--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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

const AddItemAnimationInterval = 0.2;
const MessageAnimationInterval = 0.03;
const getToastManager = id => {
  const panel = $(`#${id}`);
  return panel != undefined && panel.IsValid() ? panel : undefined;
};
const Message = () => {
  const messageQueue = [];
  const addItemQueue = [];
  let messageTimer;
  let addItemTimer;
  const showNextMessage = () => {
    const toastManager = getToastManager("MessageToast");
    if (toastManager == undefined) {
      return;
    }
    const message = messageQueue.shift();
    if (message == undefined) {
      return;
    }
    const panel = $.CreatePanel("Panel", toastManager, "");
    libs.insert(panel, libs.createComponent(EOM_Panel.EOM_Panel, {
      className: "Message",
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
          }
        })];
      }
    }));
    toastManager.QueueToast(panel);
  };
  const drainMessageQueue = () => {
    if (messageQueue.length == 0) {
      if (messageTimer != undefined) {
        clearInterval(messageTimer);
        messageTimer = undefined;
      }
      return;
    }
    showNextMessage();
  };
  const queueMessage = message => {
    messageQueue.push(message);
    if (messageTimer == undefined) {
      drainMessageQueue();
      messageTimer = setInterval(drainMessageQueue, MessageAnimationInterval * 1000);
    }
  };
  const showNextAddItem = () => {
    const toastManager = getToastManager("AddItemToast");
    if (toastManager == undefined) {
      return;
    }
    const addItemData = addItemQueue.shift();
    if (addItemData == undefined) {
      return;
    }
    const panel = $.CreatePanel("Panel", toastManager, "");
    libs.insert(panel, (() => {
      const _el$ = libs.createElement("Panel", {}, null),
        _el$2 = libs.createElement("Panel", {}, _el$),
        _el$3 = libs.createElement("Image", {}, _el$2),
        _el$4 = libs.createElement("Image", {}, _el$2);
      libs.setProp(_el$, "className", "AddItemRow");
      libs.setProp(_el$2, "className", "ItemImage");
      libs.setProp(_el$3, "className", "ItemRarityBG");
      libs.setProp(_el$4, "className", "ItemBG");
      libs.insert(_el$2, libs.createComponent(ProductImage.ProductImage, {
        get itemid() {
          return addItemData.itemID.toString();
        }
      }), null);
      libs.insert(_el$2, libs.createComponent(CosmeticCard.CosmeticImage, {
        get itemid() {
          return addItemData.itemID.toString();
        }
      }), null);
      libs.insert(_el$, libs.createComponent(GenericPanel.CLabel, {
        className: "ItemName",
        get text() {
          return $.Localize("#" + addItemData.itemID) + (addItemData.amounts > 1 ? "×" + addItemData.amounts : "") + (addItemData.exp ? $.Localize("#experience") : "");
        },
        html: true
      }), null);
      return _el$;
    })());
    toastManager.QueueToast(panel);
  };
  const drainAddItemQueue = () => {
    if (addItemQueue.length == 0) {
      if (addItemTimer != undefined) {
        clearInterval(addItemTimer);
        addItemTimer = undefined;
      }
      return;
    }
    showNextAddItem();
  };
  const onMessage = event => {
    queueMessage({
      message: event.message ?? ""
    });
  };
  const onNotifyCombat = event => {
    clientSideEvent("notify_combat", event);
    const dialogVariables = {};
    const params = {
      message: event.message ? "#" + event.message : ""
    };
    let hasPercentage = false;
    let valueKey = "";
    for (const key in event) {
      const value = event[key];
      if (key == "player_id" && typeof value == "number") {
        params.player_id = value;
      } else if (key.includes("string")) {
        if (key == "string_attribute" && value.startsWith("dota_tooltip_item_variable_item_")) {
          let textKey = $.Localize("#" + value).replace(/[+]/g, "");
          hasPercentage = textKey[0] == "%";
          if (hasPercentage) {
            textKey = textKey.slice(1);
          }
          dialogVariables[key] = replaceAll(textKey);
        } else if ($.Localize("#" + value) == "#" + value) {
          valueKey = key;
          dialogVariables[key] = value;
        } else {
          dialogVariables[key] = $.Localize("#" + value);
        }
      } else if (key.includes("int")) {
        dialogVariables[key] = value;
      } else if (key.includes("day")) {
        const diff = Math.floor(value - Date.now() / 1000);
        dialogVariables[key] = Math.max(0, Math.floor(diff / 86400));
      }
    }
    if (hasPercentage && valueKey != "" && dialogVariables[valueKey]) {
      dialogVariables[valueKey] = dialogVariables[valueKey] + "%";
    }
    params.dialogVariables = dialogVariables;
    queueMessage(params);
  };
  const onAddItem = data => {
    const formatData = JSON.parse(data.json);
    if (formatData == undefined) {
      return;
    }
    for (const itemData of formatData) {
      addItemQueue.push({
        itemID: itemData.itemId,
        amounts: itemData.amounts,
        exp: itemData.exp == 1
      });
    }
    if (addItemTimer == undefined) {
      drainAddItemQueue();
      addItemTimer = setInterval(drainAddItemQueue, AddItemAnimationInterval * 1000);
    }
  };
  libs.onMount(() => {
    const eventIDList = [];
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
      if (addItemTimer != undefined) {
        clearInterval(addItemTimer);
      }
      if (messageTimer != undefined) {
        clearInterval(messageTimer);
      }
    });
  });
};
Message();