with Ada.Text_IO;
use Ada.Text_IO;

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
   -- po prostu hamulec
   -- na poczatku sila stala
   -- po wlaczeniu ABSu zmieniamy wedlug zalecen ABSu
   -- wejscie sila z jaka hamujemy
   -- wysyla sygnal do czujnika ze dziala
   task type Hamulec is
      entry Start;
      entry Koniec;
   end Hamulec;

   -- na poczatku wspolczynnik staly
   -- potem randomo bedziemy zmieniac w tasku
   task type Podloze is
   end Podloze;

   -- dostaje sygnal ze hamulec zostal nacisniety
   -- po tym sprawdza co ustalony czas czy kola sie nie zablokowaly
   -- oblicza aktualny wpsolczynnik tarcia statycznego
   -- sila hamulca przez m*g
   -- if aktualny_wsp>podloze_wsp => kola zablokowane
   -- wejsciem moze byc boolean czyHamulecNacisniety
   task type Czujnik is
   end Czujnik;

   -- zmniejsza/zwieksza sile hamowania
   -- na podstawie sygnalow z czujnika
   -- wejsciem info czy kola zablokowane
   task type SterownikABS is
   end SterownikABS;

   task body Hamulec is
      SilaHamowania : Float := 5625;
   begin
      accept Start do
         Put_Line("Hamulec nacisniety");
         Semafor1.Sygnalizuj;
      end Start;
        delay 3.0;
      accept Koniec  do

         Put_Line("Koniec hamowania");
      end Koniec;
   end Hamulec;

   H : Hamulec;

   task body Podloze is
   begin
      null;
   end Podloze;

   task body Czujnik is
   begin
         Semafor1.Czekaj; -- czujnik czeka na wcisniecie hamulca

         Put_Line("Czujnik zaczyna dzialac");
         -- co sekunde sprawdza czy kola sie nie zablokowaly
         -- sila hamowania przez m*g
         -- if aktualny_wsp>podloze_wsp => kola zablokowane


      -- dopoki aktualny_wsp>podloze_wsp zmniejszaj sile






         Put_Line("Czujnik przestaje dzialac");

   end Czujnik;

   task body SterownikABS is
   begin
            null;
   end SterownikABS;



   Cz : Czujnik;
begin
   H.Start;
   H.Koniec;
end Main;
