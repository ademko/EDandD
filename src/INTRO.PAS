{introduction for ed&d}

procedure Intro;

{$I Info.Dat}   {disclaimer ANSI file}
{$I Daily.Pas}  {daily mantenece}

begin
     Randomize;
     MakeInUse;
     DelPC(1, CPC);

     SStat:=FALSE;
     {store prices}
     sellp:=Die(1,2)+1;
     {get color for statbar}
     stcol:=vl(Ini_Read(ininame, 'StatBarCol', '23') );
     InitBar(1, stcol);
     {# of fights/day}
     fightsaday:=vl(Ini_Read(ininame, 'FightsADay', '20') );
     {interest rate}
     bankrate:=vl(Ini_Read(ininame, 'Rate', '1') );
     {get top file name}
     TopFileName:=Ini_Read(ininame, 'TopFileName', 'TopScore.Ans');
     {Fdelay}
     FDelay:=vl(Ini_Read(ininame, 'FightDelay', '1200') );
     {days delete}
     daysdelete:=vl(Ini_Read(ininame, 'DaysBeforeDelete', '14') );
     {display ANSI??}
     Bansi:=FALSE;
     {max muders/day}
     maxpckill:=vl(Ini_Read(ininame, 'MaxPCKill', '3') );

     {daily maintanence}
     Daily;

     {PP:GP Ratio}
     PPGP:=vl(Ini_Read(ininame, 'PP', '5') );

     Cwriteln('`4'+Aclrscr);
     Bar;
     Cwriteln('ENHANCED DRAGONS AND DUNGEONS     ');
     Cwriteln('`7Version '+version+LF);

     CSendArray(Info); {Send Info.Dat}
     If ANSI_test
        then Cwriteln('`2ANSI Detected.'+LF);
     Paw;

     SendANS('Intro1','');
     Bar;
     Paw;
end;
