--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_XP = require('./EOM_XP.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var Heroes = require('./Heroes.js');
var ItemImage = require('./ItemImage.js');
var Player = require('./Player.js');
var SectIcon = require('./SectIcon.js');
var ShardAbility = require('./ShardAbility.js');
var TalentTree = require('./TalentTree.js');
var greevil_icon = require('./greevil_icon.js');
var profile_simplify = require('./profile_simplify.js');
require('./EOM_Countdown.js');
require('./EOM_PortraitFullBody.js');
require('./MedalBadgeIcon.js');
require('./profile_info.js');
require('./RankTierIcon.js');
require('./netdata_utils.js');
require('./game_utils.js');

const getMatchText = matchType => {
  switch (matchType) {
    case 1:
      return "Normal";
    case 2:
      return "Rank";
    case 4:
      return "Rank";
    case 5:
      return "Rank";
    case 6:
      return "Rank";
    case 7:
      return "Normal";
    case 10:
      return "Team";
    case 11:
      return "Team";
    default:
      return "Bot";
  }
};
const ProfileBattleRecords = props => {
  const localPlayerID = Players.GetLocalPlayer();
  const [matchRecords, setMatchRecords] = libs.createSignal();
  const matchRecordsList = () => Object.keys(matchRecords() ?? {});
  const matchCount = () => matchRecordsList().length;
  const [viewingType, setViewingType] = libs.createSignal(0);
  libs.createEffect(libs.on(viewingType, viewing_type => {
    _refreshData();
  }));
  let refreshCD = false;
  const refreshData = () => {
    if (refreshCD) return;
    refreshCD = true;
    $.Schedule(10, () => refreshCD = false);
    _refreshData();
  };
  const _refreshData = () => {
    callAction("match_recent_records", {
      num: 20,
      match_type: viewingType()
    });
    setMatchRecords();
  };
  const [detailData, setDetailData] = libs.createSignal();
  const [matchID, setMatchID] = libs.createSignal(-1);
  const [detailMatchType, setDetailMatchType] = libs.createSignal(3);
  const [detailMatchDate, setDetailMatchDate] = libs.createSignal("");
  const [stage, setStage] = libs.createSignal(1);
  const [loadingData, setLoadingData] = libs.createSignal(false);
  const showMatchDetail = (matchID, matchType, date) => {
    setStage(2);
    setLoadingData(true);
    setDetailData();
    serverRequest("show_match_detail", {
      match_id: matchID.toString()
    }, data => {
      setLoadingData(false);
      if (data.status === 0) {
        setDetailData(data.data.detail);
        setMatchID(data.data.match_id);
        setDetailMatchType(matchType);
        setDetailMatchDate(date);
      }
    });
  };
  libs.createEffect(libs.on(() => props.refresh, _ => {
    if (props.refresh) refreshData();
  }));
  const dropDownElements = [{
    text: "#Type_All",
    type: 0
  }, {
    text: "#MatchType_Normal",
    type: 1
  }, {
    text: "#MatchType_Team",
    type: 10
  }, {
    text: "#MatchType_Rank",
    type: 2
  }, {
    text: "#MatchType_Bot",
    type: 3
  }];
  libs.onMount(() => {
    refreshData();
    useNetData("match_records", data => {
      setMatchRecords(data);
    }, localPlayerID);
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileBattleRecords",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BattleRecordsMain",
        get visible() {
          return stage() == 1;
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "BattleRecordsTitle",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 1);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#BattleRecords_Rank"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 2);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#BattleRecords_Medal"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 3);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#RecordTab_Talent"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 4);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#ScoreBoard_MainSect"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 5);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Item"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 6);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#Artifact"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 7);
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    text: "#BattleRecords_Date"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 8);
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "BattleRecordList",
            scroll: "y",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return matchRecordsList();
                },
                children: (recordIndex, i) => {
                  const recordData = () => matchRecords()[Number(recordIndex())];
                  return libs.createComponent(BattleRecordRow, {
                    index: i,
                    get record_data() {
                      return recordData();
                    },
                    onClick: showMatchDetail
                  });
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            marginTop: "20px",
            width: "100%",
            horizontalAlign: "right",
            get children() {
              return [libs.createComponent(EOM_DropDown.EOM_DropDown, {
                id: "OrderFilterDropDown",
                index: 0,
                menuPosition: "top",
                onChange: (index, item) => {
                  setViewingType(dropDownElements[index].type);
                },
                get children() {
                  return dropDownElements.map((data, index) => libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return data.text;
                    }
                  }));
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                color: "#fff",
                fontSize: "22px",
                textShadow: "0px 0px 4px 2 #00000088",
                text: "#BattleRecords_Count",
                dialogVariables: {
                  count: 20
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                align: "right center",
                backgroundColor: "#111111cc",
                padding: "2px 4px",
                style: {
                  borderRadius: "4px"
                },
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    get text() {
                      return `${matchCount()} / 20`;
                    },
                    color: "#ccc",
                    textShadow: "0px 0px 4px 2 #00000088"
                  });
                }
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BattleDetailsMain",
        get visible() {
          return stage() == 2;
        },
        get children() {
          return [libs.createComponent(EOM_Button.EOM_BaseButton, {
            id: "BackButton",
            onactivate: () => setStage(1),
            get children() {
              return [libs.createComponent(GenericPanel.CImage, {
                id: "BackIcon"
              }), libs.createComponent(GenericPanel.CLabel, {
                id: "BackLabel",
                text: "#UI_BACK"
              })];
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return detailData() != undefined;
            },
            fallback: () => {
              if (loadingData()) {
                return libs.createComponent(EOM_Loading.EOM_Loading, {
                  align: "center center",
                  type: "PointSpin"
                });
              } else {
                return libs.createComponent(EOM_Label.EOM_Label, {
                  align: "center center",
                  id: "BattleDetailFailure",
                  text: "#BattleDetail_Failure"
                });
              }
            },
            get children() {
              return libs.createComponent(BattleDetails, {
                get detail_data() {
                  return detailData();
                },
                get match_id() {
                  return matchID();
                },
                get match_type() {
                  return detailMatchType();
                },
                get date() {
                  return detailMatchDate();
                }
              });
            }
          })];
        }
      })];
    }
  });
};
const BattleRecordRow = props => {
  const recordData = () => props.record_data;
  const selfRecord = libs.createMemo(() => recordData().self_record);
  const selfOid = () => selfRecord().oid;
  const medal_score = () => selfRecord()?.rank_score ?? 0;
  const matchType = () => recordData().match_type;
  const projected = () => (selfRecord()?.projected ?? 0) == 1;
  const earlyExit = () => (selfRecord()?.early_exit ?? 0) == 1;
  const matchScore = () => selfRecord()?.match_score;
  const gamblingScore = () => selfRecord()?.gambling_score ?? 0;
  const kingScoreChange = () => (selfRecord()?.match_score ?? 0) + (selfRecord()?.gambling_score ?? 0);
  const kingScoreText = () => {
    const score = kingScoreChange();
    let str = "";
    if (score >= 0) {
      str += `+${score}`;
    } else {
      str += `${score}`;
    }
    return str;
  };
  const mainSects = libs.createMemo(() => {
    const data = JSON.parseSafe(selfRecord().sect);
    if (typeof data == "object") {
      return data;
    }
  });
  const sectList = () => Object.keys(mainSects() ?? {}).sort((a, b) => mainSects()[b].exp - mainSects()[a].exp);
  const talent_tree = () => selfRecord().talent_tree;
  const equipmentList = libs.createMemo(() => {
    const data = JSON.parseSafe(selfRecord().equipment);
    if (Array.isArray(data)) {
      let list = data.filter(v => KeyValues.ItemsKv[v] != undefined);
      list = list.sort((a, b) => (KeyValues.ItemsKv[a]?.ItemLevel ?? 99) - (KeyValues.ItemsKv[b]?.ItemLevel ?? 99));
      return list;
    }
    return ["", "", ""];
  });
  const artifactList = libs.createMemo(() => {
    const data = JSON.parseSafe(selfRecord().artifact);
    if (Array.isArray(data)) {
      return data;
    }
  });
  const heroName = () => GetHeroNameByGoodID(selfRecord().hero_id);
  const rank = () => selfRecord().ranking;
  const hero_level = () => selfRecord().hero_level;
  const enableShowDetail = () => matchType() != 3 && selfRecord().status == 2;
  const matchTimeText = () => {
    const startTime = recordData().start_time;
    const date = new Date(startTime * 1000);
    let month = (date.getMonth() + 1).toString();
    let day = date.getDate().toString();
    let hour = date.getHours().toString();
    let minutes = date.getMinutes().toString();
    return `${month.length > 1 ? month : "0" + month}-${day.length > 1 ? day : "0" + day}  ${hour.length > 1 ? hour : "0" + hour}:${minutes.length > 1 ? minutes : "0" + minutes}`;
  };
  const matchText = () => `#MatchType_${getMatchText(matchType())}`;
  return (() => {
    const _el$ = libs.createElement("Panel", {}, null),
      _el$2 = libs.createTextNode(`;`, _el$),
      _el$3 = libs.createTextNode(`;`, _el$),
      _el$4 = libs.createTextNode(`;`, _el$),
      _el$5 = libs.createTextNode(`;`, _el$);
    libs.setProp(_el$, "className", "BattleRecordRow");
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 1);
      },
      get children() {
        return [libs.createComponent(EOM_Panel.EOM_Panel, {
          get className() {
            return libs.classNames("RankInfo", {
              Win: rank() <= 4 && !earlyExit(),
              EarlyExit: earlyExit()
            });
          },
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "Rank",
              get children() {
                return [libs.createComponent(GenericPanel.CImage, {
                  get className() {
                    return libs.classNames("PlayerRankBG", "Rank" + rank());
                  }
                }), libs.createComponent(GenericPanel.CLabel, {
                  className: "PlayerRank",
                  get text() {
                    return libs.memo(() => rank() <= 3)() ? "" : rank();
                  }
                })];
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return earlyExit();
              },
              fallback: () => libs.createComponent(libs.Show, {
                get when() {
                  return rank() <= 4;
                },
                fallback: () => libs.createComponent(GenericPanel.CLabel, {
                  className: "VictoryDefeat",
                  text: "#HandBook_Sub_Nav_Lose"
                }),
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    className: "VictoryDefeat",
                    text: "#HandBook_Sub_Nav_Win"
                  });
                }
              }),
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  id: "EarlyExit",
                  className: "VictoryDefeat",
                  text: "#EarlyExit"
                });
              }
            })];
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "HeroInfo",
          get children() {
            return libs.createComponent(Heroes.HeroImage, {
              get hero_name() {
                return heroName();
              },
              get oid() {
                return selfOid();
              },
              get children() {
                return libs.createComponent(EOM_XP.EOM_XP, {
                  get level() {
                    return hero_level();
                  }
                });
              }
            });
          }
        })];
      }
    }), _el$2);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 2);
      },
      get children() {
        return [libs.createComponent(GenericPanel.CLabel, {
          get className() {
            return libs.classNames("MedalScore", {
              Up: medal_score() > 0,
              Down: medal_score() < 0
            });
          },
          get text() {
            return libs.memo(() => medal_score() == 0)() ? libs.memo(() => !!projected())() ? `-${medal_score()}` : "-" : libs.memo(() => medal_score() > 0)() ? `+${medal_score()}` : medal_score();
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          get visible() {
            return projected();
          },
          id: "TierProtect",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              text: "#RankProtected"
            });
          }
        }), libs.createComponent(libs.Show, {
          get when() {
            return matchScore() != undefined;
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "GamblingScore",
              get classList() {
                return {
                  Add: kingScoreChange() > 0,
                  Sub: kingScoreChange() < 0
                };
              },
              tooltip_text: "#BountyScoreGambling",
              get dialogVariables() {
                return {
                  value: gamblingScore()
                };
              },
              get children() {
                return [libs.createComponent(EOM_Icon.EOM_Icon, {
                  size: "16",
                  get src() {
                    return getSrcPath("bountyentry/s14_bounty_icon.png");
                  }
                }), libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return kingScoreText();
                  }
                })];
              }
            });
          }
        })];
      }
    }), _el$2);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 3);
      },
      get children() {
        return libs.createComponent(TalentTree.TalentTree, {
          get heroName() {
            return heroName();
          },
          get override_talents() {
            return talent_tree();
          },
          showTooltip: true
        });
      }
    }), _el$2);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 4);
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "MainSectInfo",
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return sectList();
              },
              children: (sectName, index) => {
                const sectInfo = () => mainSects()[sectName()];
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
                            return sectName();
                          },
                          active: true,
                          get customTooltip() {
                            return {
                              name: "player_sect_list",
                              sectName: sectName(),
                              concise: 1
                            };
                          }
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
    }), _el$2);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 5);
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "ArtifactList",
          get className() {
            return libs.classNames("inventory", {
              MultSlot: equipmentList().length > 3
            });
          },
          flowChildren: "right",
          get children() {
            return libs.createComponent(libs.Index, {
              get each() {
                return equipmentList();
              },
              children: (itemName, i) => {
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
          }
        });
      }
    }), _el$3);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 6);
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
                          const _el$6 = libs.createElement("DOTAItemImage", {
                            id: "ArtifactImage",
                            get itemname() {
                              return itemName();
                            },
                            showtooltip: false
                          }, null);
                          libs.effect(_$p => libs.setProp(_el$6, "itemname", itemName(), _$p));
                          return _el$6;
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
    }), _el$4);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 7);
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "MatchTypeAndTime",
          get children() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "MatchTypeContainer",
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("MatchType", "Type" + getMatchText(matchType()));
                  },
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return matchText();
                      }
                    });
                  }
                });
              }
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "MatchTime",
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return matchTimeText();
                  }
                });
              }
            })];
          }
        });
      }
    }), _el$5);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      get className() {
        return libs.classNames("column", 8);
      },
      get children() {
        return libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "BattleRecordMore",
          get children() {
            return libs.createComponent(EOM_Button.EOM_Button, {
              color: "Blue",
              text: "#BattleRecords_Detail",
              get enabled() {
                return enableShowDetail();
              },
              onactivate: () => props.onClick(recordData().match_id, matchType(), matchTimeText())
            });
          }
        });
      }
    }), null);
    return _el$;
  })();
};
const BattleDetails = props => {
  const detailRecord = () => {
    let rankRecord = [];
    props.detail_data.forEach((data, index) => {
      if (data.ranking != undefined) {
        if (rankRecord[data.ranking] == undefined) {
          rankRecord[data.ranking] = data;
        } else {
          if (rankRecord[data.ranking + 1] == undefined) {
            rankRecord[data.ranking + 1] = data;
          }
        }
      }
    });
    return rankRecord;
  };
  const detailMatchSeason = () => {
    let season;
    if (props.detail_data && props.detail_data.length > 0) {
      season = props.detail_data.find(v => v?.season_id != undefined)?.season_id;
    }
    if (season == undefined) {
      season = CustomNetTables.GetTableValue("common", "constant")?.GAME_SEASON ?? -1;
    }
    return season;
  };
  const isGroupMatch = () => props.match_type == 10 || props.match_type == 11;
  const hasGreevil = () => {
    return props.detail_data.some(v => (v?.greevil_type ?? "") !== "" || (v?.greevil_effects ?? "") !== "" || (v?.greevil_egg ?? "") !== "");
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "BattleDetails",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "TopContainer",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "MatchTypeAndTime",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "MatchTypeContainer",
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("MatchType", "Type" + getMatchText(props.match_type));
                    },
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return `#MatchType_${getMatchText(props.match_type)}`;
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "MatchTime",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    get text() {
                      return props.date;
                    }
                  });
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "MatchIDContainer",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                id: "MatchID",
                get text() {
                  return props.match_id.toString();
                }
              }), libs.createComponent(GenericPanel.CLabel, {
                id: "MatchIDTitle",
                text: "#MatchDetailID"
              })];
            }
          })];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "BattleDetailContainer",
        get children() {
          return [libs.createComponent(OverviewPlayerRow, {
            index: -1,
            get match_type() {
              return props.match_type;
            },
            get season() {
              return detailMatchSeason();
            },
            get has_greevil() {
              return hasGreevil();
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return isGroupMatch();
            },
            get fallback() {
              return [...Array(8)].map((_, index) => {
                const detailInfo = libs.createMemo(() => {
                  return detailRecord()[index + 1];
                });
                return libs.createComponent(OverviewPlayerRow, {
                  get match_type() {
                    return props.match_type;
                  },
                  index: index,
                  get detail_info() {
                    return detailInfo();
                  },
                  get season() {
                    return detailMatchSeason();
                  },
                  get has_greevil() {
                    return hasGreevil();
                  }
                });
              });
            },
            get children() {
              return [...Array(4)].map((_, index) => {
                const detailInfo1 = libs.createMemo(() => {
                  return detailRecord()[index * 2 + 1];
                });
                const detailInfo2 = libs.createMemo(() => {
                  return detailRecord()[index * 2 + 2];
                });
                const rank = index + 1;
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "BattleDetailTeamRow",
                  flowChildren: "down",
                  get children() {
                    return [libs.createComponent(EOM_Panel.EOM_Panel, {
                      id: "TeamRankContainer",
                      hittest: true,
                      hittestchildren: false,
                      get children() {
                        return [libs.createComponent(GenericPanel.CImage, {
                          get className() {
                            return libs.classNames("TeamRankBG", "Rank" + rank);
                          }
                        }), libs.createComponent(EOM_Label.EOM_Label, {
                          className: "TeamRank",
                          text: rank > 3 ? rank : ""
                        })];
                      }
                    }), libs.createComponent(OverviewPlayerRow, {
                      hide_rank: true,
                      hide_bottom_line: true,
                      get match_type() {
                        return props.match_type;
                      },
                      index: index,
                      get detail_info() {
                        return detailInfo1();
                      },
                      get season() {
                        return detailMatchSeason();
                      },
                      get has_greevil() {
                        return hasGreevil();
                      }
                    }), libs.createComponent(OverviewPlayerRow, {
                      hide_rank: true,
                      hide_top_line: true,
                      get match_type() {
                        return props.match_type;
                      },
                      index: index,
                      get detail_info() {
                        return detailInfo2();
                      },
                      get season() {
                        return detailMatchSeason();
                      },
                      get has_greevil() {
                        return hasGreevil();
                      }
                    })];
                  }
                });
              });
            }
          })];
        }
      })];
    }
  });
};
const useOverviewPlayerRow = props => {
  const detailInfo = () => props.detail_info;
  const mainSects = libs.createMemo(() => {
    const data = JSON.parseSafe(detailInfo()?.sect ?? "");
    if (typeof data == "object") {
      return data;
    }
  });
  const isSelf = () => (detailInfo()?.uid ?? -1) == finiteNumber(Number(getPlayerData(Players.GetLocalPlayer(), "steamID")));
  const steamID = () => (detailInfo()?.uid ?? -1).toString();
  const sectList = () => Object.keys(mainSects() ?? {}).sort((a, b) => mainSects()[b].exp - mainSects()[a].exp);
  const talent_tree = () => detailInfo()?.talent_tree;
  const equipmentList = libs.createMemo(() => {
    let data = JSON.parseSafe(detailInfo()?.equipment ?? "");
    if (Array.isArray(data)) {
      let list = data.filter(v => KeyValues.ItemsKv[v] != undefined);
      list = list.sort((a, b) => (KeyValues.ItemsKv[a]?.ItemLevel ?? 99) - (KeyValues.ItemsKv[b]?.ItemLevel ?? 99));
      let offset = 3 - list.length;
      if (offset > 0) {
        for (let i = 0; i < offset; i++) {
          list.push("");
        }
      }
      return list;
    }
    return ["", "", ""];
  });
  const artifactList = libs.createMemo(() => {
    const data = JSON.parseSafe(detailInfo()?.artifact ?? "");
    if (Array.isArray(data)) {
      return data;
    }
  });
  const heroName = () => detailInfo()?.hero_id != undefined ? GetHeroNameByGoodID(detailInfo().hero_id) : undefined;
  const rank = () => detailInfo()?.ranking ?? -1;
  const hero_level = () => detailInfo()?.hero_level ?? -1;
  const runeRewardInfo = libs.createMemo(() => {
    let list = Object.values(JSON.parseSafe(detailInfo()?.nemestice_embers ?? ""));
    let trait_1;
    let trait_2;
    let lv = 0;
    list.forEach(name => {
      let round = KeyValues.TraitKv[name]?.Round;
      if (typeof round == "number") {
        if (round == 1) {
          trait_1 = name;
        } else {
          trait_2 = name;
        }
      }
    });
    lv = (trait_1 == undefined ? 0 : 1) + (trait_2 == undefined ? 0 : 1);
    return {
      trait_1,
      trait_2,
      lv
    };
  });
  return {
    detailInfo,
    steamID,
    mainSects,
    sectList,
    talent_tree,
    equipmentList,
    artifactList,
    heroName,
    rank,
    hero_level,
    isSelf,
    runeRewardInfo
  };
};
const OverviewPlayerRow = props => {
  const {
    detailInfo,
    steamID,
    mainSects,
    sectList,
    talent_tree,
    equipmentList,
    artifactList,
    heroName,
    rank,
    hero_level,
    isSelf,
    runeRewardInfo
  } = useOverviewPlayerRow(props);
  const isGroupMatch = () => props.match_type == 10 || props.match_type == 11;
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    get className() {
      return libs.classNames("OverviewPlayerRow", "Rank" + rank(), {
        Title: props.index == -1,
        selfRow: isSelf(),
        hideBottomLine: props.hide_bottom_line,
        hideTopLine: props.hide_top_line
      });
    },
    flowChildren: "right",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return props.index != -1;
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
        }), libs.createComponent(libs.Switch, {
          get fallback() {
            return [libs.createComponent(EOM_Panel.EOM_Panel, {
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
            }), libs.createComponent(EOM_Panel.EOM_Panel, {
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
            })];
          },
          get children() {
            return [libs.createComponent(libs.Match, {
              get when() {
                return props.season == 107 || isGroupMatch();
              },
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  get className() {
                    return libs.classNames("column", 13);
                  },
                  get children() {
                    return libs.createComponent(EOM_Label.EOM_Label, {
                      width: "60px",
                      align: "center center",
                      style: {
                        textAlign: "center"
                      },
                      color: "#94A2B0",
                      get text() {
                        return isGroupMatch() ? "#TeamCard" : "#CardEffect";
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
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
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
                })];
              }
            }), libs.createComponent(libs.Match, {
              get when() {
                return props.has_greevil;
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
            })];
          }
        })],
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 1);
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "PlayerOverviewInfo",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "PlayerRankContainer",
                    get children() {
                      return libs.createComponent(libs.Show, {
                        get when() {
                          return !props.hide_rank;
                        },
                        get children() {
                          return [libs.createComponent(GenericPanel.CImage, {
                            get className() {
                              return libs.classNames("PlayerRankBG", "Rank" + (props.index + 1));
                            }
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            className: "PlayerRank",
                            get text() {
                              return props.index + 1 <= 3 ? "" : props.index + 1;
                            }
                          })];
                        }
                      });
                    }
                  }), libs.createComponent(Heroes.HeroImage, {
                    get hero_name() {
                      return heroName();
                    },
                    get oid() {
                      return detailInfo()?.oid;
                    },
                    get children() {
                      return libs.createComponent(EOM_XP.EOM_XP, {
                        get level() {
                          return hero_level();
                        },
                        maxLevel: 100
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "NameContainer",
                    get children() {
                      return [libs.createComponent(Player.PlayerName, {
                        get steamID() {
                          return steamID();
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
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("column", 5);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                className: "WinLoss",
                get text() {
                  return `${detailInfo()?.win_round ?? 0}/${detailInfo()?.lose_round ?? 0}`;
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
                  return detailInfo()?.streak ?? 0;
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
                          return detailInfo()?.total_economy ?? 0;
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
                    get override_talents() {
                      return talent_tree();
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
                      return sectList();
                    },
                    children: (sectName, index) => {
                      const sectInfo = () => mainSects()[sectName()];
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
                                  return sectName();
                                },
                                active: true,
                                get customTooltip() {
                                  return {
                                    name: "player_sect_list",
                                    sectName: sectName(),
                                    concise: 1
                                  };
                                }
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
                  return libs.classNames("inventory", {
                    MultSlot: equipmentList().length > 3
                  });
                },
                flowChildren: "right",
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return equipmentList();
                    },
                    children: (itemName, i) => {
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
                                const _el$7 = libs.createElement("DOTAItemImage", {
                                  id: "ArtifactImage",
                                  get itemname() {
                                    return itemName();
                                  },
                                  showtooltip: false
                                }, null);
                                libs.effect(_$p => libs.setProp(_el$7, "itemname", itemName(), _$p));
                                return _el$7;
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
          }), libs.createComponent(libs.Switch, {
            get fallback() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 20);
                },
                get children() {
                  return libs.createComponent(ShardAbility.ShardAbility, {
                    get heroName() {
                      return heroName();
                    },
                    get unlocked() {
                      return (props.detail_info?.purchase_shard_round ?? 0) > 0;
                    },
                    showTooltip: true
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("column", 11);
                },
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    get ["class"]() {
                      return libs.classNames("RuneRewardIcon", "LV" + runeRewardInfo().lv);
                    },
                    get customTooltip() {
                      return {
                        name: "rune_reward",
                        trait_1: runeRewardInfo().trait_1,
                        trait_2: runeRewardInfo().trait_2
                      };
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    get className() {
                      return libs.classNames("RuneRewardCount", "LV" + runeRewardInfo().lv);
                    },
                    get text() {
                      return `Lv.${runeRewardInfo().lv}`;
                    }
                  })];
                }
              })];
            },
            get children() {
              return [libs.createComponent(libs.Match, {
                get when() {
                  return props.season == 107 || isGroupMatch();
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
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
                            battle_detail: 1,
                            rune_list: props.detail_info?.runes,
                            team_mode: Number(isGroupMatch())
                          };
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
                        get unlocked() {
                          return (props.detail_info?.purchase_shard_round ?? 0) > 0;
                        },
                        showTooltip: true
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 11);
                    },
                    get children() {
                      return [libs.createComponent(EOM_Image.EOM_Image, {
                        get className() {
                          return libs.classNames("RuneRewardIcon", "LV" + runeRewardInfo().lv);
                        },
                        get customTooltip() {
                          return {
                            name: "rune_reward",
                            trait_1: runeRewardInfo().trait_1,
                            trait_2: runeRewardInfo().trait_2
                          };
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        get className() {
                          return libs.classNames("RuneRewardCount", "LV" + runeRewardInfo().lv);
                        },
                        get text() {
                          return `Lv.${runeRewardInfo().lv}`;
                        }
                      })];
                    }
                  })];
                }
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.has_greevil;
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 14);
                    },
                    get children() {
                      return libs.createComponent(greevil_icon.GreevilIcon, {
                        playerID: -1,
                        mode: "icon_only",
                        get battle_record_data() {
                          return {
                            greevil_egg: detailInfo()?.greevil_egg,
                            greevil_type: detailInfo()?.greevil_type,
                            greevil_exp: detailInfo()?.greevil_exp
                          };
                        }
                      });
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 15);
                    },
                    get children() {
                      return libs.createComponent(greevil_icon.GreevilIcon, {
                        playerID: -1,
                        mode: "shop_record",
                        get battle_record_data() {
                          return {
                            greevil_effects: detailInfo()?.greevil_effects,
                            nemestice_embers: detailInfo()?.nemestice_embers,
                            runes: detailInfo()?.runes
                          };
                        }
                      });
                    }
                  })];
                }
              })];
            }
          })];
        }
      });
    }
  });
};

