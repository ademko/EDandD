{after math if batlles}

{###################################################################}
{heals a player}
procedure OffLineHeal(var p:pc);
var q:boolean;
begin
     q:=false;
     If (P.HP>0) and (P.HP<P.HPMax)
        then begin repeat

             If P.Heal>0
                then begin
                q:=false;
                P.HP:=P.HP+(Die(3,3)*((P.Level div 2)+1));
                If P.HP>P.HPMax then P.HP:=P.HPMax;
                dec(P.Heal);
                end
                else q:=true;

             If q
                then If (P.MP>=mpheal) and (P.Class=2)
                     then begin
                     q:=false;
                     P.HP:=P.HP+die(3, P.level * 10 div 3);
                     If P.HP>P.HPMax then P.HP:=P.HPMax;
                     P.MP:=P.MP-mpheal;
                     end
                     else q:=true;


             until q or (P.HP>=P.HPmax);
             end;

end;
{###################################################################}
procedure WA_Swap(find:byte);{test for weapon swapping}
var W2:Weapon;
    A2:Armor;
begin
{w}  If (OPC.WVal>0) and (Die(1,20)<=find) and (CPC.class=OPC.class){char restrict}
        then begin
        Cwriteln(LF);
        Cwriteln('`003'+OPC.charname+'''s '+OPC.Wname+', `11valued at '+st(OPC.Wval)+' GP.'+LF);
        Cwriteln('`003Your '+CPC.Wname+', `11valued at '+st(CPC.Wval)+' GP.'+LF);
        Cwriteln(LF);
        Cwriteln('`10You''ve found the '+OPC.charname+'''s '+OPC.Wname+'!'+LF);
        Cwriteln('`2Do you want to take this weapon? (Y/N)'+LF);
        If upcase(Cread)='Y'
           then begin
           {equip}
           W.name:=OPC.Wname;
           W.Dis:=OPC.WDis;
           W.val:=OPC.Wval;
           W.decap:=OPC.Wdecap;
           W.range:=OPC.Wrange;
           W.dienum:=OPC.Wdienum div 2;{old use sub}
           W.die:=OPC.Wdie div 2;
           W.diebon:=OPC.Wdiebon div 2;
           W.thaco:=20-((20-OPC.Wthaco) div 2);

           W2.name:=CPC.Wname;
           W2.Dis:=CPC.WDis;
           W2.val:=CPC.Wval;
           W2.decap:=CPC.Wdecap;
           W2.range:=CPC.Wrange;
           W2.dienum:=CPC.Wdienum div 2;{old use sub}
           W2.die:=CPC.Wdie div 2;
           W2.diebon:=CPC.Wdiebon div 2;
           W2.thaco:=20-((20-CPC.Wthaco) div 2);

           W2PC(CPC);
           W:=W2;
           W2PC(OPC);

           Cwriteln('`13Swapped Weapons!'+LF);
           Paw;
           end;
        end;

{a}  If (OPC.AVal>0) and (Die(1,20)<=find) and (CPC.class=OPC.class)
        then begin
        Cwriteln(LF);
        Cwriteln('`003'+OPC.charname+'''s '+OPC.Aname+', `11valued at '+st(OPC.Aval)+' GP.'+LF);
        Cwriteln('`003Your '+CPC.Aname+', `11valued at '+st(CPC.Aval)+' GP.'+LF);
        Cwriteln(LF);
        Cwriteln('`10You''ve found the '+OPC.charname+'''s '+OPC.Aname+'!'+LF);
        Cwriteln('`2Do you want to take this armor? (Y/N)'+LF);
        If upcase(Cread)='Y'
           then begin
           {equip}
           A.name:=OPC.Aname;
           A.val:=OPC.Aval;
           A.AC:=(OPC.AAC-10) div 2;{old use sub}

           A2.name:=CPC.Aname;
           A2.val:=CPC.Aval;
           A2.AC:=(CPC.AAC-10) div 2;{old use sub}

           A2PC(CPC);
           A:=A2;
           A2PC(OPC);

           Cwriteln('`13Swapped Armors!'+LF);
           Paw;
           end;
        end;

end;
{###################################################################}
procedure Killed;
{when a user dies}
begin
     CPC.HP:=0;
     CPC.MP:=0;
     CPC.TP:=0;
     CPC.DateOn:=-1;
     CPC.Fights:=0;
     CPC.loc:=99;
     CPC.XP:=trunc(CPC.XP*0.95);
     SendANS('Killed','');
     Paw;
end;
{##################################################################}
procedure ShowWin(XP, GP, PP, HE, FO:word);
begin
     SendANS('Win','');
     Bar;
     Cwriteln(acolor(abold,awhite,ablue)+agotoxy(42,7)+num2str(XP));
     Cwriteln(agotoxy(42,8)+num2str(GP)+agotoxy(42,9)+num2str(PP));
     Cwriteln(agotoxy(42,10)+num2str(HE)+agotoxy(42,11)+num2str(FO)+agotoxy(1,20));
     Cwriteln(acolor(anormal,awhite,ablack));
end;
{#############################################################}
procedure LevelUp(var P:PC);
{checks for a level up a udjusts accordingly!}
var tlev:byte;
    hp, mp, tp, str, dex, wis, iq, con, luc:word;

procedure TAt(var at:word);
begin
      If Die(1,25)<=at
         then at:=1
         else at:=0;
end;

procedure ShowUp(s:string; u:word);
begin
     if u>0
        then Cwriteln('`5Your `013'+s+' `5went up by `013'+num2str(u)+'`005!'+LF);
end;

begin
     tlev:=P.level+1;
     If (P.Level<Mlevel) then begin
     If (P.XP<LReq[tlev])
        then Cwriteln('`2You still need `010'+Num2Str(LReq[tlev]-P.XP)+' XP`2 for a level up.'+LF)
        else begin
             Paw;
             SendANS('LevelUp','');
             Paw;
             Inc(P.Level);
             case P.Class of
                  0:begin
                         hp:=2;
                         mp:=0;
                         tp:=0;
                         str:=2;
                         dex:=1;
                         wis:=0;
                         iq:=0;
                         con:=1;
                         luc:=0;
                         end;
                  1:begin
                         hp:=1;
                         mp:=1;
                         tp:=0;
                         str:=0;
                         dex:=1;
                         wis:=1;
                         iq:=2;
                         con:=0;
                         luc:=0;
                         end;
                  2:begin
                         hp:=1;
                         mp:=1;
                         tp:=0;
                         str:=0;
                         dex:=1;
                         wis:=1;
                         iq:=0;
                         con:=1;
                         luc:=0;
                         end;
                  3:begin
                         hp:=1;
                         mp:=0;
                         tp:=2;
                         str:=0;
                         dex:=2;
                         wis:=0;
                         iq:=0;
                         con:=0;
                         luc:=1;
                         end;
                  end;
             hp:=Die(4,8)*hp;
             mp:=Die(4,8)*mp;
             tp:=Die(4,8)*tp;
             Tat(Str);
             Tat(Dex);
             Tat(Wis);
             Tat(IQ);
             Tat(Con);
             Tat(Luc);
             ShowUp('hit points',hp);
             ShowUp('magic points',mp);
             ShowUp('thief points',tp);
             ShowUp('stregth',str);
             ShowUp('dexterity',dex);
             ShowUp('wisdom',wis);
             ShowUp('I.Q.',iq);
             ShowUp('constitution',con);
             ShowUp('luck',luc);
             P.HPmax:=P.HPmax+hp;
             P.MPmax:=P.MPmax+mp;
             P.TPmax:=P.TPmax+tp;
             P.str:=P.str+str;
             P.dex:=P.dex+dex;
             P.wis:=P.wis+wis;
             P.iq:=P.iq+iq;
             P.con:=P.con+con;
             P.luc:=P.luc+luc;
             Cwriteln(LF+'`4Your title is now `012"'+tit[tlev]+'!"'+LF+LF);
             P.title:=tit[tlev];
             UpBull('`010'+P.charname+' `2has been promoted to level `010'+st(tlev)+'`002!!'+LF+LF);
             end;
        end;{Giant IF}
end;


{###################################################################}
procedure WinE;
{$I Chest.Pas} {treasure chest!}
begin
     ShowWin(trunc(OPC.XP), OPC.GP, OPC.PP, OPC.Heal, OPC.Food);
     CPC.XP:=CPC.XP+OPC.XP;
     CPC.GP:=CPC.GP+OPC.GP;
     CPC.PP:=CPC.PP+OPC.PP;
     CPC.Heal:=CPC.Heal+OPC.Heal;
     CPC.Food:=CPC.Food+OPC.Food;
     LevelUp(CPC);
     Paw;
     WA_Swap(2);
     Chest;
end;
{###################################################################}
procedure LosE;
begin
     UpBull('`011'+CPC.charname+' `3has been killed by a whimpy `011'+OPC.charname+'!!'+LF+LF);
     Killed;
end;

{###################################################################}
procedure RunE;
begin
     UpBull('`012'+CPC.charname+'`004 has ran away in the face of a whimpy `012'+OPC.charname+'`004!!'+LF+LF);
end;

{###################################################################}
procedure WinP;
begin
     UpBull('`012'+CPC.charname+'`004 has killed`012 '+OPC.charname+'`004!!'+LF);
     UpBull(' `013"'+OPC.S2+'"`005, '+Verb[Die(1,MVerb)]+' '+OPC.charname+'!'+LF+LF);
     ShowWin(trunc(0.05*OPC.XP), OPC.GP, OPC.PP, OPC.Heal, OPC.Food);
     CPC.XP:=CPC.XP+trunc(0.05*OPC.XP);
     CPC.GP:=CPC.GP+OPC.GP;
     OPC.GP:=0;
     CPC.PP:=CPC.PP+OPC.PP;
     OPC.PP:=0;
     CPC.Heal:=CPC.Heal+OPC.Heal;
     OPC.Heal:=0;
     CPC.Food:=CPC.Food+OPC.Food;
     OPC.Food:=1;
     OPC.Loc:=99;
     Inc(CPC.I3);
     CPC.good:=CPC.good-OPC.good;
     If OPC.good>=0
        then Cwriteln('`4For killing this `12good`4 citizen, you lose `012'+num2str(OPC.good)+' `4goodness.'+LF)
        else Cwriteln('`4For killing this `12evil`4 soul, you gain `012'+num2str(-1*OPC.good)+' `4goodness.'+LF);
     PutPC(OPC, OPC.UserID);
     LevelUp(CPC);
     Paw;
     WA_Swap(20);{garentee swap!}
     PutPC(OPC, OPC.UserID);
end;

{###################################################################}
procedure LosP;
begin
     UpBull('`012'+OPC.charname+'`004 has killed `012'+CPC.charname+'`004 in self defence!'+LF);
     UpBull(' `013"'+CPC.S2+'"`005, '+Verb[Die(1,MVerb)]+' '+CPC.charname+'!'+LF+LF);
     Inc(CPC.I3);
     OffLineHeal(OPC);
     PutPC(OPC, OPC.UserID);
     Killed;
end;

{###################################################################}
procedure TieP;
begin
     UpBull('`012'+CPC.charname+'`004 has ran away in the face of `012'+OPC.charname+'`004!!'+LF);
     UpBull(' `013"'+CPC.S2+'"`005, '+Verb[Die(1,MVerb)]+' '+CPC.charname+'!'+LF+LF);
     OffLineHeal(OPC);
     PutPC(OPC, OPC.UserID);
end;
{###################################################################}
