program PCEditor;
uses crt,
     windows, pix, utils;

const ver='1.00';

var scancode:boolean;
    userrec:string;

{$I TypeHead.Pas}
{$I PC_Utils.Pas}

{##########################################################################}
{$L PCE-Main.Obj}
procedure pcemain; external;
{$L PCE-Misc.Obj}
procedure pcemisc; external;

procedure PopMess(s:string);
begin
     TSaveScreen;
     Win_Zoom(37 - (length(s) div 2),10,37 - (length(s) div 2)+length(s)+2,12,23,4,15);
     Write(s);
     Delay(900);
     TloadScreen;
end;

procedure ShowObj(p:pointer);
var pp:PTScreen;

begin
     PP:=P;
     TScreen^:=PP^;
end;

function ReadC:char;
var c:char;
begin
     c:=readkey;
     if c=#0
        then begin
        c:=readkey;
        scancode:=true;
        end else scancode:=false;
     ReadC:=c;
end;
{###########################################################################}

procedure ShowPC(var P:PC);
begin
     textattr:=13;
     gotoxy(11,2); write(P.UserID);
     gotoxy(12,3); write(P.UserName);
     gotoxy(18,4); write(P.CharName);
     gotoxy(9,5); write(P.title);
     gotoxy(13,6); write(P.icon);
     gotoxy(7,7); write(P.str);
     gotoxy(7,8); write(P.iq);
     gotoxy(7,9); write(P.wis);
     gotoxy(7,10); write(P.dex);
     gotoxy(7,11); write(P.con);
     gotoxy(8,12); write(P.luc);
     gotoxy(9,13); write(P.race);
     gotoxy(10,14); write(P.class);
     gotoxy(10,15); write(P.level);
     gotoxy(7,16); write(P.xp);
     gotoxy(13,17); write(P.good);
     gotoxy(7,18); write(P.hp);
     gotoxy(11,19); write(P.hpmax);
     gotoxy(7,20); write(P.mp);
     gotoxy(11,21); write(P.mpmax);
     gotoxy(7,22); write(P.tp);
     gotoxy(11,23); write(P.tpmax);
     gotoxy(11,24); write(P.female);
     gotoxy(16,25); write(P.dateon);
     gotoxy(54,3); write(P.loc);
     gotoxy(50,4); write(P.gp);
     gotoxy(54,5); write(P.pp);
     gotoxy(50,6); write(P.food);
     gotoxy(57,7); write(P.fights);
     gotoxy(58,8); write(P.heal);
     gotoxy(56,9); write(P.bank);
     gotoxy(57,10); write(P.wname);
     gotoxy(59,11); write(P.wdis);
     gotoxy(61,12); write(P.wval);
     gotoxy(58,13); write(P.wdecap);
     gotoxy(56,14); write(P.wrange);
     gotoxy(54,15); write(P.wdienum);
     gotoxy(54,16); write(P.wdie);
     gotoxy(58,17); write(P.wdiebon);
     gotoxy(51,18); write(P.wthaco);
     gotoxy(56,19); write(P.aname);
     gotoxy(48,20); write(P.aac);
     gotoxy(61,21); write(P.aval);
     gotoxy(65,22); write(P.b1);
     gotoxy(56,23); write(P.i2);
     gotoxy(64,24); write(P.i3);
     gotoxy(45,25); write(P.s2);
end;

procedure ShowMisc(var P:PC);
begin
     textattr:=13;
     gotoxy(16,3); write(P.I1);
     gotoxy(14,4); write(P.S1);
     gotoxy(14,5); write(P.S3);
end;

procedure EditF(var P:PC; sel:byte);

function EditS(sel:byte; d:string):string;
var s:string;
begin
     Win_Zoom(5,10,75,13,23,1,10);
     writeln('Editing Field #',sel,':');
     Cursor(CurFull);
     readln(s);
     if s=''
        then s:=d;
     if s=' '
        then s:='';
     EditS:=s;
end;

begin
     TSaveScreen;
     case sel of
          1:P.UserName:=EditS(sel, P.UserName);
          2:P.Charname:=EditS(sel, P.charname);
          3:P.title:=EditS(sel, P.title);
          4:P.icon:=EditS(sel, P.icon);
          5:P.str:=vl(EditS(sel, st(P.str) ));
          6:P.iq:=vl(EditS(sel, st(P.iq) ));
          7:P.wis:=vl(EditS(sel, st(P.wis) ));
          8:P.dex:=vl(EditS(sel, st(P.dex) ));
          9:P.con:=vl(EditS(sel, st(P.con) ));
          10:P.luc:=vl(EditS(sel, st(P.luc) ));
          11:P.race:=vl(EditS(sel, st(P.race) ));
          12:P.class:=vl(EditS(sel, st(P.class) ));
          13:P.level:=vl( EditS(sel, st(P.level) ) );
          14:P.xp:=vl( EditS(sel, st(P.xp) ) );
          15:P.good:=vl( EditS(sel, st(P.good) ) );
          16:P.hp:=vl( EditS(sel, st(P.hp) ) );
          17:P.hpmax:=vl( EditS(sel, st(P.hpmax) ) );
          18:P.mp:=vl( EditS(sel, st(P.mp) ) );
          19:P.mpmax:=vl( EditS(sel, st(P.mpmax) ) );
          20:P.tp:=vl( EditS(sel, st(P.tp) ) );
          21:P.tpmax:=vl( EditS(sel, st(P.tpmax) ) );
          22:P.female:=not(P.female);
          23:P.dateon:=vl( EditS(sel, st(P.dateon) ) );
          24:P.loc:=vl( EditS(sel, st(P.loc) ) );
          25:P.gp:=vl( EditS(sel, st(P.gp) ) );
          26:P.pp:=vl( EditS(sel, st(P.pp) ) );
          27:P.food:=vl( EditS(sel, st(P.food) ) );
          28:P.fights:=vl( EditS(sel, st(P.fights) ) );
          29:P.heal:=vl( EditS(sel, st(P.bank) ) );
          30:P.bank:=vl( EditS(sel, st(P.bank) ) );
          31:P.wname:=EditS(sel, P.wname );
          32:P.wdis:=EditS(sel, P.wdis );
          33:P.wval:=vl( EditS(sel, st(P.wval) ) );
          34:p.wdecap:=not(p.wdecap);
          35:p.wrange:=not(p.wrange);
          36:P.wdienum:=vl( EditS(sel, st(P.wdienum) ) );
          37:P.wdie:=vl( EditS(sel, st(P.wdie) ) );
          38:P.wdiebon:=vl( EditS(sel, st(P.wdiebon) ) );
          39:P.wthaco:=vl( EditS(sel, st(P.wthaco) ) );
          40:P.aname:=EditS(sel, P.aname );
          41:P.aac:=vl( EditS(sel, st(P.aac) ) );
          42:P.aval:=vl( EditS(sel, st(P.aval) ) );
          43:P.b1:=not(P.b1);
          44:P.i2:=vl( EditS(sel, st(P.i2) ) );
          45:P.i3:=vl( EditS(sel, st(P.i3) ) );
          46:P.s2:=EditS(sel, P.s2 );
          end;
     TLoadScreen;
end;

procedure main;
var c:char;
    s:string;
    n:byte;
    CPC:word;
    P:PC;
    modi:boolean;
begin
     GetPC(P,1);
     c:=' ';
     CPC:=1;
     n:=0;
     modi:=false;
     repeat
           ShowObj(@PCEMain);
           ShowPC(p);
           c:=ReadC;

           If scancode and ((c=#75) or (c=#77))
              then begin
              If modi
                 then PutPC(P,CPC);
              if (c=#75) and (CPC>1)
                 then dec(CPC);
              if (c=#77) and (CPC<maxpc)
                 then inc(CPC);
              GetPC(P,CPC);
              end;

           If (c=#59) and scancode
              then begin
              ShowObj(@PCEMisc);
              ShowMisc(p);
              ReadC;
              end;

           if between(ord(c), 48, 57) and not(scancode)
              then begin
              TSaveScreen;
              Win_Zoom(30,11,50,13,23,2,10);
              write('Edit #',c);
              Cursor(CurFull);
              s:=c;
              c:=ReadC;
              s:=s+c;
              n:=vl(s);
              TLoadScreen;
              editf(p,n);
              modi:=true;
              end;
           until c=#27;
     If modi
        then PutPC(P,CPC);
end;

begin
     TSaveScreen;

     userrec:='User.Rec';
     if (ups(paramstr(1))='/'+chr(127 XOR 50))
        then userrec:='Monster.Rec';

     PopMess(' Enhanced Dragons And Dungeaons Player Editor - version '+ver);

     If exist('User.Rec') and exist('Monster.rec')
        then Main
        else PopMess(' ERROR: REC files not found!');

     TloadScreen;
     Cursor(CurNorm);
end .

