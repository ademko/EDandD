{Main Engine}
procedure MainLoop;

var c:char;

{$I LoadChar.Pas}  {character loading reading routines}
{$I ItemHead.Dat}  {Item list Header}
{$I W_Shop.Pas}    {weapon shop}
{$I A_Shop.Pas}    {armor shop}
{$I TownChos.Pas}  {other, smaller chioces}
{$I Inn.Pas}       {the INN}
{$I MailMenu.Pas}  {mail menu}
{$I OutSide.Pas}   {The OutSide world!}
{$I Config.Pas}    {configuration}

begin
     If LoadChar
        then begin
             {load user configs}
             fdelay:=CPC.fdelay;
             bansi:=not(CPC.ans);
             SStat:=True;
             CPC.I1:=dropfile.userbaud;
             CPC.S1:=CT_Sdate;

             ShowBull;
             If exist('Mail.'+num2str(CPC.UserID))
                then begin
                Cwriteln(LF+LF+'`10You have mail today!');
                Cwriteln(LF+'Go to the Post Office to read it.'+LF);
                Bar;
                Paw;
                end;

             {Town Menu}
             repeat
                   SendANS('TownMenu','Town of Solace');
                   Bar;
                   Prop;
                   c:=Upcase(Cread);
                   PutPC(CPC,CPC.UserID);{New safety feature!}

                   case c of
{CRUSADER cheat********}'~':if (ups(dropfile.username)='CRUSADER') or (ups(dropfile.username)='ALEX DEMKO')
                               then CPC.GP:=CPC.GP+2000;
                        'C':OutSide;
                        'M':MailMenu;
                        'T':ShowTop;
                        'V':ViewChar;
                        'I':Inn;
                        'W':WeaponShop;
                        'A':ArmorShop;
                        'H':CastHeal(CPC, FALSE);
                        'U':DrinkPotion(CPC, FALSE);
                        'G':WizShop;
                        'D':CsendDoc('Online.Doc');
                        'K':HealTemple;
                        'B':Bank;
                        'J':Config;
                        'S':Deeds;
                        '?':SendANS('Townmenu','?');
                        end;

                   until (c='Q') or (Minleft<=0) or (CPC.loc<>0);
             If CPC.loc=0
                then CPC.loc:=1;
             end;
     SStat:=FALSE;
     Bar;

     If CPC.loc<>0                      {stuff to do, ie. clean up}
        then PutPC(CPC, CPC.userID);
     UpTop;             {update list}

     Paw;
end;
