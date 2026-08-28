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
var red_point_utils = require('./red_point_utils.js');
var netdata_utils = require('./netdata_utils.js');
var game_utils = require('./game_utils.js');
var StoreItem = require('./StoreItem.js');
require('./CourierTitle.js');
require('./EOM_PortraitFullBody.js');
require('./WinStreak.js');
require('./Heroes.js');
require('./profile_info.js');
require('./EOM_Icon.js');
require('./MenuMarkIcon.js');
require('./StoreItemImage.js');

const language = $.Language().toLowerCase();
const dataMap = {
  "3000012": {
    itemid: 9900303,
    count: 1
  },
  "3000018": {
    itemid: 9900302,
    count: 1
  },
  "3000004": {
    itemid: 9900307,
    count: 1
  },
  "3000037": {
    itemid: 9900316,
    count: 1
  },
  "1100001": {
    itemid: 1100001,
    count: 3000
  }
};
function FirstRecharge() {
  const [show, setShow] = libs.createSignal(false);
  const [rewardInfoList, setRewardInfoList] = libs.createSignal([]);
  const [loginActivityData, setLoginActivityData] = libs.createSignal();
  const itemid = () => dataMap[loginActivityData()?.extra ?? ""]?.itemid;
  const count = () => dataMap[loginActivityData()?.extra ?? ""]?.count;
  const haveReceived = () => Object.keys(loginActivityData()?.rewards ?? {}).some(index => loginActivityData()?.rewards[index] == 0);
  libs.createEffect(libs.on(show, showed => {
    if (showed) {
      callAction("activity_data", {
        activity_id: 1002
      });
    }
  }));
  libs.onMount(() => {
    let gameEventIDList = [];
    gameEventIDList.push(useToggleWindow("MenuButton_recharge", show, setShow));
    gameEventIDList.push(useNetData("info_activity_data", data => {
      for (const activityInfo of data) {
        if (activityInfo.activity_id == 1002) {
          const reward = JSON.parse(activityInfo.extra_information);
          setRewardInfoList(reward.rewards);
        }
      }
    }));
    gameEventIDList.push(useNetData("login_activity_data", data => {
      if (data["1002"] != undefined) {
        setLoginActivityData(data["1002"]);
      }
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
    });
  });
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    id: "FirstRecharge",
    get ["class"]() {
      return libs.classNames({
        Show: show()
      });
    },
    get children() {
      return [(() => {
        const _el$ = libs.createElement("Image", {
          id: "Title",
          "class": language
        }, null);
        libs.setProp(_el$, "class", language);
        return _el$;
      })(), (() => {
        const _el$2 = libs.createElement("Image", {
            id: "Ornaments",
            "class": language
          }, null);
          libs.createElement("Label", {
            text: "#total_value",
            id: "TotalValue"
          }, _el$2);
          const _el$4 = libs.createElement("Label", {
            html: true,
            text: "#total_value_Label",
            id: "TotalValueLabel",
            dialogVariables: {
              value: 300
            }
          }, _el$2);
        libs.setProp(_el$2, "class", language);
        libs.setProp(_el$4, "dialogVariables", {
          value: 300
        });
        return _el$2;
      })(), libs.createComponent(EOM_Panel.EOM_Panel, {
        zIndex: 2,
        horizontalAlign: "right",
        marginTop: "80px",
        marginRight: "40px",
        tooltip: "#FirstRechargeInfo",
        get children() {
          return [libs.createElement("Image", {
            id: "InfoImage"
          }, null), libs.createElement("Label", {
            id: "InfoLabel",
            text: "#SnowballInfo"
          }, null)];
        }
      }), libs.createComponent(EOM_Panel.EOM_Panel, {
        align: "center bottom",
        marginBottom: "200px",
        flowChildren: "right",
        zIndex: 10,
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return rewardInfoList();
            },
            children: (reward, index) => {
              const itemName = () => index == 0 ? itemid() : reward()?.rewards?.[0]?.item_id;
              const itemCount = () => index == 0 ? count() : reward()?.rewards?.[0]?.amounts;
              const enable = () => reward().reward_id == 1 ? loginActivityData()?.rewards["1"] == 0 : false;
              const received = () => loginActivityData()?.rewards[String(index + 1)] == 1;
              return libs.createComponent(Selection, {
                get day() {
                  return reward().reward_id;
                },
                get enable() {
                  return enable();
                },
                get received() {
                  return received();
                },
                get itemName() {
                  return itemName();
                },
                get count() {
                  return itemCount();
                }
              });
            }
          });
        }
      }), libs.createComponent(libs.Switch, {
        get children() {
          return [libs.createComponent(libs.Match, {
            get when() {
              return loginActivityData()?.active != true;
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "UnlockButton",
                onactivate: () => {
                  clientSideEvent("toggle_store_tag", {
                    menu: "Resource"
                  });
                },
                get children() {
                  return libs.createElement("Label", {
                    text: "#UnlockRecharge",
                    id: "UnlockLabel"
                  }, null);
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return libs.memo(() => loginActivityData()?.active == true)() && haveReceived();
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "UnlockButton",
                onactivate: () => {
                  callAction("activity_receive", {
                    activity_id: 1002,
                    reward_id: loginActivityData()?.progress ?? 1
                  });
                },
                get children() {
                  return libs.createElement("Label", {
                    text: "#activity_action_receive",
                    id: "UnlockLabel"
                  }, null);
                }
              });
            }
          }), libs.createComponent(libs.Match, {
            get when() {
              return libs.memo(() => loginActivityData()?.active == true)() && !haveReceived();
            },
            get children() {
              return libs.createComponent(EOM_Button.EOM_BaseButton, {
                id: "UnlockButton",
                enabled: false,
                get children() {
                  return libs.createElement("Label", {
                    text: "#TomorrowCanReceive",
                    id: "UnlockLabel"
                  }, null);
                }
              });
            }
          })];
        }
      })];
    }
  });
}
function Selection(props) {
  return libs.createComponent(EOM_Panel.EOM_Panel, {
    margin: "0px 88px",
    get children() {
      return [(() => {
        const _el$0 = libs.createElement("Image", {
            "class": "Mark"
          }, null),
          _el$1 = libs.createElement("Label", {
            text: "#RechargeReceive",
            get dialogVariables() {
              return {
                day: props.day
              };
            }
          }, _el$0);
        libs.effect(_$p => libs.setProp(_el$1, "dialogVariables", {
          day: props.day
        }, _$p));
        return _el$0;
      })(), libs.createComponent(EOM_Button.EOM_BaseButton, {
        "class": "RewardContainer",
        get enabled() {
          return props.enable ?? false;
        },
        onactivate: () => {
          showPopup("FirstRecharge", {});
        },
        get children() {
          return libs.createElement("Image", {
            "class": "Add"
          }, null);
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.received;
        },
        get children() {
          return libs.createElement("Image", {
            "class": "Check"
          }, null);
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.day == 1;
        },
        get children() {
          const _el$12 = libs.createElement("Image", {
              "class": "HeroSelect"
            }, null);
            libs.createElement("Label", {
              text: "#RechargeHeroSelect"
            }, _el$12);
          return _el$12;
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.itemName != undefined;
        },
        get children() {
          return libs.createComponent(ProductImage.ProductImage, {
            width: "179px",
            height: "179px",
            horizontalAlign: "center",
            get itemid() {
              return Number(props.itemName);
            }
          });
        }
      }), libs.createComponent(libs.Show, {
        get when() {
          return props.count != undefined;
        },
        get children() {
          const _el$14 = libs.createElement("Label", {
            "class": "ItemCount",
            get text() {
              return "×" + props.count;
            }
          }, null);
          libs.effect(_$p => libs.setProp(_el$14, "text", "×" + props.count, _$p));
          return _el$14;
        }
      })];
    }
  });
}

