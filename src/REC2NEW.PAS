program Rec2New;
uses utils;

{$I TypeHead.Pas}

type
{#####################################################################}
          PCOld=Record
          UserID                  {ID Num}
                                  :Word;
          UserName,               {BBS Name}
          CharName,               {PC's name}
          Title,                  {Character Class title}
          Icon                    {File name for Icon}
                                  :String[40];

          Str,                    {Atributes}
          IQ,
          Wis,
          Dex,
          Con,
          Luc
                                  :Byte;

          Race,                   {Race: 0=Human, 1=Elf,}
                                  {2=Dwarf, 3=Halfling, 4=Lizard Man}
          Class,                  {Class: 0=Fighter, 1=Wizard,}
                                  {2=Priest, 3=Theif}
          Level                   {XP Level}
                                  :Byte;
          XP                      {XP Points}
                                  :LongInt;

          Good,                   {alighnment}
          HP,
          HPMax,                  {Hit Points}
          MP,
          MPMax,                  {Magic Points}
          TP,
          TPMax                   {Theif Points}
                                  :Integer;

          Female                  {Female?}
                                  :Boolean;
          DateOn,                 {How many days missed, -1=killed}
          Loc                     {location, 1=outside,
                                             99=dead,
                                             101-105=inn(dif levels)}
                                  :Integer;

          Gp,                     {cash; gold & platinum}
          Pp,
          Food,                   {number of food units}
          Fights,                 {number of battles left 4 day}
          Heal,                   {healing potions}
          Bank                    {GP in bank}
                                  :Word;

          {PC's Weapon}
          WName                   {Name of weapon}
                                  :String[25];
          WDis                    {Discription when attacking}
                                  :String[80];
          WVal                    {It's value in gp}
                                  :Word;
          WDecap,                 {decapatation?}
          WRange                  {Long distance?}
                                  :Boolean;
          WDieNum,                {Number od Die}
          WDie,                   {Die Type}
          WDieBon                 {Bonus Damage}
                                  :Byte;
          WThaco                  {Thac0}
                                  :Integer;

          {PS's Armor}
          AName                   {Name of armor}
                                  :string[25];
          AAC                     {Armor Class}
                                  :integer;
          AVal                    {value in gp}
                                  :Word;

          {Config}
          ans                     {ANSI, extended?}
                                  :Boolean;
          fdelay                  {battle delay}
                                  :word;

          {Xtras}
          B1, {banished?}
          B2, {batttle pause}
          B3  {stat bar?} :Boolean;
          I1, {baud rate}
          I2, {deeds left}
          I3  {how many PC murdered today}:longint;
          S1, {last dateon}
          S2, {when murdered string}
          S3  { [1]=E(killed king, [2]=G(killed dragon) user's first day on}
                                   :string[40];
                                  end; {PC}
{############################################################}

procedure pcold2new(var po:pcold; var pn:pc);
begin
     with pn do
          begin
          userid:=po.userid;
          username:=po.username;
          charname:=po.charname;
          title:=po.title;
          icon:=po.icon;
          str:=po.str;
          iq:=po.iq;
          wis:=po.wis;
          dex:=po.dex;
          con:=po.con;
          luc:=po.luc;
          race:=po.race;
          class:=po.class;
          level:=po.level;
          xp:=po.xp;
          good:=po.good;
          hp:=po.hp;
          hpmax:=po.hpmax;
          mp:=po.mp;
          mpmax:=po.mpmax;
          tp:=po.tp;
          tpmax:=po.tpmax;
          female:=po.female;
          dateon:=po.dateon;
          loc:=po.loc;
          gp:=po.gp;
          pp:=po.pp;
          food:=po.food;
          fights:=po.fights;
          heal:=po.heal;
          bank:=po.bank;
          wname:=po.wname;
          wdis:=po.wdis;
          wval:=po.wval;
          wdecap:=po.wdecap;
          wrange:=po.wrange;
          wdienum:=po.wdienum;
          wdie:=po.wdie;
          wdiebon:=po.wdiebon;
          wthaco:=po.wthaco;
          aname:=po.aname;
          aac:=po.aac;
          aval:=po.aval;
          ans:=po.ans;
          fdelay:=po.fdelay;
          b1:=po.b1;
          b2:=po.b2;
          b3:=po.b3;
          i1:=po.i1;
          i2:=po.i2;
          i3:=po.i3;
          s1:=po.s1;
          s2:=po.s2;
          s3:=po.s3;
          end;
end;

var fr:file of pcold;
    fw:file of pc;
    cpcold:pcold;
    cpc:pc;
    i:byte;

begin
     writeln('Converts <0.99 User.Rec & Monster.Rec TO NEW RECS');
     writeln;
     if not(exist(paramstr(1)))
        then writeln('Syntax: REC2NEW <old_pc_rec_file> <file_2_creat>')
        else begin
        assign(fr, paramstr(1)); reset(fr);
        assign(fw, paramstr(2)); rewrite(fw);
        write('Working on entry #');
        i:=0;
        repeat
              inc(i);
              write(i:3,#8,#8,#8);
              read(fr, cpcold);
              pcold2new(cpcold, cpc);
              write(fw, cpc);
              until eof(fr);
        writeln;
        close(fr);
        close(fw);
        end;

end .

