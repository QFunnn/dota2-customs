--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
var AttributeKind = GameUI.CustomUIConfig().tools.AttributeKind;
const ID2Attribute = {
    '10600001': AttributeKind.AllStats,
    '10600002': AttributeKind.AllStats.BASE,
    '10600003': AttributeKind.AllStats.BONUS,
    '10600004': AttributeKind.AllStats.PCT,
    '10600005': AttributeKind.AllStats.AMP,
    '10600006': AttributeKind.Strength,
    '10600007': AttributeKind.Strength.BASE,
    '10600008': AttributeKind.Strength.BONUS,
    '10600009': AttributeKind.Strength.PCT,
    '10600010': AttributeKind.Strength.AMP,
    '10600011': AttributeKind.Agility,
    '10600012': AttributeKind.Agility.BASE,
    '10600013': AttributeKind.Agility.BONUS,
    '10600014': AttributeKind.Agility.PCT,
    '10600015': AttributeKind.Agility.AMP,
    '10600016': AttributeKind.Intellect,
    '10600017': AttributeKind.Intellect.BASE,
    '10600018': AttributeKind.Intellect.BONUS,
    '10600019': AttributeKind.Intellect.PCT,
    '10600020': AttributeKind.Intellect.AMP,
    '10600021': AttributeKind.Atk,
    '10600022': AttributeKind.Atk.BASE,
    '10600023': AttributeKind.Atk.BONUS,
    '10600024': AttributeKind.Atk.PCT,
    '10600025': AttributeKind.Atk.AMP,
    '10600026': AttributeKind.HpLimit,
    '10600027': AttributeKind.HpLimit.BASE,
    '10600028': AttributeKind.HpLimit.BONUS,
    '10600029': AttributeKind.HpLimit.PCT,
    '10600030': AttributeKind.HpLimit.AMP,
    '10600031': AttributeKind.HpRegen,
    '10600032': AttributeKind.HpRegen.BASE,
    '10600033': AttributeKind.HpRegen.BONUS,
    '10600034': AttributeKind.HpRegen.PCT,
    '10600035': AttributeKind.HpRegen.AMP,
    '10600036': AttributeKind.HpRegen.HP_PCT,
    '10600037': AttributeKind.MpLimit,
    '10600038': AttributeKind.MpLimit.BASE,
    '10600039': AttributeKind.MpLimit.BONUS,
    '10600040': AttributeKind.MpLimit.PCT,
    '10600041': AttributeKind.MpLimit.AMP,
    '10600042': AttributeKind.MpRegen,
    '10600043': AttributeKind.MpRegen.BASE,
    '10600044': AttributeKind.MpRegen.BONUS,
    '10600045': AttributeKind.MpRegen.PCT,
    '10600046': AttributeKind.MpRegen.AMP,
    '10600047': AttributeKind.MpRegen.MP_PCT,
    '10600048': AttributeKind.Armor,
    '10600049': AttributeKind.Armor.BASE,
    '10600050': AttributeKind.Armor.BONUS,
    '10600051': AttributeKind.Armor.PCT,
    '10600052': AttributeKind.Armor.AMP,
    '10600053': AttributeKind.AtkSpd,
    '10600054': AttributeKind.AtkSpd.BASE,
    '10600055': AttributeKind.AtkSpd.BONUS,
    '10600056': AttributeKind.AtkSpd.PCT,
    '10600057': AttributeKind.AtkTime,
    '10600058': AttributeKind.AtkTime.BASE,
    '10600059': AttributeKind.MoveSpd,
    '10600060': AttributeKind.MoveSpd.BASE,
    '10600061': AttributeKind.MoveSpd.BONUS,
    '10600062': AttributeKind.MoveSpd.PCT,
    '10600063': AttributeKind.AtkRange,
    '10600064': AttributeKind.AtkRange.BASE,
    '10600065': AttributeKind.AtkRange.BONUS,
    '10600066': AttributeKind.AtkRange.PCT,
    '10600067': AttributeKind.PrjctSpd,
    '10600068': AttributeKind.PrjctSpd.BASE,
    '10600069': AttributeKind.PrjctSpd.BONUS,
    '10600070': AttributeKind.PrjctSpd.PCT,
    '10600071': AttributeKind.CastRange,
    '10600072': AttributeKind.CastRange.BONUS,
    '10600073': AttributeKind.CastRange.PCT,
    '10600074': AttributeKind.Cooldown,
    '10600075': AttributeKind.Cooldown.BASE,
    '10600076': AttributeKind.Cooldown.BONUS,
    '10600077': AttributeKind.Cooldown.PCT,
    '10600078': AttributeKind.StaResist,
    '10600079': AttributeKind.DebuffAmp,
    '10600080': AttributeKind.Evasion,
    '10600081': AttributeKind.Miss,
    '10600082': AttributeKind.Heal,
    '10600083': AttributeKind.ModelScale,
    '10600084': AttributeKind.ModelScale.PCT,
    '10600085': AttributeKind.ArmorIgnore,
    '10600086': AttributeKind.ArmorIgnore.BASE,
    '10600087': AttributeKind.CritChance,
    '10600088': AttributeKind.CritChance.BASE,
    '10600089': AttributeKind.CritDmg,
    '10600090': AttributeKind.MgcCritTransformChance,
    '10600091': AttributeKind.MultCount,
    '10600092': AttributeKind.MultDmg,
    '10600093': AttributeKind.BounceCount,
    '10600094': AttributeKind.BounceDmg,
    '10600095': AttributeKind.StrGain,
    '10600096': AttributeKind.AgiGain,
    '10600097': AttributeKind.IntGain,
    '10600098': AttributeKind.AtkGain,
    '10600099': AttributeKind.HpGain,
    '10600100': AttributeKind.PhyFixedGain,
    '10600101': AttributeKind.MgcFixedGain,
    '10600102': AttributeKind.CreepDmg,
    '10600103': AttributeKind.EliteDmg,
    '10600104': AttributeKind.ChallengeDmg,
    '10600105': AttributeKind.BossDmg,
    '10600106': AttributeKind.PhyDmg,
    '10600107': AttributeKind.MgcDmg,
    '10600108': AttributeKind.DmgFinal,
    '10600109': AttributeKind.DmgReduce,
    '10600110': AttributeKind.PhyFixed,
    '10600111': AttributeKind.PhyFixed.BASE,
    '10600112': AttributeKind.PhyFixed.BONUS,
    '10600113': AttributeKind.PhyFixed.PCT,
    '10600114': AttributeKind.PhyFixed.AMP,
    '10600115': AttributeKind.MgcFixed,
    '10600116': AttributeKind.MgcFixed.BASE,
    '10600117': AttributeKind.MgcFixed.BONUS,
    '10600118': AttributeKind.MgcFixed.PCT,
    '10600119': AttributeKind.MgcFixed.AMP,
    '10600120': AttributeKind.GoldPct,
    '10600121': AttributeKind.WoodPct,
    '10600122': AttributeKind.KillPct,
    '10600123': AttributeKind.ExpPct,
    '10600124': AttributeKind.PerSecAllStats,
    '10600125': AttributeKind.PerSecStr,
    '10600126': AttributeKind.PerSecAgi,
    '10600127': AttributeKind.PerSecInt,
    '10600128': AttributeKind.PerSecAtk,
    '10600129': AttributeKind.PerSecHp,
    '10600130': AttributeKind.PerSecGold,
    '10600131': AttributeKind.PerSecWood,
    '10600132': AttributeKind.PerSecKill,
    '10600133': AttributeKind.PerSecExp,
    '10600134': AttributeKind.KillAllStats,
    '10600135': AttributeKind.KillStr,
    '10600136': AttributeKind.KillAgi,
    '10600137': AttributeKind.KillInt,
    '10600138': AttributeKind.KillAtk,
    '10600139': AttributeKind.KillHp,
    '10600140': AttributeKind.KillGold,
    '10600141': AttributeKind.KillWood,
    '10600142': AttributeKind.KillKill,
    '10600143': AttributeKind.KillExp,
    '10600144': AttributeKind.InitGood,
    '10600145': AttributeKind.InitWood,
    '10600146': AttributeKind.InitKill,
    '10600147': AttributeKind.RespawnChance,
    '10600148': AttributeKind.RespawnTime,
    '10600149': AttributeKind.RespawnTime.BASE,
    '10600150': AttributeKind.AllHeroFactorPct,
    '10600151': AttributeKind.StrHeroFactorPct,
    '10600152': AttributeKind.AgiHeroFactorPct,
    '10600153': AttributeKind.IntHeroFactorPct,
    '10600154': AttributeKind.TreasureChestPct,
    '10600155': AttributeKind.WeaponFactorPct,
    '10600156': AttributeKind.WeaponStatsPct,
    '10600157': AttributeKind.SuitStatsPct,
    '10600158': AttributeKind.SuitCooldown,
    '10600159': AttributeKind.ShiftDistance,
    '10600160': AttributeKind.AllDmg,
    '10600161': AttributeKind.ModelScale,
    '10600162': AttributeKind.ModelScale.BASE,
    '10600163': AttributeKind.ModelScale.PCT,
};

