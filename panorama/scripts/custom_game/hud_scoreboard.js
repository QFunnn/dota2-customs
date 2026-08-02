--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Popup = require('./EOM_Popup.js');
var EOM_Icon = require('./EOM_Icon.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
var ScoreBoardTabButtons = require('./ScoreBoardTabButtons.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var Heroes = require('./Heroes.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_XP = require('./EOM_XP.js');
var MedalBadgeIcon = require('./MedalBadgeIcon.js');
var RankTierIcon = require('./RankTierIcon.js');
var greevil_icon = require('./greevil_icon.js');
var ItemImage = require('./ItemImage.js');
var SectIcon = require('./SectIcon.js');
var ShardAbility = require('./ShardAbility.js');
var TalentTree = require('./TalentTree.js');
require('./netdata_utils.js');
require('./game_utils.js');

const PlayerOverviewInfo = props => {
  const [local, others] = libs.splitProps(props, ["children", "playerID", "player_info", "level", "medal_count", "show_medal", "hide_health"]);
  const playerID = () => local.playerID;
  const playerInfo = () => local.player_info;
  const heroName = () => local.player_info.heroName;
  const game_end = () => local.player_info?.rank != undefined;
  const rank = () => game_end() ? others.order : 0;
  const deg = () => {
    return 360 * playerInfo().health / playerInfo().maxHealth;
  };
  const disconnected = () => false;
  const [skinID, setSkinID] = libs.createSignal();
  libs.createEffect(libs.on(() => {
    return {
      _playerID: playerID(),
      _heroName: heroName()
    };
  }, ({
    _playerID,
    _heroName
  }) => {
    const netTableData = getServiceNetTable("player_equipped_ornament", _playerID)?.[OrnamentType.HERO_SKIN];
    let _oid;
    if (netTableData) {
      for (const oid in netTableData) {
        const kv = KeyValues.CosmeticsKv[oid];
        if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == _heroName) {
          _oid = Number(oid);
        }
      }
    }
    setSkinID(_oid);
  }));
  libs.onMount(() => {
    const id = useServiceNetTable("player_equipped_ornament", (data, player_id) => {
      if (player_id == playerID()) {
        const netTableData = data?.[OrnamentType.HERO_SKIN];
        if (netTableData) {
          for (const oid in netTableData) {
            const kv = KeyValues.CosmeticsKv[oid];
            if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == heroName()) {
              setSkinID(Number(oid));
            }
          }
        }
      }
    }, -1);
    libs.onCleanup(() => CustomNetTables.UnsubscribeNetTableListener(id));
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("PlayerOverviewInfo", {
      IsSelf: Players.GetLocalPlayer() == playerID(),
      Disconnected: disconnected()
    })
  }), {
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "PlayerRankContainer",
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return !local.hide_health;
            },
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return game_end();
                },
                fallback: () => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("HealthCircle", {
                        HealthMid: isTurboMode() ? playerInfo().health <= 8 : playerInfo().health <= 20,
                        HealthLow: isTurboMode() ? playerInfo().health <= 4 : playerInfo().health <= 10
                      });
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        className: "Circle",
                        get style() {
                          return {
                            clip: `radial( 50.0% 50.0%, 0deg, ${deg()}deg)`
                          };
                        }
                      }), libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return playerInfo().health;
                        }
                      })];
                    }
                  });
                },
                get children() {
                  return [libs.createComponent(GenericPanel.CImage, {
                    get className() {
                      return libs.classNames("PlayerRankBG", "Rank" + rank());
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    className: "PlayerRank",
                    get text() {
                      return game_end() && others.order <= 3 ? "" : others.order;
                    }
                  })];
                }
              });
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.show_medal;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "MedalContainer",
            get children() {
              return libs.memo(() => !!(isRankMode() || isKingsRankMode()))() ? libs.createComponent(RankTierIcon.RankTierIcon, {
                get player_id() {
                  return playerID();
                },
                size: "64",
                showtooltip: true
              }) : libs.createComponent(MedalBadgeIcon.MedalBadgeIcon, {
                get medal_count() {
                  return local.medal_count ?? 0;
                },
                size: "64"
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("HeroImageContainer");
        },
        get children() {
          return [libs.createComponent(Heroes.HeroImage, {
            get hero_name() {
              return heroName();
            },
            get oid() {
              return skinID();
            }
          }), libs.createComponent(EOM_XP.EOM_XP, {
            get level() {
              return local.level;
            },
            maxLevel: 100
          }), libs.createComponent(libs.Show, {
            get when() {
              return disconnected();
            },
            get children() {
              return libs.createComponent(EOM_Icon.EOM_Icon, {
                align: "center center",
                size: "48",
                get src() {
                  return getSrcPath("hud/icon_disconnect.png");
                }
              });
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "NameContainer",
        get children() {
          return [libs.createComponent(Player.PlayerName, {
            get playerID() {
              return Number(playerID());
            },
            get steamID() {
              return local.player_info.steamID;
            }
          }), libs.createComponent(EOM_Label.EOM_Label, {
            id: "HeroName",
            get text() {
              return libs.memo(() => !!heroName())() ? "#" + heroName() : "";
            }
          })];
        }
      })];
    }
  }));
};

