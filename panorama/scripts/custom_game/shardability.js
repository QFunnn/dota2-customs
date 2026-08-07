--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ShardAbility', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Label = require('./EOM_Label.js');

const ShardAbility = props => {
  const merged = libs.mergeProps$1({
    showTooltip: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "heroName", "unlocked", "entIndex", "showTooltip", "playerID"]);
  const [unlocked, setUnlocked] = libs.createSignal(false);
  let listener;
  const registerListener = playerID => {
    if (listener != undefined) {
      CustomNetTables.UnsubscribeNetTableListener(listener);
      listener = undefined;
    }
    if (playerID != undefined) {
      listener = useNetTableKeyHasDefaultValue("player_data", playerID.toString(), v => {
        setUnlocked(v.shardState == 1);
      });
    }
  };
  libs.createEffect(libs.on(() => local.unlocked, v => {
    setUnlocked(v ?? false);
  }));
  libs.createEffect(libs.on(() => local.playerID, registerListener));
  libs.onCleanup(() => {
    registerListener();
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("ShardAbility", {
      unlocked: unlocked()
    })
  }), {
    get customTooltip() {
      return libs.memo(() => !!local.showTooltip)() ? {
        name: "shard_ability",
        unlocked: unlocked(),
        player_id: local.playerID,
        heroName: local.heroName,
        entIndex: local.entIndex
      } : undefined;
    }
  }));
};
function getShardRelativeDescription(abilityName, relativeAbilityName, level = 1, entIndex, onlyShowNowLevel = false) {
  const abilityKV = GameUI.CustomUIConfig().AbilitiesKv[abilityName];
  let str = $.Localize("#DOTA_Tooltip_ability_" + abilityName + "_" + relativeAbilityName);
  str = replaceInfo(str);
  str = replaceKeyword(str);
  str = replaceAbility(str);
  str = replaceBuffEnum(str);
  str = replaceAbilityValues(str);
  str = getKeyValueDescription(abilityKV?.AbilityValues ?? {}, str, {
    entIndex,
    level,
    onlyShowNowLevel: onlyShowNowLevel
  });
  return str;
}
const ShardRelativeDescription = ({
  abilityName,
  relativeAbilityName,
  entIndex = -1
}) => {
  const level = 1;
  const text = getShardRelativeDescription(abilityName, relativeAbilityName, level, entIndex);
  return libs.createComponent(EOM_Label.EOM_Label, {
    html: true,
    className: "ShardRelativeDescription",
    text: text,
    get customTooltip() {
      return libs.memo(() => !!hasKeyWord($.Localize("#DOTA_Tooltip_ability_" + abilityName + "_" + relativeAbilityName)))() ? {
        name: "keyword_list",
        keyword_list: JSON.stringify(getKeyWordList($.Localize("#DOTA_Tooltip_ability_" + abilityName + "_" + relativeAbilityName)))
      } : undefined;
    },
    onload: self => {
      let sStr = $.Localize("#DOTA_Tooltip_ability_" + abilityName + "_description");
      let infoList = sStr.match(/{Info:(\w+?)}/g);
      const childrens = self.Children();
      for (let index = 0; index < childrens.length; index++) {
        const child = childrens[index];
        if (infoList && infoList[index]) {
          const name = infoList[index].replace(/{Info:(\w+?)}/g, "$1");
          child.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowTitleTextTooltip", self, "#" + name, replaceBuffEnum($.Localize("#" + name + "_description")));
          });
          child.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideTitleTextTooltip", self);
          });
        }
      }
    }
  });
};

exports.ShardAbility = ShardAbility;
exports.ShardRelativeDescription = ShardRelativeDescription;