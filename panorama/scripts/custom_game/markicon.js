--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('MarkIcon', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');

const language = $.Language().toLowerCase();
const MarkIcon = props => {
  const [local, others] = libs.splitProps(props, ["children", "mark"]);
  const resolved = libs.children(() => local.children);
  const markSrc = () => {
    if (props.mark != undefined) {
      let tag = "en";
      if (language == "schinese") {
        tag = "ch";
      }
      let sign = `${props.mark}_${tag}`;
      if (!$.BImageFileExists(`file://{images}/custom_game/cosmetics/marks/${sign}.png`)) {
        if (language == "schinese") {
          if ($.BImageFileExists(`file://{images}/custom_game/cosmetics/marks/${props.mark}_cn.png`)) {
            return getSrcPath(`cosmetics/marks/${props.mark}_cn.png`);
          }
        }
        if (sign == `${props.mark}_ch`) {
          sign = props.mark.toString();
        } else {
          sign = `${props.mark}_ch`;
          if (!$.BImageFileExists(`file://{images}/custom_game/cosmetics/marks/${sign}.png`)) {
            sign = props.mark.toString();
          }
        }
      }
      return getSrcPath(`cosmetics/marks/${sign}.png`);
    }
    return "";
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("MarkIcon")
    })), null);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("MarkIcon")
    })), true);
    libs.insert(_el$, libs.createComponent(GenericPanel.CImage, {
      id: "MarkIconImage",
      get src() {
        return markSrc();
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};

exports.MarkIcon = MarkIcon;