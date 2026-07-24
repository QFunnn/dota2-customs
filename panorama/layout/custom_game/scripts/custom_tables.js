--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if (!GameUI.CustomUIConfig().CUSTOM_TABLES) 
{
    GameUI.CustomUIConfig().CUSTOM_TABLES = {};
}

var CustomTableListeners = 
{
    byTable: {},
    byTableKey: {},
    nextId: 1
};

function ensureObj(parent, key) 
{
    if (!parent[key]) parent[key] = {};
    return parent[key];
}

function isPlainObject(value)
{
    return value !== null && typeof value === "object" && !Array.isArray(value);
}

function isDeleteMarker(value)
{
    return isPlainObject(value) && (value.__custom_table_delete === true || value.__custom_table_delete === 1);
}

function cloneTableValue(value)
{
    if (!isPlainObject(value) && !Array.isArray(value))
    {
        return value;
    }

    var result = Array.isArray(value) ? [] : {};
    for (var key in value)
    {
        if (!Object.prototype.hasOwnProperty.call(value, key)) continue;
        result[key] = cloneTableValue(value[key]);
    }
    return result;
}

Game.MergeCustomTablePatch = function(oldVal, patchVal)
{
    if (isDeleteMarker(patchVal))
    {
        return undefined;
    }

    if (!isPlainObject(patchVal))
    {
        return cloneTableValue(patchVal);
    }

    var merged = isPlainObject(oldVal) ? oldVal : {};
    for (var key in patchVal)
    {
        if (!Object.prototype.hasOwnProperty.call(patchVal, key)) continue;

        var patchChild = patchVal[key];
        if (isDeleteMarker(patchChild))
        {
            delete merged[key];
        }
        else
        {
            merged[key] = Game.MergeCustomTablePatch(merged[key], patchChild);
        }
    }
    return merged;
};

// Public API (как SubscribeNetTableListener)
// Usage:
// var unsub = Game.SubscribeCustomTableListener("player_data", function(t,k,n,o){})
// var unsub = Game.SubscribeCustomTableListener("player_data", "123", function(t,k,n,o){})
Game.SubscribeCustomTableListener = function (tableName, keyOrCb, cb, fireImmediately)
{
    var key = null;
    var callback = cb;
    var fireNow = (fireImmediately !== false);

    if (typeof keyOrCb === "function")
    {
        callback = keyOrCb;
    }
    else
    {
        key = String(keyOrCb);
    }

    if (typeof callback !== "function")
    {
        throw new Error("SubscribeCustomTableListener: callback must be a function");
    }

    var id = CustomTableListeners.nextId++;

    if (key === null)
    {
        var bucket = ensureObj(CustomTableListeners.byTable, tableName);
        bucket[id] = callback;

        if (fireNow)
        {
            var tables = GameUI.CustomUIConfig().CUSTOM_TABLES;
            var tableObj = tables && tables[tableName];
            if (tableObj)
            {
                for (var k in tableObj)
                {
                    if (!Object.prototype.hasOwnProperty.call(tableObj, k)) continue;
                    try { callback(tableName, k, tableObj[k], undefined); } catch (e) { $.Msg(e); }
                }
            }
        }
        return function()
        {
            if (CustomTableListeners.byTable[tableName])
            {
                delete CustomTableListeners.byTable[tableName][id];
            }
        };
    }

    var tableBucket = ensureObj(CustomTableListeners.byTableKey, tableName);
    var keyBucket = ensureObj(tableBucket, key);
    keyBucket[id] = callback;

    if (fireNow)
    {
        var tables2 = GameUI.CustomUIConfig().CUSTOM_TABLES;
        var v = tables2 && tables2[tableName] && tables2[tableName][key];
        if (v !== undefined) // если ключ реально есть
        {
            try { callback(tableName, key, v, undefined); } catch (e2) { $.Msg(e2); }
        }
    }

    return function()
    {
        if (CustomTableListeners.byTableKey[tableName] && CustomTableListeners.byTableKey[tableName][key])
        {
            delete CustomTableListeners.byTableKey[tableName][key][id];
        }
    };
};

Game.GetCustomTable = function (tableName, key) 
{
    const tables = GameUI.CustomUIConfig().CUSTOM_TABLES;
    const value = tables && tables[tableName] && tables[tableName][key];
    return value || null;
};

function fireListeners(tableName, key, newVal, oldVal) {
    var tb = CustomTableListeners.byTableKey[tableName];
    var kb = tb && tb[key];
    if (kb) 
    {
        for (var id in kb) 
        {
            try { kb[id](tableName, key, newVal, oldVal); } catch (e) { $.Msg(e); }
        }
    }
    var b = CustomTableListeners.byTable[tableName];
    if (b) 
    {
        for (var id2 in b) 
        {
            try { b[id2](tableName, key, newVal, oldVal); } catch (e2) { $.Msg(e2); }
        }
    }
}

GameEvents.Subscribe_custom("game_event_update_custom_tables", function (payload) 
{
    var tables = GameUI.CustomUIConfig().CUSTOM_TABLES;
    var tableName = payload.table_name;
    var key = String(payload.key);
    if (!tables[tableName]) tables[tableName] = {};
    var oldVal = cloneTableValue(tables[tableName][key]);
    var newVal = payload.full === true ? cloneTableValue(payload.data) : Game.MergeCustomTablePatch(tables[tableName][key], payload.data);
    if (newVal === undefined)
    {
        delete tables[tableName][key];
    }
    else
    {
        tables[tableName][key] = newVal;
    }
    fireListeners(tableName, key, newVal, oldVal);
});

var customTablesLoaded = false;
var customTablesRequestStarted = false;

GameEvents.Subscribe_custom("event_game_custom_tables_loaded", function()
{
    customTablesLoaded = true;
});

function RequestCustomTablesUntilLoaded()
{
    if (customTablesLoaded) return;

    let player_info = Game.GetPlayerInfo( Players.GetLocalPlayer() );
    if (!player_info)
    {
        $.Schedule(0.5, RequestCustomTablesUntilLoaded)
        return
    }

    let pState = player_info.player_connection_state
    if ((pState != DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED))
    {
        $.Schedule(0.5, RequestCustomTablesUntilLoaded)
        return
    }

    GameEvents.SendCustomGameEventToServer("event_game_request_custom_tables", {});
    $.Schedule(0.5, RequestCustomTablesUntilLoaded)
}

function InitCustomTables() 
{
    if (customTablesRequestStarted) return;
    customTablesRequestStarted = true;

    GameEvents.OnLoaded(function()
    {
        RequestCustomTablesUntilLoaded();
    });
    RequestCustomTablesUntilLoaded();
}

InitCustomTables();