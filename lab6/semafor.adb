with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;

procedure semafor is


-----------------------------------------------------------

protected type TypeSemaphore(Max: Natural; Initial: Natural) is 
  entry Wait;
  entry Signal;
  private
    Count: Natural := Initial;
    MaxCount : Natural := Max;
end TypeSemaphore;

protected body TypeSemaphore is
  entry Wait when Count > 0 is
    begin
      Count := Count - 1;
    end Wait;
    
  entry Signal when Count < MaxCount is
    begin
      Count := Count + 1;
    end Signal;
end TypeSemaphore;

----------------------------------------------------------

X : Integer;
N : Constant Integer := 20;
S : TypeSemaphore(1,1);

task Producer;
task Consumer;

task body Producer is
begin
  for I in 1..N loop
    S.Wait;
    X := I;
    S.Signal;
    Put_Line(Integer'Image(X));
    delay 0.5;
 end loop;
end;

-------------------------------
task body Consumer is
begin
  delay 0.1;
  for I in 1..N loop
    S.Wait;
    Put_Line(Integer'Image(X));
    S.Signal;
    delay 0.5;
 end loop;
end;
-------------------------------

begin
 null;
end semafor;






