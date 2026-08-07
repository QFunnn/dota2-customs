--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Loading = require('./EOM_Loading.js');
var EOM_Button = require('./EOM_Button.js');
var Player = require('./Player.js');
require('./service_netdata_helper.js');
require('./solid_utils.js');
require('./EOM_RedMark.js');
require('./EOM_TextEntry.js');

const PAGE_SIZE = 10;
const MAX_PAGE = 10;
const DEFAULT_AVATAR_BORDER_ID = "1710000";
const MIN_REQUEST_INTERVAL_MS = 30 * 1000;
const leaderboardCache = CustomUIConfig.__commonMatchLeaderboardCache ??= {};
const lastRequestTimes = {};
function getLeaderboardKey(leaderboardType, extraKey) {
  return `${leaderboardType}:${extraKey}`;
}
function getLeaderboardPageKey(leaderboardType, extraKey, page) {
  return `${getLeaderboardKey(leaderboardType, extraKey)}:page:${page}`;
}
function safeParseTeamExtraData(data) {
  if (data == undefined || data == "") {
    return {};
  }
  const result = JSON.parseSafe(data);
  if (result == undefined || typeof result != "object") {
    return {};
  }
  return result;
}
function firstFiniteNumber(defaultValue, ...values) {
  for (const value of values) {
    const result = toFiniteNumber(value, NaN);
    if (isFinite(result)) {
      return result;
    }
  }
  return defaultValue;
}
function firstText(defaultValue, ...values) {
  for (const value of values) {
    const text = toString(value);
    if (text != undefined && text != "") {
      return text;
    }
  }
  return defaultValue;
}
function normalizeRankData(data) {
  const teamExtra = safeParseTeamExtraData(data.team_extra_data);
  return {
    ...data,
    teamExtra,
    diff: firstFiniteNumber(0, teamExtra.diff),
    totalTime: firstFiniteNumber(0, teamExtra.total_time)
  };
}
function getDisplayPlayerID(data) {
  const mvpUID = firstText("", data.teamExtra.mvp_uid);
  if (mvpUID != "" && data.player_extra_data?.[mvpUID] != undefined) {
    return mvpUID;
  }
  const playerID = Object.keys(data.player_extra_data ?? {})[0];
  return firstText("", playerID);
}
function getPlayerIDs(data) {
  return Object.keys(data.player_extra_data ?? {});
}
function getPlayerExtraData(data, playerID = getDisplayPlayerID(data)) {
  return data.player_extra_data?.[playerID]?.extra_data;
}
function getPlayerHeroID(data, playerID) {
  return firstFiniteNumber(0, data.teamExtra.player_data?.[playerID]?.hero_id);
}
function getAvatarBorder(extraData) {
  const border = extraData?.border;
  if (border == undefined || border == "" || border == "0") {
    return DEFAULT_AVATAR_BORDER_ID;
  }
  return border;
}
function formatClearTime(totalTime) {
  const totalSeconds = Math.max(0, Math.floor(totalTime));
  const hours = Math.floor(totalSeconds / 3600);
  const minutes = Math.floor(totalSeconds % 3600 / 60);
  const seconds = totalSeconds % 60;
  if (hours > 0) {
    return `${hours}:${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`;
  }
  return `${String(minutes).padStart(2, "0")}:${String(seconds).padStart(2, "0")}`;
}
function openPlayerInfo(rankData, playerID, self = false) {
  const playerExtraData = getPlayerExtraData(rankData, playerID);
  if (playerID == "" || playerExtraData?.invalid_name == "1" || playerExtraData?.is_robot == "1") {
    return;
  }
  const localAccountID = Steam_64_3(Game.GetLocalPlayerInfo().player_steamid);
  const steamID = self && (getPlayerIDs(rankData).length == 1 || playerID == localAccountID) ? localAccountID : playerID;
  JumpToMenu({
    window_name: "book",
    menu: "PlayerInfo_Menu",
    force: true,
    data: {
      steamID
    }
  });
}
function CommonMatchLeaderboard(props) {
  const [page, setPage] = libs.createSignal(1);
  const [loading, setLoading] = libs.createSignal(false);
  const [rankDataCache, setRankDataCache] = libs.createSignal({});
  const getCachedRankData = leaderboardPageKey => rankDataCache()[leaderboardPageKey] ?? leaderboardCache[leaderboardPageKey]?.data;
  const currentLeaderboardPageKey = libs.createMemo(() => getLeaderboardPageKey(props.leaderboardType, props.extraKey, page()));
  const currentRankData = libs.createMemo(() => getCachedRankData(currentLeaderboardPageKey()));
  const firstPageRankData = libs.createMemo(() => {
    const firstPageKey = getLeaderboardPageKey(props.leaderboardType, props.extraKey, 1);
    return getCachedRankData(firstPageKey);
  });
  const displayLeaderboard = libs.createMemo(() => (currentRankData()?.leaderboard ?? []).map(normalizeRankData));
  const topRanks = libs.createMemo(() => (firstPageRankData()?.leaderboard ?? []).map(normalizeRankData).filter(data => data.rank > 0 && data.rank <= 3));
  const listRanks = libs.createMemo(() => {
    const minRank = (page() - 1) * PAGE_SIZE + 1;
    const maxRank = page() * PAGE_SIZE;
    return displayLeaderboard().filter(data => data.rank >= minRank && data.rank <= maxRank);
  });
  const displaySelfRank = libs.createMemo(() => {
    const data = firstPageRankData()?.selfRank;
    return data == undefined ? undefined : normalizeRankData(data);
  });
  let disposed = false;
  let pendingRequestTimer;
  const cancelPendingRequest = () => {
    if (pendingRequestTimer == undefined) return;
    clearTimeout(pendingRequestTimer);
    pendingRequestTimer = undefined;
  };
  const requestRankData = (leaderboardType, extraKey, requestedPage) => {
    const leaderboardPageKey = getLeaderboardPageKey(leaderboardType, extraKey, requestedPage);
    const cached = getCachedRankData(leaderboardPageKey);
    const requestTime = Date.now();
    lastRequestTimes[leaderboardPageKey] = requestTime;
    setLoading(cached == undefined);
    CallActionRequest("/v1/leaderboard/fetch", {
      leaderboard_type: leaderboardType,
      extra_keys: [extraKey],
      start: (requestedPage - 1) * PAGE_SIZE + 1,
      end: requestedPage * PAGE_SIZE
    }, result => {
      const isLatestPageRequest = lastRequestTimes[leaderboardPageKey] == requestTime;
      if (result?.code == 0) {
        const leaderboardDatas = result.data?.leaderboard_datas ?? [];
        const data = leaderboardDatas.find(data => data.leaderboard_data?.length > 0) ?? leaderboardDatas[0];
        const selfData = leaderboardDatas.find(data => data.self_data != undefined)?.self_data;
        const cacheData = {
          leaderboard: data?.leaderboard_data ?? [],
          selfRank: selfData
        };
        if (isLatestPageRequest) {
          leaderboardCache[leaderboardPageKey] = {
            data: cacheData,
            updatedAt: Date.now() / 1000
          };
          if (!disposed) {
            setRankDataCache(cache => ({
              ...cache,
              [leaderboardPageKey]: cacheData
            }));
          }
        }
        const isCurrentPage = !disposed && props.visible && currentLeaderboardPageKey() == leaderboardPageKey;
        if (!isLatestPageRequest || !isCurrentPage) return;
        setLoading(false);
        return;
      }
      if (!isLatestPageRequest || disposed || !props.visible || currentLeaderboardPageKey() != leaderboardPageKey) return;
      setLoading(false);
    });
  };
  const scheduleRankDataRequest = (leaderboardType, extraKey, requestedPage) => {
    cancelPendingRequest();
    const leaderboardPageKey = getLeaderboardPageKey(leaderboardType, extraKey, requestedPage);
    const cached = getCachedRankData(leaderboardPageKey);
    const lastRequestTime = lastRequestTimes[leaderboardPageKey] ?? (leaderboardCache[leaderboardPageKey]?.updatedAt ?? 0) * 1000;
    const delay = Math.max(0, lastRequestTime + MIN_REQUEST_INTERVAL_MS - Date.now());
    if (delay == 0) {
      requestRankData(leaderboardType, extraKey, requestedPage);
      return;
    }
    setLoading(cached == undefined);
    pendingRequestTimer = setTimeout(() => {
      pendingRequestTimer = undefined;
      if (!props.visible || props.leaderboardType != leaderboardType || props.extraKey != extraKey || page() != requestedPage) return;
      requestRankData(leaderboardType, extraKey, requestedPage);
    }, delay);
  };
  let selectedLeaderboard = "";
  libs.createEffect(libs.on([() => props.visible, page, () => props.leaderboardType, () => props.extraKey], ([visible, currentPage, leaderboardType, extraKey]) => {
    cancelPendingRequest();
    setLoading(false);
    const nextLeaderboard = getLeaderboardKey(leaderboardType, extraKey);
    if (selectedLeaderboard != nextLeaderboard) {
      selectedLeaderboard = nextLeaderboard;
      if (currentPage != 1) {
        setPage(1);
        return;
      }
    }
    selectedLeaderboard = nextLeaderboard;
    if (visible && extraKey != "") {
      scheduleRankDataRequest(leaderboardType, extraKey, currentPage);
    }
  }));
  libs.onCleanup(() => {
    disposed = true;
    cancelPendingRequest();
  });
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
    id: "CommonMatchLeaderboard",
    shadow_border: true,
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Panel", {
            id: "RankPanel"
          }, null),
          _el$2 = libs.createElement("Panel", {
            id: "RankTable"
          }, _el$),
          _el$3 = libs.createElement("Panel", {
            id: "RankHeader"
          }, _el$2),
          _el$4 = libs.createElement("Label", {
            "class": "RankCol RankNumber",
            get text() {
              return GetLocalization("#Rank_Rank");
            }
          }, _el$3),
          _el$5 = libs.createElement("Label", {
            "class": "RankCol RankPlayer",
            get text() {
              return GetLocalization("#Rank_Player");
            }
          }, _el$3),
          _el$6 = libs.createElement("Label", {
            "class": "RankCol UseHero",
            get text() {
              return GetLocalization("#Rank_Hero");
            }
          }, _el$3),
          _el$7 = libs.createElement("Label", {
            "class": "RankCol RankGroup",
            get text() {
              return GetLocalization("#Rank_Difficulty");
            }
          }, _el$3),
          _el$8 = libs.createElement("Label", {
            "class": "RankCol RankScore",
            get text() {
              return GetLocalization("#Rank_ClearTime");
            }
          }, _el$3),
          _el$9 = libs.createElement("Panel", {
            "class": "RankListVerticalScroll"
          }, _el$2),
          _el$0 = libs.createElement("Panel", {
            id: "RankList",
            flowChildren: "down",
            scroll: "y"
          }, _el$9);
        libs.insert(_el$, libs.createComponent(TopRankList, {
          get ranks() {
            return topRanks();
          }
        }), _el$2);
        libs.setProp(_el$0, "flowChildren", "down");
        libs.setProp(_el$0, "scroll", "y");
        libs.insert(_el$0, libs.createComponent(EmptyRankList, {
          get visible() {
            return listRanks().length == 0;
          }
        }), null);
        libs.insert(_el$0, libs.createComponent(libs.For, {
          get each() {
            return listRanks();
          },
          children: rank => libs.createComponent(RankRow, {
            rankData: rank
          })
        }), null);
        libs.insert(_el$2, libs.createComponent(libs.Show, {
          get when() {
            return displaySelfRank();
          },
          keyed: true,
          children: rankData => libs.createComponent(RankRow, {
            rankData: rankData,
            self: true
          })
        }), null);
        libs.insert(_el$, libs.createComponent(PageControl, {
          get page() {
            return page();
          },
          setPage: setPage
        }), null);
        libs.effect(_p$ => {
          const _v$ = GetLocalization("#Rank_Rank"),
            _v$2 = GetLocalization("#Rank_Player"),
            _v$3 = GetLocalization("#Rank_Hero"),
            _v$4 = GetLocalization("#Rank_Difficulty"),
            _v$5 = GetLocalization("#Rank_ClearTime"),
            _v$6 = libs.classNames("VerticalScrollStyle", {
              Show: !loading()
            });
          _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$4, "text", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$5, "text", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$6, "text", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$7, "text", _v$4, _p$._v$4));
          _v$5 !== _p$._v$5 && (_p$._v$5 = libs.setProp(_el$8, "text", _v$5, _p$._v$5));
          _v$6 !== _p$._v$6 && (_p$._v$6 = libs.setProp(_el$0, "className", _v$6, _p$._v$6));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined,
          _v$4: undefined,
          _v$5: undefined,
          _v$6: undefined
        });
        return _el$;
      })(), libs.memo(() => libs.memo(() => !!loading())() && libs.createComponent(EOM_Loading.EOM_Loading, {
        align: "center center",
        type: "PointSpin"
      }))];
    }
  });
}
function TopRankList(props) {
  const rankData = rank => props.ranks?.find(data => data.rank == rank);
  return (() => {
    const _el$1 = libs.createElement("Panel", {
      id: "TopRankList"
    }, null);
    libs.insert(_el$1, libs.createComponent(TopRankCard, {
      rank: 2,
      get rankData() {
        return rankData(2);
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(TopRankCard, {
      rank: 1,
      get rankData() {
        return rankData(1);
      }
    }), null);
    libs.insert(_el$1, libs.createComponent(TopRankCard, {
      rank: 3,
      get rankData() {
        return rankData(3);
      }
    }), null);
    return _el$1;
  })();
}
function TopRankCard(props) {
  const playerIDs = libs.createMemo(() => props.rankData == undefined ? [] : getPlayerIDs(props.rankData));
  const isMultiple = libs.createMemo(() => playerIDs().length > 1);
  const playerID = () => firstText("", playerIDs()[0]);
  const nameExtraData = () => props.rankData != undefined ? getPlayerExtraData(props.rankData, playerID()) : undefined;
  const title = () => firstText("", nameExtraData()?.title);
  const invalidName = () => nameExtraData()?.invalid_name == "1";
  const playerName = () => {
    if (props.rankData == undefined) {
      return libs.createElement("Label", {
        "class": "TopRankName",
        text: "-"
      }, null);
    }
    if (invalidName()) {
      return (() => {
        const _el$11 = libs.createElement("Label", {
          "class": "TopRankName",
          get text() {
            return GetLocalization("#Rank_AnonymousPlayer");
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$11, "text", GetLocalization("#Rank_AnonymousPlayer"), _$p));
        return _el$11;
      })();
    }
    return libs.createComponent(Player.PlayerName, {
      "class": "TopRankName",
      get accountid() {
        return playerID();
      }
    });
  };
  return (() => {
    const _el$12 = libs.createElement("Panel", {}, null),
      _el$13 = libs.createElement("Panel", {
        get ["class"]() {
          return libs.classNames("TitleContainer");
        }
      }, _el$12),
      _el$14 = libs.createElement("Panel", {
        "class": "AvatarItemContainer"
      }, _el$12),
      _el$15 = libs.createElement("Panel", {
        "class": "TopRankNameContainer"
      }, _el$12);
      libs.createElement("Panel", {
        "class": "RankBG"
      }, _el$12);
    libs.insert(_el$13, (() => {
      const _c$ = libs.memo(() => title() == "");
      return () => _c$() ? undefined : libs.createComponent(Player.PlayerTitle, {
        "class": "Preview_AVATAR_NAME",
        get titleid() {
          return title();
        }
      });
    })());
    libs.insert(_el$14, libs.createComponent(libs.For, {
      get each() {
        return playerIDs();
      },
      children: playerID => (() => {
        const _el$17 = libs.createElement("Panel", {
          "class": "TopRankAvatarRoot"
        }, null);
        libs.insert(_el$17, libs.createComponent(LeaderboardAvatar, {
          get rankData() {
            return props.rankData;
          },
          playerID: playerID,
          "class": "TopRankAvatar",
          onactivate: () => openPlayerInfo(props.rankData, playerID)
        }));
        return _el$17;
      })()
    }));
    libs.insert(_el$15, libs.createComponent(libs.Show, {
      get when() {
        return props.rankData != undefined;
      },
      get fallback() {
        return libs.createElement("Label", {
          "class": "EmptyRankName",
          text: "#EmptyRankName"
        }, null);
      },
      get children() {
        return playerName();
      }
    }));
    libs.effect(_p$ => {
      const _v$7 = libs.classNames("TopRankCard", "Rank" + props.rank, `PlayerCount${playerIDs().length}`, {
          Multiple: isMultiple()
        }),
        _v$8 = libs.classNames("TitleContainer");
      _v$7 !== _p$._v$7 && (_p$._v$7 = libs.setProp(_el$12, "className", _v$7, _p$._v$7));
      _v$8 !== _p$._v$8 && (_p$._v$8 = libs.setProp(_el$13, "class", _v$8, _p$._v$8));
      return _p$;
    }, {
      _v$7: undefined,
      _v$8: undefined
    });
    return _el$12;
  })();
}
function LeaderboardAvatar(props) {
  const extraData = () => getPlayerExtraData(props.rankData, props.playerID);
  const localAccountID = libs.createMemo(() => Steam_64_3(Game.GetLocalPlayerInfo().player_steamid));
  const accountID = libs.createMemo(() => {
    const isSelfPlayer = props.self && (getPlayerIDs(props.rankData).length == 1 || props.playerID == localAccountID());
    if (isSelfPlayer) {
      return localAccountID();
    }
    if (extraData()?.invalid_avatar == "1" || props.playerID == "") {
      return "0";
    }
    return props.playerID;
  });
  const playerInfoTooltip = libs.createMemo(() => {
    if (accountID() == "0" || extraData()?.invalid_name == "1") {
      return undefined;
    }
    return {
      name: "player_info",
      steam_id: accountID()
    };
  });
  return libs.createComponent(Player.AvatarBorder, {
    get ["class"]() {
      return props.class;
    },
    get borderid() {
      return getAvatarBorder(extraData());
    },
    get children() {
      return [libs.createComponent(Player.EOM_Avatar, {
        id: "Avatar",
        get accountid() {
          return accountID();
        }
      }), (() => {
        const _el$19 = libs.createElement("Panel", {
          "class": "TipsArea",
          width: "100%",
          height: "100%",
          get onactivate() {
            return props.onactivate;
          }
        }, null);
        libs.setProp(_el$19, "width", "100%");
        libs.setProp(_el$19, "height", "100%");
        libs.effect(_p$ => {
          const _v$9 = playerInfoTooltip(),
            _v$0 = props.onactivate;
          _v$9 !== _p$._v$9 && (_p$._v$9 = libs.setProp(_el$19, "customTooltip", _v$9, _p$._v$9));
          _v$0 !== _p$._v$0 && (_p$._v$0 = libs.setProp(_el$19, "onactivate", _v$0, _p$._v$0));
          return _p$;
        }, {
          _v$9: undefined,
          _v$0: undefined
        });
        return _el$19;
      })()];
    }
  });
}
function RankRow(props) {
  const rankData = () => props.rankData;
  const playerIDs = libs.createMemo(() => getPlayerIDs(rankData()));
  const isMultiple = libs.createMemo(() => playerIDs().length > 1);
  const playerID = () => firstText("", playerIDs()[0]);
  const extraData = () => getPlayerExtraData(rankData(), playerID());
  const invalidName = () => extraData()?.invalid_name == "1";
  const hasRank = () => rankData().rank > 0 && playerIDs().length > 0;
  const localAccountID = libs.createMemo(() => Steam_64_3(Game.GetLocalPlayerInfo().player_steamid));
  const nameAccountID = libs.createMemo(() => props.self && (playerIDs().length == 1 || playerID() == localAccountID()) ? localAccountID() : playerID());
  const playerName = () => {
    if (nameAccountID() == "") {
      return libs.createElement("Label", {
        "class": "RankPlayerName",
        text: "-"
      }, null);
    }
    if (invalidName()) {
      return (() => {
        const _el$21 = libs.createElement("Label", {
          "class": "RankPlayerName",
          get text() {
            return GetLocalization("#Rank_AnonymousPlayer");
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$21, "text", GetLocalization("#Rank_AnonymousPlayer"), _$p));
        return _el$21;
      })();
    }
    return libs.createComponent(Player.PlayerName, {
      "class": "RankPlayerName",
      get accountid() {
        return nameAccountID();
      }
    });
  };
  return (() => {
    const _el$22 = libs.createElement("Panel", {}, null),
      _el$23 = libs.createElement("Panel", {
        "class": "RankCol RankNumber"
      }, _el$22),
      _el$24 = libs.createElement("Panel", {
        id: "RankIcon"
      }, _el$23),
      _el$25 = libs.createElement("Panel", {
        "class": "RankCol RankPlayer"
      }, _el$22),
      _el$26 = libs.createElement("Panel", {
        "class": "RankAvatarList"
      }, _el$25),
      _el$27 = libs.createElement("Panel", {
        "class": "RankCol UseHero"
      }, _el$22),
      _el$28 = libs.createElement("Panel", {
        "class": "RankHeroList"
      }, _el$27),
      _el$29 = libs.createElement("Panel", {
        "class": "RankCol RankGroup"
      }, _el$22),
      _el$30 = libs.createElement("Label", {
        get text() {
          return libs.memo(() => rankData().diff > 0)() ? GetLocalization("DiffSelection_DiffName" + rankData().diff) : "-";
        }
      }, _el$29),
      _el$31 = libs.createElement("Panel", {
        "class": "RankCol RankScore"
      }, _el$22),
      _el$32 = libs.createElement("Label", {
        get text() {
          return formatClearTime(rankData().totalTime);
        }
      }, _el$31);
    libs.insert(_el$24, (() => {
      const _c$2 = libs.memo(() => !!(rankData().rank >= 1 && rankData().rank <= 3));
      return () => _c$2() ? undefined : (() => {
        const _el$33 = libs.createElement("Label", {
          get text() {
            return libs.memo(() => !!hasRank())() ? rankData().rank : "-";
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$33, "text", libs.memo(() => !!hasRank())() ? rankData().rank : "-", _$p));
        return _el$33;
      })();
    })());
    libs.insert(_el$26, libs.createComponent(libs.For, {
      get each() {
        return playerIDs();
      },
      children: playerID => (() => {
        const _el$34 = libs.createElement("Panel", {
          "class": "AvatarRoot"
        }, null);
        libs.insert(_el$34, libs.createComponent(LeaderboardAvatar, {
          get rankData() {
            return rankData();
          },
          playerID: playerID,
          "class": "RankAvatar",
          get self() {
            return props.self;
          },
          onactivate: () => openPlayerInfo(rankData(), playerID, props.self)
        }));
        return _el$34;
      })()
    }));
    libs.insert(_el$25, playerName, null);
    libs.insert(_el$28, libs.createComponent(libs.For, {
      get each() {
        return playerIDs().filter(playerID => getPlayerHeroID(rankData(), playerID) > 0);
      },
      children: playerID => (() => {
        const _el$35 = libs.createElement("Image", {
          "class": "RankHeroImage",
          get src() {
            return `s2r://panorama/images/heroes/icons/${GetHeroNameByHeroID(getPlayerHeroID(rankData(), playerID))}_png.vtex`;
          }
        }, null);
        libs.effect(_$p => libs.setProp(_el$35, "src", `s2r://panorama/images/heroes/icons/${GetHeroNameByHeroID(getPlayerHeroID(rankData(), playerID))}_png.vtex`, _$p));
        return _el$35;
      })()
    }));
    libs.effect(_p$ => {
      const _v$1 = libs.classNames("RankRow", "Rank" + rankData().rank, `PlayerCount${playerIDs().length}`, {
          Self: props.self,
          Multiple: isMultiple()
        }),
        _v$10 = libs.memo(() => rankData().diff > 0)() ? GetLocalization("DiffSelection_DiffName" + rankData().diff) : "-",
        _v$11 = formatClearTime(rankData().totalTime);
      _v$1 !== _p$._v$1 && (_p$._v$1 = libs.setProp(_el$22, "className", _v$1, _p$._v$1));
      _v$10 !== _p$._v$10 && (_p$._v$10 = libs.setProp(_el$30, "text", _v$10, _p$._v$10));
      _v$11 !== _p$._v$11 && (_p$._v$11 = libs.setProp(_el$32, "text", _v$11, _p$._v$11));
      return _p$;
    }, {
      _v$1: undefined,
      _v$10: undefined,
      _v$11: undefined
    });
    return _el$22;
  })();
}
function EmptyRankList(props) {
  return (() => {
    const _el$36 = libs.createElement("Panel", {
        id: "EmptyRankList"
      }, null),
      _el$37 = libs.createElement("Label", {
        get text() {
          return GetLocalization("#Rank_Empty");
        }
      }, _el$36);
    libs.effect(_p$ => {
      const _v$12 = props.visible,
        _v$13 = GetLocalization("#Rank_Empty");
      _v$12 !== _p$._v$12 && (_p$._v$12 = libs.setProp(_el$36, "visible", _v$12, _p$._v$12));
      _v$13 !== _p$._v$13 && (_p$._v$13 = libs.setProp(_el$37, "text", _v$13, _p$._v$13));
      return _p$;
    }, {
      _v$12: undefined,
      _v$13: undefined
    });
    return _el$36;
  })();
}
function PageControl(props) {
  return (() => {
    const _el$38 = libs.createElement("Panel", {
        id: "RankPageControl"
      }, null),
      _el$39 = libs.createElement("Panel", {
        "class": "PageContainer"
      }, _el$38);
    libs.insert(_el$38, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get enabled() {
        return props.page > 1;
      },
      onactivate: () => props.setPage(props.page - 1),
      className: "PageLeft"
    }), _el$39);
    libs.insert(_el$39, libs.createComponent(libs.For, {
      each: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
      children: page => libs.createComponent(EOM_Button.EOM_BaseButton, {
        onactivate: () => props.setPage(page),
        get className() {
          return libs.classNames("PageButton", {
            Selected: props.page == page
          });
        },
        get children() {
          const _el$40 = libs.createElement("Label", {
            text: page
          }, null);
          libs.setProp(_el$40, "text", page);
          return _el$40;
        }
      })
    }));
    libs.insert(_el$38, libs.createComponent(EOM_Button.EOM_BaseButton, {
      get enabled() {
        return props.page < MAX_PAGE;
      },
      onactivate: () => props.setPage(props.page + 1),
      className: "PageRight"
    }), null);
    return _el$38;
  })();
}

const heroTabs = Object.entries(GameUI.CustomUIConfig().heroes ?? {}).filter(([, hero]) => hero.IsHero == 1 && hero.HeroID != undefined).map(([heroName, hero]) => ({
  key: heroName,
  heroID: String(hero.HeroID)
}));
const heroTabMap = Object.fromEntries(heroTabs.map(hero => [hero.key, hero]));
const menuList = {
  Rank_CommonMatchHero: heroTabs.map(hero => hero.key)
};
const {
  LayoutMenu,
  show,
  menuName,
  secondTabName
} = EOM_MenuLayout.createMenuLayout("rank", () => menuList);
function Rank() {
  const leaderboardType = libs.createMemo(() => menuName() == "Rank_CommonMatchHero" ? "common_match_hero" : "common_match");
  const extraKey = libs.createMemo(() => {
    const tab = secondTabName();
    if (leaderboardType() == "common_match") {
      return tab.replace("Rank_PlayerNum_", "");
    }
    return heroTabMap[tab]?.heroID ?? "";
  });
  const title = libs.createMemo(() => GetLocalization("#" + menuName()));
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    renderOnShow: true,
    id: "RankMain",
    get show() {
      return show();
    },
    name: "MenuButton_rank",
    get children() {
      return [libs.createComponent(LayoutMenu, {}), libs.createComponent(CommonMatchLeaderboard, {
        get visible() {
          return show();
        },
        get leaderboardType() {
          return leaderboardType();
        },
        get extraKey() {
          return extraKey();
        },
        get title() {
          return title();
        }
      })];
    }
  });
}
libs.render(() => libs.createComponent(Rank, {}), $.GetContextPanel());