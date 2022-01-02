{$M 16384, 0, 200000}
{Enhanced Dragons & Dungeons, By Alex Demko.
 First swing at making a door game with the DoorLib unit}

Program Edd_Door_Game;
Uses DoorLib, ANSI,
     Crt, Dos,{version det}
     Ini, Utils, TimeDate,
     ErrorMan, FileLock,
     Pix;{update menu}

{$I TypeHead.Pas} {record defs}

const version='1.02 Beta';              {Version Number}
      versionc='January, 1995';          {compiled at??}
      ininame='Ed&d.Ini';               {name of INI file}
      userrec='User.Rec';               {file that holds users}
      mpheal=3;                         {MP cost of: HEAL}
      mpfire=3;                         {MP cost of: Fire}
      tpbackstab=10;                    {backstab cose/level}
      Abord=LF+'`4Aborted.'+LF;         {abord string}
      MGap=2;                           {You have to be <OPC.Level+MGap to attack}
      WinLevel=13;                      {level to try to win game}

      sclass:array [0..3] of string[8] ={consts for class & race strings}
                   ('Fighter',
                   'Wizard',
                   'Priest',
                   'Thief');
      srace:array [0..4] of string[10]=
                  ('Human',
                  'Elf',
                  'Dwarf',
                  'Halfling',
                  'Lizard Man');

      FArea:array [1..6] of string[20] ={dirferent battle areas!}
                  ('Forest',
                  'Mountains',
                  'Graveyard',
                  'Vulcano',
                  'Fire Brand''s Lair',
                  'King Durak''s Castle');

      MVerb=8;{max verbs!}
      Verb:array [1..MVerb] of string[18] =
                 ('howled','yelled','said','replied','responded',
                 'remarked','groaned','answered');

      MTit=10;{max titles}
      Tit:array [1..MTit] of string[40] =
                ('Unknown',
                'New Warrior',
                'Trained Adventurer',
                'Experianced Adventurer',
                'Skilled Adventurer',
                'Respected Adventurer',
                'Popular Warrior',
                'Deadly Warrior',
                'Masterfull Warrior',
                'Master');

      MMStr=10;{max default murder string!}
      MStr:array [1..MMStr] of string[39] =
                 ('I''ll get you next time!',
                 'Hahahahahaha!!!',
                 'Is that the best you could do?',
                 'Next time don''t cheat!',
                 'Fool! I was only toying with you!',
                 'Scum! Scum! You dirty sum!',
                 'I wasn''t even ready!',
                 'You just wait....',
                 'Revenge...I need revenge....',
                 'Blast you!');
      MCin=6;
      Cin:array [1..MCin] of string[20] =
                ('wink at her','blow her a kiss','squeeze her ass',
                'make sexual gestures','give her a big kiss','take her upstairs');

      {XP needed}
      MLevel=20;{maximun level attainable}
      LReq:Array [2..20] of longint=(200,500,1000,2000,4000,
                           8000,16000,32000,64000,130000,
                           250000,500000,1000000,2000000,4000000,
                           8000000,16000000,32000000,50000000);

{$I PClist.Dat}                         {PCList Header}
{$I TopHead.dat}                        {header, ED&D mini logo!}

var stcol:integer;                      {statbar's color}
    CPC:PC;                             {current player}
    OPC:PC;                             {Other PC, multiple useses}
    fightsaday:integer;                 {# of fights a day}
    daysdelete:integer;                 {number of days before delete}
    W:weapon;                           {weapon}
    a:armor;                            {armor}
    sellp:byte;                         {selling multiplyer}
    bankrate:integer;                   {bank's interest rate}
    PPGP:integer;                       {value of a PP, in GP}
    TopFileName:String;                 {filename of topscore file}
    fdelay:integer;                     {fight delay}
    Bansi:boolean;                      {display long ANSI}
    SStat:boolean;                      {show PC stat in Bar?}
    maxpckill:integer;                  {max killes per day}


{###############################################################}
{Includes}

{$I Pop.Pas}            {Popular Functions}
{$I ViewChar.Pas}       {view a character}
{$I Fight.Pas}          {fighting engine}
{$I WinData.Pas}        {After math data}
{$I Intro.Pas}          {Intro screens}
{$I MainMenu.Pas}       {Main Menu}
{$I MainLoop.Pas}       {MAIN Loop}



{###############################################################}
{Main Body}

begin
     {CRC8 Tests Here.}
     ShutUp;            {turn on system}

     If not(exist('InUse.Txt')){Multi Node!}
        then begin
        Intro;             {intro screens & make INUSE.TXT}
        While MainMenu do  {Main Loop}
              MainLoop;    {Core}

        DelFile('InUse.Txt');{delete Inuse.Txt, session over}
        end
        else begin
        CSendFile('InUse.Txt');{In Use!}
        Paw;
        end;

     ShutDown;          {shutdown}
end .
