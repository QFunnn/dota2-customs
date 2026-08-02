--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('netdata_utils', exports); const require = GameUI.__require;

var libs = require('./libs.js');

function createNetData(key, defaultValue, listenOn) {
  const [data, setData] = libs.createSignal(defaultValue);
  libs.onMount(() => {
    const id = useNetData(key, data => {
      {
        setData(() => data);
      }
    });
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  return data;
}
function createPlayerNetData(key, playerID, defaultValue) {
  const [data, setData] = libs.createSignal(defaultValue);
  libs.onMount(() => {
    const id = useNetData(key, data => {
      setData(() => data);
    }, playerID);
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  return data;
}
function createNetDataEffect(key, callback, playerID, deps) {
  if (deps != undefined && deps.length > 0) {
    libs.createEffect(libs.on(deps, () => {
      const data = getNetDataCache(key, playerID);
      if (data) {
        callback(data);
      }
    }));
  }
  libs.onMount(() => {
    const id = useNetData(key, callback, playerID);
    libs.onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
}
function createNetTable(fstKey, secKey, defaultValue) {
  const [data, setData] = libs.createSignal((() => {
    const cache = CustomNetTables.GetTableValue(fstKey, secKey);
    if (cache) {
      return cache;
    }
    return defaultValue;
  })());
  libs.onMount(() => {
    const id = useNetTableKey(fstKey, secKey, v => {
      setData(v);
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return data;
}
function createNetTableEffect(fstKey, secKey, callback, deps) {
  const cache = CustomNetTables.GetTableValue(fstKey, secKey);
  if (cache) {
    callback(cache);
  }
  libs.onMount(() => {
    const id = useNetTableKey(fstKey, secKey, callback);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
}
function createPlayerServiceNetTableEffect(key, callback, playerID, deps) {
  if (deps != undefined && deps.length > 0) {
    libs.createEffect(libs.on(deps, () => {
      const data = getServiceNetTable(key, playerID);
      if (data) {
        if (playerID == -1) {
          Object.entries(data).forEach(([id, v], i) => {
            callback(v, Number(id));
          });
        } else {
          callback(data, playerID);
        }
      }
    }));
  }
  libs.onMount(() => {
    const id = useServiceNetTable(key, (v, id) => {
      callback(v, id);
    }, playerID);
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
}
function createServiceNetTable(key, defaultValue) {
  const [data, setData] = libs.createSignal((() => {
    const cache = CustomNetTables.GetTableValue("service", key);
    if (cache) {
      return JSON.parse(cache.data);
    }
    return defaultValue;
  })());
  libs.onMount(() => {
    const id = CustomNetTables.SubscribeNetTableListener("service", (_, k, v) => {
      if (key == k) {
        const data = JSON.parse(v.data);
        setData(data);
      }
    });
    libs.onCleanup(() => {
      CustomNetTables.UnsubscribeNetTableListener(id);
    });
  });
  return data;
}

exports.createNetData = createNetData;
exports.createNetDataEffect = createNetDataEffect;
exports.createNetTable = createNetTable;
exports.createNetTableEffect = createNetTableEffect;
exports.createPlayerNetData = createPlayerNetData;
exports.createPlayerServiceNetTableEffect = createPlayerServiceNetTableEffect;
exports.createServiceNetTable = createServiceNetTable;