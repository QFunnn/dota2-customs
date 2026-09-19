--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const combatToastManager = $("#CombatNotificationToastManager");
const monsterNotificationContainer = $("#MonsterNotificationContianer");
const pvpLoseNotificationContainer = $("#PvPLoseNotificationContianer");
const UPPER_NOTIFICATION_TIME = 5.0;
const CHAT_LINE_TIME = 7.0;
let combatEvents;
let chatLinesPanel = null;
function updateSingleAction(action) {
    action.start();
    const callback = () => {
        if (!action.update()) {
            action.finish();
        }
        $.Schedule(Game.GetGameFrameTime(), callback);
    };
    callback();
}
function replaceHeroIcon(panel, playerId) {
    $.Schedule(0, () => {
        var _a;
        const label = panel.FindChildTraverse("NotificationLabel");
        const heroIconPanels = (_a = label === null || label === void 0 ? void 0 : label.FindChildrenWithClassTraverse("CombatEventHeroPlayer_" + playerId)) !== null && _a !== void 0 ? _a : [];
        for (const heroIconPanel of heroIconPanels) {
            const playerInfo = Game.GetPlayerInfo(playerId);
            const hero = Entities.GetUnitName(Players.GetPlayerHeroEntityIndex(playerId));
            heroIconPanel.RemoveClass("CombatEventHeroPlayer_" + playerId);
            heroIconPanel.BLoadLayoutSnippet("CombatEventHeroIcon");
            if (playerInfo) {
                const heroImage = heroIconPanel.FindChildTraverse("PlayerHeroImage");
                if (heroImage) {
                    heroImage.heroname = hero;
                }
            }
        }
    });
}
function replaceItemIcon(panel, itemName) {
    $.Schedule(0, () => {
        var _a;
        const label = panel.FindChildTraverse("NotificationLabel");
        const itemIconPanels = (_a = label === null || label === void 0 ? void 0 : label.FindChildrenWithClassTraverse("CombatEventItem_" + itemName)) !== null && _a !== void 0 ? _a : [];
        for (const itemIconPanel of itemIconPanels) {
            itemIconPanel.RemoveClass("CombatEventItem_" + itemName);
            itemIconPanel.AddClass("CombatEventItemIcon");
            const itemImage = $.CreatePanel("DOTAItemImage", itemIconPanel, "ItemImage");
            itemImage.itemname = itemName;
        }
    });
}
function createNotification(tParams, parent, id) {
    var _a;
    const localPlayerID = Players.GetLocalPlayer();
    const panel = $.CreatePanel("Panel", parent, id);
    panel.BLoadLayoutSnippet("Notification");
    if (typeof tParams.player_id === "number" && Players.IsValidPlayerID(tParams.player_id)) {
        const playerName = Players.GetPlayerName(tParams.player_id);
        const playerColor = intToARGB(Players.GetPlayerColor(tParams.player_id));
        panel.SetDialogVariable("player_name", "<panel class='CombatEventHeroIcon CombatEventHeroPlayer_" + tParams.player_id + "' />" +
            "<font color='#" + playerColor + "'>" + playerName + "</font>");
        replaceHeroIcon(panel, tParams.player_id);
        panel.SetHasClass("LocalPlayerInvolved", tParams.player_id === localPlayerID);
        delete tParams.player_id;
    }
    if (typeof tParams.player_id2 === "number") {
        const playerName = Players.GetPlayerName(tParams.player_id2);
        const playerColor = intToARGB(Players.GetPlayerColor(tParams.player_id2));
        panel.SetDialogVariable("player_name2", "<panel class='CombatEventPlayerIcon CombatEventHeroPlayer_" + tParams.player_id2 + "' />" +
            "<font color='#" + playerColor + "'>" + playerName + "</font>");
        replaceHeroIcon(panel, tParams.player_id2);
        panel.SetHasClass("LocalPlayerInvolved", tParams.player_id2 === localPlayerID);
        delete tParams.player_id2;
    }
    if (typeof tParams.teamnumber === "number" && tParams.teamnumber !== -1) {
        if (Players.GetTeam(localPlayerID) === tParams.teamnumber) {
            panel.SetHasClass("AllyEvent", true);
        }
        else {
            panel.SetHasClass("EnemyEvent", true);
        }
        delete tParams.teamnumber;
    }
    for (const key in tParams) {
        const value = tParams[key];
        if (key.indexOf("b_int") !== -1) {
            panel.SetDialogVariable(key, String(formatNumByLanguage(value)));
        }
        else if (key.indexOf("int_") !== -1) {
            panel.SetDialogVariableInt(key, value);
        }
        else if (key.indexOf("string_") !== -1) {
            const localized = $.Localize("#" + value);
            panel.SetDialogVariable(key, localized === "#" + value ? String(value) : localized);
            if (key.indexOf("itemname") !== -1) {
                panel.SetDialogVariable(key, "<panel class='CombatEventItemIcon CombatEventItem_" + value + "' />" +
                    $.Localize("#DOTA_Tooltip_Ability_" + value));
                replaceItemIcon(panel, value);
            }
        }
    }
    const notificationLabel = panel.FindChildTraverse("NotificationLabel");
    if (notificationLabel) {
        const message = (_a = tParams.message) !== null && _a !== void 0 ? _a : "";
        notificationLabel.html = true;
        notificationLabel.text = $.Localize("#" + message, panel) === "#" + message ? message : $.Localize("#" + message, panel);
    }
    return panel;
}
const upperNotificationSeq = new RunSequentialActions();
function upperNotification(tParams) {
    upperNotificationSeq.actions.push(new RunFunctionAction(() => {
        createNotification(tParams, $("#UpperNotificationContianer"), "UpperNotificationPanel");
        $("#UpperNotificationContianer").AddClass("PopOut");
    }));
    upperNotificationSeq.actions.push(new WaitAction(UPPER_NOTIFICATION_TIME));
    upperNotificationSeq.actions.push(new RunFunctionAction(() => {
        $("#UpperNotificationContianer").RemoveAndDeleteChildren();
        $("#UpperNotificationContianer").RemoveClass("PopOut");
    }));
}
function queueCombatNotification(tParams, parent) {
    const panel = $.CreatePanel("Panel", parent, "");
    createNotification(tParams, panel, "");
    panel.AddClass("Combat");
    const iconPanel = $.CreatePanel("Image", panel, "");
    iconPanel.AddClass("CombatIcon");
    if (tParams.panorama_class) {
        panel.AddClass(tParams.panorama_class);
    }
    combatToastManager.QueueToast(panel);
}
function onNotificationUpper(tParams) {
    tParams.teamnumber = undefined;
    upperNotification(tParams);
}
function onNotificationCombat(tParams) {
    queueCombatNotification(tParams, combatToastManager);
}
function onNotificationMonster(tParams) {
    queueCombatNotification(tParams, monsterNotificationContainer);
}
function onNotificationPvPLose(tParams) {
    queueCombatNotification(tParams, pvpLoseNotificationContainer);
}
function onNotificationPvELose(tParams) {
    queueCombatNotification(tParams, pvpLoseNotificationContainer);
}
function onNotificationOpenGift(tParams) {
    queueCombatNotification(tParams, pvpLoseNotificationContainer);
}
function onNotificationChatLine(tParams) {
    if (chatLinesPanel == null) {
        return;
    }
    const localPlayerID = Players.GetLocalPlayer();
    if (tParams.player_id === undefined || tParams.player_id === null) {
        return;
    }
    if (Players.GetTeam(localPlayerID) !== Players.GetTeam(tParams.player_id) && !Players.IsSpectator(localPlayerID)) {
        return;
    }
    const label = $.CreatePanel("Label", chatLinesPanel, "");
    label.AddClass("ChatLine");
    label.html = true;
    label.hittest = false;
    label.hittestchildren = false;
    if (tParams.team_only === 1) {
        label.SetDialogVariable("target", $.Localize("#DOTA_ChatTarget_GameAllies"));
        label.SetDialogVariable("sender_class", "GameAlliesChat");
    }
    else {
        label.SetDialogVariable("target", $.Localize("#DOTA_ChatTarget_GameAll"));
        label.SetDialogVariable("sender_class", "GameAllChat");
    }
    const playerInfo = Game.GetPlayerInfo(tParams.player_id);
    label.SetDialogVariable("hero_badge_icon", "<panel class='HeroBadge'/>");
    label.SetDialogVariable("hero_icon", "<img class='HeroIcon' src='file://{images}/heroes/" + playerInfo.player_selected_hero + ".png'>");
    label.SetDialogVariable("player_color_class", "PlayerColor" + tParams.player_id);
    label.SetDialogVariable("event_crest", "");
    label.SetDialogVariable("battle_cup_icon", "");
    label.SetDialogVariable("new_player_icon", "");
    label.SetDialogVariable("persona", playerInfo.player_name);
    let message = "";
    if (tParams.message !== undefined && tParams.message !== null) {
        for (const key in tParams) {
            const value = tParams[key];
            if (key.indexOf("b_int_") !== -1) {
                label.SetDialogVariable(key, String(formatNumByLanguage(value)));
            }
            else if (key.indexOf("int_") !== -1) {
                label.SetDialogVariableInt(key, value);
            }
            else if (key.indexOf("string_") !== -1) {
                const localized = $.Localize("#" + value);
                label.SetDialogVariable(key, localized === "#" + value ? String(value) : localized);
            }
        }
        message = $.Localize("#" + tParams.message, label) === "#" + tParams.message ? tParams.message : $.Localize("#" + tParams.message, label);
    }
    label.SetDialogVariable("message", message);
    let text = $.Localize("#DOTA_ChatMessage_HudAll", label);
    if (tParams.team_only === 1) {
        text = $.Localize("#DOTA_ChatMessage_Hud", label);
    }
    label.text = text;
    const time = Game.Time() + CHAT_LINE_TIME;
    const removeExpiredClass = () => {
        label.RemoveClass("Expired");
        if (Game.Time() < time) {
            $.Schedule(Game.GetGameFrameTime(), removeExpiredClass);
        }
    };
    removeExpiredClass();
    Game.EmitSound("Chat.Team.Received");
    if (tParams.player_id === localPlayerID) {
        Game.EmitSound("ui_chat_msg_send");
    }
}
function update() {
    $.Schedule(Game.GetGameFrameTime(), update);
    if (combatEvents) {
        $("#CombatNotificationContianer").SetHasClass("RevealCollapsed", combatEvents.BHasClass("RevealCollapsed"));
    }
}
(() => {
    var _a, _b, _c, _d, _e, _f;
    const hud = (_c = (_b = (_a = $.GetContextPanel()) === null || _a === void 0 ? void 0 : _a.GetParent()) === null || _b === void 0 ? void 0 : _b.GetParent()) === null || _c === void 0 ? void 0 : _c.GetParent();
    if (hud != null) {
        combatEvents = (_d = hud.FindChildTraverse("combat_events")) !== null && _d !== void 0 ? _d : undefined;
        chatLinesPanel = (_f = (_e = hud.FindChildTraverse("HudChat")) === null || _e === void 0 ? void 0 : _e.FindChildTraverse("ChatLinesPanel")) !== null && _f !== void 0 ? _f : null;
    }
    update();
    updateSingleAction(upperNotificationSeq);
    GameEvents.Subscribe("notification_upper", onNotificationUpper);
    GameEvents.Subscribe("notification_combat", onNotificationCombat);
    GameEvents.Subscribe("notification_chat_line", onNotificationChatLine);
    GameEvents.Subscribe("ExtraCreatureAdded", onNotificationMonster);
    GameEvents.Subscribe("PlayerLosePvP", onNotificationPvPLose);
    GameEvents.Subscribe("PlayerLosePvE", onNotificationPvELose);
    GameEvents.Subscribe("OpenSurpriseGift", onNotificationOpenGift);
})();