const SHOP_TAG_LIST = ["Must", "Cosmetics", "MoonShop", "ActiveStar", "GoldShop", "Resource", "VIP"];
if (!isSpectator()) {
  const heroCasualOnlyList = [];
  for (const key in KeyValues.UnitsCommonKv) {
    if (KeyValues.UnitsCommonKv[key].Access == "store" && KeyValues.UnitsCommonKv[key].CasualOnly == 1 && typeof KeyValues.UnitsCommonKv[key].StoreID == "number") {
      heroCasualOnlyList.push(KeyValues.UnitsCommonKv[key].StoreID);
    }
  }
  const [show, setShow] = libs.createSignal(false);
  const [tabIndex, setTabIndex] = libs.createSignal(0);
  const [menuKeys, setMenuKeys] = libs.createSignal([]);
  const [storeItemData, setStoreItemData] = libs.createSignal({});
  const [purchased_product, setPurchasedProduct] = libs.createSignal({});
  const [markNewInfo, setMarkNewInfo] = libs.createStore({});
  const [newPlayerOpen, setNewPlayerOpen] = libs.createSignal(false);
  const [newPlayerFinish, setNewPlayerFinish] = libs.createSignal(false);
  const [isToolMode, setIsToolMode] = libs.createSignal((CustomNetTables.GetTableValue("common", "settings")?.is_in_tools_mode ?? 0) == 1);
  const setMarkNewInfo_Custom = (key1, key2, value) => {
    setMarkNewInfo(key1, v => {
      if (v == undefined) {
        return {
          [key2]: value
        };
      } else {
        v[key2] = value;
      }
      return Object.assign({}, v);
    });
  };
  const filterInvalidStoreMark = (markInfo, storeItems) => {
    const tagList = Object.keys(storeItems);
    for (const tag in markInfo) {
      const sidList = Object.keys(markInfo[tag]);
      if (sidList.length > 0) {
        if (!tagList.includes(tag)) {
          sidList.forEach(sid => {
            setMarkNewInfo_Custom(tag, sid, null);
            checkNewMark(undefined, Number(sid));
          });
        } else {
          sidList.forEach((sid, index) => {
            if (!storeItems[tag].some(v => v.id == Number(sid))) {
              setMarkNewInfo_Custom(tag, sid, null);
              checkNewMark(undefined, Number(sid));
            }
          });
        }
      }
    }
  };
  let invalidStoreMarkClearTimer;
  libs.createEffect(() => {
    if (Object.keys(markNewInfo).length == 0 || Object.values(markNewInfo).every(v => Object.keys(v).length == 0)) return;
    if (Object.keys(storeItemData()).length == 0) return;
    if (invalidStoreMarkClearTimer != undefined) {
      $.CancelScheduled(invalidStoreMarkClearTimer);
    }
    invalidStoreMarkClearTimer = $.Schedule(1, () => {
      filterInvalidStoreMark(markNewInfo, storeItemData());
      invalidStoreMarkClearTimer = undefined;
    });
  });
  const checkNewMark = (self, id) => {
    if (id == undefined) return;
    if (markNewInfo) {
      for (const tag in markNewInfo) {
        for (const sid in markNewInfo[tag]) {
          if (id.toString() == sid) {
            if (markNewInfo[tag][sid]) {
              setMarkNewInfo_Custom(tag, sid, null);
            }
          }
        }
      }
    }
    {
      GameEvents.SendCustomEventToServer("check_store_new_mark", {
        id: id.toString()
      });
    }
  };
  let directlyPurchaseEvents = [];
  libs.onMount(() => {
    let gameEventIDList = [];
    let netTableIDList = [];
    gameEventIDList.push(useToggleWindow("MenuButton_store", show, setShow));
    gameEventIDList.push(useClientSideEvent("toggle_store_tag", event => {
      if (event.tabIndex) {
        setTabIndex(event.tabIndex);
        ToggleWindows("MenuButton_store", true);
      } else if (event.menu) {
        setTabIndex(menuKeys().indexOf(event.menu));
        ToggleWindows("MenuButton_store", true);
      }
    }));
    gameEventIDList.push(useNetData("login_activity_data", data => {
      if (data["1002"] != undefined) {
        const allReceived = Object.keys(data["1002"].rewards).every(index => data["1002"].rewards[index] == 1);
        const isActivityOpen = data["1002"]?.active == true;
        setNewPlayerFinish(allReceived);
        setNewPlayerOpen(isActivityOpen);
      }
    }, Players.GetLocalPlayer()));
    callAction("activity_data", {
      activity_id: 1002
    });
    gameEventIDList.push(useClientSideEvent("directly_purchase", event => {
      const cache = getNetDataCache("info_shop_product_group_by_tag");
      if (Object.keys(cache).length > 0) {
        let list = [];
        if (event.itemid) {
          let id = finiteNumber(Number(event.itemid), -1);
          if (id != -1) {
            list.push(id);
          }
        } else if (event.itemidList) {
          if (Array.isArray(event.itemidList)) {
            event.itemidList.forEach(v => {
              let id = finiteNumber(Number(v), -1);
              if (id != -1) {
                list.push(id);
              }
            });
          }
        }
        if (list.length > 0) {
          let hasFind = false;
          let endLoop = false;
          let storeDataList = [];
          for (const tag in cache) {
            const itemList = cache[tag];
            for (const itemData of itemList) {
              let index = list.indexOf(itemData.id);
              if (index != -1) {
                if (itemData.real_price == 0) {
                  serverRequest("product_buy", {
                    product_id: itemData.id,
                    product_num: 1
                  }, res => {
                    if (res.status == 0) {
                      showPopup("StoreBuyItemResult", {
                        result: "success"
                      });
                    } else {
                      showPopup("StoreBuyItemResult", {
                        result: "failure"
                      });
                    }
                  });
                  endLoop = true;
                  hasFind = true;
                  break;
                } else {
                  list.splice(index, 1);
                  storeDataList.push(itemData);
                  if (list.length == 0) {
                    endLoop = true;
                  }
                }
              }
              if (endLoop) {
                break;
              }
            }
            if (endLoop) {
              break;
            }
          }
          if (!hasFind) {
            if (storeDataList.length > 0) {
              showPopup("StoreBuyItemMult", {
                itemData: storeDataList,
                initCount: finiteNumber(Number(event.count), 1),
                group: "StoreBuyItem"
              });
            }
          }
        }
      } else {
        directlyPurchaseEvents.push(event);
      }
    }));
    gameEventIDList.push(useNetData("login_activity_data", data => {
      if (data["1002"] != undefined) {
        if ((data["1002"]?.active ?? false) == false) ;
      }
    }, Players.GetLocalPlayer()));
    libs.onCleanup(() => {
      gameEventIDList.forEach(id => GameEvents.Unsubscribe(id));
      netTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
    });
  });
  const handleProduceData = (data, isToolMode = false) => {
    const result = {};
    const tokenAccess = {};
    const _purchased_product = purchased_product();
    let tokenAccessTagList = SHOP_TAG_LIST.concat(["GoldRedeem", "MoonRedeem", "YearRedeem"]);
    const funcHandleAccess = (storeItem, tag) => {
      if (storeItem.real_price > 0 && storeItem.items && storeItem.items.length > 0 && tokenAccessTagList.includes(tag)) {
        let includeTokens = [];
        storeItem.items.forEach(_data => {
          let type = _data.item_id.toString().slice(0, 3);
          if (type == "110" || type == "200" || type == "930" || type == "931") {
            if (!includeTokens.includes(_data.item_id)) {
              includeTokens.push(_data.item_id);
            }
          }
          includeTokens = includeTokens.filter(v => {
            if (storeItem.items.length > 1) {
              if (v == 1100001) {
                return false;
              }
              if (type != "110" && type != "200" && type != "930" && type != "931") {
                return false;
              }
            }
            return true;
          });
          includeTokens.forEach(id => {
            if (tokenAccess[id] == undefined) {
              tokenAccess[id] = [];
            }
            if (!tokenAccess[id].includes(storeItem.id)) {
              tokenAccess[id].push(storeItem.id);
            }
          });
        });
      }
    };
    let sortedIDs = [];
    Object.values(KeyValues.ShopProductStepList).forEach(list => {
      sortedIDs = sortedIDs.concat(list);
    });
    const stepProductDataList = {};
    for (const tag in data) {
      data[tag].forEach(storeItem => {
        if (!SHOP_TAG_LIST.includes(tag)) {
          return;
        }
        if (!isToolMode && $.Localize("#" + storeItem.id) == "#" + storeItem.id) {
          return;
        }
        if (sortedIDs.includes(storeItem.id)) {
          if (stepProductDataList[storeItem.id] == undefined) {
            stepProductDataList[storeItem.id] = {
              data: Object.assign({}, storeItem),
              tag: []
            };
          }
          stepProductDataList[storeItem.id].tag.push(tag);
          return;
        }
        funcHandleAccess(storeItem, tag);
        if (storeItem.id.toString().slice(0, 3) == "980") {
          return;
        }
        if (result[tag] == undefined) {
          result[tag] = [];
        }
        result[tag].push(storeItem);
      });
    }
    if (Object.keys(stepProductDataList).length > 0) {
      Object.values(KeyValues.ShopProductStepList).forEach(list => {
        let stepid = -1;
        let limit_count = 0;
        let all_purchased_num = 0;
        for (let i = 0; i < list.length; i++) {
          let id = list[i];
          const stepData = stepProductDataList[id];
          let item_data = stepData.data;
          let purchased_num = _purchased_product?.[id] ?? 0;
          all_purchased_num += purchased_num;
          if (stepid == -1) {
            if (i == list.length - 1) {
              stepid = id;
            } else {
              if (item_data.limit_type >= 1 && finiteNumber(Number(purchased_num)) < item_data.limit_count) {
                stepid = id;
              }
            }
          }
          limit_count += item_data.limit_count;
        }
        if (stepid != -1) {
          let storeItem = stepProductDataList[stepid].data;
          storeItem.limit_count = limit_count;
          storeItem.step_purchased_num = all_purchased_num;
          stepProductDataList[stepid].tag.forEach(tag => {
            funcHandleAccess(storeItem, tag);
            if (storeItem.id.toString().slice(0, 3) == "980") {
              return;
            }
            if (result[tag] == undefined) {
              result[tag] = [];
            }
            result[tag].push(storeItem);
          });
        }
      });
    }
    for (const tag in result) {
      result[tag].sort((a, b) => b.order_by - a.order_by);
    }
    setClientGlobalData("token_access", tokenAccess);
    return result;
  };
  const useStoreData = () => {
    const [paymentOpen, setPaymentOpen] = libs.createSignal(false);
    const [player_hero, setPlayerHero] = libs.createSignal({});
    const [player_token, setPlayerToken] = libs.createSignal({});
    const player_vip = netdata_utils.createPlayerNetData("player_vip", Players.GetLocalPlayer(), {
      level: 1,
      expire: 0,
      permanent: 0,
      vip_valid: 0
    });
    const [exchangeShow, setExchangeShow] = libs.createSignal(false);
    const [packItemData, setPackItemData] = libs.createSignal();
    const packItemIsSkinDebris = libs.createMemo(() => {
      return Math.floor((packItemData()?.pay_type ?? 0) / 100) == 11001;
    });
    const [packItemCount, setPackItemCount] = libs.createSignal(1);
    const [previewID, setPreviewID] = libs.createSignal(5100008);
    const defaultPage = () => {
      const page = [];
      if (!newPlayerFinish()) {
        page.push("MenuButton_recharge");
      }
      return page;
    };
    const [menuList, setMenuList] = libs.createSignal({});
    const [playerOrnament, setPlayerOrnament] = libs.createSignal({});
    const [redPoints, setRedPoints] = libs.createSignal(getClientGlobalData("red_points") ?? []);
    libs.createEffect(libs.on(purchased_product, () => {
      const cache = getNetDataCache("info_shop_product_group_by_tag");
      if (cache) {
        setStoreItemData(handleProduceData(cache, isToolMode()));
      }
    }));
    libs.createEffect(libs.on(storeItemData, store_item_data => {
      const storeItemKeys = Object.keys(store_item_data);
      if (storeItemKeys.length > 0 && directlyPurchaseEvents.length > 0) {
        directlyPurchaseEvents.forEach(data => {
          clientSideEvent("directly_purchase", data);
        });
        directlyPurchaseEvents = [];
      }
      const list = {};
      const isInBlackList = isBlackList(getPlayerData(Players.GetLocalPlayer(), "steamID"));
      const sortedTags = storeItemKeys.filter(tag => {
        if (isInBlackList) {
          return tag != "Resource";
        }
        return SHOP_TAG_LIST.includes(tag);
      }).sort((a, b) => {
        const aIndex = SHOP_TAG_LIST.indexOf(a);
        const bIndex = SHOP_TAG_LIST.indexOf(b);
        if (aIndex !== -1 && bIndex !== -1) {
          return aIndex - bIndex;
        } else if (aIndex !== -1) {
          return -1;
        } else if (bIndex !== -1) {
          return 1;
        } else {
          return a > b ? 1 : -1;
        }
      });
      sortedTags.forEach((tag, index) => {
        list[tag] = [];
      });
      defaultPage().forEach(page => {
        list[page] = [];
      });
      setMenuList(list);
      setMenuKeys(Object.keys(list));
    }));
    libs.createEffect(libs.on(menuList, list => {
      setClientGlobalData("menu_bar_store_tabs", Object.keys(list), true);
    }));
    libs.createEffect(libs.on(isToolMode, _isToolMode => {
      const cache = getNetDataCache("info_shop_product_group_by_tag");
      if (cache) {
        setStoreItemData(handleProduceData(cache, _isToolMode));
      }
    }));
    libs.onMount(() => {
      let gameEventIDList = [];
      let NetTableIDList = [];
      gameEventIDList.push(useNetData("info_shop_product_group_by_tag", data => {
        setStoreItemData(handleProduceData(data, isToolMode()));
      }));
      gameEventIDList.push(useNetData("player_purchased_products", data => {
        setPurchasedProduct(data.purchased_products);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData('player_hero', data => {
        setPlayerHero(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useClientSideEvent("toggle_store_tag", event => {
        if (event.tabIndex) {
          setTabIndex(event.tabIndex);
          ToggleWindows("MenuButton_store", true);
        } else if (event.menu) {
          setTabIndex(menuKeys().indexOf(event.menu));
          ToggleWindows("MenuButton_store", true);
        }
      }));
      gameEventIDList.push(useClientSideEvent("store_preview", event => {
        setPackItemData(event.itemData);
        if (event.itemData.items) {
          for (const iterator of event.itemData.items) {
            if (KeyValues.CosmeticsKv[iterator.item_id] != undefined) {
              setPreviewID(iterator.item_id);
            }
          }
        }
        setExchangeShow(true);
      }));
      gameEventIDList.push(useNetData('player_token', data => {
        setPlayerToken(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData('player_ornament', data => {
        setPlayerOrnament(data);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useNetData("open_payment", data => {
        setPaymentOpen(data.open);
      }, Players.GetLocalPlayer()));
      gameEventIDList.push(useClientGlobalData("red_points", setRedPoints));
      NetTableIDList.push(useNetTableKey("common", "settings", data => {
        setIsToolMode(data.is_in_tools_mode == 1);
      }));
      libs.onCleanup(() => {
        for (const id of gameEventIDList) {
          GameEvents.Unsubscribe(id);
        }
        NetTableIDList.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      });
    });
    return {
      exchangeShow,
      setExchangeShow,
      paymentOpen,
      setTabIndex,
      tabIndex,
      storeItemData,
      menuList,
      purchased_product,
      menuKeys,
      playerOrnament,
      player_hero,
      packItemData,
      previewID,
      setPreviewID,
      packItemCount,
      setPackItemCount,
      player_token,
      packItemIsSkinDebris,
      player_vip,
      redPoints
    };
  };
  const getCosmeticItemProps = ({
    item_id,
    end_time,
    playerOrnament,
    playerHeroes
  }) => {
    const itemID = () => item_id;
    const owned = libs.createMemo(() => {
      return Object.keys(playerOrnament ?? {}).includes(item_id.toString()) || Object.keys(playerHeroes ?? {}).includes(item_id.toString());
    });
    const enabled = () => {
      return !owned();
    };
    const rarity = () => getCosmeticRarity(item_id);
    const button = () => {
      return {
        color: "Gold",
        text: "#CosmeticGet"
      };
    };
    const endTime = () => end_time;
    const itemImage = () => {
      return getCosmeticImagePath(itemID().toString());
    };
    const cosmeticType = libs.createMemo(() => {
      return itemID().toString().slice(0, 3);
    });
    return {
      itemId: itemID(),
      itemName: $.Localize("#" + itemID()),
      itemImage: itemImage(),
      itemCount: 1,
      enabled: enabled(),
      end_time: endTime(),
      button: button(),
      owned: !enabled(),
      rarity: rarity(),
      cosmeticType: cosmeticType(),
      onBuyItem: () => {
        const kv = KeyValues.CosmeticsKv[itemID()];
        if (kv) {
          const store_id = kv?.StoreID;
          const access = kv?.access;
          if (access == "draw" || access == "drawExchange") {
            if (store_id != undefined) {
              clientSideEvent("switchDrawPool", {
                pid: store_id
              });
              if (access == "drawExchange") {
                clientSideEvent("openDrawExchange", {
                  state: true
                });
              }
            }
            ToggleWindows('MenuButton_draw', true);
          } else if (access == "store" && store_id != undefined) {
            clientSideEvent('directly_purchase', {
              itemid: store_id
            });
          } else if (access == "coloring") {
            showPopup("ColoringUnlock", {
              cosmeticId: itemID(),
              group: "ColoringUnlock"
            });
          } else if (access == "activity") {
            ToggleWindows('MenuButton_activity', true);
            if (store_id != undefined && store_id.toString() != "") {
              clientSideEvent("switchActivityTag", {
                id: store_id.toString()
              });
            }
          } else {
            if (access == "battlepass") {
              ToggleWindows('MenuButton_store', true);
            } else {
              ToggleWindows('MenuButton_' + access, true);
            }
          }
        }
      }
    };
  };
  function Store() {
    let previewTimer = -1;
    const {
      exchangeShow,
      setExchangeShow,
      paymentOpen,
      setTabIndex,
      tabIndex,
      storeItemData,
      menuList,
      purchased_product,
      menuKeys,
      playerOrnament,
      player_hero,
      packItemData,
      previewID,
      setPreviewID,
      packItemCount,
      setPackItemCount,
      player_token,
      player_vip,
      packItemIsSkinDebris,
      redPoints
    } = useStoreData();
    const [battlePassSkinsList, setBattlePassSkinsList] = libs.createSignal([]);
    const [bpSeason, setBpSeason] = libs.createSignal({
      sid: 1,
      start_time: 1692349200,
      end_time: 1694361599
    });
    const current_season = game_utils.GetBattlePassSeason();
    netdata_utils.createNetDataEffect("info_bp_season", data => {
      for (const seasonData of data) {
        if (seasonData.sid == current_season()) {
          setBpSeason(seasonData);
        }
      }
    }, undefined, [current_season]);
    netdata_utils.createNetDataEffect("info_bp_rewards", data => {
      const list = [];
      for (const rewardData of data) {
        if (current_season() == rewardData.season && rewardData.item_id.toString().slice(0, 1) == "5" && finiteNumber(Number(rewardData.item_id.toString().slice(0, 2))) != 55) {
          list.push(rewardData.item_id);
        }
      }
      list.sort((a, b) => getCosmeticRarity(b) - getCosmeticRarity(a));
      setBattlePassSkinsList(list);
    }, undefined, [current_season]);
    return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout, {
      id: "StoreMain",
      get show() {
        return libs.memo(() => !!show())() && paymentOpen();
      },
      renderOnShow: true,
      get className() {
        return menuKeys()?.[tabIndex()];
      },
      name: "MenuButton_store",
      get children() {
        return [libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Menu, {
          get menuList() {
            return menuList();
          },
          onToggleMenu: (menu, menu2) => {
            if (menu != '') {
              setTabIndex(menuKeys().indexOf(menu));
            }
          },
          menuName: "store",
          get show() {
            return show();
          },
          get selectedMenu() {
            return menuKeys()?.[tabIndex()];
          }
        }), libs.createComponent(Player.CurrencyGroup, {
          tokens: [1100098, "moonstone", "coin"],
          exchangeButton: true,
          recentOrder: true
        }), libs.createComponent(libs.For, {
          get each() {
            return menuKeys();
          },
          children: (tag, index) => {
            const itemList = () => {
              return storeItemData()[tag];
            };
            if (isBlackList(getPlayerData(Players.GetLocalPlayer(), "steamID")) && tag == "Resource") {
              return;
            }
            return libs.createComponent(EOM_MenuLayout.EOM_MenuLayout_Content, {
              id: tag,
              get show() {
                return tabIndex() == index();
              },
              renderOnShow: true,
              get children() {
                return (() => {
                  switch (tag) {
                    case "VIP":
                      return libs.createComponent(VipPage, {});
                    case "MenuButton_recharge":
                      return libs.createComponent(FirstRecharge, {});
                    case "Must":
                      return libs.createComponent(MustPage, {
                        get itemList() {
                          return itemList();
                        },
                        get purchased_product() {
                          return purchased_product();
                        },
                        get playerOrnament() {
                          return playerOrnament();
                        },
                        get player_hero() {
                          return player_hero();
                        },
                        get redPoints() {
                          return redPoints();
                        }
                      });
                    default:
                      return libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "StoreList",
                        get marginTop() {
                          return tag == "Resource" && newPlayerOpen() ? "0px" : "70px";
                        },
                        flowChildren: "right-wrap",
                        width: "100%",
                        height: "100%",
                        scroll: "y",
                        get children() {
                          return [libs.createComponent(libs.Show, {
                            get when() {
                              return tag == "Resource" && !newPlayerOpen();
                            },
                            get children() {
                              const _el$0 = libs.createElement("Panel", {
                                  id: "FirstRechargeBanner"
                                }, null);
                                libs.createElement("Image", {
                                  id: "BG"
                                }, _el$0);
                                libs.createElement("Image", {
                                  id: "Hero1"
                                }, _el$0);
                                libs.createElement("Image", {
                                  id: "Hero2"
                                }, _el$0);
                                libs.createElement("Image", {
                                  id: "Hero3"
                                }, _el$0);
                                libs.createElement("Image", {
                                  id: "Hero4"
                                }, _el$0);
                                libs.createElement("Label", {
                                  id: "Desc",
                                  text: "#FirstRechargeBannerDesc"
                                }, _el$0);
                              return _el$0;
                            }
                          }), libs.createComponent(libs.For, {
                            get each() {
                              return itemList();
                            },
                            children: (data, index) => {
                              return libs.createComponent(EOM_Panel.EOM_Panel, {
                                get children() {
                                  return [libs.createComponent(StoreItem.StoreItem, libs.mergeProps({
                                    get markType() {
                                      return red_point_utils.hasRedPoint(redPoints(), "store", tag, data.id) ? "default" : undefined;
                                    }
                                  }, () => StoreItem.getStoreItemProps({
                                    itemData: data,
                                    purchased_num: purchased_product()?.[data.id],
                                    playerOrnament: playerOrnament(),
                                    playerHeroes: player_hero(),
                                    isStoreUI: true,
                                    playerTokens: player_token(),
                                    playerVip: player_vip()
                                  }), {
                                    get internalIcon() {
                                      return libs.createComponent(libs.Show, {
                                        get when() {
                                          return tag == "GoldShop" && heroCasualOnlyList.includes(data.id);
                                        },
                                        get children() {
                                          return libs.createComponent(EOM_Panel.EOM_Panel, {
                                            className: "CasualOnly",
                                            get children() {
                                              return [libs.createComponent(EOM_Image.EOM_Image, {
                                                id: "CasualOnlyLeftLine"
                                              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                                                id: "CasualOnlyLine",
                                                get children() {
                                                  return libs.createComponent(GenericPanel.CLabel, {
                                                    text: "#CasualOnly"
                                                  });
                                                }
                                              }), libs.createComponent(EOM_Image.EOM_Image, {
                                                id: "CasualOnlyRightLine"
                                              })];
                                            }
                                          });
                                        }
                                      });
                                    }
                                  })), libs.createComponent(libs.Show, {
                                    get when() {
                                      return isToolMode();
                                    },
                                    get children() {
                                      return [libs.createComponent(EOM_Label.EOM_Label, {
                                        align: "center top",
                                        marginTop: "40px",
                                        textShadow: "0 0 2px 2 #000000",
                                        x: "20px",
                                        color: "white",
                                        get text() {
                                          return data.id;
                                        }
                                      }), libs.createComponent(EOM_Label.EOM_Label, {
                                        align: "right top",
                                        marginTop: "40px",
                                        textShadow: "0 0 2px 2 #000000",
                                        marginRight: "20px",
                                        color: "red",
                                        get text() {
                                          return data.order_by;
                                        }
                                      })];
                                    }
                                  })];
                                }
                              });
                            }
                          }), libs.createComponent(libs.Show, {
                            when: tag == "Cosmetics",
                            get children() {
                              return libs.createComponent(libs.Index, {
                                get each() {
                                  return battlePassSkinsList();
                                },
                                children: (id, i) => {
                                  const mark = () => KeyValues.CosmeticsKv[id()]?.mark;
                                  return libs.createComponent(StoreItem.StoreItem, libs.mergeProps(() => getCosmeticItemProps({
                                    item_id: id(),
                                    end_time: bpSeason().end_time,
                                    playerOrnament: playerOrnament(),
                                    playerHeroes: player_hero()
                                  }), {
                                    get children() {
                                      return libs.createComponent(CosmeticCard.MarkIcon, {
                                        get mark() {
                                          return mark();
                                        },
                                        hittest: false
                                      });
                                    }
                                  }));
                                }
                              });
                            }
                          })];
                        }
                      });
                  }
                })();
              }
            });
          }
        }), (() => {
          const _el$ = libs.createElement("Panel", {
              id: "ExchangePanel"
            }, null),
            _el$2 = libs.createElement("Panel", {
              id: "TopBarBG"
            }, _el$),
            _el$3 = libs.createElement("Panel", {
              id: "ExchangeContainer"
            }, _el$),
            _el$4 = libs.createElement("Panel", {
              id: "ExchangeList"
            }, _el$3),
            _el$5 = libs.createElement("Panel", {
              id: "ExchangeContent"
            }, _el$4),
            _el$6 = libs.createElement("Panel", {
              id: "PackName"
            }, _el$5);
            libs.createElement("Image", {
              id: "Divider"
            }, _el$5);
            const _el$8 = libs.createElement("Panel", {
              id: "ExchangePreview"
            }, _el$3),
            _el$9 = libs.createElement("Panel", {
              id: "CosmeticDesc"
            }, _el$8);
          libs.insert(_el$2, libs.createComponent(Player.CurrencyGroup, {
            tokens: [1100098, "moonstone", "coin"]
          }));
          libs.setProp(_el$4, "onactivate", () => {});
          libs.insert(_el$4, libs.createComponent(EOM_Panel.EOM_Panel, {
            id: "ExchangeListTitle",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                id: "ExchangeListTitleLabel",
                text: "#Popup_StoreBuyItem_title"
              }), libs.createComponent(EOM_Button.EOM_CloseButton, {
                onactivate: () => {
                  setExchangeShow(false);
                }
              })];
            }
          }), _el$5);
          libs.insert(_el$6, libs.createComponent(GenericPanel.CLabel, {
            get text() {
              return "#" + packItemData()?.id;
            }
          }));
          libs.insert(_el$5, libs.createComponent(GenericPanel.CLabel, {
            id: "PackDesc",
            get text() {
              return "#" + packItemData()?.id + "_description";
            }
          }), null);
          libs.insert(_el$5, libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "right",
            horizontalAlign: "center",
            get children() {
              return libs.createComponent(libs.Switch, {
                get children() {
                  return [libs.createComponent(libs.Match, {
                    get when() {
                      return ((packItemData()?.items ?? []).length ?? 0) > 3;
                    },
                    get children() {
                      return [libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "ArrowLeft",
                        enabled: false
                      }), libs.createComponent(EOM_Panel.EOM_Panel, {
                        id: "PackItemList",
                        flowChildren: "right",
                        scroll: "x",
                        get children() {
                          return libs.createComponent(libs.Index, {
                            get each() {
                              return packItemData()?.items ?? [];
                            },
                            children: (storeItem, index) => libs.createComponent(EOM_Panel.EOM_Panel, {
                              get className() {
                                return libs.classNames("ExchangeItem", {});
                              },
                              onmouseover: self => {},
                              onmouseout: self => {},
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
                                      rarity: 1
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
                            })
                          });
                        }
                      }), libs.createComponent(EOM_Button.EOM_BaseButton, {
                        id: "ArrowRight",
                        enabled: false
                      })];
                    }
                  }), libs.createComponent(libs.Match, {
                    get when() {
                      return ((packItemData()?.items ?? []).length ?? 0) <= 3;
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
                              return packItemData()?.items ?? [];
                            },
                            children: (storeItem, index) => libs.createComponent(EOM_Panel.EOM_Panel, {
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
                                      rarity: 1
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
                            })
                          });
                        }
                      });
                    }
                  })];
                }
              });
            }
          }), null);
          libs.insert(_el$5, libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "right",
            horizontalAlign: "center",
            marginTop: "50px",
            get children() {
              return [libs.createComponent(GenericPanel.CLabel, {
                className: "CostDescLabel",
                text: "#Popup_StoreBuyItem_cost"
              }), libs.createComponent(EOM_Panel.EOM_Panel, {
                flowChildren: "right",
                verticalAlign: "center",
                get children() {
                  return [libs.createComponent(libs.Show, {
                    get when() {
                      return packItemIsSkinDebris();
                    },
                    get fallback() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        get src() {
                          return getPayTypeIconPath(packItemData()?.pay_type ?? 0);
                        },
                        width: "29px",
                        height: "29px",
                        verticalAlign: "center"
                      });
                    },
                    get children() {
                      return libs.createComponent(EOM_Image.EOM_Image, {
                        get src() {
                          return getPayTypeIconPath(packItemData()?.pay_type ?? 0);
                        },
                        width: "60px",
                        height: "60px",
                        verticalAlign: "center"
                      });
                    }
                  }), libs.createComponent(EOM_Label.EOM_Label, {
                    className: "CostLabel",
                    get text() {
                      return libs.memo(() => !!packItemIsSkinDebris())() ? `${player_token()[packItemData()?.pay_type ?? 0]?.num ?? 0} / ${packItemData()?.real_price}` : packItemData()?.real_price;
                    },
                    html: true
                  })];
                }
              }), libs.createComponent(EOM_Label.EOM_Label, {
                marginLeft: "160px",
                className: "CostDescLabel",
                text: "#Popup_StoreBuyItem_count"
              }), libs.createComponent(libs.Show, {
                get when() {
                  return exchangeShow();
                },
                get children() {
                  return libs.createComponent(EOM_NumberAdjust.EOM_NumberAdjust, {
                    verticalAlign: "center",
                    value: 1,
                    get max() {
                      return getStoreMaxCount(packItemData());
                    },
                    onvaluechanged: self => {
                      setPackItemCount(self.value);
                    },
                    marginLeft: "18px"
                  });
                }
              })];
            }
          }), null);
          libs.insert(_el$5, libs.createComponent(EOM_Panel.EOM_Panel, {
            flowChildren: "right",
            horizontalAlign: "center",
            marginTop: "50px",
            get children() {
              return [libs.createComponent(EOM_Button.EOM_Button, {
                color: "Gray",
                text: "#Popup_Button_Cancel",
                onactivate: () => setExchangeShow(false)
              }), libs.createComponent(EOM_Button.EOM_Button, {
                marginLeft: "110px",
                color: "Gold",
                text: "#Popup_Button_Buy",
                onactivate: () => {
                  const itemData = packItemData();
                  if (itemData) {
                    if (itemData.pay_type == PayType.MOON) {
                      if (getNetDataCache("player_wallet", Players.GetLocalPlayer()).moonstone < itemData.real_price) {
                        setExchangeShow(false);
                        showPopup("StoreBuyItemResult", {
                          result: "failure",
                          reason: "no_enough_moon",
                          group: String(itemData.id)
                        });
                        return;
                      }
                    } else if (itemData.pay_type == PayType.COIN) {
                      if ((getNetDataCache("player_token", Players.GetLocalPlayer())[PayType.COIN]?.num ?? 0) < itemData.real_price) {
                        setExchangeShow(false);
                        showPopup("StoreBuyItemResult", {
                          result: "failure",
                          reason: "no_enough_coin",
                          group: String(itemData.id)
                        });
                        return;
                      }
                    } else if (packItemIsSkinDebris()) {
                      if ((getNetDataCache("player_token", Players.GetLocalPlayer())[itemData.pay_type]?.num ?? 0) < itemData.real_price) {
                        setExchangeShow(false);
                        showPopup("StoreBuyItemResult", {
                          result: "failure",
                          group: String(itemData.id)
                        });
                        return;
                      }
                    }
                    setExchangeShow(false);
                    if (itemData.pay_type == PayType.MONEY) {
                      showPopup("PaymentOrder", {
                        itemData: itemData,
                        count: packItemCount(),
                        group: String(itemData.id)
                      });
                    } else {
                      let PopupID = showPopup("StoreBuyItemResult", {
                        result: "loading",
                        group: String(itemData.id)
                      });
                      serverRequest("product_buy", {
                        product_id: itemData.id,
                        product_num: packItemCount()
                      }, res => {
                        if (res.status == 0) {
                          showPopup("StoreBuyItemResult", {
                            result: "success",
                            PopupID: PopupID,
                            group: String(itemData.id)
                          });
                        } else {
                          showPopup("StoreBuyItemResult", {
                            result: "failure",
                            PopupID: PopupID,
                            group: String(itemData.id)
                          });
                        }
                      });
                    }
                  }
                }
              })];
            }
          }), null);
          libs.insert(_el$8, libs.createComponent(libs.Switch, {
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
          }), _el$9);
          libs.insert(_el$9, libs.createComponent(GenericPanel.CLabel, {
            id: "CosmeticName",
            get text() {
              return '#' + previewID();
            }
          }), null);
          libs.insert(_el$9, libs.createComponent(EOM_Separator.EOM_Separator, {
            size: "short"
          }), null);
          libs.insert(_el$9, libs.createComponent(GenericPanel.CLabel, {
            id: "CosmeticAccess",
            get text() {
              return GetCosmeticAccessDescription(previewID());
            }
          }), null);
          libs.effect(_$p => libs.setProp(_el$, "className", libs.classNames({
            Show: exchangeShow()
          }), _$p));
          return _el$;
        })()];
      }
    });
  }
  const VipPage = () => {
    const [tag, setTag] = libs.createSignal("mounth");
    const tags = ["mounth", "year"];
    const [mounthVipData, setmounthVipData] = libs.createSignal({
      id: 0,
      start_time: 0,
      end_time: 0,
      pay_type: 0,
      order_by: 0,
      overseas_origin_price: 0,
      overseas_real_price: 0,
      russia_origin_price: 0,
      russia_real_price: 0,
      status: 0,
      origin_price: 0,
      real_price: 0,
      discount: 0,
      limit_type: 0,
      limit_count: 0,
      items: [],
      tag: "",
      title: 0,
      img: ""
    });
    const [yearVipData, setyearVipData] = libs.createSignal({
      id: 0,
      start_time: 0,
      end_time: 0,
      pay_type: 0,
      order_by: 0,
      overseas_origin_price: 0,
      overseas_real_price: 0,
      russia_origin_price: 0,
      russia_real_price: 0,
      status: 0,
      origin_price: 0,
      real_price: 0,
      discount: 0,
      limit_type: 0,
      limit_count: 0,
      items: [],
      tag: "",
      title: 0,
      img: ""
    });
    const [playerVipExpire, setPlayerVipExpire] = libs.createSignal(-1);
    libs.onMount(() => {
      let gameEventIDList = [];
      gameEventIDList.push(useNetData("info_shop_product_group_by_tag", data => {
        let lists = handleProduceData(data);
        for (let tag in lists) {
          let itemList = lists[tag];
          for (let itemData of itemList) {
            if (itemData.id == 9900010) {
              setmounthVipData(itemData);
            }
            if (itemData.id == 9900011) {
              setyearVipData(itemData);
            }
          }
        }
      }));
      gameEventIDList.push(useNetData("player_vip", data => {
        if (data.vip_valid == 1) {
          setPlayerVipExpire(data.expire);
        }
      }, Players.GetLocalPlayer()));
      libs.onCleanup(() => {
        for (let id of gameEventIDList) {
          GameEvents.Unsubscribe(id);
        }
      });
    });
    const vipCost = type => {
      if (type == "mounth") {
        return {
          origin_price: mounthVipData().origin_price,
          real_price: mounthVipData().real_price
        };
      }
      return {
        origin_price: yearVipData().origin_price,
        real_price: yearVipData().real_price
      };
    };
    return (() => {
      const _el$17 = libs.createElement("Panel", {
          id: "VipPage"
        }, null),
        _el$18 = libs.createElement("Panel", {
          id: "discount",
          get ["class"]() {
            return tag();
          }
        }, _el$17);
      libs.insert(_el$18, libs.createComponent(GenericPanel.CLabel, {
        "class": "number",
        text: "-20",
        html: true
      }), null);
      libs.insert(_el$18, libs.createComponent(GenericPanel.CLabel, {
        "class": "pct",
        text: "%",
        html: true
      }), null);
      libs.insert(_el$17, libs.createComponent(libs.For, {
        each: tags,
        children: p => {
          const buttonData = libs.createMemo(() => StoreItem.getButtonData(p == "mounth" ? mounthVipData() : yearVipData()));
          return [(() => {
            const _el$19 = libs.createElement("Panel", {
              id: "tab_" + p
            }, null);
            libs.setProp(_el$19, "id", "tab_" + p);
            libs.setProp(_el$19, "onactivate", () => {
              setTag(p);
            });
            libs.insert(_el$19, libs.createComponent(GenericPanel.CLabel, {
              text: "#vip_" + p
            }));
            libs.effect(_$p => libs.setProp(_el$19, "className", libs.classNames("tab", {
              "selected": p == tag()
            }, $.Language().toLowerCase()), _$p));
            return _el$19;
          })(), (() => {
            const _el$20 = libs.createElement("Panel", {
                id: "vip_" + p
              }, null),
              _el$21 = libs.createElement("Panel", {
                "class": "PrivilegeList"
              }, _el$20);
            libs.setProp(_el$20, "id", "vip_" + p);
            libs.insert(_el$20, libs.createComponent(GenericPanel.CLabel, {
              get className() {
                return libs.classNames("vipTitle", $.Language().toLowerCase());
              },
              text: "#vip_" + p
            }), _el$21);
            libs.insert(_el$20, libs.createComponent(EOM_Button.EOM_Button, {
              get ["class"]() {
                return libs.classNames("BuyBtn", {
                  discount: vipCost(p).real_price < vipCost(p).origin_price
                });
              },
              color: "Blue",
              onactivate: () => {
                showPopup("StoreBuyItem", {
                  itemData: p == "mounth" ? mounthVipData() : yearVipData(),
                  group: "StoreBuyItem"
                });
              },
              get children() {
                return [libs.createComponent(EOM_Panel.EOM_Panel, {
                  id: "real_price",
                  align: "center center",
                  flowChildren: "right",
                  get children() {
                    return [libs.createComponent(libs.Show, {
                      get when() {
                        return buttonData()?.icon != undefined;
                      },
                      get children() {
                        return libs.children(() => buttonData().icon)();
                      }
                    }), libs.createComponent(GenericPanel.CLabel, {
                      get text() {
                        return vipCost(p).real_price;
                      }
                    })];
                  }
                }), libs.createComponent(GenericPanel.CLabel, {
                  id: "origin_price",
                  get text() {
                    return " " + vipCost(p).origin_price + " ";
                  }
                })];
              }
            }), _el$21);
            libs.insert(_el$20, libs.createComponent(GenericPanel.CLabel, {
              get className() {
                return libs.classNames("LeftTitle", $.Language().toLowerCase());
              },
              text: "#vip_" + p
            }), _el$21);
            libs.insert(_el$21, libs.createComponent(libs.For, {
              get each() {
                return [...Array(6)].map((v, i) => i).sort((a, b) => (a == 4 ? 1 : 0) - (b == 4 ? 1 : 0));
              },
              children: (i, index) => {
                return (() => {
                  const _el$23 = libs.createElement("Panel", {}, null),
                    _el$24 = libs.createElement("Panel", {
                      "class": "line"
                    }, _el$23);
                    libs.createElement("Image", {}, _el$24);
                  libs.insert(_el$24, libs.createComponent(GenericPanel.CLabel, {
                    text: "#vip_privilege_" + p + i,
                    html: true
                  }), null);
                  libs.insert(_el$23, libs.createComponent(libs.Show, {
                    get when() {
                      return index() != 5;
                    },
                    get children() {
                      return libs.createElement("Image", {
                        "class": "div"
                      }, null);
                    }
                  }), null);
                  libs.effect(_$p => libs.setProp(_el$23, "className", libs.classNames("privilege", $.Language().toLowerCase()), _$p));
                  return _el$23;
                })();
              }
            }));
            libs.insert(_el$20, libs.createComponent(libs.Show, {
              get when() {
                return playerVipExpire() != -1;
              },
              get children() {
                return libs.createComponent(EOM_Countdown.EOM_Countdown, {
                  id: "remain",
                  get className() {
                    return $.Language().toLowerCase();
                  },
                  get endTime() {
                    return playerVipExpire();
                  },
                  text: "#vip_remain"
                });
              }
            }), null);
            libs.insert(_el$20, libs.createComponent(libs.Show, {
              when: p == "year",
              get children() {
                const _el$22 = libs.createElement("Panel", {
                  id: "year_discount"
                }, null);
                libs.insert(_el$22, libs.createComponent(GenericPanel.CLabel, {
                  id: "number",
                  text: "20",
                  html: true
                }), null);
                libs.insert(_el$22, libs.createComponent(GenericPanel.CLabel, {
                  id: "pct",
                  text: "%",
                  html: true
                }), null);
                libs.insert(_el$22, libs.createComponent(GenericPanel.CLabel, {
                  id: "off",
                  text: "OFF",
                  html: true
                }), null);
                return _el$22;
              }
            }), null);
            libs.effect(_$p => libs.setProp(_el$20, "className", libs.classNames("vip", {
              "show": p == tag()
            }), _$p));
            return _el$20;
          })()];
        }
      }), null);
      libs.effect(_$p => libs.setProp(_el$18, "class", tag(), _$p));
      return _el$17;
    })();
  };
  const MustPage = props => {
    const [recommendDrawList, setRecommendDrawList] = libs.createSignal([]);
    const info_box_content = netdata_utils.createNetData("info_box_content", {});
    const info_box_pool_data = netdata_utils.createNetData("info_box_pool_data", []);
    libs.createEffect(libs.on([info_box_content, info_box_pool_data], ([content, pool]) => {
      const drawPoolList = [];
      const poolInfoRecord = {};
      const timeStamp = Math.floor(Date.now() / 1000);
      const _poolData = info_box_pool_data();
      const _boxContent = info_box_content();
      if (_poolData.length > 0 && Object.keys(_boxContent).length > 0) {
        _poolData.forEach((data, index) => {
          const endTime = data.end_time.toString();
          const startTime = data.start_time;
          let bid = data.bid;
          const nEndTime = Number(endTime);
          const nStartTime = Number(startTime);
          if (bid != -1 && (nStartTime == 0 || timeStamp >= Number(nStartTime)) && (nEndTime == 0 || timeStamp < Number(endTime))) {
            if (data.drop_content && _boxContent[data.drop_content]) {
              _boxContent[data.drop_content].forEach(v => {
                let type = v.item_id.toString().slice(0, 3);
                if (type == "510" || type == "520") {
                  const path = `file://{images}/custom_game/store/must/${v.item_id}/bg.png`;
                  if ($.BImageFileExists(path)) {
                    drawPoolList.push(v.item_id);
                    poolInfoRecord[v.item_id] = data.pool;
                    return;
                  }
                }
              });
            }
          }
        });
      }
      setRecommendDrawList(drawPoolList);
    }));
    const dateNow = Math.floor(Date.now() / 1000);
    const cosmeticItemTimeConfig = {
      [5100051]: {
        start_time: 0,
        end_time: 1764259200,
        sort: 242
      },
      [5100044]: {
        start_time: 1761753600,
        end_time: 1764259200,
        sort: 241
      },
      [5100054]: {
        start_time: 1761044934,
        end_time: 1764259200,
        sort: 242
      },
      [5100055]: {
        start_time: 1764259200,
        end_time: 1766505600,
        sort: 243
      },
      [5100056]: {
        start_time: 1766505600,
        end_time: 1769702400,
        sort: 244
      },
      [5100059]: {
        start_time: 1766505600,
        end_time: 1772121600,
        sort: 245
      },
      [5203042]: {
        start_time: 1766505600,
        end_time: 1772121600,
        sort: 246
      },
      [5100060]: {
        start_time: 1766505600,
        end_time: 1772121600,
        sort: 247
      },
      [5100061]: {
        start_time: 1772121600,
        end_time: 1774540800,
        sort: 248
      },
      [5100069]: {
        start_time: 0,
        end_time: 1782403200,
        sort: 249
      }
    };
    let defualtCosmeticItemList = {};
    Object.keys(cosmeticItemTimeConfig).forEach(v => {
      const config = cosmeticItemTimeConfig[Number(v)];
      if (dateNow > config.start_time && config.end_time > 0 && dateNow < config.end_time) {
        defualtCosmeticItemList[Number(v)] = 2;
      }
    });
    const purchased_product = () => props.purchased_product;
    const playerOrnament = () => props.playerOrnament;
    const playerHeroes = () => props.player_hero;
    const getProp = (id, type) => {
      if (itemDataList()[id]) {
        const itemData = itemDataList()[id];
        return {
          type,
          store_id: itemData.id,
          ...StoreItem.getStoreItemProps({
            itemData: itemData,
            purchased_num: purchased_product()?.[itemData.id],
            playerOrnament: playerOrnament(),
            playerHeroes: playerHeroes()
          })
        };
      }
      return {
        type,
        store_id: id,
        ...getCosmeticItemProps({
          item_id: id,
          playerOrnament: playerOrnament(),
          playerHeroes: playerHeroes()
        })
      };
    };
    const language = $.Language().toLowerCase();
    const defaultSortOrderby = {
      [9900508]: 124,
      [9900507]: 123,
      [9900504]: 122,
      [9900503]: 121,
      [9900502]: 120,
      [9900501]: 119,
      [9900500]: 118,
      [9900296]: 117,
      [9900295]: 116,
      [9900294]: 115,
      [9900293]: 114,
      [9900292]: 113,
      [9900290]: 112,
      [9900289]: 111,
      [9900239]: 100,
      [9900225]: 86,
      [9900222]: 70
    };
    const itemSizeMap = libs.createMemo(() => {
      const map = {};
      props.itemList.forEach(item => {
        map[item.id] = JSON.parseSafe(item.img)?.size ?? 2;
      });
      return map;
    });
    const playerHeroIDSet = libs.createMemo(() => new Set(Object.keys(playerHeroes() ?? {})));
    const playerOrnamentIDSet = libs.createMemo(() => new Set(Object.keys(playerOrnament() ?? {})));
    const recommendDrawRank = libs.createMemo(() => {
      const rank = {};
      recommendDrawList().forEach((id, index) => {
        rank[id] = index;
      });
      return rank;
    });
    const defaultCosmeticIDList = Object.keys(defualtCosmeticItemList).map(v => Number(v));
    const ownedList = libs.createMemo(() => {
      const list = {};
      const itemSizes = itemSizeMap();
      const heroes = playerHeroIDSet();
      const ornaments = playerOrnamentIDSet();
      let smallAllSlotOut = props.itemList.filter(item => itemSizes[item.id] == 1).every(item => {
        let enable = item.status == 1 && (item.limit_type >= 1 ? finiteNumber(Number(purchased_product()?.[item.id] ?? 0)) < item.limit_count : true);
        return !enable || getCosmeticByStoreItem(item, playerOrnament()) || getHerobyStoreItem(item, playerHeroes()) ? 1 : 0;
      });
      props.itemList.forEach(item => {
        let enable = item.status == 1 && (item.limit_type >= 1 ? finiteNumber(Number(purchased_product()?.[item.id] ?? 0)) < item.limit_count : true);
        if (itemSizes[item.id] == 1) {
          list[item.id] = smallAllSlotOut ? 1 : 0;
        } else {
          list[item.id] = !enable || getCosmeticByStoreItem(item, playerOrnament()) || getHerobyStoreItem(item, playerHeroes()) ? 1 : 0;
        }
      });
      recommendDrawList().forEach(key => {
        let id = key.toString();
        if (id.startsWith("3")) {
          if (heroes.has(id)) {
            list[Number(id)] = 1;
          }
        } else if (id.startsWith("5")) {
          if (ornaments.has(id)) {
            list[Number(id)] = 1;
          }
        }
      });
      Object.keys(defualtCosmeticItemList).forEach(id => {
        if (id.startsWith("3")) {
          if (heroes.has(id)) {
            list[Number(id)] = 1;
          }
        } else if (id.startsWith("5")) {
          if (ornaments.has(id)) {
            list[Number(id)] = 1;
          }
        }
      });
      return list;
    });
    const sortedIDList = libs.createMemo(() => {
      let list = defaultCosmeticIDList.slice();
      list = list.concat(props.itemList.map(v => v.id));
      list = list.concat(recommendDrawList());
      const owned = ownedList();
      const recommendRank = recommendDrawRank();
      let orderby_a = 0;
      let orderby_b = 0;
      return list.sort((a, b) => {
        orderby_a = cosmeticItemTimeConfig?.[a]?.sort ?? defaultSortOrderby[a] ?? 0;
        orderby_b = cosmeticItemTimeConfig?.[b]?.sort ?? defaultSortOrderby[b] ?? 0;
        return multiCompare((owned[a] ?? 0) - (owned[b] ?? 0), (recommendRank[b] ?? -1) - (recommendRank[a] ?? -1), orderby_b - orderby_a, b - a);
      });
    });
    const itemDataList = libs.createMemo(() => {
      const data = {};
      props.itemList.forEach(v => {
        data[v.id] = v;
      });
      return data;
    });
    return (() => {
      const _el$27 = libs.createElement("Panel", {
          id: "MustPage"
        }, null),
        _el$28 = libs.createElement("Panel", {
          id: "MustTitle"
        }, _el$27);
      libs.setProp(_el$28, "className", language);
      libs.insert(_el$27, libs.createComponent(EOM_Panel.EOM_Panel, {
        id: "ItemList",
        scroll: "x",
        get children() {
          return libs.createComponent(libs.Index, {
            get each() {
              return sortedIDList();
            },
            children: (id, index) => {
              const size = libs.createMemo(() => {
                const _size = itemSizeMap()[id()] ?? defualtCosmeticItemList[id()] ?? 2;
                if (_size == 1) {
                  return "small";
                }
                return "big";
              });
              return (libs.createComponent(StoreItem.SpecialItem, libs.mergeProps({
                  get markType() {
                    return red_point_utils.hasRedPoint(props.redPoints, "store", "Must", id()) ? "default" : undefined;
                  }
                }, () => getProp(id(), size())))
              );
            }
          });
        }
      }), null);
      return _el$27;
    })();
  };
  libs.render(() => libs.createComponent(Store, {}), $.GetContextPanel());
}