const NeutralRounds = [5, 10, 15];
const CombatLogLayout = props => {
  const [local, others] = libs.splitProps(props, ["allPlayerData", "sect_data", "playerOrder", "hasVip"]);
  const [round, setRound] = libs.createSignal(Math.max(0, CustomNetTables.GetTableValue("common", "round_data")?.round_number ?? 0));
  if (isSpectator()) {
    let inited = false;
    libs.createEffect(() => {
      if (!inited && Object.keys(local.allPlayerData).length > 0) {
        inited = true;
        setSelectedPlayerID(Number(Object.keys(local.allPlayerData)[0]));
      }
    });
  }
  const [selectedPlayerID, setSelectedPlayerID] = libs.createSignal(Players.GetLocalPlayer());
  const [selectedRound, setselectedRound] = libs.createSignal(round());
  const [playerRound, setPlayerRound] = libs.createStore((() => {
    let info = [];
    const data = CustomNetTables.GetTableValue("common", "round_match_info");
    if (data) {
      Object.keys(data).forEach(player_id => {
        const parsedPlayerId = Number(player_id);
        if (data[parsedPlayerId]) {
          Object.entries(data[parsedPlayerId]).forEach(([round, _info]) => {
            if (info[parsedPlayerId] == undefined) {
              info[parsedPlayerId] = [];
            }
            if (_info.isWinner == undefined) {
              info[parsedPlayerId][Number(round)] = {
                state: "notEnd",
                enemyKey: _info.enemy
              };
            } else {
              info[parsedPlayerId][Number(round)] = {
                state: _info.isWinner == 1 ? "win" : "loss",
                enemyKey: _info.enemy
              };
            }
          });
        }
      });
    }
    return info;
  })());
  const BattleBriefInfo = libs.createMemo(() => {
    const info = playerRound?.[selectedPlayerID()]?.[selectedRound()];
    if (info != undefined) {
      const [type, id] = info.enemyKey.split("_");
      if (finiteNumber(Number(id), -1) != -1 && type != "N") {
        const enemyID = Number(id);
        let selfData = getServiceNetTable("player_equipped_ornament", selectedPlayerID())?.[OrnamentType.HERO_SKIN];
        let selfOid;
        const selfHeroName = getPlayerData(selectedPlayerID(), "heroName");
        if (selfData) {
          for (const oid in selfData) {
            const kv = KeyValues.CosmeticsKv[oid];
            if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == selfHeroName) {
              selfOid = oid;
            }
          }
        }
        let enemyData = getServiceNetTable("player_equipped_ornament", enemyID)?.[OrnamentType.HERO_SKIN];
        let enemyOid;
        const enemyHeroName = getPlayerData(enemyID, "heroName");
        if (enemyData) {
          for (const oid in enemyData) {
            const kv = KeyValues.CosmeticsKv[oid];
            if (kv && kv.hero && GetHeroNameByGoodID(finiteNumber(Number(kv.hero))) == enemyHeroName) {
              enemyOid = oid;
            }
          }
        }
        return {
          state: info.state,
          isIllusion: type == "I",
          selfPlayerID: selectedPlayerID(),
          selfOid,
          selfHeroName,
          enemyPlayerID: enemyID,
          enemyOid,
          enemyHeroName
        };
      }
    }
  });
  libs.createEffect(libs.on(() => playerRound?.[selectedPlayerID()], player_round => {
    if (player_round && player_round.length > 0) {
      if (player_round[selectedRound()] == undefined) {
        for (let i = selectedRound(); i > 0; i--) {
          if (player_round[i] != undefined) {
            setselectedRound(i);
          }
        }
      }
    } else {
      setselectedRound(0);
    }
  }));
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(useNetTableKey("common", "round_data", data => {
      setRound(data.round_number);
    }));
    NetTableListenerIDs.push(useNetTableKey("common", "round_match_info", data => {
      if (data && Object.keys(data).length > 0) {
        Object.keys(data).forEach(player_id => {
          const parsedPlayerId = Number(player_id);
          const _data = data[parsedPlayerId];
          if (_data) {
            libs.batch(() => {
              if (playerRound[parsedPlayerId] == undefined) {
                let info = [];
                Object.entries(_data).forEach(([round, _info]) => {
                  if (_info.isWinner == undefined) {
                    info[Number(round)] = {
                      state: "notEnd",
                      enemyKey: _info.enemy
                    };
                  } else {
                    if (_info.isWinner == 1) {
                      info[Number(round)] = {
                        state: "win",
                        enemyKey: _info.enemy
                      };
                    } else {
                      info[Number(round)] = {
                        state: "loss",
                        enemyKey: _info.enemy
                      };
                    }
                  }
                });
                setPlayerRound(parsedPlayerId, info);
              } else {
                Object.entries(_data).forEach(([round, _info]) => {
                  if (_info.isWinner == undefined) {
                    if (playerRound[parsedPlayerId][Number(round)]?.state != "notEnd") {
                      setPlayerRound(parsedPlayerId, Number(round), {
                        state: "notEnd",
                        enemyKey: _info.enemy
                      });
                    }
                  } else {
                    if (_info.isWinner == 1) {
                      if (playerRound[parsedPlayerId][Number(round)]?.state != "win") {
                        setPlayerRound(parsedPlayerId, Number(round), {
                          state: "win",
                          enemyKey: _info.enemy
                        });
                      }
                    } else {
                      if (playerRound[parsedPlayerId][Number(round)]?.state != "loss") {
                        setPlayerRound(parsedPlayerId, Number(round), {
                          state: "loss",
                          enemyKey: _info.enemy
                        });
                      }
                    }
                  }
                });
              }
            });
          }
        });
      } else {
        let info = {};
        setPlayerRound(info);
      }
    }));
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const RoundListRow = () => {
    const arr = [];
    const currentRound = round();
    if (currentRound > 0) {
      const row_count = Math.ceil(currentRound / 5);
      const row_element = currentRound % 5 || 5;
      for (let i = 0; i < row_count; i++) {
        arr[i] = [];
        const maxIndex = i + 1 === row_count ? row_element : 5;
        for (let index = 0; index < maxIndex; index++) {
          arr[i].push(index + 1 + i * 5);
        }
      }
    }
    return arr;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ScoreBoard_combatlog",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CombatLogTitles",
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return playerRound[selectedPlayerID()]?.[selectedRound() % 1000 + 1000] != undefined;
            },
            get children() {
              return (() => {
                libs.onCleanup(() => {
                  setselectedRound(v => v % 1000);
                });
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  width: '300px',
                  horizontalAlign: 'right',
                  get children() {
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      align: 'center center',
                      flowChildren: 'right',
                      get children() {
                        return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames("ExtraBattleButton", {
                              Selected: selectedRound() < 1000
                            });
                          },
                          onactivate: () => {
                            setselectedRound(v => v % 1000);
                          },
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "ExtraBattleButtonBG",
                              get children() {
                                return libs.createElement("Label", {
                                  text: "1"
                                }, null);
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("ResultIcon", playerRound[selectedPlayerID()]?.[selectedRound() % 1000]?.state);
                              }
                            })];
                          }
                        }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                          get className() {
                            return libs.classNames("ExtraBattleButton", {
                              Selected: selectedRound() >= 1000
                            });
                          },
                          onactivate: () => {
                            setselectedRound(v => v % 1000 + 1000);
                          },
                          get children() {
                            return [libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "ExtraBattleButtonBG",
                              get children() {
                                return libs.createElement("Label", {
                                  text: "2"
                                }, null);
                              }
                            }), libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("ResultIcon", playerRound[selectedPlayerID()]?.[selectedRound() % 1000 + 1000]?.state);
                              }
                            })];
                          }
                        })];
                      }
                    });
                  }
                });
              })();
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CombatLogContents",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "PlayerList",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return local.playerOrder;
                },
                children: (player_id, i) => {
                  const playerID = () => Number(player_id());
                  const playerInfo = () => local.allPlayerData[playerID()];
                  const level = () => playerInfo().heroLevel ?? 1;
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get enabled() {
                      return playerID() != selectedPlayerID();
                    },
                    get className() {
                      return libs.classNames("PlayerButton", {
                        Selected: playerID() == selectedPlayerID(),
                        IsSelf: Number(playerID()) == Players.GetLocalPlayer()
                      });
                    },
                    onactivate: () => setSelectedPlayerID(playerID()),
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "SelectedBG"
                      }), libs.createComponent(PlayerOverviewInfo, {
                        get hide_health() {
                          return isGroupMode();
                        },
                        get playerID() {
                          return playerID();
                        },
                        get player_info() {
                          return playerInfo();
                        },
                        get level() {
                          return level();
                        },
                        order: i + 1
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "RoundList",
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return BattleBriefInfo() != undefined;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "BattleBrief",
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("PlayerBriefInfo", "Self");
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "HeroImageContainer",
                            get children() {
                              return [libs.createComponent(Heroes.HeroImage, {
                                get hero_name() {
                                  return BattleBriefInfo()?.selfHeroName;
                                },
                                get oid() {
                                  return Number(BattleBriefInfo()?.selfOid);
                                }
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "HeroBorderOverlay"
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "LoserOverlay",
                                get visible() {
                                  return BattleBriefInfo()?.state == "loss";
                                }
                              })];
                            }
                          }), libs.createComponent(Player.PlayerName, {
                            get playerID() {
                              return BattleBriefInfo()?.selfPlayerID;
                            },
                            get steamID() {
                              return getPlayerData(BattleBriefInfo()?.selfPlayerID, "steamID");
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            id: "HeroName",
                            get text() {
                              return "#" + BattleBriefInfo()?.selfHeroName;
                            }
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "InCombatIcon",
                        get children() {
                          return [libs.createComponent(GenericPanel.CImage, {
                            id: "Sword1"
                          }), libs.createComponent(GenericPanel.CImage, {
                            id: "Sword2"
                          })];
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("PlayerBriefInfo", "Enemy", {
                            Illusion: BattleBriefInfo()?.isIllusion
                          });
                        },
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "HeroImageContainer",
                            get children() {
                              return [libs.createComponent(Heroes.HeroImage, {
                                get hero_name() {
                                  return BattleBriefInfo()?.enemyHeroName;
                                },
                                get oid() {
                                  return Number(BattleBriefInfo()?.enemyOid);
                                }
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "HeroBorderOverlay"
                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "LoserOverlay",
                                get visible() {
                                  return BattleBriefInfo()?.state == "win";
                                }
                              })];
                            }
                          }), libs.createComponent(Player.PlayerName, {
                            get playerID() {
                              return BattleBriefInfo()?.enemyPlayerID;
                            },
                            get steamID() {
                              return getPlayerData(BattleBriefInfo()?.enemyPlayerID, "steamID");
                            }
                          }), libs.createComponent(GenericPanel.CLabel, {
                            id: "HeroName",
                            get text() {
                              return "#" + BattleBriefInfo()?.enemyHeroName;
                            }
                          })];
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RoundListContent",
                scroll: "y",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "RoundTitle",
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#SelectRound_Button"
                      });
                    }
                  }), libs.createComponent(libs.Index, {
                    get each() {
                      return RoundListRow();
                    },
                    children: (RoundRow, _) => libs.createComponent(EOM_Panel.EOM_Panel, {
                      className: "RoundListRow",
                      get children() {
                        return libs.createComponent(libs.Index, {
                          get each() {
                            return RoundRow();
                          },
                          children: (round_number, i) => {
                            const enable = () => {
                              if (playerRound[selectedPlayerID()]) {
                                return playerRound[selectedPlayerID()][round_number()] != undefined;
                              }
                              return false;
                            };
                            const resultType = () => {
                              if (playerRound[selectedPlayerID()]) {
                                if (playerRound[selectedPlayerID()][round_number() + 1000]) {
                                  return playerRound[selectedPlayerID()][round_number() + 1000]?.state;
                                }
                                return playerRound[selectedPlayerID()][round_number()]?.state;
                              }
                            };
                            return libs.createComponent(EOM_Button.EOM_BaseButton, {
                              get enabled() {
                                return enable();
                              },
                              get className() {
                                return libs.classNames("RoundButton", {
                                  Selected: round_number() == selectedRound() % 1000
                                }, NeutralRounds.includes(round_number()) ? "Gold" : "Blue");
                              },
                              onactivate: () => {
                                if (round_number() != selectedRound()) {
                                  setselectedRound(round_number());
                                }
                              },
                              get children() {
                                return [libs.createComponent(GenericPanel.CLabel, {
                                  get text() {
                                    return round_number();
                                  }
                                }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                  get className() {
                                    return libs.classNames("ResultIcon", resultType());
                                  }
                                })];
                              }
                            });
                          }
                        });
                      }
                    })
                  })];
                }
              })];
            }
          }), libs.createComponent(CombatLogMain, {
            selectedPlayerID: selectedPlayerID,
            selectedRound: selectedRound
          })];
        }
      })];
    }
  });
};
const getTime = time => {
  const min = String(Math.floor(time / 60)).padStart(2, "0");
  const sec = (time % 60).toFixed(2).padStart(5, "0");
  return min + ":" + sec;
};
const getText = logInfo => {
  if (logInfo.type == "damage") {
    if (logInfo.ability) {
      const [head, origin] = logInfo.ability.split("_");
      if (head == "SectAttack" || head == "AbilityAttack") {
        return logInfo?.is_crit ? "#CombatLog_DamageAbilityAttackCrit" : "#CombatLog_DamageAbilityAttack";
      } else if (head == "Attack") {
        return logInfo?.is_crit ? "#CombatLog_DamageCrit" : "#CombatLog_Damage";
      } else {
        return logInfo?.is_crit ? "#CombatLog_DamageAbilityCrit" : "#CombatLog_DamageAbility";
      }
    }
  } else if (logInfo.type == "heal") {
    return "#CombatLog_Heal";
  } else if (logInfo.type == "buff") {
    return "#CombatLog_Buff";
  } else if (logInfo.type == "AbilityCast") {
    return "#CombatLog_AbilityCast";
  } else if (logInfo.type == "State") {
    return "#CombatLog_State";
  } else if (logInfo.type == "StateLoss") {
    return "#CombatLog_StateLoss";
  } else if (logInfo.type == "Evasion") {
    return "#CombatLog_Evasion";
  } else if (logInfo.type == "block") {
    return "#CombatLog_Block";
  }
  return "";
};
const getAbilityName = name => {
  if (name == undefined) {
    return "";
  }
  const data = name.split("_");
  const prefix = data.shift();
  const abilityName = data.join("_");
  let tooltip = "#DOTA_Tooltip_ability_" + abilityName;
  if (prefix == "AbilityUpgrade" || prefix == "SectAttack") {
    tooltip = "#DOTA_Tooltip_ability_mechanics_" + abilityName;
  } else if ((prefix == "Ability" || prefix == "AbilityAttack") && KeyValues.HeroTalentKv[abilityName]) {
    const kv = KeyValues.HeroTalentKv[abilityName];
    let requireLevel = finiteNumber(Number(kv?.RequiredLevel), -1);
    if (requireLevel > 0) {
      tooltip = $.Localize("#CombatLog_TalentLabel").replace("${level}", requireLevel.toString());
    }
  }
  return $.Localize(tooltip);
};
const getUnitLabelColor = ({
  unit_name,
  info_playerID,
  viewing_playerID,
  type,
  self_cast
}) => {
  if (info_playerID == -1) {
    return type == "victim" && !self_cast ? `<font color='#8ab5ee'>${unit_name}</font>` : `<font color='#ec8e8b'>${unit_name}</font>`;
  }
  if (type == "attacker" || type == "victim" && self_cast) {
    return info_playerID == viewing_playerID ? `<font color='#8ab5ee'>${unit_name}</font>` : `<font color='#ec8e8b'>${unit_name}</font>`;
  } else {
    return info_playerID == viewing_playerID ? `<font color='#ec8e8b'>${unit_name}</font>` : `<font color='#8ab5ee'>${unit_name}</font>`;
  }
};
const CombatLogMain = ({
  selectedPlayerID,
  selectedRound
}) => {
  const [loading, setLoading] = libs.createSignal(false);
  const [showSelf, setShowSelf] = libs.createSignal(true);
  const [showEnemy, setShowEnemy] = libs.createSignal(true);
  const [showDamage, setShowDamage] = libs.createSignal(true);
  const [showAbility, setShowAbility] = libs.createSignal(true);
  const [showHeal, setShowHeal] = libs.createSignal(true);
  const [showBuff, setShowBuff] = libs.createSignal(true);
  const [viewingPlayerID, setViewingPlayerID] = libs.createSignal(-1);
  const [viewingRound, setViewingRound] = libs.createSignal(-1);
  const [buttonEnable, setButtonEnable] = libs.createSignal(true);
  const requestLog = (playerID, round) => {
    if (showSelf() || showEnemy()) {
      setLoading(true);
      setCombatLog([]);
      GameEvents.SendCustomEventToServer("request_combat_log", {
        round: round,
        requestPlayerID: playerID,
        showSelf: showSelf(),
        showEnemy: showEnemy(),
        showAbilityDamage: showAbility(),
        showAttackDamage: showDamage(),
        showBuff: showBuff(),
        showHeal: showHeal()
      });
    } else {
      ErrorMessage("#InvalidRequest");
    }
  };
  const [combatLog, setCombatLog] = libs.createSignal([]);
  let pageListPanel;
  let logListPanel;
  let lastPage = 1;
  const [page, setPage] = libs.createSignal(1);
  const pageMaxCount = 500;
  libs.createEffect(libs.on(page, _ => {
    if (logListPanel?.IsValid()) {
      if (lastPage - _ == 1) {
        logListPanel.ScrollToBottom();
      } else {
        logListPanel.ScrollToTop();
      }
    }
    if (pageListPanel?.IsValid()) {
      const child = pageListPanel.GetChild(_ - 1);
      if (child?.IsValid()) {
        child.ScrollParentToMakePanelFit(3, false);
      }
    }
    lastPage = _;
  }));
  const pageCount = libs.createMemo(() => {
    return Math.ceil(combatLog().length / pageMaxCount);
  });
  const displayerLogList = libs.createMemo(() => {
    if (combatLog().length > 0) {
      return combatLog().slice((page() - 1) * pageMaxCount, page() * (pageMaxCount - 1));
    }
    return [];
  });
  const getCombatLogText = () => {
    let combat_text = "";
    if ($("#CombatLogContainer")?.IsValid()) {
      let count = $("#CombatLogContainer")?.GetChildCount() ?? 0;
      if (count > 0) {
        for (let i = 0; i < count; i++) {
          const child = $("#CombatLogContainer")?.GetChild(i);
          if (child?.IsValid() && child.type == "Label") {
            combat_text += child.text + "\n";
          }
        }
      }
    }
    return combat_text;
  };
  libs.onMount(() => {
    const GameEventListenerIDs = [];
    GameEventListenerIDs.push(useNetData("combat_log_stream", data => {
      setLoading(false);
      setPage(1);
      setCombatLog(data.data);
      setViewingPlayerID(data.player_id);
      setViewingRound(data.round);
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => GameEventListenerIDs.forEach(id => GameEvents.Unsubscribe(id)));
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "CombatLogMain",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CombatLogOptions",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "OptionRow",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "OptionName",
                    text: "#Combatlog_Option_Self"
                  }), (() => {
                    const _el$3 = libs.createElement("ToggleButton", {
                      get selected() {
                        return showSelf();
                      }
                    }, null);
                    libs.setProp(_el$3, "onactivate", self => {
                      setShowSelf(self.IsSelected());
                    });
                    libs.effect(_$p => libs.setProp(_el$3, "selected", showSelf(), _$p));
                    return _el$3;
                  })()];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "OptionRow",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "OptionName",
                    text: "#Combatlog_Option_Enemy"
                  }), (() => {
                    const _el$4 = libs.createElement("ToggleButton", {
                      get selected() {
                        return showEnemy();
                      }
                    }, null);
                    libs.setProp(_el$4, "onactivate", self => {
                      setShowEnemy(self.IsSelected());
                    });
                    libs.effect(_$p => libs.setProp(_el$4, "selected", showEnemy(), _$p));
                    return _el$4;
                  })()];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            marginLeft: "20px",
            flowChildren: "down",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "OptionRow",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "OptionName",
                    text: "#Combatlog_Option_Attack"
                  }), (() => {
                    const _el$5 = libs.createElement("ToggleButton", {
                      get selected() {
                        return showDamage();
                      }
                    }, null);
                    libs.setProp(_el$5, "onactivate", self => {
                      setShowDamage(self.IsSelected());
                    });
                    libs.effect(_$p => libs.setProp(_el$5, "selected", showDamage(), _$p));
                    return _el$5;
                  })()];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "OptionRow",
                get children() {
                  return [libs.createComponent(GenericPanel.CLabel, {
                    className: "OptionName",
                    text: "#Combatlog_Option_Ability"
                  }), (() => {
                    const _el$6 = libs.createElement("ToggleButton", {
                      get selected() {
                        return showAbility();
                      }
                    }, null);
                    libs.setProp(_el$6, "onactivate", self => {
                      setShowAbility(self.IsSelected());
                    });
                    libs.effect(_$p => libs.setProp(_el$6, "selected", showAbility(), _$p));
                    return _el$6;
                  })()];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            marginLeft: "20px",
            flowChildren: "down",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "down",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "OptionRow",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        className: "OptionName",
                        text: "#Combatlog_Option_Heal"
                      }), (() => {
                        const _el$7 = libs.createElement("ToggleButton", {
                          get selected() {
                            return showHeal();
                          }
                        }, null);
                        libs.setProp(_el$7, "onactivate", self => {
                          setShowHeal(self.IsSelected());
                        });
                        libs.effect(_$p => libs.setProp(_el$7, "selected", showHeal(), _$p));
                        return _el$7;
                      })()];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "OptionRow",
                    get children() {
                      return [libs.createComponent(GenericPanel.CLabel, {
                        className: "OptionName",
                        text: "#Combatlog_Option_Buff"
                      }), (() => {
                        const _el$8 = libs.createElement("ToggleButton", {
                          get selected() {
                            return showBuff();
                          }
                        }, null);
                        libs.setProp(_el$8, "onactivate", self => {
                          setShowBuff(self.IsSelected());
                        });
                        libs.effect(_$p => libs.setProp(_el$8, "selected", showBuff(), _$p));
                        return _el$8;
                      })()];
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            className: "FunctionButton",
            margin: "0px",
            align: "right bottom",
            color: "Blue",
            text: "#CombatLog_Print",
            get enabled() {
              return buttonEnable();
            },
            onactivate: () => {
              setButtonEnable(false);
              $.Schedule(1, () => setButtonEnable(true));
              requestLog(selectedPlayerID(), selectedRound());
            }
          }), libs.createComponent(EOM_Button.EOM_Button, {
            className: "FunctionButton",
            margin: "0 0 50px 0",
            align: "right bottom",
            color: "Green",
            text: "#CombatLog_Copy",
            get enabled() {
              return displayerLogList().length > 0;
            },
            onactivate: () => {
              $.DispatchEvent("CopyStringToClipboard", getCombatLogText(), null);
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CombatLogContainer",
        ref(r$) {
          const _ref$ = logListPanel;
          typeof _ref$ === "function" ? _ref$(r$) : logListPanel = r$;
        },
        flowChildren: "down",
        scroll: "y",
        padding: "2px",
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return loading();
            },
            fallback: () => libs.createComponent(libs.Index, {
              get each() {
                return displayerLogList();
              },
              children: (logInfo, index) => {
                return libs.createComponent(GenericPanel.CLabel, {
                  get className() {
                    return libs.classNames("LogLabel", "Type_" + logInfo().type, {
                      Show: true
                    });
                  },
                  acceptsfocus: true,
                  allowtextselection: true,
                  html: true,
                  get text() {
                    return getText(logInfo());
                  },
                  get vars() {
                    return {
                      time: getTime(logInfo().time),
                      attacker: getUnitLabelColor({
                        unit_name: $.Localize("#" + logInfo().caster),
                        info_playerID: logInfo().playerID,
                        viewing_playerID: viewingPlayerID(),
                        type: "attacker",
                        self_cast: (logInfo()?.self_cast ?? 0) != 0
                      }),
                      victim: getUnitLabelColor({
                        unit_name: $.Localize("#" + logInfo().target),
                        info_playerID: logInfo().playerID,
                        viewing_playerID: viewingPlayerID(),
                        type: "victim",
                        self_cast: (logInfo()?.self_cast ?? 0) != 0
                      }),
                      damage: `<font color='${getDamageTypeColor(logInfo().damageType)}'>${logInfo().damage}</font>`,
                      damage_type: `<font color='${getDamageTypeColor(logInfo().damageType)}'>${$.Localize("#DamageType_" + logInfo().damageType)}</font>`,
                      abilityname: getAbilityName(logInfo().ability),
                      heal: logInfo().heal ?? 0,
                      health: logInfo().health ?? 0,
                      next_health: logInfo().next_health != undefined ? logInfo().next_health : Math.max(0, (logInfo().health ?? 0) - (logInfo().damage ?? 0)),
                      count: logInfo().count ?? 0,
                      buffname: $.Localize("#Sect_Effect_" + logInfo().buffname),
                      statename: $.Localize("#Buff_" + (logInfo()?.state_name ?? ""))
                    };
                  }
                });
              }
            }),
            get children() {
              return libs.createComponent(EOM_Icon.EOM_Icon, {
                type: "Spinner",
                horizontalAlign: "center",
                width: "34px",
                height: "34px",
                spin: true,
                marginTop: "200px"
              });
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CombatPages",
        get visible() {
          return pageCount() > 1;
        },
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "LeftPage",
            get className() {
              return libs.classNames("ActivityPageButton", {});
            },
            get enabled() {
              return page() != 1;
            },
            onactivate: self => setPage(v => v - 1),
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "pageBg"
              }), libs.createComponent(GenericPanel.CLabel, {
                text: "<"
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            ref(r$) {
              const _ref$2 = pageListPanel;
              typeof _ref$2 === "function" ? _ref$2(r$) : pageListPanel = r$;
            },
            id: "PageList",
            scroll: "x",
            get children() {
              return libs.createComponent(libs.For, {
                get each() {
                  return (() => [...Array(pageCount())])();
                },
                children: (_, i) => {
                  const pageNow = () => i() + 1;
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames("ActivityPageButton", {
                        Selected: page() == pageNow()
                      });
                    },
                    get enabled() {
                      return page() != pageNow();
                    },
                    onactivate: self => setPage(pageNow()),
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "pageBg"
                      }), libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return pageNow();
                        }
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "RightPage",
            get className() {
              return libs.classNames("ActivityPageButton", {});
            },
            get enabled() {
              return page() != pageCount();
            },
            onactivate: self => setPage(v => v + 1),
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "pageBg"
              }), libs.createComponent(GenericPanel.CLabel, {
                text: ">"
              })];
            }
          })];
        }
      })];
    }
  });
};

