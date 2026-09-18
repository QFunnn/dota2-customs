--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build c158db4 
  ~ auto-generated — do not edit
]]


'use strict'; const exports = {}; GameUI.__loadModule('battle_record', exports);

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
  snapshots = {};
  applyDelta(key, delta) {
    const current = cloneRecord(this.records[key] ?? {});
    mergeChangedFields(current, delta);
    this.records[key] = current;
  }
  applySnapshot(key, snapshot) {
    this.records[key] = cloneRecord(snapshot);
    this.snapshots[key] = true;
  }
  hasSnapshot(key) {
    return this.snapshots[key] == true;
  }
  get(key) {
    return this.records[key];
  }
  clear() {
    this.records = {};
    this.snapshots = {};
  }
}
function sumRecord(record) {
  let total = 0;
  for (const key in record) {
    if (key != 'count') {
      total += record[key];
    }
  }
  return total;
}
function createBattleRecordDetailRows(battleRecord, sectName) {
  const key = sectName.replace('sect_', '');
  return () => {
    const detail = battleRecord()?.[key] ?? {};
    const amounts = Object.keys(detail).map(abilityName => ({
      abilityName,
      amount: Math.round(sumRecord(detail[abilityName]))
    }));
    amounts.sort((a, b) => b.amount - a.amount);
    const maxAmount = amounts.reduce((maximum, row) => Math.max(maximum, row.amount), 0);
    const allAmount = amounts.reduce((total, row) => total + row.amount, 0);
    return amounts.map(({
      abilityName,
      amount
    }) => ({
      abilityName,
      amount,
      maxAmount,
      percent: Math.round(amount / Math.max(allAmount, 1) * 100)
    }));
  };
}
function createRuntime() {
  let pending = {};
  let retryTimer;
  let nextRequestTime = 0;
  const schedule = () => {
    if (retryTimer == undefined && Object.keys(pending).length > 0) {
      retryTimer = setTimeout(flush, Math.max(50, nextRequestTime - Date.now()));
    }
  };
  const flush = () => {
    retryTimer = undefined;
    const now = Date.now();
    let requestedKey;
    for (const key in pending) {
      const request = pending[key];
      if (runtime.cache.hasSnapshot(key) || now - request.lastRead > 1000 && !(runtime.callbacks[key]?.length > 0)) {
        delete pending[key];
      } else if (request.nextAttempt <= now && (requestedKey == undefined || request.nextAttempt < pending[requestedKey].nextAttempt)) {
        requestedKey = key;
      }
    }
    nextRequestTime = now + 1100;
    if (requestedKey != undefined) {
      const request = pending[requestedKey];
      request.nextAttempt = now + request.retryDelay;
      request.retryDelay = Math.min(request.retryDelay * 2, 8800);
      GameEvents.SendCustomGameEventToServer('battle_record_request_snapshot', {
        key: requestedKey
      });
    }
    schedule();
  };
  const runtime = {
    cache: new BattleRecordCache(),
    callbacks: {},
    requestSnapshots(key) {
      const entIndex = Number(key);
      if (!Number.isInteger(entIndex) || entIndex < 0 || runtime.cache.hasSnapshot(key)) return;
      const now = Date.now();
      pending[key] = pending[key] ?? {
        lastRead: now,
        nextAttempt: now,
        retryDelay: 1100
      };
      pending[key].lastRead = now;
      schedule();
    }
  };
  GameEvents.Subscribe('battle_record_delta', ({
    key,
    data
  }) => {
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
    delete pending[key];
    for (const callback of runtime.callbacks[key] ?? []) {
      callback(runtime.cache.get(key));
    }
  });
  GameEvents.Subscribe('battle_record_reset', () => {
    runtime.cache.clear();
    pending = {};
    if (retryTimer != undefined) clearTimeout(retryTimer);
    retryTimer = undefined;
    nextRequestTime = 0;
    for (const key in runtime.callbacks) {
      for (const callback of runtime.callbacks[key]) {
        callback(undefined);
      }
    }
  });
  return runtime;
}
const customUIConfig = typeof GameUI == 'undefined' ? undefined : GameUI.CustomUIConfig();
const runtime = customUIConfig == undefined ? undefined : customUIConfig.__battle_record ?? (customUIConfig.__battle_record = createRuntime());
function getBattleRecord(key) {
  if (!runtime) return undefined;
  const stringKey = String(key);
  if (!runtime.cache.hasSnapshot(stringKey)) {
    runtime.requestSnapshots(stringKey);
  }
  return runtime.cache.get(stringKey);
}
function subscribeBattleRecord(key, callback) {
  if (!runtime) return () => {};
  const stringKey = String(key);
  runtime.callbacks[stringKey] = runtime.callbacks[stringKey] ?? [];
  runtime.callbacks[stringKey].push(callback);
  callback(getBattleRecord(stringKey));
  return () => {
    runtime.callbacks[stringKey] = runtime.callbacks[stringKey].filter(registered => registered != callback);
  };
}

exports.createBattleRecordDetailRows = createBattleRecordDetailRows;
exports.getBattleRecord = getBattleRecord;
exports.subscribeBattleRecord = subscribeBattleRecord;