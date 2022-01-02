{MainMenu**************************}

function MainMenu:Boolean;

var enc:char;

{$I HallFame.Pas}       {Hall o' Fame}

begin
     repeat

     SendANS('MainMenu','');
     Bar;

     enc:=Upcase(Cread);
     Case enc of
          {E enter realm}
          'A':CSendDoc('ANSICred.Ans');
          'D':CSendDoc('online.doc');
          'B':ShowBull;
          'T':ShowTop;
          'H':VHallFame;
          {Q Quit}
          end;

     until (enc='E') or (enc='Q') or (MinLeft <=0);

     MainMenu:= enc='E';

end;
