--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 01883f2 
  ~ auto-generated — do not edit
]]


// [A77] Счётчики принятых событий PlayerTables. Нужны не для логов, а для логики:
// по ним MirrorRequest понимает, что события до клиента не доходят, и запрашивает зеркало.
// Диагностический пульс A77 снят 2026-08-05 перед прод-заливкой.
var reload = true;

var count = 0;
var PT = {
  listeners: {},
  tableListeners: {},
  nextListener: 0,
  tables: {},
  subs: []
};


$.Msg("[playertables_base.js] Loaded");

var PlayerTables = {};

PlayerTables.GetAllTableValues = function(tableName)
{
  var table = PT.tables[tableName];
  if (table)
    return JSON.parse(JSON.stringify(table));

  return null;
};


PlayerTables.GetTableValue = function(tableName, keyName)
{
  var table = PT.tables[tableName];
  if (!table)
    return null;

  var val = table[keyName];

  if (typeof val === 'object')
    return JSON.parse(JSON.stringify(val));

  return val;
};

PlayerTables.SubscribeNetTableListener = function(tableName, callback) 
{
  var listeners = PT.tableListeners[tableName];
  if (!listeners){
    listeners = {};
    PT.tableListeners[tableName] = listeners;
  }

  var ID = PT.nextListener;
  PT.nextListener++;

  listeners[ID] = callback;
  PT.listeners[ID] = tableName;

  return ID;
};

PlayerTables.UnsubscribeNetTableListener = function(callbackID)
{
  var tableName = PT.listeners[callbackID];
  if (tableName){
    if (PT.tableListeners[tableName]){
      var listener = PT.tableListeners[tableName][callbackID];
      if (listener){
        delete PT.tableListeners[tableName][callbackID];
      }
    }
 
    delete PT.listeners[callbackID];
  }
  
  return;
}; 

function isEquivalent(a, b) {
    var aProps = Object.getOwnPropertyNames(a);
    var bProps = Object.getOwnPropertyNames(b);

    if (aProps.length != bProps.length) {
        return false;
    }

    for (var i = 0; i < aProps.length; i++) {
        var propName = aProps[i];

        if (a[propName] !== b[propName]) {
            return false;
        }
    }

    return true;
}

function ProcessTable(newTable, oldTable, changes, dels)
{
  for (var k in newTable)
  {
    var n = newTable[k];
    var old = oldTable[k];

    if (typeof(n) == typeof(old) && typeof(n) == "object"){
      if (!isEquivalent(n, old)){
        changes[k] = n;
      }

      delete oldTable[k];
    }
    else if (n !== old){
      changes[k] = n;
      delete oldTable[k];
    }
    else if (n === old){
      delete oldTable[k];
    }
  }

  for (var k in oldTable)
  {
    dels[k] = true;
  }
}

// [A77] Счётчики принятых событий PlayerTables. Это не диагностика: по ним MirrorRequest
// понимает, что события до клиента не доходят, и запрашивает зеркало поверх CustomNetTables.
var A77_counters = { pt_fu: 0, pt_uk: 0, pt_kd: 0 };


function SendPID()
{
  var pid = Players.GetLocalPlayer();
  var spec = Players.IsSpectator(pid);
  //$.Msg(pid, ' -- ', spec);
  if (pid == -1 && !spec){
    $.Schedule(1/30, SendPID);
    return;
  }


  GameEvents.SendCustomGameEventToServer( "PlayerTables_Connected", {pid:pid} );
}



function TableFullUpdate(msg)
{
  //$.Msg('TableFullUpdate -- ', msg);
  //msg.table = UnprocessTable(msg.table);
  var newTable = msg.table;
  var oldTable = PT.tables[msg.name];

  if (!newTable)
    delete PT.tables[msg.name];
  else
    PT.tables[msg.name] = newTable;

  var listeners = PT.tableListeners[msg.name] || {};
  var len = Object.keys(listeners).length;
  var changes = null;
  var dels = null;

  if (len > -1 && newTable){
    if (!oldTable){
      changes = newTable;
      dels = {};
    }
    else {
      changes = {};
      dels = {};
      ProcessTable(newTable, oldTable, changes, dels);
    }
  }

  for (var k in listeners){
    try{ listeners[k](msg.name, changes, dels);} catch(err){$.Msg("PlayerTables.TableFullUpdate callback error for '", msg.name, " -- ", newTable, "': ", err.stack);};
  }
};

