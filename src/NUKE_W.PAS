{WARNING*************************************************************
This will NUKE WEAPON.REC!!                                         }

program Make_New_W;

{$I TypeHead.Pas}  {Type Defs}

var f:file of Weapon;
    l:word;
    sw:Weapon;

{$I DelPc.Pas}     {contains nuker}

begin
     assign(f,'Weapon.Rec');
     rewrite(f);

     DelW(sw);

     for l:=1 to maxW do
         write(f,sw);

     close(f);

end .
