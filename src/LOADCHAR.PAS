{#####################################################################}
{Creats a New Character!}
function NewChar:boolean;
var sel, lp:word;
    ch:char;
begin
     NewChar:=FALSE;
     SendANS('CSheet','');
     Bar;

     Cwriteln(Agotoxy(53, 2)+Acolor(anormal,ablue,ablack));
     Cwriteln(dropfile.username);
     Cwriteln(Agotoxy(69, 23)+Acolor(Abold, ared, ablack));
     Cwriteln(Num2Str(MinLeft));

     {Icon Selector}
     sel:=1;
     GotoMess;
     Cwriteln('Press '+acc(abold)+'SPACE'+acc0+' to cycle through icons,');
     Cwriteln(' and press '+acc(abold)+'ENTER'+acc0+' when done.');
     repeat
           Cwriteln(Agotoxy(1, 2)+Acolor(anormal,ared,ablack));
           For lp:=1 to 8 do
               Cwriteln('º                             º'+LF);
           Cwriteln(Agotoxy(1,2));
           SendANS('pcicon'+Num2Str(sel),'');
           ch:=Cread;
           if ch=#32
              then if not(exist('PcIcon'+Num2Str(sel+1)+'.Ans'))
                   then sel:=1
                   else inc(sel);
           until (ch=#13) or (Minleft<=0);
     CPC.icon:='pcicon'+Num2Str(sel);

     {Character Name}
     repeat
           GotoMess;
           Cwriteln(acc(abold)+'Type'+acc0+' in your character''s name.');
           Cwriteln(Agotoxy(53,3)+AColor(ABold, ACyan, Ablack));
           CPC.charname:=Creadln(16);
           until Anything(CPC.Charname) or (MinLeft<=0);
     Cwriteln(Agotoxy(53,3)+AColor(ANormal, ACyan, Ablack)+CPC.charname);

     {Race Selector}
     GotoMess;
     Cwriteln('Press '+acc(abold)+'SPACE '+acc0+'to cycle');
     Cwriteln(' through the different races, press '+acc(abold)+'ENTER'+acc0+' when done.');
     sel:=0;
     Cwriteln(Acolor(Ablink, Ared, Ablack));
     repeat
           Cwriteln(AGotoXY(44,10)+'           '+AGotoXY(44,10));
           Cwriteln(SRace[sel]);
           ch:=Cread;
           If ch=#32
              then if sel=4
                   then sel:=0
                   else inc(sel);
           until (ch=#13) or (minleft<=0);
     Cwriteln(AGotoXY(44,10)+Acolor(Anormal,Ared,Ablack)+Acolor(Abold,Ared,Ablack)+SRace[sel]);
     CPC.race:=sel;

     {Class Selector}
     GotoMess;
     Cwriteln('Press '+acc(abold)+'SPACE'+acc0+' to cycle through');
     Cwriteln(' the different classes, press '+acc(abold)+'ENTER'+acc0+' when done.');
     sel:=0;
     Cwriteln(Acolor(Ablink, Ared, Ablack));
     repeat
           Cwriteln(AGotoXY(69,10)+'       '+AGotoXY(69,10));
           Cwriteln(Sclass[sel]);
           ch:=Cread;
           If ch=#32
              then if sel=3
                   then sel:=0
                   else inc(sel);
           until (ch=#13) or (minleft<=0);
     Cwriteln(AGotoXY(69,10)+Acolor(Anormal,Ared,Ablack)+Acolor(Abold,Ared,Ablack)+SClass[sel]);
     CPC.class:=sel;

     {male/female}
     Cwriteln(Acolor(Ablink, Ared, Ablack)+Agotoxy(44,12)+'?');
     GotoMess;
     Cwriteln('Is your character Male or Female? '+acc(abold)+'(Press M or F)'+acc0);
     repeat
           ch:=Upcase(Cread);
           until (ch='F') or (ch='M') or (Minleft<=0);
     Cwriteln(AGotoXY(44,12)+Acolor(Anormal,Ared,Ablack)+Acolor(Abold,Ared,Ablack)+ch);
     CPC.female:= ch='F';

     {goodness}
     Cwriteln(Acolor(Ablink, Ared, Ablack)+Agotoxy(69,12)+'?');
     GotoMess;
     Cwriteln('Do you want to be Good or Evil? '+acc(abold)+'(Press G or E)'+acc0);
     repeat
           ch:=Upcase(Cread);
           until (ch='G') or (ch='E') or (Minleft<=0);
     If ch='E'
        then CPC.Good:=-10
        else CPC.Good:=10;
     Cwriteln(AGotoXY(69,12)+Acolor(Anormal,Ared,Ablack)+Acolor(Abold,Ared,Ablack)+Num2Str(CPC.Good));

     {Givens}
     Cwriteln(AGotoxy(20,19)+AColor(ABold,ACyan,ABlack)+'10');
     CPC.food:=10;
     Cwriteln(AGotoxy(20,20)+AColor(ABold,ACyan,ABlack)+'25');
     CPC.heal:=25;
     Cwriteln(AGotoxy(44,11)+AColor(ABold,AMagenta,ABlack)+'1');
     CPC.Level:=1;
     Cwriteln(AGotoxy(69,11)+AColor(ABold,AMagenta,ABlack)+'0');
     CPC.XP:=0;
     Cwriteln(AGotoxy(71,17)+AColor(ABold,AYellow,ABlack)+'No');
     CPC.WDecap:=FALSE;
     Cwriteln(AGotoxy(71,18)+AColor(ABold,AYellow,ABlack)+'No');
     CPC.WRange:=FALSE;
     CPC.bank:=0;
     Cwriteln(agotoxy(69,19)+aAtr(12)+st( LReq[CPC.Level+1] ));


     {Random Roller}
     sel:=10;
     repeat
           dec(sel);

           CPC.Str:=Die(3,6);
           CPC.IQ:=Die(3,6);
           CPC.Wis:=Die(3,6);
           CPC.Dex:=Die(3,6);
           CPC.Con:=Die(3,6);
           CPC.Luc:=Die(3,6);
           {female?}
           if CPC.female
              then begin
              Inc(CPC.Wis);
              Dec(CPC.Str);
              end;
           {racial +'s & -'s}
           case CPC.race of
                1:begin
                       Dec(CPC.Str);
                       Dec(CPC.Con);
                       Inc(CPC.Dex);
                       Inc(CPC.IQ);
                       end;
                2:begin
                       Dec(CPC.Dex);
                       Dec(CPC.Luc);
                       Inc(CPC.Str);
                       Inc(CPC.Con);
                       end;
                3:begin
                       Inc(CPC.Dex);
                       Inc(CPC.Luc);
                       Dec(CPC.Str);
                       Dec(CPC.Con);
                       end;
                4:begin
                       Inc(CPC.Con);
                       Inc(CPC.Con);
                       Dec(CPC.IQ);
                       Dec(CPC.Wis);
                       end;
                end;
           case CPC.class of
                0:begin
                       CPC.HPmax:=Die(3,12);
                       CPC.MPmax:=0;
                       CPC.TPmax:=0;
                       end;
                1:begin
                       CPC.HPmax:=Die(3,6);
                       CPC.MPmax:=Die(1,8)*3;
                       CPC.TPmax:=0;
                       end;
                2:begin
                       CPC.HPmax:=Die(3,10);
                       CPC.MPmax:=Die(1,8)*2;
                       CPC.TPmax:=0;
                       end;
                3:begin
                       CPC.HPmax:=Die(3,8);
                       CPC.MPmax:=0;
                       CPC.TPmax:=Die(1,6)*3;
                       end;
                end;
           {ability mods}
           CPC.HPmax:=(CPC.Con-9 div 3) + CPC.HPmax;
           If CPC.MPmax <> 0
              then CPC.MPmax:=(CPC.IQ-9 div 3) + CPC.MPmax;
           If CPC.TPmax <> 0
              then CPC.TPmax:=(CPC.Dex-9 div 3) + CPC.TPmax;
           CPC.HP:=CPC.HPmax;
           CPC.MP:=CPC.MPmax;
           CPC.TP:=CPC.TPmax;
           CPC.GP:=Die(10,20);
           CPC.PP:=Die(4,4);

           CPC.title:=Tit[1];
           CPC.DateOn:=0;
           CPC.fights:=fightsaday;
           CPC.I2:=fightsaday div 2;{deeds}

           W_load(1,w);           {give him the minimums}
           W2PC(CPC);

           A_load(1,a);
           A2PC(CPC);

           {Show all this data!}
           Cwriteln(agotoxy(53,4)+acolor(anormal,acyan,ablack)+CPC.title);
           Cwriteln(acolor(anormal,agreen,ablack)+agotoxy(50,6)+Num2Str(CPC.Str)+' ');
           Cwriteln(agotoxy(50,7)+Num2Str(CPC.IQ )+' ');
           Cwriteln(agotoxy(50,8)+Num2Str(CPC.Wis)+' ');
           Cwriteln(agotoxy(72,6)+Num2Str(CPC.dex)+' ');
           Cwriteln(agotoxy(72,7)+Num2Str(CPC.con)+' ');
           Cwriteln(agotoxy(72,8)+Num2Str(CPC.luc)+' ');
           Cwriteln(agotoxy(20,11)+cond(CPC.HP,CPC.HPmax)+'     ');
           Cwriteln(acolor(abold,ared,ablack)+agotoxy(20,13)+num2str(CPC.HP)+'/'+num2str(CPC.HPmax)+'  ');
           Cwriteln(acolor(abold,ablue,ablack)+agotoxy(20,14)+num2str(CPC.MP)+'/'+num2str(CPC.MPmax)+'  ');
           Cwriteln(acolor(abold,agreen,ablack)+agotoxy(20,15)+num2str(CPC.TP)+'/'+num2str(CPC.TPmax)+'  ');
           Cwriteln(acolor(abold,acyan,ablack)+agotoxy(47,14)+CPC.Wname);
           Cwriteln(agotoxy(47,15)+CPC.Aname);
           Cwriteln(acolor(abold,amagenta,ablack)+agotoxy(47,17)+num2str(CPC.Wthaco)+' ');
           Cwriteln(agotoxy(47,19)+num2str(CPC.AAC)+'  '+agotoxy(47,18));
           Cwriteln(num2str(CPC.Wdienum)+'d'+num2str(CPC.Wdie)+'+'+num2str(CPC.Wdiebon));
           Cwriteln(acolor(anormal,agreen,ablack)+agotoxy(20,17)+num2str(CPC.GP)+' ');
           Cwriteln(agotoxy(20,18)+num2str(CPC.PP)+'  ');

           gotomess;
           Cwriteln('Press '+acc(abold)+'any'+acc0+' key to try again, and '+acc(abold)+'ENTER'+acc0);
           Cwriteln(' to keep. ['+num2str(sel)+' tries left]');

           {NEWSTUFF}
           bansi:=(dropfile.userbaud=1200) or (dropfile.userbaud=2400);
           CPC.Ans:=not(bansi);
           CPC.fdelay:=fdelay;
           CPC.S2:=MStr[Die(1,MMStr)];
           CPC.S3:='  - '+CT_SDate;
           CPC.B3:=true;

           ch:=Cread;
           if sel=0
              then ch:=#13;
           until (ch=#13) or (minleft<=0);

     NewChar:= MinLeft > 0;
     UpBull('`014'+CPC.charname+'`006 enters the realm of `014ED&D`006 for the first time!'+LF+LF);

     If CPC.good>0
        then SendANS('GoodMiss','')
        else SendANS('EvilMiss','');
     bar;
     Paw;
end;

{#####################################################################}
{Load a chracter, new and old!}
function LoadChar:Boolean;

var l, charloc, Newloc:word;

begin
     DelPC(0, CPC);        {clear the current stats}

     CharLoc:=0;        {user's characters location}
     NewLoc:=0;         {any free slots?}

     For l:=MaxPc downto 1 do
         begin
         GetPC(CPC, l);                 {loads the char}

         If CPC.UserName=''                     {test if its open}
            then newloc:=l;

         If CPC.UserName=dropfile.username     {tests if its the user's}
            then charloc:=l;
         end; {for-do}

     LoadChar:=TRUE;                            {succesful load}

     If (charloc<>0)                            {load saved PC}
        then begin
        GetPC(CPC, charloc);
        If CPC.DateOn<>-1
           then CPC.DateOn:=0;
        end;

     If (charloc=0) and (newloc=0)              {No room left}
        then begin
        LoadChar:=FALSE;
        Cwriteln(LF+acc(amagenta)+'Sorry, no room left.'+LF);
        Cwriteln('Try again tommorow to see if anybody was deleted.'+LF);
        Paw;
        end;

     If (charloc=0) and (newloc<>0)                {new char!}
        then if not(NewChar)
             then LoadChar:=FALSE
             else begin
             CPC.UserID:=Newloc;
             CPC.UserName:=dropfile.username;
             end;

     If CPC.DateOn<>-1
        then CPC.loc:=0;                {puts him out of Inn etc}

     {If -1}
     If CPC.DateOn=-1
        then begin
        Cwriteln(LF+'`13You died today.'+LF);
        Cwriteln('Try again tomorrow, when the healers find your body.'+LF);
        LoadChar:=FALSE;
        Paw;
        end;

     {banished?}
     If CPC.B1
        then begin
        Cwriteln('`10You have been banished from the realm.'+LF);
        Cwriteln('You may be riencarnated tommrow.'+LF);
        Paw;
        LoadChar:=FALSE;
        end;

     {IF HP=0}
     If (CPC.HP<=0) and (CPC.DateOn<>-1)
        then begin
        CPC.HP:=CPC.HPmax;
        CPC.MP:=CPC.MPmax;
        CPC.TP:=CPC.TPmax;
        if (CPC.gp+CPC.bank)<100 {free $$$}
           then CPC.gp:=CPC.gp+(100-CPC.gp+CPC.Bank);
        Cwriteln('`12You awake at the temple with a slitting headache.'+LF);
        Cwriteln('The healers bandage you up, and send you on your way.'+LF);
        Paw;
        end;


end;



