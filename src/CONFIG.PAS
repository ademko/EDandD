procedure Config;
var c:char;
    n:integer;
    su:boolean;

begin
     repeat
           Cwriteln(aclrscr+acolor(abold,agreen,ablack)+'System Configuration:'+LF);
           Bar;
           Cwriteln(acc0+acc(agreen)+'ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ'+LF+acc(acyan));
           Cwriteln(' Current version           : '+version+LF);
           Cwriteln(' Compiled at               : '+versionc+LF);
           Cwriteln(' Max # of Players          : '+Num2str(MaxPc)+LF);
           Cwriteln(' Fights a day              : '+num2str(fightsaday)+LF);
           Cwriteln(' Days before user deleted  : '+num2str(daysdelete)+LF);
           Cwriteln(' Bank Interest (%)         : '+num2str(bankrate)+LF);
           Cwriteln(LF+'`010'+CPC.charname+'''s Options:'+LF);
           Cwriteln('`002'+repstr('Ä',length(CPC.charname))+'ÄÄÄÄÄÄÄÄÄÄÄ'+LF);
           Cwriteln('`011 1)`003 Extendend ANSI                  : `011'+yesno(not(bansi))+LF);
           Cwriteln('`011 2)`003 Fighting message delay (ms)     : `011'+num2str(fdelay)+LF);
           Cwriteln('`011 3)`003 When murdered reply             : `011'+CPC.S2+LF);
           Cwriteln('`011 4)`003 Pause Between Fighting message? : `011'+yesno(CPC.B2)+LF);
           Cwriteln('`011 5)`003 Quick Stat Bar                  : `011'+yesno(CPC.B3)+LF);
           Cwriteln('`12 *)`4 Nuke this character and start over...'+LF);
           Cwriteln('`011 Q)`003 Quit'+LF);
           Cwriteln(LF+acc0+acc(ayellow)+' Enter choice: '+acc0);
           c:=Upcase(Cread);
           Cwriteln(LF+LF);
           case c of
                '1':ToggleANSI;
                '2':begin
                         Cwriteln(' `2Enter new value: `010');
                         n:=str2num(Creadln(5));
                         if between(n,0,10000)
                            then fdelay:=n
                            else begin
                                 Cwriteln(Abord);
                                 Paw;
                                 end;
                         end;
                '3':begin
                         Cwriteln('`002 Enter new murder string: `010');
                         CPC.S2:=Creadln(33);
                         end;
                '4':begin
                         If CPC.B2
                            then CPC.B2:=false
                            else CPC.B2:=true;
                         end;
                '5':begin
                         if CPC.B3
                            then CPC.B3:=false
                            else CPC.B3:=true;
                         end;
                '*':begin
                         su:=FALSE;
                         Cwriteln('`140WARNING! WARNING! WARNING!'+LF);
                         Cwriteln('`12=========================='+LF);
                         Cwriteln('`4If you continue you current character'+LF);
                         Cwriteln('will be banished from the realm FOREVER.'+LF);
                         Cwriteln('You will then be able to make a new character'+LF);
                         Cwriteln('tommorow...'+LF+LF);
                         Cwriteln('`12Are you sure you want to commit suicide? (Y/N)'+LF);
                         su:=Upcase(Cread)='Y';
                         If su
                            then begin
                            Cwriteln('`Are you `140REALLY `12sure? (Y/N)'+LF);
                            su:=Upcase(Cread)='Y';
                            end;
                         If su
                            then begin
                            Cwriteln(LF+'`2The gods take pitty on you worthless soul,'+LF);
                            Cwriteln('and bannish it from the realm forever.'+LF);
                            Cwriteln('`10You may be riencarnated tommorow.'+LF);
                            UpBull('`010'+CPC.charname+'`2 has cowardly comited suicide!!'+LF+LF);
                            CPC.loc:=99;
                            CPC.B1:=TRUE;
                            c:='Q';
                            Paw;
                            end;
                         end;

                end;
           until (c='Q') or (minleft<=0);
     CPC.fdelay:=fdelay;
     CPC.ans:=not(bansi);
end;