const ACHIEVEMENT_CATEGORIES = ["全部", "战斗", "收藏", "社交", "其他"];
const ACHIEVEMENT_TYPES = ["战斗", "战斗", "战斗", "战斗", "战斗", "收藏", "收藏", "收藏", "收藏", "社交", "社交", "社交", "其他", "其他", "其他", "战斗", "收藏", "社交", "其他", "战斗"];
const mockAchievements = () => Array.from({
  length: 20
}, (_, i) => ({
  id: i,
  image: "",
  name: `成就名称 ${i + 1}`,
  type: ACHIEVEMENT_TYPES[i],
  obtainedTime: `2025-0${i % 9 + 1}-${String(i % 28 + 1).padStart(2, "0")}`
}));
const ProfileAchievement = props => {
  const achievementLevel = () => 1;
  const totalCompleted = () => 12;
  const totalCount = () => 50;
  const serverRank = () => 85.5;
  const rareCount = () => 5;
  const epicCount = () => 3;
  const legendCount = () => 2;
  const mythicCount = () => 0;
  const [selectedCategory, setSelectedCategory] = libs.createSignal(0);
  const [selectedAchievement, setSelectedAchievement] = libs.createSignal(null);
  const filteredAchievements = () => {
    const category = ACHIEVEMENT_CATEGORIES[selectedCategory()];
    if (category == "全部") return mockAchievements();
    return mockAchievements().filter(ach => ach.type == category);
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileAchievement",
    get children() {
      return libs.createComponent(libs.Show, {
        get when() {
          return selectedAchievement() != null;
        },
        get fallback() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AchievementSummary",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "AchievementLevelBG",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    id: "AchievementLevel",
                    get text() {
                      return `成就等级    ${achievementLevel()}`;
                    }
                  });
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatLabel",
                text: "达成成就"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatValue",
                get text() {
                  return `${totalCompleted()}/${totalCount()}`;
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "RankLabel",
                text: "全服排名超过"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatValue Rank",
                get text() {
                  return `${serverRank()}%`;
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RarityList",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RarityRowBG",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "稀有成就"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityCount",
                        get text() {
                          return rareCount();
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RarityRowBG",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "史诗成就"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityCount",
                        get text() {
                          return epicCount();
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RarityRowBG",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "传说成就"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityCount",
                        get text() {
                          return legendCount();
                        }
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RarityRowBG",
                    get children() {
                      return [libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "神话成就"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityCount",
                        get text() {
                          return mythicCount();
                        }
                      })];
                    }
                  })];
                }
              })];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AchievementContent",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CategoryTabs",
                get children() {
                  return ACHIEVEMENT_CATEGORIES.map((cat, i) => libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return selectedCategory() == i ? "CategoryTab Selected" : "CategoryTab";
                    },
                    onactivate: () => setSelectedCategory(i),
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        className: "CategoryTabLabel",
                        text: cat
                      });
                    }
                  }));
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "CategoryDivider"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "AchievementCardList",
                scroll: "y",
                get children() {
                  return filteredAchievements().map(ach => libs.createComponent(AchievementCard, {
                    ach: ach,
                    onSelect: () => setSelectedAchievement(ach)
                  }));
                }
              })];
            }
          })];
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AchievementDetail",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "DetailBackButton",
                onactivate: () => setSelectedAchievement(null),
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    id: "DetailBackLabel",
                    text: "#Back"
                  });
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "DetailCardRow",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "DetailStage",
                    get children() {
                      return [libs.createComponent(AchievementCardStatic, {
                        get ach() {
                          return selectedAchievement();
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "DetailStageCondition",
                        text: "达成条件 xx/xxx"
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "DetailArrow1"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "DetailStage",
                    get children() {
                      return [libs.createComponent(AchievementCardStatic, {
                        get ach() {
                          return selectedAchievement();
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "DetailStageCondition",
                        text: "达成条件 xx/xxx"
                      })];
                    }
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    id: "DetailArrow2"
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "DetailStage",
                    get children() {
                      return [libs.createComponent(AchievementCardStatic, {
                        get ach() {
                          return selectedAchievement();
                        }
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "DetailStageCondition",
                        text: "达成条件 xx/xxx"
                      })];
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
const AchievementCard = props => {
  return libs.createComponent(EOM_Button.EOM_BaseButton, {
    className: "AchievementCard",
    get onactivate() {
      return props.onSelect;
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "AchievementCardImage"
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardName",
        get text() {
          return props.ach.name;
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardTime",
        get text() {
          return props.ach.obtainedTime;
        }
      })];
    }
  });
};
const AchievementCardStatic = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "AchievementCard",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "AchievementCardImage"
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardName",
        get text() {
          return props.ach.name;
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardTime",
        get text() {
          return props.ach.obtainedTime;
        }
      })];
    }
  });
};