const CommonOverviewLayout = props => {
  const [local, others] = libs.splitProps(props, ["allPlayerData", "playerOrder", "sect_data"]);
  const playerList = () => {
    return local.playerOrder;
  };
  const [end, setEnd] = libs.createSignal((CustomNetTables.GetTableValue("common", "game_state")?.state ?? "GameState_None") == "GameState_End");
  libs.onMount(() => {
    const NetTableListeners = [];
    NetTableListeners.push(useNetTableKey("common", "game_state", data => {
      setEnd(data.state == "GameState_End");
    }));
    libs.onCleanup(() => {
      for (const id of NetTableListeners) {
        CustomNetTables.UnsubscribeNetTableListener(id);
      }
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ScoreBoard_overview",
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "OverviewLists",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            align: "center center",
            flowChildren: "down",
            style: {
              border: "1px solid #73737366"
            },
            get children() {
              return [libs.createComponent(OverviewPlayerRow, {
                index: -1,
                get game_end() {
                  return end();
                }
              }), libs.memo(() => libs.memo(() => !!isGroupMode())() ? (() => {
                let groupIndexList = [0, 1, 2, 3];
                const [allGroupInfo, setAllGroupInfo] = libs.createStore((() => {
                  let groupInfo = {};
                  groupIndexList.forEach(index => {
                    let data = CustomNetTables.GetTableValue("common", "group_team_" + index);
                    if (data != undefined) {
                      groupInfo[index] = data;
                    }
                  });
                  return groupInfo;
                })());
                const [groupSort, setGroupSort] = libs.createSignal(groupIndexList);
                libs.createEffect(() => {
                  setGroupSort(Object.keys(allGroupInfo).map(Number).sort((a, b) => multiCompare(allGroupInfo[a].rank - allGroupInfo[b].rank, allGroupInfo[b].health - allGroupInfo[a].health, allGroupInfo[a].undead - allGroupInfo[b].undead)));
                });
                libs.onMount(() => {
                  const NetTableListeners = [];
                  groupIndexList.forEach(index => {
                    NetTableListeners.push(useNetTableKeyHasDefaultValue("common", "group_team_" + index, data => {
                      setAllGroupInfo(index, Object.assign({}, data));
                    }));
                  });
                  libs.onCleanup(() => {
                    for (const id of NetTableListeners) {
                      CustomNetTables.UnsubscribeNetTableListener(id);
                    }
                  });
                });
                return libs.createComponent(libs.Index, {
                  get each() {
                    return groupSort();
                  },
                  children: (gourpID, i) => {
                    const groupInfo = () => allGroupInfo[gourpID()];
                    const groupPlayers = () => Object.values(groupInfo().players);
                    const undead = () => groupInfo().undead == 1;
                    const rank = () => groupInfo().rank;
                    const playerID = () => groupPlayers()[0] ?? -1;
                    const playerData = () => {
                      return local.allPlayerData?.[Number(playerID())];
                    };
                    const sectData = () => {
                      if (local.sect_data[Number(playerID())]) {
                        return local.sect_data[Number(playerID())];
                      }
                    };
                    const playerID2 = () => groupPlayers()[1] ?? -1;
                    const playerData2 = () => {
                      return local.allPlayerData?.[playerID2()];
                    };
                    const sectData2 = () => {
                      if (local.sect_data[playerID2()]) {
                        return local.sect_data[playerID2()];
                      }
                    };
                    const healthPct = () => Clamp(groupInfo().health / groupInfo().max_health * 100, 8, 100);
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "Team",
                      get children() {
                        return [libs.createComponent(libs.Show, {
                          get when() {
                            return rank() > 0;
                          },
                          get fallback() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "TeamHealth",
                              get classList() {
                                return {
                                  undead: undead()
                                };
                              },
                              hittest: false,
                              get children() {
                                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                  get className() {
                                    return libs.classNames("TeamHealthBar", "Team" + gourpID());
                                  },
                                  get children() {
                                    return libs.createComponent(EOM_Image.EOM_Image, {
                                      id: "HealthBar",
                                      get style() {
                                        return {
                                          clip: `rect( ${100 - healthPct()}% ,100%, 100%, 0%)`
                                        };
                                      }
                                    });
                                  }
                                }), libs.createComponent(GenericPanel.CLabel, {
                                  get text() {
                                    return groupInfo().health;
                                  }
                                })];
                              }
                            });
                          },
                          get children() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              id: "TeamRankContainer",
                              hittest: true,
                              hittestchildren: false,
                              get children() {
                                return [libs.createComponent(GenericPanel.CImage, {
                                  get className() {
                                    return libs.classNames("TeamRankBG", "Rank" + rank());
                                  }
                                }), libs.createComponent(EOM_Label.EOM_Label, {
                                  className: "TeamRank",
                                  get text() {
                                    return libs.memo(() => rank() > 3)() ? rank() : "";
                                  }
                                })];
                              }
                            });
                          }
                        }), libs.createComponent(EOM_Panel.EOM_Panel, {
                          flowChildren: "down",
                          get children() {
                            return [libs.createComponent(OverviewPlayerRow, {
                              get playerID() {
                                return playerID();
                              },
                              index: i * 2,
                              get playerData() {
                                return playerData();
                              },
                              get sect_info() {
                                return sectData();
                              },
                              get game_end() {
                                return end();
                              }
                            }), libs.createComponent(OverviewPlayerRow, {
                              get playerID() {
                                return playerID2();
                              },
                              index: i * 2 + 1,
                              get playerData() {
                                return playerData2();
                              },
                              get sect_info() {
                                return sectData2();
                              },
                              get game_end() {
                                return end();
                              }
                            })];
                          }
                        })];
                      }
                    });
                  }
                });
              })() : libs.createComponent(libs.Index, {
                get each() {
                  return playerList();
                },
                children: (playerID, index) => {
                  const playerData = () => {
                    return local.allPlayerData?.[Number(playerID())];
                  };
                  const sectData = () => {
                    if (local.sect_data[Number(playerID())]) {
                      return local.sect_data[Number(playerID())];
                    }
                  };
                  return libs.createComponent(OverviewPlayerRow, {
                    get playerID() {
                      return (() => Number(playerID()))();
                    },
                    index: index,
                    get playerData() {
                      return playerData();
                    },
                    get sect_info() {
                      return sectData();
                    },
                    get game_end() {
                      return end();
                    }
                  });
                }
              }))];
            }
          });
        }
      });
    }
  });
};
const useOverviewPlayerRow = props => {
  const getItemList = data => {
    return data.filter(v => v != "null" && v != "");
  };
  const merged = libs.mergeProps$1({
    playerID: -1,
    index: -1
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerData", "playerID", "sect_info", "game_end"]);
  const playerID = () => local.playerID;
  const [artifactList, setArtifactList] = libs.createSignal(Object.values(CustomNetTables.GetTableValue("common", "artifact_list_" + playerID()) ?? {}));
  const [itemList, setItemList] = libs.createSignal(getItemList(Object.values(CustomNetTables.GetTableValue("common", "item_list_" + playerID()) ?? {})));
  const [medalCount, setMedalCount] = libs.createSignal((getServiceNetTable("player_medal", playerID()) ?? {
    now_medal: 0
  }).now_medal);
  libs.onMount(() => {
    const gameEventListeners = [];
    const NetTableListeners = [];
    if (others.index != -1) {
      NetTableListeners.push(useServiceNetTable("player_medal", (data, player_id) => {
        if (player_id == playerID()) {
          setMedalCount(data?.now_medal ?? 0);
        }
      }, -1));
      NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("common", (tableName, key, value) => {
        if (key == "artifact_list_" + playerID()) {
          setArtifactList(Object.values(value));
        } else if (key == "item_list_" + playerID()) {
          setItemList(getItemList(Object.values(value)));
        }
      }));
    }
    libs.onCleanup(() => {
      for (const id of gameEventListeners) {
        GameEvents.Unsubscribe(id);
      }
      for (const id of NetTableListeners) {
        CustomNetTables.UnsubscribeNetTableListener(id);
      }
    });
  });
  libs.createEffect(() => {
    setMedalCount((getServiceNetTable("player_medal", playerID()) ?? {
      now_medal: 0
    }).now_medal);
    setArtifactList(Object.values(CustomNetTables.GetTableValue("common", "artifact_list_" + playerID()) ?? {}));
    setItemList(getItemList(Object.values(CustomNetTables.GetTableValue("common", "item_list_" + playerID()) ?? {})));
  });
  const level = () => {
    return local.playerData?.heroLevel ?? 1;
  };
  const mainSectInfo = libs.createMemo(() => {
    const current_sectData = local.sect_info;
    if (!current_sectData) {
      return [];
    }
    return Object.keys(current_sectData).sort((a, b) => (current_sectData[b].exp ?? 0) - (current_sectData[a].exp ?? 0)).slice(0, 3).map(sectName => ({
      sectName,
      ...current_sectData[sectName]
    }));
  });
  return {
    local,
    others,
    playerID,
    artifactList,
    itemList,
    level,
    mainSectInfo,
    medalCount
  };
};
const OverviewPlayerRow = props => {
  const {
    local,
    others,
    playerID,
    artifactList,
    itemList,
    level,
    mainSectInfo,
    medalCount
  } = useOverviewPlayerRow(props);
  return (libs.createComponent(EOM_Panel.EOM_Panel, {
      get classList() {
        return {
          BorderBottom: !isGroupMode() || props.index % 2 == 0
        };
      },
      get className() {
        return libs.classNames("OverviewPlayerRow", "Rank" + (others.index + 1), {
          Title: others.index == -1,
          selfRow: Players.GetLocalPlayer() == playerID(),
          oddRow: others.index >= 0 && others.index % 2 == 0
        });
      },
      flowChildren: "right",
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return local.playerData != undefined;
          },
          fallback: () => [libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 1);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                text: "#ScoreBoard_PlayerInfo"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 5);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#ScoreBoard_Record"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 6);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#ScoreBoard_Win"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 7);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#Scoreboard_Title_TotalGold"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 4);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#TalentBranch_Title"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 8);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#ScoreBoard_MainSect"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 9);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#Item"
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 10);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#94A2B0",
                text: "#Scoreboard_Title_Artifact"
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return getGameplayModuleState("card_effect");
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 13);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    align: "center center",
                    color: "#94A2B0",
                    get text() {
                      return isGroupMode() ? "#TeamCard" : "#CardEffect";
                    }
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 20);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                width: "60px",
                align: "center center",
                style: {
                  textAlign: "center"
                },
                color: "#94A2B0",
                text: "#HeroShard"
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return getGameplayModuleState("rune_task");
            },
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 11);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    width: "60px",
                    align: "center center",
                    style: {
                      textAlign: "center"
                    },
                    color: "#94A2B0",
                    text: "#RuneReward"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 12);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    width: "60px",
                    align: "center center",
                    style: {
                      textAlign: "center"
                    },
                    color: "#94A2B0",
                    text: "#GameState_RuneTask"
                  });
                }
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return getGameplayModuleState("greevil");
            },
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 14);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    width: "84px",
                    align: "center center",
                    style: {
                      textAlign: "center"
                    },
                    color: "#94A2B0",
                    text: "#Gameplay_Greevil"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 15);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    width: "96px",
                    align: "center center",
                    style: {
                      textAlign: "center"
                    },
                    color: "#94A2B0",
                    text: "#Greevil_Shop"
                  });
                }
              })];
            }
          })],
          get children() {
            return (() => {
              const playerInfo = () => local.playerData;
              getGameplayModuleState("rune_task");
              const [runeTaskData, setRuneTaskData] = libs.createSignal();
              const updateRuneTaskData = playerID => {
                let data = CustomNetTables.GetTableValue("common", "rune_task_" + playerID);
                if (data) {
                  setRuneTaskData(data);
                } else {
                  setRuneTaskData();
                }
              };
              const hasRuneTask = () => {
                let has = false;
                const data = runeTaskData();
                if (data) {
                  has = true;
                }
                return has;
              };
              const heroName = () => playerInfo().heroName;
              const [isMuted, setMuted] = libs.createSignal(false);
              const updateMuteState = () => {
                const muteList = Object.values(getPlayerData(Players.GetLocalPlayer(), "muteList") ?? []);
                const targetID = playerID();
                if (muteList.includes(targetID)) {
                  setMuted(true);
                } else {
                  setMuted(false);
                }
              };
              const runeRewardLv = () => {
                return (playerInfo().trait == undefined ? 0 : 1) + (playerInfo().trait2 == undefined ? 0 : 1);
              };
              libs.createEffect(libs.on(playerID, v => {
                updateMuteState();
                updateRuneTaskData(v);
              }));
              libs.onMount(() => {
                const gameEventListeners = [];
                const NetTableListeners = [];
                if (!isSpectator()) {
                  NetTableListeners.push(useNetTableKeyHasDefaultValue("player_data", Players.GetLocalPlayer().toString(), data => {
                    updateMuteState();
                  }));
                }
                NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("common", (_, key, value) => {
                  if (key == "rune_task_" + playerID()) {
                    updateRuneTaskData(playerID());
                  }
                }));
                libs.onCleanup(() => {
                  gameEventListeners.forEach(id => GameEvents.Unsubscribe(id));
                  NetTableListeners.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
                });
              });
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 1);
                },
                get children() {
                  return [libs.createComponent(PlayerOverviewInfo, {
                    get hide_health() {
                      return isGroupMode();
                    },
                    get playerID() {
                      return playerID();
                    },
                    get player_info() {
                      return playerInfo();
                    },
                    get level() {
                      return level();
                    },
                    get medal_count() {
                      return medalCount();
                    },
                    show_medal: true,
                    get order() {
                      return others.index + 1;
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    verticalAlign: "center",
                    marginLeft: "150px",
                    marginRight: "6px",
                    width: "100%",
                    height: "70%",
                    get customTooltip() {
                      return {
                        name: "player_profile",
                        playerID: playerID()
                      };
                    }
                  }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                    align: "right top",
                    margin: "4px",
                    get visible() {
                      return libs.memo(() => !!!isSpectator())() && playerID() != Players.GetLocalPlayer();
                    },
                    get className() {
                      return libs.classNames("MutePlayerButton", {
                        Muted: isMuted()
                      });
                    },
                    onactivate: self => {
                      GameEvents.SendCustomEventToServer("mute_player", {
                        targetPlayerID: playerID(),
                        state: isMuted() ? 0 : 1
                      });
                      self.enabled = false;
                      $.Schedule(0.1, () => {
                        self.enabled = true;
                      });
                    },
                    tooltip_text: "#mutePlayer"
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 5);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    className: "WinLoss",
                    get text() {
                      return `${playerInfo().totalWin}/${playerInfo().totalLose}`;
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 6);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    className: "WinLoss",
                    get text() {
                      return playerInfo().winStack;
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 7);
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "TotalGold",
                    flowChildren: "right",
                    verticalAlign: "center",
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        horizontalAlign: "center",
                        flowChildren: "right",
                        get children() {
                          return [libs.createComponent(EOM_Icon.EOM_Icon, {
                            get src() {
                              return getSrcPath("icon/icon_gold_bevel_psd.png");
                            },
                            width: "24px",
                            height: "24px"
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            verticalAlign: "center",
                            get text() {
                              return playerInfo().totalGold;
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 4);
                },
                get children() {
                  return libs.createComponent(libs.Show, {
                    get when() {
                      return libs.memo(() => !!heroName())() && heroName().indexOf("neu") == -1;
                    },
                    get children() {
                      return libs.createComponent(TalentTree.TalentTree, {
                        get heroName() {
                          return heroName();
                        },
                        get playerID() {
                          return playerID();
                        },
                        showTooltip: true
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 8);
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "MainSectInfo",
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return mainSectInfo();
                        },
                        children: (sectInfo, index) => {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return sectInfo().exp > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "MainSect",
                                get children() {
                                  return [libs.createComponent(SectIcon.SectIcon, {
                                    get sectName() {
                                      return sectInfo().sectName;
                                    },
                                    active: true
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    get text() {
                                      return sectInfo().exp;
                                    }
                                  })];
                                }
                              });
                            }
                          });
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 9);
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ArtifactList",
                    get className() {
                      return libs.classNames("inventory", "Slot" + itemList().length);
                    },
                    flowChildren: "right",
                    get children() {
                      return [...Array(4)].map((_, index) => {
                        const itemName = () => itemList()?.[index] ?? "";
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return index != 3 || itemName() != "" && itemName() != "null";
                          },
                          get children() {
                            return libs.createComponent(EOM_Panel.EOM_Panel, {
                              className: "Artifact",
                              hittest: false,
                              get children() {
                                return libs.createComponent(libs.Show, {
                                  get when() {
                                    return itemName() != "";
                                  },
                                  get children() {
                                    return libs.createComponent(ItemImage.ItemImage, {
                                      width: "100%",
                                      height: "100%",
                                      get itemName() {
                                        return itemName();
                                      }
                                    });
                                  }
                                });
                              }
                            });
                          }
                        });
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 10);
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "ArtifactList",
                    className: "inventory",
                    flowChildren: "right",
                    get children() {
                      return [...Array(3)].map((_, index) => {
                        const itemName = () => artifactList()?.[index] ?? "";
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          className: "Artifact",
                          hittest: false,
                          get children() {
                            return libs.createComponent(libs.Show, {
                              get when() {
                                return itemName() != "";
                              },
                              get children() {
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  get customTooltip() {
                                    return {
                                      name: "equipment",
                                      itemname: itemName()
                                    };
                                  },
                                  get children() {
                                    const _el$ = libs.createElement("DOTAItemImage", {
                                      id: "ArtifactImage",
                                      get itemname() {
                                        return itemName();
                                      },
                                      showtooltip: false
                                    }, null);
                                    libs.effect(_$p => libs.setProp(_el$, "itemname", itemName(), _$p));
                                    return _el$;
                                  }
                                });
                              }
                            });
                          }
                        });
                      });
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return getGameplayModuleState("card_effect");
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 13);
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        "class": "CardEffect",
                        tooltipPosition: "left",
                        get customTooltip() {
                          return {
                            name: "card_effect",
                            playerID: playerID(),
                            team_mode: Number(isGroupMode())
                          };
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 20);
                },
                get children() {
                  return libs.createComponent(ShardAbility.ShardAbility, {
                    get heroName() {
                      return heroName();
                    },
                    get playerID() {
                      return playerID();
                    },
                    showTooltip: true
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return getGameplayModuleState("rune_task");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 11);
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        get ["class"]() {
                          return libs.classNames("RuneRewardIcon", "LV" + runeRewardLv());
                        },
                        get customTooltip() {
                          return {
                            name: "rune_reward",
                            player_id: playerID()
                          };
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get className() {
                          return libs.classNames("RuneRewardCount", "LV" + runeRewardLv());
                        },
                        get text() {
                          return `Lv.${runeRewardLv()}`;
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 12);
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        get ["class"]() {
                          return libs.classNames("RuneTaskIcon", {
                            HeightLight: hasRuneTask()
                          });
                        },
                        get customTooltip() {
                          return {
                            name: "trait_task",
                            playerID: playerID()
                          };
                        }
                      });
                    }
                  })];
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return getGameplayModuleState("greevil");
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 14);
                    },
                    get children() {
                      return libs.createComponent(greevil_icon.GreevilIcon, {
                        get playerID() {
                          return playerID();
                        },
                        mode: "icon_only"
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 15);
                    },
                    get children() {
                      return libs.createComponent(greevil_icon.GreevilIcon, {
                        get playerID() {
                          return playerID();
                        },
                        mode: "shop_record"
                      });
                    }
                  })];
                }
              })];
            })();
          }
        });
      }
    })
  );
};

