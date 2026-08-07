--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('SectAbility', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const SectAbilityImage = props => {
  const [local, others] = libs.splitProps(props, ["children", "sectAbilityID", "showtooltip"]);
  const abilityUpgradeInfo = () => KeyValues.AbilityUpgradesKv[local.sectAbilityID];
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "SectAbilityImage"
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: "SectAbilityImage"
    })), true);
    libs.insert(_el$, libs.createComponent(EOM_Panel.EOM_Panel, {
      width: "100%",
      height: "100%",
      get children() {
        return [libs.createComponent(GenericPanel.CImage, {
          id: "SectAbilityImage_Image",
          scaling: "stretch",
          get src() {
            return `file://{images}/spellicons/${abilityUpgradeInfo()?.Texture ?? ""}.png`;
          }
        }), libs.memo(() => local.children)];
      }
    }));
    return _el$;
  })();
};

exports.SectAbilityImage = SectAbilityImage;