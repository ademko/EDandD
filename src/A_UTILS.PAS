{A Utils}
{##########################################################}
procedure A_load(idx:word; var a:armor);

var f:file of armor;

begin
     assign(f, 'Armor.Rec');
     FMode(flReadMode);
     reset(f);
     seek(f,idx-1);
     read(f,a);
     close(f);
end ;

{##########################################################}
procedure A_save(idx:word; var a:armor);

var f:file of armor;

begin
     assign(f, 'Armor.Rec');
     FMode(flWriteMode);
     reset(f);
     seek(f,idx-1);
     write(f,a);
     close(f);
end ;