function UpdateTable(msg)
{
  //$.Msg('UpdateTable -- ', msg);
  //msg.changes = UnprocessTable(msg.changes);

  var table = PT.tables[msg.name];
  if (!table)
  {
    $.Msg("PlayerTables.UpdateTable invoked on nonexistent playertable.");
    return;
  }

  var t = {};

  for (var k in msg.changes){
    var value = msg.changes[k];

    table[k] = value;
    if (typeof value === 'object')
      t[k] = JSON.parse(JSON.stringify(value));
    else
      t[k] = value;
  }

  var listeners = PT.tableListeners[msg.name] || {};
  for (var k in listeners){
    if (listeners[k]){
      try{ listeners[k](msg.name, t, {});} catch(err){$.Msg("PlayerTables.UpdateTable callback error for '", msg.name, " -- ", t, "': ", err.stack);}      
    }
  }
}

function DeleteTableKeys(msg)
{
  //$.Msg('DeleteTableKeys -- ', msg);
  var table = PT.tables[msg.name];
  if (!table)
  {
    $.Msg("PlayerTables.DeleteTableKey invoked on nonexistent playertable.");
    return;
  }

  var t = {};

  for (var k in msg.keys){
    var value = msg.keys[k];

    delete table[k];
  }

  var listeners = PT.tableListeners[msg.name] || {};
  for (var k in listeners){
    if (listeners[k]){
      try{ listeners[k](msg.name, {}, msg.keys);} catch(err){$.Msg("PlayerTables.DeleteTableKeys callback error for '", msg.name, " -- ", msg.keys, "': ", err.stack);}
    }
  }
}

// ============================================================================
// [A77] РЕЗЕРВНЫЙ КАНАЛ ДОСТАВКИ (зеркало через CustomNetTables)
//
// У игрока, зашедшего в наш режим из другой кастомки без перезапуска клиента,
// перестают доставляться кастомные игровые события. Проверено логами: рукопожатие
// доходит до сервера (он отвечает сообщением в чат, и оно видно), сервер шлёт
// таблицы лично этому игроку — а клиент не получает ни одного события. При этом
// CustomNetTables работают. Вся библиотека PlayerTables ездит на событиях, поэтому
// у такого игрока нет ни пула героев в пике, ни выбора способностей, ни настроек.
//
// Здесь: если за MIRROR_WAIT секунд не пришло НИ ОДНОГО pt_*, просим сервер
// дублировать наши таблицы в CustomNetTable, и дальше читаем их оттуда. Разбирает
// их тот же TableFullUpdate, так что для остального кода ничего не меняется.
//
// Запрашиваем, а не включаем всегда, потому что CustomNetTables видны всем: у
// здоровых игроков это был бы лишний трафик и раскрытие чужого пула героев.
// ============================================================================
var MIRROR_NET_TABLE = "pt_mirror";
var MIRROR_WAIT = 6;                 // столько ждём обычные события, прежде чем просить зеркало
var MIRROR_RETRY = 5;                // и столько — между повторными просьбами
var MIRROR_MAX_REQUESTS = 6;

var mirrorRequests = 0;
var mirrorActive = false;

// Ключ зеркала — "<таблица>|<ключ>", значение — обёртка {v: ...}. Шлём по одному
// ключу, а не таблицу целиком: полная публикация каталога предметов весит ~159 КБ,
// и после каждой такой записи клиент срывал синхронизацию тиков (в логе
// «Slamming client tick to server tick») — это ощущалось как рывки в игре.
function MirrorApply(mirrorKey, value)
{
  if (!mirrorKey || !value) { return; }

  var sep = mirrorKey.indexOf("|");
  if (sep < 0) { return; }

  var tableName = mirrorKey.substring(0, sep);
  var key = mirrorKey.substring(sep + 1);

  // таблицы больше нет
  if (key === "__gone"){
    TableFullUpdate({name: tableName, table: null});
    return;
  }

  // Первое обновление по таблице приходит поключно, поэтому саму таблицу
  // при необходимости заводим сами — иначе UpdateTable отвергнет обновление.
  if (!PT.tables[tableName]){
    TableFullUpdate({name: tableName, table: {}});
  }

  if (value.gone == 1){
    // DeleteTableKeys перебирает msg.keys как объект «имя ключа -> true»
    // (так же его шлёт сервер), поэтому массив сюда передавать нельзя.
    var dels = {};
    dels[key] = true;

    DeleteTableKeys({name: tableName, keys: dels});
    return;
  }

  var changes = {};
  changes[key] = value.v;

  UpdateTable({name: tableName, changes: changes});
}

