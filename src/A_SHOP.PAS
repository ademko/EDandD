procedure ArmorShop;

var c:char;

function show:boolean;
{conpare if cPC is able to Use Weapon}
var s:boolean;
begin
     {check $$$}
     s:= a.val*sellp <= CPC.GP;
     {check race}
     If s then
           s:=pos(num2str(CPC.race),a.race)<>0;
     If s then
           s:=pos(num2str(CPC.class),a.class)<>0;
     if (s) and (A.Name='')
        then s:=FALSE;
     if (s) and (A.Name='Skin')
        then s:=FALSE;
     show:=s;
end;

procedure List_A;
var lp,lp2:word;
    gp:longint;
    bn, bl:boolean;
begin
        CsendArray(ItemHead);
        Bar;
        lp2:=3;
        for lp:=1 to maxa do
            begin
            a_load(lp,a);
            bn:=show;
            gp:=CPC.GP;
            CPC.GP:=60000;
            bl:=show;
            CPC.GP:=gp;
            If (A.InList)
               then begin
               Inc(lp2);
               Cwriteln('`003'+rPad(num2str(lp),5)+rPad(num2str(a.Val*sellp),14));
               Cwriteln('`011'+rPad(a.name,36)+'`003'+rPad(yesno(bn),12));
               Cwriteln(rPad(yesno(bl),5)+LF);
               If lp2 mod 22=0
                  then begin
                  Cwriteln(asavepos);
                  Paw;
                  Cwriteln(aloadpos+adelline);
                  lp2:=1;
                  end;
               end;
            end;
end;

procedure BuyA;
var st:string;

begin
     A_load(1,a);
     If CPC.AName <> a.Name
        then begin
        List_A;
        Cwriteln('`5You must sell your armor first!'+LF);
        Paw;
        end
        else
        begin
        List_A;
        Cwriteln('`13Enter the number of the armor [abort]: ');
        St:=Creadln(3);
        If (St<>'') and ((str2num(St)>0) and (str2num(St)<=MaxA))
           then begin
           A_load(Str2Num(st),a);
           If show
              then begin
              A2PC(CPC);
              CPC.GP:=CPC.GP-(a.val*sellp);
              end
              else Cwriteln(LF+'`12You can''t afford that!'+LF);
           end;
        Paw;
        end;{if then}
end;

Procedure Sella;
var rc:char;
begin
     a_load(1,a);
     If CPC.aval>0
        then begin
        Cwriteln(LF+'`9Tell ''ya what; since it''s been used, I''ll'+LF);
        Cwriteln('give you '+num2str(CPC.aVal)+' GP.'+LF);
        Cwriteln('What you say? `1(Y/N)'+LF);
        rc:=Upcase(Cread);
        If rc='Y'
           then begin
           Cwriteln(LF+'`10Thanks great warrior!'+LF);
           CPC.GP:=CPC.GP+CPC.aVal;
           a2PC(CPC);
           end;
        end
        else{if he has HANDS}
        begin
        Cwriteln(LF+'`12You don''t have anything to sell!'+LF);
        end;
     Paw;
end;


begin
     repeat
           SendANS('A_Shop','Armor Shop');
           Bar;
           Prop;
           c:=Upcase(Cread);

           Case c of
                'V':ViewChar;
                'B':BuyA;
                'S':SellA;
                '?':SendANS('A_Shop','?');
                end;

           until (c='Q') or (Minleft<=0);
end;

