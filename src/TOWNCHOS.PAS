{HEALing temple}
procedure HealTemple;

var c:char;

procedure HealALL;
var can:boolean;
    pri:longint;
    ali:string[40];
    c:char;
begin
     can:=TRUE;
     if CPC.HP>=CPC.HPmax
        then begin
        Cwriteln(LF+'`9You look healthy and are not in need of our services.....'+LF);
        can:=FALSE;
        end;
     if can
        then begin
        if CPC.good<0
           then begin
           pri:=(CPC.HPmax-CPC.HP)*5;
           ali:='evil one';
           end;
        if (CPC.good>=0) and (CPC.good<10000)
           then begin
           pri:=CPC.HPmax-CPC.HP;
           ali:='good citizen';
           end;
        if CPC.good>=10000
           then begin
           pri:=0;
           ali:='honorary hero';
           end;
        if pri<>0
           then begin
           Cwriteln('`3Greetings `11'+ali+'`3, your cost is `011'+num2str(pri)+'`3GP,'+LF);
           Cwriteln('for the services of god.....'+LF);
           Cwriteln('`10Do you wish to donate? `2(Y/N)'+LF);
           c:=Upcase(Cread);
           if c='Y'
              then if CPC.gp < pri
                   then begin
                   Cwriteln('`12You insult us and our god with such a'+LF);
                   Cwriteln('Donation!'+LF);
                   end else begin
                   Cwriteln('`9Thank you, kind warrior......'+LF);
                   CPC.HP:=CPC.HPmax;
                   CPC.gp:=CPC.gp-pri;
                   end;
           end
           else begin{if saint}
           Cwriteln('`13For a '+ali+' like yourself, our services are free of charge.'+LF);
           CPC.HP:=CPC.HPmax;
           end;
        end;
     Paw;
end;

procedure GiveDon;
var d:longint;
begin
     Cwriteln('`2How many GPs do you want to donate? `010');
     d:=vl(Creadln(5));
     if not((d>0) and (d<=CPC.GP))
        then begin
        Cwriteln('`12You insult us and our god with such a'+LF);
        Cwriteln('Donation!'+LF);
        end else begin
        Cwriteln('`9Thank you, kind warrior......'+LF);
        CPC.GP:=CPC.GP-d;
        CPC.good:=CPC.good+d;
        end;
     Paw;
end;

procedure GetMP;
var co:longint;
begin
     If not(CPC.class=2)
        then begin
        Cwriteln(LF+'`12Your are not of our priest hood!');
        Cwriteln(LF+'How dare you make a request for our MP!'+LF);
        Paw;
        end
        else begin
        co:=CPC.level*(CPC.MPMax-CPC.MP);
        Cwriteln(LF+'`2It will require a donation of `010'+st(co)+'`2 GPs,'+LF);
        Cwriteln('`10Do you wish to make the donation? `2(Y/N)'+LF);
        If not(Upcase(Cread)='Y')
           then begin
           Cwriteln('`9Thank you, kind warrior......'+LF);
           Paw;
           end
           else If not(CPC.gp>=co)
                   then begin
                   Cwriteln('`12You insult us and our god with such a'+LF);
                   Cwriteln('petty donation!'+LF);
                   Paw;
                   end
                   else begin
                   Cwriteln('`9Thank you brother '+CPC.charname+'.'+LF);
                   Paw;
                   CPC.GP:=CPC.GP-co;
                   CPC.MP:=CPC.MPmax;
                   end;
        end;
end;

begin
     repeat
           SendANS('Temple','Healing Temple');
           Bar;
           Prop;
           c:=Upcase(Cread);
           writeln(LF);

           case c of
                'H':HealAll;
                'G':GiveDon;
                'V':ViewChar;
                'M':GetMP;
                '?':SendANS('Temple','?');
                end;
           until (MinLeft<=0) or (c='Q');
end;


{Bank}
procedure Bank;
var c:char;
    n:longint;
    s:string;

procedure Deposit;
begin
     if CPC.GP<=0
        then Cwriteln(LF+'`12You have no GP left!'+LF)
        else begin
             Cwriteln(LF+'`2How much would you like to deposit? ');
             Cwriteln('[ENTER for all '+num2str(CPC.GP)+' GP] : `010');
             s:=Creadln(8);
             If s=''
                then n:=CPC.GP
                else n:=vl(s);
             if not( (n>0)and(n<=CPC.GP) )
                then Cwriteln(Abord)
                else begin
                     CPC.GP:=CPC.GP-n;
                     CPC.bank:=CPC.bank+n;
                     Cwriteln(LF+'`13Deposited '+num2str(n)+' GP into your account.'+LF);
                     end;
             end;
     Paw;
end;

procedure WithDraw;

