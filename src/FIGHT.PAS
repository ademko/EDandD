function Fight:byte;{1=CPC Won, 2=OPC Won, 3=CPC Ran}
var c:char;
    ex:byte;{exit code}
    cap:boolean;    {decapatated??}

procedure BM(s:string);
{battle message}
begin
     GotoMess;
     Cwriteln(s);
     Bdelay;
end;

procedure Update;
begin
     Bar;

     Cwriteln(agotoxy(51,3)+cond(CPC.HP,CPC.HPmax)+'   '+acc0);
     Cwriteln('`012'+agotoxy(51,8)+lPad(num2str(CPC.hp)+'/'+num2str(CPC.HPMax),7));
     Cwriteln('`009'+agotoxy(51,9)+lPad(num2str(CPC.mp)+'/'+num2str(CPC.MPMax),7));
     Cwriteln('`010'+agotoxy(51,10)+lPad(num2str(CPC.tp)+'/'+num2str(CPC.tPMax),7));
     Cwriteln('`005'+agotoxy(74,8)+lPad(num2str(CPC.food),4));
     Cwriteln(agotoxy(74,9)+lPad(num2str(CPC.heal),4));

     Cwriteln(agotoxy(69,23)+'`015'+lPad(st(minleft),4));
     Cwriteln(agotoxy(48,13)+cond(OPC.HP,OPC.HPmax)+'   '+acc0);
end;
procedure BUpdate;
{big update}
begin
     SendANS('Fight','');
     Bar;
     Cwriteln(agotoxy(1,2));
     SendANS(CPC.Icon,'');
     Cwriteln(agotoxy(1,12));
     SendANS(OPC.Icon,'');
     Cwriteln('`012'+agotoxy(51,2)+CPC.charname);
     Cwriteln('`005'+agotoxy(45,5)+CPC.Wname);
     Cwriteln(agotoxy(45,6)+CPC.AName);
     Cwriteln('`009'+agotoxy(48,12)+OPC.charname);
     Cwriteln('`006'+agotoxy(45,15)+OPC.Wname);
     Cwriteln(agotoxy(45,16)+OPC.AName);
     Update;
end;

function AI(var P:PC):char;
{artificial intelegence, HA!}
var c:char;
begin
     c:=' ';
     {need to heal?}
     If P.HP<=trunc(P.HPmax*0.25)
        then begin
        If (P.class=2) and (P.MP>=MPheal)
           then c:='H';
        If (c=' ') and (P.heal>0)
           then c:='U';
        If (c=' ')
           then c:='A';
        end
        else begin
        If (P.class=1) and (P.MP>=MPfire)
           then c:='F';
        If (c=' ')
           then c:='A';
        end;
     AI:=c;
end;


Procedure Attack(var a, d:PC);
var tohit, dam:integer;
begin
     gotomess;
     Cwriteln('`011'+a.charname+' '+a.Wdis+' '+d.charname+'!');
     Bdelay;
     tohit:=a.WThaco-d.aac;
     dam:=die(a.wdienum,a.wdie)+a.wdiebon;
     If Die(1,20)>=tohit
        then begin
        gotomess;
        Cwriteln('`012'+a.charname+' HITS! for '+num2str(dam)+' points of damage!');
        Bdelay;
        d.hp:=d.hp-dam;
        If (Die(1,20)=1) and (a.Wdecap)
            then begin
            cap:=TRUE;
            BM('`140DECAPATATION!');
            d.hp:=0;
            end;
        end
        else begin
        gotomess;
        Cwriteln('`009'+a.charname+' misses '+d.charname+' completely!');
        BDelay;
        end;
     Update;
end;

