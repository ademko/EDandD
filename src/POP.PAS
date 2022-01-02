{Popular Functions}
{$I W_Utils.Pas}        {weapon managment}
{$I A_Utils.Pas}        {armor managment}
{$I PC_utils.Pas}       {PC managment}

{##################################################################}
procedure BDelay;
begin
     If CPC.B2
        then Cread
        else delaY(fdelay);
end;
{##################################################################}
function Cond(n1, n2:integer):String;
var per:real;
    s:string;
begin
     per:=n1/n2;
     s:=acolor(anormal,ared,ablack)+'Dead';
     if per>=0.999
        then s:=Acolor(anormal,agreen,ablack)+'Perfect';
     if (per>=0.5) and (per<0.999)
        then s:=Acolor(abold,ayellow,ablack)+'Okay';
     if (per>=0.25) and (per<0.5)
        then s:=Acolor(abold,ared,ablack)+'Hurt';
     if (per>0) and (per<0.25)
        then s:=Acolor(ablink,ared,ablack)+acolor(abold,ared,ablack)+'Dying';
     Cond:=s;
end;

{#################################################################}
{returns a Yes/No of a Boolean}
function yesno(b:boolean):string;
begin
     if b
        then yesno:='Yes'
        else yesno:='No';
end;
{#################################################################}
{Pause}
procedure GotoMess;
var lp:byte;
begin
     Cwriteln(AGotoXY(3,22));
     for lp:=1 to 74 do
         Cwrite(' ');
     Cwriteln(AGotoXY(3,22)+acc0);
end;

{#################################################################}
{Pause}
procedure Paw;

{$I Pause.Dat}  {pause graphix}

Begin
     Cwriteln(asavepos);
     Csendarray(Pause);
     CRead;
     Cwriteln(aloadpos+adelline);
end;

{#################################################################}
{Send a .ANS file, soon to have DOORTERM support}
Procedure SendANS(ansname:string; os:string);

const ansext='.ANS';              {ANS file extension}

begin
     ansname:=ansname+ansext;
     If (Bansi) and (os<>'') and (os<>'?')
        then begin
        Cwriteln(LF+LF+'`013'+os+LF);
        Cwriteln('`005(?=Help)'+acc0+LF);
        end
        else CSendFile(ansname);
end;

{#################################################################}
{Updates the StatBar}
Procedure Bar;
var st1:string;
Begin
     If SStat
        then begin
        st1:='³ '+dropfile.username+ ' ³ '+num2str(dropfile.userbaud)+' ³ ';
        st1:=st1+CPC.charname+' [Level '+st(CPC.Level)+' '+sclass[CPC.class];
        st1:=st1+'] ³ Time Left: '+num2str(MinLeft);
        end
        else begin
        st1:='³ F1=Help ³ Enhanced Dragons & Dungeons, Version '+version;
        st1:=st1+', By Alex Demko   ';
        end;

     StatBar(st1, '');
end;

{#################################################################}
{equips a PC}
procedure W2PC(var p:PC);

begin
     P.WName:=W.Name;
     P.WDis:=W.Dis;
     P.WVal:=W.Val;
     P.WDecap:=W.Decap;
     P.WRange:=W.Range;
     P.Wdienum:=W.DieNum + (P.dex div 16);
     P.Wdie:=W.Die;
     P.Wdiebon:=W.DieBon + (P.Str div 6);
     P.Wthaco:=W.Thaco - (P.Str div 6);
end;

{#################################################################}
{equips a PC}
procedure A2PC(var p:PC);

begin
     P.AName:=a.Name;
     P.AVal:=a.Val;
     P.AAC:=10 + a.ac - (p.dex div 8);
end;

{######################################################################}
function ListPC(LPC:PC):string;
{lists a PC, 4 PClist}
var s, x:string;
begin
     If LPC.good>=0
        then x:='Good'
        else x:='Evil';
     s:=aatr(3)+RPad(st(LPC.userid),3);
     s:=s+aatr(11)+RPad(LPC.Charname,18)+ASavePos+Cond(LPC.hp,LPC.hpmax);
     s:=s+AloadPos+AmoveRight(8)+aatr(3);
     s:=s+RPad(st(LPC.Level),4);
     s:=s+RPad(st(LPC.xp),8);
     s:=s+RPad(x,5);
     s:=s+RPad(sclass[LPC.class],10);
     s:=s+LPC.title;
     s:=s+acc0+LF;
     ListPC:=s;
end;

{##################################################################}
function PCExist(n:byte):Boolean;
begin
     GetPC(OPC, n);
     PCexist:=OPC.username <> '';
end;
{####################################################################}
procedure UpTop;
{update top scores}
var P:array [1..maxpc] of record
                                ID, XP:Word;
                                end;
    f:file of char;
    l, l2, l3:byte;

procedure Fwriteln(s:string);   {writes a line to a FILE of CHAR}
var lp:byte;
begin
     for lp:=1 to length(s) do
         write(f, s[lp]);
end;

begin
     for l:=1 to maxpc do
         begin
         P[l].id:=0;
         P[l].xp:=0;
         end;

     assign(f,TopFileName);
     FMode(flWriteMode);
     rewrite(f);

     Fwriteln(Aclrscr);
     For l:=1 to SizeOf(Tophead) do
         write(f,Tophead[l]);

     Fwriteln(LF+AmoveRight(26)+aatr(4)+'°±²Û '+aatr(12)+'Warriors List');
     Fwriteln(aatr(4)+' Û²±°'+LF);
     For l:=1 to SizeOf(PCList) do
         write(f,PClist[l]);

     for l:=1 to MaxPc do
         begin
         GetPC(OPC, l);
         If OPC.UserName <> ''
            then begin
            l2:=0;
            repeat
                  Inc(l2);
                  If OPC.XP >= p[l2].XP
                     then begin
                     For l3:=MaxPc Downto l2 do
                         If l3 <> 1
                            then p[l3]:=p[l3-1];
                     p[l2].XP:=OPC.XP;
                     p[l2].ID:=l;
                     end;
                  until (p[l2].ID=l) or (l2=MaxPc);
            end;
         end;

     For l:=1 to maxpc do
         If p[l].ID <> 0
            then begin
            GetPC(OPC, p[l].ID);
            Fwriteln(listPC(OPC));
            end;

     close(f);
end;

procedure ShowTop;

begin
     UpTop;
     Csenddoc(TopFileName);
end;

{#################################################################}
{Shut off door (ie. close files etc)}
procedure shutdown;

begin
     {goodbye screen}
     Cwriteln(aclrscr+'`13This FREEware program was made in a small room in Winnipeg, `116Û'+#6+'Û'+LF);
     Cwriteln('`10Don''t forget to call Five Starr BBS (204) 632-0596,'+LF);
     Cwriteln('`2For updates and game support!'+LF);
     Cwriteln(LF+'`4Now returning you to boring reality...'+LF+LF+LF);
     Paw;
     Delay(500);
     {turn off bar}
     InitBar(0, 0);
     {turn off doorutil}
     DoorLib_Off;
     ClrScr;
end;

{#################################################################}
{turns on the door}
procedure shutup;
begin
     {turn on doorutil}
     DoorLib_On;
end;
{###################################################################}
{casts the PRIEST spell: HEAL}
function CastHeal(var P:PC; bat:boolean):boolean;
var can:boolean;
    HPup:integer;
begin
     CastHeal:=FALSE;
     Bar;
     can:=TRUE;

     if P.class <> 2
        then begin
        if bat
           then begin
           gotomess;
           Cwriteln('`13You are not a Priest!');
           BDelay;
           end
           else begin
           Cwriteln(LF+'`13You are not a Priest!'+LF);
           Paw;
           end;
        can:=FALSE;
        end;

     if (P.MP < mpheal) and can
        then begin
        If bat
           then begin
           gotomess;
           Cwriteln('`13You don''t have enought Magic Points!');
           BDelay;
           end
           else begin
           Cwriteln(LF+'`13You don''t have enought Magic Points!'+LF);
           Paw;
           end;
        can:=FALSE;
        end;

     if (P.HP>=P.HPmax) and can
        then begin
        If bat
           then begin
           gotomess;
           Cwriteln('`10You not injured!');
           BDelay;
           end
           else begin
           Cwriteln(LF+'`10You not injured!'+LF);
           Paw;
           end;
        can:=false;
        end;

     if can
        then begin
        If not(bansi)
           then begin
           SendANS('SpelHEAL','');
           Bar;
           CastHeal:=TRUE;
           end
           else If bat
                then begin
                gotomess;
                Cwriteln('`010'+P.charname+' casts the spell of HEAL!');
                BDelay;
                end
                else Cwriteln('`010'+P.charname+' casts the spell of HEAL!');

        HPup:=die(3, P.level * 10 div 3);{don't forget WINDATA!}
        P.HP:=P.HP+HPup;
        IF P.HP > P.HPmax
           then begin
           HPup:=HPup - (P.hp - P.hpmax);
           P.HP:=P.HPmax;
           end;
        If bat
           then begin
           if bansi
              then gotomess;
           Cwriteln('`11The HEAL spell healed '+Num2Str(HPup)+' HP.');
           if bansi
              then BDelay
              else begin
                   Cwriteln(LF);
                   Paw;
                   end;
           end
           else begin
           Cwriteln(LF+'`11The HEAL spell healed '+Num2Str(HPup)+' HP.'+LF);
           Paw;
           end;
        P.MP:=P.MP-mpheal;
        end;
end;
{###################################################################}
{Drink a HEAL potion}
function DrinkPotion(var P:PC; bat:boolean):boolean;
var can:boolean;
    oldhp:integer;
begin
     drinkpotion:=FALSE;
     can:=TRUE;
     Bar;

     if P.heal<=0
        then begin
        can:=FALSE;
        If bat
           then begin
           gotomess;
           Cwriteln('`9You don''t have any HEAL POTIONS left!');
           BDelay;
           end
           else begin
           Cwriteln(LF+'`9You don''t have any HEAL POTIONS left!'+LF);
           Paw;
           end;
        end;

     if (P.HP>=P.HPMAX) and can
        then begin
        can:=FALSE;
        If bat
           then begin
           gotomess;
           Cwriteln('`10You not injured!');
           BDelay;
           end
           else begin
           Cwriteln(LF+'`10You not injured!'+LF);
           Paw;
           end;
        end;

     if can
        then begin
        If not(bansi)
           then begin
           SendANS('HPotion','');
           DrinkPotion:=True;
           Bar;
           end
           else if bat
                then begin
                gotomess;
                Cwriteln('`10A HEAL POTION is drunk!');
                BDelay;
                end
                else Cwriteln(LF+'`10A HEAL POTION is drunk!'+LF);
        oldhp:=P.HP;
        P.HP:=P.HP+(Die(3,3)*((P.Level div 2)+1));{remember to change in WINDATA!}
        IF P.HP > P.HPmax
           then P.HP:=P.HPmax;
        If bat
           then begin
           If bansi
              then gotomess;
           Cwriteln('`11The HEAL POTION healed '+Num2Str(P.HP-oldhp)+' HP.');
           If bansi
              then BDelay
              else begin
                   Cwriteln(LF);
                   Paw;
                   end;
           end
           else begin
           Cwriteln('`11The HEAL POTION healed '+Num2Str(P.HP-oldhp)+' HP.'+LF);
           Paw;
           end;
        Dec(P.Heal);
        end;

end;
{#######################################################################}
procedure ToggleANSI;
begin
     If Bansi
        then Bansi:=FALSE
        else Bansi:=TRUE;
end;
{#######################################################################}
procedure UpBull(s:string);
{Update Bulletin}
var f:file of char;
    lp:word;
    hs:string;
begin
     assign(f,'Bulletin.Ans');
     FMode(flWriteMode);
     reset(f);
     seek(f, filesize(f));
     for lp:=1 to length(s) do
         write(f,s[lp]);
     close(f);
end;
{#######################################################################}
procedure SendLine(u:word; s:string);
var f:file of char;
    lp:byte;

begin
     assign(f,'mail.'+st(u));
     FMode(flReadWrite+flDenyAll);
     If exist('mail.'+st(u))
        then reset(f)
        else rewrite(f);
     seek(F, Filesize(F));         {EOF}
     for lp:=1 to length(s) do
         write(f,s[lp]);
     close(f);
end;

{#######################################################################}
procedure MakeInUse;
{$I InUse.Dat}
var f:file of char;
    n:word;
begin
     assign(f,'InUse.Txt');
     FMode(flWriteMode);
     rewrite(f);
     For n:=1 to SizeOf(InUseAsc) do
         write(f,InUseAsc[n]);
     close(f);
end;
{#######################################################################}
procedure prop;
begin
     If MinLeft<10
        then Cwriteln('`007[`015'+num2str(Minleft)+'`007] Minutes Left!'+LF);
     If CPC.B3
        then begin
        Cwriteln('`10HP: '+st(CPC.HP)+'/'+st(CPC.HPMax)+' ('+cond(CPC.HP,CPC.HPMax));
        Cwriteln('`10) `11Potions: '+st(CPC.Heal));
        If CPC.MPmax>0
           then Cwriteln(' `9MP: '+st(CPC.MP)+'/'+st(CPC.MPMax));
        If CPC.TPmax>0
           then Cwriteln(' `14TP: '+st(CPC.TP)+'/'+st(CPC.TPMax));
        Cwriteln(' `13Gold/Bank: '+st(CPC.GP)+'/'+st(CPC.Bank)+LF);
        end;


     Cwriteln('`4What do you do, `012'+CPC.charname+'`004?'+acc0);
end;
{########################################################################}
procedure ShowBull;
var l:word;
begin
     For l:=1 to SizeOf(TopHead) do
         Cwrite(TopHead[l]);
     If exist('Bulletin.Old')
        then CSendDoc('Bulletin.Old');
     CsendDoc('Bulletin.Ans');
end;
{########################################################################}
procedure GetMon(index:word);
var fg:file of PC;
begin
     assign(fg, 'Monster.Rec');
     FMode(flReadMode);
     reset(fg);
     seek(fg,index-1);           {seek to location}
     read(fg, OPC);
     close(fg);
end;
{########################################################################}
function ChkPC(s:string;var P:PC):boolean;
var n:integer;
begin
     n:=vl(s);
     If not(between(n,1,maxpc))
        then ChkPC:=false
        else If PCexist(n)
                then ChkPC:=true
                else ChkPC:=false;
end;
{########################################################################}
{back stab engine}
procedure BackStab;
var d:word;
begin
     If (CPC.Class=3) and (CPC.TP>= (tpbackstab*OPC.Level) )
        then begin
        Cwriteln(LF+LF+'`11Do you wish to make a Back Stab attemp? `3[y/N]'+LF+LF);
        If upcase(Cread)='Y'
           then begin
           Cwriteln(LF+'`1You slowly go sneak up behind `009'+OPC.charname+'...'+LF);
           delay(fdelay*2);
           CPC.TP:=CPC.TP-tpbackstab*OPC.Level;
           If Die(1,20) >= (10+CPC.Level-OPC.Level)
              then begin
              d:=OPC.HP div 4;
              OPC.HP:=OPC.HP-d;
              If OPC.HP<=0
                 then OPC.HP:=1;
              Cwriteln('`10Success! You hit '+OPC.Charname+' for '+st(d)+' points of damage!'+LF+LF);
              Paw;
              end else begin
              Cwriteln('`12But '+OPC.CharName+' wakes up in time to defend against you!'+LF+LF);
              Paw;
              end;
           end;
        end;
end;
{########################################################################}


