--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function getSteamId32(playerId) {
    return Number(Game.GetPlayerInfo(playerId).player_steamid.substr(3)) - 61197960265728;
}
function netTableObjToArray(obj) {
    if (!obj)
        return [];
    return Object.keys(obj)
        .filter(k => !isNaN(Number(k)))
        .sort((a, b) => Number(a) - Number(b))
        .map(k => obj[k]);
}
function panel(id) {
    return $.GetContextPanel().FindChildTraverse(id);
}
function getDotaHud() {
    let rootUI = $.GetContextPanel();
    while (rootUI.id != "Hud" && rootUI.GetParent() != null) {
        rootUI = rootUI.GetParent();
    }
    return rootUI;
}
function findElement(id) {
    let p = $.GetContextPanel();
    while (p && p.id !== id)
        p = p.GetParent();
    return p;
}
function Count(array) {
    let c = 0;
    for (const k in array) {
        c++;
    }
    return c;
}
function filterItems(items, conditions) {
    if (conditions.length == 0) {
        return items;
    }
    return items.filter(item => conditions.every(cond => cond(item)));
}
function CreateKeyCommand(key, pressCallback, releaseCallback) {
    const command = `On${key}${Date.now()}`;
    Game.CreateCustomKeyBind(key, `+${command}`);
    Game.AddCommand(`+${command}`, () => {
        if (pressCallback) {
            pressCallback();
        }
    }, ``, 1 << 32);
    Game.AddCommand(`-${command}`, () => {
        if (releaseCallback) {
            releaseCallback();
        }
    }, ``, 1 << 32);
}
function FindDotaHudElement(id) {
    let hudRoot = null;
    for (let panell = $.GetContextPanel(); panell != null; panell = panell.GetParent()) {
        hudRoot = panell;
    }
    return hudRoot === null || hudRoot === void 0 ? void 0 : hudRoot.FindChildTraverse(id);
}
Entities.HasBuff = function (unitEntIndex, buffName) {
    for (let index = 0; index < Entities.GetNumBuffs(unitEntIndex); index++) {
        let buff = Entities.GetBuff(unitEntIndex, index);
        if (Buffs.GetName(unitEntIndex, buff) == buffName)
            return true;
    }
    return false;
};
Entities.HasShard = function (unit) {
    return Entities.HasBuff(unit, "modifier_item_aghanims_shard");
};
Game.IsValidAbility = function (abilityIndex) {
    var result = false;
    var abilityName = Abilities.GetAbilityName(abilityIndex);
    if (abilityName != null && abilityName != "" && abilityName.substring(0, 14) != "special_bonus_" && abilityName != "generic_hidden" && abilityName.substring(0, 6) != "empty_") {
        if (!Abilities.IsHidden(abilityIndex))
            result = true;
    }
    return result;
};
function GetHEXPlayerColor(PlayerId) {
    var Color = Players.GetPlayerColor(PlayerId).toString(16);
    return Color == null
        ? "#000000"
        : "#" +
            Color.substring(6, 8) +
            Color.substring(4, 6) +
            Color.substring(2, 4) +
            Color.substring(0, 2);
}
async function sleep(time) {
    return new Promise((resolve) => $.Schedule(time, resolve));
}
function GetHeroID(heroName) {
    var _a;
    const heroKv = GameUI.CustomUIConfig().heroesKv[heroName];
    return (_a = heroKv["HeroID"]) !== null && _a !== void 0 ? _a : -1;
}
function SafeDeleteAsync(p) {
    if (p && p.IsValid()) {
        p.DeleteAsync(0);
    }
}
function toBoolean(value) {
    return value === 1;
}
// Чтение nettable-булевых: движок отдаёт их на клиент как boolean | 0 | 1.
function readNetBool(value) {
    return value === true || value === 1;
}
let PLAYERS_ITEMS_LISTS = {};
function GetOwnedItemsList(playerId) {
    const playerData = PLAYERS_ITEMS_LISTS[playerId];
    if (!playerData) {
        return [];
    }
    const owned = playerData["owned"];
    if (!owned) {
        return [];
    }
    if (Array.isArray(owned)) {
        return owned;
    }
    return netTableObjToArray(owned);
}
function PlayerHasItem(PlayerID, ItemName) {
    const ownedItems = GetOwnedItemsList(PlayerID);
    for (const ItemInfo of ownedItems) {
        if (ItemInfo && ItemInfo.item_name == ItemName) {
            return true;
        }
    }
    return false;
}
function IsItemWeared(PlayerID, itemName) {
    if (PLAYERS_ITEMS_LISTS[PlayerID] && PlayerHasItem(PlayerID, itemName)) {
        const slots = PLAYERS_ITEMS_LISTS[PlayerID]["slots"] || {};
        for (const slotName in slots) {
            if (slots[slotName] == itemName) {
                return true;
            }
        }
    }
    return false;
}
function IsAbilityHasBehavior(abilityName, targetBehavior) {
    const abilityKv = Abilities.GetAbilityKV(abilityName);
    if (!abilityKv) {
        $.Msg(`AbilityKV not found for ${abilityName}`);
        return false;
    }
    const behavior = abilityKv["AbilityBehavior"];
    if (!behavior)
        return false;
    const behaviorName = DOTA_ABILITY_BEHAVIOR[targetBehavior];
    if (!behaviorName) {
        $.Msg(`Unknown behavior enum value: ${targetBehavior}`);
        return false;
    }
    return behavior.includes(behaviorName);
}
function SubscribeAndFireNetTableByKey(tableName, keyName, callback) {
    const currentValue = CustomNetTables.GetTableValue(tableName, keyName);
    if (currentValue) {
        callback(tableName, keyName, currentValue);
    }
    return CustomNetTables.SubscribeNetTableListener(tableName, (name, key, values) => {
        if (key == keyName) {
            callback(name, key, values);
        }
    });
}