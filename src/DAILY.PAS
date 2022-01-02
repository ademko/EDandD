procedure daily;

function checkifrun:boolean;
var d, m, y:integer;
begin
     y:=vl(Ini_Read(ininame,'DY','1'));
     m:=vl(Ini_Read(ininame,'DM','1'));
     d:=vl(Ini_Read(ininame,'DD','1'));
     If not((d=CT_d) and (m=CT_m) and (y=CT_y))
        then begin
        Ini_Write(ininame,'DY',st(CT_Y));
        Ini_Write(ininame,'DM',st(CT_M));
        Ini_Write(ininame,'DD',st(CT_D));
        checkifrun:=TRUE;
        end
        else checkifrun:=FALSE;
end;

procedure DoDaily;
var lp:word;
    f:file of char;
    hs:string;
begin
     Cwriteln(aclrscr+'þ Running daily maintenence...'+LF);

     {Bulletin reset}
     If exist('Bulletin.Old')
        then DelFile('Bulletin.Old');
     If exist('Bulletin.Ans')
        then RenFile('Bulletin.Ans','Bulletin.Old');
     assign(f,'Bulletin.Ans');
     FMode(flWriteMode);
     rewrite(f);
     hs:=amoveright(22)+'`14News for '+CT_Sdate+LF+LF;
     For lp:=1 to length(hs) do
         write(f,hs[lp]);
     close(f);

     {PP valule change}
     Ini_Write(ininame,'PP',st(Die(1,6)+4));

     {Cindy Reset}
     Ini_Write(ininame,'Cindy','0');

     {PC fix}
     For lp:=1 to maxpc do
         begin
         GetPC(OPC,lp);
         If OPC.username<>''
            then begin

            {bump up day}
            Inc(OPC.DateOn);

            {bank iterest}
            OPC.bank:=trunc( (1+(bankrate)*0.01)*OPC.bank );

            {reset kill counter}
            OPC.I3:=0;

            {fight, deeds/day}
            OPC.fights:=FightsADay;
            OPC.I2:=FightsADay div 2;

            {hunger strike??}
            If OPC.HP>0
               then If OPC.food>=OPC.level
                       then OPC.food:=OPC.food-OPC.level
                       else begin
                       SendLine(OPC.UserID,LF+LF+'`140Hunger Strike! Need food soon...'+LF+LF);
                       OPC.food:=0;
                       OPC.HP:=1;
                       OPC.MP:=0;
                       OPC.TP:=0;
                       end;

            {is he free loading in the inn???, delete when hit 2}
            IF (OPC.dateon>1) and between(OPC.Loc,101,105)
               then begin
               OPC.loc:=1;
               SendLine(OPC.UserID,LF+LF+'`10The Inn keeper kicked you out of his Inn!'+LF);
               SendLine(OPC.UserID,'`2 "And stay out, you good for nothing freeloader!"'+LF+LF);
               end;

            {check for delete}
            If (OPC.dateon>daysdelete) Or (OPC.B1{banished?})
               then begin
               Cwriteln('  Deleted: '+OPC.charname+'!'+LF);
               If exist('Mail.'+num2str(lp))
                  then DelFile('Mail.'+num2str(lp));
               DelPC(lp, OPC);
               end;

            PutPC(OPC, lp);
            end;
         end;

     Cwriteln('  done!'+LF);
end;

begin
     If checkifrun
        then DoDaily;
end;
