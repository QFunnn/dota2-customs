--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('profile_simplify', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_PortraitFullBody = require('./EOM_PortraitFullBody.js');
var EOM_DropDown = require('./EOM_DropDown.js');
var GenericPanel = require('./GenericPanel.js');
var MedalBadgeIcon = require('./MedalBadgeIcon.js');
var profile_info = require('./profile_info.js');
var RankTierIcon = require('./RankTierIcon.js');
var game_utils = require('./game_utils.js');
var CosmeticCard = require('./CosmeticCard.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');

const useCollections = props => {
  const merged = libs.mergeProps$1({
    playerId: Players.GetLocalPlayer()
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerId", "onClick"]);
  const [collections, setCollections] = libs.createSignal([]);
  const playerId = () => local.playerId;
  libs.createEffect(libs.on(() => merged.player_ornament_slots, data => {
    if (data != undefined) {
      let collections = [];
      data.forEach(collection => {
        collections[collection.slot - 1] = collection.oid.toString();
      });
      setCollections(collections);
    }
  }));
  libs.onMount(() => {
    const NetTableListenerIDs = [];
    NetTableListenerIDs.push(useServiceNetTable("player_ornament_slots", (data, playerID) => {
      if (merged.player_ornament_slots == undefined && playerID == playerId()) {
        let collections = [];
        data.forEach(collection => {
          collections[collection.slot - 1] = collection.oid.toString();
        });
        setCollections(collections);
      }
    }, -1));
    libs.onCleanup(() => {
      NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  return {
    collections,
    setCollections
  };
};
const CollectionList = props => {
  const merged = libs.mergeProps$1({
    playerId: Players.GetLocalPlayer(),
    listCount: 10
  }, props);
  const [local, others] = libs.splitProps(merged, ["playerId", "onClick", "onClose", "selectedSlot", "listCount"]);
  const {
    collections} = useCollections(props);
  const list = () => [...Array(local.listCount)].map((_, i) => i);
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "CollectionList",
    scroll: "x",
    get children() {
      return libs.createComponent(libs.Index, {
        get each() {
          return list();
        },
        children: index => {
          let show = () => collections()[index()] != undefined;
          let data = () => GameUI.CustomUIConfig().CosmeticsKv[collections()[index()]];
          return (() => {
            const _el$ = libs.createElement("Panel", {
              id: "Collection"
            }, null);
            libs.setProp(_el$, "onactivate", () => {
              if (local.onClick) local.onClick(index());
            });
            libs.insert(_el$, libs.createComponent(libs.Switch, {
              fallback: () => libs.createComponent(GenericPanel.CImage, {
                id: "CollectionAdd",
                get src() {
                  return getSrcPath("profile/d_icon_02.png");
                }
              }),
              get children() {
                return libs.createComponent(libs.Match, {
                  get when() {
                    return show();
                  },
                  get children() {
                    return [libs.createComponent(CosmeticCard.CosmeticCard, {
                      get itemid() {
                        return collections()[index()];
                      },
                      get rarity() {
                        return data()?.rarity ?? 0;
                      },
                      get mark() {
                        return data()?.mark ?? 0;
                      },
                      enableHover: false
                    }), libs.createComponent(libs.Show, {
                      get when() {
                        return libs.memo(() => local.onClose != undefined)() && index() == local.selectedSlot;
                      },
                      get children() {
                        return libs.createComponent(EOM_Icon.EOM_Icon, {
                          size: '24',
                          margin: '6px',
                          onactivate: () => {
                            local.onClose(index());
                          },
                          get src() {
                            return getSrcPath("hero_collection/s5_close.png");
                          }
                        });
                      }
                    })];
                  }
                });
              }
            }), null);
            libs.insert(_el$, libs.createComponent(libs.Show, {
              get when() {
                return props.markType != undefined;
              },
              get children() {
                return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
                  get type() {
                    return props.markType;
                  }
                });
              }
            }), null);
            libs.effect(_$p => libs.setProp(_el$, "classList", {
              "add": !show(),
              "self": local.playerId == Players.GetLocalPlayer(),
              "selected": local.selectedSlot == index()
            }, _$p));
            return _el$;
          })();
        }
      });
    }
  });
};

const ProfileInfoLayout = props => {
  const showExchange = () => props.showExchange == true;
  const medalCount = () => props.medalCount ?? 0;
  const winCount = () => props.winCount ?? 0;
  const fourCount = () => props.fourCount ?? 0;
  const allCount = () => props.allCount ?? 0;
  const heroCount = () => props.heroCount ?? 0;
  const heroCollected = () => heroCount() + " / " + Object.keys(KeyValues.UnitsCommonKv).filter(name => KeyValues.UnitsCommonKv[name].Hide == 0).length;
  const loginDay = () => props.loginDay ?? 0;
  const maxCup = () => props.maxCup ?? 0;
  const collectionNewMark = () => props.collectionNewMark;
  const playerVipExpire = () => props.playerVipExpire ?? -1;
  const heroName = () => props.heroName;
  const courierName = () => props.courierName;
  const playerID = () => props.playerID;
  const CareerSummaryList = {
    "winCount": winCount,
    "fourCount": fourCount,
    "allCount": allCount,
    "maxCup": maxCup,
    "heroCollected": heroCollected,
    "loginDay": loginDay
  };
  const one = () => {
    if (heroName() != "" && courierName() != "") return false;
    return true;
  };
  const isSelf = () => playerID() == Players.GetLocalPlayer();
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "ProfileInfoLayout",
    hittest: false,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "LeftSide"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "CareerData",
            get ["class"]() {
              return $.Language().toLowerCase();
            }
          }, _el$),
          _el$3 = libs.createElement("Panel", {
            id: "Badge"
          }, _el$2),
          _el$4 = libs.createElement("Panel", {
            id: "VipBtn"
          }, _el$2),
          _el$5 = libs.createElement("Panel", {
            id: "CareerSummary"
          }, _el$2);
        libs.insert(_el$, libs.createComponent(ProfileInfoSimplify, {
          get player_id() {
            return playerID();
          },
          get edit() {
            return isSelf();
          },
          get popupInfo() {
            return props.popupInfo;
          },
          get ban() {
            return props.ban;
          }
        }), _el$2);
        libs.insert(_el$3, libs.createComponent(MedalBadgeIcon.MedalBadgeIcon, {
          get medal_count() {
            return medalCount();
          },
          customTooltip: {
            name: "medal_info"
          }
        }), null);
        libs.insert(_el$3, libs.createComponent(GenericPanel.CImage, {
          id: "BadgeIcon"
        }), null);
        libs.insert(_el$3, libs.createComponent(GenericPanel.CLabel, {
          id: "BadgeText",
          get text() {
            return medalCount();
          }
        }), null);
        libs.setProp(_el$4, "onactivate", () => {
          if (isSelf()) {
            clientSideEvent("toggle_store_tag", {
              menu: "VIP"
            });
          }
        });
        libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
          id: "VipIcon"
        }), null);
        libs.insert(_el$4, libs.createComponent(EOM_Countdown.EOM_Countdown, {
          id: "remain",
          get className() {
            return $.Language().toLowerCase();
          },
          get endTime() {
            return playerVipExpire();
          },
          text: "#profile_vip_remain"
        }), null);
        libs.insert(_el$4, libs.createComponent(GenericPanel.CImage, {
          get visible() {
            return isSelf();
          },
          id: "VipAdd",
          get src() {
            return getSrcPath("profile/add.png");
          }
        }), null);
        libs.insert(_el$5, libs.createComponent(libs.For, {
          get each() {
            return Object.keys(CareerSummaryList);
          },
          children: key => {
            return (() => {
              const _el$7 = libs.createElement("Panel", {
                  id: "CareerSummaryPanel"
                }, null),
                _el$8 = libs.createElement("Panel", {
                  id: "CareerSummaryValue"
                }, _el$7);
              libs.insert(_el$7, libs.createComponent(GenericPanel.CLabel, {
                id: "CareerSummaryTitle",
                text: "#" + key
              }), _el$8);
              libs.insert(_el$8, libs.createComponent(GenericPanel.CImage, {
                id: "CareerSummaryBg"
              }), null);
              libs.insert(_el$8, libs.createComponent(GenericPanel.CLabel, {
                id: "CareerSummaryValueText",
                get text() {
                  return CareerSummaryList[key]();
                }
              }), null);
              return _el$7;
            })();
          }
        }));
        libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "HeroTitle",
          marginTop: "20px",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              id: "HeroTitleText",
              text: "#Collections"
            });
          }
        }), null);
        libs.insert(_el$, libs.createComponent(CollectionList, {
          get playerId() {
            return GameUI.ProfilePlayerId();
          },
          get player_ornament_slots() {
            return props.popupInfo?.player_ornament_slots;
          },
          get markType() {
            return collectionNewMark();
          },
          onClick: sef => {
            if (props.onClickCollection) {
              props.onClickCollection();
            }
          }
        }), null);
        libs.effect(_p$ => {
          const _v$ = {
              "showChange": showExchange()
            },
            _v$2 = $.Language().toLowerCase();
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "classList", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "class", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$;
      })(), (() => {
        const _el$6 = libs.createElement("Panel", {
          id: "Preview"
        }, null);
        libs.insert(_el$6, libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
          id: "CourierPreview",
          showPedestal: false,
          get unitname() {
            return courierName();
          }
        }), null);
        libs.insert(_el$6, libs.createComponent(libs.Show, {
          get when() {
            return heroName() != "";
          },
          get children() {
            return libs.createComponent(EOM_PortraitFullBody.EOM_PortraitFullBody, {
              id: "HeroPreview",
              showPedestal: false,
              get unitname() {
                return heroName();
              }
            });
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$6, "classList", {
          "showChange": showExchange(),
          "one": one()
        }, _$p));
        return _el$6;
      })()];
    }
  });
};
const ProfileInfoSimplify = props => {
  const gameSeason = game_utils.GetGameSeason();
  let hasSelectedSeason = false;
  const [rankScoreData, setRankScoreData] = libs.createSignal();
  const [selectedSeasonIndex, setSelectedSeasonIndex] = libs.createSignal(0);
  const selectedSeason = () => {
    if (seasonList() && seasonList()[selectedSeasonIndex()]) {
      return seasonList()[selectedSeasonIndex()];
    }
    return gameSeason();
  };
  const seasonList = libs.createMemo(() => {
    let list = [];
    if (rankScoreData()) {
      list = Object.keys(rankScoreData()).map(v => Number(v)).sort((a, b) => b - a);
    } else {
      list = [gameSeason()];
    }
    return list;
  });
  libs.createEffect(() => {
    if (!hasSelectedSeason) {
      if (seasonList().length > 0) {
        setSelectedSeasonIndex(0);
      }
    }
  });
  const rankData = () => {
    const data = rankScoreData();
    if (data && data[selectedSeason()]) {
      return data[selectedSeason()];
    }
  };
  const rankScore = () => rankData()?.now_rank_score ?? 0;
  const rank = () => rankData()?.leaderboard_rank ?? -1;
  const rankInfo = libs.createMemo(() => getRankInfo(rankScore()));
  const rankTitle = () => {
    if (rankInfo().tier == 8 && rank() > 0 && rank() < 100) {
      if (rank() > 0 && rank() < 100) {
        return $.Localize("#RankTitle_0") + ` <font color='gold'>${rank()}</font>`;
      }
      return $.Localize("#RankTitle_" + rankInfo().tier);
    }
    return $.Localize("#RankTitle_" + rankInfo().tier) + rankInfo().num;
  };
  const [seasonGameSummaryData, setSeasonGameSummaryData] = libs.createSignal();
  const seasonGameSummary = () => {
    const data = seasonGameSummaryData();
    if (data && data[gameSeason()]) {
      return data[gameSeason()];
    }
  };
  const season_winCount = libs.createMemo(() => seasonGameSummary()?.rank_1_count ?? 0);
  const season_allCount = libs.createMemo(() => seasonGameSummary()?.total_count ?? 0);
  const season_four = libs.createMemo(() => seasonGameSummary()?.win_count ?? 0);
  const SeasonSummayList = {
    "all": season_allCount,
    "win": season_winCount,
    "four": season_four
  };
  const winRate = libs.createMemo(() => {
    if (season_allCount() == 0) return 0;
    return Math.floor(season_four() / season_allCount() * 100);
  });
  if (props.player_id == undefined && props.popupInfo != undefined) {
    libs.createEffect(libs.on(() => props.popupInfo, v => {
      if (v) {
        libs.batch(() => {
          setRankScoreData(v.player_rank_score);
          setSeasonGameSummaryData(v.season_game_summary);
        });
      }
    }));
  } else {
    let player_id = () => props.player_id ?? Players.GetLocalPlayer();
    libs.onMount(() => {
      const NetTableListenerIDs = [];
      NetTableListenerIDs.push(useServiceNetTable("season_game_summary", data => {
        setSeasonGameSummaryData(data);
      }, player_id()));
      NetTableListenerIDs.push(useServiceNetTable("player_rank_score", data => {
        setRankScoreData(data);
      }, player_id()));
      libs.onCleanup(() => {
        NetTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    });
  }
  return [libs.createComponent(profile_info.ProfileInfo, {
    get player_id() {
      return props.player_id;
    },
    get edit() {
      return props.edit;
    },
    get steamID() {
      return props.popupInfo?.uid;
    },
    get avatar_background() {
      return props.popupInfo?.ornament[OrnamentType.AVATAR_BACKGROUND];
    },
    get avatar_decoration() {
      return props.popupInfo?.ornament[OrnamentType.AVATAR_DECORATION];
    },
    get avatar_border() {
      return props.popupInfo?.ornament[OrnamentType.AVATAR_BORDER];
    },
    get ban() {
      return props.player_id != Players.GetLocalPlayer() && props.ban;
    }
  }), libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "HeroTitle",
    get children() {
      return libs.createComponent(GenericPanel.CLabel, {
        id: "HeroTitleText",
        text: "#PersonalData"
      });
    }
  }), (() => {
    const _el$9 = libs.createElement("Panel", {
        id: "RankData"
      }, null),
      _el$0 = libs.createElement("Panel", {
        id: "RankText"
      }, _el$9),
      _el$1 = libs.createElement("Panel", {
        id: "rankTitlePanel"
      }, _el$0),
      _el$10 = libs.createElement("Panel", {
        id: "winRate"
      }, _el$9),
      _el$11 = libs.createElement("Panel", {
        id: "winRateBlack"
      }, _el$10),
      _el$12 = libs.createElement("Panel", {
        id: "Summary"
      }, _el$9);
    libs.insert(_el$9, libs.createComponent(RankTierIcon.RankTierIcon, {
      id: "RankIcon",
      get rank_score() {
        return rankScore();
      },
      get rank() {
        return rank();
      },
      size: "150",
      customTooltip: {
        name: "ladder_info"
      }
    }), _el$0);
    libs.insert(_el$0, libs.createComponent(libs.Show, {
      get when() {
        return seasonList().length > 1;
      },
      get fallback() {
        return libs.createComponent(GenericPanel.CLabel, {
          id: "season",
          text: "#Season",
          get dialogVariables() {
            return {
              season: selectedSeason() % 100
            };
          }
        });
      },
      get children() {
        return libs.createComponent(EOM_DropDown.EOM_DropDown, {
          id: "GameSeasonDropDown",
          index: 0,
          menuPosition: "bottom",
          onChange: (index, item) => {
            hasSelectedSeason = true;
            setSelectedSeasonIndex(index);
          },
          get children() {
            return libs.createComponent(libs.For, {
              get each() {
                return seasonList();
              },
              children: (season, index) => {
                return libs.createComponent(GenericPanel.CLabel, {
                  text: "#Season",
                  dialogVariables: {
                    season: season % 100
                  }
                });
              }
            });
          }
        });
      }
    }), _el$1);
    libs.insert(_el$1, libs.createComponent(GenericPanel.CLabel, {
      id: "rankTitle",
      get text() {
        return rankTitle();
      },
      html: true
    }), null);
    libs.insert(_el$1, libs.createComponent(GenericPanel.CImage, {
      id: "rankInfo",
      get src() {
        return getSrcPath("profile/d_button_03.png");
      },
      onactivate: () => {
        showPopup("RankInfo", {});
      }
    }), null);
    libs.insert(_el$0, libs.createComponent(EOM_Panel.EOM_Panel, {
      id: "RankScoreMedal",
      get children() {
        return [libs.createComponent(EOM_Icon.EOM_Icon, {
          size: "48",
          get src() {
            return getSrcPath("icon/icon_rank_cup.png");
          }
        }), libs.createComponent(EOM_Panel.EOM_Panel, {
          id: "RankScoreProgressBar",
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return rankScore();
              }
            });
          }
        })];
      }
    }), null);
    libs.insert(_el$10, libs.createComponent(GenericPanel.CLabel, {
      id: "winRateText",
      text: "#WinRate"
    }), _el$11);
    libs.insert(_el$11, libs.createComponent(GenericPanel.CImage, {
      id: "winRateGreen",
      get style() {
        return {
          clip: `radial(50% 50%, 0deg, ${-winRate() * 360 / 100}deg);`
        };
      }
    }), null);
    libs.insert(_el$11, libs.createComponent(GenericPanel.CLabel, {
      id: "winRateValue",
      get text() {
        return winRate() + "%";
      }
    }), null);
    libs.insert(_el$12, libs.createComponent(libs.For, {
      get each() {
        return Object.keys(SeasonSummayList);
      },
      children: key => {
        return (() => {
          const _el$13 = libs.createElement("Panel", {
            id: "SummaryPanel"
          }, null);
          libs.insert(_el$13, libs.createComponent(GenericPanel.CImage, {
            id: "SummaryBg"
          }), null);
          libs.insert(_el$13, libs.createComponent(GenericPanel.CLabel, {
            id: "SummaryText",
            text: "#" + key
          }), null);
          libs.insert(_el$13, libs.createComponent(GenericPanel.CLabel, {
            id: "SummaryValue",
            get text() {
              return SeasonSummayList[key]();
            }
          }), null);
          return _el$13;
        })();
      }
    }));
    libs.effect(_$p => libs.setProp(_el$9, "className", $.Language().toLowerCase(), _$p));
    return _el$9;
  })()];
};

exports.CollectionList = CollectionList;
exports.ProfileInfoLayout = ProfileInfoLayout;
exports.ProfileInfoSimplify = ProfileInfoSimplify;
exports.useCollections = useCollections;