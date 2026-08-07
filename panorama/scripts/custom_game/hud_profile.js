--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
var EOM_Countdown = require('./EOM_Countdown.js');
var ProductImage = require('./ProductImage.js');
var netdata_utils = require('./netdata_utils.js');
require('./MenuMarkIcon.js');
require('./red_point_utils.js');
require('./EOM_PortraitFullBody.js');
require('./MedalBadgeIcon.js');
require('./profile_info.js');
require('./RankTierIcon.js');
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
let lastRefreshTime = 0;
const ProfileBattleRecords = () => {
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
  let _date = Math.floor(Date.now() / 1000);
  if (_date - lastRefreshTime > 3) {
    lastRefreshTime = _date;
    refreshData();
  }
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
                return props.season == 110 && props.has_greevil;
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
            }), libs.createComponent(libs.Match, {
              get when() {
                return props.season > 110;
              },
              get children() {
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
                }), libs.createComponent(EOM_Panel.EOM_Panel, {
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
                      text: "#RuneReward_Treasure"
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
                  return props.season == 110 && props.has_greevil;
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
              }), libs.createComponent(libs.Match, {
                get when() {
                  return props.season > 110;
                },
                get children() {
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
                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("column", 14);
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        get className() {
                          return libs.classNames("TreasureIcon", {
                            Owned: (detailInfo()?.greevil_effects?.length ?? 0) > 0
                          });
                        },
                        get customTooltip() {
                          return {
                            name: "treasure_list",
                            override_list: detailInfo()?.greevil_effects ?? ""
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

const ACHIEVEMENT_CATEGORIES = ["#tag_all", "#tag_fight", "#tag_social", "#tag_growth"];
const ACHIEVEMENT_CATEGORY_BY_TAB = {
  1: "#tag_fight",
  2: "#tag_social",
  3: "#tag_growth"
};
const toNumber$1 = (value, fallback = 0) => {
  const numberValue = Number(value);
  return Number.isNaN(numberValue) ? fallback : numberValue;
};
const buildAchievementData = (task, progress) => ({
  achievement_id: toNumber$1(task.achievement_id),
  name: task.description,
  category: ACHIEVEMENT_CATEGORY_BY_TAB[toNumber$1(task.tab)] ?? "其他",
  eventType: toNumber$1(task.icon_type),
  group: toNumber$1(task.icon_type),
  quality: toNumber$1(task.quality),
  score: toNumber$1(task.score),
  taskID: toNumber$1(task.achievement_id),
  uniqueTaskID: progress?.unique_task_id ?? task.achievement_id.toString(),
  progress: progress?.progress ?? 0,
  target: toNumber$1(task.target),
  completionTime: progress?.update_time ?? 0,
  enable: toNumber$1(task.enable) === 1,
  receive_progress: progress?.receive_progress != undefined
});
const getAchievementDisplayRank = achievement => {
  if (isAchievementCompleted(achievement)) return achievement.quality + 100;
  return achievement.progress / Math.max(achievement.target, 1);
};
const isAchievementCompleted = achievement => achievement.receive_progress;
const getAchievementConditionProgress = achievement => Math.min(achievement.progress, achievement.target);
const normalizeLeaderboardRank = rank => {
  const normalizedRank = Number(rank);
  return Number.isFinite(normalizedRank) && normalizedRank > 0 ? normalizedRank : -1;
};
const ProfileAchievement = () => {
  const localPlayerID = Players.GetLocalPlayer();
  const cachedPlayerAchievement = getNetDataCache("player_achievement", localPlayerID);
  const cachedLeaderboardData = getNetDataCache("leaderboard_data_9", localPlayerID);
  const [achievementLevel, setAchievementLevel] = libs.createSignal(Number(cachedPlayerAchievement?.level) || 0);
  const enabledAchievements = () => achievementList().filter(achievement => achievement.enable);
  const completedAchievements = () => enabledAchievements().filter(isAchievementCompleted);
  const totalCompleted = () => completedAchievements().length;
  const totalCount = () => enabledAchievements().length;
  const [serverRank, setServerRank] = libs.createSignal(normalizeLeaderboardRank(cachedLeaderboardData?.self_rank));
  const rareCount = () => completedAchievements().filter(achievement => achievement.quality == 1).length;
  const epicCount = () => completedAchievements().filter(achievement => achievement.quality == 2).length;
  const legendCount = () => completedAchievements().filter(achievement => achievement.quality == 3).length;
  const mythicCount = () => completedAchievements().filter(achievement => achievement.quality == 4).length;
  const [achievementTaskInfo, setAchievementTaskInfo] = libs.createSignal({});
  const [bpTaskProgresses, setBpTaskProgresses] = libs.createSignal({});
  const [selectedCategory, setSelectedCategory] = libs.createSignal(0);
  const [selectedAchievement, setSelectedAchievement] = libs.createSignal(null);
  callAction("activity_task_progress", {
    task_type: 3,
    sid: 0,
    aid: 0
  });
  libs.onMount(() => {
    const eventIDList = [];
    eventIDList.push(useNetData("info_achievement_task", data => {
      setAchievementTaskInfo(data ?? {});
    }));
    eventIDList.push(useNetData("achievement_task_progresses", data => {
      setBpTaskProgresses(data ?? {});
    }, localPlayerID));
    eventIDList.push(useNetData("leaderboard_data_9", data => {
      setServerRank(normalizeLeaderboardRank(data?.self_rank));
    }, localPlayerID));
    GameEvents.SendCustomEventToServer("request_leaderboard_data", {
      leaderboard_id: 9,
      begin_rank: 1,
      end_rank: 100
    });
    eventIDList.push(useNetData("player_achievement", data => {
      setAchievementLevel(Number(data?.level) || 0);
    }, localPlayerID));
    libs.onCleanup(() => {
      eventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  const achievementProgressByTaskID = libs.createMemo(() => {
    const result = {};
    for (const progress of Object.values(bpTaskProgresses())) {
      result[toNumber$1(progress.task_id)] = progress;
    }
    return result;
  });
  const achievementList = libs.createMemo(() => {
    const progressRecord = achievementProgressByTaskID();
    const achievements = Object.values(achievementTaskInfo()).map(task => buildAchievementData(task, progressRecord[toNumber$1(task.achievement_id)]));
    const groupProgress = {};
    for (const achievement of achievements) {
      const current = groupProgress[achievement.group];
      if (current == undefined || achievement.progress > current.progress) {
        groupProgress[achievement.group] = {
          progress: achievement.progress,
          completionTime: achievement.completionTime
        };
      }
    }
    return achievements.map(achievement => ({
      ...achievement,
      progress: groupProgress[achievement.group]?.progress ?? achievement.progress,
      completionTime: groupProgress[achievement.group]?.completionTime ?? achievement.completionTime
    })).sort((a, b) => a.achievement_id - b.achievement_id);
  });
  const achievementCardList = libs.createMemo(() => {
    const grouped = {};
    for (const achievement of achievementList()) {
      if (achievement.enable) {
        const current = grouped[achievement.group];
        if (current == undefined || getAchievementDisplayRank(achievement) > getAchievementDisplayRank(current)) {
          grouped[achievement.group] = achievement;
        }
      }
    }
    return Object.values(grouped).sort((a, b) => a.achievement_id - b.achievement_id);
  });
  const selectedAchievementStages = libs.createMemo(() => {
    const achievement = selectedAchievement();
    if (achievement == undefined) return [];
    return achievementList().filter(data => data.enable && data.group == achievement.group).sort((a, b) => a.achievement_id - b.achievement_id);
  });
  const filteredAchievements = () => {
    const category = ACHIEVEMENT_CATEGORIES[selectedCategory()];
    if (category == "#tag_all") return achievementCardList();
    return achievementCardList().filter(ach => ach.category == category);
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileAchievement",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "AchievementOverview",
        get className() {
          return selectedAchievement() != null ? "Hidden" : "";
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AchievementSummary",
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "AchievementLevelBG",
                get children() {
                  return libs.createComponent(EOM_Label.EOM_Label, {
                    id: "AchievementLevel",
                    get text() {
                      return $.Localize(`#achievement_level`) + `    ${achievementLevel()}`;
                    }
                  });
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatLabel",
                text: "#achievement_unlock"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatValue",
                get text() {
                  return `${totalCompleted()} / ${totalCount()}`;
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "RankLabel",
                text: "#server_rank_exceed"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                className: "StatValue Rank",
                get text() {
                  return libs.memo(() => serverRank() == -1)() ? "#SnowRankLabel1" : serverRank();
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "RarityList",
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "RarityRowBG",
                    get children() {
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IconGreen"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "#rare_achievement"
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
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IconBlue"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "#epic_achievement"
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
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IconGold"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "#legend_achievement"
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
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "IconRed"
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "RarityLabel",
                        text: "#mythic_achievement"
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
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return selectedAchievement() != null;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "AchievementDetail",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "DetailBackButton",
                onactivate: () => setSelectedAchievement(null),
                get children() {
                  return [libs.createComponent(EOM_Image.EOM_Image, {
                    id: "icon"
                  }), libs.createComponent(GenericPanel.CLabel, {
                    text: "#ViewPlayer_Return"
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "DetailCardRow",
                get children() {
                  return selectedAchievementStages().map((achievement, index) => [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "DetailStage",
                    get children() {
                      return [libs.createComponent(AchievementCardStatic, {
                        ach: achievement
                      }), libs.createComponent(EOM_Label.EOM_Label, {
                        className: "DetailStageCondition",
                        get text() {
                          return `#${achievement.eventType}_task`;
                        },
                        get dialogVariables() {
                          return {
                            progress: getAchievementConditionProgress(achievement),
                            target: achievement.target
                          };
                        }
                      })];
                    }
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return index < selectedAchievementStages().length - 1;
                    },
                    get children() {
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        className: "DetailArrow"
                      });
                    }
                  })]);
                }
              })];
            }
          });
        }
      })];
    }
  });
};
const AchievementCard = props => {
  return libs.createComponent(EOM_Button.EOM_BaseButton, {
    className: "AchievementCard",
    get classList() {
      return {
        red: props.ach.quality === 4,
        blue: props.ach.quality === 2,
        green: props.ach.quality === 1,
        gold: props.ach.quality === 3,
        incomplete: !isAchievementCompleted(props.ach)
      };
    },
    get onactivate() {
      return props.onSelect;
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "AchievementCardImage",
        get backgroundImage() {
          return `url('file://{images}/custom_game/achievement/${props.ach.eventType}.png')`;
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardName",
        get text() {
          return `#${props.ach.eventType}_achievement`;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return isAchievementCompleted(props.ach);
        },
        get fallback() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            className: "AchievementCardTime",
            text: "#Activity_Task_Unfinished"
          });
        },
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            className: "AchievementCardTime",
            text: "#Achievement_CompletionTime",
            get dialogVariables() {
              return {
                time: formatDate(props.ach.completionTime * 1000)
              };
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return !isAchievementCompleted(props.ach);
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "AchievementCardDisabledOverlay",
            hittest: false
          });
        }
      })];
    }
  });
};
const AchievementCardStatic = props => {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    className: "AchievementCard",
    get classList() {
      return {
        red: props.ach.quality === 4,
        blue: props.ach.quality === 2,
        green: props.ach.quality === 1,
        gold: props.ach.quality === 3,
        incomplete: !isAchievementCompleted(props.ach)
      };
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "AchievementCardImage",
        get backgroundImage() {
          return `url('file://{images}/custom_game/achievement/${props.ach.eventType}.png')`;
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardName",
        get text() {
          return `#${props.ach.eventType}_achievement`;
        }
      }), libs.createComponent(EOM_Label.EOM_Label, {
        className: "AchievementCardTime",
        get text() {
          return $.Localize(`#achievement_score`) + `${props.ach.score}`;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return !isAchievementCompleted(props.ach);
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "AchievementCardDisabledOverlay",
            hittest: false
          });
        }
      })];
    }
  });
};

