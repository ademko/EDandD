procedure ViewChar;

begin
     SendANS('CSheet','');
     Bar;

     {Icon}
     Cwriteln(agotoxy(1,2));
     SendANS(CPC.icon,'');

     Cwriteln(agotoxy(53,2)+Acolor(abold,amagenta,ablack)+CPC.username);
     Cwriteln(agotoxy(53,3)+CPC.charname);
     Cwriteln(Agotoxy(53,4)+CPC.title);

     Cwriteln(acolor(anormal,acyan,ablack)+agotoxy(50,6)+num2str(CPC.Str));
     Cwriteln(agotoxy(50,7)+num2str(CPC.IQ ));
     Cwriteln(agotoxy(50,8)+num2str(CPC.Wis));
     Cwriteln(agotoxy(72,6)+num2str(CPC.Dex));
     Cwriteln(agotoxy(72,7)+num2str(CPC.Con));
     Cwriteln(agotoxy(72,8)+num2str(CPC.Luc));

     Cwriteln(acolor(abold,agreen,ablack)+agotoxy(44,10)+Srace[CPC.race]);
     Cwriteln(agotoxy(69,10)+SClass[CPC.class]);
     Cwriteln(acolor(anormal,agreen,ablack)+agotoxy(44,11)+num2str(CPC.level));
     Cwriteln(agotoxy(69,11)+num2str(CPC.XP)+agotoxy(44,12));
     If CPC.female
        then Cwrite('F')
        else Cwrite('M');
     Cwriteln(agotoxy(69,12)+num2str(CPC.good));
     Cwriteln(agotoxy(69,19)+aAtr(12)+st( LReq[CPC.Level+1] ));

     Cwriteln(agotoxy(20,11)+Cond(CPC.HP,CPC.HPMax));
     Cwriteln(acolor(anormal,ared,ablack));
     Cwriteln(acolor(abold,ared,ablack)+agotoxy(20,13)+num2str(CPC.hp)+'/'+num2str(CPC.HPMax));
     Cwriteln(acolor(abold,ablue,ablack)+agotoxy(20,14)+num2str(CPC.mp)+'/'+num2str(CPC.mPMax));
     Cwriteln(acolor(abold,agreen,ablack)+agotoxy(20,15)+num2str(CPC.tp)+'/'+num2str(CPC.tPMax));

     Cwriteln('`010'+agotoxy(20,17)+num2str(CPC.GP));
     Cwriteln(' `002('+st(CPC.Bank)+')`010');
     Cwriteln(agotoxy(20,18)+num2str(CPC.PP));
     Cwriteln(agotoxy(20,19)+num2str(CPC.food));
     Cwriteln(agotoxy(20,20)+num2str(CPC.heal));

     Cwriteln(acolor(anormal,amagenta,ablack)+agotoxy(47,14)+CPC.Wname);
     Cwriteln(agotoxy(47,15)+CPC.AName);

     Cwriteln(acolor(abold,ared,ablack)+agotoxy(47,17)+num2str(CPC.Wthaco));
     Cwriteln(agotoxy(47,19)+num2str(CPC.AAC));
     Cwriteln(agotoxy(71,17)+yesno(CPC.WDecap)+agotoxy(71,18)+yesno(CPC.WRange));
     Cwriteln(agotoxy(47,18));
     if CPC.Wdienum>1
        then Cwriteln(num2str(CPC.WDieNum));
     Cwriteln('d'+num2str(CPC.Wdie));
     if CPC.Wdiebon>0
        then Cwriteln('+'+num2str(CPC.Wdiebon));

     Cwriteln(acolor(abold,awhite,ablack)+agotoxy(69,23)+lpad(st(Minleft),4));


     GotoMess;
     Paw;
End;