/******************************************************************************
Copyright (c) Microsoft Corporation.

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
PERFORMANCE OF THIS SOFTWARE.
***************************************************************************** */
/* global Reflect, Promise, SuppressedError, Symbol, Iterator */


function __setFunctionName(f, name, prefix) {
    if (typeof name === "symbol") name = name.description ? "[".concat(name.description, "]") : "";
    return Object.defineProperty(f, "name", { configurable: true, value: prefix ? "".concat(prefix, " ", name) : name });
}

const equalFn = (a, b) => a === b;
const $PROXY = Symbol("solid-proxy");
const SUPPORTS_PROXY = typeof Proxy === "function";
const signalOptions = {
  equals: equalFn
};
let runEffects = runQueue;
const STALE = 1;
const PENDING = 2;
const UNOWNED = {
  owned: null,
  cleanups: null,
  context: null,
  owner: null
};
var Owner = null;
let Listener = null;
let Updates = null;
let Effects = null;
let ExecCount = 0;
function createRoot(fn, detachedOwner) {
  const listener = Listener,
    owner = Owner,
    unowned = fn.length === 0,
    current = owner ,
    root = unowned ? UNOWNED : {
      owned: null,
      cleanups: null,
      context: current ? current.context : null,
      owner: current
    },
    updateFn = unowned ? fn : () => fn(() => untrack(() => cleanNode(root)));
  Owner = root;
  Listener = null;
  try {
    return runUpdates(updateFn, true);
  } finally {
    Listener = listener;
    Owner = owner;
  }
}
function createRenderEffect(fn, value, options) {
  const c = createComputation(fn, value, false, STALE);
  updateComputation(c);
}
function createMemo(fn, value, options) {
  options = options ? Object.assign({}, signalOptions, options) : signalOptions;
  const c = createComputation(fn, value, true, 0);
  c.observers = null;
  c.observerSlots = null;
  c.comparator = options.equals || undefined;
  updateComputation(c);
  return readSignal.bind(c);
}
function untrack(fn) {
  if (Listener === null) return fn();
  const listener = Listener;
  Listener = null;
  try {
    return fn();
  } finally {
    Listener = listener;
  }
}
function readSignal() {
  if (this.sources && (this.state)) {
    if ((this.state) === STALE) updateComputation(this);else {
      const updates = Updates;
      Updates = null;
      runUpdates(() => lookUpstream(this), false);
      Updates = updates;
    }
  }
  if (Listener) {
    const sSlot = this.observers ? this.observers.length : 0;
    if (!Listener.sources) {
      Listener.sources = [this];
      Listener.sourceSlots = [sSlot];
    } else {
      Listener.sources.push(this);
      Listener.sourceSlots.push(sSlot);
    }
    if (!this.observers) {
      this.observers = [Listener];
      this.observerSlots = [Listener.sources.length - 1];
    } else {
      this.observers.push(Listener);
      this.observerSlots.push(Listener.sources.length - 1);
    }
  }
  return this.value;
}
function writeSignal(node, value, isComp) {
  let current = node.value;
  if (!node.comparator || !node.comparator(current, value)) {
    node.value = value;
    if (node.observers && node.observers.length) {
      runUpdates(() => {
        for (let i = 0; i < node.observers.length; i += 1) {
          const o = node.observers[i];
          if (!o.state) {
            if (o.pure) Updates.push(o);else Effects.push(o);
            if (o.observers) markDownstream(o);
          }
          o.state = STALE;
        }
        if (Updates.length > 10e5) {
          Updates = [];
          throw new Error();
        }
      }, false);
    }
  }
  return value;
}
function updateComputation(node) {
  if (!node.fn) return;
  cleanNode(node);
  const time = ExecCount;
  runComputation(node, node.value, time);
}
function runComputation(node, value, time) {
  let nextValue;
  const owner = Owner,
    listener = Listener;
  Listener = Owner = node;
  try {
    nextValue = node.fn(value);
  } catch (err) {
    if (node.pure) {
      {
        node.state = STALE;
        node.owned && node.owned.forEach(cleanNode);
        node.owned = null;
      }
    }
    node.updatedAt = time + 1;
    return handleError(err);
  } finally {
    Listener = listener;
    Owner = owner;
  }
  if (!node.updatedAt || node.updatedAt <= time) {
    if (node.updatedAt != null && "observers" in node) {
      writeSignal(node, nextValue);
    } else node.value = nextValue;
    node.updatedAt = time;
  }
}
function createComputation(fn, init, pure, state = STALE, options) {
  const c = {
    fn,
    state: state,
    updatedAt: null,
    owned: null,
    sources: null,
    sourceSlots: null,
    cleanups: null,
    value: init,
    owner: Owner,
    context: Owner ? Owner.context : null,
    pure
  };
  if (Owner === null) ;else if (Owner !== UNOWNED) {
    {
      if (!Owner.owned) Owner.owned = [c];else Owner.owned.push(c);
    }
  }
  return c;
}
function runTop(node) {
  if ((node.state) === 0) return;
  if ((node.state) === PENDING) return lookUpstream(node);
  if (node.suspense && untrack(node.suspense.inFallback)) return node.suspense.effects.push(node);
  const ancestors = [node];
  while ((node = node.owner) && (!node.updatedAt || node.updatedAt < ExecCount)) {
    if (node.state) ancestors.push(node);
  }
  for (let i = ancestors.length - 1; i >= 0; i--) {
    node = ancestors[i];
    if ((node.state) === STALE) {
      updateComputation(node);
    } else if ((node.state) === PENDING) {
      const updates = Updates;
      Updates = null;
      runUpdates(() => lookUpstream(node, ancestors[0]), false);
      Updates = updates;
    }
  }
}
function runUpdates(fn, init) {
  if (Updates) return fn();
  let wait = false;
  if (!init) Updates = [];
  if (Effects) wait = true;else Effects = [];
  ExecCount++;
  try {
    const res = fn();
    completeUpdates(wait);
    return res;
  } catch (err) {
    if (!wait) Effects = null;
    Updates = null;
    handleError(err);
  }
}
function completeUpdates(wait) {
  if (Updates) {
    runQueue(Updates);
    Updates = null;
  }
  if (wait) return;
  const e = Effects;
  Effects = null;
  if (e.length) runUpdates(() => runEffects(e), false);
}
function runQueue(queue) {
  for (let i = 0; i < queue.length; i++) runTop(queue[i]);
}
function lookUpstream(node, ignore) {
  node.state = 0;
  for (let i = 0; i < node.sources.length; i += 1) {
    const source = node.sources[i];
    if (source.sources) {
      const state = source.state;
      if (state === STALE) {
        if (source !== ignore && (!source.updatedAt || source.updatedAt < ExecCount)) runTop(source);
      } else if (state === PENDING) lookUpstream(source, ignore);
    }
  }
}
function markDownstream(node) {
  for (let i = 0; i < node.observers.length; i += 1) {
    const o = node.observers[i];
    if (!o.state) {
      o.state = PENDING;
      if (o.pure) Updates.push(o);else Effects.push(o);
      o.observers && markDownstream(o);
    }
  }
}
function cleanNode(node) {
  let i;
  if (node.sources) {
    while (node.sources.length) {
      const source = node.sources.pop(),
        index = node.sourceSlots.pop(),
        obs = source.observers;
      if (obs && obs.length) {
        const n = obs.pop(),
          s = source.observerSlots.pop();
        if (index < obs.length) {
          n.sourceSlots[s] = index;
          obs[index] = n;
          source.observerSlots[index] = s;
        }
      }
    }
  }
  if (node.tOwned) {
    for (i = node.tOwned.length - 1; i >= 0; i--) cleanNode(node.tOwned[i]);
    delete node.tOwned;
  }
  if (node.owned) {
    for (i = node.owned.length - 1; i >= 0; i--) cleanNode(node.owned[i]);
    node.owned = null;
  }
  if (node.cleanups) {
    for (i = node.cleanups.length - 1; i >= 0; i--) node.cleanups[i]();
    node.cleanups = null;
  }
  node.state = 0;
}
function castError(err) {
  if (err instanceof Error) return err;
  return new Error(typeof err === "string" ? err : "Unknown error", {
    cause: err
  });
}
function handleError(err, owner = Owner) {
  const error = castError(err);
  throw error;
}
function createComponent(Comp, props) {
  return untrack(() => Comp(props || {}));
}
function trueFn() {
  return true;
}
const propTraps = {
  get(_, property, receiver) {
    if (property === $PROXY) return receiver;
    return _.get(property);
  },
  has(_, property) {
    if (property === $PROXY) return true;
    return _.has(property);
  },
  set: trueFn,
  deleteProperty: trueFn,
  getOwnPropertyDescriptor(_, property) {
    return {
      configurable: true,
      enumerable: true,
      get() {
        return _.get(property);
      },
      set: trueFn,
      deleteProperty: trueFn
    };
  },
  ownKeys(_) {
    return _.keys();
  }
};
function resolveSource(s) {
  return !(s = typeof s === "function" ? s() : s) ? {} : s;
}
function resolveSources() {
  for (let i = 0, length = this.length; i < length; ++i) {
    const v = this[i]();
    if (v !== undefined) return v;
  }
}
function mergeProps(...sources) {
  let proxy = false;
  for (let i = 0; i < sources.length; i++) {
    const s = sources[i];
    proxy = proxy || !!s && $PROXY in s;
    sources[i] = typeof s === "function" ? (proxy = true, createMemo(s)) : s;
  }
  if (SUPPORTS_PROXY && proxy) {
    return new Proxy({
      get(property) {
        for (let i = sources.length - 1; i >= 0; i--) {
          const v = resolveSource(sources[i])[property];
          if (v !== undefined) return v;
        }
      },
      has(property) {
        for (let i = sources.length - 1; i >= 0; i--) {
          if (property in resolveSource(sources[i])) return true;
        }
        return false;
      },
      keys() {
        const keys = [];
        for (let i = 0; i < sources.length; i++) keys.push(...Object.keys(resolveSource(sources[i])));
        return [...new Set(keys)];
      }
    }, propTraps);
  }
  const sourcesMap = {};
  const defined = Object.create(null);
  for (let i = sources.length - 1; i >= 0; i--) {
    const source = sources[i];
    if (!source) continue;
    const sourceKeys = Object.getOwnPropertyNames(source);
    for (let i = sourceKeys.length - 1; i >= 0; i--) {
      const key = sourceKeys[i];
      if (key === "__proto__" || key === "constructor") continue;
      const desc = Object.getOwnPropertyDescriptor(source, key);
      if (!defined[key]) {
        defined[key] = desc.get ? {
          enumerable: true,
          configurable: true,
          get: resolveSources.bind(sourcesMap[key] = [desc.get.bind(source)])
        } : desc.value !== undefined ? desc : undefined;
      } else {
        const sources = sourcesMap[key];
        if (sources) {
          if (desc.get) sources.push(desc.get.bind(source));else if (desc.value !== undefined) sources.push(() => desc.value);
        }
      }
    }
  }
  const target = {};
  const definedKeys = Object.keys(defined);
  for (let i = definedKeys.length - 1; i >= 0; i--) {
    const key = definedKeys[i],
      desc = defined[key];
    if (desc && desc.get) Object.defineProperty(target, key, desc);else target[key] = desc ? desc.value : undefined;
  }
  return target;
}
function splitProps(props, ...keys) {
  if (SUPPORTS_PROXY && $PROXY in props) {
    const blocked = new Set(keys.length > 1 ? keys.flat() : keys[0]);
    const res = keys.map(k => {
      return new Proxy({
        get(property) {
          return k.includes(property) ? props[property] : undefined;
        },
        has(property) {
          return k.includes(property) && property in props;
        },
        keys() {
          return k.filter(property => property in props);
        }
      }, propTraps);
    });
    res.push(new Proxy({
      get(property) {
        return blocked.has(property) ? undefined : props[property];
      },
      has(property) {
        return blocked.has(property) ? false : property in props;
      },
      keys() {
        return Object.keys(props).filter(k => !blocked.has(k));
      }
    }, propTraps));
    return res;
  }
  const otherObject = {};
  const objects = keys.map(() => ({}));
  for (const propName of Object.getOwnPropertyNames(props)) {
    const desc = Object.getOwnPropertyDescriptor(props, propName);
    const isDefaultDesc = !desc.get && !desc.set && desc.enumerable && desc.writable && desc.configurable;
    let blocked = false;
    let objectIndex = 0;
    for (const k of keys) {
      if (k.includes(propName)) {
        blocked = true;
        isDefaultDesc ? objects[objectIndex][propName] = desc.value : Object.defineProperty(objects[objectIndex], propName, desc);
      }
      ++objectIndex;
    }
    if (!blocked) {
      isDefaultDesc ? otherObject[propName] = desc.value : Object.defineProperty(otherObject, propName, desc);
    }
  }
  return [...objects, otherObject];
}

