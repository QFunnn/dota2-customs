--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('CosmeticCard', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

const EOM_CountdownWithIcon = props => {
  const [local, other] = libs.splitProps(props, ["children", "endTime", "updateInterval", "text", "onlyCoundown", "limitTime", "short"]);
  let now = () => Math.floor(Date.now() / 1000);
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(other, {
    className: libs.classNames("EOM_CountdonwWithIcon", {
      LowTime: now() > (local.endTime ?? 0) - 24 * 60 * 60
    })
  }), {
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Image", {}, null);
        libs.setProp(_el$, "className", "CountDownIcon");
        return _el$;
      })(), libs.createComponent(EOM_Countdown.EOM_Countdown, local)];
    }
  }));
};

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

$.Language().toLowerCase();
const CosmeticCard = props => {
  const merged = libs.mergeProps$1({
    equip: false,
    preview: false,
    lock: false,
    enableHover: true,
    num: -1
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "mark", "itemid", "rarity", "equip", "preview", "lock", "hasColoring", "enableHover", "num", "slot"]);
  const resolved = libs.children(() => local.children);
  libs.createMemo(() => {
    return local.slot?.toString() ?? local.itemid.slice(1, 3);
  });
  const rarity = () => {
    if (local.rarity == undefined) {
      return KeyValues.CosmeticsKv[local.itemid]?.rarity ?? 0;
    }
    return local.rarity;
  };
  const mark = () => {
    if (local.mark == undefined) {
      return KeyValues.CosmeticsKv[local.itemid]?.mark;
    }
    return local.mark;
  };
  const hasColoring = () => {
    if (local.hasColoring == undefined) {
      return KeyValues.CosmeticColoringList[local.itemid] != undefined;
    }
    return local.hasColoring;
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("CosmeticCard", "Rarity" + rarity(), {
          enableHover: local.enableHover
        })
      })), null),
      _el$2 = libs.createElement("Panel", {}, _el$),
      _el$6 = libs.createElement("Image", {}, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("CosmeticCard", "Rarity" + rarity(), {
        enableHover: local.enableHover
      })
    })), true);
    libs.setProp(_el$2, "className", "CosmeticCardBG");
    libs.insert(_el$2, libs.createComponent(CosmeticImage, {
      get itemid() {
        return local.itemid;
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return local.lock;
      },
      get children() {
        return libs.createElement("Image", {
          id: "Lock"
        }, null);
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return local.equip;
      },
      get children() {
        return libs.createElement("Panel", {
          id: "Equip"
        }, null);
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(MarkIcon, {
      get mark() {
        return mark();
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(libs.Show, {
      get when() {
        return hasColoring();
      },
      get children() {
        return libs.createElement("Panel", {
          id: "coloring"
        }, null);
      }
    }), null);
    libs.insert(_el$2, libs.createComponent(GenericPanel.CLabel, {
      id: "CosmeticName",
      get text() {
        return "#" + local.itemid;
      }
    }), null);
    libs.setProp(_el$6, "className", "CosmeticCardHover");
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.preview;
      },
      get children() {
        const _el$7 = libs.createElement("Image", {}, null);
        libs.setProp(_el$7, "className", "CosmeticCardPreview");
        return _el$7;
      }
    }), null);
    libs.insert(_el$, libs.createComponent(libs.Show, {
      get when() {
        return local.num >= 0;
      },
      get children() {
        return libs.createComponent(GenericPanel.CLabel, {
          className: "CosmeticCardNum",
          get text() {
            return local.num;
          }
        });
      }
    }), null);
    libs.insert(_el$, resolved, null);
    return _el$;
  })();
};
const CosmeticImage = props => {
  const [local, other] = libs.splitProps(props, ["children"]);
  return libs.createComponent(GenericPanel.CImage, libs.mergeProps(() => EOM_Panel.EOMProps(other, {
    className: "CosmeticImage Cosmetic_" + props.itemid
  }), {
    get src() {
      return getCosmeticImagePath(props.itemid.toString());
    },
    scaling: "stretch-to-cover-preserve-aspect"
  }));
};
const HeroCosmeticCard = props => {
  const merged = libs.mergeProps$1({
    equip: false,
    preview: false,
    lock: false
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "mark", "hid", "itemid", "rarity", "equip", "preview", "lock", "hasColoring", "expire"]);
  const heroName = libs.createMemo(() => {
    return GetHeroNameByGoodID(Number(local.hid));
  });
  const resolved = libs.children(() => local.children);
  const rarity = () => {
    if (local.rarity == undefined) {
      return KeyValues.CosmeticsKv[local.itemid]?.rarity ?? 0;
    }
    return local.rarity;
  };
  const mark = () => {
    if (local.mark == undefined) {
      return KeyValues.CosmeticsKv[local.itemid]?.mark;
    }
    return local.mark;
  };
  const hasColoring = () => {
    if (local.hasColoring == undefined) {
      return KeyValues.CosmeticColoringList[local.itemid] != undefined;
    }
    return local.hasColoring;
  };
  return (() => {
    const _el$8 = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others, {
        className: libs.classNames("HeroCosmeticCard", "Rarity" + rarity(), {})
      })), null),
      _el$9 = libs.createElement("Panel", {}, _el$8),
      _el$11 = libs.createElement("Image", {
        hittest: false
      }, _el$8),
      _el$12 = libs.createElement("Image", {
        hittest: false
      }, _el$8);
    libs.spread(_el$8, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
      className: libs.classNames("HeroCosmeticCard", "Rarity" + rarity(), {})
    })), true);
    libs.setProp(_el$9, "className", "HeroCosmeticCardBG");
    libs.insert(_el$9, libs.createComponent(GenericPanel.CImage, {
      className: "HeroCosmeticImage",
      get src() {
        return getCosmeticImagePath(local.itemid);
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return local.lock;
      },
      get children() {
        return libs.createElement("Image", {
          id: "Lock"
        }, null);
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return local.equip;
      },
      get children() {
        return libs.createElement("Panel", {
          id: "Equip"
        }, null);
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(MarkIcon, {
      get mark() {
        return mark();
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return hasColoring();
      },
      get children() {
        return libs.createElement("Panel", {
          id: "coloring"
        }, null);
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(libs.Show, {
      get when() {
        return heroName() != undefined;
      },
      get children() {
        return libs.createComponent(EOM_Label.EOM_Label, {
          id: "HeroName",
          get text() {
            return "#" + heroName();
          }
        });
      }
    }), null);
    libs.insert(_el$9, libs.createComponent(GenericPanel.CLabel, {
      id: "CosmeticName",
      get text() {
        return "#" + local.itemid;
      }
    }), null);
    libs.setProp(_el$11, "className", "HeroCosmeticCardFrame");
    libs.setProp(_el$12, "className", "HeroCosmeticCardHover");
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return local.preview;
      },
      get children() {
        const _el$13 = libs.createElement("Image", {
          hittest: false
        }, null);
        libs.setProp(_el$13, "className", "HeroCosmeticCardPreview");
        return _el$13;
      }
    }), null);
    libs.insert(_el$8, libs.createComponent(libs.Show, {
      get when() {
        return local.expire != undefined;
      },
      get children() {
        const _el$14 = libs.createElement("Panel", {
            id: "Trial"
          }, null),
          _el$15 = libs.createElement("Panel", {
            id: "TrialTime"
          }, _el$14);
        libs.insert(_el$14, libs.createComponent(GenericPanel.CImage, {
          id: "TrialMark",
          get ["class"]() {
            return $.Language().toLocaleLowerCase();
          }
        }), _el$15);
        libs.insert(_el$15, libs.createComponent(EOM_CountdownWithIcon, {
          id: "HeroRoleCountdown",
          short: true,
          get endTime() {
            return Number(local.expire);
          }
        }));
        return _el$14;
      }
    }), null);
    libs.insert(_el$8, resolved, null);
    return _el$8;
  })();
};

exports.CosmeticCard = CosmeticCard;
exports.CosmeticImage = CosmeticImage;
exports.EOM_CountdownWithIcon = EOM_CountdownWithIcon;
exports.HeroCosmeticCard = HeroCosmeticCard;
exports.MarkIcon = MarkIcon;