procedure OutSide;
var c:char;
    b:boolean;

procedure Encounter;{encounter BANK}
var n:integer;
begin
     Cwriteln(aclrscr+'`13Special Ensounter'+LF);
     Cwriteln('`5=================`3'+LF);
{MAX encounters}case Die(1,5) of
                     1:begin
                            Cwriteln('You see a beatiful tree with all kinds'+LF);
                            Cwriteln('of fruit growing from it. It glimmers in the'+LF);
                            Cwriteln('sun light, and you feel compelled to take'+LF);
                            Cwriteln('some.'+LF);
                            Cwriteln('`11Do you pick some fruit? [y/N]`13'+LF+LF);
                            If Upcase(Cread)='Y'
                               then If (Die(1,5)<=4)
                                    then begin
                                    Cwriteln('You feel totally refreshed!'+LF);
                                    CPC.HP:=CPC.HPmax;
                                    CPC.MP:=CPC.MPmax;
                                    CPC.TP:=CPC.TPmax;
                                    Paw;
                                    end else begin
                                    Cwriteln('It tastes and feels like poison!'+LF);
                                    CPC.HP:=CPC.HP div 2;
                                    CPC.MP:=CPC.MP div 2;
                                    CPC.TP:=CPC.TP div 2;
                                    Paw;
                                    end
                               else begin
                                    Cwriteln('Your loss.....'+LF);
                                    Paw;
                                    end;
                            end;{encounter 1}
                     2:begin
                            n:=Die(2,3);
                            Cwriteln('You find '+num2str(n)+' healing potions hidden'+LF);
                            Cwriteln('in a tree hole!'+LF);
                            CPC.heal:=CPC.heal+n;
                            Paw;
                            end;
                     3:begin
                            Cwriteln('It''s your lucky day! You found a platinum piece!'+LF);
                            Inc(CPC.PP);
                            Paw;
                            end;
                     4:begin
                            Cwriteln('You find a mystical black box, lying in the nook of a'+LF);
                            Cwriteln('tree. Do you open it? [y/N] ');
                            If Upcase(Cread)='Y'
                               then begin
                               if Die(1,3)=1
                                  then begin
                                  Cwriteln(LF+LF+'`12Sparks fly out of the trapped box, spraying you!'+LF);
                                  CPC.HP:=CPC.HP div 2;
                                  Paw;
                                  end else begin
                                  Cwriteln(LF+LF+'`9The mystic box recharges you magical abilities!'+LF);
                                  CPC.MP:=CPC.MPmax;
                                  Paw;
                                  end;
                               end else begin
                               Cwriteln(LF+LF+'`11Your loss....'+LF);
                               Paw;
                               end;
                            end;
                     5:begin
                            Cwriteln('Walking in the woods, you find a poor child begging'+LF);
                            Cwriteln('for food and shelter. Would you like to put this little'+LF);
                            Cwriteln('runt out of his misery, give him some gold or leave'+LF);
                            Cwriteln('here? [k/g/L]'+LF+LF);
                            case Upcase(Cread) of
                                 'K':begin Cwriteln('`12Much to your disapointment, the child puts up'+LF);
                                           Cwriteln('little resistance, as you separate his head from'+LF);
                                           Cwriteln('his body....'+LF);
                                           Cwriteln('`2(You lose 20 goodness)'+LF+LF);
                                           CPC.good:=CPC.good-20;
                                           Paw;
                                           end;
                                 'G':begin If CPC.gp<=0
                                              then begin
                                              Cwriteln('`10Mabye you should be begging for money too!'+LF);
                                              Paw;
                                              end else begin
                                              Cwriteln('`11His face lights up with joy, as you give him'+LF);
                                              Cwriteln('a shiney gold piece!'+LF);
                                              Cwriteln('`2(You gain 20 goodness)'+LF+LF);
                                              Dec(CPC.gp);
                                              CPC.good:=CPC.good+20;
                                              Paw;
                                              end;
                                           end;
                                 end;
                            end;
                     end;{case}
end;


