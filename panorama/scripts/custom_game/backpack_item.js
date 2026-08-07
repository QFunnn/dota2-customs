--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('backpack_item', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Button = require('./EOM_Button.js');
var StoreItemImage = require('./StoreItemImage.js');

const BackpackItem = props => {
  const merged = libs.mergeProps$1({
    type: -1,
    uid: props.id
  }, props);
  const [local, other] = libs.splitProps(merged, ["id", "num", "expire_time", "quality", "usenum", "type"]);
  const icon = libs.createMemo(() => {
    if ($.BImageFileExists("file://{images}/custom_game/backpack_items/" + local.id + ".png")) {
      return "file://{images}/custom_game/backpack_items/" + local.id + ".png";
    }
    return "file://{images}/custom_game/store_items/" + local.id + ".png";
  });
  return libs.createComponent(EOM_Button.EOM_BaseButton, {
    className: "BackPackItemMain",
    onactivate: self => {
      if (other.onclick) {
        other.onclick();
      }
    },
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return local.expire_time && local.expire_time > 0;
        },
        get children() {
          return libs.createComponent(CosmeticCard.EOM_CountdownWithIcon, {
            className: "PropCountdown",
            get endTime() {
              return Number(local.expire_time);
            }
          });
        }
      }), libs.createComponent(StoreItemImage.StoreItemImage, {
        show1Count: true,
        get itemName() {
          return $.Localize("#" + local.id);
        },
        get itemImage() {
          return icon();
        },
        get rarity() {
          return local.quality;
        },
        get itemCount() {
          return local.num;
        }
      })];
    }
  });
};

exports.BackpackItem = BackpackItem;