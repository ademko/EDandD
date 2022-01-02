uses Utils;

{$I TypeHead.Pas}

const userrec='Monster.Rec';{to trick PCUTILS}

{$I PC_Utils.Pas}

var p:pc;
    ft:text;
    n:word;
    s:string;

begin
     writeln('Turns MONSTER.REC --> MONSTER.LST');
     writeln;
     writeln('Making header...');

     assign(ft,'Monster.Lst');
     rewrite(ft);

     writeln(ft,'This file lists all the monster and their icons.');
     writeln(ft,'ICONTEMP.ANS is not a real icon, it''s just a filler');
     writeln(ft,'or temp. You should uses ICONTEMP.ANS as a guide when');
     writeln(ft,'making icons...');
     writeln(ft,'');
     writeln(ft,'A "-" means that the monster does not have an icon.');
     writeln(ft,'');

     write('Working: ');
     write('':4);
     for n:=1 to maxmon do
         begin
         write(#8+#8+#8+#8,n:4);
         GetPC(p,n);
         If p.charname<>''
            then begin
            s:=ups(p.icon);
            s:=s+'.ANS';
            if s='ICONTEMP.ANS'
               then s:='-';
            writeln(ft,n:4,p.charname:30,s:20);
            end;
         end;

     writeln;
     writeln;

     close(ft);
end .

     for n:=