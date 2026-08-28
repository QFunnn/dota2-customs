--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('ExchangeItem', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var ProductItem = require('./ProductItem.js');

function getExchangeItemProps(props) {
  const purchased_num = () => props.purchased_product?.[props.storeItem.id] ?? 0;
  const owned = () => getCosmeticByStoreItem(props.storeItem, props.player_ornament) || getHerobyStoreItem(props.storeItem, props.player_hero);
  const enable = () => !owned() && (props.storeItem.limit_type == 0 || purchased_num() < props.storeItem.limit_count);
  const cosmetic_id = libs.createMemo(() => {
    const current_storeItem = props.storeItem;
    if ((current_storeItem?.items?.length ?? 0) > 0) {
      return current_storeItem.items.find(v => KeyValues.CosmeticsKv?.[v.item_id.toString()] != undefined)?.item_id;
    }
  });
  const cosmeticTag = () => {
    if (cosmetic_id()) {
      return cosmetic_id().toString().slice(0, 3);
    }
  };
  const endTime = () => props.storeItem?.end_time ?? 0;
  return {
    owned: owned(),
    previewing_id: props.previewing_id,
    cosmeticTag: cosmeticTag(),
    enable: enable(),
    storeItem: props.storeItem,
    cosmetic_id: cosmetic_id(),
    purchased_num: purchased_num(),
    endTime: endTime(),
    onPreview: props.onPreview,
    onCancelPreview: props.onCancelPreview,
    OnBuy: () => {
      showPopup("StoreBuyItem", {
        itemData: props.storeItem,
        group: "StoreBuyItem"
      });
    },
    isToolMode: (CustomNetTables.GetTableValue("common", "settings")?.is_in_tools_mode ?? 0) == 1
  };
}
const ExchangeItem = props => {
  const [local, others] = libs.splitProps(props, ["children", "owned", "previewing_id", "onPreview", "endTime", "onCancelPreview", "enable", "storeItem", "cosmetic_id", "isToolMode", "purchased_num", "OnBuy", "cosmeticTag", "markType"]);
  const resolved = libs.children(() => local.children);
  const language = $.Language().toLowerCase();
  const freeRedPoint = libs.createMemo(() => {
    return local.storeItem.status == 1 && local.storeItem.real_price == 0 && !local.owned && local.enable;
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("ExchangeItem", {
      Disabled: local.owned,
      CanPreview: local.cosmetic_id != undefined,
      Previewing: local.cosmetic_id != undefined && local.previewing_id == local.cosmetic_id
    })
  }), {
    onmouseover: self => {
      if (local.onPreview) {
        if (local.cosmetic_id != undefined) {
          local.onPreview(local.cosmetic_id, local.storeItem.id);
        }
      }
    },
    onmouseout: self => {
      if (local.onCancelPreview) {
        local.onCancelPreview();
      }
    },
    get children() {
      return [libs.createComponent(libs.Show, {
        get when() {
          return local.owned;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "Owned"
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ProductItemContainer",
        get children() {
          return [libs.createComponent(ProductItem.ProductItem, {
            get itemid() {
              return local.storeItem.id;
            },
            get count() {
              return local.storeItem.items.length == 1 ? local.storeItem.items[0].amounts : 1;
            },
            get rarity() {
              return local.storeItem.title;
            },
            get children() {
              return [libs.createComponent(libs.Show, {
                get when() {
                  return local.endTime > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    get className() {
                      return libs.classNames("StoreCountdown", $.Language().toLowerCase(), {
                        LowTime: Math.floor(Date.now() / 1000) > local.endTime - 24 * 60 * 60
                      });
                    },
                    get children() {
                      return [(() => {
                        const _el$ = libs.createElement("Image", {}, null);
                        libs.setProp(_el$, "className", "CountDownIcon");
                        return _el$;
                      })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                        get endTime() {
                          return local.endTime;
                        }
                      })];
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return local.storeItem.limit_type > 0;
                },
                get children() {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    className: "StoreLimit",
                    get children() {
                      return libs.createComponent(GenericPanel.CLabel, {
                        className: "LimitLabel",
                        get text() {
                          return $.Localize("#LimitLabel") + ` ${local.purchased_num}/${local.storeItem.limit_count}`;
                        }
                      });
                    }
                  });
                }
              }), libs.createComponent(libs.Show, {
                get when() {
                  return local.cosmeticTag != undefined;
                },
                get children() {
                  return libs.createComponent(EOM_Image.EOM_Image, {
                    className: "ExchangeItemImage_Tag",
                    get src() {
                      return getSrcPath(`store/cosmetic_tag/${local.cosmeticTag}_${language == "schinese" ? "ch" : language == "russian" ? "ru" : "en"}.png`);
                    }
                  });
                }
              })];
            }
          }), libs.createElement("Panel", {
            id: "HoverBorder",
            hittest: false
          }, null)];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.storeItem.real_price > 0;
        },
        get fallback() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "center",
            get enabled() {
              return local.enable;
            },
            color: "Green",
            text: "#Free",
            onactivate: () => {
              if (local.OnBuy) {
                local.OnBuy();
              }
            }
          });
        },
        get children() {
          return libs.createComponent(EOM_Button.EOM_Button, {
            horizontalAlign: "center",
            get enabled() {
              return local.enable;
            },
            color: "Light",
            get text() {
              return local.storeItem.real_price;
            },
            get icon() {
              return libs.createComponent(EOM_Image.EOM_Image, {
                get src() {
                  return getPayTypeIconPath(local.storeItem.pay_type);
                },
                width: "35px",
                height: "35px"
              });
            },
            onactivate: () => {
              if (local.OnBuy) {
                local.OnBuy();
              }
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.isToolMode;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ToolMode",
            get children() {
              return [libs.createComponent(EOM_Label.EOM_Label, {
                align: "center top",
                textShadow: "0 0 2px 2 #000000",
                color: "white",
                get text() {
                  return local.storeItem.id;
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                align: "right top",
                textShadow: "0 0 2px 2 #000000",
                marginRight: "10px",
                color: "red",
                get text() {
                  return local.storeItem.order_by;
                }
              })];
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.markType != undefined || freeRedPoint();
        },
        get children() {
          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
            get type() {
              return local.markType == "new" ? "new_large" : local.markType ?? "default";
            },
            hittest: false
          });
        }
      }), libs.memo(() => resolved())];
    }
  }));
};

exports.ExchangeItem = ExchangeItem;
exports.getExchangeItemProps = getExchangeItemProps;