with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Lista is

type Element is
  record
    Data : Integer := 0;
    Next : access Element := Null;
  end record;

type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
begin
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:");
  end if;
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop;
end Print;

procedure Insert(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element;
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List);
  List := E;
end Insert;

-- wstawianie jako funkcja - wersja krótka
function Insert(List : access Element; D : in Integer) return access Element is
  ( new Element'(D,List) );

-- do napisania !!
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
  E : Elem_Ptr := new Element;
  previous : Elem_Ptr := new Element;
  tmp : Elem_Ptr := new Element;
  begin
    E.Data := D;
    E.Next := Null;
    if(List = Null) then
      List := E;
    elsif (D < List.Data) then
      E.next := List;
      List:= E;
    else
      previous := List;
      tmp := List.Next;
      while(tmp /= Null and then D > tmp.Data) loop
        previous := tmp;
        tmp := tmp.Next;
      end loop;
      if(tmp = Null) then
        previous.Next := E;
      else
        E.Next := tmp;
        previous.Next := E;
      end if;
    end if;
end Insert_Sort;

procedure AddRandom(List : in out Elem_Ptr; N : in Integer) is
  subtype Rand_range is Integer range 1..21;
  package Rand_Int is new Ada.Numerics.discrete_Random(Rand_Range);
  G : Rand_Int.Generator;
  Num : Rand_range;
begin
  for I in 1..N loop
   Rand_Int.Reset(G);
   Num := Rand_Int.Random(G);
   Insert_sort(List, Num);
  end loop;
end AddRandom;


function search(List : in out Elem_Ptr; D : in Integer) return Boolean is
  L : access Element := List;
begin
  L := List;
  while L /= Null loop
    if L.Data = D then
      return TRUE;
    end if;
    L := L.Next;
  end loop;
  return FALSE;
end search;

procedure Remove(List : in out Elem_Ptr; D : in Integer) is
  E : Elem_Ptr := new Element;
  previous : Elem_ptr := new Element;
  begin
    previous := List;
    while(previous.Data = D) loop
      previous := previous.Next;
      List := previous;
    end loop;
    while( previous /= null ) loop
      E := previous.next;
      while (E /= NULL and then D = E.Data) loop
        E := E.Next;
        previous.next := E;
      end loop;
      previous := previous.next;
    end loop;
end Remove;
  

Lista : Elem_Ptr := Null;

begin
  Print(Lista);
  Lista := Insert(Lista, 21);
  Print(Lista);
  Insert(Lista, 20);
  Print(Lista);
  for I in reverse 1..12 loop
  Insert(Lista, I);
  end loop;
  Insert_Sort(Lista, 5);
  Print(Lista);
  AddRandom(Lista, 3);
  Print(Lista);
  
  Put_line(search(Lista,1)'Img);
  Put_line(search(Lista,24)'Img);
  
  remove(Lista, 1);
  remove(Lista, 5);
  remove(Lista, 14);
  Print(Lista);
end Lab4Lista;