procedure FireBall(var a, d:PC);
{Fire Ball: Hadyken!}
var tohit, dam:integer;
begin
     If a.class<>1
        then BM('`4Only a Wizard can cast a FIRE BALL!!')
        else If a.mp<MPfire
             then BM('`4You don''t have enough MPs to cast a FIRE BALL!')
             else begin
             a.mp:=a.mp-MPfire;
             dam:=die(3, a.level * 10 div 3);
             tohit:=5-d.aac;
             BM('`012'+a.charname+' casts a FIRE BALL!');
             If (Die(1,20)>=tohit)
                then begin
                If not(bansi)
                   then begin
                   SendANS('SpelFire','');
                   Cwriteln('`13Hit for '+num2str(dam)+' points of damage!');
                   end
                   else BM('`13Hit for '+num2str(dam)+' points of damage!');
                d.hp:=d.hp-dam;
                If not(bansi)
                   then begin
                   Paw;
                   BUpdate;
                   end;
                end
                else BM('`4The fire ball just BARELY missed '+d.charname+'!');
             end;
end;


procedure DoMove(var a, d:PC; mv:char);
{battle chose processor}
begin
     case mv of
          'A':Attack(a,d);
          'F':FireBall(a,d);
          'U':begin
                   BM('`010'+a.charname+' searches for a healing potion...');
                   If DrinkPotion(a,TRUE)
                      then BUpdate;
                   end;
          'H':begin
                   BM('`011'+a.charname+' searches for a spell book...');
                   If CastHeal(a, TRUE)
                      then BUpdate;
                   end;
          'R':BM('`3You look around for a place to run....');
          end;
end;


begin
     ex:=0;
     cap:=FALSE;
     BUpdate;

     {Test For RANGE!}
     If (OPC.Wrange)
        then begin
        BM('`015'+OPC.charname+' uses it''s range weapon!');
        Attack(OPC, CPC);
        If CPC.HP<=0
           then ex:=2;
        end;
     If (CPC.Wrange)
        then begin
        BM('`15You get an early attack for your range weapon!');
        Attack(CPC, OPC);
        If OPC.HP<=0
           then ex:=1;
        end;


     repeat
           If ex=0
              then begin
              gotomess;
              Cwriteln('`10What will you do?'+acc0);
              repeat
                    c:=upcase(Cread);
                    If c='V'
                       then begin
                       ViewChar;
                       BUpdate;
                       GotoMess;
                       Cwriteln('`10What will you do?');
                       end;
                    If minleft<=0
                       then c:='R';
                    until c in ['A','F','H','U','R'];

              {actual colision!}
              If Die(1,30) >= (15+CPC.dex-OPC.dex)
                 then begin
                 If CPC.HP>0
                    then DoMove(CPC, OPC, c);
                 If OPC.HP>0
                    then DoMove(OPC, CPC, AI(OPC));
                 end
                 else begin
                 If OPC.HP>0
                    then DoMove(OPC, CPC, AI(OPC));
                 If CPC.HP>0
                    then DoMove(CPC, OPC, c);
                 end;
           end else c:='A';{IF}

           Update;
           {run check}
           If (c='R') and (CPC.HP>0)
              then begin
              BM('`2You make a break for it...');
              If Die(1,30) >= (15+CPC.dex-OPC.dex)
                 then begin
                 BM('`10Great! You lost that slow '+OPC.charname+'.');
                 ex:=3;
                 end
                 else BM('`004'+OPC.charname+' blocked you!');
              end;

           If CPC.HP<=0
              then begin
              gotomess;
              Cwriteln('`12The '+OPC.charname+' laughs at you feable attempts as you lie');
              BDelay;
              gotomess;
              Cwriteln('`12on the ground, bleeding to a slow death....');
              BDelay;
              ex:=2;
              end;
           If OPC.HP<=0
              then begin
              gotomess;
              Cwriteln('`12You stand triumphantly over the dead body of the '+OPC.charname+',');
              Bdelay;
              gotomess;
              Cwriteln('`12Watching it bleed from the many wounds you inflicted...');
              Bdelay;
              ex:=1;
              end;
           if (cap) and not(bansi)
              then begin
              SendANS('Decap', '');
              delay(3*fdelay);
              end;

           {test 4 deaths!}
           until ex<>0;

     Fight:=ex;
     GotoMess;
     Paw;
     Cwriteln(aclrscr);
end;
