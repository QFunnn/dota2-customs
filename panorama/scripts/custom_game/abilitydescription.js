--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('AbilityDescription', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const AbilityDescription = props => {
  const merged = libs.mergeProps$1({
    level: 1
  }, props);
  const [local, others] = libs.splitProps(merged, ["abilityName", "level", "entityIndex", "onlyShowNowLevel", "children"]);
  const text = libs.createMemo(() => getAbilityDescription(local.abilityName, local.level, local.entityIndex, local.onlyShowNowLevel));
  return libs.createComponent(GenericPanel.CLabel, libs.mergeProps({
    html: true
  }, () => EOM_Panel.EOMProps(others), {
    get text() {
      return text();
    },
    onload: self => {
      let sStr = $.Localize("#DOTA_Tooltip_ability_" + local.abilityName + "_description");
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
  }));
};

exports.AbilityDescription = AbilityDescription;