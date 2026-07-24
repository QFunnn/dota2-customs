--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
(function (factory) {
  typeof define === 'function' && define.amd ? define(factory) :
  factory();
})((function () { 'use strict';

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
  function createSignal(value, options) {
    options = options ? Object.assign({}, signalOptions, options) : signalOptions;
    const s = {
      value,
      observers: null,
      observerSlots: null,
      comparator: options.equals || undefined
    };
    const setter = value => {
      if (typeof value === "function") {
        value = value(s.value);
      }
      return writeSignal(s, value);
    };
    return [readSignal.bind(s), setter];
  }
  function createRenderEffect(fn, value, options) {
    const c = createComputation(fn, value, false, STALE);
    updateComputation(c);
  }
  function createEffect(fn, value, options) {
    runEffects = runUserEffects;
    const c = createComputation(fn, value, false, STALE);
    c.user = true;
    Effects ? Effects.push(c) : updateComputation(c);
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
  function batch(fn) {
    return runUpdates(fn, false);
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
  function onCleanup(fn) {
    if (Owner === null) ;else if (Owner.cleanups === null) Owner.cleanups = [fn];else Owner.cleanups.push(fn);
    return fn;
  }
  function children(fn) {
    const children = createMemo(fn);
    const memo = createMemo(() => resolveChildren(children()));
    memo.toArray = () => {
      const c = memo();
      return Array.isArray(c) ? c : c != null ? [c] : [];
    };
    return memo;
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
  function runUserEffects(queue) {
    let i,
      userLength = 0;
    for (i = 0; i < queue.length; i++) {
      const e = queue[i];
      if (!e.user) runTop(e);else queue[userLength++] = e;
    }
    for (i = 0; i < userLength; i++) runTop(queue[i]);
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
    if (typeof err == "object") return err;
    return new Error(typeof err === "string" ? err : "Unknown error", {
      cause: err
    });
  }
  function handleError(err, owner = Owner) {
    const error = castError(err);
    throw error;
  }
  function resolveChildren(children) {
    if (typeof children === "function" && !children.length) return resolveChildren(children());
    if (Array.isArray(children)) {
      const results = [];
      for (let i = 0; i < children.length; i++) {
        const result = resolveChildren(children[i]);
        Array.isArray(result) ? results.push.apply(results, result) : results.push(result);
      }
      return results;
    }
    return children;
  }

  const FALLBACK = Symbol("fallback");
  function dispose(d) {
    for (let i = 0; i < d.length; i++) d[i]();
  }
  function mapArray(list, mapFn, options = {}) {
    let items = [],
      mapped = [],
      disposers = [],
      len = 0,
      indexes = mapFn.length > 1 ? [] : null;
    onCleanup(() => dispose(disposers));
    return () => {
      let newItems = list() || [],
        newLen = newItems.length,
        i,
        j;
      return untrack(() => {
        let newIndices, newIndicesNext, temp, tempdisposers, tempIndexes, start, end, newEnd, item;
        if (newLen === 0) {
          if (len !== 0) {
            dispose(disposers);
            disposers = [];
            items = [];
            mapped = [];
            len = 0;
            indexes && (indexes = []);
          }
          if (options.fallback) {
            items = [FALLBACK];
            mapped[0] = createRoot(disposer => {
              disposers[0] = disposer;
              return options.fallback();
            });
            len = 1;
          }
        }
        else if (len === 0) {
          mapped = new Array(newLen);
          for (j = 0; j < newLen; j++) {
            items[j] = newItems[j];
            mapped[j] = createRoot(mapper);
          }
          len = newLen;
        } else {
          temp = new Array(newLen);
          tempdisposers = new Array(newLen);
          indexes && (tempIndexes = new Array(newLen));
          for (start = 0, end = Math.min(len, newLen); start < end && items[start] === newItems[start]; start++);
          for (end = len - 1, newEnd = newLen - 1; end >= start && newEnd >= start && items[end] === newItems[newEnd]; end--, newEnd--) {
            temp[newEnd] = mapped[end];
            tempdisposers[newEnd] = disposers[end];
            indexes && (tempIndexes[newEnd] = indexes[end]);
          }
          newIndices = new Map();
          newIndicesNext = new Array(newEnd + 1);
          for (j = newEnd; j >= start; j--) {
            item = newItems[j];
            i = newIndices.get(item);
            newIndicesNext[j] = i === undefined ? -1 : i;
            newIndices.set(item, j);
          }
          for (i = start; i <= end; i++) {
            item = items[i];
            j = newIndices.get(item);
            if (j !== undefined && j !== -1) {
              temp[j] = mapped[i];
              tempdisposers[j] = disposers[i];
              indexes && (tempIndexes[j] = indexes[i]);
              j = newIndicesNext[j];
              newIndices.set(item, j);
            } else disposers[i]();
          }
          for (j = start; j < newLen; j++) {
            if (j in temp) {
              mapped[j] = temp[j];
              disposers[j] = tempdisposers[j];
              if (indexes) {
                indexes[j] = tempIndexes[j];
                indexes[j](j);
              }
            } else mapped[j] = createRoot(mapper);
          }
          mapped = mapped.slice(0, len = newLen);
          items = newItems.slice(0);
        }
        return mapped;
      });
      function mapper(disposer) {
        disposers[j] = disposer;
        if (indexes) {
          const [s, set] = createSignal(j);
          indexes[j] = set;
          return mapFn(newItems[j], s);
        }
        return mapFn(newItems[j]);
      }
    };
  }
  function indexArray(list, mapFn, options = {}) {
    let items = [],
      mapped = [],
      disposers = [],
      signals = [],
      len = 0,
      i;
    onCleanup(() => dispose(disposers));
    return () => {
      const newItems = list() || [],
        newLen = newItems.length;
      return untrack(() => {
        if (newLen === 0) {
          if (len !== 0) {
            dispose(disposers);
            disposers = [];
            items = [];
            mapped = [];
            len = 0;
            signals = [];
          }
          if (options.fallback) {
            items = [FALLBACK];
            mapped[0] = createRoot(disposer => {
              disposers[0] = disposer;
              return options.fallback();
            });
            len = 1;
          }
          return mapped;
        }
        if (items[0] === FALLBACK) {
          disposers[0]();
          disposers = [];
          items = [];
          mapped = [];
          len = 0;
        }
        for (i = 0; i < newLen; i++) {
          if (i < items.length && items[i] !== newItems[i]) {
            signals[i](() => newItems[i]);
          } else if (i >= items.length) {
            mapped[i] = createRoot(mapper);
          }
        }
        for (; i < items.length; i++) {
          disposers[i]();
        }
        len = signals.length = disposers.length = newLen;
        items = newItems.slice(0);
        return mapped = mapped.slice(0, len);
      });
      function mapper(disposer) {
        disposers[i] = disposer;
        const [s, set] = createSignal(newItems[i]);
        signals[i] = set;
        return mapFn(s, i);
      }
    };
  }
  function createComponent$1(Comp, props) {
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
  function mergeProps$1(...sources) {
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

  const narrowedError = name => `Stale read from <${name}>.`;
  function For(props) {
    const fallback = "fallback" in props && {
      fallback: () => props.fallback
    };
    return createMemo(mapArray(() => props.each, props.children, fallback || undefined));
  }
  function Index(props) {
    const fallback = "fallback" in props && {
      fallback: () => props.fallback
    };
    return createMemo(indexArray(() => props.each, props.children, fallback || undefined));
  }
  function Show(props) {
    const keyed = props.keyed;
    const conditionValue = createMemo(() => props.when, undefined, undefined);
    const condition = keyed ? conditionValue : createMemo(conditionValue, undefined, {
      equals: (a, b) => !a === !b
    });
    return createMemo(() => {
      const c = condition();
      if (c) {
        const child = props.children;
        const fn = typeof child === "function" && child.length > 0;
        return fn ? untrack(() => child(keyed ? c : () => {
          if (!untrack(condition)) throw narrowedError("Show");
          return conditionValue();
        })) : child;
      }
      return props.fallback;
    }, undefined, undefined);
  }
  function Switch(props) {
    const chs = children(() => props.children);
    const switchFunc = createMemo(() => {
      const ch = chs();
      const mps = Array.isArray(ch) ? ch : [ch];
      let func = () => undefined;
      for (let i = 0; i < mps.length; i++) {
        const index = i;
        const mp = mps[i];
        const prevFunc = func;
        const conditionValue = createMemo(() => prevFunc() ? undefined : mp.when, undefined, undefined);
        const condition = mp.keyed ? conditionValue : createMemo(conditionValue, undefined, {
          equals: (a, b) => !a === !b
        });
        func = () => prevFunc() || (condition() ? [index, conditionValue, mp] : undefined);
      }
      return func;
    });
    return createMemo(() => {
      const sel = switchFunc()();
      if (!sel) return props.fallback;
      const [index, conditionValue, mp] = sel;
      const child = mp.children;
      const fn = typeof child === "function" && child.length > 0;
      return fn ? untrack(() => child(mp.keyed ? conditionValue() : () => {
        if (untrack(switchFunc)()?.[0] !== index) throw narrowedError("Match");
        return conditionValue();
      })) : child;
    }, undefined, undefined);
  }
  function Match(props) {
    return props;
  }

  const memo$1 = fn => createMemo(() => fn());

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
      mergeProps: mergeProps$1,
      effect: createRenderEffect,
      memo: memo$1,
      createComponent: createComponent$1,
      use(fn, element, arg) {
        return untrack(() => fn(element, arg));
      }
    };
  }

  function createRenderer(options) {
    const renderer = createRenderer$1(options);
    renderer.mergeProps = mergeProps$1;
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
      return $.CreatePanel('Panel', root, '', {
          style: 'visibility: collapse;'
      });
  })();
  const { render: _render, effect, memo, createComponent, createElement, insert, spread, setProp, mergeProps, use } = createRenderer({
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
          $.Schedule(0, () => {
              if (node.GetParent() == nodeTrash) {
                  node.DeleteAsync(0);
              }
          });
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
  function Dynamic(props) {
      const [p, others] = splitProps(props, ['component']);
      const cached = createMemo(() => p.component);
      return createMemo(() => {
          const component = cached();
          switch (typeof component) {
              case 'function':
                  return untrack(() => component(others));
              case 'string':
                  const el = createElement(component);
                  spread(el, others);
                  return el;
          }
      });
  }
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
      let stack = new Error().stack;
      node.SetPanelEvent(event, function () {
          try {
              handle(node);
          }
          catch (error) {
              if (typeof error == 'string') {
                  error += '\n' + stack;
              }
              throw error;
          }
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

  function getDefaultExportFromCjs (x) {
  	return x && x.__esModule && Object.prototype.hasOwnProperty.call(x, 'default') ? x['default'] : x;
  }

  var classnames = {exports: {}};

  /*!
  	Copyright (c) 2018 Jed Watson.
  	Licensed under the MIT License (MIT), see
  	http://jedwatson.github.io/classnames
  */

  var hasRequiredClassnames;

  function requireClassnames () {
  	if (hasRequiredClassnames) return classnames.exports;
  	hasRequiredClassnames = 1;
  	(function (module) {
  		/* global define */

  		(function () {

  			var hasOwn = {}.hasOwnProperty;

  			function classNames () {
  				var classes = '';

  				for (var i = 0; i < arguments.length; i++) {
  					var arg = arguments[i];
  					if (arg) {
  						classes = appendClass(classes, parseValue(arg));
  					}
  				}

  				return classes;
  			}

  			function parseValue (arg) {
  				if (typeof arg === 'string' || typeof arg === 'number') {
  					return arg;
  				}

  				if (typeof arg !== 'object') {
  					return '';
  				}

  				if (Array.isArray(arg)) {
  					return classNames.apply(null, arg);
  				}

  				if (arg.toString !== Object.prototype.toString && !arg.toString.toString().includes('[native code]')) {
  					return arg.toString();
  				}

  				var classes = '';

  				for (var key in arg) {
  					if (hasOwn.call(arg, key) && arg[key]) {
  						classes = appendClass(classes, key);
  					}
  				}

  				return classes;
  			}

  			function appendClass (value, newClass) {
  				if (!newClass) {
  					return value;
  				}
  			
  				if (value) {
  					return value + ' ' + newClass;
  				}
  			
  				return value + newClass;
  			}

  			if (module.exports) {
  				classNames.default = classNames;
  				module.exports = classNames;
  			} else {
  				window.classNames = classNames;
  			}
  		}()); 
  	} (classnames));
  	return classnames.exports;
  }

  var classnamesExports = /*@__PURE__*/ requireClassnames();
  var classNames = /*@__PURE__*/getDefaultExportFromCjs(classnamesExports);

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


  function __rest(s, e) {
      var t = {};
      for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
          t[p] = s[p];
      if (s != null && typeof Object.getOwnPropertySymbols === "function")
          for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
              if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                  t[p[i]] = s[p[i]];
          }
      return t;
  }

  function __setFunctionName(f, name, prefix) {
      if (typeof name === "symbol") name = name.description ? "[".concat(name.description, "]") : "";
      return Object.defineProperty(f, "name", { configurable: true, value: prefix ? "".concat(prefix, " ", name) : name });
  }

  var _a$1, _b$1, _c$1, _d, _e;
  if (GameUI.CustomUIConfig().tools == undefined) GameUI.CustomUIConfig().tools = {};
  ENV_NAME = $.GetContextPanel().layoutfile;
  var EventManager = (_a$1 = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a$1, "EventManager"), _a$1.sEnvName = ENV_NAME, _a$1);
  var NetEventData = (_b$1 = class extends GameUI.CustomUIConfig().tools.NetEventData {}, __setFunctionName(_b$1, "NetEventData"), _b$1.sEnvName = ENV_NAME, _b$1);
  var Keybinds = (_c$1 = class extends GameUI.CustomUIConfig().tools.Keybinds {}, __setFunctionName(_c$1, "Keybinds"), _c$1.sEnvName = ENV_NAME, _c$1);
  var Mousebinds = (_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {}, __setFunctionName(_d, "Mousebinds"), _d.sEnvName = ENV_NAME, _d);
  GameUI.CustomUIConfig().tools.ParticleManager_s2c;
  GameUI.CustomUIConfig().tools.AttributeSystem;
  GameUI.CustomUIConfig().tools.AttributeKind;
  var _Timer = (_e = class extends GameUI.CustomUIConfig().tools.Timer {}, __setFunctionName(_e, "_Timer"), _e.sEnvName = ENV_NAME, _e);
  var Timer = _Timer.Timer.bind(_Timer);
  var GameTimer = _Timer.GameTimer.bind(_Timer);
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
  _Player.FocusPlayer.bind(_Player);
  _Player.IsPlayerDisconnected.bind(_Player);
  _Player.IsPlayerAbandoned.bind(_Player);
  var Player_EntityToID = _Player.Player_EntityToID.bind(_Player);
  _Player.Player_IDToOrder.bind(_Player);
  _Player.Player_OrderToID.bind(_Player);
  _Player.Player_IDToAccount.bind(_Player);
  _Player.Player_AccountToID.bind(_Player);
  _Player.PlayerLanguage.bind(_Player);
  var runlua = GameUI.CustomUIConfig().tools.runlua;
  GameUI.CustomUIConfig().tools.EntIndexToHScript;
  GameUI.CustomUIConfig().tools.BuffToModifier;
  GameUI.CustomUIConfig().tools.PolymerIDToDiyPolymer;
  var AbilitiesKv = GameUI.CustomUIConfig()['AbilitiesKv'];
  var HeroesKv = GameUI.CustomUIConfig()['HeroesKv'];
  var UnitsKv = GameUI.CustomUIConfig()['UnitsKv'];
  var ItemsKv = GameUI.CustomUIConfig()['ItemsKv'];
  var WearableKv = GameUI.CustomUIConfig()['WearableKv'];
  var CustomHeroesKv = GameUI.CustomUIConfig()['CustomHeroesKv'];
  GameUI.CustomUIConfig()['GameItemsKv'];
  const KvByID = (() => {
    const tID2Kv = {};
    for (const t of [AbilitiesKv, ItemsKv, UnitsKv]) {
      for (const k in t) {
        let t2 = t[k];
        if (typeof t2 == 'object' && t2['id'] != undefined) {
          tID2Kv[t2['id']] = t2;
        }
      }
    }
    return id => tID2Kv[id];
  })();
  var Request = GameUI.CustomUIConfig().tools.Request;
  GameUI.CustomUIConfig().tools.UnregRequest;
  GameUI.CustomUIConfig().tools.WindowManager;
  var UploadError = GameUI.CustomUIConfig().UploadError;

  function print(...args) {
    let params = [];
    for (let i = 0; i < arguments.length; i++) {
      params.push(arguments[i], ' ');
    }
    return $.Msg(...params);
  }
  function Clamp(num, min, max) {
    return num <= min ? min : num >= max ? max : num;
  }
  const FormatTimeStyle = {
    Clock_ms: {
      'format': 'm:s',
      'replace': {
        'm': (iVal, iTime) => {
          if (iVal < 10) {
            return `0${iVal}`;
          }
        },
        's': (iVal, iTime) => {
          if (iVal < 10) {
            return `0${iVal}`;
          }
        }
      }
    }};
  function FormatTime(iTime, tCfg = FormatTimeStyle.Clock_ms) {
    var _a;
    let arr = [['Y', 31536000], ['M', 2592000], ['D', 86400], ['h', 3600], ['m', 60], ['s', 1]];
    let fTimeLast = iTime;
    let s = tCfg.format;
    for (let i = 0; i < arr.length; ++i) {
      const sKey = arr[i][0];
      if (-1 == s.indexOf(sKey)) continue;
      const iLen = arr[i][1];
      let iVal = Math.floor(fTimeLast / iLen);
      fTimeLast -= iVal * iLen;
      if (tCfg.replace) {
        const func = tCfg.replace[sKey];
        if (func) {
          let sVal = func(iVal, iTime);
          if (sVal != undefined) {
            s = s.replace(sKey, sVal);
            continue;
          }
        }
      }
      s = s.replace(sKey, iVal.toString());
    }
    if (tCfg.msec) {
      s += '.' + ((_a = String(iTime).split('.')[1]) !== null && _a !== void 0 ? _a : '000').substring(0, 3);
    }
    return s;
  }
  function ErrorMsg(sMsg, sSound = 'General.CastFail_Custom') {
    GameUI.SendCustomHUDError(sMsg, sSound);
  }
  function CacheValue(key, val) {
    if (GameUI.CustomUIConfig()['__Cache__'] == undefined) GameUI.CustomUIConfig()['__Cache__'] = {};
    if (val !== undefined) GameUI.CustomUIConfig()['__Cache__'][key] = val;
    return GameUI.CustomUIConfig()['__Cache__'][key];
  }
  function Round(fNumber, prec = 0) {
    let i = Math.pow(10, prec);
    return Math.round(fNumber * i) / i;
  }
  function VectorToString(v) {
    return v.join(' ');
  }
  function CheckDoubleClick(p, OnSingleClick) {
    if (CheckDoubleClick['timer'] == undefined) {
      CheckDoubleClick['timer'] = GameUI.CustomUIConfig().tools.Timer.Timer(() => {
        OnSingleClick === null || OnSingleClick === void 0 ? void 0 : OnSingleClick();
        CheckDoubleClick['timer'] = undefined;
      }, 0.3);
    } else {
      GameUI.CustomUIConfig().tools.Timer.StopTimer(CheckDoubleClick['timer']);
      CheckDoubleClick['timer'] = undefined;
      return true;
    }
    return false;
  }

  const getter_iLocalPlayer = useLocalPlayer();

  function KeybindButton(props) {
    let ref;
    const getter = PropsGetter(props);
    createEffect(() => {
      const sKey = getter.key();
      if (sKey) {
        const id = Keybinds.Bind(sKey, 1, () => {
          var _a;
          (_a = props.onactivate) === null || _a === void 0 ? void 0 : _a.call(props, ref, true);
        });
        onCleanup(() => {
          Keybinds.Unbind(id, sKey);
        });
      }
    });
    return (() => {
      const _el$2 = createElement("Panel", mergeProps(props, {
        get ["class"]() {
          return "KeybindButton " + props.class;
        }
      }), null);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') {
          props.ref(p);
        }
      }, _el$2);
      spread(_el$2, mergeProps(props, {
        get ["class"]() {
          return "KeybindButton " + props.class;
        }
      }), true);
      insert(_el$2, () => children(() => props.children));
      return _el$2;
    })();
  }
  function PropsGetter(props, init = {}) {
    const getter = {};
    for (const key in init) {
      if (props[key] == undefined) {
        getter[key] = () => init[key];
      }
    }
    for (const key in props) {
      const hDescriptor = Object.getOwnPropertyDescriptor(props, key);
      if (hDescriptor.set != undefined) continue;
      if (hDescriptor.get != undefined) {
        getter[key] = () => {
          const v = hDescriptor.get();
          if (typeof v == 'function') return v();
          return v;
        };
      } else if (typeof props[key] == 'function') {
        getter[key] = props[key];
      } else {
        getter[key] = () => props[key];
      }
    }
    return getter;
  }
  function createCache(key, value, options) {
    var _a;
    const [sign, setSign] = createSignal(CacheValue(key, (_a = CacheValue(key)) !== null && _a !== void 0 ? _a : value), options);
    return [sign, v => CacheValue(key, setSign(v))];
  }
  function useNetEventTable(func, table, key) {
    const [sign, setSign] = createSignal(func(undefined));
    const [data, setData] = createSignal();
    createEffect(() => {
      setSign(func(data(), untrack(sign)));
    });
    if (typeof table == 'function' || typeof key == 'function') {
      const getTable = typeof table == 'function' ? table : () => table;
      const getKey = typeof key == 'function' ? key : () => key;
      createEffect(() => {
        const sTable = getTable();
        const sKey = getKey();
        const bind = NetEventData.BindDo(sTable, sKey, tTable => {
          setData(tTable);
        });
        onCleanup(() => {
          NetEventData.Unbind(bind, sTable, sKey);
        });
      });
      return [sign, () => {
        const v = NetEventData.GetTableValue(getTable(), getKey());
        if (typeof v == 'object') {
          if (Array.isArray(v)) {
            setData([...v]);
          } else {
            setData(Object.assign({}, v));
          }
        } else {
          setData(v);
        }
      }];
    } else {
      createEffect(() => {
        setData(NetEventData.GetTableValue(table, key));
      });
      const bind = NetEventData.Bind(table, key, tTable => {
        setData(tTable);
      });
      onCleanup(() => {
        NetEventData.Unbind(bind, table, key);
      });
      return [sign, () => {
        const v = NetEventData.GetTableValue(table, key);
        if (typeof v == 'object') {
          if (Array.isArray(v)) {
            setData([...v]);
          } else {
            setData(Object.assign({}, v));
          }
        } else {
          setData(v);
        }
      }];
    }
  }
  function useNetTable(func, table, key) {
    const [sign, setSign] = createSignal(func(undefined));
    const [data, setData] = createSignal();
    createEffect(() => {
      setSign(func(data(), untrack(sign)));
    });
    if (typeof key == 'function') {
      const getTable = () => table;
      const getKey = typeof key == 'function' ? key : () => key;
      let bind;
      createEffect(() => {
        const sTable = getTable();
        const sKey = getKey();
        setData(CustomNetTables.GetTableValue(sTable, sKey));
        bind = CustomNetTables.SubscribeNetTableListener(sTable, (_, _key, tTable) => {
          if (_key == sKey) setData(tTable);
        });
        onCleanup(() => {
          CustomNetTables.UnsubscribeNetTableListener(bind);
        });
      });
      return [sign, () => {
        const v = CustomNetTables.GetTableValue(getTable(), getKey());
        if (v != undefined) {
          setData(Object.assign({}, v));
        } else {
          setData(v);
        }
      }];
    } else {
      createEffect(() => {
        setData(CustomNetTables.GetTableValue(table, key));
      });
      const bind = CustomNetTables.SubscribeNetTableListener(table, (_, _key, tTable) => {
        if (_key == key) setData(tTable);
      });
      onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(bind);
      });
      return [sign, () => {
        const v = CustomNetTables.GetTableValue(table, key);
        if (v != undefined) {
          setData(Object.assign({}, v));
        } else {
          setData(v);
        }
      }];
    }
  }
  function useSelectUnit() {
    let iEntID = Players.GetLocalPlayerPortraitUnit();
    const [sign, setSign] = createSignal(iEntID);
    const iTimeID = Timer(() => {
      let iEntID2 = Players.GetLocalPlayerPortraitUnit();
      if (iEntID != iEntID2) {
        iEntID = iEntID2;
        setSign(iEntID);
      }
      return 0;
    }, 0, undefined, 'useSelectUnit');
    onCleanup(() => {
      StopTimer(iTimeID);
    });
    return sign;
  }
  function usePlayerSelectedHero(pid = getter_iLocalPlayer) {
    const [sign, setSign] = createSignal(-1);
    createEffect(() => {
      const iPlayerID = typeof pid == 'function' ? pid() : pid;
      let iEntID = -1;
      const iTimeID = GameTimer(() => {
        let iEntID2 = Players.GetPlayerHeroEntityIndex(iPlayerID);
        if (iEntID != iEntID2) {
          iEntID = iEntID2;
          setSign(iEntID);
        }
        return 0.1;
      }, -1, undefined, 'usePlayerSelectedHero');
      onCleanup(() => {
        StopTimer(iTimeID);
      });
    });
    return sign;
  }
  function useLocalPlayer() {
    const [sign, setSign] = createSignal(Players.GetLocalPlayer());
    if (!Players.IsValidPlayerID(sign())) {
      const id = Timer(() => {
        const pid = Players.GetLocalPlayer();
        if (!Players.IsValidPlayerID(pid)) return 0.1;
        setSign(pid);
      }, 0.1, undefined, 'useLocalPlayer');
      onCleanup(() => {
        StopTimer(id);
      });
    }
    return sign;
  }

  function DemoOther(props) {
    var _a, _b;
    return (() => {
      const _el$ = createElement("Panel", {
          id: "DemoOther"
        }, null),
        _el$2 = createElement("Label", {
          text: "其他功能"
        }, _el$),
        _el$3 = createElement("Panel", {}, _el$),
        _el$4 = createElement("Panel", {}, _el$3),
        _el$5 = createElement("Button", {}, _el$4);
        createElement("Label", {
          text: "重载脚本"
        }, _el$5);
        const _el$7 = createElement("Panel", {}, _el$3),
        _el$8 = createElement("Button", {}, _el$7);
        createElement("Label", {
          text: "TEST"
        }, _el$8);
        const _el$0 = createElement("Panel", {}, _el$3),
        _el$1 = createElement("Button", {}, _el$0);
        createElement("Label", {
          text: "清除怪物"
        }, _el$1);
        const _el$11 = createElement("ToggleButton", {}, _el$0);
        createElement("Label", {
          text: "停止刷怪"
        }, _el$11);
        const _el$13 = createElement("Panel", {}, _el$3),
        _el$14 = createElement("ToggleButton", {}, _el$13);
        createElement("Label", {
          text: "无限冷却"
        }, _el$14);
        const _el$16 = createElement("Button", {}, _el$13);
        createElement("Label", {
          text: "昼夜更替"
        }, _el$16);
        const _el$18 = createElement("Panel", {}, _el$3),
        _el$19 = createElement("Button", {}, _el$18);
        createElement("Label", {
          text: "更新服务数据"
        }, _el$19);
        const _el$21 = createElement("Panel", {}, _el$3),
        _el$22 = createElement("Button", {}, _el$21),
        _el$23 = createElement("TextEntry", {
          multiline: false,
          placeholder: '跳关',
          get text() {
            return (_a = GameUI['__Debug__Round']) !== null && _a !== void 0 ? _a : '';
          }
        }, _el$22);
        createElement("Label", {
          text: "跳关"
        }, _el$22);
        const _el$25 = createElement("Panel", {}, _el$3),
        _el$26 = createElement("Button", {}, _el$25),
        _el$27 = createElement("TextEntry", {
          multiline: false,
          placeholder: '1180001',
          get text() {
            return (_b = GameUI['__Debug__Privilege']) !== null && _b !== void 0 ? _b : '';
          }
        }, _el$26);
        createElement("Label", {
          text: "特权添加"
        }, _el$26);
        const _el$29 = createElement("Panel", {}, _el$3),
        _el$30 = createElement("Button", {}, _el$29);
        createElement("Label", {
          text: "下关"
        }, _el$30);
        const _el$32 = createElement("Button", {}, _el$29);
        createElement("Label", {
          text: "终局BOSS"
        }, _el$32);
        const _el$34 = createElement("Panel", {}, _el$3),
        _el$35 = createElement("Button", {}, _el$34);
        createElement("Label", {
          text: "升级属性选择"
        }, _el$35);
        const _el$37 = createElement("Panel", {}, _el$3),
        _el$38 = createElement("Button", {}, _el$37);
        createElement("Label", {
          text: "英雄进化"
        }, _el$38);
        const _el$40 = createElement("Panel", {}, _el$3),
        _el$41 = createElement("Button", {}, _el$40);
        createElement("Label", {
          text: "添加宝物选择次数"
        }, _el$41);
        const _el$43 = createElement("Panel", {}, _el$3),
        _el$44 = createElement("Button", {}, _el$43);
        createElement("Label", {
          text: "添加技能选择次数"
        }, _el$44);
        const _el$46 = createElement("Panel", {}, _el$3),
        _el$47 = createElement("Button", {}, _el$46);
        createElement("Label", {
          text: "增加转职挑战次数"
        }, _el$47);
        const _el$49 = createElement("Panel", {}, _el$3),
        _el$50 = createElement("Button", {}, _el$49);
        createElement("Label", {
          text: "主武器词缀选择"
        }, _el$50);
        const _el$52 = createElement("Panel", {}, _el$3),
        _el$53 = createElement("Button", {}, _el$52);
        createElement("Label", {
          text: "魔瓶加词条"
        }, _el$53);
        const _el$55 = createElement("Panel", {}, _el$3),
        _el$56 = createElement("Button", {}, _el$55);
        createElement("Label", {
          text: "奇遇选择"
        }, _el$56);
        const _el$58 = createElement("Panel", {}, _el$3),
        _el$59 = createElement("Button", {}, _el$58);
        createElement("Label", {
          text: "普通宝箱"
        }, _el$59);
        const _el$61 = createElement("Panel", {}, _el$3),
        _el$62 = createElement("Button", {}, _el$61);
        createElement("Label", {
          text: "BOSS宝箱"
        }, _el$62);
        const _el$64 = createElement("Panel", {}, _el$3),
        _el$65 = createElement("Button", {}, _el$64);
        createElement("Label", {
          text: "胜利"
        }, _el$65);
        const _el$67 = createElement("Panel", {}, _el$3),
        _el$68 = createElement("Button", {}, _el$67);
        createElement("Label", {
          text: "失败"
        }, _el$68);
        const _el$70 = createElement("Panel", {}, _el$3),
        _el$71 = createElement("Button", {}, _el$70);
        createElement("Label", {
          text: "局内重开"
        }, _el$71);
        const _el$73 = createElement("Panel", {}, _el$3);
      setProp(_el$, "className", "Category");
      setProp(_el$2, "className", "CategoryHeader");
      setProp(_el$2, "onactivate", p => {
        p.GetParent().ToggleClass('Spread');
      });
      setProp(_el$3, "className", "CategoryButtonContainer");
      setProp(_el$4, "className", "Row");
      setProp(_el$5, "className", "CategoryButton");
      setProp(_el$5, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-reloadscript`
        });
      });
      setProp(_el$7, "className", "Row");
      setProp(_el$8, "className", "CategoryButton");
      setProp(_el$8, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-test ${props.getEntID()}`
        });
        EventManager.Fire('debug_test', {});
      });
      setProp(_el$0, "className", "Row");
      setProp(_el$1, "className", "CategoryButton LeftButton");
      setProp(_el$1, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-clear_enemies`
        });
      });
      setProp(_el$11, "className", "CategoryButton RightButton");
      setProp(_el$11, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-toggle_spawner ${p.IsSelected() ? 1 : 0}`
        });
      });
      setProp(_el$13, "className", "Row");
      setProp(_el$14, "className", "CategoryButton LeftButton");
      setProp(_el$14, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-wtf ${p.IsSelected() ? 1 : 0}`
        });
      });
      setProp(_el$16, "className", "CategoryButton RightButton");
      setProp(_el$16, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-daynight`
        });
      });
      setProp(_el$18, "className", "Row");
      setProp(_el$19, "className", "CategoryButton LeftButton");
      setProp(_el$19, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-upser`
        });
      });
      setProp(_el$21, "className", "Row");
      setProp(_el$22, "className", "CategoryButton TextEntryButton");
      setProp(_el$22, "onactivate", p => {
        GameUI['__Debug__Round'] = p.GetChild(0).text;
        if (GameUI['__Debug__Round'] != '') {
          GameEvents.SendCustomGameEventToServer('debug_cmd', {
            cmd: `-jump_round ${GameUI['__Debug__Round']}`
          });
        }
      });
      setProp(_el$25, "className", "Row");
      setProp(_el$26, "className", "CategoryButton TextEntryButton");
      setProp(_el$26, "onactivate", p => {
        GameUI['__Debug__Privilege'] = p.GetChild(0).text;
        if (GameUI['__Debug__Privilege'] != '') {
          GameEvents.SendCustomGameEventToServer('debug_cmd', {
            cmd: `-privilege ${GameUI['__Debug__Privilege']}`
          });
        }
      });
      setProp(_el$29, "className", "Row");
      setProp(_el$30, "className", "CategoryButton LeftButton");
      setProp(_el$30, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-next_round`
        });
      });
      setProp(_el$32, "className", "CategoryButton LeftButton");
      setProp(_el$32, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-final_boss`
        });
      });
      setProp(_el$34, "className", "Row");
      setProp(_el$35, "className", "CategoryButton");
      setProp(_el$35, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-level_up_selection`
        });
      });
      setProp(_el$37, "className", "Row");
      setProp(_el$38, "className", "CategoryButton");
      setProp(_el$38, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-replace_count`
        });
      });
      setProp(_el$40, "className", "Row");
      setProp(_el$41, "className", "CategoryButton");
      setProp(_el$41, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-relic_selection_count`
        });
      });
      setProp(_el$43, "className", "Row");
      setProp(_el$44, "className", "CategoryButton");
      setProp(_el$44, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-ability_selection_count`
        });
      });
      setProp(_el$46, "className", "Row");
      setProp(_el$47, "className", "CategoryButton");
      setProp(_el$47, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-replace_challenge_count`
        });
      });
      setProp(_el$49, "className", "Row");
      setProp(_el$50, "className", "CategoryButton");
      setProp(_el$50, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-weapon_selection`
        });
      });
      setProp(_el$52, "className", "Row");
      setProp(_el$53, "className", "CategoryButton TextEntryButton");
      setProp(_el$53, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-bottle_add_affix`
        });
      });
      setProp(_el$55, "className", "Row");
      setProp(_el$56, "className", "CategoryButton");
      setProp(_el$56, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-adventure_selection`
        });
      });
      setProp(_el$58, "className", "Row");
      setProp(_el$59, "className", "CategoryButton");
      setProp(_el$59, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-treasure`
        });
      });
      setProp(_el$61, "className", "Row");
      setProp(_el$62, "className", "CategoryButton");
      setProp(_el$62, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-boss_treasure`
        });
      });
      setProp(_el$64, "className", "Row");
      setProp(_el$65, "className", "CategoryButton");
      setProp(_el$65, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-conclusion 1`
        });
      });
      setProp(_el$67, "className", "Row");
      setProp(_el$68, "className", "CategoryButton");
      setProp(_el$68, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-conclusion 0`
        });
      });
      setProp(_el$70, "className", "Row");
      setProp(_el$71, "className", "CategoryButton");
      setProp(_el$71, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-newgame`
        });
      });
      setProp(_el$73, "className", "Row");
      insert(_el$73, createComponent(TimeScale, {}));
      effect(_p$ => {
        const _v$ = (_a = GameUI['__Debug__Round']) !== null && _a !== void 0 ? _a : '',
          _v$2 = (_b = GameUI['__Debug__Privilege']) !== null && _b !== void 0 ? _b : '';
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$23, "text", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$27, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }
  function TimeScale({}) {
    const increment = 0.5;
    const [getSliderVal, setSliderVal] = createSignal(1);
    return (() => {
      const _el$74 = createElement("Panel", {
          id: "TimeScale"
        }, null),
        _el$75 = createElement("Panel", {}, _el$74),
        _el$76 = createElement("Label", {
          text: "时间:"
        }, _el$75),
        _el$77 = createElement("Label", {
          get text() {
            return getSliderVal();
          }
        }, _el$75),
        _el$78 = createElement("GenericPanel", {
          type: "Slider",
          direction: "horizontal"
        }, _el$74);
      setProp(_el$74, "className", "CategorySlider");
      setProp(_el$75, "className", "CategorySliderKV");
      setProp(_el$76, "className", "CategorySliderKey");
      setProp(_el$77, "className", "CategorySliderVal");
      setProp(_el$78, "className", "HorizontalSlider");
      setProp(_el$78, "onload", p => {
        p.min = 0.1;
        p.max = 10;
        p.value = 1;
      });
      setProp(_el$78, "onmouseover", pSelf => {
        let fVal = Math.floor(pSelf.value / increment) * increment;
        Timer(() => {
          if (fVal != Math.floor(pSelf.value / increment) * increment) {
            fVal = Math.max(0.1, Math.floor(pSelf.value / increment) * increment);
            setSliderVal(Number(fVal.toFixed(1)));
            GameEvents.SendCustomGameEventToServer('set_time_speed', {
              val: parseFloat(fVal.toFixed(1))
            });
          }
          return 0;
        }, 0, "DebugSliderTimer");
      });
      setProp(_el$78, "onmouseout", () => {
        StopTimer("DebugSliderTimer");
      });
      effect(_$p => setProp(_el$77, "text", getSliderVal(), _$p));
      return _el$74;
    })();
  }

  function DOTAUIEconSetPreview(_a) {
    var {
        itemdef,
        itemstyle = 1,
        displaymode = 'loadout_small',
        drawbackground = true,
        renderdeferred = true,
        deferredalpha = true,
        requireCompositionLayer = false,
        antialias = false,
        allowrotation = false,
        rotationspeed = 0
      } = _a,
      arg = __rest(_a, ["itemdef", "itemstyle", "displaymode", "drawbackground", "renderdeferred", "deferredalpha", "requireCompositionLayer", "antialias", "allowrotation", "rotationspeed"]);
    return (() => {
      const _el$ = createElement("GenericPanel", mergeProps({
        type: "DOTAUIEconSetPreview"
      }, arg, {
        itemdef: itemdef,
        itemstyle: itemstyle,
        displaymode: displaymode,
        drawbackground: drawbackground,
        renderdeferred: renderdeferred,
        deferredalpha: deferredalpha,
        "require-composition-layer": requireCompositionLayer,
        antialias: antialias,
        allowrotation: allowrotation,
        rotationspeed: rotationspeed,
        "post-process-material": "materials/dev/deferred_post_process_graphic_ui.vmat"
      }), null);
      spread(_el$, mergeProps(arg, {
        "itemdef": itemdef,
        "itemstyle": itemstyle,
        "displaymode": displaymode,
        "drawbackground": drawbackground,
        "renderdeferred": renderdeferred,
        "deferredalpha": deferredalpha,
        "require-composition-layer": requireCompositionLayer,
        "antialias": antialias,
        "allowrotation": allowrotation,
        "rotationspeed": rotationspeed,
        "post-process-material": "materials/dev/deferred_post_process_graphic_ui.vmat"
      }), false);
      return _el$;
    })();
  }
  function TabContents(props) {
    let ref;
    if (props.selected != undefined) {
      createEffect(() => {
        ref.checked = props.selected;
      });
    }
    return (() => {
      const _el$5 = createElement("GenericPanel", mergeProps({
        type: "TabContents"
      }, props), null);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') props.ref(p);
      }, _el$5);
      spread(_el$5, props, false);
      return _el$5;
    })();
  }

  function ShowTooltip(panel, sTooltipName, param) {
    if (panel.IsValid()) {
      GameUI.CustomUIConfig()['__showing_tooltip'] = sTooltipName;
      GameUI.CustomUIConfig()[sTooltipName] = Object.assign(Object.assign({}, param), {
        panel
      });
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
        return Object.assign(Object.assign({}, t), {
          tooltip_name: sTooltipName
        });
      }
    }
  }

  const TextKeyWords = {
    'icon_cd': `<img src="s2r://panorama/images/status_icons/ability_cooldown_icon_psd.vtex" class="cooldown" />`
  };
  const TextFunctions = {
    'MATH': {
      'process': (s, vals, options) => {
        const ender_pos = s.lastIndexOf(')');
        const ender = s.slice(ender_pos + 1);
        const sMath = NoHtmlText(s.slice(5, ender_pos));
        try {
          $.GetContextPanel().RunScriptInPanelContext(`
                    try {
                        delete GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'];
                        GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'] = ${sMath};
                    } catch (error) {}
                `);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
        let f = GameUI.CustomUIConfig()['__ReplaceTextVariable_MATH__'];
        if (typeof f == 'number') {
          f = parseFloat(f.toFixed(2));
          if (options.no_html) {
            return `${f}${ender}`;
          } else {
            return SpanText(`${f}${ender}`, 'NumberValues');
          }
        }
      },
      'is_number': true
    },
    'NOHTML': {
      'process': (s, vals, options) => {
        return NoHtmlText(s.slice(7, -1));
      }
    },
    'ISNUMB': {
      'process': (s, vals, options) => {
        let [s2, start] = findStringWrapped(s, '(', ')', 6);
        s2 = NoHtmlText(s2);
        return s.slice(0, start - 6) + String(!Number.isNaN(Number(s2)));
      }
    },
    'SHOW': {
      'process': (s, vals, options) => {
        const [s2, start, end] = findStringWrapped(s, '(', ')', 4);
        const text = s.slice(end);
        try {
          $.GetContextPanel().RunScriptInPanelContext(`
                    try {
                        delete GameUI.CustomUIConfig()['__ReplaceTextVariable_SHOW__'];
                        GameUI.CustomUIConfig()['__ReplaceTextVariable_SHOW__'] = ${s2};
                    } catch (error) {}
                `);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
        if (!!GameUI.CustomUIConfig()['__ReplaceTextVariable_SHOW__']) return text;
        return '';
      }
    },
    'IF': {
      'process': (s, vals, options) => {
        let [s2, start, end] = findStringWrapped(s, '(', ')', 2);
        s2 = NoHtmlText(s2);
        try {
          $.GetContextPanel().RunScriptInPanelContext(`
                    try {
                        delete GameUI.CustomUIConfig()['__ReplaceTextVariable_IF__'];
                        GameUI.CustomUIConfig()['__ReplaceTextVariable_IF__'] = ${s2};
                    } catch (error) {}
                `);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
        if (typeof GameUI.CustomUIConfig()['__ReplaceTextVariable_IF__'] == 'boolean') {
          let text = s.slice(end);
          const [sTrueText, start2, end2] = findStringWrapped(text, '(', ')');
          text = text.slice(end2);
          const [sFalseText] = findStringWrapped(text, '(', ')');
          if (GameUI.CustomUIConfig()['__ReplaceTextVariable_IF__']) {
            return sTrueText !== null && sTrueText !== void 0 ? sTrueText : '';
          } else {
            return sFalseText !== null && sFalseText !== void 0 ? sFalseText : '';
          }
        }
        return '';
      }
    },
    'LOCALIZE': {
      'process': (s, vals, options) => {
        return ReplaceTextVariable('#' + s.slice(9, -1), vals);
      }
    }
  };
  function findStringWrapped(text, start, end, pos = 0) {
    let stack = 0;
    let start_index = -1;
    for (let i = pos; i < text.length; i++) {
      if (text[i] == start) {
        if (stack++ == 0) {
          start_index = i;
        }
      } else if (text[i] == end) {
        if (stack > 0) {
          if (--stack == 0) {
            return [text.slice(start_index + 1, i), start_index, i + 1];
          }
        }
      }
    }
    return [];
  }
  function ReplaceTextVariable(text, vals, options = {}) {
    var _a;
    if (!text) return '';
    if (text[0] == '#') {
      text = $.Localize(text, $.GetContextPanel());
    }
    if (typeof vals != 'object') {
      vals = {
        'val': vals
      };
    }
    for (const key in vals) {
      const val = vals[key];
      const bNumberText = typeof val == 'number' ? true : typeof val == 'string' ? !Number.isNaN(Number(NoHtmlText(val))) : false;
      const sVal = typeof val == 'number' ? Number(val.toFixed(2)).toString() : val;
      if (options === null || options === void 0 ? void 0 : options.no_html) {
        if (bNumberText) {
          text = text.replace(new RegExp(`\\[${key}\]%`, 'gm'), sVal + '%');
          text = text.replace(new RegExp(`\\[${key}\]`, 'g'), sVal);
        } else {
          text = text.replace(new RegExp(`\\[${key}\]`, 'g'), val);
        }
      } else {
        if (bNumberText) {
          text = text.replace(new RegExp(`\\[${key}\]%`, 'gm'), SpanText(sVal + '%', 'NumberValues'));
          text = text.replace(new RegExp(`\\[${key}\]`, 'g'), SpanText(sVal, 'NumberValues'));
        } else {
          text = text.replace(new RegExp(`\\[${key}\]`, 'g'), val);
        }
      }
    }
    const process = text => {
      let bChange = false;
      let i = 0;
      while (true) {
        let [s, start, end] = findStringWrapped(text, `[`, ']', i);
        if (s == undefined) break;
        let bChange2 = false;
        let s2 = process(s);
        if (s2) {
          bChange2 = true;
          s = s2;
        }
        for (const func_name in TextFunctions) {
          let [s2, start] = findStringWrapped(s, '(', ')');
          if (s2 != undefined && s.slice(start - func_name.length, start) == func_name) {
            const sResult = TextFunctions[func_name].process(s, vals, options);
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
        } else {
          i = end;
        }
      }
      if (bChange) {
        return text;
      }
    };
    text = (_a = process(text)) !== null && _a !== void 0 ? _a : text;
    for (const key in TextKeyWords) {
      text = text.replace(new RegExp(`\\[${key}\]`, 'g'), TextKeyWords[key]);
    }
    return text;
  }
  function NoHtmlText(text) {
    return text.replace(/<[^>]*>?/g, '');
  }
  function SpanText(text, className = "") {
    return `<span class="${className}">${text}</span>`;
  }
  function ColorText(text, color, className = "") {
    const sClass = className != "" ? `class="${className}"` : undefined;
    if (sClass) return `<font color="${color}" ${sClass} >${text}</font>`;
    return `<font color="${color}">${text}</font>`;
  }

  function WatchBehaviorTree() {
    NetEventData.BindDo('behavior_tree', '', (t, sEntID) => {
      if (t == undefined) {
        let p = $('#BTViewRoot_' + sEntID);
        if (p) {
          render(() => [], p);
          p.DeleteAsync(-1);
        }
      } else {
        let p = $('#BTViewRoot_' + sEntID);
        if (p != undefined) return;
        p = $.CreatePanel("Panel", $.GetContextPanel(), 'BTViewRoot_' + sEntID);
        p.AddClass('BTViewRoot');
        p.hittest = false;
        render(() => createComponent(BTView, {
          get iEntID() {
            return Number(sEntID);
          }
        }), p);
      }
    }, 'BehaviorTreeViewWatcher');
  }
  function BTView(props) {
    let ref;
    let refBody;
    let refLineBox;
    const getEntID = typeof props.iEntID == 'function' ? props.iEntID : () => props.iEntID;
    const [getData] = useNetEventTable(t => t, 'behavior_tree', () => getEntID());
    const [isAlive, setAlive] = createSignal(true);
    createEffect(() => {
      const iEntID = getEntID();
      const id = EventManager.Reg("DrawBTLine", ({
        entid,
        p1,
        p2,
        key,
        activated
      }) => {
        var _a;
        if (entid != iEntID) return;
        let v1 = p1.GetPositionWithinAncestor(refLineBox.GetParent()),
          v2 = p2.GetPositionWithinAncestor(refLineBox.GetParent());
        let fLen = Game.Length2D([v1.x, v1.y, 0], [v2.x, v2.y, 0]);
        if (isNaN(fLen) || fLen <= 0) return;
        let fAngle = Math.atan2(v2.y - v1.y, v2.x - v1.x) * 180 / Math.PI;
        let p = (_a = refLineBox.FindChild('BTLine_' + key)) !== null && _a !== void 0 ? _a : $.CreatePanel('Panel', refLineBox, 'BTLine_' + key);
        p.AddClass('BTLine');
        p.SetHasClass('Activated', activated == true);
        p.style.width = fLen + 'px';
        p.style.preTransformRotate2d = fAngle + 'deg';
        p.style.marginLeft = `-${fLen / 2}px`;
        p.SetPositionInPixels((v1.x + v2.x) / 2 / p.actualuiscale_x, (v1.y + v2.y) / 2 / p.actualuiscale_y, 0);
      });
      const id2 = GameTimer(() => {
        setAlive(Entities.IsAlive(iEntID));
        return 1;
      }, -1, undefined, 'BTView.setAlive');
      onCleanup(() => {
        EventManager.Unreg("DrawBTLine", id);
        StopTimer(id2);
        refLineBox.RemoveAndDeleteChildren();
      });
    });
    const pullBox = params => {
      var _a, _b, _c, _d, _e, _f;
      if (ref) {
        ref.style.width = Number(String((_a = ref.style.width) !== null && _a !== void 0 ? _a : ref.desiredlayoutwidth + 'px').split(/(px|%)/)[0]) + params.x + 'px';
        ref.style.height = Number(String((_b = ref.style.height) !== null && _b !== void 0 ? _b : ref.desiredlayoutheight + 'px').split(/(px|%)/)[0]) + params.y + 'px';
        if (params.pos_move) {
          ref.style.position = parseInt(((_c = ref.style.position) !== null && _c !== void 0 ? _c : '0px 0px 0px').split('px ')[0]) + ((_d = params.pos_x) !== null && _d !== void 0 ? _d : params.x) + 'px ' + (parseInt(((_e = ref.style.position) !== null && _e !== void 0 ? _e : '0px 0px 0px').split('px ')[1]) + ((_f = params.pos_y) !== null && _f !== void 0 ? _f : params.y)) + 'px 0px';
        }
      }
    };
    return (() => {
      const _el$ = createElement("Panel", {
          hittest: true,
          draggable: true
        }, null),
        _el$2 = createElement("Panel", {
          hittest: true,
          draggable: true
        }, _el$);
        createElement("Panel", {
          id: "BTIcon"
        }, _el$2);
        const _el$4 = createElement("Label", {
          id: "BTTitle",
          get text() {
            return `行为树 - ${$.Localize('#' + Entities.GetUnitName(getEntID()))}（${getEntID()}）${!isAlive() ? ' 已死亡' : ''}`;
          }
        }, _el$2),
        _el$5 = createElement("Button", {
          id: "BTCloseBtn"
        }, _el$2),
        _el$6 = createElement("Panel", {}, _el$),
        _el$7 = createElement("Panel", {}, _el$6);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$) : ref = _el$;
      setProp(_el$, "onload", p => {
        $.RegisterEventHandler('DragStart', p, pDrag => {
          SetTop(ref.GetParent());
          if (pDrag != p) return;
          let vPos = GameUI.GetCursorPosition();
          Timer(() => {
            var _a, _b;
            let vPos2 = GameUI.GetCursorPosition();
            refBody.style.position = parseInt(((_a = refBody.style.position) !== null && _a !== void 0 ? _a : '0px 0px 0px').split('px ')[0]) + vPos2[0] - vPos[0] + 'px ' + (parseInt(((_b = refBody.style.position) !== null && _b !== void 0 ? _b : '0px 0px 0px').split('px ')[1]) + vPos2[1] - vPos[1]) + 'px 0px';
            vPos = vPos2;
            if (GameUI.IsMouseDown(0)) return 0;
            $.DispatchEvent('DropInputFocus', p);
          }, 0, 'BTViewBodyMove');
        });
        $.RegisterEventHandler("DragEnd", p, () => {
          StopTimer('BTViewBodyMove');
        });
      });
      setProp(_el$, "onmouseover", () => {
        Mousebinds.Bind((sEvent, iBtnNum, tExtraData, typeEvent, typeBtn) => {
          var _a, _b, _c;
          if (typeBtn == 2048) {
            refBody['_scale'] = Math.max(0, ((_a = refBody['_scale']) !== null && _a !== void 0 ? _a : 1) - ((_b = refBody['_scale']) !== null && _b !== void 0 ? _b : 1) * 0.1);
          } else {
            refBody['_scale'] = ((_c = refBody['_scale']) !== null && _c !== void 0 ? _c : 1) + 0.1;
          }
          refBody.style.preTransformScale2d = refBody['_scale'];
        }, 4096 + 2048 + 4, 'BTViewBodyScale');
      });
      setProp(_el$, "onmouseout", () => {
        Mousebinds.Unbind('BTViewBodyScale');
      });
      setProp(_el$, "onactivate", p => {
        SetTop(ref.GetParent());
      });
      setProp(_el$2, "className", "Hander");
      setProp(_el$2, "onload", p => {
        $.RegisterEventHandler('DragStart', p, () => {
          let pView = ref;
          let vPos = GameUI.GetCursorPosition();
          if (pView['_FullScreen']) {
            pView.style.width = pView['_FullScreen'].width;
            pView.style.height = pView['_FullScreen'].height;
            let width = Number(String(pView['_FullScreen'].width).split('px')[0]) || 0;
            pView.style.position = `${vPos[0] - width / 2}px ${vPos[1]}px 0px`;
            delete pView['_FullScreen'];
            pView.ToggleClass('FullScreen');
          }
          Timer(() => {
            var _a, _b;
            let vPos2 = GameUI.GetCursorPosition();
            pView.style.position = parseInt(((_a = pView.style.position) !== null && _a !== void 0 ? _a : '0px 0px 0px').split('px ')[0]) + vPos2[0] - vPos[0] + 'px ' + (parseInt(((_b = pView.style.position) !== null && _b !== void 0 ? _b : '0px 0px 0px').split('px ')[1]) + vPos2[1] - vPos[1]) + 'px 0px';
            vPos = vPos2;
            if (GameUI.IsMouseDown(0)) return 0;
            $.DispatchEvent('DropInputFocus', p);
          }, 0, 'BTViewMove');
        });
        $.RegisterEventHandler("DragEnd", p, () => {
          StopTimer('BTViewMove');
        });
      });
      setProp(_el$2, "onactivate", p => {
        var _a;
        SetTop(ref.GetParent());
        let fTime = new Date().getTime() / 1000;
        if (fTime - ((_a = p['DoubleClick']) !== null && _a !== void 0 ? _a : 0) < 0.2) {
          let pView = ref;
          pView.ToggleClass('FullScreen');
          if (pView['_FullScreen']) {
            pView.style.position = pView['_FullScreen'].position;
            pView.style.width = pView['_FullScreen'].width;
            pView.style.height = pView['_FullScreen'].height;
            delete pView['_FullScreen'];
          } else {
            pView['_FullScreen'] = {
              position: pView.style.position,
              width: pView.style.width || pView.actuallayoutwidth + 'px',
              height: pView.style.height || pView.actuallayoutheight + 'px'
            };
            pView.style.position = '0px 0px 0px';
            pView.style.width = '100%';
            pView.style.height = '100%';
          }
        }
        p['DoubleClick'] = fTime;
      });
      setProp(_el$5, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-wbt ${getEntID()}`
        });
      });
      const _ref$2 = refBody;
      typeof _ref$2 === "function" ? use(_ref$2, _el$6) : refBody = _el$6;
      setProp(_el$6, "className", "Body");
      const _ref$3 = refLineBox;
      typeof _ref$3 === "function" ? use(_ref$3, _el$7) : refLineBox = _el$7;
      setProp(_el$7, "className", "LineBox");
      insert(_el$6, createComponent(Show, {
        get when() {
          return getData() != undefined;
        },
        get children() {
          return createComponent(BTNodePanel, {
            getEntID: getEntID,
            getData: getData
          });
        }
      }), null);
      insert(_el$, () => [['RightSide', (x, y) => pullBox({
        x,
        y
      })], ['BottomSide', (x, y) => pullBox({
        x: 0,
        y
      })], ['LeftSide', (x, y) => pullBox({
        x: -x,
        y: y,
        pos_move: true,
        pos_x: x,
        pos_y: 0
      })]].map(t => {
        return (() => {
          const _el$8 = createElement("Panel", {
            get id() {
              return t[0];
            },
            draggable: true
          }, null);
          setProp(_el$8, "className", "BoxSide");
          setProp(_el$8, "onload", p => {
            $.RegisterEventHandler('DragStart', p, () => {
              let vPos = GameUI.GetCursorPosition();
              Timer(() => {
                let vPos2 = GameUI.GetCursorPosition();
                t[1](vPos2[0] - vPos[0], vPos2[1] - vPos[1]);
                vPos = vPos2;
                if (GameUI.IsMouseDown(0)) return 0;
              }, 0, 'BTViewBodyPull');
              return false;
            });
            $.RegisterEventHandler("DragEnd", p, () => {
              StopTimer('BTViewBodyPull');
            });
          });
          effect(_$p => setProp(_el$8, "id", t[0], _$p));
          return _el$8;
        })();
      }), null);
      effect(_p$ => {
        const _v$ = classNames('BTView', {
            Alive: isAlive()
          }),
          _v$2 = `行为树 - ${$.Localize('#' + Entities.GetUnitName(getEntID()))}（${getEntID()}）${!isAlive() ? ' 已死亡' : ''}`;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "className", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$4, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }
  function BTNodePanel(props) {
    var _a, _b;
    let isActivated = tData => {
      if (tData.type == "Precondition") {
        return tData.evaluate != undefined;
      } else if (tData.type == "Action") {
        return tData.precondition == undefined && tData.evaluate != undefined || tData.run != undefined;
      } else if (tData.type == "Control") {
        if (tData.children) {
          for (const t of tData.children) {
            if (t.precondition && isActivated(t.precondition)) return true;
            if (isActivated(t)) return true;
          }
        }
      }
      return false;
    };
    const getActivated = createMemo(() => isActivated(props.getData()));
    let refPrecondition;
    let refTail;
    createEffect(() => {
      const iEntID = props.getEntID();
      const bActivated = getActivated();
      const tData = props.getData();
      Timer(() => {
        if (!props.refPanel.IsValid()) return;
        let p1;
        if (tData.precondition) ; else if (props.refParenTail) {
          p1 = props.refParenTail;
        }
        if (p1) {
          let p2 = props.refPanel.FindChildTraverse('BTHeadLine');
          if (p2) {
            EventManager.Fire("DrawBTLine", {
              p1,
              p2,
              key: `${iEntID} ${tData.id}`,
              activated: bActivated,
              entid: iEntID
            });
          }
        }
      }, 1 / 60, undefined, 'BTNodeLine');
    });
    return (() => {
      const _el$9 = createElement("Panel", {
          hittest: false
        }, null),
        _el$0 = createElement("Panel", {
          id: "BTHeadLine",
          hittest: false
        }, _el$9),
        _el$1 = createElement("Panel", {
          id: "BTBox",
          hittest: false
        }, _el$9),
        _el$10 = createElement("Panel", {
          hittest: false
        }, _el$1),
        _el$11 = createElement("Panel", {
          id: "BTTypeIcon",
          hittest: false
        }, _el$1),
        _el$12 = createElement("Image", {
          get src() {
            return `file://{images}/custom_game/behavior_tree/${(() => {
            return {
              ['顺序']: 'icon_bt_sequence',
              ['最大权重']: 'icon_bt_weight',
              ['权重随机']: 'icon_bt_random'
            }[props.getData().name] || {
              ["Control"]: 'icon_bt_control',
              ["Precondition"]: 'icon_bt_precondition',
              ["Action"]: 'icon_bt_action'
            }[props.getData().type];
          })()}.png`;
          }
        }, _el$11),
        _el$13 = createElement("Panel", {}, _el$1),
        _el$14 = createElement("Label", {
          id: "BTName",
          get text() {
            return props.getData().name;
          }
        }, _el$13),
        _el$18 = createElement("Panel", {
          id: "BTTailLine",
          hittest: false
        }, _el$9);
      const _ref$4 = props.refPanel;
      typeof _ref$4 === "function" ? use(_ref$4, _el$9) : props.refPanel = _el$9;
      insert(_el$9, createComponent(Show, {
        get when() {
          return props.getData().precondition != undefined;
        },
        get children() {
          return createComponent(BTNodePanel, {
            getData: () => props.getData().precondition,
            get getEntID() {
              return props.getEntID;
            },
            refPanel: refPrecondition,
            get refParenTail() {
              return props.refParenTail;
            }
          });
        }
      }), _el$0);
      setProp(_el$10, "className", "BG");
      setProp(_el$13, "className", "Body");
      setProp(_el$13, "onmouseover", p => {
        if (props.getData().description) {
          $.DispatchEvent('DOTAShowTextTooltip', p, props.getData().description);
        }
      });
      setProp(_el$13, "onmouseout", p => {
        $.DispatchEvent('DOTAHideTextTooltip', p);
      });
      insert(_el$13, createComponent(Show, {
        get when() {
          return props.getData().evaluate != undefined;
        },
        get children() {
          const _el$15 = createElement("Label", {
            id: "BTEvaluate",
            get text() {
              return `评估值：${props.getData().evaluate}`;
            }
          }, null);
          effect(_$p => setProp(_el$15, "text", `评估值：${props.getData().evaluate}`, _$p));
          return _el$15;
        }
      }), null);
      insert(_el$13, createComponent(Show, {
        get when() {
          return getActivated();
        },
        get children() {
          return createComponent(Switch, {
            get children() {
              return [createComponent(Match, {
                get when() {
                  return props.getData().type == "Action";
                },
                get children() {
                  const _el$16 = createElement("Label", {
                    id: "BTStatus",
                    html: true,
                    get text() {
                      return memo(() => !!(props.getData().evaluate != undefined && props.getData().evaluate <= 0))() ? ColorText((_a = props.getData().err) !== null && _a !== void 0 ? _a : '失败', 'red') : {
                        [1]: ColorText('运行中...', 'yellow'),
                        [2]: ColorText('运行且完成', '#74b14aff')
                      }[props.getData().run];
                    }
                  }, null);
                  effect(_$p => setProp(_el$16, "text", memo(() => !!(props.getData().evaluate != undefined && props.getData().evaluate <= 0))() ? ColorText((_a = props.getData().err) !== null && _a !== void 0 ? _a : '失败', 'red') : {
                    [1]: ColorText('运行中...', 'yellow'),
                    [2]: ColorText('运行且完成', '#74b14aff')
                  }[props.getData().run], _$p));
                  return _el$16;
                }
              }), createComponent(Match, {
                get when() {
                  return props.getData().type == "Precondition";
                },
                get children() {
                  const _el$17 = createElement("Label", {
                    id: "BTStatus",
                    get text() {
                      return memo(() => props.getData().evaluate <= 0)() ? ColorText((_b = props.getData().err) !== null && _b !== void 0 ? _b : '失败', 'red') : ColorText('成功', '#74b14aff');
                    },
                    html: true
                  }, null);
                  effect(_$p => setProp(_el$17, "text", memo(() => props.getData().evaluate <= 0)() ? ColorText((_b = props.getData().err) !== null && _b !== void 0 ? _b : '失败', 'red') : ColorText('成功', '#74b14aff'), _$p));
                  return _el$17;
                }
              })];
            }
          });
        }
      }), null);
      const _ref$5 = refTail;
      typeof _ref$5 === "function" ? use(_ref$5, _el$18) : refTail = _el$18;
      insert(_el$9, createComponent(Show, {
        get when() {
          return memo(() => !!props.getData().children)() && props.getData().children.length > 0;
        },
        get children() {
          const _el$19 = createElement("Panel", {
            id: "BTChildrenBox"
          }, null);
          insert(_el$19, createComponent(Index, {
            get each() {
              return props.getData().children;
            },
            children: (t, i) => {
              return createComponent(BTNodePanel, {
                getData: t,
                get getEntID() {
                  return props.getEntID;
                },
                refParenTail: refTail
              });
            }
          }));
          return _el$19;
        }
      }), null);
      effect(_p$ => {
        const _v$3 = classNames("BTNodePanel", 'Type_' + props.getData().type, {
            'Activated': getActivated(),
            'Success': props.getData().evaluate != undefined && props.getData().evaluate > 0,
            'Fail': props.getData().evaluate != undefined && props.getData().evaluate <= 0
          }),
          _v$4 = `file://{images}/custom_game/behavior_tree/${(() => {
          return {
            ['顺序']: 'icon_bt_sequence',
            ['最大权重']: 'icon_bt_weight',
            ['权重随机']: 'icon_bt_random'
          }[props.getData().name] || {
            ["Control"]: 'icon_bt_control',
            ["Precondition"]: 'icon_bt_precondition',
            ["Action"]: 'icon_bt_action'
          }[props.getData().type];
        })()}.png`,
          _v$5 = props.getData().name;
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$9, "className", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$12, "src", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$14, "text", _v$5, _p$._v$5));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined
      });
      return _el$9;
    })();
  }
  function SetTop(p) {
    let pLast = SetTop['last'];
    if (pLast != undefined && pLast.IsValid()) {
      pLast.style.zIndex = 0;
    }
    SetTop['last'] = p;
    p.style.zIndex = 100;
  }

  var Diy;
  (function (Diy) {
    class DiyAbility {
      constructor(iEntID, iAbltID) {
        this.__iEntID = iEntID;
        this.__iAbltID = iAbltID;
      }
      GetDiyAbilityCustomAttributes() {
        var _a;
        return (_a = GameUI.CustomUIConfig().tools.runlua(`
                local tAttributes = {}
                local hUnit = EntIndexToHScript(${this.__iEntID})
                if IsValid(hUnit) then
                    local hAblt = EntIndexToHScript(${this.__iAbltID})
                    if hAblt and hAblt.DDeclareFunctions then
                        for typeFun, v in pairs(hAblt:DDeclareFunctions()) do
                            if type(typeFun) == "table" then
                                local hAttribute = typeFun
                                tAttributes[hAttribute.name] = hAttribute:GetByKey(hUnit, hAblt)
                            end
                        end
                    end
                end
                return tAttributes
            `)) !== null && _a !== void 0 ? _a : {};
      }
      GetAbilityName() {
        return Abilities.GetAbilityName(this.__iAbltID);
      }
      GetAbilityTextureName() {
        return Abilities.GetAbilityTextureName(this.__iAbltID);
      }
      GetAssociatedPrimaryAbilities() {
        return Abilities.GetAssociatedPrimaryAbilities(this.__iAbltID);
      }
      GetAssociatedSecondaryAbilities() {
        return Abilities.GetAssociatedSecondaryAbilities(this.__iAbltID);
      }
      GetHotkeyOverride() {
        return Abilities.GetHotkeyOverride(this.__iAbltID);
      }
      GetIntrinsicModifierName() {
        return Abilities.GetIntrinsicModifierName(this.__iAbltID);
      }
      GetSharedCooldownName() {
        return Abilities.GetSharedCooldownName(this.__iAbltID);
      }
      AbilityReady() {
        return Abilities.AbilityReady(this.__iAbltID);
      }
      CanAbilityBeUpgraded() {
        return Abilities.CanAbilityBeUpgraded(this.__iAbltID);
      }
      CanBeExecuted() {
        return Abilities.CanBeExecuted(this.__iAbltID);
      }
      GetAbilityDamage() {
        return Abilities.GetAbilityDamage(this.__iAbltID);
      }
      GetAbilityDamageType() {
        return Abilities.GetAbilityDamageType(this.__iAbltID);
      }
      GetAbilityTargetFlags() {
        return Abilities.GetAbilityTargetFlags(this.__iAbltID);
      }
      GetAbilityTargetTeam() {
        return Abilities.GetAbilityTargetTeam(this.__iAbltID);
      }
      GetAbilityTargetType() {
        return Abilities.GetAbilityTargetType(this.__iAbltID);
      }
      GetAbilityType() {
        return Abilities.GetAbilityType(this.__iAbltID);
      }
      GetBehavior() {
        return Abilities.GetBehavior(this.__iAbltID);
      }
      GetCastRange() {
        return Abilities.GetCastRange(this.__iAbltID);
      }
      GetChannelledManaCostPerSecond() {
        return Abilities.GetChannelledManaCostPerSecond(this.__iAbltID);
      }
      GetCurrentCharges() {
        return Abilities.GetCurrentCharges(this.__iAbltID);
      }
      GetEffectiveLevel() {
        return Abilities.GetEffectiveLevel(this.__iAbltID);
      }
      GetHeroLevelRequiredToUpgrade() {
        return Abilities.GetHeroLevelRequiredToUpgrade(this.__iAbltID);
      }
      GetLevel() {
        return Abilities.GetLevel(this.__iAbltID);
      }
      GetManaCost() {
        return Abilities.GetManaCost(this.__iAbltID);
      }
      GetMaxLevel() {
        return Abilities.GetMaxLevel(this.__iAbltID);
      }
      AttemptToUpgrade() {
        return Abilities.AttemptToUpgrade(this.__iAbltID);
      }
      CanLearn() {
        return Abilities.CanLearn(this.__iAbltID);
      }
      GetAutoCastState() {
        return Abilities.GetAutoCastState(this.__iAbltID);
      }
      GetToggleState() {
        return Abilities.GetToggleState(this.__iAbltID);
      }
      HasScepterUpgradeTooltip() {
        return Abilities.HasScepterUpgradeTooltip(this.__iAbltID);
      }
      IsActivated() {
        return Abilities.IsActivated(this.__iAbltID);
      }
      IsActivatedChanging() {
        return Abilities.IsActivatedChanging(this.__iAbltID);
      }
      IsAttributeBonus() {
        return Abilities.IsAttributeBonus(this.__iAbltID);
      }
      IsAutocast() {
        return Abilities.IsAutocast(this.__iAbltID);
      }
      IsCooldownReady() {
        return Abilities.IsCooldownReady(this.__iAbltID);
      }
      IsDisplayedAbility() {
        return Abilities.IsDisplayedAbility(this.__iAbltID);
      }
      IsHidden() {
        return Abilities.IsHidden(this.__iAbltID);
      }
      IsHiddenWhenStolen() {
        return Abilities.IsHiddenWhenStolen(this.__iAbltID);
      }
      IsInAbilityPhase() {
        return Abilities.IsInAbilityPhase(this.__iAbltID);
      }
      IsItem() {
        return Abilities.IsItem(this.__iAbltID);
      }
      IsMarkedAsDirty() {
        return Abilities.IsMarkedAsDirty(this.__iAbltID);
      }
      IsMuted() {
        return Abilities.IsMuted(this.__iAbltID);
      }
      IsOnCastbar() {
        return Abilities.IsOnCastbar(this.__iAbltID);
      }
      IsOnLearnbar() {
        return Abilities.IsOnLearnbar(this.__iAbltID);
      }
      IsOwnersGoldEnough() {
        return Abilities.IsOwnersGoldEnough(this.__iAbltID);
      }
      IsOwnersGoldEnoughForUpgrade() {
        return Abilities.IsOwnersGoldEnoughForUpgrade(this.__iAbltID);
      }
      IsOwnersManaEnough() {
        return Abilities.IsOwnersManaEnough(this.__iAbltID);
      }
      IsPassive() {
        return Abilities.IsPassive(this.__iAbltID);
      }
      IsRecipe() {
        return Abilities.IsRecipe(this.__iAbltID);
      }
      IsSharedWithTeammates() {
        return Abilities.IsSharedWithTeammates(this.__iAbltID);
      }
      IsStealable() {
        return Abilities.IsStealable(this.__iAbltID);
      }
      IsStolen() {
        return Abilities.IsStolen(this.__iAbltID);
      }
      IsToggle() {
        return Abilities.IsToggle(this.__iAbltID);
      }
      GetAOERadius() {
        return Abilities.GetAOERadius(this.__iAbltID);
      }
      GetBackswingTime() {
        return Abilities.GetBackswingTime(this.__iAbltID);
      }
      GetCastPoint() {
        return Abilities.GetCastPoint(this.__iAbltID);
      }
      GetChannelStartTime() {
        return Abilities.GetChannelStartTime(this.__iAbltID);
      }
      GetChannelTime() {
        return Abilities.GetChannelTime(this.__iAbltID);
      }
      GetCooldown() {
        return Abilities.GetCooldown(this.__iAbltID);
      }
      GetCooldownLength() {
        return Abilities.GetCooldownLength(this.__iAbltID);
      }
      GetCooldownTime() {
        return Abilities.GetCooldownTime(this.__iAbltID);
      }
      GetCooldownTimeRemaining() {
        return Abilities.GetCooldownTimeRemaining(this.__iAbltID);
      }
      GetDuration() {
        return Abilities.GetDuration(this.__iAbltID);
      }
      GetUpgradeBlend() {
        return Abilities.GetUpgradeBlend(this.__iAbltID);
      }
      GetLocalPlayerActiveAbility() {
        return Abilities.GetLocalPlayerActiveAbility();
      }
      GetCaster() {
        return this.__iEntID;
      }
      GetCustomValueFor(pszAbilityVarName) {
        return Abilities.GetCustomValueFor(this.__iAbltID, pszAbilityVarName);
      }
      GetLevelSpecialValueFor(szName, nLevel) {
        return Abilities.GetLevelSpecialValueFor(this.__iAbltID, szName, nLevel);
      }
      GetSpecialValueFor(szName) {
        return Abilities.GetSpecialValueFor(this.__iAbltID, szName);
      }
      IsCosmetic(nTargetEntityIndex) {
        return Abilities.IsCosmetic(this.__iAbltID, nTargetEntityIndex);
      }
      ExecuteAbility(nCasterEntIndex, bIsQuickCast) {
        return Abilities.ExecuteAbility(this.__iAbltID, nCasterEntIndex, bIsQuickCast);
      }
      CreateDoubleTapCastOrder(nCasterEntIndex) {
        return Abilities.CreateDoubleTapCastOrder(this.__iAbltID, nCasterEntIndex);
      }
      PingAbility() {
        return Abilities.PingAbility(this.__iAbltID);
      }
      GetKeybind() {
        return Abilities.GetKeybind(this.__iAbltID);
      }
      GetAbilitySlot(iAbltID) {
        return Abilities.GetAbilitySlot(iAbltID);
      }
      GetCooldownModified(iAbltID) {
        return Abilities.GetCooldownModified(iAbltID);
      }
      GetManaCostModified(iAbltID) {
        return Abilities.GetManaCostModified(iAbltID);
      }
    }
    Diy.DiyAbility = DiyAbility;
    class DiyModifier {
      constructor(iEntID, params) {
        this.__iParentEntID = iEntID;
        if (params.buff_id != undefined) {
          this.__iBuffID = params.buff_id;
        } else if (params.creation_time != undefined && params.name != undefined) {
          const creation_time = params.creation_time.toFixed(2);
          for (let i = Entities.GetNumBuffs(iEntID) - 1; i >= 0; --i) {
            const iBuffID = Entities.GetBuff(iEntID, i);
            if (Buffs.GetName(iEntID, iBuffID) == params.name && Buffs.GetCreationTime(iEntID, iBuffID).toFixed(2) == creation_time) {
              this.__iBuffID = iBuffID;
              break;
            }
          }
        }
      }
      GetBuffID() {
        return this.__iBuffID;
      }
      GetName() {
        return Buffs.GetName(this.__iParentEntID, this.__iBuffID);
      }
      GetAbility() {
        return Buffs.GetAbility(this.__iParentEntID, this.__iBuffID);
      }
      GetParent() {
        return Buffs.GetParent(this.__iParentEntID, this.__iBuffID);
      }
      GetCaster() {
        return Buffs.GetCaster(this.__iParentEntID, this.__iBuffID);
      }
      GetTexture() {
        return Buffs.GetTexture(this.__iParentEntID, this.__iBuffID);
      }
      GetAttributes() {
        return this.__call('GetAttributes');
      }
      GetPriority() {
        return this.__call('GetPriority');
      }
      GetAuraDuration() {
        return this.__call('GetAuraDuration');
      }
      GetAuraEntityReject() {
        return this.__call('GetAuraEntityReject');
      }
      GetAuraRadius() {
        return this.__call('GetAuraRadius');
      }
      GetAuraSearchFlags() {
        return this.__call('GetAuraSearchFlags');
      }
      GetAuraSearchTeam() {
        return this.__call('GetAuraSearchTeam');
      }
      GetAuraSearchType() {
        return this.__call('GetAuraSearchType');
      }
      GetModifierAura() {
        return this.__call('GetModifierAura');
      }
      IsAura() {
        return this.__call('IsAura');
      }
      IsAuraActiveOnDeath() {
        return this.__call('IsAuraActiveOnDeath');
      }
      GetEffectAttachType() {
        return this.__call('GetEffectAttachType');
      }
      GetEffectName() {
        return this.__call('GetEffectName');
      }
      GetHeroEffectName() {
        return this.__call('GetHeroEffectName');
      }
      GetStatusEffectName() {
        return this.__call('GetStatusEffectName');
      }
      HeroEffectPriority() {
        return this.__call('HeroEffectPriority');
      }
      StatusEffectPriority() {
        return this.__call('StatusEffectPriority');
      }
      GetCreationTime() {
        return Buffs.GetCreationTime(this.__iParentEntID, this.__iBuffID);
      }
      GetDieTime() {
        return Buffs.GetDieTime(this.__iParentEntID, this.__iBuffID);
      }
      GetDuration() {
        return Buffs.GetDuration(this.__iParentEntID, this.__iBuffID);
      }
      GetElapsedTime() {
        return Buffs.GetElapsedTime(this.__iParentEntID, this.__iBuffID);
      }
      GetLastAppliedTime() {
        return this.__call('GetLastAppliedTime');
      }
      GetRemainingTime() {
        return Buffs.GetRemainingTime(this.__iParentEntID, this.__iBuffID);
      }
      GetClass() {
        return Buffs.GetClass(this.__iParentEntID, this.__iBuffID);
      }
      GetSerialNumber() {
        return this.__call('GetSerialNumber');
      }
      GetStackCount() {
        return Buffs.GetStackCount(this.__iParentEntID, this.__iBuffID);
      }
      CheckState() {
        return this.__call('CheckState');
      }
      HasFunction(iFunction) {
        return this.__call('HasFunction', iFunction);
      }
      IsHidden() {
        return Buffs.IsHidden(this.__iParentEntID, this.__iBuffID);
      }
      IsDebuff() {
        return Buffs.IsDebuff(this.__iParentEntID, this.__iBuffID);
      }
      IsStunDebuff() {
        return this.__call('IsStunDebuff');
      }
      IsPurgable() {
        return this.__call('IsPurgable');
      }
      IsPurgeException() {
        return this.__call('IsPurgeException');
      }
      IsPermanent() {
        return this.__call('IsPermanent');
      }
      AllowIllusionDuplicate() {
        return this.__call('AllowIllusionDuplicate');
      }
      RemoveOnDeath() {
        return this.__call('RemoveOnDeath');
      }
      OnTooltip() {
        return this.__call('OnTooltip');
      }
      OnTooltip2() {
        return this.__call('OnTooltip2');
      }
      GetCustomAttributes() {
        var _a;
        return (_a = GameUI.CustomUIConfig().tools.runlua(`
            local tAttributes = {}
            local hUnit = EntIndexToHScript(${this.__iParentEntID})
            if IsValid(hUnit) then
                local hBuff = hUnit:FindModifierByJsBuff('${this.GetName()}', ${this.GetCreationTime()})
                if hBuff and hBuff.DDeclareFunctions then
                    for typeFun, v in pairs(hBuff:DDeclareFunctions()) do
                        if type(typeFun) == "table" then
                            local hAttribute = typeFun
                            tAttributes[hAttribute.name] = hAttribute:GetByKey(hUnit, hBuff)
                        end
                    end
                end
            end
            return tAttributes
            `)) !== null && _a !== void 0 ? _a : {};
      }
      __call(sFunc, ...args) {
        let sParams = args.map(v => {
          if (typeof v == 'boolean') {
            return v;
          } else if (typeof v == 'string') {
            return "'" + v + "'";
          } else if (typeof v == 'number') {
            if (Number.isNaN(v)) {
              return '0/0';
            }
            return v;
          }
          return 'nil';
        }).join(',');
        return GameUI.CustomUIConfig().tools.runlua(`
            local hUnit = EntIndexToHScript(${this.__iParentEntID})
            if IsValid(hUnit) then
                local hBuff = hUnit:FindModifierByJsBuff('${this.GetName()}', ${this.GetCreationTime()})
                if hBuff then
                    return hBuff:${sFunc}(${sParams})
                end
            end
            `);
      }
    }
    Diy.DiyModifier = DiyModifier;
  })(Diy || (Diy = {}));

  var _a, _b, _c;
  class Attribute {
    constructor(hParent, hMath) {
      this.hParent = hParent;
      this.hMath = hMath;
    }
    Get(iEntID, key, ...args) {
      return GameUI.CustomUIConfig().tools.AttributeGet(iEntID, this.name, key, ...args);
    }
    Data(iEntID) {
      const tData = [];
      for (const {
        k,
        v
      } of GameUI.CustomUIConfig().tools.AttributeData(iEntID, this.name)) {
        if (k.type == 'key') {
          const get_key = k.name;
          tData.push({
            k: k.name,
            v: v.is_dynamic ? () => this.Get(iEntID, get_key) : v.val
          });
        } else {
          let get_key;
          let key = k.name;
          if (k.type == 'ability') {
            get_key = GameUI.CustomUIConfig().tools.EntIndexToHScript(k.ability_entid);
            key = new Diy.DiyAbility(iEntID, k.ability_entid);
          } else if (k.type == 'buff') {
            const h = key = new Diy.DiyModifier(iEntID, {
              'name': k.name,
              'creation_time': k.buff_creation_time
            });
            get_key = GameUI.CustomUIConfig().tools.BuffToModifier(iEntID, h.GetBuffID());
          } else if (k.type == 'polymer') {
            get_key = GameUI.CustomUIConfig().tools.PolymerIDToDiyPolymer(iEntID, k.polymer_id);
          } else {
            const object_address = k.object_address;
            tData.push({
              k: key,
              v: v.is_dynamic ? () => GameUI.CustomUIConfig().tools.runlua(`
                            local hUnit = EntIndexToHScript(${iEntID})
                            if IsValid(hUnit) then
                                local hAttribute = AttributeSysteam.ID2Attribute[${this.name}]
                                local _ = hAttribute:Data(hUnit)
                                if _ then
                                    for ____, t in ipairs(_) do
                                        for k, v in pairs(t) do
                                            if type(k) == "table" and tostring(k) == "${object_address}" then
                                                return hAttribute:GetByKey(hUnit, k)
                                            end
                                        end
                                    end
                                end
                            end`) : v.val
            });
            continue;
          }
          tData.push({
            k: key,
            v: v.is_dynamic ? () => this.Get(iEntID, get_key) : v.val
          });
        }
      }
      return tData;
    }
  }
  var MathAlgorithm;
  (function (MathAlgorithm) {
    class Base {
      static count(x, y) {}
      static reverse_count(x, y) {}
    }
    MathAlgorithm.Base = Base;
    class Add extends Base {
      static count(x, y) {
        return x + y;
      }
      static reverse_count(x, y) {
        return x - y;
      }
    }
    Add.base = 0;
    MathAlgorithm.Add = Add;
    class PctAdd extends Base {
      static count(x, y) {
        return x + y;
      }
      static reverse_count(x, y) {
        return x - y;
      }
    }
    PctAdd.base = 100;
    MathAlgorithm.PctAdd = PctAdd;
    class Add_Min0 extends Base {
      static count(x, y) {
        if (y != y) return x;
        return x + y;
      }
      static reverse_count(x, y) {
        if (y != y) return x;
        return x - y;
      }
    }
    Add_Min0.base = 0;
    Add_Min0.post_process = function (v) {
      return Math.max(v, 0);
    };
    MathAlgorithm.Add_Min0 = Add_Min0;
    class PctAdd_Min0 extends Base {
      static count(x, y) {
        return x + y;
      }
      static reverse_count(x, y) {
        return x - y;
      }
    }
    PctAdd_Min0.base = 100;
    PctAdd_Min0.post_process = function (v) {
      return Math.max(v, 0);
    };
    MathAlgorithm.PctAdd_Min0 = PctAdd_Min0;
    class PctMul extends Base {
      static count(x, y) {
        if (y <= -100) return 0;
        return x * (100 + y) * 0.01;
      }
      static reverse_count(x, y) {
        if (y <= -100) return NaN;
        return x / (100 + y) * 100;
      }
    }
    PctMul.base = 100;
    MathAlgorithm.PctMul = PctMul;
    class PctInvMul extends Base {
      static count(x, y) {
        if (y >= 100) return 100;
        return 100 - (100 - x) * (100 - y) * 0.01;
      }
      static reverse_count(x, y) {
        if (y >= 100) return NaN;
        return 100 - (100 - x) / (100 - y) * 100;
      }
    }
    PctInvMul.base = 0;
    MathAlgorithm.PctInvMul = PctInvMul;
  })(MathAlgorithm || (MathAlgorithm = {}));
  class LevelAttribute extends Attribute {
    constructor(hParent) {
      super(hParent, undefined);
    }
    Get(iEntID, key, ...args) {
      return GameUI.CustomUIConfig().tools.AttributeGet(iEntID, this.name, key, ...args);
    }
    Data(iEntID) {
      return super.Data(iEntID);
    }
  }
  class ConstAttribute extends Attribute {}
  var DotaAttribute;
  (function (DotaAttribute) {
    DotaAttribute.Main = new class Main extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Secondary = new class Secondary extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.AllStats = new class AllStats extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Strength = new class Strength extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Agility = new class Agility extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Intellect = new class Intellect extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Attributes2Class = {
      [Attributes.DOTA_ATTRIBUTE_STRENGTH]: DotaAttribute.Strength,
      [Attributes.DOTA_ATTRIBUTE_AGILITY]: DotaAttribute.Agility,
      [Attributes.DOTA_ATTRIBUTE_INTELLECT]: DotaAttribute.Intellect
    };
    DotaAttribute.Atk = new class Atk extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.PhyFixDmg = new class PhyFixDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.MgcFixDmg = new class MgcFixDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.AtkPure = new class AtkPure extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.HpLimit = new class HpLimit extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.HpRegen = new class HpRegen extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.HP_PCT = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.MpLimit = new class MpLimit extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.MpRegen = new class MpRegen extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.MP_PCT = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.Armor = new class Armor extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_2 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
        this.AMP_4 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.AtkSpd = new class AtkSpd extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.TOTAL = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.AtkTime = new class AtkTime extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MIN = new LevelAttribute(this);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.MoveSpd = new class MoveSpd extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
        this.LIMIT_MIN = new LevelAttribute(this);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.AtkRange = new class AtkRange extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }();
    DotaAttribute.PrjctSpd = new class PrjctSpd extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.CastRange = new class CastRange extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
      }
    }();
    DotaAttribute.Cooldown = new class Cooldown extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }();
    DotaAttribute.StaResist = new Attribute(undefined, MathAlgorithm.PctInvMul);
    DotaAttribute.DebuffAmp = new Attribute(undefined, MathAlgorithm.PctInvMul);
    DotaAttribute.Hit = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Evasion = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Heal = new Attribute(undefined, MathAlgorithm.Add);
    DotaAttribute.Vision = new class Vision extends Attribute {
      constructor() {
        super(...arguments);
        this.DAY = new class DAY extends Attribute {
          constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
          }
        }(this);
        this.NIGHT = new class NIGHT extends Attribute {
          constructor() {
            super(...arguments);
            this.BASE = new Attribute(this, MathAlgorithm.Add);
            this.PCT = new Attribute(this, MathAlgorithm.Add);
            this.OVERRIDE = new LevelAttribute(this);
          }
        }(this);
      }
    }();
    DotaAttribute.ModelScale = new class ModelScale extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.PctAdd_Min0);
      }
    }();
    DotaAttribute.Model = new LevelAttribute();
    DotaAttribute.Prjct = new LevelAttribute();
    DotaAttribute.AtkAnimPoint = new Attribute();
    DotaAttribute.HpMin = new LevelAttribute();
  })(DotaAttribute || (DotaAttribute = {}));
  const AttributeCfg = {
    Main: DotaAttribute.Main,
    Secondary: DotaAttribute.Secondary,
    AllStats: DotaAttribute.AllStats,
    Strength: DotaAttribute.Strength,
    Agility: DotaAttribute.Agility,
    Intellect: DotaAttribute.Intellect,
    Atk: DotaAttribute.Atk,
    PhyFixDmg: DotaAttribute.PhyFixDmg,
    MgcFixDmg: DotaAttribute.MgcFixDmg,
    AtkPure: DotaAttribute.AtkPure,
    HpLimit: DotaAttribute.HpLimit,
    HpRegen: DotaAttribute.HpRegen,
    MpLimit: DotaAttribute.MpLimit,
    MpRegen: DotaAttribute.MpRegen,
    Armor: DotaAttribute.Armor,
    AtkSpd: DotaAttribute.AtkSpd,
    AtkTime: DotaAttribute.AtkTime,
    MoveSpd: DotaAttribute.MoveSpd,
    AtkRange: DotaAttribute.AtkRange,
    PrjctSpd: DotaAttribute.PrjctSpd,
    CastRange: DotaAttribute.CastRange,
    Cooldown: DotaAttribute.Cooldown,
    StaResist: DotaAttribute.StaResist,
    DebuffAmp: DotaAttribute.DebuffAmp,
    Hit: DotaAttribute.Hit,
    Evasion: DotaAttribute.Evasion,
    Heal: DotaAttribute.Heal,
    Vision: DotaAttribute.Vision,
    ModelScale: DotaAttribute.ModelScale,
    Model: DotaAttribute.Model,
    Prjct: DotaAttribute.Prjct,
    AtkAnimPoint: DotaAttribute.AtkAnimPoint,
    HpMin: DotaAttribute.HpMin,
    ArmorPenetrate: new class ArmorPenetrate extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    ArmorIgnore: new class ArmorIgnore extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    PhyCritChance: new class PhyCritChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    MgcCritChance: new class MgcCritChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    PureCritChance: new class PureCritChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    PhyCritDmg: new class PhyCritDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    MgcCritDmg: new class MgcCritDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    PureCritDmg: new class PureCritDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    MultCount: new Attribute(undefined, MathAlgorithm.Add),
    MultDmg: new Attribute(undefined, MathAlgorithm.Add),
    BounceCount: new Attribute(undefined, MathAlgorithm.Add),
    BounceDmg: new Attribute(undefined, MathAlgorithm.Add),
    CleaveCount: new Attribute(undefined, MathAlgorithm.Add),
    CleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    StrGain: new class StrGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AgiGain: new class AgiGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    IntGain: new class IntGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AtkGain: new class AtkGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AtkPureGain: new class AtkPureGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    HpGain: new class HpGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    PhyFixedGain: new class PhyFixedGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    MgcFixedGain: new class MgcFixedGain extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.BONUS = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_3 = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    CreepDmg: new class CreepDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    EliteDmg: new class EliteDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    ChallengeDmg: new class ChallengeDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    BossDmg: new class BossDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    ArchiveDmg: new class ArchiveDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AtkDmg: new class AtkDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AbltDmg: new class AbltDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    PhyDmg: new class PhyDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    MgcDmg: new class MgcDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    PureDmg: new class PureDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    AllDmg: new class AllDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    DmgFinal: new class DmgFinal extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    DmgReduce: new class DmgReduce extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined),
    GoldPct: new Attribute(undefined, MathAlgorithm.Add),
    WoodPct: new Attribute(undefined, MathAlgorithm.Add),
    KillPct: new Attribute(undefined, MathAlgorithm.Add),
    ExpPct: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAllStats: new Attribute(undefined, MathAlgorithm.Add),
    PerSecStr: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAgi: new Attribute(undefined, MathAlgorithm.Add),
    PerSecInt: new Attribute(undefined, MathAlgorithm.Add),
    PerSecHp: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAtk: new Attribute(undefined, MathAlgorithm.Add),
    PerSecAtkPure: new Attribute(undefined, MathAlgorithm.Add),
    PerSecPhyFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    PerSecMgcFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    PerSecGold: new Attribute(undefined, MathAlgorithm.Add),
    PerSecWood: new Attribute(undefined, MathAlgorithm.Add),
    PerSecKill: new Attribute(undefined, MathAlgorithm.Add),
    PerSecExp: new Attribute(undefined, MathAlgorithm.Add),
    KillAllStats: new Attribute(undefined, MathAlgorithm.Add),
    KillStr: new Attribute(undefined, MathAlgorithm.Add),
    KillAgi: new Attribute(undefined, MathAlgorithm.Add),
    KillInt: new Attribute(undefined, MathAlgorithm.Add),
    KillHp: new Attribute(undefined, MathAlgorithm.Add),
    KillAtk: new Attribute(undefined, MathAlgorithm.Add),
    KillAtkPure: new Attribute(undefined, MathAlgorithm.Add),
    KillPhyFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    KillMgcFixDmg: new Attribute(undefined, MathAlgorithm.Add),
    KillGold: new Attribute(undefined, MathAlgorithm.Add),
    KillWood: new Attribute(undefined, MathAlgorithm.Add),
    KillKill: new Attribute(undefined, MathAlgorithm.Add),
    KillExp: new Attribute(undefined, MathAlgorithm.Add),
    KillRegenHp: new Attribute(undefined, MathAlgorithm.Add),
    KillGoldPct: new Attribute(undefined, MathAlgorithm.Add),
    KillWoodPct: new Attribute(undefined, MathAlgorithm.Add),
    KillKillPct: new Attribute(undefined, MathAlgorithm.Add),
    KillExpPct: new Attribute(undefined, MathAlgorithm.Add),
    RespawnChance: new Attribute(undefined, MathAlgorithm.Add),
    RespawnTime: new class RespawnTime extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.PCT = new Attribute(this, MathAlgorithm.Add);
        this.OVERRIDE = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    SummonDoubleChance: new Attribute(undefined, MathAlgorithm.Add),
    SummonDuration: new Attribute(undefined, MathAlgorithm.Add),
    SummonDmg: new Attribute(undefined, MathAlgorithm.Add),
    HolyDmg: new class HolyDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    NatureDmg: new class NatureDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    FrostDmg: new class FrostDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    FireDmg: new class FireDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    PhysicalDmg: new class PhysicalDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    ShadowDmg: new class ShadowDmg extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.AMP = new Attribute(this, MathAlgorithm.Add);
        this.AMP_1 = new Attribute(this, MathAlgorithm.Add);
        this.AMP2 = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
      }
    }(undefined, MathAlgorithm.Add),
    AllFlagDmg: new Attribute(undefined, MathAlgorithm.Add),
    HolyPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    NaturePenetrate: new Attribute(undefined, MathAlgorithm.Add),
    FrostPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    FirePenetrate: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    ShadowPenetrate: new Attribute(undefined, MathAlgorithm.Add),
    HolyResist: new Attribute(undefined, MathAlgorithm.Add),
    NatureResist: new Attribute(undefined, MathAlgorithm.Add),
    FrostResist: new Attribute(undefined, MathAlgorithm.Add),
    FireResist: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalResist: new Attribute(undefined, MathAlgorithm.Add),
    ShadowResist: new Attribute(undefined, MathAlgorithm.Add),
    InitGood: new Attribute(undefined, MathAlgorithm.Add),
    InitWood: new Attribute(undefined, MathAlgorithm.Add),
    InitKill: new Attribute(undefined, MathAlgorithm.Add),
    GainDoubleChance: new class GainDoubleChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    DoubleCastChance: new class DoubleCastChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.UNIQUE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    AtkPureChance: new Attribute(undefined, MathAlgorithm.Add),
    MgcPureChance: new Attribute(undefined, MathAlgorithm.Add),
    AtkCleaveChance: new class AtkCleaveChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    AtkCleaveRadius: new Attribute(undefined, MathAlgorithm.Add),
    AtkCleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    PureCleaveChance: new class PureCleaveChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    PureCleaveRadius: new Attribute(undefined, MathAlgorithm.Add),
    PureCleaveDmg: new Attribute(undefined, MathAlgorithm.Add),
    AtkBadDmgChance: new class AtkBadDmgChance extends Attribute {
      constructor() {
        super(...arguments);
        this.BASE = new Attribute(this, MathAlgorithm.Add);
        this.LIMIT_MAX = new LevelAttribute(this);
      }
    }(undefined, MathAlgorithm.Add),
    AtkBadDmg: new Attribute(undefined, MathAlgorithm.Add),
    AtkBadDuration: new Attribute(undefined, MathAlgorithm.Add),
    BadEffect: new Attribute(undefined, MathAlgorithm.Add),
    CardEffect: new Attribute(undefined, MathAlgorithm.Add),
    FatalBlow: new Attribute(undefined, MathAlgorithm.Add),
    PenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    BurnDmg: new Attribute(undefined, MathAlgorithm.Add),
    IceDmg: new Attribute(undefined, MathAlgorithm.Add),
    GoldChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    WoodChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    ExpChallengeCount: new Attribute(undefined, MathAlgorithm.Add),
    ChallengeDuration: new Attribute(undefined, MathAlgorithm.Add),
    ShiftDistance: new Attribute(undefined, MathAlgorithm.Add),
    SpawnRatePct: new Attribute(undefined, MathAlgorithm.Add),
    VertRefreshSR: new Attribute(undefined, MathAlgorithm.Add),
    VertRefreshSSR: new Attribute(undefined, MathAlgorithm.Add),
    BottleMaxStack: new Attribute(undefined, MathAlgorithm.Add),
    BlockDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopDiscount: new Attribute(undefined, MathAlgorithm.Add),
    PerSecGameShopExp: new Attribute(undefined, MathAlgorithm.Add),
    BaseAtkDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowAoeDmg: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowAoeRadius: new Attribute(undefined, MathAlgorithm.Add),
    ShadowSecondaryArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    ShadowSecondaryArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopRefreshCostReduce: new Attribute(undefined, MathAlgorithm.Add),
    WeaponStatsPct: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowHitDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowBoomDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowAoeRadius: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    BlazingArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCleaveCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowProjectSpd: new Attribute(undefined, MathAlgorithm.Add),
    SmallIceArrowDmg: new Attribute(undefined, MathAlgorithm.Add),
    SkyThunderDmg: new Attribute(undefined, MathAlgorithm.Add),
    MagneticStormDmg: new Attribute(undefined, MathAlgorithm.Add),
    MagneticStormRadius: new Attribute(undefined, MathAlgorithm.Add),
    EMFieldDmg: new Attribute(undefined, MathAlgorithm.Add),
    BlitzballDmg: new Attribute(undefined, MathAlgorithm.Add),
    SwordDmg: new Attribute(undefined, MathAlgorithm.Add),
    SwordProjectSpd: new Attribute(undefined, MathAlgorithm.Add),
    SwordScale: new Attribute(undefined, MathAlgorithm.Add),
    SwordCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserRadius: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayCount: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaDmg: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaRadius: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaCount: new Attribute(undefined, MathAlgorithm.Add),
    FrostNovaCooldown: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowCooldown: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainDmg: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainCount: new Attribute(undefined, MathAlgorithm.Add),
    LonBlastingRadius: new Attribute(undefined, MathAlgorithm.Add),
    LonBlastingDmg: new Attribute(undefined, MathAlgorithm.Add),
    LightningChainCooldown: new Attribute(undefined, MathAlgorithm.Add),
    SkyThunderCooldown: new Attribute(undefined, MathAlgorithm.Add),
    EarthQuakeDmg: new Attribute(undefined, MathAlgorithm.Add),
    EarthQuakeRadius: new Attribute(undefined, MathAlgorithm.Add),
    EmbersDmg: new Attribute(undefined, MathAlgorithm.Add),
    TornadoDmg: new Attribute(undefined, MathAlgorithm.Add),
    TornadoKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    TornadoRadius: new Attribute(undefined, MathAlgorithm.Add),
    TornadoMoveSpd: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangDmg: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangRadius: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangCooldown: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteDmg: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteCooldown: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteRadius: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteCount: new Attribute(undefined, MathAlgorithm.Add),
    MeteoriteFragmentsCount: new Attribute(undefined, MathAlgorithm.Add),
    FireBallDmg: new Attribute(undefined, MathAlgorithm.Add),
    FireBallKeepTime: new Attribute(undefined, MathAlgorithm.Add),
    FireBallRadius: new Attribute(undefined, MathAlgorithm.Add),
    FireBallMoveSpd: new Attribute(undefined, MathAlgorithm.Add),
    FireBallCount: new Attribute(undefined, MathAlgorithm.Add),
    BurntFrostDmg: new Attribute(undefined, MathAlgorithm.Add),
    HurricaneDmg: new Attribute(undefined, MathAlgorithm.Add),
    SmallHurricaneCount: new Attribute(undefined, MathAlgorithm.Add),
    VacuumDmg: new Attribute(undefined, MathAlgorithm.Add),
    GameShopRefreshInterval: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilitySpellRadius: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilityCooldown: new Attribute(undefined, MathAlgorithm.Add),
    HolyReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    NatureReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    FrostReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    FireReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    ShadowReduceResistPct: new Attribute(undefined, MathAlgorithm.Add),
    MiningSpd: new Attribute(undefined, MathAlgorithm.Add),
    GameShopCostReduce: new Attribute(undefined, MathAlgorithm.Add),
    ShadowArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    IceArrowPenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    HurricanePenetrateCount: new Attribute(undefined, MathAlgorithm.Add),
    ThunderDmgFactor: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayCooldown: new Attribute(undefined, MathAlgorithm.Add),
    LightningBounceCount: new Attribute(undefined, MathAlgorithm.Add),
    EarthquakeCooldown: new Attribute(undefined, MathAlgorithm.Add),
    TornadoCooldown: new Attribute(undefined, MathAlgorithm.Add),
    HurricaneCooldown: new Attribute(undefined, MathAlgorithm.Add),
    FireballDuration: new Attribute(undefined, MathAlgorithm.Add),
    FireballCooldown: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneRayRange: new Attribute(undefined, MathAlgorithm.Add),
    FinalDamageCalculation: new Attribute(undefined, MathAlgorithm.Add),
    FinalDamageCalculation1: new Attribute(undefined, MathAlgorithm.Add),
    FinalHpRegen: new Attribute(undefined, MathAlgorithm.Add),
    DmgAmp: new Attribute(undefined, MathAlgorithm.Add),
    FinalAllDmg: new Attribute(undefined, MathAlgorithm.Add),
    FinalPhyDmg: new Attribute(undefined, MathAlgorithm.Add),
    FinalMagDmg: new Attribute(undefined, MathAlgorithm.Add),
    ArcaneLaserCount: new Attribute(undefined, MathAlgorithm.Add),
    DianCiWangFixRadius: new Attribute(undefined, MathAlgorithm.Add),
    HolyRairty: new Attribute(undefined, MathAlgorithm.Add),
    HolyAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    NatureAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    FrostAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    FireAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    PhysicalAbilityLevel: new Attribute(undefined, MathAlgorithm.Add),
    ShadowAbilityLevel: new Attribute(undefined, MathAlgorithm.Add)
  };
  function setname(t, sNameParent) {
    for (const k in t) {
      if (k != 'hParent' && t[k] instanceof Attribute) {
        if (sNameParent) {
          t[k].name = sNameParent + '.' + k;
        } else {
          t[k].name = k;
        }
        setname(t[k], t[k].name);
      }
    }
  }
  setname(AttributeCfg);
  {
    Entities['_GetHealth'] = (_a = Entities['_GetHealth']) !== null && _a !== void 0 ? _a : Entities.GetHealth;
    Entities.GetHealth = function (iEntID) {
      var _a, _b, _c;
      if ((_c = (_b = (_a = GameUI.CustomUIConfig()) === null || _a === void 0 ? void 0 : _a.tools) === null || _b === void 0 ? void 0 : _b.AttributeKind) === null || _c === void 0 ? void 0 : _c.HpLimit) {
        return Entities['_GetHealth'](iEntID) / Entities['_GetMaxHealth'](iEntID) * GameUI.CustomUIConfig().tools.AttributeKind.HpLimit.Get(iEntID);
      }
      return Entities['_GetHealth'](iEntID);
    };
    Entities['_GetMaxHealth'] = (_b = Entities['_GetMaxHealth']) !== null && _b !== void 0 ? _b : Entities.GetMaxHealth;
    Entities.GetMaxHealth = function (iEntID) {
      var _a, _b, _c;
      if ((_c = (_b = (_a = GameUI.CustomUIConfig()) === null || _a === void 0 ? void 0 : _a.tools) === null || _b === void 0 ? void 0 : _b.AttributeKind) === null || _c === void 0 ? void 0 : _c.HpLimit) {
        let f = GameUI.CustomUIConfig().tools.AttributeKind.HpLimit.Get(iEntID);
        if (typeof f == 'number') return f;
        return 0;
      }
      return Entities['_GetMaxHealth'](iEntID);
    };
    Entities['_GetHealthPercent'] = (_c = Entities['_GetHealthPercent']) !== null && _c !== void 0 ? _c : Entities.GetHealthPercent;
    Entities.GetHealthPercent = function (iEntID) {
      return Math.floor(Entities['_GetHealth'](iEntID) / Entities['_GetMaxHealth'](iEntID) * 100);
    };
  }

  function FindPolymerData(iEntID, sAbltName) {
    return GameUI.CustomUIConfig().tools.NetEventData.GetTableValue('diy_polymer', sAbltName + ' ' + iEntID);
  }
  function FindPolymer(iEntID, sAbltName) {
    if (FindPolymerData(iEntID, sAbltName) != undefined) {
      return new DiyPolymer(iEntID, sAbltName);
    }
  }
  function FindPolymerByID(iEntID, id) {
    var _a;
    const sUniqueName = (_a = GameUI.CustomUIConfig().tools.runlua(`
        local hUnit = EntIndexToHScript(${iEntID})
        if IsValid(hUnit) then
            local hPlm = hUnit:FindPolymerByID(${id})
            if hPlm then
                return hPlm.__sNameUnique
            end
        end
        `)) !== null && _a !== void 0 ? _a : '';
    if (sUniqueName) {
      return new DiyPolymer(iEntID, sUniqueName);
    }
  }
  function FindAllPolymerName(iEntID) {
    const t = GameUI.CustomUIConfig().tools.NetEventData.GetTableValue('polymer', String(iEntID));
    if (t) return Object.keys(t);
    return [];
  }
  class DiyPolymer {
    constructor(iEntID, sName) {
      this.__sNameUnique = sName;
      let _ = sName.split(' ');
      if (_.length == 1) {
        this.__sName = sName;
      } else {
        this.__sName = _[0];
        this.__iMultipleID = Number(_[1]);
      }
      this.__iParentEntID = iEntID;
      const tData = this.__data();
      this.__iPolymerID = tData.id;
    }
    GetName() {
      return this.__sName;
    }
    GetPolymerID() {
      return this.__iPolymerID;
    }
    GetCustomTransmitterData() {
      return this.__data().data;
    }
    GetCustomAttributes() {
      var _a;
      return (_a = GameUI.CustomUIConfig().tools.runlua(`
        local tAttributes = {}
        local hUnit = EntIndexToHScript(${this.__iParentEntID})
        if IsValid(hUnit) then
            local hPlm = hUnit:FindPolymerByID(${this.__iPolymerID})
            if hPlm then
                for typeFun, v in pairs(hPlm:DDeclareFunctions()) do
                    if type(typeFun) == "table" then
                        local hAttribute = typeFun
                        tAttributes[hAttribute.name] = hAttribute:GetByKey(hUnit, hPlm)
                    end
                end
            end
        end
        return tAttributes
        `)) !== null && _a !== void 0 ? _a : {};
    }
    IsHidden() {
      return this.__call('IsHidden');
    }
    IsDebuff() {
      return this.__call('IsDebuff');
    }
    IsStunDebuff() {
      return this.__call('IsStunDebuff');
    }
    IsPurgable() {
      return this.__call('IsPurgable');
    }
    IsPurgeException() {
      return this.__call('IsPurgeException');
    }
    IsPermanent() {
      return this.__call('IsPermanent');
    }
    IsAura() {
      return this.__call('IsAura');
    }
    IsAuraActiveOnDeath() {
      return this.__call('IsAuraActiveOnDeath');
    }
    AllowIllusionDuplicate() {
      return this.__call('AllowIllusionDuplicate');
    }
    GetTexture() {
      return this.__call('GetTexture');
    }
    GetPriority() {
      return this.__call('GetPriority');
    }
    GetAttributes() {
      return this.__call('GetAttributes');
    }
    GetDuration() {
      return this.__call('GetDuration');
    }
    GetCreationTime() {
      return this.__call('GetCreationTime');
    }
    GetElapsedTime() {
      return this.__call('GetElapsedTime');
    }
    GetRemainingTime() {
      return this.__call('GetRemainingTime');
    }
    GetDieTime() {
      return this.__call('GetDieTime');
    }
    GetStackCount() {
      return this.__call('GetStackCount');
    }
    __call(sFunc, ...args) {
      let sParams = args.map(v => {
        if (typeof v == 'boolean') {
          return v;
        } else if (typeof v == 'string') {
          return "'" + v + "'";
        } else if (typeof v == 'number') {
          if (Number.isNaN(v)) {
            return '0/0';
          }
          return v;
        }
        return 'nil';
      }).join(',');
      return GameUI.CustomUIConfig().tools.runlua(`
        local hUnit = EntIndexToHScript(${this.__iParentEntID})
        if IsValid(hUnit) then
            local hPlm = hUnit:FindPolymerByID(${this.__iPolymerID})
            if hPlm then
                return hPlm:${sFunc}(${sParams})
            end
        end
        `);
    }
    __data() {
      return GameUI.CustomUIConfig().tools.NetEventData.GetTableValue('diy_polymer', this.__sNameUnique + ' ' + this.__iParentEntID);
    }
  }

  function ShowDragTip(sMsg, sType = 'normal') {
    const pDrag = GameUI.CustomUIConfig()['DragRoot'];
    if (pDrag) {
      pDrag.AddClass('HasTip');
      pDrag.SwitchClass('TipType', '');
      pDrag.SwitchClass('TipType', 'TipType_' + sType);
      const s = SpanText(sMsg[0] == '#' ? $.Localize(sMsg) : sMsg, sType);
      pDrag.SetDialogVariable('drag_tip', s);
    }
  }
  function HideDragTip() {
    const pDrag = GameUI.CustomUIConfig()['DragRoot'];
    if (pDrag) {
      pDrag.RemoveClass('HasTip');
    }
  }

  function RegDraggle(pDragSource, type, params, element, callback = {}) {
    const getType = () => type;
    const getParams = () => params;
    $.RegisterEventHandler('DragStart', pDragSource, (pDragSource, tCallback) => {
      const params = getParams();
      if (callback.onDragStart == undefined || callback.onDragStart(pDragSource, params)) {
        let pDragPanel = GameUI.CustomUIConfig()['DragRoot'];
        if (!(pDragPanel === null || pDragPanel === void 0 ? void 0 : pDragPanel.IsValid())) {
          pDragPanel = GameUI.CustomUIConfig()['DragRoot'] = $.CreatePanel("Panel", $.GetContextPanel(), 'DragRoot');
          pDragPanel.hittest = false;
        }
        tCallback.displayPanel = pDragPanel;
        tCallback.offsetX = 500 * (Game.GetScreenHeight() / 1080);
        tCallback.offsetY = 500 * (Game.GetScreenHeight() / 1080);
        tCallback.displayPanel['drag_type'] = getType();
        tCallback.displayPanel['params'] = params;
        {
          const onDragEnter = (func, pDragPanel, tDragInfo, tDropInfo, pDropPanel) => {
            let sToken = `#DragTip_${tDragInfo.type}__Drop__${tDropInfo.type}`;
            let sText = $.Localize(sToken);
            if (sToken != sText) {
              ShowDragTip(sText);
            }
            func === null || func === void 0 ? void 0 : func(pDragPanel, tDragInfo, tDropInfo, pDropPanel);
          };
          const onDragLeave = (func, pDragPanel, tDragInfo, tDropInfo, pDropPanel) => {
            HideDragTip();
            func === null || func === void 0 ? void 0 : func(pDragPanel, tDragInfo, tDropInfo, pDropPanel);
          };
          let tEnteredPanel = [];
          tCallback.displayPanel['callback'] = Object.assign(Object.assign({}, callback), {
            'onDragEnter': (pDragPanel, tDragInfo, tDropInfo, pDropPanel) => {
              if (tEnteredPanel.find(p => p == pDropPanel) != undefined) {
                return;
              }
              tEnteredPanel.push(pDropPanel);
              try {
                return onDragEnter(callback.onDragEnter, pDragPanel, tDragInfo, tDropInfo, pDropPanel);
              } catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
              }
            },
            'onDragLeave': (pDragPanel, tDragInfo, tDropInfo, pDropPanel) => {
              const i = tEnteredPanel.findIndex(p => p == pDropPanel);
              if (i == -1) {
                try {
                  onDragEnter(callback.onDragEnter, pDragPanel, tDragInfo, tDropInfo, pDropPanel);
                } catch (error) {
                  GameUI.CustomUIConfig().UploadError(error);
                }
                try {
                  onDragEnter(pDropPanel['draggle/drop/callback'].onDragEnter, pDragPanel, tDragInfo, tDropInfo, pDropPanel);
                } catch (error) {
                  GameUI.CustomUIConfig().UploadError(error);
                }
              } else {
                tEnteredPanel.splice(i, 1);
              }
              for (let i = tEnteredPanel.length - 1; i >= 0; --i) {
                const pDropPanel = tEnteredPanel[i];
                if (!pDropPanel.BHasHoverStyle()) {
                  try {
                    onDragLeave(callback.onDragLeave, pDragPanel, tDragInfo, pDropPanel['draggle/drop/params'](), pDropPanel);
                  } catch (error) {
                    GameUI.CustomUIConfig().UploadError(error);
                  }
                  try {
                    onDragLeave(pDropPanel['draggle/drop/callback'].onDragLeave, pDragPanel, tDragInfo, pDropPanel['draggle/drop/params'](), pDropPanel);
                  } catch (error) {
                    GameUI.CustomUIConfig().UploadError(error);
                  }
                  tEnteredPanel.splice(i, 1);
                }
              }
              try {
                return onDragLeave(callback.onDragLeave, pDragPanel, tDragInfo, tDropInfo, pDropPanel);
              } catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
              }
            },
            'onDragEnd': (pDragPanel, params) => {
              var _a;
              for (const pDropPanel of tEnteredPanel) {
                try {
                  onDragLeave(callback.onDragLeave, pDragPanel, {
                    'type': getType(),
                    params
                  }, pDropPanel['draggle/drop/params'](), pDropPanel);
                } catch (error) {
                  GameUI.CustomUIConfig().UploadError(error);
                }
                try {
                  onDragLeave(pDropPanel['draggle/drop/callback'].onDragLeave, pDragPanel, {
                    'type': getType(),
                    params
                  }, pDropPanel['draggle/drop/params'](), pDropPanel);
                } catch (error) {
                  GameUI.CustomUIConfig().UploadError(error);
                }
              }
              tEnteredPanel = [];
              try {
                return (_a = callback.onDragEnd) === null || _a === void 0 ? void 0 : _a.call(callback, pDragPanel, params);
              } catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
              }
            }
          });
        }
        render(() => (() => {
          const _el$ = createElement("Panel", {
              "class": "Body"
            }, null);
            createElement("Label", {
              id: "DragTip",
              text: '{s:drag_tip}',
              html: true
            }, _el$);
            const _el$3 = createElement("Panel", {
              "class": "Content"
            }, _el$);
          insert(_el$3, element);
          return _el$;
        })(), tCallback.displayPanel);
        HideTooltip();
        GameUI.CustomUIConfig().tools.WindowManager.pFloor.visible = true;
        GameUI.CustomUIConfig().tools.EventManager.Fire('ON_DRAG_START', {
          'pDragPanel': tCallback.displayPanel,
          'info': {
            'type': getType(),
            'params': params
          }
        });
        Timer(() => {
          if (pDragSource.IsValid()) return 0;
          onDragEnd(pDragSource, pDragPanel);
        }, 0, 'DragCheck');
      }
    });
    const onDragEnd = (pDrag, pDragPanel) => {
      GameUI.CustomUIConfig().tools.EventManager.Fire('ON_DRAG_END', {
        'pDragPanel': pDragPanel,
        'info': {
          'type': pDragPanel['drag_type'],
          'params': pDragPanel['params']
        }
      });
      GameUI.CustomUIConfig().tools.WindowManager.pFloor.visible = false;
      if (pDragPanel['callback'].onDragEnd) {
        pDragPanel['callback'].onDragEnd(pDrag, pDragPanel['params']);
      }
      render(() => undefined, pDragPanel);
      pDragPanel.DeleteAsync(-1);
      delete GameUI.CustomUIConfig()['DragRoot'];
      StopTimer('DragCheck');
    };
    $.RegisterEventHandler("DragEnd", pDragSource, onDragEnd);
  }

  const [getCutoffLineCount, setCutoffLineCount] = createCache('UIHelper_CutoffLineCount', [0, 0]);
  const [isShowVernier, setShowVernier] = createCache('UIHelper_ShowVernier', false);
  function UIHelperBox() {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "UIHelperBox"
        }, null),
        _el$2 = createElement("Label", {
          text: "UI编辑"
        }, _el$),
        _el$3 = createElement("Panel", {}, _el$),
        _el$4 = createElement("Panel", {}, _el$3),
        _el$5 = createElement("ToggleButton", {
          get selected() {
            return isShowVernier();
          }
        }, _el$4);
        createElement("Label", {
          text: "游标尺"
        }, _el$5);
        const _el$7 = createElement("Panel", {}, _el$3),
        _el$8 = createElement("Button", {
          hittest: false
        }, _el$7),
        _el$9 = createElement("TextEntry", {
          multiline: false,
          maxchars: 3,
          textmode: "numeric",
          placeholder: '列',
          get text() {
            return getCutoffLineCount()[0].toString();
          }
        }, _el$8),
        _el$0 = createElement("TextEntry", {
          multiline: false,
          maxchars: 3,
          textmode: "numeric",
          placeholder: '行',
          get text() {
            return getCutoffLineCount()[1].toString();
          }
        }, _el$8);
        createElement("Label", {
          text: "分割线"
        }, _el$8);
      setProp(_el$, "className", "Category");
      setProp(_el$2, "className", "CategoryHeader");
      setProp(_el$2, "onactivate", p => {
        var _a;
        (_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.ToggleClass('Spread');
      });
      setProp(_el$3, "className", "CategoryButtonContainer");
      setProp(_el$4, "className", "Row");
      setProp(_el$5, "className", "CategoryButton");
      setProp(_el$5, "onactivate", p => {
        setShowVernier(p.IsSelected());
      });
      setProp(_el$7, "className", "Row");
      setProp(_el$8, "className", "CategoryButton TextEntryButton");
      setProp(_el$9, "ontextentrychange", p => {
        setCutoffLineCount([Number(p.text) || 0, getCutoffLineCount()[1]]);
      });
      setProp(_el$0, "ontextentrychange", p => {
        setCutoffLineCount([getCutoffLineCount()[0], Number(p.text) || 0]);
      });
      effect(_p$ => {
        const _v$ = isShowVernier(),
          _v$2 = getCutoffLineCount()[0].toString(),
          _v$3 = getCutoffLineCount()[1].toString();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$5, "selected", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$9, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$0, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }
  function UIHelperPanel() {
    function setVernier(p, vPos = GameUI.GetCursorPosition()) {
      const pParent = p.GetParent();
      const pRoot = pParent.GetParent();
      const pXLine = pRoot.GetChild(0);
      const pYLine = pRoot.GetChild(1);
      vPos[0] = Clamp(vPos[0], 0, Game.GetScreenWidth());
      vPos[1] = Clamp(vPos[1], 0, Game.GetScreenHeight());
      pXLine.style.transform = `translate3d(${vPos[0] / (Game.GetScreenHeight() / 1080)}px,0px,0px)`;
      pYLine.style.transform = `translate3d(0px,${vPos[1] / (Game.GetScreenHeight() / 1080)}px,0px)`;
      pParent.style.transform = `translate3d(${vPos[0] / (Game.GetScreenHeight() / 1080)}px,${vPos[1] / (Game.GetScreenHeight() / 1080)}px,0px)`;
      pParent.GetChild(1).text = vPos[1].toString();
      pParent.GetChild(2).text = (Game.GetScreenWidth() - vPos[0]).toString();
      pParent.GetChild(3).text = (Game.GetScreenHeight() - vPos[1]).toString();
      pParent.GetChild(4).text = vPos[0].toString();
    }
    const [getVernierPos, setVernierPos] = createCache('UIHelper_VernierPos', [Game.GetScreenWidth() * .5, Game.GetScreenHeight() * .5]);
    return (() => {
      const _el$10 = createElement("Panel", {
        id: "UIHelperPanel",
        hittest: false
      }, null);
      insert(_el$10, createComponent(Show, {
        get when() {
          return memo(() => getCutoffLineCount()[0] > 0)() && getCutoffLineCount()[1] > 0;
        },
        get children() {
          const _el$11 = createElement("Panel", {
              id: "CutoffLinePanel",
              hittest: false
            }, null),
            _el$12 = createElement("Panel", {
              "class": "XLineBox",
              hittest: false
            }, _el$11),
            _el$13 = createElement("Panel", {
              "class": "YLineBox",
              hittest: false
            }, _el$11);
          insert(_el$12, createComponent(For, {
            get each() {
              return Array(getCutoffLineCount()[0]).fill(null);
            },
            children: () => createElement("Panel", {
              hittest: false
            }, null)
          }));
          insert(_el$13, createComponent(For, {
            get each() {
              return Array(getCutoffLineCount()[1]).fill(null);
            },
            children: () => createElement("Panel", {
              hittest: false
            }, null)
          }));
          return _el$11;
        }
      }), null);
      insert(_el$10, createComponent(Show, {
        get when() {
          return isShowVernier();
        },
        get children() {
          const _el$14 = createElement("Panel", {
              id: "VernierPanel",
              hittest: false
            }, null);
            createElement("Panel", {
              "class": "XLien",
              hittest: false
            }, _el$14);
            createElement("Panel", {
              "class": "YLien",
              hittest: false
            }, _el$14);
            const _el$17 = createElement("Panel", {
              id: "ControlPanel",
              hittest: false
            }, _el$14),
            _el$18 = createElement("Button", {
              draggable: true
            }, _el$17);
            createElement("Label", {
              "class": "TopLabel",
              hittest: false
            }, _el$17);
            createElement("Label", {
              "class": "RightLabel",
              hittest: false
            }, _el$17);
            createElement("Label", {
              "class": "BottomLabel",
              hittest: false
            }, _el$17);
            createElement("Label", {
              "class": "LeftLabel",
              hittest: false
            }, _el$17);
          setProp(_el$18, "onload", p => {
            setVernier(p, getVernierPos());
            RegDraggle(p, undefined, undefined, () => [], {
              onDragStart: p => {
                Timer(() => {
                  if (!GameUI.IsMouseDown(0)) return;
                  if (!p.IsValid()) return;
                  setVernierPos(GameUI.GetCursorPosition());
                  setVernier(p);
                  return 0;
                }, -1, 'UIHelperVernier');
                return true;
              },
              onDragEnd: () => {
                StopTimer('UIHelperVernier');
              }
            });
          });
          return _el$14;
        }
      }), null);
      return _el$10;
    })();
  }
  render(() => createComponent(UIHelperPanel, {}), $('#UIHelperRoot'));

  const WindowCaches = {};
  function Window(props) {
    const [_, other_props] = splitProps(props, ['name', 'onclose']);
    let ref;
    let refBody;
    function pullBox(params) {
      var _a, _b, _c, _d, _e, _f;
      if (ref) {
        ref.style.width = Math.max(100, Number(String((_a = ref.style.width) !== null && _a !== void 0 ? _a : ref.desiredlayoutwidth + 'px').split(/(px|%)/)[0]) + params.x) + 'px';
        ref.style.height = Math.max(100, Number(String((_b = ref.style.height) !== null && _b !== void 0 ? _b : ref.desiredlayoutheight + 'px').split(/(px|%)/)[0]) + params.y) + 'px';
        if (params.pos_move) {
          ref.style.position = parseInt(((_c = ref.style.position) !== null && _c !== void 0 ? _c : '0px 0px 0px').split('px ')[0]) + ((_d = params.pos_x) !== null && _d !== void 0 ? _d : params.x) + 'px ' + (parseInt(((_e = ref.style.position) !== null && _e !== void 0 ? _e : '0px 0px 0px').split('px ')[1]) + ((_f = params.pos_y) !== null && _f !== void 0 ? _f : params.y)) + 'px 0px';
        }
      }
    }
    return (() => {
      const _el$ = createElement("Panel", mergeProps(other_props, {
          hittest: true,
          get id() {
            return 'Window_' + props.name;
          },
          get ["class"]() {
            return classNames('Window', props.class);
          }
        }), null),
        _el$2 = createElement("Panel", {
          hittest: true,
          draggable: true
        }, _el$),
        _el$3 = createElement("Label", {
          id: "WindowTitle",
          get text() {
            return props.name;
          }
        }, _el$2),
        _el$4 = createElement("Button", {
          id: "WindowCloseBtn"
        }, _el$2),
        _el$5 = createElement("Panel", {}, _el$);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') props.ref(p);
      }, _el$);
      spread(_el$, mergeProps(other_props, {
        "hittest": true,
        get id() {
          return 'Window_' + props.name;
        },
        get ["class"]() {
          return classNames('Window', props.class);
        },
        "onload": p => {
          var _a, _b;
          (_a = props.onload) === null || _a === void 0 ? void 0 : _a.call(props, p);
          const {
            weight,
            height,
            pos
          } = (_b = WindowCaches[props.name]) !== null && _b !== void 0 ? _b : {};
          if (weight) p.style.width = weight;
          if (height) p.style.height = height;
          if (pos) p.style.position = pos;
        },
        "onactivate": p => {
          var _a;
          (_a = props.onactivate) === null || _a === void 0 ? void 0 : _a.call(props, p);
          SetWindowTop(ref.GetParent());
        }
      }), true);
      setProp(_el$2, "className", "Header");
      setProp(_el$2, "onload", p => {
        $.RegisterEventHandler('DragStart', p, () => {
          let pView = ref;
          let vPos = GameUI.GetCursorPosition();
          if (pView['_FullScreen']) {
            pView.style.width = pView['_FullScreen'].width;
            pView.style.height = pView['_FullScreen'].height;
            let width = Number(String(pView['_FullScreen'].width).split('px')[0]) || 0;
            pView.style.position = `${vPos[0] - width / 2}px ${vPos[1]}px 0px`;
            delete pView['_FullScreen'];
            pView.ToggleClass('FullScreen');
          }
          Timer(() => {
            var _a, _b;
            let vPos2 = GameUI.GetCursorPosition();
            pView.style.position = parseInt(((_a = pView.style.position) !== null && _a !== void 0 ? _a : '0px 0px 0px').split('px ')[0]) + vPos2[0] - vPos[0] + 'px ' + (parseInt(((_b = pView.style.position) !== null && _b !== void 0 ? _b : '0px 0px 0px').split('px ')[1]) + vPos2[1] - vPos[1]) + 'px 0px';
            vPos = vPos2;
            if (GameUI.IsMouseDown(0)) return 0;
            $.DispatchEvent('DropInputFocus', p);
          }, 0, 'WindowMove');
        });
        $.RegisterEventHandler("DragEnd", p, () => {
          StopTimer('WindowMove');
        });
      });
      setProp(_el$2, "onactivate", p => {
        var _a;
        SetWindowTop(ref.GetParent());
        let fTime = new Date().getTime() / 1000;
        if (fTime - ((_a = p['DoubleClick']) !== null && _a !== void 0 ? _a : 0) < 0.2) {
          let pView = ref;
          pView.ToggleClass('FullScreen');
          if (pView['_FullScreen']) {
            pView.style.position = pView['_FullScreen'].position;
            pView.style.width = pView['_FullScreen'].width;
            pView.style.height = pView['_FullScreen'].height;
            delete pView['_FullScreen'];
          } else {
            pView['_FullScreen'] = {
              position: pView.style.position,
              width: pView.style.width || pView.actuallayoutwidth + 'px',
              height: pView.style.height || pView.actuallayoutheight + 'px'
            };
            pView.style.position = '0px 0px 0px';
            pView.style.width = '100%';
            pView.style.height = '100%';
          }
        }
        p['DoubleClick'] = fTime;
      });
      setProp(_el$4, "onactivate", () => {
        var _a;
        (_a = props.onclose) === null || _a === void 0 ? void 0 : _a.call(props);
        DeleteWindow(props.name);
      });
      const _ref$ = refBody;
      typeof _ref$ === "function" ? use(_ref$, _el$5) : refBody = _el$5;
      setProp(_el$5, "className", "Body");
      insert(_el$5, () => children(() => props.children));
      insert(_el$, () => [['RightSide', (x, y) => pullBox({
        x,
        y
      })], ['BottomSide', (x, y) => pullBox({
        x: 0,
        y
      })], ['LeftSide', (x, y) => pullBox({
        x: -x,
        y: y,
        pos_move: true,
        pos_x: x,
        pos_y: 0
      })]].map(t => {
        return (() => {
          const _el$6 = createElement("Panel", {
            get id() {
              return t[0];
            },
            draggable: true
          }, null);
          setProp(_el$6, "className", "BoxSide");
          setProp(_el$6, "onload", p => {
            $.RegisterEventHandler('DragStart', p, () => {
              let vPos = GameUI.GetCursorPosition();
              Timer(() => {
                let vPos2 = GameUI.GetCursorPosition();
                t[1](vPos2[0] - vPos[0], vPos2[1] - vPos[1]);
                vPos = vPos2;
                if (GameUI.IsMouseDown(0)) return 0;
              }, 0, 'WindowPull');
              return false;
            });
            $.RegisterEventHandler("DragEnd", p, () => {
              StopTimer('WindowPull');
            });
          });
          effect(_$p => setProp(_el$6, "id", t[0], _$p));
          return _el$6;
        })();
      }), null);
      effect(_$p => setProp(_el$3, "text", props.name, _$p));
      return _el$;
    })();
  }
  function CreateWindow(params) {
    let pRoot = $('#WindowRoot');
    if (pRoot == undefined) {
      pRoot = $.CreatePanel("Panel", $.GetContextPanel(), 'WindowRoot');
      pRoot.hittest = false;
    }
    let p = pRoot.FindChild('WindowBox_' + params.name);
    if (p == undefined) {
      p = $.CreatePanel("Panel", pRoot, 'WindowBox_' + params.name);
      p.AddClass('WindowBox');
      p.hittest = false;
    }
    render(() => createComponent(Window, {
      get name() {
        return params.name;
      },
      get ["class"]() {
        return params.class;
      },
      get onclose() {
        return params.onclose;
      },
      get children() {
        return params.content;
      }
    }), p);
    return p.GetChild(0);
  }
  function DeleteWindow(name) {
    var _a;
    const p = $('#Window_' + name);
    if (p) {
      WindowCaches[name] = (_a = WindowCaches[name]) !== null && _a !== void 0 ? _a : {};
      if (p.style.width) WindowCaches[name].weight = p.style.width;
      if (p.style.height) WindowCaches[name].height = p.style.height;
      if (p.style.position) WindowCaches[name].pos = p.style.position;
      const pBox = p.GetParent();
      render(() => [], pBox);
      pBox.DeleteAsync(-1);
    }
  }
  function SetWindowTop(p) {
    let pLast = SetWindowTop['last'];
    if (pLast != undefined && pLast.IsValid()) {
      pLast.style.zIndex = 0;
    }
    SetWindowTop['last'] = p;
    p.style.zIndex = 100;
  }
  function FindWindow(name) {
    return $('#Window_' + name);
  }

  function DebugPerformanceBox() {
    const [isEnableNetFlow] = useNetTable(t => Object.keys(t !== null && t !== void 0 ? t : {}).length > 0, 'debug', 'net_flow');
    const [isEnableNetTable] = useNetTable(t => Object.keys(t !== null && t !== void 0 ? t : {}).length > 0, 'debug', 'nettable');
    return (() => {
      const _el$ = createElement("Panel", {
          id: "UIHelperBox"
        }, null),
        _el$2 = createElement("Label", {
          text: "性能监测"
        }, _el$),
        _el$3 = createElement("Panel", {}, _el$),
        _el$4 = createElement("Panel", {}, _el$3),
        _el$5 = createElement("ToggleButton", {}, _el$4);
        createElement("Label", {
          text: "特效屏蔽"
        }, _el$5);
        const _el$7 = createElement("Panel", {}, _el$3),
        _el$8 = createElement("Button", {}, _el$7);
        createElement("Label", {
          text: "流量面板"
        }, _el$8);
        const _el$0 = createElement("Panel", {}, _el$3),
        _el$1 = createElement("Button", {}, _el$0);
        createElement("Label", {
          text: "网表面板"
        }, _el$1);
        const _el$11 = createElement("Panel", {}, _el$3),
        _el$12 = createElement("Button", {}, _el$11);
        createElement("Label", {
          text: "计时器面板"
        }, _el$12);
        const _el$14 = createElement("Panel", {}, _el$3),
        _el$15 = createElement("Button", {}, _el$14);
        createElement("Label", {
          text: "Code面板"
        }, _el$15);
      setProp(_el$, "className", "Category Spread");
      setProp(_el$2, "className", "CategoryHeader");
      setProp(_el$2, "onactivate", p => {
        var _a;
        (_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.ToggleClass('Spread');
      });
      setProp(_el$3, "className", "CategoryButtonContainer");
      setProp(_el$4, "className", "Row");
      setProp(_el$5, "className", "CategoryButton");
      setProp(_el$5, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-ptcl_dis ${p.IsSelected() ? 1 : 0}`
        });
      });
      setProp(_el$7, "className", "Row");
      setProp(_el$8, "className", "CategoryButton");
      setProp(_el$8, "onactivate", () => {
        if (FindWindow('NetFlow') != undefined) {
          DeleteWindow('NetFlow');
        } else {
          CreateWindow({
            'name': 'NetFlow',
            'content': () => createComponent(NetFlowPanel, {})
          });
        }
        if (!untrack(isEnableNetFlow)) {
          GameEvents.SendCustomGameEventToServer('debug_cmd', {
            cmd: `-net_flow`
          });
        }
      });
      setProp(_el$0, "className", "Row");
      setProp(_el$1, "className", "CategoryButton");
      setProp(_el$1, "onactivate", () => {
        if (FindWindow('NetTable') != undefined) {
          DeleteWindow('NetTable');
        } else {
          CreateWindow({
            'name': 'NetTable',
            'content': () => createComponent(NetTablePanel, {})
          });
        }
        if (!untrack(isEnableNetTable)) {
          GameEvents.SendCustomGameEventToServer('debug_cmd', {
            cmd: `-net_table`
          });
        }
      });
      setProp(_el$11, "className", "Row");
      setProp(_el$12, "className", "CategoryButton");
      setProp(_el$12, "onactivate", () => {
        if (FindWindow('Timer') != undefined) {
          DeleteWindow('Timer');
        } else {
          CreateWindow({
            'name': 'Timer',
            'content': () => createComponent(TimerPanel, {})
          });
        }
      });
      setProp(_el$14, "className", "Row");
      setProp(_el$15, "className", "CategoryButton");
      setProp(_el$15, "onactivate", p => {
        var _a;
        const index = p['index'] = ((_a = p['index']) !== null && _a !== void 0 ? _a : 0) + 1;
        CreateWindow({
          'name': 'DebugCode' + index,
          'class': 'DebugCodeRoot',
          'content': () => createComponent(DebugCodePanel, {})
        });
      });
      return _el$;
    })();
  }
  function NetFlowPanel() {
    function Sort_Total(a, b) {
      return a.total - b.total;
    }
    function Sort_Total2(a, b) {
      return b.total - a.total;
    }
    function Sort_Time5(a, b) {
      return a.time_5 - b.time_5;
    }
    function Sort_Time5_2(a, b) {
      return b.time_5 - a.time_5;
    }
    const [getFilter, setFilter] = createSignal(Sort_Total2);
    const [getFlow] = useNetTable(t => {
      const tList = [];
      for (const event in t) {
        tList.push(Object.assign({
          event
        }, t[event]));
      }
      const funcFilter = getFilter();
      tList.sort((a, b) => funcFilter(a, b));
      return tList;
    }, 'debug', 'net_flow');
    return (() => {
      const _el$17 = createElement("Panel", {
          "class": "NetFlowPanel"
        }, null),
        _el$18 = createElement("Panel", {
          "class": "Header"
        }, _el$17);
        createElement("Label", {
          "class": "EventCol",
          text: '事件'
        }, _el$18);
        const _el$20 = createElement("Label", {
          "class": "Time5Col",
          text: '5秒吞吐量'
        }, _el$18),
        _el$21 = createElement("Label", {
          "class": "TotalCol",
          text: '总流量'
        }, _el$18),
        _el$22 = createElement("Panel", {
          "class": "Body"
        }, _el$17);
      setProp(_el$20, "onactivate", () => {
        if (getFilter() == Sort_Time5_2) setFilter(() => Sort_Time5);else setFilter(() => Sort_Time5_2);
      });
      setProp(_el$21, "onactivate", () => {
        if (getFilter() == Sort_Total2) setFilter(() => Sort_Total);else setFilter(() => Sort_Total2);
      });
      insert(_el$22, createComponent(Index, {
        get each() {
          return getFlow();
        },
        children: tData => {
          const [getFlow, setFlow] = createSignal();
          return (() => {
            const _el$23 = createElement("Panel", {
                "class": "NetFlowRow"
              }, null),
              _el$24 = createElement("Panel", {
                "class": "Header"
              }, _el$23),
              _el$25 = createElement("Panel", {
                "class": "EventCol"
              }, _el$24);
              createElement("Panel", {
                id: "EventDetailBtn"
              }, _el$25);
              const _el$27 = createElement("Label", {
                get text() {
                  return tData().event;
                }
              }, _el$25),
              _el$28 = createElement("Label", {
                "class": "Time5Col",
                get text() {
                  return tData().time_5;
                }
              }, _el$24),
              _el$29 = createElement("Label", {
                "class": "TotalCol",
                get text() {
                  return tData().total;
                }
              }, _el$24);
            setProp(_el$25, "onactivate", () => {
              if (getFlow() != undefined) {
                setFlow();
              } else {
                Request('debug_net_flow_row_info', {
                  'event': tData().event
                }).then(res => {
                  var _a;
                  setFlow((_a = res === null || res === void 0 ? void 0 : res.data) !== null && _a !== void 0 ? _a : []);
                });
              }
            });
            insert(_el$23, createComponent(Show, {
              get when() {
                return getFlow();
              },
              get children() {
                const _el$30 = createElement("Panel", {
                  id: "NetFlowDataBox"
                }, null);
                insert(_el$30, createComponent(For, {
                  get each() {
                    return getFlow().sort((a, b) => b.time - a.time);
                  },
                  children: tData => {
                    return (() => {
                      const _el$31 = createElement("Panel", {
                          "class": "NetFlowDataRow"
                        }, null),
                        _el$32 = createElement("Label", {
                          id: "TimeLabel",
                          get text() {
                            return `${tData.time.toFixed(2)}`;
                          }
                        }, _el$31),
                        _el$33 = createElement("Label", {
                          id: "DataText",
                          get text() {
                            return tData.data;
                          }
                        }, _el$31);
                      setProp(_el$33, "onactivate", () => {
                        $.DispatchEvent('CopyStringToClipboard', tData.data, "1");
                        ErrorMsg('CopySuccess');
                      });
                      effect(_p$ => {
                        const _v$4 = `${tData.time.toFixed(2)}`,
                          _v$5 = tData.data;
                        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$32, "text", _v$4, _p$._v$4));
                        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$33, "text", _v$5, _p$._v$5));
                        return _p$;
                      }, {
                        _v$4: undefined,
                        _v$5: undefined
                      });
                      return _el$31;
                    })();
                  }
                }));
                return _el$30;
              }
            }), null);
            effect(_p$ => {
              const _v$ = tData().event,
                _v$2 = tData().time_5,
                _v$3 = tData().total;
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$27, "text", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$28, "text", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$29, "text", _v$3, _p$._v$3));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined
            });
            return _el$23;
          })();
        }
      }));
      return _el$17;
    })();
  }
  function NetTablePanel() {
    const [getNetEventTable] = useNetTable(t => t !== null && t !== void 0 ? t : {}, 'debug', 'nettable');
    const [getNetTable, setNetTable] = createSignal({});
    createEffect(() => {
      const tInfo = {};
      function callback(table, key, val) {
        var _a, _b;
        tInfo[table] = (_a = tInfo[table]) !== null && _a !== void 0 ? _a : {};
        const tData = tInfo[table][key] = (_b = tInfo[table][key]) !== null && _b !== void 0 ? _b : {
          'len': undefined,
          'max': 0,
          'increase': []
        };
        const len = val != undefined ? JSON.stringify(val).length : 0;
        if (tData.len != undefined) {
          tData.increase.push(len - tData.len);
          if (tData.increase.length > 10) tData.increase.splice(0, 1);
        }
        tData.len = len;
        tData.max = Math.max(tData.len, tData.max);
        setNetTable(Object.assign({}, tInfo));
      }
      function update() {
        batch(() => {
          for (const table of ['0', 'attribute', 'client_load', 'debug', 'particle_id', 'service']) {
            CustomNetTables.GetAllTableValues(table).forEach(v => {
              callback(table, v.key, v.value);
            });
          }
        });
      }
      const id = Timer(() => {
        update();
        return 1;
      }, -1, undefined, 'NetTablePanel');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    const getTableInfo = createMemo(tLastInfo => {
      var _a;
      const tInfo = [];
      for (const {
        type,
        tTable
      } of [{
        type: 'ET',
        tTable: getNetEventTable()
      }, {
        type: 'NT',
        tTable: getNetTable()
      }]) {
        for (const table in tTable) {
          const t = {
            'type': type,
            'table': table,
            'data': [],
            'len': 0,
            'max': 0,
            'increase': 0
          };
          for (const name in tTable[table]) {
            t.len += tTable[table][name].len;
            t.max += tTable[table][name].max;
            const tIncreaseArr = Object.values(tTable[table][name].increase);
            const increase = tIncreaseArr.reduce((s, i) => i + s, 0) / tIncreaseArr.length;
            t.increase += increase;
            t.data.push({
              'name': name,
              'key': (_a = tTable[table][name].key) !== null && _a !== void 0 ? _a : name,
              'len': tTable[table][name].len,
              'max': tTable[table][name].max,
              'increase': increase
            });
          }
          t.data.sort((a, b) => b.max - a.max);
          tInfo.push(t);
        }
      }
      return tInfo.sort((a, b) => b.max - a.max);
    });
    return (() => {
      const _el$34 = createElement("Panel", {
          "class": "NetTablePanel"
        }, null),
        _el$35 = createElement("Panel", {
          "class": "Header"
        }, _el$34);
        createElement("Label", {
          "class": "TableNameCol",
          text: '表名'
        }, _el$35);
        createElement("Label", {
          "class": "DataIncreaseCol",
          text: '增量'
        }, _el$35);
        createElement("Label", {
          "class": "DataLenCol",
          text: '数据字符长度'
        }, _el$35);
        createElement("Label", {
          "class": "DataMaxCol",
          text: '峰值'
        }, _el$35);
        createElement("Label", {
          "class": "DataClientCol",
          text: 'CLua长度'
        }, _el$35);
        const _el$41 = createElement("Panel", {
          "class": "Body"
        }, _el$34);
      insert(_el$41, createComponent(Index, {
        get each() {
          return getTableInfo();
        },
        children: tData => {
          const [isShowDetail, setShowDetail] = createSignal(false);
          return (() => {
            const _el$42 = createElement("Panel", {
                get ["class"]() {
                  return classNames("NetTableRow", tData().type);
                }
              }, null),
              _el$43 = createElement("Panel", {
                "class": "Header"
              }, _el$42),
              _el$44 = createElement("Panel", {
                "class": "TableNameCol"
              }, _el$43);
              createElement("Panel", {
                id: "DetailBtn"
              }, _el$44);
              const _el$46 = createElement("Label", {
                get text() {
                  return `[${tData().type}] ${tData().table}`;
                }
              }, _el$44),
              _el$47 = createElement("Label", {
                get ["class"]() {
                  return classNames("DataIncreaseCol", tData().increase > 0 ? 'Increase' : tData().increase < 0 ? 'Decrease' : '');
                },
                get text() {
                  return memo(() => tData().increase > 0)() ? '+' + tData().increase : memo(() => tData().increase < 0)() ? tData().increase : '';
                }
              }, _el$43),
              _el$48 = createElement("Label", {
                "class": "DataLenCol",
                get text() {
                  return tData().len;
                }
              }, _el$43),
              _el$49 = createElement("Label", {
                "class": "DataMaxCol",
                get text() {
                  return tData().max;
                }
              }, _el$43);
              createElement("Label", {
                "class": "DataClientCol",
                text: ''
              }, _el$43);
            setProp(_el$44, "onactivate", () => {
              setShowDetail(!isShowDetail());
            });
            insert(_el$42, createComponent(Show, {
              get when() {
                return isShowDetail();
              },
              get children() {
                const _el$51 = createElement("Panel", {
                  id: "NettableDataBox"
                }, null);
                insert(_el$51, createComponent(Index, {
                  get each() {
                    return tData().data.sort((a, b) => b.len - a.len);
                  },
                  children: tData2 => {
                    const [getClientLen, setClientLen] = createSignal(0);
                    const id = Timer(() => {
                      let iLen = 0;
                      const t = NetEventData.GetTableValue(tData().table, tData2().key);
                      if (t) {
                        iLen = JSON.stringify(t).length;
                      }
                      setClientLen(iLen);
                      return 1;
                    }, -1, undefined, 'Debug.NetTable.setClientLen');
                    onCleanup(() => {
                      StopTimer(id);
                    });
                    return (() => {
                      const _el$52 = createElement("Panel", {
                          "class": "NettableDataRow"
                        }, null),
                        _el$53 = createElement("Label", {
                          id: "NameLabel",
                          get text() {
                            return `${tData2().name}`;
                          }
                        }, _el$52),
                        _el$54 = createElement("Label", {
                          get ["class"]() {
                            return classNames("DataIncreaseCol", tData2().increase > 0 ? 'Increase' : tData2().increase < 0 ? 'Decrease' : '');
                          },
                          get text() {
                            return memo(() => tData2().increase > 0)() ? '+' + tData2().increase : memo(() => tData2().increase < 0)() ? tData2().increase : '';
                          }
                        }, _el$52),
                        _el$55 = createElement("Label", {
                          "class": "DataLenCol",
                          get text() {
                            return tData2().len;
                          }
                        }, _el$52),
                        _el$56 = createElement("Label", {
                          "class": "DataMaxCol",
                          get text() {
                            return tData2().max;
                          }
                        }, _el$52),
                        _el$57 = createElement("Label", {
                          "class": "DataClientCol",
                          get text() {
                            return getClientLen();
                          }
                        }, _el$52);
                      effect(_p$ => {
                        const _v$11 = {
                            'IsMax': tData2().len == tData2().max
                          },
                          _v$12 = `${tData2().name}`,
                          _v$13 = classNames("DataIncreaseCol", tData2().increase > 0 ? 'Increase' : tData2().increase < 0 ? 'Decrease' : ''),
                          _v$14 = memo(() => tData2().increase > 0)() ? '+' + tData2().increase : memo(() => tData2().increase < 0)() ? tData2().increase : '',
                          _v$15 = tData2().len,
                          _v$16 = tData2().max,
                          _v$17 = getClientLen();
                        _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$52, "classList", _v$11, _p$._v$11));
                        _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$53, "text", _v$12, _p$._v$12));
                        _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$54, "class", _v$13, _p$._v$13));
                        _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$54, "text", _v$14, _p$._v$14));
                        _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$55, "text", _v$15, _p$._v$15));
                        _v$16 !== _p$._v$16 && (_p$._v$16 = setProp(_el$56, "text", _v$16, _p$._v$16));
                        _v$17 !== _p$._v$17 && (_p$._v$17 = setProp(_el$57, "text", _v$17, _p$._v$17));
                        return _p$;
                      }, {
                        _v$11: undefined,
                        _v$12: undefined,
                        _v$13: undefined,
                        _v$14: undefined,
                        _v$15: undefined,
                        _v$16: undefined,
                        _v$17: undefined
                      });
                      return _el$52;
                    })();
                  }
                }));
                return _el$51;
              }
            }), null);
            effect(_p$ => {
              const _v$6 = classNames("NetTableRow", tData().type),
                _v$7 = {
                  'IsMax': tData().len == tData().max
                },
                _v$8 = `[${tData().type}] ${tData().table}`,
                _v$9 = classNames("DataIncreaseCol", tData().increase > 0 ? 'Increase' : tData().increase < 0 ? 'Decrease' : ''),
                _v$0 = memo(() => tData().increase > 0)() ? '+' + tData().increase : memo(() => tData().increase < 0)() ? tData().increase : '',
                _v$1 = tData().len,
                _v$10 = tData().max;
              _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$42, "class", _v$6, _p$._v$6));
              _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$42, "classList", _v$7, _p$._v$7));
              _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$46, "text", _v$8, _p$._v$8));
              _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$47, "class", _v$9, _p$._v$9));
              _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$47, "text", _v$0, _p$._v$0));
              _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$48, "text", _v$1, _p$._v$1));
              _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$49, "text", _v$10, _p$._v$10));
              return _p$;
            }, {
              _v$6: undefined,
              _v$7: undefined,
              _v$8: undefined,
              _v$9: undefined,
              _v$0: undefined,
              _v$1: undefined,
              _v$10: undefined
            });
            return _el$42;
          })();
        }
      }));
      return _el$34;
    })();
  }
  function TimerPanel() {
    GameUI.CustomUIConfig().tools.Timer.tTimerDebug = {};
    const [getTimerDebug, setTimerDebug] = createSignal(GameUI.CustomUIConfig().tools.Timer.tTimerDebug);
    createEffect(() => {
      const id = Timer(() => {
        setTimerDebug(Object.assign({}, GameUI.CustomUIConfig().tools.Timer.tTimerDebug));
        return 0;
      }, 0, undefined, 'TimerPanel');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$58 = createElement("Panel", {
          "class": "TimerPanel"
        }, null),
        _el$59 = createElement("Panel", {
          "class": "Header"
        }, _el$58);
        createElement("Label", {
          "class": "NameCol",
          text: '表名'
        }, _el$59);
        createElement("Label", {
          "class": "SpendCol",
          text: '耗时(ms)'
        }, _el$59);
        createElement("Label", {
          "class": "SpendMaxCol",
          text: '耗时峰值(ms)'
        }, _el$59);
        createElement("Label", {
          "class": "OncSecSpendCol",
          text: '上秒占用(ms)'
        }, _el$59);
        createElement("Label", {
          "class": "DelayCol",
          text: '间隔(s)'
        }, _el$59);
        const _el$65 = createElement("Panel", {
          "class": "Body"
        }, _el$58);
      insert(_el$65, createComponent(Index, {
        get each() {
          return Object.keys(getTimerDebug()).sort();
        },
        children: sName => {
          const tDebug = () => getTimerDebug()[sName()];
          const [isPause, setPause] = createSignal(GameUI.CustomUIConfig().tools.Timer.tTimerDebug[sName()].bPause);
          return (() => {
            const _el$66 = createElement("Panel", {
                "class": "Row"
              }, null),
              _el$67 = createElement("Panel", {
                "class": "Header"
              }, _el$66),
              _el$68 = createElement("Panel", {
                "class": "NameCol"
              }, _el$67),
              _el$69 = createElement("Label", {
                id: "PauseBtn",
                get text() {
                  return isPause() ? '开启' : '暂停';
                }
              }, _el$68),
              _el$70 = createElement("Label", {
                id: "NameLabel",
                get text() {
                  return sName();
                }
              }, _el$68),
              _el$71 = createElement("Label", {
                "class": "SpendCol",
                get text() {
                  return tDebug().fSpend;
                }
              }, _el$67),
              _el$72 = createElement("Label", {
                "class": "SpendMaxCol",
                get text() {
                  return tDebug().fSpendMax;
                }
              }, _el$67),
              _el$73 = createElement("Label", {
                "class": "OncSecSpendCol",
                get text() {
                  return tDebug().tLastSec.last_spend;
                }
              }, _el$67),
              _el$74 = createElement("Label", {
                "class": "DelayCol",
                get text() {
                  return tDebug().fDelay;
                }
              }, _el$67);
            setProp(_el$69, "onactivate", () => {
              GameUI.CustomUIConfig().tools.Timer.tTimerDebug[sName()].bPause = GameUI.CustomUIConfig().tools.Timer.tTimerDebug[sName()].bPause != true;
              setPause(GameUI.CustomUIConfig().tools.Timer.tTimerDebug[sName()].bPause);
            });
            setProp(_el$70, "onactivate", () => {
              $.DispatchEvent('CopyStringToClipboard', sName(), "1");
              ErrorMsg('CopySuccess');
            });
            effect(_p$ => {
              const _v$18 = {
                  'Pause': isPause()
                },
                _v$19 = isPause() ? '开启' : '暂停',
                _v$20 = sName(),
                _v$21 = tDebug().fSpend,
                _v$22 = tDebug().fSpendMax,
                _v$23 = tDebug().tLastSec.last_spend,
                _v$24 = tDebug().fDelay;
              _v$18 !== _p$._v$18 && (_p$._v$18 = setProp(_el$69, "classList", _v$18, _p$._v$18));
              _v$19 !== _p$._v$19 && (_p$._v$19 = setProp(_el$69, "text", _v$19, _p$._v$19));
              _v$20 !== _p$._v$20 && (_p$._v$20 = setProp(_el$70, "text", _v$20, _p$._v$20));
              _v$21 !== _p$._v$21 && (_p$._v$21 = setProp(_el$71, "text", _v$21, _p$._v$21));
              _v$22 !== _p$._v$22 && (_p$._v$22 = setProp(_el$72, "text", _v$22, _p$._v$22));
              _v$23 !== _p$._v$23 && (_p$._v$23 = setProp(_el$73, "text", _v$23, _p$._v$23));
              _v$24 !== _p$._v$24 && (_p$._v$24 = setProp(_el$74, "text", _v$24, _p$._v$24));
              return _p$;
            }, {
              _v$18: undefined,
              _v$19: undefined,
              _v$20: undefined,
              _v$21: undefined,
              _v$22: undefined,
              _v$23: undefined,
              _v$24: undefined
            });
            return _el$66;
          })();
        }
      }));
      return _el$58;
    })();
  }
  function DebugCodePanel() {
    let refInputText;
    let refOutputText;
    return (() => {
      const _el$75 = createElement("Panel", {
          "class": "DebugCodePanel"
        }, null),
        _el$76 = createElement("Panel", {
          id: "Input"
        }, _el$75),
        _el$77 = createElement("TextEntry", {
          id: "InputText",
          multiline: true
        }, _el$76),
        _el$78 = createElement("Panel", {
          id: "Output"
        }, _el$75),
        _el$79 = createElement("TextEntry", {
          id: "OutputText",
          multiline: true
        }, _el$78),
        _el$80 = createElement("Panel", {
          id: "BtnBox"
        }, _el$75),
        _el$81 = createElement("TextButton", {
          id: "RunBtn",
          text: 'JS'
        }, _el$80),
        _el$82 = createElement("TextButton", {
          id: "RunBtn",
          text: 'C-Lua'
        }, _el$80),
        _el$83 = createElement("TextButton", {
          id: "RunBtn",
          text: 'S-Lua'
        }, _el$80),
        _el$84 = createElement("TextButton", {
          id: "RunBtn",
          text: 'DebugLog'
        }, _el$80),
        _el$85 = createElement("TextButton", {
          id: "RunBtn",
          text: 'ClearLog'
        }, _el$80);
      const _ref$ = refInputText;
      typeof _ref$ === "function" ? use(_ref$, _el$77) : refInputText = _el$77;
      const _ref$2 = refOutputText;
      typeof _ref$2 === "function" ? use(_ref$2, _el$79) : refOutputText = _el$79;
      setProp(_el$81, "onactivate", () => {
        if (refInputText === null || refInputText === void 0 ? void 0 : refInputText.text) {
          $.GetContextPanel().RunScriptInPanelContext(`
                            try {
                                delete GameUI.CustomUIConfig()['__DebugCode__'];
                                GameUI.CustomUIConfig()['__DebugCode__'] = (()=>{
                                    ${refInputText.text}
                                })();
                            } catch (error) {
                                GameUI.CustomUIConfig()['__DebugCode__'] = error
                            }
                        `);
          let res = GameUI.CustomUIConfig()['__DebugCode__'];
          if (refOutputText) {
            refOutputText.text = String(res);
          }
        }
      });
      setProp(_el$82, "onactivate", () => {
        if (refInputText === null || refInputText === void 0 ? void 0 : refInputText.text) {
          if (refOutputText) {
            try {
              let res = runlua(refInputText.text);
              refOutputText.text = String(res);
            } catch (error) {
              refOutputText.text = String(error);
            }
          }
        }
      });
      setProp(_el$83, "onactivate", () => {
        if (refInputText === null || refInputText === void 0 ? void 0 : refInputText.text) {
          Request('debug_run', {
            lua: refInputText === null || refInputText === void 0 ? void 0 : refInputText.text
          }).then(res => {
            var _a, _b;
            if (refOutputText) {
              refOutputText.text = String((_b = (_a = res === null || res === void 0 ? void 0 : res.data) === null || _a === void 0 ? void 0 : _a.r) !== null && _b !== void 0 ? _b : '');
            }
          });
        }
      });
      setProp(_el$84, "onactivate", () => {
        Request('debug_run', {
          lua: 'return GameDebug:PrintDebugLog()'
        }).then(res => {
          var _a, _b;
          if (refOutputText) {
            const tLog = JSON.parse((_b = (_a = res === null || res === void 0 ? void 0 : res.data) === null || _a === void 0 ? void 0 : _a.r) !== null && _b !== void 0 ? _b : '');
            if (tLog && Array.isArray(tLog)) {
              refOutputText.text = tLog.join('\n');
            }
          }
        });
      });
      setProp(_el$85, "onactivate", () => {
        Request('debug_run', {
          lua: 'return GameDebug:ClearDebugLog()'
        });
      });
      return _el$75;
    })();
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
    fNumber = Round(Math.abs(fNumber), prec);
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
    } else {
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

  function IsPanelOverflowScreen(p, vPos) {
    if (vPos == undefined) {
      const v = p.GetPositionWithinWindow();
      return v.x < 0 || v.y < 0 || v.x > Game.GetScreenWidth() || v.y > Game.GetScreenHeight();
    }
    return vPos[0] < 0 || vPos[1] < 0 || vPos[0] > Game.GetScreenWidth() || vPos[1] > Game.GetScreenHeight();
  }
  function AngleBetween(v1, v2) {
    const sin = v1[0] * v2[1] - v2[0] * v1[1];
    const cos = v1[0] * v2[0] + v1[1] * v2[1];
    const a = Math.atan2(sin, cos) * (180 / Math.PI);
    return a;
  }
  function UpdateOverheadPanel(p, iEntID, params) {
    var _a, _b;
    if (!p || !p.IsValid()) return false;
    if (!Entities.IsValidEntity(iEntID) || !Entities.IsItemPhysical(iEntID) && (!Entities.IsAlive(iEntID) || ((_a = params === null || params === void 0 ? void 0 : params.no_health_bar) !== null && _a !== void 0 ? _a : Entities.NoHealthBar(iEntID)) || Entities.GetNumBuffs(iEntID) == 0)) {
      p.style.visibility = 'collapse';
      return false;
    }
    p.style.visibility = 'visible';
    const vOrigin = Entities.GetAbsOrigin(iEntID);
    let fX = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2]);
    let fY = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2]);
    p.SetPositionInPixels((fX - p.actuallayoutwidth / 2) / p.actualuiscale_x, (fY - p.actuallayoutheight) / p.actualuiscale_y, 0);
    if (IsPanelOverflowScreen(p, [fX, fY])) {
      p.style.visibility = 'collapse';
      return false;
    }
    let fOffset = (_b = params === null || params === void 0 ? void 0 : params.offset) !== null && _b !== void 0 ? _b : Entities.GetHealthBarOffset(iEntID);
    fX = Game.WorldToScreenX(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset);
    fY = Game.WorldToScreenY(vOrigin[0], vOrigin[1], vOrigin[2] + fOffset);
    p.SetPositionInPixels((fX - p.actuallayoutwidth / 2) / p.actualuiscale_x, (fY - p.actuallayoutheight) / p.actualuiscale_y, 0);
    if (params === null || params === void 0 ? void 0 : params.rotatable) {
      const vCamera = GameUI.GetCameraPosition();
      let vDir = Game.Normalized([vCamera[0] - vOrigin[0], vCamera[1] - vOrigin[1], vCamera[2] - vOrigin[2]]);
      const fAge = AngleBetween(vDir, [0, -1, 0]) * 0.3;
      p.style.preTransformRotate2d = fAge + 'deg';
    }
    return true;
  }

  var WearableHeroSlot = {
    'npc_dota_hero_axe': {
      "weapon": 31,
      "head": 30,
      "armor": 28,
      "belt": 18,
      "misc": 15
    },
    'npc_dota_hero_juggernaut': {
      "head": 26,
      "arms": 32,
      "back": 21,
      "legs": 19
    },
    'npc_dota_hero_luna': {
      'offhand_weapon': 15,
      'shoulder': 18,
      'mount': 21
    },
    'npc_dota_hero_techies': {
      'shoulder': 5,
      'head': 6,
      'back': 10,
      'mount': 17
    },
    'npc_dota_hero_dawnbreaker': {
      'armor': 0,
      'arms': 6,
      'head': 7,
      'weapon': 20
    },
    'npc_dota_hero_grimstroke': {
      'weapon': 0,
      'armor': 7,
      'head': 8,
      'belt': 21
    },
    'npc_dota_hero_jakiro': {
      'head': 4,
      'body_head': 10,
      'back': 13,
      'tail': 21
    },
    'npc_dota_hero_hoodwink': {
      'weapon': 0,
      'armor': 7,
      'tail': 13,
      'back': 20
    },
    'npc_dota_hero_mars': {
      'weapon': 0,
      'armor': 2,
      'offhand_weapon': 15,
      'legs': 21,
      'costume': 29
    },
    'npc_dota_hero_phantom_assassin': {
      'weapon': 0,
      'head': 4,
      'shoulder': 8,
      'back': 10,
      'belt': 20
    },
    'npc_dota_hero_phantom_assassin_persona': {},
    'npc_dota_hero_huskar': {
      'weapon': 0,
      'head': 4,
      'offhand_weapon': 5,
      'arms': 6,
      'shoulder': 21
    },
    'npc_dota_hero_snapfire': {
      'weapon': 0,
      'head': 4,
      'armor': 7,
      'mount': 20,
      'costume': 30
    },
    'npc_dota_hero_storm_spirit': {
      'head': 4,
      'armor': 7,
      'arms': 20
    },
    'npc_dota_hero_faceless_void': {
      'weapon': 0,
      'body_head': 5,
      'arms': 6,
      'belt': 8,
      'shoulder': 20
    },
    'npc_dota_hero_undying': {
      'head': 4,
      'armor': 6,
      'arms': 20,
      'ability4': 21
    },
    'npc_dota_hero_dark_willow': {
      'head': 1,
      'armor': 7,
      'offhand_weapon': 8,
      'back': 10,
      'belt': 15
    },
    'npc_dota_hero_earth_spirit': {
      'weapon': 0,
      'head': 4,
      'neck': 6,
      'belt': 8,
      'arms': 8
    },
    'npc_dota_hero_doom_bringer': {
      'weapon': 0,
      'head': 4,
      'arms': 5,
      'shoulder': 8,
      'back': 10,
      'belt': 13,
      'tail': 20
    },
    'npc_dota_hero_venomancer': {
      'head': 4,
      'shoulder': 5,
      'tail': 6,
      'arms': 21
    },
    'npc_dota_hero_legion_commander': {
      'weapon': 0,
      'head': 29,
      'back': 28,
      'shoulder': 20,
      'arms': 11,
      'legs': 15
    },
    'npc_dota_hero_shredder': {
      'weapon': 0,
      'offhand_weapon': 1,
      'armor': 20,
      'shoulder': 21,
      'back': 29,
      'head': 31
    },
    'npc_dota_hero_phoenix': {
      'head': 10,
      'back': 31
    },
    'npc_dota_hero_terrorblade': {
      'weapon': 0,
      'armor': 21,
      'head': 25,
      'back': 7
    },
    'npc_dota_hero_razor': {
      'weapon': 0,
      'head': 30,
      'armor': 21,
      'arms': 28,
      'belt': 8
    },
    'npc_dota_hero_bristleback': {
      'weapon': 0,
      'back': 18,
      'arms': 20,
      'head': 28,
      'neck': 29
    },
    'npc_dota_hero_pudge': {
      'weapon': 0,
      'belt': 42,
      'shoulder': 44,
      'offhand_weapon': 45,
      'back': 57,
      'head': 58,
      'arms': 66
    },
    'npc_dota_hero_lich': {
      'belt': 10,
      'head': 21,
      'neck': 29,
      'arms': 30,
      'back': 31
    },
    'npc_dota_hero_obsidian_destroyer': {
      'weapon': 0,
      'armor': 21,
      'back': 29,
      'head': 31
    },
    'npc_dota_hero_night_stalker': {
      'head': 4,
      'back': 6,
      'arms': 11,
      'legs': 13,
      'tail': 20
    },
    'npc_dota_hero_nevermore': {
      'head': 4,
      'arms': 5,
      'shoulder': 6,
      'hero_base': 16
    },
    'npc_dota_hero_crystal_maiden': {
      'weapon': 0,
      'back': 4,
      'shoulder': 5,
      'arms': 6,
      'head': 21
    },
    'npc_dota_hero_chaos_knight': {
      'shoulder': 21,
      'head': 4,
      'mount': 18,
      'offhand_weapon': 5
    },
    'npc_dota_hero_zuus': {
      'head': 30,
      'belt': 8
    },
    'npc_dota_hero_oracle': {
      'weapon': 0,
      'head': 31,
      'armor': 29,
      'back': 20
    },
    'npc_dota_hero_enigma': {
      'head': 31,
      'arms': 7,
      'armor': 26
    },
    'npc_dota_hero_lina': {
      'head': 29,
      'arms': 21,
      'neck': 6,
      'belt': 31
    },
    'npc_dota_hero_spectre': {
      'head': 21,
      'shoulder': 8,
      'weapon': 22,
      'misc': 14,
      'belt': 0
    },
    'npc_dota_hero_vengefulspirit': {
      'head': 29,
      'shoulder': 11,
      'weapon': 0,
      'legs': 28
    },
    'npc_dota_hero_witch_doctor': {
      'head': 4,
      'shoulder': 10,
      'weapon': 30,
      'back': 29,
      'belt': 5
    },
    'npc_dota_hero_shadow_demon': {
      'tail': 21,
      'armor': 7,
      'back': 31,
      'belt': 8
    },
    'npc_dota_hero_necrolyte': {
      'head': 4,
      'body_head': 21,
      'shoulder': 29,
      'legs': 0,
      'weapon': 30
    },
    'npc_dota_hero_sand_king': {
      'arms': 10,
      'body_head': 31,
      'shoulder': 6,
      'legs': 20,
      'back': 29
    },
    'npc_dota_hero_alchemist': {
      'armor': 1,
      'arms': 7,
      'back': 9,
      'neck': 15,
      'offhand_weapon': 4,
      'shoulder': 5,
      'weapon': 6
    },
    'npc_dota_hero_morphling': {
      'back': 6,
      'head': 4,
      'arms': 29,
      'misc': 14,
      'shoulder': 21
    },
    'npc_dota_hero_lion': {
      'shoulder': 21,
      'arms': 5,
      'head': 10,
      'back': 29,
      'weapon': 31
    },
    'npc_dota_hero_skeleton_king': {
      'head': 4,
      'back': 7,
      'armor': 31,
      'shoulder': 21,
      'arms': 29,
      'weapon': 30
    },
    'npc_dota_hero_abyssal_underlord': {
      'head': 7,
      'armor': 30,
      'weapon': 0
    },
    'npc_dota_hero_slark': {
      'weapon': 0,
      'head': 6,
      'arms': 10,
      'back': 5,
      'shoulder': 19
    },
    'npc_dota_hero_primal_beast': {
      'arms': 10,
      'back': 28,
      'head': 4,
      'legs': 20
    },
    'npc_dota_hero_rubick': {
      'weapon': 0,
      'back': 38,
      'head': 21,
      'shoulder': 10
    },
    'npc_dota_hero_skywrath_mage': {
      'weapon': 0,
      'back': 32,
      'head': 21,
      'shoulder': 6,
      'belt': 28,
      'arms': 15
    },
    'npc_dota_hero_drow_ranger': {
      'weapon': 0,
      'back': 30,
      'head': 14,
      'shoulder': 31,
      'misc': 20,
      'legs': 4,
      'arms': 11
    },
    'npc_dota_hero_windrunner': {
      'weapon': 30,
      'back': 31,
      'shoulder': 32,
      'offhand_weapon': 21,
      'head': 22
    },
    'npc_dota_hero_ancient_apparition': {
      'head': 4,
      'shoulder': 6,
      'arms': 22,
      'tail': 21
    }
  };

  function WearableHero(props) {
    return createMemo(() => {
      var _a, _b, _c, _d, _e;
      const tItems = props.tItems;
      const itemdef = (_a = props.itemdef) !== null && _a !== void 0 ? _a : (_b = tItems === null || tItems === void 0 ? void 0 : tItems[0]) === null || _b === void 0 ? void 0 : _b[0];
      const itemstyle = (_e = (_c = props.itemstyle) !== null && _c !== void 0 ? _c : (_d = tItems === null || tItems === void 0 ? void 0 : tItems[0]) === null || _d === void 0 ? void 0 : _d[1]) !== null && _e !== void 0 ? _e : 0;
      const displaymode = props.displaymode != undefined ? props.displaymode : 'loadout_small';
      const drawbackground = props.drawbackground != undefined ? props.drawbackground : false;
      const renderdeferred = props.renderdeferred != undefined ? props.renderdeferred : false;
      const deferredalpha = props.deferredalpha != undefined ? props.deferredalpha : false;
      const requireCompositionLayer = props.requireCompositionLayer != undefined ? props.requireCompositionLayer : false;
      const antialias = props.antialias != undefined ? props.antialias : false;
      const allowrotation = props.allowrotation != undefined ? props.allowrotation : false;
      const rotationspeed = props.rotationspeed != undefined ? props.rotationspeed : 0;
      const postProcessMaterial = props.postProcessMaterial != undefined ? props.postProcessMaterial : "materials/dev/deferred_post_process_graphic_ui.vmat";
      return (() => {
        const _el$ = createElement("GenericPanel", mergeProps({
          type: "DOTAUIEconSetPreview"
        }, props, {
          itemdef: itemdef,
          itemstyle: itemstyle,
          displaymode: displaymode,
          drawbackground: drawbackground,
          renderdeferred: renderdeferred,
          deferredalpha: deferredalpha,
          "require-composition-layer": requireCompositionLayer,
          antialias: antialias,
          allowrotation: allowrotation,
          rotationspeed: rotationspeed,
          "post-process-material": postProcessMaterial
        }), null);
        spread(_el$, mergeProps(props, {
          "itemdef": itemdef,
          "itemstyle": itemstyle,
          "displaymode": displaymode,
          "drawbackground": drawbackground,
          "renderdeferred": renderdeferred,
          "deferredalpha": deferredalpha,
          "require-composition-layer": requireCompositionLayer,
          "antialias": antialias,
          "allowrotation": allowrotation,
          "rotationspeed": rotationspeed,
          "post-process-material": postProcessMaterial,
          "onload": p => {
            var _a, _b, _c, _d, _e;
            const p2 = p.GetChild(0);
            if (p2 && p2.IsValid()) {
              for (let i = props.itemdef != undefined ? 0 : 1; i < tItems.length; i++) {
                const [id, style] = tItems[i];
                const tKv = WearableKv[id];
                if (tKv) {
                  let sHero2 = (_a = props.sHero) !== null && _a !== void 0 ? _a : Object.keys((_b = tKv === null || tKv === void 0 ? void 0 : tKv['slot_id']) !== null && _b !== void 0 ? _b : {})[0];
                  if (sHero2) {
                    let slot = (_d = (_c = WearableHeroSlot[sHero2]) === null || _c === void 0 ? void 0 : _c[tKv['slot']]) !== null && _d !== void 0 ? _d : tKv['slot_id'][sHero2];
                    if (slot != undefined) {
                      p2.ReplaceEconItemSlot(Number(slot) || 0, id, style !== null && style !== void 0 ? style : 1);
                    } else {
                      UploadError(`[Wearable warning] 缺少英雄饰品槽位配置 hero=${sHero2} slot=${tKv['slot']} `);
                    }
                  }
                }
              }
            }
            if (typeof props.onload == 'function') {
              (_e = props.onload) === null || _e === void 0 ? void 0 : _e.call(props, p);
            }
          }
        }), false);
        return _el$;
      })();
    });
  }
  function WearableCfgByKv(tKv) {
    var _a;
    const tCfg = {
      items: []
    };
    if (((_a = tKv === null || tKv === void 0 ? void 0 : tKv['Creature']) === null || _a === void 0 ? void 0 : _a['AttachWearables']) != undefined) {
      for (const t of Object.values(tKv['Creature']['AttachWearables'])) {
        if (t['ItemDef'] != undefined) {
          const [id, style] = String(t['ItemDef']).split(' ');
          tCfg.items.push([Number(id), Number(style) || 0]);
        }
      }
    }
    if (tKv === null || tKv === void 0 ? void 0 : tKv['ItemDefBase']) {
      const [id, style] = String(tKv['ItemDefBase']).split(' ');
      if (id) {
        tCfg.base_def = Number(id);
      }
      if (style) {
        tCfg.base_style = Number(style);
      }
    }
    return tCfg;
  }

  var AttributeKind = GameUI.CustomUIConfig().tools.AttributeKind;
  const ID2Attribute = {
    '10600001': AttributeKind.Main,
    '10600002': AttributeKind.Main.BASE,
    '10600003': AttributeKind.Main.BONUS,
    '10600004': AttributeKind.Main.PCT,
    '10600005': AttributeKind.Main.AMP,
    '10600006': AttributeKind.Secondary,
    '10600007': AttributeKind.Secondary.BASE,
    '10600008': AttributeKind.Secondary.BONUS,
    '10600009': AttributeKind.Secondary.PCT,
    '10600010': AttributeKind.Secondary.AMP,
    '10600011': AttributeKind.AllStats,
    '10600012': AttributeKind.AllStats.BASE,
    '10600013': AttributeKind.AllStats.BONUS,
    '10600014': AttributeKind.AllStats.PCT,
    '10600015': AttributeKind.AllStats.AMP,
    '10600016': AttributeKind.Strength,
    '10600017': AttributeKind.Strength.BASE,
    '10600018': AttributeKind.Strength.BONUS,
    '10600019': AttributeKind.Strength.PCT,
    '10600020': AttributeKind.Strength.AMP,
    '10600021': AttributeKind.Agility,
    '10600022': AttributeKind.Agility.BASE,
    '10600023': AttributeKind.Agility.BONUS,
    '10600024': AttributeKind.Agility.PCT,
    '10600025': AttributeKind.Agility.AMP,
    '10600026': AttributeKind.Intellect,
    '10600027': AttributeKind.Intellect.BASE,
    '10600028': AttributeKind.Intellect.BONUS,
    '10600029': AttributeKind.Intellect.PCT,
    '10600030': AttributeKind.Intellect.AMP,
    '10600031': AttributeKind.Atk,
    '10600032': AttributeKind.Atk.BASE,
    '10600033': AttributeKind.Atk.BONUS,
    '10600034': AttributeKind.Atk.PCT,
    '10600035': AttributeKind.Atk.AMP,
    '10600036': AttributeKind.PhyFixDmg,
    '10600037': AttributeKind.PhyFixDmg.BASE,
    '10600038': AttributeKind.PhyFixDmg.BONUS,
    '10600039': AttributeKind.PhyFixDmg.PCT,
    '10600040': AttributeKind.PhyFixDmg.AMP,
    '10600041': AttributeKind.MgcFixDmg,
    '10600042': AttributeKind.MgcFixDmg.BASE,
    '10600043': AttributeKind.MgcFixDmg.BONUS,
    '10600044': AttributeKind.MgcFixDmg.PCT,
    '10600045': AttributeKind.MgcFixDmg.AMP,
    '10600046': AttributeKind.AtkPure,
    '10600047': AttributeKind.AtkPure.BASE,
    '10600048': AttributeKind.AtkPure.BONUS,
    '10600049': AttributeKind.AtkPure.PCT,
    '10600050': AttributeKind.AtkPure.AMP,
    '10600051': AttributeKind.HpLimit,
    '10600052': AttributeKind.HpLimit.BASE,
    '10600053': AttributeKind.HpLimit.BONUS,
    '10600054': AttributeKind.HpLimit.PCT,
    '10600055': AttributeKind.HpLimit.AMP,
    '10600056': AttributeKind.HpRegen,
    '10600057': AttributeKind.HpRegen.BASE,
    '10600058': AttributeKind.HpRegen.BONUS,
    '10600059': AttributeKind.HpRegen.PCT,
    '10600060': AttributeKind.HpRegen.AMP,
    '10600061': AttributeKind.HpRegen.HP_PCT,
    '10600062': AttributeKind.MpLimit,
    '10600063': AttributeKind.MpLimit.BASE,
    '10600064': AttributeKind.MpLimit.BONUS,
    '10600065': AttributeKind.MpLimit.PCT,
    '10600066': AttributeKind.MpLimit.AMP,
    '10600067': AttributeKind.MpRegen,
    '10600068': AttributeKind.MpRegen.BASE,
    '10600069': AttributeKind.MpRegen.BONUS,
    '10600070': AttributeKind.MpRegen.PCT,
    '10600071': AttributeKind.MpRegen.AMP,
    '10600072': AttributeKind.MpRegen.MP_PCT,
    '10600073': AttributeKind.Armor,
    '10600074': AttributeKind.Armor.BASE,
    '10600075': AttributeKind.Armor.BONUS,
    '10600076': AttributeKind.Armor.PCT,
    '10600077': AttributeKind.Armor.AMP,
    '10600078': AttributeKind.AtkSpd,
    '10600079': AttributeKind.AtkSpd.BASE,
    '10600080': AttributeKind.AtkSpd.BONUS,
    '10600081': AttributeKind.AtkSpd.PCT,
    '10600082': AttributeKind.AtkTime,
    '10600083': AttributeKind.AtkTime.BASE,
    '10600084': AttributeKind.MoveSpd,
    '10600085': AttributeKind.MoveSpd.BASE,
    '10600086': AttributeKind.MoveSpd.BONUS,
    '10600087': AttributeKind.MoveSpd.PCT,
    '10600088': AttributeKind.AtkRange,
    '10600089': AttributeKind.AtkRange.BASE,
    '10600090': AttributeKind.AtkRange.BONUS,
    '10600091': AttributeKind.AtkRange.PCT,
    '10600092': AttributeKind.PrjctSpd,
    '10600093': AttributeKind.PrjctSpd.BASE,
    '10600094': AttributeKind.PrjctSpd.BONUS,
    '10600095': AttributeKind.PrjctSpd.PCT,
    '10600096': AttributeKind.CastRange,
    '10600097': AttributeKind.CastRange.BASE,
    '10600098': AttributeKind.CastRange.BONUS,
    '10600099': AttributeKind.CastRange.PCT,
    '10600100': AttributeKind.Cooldown,
    '10600101': AttributeKind.Cooldown.BASE,
    '10600102': AttributeKind.Cooldown.BONUS,
    '10600103': AttributeKind.Cooldown.PCT,
    '10600104': AttributeKind.StaResist,
    '10600105': AttributeKind.DebuffAmp,
    '10600106': AttributeKind.Hit,
    '10600107': AttributeKind.Evasion,
    '10600108': AttributeKind.Heal,
    '10600109': AttributeKind.ModelScale,
    '10600110': AttributeKind.ModelScale.PCT,
    '10600111': AttributeKind.ArmorPenetrate,
    '10600112': AttributeKind.ArmorPenetrate.BASE,
    '10600113': AttributeKind.ArmorPenetrate.BONUS,
    '10600114': AttributeKind.ArmorPenetrate.PCT,
    '10600115': AttributeKind.ArmorPenetrate.AMP,
    '10600116': AttributeKind.ArmorIgnore,
    '10600117': AttributeKind.ArmorIgnore.BASE,
    '10600118': AttributeKind.PhyCritChance,
    '10600119': AttributeKind.PhyCritChance.BASE,
    '10600120': AttributeKind.MgcCritChance,
    '10600121': AttributeKind.MgcCritChance.BASE,
    '10600122': AttributeKind.PureCritChance,
    '10600123': AttributeKind.PureCritChance.BASE,
    '10600124': AttributeKind.PhyCritDmg,
    '10600125': AttributeKind.PhyCritDmg.BASE,
    '10600126': AttributeKind.MgcCritDmg,
    '10600127': AttributeKind.MgcCritDmg.BASE,
    '10600128': AttributeKind.PureCritDmg,
    '10600129': AttributeKind.PureCritDmg.BASE,
    '10600130': AttributeKind.MultCount,
    '10600131': AttributeKind.MultDmg,
    '10600132': AttributeKind.BounceCount,
    '10600133': AttributeKind.BounceDmg,
    '10600134': AttributeKind.CleaveCount,
    '10600135': AttributeKind.CleaveDmg,
    '10600136': AttributeKind.StrGain,
    '10600137': AttributeKind.AgiGain,
    '10600138': AttributeKind.IntGain,
    '10600139': AttributeKind.AtkGain,
    '10600140': AttributeKind.AtkPureGain,
    '10600141': AttributeKind.HpGain,
    '10600142': AttributeKind.PhyFixedGain,
    '10600143': AttributeKind.MgcFixedGain,
    '10600144': AttributeKind.CreepDmg,
    '10600145': AttributeKind.CreepDmg.BASE,
    '10600146': AttributeKind.EliteDmg,
    '10600147': AttributeKind.EliteDmg.BASE,
    '10600148': AttributeKind.ChallengeDmg,
    '10600149': AttributeKind.ChallengeDmg.BASE,
    '10600150': AttributeKind.BossDmg,
    '10600151': AttributeKind.BossDmg.BASE,
    '10600152': AttributeKind.AtkDmg,
    '10600153': AttributeKind.AtkDmg.BASE,
    '10600154': AttributeKind.AbltDmg,
    '10600155': AttributeKind.AbltDmg.BASE,
    '10600156': AttributeKind.PhyDmg,
    '10600157': AttributeKind.PhyDmg.BASE,
    '10600158': AttributeKind.MgcDmg,
    '10600159': AttributeKind.MgcDmg.BASE,
    '10600160': AttributeKind.PureDmg,
    '10600161': AttributeKind.PureDmg.BASE,
    '10600162': AttributeKind.AllDmg,
    '10600163': AttributeKind.AllDmg.BASE,
    '10600164': AttributeKind.DmgFinal,
    '10600165': AttributeKind.DmgFinal.BASE,
    '10600166': AttributeKind.DmgReduce,
    '10600167': AttributeKind.DmgReduce.BASE,
    '10600168': AttributeKind.GoldPct,
    '10600169': AttributeKind.WoodPct,
    '10600170': AttributeKind.KillPct,
    '10600171': AttributeKind.ExpPct,
    '10600172': AttributeKind.PerSecAllStats,
    '10600173': AttributeKind.PerSecStr,
    '10600174': AttributeKind.PerSecAgi,
    '10600175': AttributeKind.PerSecInt,
    '10600176': AttributeKind.PerSecHp,
    '10600177': AttributeKind.PerSecAtk,
    '10600178': AttributeKind.PerSecAtkPure,
    '10600179': AttributeKind.PerSecPhyFixDmg,
    '10600180': AttributeKind.PerSecMgcFixDmg,
    '10600181': AttributeKind.PerSecGold,
    '10600182': AttributeKind.PerSecWood,
    '10600183': AttributeKind.PerSecKill,
    '10600184': AttributeKind.PerSecExp,
    '10600185': AttributeKind.KillAllStats,
    '10600186': AttributeKind.KillStr,
    '10600187': AttributeKind.KillAgi,
    '10600188': AttributeKind.KillInt,
    '10600189': AttributeKind.KillHp,
    '10600190': AttributeKind.KillAtk,
    '10600191': AttributeKind.KillAtkPure,
    '10600192': AttributeKind.KillPhyFixDmg,
    '10600193': AttributeKind.KillMgcFixDmg,
    '10600194': AttributeKind.KillGold,
    '10600195': AttributeKind.KillWood,
    '10600196': AttributeKind.KillKill,
    '10600197': AttributeKind.KillExp,
    '10600198': AttributeKind.KillRegenHp,
    '10600199': AttributeKind.RespawnChance,
    '10600200': AttributeKind.RespawnTime,
    '10600201': AttributeKind.RespawnTime.BASE,
    '10600202': AttributeKind.RespawnTime.PCT,
    '10600203': AttributeKind.SummonDoubleChance,
    '10600204': AttributeKind.SummonDuration,
    '10600205': AttributeKind.SummonDmg,
    '10600206': AttributeKind.HolyDmg,
    '10600207': AttributeKind.HolyDmg.BASE,
    '10600208': AttributeKind.NatureDmg,
    '10600209': AttributeKind.NatureDmg.BASE,
    '10600210': AttributeKind.FrostDmg,
    '10600211': AttributeKind.FrostDmg.BASE,
    '10600212': AttributeKind.FireDmg,
    '10600213': AttributeKind.FireDmg.BASE,
    '10600214': AttributeKind.PhysicalDmg,
    '10600215': AttributeKind.PhysicalDmg.BASE,
    '10600216': AttributeKind.ShadowDmg,
    '10600217': AttributeKind.ShadowDmg.BASE,
    '10600218': AttributeKind.AllFlagDmg,
    '10600219': AttributeKind.HolyPenetrate,
    '10600220': AttributeKind.NaturePenetrate,
    '10600221': AttributeKind.FrostPenetrate,
    '10600222': AttributeKind.FirePenetrate,
    '10600223': AttributeKind.PhysicalPenetrate,
    '10600224': AttributeKind.ShadowPenetrate,
    '10600225': AttributeKind.HolyResist,
    '10600226': AttributeKind.NatureResist,
    '10600227': AttributeKind.FrostResist,
    '10600228': AttributeKind.FireResist,
    '10600229': AttributeKind.PhysicalResist,
    '10600230': AttributeKind.ShadowResist,
    '10600231': AttributeKind.InitGood,
    '10600232': AttributeKind.InitWood,
    '10600233': AttributeKind.InitKill,
    '10600234': AttributeKind.GainDoubleChance,
    '10600235': AttributeKind.GainDoubleChance.BASE,
    '10600236': AttributeKind.DoubleCastChance,
    '10600237': AttributeKind.DoubleCastChance.BASE,
    '10600238': AttributeKind.AtkPureChance,
    '10600239': AttributeKind.MgcPureChance,
    '10600240': AttributeKind.AtkCleaveChance,
    '10600241': AttributeKind.AtkCleaveChance.BASE,
    '10600242': AttributeKind.AtkCleaveRadius,
    '10600243': AttributeKind.AtkCleaveDmg,
    '10600244': AttributeKind.PureCleaveChance,
    '10600245': AttributeKind.PureCleaveChance.BASE,
    '10600246': AttributeKind.PureCleaveRadius,
    '10600247': AttributeKind.PureCleaveDmg,
    '10600248': AttributeKind.AtkBadDmgChance,
    '10600249': AttributeKind.AtkBadDmgChance.BASE,
    '10600250': AttributeKind.AtkBadDmg,
    '10600251': AttributeKind.AtkBadDuration,
    '10600252': AttributeKind.BadEffect,
    '10600253': AttributeKind.CardEffect,
    '10600254': AttributeKind.FatalBlow,
    '10600255': AttributeKind.PenetrateCount,
    '10600256': AttributeKind.BurnDmg,
    '10600257': AttributeKind.IceDmg,
    '10600258': AttributeKind.GoldChallengeCount,
    '10600259': AttributeKind.WoodChallengeCount,
    '10600260': AttributeKind.ExpChallengeCount,
    '10600261': AttributeKind.ChallengeDuration,
    '10600262': AttributeKind.ShiftDistance,
    '10600263': AttributeKind.SpawnRatePct,
    '10600264': AttributeKind.VertRefreshSR,
    '10600265': AttributeKind.VertRefreshSSR,
    '10600266': AttributeKind.BottleMaxStack,
    '10600267': AttributeKind.BlockDmg,
    '10600268': AttributeKind.StrGain.BASE,
    '10600269': AttributeKind.StrGain.BONUS,
    '10600270': AttributeKind.StrGain.PCT,
    '10600271': AttributeKind.StrGain.AMP,
    '10600272': AttributeKind.AgiGain.BASE,
    '10600273': AttributeKind.AgiGain.BONUS,
    '10600274': AttributeKind.AgiGain.PCT,
    '10600275': AttributeKind.AgiGain.AMP,
    '10600276': AttributeKind.IntGain.BASE,
    '10600277': AttributeKind.IntGain.BONUS,
    '10600278': AttributeKind.IntGain.PCT,
    '10600279': AttributeKind.IntGain.AMP,
    '10600280': AttributeKind.AtkGain.BASE,
    '10600281': AttributeKind.AtkGain.BONUS,
    '10600282': AttributeKind.AtkGain.PCT,
    '10600283': AttributeKind.AtkGain.AMP,
    '10600284': AttributeKind.AtkPureGain.BASE,
    '10600285': AttributeKind.AtkPureGain.BONUS,
    '10600286': AttributeKind.AtkPureGain.PCT,
    '10600287': AttributeKind.AtkPureGain.AMP,
    '10600288': AttributeKind.HpGain.BASE,
    '10600289': AttributeKind.HpGain.BONUS,
    '10600290': AttributeKind.HpGain.PCT,
    '10600291': AttributeKind.HpGain.AMP,
    '10600292': AttributeKind.PhyFixedGain.BASE,
    '10600293': AttributeKind.PhyFixedGain.BONUS,
    '10600294': AttributeKind.PhyFixedGain.PCT,
    '10600295': AttributeKind.PhyFixedGain.AMP,
    '10600296': AttributeKind.MgcFixedGain.BASE,
    '10600297': AttributeKind.MgcFixedGain.BONUS,
    '10600298': AttributeKind.MgcFixedGain.PCT,
    '10600299': AttributeKind.MgcFixedGain.AMP,
    '10600300': AttributeKind.KillGoldPct,
    '10600301': AttributeKind.KillWoodPct,
    '10600302': AttributeKind.KillKillPct,
    '10600303': AttributeKind.KillExpPct,
    '10600304': AttributeKind.GameShopDiscount,
    '10600305': AttributeKind.PerSecGameShopExp,
    '10600306': AttributeKind.BaseAtkDmg,
    '10600307': AttributeKind.ShadowArrowCount,
    '10600308': AttributeKind.ShadowArrowDmg,
    '10600309': AttributeKind.ShadowArrowCooldown,
    '10600310': AttributeKind.ShadowArrowAoeDmg,
    '10600311': AttributeKind.ShadowArrowAoeRadius,
    '10600312': AttributeKind.ShadowSecondaryArrowCount,
    '10600313': AttributeKind.ShadowSecondaryArrowDmg,
    '10600314': AttributeKind.GameShopRefreshCostReduce,
    '10600315': AttributeKind.WeaponStatsPct,
    '10600316': AttributeKind.BlazingArrowHitDmg,
    '10600317': AttributeKind.BlazingArrowBoomDmg,
    '10600318': AttributeKind.BlazingArrowDmg,
    '10600319': AttributeKind.BlazingArrowAoeRadius,
    '10600320': AttributeKind.BlazingArrowCooldown,
    '10600321': AttributeKind.BlazingArrowPenetrateCount,
    '10600322': AttributeKind.IceArrowDmg,
    '10600323': AttributeKind.IceArrowCount,
    '10600324': AttributeKind.IceArrowCleaveCount,
    '10600325': AttributeKind.IceArrowProjectSpd,
    '10600326': AttributeKind.SmallIceArrowDmg,
    '10600327': AttributeKind.SkyThunderDmg,
    '10600328': AttributeKind.MagneticStormDmg,
    '10600329': AttributeKind.MagneticStormRadius,
    '10600330': AttributeKind.EMFieldDmg,
    '10600331': AttributeKind.BlitzballDmg,
    '10600332': AttributeKind.SwordDmg,
    '10600333': AttributeKind.SwordProjectSpd,
    '10600334': AttributeKind.SwordScale,
    '10600335': AttributeKind.SwordCooldown,
    '10600336': AttributeKind.ArcaneLaserDmg,
    '10600337': AttributeKind.ArcaneLaserKeepTime,
    '10600338': AttributeKind.ArcaneLaserCooldown,
    '10600339': AttributeKind.ArcaneLaserRadius,
    '10600340': AttributeKind.ArcaneRayDmg,
    '10600341': AttributeKind.ArcaneRayKeepTime,
    '10600342': AttributeKind.ArcaneRayCount,
    '10600343': AttributeKind.FrostNovaDmg,
    '10600344': AttributeKind.FrostNovaRadius,
    '10600345': AttributeKind.FrostNovaCount,
    '10600346': AttributeKind.FrostNovaCooldown,
    '10600347': AttributeKind.IceArrowCooldown,
    '10600348': AttributeKind.LightningChainDmg,
    '10600349': AttributeKind.LightningChainCount,
    '10600350': AttributeKind.LonBlastingRadius,
    '10600351': AttributeKind.LonBlastingDmg,
    '10600352': AttributeKind.LightningChainCooldown,
    '10600353': AttributeKind.SkyThunderCooldown,
    '10600354': AttributeKind.EarthQuakeDmg,
    '10600355': AttributeKind.EarthQuakeRadius,
    '10600356': AttributeKind.EmbersDmg,
    '10600357': AttributeKind.TornadoDmg,
    '10600358': AttributeKind.TornadoKeepTime,
    '10600359': AttributeKind.TornadoRadius,
    '10600360': AttributeKind.TornadoMoveSpd,
    '10600361': AttributeKind.DianCiWangDmg,
    '10600362': AttributeKind.DianCiWangRadius,
    '10600363': AttributeKind.DianCiWangCooldown,
    '10600364': AttributeKind.MeteoriteDmg,
    '10600365': AttributeKind.MeteoriteCooldown,
    '10600366': AttributeKind.MeteoriteRadius,
    '10600367': AttributeKind.MeteoriteCount,
    '10600368': AttributeKind.MeteoriteFragmentsCount,
    '10600369': AttributeKind.FireBallDmg,
    '10600370': AttributeKind.FireBallKeepTime,
    '10600371': AttributeKind.FireBallRadius,
    '10600372': AttributeKind.FireBallMoveSpd,
    '10600373': AttributeKind.FireBallCount,
    '10600374': AttributeKind.BurntFrostDmg,
    '10600375': AttributeKind.HurricaneDmg,
    '10600376': AttributeKind.SmallHurricaneCount,
    '10600377': AttributeKind.VacuumDmg,
    '10600378': AttributeKind.Main.AMP_1,
    '10600379': AttributeKind.Secondary.AMP_1,
    '10600380': AttributeKind.AllStats.AMP_1,
    '10600381': AttributeKind.Strength.AMP_1,
    '10600382': AttributeKind.Agility.AMP_1,
    '10600383': AttributeKind.Intellect.AMP_1,
    '10600384': AttributeKind.Atk.AMP_1,
    '10600385': AttributeKind.AtkPure.AMP_1,
    '10600386': AttributeKind.PhyFixDmg.AMP_1,
    '10600387': AttributeKind.MgcFixDmg.AMP_1,
    '10600388': AttributeKind.HpLimit.AMP_1,
    '10600389': AttributeKind.Armor.AMP_1,
    '10600390': AttributeKind.GameShopRefreshInterval,
    '10600391': AttributeKind.HolyAbilitySpellRadius,
    '10600392': AttributeKind.NatureAbilitySpellRadius,
    '10600393': AttributeKind.FrostAbilitySpellRadius,
    '10600394': AttributeKind.FireAbilitySpellRadius,
    '10600395': AttributeKind.PhysicalAbilitySpellRadius,
    '10600396': AttributeKind.ShadowAbilitySpellRadius,
    '10600397': AttributeKind.HolyAbilityCooldown,
    '10600398': AttributeKind.NatureAbilityCooldown,
    '10600399': AttributeKind.FrostAbilityCooldown,
    '10600400': AttributeKind.FireAbilityCooldown,
    '10600401': AttributeKind.PhysicalAbilityCooldown,
    '10600402': AttributeKind.ShadowAbilityCooldown,
    '10600403': AttributeKind.HolyReduceResistPct,
    '10600404': AttributeKind.NatureReduceResistPct,
    '10600405': AttributeKind.FrostReduceResistPct,
    '10600406': AttributeKind.FireReduceResistPct,
    '10600407': AttributeKind.PhysicalReduceResistPct,
    '10600408': AttributeKind.ShadowReduceResistPct,
    '10600409': AttributeKind.MiningSpd,
    '10600410': AttributeKind.GameShopCostReduce,
    '10600411': AttributeKind.ArchiveDmg,
    '10600412': AttributeKind.ArchiveDmg.BASE,
    '10600413': AttributeKind.Main.AMP_2,
    '10600414': AttributeKind.Secondary.AMP_2,
    '10600415': AttributeKind.AllStats.AMP_2,
    '10600416': AttributeKind.Strength.AMP_2,
    '10600417': AttributeKind.Agility.AMP_2,
    '10600418': AttributeKind.Intellect.AMP_2,
    '10600419': AttributeKind.Atk.AMP_2,
    '10600420': AttributeKind.AtkPure.AMP_2,
    '10600421': AttributeKind.PhyFixDmg.AMP_2,
    '10600422': AttributeKind.MgcFixDmg.AMP_2,
    '10600423': AttributeKind.HpLimit.AMP_2,
    '10600424': AttributeKind.Armor.AMP_2,
    '10600425': AttributeKind.ShadowArrowPenetrateCount,
    '10600426': AttributeKind.IceArrowPenetrateCount,
    '10600427': AttributeKind.HurricanePenetrateCount,
    '10600428': AttributeKind.ThunderDmgFactor,
    '10600429': AttributeKind.ArcaneRayCooldown,
    '10600430': AttributeKind.LightningBounceCount,
    '10600431': AttributeKind.EarthquakeCooldown,
    '10600432': AttributeKind.TornadoCooldown,
    '10600433': AttributeKind.HurricaneCooldown,
    '10600434': AttributeKind.FireballDuration,
    '10600435': AttributeKind.FireballCooldown,
    '10600436': AttributeKind.ArcaneRayRange,
    '10600437': AttributeKind.HpRegen.OVERRIDE,
    '10600438': AttributeKind.MpRegen.OVERRIDE,
    '10600439': AttributeKind.Armor.OVERRIDE,
    '10600440': AttributeKind.FinalDamageCalculation,
    '10600441': AttributeKind.Main.AMP_3,
    '10600442': AttributeKind.Secondary.AMP_3,
    '10600443': AttributeKind.AllStats.AMP_3,
    '10600444': AttributeKind.Strength.AMP_3,
    '10600445': AttributeKind.Agility.AMP_3,
    '10600446': AttributeKind.Intellect.AMP_3,
    '10600447': AttributeKind.Atk.AMP_3,
    '10600448': AttributeKind.AtkPure.AMP_3,
    '10600449': AttributeKind.PhyFixDmg.AMP_3,
    '10600450': AttributeKind.MgcFixDmg.AMP_3,
    '10600451': AttributeKind.HpLimit.AMP_3,
    '10600452': AttributeKind.Armor.AMP_3,
    '10600453': AttributeKind.StrGain.AMP_3,
    '10600454': AttributeKind.AgiGain.AMP_3,
    '10600455': AttributeKind.IntGain.AMP_3,
    '10600456': AttributeKind.AtkGain.AMP_3,
    '10600457': AttributeKind.PhyFixedGain.AMP_3,
    '10600458': AttributeKind.MgcFixedGain.AMP_3,
    '10600459': AttributeKind.HpGain.AMP_3,
    '10600460': AttributeKind.PhyCritDmg.AMP,
    '10600461': AttributeKind.MgcCritDmg.AMP,
    '10600462': AttributeKind.CreepDmg.AMP,
    '10600463': AttributeKind.EliteDmg.AMP,
    '10600464': AttributeKind.ChallengeDmg.AMP,
    '10600465': AttributeKind.BossDmg.AMP,
    '10600466': AttributeKind.AtkDmg.AMP,
    '10600467': AttributeKind.AbltDmg.AMP,
    '10600468': AttributeKind.PhyDmg.AMP,
    '10600469': AttributeKind.MgcDmg.AMP,
    '10600470': AttributeKind.PureDmg.AMP,
    '10600471': AttributeKind.HolyDmg.AMP,
    '10600472': AttributeKind.NatureDmg.AMP,
    '10600473': AttributeKind.FrostDmg.AMP,
    '10600474': AttributeKind.FireDmg.AMP,
    '10600475': AttributeKind.PhysicalDmg.AMP,
    '10600476': AttributeKind.ShadowDmg.AMP,
    '10600477': AttributeKind.FinalDamageCalculation1,
    '10600478': AttributeKind.HolyDmg.AMP2,
    '10600479': AttributeKind.NatureDmg.AMP2,
    '10600480': AttributeKind.FrostDmg.AMP2,
    '10600481': AttributeKind.FireDmg.AMP2,
    '10600482': AttributeKind.PhysicalDmg.AMP2,
    '10600483': AttributeKind.ShadowDmg.AMP2,
    '10600484': AttributeKind.FinalHpRegen,
    '10600485': AttributeKind.AtkSpd.TOTAL,
    '10600486': AttributeKind.DmgAmp,
    '10600487': AttributeKind.AllDmg.AMP,
    '10600488': AttributeKind.FinalAllDmg,
    '10600489': AttributeKind.FinalPhyDmg,
    '10600490': AttributeKind.FinalMagDmg,
    '10600492': AttributeKind.ArcaneLaserCount,
    '10600493': AttributeKind.DianCiWangFixRadius,
    '10600494': AttributeKind.Main.AMP_4,
    '10600495': AttributeKind.Secondary.AMP_4,
    '10600496': AttributeKind.AllStats.AMP_4,
    '10600497': AttributeKind.Strength.AMP_4,
    '10600498': AttributeKind.Agility.AMP_4,
    '10600499': AttributeKind.Intellect.AMP_4,
    '10600500': AttributeKind.Atk.AMP_4,
    '10600501': AttributeKind.PhyFixDmg.AMP_4,
    '10600502': AttributeKind.MgcFixDmg.AMP_4,
    '10600503': AttributeKind.AtkPure.AMP_4,
    '10600504': AttributeKind.HpLimit.AMP_4,
    '10600505': AttributeKind.Armor.AMP_4,
    '10600506': AttributeKind.PhyCritDmg.AMP_1,
    '10600507': AttributeKind.MgcCritDmg.AMP_1,
    '10600508': AttributeKind.PureCritDmg.AMP_1,
    '10600509': AttributeKind.CreepDmg.AMP_1,
    '10600510': AttributeKind.EliteDmg.AMP_1,
    '10600511': AttributeKind.ChallengeDmg.AMP_1,
    '10600512': AttributeKind.BossDmg.AMP_1,
    '10600513': AttributeKind.ArchiveDmg.AMP_1,
    '10600514': AttributeKind.AtkDmg.AMP_1,
    '10600515': AttributeKind.AbltDmg.AMP_1,
    '10600516': AttributeKind.PhyDmg.AMP_1,
    '10600517': AttributeKind.MgcDmg.AMP_1,
    '10600518': AttributeKind.PureDmg.AMP_1,
    '10600519': AttributeKind.AllDmg.AMP_1,
    '10600520': AttributeKind.DmgFinal.AMP_1,
    '10600521': AttributeKind.HolyDmg.AMP_1,
    '10600522': AttributeKind.NatureDmg.AMP_1,
    '10600523': AttributeKind.FrostDmg.AMP_1,
    '10600524': AttributeKind.FireDmg.AMP_1,
    '10600525': AttributeKind.PhysicalDmg.AMP_1,
    '10600526': AttributeKind.ShadowDmg.AMP_1,
    '10600527': AttributeKind.HolyRairty,
    '10600528': AttributeKind.HolyAbilityLevel,
    '10600529': AttributeKind.NatureAbilityLevel,
    '10600530': AttributeKind.FrostAbilityLevel,
    '10600531': AttributeKind.FireAbilityLevel,
    '10600532': AttributeKind.PhysicalAbilityLevel,
    '10600533': AttributeKind.ShadowAbilityLevel
  };

  function ReplaceAbltSpecialVals(sAblt, s, iLevel = 1, bCurLevelSpecial = false, options) {
    var _a;
    const tKv = (_a = AbilitiesKv[sAblt]) !== null && _a !== void 0 ? _a : ItemsKv[sAblt];
    if (!tKv || tKv.AbilityValues == undefined) return s;
    let tAbilityValues = tKv.AbilityValues;
    s = ReplaceTextVariable(s, tAbilityValues, options);
    for (const sKey in tAbilityValues) {
      let tVals = String(tAbilityValues[sKey]).split(' ');
      let s2 = '';
      if (bCurLevelSpecial) {
        let sVal = tVals[Math.min(iLevel - 1, tVals.length - 1)];
        s2 = SpanText(`${sVal}%`, 'CurLvl');
      } else {
        for (let i = 0; i < tVals.length; ++i) {
          const iLevel2 = i + 1;
          if (iLevel2 == iLevel || iLevel2 == tVals.length && tVals.length < iLevel) {
            s2 += SpanText(tVals[i] + '%', 'CurLvl') + ' / ';
          } else {
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
      } else {
        for (let i = 0; i < tVals.length; ++i) {
          const iLevel2 = i + 1;
          if (iLevel2 == iLevel || iLevel2 == tVals.length && tVals.length < iLevel) {
            s2 += SpanText(tVals[i], 'CurLvl') + ' / ';
          } else {
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
  function ReplaceAbltVals(sAblt, s, options) {
    var _a, _b, _c;
    const tKv = (_a = AbilitiesKv[sAblt]) !== null && _a !== void 0 ? _a : ItemsKv[sAblt];
    if (!tKv) return s;
    options = options !== null && options !== void 0 ? options : {};
    const iEntID = (_b = options.entid) !== null && _b !== void 0 ? _b : Players.GetPlayerHeroEntityIndex(GameUI.CustomUIConfig().tools.Player.FocusPlayer());
    const iLevel = Math.max(1, (_c = options.level) !== null && _c !== void 0 ? _c : 1);
    s = ReplaceAbltSpecialVals(sAblt, s, iLevel, true, options);
    const bCount = options.count && iEntID != -1;
    let isEscape = i => {
      if (--i > 0) if (s[i] == '\\') return !isEscape(i);
      return false;
    };
    let i;
    while (-1 != (i = s.indexOf('[', i))) {
      if (isEscape(i)) {
        ++i;
        continue;
      }
      options.has_more_info = true;
      let i2 = s.indexOf(']', i + 1);
      if (-1 == i2) break;
      let sReplace = s.substring(i + 1, i2);
      let sReplace2 = NoHtmlText(sReplace);
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
          } else {
            sReplace2 = String(parseFloat(f.toFixed(2)));
          }
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(new Error(`Replace ability vaules text error, name is ${sAblt}`));
        }
        sReplace2 = FormatNumber(sReplace2);
        sReplace2 = SpanText(sReplace2, 'AbilityValues');
        sReplace2 = SpanText(sReplace2, 'Count');
        s = s.substring(0, i) + sReplace2 + s.substring(i2 + 1);
        i += sReplace2.length + 1;
      } else {
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
      } else {
        return $.Localize('#' + id);
      }
    }
    if (s == 'ablt_lvl') {
      if (bCount) {
        if (undefined != iLevel && iLevel > 0) {
          return iLevel;
        } else if (-1 != iEntID) {
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

  function Yzy_ItemImage(params) {
    const [local, props] = splitProps(params, ['name', 'image', 'rarity', 'children']);
    const getKv = () => AbilitiesKv[local.name];
    const getItemImage = () => {
      return local.image || `file://{images}/custom_game/items/${local.name}.png`;
    };
    const getRarity = () => {
      var _a;
      return local.rarity || ((_a = getKv()) === null || _a === void 0 ? void 0 : _a.Rarity) || 0;
    };
    return (() => {
      const _el$18 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_ItemImage', `Rarity_${getRarity()}`, props.class, props.className);
          }
        }), null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$18);
        const _el$20 = createElement("Image", {
          "class": "ItemImage",
          get src() {
            return getItemImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$18);
      spread(_el$18, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ItemImage', `Rarity_${getRarity()}`, props.class, props.className);
        },
        "onmouseover": p => {
          var _a;
          (_a = props === null || props === void 0 ? void 0 : props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
        },
        "onmouseout": p => {
          var _a;
          (_a = props === null || props === void 0 ? void 0 : props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
        },
        "onactivate": p => {
          var _a;
          (_a = props === null || props === void 0 ? void 0 : props.onactivate) === null || _a === void 0 ? void 0 : _a.call(props, p);
        }
      }), true);
      insert(_el$18, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      effect(_$p => setProp(_el$20, "src", getItemImage(), _$p));
      return _el$18;
    })();
  }
  function Yzy_ItemName(params) {
    const [local, props] = splitProps(params, ['name', 'rarity', 'text', 'children']);
    const getKv = () => AbilitiesKv[local.name];
    const getItemName = () => {
      if (local.text) {
        return local.text;
      }
      return $.Localize('#' + local.name);
    };
    const getRarity = () => {
      var _a;
      return local.rarity || ((_a = getKv()) === null || _a === void 0 ? void 0 : _a.Rarity) || 0;
    };
    return createComponent(Yzy_Label, mergeProps(props, {
      html: true,
      get ["class"]() {
        return classNames('Yzy_ItemName', `Rarity_${getRarity()}`, props.class, props.className);
      },
      get text() {
        return getItemName();
      },
      get rarity() {
        return getRarity();
      }
    }));
  }
  function Yzy_Label(params) {
    var _a;
    const [local, props] = splitProps(params, ['rarity', 'text']);
    return (() => {
      const _el$24 = createElement("Label", mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Label", (_a = local.rarity) !== null && _a !== void 0 ? _a : 'Rarity_' + local.rarity, props.class, props.className);
        },
        get text() {
          return local.text;
        },
        hittest: false
      }), null);
      spread(_el$24, mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Label", (_a = local.rarity) !== null && _a !== void 0 ? _a : 'Rarity_' + local.rarity, props.class, props.className);
        },
        get text() {
          return local.text;
        },
        "hittest": false
      }), false);
      return _el$24;
    })();
  }

  function ShowMouseTip(msg, sType = 'normal') {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseTip', {
      msg: msg,
      type: sType
    });
  }
  function HideMouseTip() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseTip', undefined);
  }

  class item_gameplay_base {
    static GetItem(tItem) {
      if (NetEventData.GetTableValue('gameplay_item', tItem.uid) == undefined) return;
      if (this.tInstances[tItem.uid]) {
        this.tInstances[tItem.uid].tItem = tItem;
        return this.tInstances[tItem.uid];
      }
      const tKv = KvByID(tItem.id);
      if (tKv) {
        const sName = tKv['name'];
        if (this.tClasses[sName]) {
          return new this.tClasses[sName](tItem);
        }
      }
      if (this.tClasses['item_' + tItem.type]) {
        return new this.tClasses['item_' + tItem.type](tItem);
      }
      return new this(tItem);
    }
    static GetCastHelperItem() {
      return this.signCastHelperItem[0]();
    }
    static SetCastHelperItem(hItem) {
      this.signCastHelperItem[1](hItem);
    }
    static Init() {
      NetEventData.Bind('gameplay_item', '', (tItem, uid) => {
        if (tItem == undefined && this.tInstances[uid]) {
          this.tInstances[uid].Destroy();
        }
      }, 'item_gameplay_base');
    }
    constructor(tItem) {
      item_gameplay_base.tInstances[tItem.uid] = this;
      this.tItem = tItem;
    }
    onactivate(p) {
      this.startCast();
    }
    ondblclick(p) {}
    startCast(params) {
      this.tCastParams = params;
      const iOwnerEntID = this.GetOwnerEntID();
      const iPlayerID = Player_EntityToID(iOwnerEntID);
      if (Players.IsValidPlayerID(iPlayerID) && iPlayerID != Players.GetLocalPlayer()) return;
      const iBehavior = this.GetBehavior();
      if ((iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) > 0) {
        return;
      }
      if ((iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) > 0 || (iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT) > 0) {
        this.enableCastHelper({
          'target_cast': (iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) > 0,
          'point_cast': (iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_POINT) > 0
        });
        return;
      }
      if ((iBehavior & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET) > 0) {
        this.tCastResult = {
          'result': this.CastFilterResult(this.tCastParams)
        };
        this.onCastHelperTrigger();
      }
    }
    enableCastHelper(params) {
      var _a;
      const iCaster = this.GetCaster();
      item_gameplay_base.SetCastHelperItem(this);
      this.tCastResult = undefined;
      (_a = this.pRoot) === null || _a === void 0 ? void 0 : _a.AddClass('CastHelper_Casting');
      if (params.no_particle !== true) {
        const iLineParticle = Particles.CreateParticle("particles/ui_mouseactions/range_finder_generic_aoe.vpcf", ParticleAttachment_t.PATTACH_CUSTOMORIGIN, 0);
        Particles.SetParticleControlEnt(iLineParticle, 0, iCaster, ParticleAttachment_t.PATTACH_POINT_FOLLOW, '', Entities.GetAbsOrigin(iCaster), false);
        Particles.SetParticleControlEnt(iLineParticle, 1, iCaster, ParticleAttachment_t.PATTACH_POINT_FOLLOW, '', Entities.GetAbsOrigin(iCaster), false);
        this.enableCastHelper['iLineParticle'] = iLineParticle;
      }
      let sCastTip = $.Localize(`#DOTA_TOOLTIP_ability_${this.GetName()}_CastTip`);
      if (sCastTip == `#DOTA_TOOLTIP_ability_${this.GetName()}_CastTip`) {
        sCastTip = undefined;
      } else {
        ShowMouseTip(sCastTip);
      }
      Timer(() => {
        var _a;
        let sLastError = (_a = this.tCastResult) === null || _a === void 0 ? void 0 : _a.result;
        this.tCastResult = undefined;
        if (this.pRoot != undefined && !this.pRoot.IsValid()) {
          this.disableCastHelper();
          return;
        }
        if (params.target_cast && item_gameplay_base.tMouseoverItem) {
          this.tCastResult = {
            'item': item_gameplay_base.tMouseoverItem,
            'result': this.CastFilterResultItem(item_gameplay_base.tMouseoverItem, this.tCastParams)
          };
        }
        const vMousePos = GameUI.GetCursorPosition();
        const vWorldPos = GameUI.GetScreenWorldPosition(vMousePos);
        if (vWorldPos) {
          if (this.enableCastHelper['iLineParticle']) {
            Particles.SetParticleControl(this.enableCastHelper['iLineParticle'], 2, vWorldPos);
          }
          if (this.tCastResult == undefined) {
            if (params.target_cast && !item_gameplay_base.tMouseoverItem) {
              const tTargets = GameUI.FindScreenEntities(GameUI.GetCursorPosition());
              for (const t of tTargets) {
                if (t.accurateCollision) {
                  this.tCastResult = {
                    'target': t.entityIndex,
                    'result': this.CastFilterResultTarget(t.entityIndex, this.tCastParams)
                  };
                  break;
                }
              }
              if (this.tCastResult == undefined) {
                for (const t of tTargets) {
                  if (!t.accurateCollision) {
                    this.tCastResult = {
                      'target': t.entityIndex,
                      'result': this.CastFilterResultTarget(t.entityIndex, this.tCastParams)
                    };
                    break;
                  }
                }
              }
            }
            if (this.tCastResult == undefined && params.point_cast) {
              this.tCastResult = {
                'point': vWorldPos,
                'result': this.CastFilterResultLocation(vWorldPos, this.tCastParams)
              };
            }
          }
        }
        if (this.tCastResult && typeof this.tCastResult.result == 'string') {
          if (sLastError != this.tCastResult.result) {
            ShowMouseTip('#' + this.tCastResult.result, 'error');
          }
        } else if (sCastTip) {
          ShowMouseTip(sCastTip, this.tCastResult == undefined ? 'normal' : this.tCastResult.result === true ? 'pass' : 'error');
        } else if (typeof sLastError == 'string') {
          HideMouseTip();
        }
        return 0;
      }, 0, 'gameplay_cast_help');
      Mousebinds.Bind((sEvent, iBtnNum, tExtraData, typeEvent, typeBtn) => {
        if (typeBtn == 64) {
          this.onCastHelperTrigger();
        } else {
          this.disableCastHelper();
        }
        return true;
      }, 64 + 128, 'gameplay_cast_help');
    }
    disableCastHelper() {
      var _a;
      item_gameplay_base.SetCastHelperItem(undefined);
      if ((_a = this.pRoot) === null || _a === void 0 ? void 0 : _a.IsValid()) {
        this.pRoot.RemoveClass('CastHelper_Casting');
        this.pRoot = undefined;
      }
      HideMouseTip();
      if (this.enableCastHelper['iLineParticle']) {
        Particles.DestroyParticleEffect(this.enableCastHelper['iLineParticle'], false);
        delete this.enableCastHelper['iLineParticle'];
      }
      StopTimer('gameplay_cast_help');
      Mousebinds.Unbind('gameplay_cast_help');
    }
    onCastHelperTrigger() {
      var _a;
      if (this.tCastResult) {
        if (this.tCastResult.result === true) {
          if (this.OnAbilityPhaseStart()) {
            Request('GameplayItem_ItemCast', {
              'item': this.tItem.uid,
              'item_target': (_a = this.tCastResult.item) === null || _a === void 0 ? void 0 : _a.uid,
              'unit_target': this.tCastResult.target,
              'point_target': this.tCastResult.point ? VectorToString(this.tCastResult.point) : undefined,
              'params': this.tCastParams
            }).then(res => {
              if (res == undefined) return;
              if (res.code !== 0 && res.msg) {
                ErrorMsg(res.msg);
                return;
              }
              this.OnSpellStart(res.data);
              delete this.tCastParams;
            }).catch(err => {
              ErrorMsg(err);
            });
          }
        } else if (this.tCastResult.result) {
          ErrorMsg(this.tCastResult.result);
        }
      }
      this.disableCastHelper();
    }
    Destroy() {
      if (item_gameplay_base.GetCastHelperItem() == this) {
        this.disableCastHelper();
      }
      this.OnDestroy();
      delete item_gameplay_base.tInstances[this.tItem.uid];
    }
    __call(sFunc, sParams, process) {
      var _a;
      return runlua(`
        local h = item_gameplay_base:GetItem(json.decode('${JSON.stringify(this.tItem)}'))
        if h then
            ${(_a = process === null || process === void 0 ? void 0 : process('h')) !== null && _a !== void 0 ? _a : ''}
            return h:${sFunc}(${sParams})
        end
        `);
    }
    __process_SetCaster(handle) {
      return `
        ${handle}.tCastResult={caster=EntIndexToHScript(${this.GetCaster()})}
        `;
    }
    GetKv() {
      return KvByID(this.tItem.id);
    }
    GetName() {
      return KvByID(this.tItem.id)['name'];
    }
    GetBehavior() {
      var _a;
      return (_a = this.__call('GetBehavior', '')) !== null && _a !== void 0 ? _a : 0;
    }
    GetCursorTarget() {
      if (this.tCastResult) return this.tCastResult.target;
    }
    GetCursorPosition() {
      if (this.tCastResult) return this.tCastResult.point;
    }
    GetCursorItem() {
      if (this.tCastResult) return this.tCastResult.item;
    }
    CastFilterResult(params) {
      var _a, _b;
      if (params) (_a = this.__call('CastFilterResult', `json.decode('${JSON.stringify(params !== null && params !== void 0 ? params : '')}')`, h => this.__process_SetCaster(h))) !== null && _a !== void 0 ? _a : false;
      return (_b = this.__call('CastFilterResult', '', h => this.__process_SetCaster(h))) !== null && _b !== void 0 ? _b : false;
    }
    CastFilterResultLocation(vLocation, params) {
      var _a, _b;
      if (params) return (_a = this.__call('CastFilterResultLocation', `Vector(${vLocation[0]},${vLocation[1]},${vLocation[2]}),json.decode('${JSON.stringify(params !== null && params !== void 0 ? params : '')}')`, h => this.__process_SetCaster(h))) !== null && _a !== void 0 ? _a : false;
      return (_b = this.__call('CastFilterResultLocation', `Vector(${vLocation[0]},${vLocation[1]},${vLocation[2]})`, h => this.__process_SetCaster(h))) !== null && _b !== void 0 ? _b : false;
    }
    CastFilterResultTarget(iTargetEntID, params) {
      var _a, _b;
      if (params) return (_a = this.__call('CastFilterResultTarget', `EntIndexToHScript(${iTargetEntID}),json.decode('${JSON.stringify(params !== null && params !== void 0 ? params : '')}')`, h => this.__process_SetCaster(h))) !== null && _a !== void 0 ? _a : false;
      return (_b = this.__call('CastFilterResultTarget', `EntIndexToHScript(${iTargetEntID})`, h => this.__process_SetCaster(h))) !== null && _b !== void 0 ? _b : false;
    }
    CastFilterResultItem(tItem, params) {
      var _a, _b;
      if (params) return (_a = this.__call('CastFilterResultItem', `json.decode('${JSON.stringify(tItem)}'),json.decode('${JSON.stringify(params !== null && params !== void 0 ? params : '')}')`, h => this.__process_SetCaster(h))) !== null && _a !== void 0 ? _a : false;
      return (_b = this.__call('CastFilterResultItem', `json.decode('${JSON.stringify(tItem)}')`, h => this.__process_SetCaster(h))) !== null && _b !== void 0 ? _b : false;
    }
    GetOwnerEntID() {
      if (this.tItem.entid != undefined) {
        return this.tItem.entid;
      }
      if (this.tItem.pid != undefined) {
        return Players.GetPlayerHeroEntityIndex(this.tItem.pid);
      }
      return -1;
    }
    GetCaster() {
      let i = this.GetOwnerEntID();
      if (i == -1) return Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
      return i;
    }
    OnAbilityPhaseStart() {
      return true;
    }
    OnSpellStart(params) {}
    OnDestroy() {}
  }
  item_gameplay_base.tClasses = {};
  item_gameplay_base.tInstances = {};
  item_gameplay_base.signCastHelperItem = createSignal();
  item_gameplay_base.Init();

  function CooldownPanel(props) {
    var _a, _b, _c, _d, _e;
    const getEnd = typeof props.fEnd == 'function' ? props.fEnd : () => props.fEnd;
    const getCD = typeof props.fCD == 'function' ? props.fCD : () => props.fCD;
    const iRound = (_a = props.iRound) !== null && _a !== void 0 ? _a : 0;
    const bShine = (_b = props.bShine) !== null && _b !== void 0 ? _b : true;
    createEffect(() => {
      let fEnd = getEnd();
      let fCd = getCD();
      if (fEnd == undefined) return;
      if (fCd == undefined || fCd <= 0) return;
      const id = Timer(() => {
        var _a;
        let f = fEnd - Game.GetGameTime();
        if (props.ref && props.ref.IsValid()) {
          if (f > 0) {
            props.ref.GetChild(0).style.clip = `radial( 50% 50%, 0deg, ${(-360 * f / fCd || 0).toFixed(2)}deg)`;
            props.ref.GetChild(1).text = String(Math.ceil(f * (10 * iRound || 1)) / (10 * iRound || 1));
            props.ref.AddClass('Cooling');
          } else {
            props.ref.GetChild(0).style.clip = 'radial( 50% 50%, 0deg, -360deg)';
            props.ref.RemoveClass('Cooling');
            if (bShine) {
              const pShineRoot = $.CreatePanel('Panel', props.ref, 'ShineRoot');
              render(() => createComponent(Shine, {}), pShineRoot);
            }
            (_a = props.callback) === null || _a === void 0 ? void 0 : _a.call(props, props.ref);
            return;
          }
        }
        return 0.1;
      }, 0, undefined, 'CooldownPanel');
      onCleanup(() => {
        var _a;
        StopTimer(id);
        if ((_a = props.ref) === null || _a === void 0 ? void 0 : _a.IsValid()) {
          const pShineRoot = props.ref.FindChild('ShineRoot');
          if (pShineRoot === null || pShineRoot === void 0 ? void 0 : pShineRoot.IsValid()) {
            render(() => [], pShineRoot);
            pShineRoot.DeleteAsync(0);
          }
        }
      });
    });
    return (() => {
      const _el$ = createElement("Panel", mergeProps(() => splitProps(props, ['ref'])[1]), null),
        _el$2 = createElement("Panel", {
          id: "BG",
          get style() {
            return {
              clip: `radial( 50% 50%, 0deg, ${(getCD() == undefined || getCD() <= 0 ? iRound : -360 * ((_c = getEnd()) !== null && _c !== void 0 ? _c : 0 - Game.GetGameTime()) / ((_d = getCD()) !== null && _d !== void 0 ? _d : 1) || 0).toFixed(2)}deg)`
            };
          },
          hittest: false
        }, _el$),
        _el$3 = createElement("Label", {
          get text() {
            return Math.ceil(((_e = getCD()) !== null && _e !== void 0 ? _e : 0) * (10 * iRound || 1)) / (10 * iRound || 1);
          },
          hittest: false
        }, _el$);
      const _ref$ = props.ref;
      typeof _ref$ === "function" ? use(_ref$, _el$) : props.ref = _el$;
      spread(_el$, mergeProps(() => splitProps(props, ['ref'])[1], {
        get classList() {
          return Object.assign({
            "CooldownPanel": true,
            Cooling: getEnd() != undefined && getEnd() > Game.GetGameTime()
          }, props.classList);
        }
      }), true);
      effect(_p$ => {
        const _v$ = {
            clip: `radial( 50% 50%, 0deg, ${(getCD() == undefined || getCD() <= 0 ? iRound : -360 * ((_c = getEnd()) !== null && _c !== void 0 ? _c : 0 - Game.GetGameTime()) / ((_d = getCD()) !== null && _d !== void 0 ? _d : 1) || 0).toFixed(2)}deg)`
          },
          _v$2 = Math.ceil(((_e = getCD()) !== null && _e !== void 0 ? _e : 0) * (10 * iRound || 1)) / (10 * iRound || 1);
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$2, "style", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$3, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }
  function Shine() {
    let timer;
    onCleanup(() => {
      if (timer != undefined) {
        StopTimer(timer);
      }
    });
    return (() => {
      const _el$4 = createElement("Panel", {
          hittest: false
        }, null),
        _el$5 = createElement("Panel", {
          hittest: false
        }, _el$4);
      setProp(_el$4, "className", "CooldownShine");
      setProp(_el$5, "onload", p => {
        p.style.transform = 'translateX(50%) translateY(-50%)';
        timer = Timer(() => {
          if (p.IsValid()) {
            const pParent = p.GetParent().GetParent();
            render(() => [], pParent);
            pParent.style.opacity = '0';
            timer = Timer(() => {
              if (pParent.IsValid()) {
                pParent.DeleteAsync(0);
              }
            }, 1, 'CooldownShine');
          }
        }, 0.4, undefined, 'CooldownShine');
      });
      return _el$4;
    })();
  }

  const getter_iSelectUnit = useSelectUnit();

  function CountDown(props) {
    var _a, _b;
    const getTimeEnd = typeof props.fTimeEnd == 'function' ? props.fTimeEnd : () => props.fTimeEnd;
    const getRound = typeof props.iRound == 'function' ? props.iRound : () => {
      var _a;
      return (_a = props.iRound) !== null && _a !== void 0 ? _a : 0;
    };
    const getInterval = typeof props.fInterval == 'function' ? props.fInterval : () => {
      var _a;
      return (_a = props.fInterval) !== null && _a !== void 0 ? _a : 1;
    };
    const sTimeDialogVariable = (_a = props.sTimeDialogVariable) !== null && _a !== void 0 ? _a : 'countdown_time';
    const funcGetTime = (_b = props.funcGetTime) !== null && _b !== void 0 ? _b : () => Game.GetGameTime();
    createEffect(() => {
      let fDuration = 0;
      if (undefined == getTimeEnd()) {
        if (props.ref) {
          props.ref.SetDialogVariable(sTimeDialogVariable, '∞');
          props.ref.SetHasClass('Finished', false);
          props.ref.SetHasClass('Urgent', false);
        }
      } else {
        const id = Timer(() => {
          var _a;
          fDuration = Math.max(0, getTimeEnd() - funcGetTime());
          if (props.onUpdate == undefined || props.onUpdate(props.ref, fDuration) !== false) {
            if (props.ref) {
              if (props.tFormatCfg) {
                props.ref.SetDialogVariable(sTimeDialogVariable, FormatTime(fDuration, props.tFormatCfg));
              } else if (props.funcFormat) {
                props.ref.SetDialogVariable(sTimeDialogVariable, props.funcFormat(fDuration));
              } else {
                props.ref.SetDialogVariable(sTimeDialogVariable, fDuration.toFixed(getRound()));
              }
              props.ref.SetHasClass('Finished', fDuration <= 0);
              props.ref.SetHasClass('Urgent', props.fTimeUrgent != undefined && fDuration <= props.fTimeUrgent);
              if (props.sUrgentSound && props.fTimeUrgent && !Game.IsGamePaused() && fDuration <= props.fTimeUrgent) {
                Game.EmitSound(typeof props.sUrgentSound == 'function' ? props.sUrgentSound(props.ref) : props.sUrgentSound);
              }
            }
          }
          if (fDuration > 0) {
            return getInterval();
          }
          (_a = props.onOver) === null || _a === void 0 ? void 0 : _a.call(props, props.ref);
        }, -1, undefined, 'CountDown');
        onCleanup(() => {
          StopTimer(id);
        });
      }
    });
    return (() => {
      const _el$ = createElement("Panel", mergeProps(() => splitProps(props, ['ref'])[1]), null);
      const _ref$ = props.ref;
      typeof _ref$ === "function" ? use(_ref$, _el$) : props.ref = _el$;
      spread(_el$, mergeProps(() => splitProps(props, ['ref'])[1], {
        get classList() {
          return Object.assign({
            "CountDown": true
          }, props.classList);
        }
      }), false);
      return _el$;
    })();
  }
  function CountUp(props) {
    var _a, _b;
    const getTimeStart = typeof props.fTimeStart == 'function' ? props.fTimeStart : () => props.fTimeStart;
    const getRound = typeof props.iRound == 'function' ? props.iRound : () => {
      var _a;
      return (_a = props.iRound) !== null && _a !== void 0 ? _a : 0;
    };
    const getInterval = typeof props.fInterval == 'function' ? props.fInterval : () => {
      var _a;
      return (_a = props.fInterval) !== null && _a !== void 0 ? _a : 1;
    };
    const sTimeDialogVariable = (_a = props.sTimeDialogVariable) !== null && _a !== void 0 ? _a : 'countdown_time';
    const funcGetTime = (_b = props.funcGetTime) !== null && _b !== void 0 ? _b : () => Game.GetGameTime();
    createEffect(() => {
      let fDuration = 0;
      if (undefined == getTimeStart()) {
        if (props.ref) {
          props.ref.SetDialogVariable(sTimeDialogVariable, '∞');
        }
      } else {
        const id = Timer(() => {
          fDuration = Math.max(0, funcGetTime() - getTimeStart());
          if (props.onUpdate == undefined || props.onUpdate(props.ref, fDuration) !== false) {
            if (props.ref) {
              if (props.tFormatCfg) {
                props.ref.SetDialogVariable(sTimeDialogVariable, FormatTime(fDuration, props.tFormatCfg));
              } else if (props.funcFormat) {
                props.ref.SetDialogVariable(sTimeDialogVariable, props.funcFormat(fDuration));
              } else {
                props.ref.SetDialogVariable(sTimeDialogVariable, fDuration.toFixed(getRound()));
              }
            }
          }
          if (fDuration > 0) {
            return getInterval();
          }
        }, -1, undefined, 'CountUp');
        onCleanup(() => {
          StopTimer(id);
        });
      }
    });
    return (() => {
      const _el$2 = createElement("Panel", mergeProps(() => splitProps(props, ['ref'])[1]), null);
      const _ref$2 = props.ref;
      typeof _ref$2 === "function" ? use(_ref$2, _el$2) : props.ref = _el$2;
      spread(_el$2, mergeProps(() => splitProps(props, ['ref'])[1], {
        get classList() {
          return Object.assign({
            "CountUp": true
          }, props.classList);
        }
      }), false);
      return _el$2;
    })();
  }

  function GameplayItem(props) {
    var _a, _b, _c;
    const getter = PropsGetter(props);
    const getItemID = () => {
      var _a, _b, _c, _d;
      return (_b = (_a = getter.item_id) === null || _a === void 0 ? void 0 : _a.call(getter)) !== null && _b !== void 0 ? _b : (_d = (_c = getter.item) === null || _c === void 0 ? void 0 : _c.call(getter)) === null || _d === void 0 ? void 0 : _d.id;
    };
    const getKv = () => getItemID() != undefined ? KvByID(getItemID()) : undefined;
    const getHeadID = () => {
      var _a;
      return String((_a = getItemID()) !== null && _a !== void 0 ? _a : '').substring(0, 3);
    };
    const getType = () => {
      var _a, _b, _c, _d;
      return (_c = (_b = (_a = getter.item) === null || _a === void 0 ? void 0 : _a.call(getter)) === null || _b === void 0 ? void 0 : _b.type) !== null && _c !== void 0 ? _c : (_d = getKv()) === null || _d === void 0 ? void 0 : _d['ItemLabel'];
    };
    const getName = () => {
      var _a, _b, _c;
      return (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['name']) !== null && _b !== void 0 ? _b : (_c = getKv()) === null || _c === void 0 ? void 0 : _c['UnitName'];
    };
    const [isNotMana, setNotCast] = createSignal(false);
    const getEndTime = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getter.item) === null || _a === void 0 ? void 0 : _a.call(getter)) === null || _b === void 0 ? void 0 : _b.cd_end;
    });
    const getCountDown = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getter.item) === null || _a === void 0 ? void 0 : _a.call(getter)) === null || _b === void 0 ? void 0 : _b.countdown;
    });
    const getCountUp = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getter.item) === null || _a === void 0 ? void 0 : _a.call(getter)) === null || _b === void 0 ? void 0 : _b.countup;
    });
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) !== null && _b !== void 0 ? _b : 0;
    };
    const [ref, setRef] = createSignal();
    const getItemClass = createMemo(() => {
      var _a;
      const tItem = (_a = getter.item) === null || _a === void 0 ? void 0 : _a.call(getter);
      if (tItem) {
        return item_gameplay_base.GetItem(tItem);
      }
    });
    createEffect(() => {
      var _a;
      const hItemCast = item_gameplay_base.GetCastHelperItem();
      const hItem = getItemClass();
      (_a = ref()) === null || _a === void 0 ? void 0 : _a.SwitchClass('CastHelper', hItemCast && hItem ? hItemCast.CastFilterResultItem(hItem.tItem) === true ? 'CastHelper_Active' : 'CastHelper_Disable' : '');
      const id = Timer(() => {
        var _a;
        setNotCast(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityManaCost']) > Entities.GetMana(getter_iSelectUnit()));
        return 0.1;
      }, 0.1, undefined, 'gameplay_item');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    onCleanup(() => {
      var _a;
      if (((_a = getItemClass()) === null || _a === void 0 ? void 0 : _a.pRoot) != undefined && ref() == getItemClass().pRoot) {
        getItemClass().disableCastHelper();
      }
    });
    const onactivate = p => {
      var _a, _b, _c, _d, _e;
      (_a = props.onactivate) === null || _a === void 0 ? void 0 : _a.call(props, p);
      if (!props.not_useable) {
        if (((_d = (_c = (_b = getter.item) === null || _b === void 0 ? void 0 : _b.call(getter)) === null || _c === void 0 ? void 0 : _c.boxid) !== null && _d !== void 0 ? _d : 0) > 1000) {
          return;
        }
        if (item_gameplay_base.GetCastHelperItem()) {
          item_gameplay_base.GetCastHelperItem().onCastHelperTrigger();
        } else if (getItemClass()) {
          getItemClass().pRoot = p;
          getItemClass().onactivate(p);
          if (CheckDoubleClick()) {
            (_e = props.onactivate_db) === null || _e === void 0 ? void 0 : _e.call(props, p);
            getItemClass().pRoot = p;
            getItemClass().ondblclick(p);
          }
        }
      }
    };
    return createComponent(KeybindButton, mergeProps(props, {
      get key() {
        return memo(() => !!((_a = getter.key) === null || _a === void 0))() ? void 0 : _a.call(getter);
      },
      get className() {
        return classNames("GameplayItem", props.className, getHeadID(), getType(), getRarity() ? 'Rarity_' + getRarity() : '');
      },
      ref: p => {
        setRef(p);
        if (props.ref) {
          if (typeof props.ref == 'function') props.ref(p);else props.ref = p;
        }
      },
      onactivate: onactivate,
      onmouseover: p => {
        var _a, _b;
        (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
        item_gameplay_base.tMouseoverItem = (_b = getter.item) === null || _b === void 0 ? void 0 : _b.call(getter);
      },
      onmouseout: p => {
        var _a;
        (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
        item_gameplay_base.tMouseoverItem = undefined;
      },
      get children() {
        return [createComponent(Switch, {
          get children() {
            return [createComponent(Match, {
              get when() {
                return getType() == 'game_item';
              },
              get children() {
                const _el$ = createElement("Panel", {
                  id: "GameItemBody",
                  get ["class"]() {
                    return classNames({
                      NotMana: isNotMana()
                    });
                  }
                }, null);
                insert(_el$, createComponent(Yzy_ItemImage, {
                  get name() {
                    return getName();
                  },
                  get rarity() {
                    return getRarity();
                  },
                  onmouseover: p => {
                    ShowTooltip(p, 'game_item_tooltip', {
                      'sItemName': getName()
                    });
                  },
                  onmouseout: HideTooltip,
                  onactivate: onactivate
                }), null);
                insert(_el$, createComponent(Show, {
                  get when() {
                    return memo(() => getEndTime() != undefined)() && getEndTime() > Game.GetGameTime();
                  },
                  get children() {
                    return createComponent(CooldownPanel, {
                      fEnd: getEndTime,
                      get fCD() {
                        return getKv()['AbilityCooldown'];
                      },
                      bShine: true,
                      hittest: false
                    });
                  }
                }), null);
                insert(_el$, createComponent(Show, {
                  get when() {
                    return memo(() => ((_b = getter.key) === null || _b === void 0 ? void 0 : _b.call(getter)) != undefined)() && !IsPassive(getName());
                  },
                  get children() {
                    const _el$2 = createElement("Label", {
                      id: "HotKey",
                      get text() {
                        return memo(() => !!((_c = getter.key) === null || _c === void 0))() ? void 0 : _c.call(getter);
                      }
                    }, null);
                    effect(_$p => setProp(_el$2, "text", memo(() => !!((_c = getter.key) === null || _c === void 0))() ? void 0 : _c.call(getter), _$p));
                    return _el$2;
                  }
                }), null);
                effect(_$p => setProp(_el$, "class", classNames({
                  NotMana: isNotMana()
                }), _$p));
                return _el$;
              }
            }), createComponent(Match, {
              get when() {
                return getType() == 'consumable';
              },
              get children() {
                return createComponent(Yzy_ItemImage, {
                  get name() {
                    return getName();
                  },
                  get rarity() {
                    return getRarity();
                  },
                  onactivate: onactivate,
                  onmouseover: p => {
                    ShowTooltip(p, 'common_detail_tooltip', {
                      'sName': getName(),
                      'sTitle': "#DOTA_TOOLTIP_ability_" + getName(),
                      'iRarity': getRarity(),
                      'sTitleContext': $.Localize('#DOTA_TOOLTIP_ability_' + getName() + '_Use') != '#DOTA_TOOLTIP_ability_' + getName() + '_Use' ? $.Localize('#DOTA_TOOLTIP_ability_' + getName() + '_Use') : undefined,
                      'sContext': ReplaceAbltVals(getName(), $.Localize('#DOTA_TOOLTIP_ability_' + getName() + '_Description'))
                    });
                  },
                  onmouseout: HideTooltip
                });
              }
            })];
          }
        }), createComponent(Show, {
          get when() {
            return (getCountDown() || 0) > 0;
          },
          get children() {
            return createComponent(CountDown, {
              id: "CountDown",
              hittest: false,
              get fTimeEnd() {
                return getCountDown();
              },
              get children() {
                return createElement("Label", {
                  hittest: false,
                  text: "{s:countdown_time}"
                }, null);
              }
            });
          }
        }), createComponent(Show, {
          get when() {
            return getCountUp() != undefined;
          },
          get children() {
            return createComponent(CountUp, {
              id: "CountUp",
              hittest: false,
              get fTimeStart() {
                return getCountUp();
              },
              get children() {
                return createElement("Label", {
                  hittest: false,
                  text: "{s:countdown_time}"
                }, null);
              }
            });
          }
        })];
      }
    }));
  }
  function IsPassive(sItemName) {
    var _a;
    const sAbilityBehavior = (_a = ItemsKv === null || ItemsKv === void 0 ? void 0 : ItemsKv[sItemName]) === null || _a === void 0 ? void 0 : _a['AbilityBehavior'];
    if (sAbilityBehavior == undefined) return false;
    const s = sAbilityBehavior.replace(/ /g, "");
    let t = s.split('|');
    for (let i = 0; i < t.length; i++) {
      if (DOTA_ABILITY_BEHAVIOR[t[i]] == DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) {
        return true;
      }
    }
    return false;
  }

  const getter_bDebugMode = useNetEventTable(t => t === null || t === void 0 ? void 0 : t.enable, 'debug', () => 'player_' + getter_iLocalPlayer())[0];

  createEffect(() => {
    if (Game.IsInToolsMode() || getter_bDebugMode()) {
      render(() => createComponent(DebugBody, {}), $('#DebugBodyRoot'));
      render(() => createComponent(DummyOverHead, {}), $('#DummyOverHeadRoot'));
      WatchBehaviorTree();
    }
    const id = GameEvents.Subscribe('debug_key_log', ({
      data
    }) => {
      print(`[Debug Key]`, data);
    });
    onCleanup(() => {
      GameEvents.Unsubscribe(id);
    });
  });
  function DebugBody() {
    const getEntID = useSelectUnit();
    return (() => {
      const _el$ = createElement("Panel", {
        id: "DebugBody",
        hittest: false
      }, null);
      setProp(_el$, "style", {
        width: '100%',
        height: '100%'
      });
      insert(_el$, createComponent(Debug, {
        getEntID: getEntID
      }), null);
      insert(_el$, createComponent(SelectionBoxs, {
        getEntID: getEntID
      }), null);
      insert(_el$, createComponent(UnitAttributePanel, {
        getEntID: getEntID
      }), null);
      return _el$;
    })();
  }
  function Debug(props) {
    return (() => {
      const _el$2 = createElement("Panel", {
          hittest: false
        }, null),
        _el$3 = createElement("Panel", {}, _el$2),
        _el$4 = createElement("Panel", {
          id: "DebugSlideThumb"
        }, _el$2),
        _el$5 = createElement("Button", {
          acceptsfocus: true
        }, _el$4),
        _el$6 = createElement("Panel", {}, _el$5);
      setProp(_el$2, "className", "Debug");
      setProp(_el$3, "className", "Body");
      insert(_el$3, createComponent(HeroBox, {}), null);
      insert(_el$3, createComponent(UnitBox, {
        get getEntID() {
          return props.getEntID;
        }
      }), null);
      insert(_el$3, createComponent(ItemBox, {}), null);
      insert(_el$3, createComponent(DemoOther, {
        get getEntID() {
          return props.getEntID;
        }
      }), null);
      insert(_el$3, createComponent(UIHelperBox, {}), null);
      insert(_el$3, createComponent(DebugPerformanceBox, {}), null);
      setProp(_el$5, "onactivate", () => {
        $.GetContextPanel().ToggleClass('Minimized');
      });
      setProp(_el$6, "className", "RightArrowButtonIcon");
      return _el$2;
    })();
  }
  function SelectionBoxs(props) {
    var _a;
    let ref;
    const [getAction, setAction] = createSignal('');
    createSignal('');
    const [isNoLocal, setLocal] = createSignal(false);
    createSignal('');
    createSignal({});
    createSignal('');
    createEffect(() => {
      const sAction = getAction();
      let id = EventManager.Reg('ON_DEBUG_SELECTION_ACTION', s => {
        if (!ref.BHasClass('Show')) {
          ref.SetHasClass('Show', true);
        } else if (s == sAction) {
          ref.SetHasClass('Show', false);
        }
        setAction(s);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_DEBUG_SELECTION_ACTION', id);
      });
    });
    return (() => {
      const _el$7 = createElement("Panel", {
          id: "SelectionBoxs",
          hittest: false
        }, null),
        _el$8 = createElement("Panel", {
          hittest: false
        }, _el$7),
        _el$9 = createElement("Panel", {}, _el$8),
        _el$0 = createElement("Label", {
          get text() {
            return `${(_a = {
            'hero': '英雄',
            'consumable': '消耗品',
            'shopitem': '黑市商品',
            'card': '卡牌',
            'relic': '宝物',
            'game_item': '局内装备'
          }[getAction()]) !== null && _a !== void 0 ? _a : ''}`;
          }
        }, _el$9),
        _el$1 = createElement("ToggleButton", {}, _el$9);
        createElement("Label", {
          text: '源码'
        }, _el$1);
        const _el$11 = createElement("Panel", {
          hittest: false
        }, _el$8);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$7) : ref = _el$7;
      setProp(_el$8, "className", "Body");
      setProp(_el$9, "className", "Hander");
      setProp(_el$9, "onactivate", () => {});
      setProp(_el$0, "className", "TitleLabel");
      setProp(_el$1, "onactivate", () => {
        setLocal(!isNoLocal());
      });
      setProp(_el$11, "className", "Body");
      insert(_el$11, createComponent(Dynamic, {
        get component() {
          return {
            'hero': () => createComponent(HeroSelectionBox, {
              onactivate: sName => {
                GameEvents.SendCustomGameEventToServer('debug_cmd', {
                  cmd: `-replace_hero ${sName}`
                });
                $('#SelectionBoxs').SetHasClass('Show', false);
              }
            }),
            'consumable': () => createComponent(ConsumableSelectionBox, {
              get iEntID() {
                return props.getEntID;
              }
            }),
            'shopitem': () => createComponent(ShopItemSelectionBox, {
              get iEntID() {
                return props.getEntID;
              }
            }),
            'card': () => createComponent(CardSelectionBox, {
              get iEntID() {
                return props.getEntID;
              }
            }),
            'relic': () => createComponent(RelicSelectionBox, {
              get iEntID() {
                return props.getEntID;
              }
            }),
            'game_item': () => createComponent(ItemSelectionBox, {
              bLocal: isNoLocal,
              get iEntID() {
                return props.getEntID;
              }
            })
          }[getAction()];
        }
      }));
      effect(_$p => setProp(_el$0, "text", `${(_a = {
      'hero': '英雄',
      'consumable': '消耗品',
      'shopitem': '黑市商品',
      'card': '卡牌',
      'relic': '宝物',
      'game_item': '局内装备'
    }[getAction()]) !== null && _a !== void 0 ? _a : ''}`, _$p));
      return _el$7;
    })();
  }
  function HeroBox() {
    var _a;
    const getHeroEntID = usePlayerSelectedHero();
    const tHeroData = createMemo(() => {
      var _a, _b;
      let tKv = HeroesKv[Entities.GetUnitName(getHeroEntID())];
      let fModelScale = (_a = tKv === null || tKv === void 0 ? void 0 : tKv['ModelScale']) !== null && _a !== void 0 ? _a : 1;
      let iHealthBarOffset = (_b = tKv === null || tKv === void 0 ? void 0 : tKv['HealthBarOffset']) !== null && _b !== void 0 ? _b : 0;
      return {
        tKv,
        fModelScale,
        iHealthBarOffset
      };
    });
    return (() => {
      const _el$12 = createElement("Panel", {
          id: "HeroBox",
          hittest: false
        }, null),
        _el$14 = createElement("Label", {
          id: "HeroDemoHeroName",
          get text() {
            return '#' + Entities.GetUnitName(getHeroEntID());
          }
        }, _el$12),
        _el$15 = createElement("Button", {
          id: "PlayerHeroPickerButton"
        }, _el$12);
      insert(_el$12, createComponent(Show, {
        get when() {
          return tHeroData().tKv != undefined;
        },
        get children() {
          const _el$13 = createElement("Panel", {
            id: "Hero3DPanel"
          }, null);
          setProp(_el$13, "className", "Hero3DPanel");
          insert(_el$13, createComponent(Show, {
            get when() {
              return tHeroData().tKv['UIItemDef'] != undefined;
            },
            get fallback() {
              return (() => {
                const _el$16 = createElement("DOTAScenePanel", {
                  get unit() {
                    return Entities.GetUnitName(getHeroEntID());
                  },
                  allowrotation: false,
                  hittest: true,
                  particleonly: false
                }, null);
                setProp(_el$16, "style", {
                  width: '150px',
                  height: '150px',
                  marginLeft: '-15px',
                  overflow: 'clip'
                });
                effect(_$p => setProp(_el$16, "unit", Entities.GetUnitName(getHeroEntID()), _$p));
                return _el$16;
              })();
            },
            get children() {
              return createComponent(DOTAUIEconSetPreview, {
                get itemdef() {
                  return tHeroData().tKv['UIItemDef'];
                },
                get itemstyle() {
                  return (_a = tHeroData().tKv['UIItemStyle']) !== null && _a !== void 0 ? _a : 0;
                },
                displaymode: 'loadout_small',
                drawbackground: false,
                renderdeferred: false,
                deferredalpha: false,
                antialias: true,
                get style() {
                  return {
                    width: '250px',
                    height: '250px',
                    marginTop: `${ -110 + tHeroData().iHealthBarOffset * tHeroData().fModelScale * 0.4}px`,
                    marginLeft: '-45px',
                    overflow: 'noclip',
                    opacityBrush: 'gradient(linear, 0% 100%, 0% 0%, from(#fff0), color-stop(0.3, #fff0), color-stop(0.301, #ffff), to(#ffff))'
                  };
                }
              });
            }
          }));
          return _el$13;
        }
      }), _el$14);
      setProp(_el$15, "onactivate", () => {
        Game.EmitSound("UI.Button.Pressed");
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'hero');
      });
      effect(_$p => setProp(_el$14, "text", '#' + Entities.GetUnitName(getHeroEntID()), _$p));
      return _el$12;
    })();
  }
  function HeroSelectionBox({
    onactivate
  }) {
    return (() => {
      const _el$17 = createElement("Panel", {
        id: "HeroSelectionBox",
        hittest: false
      }, null);
      setProp(_el$17, "className", "SelectionBox");
      insert(_el$17, () => Object.keys(CustomHeroesKv || []).map(sName => {
        var _a, _b, _c, _d;
        let tKv = CustomHeroesKv[sName];
        let fModelScale = (_a = tKv['ModelScale']) !== null && _a !== void 0 ? _a : 1;
        let iHealthBarOffset = (_b = tKv['HealthBarOffset']) !== null && _b !== void 0 ? _b : 0;
        const bEnable = tKv['Enable'] || 0;
        let tWearable = WearableCfgByKv(tKv).items;
        if (bEnable == 0) return [];
        return (() => {
          const _el$18 = createElement("Panel", {}, null),
            _el$19 = createElement("Panel", {}, _el$18),
            _el$20 = createElement("Label", {
              text: '#' + sName
            }, _el$18);
          setProp(_el$18, "className", "HeroOption");
          setProp(_el$18, "onload", p => {
            p.SetScrollParentToFitWhenFocused(false);
          });
          setProp(_el$18, "onactivate", () => {
            onactivate(sName);
          });
          setProp(_el$19, "className", "Hero3DPanel");
          insert(_el$19, (() => {
            const _c$ = memo(() => tKv['UIItemDef'] != undefined);
            return () => _c$() ? createComponent(DOTAUIEconSetPreview, {
              get itemdef() {
                return tKv['UIItemDef'];
              },
              get itemstyle() {
                return (_c = tKv['UIItemStyle']) !== null && _c !== void 0 ? _c : 0;
              },
              displaymode: 'loadout_small',
              drawbackground: false,
              renderdeferred: false,
              deferredalpha: false,
              antialias: true,
              style: {
                width: '300px',
                height: '300px',
                marginTop: `${ -170 + iHealthBarOffset * fModelScale * 0.7}px`,
                marginLeft: '-80px'
              }
            }) : (() => {
              const _c$2 = memo(() => tWearable.length > 0);
              return () => _c$2() ? createComponent(WearableHero, {
                get sHero() {
                  return tKv['HeroName'];
                },
                get tItems() {
                  return WearableCfgByKv(tKv).items;
                },
                hittest: false,
                style: {
                  width: '300px',
                  height: '300px',
                  marginTop: `${ -80 + iHealthBarOffset * fModelScale * 0.7}px`,
                  marginLeft: '-80px',
                  padding: '50px'
                }
              }) : (() => {
                const _el$21 = createElement("DOTAScenePanel", {
                  get unit() {
                    return (_d = tKv['HeroName']) !== null && _d !== void 0 ? _d : sName;
                  },
                  allowrotation: false,
                  hittest: true,
                  particleonly: false
                }, null);
                setProp(_el$21, "style", {
                  width: '150px',
                  height: '150px',
                  padding: '-70px',
                  marginTop: `0px`,
                  marginLeft: '-15px'
                });
                effect(_$p => setProp(_el$21, "unit", (_d = tKv['HeroName']) !== null && _d !== void 0 ? _d : sName, _$p));
                return _el$21;
              })();
            })();
          })());
          setProp(_el$20, "text", '#' + sName);
          return _el$18;
        })();
      }));
      return _el$17;
    })();
  }
  function UnitBox(props) {
    var _a, _b;
    const getTeam = () => {
      return $('#UnitTeamCfgBtn').IsSelected() ? DOTATeam_t.DOTA_TEAM_BADGUYS : DOTATeam_t.DOTA_TEAM_GOODGUYS;
    };
    return (() => {
      const _el$22 = createElement("Panel", {
          id: "UnitBox"
        }, null),
        _el$23 = createElement("Label", {
          text: "单位"
        }, _el$22),
        _el$24 = createElement("Panel", {}, _el$22),
        _el$25 = createElement("Panel", {}, _el$24),
        _el$26 = createElement("RadioButton", {
          id: "UnitTeamCfgBtn",
          group: "UnitTeamCfg",
          text: "敌方",
          selected: true
        }, _el$25),
        _el$27 = createElement("RadioButton", {
          group: "UnitTeamCfg",
          text: "友方"
        }, _el$25),
        _el$28 = createElement("Panel", {}, _el$24),
        _el$29 = createElement("Button", {}, _el$28),
        _el$30 = createElement("TextEntry", {
          multiline: false,
          get placeholder() {
            return (_a = GameUI['__Debug__LastUnit']) !== null && _a !== void 0 ? _a : '单位名';
          },
          get text() {
            return (_b = GameUI['__Debug__LastUnit']) !== null && _b !== void 0 ? _b : '';
          }
        }, _el$29);
        createElement("Label", {
          text: "创建单位"
        }, _el$29);
        const _el$32 = createElement("Panel", {}, _el$24),
        _el$33 = createElement("Button", {}, _el$32);
        createElement("Label", {
          text: "创建傀儡"
        }, _el$33);
        const _el$35 = createElement("Panel", {}, _el$24),
        _el$36 = createElement("Button", {}, _el$35);
        createElement("Label", {
          text: "移除傀儡"
        }, _el$36);
        const _el$38 = createElement("Panel", {}, _el$24),
        _el$39 = createElement("Button", {}, _el$38);
        createElement("TextEntry", {
          multiline: false,
          textmode: "numeric",
          placeholder: '等级',
          text: '1'
        }, _el$39);
        createElement("Label", {
          text: "升级"
        }, _el$39);
        const _el$42 = createElement("Panel", {}, _el$24),
        _el$43 = createElement("Button", {}, _el$42);
        createElement("Label", {
          text: "击杀"
        }, _el$43);
        const _el$45 = createElement("Button", {}, _el$42);
        createElement("Label", {
          text: "自杀"
        }, _el$45);
        const _el$47 = createElement("Button", {}, _el$42);
        createElement("Label", {
          text: "复活"
        }, _el$47);
        const _el$49 = createElement("Panel", {}, _el$24),
        _el$50 = createElement("Button", {}, _el$49);
        createElement("Label", {
          text: "控制"
        }, _el$50);
        const _el$52 = createElement("Button", {}, _el$49);
        createElement("Label", {
          text: "移除"
        }, _el$52);
        const _el$54 = createElement("Button", {}, _el$49);
        createElement("Label", {
          text: "行为"
        }, _el$54);
        const _el$56 = createElement("Panel", {}, _el$24),
        _el$57 = createElement("Button", {}, _el$56);
        createElement("Label", {
          text: "属性"
        }, _el$57);
        const _el$59 = createElement("Panel", {}, _el$24),
        _el$60 = createElement("ToggleButton", {
          get selected() {
            return Entities.HasBuff(props.getEntID(), 'lm_take_no_damage');
          }
        }, _el$59);
        createElement("Label", {
          text: "无敌"
        }, _el$60);
        const _el$62 = createElement("Panel", {}, _el$24),
        _el$63 = createElement("ToggleButton", {}, _el$62);
        createElement("Label", {
          text: "伤害打印"
        }, _el$63);
      setProp(_el$22, "className", "Category Spread");
      setProp(_el$23, "className", "CategoryHeader");
      setProp(_el$23, "onactivate", p => {
        var _a;
        (_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.ToggleClass('Spread');
      });
      setProp(_el$24, "className", "CategoryButtonContainer");
      setProp(_el$25, "className", "Row");
      setProp(_el$26, "className", "CategoryButton LeftButton");
      setProp(_el$26, "style", {
        backgroundColor: '#b63221'
      });
      setProp(_el$27, "className", "CategoryButton RightButton");
      setProp(_el$27, "style", {
        backgroundColor: '#6aa42f'
      });
      setProp(_el$28, "className", "Row");
      setProp(_el$29, "className", "CategoryButton TextEntryButton LeftButton");
      setProp(_el$29, "onactivate", p => {
        GameUI['__Debug__LastUnit'] = p.GetChild(0).text;
        if (GameUI['__Debug__LastUnit'] != '') {
          GameEvents.SendCustomGameEventToServer('debug_cmd', {
            cmd: `-unit ${GameUI['__Debug__LastUnit']} ${getTeam()}`
          });
        }
      });
      setProp(_el$32, "className", "Row");
      setProp(_el$33, "className", "CategoryButton");
      setProp(_el$33, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-puppet ${getTeam()}`
        });
      });
      setProp(_el$35, "className", "Row");
      setProp(_el$36, "className", "CategoryButton");
      setProp(_el$36, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-remove_dummy`
        });
      });
      setProp(_el$38, "className", "Row");
      setProp(_el$39, "className", "CategoryButton TextEntryButton LeftButton");
      setProp(_el$39, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-lvlup ${p.GetChild(0).text || 1} ${props.getEntID()}`
        });
      });
      setProp(_el$42, "className", "Row");
      setProp(_el$43, "className", "CategoryButton LeftButton");
      setProp(_el$43, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-kill ${props.getEntID()}`
        });
      });
      setProp(_el$45, "className", "CategoryButton");
      setProp(_el$45, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-suicide ${props.getEntID()}`
        });
      });
      setProp(_el$47, "className", "CategoryButton RightButton");
      setProp(_el$47, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-respawn ${props.getEntID()}`
        });
      });
      setProp(_el$49, "className", "Row");
      setProp(_el$50, "className", "CategoryButton LeftButton");
      setProp(_el$50, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-ctrl ${props.getEntID()}`
        });
      });
      setProp(_el$52, "className", "CategoryButton");
      setProp(_el$52, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: '-remove ' + Players.GetSelectedEntities(Players.GetLocalPlayer()).join(' ')
        });
      });
      setProp(_el$54, "className", "CategoryButton RightButton");
      setProp(_el$54, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-wbt ${props.getEntID()}`
        });
      });
      setProp(_el$56, "className", "Row");
      setProp(_el$57, "className", "CategoryButton RightButton");
      setProp(_el$57, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_OPEN_ATTRIBUTE', {});
      });
      setProp(_el$59, "className", "Row");
      setProp(_el$60, "className", "CategoryButton LeftButton");
      setProp(_el$60, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-invulner`
        });
      });
      setProp(_el$62, "className", "Row");
      setProp(_el$63, "className", "CategoryButton LeftButton");
      setProp(_el$63, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-print_dmg ${p.IsSelected() ? 1 : 0}`
        });
      });
      effect(_p$ => {
        const _v$ = (_a = GameUI['__Debug__LastUnit']) !== null && _a !== void 0 ? _a : '单位名',
          _v$2 = (_b = GameUI['__Debug__LastUnit']) !== null && _b !== void 0 ? _b : '',
          _v$3 = Entities.HasBuff(props.getEntID(), 'lm_take_no_damage');
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$30, "placeholder", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$30, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$60, "selected", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$22;
    })();
  }
  function ItemBox() {
    return (() => {
      const _el$65 = createElement("Panel", {}, null),
        _el$66 = createElement("Label", {
          text: "道具"
        }, _el$65),
        _el$67 = createElement("Panel", {}, _el$65),
        _el$68 = createElement("Panel", {}, _el$67),
        _el$69 = createElement("Button", {}, _el$68);
        createElement("Label", {
          text: "清除掉落物"
        }, _el$69);
        const _el$71 = createElement("Panel", {}, _el$67),
        _el$72 = createElement("Button", {}, _el$71);
        createElement("Label", {
          text: "消耗品"
        }, _el$72);
        const _el$74 = createElement("Panel", {}, _el$67),
        _el$75 = createElement("Button", {}, _el$74);
        createElement("Label", {
          text: "黑市商品"
        }, _el$75);
        const _el$77 = createElement("Panel", {}, _el$67),
        _el$78 = createElement("Button", {}, _el$77);
        createElement("Label", {
          text: "卡牌"
        }, _el$78);
        const _el$80 = createElement("Panel", {}, _el$67),
        _el$81 = createElement("Button", {}, _el$80);
        createElement("Label", {
          text: "宝物"
        }, _el$81);
        const _el$83 = createElement("Panel", {}, _el$67),
        _el$84 = createElement("Button", {}, _el$83);
        createElement("Label", {
          text: "局内装备"
        }, _el$84);
        const _el$86 = createElement("Panel", {}, _el$67),
        _el$87 = createElement("TextEntry", {
          textmode: "normal",
          placeholder: '10000',
          multiline: false,
          text: '10000'
        }, _el$86),
        _el$88 = createElement("Button", {}, _el$86);
        createElement("Label", {
          text: "金币"
        }, _el$88);
        const _el$90 = createElement("Button", {}, _el$86);
        createElement("Label", {
          text: "木材"
        }, _el$90);
        const _el$92 = createElement("Button", {}, _el$86);
        createElement("Label", {
          text: "杀敌"
        }, _el$92);
      setProp(_el$65, "className", "Category Spread");
      setProp(_el$66, "className", "CategoryHeader");
      setProp(_el$66, "onactivate", p => {
        var _a;
        (_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.ToggleClass('Spread');
      });
      setProp(_el$67, "className", "CategoryButtonContainer");
      setProp(_el$68, "className", "Row");
      setProp(_el$69, "className", "CategoryButton LeftButton");
      setProp(_el$69, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: '-clrdrop'
        });
      });
      setProp(_el$71, "className", "Row");
      setProp(_el$72, "className", "CategoryButton LeftButton CategoryPickerArrowButton");
      setProp(_el$72, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'consumable');
      });
      setProp(_el$74, "className", "Row");
      setProp(_el$75, "className", "CategoryButton LeftButton CategoryPickerArrowButton");
      setProp(_el$75, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'shopitem');
      });
      setProp(_el$77, "className", "Row");
      setProp(_el$78, "className", "CategoryButton LeftButton CategoryPickerArrowButton");
      setProp(_el$78, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'card');
      });
      setProp(_el$80, "className", "Row");
      setProp(_el$81, "className", "CategoryButton LeftButton CategoryPickerArrowButton");
      setProp(_el$81, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'relic');
      });
      setProp(_el$83, "className", "Row");
      setProp(_el$84, "className", "CategoryButton LeftButton CategoryPickerArrowButton");
      setProp(_el$84, "onactivate", () => {
        EventManager.Fire('ON_DEBUG_SELECTION_ACTION', 'game_item');
      });
      setProp(_el$86, "className", "Row ResourceRow");
      setProp(_el$86, "style", {
        flowChildren: 'right-wrap'
      });
      setProp(_el$87, "style", {
        width: '100%',
        height: '30px',
        marginBottom: '3px'
      });
      setProp(_el$88, "className", "CategoryButton LeftButton");
      setProp(_el$88, "style", {
        width: '31%'
      });
      setProp(_el$88, "onactivate", p => {
        var _a;
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-res_gold ${((_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.GetChild(0)).text}`
        });
      });
      setProp(_el$90, "className", "CategoryButton LeftButton");
      setProp(_el$90, "style", {
        width: '32%'
      });
      setProp(_el$90, "onactivate", p => {
        var _a;
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-res_wood ${((_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.GetChild(0)).text}`
        });
      });
      setProp(_el$92, "className", "CategoryButton LeftButton");
      setProp(_el$92, "style", {
        width: '32%'
      });
      setProp(_el$92, "onactivate", p => {
        var _a;
        GameEvents.SendCustomGameEventToServer('debug_cmd', {
          cmd: `-res_kill ${((_a = p === null || p === void 0 ? void 0 : p.GetParent()) === null || _a === void 0 ? void 0 : _a.GetChild(0)).text}`
        });
      });
      return _el$65;
    })();
  }
  function ItemSelectionBox(props) {
    const getter = PropsGetter(props);
    return (() => {
      const _el$94 = createElement("Panel", {
        id: "ItemSelectionBox",
        hittest: false
      }, null);
      setProp(_el$94, "className", "SelectionBox");
      insert(_el$94, () => Object.keys(ItemsKv).filter(k => {
        var _a;
        return String((_a = ItemsKv[k]['id']) !== null && _a !== void 0 ? _a : '').substring(0, 3) == '112';
      }).sort((a, b) => ItemsKv[a]['id'] - ItemsKv[b]['id']).map(sName => {
        var _a, _b;
        let sLocalizeName = $.Localize('#DOTA_TOOLTIP_ability_' + sName);
        if (sLocalizeName == '#DOTA_TOOLTIP_ability_' + sName) {
          sLocalizeName = sName;
        }
        return (() => {
          const _el$95 = createElement("Panel", {}, null);
          setProp(_el$95, "className", "ItemOption");
          insert(_el$95, createComponent(Yzy_ItemImage, {
            name: sName,
            get rarity() {
              return (_a = ItemsKv[sName]) === null || _a === void 0 ? void 0 : _a['Rarity'];
            },
            onmouseover: p => {
              var _a;
              ShowTooltip(p, 'game_item_tooltip', {
                'sItemName': sName,
                'iEntID': (_a = getter.iEntID) === null || _a === void 0 ? void 0 : _a.call(getter)
              });
            },
            onmouseout: HideTooltip,
            onactivate: () => {
              GameEvents.SendCustomGameEventToServer('debug_cmd', {
                cmd: `-gitem ${sName} ${getter.iEntID()}`
              });
            }
          }), null);
          insert(_el$95, createComponent(Yzy_ItemName, {
            name: sName,
            get rarity() {
              return (_b = ItemsKv[sName]) === null || _b === void 0 ? void 0 : _b['Rarity'];
            },
            get text() {
              return getter.bLocal() ? sName : sLocalizeName;
            }
          }), null);
          return _el$95;
        })();
      }));
      return _el$94;
    })();
  }
  function ConsumableSelectionBox(props) {
    const getter = PropsGetter(props);
    return (() => {
      const _el$96 = createElement("Panel", {
        id: "ConsumableSelectionBox",
        hittest: false
      }, null);
      setProp(_el$96, "className", "SelectionBox");
      insert(_el$96, () => Object.keys(ItemsKv).filter(k => {
        return String(ItemsKv[k]['id']).substring(0, 3) == '108' && ItemsKv[k]['ItemLabel'] == 'consumable';
      }).sort((a, b) => {
        var _a, _b;
        return ((_a = ItemsKv[a]['id']) !== null && _a !== void 0 ? _a : 0) - ((_b = ItemsKv[b]['id']) !== null && _b !== void 0 ? _b : 0);
      }).map(sName => {
        const tKv = ItemsKv[sName];
        return (() => {
          const _el$97 = createElement("Panel", {}, null),
            _el$98 = createElement("Panel", {}, _el$97);
          setProp(_el$97, "className", "AbilityOption");
          setProp(_el$98, "className", "ConsumableImagePanel");
          insert(_el$98, createComponent(GameplayItem, {
            get item_id() {
              return tKv['id'];
            },
            onactivate: () => {
              GameEvents.SendCustomGameEventToServer('debug_cmd', {
                cmd: `-consumable ${sName} ${getter.iEntID()}`
              });
            }
          }));
          insert(_el$97, createComponent(Yzy_ItemName, {
            name: sName,
            text: '#DOTA_TOOLTIP_ability_' + sName,
            get rarity() {
              return tKv['Rarity'];
            }
          }), null);
          return _el$97;
        })();
      }));
      return _el$96;
    })();
  }
  function ShopItemSelectionBox(props) {
    const getter = PropsGetter(props);
    return (() => {
      const _el$99 = createElement("Panel", {
        id: "ShopItemSelectionBox",
        hittest: false
      }, null);
      setProp(_el$99, "className", "SelectionBox");
      insert(_el$99, () => Object.keys(AbilitiesKv).filter(k => {
        return String(AbilitiesKv[k]['id']).substring(0, 3) == '109';
      }).sort((a, b) => {
        var _a, _b;
        return ((_a = AbilitiesKv[a]['id']) !== null && _a !== void 0 ? _a : 0) - ((_b = AbilitiesKv[b]['id']) !== null && _b !== void 0 ? _b : 0);
      }).map(sName => {
        const tKv = AbilitiesKv[sName];
        if (tKv['Enable'] != 1) return [];
        return (() => {
          const _el$100 = createElement("Panel", {}, null),
            _el$101 = createElement("Panel", {}, _el$100);
          setProp(_el$100, "className", "AbilityOption");
          setProp(_el$101, "className", "ShopItemImagePanel");
          insert(_el$101, createComponent(Yzy_ItemImage, {
            name: sName,
            get rarity() {
              return tKv['Rarity'];
            },
            onmouseover: p => {
              ShowTooltip(p, 'common_detail_tooltip', {
                'sName': sName,
                'sTitle': $.Localize('#' + sName),
                'tAttribute': Object.keys((tKv === null || tKv === void 0 ? void 0 : tKv.AbilityValues) || {}).filter(k => k.substring(0, 3) == 'sx_').map(k => {
                  var _a;
                  return `${k}=${(_a = tKv === null || tKv === void 0 ? void 0 : tKv.AbilityValues) === null || _a === void 0 ? void 0 : _a[k]}`;
                }),
                'sContext': $.Localize("#" + sName + '_Description') != "#" + sName + '_Description' ? ReplaceAbltVals(sName, $.Localize("#" + sName + '_Description')) : undefined
              });
            },
            onmouseout: HideTooltip,
            onactivate: () => {
              GameEvents.SendCustomGameEventToServer('debug_cmd', {
                cmd: `-shopitem ${sName} ${getter.iEntID()}`
              });
            }
          }));
          insert(_el$100, createComponent(Yzy_ItemName, {
            name: sName
          }), null);
          return _el$100;
        })();
      }));
      return _el$99;
    })();
  }
  function CardSelectionBox(props) {
    PropsGetter(props);
    const [getCardSelected] = useNetEventTable(t => t, 'card', () => "selected_" + getter_iLocalPlayer());
    const [getCardDevour] = useNetEventTable(t => t, 'card', () => 'devour_' + getter_iLocalPlayer());
    return (() => {
      const _el$102 = createElement("Panel", {
        id: "CardSelectionBox",
        hittest: false
      }, null);
      setProp(_el$102, "className", "SelectionBox");
      insert(_el$102, () => Object.keys(AbilitiesKv).filter(k => {
        return String(AbilitiesKv[k]['id']).substring(0, 3) == '110';
      }).sort((a, b) => {
        var _a, _b;
        return ((_a = AbilitiesKv[a]['id']) !== null && _a !== void 0 ? _a : 0) - ((_b = AbilitiesKv[b]['id']) !== null && _b !== void 0 ? _b : 0);
      }).map(sName => {
        const tKv = AbilitiesKv[sName];
        if (tKv['Enable'] != 1) return [];
        const getHasCard = () => {
          var _a, _b;
          const tSelectedNames = [];
          for (const tCardData of (_a = getCardSelected()) !== null && _a !== void 0 ? _a : []) {
            if (tCardData.name) {
              tSelectedNames.push(tCardData.name);
            }
          }
          if ((tKv === null || tKv === void 0 ? void 0 : tKv['IsOnly']) == 1) {
            return (tSelectedNames === null || tSelectedNames === void 0 ? void 0 : tSelectedNames.includes(sName)) || ((_b = getCardDevour()) === null || _b === void 0 ? void 0 : _b.includes(sName));
          }
          return false;
        };
        return (() => {
          const _el$103 = createElement("Panel", {}, null);
          insert(_el$103, createComponent(Yzy_ItemImage, {
            name: sName,
            onmouseover: p => {
              ShowTooltip(p, 'card_tooltip', {
                'sCardName': sName
              });
            },
            onmouseout: HideTooltip,
            onactivate: () => {
              if (getHasCard()) return ErrorMsg('已经拥有该卡牌，无法重复添加');
              GameEvents.SendCustomGameEventToServer('debug_cmd', {
                cmd: `-card ${sName}`
              });
            }
          }), null);
          insert(_el$103, createComponent(Yzy_ItemName, {
            name: sName
          }), null);
          effect(_$p => setProp(_el$103, "className", classNames('AbilityOption', {
            'HasCard': getHasCard()
          }), _$p));
          return _el$103;
        })();
      }));
      return _el$102;
    })();
  }
  function RelicSelectionBox(props) {
    PropsGetter(props);
    const [getSelected] = useNetEventTable(t => t, 'relic', () => "selected_" + getter_iLocalPlayer());
    return (() => {
      const _el$104 = createElement("Panel", {
        id: "RelicSelectionBox",
        hittest: false
      }, null);
      setProp(_el$104, "className", "SelectionBox");
      insert(_el$104, () => Object.keys(AbilitiesKv).filter(k => {
        return String(AbilitiesKv[k]['id']).substring(0, 3) == '113';
      }).sort((a, b) => {
        var _a, _b;
        return ((_a = AbilitiesKv[a]['id']) !== null && _a !== void 0 ? _a : 0) - ((_b = AbilitiesKv[b]['id']) !== null && _b !== void 0 ? _b : 0);
      }).map(sName => {
        const tKv = AbilitiesKv[sName];
        if (tKv['Enable'] != 1) return [];
        const getHas = () => {
          var _a;
          const tSelectedNames = [];
          for (const tData of (_a = getSelected()) !== null && _a !== void 0 ? _a : []) {
            if (tData.name) {
              tSelectedNames.push(tData.name);
            }
          }
          if ((tKv === null || tKv === void 0 ? void 0 : tKv['IsOnly']) == 1) {
            return tSelectedNames === null || tSelectedNames === void 0 ? void 0 : tSelectedNames.includes(sName);
          }
          return false;
        };
        return (() => {
          const _el$105 = createElement("Panel", {}, null),
            _el$106 = createElement("Panel", {}, _el$105);
          setProp(_el$106, "className", "RelicImagePanel");
          insert(_el$106, createComponent(Yzy_ItemImage, {
            name: sName,
            get rarity() {
              return tKv['Rarity'];
            },
            onmouseover: p => {
              ShowTooltip(p, 'common_detail_tooltip', {
                'sName': sName,
                'sTitle': $.Localize('#' + sName),
                'tAttribute': Object.keys((tKv === null || tKv === void 0 ? void 0 : tKv.AbilityValues) || {}).filter(k => k.substring(0, 3) == 'sx_').map(k => {
                  var _a;
                  return `${k}=${(_a = tKv === null || tKv === void 0 ? void 0 : tKv.AbilityValues) === null || _a === void 0 ? void 0 : _a[k]}`;
                }),
                'sContext': $.Localize("#" + sName + '_Description') != "#" + sName + '_Description' ? ReplaceAbltVals(sName, $.Localize("#" + sName + '_Description')) : undefined
              });
            },
            onmouseout: HideTooltip,
            onactivate: () => {
              if (getHas()) return ErrorMsg('已经拥有该宝物，无法重复添加');
              GameEvents.SendCustomGameEventToServer('debug_cmd', {
                cmd: `-relic ${sName}`
              });
            }
          }));
          insert(_el$105, createComponent(Yzy_ItemName, {
            name: sName
          }), null);
          effect(_$p => setProp(_el$105, "className", classNames('AbilityOption', {
            'Has': getHas()
          }), _$p));
          return _el$105;
        })();
      }));
      return _el$104;
    })();
  }
  function UnitAttributePanel(props) {
    const [isShow, setShow] = createSignal(false);
    createEffect(() => {
      const bShow = isShow();
      const id = EventManager.Reg('ON_DEBUG_OPEN_ATTRIBUTE', () => {
        setShow(!bShow);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_DEBUG_OPEN_ATTRIBUTE', id);
      });
    });
    return (() => {
      const _el$107 = createElement("Panel", {
        id: "UnitAttributePanel"
      }, null);
      insert(_el$107, createComponent(Show, {
        get when() {
          return isShow();
        },
        get children() {
          const _el$108 = createElement("Panel", {
            id: "SwitchContentBox"
          }, null);
          insert(_el$108, createComponent(TabContents, {
            tabid: "UnitAttributeCtrl",
            "class": "UnitAttributeCtrl",
            group: "UnitAttribute",
            selected: true,
            get children() {
              return createComponent(AttributeCtrlBox, {
                get getEntID() {
                  return props.getEntID;
                }
              });
            }
          }), null);
          insert(_el$108, createComponent(TabContents, {
            tabid: "UnitBuffAttributesBtn",
            group: "UnitAttribute",
            get children() {
              return createComponent(UnitBuffAttributes, {
                get getEntID() {
                  return props.getEntID;
                }
              });
            }
          }), null);
          return _el$108;
        }
      }));
      effect(_$p => setProp(_el$107, "visible", isShow(), _$p));
      return _el$107;
    })();
  }
  function GetAttributeId(attribute) {
    for (const id in ID2Attribute) {
      if (ID2Attribute[id].name == attribute.name) {
        return id;
      }
    }
    return undefined;
  }
  function AttributeCtrlBox(props) {
    const [getSearchText, setSearchText] = createSignal('');
    return (() => {
      const _el$109 = createElement("Panel", {
          id: "AttributeCtrlBox",
          hittest: false
        }, null),
        _el$110 = createElement("Panel", {
          id: "AttributeCtrlBoxHeader"
        }, _el$109);
        createElement("Label", {
          text: "搜索"
        }, _el$110);
        const _el$112 = createElement("TextEntry", {
          placeholder: "支持名称、ID、本地化名称",
          get text() {
            return getSearchText();
          }
        }, _el$110),
        _el$113 = createElement("Panel", {
          id: "AttributeCtrlBoxContent",
          hittest: false
        }, _el$109);
      setProp(_el$112, "ontextentrychange", p => {
        setSearchText(p.text.toLowerCase());
      });
      insert(_el$113, () => Object.keys(AttributeCfg).map((sName, i) => {
        let sLocalizeName = '#' + sName;
        if ($.Localize(sLocalizeName) != sLocalizeName) {
          sLocalizeName = $.Localize(sLocalizeName);
        } else {
          sLocalizeName = sName;
        }
        const hAttribute = AttributeCfg[sName];
        const iAttributeID = GetAttributeId(hAttribute);
        const [bInSearch, setInSearch] = createSignal(false);
        createEffect(() => {
          if (getSearchText().length == 0) {
            setInSearch(false);
            return;
          } else {
            let bInSearch = false;
            const bParentInSearch = getSearchText().length > 0 && (sName.toLowerCase().includes(getSearchText()) || (iAttributeID === null || iAttributeID === void 0 ? void 0 : iAttributeID.toLowerCase().includes(getSearchText())) || $.Localize('#' + (iAttributeID !== null && iAttributeID !== void 0 ? iAttributeID : '')).includes(getSearchText()));
            if (bParentInSearch) {
              bInSearch = true;
            } else {
              for (const sSonName in hAttribute) {
                const v = hAttribute[sSonName];
                if (v != hAttribute.hParent && typeof v == 'object' && v instanceof Object) {
                  const iSonAttributeID = GetAttributeId(v);
                  let sSonLocalizeName = '#' + sSonName;
                  if ($.Localize(sSonLocalizeName) != sSonLocalizeName) {
                    sSonLocalizeName = $.Localize(sSonLocalizeName);
                  } else {
                    sSonLocalizeName = sSonName;
                  }
                  if (sSonLocalizeName.toLowerCase().includes(getSearchText()) || (iSonAttributeID === null || iSonAttributeID === void 0 ? void 0 : iSonAttributeID.toLowerCase().includes(getSearchText())) || $.Localize('#' + iSonAttributeID).includes(getSearchText())) {
                    bInSearch = true;
                    break;
                  }
                }
              }
            }
            setInSearch(bInSearch);
          }
        });
        return createComponent(AttributeCtrlSon, {
          hAttribute: hAttribute,
          get getEntID() {
            return props.getEntID;
          },
          sName: sLocalizeName,
          attributeID: iAttributeID,
          get bInSearch() {
            return bInSearch();
          }
        });
      }));
      effect(_$p => setProp(_el$112, "text", getSearchText(), _$p));
      return _el$109;
    })();
  }
  function AttributeCtrlSon(props) {
    var _a, _b, _c;
    let bHasSon = false;
    const tSon = {};
    for (const key in props.hAttribute) {
      const v = props.hAttribute[key];
      if (v != props.hAttribute.hParent && typeof v == 'object' && v instanceof Object) {
        bHasSon = true;
        tSon[key] = v;
      }
    }
    const bCanModify = !bHasSon && !(props.hAttribute instanceof ConstAttribute);
    const [isOpen, setOpen] = createSignal(false);
    const [getVal, setVal] = createSignal(props.hAttribute.Get(props.getEntID()));
    const [getValModifier, setValModifier] = createSignal(props.hAttribute.Get(props.getEntID(), 'debug'));
    const isNumber = () => getVal() == undefined || !Number.isNaN(parseFloat(getVal()));
    createEffect(() => {
      setValModifier(props.hAttribute.Get(props.getEntID(), 'debug'));
    });
    const iTimerID = Timer(() => {
      setVal(setVal(props.hAttribute.Get(props.getEntID())));
      return 0.5;
    }, 0.1, undefined, 'Debug.AttributeCtrlSon');
    onCleanup(() => {
      StopTimer(iTimerID);
    });
    return (() => {
      const _el$114 = createElement("Panel", {
          get style() {
            return {
              marginLeft: `${props.hAttribute.hParent == undefined ? 0 : 32}px`
            };
          }
        }, null),
        _el$115 = createElement("Panel", {
          onactivate: bHasSon ? () => {
            setOpen(!isOpen());
          } : undefined
        }, _el$114),
        _el$117 = createElement("Panel", {}, _el$115),
        _el$118 = createElement("Image", {
          id: "OpenStateImg",
          src: "s2r://panorama/images/control_icons/arrow_solid_right_png.vtex"
        }, _el$117),
        _el$119 = createElement("Label", {
          id: "AttributeName",
          html: true,
          get text() {
            return `${props.sName}${props.attributeID ? ' — ' + $.Localize('#' + props.attributeID) : ''}`;
          }
        }, _el$117),
        _el$120 = createElement("Label", {
          id: "AttributeVal",
          get text() {
            return (_a = getVal()) !== null && _a !== void 0 ? _a : '';
          }
        }, _el$117);
      setProp(_el$115, "className", "Body");
      setProp(_el$115, "onactivate", bHasSon ? () => {
        setOpen(!isOpen());
      } : undefined);
      insert(_el$115, createComponent(Show, {
        when: bCanModify,
        get children() {
          const _el$116 = createElement("Button", {
            id: "AttributeInfoButton"
          }, null);
          setProp(_el$116, "onmouseover", p => {
            let s = '';
            props.hAttribute.Data(props.getEntID()).map(({
              k,
              v
            }, i) => {
              if (i > 0) {
                s += '<br/>';
              }
              const val = typeof v == 'function' ? v() : v;
              let s2 = '';
              if (typeof k == 'object') {
                if (k instanceof DiyPolymer) {
                  s2 = `${k.GetName()} = ${val}, 'GetPolymerID' = ${k.GetPolymerID()}`;
                } else if (k instanceof Diy.DiyModifier) {
                  s2 = `${$.Localize('#DOTA_TOOLTIP_' + k.GetName()) == '#DOTA_TOOLTIP_' + k.GetName() ? k.GetName() : $.Localize('#DOTA_TOOLTIP_' + k.GetName())} = ${val}`;
                } else if (k instanceof Diy.DiyAbility) {
                  s2 = `${$.Localize('#DOTA_TOOLTIP_ability_' + k.GetAbilityName()) == '#DOTA_TOOLTIP_ability_' + k.GetAbilityName() ? k.GetAbilityName() : $.Localize('#DOTA_TOOLTIP_ability_' + k.GetAbilityName())} = ${val}`;
                }
              } else {
                s2 = `"${k}" = ${val}`;
              }
              s += s2;
            });
            if (s != '') {
              ShowTooltip(p, 'title_text_tooltip', {
                'sContext': s
              });
            }
          });
          setProp(_el$116, "onmouseout", p => {
            HideTooltip();
          });
          return _el$116;
        }
      }), _el$117);
      setProp(_el$117, "className", "Header");
      setProp(_el$117, "onmouseover", p => {
        if (props.attributeID) {
          $.DispatchEvent("DOTAShowTextTooltip", p, $.Localize('#' + props.attributeID) + ' - ' + props.attributeID);
        }
      });
      setProp(_el$117, "onmouseout", p => {
        $.DispatchEvent("DOTAHideTextTooltip", p);
      });
      setProp(_el$118, "visible", bHasSon);
      insert(_el$115, createComponent(Show, {
        when: bCanModify,
        get children() {
          const _el$121 = createElement("Panel", {
              id: "Modifier"
            }, null),
            _el$122 = createElement("TextEntry", {
              multiline: false,
              get textmode() {
                return isNumber() ? 'numeric' : 'normal';
              },
              placeholder: '',
              get text() {
                return (_c = (_b = getValModifier()) === null || _b === void 0 ? void 0 : _b.toString()) !== null && _c !== void 0 ? _c : '';
              }
            }, _el$121);
          setProp(_el$122, "ontextentrychange", p => {
            if (isNumber() && p.text != '' && Number.isNaN(parseFloat(p.text))) return;
            GameEvents.SendCustomGameEventToServer('debug_cmd', {
              cmd: `-sx ${JSON.stringify({
              name: props.hAttribute.name,
              val: p.text == '' ? undefined : isNumber() ? Number(p.text) : p.text,
              entid: props.getEntID()
            })}`
            });
          });
          effect(_p$ => {
            const _v$4 = isNumber() ? 'numeric' : 'normal',
              _v$5 = (_c = (_b = getValModifier()) === null || _b === void 0 ? void 0 : _b.toString()) !== null && _c !== void 0 ? _c : '';
            _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$122, "textmode", _v$4, _p$._v$4));
            _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$122, "text", _v$5, _p$._v$5));
            return _p$;
          }, {
            _v$4: undefined,
            _v$5: undefined
          });
          return _el$121;
        }
      }), null);
      insert(_el$114, createComponent(Show, {
        get when() {
          return bHasSon && isOpen();
        },
        get children() {
          const _el$123 = createElement("Panel", {
            id: "SonBox"
          }, null);
          insert(_el$123, () => Object.keys(tSon).map((sName, i) => {
            return createComponent(AttributeCtrlSon, {
              get hAttribute() {
                return tSon[sName];
              },
              get getEntID() {
                return props.getEntID;
              },
              sName: sName,
              get attributeID() {
                return GetAttributeId(tSon[sName]);
              }
            });
          }));
          return _el$123;
        }
      }), null);
      effect(_p$ => {
        const _v$6 = classNames("AttributeCtrlSon", {
            Showing: isOpen(),
            HasSon: bHasSon,
            InSearch: props.bInSearch
          }),
          _v$7 = {
            marginLeft: `${props.hAttribute.hParent == undefined ? 0 : 32}px`
          },
          _v$8 = `${props.sName}${props.attributeID ? ' — ' + $.Localize('#' + props.attributeID) : ''}`,
          _v$9 = (_a = getVal()) !== null && _a !== void 0 ? _a : '';
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$114, "className", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$114, "style", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$119, "text", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$120, "text", _v$9, _p$._v$9));
        return _p$;
      }, {
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined,
        _v$9: undefined
      });
      return _el$114;
    })();
  }
  function UnitBuffAttributes(props) {
    const [tPolymers, setPolymers] = createSignal([]);
    const [tBuffs, setBuffs] = createSignal([]);
    const iTimerID = Timer(() => {
      setPolymers(FindAllPolymerName(props.getEntID()).map(s => Object.assign({
        'name': s
      }, FindPolymerData(props.getEntID(), s))).sort((a, b) => a.id - b.id));
      const tBuffs = [];
      for (let i = 0; i < Entities.GetNumBuffs(props.getEntID()); ++i) {
        let a = new Diy.DiyModifier(props.getEntID(), {
          buff_id: Entities.GetBuff(props.getEntID(), i)
        });
        tBuffs.push(a);
      }
      tBuffs.sort((a, b) => a.GetSerialNumber() - b.GetSerialNumber());
      setBuffs(tBuffs);
    }, 0.1, undefined, 'Debug.UnitBuffAttributes');
    onCleanup(() => {
      StopTimer(iTimerID);
    });
    return (() => {
      const _el$124 = createElement("Panel", {
        id: "UnitBuffAttributes"
      }, null);
      insert(_el$124, createComponent(Index, {
        get each() {
          return tPolymers();
        },
        children: (getPolymerData, i) => {
          const hPlm = FindPolymer(props.getEntID(), getPolymerData().name);
          if (hPlm == undefined) return [];
          const tAttributes = hPlm.GetCustomAttributes();
          return (() => {
            const _el$125 = createElement("Panel", {}, null),
              _el$126 = createElement("Label", {
                id: "Title",
                get text() {
                  return `${getPolymerData().name}(${getPolymerData().id})`;
                }
              }, _el$125),
              _el$127 = createElement("Panel", {
                id: "AttributeBox"
              }, _el$125);
            insert(_el$127, () => Object.keys(tAttributes).map((sAttributeID, i) => {
              const val = tAttributes[sAttributeID];
              let sVal = typeof val == 'number' ? tAttributes[sAttributeID].toFixed(2) : String(val);
              return (() => {
                const _el$128 = createElement("Label", {
                  get text() {
                    return `${sAttributeID} ${SpanText(sVal, 'Val')}`;
                  },
                  html: true
                }, null);
                setProp(_el$128, "className", "AttributeLabel");
                effect(_$p => setProp(_el$128, "text", `${sAttributeID} ${SpanText(sVal, 'Val')}`, _$p));
                return _el$128;
              })();
            }));
            effect(_p$ => {
              const _v$0 = classNames("AttributeInfo", "Polymer", {
                  'Debuff': hPlm.IsDebuff()
                }),
                _v$1 = `${getPolymerData().name}(${getPolymerData().id})`;
              _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$125, "className", _v$0, _p$._v$0));
              _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$126, "text", _v$1, _p$._v$1));
              return _p$;
            }, {
              _v$0: undefined,
              _v$1: undefined
            });
            return _el$125;
          })();
        }
      }), null);
      insert(_el$124, createComponent(Index, {
        get each() {
          return tBuffs();
        },
        children: (getBuff, i) => {
          const tAttributes = getBuff().GetCustomAttributes();
          return (() => {
            const _el$129 = createElement("Panel", {}, null),
              _el$130 = createElement("Label", {
                id: "Title",
                get text() {
                  return `${getBuff().GetName()}(${getBuff().GetSerialNumber()})`;
                }
              }, _el$129),
              _el$131 = createElement("Panel", {
                id: "AttributeBox"
              }, _el$129);
            insert(_el$131, () => Object.keys(tAttributes).map(sAttributeID => {
              const val = tAttributes[sAttributeID];
              let sVal = typeof val == 'number' ? tAttributes[sAttributeID].toFixed(2) : String(val);
              return (() => {
                const _el$132 = createElement("Label", {
                  get text() {
                    return `${sAttributeID} ${SpanText(sVal, 'Val')}`;
                  },
                  html: true
                }, null);
                setProp(_el$132, "className", "AttributeLabel");
                effect(_$p => setProp(_el$132, "text", `${sAttributeID} ${SpanText(sVal, 'Val')}`, _$p));
                return _el$132;
              })();
            }));
            effect(_p$ => {
              const _v$10 = classNames("AttributeInfo", "Modifier", {
                  'Debuff': getBuff().IsDebuff()
                }),
                _v$11 = `${getBuff().GetName()}(${getBuff().GetSerialNumber()})`;
              _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$129, "className", _v$10, _p$._v$10));
              _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$130, "text", _v$11, _p$._v$11));
              return _p$;
            }, {
              _v$10: undefined,
              _v$11: undefined
            });
            return _el$129;
          })();
        }
      }), null);
      return _el$124;
    })();
  }
  function DummyOverHead() {
    var _a;
    const [getDummy] = useNetEventTable(t => {
      return t;
    }, 'dummy', 'demo_dummy');
    return (() => {
      const _el$133 = createElement("Panel", {
        id: "DummyOverHead",
        hittest: false
      }, null);
      insert(_el$133, createComponent(Index, {
        get each() {
          return Object.keys((_a = getDummy()) !== null && _a !== void 0 ? _a : []);
        },
        children: (k, i) => {
          var _a;
          const iEntID = Number((_a = getDummy()) === null || _a === void 0 ? void 0 : _a[k()]);
          return createComponent(DummyBar, {
            iEntID: iEntID
          });
        }
      }));
      return _el$133;
    })();
  }
  function DummyBar({
    iEntID
  }) {
    let ref;
    let refHealthProgress;
    let refCountDownBar;
    let refTotalDamage = 0;
    let refStartTime = Game.GetGameTime();
    let refEndTime = Game.GetGameTime() + 5;
    let refCount = 0;
    const [getTotalDamage, setTotalDamage] = createSignal(0);
    const [getDps, setDps] = createSignal(0);
    const [getLastDamage, setLastDamage] = createSignal(0);
    const [getCount, setCount] = createSignal(0);
    const [getDamageData, setDamageData] = createSignal({
      'ability': {},
      'polymer': {},
      'attack': {
        'count': 0,
        'damage': {}
      }
    });
    {
      const id = Timer(() => {
        if (ref == undefined) return 0;
        UpdateOverheadPanel(ref, iEntID, {
          no_health_bar: false
        });
        return 0;
      }, 0, undefined, 'Debug.DummyBar');
      onCleanup(() => {
        StopTimer(id);
      });
    }
    {
      let tDamageData = {
        'ability': {},
        'polymer': {},
        'attack': {
          'count': 0,
          'damage': {}
        }
      };
      const h = GameEvents.Subscribe("dummy_hurt", tData => {
        var _a, _b, _c;
        let damage = Number(tData.damage);
        if (tData.entindex_killed == iEntID) {
          if (refCount == 0) {
            refStartTime = Game.GetGameTime();
          }
          refCount = refCount + 1;
          setCount(refCount);
          refTotalDamage = refTotalDamage + damage;
          setTotalDamage(refTotalDamage);
          const fTime = Game.GetGameTime() - refStartTime;
          const fDps = fTime <= 0 ? refTotalDamage : refTotalDamage / fTime;
          setDps(fDps);
          setLastDamage(damage);
          refEndTime = Game.GetGameTime() + 5;
          if (tData.damage_category == 1) {
            if (tDamageData.attack == undefined) {
              tDamageData.attack = {
                'count': 0,
                'damage': {}
              };
            }
            tDamageData.attack.count++;
            tDamageData.attack.damage[String(tData.damage_type)] = ((_a = tDamageData.attack.damage[String(tData.damage_type)]) !== null && _a !== void 0 ? _a : 0) + Number(tData.damage);
            setDamageData(tDamageData);
          } else if (tData.entindex_inflictor_ability != undefined) {
            const sAbltName = Abilities.GetAbilityName(tData.entindex_inflictor_ability);
            if (tDamageData.ability == undefined) {
              tDamageData.ability = {};
            }
            if (tDamageData.ability[sAbltName] == undefined) {
              tDamageData.ability[sAbltName] = {
                'count': 0,
                'damage': {}
              };
            }
            tDamageData.ability[sAbltName].count++;
            tDamageData.ability[sAbltName].damage[String(tData.damage_type)] = ((_b = tDamageData.ability[sAbltName].damage[String(tData.damage_type)]) !== null && _b !== void 0 ? _b : 0) + Number(tData.damage);
            setDamageData(tDamageData);
          } else if (tData.entindex_inflictor_polymer != undefined) {
            const hPlm = FindPolymerByID(tData.entindex_attacker, tData.entindex_inflictor_polymer);
            if (hPlm != undefined) {
              if (tDamageData.polymer == undefined) {
                tDamageData.polymer = {};
              }
              if (tDamageData.polymer[hPlm.GetName()] == undefined) {
                tDamageData.polymer[hPlm.GetName()] = {
                  'count': 0,
                  'damage': {}
                };
              }
              tDamageData.polymer[hPlm.GetName()].count++;
              tDamageData.polymer[hPlm.GetName()].damage[String(tData.damage_type)] = ((_c = tDamageData.polymer[hPlm.GetName()].damage[String(tData.damage_type)]) !== null && _c !== void 0 ? _c : 0) + Number(tData.damage);
              setDamageData(tDamageData);
            }
          }
        }
      });
      const i = Timer(() => {
        if (refCountDownBar && refCount != 0) {
          refCountDownBar.value = Clamp((refEndTime - Game.GetGameTime()) / 5, 0, 1);
          const bEndTime = Game.GetGameTime() >= refEndTime;
          refCountDownBar.SetHasClass("ShowCountdown", !bEndTime);
          if (bEndTime) {
            setCount(0);
            setTotalDamage(0);
            setDps(0);
            setLastDamage(0);
            refTotalDamage = 0;
            refCount = 0;
            setDamageData({
              'ability': {},
              'polymer': {},
              'attack': {
                'count': 0,
                'damage': {}
              }
            });
            tDamageData = {
              'ability': {},
              'polymer': {},
              'attack': {
                'count': 0,
                'damage': {}
              }
            };
          }
        }
        const fHealthPercent = Entities.GetHealth(iEntID) / Entities.GetMaxHealth(iEntID);
        if (refHealthProgress && refHealthProgress['fLastHealthPercent'] != fHealthPercent) {
          refHealthProgress['fLastHealthPercent'] = fHealthPercent;
          refHealthProgress.FindChildTraverse("HealthProgress_Left").style.width = fHealthPercent * 100 + "%";
          refHealthProgress.FindChildTraverse("HealthProgress_Loss").style.width = fHealthPercent * 100 + "%";
        }
        return 0;
      }, -1, undefined, 'Debug.DummyBar');
      onCleanup(() => {
        StopTimer(i);
        GameEvents.Unsubscribe(h);
      });
    }
    return (() => {
      const _el$134 = createElement("Panel", {
          id: "DummyBar",
          hittest: false,
          onmouseout: HideTooltip
        }, null),
        _el$135 = createElement("Panel", {
          id: "Bar"
        }, _el$134),
        _el$136 = createElement("Panel", {
          id: "HealthProgress"
        }, _el$135);
        createElement("Panel", {
          id: "HealthProgress_Loss"
        }, _el$136);
        createElement("Panel", {
          id: "HealthProgress_Left"
        }, _el$136);
        const _el$139 = createElement("Panel", {
          id: "TestRecord"
        }, _el$134),
        _el$140 = createElement("ProgressBar", {
          id: "TestRecordCountdownBar",
          value: 0
        }, _el$139),
        _el$141 = createElement("Panel", {}, _el$139),
        _el$142 = createElement("Label", {
          text: "总伤害"
        }, _el$141),
        _el$143 = createElement("Label", {
          text: "{s:total_damage}",
          get dialogVariables() {
            return {
              total_damage: FormatNumber(getTotalDamage())
            };
          }
        }, _el$141),
        _el$144 = createElement("Panel", {}, _el$139),
        _el$145 = createElement("Label", {
          text: "DPS："
        }, _el$144),
        _el$146 = createElement("Label", {
          text: "{s:dps}",
          get dialogVariables() {
            return {
              dps: FormatNumber(getDps())
            };
          }
        }, _el$144),
        _el$147 = createElement("Panel", {}, _el$139),
        _el$148 = createElement("Label", {
          text: "最后一次伤害"
        }, _el$147),
        _el$149 = createElement("Label", {
          text: "{s:last_damage}",
          get dialogVariables() {
            return {
              last_damage: FormatNumber(getLastDamage())
            };
          }
        }, _el$147),
        _el$150 = createElement("Panel", {}, _el$139),
        _el$151 = createElement("Label", {
          text: "伤害次数"
        }, _el$150),
        _el$152 = createElement("Label", {
          text: "{s:count}",
          get dialogVariables() {
            return {
              count: FormatNumber(getCount())
            };
          }
        }, _el$150);
      const _ref$2 = ref;
      typeof _ref$2 === "function" ? use(_ref$2, _el$134) : ref = _el$134;
      setProp(_el$134, "onmouseover", p => {});
      setProp(_el$134, "onmouseout", HideTooltip);
      insert(_el$134, (() => {
        const _el$153 = createElement("Panel", {
            id: "UnitName"
          }, null),
          _el$154 = createElement("Panel", {}, _el$153);
        setProp(_el$153, "onactivate", () => {});
        setProp(_el$154, "className", "BG");
        return _el$153;
      })(), _el$135);
      const _ref$3 = refHealthProgress;
      typeof _ref$3 === "function" ? use(_ref$3, _el$136) : refHealthProgress = _el$136;
      const _ref$4 = refCountDownBar;
      typeof _ref$4 === "function" ? use(_ref$4, _el$140) : refCountDownBar = _el$140;
      setProp(_el$141, "className", "TestRecordRow");
      setProp(_el$142, "className", "TestRecordRowLeft");
      setProp(_el$143, "className", "TestRecordRowRight");
      setProp(_el$144, "className", "TestRecordRow");
      setProp(_el$145, "className", "TestRecordRowLeft");
      setProp(_el$146, "className", "TestRecordRowRight");
      setProp(_el$147, "className", "TestRecordRow");
      setProp(_el$148, "className", "TestRecordRowLeft");
      setProp(_el$149, "className", "TestRecordRowRight");
      setProp(_el$150, "className", "TestRecordRow");
      setProp(_el$151, "className", "TestRecordRowLeft");
      setProp(_el$152, "className", "TestRecordRowRight");
      effect(_p$ => {
        const _v$12 = {
            total_damage: FormatNumber(getTotalDamage())
          },
          _v$13 = {
            dps: FormatNumber(getDps())
          },
          _v$14 = {
            last_damage: FormatNumber(getLastDamage())
          },
          _v$15 = {
            count: FormatNumber(getCount())
          };
        _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$143, "dialogVariables", _v$12, _p$._v$12));
        _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$146, "dialogVariables", _v$13, _p$._v$13));
        _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$149, "dialogVariables", _v$14, _p$._v$14));
        _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$152, "dialogVariables", _v$15, _p$._v$15));
        return _p$;
      }, {
        _v$12: undefined,
        _v$13: undefined,
        _v$14: undefined,
        _v$15: undefined
      });
      return _el$134;
    })();
  }
  print(NetEventData.GetTableValue('tower', 'unit_data'));

}));