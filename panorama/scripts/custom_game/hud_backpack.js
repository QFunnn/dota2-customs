--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var CosmeticPreview = require('./CosmeticPreview.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Label = require('./EOM_Label.js');
var EOM_Button = require('./EOM_Button.js');
var EOM_NumberAdjust = require('./EOM_NumberAdjust.js');
var EOM_MenuLayout = require('./EOM_MenuLayout.js');
var EOM_Separator = require('./EOM_Separator.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
var ProductImage = require('./ProductImage.js');
var ProductItem = require('./ProductItem.js');
var backpack_item = require('./backpack_item.js');
var netdata_utils = require('./netdata_utils.js');
require('./CourierTitle.js');
require('./EOM_PortraitFullBody.js');
require('./WinStreak.js');
require('./Heroes.js');
require('./profile_info.js');
require('./EOM_Icon.js');
require('./MenuMarkIcon.js');
require('./red_point_utils.js');
require('./StoreItemImage.js');

$.Language().toLowerCase();
const BackpackRoot = () => {
  const [show, setShow] = libs.createSignal(false);
  const [tabIndex, setTabIndex] = libs.createSignal(0);
  const menuKeys = ["BackPack_Main"];
  const meunList = {
    BackPack_Main: []
  };
  const initSourceKey = new Set(Object.values(KeyValues.BackpackKv).map(v => v.table));
  const initSourceData = libs.createMemo(() => {
    let res = {};
    initSourceKey.forEach(key => {
      res[key] = {};
    });
    return res;
  });
  const [sourceData, setSourceData] = libs.createSignal(initSourceData(), {
    equals: (a, b) => {
      return false;
    }
  });
  const infoProp = netdata_utils.createNetData("info_prop");
  const [itemList, setItemList] = libs.createSignal([]);
  const [num, setNum] = libs.createSignal(0);
  libs.onMount(() => {
    const eventId = useToggleWindow("MenuButton_backpack", show, setShow);
    libs.onCleanup(() => GameEvents.Unsubscribe(eventId));
  });
  EOM_MenuLayout.useEOM_MenuLayoutData(show, () => {
    const eventIdList = [];
    for (let key of initSourceKey) {
      eventIdList.push(useNetData(key, data => {
        setSourceData(preData => {
          preData[key] = data;
          return preData;
        });
      }, Players.GetLocalPlayer()));
    }
    return () => {
      eventIdList.forEach(id => GameEvents.Unsubscribe(id));
    };
  });
  libs.createEffect(libs.on([sourceData, infoProp], ([_sourceData, _infoProp]) => {
    let list = [];
    const numKeyMap = {
      "player_boxes": "amounts",
      "player_consumables": "amounts",
      "player_token": "num"
    };
    Object.entries(_sourceData).forEach(([key, v]) => {
      if (key != "player_props") {
        Object.entries(v).forEach(([id, value]) => {
          let item = KeyValues.BackpackKv[id];
          if (item) {
            if (!value[numKeyMap[key]] || value[numKeyMap[key]] <= 0) return;
            list.push({
              id: Number(id),
              num: value[numKeyMap[key]] ?? 0,
              ...item
            });
          }
        });
      } else {
        Object.entries(v).forEach(([id, value]) => {
          if (value.expire_time && value.expire_time <= now || value.amounts <= 0) return;
          let item = KeyValues.BackpackKv[String(value.prop_id)];
          if (item) {
            let info;
            if (_infoProp) {
              info = _infoProp[value.prop_id];
            }
            item.type = info?.type ?? item.type ?? 1;
            let params;
            if (info && info.param) {
              params = JSON.parseSafe(info.param);
            }
            if (params) {
              if (params.items) {
                let items = [];
                Object.entries(params.items).forEach(([k, v]) => {
                  items.push({
                    item_id: Number(k),
                    amounts: Number(v)
                  });
                });
                item.items = items;
              }
              if (params.hero_ids) {
                item.hero_ids = params.hero_ids;
              }
              if (item.type == 5 && params.type) {
                if (params.type == "any" && params.items) {
                  item.items = params.items.map(v => ({
                    item_id: v,
                    amounts: 1
                  }));
                } else {
                  item.items = [{
                    item_id: Number(params.type),
                    amounts: 1
                  }];
                }
              }
            }
            let priceMap;
            if (info && info.price) {
              priceMap = JSON.parseSafe(info.price);
            }
            if (priceMap) {
              let token = Object.keys(priceMap)[0];
              if (token) {
                item.sell_token = token;
                item.price = priceMap[token];
              }
            }
            item.onuse = num => {
              if (item.jump) {
                if (item.jump == "draw") {
                  clientSideEvent("switchDrawPool", {
                    pid: item.pool
                  });
                }
                if (item.jump == "activity") {
                  clientSideEvent("switchActivityTag", {
                    id: item.pool
                  });
                }
                ToggleWindows('MenuButton_' + item.jump, true);
                return;
              }
              if (item.direct == 1) {
                let data = {
                  id: value.id,
                  amounts: num,
                  prop_id: value.prop_id,
                  params: []
                };
                if (item.type == 2 && params != undefined && params.type == "any") {
                  if (previewID() != -1) {
                    data.params.push(previewID().toString());
                    callAction("use_prop", data);
                  }
                } else {
                  callAction("use_prop", data);
                }
              }
            };
            if (item.price > 0) {
              item.onsell = num => {
                callAction("sell_prop", {
                  id: value.id,
                  amounts: num,
                  prop_id: value.prop_id
                });
              };
            }
            list.push({
              uid: value.id,
              id: value.prop_id,
              expire_time: value.expire_time,
              num: value.amounts ?? 0,
              ...item
            });
          }
        });
      }
    });
    setItemList(list.sort((a, b) => multiCompare(b.weight - a.weight, b.quality - a.quality, b.id - a.id)));
  }));
  const [selectedId, setSelectedId] = libs.createSignal(-1);
  const selectedItemData = () => {
    let id = selectedId();
    if (id == -1) return;
    return itemList().find(v => v.uid == id);
  };
  const selectedItemMax = libs.createMemo(() => {
    let data = selectedItemData();
    if (!data) return 0;
    if (data.usenum == undefined || data.usenum == 0) {
      return data.num;
    }
    return data.usenum;
  });
  const selectedItemMin = libs.createMemo(() => {
    if (selectedItemMax() == 0) return 0;
    return 1;
  });
  let previewTimer = -1;
  const [previewID, setPreviewID] = libs.createSignal(-1);
  const sellTypeIcon = () => getPayTypeIconPath(1100001);
  libs.createEffect(libs.on(selectedItemData, data => {
    let items = data?.items ?? [];
    for (let i = 0; i < items.length; i++) {
      if (KeyValues.CosmeticsKv[items[i].item_id] != undefined) {
        setPreviewID(items[i].item_id);
        return;
      }
    }
    if (items.length > 0) {
      setPreviewID(items[0].item_id);
    }
  }));
  let now = Math.floor(Date.now() / 1000);
  return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
    renderOnShow: true,
    get show() {
      return show();
    },
    name: "MenuButton_backpack",
    get children() {
      return [libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Menu, {
        menuList: meunList,
        onToggleMenu: (menu, menu2) => {
          if (menu != '') {
            setTabIndex(menuKeys.indexOf(menu));
          }
        },
        menuName: "profile",
        get show() {
          return show();
        },
        get selectedMenu() {
          return menuKeys?.[tabIndex()];
        }
      }), libs.createComponent(libs.For, {
        each: menuKeys,
        children: (tag, index) => {
          return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
            id: tag,
            get show() {
              return tabIndex() == index();
            },
            get children() {
              return (() => {
                switch (tag) {
                  case "BackPack_Main":
                    return [(() => {
                      const _el$ = libs.createElement("Panel", {
                        id: "BackpackMain"
                      }, null);
                      libs.insert(_el$, libs.createComponent(libs.Switch, {
                        get fallback() {
                          return (() => {
                            const _el$10 = libs.createElement("Panel", {
                                id: "empty"
                              }, null);
                              libs.createElement("Panel", {
                                id: "emptyBg"
                              }, _el$10);
                              libs.createElement("Label", {
                                text: "#Backpack_Empty"
                              }, _el$10);
                            return _el$10;
                          })();
                        },
                        get children() {
                          return libs.createComponent(libs.Match, {
                            get when() {
                              return itemList().length > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "Backpack_Itemlist",
                                flowChildren: "right-wrap",
                                width: "100%",
                                height: "100%",
                                scroll: "y",
                                get children() {
                                  return libs.createComponent(libs.For, {
                                    get each() {
                                      return itemList();
                                    },
                                    children: item => {
                                      return libs.createComponent(backpack_item.BackpackItem, libs.mergeProps({
                                        onclick: () => {
                                          switch (item.type) {
                                            case 0:
                                              showPopup("BackpackItem", {
                                                ...item
                                              });
                                              return;
                                            case 1:
                                              showPopup("BackpackItem", {
                                                ...item
                                              });
                                              break;
                                            case 2:
                                              showPopup("BackpackItemUse", {
                                                id: item.id
                                              });
                                              break;
                                            case 3:
                                              showPopup("BackpackItem", {
                                                ...item
                                              });
                                              break;
                                            case 4:
                                              showPopup("BackpackItem", {
                                                ...item
                                              });
                                              break;
                                            case 5:
                                              if (item.items && item.items.length > 1) {
                                                showPopup("BackpackItemUse", {
                                                  id: item.id
                                                });
                                              } else {
                                                setSelectedId(item.uid);
                                              }
                                              break;
                                          }
                                        }
                                      }, item));
                                    }
                                  });
                                }
                              });
                            }
                          });
                        }
                      }));
                      return _el$;
                    })(), (() => {
                      const _el$2 = libs.createElement("Panel", {
                          id: "ExchangePanel"
                        }, null),
                        _el$3 = libs.createElement("Panel", {
                          id: "TopBarBG"
                        }, _el$2),
                        _el$4 = libs.createElement("Panel", {
                          id: "ExchangeContainer"
                        }, _el$2),
                        _el$5 = libs.createElement("Panel", {
                          id: "ExchangeList"
                        }, _el$4),
                        _el$6 = libs.createElement("Panel", {
                          id: "ExchangeContent"
                        }, _el$5),
                        _el$7 = libs.createElement("Panel", {
                          id: "PackName"
                        }, _el$6);
                        libs.createElement("Image", {
                          id: "Divider"
                        }, _el$6);
                        const _el$9 = libs.createElement("Panel", {
                          id: "ExchangePreview"
                        }, _el$4),
                        _el$1 = libs.createElement("Panel", {
                          id: "CosmeticDesc"
                        }, _el$9);
                      libs.insert(_el$3, libs.createComponent(Player.CurrencyGroup, {
                        tokens: ["moonstone", "coin"]
                      }));
                      libs.setProp(_el$5, "onactivate", () => {});
                      libs.insert(_el$5, libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "ExchangeListTitle",
                        get children() {
                          return [libs.createComponent(GenericPanel.CLabel, {
                            id: "ExchangeListTitleLabel",
                            text: "#Popup_BackpackItem_title"
                          }), libs.createComponent(EOM_Button.EOM_CloseButton, {
                            onactivate: () => {
                              setSelectedId(-1);
                            }
                          })];
                        }
                      }), _el$6);
                      libs.insert(_el$7, libs.createComponent(GenericPanel.CLabel, {
                        get text() {
                          return "#" + selectedItemData()?.id;
                        }
                      }));
                      libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
                        id: "PackDesc",
                        get text() {
                          return "#" + selectedItemData()?.id + "_description";
                        }
                      }), null);
                      libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "right",
                        horizontalAlign: "center",
                        get children() {
                          return libs.createComponent(libs.Switch, {
                            get children() {
                              return [libs.createComponent(libs.Match, {
                                get when() {
                                  return (selectedItemData()?.items ?? []).length > 3;
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                                    id: "ArrowLeft",
                                    enabled: false
                                  }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "PackItemList",
                                    width: "700px",
                                    flowChildren: "right",
                                    scroll: "x",
                                    get children() {
                                      return libs.createComponent(libs.Index, {
                                        get each() {
                                          return selectedItemData()?.items ?? [];
                                        },
                                        children: (storeItem, index) => {
                                          const rarity = libs.createMemo(() => {
                                            if (storeItem() && KeyValues.CosmeticsKv[storeItem().item_id]) return KeyValues.CosmeticsKv[storeItem().item_id].rarity;
                                            return 1;
                                          });
                                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                                            get className() {
                                              return libs.classNames("ExchangeItem", {
                                                CanPreview: previewID() != undefined,
                                                Previewing: previewID() != undefined && storeItem().item_id == previewID()
                                              });
                                            },
                                            onmouseover: self => {
                                              previewTimer = $.Schedule(0.3, () => {
                                                previewTimer = -1;
                                                if (previewID() != storeItem().item_id) {
                                                  setPreviewID(storeItem().item_id);
                                                }
                                              });
                                            },
                                            onmouseout: self => {
                                              if (previewTimer != -1) {
                                                $.CancelScheduled(previewTimer);
                                                previewTimer = -1;
                                              }
                                            },
                                            get children() {
                                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                                id: "ProductItemContainer",
                                                get children() {
                                                  return [libs.createComponent(ProductItem.ProductItem, {
                                                    get itemid() {
                                                      return storeItem().item_id;
                                                    },
                                                    get count() {
                                                      return storeItem().amounts;
                                                    },
                                                    get rarity() {
                                                      return rarity();
                                                    }
                                                  }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                                    get itemid() {
                                                      return storeItem().item_id;
                                                    },
                                                    hittest: false,
                                                    verticalAlign: "center"
                                                  }), libs.createElement("Panel", {
                                                    id: "HoverBorder",
                                                    hittest: false
                                                  }, null)];
                                                }
                                              });
                                            }
                                          });
                                        }
                                      });
                                    }
                                  }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                                    id: "ArrowRight",
                                    enabled: false
                                  })];
                                }
                              }), libs.createComponent(libs.Match, {
                                get when() {
                                  return (selectedItemData()?.items ?? []).length <= 3;
                                },
                                get children() {
                                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                                    id: "PackItemList",
                                    horizontalAlign: "center",
                                    flowChildren: "right",
                                    scroll: "x",
                                    get children() {
                                      return libs.createComponent(libs.Index, {
                                        get each() {
                                          return selectedItemData()?.items ?? [];
                                        },
                                        children: (storeItem, index) => {
                                          const rarity = libs.createMemo(() => {
                                            if (storeItem() && KeyValues.CosmeticsKv[storeItem().item_id]) return KeyValues.CosmeticsKv[storeItem().item_id].rarity;
                                            return 1;
                                          });
                                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                                            get className() {
                                              return libs.classNames("ExchangeItem", {
                                                CanPreview: previewID() != undefined,
                                                Previewing: previewID() != undefined && storeItem().item_id == previewID()
                                              });
                                            },
                                            onmouseover: self => {
                                              previewTimer = $.Schedule(0.3, () => {
                                                previewTimer = -1;
                                                if (previewID() != storeItem().item_id) {
                                                  setPreviewID(storeItem().item_id);
                                                }
                                              });
                                            },
                                            onmouseout: self => {
                                              if (previewTimer != -1) {
                                                $.CancelScheduled(previewTimer);
                                                previewTimer = -1;
                                              }
                                            },
                                            get children() {
                                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                                id: "ProductItemContainer",
                                                get children() {
                                                  return [libs.createComponent(ProductItem.ProductItem, {
                                                    get itemid() {
                                                      return storeItem().item_id;
                                                    },
                                                    get count() {
                                                      return storeItem().amounts;
                                                    },
                                                    get rarity() {
                                                      return rarity();
                                                    }
                                                  }), libs.createComponent(CosmeticCard.CosmeticImage, {
                                                    get itemid() {
                                                      return storeItem().item_id;
                                                    },
                                                    hittest: false,
                                                    verticalAlign: "center"
                                                  }), libs.createElement("Panel", {
                                                    id: "HoverBorder",
                                                    hittest: false
                                                  }, null)];
                                                }
                                              });
                                            }
                                          });
                                        }
                                      });
                                    }
                                  });
                                }
                              })];
                            }
                          });
                        }
                      }), null);
                      libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
                        flowChildren: "right",
                        horizontalAlign: "center",
                        marginTop: "50px",
                        get children() {
                          return [libs.createComponent(GenericPanel.CLabel, {
                            className: "CostDescLabel",
                            get text() {
                              return $.Localize("#has_num") + selectedItemData()?.num;
                            }
                          }), libs.createComponent(EOM_Label.EOM_Label, {
                            marginLeft: "160px",
                            className: "CostDescLabel",
                            text: "#use_count"
                          }), libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                            verticalAlign: "center",
                            get value() {
                              return num();
                            },
                            get max() {
                              return selectedItemMax();
                            },
                            get min() {
                              return selectedItemMin();
                            },
                            onvaluechanged: self => {
                              setNum(self.value);
                            },
                            marginLeft: "18px"
                          })];
                        }
                      }), null);
                      libs.insert(_el$6, libs.createComponent(EOM_Panel.EOM_Panel, {
                        width: "fit-children",
                        flowChildren: "right",
                        horizontalAlign: "center",
                        marginTop: "50px",
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return selectedItemData()?.price ?? 0 > 0;
                            },
                            get children() {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                id: "sell",
                                marginRight: "80px",
                                onactivate: () => {
                                  let itemData = selectedItemData();
                                  if (itemData && itemData.onsell) {
                                    itemData.onsell(num());
                                  }
                                },
                                get children() {
                                  return [libs.createComponent(EOM_Panel.EOM_Panel, {
                                    verticalAlign: "center",
                                    flowChildren: "right",
                                    get children() {
                                      return [libs.createComponent(EOM_Image.EOM_Image, {
                                        get src() {
                                          return sellTypeIcon();
                                        },
                                        width: "50px",
                                        height: "50px",
                                        verticalAlign: "center"
                                      }), libs.createComponent(EOM_Label.EOM_Label, {
                                        marginLeft: "-10px",
                                        get text() {
                                          return (selectedItemData()?.price ?? 0) * num();
                                        }
                                      })];
                                    }
                                  }), libs.createComponent(EOM_Label.EOM_Label, {
                                    horizontalAlign: "right",
                                    marginRight: "20px",
                                    text: "#sell"
                                  })];
                                }
                              });
                            }
                          }), libs.createComponent(EOM_Button.EOM_Button, {
                            enabled: true,
                            horizontalAlign: "right",
                            color: "Gold",
                            text: "#use",
                            onactivate: () => {
                              let itemData = selectedItemData();
                              if (itemData && itemData.onuse) {
                                itemData.onuse(num());
                              }
                            }
                          })];
                        }
                      }), null);
                      libs.insert(_el$9, libs.createComponent(libs.Show, {
                        get when() {
                          return selectedItemData()?.expire_time ?? 0 > 0;
                        },
                        get children() {
                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                            get classList() {
                              return {
                                StoreCountdown: true,
                                LowTime: now > (selectedItemData()?.expire_time ?? 0) - 24 * 60 * 60,
                                [$.Language().toLowerCase()]: true
                              };
                            },
                            get children() {
                              return [(() => {
                                const _el$0 = libs.createElement("Image", {}, null);
                                libs.setProp(_el$0, "className", "CountDownIcon");
                                return _el$0;
                              })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                                get endTime() {
                                  return Number(selectedItemData()?.expire_time ?? 0);
                                }
                              })];
                            }
                          });
                        }
                      }), _el$1);
                      libs.insert(_el$9, libs.createComponent(libs.Switch, {
                        get children() {
                          return [libs.createComponent(libs.Match, {
                            get when() {
                              return KeyValues.CosmeticsKv[previewID()] != undefined;
                            },
                            get children() {
                              return libs.createComponent(CosmeticPreview.CosmeticPreview, {
                                get cosmetic_id() {
                                  return previewID();
                                },
                                showPedestal: true,
                                showCourierPedestal: true
                              });
                            }
                          }), libs.createComponent(libs.Match, {
                            get when() {
                              return KeyValues.CosmeticsKv[previewID()] == undefined;
                            },
                            get children() {
                              return [libs.createComponent(CosmeticCard.CosmeticImage, {
                                className: "CosmeticPreviewImage",
                                get itemid() {
                                  return previewID().toString();
                                }
                              }), libs.createComponent(ProductImage.ProductImage, {
                                className: "CosmeticPreviewImage",
                                get itemid() {
                                  return previewID();
                                }
                              })];
                            }
                          })];
                        }
                      }), _el$1);
                      libs.insert(_el$1, libs.createComponent(GenericPanel.CLabel, {
                        id: "CosmeticName",
                        get text() {
                          return '#' + previewID();
                        }
                      }), null);
                      libs.insert(_el$1, libs.createComponent(EOM_Separator.EOM_Separator, {
                        size: "short"
                      }), null);
                      libs.insert(_el$1, libs.createComponent(GenericPanel.CLabel, {
                        id: "CosmeticAccess",
                        get text() {
                          return GetCosmeticAccessDescription(previewID());
                        }
                      }), null);
                      libs.effect(_$p => libs.setProp(_el$2, "className", libs.classNames({
                        Show: selectedId() != -1 && selectedItemData() && (selectedItemData()?.num ?? 0) > 0
                      }), _$p));
                      return _el$2;
                    })()];
                }
              })();
            }
          });
        }
      })];
    }
  });
};
if (!isSpectator()) {
  libs.render(() => libs.createComponent(BackpackRoot, {}), $.GetContextPanel());
}