--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('upgrade_box', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var hotkey_label = require('./hotkey_label.js');
var upgrade_icon = require('./upgrade_icon.js');

const UpgradeBox = props => {
  const merged = libs.mergeProps(props, {
    class: libs.classNames("UpgradeBox", props.class)
  });
  const [local, others] = libs.splitProps(merged, ["upgradeID"]);
  const kv = libs.createMemo(() => KeyValues.ability_upgrades[local.upgradeID] ?? KeyValues.ability_upgrades_service[local.upgradeID] ?? {});
  return (() => {
    const _el$ = libs.createElement("Panel", others, null),
      _el$2 = libs.createElement("Panel", {
        "class": "UpgradeInfo"
      }, _el$),
      _el$3 = libs.createElement("Label", {
        "class": "UpgradeName",
        html: true,
        get text() {
          return `#${local.upgradeID}`;
        }
      }, _el$2);
    libs.spread(_el$, others, true);
    libs.insert(_el$, libs.createComponent(upgrade_icon.UpgradeIcon, {
      get upgradeID() {
        return local.upgradeID;
      },
      size: "large"
    }), _el$2);
    libs.insert(_el$2, libs.createComponent(hotkey_label.HotkeyLabel, {
      "class": "UpgradeDescription",
      html: true,
      get text() {
        return getKeyValueDescription(GetLocalization(`#${local.upgradeID}_description`), kv().AbilityValues ?? {});
      }
    }), null);
    libs.insert(_el$, () => props.children, null);
    libs.effect(_$p => libs.setProp(_el$3, "text", `#${local.upgradeID}`, _$p));
    return _el$;
  })();
};

exports.UpgradeBox = UpgradeBox;