const memo = fn => createMemo(() => fn());

function createRenderer$1({
  createElement,
  createTextNode,
  isTextNode,
  replaceText,
  insertNode,
  removeNode,
  setProperty,
  getParentNode,
  getFirstChild,
  getNextSibling
}) {
  function insert(parent, accessor, marker, initial) {
    if (marker !== undefined && !initial) initial = [];
    if (typeof accessor !== "function") return insertExpression(parent, accessor, initial, marker);
    createRenderEffect(current => insertExpression(parent, accessor(), current, marker), initial);
  }
  function insertExpression(parent, value, current, marker, unwrapArray) {
    while (typeof current === "function") current = current();
    if (value === current) return current;
    const t = typeof value,
      multi = marker !== undefined;
    if (t === "string" || t === "number") {
      if (t === "number") value = value.toString();
      if (multi) {
        let node = current[0];
        if (node && isTextNode(node)) {
          replaceText(node, value);
        } else node = createTextNode(value);
        current = cleanChildren(parent, current, marker, node);
      } else {
        if (current !== "" && typeof current === "string") {
          replaceText(getFirstChild(parent), current = value);
        } else {
          cleanChildren(parent, current, marker, createTextNode(value));
          current = value;
        }
      }
    } else if (value == null || t === "boolean") {
      current = cleanChildren(parent, current, marker);
    } else if (t === "function") {
      createRenderEffect(() => {
        let v = value();
        while (typeof v === "function") v = v();
        current = insertExpression(parent, v, current, marker);
      });
      return () => current;
    } else if (Array.isArray(value)) {
      const array = [];
      if (normalizeIncomingArray(array, value, unwrapArray)) {
        createRenderEffect(() => current = insertExpression(parent, array, current, marker, true));
        return () => current;
      }
      if (array.length === 0) {
        const replacement = cleanChildren(parent, current, marker);
        if (multi) return current = replacement;
      } else {
        if (Array.isArray(current)) {
          if (current.length === 0) {
            appendNodes(parent, array, marker);
          } else reconcileArrays(parent, current, array);
        } else if (current == null || current === "") {
          appendNodes(parent, array);
        } else {
          reconcileArrays(parent, multi && current || [getFirstChild(parent)], array);
        }
      }
      current = array;
    } else {
      if (Array.isArray(current)) {
        if (multi) return current = cleanChildren(parent, current, marker, value);
        cleanChildren(parent, current, null, value);
      } else if (current == null || current === "" || !getFirstChild(parent)) {
        insertNode(parent, value);
      } else replaceNode(parent, value, getFirstChild(parent));
      current = value;
    }
    return current;
  }
  function normalizeIncomingArray(normalized, array, unwrap) {
    let dynamic = false;
    for (let i = 0, len = array.length; i < len; i++) {
      let item = array[i],
        t;
      if (item == null || item === true || item === false) ; else if (Array.isArray(item)) {
        dynamic = normalizeIncomingArray(normalized, item) || dynamic;
      } else if ((t = typeof item) === "string" || t === "number") {
        normalized.push(createTextNode(item));
      } else if (t === "function") {
        if (unwrap) {
          while (typeof item === "function") item = item();
          dynamic = normalizeIncomingArray(normalized, Array.isArray(item) ? item : [item]) || dynamic;
        } else {
          normalized.push(item);
          dynamic = true;
        }
      } else normalized.push(item);
    }
    return dynamic;
  }
  function reconcileArrays(parentNode, a, b) {
    let bLength = b.length,
      aEnd = a.length,
      bEnd = bLength,
      aStart = 0,
      bStart = 0,
      after = getNextSibling(a[aEnd - 1]),
      map = null;
    while (aStart < aEnd || bStart < bEnd) {
      if (a[aStart] === b[bStart]) {
        aStart++;
        bStart++;
        continue;
      }
      while (a[aEnd - 1] === b[bEnd - 1]) {
        aEnd--;
        bEnd--;
      }
      if (aEnd === aStart) {
        const node = bEnd < bLength ? bStart ? getNextSibling(b[bStart - 1]) : b[bEnd - bStart] : after;
        while (bStart < bEnd) insertNode(parentNode, b[bStart++], node);
      } else if (bEnd === bStart) {
        while (aStart < aEnd) {
          if (!map || !map.has(a[aStart])) removeNode(parentNode, a[aStart]);
          aStart++;
        }
      } else if (a[aStart] === b[bEnd - 1] && b[bStart] === a[aEnd - 1]) {
        const node = getNextSibling(a[--aEnd]);
        insertNode(parentNode, b[bStart++], getNextSibling(a[aStart++]));
        insertNode(parentNode, b[--bEnd], node);
        a[aEnd] = b[bEnd];
      } else {
        if (!map) {
          map = new Map();
          let i = bStart;
          while (i < bEnd) map.set(b[i], i++);
        }
        const index = map.get(a[aStart]);
        if (index != null) {
          if (bStart < index && index < bEnd) {
            let i = aStart,
              sequence = 1,
              t;
            while (++i < aEnd && i < bEnd) {
              if ((t = map.get(a[i])) == null || t !== index + sequence) break;
              sequence++;
            }
            if (sequence > index - bStart) {
              const node = a[aStart];
              while (bStart < index) insertNode(parentNode, b[bStart++], node);
            } else replaceNode(parentNode, b[bStart++], a[aStart++]);
          } else aStart++;
        } else removeNode(parentNode, a[aStart++]);
      }
    }
  }
  function cleanChildren(parent, current, marker, replacement) {
    if (marker === undefined) {
      let removed;
      while (removed = getFirstChild(parent)) removeNode(parent, removed);
      replacement && insertNode(parent, replacement);
      return "";
    }
    const node = replacement || createTextNode("");
    if (current.length) {
      let inserted = false;
      for (let i = current.length - 1; i >= 0; i--) {
        const el = current[i];
        if (node !== el) {
          const isParent = getParentNode(el) === parent;
          if (!inserted && !i) isParent ? replaceNode(parent, node, el) : insertNode(parent, node, marker);else isParent && removeNode(parent, el);
        } else inserted = true;
      }
    } else insertNode(parent, node, marker);
    return [node];
  }
  function appendNodes(parent, array, marker) {
    for (let i = 0, len = array.length; i < len; i++) insertNode(parent, array[i], marker);
  }
  function replaceNode(parent, newNode, oldNode) {
    insertNode(parent, newNode, oldNode);
    removeNode(parent, oldNode);
  }
  function spreadExpression(node, props, prevProps = {}, skipChildren) {
    props || (props = {});
    if (!skipChildren) {
      createRenderEffect(() => prevProps.children = insertExpression(node, props.children, prevProps.children));
    }
    createRenderEffect(() => props.ref && props.ref(node));
    createRenderEffect(() => {
      for (const prop in props) {
        if (prop === "children" || prop === "ref") continue;
        const value = props[prop];
        if (value === prevProps[prop]) continue;
        setProperty(node, prop, value, prevProps[prop]);
        prevProps[prop] = value;
      }
    });
    return prevProps;
  }
  return {
    render(code, element) {
      let disposer;
      createRoot(dispose => {
        disposer = dispose;
        insert(element, code());
      });
      return disposer;
    },
    insert,
    spread(node, accessor, skipChildren) {
      if (typeof accessor === "function") {
        createRenderEffect(current => spreadExpression(node, accessor(), current, skipChildren));
      } else spreadExpression(node, accessor, undefined, skipChildren);
    },
    createElement,
    createTextNode,
    insertNode,
    setProp(node, name, value, prev) {
      setProperty(node, name, value, prev);
      return value;
    },
    mergeProps,
    effect: createRenderEffect,
    memo,
    createComponent,
    use(fn, element, arg) {
      return untrack(() => fn(element, arg));
    }
  };
}

