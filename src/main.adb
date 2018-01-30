with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Calendar;  use Ada.Calendar;
with Ada.Numerics.Elementary_Functions;



procedure Main is

   -- typ chroniony
protected type Semafor_Bin(Init_Sem: Boolean := True) is
  entry Czekaj;
  procedure Sygnalizuj;
  private
   S : Boolean := Init_Sem;
end Semafor_Bin ;

protected body Semafor_Bin  is
  entry Czekaj when S is
  begin
    S := False;
  end Czekaj;
  procedure Sygnalizuj  is
  begin
    S := True;
  end Sygnalizuj;
end Semafor_Bin ;

Semafor1: Semafor_Bin(False);

   CzyHamulecWcisniety: Boolean := False with Atomic;
   SilaHamowania : Float := 0.0 with Atomic;
   PredkoscAuta : Float := 25.0 with Atomic; -- w metrach na sekunde
   MasaAuta : Float := 900.0;
   PrzyspieszenieZiemskie : Float := 10.0;
   WspoczynnikPodloza : Float := 0.7;



   -- zmniejsza/zwieksza sile hamowania
   -- na podstawie sygnalow z czujnika
   -- wejsciem info czy kola zablokowane
   task type SterownikABS is
      entry Start;
   end SterownikABS;

   -- dostaje sygnal ze hamulec zostal nacisniety
   -- po tym sprawdza co ustalony czas czy kola sie nie zablokowaly
   -- oblicza aktualny wpsolczynnik tarcia statycznego
   -- sila hamulca przez m*g
   -- if aktualny_wsp>podloze_wsp => kola zablokowane
   -- wejsciem moze byc boolean czyHamulecNacisniety
   task type Czujnik is
      entry StartCzujnika (ABSster : in SterownikABS);
   end Czujnik;

   -- po prostu hamulec
   -- na poczatku sila stala
   -- po wlaczeniu ABSu zmieniamy wedlug zalecen ABSu
   -- wejscie sila z jaka hamujemy
   -- wysyla sygnal do czujnika ze dziala
   task type Hamulec is
      entry Start (ABSo : in SterownikABS; Czujniko : in Czujnik);
      entry Koniec;
   end Hamulec;

   -- na poczatku wspolczynnik staly
   -- potem randomo bedziemy zmieniac w tasku
   task type Podloze is
   end Podloze;





   task body Hamulec is

   begin
      accept Start (ABSo : in SterownikABS; Czujniko : in Czujnik) do
         Put_Line("Hamulec nacisniety");
         SilaHamowania := 6625.0;
         Czujniko.StartCzujnika(ABSo);
      end Start;

      accept Koniec  do

         Put_Line("Koniec hamowania");
      end Koniec;
   end Hamulec;



   task body Podloze is
   begin
      null;
   end Podloze;

   task body Czujnik is
      AktualnyWspolczynnik : Float := 0.0;
   begin

      accept StartCzujnika (ABSster : in SterownikABS) do


         Put_Line("Czujnik zaczyna dzialac");
         -- co sekunde sprawdza czy kola sie nie zablokowaly
         -- sila hamowania przez m*g = aktualny_wsp
         AktualnyWspolczynnik := SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
         -- if aktualny_wsp>podloze_wsp => kola zablokowane
         if AktualnyWspolczynnik>WspoczynnikPodloza then
            Put_Line("Kola zablokowane");
            ABSster.Start;
         end if;
         -- wlacz abs

         -- dopoki aktualny_wsp>podloze_wsp zmniejszaj sile

         Put_Line("Czujnik przestaje dzialac");
      end StartCzujnika;


   end Czujnik;

   task body SterownikABS is
      EnergiaPoczatkowa : Float :=0.0;
      AktualnyWspolczynnik : Float := 0.8;
      DrogaPrzebyta : Float;
      PredkoscInteger : Integer;
   begin
      accept Start;
      Put_Line("Wlaczony ABS");

      --dopoki predkosc nie jest zero
      while PredkoscAuta > 3.0 loop
         -- dobieramy odpowiednia sile
         while AktualnyWspolczynnik>WspoczynnikPodloza loop
            SilaHamowania := SilaHamowania-1000.0;
            AktualnyWspolczynnik := SilaHamowania/(PrzyspieszenieZiemskie*MasaAuta);
            Put_Line("in");
         end loop;

         --obliczamy energie poczatkowa
         EnergiaPoczatkowa := 0.5*MasaAuta*PredkoscAuta*PredkoscAuta;
         -- obliczamy droge przebyta przez 1 sekunde
         DrogaPrzebyta := PredkoscAuta;
         -- obliczamy predkosc po jednej sekundzie dzialania sily hamowania
         --
         PredkoscAuta := Ada.Numerics.Elementary_Functions.Sqrt(2.0*(EnergiaPoczatkowa-SilaHamowania*DrogaPrzebyta)/MasaAuta); -- to powinno byc w pierwiastku
         PredkoscInteger := Integer(PredkoscAuta);
         Put_Line(PredkoscInteger'Img);
         --delay 1.0;

      end loop;
   Put_Line("koniec ABSu");
   end SterownikABS;


   H : Hamulec;
   Cz : Czujnik;
   S : SterownikABS;
begin
   H.Start(S,Cz);
  --         delay 5.0;
  -- H.Koniec;
end Main;
