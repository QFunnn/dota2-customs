--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOM_Portrait', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var GenericPanel = require('./GenericPanel.js');
var EOM_Panel = require('./EOM_Panel.js');

const EOM_Portrait = props => {
  const [local, others] = libs.splitProps(props, ["children", "unitname", "model", "custom_ref"]);
  const resolved = libs.children(() => local.children);
  let HUD;
  const unitModel = () => {
    if (local.unitname != undefined) {
      let KV = KeyValues.UnitsKv[local.unitname] ?? KeyValues.CosmeticsKv[local.unitname];
      if (KV) {
        return KV.Model ?? KV.resource ?? local.model;
      }
    }
    return local.model;
  };
  libs.createEffect(libs.on(() => ({
    unitname: local.unitname,
    model: local.model
  }), () => {
    if (HUD?.IsValid()) {
      HUD.ReloadScene();
    }
  }));
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Portrait"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "EOM_Portrait"
    })), true);
    libs.insert(_el$, () => {
      let unit = unitModel();
      return (() => {
        const _el$3 = libs.createElement("Panel", {}, null);
        libs.setProp(_el$3, "style", {
          width: "100%",
          height: "100%"
        });
        libs.setProp(_el$3, "onload", self => {
          if (unit && unit != "") {
            if (self.GetChildCount() > 0) {
              let child = self.GetChild(0);
              if (child?.IsValid() && typeof child.SetUnit == "function") {
                child.SetUnit(unit, "", true);
              }
            }
          }
        });
        libs.insert(_el$3, libs.createComponent(GenericPanel.CDOTAScenePanel, {
          className: "CustomHeroPortraitHUDBG",
          hittest: false
        }));
        return _el$3;
      })();
    }, null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.unitname != undefined;
      },
      get children() {
        const _el$2 = libs.createElement("DOTAScenePanel", {
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
          if (local.custom_ref) {
            local.custom_ref(self);
          }
        }, _el$2);
        libs.setProp(_el$2, "className", "CustomHeroPortraitHUD");
        libs.effect(_$p => libs.setProp(_el$2, "map", "portraits/" + local.unitname, _$p));
        return _el$2;
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.EOM_Portrait = EOM_Portrait;