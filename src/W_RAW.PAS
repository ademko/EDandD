program W_conv;

{$I TypeHead.Pas}               {defs}

var w:weapon;
    ft:text;
    f:file of weapon;
    c:char;
    s:string;

procedure MakeRaw;

begin
     Assign(ft,'Weapon.Raw');
     Rewrite(ft);

     Assign(f,'Weapon.Rec');
     Reset(f);

     while not(eof(F)) do
           begin
           read(f,w);
           writeln(ft,'**************************Name*****************************');
           writeln(ft,w.name);
           writeln(ft,'*Discription');
           writeln(ft,w.dis);
           writeln(ft,'*Value');
           writeln(ft,w.val);
           writeln(ft,'*# of Die');
           writeln(ft,w.dienum);
           writeln(ft,'*Die type');
           writeln(ft,w.die);
           writeln(ft,'*DIe bonus');
           writeln(ft,w.diebon);
           writeln(ft,'*THACO');
           writeln(ft,w.thaco);
           writeln(ft,'*Range');
           writeln(ft,w.range);
           writeln(ft,'*Decap');
           writeln(ft,w.decap);
           writeln(ft,'*In store?');
           writeln(ft,w.inlist);
           writeln(ft,'*Race 0=Human, 1=Elf, 2=Dwarf, 3=Halfling, 4=Lizard Man');
           writeln(ft,w.race);
           writeln(ft,'*Class 0=Fighter, 1=Wizard, 2=Priest, 3=Theif');
           writeln(ft,w.class);
           end;

     close(f);
     close(ft);
end;

procedure MakeRec;

begin
     Assign(ft,'Weapon.Raw');
     Reset(ft);

     Assign(f,'Weapon.Rec');
     Rewrite(f);

     while not(eof(ft)) do
           begin
           readln(ft,s);
           readln(ft,w.name);
           readln(ft,s);
           readln(ft,w.dis);
           readln(ft,s);
           readln(ft,w.val);
           readln(ft,s);
           readln(ft,w.dienum);
           readln(ft,s);
           readln(ft,w.die);
           readln(ft,s);
           readln(ft,w.diebon);
           readln(ft,s);
           readln(ft,w.thaco);
           readln(ft,s);
           readln(ft,s);
           w.range:= s='TRUE';
           readln(ft,s);
           readln(ft,s);
           w.decap:= s='TRUE';
           readln(ft,s);
           readln(ft,s);
           w.inlist:= s='TRUE';
           readln(ft,s);
           readln(ft,w.race);
           readln(ft,s);
           readln(ft,w.class);

           write(f,w);
           end;

     close(f);
     close(ft);
end;

begin
     If paramstr(1)='REC'
        then makerec;
     If paramstr(1)='RAW'
        then makeraw;
     writeln('Options: RAW or REC (ie. file to make)');
end .