function createRenderer(options) {
  const renderer = createRenderer$1(options);
  renderer.mergeProps = mergeProps;
  return renderer;
}

const StyleKeyAutoConvertToPixelList = [
    'x',
    'y',
    'z',
    'width',
    'height',
    'minHeight',
    'maxHeight',
    'minWidth',
    'maxWidth',
    'border-radius',
    'borderRadius',
    'fontSize',
    'lineHeight',
    'margin',
    'marginBottom',
    'marginLeft',
    'marginRight',
    'marginTop',
    'padding',
    'paddingBottom',
    'paddingLeft',
    'paddingRight',
    'paddingTop'
];

const hasOwn = Object.prototype.hasOwnProperty;
const nodeTrash = (function () {
    let root = $.GetContextPanel();
    while (root.GetParent()) {
        root = root.GetParent();
    }
    let trashing = () => {
        nodeTrash.RemoveAndDeleteChildren();
        $.Schedule(0, trashing);
    };
    $.Schedule(0, trashing);
    return $.CreatePanel('Panel', root, '', {
        style: 'visibility: collapse;'
    });
})();
const { render: _render} = createRenderer({
    createElement(type, props, parent) {
        return untrack(() => {
            const [{ id, snippet, vars, dialogVariables, style, visible, enabled, checked, type: _type, }, _props] = splitProps(props, ['id', 'snippet', 'vars', 'dialogVariables', 'style', 'visible', 'enabled', 'checked', 'children', 'type']);
            const styleIsString = typeof style === 'string';
            if (styleIsString) {
                props.style = style;
            }
            if (type === 'GenericPanel') {
                type = _type;
            }
            const el = $.CreatePanel(type, parent || $.GetContextPanel(), id || '', { ..._props });
            if (typeof visible === 'boolean') {
                el.visible = visible;
            }
            if (typeof enabled === 'boolean') {
                el.enabled = enabled;
            }
            if (typeof checked === 'boolean') {
                el.checked = checked;
            }
            if (type != 'TextEntry') {
                el.SetDisableFocusOnMouseDown(true);
            }
            if (!styleIsString) {
                applyStyles(el, style);
            }
            if (snippet) {
                el.BLoadLayoutSnippet(snippet);
            }
            if (vars) {
                setDialogVariables(el, vars, {});
            }
            if (dialogVariables) {
                setDialogVariables(el, dialogVariables, {});
            }
            if (props.text) {
                const lab = getLabelNode(el);
                if (lab) {
                    lab.__solidText = props.text;
                }
            }
            return el;
        });
    },
    createTextNode(value, parent) {
        return;
    },
    replaceText(textNode, value) {
        if (!textNode || !textNode.IsValid()) {
            return;
        }
        setText(textNode, value);
    },
    isTextNode(node) {
        if (!node || !node.IsValid()) {
            return false;
        }
        return node.paneltype === 'Label';
    },
    insertNode(parent, node, anchor) {
        if (!parent || !parent.IsValid() || !node || !node.IsValid()) {
            return;
        }
        node.SetParent(parent);
        if (anchor && anchor.IsValid()) {
            parent.MoveChildBefore(node, anchor);
        }
    },
    removeNode(parent, node) {
        if (!parent || !parent.IsValid() || !node || !node.IsValid()) {
            return;
        }
        node.SetParent(nodeTrash);
    },
    getParentNode(node) {
        if (!node || !node.IsValid()) {
            return;
        }
        const parent = node.GetParent();
        if (parent) {
            return parent;
        }
    },
    getFirstChild(node) {
        if (!node || !node.IsValid()) {
            return;
        }
        const child = node.GetChild(0);
        if (!child) {
            return;
        }
        return child;
    },
    getNextSibling(node) {
        if (!node || !node.IsValid()) {
            return;
        }
        const parent = node.GetParent();
        if (!parent) {
            return;
        }
        const el = parent.GetChild(parent.GetChildIndex(node) + 1);
        if (!el) {
            return;
        }
        return el;
    },
    setProperty(node, name, value, prev) {
        if (!node || !node.IsValid()) {
            return;
        }
        if (name === 'id') {
            return;
        }
        if (name === 'class' || name === 'className') {
            applyClassNames(node, value || '', prev || '');
        }
        else if (name === 'text') {
            setText(node, value);
        }
        else if (name === 'src' && node.SetImage) {
            node.SetImage(value);
        }
        else if (name === 'classList') {
            updateClassList(node, value, prev);
        }
        else if (name === 'style') {
            applyStyles(node, value, prev);
        }
        else if (name === 'vars' || name === 'dialogVariables') {
            setDialogVariables(node, value, prev);
        }
        else if (name === 'attrs') {
            setAttributes(node, value);
        }
        else if (name === 'inputnamespace') {
            node.SetInputNamespace(value || '');
        }
        else if (name === 'draggable') {
            node.SetDraggable(value === true);
        }
        else if (name === 'acceptsfocus') {
            node.SetAcceptsFocus(value === true);
        }
        else if (name.startsWith('data-')) {
            setData(node, name.slice(5), value);
        }
        else if (name.startsWith('on')) {
            setPanelEvent(node, name, value);
        }
        else {
            if (hasOwn.call(node, name)) {
                node[name] = value;
            }
            else {
                node.SetAttributeString(name, String(value));
            }
        }
    }
});
function render(code, container) {
    if (container.__solidDisposer) {
        container.__solidDisposer();
        container.RemoveAndDeleteChildren();
    }
    Object.defineProperty(container, '__solidDisposer', {
        configurable: true,
        value: _render(code, container)
    });
    return container.__solidDisposer;
}
const splitClassName = /\s+/;
function applyClassNames(node, names, prev) {
    const nameList = names.split(splitClassName);
    const oldList = prev.split(splitClassName);
    for (let i = oldList.length - 1; i >= 0; i--) {
        const name = oldList[i];
        if (nameList.includes(name)) {
            continue;
        }
        else {
            node.RemoveClass(name);
        }
    }
    for (const name of nameList) {
        node.AddClass(name);
    }
}
function updateClassList(node, state, prev) {
    state = state || {};
    if (prev) {
        for (const k in prev) {
            if (state[k] === undefined) {
                node.RemoveClass(k);
            }
        }
    }
    for (const k in state) {
        node.SetHasClass(k, state[k] === true);
    }
}
function applyStyles(node, styles, prev) {
    styles = styles || {};
    prev = prev || {};
    for (const k in prev) {
        if (!hasOwn.call(styles, k)) {
            node.style[k] = null;
        }
    }
    for (const k in styles) {
        if (typeof styles[k] === 'number') {
            if (StyleKeyAutoConvertToPixelList.includes(k)) {
                node.style[k] = `${styles[k]}px`;
                continue;
            }
        }
        node.style[k] = styles[k] === undefined ? null : styles[k];
    }
}
function setPanelEvent(node, event, handle) {
    if (!handle) {
        node.ClearPanelEvent(event);
        return;
    }
    node.SetPanelEvent(event, function () {
        handle(node);
    });
}
const PANORAMA_INVALID_DATE = 2 ** 52;
function setDialogVariables(node, vars, prev) {
    prev = prev || {};
    for (const key in prev) {
        if (!vars[key]) {
            const value = prev[key];
            if (value != undefined) {
                if (typeof value === 'string') {
                    node.SetDialogVariable(key, `[!s:${key}]`);
                }
                else if (typeof value === 'number') {
                    node.SetDialogVariableInt(key, NaN);
                }
                else {
                    node.SetDialogVariableTime(key, PANORAMA_INVALID_DATE);
                }
            }
        }
    }
    for (const key in vars) {
        const value = vars[key];
        if (value != undefined) {
            if (typeof value === 'string') {
                if (value[0] === '#') {
                    node.SetDialogVariableLocString(key, value);
                }
                else {
                    node.SetDialogVariable(key, value);
                }
            }
            else if (typeof value === 'number') {
                node.SetDialogVariableInt(key, value);
            }
            else {
                node.SetDialogVariableTime(key, Math.floor(value.getTime() / 1000));
            }
        }
    }
}
function setAttributes(node, attrs) {
    for (const key in attrs) {
        const value = attrs[key];
        if (typeof value === 'number') {
            node.SetAttributeInt(key, value);
        }
        else {
            node.SetAttributeString(key, value);
        }
    }
}
function setData(node, key, v) {
    if (!node.Data) {
        const data = {};
        Object.defineProperty(node, 'Data', {
            configurable: true,
            enumerable: true,
            writable: true,
            value: function () {
                return data;
            }
        });
    }
    node.Data()[key] = v;
}
function getLabelNode(node) {
    let lab;
    if (node.paneltype == 'Label') {
        lab = node;
    }
    else if (node.paneltype == 'TextButton') {
        lab = node.GetChild(0);
    }
    else if (node.paneltype == 'RadioButton') {
        lab = node.GetChild(1);
    }
    return lab;
}
function setText(node, text) {
    const lab = getLabelNode(node);
    if (lab) {
        if (lab.__solidText != text) {
            lab.__solidText = text;
            if (lab.html) {
                if (text[0] === '#') {
                    lab.text = $.Localize(text, node);
                }
                else {
                    lab.text = text;
                }
            }
            else {
                lab.SetAlreadyLocalizedText(text);
            }
        }
    }
}

