procedure Chest;
var c:char;
    tr, gl:boolean;
    gp,pp:longint;
begin
     If (Die(1,100) <= CPC.luc) and (OPC.GP>=10)
        then begin
        tr:=Die(1,5)=1;
        gl:=TRUE;
        gp:=OPC.GP*(Die(2,5)+1);
        pp:=OPC.GP;
        Cwriteln(LF+LF+'`10You found a chest!'+LF);
        Paw;
        repeat
              SendANS('Chest','Treasure Chest');
              prop;
              c:=Upcase(Cread);
              case c of
                   'O':If GL then
                          begin
                            If tr
                               then begin
                               SendANS('trap','');
                               Cwriteln(LF+LF+'`4You suffer`012 '+st(OPC.GP)+' `4points of damage!'+LF);
                               Paw;
                               CPC.HP:=CPC.HP-OPC.GP;
                               If CPC.HP<=0
                                  then begin
                                  UpBull('`012'+CPC.charname+' `4died by a chest trap!'+LF+LF);
                                  Killed;
                                  end;
                               end;
                            If CPC.HP>0
                               then begin
                               Cwriteln(LF+LF+'`10Searching greedily throught the chest you find:'+LF);
                               Cwriteln('`014'+st(gp)+' `6Gold Pieces and `014'+st(pp)+' `6Platinum Pieces!'+LF);
                               CPC.GP:=CPC.GP+GP;
                               CPC.PP:=CPC.PP+PP;
                               end;
                            GL:=FALSE;
                            TR:=FALSE;
                            Paw;
                          end
                          else begin
                          Cwriteln(LF+'`13You already cleaned the chest out!'+LF);
                          Paw;
                          end;
                   'C':begin
                            If not(CPC.TP>=3)
                               then begin
                               Cwriteln(LF+'`11You don''t have enough Theif Points!'+LF);
                               Paw;
                               end
                               else begin
                               CPC.TP:=CPC.TP-3;
                               Cwriteln(LF+'`2You go inspect the chest for traps.....');
                               delay(2*fdelay);
                               If tr
                                  then Cwriteln('`10Trapped!`2 Luckily you checked!'+LF)
                                  else Cwriteln('`10Nope!`2 All Clear!'+LF);
                               Paw;
                               end;
                            end;
                   'D':begin
                            If not(CPC.TP>=9)
                               then begin
                               Cwriteln(LF+'`11You don''t have enough Theif Points!'+LF);
                               Paw;
                               end
                               else begin
                               CPC.TP:=CPC.TP-9;
                               Cwriteln(LF+'`2You go and attempt to diable any traps....');
                               delay(2*fdelay);
                               If not(tr)
                                  then begin
                                  Cwriteln('`10But there was no trap! `2What a waste!'+LF);
                                  Paw;
                                  end
                                  else If Die(1,20)<CPC.dex
                                          then begin
                                          Cwriteln('`10Great!`2You disabled the trap!'+LF);
                                          tr:=FALSE;
                                          Paw;
                                          end
                                          else begin
                                          Cwriteln('`10Ooohhh,`2 almost go it...'+LF);
                                          Paw;
                                          end;
                               end;
                            end;
                   '?':SendANS('Chest','?');
                   end;
              until (c='L') or (MinLeft<=0);
        end;
end;
