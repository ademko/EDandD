{WARNING*************************************************************
This will NUKE ARMOR .REC!!                                         }

program Make_New_A;

{$I TypeHead.Pas}  {Type Defs}

var f:file of Armor;
    l:word;
    sa:armor;

{$I DelPc.Pas}     {contains nuker}

begin
     assign(f,'Armor.Rec');
     rewrite(f);

     DelA(sa);

     for l:=1 to maxA do
         write(f,sA);

     close(f);

end .
