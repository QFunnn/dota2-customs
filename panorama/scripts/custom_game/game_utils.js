--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('game_utils', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var netdata_utils = require('./netdata_utils.js');

const GetBattlePassSeason = () => {
  const [value, setValue] = libs.createSignal(CustomNetTables.GetTableValue("common", "constant")?.BATTLEPASS_SEASON ?? -1);
  netdata_utils.createNetTableEffect("common", "constant", v => {
    setValue(v.BATTLEPASS_SEASON);
  });
  return value;
};
const GetGameSeason = () => {
  const [value, setValue] = libs.createSignal(CustomNetTables.GetTableValue("common", "constant")?.GAME_SEASON ?? -1);
  netdata_utils.createNetTableEffect("common", "constant", v => {
    setValue(v.GAME_SEASON);
  });
  return value;
};
const GetPeakArenaKingsData = () => {
  const king_score = netdata_utils.createPlayerNetData("player_kings_score", Players.GetLocalPlayer());
  const season = GetGameSeason();
  const [value, setValue] = libs.createSignal(king_score()?.[season()]?.["9"] ?? {
    season: -1,
    now_kings_score: -1,
    region: "default"
  });
  libs.createEffect(() => {
    setValue(king_score()?.[season()]?.["9"] ?? {
      season: -1,
      now_kings_score: -1,
      region: "default"
    });
  });
  return value;
};
const CreateTeammateSuggestActionSignal = (actionType, duration = 3) => {
  const [value, setValue] = libs.createSignal(undefined);
  let timer;
  libs.onMount(() => {
    let listener = GameEvents.Subscribe("teammate_suggest_action", data => {
      console.log("teammate_suggest_action get00", data);
      if (actionType == data.action) {
        console.log("teammate_suggest_action get11", data.extra_info);
        setValue(data.extra_info ?? "");
        if (timer != undefined) {
          $.CancelScheduled(timer);
          timer = undefined;
        }
        timer = $.Schedule(duration, () => {
          console.log("teammate_suggest_action get22", data);
          setValue(undefined);
        });
      }
    });
    libs.onCleanup(() => {
      if (timer != undefined) {
        $.CancelScheduled(timer);
        timer = undefined;
      }
      GameEvents.Unsubscribe(listener);
    });
  });
  return value;
};

exports.CreateTeammateSuggestActionSignal = CreateTeammateSuggestActionSignal;
exports.GetBattlePassSeason = GetBattlePassSeason;
exports.GetGameSeason = GetGameSeason;
exports.GetPeakArenaKingsData = GetPeakArenaKingsData;