var _a, _b, _c, _d, _e, _f;
if (GameUI.CustomUIConfig().tools == undefined)
    GameUI.CustomUIConfig().tools = {};
ENV_NAME = $.GetContextPanel().layoutfile;
(_a = class extends GameUI.CustomUIConfig().tools.EventManager {
    },
    __setFunctionName(_a, "EventManager"),
    _a.sEnvName = ENV_NAME,
    _a);
(_b = class extends GameUI.CustomUIConfig().tools.NetEventData {
    },
    __setFunctionName(_b, "NetEventData"),
    _b.sEnvName = ENV_NAME,
    _b);
(_c = class extends GameUI.CustomUIConfig().tools.Keybinds {
    },
    __setFunctionName(_c, "Keybinds"),
    _c.sEnvName = ENV_NAME,
    _c);
(_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {
    },
    __setFunctionName(_d, "Mousebinds"),
    _d.sEnvName = ENV_NAME,
    _d);
GameUI.CustomUIConfig().tools.ParticleManager_s2c;
GameUI.CustomUIConfig().tools.AttributeSystem;
GameUI.CustomUIConfig().tools.AttributeKind;
var _Timer = (_e = class extends GameUI.CustomUIConfig().tools.Timer {
    },
    __setFunctionName(_e, "_Timer"),
    _e.sEnvName = ENV_NAME,
    _e);
