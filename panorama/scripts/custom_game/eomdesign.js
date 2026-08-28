--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('EOMDesign', exports); const require = GameUI.__require;

var libs = require('./libs.js');

const ADDON_NAME = "C4";
const SUPPORT_CSS_LIST = ["flowChildren", "width", "height", "tooltipPosition", "verticalAlign", "horizontalAlign", "align", "margin", "marginTop", "marginLeft", "marginBottom", "marginRight", "padding", "paddingTop", "paddingLeft", "paddingBottom", "paddingRight", "overflow", "backgroundImage", "backgroundSize", "backgroundColor", "washColor", "opacity", "opacity", "x", "y", "zIndex", "fontSize", "fontFamily", "textShadow", "textDecoration", "color", "scroll", "style"];
function EOMProps(props, defaultProps = {}) {
  const [css, others] = libs.splitProps(props, SUPPORT_CSS_LIST);
  const [combine, final] = libs.splitProps(others, ["className", "customTooltip", "tooltip", "titleTooltip"]);
  if (css.scroll != undefined) {
    css.overflow = getOverflow(css.scroll);
    delete css.scroll;
  }
  const [htmlStyle, htmlCss] = libs.splitProps(css, ["style"]);
  let style = {
    style: htmlCss
  };
  if (htmlStyle.style != undefined) {
    style.style = Object.assign(style.style, {
      ...htmlStyle.style
    });
  }
  defaultProps.style = Object.assign(Object.fromEntries(Object.entries(defaultProps.style ?? {}).filter(([key, value]) => value !== undefined)), style.style ?? {});
  defaultProps.className = libs.classNames(defaultProps.className ?? "", props.className ?? "");
  if (combine.customTooltip != undefined) {
    defaultProps.custom_tooltip = [props.customTooltip.name, `file://{resources}/layout/custom_game/${props.customTooltip.name}.xml`];
    defaultProps.custom_tooltip_params = props.customTooltip;
  }
  if (combine.tooltip != undefined) {
    defaultProps.tooltip_text = combine.tooltip;
  }
  return libs.mergeProps(defaultProps, final);
}
function getOverflow(scroll) {
  if (scroll === "x") {
    return "scroll squish";
  } else if (scroll === "y") {
    return "squish scroll";
  } else if (scroll === "both") {
    return "scroll scroll";
  } else if (scroll === "none" || Array.isArray(scroll) && scroll[0] === "none" && scroll[1] === "none") {
    return "squish squish";
  }
}

exports.ADDON_NAME = ADDON_NAME;
exports.EOMProps = EOMProps;