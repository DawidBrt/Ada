with Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random;
use Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random;

procedure losowanie is

task type zadanie is
	entry Start;
	entry Koniec;
end zadanie;

type wsk_z is access zadanie;

task type zadanie_losowania is
	entry Losuj(N: out Float; Gen:Generator);
	entry koniec;
end zadanie_losowania;
type wsk_los is access zadanie_losowania;

task body zadanie_losowania is
begin
	loop
		select
			accept Losuj(N: out float; Gen: Generator) do
			N := 5.0 * Random(Gen);
			end Losuj;
		or
			accept koniec;
			exit;
		end select;
	end loop;
end zadanie_losowania;

task body zadanie is
	Gen: Generator;
	N: Float := 0.0;
	Los : wsk_los;
begin
	Los := new zadanie_losowania;
	Reset(Gen);
	accept start;
	loop
		select
			accept Koniec;
			los.koniec;
			put_line("koniec");
			exit;
		else
			los.losuj(N, Gen);
			put_line("Random: " & N'Img);
			delay 0.2;
		end select;
	end loop;
end zadanie;


wz1 : wsk_z;
wz2 : wsk_z;

begin
	Put_line("Poczatek:");
	wz1 := new zadanie;
	wz1.start;
	delay 0.3;
	Put_line("kolejny");
	wz2 := new zadanie;
	wz2.start;
	delay 1.0;
	wz2.koniec;
	delay 1.0;
	wz1.koniec;
end losowanie;
	
