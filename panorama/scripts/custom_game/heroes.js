--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('Heroes', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');

const HeroImage = props => {
  const merged = libs.mergeProps$1({
    type: "default"
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "type", "hero_name", "oid"]);
  const resolved = libs.children(() => local.children);
  const imagePath = () => {
    let path = "";
    const current_heroName = local.hero_name;
    if (current_heroName) {
      const kv = KeyValues.UnitsCommonKv?.[current_heroName];
      if (kv && typeof kv.Icon == "string") {
        let src = kv.Icon;
        if (local.type == "selection") {
          path = src.replace("/heroes/icons/", "/heroes/selection/");
        } else {
          path = src.replace("/heroes/icons/", "/heroes/");
        }
      }
    }
    if ($.BImageFileExists(path.replace("/heroes/", "/custom_game/heroes/"))) {
      return "url()";
    }
    return `url('${path}')`;
  };
  const CustomHeroPath = () => {
    let path = "";
    const current_heroName = local.hero_name;
    if (local.oid != undefined && isFinite(local.oid)) {
      path = `file://{images}/custom_game/heroes/${local.oid}.png`;
    } else if (current_heroName) {
      const kv = KeyValues.UnitsCommonKv?.[current_heroName];
      if (kv && typeof kv.Icon == "string") {
        let src = kv.Icon;
        src = src.replace("/heroes/icons/", "/custom_game/heroes/icons/");
        if (local.type == "selection") {
          path = src.replace("/heroes/icons/", "/heroes/selection/");
        } else {
          path = src.replace("/heroes/icons/", "/heroes/");
        }
      }
    }
    if ($.BImageFileExists(path)) {
      return `url('${path}')`;
    }
    return "url()";
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("HeroImage", local.type)
  }), {
    get backgroundImage() {
      return imagePath();
    },
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "CustomHeroImage",
        get visible() {
          return local.type == "default";
        },
        get backgroundImage() {
          return CustomHeroPath();
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.HeroImage = HeroImage;