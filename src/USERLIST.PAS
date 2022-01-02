program userlister;
uses utils, crt;

{$I TypeHead.Pas}
const
      sclass:array [0..3] of string[8] ={consts for class & race strings}
                   ('Fighter',
                   'Wizard',
                   'Priest',
                   'Thief');
      srace:array [0..4] of string[10]=
                  ('Human',
                  'Elf',
                  'Dwarf',
                  'Halfling',
                  'Lizard Man');

var lp, n:word;
    f:file of PC;
    p:PC;

begin
     assign(f,'User.Rec');
     reset(f);
     n:=1;
     for lp:=1 to maxpc do
         begin
         read(f, p);
         If p.username<>''
            then begin
            n:=n+2;
            If n>=24
               then begin
               n:=1;
               writeln('[PAUSE]');
               readln;
               end;
            textattr:=9;
            write('#',P.UserID,' ',P.charname,' (',P.username,' @ ',P.I1,') ');
            write('Last on: ',P.S1,', days missed: ',P.dateon);
            writeln;
            textattr:=1;
            write('   [Level ',P.level,', ',srace[P.race],', ',sclass[P.class],']');
            writeln;
            end;
         end;
     close(f);
     textattr:=7;
end .