function MirrorReadAll()
{
  var all = CustomNetTables.GetAllTableValues(MIRROR_NET_TABLE);
  if (!all){ return; }

  // Разбираем обе возможные формы ответа: массив пар {key, value} и обычный
  // объект «имя таблицы -> значение». Форма не задокументирована жёстко, а цена
  // ошибки здесь — молча не применённое зеркало, поэтому поддерживаем оба вида.
  for (var i in all){
    var row = all[i];
    if (row && row.key !== undefined){
      MirrorApply(row.key, row.value);
    } else {
      MirrorApply(i, row);
    }
  }
}

function MirrorRequest()
{
  // события пошли — резервный канал не нужен
  if (A77_counters.pt_fu > 0 || A77_counters.pt_uk > 0){ return; }

  var pid = Players.GetLocalPlayer();
  if (pid == -1){
    $.Schedule(1, MirrorRequest);
    return;
  }

  mirrorRequests++;
  $.Msg("[A77] события PlayerTables не доходят — запрашиваем зеркало, попытка ", mirrorRequests);

  // ==========================================================================
  // [A77] Пробуем вылечить причину, а не следствие.
  //
  // Гипотеза: клиент, пришедший из другой кастомки, держит СХЕМУ ИГРОВЫХ СОБЫТИЙ
  // от неё. Тогда идентификаторы разъезжаются, и молчат разом и кастомные события,
  // и движковые (подписка на game_rules_state_change у нас тоже не срабатывала),
  // а нет-таблицы живут — они идут другим механизмом. Ровно та картина, что в логах.
  //
  // В клиенте есть команда dota_reload_event_schema (нашлась в client.dll). Панорама
  // сама консольные команды выполнять не умеет, поэтому идём через наш канал
  // client_side_server_command -> SendToConsole (addon_init.lua:77-81). Событие
  // локальное, по сети не идёт, так что имеет шанс сработать даже здесь.
  //
  // Если после этого пойдут pt_*, значит нашли настоящее лекарство и резервный
  // канал останется лишь страховкой.
  // ==========================================================================
  if (mirrorRequests === 1){
    GameEvents.SendEventClientSide("client_side_server_command", {command: "dota_reload_event_schema"});
  }

  GameEvents.SendCustomGameEventToServer("PlayerTables_NeedMirror", {pid: pid});

  if (!mirrorActive){
    mirrorActive = true;

    // [A77] Помечаем для остальных панелей, что этот клиент «битый» — события до него
    // не доходят. Этим пользуется, например, подложка миникарты в manifest.js:
    // у такого игрока движок рисует карту от предыдущей кастомки.
    GameUI.CustomUIConfig().A77_MirrorActive = true;

    CustomNetTables.SubscribeNetTableListener(MIRROR_NET_TABLE, function(name, key, value){
      MirrorApply(key, value);
    });
  }

  // сервер мог ответить не сразу (или запрос потерялся) — читаем, что уже лежит,
  // и при пустом зеркале просим ещё раз
  $.Schedule(1, MirrorReadAll);

  if (mirrorRequests < MIRROR_MAX_REQUESTS){
    $.Schedule(MIRROR_RETRY, function(){
      var names = [];
      for (var n in PT.tables){ names.push(n); }
      if (names.length === 0){ MirrorRequest(); }
    });
  }
}

(function(){
  GameUI.CustomUIConfig().PlayerTables = PlayerTables;

  SendPID();

  // Счётчики держим в обёртках, а не внутри обработчиков: данные, пришедшие
  // зеркалом, идут через тот же TableFullUpdate и не должны выглядеть как
  // «события заработали».
  GameEvents.Subscribe( "pt_fu", function(msg){
    A77_counters.pt_fu++;
    TableFullUpdate(msg);
  });
  GameEvents.Subscribe( "pt_uk", function(msg){
    A77_counters.pt_uk++;
    UpdateTable(msg);
  });
  GameEvents.Subscribe( "pt_kd", function(msg){
    A77_counters.pt_kd++;
    DeleteTableKeys(msg);
  });

  // [A77] если события так и не пойдут — переключимся на зеркало
  $.Schedule(MIRROR_WAIT, MirrorRequest);

})()