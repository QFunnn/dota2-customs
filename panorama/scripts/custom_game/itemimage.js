--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ItemImage', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Panel = require('./EOM_Panel.js');

const ItemImage = props => {
  let merged = libs.mergeProps$1({
    itemName: "",
    itemEntIndex: -1,
    showOverrideWarning: false,
    showtooltip: true,
    itemCharge: -1
  }, props);
  const [local, others] = libs.splitProps(merged, ["children", "itemName", "itemEntIndex", "showtooltip", "itemCharge", "showOverrideWarning"]);
  let itemName = () => {
    if (local.itemEntIndex != undefined && local.itemEntIndex != -1) {
      return Abilities.GetAbilityName(local.itemEntIndex) ?? "";
    }
    return local.itemName;
  };
  const itemLevel = () => GameUI.CustomUIConfig().ItemsKv[itemName()]?.ItemLevel ?? 0;
  const charge = () => {
    if (local.itemCharge == undefined || local.itemCharge == -1) {
      return Items.GetCurrentCharges(local.itemEntIndex) ?? 0;
    }
    return local.itemCharge;
  };
  return (() => {
    const _el$ = libs.createElement("Panel", libs.mergeProps(() => EOM_Panel.EOMProps(others)), null),
      _el$2 = libs.createElement("DOTAItemImage", {
        get itemname() {
          return itemName();
        },
        showtooltip: false
      }, _el$);
    libs.spread(_el$, libs.mergeProps(() => EOM_Panel.EOMProps(others), {
      "onmouseover": self => {
        if (merged.showtooltip) {
          ShowCustomTooltip(self, "equipment", {
            itemname: itemName(),
            showOverrideWarning: merged.showOverrideWarning ? 1 : 0
          });
        }
      },
      "onmouseout": self => {
        if (merged.showtooltip) {
          HideCustomTooltip(self, "equipment");
        }
      }
    }), true);
    libs.setProp(_el$2, "style", {
      width: "100%",
      height: "100%"
    });
    libs.insert(_el$, libs.createComponent(EOM_Image.EOM_Image, {
      width: "100%",
      height: "100%",
      get backgroundImage() {
        return getImagePath("hud/item_border_" + itemLevel() + ".png");
      },
      hittestchildren: false,
      hittest: false,
      get children() {
        return libs.createComponent(libs.Show, {
          get when() {
            return charge() > 0;
          },
          get children() {
            return libs.createComponent(EOM_Label.EOM_Label, {
              align: "right bottom",
              marginRight: "2px",
              fontSize: "15px",
              textShadow: "0px 0px 3px 4 #000000",
              color: "white",
              get text() {
                return charge();
              },
              hittest: false
            });
          }
        });
      }
    }), null);
    libs.effect(_$p => libs.setProp(_el$2, "itemname", itemName(), _$p));
    return _el$;
  })();
};

exports.ItemImage = ItemImage;