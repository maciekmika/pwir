with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;
with Ada.Numerics.Elementary_Functions;
with ada.numerics.float_random;


procedure Main is

   CzyHamulecWcisniety: Boolean := False with Atomic;
   SilaHamowania : Float := 0.0 with Atomic;
   PredkoscAuta : Float := 25.0 with Atomic; -- w metrach na sekunde
   MasaAuta : Float := 900.0;
   PrzyspieszenieZiemskie : Float := 10.0;
   WspoczynnikPodloza : Float := 0.7 with Atomic;
   WspoczynnikPodlozaPodstawa : Float := 0.7 with Atomic;

   ABSwlaczony : Boolean := False with Atomic;



   record BoxWithGlobals is record
      CzyHamulecWcisniety: Boolean := False with Atomic;
      SilaHamowania : Float := 0.0 with Atomic;
      PredkoscAuta : Float := 25.0 with Atomic; -- w metrach na sekunde
      MasaAuta : Float := 900.0;
      PrzyspieszenieZiemskie : Float := 10.0;
      WspoczynnikPodloza : Float := 0.7 with Atomic;
      WspoczynnikPodlozaPodstawa : Float := 0.7 with Atomic;

      ABSwlaczony : Boolean := False with Atomic;
   end record;

   -- zmniejsza/zwieksza sile hamowania
   -- na podstawie sygnalow z czujnika
   -- wejsciem info czy kola zablokowane
   task type SterownikABS is
      entry Start (BoxInit : BoxWithGlobals);
   end SterownikABS;

   -- dostaje sygnal ze hamulec zostal nacisniety
   -- po tym sprawdza co ustalony czas czy kola sie nie zablokowaly
   -- oblicza aktualny wpsolczynnik tarcia statycznego
   -- sila hamulca przez m*g
   -- if aktualny_wsp>podloze_wsp => kola zablokowane
   -- wejsciem moze byc boolean czyHamulecNacisniety
   task type Czujnik is
     entry Start (BoxInit : BoxWithGlobals);
   end Czujnik;

   -- po prostu hamulec
   -- na poczatku sila stala
   -- po wlaczeniu ABSu zmieniamy wedlug zalecen ABSu
   -- wejscie sila z jaka hamujemy
   -- wysyla sygnal do czujnika ze dziala
   task type Hamulec is
      entry StartHamowania;
      entry Start (BoxInit : BoxWithGlobals);
   end Hamulec;

   -- na poczatku wspolczynnik staly
   -- potem randomo bedziemy zmieniac w tasku
   task type Podloze  is
      entry Start (BoxInit : BoxWithGlobals);
   end Podloze;


   procedure ObliczaniePredkosci (Box : in BoxWithGlobals) is
      EnergiaPoczatkowa : Float :=0.0;
      DrogaPrzebyta : Float;
      PredkoscInteger : Integer;
      Zmienna : Float;
   begin
      EnergiaPoczatkowa := 0.5*Box.MasaAuta*Box.PredkoscAuta*Box.PredkoscAuta;
            -- obliczamy droge przebyta przez 1 sekunde
            DrogaPrzebyta := Box.PredkoscAuta/10.0;
            -- obliczamy predkosc po jednej sekundzie dzialania sily hamowania
            --
            Zmienna :=  EnergiaPoczatkowa-Box.SilaHamowania*DrogaPrzebyta;
            if Zmienna >= 0.0 then
               PredkoscAuta := Ada.Numerics.Elementary_Functions.Sqrt(2.0*(Zmienna)/MasaAuta); -- to powinno byc w pierwiastku
            else
               PredkoscAuta := 0.0;
            end if;

            PredkoscInteger := Integer(PredkoscAuta);
            Put_Line(PredkoscInteger'Img);
   end ObliczaniePredkosci;



   task body Hamulec is

   Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;

      accept StartHamowania do
         Put_Line("Hamulec nacisniety");
         SilaHamowania := 5825.0;
         CzyHamulecWcisniety := True;
         delay 0.2;
         while PredkoscAuta > 0.0 and ABSwlaczony = False loop
            Put_Line("hamulec bez absu");
            --obliczamy energie poczatkowa
            ObliczaniePredkosci(Box);
            delay 0.1;
         end loop;

      end StartHamowania;

   end Hamulec;



   task body Podloze is
      g : ada.numerics.float_random.Generator;
      ZmianaPodloza : Float;
      RandomFloat: Float;
   Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;
      while PredkoscAuta > 0.0 loop
         RandomFloat := ada.numerics.float_random.Random(g);
         ZmianaPodloza := RandomFloat/10.0;

         --Put_Line("Zmiana podloza" & ZmianaPodloza'Img);
         if RandomFloat > 0.5 then
            WspoczynnikPodloza := WspoczynnikPodlozaPodstawa-ZmianaPodloza;
         else
            WspoczynnikPodloza := WspoczynnikPodlozaPodstawa+ZmianaPodloza;
         end if;

         delay 0.1;
      end loop;
   end Podloze;

   task body Czujnik is
      AktualnyWspolczynnik : Float := 0.0;
      Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;

         while CzyHamulecWcisniety = false loop
         --delay 0.1;
         null;
         end loop;

         Put_Line("Czujnik zaczyna dzialac");
         while PredkoscAuta > 0.0 and ABSwlaczony = false loop
            -- co sekunde sprawdza czy kola sie nie zablokowaly
            -- sila hamowania przez m*g = aktualny_wsp
            AktualnyWspolczynnik := SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
            -- if aktualny_wsp>podloze_wsp => kola zablokowane
            if AktualnyWspolczynnik>WspoczynnikPodloza then
               Put_Line("Kola zablokowane");
               ABSwlaczony := True;
            end if;
            -- wlacz abs
         end loop;
         -- dopoki aktualny_wsp>podloze_wsp zmniejszaj sile

         Put_Line("Czujnik przestaje dzialac");


   end Czujnik;

   task body SterownikABS is
      AktualnyWspolczynnik : Float := 0.8;
   Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;
      while ABSwlaczony = false loop
         --delay 0.1;
                  null;
         end loop;
      Put_Line("Wlaczony ABS");

      --dopoki predkosc nie jest zero
      while PredkoscAuta > 0.0 loop
         -- dobieramy odpowiednia sile
         SilaHamowania := SilaHamowania+200.0;
         while AktualnyWspolczynnik>WspoczynnikPodloza loop
            SilaHamowania := SilaHamowania-100.0;
            AktualnyWspolczynnik := SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
            --Put_Line("in");
         end loop;

         ObliczaniePredkosci(Box);
         delay 0.1;

      end loop;
      Put_Line("koniec ABSu");
   end SterownikABS;


   task type Proba is
      entry Start (BoxInit : BoxWithGlobals);
   end Proba;

   task type Proba2 is
      entry Start (BoxInit : BoxWithGlobals);
   end Proba2;

   task body Proba is
      Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;
      Box.SilaHamowania := 1.0;
   end Proba;

   task body Proba2 is
      Box : BoxWithGlobals;
   begin
      accept Start (BoxInit : BoxWithGlobals) do
         Box := BoxInit;
      end Start;
      delay 3.0;
      Put_Line(SilaHamowania'Img);
   end Proba2;

   H : Hamulec;

   S : SterownikABS;
   P : Podloze;
   B1 : BoxWithGlobals;
   Cz : Czujnik;

   P1 : Proba;
   P2 : Proba2;
begin
   --Cz--.Start(B1);
   --P--.Start(B1);
   --S.Start(B1);
   --H.Start(B1);
   P1.Start(B1);
   P2.Start(B1);
   --H.StartHamowania;
end Main;

