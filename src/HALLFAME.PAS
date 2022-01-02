procedure VHallFame;
{view hall of fame}
{$I HallFame.Dat}
var b:boolean;
    i:word;
    t:pc;
begin
     CSendArray(HallFameANS);
     b:=false;
     For i:=1 to maxpc do
         begin
         GetPC(t,i);
         If (t.username<>'') and ( (t.s3[1]<>' ') or (t.s3[2]<>' ') )
            then begin
            b:=true;
            case ( ord(t.s3[1]) + ord(t.s3[2]) ) of
{only E}         101:Cwriteln('`12'+t.charname+'`4 has killed the King!'+LF);
{only G}         103:Cwriteln('`12'+t.charname+'`4 has killed the Dragon!'+LF);
{both!}          140:Cwriteln('`28'+t.charname+' has killed BOTH the King and Dragon!!`4'+LF);
                 end;
            end;
         end;
     If not(b)
        then Cwriteln('`13No brave warriors yet!'+LF);
     Cwriteln(LF);
     Paw;
end;
