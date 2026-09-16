--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('battle_record_runtime', exports);

function mergeChangedFields(current, changed) {
  for (const key in changed) {
    const changedValue = changed[key];
    if (typeof changedValue == 'object' && changedValue != undefined) {
      const currentValue = current[key];
      if (typeof currentValue != 'object' || currentValue == undefined) {
        current[key] = {};
      }
      mergeChangedFields(current[key], changedValue);
    } else {
      current[key] = changedValue;
    }
  }
}
function cloneRecord(value) {
  if (typeof value != 'object' || value == undefined) {
    return value;
  }
  const clone = {};
  for (const key in value) {
    clone[key] = cloneRecord(value[key]);
  }
  return clone;
}
class BattleRecordCache {
  records = {};
  applyDelta(key, delta) {
    const current = cloneRecord(this.records[key] ?? {});
    mergeChangedFields(current, delta);
    this.records[key] = current;
  }
  applySnapshot(key, snapshot) {
    this.records[key] = cloneRecord(snapshot);
  }
  get(key) {
    return this.records[key];
  }
  clear() {
    this.records = {};
  }
}

function createRuntime() {
  const runtime = {
    cache: new BattleRecordCache(),
    callbacks: {},
    lastSnapshotRequestTime: 0,
    requestSnapshots() {
      const now = Date.now();
      if (now - runtime.lastSnapshotRequestTime < 1000) return;
      runtime.lastSnapshotRequestTime = now;
      GameEvents.SendCustomGameEventToServer('battle_record_request_snapshot', {});
    }
  };
  GameEvents.Subscribe('battle_record_delta', ({
    key,
    data
  }) => {
    if (!runtime.cache.get(key)) {
      runtime.requestSnapshots();
    }
    runtime.cache.applyDelta(key, JSON.parse(data));
    for (const callback of runtime.callbacks[key] ?? []) {
      callback(runtime.cache.get(key));
    }
  });
  GameEvents.Subscribe('battle_record_snapshot', ({
    key,
    data
  }) => {
    runtime.cache.applySnapshot(key, JSON.parse(data));
    for (const callback of runtime.callbacks[key] ?? []) {
      callback(runtime.cache.get(key));
    }
  });
  GameEvents.Subscribe('battle_record_reset', () => {
    runtime.cache.clear();
    for (const key in runtime.callbacks) {
      for (const callback of runtime.callbacks[key]) {
        callback(undefined);
      }
    }
  });
  runtime.requestSnapshots();
  return runtime;
}
const customUIConfig = GameUI.CustomUIConfig();
const runtime = customUIConfig.__battle_record_runtime ?? (customUIConfig.__battle_record_runtime = createRuntime());
function getBattleRecord(key) {
  const stringKey = String(key);
  if (!runtime.cache.get(stringKey)) {
    runtime.requestSnapshots();
  }
  return runtime.cache.get(stringKey);
}
function subscribeBattleRecord(key, callback) {
  const stringKey = String(key);
  runtime.callbacks[stringKey] = runtime.callbacks[stringKey] ?? [];
  runtime.callbacks[stringKey].push(callback);
  callback(getBattleRecord(stringKey));
  return () => {
    runtime.callbacks[stringKey] = runtime.callbacks[stringKey].filter(registered => registered != callback);
  };
}

exports.getBattleRecord = getBattleRecord;
exports.subscribeBattleRecord = subscribeBattleRecord;