const SectOverviewLayout = props => {
  const [local, others] = libs.splitProps(props, ["allPlayerData", "playerOrder", "sect_data", "hasVip", "isPlayerDead"]);
  const playerOrder = () => local.playerOrder;
  const [selectedPlayerID, setSelectedPlayerID] = libs.createSignal(Players.GetLocalPlayer());
  if (isSpectator()) {
    let inited = false;
    libs.createEffect(() => {
      if (!inited && Object.keys(local.allPlayerData).length > 0) {
        inited = true;
        setSelectedPlayerID(Number(Object.keys(local.allPlayerData)[0]));
      }
    });
  }
  const getSectDetail = () => {
    const data = CustomNetTables.GetTableValue("sect_data", "ability_upgrade_" + selectedPlayerID()) ?? {};
    const tempData = CustomNetTables.GetTableValue("sect_data", "temp_ability_upgrade_" + selectedPlayerID()) ?? {};
    for (const aid in tempData) {
      if (tempData[aid].level > 0) {
        if (data[aid] == undefined) {
          data[aid] = {
            level: tempData[aid].level
          };
        } else {
          data[aid].level = Math.min(KeyValues.AbilityUpgradesKv[aid].MaxLevel, data[aid].level + tempData[aid].level);
        }
      }
    }
    return data;
  };
  const [sectDetail, setSectDetail] = libs.createSignal(getSectDetail());
  const [banListNet, setBanListNet] = libs.createSignal(CustomNetTables.GetTableValue("common", "ban_list"));
  const banList = () => Object.values(banListNet() ?? {});
  const selectedSectInfo = libs.createMemo(() => {
    return local.sect_data?.[selectedPlayerID()] ?? {};
  });
  const [hasReturnPrivilege, setHasReturnPrivilege] = libs.createSignal(false);
  libs.createEffect(libs.on(selectedPlayerID, v => {
    setSectDetail(getSectDetail());
  }));
  libs.onMount(() => {
    const gameEventIDList = [];
    const NetTableListeners = [];
    gameEventIDList.push(useNetData("player_regression_data", data => {
      setHasReturnPrivilege(data?.in_7days == true);
    }, Players.GetLocalPlayer()));
    NetTableListeners.push(useNetTableKey("common", "ban_list", data => {
      setBanListNet(data);
    }));
    NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("sect_data", (tableName, key, value) => {
      const specifiedKey = "ability_upgrade_";
      if (key.includes(specifiedKey)) {
        const playerID = Number(key.slice(specifiedKey.length));
        if (playerID == selectedPlayerID()) {
          setSectDetail(getSectDetail());
        }
      }
    }));
    libs.onCleanup(() => {
      for (const id of NetTableListeners) {
        CustomNetTables.UnsubscribeNetTableListener(id);
      }
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const sectList = libs.createMemo(() => {
    const kv = KeyValues.SectAbilitiesKv;
    if (!kv) return [];
    return Object.keys(kv).filter((sectName, index) => {
      for (const key in banList()) {
        if (banList()[key] == sectName) {
          return false;
        }
      }
      return true;
    });
  });
  const parseSectDetailData = init_data => {
    const data = {};
    if (init_data) {
      const kv = KeyValues.AbilityUpgradesKv;
      for (const aid in init_data) {
        const level = init_data[aid].level;
        const kvData = kv[aid];
        if (kvData) {
          const sect = kvData.sect ?? "";
          const rarity = ["n", "r", "sr"].indexOf(kvData.rarity ?? "") + 1;
          if (sect != "" && rarity > 0) {
            const arrSect = sect.split("|");
            if (arrSect) {
              arrSect.forEach(sect => {
                if (data[sect] == undefined) {
                  data[sect] = {};
                }
                if (data[sect][rarity] == undefined) {
                  data[sect][rarity] = {};
                }
                data[sect][rarity][aid] = level;
              });
            }
          }
        }
      }
    }
    return data;
  };
  const [parsedSectDetail, setParsedSectDetail] = libs.createSignal(parseSectDetailData(sectDetail()));
  libs.createEffect(() => {
    setSectDetail(CustomNetTables.GetTableValue("sect_data", "ability_upgrade_" + selectedPlayerID()));
  });
  libs.createEffect(() => {
    setParsedSectDetail(parseSectDetailData(sectDetail()));
  });
  const [setting, _setSetting] = libs.createSignal(CustomNetTables.GetTableValue("common", "settings"));
  const isCheatMode = () => setting()?.is_cheat_mode == 1;
  const showContent = () => isCheatMode() || isSpectator() || local.isPlayerDead && (local.hasVip || hasReturnPrivilege());
  libs.createEffect(() => {
    const id = CustomNetTables.SubscribeNetTableListener("common", function (_, k, v) {
      if (k === "settings") {
        _setSetting(v);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "SectOverviewLayout",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return showContent();
        },
        fallback: () => libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "SectOverviewBanned",
          get children() {
            return libs.createComponent(EOM_Label.EOM_Label, {
              text: "#SectOverviewBanned"
            });
          }
        }),
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            style: {
              borderTop: "1px solid #73737366",
              borderLeft: "1px solid #73737366",
              borderBottom: "1px solid #73737366"
            },
            flowChildren: "down",
            align: "center center",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "Title",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("columns", 1);
                    },
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        text: "#ScoreBoard_HeroSect"
                      });
                    }
                  }), libs.memo(() => [...Array(8)].map((_, index) => {
                    const sectName = () => sectList()[index] != undefined ? sectList()[index] : undefined;
                    const sectInfo = () => {
                      const current_sectName = sectName();
                      if (current_sectName) {
                        if (selectedSectInfo()?.[current_sectName]) {
                          return selectedSectInfo()?.[current_sectName];
                        }
                      }
                    };
                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("columns", 2);
                      },
                      get children() {
                        return libs.createComponent(libs.Show, {
                          get when() {
                            return sectName() != undefined;
                          },
                          get children() {
                            return libs.createComponent(SectTitle, {
                              get sect_info() {
                                return sectInfo();
                              },
                              get sect_name() {
                                return sectName();
                              }
                            });
                          }
                        });
                      }
                    });
                  }))];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                height: "560px",
                flowChildren: "right",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PlayerList",
                    get className() {
                      return libs.classNames("columns", 1);
                    },
                    get children() {
                      return libs.createComponent(libs.Index, {
                        get each() {
                          return playerOrder();
                        },
                        children: (playerID, index) => {
                          const playerInfo = () => local.allPlayerData[Number(playerID())];
                          const level = () => playerInfo().heroLevel ?? 1;
                          const playerDied = () => playerInfo()?.rank != undefined;
                          const buttonEnable = () => isCheatMode() || Number(playerID()) != selectedPlayerID() && (isSpectator() || playerDied());
                          return libs.createComponent(EOM_Button.EOM_BaseButton, {
                            get className() {
                              return libs.classNames("PlayerInfoButton", {
                                Selected: Number(playerID()) == selectedPlayerID(),
                                IsSelf: Number(playerID()) == Players.GetLocalPlayer(),
                                Alive: !isSpectator() && !playerDied()
                              });
                            },
                            get enabled() {
                              return buttonEnable();
                            },
                            onactivate: () => setSelectedPlayerID(Number(playerID())),
                            get children() {
                              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "SelectedBG"
                              }), libs.createComponent(PlayerOverviewInfo, {
                                get hide_health() {
                                  return isGroupMode();
                                },
                                get playerID() {
                                  return Number(playerID());
                                },
                                get player_info() {
                                  return playerInfo();
                                },
                                get level() {
                                  return level();
                                },
                                order: index + 1
                              })];
                            }
                          });
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "SectDetails",
                    get children() {
                      return [...Array(8)].map((_, index) => {
                        const sectName = () => sectList()[index] != undefined ? sectList()[index] : undefined;
                        const sect_detail = libs.createMemo(() => {
                          const current_sectName = sectName();
                          if (current_sectName) {
                            return parsedSectDetail()[current_sectName];
                          }
                        });
                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                          get className() {
                            return libs.classNames("columns", 2);
                          },
                          flowChildren: "down",
                          get children() {
                            return [...Array(3)].map((_, index) => {
                              const rarity = 3 - index;
                              const sectList = () => Object.keys(sect_detail()?.[rarity] ?? {}).sort((a, b) => (sect_detail()?.[rarity]?.[b] ?? 0) - (sect_detail()?.[rarity]?.[a] ?? 0));
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get className() {
                                  return libs.classNames("SectRow", "Rarity" + rarity, "Count" + sectList().length);
                                },
                                get children() {
                                  return libs.createComponent(libs.Index, {
                                    get each() {
                                      return sectList();
                                    },
                                    children: (aid, i) => {
                                      const filePath = () => {
                                        const abilityUpgradeInfo = KeyValues.AbilityUpgradesKv?.[aid()];
                                        if (abilityUpgradeInfo) {
                                          return `url('file://{images}/spellicons/${abilityUpgradeInfo.Texture}.png')`;
                                        }
                                      };
                                      const a_level = () => {
                                        return sect_detail()?.[rarity]?.[aid()] ?? 0;
                                      };
                                      const starCount = [5, 3, 1][rarity - 1];
                                      const arr1_count = Math.min(starCount, 3);
                                      const arr2_count = starCount - 3;
                                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                                        className: "HandBookContentPickerItem",
                                        get customTooltip() {
                                          return {
                                            name: "sect_ability",
                                            abilityUpgradeID: aid(),
                                            level: a_level()
                                          };
                                        },
                                        get children() {
                                          return [libs.createComponent(EOM_Image.EOM_Image, {
                                            className: "DOTAAbilityImage",
                                            get backgroundImage() {
                                              return filePath();
                                            }
                                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                            get className() {
                                              return libs.classNames("StarsContainer", {
                                                doubleRow: arr2_count > 0
                                              });
                                            },
                                            get children() {
                                              return [libs.createComponent(libs.Show, {
                                                when: arr2_count > 0,
                                                get children() {
                                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                                    className: "StarRow",
                                                    y: "-10px",
                                                    get children() {
                                                      return [...Array(arr2_count)].map((_, index) => {
                                                        return libs.createComponent(EOM_Panel.EOM_Panel, {
                                                          get className() {
                                                            return libs.classNames("StarIcon", {
                                                              Active: a_level() > 3 + index
                                                            });
                                                          }
                                                        });
                                                      });
                                                    }
                                                  });
                                                }
                                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                                className: "StarRow",
                                                get children() {
                                                  return [...Array(arr1_count)].map((_, index) => {
                                                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                                                      get className() {
                                                        return libs.classNames("StarIcon", {
                                                          Active: a_level() > index
                                                        });
                                                      }
                                                    });
                                                  });
                                                }
                                              })];
                                            }
                                          })];
                                        }
                                      });
                                    }
                                  });
                                }
                              });
                            });
                          }
                        });
                      });
                    }
                  })];
                }
              })];
            }
          });
        }
      });
    }
  });
};
const SectTitle = props => {
  const [local, others] = libs.splitProps(props, ["sect_info", "sect_name"]);
  const level = () => local.sect_info?.level ?? 0;
  const maxLevel = () => 4 + (local.sect_info?.bonusLevel ?? 0);
  const sectName = () => local.sect_name;
  const exp = () => local.sect_info?.exp ?? 0;
  const maxExp = () => local.sect_info?.maxExp ?? 4;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("SectTitle", {
        noExp: exp() == 0
      });
    },
    get tooltip() {
      return "#DOTA_Tooltip_ability_" + sectName();
    },
    get children() {
      return [" ", (() => {
        const _el$ = libs.createElement("Panel", {}, null),
          _el$2 = libs.createElement("Panel", {}, _el$);
        libs.setProp(_el$, "className", "ExpPanel");
        libs.setProp(_el$2, "className", "ExpProgressBG");
        libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
          className: "ExpProgress",
          get width() {
            return level() / maxLevel() * 59 + "px";
          }
        }), null);
        libs.insert(_el$, libs.createComponent(GenericPanel.CImage, {
          className: "ExpShield"
        }), null);
        libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
          className: "ExpLabel",
          get text() {
            return exp();
          }
        }), null);
        libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
          className: "ExpMaxLabel",
          get text() {
            return "/" + maxExp();
          }
        }), null);
        return _el$;
      })(), libs.createComponent(SectIcon.SectIcon, {
        get sectName() {
          return sectName();
        },
        get active() {
          return exp() > 0;
        }
      })];
    }
  });
};

