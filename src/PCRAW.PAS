program RAWPC_conv;
uses Dos;
{$I TypeHead.Pas}
var filename, s1, s2:string[20];
    f:file of PC;
    p:PC;
    t:text;
    c1, c2:char;

{$I DelPc.Pas}
procedure MakeRaw;
begin
     assign(f,filename+'.REC');
     reset(f);
     assign(t,filename+'.RAW');
     rewrite(t);

     repeat
           read(f,p);

           writeln(t,'***************************User ID************************');
           writeln(t,p.UserID);
           writeln(t,'             UserName(none for monster)');
           writeln(t,p.username  );
           writeln(t,'             Character Name');
           writeln(t,p.charname  );
           writeln(t,'             Title(0 4 mon)');
           writeln(t,p.title     );
           writeln(t,'             Icon FileName');
           writeln(t,p.Icon      );
           writeln(t,'             Str(0 4 mon)');
           writeln(t,p.Str       );
           writeln(t,'             IQ (0 4 mon)');
           writeln(t,p.iq        );
           writeln(t,'             Wis(0 4 mon)');
           writeln(t,p.wis       );
           writeln(t,'             Dex(AVG=9)');
           writeln(t,p.dex       );
           writeln(t,'             Con(0 4 mon)');
           writeln(t,p.con       );
           writeln(t,'             Luc(0 4 mon)');
           writeln(t,p.luc       );
           writeln(t,'             Race 0=Human, 1=Elf, 2=Dwarf, 3=Halfling, 4=Lizard Man (0 4 mon)');
           writeln(t,p.race      );
           writeln(t,'             Class 0=Fighter, 1=Wizard, 2=Priest, 3=Theif (0 4 mon)');
           writeln(t,p.class     );
           writeln(t,'             XP Level');
           writeln(t,p.level     );
           writeln(t,'             XP (mon=XP val)');
           writeln(t,p.xp        );
           writeln(t,'             Goodess (0 4 mon)');
           writeln(t,p.good      );
           writeln(t,'             HP');
           writeln(t,p.hp        );
           writeln(t,'             HP max');
           writeln(t,p.hpmax     );
           writeln(t,'             MP');
           writeln(t,p.mp        );
           writeln(t,'             MP max');
           writeln(t,p.mpmax     );
           writeln(t,'             TP');
           writeln(t,p.tp        );
           writeln(t,'             TP max');
           writeln(t,p.tpmax     );
           writeln(t,'             Female??');
           writeln(t,p.female    );
           writeln(t,'             Days Missed');
           writeln(t,p.dateon    );
           writeln(t,'             Location (mon=home area)');
           writeln(t,p.loc       );
           writeln(t,'             GP(mon=reward)');
           writeln(t,p.gp        );
           writeln(t,'             PP(mon=reward)');
           writeln(t,p.pp        );
           writeln(t,'             Food(mon=reward)');
           writeln(t,p.food      );
           writeln(t,'             Fights(0 4 mon)');
           writeln(t,p.fights    );
           writeln(t,'             Heal(mon=reward)');
           writeln(t,p.heal      );
           writeln(t,'             bank(0 4 mon)');
           writeln(t,p.bank      );
           writeln(t,'             Weapon Name');
           writeln(t,p.Wname     );
           writeln(t,'             W-Discription');
           writeln(t,p.WDis      );
           writeln(t,'             W-Val(0 4 mon)');
           writeln(t,p.WVal      );
           writeln(t,'             W-Decap???');
           writeln(t,p.Wdecap    );
           writeln(t,'             Long range weapon??');
           writeln(t,p.Wrange    );
           writeln(t,'             # of Die');
           writeln(t,p.WDieNum   );
           writeln(t,'             Die type');
           writeln(t,p.WDie      );
           writeln(t,'             DieBonus');
           writeln(t,p.Wdiebon   );
           writeln(t,'             THAC0(AVG=20)');
           writeln(t,p.WTHACo    );
           writeln(t,'             Armor name');
           writeln(t,p.AName     );
           writeln(t,'             AC(AVG=10)');
           writeln(t,p.aac       );
           writeln(t,'             armor val (0 4 mon)');
           writeln(t,p.aval      );
           writeln(t,'             ANSI?');
           writeln(t,p.ans      );
           writeln(t,'             Battel Delay m/s');
           writeln(t,p.fdelay   );
           writeln(t,'             B1:Banished?');
           writeln(t,p.b1      );
           writeln(t,'             B2:Battle Pause');
           writeln(t,p.B2      );
           writeln(t,'             B3:StatBar?');
           writeln(t,p.b3      );
           writeln(t,'             I1:baud');
           writeln(t,p.i1      );
           writeln(t,'             I2:Deeds');
           writeln(t,p.i2      );
           writeln(t,'             I3:Death toll, 4 day');
           writeln(t,p.i3      );
           writeln(t,'             S1:last date on');
           writeln(t,p.s1      );
           writeln(t,'             S2:when defeated string');
           writeln(t,p.s2     );
           writeln(t,'             S3:very first day on.');
           writeln(t,p.s3    );
           until eof(f);

     close(f);
     close(t);