begin
     if CPC.bank=0
        then Cwriteln(LF+'`12You have no GP left!'+LF)
        else begin
             Cwriteln(LF+'`2How much would you like to withdraw? ');
             Cwriteln('[ENTER for all '+num2str(CPC.bank)+' GP] : `010');
             s:=Creadln(8);
             If s=''
                then n:=CPC.bank
                else n:=vl(s);
             if not( (n>0)and(n<=CPC.bank) )
                then Cwriteln(LF+'`4Aborded.'+LF)
                else begin
                     CPC.GP:=CPC.GP+n;
                     CPC.bank:=CPC.bank-n;
                     Cwriteln(LF+'`13Withdrew '+num2str(n)+' GP from your account.'+LF);
                     end;
             end;
     Paw;
end;

Procedure Rates;
Begin
     SendANS('Rates','');
     Bar;
     Cwriteln(Agotoxy(38,2)+Acolor(abold,amagenta,ablack)+num2str(sellp));
     Cwriteln(Agotoxy(38,3)+Acolor(abold,amagenta,ablack)+num2str(bankrate));
     Cwriteln(Agotoxy(38,4)+Acolor(abold,amagenta,ablack)+num2str(PPGP));
     Cwriteln(Agotoxy(1,20));
     Paw;
end;

procedure Tran;
var n, n2:longint;
begin
     Cwriteln(LF+'`1Enter the user''s ID Number: `009');
     n:=str2num(Creadln(3));
     if not((n>0)and(n<=maxpc)) or (n=CPC.UserID)
        then cwriteln(LF+'`4Aborded.'+LF)
        else if not(PCexist(n))
             then Cwriteln(LF+'`4Aborded.'+LF)
             else begin
                  GetPC(OPC,n);
                  Cwriteln(LF+'`2Transfering to: `010'+OPC.charname+LF);
                  Cwriteln('`2Transfer how many GPs? : `010');
                  n2:=str2num(Creadln(8));
                  if not((n2>0) and (n2<=CPC.bank))
                     then Cwriteln(LF+'`4Aborded.'+LF)
                     else begin
                     CPC.bank:=CPC.bank-n2;
                     OPC.bank:=OPC.bank+n2;
                     PutPC(OPC,n);
                     Cwriteln(LF+'`010GPs transfered succesfully.'+LF);
                     SendLine(n,LF+'`015'+CPC.charname+' `7transfered `015'+num2str(n2)+' GP `7into your account.'+LF+LF);
                     end;
                  end;
     Paw;
end;

procedure BuyP;
var max, en:longint;
    s:String;
begin
     max:=CPC.GP div PPGP;
     Cwriteln(LF+'`6How much platinum do you want? [ENTER for all '+num2str(max)+'] : `014');
     s:=Creadln(8);
     If s=''
        then en:=max
        else en:=vl(s);
     If not((en>0) and (en<=max))
        then Cwriteln(LF+'`4Aborded.'+LF)
        else begin
        CPC.GP:=CPC.GP-(en*PPGP);
        CPC.PP:=CPC.PP+en;
        Cwriteln(LF+'`12Bought '+st(en)+' PP!'+LF);
        end;
     Paw;
end;

procedure SellP;
var max, en:longint;
    s:string;
begin
     max:=CPC.PP;
     Cwriteln(LF+'`6How much platinum do you want to sell? [ENTER for all '+num2str(max)+'] : `014');
     s:=Creadln(8);
     If s=''
        then en:=max
        else en:=vl(s);
     If not((en>0) and (en<=max))
        then Cwriteln(LF+'`4Aborded.'+LF)
        else begin
        CPC.GP:=CPC.GP+(en*PPGP);
        CPC.PP:=CPC.PP-en;
        Cwriteln(LF+'`12Sold '+st(en)+' PP!'+LF);
        end;
     Paw;
end;

begin
     repeat
           SendANS('Bank','Bank Menu');
           Cwriteln('`2Cash in hand   : `010'+Num2Str(CPC.GP)+' GP.'+LF);
           Cwriteln('`2Cash in account: `010'+Num2Str(CPC.Bank)+' GP.'+LF);
           bar;
           Prop;

           c:=upcase(Cread);
           case c of
                'D':Deposit;
                'W':WithDraw;
                'V':ViewChar;
                'R':Rates;
                'T':Tran;
                'B':BuyP;
                'S':SellP;
                '?':SendANS('Bank','?');
                end;
           until (c='Q') or (Minleft<=0);
end;

procedure WizShop;
var c:char;

