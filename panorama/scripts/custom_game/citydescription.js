--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('CityDescription', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

function updateDescriptionTooltip(abilityName, p) {
  if (!p?.IsValid()) return;
  let sStr = $.Localize("#DOTA_Tooltip_ability_" + abilityName + "_description");
  let infoList = sStr.match(/{Info:(\w+?)}/g);
  const childrens = p.Children();
  for (let index = 0; index < childrens.length; index++) {
    const child = childrens[index];
    if (infoList && infoList[index]) {
      const name = infoList[index].replace(/{Info:(\w+?)}/g, "$1");
      child.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowTitleTextTooltip", p, "#" + name, replaceBuffEnum($.Localize("#" + name + "_description")));
      });
      child.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideTitleTextTooltip", p);
      });
    }
  }
}
const CityDescription = props => {
  const merged = libs.mergeProps$1({
    level: 1
  }, props);
  const [local, others] = libs.splitProps(merged, ["abilityName", "level", "entityIndex", "children"]);
  const text = () => {
    return getCityDescription(local.abilityName, local.level, local.entityIndex);
  };
  let ref;
  libs.createEffect(() => {
    updateDescriptionTooltip(local.abilityName, ref);
  });
  return libs.createComponent(GenericPanel.CLabel, libs.mergeProps({
    html: true
  }, () => EOM_Panel.EOMProps(others), {
    ref(r$) {
      const _ref$ = ref;
      typeof _ref$ === "function" ? _ref$(r$) : ref = r$;
    },
    get text() {
      return text();
    },
    onload: self => {
      updateDescriptionTooltip(local.abilityName, self);
    }
  }));
};

exports.CityDescription = CityDescription;