--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var tooltip_base = require('./tooltip_base.js');

const maxStar = 6;
let root = $.GetContextPanel();
function getPrivilegeDescription(privilege, level = 1) {
  const privilegeData = KeyValues.privilege[privilege];
  if (!privilegeData || !privilegeData.AbilityValues) {
    return GetLocalization(`#DOTA_Tooltip_ability_${privilege}`, "");
  }
  const abilityValues = {};
  for (const key in privilegeData.AbilityValues) {
    if (key.startsWith("desc_key")) continue;
    abilityValues[key] = privilegeData.AbilityValues[key];
  }
  const upgradeKeys = privilegeData.AbilityValues["desc_key"] !== undefined ? String(privilegeData.AbilityValues["desc_key"]).split(" ") : [];
  for (const upgradeKey of upgradeKeys) {
    const abilityUpgradeData = KeyValues.ability_upgrades_service[upgradeKey];
    const upgradeValue = abilityUpgradeData?.AbilityValues;
    if (!upgradeValue) continue;
    for (const key in upgradeValue) {
      abilityValues[key] = upgradeValue[key];
    }
  }
  return getKeyValueDescription(GetLocalization(`#DOTA_Tooltip_ability_${privilege}`, ""), abilityValues, {
    level
  });
}
function getWeaponID() {
  return root.GetAttributeString("weapon_id", "") || root.GetAttributeString("item_id", "") || root.GetAttributeString("id", "");
}
function getWeaponName(weaponID) {
  return GetLocalization("#" + weaponID, weaponID);
}
function getWeaponSkillDesc(weaponData) {
  const privilege = weaponData?.weapon_effect;
  if (!privilege) {
    return GetLocalization("#Weapon_NoAbilityEffect", "");
  }
  return getPrivilegeDescription(privilege, maxStar);
}
function getWeaponEffectDescriptions(weaponData) {
  const maxEntries = [];
  const entryIndex = {};
  const privileges = [];
  const privilegeMap = {};
  if (!weaponData) return [];
  for (let i = 1; i <= maxStar; i++) {
    const effectData = weaponData["star_effect" + i];
    for (const [attribute, rawValue] of Object.entries(effectData ?? {})) {
      const value = Number(rawValue);
      if (!Number.isFinite(value)) continue;
      if (entryIndex[attribute] === undefined) {
        entryIndex[attribute] = maxEntries.length;
        maxEntries.push([attribute, value]);
      } else if (value > maxEntries[entryIndex[attribute]][1]) {
        maxEntries[entryIndex[attribute]][1] = value;
      }
    }
    const privilegeData = weaponData["star_privilege" + i];
    if (!privilegeData) continue;
    for (const privilege of privilegeData.split("|").filter(Boolean)) {
      if (privilegeMap[privilege]) continue;
      privilegeMap[privilege] = true;
      privileges.push(privilege);
    }
  }
  const descriptions = maxEntries.map(([attribute, value]) => GetPropertyLocalization(attribute, value));
  for (const privilege of privileges) {
    const desc = getPrivilegeDescription(privilege);
    if (desc) {
      descriptions.push(desc);
    }
  }
  return descriptions;
}
function TooltipContents(props) {
  const weaponData = KeyValues.weapon[props.weaponID];
  const effectDescriptions = getWeaponEffectDescriptions(weaponData);
  return (() => {
    const _el$ = libs.createElement("Panel", {
      id: "WeaponTooltip"
    }, null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      when: weaponData,
      get children() {
        return [(() => {
          const _el$2 = libs.createElement("Label", {
            id: "WeaponTooltipTitle",
            html: true,
            get text() {
              return getWeaponName(props.weaponID);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$2, "text", getWeaponName(props.weaponID), _$p));
          return _el$2;
        })(), (() => {
          const _el$3 = libs.createElement("Label", {
            id: "WeaponTooltipSkillDesc",
            html: true,
            get text() {
              return getWeaponSkillDesc(weaponData);
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$3, "text", getWeaponSkillDesc(weaponData), _$p));
          return _el$3;
        })(), (() => {
          const _el$4 = libs.createElement("Panel", {
            id: "WeaponTooltipEffectList"
          }, null);
          libs.insert(_el$4, libs.createComponent(libs.For, {
            each: effectDescriptions,
            children: desc => (() => {
              const _el$5 = libs.createElement("Label", {
                "class": "WeaponTooltipEffectDesc",
                html: true,
                text: desc
              }, null);
              libs.setProp(_el$5, "text", desc);
              return _el$5;
            })()
          }));
          return _el$4;
        })()];
      }
    }));
    return _el$;
  })();
}
function SetupTooltip() {
  libs.render(() => libs.createComponent(TooltipContents, {
    get weaponID() {
      return getWeaponID();
    }
  }), root);
}
(function () {
  tooltip_base.InitTooltipStyle(root, "BaseTooltip");
  root.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();