var Timer = _Timer.Timer.bind(_Timer);
_Timer.GameTimer.bind(_Timer);
var StopTimer = _Timer.StopTimer.bind(_Timer);
var _Player = GameUI.CustomUIConfig().tools.Player;
_Player.PlayerCount.bind(_Player);
_Player.PlayerHost.bind(_Player);
_Player.PlayerCount_NotDisconnected.bind(_Player);
_Player.PlayerCount_NotAbandoned.bind(_Player);
_Player.IsValidPlayer.bind(_Player);
_Player.IsFakePlayer.bind(_Player);
_Player.EachPlayer.bind(_Player);
_Player.RandomPlayer.bind(_Player);
var FocusPlayer = _Player.FocusPlayer.bind(_Player);
_Player.IsPlayerDisconnected.bind(_Player);
_Player.IsPlayerAbandoned.bind(_Player);
_Player.Player_EntityToID.bind(_Player);
_Player.Player_IDToOrder.bind(_Player);
_Player.Player_OrderToID.bind(_Player);
_Player.Player_IDToAccount.bind(_Player);
_Player.Player_AccountToID.bind(_Player);
_Player.PlayerLanguage.bind(_Player);
GameUI.CustomUIConfig().tools.runlua;
GameUI.CustomUIConfig().tools.EntIndexToHScript;
GameUI.CustomUIConfig().tools.BuffToModifier;
GameUI.CustomUIConfig().tools.PolymerIDToDiyPolymer;
var AbilitiesKv = GameUI.CustomUIConfig()['AbilitiesKv'];
GameUI.CustomUIConfig()['HeroesKv'];
var UnitsKv = GameUI.CustomUIConfig()['UnitsKv'];
var ItemsKv = GameUI.CustomUIConfig()['ItemsKv'];
GameUI.CustomUIConfig()['WearableKv'];
GameUI.CustomUIConfig()['CustomHeroesKv'];
GameUI.CustomUIConfig()['GameItemsKv'];
(() => {
    const tID2Kv = {};
    for (const t of [
        AbilitiesKv,
        ItemsKv,
        UnitsKv,
    ]) {
        for (const k in t) {
            let t2 = t[k];
            if (typeof (t2) == 'object' && t2['id'] != undefined) {
                tID2Kv[t2['id']] = t2;
            }
        }
    }
    return (id) => tID2Kv[id];
})();
GameUI.CustomUIConfig().tools.Request;
GameUI.CustomUIConfig().tools.UnregRequest;
(_f = class extends GameUI.CustomUIConfig().tools.ScreenPanel {
        static render(code, node) {
            return render(code, node);
        }
    },
    __setFunctionName(_f, "ScreenPanel"),
    _f.pEnvContextPanel = $.GetContextPanel(),
    _f);
GameUI.CustomUIConfig().tools.WindowManager;
GameUI.CustomUIConfig().UploadError;

function FindDotaHudElement(id) {
    let p = GameUI.CustomUIConfig()['DotaHud'];
    if (p == undefined) {
        p = $.GetContextPanel();
        while (p.id != "Hud" && p.GetParent() != null) {
            p = p.GetParent();
        }
        GameUI.CustomUIConfig()['DotaHud'] = p;
    }
    return p.FindChildTraverse(id);
}
function Round(fNumber, prec = 0) {
    let i = Math.pow(10, prec);
    return Math.round(fNumber * i) / i;
}

var Digit;
(function (Digit) {
    Digit[Digit["K"] = 1] = "K";
    Digit[Digit["M"] = 2] = "M";
    Digit[Digit["G"] = 3] = "G";
    Digit[Digit["T"] = 4] = "T";
    Digit[Digit["P"] = 5] = "P";
    Digit[Digit["E"] = 6] = "E";
    Digit[Digit["Z"] = 7] = "Z";
    Digit[Digit["Y"] = 8] = "Y";
    Digit[Digit["R"] = 9] = "R";
})(Digit || (Digit = {}));
var DigitSchinese;
(function (DigitSchinese) {
    DigitSchinese[DigitSchinese["万"] = 1] = "万";
    DigitSchinese[DigitSchinese["亿"] = 2] = "亿";
    DigitSchinese[DigitSchinese["兆"] = 3] = "兆";
    DigitSchinese[DigitSchinese["京"] = 4] = "京";
    DigitSchinese[DigitSchinese["垓"] = 5] = "垓";
    DigitSchinese[DigitSchinese["秭"] = 6] = "秭";
    DigitSchinese[DigitSchinese["穰"] = 7] = "穰";
    DigitSchinese[DigitSchinese["沟"] = 8] = "沟";
    DigitSchinese[DigitSchinese["涧"] = 9] = "涧";
})(DigitSchinese || (DigitSchinese = {}));
function FormatNumber(fNumber, prec = 2) {
    let sSign = fNumber < 0 ? "-" : "";
    fNumber = Math.abs(fNumber);
    let sNumber = NumberToString(Math.abs(fNumber));
    let a = sNumber.split(".");
    let sInteger = a[0];
    let sLanguage = $.Language().toLowerCase();
    if (sLanguage == "schinese") {
        let n = Math.floor((sInteger.length - 1) / 4);
        if (n == 0) {
            return sSign + NumberToString(Round(fNumber, prec));
        }
        sNumber = NumberToString(Round(fNumber / Math.pow(10000, n), prec));
        let sDigit = DigitSchinese[n];
        if (sDigit == undefined) {
            sDigit = `e+${4 * n}`;
        }
        return sSign + sNumber + sDigit;
    }
    else {
        let n = Math.floor((sInteger.length - 1) / 3);
        if (n == 0) {
            return sSign + NumberToString(Round(fNumber, prec));
        }
        sNumber = NumberToString(Round(fNumber / Math.pow(1000, n), prec));
        let sDigit = Digit[n];
        if (sDigit == undefined) {
            sDigit = `e+${3 * n}`;
        }
        return sSign + sNumber + sDigit;
    }
}
function NumberToString(fNumber) {
    let sNumber = String(fNumber);
    if (sNumber.indexOf("e+") != -1) {
        let s = sNumber.split("e+");
        s[0] = s[0].replace(/\./g, "");
        let n = finiteNumber(Number(s[1])) + 1;
        for (let index = s[0].length; index < n; index++) {
            s[0] += "0";
        }
        sNumber = s[0];
    }
    return sNumber;
}
function finiteNumber(i, defaultVar = 0) {
    return isFinite(i) ? i : defaultVar;
}

