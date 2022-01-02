program ResetGame;
Uses SPX_Fnc, Utils;

{$I TypeHead.Pas}
{$I DelPC.Pas}
{$I DeadIni.Dat}

var CurPC:PC;
    f:file of PC;
    fi:file of patron;
    pa:patron;
    loop:Word;
    fc:file of char;

begin
     writeln('ED&D Reset Util');
     writeln('===============');

     {clean UserRec}
     writeln('Reseting user database,');
     DelPC(0, CurPC);
     Assign(f, 'User.Rec');
     ReWrite(f);
     For loop:=1 to MaxPC do
         begin
         if exist('Mail.'+Num2str(loop))
            then DelFile('Mail.'+Num2str(loop));
         CurPC.UserID:=loop;
         write(f, CurPC);
         end;
     close(F);

     {clear bulletins}
     writeln('Deleting bulletins,');
     If exist('Bulletin.Old')
        then Delfile('Bulletin.Old');
     If exist('Bulletin.Ans')
        then Delfile('Bulletin.Ans');

     {INI Setup}
     writeln('Reseting ED&D.Ini,');
     Assign(fc,'ED&D.Ini');
     rewrite(fc);
     For loop:=1 to SizeOf(DeadIni) do
         write(fc,DeadIni[loop]);
     close(fc);

     writeln('Clearing Inn conversation,');
     assign(fi,'Inn.Rec');
     rewrite(fi);
     pa.who:='Bartender welcomes all;';
     pa.what:='Welcome all adventurers to my humble establishment!';
     write(fi,pa);
     pa.who:='';
     pa.what:='';
     loop:=1;
     repeat
           Inc(loop);
           write(fi,pa);
           until loop=maxpate;
     close(fi);

     writeln('Done!');
end .
