procedure MailMenu;
var c:char;

procedure ReadMail;
begin
     If not(exist('Mail.'+Num2Str(CPC.UserID)))
        then begin
        cwriteln(LF+LF+'`11You don''t have any mail to read!'+LF);
        Paw;
        end
        else CsendDOC('Mail.'+Num2Str(CPC.UserID));
end;

procedure DelMail;
begin
     If not(exist('Mail.'+Num2Str(CPC.UserID)))
        then cwriteln(LF+LF+'`11You have no mail to delete!'+LF)
        else begin
        cwriteln(LF+LF+'`11Mail deleted.'+LF);
        DelFile('Mail.'+Num2Str(CPC.UserID));
        end;
     Paw;
end;

procedure SendMail;
var n:byte;
    s:string;
begin
     cwriteln(aclrscr);
     Bar;
     Cwriteln('`4Send mail to which player [ID#] : `012');
     N:=vl(Creadln(3));
     Cwriteln(LF+LF);
     If not((n>0) and (n<=maxpc))
        then cwriteln(abord)
        else if not(PCexist(n))
             then cwriteln(abord)
             else begin                      {mail sending}
                  Cwriteln('`3Sending mail to:`011 '+OPC.charname+LF);
                  Cwriteln('`3Press ENTER on a blank line when finished...`002'+LF+LF);
                  SendLine(n,LF);
                  SendLine(n,'`003Mail from:`011 '+CPC.charname+'`003 on '+CT_Sdate+LF);
                  SendLine(n,RepStr('Ä',60)+'`002'+LF);
                  CEditTextFile('MAIL.'+st(n),75,25);
                  Cwriteln(LF+LF+'`11Done.'+LF);
                  end;
     Paw;
end;

procedure Post;
begin
     Cwriteln(aclrscr+'`5Type in you post; 2 lines, 75 chars/line max:`13'+LF);
     Bar;
     UpBull('`009'+CPC.charname+' makes an anouncement:`001'+LF);
     UpBull(' '+Creadln(75)+LF);
     UpBull(' '+Creadln(75)+LF+LF);
     Cwriteln(LF+LF+'`005Posted!'+LF);
     Paw;
end;

procedure NameC;
var c:boolean;
    p:word;
begin
     p:=CPC.Level*100;
     Cwriteln(LF+'`2It'' difficult to change a popular warrior''s name,'+LF);
     Cwriteln('for you, it''ll cost ''ya '+st(p)+' GP.'+LF);
     Cwriteln('Do you still want your name changed? `10(Y/N)'+LF);
     c:=Upcase(Cread) = 'Y';
     If c then
     If (CPC.gp<p)
        then begin
        Cwriteln('Your to poor!'+LF);
        Paw;
        end
        else begin
        Cwriteln('`3OK! What will be your new name?`11'+LF);
        CPC.charname:=Creadln(16);
        Cwriteln('Done!');
        Paw;
        CPC.gp:=CPC.GP-p;
        end;
end;

begin
     repeat
           SendANS('MailMenu','Local Post Office');
           Bar;
           Prop;
           c:=upcase(Cread);
           case c of
                'R':readmail;
                'D':delmail;
                'S':SendMail;
                'B':ShowBull;
                'P':Post;
                'N':NameC;
                '?':SendANS('MailMenu','?');
                end;

           until (C='Q') or (minleft<=0);
end;