end;

procedure MakeRec;
var s:string;
begin
     assign(f,filename+'.REC');
     assign(t,filename+'.RAW');
     reset(t);
     rewrite(f);

     repeat
           readln(t,s);
           readln(t,p.userid     );
{*}           DelPC(P.userID, p);
           readln(t,s);
           readln(t,p.username   );
           readln(t,s);
           readln(t,p.charname   );
           readln(t,s);
           readln(t,p.title      );
           readln(t,s);
           readln(t,p.icon       );
           readln(t,s);
           readln(t,p.str        );
           readln(t,s);
           readln(t,p.iq         );
           readln(t,s);
           readln(t,p.wis        );
           readln(t,s);
           readln(t,p.dex        );
           readln(t,s);
           readln(t,p.con        );
           readln(t,s);
           readln(t,p.luc        );
           readln(t,s);
           readln(t,p.race       );
           readln(t,s);
           readln(t,p.class      );
           readln(t,s);
           readln(t,p.level      );
           readln(t,s);
           readln(t,p.xp         );
           readln(t,s);
           readln(t,p.good       );
           readln(t,s);
           readln(t,p.hp         );
           readln(t,s);
           readln(t,p.hpmax      );
           readln(t,s);
           readln(t,p.mp         );
           readln(t,s);
           readln(t,p.mpmax      );
           readln(t,s);
           readln(t,p.tp         );
           readln(t,s);
           readln(t,p.tpmax      );
           readln(t,s);
           readln(t,s);
           p.female:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,p.dateon     );
           readln(t,s);
           readln(t,p.loc        );
           readln(t,s);
           readln(t,p.gp         );
           readln(t,s);
           readln(t,p.pp         );
           readln(t,s);
           readln(t,p.food       );
           readln(t,s);
           readln(t,p.fights     );
           readln(t,s);
           readln(t,p.heal       );
           readln(t,s);
           readln(t,p.bank       );
           readln(t,s);
           readln(t,p.wname      );
           readln(t,s);
           readln(t,p.wdis       );
           readln(t,s);
           readln(t,p.wval       );
           readln(t,s);
           readln(t,s);
           p.Wdecap:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,s);
           p.Wrange:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,p.wdienum    );
           readln(t,s);
           readln(t,p.wdie       );
           readln(t,s);
           readln(t,p.wdiebon    );
           readln(t,s);
           readln(t,p.wthaco     );
           readln(t,s);
           readln(t,p.aname      );
           readln(t,s);
           readln(t,p.aac        );
           readln(t,s);
           readln(t,p.aval       );
           readln(t,s);
           readln(t,s);
           p.ans:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,p.fdelay);
           readln(t,s);
           readln(t,s);
           p.b1:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,s);
           p.b2:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,s);
           p.b3:=(s='TRUE') or (s='True') or (s='true');
           readln(t,s);
           readln(t,p.i1);
           readln(t,s);
           readln(t,p.i2);
           readln(t,s);
           readln(t,p.i3);
           readln(t,s);
           readln(t,p.s1);
           readln(t,s);
           readln(t,p.s2);
           readln(t,s);
           readln(t,p.s3);

           write(f, p);
           until eof(t);

     close(f);
     close(t);
end;


begin
     writeln('PCRAW U|M C|W');
     writeln('U=user M=monster C=Rec W=Raw');

     if paramcount=2
        then begin

        s1:=Paramstr(1);
        s2:=paramstr(2);
        c1:=upcase(s1[1]);
        c2:=upcase(s2[1]);

        If c1='U'
           then filename:='User';
        If c1='M'
           then filename:='Monster';
        If c2='C'
           then makerec;
        If c2='W'
           then makeraw;

        end;
end .


