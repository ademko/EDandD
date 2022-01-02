{cleans out user defined record types}


{###############################################################}
{cleans out a PC type}
procedure DelPC(id:integer; var PC2kill:PC);
begin
     FillChar(PC2Kill,SizeOf(PC2Kill),0);
     PC2Kill.UserID:=id;
end;

{###############################################################}
procedure DelW(var W_to_use:Weapon);
{cleans out a Weapon type}

begin
     With W_to_use do
          begin
          Name:='';
          Dis:='Attacks';
          Val:=0;
          DieNum:=1;
          Die:=4;
          DieBon:=0;
          Thaco:=20;
          Range:=FALSE;
          Decap:=FALSE;
          Inlist:=FALSE;
          Race:='01234';
          Class:='0123';
          end;
end;

{###############################################################}
procedure DelA(var A_2_use:armor);
{deletes a armor}

begin
     with A_2_use do
          begin
          name:='';
          Val:=0;
          InList:=FALSE;
          Race:='01234';
          Class:='0123';
          AC:=0;
          end;
end;

