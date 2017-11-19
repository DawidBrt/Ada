with Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

procedure lab3 is
	type Wektor is array (Integer range <>) of float;
	W1 : Wektor(1..20);
	
	T1, T2: Time;
	D: Duration;
	P1 : File_Type;
	Nazwa: String := "test.txt";

procedure show(W:Wektor) is
begin
	for I in W'Range loop
    	Put("Tab("& I'Img &" )=");
		Put( W(I),3,4,0 );
		New_Line;
	end loop;
end show;

procedure Wrandom(W: out Wektor) is

	Gen: Generator;
begin
	Reset(Gen);
	for I OF W loop
		I := 100.0 * Random(Gen);
	end loop;
end Wrandom;

procedure checkSort(W:Wektor) is
	b: boolean;
begin
	b:= (for all I in W'First..(W'Last-1) => W(I) <= W(I+1));
	put_line(b'img);
end checkSort;

procedure swap(a, b : in out float) is
	tmp : constant float := a;
begin
	a:=b;
	b:=tmp;
end swap;

procedure bubbleSort(W: in out Wektor) is	
	n : integer := 20;
	i : integer := 0;
	tmp : float := 0.0;
begin
	for I in reverse W'Range loop
  	for J in W'First .. I loop
  		if W(I) < W(J) then
  			swap(W(J),W(I));
      end if;
  	end loop;
  end loop;
end bubbleSort;

procedure toFile(plik : File_type; W:Wektor) is
begin
	for I in W'Range loop
		Put(plik,"Tab("& I'Img &" )=");
		Put(plik, W(I),3,4,0 );
		put_line(p1,"");
	end loop;
end toFile;


begin
	T1 := Clock;
	
	--W1 := (others => 0.0);
	Wrandom(W1);
	show(W1);
	checkSort(W1);
	bubbleSort(W1);
	show(w1);
	checkSort(W1);
	
	create(p1, out_file, Nazwa);
	tofile(p1,w1);
	close(p1);
	
	T2 := Clock;
	D := T2 - T1;
  Put_Line("Czas obliczen = " & D'Img & "[s]");
	
end lab3;
	
