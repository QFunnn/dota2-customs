--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const require = GameUI.__require;

var libs = require('./libs.js');
var CosmeticCard = require('./CosmeticCard.js');
var EOM_Panel = require('./EOM_Panel.js');
var GenericPanel = require('./GenericPanel.js');
var Player = require('./Player.js');
var ProductImage = require('./ProductImage.js');
require('./EOM_Countdown.js');
require('./EOM_Label.js');
require('./EOM_Button.js');
require('./EOM_Icon.js');
require('./EOM_Image.js');

const Message = () => {
  const [messageList, setMessageList] = libs.createSignal([]);
  const [addItemList, setAddItemList] = libs.createSignal([]);
  const Update = () => {
    let nextList = [];
    messageList().forEach((message, index) => {
      if (message.duration > 0) {
        message.duration -= Game.GetGameFrameTime();
        nextList.push(message);
      }
    });
    setMessageList(nextList);
    let nextAddItemList = [];
    addItemList().forEach((message, index) => {
      if (message.duration > 0) {
        message.duration -= Game.GetGameFrameTime();
        nextAddItemList.push(message);
      }
    });
    setAddItemList(nextAddItemList);
  };
  const onMessage = event => {
    setMessageList([...messageList(), {
      message: event.message ?? "",
      duration: event.duration ?? 3
    }]);
  };
  const onNotifyCombat = event => {
    clientSideEvent("notify_combat", event);
    let dialogVariables = {};
    const params = {
      message: event.message ? "#" + event.message : "",
      duration: event.duration ?? 3
    };
    let hasPercentage = false;
    let valueKey = "";
    for (const key in event) {
      const value = event[key];
      if (key == "player_id" && typeof value == "number") {
        params.player_id = value;
      } else if (key.includes("string")) {
        if (key == "string_attribute" && value.startsWith("dota_tooltip_item_variable_item_")) {
          let textKey = $.Localize("#" + value).replace(/[+]/g, '');
          hasPercentage = textKey[0] == "%";
          if (hasPercentage) {
            textKey = textKey.slice(1);
          }
          dialogVariables[key] = replaceAll(textKey);
        } else {
          if ($.Localize("#" + value) == "#" + value) {
            valueKey = key;
            dialogVariables[key] = value;
          } else {
            dialogVariables[key] = $.Localize("#" + value);
          }
        }
      } else if (key.includes("int")) {
        dialogVariables[key] = value;
      } else if (key.includes("day")) {
        let diff = Math.floor(value - Date.now() / 1000);
        let days = Math.max(0, Math.floor(diff / 86400));
        dialogVariables[key] = days;
      }
    }
    if (hasPercentage && valueKey != "" && dialogVariables[valueKey]) {
      dialogVariables[valueKey] = dialogVariables[valueKey] + "%";
    }
    params.dialogVariables = dialogVariables;
    setMessageList([...messageList(), params]);
  };
  const onAddItem = data => {
    const formatData = JSON.parse(data.json);
    const newList = [];
    if (formatData != undefined) {
      for (const itemData of formatData) {
        newList.push({
          itemID: itemData.itemId,
          duration: 4,
          amounts: itemData.amounts,
          exp: itemData.exp == 1
        });
      }
    }
    setAddItemList(addItemList().concat(newList));
  };
  libs.onMount(() => {
    const timer = setInterval(Update, Game.GetGameFrameTime());
    const eventIDList = [];
    const netTableListenerIDs = [];
    eventIDList.push(useClientSideEvent("message", onMessage));
    eventIDList.push(GameEvents.Subscribe("notification_combat", onNotifyCombat));
    eventIDList.push(GameEvents.Subscribe("ReceiveRewards", onAddItem));
    eventIDList.push(GameEvents.Subscribe("client_side_event", eventData => {
      if (eventData.event_name == "client_ReceiveRewards") {
        onAddItem(eventData);
      }
    }));
    libs.onCleanup(() => {
      eventIDList.forEach(id => {
        GameEvents.Unsubscribe(id);
      });
      netTableListenerIDs.forEach(id => CustomNetTables.UnsubscribeNetTableListener(id));
      clearInterval(timer);
    });
  });
  return (() => {
    const _el$ = libs.createElement("Panel", {
        id: "MessageMain",
        hittest: false
      }, null),
      _el$2 = libs.createElement("Panel", {
        id: "MessageList",
        hittest: false
      }, _el$),
      _el$3 = libs.createElement("Panel", {
        id: "AddItemList",
        hittest: false
      }, _el$);
    libs.insert(_el$2, libs.createComponent(libs.For, {
      get each() {
        return messageList();
      },
      children: (message, i) => libs.createComponent(EOM_Panel.EOM_Panel, {
        className: "Message",
        get style() {
          return {
            animationDelay: `0s, ${message.duration - 0.3}s`
          };
        },
        get children() {
          return [libs.createComponent(libs.Show, {
            get when() {
              return message.player_id != undefined;
            },
            get children() {
              return libs.createComponent(EOM_Panel.EOM_Panel, {
                className: "MessagePlayer",
                get children() {
                  return [libs.createComponent(Player.PlayerAvatar, {
                    get playerID() {
                      return message.player_id;
                    },
                    get steamID() {
                      return getPlayerData(message.player_id, "steamID");
                    },
                    get ban() {
                      return isNameBan(message.player_id);
                    }
                  }), libs.createComponent(Player.PlayerName, {
                    get playerID() {
                      return message.player_id;
                    },
                    get steamID() {
                      return getPlayerData(message.player_id, "steamID");
                    },
                    get ban() {
                      return isNameBan(message.player_id);
                    }
                  })];
                }
              });
            }
          }), libs.createComponent(GenericPanel.CLabel, {
            html: true,
            className: "MessageLabel",
            get text() {
              return message.message;
            },
            get dialogVariables() {
              return message.dialogVariables;
            },
            onload: self => {
              self.ScrollParentToMakePanelFit(2, false);
            }
          })];
        }
      })
    }));
    libs.insert(_el$3, libs.createComponent(libs.For, {
      get each() {
        return addItemList();
      },
      children: (addItemData, i) => (() => {
        const _el$4 = libs.createElement("Panel", {}, null),
          _el$5 = libs.createElement("Panel", {}, _el$4),
          _el$6 = libs.createElement("Image", {}, _el$5),
          _el$7 = libs.createElement("Image", {}, _el$5);
        libs.setProp(_el$4, "className", "AddItemRow");
        libs.setProp(_el$4, "onload", self => {
          self.ScrollParentToMakePanelFit(2, false);
        });
        libs.setProp(_el$5, "className", "ItemImage");
        libs.setProp(_el$6, "className", "ItemRarityBG");
        libs.setProp(_el$7, "className", "ItemBG");
        libs.insert(_el$5, libs.createComponent(ProductImage.ProductImage, {
          get itemid() {
            return addItemData.itemID.toString();
          }
        }), null);
        libs.insert(_el$5, libs.createComponent(CosmeticCard.CosmeticImage, {
          get itemid() {
            return addItemData.itemID.toString();
          }
        }), null);
        libs.insert(_el$4, libs.createComponent(GenericPanel.CLabel, {
          className: "ItemName",
          get text() {
            return $.Localize("#" + addItemData.itemID) + (addItemData.amounts > 1 ? "×" + addItemData.amounts : "") + (addItemData.exp ? $.Localize("#experience") : "");
          },
          html: true
        }), null);
        return _el$4;
      })()
    }));
    return _el$;
  })();
};
libs.render(() => libs.createComponent(Message, {}), $.GetContextPanel());