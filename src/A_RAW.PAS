program A_conv;

{$I TypeHead.Pas}               {defs}

var A:armor;
    ft:text;
    f:file of armor;
    c:char;
    s:string;

procedure MakeRaw;

begin
     Assign(ft,'armor.Raw');
     Rewrite(ft);

     Assign(f,'armor.Rec');
     Reset(f);

     while not(eof(F)) do
           begin
           read(f,a);
           writeln(ft,'*************************Name********************************');
           writeln(ft,a.name);
           writeln(ft,'*Value');
           writeln(ft,a.val);
           writeln(ft,'*AC');
           writeln(ft,a.ac);
           writeln(ft,'*In store?');
           writeln(ft,a.inlist);
           writeln(ft,'*Race 0=Human, 1=Elf, 2=Dwarf, 3=Halfling, 4=Lizard Man');
           writeln(ft,a.race);
           writeln(ft,'*Class 0=Fighter, 1=Wizard, 2=Priest, 3=Theif');
           writeln(ft,a.class);
           end;

     close(f);
     close(ft);
end;

procedure MakeRec;

begin
     Assign(ft,'armor.Raw');
     Reset(ft);

     Assign(f,'armor.Rec');
     Rewrite(f);

     while not(eof(ft)) do
           begin
           readln(ft,s);
           readln(ft,a.name);
           readln(ft,s);
           readln(ft,a.val);
           readln(ft,s);
           readln(ft,a.ac);
           readln(ft,s);
           readln(ft,s);
           a.Inlist:= s='TRUE';
           readln(ft,s);
           readln(ft,a.race);
           readln(ft,s);
           readln(ft,a.class);

           write(f,a);
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
