(*const FS=LF+LF+'`12Only available at Five Starr (204) 623 0596'+LF;

function FiveStarr:boolean;
begin
     FiveStarr:=Exist('c:\r\renegade.exe');
end;*)


procedure DeBugA;
var f:text;
    r:byte;
begin
     assign(f,'DeBug.Txt');
     rewrite(f);
     writeln(f,'³DEBUG.TXT: Contains debugging info for ED&D');
     writeln(f,'³Alphas. If you have ANY trouble installing');
     writeln(f,'³ED&D on your BBS, please contact me (See DOCs).');
     writeln(f,'');
     writeln(f,'Cur time: ',CT_SDate,' ',CT_Time);
     writeln(f,'Cur version: ',version,' (',versionc,')');
     writeln(f,'');
     writeln(f,'Dropfile reads:');
     with dropfile do
          begin
          writeln(f,' User DATA: ',realname,',',username);
          writeln(f,' Port DATA: COMM',commport,' at ',commbaud,' {',userbaud,'} Node:',node);
          writeln(f,' Time: ',minleft,' Level',level,' Local View=',localview);
          writeln(f,' Local Mode=',local);
          end;
     writeln(f,'');
     writeln(f,'ANSI-Dected=',ANSI_Test);
     writeln(f,'In ED&D Dir=',exist('User.Rec'));
     asm{desq view}
        mov cx, 4445h
        mov dx, 5351h
        mov ax, 2B01h
        int 21h
        mov r, al
        end;
     writeln(f,'DESQView=',r<>$ff);
     writeln(f,'DOS ver: ',DOSVersion mod 256,'.',DOSversion div 256);
     close(f);
end;

(*procedure Sugg;
var s:string;
{$I Sugg.Dat} {crusader signature}
begin
     if not(fivestarr) then begin
        Cwriteln(FS);
        Paw;
        end else
     if (ups(dropfile.username)='CRUSADER')
        then begin
        If not(exist('Mail.999'))
           then begin
           Cwriteln('No sug.'+LF);
           Paw;
           end
           else begin
           CSendDoc('Mail.999');
           Cwriteln('`12Delete? (Y/N) '+LF);
           If upcase(Cread)='Y'
              then DelFile('Mail.999');
           end;
        end else begin
        Cwriteln(aclrscr+'`13Do you wish to send a note to ');
        CSendArray(Crusader);
        Cwriteln(' `13(Y/N)'+LF+LF);
        If upcase(Cread)='Y'
           then begin
           Cwriteln('`9Type in you message, press ENTER on a blank line to quit.`10'+LF);
           SendLine(999,'`14From '+dropfile.username+'`006'+LF);
           repeat
                 s:=Creadln(75);
                 SendLine(999,s+LF);
                 until s='';
           Cwriteln(LF+'`12Message send.'+LF);
           Paw;
           end;
        end;
end;

procedure EDDANSI_Send;
begin
     if not(fivestarr) then begin
        Cwriteln(FS);
        Paw;
        end else
     If dropfile.local
        then begin
        Cwriteln('`9You can''t download in local mode!'+LF);
        Paw;
        end else begin
        Cwriteln('`13ED&DANSI.ZIP ('+st(FSize('ED&DANSI.Zip')));
        Cwriteln(' bytes) `5is an archive containing all of the'+LF);
        Cwriteln('ANSI screens used in ED&D.'+LF+LF);
        Cwriteln('If you are an ANSI artist, or just have alot of ANSIs,'+LF);
        Cwriteln('then Download this file, and have a look.'+LF+LF);
        Cwriteln('Change any number of the screens and send back you modified'+LF);
        Cwriteln('files to CRUSADER, attached to E-Mail.'+LF+LF);
        Cwriteln('`13Do you want to download the file now with ZMODEM? (Y/N)'+LF);

        If Upcase(Cread)='Y'
           then begin
           TSaveScreen;
           Prog('ED&DANSI');
           TLoadScreen;
           Cwriteln(LF+LF+'`10Transfer Complete.'+LF);
           SendLine(999,'`013'+dropfile.username+' `5took ED&DANSI.ZIP at `013');
           SendLine(999,' '+CT_SDate+'  '+CT_Time+LF+LF);
           Paw;
           end;

        end;
end;*)
