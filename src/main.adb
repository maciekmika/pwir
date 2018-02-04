with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;
with Ada.Numerics.Elementary_Functions;
with ada.numerics.float_random;


procedure Main is

   Gen : ada.numerics.float_random.Generator;

   MasaAuta : Float := 900.0;
   PrzyspieszenieZiemskie : Float := 10.0;
   WspoczynnikPodloza : Float := 0.7 with Atomic;

   type DaneWspoldzielone is record
      Prefix: String(1 .. 9);
      CzyHamulecWcisniety : Boolean;
      SilaHamowania : Float;
      PredkoscAuta : Float;
      ABSwlaczony: Boolean;
   end record;

   type DaneWspoldzielone2 is record
      Prefix: String(1 .. 9);
      CzyGazWcisniety : Boolean;
      SilaGazu : Float;
      PredkoscAuta : Float;
      ASRwlaczony: Boolean;
   end record;

   type Dane_Access is access DaneWspoldzielone;
   type Dane_Access2 is access DaneWspoldzielone2;

   procedure ObliczaniePredkosci(Prefix: in String; PredkoscAuta: in out Float; SilaHamowania: in out Float) is
      EnergiaPoczatkowa : Float :=0.0;
      DrogaPrzebyta : Float;
      PredkoscInteger : Integer;
      Zmienna : Float;
   begin
      EnergiaPoczatkowa := 0.5*MasaAuta*PredkoscAuta*PredkoscAuta;
      -- obliczamy droge przebyta przez 1/10 sekundy sekunde
      DrogaPrzebyta := PredkoscAuta/10.0;
      -- obliczamy predkosc po 1/10 sekundy dzialania sily hamowania

      Zmienna :=  EnergiaPoczatkowa-SilaHamowania*DrogaPrzebyta;
      if Zmienna >= 0.0 then
         PredkoscAuta := Ada.Numerics.Elementary_Functions.Sqrt(2.0*(Zmienna)/MasaAuta); -- to powinno byc w pierwiastku
      else
         PredkoscAuta := 0.0;
      end if;

      PredkoscInteger := Integer(PredkoscAuta);
      Put_Line(Prefix & PredkoscInteger'Img);
   end ObliczaniePredkosci;


   procedure ObliczaniePredkosciGaz(Prefix: in String; PredkoscAuta: in out Float; SilaGazu: in out Float) is
      EnergiaPoczatkowa : Float :=0.0;
      DrogaPrzebyta : Float;
      PredkoscInteger : Integer;
      Zmienna : Float;
   begin
      EnergiaPoczatkowa := 0.5*MasaAuta*PredkoscAuta*PredkoscAuta;
      -- obliczamy droge przebyta przez 1/10 sekundy sekunde
      DrogaPrzebyta := PredkoscAuta/10.0;
      -- obliczamy predkosc po 1/10 sekundy dzialania sily hamowania

      Zmienna :=  EnergiaPoczatkowa+SilaGazu*DrogaPrzebyta;
      PredkoscAuta := Ada.Numerics.Elementary_Functions.Sqrt(2.0*(Zmienna)/MasaAuta); -- to powinno byc w pierwiastku


      PredkoscInteger := Integer(PredkoscAuta);
      Put_Line(Prefix & PredkoscInteger'Img);
   end ObliczaniePredkosciGaz;

   function LosoweZmianyPodloza(WspolczynnikOryginalny: in Float) return Float is
      RandomFloat: Float;
      ZmianaPodloza: Float;
   begin
      RandomFloat := Ada.Numerics.Float_Random.Random(Gen);
      RandomFloat := RandomFloat - 0.5;
      ZmianaPodloza := RandomFloat/10.0;
      --Put_Line("Zmiana podloza" & ZmianaPodloza'Img);
      return WspolczynnikOryginalny+ZmianaPodloza;
   end LosoweZmianyPodloza;

   -- zmniejsza/zwieksza sile hamowania
   -- na podstawie sygnalow z czujnika
   -- wejsciem info czy kola zablokowane
   task type SterownikABS(Dane: Dane_Access) is
   end SterownikABS;

   task type SterownikASR(Dane: Dane_Access2) is
   end SterownikASR;

   -- dostaje sygnal ze hamulec zostal nacisniety
   -- po tym sprawdza co ustalony czas czy kola sie nie zablokowaly
   -- oblicza aktualny wpsolczynnik tarcia statycznego
   -- sila hamulca przez m*g
   -- if aktualny_wsp>podloze_wsp => kola zablokowane
   -- wejsciem moze byc boolean czyHamulecNacisniety
   task type Czujnik(Dane: Dane_Access) is
   end Czujnik;

   task type CzujnikASR(Dane: Dane_Access2) is
   end CzujnikASR;

   -- po prostu hamulec
   -- na poczatku sila stala
   -- po wlaczeniu ABSu zmieniamy wedlug zalecen ABSu
   -- wejscie sila z jaka hamujemy
   -- wysyla sygnal do czujnika ze dziala
   task type Hamulec(Dane: Dane_Access) is
      entry Start;
   end Hamulec;

   task type Gaz(Dane: Dane_Access2) is
      entry Start;
   end Gaz;

   task body Hamulec is
   begin
      accept Start do
         Put_Line(Dane.Prefix & "hamulec uruchomiony");
         Dane.SilaHamowania := 8000.0; -- mozna zakomentowac i podawac na samym poczatku
         Dane.CzyHamulecWcisniety := True;
         delay 0.2;
         while Dane.PredkoscAuta > 0.0 and Dane.ABSwlaczony = False loop
            Put_Line(Dane.Prefix & "hamowanie, ABS nieaktywny");
            --obliczamy energie poczatkowa
            ObliczaniePredkosci(Dane.Prefix, Dane.PredkoscAuta, Dane.SilaHamowania);
            delay 0.1;
         end loop;
      end Start;
   end Hamulec;

   task body Gaz is
   begin
      accept Start do
         Put_Line(Dane.Prefix & "gaz uruchomiony");
         Dane.SilaGazu := 8000.0; -- mozna zakomentowac i podawac na samym poczatku
         Dane.CzyGazWcisniety := True;
         delay 0.2;
         while Dane.PredkoscAuta < 25.0 and Dane.ASRwlaczony = False loop
            Put_Line(Dane.Prefix & "przyspieszanie, ASR nieaktywny");
            --obliczamy energie poczatkowa
            ObliczaniePredkosciGaz(Dane.Prefix, Dane.PredkoscAuta, Dane.SilaGazu);
            delay 0.1;
         end loop;
      end Start;
   end Gaz;

   task body Czujnik is
      AktualnyWspolczynnik : Float := 0.0;
   begin
      Put_Line(Dane.Prefix & "czujnik zainicjalizowany");

         while Dane.CzyHamulecWcisniety = false loop
         --delay 0.1;
         null;
         end loop;

         Put_Line(Dane.Prefix & "czujnik kola aktywowany");
         while Dane.PredkoscAuta > 0.0 and Dane.ABSwlaczony = false loop
            -- co sekunde sprawdza czy kola sie nie zablokowaly
            -- sila hamowania przez m*g = aktualny_wsp
            AktualnyWspolczynnik := Dane.SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
            -- if aktualny_wsp>podloze_wsp => kola zablokowane
            if AktualnyWspolczynnik>LosoweZmianyPodloza(WspoczynnikPodloza) then
               Put_Line(Dane.Prefix & "kolo zablokowane");
               Dane.ABSwlaczony := True;
            end if;
            -- wlacz abs
         end loop;
         -- dopoki aktualny_wsp>podloze_wsp zmniejszaj sile

         Put_Line(Dane.Prefix & "czujnik kola dezaktywowany");
   end Czujnik;



   task body CzujnikASR is
      AktualnyWspolczynnik : Float := 0.0;
   begin
      Put_Line(Dane.Prefix & "czujnik ASR zainicjalizowany");

         while Dane.CzyGazWcisniety = false loop
         --delay 0.1;
         null;
         end loop;

         Put_Line(Dane.Prefix & "czujnik kola aktywowany");
         while Dane.PredkoscAuta < 25.0 and Dane.ASRwlaczony = false loop
            -- co sekunde sprawdza czy kola sie nie zablokowaly
            -- sila hamowania przez m*g = aktualny_wsp
            AktualnyWspolczynnik := Dane.SilaGazu/(PrzyspieszenieZiemskie*MasaAuta);
            -- if aktualny_wsp>podloze_wsp => kola zablokowane
            if AktualnyWspolczynnik>LosoweZmianyPodloza(WspoczynnikPodloza) then
               Put_Line(Dane.Prefix & "kolo zablokowane");
               Dane.ASRwlaczony := True;
            end if;
            -- wlacz asr
         end loop;
         -- dopoki aktualny_wsp>podloze_wsp zmniejszaj sile

         Put_Line(Dane.Prefix & "czujnik ASR kola dezaktywowany");
   end CzujnikASR;



   task body SterownikABS is
      AktualnyWspolczynnik : Float := 0.8;
   begin

      Put_Line(Dane.Prefix & "sterownik zainicjalizowany");

      while Dane.ABSwlaczony = false loop
         --delay 0.1;
                  null;
         end loop;
      Put_Line(Dane.Prefix & "ABS aktywowany");

      --dopoki predkosc nie jest zero
      while Dane.PredkoscAuta > 0.0 loop
         -- dobieramy odpowiednia sile
         Dane.SilaHamowania := Dane.SilaHamowania+200.0;
         while AktualnyWspolczynnik>WspoczynnikPodloza loop
            Dane.SilaHamowania := Dane.SilaHamowania-100.0;
            AktualnyWspolczynnik := Dane.SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
            --Put_Line("in");
         end loop;

         ObliczaniePredkosci(Dane.Prefix, Dane.PredkoscAuta, Dane.SilaHamowania);
         delay 0.1;

      end loop;
         Put_Line(Dane.Prefix &  "ABS dezaktywowany");
   end SterownikABS;


   task body SterownikASR is
      AktualnyWspolczynnik : Float := 0.8;
   begin

      Put_Line(Dane.Prefix & "sterownik ASR zainicjalizowany");

      while Dane.ASRwlaczony = false loop
         --delay 0.1;
                  null;
         end loop;
      Put_Line(Dane.Prefix & "ASR aktywowany");

      --dopoki predkosc nie jest zero
      while Dane.PredkoscAuta < 25.0 loop
         -- dobieramy odpowiednia sile
         Dane.SilaGazu := Dane.SilaGazu+200.0;
         while AktualnyWspolczynnik>WspoczynnikPodloza loop
            Dane.SilaGazu := Dane.SilaGazu-100.0;
            AktualnyWspolczynnik := Dane.SilaGazu/(PrzyspieszenieZiemskie*MasaAuta);
            --Put_Line("in");
         end loop;

         ObliczaniePredkosciGaz(Dane.Prefix, Dane.PredkoscAuta, Dane.SilaGazu);
         delay 0.1;

      end loop;
         Put_Line(Dane.Prefix &  "ASR dezaktywowany");
   end SterownikASR;


   --LP - lewy przód PP - prawy przód LT PT
   Dane_LP: Dane_Access := new DaneWspoldzielone'(ASCII.ESC & "[30m" & "LP: ",False,0.0,15.0,False);
   S_LP : SterownikABS(Dane_LP);
   Cz_LP : Czujnik(Dane_LP);
   H_LP : Hamulec(Dane_LP);

   Dane_PP: Dane_Access := new DaneWspoldzielone'(ASCII.ESC & "[31m" & "PP: ",False,0.0,25.0,False);
   S_PP : SterownikABS(Dane_PP);
   Cz_PP : Czujnik(Dane_PP);
   H_PP : Hamulec(Dane_PP);

   Dane_LT: Dane_Access := new DaneWspoldzielone'(ASCII.ESC & "[32m" & "LT: ",False,0.0,35.0,False);
   S_LT : SterownikABS(Dane_LT);
   Cz_LT : Czujnik(Dane_LT);
   H_LT : Hamulec(Dane_LT);

   Dane_PT: Dane_Access := new DaneWspoldzielone'(ASCII.ESC & "[34m" & "PT: ",False,0.0,45.0,False);
   S_PT : SterownikABS(Dane_PT);
   Cz_PT : Czujnik(Dane_PT);
   H_PT : Hamulec(Dane_PT);


   Dane_LP2: Dane_Access2 := new DaneWspoldzielone2'(ASCII.ESC & "[30m" & "LP: ",False,0.0,0.1,False);
   S_LP2 : SterownikASR(Dane_LP2);
   Cz_LP2 : CzujnikASR(Dane_LP2);
   H_LP2 : Gaz(Dane_LP2);

   Dane_PP2: Dane_Access2 := new DaneWspoldzielone2'(ASCII.ESC & "[31m" & "PP: ",False,0.0,0.1,False);
   S_PP2 : SterownikASR(Dane_PP2);
   Cz_PP2 : CzujnikASR(Dane_PP2);
   H_PP2 : Gaz(Dane_PP2);

   Dane_LT2: Dane_Access2 := new DaneWspoldzielone2'(ASCII.ESC & "[32m" & "LT: ",False,0.0,0.1,False);
   S_LT2 : SterownikASR(Dane_LT2);
   Cz_LT2 : CzujnikASR(Dane_LT2);
   H_LT2 : Gaz(Dane_LT2);

   Dane_PT2: Dane_Access2 := new DaneWspoldzielone2'(ASCII.ESC & "[34m" & "PT: ",False,0.0,0.1,False);
   S_PT2 : SterownikASR(Dane_PT2);
   Cz_PT2 : CzujnikASR(Dane_PT2);
   H_PT2 : Gaz(Dane_PT2);

begin
   Put_Line("START#############################");
   delay 3.0;
   --H_LP.Start;
   --H_PP.Start;
   --H_LT--.Start;
   --H_PT.Start;

   H_LP2.Start;
   H_PP2.Start;
   H_LT2.Start;
   H_PT2.Start;
   --powrót do czarnego koloru terminala
   Put_Line(ASCII.ESC & "[30m");
end Main;