const ProfileJourney = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileJourney",
    get children() {
      return libs.createComponent(EOM_Label.EOM_Label, {
        text: "#ProfileTag_Journey"
      });
    }
  });
};

if (!isSpectator()) {
  const bSelf = () => {
    return GameUI.ProfilePlayerId() == Players.GetLocalPlayer();
  };
  const [collectionNewMark, setCollectionNewMark] = libs.createSignal();
  const [displayNewMark, setDisplayNewMark] = libs.createSignal();
  const Profile = () => {
    const [show, setShow] = libs.createSignal(false);
    const [tabIndex, setTabIndex] = libs.createSignal(0);
    const [subTab, setSubTab] = libs.createSignal("ProfileTag_Journey");
    const menuKeys = () => bSelf() ? ["ProfileTag_SelfInfo", "ProfileTag_BattleRecords", "ProfileTag_GloryRoad"] : ["ProfileTag_SelfInfo"];
    const meunList = () => bSelf() ? {
      ProfileTag_SelfInfo: [],
      ProfileTag_BattleRecords: []
    } : {
      ProfileTag_SelfInfo: []
    };
    libs.createEffect(libs.on(show, _show => {
      if (_show && showExchange()) {
        setShowExchange(false);
      }
    }));
    libs.createEffect(() => {
      if (show()) GameEvents.SendCustomGameEventToServer('report_open_window', {
        window_type: 4
      });
    });
    const updateNewMarkInfo = data => {
      if (data) {
        for (const mid in data) {
          const state = data[mid];
          if (state) {
            const kv = KeyValues.NewMarkInfoKv[mid];
            if (kv != undefined) {
              if (kv.menu_button == "profile") {
                if (kv.tag_id == "ProfileTag_SelfInfo") {
                  if (kv.benchmark == "collection" && collectionNewMark() === undefined) {
                    setCollectionNewMark(kv.type);
                  } else if (kv.benchmark == "display_detail" && displayNewMark() === undefined) {
                    setDisplayNewMark(kv.type);
                  }
                }
              }
            }
          }
        }
      }
    };
    libs.onMount(() => {
      const eventId = useToggleWindow("MenuButton_profile", show, setShow);
      libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
    });
    EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
      const eventIdList = [];
      const netTableIDList = [];
      netTableIDList.push(useServiceNetTable("player_new_mark", data => {
        updateNewMarkInfo(data);
      }, Players.GetLocalPlayer()));
      eventIdList.push(useClientSideEvent("create_new_mark_info", data => {
        updateNewMarkInfo(data);
      }));
      return () => {
        eventIdList.forEach(id => GameEvents.Unsubscribe(id));
        netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      };
    });
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      renderOnShow: true,
      get show() {
        return show();
      },
      name: "MenuButton_profile",
      get children() {
        return [libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Menu, {
          get menuList() {
            return meunList();
          },
          onToggleMenu: (menu, menu2) => {
            if (menu != '') {
              setTabIndex(menuKeys().indexOf(menu));
              if (menu2 && menu2 != "") setSubTab(menu2);
            }
          },
          menuName: "profile",
          get show() {
            return show();
          },
          get selectedMenu() {
            return menuKeys()?.[tabIndex()];
          }
        }), libs.createComponent(libs.For, {
          get each() {
            return menuKeys();
          },
          children: (tag, index) => {
            return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
              id: tag,
              get show() {
                return tabIndex() == index();
              },
              get children() {
                return (() => {
                  switch (tag) {
                    case "ProfileTag_SelfInfo":
                      return libs.createComponent(ProfileMain, {});
                    case "ProfileTag_BattleRecords":
                      return libs.createComponent(ProfileBattleRecords, {
                        get refresh() {
                          return libs.memo(() => !!show())() && tabIndex() == index();
                        }
                      });
                    case "ProfileTag_GloryRoad":
                      return subTab() == "ProfileTag_Achievement" ? libs.createComponent(ProfileAchievement, {
                        get refresh() {
                          return libs.memo(() => !!show())() && tabIndex() == index();
                        }
                      }) : libs.createComponent(ProfileJourney, {
                        get refresh() {
                          return libs.memo(() => !!show())() && tabIndex() == index();
                        }
                      });
                  }
                })();
              }
            });
          }
        })];
      }
    });
  };
  const [courierName, setCourierName] = libs.createSignal("5200000");
  const [heroName, setheroName] = libs.createSignal("");
  const [showExchange, setShowExchange] = libs.createSignal(false);
  const ProfileMain = () => {
    const [gameSummary, setGameSummary] = libs.createSignal({});
    const [loginData, setLoginData] = libs.createSignal({});
    const [playerMedal, setPlayerMedal] = libs.createSignal(getServiceNetTable("player_medal", GameUI.ProfilePlayerId()));
    const [heroCount, setHeroCount] = libs.createSignal(CustomNetTables.GetTableValue("common", "player_hero_count_" + GameUI.ProfilePlayerId())?.count ?? 0);
    const [playerVipExpire, setPlayerVipExpire] = libs.createSignal(-1);
    const [maxCup, setMaxCup] = libs.createSignal(0);
    const winCount = () => gameSummary()?.rank_1_count ?? 0;
    const fourCount = () => gameSummary()?.win_count ?? 0;
    const allCount = () => gameSummary()?.total_count ?? 0;
    const medalCount = () => playerMedal()?.now_medal ?? 0;
    const loginDay = () => loginData()?.total_login_days ?? 0;
    let NetTableListenerIDs = [];
    let eventIdList = [];
    libs.createEffect(libs.on(GameUI.ProfilePlayerId, playerId => {
      eventIdList.forEach(id => GameEvents.Unsubscribe(id));
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      NetTableListenerIDs = [];
      eventIdList = [];
      NetTableListenerIDs.push(useServiceNetTable("player_medal", data => {
        setPlayerMedal(data);
      }, playerId));
      NetTableListenerIDs.push(useServiceNetTable("login_data", data => {
        setLoginData(data);
      }, playerId));
      NetTableListenerIDs.push(useServiceNetTable("game_summary", data => {
        setGameSummary(data);
      }, playerId));
      NetTableListenerIDs.push(useServiceNetTable("player_rank_score", data => {
        let max = 0;
        for (let season in data) {
          let v = data[season];
          if (v.highest_rank_score > max) {
            max = v.highest_rank_score;
          }
        }
        setMaxCup(max);
      }, playerId));
      NetTableListenerIDs.push(useNetTableKeyHasDefaultValue("common", "player_hero_count_" + GameUI.ProfilePlayerId(), data => {
        setHeroCount(data.count);
      }));
      eventIdList.push(useNetData("player_vip", data => {
        if (data.vip_valid == 1) {
          setPlayerVipExpire(data.expire);
        }
      }, playerId));
      libs.onCleanup(() => {
        eventIdList.forEach(id => GameEvents.Unsubscribe(id));
        NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    }));
    return [libs.createComponent(profile_simplify.ProfileInfoLayout, {
      get playerID() {
        return GameUI.ProfilePlayerId();
      },
      get showExchange() {
        return showExchange();
      },
      get medalCount() {
        return medalCount();
      },
      get winCount() {
        return winCount();
      },
      get fourCount() {
        return fourCount();
      },
      get allCount() {
        return allCount();
      },
      get maxCup() {
        return maxCup();
      },
      get heroCount() {
        return heroCount();
      },
      get loginDay() {
        return loginDay();
      },
      get collectionNewMark() {
        return collectionNewMark();
      },
      onClickCollection: () => {
        if (bSelf()) {
          showPopup("SelectCollections", {});
        }
        if (collectionNewMark()) {
          setCollectionNewMark(null);
          clickNewMark({
            menu: "profile",
            tag: "ProfileTag_SelfInfo",
            benchmark: "collection"
          });
        }
      },
      get heroName() {
        return heroName();
      },
      get courierName() {
        return courierName();
      },
      get playerVipExpire() {
        return playerVipExpire();
      }
    }), libs.createComponent(CosmeticsShelf, {
      id: "CosmeticsShelf",
      get show() {
        return showExchange();
      },
      get classList() {
        return {
          "showChange": showExchange()
        };
      },
      get hittest() {
        return showExchange();
      }
    }), libs.createComponent(libs.Show, {
      get when() {
        return bSelf();
      },
      get children() {
        return libs.createComponent(EOM_Button.EOM_BaseButton, {
          id: "ChangeShow",
          get classList() {
            return {
              "showChange": showExchange()
            };
          },
          onactivate: self => {
            setShowExchange(prev => !prev);
            if (displayNewMark()) {
              setDisplayNewMark(null);
              clickNewMark({
                menu: "profile",
                tag: "ProfileTag_SelfInfo",
                benchmark: "display_detail"
              }, self);
            }
          },
          get children() {
            return [libs.createComponent(GenericPanel.CLabel, {
              text: "#ChangeShow"
            }), libs.createComponent(libs.Show, {
              get when() {
                return displayNewMark();
              },
              get children() {
                return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                  get type() {
                    return displayNewMark();
                  }
                });
              }
            })];
          }
        });
      }
    })];
  };
  const CosmeticsShelf = props => {
    const [local, others] = libs.splitProps(props, []);
    const filters = [10, 20];
    const [selected, setSelected] = libs.createSignal(10);
    const [playerOrnament, setPlayerOrnament] = libs.createSignal({});
    const [collections, setCollections] = libs.createSignal([]);
    libs.createEffect(libs.on(GameUI.ProfilePlayerId, playerId => {
      const NetTableListenerIDs = [];
      NetTableListenerIDs.push(useServiceNetTable("player_ornament_slots", data => {
        let collections = [];
        data.forEach(collection => {
          collections[collection.slot - 1] = collection.oid.toString();
        });
        setCollections(collections);
      }, playerId));
      libs.onCleanup(() => {
        NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    }));
    libs.createEffect(libs.on(collections, _collections => {
      if (_collections[19]) {
        setCourierName(_collections[19]);
      }
      if (_collections[20]) {
        setheroName(_collections[20]);
      }
    }));
    libs.createEffect(libs.on(showExchange, _showChange => {
      if (!_showChange) {
        if (collections()[19]) {
          setCourierName(collections()[19]);
        } else {
          setCourierName("5200000");
        }
        if (collections()[20]) {
          setheroName(collections()[20]);
        } else {
          setheroName("");
        }
      }
    }));
    libs.onMount(() => {
      let gameEventIDList = [];
      gameEventIDList.push(useNetData('player_ornament', data => {
        setPlayerOrnament(data);
      }, Players.GetLocalPlayer()));
      libs.onCleanup(() => {
        for (const id of gameEventIDList) {
          GameEvents.Unsubscribe(id);
        }
      });
    });
    const isEquip = cosmeticID => {
      return collections()[19] == cosmeticID || collections()[20] == cosmeticID;
    };
    const hasColoring = cosmeticID => {
      if (KeyValues.CosmeticsKv[cosmeticID] && KeyValues.CosmeticsKv[cosmeticID].hasColoring == 1) {
        return true;
      }
      return false;
    };
    const cosmeticList = () => getAllCosmetics().filter(cosmeticInfo => {
      if (cosmeticInfo.oid % 10000 != 520 && cosmeticInfo.oid % 10000 == 510) {
        return false;
      }
      if (filters.indexOf(cosmeticInfo.slot) != -1) {
        return true;
      }
    }).sort((a, b) => {
      const aOwned = playerOrnament()[a.oid.toString()] == undefined && !a.default ? 0 : 1;
      const bOwned = playerOrnament()[b.oid.toString()] == undefined && !b.default ? 0 : 1;
      return multiCompare(bOwned - aOwned, b.orderby - a.orderby, b.rarity - a.rarity);
    });
    return (() => {
      const _el$ = libs.createElement("Panel", others, null);
      libs.spread(_el$, others, true);
      libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CosmeticSlots",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticSlotShadow"
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticSlotContainer",
            flowChildren: "down",
            get children() {
              return libs.createComponent(libs.For, {
                each: filters,
                children: (slot, i) => {
                  return libs.createComponent(EOM_Button.EOM_BaseButton, {
                    get className() {
                      return libs.classNames('CosmeticSlot', {
                        Selected: selected() == slot
                      });
                    },
                    id: 'cosmetic_slot_' + slot,
                    onactivate: self => {
                      setSelected(slot);
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        src: 'file://{images}/custom_game/cosmetics/slot_' + slot + '.png'
                      });
                    }
                  });
                }
              });
            }
          })];
        }
      }), null);
      libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CosmeticItems",
        flowChildren: "down",
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticItemsTitle",
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                align: "center center",
                get text() {
                  return '#CosmeticSlot_' + selected();
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "CosmeticList",
            flowChildren: "right-wrap",
            scroll: "y",
            get children() {
              return libs.createComponent(libs.Show, {
                get when() {
                  return props.show;
                },
                get children() {
                  return libs.createComponent(libs.Index, {
                    get each() {
                      return cosmeticList();
                    },
                    children: (cosmetic, i) => {
                      const lock = () => playerOrnament()[cosmetic().oid.toString()] == undefined && !cosmetic().default;
                      const equipped = libs.createMemo(() => isEquip(cosmetic().oid.toString()));
                      const cosmetic_data = () => getCosmeticData(cosmetic().oid);
                      return libs.createComponent(libs.Switch, {
                        get children() {
                          return [libs.createComponent(libs.Match, {
                            get when() {
                              return selected() == 20;
                            },
                            get children() {
                              return libs.createComponent(CosmeticCard.CosmeticCard, {
                                get visible() {
                                  return selected() == cosmetic().slot;
                                },
                                get itemid() {
                                  return cosmetic().oid.toString();
                                },
                                get lock() {
                                  return lock();
                                },
                                get equip() {
                                  return equipped();
                                },
                                get rarity() {
                                  return cosmetic().rarity;
                                },
                                get mark() {
                                  return cosmetic().mark;
                                },
                                get hasColoring() {
                                  return hasColoring(cosmetic().oid.toString());
                                },
                                onactivate: () => {
                                  setCourierName(cosmetic().oid.toString());
                                  if (!lock()) {
                                    callAction("equip_collection", {
                                      slot: 20,
                                      oid: cosmetic().default ? 0 : cosmetic().oid,
                                      group: 2
                                    });
                                  }
                                }
                              });
                            }
                          }), libs.createComponent(libs.Match, {
                            get when() {
                              return selected() == 10;
                            },
                            get children() {
                              return libs.createComponent(CosmeticCard.HeroCosmeticCard, {
                                get visible() {
                                  return selected() == cosmetic().slot;
                                },
                                get itemid() {
                                  return cosmetic().oid.toString();
                                },
                                get hid() {
                                  return Number(cosmetic_data()?.hero);
                                },
                                get lock() {
                                  return lock();
                                },
                                get equip() {
                                  return equipped();
                                },
                                get rarity() {
                                  return cosmetic().rarity;
                                },
                                get mark() {
                                  return cosmetic().mark;
                                },
                                get hasColoring() {
                                  return hasColoring(cosmetic().oid.toString());
                                },
                                onactivate: () => {
                                  setheroName(cosmetic().default ? "" : cosmetic().oid.toString());
                                  if (!lock()) {
                                    callAction("equip_collection", {
                                      slot: 21,
                                      oid: cosmetic().default ? 0 : cosmetic().oid,
                                      group: 2
                                    });
                                  }
                                }
                              });
                            }
                          })];
                        }
                      });
                    }
                  });
                }
              });
            }
          })];
        }
      }), null);
      return _el$;
    })();
  };
  libs.render(() => libs.createComponent(Profile, {}), $.GetContextPanel());
}