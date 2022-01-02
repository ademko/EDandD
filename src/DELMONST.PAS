program makemonsterdat;


{$I TypeHead.Pas}
{$I DelPC.Pas}

var CurPC:PC;
    f:file of PC;
    loop:Word;

begin
     DelPC(0, CurPC);

     Assign(f, 'Monster.Rec');
     ReWrite(f);

     For loop:=1 to maxmon do
         begin
         CurPC.UserID:=loop;
         CurPC.Icon:='Icon1';
         write(f, CurPC);
         end;

     close(F);
end .
