--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('StoreItemImage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var GenericPanel = require('./GenericPanel.js');

const language = $.Language().toLowerCase();
const StoreItemImage = props => {
  const mergerd = libs.mergeProps$1({
    rarity: 0,
    show1Count: false
  }, props);
  const [local, others] = libs.splitProps(mergerd, ["children", "itemName", "rarity", "itemImage", "itemCount", "show1Count", "cosmeticType"]);
  const rarity = () => {
    return finiteNumber(Number(local.rarity), 0) + 1;
  };
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "StoreItemImage"
  }), {
    get children() {
      return [libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("StoreItemBG", "Rarity" + rarity());
        },
        get backgroundImage() {
          return getImagePath(`store/new/store_item_bg_${rarity()}.png`);
        },
        backgroundSize: "100%"
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("StoreItemTitle", "Rarity" + rarity());
        },
        get children() {
          return [libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "left",
            width: "12px",
            height: "100%",
            backgroundSize: "100%",
            get backgroundImage() {
              return getImagePath(`store/new/store_name_bg_l_${rarity()}.png`);
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "center",
            margin: "0px 12px",
            style: {
              minHeight: "28px",
              maxHeight: "40px"
            },
            width: "100%",
            backgroundSize: "100%",
            get backgroundImage() {
              return getImagePath(`store/new/store_name_bg_${rarity()}.png`);
            },
            get children() {
              return libs.createComponent(EOM_Label.EOM_Label, {
                style: {
                  textAlign: "center"
                },
                textOverflow: "shrink",
                get text() {
                  return local.itemName;
                }
              });
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            horizontalAlign: "right",
            width: "12px",
            height: "100%",
            backgroundSize: "100%",
            get backgroundImage() {
              return getImagePath(`store/new/store_name_bg_r_${rarity()}.png`);
            }
          })];
        }
      }), libs.createComponent(GenericPanel.CImage, {
        className: "StoreItemImage_Image",
        get src() {
          return local.itemImage;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.cosmeticType != undefined;
        },
        get children() {
          return libs.createComponent(EOM_Image.EOM_Image, {
            className: "StoreItemImage_Tag",
            get src() {
              return getSrcPath(`store/cosmetic_tag/${local.cosmeticType}_${language == "schinese" ? "ch" : language == "russian" ? "ru" : "en"}.png`);
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.itemCount && local.itemCount > (local.show1Count ? 0 : 1);
        },
        get children() {
          return libs.createComponent(GenericPanel.CLabel, {
            className: "StoreItemCount",
            get text() {
              return "×" + local.itemCount;
            }
          });
        }
      })];
    }
  }));
};

exports.StoreItemImage = StoreItemImage;