function findStringWrapped(text, start, end, pos = 0) {
    let stack = 0;
    let start_index = -1;
    for (let i = pos; i < text.length; i++) {
        if (text[i] == start) {
            if (stack++ == 0) {
                start_index = i;
            }
        }
        else if (text[i] == end) {
            if (stack > 0) {
                if (--stack == 0) {
                    return [text.slice(start_index + 1, i), start_index, i + 1];
                }
            }
        }
    }
    return [];
}
function ReplaceTextVariable(text, variables, notSpanVal = false) {
    var _a;
    if (text[0] == '#') {
        text = $.Localize(text, $.GetContextPanel());
    }
    if (typeof variables != 'object') {
        variables = { 'val': variables };
    }
    for (const key in variables) {
        const val = variables[key];
        if (notSpanVal) {
            if (typeof val == 'number') {
                text = text.replace(new RegExp(`\\[${key}\]%`, 'gm'), Number(val.toFixed(2)).toString() + '%');
                text = text.replace(new RegExp(`\\[${key}\]`, 'g'), Number(val.toFixed(2)).toString());
            }
            else {
                text = text.replace(new RegExp(`\\[${key}\]`, 'g'), val);
            }
        }
        else {
            if (typeof val == 'number') {
                text = text.replace(new RegExp(`\\[${key}\]%`, 'gm'), SpanText(SpanText(SpanText(Number(val.toFixed(2)).toString() + '%', 'CurLvl'), 'GameplayVariable'), 'GameplayValues'));
                text = text.replace(new RegExp(`\\[${key}\]`, 'g'), SpanText(SpanText(SpanText(Number(val.toFixed(2)).toString(), 'CurLvl'), 'GameplayVariable'), 'GameplayValues'));
            }
            else {
                text = text.replace(new RegExp(`\\[${key}\]`, 'g'), SpanText(SpanText(SpanText(val, 'CurLvl'), 'GameplayVariable'), 'GameplayValues'));
            }
        }
    }
    const types = {
        'MATH': {
            'process': (s) => {
                const sMath = s.slice(5, -1).replace(/<\/?[\w\s="'-]+\/?>/g, '');
                $.GetContextPanel().RunScriptInPanelContext(`GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'] = ${sMath}`);
                let f = GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'];
                if (f != undefined) {
                    if (notSpanVal) {
                        return String(parseFloat((f).toFixed(2)));
                    }
                    else {
                        return SpanText(SpanText(SpanText(String(parseFloat((f).toFixed(2))), 'CurLvl'), 'GameplayVariable'), 'GameplayValues');
                    }
                }
            },
        },
        'NOHTML': {
            'process': (s) => {
                return s.slice(7, -1).replace(/<\/?.+?\/?>/g, '');
            }
        },
        'ISNUMB': {
            'process': (s) => {
                let [s2, start] = findStringWrapped(s, '(', ')', 6);
                s2 = s2.replace(/<\/?.+?\/?>/g, '');
                return s.slice(0, start - 6) + String(!Number.isNaN(Number(s2)));
            }
        },
        'SHOW': {
            'process': (s) => {
                const [s2, start, end] = findStringWrapped(s, '(', ')', 4);
                const text = s.slice(end);
                $.GetContextPanel().RunScriptInPanelContext(`
                    delete GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'];
                    GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'] = ${s2};
                    `);
                if (!!GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'])
                    return text;
                return '';
            }
        },
        'LOCALIZE': {
            'process': (s) => {
                return ReplaceTextVariable('#' + s.slice(9, -1), variables);
            }
        },
    };
    const process = (text) => {
        let bChange = false;
        let i = 0;
        while (true) {
            let [s, start, end] = findStringWrapped(text, `[`, ']', i);
            if (s == undefined)
                break;
            let bChange2 = false;
            let s2 = process(s);
            if (s2) {
                bChange2 = true;
                s = s2;
            }
            for (const func_name in types) {
                let [s2, start] = findStringWrapped(s, '(', ')');
                if (s2 != undefined && s.slice(start - func_name.length, start) == func_name) {
                    const sResult = types[func_name].process(s);
                    if (sResult != undefined) {
                        s = sResult;
                        bChange2 = true;
                    }
                    break;
                }
            }
            if (bChange2) {
                bChange = true;
                text = text.slice(0, start) + s + text.slice(end);
                i = start + s.length;
            }
            else {
                i = end;
            }
        }
        if (bChange) {
            return text;
        }
    };
    return (_a = process(text)) !== null && _a !== void 0 ? _a : text;
}
function SpanText(text, className = "") {
    return `<span class="${className}">${text}</span>`;
}
function StringLocalize(s) {
    var _a;
    ((_a = s.match(/LOCALIZE\(.*?\)/g)) !== null && _a !== void 0 ? _a : []).forEach((s2) => {
        s = s.replace(s2, $.Localize("#" + s2.slice(9, -1)));
    });
    return s;
}

function ReplaceAbltSpecialVals(sAblt, s, iLevel = 1, bCurLevelSpecial = false, iEntID) {
    var _a;
    const tKv = (_a = AbilitiesKv[sAblt]) !== null && _a !== void 0 ? _a : ItemsKv[sAblt];
    if (!tKv || tKv.AbilityValues == undefined)
        return s;
    let tAbilityValues = tKv.AbilityValues;
    s = ReplaceTextVariable(s, tAbilityValues);
    for (const sKey in tAbilityValues) {
        let tVals = String(tAbilityValues[sKey]).split(' ');
        let s2 = '';
        if (bCurLevelSpecial) {
            let sVal = tVals[Math.min(iLevel - 1, tVals.length - 1)];
            s2 = SpanText(`${sVal}%`, 'CurLvl');
        }
        else {
            for (let i = 0; i < tVals.length; ++i) {
                const iLevel2 = i + 1;
                if (iLevel2 == iLevel || (iLevel2 == tVals.length && tVals.length < iLevel)) {
                    s2 += SpanText(tVals[i] + '%', 'CurLvl') + ' / ';
                }
                else {
                    s2 += tVals[i] + '% / ';
                }
            }
            s2 = s2.slice(0, -3);
        }
        s2 = SpanText(SpanText(s2, 'GameplayVariable'), 'GameplayValues');
        s = s.replace(new RegExp(`%${sKey}%%%`, 'gm'), s2);
        s2 = '';
        if (bCurLevelSpecial) {
            let sVal = tVals[Math.min(iLevel - 1, tVals.length - 1)];
            s2 = SpanText(sVal, 'CurLvl');
        }
        else {
            for (let i = 0; i < tVals.length; ++i) {
                const iLevel2 = i + 1;
                if (iLevel2 == iLevel || (iLevel2 == tVals.length && tVals.length < iLevel)) {
                    s2 += SpanText(tVals[i], 'CurLvl') + ' / ';
                }
                else {
                    s2 += tVals[i] + ' / ';
                }
            }
            s2 = s2.slice(0, -3);
        }
        s2 = SpanText(SpanText(s2, 'GameplayVariable'), 'GameplayValues');
        s = s.replace(new RegExp(`%${sKey}%`, 'gm'), s2);
    }
    return s;
}
function ReplaceAbltVals(sAblt, s, iEntID = -1, iLevel = 1, bCount = false, tHasMoreInfo) {
    var _a;
    const tKv = (_a = AbilitiesKv[sAblt]) !== null && _a !== void 0 ? _a : ItemsKv[sAblt];
    if (!tKv)
        return s;
    if (-1 == iEntID) {
        iEntID = Players.GetPlayerHeroEntityIndex(FocusPlayer());
    }
    iLevel = Math.max(1, iLevel);
    s = ReplaceAbltSpecialVals(sAblt, s, iLevel, true);
    bCount = bCount && -1 != iEntID;
    let isEscape = (i) => {
        if (--i > 0)
            if (s[i] == '\\')
                return !isEscape(i);
        return false;
    };
    let i;
    while (-1 != (i = s.indexOf('[', i))) {
        if (isEscape(i)) {
            ++i;
            continue;
        }
        let i2 = s.indexOf(']', i + 1);
        if (-1 == i2)
            break;
        let sReplace = s.substring(i + 1, i2);
        let sReplace2 = sReplace.replace(/<.*?>/g, '');
        let bCanCount = bCount;
        let tAttributes = {};
        sReplace2.split(/[\+\-\*\/\(\)\% ]/).forEach(s => {
            if (s && Number.isNaN(parseFloat(s))) {
                let sVal = CustomKey2Val(s, sAblt, iEntID, iLevel, bCount);
                tAttributes[s] = sVal;
                if (bCanCount && Number.isNaN(parseInt(sVal))) {
                    bCanCount = false;
                }
            }
        });
        if (bCanCount) {
            Object.keys(tAttributes).forEach(s => {
                sReplace2 = sReplace2.replace(new RegExp(s, 'gm'), tAttributes[s]);
            });
            sReplace2 = sReplace2.replace(new RegExp('%', 'gm'), '*.01');
            try {
                $.GetContextPanel().RunScriptInPanelContext(`GameUI.CustomUIConfig()['__ReplaceAbltVals__val'] = ${sReplace2}`);
                let f = GameUI.CustomUIConfig()['__ReplaceAbltVals__val'];
                let sDecimal = String(f).split('.')[1];
                if (sDecimal == undefined || sDecimal.length < 6) {
                    sReplace2 = String(f);
                }
                else {
                    sReplace2 = String(parseFloat((f).toFixed(2)));
                }
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(new Error(`Replace ability vaules text error, name is ${sAblt}`));
            }
            sReplace2 = FormatNumber(sReplace2);
            sReplace2 = SpanText(sReplace2, 'AbilityValues');
            sReplace2 = SpanText(sReplace2, 'Count');
            s = s.substring(0, i) + sReplace2 + s.substring(i2 + 1);
            i += sReplace2.length + 1;
        }
        else {
            Object.keys(tAttributes).forEach(s => {
                let s2 = tAttributes[s];
                if (s2 != s) {
                    s2 = SpanText(s2, 'AbilityCustomKey');
                    sReplace = sReplace.replace(new RegExp(s, 'gm'), s2);
                }
            });
            sReplace = sReplace.replace(/\*\*/g, '^');
            sReplace = SpanText(sReplace, 'AbilityValues');
            s = s.substring(0, i) + sReplace + s.substring(i2 + 1);
            i += sReplace.length + 1;
        }
    }
    return s;
}
function CustomKey2Val(s, sAblt, iEntID, iLevel, bCount) {
    if (s.substring(0, 3) == 'sx_') {
        let id = s.substring(3);
        if (bCount) {
            let h = ID2Attribute[id];
            while (h.hParent != undefined) {
                h = h.hParent;
            }
            return h.Get(iEntID);
        }
        else {
            return $.Localize('#' + id);
        }
    }
    if (s == 'ablt_lvl') {
        if (bCount) {
            if (undefined != iLevel && iLevel > 0) {
                return iLevel;
            }
            else if (-1 != iEntID) {
                const iAblt = Entities.GetAbilityByName(iEntID, sAblt);
                if (-1 != iAblt) {
                    return Abilities.GetLevel(iAblt);
                }
            }
        }
        return $.Localize('#Tooltip_ablt_lvl');
    }
    if (s == 'cur_hp') {
        if (bCount && -1 != iEntID) {
            return Entities.GetHealth(iEntID);
        }
        return $.Localize('#Tooltip_cur_hp');
    }
    return s;
}

function ShowTooltip(panel, sTooltipName, param) {
    if (panel.IsValid()) {
        GameUI.CustomUIConfig()['__showing_tooltip'] = sTooltipName;
        GameUI.CustomUIConfig()[sTooltipName] = Object.assign(Object.assign({}, param), { panel });
        $.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, sTooltipName, `file://{resources}/layout/custom_game/tooltips/${sTooltipName}/${sTooltipName}.xml`, "a=1");
    }
}
function HideTooltip() {
    const t = GetShowingTooltip();
    if (t) {
        if (t.panel && t.panel.IsValid()) {
            $.DispatchEvent("UIHideCustomLayoutTooltip", t.panel, t.tooltip_name);
        }
        if (t.context != undefined) {
            render(() => undefined, t.context);
        }
        delete GameUI.CustomUIConfig()[t.tooltip_name];
    }
}
function GetShowingTooltip() {
    let sTooltipName = GameUI.CustomUIConfig()['__showing_tooltip'];
    if (sTooltipName != undefined) {
        let t = GameUI.CustomUIConfig()[sTooltipName];
        if (t != undefined && t.panel != undefined) {
            return Object.assign(Object.assign({}, t), { tooltip_name: sTooltipName });
        }
    }
}

function RegTooltips() {
    {
        const pDropItemBody = FindDotaHudElement("DropItemBody") || $.CreatePanel('Panel', FindDotaHudElement("Tooltips"), 'DropItemBody');
        pDropItemBody.style.tooltipPosition = 'top left';
        pDropItemBody.style.tooltipBodyPosition = '50%';
        $.RegisterForUnhandledEvent("DOTAShowDroppedItemTooltip", function (panel, x, _y, _sItemName, ...args) {
            const y = Number(_y);
            const sItemName = String(_sItemName);
            const tKv = ItemsKv[sItemName];
            if (tKv == undefined)
                return;
            pDropItemBody.SetPositionInPixels(x / pDropItemBody.actualuiscale_x, y / pDropItemBody.actualuiscale_y, 0);
            Timer(() => {
                const id = String(tKv['id']);
                if (id != undefined) {
                    switch (id.substring(0, 3)) {
                        case '108':
                            ShowTooltip(pDropItemBody, 'common_detail_tooltip', {
                                'sTitle': $.Localize("#DOTA_TOOLTIP_ability_" + sItemName),
                                'sImg': `file://{images}/custom_game/consumable/${sItemName}.png`,
                                'sTitleContext': $.Localize('#DOTA_TOOLTIP_ability_' + sItemName + '_Use') != '#DOTA_TOOLTIP_ability_' + sItemName + '_Use' ? $.Localize('#DOTA_TOOLTIP_ability_' + sItemName + '_Use') : undefined,
                                'sContext': StringLocalize(ReplaceAbltVals(sItemName, $.Localize('#DOTA_TOOLTIP_ability_' + sItemName + '_Description'))),
                            });
                            break;
                    }
                }
            }, 0, 'DOTAShowDroppedItemTooltip');
        });
        $.RegisterForUnhandledEvent("DOTAHideDroppedItemTooltip", () => {
            StopTimer('DOTAShowDroppedItemTooltip');
            HideTooltip();
        });
    }
}

export { RegTooltips };