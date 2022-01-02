{#################################################################}
{Used for ED&D}
{Structures for a PC, monster and weapon/armor}

const maxpc=100;                   {max # of PCs}
      maxw=50;                    {max # of Ws}
      maxa=50;                    {max # of As}
      maxmon=100;                 {max # of monsters}
      maxpate=10;                 {max # of patrons}

Type
{#####################################################################}
          PC=Record
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
{*}                               :LongInt;

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
{*}                               :LongInt;

          {PC's Weapon}
          WName                   {Name of weapon}
                                  :String[25];
          WDis                    {Discription when attacking}
                                  :String[80];
          WVal                    {It's value in gp}
{*}                               :LongInt;
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
{*}                               :LongInt;

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
          Weapon=Record
          Name                    {name of weapon}
                                  :string[25];
          Dis                     {discription}
                                  :string[80];

          Val                     {Selling val}
                                  :Word;
          DieNum,                 {Number od Die}
          Die,                    {Die Type}
          DieBon                  {Bonus Damage}
                                  :Byte;
          Thaco                   {thac0}
                                  :integer;
          Range,                  {Range weapon}
          Decap,                  {decapatation?}
          InList                  {In the For Sale List?}
                                  :Boolean;

          Race                    {Races that can Use}
                                  :String[5];
          Class                   {Class that can Use}
                                  :String[4];

                                  end;

{############################################################}
          Armor=Record
          Name                    {name of armor}
                                  :string[25];
          Val                     {Selling val}
                                  :Word;
          InList                  {In the For Sale List?}
                                  :Boolean;
          Race                    {Races that can Use}
                                  :String[5];
          Class                   {Class that can Use}
                                  :String[4];
          AC                      {AC Mod}
                                  :Integer;

                                  end;

{############################################################}
          Patron=Record{Inn Patrons}
          Who,
          What                     :String[75];
                                   end;
{############################################################}