function Buy(pr:word; a:integer):integer;{CPC}
var n:longint;
begin
     Buy:=a;
     Cwriteln(LF+'`1How many do you want? (Max='+st(CPC.GP div pr)+') :`009');
     n:=vl(Creadln(5));
     if (n*pr>0) and (n*pr<=CPC.GP)
        then begin
        Cwriteln(LF+'`14Thanks!'+LF);
        CPC.GP:=CPC.GP-(N*pr);
        Buy:=A+N;
        end
        else Cwriteln(abord);
     Paw;
end;
procedure AddMP;
var co:longint;
begin
     if not(CPC.class=1)
        then begin
        Cwriteln(LF+'`4You are not a Wizard!'+LF);
        Paw
        end
        else begin
        co:=CPC.level*(CPC.MPMax-CPC.MP)*2;
        Cwriteln(LF+'`2It will require a donation of '+st(co)+' GPs to the'+LF);
        Cwriteln('wizardry school, do you wish to donate? (Y/N)'+LF);
        If Upcase(Cread)='Y'
           then begin
           If co>CPC.GP
              then begin
              Cwriteln('`12Get out, you poor street beggar!'+LF);
              Paw;
              end
              else begin
              Cwriteln('`10Thank you......'+LF);
              Paw;
              CPC.GP:=CPC.GP-co;
              CPC.MP:=CPC.MPmax;
              end;
              end;
        end;
end;

procedure AddTP;
var co:longint;
begin
     If CPC.class<>3
        then begin
        Cwriteln(LF+'`2Your are NOT a theif, there for it would be wasted'+LF);
        Cwriteln('on you!'+LF);
        Paw;
        end
        else begin
        co:=CPC.level*(CPC.TPMax-CPC.TP)*2;
        Cwriteln(LF+'`2To drink out of the cauldrin, it''ll cost ''ya'+LF);
        Cwriteln(st(co)+' GPs. Do you still want to drink? (Y/N)'+LF);
        If Upcase(Cread)='Y'
           then begin
           If co>CPC.GP
              then begin
              Cwriteln('`12Get out, you poor street beggar!'+LF);
              Paw;
              end
              else begin
              Cwriteln('`10Thank you......'+LF);
              Paw;
              CPC.GP:=CPC.GP-co;
              CPC.TP:=CPC.TPmax;
              end;
           end;
        end;
end;

procedure CBall;{Crystal Ball}
var c:longint;
    T:PC;{temp}
begin
     Cwriteln(LF+'`12Who do you wish to spy on? `4(ID #):`012 ');
     If ChkPC(Creadln(3),OPC)
        then begin
        c:=OPC.level*100;
        IF CPC.GP<c
           then begin
           Cwriteln(LF+'`10Sorry, your a bit short of the '+st(c)+' GPs'+LF);
           Cwriteln('required. Come back when you have '+st(c-CPC.GP)+' more'+LF);
           Cwriteln('GPs.'+LF);
           Paw;
           end
           else begin
           SendANS('CBall','');
           Cwriteln(LF+'`12Oh magical crystal ball,'+LF);
           delay(fdelay);
           Cwriteln('`13Show me one, show me all...'+LF);
           delay(fdelay);
           Cwriteln('`14Tell us about those we seek,'+LF);
           delay(fdelay);
           Cwriteln('`10Please crystall ball, just one peek!'+LF);
           Paw;
           CPC.GP:=CPC.GP-c;
           {Swap PCs}
           T:=CPC;
           CPC:=OPC;
           CPC.username:='Not Shown';
           ViewChar;
           {back to norm!}
           CPC:=T;
           end;
        end else begin
        Cwriteln(LF+LF+'`4Aborded.'+LF);
        Paw;
        end;
end;

begin
     repeat
           SendANS('WizShop','Wizardry Shop');
           Bar;
           Prop;

           c:=upcase(Cread);
           case c of
                'H':CPC.heal:=Buy(10, CPC.heal);
                'F':CPC.food:=Buy(5, CPC.food);
                'M':AddMP;
                'T':AddTP;
                'B':CBall;
                'V':ViewChar;
                '?':SendANS('WizShop','?');
                end;
           until (C='Q') or (Minleft<=0);
end;

