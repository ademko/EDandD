procedure WeaponShop;

var c:char;

function show:boolean;
{conpare if cPC is able to Use Weapon}
var s:boolean;
begin
     {check $$$}
     s:= W.val*sellp <= CPC.GP;
     {check race}
     If s then
           s:=pos(st(CPC.race),W.race)<>0;
     If s then
           s:=pos(st(CPC.class),W.class)<>0;
     if (s) and (W.Name='')
        then s:=FALSE;
     if (s) and (W.Name='Hands')
        then s:=FALSE;
     show:=s;
end;


procedure List_W;
var lp, lp2:word;
    gp:longint;
    bn, bl:boolean;
begin
        CsendArray(ItemHead);
        Bar;
        lp2:=3;
        for lp:=1 to maxw do
            begin
            W_load(lp,W);
            bn:=show;
            gp:=CPC.GP;
            CPC.GP:=60000;
            bl:=show;
            CPC.GP:=gp;
            If (W.Inlist)
               then begin
               Inc(lp2);
               Cwriteln('`003'+rPad(num2str(lp),5)+rPad(num2str(w.Val*sellp),14));
               Cwriteln('`011'+rPad(w.name,36)+'`003'+rPad(yesno(bn),12));
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

procedure BuyW;
var
    st:string;
begin
     W_load(1,W);
     If CPC.WName <> W.Name
        then begin
        List_W;
        Cwriteln('`5You must sell your weapon first!'+LF);
        Paw;
        end
        else
        begin
        List_W;
        Cwriteln('`13Enter the number of the weapon [abort]: ');
        St:=Creadln(3);
        If (St<>'') and ((str2num(St)>0) and (str2num(St)<=MaxA))
           then begin
           W_load(Str2Num(st),w);
           If show
              then begin
              W2PC(CPC);
              CPC.GP:=CPC.GP-(W.val*sellp);
              end
              else Cwriteln(LF+'`12You can''t afford that!'+LF);
           end;
        Paw;
        end;{if then}
end;

Procedure SellW;
var rc:char;
begin
     W_load(1,W);
     If CPC.Wval>0
        then begin
        Cwriteln(LF+'`9Tell ''ya what; since it''s been used, I''ll'+LF);
        Cwriteln('give you '+num2str(CPC.WVal)+' GP.'+LF);
        Cwriteln('What you say? `1(Y/N)'+LF);
        rc:=Upcase(Cread);
        If rc='Y'
           then begin
           Cwriteln(LF+'`10Thanks great warrior!'+LF);
           CPC.GP:=CPC.GP+CPC.WVal;
           W2PC(CPC);
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
           SendANS('W_Shop','Weapon Shop');
           Bar;
           Prop;
           c:=Upcase(Cread);

           Case c of
                'V':ViewChar;
                'B':BuyW;
                'S':SellW;
                '?':SendANS('W_shop','?');
                end;

           until (c='Q') or (Minleft<=0);
end;

