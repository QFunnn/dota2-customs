--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('StoreItem', exports); const require = GameUI.__require;

var libs = require('./libs.js');
var EOM_Panel = require('./EOM_Panel.js');
var EOM_Countdown = require('./EOM_Countdown.js');
var EOM_Icon = require('./EOM_Icon.js');
var EOM_Image = require('./EOM_Image.js');
var EOM_Button = require('./EOM_Button.js');
var GenericPanel = require('./GenericPanel.js');
var MenuMarkIcon = require('./MenuMarkIcon.js');
var StoreItemImage = require('./StoreItemImage.js');

function getButtonData(itemData, isStoreUI = false) {
  if (itemData.real_price == 0) {
    return {
      color: "Green",
      text: "#Free"
    };
  }
  const sLanguage = $.Language().toLowerCase();
  if (itemData.pay_type == undefined || itemData.pay_type == PayType.MONEY) {
    let dollarMark = "￥";
    let price = itemData.real_price;
    if (sLanguage == "schinese") {
      dollarMark = "￥";
      price = itemData.real_price;
    } else if (sLanguage == "english") {
      dollarMark = "$";
      price = itemData.overseas_real_price;
    } else if (sLanguage == "russian") {
      dollarMark = "₽";
      price = itemData.russia_real_price;
    }
    return {
      color: "Purple",
      text: dollarMark + price.toFixed(2)
    };
  } else if (itemData.pay_type == PayType.MOON) {
    return {
      color: "Blue",
      text: String(Round(itemData.real_price, 2)),
      icon: libs.createComponent(EOM_Image.EOM_Image, {
        get backgroundImage() {
          return getImagePath("tokens/1000001.png");
        },
        width: isStoreUI ? "40px" : "28px",
        height: isStoreUI ? "40px" : "28px"
      })
    };
  } else if (itemData.pay_type == PayType.STAR) {
    return {
      color: "Purple",
      text: String(Round(itemData.real_price, 2)),
      icon: libs.createComponent(EOM_Image.EOM_Image, {
        get backgroundImage() {
          return getImagePath("money_icon/star.png");
        },
        width: isStoreUI ? "40px" : "20px",
        height: isStoreUI ? "40px" : "20px"
      })
    };
  } else if (itemData.pay_type == PayType.SHARD) {
    return {
      color: "Purple",
      text: String(Round(itemData.real_price, 2)),
      icon: libs.createComponent(EOM_Image.EOM_Image, {
        get backgroundImage() {
          return getImagePath("money_icon/shard.png");
        },
        width: isStoreUI ? "40px" : "20px",
        height: isStoreUI ? "40px" : "20px"
      })
    };
  } else if (Math.floor(itemData.pay_type / 100) == 11001) {
    return {
      color: "Light",
      text: String(Round(itemData.real_price, 2)),
      icon: libs.createComponent(EOM_Image.EOM_Image, {
        get backgroundImage() {
          return getImagePath("tokens/" + itemData.pay_type + ".png");
        },
        width: "60px",
        height: "60px"
      })
    };
  } else if (Math.floor(itemData.pay_type / 10000) == 110) {
    return {
      color: "Light",
      text: String(Round(itemData.real_price, 2)),
      icon: libs.createComponent(EOM_Image.EOM_Image, {
        get backgroundImage() {
          return getImagePath("tokens/" + itemData.pay_type + ".png");
        },
        width: isStoreUI ? "40px" : "28px",
        height: isStoreUI ? "40px" : "28px"
      })
    };
  }
  return {
    color: "Gold",
    text: String(Round(itemData.real_price, 2)),
    icon: libs.createComponent(EOM_Image.EOM_Image, {
      get backgroundImage() {
        return getImagePath("money_icon/shard.png");
      },
      width: isStoreUI ? "40px" : "20px",
      height: isStoreUI ? "40px" : "20px"
    })
  };
}
function getOriginPrice(itemData) {
  if (itemData.pay_type == undefined || itemData.pay_type == PayType.MONEY) {
    const sLanguage = $.Language().toLowerCase();
    let dollarMark = "￥";
    let price = itemData.origin_price;
    if (sLanguage == "schinese") {
      dollarMark = "￥";
      price = itemData.real_price;
    } else if (sLanguage == "english") {
      dollarMark = "$";
      price = itemData.overseas_origin_price;
    } else if (sLanguage == "russian") {
      dollarMark = "₽";
      price = itemData.russia_origin_price;
    }
    return dollarMark + price.toFixed(2);
  } else {
    return String(Round(itemData.origin_price, 2));
  }
}
function getLabels(itemData, token_count) {
  const labels = [];
  if (itemData.discount && itemData.discount > 0) {
    labels.push({
      type: "discount",
      label: `-${itemData.discount}`
    });
  }
  if (itemData.limit_type >= 1 && itemData.limit_count > 0) {
    labels.push({
      type: "limit",
      label: `${itemData.limit_type}|${itemData.purchased_num ?? 0}/${itemData.limit_count}`
    });
  }
  if (Math.floor(itemData.pay_type / 100) == 11001) {
    labels.push({
      type: "skin_debris",
      label: `${token_count ?? 0}`
    });
  }
  return labels;
}
function getTagName(itemData) {
  const isVip = itemData.vip == 1;
  if (isVip) {
    return "vip";
  }
}
const useStoreItem = props => {
  const [local, others] = libs.splitProps(props, ["children", "itemId", "store_id", "checkNewMark", "itemName", "enabled", "owned", "tagName", "rarity", "labels", "itemImage", "itemCount", "button", "end_time", "onBuyItem", "orgin_price", "markType", "onAddToken", "cosmeticType"]);
  const [discount, setDiscount] = libs.createSignal("");
  const [skinDebrisLabel, setSkinDebrisLabel] = libs.createSignal();
  const [label_data, setLabelData] = libs.createSignal([]);
  libs.createEffect(() => {
    if (local.labels != undefined) {
      let arr = local.labels ?? [];
      setLabelData(arr.filter((data, index) => {
        if (data.type == "discount") {
          setDiscount(data.label);
          return false;
        }
        if (data.type == "skin_debris") {
          setSkinDebrisLabel(data.label);
          return false;
        }
      }));
    }
  });
  return {
    local,
    others,
    discount,
    label_data,
    skinDebrisLabel
  };
};
const getStoreItemProps = ({
  itemData,
  purchased_num,
  playerOrnament,
  playerHeroes,
  isStoreUI,
  ignorePreview,
  playerTokens,
  playerVip
}) => {
  const item_data = {
    ...itemData,
    items: itemData.items ?? [],
    purchased_num: itemData?.step_purchased_num ?? purchased_num
  };
  const tagName = getTagName(item_data);
  const owned = getCosmeticByStoreItem(item_data, playerOrnament) || getHerobyStoreItem(item_data, playerHeroes);
  const soldOut = !(item_data.status == 1 && (item_data.limit_type >= 1 ? finiteNumber(Number(item_data.purchased_num)) < item_data.limit_count : true) && !owned);
  const enabled = !soldOut && (tagName == "vip" ? playerVip?.vip_valid == 1 : true);
  const origin_price = getOriginPrice(item_data);
  const labels = getLabels(item_data, playerTokens?.[item_data.pay_type.toString()]?.num ?? 0);
  const cosmeticType = (() => {
    for (const item of item_data.items) {
      if (KeyValues.CosmeticsKv[item.item_id]) {
        return item.item_id.toString().slice(0, 3);
      }
    }
  })();
  const onAddToken = () => {
    if ((playerTokens?.[itemData.pay_type]?.num ?? 0) < itemData.real_price && Math.floor(itemData.pay_type / 100) == 11001) {
      return () => {
        const infoShopData = getNetDataCache("info_shop_product_group_by_tag");
        const playerTokens = getNetDataCache("player_token", Players.GetLocalPlayer());
        if (infoShopData && playerTokens) {
          const storeID = Number(9809800 + itemData.pay_type % 100);
          for (const tag in infoShopData) {
            const storeData = infoShopData[tag].find(v => v.id == storeID);
            if (storeData) {
              let needAmounts = itemData.real_price - (playerTokens[itemData.pay_type.toString()]?.num ?? 0);
              if (needAmounts > 0) {
                showPopup("StoreBuyItem", {
                  itemData: storeData,
                  limit_num: needAmounts,
                  group: "StoreBuyItem"
                });
                return;
              }
              break;
            }
          }
        }
      };
    }
  };
  return {
    itemId: item_data.id,
    itemName: $.Localize("#" + item_data.id),
    itemImage: "file://{images}/custom_game/store_items/" + item_data.id + ".png",
    itemCount: item_data.items.length == 1 ? item_data.items?.[0]?.amounts ?? 1 : 1,
    enabled,
    end_time: item_data.end_time,
    button: getButtonData(item_data, isStoreUI),
    tagName,
    owned: soldOut,
    rarity: Number(item_data.title),
    labels,
    orgin_price: origin_price,
    store_id: item_data.id,
    pay_type: item_data.pay_type,
    cosmeticType,
    onBuyItem: () => {
      if (item_data.end_time != 0 && item_data.end_time < Math.floor(Date.now() / 1000)) {
        return;
      }
      const cosmeticsList = Object.keys(KeyValues.CosmeticsKv);
      const hasCosmetic = ignorePreview ? false : item_data.items.some(v => {
        return cosmeticsList.includes(v.item_id.toString());
      });
      if (hasCosmetic) {
        clientSideEvent("store_preview", {
          itemData: item_data,
          purchased_num: item_data.purchased_num,
          playerOrnament: playerOrnament,
          playerHeroes: playerHeroes
        });
      } else {
        showPopup("StoreBuyItem", {
          itemData: item_data,
          purchased_num: item_data.purchased_num,
          playerOrnament: playerOrnament,
          playerHeroes: playerHeroes,
          group: "StoreBuyItem"
        });
      }
    },
    onAddToken: onAddToken()
  };
};
const StoreItem = props => {
  const {
    local,
    others,
    discount,
    label_data,
    skinDebrisLabel
  } = useStoreItem(props);
  const resolved = libs.children(() => local.children);
  const _internalIcon = libs.children(() => props.internalIcon);
  const owned = () => {
    return local.owned;
  };
  const limitInfo = () => local.labels?.filter(label => label.type == "limit")?.[0];
  const limitType = () => {
    switch (Number(limitInfo()?.label?.split("|")?.[0])) {
      case 1:
        return "#LimitLife";
      case 2:
        return "#LimitDay";
      case 3:
        return "#LimitWeek";
      default:
        return "#LimitMonth";
    }
  };
  const limitCount = () => limitInfo()?.label?.split("|")?.[1];
  const sLanguage = $.Language().toLowerCase();
  let now = Math.floor(Date.now() / 1000);
  return libs.createComponent(EOM_Panel.EOM_Panel, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: "StoreItem"
  }), {
    get children() {
      return [libs.createComponent(EOM_Button.EOM_BaseButton, {
        className: "StoreItemMain",
        onactivate: self => {
          if (local.onBuyItem && local.enabled) {
            local.onBuyItem();
          }
          if (local.markType && local.store_id && local.checkNewMark) {
            local.checkNewMark(self, local.store_id);
          }
        },
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return limitInfo() != undefined;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "StoreLimit",
                get children() {
                  return libs.createComponent(GenericPanel.CLabel, {
                    get className() {
                      return libs.classNames("LimitLabel", sLanguage);
                    },
                    get text() {
                      return $.Localize(limitType()) + $.Localize("#LimitLabel") + " " + limitCount();
                    }
                  });
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return local.end_time && local.end_time > 0;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                get classList() {
                  return {
                    StoreCountdown: true,
                    LowTime: now > (local.end_time ?? 0) - 24 * 60 * 60,
                    [$.Language().toLowerCase()]: true
                  };
                },
                get children() {
                  return [(() => {
                    const _el$ = libs.createElement("Image", {}, null);
                    libs.setProp(_el$, "className", "CountDownIcon");
                    return _el$;
                  })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                    get endTime() {
                      return Number(local.end_time);
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(StoreItemImage.StoreItemImage, {
            get itemName() {
              return local.itemName;
            },
            get rarity() {
              return local.rarity;
            },
            get itemImage() {
              return local.itemImage;
            },
            get itemCount() {
              return local.itemCount;
            },
            get cosmeticType() {
              return local.cosmeticType;
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return owned();
            },
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "Owned"
              }), (() => {
                const _el$2 = libs.createElement("Image", {}, null);
                libs.setProp(_el$2, "className", "OwnedMask");
                return _el$2;
              })()];
            }
          }), libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "StoreItemLabels",
            verticalAlign: "bottom",
            marginBottom: "74px",
            flowChildren: "up",
            get children() {
              return libs.createComponent(libs.Index, {
                get each() {
                  return label_data();
                },
                children: (labelInfo, index) => {
                  return libs.createComponent(EOM_Panel.EOM_Panel, {
                    flowChildren: "down",
                    get children() {
                      return [libs.createComponent(libs.Show, {
                        get when() {
                          return labelInfo().countdown != undefined;
                        },
                        get children() {
                          return libs.createComponent(EOM_Countdown.EOM_Countdown, {
                            get className() {
                              return libs.classNames("CountDown", {
                                Show: false
                              });
                            },
                            get endTime() {
                              return labelInfo().countdown;
                            },
                            text: "#countdown_time",
                            hittest: false
                          });
                        }
                      }), libs.createComponent(EOM_Image.EOM_Image, {
                        get className() {
                          return libs.classNames("StoreItemLabel", labelInfo().type);
                        },
                        get children() {
                          return libs.createComponent(GenericPanel.CLabel, {
                            get text() {
                              return labelInfo().label;
                            }
                          });
                        }
                      })];
                    }
                  });
                }
              });
            }
          }), libs.createComponent(libs.Show, {
            get when() {
              return local.onBuyItem;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "ButtonContainer",
                get children() {
                  return libs.createComponent(libs.Switch, {
                    get fallback() {
                      return libs.createComponent(EOM_Button.EOM_Button, {
                        id: "BuyButton",
                        get className() {
                          return local.button?.className;
                        },
                        get enabled() {
                          return local.enabled;
                        },
                        get color() {
                          return local.button?.color;
                        },
                        horizontalAlign: "center",
                        get text() {
                          return local.button?.text ?? "";
                        },
                        get icon() {
                          return local.button?.icon;
                        },
                        get children() {
                          return libs.createComponent(libs.Show, {
                            get when() {
                              return discount() != "";
                            },
                            get children() {
                              return libs.createComponent(GenericPanel.CLabel, {
                                id: "OriginalPrice",
                                get text() {
                                  return `${local.orgin_price}`;
                                }
                              });
                            }
                          });
                        }
                      });
                    },
                    get children() {
                      return libs.createComponent(libs.Match, {
                        get when() {
                          return skinDebrisLabel();
                        },
                        get children() {
                          return libs.createComponent(EOM_Button.EOM_BaseButton, {
                            id: "SkinDebrisBuyButton",
                            get enabled() {
                              return local.enabled;
                            },
                            horizontalAlign: "center",
                            get children() {
                              return [libs.memo(() => (() => {
                                const percentage = () => {
                                  if (!local.enabled) {
                                    return 100;
                                  }
                                  return Clamp(finiteNumber(Number(skinDebrisLabel())) / Math.max(1, finiteNumber(Number(local.orgin_price))), 0, 1) * 100;
                                };
                                return libs.createComponent(EOM_Panel.EOM_Panel, {
                                  id: "SkinDebrisButtonBG",
                                  get children() {
                                    return libs.createComponent(EOM_Panel.EOM_Panel, {
                                      id: "SkinDebrisProgress",
                                      get width() {
                                        return `${percentage()}%`;
                                      },
                                      height: "100%"
                                    });
                                  }
                                });
                              })()), libs.memo(() => libs.children(() => local.button?.icon)()), libs.createComponent(libs.Show, {
                                get when() {
                                  return local.onAddToken != undefined && local.enabled;
                                },
                                get fallback() {
                                  return libs.createComponent(GenericPanel.CLabel, {
                                    id: "SkinDebrisPrice",
                                    text: "#Store_Exchange_Button"
                                  });
                                },
                                get children() {
                                  return [libs.createComponent(GenericPanel.CLabel, {
                                    id: "SkinDebrisPrice",
                                    get text() {
                                      return `${skinDebrisLabel()}/${local.orgin_price ?? -1}`;
                                    }
                                  }), libs.createComponent(EOM_Button.EOM_IconButton, {
                                    id: "SkinDebrisAdd",
                                    get icon() {
                                      return libs.createComponent(EOM_Icon.EOM_Icon, {
                                        get src() {
                                          return getSrcPath("eom_design/icon/c4/btn_store_add.png");
                                        }
                                      });
                                    },
                                    onactivate: () => local.onAddToken()
                                  })];
                                }
                              })];
                            }
                          });
                        }
                      });
                    }
                  });
                }
              });
            }
          }), libs.memo(() => _internalIcon())];
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.tagName != undefined;
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            get className() {
              return libs.classNames("StoreItemTag", local.tagName);
            },
            hittest: false,
            hittestchildren: false,
            get children() {
              return [libs.createComponent(EOM_Panel.EOM_Panel, {
                id: "StoreItemTagBG"
              }), libs.createComponent(GenericPanel.CLabel, {
                get text() {
                  return $.Localize("#StoreTag_" + local.tagName);
                }
              })];
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.markType;
        },
        get children() {
          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
            get type() {
              return local.markType == "new" ? "new_large" : local.markType;
            }
          });
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        get className() {
          return libs.classNames("StoreItemDiscount", "discount" + discount(), "Top");
        },
        hittest: false
      }), libs.memo(() => resolved())];
    }
  }));
};
const SpecialItem = props => {
  const [local, others] = libs.splitProps(props, ["type", "itemId", "store_id", "checkNewMark", "itemName", "enabled", "owned", "tagName", "rarity", "labels", "itemImage", "itemCount", "button", "end_time", "onBuyItem", "orgin_price", "markType"]);
  const {
    discount} = useStoreItem(props);
  const limitInfo = () => local.labels?.filter(label => label.type == "limit")?.[0];
  const limitType = () => {
    switch (Number(limitInfo()?.label?.split("|")?.[0])) {
      case 1:
        return "#LimitLife";
      case 2:
        return "#LimitDay";
      case 3:
        return "#LimitWeek";
      default:
        return "#LimitMonth";
    }
  };
  const limitCount = () => limitInfo()?.label?.split("|")?.[1];
  const owned = () => {
    return local.owned;
  };
  let now = Math.floor(Date.now() / 1000);
  const language = $.Language().toLowerCase();
  const end_time = () => local?.end_time ?? 0;
  const titlePath = () => {
    if (language == "schinese") {
      return getSrcPath(`store/must/${local.itemId}/title_ch.png`);
    } else if (language == "english") {
      return getSrcPath(`store/must/${local.itemId}/title_en.png`);
    } else if (language == "russian") {
      return getSrcPath(`store/must/${local.itemId}/title_en.png`);
    }
    return getSrcPath(`store/must/${local.itemId}/title_ch.png`);
  };
  return libs.createComponent(EOM_Button.EOM_BaseButton, libs.mergeProps(() => EOM_Panel.EOMProps(others, {
    className: libs.classNames("SpecialItem", local.itemId)
  }), {
    get classList() {
      return {
        [local.type ?? ""]: true
      };
    },
    onactivate: self => {
      if (local.onBuyItem && local.enabled) {
        local.onBuyItem();
      }
      if (local.markType && local.store_id && local.checkNewMark) {
        local.checkNewMark(self, local.store_id);
      }
    },
    get children() {
      return [(() => {
        const _el$3 = libs.createElement("Panel", {
            id: "content"
          }, null),
          _el$12 = libs.createElement("Panel", {
            id: "Price"
          }, _el$3);
        libs.insert(_el$3, libs.createComponent(GenericPanel.CImage, {
          id: "Bg",
          get src() {
            return getSrcPath(`store/must/${local.itemId}/bg.png`);
          }
        }), _el$12);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return local.type == "big";
          },
          get children() {
            return [libs.createComponent(GenericPanel.CImage, {
              id: "Title",
              get src() {
                return titlePath();
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return discount() != "";
              },
              get children() {
                const _el$4 = libs.createElement("Panel", {
                  id: "Discont"
                }, null);
                libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
                  get text() {
                    return 100 - finiteNumber(Number(discount().split("-")[1]), 100);
                  }
                }));
                return _el$4;
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return end_time() > 0;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  get classList() {
                    return {
                      StoreCountdown: true,
                      LowTime: now > (end_time() ?? 0) - 24 * 60 * 60
                    };
                  },
                  get children() {
                    return [(() => {
                      const _el$5 = libs.createElement("Image", {}, null);
                      libs.setProp(_el$5, "className", "CountDownIcon");
                      return _el$5;
                    })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                      get endTime() {
                        return Number(end_time());
                      }
                    })];
                  }
                });
              }
            }), libs.createComponent(libs.Show, {
              get when() {
                return limitInfo() != undefined;
              },
              get children() {
                return libs.createComponent(EOM_Panel.EOM_Panel, {
                  className: "StoreLimit",
                  get children() {
                    return libs.createComponent(GenericPanel.CLabel, {
                      get className() {
                        return libs.classNames("LimitLabel");
                      },
                      get text() {
                        return $.Localize(limitType()) + $.Localize("#LimitLabel") + " " + limitCount();
                      }
                    });
                  }
                });
              }
            }), (() => {
              const _el$6 = libs.createElement("Panel", {
                  id: "Detail"
                }, null),
                _el$7 = libs.createElement("Image", {}, _el$6);
              libs.setProp(_el$6, "className", language);
              libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
                text: "#click_to_show"
              }), _el$7);
              return _el$6;
            })()];
          }
        }), _el$12);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return local.type == "small";
          },
          get children() {
            const _el$8 = libs.createElement("Panel", {
                id: "right"
              }, null),
              _el$0 = libs.createElement("Panel", {
                id: "Detail"
              }, _el$8),
              _el$1 = libs.createElement("Image", {}, _el$0);
            libs.insert(_el$8, libs.createComponent(GenericPanel.CLabel, {
              id: "ItemName",
              get text() {
                return local.itemName;
              }
            }), _el$0);
            libs.insert(_el$8, libs.createComponent(EOM_Panel.EOM_Panel, {
              get visible() {
                return end_time() > 0;
              },
              get classList() {
                return {
                  StoreCountdown: true,
                  LowTime: now > (end_time() ?? 0) - 24 * 60 * 60
                };
              },
              get children() {
                return [(() => {
                  const _el$9 = libs.createElement("Image", {}, null);
                  libs.setProp(_el$9, "className", "CountDownIcon");
                  return _el$9;
                })(), libs.createComponent(EOM_Countdown.EOM_Countdown, {
                  get endTime() {
                    return Number(end_time());
                  }
                })];
              }
            }), _el$0);
            libs.insert(_el$0, libs.createComponent(GenericPanel.CLabel, {
              text: "#click_to_show"
            }), _el$1);
            return _el$8;
          }
        }), _el$12);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return limitInfo() != undefined;
          },
          get children() {
            return libs.createComponent(EOM_Panel.EOM_Panel, {
              className: "StoreLimit",
              get children() {
                return libs.createComponent(GenericPanel.CLabel, {
                  get className() {
                    return libs.classNames("LimitLabel");
                  },
                  get text() {
                    return $.Localize(limitType()) + $.Localize("#LimitLabel") + " " + limitCount();
                  }
                });
              }
            });
          }
        }), _el$12);
        libs.insert(_el$3, libs.createComponent(libs.Show, {
          get when() {
            return libs.memo(() => local.orgin_price != undefined)() && discount() != "";
          },
          get children() {
            const _el$10 = libs.createElement("Panel", {
                id: "PriceBeforeDiscount"
              }, null),
              _el$11 = libs.createElement("Panel", {
                id: "div"
              }, _el$10);
            libs.insert(_el$10, libs.createComponent(GenericPanel.CLabel, {
              get text() {
                return local.orgin_price ?? "";
              }
            }), _el$11);
            return _el$10;
          }
        }), _el$12);
        libs.insert(_el$12, () => local.button?.icon, null);
        libs.insert(_el$12, libs.createComponent(GenericPanel.CLabel, {
          get text() {
            return local.button?.text ?? "";
          }
        }), null);
        libs.effect(_$p => libs.setProp(_el$3, "classList", {
          owned: local.owned
        }, _$p));
        return _el$3;
      })(), libs.createComponent(libs.Show, {
        get when() {
          return owned();
        },
        get children() {
          return libs.createComponent(EOM_Panel.EOM_Panel, {
            className: "Owned"
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return local.markType != undefined;
        },
        get children() {
          return libs.createComponent(MenuMarkIcon.MenuMarkIcon, {
            get type() {
              return local.markType == "new" ? "new_largest" : local.markType;
            }
          });
        }
      })];
    }
  }));
};

exports.SpecialItem = SpecialItem;
exports.StoreItem = StoreItem;
exports.getButtonData = getButtonData;
exports.getLabels = getLabels;
exports.getStoreItemProps = getStoreItemProps;
exports.getTagName = getTagName;
exports.useStoreItem = useStoreItem;