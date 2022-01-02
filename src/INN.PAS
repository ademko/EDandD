procedure Inn;
var c:char;

const Room:Array [1..5] of string[40] =
                 ('Stable',
                 'Bunk Bed',
                 'Unfurnished Room',
                 'Furnished Room',
                 'Suite');

procedure GetARoom(lv:byte);
var cost:longint;
    c2:char;
begin
     cost:=lv*CPC.level*100;
     SendANS('Room','');
     Bar;
     Cwriteln(LF+'`2"This room will cost you `010'+st(cost)+' `2GP,'+LF);
     Cwriteln('Do you sill want it?" `10(Y/N)'+LF);
     c2:=Upcase(Cread);
     if (c2='Y') and (cost>CPC.GP)
        then Cwriteln(LF+'`12"You don''t have enough gold!"'+LF);
     if (c2='Y') and (cost<=CPC.GP)
        then begin
        CPC.GP:=CPC.GP-cost;
        CPC.loc:=100+lv;
        CPC.HP:=CPC.HPmax;
        CPC.MP:=CPC.MPmax;
        CPC.TP:=CPC.TPmax;
        Cwriteln(LF+'`9"Good night brave warrior, and may your'+LF);
        Cwriteln('sleep be peacefull....'+LF);
        end;
     Paw;
end;

procedure BribeC;
var c:char;

function Show(idx:word):boolean;
begin
     GetPC(OPC, idx);
     Show:=(between(OPC.loc,101,105)) and (idx<>CPC.UserID);
end;

procedure AttackP;
var n:integer;
    c:longint;
    e, s:boolean;
    s1:string;
begin
     s:=FALSE;
     for n:=1 to maxpc do
         If Show(n)
            then begin
            s:=TRUE;
            Cwriteln('`013'+OPC.charname+' `005(ID #`014'+num2str(OPC.userID)+'`5) is in a `014'+Room[OPC.loc-100]+LF);
            end;
     If s
        then begin
        Cwriteln('`9"Who do you want to attack?" `1(ENTER=Abord) : `009');
        s1:=Creadln(3);
        n:=vl(s1)
        end
        else begin
        Cwriteln(LF+'`9"No one is here to attack..."'+LF);
        Paw;
        end;

     If s and (s1<>'') then
     If not(between(n,1,maxpc))
        then begin
        Cwriteln(abord);
        Paw;
        end
        else If CPC.Level>OPC.Level+MGap
                then begin
                cwriteln(LF+'`13Surley you could find a more worthy opponent!'+LF);
                Paw;
                end else
            If show(n)
             then begin
             c:=(OPC.loc-100)*CPC.Level*100;
             Cwriteln(LF+'`10"It will cost ya...hmmm... I say about'+LF);
             Cwriteln('`011'+st(c)+' GPs. `10Do you still want to attack? `2(Y/N)'+LF);
             e:=Upcase(Cread)='Y';
             Cwriteln(LF+LF);
             If e and (CPC.GP<c)
                then begin
                Cwriteln(LF+'`12"Mabye when you get some real cash..."'+LF);
                Paw;
                end;
             If not(e)
                then begin
                Cwriteln(LF+'`1"Ohhh well, another whimpy warrior....'+LF);
                Paw;
                end;
             If e and (CPC.GP>=c)
                then begin
                Cwriteln('`13"Great! Here are the spare keys..."'+LF+LF);
                Cwriteln('`5You go to the '+Room[OPC.loc-100]+' and prepare for Battle!'+LF);
                CPC.GP:=CPC.GP-c;
                Paw;
                BackStab;
                Case Fight of{battle data!}
                     1:WinP;
                     2:LosP;
                     3:TieP;
                     end;
                end;
             end
             else If s
                  then begin
                  Cwriteln(abord);
                  Paw;
                  end;
end;

begin
     repeat
           Cwriteln(LF+LF+LF+'`10"Hmmm, so you want to have the keys'+LF);
           Cwriteln('to someones room eh? I''ll need a little incentive..."'+LF);
           Cwriteln('`2[Give her some cash as a bribe? (Y/N)]'+LF);
           c:=Upcase(Cread);
           If c='Y'
              then AttackP;
           until (c <>'Y') or (Minleft<=0) or (CPC.loc<>0) or (CPC.I3>=maxpckill);
end;

procedure Conver; {Patrons converser!}
var f:File of Patron;
    b:Array[1..maxpate] of Patron;
    l, fr:byte;
