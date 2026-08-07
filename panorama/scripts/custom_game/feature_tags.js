--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var FeatureTag = require('./FeatureTag.js');
var tooltip_base = require('./tooltip_base.js');

let root = $.GetContextPanel();
function TooltipContents(props) {
  return libs.createComponent(FeatureTag.FeatureTagList, {
    marginLeft: "8px",
    get tags() {
      return props.tags;
    }
  });
}
function SetupTooltip() {
  const tagsText = root.GetAttributeString("tags", "");
  const tags = tagsText === "" ? [] : tagsText.split("|").filter(tag => tag !== "");
  libs.render(() => libs.createComponent(TooltipContents, {
    tags: tags
  }), root);
}
(function () {
  tooltip_base.InitTooltipStyle(root, "EmptyTooltip");
  root.SetPanelEvent("ontooltiploaded", SetupTooltip);
})();