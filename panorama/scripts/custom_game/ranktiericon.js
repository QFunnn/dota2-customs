--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('RankTierIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var netdata_utils = require('./netdata_utils.js');
var game_utils = require('./game_utils.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const getPlayerRankScore = (season, data) => {
  let rank = -1;
  let rank_score = 0;
  if (data && data[season]) {
    rank_score = data[season].now_rank_score;
    rank = data[season].leaderboard_rank ?? rank;
  }
  return {
    rank,
    rank_score
  };
};
const RankTierIcon = props => {
  const merged = libs.mergeProps$1({
    show_title: false,
    size: "512",
    showtooltip: false,
    player_id: Players.GetLocalPlayer()
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "rank_score", "player_id", "rank", "show_title", "size", "showtooltip"]);
  const playerID = () => local.player_id;
  const enableListener = () => local.rank_score == undefined;
  const gameSeason = game_utils.GetGameSeason();
  const [rankScore, setRankScore] = libs.createSignal(local.rank_score);
  const [rank, setRank] = libs.createSignal(local.rank ?? -1);
  const updateRank = () => {
    if (local.rank == undefined) {
      const rankInfo = getPlayerRankScore(gameSeason(), getServiceNetTable("player_rank_score", playerID()));
      setRank(rankInfo.rank ?? -1);
    } else {
      setRank(local.rank ?? -1);
    }
  };
  libs.createEffect(libs.on(() => local.rank, v => {
    updateRank();
  }));
  const [rankTier, setRankTier] = libs.createSignal(-1);
  const [rankNum, setRankNum] = libs.createSignal(-1);
  netdata_utils.createPlayerServiceNetTableEffect("player_rank_score", (data, _playerID) => {
    if (enableListener() && _playerID == playerID()) {
      const rankInfo = getPlayerRankScore(gameSeason(), data);
      setRankScore(rankInfo.rank_score);
      updateRank();
    }
  }, -1, [gameSeason]);
  libs.createEffect(libs.on(() => local.rank_score, rankScore => {
    if (rankScore != undefined) {
      setRankScore(rankScore);
    }
  }));
  libs.createEffect(libs.on(playerID, _playerID => {
    if (enableListener()) {
      const rankInfo = getPlayerRankScore(gameSeason(), getServiceNetTable("player_rank_score", playerID()));
      setRankScore(rankInfo.rank_score);
      updateRank();
    }
  }));
  libs.createEffect(libs.on(rankScore, rank_score => {
    if (rank_score != undefined) {
      const {
        tier,
        num
      } = getRankInfo(rank_score);
      libs.batch(() => {
        setRankTier(tier);
        setRankNum(num);
      });
    }
  }));
  const Top100Rank = () => {
    let v = -1;
    if (rankTier() == 8 && rank() > 0 && rank() < 100) {
      v = rank();
    }
    return v;
  };
  const RankIconPath = () => {
    let tier = rankTier().toString();
    if (rankTier() <= 0) {
      tier = "1";
    } else if (Top100Rank() != -1) {
      tier = "00";
    } else if (tier.length == 1) {
      tier = "0" + tier;
    }
    return `url("file://{images}/custom_game/ladder/j_rank_icon_${tier}_${local.size}.png")`;
  };
  const RankNumPath = () => {
    let num = rankNum().toString();
    if (rankTier() <= 0) {
      num = "5";
    }
    if (num.length == 1) {
      num = "0" + num;
    }
    return `url("file://{images}/custom_game/ladder/j_rank_num_${num}_${local.size}.png")`;
  };
  const RankTitleText = libs.createMemo(() => {
    let tier = rankTier();
    let num = rankNum();
    if (tier <= 0 || num <= 0) {
      const info = getRankInfo(0);
      tier = info.tier;
      num = info.num;
    }
    if (tier == 8) {
      if (Top100Rank() != -1) {
        return $.Localize(`#RankTitle_0`) + " <font color='gold'>" + Top100Rank() + "</font>";
      }
      return $.Localize(`#RankTitle_${tier}`);
    }
    return $.Localize(`#RankTitle_${tier}`) + num;
  });
  const resolved = libs.children(() => local.children);
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("RankTierIcon", "Size" + local.size, {
        Top100: Top100Rank() != -1
      })
    }), {
      get style() {
        return {
          backgroundImage: RankIconPath()
        };
      }
    }), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("RankTierIcon", "Size" + local.size, {
        Top100: Top100Rank() != -1
      })
    }), {
      get style() {
        return {
          backgroundImage: RankIconPath()
        };
      },
      "onmouseover": self => {
        if (local.showtooltip) {
          $.DispatchEvent("DOTAShowTextTooltip", self, RankTitleText());
        }
      },
      "onmouseout": self => {
        if (local.showtooltip) {
          $.DispatchEvent("DOTAHideTextTooltip", self);
        }
      }
    }), true);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return rankTier() != 8 || Top100Rank() != -1;
      },
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return Top100Rank() != -1;
          },
          get fallback() {
            return (() => {
              const _el$2 = libs.createElement("Panel", {
                get style() {
                  return {
                    backgroundImage: RankNumPath()
                  };
                }
              }, null);
              libs.effect(_p$ => {
                const _v$ = libs.classNames("RankTierLabel"),
                  _v$2 = {
                    backgroundImage: RankNumPath()
                  };
                _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$2, "className", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$2, "style", _v$2, _p$._v$2));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined
              });
              return _el$2;
            })();
          },
          get children() {
            return libs.createComponent(GenericPanel.CLabel, {
              get className() {
                return libs.classNames("RankTierTop100Label");
              },
              get text() {
                return Top100Rank();
              }
            });
          }
        });
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.show_title;
      },
      get children() {
        return libs.createComponent(GenericPanel.CLabel, {
          className: "RankTierTitle",
          get text() {
            return RankTitleText();
          },
          html: true
        });
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.RankTierIcon = RankTierIcon;