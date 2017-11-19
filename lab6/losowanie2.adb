with Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure losowanie2 is

------------ random float 0.0 to 5.0
task type r_float is
	entry Losuj(N: out Float);
end r_float;

type wsk_float is access r_float;

task body r_float is
use Ada.Numerics.Float_Random;
Gen : Generator;
begin
	Reset(Gen);
	accept Losuj(N: out float) do
	N := 5.0 * Random(Gen);
	end Losuj;
end r_float;

------------ random color
type Colors is (Red, Blue, Yellow, Green, Brown, Grey, Black, White, Purple);

task type r_color is
	entry Losuj(C: out Colors);
end r_color;

type wsk_color is access r_color;

task body r_color is
package Los_Color is new Ada.Numerics.Discrete_Random(Colors);
use Los_Color;
Gen : Generator;
begin
	Reset(Gen);
	accept Losuj(C: out Colors) do
	C := Random(Gen);
	end Losuj;
end r_color;

------------ random days
type Days is (Mon, Tue, Wed, Thu, Sat, Sun);

task type r_day is
	entry Losuj(D: out Days);
end r_day;

type wsk_day is access r_day;

task body r_day is
package Los_Day is new Ada.Numerics.Discrete_Random(Days);
use Los_Day;
Gen : Generator;
begin
	Reset(Gen);
	accept Losuj(D: out Days) do
	D := Random(Gen);
	end Losuj;
end r_day;

----------- random integer 1 to 49
task type r_int is
	entry Losuj(Int: out Integer);
end r_int;

type wsk_int is access r_int;

task body r_int is
use Ada.Numerics.Float_Random;
Gen : Generator;
begin
	Reset(Gen);
	accept Losuj(Int: out Integer) do
	Int := Integer(49.0 * Random(Gen)) mod 49;
	end Losuj;
end r_int;

----------- task with tasks
task type zadanie is
	entry Start;
	entry Koniec;
end zadanie;

type wsk_z is access zadanie;

type table is array (Integer range <>) of Integer;

task body zadanie is
	N: Float;
	C: Colors;
	D: Days;
	A: table(1..6);
	Flo : wsk_float;
	Col : wsk_color;
	DayZ: wsk_day;
	Arr : wsk_int;
begin
	accept start;
	loop
		select
			accept Koniec;
			put_line("Koniec procesu");
			exit;
		else
			Flo := new r_float;
			Col := new r_color;
			DayZ:= new r_day;
			Flo.Losuj(N);
			Col.Losuj(C);
			DayZ.Losuj(D);
			for I in A'Range loop
				Arr := new r_int;
				Arr.Losuj(A(I));
			end loop;
			put_line("Float: " & N'Img & "; Color: " & C'Img & "; Day: " & D'Img);
			put("Array:");
			for I in A'Range loop
			  put(" " & A(I)'Img);
			end loop;
			put_line("");
			delay 0.2;
		end select;
	end loop;
end zadanie;

----------- main
wz1 : wsk_z;
wz2 : wsk_z;

begin
	Put_line("Poczatek:");
	wz1 := new zadanie;
	wz1.start;
	delay 0.3;
	Put_line("Kolejny proces sie zaczyna!");
	wz2 := new zadanie;
	wz2.start;
	delay 1.0;
	wz2.koniec;
	delay 1.0;
	wz1.koniec;
end losowanie2;
	
