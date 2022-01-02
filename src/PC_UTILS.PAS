{delets a PC}

{$I DelPc.Pas}

{#####################################################################}
{Gets a PC type from USER.REC}
procedure GetPC(var PCGet:PC; index:word);
var fg:file of PC;
begin
     assign(fg, userrec);
     FMode(flReadMode);
     reset(fg);
     seek(fg,index-1);           {seek to location}
     read(fg, PCGet);
     close(fg);
end;
{#####################################################################}
{Puts a PC type to USERREC}
procedure PutPC(PCPut:PC; index:word);
var fg:file of PC;
begin
     assign(fg, userrec);
     FMode(flWriteMode);
     reset(fg);
     seek(fg,index-1);           {seek to location}
     write(fg, PCPut);
     close(fg);
end;