const GLORY_ROAD_MAX_LEVEL = 40;
const GLORY_ROAD_GROUP_SIZE = 4;
const GLORY_ROAD_PLAYER_COUNT = 10;
const ACHIEVEMENT_RECEIVED_LEVELS_CACHE = "achievement_received_levels";
const clampLevel = level => Math.max(0, Math.min(GLORY_ROAD_MAX_LEVEL, Math.floor(level)));
const toNumber = (value, fallback = 0) => {
  const numberValue = Number(value);
  return Number.isNaN(numberValue) ? fallback : numberValue;
};
const getAchievementLevelScore = (achievementLevelInfo, level) => {
  const score = Number(achievementLevelInfo[level.toString()]?.score);
  return Number.isFinite(score) ? score : undefined;
};
const getRewardLevel = reward => toNumber(reward?.achievement_lv);
const isReceivedFlag = value => {
  if (value === true || value === 1 || value === "1") return true;
  return typeof value == "string" && value.toLowerCase() == "true";
};
const getReceivedAchievementLevels = data => {
  const raw = data.received_levels ?? data.reward_levels ?? data.received ?? data.rewards;
  if (Array.isArray(raw)) return raw.map(value => toNumber(value)).filter(value => value > 0);
  if (typeof raw == "string") return raw.split(",").map(value => toNumber(value.trim())).filter(value => value > 0);
  if (raw != undefined && typeof raw == "object") return Object.entries(raw).filter(([, received]) => isReceivedFlag(received)).map(([level]) => toNumber(level)).filter(level => level > 0);
  return [];
};
const getLevelRewardItems = reward => {
  const items = new Map();
  const addItem = (itemId, amounts) => {
    if (itemId == "" || amounts <= 0) return;
    items.set(itemId, (items.get(itemId) ?? 0) + amounts);
  };
  const raw = reward?.reward ?? reward?.box_reward;
  if (typeof raw == "string" && raw != "") {
    try {
      for (const [itemId, amounts] of Object.entries(JSON.parse(raw))) addItem(itemId, toNumber(amounts, 1));
    } catch {}
  } else if (raw != undefined && typeof raw == "object") {
    for (const [itemId, amounts] of Object.entries(raw)) addItem(itemId, toNumber(amounts, 1));
  }
  addItem("1100001", toNumber(reward?.gold_reward));
  return Array.from(items, ([itemId, amounts]) => ({
    itemId,
    amounts
  }));
};
const getLevelRewardTooltipItems = reward => getLevelRewardItems(reward).map(item => ({
  item_id: item.itemId,
  amounts: item.amounts
}));
const getReceivedLevelsFromData = data => {
  const levels = new Set();
  const addLevel = value => {
    const level = toNumber(value);
    if (level > 0) levels.add(level);
  };
  const parseEntry = (entry, key) => {
    if (entry == undefined) return;
    if (Array.isArray(entry)) {
      for (const item of entry) parseEntry(item);
      return;
    }
    if (typeof entry != "object") {
      if (key != undefined && isReceivedFlag(entry)) addLevel(key);
      return;
    }
    const level = entry.achievement_lv ?? entry.level ?? key;
    if (isReceivedFlag(entry.received ?? entry.receive ?? entry.state)) addLevel(level);
    for (const [childKey, childValue] of Object.entries(entry)) {
      if (childKey != "achievement_lv" && childKey != "level" && childKey != "received" && childKey != "receive" && childKey != "state") {
        parseEntry(childValue, childKey);
      }
    }
  };
  parseEntry(data);
  return Array.from(levels);
};
const rememberReceivedAchievementLevels = (playerID, levels) => {
  const cache = getClientGlobalData(ACHIEVEMENT_RECEIVED_LEVELS_CACHE) ?? {};
  const cacheKey = playerID.toString();
  const rememberedLevels = new Set(cache[cacheKey] ?? []);
  const previousSize = rememberedLevels.size;
  levels.forEach(level => {
    if (level > 0) rememberedLevels.add(level);
  });
  const nextLevels = Array.from(rememberedLevels).sort((a, b) => a - b);
  if (nextLevels.length != previousSize) {
    setClientGlobalData(ACHIEVEMENT_RECEIVED_LEVELS_CACHE, {
      ...cache,
      [cacheKey]: nextLevels
    });
  }
  return nextLevels;
};
const normalizeSteamID = steamID => {
  if (steamID == undefined) return "";
  const id = steamID.toString();
  return id.length >= 16 ? steam_64_3(id) : id;
};
const getPlayerName = steamID => steamID == "" ? "" : SteamFriends.RequestPersonaName(steam_3_64(steamID), undefined);
const ProfileJourney = props => {
  const localPlayerID = Players.GetLocalPlayer();
  const localSteamID = () => steam_64_3(Game.GetPlayerInfo(localPlayerID).player_steamid);
  const cachedPlayerAchievement = getNetDataCache("player_achievement", localPlayerID);
  const cachedReceivedData = getNetDataCache("player_achievement_received", localPlayerID);
  const cachedAchievementInfo = getNetDataCache("info_achievement");
  const cachedReceivedLevels = getReceivedLevelsFromData(cachedReceivedData);
  const rememberedReceivedLevels = rememberReceivedAchievementLevels(localPlayerID, cachedReceivedLevels);
  const [playerAchievement, setPlayerAchievement] = libs.createSignal({
    ...(cachedPlayerAchievement ?? {}),
    score: Number(cachedPlayerAchievement?.score) || 0,
    level: clampLevel(Number(cachedPlayerAchievement?.level) || 0)
  });
  const [roadData, setRoadData] = libs.createSignal({
    current_level: 1,
    level_players: {}
  });
  const [achievementLevelInfo, setAchievementLevelInfo] = libs.createSignal(cachedAchievementInfo ?? {});
  const [serverReceivedLevels, setServerReceivedLevels] = libs.createSignal(cachedReceivedLevels);
  const [locallyReceivedLevels, setLocallyReceivedLevels] = libs.createSignal(rememberedReceivedLevels);
  const replacementSlotByLevel = new Map();
  const pendingRewardToastLevels = new Set();
  const requestRoadData = () => callAction("achievement_uids_by_levels", {
    levels: Array.from({
      length: GLORY_ROAD_MAX_LEVEL
    }, (_, index) => index + 1)
  });
  libs.onMount(() => {
    const eventIDList = [];
    eventIDList.push(useNetData("glory_road_data", data => {
      const levelPlayers = data?.level_players ?? {};
      setRoadData({
        current_level: clampLevel(Number(data?.current_level) || 1),
        level_players: levelPlayers
      });
      replacementSlotByLevel.clear();
    }, localPlayerID));
    eventIDList.push(useNetData("player_achievement", data => {
      const achievementLevel = data?.level;
      setPlayerAchievement({
        ...(data ?? {}),
        score: Number(data?.score) || 0,
        level: clampLevel(Number(achievementLevel) || 0)
      });
    }, localPlayerID));
    eventIDList.push(useNetData("player_achievement_received", data => {
      const receivedLevels = getReceivedLevelsFromData(data);
      const rememberedLevels = rememberReceivedAchievementLevels(localPlayerID, receivedLevels);
      if (pendingRewardToastLevels.size > 0) {
        const toastItems = [];
        for (const level of receivedLevels) {
          if (!pendingRewardToastLevels.has(level)) continue;
          pendingRewardToastLevels.delete(level);
          toastItems.push(...getLevelRewardItems(achievementLevelInfo()[level.toString()]));
        }
        if (toastItems.length > 0) addItemMessage(toastItems);
      }
      setServerReceivedLevels(levels => Array.from(new Set([...levels, ...receivedLevels])));
      setLocallyReceivedLevels(levels => Array.from(new Set([...levels, ...rememberedLevels])));
    }, localPlayerID));
    eventIDList.push(useNetData("info_achievement", data => {
      setAchievementLevelInfo(data ?? {});
    }));
    requestRoadData();
    libs.onCleanup(() => eventIDList.forEach(eventID => GameEvents.Unsubscribe(eventID)));
  });
  libs.createEffect(libs.on(() => props.refresh, refresh => {
    if (refresh) requestRoadData();
  }, {
    defer: true
  }));
  const currentJourneyLevel = libs.createMemo(() => {
    return clampLevel(Number(playerAchievement().level) || 0);
  });
  const getJourneyLevelTooltip = level => {
    const currentLevel = currentJourneyLevel();
    const showNextLevelOnCurrentNode = level == currentLevel && currentLevel % GLORY_ROAD_GROUP_SIZE == 0;
    if (level <= currentLevel && !showNextLevelOnCurrentNode || level > GLORY_ROAD_MAX_LEVEL) return undefined;
    const targetLevel = showNextLevelOnCurrentNode ? currentLevel + 1 : level;
    if (targetLevel > GLORY_ROAD_MAX_LEVEL) return undefined;
    let requiredScore = 0;
    for (let requiredLevel = currentLevel + 1; requiredLevel <= targetLevel; requiredLevel++) {
      const levelScore = getAchievementLevelScore(achievementLevelInfo(), requiredLevel);
      if (levelScore == undefined) return undefined;
      requiredScore += Math.max(0, levelScore);
    }
    const currentScore = Math.max(0, toNumber(playerAchievement().score));
    const remainingScore = Math.max(0, Math.ceil(requiredScore - currentScore));
    if (remainingScore <= 0) return undefined;
    return {
      name: "custom_text",
      text: $.Localize("#GloryRoad_NextLevelScore").replace("${level}", targetLevel.toString()).replace("${score}", remainingScore.toString())
    };
  };
  const currentGroupStart = libs.createMemo(() => {
    const currentLevel = Math.max(currentJourneyLevel(), 1);
    return Math.floor((currentLevel - 1) / GLORY_ROAD_GROUP_SIZE) * GLORY_ROAD_GROUP_SIZE + 1;
  });
  const visibleLevels = libs.createMemo(() => Array.from({
    length: GLORY_ROAD_GROUP_SIZE
  }, (_, index) => currentGroupStart() + index));
  const achievementLevelRewards = libs.createMemo(() => Object.values(achievementLevelInfo()).filter(reward => getRewardLevel(reward) > 0).sort((a, b) => getRewardLevel(a) - getRewardLevel(b)));
  const receivedAchievementLevels = libs.createMemo(() => new Set([...getReceivedAchievementLevels(playerAchievement()), ...serverReceivedLevels(), ...locallyReceivedLevels()]));
  const receiveLevelReward = reward => {
    const level = getRewardLevel(reward);
    if (level > currentJourneyLevel() || receivedAchievementLevels().has(level)) return;
    pendingRewardToastLevels.add(level);
    callAction("achievement_reward", {
      achievement_lv: level
    });
    setLocallyReceivedLevels(rememberReceivedAchievementLevels(localPlayerID, [level]));
  };
  const receiveAllLevelRewards = () => {
    const receivedLevels = receivedAchievementLevels();
    const receivable = achievementLevelRewards().filter(reward => {
      const level = getRewardLevel(reward);
      return level <= currentJourneyLevel() && !receivedLevels.has(level);
    });
    if (receivable.length == 0) return;
    for (const reward of receivable) pendingRewardToastLevels.add(getRewardLevel(reward));
    setLocallyReceivedLevels(rememberReceivedAchievementLevels(localPlayerID, receivable.map(getRewardLevel)));
    callAction("achievement_reward", {
      achievement_lv: 0
    });
  };
  const levelSteamIDs = level => {
    const levelData = roadData().level_players?.[level.toString()];
    const steamIDs = Array.isArray(levelData) ? levelData : levelData?.steamids ?? [];
    const roster = Array.from({
      length: GLORY_ROAD_PLAYER_COUNT
    }, (_, index) => normalizeSteamID(steamIDs[index]));
    if (level != currentJourneyLevel() || localSteamID() == "") return roster;
    const localIndex = roster.indexOf(localSteamID());
    if (localIndex >= 0) {
      roster.splice(localIndex, 1);
    } else {
      const replacementSlot = replacementSlotByLevel.get(level) ?? Math.floor(Math.random() * GLORY_ROAD_PLAYER_COUNT);
      replacementSlotByLevel.set(level, replacementSlot);
      roster.splice(replacementSlot, 1);
    }
    roster.unshift(localSteamID());
    return roster;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileJourney",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "JourneyMap",
        get classList() {
          return {
            LastGroup: currentGroupStart() == 37
          };
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "JourneyRoad"
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "JourneyTitle",
            get className() {
              return $.Language().toLowerCase();
            },
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "JourneyTitleBG"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "JourneyTitleImage"
              }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "JourneyInfo",
                tooltip: "#ProfileTag_GloryRoad_info"
              }), libs.createComponent(EOM_Label.EOM_Label, {
                id: "JourneyDescription",
                text: "#GloryRoad_Description"
              })];
            }
          }), libs.createComponent(libs.For, {
            get each() {
              return visibleLevels();
            },
            children: (level, slotIndex) => {
              const steamIDs = () => levelSteamIDs(level);
              const featuredSteamID = () => steamIDs()[0];
              const featuredPlayerName = () => getPlayerName(featuredSteamID());
              const isCurrentLevel = () => level == currentJourneyLevel();
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("JourneyMilestone", `JourneySlot${slotIndex() + 1}`, {
                    Current: isCurrentLevel()
                  });
                },
                tooltipPosition: "top",
                get customTooltip() {
                  return getJourneyLevelTooltip(level);
                },
                get children() {
                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "JourneyFlag"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    className: "JourneyLevelLabel",
                    text: "#GloryRoad_Level"
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    className: "JourneyLevelValue",
                    get text() {
                      return level.toString();
                    }
                  })];
                }
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                get className() {
                  return libs.classNames("JourneyPlayers", `JourneyPlayersSlot${slotIndex() + 1}`);
                },
                get children() {
                  return [libs.createComponent(libs.For, {
                    get each() {
                      return steamIDs();
                    },
                    children: (steamID, avatarIndex) => libs.createComponent(EOM_Panel.EOM_Panel, {
                      get className() {
                        return libs.classNames("JourneyAvatarSlot", `AvatarSlot${avatarIndex() + 1}`, {
                          Featured: avatarIndex() == 0,
                          Self: steamID != "" && steamID == localSteamID() && isCurrentLevel(),
                          Empty: steamID == ""
                        });
                      },
                      get children() {
                        return libs.createComponent(libs.Show, {
                          when: steamID != "",
                          get children() {
                            return [libs.createComponent(Player.EOM_Avatar, {
                              className: "JourneyAvatar",
                              accountid: steamID,
                              customTooltip: {
                                name: "ladder_player_profile",
                                steamID
                              }
                            }), libs.createComponent(libs.Show, {
                              get when() {
                                return libs.memo(() => steamID == localSteamID())() && isCurrentLevel();
                              },
                              get children() {
                                return libs.createComponent(EOM_Label.EOM_Label, {
                                  className: "JourneySelfLabel",
                                  text: "#GloryRoad_Self"
                                });
                              }
                            })];
                          }
                        });
                      }
                    })
                  }), libs.createComponent(libs.Show, {
                    get when() {
                      return featuredSteamID() != "";
                    },
                    get children() {
                      return libs.createComponent(EOM_Label.EOM_Label, {
                        className: "JourneyFeaturedName",
                        get text() {
                          return featuredPlayerName();
                        }
                      });
                    }
                  })];
                }
              })];
            }
          })];
        }
      }), libs.createComponent(JourneyLevelRewardTrack, {
        get rewards() {
          return achievementLevelRewards();
        },
        get playerLevel() {
          return currentJourneyLevel();
        },
        get receivedLevels() {
          return receivedAchievementLevels();
        },
        onReceive: receiveLevelReward,
        onReceiveAll: receiveAllLevelRewards
      })];
    }
  });
};
const JourneyLevelRewardTrack = props => {
  const targetLevel = () => {
    const receivable = props.rewards.filter(reward => getRewardLevel(reward) <= props.playerLevel && !props.receivedLevels.has(getRewardLevel(reward)));
    const reached = props.rewards.filter(reward => getRewardLevel(reward) <= props.playerLevel);
    return getRewardLevel(receivable[receivable.length - 1]) || getRewardLevel(reached[reached.length - 1]);
  };
  const hasReceivableReward = () => props.rewards.some(reward => {
    const level = getRewardLevel(reward);
    return level > 0 && level <= props.playerLevel && !props.receivedLevels.has(level);
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "JourneyRewardTrack",
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "JourneyRewardScroll",
        scroll: "x",
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "JourneyRewardContent",
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "JourneyRewardLevels",
                get children() {
                  return libs.createComponent(libs.For, {
                    get each() {
                      return props.rewards;
                    },
                    children: reward => {
                      const level = getRewardLevel(reward);
                      const received = () => props.receivedLevels.has(level);
                      const available = () => level <= props.playerLevel && !received();
                      return libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: `JourneyRewardLevel${level}`,
                        className: "JourneyLevelBox",
                        get classList() {
                          return {
                            Received: received(),
                            Available: available()
                          };
                        },
                        onload: self => {
                          if (level == targetLevel()) self.ScrollParentToMakePanelFit(3, false);
                        },
                        onactivate: () => props.onReceive(reward),
                        get children() {
                          return [libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "JourneyRewardSegment",
                            get classList() {
                              return {
                                Reached: level <= props.playerLevel,
                                Last: level == getRewardLevel(props.rewards[props.rewards.length - 1])
                              };
                            },
                            hittest: false
                          }), libs.createComponent(EOM_Panel.EOM_Panel, {
                            className: "JourneyBoxImage",
                            get customTooltip() {
                              return {
                                name: "reward_tooltip",
                                reward_list: JSON.stringify(getLevelRewardTooltipItems(reward))
                              };
                            }
                          }), libs.createComponent(libs.Show, {
                            get when() {
                              return received();
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                className: "JourneyBoxCheck",
                                hittest: false
                              });
                            }
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            className: "JourneyBoxLevel",
                            text: `Lv. ${level}`
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
      }), libs.createComponent(EOM_Button.EOM_Button, {
        color: "Gold",
        id: "JourneyReceiveAll",
        get enabled() {
          return hasReceivableReward();
        },
        get classList() {
          return {
            Disabled: !hasReceivableReward()
          };
        },
        get onactivate() {
          return props.onReceiveAll;
        },
        get children() {
          return libs.createComponent(EOM_Label.EOM_Label, {
            text: "#mail_action_receive_all"
          });
        }
      })];
    }
  });
};

