{W Utils}
{##########################################################}
procedure W_load(idx:word; var w:weapon);

var f:file of weapon;

begin
     assign(f, 'Weapon.Rec');
     FMode(flReadMode);
     reset(f);
     seek(f,idx-1);
     read(f,w);
     close(f);
end ;

{##########################################################}
procedure W_save(idx:word; var w:weapon);

var f:file of weapon;

begin
     assign(f, 'Weapon.Rec');
     FMode(flWriteMode);
     reset(f);
     seek(f,idx-1);
     write(f,w);
     close(f);
end ;