procedure LookForFight(lv:byte);
{looks for a random encounter}
const MonBank:Array [1..6] of byte=(16,16,16,16, 0,0);{max # of monster in REC}
var lp, lp2, cho:integer;

begin
     If CPC.Fights<=0
        then begin
        Cwriteln(LF+'`6Your to tired to fight, mabye tommorow...'+LF);
        Paw;
        end
        else If (Die(1,10)>9)
             then Encounter
             else begin
             Dec(CPC.Fights);
             If MonBank[lv]=0   {monster!}
                then lv:=1;
             cho:=Die(1, MonBank[lv]);
             lp:=0;
             lp2:=0;{file pointer}
             repeat
                   Inc(lp);
                   repeat
                         Inc(lp2);
                         GetMon(lp2);
                         until OPC.Loc=Lv;
                   Until lp=cho;
             Case Fight of{battle data!}
                  1:WinE;
                  2:LosE;
                  3:RunE;
                  end;
             end;
end;


function ShowOtherPCs(l:byte):boolean;
var lp:word;
    tt:boolean;
begin
     tt:=FALSE;
     for lp:=1 to maxpc do
         begin
         GetPC(OPC, lp);
         If (OPC.loc=l) and (CPC.UserID <> lp)
            then begin
            if not(tt)
               then begin
               tt:=TRUE;
               CsendArray(PCList);
               end;
            Cwriteln(ListPC(OPC));
            end;
         end;
     ShowOtherPCs:=tt;
end;

procedure Scene(v:byte);
var c:char;

begin
     repeat
           SendANS('OutSide'+Num2Str(v),'Outside Area: '+Farea[v]);

           Bar;
           Cwriteln('`2Fights left: `010'+st(CPC.fights)+LF+LF);
           Prop;

           c:=upcase(Cread);
           PutPC(CPC,CPC.UserID);{New safety feature!}

           case c of
                'L':LookForFight(v);
                'U':DrinkPotion(CPC,FALSE);
                'H':CastHeal(CPC, FALSE);
                'V':ViewChar;
                '?':SendANS('OutSide'+Num2Str(v),'?');
                end;

           until (c='Q') or (minleft<=0) or (CPC.loc<>0);
end;

procedure Chall;
var id:integer;
    c:char;
begin
     If CPC.I3<maxpckill then begin
     Cwriteln(LF+LF+'`12Who do you wish to challenge brave warrior?`4 (ID#) : `012');
     id:=vl(Creadln(3));
     if not( between(id,1,MaxPc) and (id<>CPC.UserID) )
        then cwriteln(abord)
        else begin
             getpc(OPC, id);
             If (OPC.username='') or (OPC.loc<>1)
                then cwriteln(abord)
                else {If CPC.Level>OPC.Level+MGap
                     then cwriteln(LF+'`13Surley you could find a more worthy opponent!'+LF)
                     else }begin
                               BackStab;
                               Case Fight of{battle data!}
                                    1:WinP;
                                    2:LosP;
                                    3:TieP;
                                    end;
                               end;
             end;
     Paw;
     end else begin
         Cwriteln(LF+'`12Enough blood shed! Try again tommorow'+LF);
         Cwriteln('when you have more strenght...'+LF);
         Paw;
         end;
end;

procedure EndGame(evilend:boolean);{end of the game}
var go:boolean;
begin
     go:=true;
     If (CPC.S3[1]='E') and evilend
        then begin
        go:=false;
        Cwriteln(LF+LF+'`2You''ve alread killed the king you evil soul!'+LF);
        Paw;
        end;
     If (CPC.S3[2]='G') and not(evilend) and go
        then begin
        go:=false;
        Cwriteln(LF+LF+'`2You already killed the dragon you great warrior!'+LF);
        Paw;
        end;
     If evilend and (CPC.good>=0) and go
        then begin
        go:=false;
        Cwriteln(LF+LF+'`10What?! Your to nice to even think about'+LF);
        Cwriteln('harming the king! Don''t you remember you mission?'+LF);
        Cwriteln('`2(Kill the Dragon like a the brave hero you are!)'+LF);
        Paw;
        end;
     If not(evilend) and (CPC.good<0) and go
        then begin
        go:=false;
        Cwriteln(LF+LF+'`10Don''t be a whimp and go for the weak dragon,'+LF);
        Cwriteln('go for that lousy, good for nothing king!'+LF);
        Cwriteln('`2(Kill the King like the evil killer you are!)'+LF);
        Paw;
        end;
     If go
        then begin
        If evilend
           then SendANS('end-e1','')
           else SendANS('end-g1','');
        If upcase(Cread)='Y'
           then begin
           If evilend
              then SendANS('end-e2','')
              else SendANS('end-g2','');
           Paw;
           If evilend
              then GetMon(78)
              else GetMon(77);

           CPC.WDecap:=false;{long fight}
           OPC.Wdecap:=false;

           case Fight Of
                1:begin
                       WinE;
                       If evilend
                          then begin
                          UpBull('`29'+CPC.charname+' has challenged King Durak and won!`1'+LF);
                          UpBull(' `21King Durak II succeeds his father!`1'+LF+LF);
                          CPC.S3[1]:='E';
                          SendANS('end-e3','');
                          Paw;
                          end else begin
                          UpBull('`29'+CPC.charname+' has challenged the Red Dragon and won!`1'+LF);
                          UpBull(' `21A hatchling grows to replace it father!`1'+LF+LF);
                          CPC.S3[2]:='G';
                          SendANS('end-g3','');
                          Paw;
                          end;
                       end;
                2:LosE;
                3:RunE;
                end;

           end;
        end;
end;

{warn player, intering bad teritory!}
function PreScene(b:byte):boolean;
const SugL:Array [1..4] of byte = (1,3,7,10);{level req}
begin
     If CPC.Level < SugL[b]
        then begin
             Cwriteln(LF+LF+'`12Stupidy is not a trait of a good warrior.'+LF);
             Cwriteln('You must have patience and take on realistic challenges,'+LF);
             Cwriteln('and getting yourself killed here will not help you cause...'+LF+LF);
             Cwriteln('`13Are you sure you wish to enter?`5 [y/N]'+LF);
             PreScene:=Upcase(Cread)='Y';
             end
        else PreScene:=true;{passed, Ok}
end;

begin
     repeat
           If CPC.level>WinLevel
              then SendANS('OutSide!','Outside Menu')
              else SendANS('OutSide','Outside Menu');
           bar;

           b:=ShowOtherPCs(1);                {show other PCs here}
           If b
              then Cwriteln('`4Press `12C`4 to challenge another player!'+LF+LF);
           Prop;

           c:=upcase(Cread);
           PutPC(CPC,CPC.UserID);{New safety feature!}

           case c of
                '1'..'4':If PreScene(vl(c))
                            then Scene(vl(c));
                '5'..'6':If CPC.Level>WinLevel
                            then EndGame(c='6');
                'C':If b then chall;
                'U':DrinkPotion(CPC,FALSE);
                'H':CastHeal(CPC, FALSE);
                'V':ViewChar;
                '?':If CPC.level>WinLevel
                       then SendANS('OutSide!','?')
                       else SendANS('OutSide','?');

                end;
           until (c='Q') or (minleft<=0) or (CPC.loc<>0);
end;
