--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var Player = require('./Player.js');
var StoreTagPage = require('./StoreTagPage.js');
var EOM_HeroImage = require('./EOM_HeroImage.js');
var EOM_RedMark = require('./EOM_RedMark.js');
var EOM_Button = require('./EOM_Button.js');
var solid_utils = require('./solid_utils.js');
var common_match_leaderboard = require('./common_match_leaderboard.js');
require('./service_netdata_helper.js');
require('./EOM_TextEntry.js');
require('./StoreItem.js');
require('./EOM_Countdown.js');
require('./equipment_utils.js');
require('./EOM_Loading.js');

const PVP_AUTO_REQUEST_INTERVAL = 5 * 60;
const DEFAULT_PVP_SCORE = 1000;
const LEADERBOARD_PAGE_SIZE = 10;
const LEADERBOARD_MAX_PAGE = 50;
let lastPvpRequestTime = 0;
function normalizeLadderRank(data, defaultScore = DEFAULT_PVP_SCORE, defaultPvpPower = 0) {
  const extraData = JSON.parseSafe(data.team_extra_data);
  const pvpPower = Number(data.player_extra_data?.[data.team_id]?.extra_data.pvp_power);
  return {
    accountID: data.team_id,
    rank: data.rank,
    score: toFiniteNumber(extraData?.score, defaultScore),
    pvpPower: Number.isFinite(pvpPower) ? pvpPower : defaultPvpPower
  };
}
function LadderButton(props) {
  const [local, others] = libs.splitProps(props, ["class", "children"]);
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps$1(others, {
    get ["class"]() {
      return libs.classNames("LadderButton", local.class);
    },
    get children() {
      return [libs.createElement("Image", {
        "class": "LadderButtonIcon"
      }, null), (() => {
        const _el$2 = libs.createElement("Panel", {
            "class": "LadderButtonContent"
          }, null),
          _el$3 = libs.createElement("Label", {
            "class": "LadderButtonLabel",
            get text() {
              return props.labelText ?? "";
            }
          }, _el$2);
        libs.effect(_$p => libs.setProp(_el$3, "text", props.labelText ?? "", _$p));
        return _el$2;
      })(), libs.memo(() => local.children)];
    }
  }));
}
function PlayerAvatar(props) {
  const accountID = () => props.accountID ?? "0";
  return (() => {
    const _el$4 = libs.createElement("Panel", {
      "class": "PlayerAvatar"
    }, null);
    libs.insert(_el$4, libs.createComponent(Player.AvatarBorder, {
      borderid: "1710000",
      get children() {
        return [libs.createComponent(Player.EOM_Avatar, {
          "class": "Avatar",
          get accountid() {
            return accountID();
          }
        }), (() => {
          const _el$5 = libs.createElement("Panel", {
            "class": "TipsArea"
          }, null);
          libs.effect(_$p => libs.setProp(_el$5, "customTooltip", accountID() === "0" ? undefined : {
            name: "player_info",
            steam_id: accountID()
          }, _$p));
          return _el$5;
        })()];
      }
    }));
    return _el$4;
  })();
}
function LadderChartScore(props) {
  return (() => {
    const _el$6 = libs.createElement("Panel", {
        "class": "LadderChartScore"
      }, null);
      libs.createElement("Image", {
        "class": "ChartScoreBadge"
      }, _el$6);
      const _el$8 = libs.createElement("Label", {
        "class": "ChartScoreValue",
        get text() {
          return `${props.score ?? 0}`;
        }
      }, _el$6);
    libs.effect(_$p => libs.setProp(_el$8, "text", `${props.score ?? 0}`, _$p));
    return _el$6;
  })();
}
function LadderLobbyBigChartItem(props) {
  const [local, others] = libs.splitProps(props, ["class", "rankData"]);
  return (() => {
    const _el$9 = libs.createElement("Panel", libs.mergeProps$1(others, {
        get ["class"]() {
          return libs.classNames("LadderLobbyBigChartItem", local.class);
        }
      }), null);
      libs.createElement("Image", {
        "class": "LadderLobbyBigChartItemBG"
      }, _el$9);
      const _el$1 = libs.createElement("Panel", {
        "class": "LadderLobbyBigChartItemContent"
      }, _el$9),
      _el$10 = libs.createElement("Panel", {
        "class": "ChartPlayerName"
      }, _el$1);
      libs.createElement("Image", {
        "class": "ChartPlayerNameBG"
      }, _el$10);
      const _el$12 = libs.createElement("Panel", {
        "class": "LadderLobbyBigChartScoreContent"
      }, _el$1);
      libs.createElement("Image", {
        "class": "LadderLobbyBigChartScoreBG"
      }, _el$12);
    libs.spread(_el$9, libs.mergeProps$1(others, {
      get ["class"]() {
        return libs.classNames("LadderLobbyBigChartItem", local.class);
      }
    }), true);
    libs.insert(_el$1, libs.createComponent(PlayerAvatar, {
      get accountID() {
        return local.rankData?.accountID;
      }
    }), _el$10);
    libs.insert(_el$10, libs.createComponent(libs.Show, {
      get when() {
        return local.rankData !== undefined;
      },
      get fallback() {
        return libs.createElement("Label", {
          text: "-"
        }, null);
      },
      get children() {
        return libs.createComponent(Player.PlayerName, {
          get accountid() {
            return local.rankData?.accountID;
          }
        });
      }
    }), null);
    libs.insert(_el$12, libs.createComponent(LadderChartScore, {
      get score() {
        return local.rankData?.score;
      }
    }), null);
    return _el$9;
  })();
}
function LadderChartRowHeader() {
  return (() => {
    const _el$15 = libs.createElement("Panel", {
        id: "LadderChartRowHeader"
      }, null),
      _el$16 = libs.createElement("Panel", {
        "class": "LadderChartHeaderCol LadderNumber"
      }, _el$15),
      _el$17 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#LadderChart_LadderNumber");
        }
      }, _el$16),
      _el$18 = libs.createElement("Panel", {
        "class": "LadderChartHeaderCol PlayerInfo"
      }, _el$15),
      _el$19 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#LadderChart_LadderPlayer");
        }
      }, _el$18),
      _el$20 = libs.createElement("Panel", {
        "class": "LadderChartHeaderCol LadderGroup"
      }, _el$15),
      _el$21 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#LadderChart_LadderPower");
        }
      }, _el$20),
      _el$22 = libs.createElement("Panel", {
        "class": "LadderChartHeaderCol LadderScore"
      }, _el$15),
      _el$23 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#LadderChart_LadderScore");
        }
      }, _el$22);
    libs.effect(_p$ => {
      const _v$ = GetLocalization("#LadderChart_LadderNumber"),
        _v$2 = GetLocalization("#LadderChart_LadderPlayer"),
        _v$3 = GetLocalization("#LadderChart_LadderPower"),
        _v$4 = GetLocalization("#LadderChart_LadderScore");
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$17, "text", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$19, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$21, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$23, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$15;
  })();
}
function LadderChartRow(props) {
  const rank = () => props.rankData?.rank ?? 0;
  const hasRank = () => rank() > 0;
  const isTopRank = () => rank() >= 1 && rank() <= 3;
  const accountID = () => props.rankData?.accountID ?? "0";
  return (() => {
    const _el$24 = libs.createElement("Panel", {
        get id() {
          return props.id;
        },
        get ["class"]() {
          return libs.classNames("LadderChartRow", {
            [`Rank${rank()}`]: isTopRank()
          });
        }
      }, null);
      libs.createElement("Image", {
        "class": "LadderChartRowBG"
      }, _el$24);
      const _el$26 = libs.createElement("Panel", {
        "class": "LadderChartRowContent"
      }, _el$24),
      _el$27 = libs.createElement("Panel", {
        "class": "LadderChartRowCol LadderNumber"
      }, _el$26),
      _el$31 = libs.createElement("Panel", {
        "class": "LadderChartRowCol PlayerInfo"
      }, _el$26),
      _el$32 = libs.createElement("Panel", {
        "class": "LadderChartRowCol LadderGroup"
      }, _el$26),
      _el$33 = libs.createElement("Label", {
        "class": "LadderChartGroupValue",
        get text() {
          return FormatNumber(props.rankData?.pvpPower ?? 0);
        }
      }, _el$32),
      _el$34 = libs.createElement("Panel", {
        "class": "LadderChartRowCol LadderScore"
      }, _el$26);
    libs.insert(_el$27, libs.createComponent(libs.Show, {
      get when() {
        return hasRank();
      },
      get fallback() {
        return (() => {
          const _el$35 = libs.createElement("Panel", {
              "class": "LadderChartRowRankNoRank"
            }, null),
            _el$36 = libs.createElement("Label", {
              get text() {
                return GetLocalization("#LadderLobby_ChartNoRank");
              }
            }, _el$35);
          libs.effect(_$p => libs.setProp(_el$36, "text", GetLocalization("#LadderLobby_ChartNoRank"), _$p));
          return _el$35;
        })();
      },
      get children() {
        const _el$28 = libs.createElement("Panel", {
            "class": "LadderChartRowRank"
          }, null);
          libs.createElement("Image", {
            "class": "LadderChartRankBG"
          }, _el$28);
        libs.insert(_el$28, libs.createComponent(libs.Show, {
          get when() {
            return !isTopRank();
          },
          get children() {
            const _el$30 = libs.createElement("Label", {
              "class": "LadderChartRankValue",
              get text() {
                return `${rank()}`;
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$30, "text", `${rank()}`, _$p));
            return _el$30;
          }
        }), null);
        return _el$28;
      }
    }));
    libs.insert(_el$31, libs.createComponent(PlayerAvatar, {
      get accountID() {
        return accountID();
      }
    }), null);
    libs.insert(_el$31, libs.createComponent(libs.Show, {
      get when() {
        return accountID() !== "0";
      },
      get fallback() {
        return libs.createElement("Label", {
          "class": "LadderChartPlayerName",
          text: "-"
        }, null);
      },
      get children() {
        return libs.createComponent(Player.PlayerName, {
          "class": "LadderChartPlayerName",
          get accountid() {
            return accountID();
          }
        });
      }
    }), null);
    libs.insert(_el$34, libs.createComponent(LadderChartScore, {
      get score() {
        return props.rankData?.score;
      }
    }));
    libs.effect(_p$ => {
      const _v$5 = props.id,
        _v$6 = libs.classNames("LadderChartRow", {
          [`Rank${rank()}`]: isTopRank()
        }),
        _v$7 = FormatNumber(props.rankData?.pvpPower ?? 0);
      _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$24, "id", _v$5, _p$._v$5));
      _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$24, "class", _v$6, _p$._v$6));
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$33, "text", _v$7, _p$._v$7));
      return _p$;
    }, {
      _v$5: undefined,
      _v$6: undefined,
      _v$7: undefined
    });
    return _el$24;
  })();
}
function isHeroID(heroID) {
  return heroID > 0;
}
function LadderBattleTeamSlot(props) {
  const [local, others] = libs.splitProps(props, ["class", "heroId", "locked"]);
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps$1({
    "class": "LadderBattleTeamSlot",
    onactivate: () => {
      GameEvents.SendCustomEventToServer("arena_enter_team_editor", {
        kind: "attack"
      });
      ToggleWindow("MenuButton_ladder", false);
    },
    get classList() {
      return {
        Lock: local.locked == true,
        Idle: local.heroId == undefined && local.locked != true
      };
    }
  }, others, {
    get children() {
      return [libs.createElement("Image", {
        "class": "LadderBattleTeamSlotBG"
      }, null), libs.createElement("Image", {
        "class": "LadderBattleTeamSlotAddIcon"
      }, null), libs.createElement("Image", {
        "class": "LadderBattleTeamSlotLockIcon"
      }, null), libs.createComponent(libs.Show, {
        get when() {
          return local.heroId !== undefined;
        },
        get children() {
          return libs.createComponent(EOM_HeroImage.EOM_HeroImage, {
            "class": "LadderBattleTeamSlotHero",
            get heroid() {
              return local.heroId;
            },
            heroimagestyle: "portrait"
          });
        }
      })];
    }
  }));
}
function LadderBattleTeam(props) {
  return (() => {
    const _el$41 = libs.createElement("Panel", {
        "class": "LadderBattleTeam"
      }, null),
      _el$42 = libs.createElement("Panel", {
        "class": "LadderBattleTeamTitle"
      }, _el$41),
      _el$43 = libs.createElement("Label", {
        "class": "LadderBattleTeamTitleLabel",
        get text() {
          return GetLocalization("#LadderLobby_BattleTeamTitle");
        }
      }, _el$42),
      _el$44 = libs.createElement("Label", {
        "class": "LadderBattleTeamBP",
        get text() {
          return LocalizeWithVars("#LadderLobby_BattleTeamTitleBP", {
            bp: props.team?.power ?? 0
          });
        }
      }, _el$42),
      _el$45 = libs.createElement("Panel", {
        "class": "LadderBattleTeamContent"
      }, _el$41);
    libs.insert(_el$45, () => [1, 2, 3, 4].map(slotID => {
      const slot = props.team?.slots.find(item => item.slot === slotID);
      return libs.createComponent(LadderBattleTeamSlot, {
        get enabled() {
          return props.team !== undefined;
        },
        get heroId() {
          return slot !== undefined && isHeroID(slot.hero_id) ? slot.hero_id : undefined;
        }
      });
    }));
    libs.effect(_p$ => {
      const _v$8 = GetLocalization("#LadderLobby_BattleTeamTitle"),
        _v$9 = LocalizeWithVars("#LadderLobby_BattleTeamTitleBP", {
          bp: props.team?.power ?? 0
        });
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$43, "text", _v$8, _p$._v$8));
      _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$44, "text", _v$9, _p$._v$9));
      return _p$;
    }, {
      _v$8: undefined,
      _v$9: undefined
    });
    return _el$41;
  })();
}
function GetCurrentPvpSeasonID() {
  const serverTime = Math.floor(CustomUIConfig.GetServerTimeStamp());
  let seasonID = 1;
  for (let index = 1; index <= 1000; index++) {
    const season = KeyValues.pvp_season[String(index)];
    if (season === undefined) break;
    if (serverTime >= season.start_time) seasonID = season.sid;
  }
  return seasonID;
}
function LadderLobby() {
  const teamData = solid_utils.createPlayerNetDataSignal("arena", "team_setting");
  const pvpRequest = solid_utils.createPlayerNetDataSignal("arena", "pvp_request");
  const playerPvpDatas = solid_utils.createServiceNetData("player_pvp_datas", {});
  const playerCounters = solid_utils.createServiceNetData("player_counters", {});
  const [leaderboardPage, setLeaderboardPage] = libs.createSignal(1);
  const [leaderboardPages, setLeaderboardPages] = libs.createSignal({});
  const [redPointVersion, setRedPointVersion] = libs.createSignal(0);
  const seasonID = GetCurrentPvpSeasonID();
  const currentPvpData = libs.createMemo(() => playerPvpDatas()[String(seasonID)]);
  const attackTeam = libs.createMemo(() => {
    const data = teamData();
    return data?.setting.teams.find(team => team.team_id === data.setting.attack_team);
  });
  const currentLeaderboardData = libs.createMemo(() => leaderboardPages()[leaderboardPage()]);
  const firstLeaderboardData = libs.createMemo(() => leaderboardPages()[1]);
  const leaderboardRanks = libs.createMemo(() => (currentLeaderboardData()?.leaderboard_data ?? []).map(data => normalizeLadderRank(data)));
  const topRanks = libs.createMemo(() => (firstLeaderboardData()?.leaderboard_data ?? []).map(data => normalizeLadderRank(data)));
  const topRank = rank => topRanks().find(data => data.rank === rank);
  const selfRank = libs.createMemo(() => {
    const data = firstLeaderboardData()?.self_data;
    if (data !== undefined) return normalizeLadderRank(data, currentPvpData()?.score ?? DEFAULT_PVP_SCORE, attackTeam()?.power ?? 0);
    return {
      accountID: Steam_64_3(Game.GetLocalPlayerInfo().player_steamid),
      rank: 0,
      score: currentPvpData()?.score ?? DEFAULT_PVP_SCORE,
      pvpPower: attackTeam()?.power ?? 0
    };
  });
  const requestPvpData = (force = false) => {
    const now = CustomUIConfig.GetServerTimeStamp();
    if (!force && now - lastPvpRequestTime < PVP_AUTO_REQUEST_INTERVAL) return;
    lastPvpRequestTime = now;
    GameEvents.SendCustomEventToServer("ladder_request_pvp_data", {
      seasonID
    });
  };
  const pvpLoading = libs.createMemo(() => pvpRequest()?.loading ?? currentPvpData() === undefined);
  const pvpReady = libs.createMemo(() => {
    const request = pvpRequest();
    return request !== undefined && request.seasonID === seasonID && !request.loading && request.error === undefined && currentPvpData() !== undefined;
  });
  const battleButtonText = libs.createMemo(() => pvpLoading() ? GetLocalization("#LadderBattle_ButtonLoading") : pvpReady() ? GetLocalization("#LadderBattle_ButtonBattleStart") : GetLocalization("#LadderBattle_ButtonRetry"));
  const battleHintText = libs.createMemo(() => {
    const error = pvpRequest()?.error;
    if (!pvpLoading() && error === "opponents_empty") return GetLocalization("#LadderBattle_EmptyOpponents");
    if (!pvpLoading() && error !== undefined) return GetLocalization("#LadderBattle_MatchError");
    const totalCount = 5;
    const usedCount = playerCounters()["daily_pvp_play"]?.count ?? 0;
    return LocalizeWithVars("#LadderBattle_BattleCount", {
      allowCount: Math.max(0, totalCount - usedCount),
      totalCount
    });
  });
  const showWeeklyTaskRedPoint = () => {
    redPointVersion();
    return CustomUIConfig.GetRedPoint("ladder", "LadderLobbyButtonStore");
  };
  const requestLeaderboardPage = page => {
    if (leaderboardPages()[page] !== undefined) return;
    CallActionRequest("/v1/leaderboard/fetch", {
      leaderboard_type: "pvp",
      extra_keys: [String(seasonID)],
      start: (page - 1) * LEADERBOARD_PAGE_SIZE + 1,
      end: page * LEADERBOARD_PAGE_SIZE
    }, result => {
      if (result?.code !== 0) return;
      const data = result.data?.leaderboard_datas?.[0];
      if (data !== undefined) setLeaderboardPages(pages => ({
        ...pages,
        [page]: data
      }));
    });
  };
  const changeLeaderboardPage = page => {
    setLeaderboardPage(page);
    requestLeaderboardPage(page);
  };
  libs.onMount(() => {
    const redPointListenerID = CustomUIConfig.SubscribeRedPointChange(() => {
      setRedPointVersion(version => version + 1);
    }, "ladder");
    libs.onCleanup(() => GameEvents.Unsubscribe(redPointListenerID));
    GameEvents.SendCustomEventToServer("ladder_request_team_setting", {});
    requestPvpData();
    requestLeaderboardPage(1);
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "LadderLobby",
    get children() {
      const _el$46 = libs.createElement("Panel", {
          id: "LadderLobbyContent"
        }, null),
        _el$47 = libs.createElement("Panel", {
          id: "LadderLobbyPageBar"
        }, _el$46);
        libs.createElement("Image", {
          "class": "LadderLobbyPageArrorw PageArrorLeft"
        }, _el$47);
        const _el$49 = libs.createElement("Panel", {
          "class": "LadderLobbyPageContent"
        }, _el$47);
        libs.createElement("Image", {
          "class": "LadderLobbyPageBG"
        }, _el$49);
        const _el$51 = libs.createElement("Label", {
          "class": "LadderLobbyPageLabel",
          get text() {
            return GetLocalization("#LadderGroup_Group3");
          }
        }, _el$49);
        libs.createElement("Image", {
          "class": "LadderLobbyPageArrorw PageArrorRight"
        }, _el$47);
        const _el$53 = libs.createElement("Panel", {
          id: "LadderLobbyTopContent"
        }, _el$46),
        _el$54 = libs.createElement("Panel", {
          id: "LadderLobbySessionContent"
        }, _el$53);
        libs.createElement("Image", {
          "class": "LadderLobbySessionBG"
        }, _el$54);
        const _el$56 = libs.createElement("Panel", {
          "class": "LadderLobbySessionInfo"
        }, _el$54),
        _el$57 = libs.createElement("Label", {
          "class": "LadderLobbySessionLabel",
          get text() {
            return GetLocalization("#LadderLobby_SessionLabel");
          }
        }, _el$56),
        _el$58 = libs.createElement("Label", {
          "class": "LadderLobbySessionValue",
          get text() {
            return GetLocalization("#LadderGroup_Group3");
          }
        }, _el$56),
        _el$59 = libs.createElement("Panel", {
          id: "LadderLobbyBigChart"
        }, _el$53),
        _el$60 = libs.createElement("Panel", {
          id: "LadderLobbyTopOptionContent"
        }, _el$53),
        _el$61 = libs.createElement("Panel", {
          id: "LadderLobbyChart"
        }, _el$46);
        libs.createElement("Image", {
          id: "LadderLobbyChartBG"
        }, _el$61);
        const _el$63 = libs.createElement("Panel", {
          id: "LadderChartPanel"
        }, _el$61),
        _el$64 = libs.createElement("Panel", {
          "class": "ChartListVerticalScroll VerticalScrollStyle"
        }, _el$63),
        _el$65 = libs.createElement("Panel", {
          id: "LadderRankPagination"
        }, _el$46),
        _el$66 = libs.createElement("Panel", {
          id: "LadderLobbyBottomContent"
        }, _el$46),
        _el$67 = libs.createElement("Panel", {
          "class": "LadderBattleButtonContent"
        }, _el$66),
        _el$68 = libs.createElement("Label", {
          "class": "LadderBattleCount",
          get text() {
            return battleHintText();
          }
        }, _el$67),
        _el$71 = libs.createElement("Panel", {
          "class": "LadderBottomOptions"
        }, _el$66);
      libs.insert(_el$59, libs.createComponent(LadderLobbyBigChartItem, {
        "class": "Rank2",
        get rankData() {
          return topRank(2);
        }
      }), null);
      libs.insert(_el$59, libs.createComponent(LadderLobbyBigChartItem, {
        "class": "Rank1",
        get rankData() {
          return topRank(1);
        }
      }), null);
      libs.insert(_el$59, libs.createComponent(LadderLobbyBigChartItem, {
        "class": "Rank3",
        get rankData() {
          return topRank(3);
        }
      }), null);
      libs.insert(_el$60, libs.createComponent(LadderButton, {
        "class": "LadderLobbyButtonGroup",
        get labelText() {
          return GetLocalization("#LadderLobby_ButtonGroupDescription");
        },
        onactivate: () => {
          ShowPopup("CommonConfirm", {
            title: GetLocalization("#LadderGroupDescription_Title"),
            text: GetLocalization("#LadderGroupDescription_Text"),
            showCancel: false
          });
        }
      }), null);
      libs.insert(_el$60, libs.createComponent(LadderButton, {
        "class": "LadderLobbyButtonLadderRewards",
        onactivate: () => {
          ShowPopup("PvpReward", {
            seasonID
          });
        },
        get labelText() {
          return GetLocalization("#LadderLobby_ButtonLadderRewards");
        }
      }), null);
      libs.insert(_el$63, libs.createComponent(LadderChartRowHeader, {}), _el$64);
      libs.insert(_el$64, libs.createComponent(libs.For, {
        get each() {
          return leaderboardRanks();
        },
        children: rankData => libs.createComponent(LadderChartRow, {
          rankData: rankData
        })
      }));
      libs.insert(_el$63, libs.createComponent(LadderChartRow, {
        id: "LadderChartSelfRow",
        get rankData() {
          return selfRank();
        }
      }), null);
      libs.insert(_el$65, libs.createComponent(common_match_leaderboard.PageControl, {
        get page() {
          return leaderboardPage();
        },
        setPage: changeLeaderboardPage,
        pageCount: LEADERBOARD_MAX_PAGE
      }));
      libs.insert(_el$66, libs.createComponent(LadderBattleTeam, {
        get team() {
          return attackTeam();
        }
      }), _el$67);
      libs.insert(_el$67, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "LadderBattleButton",
        get enabled() {
          return !pvpLoading();
        },
        onactivate: () => {
          if (!pvpReady()) {
            requestPvpData(true);
            return;
          }
          GameEvents.SendCustomEventToServer("arena_enter", {});
          ToggleWindow("MenuButton_ladder", false);
        },
        get children() {
          return [libs.createElement("Image", {
            "class": "LadderBattleButtonBG"
          }, null), (() => {
            const _el$70 = libs.createElement("Label", {
              "class": "LadderBattleButtonLabel",
              get text() {
                return battleButtonText();
              }
            }, null);
            libs.effect(_$p => libs.setProp(_el$70, "text", battleButtonText(), _$p));
            return _el$70;
          })()];
        }
      }), null);
      libs.insert(_el$71, libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "LadderButton LadderLobbyButtonDefense",
        get enabled() {
          return teamData() !== undefined;
        },
        onactivate: () => {
          GameEvents.SendCustomEventToServer("arena_enter_team_editor", {
            kind: "defense"
          });
          ToggleWindow("MenuButton_ladder", false);
        },
        get children() {
          return [libs.createElement("Image", {
            "class": "LadderButtonIcon"
          }, null), (() => {
            const _el$73 = libs.createElement("Panel", {
                "class": "LadderButtonContent"
              }, null),
              _el$74 = libs.createElement("Label", {
                "class": "LadderButtonLabel",
                get text() {
                  return GetLocalization("#LadderLobby_ButtonDefensiveTeam");
                }
              }, _el$73);
            libs.effect(_$p => libs.setProp(_el$74, "text", GetLocalization("#LadderLobby_ButtonDefensiveTeam"), _$p));
            return _el$73;
          })()];
        }
      }), null);
      libs.insert(_el$71, libs.createComponent(LadderButton, {
        "class": "LadderLobbyButtonRecord",
        onactivate: () => {
          ShowPopup("PvpCombatLog", {
            seasonID
          });
        },
        get labelText() {
          return GetLocalization("#LadderLobby_ButtonBattleRecord");
        }
      }), null);
      libs.insert(_el$71, libs.createComponent(LadderButton, {
        "class": "LadderLobbyButtonStore",
        onactivate: () => ShowPopup("PvpWeeklyTask", {}),
        get labelText() {
          return GetLocalization("#LadderWeekTask");
        },
        get children() {
          return libs.createComponent(libs.Show, {
            get when() {
              return showWeeklyTaskRedPoint();
            },
            get children() {
              return libs.createComponent(EOM_RedMark.EOM_RedMark, {
                align: "right top",
                hittest: false
              });
            }
          });
        }
      }), null);
      libs.effect(_p$ => {
        const _v$0 = GetLocalization("#LadderGroup_Group3"),
          _v$1 = GetLocalization("#LadderLobby_SessionLabel"),
          _v$10 = GetLocalization("#LadderGroup_Group3"),
          _v$11 = battleHintText();
        _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$51, "text", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$57, "text", _v$1, _p$._v$1));
        _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$58, "text", _v$10, _p$._v$10));
        _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$68, "text", _v$11, _p$._v$11));
        return _p$;
      }, {
        _v$0: undefined,
        _v$1: undefined,
        _v$10: undefined,
        _v$11: undefined
      });
      return _el$46;
    }
  });
}

const menuList = {
  ladder: ["ladder_lobby", "pvp_shop"]
};
const {
  LayoutMenu,
  show,
  secondTabName
} = EOM_MenuLayout.createMenuLayout("ladder", () => menuList);
function HUDLadder() {
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    renderOnShow: true,
    id: "HUDLadderRoot",
    get show() {
      return show();
    },
    name: "MenuButton_ladder",
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(Player.CurrencyGroup, {
        currencyType: "top",
        tokens: [110022]
      }), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "ladder_lobby";
            },
            get children() {
              return libs.createComponent(LadderLobby, {});
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return secondTabName() == "pvp_shop";
            },
            get children() {
              return libs.createComponent(StoreTagPage.StoreTagPage, {
                tag: "pvp_shop"
              });
            }
          })];
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(HUDLadder, {}), $.GetContextPanel());