procedure Deeds;{Good n' evil deeds!}
var c:Char;

procedure Qcash(n:byte);
const dv:array [1..3] of string[30]=('person to snach','person to mug','bank to rob');
var dif, v:word;
begin
     dif:=Pow(8,n);
     If (CPC.good*-1)<dif
        then begin
        Cwriteln('`11You don''t have enough guts to do that!'+LF);
        Paw;
        end
        else begin
        Dec(CPC.I2);
        CPC.Good:=CPC.Good-n;
        Cwriteln('`12You look for a '+dv[n]+' and evntually you find'+LF);
        Cwriteln('one. You get ready to get the loot...'+LF);
        Delay(fdelay);
        If Die(1,4)<=3
           then begin
           v:=Pow(8,n);
           Cwriteln('`12You got the loot valued at '+num2str(v)+' GP!'+LF);
           Paw;
           CPC.GP:=CPC.GP+v;
           end else begin
           Cwriteln('`141Your busted!'+LF);
           Cwriteln('`13You''ll have to fight your way out of trouble!'+LF);
           Paw;
           GetMon(70+n);
           case Fight Of
                  1:WinE;
                  2:LosE;
                  3:RunE;
                  end;
           end;
        end;
end;

procedure GivePoor;
begin
     If CPC.Good<8
        then begin
        Cwriteln('`12Your are too mean and cheap to give your money away!'+LF);
        Paw;
        end else If CPC.GP<1
                 then begin
                 Cwriteln('`11You don''t have any gold to give!'+LF);
                 Paw;
                 end else begin
                 Dec(CPC.I2);
                 Cwriteln('`10You give some poor street beggar a Gold Piece,'+LF);
                 Cwriteln('watching his face light up with joy.'+LF);
                 CPC.Good:=CPC.Good+2;
                 Dec(CPC.GP);
                 Paw;
                 end;
end;

procedure GiveBlood;
begin
     If CPC.Good<Pow(8,2)
        then begin
        Cwriteln('`12Your are too cheap to give your blood away!'+LF);
        Paw;
        end else If CPC.HP<=1
                 then begin
                 Cwriteln('`11You can''t give blood in your week condition!'+LF);
                 Paw;
                 end else begin
                 Dec(CPC.I2);
                 Cwriteln('`10You donate blood to the local blood bank,'+LF);
                 Cwriteln('knowing that it might just save a life.'+LF);
                 Inc(CPC.Good);
                 Dec(CPC.HP);
                 Paw;
                 end;
end;

procedure HitMan;
var dif:word;
begin
     dif:=Pow(8,4);
     If (CPC.good*-1)<dif
        then begin
        Cwriteln('`11You don''t have enough guts to do that!'+LF);
        Paw;
        end
        else begin
        Dec(CPC.I2);
        CPC.Good:=CPC.Good-4;
        Cwriteln('`4You go to the local crook''s hang outs to see if'+LF);
        Cwriteln('you can find any potencial customers. After about an'+LF);
        Cwriteln('hour or so of hunting you find and angered man...'+LF+LF);
        delay(fdelay);
        Cwriteln('`12"Yeah, I got somebody you could get rid off...'+LF);
        Cwriteln('He lives on the other side or town, he should be'+LF);
        Cwriteln('sleeping right now...here is the address..'+LF+LF);
        delay(fdelay);
        Cwriteln('`4You take the paper eagerly and begin your'+LF);
        Cwriteln('search for the man. The house was not hard to find,'+LF);
        Cwriteln('and you figure this to be easy cash...'+LF);
        Paw;
        GetMon(74);
        case Fight Of
                  1:WinE;
                  2:LosE;
                  3:RunE;
                  end;
        end;
end;

procedure CapF(n:byte);
var dif:word;
begin
     n:=n-4;
     dif:=Pow(8,n);
     If CPC.good<dif
        then begin
        Cwriteln('`12You are not brave enough!'+LF);
        Paw;
        end else begin
        Dec(CPC.I2);
        CPC.good:=CPC.good+n;
        Cwriteln('`011The king welcomes you and greatfull takes you'+LF);
        Cwriteln('up on you offering. He is happy to find that a'+LF);
        Cwriteln('precstigios warrior like you, wants to help a'+LF);
        Cwriteln('good cause. He gives you a map and sends you on you way'+LF);
        Paw;
        GetMon(72+n);
        case Fight Of
                  1:WinE;
                  2:LosE;
                  3:RunE;
                  end;
        end;
end;

begin
     repeat
           SendANS('Deeds','Deeds Menu');
           Cwriteln('`4Deeds left: `012'+st(CPC.I2)+LF);
           Prop;
           c:=Upcase(Cread);
           Cwriteln(LF);

           case c of
                '1'..'8':If CPC.I2<=0
                            then begin
                                 Cwriteln(LF+'`11Your to tired...'+LF);
                                 Paw;
                                 end else begin
                                 case c of
                                      '1'..'3':QCash(str2num(c));
                                      '4':HitMan;
                                      '5':GivePoor;
                                      '6':GiveBlood;
                                      '7','8':CapF(vl(c));
                                      end;
                                 end;
                'V':ViewChar;
                'H':CastHeal(CPC, FALSE);
                'U':DrinkPotion(CPC, FALSE);
                '?':SendANS('Deeds','?');
                end;
           until (c='Q') Or (MinLeft<=0) Or (CPC.loc<>0);

end;