const TierReward = {
  "1": [{
    item_id: 1100001,
    amounts: 1000,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 10,
    rarity: 2
  }],
  "2": [{
    item_id: 1100001,
    amounts: 1200,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 12,
    rarity: 2
  }],
  "3": [{
    item_id: 1100001,
    amounts: 1400,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 16,
    rarity: 2
  }],
  "4": [{
    item_id: 1100001,
    amounts: 1600,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 20,
    rarity: 2
  }, {
    item_id: -1,
    amounts: 1,
    rarity: 3
  }],
  "5": [{
    item_id: 1100001,
    amounts: 1800,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 25,
    rarity: 2
  }, {
    item_id: -1,
    amounts: 1,
    rarity: 3
  }],
  "6": [{
    item_id: 1100001,
    amounts: 2000,
    rarity: 1
  }, {
    item_id: 9310017,
    amounts: 30,
    rarity: 2
  }, {
    item_id: -2,
    amounts: 1,
    rarity: 4
  }]
};
const rewardTiers = Object.keys(TierReward).map(Number);
const RANK_CHANGE_AMOUNTS = 6;
const MIN_GROUP_MEMBER_COUNT = 20;
const WEEKLY_DATA_REQUEST_COOLDOWN_MS = 10 * 1000;
let nextCurrentWeeklyDataRequestTime = 0;
let nextLastWeeklyDataRequestTime = 0;
const getWeeklyRegistrationSchedule = (serverTimestamp = ServerTimestamp()) => {
  const secondsPerDay = 24 * 60 * 60;
  const beijingOffset = 8 * 60 * 60;
  const beijingDay = Math.floor((serverTimestamp + beijingOffset) / secondsPerDay);
  const beijingWeekday = (beijingDay + 4) % 7;
  const beijingDayStart = beijingDay * secondsPerDay - beijingOffset;
  const daysUntilWednesday = (3 - beijingWeekday + 7) % 7 || 7;
  const daysUntilNextFriday = (5 - beijingWeekday + 7) % 7 || 7;
  return {
    isRegistrationOpen: beijingWeekday >= 5 || beijingWeekday <= 2,
    registrationEndTime: beijingDayStart + daysUntilWednesday * secondsPerDay,
    settlementEndTime: beijingDayStart + daysUntilNextFriday * secondsPerDay
  };
};
const isWeeklyRegistrationOpen = (serverTimestamp = ServerTimestamp()) => {
  return getWeeklyRegistrationSchedule(serverTimestamp).isRegistrationOpen;
};
const ProfileTag_WeeklyMatch = () => {
  const localPlayerID = Players.GetLocalPlayer();
  const weeklyMatchData = netdata_utils.createPlayerNetData("weekly_league_data", localPlayerID);
  const lastWeeklyMatchData = netdata_utils.createPlayerNetData("weekly_league_last_data", localPlayerID);
  const [selectedWeek, setSelectedWeek] = libs.createSignal(0);
  const currentWeeklyMatchData = () => {
    return weeklyMatchData();
  };
  const selectedWeeklyData = () => {
    return selectedWeek() == 0 ? weeklyMatchData() : lastWeeklyMatchData();
  };
  const [self_steam_id, setSelfSteamID] = libs.createSignal("-1");
  netdata_utils.createNetTableEffect("player_data", localPlayerID.toString(), data => setSelfSteamID(data.steamID));
  const [previewTier, setPreviewTier] = libs.createSignal();
  const [leavingTier, setLeavingTier] = libs.createSignal();
  const [tierTransitioning, setTierTransitioning] = libs.createSignal(false);
  const [tierTransitionDirection, setTierTransitionDirection] = libs.createSignal("Next");
  const selfTier = () => currentWeeklyMatchData()?.tier ?? 1;
  libs.createEffect(() => {
    if (previewTier() == selfTier()) {
      setPreviewTier(selfTier());
    }
  });
  const requestCurrentWeeklyData = () => {
    const currentTime = Date.now();
    if (currentTime < nextCurrentWeeklyDataRequestTime) {
      return;
    }
    nextCurrentWeeklyDataRequestTime = currentTime + WEEKLY_DATA_REQUEST_COOLDOWN_MS;
    callAction("weekly_league", {
      week_index: 0
    });
  };
  const requestLastWeeklyData = () => {
    const currentTime = Date.now();
    if (currentTime < nextLastWeeklyDataRequestTime) {
      return;
    }
    nextLastWeeklyDataRequestTime = currentTime + WEEKLY_DATA_REQUEST_COOLDOWN_MS;
    GameEvents.SendCustomEventToServer("get_last_weekly_competition_data", {});
  };
  const displayedTier = () => previewTier() ?? selfTier();
  let tierTransitionTimer = -1;
  const changePreviewTier = offset => {
    const currentTier = displayedTier();
    const nextTier = Math.max(1, Math.min(6, currentTier + offset));
    if (currentTier == nextTier) {
      return;
    }
    if (tierTransitionTimer != -1) {
      $.CancelScheduled(tierTransitionTimer);
    }
    setLeavingTier(currentTier);
    setPreviewTier(nextTier);
    setTierTransitionDirection(offset > 0 ? "Next" : "Previous");
    setTierTransitioning(true);
    tierTransitionTimer = $.Schedule(0.15, () => {
      setLeavingTier();
      setTierTransitioning(false);
      tierTransitionTimer = -1;
    });
  };
  {
    requestCurrentWeeklyData();
  }
  const [registrationOpen, setRegistrationOpen] = libs.createSignal(isWeeklyRegistrationOpen());
  const registrationStateTimer = setInterval(() => {
    setRegistrationOpen(isWeeklyRegistrationOpen());
  }, 10000);
  libs.onCleanup(() => {
    if (tierTransitionTimer != -1) {
      $.CancelScheduled(tierTransitionTimer);
    }
    clearInterval(registrationStateTimer);
  });
  const status = () => selectedWeeklyData()?.state ?? -1;
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "WeeklyMatchWindow"
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "WeeklyMatchTitle"
      }, _el$);
      libs.createElement("Image", {
        id: "TitleBG"
      }, _el$2);
      const _el$4 = libs.createElement("Panel", {
        id: "WeeklyMatchTitleContent"
      }, _el$2);
      libs.createElement("Label", {
        id: "WeeklyMatchTitleLabel",
        text: "#ProfileTag_WeeklyMatch"
      }, _el$4);
      const _el$6 = libs.createElement("Panel", {
        id: "WeeklyMatchMain"
      }, _el$),
      _el$7 = libs.createElement("Panel", {
        id: "SelfBrief"
      }, _el$6),
      _el$8 = libs.createElement("Panel", {}, _el$7),
      _el$9 = libs.createElement("Label", {
        get text() {
          return $.Localize("#ProfileBadge") + ":";
        }
      }, _el$8),
      _el$0 = libs.createElement("Label", {
        get text() {
          return currentWeeklyMatchData()?.score ?? 0;
        }
      }, _el$8),
      _el$1 = libs.createElement("Image", {}, _el$7),
      _el$10 = libs.createElement("Panel", {}, _el$7),
      _el$11 = libs.createElement("Label", {
        get text() {
          return $.Localize("#BattleRecords_Rank") + ":";
        }
      }, _el$10),
      _el$12 = libs.createElement("Label", {
        get text() {
          return currentWeeklyMatchData()?.rank ?? 0;
        }
      }, _el$10),
      _el$13 = libs.createElement("Image", {}, _el$7),
      _el$14 = libs.createElement("Panel", {}, _el$7),
      _el$15 = libs.createElement("Label", {
        get text() {
          return $.Localize("#allCount") + ":";
        }
      }, _el$14),
      _el$16 = libs.createElement("Label", {
        get text() {
          return currentWeeklyMatchData()?.game_count ?? 0;
        }
      }, _el$14),
      _el$17 = libs.createElement("Panel", {
        id: "SelfRankTitle"
      }, _el$7),
      _el$18 = libs.createElement("Image", {}, _el$17);
      libs.createElement("Label", {
        text: "#WeeklyMatch_SelfRank"
      }, _el$17);
      const _el$20 = libs.createElement("Image", {}, _el$17),
      _el$21 = libs.createElement("Image", {}, _el$7),
      _el$22 = libs.createElement("Panel", {}, _el$7),
      _el$23 = libs.createElement("Label", {
        get text() {
          return "#WeeklyMatch_Tier" + selfTier();
        }
      }, _el$22),
      _el$24 = libs.createElement("Panel", {
        id: "WeeklyMatchGroupInfo"
      }, _el$6),
      _el$38 = libs.createElement("Panel", {
        id: "GroupBottomButtons"
      }, _el$24),
      _el$39 = libs.createElement("Panel", {
        id: "WeeklyMatchRightInfo"
      }, _el$6),
      _el$40 = libs.createElement("Panel", {
        id: "WeeklyMatchReward"
      }, _el$39),
      _el$41 = libs.createElement("Panel", {
        "class": "WeeklyRightTitle"
      }, _el$40);
      libs.createElement("Label", {
        text: "#WeeklyMatch_Reward"
      }, _el$41);
      const _el$43 = libs.createElement("Panel", {
        id: "RankWrap"
      }, _el$40),
      _el$46 = libs.createElement("Panel", {
        id: "RankTierDots",
        hittest: false
      }, _el$40),
      _el$47 = libs.createElement("Panel", {}, _el$40),
      _el$48 = libs.createElement("Label", {
        get text() {
          return "#WeeklyMatch_Tier" + displayedTier();
        }
      }, _el$47),
      _el$49 = libs.createElement("Panel", {
        id: "RewardList"
      }, _el$40),
      _el$50 = libs.createElement("Panel", {
        id: "WeeklyMatchScoreRule"
      }, _el$39),
      _el$51 = libs.createElement("Panel", {
        "class": "WeeklyRightTitle"
      }, _el$50);
      libs.createElement("Label", {
        text: "#WeeklyMatch_ScoreRule"
      }, _el$51);
      const _el$53 = libs.createElement("Panel", {
        id: "ScoreRuleContent"
      }, _el$50),
      _el$54 = libs.createElement("Panel", {}, _el$53),
      _el$55 = libs.createElement("Image", {}, _el$54);
      libs.createElement("Label", {
        text: "#WeeklyMatch_ScoreRule1"
      }, _el$54);
      const _el$57 = libs.createElement("Panel", {}, _el$53),
      _el$58 = libs.createElement("Image", {}, _el$57);
      libs.createElement("Label", {
        text: "#WeeklyMatch_ScoreRule2"
      }, _el$57);
      const _el$60 = libs.createElement("Panel", {}, _el$53),
      _el$61 = libs.createElement("Image", {}, _el$60);
      libs.createElement("Label", {
        text: "#WeeklyMatch_ScoreRule3"
      }, _el$60);
      const _el$63 = libs.createElement("Panel", {}, _el$53);
      libs.createElement("Label", {
        text: "#WeeklyMatch_ScoreRule4"
      }, _el$63);
    libs.insert(_el$4, libs.createComponent(EOM_Icon.EOM_Icon, {
      size: "24",
      get src() {
        return getSrcPath("icon/c_info.png");
      },
      onmouseover: self => {
        $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#WeeklyMatch_RuleTitle", "#WeeklyMatch_Rule");
      },
      onmouseout: self => {
        $.DispatchEvent("DOTAHideTitleTextTooltip", self);
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return (currentWeeklyMatchData()?.state ?? 0) == 0;
      },
      get fallback() {
        return libs.createComponent(EOM_Countdown.EOM_Countdown, {
          get endTime() {
            return getWeeklyRegistrationSchedule().settlementEndTime;
          },
          text: "#WeeklyMatch_EndCountdown",
          server_time: true
        });
      },
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return registrationOpen();
          },
          get fallback() {
            return libs.createElement("Label", {
              id: "CountdownEnd",
              text: "#WeeklyMatch_JoinEnd"
            }, null);
          },
          get children() {
            return libs.createComponent(EOM_Countdown.EOM_Countdown, {
              get endTime() {
                return getWeeklyRegistrationSchedule().registrationEndTime;
              },
              text: "#WeeklyMatch_JoinCountdown",
              server_time: true
            });
          }
        });
      }
    }), null);
    libs.insert(_el$7, libs.createComponent(Player.PlayerName, {
      id: "SelfName",
      get steamID() {
        return self_steam_id();
      },
      playerID: localPlayerID
    }), _el$8);
    libs.insert(_el$7, libs.createComponent(Player.PlayerAvatar, {
      id: "SelfAvatar",
      get steamID() {
        return self_steam_id();
      },
      playerID: localPlayerID
    }), _el$8);
    libs.setProp(_el$8, "className", "BriefInfoRow");
    libs.setProp(_el$9, "className", "left_info");
    libs.setProp(_el$0, "className", "right_info");
    libs.setProp(_el$1, "className", "SeparatorLine");
    libs.setProp(_el$10, "className", "BriefInfoRow");
    libs.setProp(_el$11, "className", "left_info");
    libs.setProp(_el$12, "className", "right_info");
    libs.setProp(_el$13, "className", "SeparatorLine");
    libs.setProp(_el$14, "className", "BriefInfoRow");
    libs.setProp(_el$15, "className", "left_info");
    libs.setProp(_el$16, "className", "right_info");
    libs.setProp(_el$18, "className", "TitleDecorate");
    libs.setProp(_el$20, "className", "TitleDecorate right");
    libs.setProp(_el$22, "className", "RankTierName");
    libs.insert(_el$24, libs.createComponent(libs.Switch, {
      get fallback() {
        return libs.createComponent(EOM_Loading.EOM_Loading, {
          align: "center center",
          type: "Wave"
        });
      },
      get children() {
        return [libs.createComponent(libs.Match, {
          get when() {
            return status() == 0;
          },
          get children() {
            return libs.createComponent(libs.Show, {
              get when() {
                return selectedWeek() == 0;
              },
              get fallback() {
                return (() => {
                  const _el$66 = libs.createElement("Label", {
                    text: "#WeeklyMatch_Status0_Last"
                  }, null);
                  libs.setProp(_el$66, "className", "GroupInfoCenterLabel");
                  return _el$66;
                })();
              },
              get children() {
                return libs.createComponent(libs.Show, {
                  get when() {
                    return registrationOpen();
                  },
                  get fallback() {
                    return (() => {
                      const _el$67 = libs.createElement("Label", {
                        text: "#WeeklyMatch_JoinEnd"
                      }, null);
                      libs.setProp(_el$67, "className", "GroupInfoCenterLabel");
                      return _el$67;
                    })();
                  },
                  get children() {
                    const _el$25 = libs.createElement("Label", {
                      text: "#WeeklyMatch_Status0"
                    }, null);
                    libs.setProp(_el$25, "className", "GroupInfoCenterLabel");
                    return _el$25;
                  }
                });
              }
            });
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return status() == 1;
          },
          get children() {
            const _el$26 = libs.createElement("Label", {
              text: "#WeeklyMatch_Status1"
            }, null);
            libs.setProp(_el$26, "className", "GroupInfoCenterLabel");
            return _el$26;
          }
        }), libs.createComponent(libs.Match, {
          get when() {
            return status() == 2;
          },
          get children() {
            return [(() => {
              const _el$27 = libs.createElement("Panel", {
                  id: "GroupTitleRow"
                }, null),
                _el$28 = libs.createElement("Panel", {}, _el$27);
                libs.createElement("Label", {
                  text: "#BattleRecords_Rank"
                }, _el$28);
                const _el$30 = libs.createElement("Panel", {}, _el$27);
                libs.createElement("Label", {
                  text: "#Scoreboard_Title_Player"
                }, _el$30);
                const _el$32 = libs.createElement("Panel", {}, _el$27);
                libs.createElement("Label", {
                  text: "#ProfileBadge"
                }, _el$32);
                const _el$34 = libs.createElement("Panel", {}, _el$27);
                libs.createElement("Label", {
                  text: "#allCount"
                }, _el$34);
                const _el$36 = libs.createElement("Panel", {}, _el$27);
                libs.createElement("Label", {
                  text: "#WeeklyMatch_Status"
                }, _el$36);
              libs.setProp(_el$28, "className", "RankColumn 1");
              libs.setProp(_el$30, "className", "RankColumn 2");
              libs.setProp(_el$32, "className", "RankColumn 3");
              libs.setProp(_el$34, "className", "RankColumn 4");
              libs.setProp(_el$36, "className", "RankColumn 5");
              return _el$27;
            })(), libs.createComponent(EOM_Panel.EOM_Panel, {
              id: "GroupList",
              scroll: "y",
              get children() {
                return libs.createComponent(libs.For, {
                  get each() {
                    return selectedWeeklyData()?.members ?? [];
                  },
                  children: (member, index) => {
                    let members_count = selectedWeeklyData()?.members.length ?? 0;
                    let down_count = members_count > MIN_GROUP_MEMBER_COUNT ? members_count - RANK_CHANGE_AMOUNTS : MIN_GROUP_MEMBER_COUNT - RANK_CHANGE_AMOUNTS;
                    const state = index() < RANK_CHANGE_AMOUNTS ? "up" : index() >= down_count ? "down" : "same";
                    return libs.createComponent(WeeklyMatchRankRow, {
                      member: member,
                      state: state,
                      get match_over() {
                        return selectedWeek() != 0;
                      }
                    });
                  }
                });
              }
            })];
          }
        })];
      }
    }), _el$38);
    libs.insert(_el$38, libs.createComponent(EOM_Button.EOM_Button, {
      type: "C4glass",
      get color() {
        return selectedWeek() == 0 ? "Gold" : "Blue";
      },
      text: "#WeeklyMatch_DataNow",
      onactivate: () => {
        if (selectedWeek() != 0) {
          setSelectedWeek(0);
        }
      }
    }), null);
    libs.insert(_el$38, libs.createComponent(EOM_Button.EOM_Button, {
      type: "C4glass",
      get color() {
        return selectedWeek() == -1 ? "Gold" : "Blue";
      },
      text: "#WeeklyMatch_DataLast",
      onactivate: () => {
        if (selectedWeek() != -1) {
          setSelectedWeek(-1);
          requestLastWeeklyData();
        }
      }
    }), null);
    libs.insert(_el$43, libs.createComponent(EOM_Button.EOM_BaseButton, {
      className: "ArrowButton",
      get enabled() {
        return libs.memo(() => !!!tierTransitioning())() && TierReward[(displayedTier() - 1).toString()] != undefined;
      },
      onactivate: () => changePreviewTier(-1)
    }), null);
    libs.insert(_el$43, libs.createComponent(libs.Show, {
      get when() {
        return leavingTier() != undefined;
      },
      get children() {
        const _el$44 = libs.createElement("Image", {}, null);
        libs.effect(_$p => libs.setProp(_el$44, "className", libs.classNames("WeeklyRankIcon", "Leaving", "Tier" + leavingTier()), _$p));
        return _el$44;
      }
    }), null);
    libs.insert(_el$43, libs.createComponent(libs.Show, {
      get when() {
        return tierTransitioning();
      },
      get fallback() {
        return (() => {
          const _el$68 = libs.createElement("Image", {}, null);
          libs.effect(_$p => libs.setProp(_el$68, "className", libs.classNames("WeeklyRankIcon", "Tier" + displayedTier()), _$p));
          return _el$68;
        })();
      },
      get children() {
        const _el$45 = libs.createElement("Image", {}, null);
        libs.effect(_$p => libs.setProp(_el$45, "className", libs.classNames("WeeklyRankIcon", "Entering", "Tier" + displayedTier()), _$p));
        return _el$45;
      }
    }), null);
    libs.insert(_el$43, libs.createComponent(EOM_Button.EOM_BaseButton, {
      className: "ArrowButton right",
      get enabled() {
        return libs.memo(() => !!!tierTransitioning())() && TierReward[(displayedTier() + 1).toString()] != undefined;
      },
      onactivate: () => changePreviewTier(1)
    }), null);
    libs.insert(_el$46, libs.createComponent(libs.For, {
      each: rewardTiers,
      children: tier => (() => {
        const _el$69 = libs.createElement("Panel", {}, null);
        libs.effect(_$p => libs.setProp(_el$69, "className", libs.classNames("RankTierDot", {
          Selected: tier == displayedTier()
        }), _$p));
        return _el$69;
      })()
    }));
    libs.setProp(_el$47, "className", "RankTierName");
    libs.insert(_el$49, libs.createComponent(libs.For, {
      get each() {
        return TierReward[displayedTier()] ?? [];
      },
      children: reward => (() => {
        const _el$70 = libs.createElement("Panel", {}, null);
        libs.insert(_el$70, libs.createComponent(libs.Show, {
          get when() {
            return reward.item_id < 0;
          },
          get fallback() {
            return [libs.createComponent(ProductImage.ProductImage, {
              get itemid() {
                return reward.item_id;
              },
              get count() {
                return reward.amounts;
              }
            }), (() => {
              const _el$74 = libs.createElement("Label", {
                "class": "RewardItemName",
                get text() {
                  return "#" + reward.item_id;
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$74, "text", "#" + reward.item_id, _$p));
              return _el$74;
            })()];
          },
          get children() {
            return [(() => {
              const _el$71 = libs.createElement("Image", {}, null);
              libs.setProp(_el$71, "onmouseover", self => {
                $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#WeeklySpecialReward_" + Math.abs(reward.item_id), "#WeeklySpecialReward_" + Math.abs(reward.item_id) + "_description");
              });
              libs.setProp(_el$71, "onmouseout", self => {
                $.DispatchEvent("DOTAHideTitleTextTooltip", self);
              });
              libs.effect(_$p => libs.setProp(_el$71, "className", libs.classNames("ProductImage", "Special_" + Math.abs(reward.item_id)), _$p));
              return _el$71;
            })(), (() => {
              const _el$72 = libs.createElement("Image", {
                hittest: false
              }, null);
              libs.effect(_$p => libs.setProp(_el$72, "className", libs.classNames("Special_Tag", $.Language().toLowerCase()), _$p));
              return _el$72;
            })(), (() => {
              const _el$73 = libs.createElement("Label", {
                "class": "RewardItemName",
                get text() {
                  return "#WeeklySpecialReward_" + Math.abs(reward.item_id);
                }
              }, null);
              libs.effect(_$p => libs.setProp(_el$73, "text", "#WeeklySpecialReward_" + Math.abs(reward.item_id), _$p));
              return _el$73;
            })()];
          }
        }));
        libs.effect(_$p => libs.setProp(_el$70, "className", libs.classNames("RewardItem", "Rarity" + reward.rarity), _$p));
        return _el$70;
      })()
    }));
    libs.setProp(_el$54, "className", "ScoreRuleLine");
    libs.setProp(_el$55, "className", "ScoreRulePoint");
    libs.setProp(_el$57, "className", "ScoreRuleLine");
    libs.setProp(_el$58, "className", "ScoreRulePoint");
    libs.setProp(_el$60, "className", "ScoreRuleLine");
    libs.setProp(_el$61, "className", "ScoreRulePoint");
    libs.setProp(_el$63, "className", "ScoreRuleLine short");
    libs.effect(_p$ => {
      const _v$ = $.Localize("#ProfileBadge") + ":",
        _v$2 = currentWeeklyMatchData()?.score ?? 0,
        _v$3 = $.Localize("#BattleRecords_Rank") + ":",
        _v$4 = currentWeeklyMatchData()?.rank ?? 0,
        _v$5 = $.Localize("#allCount") + ":",
        _v$6 = currentWeeklyMatchData()?.game_count ?? 0,
        _v$7 = libs.classNames("WeeklyRankIcon", "small", "Tier" + selfTier()),
        _v$8 = "#WeeklyMatch_Tier" + selfTier(),
        _v$9 = "Direction" + tierTransitionDirection(),
        _v$0 = "#WeeklyMatch_Tier" + displayedTier();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$9, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$0, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$11, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$12, "text", _v$4, _p$._v$4));
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$15, "text", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$16, "text", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$21, "className", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$23, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$43, "className", _v$9, _p$._v$9));
      _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$48, "text", _v$0, _p$._v$0));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined,
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined,
      _v$8: undefined,
      _v$9: undefined,
      _v$0: undefined
    });
    return _el$;
  })();
};
const WeeklyMatchRankRow = props => {
  const rank = () => props.member.rank;
  const stateLable = () => {
    switch (props.state) {
      case "up":
        if (props.match_over) {
          return "#WeeklyMatch_StatusUp_Over";
        }
        return "#WeeklyMatch_StatusUp";
      case "down":
        if (props.match_over) {
          return "#WeeklyMatch_StatusDown_Over";
        }
        return "#WeeklyMatch_StatusDown";
      case "same":
        if (props.match_over) {
          return "#WeeklyMatch_StatusSame_Over";
        }
        return "#WeeklyMatch_StatusSame";
    }
  };
  return (() => {
    const _el$75 = libs.createElement("Panel", {}, null),
      _el$76 = libs.createElement("Panel", {}, _el$75),
      _el$77 = libs.createElement("Image", {}, _el$76),
      _el$78 = libs.createElement("Label", {
        get text() {
          return libs.memo(() => rank() <= 3)() ? "" : rank();
        }
      }, _el$76),
      _el$79 = libs.createElement("Panel", {}, _el$75),
      _el$80 = libs.createElement("Panel", {}, _el$75),
      _el$81 = libs.createElement("Label", {
        get text() {
          return props.member.score;
        }
      }, _el$80),
      _el$82 = libs.createElement("Panel", {}, _el$75),
      _el$83 = libs.createElement("Label", {
        get text() {
          return props.member.game_count;
        }
      }, _el$82),
      _el$84 = libs.createElement("Panel", {}, _el$75),
      _el$85 = libs.createElement("Label", {
        "class": "StatusLabel",
        get text() {
          return stateLable();
        }
      }, _el$84);
    libs.setProp(_el$76, "className", "RankColumn 1");
    libs.setProp(_el$77, "className", "RankBackground");
    libs.setProp(_el$78, "className", "RankNumber");
    libs.setProp(_el$79, "className", "RankColumn 2 PlayerColumn");
    libs.insert(_el$79, libs.createComponent(Player.PlayerAvatar, {
      className: "MemberAvatar",
      get steamID() {
        return props.member.uid.toString();
      },
      get avatar_border() {
        return props.member.oid71;
      },
      get customTooltip() {
        return {
          name: "ladder_player_profile",
          steamID: props.member.uid,
          avatarBorder: props.member.oid71,
          avatarBG: props.member.oid72,
          avatarDecoration: props.member.oid73
        };
      }
    }), null);
    libs.insert(_el$79, libs.createComponent(Player.PlayerName, {
      className: "MemberName",
      get steamID() {
        return props.member.uid.toString();
      }
    }), null);
    libs.setProp(_el$80, "className", "RankColumn 3");
    libs.setProp(_el$82, "className", "RankColumn 4");
    libs.setProp(_el$84, "className", "RankColumn 5");
    libs.effect(_p$ => {
      const _v$1 = libs.classNames("WeeklyMatchRankRow", "Rank" + rank(), props.state),
        _v$10 = libs.memo(() => rank() <= 3)() ? "" : rank(),
        _v$11 = props.member.score,
        _v$12 = props.member.game_count,
        _v$13 = {
          StatusUp: props.state == "up",
          StatusDown: props.state == "down",
          StatusSame: props.state == "same"
        },
        _v$14 = stateLable();
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$75, "className", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$78, "text", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$81, "text", _v$11, _p$._v$11));
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$83, "text", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$85, "classList", _v$13, _p$._v$13));
      _v$14 !== _p$._v$14 && (_p$._v$14 = libs.setProp(_el$85, "text", _v$14, _p$._v$14));
      return _p$;
    }, {
      _v$1: undefined,
      _v$10: undefined,
      _v$11: undefined,
      _v$12: undefined,
      _v$13: undefined,
      _v$14: undefined
    });
    return _el$75;
  })();
};

