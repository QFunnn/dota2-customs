--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('HeroPortrait', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

function createLocalConsoleMessage(event, callback) {
  const command = String(Date.now() / 1000);
  GameEvents.SendEventClientSide("custom_local_console_message", {
    key: command,
    event: event,
    enable: 1
  });
  Game.AddCommand(event + command, (_, data) => {
    data = decodeURIComponent(data.replace(/\+/g, ' '));
    let v = JSON.parseSafe(data);
    callback(v);
  }, "", 1 << 26);
  libs.onCleanup(() => {
    GameEvents.SendEventClientSide("custom_local_console_message", {
      key: command,
      event: event,
      enable: 0
    });
  });
}

const HeroPortrait = props => {
  const merged = libs.mergeProps$1({
    player_id: -1
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "player_id", "model", "unitname", "neutral"]);
  libs.createEffect(libs.on(() => local.neutral, v => {}));
  const unitModel = () => {
    if (local.unitname != undefined) {
      let KV = KeyValues.UnitsKv[local.unitname] ?? KeyValues.CosmeticsKv[local.unitname];
      if (KV) {
        return KV.Model ?? KV.resource ?? local.model;
      }
    }
    return local.model;
  };
  let HUD;
  const HeroPortraitUpdate = () => {
    if (HUD?.IsValid()) {
      HUD.ReloadScene();
    }
  };
  libs.createEffect(libs.on(() => ({
    unitname: local.unitname,
    player_id: local.player_id
  }), () => {
    HeroPortraitUpdate();
  }));
  createLocalConsoleMessage("refresh_hero_portrait", data => {
    let playerID = finiteNumber(Number(data.player_id), -1);
    if (!local.neutral && playerID != -1 && local.player_id == playerID) {
      HeroPortraitUpdate();
    }
  });
  const playerIndex = libs.createMemo(() => {
    if (local.player_id > -1) {
      return getPlayerData(local.player_id, "index") ?? -1;
    }
    return -1;
  });
  const resolved = libs.children(() => local.children);
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "HeroPortrait"
  }), {
    get children() {
      return [libs.createComponent(GenericPanel.DynamicKey, {
        key: unitModel,
        children: unit => (() => {
          const _el$2 = libs.createElement("DOTAScenePanel", {
            hittest: false
          }, null);
          libs.use(self => self.SetUnit(unit, "", true), _el$2);
          libs.setProp(_el$2, "className", "HeroPortraitHUDBG");
          return _el$2;
        })()
      }), libs.createComponent(libs.Show, {
        get when() {
          return !local.neutral;
        },
        get fallback() {
          return (() => {
            const _el$3 = libs.createElement("DOTAScenePanel", {
              get map() {
                return "portraits/" + local.unitname;
              },
              camera: "camera_1",
              light: "portrait_light",
              particleonly: false,
              hittest: false
            }, null);
            libs.use(self => {
              HUD = self;
            }, _el$3);
            libs.setProp(_el$3, "className", "HeroPortraitHUD");
            libs.effect(_$p => libs.setProp(_el$3, "map", "portraits/" + local.unitname, _$p));
            return _el$3;
          })();
        },
        get children() {
          const _el$ = libs.createElement("DOTAScenePanel", {
            get map() {
              return "player_portraits/player_portrait_" + playerIndex();
            },
            camera: "camera_1",
            light: "portrait_light",
            particleonly: false,
            hittest: false
          }, null);
          libs.use(self => {
            HUD = self;
          }, _el$);
          libs.setProp(_el$, "className", "HeroPortraitHUD");
          libs.effect(_$p => libs.setProp(_el$, "map", "player_portraits/player_portrait_" + playerIndex(), _$p));
          return _el$;
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.HeroPortrait = HeroPortrait;
exports.createLocalConsoleMessage = createLocalConsoleMessage;