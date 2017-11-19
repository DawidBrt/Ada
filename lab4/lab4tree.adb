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

function Search(Tree : in out Tree_Ptr; D : in Integer) return boolean is
  tmp : boolean := false;
begin
  if(Tree = Null) then
    return false;
  elsif (Tree.Data = D) then
    return true;
  elsif (D>Tree.Data) then
    tmp := Search(Tree.Right, D);
    if(tmp = true) then
      return true;
    end if;
  else
    tmp := Search(Tree.Left, D);
  end if;
  return tmp;
end Search;

procedure Delete(Tree : in out Tree_Ptr; D : in Integer) is
  tmp : Tree_Ptr := Null;
  procedure Delete_Inn(Tree: in out Tree_Ptr; Parent: in out Tree_Ptr; D : in Integer) is
    function Minimum(Tree : in out Tree_Ptr) return Integer is
    tmp : integer;
    begin
      if Tree.Left.Left /= Null  then
        return Minimum(Tree.left);
      elsif Tree.left.left = Null then
        tmp := Tree.left.data;
        if tree.left.right /= null then
          tree.left := tree.left.right;
        else
          tree.left := null;
        end if;
        return tmp;
      end if;
    return -999999;
    end minimum;
    
  begin
    if Tree /= Null then
			if D = Tree.Data then
				if Parent = Null then
					if Tree.Right = Null then
						Tree := Tree.Left;
					else
						if Tree.Right.Left = Null and Tree.Right.Right = Null then
							Tree.Data := Tree.Right.Data;
							Tree.Right := Null;
						elsif Tree.Right.Left = Null and Tree.Right.Right /= Null then
							Tree.Data := Tree.Right.Data;
							Tree.Right := Tree.Right.Right;
						else
							Tree.Data := Minimum(Tree.Right);
						end if;
					end if;
				elsif Tree.Left = Null and Tree.Right = Null then 
					if D < Parent.Data then 
						Parent.Left := Null;
					else
						Parent.Right := Null;
					end if;
				elsif Tree.Left = Null and Tree.Right /= Null then
					Tree := Tree.Right;
				elsif Tree.Right = Null and Tree.Left /= Null then
					Tree := Tree.Left;
				elsif Tree.Right /= Null and Tree.Left /= Null then
					if Tree.Right.Left = Null and Tree.Right.Right = Null then
						Tree.Data := Tree.Right.Data;
						Tree.Right := Null;
					elsif Tree.Right.Left = Null and Tree.Right.Right /= Null then
						Tree.Data := Tree.Right.Data;
						Tree.Right := Tree.Right.Right;
					else
						Tree.Data := Minimum(Tree.Right);
					end if;
				end if;
			elsif D <  Tree.Data then
				Delete_Inn(Tree.Left,Tree, D);
			else
				Delete_Inn(Tree.Right,Tree, D);
			end if;
		end if;
	end Delete_Inn;
  
  StartRoot: Tree_Ptr := Null;
begin
	Delete_Inn(Tree,StartRoot, D);
end Delete; 



Drzewo : Tree_Ptr := Null;
  
begin
  Print(drzewo);
  New_Line;
  Insert(drzewo, 5);
  Insert(drzewo, 2);
  Insert(drzewo, 3);
  Insert(drzewo, 10);
  Print(drzewo);
  
  put_line(search(drzewo, 14)'img);
  put_line(search(drzewo, 10)'img);
  
  put_line("");
  delete(drzewo, 10);
  print(drzewo);
  delete(drzewo, 3);
  put_line("");
  print(drzewo);
  
end Lab4Tree;
