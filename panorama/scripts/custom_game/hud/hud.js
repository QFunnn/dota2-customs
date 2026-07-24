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
  function on(deps, fn, options) {
    const isArray = Array.isArray(deps);
    let prevInput;
    return prevValue => {
      let input;
      if (isArray) {
        input = Array(deps.length);
        for (let i = 0; i < deps.length; i++) input[i] = deps[i]();
      } else input = deps();
      const result = untrack(() => fn(input, prevInput, prevValue));
      prevInput = input;
      return result;
    };
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
  const { render: _render, effect, memo, createComponent, createElement, createTextNode, insert, spread, setProp, mergeProps, use } = createRenderer({
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

  var _a$1, _b, _c, _d, _e;
  if (GameUI.CustomUIConfig().tools == undefined) GameUI.CustomUIConfig().tools = {};
  ENV_NAME = $.GetContextPanel().layoutfile;
  var EventManager = (_a$1 = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a$1, "EventManager"), _a$1.sEnvName = ENV_NAME, _a$1);
  var NetEventData = (_b = class extends GameUI.CustomUIConfig().tools.NetEventData {}, __setFunctionName(_b, "NetEventData"), _b.sEnvName = ENV_NAME, _b);
  var Keybinds = (_c = class extends GameUI.CustomUIConfig().tools.Keybinds {}, __setFunctionName(_c, "Keybinds"), _c.sEnvName = ENV_NAME, _c);
  var Mousebinds = (_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {}, __setFunctionName(_d, "Mousebinds"), _d.sEnvName = ENV_NAME, _d);
  GameUI.CustomUIConfig().tools.ParticleManager_s2c;
  GameUI.CustomUIConfig().tools.AttributeSystem;
  var AttributeKind$1 = GameUI.CustomUIConfig().tools.AttributeKind;
  var _Timer = (_e = class extends GameUI.CustomUIConfig().tools.Timer {}, __setFunctionName(_e, "_Timer"), _e.sEnvName = ENV_NAME, _e);
  var Timer = _Timer.Timer.bind(_Timer);
  var GameTimer = _Timer.GameTimer.bind(_Timer);
  var StopTimer = _Timer.StopTimer.bind(_Timer);
  var _Player = GameUI.CustomUIConfig().tools.Player;
  var PlayerCount = _Player.PlayerCount.bind(_Player);
  var PlayerHost = _Player.PlayerHost.bind(_Player);
  _Player.PlayerCount_NotDisconnected.bind(_Player);
  _Player.PlayerCount_NotAbandoned.bind(_Player);
  _Player.IsValidPlayer.bind(_Player);
  _Player.IsFakePlayer.bind(_Player);
  var EachPlayer = _Player.EachPlayer.bind(_Player);
  _Player.RandomPlayer.bind(_Player);
  _Player.FocusPlayer.bind(_Player);
  _Player.IsPlayerDisconnected.bind(_Player);
  _Player.IsPlayerAbandoned.bind(_Player);
  var Player_EntityToID = _Player.Player_EntityToID.bind(_Player);
  _Player.Player_IDToOrder.bind(_Player);
  _Player.Player_OrderToID.bind(_Player);
  var Player_IDToAccount = _Player.Player_IDToAccount.bind(_Player);
  _Player.Player_AccountToID.bind(_Player);
  _Player.PlayerLanguage.bind(_Player);
  var runlua = GameUI.CustomUIConfig().tools.runlua;
  var EntIndexToHScript = GameUI.CustomUIConfig().tools.EntIndexToHScript;
  GameUI.CustomUIConfig().tools.BuffToModifier;
  GameUI.CustomUIConfig().tools.PolymerIDToDiyPolymer;
  var AbilitiesKv = GameUI.CustomUIConfig()['AbilitiesKv'];
  GameUI.CustomUIConfig()['HeroesKv'];
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
  function Lerp(percent, a, b) {
    return a + percent * (b - a);
  }
  function RemapValClamped(num, a, b, c, d) {
    if (a == b) return c;
    var percent = (num - a) / (b - a);
    percent = Clamp(percent, 0.0, 1.0);
    return Lerp(percent, c, d);
  }
  function RandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
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
  function IsEmptyObject(obj) {
    for (let _ in obj) return false;
    return true;
  }
  function GetSystemConfig(sCfg) {
    var _a;
    GameUI.CustomUIConfig()['__config__'] = (_a = GameUI.CustomUIConfig()['__config__']) !== null && _a !== void 0 ? _a : {};
    if (GameUI.CustomUIConfig()['__config__'][sCfg] != undefined) return GameUI.CustomUIConfig()['__config__'][sCfg];
    return GameUI.CustomUIConfig()['__config__'][sCfg] = GameUI.CustomUIConfig().tools.runlua(`return _G['${sCfg}']`);
  }
  function ErrorMsg(sMsg, sSound = 'General.CastFail_Custom') {
    GameUI.SendCustomHUDError(sMsg, sSound);
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

  const getter_iLocalPlayer = useLocalPlayer();

  function FadeShow(props) {
    const [getData, setData] = createSignal();
    const [getRoot, setRoot] = createSignal();
    createEffect(() => {
      var _a, _b;
      const root = getRoot();
      const data = props.data;
      if (data) {
        if (root == undefined) {
          setData(data);
        } else if (!root.BHasClass('FadeShow')) {
          root.AddClass('FadeShow');
          if (props.fade_in) {
            root.AddClass('FadeIn');
            const id = (props.bUseGameTime ? GameTimer : Timer)(() => {
              root.RemoveClass('FadeIn');
            }, props.fade_in, undefined, 'FadeShow.FadeIn');
            onCleanup(() => {
              if (root === null || root === void 0 ? void 0 : root.IsValid()) {
                root.RemoveClass('FadeIn');
              }
              StopTimer(id);
            });
          }
        } else if (root.BHasClass('FadeOut')) {
          batch(() => {
            setData(undefined);
          });
          (_a = props.onFadedOut) === null || _a === void 0 ? void 0 : _a.call(props);
        } else {
          setData(data);
        }
      } else {
        if (root) {
          if (props.fade_out) {
            root.AddClass('FadeOut');
            let id;
            id = (props.bUseGameTime ? GameTimer : Timer)(() => {
              var _a;
              batch(() => {
                setData(undefined);
              });
              (_a = props.onFadedOut) === null || _a === void 0 ? void 0 : _a.call(props);
            }, props.fade_out, undefined, 'FadeShow.FadeOut');
            onCleanup(() => {
              StopTimer(id);
            });
          } else {
            batch(() => {
              setData(undefined);
            });
            (_b = props.onFadedOut) === null || _b === void 0 ? void 0 : _b.call(props);
          }
        }
      }
    });
    return memo((() => {
      const _c$ = memo(() => !!getData());
      return () => _c$() ? memo(() => children(() => {
        const element = props.children(getData);
        if (element.paneltype != undefined) {
          setRoot(element);
        }
        return element;
      })) : (() => {
        setRoot(undefined);
        return undefined;
      })();
    })());
  }
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
    {
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
  function useAltDown() {
    const [sign, setSign] = createSignal(GameUI.IsAltDown());
    if (!GameUI.CustomUIConfig().tools.Timer.HasTimer('__use_alt_down__')) {
      let b = GameUI.IsAltDown();
      Timer(() => {
        if (GameUI.IsAltDown() != b) {
          b = GameUI.IsAltDown();
          EventManager.Fire('__use_alt_down__', b);
        }
        return 0;
      }, 0, '__use_alt_down__');
    }
    const id = EventManager.Reg('__use_alt_down__', b => {
      setSign(b);
    });
    onCleanup(() => {
      EventManager.Unreg('__use_alt_down__', id);
    });
    return sign;
  }
  function useControlDown() {
    const [sign, setSign] = createSignal(GameUI.IsControlDown());
    if (!GameUI.CustomUIConfig().tools.Timer.HasTimer('__use_control_down__')) {
      let b = GameUI.IsControlDown();
      Timer(() => {
        if (GameUI.IsControlDown() != b) {
          b = GameUI.IsControlDown();
          EventManager.Fire('__use_control_down__', b);
        }
        return 0.1;
      }, 0.1, '__use_control_down__');
    }
    const id = EventManager.Reg('__use_control_down__', b => {
      setSign(b);
    });
    onCleanup(() => {
      EventManager.Unreg('__use_control_down__', id);
    });
    return sign;
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
  function useFocusPlayer() {
    const [getPlayerID, setPlayerID] = createSignal(Players.GetLocalPlayer());
    const id = Timer(() => {
      let iPlayerID = Players.GetLocalPlayer();
      const iEntID = Players.GetLocalPlayerPortraitUnit();
      if (Entities.IsRealHero(iEntID)) {
        if (Players.IsValidPlayerID(Entities.GetPlayerOwnerID(iEntID))) {
          iPlayerID = Entities.GetPlayerOwnerID(iEntID);
        }
      }
      if (iPlayerID != getPlayerID()) {
        setPlayerID(iPlayerID);
      }
      return 0.1;
    }, 0, undefined, 'useFocusPlayer');
    onCleanup(() => {
      StopTimer(id);
    });
    return getPlayerID;
  }
  function useSystemConfig(sCfg) {
    const [sign, setSign] = createSignal();
    if (sign() == undefined) {
      const id = Timer(() => {
        let _ = GetSystemConfig(sCfg);
        if (_ == undefined) return 0.1;
        setSign(_);
      }, 0.1, undefined, 'useSystemConfig');
      const id2 = EventManager.Reg('ON_SERVICE_LOAD', () => {
        setSign(GetSystemConfig(sCfg));
      });
      onCleanup(() => {
        StopTimer(id);
        EventManager.Unreg('ON_SERVICE_LOAD', id2);
      });
    }
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
  const PctUnitAttributes = {
    [AttributeKind.Main.PCT.name]: '%',
    [AttributeKind.Main.AMP.name]: '%',
    [AttributeKind.Secondary.PCT.name]: '%',
    [AttributeKind.Secondary.AMP.name]: '%',
    [AttributeKind.AllStats.PCT.name]: '%',
    [AttributeKind.AllStats.AMP.name]: '%',
    [AttributeKind.Strength.PCT.name]: '%',
    [AttributeKind.Strength.AMP.name]: '%',
    [AttributeKind.Agility.PCT.name]: '%',
    [AttributeKind.Agility.AMP.name]: '%',
    [AttributeKind.Intellect.PCT.name]: '%',
    [AttributeKind.Intellect.AMP.name]: '%',
    [AttributeKind.Atk.PCT.name]: '%',
    [AttributeKind.Atk.AMP.name]: '%',
    [AttributeKind.PhyFixDmg.PCT.name]: '%',
    [AttributeKind.PhyFixDmg.AMP.name]: '%',
    [AttributeKind.MgcFixDmg.PCT.name]: '%',
    [AttributeKind.MgcFixDmg.AMP.name]: '%',
    [AttributeKind.AtkPure.PCT.name]: '%',
    [AttributeKind.AtkPure.AMP.name]: '%',
    [AttributeKind.HpLimit.PCT.name]: '%',
    [AttributeKind.HpLimit.AMP.name]: '%',
    [AttributeKind.HpRegen.PCT.name]: '%',
    [AttributeKind.HpRegen.AMP.name]: '%',
    [AttributeKind.HpRegen.HP_PCT.name]: '%',
    [AttributeKind.MpLimit.PCT.name]: '%',
    [AttributeKind.MpLimit.AMP.name]: '%',
    [AttributeKind.MpRegen.PCT.name]: '%',
    [AttributeKind.MpRegen.AMP.name]: '%',
    [AttributeKind.MpRegen.MP_PCT.name]: '%',
    [AttributeKind.Armor.PCT.name]: '%',
    [AttributeKind.Armor.AMP.name]: '%',
    [AttributeKind.AtkSpd.PCT.name]: '%',
    [AttributeKind.MoveSpd.PCT.name]: '%',
    [AttributeKind.AtkRange.PCT.name]: '%',
    [AttributeKind.PrjctSpd.PCT.name]: '%',
    [AttributeKind.CastRange.PCT.name]: '%',
    [AttributeKind.Cooldown.PCT.name]: '%',
    [AttributeKind.StaResist.name]: '%',
    [AttributeKind.DebuffAmp.name]: '%',
    [AttributeKind.Heal.name]: '%',
    [AttributeKind.ModelScale.PCT.name]: '%',
    [AttributeKind.ArmorPenetrate.PCT.name]: '%',
    [AttributeKind.ArmorPenetrate.AMP.name]: '%',
    [AttributeKind.ArmorIgnore.name]: '%',
    [AttributeKind.ArmorIgnore.BASE.name]: '%',
    [AttributeKind.PhyCritChance.name]: '%',
    [AttributeKind.PhyCritChance.BASE.name]: '%',
    [AttributeKind.MgcCritChance.name]: '%',
    [AttributeKind.MgcCritChance.BASE.name]: '%',
    [AttributeKind.PureCritChance.name]: '%',
    [AttributeKind.PureCritChance.BASE.name]: '%',
    [AttributeKind.PhyCritDmg.name]: '%',
    [AttributeKind.PhyCritDmg.BASE.name]: '%',
    [AttributeKind.MgcCritDmg.name]: '%',
    [AttributeKind.MgcCritDmg.BASE.name]: '%',
    [AttributeKind.PureCritDmg.name]: '%',
    [AttributeKind.PureCritDmg.BASE.name]: '%',
    [AttributeKind.MultDmg.name]: '%',
    [AttributeKind.BounceDmg.name]: '%',
    [AttributeKind.CleaveDmg.name]: '%',
    [AttributeKind.CreepDmg.name]: '%',
    [AttributeKind.CreepDmg.BASE.name]: '%',
    [AttributeKind.EliteDmg.name]: '%',
    [AttributeKind.EliteDmg.BASE.name]: '%',
    [AttributeKind.ChallengeDmg.name]: '%',
    [AttributeKind.ChallengeDmg.BASE.name]: '%',
    [AttributeKind.BossDmg.name]: '%',
    [AttributeKind.BossDmg.BASE.name]: '%',
    [AttributeKind.AtkDmg.name]: '%',
    [AttributeKind.AtkDmg.BASE.name]: '%',
    [AttributeKind.AbltDmg.name]: '%',
    [AttributeKind.AbltDmg.BASE.name]: '%',
    [AttributeKind.PhyDmg.name]: '%',
    [AttributeKind.PhyDmg.BASE.name]: '%',
    [AttributeKind.MgcDmg.name]: '%',
    [AttributeKind.MgcDmg.BASE.name]: '%',
    [AttributeKind.PureDmg.name]: '%',
    [AttributeKind.PureDmg.BASE.name]: '%',
    [AttributeKind.AllDmg.name]: '%',
    [AttributeKind.AllDmg.BASE.name]: '%',
    [AttributeKind.DmgFinal.name]: '%',
    [AttributeKind.DmgFinal.BASE.name]: '%',
    [AttributeKind.DmgReduce.name]: '%',
    [AttributeKind.DmgReduce.BASE.name]: '%',
    [AttributeKind.GoldPct.name]: '%',
    [AttributeKind.WoodPct.name]: '%',
    [AttributeKind.KillPct.name]: '%',
    [AttributeKind.ExpPct.name]: '%',
    [AttributeKind.RespawnChance.name]: '%',
    [AttributeKind.RespawnTime.PCT.name]: '%',
    [AttributeKind.SummonDoubleChance.name]: '%',
    [AttributeKind.SummonDuration.name]: '%',
    [AttributeKind.SummonDmg.name]: '%',
    [AttributeKind.HolyDmg.name]: '%',
    [AttributeKind.HolyDmg.BASE.name]: '%',
    [AttributeKind.NatureDmg.name]: '%',
    [AttributeKind.NatureDmg.BASE.name]: '%',
    [AttributeKind.FrostDmg.name]: '%',
    [AttributeKind.FrostDmg.BASE.name]: '%',
    [AttributeKind.FireDmg.name]: '%',
    [AttributeKind.FireDmg.BASE.name]: '%',
    [AttributeKind.PhysicalDmg.name]: '%',
    [AttributeKind.PhysicalDmg.BASE.name]: '%',
    [AttributeKind.ShadowDmg.name]: '%',
    [AttributeKind.ShadowDmg.BASE.name]: '%',
    [AttributeKind.AllFlagDmg.name]: '%',
    [AttributeKind.HolyPenetrate.name]: '%',
    [AttributeKind.NaturePenetrate.name]: '%',
    [AttributeKind.FrostPenetrate.name]: '%',
    [AttributeKind.FirePenetrate.name]: '%',
    [AttributeKind.PhysicalPenetrate.name]: '%',
    [AttributeKind.ShadowPenetrate.name]: '%',
    [AttributeKind.HolyResist.name]: '%',
    [AttributeKind.NatureResist.name]: '%',
    [AttributeKind.FrostResist.name]: '%',
    [AttributeKind.FireResist.name]: '%',
    [AttributeKind.PhysicalResist.name]: '%',
    [AttributeKind.ShadowResist.name]: '%',
    [AttributeKind.GainDoubleChance.name]: '%',
    [AttributeKind.GainDoubleChance.BASE.name]: '%',
    [AttributeKind.DoubleCastChance.name]: '%',
    [AttributeKind.DoubleCastChance.BASE.name]: '%',
    [AttributeKind.AtkPureChance.name]: '%',
    [AttributeKind.MgcPureChance.name]: '%',
    [AttributeKind.AtkCleaveChance.name]: '%',
    [AttributeKind.AtkCleaveChance.BASE.name]: '%',
    [AttributeKind.AtkCleaveDmg.name]: '%',
    [AttributeKind.PureCleaveChance.name]: '%',
    [AttributeKind.PureCleaveChance.BASE.name]: '%',
    [AttributeKind.PureCleaveDmg.name]: '%',
    [AttributeKind.AtkBadDmgChance.name]: '%',
    [AttributeKind.AtkBadDmgChance.BASE.name]: '%',
    [AttributeKind.AtkBadDmg.name]: '%',
    [AttributeKind.AtkBadDuration.name]: '%',
    [AttributeKind.BadEffect.name]: '%',
    [AttributeKind.CardEffect.name]: '%',
    [AttributeKind.FatalBlow.name]: '%',
    [AttributeKind.BurnDmg.name]: '%',
    [AttributeKind.IceDmg.name]: '%',
    [AttributeKind.ChallengeDuration.name]: '%',
    [AttributeKind.SpawnRatePct.name]: '%',
    [AttributeKind.VertRefreshSR.name]: '%',
    [AttributeKind.VertRefreshSSR.name]: '%',
    [AttributeKind.StrGain.PCT.name]: '%',
    [AttributeKind.StrGain.AMP.name]: '%',
    [AttributeKind.AgiGain.PCT.name]: '%',
    [AttributeKind.AgiGain.AMP.name]: '%',
    [AttributeKind.IntGain.PCT.name]: '%',
    [AttributeKind.IntGain.AMP.name]: '%',
    [AttributeKind.AtkGain.PCT.name]: '%',
    [AttributeKind.AtkGain.AMP.name]: '%',
    [AttributeKind.AtkPureGain.PCT.name]: '%',
    [AttributeKind.AtkPureGain.AMP.name]: '%',
    [AttributeKind.HpGain.PCT.name]: '%',
    [AttributeKind.HpGain.AMP.name]: '%',
    [AttributeKind.PhyFixedGain.PCT.name]: '%',
    [AttributeKind.PhyFixedGain.AMP.name]: '%',
    [AttributeKind.MgcFixedGain.PCT.name]: '%',
    [AttributeKind.MgcFixedGain.AMP.name]: '%',
    [AttributeKind.KillGoldPct.name]: '%',
    [AttributeKind.KillWoodPct.name]: '%',
    [AttributeKind.KillKillPct.name]: '%',
    [AttributeKind.KillExpPct.name]: '%',
    [AttributeKind.GameShopDiscount.name]: '%',
    [AttributeKind.BaseAtkDmg.name]: '%',
    [AttributeKind.ShadowArrowDmg.name]: '%',
    [AttributeKind.ShadowArrowCooldown.name]: '%',
    [AttributeKind.ShadowArrowAoeDmg.name]: '%',
    [AttributeKind.ShadowArrowAoeRadius.name]: '%',
    [AttributeKind.ShadowSecondaryArrowDmg.name]: '%',
    [AttributeKind.GameShopRefreshCostReduce.name]: '%',
    [AttributeKind.WeaponStatsPct.name]: '%',
    [AttributeKind.BlazingArrowHitDmg.name]: '%',
    [AttributeKind.BlazingArrowBoomDmg.name]: '%',
    [AttributeKind.BlazingArrowDmg.name]: '%',
    [AttributeKind.BlazingArrowAoeRadius.name]: '%',
    [AttributeKind.BlazingArrowCooldown.name]: '%',
    [AttributeKind.IceArrowDmg.name]: '%',
    [AttributeKind.IceArrowProjectSpd.name]: '%',
    [AttributeKind.SmallIceArrowDmg.name]: '%',
    [AttributeKind.SkyThunderDmg.name]: '%',
    [AttributeKind.MagneticStormDmg.name]: '%',
    [AttributeKind.MagneticStormRadius.name]: '%',
    [AttributeKind.EMFieldDmg.name]: '%',
    [AttributeKind.BlitzballDmg.name]: '%',
    [AttributeKind.SwordDmg.name]: '%',
    [AttributeKind.SwordProjectSpd.name]: '%',
    [AttributeKind.SwordScale.name]: '%',
    [AttributeKind.SwordCooldown.name]: '%',
    [AttributeKind.ArcaneLaserDmg.name]: '%',
    [AttributeKind.ArcaneLaserKeepTime.name]: '%',
    [AttributeKind.ArcaneLaserCooldown.name]: '%',
    [AttributeKind.ArcaneLaserRadius.name]: '%',
    [AttributeKind.ArcaneRayDmg.name]: '%',
    [AttributeKind.ArcaneRayKeepTime.name]: '%',
    [AttributeKind.FrostNovaDmg.name]: '%',
    [AttributeKind.FrostNovaRadius.name]: '%',
    [AttributeKind.FrostNovaCooldown.name]: '%',
    [AttributeKind.IceArrowCooldown.name]: '%',
    [AttributeKind.LightningChainDmg.name]: '%',
    [AttributeKind.LonBlastingRadius.name]: '%',
    [AttributeKind.LonBlastingDmg.name]: '%',
    [AttributeKind.LightningChainCooldown.name]: '%',
    [AttributeKind.SkyThunderCooldown.name]: '%',
    [AttributeKind.EarthQuakeDmg.name]: '%',
    [AttributeKind.EarthQuakeRadius.name]: '%',
    [AttributeKind.EmbersDmg.name]: '%',
    [AttributeKind.TornadoDmg.name]: '%',
    [AttributeKind.TornadoKeepTime.name]: '%',
    [AttributeKind.TornadoRadius.name]: '%',
    [AttributeKind.TornadoMoveSpd.name]: '%',
    [AttributeKind.DianCiWangDmg.name]: '%',
    [AttributeKind.DianCiWangRadius.name]: '%',
    [AttributeKind.DianCiWangCooldown.name]: '%',
    [AttributeKind.MeteoriteDmg.name]: '%',
    [AttributeKind.MeteoriteCooldown.name]: '%',
    [AttributeKind.MeteoriteRadius.name]: '%',
    [AttributeKind.FireBallDmg.name]: '%',
    [AttributeKind.FireBallKeepTime.name]: '%',
    [AttributeKind.FireBallRadius.name]: '%',
    [AttributeKind.FireBallMoveSpd.name]: '%',
    [AttributeKind.BurntFrostDmg.name]: '%',
    [AttributeKind.HurricaneDmg.name]: '%',
    [AttributeKind.VacuumDmg.name]: '%',
    [AttributeKind.Main.AMP_1.name]: '%',
    [AttributeKind.Secondary.AMP_1.name]: '%',
    [AttributeKind.AllStats.AMP_1.name]: '%',
    [AttributeKind.Strength.AMP_1.name]: '%',
    [AttributeKind.Agility.AMP_1.name]: '%',
    [AttributeKind.Intellect.AMP_1.name]: '%',
    [AttributeKind.Atk.AMP_1.name]: '%',
    [AttributeKind.AtkPure.AMP_1.name]: '%',
    [AttributeKind.PhyFixDmg.AMP_1.name]: '%',
    [AttributeKind.MgcFixDmg.AMP_1.name]: '%',
    [AttributeKind.HpLimit.AMP_1.name]: '%',
    [AttributeKind.Armor.AMP_1.name]: '%',
    [AttributeKind.HolyAbilitySpellRadius.name]: '%',
    [AttributeKind.NatureAbilitySpellRadius.name]: '%',
    [AttributeKind.FrostAbilitySpellRadius.name]: '%',
    [AttributeKind.FireAbilitySpellRadius.name]: '%',
    [AttributeKind.PhysicalAbilitySpellRadius.name]: '%',
    [AttributeKind.ShadowAbilitySpellRadius.name]: '%',
    [AttributeKind.HolyAbilityCooldown.name]: '%',
    [AttributeKind.NatureAbilityCooldown.name]: '%',
    [AttributeKind.FrostAbilityCooldown.name]: '%',
    [AttributeKind.FireAbilityCooldown.name]: '%',
    [AttributeKind.PhysicalAbilityCooldown.name]: '%',
    [AttributeKind.ShadowAbilityCooldown.name]: '%',
    [AttributeKind.HolyReduceResistPct.name]: '%',
    [AttributeKind.NatureReduceResistPct.name]: '%',
    [AttributeKind.FrostReduceResistPct.name]: '%',
    [AttributeKind.FireReduceResistPct.name]: '%',
    [AttributeKind.PhysicalReduceResistPct.name]: '%',
    [AttributeKind.ShadowReduceResistPct.name]: '%',
    [AttributeKind.MiningSpd.name]: '%',
    [AttributeKind.GameShopCostReduce.name]: '%',
    [AttributeKind.ArchiveDmg.name]: '%',
    [AttributeKind.ArchiveDmg.BASE.name]: '%',
    [AttributeKind.Main.AMP_2.name]: '%',
    [AttributeKind.Secondary.AMP_2.name]: '%',
    [AttributeKind.AllStats.AMP_2.name]: '%',
    [AttributeKind.Strength.AMP_2.name]: '%',
    [AttributeKind.Agility.AMP_2.name]: '%',
    [AttributeKind.Intellect.AMP_2.name]: '%',
    [AttributeKind.Atk.AMP_2.name]: '%',
    [AttributeKind.AtkPure.AMP_2.name]: '%',
    [AttributeKind.PhyFixDmg.AMP_2.name]: '%',
    [AttributeKind.MgcFixDmg.AMP_2.name]: '%',
    [AttributeKind.HpLimit.AMP_2.name]: '%',
    [AttributeKind.Armor.AMP_2.name]: '%',
    [AttributeKind.ThunderDmgFactor.name]: '%',
    [AttributeKind.ArcaneRayCooldown.name]: '%',
    [AttributeKind.LightningBounceCount.name]: '%',
    [AttributeKind.EarthquakeCooldown.name]: '%',
    [AttributeKind.TornadoCooldown.name]: '%',
    [AttributeKind.HurricaneCooldown.name]: '%',
    [AttributeKind.FireballCooldown.name]: '%',
    [AttributeKind.FinalDamageCalculation.name]: '%',
    [AttributeKind.Main.AMP_3.name]: '%',
    [AttributeKind.Secondary.AMP_3.name]: '%',
    [AttributeKind.AllStats.AMP_3.name]: '%',
    [AttributeKind.Strength.AMP_3.name]: '%',
    [AttributeKind.Agility.AMP_3.name]: '%',
    [AttributeKind.Intellect.AMP_3.name]: '%',
    [AttributeKind.Atk.AMP_3.name]: '%',
    [AttributeKind.AtkPure.AMP_3.name]: '%',
    [AttributeKind.PhyFixDmg.AMP_3.name]: '%',
    [AttributeKind.MgcFixDmg.AMP_3.name]: '%',
    [AttributeKind.HpLimit.AMP_3.name]: '%',
    [AttributeKind.Armor.AMP_3.name]: '%',
    [AttributeKind.StrGain.AMP_3.name]: '%',
    [AttributeKind.AgiGain.AMP_3.name]: '%',
    [AttributeKind.IntGain.AMP_3.name]: '%',
    [AttributeKind.AtkGain.AMP_3.name]: '%',
    [AttributeKind.PhyFixedGain.AMP_3.name]: '%',
    [AttributeKind.MgcFixedGain.AMP_3.name]: '%',
    [AttributeKind.HpGain.AMP_3.name]: '%',
    [AttributeKind.PhyCritDmg.AMP.name]: '%',
    [AttributeKind.MgcCritDmg.AMP.name]: '%',
    [AttributeKind.CreepDmg.AMP.name]: '%',
    [AttributeKind.EliteDmg.AMP.name]: '%',
    [AttributeKind.ChallengeDmg.AMP.name]: '%',
    [AttributeKind.BossDmg.AMP.name]: '%',
    [AttributeKind.AtkDmg.AMP.name]: '%',
    [AttributeKind.AbltDmg.AMP.name]: '%',
    [AttributeKind.PhyDmg.AMP.name]: '%',
    [AttributeKind.MgcDmg.AMP.name]: '%',
    [AttributeKind.PureDmg.AMP.name]: '%',
    [AttributeKind.HolyDmg.AMP.name]: '%',
    [AttributeKind.NatureDmg.AMP.name]: '%',
    [AttributeKind.FrostDmg.AMP.name]: '%',
    [AttributeKind.FireDmg.AMP.name]: '%',
    [AttributeKind.PhysicalDmg.AMP.name]: '%',
    [AttributeKind.ShadowDmg.AMP.name]: '%',
    [AttributeKind.FinalDamageCalculation1.name]: '%',
    [AttributeKind.HolyDmg.AMP2.name]: '%',
    [AttributeKind.NatureDmg.AMP2.name]: '%',
    [AttributeKind.FrostDmg.AMP2.name]: '%',
    [AttributeKind.FireDmg.AMP2.name]: '%',
    [AttributeKind.PhysicalDmg.AMP2.name]: '%',
    [AttributeKind.ShadowDmg.AMP2.name]: '%',
    [AttributeKind.FinalHpRegen.name]: '%',
    [AttributeKind.AtkSpd.TOTAL.name]: '%',
    [AttributeKind.DmgAmp.name]: '%',
    [AttributeKind.AllDmg.AMP.name]: '%',
    [AttributeKind.FinalAllDmg.name]: '%',
    [AttributeKind.FinalPhyDmg.name]: '%',
    [AttributeKind.FinalMagDmg.name]: '%',
    [AttributeKind.Main.AMP_4.name]: '%',
    [AttributeKind.Secondary.AMP_4.name]: '%',
    [AttributeKind.AllStats.AMP_4.name]: '%',
    [AttributeKind.Strength.AMP_4.name]: '%',
    [AttributeKind.Agility.AMP_4.name]: '%',
    [AttributeKind.Intellect.AMP_4.name]: '%',
    [AttributeKind.Atk.AMP_4.name]: '%',
    [AttributeKind.PhyFixDmg.AMP_4.name]: '%',
    [AttributeKind.MgcFixDmg.AMP_4.name]: '%',
    [AttributeKind.AtkPure.AMP_4.name]: '%',
    [AttributeKind.HpLimit.AMP_4.name]: '%',
    [AttributeKind.Armor.AMP_4.name]: '%',
    [AttributeKind.PhyCritDmg.AMP_1.name]: '%',
    [AttributeKind.MgcCritDmg.AMP_1.name]: '%',
    [AttributeKind.PureCritDmg.AMP_1.name]: '%',
    [AttributeKind.CreepDmg.AMP_1.name]: '%',
    [AttributeKind.EliteDmg.AMP_1.name]: '%',
    [AttributeKind.ChallengeDmg.AMP_1.name]: '%',
    [AttributeKind.BossDmg.AMP_1.name]: '%',
    [AttributeKind.ArchiveDmg.AMP_1.name]: '%',
    [AttributeKind.AtkDmg.AMP_1.name]: '%',
    [AttributeKind.AbltDmg.AMP_1.name]: '%',
    [AttributeKind.PhyDmg.AMP_1.name]: '%',
    [AttributeKind.MgcDmg.AMP_1.name]: '%',
    [AttributeKind.PureDmg.AMP_1.name]: '%',
    [AttributeKind.AllDmg.AMP_1.name]: '%',
    [AttributeKind.DmgFinal.AMP_1.name]: '%',
    [AttributeKind.HolyDmg.AMP_1.name]: '%',
    [AttributeKind.NatureDmg.AMP_1.name]: '%',
    [AttributeKind.FrostDmg.AMP_1.name]: '%',
    [AttributeKind.FireDmg.AMP_1.name]: '%',
    [AttributeKind.PhysicalDmg.AMP_1.name]: '%',
    [AttributeKind.ShadowDmg.AMP_1.name]: '%'
  };

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
  function YellowText(text, className = "") {
    return ColorText(text, "#ffff00", className);
  }
  function RedText(text, className = "") {
    return ColorText(text, "#ff0000", className);
  }
  function GreenText(text, className = "") {
    return ColorText(text, "#00ff00", className);
  }
  function SpanText(text, className = "") {
    return `<span class="${className}">${text}</span>`;
  }
  function ColorText(text, color, className = "") {
    const sClass = className != "" ? `class="${className}"` : undefined;
    if (sClass) return `<font color="${color}" ${sClass} >${text}</font>`;
    return `<font color="${color}">${text}</font>`;
  }
  function Str2RewardMap(s, separator = '|') {
    let t = {};
    const rws = s.split(separator);
    for (const rw of rws) {
      const [k, v] = rw.split('=');
      t[k] = v;
    }
    return t;
  }

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

  function PlayerAvatar(props) {
    var _a;
    const tPlayerInfo = createMemo(() => {
      if (typeof props.iPlayerID == 'function') {
        return Game.GetPlayerInfo(props.iPlayerID());
      }
      return Game.GetPlayerInfo(props.iPlayerID);
    });
    return (() => {
      const _el$3 = createElement("Panel", props, null);
      spread(_el$3, mergeProps(props, {
        get className() {
          return classNames("PlayerAvatar", props.className);
        }
      }), true);
      insert(_el$3, () => (() => {
        const _el$4 = createElement("DOTAAvatarImage", {
          get steamid() {
            return (_a = tPlayerInfo()) === null || _a === void 0 ? void 0 : _a.player_steamid;
          },
          get onactivate() {
            return props.onactivate;
          }
        }, null);
        setProp(_el$4, "style", {
          width: '100%',
          height: '100%',
          align: 'center center'
        });
        effect(_p$ => {
          const _v$ = (_a = tPlayerInfo()) === null || _a === void 0 ? void 0 : _a.player_steamid,
            _v$2 = props.onactivate;
          _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$4, "steamid", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$4, "onactivate", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$4;
      })());
      return _el$3;
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

  function AttrVal2Str(attrid, val, ratio = 1) {
    var _a, _b;
    const name = (_a = ID2Attribute[attrid]) === null || _a === void 0 ? void 0 : _a.name;
    if (name == undefined) return "";
    const sPct = (_b = PctUnitAttributes[name]) !== null && _b !== void 0 ? _b : "";
    return (val > 0 ? "+" : "") + NumFixRatio(val, ratio) + sPct;
  }
  function NumFixRatio(val, ratio) {
    return Math.floor(val * Math.pow(10, ratio)) / Math.pow(10, ratio);
  }
  function Str2RewardList(str = "") {
    return str.split('|').map(s => s.split('=').map(v => Number(v)));
  }

  const CfgGetter_shop_items = useSystemConfig('shop_items');

  const CfgGetter_mining_props = useSystemConfig('mining_props');

  const CfgGetter_mining_drop = useSystemConfig('mining_drop');

  const CfgGetter_mining_collect = useSystemConfig('mining_collect');

  const CfgGetter_cosplay = useSystemConfig('cosplay');

  const CfgGetter_shop = useSystemConfig('shop');

  const CfgGetter_equip_collect = useSystemConfig('equip_collect');

  const CfgGetter_qizhen = useSystemConfig('qizhen_collect');

  function TipsPanel() {
    let LastTIP = 1;
    let tick = 5;
    for (let i = 1; i < 1000; i++) {
      const key = "#LoadingTip_" + i;
      const sLoc = $.Localize(key);
      if (key == sLoc) {
        break;
      }
      LastTIP = i;
    }
    const [index, SetIndex] = createSignal(1);
    function NextTip() {
      let rnd = RandomInt(1, LastTIP);
      for (let i = 0; i < 100; i++) {
        if (rnd == index()) {
          rnd = RandomInt(1, LastTIP);
        } else {
          break;
        }
      }
      SetIndex(rnd);
    }
    createEffect(() => {
      index();
      let id = $.Schedule(tick, NextTip);
      onCleanup(() => {
        try {
          $.CancelScheduled(id);
        } catch (error) {}
      });
    });
    return (() => {
      const _el$12 = createElement("Panel", {
          id: "TipContainer"
        }, null),
        _el$13 = createElement("Panel", {}, _el$12),
        _el$14 = createElement("Panel", {}, _el$12),
        _el$15 = createElement("Panel", {
          id: "TipText"
        }, _el$14),
        _el$16 = createElement("Label", {
          id: "TipLabel",
          html: true,
          get text() {
            return "#LoadingTip_" + index();
          }
        }, _el$15),
        _el$17 = createElement("Panel", {
          id: "NextTip"
        }, _el$14);
      setProp(_el$12, "onactivate", NextTip);
      setProp(_el$13, "className", "BG");
      setProp(_el$14, "className", "Body");
      setProp(_el$17, "className", "TipButton");
      setProp(_el$17, "onactivate", NextTip);
      effect(_$p => setProp(_el$16, "text", "#LoadingTip_" + index(), _$p));
      return _el$12;
    })();
  }
  function GetRes(type, iPlayerID) {
    var _a, _b;
    return (_b = (_a = NetEventData.GetTableValue('resource', String(iPlayerID))) === null || _a === void 0 ? void 0 : _a[type]) !== null && _b !== void 0 ? _b : 0;
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
  function Yzy_ProgressBar(params) {
    const [local, props] = splitProps(params, ['value', 'min', 'max', 'children']);
    const getValue = () => {
      var _a;
      return (_a = local.value) !== null && _a !== void 0 ? _a : 0;
    };
    const getMin = () => {
      var _a;
      return (_a = local.min) !== null && _a !== void 0 ? _a : 0;
    };
    const getMax = () => {
      var _a;
      return (_a = local.max) !== null && _a !== void 0 ? _a : 100;
    };
    const getWidth = createMemo(() => {
      if (local.max == 0) {
        return 100;
      }
      return Clamp(Round(finiteNumber((getValue() - getMin()) / (getMax() - getMin()) * 100), 2), 0, 100);
    });
    return (() => {
      const _el$43 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_ProgressBar', props.class, props.className);
          },
          hittest: false
        }), null),
        _el$44 = createElement("Panel", {
          "class": "Yzy_ProgressBar_Left",
          get style() {
            return {
              'width': getWidth() + '%'
            };
          }
        }, _el$43),
        _el$45 = createElement("Panel", {
          "class": "Yzy_ProgressBar_Right",
          get style() {
            return {
              'width': 100 - getWidth() + '%'
            };
          }
        }, _el$43);
      spread(_el$43, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ProgressBar', props.class, props.className);
        },
        "hittest": false
      }), true);
      insert(_el$43, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      effect(_p$ => {
        const _v$ = {
            'width': getWidth() + '%'
          },
          _v$2 = {
            'width': 100 - getWidth() + '%'
          };
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$44, "style", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$45, "style", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$43;
    })();
  }
  function Yzy_Button(params) {
    const [local, props] = splitProps(params, ['type', 'size', 'text', 'children']);
    const getBtnType = () => {
      var _a;
      return (_a = params.type) !== null && _a !== void 0 ? _a : "btn_purple";
    };
    const getBtnSize = () => {
      var _a;
      return (_a = params.size) !== null && _a !== void 0 ? _a : 'Normal';
    };
    return (() => {
      const _el$46 = createElement("Button", mergeProps(props, {
          get ["class"]() {
            return classNames("Yzy_Button", getBtnType(), getBtnSize(), props.class, props.className);
          }
        }), null);
        createElement("Panel", {
          "class": "Image"
        }, _el$46);
      spread(_el$46, mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Button", getBtnType(), getBtnSize(), props.class, props.className);
        }
      }), true);
      insert(_el$46, createComponent(Show, {
        get when() {
          return local.text;
        },
        get children() {
          const _el$48 = createElement("Label", {
            "class": "Text",
            get text() {
              return local.text;
            },
            hittest: false,
            html: true,
            get dialogVariables() {
              return props.dialogVariables;
            }
          }, null);
          effect(_p$ => {
            const _v$3 = local.text,
              _v$4 = props.dialogVariables;
            _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$48, "text", _v$3, _p$._v$3));
            _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$48, "dialogVariables", _v$4, _p$._v$4));
            return _p$;
          }, {
            _v$3: undefined,
            _v$4: undefined
          });
          return _el$48;
        }
      }), null);
      insert(_el$46, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      return _el$46;
    })();
  }
  function Yzy_Icon(params) {
    const [local, props] = splitProps(params, ['type', 'hittest', 'children']);
    const getHittest = () => local.hittest !== undefined ? local.hittest : true;
    return (() => {
      const _el$49 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_Icon', local.type, props.class, props.className);
          },
          get hittest() {
            return getHittest();
          }
        }), null),
        _el$50 = createElement("Panel", {
          "class": "Icon",
          get hittest() {
            return getHittest();
          }
        }, _el$49);
      spread(_el$49, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_Icon', local.type, props.class, props.className);
        },
        get hittest() {
          return getHittest();
        }
      }), true);
      insert(_el$49, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      effect(_$p => setProp(_el$50, "hittest", getHittest(), _$p));
      return _el$49;
    })();
  }
  function Yzy_IconButton(params) {
    const [local, props] = splitProps(params, ['type', 'text', 'children']);
    return (() => {
      const _el$51 = createElement("Button", mergeProps(props, {
          get ["class"]() {
            return classNames("Yzy_IconButton", local.type, props.class, props.className);
          }
        }), null);
        createElement("Panel", {
          "class": "Icon"
        }, _el$51);
      spread(_el$51, mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_IconButton", local.type, props.class, props.className);
        }
      }), true);
      insert(_el$51, createComponent(Show, {
        get when() {
          return local.text;
        },
        get children() {
          const _el$53 = createElement("Label", {
            "class": "Text",
            get text() {
              return local.text;
            },
            hittest: false,
            html: true
          }, null);
          effect(_$p => setProp(_el$53, "text", local.text, _$p));
          return _el$53;
        }
      }), null);
      insert(_el$51, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      return _el$51;
    })();
  }
  function Yzy_Attribute(params) {
    const [local, props] = splitProps(params, ['id', 'val', 'children']);
    const getName = () => {
      var _a, _b, _c, _d, _e, _f;
      if (local.id.startsWith('118')) {
        if (local.id.startsWith('1180')) {
          return ReplaceAbltSpecialVals('privilege_' + local.id, $.Localize("#privilege_" + local.id + '_desc'));
        }
        return ReplaceTextVariable("#" + local.id, {
          val: ((_c = (_b = (_a = AbilitiesKv['privilege_' + local.id]) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b['val']) !== null && _c !== void 0 ? _c : 1) * local.val
        });
      } else if (local.id.startsWith('178')) {
        return ReplaceTextVariable('#hero_challenge_enemy_' + local.id + '_desc', {
          val: ((_f = (_e = (_d = AbilitiesKv['hero_challenge_enemy_' + local.id]) === null || _d === void 0 ? void 0 : _d['AbilityValues']) === null || _e === void 0 ? void 0 : _e['val']) !== null && _f !== void 0 ? _f : 1) * local.val
        });
      }
      return $.Localize("#" + local.id);
    };
    const getSign = () => local.val < 0 ? '' : '+';
    const getVal = () => {
      var _a, _b, _c;
      return `${Number(((_a = local.val) !== null && _a !== void 0 ? _a : 0).toFixed(2))}${(_c = PctUnitAttributes[(_b = ID2Attribute[local.id]) === null || _b === void 0 ? void 0 : _b.name]) !== null && _c !== void 0 ? _c : ''}`;
    };
    const getText = () => {
      if (local.id == '10600083') {
        return getSign() + getVal();
      }
      return local.val < 0 ? RedText(getSign() + getVal()) : getSign() + getVal();
    };
    return (() => {
      const _el$55 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_Attribute', props.class);
          }
        }), null),
        _el$56 = createElement("Label", {
          get text() {
            return getName();
          },
          html: true
        }, _el$55);
      spread(_el$55, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_Attribute', props.class);
        }
      }), true);
      setProp(_el$56, "className", "Name");
      insert(_el$55, createComponent(Show, {
        get when() {
          return memo(() => !!!local.id.startsWith('118'))() && !local.id.startsWith('178');
        },
        get children() {
          const _el$57 = createElement("Label", {
            get text() {
              return getText();
            },
            html: true
          }, null);
          setProp(_el$57, "className", "Value");
          effect(_$p => setProp(_el$57, "text", getText(), _$p));
          return _el$57;
        }
      }), null);
      insert(_el$55, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      effect(_$p => setProp(_el$56, "text", getName(), _$p));
      return _el$55;
    })();
  }
  function Yzy_Description(params) {
    const [local, props] = splitProps(params, ['name', 'text']);
    const getDescription = () => {
      var _a;
      if (local.name != undefined && $.Localize('#' + local.name + '_Description') != '#' + local.name + '_Description') {
        return ReplaceAbltVals(local.name, $.Localize("#" + local.name + '_Description'));
      }
      return (_a = local === null || local === void 0 ? void 0 : local.text) !== null && _a !== void 0 ? _a : '';
    };
    return (() => {
      const _el$58 = createElement("Label", mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Description", props.class, props.className);
        },
        get text() {
          return getDescription();
        },
        hittest: false,
        html: true
      }), null);
      spread(_el$58, mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Description", props.class, props.className);
        },
        get text() {
          return getDescription();
        },
        "hittest": false,
        "html": true
      }), false);
      return _el$58;
    })();
  }
  function Yzy_ServiceItem(params) {
    const [local, props] = splitProps(params, ['data', 'rarity', 'notooltip', 'nobg', 'nocount', 'children']);
    const getItem = () => local.data;
    const getItemID = () => {
      var _a;
      return (_a = getItem()) === null || _a === void 0 ? void 0 : _a.id;
    };
    const getItemType = () => {
      const id = String(getItemID());
      if (id.length >= 3) {
        return Number(id.substring(0, 3));
      }
      return undefined;
    };
    const getItemCount = () => {
      var _a;
      return ((_a = getItem()) === null || _a === void 0 ? void 0 : _a.count) || 0;
    };
    const getItemName = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
      if (getItemType() == 210) {
        return `#EquipInfoTitle_${(_b = (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b.part}_${(_d = (_c = getItem()) === null || _c === void 0 ? void 0 : _c.equips) === null || _d === void 0 ? void 0 : _d.class}`;
      }
      if (getItemType() == 214) {
        if (!((_e = getItem()) === null || _e === void 0 ? void 0 : _e.gems)) {
          if ($.Localize("#" + getItemID()) != '#' + getItemID()) {
            return $.Localize("#" + getItemID());
          }
          return $.Localize("#" + getItemType());
        }
      }
      if (getItemType() == 211) {
        return $.Localize("#" + getItemType());
      }
      if (getItemType() == 226) {
        if ((_f = getItem()) === null || _f === void 0 ? void 0 : _f.holies) {
          return `#HolyInfoTitle_${(_h = (_g = getItem()) === null || _g === void 0 ? void 0 : _g.holies) === null || _h === void 0 ? void 0 : _h.part}_${(_k = (_j = getItem()) === null || _j === void 0 ? void 0 : _j.holies) === null || _k === void 0 ? void 0 : _k.rarity}`;
        }
        return $.Localize("#" + getItemType());
      }
      return $.Localize("#" + getItemID());
    };
    const getItemDescription = () => {
      var _a, _b, _c, _d, _e, _f, _g;
      if ([216, 119].includes((_a = getItemType()) !== null && _a !== void 0 ? _a : 0)) {
        return '';
      }
      if (getItemType() == 214) {
        if (!((_b = getItem()) === null || _b === void 0 ? void 0 : _b.gems)) {
          return $.Localize("#" + getItemType() + '_Description');
        }
      } else if (getItemType() == 303) {
        const item = (_c = CfgGetter_mining_props()) === null || _c === void 0 ? void 0 : _c[(_d = getItemID()) !== null && _d !== void 0 ? _d : ''];
        if (item) {
          return ReplaceTextVariable(`#Mode1_Props_Tooltip_${item.id}_Desc`, {
            limit: (_e = Str2RewardMap(item.effect)) === null || _e === void 0 ? void 0 : _e[1185005],
            interval: item.interval,
            extar2: item.extra_chance.split('|')[0],
            extar3: item.extra_chance.split('|')[1]
          }) + '<br />' + $.Localize(`#Mode1_Props_Tooltip_${item.id}_Source`);
        }
      } else if (getItemType() == 211) {
        if (!((_f = getItem()) === null || _f === void 0 ? void 0 : _f.ancients)) {
          return $.Localize("#" + getItemType() + '_Description');
        }
      } else if (getItemType() == 226) {
        if (!((_g = getItem()) === null || _g === void 0 ? void 0 : _g.holies)) {
          return $.Localize("#" + getItemType() + '_Description');
        }
      }
      if ($.Localize("#" + getItemID() + '_Description') != "#" + getItemID() + '_Description') {
        return $.Localize("#" + getItemID() + '_Description');
      }
    };
    const getItemAttribute = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q, _r, _s, _t, _u;
      if (getItemType() == 216) {
        return (_d = (_c = (_a = CfgGetter_cosplay()) === null || _a === void 0 ? void 0 : _a[(_b = getItemID()) !== null && _b !== void 0 ? _b : '']) === null || _c === void 0 ? void 0 : _c['item_effect']) === null || _d === void 0 ? void 0 : _d.split('|');
      } else if (getItemType() == 119) {
        return (_j = (_h = (_g = (_e = CfgGetter_mining_collect()) === null || _e === void 0 ? void 0 : _e[(_f = getItemID()) !== null && _f !== void 0 ? _f : '']) === null || _g === void 0 ? void 0 : _g.effect) === null || _h === void 0 ? void 0 : _h.split('|')) !== null && _j !== void 0 ? _j : [];
      } else if (getItemType() == '175') {
        return (_p = (_o = (_m = (_k = CfgGetter_qizhen()) === null || _k === void 0 ? void 0 : _k[(_l = getItemID()) !== null && _l !== void 0 ? _l : '']) === null || _m === void 0 ? void 0 : _m.effect) === null || _o === void 0 ? void 0 : _o.split('|')) !== null && _p !== void 0 ? _p : [];
      } else if (getItemType() == '172') {
        return (_u = (_t = (_s = (_q = CfgGetter_equip_collect()) === null || _q === void 0 ? void 0 : _q[(_r = getItemID()) !== null && _r !== void 0 ? _r : '']) === null || _s === void 0 ? void 0 : _s.effect) === null || _t === void 0 ? void 0 : _t.split('|')) !== null && _u !== void 0 ? _u : [];
      }
      return [];
    };
    const getItemRarity = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q, _r, _s, _t, _u, _v, _w, _x;
      if (params.rarity != undefined) {
        return params.rarity;
      } else if (getItemType() == 210) {
        return (_b = (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b.rarity;
      } else if (getItemType() == 172) {
        return (_e = (_c = CfgGetter_equip_collect()) === null || _c === void 0 ? void 0 : _c[(_d = getItemID()) !== null && _d !== void 0 ? _d : '']) === null || _e === void 0 ? void 0 : _e.rarity;
      } else if (getItemType() == 214 && ((_f = getItem()) === null || _f === void 0 ? void 0 : _f.gems)) {
        return (_h = (_g = getItem()) === null || _g === void 0 ? void 0 : _g.gems) === null || _h === void 0 ? void 0 : _h.rarity;
      } else if (getItemType() == 211 && ((_j = getItem()) === null || _j === void 0 ? void 0 : _j.ancients)) {
        return (_l = (_k = getItem()) === null || _k === void 0 ? void 0 : _k.ancients) === null || _l === void 0 ? void 0 : _l.class;
      } else if (getItemType() == 226 && ((_m = getItem()) === null || _m === void 0 ? void 0 : _m.holies)) {
        return (_p = (_o = getItem()) === null || _o === void 0 ? void 0 : _o.holies) === null || _p === void 0 ? void 0 : _p.rarity;
      } else if (getItemType() == '175') {
        return (_s = (_q = CfgGetter_qizhen()) === null || _q === void 0 ? void 0 : _q[(_r = getItemID()) !== null && _r !== void 0 ? _r : '']) === null || _s === void 0 ? void 0 : _s['rarity'];
      }
      if (((_v = (_t = CfgGetter_shop_items()) === null || _t === void 0 ? void 0 : _t[(_u = getItemID()) !== null && _u !== void 0 ? _u : '']) === null || _v === void 0 ? void 0 : _v['rarity']) != undefined) {
        return (_x = (_w = CfgGetter_shop_items()) === null || _w === void 0 ? void 0 : _w[getItemID()]) === null || _x === void 0 ? void 0 : _x['rarity'];
      }
      return 1;
    };
    const getItemImage = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q, _r;
      if (getItemType() == 210) {
        return `file://{images}/custom_game/service/equip/equip_part/equip_${(_b = (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b.part}_${(_d = (_c = getItem()) === null || _c === void 0 ? void 0 : _c.equips) === null || _d === void 0 ? void 0 : _d.class}.png`;
      } else if (getItemType() == 214) {
        if (((_f = (_e = getItem()) === null || _e === void 0 ? void 0 : _e.gems) === null || _f === void 0 ? void 0 : _f.rarity) == undefined) {
          return `file://{images}/custom_game/service/items/214.png`;
        }
        return `file://{images}/custom_game/service/equip/gem_part/gem_${getItemRarity() || 1}.png`;
      } else if (getItemType() == 211) {
        if (((_g = getItem()) === null || _g === void 0 ? void 0 : _g.ancients) == undefined) {
          return `file://{images}/custom_game/service/items/211.png`;
        }
        return `file://{images}/custom_game/service/equip/equip_part/ancient_${(_j = (_h = getItem()) === null || _h === void 0 ? void 0 : _h.ancients) === null || _j === void 0 ? void 0 : _j.part}_${(_l = (_k = getItem()) === null || _k === void 0 ? void 0 : _k.ancients) === null || _l === void 0 ? void 0 : _l.class}.png`;
      } else if (getItemType() == 226) {
        if (((_m = getItem()) === null || _m === void 0 ? void 0 : _m.holies) == undefined) {
          return `file://{images}/custom_game/service/items/226.png`;
        }
        return `file://{images}/custom_game/service/equip/equip_part/holy_${(_p = (_o = getItem()) === null || _o === void 0 ? void 0 : _o.holies) === null || _p === void 0 ? void 0 : _p.part}_${(_r = (_q = getItem()) === null || _q === void 0 ? void 0 : _q.holies) === null || _r === void 0 ? void 0 : _r.rarity}.png`;
      }
      return `file://{images}/custom_game/service/items/${getItemID()}.png`;
    };
    return (() => {
      const _el$59 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_ServiceItem', 'Rarity_' + getItemRarity(), props.class, props.className);
          },
          onmouseout: HideTooltip
        }), null),
        _el$61 = createElement("Image", {
          id: "ItemImage",
          get src() {
            return getItemImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect"
        }, _el$59);
      spread(_el$59, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ServiceItem', 'Rarity_' + getItemRarity(), props.class, props.className);
        },
        "onmouseover": p => {
          var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
          if (local.notooltip) return;
          if (getItemType() == 210) {
            ShowTooltip(p, 'equip_tooltip', {
              type: 'Equip',
              data: (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips
            });
            return;
          }
          if (getItemType() == 214 && ((_b = getItem()) === null || _b === void 0 ? void 0 : _b.gems)) {
            ShowTooltip(p, 'equip_tooltip', {
              type: 'Gem',
              data: (_c = getItem()) === null || _c === void 0 ? void 0 : _c.gems
            });
            return;
          }
          if (getItemType() == 211 && ((_d = getItem()) === null || _d === void 0 ? void 0 : _d.ancients)) {
            ShowTooltip(p, 'equip_tooltip', {
              type: 'Ancient',
              data: (_e = getItem()) === null || _e === void 0 ? void 0 : _e.ancients
            });
            return;
          }
          if (getItemType() == 226 && ((_f = getItem()) === null || _f === void 0 ? void 0 : _f.holies)) {
            ShowTooltip(p, 'equip_tooltip', {
              type: 'Holy',
              data: (_g = getItem()) === null || _g === void 0 ? void 0 : _g.holies
            });
            return;
          }
          if (getItemType() == 171) {
            ShowTooltip(p, 'common_detail_tooltip', {
              sTitle: String($.Localize(`#${getItemID()}`)),
              tGroups: Str2RewardList((_l = (_k = (_h = CfgGetter_mining_drop()) === null || _h === void 0 ? void 0 : _h[(_j = getItemID()) !== null && _j !== void 0 ? _j : '']) === null || _k === void 0 ? void 0 : _k.reward) !== null && _l !== void 0 ? _l : []).map(item => {
                return {
                  'sContext': $.Localize(`#${item[0]}`) + ' x ' + String(item[1])
                };
              })
            });
            return;
          }
          if (getItemType() == 201) {
            ShowTooltip(p, 'shopitem_tooltip', {
              'tShopItemCfg': (_m = CfgGetter_shop()) === null || _m === void 0 ? void 0 : _m[getItemID()]
            });
            return;
          }
          ShowTooltip(p, 'common_detail_tooltip', {
            'sImg': getItemImage(),
            'sTitle': getItemName(),
            'sContext': getItemDescription(),
            'iRarity': getItemRarity(),
            'tAttribute': getItemAttribute()
          });
        },
        "onmouseout": HideTooltip
      }), true);
      insert(_el$59, createComponent(Show, {
        get when() {
          return !local.nobg;
        },
        get children() {
          return createElement("Panel", {
            "class": "BG"
          }, null);
        }
      }), _el$61);
      insert(_el$59, createComponent(Show, {
        get when() {
          return memo(() => !!!local.nocount)() && getItemCount() > 1;
        },
        get children() {
          const _el$62 = createElement("Label", {
            id: "ItemCount",
            get text() {
              return 'x' + getItemCount();
            }
          }, null);
          effect(_$p => setProp(_el$62, "text", 'x' + getItemCount(), _$p));
          return _el$62;
        }
      }), null);
      insert(_el$59, () => children(() => local === null || local === void 0 ? void 0 : local.children), null);
      effect(_$p => setProp(_el$61, "src", getItemImage(), _$p));
      return _el$59;
    })();
  }
  function Yzy_ServiceItemName(params) {
    const [local, props] = splitProps(params, ['data', 'bShowCount', 'iAttrRatio', 'rarity']);
    const getShowCount = () => local.bShowCount !== undefined ? local.bShowCount : false;
    const getItem = () => local.data;
    const getItemID = () => {
      var _a;
      return (_a = getItem()) === null || _a === void 0 ? void 0 : _a.id;
    };
    const getItemType = () => {
      const id = getItemID();
      if (typeof id === "string" && id.length >= 3) {
        return Number(id.substring(0, 3));
      }
      return undefined;
    };
    const getItemName = () => {
      var _a, _b, _c, _d, _e, _f;
      switch (getItemType()) {
        case 210:
          return `#EquipInfoTitle_${(_b = (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b.part}_${(_d = (_c = getItem()) === null || _c === void 0 ? void 0 : _c.equips) === null || _d === void 0 ? void 0 : _d.class}`;
        case 106:
          const sName = $.Localize("#" + getItemID());
          if (!getShowCount()) {
            return SpanText(sName, 'AttributeName');
          }
          const sValue = AttrVal2Str(Number(getItemID()), Number((_e = getItem()) === null || _e === void 0 ? void 0 : _e.count), local.iAttrRatio);
          return SpanText(sValue, 'AttributeValue') + ' ' + SpanText(sName, 'AttributeName');
        default:
          return $.Localize("#" + getItemID()) + (getShowCount() ? "x" + ((_f = getItem()) === null || _f === void 0 ? void 0 : _f.count) : '');
      }
    };
    const getItemRarity = () => {
      var _a, _b;
      if (getItemType() == 210) {
        return (_b = (_a = getItem()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b.rarity;
      }
      return params.rarity;
    };
    return createComponent(Yzy_Label, mergeProps(props, {
      html: true,
      get ["class"]() {
        return classNames('Yzy_ServiceItemName', props.class, props.className);
      },
      get rarity() {
        return getItemRarity();
      },
      get text() {
        return getItemName();
      }
    }));
  }
  function Yzy_ServiceAssetCost(params) {
    const [local, props] = splitProps(params, ['cost', 'extra_cost_pct', 'has_item_count']);
    return (() => {
      const _el$63 = createElement("Panel", mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ServiceAssetCost', props.class, props.className);
        }
      }), null);
      spread(_el$63, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ServiceAssetCost', props.class, props.className);
        }
      }), true);
      insert(_el$63, createComponent(For, {
        get each() {
          return Object.entries(local.cost);
        },
        children: t => {
          const getItemID = () => t[0];
          const getItemCount = () => t[1];
          const getItemImage = () => `file://{images}/custom_game/service/items/${getItemID()}.png`;
          return (() => {
            const _el$64 = createElement("Panel", {
                "class": "AssetCostRow"
              }, null),
              _el$65 = createElement("Image", {
                id: "ItemImage",
                get src() {
                  return getItemImage();
                },
                scaling: "stretch-to-fit-x-preserve-aspect"
              }, _el$64),
              _el$66 = createElement("Label", {
                id: "ItemCount",
                get text() {
                  return getItemCount();
                }
              }, _el$64);
            effect(_p$ => {
              const _v$5 = getItemImage(),
                _v$6 = getItemCount();
              _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$65, "src", _v$5, _p$._v$5));
              _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$66, "text", _v$6, _p$._v$6));
              return _p$;
            }, {
              _v$5: undefined,
              _v$6: undefined
            });
            return _el$64;
          })();
        }
      }));
      return _el$63;
    })();
  }
  function Yzy_ServiceTokenImage(params) {
    const [local, props] = splitProps(params, ['item_id']);
    return (() => {
      const _el$67 = createElement("Image", mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ServiceTokenImage', props.class, props.className);
        },
        get src() {
          return `file://{images}/custom_game/service/tokens/${local.item_id}.png`;
        },
        scaling: "stretch-to-fit-y-preserve-aspect"
      }), null);
      spread(_el$67, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_ServiceTokenImage', props.class, props.className);
        },
        get src() {
          return `file://{images}/custom_game/service/tokens/${local.item_id}.png`;
        },
        "scaling": "stretch-to-fit-y-preserve-aspect"
      }), false);
      return _el$67;
    })();
  }

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

  const ServGetter_UserCheckoutWaveStar = useNetEventTable(t => t, 'service', () => 'UserCheckoutWaveStar_' + getter_iLocalPlayer())[0];

  const CfgGetter_settings_common = useSystemConfig('settings_common');

  function GetStoreValue(k) {
    const tp = GameUI.CustomUIConfig()['__UseStoreType_' + k];
    const v = GameUI.CustomUIConfig()['__UseStore_' + k];
    if (tp && v) {
      if (tp !== 'object') {
        return v;
      } else {
        return JSON.parse(v);
      }
    }
    return undefined;
  }

  const ServGetter_UserItem = useNetEventTable(t => t, 'service', () => 'UserItem_' + getter_iLocalPlayer())[0];

  function ServiceItemAsset(props) {
    const [params, other_props] = splitProps(props, ['item_id', 'count']);
    const getter = PropsGetter(params);
    const getCount = () => {
      var _a, _b, _c;
      return getter.count ? getter.count() : (_c = (_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a[String(getter.item_id())]) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
    };
    const getDes = () => "#" + getter.item_id() + '_Description';
    return (() => {
      const _el$16 = createElement("Panel", mergeProps(other_props, {
          get ["class"]() {
            return classNames("ServiceItemAsset", props.class, {
              HasAddBtn: props.onAdd != undefined
            });
          },
          onmouseout: HideTooltip
        }), null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$16);
        const _el$18 = createElement("Panel", {
          "class": "Body"
        }, _el$16),
        _el$19 = createElement("Label", {
          "class": "AssetCount",
          get text() {
            return getCount();
          },
          html: true
        }, _el$18);
      spread(_el$16, mergeProps(other_props, {
        get ["class"]() {
          return classNames("ServiceItemAsset", props.class, {
            HasAddBtn: props.onAdd != undefined
          });
        },
        "onmouseover": p => {
          ShowTooltip(p, 'common_detail_tooltip', {
            'sTitle': String("#" + getter.item_id()),
            'sContext': getDes()
          });
        },
        "onmouseout": HideTooltip
      }), true);
      insert(_el$18, createComponent(Yzy_ServiceTokenImage, {
        "class": "AssetImage",
        get item_id() {
          return getter.item_id();
        }
      }), _el$19);
      insert(_el$18, createComponent(Show, {
        get when() {
          return props.onAdd;
        },
        get children() {
          return createComponent(Yzy_IconButton, {
            type: "icon_btn_add",
            onactivate: () => props.onAdd()
          });
        }
      }), null);
      effect(_$p => setProp(_el$19, "text", getCount(), _$p));
      return _el$16;
    })();
  }
  function SwitchServicePage(sPage = '') {
    if (GetStoreValue('ServicePage') == sPage) return;
    GameUI.CustomUIConfig().tools.EventManager.Fire('ServicePageSwitch', sPage);
  }

  function ShowPopup(sPopup, params) {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/ShowPopup', {
      'sPopup': sPopup,
      'params': Object.assign({}, params)
    });
  }
  function ShowProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/ShowProcessing', true);
  }
  function HideProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/ShowProcessing', false);
  }
  function ShowMouseProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseProcessing', true);
  }
  function HideMouseProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseProcessing', false);
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

  const ServGetter_UserDiffPass1 = useNetEventTable(t => t, 'service', () => 'UserDiffPass1_' + getter_iLocalPlayer())[0];

  const ServGetter_UserGetLimit = useNetEventTable(t => t, 'service', () => 'UserGetLimit_' + getter_iLocalPlayer())[0];

  const CfgGetter_hero_challenge = useSystemConfig('hero_challenge');

  const CfgGetter_get_limit = useSystemConfig('get_limit');

  const getLocalPlayerID = useLocalPlayer();
  const isHost = createMemo(() => PlayerHost() == getLocalPlayerID());
  function GsSelection() {
    var _a, _b, _c, _d, _e, _f, _g;
    let refDifficultListPanel = undefined;
    const [getGameState] = useNetEventTable(t => t, 'common', 'game_state');
    const [getMode, setMode] = createSignal(0);
    const [getDifficult, setDifficult] = createSignal(1);
    const [getSubDifficult, setSubDifficult] = createSignal(0);
    const getCurMaxDifficult = 20;
    const getCurMaxDifficultMolten = 22;
    const [getUnlockDifficult] = useNetEventTable(t => {
      const i = t || 1;
      if (i >= getCurMaxDifficult + 1) {
        setMode(2);
        setDifficult(Math.min(Math.max(i - 1, getCurMaxDifficultMolten), getCurMaxDifficultMolten));
      } else if (getMode() == 0) {
        setDifficult(Math.min(Math.max(i - 1, 1), getCurMaxDifficult));
      } else if (getMode() == 2) {
        setDifficult(Math.min(Math.max(i - 1, getCurMaxDifficultMolten), getCurMaxDifficultMolten));
      }
      return i;
    }, 'gs_selection', () => 'difficult');
    const getWaveReward = useSystemConfig('wave_reward');
    const getDiffList = createMemo(() => {
      const cfg = getWaveReward();
      if (!cfg) return [];
      if (getMode() == 2) {
        return Object.keys(cfg).filter(key => Number(key) > getCurMaxDifficult) || [];
      }
      return Object.keys(cfg).filter(key => Number(key) <= getCurMaxDifficult) || [];
    });
    const getSubDiffList = createMemo(() => {
      const cfg = getWaveReward();
      if (!cfg) return [];
      const diffData = cfg[String(getDifficult())];
      if (!diffData) return [];
      return Object.keys(diffData).map(key => Number(key));
    });
    const getPlayerRewards = createMemo(() => {
      var _a, _b;
      const tReawrds = [];
      if (getMode() == 0 || getMode() == 2) {
        const cfg = getWaveReward();
        if (!cfg) return [];
        const diffData = (_a = cfg === null || cfg === void 0 ? void 0 : cfg[String(getDifficult())]) === null || _a === void 0 ? void 0 : _a[getSubDifficult()];
        if (!diffData) return [];
        const tRewardList = Str2RewardList(diffData.player_reward_win);
        tRewardList.push(...((_b = Str2RewardList(diffData.activity_reward_2 || "")) !== null && _b !== void 0 ? _b : []));
        return tRewardList.map(([id, count]) => ({
          id: String(id),
          count,
          rarity: 1
        }));
      } else if (getMode() == 1) {
        const cfg = CfgGetter_mining_drop();
        if (!cfg) return [];
        for (const id in cfg) {
          tReawrds.push({
            id,
            count: 1,
            rarity: cfg[id]['rarity']
          });
        }
      }
      const res = tReawrds.sort((a, b) => {
        var _a, _b;
        const rarityCompare = ((_a = a.rarity) !== null && _a !== void 0 ? _a : 1) - ((_b = b.rarity) !== null && _b !== void 0 ? _b : 1);
        if (rarityCompare !== 0) return rarityCompare;
        return Number(b.id) - Number(a.id);
      });
      return res;
    });
    const getPlayerList = createMemo(() => {
      const list = [];
      EachPlayer((iPlayerID, iOrder) => {
        list.push({
          iPlayerID,
          iOrder
        });
      });
      return list.sort((a, b) => a.iOrder - b.iOrder);
    });
    const getDifficultDesc = createMemo(() => {
      if (getMode() == 1) {
        return `#GS_Selection_Mode${getMode()}_Desc`;
      }
      return `#GS_Selection_Mode${getMode()}_${getDifficult()}_Desc`;
    });
    const getChallengeUseCount = createMemo(() => {
      var _a, _b;
      const tChallengeCost = Str2RewardMap((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['ChallengeTicketCostDiffCount']) !== null && _b !== void 0 ? _b : "");
      let iUseCost = -1;
      for (const [diff, value] of Object.entries(tChallengeCost)) {
        if (getDifficult() >= Number(diff)) {
          iUseCost = Math.max(iUseCost, Number(value));
        }
      }
      return iUseCost;
    });
    const getChallengeCost = createMemo(() => {
      return {
        ["2030028"]: getChallengeUseCount()
      };
    });
    const [getIsEnoughChallengeTicket] = useNetEventTable(t => {
      if (!t) return false;
      const iUseCount = getChallengeUseCount();
      let hasNotEnough = false;
      EachPlayer(iPlayerID => {
        var _a;
        const tChallengeTicketCount = (_a = t[iPlayerID]) !== null && _a !== void 0 ? _a : 0;
        if (tChallengeTicketCount < iUseCount) {
          hasNotEnough = true;
          return true;
        }
      });
      return !hasNotEnough;
    }, 'gs_selection', 'challenge_ticket_count');
    const getSweepUseCount = createMemo(() => {
      var _a, _b;
      const tSweepCost = Str2RewardMap((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['SweepTicketCostDiffCount']) !== null && _b !== void 0 ? _b : "");
      let iUseCost = -1;
      for (const [diff, value] of Object.entries(tSweepCost)) {
        if (getDifficult() >= Number(diff)) {
          iUseCost = Math.max(iUseCost, Number(value));
        }
      }
      return iUseCost;
    });
    const getSweepCost = createMemo(() => {
      const tResultCost = {
        ["2030029"]: getSweepUseCount()
      };
      return tResultCost;
    });
    const getCanChallenge = (bShowMsg = false) => {
      if (!isHost()) {
        if (bShowMsg) {
          ErrorMsg('error_challenge_not_host');
        }
        return false;
      }
      if (getDifficult() > getUnlockDifficult()) {
        if (bShowMsg) {
          ErrorMsg('error_challenge_not_unlock');
        }
        return false;
      }
      if (getMode() == 1) {
        if (bShowMsg) {
          ErrorMsg('error_challenge_not_normal');
        }
        return false;
      }
      const hasNotEnough = !getIsEnoughChallengeTicket();
      if (hasNotEnough) {
        if (bShowMsg) {
          ErrorMsg('#error_not_enough_challenge_ticket');
        }
        return false;
      }
      return true;
    };
    const getCanChallengeState = createMemo(() => {
      return getCanChallenge(false);
    });
    const getCanSweep = (bShowMsg = false) => {
      var _a, _b, _c, _d;
      if (!isHost()) {
        if (bShowMsg) {
          ErrorMsg('error_sweep_not_host');
        }
        return false;
      }
      if (PlayerCount() > 1) {
        if (bShowMsg) {
          ErrorMsg('error_sweep_not_single');
        }
        return false;
      }
      if (getMode() == 1) {
        if (bShowMsg) {
          ErrorMsg('error_sweep_not_normal');
        }
        return false;
      }
      if (Object.values(((_a = ServGetter_UserDiffPass1()) === null || _a === void 0 ? void 0 : _a[getDifficult()]) || {}).length <= 0) {
        if (bShowMsg) {
          ErrorMsg('error_sweep_not_diffpass1');
        }
        return false;
      }
      const hasNotEnough = !getIsEnoughChallengeTicket();
      if (hasNotEnough) {
        if (bShowMsg) {
          ErrorMsg('#error_not_enough_challenge_ticket');
        }
        return false;
      }
      let hasNotEnoughSweepTicket = ((_d = (_c = (_b = ServGetter_UserItem()) === null || _b === void 0 ? void 0 : _b[String("2030029")]) === null || _c === void 0 ? void 0 : _c.count) !== null && _d !== void 0 ? _d : 0) < getSweepUseCount();
      if (hasNotEnoughSweepTicket) {
        if (bShowMsg) {
          ErrorMsg('#error_not_enough_sweep_ticket');
        }
        return false;
      }
      return true;
    };
    createMemo(() => {
      return getCanSweep(false);
    });
    const scrollToCurDifficult = () => {
      return $.Schedule(0.03, () => {
        const pDiff = refDifficultListPanel && (refDifficultListPanel === null || refDifficultListPanel === void 0 ? void 0 : refDifficultListPanel.FindChildTraverse("DifficultBtn_" + getDifficult()));
        if (pDiff != undefined && !pDiff.BCanSeeInParentScroll()) {
          pDiff.ScrollParentToMakePanelFit(1, false);
        }
      });
    };
    createEffect(on(getGameState, (newVal, oldVal) => {
      if ((newVal === null || newVal === void 0 ? void 0 : newVal.state_cur) == 'GS_Selection') {
        const iSchId = scrollToCurDifficult();
        onCleanup(() => {
          $.CancelScheduled(iSchId);
        });
      }
    }));
    const [getShowHeroChallenge, setShowHeroChallenge] = createSignal(false);
    const resetHeroChallengeData = () => {
      GameEvents.SendCustomGameEventToServer('HeroChallenge_LevelReset', {});
    };
    const getHeroChallengeMaxLevel = createMemo(() => {
      var _a;
      const cfg = getWaveReward();
      if (!cfg) return 0;
      const diffData = (_a = cfg === null || cfg === void 0 ? void 0 : cfg[String(getDifficult())]) === null || _a === void 0 ? void 0 : _a[String(getSubDifficult())];
      if (!diffData) return 0;
      return Number(diffData.hero_challenge_max_level);
    });
    function HeroChallengePanel() {
      var _a, _b, _c;
      const [getChallengeData] = useNetEventTable(t => t !== null && t !== void 0 ? t : {}, 'hero_challenge', 'challenge_data');
      const getCurTotalLevel = createMemo(() => {
        return Object.values(getChallengeData()).reduce((acc, cur) => acc + cur, 0);
      });
      const getCanLevelUp = createMemo(() => {
        return getCurTotalLevel() < getHeroChallengeMaxLevel();
      });
      const [getSelectChallengeId, setSelectChallengeId] = createSignal();
      createEffect(() => {
        var _a;
        if (!getSelectChallengeId()) {
          setSelectChallengeId(Object.keys((_a = CfgGetter_hero_challenge()) !== null && _a !== void 0 ? _a : {})[0]);
        }
      });
      const getSelectChallengeCfg = createMemo(() => {
        var _a;
        return (_a = CfgGetter_hero_challenge()) === null || _a === void 0 ? void 0 : _a[getSelectChallengeId()];
      });
      return (() => {
        const _el$ = createElement("Panel", {
            "class": "HeroChallengePanel"
          }, null),
          _el$2 = createElement("Panel", {
            "class": "BG"
          }, _el$);
          createElement("Panel", {
            "class": "BG1"
          }, _el$2);
          createElement("Panel", {
            "class": "Border"
          }, _el$);
          const _el$5 = createElement("Panel", {
            "class": "LeftBody"
          }, _el$),
          _el$6 = createElement("Panel", {
            "class": "ChallengeList"
          }, _el$5),
          _el$7 = createElement("Panel", {
            "class": "Footer"
          }, _el$5),
          _el$8 = createElement("Panel", {
            "class": "TipInfo"
          }, _el$7),
          _el$9 = createElement("Panel", {
            "class": "TipChallengeLevel"
          }, _el$8),
          _el$0 = createElement("Label", {
            get text() {
              return ReplaceTextVariable('#GS_Selection_HeroChallenge_MaxLevel', getHeroChallengeMaxLevel());
            },
            html: true
          }, _el$9),
          _el$1 = createElement("Label", {
            get text() {
              return ReplaceTextVariable('#GS_Selection_HeroChallenge_CurLevel', getCurTotalLevel());
            },
            html: true
          }, _el$9),
          _el$10 = createElement("Panel", {
            "class": "TipChallengeDailyGetLimit"
          }, _el$8),
          _el$11 = createElement("Panel", {
            "class": "OperateGroup"
          }, _el$7),
          _el$15 = createElement("Panel", {
            "class": "RightBody"
          }, _el$);
          createElement("Panel", {
            "class": "BG"
          }, _el$15);
          const _el$17 = createElement("Panel", {
            "class": "Body"
          }, _el$15);
        insert(_el$6, createComponent(For, {
          get each() {
            return Object.keys((_a = CfgGetter_hero_challenge()) !== null && _a !== void 0 ? _a : {});
          },
          children: (challengeId, i) => {
            var _a;
            const tCfg = (_a = CfgGetter_hero_challenge()) === null || _a === void 0 ? void 0 : _a[challengeId];
            if (!tCfg) return null;
            const getCurLevel = createMemo(() => {
              var _a;
              return (_a = getChallengeData()[challengeId]) !== null && _a !== void 0 ? _a : 0;
            });
            const onClickLevelUp = () => {
              setSelectChallengeId(challengeId);
              if (!getCanLevelUp()) return;
              const iCurLevel = getCurLevel();
              const iNewLevel = iCurLevel + 1;
              if (iNewLevel > tCfg['max_level']) return;
              GameEvents.SendCustomGameEventToServer('HeroChallenge_LevelChange', {
                'challenge_id': challengeId,
                'level': iNewLevel,
                'difficult': getDifficult(),
                'sub_difficult': getSubDifficult()
              });
            };
            const onClickLevelDown = () => {
              setSelectChallengeId(challengeId);
              const iCurLevel = getCurLevel();
              const iNewLevel = iCurLevel - 1;
              if (iNewLevel < 0) return;
              GameEvents.SendCustomGameEventToServer('HeroChallenge_LevelChange', {
                'challenge_id': challengeId,
                'level': iNewLevel,
                'difficult': getDifficult(),
                'sub_difficult': getSubDifficult()
              });
            };
            const onClickLevelMin = () => {
              setSelectChallengeId(challengeId);
              const iCurLevel = getCurLevel();
              if (iCurLevel <= 0) return;
              const iNewLevel = 0;
              GameEvents.SendCustomGameEventToServer('HeroChallenge_LevelChange', {
                'challenge_id': challengeId,
                'level': iNewLevel,
                'difficult': getDifficult(),
                'sub_difficult': getSubDifficult()
              });
            };
            const onClickLevelMax = () => {
              setSelectChallengeId(challengeId);
              if (!getCanLevelUp()) return;
              const iCurLevel = getCurLevel();
              if (iCurLevel >= tCfg['max_level']) return;
              const iNewLevel = Math.min(getHeroChallengeMaxLevel() - (getCurTotalLevel() - iCurLevel), tCfg['max_level']);
              GameEvents.SendCustomGameEventToServer('HeroChallenge_LevelChange', {
                'challenge_id': challengeId,
                'level': Math.max(0, iNewLevel),
                'difficult': getDifficult(),
                'sub_difficult': getSubDifficult()
              });
            };
            const getLevelRewardTotal = createMemo(() => {
              var _a;
              const tRewardTotal = {};
              for (let i = 1; i <= getCurLevel(); i++) {
                const tReward = Str2RewardList((_a = tCfg['reward_' + i]) !== null && _a !== void 0 ? _a : '');
                for (const [itemId, count] of tReward) {
                  if (tRewardTotal[itemId] == undefined) {
                    tRewardTotal[itemId] = 0;
                  }
                  tRewardTotal[itemId] += count;
                }
              }
              return tRewardTotal;
            });
            return (() => {
              const _el$22 = createElement("Panel", {
                  "class": "ChallengeItem Rarity3"
                }, null),
                _el$23 = createElement("Panel", {
                  "class": "ItemImage"
                }, _el$22);
                createElement("Panel", {
                  "class": "ItemImageMask"
                }, _el$23);
                const _el$25 = createElement("Panel", {
                  "class": "Body"
                }, _el$22),
                _el$26 = createElement("Label", {
                  "class": "ChallengeName",
                  text: '#hero_' + challengeId
                }, _el$25),
                _el$27 = createElement("Panel", {
                  "class": "Footer"
                }, _el$25),
                _el$28 = createElement("Panel", {
                  "class": "LevelGroup"
                }, _el$27),
                _el$29 = createElement("Panel", {
                  "class": "LevelMinBtn ChangeBtn"
                }, _el$28);
                createElement("Image", {
                  src: "s2r://panorama/images/control_icons/fastforward_psd.vtex"
                }, _el$29);
                const _el$31 = createElement("Panel", {
                  "class": "LevelDownBtn ChangeBtn"
                }, _el$28);
                createElement("Image", {
                  src: "s2r://panorama/images/control_icons/24px/chevron_fancy_left.vsvg"
                }, _el$31);
                const _el$33 = createElement("Panel", {
                  "class": "LevelValue"
                }, _el$28),
                _el$34 = createElement("Label", {
                  get text() {
                    return getCurLevel();
                  }
                }, _el$33),
                _el$35 = createElement("Panel", {
                  "class": "LevelUpBtn ChangeBtn"
                }, _el$28);
                createElement("Image", {
                  src: "s2r://panorama/images/control_icons/24px/chevron_fancy_right.vsvg"
                }, _el$35);
                const _el$37 = createElement("Panel", {
                  "class": "LevelMaxBtn ChangeBtn"
                }, _el$28);
                createElement("Image", {
                  src: "s2r://panorama/images/control_icons/fastforward_psd.vtex"
                }, _el$37);
                const _el$39 = createElement("Panel", {
                  "class": "LevelRewardTotal"
                }, _el$27);
                createElement("Panel", {
                  "class": "ItemBG"
                }, _el$22);
                createElement("Panel", {
                  "class": "ItemBGSelected"
                }, _el$22);
              setProp(_el$22, "onactivate", () => setSelectChallengeId(challengeId));
              setProp(_el$23, "style", {
                backgroundImage: `url("file://{images}/custom_game/service/archives/hero_challenge/${challengeId}.png")`
              });
              setProp(_el$26, "text", '#hero_' + challengeId);
              setProp(_el$29, "onactivate", onClickLevelMin);
              setProp(_el$31, "onactivate", onClickLevelDown);
              setProp(_el$35, "onactivate", onClickLevelUp);
              setProp(_el$37, "onactivate", onClickLevelMax);
              insert(_el$39, createComponent(Show, {
                get when() {
                  return Object.entries(getLevelRewardTotal()).length > 0;
                },
                get children() {
                  return createComponent(For, {
                    get each() {
                      return Object.entries(getLevelRewardTotal());
                    },
                    children: reward => {
                      if (reward[1] <= 0) return null;
                      return createComponent(ServiceItemAsset, {
                        get item_id() {
                          return reward[0];
                        },
                        get count() {
                          return 'x ' + reward[1];
                        }
                      });
                    }
                  });
                }
              }));
              effect(_p$ => {
                const _v$5 = {
                    "Selected": getSelectChallengeId() == challengeId
                  },
                  _v$6 = getCurLevel();
                _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$22, "classList", _v$5, _p$._v$5));
                _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$34, "text", _v$6, _p$._v$6));
                return _p$;
              }, {
                _v$5: undefined,
                _v$6: undefined
              });
              return _el$22;
            })();
          }
        }));
        insert(_el$10, createComponent(For, {
          each: ['177', '2030210'],
          children: sId => {
            var _a, _b, _c, _d, _e, _f, _g, _h, _j;
            const getUserLimit = createMemo(() => {
              var _a, _b;
              return (_b = (_a = ServGetter_UserGetLimit()) === null || _a === void 0 ? void 0 : _a[sId]) !== null && _b !== void 0 ? _b : {
                count: 0,
                item_id: 0,
                limit: 0,
                refresh: 0
              };
            });
            return (() => {
              const _el$42 = createElement("Panel", {
                  "class": "Item"
                }, null),
                _el$43 = createElement("Panel", {
                  "class": "ItemInfo"
                }, _el$42),
                _el$44 = createElement("Panel", {
                  "class": "ItemDesc"
                }, _el$43),
                _el$45 = createElement("Label", {
                  "class": "LimitType",
                  get text() {
                    return ReplaceTextVariable(`#ArchivePersonal_GetLimit_Type2_${(_b = (_a = CfgGetter_get_limit()) === null || _a === void 0 ? void 0 : _a[sId]) === null || _b === void 0 ? void 0 : _b.refresh_type}`, $.Localize('#' + sId));
                  },
                  html: true
                }, _el$44),
                _el$46 = createElement("Panel", {
                  "class": "LimitInfo"
                }, _el$43),
                _el$47 = createElement("Label", {
                  "class": "LimitText",
                  get text() {
                    return `(${(_d = (_c = getUserLimit()) === null || _c === void 0 ? void 0 : _c.count) !== null && _d !== void 0 ? _d : 0} / ${(_j = (_f = (_e = getUserLimit()) === null || _e === void 0 ? void 0 : _e.limit) !== null && _f !== void 0 ? _f : (_h = (_g = CfgGetter_get_limit()) === null || _g === void 0 ? void 0 : _g[sId]) === null || _h === void 0 ? void 0 : _h.limit_count) !== null && _j !== void 0 ? _j : 0})`;
                  }
                }, _el$46);
              effect(_p$ => {
                const _v$7 = ReplaceTextVariable(`#ArchivePersonal_GetLimit_Type2_${(_b = (_a = CfgGetter_get_limit()) === null || _a === void 0 ? void 0 : _a[sId]) === null || _b === void 0 ? void 0 : _b.refresh_type}`, $.Localize('#' + sId)),
                  _v$8 = `(${(_d = (_c = getUserLimit()) === null || _c === void 0 ? void 0 : _c.count) !== null && _d !== void 0 ? _d : 0} / ${(_j = (_f = (_e = getUserLimit()) === null || _e === void 0 ? void 0 : _e.limit) !== null && _f !== void 0 ? _f : (_h = (_g = CfgGetter_get_limit()) === null || _g === void 0 ? void 0 : _g[sId]) === null || _h === void 0 ? void 0 : _h.limit_count) !== null && _j !== void 0 ? _j : 0})`;
                _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$45, "text", _v$7, _p$._v$7));
                _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$47, "text", _v$8, _p$._v$8));
                return _p$;
              }, {
                _v$7: undefined,
                _v$8: undefined
              });
              return _el$42;
            })();
          }
        }));
        insert(_el$11, createComponent(Show, {
          get when() {
            return isHost();
          },
          get children() {
            return [(() => {
              const _el$12 = createElement("TextButton", {
                "class": "ConfirmBtn",
                text: "#GS_Selection_Cancel"
              }, null);
              setProp(_el$12, "classList", {});
              setProp(_el$12, "onactivate", () => {
                setShowHeroChallenge(false);
              });
              return _el$12;
            })(), (() => {
              const _el$13 = createElement("Panel", {
                  "class": "ChallengeBtn"
                }, null),
                _el$14 = createElement("TextButton", {
                  "class": "ConfirmBtn ChallengeBtn",
                  text: "#GS_Selection_Confirm"
                }, _el$13);
              setProp(_el$14, "onactivate", () => {
                if (!getCanChallenge(true)) {
                  return;
                }
                GameEvents.SendCustomGameEventToServer('HeroChallenge_Start', {
                  'mode': getMode(),
                  'difficult': getDifficult(),
                  'sub_difficult': getSubDifficult()
                });
                setShowHeroChallenge(false);
              });
              insert(_el$14, createComponent(Yzy_ServiceAssetCost, {
                get cost() {
                  return getChallengeCost();
                }
              }));
              effect(_p$ => {
                const _v$ = {
                    "PlayerMulit": PlayerCount() > 1
                  },
                  _v$2 = {
                    'Disabled': !getCanChallengeState()
                  };
                _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$13, "classList", _v$, _p$._v$));
                _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$14, "classList", _v$2, _p$._v$2));
                return _p$;
              }, {
                _v$: undefined,
                _v$2: undefined
              });
              return _el$13;
            })()];
          }
        }));
        insert(_el$17, createComponent(Show, {
          get when() {
            return getSelectChallengeId();
          },
          get children() {
            return [(() => {
              const _el$18 = createElement("Panel", {
                  "class": "Header"
                }, null),
                _el$19 = createElement("Label", {
                  "class": "ChallengeName",
                  get text() {
                    return ReplaceTextVariable('#GS_Selection_HeroChallengeTask', $.Localize('#hero_' + getSelectChallengeId()));
                  }
                }, _el$18);
                createElement("Panel", {
                  "class": "Line"
                }, _el$18);
              effect(_$p => setProp(_el$19, "text", ReplaceTextVariable('#GS_Selection_HeroChallengeTask', $.Localize('#hero_' + getSelectChallengeId())), _$p));
              return _el$18;
            })(), (() => {
              const _el$21 = createElement("Panel", {
                "class": "ChallengeLevelList"
              }, null);
              insert(_el$21, createComponent(Index, {
                get each() {
                  return Array.from({
                    length: (_c = (_b = getSelectChallengeCfg()) === null || _b === void 0 ? void 0 : _b.max_level) !== null && _c !== void 0 ? _c : 0
                  });
                },
                children: (_, i) => {
                  var _a;
                  const getCurLevel = createMemo(() => {
                    var _a;
                    return (_a = getChallengeData()[getSelectChallengeId()]) !== null && _a !== void 0 ? _a : 0;
                  });
                  return (() => {
                    const _el$48 = createElement("Panel", {
                        "class": "ChallengeLevelItem"
                      }, null),
                      _el$49 = createElement("Panel", {
                        "class": "ChallengeLevelContent"
                      }, _el$48),
                      _el$50 = createElement("Label", {
                        "class": "ChallengeLevelText",
                        text: i + 1
                      }, _el$49),
                      _el$51 = createElement("Panel", {
                        "class": "ChallengeLevelDetail"
                      }, _el$49),
                      _el$52 = createElement("Panel", {
                        "class": "LevelEffect"
                      }, _el$51),
                      _el$53 = createElement("Panel", {
                        "class": "LevelReward"
                      }, _el$51);
                      createElement("Panel", {
                        "class": "ChallengeLevelMask",
                        hittest: false
                      }, _el$48);
                    setProp(_el$50, "text", i + 1);
                    insert(_el$52, createComponent(For, {
                      get each() {
                        return Str2RewardList(getSelectChallengeCfg()['effect_' + (i + 1)]);
                      },
                      children: effect => {
                        return createComponent(Yzy_Attribute, {
                          get id() {
                            return String(effect[0]);
                          },
                          get val() {
                            return effect[1];
                          }
                        });
                      }
                    }));
                    insert(_el$53, createComponent(Show, {
                      get when() {
                        return getSelectChallengeCfg()['reward_' + (i + 1)];
                      },
                      get children() {
                        return [createElement("Label", {
                          "class": "LevelRewardTitle",
                          text: "#MainChallengeRewardTitle"
                        }, null), createComponent(For, {
                          get each() {
                            return Str2RewardList((_a = getSelectChallengeCfg()['reward_' + (i + 1)]) !== null && _a !== void 0 ? _a : '');
                          },
                          children: reward => {
                            if (reward[1] <= 0) return null;
                            return createComponent(ServiceItemAsset, {
                              get item_id() {
                                return reward[0];
                              },
                              get count() {
                                return 'x ' + reward[1];
                              }
                            });
                          }
                        })];
                      }
                    }));
                    effect(_$p => setProp(_el$48, "classList", {
                      ["Level" + (i + 1)]: true,
                      "Active": getCurLevel() >= i + 1
                    }, _$p));
                    return _el$48;
                  })();
                }
              }));
              return _el$21;
            })()];
          }
        }));
        effect(_p$ => {
          const _v$3 = ReplaceTextVariable('#GS_Selection_HeroChallenge_MaxLevel', getHeroChallengeMaxLevel()),
            _v$4 = ReplaceTextVariable('#GS_Selection_HeroChallenge_CurLevel', getCurTotalLevel());
          _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$0, "text", _v$3, _p$._v$3));
          _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$1, "text", _v$4, _p$._v$4));
          return _p$;
        }, {
          _v$3: undefined,
          _v$4: undefined
        });
        return _el$;
      })();
    }
    return (() => {
      const _el$56 = createElement("Panel", {
          id: "GsSelection",
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$56);
        const _el$58 = createElement("Panel", {
          "class": "Body"
        }, _el$56),
        _el$59 = createElement("Panel", {
          "class": "TopInfo"
        }, _el$58),
        _el$61 = createElement("Label", {
          "class": "TitleText",
          text: "#GS_Selection_Title"
        }, _el$59),
        _el$62 = createElement("Panel", {
          "class": "LeftPanel"
        }, _el$58),
        _el$63 = createElement("Panel", {
          "class": "SubDifficultSelect"
        }, _el$58);
        createElement("Panel", {
          "class": "BG"
        }, _el$63);
        const _el$65 = createElement("Panel", {
          "class": "Body"
        }, _el$63),
        _el$66 = createElement("Panel", {
          "class": "Header"
        }, _el$65);
        createElement("Label", {
          text: "#GS_Selection_SubDifficult"
        }, _el$66);
        const _el$68 = createElement("Panel", {
          "class": "SubDifficultList"
        }, _el$65),
        _el$69 = createElement("Panel", {
          "class": "CenterPanel"
        }, _el$58);
        createElement("Panel", {
          "class": "BG"
        }, _el$69);
        const _el$71 = createElement("Panel", {
          "class": "CenterTitle"
        }, _el$69);
        createElement("Panel", {
          "class": "LeftIcon"
        }, _el$71);
        const _el$73 = createElement("Label", {
          get text() {
            return "#GameMode_" + getMode();
          }
        }, _el$71);
        createElement("Panel", {
          "class": "RightIcon"
        }, _el$71);
        const _el$75 = createElement("Panel", {
          "class": "ModeSelect"
        }, _el$69),
        _el$76 = createElement("Panel", {
          get ["class"]() {
            return classNames("ModeBtn", {
              "Selected": getMode() == 0
            });
          }
        }, _el$75);
        createElement("Image", {
          src: "file://{images}/custom_game/gs_selection/btn_mode_0.png",
          scaling: "stretch-to-fit-x-preserve-aspect"
        }, _el$76);
        createElement("Label", {
          text: "#GameMode_0"
        }, _el$76);
        const _el$79 = createElement("Panel", {
          get ["class"]() {
            return classNames("ModeBtn", {
              "Selected": getMode() == 2,
              'Unlock': getUnlockDifficult() < getCurMaxDifficult + 1
            });
          }
        }, _el$75);
        createElement("Image", {
          src: "file://{images}/custom_game/gs_selection/btn_mode_2.png",
          scaling: "stretch-to-fit-x-preserve-aspect"
        }, _el$79);
        createElement("Label", {
          text: "#GameMode_2"
        }, _el$79);
        const _el$82 = createElement("Panel", {
          get ["class"]() {
            return classNames("ModeBtn", {
              "Selected": getMode() == 1
            });
          }
        }, _el$75);
        createElement("Image", {
          src: "file://{images}/custom_game/gs_selection/btn_mode_1.png",
          scaling: "stretch-to-fit-x-preserve-aspect"
        }, _el$82);
        createElement("Label", {
          text: "#GameMode_1"
        }, _el$82);
        const _el$85 = createElement("Panel", {
          "class": "DifficultList"
        }, _el$69),
        _el$86 = createElement("Panel", {
          "class": "RightPanel"
        }, _el$58);
        createElement("Panel", {
          "class": "BG"
        }, _el$86);
        const _el$88 = createElement("Panel", {
          "class": "RightHeader"
        }, _el$86);
        createElement("Panel", {
          "class": "RightHeaderIcon"
        }, _el$88);
        const _el$90 = createElement("Label", {
          "class": "RightHeaderText",
          get text() {
            return "#GameMode_" + getMode();
          }
        }, _el$88),
        _el$91 = createElement("Panel", {
          "class": "Body"
        }, _el$86),
        _el$92 = createElement("Label", {
          "class": "RightDesc",
          get text() {
            return getDifficultDesc();
          }
        }, _el$91),
        _el$93 = createElement("Panel", {
          "class": "RewardGroups"
        }, _el$91),
        _el$94 = createElement("Panel", {
          "class": "RewardSection"
        }, _el$93),
        _el$95 = createElement("Panel", {
          "class": "RewardSectionHeader"
        }, _el$94);
        createElement("Label", {
          text: "#GS_Selection_DropReward"
        }, _el$95);
        const _el$97 = createElement("Panel", {
          "class": "RewardList"
        }, _el$94),
        _el$112 = createElement("Panel", {
          id: "HeroChallengeRoot",
          hittest: true
        }, _el$56);
      insert(_el$59, createComponent(CountDown, {
        get fTimeEnd() {
          return (_a = getGameState()) === null || _a === void 0 ? void 0 : _a.time_end;
        },
        get children() {
          return createElement("Label", {
            "class": "LevelText",
            text: "{s:countdown_time}"
          }, null);
        }
      }), _el$61);
      insert(_el$62, createComponent(For, {
        get each() {
          return getPlayerList();
        },
        children: player => {
          var _a;
          return (() => {
            const _el$113 = createElement("Panel", {
                "class": "PlayerRow"
              }, null),
              _el$114 = createElement("Label", {
                "class": "PlayerName",
                get text() {
                  return ((_a = Game.GetPlayerInfo(player.iPlayerID)) === null || _a === void 0 ? void 0 : _a.player_name) || "";
                }
              }, _el$113),
              _el$115 = createElement("Panel", {
                "class": "PlayerHeader"
              }, _el$113),
              _el$116 = createElement("Panel", {
                "class": "FG"
              }, _el$115);
            insert(_el$115, createComponent(PlayerAvatar, {
              get iPlayerID() {
                return player.iPlayerID;
              }
            }), _el$116);
            effect(_$p => setProp(_el$114, "text", ((_a = Game.GetPlayerInfo(player.iPlayerID)) === null || _a === void 0 ? void 0 : _a.player_name) || "", _$p));
            return _el$113;
          })();
        }
      }));
      insert(_el$66, createComponent(Yzy_Icon, {
        type: "icon_tips",
        onmouseover: p => {
          ShowTooltip(p, 'common_detail_tooltip', {
            'sContext': '#GS_Selection_SubDifficult_Tips'
          });
        },
        onmouseout: HideTooltip
      }), null);
      insert(_el$68, createComponent(For, {
        get each() {
          return getSubDiffList();
        },
        children: (item, i) => (() => {
          const _el$117 = createElement("Panel", {
              "class": "SubDifficultItem"
            }, null);
            createElement("DOTAEmoticon", {
              "class": "SubDifficultIcon",
              animating: true,
              scaling: "stretch",
              src: "file://{images}/custom_game/gs_selection/sub_difficult_huo.png"
            }, _el$117);
            const _el$119 = createElement("Panel", {
              "class": "Body"
            }, _el$117),
            _el$120 = createElement("Label", {
              "class": "SubDifficultText",
              text: item
            }, _el$119);
          setProp(_el$117, "onactivate", () => setSubDifficult(item));
          setProp(_el$120, "text", item);
          effect(_$p => setProp(_el$117, "classList", {
            "Last": i() == getSubDiffList().length - 1,
            "Selected": getSubDifficult() == item
          }, _$p));
          return _el$117;
        })()
      }));
      setProp(_el$76, "onactivate", () => {
        setSubDifficult(0);
        setMode(0);
        setDifficult(Math.min(Math.max(getUnlockDifficult() - 1, 1), getCurMaxDifficult));
        scrollToCurDifficult();
      });
      setProp(_el$79, "onactivate", () => {
        setSubDifficult(0);
        setMode(2);
        setDifficult(Math.min(Math.max(getUnlockDifficult() - 1, 21), getCurMaxDifficultMolten));
        scrollToCurDifficult();
      });
      setProp(_el$82, "onactivate", () => setMode(1));
      const _ref$ = refDifficultListPanel;
      typeof _ref$ === "function" ? use(_ref$, _el$85) : refDifficultListPanel = _el$85;
      insert(_el$85, createComponent(Index, {
        get each() {
          return getDiffList();
        },
        children: (_, i) => {
          const n = () => getMode() == 2 ? i + 21 : i + 1;
          return (() => {
            const _el$121 = createElement("Panel", {
                get id() {
                  return "DifficultBtn_" + n();
                },
                get ["class"]() {
                  return classNames("DifficultBtn", {
                    "Selected": getDifficult() == n(),
                    "Unlcok": getUnlockDifficult() >= n()
                  });
                }
              }, null);
              createElement("Panel", {
                "class": "DifficultBG"
              }, _el$121);
              const _el$123 = createElement("Label", {
                "class": "DifficultText",
                text: "#DifLabel",
                get dialogVariables() {
                  return {
                    val: n()
                  };
                }
              }, _el$121);
            setProp(_el$121, "onactivate", p => {
              if (isHost()) {
                if (getDifficult() != n()) {
                  setSubDifficult(0);
                  setDifficult(n());
                  resetHeroChallengeData();
                }
              }
            });
            effect(_p$ => {
              const _v$21 = "DifficultBtn_" + n(),
                _v$22 = classNames("DifficultBtn", {
                  "Selected": getDifficult() == n(),
                  "Unlcok": getUnlockDifficult() >= n()
                }),
                _v$23 = {
                  val: n()
                };
              _v$21 !== _p$._v$21 && (_p$._v$21 = setProp(_el$121, "id", _v$21, _p$._v$21));
              _v$22 !== _p$._v$22 && (_p$._v$22 = setProp(_el$121, "class", _v$22, _p$._v$22));
              _v$23 !== _p$._v$23 && (_p$._v$23 = setProp(_el$123, "dialogVariables", _v$23, _p$._v$23));
              return _p$;
            }, {
              _v$21: undefined,
              _v$22: undefined,
              _v$23: undefined
            });
            return _el$121;
          })();
        }
      }));
      insert(_el$97, createComponent(For, {
        get each() {
          return getPlayerRewards();
        },
        children: item => {
          return createComponent(Yzy_ServiceItem, {
            "class": "RewardItemSlot",
            data: item,
            get rarity() {
              return item.rarity;
            }
          });
        }
      }));
      insert(_el$93, () => {
        const starRewards = createMemo(() => {
          var _a;
          const cfg = getWaveReward();
          if (!cfg) return [];
          const diffData = (_a = cfg[String(getDifficult())]) === null || _a === void 0 ? void 0 : _a['0'];
          if (!diffData) return [];
          return [Str2RewardList(diffData.star_reward_1).map(([id, count]) => ({
            id: String(id),
            count
          })), Str2RewardList(diffData.star_reward_2).map(([id, count]) => ({
            id: String(id),
            count
          })), Str2RewardList(diffData.star_reward_3).map(([id, count]) => ({
            id: String(id),
            count
          }))];
        });
        const getRecvStarCount = createMemo(() => {
          var _a, _b;
          return (_b = (_a = ServGetter_UserCheckoutWaveStar()) === null || _a === void 0 ? void 0 : _a[getDifficult()]) !== null && _b !== void 0 ? _b : 0;
        });
        return createComponent(Show, {
          get when() {
            return getMode() == 0 || getMode() == 2;
          },
          get children() {
            return createComponent(For, {
              get each() {
                return starRewards();
              },
              children: (item, i) => (() => {
                const _el$124 = createElement("Panel", {
                    "class": "RewardSection"
                  }, null),
                  _el$125 = createElement("Panel", {
                    "class": "RewardSectionHeader"
                  }, _el$124),
                  _el$126 = createElement("Label", {
                    get text() {
                      return $.Localize('#GS_Selection_StarReward_' + (i() + 1));
                    }
                  }, _el$125),
                  _el$127 = createElement("Panel", {
                    "class": "RewardList"
                  }, _el$124);
                insert(_el$127, createComponent(For, {
                  each: item,
                  children: item => createComponent(Yzy_ServiceItem, {
                    data: item,
                    "class": "RewardItemSlot",
                    get classList() {
                      return {
                        'Received': getRecvStarCount() >= i() + 1
                      };
                    },
                    get children() {
                      return createComponent(Show, {
                        get when() {
                          return getRecvStarCount() >= i() + 1;
                        },
                        get children() {
                          return createComponent(Yzy_Icon, {
                            type: "icon_y"
                          });
                        }
                      });
                    }
                  })
                }));
                effect(_$p => setProp(_el$126, "text", $.Localize('#GS_Selection_StarReward_' + (i() + 1)), _$p));
                return _el$124;
              })()
            });
          }
        });
      }, null);
      insert(_el$86, createComponent(Switch, {
        get children() {
          return [createComponent(Match, {
            get when() {
              return getMode() == 0 || getMode() == 2;
            },
            get children() {
              return [(() => {
                const _el$98 = createElement("Panel", {
                    "class": "TopInfo"
                  }, null),
                  _el$99 = createElement("Panel", {
                    "class": "ServiceAssetGroup ChallengeAssetGroup"
                  }, _el$98);
                insert(_el$99, createComponent(ServiceItemAsset, {
                  item_id: "2030028"
                }), null);
                insert(_el$99, createComponent(Yzy_Icon, {
                  type: "icon_tips",
                  onmouseover: p => {
                    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
                    ShowTooltip(p, 'common_detail_tooltip', {
                      'sTitle': $.Localize("#GS_Selection_ChallengeTicketTitle"),
                      'sContext': ReplaceTextVariable('#GS_Selection_ChallengeTicket_Tips', {
                        'free': GreenText(((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['ChallengeTicketDailyFree']) !== null && _b !== void 0 ? _b : 0) + ((_e = (_d = (_c = ServGetter_UserItem()) === null || _c === void 0 ? void 0 : _c['1185040']) === null || _d === void 0 ? void 0 : _d.count) !== null && _e !== void 0 ? _e : 0)),
                        'free_limit': YellowText(((_g = (_f = CfgGetter_settings_common()) === null || _f === void 0 ? void 0 : _f['ChallengeTicketDefaultLimit']) !== null && _g !== void 0 ? _g : 0) + ((_k = (_j = (_h = ServGetter_UserItem()) === null || _h === void 0 ? void 0 : _h['1185039']) === null || _j === void 0 ? void 0 : _j.count) !== null && _k !== void 0 ? _k : 0))
                      })
                    });
                  },
                  onmouseout: HideTooltip
                }), null);
                insert(_el$98, createComponent(Show, {
                  get when() {
                    return PlayerCount() == 1;
                  },
                  get children() {
                    const _el$100 = createElement("Panel", {
                      "class": "ServiceAssetGroup SweepAssetGroup"
                    }, null);
                    insert(_el$100, createComponent(ServiceItemAsset, {
                      item_id: "2030029"
                    }), null);
                    insert(_el$100, createComponent(Yzy_Icon, {
                      type: "icon_tips",
                      onmouseover: p => {
                        var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o;
                        ShowTooltip(p, 'common_detail_tooltip', {
                          'sTitle': $.Localize("#GS_Selection_SweepTicketTitle"),
                          'sContext': ReplaceTextVariable('#GS_Selection_SweepTicket_Tips', {
                            'free': GreenText(((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['SweepTicketDailyLoginFree']) !== null && _b !== void 0 ? _b : 0) + ((_e = (_d = (_c = ServGetter_UserItem()) === null || _c === void 0 ? void 0 : _c['1185042']) === null || _d === void 0 ? void 0 : _d.count) !== null && _e !== void 0 ? _e : 0)),
                            'free_limit': YellowText(((_g = (_f = CfgGetter_settings_common()) === null || _f === void 0 ? void 0 : _f['SweepTicketDefaultLimit']) !== null && _g !== void 0 ? _g : 0) + ((_k = (_j = (_h = ServGetter_UserItem()) === null || _h === void 0 ? void 0 : _h['1185041']) === null || _j === void 0 ? void 0 : _j.count) !== null && _k !== void 0 ? _k : 0)),
                            'daily_limit': YellowText((_o = (_m = (_l = ServGetter_UserGetLimit()) === null || _l === void 0 ? void 0 : _l["2030029"]) === null || _m === void 0 ? void 0 : _m.limit) !== null && _o !== void 0 ? _o : 0)
                          })
                        });
                      },
                      onmouseout: HideTooltip
                    }), null);
                    return _el$100;
                  }
                }), null);
                return _el$98;
              })(), (() => {
                const _el$101 = createElement("Panel", {
                  "class": "OperateContainer NormalMode"
                }, null);
                insert(_el$101, createComponent(Show, {
                  get when() {
                    return isHost();
                  },
                  get children() {
                    return [(() => {
                      const _el$102 = createElement("Panel", {
                          "class": "OperateGroup ChallengeOperateGroup"
                        }, null),
                        _el$103 = createElement("TextButton", {
                          "class": "ConfirmBtn ChallengeBtn",
                          text: "#GS_Selection_Confirm"
                        }, _el$102);
                      setProp(_el$103, "onactivate", () => {
                        if (!getCanChallenge(true)) {
                          return;
                        }
                        GameEvents.SendCustomGameEventToServer('OnDifficultSelected', {
                          'mode': getMode(),
                          'difficult': getDifficult(),
                          'sub_difficult': getSubDifficult()
                        });
                      });
                      insert(_el$103, createComponent(Yzy_ServiceAssetCost, {
                        get cost() {
                          return getChallengeCost();
                        }
                      }));
                      effect(_p$ => {
                        const _v$9 = {
                            "PlayerMulit": PlayerCount() > 1
                          },
                          _v$0 = {
                            'Disabled': !getCanChallengeState()
                          };
                        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$102, "classList", _v$9, _p$._v$9));
                        _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$103, "classList", _v$0, _p$._v$0));
                        return _p$;
                      }, {
                        _v$9: undefined,
                        _v$0: undefined
                      });
                      return _el$102;
                    })(), (() => {
                      const _el$104 = createElement("Panel", {
                          "class": "OperateGroup HeroChallengeOperateGroup"
                        }, null),
                        _el$105 = createElement("TextButton", {
                          "class": "ConfirmBtn ChallengeBtn",
                          text: "#GS_Selection_HeroChallenge"
                        }, _el$104);
                      setProp(_el$105, "onactivate", () => {
                        setShowHeroChallenge(true);
                      });
                      effect(_p$ => {
                        const _v$1 = {
                            "PlayerMulit": PlayerCount() > 1,
                            "Show": getHeroChallengeMaxLevel() > 0
                          },
                          _v$10 = {
                            'Disabled': !getCanChallengeState()
                          };
                        _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$104, "classList", _v$1, _p$._v$1));
                        _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$105, "classList", _v$10, _p$._v$10));
                        return _p$;
                      }, {
                        _v$1: undefined,
                        _v$10: undefined
                      });
                      return _el$104;
                    })()];
                  }
                }), null);
                insert(_el$101, createComponent(Show, {
                  get when() {
                    return PlayerCount() == 1;
                  },
                  get children() {
                    const _el$106 = createElement("Panel", {
                        "class": "OperateGroup SweepOperateGroup"
                      }, null),
                      _el$107 = createElement("TextButton", {
                        "class": "ConfirmBtn SweepBtn",
                        text: "#GS_Selection_SweepBtn"
                      }, _el$106),
                      _el$108 = createElement("Label", {
                        "class": "SweepCountTip",
                        get text() {
                          return ReplaceTextVariable("#GS_Selection_SweepTicket_Desc", {
                            cur: (_d = (_c = (_b = ServGetter_UserGetLimit()) === null || _b === void 0 ? void 0 : _b["2030029"]) === null || _c === void 0 ? void 0 : _c.count) !== null && _d !== void 0 ? _d : 0,
                            max: (_g = (_f = (_e = ServGetter_UserGetLimit()) === null || _e === void 0 ? void 0 : _e["2030029"]) === null || _f === void 0 ? void 0 : _f.limit) !== null && _g !== void 0 ? _g : 0
                          });
                        },
                        html: true
                      }, _el$106);
                    setProp(_el$107, "onactivate", () => {
                      if (!getCanSweep(true)) {
                        return;
                      }
                      ShowProcessing();
                      Request('MatchSweep', {
                        'mode': getMode(),
                        'difficult': getDifficult(),
                        'sub_difficult': getSubDifficult()
                      }).then(resp => {
                        var _a;
                        HideProcessing();
                        if ((resp === null || resp === void 0 ? void 0 : resp.code) == 0) {
                          ShowPopup('show_reward_popup', {
                            'tReward': ((_a = resp.data) === null || _a === void 0 ? void 0 : _a.filter(item => item.count > 0)) || []
                          });
                        } else {
                          ErrorMsg((resp === null || resp === void 0 ? void 0 : resp.msg) || 'error_request_fail');
                        }
                      }).catch(err => {
                        HideProcessing();
                        ErrorMsg('error_request_fail');
                      });
                    });
                    insert(_el$107, createComponent(Yzy_ServiceAssetCost, {
                      get cost() {
                        return getSweepCost();
                      }
                    }));
                    effect(_$p => setProp(_el$108, "text", ReplaceTextVariable("#GS_Selection_SweepTicket_Desc", {
                      cur: (_d = (_c = (_b = ServGetter_UserGetLimit()) === null || _b === void 0 ? void 0 : _b["2030029"]) === null || _c === void 0 ? void 0 : _c.count) !== null && _d !== void 0 ? _d : 0,
                      max: (_g = (_f = (_e = ServGetter_UserGetLimit()) === null || _e === void 0 ? void 0 : _e["2030029"]) === null || _f === void 0 ? void 0 : _f.limit) !== null && _g !== void 0 ? _g : 0
                    }), _$p));
                    return _el$106;
                  }
                }), null);
                return _el$101;
              })()];
            }
          }), createComponent(Match, {
            get when() {
              return getMode() == 1;
            },
            get children() {
              const _el$109 = createElement("Panel", {
                  "class": "OperateContainer Mode1"
                }, null),
                _el$110 = createElement("Panel", {
                  "class": "OperateGroup Mode1OperateGroup"
                }, _el$109),
                _el$111 = createElement("TextButton", {
                  "class": "ConfirmBtn ChallengeBtn",
                  text: "#GS_Selection_Confirm"
                }, _el$110);
              setProp(_el$111, "onactivate", () => {
                GameEvents.SendCustomGameEventToServer('OnDifficultSelected', {
                  'mode': getMode(),
                  'difficult': getDifficult(),
                  'sub_difficult': getSubDifficult()
                });
              });
              return _el$109;
            }
          })];
        }
      }), null);
      setProp(_el$112, "onactivate", p => {});
      insert(_el$112, createComponent(HeroChallengePanel, {}));
      effect(_p$ => {
        const _v$11 = {
            "Show": getSubDiffList().length > 1
          },
          _v$12 = "#GameMode_" + getMode(),
          _v$13 = classNames("ModeBtn", {
            "Selected": getMode() == 0
          }),
          _v$14 = classNames("ModeBtn", {
            "Selected": getMode() == 2,
            'Unlock': getUnlockDifficult() < getCurMaxDifficult + 1
          }),
          _v$15 = getUnlockDifficult() >= getCurMaxDifficult + 1,
          _v$16 = classNames("ModeBtn", {
            "Selected": getMode() == 1
          }),
          _v$17 = getMode() != 1,
          _v$18 = "#GameMode_" + getMode(),
          _v$19 = getDifficultDesc(),
          _v$20 = {
            'Show': getShowHeroChallenge()
          };
        _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$63, "classList", _v$11, _p$._v$11));
        _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$73, "text", _v$12, _p$._v$12));
        _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$76, "class", _v$13, _p$._v$13));
        _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$79, "class", _v$14, _p$._v$14));
        _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$79, "enabled", _v$15, _p$._v$15));
        _v$16 !== _p$._v$16 && (_p$._v$16 = setProp(_el$82, "class", _v$16, _p$._v$16));
        _v$17 !== _p$._v$17 && (_p$._v$17 = setProp(_el$85, "visible", _v$17, _p$._v$17));
        _v$18 !== _p$._v$18 && (_p$._v$18 = setProp(_el$90, "text", _v$18, _p$._v$18));
        _v$19 !== _p$._v$19 && (_p$._v$19 = setProp(_el$92, "text", _v$19, _p$._v$19));
        _v$20 !== _p$._v$20 && (_p$._v$20 = setProp(_el$112, "classList", _v$20, _p$._v$20));
        return _p$;
      }, {
        _v$11: undefined,
        _v$12: undefined,
        _v$13: undefined,
        _v$14: undefined,
        _v$15: undefined,
        _v$16: undefined,
        _v$17: undefined,
        _v$18: undefined,
        _v$19: undefined,
        _v$20: undefined
      });
      return _el$56;
    })();
  }

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

  function AbilityPanel$1(props) {
    var _a, _b;
    const [_, props_other] = splitProps(props, ['iAbltID', 'sAbltName']);
    let ref;
    const tKV = (_a = AbilitiesKv[props.sAbltName]) !== null && _a !== void 0 ? _a : {};
    const getEntID = () => Abilities.GetCaster(props.iAbltID);
    const [isPassive, setPassive] = createSignal(false);
    const [isActivated, setActivated] = createSignal(Abilities.IsActivated(props.iAbltID));
    const [isAutocastable, setAutocastable] = createSignal(Abilities.IsAutocast(props.iAbltID));
    const [isAutocast, setAutocast] = createSignal(Abilities.GetAutoCastState(props.iAbltID));
    const [isCastActivated, setCastActivated] = createSignal(Abilities.GetLocalPlayerActiveAbility() == props.iAbltID);
    const [getCooldownTime, setCooldown] = createSignal(0);
    const [getCooldownLength, setCooldownLength] = createSignal(0);
    const [getMana, setMana] = createSignal(0);
    const [getKeybind, setKeybind] = createSignal((_b = props.sHotKey) !== null && _b !== void 0 ? _b : '');
    const [isKeybindAlt, setKeybindAlt] = createSignal(false);
    const [isChargeable, setChargeable] = createSignal(false);
    const [getCharges, setCharges] = createSignal(0);
    const [getChargesRemaining, setChargesRemaining] = createSignal(0);
    const [getChargesTimeLenght, setChargesTimeLenght] = createSignal(0);
    const [getLevel, setLevel] = createSignal(Abilities.GetLevel(props.iAbltID));
    const [isNotMana, setNotCast] = createSignal(false);
    const [getCastRangePtclID, setCastRangePtclID] = createSignal(undefined);
    {
      let fCooldownTime;
      const id = Timer(() => {
        var _a;
        setPassive((Abilities.GetBehavior(props.iAbltID) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) > 0);
        setActivated(Abilities.IsActivated(props.iAbltID));
        setAutocastable(Abilities.IsAutocast(props.iAbltID));
        setAutocast(Abilities.GetAutoCastState(props.iAbltID));
        setCastActivated(Abilities.GetLocalPlayerActiveAbility() == props.iAbltID);
        setLevel(Abilities.GetLevel(props.iAbltID));
        let fChargesCooldown;
        let fChargesTimeLenght;
        let iMaxCharges = Abilities.GetMaxAbilityCharges(props.iAbltID);
        if (iMaxCharges > 0 && runlua(`
                local h = EntIndexToHScript(${props.iAbltID})
                return h and h.IsChargeable and h:IsChargeable()
            `)) {
          setChargeable(true);
          fChargesTimeLenght = Math.max(0, ((_a = tKV['AbilityChargeRestoreTime']) !== null && _a !== void 0 ? _a : 0) - AttributeKind$1.Cooldown.Get(getEntID(), undefined, {
            'ability': EntIndexToHScript(props.iAbltID)
          })) * Math.max(0, 100 - AttributeKind$1.Cooldown.PCT.Get(getEntID(), undefined, {
            'ability': EntIndexToHScript(props.iAbltID)
          })) * 0.01;
          setChargesTimeLenght(fChargesTimeLenght);
          let iCharges = Abilities.GetCurrentAbilityCharges(props.iAbltID);
          setCharges(iCharges);
          if (iCharges < iMaxCharges) {
            let f = Abilities.GetAbilityChargeRestoreTimeRemaining(props.iAbltID);
            if (f > 0) {
              setChargesRemaining(f);
              if (iCharges <= 0) {
                fChargesCooldown = f;
              }
            } else {
              setChargesRemaining(0);
            }
          }
        } else {
          setChargeable(false);
        }
        let fCooldownRemaining = Abilities.GetCooldownTimeRemaining(props.iAbltID);
        let fCooldownLength;
        if (fChargesCooldown != undefined && fChargesCooldown > fCooldownRemaining) {
          fCooldownRemaining = fChargesCooldown;
          fCooldownLength = fChargesTimeLenght;
        } else {
          fCooldownLength = Abilities.GetCooldownModified(props.iAbltID);
        }
        if (fCooldownRemaining > 0) {
          let f = Number((Game.GetGameTime() + fCooldownRemaining).toFixed(1));
          if (fCooldownTime == undefined || Math.abs(fCooldownTime - f) > 1) {
            fCooldownTime = f;
            setCooldown(fCooldownTime);
            setCooldownLength(fCooldownLength);
            if (ref) {
              ref.SetHasClass('Cooling', true);
            }
          }
        } else {
          setCooldown(0);
          if (fCooldownTime != undefined) {
            fCooldownTime = undefined;
            if (ref) {
              ref.SetHasClass('Cooling', false);
              const pCooldown = ref.FindChildTraverse('Cooldown');
              if (pCooldown) {
                const pShineRoot = $.CreatePanel('DOTAParticleScenePanel', pCooldown, 'ShineRoot', {
                  particleName: "particles/ui/common/cooldown/cooldown_shine.vpcf",
                  fov: 60,
                  lookAt: "0 0 0",
                  cameraOrigin: "300 0 0"
                });
                render(() => createComponent(Shine, {}), pShineRoot);
              }
            }
          }
        }
        setMana(Abilities.GetManaCostModified(props.iAbltID));
        setNotCast(Abilities.GetManaCostModified(props.iAbltID) > Entities.GetMana(Abilities.GetCaster(props.iAbltID)));
        if (props.sHotKey == undefined) {
          let bAlt = false;
          let sKeybind = '';
          if (Entities.IsControllableByPlayer(getEntID(), Players.GetLocalPlayer())) {
            let iSlot = Abilities.GetAbilitySlot(props.iAbltID);
            if (iSlot < 6) {
              sKeybind = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1 + iSlot);
              if (sKeybind == '') {
                sKeybind = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_ABILITY_PRIMARY1_QUICKCAST + iSlot);
              }
              if (sKeybind != '') {
                let t = sKeybind.split('-');
                if (t.length == 1) {
                  sKeybind = t[0];
                } else {
                  sKeybind = t[1];
                  if (t[0].indexOf('ALT') != -1) {
                    bAlt = true;
                  }
                }
              }
            }
          }
          setKeybind(sKeybind);
          setKeybindAlt(bAlt);
        }
        return 0.1;
      }, 0.1, undefined, 'AbilityPanel');
      onCleanup(() => {
        StopTimer(id);
        if (getCastRangePtclID()) {
          Particles.DestroyParticleEffect(getCastRangePtclID(), true);
        }
      });
    }
    return (() => {
      const _el$ = createElement("Panel", mergeProps(props_other, {
          get ["class"]() {
            return classNames("AbilityPanel", props.class, {
              Passive: isPassive(),
              NotActivated: !isActivated(),
              Autocastable: isAutocastable(),
              CastActivated: isCastActivated(),
              ChargesNotEnough: isChargeable() && getCharges() <= 0,
              NoLevel: getLevel() <= 0,
              NotMana: isNotMana()
            });
          }
        }), null),
        _el$2 = createElement("Panel", {
          "class": "Body"
        }, _el$);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') {
          props.ref(p);
        }
      }, _el$);
      spread(_el$, mergeProps(props_other, {
        get ["class"]() {
          return classNames("AbilityPanel", props.class, {
            Passive: isPassive(),
            NotActivated: !isActivated(),
            Autocastable: isAutocastable(),
            CastActivated: isCastActivated(),
            ChargesNotEnough: isChargeable() && getCharges() <= 0,
            NoLevel: getLevel() <= 0,
            NotMana: isNotMana()
          });
        }
      }), true);
      insert(_el$2, createComponent(Show, {
        get when() {
          return isAutocastable();
        },
        get children() {
          return createComponent(AutocastablePanel, {
            isAutocast: isAutocast
          });
        }
      }), null);
      insert(_el$2, createComponent(KeybindButton, {
        id: "AbilityButton",
        key: getKeybind,
        get onactivate() {
          return isPassive() ? undefined : () => {
            setCastActivated(true);
            if (props.bQuickCast) {
              let iTargetID;
              let iTargetID2;
              const vPos3D = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition());
              if (vPos3D != null) {
                for (const iterator of GameUI.FindScreenEntities(GameUI.GetCursorPosition())) {
                  if (!iTargetID2) {
                    iTargetID2 = iterator.entityIndex;
                  }
                  if (iterator.accurateCollision) {
                    iTargetID = iterator.entityIndex;
                    break;
                  }
                }
              }
              GameEvents.SendCustomGameEventToServer('custom_execute_ability', {
                'ablt': props.iAbltID,
                'ent': getEntID(),
                'pos': vPos3D ? VectorToString(vPos3D) : undefined,
                'target': iTargetID !== null && iTargetID !== void 0 ? iTargetID : iTargetID2
              });
            } else {
              Abilities.ExecuteAbility(props.iAbltID, getEntID(), false);
            }
          };
        },
        get oncontextmenu() {
          return isAutocastable() ? () => {
            Game.PrepareUnitOrders({
              'OrderType': dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TOGGLE_AUTO,
              'AbilityIndex': props.iAbltID,
              'UnitIndex': getEntID()
            });
          } : undefined;
        },
        onmouseover: p => {
          ShowTooltip(p, 'ability_tooltip', {
            'sAbltName': props.sAbltName,
            'iEntID': getEntID()
          });
          if ((Abilities.GetBehavior(props.iAbltID) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_PASSIVE) > 0 || (Abilities.GetBehavior(props.iAbltID) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_NO_TARGET) > 0) {
            const fRange = Abilities.GetCastRange(props.iAbltID);
            if (fRange > 0) {
              const iParticleID = Particles.CreateParticle("particles/ui_mouseactions/range_display.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, getEntID());
              Particles.SetParticleControl(iParticleID, 1, [fRange, fRange, fRange]);
              setCastRangePtclID(iParticleID);
            }
          }
        },
        onmouseout: () => {
          HideTooltip();
          if (getCastRangePtclID()) {
            Particles.DestroyParticleEffect(getCastRangePtclID(), true);
          }
        },
        onload: p => {},
        get children() {
          return [(() => {
            const _el$3 = createElement("DOTAAbilityImage", {
              get abilityname() {
                return props.sAbltName;
              },
              showtooltip: false
            }, null);
            effect(_$p => setProp(_el$3, "abilityname", props.sAbltName, _$p));
            return _el$3;
          })(), createElement("Panel", {
            id: "AbilityBevel",
            hittest: false
          }, null), (() => {
            const _el$5 = createElement("Panel", {
              id: "Cooldown",
              hittest: false
            }, null);
            insert(_el$5, createComponent(Show, {
              get when() {
                return getCooldownTime() > Game.GetGameTime();
              },
              get children() {
                return createComponent(CooldownPanel, {
                  fEnd: getCooldownTime,
                  fCD: getCooldownLength,
                  hittest: false
                });
              }
            }));
            return _el$5;
          })()];
        }
      }), null);
      insert(_el$2, createComponent(Show, {
        get when() {
          return isPassive();
        },
        get fallback() {
          return createElement("Panel", {
            id: "AbilityBorder",
            hittest: false
          }, null);
        },
        get children() {
          return createElement("Panel", {
            id: "PassiveAbilityBorder",
            hittest: false
          }, null);
        }
      }), null);
      insert(_el$2, createComponent(Show, {
        get when() {
          return getMana() > 0;
        },
        get children() {
          const _el$7 = createElement("Panel", {
              id: "CostBody",
              hittest: false,
              hittestchildren: false
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$7);
            const _el$9 = createElement("Panel", {
              "class": "Body"
            }, _el$7);
          insert(_el$9, createComponent(Show, {
            get when() {
              return getMana() > 0;
            },
            get children() {
              const _el$0 = createElement("Panel", {
                  id: "ManaCost",
                  hittest: false
                }, null),
                _el$1 = createElement("Label", {
                  get text() {
                    return getMana();
                  },
                  hittest: false
                }, _el$0);
              effect(_$p => setProp(_el$1, "text", getMana(), _$p));
              return _el$0;
            }
          }));
          return _el$7;
        }
      }), null);
      insert(_el$2, createComponent(Show, {
        get when() {
          return memo(() => !!!isPassive())() && getKeybind() != '';
        },
        get children() {
          const _el$10 = createElement("Panel", {
              id: "HotkeyContainer",
              hittest: false
            }, null),
            _el$11 = createElement("Panel", {
              id: "Hotkey",
              hittest: false
            }, _el$10),
            _el$12 = createElement("Label", {
              get text() {
                return getKeybind();
              },
              hittest: false
            }, _el$11);
          insert(_el$10, createComponent(Show, {
            get when() {
              return isKeybindAlt();
            },
            get children() {
              const _el$13 = createElement("Panel", {
                  id: "HotkeyModifier",
                  hittest: false
                }, null);
                createElement("Label", {
                  text: '#DOTA_Keybind_ALT',
                  hittest: false
                }, _el$13);
              return _el$13;
            }
          }), null);
          effect(_$p => setProp(_el$12, "text", getKeybind(), _$p));
          return _el$10;
        }
      }), null);
      insert(_el$2, createComponent(Show, {
        get when() {
          return isChargeable();
        },
        get children() {
          const _el$15 = createElement("Panel", {
              id: "AbilityCharges",
              hittest: false
            }, null),
            _el$16 = createElement("Panel", {
              id: "AbilityChargesBorder",
              hittest: false,
              get style() {
                return {
                  clip: `radial( 50.0% 50.0%, 0.0deg, ${(() => {
                  var _a;
                  const i = ((_a = tKV['AbilityChargeRestoreTime']) !== null && _a !== void 0 ? _a : 0) <= 0 ? 360 : 360 * (1 - (Number.isFinite(getChargesRemaining() / getChargesTimeLenght()) ? Number((getChargesRemaining() / getChargesTimeLenght()).toFixed(2)) : 0));
                  return i || 1;
                })()}deg)`
                };
              }
            }, _el$15),
            _el$17 = createElement("Label", {
              get text() {
                return getCharges();
              }
            }, _el$15);
          effect(_p$ => {
            const _v$ = {
                clip: `radial( 50.0% 50.0%, 0.0deg, ${(() => {
                var _a;
                const i = ((_a = tKV['AbilityChargeRestoreTime']) !== null && _a !== void 0 ? _a : 0) <= 0 ? 360 : 360 * (1 - (Number.isFinite(getChargesRemaining() / getChargesTimeLenght()) ? Number((getChargesRemaining() / getChargesTimeLenght()).toFixed(2)) : 0));
                return i || 1;
              })()}deg)`
              },
              _v$2 = getCharges();
            _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$16, "style", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$17, "text", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$15;
        }
      }), null);
      return _el$;
    })();
  }
  function AutocastablePanel(props) {
    let ref;
    createEffect(() => {
      const bAutocast = props.isAutocast();
      let p = ref.GetChild(0);
      if (bAutocast) {
        if (p) {
          p.style.opacity = '1';
        } else {
          $.CreatePanel('DOTAParticleScenePanel', ref, 'AutoCasting', {
            particleName: "particles/ui/hud/autocasting_square.vpcf",
            fov: '90',
            cameraOrigin: "0 0 50",
            lookAt: "0 0 0",
            hittest: 'false'
          });
        }
      } else {
        if (p) p.style.opacity = '0';
        const id = Timer(() => {
          var _a;
          if (ref.IsValid()) {
            (_a = ref.GetChild(0)) === null || _a === void 0 ? void 0 : _a.DeleteAsync(0);
          }
        }, 3, undefined, 'AbilityPanel.AutocastablePanel');
        onCleanup(() => {
          StopTimer(id);
        });
      }
    });
    return [createElement("Panel", {
      id: "AutocastableBorder",
      hittest: false
    }, null), (() => {
      const _el$20 = createElement("Panel", {
        id: "AutoCastingContainer",
        hittest: false
      }, null);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$20) : ref = _el$20;
      return _el$20;
    })()];
  }

  function useDiyPolymer(entid, ablt_name) {
    if (typeof entid == 'function' || typeof ablt_name == 'function') {
      const getEntid = typeof entid == 'function' ? entid : () => entid;
      const getAbltName = typeof ablt_name == 'function' ? ablt_name : () => ablt_name;
      return useNetEventTable(t => t, 'diy_polymer', () => getAbltName() + ' ' + getEntid());
    }
    return useNetEventTable(t => t, 'diy_polymer', ablt_name + ' ' + entid);
  }

  const DragDropToDragTypes = {
    'Floor': [],
    'PublicPack': ['PackItem', 'GameItem', 'PackItem_game_item'],
    'PlayerPack': ['PackItem', 'GameItem', 'PackItem_game_item'],
    'GameItemSlot': ['GameItem', 'PackItem_game_item'],
    'EquipPack': ['Service_EquipItem'],
    'EquipDecompose': ['Service_EquipItem'],
    'EquipLock': ['Service_EquipItem'],
    'EquipWearSlot': ['Service_EquipItem'],
    'EquipSlot': ['Service_EquipItem'],
    'TradeGoodsOnItemBox': ['Service_EquipItem']
  };

  function RegDraggleDrop(pDropPanel, type, params, callback = {}) {
    pDropPanel['draggle/drop/params'] = () => ({
      type: typeof type == 'function' ? type() : type,
      params: typeof params == 'function' ? params() : params
    });
    pDropPanel['draggle/drop/callback'] = callback;
    for (const event of ['DragEnter', 'DragLeave', 'DragDrop']) {
      $.RegisterEventHandler(event, pDropPanel, (_, pDragPanel) => {
        var _a, _b, _c, _d;
        if (pDragPanel['drag_type'] == undefined) return;
        const tDropInfo = pDropPanel['draggle/drop/params']();
        const tDropTypes = DragDropToDragTypes[tDropInfo.type];
        if (tDropTypes.length > 0 && !tDropTypes.includes(pDragPanel['drag_type'])) return;
        try {
          (_b = (_a = pDragPanel['callback'])['on' + event]) === null || _b === void 0 ? void 0 : _b.call(_a, pDragPanel, {
            type: pDragPanel['drag_type'],
            params: pDragPanel['params']
          }, tDropInfo, pDropPanel);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
        try {
          (_d = (_c = pDropPanel['draggle/drop/callback'])['on' + event]) === null || _d === void 0 ? void 0 : _d.call(_c, pDragPanel, {
            type: pDragPanel['drag_type'],
            params: pDragPanel['params']
          }, tDropInfo, pDropPanel);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
      });
    }
    for (const [sEvent, sFunc] of [['ON_DRAG_START', 'onDragStart'], ['ON_DRAG_END', 'onDragEnd']]) {
      GameUI.CustomUIConfig().tools.EventManager.Reg(sEvent, ({
        pDragPanel,
        info
      }) => {
        var _a, _b;
        if (!pDropPanel.IsValid()) {
          return true;
        }
        if (info.type == undefined) return;
        const tDropInfo = pDropPanel['draggle/drop/params']();
        const tDropTypes = DragDropToDragTypes[tDropInfo.type];
        if (tDropTypes.length > 0 && !tDropTypes.includes(info.type)) return;
        try {
          (_b = (_a = pDropPanel['draggle/drop/callback'])[sFunc]) === null || _b === void 0 ? void 0 : _b.call(_a, pDragPanel, {
            type: info.type,
            params: pDragPanel['params']
          }, tDropInfo, pDropPanel);
        } catch (error) {
          GameUI.CustomUIConfig().UploadError(error);
        }
      }, pDropPanel);
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
  function CheckDragInfo(tInfo, ...args) {
    return args.includes(tInfo.type);
  }
  function CheckDropInfo(tInfo, ...args) {
    return args.includes(tInfo.type);
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

  const getter_iSelectUnit = useSelectUnit();

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
                    return memo(() => ((_b = getter.key) === null || _b === void 0 ? void 0 : _b.call(getter)) != undefined)() && !IsPassive$1(getName());
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
  function IsPassive$1(sItemName) {
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

  function RegDraggle(pDragSource, type, params, element, callback = {}) {
    const getType = typeof type == 'function' ? type : () => type;
    const getParams = typeof params == 'function' ? params : () => params;
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

  const Key2Command = {
    key_Backquote: "`",
    key_Tab: "TAB",
    key_Capslock: "CAPSLOCK",
    key_Space: "SPACE",
    key_Minus: "-",
    key_Equal: "=",
    key_Backspace: "BACKSPACE",
    key_Backslash: "\\",
    key_Semicolon: ";",
    key_Comma: ",",
    key_Period: ".",
    key_Slash: "/",
    key_Enter: "RETURN",
    key_1: "1",
    key_2: "2",
    key_3: "3",
    key_4: "4",
    key_5: "5",
    key_6: "6",
    key_7: "7",
    key_8: "8",
    key_9: "9",
    key_0: "0",
    key_F1: "F1",
    key_F2: "F2",
    key_F3: "F3",
    key_F4: "F4",
    key_F5: "F5",
    key_F6: "F6",
    key_F7: "F7",
    key_F8: "F8",
    key_F9: "F9",
    key_F10: "F10",
    key_F11: "F11",
    key_F12: "F12",
    key_Q: "Q",
    key_W: "W",
    key_E: "E",
    key_R: "R",
    key_T: "T",
    key_Y: "Y",
    key_U: "U",
    key_I: "I",
    key_O: "O",
    key_P: "P",
    key_A: "A",
    key_S: "S",
    key_D: "D",
    key_F: "F",
    key_G: "G",
    key_H: "H",
    key_J: "J",
    key_K: "K",
    key_L: "L",
    key_Z: "Z",
    key_X: "X",
    key_C: "C",
    key_V: "V",
    key_B: "B",
    key_N: "N",
    key_M: "M"
  };

  var _a;
  var ScreenPanel = (_a = class extends GameUI.CustomUIConfig().tools.ScreenPanel {
    static render(code, node) {
      return render(code, node);
    }
  }, __setFunctionName(_a, "ScreenPanel"), _a.pEnvContextPanel = $.GetContextPanel(), _a);

  const CfgGetter_weapon_attribute = useSystemConfig('weapon_attribute');

  const CfgGetter_archive_challenge = useSystemConfig('archive_challenge');

  const ServGetter_UserTowerRound = useNetEventTable(t => t, 'service', () => 'UserTowerRound_' + getter_iLocalPlayer())[0];

  const CfgGetter_tower = useSystemConfig('tower');

  const CfgGetter_wave_raid = useSystemConfig('wave_raid');

  const ServGetter_UserCommonData = useNetEventTable(t => t, 'service', () => 'UserCommonData_' + getter_iLocalPlayer())[0];

  const ServGetter_UserQiZhen = useNetEventTable(t => t, 'service', () => 'UserQizhenCollect_' + getter_iLocalPlayer())[0];

  function ArchiveChallenge() {
    const [getChallenge] = useNetEventTable(t => t, 'archive_challenge', () => 'challenge_' + getter_iLocalPlayer());
    const [getDifficult] = useNetEventTable(t => t, 'common', 'difficult');
    return (() => {
      const _el$ = createElement("Panel", {
          id: "ArchiveChallenge",
          get ["class"]() {
            return classNames({
              'Show': getShowArchiveChallenge()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        createElement("Panel", {
          "class": "TitleBG"
        }, _el$);
        const _el$4 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$5 = createElement("Panel", {
          "class": "Header"
        }, _el$4);
        createElement("Label", {
          "class": "TitleLabel",
          text: "#ArchiveChallengeTitle"
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$4),
        _el$8 = createElement("Button", {
          "class": "CloseBtn"
        }, _el$);
      insert(_el$7, createComponent(Index, {
        each: ['archive_challenge_1', 'archive_challenge_3', 'archive_challenge_4', 'archive_challenge_5', 'archive_challenge_8', 'archive_challenge_9', 'archive_challenge_13', 'archive_challenge_14'],
        children: (getName, i) => {
          const getCfg = () => {
            var _a;
            return (_a = CfgGetter_archive_challenge()) === null || _a === void 0 ? void 0 : _a[getName()];
          };
          const getData = () => {
            var _a;
            return (_a = getChallenge()) === null || _a === void 0 ? void 0 : _a[getName()];
          };
          const getCount = () => {
            var _a;
            return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.count) || 0;
          };
          const getMaxCount = () => {
            var _a;
            return (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['MaxLevel'];
          };
          const getNeedKillCount = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.need_kill_count;
          };
          const getIsMaxLevel = () => getMaxCount() != undefined && getCount() >= getMaxCount();
          const getDifficultUnlock = () => {
            var _a;
            return (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['DifficulUnlock'];
          };
          const getUnlock = () => (getDifficult() || 1) >= getDifficultUnlock();
          const getFinfish = () => getMaxCount() != undefined && getCount() >= getMaxCount();
          const getActive = createMemo(() => {
            if (getIsMaxLevel()) {
              return false;
            }
            return getUnlock();
          });
          const getChallengeState = () => {
            var _a;
            return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.state) || 0;
          };
          const getTitle = () => {
            return $.Localize('#' + getName());
          };
          const getImage = () => {
            return `file://{images}/custom_game/archive_challenge/${getName()}.png`;
          };
          const [getCanClick, setCanClick] = createSignal(true);
          return (() => {
            const _el$9 = createElement("Panel", {
                get ["class"]() {
                  return classNames('ChallengeRow', {
                    'Active': getActive(),
                    'IsUnlock': getUnlock(),
                    'IsFinfish': getFinfish()
                  });
                },
                onmouseout: HideTooltip
              }, null),
              _el$0 = createElement("Panel", {
                "class": "Body"
              }, _el$9);
              createElement("Panel", {
                "class": "BG"
              }, _el$0);
              const _el$10 = createElement("Panel", {
                "class": "Body"
              }, _el$0),
              _el$11 = createElement("Image", {
                id: "ChallengeRowImage",
                get src() {
                  return getImage();
                },
                scaling: 'stretch-to-fit-y-preserve-aspect',
                get style() {
                  return {
                    backgroundImage: `url("${getImage()}")`
                  };
                }
              }, _el$10),
              _el$12 = createElement("Panel", {
                "class": "StatePanel"
              }, _el$0);
            setProp(_el$9, "onmouseover", p => {
              ShowTooltip(p, 'common_detail_tooltip', {
                'sTitle': getTitle(),
                'sImg': getImage(),
                'tGroups': (() => {
                  const tGroups = [];
                  if (!getUnlock()) {
                    tGroups.push({
                      'sTitle': YellowText(ReplaceTextVariable($.Localize('#ArchiveChallengeUnlock'), {
                        'val': getDifficultUnlock()
                      }))
                    });
                  }
                  if (getFinfish()) {
                    tGroups.push({
                      'sContext': GreenText($.Localize('#archive_challenge_finish')) + '<br/>'
                    });
                  } else {
                    tGroups.push({
                      'sContext': $.Localize("#" + getName() + '_desc')
                    });
                  }
                  return tGroups;
                })()
              });
            });
            setProp(_el$9, "onmouseout", HideTooltip);
            setProp(_el$9, "onactivate", () => {
              if (!getCanClick()) return ErrorMsg('error_not_Click');
              setCanClick(false);
              Timer(() => {
                setCanClick(true);
              }, 1);
              if (getIsMaxLevel()) return ErrorMsg('error_max_level');
              if (getNeedKillCount() != undefined && (getNeedKillCount() || 0) > 0) return ErrorMsg('error_not_kill_finish');
              GameEvents.SendCustomGameEventToServer('OnArchiveChallenge', {
                'name': getName()
              });
            });
            insert(_el$12, createComponent(Show, {
              get when() {
                return getUnlock();
              },
              get fallback() {
                return (() => {
                  const _el$14 = createElement("Label", {
                    id: "StateLabel",
                    get text() {
                      return $.Localize('#archive_challenge_state_3');
                    },
                    html: true
                  }, null);
                  effect(_$p => setProp(_el$14, "text", $.Localize('#archive_challenge_state_3'), _$p));
                  return _el$14;
                })();
              },
              get children() {
                const _el$13 = createElement("Label", {
                  id: "StateLabel",
                  get text() {
                    return $.Localize('#archive_challenge_state_' + getChallengeState());
                  },
                  html: true
                }, null);
                effect(_$p => setProp(_el$13, "text", $.Localize('#archive_challenge_state_' + getChallengeState()), _$p));
                return _el$13;
              }
            }));
            effect(_p$ => {
              const _v$ = classNames('ChallengeRow', {
                  'Active': getActive(),
                  'IsUnlock': getUnlock(),
                  'IsFinfish': getFinfish()
                }),
                _v$2 = getImage(),
                _v$3 = {
                  backgroundImage: `url("${getImage()}")`
                };
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$9, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$11, "src", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$11, "style", _v$3, _p$._v$3));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined
            });
            return _el$9;
          })();
        }
      }), null);
      insert(_el$7, createComponent(TowerChallengeRow, {}), null);
      insert(_el$4, createComponent(Yzy_Button, {
        type: "btn_blue",
        text: "#ArchiveChallengeOneKey",
        "class": "OneKeyBtn",
        onactivate: _ => {
          GameEvents.SendCustomGameEventToServer('OnArchiveChallenge', {
            'name': '',
            'oneKey': true
          });
        }
      }), null);
      setProp(_el$8, "onactivate", _ => {
        setShowArchiveChallenge(false);
      });
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': getShowArchiveChallenge()
      }), _$p));
      return _el$;
    })();
  }
  function TowerChallengeRow() {
    const [getGameState] = useNetEventTable(t => t, 'common', 'game_state');
    const getTitle = () => {
      return $.Localize('#TowerChallengeOpen');
    };
    const getImage = () => {
      return `file://{images}/custom_game/archive_challenge/tower_challenge.png`;
    };
    const [getDifficult] = useNetEventTable(t => t, 'common', 'difficult');
    const getMaxRound = createMemo(() => {
      var _a;
      let iCfgMaxRound = 0;
      for (const iRound in CfgGetter_tower()) {
        const cfg = CfgGetter_tower()[iRound];
        if (cfg['diff'] <= (getDifficult() || 1) && Number(iRound) > iCfgMaxRound) {
          iCfgMaxRound = Number(iRound);
        }
      }
      const iUserMaxRound = Math.max(1, ((_a = ServGetter_UserTowerRound()) === null || _a === void 0 ? void 0 : _a['single']) || 1);
      return Math.min(iUserMaxRound, iCfgMaxRound);
    });
    const [getRound, setRound] = createSignal(Math.max(1, getMaxRound() - 10));
    const getIsActive = createMemo(() => {
      var _a;
      if (((_a = getGameState()) === null || _a === void 0 ? void 0 : _a.state_cur) != 'GS_Conclusion') return false;
      if (PlayerHost() != Players.GetLocalPlayer()) return false;
      if (!CfgGetter_tower()) return false;
      let iMinDiff = 99999;
      for (const key in CfgGetter_tower()) {
        const cfg = CfgGetter_tower()[key];
        if (cfg['diff'] < iMinDiff) {
          iMinDiff = cfg['diff'];
        }
      }
      return (getDifficult() || 1) >= iMinDiff;
    });
    return (() => {
      const _el$15 = createElement("Panel", {
          id: "TowerChallengeRow",
          get ["class"]() {
            return classNames('ChallengeRow', {
              'Active': true,
              'Show': getIsActive()
            });
          }
        }, null),
        _el$16 = createElement("Panel", {
          "class": "Body",
          onmouseout: HideTooltip
        }, _el$15);
        createElement("Panel", {
          "class": "BG"
        }, _el$16);
        const _el$18 = createElement("Panel", {
          "class": "Body"
        }, _el$16),
        _el$19 = createElement("Image", {
          id: "ChallengeRowImage",
          get src() {
            return getImage();
          },
          scaling: 'stretch-to-fit-y-preserve-aspect'
        }, _el$18),
        _el$20 = createElement("Panel", {
          "class": "RoundInput"
        }, _el$15);
        createElement("Label", {
          "class": "RoundLabel",
          text: "#TowerRoundTitle"
        }, _el$20);
      setProp(_el$16, "onmouseover", p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': getTitle(),
          'sImg': getImage(),
          'tGroups': (() => {
            const tGroups = [];
            tGroups.push({
              'sTitle': YellowText($.Localize('#tower_challenge_title')),
              'sContext': GreenText($.Localize('#tower_challenge_desc'))
            });
            return tGroups;
          })()
        });
      });
      setProp(_el$16, "onmouseout", HideTooltip);
      setProp(_el$16, "onactivate", () => {
        if (PlayerHost() != Players.GetLocalPlayer()) return ErrorMsg('error_need_player_host');
        if (!getIsActive()) return;
        GameEvents.SendCustomGameEventToServer('OnTowerOpen', {
          'round': getRound()
        });
      });
      insert(_el$20, createComponent(Show, {
        get when() {
          return memo(() => !!getMaxRound())() && getRound();
        },
        get children() {
          const _el$22 = createElement("NumberEntry", {
            "class": "NumberEntry CustomStyling1",
            min: 1,
            increment: 1,
            get max() {
              return getMaxRound();
            },
            get value() {
              return getRound();
            }
          }, null);
          setProp(_el$22, "onvaluechanged", p => {
            setRound(p.value);
          });
          effect(_p$ => {
            const _v$4 = getMaxRound(),
              _v$5 = getRound();
            _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$22, "max", _v$4, _p$._v$4));
            _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$22, "value", _v$5, _p$._v$5));
            return _p$;
          }, {
            _v$4: undefined,
            _v$5: undefined
          });
          return _el$22;
        }
      }), null);
      effect(_p$ => {
        const _v$6 = classNames('ChallengeRow', {
            'Active': true,
            'Show': getIsActive()
          }),
          _v$7 = getImage();
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$15, "class", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$19, "src", _v$7, _p$._v$7));
        return _p$;
      }, {
        _v$6: undefined,
        _v$7: undefined
      });
      return _el$15;
    })();
  }
  function RaidChallenge() {
    const getBossList = createMemo(() => {
      var _a;
      const tRaidCfg = (_a = CfgGetter_wave_raid()) !== null && _a !== void 0 ? _a : {};
      const tBossList = {};
      for (const key in tRaidCfg) {
        const tDiffCfg = tRaidCfg[key];
        for (const diffKey in tDiffCfg) {
          const {
            boss_name,
            is_hide,
            unlock_diff
          } = tDiffCfg[diffKey];
          if (is_hide == 1) {
            if (!tBossList[key]) {
              tBossList[key] = {
                'boss_name': boss_name,
                'unlock_min_diff': unlock_diff,
                'diffList': {}
              };
            }
            tBossList[key].is_hide = true;
            continue;
          }
          if (!tBossList[key]) {
            tBossList[key] = {
              'boss_name': boss_name,
              'unlock_min_diff': unlock_diff,
              'diffList': {}
            };
          }
          tBossList[key]['diffList'][diffKey] = {
            'unlock_diff': unlock_diff
          };
          if (unlock_diff < tBossList[key]['unlock_min_diff']) {
            tBossList[key]['unlock_min_diff'] = unlock_diff;
          }
        }
        if (tBossList[key].is_hide) {
          delete tBossList[key];
        }
      }
      return tBossList;
    });
    const [getDifficult] = useNetEventTable(t => t, 'common', 'difficult');
    const getCurDifficult = () => getDifficult() || 1;
    const [getSelectBoss, setSelectBoss] = createSignal();
    const [getSelectDiff, setSelectDiff] = createSignal();
    const getUseNotUseTicketData = createMemo(() => {
      var _a, _b;
      ServGetter_UserCommonData();
      const tData = (_b = (_a = ServGetter_UserCommonData()) === null || _a === void 0 ? void 0 : _a['raid_challenge_not_use_ticket_data']) !== null && _b !== void 0 ? _b : '0';
      return tData;
    });
    const setUseNotUseTicketData = sUse => {
      ShowMouseProcessing();
      $.Msg('SetServiceCommonData_RaidChallengeNotUseTicketData', sUse);
      Request('SetServiceCommonData_RaidChallengeNotUseTicketData', {
        'user_id': 0,
        'data': sUse
      }).then(res => {
        var _a;
        HideMouseProcessing();
        if ((res === null || res === void 0 ? void 0 : res.code) != 0) {
          ErrorMsg((_a = res === null || res === void 0 ? void 0 : res.msg) !== null && _a !== void 0 ? _a : '#error_request_fail');
        }
      }).catch(err => {
        ErrorMsg('RequestError');
        $.Warning('SetServiceCommonData_RaidChallengeNotUseTicketDataErr: ', err);
      });
    };
    const getUnlockedDiffKeys = sBoss => {
      const tBossCfg = sBoss ? getBossList()[sBoss] : undefined;
      if (!tBossCfg) return [];
      const iDiff = getCurDifficult();
      return Object.keys(tBossCfg.diffList).filter(diffKey => tBossCfg.diffList[diffKey].unlock_diff <= iDiff).sort((a, b) => Number(a) - Number(b));
    };
    const getMaxUnlockedDiffKey = sBoss => {
      const tKeys = getUnlockedDiffKeys(sBoss);
      return tKeys[tKeys.length - 1];
    };
    createEffect(() => {
      $.Msg('getUnlockedDiffKeys: ', getUnlockedDiffKeys());
      $.Msg('getMaxUnlockedDiffKey: ', getMaxUnlockedDiffKey());
    });
    const resetSelect = () => {
      var _a, _b;
      let iUseBoss = Object.keys(getBossList())[0];
      let iDiffKey = Object.keys((_b = (_a = getBossList()[iUseBoss]) === null || _a === void 0 ? void 0 : _a['diffList']) !== null && _b !== void 0 ? _b : {})[0];
      let iUseUnlockDiff = -1;
      for (const key in getBossList()) {
        const tBossCfg = getBossList()[key];
        if (tBossCfg.unlock_min_diff > getCurDifficult()) continue;
        for (const diffKey in tBossCfg.diffList) {
          const tDiffCfg = tBossCfg.diffList[diffKey];
          if (tDiffCfg.unlock_diff <= getCurDifficult() && tDiffCfg.unlock_diff > iUseUnlockDiff) {
            iUseBoss = key;
            iDiffKey = diffKey;
            iUseUnlockDiff = tDiffCfg.unlock_diff;
          }
        }
      }
      setSelectBoss(iUseBoss);
      setSelectDiff(iDiffKey);
    };
    const selectBoss = sBoss => {
      var _a, _b, _c;
      setSelectBoss(sBoss);
      setSelectDiff((_a = getMaxUnlockedDiffKey(sBoss)) !== null && _a !== void 0 ? _a : Object.keys((_c = (_b = getBossList()[sBoss]) === null || _b === void 0 ? void 0 : _b.diffList) !== null && _c !== void 0 ? _c : {})[0]);
    };
    const changeSelectDiff = iDelta => {
      const sBoss = getSelectBoss();
      const sCur = getSelectDiff();
      if (!sBoss || !sCur) return;
      const tKeys = getUnlockedDiffKeys(sBoss);
      const iIdx = tKeys.indexOf(sCur);
      if (iIdx < 0) {
        setSelectDiff(getMaxUnlockedDiffKey(sBoss));
        return;
      }
      const sNext = tKeys[iIdx + iDelta];
      if (sNext != undefined) {
        setSelectDiff(sNext);
      }
    };
    createEffect(() => {
      if (!getSelectBoss() || !getSelectDiff()) {
        resetSelect();
      }
    });
    createEffect(on(getDifficult, () => {
      resetSelect();
    }));
    const getShowReward = createMemo(() => {
      var _a, _b, _c, _d, _e;
      getSelectBoss();
      getSelectDiff();
      CfgGetter_wave_raid();
      if (!getSelectBoss() || !getSelectDiff()) return [];
      const tRaidCfg = (_a = CfgGetter_wave_raid()) !== null && _a !== void 0 ? _a : {};
      const tCfgRow = (_b = tRaidCfg[getSelectBoss()]) === null || _b === void 0 ? void 0 : _b[getSelectDiff()];
      if (!tCfgRow) return [];
      const tReward = Str2RewardMap((_c = tCfgRow['reward_item']) !== null && _c !== void 0 ? _c : '');
      const tResult = [];
      for (const key in tReward) {
        const tItem = tReward[key];
        tResult.push({
          'item_id': Number(key),
          'count': Number(tItem),
          'chance': 10000
        });
      }
      const tQizhen = Str2RewardMap((_d = tCfgRow === null || tCfgRow === void 0 ? void 0 : tCfgRow['qizhen_pool']) !== null && _d !== void 0 ? _d : '');
      for (const itemId in tQizhen) {
        const iChance = tQizhen[itemId];
        tResult.push({
          'item_id': Number(itemId),
          'count': 1,
          'chance': Number(iChance)
        });
      }
      tResult.push({
        'item_id': 226,
        'count': 1,
        'chance': (_e = tCfgRow === null || tCfgRow === void 0 ? void 0 : tCfgRow['chance_holy']) !== null && _e !== void 0 ? _e : 0
      });
      return tResult;
    });
    const onClickChallenge = () => {
      if (PlayerHost() != Players.GetLocalPlayer()) return ErrorMsg('error_need_player_host');
      const sBoss = getSelectBoss();
      const sDiff = getSelectDiff();
      if (!sBoss || !sDiff) return;
      const tBossCfg = getBossList()[sBoss];
      if (!tBossCfg || tBossCfg.unlock_min_diff > getCurDifficult()) return ErrorMsg('error_not_unlock');
      const tDiffCfg = tBossCfg.diffList[sDiff];
      if (!tDiffCfg || tDiffCfg.unlock_diff > getCurDifficult()) return ErrorMsg('error_not_unlock');
      GameEvents.SendCustomGameEventToServer('RaidChallenge_Open', {
        raid_id: Number(sBoss),
        raid_diff: Number(sDiff)
      });
      setShowRaidChallenge(false);
    };
    const [getUserUseTimes] = useNetEventTable(t => t || 0, 'service', () => 'UserRaidBossRewardFreeTimes_' + getter_iLocalPlayer());
    const getFreeTimes = createMemo(() => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['RaidBossRewardFreeTimes']) !== null && _b !== void 0 ? _b : 0;
    });
    const getSelectTicketId = createMemo(() => {
      var _a;
      const sBoss = getSelectBoss();
      if (!sBoss) return undefined;
      return (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a[`ItemId_RaidBossTicket${sBoss}`];
    });
    return (() => {
      const _el$23 = createElement("Panel", {
          id: "RaidChallenge",
          get ["class"]() {
            return classNames({
              'Show': getShowRaidChallenge()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "ContentsBG"
        }, _el$23);
        const _el$25 = createElement("Panel", {
          "class": "Contents"
        }, _el$23),
        _el$26 = createElement("Panel", {
          "class": "TitleContainer"
        }, _el$25);
        createElement("Panel", {
          "class": "TitleTexture"
        }, _el$26);
        createElement("Panel", {
          "class": "TitleDash"
        }, _el$26);
        const _el$29 = createElement("Panel", {
          "class": "TitleLabelContainer"
        }, _el$26);
        createElement("Label", {
          "class": "TitleLabel",
          text: "#RaidChallengeTitle"
        }, _el$29);
        const _el$31 = createElement("Panel", {
          "class": "RaidRewardsFreeTimes"
        }, _el$26),
        _el$32 = createElement("Label", {
          "class": "RaidRewardsFreeTimesLabel",
          get text() {
            return ReplaceTextVariable('#RaidChallengeFreeTimes', {
              'limit': getFreeTimes(),
              'use': YellowText(getUserUseTimes(), 'UseLabel')
            });
          },
          html: true
        }, _el$31),
        _el$33 = createElement("Panel", {
          "class": "RaidRewardNotUseTicket",
          onmouseout: HideTooltip
        }, _el$26),
        _el$34 = createElement("Panel", {
          id: "MainBody",
          "class": ""
        }, _el$25),
        _el$35 = createElement("Panel", {
          "class": "Left"
        }, _el$34),
        _el$36 = createElement("Panel", {
          "class": "BossList"
        }, _el$35);
        createElement("Panel", {
          "class": "ContentDash"
        }, _el$34);
        const _el$38 = createElement("Panel", {
          "class": "Right"
        }, _el$34),
        _el$39 = createElement("Panel", {
          "class": "RewardTitle"
        }, _el$38);
        createElement("Label", {
          "class": "RewardTitleLabel",
          text: "#RaidChallengeRewardTitle"
        }, _el$39);
        const _el$41 = createElement("Panel", {
          "class": "RewardPanel"
        }, _el$38),
        _el$42 = createElement("Panel", {
          "class": "Operate"
        }, _el$34),
        _el$43 = createElement("Panel", {
          "class": "DiffGroupBtn"
        }, _el$42),
        _el$44 = createElement("Panel", {
          "class": "ChangeBtn DecreaseBtn"
        }, _el$43),
        _el$45 = createElement("Label", {
          "class": "DiffLabel",
          get text() {
            return '#RaidBossDiff_' + getSelectDiff();
          }
        }, _el$43),
        _el$46 = createElement("Panel", {
          "class": "ChangeBtn IncreaseBtn"
        }, _el$43);
        createElement("Panel", {
          "class": "PopupBorder",
          hittest: false
        }, _el$23);
        const _el$49 = createElement("Button", {
          "class": "ClosePopupButton"
        }, _el$23);
        createElement("Panel", {
          "class": "BorderInner"
        }, _el$49);
        createElement("Image", {
          "class": "CloseIcon",
          src: "s2r://panorama/images/control_icons/24px/x_close.vsvg"
        }, _el$49);
      insert(_el$29, createComponent(Yzy_Icon, {
        "class": "TipsIcon",
        type: "icon_tips",
        onmouseover: p => {
          ShowTooltip(p, 'common_detail_tooltip', {
            'sContext': '#RaidChallengeTitleTips'
          });
        },
        onmouseout: HideTooltip
      }), null);
      setProp(_el$33, "onmouseover", p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sContext': '#RaidChallengeNotUseTicketTips'
        });
      });
      setProp(_el$33, "onmouseout", HideTooltip);
      insert(_el$33, () => {
        getUseNotUseTicketData();
        return (() => {
          const _el$52 = createElement("ToggleButton", {
            "class": "RaidRewardNotUseTicketBtn",
            text: "#RaidChallengeNotUseTicket"
          }, null);
          setProp(_el$52, "onactivate", () => {
            setUseNotUseTicketData(getUseNotUseTicketData() == '1' ? '0' : '1');
          });
          effect(_$p => setProp(_el$52, "checked", getUseNotUseTicketData() == '1', _$p));
          return _el$52;
        })();
      });
      insert(_el$36, createComponent(Index, {
        get each() {
          return Object.keys(getBossList());
        },
        children: (key, i) => {
          const tCfg = getBossList()[key()];
          const getIsUnlock = () => tCfg.unlock_min_diff <= getCurDifficult();
          return (() => {
            const _el$53 = createElement("Panel", {
                "class": "BossRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$53);
              const _el$55 = createElement("Panel", {
                "class": "Body"
              }, _el$53),
              _el$56 = createElement("Panel", {
                "class": "BossImage",
                get style() {
                  return {
                    backgroundImage: `url("file://{images}/custom_game/lower_hud/${tCfg.boss_name}.png")`
                  };
                }
              }, _el$55),
              _el$57 = createElement("Label", {
                "class": "BossName",
                get text() {
                  return '#' + tCfg.boss_name;
                }
              }, _el$55);
            setProp(_el$53, "onactivate", p => {
              if (!getIsUnlock()) return;
              selectBoss(key());
            });
            effect(_p$ => {
              const _v$10 = {
                  'Active': getSelectBoss() == key(),
                  'IsUnlock': getIsUnlock()
                },
                _v$11 = {
                  backgroundImage: `url("file://{images}/custom_game/lower_hud/${tCfg.boss_name}.png")`
                },
                _v$12 = '#' + tCfg.boss_name;
              _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$53, "classList", _v$10, _p$._v$10));
              _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$56, "style", _v$11, _p$._v$11));
              _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$57, "text", _v$12, _p$._v$12));
              return _p$;
            }, {
              _v$10: undefined,
              _v$11: undefined,
              _v$12: undefined
            });
            return _el$53;
          })();
        }
      }));
      insert(_el$41, createComponent(Index, {
        get each() {
          return getShowReward();
        },
        children: (item, i) => {
          const getItemId = () => item().item_id;
          const getIsQiZhenOwned = () => {
            var _a, _b, _c;
            if (!((_a = CfgGetter_qizhen()) === null || _a === void 0 ? void 0 : _a[getItemId()])) return false;
            return ((_c = (_b = ServGetter_UserQiZhen()) === null || _b === void 0 ? void 0 : _b[getItemId()]) !== null && _c !== void 0 ? _c : 0) > 0;
          };
          return (() => {
            const _el$58 = createElement("Panel", {
              "class": "RewardItem"
            }, null);
            insert(_el$58, createComponent(Yzy_ServiceItem, {
              get data() {
                return {
                  'id': getItemId().toString(),
                  'count': item().count
                };
              },
              get children() {
                return [(() => {
                  const _el$59 = createElement("Label", {
                    "class": "ChanceLabel",
                    get text() {
                      return NumFixRatio(item().chance / 100, 2) + '%';
                    }
                  }, null);
                  effect(_$p => setProp(_el$59, "text", NumFixRatio(item().chance / 100, 2) + '%', _$p));
                  return _el$59;
                })(), createComponent(Show, {
                  get when() {
                    return getIsQiZhenOwned();
                  },
                  get children() {
                    return createComponent(Yzy_Icon, {
                      "class": "OwnedIcon",
                      type: "icon_y",
                      hittest: false
                    });
                  }
                })];
              }
            }));
            return _el$58;
          })();
        }
      }));
      setProp(_el$44, "onactivate", () => changeSelectDiff(-1));
      setProp(_el$46, "onactivate", () => changeSelectDiff(1));
      insert(_el$42, createComponent(Yzy_Button, {
        "class": "ChallengeBtn",
        type: "btn_golden",
        text: "#RaidChallengeChallenge",
        onactivate: onClickChallenge
      }), null);
      insert(_el$34, createComponent(Show, {
        get when() {
          return getSelectTicketId();
        },
        get children() {
          const _el$47 = createElement("Panel", {
            "class": "RaidBossTicket ServiceAssetGroup",
            hittest: false
          }, null);
          insert(_el$47, createComponent(ServiceItemAsset, {
            get item_id() {
              return getSelectTicketId();
            }
          }));
          return _el$47;
        }
      }), null);
      setProp(_el$49, "onactivate", _ => {
        setShowRaidChallenge(false);
      });
      effect(_p$ => {
        const _v$8 = classNames({
            'Show': getShowRaidChallenge()
          }),
          _v$9 = ReplaceTextVariable('#RaidChallengeFreeTimes', {
            'limit': getFreeTimes(),
            'use': YellowText(getUserUseTimes(), 'UseLabel')
          }),
          _v$0 = {
            'Show': isHost()
          },
          _v$1 = '#RaidBossDiff_' + getSelectDiff();
        _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$23, "class", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$32, "text", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$42, "classList", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$45, "text", _v$1, _p$._v$1));
        return _p$;
      }, {
        _v$8: undefined,
        _v$9: undefined,
        _v$0: undefined,
        _v$1: undefined
      });
      return _el$23;
    })();
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

  const [getRoundPrepara] = useNetEventTable(t => t, 'common', 'round_prepara');
  const [getRound] = useNetEventTable(t => t, 'common', 'round');
  useNetEventTable(t => t, 'common', 'wave');
  const [getDifficult] = useNetEventTable(t => t, 'common', 'difficult');
  const [getSubDifficult] = useNetEventTable(t => t, 'common', 'sub_difficult');
  const [getGameResult] = useNetEventTable(t => t, 'common', 'game_result');
  function RoundPanel() {
    var _a, _b, _c, _d, _e, _f, _g, _h;
    const [getGameState] = useNetEventTable(t => t, 'common', 'game_state');
    const [getBoss] = useNetEventTable(t => t, 'common', 'boss');
    const [getRaidBoss] = useNetEventTable(t => t, 'raid_challenge', 'boss_entindex');
    const [getRaidStatus] = useNetEventTable(t => t, 'raid_challenge', 'status_info');
    const getRaidActive = () => {
      var _a;
      return ((_a = getRaidStatus()) === null || _a === void 0 ? void 0 : _a.start_time) != undefined && !getRaidStatus().is_finished;
    };
    const [getMode] = useNetEventTable(t => t, 'common', 'mode');
    return (() => {
      const _el$ = createElement("Panel", {
          id: "RoundPanel",
          get ["class"]() {
            return classNames((_a = getGameState()) === null || _a === void 0 ? void 0 : _a.state_cur, {
              'GS_Boss': getRaidActive()
            });
          },
          hittest: false
        }, null),
        _el$2 = createElement("Panel", {
          id: "Round",
          hittest: false
        }, _el$);
      insert(_el$2, createComponent(Switch, {
        get children() {
          return [createComponent(Match, {
            get when() {
              return memo(() => ((_b = getGameState()) === null || _b === void 0 ? void 0 : _b.state_cur) == 'GS_Main')() && getRoundPrepara() == 1;
            },
            get children() {
              return createComponent(GS_Prepara, {});
            }
          }), createComponent(Match, {
            get when() {
              return memo(() => ((_c = getGameState()) === null || _c === void 0 ? void 0 : _c.state_cur) == 'GS_Main')() && getRoundPrepara() != 1;
            },
            get children() {
              return createComponent(GS_Main, {});
            }
          }), createComponent(Match, {
            get when() {
              return ((_d = getGameState()) === null || _d === void 0 ? void 0 : _d.state_cur) == 'GS_Boss';
            },
            get children() {
              return createComponent(GS_Boss, {});
            }
          }), createComponent(Match, {
            get when() {
              return memo(() => ((_e = getGameState()) === null || _e === void 0 ? void 0 : _e.state_cur) == 'GS_Conclusion')() && !getRaidActive();
            },
            get children() {
              return createComponent(GS_Conclusion, {});
            }
          }), createComponent(Match, {
            get when() {
              return memo(() => ((_f = getGameState()) === null || _f === void 0 ? void 0 : _f.state_cur) == 'GS_Conclusion')() && getRaidActive();
            },
            get children() {
              return createComponent(GS_RaidChallenge, {});
            }
          }), createComponent(Match, {
            get when() {
              return ((_g = getGameState()) === null || _g === void 0 ? void 0 : _g.state_cur) == 'GS_Tower' || ((_h = getGameState()) === null || _h === void 0 ? void 0 : _h.state_cur) == 'GS_Tower_Conclusion';
            },
            get children() {
              return createComponent(GS_Tower, {});
            }
          })];
        }
      }));
      insert(_el$, createComponent(Show, {
        get when() {
          return getBoss() != undefined;
        },
        get children() {
          return createComponent(UnitBigBar, {
            get entid() {
              return getBoss();
            }
          });
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return getRaidBoss() != undefined;
        },
        get children() {
          return createComponent(UnitBigBar, {
            get entid() {
              return getRaidBoss();
            }
          });
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return getMode() == 2;
        },
        get children() {
          return createComponent(MoltenHeat, {});
        }
      }), null);
      effect(_$p => setProp(_el$, "class", classNames((_a = getGameState()) === null || _a === void 0 ? void 0 : _a.state_cur, {
        'GS_Boss': getRaidActive()
      }), _$p));
      return _el$;
    })();
  }
  function GS_Prepara() {
    useNetEventTable(t => t, 'common', 'prepara_start_time');
    const [getPreparaEndTime] = useNetEventTable(t => t, 'common', 'prepara_end_time');
    return (() => {
      const _el$3 = createElement("Panel", {
          id: "GS_Prepara",
          "class": "RoundDetial"
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        const _el$5 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$6 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$5);
        createElement("Label", {
          "class": "Title",
          text: '#RoundTitle'
        }, _el$6);
        const _el$8 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getRound() || 0) + '/5';
          }
        }, _el$6),
        _el$9 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$5);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$9);
        const _el$1 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$9);
        createElement("Label", {
          id: "GS_PreparaTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Prepara'
        }, _el$5);
        const _el$11 = createElement("Panel", {
          "class": "CountDownPanel"
        }, _el$5);
      insert(_el$11, createComponent(CountDown, {
        "class": "CountDown",
        get fTimeEnd() {
          return getPreparaEndTime();
        },
        get children() {
          return createElement("Label", {
            "class": "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      effect(_p$ => {
        const _v$ = (getRound() || 0) + '/5',
          _v$2 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$8, "text", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$1, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$3;
    })();
  }
  function GS_Main() {
    useNetEventTable(t => t, 'common', 'round_start_time');
    const [getRoundEndTime] = useNetEventTable(t => t, 'common', 'round_end_time');
    return (() => {
      const _el$13 = createElement("Panel", {
          id: "GS_Main",
          hittest: false,
          get ["class"]() {
            return classNames('RoundDetial');
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$13);
        const _el$15 = createElement("Panel", {
          "class": "Body"
        }, _el$13),
        _el$16 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$15);
        createElement("Label", {
          "class": "Title",
          text: '#RoundTitle'
        }, _el$16);
        const _el$18 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getRound() || 0) + '/5';
          }
        }, _el$16),
        _el$19 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$15);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$19);
        const _el$21 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$19);
        createElement("Label", {
          id: "GS_MainTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Main'
        }, _el$15);
        const _el$23 = createElement("Panel", {
          "class": "CountDownPanel"
        }, _el$15);
      insert(_el$23, createComponent(CountDown, {
        "class": "CountDown",
        get fTimeEnd() {
          return getRoundEndTime();
        },
        get tFormatCfg() {
          return FormatTimeStyle.Clock_ms;
        },
        get children() {
          return createElement("Label", {
            "class": "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      effect(_p$ => {
        const _v$3 = classNames('RoundDetial'),
          _v$4 = (getRound() || 0) + '/5',
          _v$5 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$13, "class", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$18, "text", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$21, "text", _v$5, _p$._v$5));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined
      });
      return _el$13;
    })();
  }
  function GS_Boss() {
    useNetEventTable(t => t, 'common', 'boss_start_time');
    const [getBossEndTime] = useNetEventTable(t => t, 'common', 'boss_end_time');
    return (() => {
      const _el$25 = createElement("Panel", {
          id: "GS_Boss",
          hittest: false,
          get ["class"]() {
            return classNames('RoundDetial');
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$25);
        const _el$27 = createElement("Panel", {
          "class": "Body"
        }, _el$25),
        _el$28 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$27);
        createElement("Label", {
          "class": "Title",
          text: '#RoundTitle'
        }, _el$28);
        const _el$30 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getRound() || 0) + '/5';
          }
        }, _el$28),
        _el$31 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$27);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$31);
        const _el$33 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$31);
        createElement("Label", {
          id: "GS_BossTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Boss'
        }, _el$27);
        const _el$35 = createElement("Panel", {
          "class": "CountDownPanel"
        }, _el$27);
      insert(_el$35, createComponent(CountDown, {
        "class": "CountDown",
        get fTimeEnd() {
          return getBossEndTime();
        },
        get tFormatCfg() {
          return FormatTimeStyle.Clock_ms;
        },
        get children() {
          return createElement("Label", {
            "class": "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      effect(_p$ => {
        const _v$6 = classNames('RoundDetial'),
          _v$7 = (getRound() || 0) + '/5',
          _v$8 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$25, "class", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$30, "text", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$33, "text", _v$8, _p$._v$8));
        return _p$;
      }, {
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined
      });
      return _el$25;
    })();
  }
  function GS_RaidChallenge() {
    const [getRaidStatus] = useNetEventTable(t => t, 'raid_challenge', 'status_info');
    return (() => {
      const _el$37 = createElement("Panel", {
          id: "GS_RaidChallenge",
          hittest: false,
          get ["class"]() {
            return classNames('RoundDetial');
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$37);
        const _el$39 = createElement("Panel", {
          "class": "Body"
        }, _el$37),
        _el$40 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$39);
        createElement("Label", {
          "class": "Title",
          text: '#RoundTitle'
        }, _el$40);
        const _el$42 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getRound() || 0) + '/5';
          }
        }, _el$40),
        _el$43 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$39);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$43);
        const _el$45 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$43);
        createElement("Label", {
          id: "GS_RaidChallengeTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Boss'
        }, _el$39);
        const _el$47 = createElement("Panel", {
          "class": "CountDownPanel"
        }, _el$39);
      insert(_el$47, createComponent(CountDown, {
        "class": "CountDown",
        fTimeEnd: () => {
          var _a;
          return (_a = getRaidStatus()) === null || _a === void 0 ? void 0 : _a.end_time;
        },
        get tFormatCfg() {
          return FormatTimeStyle.Clock_ms;
        },
        get children() {
          return createElement("Label", {
            "class": "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      effect(_p$ => {
        const _v$9 = classNames('RoundDetial'),
          _v$0 = (getRound() || 0) + '/5',
          _v$1 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$37, "class", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$42, "text", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$45, "text", _v$1, _p$._v$1));
        return _p$;
      }, {
        _v$9: undefined,
        _v$0: undefined,
        _v$1: undefined
      });
      return _el$37;
    })();
  }
  function GS_Conclusion() {
    useNetEventTable(t => t, 'tower', 'round_start_time');
    const [getTowerRoundEndTime] = useNetEventTable(t => t, 'tower', 'round_end_time');
    useNetEventTable(t => t, 'tower', 'round');
    return (() => {
      const _el$49 = createElement("Panel", {
          id: "GS_Conclusion",
          hittest: false,
          get ["class"]() {
            return classNames('RoundDetial');
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$49);
        const _el$51 = createElement("Panel", {
          "class": "Body"
        }, _el$49),
        _el$52 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$51);
        createElement("Label", {
          "class": "Title",
          text: '#RoundTitle'
        }, _el$52);
        const _el$54 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getRound() || 0) + '/5';
          }
        }, _el$52),
        _el$55 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$51);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$55);
        const _el$57 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$55);
        createElement("Label", {
          id: "GS_ConclusionTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Conclusion'
        }, _el$51);
        const _el$59 = createElement("Panel", {
          "class": "CountDownPanel"
        }, _el$51);
      insert(_el$59, createComponent(CountDown, {
        "class": "CountDown",
        get fTimeEnd() {
          return getTowerRoundEndTime();
        },
        get children() {
          return createElement("Label", {
            "class": "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      effect(_p$ => {
        const _v$10 = classNames('RoundDetial'),
          _v$11 = (getRound() || 0) + '/5',
          _v$12 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$49, "class", _v$10, _p$._v$10));
        _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$54, "text", _v$11, _p$._v$11));
        _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$57, "text", _v$12, _p$._v$12));
        return _p$;
      }, {
        _v$10: undefined,
        _v$11: undefined,
        _v$12: undefined
      });
      return _el$49;
    })();
  }
  function GS_Tower() {
    var _a, _b;
    useNetEventTable(t => t, 'tower', 'round_start_time');
    const [getTowerRoundEndTime] = useNetEventTable(t => t, 'tower', 'round_end_time');
    const [getTowerRound] = useNetEventTable(t => t, 'tower', 'round');
    const [getConclusion] = useNetEventTable(t => t, 'tower_conclusion', 'conclusion');
    return (() => {
      const _el$61 = createElement("Panel", {
          id: "GS_Tower",
          hittest: false,
          get ["class"]() {
            return classNames('RoundDetial');
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$61);
        const _el$63 = createElement("Panel", {
          "class": "Body"
        }, _el$61),
        _el$64 = createElement("Panel", {
          id: "RoundTitle",
          "class": "DetialTitle"
        }, _el$63);
        createElement("Label", {
          "class": "Title",
          text: '#TowerRoundTitle'
        }, _el$64);
        const _el$66 = createElement("Label", {
          "class": "Value",
          get text() {
            return getTowerRound() || 0;
          }
        }, _el$64),
        _el$67 = createElement("Panel", {
          id: "DifficultTitle",
          "class": "DetialTitle"
        }, _el$63);
        createElement("Label", {
          "class": "Title",
          text: '#DifficultTitle'
        }, _el$67);
        const _el$69 = createElement("Label", {
          "class": "Value",
          get text() {
            return (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
          }
        }, _el$67);
        createElement("Label", {
          id: "GS_TowerTitle",
          "class": "GS_DetialTitle",
          text: '#GS_Tower'
        }, _el$63);
      insert(_el$63, createComponent(Show, {
        get when() {
          return ((_a = getConclusion()) === null || _a === void 0 ? void 0 : _a.win) != undefined;
        },
        get fallback() {
          return (() => {
            const _el$72 = createElement("Panel", {
              "class": "CountDownPanel"
            }, null);
            insert(_el$72, createComponent(CountDown, {
              "class": "CountDown",
              get fTimeEnd() {
                return getTowerRoundEndTime();
              },
              get children() {
                return createElement("Label", {
                  "class": "TimeLabel",
                  text: "{s:countdown_time}"
                }, null);
              }
            }));
            return _el$72;
          })();
        },
        get children() {
          const _el$71 = createElement("Label", {
            id: "WinLab",
            get text() {
              return ((_b = getConclusion()) === null || _b === void 0 ? void 0 : _b.win) ? 'TowerWin' : 'TowerLose';
            }
          }, null);
          effect(_$p => setProp(_el$71, "text", ((_b = getConclusion()) === null || _b === void 0 ? void 0 : _b.win) ? 'TowerWin' : 'TowerLose', _$p));
          return _el$71;
        }
      }), null);
      effect(_p$ => {
        const _v$13 = classNames('RoundDetial'),
          _v$14 = getTowerRound() || 0,
          _v$15 = (getDifficult() || 0) + (getSubDifficult() || 0 > 0 ? '-' + getSubDifficult() : '');
        _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$61, "class", _v$13, _p$._v$13));
        _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$66, "text", _v$14, _p$._v$14));
        _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$69, "text", _v$15, _p$._v$15));
        return _p$;
      }, {
        _v$13: undefined,
        _v$14: undefined,
        _v$15: undefined
      });
      return _el$61;
    })();
  }
  function UnitBigBar(props) {
    let ref;
    const getter = PropsGetter(props);
    createEffect(() => {
      const iEntID = getter.entid();
      const id = Timer(() => {
        const p = ref.FindChildTraverse('HpBar');
        let fPct = Entities.GetHealthPercent(iEntID);
        let pBar = p.FindChildInLayoutFile('HpBufferPanel');
        let s = `translateX(-${Math.abs(100 - fPct) || 0}%)`;
        if (pBar) {
          pBar.style.transform = s;
        }
        pBar = p.FindChildInLayoutFile('HpFG');
        if (pBar) {
          pBar.style.transform = s;
        }
        ref === null || ref === void 0 ? void 0 : ref.SetDialogVariable('cur_hp', FormatNumber(Entities.GetHealth(iEntID)));
        ref === null || ref === void 0 ? void 0 : ref.SetDialogVariable('max_hp', FormatNumber(Entities.GetMaxHealth(iEntID)));
        return 0;
      }, 0, undefined, 'UnitBigBar');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$74 = createElement("Panel", {
          "class": "UnitBigBar"
        }, null),
        _el$75 = createElement("Panel", {
          id: "HpBar",
          "class": "BossBarHpPanel"
        }, _el$74);
        createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$75);
        const _el$77 = createElement("Panel", {
          id: "HpFG"
        }, _el$75);
        createElement("DOTAScenePanel", {
          map: "scenes/hud/healthbarburner",
          camera: "camera_1",
          renderdeferred: false,
          rendershadows: false,
          hittest: false,
          particleonly: true
        }, _el$77);
        createElement("Panel", {
          id: "BossIcon"
        }, _el$74);
        const _el$80 = createElement("Label", {
          id: "NameLabel",
          get text() {
            return '#' + Entities.GetUnitName(getter.entid());
          }
        }, _el$74);
        createElement("Label", {
          id: "HpLabel",
          text: "<span class='HpCur'>{s:cur_hp}</span> / <span class='HpMax'>{s:max_hp}</span>",
          html: true
        }, _el$74);
        const _el$82 = createElement("Panel", {
          id: "BossDetial"
        }, _el$74),
        _el$83 = createElement("Panel", {
          "class": "AttributeDetial"
        }, _el$82);
        createElement("Panel", {
          id: "AtkIcon",
          "class": "Icon"
        }, _el$83);
        const _el$85 = createElement("Label", {
          id: "AtkLabel",
          "class": "AttributeLabel",
          get text() {
            return AttributeKind$1.Atk.Get(getter.entid());
          }
        }, _el$83),
        _el$86 = createElement("Panel", {
          "class": "AttributeDetial"
        }, _el$82);
        createElement("Panel", {
          id: "ArmorIcon",
          "class": "Icon"
        }, _el$86);
        const _el$88 = createElement("Label", {
          id: "ArmorLabel",
          "class": "AttributeLabel",
          get text() {
            return AttributeKind$1.Atk.Get(getter.entid());
          }
        }, _el$86);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$74) : ref = _el$74;
      setProp(_el$74, "onload", p => {
        Timer(() => {
          p.AddClass('Show');
        }, 0.1, undefined, 'UnitBigBar.onload');
      });
      effect(_p$ => {
        const _v$16 = '#' + Entities.GetUnitName(getter.entid()),
          _v$17 = AttributeKind$1.Atk.Get(getter.entid()),
          _v$18 = AttributeKind$1.Atk.Get(getter.entid());
        _v$16 !== _p$._v$16 && (_p$._v$16 = setProp(_el$80, "text", _v$16, _p$._v$16));
        _v$17 !== _p$._v$17 && (_p$._v$17 = setProp(_el$85, "text", _v$17, _p$._v$17));
        _v$18 !== _p$._v$18 && (_p$._v$18 = setProp(_el$88, "text", _v$18, _p$._v$18));
        return _p$;
      }, {
        _v$16: undefined,
        _v$17: undefined,
        _v$18: undefined
      });
      return _el$74;
    })();
  }
  function MoltenHeat() {
    var _a, _b, _c, _d, _e, _f;
    const [getMoltenData] = useNetEventTable(t => t, 'molten_data', () => getter_iLocalPlayer());
    return (() => {
      const _el$89 = createElement("Panel", {
          id: "MoltenHeat",
          get ["class"]() {
            return classNames("MoltenHeat", {
              Show: getMoltenData() != undefined
            });
          }
        }, null);
        createElement("Panel", {
          "class": "Header"
        }, _el$89);
        const _el$91 = createElement("Panel", {
          "class": "Body"
        }, _el$89),
        _el$94 = createElement("Panel", {
          "class": 'Content',
          onmouseout: HideTooltip
        }, _el$91),
        _el$95 = createElement("Label", {
          "class": "Title",
          get text() {
            return `${(_f = getMoltenData()) === null || _f === void 0 ? void 0 : _f.count}`;
          }
        }, _el$94);
      insert(_el$91, createComponent(Yzy_ProgressBar, {
        get value() {
          return (_a = getMoltenData()) === null || _a === void 0 ? void 0 : _a.current;
        },
        get max() {
          return (_b = getMoltenData()) === null || _b === void 0 ? void 0 : _b.max;
        },
        "class": "HeatBar",
        onmouseover: p => {
          ShowTooltip(p, 'common_detail_tooltip', {
            'sTitle': '#HeatVal',
            'sContext': '#HeatValDesc'
          });
        },
        onmouseout: HideTooltip,
        get children() {
          return [(() => {
            const _el$92 = createElement("Label", {
              "class": "LevelValue",
              get text() {
                return `${(_c = getMoltenData()) === null || _c === void 0 ? void 0 : _c.current}/${(_d = getMoltenData()) === null || _d === void 0 ? void 0 : _d.max}`;
              }
            }, null);
            effect(_$p => setProp(_el$92, "text", `${(_c = getMoltenData()) === null || _c === void 0 ? void 0 : _c.current}/${(_d = getMoltenData()) === null || _d === void 0 ? void 0 : _d.max}`, _$p));
            return _el$92;
          })(), (() => {
            const _el$93 = createElement("Label", {
              "class": "PreSecond",
              get text() {
                return `${(((_e = getMoltenData()) === null || _e === void 0 ? void 0 : _e.heat_per_second) || 0).toFixed(1)}/s`;
              }
            }, null);
            effect(_$p => setProp(_el$93, "text", `${(((_e = getMoltenData()) === null || _e === void 0 ? void 0 : _e.heat_per_second) || 0).toFixed(1)}/s`, _$p));
            return _el$93;
          })()];
        }
      }), _el$94);
      setProp(_el$94, "onmouseover", p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': '#MoltenVal',
          'sContext': '#MoltenValDesc'
        });
      });
      setProp(_el$94, "onmouseout", HideTooltip);
      effect(_p$ => {
        const _v$19 = classNames("MoltenHeat", {
            Show: getMoltenData() != undefined
          }),
          _v$20 = `${(_f = getMoltenData()) === null || _f === void 0 ? void 0 : _f.count}`;
        _v$19 !== _p$._v$19 && (_p$._v$19 = setProp(_el$89, "class", _v$19, _p$._v$19));
        _v$20 !== _p$._v$20 && (_p$._v$20 = setProp(_el$95, "text", _v$20, _p$._v$20));
        return _p$;
      }, {
        _v$19: undefined,
        _v$20: undefined
      });
      return _el$89;
    })();
  }

  const [getSettingData] = useNetEventTable(t => t, 'setting_data', 'data');
  const [getPlm] = useDiyPolymer(getter_iSelectUnit, 'game_item');
  const getSlot2Item = createMemo(() => {
    var _a, _b;
    return (_b = (_a = getPlm()) === null || _a === void 0 ? void 0 : _a.data) !== null && _b !== void 0 ? _b : {
      0: -1,
      1: -1,
      2: -1,
      3: -1,
      4: -1,
      5: -1
    };
  });
  const getLowerHudUnitId = createMemo(() => {
    if (Entities.GetUnitName(getter_iSelectUnit()) == 'npc_archive' || Entities.GetUnitName(getter_iSelectUnit()) == 'npc_raid_challenge') {
      return Players.GetPlayerHeroEntityIndex(getter_iLocalPlayer());
    }
    return getter_iSelectUnit();
  });
  const [getShowArchiveChallenge, setShowArchiveChallenge] = createSignal(false);
  const [getShowRaidChallenge, setShowRaidChallenge] = createSignal(false);
  createEffect(() => {
    if (Entities.GetUnitName(getter_iSelectUnit()) == 'npc_archive') {
      Players.PlayerPortraitClicked(getter_iLocalPlayer(), false, false);
      setShowArchiveChallenge(true);
    } else if (Entities.GetUnitName(getter_iSelectUnit()) == 'npc_raid_challenge') {
      Players.PlayerPortraitClicked(getter_iLocalPlayer(), false, false);
      setShowRaidChallenge(true);
    }
    if (getGameResult() != 2) {
      setShowArchiveChallenge(false);
      setShowRaidChallenge(false);
    }
  });
  function LowerHud() {
    const [getHeroName] = useNetEventTable(t => t, () => 'hero_' + getLowerHudUnitId(), 'skin_name');
    const getUnitName = createMemo(() => {
      var _a, _b;
      if (Entities.IsRealHero(getLowerHudUnitId())) {
        return '#' + ((_b = (_a = CustomHeroesKv[getHeroName()]) === null || _a === void 0 ? void 0 : _a['id']) !== null && _b !== void 0 ? _b : getHeroName());
      }
      return $.Localize('#' + Entities.GetUnitName(getLowerHudUnitId()));
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "LowerHud",
          hittest: false
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$2);
        const _el$4 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$2),
        _el$5 = createElement("Panel", {
          id: "UnitName",
          hittest: false
        }, _el$);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$5);
        const _el$7 = createElement("Label", {
          "class": "Label",
          get text() {
            return getUnitName();
          }
        }, _el$5),
        _el$8 = createElement("Panel", {
          id: "BuffBox",
          hittest: false
        }, _el$),
        _el$9 = createElement("GenericPanel", {
          type: "DOTABuffList",
          id: "buffs",
          showdebuffs: "true"
        }, _el$8);
      insert(_el$4, createComponent(PortraitHudAndAttribute, {
        getEntID: getLowerHudUnitId
      }), null);
      insert(_el$4, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(getLowerHudUnitId());
        },
        get children() {
          return createComponent(TalentPanel, {
            getEntID: getLowerHudUnitId
          });
        }
      }), null);
      insert(_el$4, createComponent(HealthManaAndAbilityList, {
        getEntID: getLowerHudUnitId
      }), null);
      setProp(_el$9, "style", {
        align: 'left top',
        flowChildren: "right-wrap",
        uiScale: '75%'
      });
      insert(_el$, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(getLowerHudUnitId());
        },
        get children() {
          return [createComponent(CustomXp, {
            getEntID: getLowerHudUnitId
          }), createComponent(OperateBox, {
            getEntID: getLowerHudUnitId
          })];
        }
      }), null);
      insert(_el$, createComponent(OperateBox1, {}), null);
      insert(_el$, createComponent(ArchiveChallenge, {}), null);
      insert(_el$, createComponent(RaidChallenge, {}), null);
      effect(_p$ => {
        const _v$ = {
            Show: !['npc_tower_box'].includes(Entities.GetUnitName(getLowerHudUnitId()))
          },
          _v$2 = getUnitName();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "classList", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$7, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }
  function PortraitHudAndAttribute(props) {
    const [getParticleID, setParticleID] = createSignal(-1);
    return (() => {
      const _el$0 = createElement("Panel", {
          id: "PortraitHudAndAttribute",
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$0);
        const _el$10 = createElement("Panel", {
          "class": "Portrait"
        }, _el$0);
      insert(_el$10, createComponent(PortraitHud, {
        get getEntID() {
          return props.getEntID;
        }
      }));
      insert(_el$0, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(props.getEntID());
        },
        get children() {
          const _el$11 = createElement("Panel", {
            id: "TootipTrigger"
          }, null);
          setProp(_el$11, "onmouseover", p => {
            ShowTooltip(p, 'attribute_tooltip', {
              iEntID: props.getEntID()
            });
            const fRange = AttributeKind$1.AtkRange.Get(props.getEntID());
            const iParticleID = Particles.CreateParticle("particles/ui_mouseactions/range_display.vpcf", ParticleAttachment_t.PATTACH_ABSORIGIN_FOLLOW, props.getEntID());
            Particles.SetParticleControl(iParticleID, 1, [fRange, fRange, fRange]);
            setParticleID(iParticleID);
          });
          setProp(_el$11, "onmouseout", () => {
            HideTooltip();
            if (getParticleID() != -1) {
              Particles.DestroyParticleEffect(getParticleID(), true);
              setParticleID(-1);
            }
          });
          return _el$11;
        }
      }), null);
      insert(_el$0, createComponent(AttributeHud, {
        get getEntID() {
          return props.getEntID;
        }
      }), null);
      return _el$0;
    })();
  }
  function PortraitHud(props) {
    var _a, _b, _c, _d, _e;
    const [getHeroName] = useNetEventTable(t => {
      if (props.getEntID() && Entities.IsRealHero(props.getEntID())) {
        return t !== null && t !== void 0 ? t : 'npc_dota_hero_base';
      }
      return undefined;
    }, () => 'hero_' + props.getEntID(), 'skin_name');
    return (() => {
      const _el$12 = createElement("Panel", {
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG1",
          hittest: false
        }, _el$12);
        createElement("Panel", {
          "class": "BG2",
          hittest: false
        }, _el$12);
        const _el$15 = createElement("Panel", {
          "class": "Hero3DPanel",
          hittest: false
        }, _el$12);
      setProp(_el$12, "className", "PortraitHud");
      insert(_el$15, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(props.getEntID());
        },
        get children() {
          const _el$16 = createElement("Panel", {
            "class": "RealHero",
            hittest: false
          }, null);
          insert(_el$16, createComponent(WearableHero, {
            get tItems() {
              return (_c = (_b = WearableCfgByKv(CustomHeroesKv[getHeroName()])) === null || _b === void 0 ? void 0 : _b.items) !== null && _c !== void 0 ? _c : [];
            },
            "suppress-intro-effects": true,
            get zoom() {
              return (_e = {
                'npc_dota_hero_base_12': 88,
                'npc_dota_hero_base_14': 88
              }[(_d = getHeroName()) !== null && _d !== void 0 ? _d : '']) !== null && _e !== void 0 ? _e : 105;
            }
          }));
          effect(_$p => setProp(_el$16, "classList", {
            [(_a = getHeroName()) !== null && _a !== void 0 ? _a : '']: true
          }, _$p));
          return _el$16;
        }
      }), null);
      insert(_el$15, createComponent(Show, {
        get when() {
          return !Entities.IsRealHero(props.getEntID());
        },
        get children() {
          const _el$17 = createElement("Panel", {
            "class": "NormalUnit",
            hittest: false
          }, null);
          insert(_el$17, () => {
            const sUnitName = Entities.GetUnitName(props.getEntID());
            return (() => {
              const _el$18 = createElement("DOTAScenePanel", {
                "class": "ScenePanel",
                camera: "0 0 0",
                unit: sUnitName,
                allowrotation: false,
                hittest: true,
                particleonly: false,
                renderdeferred: false,
                drawbackground: false,
                pitchmin: 90,
                pitchmax: 90
              }, null);
              setProp(_el$18, "unit", sUnitName);
              return _el$18;
            })();
          });
          return _el$17;
        }
      }), null);
      return _el$12;
    })();
  }
  function AttributeHud(props) {
    const getter_bAltDown = useAltDown();
    const [getAttribute, setAttribute] = createSignal([]);
    createEffect(() => {
      const iTimeID = GameTimer(() => {
        const t = [];
        (Entities.IsRealHero(props.getEntID()) ? [AttributeKind$1.Atk, AttributeKind$1.Armor, AttributeKind$1.MoveSpd, AttributeKind$1.Strength, AttributeKind$1.Agility, AttributeKind$1.Intellect] : [AttributeKind$1.Atk, AttributeKind$1.Armor]).forEach((hAttribute, i) => {
          if (AttributeKind$1.Armor == hAttribute && AttributeKind$1.Armor.OVERRIDE.Get(props.getEntID()) != -1) {
            t.push({
              'name': hAttribute.name,
              'base': AttributeKind$1.Armor.OVERRIDE.Get(props.getEntID()),
              'bonus': 0
            });
            return;
          }
          const fBase = hAttribute.BASE.Get(props.getEntID());
          const fTotalVal = hAttribute.Get(props.getEntID());
          const fBonus = fTotalVal - fBase;
          const sID = hAttribute.name;
          t.push({
            'name': sID,
            'base': getter_bAltDown() ? fTotalVal : fBase,
            'bonus': getter_bAltDown() ? 0 : fBonus
          });
        });
        setAttribute(t);
        return 0.2;
      }, -1, undefined, 'LowerHud.Attribute');
      onCleanup(() => {
        StopTimer(iTimeID);
      });
    });
    return (() => {
      const _el$19 = createElement("Panel", {
          id: "Attribute",
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$19);
        const _el$21 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$19);
      insert(_el$21, createComponent(Index, {
        get each() {
          return getAttribute();
        },
        children: (getVal, i) => {
          return (() => {
            const _el$22 = createElement("Panel", {
                get ["class"]() {
                  return classNames('AttributeRow', getVal().name);
                },
                hittest: false
              }, null);
              createElement("Panel", {
                "class": "BG",
                hittest: false
              }, _el$22);
              const _el$24 = createElement("Panel", {
                "class": "Content",
                hittest: false
              }, _el$22),
              _el$25 = createElement("Image", {
                get src() {
                  return `file://{images}/custom_game/lower_hud/${getVal().name}.png`;
                },
                hittest: false
              }, _el$24),
              _el$26 = createElement("Label", {
                id: "Base",
                get text() {
                  return FormatNumber(getVal().base);
                },
                html: true,
                hittest: false
              }, _el$24);
            setProp(_el$25, "className", "Icon");
            insert(_el$24, createComponent(Show, {
              get when() {
                return getVal().bonus != 0;
              },
              get children() {
                const _el$27 = createElement("Label", {
                  id: "Bonus",
                  get text() {
                    return memo(() => getVal().bonus > 0)() ? GreenText('+' + FormatNumber(getVal().bonus)) : RedText(FormatNumber(getVal().bonus));
                  },
                  html: true,
                  hittest: false
                }, null);
                effect(_$p => setProp(_el$27, "text", memo(() => getVal().bonus > 0)() ? GreenText('+' + FormatNumber(getVal().bonus)) : RedText(FormatNumber(getVal().bonus)), _$p));
                return _el$27;
              }
            }), null);
            effect(_p$ => {
              const _v$3 = classNames('AttributeRow', getVal().name),
                _v$4 = `file://{images}/custom_game/lower_hud/${getVal().name}.png`,
                _v$5 = FormatNumber(getVal().base);
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$22, "class", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$25, "src", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$26, "text", _v$5, _p$._v$5));
              return _p$;
            }, {
              _v$3: undefined,
              _v$4: undefined,
              _v$5: undefined
            });
            return _el$22;
          })();
        }
      }));
      return _el$19;
    })();
  }
  function CustomXp(props) {
    const [getHeroExp] = useNetEventTable(t => t, () => 'hero_' + props.getEntID(), 'exp');
    const getLvl = createMemo(() => {
      var _a;
      return ((_a = getHeroExp()) === null || _a === void 0 ? void 0 : _a.lvl) || 0;
    });
    const getCur = createMemo(() => {
      var _a;
      return ((_a = getHeroExp()) === null || _a === void 0 ? void 0 : _a.cur) || 0;
    });
    const getLvlUp = createMemo(() => {
      var _a;
      return ((_a = getHeroExp()) === null || _a === void 0 ? void 0 : _a.lvlup) || 1;
    });
    const getMaxLvl = createMemo(() => {
      var _a;
      return ((_a = getHeroExp()) === null || _a === void 0 ? void 0 : _a.max_lvl) || 0;
    });
    return (() => {
      const _el$28 = createElement("Panel", {
          id: "CustomXp",
          onmouseout: HideTooltip
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$28);
        createElement("Panel", {
          "class": "BG1"
        }, _el$28);
        const _el$31 = createElement("Panel", {
          id: "CustomXpBorder",
          hittest: false,
          get style() {
            return {
              clip: `radial( 50.0% 50.0%, 0.0deg, ${360 * (getLvlUp() == 0 ? 1 : Number((getCur() / getLvlUp()).toFixed(2)))}deg)`
            };
          }
        }, _el$28),
        _el$32 = createElement("Label", {
          id: "LevelLabel",
          get text() {
            return memo(() => getLvl() < getMaxLvl())() ? getLvl() : 'Max';
          }
        }, _el$28);
      setProp(_el$28, "onmouseover", p => {
        var _a;
        ShowTooltip(p, 'common_detail_tooltip', {
          'sContext': ReplaceTextVariable($.Localize('#CustomXp_Description'), {
            'val': getCur(),
            'val1': getLvlUp(),
            'val2': FormatNumber(AttributeKind$1.ExpPct.Get(props.getEntID()), 1) + ((_a = PctUnitAttributes[AttributeKind$1.ExpPct.name]) !== null && _a !== void 0 ? _a : ''),
            'val3': FormatNumber(AttributeKind$1.PerSecExp.Get(props.getEntID()), 1)
          })
        });
      });
      setProp(_el$28, "onmouseout", HideTooltip);
      effect(_p$ => {
        const _v$6 = {
            clip: `radial( 50.0% 50.0%, 0.0deg, ${360 * (getLvlUp() == 0 ? 1 : Number((getCur() / getLvlUp()).toFixed(2)))}deg)`
          },
          _v$7 = memo(() => getLvl() < getMaxLvl())() ? getLvl() : 'Max';
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$31, "style", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$32, "text", _v$7, _p$._v$7));
        return _p$;
      }, {
        _v$6: undefined,
        _v$7: undefined
      });
      return _el$28;
    })();
  }
  function HealthManaAndAbilityList(props) {
    return (() => {
      const _el$33 = createElement("Panel", {
        id: "HealthManaAndAbilityList",
        hittest: false
      }, null);
      insert(_el$33, createComponent(AbilityList, {
        get getEntID() {
          return props.getEntID;
        }
      }), null);
      insert(_el$33, createComponent(HealthMana, {
        get getEntID() {
          return props.getEntID;
        }
      }), null);
      return _el$33;
    })();
  }
  function HealthMana(props) {
    let pHealthLabelCustom;
    let pHealthRegenLabel;
    const id = Timer(() => {
      var _a;
      const iEntID = props.getEntID();
      if (pHealthLabelCustom) {
        const hp = Entities.GetHealth(iEntID) < 0.00001 ? 0 : FormatNumber(Math.ceil(Entities.GetHealth(iEntID)));
        pHealthLabelCustom.text = hp + " / " + FormatNumber(Math.ceil(Entities.GetMaxHealth(iEntID)));
      }
      if (pHealthRegenLabel) {
        let fHPRegen = (_a = AttributeKind$1.HpRegen.Get(iEntID)) !== null && _a !== void 0 ? _a : 0;
        pHealthRegenLabel.text = (fHPRegen >= 0 ? '+' : '-') + FormatNumber(fHPRegen, 1);
      }
      return 0.1;
    }, 0, undefined, 'LowerHud.HealthMana');
    onCleanup(() => {
      StopTimer(id);
    });
    return (() => {
      const _el$34 = createElement("Panel", {
          "class": "HealthMana"
        }, null),
        _el$35 = createElement("GenericPanel", {
          id: "health_mana",
          type: "DOTAHealthMana",
          hittest: false
        }, _el$34);
      setProp(_el$35, "style", {
        width: "100%"
      });
      setProp(_el$35, "onload", p => {
        let panel = p.FindChild("HealthManaContainer");
        if (panel) {
          panel.style.margin = "0px";
        }
        const pHealthContainer = p.FindChildTraverse("HealthContainer");
        if (pHealthContainer) {
          pHealthContainer.style.height = '20px';
          pHealthContainer.style.margin = '0px 0px 5px 0px';
          pHealthContainer.style.boxShadow = '#000c 0px 1px 2px 1px';
          if (pHealthContainer.FindChildTraverse("HealthProgress")) {
            pHealthContainer.FindChildTraverse("HealthProgress").style.margin = '0px';
          }
          for (let i = pHealthContainer.GetChildCount() - 1; i >= 0; --i) {
            const p = pHealthContainer.GetChild(i);
            if (p && p.id == "HealthLabel") {
              if (p.BHasClass('HealthLabelCustom')) {
                pHealthLabelCustom = p;
              } else {
                p.visible = false;
              }
            }
          }
          if (!pHealthLabelCustom) {
            pHealthLabelCustom = $.CreatePanel('Label', pHealthContainer, 'HealthLabel', {
              class: 'MonoNumbersFont HealthLabelCustom',
              hittest: "false"
            });
            pHealthLabelCustom.style.margin = '2px 0px 0px 0px';
            pHealthLabelCustom.style.textShadow = '0px 0px 0px 3 #000';
          }
        }
        pHealthRegenLabel = p.FindChildTraverse("HealthRegenLabel");
        const pManaContainer = p.FindChildTraverse("ManaContainer");
        if (pManaContainer) {
          pManaContainer.style.height = '20px';
          pManaContainer.style.margin = '0px 0px 0px 0px';
          pManaContainer.style.boxShadow = '#000c 0px 1px 2px 1px';
          if (pManaContainer.FindChildTraverse("ManaLabel")) {
            pManaContainer.FindChildTraverse("ManaLabel").style.margin = '0px';
            pManaContainer.FindChildTraverse("ManaLabel").style.textShadow = '0px 0px 0px 3 #000';
          }
        }
        pHealthRegenLabel = p.FindChildTraverse("HealthRegenLabel");
      });
      return _el$34;
    })();
  }
  function AbilityList(props) {
    let ref;
    const [getAblts, setAblts] = createSignal([]);
    {
      const id = Timer(() => {
        const iEntID = props.getEntID();
        const tAblts1 = getAblts();
        const tAblts2 = [];
        const tAblts3 = [];
        for (let i = 0; i < Entities.GetAbilityCount(iEntID); ++i) {
          let iAblt = Entities.GetAbility(iEntID, i);
          if (iAblt != -1 && Abilities.GetAbilityName(iAblt) != "" && !Abilities.IsHidden(iAblt)) {
            if (Abilities.GetAbilityName(iAblt) == 'shift' || Abilities.GetAbilityName(iAblt) == 'tpscroll') {
              let t = {
                'ablt_entid': iAblt,
                'ablt_name': Abilities.GetAbilityName(iAblt)
              };
              tAblts3.push(t);
            } else {
              tAblts2.push({
                'ablt_entid': iAblt,
                'ablt_name': Abilities.GetAbilityName(iAblt)
              });
            }
          }
        }
        for (const v of tAblts3) {
          tAblts2.push({
            'ablt_entid': v.ablt_entid,
            'ablt_name': v.ablt_name,
            'ablt_key': v.ablt_key
          });
        }
        if (tAblts2.length == tAblts1.length) {
          for (let i = 0; i < tAblts2.length; ++i) {
            if (tAblts2[i].ablt_entid != tAblts1[i].ablt_entid) {
              setAblts(tAblts2);
              break;
            }
          }
        } else {
          setAblts(tAblts2);
        }
        return 0;
      }, -1, undefined, 'LowerHud.AbilityList');
      onCleanup(() => {
        StopTimer(id);
      });
    }
    return (() => {
      const _el$36 = createElement("Panel", {
        id: "AbilityList",
        "class": "AbilityList",
        hittest: false
      }, null);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$36) : ref = _el$36;
      insert(_el$36, () => getAblts().map(t => {
        return createComponent(AbilityPanel$1, {
          get iAbltID() {
            return t.ablt_entid;
          },
          get sAbltName() {
            return t.ablt_name;
          },
          bQuickCast: true,
          get sHotKey() {
            return t.ablt_key;
          }
        });
      }));
      return _el$36;
    })();
  }
  function TalentPanel(props) {
    var _a;
    const [getTalent] = useDiyPolymer(getter_iSelectUnit, 'talent');
    const getTalentData = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getTalent()) === null || _a === void 0 ? void 0 : _a.data) === null || _b === void 0 ? void 0 : _b.Talent;
    });
    const getName = () => {
      var _a;
      return (_a = getTalentData()) === null || _a === void 0 ? void 0 : _a.name;
    };
    const [getAbility] = useDiyPolymer(getter_iSelectUnit, () => getName());
    const getAbilityData = createMemo(() => {
      var _a;
      return (_a = getAbility()) === null || _a === void 0 ? void 0 : _a.data;
    });
    const getKv = () => AbilitiesKv[getName()];
    const getInterval = () => {
      var _a;
      return (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityCooldown'];
    };
    const getEndTime = () => {
      var _a;
      return (_a = getAbilityData()) === null || _a === void 0 ? void 0 : _a.fEndTime;
    };
    return (() => {
      const _el$37 = createElement("Panel", {
          id: "TalentPanel",
          get ["class"]() {
            return classNames({
              "Hidden": getName() == undefined
            });
          },
          onmouseout: HideTooltip
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$37);
        const _el$39 = createElement("Panel", {
          "class": "Body"
        }, _el$37);
        createElement("Panel", {
          id: "AbilityBevel",
          hittest: false
        }, _el$39);
        createElement("Panel", {
          id: "PassiveAbilityBorder",
          hittest: false
        }, _el$39);
        createElement("Panel", {
          id: "AbilityBorder",
          hittest: false
        }, _el$39);
        const _el$43 = createElement("Image", {
          "class": "Icon",
          get src() {
            return `file://{images}/custom_game/talent/${(_a = getName()) !== null && _a !== void 0 ? _a : 'empty'}.png`;
          }
        }, _el$39);
      setProp(_el$37, "onmouseover", p => {
        if (getName() != undefined) {
          ShowTooltip(p, 'talent_tooltip', {
            'sTalentName': getName(),
            'iEntID': props.getEntID()
          });
          return;
        }
      });
      setProp(_el$37, "onmouseout", HideTooltip);
      insert(_el$39, createComponent(Show, {
        get when() {
          return memo(() => getEndTime() != undefined)() && getEndTime() > Game.GetGameTime();
        },
        get children() {
          return createComponent(CooldownPanel, {
            fEnd: getEndTime,
            get fCD() {
              return getInterval();
            },
            bShine: true,
            hittest: false
          });
        }
      }), null);
      effect(_p$ => {
        const _v$8 = classNames({
            "Hidden": getName() == undefined
          }),
          _v$9 = `file://{images}/custom_game/talent/${(_a = getName()) !== null && _a !== void 0 ? _a : 'empty'}.png`;
        _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$37, "class", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$43, "src", _v$9, _p$._v$9));
        return _p$;
      }, {
        _v$8: undefined,
        _v$9: undefined
      });
      return _el$37;
    })();
  }
  function GameItemBox(props) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
    return (() => {
      const _el$44 = createElement("Panel", {
          id: "GameItemBox"
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$44);
        const _el$46 = createElement("Panel", {}, _el$44),
        _el$47 = createElement("Panel", {
          id: "Line1",
          "class": "ItemLine"
        }, _el$46),
        _el$48 = createElement("Panel", {
          id: "Line2",
          "class": "ItemLine"
        }, _el$46);
      setProp(_el$46, "className", "Body");
      insert(_el$47, createComponent(GameItemPanel, {
        id: "ItemSlot_0",
        ItemID: () => getSlot2Item()['0'],
        iSlot: 0,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_1];
        }
      }), null);
      insert(_el$47, createComponent(GameItemPanel, {
        id: "ItemSlot_1",
        ItemID: () => getSlot2Item()['1'],
        iSlot: 1,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_d = (_c = getSettingData()) === null || _c === void 0 ? void 0 : _c.SetKeyVal) === null || _d === void 0 ? void 0 : _d.key_2];
        }
      }), null);
      insert(_el$47, createComponent(GameItemPanel, {
        id: "ItemSlot_2",
        ItemID: () => getSlot2Item()['2'],
        iSlot: 2,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_f = (_e = getSettingData()) === null || _e === void 0 ? void 0 : _e.SetKeyVal) === null || _f === void 0 ? void 0 : _f.key_3];
        }
      }), null);
      insert(_el$48, createComponent(GameItemPanel, {
        id: "ItemSlot_3",
        ItemID: () => getSlot2Item()['3'],
        iSlot: 3,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_h = (_g = getSettingData()) === null || _g === void 0 ? void 0 : _g.SetKeyVal) === null || _h === void 0 ? void 0 : _h.key_4];
        }
      }), null);
      insert(_el$48, createComponent(GameItemPanel, {
        id: "ItemSlot_4",
        ItemID: () => getSlot2Item()['4'],
        iSlot: 4,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_k = (_j = getSettingData()) === null || _j === void 0 ? void 0 : _j.SetKeyVal) === null || _k === void 0 ? void 0 : _k.key_5];
        }
      }), null);
      insert(_el$48, createComponent(GameItemPanel, {
        id: "ItemSlot_5",
        ItemID: () => getSlot2Item()['5'],
        iSlot: 5,
        get getEntID() {
          return props.getEntID;
        },
        get key() {
          return Key2Command[(_m = (_l = getSettingData()) === null || _l === void 0 ? void 0 : _l.SetKeyVal) === null || _m === void 0 ? void 0 : _m.key_6];
        }
      }), null);
      return _el$44;
    })();
  }
  function GameItemPanel(props) {
    const [getItemData] = useNetEventTable(t => t, 'gameplay_item', () => props.ItemID());
    return (() => {
      const _el$49 = createElement("Panel", {
          get id() {
            return props.id;
          },
          "class": "GameItemPanel PackBox",
          onmouseout: HideTooltip
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$49);
        const _el$51 = createElement("Panel", {
          get ["class"]() {
            return classNames("Body");
          },
          hittest: false
        }, _el$49);
      setProp(_el$49, "onload", p => {
        RegDraggleDrop(p, 'GameItemSlot', {
          slot: props.iSlot
        }, {
          'onDragEnter': () => {
            p.AddClass('Dragging');
          },
          'onDragLeave': () => {
            p.RemoveClass('Dragging');
          },
          'onDragDrop': (_, tDragInfo) => {
            var _a, _b;
            if (CheckDragInfo(tDragInfo, 'GameItem')) {
              if (((_a = tDragInfo === null || tDragInfo === void 0 ? void 0 : tDragInfo.params) === null || _a === void 0 ? void 0 : _a.slot) != undefined) {
                GameEvents.SendCustomGameEventToServer("GameItem_Move", {
                  slot: (_b = tDragInfo === null || tDragInfo === void 0 ? void 0 : tDragInfo.params) === null || _b === void 0 ? void 0 : _b.slot,
                  target_slot: props.iSlot,
                  entid: props.getEntID()
                });
              }
            } else if (CheckDragInfo(tDragInfo, 'PackItem_game_item')) {
              GameEvents.SendCustomGameEventToServer("GameItem_AddByPack", {
                slot: props.iSlot,
                entid: props.getEntID(),
                'boxid': tDragInfo.params.boxid
              });
            }
          }
        });
      });
      setProp(_el$49, "onmouseover", p => {});
      setProp(_el$49, "onmouseout", HideTooltip);
      insert(_el$51, createComponent(Show, {
        get when() {
          return getItemData() != undefined;
        },
        get children() {
          const _el$52 = createElement("Panel", {
            "class": "GameItemRow"
          }, null);
          insert(_el$52, createComponent(GameplayItem, {
            id: "GameItemImage",
            item: getItemData,
            get key() {
              return props.key;
            },
            draggable: true,
            onload: p => {
              RegDraggle(p, 'GameItem', () => ({
                'slot': props.iSlot,
                'item': getItemData()
              }), () => createComponent(GameplayItem, {
                id: "DragGameItem",
                item: getItemData
              }), {
                'onDragStart': () => {
                  var _a;
                  return ((_a = getItemData()) === null || _a === void 0 ? void 0 : _a.pid) == Players.GetLocalPlayer();
                },
                'onDragEnter': (pDrag, tDragInfo, tDropInfo) => {
                  if (CheckDropInfo(tDropInfo, 'Floor')) {
                    Timer(() => {
                      for (const t of GameUI.FindScreenEntities(GameUI.GetCursorPosition())) {
                        if (t.entityIndex != tDragInfo.params.item.entid) {
                          if (Player_EntityToID(t.entityIndex) == Players.GetLocalPlayer()) {
                            ShowDragTip('#DragTip_Drop_GameItemSlot');
                            return 0;
                          }
                        }
                      }
                      ShowDragTip('#DragTip_Drop_Floor');
                      return 0;
                    }, 0, 'drag', 'LowerHud.GameItemPanel.drag');
                  }
                },
                'onDragLeave': (pDrag, tDragInfo, tDropInfo) => {
                  if (CheckDropInfo(tDropInfo, 'Floor')) {
                    StopTimer('drag');
                  }
                },
                'onDragDrop': (_, __, tDropInfo) => {
                  var _a;
                  if (tDropInfo.type == 'Floor') {
                    GameEvents.SendCustomGameEventToServer("GameItem_DropFloor", {
                      slot: props.iSlot,
                      pos: (_a = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition())) !== null && _a !== void 0 ? _a : [0, 0, 0],
                      entid: props.getEntID()
                    });
                  }
                }
              });
            },
            onmouseover: p => {
              var _a, _b;
              ShowTooltip(p, 'game_item_tooltip', {
                'sItemName': ((_a = getItemData()) === null || _a === void 0 ? void 0 : _a.name) || '',
                'uid': (_b = getItemData()) === null || _b === void 0 ? void 0 : _b.uid,
                'iEntID': props.getEntID()
              });
            },
            onmouseout: () => {
              HideTooltip();
            },
            onactivate_db: p => {
              var _a;
              if (getItemData().type == 'game_item') {
                GameEvents.SendCustomGameEventToServer('ON_CLICK_IN_GAME_ITEM', {
                  polymer_id: ((_a = getItemData()) === null || _a === void 0 ? void 0 : _a.polymer_id) || 0,
                  slot: props.iSlot,
                  entid: props.getEntID()
                });
                return;
              }
              function GetEmptyPackBoxInPlayer() {
                var _a, _b, _c, _d, _e, _f;
                const iRow = (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackRowPlayer']) !== null && _b !== void 0 ? _b : 0;
                const iCol = (_d = (_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['PackCol']) !== null && _d !== void 0 ? _d : 0;
                const iMax = iRow * iCol;
                for (let i = 1; i <= iMax; i++) {
                  if (((_f = (_e = NetEventData.GetTableValue('pack', `player_${getter_iLocalPlayer()}`)) === null || _e === void 0 ? void 0 : _e[i]) === null || _f === void 0 ? void 0 : _f.item_uid) == undefined) {
                    return i;
                  }
                }
              }
              const box_id = GetEmptyPackBoxInPlayer();
              if (box_id) {
                GameEvents.SendCustomGameEventToServer("GameItem_ToPack", {
                  slot: props.iSlot,
                  entid: props.getEntID(),
                  'boxid': box_id
                });
              } else {
                ErrorMsg('dota_hud_error_pack_fulled');
              }
            },
            oncontextmenu: () => {
              function GetEmptyPackBoxInPlayer() {
                var _a, _b, _c, _d, _e, _f;
                const iRow = (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackRowPlayer']) !== null && _b !== void 0 ? _b : 0;
                const iCol = (_d = (_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['PackCol']) !== null && _d !== void 0 ? _d : 0;
                const iMax = iRow * iCol;
                for (let i = 1; i <= iMax; i++) {
                  if (((_f = (_e = NetEventData.GetTableValue('pack', `player_${getter_iLocalPlayer()}`)) === null || _e === void 0 ? void 0 : _e[i]) === null || _f === void 0 ? void 0 : _f.item_uid) == undefined) {
                    return i;
                  }
                }
              }
              const box_id = GetEmptyPackBoxInPlayer();
              if (box_id) {
                GameEvents.SendCustomGameEventToServer("GameItem_ToPack", {
                  slot: props.iSlot,
                  entid: props.getEntID(),
                  'boxid': box_id
                });
              } else {
                ErrorMsg('dota_hud_error_pack_fulled');
              }
            }
          }));
          return _el$52;
        }
      }));
      effect(_p$ => {
        const _v$0 = props.id,
          _v$1 = classNames("Body");
        _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$49, "id", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$51, "class", _v$1, _p$._v$1));
        return _p$;
      }, {
        _v$0: undefined,
        _v$1: undefined
      });
      return _el$49;
    })();
  }
  function OperateBox(props) {
    return (() => {
      const _el$53 = createElement("Panel", {
        id: "OperateBox",
        hittest: false
      }, null);
      insert(_el$53, createComponent(WeaponBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      insert(_el$53, createComponent(DevourBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      return _el$53;
    })();
  }
  function OperateBox1() {
    return (() => {
      const _el$54 = createElement("Panel", {
        id: "OperateBox1",
        get ["class"]() {
          return classNames({
            'Show': Entities.IsRealHero(getLowerHudUnitId())
          });
        },
        hittest: false
      }, null);
      insert(_el$54, createComponent(HeroSelectionBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      insert(_el$54, createComponent(RelicBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      insert(_el$54, createComponent(AbilityBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      insert(_el$54, createComponent(AdventureBtn, {
        getEntID: getLowerHudUnitId
      }), null);
      effect(_$p => setProp(_el$54, "class", classNames({
        'Show': Entities.IsRealHero(getLowerHudUnitId())
      }), _$p));
      return _el$54;
    })();
  }
  function HeroSelectionBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const [getHeroSelect] = useNetEventTable(t => t, 'hero', () => 'select_' + getter_iLocalPlayer());
    const [getHeroSelectCount] = useNetEventTable(t => t || 0, 'hero', () => 'select_count_' + getter_iLocalPlayer());
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_Z];
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_HERO_SELECTION_TOGGLE', () => {
        setOpen(!getOpen());
      });
      onCleanup(() => {
        EventManager.Unreg('ON_HERO_SELECTION_TOGGLE', id);
      });
    });
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/hero.png';
    };
    return createComponent(KeybindButton, {
      id: "HeroSelectionBtn",
      get ["class"]() {
        return classNames('OperateBtn', {
          'Active': getHeroSelectCount() > 0,
          'Show': getHeroSelectCount() > 0
        });
      },
      key: getKeybind,
      onactivate: () => {
        if (getHeroSelect() != undefined) {
          EventManager.Fire('ON_HERO_SELECTION_TOGGLE', {
            'open': !getOpen()
          });
          return;
        }
        if (getHeroSelectCount() <= 0) return ErrorMsg('error_not_transfer_count');
        GameEvents.SendCustomGameEventToServer('OnOpenHeroSelect', {});
        EventManager.Fire('ON_HERO_SELECTION_TOGGLE', {
          'open': true
        });
      },
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#HeroSelectionBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/hero.png",
          'sContext': $.Localize("#HeroSelectionBtnDes")
        });
      },
      onmouseout: HideTooltip,
      get children() {
        return [createElement("Panel", {
          "class": "BG"
        }, null), (() => {
          const _el$56 = createElement("Panel", {
              "class": "Body"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$56);
            const _el$58 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$56),
            _el$59 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$56),
            _el$60 = createElement("Label", {
              "class": "CountLabel",
              get text() {
                return getHeroSelectCount();
              }
            }, _el$56),
            _el$61 = createElement("Panel", {
              "class": "Name"
            }, _el$56);
            createElement("Label", {
              text: '#HeroSelectionBtn'
            }, _el$61);
          insert(_el$56, createComponent(Show, {
            get when() {
              return getHeroSelectCount() > 0;
            },
            get children() {
              const _el$63 = createElement("Panel", {
                  "class": "TogglePtc",
                  hittest: false
                }, null);
                createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleName: "particles/ui/hud/autocasting_square.vpcf",
                  cameraOrigin: "0 0 50",
                  lookAt: "0 0 0",
                  fov: 90
                }, _el$63);
              return _el$63;
            }
          }), null);
          effect(_p$ => {
            const _v$10 = getImage(),
              _v$11 = getKeybind(),
              _v$12 = getHeroSelectCount();
            _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$58, "src", _v$10, _p$._v$10));
            _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$59, "text", _v$11, _p$._v$11));
            _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$60, "text", _v$12, _p$._v$12));
            return _p$;
          }, {
            _v$10: undefined,
            _v$11: undefined,
            _v$12: undefined
          });
          return _el$56;
        })()];
      }
    });
  }
  function WeaponBtn(props) {
    const [getWeapon] = useDiyPolymer(getter_iSelectUnit, 'weapon');
    const getWeaponData = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getWeapon()) === null || _a === void 0 ? void 0 : _a.data) === null || _b === void 0 ? void 0 : _b.Weapon;
    });
    const getLevel = createMemo(() => {
      var _a;
      return (_a = getWeaponData()) === null || _a === void 0 ? void 0 : _a.level;
    });
    const getLevelUpGold = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getWeaponData()) === null || _a === void 0 ? void 0 : _a.gold) !== null && _b !== void 0 ? _b : 0;
    });
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_X];
    });
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/weapon.png';
    };
    return createComponent(KeybindButton, {
      id: "WeaponBtn",
      "class": "OperateBtn",
      key: getKeybind,
      onactivate: p => {
        var _a;
        if (((_a = CfgGetter_weapon_attribute()) === null || _a === void 0 ? void 0 : _a[getLevel() + 1]) == undefined) return ErrorMsg('error_max_level');
        if (GetRes("gold", getter_iLocalPlayer()) < getLevelUpGold()) return ErrorMsg('error_not_enough_gold');
        if (NetEventData.GetTableValue('level_up', 'select_' + getter_iLocalPlayer())) return ErrorMsg('error_weapon_selection');
        GameEvents.SendCustomGameEventToServer('OnWeaponLevelUp', {});
        ScreenPanel.CreateOnPanel({
          'pTarget': p,
          'content': () => (() => {
            const _el$72 = createElement("DOTAParticleScenePanel", {
              hittest: false,
              particleonly: false,
              drawbackground: true,
              rendershadows: true,
              particleName: "particles/ui/common/forge/forge.vpcf",
              cameraOrigin: "-50 -100 120",
              lookAt: "0 0 0",
              fov: 60
            }, null);
            setProp(_el$72, "style", {
              width: '200px',
              height: '200px'
            });
            return _el$72;
          })(),
          fInterval: 0.35,
          'onUpdate': () => {
            Game.EmitSound('DOTA_Item.HavocHammer.Cast');
          },
          fDuration: 0.5
        });
        Timer(() => {
          const tStyle = {
            1: {
              saturation: 0.1,
              brightness: 0.7
            },
            2: {
              hueRotation: '90deg'
            },
            3: {
              hueRotation: '170deg'
            },
            4: {
              hueRotation: '210deg'
            },
            5: {},
            6: {
              hueRotation: '325deg',
              washColor: '#f006'
            }
          }[getLevel() % 5];
          ScreenPanel.CreateOnPanel({
            'pTarget': p,
            'content': () => (() => {
              const _el$73 = createElement("Panel", {
                  hittest: false
                }, null),
                _el$74 = createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleonly: false,
                  drawbackground: true,
                  rendershadows: true,
                  particleName: "particles/ui/plus/ui_hud_relic_gem_gold_ambient.vpcf",
                  cameraOrigin: "0 0 300",
                  lookAt: "0 0 0",
                  fov: 60,
                  get style() {
                    return Object.assign({
                      width: '600px',
                      height: '600px'
                    }, tStyle);
                  }
                }, _el$73),
                _el$75 = createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleonly: false,
                  drawbackground: true,
                  rendershadows: true,
                  particleName: "particles/ui/plus/ui_hud_relic_burst_generic.vpcf",
                  cameraOrigin: "0 0 200",
                  lookAt: "0 0 0",
                  fov: 60,
                  get style() {
                    return Object.assign({
                      width: '600px',
                      height: '600px',
                      preTransformRotate2d: RandomInt(0, 360) + 'deg'
                    }, tStyle);
                  }
                }, _el$73);
              effect(_p$ => {
                const _v$16 = Object.assign({
                    width: '600px',
                    height: '600px'
                  }, tStyle),
                  _v$17 = Object.assign({
                    width: '600px',
                    height: '600px',
                    preTransformRotate2d: RandomInt(0, 360) + 'deg'
                  }, tStyle);
                _v$16 !== _p$._v$16 && (_p$._v$16 = setProp(_el$74, "style", _v$16, _p$._v$16));
                _v$17 !== _p$._v$17 && (_p$._v$17 = setProp(_el$75, "style", _v$17, _p$._v$17));
                return _p$;
              }, {
                _v$16: undefined,
                _v$17: undefined
              });
              return _el$73;
            })(),
            fInterval: 0.35,
            fDuration: 1
          });
        }, 0.2, 'Weapon.OnActivate.Particle');
        Timer(() => {
          ScreenPanel.CreateOnPanel({
            'pTarget': p,
            'content': () => (() => {
              const _el$76 = createElement("Panel", {
                hittest: false
              }, null);
              setProp(_el$76, "onload", p => {
                p.style.transform = 'translateX(50%) translateY(-50%)';
              });
              setProp(_el$76, "style", {
                width: '50px',
                height: '50px',
                backgroundColor: 'gradient( linear, 100% 0%, 0% 100%, from( #00000000 ), color-stop( 0.3, #00000000 ), color-stop( 0.45, #ffffffff ), color-stop( 0.55, #ffffffff ), color-stop( 0.7, #00000000 ), to( #00000000 ) )',
                transform: 'translateX(-50%) translateY(50%)',
                transitionDuration: '0.4s',
                transitionTimingFunction: 'ease-in-out',
                transitionProperty: 'transform'
              });
              return _el$76;
            })(),
            fDuration: 0.4
          });
        }, 1, 'Weapon.OnActivate.Shine');
      },
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#WeaponName"),
          'sImg': "file://{images}/custom_game/lower_hud/weapon.png",
          'sRes': `gold=${getLevelUpGold()}`,
          'tGroups': (() => {
            var _a, _b, _c;
            const tGroups = [];
            let t = [];
            Object.keys(((_a = CfgGetter_weapon_attribute()) === null || _a === void 0 ? void 0 : _a[getLevel()]) || {}).forEach(sID => {
              var _a, _b;
              if (sID.startsWith('106')) {
                const fVal = Number((((_b = (_a = CfgGetter_weapon_attribute()) === null || _a === void 0 ? void 0 : _a[getLevel()]) === null || _b === void 0 ? void 0 : _b[sID]) * (1 + AttributeKind$1.WeaponStatsPct.Get(props.getEntID()) * 0.01)).toFixed(2));
                t.push({
                  id: sID,
                  val: fVal
                });
              }
            });
            tGroups.push({
              'sTitle': YellowText($.Localize('#WeaponBaseAttribute')),
              'tAttribute': t
            });
            if (((_b = getWeaponData()) === null || _b === void 0 ? void 0 : _b.affix.length) > 0) {
              tGroups.push({
                'sTitle': YellowText($.Localize('#WeaponAffix')),
                'tAttribute': (_c = getWeaponData()) === null || _c === void 0 ? void 0 : _c.affix
              });
            }
            return tGroups;
          })(),
          'sTips': $.Localize('#WeaponTipDes')
        });
      },
      onmouseout: HideTooltip,
      oncontextmenu: p => {
        let iCount = 10;
        Timer(() => {
          if (GetRes("gold", getter_iLocalPlayer()) < getLevelUpGold()) {
            ErrorMsg('error_not_enough_gold');
            return;
          }
          GameEvents.SendCustomGameEventToServer('OnWeaponLevelUp', {});
          ScreenPanel.CreateOnPanel({
            'pTarget': p,
            'content': () => (() => {
              const _el$77 = createElement("DOTAParticleScenePanel", {
                hittest: false,
                particleonly: false,
                drawbackground: true,
                rendershadows: true,
                particleName: "particles/ui/common/forge/forge.vpcf",
                cameraOrigin: "-50 -100 120",
                lookAt: "0 0 0",
                fov: 60
              }, null);
              setProp(_el$77, "style", {
                width: '200px',
                height: '200px'
              });
              return _el$77;
            })(),
            fInterval: 0.35,
            'onUpdate': () => {
              Game.EmitSound('DOTA_Item.HavocHammer.Cast');
            },
            fDuration: 0.5
          });
          Timer(() => {
            const tStyle = {
              1: {
                saturation: 0.1,
                brightness: 0.7
              },
              2: {
                hueRotation: '90deg'
              },
              3: {
                hueRotation: '170deg'
              },
              4: {
                hueRotation: '210deg'
              },
              5: {},
              6: {
                hueRotation: '325deg',
                washColor: '#f006'
              }
            }[getLevel() % 5];
            ScreenPanel.CreateOnPanel({
              'pTarget': p,
              'content': () => (() => {
                const _el$78 = createElement("Panel", {
                    hittest: false
                  }, null),
                  _el$79 = createElement("DOTAParticleScenePanel", {
                    hittest: false,
                    particleonly: false,
                    drawbackground: true,
                    rendershadows: true,
                    particleName: "particles/ui/plus/ui_hud_relic_gem_gold_ambient.vpcf",
                    cameraOrigin: "0 0 300",
                    lookAt: "0 0 0",
                    fov: 60,
                    get style() {
                      return Object.assign({
                        width: '600px',
                        height: '600px'
                      }, tStyle);
                    }
                  }, _el$78),
                  _el$80 = createElement("DOTAParticleScenePanel", {
                    hittest: false,
                    particleonly: false,
                    drawbackground: true,
                    rendershadows: true,
                    particleName: "particles/ui/plus/ui_hud_relic_burst_generic.vpcf",
                    cameraOrigin: "0 0 200",
                    lookAt: "0 0 0",
                    fov: 60,
                    get style() {
                      return Object.assign({
                        width: '600px',
                        height: '600px',
                        preTransformRotate2d: RandomInt(0, 360) + 'deg'
                      }, tStyle);
                    }
                  }, _el$78);
                effect(_p$ => {
                  const _v$18 = Object.assign({
                      width: '600px',
                      height: '600px'
                    }, tStyle),
                    _v$19 = Object.assign({
                      width: '600px',
                      height: '600px',
                      preTransformRotate2d: RandomInt(0, 360) + 'deg'
                    }, tStyle);
                  _v$18 !== _p$._v$18 && (_p$._v$18 = setProp(_el$79, "style", _v$18, _p$._v$18));
                  _v$19 !== _p$._v$19 && (_p$._v$19 = setProp(_el$80, "style", _v$19, _p$._v$19));
                  return _p$;
                }, {
                  _v$18: undefined,
                  _v$19: undefined
                });
                return _el$78;
              })(),
              fInterval: 0.35,
              fDuration: 1
            });
          }, 0.2, 'Weapon.OnActivate.Particle');
          Timer(() => {
            ScreenPanel.CreateOnPanel({
              'pTarget': p,
              'content': () => (() => {
                const _el$81 = createElement("Panel", {
                  hittest: false
                }, null);
                setProp(_el$81, "onload", p => {
                  p.style.transform = 'translateX(50%) translateY(-50%)';
                });
                setProp(_el$81, "style", {
                  width: '50px',
                  height: '50px',
                  backgroundColor: 'gradient( linear, 100% 0%, 0% 100%, from( #00000000 ), color-stop( 0.3, #00000000 ), color-stop( 0.45, #ffffffff ), color-stop( 0.55, #ffffffff ), color-stop( 0.7, #00000000 ), to( #00000000 ) )',
                  transform: 'translateX(-50%) translateY(50%)',
                  transitionDuration: '0.4s',
                  transitionTimingFunction: 'ease-in-out',
                  transitionProperty: 'transform'
                });
                return _el$81;
              })(),
              fDuration: 0.4
            });
          }, 1, 'Weapon.OnActivate.Shine');
          iCount--;
          if (iCount > 0) {
            return 0.15;
          }
        }, 0, 'Weapon_Auto_Level_Up');
      },
      get children() {
        return [createElement("Panel", {
          "class": "BG",
          hittest: false
        }, null), (() => {
          const _el$66 = createElement("Panel", {
              "class": "Body"
            }, null),
            _el$67 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$66),
            _el$68 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$66),
            _el$69 = createElement("Label", {
              "class": "CountLabel",
              get text() {
                return "+" + getLevel();
              }
            }, _el$66),
            _el$70 = createElement("Panel", {
              "class": "Name"
            }, _el$66);
            createElement("Label", {
              text: '#WeaponOperateBtn'
            }, _el$70);
          effect(_p$ => {
            const _v$13 = getImage(),
              _v$14 = getKeybind(),
              _v$15 = "+" + getLevel();
            _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$67, "src", _v$13, _p$._v$13));
            _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$68, "text", _v$14, _p$._v$14));
            _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$69, "text", _v$15, _p$._v$15));
            return _p$;
          }, {
            _v$13: undefined,
            _v$14: undefined,
            _v$15: undefined
          });
          return _el$66;
        })()];
      }
    });
  }
  function CardBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const [getResource] = useNetEventTable(t => t, 'resource', () => String(getter_iLocalPlayer()));
    const [getCardSelect] = useNetEventTable(t => t, 'card', () => 'select_' + getter_iLocalPlayer());
    const [getCardSelectCount] = useNetEventTable(t => t || 0, 'card', () => 'select_count_' + getter_iLocalPlayer());
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_F];
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_CARD_SELECTION_TOGGLE', () => {
        setOpen(!getOpen());
      });
      onCleanup(() => {
        EventManager.Unreg('ON_CARD_SELECTION_TOGGLE', id);
      });
    });
    const getCost = () => {
      var _a, _b, _c;
      let iSelectCost = Math.min(((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['CardSelectionBaseCost']) + getCardSelectCount() * ((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['CardSelectionPerCost']), (_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['CardSelectionMaxCost']);
      return Math.floor(iSelectCost);
    };
    const getActive = () => {
      var _a;
      let iSelectCost = getCost();
      if (((_a = getResource()) === null || _a === void 0 ? void 0 : _a["wood"]) < iSelectCost) return false;
      return true;
    };
    const getCount = () => {
      var _a, _b, _c, _d;
      let iWood = ((_a = getResource()) === null || _a === void 0 ? void 0 : _a["wood"]) || 0;
      let iSelectCount = getCardSelectCount() || 0;
      let iBaseCount = ((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['CardSelectionBaseCost']) || 0;
      if (iBaseCount == 0) {
        return 0;
      }
      let iPerCount = ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['CardSelectionPerCost']) || 0;
      if (iPerCount == 0) {
        return 0;
      }
      let iMaxCount = (_d = CfgGetter_settings_common()) === null || _d === void 0 ? void 0 : _d['CardSelectionMaxCost'];
      if (iMaxCount == 0) {
        return 0;
      }
      let iCost = 0;
      let iCount = 0;
      while (iWood >= iCost) {
        iCost = Math.min(iBaseCount + (iSelectCount + iCount) * iPerCount, iMaxCount);
        if (iWood >= iCost) {
          iWood -= iCost;
          iCount++;
        }
      }
      return iCount;
    };
    return createComponent(KeybindButton, {
      id: "CardBtn",
      get ["class"]() {
        return classNames('OperateBtn', {
          'Active': getActive() || getCardSelect() != undefined,
          'Show': getActive() || getCardSelect() != undefined
        });
      },
      key: getKeybind,
      onactivate: () => {
        if (getCardSelect() != undefined) {
          EventManager.Fire('ON_CARD_SELECTION_TOGGLE', {
            'open': !getOpen()
          });
          return;
        }
        if (!getActive()) return ErrorMsg('error_not_enough_wood');
        GameEvents.SendCustomGameEventToServer('OnOpenCardSelected', {});
        EventManager.Fire('ON_CARD_SELECTION_TOGGLE', {
          'open': true
        });
      },
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#CardBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/card.png",
          'sRes': `wood=${getCost()}`,
          'sContext': $.Localize("#CardBtnDes")
        });
      },
      onmouseout: HideTooltip,
      get children() {
        const _el$90 = createElement("Panel", {
            "class": "Body"
          }, null);
          createElement("Panel", {
            "class": "BG"
          }, _el$90);
          const _el$92 = createElement("Label", {
            "class": "HotKey",
            get text() {
              return getKeybind();
            }
          }, _el$90),
          _el$93 = createElement("Panel", {
            "class": "Name"
          }, _el$90),
          _el$94 = createElement("Label", {
            get text() {
              return $.Localize('#CardBtn') + ' x' + getCount();
            }
          }, _el$93);
        insert(_el$90, createComponent(Show, {
          get when() {
            return getActive() || getCardSelect() != undefined;
          },
          get children() {
            const _el$95 = createElement("Panel", {
                "class": "TogglePtc",
                hittest: false
              }, null);
              createElement("DOTAParticleScenePanel", {
                hittest: false,
                particleName: "particles/ui/hud/autocasting_square.vpcf",
                cameraOrigin: "0 0 50",
                lookAt: "0 0 0",
                fov: 90
              }, _el$95);
            return _el$95;
          }
        }), null);
        effect(_p$ => {
          const _v$23 = getKeybind(),
            _v$24 = $.Localize('#CardBtn') + ' x' + getCount();
          _v$23 !== _p$._v$23 && (_p$._v$23 = setProp(_el$92, "text", _v$23, _p$._v$23));
          _v$24 !== _p$._v$24 && (_p$._v$24 = setProp(_el$94, "text", _v$24, _p$._v$24));
          return _p$;
        }, {
          _v$23: undefined,
          _v$24: undefined
        });
        return _el$90;
      }
    });
  }
  function RelicBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const [getSelect] = useNetEventTable(t => t, 'relic', () => 'select_' + getter_iLocalPlayer());
    const [getSelectCount] = useNetEventTable(t => t || 0, 'relic', () => 'select_count_' + getter_iLocalPlayer());
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_G];
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_RELIC_SELECTION_TOGGLE', () => {
        setOpen(!getOpen());
      });
      onCleanup(() => {
        EventManager.Unreg('ON_RELIC_SELECTION_TOGGLE', id);
      });
    });
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/relic.png';
    };
    return createComponent(KeybindButton, {
      id: "RelicBtn",
      get ["class"]() {
        return classNames('OperateBtn', {
          'Active': getSelectCount() > 0,
          'Show': getSelectCount() > 0
        });
      },
      key: getKeybind,
      onactivate: () => {
        if (getSelect() != undefined) {
          EventManager.Fire('ON_RELIC_SELECTION_TOGGLE', {
            'open': !getOpen()
          });
          return;
        }
        if (getSelectCount() <= 0) return ErrorMsg('error_not_count_enough');
        GameEvents.SendCustomGameEventToServer('OnOpenRelicSelected', {});
        EventManager.Fire('ON_RELIC_SELECTION_TOGGLE', {
          'open': true
        });
      },
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#RelicBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/relic.png",
          'sContext': $.Localize("#RelicBtnDes")
        });
      },
      onmouseout: HideTooltip,
      get children() {
        return [createElement("Panel", {
          "class": "BG"
        }, null), (() => {
          const _el$98 = createElement("Panel", {
              "class": "Body"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$98);
            const _el$100 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$98),
            _el$101 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$98),
            _el$102 = createElement("Label", {
              "class": "CountLabel",
              get text() {
                return getSelectCount();
              }
            }, _el$98),
            _el$103 = createElement("Panel", {
              "class": "Name"
            }, _el$98);
            createElement("Label", {
              text: '#RelicBtn'
            }, _el$103);
          insert(_el$98, createComponent(Show, {
            get when() {
              return getSelectCount() > 0;
            },
            get children() {
              const _el$105 = createElement("Panel", {
                  "class": "TogglePtc",
                  hittest: false
                }, null);
                createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleName: "particles/ui/hud/autocasting_square.vpcf",
                  cameraOrigin: "0 0 50",
                  lookAt: "0 0 0",
                  fov: 90
                }, _el$105);
              return _el$105;
            }
          }), null);
          effect(_p$ => {
            const _v$25 = getImage(),
              _v$26 = getKeybind(),
              _v$27 = getSelectCount();
            _v$25 !== _p$._v$25 && (_p$._v$25 = setProp(_el$100, "src", _v$25, _p$._v$25));
            _v$26 !== _p$._v$26 && (_p$._v$26 = setProp(_el$101, "text", _v$26, _p$._v$26));
            _v$27 !== _p$._v$27 && (_p$._v$27 = setProp(_el$102, "text", _v$27, _p$._v$27));
            return _p$;
          }, {
            _v$25: undefined,
            _v$26: undefined,
            _v$27: undefined
          });
          return _el$98;
        })()];
      }
    });
  }
  function AbilityBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const [getSelect] = useNetEventTable(t => t, 'abilities', () => 'select_' + getter_iLocalPlayer());
    const [getSelectCount] = useNetEventTable(t => t || 0, 'abilities', () => 'select_count_' + getter_iLocalPlayer());
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_V];
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_ABILITY_SELECTION_TOGGLE', () => {
        setOpen(!getOpen());
      });
      onCleanup(() => {
        EventManager.Unreg('ON_ABILITY_SELECTION_TOGGLE', id);
      });
    });
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/ability.png';
    };
    return createComponent(KeybindButton, {
      id: "AbilityBtn",
      get ["class"]() {
        return classNames('OperateBtn', {
          'Active': getSelectCount() > 0,
          'Show': getSelectCount() > 0
        });
      },
      key: getKeybind,
      onactivate: () => {
        if (getSelect() != undefined) {
          EventManager.Fire('ON_ABILITY_SELECTION_TOGGLE', {
            'open': !getOpen()
          });
          return;
        }
        if (getSelectCount() <= 0) return ErrorMsg('error_not_count_enough');
        GameEvents.SendCustomGameEventToServer('OnOpenAbilitySelected', {});
        EventManager.Fire('ON_ABILITY_SELECTION_TOGGLE', {
          'open': true
        });
      },
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#AbilityBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/ability.png",
          'sContext': $.Localize("#AbilityBtnDes")
        });
      },
      onmouseout: HideTooltip,
      get children() {
        return [createElement("Panel", {
          "class": "BG"
        }, null), (() => {
          const _el$108 = createElement("Panel", {
              "class": "Body"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$108);
            const _el$110 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$108),
            _el$111 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$108),
            _el$112 = createElement("Label", {
              "class": "CountLabel",
              get text() {
                return getSelectCount();
              }
            }, _el$108),
            _el$113 = createElement("Panel", {
              "class": "Name"
            }, _el$108);
            createElement("Label", {
              text: '#AbilityBtn'
            }, _el$113);
          insert(_el$108, createComponent(Show, {
            get when() {
              return getSelectCount() > 0;
            },
            get children() {
              const _el$115 = createElement("Panel", {
                  "class": "TogglePtc",
                  hittest: false
                }, null);
                createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleName: "particles/ui/hud/autocasting_square.vpcf",
                  cameraOrigin: "0 0 50",
                  lookAt: "0 0 0",
                  fov: 90
                }, _el$115);
              return _el$115;
            }
          }), null);
          effect(_p$ => {
            const _v$28 = getImage(),
              _v$29 = getKeybind(),
              _v$30 = getSelectCount();
            _v$28 !== _p$._v$28 && (_p$._v$28 = setProp(_el$110, "src", _v$28, _p$._v$28));
            _v$29 !== _p$._v$29 && (_p$._v$29 = setProp(_el$111, "text", _v$29, _p$._v$29));
            _v$30 !== _p$._v$30 && (_p$._v$30 = setProp(_el$112, "text", _v$30, _p$._v$30));
            return _p$;
          }, {
            _v$28: undefined,
            _v$29: undefined,
            _v$30: undefined
          });
          return _el$108;
        })()];
      }
    });
  }
  function AdventureBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const [getAdventure] = useDiyPolymer(getter_iSelectUnit, 'adventure');
    const getAdventureData = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getAdventure()) === null || _a === void 0 ? void 0 : _a.data) === null || _b === void 0 ? void 0 : _b.Adventure;
    });
    const getKillCount = () => {
      var _a;
      return (_a = getAdventureData()) === null || _a === void 0 ? void 0 : _a.kill_count;
    };
    const getMaxKillCount = () => {
      var _a;
      return (_a = getAdventureData()) === null || _a === void 0 ? void 0 : _a.max_kill_count;
    };
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_B];
    });
    const [getAdventureSelect] = useNetEventTable(t => t, 'adventure', () => 'select_' + getter_iLocalPlayer());
    createEffect(() => {
      const id = EventManager.Reg('ON_ADVENTURE_TOGGLE', event => {
        setOpen(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_ADVENTURE_TOGGLE', id);
      });
    });
    const getActive = () => {
      return getKillCount() >= (getMaxKillCount() || 0);
    };
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/adventure.png';
    };
    return createComponent(KeybindButton, {
      id: "AdventureBtn",
      get ["class"]() {
        return classNames("OperateBtn", {
          'Active': getActive(),
          'Show': getActive()
        });
      },
      key: getKeybind,
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#AdventureBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/adventure.png",
          'sContext': $.Localize("#AdventureBtnDes")
        });
      },
      onmouseout: HideTooltip,
      onactivate: () => {
        if (getAdventureSelect() != undefined) {
          EventManager.Fire('ON_ADVENTURE_TOGGLE', {
            'open': !getOpen()
          });
          return;
        }
        if (!getActive()) return ErrorMsg('error_not_enough_kill');
        GameEvents.SendCustomGameEventToServer('OnOpenAdventureSelected', {});
        EventManager.Fire('ON_ADVENTURE_TOGGLE', {
          'open': true
        });
      },
      get children() {
        return [createElement("Panel", {
          "class": "BG",
          hittest: false
        }, null), (() => {
          const _el$118 = createElement("Panel", {
              "class": "Body"
            }, null);
            createElement("Panel", {
              "class": "BG",
              hittest: false
            }, _el$118);
            const _el$120 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$118),
            _el$121 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$118),
            _el$122 = createElement("Panel", {
              "class": "Name"
            }, _el$118);
            createElement("Label", {
              text: '#AdventureBtn'
            }, _el$122);
          insert(_el$118, createComponent(Show, {
            get when() {
              return getActive();
            },
            get children() {
              const _el$124 = createElement("Panel", {
                  "class": "TogglePtc",
                  hittest: false
                }, null);
                createElement("DOTAParticleScenePanel", {
                  hittest: false,
                  particleName: "particles/ui/hud/autocasting_square.vpcf",
                  cameraOrigin: "0 0 50",
                  lookAt: "0 0 0",
                  fov: 90
                }, _el$124);
              return _el$124;
            }
          }), null);
          effect(_p$ => {
            const _v$31 = getImage(),
              _v$32 = getKeybind();
            _v$31 !== _p$._v$31 && (_p$._v$31 = setProp(_el$120, "src", _v$31, _p$._v$31));
            _v$32 !== _p$._v$32 && (_p$._v$32 = setProp(_el$121, "text", _v$32, _p$._v$32));
            return _p$;
          }, {
            _v$31: undefined,
            _v$32: undefined
          });
          return _el$118;
        })()];
      }
    });
  }
  function DevourBtn(props) {
    const [getOpen, setOpen] = createSignal(false);
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_T];
    });
    const getImage = () => {
      return 'file://{images}/custom_game/lower_hud/devour.png';
    };
    createEffect(() => {
      const id = EventManager.Reg('ON_DEVOUR_TOGGLE', () => {
        setOpen(!getOpen());
      });
      onCleanup(() => {
        EventManager.Unreg('ON_DEVOUR_TOGGLE', id);
      });
    });
    return createComponent(KeybindButton, {
      id: "DevourBtn",
      get ["class"]() {
        return classNames("OperateBtn", {
          'Active': true
        });
      },
      key: getKeybind,
      onmouseover: p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': $.Localize("#DevourBtn"),
          'sImg': "file://{images}/custom_game/lower_hud/devour.png",
          'sContext': $.Localize("#DevourBtnDes")
        });
      },
      onmouseout: HideTooltip,
      onactivate: () => {
        EventManager.Fire('ON_DEVOUR_TOGGLE', {
          'open': !getOpen()
        });
      },
      get children() {
        return [createElement("Panel", {
          "class": "BG",
          hittest: false
        }, null), (() => {
          const _el$127 = createElement("Panel", {
              "class": "Body"
            }, null),
            _el$128 = createElement("Image", {
              "class": "Icon",
              get src() {
                return getImage();
              }
            }, _el$127),
            _el$129 = createElement("Label", {
              "class": "HotKey",
              get text() {
                return getKeybind();
              }
            }, _el$127),
            _el$130 = createElement("Panel", {
              "class": "Name"
            }, _el$127);
            createElement("Label", {
              text: '#DevourBtn'
            }, _el$130);
          effect(_p$ => {
            const _v$33 = getImage(),
              _v$34 = getKeybind();
            _v$33 !== _p$._v$33 && (_p$._v$33 = setProp(_el$128, "src", _v$33, _p$._v$33));
            _v$34 !== _p$._v$34 && (_p$._v$34 = setProp(_el$129, "text", _v$34, _p$._v$34));
            return _p$;
          }, {
            _v$33: undefined,
            _v$34: undefined
          });
          return _el$127;
        })()];
      }
    });
  }

  function Pause() {
    const [getPaused] = useNetEventTable(t => t, 'common', 'pause');
    const [getPauseKey, setPauseKey] = createSignal(Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE));
    createEffect(() => {
      const id = GameEvents.Subscribe('keybind_changed', () => {
        setPauseKey(Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE));
      });
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
      });
    });
    createEffect(on(getPauseKey, () => {
      const sPauseKey = getPauseKey();
      let key = Keybinds.Bind(sPauseKey, 1, () => {
        GameEvents.SendCustomGameEventToServer('OnPause', {});
      });
      onCleanup(() => {
        Keybinds.Unbind(key, sPauseKey);
      });
    }));
    return (() => {
      const _el$ = createElement("Panel", {
          hittest: false
        }, null),
        _el$2 = createElement("Label", {
          id: "PauseLabel",
          text: '#DOTA_Hud_Paused'
        }, _el$);
      insert(_el$, createComponent(TipsPanel, {}), _el$2);
      effect(_$p => setProp(_el$, "className", classNames('Pause', {
        'Show': getPaused()
      }), _$p));
      return _el$;
    })();
  }

  function NumberRunningLabel(props) {
    var _a, _b;
    const [_, props_other] = splitProps(props, ['fNumber', 'fDuration', 'iRetained', 'fNumberStart', 'bUnitization', 'localize']);
    let ref;
    let iNum = NaN;
    createEffect(() => {
      if (props.fNumber != undefined) {
        const fStartTime = Game.Time();
        const fEndTime = fStartTime + props.fDuration;
        let fStartNum;
        if (props.fNumberStart != undefined) {
          fStartNum = props.fNumberStart;
        } else {
          fStartNum = iNum || 0;
        }
        const id = Timer(() => {
          var _a;
          if (ref) {
            iNum = RemapValClamped(Game.Time(), fStartTime, fEndTime, fStartNum, props.fNumber);
            iNum = Number(iNum.toFixed((_a = props.iRetained) !== null && _a !== void 0 ? _a : 0));
            let val = props.bUnitization ? FormatNumber(iNum) : String(iNum);
            if (props.localize) {
              ref.SetDialogVariableInt(props.localize.key, Number(val));
            } else {
              ref.text = val;
            }
            if (Game.Time() >= fEndTime) return;
          }
          return 0;
        }, 0, undefined, 'NumberRunningLabel');
        onCleanup(() => {
          StopTimer(id);
        });
      }
    });
    const text = (_b = (_a = props.localize) === null || _a === void 0 ? void 0 : _a.text) !== null && _b !== void 0 ? _b : '';
    return (() => {
      const _el$ = createElement("Label", mergeProps(props_other, {
        text: text
      }), null);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') props.ref(p);
      }, _el$);
      spread(_el$, mergeProps(props_other, {
        "text": text
      }), false);
      return _el$;
    })();
  }

  const getter_iPlayerSelectedHero = usePlayerSelectedHero();

  function Resource() {
    const [getResource] = useNetEventTable(t => t, 'resource', () => String(getter_iLocalPlayer()));
    const [getAttribute, setAttribute] = createSignal([]);
    createEffect(() => {
      const iTimeID = GameTimer(() => {
        const t = [];
        ["gold", "wood", "kill"].forEach((sResType, i) => {
          var _a;
          const fVal = Math.floor((_a = getResource()) === null || _a === void 0 ? void 0 : _a[sResType]);
          const fPerVal = {
            ["gold"]: AttributeKind$1.PerSecGold,
            ["wood"]: AttributeKind$1.PerSecWood,
            ["kill"]: AttributeKind$1.PerSecKill
          }[sResType].Get(getter_iPlayerSelectedHero());
          t.push({
            'name': sResType,
            'val': fVal,
            'per_val': fPerVal
          });
        });
        setAttribute(t);
        return 0.2;
      }, -1, undefined, 'Resource');
      onCleanup(() => {
        StopTimer(iTimeID);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "Resource",
          hittest: false
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Body"
        }, _el$);
      insert(_el$2, createComponent(Index, {
        get each() {
          return getAttribute();
        },
        children: (getVal, i) => {
          return (() => {
            const _el$3 = createElement("Panel", {
                get ["class"]() {
                  return classNames('ResourceRow', getVal().name);
                }
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$3);
              createElement("Panel", {
                "class": "Icon"
              }, _el$3);
              const _el$6 = createElement("Label", {
                "class": "PerValLabel",
                get text() {
                  return ' +' + FormatNumber(getVal().per_val) + '/s';
                }
              }, _el$3);
            insert(_el$3, createComponent(NumberRunningLabel, {
              "class": "ValLabel",
              get fNumber() {
                return getVal().val;
              },
              fDuration: 0.2,
              bUnitization: true
            }), _el$6);
            effect(_p$ => {
              const _v$ = classNames('ResourceRow', getVal().name),
                _v$2 = ' +' + FormatNumber(getVal().per_val) + '/s';
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$3, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$6, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$3;
          })();
        }
      }));
      return _el$;
    })();
  }

  function SelectionLevelup() {
    var _a;
    const [getData] = useNetEventTable(t => t, 'level_up', () => 'select_' + getter_iLocalPlayer());
    const [getLevelUpFreeRefreshCount] = useNetEventTable(t => t, 'level_up', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const [getLevelUpRefreshCount] = useNetEventTable(t => t, 'level_up', () => 'refresh_count_' + getter_iLocalPlayer());
    const getRefreshText = createMemo(() => {
      var _a, _b, _c;
      if ((getLevelUpFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getLevelUpFreeRefreshCount() || 0);
      }
      return ReplaceTextVariable('#RefreshCount', Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['LevelUpSelectionRefreshBaseCost']) || 0) + (getLevelUpRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['LevelUpSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['LevelUpSelectionRefreshMaxCost']) || 0));
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "SelectionLevelUp",
          get ["class"]() {
            return classNames({
              'Show': getData() != undefined
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Header"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        const _el$5 = createElement("Label", {
          get text() {
            return $.Localize('#LevelUpReward');
          }
        }, _el$3),
        _el$6 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$7 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$6),
        _el$8 = createElement("TextButton", {
          id: "RefreshBtn",
          get text() {
            return getRefreshText();
          },
          html: true
        }, _el$6);
      insert(_el$7, createComponent(Index, {
        get each() {
          return (_a = getData()) !== null && _a !== void 0 ? _a : [];
        },
        children: (getRewardData, i) => {
          var _a, _b;
          const sRewardID = () => getRewardData().reward_id;
          const fVal = () => getRewardData().val;
          const getLevel = () => getRewardData().level;
          return (() => {
            const _el$9 = createElement("Panel", {
                get ["class"]() {
                  return classNames("SelectionRow", 'Rarity_' + getLevel());
                }
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$9);
              const _el$1 = createElement("Panel", {
                "class": "Body"
              }, _el$9),
              _el$10 = createElement("Panel", {
                "class": "AttributeRow"
              }, _el$1),
              _el$11 = createElement("Label", {
                get text() {
                  return $.Localize('#' + sRewardID());
                }
              }, _el$10),
              _el$12 = createElement("Label", {
                get text() {
                  return GreenText(` +${fVal()}${(_b = PctUnitAttributes[(_a = ID2Attribute[sRewardID()]) === null || _a === void 0 ? void 0 : _a.name]) !== null && _b !== void 0 ? _b : ''}`);
                },
                html: true
              }, _el$10);
            setProp(_el$9, "onactivate", () => {
              GameEvents.SendCustomGameEventToServer('OnLevelUpSelection', {
                'index': i
              });
            });
            setProp(_el$11, "className", "Name");
            setProp(_el$12, "className", "Value");
            effect(_p$ => {
              const _v$4 = classNames("SelectionRow", 'Rarity_' + getLevel()),
                _v$5 = $.Localize('#' + sRewardID()),
                _v$6 = GreenText(` +${fVal()}${(_b = PctUnitAttributes[(_a = ID2Attribute[sRewardID()]) === null || _a === void 0 ? void 0 : _a.name]) !== null && _b !== void 0 ? _b : ''}`);
              _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$9, "class", _v$4, _p$._v$4));
              _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$11, "text", _v$5, _p$._v$5));
              _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$12, "text", _v$6, _p$._v$6));
              return _p$;
            }, {
              _v$4: undefined,
              _v$5: undefined,
              _v$6: undefined
            });
            return _el$9;
          })();
        }
      }));
      setProp(_el$8, "onactivate", p => {
        var _a, _b, _c;
        if ((getLevelUpFreeRefreshCount() || 0) <= 0) {
          const iRefreshCost = Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['LevelUpSelectionRefreshBaseCost']) || 0) + (getLevelUpRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['LevelUpSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['LevelUpSelectionRefreshMaxCost']) || 0);
          if (iRefreshCost > GetRes("kill", getter_iLocalPlayer())) return ErrorMsg(`error_not_enough_${"kill"}`);
        }
        GameEvents.SendCustomGameEventToServer('OnRefreshLevelUpSelect', {});
      });
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getData() != undefined
          }),
          _v$2 = $.Localize('#LevelUpReward'),
          _v$3 = getRefreshText();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$5, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$8, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }

  function SelectionHero() {
    const [getOpen, setOpen] = createSignal(false);
    const [getHeroSelect] = useNetEventTable(t => t, 'hero', () => 'select_' + getter_iLocalPlayer());
    const [getHeroFreeRefreshCount] = useNetEventTable(t => t, 'hero', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const [getHeroRefreshCount] = useNetEventTable(t => t, 'hero', () => 'refresh_count_' + getter_iLocalPlayer());
    const getRefreshText = createMemo(() => {
      var _a, _b, _c;
      if ((getHeroFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getHeroFreeRefreshCount() || 0);
      }
      return ReplaceTextVariable('#RefreshCount', Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['HeroSelectionRefreshBaseCost']) || 0) + (getHeroRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['HeroSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['HeroSelectionRefreshMaxCost']) || 0));
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_HERO_SELECTION_TOGGLE', event => {
        setOpen(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_HERO_SELECTION_TOGGLE', id);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "HeroSelection",
          get ["class"]() {
            return classNames({
              'Show': getOpen() && getHeroSelect() != undefined
            });
          }
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$3 = createElement("Panel", {
          "class": "BottomPanel"
        }, _el$),
        _el$4 = createElement("TextButton", {
          id: "CloseBtn",
          text: "#ChooseLaterBtn"
        }, _el$3),
        _el$5 = createElement("Panel", {
          "class": "Group"
        }, _el$3);
        createElement("Label", {
          id: "GiveUpSelectionHeroDes",
          text: '#GiveUpSelectionHeroDes'
        }, _el$5);
        const _el$7 = createElement("TextButton", {
          id: "GiveUpBtn",
          text: "#GiveUpBtn"
        }, _el$5),
        _el$8 = createElement("TextButton", {
          id: "RefreshBtn",
          get text() {
            return getRefreshText();
          },
          html: true
        }, _el$3);
      insert(_el$2, createComponent(For, {
        get each() {
          return getHeroSelect();
        },
        children: (sName, i) => {
          if (sName == 'Unknown') {
            return (() => {
              const _el$9 = createElement("Panel", {
                  "class": "HeroRow"
                }, null),
                _el$0 = createElement("Panel", {
                  "class": "BG"
                }, _el$9);
                createElement("Label", {
                  id: "HeroName",
                  text: "#UnknownEvolve"
                }, _el$9);
                const _el$10 = createElement("Panel", {
                  "class": "Line"
                }, _el$9),
                _el$11 = createElement("Panel", {
                  id: "HeroRarity"
                }, _el$9);
                createElement("Label", {
                  id: "HeroDescription",
                  text: "#UnknownEvolveContent"
                }, _el$9);
              setProp(_el$9, "onactivate", p => {
                p.AddClass('Selected');
                GameEvents.SendCustomGameEventToServer('OnHeroSelected', {
                  'name': sName
                });
              });
              setProp(_el$0, "style", {
                backgroundImage: `url("file://{images}/custom_game/selections/hero/bg_0.png")`
              });
              insert(_el$9, createComponent(Yzy_ItemImage, {
                id: "HeroImage",
                name: sName,
                image: `file://{images}/custom_game/hero_icon/random.png`,
                rarity: 1,
                hittest: false
              }), _el$10);
              setProp(_el$11, "style", {
                backgroundImage: `url("file://{images}/custom_game/selections/hero/Unknown.png")`
              });
              return _el$9;
            })();
          } else {
            const getKv = () => CustomHeroesKv[sName];
            if (getKv() == undefined) return;
            const getName = () => getKv()['Talent'];
            return (() => {
              const _el$13 = createElement("Panel", {
                  "class": "HeroRow"
                }, null),
                _el$14 = createElement("Panel", {
                  "class": "BG",
                  get style() {
                    return {
                      backgroundImage: `url("file://{images}/custom_game/selections/hero/bg_${getKv()['Rarity']}.png")`
                    };
                  }
                }, _el$13),
                _el$15 = createElement("Label", {
                  id: "HeroName",
                  text: '#' + sName
                }, _el$13),
                _el$16 = createElement("Panel", {
                  "class": "Line"
                }, _el$13),
                _el$17 = createElement("Panel", {
                  id: "HeroRarity",
                  get style() {
                    return {
                      backgroundImage: `url("file://{images}/custom_game/selections/hero/${getKv()['Rarity']}.png")`
                    };
                  }
                }, _el$13),
                _el$18 = createElement("Panel", {
                  id: "HeroAbility",
                  onmouseout: HideTooltip
                }, _el$13);
                createElement("Panel", {
                  "class": "BG",
                  hittest: false
                }, _el$18);
                createElement("Panel", {
                  id: "AbilityBevel",
                  hittest: false
                }, _el$18);
                createElement("Panel", {
                  id: "PassiveAbilityBorder",
                  hittest: false
                }, _el$18);
                createElement("Panel", {
                  id: "AbilityBorder",
                  hittest: false
                }, _el$18);
                const _el$23 = createElement("Image", {
                  id: "AbilityImage",
                  get src() {
                    return `file://{images}/custom_game/talent/${getName()}.png`;
                  }
                }, _el$18);
              setProp(_el$13, "onactivate", p => {
                p.AddClass('Selected');
                GameEvents.SendCustomGameEventToServer('OnHeroSelected', {
                  'name': sName
                });
              });
              setProp(_el$15, "text", '#' + sName);
              insert(_el$13, createComponent(Yzy_ItemImage, {
                id: "HeroImage",
                name: sName,
                image: `file://{images}/custom_game/hero_icon/${sName}.png`,
                get rarity() {
                  return getKv()['Rarity'] + 1;
                },
                hittest: false
              }), _el$16);
              setProp(_el$18, "onmouseover", p => {
                ShowTooltip(p, 'talent_tooltip', {
                  'sTalentName': getName()
                });
              });
              setProp(_el$18, "onmouseout", HideTooltip);
              effect(_p$ => {
                const _v$3 = {
                    backgroundImage: `url("file://{images}/custom_game/selections/hero/bg_${getKv()['Rarity']}.png")`
                  },
                  _v$4 = {
                    backgroundImage: `url("file://{images}/custom_game/selections/hero/${getKv()['Rarity']}.png")`
                  },
                  _v$5 = `file://{images}/custom_game/talent/${getName()}.png`;
                _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$14, "style", _v$3, _p$._v$3));
                _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$17, "style", _v$4, _p$._v$4));
                _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$23, "src", _v$5, _p$._v$5));
                return _p$;
              }, {
                _v$3: undefined,
                _v$4: undefined,
                _v$5: undefined
              });
              return _el$13;
            })();
          }
        }
      }));
      setProp(_el$4, "onactivate", p => {
        EventManager.Fire('ON_HERO_SELECTION_TOGGLE', {
          'open': false
        });
      });
      setProp(_el$7, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnGiveUpSelect', {});
      });
      setProp(_el$8, "onactivate", p => {
        var _a, _b, _c;
        if ((getHeroFreeRefreshCount() || 0) <= 0) {
          const iRefreshCost = Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['HeroSelectionRefreshBaseCost']) || 0) + (getHeroRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['HeroSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['HeroSelectionRefreshMaxCost']) || 0);
          if (iRefreshCost > GetRes("kill", getter_iLocalPlayer())) return ErrorMsg(`error_not_enough_${"kill"}`);
        }
        GameEvents.SendCustomGameEventToServer('OnRefreshSelect', {});
      });
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getOpen() && getHeroSelect() != undefined
          }),
          _v$2 = getRefreshText();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }

  function ReplaceAbility() {
    const [getHeroAblt] = useNetEventTable(t => t, 'hero', () => 'hero_ablt_' + getter_iLocalPlayer());
    const [getData] = useNetEventTable(t => t, 'hero', () => 'select_replace_' + getter_iLocalPlayer());
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      if (getData() != undefined) {
        setShow(true);
      }
    });
    return createComponent(FadeShow, {
      get data() {
        return getData();
      },
      fade_out: 1,
      onFadedOut: () => {
        if (getData() == undefined) {
          setShow(false);
        }
      },
      bUseGameTime: true,
      children: getData => (() => {
        const _el$ = createElement("Panel", {
            id: "ReplaceAbility",
            get ["class"]() {
              return classNames({
                'Show': getShow()
              });
            }
          }, null);
          createElement("Panel", {
            "class": "BG"
          }, _el$);
          const _el$3 = createElement("Panel", {
            "class": "Body"
          }, _el$),
          _el$4 = createElement("Panel", {
            "class": "Header"
          }, _el$3);
          createElement("Label", {
            id: "Title",
            text: '#ReplaceAbilityTitle'
          }, _el$4);
          createElement("Panel", {
            "class": "Line"
          }, _el$4);
          const _el$7 = createElement("Panel", {
            "class": "Body"
          }, _el$3),
          _el$10 = createElement("Panel", {
            "class": "Operate"
          }, _el$3);
        insert(_el$7, createComponent(Show, {
          get when() {
            return getData() != undefined;
          },
          get children() {
            return [(() => {
              const _el$8 = createElement("Panel", {
                  "class": "AbilityBox"
                }, null);
                createElement("Panel", {
                  "class": "BG",
                  hittest: false
                }, _el$8);
              insert(_el$8, createComponent(AbilityPanel, {
                getAbilityName: () => getData()
              }), null);
              return _el$8;
            })(), createElement("Panel", {
              "class": "Line"
            }, null), (() => {
              const _el$1 = createElement("Panel", {
                "class": "Body"
              }, null);
              insert(_el$1, createComponent(Index, {
                get each() {
                  return Object.keys(getHeroAblt() || []);
                },
                children: (getIndex, i) => {
                  const getAbilityName = () => {
                    var _a;
                    return (_a = getHeroAblt()) === null || _a === void 0 ? void 0 : _a[Number(getIndex())];
                  };
                  return (() => {
                    const _el$11 = createElement("Panel", {
                      "class": "AbilityRow"
                    }, null);
                    setProp(_el$11, "onactivate", () => {
                      GameEvents.SendCustomGameEventToServer('OnReplaceSelected', {
                        'name': getAbilityName()
                      });
                    });
                    insert(_el$11, createComponent(AbilityPanel, {
                      getAbilityName: () => getAbilityName()
                    }));
                    return _el$11;
                  })();
                }
              }));
              return _el$1;
            })()];
          }
        }));
        insert(_el$10, createComponent(Yzy_Button, {
          id: "CloseBtn",
          text: "#CancelBtn",
          type: "btn_grey",
          onactivate: p => {
            GameEvents.SendCustomGameEventToServer('OnReplaceSelected', {});
          }
        }));
        effect(_$p => setProp(_el$, "class", classNames({
          'Show': getShow()
        }), _$p));
        return _el$;
      })()
    });
  }
  function AbilityPanel(props) {
    const getter = PropsGetter(props);
    return (() => {
      const _el$12 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('AbilityPanel', {
              Passive: IsPassive(getter.getAbilityName())
            });
          }
        }), null),
        _el$13 = createElement("Panel", {
          "class": "Body"
        }, _el$12),
        _el$14 = createElement("Panel", {
          id: "AbilityButton",
          onmouseout: HideTooltip
        }, _el$13),
        _el$15 = createElement("DOTAAbilityImage", {
          get abilityname() {
            return getter.getAbilityName();
          },
          showtooltip: false
        }, _el$14);
        createElement("Panel", {
          id: "AbilityBevel",
          hittest: false
        }, _el$14);
      spread(_el$12, mergeProps(props, {
        get ["class"]() {
          return classNames('AbilityPanel', {
            Passive: IsPassive(getter.getAbilityName())
          });
        }
      }), true);
      setProp(_el$14, "onmouseover", p => {
        ShowTooltip(p, 'ability_tooltip', {
          'sAbltName': getter.getAbilityName()
        });
      });
      setProp(_el$14, "onmouseout", HideTooltip);
      insert(_el$13, createComponent(Show, {
        get when() {
          return IsPassive(getter.getAbilityName());
        },
        get fallback() {
          return createElement("Panel", {
            id: "AbilityBorder",
            hittest: false
          }, null);
        },
        get children() {
          return createElement("Panel", {
            id: "PassiveAbilityBorder",
            hittest: false
          }, null);
        }
      }), null);
      effect(_$p => setProp(_el$15, "abilityname", getter.getAbilityName(), _$p));
      return _el$12;
    })();
  }
  function IsPassive(sAbltName) {
    var _a;
    const sAbilityBehavior = (_a = AbilitiesKv === null || AbilitiesKv === void 0 ? void 0 : AbilitiesKv[sAbltName]) === null || _a === void 0 ? void 0 : _a['AbilityBehavior'];
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

  function SelectionWeapon() {
    var _a;
    const [getWeaponSelection] = useNetEventTable(t => t, 'weapon', () => 'select_' + getter_iLocalPlayer());
    const [getShow, setShow] = createSignal(true);
    createEffect(() => {
      var _a;
      if (((_a = getWeaponSelection()) === null || _a === void 0 ? void 0 : _a[0]) != undefined) {
        setShow(true);
      }
    });
    return (() => {
      const _el$ = createElement("Panel", {
        id: "WeaponSelection",
        get ["class"]() {
          return classNames({
            'Show': getShow()
          });
        },
        hittest: false
      }, null);
      insert(_el$, createComponent(FadeShow, {
        get data() {
          return (_a = getWeaponSelection()) === null || _a === void 0 ? void 0 : _a[0];
        },
        fade_out: 1,
        fade_in: 2,
        onFadedOut: () => {
          var _a;
          if (((_a = getWeaponSelection()) === null || _a === void 0 ? void 0 : _a[0]) == undefined) {
            setShow(false);
          }
        },
        bUseGameTime: false,
        children: data => {
          var _a;
          return (() => {
            const _el$2 = createElement("Panel", {
                "class": "SelectRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$2);
              const _el$4 = createElement("Panel", {
                "class": "Header"
              }, _el$2);
              createElement("Label", {
                text: '#WeaponSelection'
              }, _el$4);
              const _el$6 = createElement("Panel", {
                "class": "Body",
                hittest: false
              }, _el$2);
            insert(_el$6, createComponent(Index, {
              get each() {
                return (_a = data()) !== null && _a !== void 0 ? _a : [];
              },
              children: (getAffixName, i) => {
                return (() => {
                  const _el$7 = createElement("Panel", {
                      "class": 'SelectionRow'
                    }, null);
                    createElement("Panel", {
                      "class": "BG"
                    }, _el$7);
                    const _el$9 = createElement("Panel", {
                      "class": "Body"
                    }, _el$7),
                    _el$0 = createElement("Label", {
                      "class": "AffixDesc",
                      get text() {
                        return ReplaceAbltVals(getAffixName(), $.Localize(`#${getAffixName()}_Description`));
                      },
                      html: true
                    }, _el$9);
                  setProp(_el$7, "onactivate", () => {
                    var _a;
                    if ((_a = getWeaponSelection()) === null || _a === void 0 ? void 0 : _a[0]) {
                      GameEvents.SendCustomGameEventToServer('OnWeaponSelection', {
                        'index': i
                      });
                    }
                  });
                  effect(_$p => setProp(_el$0, "text", ReplaceAbltVals(getAffixName(), $.Localize(`#${getAffixName()}_Description`)), _$p));
                  return _el$7;
                })();
              }
            }));
            return _el$2;
          })();
        }
      }));
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': getShow()
      }), _$p));
      return _el$;
    })();
  }

  function GameShop() {
    const [getGameShop] = useNetEventTable(t => t, 'game_shop', () => 'game_shop_' + getter_iLocalPlayer());
    const getRefreshEndTime = createMemo(() => {
      var _a;
      return (_a = getGameShop()) === null || _a === void 0 ? void 0 : _a.refresh_end_time;
    });
    const getRefreshCount = createMemo(() => {
      var _a;
      return (_a = getGameShop()) === null || _a === void 0 ? void 0 : _a.refresh_count;
    });
    const getFreeRefreshCount = createMemo(() => {
      var _a;
      return (_a = getGameShop()) === null || _a === void 0 ? void 0 : _a.free_refresh_count;
    });
    const getShopItems = createMemo(() => {
      var _a;
      return (_a = getGameShop()) === null || _a === void 0 ? void 0 : _a.shop_items;
    });
    const [getRefreshCost, setRefreshCost] = createSignal(0);
    const [getGameShopExp] = useNetEventTable(t => t, 'game_shop', () => 'exp_' + getter_iLocalPlayer());
    const getExp = () => {
      var _a;
      return ((_a = getGameShopExp()) === null || _a === void 0 ? void 0 : _a.cur) || 0;
    };
    const getMaxExp = () => {
      var _a;
      return ((_a = getGameShopExp()) === null || _a === void 0 ? void 0 : _a.lvlup) || 0;
    };
    const getLevel = () => {
      var _a;
      return ((_a = getGameShopExp()) === null || _a === void 0 ? void 0 : _a.lvl) || 0;
    };
    createEffect(() => {
      const iTimeID = GameTimer(() => {
        let fVal = Math.min(((getRefreshCount() || 0) + 1) * 50, 500) * (1 - AttributeKind$1.GameShopRefreshCostReduce.Get(getter_iPlayerSelectedHero()) * 0.01);
        setRefreshCost(Math.ceil(fVal));
        return 0.2;
      }, -1, undefined, 'GameShop');
      onCleanup(() => {
        StopTimer(iTimeID);
      });
    });
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_R];
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "GameShop",
          get ["class"]() {
            return classNames({
              'Show': getGameShop() != undefined
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        createElement("Panel", {
          "class": "TitleBG",
          hittest: false
        }, _el$);
        const _el$4 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$),
        _el$5 = createElement("Panel", {}, _el$4);
        createElement("Label", {
          "class": "GameShop",
          text: '#GameShop'
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$4),
        _el$8 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$7),
        _el$13 = createElement("Panel", {
          id: "GameShopExp"
        }, _el$4),
        _el$15 = createElement("Panel", {
          id: "GameShopLevel"
        }, _el$13);
        createElement("Panel", {
          "class": "BG"
        }, _el$15);
        const _el$17 = createElement("Label", {
          id: "GameShopLevelLabel",
          get text() {
            return getLevel();
          }
        }, _el$15);
      setProp(_el$5, "className", "Header");
      insert(_el$8, createComponent(Index, {
        get each() {
          return getShopItems();
        },
        children: (getShopItem, i) => {
          const getName = () => {
            var _a;
            return (_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.name;
          };
          const getKv = () => AbilitiesKv[getName()];
          const getRarity = () => {
            var _a;
            return (_a = getKv()) === null || _a === void 0 ? void 0 : _a.Rarity;
          };
          const getResType = () => {
            var _a;
            return (_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.cost_type;
          };
          const getSourcePrice = () => {
            var _a;
            return (_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.source_price;
          };
          const getDiscountPrice = () => {
            var _a;
            return ((_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.discount_price) || 0;
          };
          const getDiscount = () => {
            var _a;
            return (_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.discount;
          };
          const getIsFree = () => {
            if (getDiscount() != undefined) {
              return getDiscount() == 100;
            }
            return false;
          };
          const getResVal = () => {
            return FormatNumber(Math.floor(getDiscount() != undefined ? getDiscountPrice() : getSourcePrice()));
          };
          return (() => {
            const _el$18 = createElement("Panel", {
                get ["class"]() {
                  return classNames('ShopItemRow');
                },
                hittest: false
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$18);
              const _el$20 = createElement("Panel", {
                "class": "ItemGroup"
              }, _el$18);
            insert(_el$20, createComponent(Yzy_ItemImage, {
              get name() {
                return getName();
              },
              get rarity() {
                return getRarity();
              },
              onmouseover: p => {
                var _a;
                if (getName()) {
                  ShowTooltip(p, 'common_detail_tooltip', {
                    'sName': getName(),
                    'sTitle': $.Localize('#' + getName()),
                    'sRes': `${getResType()}=${getResVal()}`,
                    'tAttribute': Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a.AbilityValues) || {}).filter(k => k.substring(0, 3) == 'sx_').map(k => {
                      var _a, _b;
                      return `${k}=${(_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a.AbilityValues) === null || _b === void 0 ? void 0 : _b[k]}`;
                    }),
                    'sContext': $.Localize("#" + getName() + '_Description') != "#" + getName() + '_Description' ? ReplaceAbltVals(getName(), $.Localize("#" + getName() + '_Description')) : undefined
                  });
                }
              },
              onmouseout: HideTooltip,
              onactivate: () => {
                let iCost = getSourcePrice();
                if (getDiscount() != undefined) {
                  iCost = getDiscountPrice();
                }
                if (GetRes(getResType(), Players.GetLocalPlayer()) < iCost) return ErrorMsg(`error_not_enough_${getResType()}`);
                GameEvents.SendCustomGameEventToServer('GameShop_Buy', {
                  'index': i
                });
              }
            }), null);
            insert(_el$20, createComponent(Switch, {
              get children() {
                return [createComponent(Match, {
                  get when() {
                    return memo(() => !!getName())() && getIsFree();
                  },
                  get children() {
                    return createElement("Label", {
                      id: "Free",
                      text: 'Free',
                      hittest: false
                    }, null);
                  }
                }), createComponent(Match, {
                  get when() {
                    return getDiscount();
                  },
                  get children() {
                    const _el$22 = createElement("Label", {
                      id: "Discount",
                      get text() {
                        return `-${getDiscount()}%`;
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$22, "text", `-${getDiscount()}%`, _$p));
                    return _el$22;
                  }
                })];
              }
            }), null);
            insert(_el$18, createComponent(Show, {
              get when() {
                return getName() != undefined;
              },
              get children() {
                const _el$23 = createElement("Panel", {
                    "class": "CostPanel"
                  }, null),
                  _el$24 = createElement("Panel", {
                    id: "ResCost",
                    get ["class"]() {
                      return `${getResType()}`;
                    }
                  }, _el$23),
                  _el$25 = createElement("Image", {
                    "class": "ResIcon",
                    get src() {
                      return `file://{images}/custom_game/common/icon/icon_${getResType()}.png`;
                    },
                    scaling: 'stretch-to-fit-y-preserve-aspect'
                  }, _el$24),
                  _el$26 = createElement("Label", {
                    "class": "ResVal",
                    get text() {
                      return getResVal();
                    }
                  }, _el$24);
                effect(_p$ => {
                  const _v$3 = `${getResType()}`,
                    _v$4 = `file://{images}/custom_game/common/icon/icon_${getResType()}.png`,
                    _v$5 = getResVal();
                  _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$24, "class", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$25, "src", _v$4, _p$._v$4));
                  _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$26, "text", _v$5, _p$._v$5));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined,
                  _v$5: undefined
                });
                return _el$23;
              }
            }), null);
            effect(_$p => setProp(_el$18, "class", classNames('ShopItemRow'), _$p));
            return _el$18;
          })();
        }
      }));
      insert(_el$7, createComponent(KeybindButton, {
        id: "RefreshBtn",
        get key() {
          return getKeybind();
        },
        onmouseover: p => {
          ShowTooltip(p, 'common_detail_tooltip', {
            'sTitle': $.Localize('#GameShopRefreshBtnTitle'),
            'sImg': `file://{images}/custom_game/gamepack/refresh.png`,
            'sRes': `kill=${(getFreeRefreshCount() || 0) > 0 ? 0 : getRefreshCost()}`,
            'sContext': ReplaceTextVariable($.Localize("#GameShopRefreshBtnDes"), {
              val: 180,
              val1: 1
            })
          });
        },
        onmouseout: HideTooltip,
        onactivate: () => {
          if ((getFreeRefreshCount() || 0) <= 0) {
            if (GetRes("kill", Players.GetLocalPlayer()) < getRefreshCost()) {
              return ErrorMsg('error_not_enough_kill');
            }
          }
          GameEvents.SendCustomGameEventToServer('GameShop_Refresh', {});
        },
        get children() {
          return [(() => {
            const _el$9 = createElement("Panel", {
                "class": "Body"
              }, null),
              _el$0 = createElement("Image", {
                id: "ShopItemImage",
                src: `file://{images}/custom_game/gamepack/refresh.png`,
                scaling: 'stretch-to-fit-y-preserve-aspect'
              }, _el$9),
              _el$1 = createElement("Label", {
                "class": "HotKey",
                get text() {
                  return getKeybind();
                }
              }, _el$9);
            setProp(_el$0, "src", `file://{images}/custom_game/gamepack/refresh.png`);
            insert(_el$9, createComponent(Show, {
              get when() {
                return (getFreeRefreshCount() || 0) > 0;
              },
              get children() {
                const _el$10 = createElement("Panel", {
                    "class": "FreeRefresh"
                  }, null),
                  _el$11 = createElement("Label", {
                    "class": "Free",
                    get text() {
                      return `+${getFreeRefreshCount()}`;
                    }
                  }, _el$10);
                effect(_$p => setProp(_el$11, "text", `+${getFreeRefreshCount()}`, _$p));
                return _el$10;
              }
            }), null);
            effect(_$p => setProp(_el$1, "text", getKeybind(), _$p));
            return _el$9;
          })(), createComponent(Show, {
            get when() {
              return getRefreshEndTime() != undefined;
            },
            get children() {
              return createComponent(CountDown, {
                id: "CountDown",
                get fTimeEnd() {
                  return getRefreshEndTime();
                },
                get children() {
                  return createElement("Label", {
                    text: "#RefreshGameShopBtn"
                  }, null);
                }
              });
            }
          })];
        }
      }), null);
      insert(_el$13, createComponent(Yzy_ProgressBar, {
        get value() {
          return Clamp(getExp() / getMaxExp(), 0, 1) * 100;
        },
        get children() {
          const _el$14 = createElement("Label", {
            "class": "Value",
            get text() {
              return `${getExp()}/${getMaxExp()}`;
            }
          }, null);
          effect(_$p => setProp(_el$14, "text", `${getExp()}/${getMaxExp()}`, _$p));
          return _el$14;
        }
      }), _el$15);
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getGameShop() != undefined
          }),
          _v$2 = getLevel();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$17, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }

  function SelectionItemDrop16() {
    const [getData] = useNetEventTable(t => t, 'selection', () => `player_selection_${'item_drop_16'}_${getter_iLocalPlayer()}`);
    const [getShow, setShow] = createSignal(true);
    createEffect(() => {
      if (getData() != undefined) {
        setShow(true);
      }
    });
    return (() => {
      const _el$ = createElement("Panel", {
        id: "SelectionItemDrop16",
        get ["class"]() {
          return classNames({
            'Show': getShow()
          });
        },
        hittest: false
      }, null);
      insert(_el$, createComponent(FadeShow, {
        get data() {
          return getData();
        },
        fade_out: 1,
        fade_in: 2,
        onFadedOut: () => {
          var _a;
          if (((_a = getData()) === null || _a === void 0 ? void 0 : _a.options) == undefined) {
            setShow(false);
          }
        },
        bUseGameTime: false,
        children: data => {
          var _a, _b;
          return (() => {
            const _el$2 = createElement("Panel", {
                "class": "SelectRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$2);
              const _el$4 = createElement("Panel", {
                "class": "Header"
              }, _el$2);
              createElement("Label", {
                text: '#ItemDrop16Title'
              }, _el$4);
              const _el$6 = createElement("Panel", {
                "class": "Body",
                hittest: false
              }, _el$2);
            insert(_el$6, createComponent(Index, {
              get each() {
                return (_b = (_a = data()) === null || _a === void 0 ? void 0 : _a.options) !== null && _b !== void 0 ? _b : [];
              },
              children: (getOption, i) => {
                const getRewardData = () => getOption().data;
                const getID_a = () => getRewardData().sID_a;
                const getID_b = () => getRewardData().sID_b;
                const getVal = () => getRewardData().val;
                return (() => {
                  const _el$7 = createElement("Panel", {
                      "class": 'SelectionRow'
                    }, null);
                    createElement("Panel", {
                      "class": "BG"
                    }, _el$7);
                    const _el$9 = createElement("Panel", {
                      "class": "Body"
                    }, _el$7),
                    _el$0 = createElement("Label", {
                      get text() {
                        return ReplaceTextVariable('#ItemDrop16Des', {
                          'id_a': ColorText($.Localize("#" + getID_a()), {
                            '10600007': '#ff0000',
                            '10600012': '#00ff00',
                            '10600017': '#00ffff'
                          }[getID_a()]),
                          'id_b': ColorText($.Localize("#" + getID_b()), {
                            '10600007': '#ff0000',
                            '10600012': '#00ff00',
                            '10600017': '#00ffff'
                          }[getID_b()]),
                          'val': getVal()
                        });
                      },
                      html: true
                    }, _el$9);
                  setProp(_el$7, "onactivate", () => {
                    if (getData()) {
                      GameEvents.SendCustomGameEventToServer('player_selection_selected', {
                        'id': getData().id,
                        'index': i
                      });
                    }
                  });
                  effect(_$p => setProp(_el$0, "text", ReplaceTextVariable('#ItemDrop16Des', {
                    'id_a': ColorText($.Localize("#" + getID_a()), {
                      '10600007': '#ff0000',
                      '10600012': '#00ff00',
                      '10600017': '#00ffff'
                    }[getID_a()]),
                    'id_b': ColorText($.Localize("#" + getID_b()), {
                      '10600007': '#ff0000',
                      '10600012': '#00ff00',
                      '10600017': '#00ffff'
                    }[getID_b()]),
                    'val': getVal()
                  }), _$p));
                  return _el$7;
                })();
              }
            }));
            return _el$2;
          })();
        }
      }));
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': getShow()
      }), _$p));
      return _el$;
    })();
  }

  let ref;
  function CardPack() {
    const [getCardSelected] = useNetEventTable(t => t, 'card', () => "selected_" + getter_iLocalPlayer());
    return (() => {
      const _el$ = createElement("Panel", {
          id: "CardPack",
          get ["class"]() {
            return classNames({
              'Show': Entities.IsRealHero(getter_iSelectUnit())
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$),
        _el$4 = createElement("Panel", {
          "class": "CardList",
          hittest: false
        }, _el$3),
        _el$5 = createElement("Panel", {
          "class": "CardDrawBtn"
        }, _el$3);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$4) : ref = _el$4;
      insert(_el$4, createComponent(Index, {
        get each() {
          return getCardSelected() || [];
        },
        children: (getData, i) => {
          var _a, _b;
          const getName = () => getData().name;
          const getPolymerID = () => getData().iPolymerID;
          const [getCard, setCard] = createSignal();
          createEffect(on(getCardSelected, () => {
            const bind = NetEventData.BindDo('diy_polymer', '', tTable => {
              if ((tTable === null || tTable === void 0 ? void 0 : tTable.id) == getPolymerID()) {
                setCard(tTable);
              }
            });
            onCleanup(() => {
              NetEventData.Unbind(bind, 'diy_polymer', '');
            });
          }));
          const getCardData = createMemo(() => {
            var _a;
            return (_a = getCard()) === null || _a === void 0 ? void 0 : _a.data;
          });
          const getKv = () => AbilitiesKv[getName()];
          const getInterval = () => {
            var _a, _b;
            const fBaseCooldown = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b['cooldown'];
            if (fBaseCooldown != undefined) {
              const fCooldown = AttributeKind$1.Cooldown.Get(getter_iPlayerSelectedHero());
              const fVal = fBaseCooldown * (1 - fCooldown / (fCooldown + 300));
              const fMin = fBaseCooldown * (1 - 1200 / (1200 + 300));
              return Math.max(fVal, fMin);
            }
          };
          const getEndTime = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.fEndTime;
          };
          const getKillCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iKillCount;
          };
          const getLevelUpCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iLevelUpCount;
          };
          const getGainCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iGainCount;
          };
          const getGainTime = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iGainTime;
          };
          const getCostGold = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iCostGold;
          };
          const getCostKill = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iCostKill;
          };
          const getDevourCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iDevourCount;
          };
          const getCastCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iCastCount;
          };
          const getAtkCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iAtkCount;
          };
          const getBaseCount = () => {
            var _a;
            return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iBaseCount;
          };
          const getCombinationName = () => {
            var _a, _b, _c, _d, _e;
            if ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Combination']) {
              return (_b = getKv()) === null || _b === void 0 ? void 0 : _b['Combination'];
            }
            return (_e = (_d = ((_c = getKv()) === null || _c === void 0 ? void 0 : _c['Tag']) || '') === null || _d === void 0 ? void 0 : _d.split(',')) === null || _e === void 0 ? void 0 : _e[0];
          };
          return (() => {
            const _el$6 = createElement("Panel", {
                id: `CardRow_${i}`,
                get ["class"]() {
                  return classNames('CardRow');
                }
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$6);
              const _el$8 = createElement("Panel", {
                "class": "Body"
              }, _el$6);
            setProp(_el$6, "id", `CardRow_${i}`);
            setProp(_el$6, "onload", p => {
              Timer(() => {
                const vAbsPos = p.GetPositionWithinWindow();
                if (vAbsPos.x == Infinity || vAbsPos.y == Infinity) {
                  return 0.1;
                }
                const vPos = [vAbsPos.x / p.actualuiscale_x, vAbsPos.y / p.actualuiscale_y, 0];
                GameUI.CustomUIConfig()[`CardRow_${i}`] = vPos;
              }, 0.1);
            });
            insert(_el$8, createComponent(Show, {
              get when() {
                return getName() != undefined;
              },
              get children() {
                return [createComponent(Yzy_ItemImage, {
                  get name() {
                    return getName();
                  },
                  onmouseover: p => {
                    ShowTooltip(p, 'card_tooltip', {
                      'sCardName': getName()
                    });
                  },
                  onmouseout: HideTooltip
                }), createComponent(Show, {
                  get when() {
                    return memo(() => getEndTime() != undefined)() && getEndTime() > Game.GetGameTime();
                  },
                  get children() {
                    return createComponent(CooldownPanel, {
                      fEnd: getEndTime,
                      get fCD() {
                        return getInterval();
                      },
                      bShine: true,
                      hittest: false
                    });
                  }
                }), createComponent(Show, {
                  get when() {
                    return getCombinationName() != undefined;
                  },
                  get children() {
                    return createComponent(Yzy_ItemName, {
                      get name() {
                        return getCombinationName();
                      }
                    });
                  }
                }), createComponent(Show, {
                  get when() {
                    return memo(() => getCard() != undefined)() && ((_a = getCard()) === null || _a === void 0 ? void 0 : _a.stack) != 0;
                  },
                  get children() {
                    const _el$9 = createElement("Label", {
                      id: "CardStack",
                      get text() {
                        return (_b = getCard()) === null || _b === void 0 ? void 0 : _b.stack;
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$9, "text", (_b = getCard()) === null || _b === void 0 ? void 0 : _b.stack, _$p));
                    return _el$9;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getKillCount() > 0;
                  },
                  get children() {
                    const _el$0 = createElement("Label", {
                      id: "KillCount",
                      get text() {
                        return getKillCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$0, "text", getKillCount(), _$p));
                    return _el$0;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getLevelUpCount() > 0;
                  },
                  get children() {
                    const _el$1 = createElement("Label", {
                      id: "LevelUpCount",
                      get text() {
                        return getLevelUpCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$1, "text", getLevelUpCount(), _$p));
                    return _el$1;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getGainCount() > 0;
                  },
                  get children() {
                    const _el$10 = createElement("Label", {
                      id: "GainCount",
                      get text() {
                        return getGainCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$10, "text", getGainCount(), _$p));
                    return _el$10;
                  }
                }), createComponent(Show, {
                  get when() {
                    return memo(() => getGainTime() != undefined)() && getGainTime() > Game.GetGameTime();
                  },
                  get children() {
                    return createComponent(CountDown, {
                      get fTimeEnd() {
                        return getGainTime();
                      },
                      get children() {
                        return createElement("Label", {
                          id: "GainTime",
                          text: "{s:countdown_time}"
                        }, null);
                      }
                    });
                  }
                }), createComponent(Show, {
                  get when() {
                    return getCostGold() > 0;
                  },
                  get children() {
                    const _el$12 = createElement("Label", {
                      id: "CostGold",
                      get text() {
                        return getCostGold();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$12, "text", getCostGold(), _$p));
                    return _el$12;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getCostKill() > 0;
                  },
                  get children() {
                    const _el$13 = createElement("Label", {
                      id: "CostKill",
                      get text() {
                        return getCostKill();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$13, "text", getCostKill(), _$p));
                    return _el$13;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getDevourCount() > 0;
                  },
                  get children() {
                    const _el$14 = createElement("Label", {
                      id: "DevourCount",
                      get text() {
                        return getDevourCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$14, "text", getDevourCount(), _$p));
                    return _el$14;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getCastCount() > 0;
                  },
                  get children() {
                    const _el$15 = createElement("Label", {
                      id: "CastCount",
                      get text() {
                        return getCastCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$15, "text", getCastCount(), _$p));
                    return _el$15;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getAtkCount() > 0;
                  },
                  get children() {
                    const _el$16 = createElement("Label", {
                      id: "AtkCount",
                      get text() {
                        return getAtkCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$16, "text", getAtkCount(), _$p));
                    return _el$16;
                  }
                }), createComponent(Show, {
                  get when() {
                    return getBaseCount() > 0;
                  },
                  get children() {
                    const _el$17 = createElement("Label", {
                      id: "Count",
                      get text() {
                        return getBaseCount();
                      },
                      hittest: false
                    }, null);
                    effect(_$p => setProp(_el$17, "text", getBaseCount(), _$p));
                    return _el$17;
                  }
                })];
              }
            }));
            effect(_$p => setProp(_el$6, "class", classNames('CardRow'), _$p));
            return _el$6;
          })();
        }
      }));
      insert(_el$5, createComponent(CardBtn, {
        getEntID: getter_iSelectUnit
      }));
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': Entities.IsRealHero(getter_iSelectUnit())
      }), _$p));
      return _el$;
    })();
  }
  function GetCardPositionByIndex(iIndex) {
    let vPos = [0, 0, 0];
    if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
      const pRow = ref.FindChild(`CardRow_${iIndex}`);
      if (pRow === null || pRow === void 0 ? void 0 : pRow.IsValid()) {
        const vAbsPos = pRow.GetPositionWithinWindow();
        if (vAbsPos.x != Infinity && vAbsPos.y != Infinity) {
          vPos = [vAbsPos.x / pRow.actualuiscale_x, vAbsPos.y / pRow.actualuiscale_y, 0];
        }
      }
    }
    return vPos;
  }

  function SelectionCard() {
    createSignal(false);
    const [getCardSelected] = useNetEventTable(t => t, 'card', () => 'selected_' + getter_iLocalPlayer());
    const [getCardDevour] = useNetEventTable(t => t, 'card', () => 'devour_' + getter_iLocalPlayer());
    const [getData] = useNetEventTable(t => t, 'card', () => 'select_' + getter_iLocalPlayer());
    const [getCardFreeRefreshCount] = useNetEventTable(t => t, 'card', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const [getCardRefreshCount] = useNetEventTable(t => t, 'card', () => 'refresh_count_' + getter_iLocalPlayer());
    const getRefreshText = createMemo(() => {
      var _a, _b, _c;
      if ((getCardFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getCardFreeRefreshCount() || 0);
      }
      return ReplaceTextVariable('#CardRefreshCount', Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['CardSelectionRefreshBaseCost']) || 0) + (getCardRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['CardSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['CardSelectionRefreshMaxCost']) || 0));
    });
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      if (getData() != undefined) {
        setShow(true);
      }
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_CARD_SELECTION_TOGGLE', event => {
        setShow(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_CARD_SELECTION_TOGGLE', id);
      });
    });
    return createComponent(FadeShow, {
      get data() {
        return getData();
      },
      fade_out: 1,
      onFadedOut: () => {
        if (getData() == undefined) {
          setShow(false);
        }
      },
      bUseGameTime: true,
      children: getData => (() => {
        const _el$ = createElement("Panel", {
            id: "CardSelection",
            get ["class"]() {
              return classNames({
                'Show': getShow()
              });
            }
          }, null),
          _el$2 = createElement("Panel", {
            "class": "Body"
          }, _el$),
          _el$3 = createElement("Panel", {
            "class": "BottomPanel"
          }, _el$),
          _el$4 = createElement("TextButton", {
            id: "CloseBtn",
            text: "#ChooseLaterBtn"
          }, _el$3),
          _el$5 = createElement("Panel", {
            "class": "Group"
          }, _el$3);
          createElement("Label", {
            id: "GiveUpCardSelectDes",
            text: '#GiveUpCardSelectDes'
          }, _el$5);
          const _el$7 = createElement("TextButton", {
            id: "GiveUpBtn",
            text: "#GiveUpBtn"
          }, _el$5),
          _el$8 = createElement("TextButton", {
            id: "RefreshBtn",
            get text() {
              return getRefreshText();
            },
            html: true
          }, _el$3);
        insert(_el$2, createComponent(Index, {
          get each() {
            return getData();
          },
          children: (getName, i) => {
            const getKv = () => AbilitiesKv[getName()];
            const getRarity = () => {
              var _a;
              return ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) || 0;
            };
            const getAttributeValues = () => {
              var _a;
              const tAttributeKey = [];
              Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
                if (sKey.substring(0, 3) == 'sx_') {
                  tAttributeKey.push(sKey);
                }
              });
              return tAttributeKey;
            };
            const getDescription = () => {
              if ($.Localize('#' + getName() + '_Description') != '#' + getName() + '_Description') {
                return ReplaceAbltVals(getName(), $.Localize("#" + getName() + '_Description'));
              }
            };
            const getCombinationName = () => {
              var _a, _b, _c;
              if ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Combination']) {
                return (_b = getKv()) === null || _b === void 0 ? void 0 : _b['Combination'];
              }
              return ((_c = getKv()) === null || _c === void 0 ? void 0 : _c['Tag']).split(',')[0];
            };
            const getCombinationKv = () => AbilitiesKv[getCombinationName()];
            const getCombinationAttributeValues = () => {
              var _a;
              const tAttributeKey = [];
              Object.keys(((_a = getCombinationKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
                if (sKey.substring(0, 3) == 'sx_') {
                  tAttributeKey.push(sKey);
                }
              });
              return tAttributeKey;
            };
            const getCombinationDescription = () => {
              if ($.Localize('#' + getCombinationName() + '_Description') != '#' + getCombinationName() + '_Description') {
                return ReplaceAbltVals(getCombinationName(), $.Localize("#" + getCombinationName() + '_Description'));
              }
            };
            const getCombinationList = () => {
              var _a, _b;
              return ((_b = (_a = getCombinationKv()) === null || _a === void 0 ? void 0 : _a['CombinationList']) === null || _b === void 0 ? void 0 : _b.split("|")) || [];
            };
            const getActiveCombinationCount = () => {
              var _a, _b;
              let iCount = 0;
              const tSelectedNames = [];
              for (const tCardData of (_a = getCardSelected()) !== null && _a !== void 0 ? _a : []) {
                if (tCardData.name) {
                  tSelectedNames.push(tCardData.name);
                }
              }
              for (const sCardName of getCombinationList()) {
                if ((tSelectedNames === null || tSelectedNames === void 0 ? void 0 : tSelectedNames.includes(sCardName)) || ((_b = getCardDevour()) === null || _b === void 0 ? void 0 : _b.includes(sCardName))) {
                  iCount++;
                }
              }
              return iCount;
            };
            const [getSend, setSend] = createSignal(true);
            return (() => {
              const _el$9 = createElement("Panel", {
                  "class": "CardRow"
                }, null),
                _el$0 = createElement("Panel", {
                  "class": "BG",
                  get style() {
                    return {
                      backgroundImage: `url("file://{images}/custom_game/selections/card/bg_${getRarity() - 1}.png")`
                    };
                  }
                }, _el$9),
                _el$1 = createElement("Panel", {
                  "class": "Body"
                }, _el$9),
                _el$15 = createElement("Panel", {
                  "class": "Group"
                }, _el$1),
                _el$16 = createElement("Panel", {
                  id: "CardEffect"
                }, _el$15);
              setProp(_el$9, "onactivate", p => {
                const tSelected = NetEventData.GetTableValue('card', 'selected_' + getter_iLocalPlayer()) || [];
                const iIndex = tSelected.findIndex(k => k.name == undefined && k.iPolymerID == undefined);
                let vEndPos = undefined;
                if (iIndex != -1) {
                  vEndPos = GetCardPositionByIndex(iIndex);
                }
                const vStartPos = [(p.GetPositionWithinWindow().x + p.actuallayoutwidth / 2) / p.actualuiscale_x, (p.GetPositionWithinWindow().y + p.actuallayoutheight / 2) / p.actualuiscale_y, 0];
                if (getSend()) {
                  setSend(false);
                  GameEvents.SendCustomGameEventToServer('OnCardSelected', {
                    'name': getName(),
                    'vStartPos': vStartPos,
                    'vEndPos': vEndPos
                  });
                }
              });
              insert(_el$1, createComponent(Show, {
                get when() {
                  return getCombinationName() != undefined;
                },
                get children() {
                  const _el$10 = createElement("Panel", {
                      id: "CombinationTitle"
                    }, null);
                    createElement("Panel", {
                      "class": "BG"
                    }, _el$10);
                    const _el$12 = createElement("Panel", {
                      "class": "Group"
                    }, _el$10),
                    _el$13 = createElement("Label", {
                      id: "Name",
                      get text() {
                        return '#' + getCombinationName();
                      },
                      html: true
                    }, _el$12);
                  insert(_el$12, createComponent(Show, {
                    get when() {
                      return getCombinationList().length > 0;
                    },
                    get children() {
                      const _el$14 = createElement("Label", {
                        id: "Count",
                        get ["class"]() {
                          return classNames({
                            'HasCount': getActiveCombinationCount() > 0
                          });
                        },
                        get text() {
                          return `(${getActiveCombinationCount()}/${getCombinationList().length})`;
                        },
                        html: true
                      }, null);
                      effect(_p$ => {
                        const _v$3 = classNames({
                            'HasCount': getActiveCombinationCount() > 0
                          }),
                          _v$4 = `(${getActiveCombinationCount()}/${getCombinationList().length})`;
                        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$14, "class", _v$3, _p$._v$3));
                        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$14, "text", _v$4, _p$._v$4));
                        return _p$;
                      }, {
                        _v$3: undefined,
                        _v$4: undefined
                      });
                      return _el$14;
                    }
                  }), null);
                  effect(_$p => setProp(_el$13, "text", '#' + getCombinationName(), _$p));
                  return _el$10;
                }
              }), _el$15);
              insert(_el$1, createComponent(Yzy_ItemImage, {
                get name() {
                  return getName();
                },
                get rarity() {
                  return getRarity();
                },
                hittest: false
              }), _el$15);
              insert(_el$1, createComponent(Yzy_ItemName, {
                get name() {
                  return getName();
                },
                get rarity() {
                  return getRarity();
                }
              }), _el$15);
              insert(_el$16, createComponent(Show, {
                get when() {
                  return getAttributeValues().length > 0;
                },
                get children() {
                  const _el$17 = createElement("Panel", {
                    id: "AttributeBox"
                  }, null);
                  insert(_el$17, () => Object.values(getAttributeValues()).map((sKey, i) => {
                    var _a, _b, _c;
                    const sAttributeID = sKey.substring(3);
                    const fVal = (_c = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey]) !== null && _c !== void 0 ? _c : 0;
                    return createComponent(Yzy_Attribute, {
                      id: sAttributeID,
                      val: fVal
                    });
                  }));
                  return _el$17;
                }
              }), null);
              insert(_el$16, createComponent(Show, {
                get when() {
                  return getDescription() != undefined;
                },
                get children() {
                  return createComponent(Yzy_Description, {
                    get name() {
                      return getName();
                    }
                  });
                }
              }), null);
              insert(_el$15, createComponent(Show, {
                get when() {
                  return getCombinationAttributeValues().length > 0 || getCombinationDescription() != undefined;
                },
                get children() {
                  const _el$18 = createElement("Panel", {
                      id: "CombinationEffect"
                    }, null);
                    createElement("Label", {
                      id: "CombinationTitle",
                      text: '#CardCombinationEffectTitle',
                      html: true
                    }, _el$18);
                  insert(_el$18, createComponent(Show, {
                    get when() {
                      return getCombinationAttributeValues().length > 0;
                    },
                    get children() {
                      const _el$20 = createElement("Panel", {
                        id: "CombinationAttributeBox"
                      }, null);
                      insert(_el$20, () => Object.values(getCombinationAttributeValues()).map((sKey, i) => {
                        var _a, _b, _c;
                        const sAttributeID = sKey.substring(3);
                        const fVal = (_c = (_b = (_a = getCombinationKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey]) !== null && _c !== void 0 ? _c : 0;
                        return createComponent(Yzy_Attribute, {
                          id: sAttributeID,
                          val: fVal
                        });
                      }));
                      return _el$20;
                    }
                  }), null);
                  insert(_el$18, createComponent(Show, {
                    get when() {
                      return getCombinationDescription() != undefined;
                    },
                    get children() {
                      return createComponent(Yzy_Description, {
                        get name() {
                          return getCombinationName();
                        }
                      });
                    }
                  }), null);
                  return _el$18;
                }
              }), null);
              effect(_$p => setProp(_el$0, "style", {
                backgroundImage: `url("file://{images}/custom_game/selections/card/bg_${getRarity() - 1}.png")`
              }, _$p));
              return _el$9;
            })();
          }
        }));
        setProp(_el$4, "onactivate", p => {
          EventManager.Fire('ON_CARD_SELECTION_TOGGLE', {
            'open': false
          });
        });
        setProp(_el$7, "onactivate", p => {
          GameEvents.SendCustomGameEventToServer('OnCardGiveUpSelect', {});
        });
        setProp(_el$8, "onactivate", p => {
          var _a, _b, _c;
          if ((getCardFreeRefreshCount() || 0) <= 0) {
            const iRefreshCost = Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['CardSelectionRefreshBaseCost']) || 0) + (getCardRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['CardSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['CardSelectionRefreshMaxCost']) || 0);
            if (iRefreshCost > GetRes("wood", getter_iLocalPlayer())) return ErrorMsg(`error_not_enough_${"wood"}`);
          }
          GameEvents.SendCustomGameEventToServer('OnCardRefresh', {});
        });
        effect(_p$ => {
          const _v$ = classNames({
              'Show': getShow()
            }),
            _v$2 = getRefreshText();
          _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined
        });
        return _el$;
      })()
    });
  }

  function ReplaceCard() {
    const [getCardSelected] = useNetEventTable(t => t, 'card', () => 'selected_' + getter_iLocalPlayer());
    const [getData] = useNetEventTable(t => t || [], 'card', () => 'select_replace_' + getter_iLocalPlayer());
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      if (getData() != undefined && getData().length > 0) {
        setShow(true);
      }
    });
    return createComponent(FadeShow, {
      get data() {
        return memo(() => getData().length > 0)() ? getData() : undefined;
      },
      fade_out: 1,
      onFadedOut: () => {
        if (getData() == undefined || getData().length == 0) {
          setShow(false);
        }
      },
      bUseGameTime: true,
      children: getData => (() => {
        const _el$ = createElement("Panel", {
            id: "ReplaceCard"
          }, null);
          createElement("Panel", {
            "class": "BG"
          }, _el$);
          const _el$3 = createElement("Panel", {
            "class": "Body"
          }, _el$),
          _el$4 = createElement("Panel", {
            "class": "Header"
          }, _el$3);
          createElement("Panel", {
            "class": "BG"
          }, _el$4);
          createElement("Label", {
            id: "Title",
            text: '#ReplaceCardTitle'
          }, _el$4);
          const _el$7 = createElement("Panel", {
            "class": "Body"
          }, _el$3),
          _el$8 = createElement("Panel", {
            "class": "Operate"
          }, _el$3),
          _el$9 = createElement("TextButton", {
            id: "CloseBtn",
            text: "#CancelBtn"
          }, _el$8);
        insert(_el$3, createComponent(Show, {
          get when() {
            return memo(() => getData() != undefined)() && getData().length > 0;
          },
          get children() {
            return createComponent(Yzy_ItemImage, {
              get name() {
                return getData()[0];
              },
              onmouseover: p => {
                ShowTooltip(p, 'card_tooltip', {
                  'sCardName': getData()[0]
                });
              },
              onmouseout: HideTooltip
            });
          }
        }), _el$7);
        insert(_el$7, createComponent(Index, {
          get each() {
            return getCardSelected() || [];
          },
          children: (getData, i) => {
            var _a, _b;
            const getName = () => getData().name;
            const getPolymerID = () => getData().iPolymerID;
            const [getCard, setCard] = createSignal();
            createEffect(on(getCardSelected, () => {
              const bind = NetEventData.BindDo('diy_polymer', '', tTable => {
                if ((tTable === null || tTable === void 0 ? void 0 : tTable.id) == getPolymerID()) {
                  setCard(tTable);
                }
              });
              onCleanup(() => {
                NetEventData.Unbind(bind, 'diy_polymer', '');
              });
            }));
            const getCardData = createMemo(() => {
              var _a;
              return (_a = getCard()) === null || _a === void 0 ? void 0 : _a.data;
            });
            const getKv = () => AbilitiesKv[getName()];
            const getInterval = () => {
              var _a, _b;
              const fBaseCooldown = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b['cooldown'];
              if (fBaseCooldown != undefined) {
                const fCooldown = AttributeKind$1.Cooldown.Get(getter_iPlayerSelectedHero());
                const fVal = fBaseCooldown * (1 - fCooldown / (fCooldown + 300));
                const fMin = fBaseCooldown * (1 - 1200 / (1200 + 300));
                return Math.max(fVal, fMin);
              }
            };
            const getEndTime = () => {
              var _a;
              return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.fEndTime;
            };
            const getKillCount = () => {
              var _a;
              return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iKillCount;
            };
            const getGainCount = () => {
              var _a;
              return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iGainCount;
            };
            const getGainTime = () => {
              var _a;
              return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iGainTime;
            };
            const getDevourCount = () => {
              var _a;
              return (_a = getCardData()) === null || _a === void 0 ? void 0 : _a.iDevourCount;
            };
            const getCombinationName = () => {
              var _a, _b, _c, _d, _e;
              if ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Combination']) {
                return (_b = getKv()) === null || _b === void 0 ? void 0 : _b['Combination'];
              }
              return (_e = (_d = ((_c = getKv()) === null || _c === void 0 ? void 0 : _c['Tag']) || '') === null || _d === void 0 ? void 0 : _d.split(',')) === null || _e === void 0 ? void 0 : _e[0];
            };
            const getIsCanReplace = () => {
              var _a;
              return ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['ReplaceState']) != 1;
            };
            return (() => {
              const _el$0 = createElement("Panel", {
                  get ["class"]() {
                    return classNames('CardRow');
                  }
                }, null);
                createElement("Panel", {
                  "class": "BG"
                }, _el$0);
                const _el$10 = createElement("Panel", {
                  "class": "Body"
                }, _el$0);
              setProp(_el$0, "onactivate", p => {
                const vAbovePos = p.GetPositionWithinWindow();
                const vStartPos = [vAbovePos.x / p.actualuiscale_x, vAbovePos.y / p.actualuiscale_y, 0];
                GameEvents.SendCustomGameEventToServer('OnCardReplace', {
                  'index': i,
                  'vStartPos': vStartPos,
                  'vEndPos': GetCardPositionByIndex(i)
                });
              });
              insert(_el$10, createComponent(Show, {
                get when() {
                  return getName() != undefined;
                },
                get children() {
                  return [createComponent(Yzy_ItemImage, {
                    get name() {
                      return getName();
                    },
                    onmouseover: p => {
                      ShowTooltip(p, 'card_tooltip', {
                        'sCardName': getName()
                      });
                    },
                    onmouseout: HideTooltip,
                    onactivate: p => {
                      const vAbovePos = p.GetPositionWithinWindow();
                      const vStartPos = [vAbovePos.x / p.actualuiscale_x, vAbovePos.y / p.actualuiscale_y, 0];
                      GameEvents.SendCustomGameEventToServer('OnCardReplace', {
                        'index': i,
                        'vStartPos': vStartPos,
                        'vEndPos': GetCardPositionByIndex(i)
                      });
                    }
                  }), createComponent(Show, {
                    get when() {
                      return getCombinationName() != undefined;
                    },
                    get children() {
                      return createComponent(Yzy_ItemName, {
                        get name() {
                          return getCombinationName();
                        }
                      });
                    }
                  }), createComponent(Show, {
                    get when() {
                      return memo(() => getEndTime() != undefined)() && getEndTime() > Game.GetGameTime();
                    },
                    get children() {
                      return createComponent(CooldownPanel, {
                        fEnd: getEndTime,
                        get fCD() {
                          return getInterval();
                        },
                        bShine: true,
                        hittest: false
                      });
                    }
                  }), createComponent(Show, {
                    get when() {
                      return memo(() => getCard() != undefined)() && ((_a = getCard()) === null || _a === void 0 ? void 0 : _a.stack) != 0;
                    },
                    get children() {
                      const _el$11 = createElement("Label", {
                        id: "CardStack",
                        get text() {
                          return (_b = getCard()) === null || _b === void 0 ? void 0 : _b.stack;
                        },
                        hittest: false
                      }, null);
                      effect(_$p => setProp(_el$11, "text", (_b = getCard()) === null || _b === void 0 ? void 0 : _b.stack, _$p));
                      return _el$11;
                    }
                  }), createComponent(Show, {
                    get when() {
                      return getKillCount() > 0;
                    },
                    get children() {
                      const _el$12 = createElement("Label", {
                        id: "KillCount",
                        get text() {
                          return getKillCount();
                        },
                        hittest: false
                      }, null);
                      effect(_$p => setProp(_el$12, "text", getKillCount(), _$p));
                      return _el$12;
                    }
                  }), createComponent(Show, {
                    get when() {
                      return getGainCount() > 0;
                    },
                    get children() {
                      const _el$13 = createElement("Label", {
                        id: "GainCount",
                        get text() {
                          return getGainCount();
                        },
                        hittest: false
                      }, null);
                      effect(_$p => setProp(_el$13, "text", getGainCount(), _$p));
                      return _el$13;
                    }
                  }), createComponent(Show, {
                    get when() {
                      return memo(() => getGainTime() != undefined)() && getGainTime() > Game.GetGameTime();
                    },
                    get children() {
                      return createComponent(CountDown, {
                        get fTimeEnd() {
                          return getGainTime();
                        },
                        get children() {
                          return createElement("Label", {
                            id: "GainTime",
                            text: "{s:countdown_time}"
                          }, null);
                        }
                      });
                    }
                  }), createComponent(Show, {
                    get when() {
                      return getDevourCount() > 0;
                    },
                    get children() {
                      const _el$15 = createElement("Label", {
                        id: "DevourCount",
                        get text() {
                          return getDevourCount();
                        },
                        hittest: false
                      }, null);
                      effect(_$p => setProp(_el$15, "text", getDevourCount(), _$p));
                      return _el$15;
                    }
                  }), createComponent(Show, {
                    get when() {
                      return !getIsCanReplace();
                    },
                    get children() {
                      return createElement("Label", {
                        id: "NoReplace",
                        text: '#NoReplace'
                      }, null);
                    }
                  })];
                }
              }));
              effect(_$p => setProp(_el$0, "class", classNames('CardRow'), _$p));
              return _el$0;
            })();
          }
        }));
        setProp(_el$9, "onactivate", p => {
          GameEvents.SendCustomGameEventToServer('OnCardGiveUpReplace', {});
        });
        return _el$;
      })()
    });
  }

  const CfgGetter_adventure_affix = useSystemConfig('adventure_affix');

  function SelectionAdventure() {
    const [getOpen, setOpen] = createSignal(false);
    const [getAdventureSelect] = useNetEventTable(t => t, 'adventure', () => 'select_' + getter_iLocalPlayer());
    const getRarity = () => {
      var _a, _b;
      return ((_b = (_a = CfgGetter_adventure_affix()) === null || _a === void 0 ? void 0 : _a[getAdventureSelect()]) === null || _b === void 0 ? void 0 : _b.Rarity) || 1;
    };
    createEffect(() => {
      const id = EventManager.Reg('ON_ADVENTURE_TOGGLE', event => {
        print('event.open:', event.open);
        setOpen(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_ADVENTURE_TOGGLE', id);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "AdventureSelection",
          get ["class"]() {
            return classNames({
              'Show': getOpen() && getAdventureSelect() != undefined
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        const _el$5 = createElement("Panel", {
          "class": "Header"
        }, _el$3);
        createElement("Label", {
          text: '#AdventureTitle'
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$8 = createElement("Panel", {
          "class": "Body"
        }, _el$7);
        createElement("Panel", {
          "class": "BG"
        }, _el$8);
        const _el$0 = createElement("Panel", {
          "class": "Name"
        }, _el$8),
        _el$1 = createElement("Label", {
          get text() {
            return '#' + getAdventureSelect();
          }
        }, _el$0),
        _el$12 = createElement("Label", {
          "class": "RarityText",
          get text() {
            return `#AdventureRarity_${getRarity()}`;
          }
        }, _el$8),
        _el$13 = createElement("Panel", {
          "class": "Bottom"
        }, _el$3),
        _el$14 = createElement("Panel", {
          "class": "Group"
        }, _el$13),
        _el$15 = createElement("TextButton", {
          id: "LaterBtn",
          text: "#ChooseLaterBtn"
        }, _el$14),
        _el$16 = createElement("TextButton", {
          id: "SureBtn",
          text: "#SureAdventureBtn"
        }, _el$14),
        _el$17 = createElement("TextButton", {
          id: "CloseBtn",
          get text() {
            return `${$.Localize('#CancelAdventureBtn')}, ${$.Localize('#CancelAdventureBtnDesc')}`;
          }
        }, _el$13);
      insert(_el$8, createComponent(Show, {
        get when() {
          return getAdventureSelect();
        },
        get children() {
          const _el$10 = createElement("Panel", {
              "class": "Description"
            }, null),
            _el$11 = createElement("Label", {
              get text() {
                return ReplaceAbltVals(getAdventureSelect(), $.Localize("#" + getAdventureSelect() + '_Description'));
              },
              html: true
            }, _el$10);
          effect(_$p => setProp(_el$11, "text", ReplaceAbltVals(getAdventureSelect(), $.Localize("#" + getAdventureSelect() + '_Description')), _$p));
          return _el$10;
        }
      }), _el$12);
      setProp(_el$15, "onactivate", p => {
        EventManager.Fire('ON_ADVENTURE_TOGGLE', {
          'open': false
        });
      });
      setProp(_el$16, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnAdventureSelected', {
          'name': getAdventureSelect()
        });
      });
      setProp(_el$17, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnAdventureGiveUpSelect', {});
      });
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getOpen() && getAdventureSelect() != undefined
          }),
          _v$2 = '#' + getAdventureSelect(),
          _v$3 = `#AdventureRarity_${getRarity()}`,
          _v$4 = `${$.Localize('#CancelAdventureBtn')}, ${$.Localize('#CancelAdventureBtnDesc')}`;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$1, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$12, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$17, "text", _v$4, _p$._v$4));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined
      });
      return _el$;
    })();
  }

  function SelectionHalidom() {
    const [getHalidomSelection] = useNetEventTable(t => t, 'halidom', () => 'select_' + getter_iLocalPlayer());
    const [getHalidomRefreshCount] = useNetEventTable(t => t, 'halidom', () => 'refresh_count_' + getter_iLocalPlayer());
    const [getHalidomFreeRefreshCount] = useNetEventTable(t => t, 'halidom', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const getRefreshText = createMemo(() => {
      var _a, _b, _c;
      if ((getHalidomFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getHalidomFreeRefreshCount() || 0);
      }
      let iRefreshCost = Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['HalidomSelectionRefreshBaseCost']) || 0) + (getHalidomRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['HalidomSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['HalidomSelectionRefreshMaxCost']) || 0);
      return ReplaceTextVariable('#RefreshCount', iRefreshCost);
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "HalidomSelection",
          get ["class"]() {
            return classNames({
              'Show': getHalidomSelection() != undefined
            });
          }
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Body"
        }, _el$);
      insert(_el$2, createComponent(Index, {
        get each() {
          return getHalidomSelection();
        },
        children: (getName, i) => {
          const getKv = () => AbilitiesKv[getName()];
          const getAttributeValues = () => {
            var _a;
            const tAttributeKey = [];
            Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
              if (sKey.substring(0, 3) == 'sx_') {
                tAttributeKey.push(sKey);
              }
            });
            return tAttributeKey;
          };
          return (() => {
            const _el$3 = createElement("Panel", {
                "class": "SelectionRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$3);
              const _el$5 = createElement("Panel", {
                "class": "Body"
              }, _el$3),
              _el$6 = createElement("Panel", {
                id: "Level"
              }, _el$5);
              createElement("Panel", {
                "class": "BG"
              }, _el$6);
              const _el$8 = createElement("Image", {
                id: "Image",
                get src() {
                  return `file://{images}/custom_game/halidom/${getName()}.png`;
                },
                scaling: 'stretch-to-fit-y-preserve-aspect'
              }, _el$5),
              _el$9 = createElement("Label", {
                id: "Name",
                get text() {
                  return `${YellowText($.Localize(`#${getName()}`))}`;
                },
                html: true
              }, _el$5);
            setProp(_el$3, "onactivate", p => {
              p.AddClass('Selected');
              GameEvents.SendCustomGameEventToServer('OnHalidomSelection', {
                'index': i
              });
            });
            insert(_el$6, createComponent(Yzy_Icon, {
              get ["class"]() {
                return 'icon_' + ['n', 'r', 'sr', 'ssr', 'ur'][getKv()['Rarity']];
              }
            }), null);
            insert(_el$5, createComponent(Show, {
              get when() {
                return getAttributeValues().length > 0;
              },
              get children() {
                const _el$0 = createElement("Panel", {
                  id: "AttributeBox"
                }, null);
                insert(_el$0, () => Object.values(getAttributeValues()).map((sKey, i) => {
                  var _a, _b, _c;
                  const sAttributeID = sKey.substring(3);
                  const fVal = (_c = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey]) !== null && _c !== void 0 ? _c : 0;
                  return createComponent(Yzy_Attribute, {
                    id: sAttributeID,
                    val: fVal
                  });
                }));
                return _el$0;
              }
            }), null);
            insert(_el$5, createComponent(Show, {
              get when() {
                return $.Localize(`#${getName()}_Description`) != `#${getName()}_Description`;
              },
              get children() {
                const _el$1 = createElement("Label", {
                  id: "Description",
                  get text() {
                    return ReplaceAbltVals(getName(), $.Localize(`#${getName()}_Description`));
                  },
                  html: true
                }, null);
                effect(_$p => setProp(_el$1, "text", ReplaceAbltVals(getName(), $.Localize(`#${getName()}_Description`)), _$p));
                return _el$1;
              }
            }), null);
            effect(_p$ => {
              const _v$ = `file://{images}/custom_game/halidom/${getName()}.png`,
                _v$2 = `${YellowText($.Localize(`#${getName()}`))}`;
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$8, "src", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$9, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$3;
          })();
        }
      }));
      insert(_el$, createComponent(Yzy_Button, {
        id: "RefreshBtn",
        get text() {
          return getRefreshText();
        },
        type: "btn_green",
        onactivate: p => {
          var _a, _b, _c;
          if ((getHalidomFreeRefreshCount() || 0) <= 0) {
            let iRefreshCost = Math.min((((_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['HalidomSelectionRefreshBaseCost']) || 0) + (getHalidomRefreshCount() || 0) * (((_b = CfgGetter_settings_common()) === null || _b === void 0 ? void 0 : _b['HalidomSelectionRefreshPerCost']) || 0), ((_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['HalidomSelectionRefreshMaxCost']) || 0);
            if (iRefreshCost > GetRes("kill", getter_iLocalPlayer())) return ErrorMsg(`error_not_enough_${"kill"}`);
          }
          GameEvents.SendCustomGameEventToServer('OnHalidomRefresh', {});
        }
      }), null);
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': getHalidomSelection() != undefined
      }), _$p));
      return _el$;
    })();
  }

  const [getDamageTotal, setDamageTotal] = createSignal({});
  const id = NetEventData.BindDo('damage_total', '', (t, pid) => {
    if (t == undefined) delete getDamageTotal()[pid];else getDamageTotal()[pid] = t;
    setDamageTotal(Object.assign({}, getDamageTotal()));
  });
  onCleanup(() => {
    NetEventData.Unbind(id, 'damage_total');
  });
  function DamageTotal() {
    var _a;
    const getHeroMax = createMemo(() => {
      let iMax;
      for (const key in getDamageTotal()) {
        let i = Object.values(getDamageTotal()[key]).reduce((prev, cur) => prev + cur, 0);
        if (iMax == undefined || iMax < i) {
          iMax = i;
        }
      }
      return iMax;
    });
    const getHeroTotal = createMemo(() => {
      let iTotal = 0;
      for (const key in getDamageTotal()) {
        iTotal += Object.values(getDamageTotal()[key]).reduce((prev, cur) => prev + cur, 0);
      }
      return iTotal;
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: 'DamageTotal'
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Header"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$2);
        createElement("Label", {
          "class": "Title",
          text: '#DamageTotal'
        }, _el$2);
        const _el$5 = createElement("Panel", {
          "class": "Body"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$5);
      insert(_el$7, createComponent(For, {
        get each() {
          return Object.keys((_a = getDamageTotal()) !== null && _a !== void 0 ? _a : {}).sort((a, b) => {
            const total_a = Object.values(getDamageTotal()[a]).reduce((prev, cur) => prev + cur, 0);
            const total_b = Object.values(getDamageTotal()[b]).reduce((prev, cur) => prev + cur, 0);
            return total_b - total_a;
          });
        },
        children: (pid, i) => {
          const iPlayerID = Number(pid);
          const getDmg = () => getDamageTotal()[pid];
          const getTotal = () => Object.values(getDmg()).reduce((prev, cur) => prev + cur, 0);
          const getTotalPct = () => {
            var _a;
            return getTotal() / ((_a = getHeroMax()) !== null && _a !== void 0 ? _a : 1);
          };
          const getHeroTotalPct = () => getTotal() / getHeroTotal();
          let ref;
          createEffect(() => {
            if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
              const hParent = ref.GetParent();
              if (hParent === null || hParent === void 0 ? void 0 : hParent.IsValid()) {
                if (hParent.GetChildIndex(ref) != i()) {
                  const p = hParent.GetChild(i());
                  if (p === null || p === void 0 ? void 0 : p.IsValid()) {
                    hParent.MoveChildBefore(ref, p);
                  }
                }
              }
            }
          });
          return (() => {
            const _el$8 = createElement("Panel", {
                "class": "DamageTotalRow"
              }, null),
              _el$9 = createElement("Panel", {
                "class": "Body"
              }, _el$8),
              _el$0 = createElement("Label", {
                id: "DamageTotalLabel",
                get text() {
                  return FormatNumber(getTotal());
                }
              }, _el$9),
              _el$1 = createElement("Panel", {
                "class": "Body"
              }, _el$9),
              _el$10 = createElement("Panel", {
                id: "DamageBarBox"
              }, _el$1),
              _el$11 = createElement("Label", {
                id: "DamageTotalPctLabel",
                get text() {
                  return `${(getHeroTotalPct() * 100).toFixed(0)}%`;
                }
              }, _el$1);
            const _ref$ = ref;
            typeof _ref$ === "function" ? use(_ref$, _el$8) : ref = _el$8;
            setProp(_el$8, "onmouseover", p => {
              ShowTooltip(p, 'damage_detail', {
                pid: iPlayerID
              });
            });
            setProp(_el$8, "onmouseout", p => {
              HideTooltip();
            });
            insert(_el$8, createComponent(PlayerAvatar, {
              "class": "Icon",
              iPlayerID: iPlayerID,
              hittest: false,
              onactivate: _ => {
                const iEntID = Players.GetPlayerHeroEntityIndex(iPlayerID);
                if (iEntID != -1) {
                  GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(iEntID), 0.1);
                }
              },
              hittestchildren: false
            }), _el$9);
            insert(_el$10, createComponent(For, {
              get each() {
                return Object.keys(getDmg() || {}).sort((a, b) => Number(a) - Number(b));
              },
              children: (type, i) => {
                const getPct = () => {
                  let v = getDmg()[type] / getTotal() * getTotalPct();
                  if (Number.isNaN(v)) return 0;
                  return v;
                };
                return (() => {
                  const _el$12 = createElement("Panel", {
                    get ["class"]() {
                      return classNames("DamageBarPanel", 'DmgType_' + type);
                    },
                    get style() {
                      return {
                        'width': `${(getPct() * 100).toFixed(2)}%`
                      };
                    }
                  }, null);
                  effect(_p$ => {
                    const _v$3 = classNames("DamageBarPanel", 'DmgType_' + type),
                      _v$4 = {
                        'width': `${(getPct() * 100).toFixed(2)}%`
                      };
                    _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$12, "class", _v$3, _p$._v$3));
                    _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$12, "style", _v$4, _p$._v$4));
                    return _p$;
                  }, {
                    _v$3: undefined,
                    _v$4: undefined
                  });
                  return _el$12;
                })();
              }
            }));
            effect(_p$ => {
              const _v$ = FormatNumber(getTotal()),
                _v$2 = `${(getHeroTotalPct() * 100).toFixed(0)}%`;
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$0, "text", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$11, "text", _v$2, _p$._v$2));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined
            });
            return _el$8;
          })();
        }
      }));
      return _el$;
    })();
  }

  function PlayerTeam() {
    const [getPlayerOrder] = useNetTable(t => {
      var _a;
      return (_a = t === null || t === void 0 ? void 0 : t.p2o) !== null && _a !== void 0 ? _a : {};
    }, '0', 'player');
    return (() => {
      const _el$ = createElement("Panel", {
        id: "PlayerTeam"
      }, null);
      insert(_el$, createComponent(Index, {
        get each() {
          return Object.keys(getPlayerOrder()).sort((a, b) => getPlayerOrder()[a] - getPlayerOrder()[b]);
        },
        children: (getPlayerID, i) => {
          return createComponent(PlayerPanel, {
            get iPlayerID() {
              return Number(getPlayerID());
            }
          });
        }
      }));
      return _el$;
    })();
  }
  function PlayerPanel(props) {
    var _a, _b, _c, _d;
    let ref;
    const [getDeath, setDeath] = createSignal(false);
    const [getRespawnTime, setRespawnTime] = createSignal(-1);
    const [getPowerValue, setPowerValue] = createSignal(-1);
    const getEntID = usePlayerSelectedHero(props.iPlayerID);
    createEffect(on([getEntID, getDeath], () => {
      if (Entities.IsValidEntity(getEntID())) {
        setDeath(!Entities.IsAlive(getEntID()));
        if (Entities.IsAlive(getEntID())) {
          let iTimerID = undefined;
          const id = GameEvents.Subscribe('entity_killed', t => {
            if (t.entindex_killed == getEntID()) {
              setDeath(true);
              iTimerID = Timer(() => {
                if (!Entities.IsAlive(getEntID())) return 0.1;
                setDeath(false);
                iTimerID = undefined;
              }, 0.1, undefined, 'PlayerPanel.Death');
            }
          });
          onCleanup(() => {
            GameEvents.Unsubscribe(id);
            StopTimer(iTimerID);
          });
        } else {
          const iTimerID = Timer(() => {
            if (!Entities.IsAlive(getEntID())) {
              setRespawnTime(Math.ceil(Players.GetRespawnSeconds(props.iPlayerID)) + 1);
              return 0.1;
            }
            setRespawnTime(-1);
            setDeath(false);
          }, 0.1);
          onCleanup(() => {
            StopTimer(iTimerID);
          });
        }
      }
    }));
    {
      const id = CustomNetTables.SubscribeNetTableListener('0', (sTable, sKey, t) => {
        var _a, _b;
        if (sKey == 'player') {
          if (ref) {
            ref.SetHasClass("Disconnect", ((_a = t === null || t === void 0 ? void 0 : t['disconnect']) === null || _a === void 0 ? void 0 : _a[props.iPlayerID]) == 1);
            ref.SetHasClass("Abandoned", ((_b = t === null || t === void 0 ? void 0 : t['abandoned']) === null || _b === void 0 ? void 0 : _b[props.iPlayerID]) == 1);
          }
        }
      });
      onCleanup(() => {
        CustomNetTables.UnsubscribeNetTableListener(id);
      });
    }
    createEffect(() => {
      const iTimerID = Timer(() => {
        const fPowerValue = GetPowerValue(props.iPlayerID);
        if (fPowerValue != getPowerValue()) {
          setPowerValue(fPowerValue);
        }
        return 0.5;
      }, 0.1);
      onCleanup(() => {
        StopTimer(iTimerID);
      });
    });
    const [getCosplayHeadIcon] = useNetEventTable(t => {
      var _a;
      return (_a = t === null || t === void 0 ? void 0 : t[5]) === null || _a === void 0 ? void 0 : _a.item_id;
    }, 'service', () => 'UserCosplay_' + props.iPlayerID);
    return (() => {
      const _el$2 = createElement("Panel", {
          get ["class"]() {
            return classNames('PlayerPanel', {
              'Death': getDeath()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$2);
        const _el$4 = createElement("Panel", {
          "class": "Body"
        }, _el$2),
        _el$5 = createElement("Panel", {
          id: "PlayerName"
        }, _el$4);
        createElement("Panel", {
          "class": "BG"
        }, _el$5);
        const _el$7 = createElement("Label", {
          "class": "Name",
          text: "{g:dota_persona:account_id}",
          get dialogVariables() {
            return {
              account_id: Player_IDToAccount(props.iPlayerID)
            };
          },
          html: true
        }, _el$5),
        _el$8 = createElement("Panel", {
          id: "PlayerPower"
        }, _el$4);
        createElement("Panel", {
          "class": "BG"
        }, _el$8);
        const _el$0 = createElement("Panel", {
          "class": "Body"
        }, _el$8);
        createElement("Panel", {
          "class": "Icon"
        }, _el$0);
        const _el$10 = createElement("Label", {
          "class": "Value",
          get text() {
            return FormatNumber(getPowerValue());
          }
        }, _el$0),
        _el$11 = createElement("Panel", {
          id: "PlayerAvatar"
        }, _el$4);
        createElement("Panel", {
          "class": "BG"
        }, _el$11);
        const _el$14 = createElement("Panel", {
          "class": "DisconnectIcon",
          hittest: false
        }, _el$11);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$2) : ref = _el$2;
      setProp(_el$7, "onactivate", _ => 0);
      setProp(_el$11, "onactivate", () => {
        const iEntID = Players.GetPlayerHeroEntityIndex(props.iPlayerID);
        if (iEntID != -1) {
          GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(iEntID), 0.1);
        }
      });
      setProp(_el$11, "ondblclick", () => {
        const iEntID = Players.GetPlayerHeroEntityIndex(props.iPlayerID);
        if (iEntID != -1) {
          GameUI.SelectUnit(iEntID, false);
        }
      });
      insert(_el$11, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return props.iPlayerID;
        },
        hittest: false,
        onactivate: _ => {
          const iEntID = Players.GetPlayerHeroEntityIndex(props.iPlayerID);
          if (iEntID != -1) {
            GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(iEntID), 0.1);
          }
        }
      }), _el$14);
      insert(_el$11, createComponent(Show, {
        get when() {
          return memo(() => !!getDeath())() && getRespawnTime() > 0;
        },
        get children() {
          const _el$13 = createElement("Label", {
            get text() {
              return getRespawnTime();
            }
          }, null);
          setProp(_el$13, "className", "DeadTime");
          effect(_$p => setProp(_el$13, "text", getRespawnTime(), _$p));
          return _el$13;
        }
      }), _el$14);
      insert(_el$4, createComponent(Show, {
        get when() {
          return (_b = (_a = CfgGetter_cosplay()) === null || _a === void 0 ? void 0 : _a[getCosplayHeadIcon()]) === null || _b === void 0 ? void 0 : _b['effect_path'];
        },
        get children() {
          const _el$15 = createElement("DOTAParticleScenePanel", {
            "class": "CosplayHeadIcon_FX",
            hittest: false,
            particleonly: false,
            drawbackground: true,
            rendershadows: true,
            get particleName() {
              return (_d = (_c = CfgGetter_cosplay()) === null || _c === void 0 ? void 0 : _c[getCosplayHeadIcon()]) === null || _d === void 0 ? void 0 : _d['effect_path'];
            },
            cameraOrigin: "0 0 300",
            lookAt: "0 0 0",
            fov: 90
          }, null);
          effect(_$p => setProp(_el$15, "particleName", (_d = (_c = CfgGetter_cosplay()) === null || _c === void 0 ? void 0 : _c[getCosplayHeadIcon()]) === null || _d === void 0 ? void 0 : _d['effect_path'], _$p));
          return _el$15;
        }
      }), null);
      effect(_p$ => {
        const _v$ = classNames('PlayerPanel', {
            'Death': getDeath()
          }),
          _v$2 = {
            account_id: Player_IDToAccount(props.iPlayerID)
          },
          _v$3 = FormatNumber(getPowerValue());
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$2, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$7, "dialogVariables", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$10, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$2;
    })();
  }
  function GetPowerValue(iPlayerID) {
    const iEntityIndex = Players.GetPlayerHeroEntityIndex(iPlayerID);
    const fHealth = AttributeKind$1.HpLimit.Get(iEntityIndex);
    return (AttributeKind$1.Atk.Get(iEntityIndex) + AttributeKind$1.Armor.Get(iEntityIndex) * 50 + fHealth / 2) * 0.1 * (1 + AttributeKind$1.AtkSpd.Get(iEntityIndex) * 0.01) * (1 + AttributeKind$1.DmgFinal.Get(iEntityIndex) * 0.5) * (1 + Math.max(AttributeKind$1.DmgReduce.Get(iEntityIndex), 0) * 0.5) * (1 + AttributeKind$1.Evasion.Get(iEntityIndex) * 0.01) * (1 + AttributeKind$1.PhyCritChance.Get(iEntityIndex) * 0.01 * AttributeKind$1.PhyCritDmg.Get(iEntityIndex) * 0.005) * (1 + AttributeKind$1.MgcCritChance.Get(iEntityIndex) * 0.01 * AttributeKind$1.MgcCritDmg.Get(iEntityIndex) * 0.005) * (1 + AttributeKind$1.AtkDmg.Get(iEntityIndex) * 0.002) * (1 + AttributeKind$1.AbltDmg.Get(iEntityIndex) * 0.002) * (1 + AttributeKind$1.PhyDmg.Get(iEntityIndex) * 0.002) * (1 + AttributeKind$1.MgcDmg.Get(iEntityIndex) * 0.002) * (1 + AttributeKind$1.PhysicalDmg.Get(iEntityIndex) * 0.001) * (1 + AttributeKind$1.ShadowDmg.Get(iEntityIndex) * 0.001) * (1 + AttributeKind$1.FireDmg.Get(iEntityIndex) * 0.001) * (1 + AttributeKind$1.FrostDmg.Get(iEntityIndex) * 0.001) * (1 + AttributeKind$1.NatureDmg.Get(iEntityIndex) * 0.001) * (1 + AttributeKind$1.HolyDmg.Get(iEntityIndex) * 0.001);
  }

  useNetEventTable(t => t, 'tower', 'round');
  useNetEventTable(t => t, 'tower', 'unit_data');
  useNetEventTable(t => t, 'tower', 'round_start_time');
  useNetEventTable(t => t, 'tower', 'round_end_time');
  function TowerPanel() {
    return createElement("Panel", {
      id: "TowerPanel",
      hittest: false
    }, null);
  }

  function CreateMenuOnPoint(props) {
    var _a;
    ScreenPanel.CreateOnPoint({
      'vPos': [0, 0],
      'origin': [0, 0],
      'limit_screen': true,
      'content': () => (() => {
        const _el$ = createElement("Panel", {
          get id() {
            return `MenuMask_${props.name}`;
          },
          "class": "MenuMask"
        }, null);
        setProp(_el$, "style", {
          'width': '100%',
          'height': '100%'
        });
        setProp(_el$, "onload", p => {
          p.GetParent().style.width = '100%';
          p.GetParent().style.height = '100%';
        });
        setProp(_el$, "onactivate", () => {
          ScreenPanel.DestroyByBind(props.name);
        });
        setProp(_el$, "oncontextmenu", () => {
          ScreenPanel.DestroyByBind(props.name);
        });
        effect(_$p => setProp(_el$, "id", `MenuMask_${props.name}`, _$p));
        return _el$;
      })()
    }, `MenuMask_${props.name}`);
    ScreenPanel.CreateOnPoint({
      'vPos': props.vPos,
      'origin': (_a = props.origin) !== null && _a !== void 0 ? _a : [0, 0],
      'limit_screen': true,
      'content': () => (() => {
        const _el$2 = createElement("Panel", {
          get id() {
            return 'MenuRoot_' + props.name;
          },
          "class": "MenuRoot",
          hittest: false,
          acceptsfocus: true
        }, null);
        setProp(_el$2, "onblur", () => {
          ScreenPanel.DestroyByBind(props.name);
        });
        setProp(_el$2, "onload", p => {
          p.SetFocus();
        });
        insert(_el$2, () => children(() => props.content));
        effect(_$p => setProp(_el$2, "id", 'MenuRoot_' + props.name, _$p));
        return _el$2;
      })(),
      'onDestroy': () => {
        var _a;
        ScreenPanel.DestroyByBind(`MenuMask_${props.name}`);
        (_a = props.onDestroy) === null || _a === void 0 ? void 0 : _a.call(props);
      }
    }, props.name);
  }
  function CreateMenuOnMouse(props) {
    var _a;
    const vPos = GameUI.GetCursorPosition();
    props.origin = (_a = props.origin) !== null && _a !== void 0 ? _a : [0, 0];
    if (props.origin[0] == 0) {
      vPos[0] += 5;
    } else if (props.origin[0] == 100) {
      vPos[0] -= 5;
    }
    if (props.origin[1] == 0) {
      vPos[1] += 5;
    } else if (props.origin[1] == 100) {
      vPos[1] -= 5;
    }
    CreateMenuOnPoint({
      'name': props.name,
      'vPos': vPos,
      'origin': props.origin,
      'content': props.content
    });
  }
  function MenuOption(props) {
    return (() => {
      const _el$3 = createElement("Panel", mergeProps(props, {
        get ["class"]() {
          return classNames('MenuOption', props.class);
        }
      }), null);
      spread(_el$3, mergeProps(props, {
        get ["class"]() {
          return classNames('MenuOption', props.class);
        },
        "onactivate": p => {
          var _a;
          const r = (_a = props.onactivate) === null || _a === void 0 ? void 0 : _a.call(props, p);
          if (r !== false) {
            ScreenPanel.DestroyByBind(props.name);
          }
        }
      }), false);
      return _el$3;
    })();
  }

  const getter_iFocusPlayer = useFocusPlayer();

  const getter_bControlDown = useControlDown();

  const [getPublicPack] = useNetEventTable(t => t, 'pack', 'public');
  const [getPlayerPack] = useNetEventTable(t => t, 'pack', () => 'player_' + getter_iFocusPlayer());
  function Pack() {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "Pack"
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "TitleBG"
        }, _el$);
        createElement("Label", {
          "class": "Title",
          text: "#GamePack"
        }, _el$3);
        const _el$5 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$6 = createElement("Panel", {
          "class": "PackTitle"
        }, _el$),
        _el$7 = createElement("Panel", {
          "class": "Title"
        }, _el$6);
        createElement("Label", {
          text: "#PublicPack"
        }, _el$7);
        const _el$9 = createElement("Panel", {
          "class": "Title"
        }, _el$6);
        createElement("Label", {
          text: "#PlayerPack"
        }, _el$9);
        const _el$1 = createElement("Panel", {
          "class": "Title"
        }, _el$6);
        createElement("Label", {
          text: "#GameItemPack"
        }, _el$1);
      insert(_el$5, createComponent(PublicPack, {}), null);
      insert(_el$5, createComponent(PlayerPack, {}), null);
      insert(_el$5, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(getLowerHudUnitId());
        },
        get children() {
          return createComponent(GameItemBox, {
            getEntID: getLowerHudUnitId
          });
        }
      }), null);
      return _el$;
    })();
  }
  function PublicPack() {
    const getRow = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackRowPublic']) !== null && _b !== void 0 ? _b : 0;
    };
    const getCol = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackCol']) !== null && _b !== void 0 ? _b : 0;
    };
    const [getShow, setShow] = createSignal(true);
    return (() => {
      const _el$11 = createElement("Panel", {
          get ["class"]() {
            return classNames({
              hidden: !getShow()
            });
          }
        }, null),
        _el$12 = createElement("Panel", {}, _el$11);
      setProp(_el$11, "className", "PublicPack");
      setProp(_el$12, "className", "Body");
      insert(_el$12, () => Array(getRow()).fill(null).map((_, i) => {
        return (() => {
          const _el$13 = createElement("Panel", {}, null);
          setProp(_el$13, "className", "Row");
          insert(_el$13, () => Array(getCol()).fill(null).map((_, j) => {
            let iBoxID = 1001 + i * getCol() + j;
            return createComponent(PackBox, {
              id: 'PackBox_' + iBoxID,
              boxid: iBoxID
            });
          }));
          return _el$13;
        })();
      }));
      effect(_$p => setProp(_el$11, "class", classNames({
        hidden: !getShow()
      }), _$p));
      return _el$11;
    })();
  }
  function PlayerPack() {
    const [getSettingData] = useNetEventTable(t => t, 'setting_data', 'data');
    const getRow = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackRowPlayer']) !== null && _b !== void 0 ? _b : 0;
    };
    const getCol = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackCol']) !== null && _b !== void 0 ? _b : 0;
    };
    const [getShow, setShow] = createSignal(true);
    createMemo(() => {
      var _a, _b, _c;
      return (_c = Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_X]) !== null && _c !== void 0 ? _c : 'X';
    });
    return (() => {
      const _el$14 = createElement("Panel", {
          get ["class"]() {
            return classNames({
              hidden: !getShow()
            });
          }
        }, null),
        _el$15 = createElement("Panel", {}, _el$14);
      setProp(_el$14, "className", "PlayerPack");
      setProp(_el$15, "className", "Body");
      insert(_el$15, () => Array(getRow()).fill(null).map((_, i) => {
        return (() => {
          const _el$16 = createElement("Panel", {
            get ["class"]() {
              return classNames('Row', {
                Show: getShow()
              });
            }
          }, null);
          insert(_el$16, () => Array(getCol()).fill(null).map((_, j) => {
            let iBoxID = i * getCol() + j + 1;
            return createComponent(PackBox, {
              id: 'PackBox_' + iBoxID,
              boxid: iBoxID
            });
          }));
          effect(_$p => setProp(_el$16, "class", classNames('Row', {
            Show: getShow()
          }), _$p));
          return _el$16;
        })();
      }));
      effect(_$p => setProp(_el$14, "class", classNames({
        hidden: !getShow()
      }), _$p));
      return _el$14;
    })();
  }
  function PackBox(props) {
    var _a, _b, _c, _d, _e, _f, _g;
    const [getItemData] = useNetEventTable(t => t, 'gameplay_item', () => {
      var _a, _b;
      return (_b = (_a = getPackBox(props.boxid)) === null || _a === void 0 ? void 0 : _a.item_uid) !== null && _b !== void 0 ? _b : -1;
    });
    const getItem = () => getItemData() ? item_gameplay_base.GetItem(getItemData()) : undefined;
    return (() => {
      const _el$17 = createElement("Panel", props, null),
        _el$18 = createElement("Panel", {}, _el$17),
        _el$19 = createElement("Panel", {}, _el$17),
        _el$21 = createElement("Panel", {
          hittest: false
        }, _el$17);
      spread(_el$17, mergeProps(props, {
        get className() {
          return classNames("PackBox", props.className, {
            Lock: (_b = (_a = getPackBox(props.boxid)) === null || _a === void 0 ? void 0 : _a.add) === null || _b === void 0 ? void 0 : _b.lock
          });
        },
        "onload": p => {
          RegDraggleDrop(p, 'PlayerPack', () => ({
            'boxid': props.boxid
          }), {
            'onDragEnter': (pDrag, tDragInfo) => {
              p.AddClass('Dragging');
            },
            'onDragLeave': (pDrag, tDragInfo) => {
              p.RemoveClass('Dragging');
            },
            'onDragDrop': (pDrag, tDragInfo, tDropInfo) => {
              if (CheckDragInfo(tDragInfo, 'PackItem', 'PackItem_game_item')) {
                if (tDragInfo.params.boxid != props.boxid) {
                  GameEvents.SendCustomGameEventToServer("Pack_Move", {
                    boxid: tDragInfo.params.boxid,
                    target_boxid: props.boxid
                  });
                }
              } else if (CheckDragInfo(tDragInfo, 'GameItem')) {
                GameEvents.SendCustomGameEventToServer("GameItem_ToPack", {
                  slot: tDragInfo.params.slot,
                  boxid: props.boxid,
                  entid: tDragInfo.params.item.entid
                });
              }
            }
          });
        }
      }), true);
      setProp(_el$18, "className", "BG");
      setProp(_el$19, "className", "Body");
      insert(_el$19, createComponent(Show, {
        get when() {
          return memo(() => getItem() != undefined)() && ((_c = getItem()) === null || _c === void 0 ? void 0 : _c.tItem);
        },
        get children() {
          return createComponent(GameplayItem, {
            get item() {
              return getItem().tItem;
            },
            get id() {
              return 'item_' + getItem().tItem.uid;
            },
            iCount: () => getItem().tItem['item'].count,
            draggable: true,
            onload: p => {
              const data = Object.assign({}, getItem());
              RegDraggle(p, () => {
                var _a;
                if (((_a = data.tItem) === null || _a === void 0 ? void 0 : _a.type) == 'game_item') {
                  return 'PackItem_game_item';
                }
                return 'PackItem';
              }, () => ({
                'boxid': props.boxid,
                'item_type': data.tItem.type
              }), () => {
                var _a;
                return createComponent(GameplayItem, {
                  get item() {
                    return (_a = getItem()) === null || _a === void 0 ? void 0 : _a.tItem;
                  },
                  className: "DragPackItem"
                });
              }, {
                'onDragStart': () => {
                  return true;
                },
                'onDragEnter': (pDrag, tDragInfo, tDropInfo) => {
                  if (CheckDropInfo(tDropInfo, 'Floor')) {
                    if (CheckDragInfo(tDragInfo, 'PackItem_game_item')) {
                      Timer(() => {
                        ShowDragTip('#DragTip_Drop_Floor');
                        return 0;
                      }, 0, 'PackBox.drag');
                    }
                  }
                },
                'onDragLeave': (pDrag, tDragInfo, tDropInfo) => {
                  if (CheckDropInfo(tDropInfo, 'Floor')) {
                    StopTimer('PackBox.drag');
                  }
                },
                'onDragDrop': (pDrag, tDragInfo, tDropInfo) => {
                  if (CheckDropInfo(tDropInfo, 'Floor')) {
                    if (CheckDragInfo(tDragInfo, 'PackItem_game_item')) {
                      for (const t of GameUI.FindScreenEntities(GameUI.GetCursorPosition())) {
                        if (Player_EntityToID(t.entityIndex) == Players.GetLocalPlayer()) {
                          GameEvents.SendCustomGameEventToServer("GameItem_AddByPack", {
                            entid: t.entityIndex,
                            'boxid': tDragInfo.params.boxid
                          });
                          return;
                        }
                      }
                    }
                    const pos = GameUI.GetScreenWorldPosition(GameUI.GetCursorPosition());
                    if (pos) {
                      GameEvents.SendCustomGameEventToServer('Pack_DropFloor', {
                        'boxid': props.boxid,
                        'pos': pos.join(' ')
                      });
                    }
                  }
                },
                'onDragEnd': () => {
                  print('onDragEnd');
                }
              });
            },
            onactivate: p => {
              if (getter_bControlDown()) {
                GameEvents.SendCustomGameEventToServer("Pack_Lock", {
                  boxid: props.boxid
                });
              }
            },
            onactivate_db: p => {
              GameEvents.SendCustomGameEventToServer('GameItem_AddByPack', {
                boxid: props.boxid,
                entid: Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer())
              });
            },
            oncontextmenu: p => {
              const tItem = getItem().tItem;
              if (props.boxid < 1000) {
                CreateMenuOnMouse({
                  'name': 'PackItemMenu',
                  'content': () => {
                    var _a, _b, _c;
                    return (() => {
                      const _el$22 = createElement("Panel", {
                        id: 'PackItemMenu'
                      }, null);
                      insert(_el$22, createComponent(MenuOption, {
                        name: 'PackItemMenu',
                        onactivate: p => {
                          GameEvents.SendCustomGameEventToServer("Pack_Lock", {
                            boxid: props.boxid
                          });
                        },
                        get children() {
                          const _el$23 = createElement("Label", {
                            get text() {
                              return ((_b = (_a = getPackBox(props.boxid)) === null || _a === void 0 ? void 0 : _a.add) === null || _b === void 0 ? void 0 : _b.lock) ? "#packunlock" : "#PackLock";
                            }
                          }, null);
                          effect(_$p => setProp(_el$23, "text", ((_b = (_a = getPackBox(props.boxid)) === null || _a === void 0 ? void 0 : _a.add) === null || _b === void 0 ? void 0 : _b.lock) ? "#packunlock" : "#PackLock", _$p));
                          return _el$23;
                        }
                      }), null);
                      insert(_el$22, createComponent(Show, {
                        get when() {
                          return CheckItemShared(tItem.type, tItem.id);
                        },
                        get children() {
                          return createComponent(MenuOption, {
                            name: 'PackItemMenu',
                            onactivate: p => {
                              const iBoxID2 = GetEmptyPackBoxInPublic();
                              if (iBoxID2) {
                                GameEvents.SendCustomGameEventToServer("Pack_Move", {
                                  boxid: props.boxid,
                                  target_boxid: iBoxID2
                                });
                              }
                            },
                            get children() {
                              return createElement("Label", {
                                text: "#PackShare"
                              }, null);
                            }
                          });
                        }
                      }), null);
                      insert(_el$22, createComponent(Show, {
                        get when() {
                          return (_c = KvByID(tItem.id)) === null || _c === void 0 ? void 0 : _c['ItemCost'];
                        },
                        get children() {
                          return createComponent(MenuOption, {
                            name: 'PackItemMenu',
                            onactivate: p => {
                              GameEvents.SendCustomGameEventToServer("Pack_Decompose", {
                                box_id: props.boxid
                              });
                            },
                            get children() {
                              return createElement("Label", {
                                text: "#PackDecompose"
                              }, null);
                            }
                          });
                        }
                      }), null);
                      return _el$22;
                    })();
                  }
                });
              }
            }
          });
        }
      }));
      insert(_el$17, createComponent(Show, {
        get when() {
          return ((_e = (_d = getItemData()) === null || _d === void 0 ? void 0 : _d.count) !== null && _e !== void 0 ? _e : 1) > 1;
        },
        get children() {
          const _el$20 = createElement("Label", {
            id: "ItemCount",
            get text() {
              return (_g = (_f = getItemData()) === null || _f === void 0 ? void 0 : _f.count) !== null && _g !== void 0 ? _g : '';
            },
            hittest: false
          }, null);
          effect(_$p => setProp(_el$20, "text", (_g = (_f = getItemData()) === null || _f === void 0 ? void 0 : _f.count) !== null && _g !== void 0 ? _g : '', _$p));
          return _el$20;
        }
      }), _el$21);
      setProp(_el$21, "className", "LockImage");
      return _el$17;
    })();
  }
  function getPackBox(iBoxID) {
    var _a, _b;
    if (iBoxID > 1000) return (_a = getPublicPack()) === null || _a === void 0 ? void 0 : _a[iBoxID];
    return (_b = getPlayerPack()) === null || _b === void 0 ? void 0 : _b[iBoxID];
  }
  function CheckItemShared(sItemType, item_id) {
    var _a;
    return ((_a = KvByID(item_id)) === null || _a === void 0 ? void 0 : _a['ItemShared']) == 1;
  }
  function GetEmptyPackBoxInPublic() {
    var _a, _b, _c, _d, _e, _f;
    const iRow = (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['PackRowPublic']) !== null && _b !== void 0 ? _b : 0;
    const iCol = (_d = (_c = CfgGetter_settings_common()) === null || _c === void 0 ? void 0 : _c['PackCol']) !== null && _d !== void 0 ? _d : 0;
    const iMax = 1000 + iRow * iCol;
    for (let i = 1001; i <= iMax; i++) {
      if (((_f = (_e = NetEventData.GetTableValue('pack', 'public')) === null || _e === void 0 ? void 0 : _e[i]) === null || _f === void 0 ? void 0 : _f.item_uid) == undefined) {
        return i;
      }
    }
  }

  function SelectionRelic() {
    const [getOpen, setOpen] = createSignal(false);
    const [getSelect] = useNetEventTable(t => t, 'relic', () => 'select_' + getter_iLocalPlayer());
    const [getFreeRefreshCount] = useNetEventTable(t => t, 'relic', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const [getRelicSelected] = useNetEventTable(t => t, 'relic', () => 'selected_' + getter_iLocalPlayer());
    const getRefreshText = createMemo(() => {
      if ((getFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getFreeRefreshCount() || 0);
      }
      return '#RefreshCountNotEnough';
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_RELIC_SELECTION_TOGGLE', event => {
        setOpen(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_RELIC_SELECTION_TOGGLE', id);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "RelicSelection",
          get ["class"]() {
            return classNames({
              'Show': getOpen() && getSelect() != undefined
            });
          }
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$3 = createElement("Panel", {
          "class": "BottomPanel"
        }, _el$),
        _el$4 = createElement("TextButton", {
          id: "CloseBtn",
          text: "#ChooseLaterBtn"
        }, _el$3),
        _el$5 = createElement("Panel", {
          "class": "Group"
        }, _el$3);
        createElement("Label", {
          id: "GiveUpRelicSelectDes",
          text: '#GiveUpRelicSelectDes'
        }, _el$5);
        const _el$7 = createElement("TextButton", {
          id: "GiveUpBtn",
          text: "#GiveUpBtn"
        }, _el$5),
        _el$8 = createElement("TextButton", {
          id: "RefreshBtn",
          get text() {
            return getRefreshText();
          },
          html: true
        }, _el$3);
      insert(_el$2, createComponent(Index, {
        get each() {
          return getSelect();
        },
        children: (getName, i) => {
          var _a, _b;
          const getKv = () => AbilitiesKv[getName()];
          const getAttributeValues = () => {
            var _a;
            const tAttributeKey = [];
            Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
              if (sKey.substring(0, 3) == 'sx_') {
                tAttributeKey.push(sKey);
              }
            });
            return tAttributeKey;
          };
          const getDescription = () => {
            if ($.Localize('#' + getName() + '_Description') != '#' + getName() + '_Description') {
              return ReplaceAbltVals(getName(), $.Localize("#" + getName() + '_Description'));
            }
          };
          const getCombinationList = () => {
            var _a, _b;
            return ((_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['CombinationList']) === null || _b === void 0 ? void 0 : _b.split("|")) || [];
          };
          const getActiveCombinationCount = () => {
            var _a;
            let iCount = 0;
            const tSelectedNames = [];
            for (const tCardData of (_a = getRelicSelected()) !== null && _a !== void 0 ? _a : []) {
              if (tCardData.name) {
                tSelectedNames.push(tCardData.name);
              }
            }
            for (const sCardName of getCombinationList()) {
              if (tSelectedNames === null || tSelectedNames === void 0 ? void 0 : tSelectedNames.includes(sCardName)) {
                iCount++;
              }
            }
            return iCount;
          };
          return (() => {
            const _el$9 = createElement("Panel", {
                "class": "SelectRow"
              }, null),
              _el$0 = createElement("Panel", {
                "class": "BG",
                get style() {
                  return {
                    backgroundImage: `url("file://{images}/custom_game/selections/relic/bg_${(_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) !== null && _b !== void 0 ? _b : 1}.png")`
                  };
                }
              }, _el$9),
              _el$1 = createElement("Panel", {
                "class": "Body"
              }, _el$9),
              _el$10 = createElement("Panel", {
                "class": "Group"
              }, _el$1),
              _el$11 = createElement("Label", {
                id: "Name",
                get text() {
                  return '#' + getName();
                }
              }, _el$10),
              _el$13 = createElement("Panel", {
                id: "Effect"
              }, _el$1),
              _el$15 = createElement("Panel", {
                id: "EffectDescriptionContainer"
              }, _el$13);
            setProp(_el$9, "onactivate", () => {
              GameEvents.SendCustomGameEventToServer('OnRelicSelected', {
                'name': getName()
              });
            });
            insert(_el$10, createComponent(Show, {
              get when() {
                return getCombinationList().length > 0;
              },
              get children() {
                const _el$12 = createElement("Label", {
                  id: "Count",
                  get ["class"]() {
                    return classNames({
                      'HasCount': getActiveCombinationCount() > 0
                    });
                  },
                  get text() {
                    return `(${getActiveCombinationCount()}/${getCombinationList().length})`;
                  },
                  html: true
                }, null);
                effect(_p$ => {
                  const _v$4 = classNames({
                      'HasCount': getActiveCombinationCount() > 0
                    }),
                    _v$5 = `(${getActiveCombinationCount()}/${getCombinationList().length})`;
                  _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$12, "class", _v$4, _p$._v$4));
                  _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$12, "text", _v$5, _p$._v$5));
                  return _p$;
                }, {
                  _v$4: undefined,
                  _v$5: undefined
                });
                return _el$12;
              }
            }), null);
            insert(_el$1, createComponent(Yzy_ItemImage, {
              get name() {
                return getName();
              },
              hittest: false
            }), _el$13);
            insert(_el$13, createComponent(Show, {
              get when() {
                return getAttributeValues().length > 0;
              },
              get children() {
                const _el$14 = createElement("Panel", {
                  id: "AttributeBox"
                }, null);
                insert(_el$14, () => Object.values(getAttributeValues()).map((sKey, i) => {
                  var _a, _b, _c;
                  const sAttributeID = sKey.substring(3);
                  const fVal = (_c = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey]) !== null && _c !== void 0 ? _c : 0;
                  return createComponent(Yzy_Attribute, {
                    id: sAttributeID,
                    val: fVal
                  });
                }));
                return _el$14;
              }
            }), _el$15);
            insert(_el$15, createComponent(Show, {
              get when() {
                return getDescription() != undefined;
              },
              get children() {
                return createComponent(Yzy_Description, {
                  get name() {
                    return getName();
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$6 = {
                  backgroundImage: `url("file://{images}/custom_game/selections/relic/bg_${(_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) !== null && _b !== void 0 ? _b : 1}.png")`
                },
                _v$7 = '#' + getName();
              _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$0, "style", _v$6, _p$._v$6));
              _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$11, "text", _v$7, _p$._v$7));
              return _p$;
            }, {
              _v$6: undefined,
              _v$7: undefined
            });
            return _el$9;
          })();
        }
      }));
      setProp(_el$4, "onactivate", p => {
        EventManager.Fire('ON_RELIC_SELECTION_TOGGLE', {
          'open': false
        });
      });
      setProp(_el$7, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnRelicGiveUpSelect', {});
      });
      setProp(_el$8, "onactivate", p => {
        if ((getFreeRefreshCount() || 0) <= 0) return;
        GameEvents.SendCustomGameEventToServer('OnRelicRefresh', {});
      });
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getOpen() && getSelect() != undefined
          }),
          _v$2 = getRefreshText(),
          _v$3 = (getFreeRefreshCount() || 0) > 0;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$8, "enabled", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }

  const getter_bAltDown = useAltDown();

  function SelectionAbility() {
    const [getData] = useNetEventTable(t => t, 'abilities', () => 'select_' + getter_iLocalPlayer());
    const [getFreeRefreshCount] = useNetEventTable(t => t, 'abilities', () => 'free_refresh_count_' + getter_iLocalPlayer());
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      if (getData() != undefined) {
        setShow(true);
      }
    });
    const getRefreshText = createMemo(() => {
      if ((getFreeRefreshCount() || 0) > 0) {
        return ReplaceTextVariable('#FreeRefreshCount', getFreeRefreshCount() || 0);
      }
      return '#RefreshCountNotEnough';
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_ABILITY_SELECTION_TOGGLE', event => {
        setShow(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_ABILITY_SELECTION_TOGGLE', id);
      });
    });
    return createComponent(FadeShow, {
      get data() {
        return getData();
      },
      fade_out: 1,
      onFadedOut: () => {
        if (getData() == undefined) {
          setShow(false);
        }
      },
      bUseGameTime: true,
      children: getData => (() => {
        const _el$ = createElement("Panel", {
            id: "AbilitySelection",
            get ["class"]() {
              return classNames({
                'Show': getShow()
              });
            }
          }, null),
          _el$2 = createElement("Panel", {
            "class": "Body"
          }, _el$),
          _el$3 = createElement("Panel", {
            "class": "BottomPanel"
          }, _el$),
          _el$4 = createElement("TextButton", {
            id: "CloseBtn",
            text: "#ChooseLaterBtn"
          }, _el$3),
          _el$5 = createElement("Panel", {
            "class": "Group"
          }, _el$3);
          createElement("Label", {
            id: "GiveUpSelectDes",
            text: '#GiveUpAbilitySelectDes'
          }, _el$5);
          const _el$7 = createElement("TextButton", {
            id: "GiveUpBtn",
            text: "#GiveUpBtn"
          }, _el$5),
          _el$8 = createElement("TextButton", {
            id: "RefreshBtn",
            get text() {
              return getRefreshText();
            },
            html: true
          }, _el$3);
        insert(_el$2, createComponent(Index, {
          get each() {
            return getData();
          },
          children: (getName, i) => {
            const getKv = () => AbilitiesKv[getName()];
            const getAttributeValues = () => {
              var _a;
              const tAttributeKey = [];
              Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
                if (sKey.substring(0, 3) == 'sx_') {
                  tAttributeKey.push(sKey);
                }
              });
              return tAttributeKey;
            };
            const getDescription = () => {
              if ($.Localize('#DOTA_TOOLTIP_ability_' + getName() + '_Description') != '#DOTA_TOOLTIP_ability_' + getName() + '_Description') {
                return ReplaceAbltVals(getName(), $.Localize("#DOTA_TOOLTIP_ability_" + getName() + '_Description'));
              }
            };
            const getSpecials = () => {
              var _a;
              const tSpecials = {};
              Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
                var _a, _b;
                if ($.Localize(`#DOTA_TOOLTIP_ability_${getName()}_${sKey}`) != `#DOTA_TOOLTIP_ability_${getName()}_${sKey}`) {
                  tSpecials[sKey] = {
                    sDescription: $.Localize(`#DOTA_TOOLTIP_ability_${getName()}_${sKey}`),
                    sVal: String((_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey])
                  };
                }
              });
              return tSpecials;
            };
            const getAmplifyName = () => {
              var _a, _b;
              if ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AmpAblt']) {
                return (_b = getKv()) === null || _b === void 0 ? void 0 : _b['AmpAblt'];
              }
              return getName();
            };
            const getRarity = () => {
              var _a;
              return ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) || 1;
            };
            const isInitialAbility = () => {
              var _a;
              return (_a = getName()) === null || _a === void 0 ? void 0 : _a.startsWith('com_');
            };
            return (() => {
              const _el$9 = createElement("Panel", {
                  get ["class"]() {
                    return classNames("SelectRow", "Rarity_" + getRarity());
                  }
                }, null);
                createElement("Panel", {
                  "class": "BG"
                }, _el$9);
                const _el$1 = createElement("Panel", {
                  "class": "Body"
                }, _el$9),
                _el$10 = createElement("Label", {
                  id: "Name",
                  get text() {
                    return '#DOTA_TOOLTIP_ability_' + getName();
                  }
                }, _el$1),
                _el$11 = createElement("Panel", {
                  "class": "Line"
                }, _el$1),
                _el$12 = createElement("Panel", {
                  id: "Effect"
                }, _el$1),
                _el$14 = createElement("Panel", {
                  id: "EffectDescriptionContainer"
                }, _el$12);
              setProp(_el$9, "onactivate", () => {
                GameEvents.SendCustomGameEventToServer('OnAbilitySelected', {
                  'name': getName()
                });
              });
              insert(_el$9, createComponent(Show, {
                get when() {
                  return isInitialAbility();
                },
                get children() {
                  return createComponent(Yzy_Icon, {
                    "class": 'New',
                    type: "icon_new"
                  });
                }
              }), _el$1);
              insert(_el$1, createComponent(Yzy_ItemImage, {
                id: "AbilityImage",
                get name() {
                  return getAmplifyName();
                },
                get image() {
                  return `file://{images}/spellicons/${getAmplifyName()}.png`;
                },
                get rarity() {
                  return getRarity() + 1;
                },
                hittest: false
              }), _el$11);
              insert(_el$12, createComponent(Show, {
                get when() {
                  return getAttributeValues().length > 0;
                },
                get children() {
                  const _el$13 = createElement("Panel", {
                    id: "AttributeBox"
                  }, null);
                  insert(_el$13, () => Object.values(getAttributeValues()).map((sKey, i) => {
                    var _a, _b, _c;
                    const sAttributeID = sKey.substring(3);
                    const fVal = (_c = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) === null || _b === void 0 ? void 0 : _b[sKey]) !== null && _c !== void 0 ? _c : 0;
                    return createComponent(Yzy_Attribute, {
                      id: sAttributeID,
                      val: fVal
                    });
                  }));
                  return _el$13;
                }
              }), _el$14);
              insert(_el$14, createComponent(Show, {
                get when() {
                  return getDescription() != undefined;
                },
                get children() {
                  return createComponent(Yzy_Description, {
                    get name() {
                      return getName();
                    },
                    get text() {
                      return getDescription();
                    }
                  });
                }
              }));
              insert(_el$12, createComponent(Show, {
                get when() {
                  return !IsEmptyObject(getSpecials());
                },
                get children() {
                  const _el$15 = createElement("Panel", {
                    id: "AbilitySpecialBox"
                  }, null);
                  insert(_el$15, () => Object.keys(getSpecials()).map(sKey => {
                    let {
                      sDescription,
                      sVal
                    } = getSpecials()[sKey];
                    if (sDescription.search(/\[.*?\]/) != -1) {
                      let s = ReplaceAbltVals(getName(), sDescription, {
                        'level': 1,
                        'count': getter_bAltDown()
                      });
                      let i = s.search(/[:：]/);
                      let sKey2;
                      let sVal2;
                      if (i != -1) {
                        sKey2 = s.slice(0, i + 1);
                        sVal2 = s.slice(i + 1);
                      } else {
                        sKey = s;
                      }
                      return (() => {
                        const _el$16 = createElement("Panel", {}, null),
                          _el$17 = createElement("Label", {
                            id: "AbilitySpecialKey",
                            text: sKey2,
                            html: true
                          }, _el$16);
                        setProp(_el$16, "className", "AbilitySpecialPanel");
                        setProp(_el$17, "text", sKey2);
                        insert(_el$16, sVal2 != undefined ? (() => {
                          const _el$18 = createElement("Label", {
                            id: "AbilitySpecialVal",
                            text: sVal2,
                            html: true
                          }, null);
                          setProp(_el$18, "text", sVal2);
                          return _el$18;
                        })() : undefined, null);
                        return _el$16;
                      })();
                    } else {
                      let bPct = sDescription[0] == '%';
                      if (bPct) {
                        sDescription = sDescription.substring(1);
                      }
                      let sVal2 = '';
                      let tVal = sVal.split(' ');
                      {
                        sVal2 = tVal[Clamp(0, 0, tVal.length - 1)];
                      }
                      if (bPct) sVal2 += '%';
                      sVal2 = SpanText(sVal2, 'CurLevel');
                      return (() => {
                        const _el$19 = createElement("Panel", {}, null),
                          _el$20 = createElement("Label", {
                            id: "AbilitySpecialKey",
                            text: sDescription
                          }, _el$19),
                          _el$21 = createElement("Label", {
                            id: "AbilitySpecialVal",
                            text: sVal2,
                            html: true
                          }, _el$19);
                        setProp(_el$19, "className", "AbilitySpecialPanel");
                        setProp(_el$20, "text", sDescription);
                        setProp(_el$21, "text", sVal2);
                        return _el$19;
                      })();
                    }
                  }));
                  return _el$15;
                }
              }), null);
              effect(_p$ => {
                const _v$4 = classNames("SelectRow", "Rarity_" + getRarity()),
                  _v$5 = '#DOTA_TOOLTIP_ability_' + getName();
                _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$9, "class", _v$4, _p$._v$4));
                _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$10, "text", _v$5, _p$._v$5));
                return _p$;
              }, {
                _v$4: undefined,
                _v$5: undefined
              });
              return _el$9;
            })();
          }
        }));
        setProp(_el$4, "onactivate", p => {
          EventManager.Fire('ON_ABILITY_SELECTION_TOGGLE', {
            'open': false
          });
        });
        setProp(_el$7, "onactivate", p => {
          GameEvents.SendCustomGameEventToServer('OnAbilityGiveUpSelect', {});
        });
        setProp(_el$8, "onactivate", p => {
          if ((getFreeRefreshCount() || 0) <= 0) return;
          GameEvents.SendCustomGameEventToServer('OnAbilityRefresh', {});
        });
        effect(_p$ => {
          const _v$ = classNames({
              'Show': getShow()
            }),
            _v$2 = getRefreshText(),
            _v$3 = (getFreeRefreshCount() || 0) > 0;
          _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
          _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
          _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$8, "enabled", _v$3, _p$._v$3));
          return _p$;
        }, {
          _v$: undefined,
          _v$2: undefined,
          _v$3: undefined
        });
        return _el$;
      })()
    });
  }

  function MiniMap() {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "MinimapPanel"
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$4 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$5 = createElement("DOTAMinimap", {
          id: "Minimap"
        }, _el$4);
      setProp(_el$5, "style", {
        width: `100%`,
        height: `100%`,
        opacityMask: `url('file://{images}/custom_game/minimap/minimap_mask.png') 1`,
        align: `center center`
      });
      return _el$;
    })();
  }

  function TabButton(props) {
    let ref;
    if (props.selected != undefined) {
      createEffect(() => {
        ref.checked = props.selected;
      });
    }
    const hasLock = createMemo(() => {
      return false;
    });
    return (() => {
      const _el$2 = createElement("Panel", {
          get ["class"]() {
            return classNames("TabButton", {
              Lock: props.hsaLock ? props.hsaLock() : hasLock()
            });
          }
        }, null),
        _el$3 = createElement("GenericPanel", mergeProps({
          type: "TabButton"
        }, props), _el$2),
        _el$4 = createElement("Panel", {
          "class": "LockPane"
        }, _el$2);
      use(p => {
        ref = p;
        if (typeof props.ref == 'function') props.ref(p);
      }, _el$3);
      spread(_el$3, props, false);
      setProp(_el$4, "onactivate", () => {
        var _a;
        if (props.lock_fun) {
          (_a = props.lock_fun) === null || _a === void 0 ? void 0 : _a.call(props, props.id);
          return;
        }
        print('onactivate LOCK');
      });
      effect(_$p => setProp(_el$2, "class", classNames("TabButton", {
        Lock: props.hsaLock ? props.hsaLock() : hasLock()
      }), _$p));
      return _el$2;
    })();
  }

  function DevourPack() {
    var _a;
    const [getOpen, setOpen] = createSignal(false);
    const [getPage, setPage] = createSignal("Card");
    const [getCard] = useNetEventTable(t => t, 'card', () => 'devour_' + getter_iLocalPlayer());
    const [getHero] = useNetEventTable(t => t, 'hero', () => 'transfer_heros_' + getter_iLocalPlayer());
    const [getRelic] = useNetEventTable(t => t, 'relic', () => 'selected_' + getter_iLocalPlayer());
    const [getShop] = useNetEventTable(t => t, 'game_shop', () => 'select_' + getter_iLocalPlayer());
    const getDevour = createMemo(() => {
      var _a, _b, _c, _d;
      if (getPage() == "Card") {
        let t = [];
        (_a = getCard()) === null || _a === void 0 ? void 0 : _a.forEach(v => {
          const iIndex = t.findIndex(k => (k === null || k === void 0 ? void 0 : k.name) == v);
          if (iIndex == -1) {
            t.push({
              'name': v,
              'count': 1
            });
          } else {
            t[iIndex].count++;
          }
        });
        return t;
      } else if (getPage() == "Hero") {
        let t = [];
        (_b = getHero()) === null || _b === void 0 ? void 0 : _b.forEach(v => {
          const iIndex = t.findIndex(k => k.name == v);
          if (iIndex == -1) {
            t.push({
              'name': v,
              'count': 1
            });
          } else {
            t[iIndex].count++;
          }
        });
        return t;
      } else if (getPage() == "Relic") {
        let t = [];
        (_c = getRelic()) === null || _c === void 0 ? void 0 : _c.forEach(v => {
          if (v.name) {
            const iIndex = t.findIndex(k => k.name == v.name);
            if (iIndex == -1) {
              t.push({
                'name': v.name,
                'count': 1
              });
            } else {
              t[iIndex].count++;
            }
          }
        });
        return t;
      } else if (getPage() == "Shop") {
        let t = [];
        (_d = getShop()) === null || _d === void 0 ? void 0 : _d.forEach(v => {
          const iIndex = t.findIndex(k => k.name == v);
          if (iIndex == -1) {
            t.push({
              'name': v,
              'count': 1
            });
          } else {
            t[iIndex].count++;
          }
        });
        return t;
      }
    });
    createEffect(() => {
      const id = EventManager.Reg('ON_DEVOUR_TOGGLE', event => {
        setOpen(event.open);
      });
      onCleanup(() => {
        EventManager.Unreg('ON_DEVOUR_TOGGLE', id);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "DevourPack",
          get ["class"]() {
            return classNames({
              'Show': getOpen()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Title"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        createElement("Label", {
          text: "#DevourTitle"
        }, _el$3);
        const _el$6 = createElement("Panel", {
          "class": "CloseBtn"
        }, _el$3),
        _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$8 = createElement("Panel", {
          "class": "Body"
        }, _el$7),
        _el$9 = createElement("Panel", {
          "class": "Page"
        }, _el$8),
        _el$0 = createElement("Panel", {
          "class": "Contain"
        }, _el$8);
        createElement("Panel", {
          "class": "BG"
        }, _el$0);
        const _el$10 = createElement("Panel", {
          "class": "Body"
        }, _el$0);
      setProp(_el$6, "onactivate", p => {
        EventManager.Fire('ON_DEVOUR_TOGGLE', {
          'open': false
        });
      });
      insert(_el$9, createComponent(Index, {
        each: ["Card", "Hero", "Relic", "Shop"],
        children: (getPageId, i) => {
          return createComponent(TabButton, {
            get ["class"]() {
              return classNames('PageTab', 'Page_' + getPageId());
            },
            group: "DevourPageTab",
            get selected() {
              return getPageId() == getPage();
            },
            onactivate: p => {
              setPage(getPageId());
            },
            get children() {
              return [createElement("Panel", {
                "class": "BG"
              }, null), (() => {
                const _el$12 = createElement("Panel", {
                    "class": "Body"
                  }, null),
                  _el$13 = createElement("Label", {
                    "class": "PageTitle",
                    get text() {
                      return '#DevourPage_' + getPageId();
                    }
                  }, _el$12);
                effect(_$p => setProp(_el$13, "text", '#DevourPage_' + getPageId(), _$p));
                return _el$12;
              })()];
            }
          });
        }
      }));
      insert(_el$10, createComponent(Index, {
        get each() {
          return Array(Math.max(((_a = getDevour()) === null || _a === void 0 ? void 0 : _a.length) || 0, 36));
        },
        children: (v, i) => {
          var _a;
          const getName = () => {
            var _a, _b;
            return (_b = (_a = getDevour()) === null || _a === void 0 ? void 0 : _a[i]) === null || _b === void 0 ? void 0 : _b.name;
          };
          const getCount = () => {
            var _a, _b;
            return (_b = (_a = getDevour()) === null || _a === void 0 ? void 0 : _a[i]) === null || _b === void 0 ? void 0 : _b.count;
          };
          const getKv = () => {
            if (getPage() == "Hero") {
              return CustomHeroesKv[getName()];
            }
            return AbilitiesKv[getName()];
          };
          const getRarity = () => {
            var _a, _b;
            return (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['Rarity']) !== null && _b !== void 0 ? _b : 1;
          };
          const getImage = () => {
            if (getPage() == "Hero") {
              return `file://{images}/custom_game/talent/${CustomHeroesKv[getName()]['Talent']}.png`;
            } else if (getPage() == "Relic") {
              return `file://{images}/custom_game/items/${getName()}.png`;
            }
            return `file://{images}/custom_game/items/${getName()}.png`;
          };
          const getCombinationName = () => {
            var _a, _b, _c, _d, _e;
            if ((_a = getKv()) === null || _a === void 0 ? void 0 : _a['Combination']) {
              return (_b = getKv()) === null || _b === void 0 ? void 0 : _b['Combination'];
            }
            return (_e = (_d = ((_c = getKv()) === null || _c === void 0 ? void 0 : _c['Tag']) || '') === null || _d === void 0 ? void 0 : _d.split(',')) === null || _e === void 0 ? void 0 : _e[0];
          };
          const getNameText = () => {
            if (getPage() == "Card") {
              return getCombinationName();
            }
            return getName();
          };
          return (() => {
            const _el$14 = createElement("Panel", {
                "class": "DevourRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$14);
              const _el$16 = createElement("Panel", {
                "class": "Body"
              }, _el$14);
            insert(_el$16, createComponent(Show, {
              get when() {
                return getName() != undefined;
              },
              get children() {
                return [createComponent(Yzy_ItemImage, {
                  get name() {
                    return getName();
                  },
                  get image() {
                    return getImage();
                  },
                  get rarity() {
                    return getRarity();
                  },
                  onmouseover: p => {
                    var _a, _b;
                    if (getPage() == "Card") {
                      ShowTooltip(p, 'card_tooltip', {
                        'sCardName': getName()
                      });
                    } else if (getPage() == "Hero") {
                      ShowTooltip(p, 'talent_tooltip', {
                        'sTalentName': CustomHeroesKv[getName()]['Talent']
                      });
                    } else if (getPage() == "Relic") {
                      ShowTooltip(p, 'common_detail_tooltip', {
                        'sName': getName(),
                        'sTitle': $.Localize('#' + getName()),
                        'tAttribute': Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a.AbilityValues) || {}).filter(k => k.substring(0, 3) == 'sx_').map(k => {
                          var _a, _b;
                          return `${k}=${(_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a.AbilityValues) === null || _b === void 0 ? void 0 : _b[k]}`;
                        }),
                        'sContext': $.Localize("#" + getName() + '_Description') != "#" + getName() + '_Description' ? ReplaceAbltVals(getName(), $.Localize("#" + getName() + '_Description')) : undefined
                      });
                    } else if (getPage() == "Shop") {
                      ShowTooltip(p, 'common_detail_tooltip', {
                        'sName': getName(),
                        'sTitle': $.Localize('#' + getName()),
                        'tAttribute': Object.keys(((_b = getKv()) === null || _b === void 0 ? void 0 : _b.AbilityValues) || {}).filter(k => k.substring(0, 3) == 'sx_').map(k => {
                          var _a, _b;
                          return `${k}=${(_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a.AbilityValues) === null || _b === void 0 ? void 0 : _b[k]}`;
                        }),
                        'sContext': $.Localize("#" + getName() + '_Description') != "#" + getName() + '_Description' ? ReplaceAbltVals(getName(), $.Localize("#" + getName() + '_Description')) : undefined
                      });
                    }
                  },
                  onmouseout: HideTooltip
                }), createComponent(Show, {
                  get when() {
                    return getNameText() != undefined;
                  },
                  get children() {
                    return createComponent(Yzy_ItemName, {
                      get name() {
                        return getNameText();
                      },
                      get rarity() {
                        return getRarity();
                      }
                    });
                  }
                }), createComponent(Show, {
                  get when() {
                    return ((_a = getCount()) !== null && _a !== void 0 ? _a : 0) > 1;
                  },
                  get children() {
                    const _el$17 = createElement("Label", {
                      id: "Count",
                      get text() {
                        return getCount();
                      }
                    }, null);
                    effect(_$p => setProp(_el$17, "text", getCount(), _$p));
                    return _el$17;
                  }
                })];
              }
            }));
            return _el$14;
          })();
        }
      }));
      effect(_$p => setProp(_el$, "class", classNames({
        'Show': getOpen()
      }), _$p));
      return _el$;
    })();
  }

  function ServiceTopBarBG() {
    return (() => {
      const _el$8 = createElement("Panel", {
          id: "ServiceTopBarActive"
        }, null);
        createElement("Panel", {
          "class": 'BG'
        }, _el$8);
      insert(_el$8, createComponent(Yzy_IconButton, {
        type: "icon_btn_close_1",
        onactivate: () => {
          SwitchServicePage('');
        }
      }), null);
      return _el$8;
    })();
  }

  function Conclusion() {
    var _a;
    let refTagFX;
    let refLightFX;
    const [getCheckUpdate] = useNetEventTable(t => t, 'conclusion', 'check_update');
    const [getData] = useNetEventTable(t => t, 'conclusion', 'conclusion');
    const getGameTime = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.game_time) !== null && _b !== void 0 ? _b : 0;
    };
    const getPlayerData = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.player;
    };
    const getWin = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.win;
    };
    const getMvpPlayerID = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.mvp_pid;
    };
    const [getOpen, setOpen] = createSignal(false);
    const [getStep, setStep] = createSignal(0);
    const [getPage, setPage] = createSignal(0);
    const [getEquipDrawData] = useNetEventTable(t => t, 'conclusion', () => 'equip_draw_' + getter_iLocalPlayer());
    const getEndTime = () => {
      var _a;
      return (_a = getEquipDrawData()) === null || _a === void 0 ? void 0 : _a.end_time;
    };
    const getEquipList = () => {
      var _a;
      return (_a = getEquipDrawData()) === null || _a === void 0 ? void 0 : _a.rewards;
    };
    const getIsMvp = () => {
      var _a;
      return (_a = getEquipDrawData()) === null || _a === void 0 ? void 0 : _a.is_mvp;
    };
    const getCount = () => {
      var _a, _b;
      return (_b = (_a = getEquipDrawData()) === null || _a === void 0 ? void 0 : _a.count) !== null && _b !== void 0 ? _b : 0;
    };
    const getFinish = () => {
      var _a;
      return (_a = getEquipDrawData()) === null || _a === void 0 ? void 0 : _a.finfish;
    };
    const getCost = createMemo(() => {
      var _a, _b;
      return Str2RewardMap((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['equip_reward_add_cost']) !== null && _b !== void 0 ? _b : '');
    });
    const getLocalPlayerID = useLocalPlayer();
    const isHost = createMemo(() => PlayerHost() == getLocalPlayerID());
    const [getRewardData] = useNetEventTable(t => t, 'conclusion', () => 'reward_' + getter_iLocalPlayer());
    const [getTowerRewardData] = useNetEventTable(t => t, 'conclusion', () => 'tower_reward_' + getter_iLocalPlayer());
    createEffect(() => {
      const id = EventManager.Reg('ON_SERVICE_SWITCH', ({
        sPage
      }) => {
        setOpen(sPage == "Conclusion");
      });
      onCleanup(() => {
        EventManager.Unreg('ON_SERVICE_SWITCH', id);
      });
    });
    const fTagFX1Delay = 0.3;
    const fTagFX2Delay = 3;
    createEffect(on(getData, () => {
      var _a, _b;
      setOpen(true);
      setStep(0);
      setPage(0);
      if (getCheckUpdate() == 2) return Game.Disconnect();
      SwitchServicePage("Conclusion");
      if (getPlayerData() == undefined) return;
      Game.EmitSound(getWin() ? "dsadowski_01.stinger.radiant_win" : "dsadowski_01.stinger.radiant_lose");
      let id;
      let id1;
      let iPtclID;
      if (refTagFX && refLightFX) {
        if (getWin()) {
          iPtclID = Particles.CreateParticle('particles/juwai/screen_arcane_drop_5.vpcf', 0, Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer()));
        }
        refTagFX === null || refTagFX === void 0 ? void 0 : refTagFX.RemoveAndDeleteChildren();
        refLightFX === null || refLightFX === void 0 ? void 0 : refLightFX.RemoveAndDeleteChildren();
        $.CreatePanel('DOTAParticleScenePanel', refTagFX, 'TagFX1', {
          particleName: getWin() ? "particles/ui/conclusion/victory_fx/victory_fx.vpcf" : "particles/ui/conclusion/defeated_fx/defeated_fx.vpcf",
          fov: 90,
          lookAt: "0 0 0",
          cameraOrigin: "0 0 500",
          squarePixels: true,
          hittest: false
        });
        const language = $.Language().toLocaleLowerCase();
        const WinFx = {
          schinese: "particles/ui/conclusion/victory_title/victory_title.vpcf",
          english: "particles/ui/conclusion/victory_title/victory_title_en.vpcf",
          russian: "particles/ui/conclusion/victory_title/victory_title_ru.vpcf"
        };
        const LoseFx = {
          schinese: "particles/ui/conclusion/defeated_title/defeated_title.vpcf",
          english: "particles/ui/conclusion/defeated_title/defeated_title_en.vpcf",
          russian: "particles/ui/conclusion/defeated_title/defeated_title_ru.vpcf"
        };
        $.CreatePanel('DOTAParticleScenePanel', refTagFX, 'TagFX2', {
          particleName: getWin() ? (_a = WinFx[language]) !== null && _a !== void 0 ? _a : WinFx["english"] : (_b = LoseFx[language]) !== null && _b !== void 0 ? _b : LoseFx["english"],
          fov: 90,
          lookAt: "0 0 0",
          cameraOrigin: "0 0 200",
          squarePixels: true,
          hittest: false
        });
        $.CreatePanel('DOTAParticleScenePanel', refLightFX, 'LightFX', {
          particleName: getWin() ? 'particles/ui/conclusion/victory_light/victory_light.vpcf' : 'particles/ui/conclusion/defeated_light/defeated_light.vpcf',
          fov: 90,
          lookAt: "0 0 0",
          cameraOrigin: "0 0 -256",
          squarePixels: true,
          hittest: false
        });
        id = Timer(() => {
          setStep(1);
        }, fTagFX1Delay, undefined, 'Conclusion.setStep');
        id1 = Timer(() => {
          setStep(2);
          setPage(1);
        }, fTagFX2Delay, undefined, 'Conclusion.setStep1');
      }
      onCleanup(() => {
        if (id != undefined) {
          StopTimer(id);
        }
        if (id1 != undefined) {
          StopTimer(id1);
        }
        if (iPtclID != undefined) {
          Particles.DestroyParticleEffect(iPtclID, false);
        }
      });
    }));
    const getSortPlayer = createMemo(on(getData, () => {
      var _a, _b;
      const tt = [];
      for (const pid in (_a = getData()) === null || _a === void 0 ? void 0 : _a.player) {
        const t = (_b = getData()) === null || _b === void 0 ? void 0 : _b.player[pid];
        tt.push({
          'pid': pid,
          'dps': (t === null || t === void 0 ? void 0 : t.dps) || 0
        });
      }
      tt.sort((a, b) => b.dps - a.dps);
      return tt;
    }));
    const getPlayerMain = () => {
      var _a;
      const tReward = [];
      for (const t of (_a = getRewardData()) !== null && _a !== void 0 ? _a : []) {
        if (!t.equips && !t.gems && !t.ancients && !t.holies) {
          tReward.push(t);
        }
      }
      if (getTowerRewardData()) {
        for (const key in getTowerRewardData()) {
          const t = getTowerRewardData()[key];
          if (t) {
            tReward.push(t);
          }
        }
      }
      return tReward;
    };
    const getPlayerEquips = () => {
      var _a;
      const tReward = [];
      for (const t of (_a = getRewardData()) !== null && _a !== void 0 ? _a : []) {
        if (t.equips || t.gems || t.ancients || t.holies) {
          tReward.push(t);
        }
      }
      return tReward;
    };
    return (() => {
      const _el$ = createElement("Panel", {
          id: "Conclusion",
          hittest: false,
          get ["class"]() {
            return classNames("Step_" + getStep(), 'Page_' + getPage(), {
              'Show': getOpen(),
              'GameWin': getWin()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        const _el$3 = createElement("Panel", {
          id: "HeroPage",
          hittest: false
        }, _el$),
        _el$4 = createElement("Panel", {
          id: "PlayerContainer",
          get ["class"]() {
            return "PlayerCount" + getSortPlayer().length;
          },
          hittest: false
        }, _el$3),
        _el$5 = createElement("Panel", {
          id: "HeroFXContainer",
          hittest: false
        }, _el$3),
        _el$6 = createElement("Panel", {
          id: "EquipDraw"
        }, _el$),
        _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$6),
        _el$8 = createElement("Panel", {
          id: "CountDownPanel"
        }, _el$7),
        _el$0 = createElement("Panel", {
          id: "PickCountContainer"
        }, _el$7),
        _el$1 = createElement("Label", {
          id: "PickCountLabel",
          get text() {
            return ReplaceTextVariable("#PickCountLabel", {
              'val': getCount()
            });
          },
          html: true
        }, _el$0),
        _el$11 = createElement("Panel", {
          id: "ExtraDropProbability"
        }, _el$7);
        createElement("Label", {
          "class": "Title",
          text: "#ExtraDropProbabilityTitle"
        }, _el$11);
        const _el$13 = createElement("Panel", {
          id: "ResultList",
          hittest: false
        }, _el$7),
        _el$14 = createElement("Panel", {
          id: "OperateGroup"
        }, _el$7),
        _el$16 = createElement("Panel", {
          "class": "ServiceAssetGroup"
        }, _el$6),
        _el$17 = createElement("Panel", {
          id: "ConclusionReslut"
        }, _el$),
        _el$18 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$17),
        _el$19 = createElement("Panel", {
          id: "TotalGameTime"
        }, _el$18),
        _el$20 = createElement("Label", {
          get text() {
            return ReplaceTextVariable('#TotalGameTime', {
              'val': FormatTime(getGameTime(), FormatTimeStyle.Clock_ms)
            });
          }
        }, _el$19),
        _el$21 = createElement("Panel", {
          "class": "RewardContainer"
        }, _el$18),
        _el$22 = createElement("Panel", {
          id: "Header"
        }, _el$21);
        createElement("Panel", {
          "class": "LeftLine"
        }, _el$22);
        createElement("Label", {
          "class": "Title",
          text: "#MainRewardTitle"
        }, _el$22);
        createElement("Panel", {
          "class": "RightLine"
        }, _el$22);
        const _el$26 = createElement("Panel", {
          "class": "Body"
        }, _el$21),
        _el$27 = createElement("Panel", {
          "class": "RewardContainer"
        }, _el$18),
        _el$28 = createElement("Panel", {
          id: "Header"
        }, _el$27);
        createElement("Panel", {
          "class": "LeftLine"
        }, _el$28);
        createElement("Label", {
          "class": "Title",
          text: "#OtherRewardTitle"
        }, _el$28);
        createElement("Panel", {
          "class": "RightLine"
        }, _el$28);
        const _el$32 = createElement("Panel", {
          "class": "Body"
        }, _el$27),
        _el$33 = createElement("Panel", {
          "class": "ButtonGroup",
          hittest: false
        }, _el$17),
        _el$34 = createElement("Panel", {
          id: "TagFXContainer",
          hittest: false
        }, _el$),
        _el$35 = createElement("Panel", {
          id: "LightFXContainer",
          hittest: false
        }, _el$);
      insert(_el$4, createComponent(Index, {
        get each() {
          return getSortPlayer();
        },
        children: (getVal, i) => {
          var _a, _b;
          const getPlayerID = () => Number(getVal().pid);
          const getDps = () => getVal().dps;
          const getUnitName = () => NetEventData.GetTableValue('hero_' + Players.GetPlayerHeroEntityIndex(getPlayerID()), 'skin_name');
          const getKv = () => CustomHeroesKv[getUnitName()];
          return (() => {
            const _el$36 = createElement("Panel", {
                id: 'Player_' + i,
                get ["class"]() {
                  return classNames('PlayerRow');
                },
                hittest: false
              }, null),
              _el$37 = createElement("Panel", {
                id: "PlayerDetial"
              }, _el$36),
              _el$38 = createElement("Label", {
                id: "UserName",
                get text() {
                  return Players.GetPlayerName(getPlayerID());
                },
                html: true
              }, _el$37),
              _el$39 = createElement("Panel", {
                "class": "Body"
              }, _el$37),
              _el$40 = createElement("Label", {
                id: "HeroName",
                get text() {
                  return $.Localize("#" + ((_b = (_a = CustomHeroesKv[getUnitName()]) === null || _a === void 0 ? void 0 : _a['id']) !== null && _b !== void 0 ? _b : getUnitName()));
                },
                html: true
              }, _el$39),
              _el$41 = createElement("Label", {
                id: "Dps",
                get text() {
                  return `${Round(getDps(), 2)}%`;
                }
              }, _el$39),
              _el$42 = createElement("Panel", {
                id: "HeroModelScene",
                hittest: false
              }, _el$36);
            use(p => {
              $.Schedule(fTagFX1Delay + fTagFX2Delay + Math.max(i * 0.25 - 0.05) + 0.3, () => {
                if (p && p.IsValid()) {
                  p.AddClass("Show");
                }
              });
            }, _el$36);
            setProp(_el$36, "id", 'Player_' + i);
            insert(_el$39, createComponent(Yzy_Icon, {
              type: "icon_score"
            }), _el$41);
            insert(_el$42, createComponent(WearableHero, {
              get tItems() {
                return WearableCfgByKv(getKv()).items;
              },
              hittest: false,
              hittestchildren: false
            }));
            insert(_el$36, createComponent(Show, {
              get when() {
                return getMvpPlayerID() == getPlayerID();
              },
              get children() {
                return createElement("Panel", {
                  id: "MVPImage",
                  hittest: false
                }, null);
              }
            }), null);
            effect(_p$ => {
              const _v$5 = classNames('PlayerRow'),
                _v$6 = Players.GetPlayerName(getPlayerID()),
                _v$7 = $.Localize("#" + ((_b = (_a = CustomHeroesKv[getUnitName()]) === null || _a === void 0 ? void 0 : _a['id']) !== null && _b !== void 0 ? _b : getUnitName())),
                _v$8 = `${Round(getDps(), 2)}%`;
              _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$36, "class", _v$5, _p$._v$5));
              _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$38, "text", _v$6, _p$._v$6));
              _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$40, "text", _v$7, _p$._v$7));
              _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$41, "text", _v$8, _p$._v$8));
              return _p$;
            }, {
              _v$5: undefined,
              _v$6: undefined,
              _v$7: undefined,
              _v$8: undefined
            });
            return _el$36;
          })();
        }
      }));
      insert(_el$5, createComponent(Index, {
        get each() {
          return getSortPlayer();
        },
        children: (getVal, i) => {
          return (() => {
            const _el$44 = createElement("DOTAParticleScenePanel", {
              hittest: false,
              "class": "HeroFX",
              particleName: "particles/ui/conclusion/hero_ending/hero_ending.vpcf",
              cameraOrigin: "0 0 900",
              lookAt: "0 0 0",
              fov: 110
            }, null);
            use(p => {
              $.Schedule(fTagFX1Delay + fTagFX2Delay + Math.max(i * 0.25 - 0.05), () => {
                p.ReloadScene();
                p.AddClass("Show");
                Game.EmitSound("UI.Draw.Fall");
              });
            }, _el$44);
            return _el$44;
          })();
        }
      }));
      insert(_el$3, createComponent(Yzy_Button, {
        id: "NextPageBtn",
        type: "btn_purple",
        size: 'Small',
        text: '#NextPageTitle',
        onactivate: p => {
          setPage(getWin() ? 2 : 3);
        }
      }), null);
      insert(_el$8, createComponent(CountDown, {
        id: "CountDown",
        get fTimeEnd() {
          return getEndTime();
        },
        get children() {
          return createElement("Label", {
            id: "TimeLabel",
            text: "{s:countdown_time}"
          }, null);
        }
      }));
      insert(_el$0, createComponent(Show, {
        get when() {
          return getIsMvp();
        },
        get children() {
          const _el$10 = createElement("Label", {
            id: "MvpExtra",
            get text() {
              return ReplaceTextVariable("#EquipDrawMvpExtra", {
                'val': (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['equip_reward_mvp_times']
              });
            },
            html: true
          }, null);
          effect(_$p => setProp(_el$10, "text", ReplaceTextVariable("#EquipDrawMvpExtra", {
            'val': (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['equip_reward_mvp_times']
          }), _$p));
          return _el$10;
        }
      }), null);
      insert(_el$7, () => {
        const getStat = createMemo(() => {
          var _a, _b, _c, _d;
          const tEquipStat = {};
          for (const t of (_a = getEquipList()) !== null && _a !== void 0 ? _a : []) {
            const tEquip = (_b = t.equips) === null || _b === void 0 ? void 0 : _b[0];
            if (tEquip && tEquip.equips != undefined) {
              tEquipStat[tEquip.equips.rarity] = ((_c = tEquipStat[tEquip.equips.rarity]) !== null && _c !== void 0 ? _c : 0) + 1;
            }
          }
          const tStat = [];
          for (let i = 1; i <= 6; i++) {
            tStat.push({
              'rarity': i,
              'count': (_d = tEquipStat[i]) !== null && _d !== void 0 ? _d : 0
            });
          }
          return tStat;
        });
        return (() => {
          const _el$45 = createElement("Panel", {
            id: "QualityStatistic"
          }, null);
          insert(_el$45, createComponent(Index, {
            get each() {
              return getStat();
            },
            children: (getVal, i) => {
              return (() => {
                const _el$46 = createElement("Panel", {
                    "class": "QualityItem"
                  }, null);
                  createElement("Panel", {
                    "class": "RarityBG"
                  }, _el$46);
                  const _el$48 = createElement("Label", {
                    get text() {
                      return `x ${getVal().count}`;
                    }
                  }, _el$46);
                effect(_p$ => {
                  const _v$9 = {
                      ['Rarity_' + getVal().rarity]: true
                    },
                    _v$0 = `x ${getVal().count}`;
                  _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$46, "classList", _v$9, _p$._v$9));
                  _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$48, "text", _v$0, _p$._v$0));
                  return _p$;
                }, {
                  _v$9: undefined,
                  _v$0: undefined
                });
                return _el$46;
              })();
            }
          }));
          return _el$45;
        })();
      }, _el$11);
      insert(_el$11, () => {
        const getProbability = createMemo(() => {
          var _a, _b, _c;
          return (_c = (_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a['1185001']) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
        });
        return (() => {
          const _el$49 = createElement("Label", {
            "class": "Value",
            html: true,
            get text() {
              return ReplaceTextVariable("#ExtraDropProbabilityValue", getProbability());
            }
          }, null);
          effect(_$p => setProp(_el$49, "text", ReplaceTextVariable("#ExtraDropProbabilityValue", getProbability()), _$p));
          return _el$49;
        })();
      }, null);
      insert(_el$13, createComponent(Index, {
        get each() {
          return getEquipList();
        },
        children: (getResult, i) => {
          var _a, _b, _c, _d;
          const [getSelectIdx, setSelectIdx] = createSignal(0);
          const getItem = () => {
            var _a, _b;
            return (_b = (_a = getResult()) === null || _a === void 0 ? void 0 : _a.equips) === null || _b === void 0 ? void 0 : _b[getSelectIdx()];
          };
          const getRarity = () => {
            var _a;
            return ((_a = getItem().equips) === null || _a === void 0 ? void 0 : _a.rarity) || 1;
          };
          const getFlip = () => {
            var _a;
            return (_a = getResult()) === null || _a === void 0 ? void 0 : _a.flip;
          };
          const getIndex = () => {
            var _a;
            return (_a = getResult()) === null || _a === void 0 ? void 0 : _a.index;
          };
          const getBlinkFxName = () => {
            return {
              '4': 'particles/ui/draw/draw_blink_fx_2/draw_blink_fx_2.vpcf',
              '5': 'particles/ui/draw/draw_blink_fx_3/draw_blink_fx_3.vpcf',
              '6': 'particles/ui/draw/draw_blink_fx_4/draw_blink_fx_4.vpcf'
            }[getRarity()];
          };
          const getFxName = () => {
            return {
              '3': 'particles/ui/draw/draw_fx_1/draw_fx_1.vpcf',
              '4': 'particles/ui/draw/draw_fx_2/draw_fx_2.vpcf',
              '5': 'particles/ui/draw/draw_fx_3/draw_fx_3.vpcf',
              '6': 'particles/ui/draw/draw_fx_4/draw_fx_4.vpcf'
            }[getRarity()];
          };
          const fAnimationDelay = 0.14;
          let refResultItem;
          createEffect(on(getSelectIdx, () => {
            if (refResultItem && getFlip()) {
              refResultItem.TriggerClass('FilpAni');
            }
          }));
          return (() => {
            const _el$50 = createElement("Panel", {
                get ["class"]() {
                  return classNames("ResultItem", 'Rarity_' + getRarity(), {
                    Flip: getFlip() || getFinish()
                  });
                },
                hittest: false
              }, null),
              _el$51 = createElement("Panel", {
                id: "FlipContainer"
              }, _el$50);
              createElement("Panel", {
                "class": "BackImg"
              }, _el$51);
              createElement("Panel", {
                "class": "RarityBG"
              }, _el$51);
              createElement("Panel", {
                "class": "ClipContainer"
              }, _el$51);
            const _ref$3 = refResultItem;
            typeof _ref$3 === "function" ? use(_ref$3, _el$50) : refResultItem = _el$50;
            setProp(_el$50, "onload", p => {
              $.Schedule(Math.max(0, i * fAnimationDelay - i * 0.02), () => {
                if (p.IsValid()) {
                  p.AddClass(i % 2 != 0 ? "FadeTop" : 'PreFadeBottom');
                  p.AddClass("FadeOk");
                }
              });
            });
            setProp(_el$51, "onactivate", p => {
              if (getFinish() || getFlip()) return;
              if (getCount() <= 0) return ErrorMsg('error_not_enough_equip_draw_count');
              GameEvents.SendCustomGameEventToServer('OnEquipDraw', {
                'index': getIndex()
              });
              if (getRarity() >= 5) {
                Game.EmitSound("ui.treasure_01");
              } else if (getRarity() >= 4) {
                Game.EmitSound("Item.DropGemShop");
              } else if (getRarity() >= 3) {
                Game.EmitSound("Item.DropRingShop");
              } else {
                Game.EmitSound("DrawEquip.Rarity1");
              }
              if (getBlinkFxName()) {
                $.CreatePanel('DOTAParticleScenePanel', p.GetParent(), 'CardFxShow', {
                  particleName: getBlinkFxName(),
                  fov: 110,
                  lookAt: "0 0 0",
                  cameraOrigin: "0 0 100",
                  squarePixels: true,
                  hittest: false
                });
              }
              if (getFxName()) {
                $.Schedule(0.5, () => {
                  $.CreatePanel('DOTAParticleScenePanel', p.GetParent(), 'CardFx', {
                    particleName: getFxName(),
                    fov: 110,
                    lookAt: "0 0 0",
                    cameraOrigin: "0 0 100",
                    squarePixels: true,
                    hittest: false
                  });
                });
              }
            });
            insert(_el$51, createComponent(Yzy_ServiceItemName, {
              get data() {
                return getItem();
              }
            }), null);
            insert(_el$51, createComponent(Yzy_ServiceItem, {
              get data() {
                return getItem();
              },
              nobg: true
            }), null);
            insert(_el$51, createComponent(Show, {
              get when() {
                return (_a = getResult()) === null || _a === void 0 ? void 0 : _a.flip;
              },
              get children() {
                return createComponent(Yzy_Icon, {
                  type: "icon_y"
                });
              }
            }), null);
            insert(_el$51, createComponent(Show, {
              get when() {
                return ((_b = getResult()) === null || _b === void 0 ? void 0 : _b.equips.length) > 1;
              },
              get children() {
                return [(() => {
                  const _el$55 = createElement("Panel", {
                      "class": "CountContainer"
                    }, null),
                    _el$56 = createElement("Label", {
                      "class": "CountLabel",
                      get text() {
                        return `x ${(_c = getResult()) === null || _c === void 0 ? void 0 : _c.equips.length}`;
                      }
                    }, _el$55);
                  effect(_$p => setProp(_el$56, "text", `x ${(_c = getResult()) === null || _c === void 0 ? void 0 : _c.equips.length}`, _$p));
                  return _el$55;
                })(), (() => {
                  const _el$57 = createElement("Panel", {
                    "class": "Selection"
                  }, null);
                  insert(_el$57, createComponent(Index, {
                    get each() {
                      return (_d = getResult()) === null || _d === void 0 ? void 0 : _d.equips;
                    },
                    children: (_, i) => {
                      return (() => {
                        const _el$58 = createElement("Panel", {
                            "class": "SelectionItem"
                          }, null);
                          createElement("Panel", {
                            "class": "SelectionItemBg"
                          }, _el$58);
                        setProp(_el$58, "onactivate", () => {
                          setSelectIdx(i);
                        });
                        effect(_$p => setProp(_el$58, "classList", {
                          ['Selected']: getSelectIdx() == i
                        }, _$p));
                        return _el$58;
                      })();
                    }
                  }));
                  return _el$57;
                })()];
              }
            }), null);
            effect(_$p => setProp(_el$50, "class", classNames("ResultItem", 'Rarity_' + getRarity(), {
              Flip: getFlip() || getFinish()
            }), _$p));
            return _el$50;
          })();
        }
      }));
      insert(_el$14, createComponent(Show, {
        get when() {
          return !getFinish();
        },
        get children() {
          return [(() => {
            const _el$15 = createElement("Panel", {
              id: "AddPickCount"
            }, null);
            insert(_el$15, createComponent(Yzy_Button, {
              type: "btn_golden",
              text: "#AddPickCount",
              onactivate: () => {
                var _a;
                let iNotFlipCount = 0;
                (_a = getEquipList()) === null || _a === void 0 ? void 0 : _a.forEach(v => {
                  if (!v.flip) {
                    iNotFlipCount++;
                  }
                });
                if (iNotFlipCount <= getCount()) return ErrorMsg("error_max_equip_draw_count");
                ShowMouseProcessing();
                Request('EquipDraw_PickCount', {}).then(res => {
                  HideMouseProcessing();
                  if ((res === null || res === void 0 ? void 0 : res.code) != 0) {
                    if (res === null || res === void 0 ? void 0 : res.msg) {
                      ErrorMsg(res === null || res === void 0 ? void 0 : res.msg);
                    }
                    return;
                  }
                });
              }
            }), null);
            insert(_el$15, createComponent(Yzy_ServiceAssetCost, {
              get cost() {
                return getCost();
              }
            }), null);
            return _el$15;
          })(), createComponent(Yzy_Button, {
            id: "ConfirmEquipDraw",
            get enabled() {
              return getCount() <= 0;
            },
            type: "btn_purple",
            text: "#ConfirmEquipDraw",
            onactivate: () => {
              if (getCount() > 0 || getFinish()) return;
              ShowMouseProcessing();
              Request('EquipDraw_Confirm', {}).then(res => {
                HideMouseProcessing();
                if ((res === null || res === void 0 ? void 0 : res.code) != 0) {
                  if (res === null || res === void 0 ? void 0 : res.msg) {
                    ErrorMsg(res === null || res === void 0 ? void 0 : res.msg);
                  }
                  return;
                }
              });
            }
          })];
        }
      }), null);
      insert(_el$14, createComponent(Show, {
        get when() {
          return getFinish();
        },
        get children() {
          return createComponent(Yzy_Button, {
            id: "Confirm",
            type: "btn_purple",
            text: "#Confirm",
            onactivate: p => {
              if (!getFinish()) return;
              setPage(3);
            }
          });
        }
      }), null);
      insert(_el$6, createComponent(ServiceTopBarBG, {}), _el$16);
      insert(_el$16, createComponent(ServiceItemAsset, {
        item_id: "2020001"
      }));
      insert(_el$26, createComponent(For, {
        get each() {
          return getPlayerMain();
        },
        children: t => {
          var _a, _b;
          return createComponent(Show, {
            get when() {
              return t.count && t.count > 0;
            },
            get children() {
              const _el$60 = createElement("Panel", {
                "class": "MainRewardItem"
              }, null);
              insert(_el$60, createComponent(Yzy_ServiceItem, {
                data: t
              }), null);
              insert(_el$60, createComponent(Show, {
                get when() {
                  return (_a = t === null || t === void 0 ? void 0 : t.convert) === null || _a === void 0 ? void 0 : _a[0];
                },
                get children() {
                  return [createElement("Label", {
                    "class": "TipText",
                    text: '#ConclusionConvert'
                  }, null), createComponent(Yzy_ServiceItemName, {
                    get data() {
                      return (_b = t === null || t === void 0 ? void 0 : t.convert) === null || _b === void 0 ? void 0 : _b[0];
                    },
                    bShowCount: true
                  })];
                }
              }), null);
              return _el$60;
            }
          });
        }
      }));
      insert(_el$32, createComponent(For, {
        get each() {
          return getPlayerEquips();
        },
        children: t => t.count && t.count > 0 ? createComponent(Yzy_ServiceItem, {
          data: t
        }) : null
      }));
      insert(_el$33, createComponent(Yzy_Button, {
        id: "Exit",
        type: "btn_purple",
        size: 'Small',
        text: "#ExitTitle",
        onactivate: () => {
          SwitchServicePage('');
        }
      }), null);
      insert(_el$33, createComponent(Yzy_Button, {
        id: "GotoArchiveChallenge",
        type: "btn_golden",
        size: 'Small',
        text: "#GotoArchiveChallenge",
        onactivate: () => {
          SwitchServicePage('');
          const hFountain = NetEventData.GetTableValue('common', 'npc_archive');
          if (Entities.IsValidEntity(hFountain || -1)) {
            GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(hFountain), 1);
          } else {
            GameUI.SetCameraTargetPosition([0, 0, 0], 1);
          }
        }
      }), null);
      insert(_el$33, createComponent(Show, {
        get when() {
          return isHost();
        },
        get children() {
          return createComponent(Yzy_Button, {
            id: "Restart",
            type: "btn_purple",
            size: 'Small',
            get text() {
              return getCheckUpdate() == 1 ? '#NeedRestart' : '#RestartTitle';
            },
            onactivate: p => {
              if (getCheckUpdate() == undefined) return;
              if (getCheckUpdate() == 1) return Game.Disconnect();
              GameEvents.SendCustomGameEventToServer('OnOnceAgain', {
                'page': 'conclusion'
              });
            }
          });
        }
      }), null);
      const _ref$ = refTagFX;
      typeof _ref$ === "function" ? use(_ref$, _el$34) : refTagFX = _el$34;
      const _ref$2 = refLightFX;
      typeof _ref$2 === "function" ? use(_ref$2, _el$35) : refLightFX = _el$35;
      effect(_p$ => {
        const _v$ = classNames("Step_" + getStep(), 'Page_' + getPage(), {
            'Show': getOpen(),
            'GameWin': getWin()
          }),
          _v$2 = "PlayerCount" + getSortPlayer().length,
          _v$3 = ReplaceTextVariable("#PickCountLabel", {
            'val': getCount()
          }),
          _v$4 = ReplaceTextVariable('#TotalGameTime', {
            'val': FormatTime(getGameTime(), FormatTimeStyle.Clock_ms)
          });
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$4, "class", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$1, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$20, "text", _v$4, _p$._v$4));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined
      });
      return _el$;
    })();
  }

  const ServGetter_UserMiningCollect = useNetEventTable(t => t, 'service', () => 'UserMiningCollect_' + getter_iLocalPlayer())[0];

  function GsMode1() {
    var _a;
    const [getMode] = useNetEventTable(t => t, 'common', 'mode');
    const getScoreText = createMemo(() => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
      const score = (_c = (_b = (_a = ServGetter_UserGetLimit()) === null || _a === void 0 ? void 0 : _a["2030018"]) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
      const limit = ((_e = (_d = ServGetter_UserGetLimit()) === null || _d === void 0 ? void 0 : _d["2030018"]) === null || _e === void 0 ? void 0 : _e.limit) ? (_g = (_f = ServGetter_UserGetLimit()) === null || _f === void 0 ? void 0 : _f["2030018"]) === null || _g === void 0 ? void 0 : _g.limit : (_k = (_j = (_h = CfgGetter_get_limit()) === null || _h === void 0 ? void 0 : _h["2030018"]) === null || _j === void 0 ? void 0 : _j.limit_count) !== null && _k !== void 0 ? _k : 0;
      return `${score} / ${limit}`;
    });
    const getBaseDrop = createMemo(() => {
      var _a;
      const tCfg = (_a = CfgGetter_mining_drop()) !== null && _a !== void 0 ? _a : {};
      const tList = Object.values(tCfg).filter(item => item.extra == 1 || item.extra == 2);
      return tList;
    });
    const getAdvancedDrop = createMemo(() => {
      var _a;
      const tCfg = (_a = CfgGetter_mining_drop()) !== null && _a !== void 0 ? _a : {};
      const tList = Object.values(tCfg).filter(item => item.extra == 3);
      return tList;
    });
    const [getShowCount] = useNetEventTable(t => t, 'gs_mode_1', 'player_show_rewards');
    const [getStartTime] = useNetEventTable(t => t !== null && t !== void 0 ? t : 0, 'gs_mode_1', 'start_time');
    const [getShowTime, setShowTime] = createSignal(0);
    createEffect(() => {
      getStartTime();
      const iTimer = Timer(() => {
        setShowTime(Math.floor(Game.GetGameTime() - getStartTime()));
        return 1;
      }, 0);
      onCleanup(() => {
        StopTimer(iTimer);
      });
    });
    const [getPrvg1180121Local] = useNetEventTable(t => {
      return (t === null || t === void 0 ? void 0 : t['1180121']) || 0;
    }, 'privilege', () => getter_iLocalPlayer());
    return (() => {
      const _el$ = createElement("Panel", {
          id: "GsMode1",
          get ["class"]() {
            return 'Mode_' + getMode();
          },
          hittest: false
        }, null),
        _el$2 = createElement("Panel", {
          "class": "Content"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$2);
        createElement("Panel", {
          "class": "TitleBG"
        }, _el$2);
        const _el$5 = createElement("Panel", {
          "class": "GetScore"
        }, _el$2),
        _el$6 = createElement("Label", {
          "class": "ScoreText",
          get text() {
            return `${$.Localize("#Mode1_GetScore_Today")} ${getScoreText()}`;
          }
        }, _el$5);
        createElement("Label", {
          "class": "TipText",
          text: "#Mode1_GetScore_Tip"
        }, _el$5);
        const _el$8 = createElement("Panel", {
          "class": "PropsList"
        }, _el$2),
        _el$9 = createElement("Panel", {
          "class": "GetShow"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$9);
        const _el$1 = createElement("Panel", {
          "class": "Body"
        }, _el$9),
        _el$10 = createElement("Label", {
          "class": "TimeLabel",
          get text() {
            return `${$.Localize("#Mode1_GetShow_Time")} ${FormatTime(getShowTime())}`;
          }
        }, _el$1),
        _el$11 = createElement("Panel", {
          "class": "GetShowTitle"
        }, _el$1);
        createElement("Panel", {
          "class": "BG"
        }, _el$11);
        createElement("Label", {
          "class": "Title",
          text: "#Mode1_GetShow_ThisGetBase"
        }, _el$11);
        const _el$14 = createElement("Panel", {
          "class": "GetShowList Base"
        }, _el$1),
        _el$15 = createElement("Panel", {
          "class": "GetShowTitle"
        }, _el$1);
        createElement("Panel", {
          "class": "BG"
        }, _el$15);
        createElement("Label", {
          "class": "Title",
          text: "#Mode1_GetShow_ThisGetAdvanced"
        }, _el$15);
        const _el$18 = createElement("Panel", {
          "class": "GetShowList Advanced"
        }, _el$1),
        _el$19 = createElement("Panel", {
          "class": "Operate"
        }, _el$1);
      insert(_el$8, createComponent(For, {
        get each() {
          return Object.values((_a = CfgGetter_mining_props()) !== null && _a !== void 0 ? _a : {});
        },
        children: item => {
          var _a, _b, _c, _d, _e;
          return (() => {
            const _el$20 = createElement("Panel", {
              "class": "PropsItem",
              hittestchildren: false
            }, null);
            setProp(_el$20, "onmouseover", p => {
              var _a;
              ShowTooltip(p, 'common_detail_tooltip', {
                'sTitle': $.Localize(`#${item.id}`),
                'sContext': ReplaceTextVariable(`#Mode1_Props_Tooltip_${item.id}_Desc`, {
                  limit: (_a = Str2RewardMap(item.effect)) === null || _a === void 0 ? void 0 : _a[1185005],
                  interval: item.interval,
                  extar2: item.extra_chance.split('|')[0],
                  extar3: item.extra_chance.split('|')[1]
                }) + '<br />' + $.Localize(`#Mode1_Props_Tooltip_${item.id}_Source`)
              });
            });
            setProp(_el$20, "onmouseout", p => {
              HideTooltip();
            });
            insert(_el$20, createComponent(Yzy_ServiceItem, {
              get data() {
                return {
                  id: String(item.id),
                  count: (_e = (_d = (_c = ServGetter_UserItem()) === null || _c === void 0 ? void 0 : _c[item.id]) === null || _d === void 0 ? void 0 : _d.count) !== null && _e !== void 0 ? _e : 0
                };
              },
              rarity: 3,
              hittest: false
            }));
            effect(_$p => setProp(_el$20, "classList", {
              Has: !!((_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a[item.id]) === null || _b === void 0 ? void 0 : _b.count)
            }, _$p));
            return _el$20;
          })();
        }
      }));
      insert(_el$14, createComponent(For, {
        get each() {
          return getBaseDrop();
        },
        children: item => {
          var _a, _b, _c, _d;
          return (() => {
            const _el$21 = createElement("Panel", {
              "class": "GetShowItem",
              hittestchildren: false
            }, null);
            setProp(_el$21, "onmouseover", p => {
              var _a, _b, _c;
              ShowTooltip(p, 'common_detail_tooltip', {
                sTitle: String($.Localize(`#${item.id}`)),
                tGroups: Str2RewardList((_c = (_b = (_a = CfgGetter_mining_drop()) === null || _a === void 0 ? void 0 : _a[item.id]) === null || _b === void 0 ? void 0 : _b.reward) !== null && _c !== void 0 ? _c : []).map(item => {
                  return {
                    'sContext': $.Localize(`#${item[0]}`) + ' x ' + String(item[1])
                  };
                })
              });
            });
            setProp(_el$21, "onmouseout", p => {
              HideTooltip();
            });
            insert(_el$21, createComponent(Yzy_ServiceItem, {
              get data() {
                return {
                  id: String(item.id),
                  count: (_d = (_c = getShowCount()) === null || _c === void 0 ? void 0 : _c[item.id]) !== null && _d !== void 0 ? _d : 0
                };
              },
              get rarity() {
                return item.rarity;
              },
              hittest: false
            }));
            effect(_$p => setProp(_el$21, "classList", {
              Active: ((_b = (_a = getShowCount()) === null || _a === void 0 ? void 0 : _a[item.id]) !== null && _b !== void 0 ? _b : 0) > 0
            }, _$p));
            return _el$21;
          })();
        }
      }));
      insert(_el$18, createComponent(For, {
        get each() {
          return getAdvancedDrop();
        },
        children: item => {
          var _a, _b, _c, _d, _e, _f;
          return (() => {
            const _el$22 = createElement("Panel", {
              "class": "GetShowItem",
              hittestchildren: false
            }, null);
            setProp(_el$22, "onmouseover", p => {
              var _a, _b, _c, _d;
              ShowTooltip(p, 'common_detail_tooltip', {
                sTitle: String($.Localize(`#${item.id}`)),
                tAttribute: (_d = (_c = (_b = (_a = CfgGetter_mining_collect()) === null || _a === void 0 ? void 0 : _a[item.id]) === null || _b === void 0 ? void 0 : _b.effect) === null || _c === void 0 ? void 0 : _c.split('|')) !== null && _d !== void 0 ? _d : [],
                sPrivilegeAttribute: getPrvg1180121Local() > 0 ? '1180121' : undefined
              });
            });
            setProp(_el$22, "onmouseout", p => {
              HideTooltip();
            });
            insert(_el$22, createComponent(Yzy_ServiceItem, {
              get data() {
                return {
                  id: String(item.id),
                  count: (_f = (_e = (_d = ServGetter_UserMiningCollect()) === null || _d === void 0 ? void 0 : _d[item.id]) === null || _e === void 0 ? void 0 : _e.level) !== null && _f !== void 0 ? _f : 0
                };
              },
              get rarity() {
                return item.rarity;
              },
              hittest: false
            }));
            effect(_$p => setProp(_el$22, "classList", {
              Active: ((_c = (_b = (_a = ServGetter_UserMiningCollect()) === null || _a === void 0 ? void 0 : _a[item.id]) === null || _b === void 0 ? void 0 : _b.level) !== null && _c !== void 0 ? _c : 0) > 0
            }, _$p));
            return _el$22;
          })();
        }
      }));
      insert(_el$19, createComponent(Yzy_Button, {
        type: "btn_golden",
        text: "#Mode1_Operate_Exit",
        onactivate: p => {
          ShowPopup('common_popup', {
            'sTitle': $.Localize('#Mode1_Operate_Exit_Confirm_Title'),
            'sContext': $.Localize('#Mode1_Operate_Exit_Confirm_Content'),
            'OnConfirm': () => {
              GameEvents.SendCustomGameEventToServer('on_mode_1_mining_exit', {});
            }
          });
        }
      }));
      effect(_p$ => {
        const _v$ = 'Mode_' + getMode(),
          _v$2 = `${$.Localize("#Mode1_GetScore_Today")} ${getScoreText()}`,
          _v$3 = `${$.Localize("#Mode1_GetShow_Time")} ${FormatTime(getShowTime())}`;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$6, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$10, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }

  const CfgGetter_novice_guide = useSystemConfig('novice_guide');

  function NoviceGuide() {
    const [getTaskID] = useNetEventTable(t => t, 'novice_guide', () => 'task_' + getter_iLocalPlayer());
    const [getNoviceGuide] = useNetEventTable(t => t, 'novice_guide', () => 'novice_guide_' + getter_iLocalPlayer());
    const getName = () => 'novice_guide_' + getTaskID();
    const getData = () => {
      var _a;
      return (_a = getNoviceGuide()) === null || _a === void 0 ? void 0 : _a[getName()];
    };
    const getTaskProgress = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.task_progress) || 0;
    };
    const getMaxTaskProgress = () => {
      var _a, _b;
      return ((_b = (_a = CfgGetter_novice_guide()) === null || _a === void 0 ? void 0 : _a[getName()]) === null || _b === void 0 ? void 0 : _b['TaskProgress']) || 0;
    };
    const getTaskRewardList = () => {
      var _a, _b;
      return ((_b = (_a = CfgGetter_novice_guide()) === null || _a === void 0 ? void 0 : _a[getName()]) === null || _b === void 0 ? void 0 : _b['RewardList']) || '';
    };
    const getRewardDesc = () => {
      let s = '';
      getTaskRewardList().split('|').forEach(sReward => {
        const getKey = () => sReward.split('=')[0];
        const getVal = () => sReward.split('=')[1];
        if (getKey().startsWith('gold') || getKey().startsWith('wood') || getKey().startsWith('kill') || getKey().startsWith('exp')) {
          s += $.Localize("#NoviceGuide_" + getKey()) + GreenText(' +' + getVal());
        } else if (getKey().startsWith('special_ablt')) {
          s += ReplaceTextVariable('#NoviceGuide_' + getKey(), {
            'val': getVal()
          });
        } else if (getKey().startsWith('item_1')) {
          s += $.Localize("#DOTA_TOOLTIP_ability_" + getKey()) + '*' + getVal();
        }
      });
      return s;
    };
    return (() => {
      const _el$ = createElement("Panel", {
          id: "NoviceGuide",
          get ["class"]() {
            return classNames({
              'Show': getData() != undefined
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        createElement("Panel", {
          "class": "BG1"
        }, _el$);
        const _el$4 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$5 = createElement("Panel", {
          "class": "Header"
        }, _el$4);
        createElement("Label", {
          text: "#NoviceGuide"
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$4),
        _el$8 = createElement("Label", {
          "class": "TaskDesc",
          get text() {
            return ReplaceTextVariable('#' + getName(), {
              'val': getTaskProgress(),
              'max_val': getMaxTaskProgress()
            });
          },
          html: true
        }, _el$7),
        _el$9 = createElement("Label", {
          "class": "RewardDesc",
          get text() {
            return getRewardDesc();
          },
          html: true
        }, _el$7);
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getData() != undefined
          }),
          _v$2 = ReplaceTextVariable('#' + getName(), {
            'val': getTaskProgress(),
            'max_val': getMaxTaskProgress()
          }),
          _v$3 = getRewardDesc();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$9, "text", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }

  const ServGetter_UserEquipWear = useNetEventTable(t => t, 'service', () => 'UserEquipWear_' + getter_iLocalPlayer())[0];

  const ServGetter_UserEquip = useNetEventTable(t => t, 'service', () => 'UserEquip_' + getter_iLocalPlayer())[0];

  const ServGetter_UserEquipEnhance = useNetEventTable(t => t, 'service', () => 'UserEquipEnhance_' + getter_iLocalPlayer())[0];

  function PackEquipItem(params) {
    var _a;
    const [local, props] = splitProps(params, ['data', 'item_id']);
    const getData = (_a = local.data) !== null && _a !== void 0 ? _a : createMemo(() => {
      var _a;
      return ((_a = ServGetter_UserEquip()) === null || _a === void 0 ? void 0 : _a[local.item_id]) || {};
    });
    const getItemID = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.id;
    });
    const getPart = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    });
    const getClass = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.class;
    });
    const getRarity = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity;
    });
    const getImage = () => `file://{images}/custom_game/service/equip/equip_part/equip_${getPart()}_${getClass()}.png`;
    const getIsLock = createMemo(() => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.lock) == 1;
    });
    const getIsSystemLock = createMemo(() => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.lock) == 2;
    });
    const getIsNew = createMemo(() => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.new) == 1;
    });
    const [getHasWear, setHasWear] = createSignal(false);
    const [getOwnerPage, setOwnerPage] = createSignal(-1);
    const getPartEnhanceLevel = () => {
      var _a, _b;
      return ((_b = (_a = ServGetter_UserEquipEnhance()) === null || _a === void 0 ? void 0 : _a[`1${getPart()}01`]) === null || _b === void 0 ? void 0 : _b.enhance) || 0;
    };
    const [getPrvg96Local] = useNetEventTable(t => {
      return (t === null || t === void 0 ? void 0 : t['1180096']) || 0;
    }, 'privilege', () => getter_iLocalPlayer());
    const getPrvg96 = () => {
      return getPrvg96Local();
    };
    if (!props.no_local) {
      createEffect(() => {
        const t = ServGetter_UserEquipWear();
        const data = getData();
        let bHasWear = false;
        if (t) {
          for (const sSlot in t) {
            if (data.id == t[sSlot]) {
              setOwnerPage(Number(sSlot.substring(1, 3)));
              bHasWear = true;
              break;
            }
          }
        }
        setHasWear(bHasWear);
      });
    }
    return (() => {
      const _el$ = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames("PackEquipItem", 'Rarity_' + getRarity());
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$4 = createElement("Image", {
          "class": "Image",
          get src() {
            return getImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$3);
      spread(_el$, mergeProps(props, {
        get ["class"]() {
          return classNames("PackEquipItem", 'Rarity_' + getRarity());
        },
        "onmouseover": p => {
          var _a;
          (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
          ShowTooltip(p, 'equip_tooltip', {
            type: 'Equip',
            data: getData(),
            local: props.no_local,
            part_level: () => {
              var _a;
              return ((_a = local.data) === null || _a === void 0 ? void 0 : _a.call(local)['part_level']) || getPartEnhanceLevel();
            },
            prvg96: () => {
              var _a;
              return ((_a = local.data) === null || _a === void 0 ? void 0 : _a.call(local)['prvg96']) || getPrvg96();
            },
            compareData: props.compareData
          });
        },
        "onmouseout": p => {
          var _a, _b;
          (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
          HideTooltip();
          if (getIsNew()) {
            GameUI.CustomUIConfig()['Equip_Touch'] = (_b = GameUI.CustomUIConfig()['Equip_Touch']) !== null && _b !== void 0 ? _b : [];
            GameUI.CustomUIConfig()['Equip_Touch'].push(getItemID());
            Timer(() => {
              Request('Equip_Touch', {
                'ids': GameUI.CustomUIConfig()['Equip_Touch']
              });
              delete GameUI.CustomUIConfig()['Equip_Touch'];
            }, 1, "PackEquipItem_Touch");
          }
        }
      }), true);
      insert(_el$3, createComponent(Show, {
        get when() {
          return getIsLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'Lock',
            type: "icon_equip_lock"
          });
        }
      }), null);
      insert(_el$3, createComponent(Show, {
        get when() {
          return getIsSystemLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'SystemLock',
            type: "icon_system_lock"
          });
        }
      }), null);
      insert(_el$3, createComponent(Show, {
        get when() {
          return getIsNew();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'New',
            type: "icon_new"
          });
        }
      }), null);
      insert(_el$3, createComponent(Show, {
        get when() {
          return getClass() != undefined;
        },
        get children() {
          const _el$5 = createElement("Panel", {
              "class": "Class"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$5);
            const _el$7 = createElement("Label", {
              "class": "ClassLabel",
              get text() {
                return ReplaceTextVariable('#EquipClass', {
                  'val': getClass()
                });
              },
              html: true
            }, _el$5);
          effect(_$p => setProp(_el$7, "text", ReplaceTextVariable('#EquipClass', {
            'val': getClass()
          }), _$p));
          return _el$5;
        }
      }), null);
      insert(_el$3, createComponent(Show, {
        get when() {
          return getHasWear();
        },
        get children() {
          return [(() => {
            const _el$8 = createElement("Panel", {
                "class": "PartEnhance"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$8);
              const _el$0 = createElement("Label", {
                "class": "PartEnhanceLabel",
                get text() {
                  return '+' + getPartEnhanceLevel();
                }
              }, _el$8);
            effect(_$p => setProp(_el$0, "text", '+' + getPartEnhanceLevel(), _$p));
            return _el$8;
          })(), (() => {
            const _el$1 = createElement("Panel", {
                "class": "Wear",
                hittest: false
              }, null),
              _el$10 = createElement("Label", {
                "class": "WearLabel",
                get text() {
                  return `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`;
                }
              }, _el$1);
            insert(_el$1, createComponent(Yzy_Icon, {
              "class": "BG",
              type: "icon_equip_wear",
              hittest: false
            }), _el$10);
            effect(_$p => setProp(_el$10, "text", `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`, _$p));
            return _el$1;
          })()];
        }
      }), null);
      effect(_$p => setProp(_el$4, "src", getImage(), _$p));
      return _el$;
    })();
  }

  function DragonWish() {
    var _a;
    const [getDragonWishData] = useNetEventTable(t => t, 'dragon_wish', () => getter_iLocalPlayer());
    const getState = createMemo(() => {
      var _a;
      return ((_a = getDragonWishData()) === null || _a === void 0 ? void 0 : _a.state) || 0;
    });
    const getSelectIndex = createMemo(() => {
      var _a, _b;
      return ((_b = (_a = getDragonWishData()) === null || _a === void 0 ? void 0 : _a.reward) === null || _b === void 0 ? void 0 : _b.index) || 0;
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "DragonWish",
          get ["class"]() {
            return classNames("DragonWish", {
              "Show": getDragonWishData() != undefined
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        const _el$5 = createElement("Panel", {
          "class": "Content"
        }, _el$3),
        _el$8 = createElement("Panel", {
          "class": "TitlePanel"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$8);
        createElement("Label", {
          "class": "Title",
          text: "#DragonWish"
        }, _el$8);
      insert(_el$5, createComponent(Show, {
        get when() {
          return getState() == 1;
        },
        get children() {
          const _el$6 = createElement("Panel", {
            "class": "OptionBtns"
          }, null);
          insert(_el$6, createComponent(Index, {
            each: [0, 1, 2, 3],
            children: (_, index) => {
              return (() => {
                const _el$1 = createElement("TextButton", {
                  "class": "OptionBtn",
                  text: `#wish_desc_${index + 1}`
                }, null);
                setProp(_el$1, "text", `#wish_desc_${index + 1}`);
                setProp(_el$1, "onactivate", p => {
                  GameEvents.SendCustomGameEventToServer('OnDragonWish', {
                    index: index
                  });
                });
                return _el$1;
              })();
            }
          }));
          return _el$6;
        }
      }), null);
      insert(_el$5, createComponent(Show, {
        get when() {
          return getState() == 2;
        },
        get children() {
          const _el$7 = createElement("Panel", {
            "class": "DragonWishReward"
          }, null);
          insert(_el$7, createComponent(DragonWishReward, {
            get reward_desc() {
              return `#reward_desc_${getSelectIndex() + 1}`;
            },
            get reward() {
              return (_a = getDragonWishData()) === null || _a === void 0 ? void 0 : _a.reward;
            }
          }));
          return _el$7;
        }
      }), null);
      effect(_$p => setProp(_el$, "class", classNames("DragonWish", {
        "Show": getDragonWishData() != undefined
      }), _$p));
      return _el$;
    })();
  }
  function DragonWishReward(params) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
    return (() => {
      const _el$10 = createElement("Panel", {
          "class": "RewardPanel"
        }, null),
        _el$11 = createElement("Label", {
          "class": "RewardDesc",
          get text() {
            return params.reward_desc;
          }
        }, _el$10),
        _el$12 = createElement("Panel", {
          "class": "RewardGroup"
        }, _el$10);
        createTextNode(`/**木材 */`, _el$12);
        const _el$15 = createTextNode(`/**进化次数 */`, _el$12),
        _el$17 = createTextNode(`/**物品 */`, _el$12),
        _el$20 = createTextNode(`/**装备 */`, _el$12),
        _el$23 = createElement("TextButton", {
          "class": "OptionBtn",
          text: "#reward_close"
        }, _el$10);
      insert(_el$12, createComponent(Show, {
        get when() {
          return (_a = params.reward) === null || _a === void 0 ? void 0 : _a.wood;
        },
        get children() {
          const _el$14 = createElement("Label", {
            "class": "RewardWood",
            text: "#reward_wood",
            html: true,
            get dialogVariables() {
              return {
                'wood': ((_b = params === null || params === void 0 ? void 0 : params.reward) === null || _b === void 0 ? void 0 : _b.wood) || 0
              };
            }
          }, null);
          effect(_$p => setProp(_el$14, "dialogVariables", {
            'wood': ((_b = params === null || params === void 0 ? void 0 : params.reward) === null || _b === void 0 ? void 0 : _b.wood) || 0
          }, _$p));
          return _el$14;
        }
      }), _el$15);
      insert(_el$12, createComponent(Show, {
        get when() {
          return (_c = params.reward) === null || _c === void 0 ? void 0 : _c.EvolveCount;
        },
        get children() {
          const _el$16 = createElement("Label", {
            "class": "RewardEvolveCount",
            text: "#reward_evolve_count",
            html: true,
            get dialogVariables() {
              return {
                'evolve_count': ((_d = params === null || params === void 0 ? void 0 : params.reward) === null || _d === void 0 ? void 0 : _d.EvolveCount) || 0
              };
            }
          }, null);
          effect(_$p => setProp(_el$16, "dialogVariables", {
            'evolve_count': ((_d = params === null || params === void 0 ? void 0 : params.reward) === null || _d === void 0 ? void 0 : _d.EvolveCount) || 0
          }, _$p));
          return _el$16;
        }
      }), _el$17);
      insert(_el$12, createComponent(Show, {
        get when() {
          return (_e = params.reward) === null || _e === void 0 ? void 0 : _e.items;
        },
        get children() {
          return [createElement("Label", {
            "class": "RewardItems",
            text: "#reward_items"
          }, null), (() => {
            const _el$19 = createElement("Panel", {
              "class": "RewardItemList"
            }, null);
            insert(_el$19, createComponent(Index, {
              get each() {
                return (_g = (_f = params.reward) === null || _f === void 0 ? void 0 : _f.items) !== null && _g !== void 0 ? _g : [];
              },
              children: item => {
                var _a;
                return createComponent(Yzy_ItemImage, {
                  get name() {
                    return item();
                  },
                  get rarity() {
                    return (_a = ItemsKv[item()]) === null || _a === void 0 ? void 0 : _a['Rarity'];
                  },
                  onmouseover: p => {
                    ShowTooltip(p, 'game_item_tooltip', {
                      'sItemName': item()
                    });
                  },
                  onmouseout: HideTooltip
                });
              }
            }));
            return _el$19;
          })()];
        }
      }), _el$20);
      insert(_el$12, createComponent(Show, {
        get when() {
          return (_h = params.reward) === null || _h === void 0 ? void 0 : _h.Equips;
        },
        get children() {
          return [createElement("Label", {
            "class": "RewardEquips",
            text: "#reward_equips"
          }, null), (() => {
            const _el$22 = createElement("Panel", {
              "class": "RewardEquipList"
            }, null);
            insert(_el$22, createComponent(Index, {
              get each() {
                return (_k = (_j = params.reward) === null || _j === void 0 ? void 0 : _j.Equips) !== null && _k !== void 0 ? _k : [];
              },
              children: item => {
                const getEquipData = () => {
                  var _a;
                  return (_a = item()) === null || _a === void 0 ? void 0 : _a.equips;
                };
                return createComponent(Show, {
                  get when() {
                    return getEquipData() !== undefined;
                  },
                  get children() {
                    return createComponent(PackEquipItem, {
                      data: () => getEquipData()
                    });
                  }
                });
              }
            }));
            return _el$22;
          })()];
        }
      }), null);
      setProp(_el$23, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnDragonWishEnd', {});
      });
      effect(_$p => setProp(_el$11, "text", params.reward_desc, _$p));
      return _el$10;
    })();
  }

  function SelectionAttributeConversion() {
    var _a, _b;
    const [getAttributeConversionSelection] = useNetEventTable(t => t, 'attribute_conversion_stone', () => getter_iLocalPlayer());
    const getShow = createMemo(() => {
      var _a;
      return ((_a = getAttributeConversionSelection()) === null || _a === void 0 ? void 0 : _a.options) != undefined;
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "AttributeConversion",
          get ["class"]() {
            return classNames({
              'Show': getShow()
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Header"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$3);
        const _el$5 = createElement("Label", {
          get text() {
            return $.Localize('#AttributeConversion');
          }
        }, _el$3),
        _el$6 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$7 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$6);
      insert(_el$7, createComponent(Show, {
        get when() {
          return getShow();
        },
        get children() {
          return createComponent(Index, {
            get each() {
              return (_b = (_a = getAttributeConversionSelection()) === null || _a === void 0 ? void 0 : _a.options) !== null && _b !== void 0 ? _b : [];
            },
            children: (option, i) => {
              var _a, _b, _c;
              return (() => {
                const _el$8 = createElement("Panel", {
                    get ["class"]() {
                      return classNames('SelectionRow');
                    }
                  }, null);
                  createElement("Panel", {
                    "class": "BG"
                  }, _el$8);
                  const _el$0 = createElement("Label", {
                    "class": "Desc",
                    html: true,
                    get text() {
                      return ReplaceTextVariable('#AttributeConversionDesc', {
                        id1: $.Localize(`#${(_a = option()) === null || _a === void 0 ? void 0 : _a.id1}`),
                        id2: $.Localize(`#${(_b = option()) === null || _b === void 0 ? void 0 : _b.id2}`),
                        val: (_c = option()) === null || _c === void 0 ? void 0 : _c.val
                      });
                    }
                  }, _el$8);
                setProp(_el$8, "onactivate", () => {
                  var _a, _b;
                  if ((_b = (_a = getAttributeConversionSelection()) === null || _a === void 0 ? void 0 : _a.options) === null || _b === void 0 ? void 0 : _b[0]) {
                    GameEvents.SendCustomGameEventToServer('OnAttributeConversion', {
                      'index': i
                    });
                  }
                });
                effect(_p$ => {
                  const _v$3 = classNames('SelectionRow'),
                    _v$4 = ReplaceTextVariable('#AttributeConversionDesc', {
                      id1: $.Localize(`#${(_a = option()) === null || _a === void 0 ? void 0 : _a.id1}`),
                      id2: $.Localize(`#${(_b = option()) === null || _b === void 0 ? void 0 : _b.id2}`),
                      val: (_c = option()) === null || _c === void 0 ? void 0 : _c.val
                    });
                  _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$8, "class", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$0, "text", _v$4, _p$._v$4));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined
                });
                return _el$8;
              })();
            }
          });
        }
      }));
      effect(_p$ => {
        const _v$ = classNames({
            'Show': getShow()
          }),
          _v$2 = $.Localize('#AttributeConversion');
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$5, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }

  const CfgGetter_challenge = useSystemConfig('challenge');

  function Challenge() {
    const [getChallenge] = useNetEventTable(t => t, 'challenge', () => 'challenge_' + getter_iLocalPlayer());
    return (() => {
      const _el$ = createElement("Panel", {
          id: "Challenge",
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$);
      insert(_el$3, createComponent(Index, {
        each: ['challenge_1', 'challenge_2', 'challenge_3', 'challenge_4'],
        children: (getName, i) => {
          const getCfg = () => {
            var _a;
            return (_a = CfgGetter_challenge()) === null || _a === void 0 ? void 0 : _a[getName()];
          };
          const getData = () => {
            var _a;
            return (_a = getChallenge()) === null || _a === void 0 ? void 0 : _a[getName()];
          };
          const getCount = () => {
            var _a;
            return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.count) || 0;
          };
          const getMaxCount = () => {
            var _a;
            return (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['MaxLevel'];
          };
          const getEndTime = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.end_time;
          };
          const getChargingCount = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.charging_count;
          };
          const getChargingInterval = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.charging_interval;
          };
          const getChargingEndTime = () => {
            var _a, _b, _c, _d;
            return (_d = (_c = (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.charging_end_time) === null || _b === void 0 ? void 0 : _b[0]) === null || _c === void 0 ? void 0 : _c.time) !== null && _d !== void 0 ? _d : 0;
          };
          const getNeedKillCount = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.need_kill_count;
          };
          const getCanCount = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.can_count;
          };
          const getIsMaxLevel = () => getMaxCount() != undefined && getCount() >= getMaxCount();
          const getAuto = () => {
            var _a;
            return (_a = getData()) === null || _a === void 0 ? void 0 : _a.auto;
          };
          const getActive = createMemo(() => {
            if (getIsMaxLevel()) {
              return false;
            }
            if (getCanCount() != undefined && (getCanCount() || 0) <= 0) {
              return false;
            }
            return true;
          });
          const getResCost = () => {
            var _a, _b;
            const sResCost = (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['ResCost'];
            if (sResCost != undefined) {
              const sResType = sResCost.split("=")[0];
              const iResVal = sResCost.split("=")[1].includes('|') ? (_b = sResCost.split("=")[1].split('|')) === null || _b === void 0 ? void 0 : _b[getCount()] : sResCost.split("=")[1];
              return `${sResType}=${iResVal}`;
            }
            return;
          };
          const getTitle = () => {
            if (getName() == 'challenge_6' && getIsMaxLevel()) {
              return $.Localize('#' + getName() + '_replace');
            }
            return $.Localize('#' + getName()) + GreenText(`${' Lv ' + Math.min(getMaxCount(), getCount() + 1)}`);
          };
          const getImage = () => {
            if (getName() == 'challenge_6' && getIsMaxLevel()) {
              return `file://{images}/custom_game/challenge/${getName()}_replace.png`;
            }
            return `file://{images}/custom_game/challenge/${getName()}.png`;
          };
          return (() => {
            const _el$4 = createElement("Panel", {
                get ["class"]() {
                  return classNames('ChallengeRow', {
                    'Active': getActive()
                  });
                },
                onmouseout: HideTooltip
              }, null),
              _el$5 = createElement("Panel", {
                "class": "Body"
              }, _el$4);
              createElement("Panel", {
                "class": "BG"
              }, _el$5);
              const _el$7 = createElement("Panel", {
                "class": "Body"
              }, _el$5),
              _el$8 = createElement("Image", {
                id: "ChallengeRowImage",
                get src() {
                  return `file://{images}/custom_game/challenge/${getName()}.png`;
                },
                scaling: 'stretch-to-fit-y-preserve-aspect'
              }, _el$7),
              _el$11 = createElement("Label", {
                "class": "Name",
                get text() {
                  return '#' + getName();
                },
                html: true
              }, _el$4);
            setProp(_el$4, "onmouseover", p => {
              ShowTooltip(p, 'common_detail_tooltip', {
                'sTitle': getTitle(),
                'sImg': getImage(),
                'sRes': getResCost(),
                'tGroups': (() => {
                  var _a;
                  const tGroups = [];
                  if (getIsMaxLevel()) {
                    tGroups.push({
                      'sContext': $.Localize('#challenge_finish') + '<br/>'
                    });
                  } else {
                    tGroups.push({
                      'sContext': ReplaceTextVariable($.Localize('#' + getName() + '_des'), {
                        'val': (((_a = getCfg()) === null || _a === void 0 ? void 0 : _a['Reward']) || '').split('|')[getCount()]
                      }) + '<br/>' + '<br/>'
                    });
                  }
                  return tGroups;
                })(),
                'sTips': $.Localize("#ChallengeTips")
              });
            });
            setProp(_el$4, "onmouseout", HideTooltip);
            setProp(_el$4, "onactivate", () => {
              var _a, _b;
              if (getIsMaxLevel()) return ErrorMsg('error_max_level');
              if (getNeedKillCount() != undefined && (getNeedKillCount() || 0) > 0) return ErrorMsg('error_not_kill_finish');
              if (getEndTime() != undefined && Game.GetGameTime() < getEndTime()) return ErrorMsg('error_not_end_time');
              if (getCanCount() != undefined && (getCanCount() || 0) <= 0) return ErrorMsg('error_not_count_enough');
              if (getResCost() != undefined) {
                const sResType = (_a = getResCost()) === null || _a === void 0 ? void 0 : _a.split("=")[0];
                const iResVal = (_b = getResCost()) === null || _b === void 0 ? void 0 : _b.split("=")[1];
                if (GetRes(sResType, getter_iLocalPlayer()) < Number(iResVal)) return ErrorMsg(`error_not_enough_${sResType}`);
              }
              GameEvents.SendCustomGameEventToServer('OnChallenge', {
                'name': getName()
              });
            });
            setProp(_el$4, "oncontextmenu", () => {
              GameEvents.SendCustomGameEventToServer('OnToggleAtuoChallenge', {
                'name': getName()
              });
            });
            insert(_el$7, createComponent(Show, {
              get when() {
                return memo(() => getEndTime() != undefined)() && getEndTime() > Game.GetGameTime();
              },
              get children() {
                return createComponent(CooldownPanel, {
                  fEnd: getEndTime,
                  get fCD() {
                    return getChargingInterval();
                  },
                  hittest: false
                });
              }
            }), null);
            insert(_el$7, createComponent(Show, {
              get when() {
                return getChargingCount() != undefined;
              },
              get children() {
                return createComponent(ChallengeCharging, {
                  get iCharging() {
                    return getChargingCount();
                  },
                  get fEnd() {
                    return getChargingEndTime();
                  },
                  get fCD() {
                    return getCfg()['Interval'];
                  }
                });
              }
            }), null);
            insert(_el$7, createComponent(Show, {
              get when() {
                return getCanCount() != undefined;
              },
              get children() {
                const _el$9 = createElement("Panel", {
                    id: "CanChallengeCount",
                    hittest: false
                  }, null);
                  createElement("Panel", {
                    id: "CanChallengeCountBorder",
                    hittest: false
                  }, _el$9);
                  const _el$1 = createElement("Label", {
                    get text() {
                      return getCanCount();
                    }
                  }, _el$9);
                effect(_$p => setProp(_el$1, "text", getCanCount(), _$p));
                return _el$9;
              }
            }), null);
            insert(_el$5, createComponent(Show, {
              get when() {
                return getAuto();
              },
              get children() {
                return createElement("DOTAParticleScenePanel", {
                  "class": "AutoCastFX",
                  hittest: false,
                  particleName: "particles/ui/hud/autocasting_square.vpcf",
                  cameraOrigin: "0 0 45",
                  lookAt: "0 0 0",
                  fov: 90
                }, null);
              }
            }), null);
            effect(_p$ => {
              const _v$ = classNames('ChallengeRow', {
                  'Active': getActive()
                }),
                _v$2 = `file://{images}/custom_game/challenge/${getName()}.png`,
                _v$3 = getName(),
                _v$4 = '#' + getName();
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$4, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "src", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$11, "className", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$11, "text", _v$4, _p$._v$4));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined,
              _v$4: undefined
            });
            return _el$4;
          })();
        }
      }));
      return _el$;
    })();
  }
  function ChallengeCharging(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    const [getRemaining, setRemaining] = createSignal((getter.fEnd() || 0) - Game.GetGameTime());
    createEffect(() => {
      if (getter.fEnd() == undefined) {
        setRemaining(0);
        return;
      }
      const id = Timer(() => {
        setRemaining(getter.fEnd() - Game.GetGameTime());
        return 0.1;
      }, 0, undefined, 'ChallengeCharging.setRemaining');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$12 = createElement("Panel", {
          id: "ChallengeCharges",
          hittest: false
        }, null),
        _el$13 = createElement("Panel", {
          id: "ChallengeChargesBorder",
          hittest: false,
          get style() {
            return {
              clip: `radial( 50.0% 50.0%, 0.0deg, ${360 * (1 - Number((((_a = getRemaining()) !== null && _a !== void 0 ? _a : 0) / ((_b = getter.fCD()) !== null && _b !== void 0 ? _b : 1)).toFixed(2))) || 0}deg)`
            };
          }
        }, _el$12),
        _el$14 = createElement("Label", {
          get text() {
            return getter.iCharging();
          }
        }, _el$12);
      effect(_p$ => {
        const _v$5 = {
            clip: `radial( 50.0% 50.0%, 0.0deg, ${360 * (1 - Number((((_a = getRemaining()) !== null && _a !== void 0 ? _a : 0) / ((_b = getter.fCD()) !== null && _b !== void 0 ? _b : 1)).toFixed(2))) || 0}deg)`
          },
          _v$6 = getter.iCharging();
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$13, "style", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$14, "text", _v$6, _p$._v$6));
        return _p$;
      }, {
        _v$5: undefined,
        _v$6: undefined
      });
      return _el$12;
    })();
  }

  const CfgGetter_main_challenge = useSystemConfig('main_challenge');

  function MainChallengeRow() {
    var _a, _b;
    const [getMainChallenge] = useNetEventTable(t => t, 'main_challenge', () => 'challenge_' + getter_iLocalPlayer());
    const getName = () => {
      var _a;
      return 'main_challenge_' + ((_a = getMainChallenge()) === null || _a === void 0 ? void 0 : _a.level);
    };
    const getAuto = () => {
      var _a;
      return (_a = getMainChallenge()) === null || _a === void 0 ? void 0 : _a.auto;
    };
    const getCfg = () => {
      var _a;
      return (_a = CfgGetter_main_challenge()) === null || _a === void 0 ? void 0 : _a[getName() || ''];
    };
    const [getGameState] = useNetEventTable(t => t, 'common', 'game_state');
    const [getRound] = useNetEventTable(t => t, 'common', 'round');
    const [getPrvg1180101Local] = useNetEventTable(t => {
      return (t === null || t === void 0 ? void 0 : t['1180101']) || 0;
    }, 'privilege', () => getter_iLocalPlayer());
    const getShowFinalBoss = createMemo(() => {
      var _a, _b, _c;
      if (((_a = getGameState()) === null || _a === void 0 ? void 0 : _a.state_cur) != 'GS_Main') return false;
      if (((_c = (_b = getMainChallenge()) === null || _b === void 0 ? void 0 : _b.level) !== null && _c !== void 0 ? _c : 0) <= 45) return false;
      if (getPrvg1180101Local() > 0) {
        if ((getRound() || 0) < 1) return false;
      } else {
        if ((getRound() || 0) < 2) return false;
      }
      if (PlayerHost() != useLocalPlayer()()) return false;
      return true;
    });
    const getTitle = () => {
      var _a;
      return $.Localize('#main_challenge_' + ((_a = getMainChallenge()) === null || _a === void 0 ? void 0 : _a.level));
    };
    const getTaskConditionText = createMemo(() => {
      var _a, _b, _c, _d;
      const sUnitTarget = (_b = (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['UnitList']) !== null && _b !== void 0 ? _b : '';
      const sUnitName = sUnitTarget.split('=')[0];
      const iUnitCount = Number(sUnitTarget.split('=')[1]);
      return ReplaceTextVariable('#MainChallenge_TaskCondition', {
        'unit': $.Localize('#' + sUnitName),
        'target': iUnitCount,
        'current': SpanText(iUnitCount - ((_d = (_c = getMainChallenge()) === null || _c === void 0 ? void 0 : _c.need_kill_count) !== null && _d !== void 0 ? _d : iUnitCount), 'CurrentValue')
      });
    });
    const getDesc = () => {
      if ($.Localize('#' + getName() + '_desc') != '#' + getName() + '_desc') {
        return $.Localize('#' + getName() + '_desc');
      }
    };
    const getActive = createMemo(() => {
      var _a, _b;
      return ((_b = (_a = getCfg()) === null || _a === void 0 ? void 0 : _a['UnitList']) === null || _b === void 0 ? void 0 : _b.split('=')[0]) != undefined;
    });
    createEffect(() => {
      var _a, _b;
      const sKey = Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_F4];
      if (sKey) {
        const id = Keybinds.Bind(sKey, 1, () => {
          GameEvents.SendCustomGameEventToServer('OnClearChallenge', {});
        });
        onCleanup(() => {
          Keybinds.Unbind(id, sKey);
        });
      }
    });
    createEffect(() => {
      var _a, _b;
      const sKey = Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_H];
      if (sKey) {
        const id = Keybinds.Bind(sKey, 1, () => {
          GameEvents.SendCustomGameEventToServer('OnHeroHold', {});
        });
        onCleanup(() => {
          Keybinds.Unbind(id, sKey);
        });
      }
    });
    createEffect(() => {
      var _a, _b;
      const sKey = Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_F2];
      if (sKey) {
        const id = Keybinds.Bind(sKey, 1, () => {
          GameEvents.SendCustomGameEventToServer('OnBackMain', {});
        });
        onCleanup(() => {
          Keybinds.Unbind(id, sKey);
        });
      }
    });
    const getKeybind = createMemo(() => {
      var _a, _b;
      return Key2Command[(_b = (_a = getSettingData()) === null || _a === void 0 ? void 0 : _a.SetKeyVal) === null || _b === void 0 ? void 0 : _b.key_C];
    });
    return [(() => {
      const _el$ = createElement("Panel", {
          id: "MainChallengeRow",
          get ["class"]() {
            return classNames({
              'Active': getActive()
            });
          }
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$4 = createElement("Panel", {
          "class": "Title"
        }, _el$3);
        createElement("Panel", {
          "class": "BG"
        }, _el$4);
        const _el$6 = createElement("Label", {
          "class": "TitleText",
          get text() {
            return getTitle();
          }
        }, _el$4),
        _el$7 = createElement("Panel", {
          "class": "Content"
        }, _el$3),
        _el$13 = createElement("Panel", {
          "class": "Auto"
        }, _el$3);
        createElement("Panel", {
          "class": "BG"
        }, _el$13);
        const _el$16 = createElement("Label", {
          "class": "AutoText",
          text: '#MainChallengeAuto'
        }, _el$13);
      setProp(_el$, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('OnMainChallenge', {});
      });
      setProp(_el$, "oncontextmenu", () => {
        GameEvents.SendCustomGameEventToServer('OnToggleAtuoMainChallenge', {});
      });
      insert(_el$7, createComponent(Show, {
        get when() {
          return getCfg() != undefined;
        },
        get fallback() {
          return createElement("Label", {
            "class": "TaskCompleteTitle",
            text: '#main_challenge_complete'
          }, null);
        },
        get children() {
          return [(() => {
            const _el$8 = createElement("Panel", {
                "class": "TaskCondition"
              }, null);
              createElement("Label", {
                "class": "TaskConditionTitle",
                text: '#MainChallengeTask'
              }, _el$8);
              const _el$0 = createElement("Label", {
                "class": "TaskConditionText",
                get text() {
                  return getTaskConditionText();
                },
                html: true
              }, _el$8);
            effect(_$p => setProp(_el$0, "text", getTaskConditionText(), _$p));
            return _el$8;
          })(), (() => {
            const _el$1 = createElement("Panel", {
                "class": "TaskReward"
              }, null);
              createElement("Label", {
                "class": "TaskRewardTitle",
                text: '#MainChallengeReward'
              }, _el$1);
              const _el$11 = createElement("Panel", {
                "class": "TaskRewardList"
              }, _el$1);
            insert(_el$11, createComponent(Show, {
              get when() {
                return ((_a = getCfg()) === null || _a === void 0 ? void 0 : _a['RewardList']) != undefined;
              },
              get children() {
                return createComponent(Index, {
                  get each() {
                    return (((_b = getCfg()) === null || _b === void 0 ? void 0 : _b['RewardList']) || '').split('|');
                  },
                  children: item => {
                    const getNameAndValue = () => {
                      var _a;
                      let [sType, sCount] = item().split('=');
                      sCount = sCount && Number(sCount) > 0 ? `+${sCount}` : sCount;
                      let sKey = String(sType);
                      if (sKey.startsWith('sx_')) {
                        return [$.Localize("#" + sKey.substring(3)), sCount + ((_a = PctUnitAttributes[ID2Attribute[sKey.substring(3)].name]) !== null && _a !== void 0 ? _a : '')];
                      } else if (sKey.startsWith('gold') || sKey.startsWith('wood') || sKey.startsWith('kill') || sKey.startsWith('exp')) {
                        return [$.Localize("#MainChallenge_" + sKey), sCount];
                      } else if (sKey.startsWith('special_relic') || sKey.startsWith('special_ablt') || sKey.startsWith('special_hero')) {
                        return [ReplaceTextVariable('#MainChallenge_' + sKey, {
                          'val': sCount
                        })];
                      }
                      return [$.Localize("#" + sType), sCount];
                    };
                    return (() => {
                      const _el$24 = createElement("Panel", {
                          "class": "Yzy_Attribute"
                        }, null),
                        _el$25 = createElement("Label", {
                          get text() {
                            return getNameAndValue()[0];
                          },
                          html: true
                        }, _el$24);
                      setProp(_el$25, "className", "Name");
                      insert(_el$24, createComponent(Show, {
                        get when() {
                          return getNameAndValue()[1] != undefined;
                        },
                        get children() {
                          const _el$26 = createElement("Label", {
                            get text() {
                              return getNameAndValue()[1];
                            },
                            html: true
                          }, null);
                          setProp(_el$26, "className", "Value");
                          effect(_$p => setProp(_el$26, "text", getNameAndValue()[1], _$p));
                          return _el$26;
                        }
                      }), null);
                      effect(_$p => setProp(_el$25, "text", getNameAndValue()[0], _$p));
                      return _el$24;
                    })();
                  }
                });
              }
            }));
            return _el$1;
          })(), createComponent(Show, {
            get when() {
              return getDesc() != undefined;
            },
            get children() {
              const _el$12 = createElement("Label", {
                "class": "TaskDescText",
                get text() {
                  return getDesc();
                },
                html: true
              }, null);
              effect(_$p => setProp(_el$12, "text", getDesc(), _$p));
              return _el$12;
            }
          })];
        }
      }));
      setProp(_el$13, "onactivate", () => {
        GameEvents.SendCustomGameEventToServer('OnToggleAtuoMainChallenge', {});
      });
      insert(_el$13, createComponent(Show, {
        get when() {
          return getAuto();
        },
        get children() {
          return createElement("Panel", {
            "class": "AutoIcon"
          }, null);
        }
      }), _el$16);
      insert(_el$3, createComponent(KeybindButton, {
        id: "MainChallengeBtn",
        "class": "AutoBtn",
        get key() {
          return getKeybind();
        },
        onactivate: () => {
          GameEvents.SendCustomGameEventToServer('OnMainChallenge', {});
        },
        get children() {
          return [(() => {
            const _el$17 = createElement("Label", {
              id: "HotKey",
              get text() {
                return getKeybind();
              }
            }, null);
            effect(_$p => setProp(_el$17, "text", getKeybind(), _$p));
            return _el$17;
          })(), createElement("Label", {
            "class": "AutoText",
            text: '#MainChallengeBtn'
          }, null)];
        }
      }), null);
      effect(_p$ => {
        const _v$ = classNames({
            'Active': getActive()
          }),
          _v$2 = getTitle();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$6, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })(), (() => {
      const _el$19 = createElement("Panel", {
          "class": "HudChallengeGroupList"
        }, null),
        _el$20 = createElement("Panel", {
          id: "ChallengeFinalBoss"
        }, _el$19);
        createElement("Panel", {
          "class": "BG"
        }, _el$20);
        createElement("Label", {
          "class": "ChallengeFinalBossLabel",
          text: "#ChallengeFinalBoss"
        }, _el$20);
      insert(_el$19, createComponent(HeroChallengeRow, {}), _el$20);
      setProp(_el$20, "onactivate", p => {
        GameEvents.SendCustomGameEventToServer('OnChallengeFinalBoss', {});
      });
      effect(_$p => setProp(_el$20, "classList", {
        'Show': getShowFinalBoss()
      }, _$p));
      return _el$19;
    })()];
  }
  function HeroChallengeRow() {
    const [getChellengeEffect] = useNetEventTable(t => t !== null && t !== void 0 ? t : {}, 'hero_challenge', 'challenge_effect');
    return (() => {
      const _el$27 = createElement("Panel", {
          id: "HudHeroChallengeRow",
          onmouseout: HideTooltip
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$27);
        createElement("Label", {
          "class": "HeroChallengeLabel",
          text: "#HudHeroChallengeText"
        }, _el$27);
      setProp(_el$27, "onmouseover", p => {
        ShowTooltip(p, 'common_detail_tooltip', {
          'sTitle': '#HudHeroChallengeText',
          'tAttribute': Object.entries(getChellengeEffect()).map(([key, value]) => `${key}=${value}`)
        });
      });
      setProp(_el$27, "onmouseout", HideTooltip);
      effect(_$p => setProp(_el$27, "classList", {
        'Show': Object.keys(getChellengeEffect()).length > 0
      }, _$p));
      return _el$27;
    })();
  }

  const CfgGetter_ablts_hero_exp = useSystemConfig('ablts_hero_exp');

  const AbltsHeroKv = createMemo(() => {
    const tCfg = CfgGetter_ablts_hero_exp();
    const tResult = {};
    if (tCfg) {
      for (const k in AbilitiesKv) {
        const tKv = AbilitiesKv[k];
        if (tCfg[tKv['id']]) {
          tResult[tKv['id']] = tKv;
        }
      }
    }
    return tResult;
  });

  function AbilityBanCard() {
    const [bSystemEnable] = useNetEventTable(t => {
      return t !== null && t !== void 0 ? t : false;
    }, 'abilities', 'bancard_system_enable');
    const [fSystemEndTime] = useNetEventTable(t => t !== null && t !== void 0 ? t : 0, 'abilities', 'bancard_end_time');
    const [getCurBancardData] = useNetEventTable(t => {
      return t !== null && t !== void 0 ? t : {
        can_bancard_count: 0,
        bancard_list: [],
        is_confirm: false
      };
    }, 'abilities', () => 'ability_bancard_' + getter_iLocalPlayer());
    const getShowSelectBanCardPanel = createMemo(() => {
      return getCurBancardData().can_bancard_count > 0 && bSystemEnable() && Game.GetDOTATime(true, true) <= fSystemEndTime() && getCurBancardData().is_confirm == false;
    });
    const getShowHasBanCard = createMemo(() => {
      return getCurBancardData().is_confirm == true && getCurBancardData().can_bancard_count > 0;
    });
    const getBancardRemainCount = createMemo(() => {
      return getCurBancardData().can_bancard_count - getCurBancardData().bancard_list.length;
    });
    const onClickCard = name => {
      if (getCurBancardData().bancard_list.includes(name)) {
        GameEvents.SendCustomGameEventToServer('OnAbilityUnbancard', {
          'name': name
        });
      } else {
        GameEvents.SendCustomGameEventToServer('OnAbilityBancard', {
          'name': name
        });
      }
    };
    return (() => {
      const _el$ = createElement("Panel", {
          id: "AbilityBanCardRoot",
          hittest: false
        }, null),
        _el$2 = createElement("Panel", {
          id: "AbilityBanCard",
          "class": "AbilityBanCard"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$2);
        const _el$4 = createElement("Panel", {
          "class": "Header"
        }, _el$2);
        createElement("Panel", {
          "class": "TopLine"
        }, _el$4);
        createElement("Label", {
          "class": "Title",
          text: '#AbilityBanCardTitle'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$2),
        _el$8 = createElement("Panel", {
          "class": "CardList"
        }, _el$7),
        _el$9 = createElement("Panel", {
          "class": "Footer"
        }, _el$2),
        _el$0 = createElement("Label", {
          "class": "CountRemainLabel",
          html: true,
          get text() {
            return ReplaceTextVariable("#AbilityBanCardCountRemain", getBancardRemainCount());
          }
        }, _el$9),
        _el$11 = createElement("Panel", {
          id: "AbilityBanCardShow"
        }, _el$);
        createElement("Panel", {
          "class": "BG"
        }, _el$11);
        const _el$13 = createElement("Panel", {
          "class": "Header"
        }, _el$11);
        createElement("Label", {
          "class": "Title",
          text: '#AbilityBanCardShowTitle'
        }, _el$13);
        const _el$15 = createElement("Panel", {
          "class": "AbilityBanCardShowList"
        }, _el$11);
      setProp(_el$2, "onactivate", () => {});
      insert(_el$8, createComponent(For, {
        get each() {
          return Object.keys(AbltsHeroKv());
        },
        children: (sAbilityId, i) => {
          const tKv = AbltsHeroKv()[sAbilityId];
          if (tKv['name'] == 'base_1') {
            return null;
          }
          return (() => {
            const _el$16 = createElement("Panel", {
                "class": "CardItem"
              }, null),
              _el$17 = createElement("Panel", {
                "class": "BanOverlay"
              }, _el$16);
              createElement("Label", {
                text: "#AbilityBanCardOverlay"
              }, _el$17);
            setProp(_el$16, "style", {
              tooltipPosition: 'right'
            });
            setProp(_el$16, "onactivate", p => {
              onClickCard(tKv['name']);
            });
            setProp(_el$16, "onmouseover", p => {
              $.DispatchEvent('DOTAShowTextTooltip', p, `#DOTA_TOOLTIP_ability_${tKv['name']}`);
            });
            setProp(_el$16, "onmouseout", p => {
              $.DispatchEvent('DOTAHideTextTooltip', p);
            });
            insert(_el$16, createComponent(Yzy_ItemImage, {
              id: "AbilityImage",
              get name() {
                return tKv['name'];
              },
              get image() {
                return `file://{images}/spellicons/${tKv['name']}.png`;
              },
              get rarity() {
                return tKv['Rarity'] || 1;
              },
              hittest: false
            }), _el$17);
            effect(_$p => setProp(_el$17, "classList", {
              "Show": getCurBancardData().bancard_list.includes(tKv['name'])
            }, _$p));
            return _el$16;
          })();
        }
      }));
      insert(_el$9, createComponent(Yzy_Button, {
        type: "btn_golden",
        size: 'Small',
        onactivate: () => {
          GameEvents.SendCustomGameEventToServer('OnAblituBancardConfirm', {});
        },
        get children() {
          return createComponent(CountDown, {
            fTimeEnd: fSystemEndTime,
            funcGetTime: () => Game.GetDOTATime(true, true),
            get children() {
              return [createElement("Label", {
                text: "#AbilityBanCardConfirmBtn"
              }, null), createElement("Label", {
                "class": "Time",
                text: "({s:countdown_time})"
              }, null)];
            }
          });
        }
      }), null);
      insert(_el$15, createComponent(For, {
        get each() {
          return getCurBancardData().bancard_list;
        },
        children: (sName, i) => {
          const tKv = AbilitiesKv[sName];
          if (!tKv) {
            $.Msg('AbilityBanCardShowItem 技能不存在', sName);
            return null;
          }
          return (() => {
            const _el$19 = createElement("Panel", {
              "class": "AbilityBanCardShowItem"
            }, null);
            setProp(_el$19, "style", {
              tooltipPosition: 'right'
            });
            setProp(_el$19, "onmouseover", p => {
              $.DispatchEvent('DOTAShowTextTooltip', p, `#DOTA_TOOLTIP_ability_${tKv['name']}`);
            });
            setProp(_el$19, "onmouseout", p => {
              $.DispatchEvent('DOTAHideTextTooltip', p);
            });
            insert(_el$19, createComponent(Yzy_ItemImage, {
              id: "AbilityImage",
              get name() {
                return tKv['name'];
              },
              get image() {
                return `file://{images}/spellicons/${tKv['name']}.png`;
              },
              get rarity() {
                return tKv['Rarity'] || 1;
              },
              hittest: false
            }));
            return _el$19;
          })();
        }
      }));
      effect(_p$ => {
        const _v$ = {
            "Show": getShowSelectBanCardPanel()
          },
          _v$2 = ReplaceTextVariable("#AbilityBanCardCountRemain", getBancardRemainCount()),
          _v$3 = {
            "Show": getShowHasBanCard()
          };
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$2, "classList", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$0, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$11, "classList", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$;
    })();
  }
  function CardGroupBan() {
    const [bSystemEnable] = useNetEventTable(t => {
      return t !== null && t !== void 0 ? t : false;
    }, 'abilities', 'bancard_system_enable');
    const [fSystemEndTime] = useNetEventTable(t => t !== null && t !== void 0 ? t : 0, 'abilities', 'bancard_end_time');
    const [getCanBanCardGroupList] = useNetEventTable(t => t !== null && t !== void 0 ? t : [], 'card', 'can_ban_card_group_list');
    const [getCurCardGroupBancardData] = useNetEventTable(t => {
      return t !== null && t !== void 0 ? t : {
        can_bancard_count: 0,
        bancard_list: [],
        is_confirm: false
      };
    }, 'card', () => 'card_group_bancard_' + getter_iLocalPlayer());
    const getShowSelectBanCardPanel = createMemo(() => {
      return getCurCardGroupBancardData().can_bancard_count > 0 && bSystemEnable() && Game.GetDOTATime(true, true) <= fSystemEndTime() && getCurCardGroupBancardData().is_confirm == false;
    });
    const getShowHasBanCard = createMemo(() => {
      return getCurCardGroupBancardData().is_confirm == true && getCurCardGroupBancardData().can_bancard_count > 0;
    });
    const getBancardRemainCount = createMemo(() => {
      return getCurCardGroupBancardData().can_bancard_count - getCurCardGroupBancardData().bancard_list.length;
    });
    const onClickCard = name => {
      if (getCurCardGroupBancardData().bancard_list.includes(name)) {
        GameEvents.SendCustomGameEventToServer('OnCardGroupUnbancard', {
          'name': name
        });
      } else {
        GameEvents.SendCustomGameEventToServer('OnCardGroupBancard', {
          'name': name
        });
      }
    };
    return (() => {
      const _el$20 = createElement("Panel", {
          id: "CardGroupBanRoot",
          hittest: false
        }, null),
        _el$21 = createElement("Panel", {
          id: "CardGroupBan",
          "class": "CardGroupBan"
        }, _el$20);
        createElement("Panel", {
          "class": "BG"
        }, _el$21);
        const _el$23 = createElement("Panel", {
          "class": "Header"
        }, _el$21);
        createElement("Panel", {
          "class": "TopLine"
        }, _el$23);
        createElement("Label", {
          "class": "Title",
          text: '#CardGroupBanTitle'
        }, _el$23);
        const _el$26 = createElement("Panel", {
          "class": "Body"
        }, _el$21),
        _el$27 = createElement("Panel", {
          "class": "CardList"
        }, _el$26),
        _el$28 = createElement("Panel", {
          "class": "Footer"
        }, _el$21),
        _el$29 = createElement("Label", {
          "class": "CountRemainLabel",
          html: true,
          get text() {
            return ReplaceTextVariable("#AbilityBanCardCountRemain", getBancardRemainCount());
          }
        }, _el$28),
        _el$32 = createElement("Panel", {
          id: "CardGroupBanShow"
        }, _el$20);
        createElement("Panel", {
          "class": "BG"
        }, _el$32);
        const _el$34 = createElement("Panel", {
          "class": "Header"
        }, _el$32);
        createElement("Label", {
          "class": "Title",
          text: '#CardGroupBanShowTitle'
        }, _el$34);
      setProp(_el$21, "onactivate", () => {});
      insert(_el$27, createComponent(For, {
        get each() {
          return Object.keys(getCanBanCardGroupList()).sort((a, b) => getCanBanCardGroupList()[a].order - getCanBanCardGroupList()[b].order);
        },
        children: (sName, i) => {
          return (() => {
            const _el$36 = createElement("Panel", {
                "class": "CardItem"
              }, null),
              _el$37 = createElement("Panel", {
                "class": "BanOverlay"
              }, _el$36);
              createElement("Label", {
                text: "#AbilityBanCardOverlay"
              }, _el$37);
            setProp(_el$36, "style", {
              tooltipPosition: 'right'
            });
            setProp(_el$36, "onactivate", p => {
              onClickCard(sName);
            });
            setProp(_el$36, "onmouseover", p => {
              $.DispatchEvent('DOTAShowTextTooltip', p, `#${sName}`);
            });
            setProp(_el$36, "onmouseout", p => {
              $.DispatchEvent('DOTAHideTextTooltip', p);
            });
            insert(_el$36, createComponent(Yzy_ItemImage, {
              id: "CardGroupImage",
              get name() {
                return getCanBanCardGroupList()[sName].img;
              },
              get image() {
                return `file://{images}/custom_game/items/${getCanBanCardGroupList()[sName].img}.png`;
              },
              hittest: false
            }), _el$37);
            effect(_$p => setProp(_el$37, "classList", {
              "Show": getCurCardGroupBancardData().bancard_list.includes(sName)
            }, _$p));
            return _el$36;
          })();
        }
      }));
      insert(_el$28, createComponent(Yzy_Button, {
        type: "btn_golden",
        size: 'Small',
        onactivate: () => {
          GameEvents.SendCustomGameEventToServer('OnCardGroupBancardConfirm', {});
        },
        get children() {
          return createComponent(CountDown, {
            fTimeEnd: fSystemEndTime,
            funcGetTime: () => Game.GetDOTATime(true, true),
            get children() {
              return [createElement("Label", {
                text: "#AbilityBanCardConfirmBtn"
              }, null), createElement("Label", {
                "class": "Time",
                text: "({s:countdown_time})"
              }, null)];
            }
          });
        }
      }), null);
      insert(_el$32, () => {
        const tCardGroupList = createMemo(() => getCanBanCardGroupList());
        const getList = createMemo(() => {
          const tList = getCurCardGroupBancardData().bancard_list;
          return tList.map(sName => {
            var _a;
            return Object.assign(Object.assign({}, (_a = tCardGroupList()[sName]) !== null && _a !== void 0 ? _a : {
              img: '',
              order: 0
            }), {
              name: sName
            });
          }).sort((a, b) => a.order - b.order);
        });
        return (() => {
          const _el$39 = createElement("Panel", {
            "class": "AbilityBanCardShowList"
          }, null);
          insert(_el$39, createComponent(For, {
            get each() {
              return getList();
            },
            children: (tItem, i) => {
              return (() => {
                const _el$40 = createElement("Panel", {
                  "class": "AbilityBanCardShowItem"
                }, null);
                setProp(_el$40, "style", {
                  tooltipPosition: 'right'
                });
                setProp(_el$40, "onmouseover", p => {
                  $.DispatchEvent('DOTAShowTextTooltip', p, `#${tItem.name}`);
                });
                setProp(_el$40, "onmouseout", p => {
                  $.DispatchEvent('DOTAHideTextTooltip', p);
                });
                insert(_el$40, createComponent(Yzy_ItemImage, {
                  id: "CardGroupImage",
                  get name() {
                    return tItem.img;
                  },
                  get image() {
                    return `file://{images}/custom_game/items/${tItem.img}.png`;
                  },
                  hittest: false
                }));
                return _el$40;
              })();
            }
          }));
          return _el$39;
        })();
      }, null);
      effect(_p$ => {
        const _v$4 = {
            "Show": getShowSelectBanCardPanel()
          },
          _v$5 = ReplaceTextVariable("#AbilityBanCardCountRemain", getBancardRemainCount()),
          _v$6 = {
            "Show": getShowHasBanCard()
          };
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$21, "classList", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$29, "text", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$32, "classList", _v$6, _p$._v$6));
        return _p$;
      }, {
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined
      });
      return _el$20;
    })();
  }

  try {
    render(() => createComponent(MiniMap, {}), $('#MiniMapRoot'));
  } catch (error) {
    UploadError(error, 'MiniMapRoot');
  }
  try {
    render(() => createComponent(GsSelection, {}), $('#GsSelectionRoot'));
  } catch (error) {
    UploadError(error, 'GsSelectionRoot');
  }
  try {
    render(() => createComponent(GsMode1, {}), $('#GsMode1Root'));
  } catch (error) {
    UploadError(error, 'GsMode1Root');
  }
  try {
    render(() => createComponent(LowerHud, {}), $('#LowerHudRoot'));
  } catch (error) {
    UploadError(error, 'LowerHudPanel');
  }
  try {
    render(() => createComponent(RoundPanel, {}), $('#RoundRoot'));
  } catch (error) {
    UploadError(error, 'RoundPanel');
  }
  try {
    render(() => createComponent(Pause, {}), $('#PauseRoot'));
  } catch (error) {
    UploadError(error, 'Pause');
  }
  try {
    render(() => createComponent(Resource, {}), $('#ResourceRoot'));
  } catch (error) {
    UploadError(error, 'Resource');
  }
  try {
    render(() => createComponent(SelectionLevelup, {}), $('#SelectionLevelupRoot'));
  } catch (error) {
    UploadError(error, 'SelectionLevelup');
  }
  try {
    render(() => createComponent(SelectionHero, {}), $('#SelectionHeroRoot'));
  } catch (error) {
    UploadError(error, 'SelectionHero');
  }
  try {
    render(() => createComponent(ReplaceAbility, {}), $('#ReplaceAbilityRoot'));
  } catch (error) {
    UploadError(error, 'ReplaceAbility');
  }
  try {
    render(() => createComponent(SelectionWeapon, {}), $('#SelectionWeaponRoot'));
  } catch (error) {
    UploadError(error, 'SelectionWeapon');
  }
  try {
    render(() => createComponent(SelectionAttributeConversion, {}), $('#AttributeConversionRoot'));
  } catch (error) {
    UploadError(error, 'AttributeConversion');
  }
  try {
    render(() => createComponent(Challenge, {}), $('#ChallengeRoot'));
  } catch (error) {
    UploadError(error, 'Challenge');
  }
  try {
    render(() => createComponent(MainChallengeRow, {}), $('#MainChallengeRoot'));
  } catch (error) {
    UploadError(error, 'MainChallenge');
  }
  try {
    render(() => createComponent(GameShop, {}), $('#GameShopRoot'));
  } catch (error) {
    UploadError(error, 'GameShop');
  }
  try {
    render(() => createComponent(SelectionItemDrop16, {}), $('#SelectionItemDrop16Root'));
  } catch (error) {
    UploadError(error, 'SelectionItemDrop16');
  }
  try {
    render(() => createComponent(SelectionCard, {}), $('#SelectionCardRoot'));
  } catch (error) {
    UploadError(error, 'SelectionCard');
  }
  try {
    render(() => createComponent(SelectionRelic, {}), $('#SelectionRelicRoot'));
  } catch (error) {
    UploadError(error, 'SelectionRelic');
  }
  try {
    render(() => createComponent(SelectionAbility, {}), $('#SelectionAbilityRoot'));
  } catch (error) {
    UploadError(error, 'SelectionAbility');
  }
  try {
    render(() => createComponent(SelectionAdventure, {}), $('#SelectionAdventureRoot'));
  } catch (error) {
    UploadError(error, 'SelectionAdventure');
  }
  try {
    render(() => createComponent(CardPack, {}), $('#CardPackRoot'));
  } catch (error) {
    UploadError(error, 'CardPack');
  }
  try {
    render(() => createComponent(DevourPack, {}), $('#DevourPackRoot'));
  } catch (error) {
    UploadError(error, 'DevourPack');
  }
  try {
    render(() => createComponent(ReplaceCard, {}), $('#ReplaceCardRoot'));
  } catch (error) {
    UploadError(error, 'ReplaceCard');
  }
  try {
    render(() => createComponent(SelectionHalidom, {}), $('#SelectionHalidomRoot'));
  } catch (error) {
    UploadError(error, 'SelectionHalidom');
  }
  try {
    render(() => createComponent(DamageTotal, {}), $('#DamageTotalRoot'));
  } catch (error) {
    UploadError(error, 'DamageTotal');
  }
  try {
    render(() => createComponent(PlayerTeam, {}), $('#PlayerTeamRoot'));
  } catch (error) {
    UploadError(error, 'PlayerTeam');
  }
  try {
    render(() => (() => {
      const _el$ = createElement("Panel", {
        id: "BanCardRoot2",
        hittest: false
      }, null);
      insert(_el$, createComponent(AbilityBanCard, {}), null);
      insert(_el$, createComponent(CardGroupBan, {}), null);
      return _el$;
    })(), $('#BanCardRoot'));
  } catch (error) {
    UploadError(error, 'BanCard');
  }
  try {
    render(() => createComponent(NoviceGuide, {}), $('#NoviceGuideRoot'));
  } catch (error) {
    UploadError(error, 'NoviceGuide');
  }
  try {
    render(() => createComponent(Conclusion, {}), $('#ConclusionRoot'));
  } catch (error) {
    UploadError(error, 'Conclusion');
  }
  try {
    render(() => createComponent(TowerPanel, {}), $('#TowerRoot'));
  } catch (error) {
    UploadError(error, 'TowerPanel');
  }
  try {
    render(() => createComponent(Pack, {}), $('#PackRoot'));
  } catch (error) {
    UploadError(error, 'Pack');
  }
  try {
    render(() => createComponent(DragonWish, {}), $('#DragonWishRoot'));
  } catch (error) {
    UploadError(error, 'DragonWish');
  }
  NetEventData.BindDo('common', 'game_state', t => {
    $.GetContextPanel().SwitchClass('GameState', 'GameState_' + (t === null || t === void 0 ? void 0 : t.state_cur));
  }, 'hud');
  $.GetContextPanel().SwitchClass('Language', $.Language());
  let iSoundID;
  NetEventData.BindDo('common', 'music', t => {
    const tSettingData = NetEventData.GetTableValue('setting_data', 'data');
    if (iSoundID) {
      Game.StopSound(iSoundID);
      iSoundID = undefined;
    }
    if (t === null || t === void 0 ? void 0 : t.name) {
      if (tSettingData === null || tSettingData === void 0 ? void 0 : tSettingData.Music) {
        iSoundID = Game.EmitSound(t === null || t === void 0 ? void 0 : t.name);
      }
    }
  }, 'hud_music');
  NetEventData.BindDo('setting_data', 'data', t => {
    if (t && !t.Music && iSoundID) {
      Game.StopSound(iSoundID);
    }
  }, 'hud_setting');

}));