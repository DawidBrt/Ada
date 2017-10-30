with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO;

procedure Lab4Tree is

type BinTree is
  record
    Data : integer := 0;
    Left : access BinTree := Null;
    Right : access BinTree := Null;
  end record;
  
type Tree_Ptr is access all BinTree;

procedure Print(Tree : access BinTree) is
  T : access BinTree := Tree;
begin
  if Tree = Null then
    Put_Line("Leaf");
  else
    Put(T.Data, 4);
    New_Line;
    Print(T.Left);
    Print(T.Right);
  end if;
end Print;

procedure Insert(Tree : in out Tree_Ptr; D : in Integer) is
  T : Tree_Ptr := new BinTree;
begin
  T.Data := D;
  T.Left := Null;
  T.Right := Null;
  if(Tree = Null) then
    Tree := T;
  elsif (D>Tree.Data) then
    Insert(Tree.Right, D);
  else
    Insert(Tree.Left, D);
  end if;
end Insert;

procedure Search(Tree : in out Tree_Ptr; D : in Integer) is
begin
  if(Tree = Null) then
    Put_line("False");
  elsif (Tree.Data = D) then
    Put_line("True");
  elsif (D>Tree.Data) then
    Search(Tree.Right, D);
  else
    Search(Tree.Left, D);
  end if;
end Search;



Drzewo : Tree_Ptr := Null;
  
begin
  Print(drzewo);
  New_Line;
  Insert(drzewo, 5);
  Insert(drzewo, 2);
  Insert(drzewo, 3);
  Insert(drzewo, 10);
  Print(drzewo);
  
  search(drzewo, 14);
  search(drzewo, 10);
  
end Lab4Tree;