if (!isSpectator()) {
  const bSelf = () => {
    return GameUI.ProfilePlayerId() == Players.GetLocalPlayer();
  };
  const Profile = () => {
    const profile_list = {
      ProfileTag_SelfInfo: [],
      ProfileTag_BattleRecords: [],
      ProfileTag_WeeklyMatch: [],
      ProfileTag_Achievement: ["ProfileTag_GloryRoad", "ProfileTag_AchievementList"]
    };
    const meunList = () => bSelf() ? profile_list : {
      ProfileTag_SelfInfo: []
    };
    const [show, setShow] = libs.createSignal(false);
    const [tabIndex, setTabIndex] = libs.createSignal(0);
    const [subTab, setSubTab] = libs.createSignal("ProfileTag_Journey");
    const menuKeys = () => Object.keys(meunList());
    libs.createEffect(() => {
      setClientGlobalData("menu_bar_profile_tabs", menuKeys());
    });
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
    libs.onMount(() => {
      const eventIdList = [];
      eventIdList.push(useToggleWindow("MenuButton_profile", show, setShow));
      eventIdList.push(useClientSideEvent("menu_bar_profile_tab", data => {
        const tabIndex = menuKeys().indexOf(data.tag);
        if (tabIndex != -1) {
          setTabIndex(tabIndex);
        }
      }));
      libs.onCleanup(() => eventIdList.forEach(id => GameEvents.Unsubscribe(id)));
    });
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      get className() {
        return menuKeys()[tabIndex()];
      },
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
              get className() {
                return libs.classNames({
                  GloryRoad: tag == "ProfileTag_Achievement" && subTab() == "ProfileTag_GloryRoad"
                });
              },
              get show() {
                return tabIndex() == index();
              },
              renderOnShow: true,
              get children() {
                return (() => {
                  switch (tag) {
                    case "ProfileTag_SelfInfo":
                      return libs.createComponent(ProfileMain, {});
                    case "ProfileTag_BattleRecords":
                      return libs.createComponent(ProfileBattleRecords, {});
                    case "ProfileTag_Achievement":
                      return [libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("ProfileAchievementSubPage", {
                            Hidden: subTab() != "ProfileTag_GloryRoad"
                          });
                        },
                        get children() {
                          return libs.createComponent(ProfileJourney, {
                            get refresh() {
                              return libs.memo(() => !!(show() && tabIndex() == index()))() && subTab() == "ProfileTag_GloryRoad";
                            }
                          });
                        }
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        get className() {
                          return libs.classNames("ProfileAchievementSubPage", {
                            Hidden: subTab() == "ProfileTag_GloryRoad"
                          });
                        },
                        get children() {
                          return libs.createComponent(ProfileAchievement, {});
                        }
                      })];
                    case "ProfileTag_WeeklyMatch":
                      return libs.createComponent(ProfileTag_WeeklyMatch, {});
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
      onClickCollection: () => {
        if (bSelf()) {
          showPopup("SelectCollections", {});
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
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              text: "#ChangeShow"
            });
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