const useScoreBoard = () => {
  const [show, setShow] = libs.createSignal(false);
  const [playerPrivilege, setPlayerPrivilege] = libs.createSignal(CustomNetTables.GetTableValue("common", "player_privilege")?.[Players.GetLocalPlayer()]);
  const hasVip = () => (playerPrivilege()?.sect_statistics ?? 0) > 0;
  const [allPlayerData, setAllPlayerData] = libs.createStore((() => {
    const data = {};
    const player_data = CustomNetTables.GetAllTableValues("player_data");
    if (player_data) {
      Object.values(player_data).forEach(v => {
        data[Number(v.key)] = v.value;
      });
    }
    return data;
  })());
  const [sectData, setSectData] = libs.createStore((() => {
    const data = {};
    const sect_data = CustomNetTables.GetAllTableValues("sect_data");
    if (sect_data) {
      sect_data.forEach((netTable, _index) => {
        if (netTable.key.includes("sect_data_")) {
          const playerID = Number(netTable.key.slice(10));
          if (typeof playerID == "number" && Players.IsValidPlayerID(playerID)) {
            data[playerID] = netTable.value;
          }
        }
      });
    }
    return data;
  })());
  const playerOrder = () => {
    return Object.keys(allPlayerData).sort((a, b) => {
      const health_a = allPlayerData[Number(a)].health;
      const health_b = allPlayerData[Number(b)].health;
      const rank_a = allPlayerData[Number(a)].rank ?? 8;
      const rank_b = allPlayerData[Number(b)].rank ?? 8;
      return multiCompare(...[health_b - health_a, rank_a - rank_b, Number(a) - Number(b)]);
    });
  };
  const [selecteindex, setindex] = libs.createSignal(1);
  const isPlayerDead = libs.createMemo(() => {
    return allPlayerData[Players.GetLocalPlayer()]?.rank != undefined;
  });
  const ScoreBoardEnable = state => {
    return !(state == "GameState_HeroSelection" || state == "GameState_CitySelection" || state == "GameState_CityEnd" || state == "GameState_HeroBan" || state == "GameState_None");
  };
  const [gameState, setGameState] = libs.createSignal(getGameState());
  libs.createEffect(() => {
    if (!ScoreBoardEnable(gameState())) {
      setShow(false);
    }
  });
  libs.createEffect(() => {
    if (show()) GameEvents.SendCustomGameEventToServer('report_open_window', {
      window_type: 3
    });
  });
  libs.onMount(() => {
    const NetTableListeners = [];
    const GameEventListenerIDs = [];
    NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("sect_data", (_, key, value) => {
      if (key.includes("sect_data_")) {
        const playerID = Number(key.slice(10));
        if (typeof playerID == "number" && Players.IsValidPlayerID(playerID)) {
          setSectData(playerID, value);
        }
      }
    }));
    NetTableListeners.push(useNetTableKey("common", "player_privilege", data => {
      if (data) {
        setPlayerPrivilege(data?.[Players.GetLocalPlayer()]);
      }
    }));
    NetTableListeners.push(useNetTableKey("common", "game_state", data => {
      setGameState(data?.state ?? "GameState_None");
    }));
    GameEventListenerIDs.push(GameEvents.Subscribe("custom_ui_toggle_windows", eventData => {
      if (!ScoreBoardEnable(gameState())) return;
      if (eventData.window_name == "MenuButton_scoreboard") {
        if (eventData.state) {
          setShow(eventData.state == 1);
        } else {
          setShow(v => !v);
        }
      } else {
        setShow(false);
      }
    }));
    NetTableListeners.push(CustomNetTables.SubscribeNetTableListener("player_data", (tableName, key, data) => {
      let _playerID = Number(key) ?? -1;
      if (Players.IsValidPlayerID(_playerID)) {
        setAllPlayerData(_playerID, data);
      }
    }));
    GameEventListenerIDs.push(GameEvents.Subscribe("custom_ui_toggle_flyout_scoreboard", event => {
      if (!ScoreBoardEnable(gameState())) return;
      setShow(event.visible == 1);
    }));
    libs.onCleanup(() => {
      for (const id of GameEventListenerIDs) {
        GameEvents.Unsubscribe(id);
      }
      for (const id of NetTableListeners) {
        CustomNetTables.UnsubscribeNetTableListener(id);
      }
    });
  });
  return {
    show,
    selecteindex,
    setindex,
    playerOrder,
    hasVip,
    isPlayerDead,
    allPlayerData,
    sectData
  };
};
function ScoreBoard() {
  let menuList = ["#ScoreBoard_overview", "#ScoreBoard_sect", "#ScoreBoard_log", "#ScoreBoard_message"];
  let viperIndex = [1];
  if (isSpectator()) {
    menuList = ["#ScoreBoard_overview", "#ScoreBoard_sect", "#ScoreBoard_log"];
    viperIndex = [];
  }
  const {
    show,
    selecteindex,
    setindex,
    playerOrder,
    hasVip,
    isPlayerDead,
    allPlayerData,
    sectData
  } = useScoreBoard();
  return libs.createComponent(EOM_Popup.EOM_Popup, {
    id: "ScoreBoardMain",
    size: "large",
    title: "#MenuButton_scoreboard",
    get className() {
      return libs.classNames({
        EOM_PopupMainShow: show()
      });
    },
    verticalAlign: "top",
    marginTop: "80px",
    onClose: () => ToggleWindows("MenuButton_scoreboard", false),
    get children() {
      return libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ScoreBoardContent",
        get children() {
          return [libs.createComponent(ScoreBoardTabButtons.ScoreBoardTabButtons, {
            group: "scoreboard_Breadcrumb",
            list: menuList,
            vipIndex: viperIndex,
            selected: 1,
            onChange: (index, item) => {
              setindex(index);
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            width: "100%",
            height: "100%",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get ["class"]() {
                  return libs.classNames("MenuContent", {
                    Show: selecteindex() == 1
                  });
                },
                get children() {
                  return libs.createComponent(CommonOverviewLayout, {
                    allPlayerData: allPlayerData,
                    get playerOrder() {
                      return playerOrder();
                    },
                    sect_data: sectData,
                    get isPlayerDead() {
                      return isPlayerDead();
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get ["class"]() {
                  return libs.classNames("MenuContent", {
                    Show: selecteindex() == 2
                  });
                },
                get children() {
                  return libs.createComponent(SectOverviewLayout, {
                    allPlayerData: allPlayerData,
                    get playerOrder() {
                      return playerOrder();
                    },
                    sect_data: sectData,
                    get hasVip() {
                      return hasVip();
                    },
                    get isPlayerDead() {
                      return isPlayerDead();
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get ["class"]() {
                  return libs.classNames("MenuContent", {
                    Show: selecteindex() == 3
                  });
                },
                get children() {
                  return libs.createComponent(CombatLogLayout, {
                    allPlayerData: allPlayerData,
                    get playerOrder() {
                      return playerOrder();
                    },
                    sect_data: sectData,
                    get hasVip() {
                      return hasVip();
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get ["class"]() {
                  return libs.classNames("MenuContent", {
                    Show: selecteindex() == 4
                  });
                },
                get children() {
                  return libs.createComponent(MessageBox, {});
                }
              })];
            }
          })];
        }
      });
    }
  });
}
const MessageBox = () => {
  const [messages, setMessages] = libs.createSignal([]);
  const [loading, setLoading] = libs.createSignal(true);
  libs.onMount(() => {
    const GameEventListenerIDs = [];
    GameEventListenerIDs.push(GameEvents.Subscribe("combat_messages", data => {
      setLoading(false);
      if (data?.data != undefined) {
        const list = JSON.parse(data.data);
        const reconstruct = [];
        if (list.length != undefined) {
          list.forEach(event => {
            let dialogVariables = {};
            const params = {
              message: event.message ? "#" + event.message : ""
            };
            let hasPercentage = false;
            let valueKey = "";
            for (const key in event) {
              const value = event[key];
              if (key == "player_id" && typeof value == "number") {
                params.player_id = value;
              } else if (key.includes("string")) {
                if (key == "string_attribute" && value.startsWith("dota_tooltip_item_variable_item_")) {
                  let textKey = $.Localize("#" + value).replace(/[+]/g, '');
                  hasPercentage = textKey[0] == "%";
                  if (hasPercentage) {
                    textKey = textKey.slice(1);
                  }
                  dialogVariables[key] = replaceAll(textKey);
                } else {
                  if ($.Localize("#" + value) == "#" + value) {
                    valueKey = key;
                    dialogVariables[key] = value;
                  } else {
                    dialogVariables[key] = $.Localize("#" + value);
                  }
                }
              } else if (key.includes("int")) {
                dialogVariables[key] = value;
              } else if (key.includes("day")) {
                let diff = Math.floor(value - Date.now() / 1000);
                let days = Math.max(0, Math.floor(diff / 86400));
                dialogVariables[key] = days;
              }
            }
            if (hasPercentage && valueKey != "" && dialogVariables[valueKey]) {
              dialogVariables[valueKey] = dialogVariables[valueKey] + "%";
            }
            params.dialogVariables = dialogVariables;
            reconstruct.push(params);
          });
        }
        setMessages(reconstruct);
      }
    }));
    if (!isSpectator()) {
      GameEventListenerIDs.push(useClientSideEvent("notify_combat", event => {
        let dialogVariables = {};
        const params = {
          message: event.message ? "#" + event.message : ""
        };
        let hasPercentage = false;
        let valueKey = "";
        for (const key in event) {
          const value = event[key];
          if (key == "player_id" && typeof value == "number") {
            params.player_id = value;
          } else if (key.includes("string")) {
            if (key == "string_attribute" && value.startsWith("dota_tooltip_item_variable_item_")) {
              let textKey = $.Localize("#" + value).replace(/[+]/g, '');
              hasPercentage = textKey[0] == "%";
              if (hasPercentage) {
                textKey = textKey.slice(1);
              }
              dialogVariables[key] = replaceAll(textKey);
            } else {
              if ($.Localize("#" + value) == "#" + value) {
                valueKey = key;
                dialogVariables[key] = value;
              } else {
                dialogVariables[key] = $.Localize("#" + value);
              }
            }
          } else if (key.includes("int")) {
            dialogVariables[key] = value;
          } else if (key.includes("day")) {
            let diff = Math.floor(value - Date.now() / 1000);
            let days = Math.max(0, Math.floor(diff / 86400));
            dialogVariables[key] = days;
          }
        }
        if (hasPercentage && valueKey != "" && dialogVariables[valueKey]) {
          dialogVariables[valueKey] = dialogVariables[valueKey] + "%";
        }
        params.dialogVariables = dialogVariables;
        setMessages([...messages(), params]);
      }));
      GameEvents.SendCustomEventToServer("request_messages", {
        playerID: Players.GetLocalPlayer()
      });
    }
    libs.onCleanup(() => GameEventListenerIDs.forEach(id => GameEvents.Unsubscribe(id)));
  });
  return [libs.createComponent(libs.Show, {
    get when() {
      return loading();
    },
    get children() {
      return libs.createComponent(EOM_Icon.EOM_Icon, {
        type: "Spinner",
        horizontalAlign: "center",
        marginTop: "300px",
        width: "34px",
        height: "34px",
        spin: true
      });
    }
  }), libs.createComponent(EOM_Panel.EOM_Panel, {
    padding: "16px",
    width: "80%",
    height: "80%",
    marginBottom: "50px",
    align: "center center",
    flowChildren: "down",
    scroll: "y",
    backgroundColor: "#161a2aaa",
    id: "message_box",
    get children() {
      return libs.createComponent(libs.For, {
        get each() {
          return messages();
        },
        children: message => libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "Message",
          get children() {
            return [libs.createComponent(libs.Show, {
              get when() {
                return message.player_id != undefined;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "MessagePlayer",
                  get children() {
                    return [libs.createComponent(Player.PlayerAvatar, {
                      get playerID() {
                        return message.player_id;
                      },
                      get steamID() {
                        return getPlayerData(message.player_id, "steamID");
                      },
                      get ban() {
                        return isNameBan(message.player_id);
                      }
                    }), libs.createComponent(Player.PlayerName, {
                      get playerID() {
                        return message.player_id;
                      },
                      get steamID() {
                        return getPlayerData(message.player_id, "steamID");
                      },
                      get ban() {
                        return isNameBan(message.player_id);
                      }
                    })];
                  }
                });
              }
            }), libs.createComponent(GenericPanel.CLabel, {
              html: true,
              className: "MessageLabel",
              get text() {
                return message.message;
              },
              get dialogVariables() {
                return message.dialogVariables;
              },
              onload: self => {
                self.ScrollParentToMakePanelFit(2, false);
              }
            })];
          }
        })
      });
    }
  })];
};
libs.render(() => libs.createComponent(ScoreBoard, {}), $.GetContextPanel());
$.RegisterEventHandler("DOTACustomUI_SetFlyoutScoreboardVisible", $.GetContextPanel(), bVisible => {
  GameEvents.SendEventClientSide("custom_ui_toggle_flyout_scoreboard", {
    visible: bVisible
  });
});