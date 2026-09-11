--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var abyss_hud_shared = require('./abyss_hud_shared.js');

const HUDSurvivor = () => {
  const survivorState = abyss_hud_shared.createNullableNetDataSignal("common", "survivor_state");
  const now = abyss_hud_shared.createGameTimeSignal(100);
  const isVisible = libs.createMemo(() => survivorState()?.state === "running");
  const timeLeft = libs.createMemo(() => Math.max(0, (survivorState()?.end_time ?? 0) - now()));
  const timeText = libs.createMemo(() => LocalizeWithVars("#SurvivorHudTime", {
    time: abyss_hud_shared.formatClock(timeLeft())
  }));
  const enemyText = libs.createMemo(() => LocalizeWithVars("#SurvivorHudEnemyCount", {
    count: survivorState()?.alive_enemy_count ?? 0
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "HUDSurvivorRoot",
        get ["class"]() {
          return libs.classNames({
            Show: isVisible()
          });
        },
        hittest: false
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "SurvivorTopCenter",
        hittest: false
      }, _el$),
      _el$3 = libs.createElement("Label", {
        id: "SurvivorHudTitle",
        get text() {
          return GetLocalization("#SurvivorHudTitle");
        }
      }, _el$2),
      _el$4 = libs.createElement("Panel", {
        id: "SurvivorHudStats"
      }, _el$2),
      _el$5 = libs.createElement("Label", {
        id: "SurvivorHudTime",
        get text() {
          return timeText();
        }
      }, _el$4),
      _el$6 = libs.createElement("Label", {
        id: "SurvivorHudEnemyCount",
        get text() {
          return enemyText();
        }
      }, _el$4);
    libs.effect(_p$ => {
      const _v$ = libs.classNames({
          Show: isVisible()
        }),
        _v$2 = GetLocalization("#SurvivorHudTitle"),
        _v$3 = timeText(),
        _v$4 = enemyText();
      _v$ !== _p$._v$ && (_p$._v$ = libs.setProp(_el$, "class", _v$, _p$._v$));
      _v$2 !== _p$._v$2 && (_p$._v$2 = libs.setProp(_el$3, "text", _v$2, _p$._v$2));
      _v$3 !== _p$._v$3 && (_p$._v$3 = libs.setProp(_el$5, "text", _v$3, _p$._v$3));
      _v$4 !== _p$._v$4 && (_p$._v$4 = libs.setProp(_el$6, "text", _v$4, _p$._v$4));
      return _p$;
    }, {
      _v$: undefined,
      _v$2: undefined,
      _v$3: undefined,
      _v$4: undefined
    });
    return _el$;
  })();
};
libs.render(() => libs.createComponent(HUDSurvivor, {}), $.GetContextPanel());