begin
     fr:=0;
     assign(f,'Inn.Rec');
     FMode(flReadMode);
     reset(f);
     l:=0;
     repeat
           Inc(l);
           read(f,b[l]);
           until eof(f);
     close(f);
     Cwriteln(aclrscr);
     l:=0;
     repeat
           Inc(l);
           If b[l].who<>''
              then begin
              Cwriteln('`004'+b[l].who+LF);
              Cwriteln(' `012'+b[l].what+LF);
              end
              else If fr=0
                   then fr:=l;
           until l=maxpate;
     If fr=0
        then begin
        for l:=1 to maxpate-1 do
            b[l]:=b[l+1];
        b[maxpate].who:='';
        b[maxpate].what:='';
        fr:=maxpate;
        end;
     Cwriteln('`002Do you want to add your wisdom to this conversation?`010 (Y/N)'+LF);
     If Upcase(Cread)='Y'
        then begin
        Cwriteln('`002Enter up to `01075 Characters`002:`013'+LF);
        b[fr].who:=CPC.charname+' '+Verb[Die(1,MVerb)]+':';
        b[fr].what:=Creadln(75);
        Cwriteln('`011Done!'+LF);
        Paw;
        end;
     assign(f,'Inn.Rec');
     FMode(flWriteMode);
     rewrite(f);
     l:=0;
          repeat
          Inc(l);
          write(f,b[l]);
          until l=maxpate;
     close(f);
end;

procedure Flirt;
var c,i:byte;
    g:word;
begin
     if CPC.female
        then begin
        Cwriteln(LF+LF+'`12Cindy is not that kind of a girl!'+LF+LF);
        Paw;
        end else begin
        if Ini_read(ininame,'Cindy','')=st(CPC.UserID)
           then begin
           Cwriteln(LF+LF+'`13You''ve already tried!'+LF+LF);
           Paw;
           end else begin
           Cwriteln(LF+LF+'`10Cindy is the sexiest women in all of Solace.'+LF);
           Cwriteln('Only the bravest warriors have a chance to succeed with her...'+LF+LF);
           for i:=1 to 6 do
               Cwriteln(' `004(`012'+st(i)+'`004) `2'+Cin[i]+LF);
           Cwriteln(LF+'`10What would you like to do? ');
           c:=vl(Cread);
           Cwriteln(LF+LF);
           if between(c,1,6)
              then begin
              Ini_Write(ininame,'Cindy',st(CPC.UserID));
              If CPC.Level>(c*2-1){got lucky?}
                 then begin
                 g:=Pow(2,c-1)*30;
                 if c=6
                    then begin
                    Cwriteln(LF+LF+'`14You and Cindy had a very enjoyable time upstairs,'+LF);
                    Cwriteln('after which you celebrated with cigarettes.'+LF);
                    Cwriteln('You both come back down to the bar, with big smiles on your faces!'+LF+LF);
                    UpBull('`010'+CPC.charname+' `2got lucky with Cindy!!'+LF+LF);
                    end else begin
                    Cwriteln(LF+LF+'`12Cindy smiles back at you!'+LF);
                    Cwriteln('You''re making progress with her!'+LF+LF);
                    end;
                 Cwriteln('`11You''ve gained '+st(g)+' experiance points!'+LF);
                 CPC.XP:=CPC.XP+g;
                 LevelUp(CPC);
                 Paw;
                 end else begin
                 Cwriteln(LF+LF+'`9Cindy ignores you and goes to another table...'+LF);
                 Cwriteln('Looks like you''re going to have to keep working up your'+LF);
                 Cwriteln('muscles and show her what a heroic man you are!'+LF);
                 Paw;
                 end;
              end else begin
              Cwriteln(LF+'`9Oh well, mabye next time when you get a little more courage...'+LF);
              Paw;
              end;
           end;
        end;
end;

begin
     repeat
           SendANS('Inn','Lost Trveler''s Inn');
           Bar;
           Prop;
           c:=Upcase(Cread);
           case c of
                '1'..'5':GetARoom(str2num(c));
                'V':ViewChar;
                'B':If CPC.I3<maxpckill
                       then BribeC
                       else begin
                       Cwriteln(LF+LF+'`12Enough blood shed! Try again tommorow'+LF);
                       Cwriteln('when you have more strenght...'+LF);
                       Paw;
                       end;
                'C':Conver;
                'F':Flirt;
                '?':SendANS('Inn','?');
                end;
           until (c='Q') or (Minleft<=0) or (CPC.loc<>0);
end;
