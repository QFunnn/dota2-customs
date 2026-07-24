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

  var _a, _b, _c, _d, _e;
  if (GameUI.CustomUIConfig().tools == undefined) GameUI.CustomUIConfig().tools = {};
  ENV_NAME = $.GetContextPanel().layoutfile;
  var EventManager = (_a = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a, "EventManager"), _a.sEnvName = ENV_NAME, _a);
  var NetEventData = (_b = class extends GameUI.CustomUIConfig().tools.NetEventData {}, __setFunctionName(_b, "NetEventData"), _b.sEnvName = ENV_NAME, _b);
  (_c = class extends GameUI.CustomUIConfig().tools.Keybinds {}, __setFunctionName(_c, "Keybinds"), _c.sEnvName = ENV_NAME, _c);
  (_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {}, __setFunctionName(_d, "Mousebinds"), _d.sEnvName = ENV_NAME, _d);
  GameUI.CustomUIConfig().tools.ParticleManager_s2c;
  GameUI.CustomUIConfig().tools.AttributeSystem;
  GameUI.CustomUIConfig().tools.AttributeKind;
  var _Timer = (_e = class extends GameUI.CustomUIConfig().tools.Timer {}, __setFunctionName(_e, "_Timer"), _e.sEnvName = ENV_NAME, _e);
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
  _Player.FocusPlayer.bind(_Player);
  _Player.IsPlayerDisconnected.bind(_Player);
  _Player.IsPlayerAbandoned.bind(_Player);
  _Player.Player_EntityToID.bind(_Player);
  _Player.Player_IDToOrder.bind(_Player);
  _Player.Player_OrderToID.bind(_Player);
  var Player_IDToAccount = _Player.Player_IDToAccount.bind(_Player);
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

  function FormatDate(timestamp, sFormat = 'Y-M-D h:m:s') {
    function formatNumber(n) {
      const s = String(n);
      return s[1] ? s : `0${n}`;
    }
    const formateArr = ["Y", "M", "D", "h", "m", "s"];
    const returnArr = [];
    const date = new Date(timestamp * 1000);
    returnArr.push(date.getFullYear());
    returnArr.push(formatNumber(date.getMonth() + 1));
    returnArr.push(formatNumber(date.getDate()));
    returnArr.push(formatNumber(date.getHours()));
    returnArr.push(formatNumber(date.getMinutes()));
    returnArr.push(formatNumber(date.getSeconds()));
    for (const i in returnArr) {
      if ({}.hasOwnProperty.call(returnArr, i)) {
        sFormat = sFormat.replace(formateArr[i], returnArr[i]);
      }
    }
    return sFormat;
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
  function CopyStringToClipboard(s) {
    $.DispatchEvent('CopyStringToClipboard', s, "1");
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
  function Str2RewardMap$1(s, separator = '|') {
    let t = {};
    const rws = s.split(separator);
    for (const rw of rws) {
      const [k, v] = rw.split('=');
      t[k] = v;
    }
    return t;
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

  const getter_iLocalPlayer = useLocalPlayer();

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

  function Str2RewardMap(str = "") {
    var _a;
    const t = {};
    const arr = str.split('|');
    for (const s of arr) {
      const [k, v] = s.split('=');
      t[Number(k)] = ((_a = t[Number(k)]) !== null && _a !== void 0 ? _a : 0) + Number(v);
    }
    return t;
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

  function Yzy_NumberEntryAdjust(params) {
    var _a;
    let refTextEntry;
    const [local, props] = splitProps(params, ['value', 'min', 'max', 'onChange']);
    const getMin = () => {
      var _a;
      return (_a = local.min) !== null && _a !== void 0 ? _a : 1;
    };
    const getMax = () => {
      var _a;
      return (_a = local.max) !== null && _a !== void 0 ? _a : 999999;
    };
    const [getValue, setValue] = createSignal((_a = local.value) !== null && _a !== void 0 ? _a : getMin());
    return (() => {
      const _el$21 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('Yzy_NumberEntryAdjust', props.class, props.className);
          }
        }), null),
        _el$22 = createElement("TextEntry", {
          maxchars: 6,
          get placeholder() {
            return getValue().toString();
          },
          textmode: "numeric"
        }, _el$21);
      spread(_el$21, mergeProps(props, {
        get ["class"]() {
          return classNames('Yzy_NumberEntryAdjust', props.class, props.className);
        }
      }), true);
      insert(_el$21, createComponent(Yzy_IconButton, {
        "class": 'Sub',
        get enabled() {
          return getValue() > getMin();
        },
        type: "icon_btn_sub",
        onactivate: p => {
          if (getValue() > getMin()) {
            setValue(getValue() - 1);
            if (refTextEntry != undefined) {
              refTextEntry.text = getValue().toString();
              if (local.onChange) {
                local.onChange(p, getValue());
              }
            }
          }
        }
      }), _el$22);
      const _ref$ = refTextEntry;
      typeof _ref$ === "function" ? use(_ref$, _el$22) : refTextEntry = _el$22;
      setProp(_el$22, "ontextentrychange", p => {
        if (p.text == getValue().toString()) return;
        if (p.text.indexOf('.') != -1) p.text = p.text.replace('.', '');
        if (!isFinite(Number(p.text)) || parseInt(p.text) < 1) p.text = getValue().toString();
        if (p.text == '') {
          setValue(getMin());
          if (local.onChange) {
            local.onChange(p, getValue());
          }
        } else if (parseInt(p.text) >= 1) {
          setValue(Math.max(getMin(), Math.min(getMax(), Number(p.text))));
          if (p.text != getValue().toString()) {
            p.text = getValue().toString();
          }
          if (local.onChange) {
            local.onChange(p, getValue());
          }
        }
      });
      insert(_el$21, createComponent(Yzy_IconButton, {
        "class": "Add",
        get enabled() {
          return getValue() < getMax();
        },
        type: "icon_btn_add_1",
        onactivate: p => {
          if (getValue() < getMax()) {
            setValue(getValue() + 1);
            if (refTextEntry != undefined) {
              refTextEntry.text = getValue().toString();
            }
            if (local.onChange) {
              local.onChange(p, getValue());
            }
          }
        }
      }), null);
      effect(_$p => setProp(_el$22, "placeholder", getValue().toString(), _$p));
      return _el$21;
    })();
  }
  function Yzy_Loading(params) {
    const [local, props] = splitProps(params, ['type']);
    return (() => {
      const _el$25 = createElement("Panel", mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Loading", local.type, props.class, props.className);
        },
        hittest: false
      }), null);
      spread(_el$25, mergeProps(props, {
        get ["class"]() {
          return classNames("Yzy_Loading", local.type, props.class, props.className);
        },
        "hittest": false
      }), true);
      insert(_el$25, createComponent(Switch, {
        get children() {
          return [createComponent(Match, {
            get when() {
              return local.type == "Wave";
            },
            get children() {
              return [createElement("Panel", {
                "class": "WaveCol1"
              }, null), createElement("Panel", {
                "class": "WaveCol2"
              }, null), createElement("Panel", {
                "class": "WaveCol3"
              }, null), createElement("Panel", {
                "class": "WaveCol4"
              }, null), createElement("Panel", {
                "class": "WaveCol5"
              }, null), createElement("Panel", {
                "class": "WaveCol6"
              }, null), createElement("Panel", {
                "class": "WaveCol7"
              }, null), createElement("Panel", {
                "class": "WaveCol8"
              }, null)];
            }
          }), createComponent(Match, {
            get when() {
              return local.type == "Matrix";
            },
            get children() {
              return createComponent(Index, {
                each: [1, 2, 3, 4],
                children: (getIndex, i) => {
                  return (() => {
                    const _el$38 = createElement("Panel", {
                        get ["class"]() {
                          return 'Row' + getIndex();
                        }
                      }, null);
                      createElement("Panel", {
                        "class": "Row"
                      }, _el$38);
                      createElement("Panel", {
                        "class": "Row"
                      }, _el$38);
                      createElement("Panel", {
                        "class": "Row"
                      }, _el$38);
                      createElement("Panel", {
                        "class": "Row"
                      }, _el$38);
                    effect(_$p => setProp(_el$38, "class", 'Row' + getIndex(), _$p));
                    return _el$38;
                  })();
                }
              });
            }
          }), createComponent(Match, {
            get when() {
              return local.type == "PointSpin";
            },
            get children() {
              return [createElement("Panel", {
                "class": "Point1"
              }, null), createElement("Panel", {
                "class": "Point2"
              }, null), createElement("Panel", {
                "class": "Point3"
              }, null), createElement("Panel", {
                "class": "Point4"
              }, null)];
            }
          })];
        }
      }));
      return _el$25;
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
            limit: (_e = Str2RewardMap$1(item.effect)) === null || _e === void 0 ? void 0 : _e[1185005],
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

  function Processing() {
    return (() => {
      const _el$ = createElement("Panel", {
        id: "Processing",
        hittest: false
      }, null);
      insert(_el$, createComponent(CommonProcessing, {}), null);
      insert(_el$, createComponent(MouseProcessing, {}), null);
      insert(_el$, createComponent(MouseTip, {}), null);
      return _el$;
    })();
  }
  function CommonProcessing() {
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      const id = EventManager.Reg('popup/processing/ShowProcessing', bShow => {
        $.GetContextPanel().SetHasClass('ShowProcessing', bShow);
        setShow(bShow);
        if (bShow) {
          Timer(() => {
            setShow(false);
          }, 30, 'CloseProcessing');
        } else {
          StopTimer('CloseProcessing');
        }
      });
      onCleanup(() => {
        EventManager.Unreg('popup/processing/ShowProcessing', id);
      });
    });
    return createComponent(Yzy_Loading, {
      get ["class"]() {
        return classNames("CommonProcessing", {
          'Show': getShow()
        });
      },
      type: "Circle"
    });
  }
  function MouseProcessing() {
    let ref;
    const [getShow, setShow] = createSignal(false);
    createEffect(() => {
      EventManager.Reg('popup/processing/MouseProcessing', bShow => {
        setShow(bShow);
      }, 'popup/processing/MouseProcessing');
      onCleanup(() => {
        EventManager.Unreg('popup/processing/MouseProcessing', 'popup/processing/MouseProcessing');
      });
    });
    createEffect(() => {
      if (getShow()) {
        const fTimeout = Game.Time() + 30;
        Timer(() => {
          if (fTimeout <= Game.Time()) {
            setShow(false);
            return;
          }
          const vPos = GameUI.GetCursorPosition();
          ref.SetPositionInPixels(Math.round((vPos[0] - ref.actuallayoutwidth * .5) / ref.actualuiscale_x), Math.round((vPos[1] - ref.actuallayoutheight * .5) / ref.actualuiscale_y), 0);
          return 0;
        }, 0, 'popup/processing/MouseProcessing');
        onCleanup(() => {
          StopTimer('popup/processing/MouseProcessing');
        });
      } else {
        StopTimer('popup/processing/MouseProcessing');
      }
    });
    return (() => {
      const _el$2 = createElement("Panel", {
        get ["class"]() {
          return classNames('MouseProcessing', {
            'Show': getShow()
          });
        }
      }, null);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$2) : ref = _el$2;
      setProp(_el$2, "onactivate", () => {});
      insert(_el$2, createComponent(Yzy_Loading, {
        type: "Circle",
        hittest: true
      }));
      effect(_$p => setProp(_el$2, "class", classNames('MouseProcessing', {
        'Show': getShow()
      }), _$p));
      return _el$2;
    })();
  }
  function MouseTip() {
    let ref;
    const [getMsg, setMsg] = createSignal();
    createEffect(() => {
      let param_last;
      EventManager.Reg('popup/processing/MouseTip', param => {
        if (param) {
          param.msg = SpanText(param.msg[0] == '#' ? $.Localize(param.msg) : param.msg, param.type);
          if ((param_last === null || param_last === void 0 ? void 0 : param_last.msg) != param.msg) {
            setMsg(param.msg);
          }
          if ((param_last === null || param_last === void 0 ? void 0 : param_last.type) != param.type) {
            ref.SwitchClass('TipType', '');
            ref.SwitchClass('TipType', 'TipType_' + param.type);
          }
        } else {
          setMsg(undefined);
        }
        param_last = param;
      }, 'popup/processing/MouseTip');
      onCleanup(() => {
        EventManager.Unreg('popup/processing/MouseTip', 'popup/processing/MouseTip');
      });
    });
    createEffect(() => {
      const msg = getMsg();
      const visible = msg != undefined && msg != '';
      if (visible) {
        ref.style.opacity = '1';
        ref.SetDialogVariable('msg', msg);
        Timer(() => {
          const vPos = GameUI.GetCursorPosition();
          ref.SetPositionInPixels(Math.round((vPos[0] - ref.actuallayoutwidth * .5) / ref.actualuiscale_x), Math.round((vPos[1] - ref.actuallayoutheight * .5) / ref.actualuiscale_y), 0);
          return 0;
        }, 0, 'popup/processing/MouseTip');
        onCleanup(() => {
          StopTimer('popup/processing/MouseTip');
        });
      } else {
        ref.style.opacity = '0';
        StopTimer('popup/processing/MouseTip');
      }
    });
    return (() => {
      const _el$3 = createElement("Panel", {
          "class": "MouseTip",
          hittest: false,
          hittestchildren: false
        }, null);
        createElement("Label", {
          id: "MouseTipLabel",
          html: true,
          text: '{s:msg}'
        }, _el$3);
      const _ref$2 = ref;
      typeof _ref$2 === "function" ? use(_ref$2, _el$3) : ref = _el$3;
      return _el$3;
    })();
  }

  function ShowPopup(sPopup, params) {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/ShowPopup', {
      'sPopup': sPopup,
      'params': Object.assign({}, params)
    });
  }
  function HidePopup() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/ShowPopup', {
      'sPopup': ''
    });
  }
  function ShowMouseProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseProcessing', true);
  }
  function HideMouseProcessing() {
    GameUI.CustomUIConfig().tools.EventManager.Fire('popup/processing/MouseProcessing', false);
  }

  function RewardPopup(props) {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "RewardPopup"
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
        createElement("Label", {
          "class": "TitleLabel",
          text: '#RewardPopup'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3);
      setProp(_el$, "onactivate", () => {});
      insert(_el$7, createComponent(Index, {
        get each() {
          return props.tReward;
        },
        children: (getItem, i) => {
          return (() => {
            const _el$8 = createElement("Panel", {
              "class": "RewardPanel"
            }, null);
            insert(_el$8, createComponent(Yzy_ServiceItem, {
              get data() {
                return getItem();
              }
            }));
            return _el$8;
          })();
        }
      }));
      insert(_el$3, createComponent(Yzy_Button, {
        "class": "CloseBtn",
        type: "btn_grey",
        text: "#OFF",
        onactivate: HidePopup
      }), null);
      insert(_el$3, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_1",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      return _el$;
    })();
  }

  const ServGetter_UserShopLimit = useNetEventTable(t => t, 'service', () => 'UserShopLimit_' + getter_iLocalPlayer())[0];

  const ServGetter_UserItem = useNetEventTable(t => t, 'service', () => 'UserItem_' + getter_iLocalPlayer())[0];

  function ShopItem(props) {
    const getShopRarity = () => props.tShopItemCfg.rarity;
    const getShopItemID = () => String(props.tShopItemCfg.product_id);
    const getBuyCount = () => {
      var _a, _b;
      return (_b = (_a = ServGetter_UserShopLimit()) === null || _a === void 0 ? void 0 : _a[getShopItemID()]) !== null && _b !== void 0 ? _b : 0;
    };
    const getLimitType = () => props.tShopItemCfg.limit_type;
    const getLimitCount = () => props.tShopItemCfg.limit_count || 0;
    const getShopItemName = () => '#' + getShopItemID();
    const getShopItemCount = () => {
      const tReward = Str2RewardList(props.tShopItemCfg.reward_id);
      if (tReward.length == 1) {
        return tReward[0][1];
      }
    };
    const getCurrencyID = () => {
      var _a, _b;
      return ((_b = (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.price) !== null && _b !== void 0 ? _b : '').split("=")[0];
    };
    const getPrice = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h;
      if (getLimitCount() > 0 && getBuyCount() >= getLimitCount()) {
        return '#Shop_Purchased';
      }
      const tPrice = ParseShopPrice((_b = (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.price) !== null && _b !== void 0 ? _b : '');
      const sLanguage = $.Language();
      if (getCurrencyID() == "2020000") {
        if (sLanguage.includes('schinese')) {
          return (tPrice["1"] * 0.01).toFixed(2);
        }
        if (sLanguage.includes('russian')) {
          return (tPrice["3"] * 0.01).toFixed(2);
        } else {
          return (tPrice["2"] * 0.01).toFixed(2);
        }
      }
      if (tPrice[getCurrencyID()] == 0) {
        if (((_c = props.tShopItemCfg) === null || _c === void 0 ? void 0 : _c.need_card) == 1 && ((_d = ServGetter_UserItem()) === null || _d === void 0 ? void 0 : _d["2010103"]) == undefined) {
          return `#Store_NeedCard_${(_e = props.tShopItemCfg) === null || _e === void 0 ? void 0 : _e.need_card}`;
        }
        if (((_f = props.tShopItemCfg) === null || _f === void 0 ? void 0 : _f.need_card) == 2 && ((_g = ServGetter_UserItem()) === null || _g === void 0 ? void 0 : _g["2010104"]) == undefined) {
          return `#Store_NeedCard_${(_h = props.tShopItemCfg) === null || _h === void 0 ? void 0 : _h.need_card}`;
        }
        return '#Free';
      }
      return tPrice[getCurrencyID()];
    };
    const getOriginPrice = () => {
      var _a, _b;
      if (getLimitCount() > 0 && getBuyCount() >= getLimitCount()) return;
      const tPrice = ParseShopPrice((_b = (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.price_show) !== null && _b !== void 0 ? _b : '');
      const sLanguage = $.Language();
      if (getCurrencyID() == "2020000") {
        if (sLanguage.includes('schinese')) {
          return (tPrice["1"] * 0.01).toFixed(2);
        }
        if (sLanguage.includes('russian')) {
          return (tPrice["3"] * 0.01).toFixed(2);
        } else {
          return (tPrice["2"] * 0.01).toFixed(2);
        }
      }
      if (tPrice[getCurrencyID()] == 0) return;
      return tPrice[getCurrencyID()];
    };
    return (() => {
      const _el$ = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('ShopItem', `Rarity_${getShopRarity()}`, props.class, props.className);
          }
        }), null);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        createElement("Panel", {
          "class": "HoverBorder",
          hittest: false
        }, _el$);
        const _el$4 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$),
        _el$5 = createElement("Label", {
          "class": "ItemName",
          get text() {
            return getShopItemName();
          },
          hittest: false
        }, _el$4),
        _el$7 = createElement("Panel", {
          "class": "CostContainer"
        }, _el$4);
        createElement("Panel", {
          "class": "BG"
        }, _el$7);
        const _el$9 = createElement("Panel", {
          "class": "Body"
        }, _el$7),
        _el$10 = createElement("Label", {
          "class": "CostLabel",
          get text() {
            return getPrice();
          }
        }, _el$9);
      spread(_el$, mergeProps(props, {
        get ["class"]() {
          return classNames('ShopItem', `Rarity_${getShopRarity()}`, props.class, props.className);
        },
        "onmouseover": p => {
          ShowTooltip(p, 'shopitem_tooltip', {
            'tShopItemCfg': props.tShopItemCfg
          });
        },
        "onmouseout": p => {
          HideTooltip();
        },
        "onactivate": p => {
          var _a, _b, _c, _d, _e, _f;
          if (getLimitCount() > 0 && getBuyCount() >= getLimitCount()) return ErrorMsg("#error_not_enough_limit_count");
          if (((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.need_card) == 1 && ((_b = ServGetter_UserItem()) === null || _b === void 0 ? void 0 : _b["2010103"]) == undefined) {
            ShowPopup('common_popup', {
              'sTitle': `#Store_NeedCard_${(_c = props.tShopItemCfg) === null || _c === void 0 ? void 0 : _c.need_card}`,
              'sContext': '#GoToBuyItem',
              'OnConfirm': p => {
                OpenShopPopupByProductID('2010010');
              }
            });
            return;
          }
          if (((_d = props.tShopItemCfg) === null || _d === void 0 ? void 0 : _d.need_card) == 2 && ((_e = ServGetter_UserItem()) === null || _e === void 0 ? void 0 : _e["2010104"]) == undefined) {
            ShowPopup('common_popup', {
              'sTitle': `#Store_NeedCard_${(_f = props.tShopItemCfg) === null || _f === void 0 ? void 0 : _f.need_card}`,
              'sContext': '#GoToBuyItem',
              'OnConfirm': p => {
                OpenShopPopupByProductID('2010011');
              }
            });
            return;
          }
          Game.EmitSound('UI.ShopButtonClick');
          if (getCurrencyID() == "2020000") {
            ShowPopup('shop_pay_popup', {
              'tShopItemCfg': props.tShopItemCfg
            });
          } else {
            ShowPopup('shop_buy_item_popup', {
              'tShopItemCfg': props.tShopItemCfg,
              'price_id': getCurrencyID()
            });
          }
        }
      }), true);
      insert(_el$4, createComponent(Yzy_ServiceItem, {
        get data() {
          return {
            'id': getShopItemID()
          };
        },
        nobg: true,
        notooltip: true
      }), _el$5);
      insert(_el$4, createComponent(Show, {
        get when() {
          return memo(() => getShopItemCount() != undefined)() && (getShopItemCount() || 0) > 1;
        },
        get children() {
          const _el$6 = createElement("Label", {
            "class": "ItemCount",
            get text() {
              return 'x' + getShopItemCount();
            },
            hittest: false
          }, null);
          effect(_$p => setProp(_el$6, "text", 'x' + getShopItemCount(), _$p));
          return _el$6;
        }
      }), _el$7);
      insert(_el$9, createComponent(Show, {
        get when() {
          return memo(() => getPrice() != 0)() && isFinite(Number(getPrice()));
        },
        get children() {
          return createComponent(Show, {
            get when() {
              return getCurrencyID() == "2020000";
            },
            get fallback() {
              return createComponent(Yzy_ServiceTokenImage, {
                "class": "CurrencyIcon",
                get item_id() {
                  return getCurrencyID();
                }
              });
            },
            get children() {
              return createComponent(Switch, {
                get fallback() {
                  return createElement("Label", {
                    "class": "CurrencyIcon",
                    text: '$'
                  }, null);
                },
                get children() {
                  return [createComponent(Match, {
                    get when() {
                      return $.Language().includes('schinese');
                    },
                    get children() {
                      return createElement("Label", {
                        "class": "CurrencyIcon",
                        text: '￥'
                      }, null);
                    }
                  }), createComponent(Match, {
                    get when() {
                      return $.Language().includes('russian');
                    },
                    get children() {
                      return createElement("Label", {
                        "class": "CurrencyIcon",
                        text: '₽'
                      }, null);
                    }
                  })];
                }
              });
            }
          });
        }
      }), _el$10);
      insert(_el$4, createComponent(Show, {
        get when() {
          return memo(() => getOriginPrice() != undefined)() && getOriginPrice() != getPrice();
        },
        get children() {
          const _el$11 = createElement("Panel", {
              "class": "CostOriginPrice"
            }, null),
            _el$12 = createElement("Label", {
              "class": "CostLabel",
              get text() {
                return getOriginPrice();
              }
            }, _el$11);
            createElement("Panel", {
              "class": "LineThrough"
            }, _el$11);
          effect(_$p => setProp(_el$12, "text", getOriginPrice(), _$p));
          return _el$11;
        }
      }), null);
      insert(_el$4, createComponent(Show, {
        get when() {
          return getLimitCount() > 0;
        },
        get children() {
          const _el$14 = createElement("Panel", {
              "class": "LimitInfo"
            }, null),
            _el$15 = createElement("Label", {
              "class": "LimitLabel",
              get text() {
                return "#Shop_Restricted_" + getLimitType();
              },
              get dialogVariables() {
                return {
                  count: getBuyCount(),
                  max: getLimitCount()
                };
              }
            }, _el$14);
          effect(_p$ => {
            const _v$ = "#Shop_Restricted_" + getLimitType(),
              _v$2 = {
                count: getBuyCount(),
                max: getLimitCount()
              };
            _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$15, "text", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$15, "dialogVariables", _v$2, _p$._v$2));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined
          });
          return _el$14;
        }
      }), null);
      insert(_el$4, createComponent(ShopItemSalePanel, {
        get tShopItemCfg() {
          return props.tShopItemCfg;
        }
      }), null);
      effect(_p$ => {
        const _v$3 = getShopItemName(),
          _v$4 = {
            "HasOriginPrice": getOriginPrice() != undefined && getOriginPrice() != getPrice()
          },
          _v$5 = getPrice();
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$5, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$7, "classList", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$10, "text", _v$5, _p$._v$5));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined
      });
      return _el$;
    })();
  }
  function ShopItemSalePanel(props) {
    const getShopItemID = () => {
      var _a;
      return String((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.product_id);
    };
    const getBuyCount = () => {
      var _a, _b;
      return (_b = (_a = ServGetter_UserShopLimit()) === null || _a === void 0 ? void 0 : _a[getShopItemID()]) !== null && _b !== void 0 ? _b : 0;
    };
    const getFirstDouble = () => props.tShopItemCfg.have_double && getBuyCount() <= 0;
    const getIsHot = () => {
      var _a;
      return (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.is_hot;
    };
    return createMemo(() => {
      let tLeft = [];
      let tRight = [];
      if (props.tShopItemCfg.reward_gift) {
        const tGift = Str2RewardMap(props.tShopItemCfg.reward_gift);
        for (const id in tGift) {
          tRight.push(() => {
            return (() => {
              const _el$17 = createElement("Panel", {
                  "class": "SaleTopPanel GreenStyle"
                }, null);
                createElement("Panel", {
                  "class": "BG"
                }, _el$17);
                const _el$19 = createElement("Panel", {
                  "class": "ShopBuyGiftPanel"
                }, _el$17),
                _el$20 = createElement("Label", {
                  id: "ShopBuyGiftLabel",
                  text: "#Shop_RewardGift",
                  get dialogVariables() {
                    return {
                      count: tGift[id]
                    };
                  }
                }, _el$19);
              insert(_el$19, createComponent(Yzy_ServiceItem, {
                data: {
                  'id': id
                }
              }), null);
              effect(_$p => setProp(_el$20, "dialogVariables", {
                count: tGift[id]
              }, _$p));
              return _el$17;
            })();
          });
          break;
        }
      }
      if (props.tShopItemCfg.reward_activity) {
        let tActiveIDs = [];
        if (tActiveIDs.length > 0) {
          let sAct = props.tShopItemCfg.reward_activity.split('|');
          for (const s of sAct) {
            for (const k of s.split('$')) {
              let sId = k.split('#')[1];
              let sRewardCfg = k.split('#')[2];
              if (tActiveIDs.includes(sId)) {
                const tGift = Str2RewardMap(sRewardCfg);
                for (const id in tGift) {
                  tRight.push(() => {
                    return (() => {
                      const _el$21 = createElement("Panel", {
                          "class": "SaleTopPanel GreenStyle"
                        }, null);
                        createElement("Panel", {
                          "class": "BG"
                        }, _el$21);
                        const _el$23 = createElement("Panel", {
                          "class": "ShopBuyActiveGiftPanel"
                        }, _el$21),
                        _el$24 = createElement("Label", {
                          id: "ShopBuyGiftLabel",
                          text: "#Shop_BuyGift",
                          get dialogVariables() {
                            return {
                              count: tGift[id]
                            };
                          }
                        }, _el$23);
                      insert(_el$23, createComponent(Yzy_ServiceItem, {
                        data: {
                          'id': id
                        }
                      }), null);
                      effect(_$p => setProp(_el$24, "dialogVariables", {
                        count: tGift[id]
                      }, _$p));
                      return _el$21;
                    })();
                  });
                  break;
                }
              }
            }
          }
        }
      }
      if (getFirstDouble()) {
        tLeft.push(() => {
          return (() => {
            const _el$25 = createElement("Panel", {
                get ["class"]() {
                  return classNames("SaleTopPanel", "GoldStyle", "FirstDouble");
                }
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$25);
            effect(_$p => setProp(_el$25, "class", classNames("SaleTopPanel", "GoldStyle", "FirstDouble"), _$p));
            return _el$25;
          })();
        });
      }
      if (getIsHot()) {
        (props.bOnlyRight ? tRight : tLeft).push(() => {
          return (() => {
            const _el$27 = createElement("Panel", {
                get ["class"]() {
                  return classNames("SaleTopPanel", "RedStyle", "Hot");
                }
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$27);
            effect(_$p => setProp(_el$27, "class", classNames("SaleTopPanel", "RedStyle", "Hot"), _$p));
            return _el$27;
          })();
        });
      }
      if (tLeft.length > 0 || tRight.length > 0) {
        return (() => {
          const _el$29 = createElement("Panel", mergeProps(props, {
              get ["class"]() {
                return classNames("ShopItemSalePanel");
              },
              hittest: false
            }), null),
            _el$30 = createElement("Panel", {
              id: "LeftBox",
              "class": "Box",
              hittest: false
            }, _el$29),
            _el$31 = createElement("Panel", {
              id: "RightBox",
              "class": "Box",
              hittest: false
            }, _el$29);
          spread(_el$29, mergeProps(props, {
            get ["class"]() {
              return classNames("ShopItemSalePanel");
            },
            "hittest": false
          }), true);
          insert(_el$30, createComponent(For, {
            each: tLeft,
            children: func => func()
          }));
          insert(_el$31, createComponent(For, {
            each: tRight,
            children: func => func()
          }));
          return _el$29;
        })();
      }
      return [];
    });
  }
  function ShopItemDetail(props) {
    const getShopItemID = () => {
      var _a;
      return String((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.product_id);
    };
    const getShopItemName = () => '#' + getShopItemID();
    return (() => {
      const _el$32 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('ShopItemDetail', props.className);
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$32);
        const _el$34 = createElement("Panel", {
          "class": "Body"
        }, _el$32),
        _el$35 = createElement("Label", {
          id: "ShopItemDetailTitle",
          get text() {
            return getShopItemName();
          }
        }, _el$34);
      spread(_el$32, mergeProps(props, {
        get ["class"]() {
          return classNames('ShopItemDetail', props.className);
        }
      }), true);
      insert(_el$34, createComponent(ShopItemRewardDetail, {
        get tShopItemCfg() {
          return props.tShopItemCfg;
        }
      }), null);
      effect(_$p => setProp(_el$35, "text", getShopItemName(), _$p));
      return _el$32;
    })();
  }
  function ShopItemRewardDetail(props) {
    const getShopItemID = () => {
      var _a;
      return String((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.product_id);
    };
    const getShopItemRarity = () => {
      var _a;
      return ((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.rarity) || 0;
    };
    const getShopItemRewardList = () => {
      var _a;
      return Str2RewardList((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.reward_id);
    };
    const getHasOtherReward = () => {
      for (const [item_id, iVal] of getShopItemRewardList()) {
        if (String(item_id).startsWith(118..toString()) || String(item_id).startsWith(106..toString())) {
          return true;
        }
      }
      return false;
    };
    return (() => {
      const _el$36 = createElement("Panel", mergeProps(props, {
        get ["class"]() {
          return classNames('ShopItemRewardDetail', props.className);
        }
      }), null);
      spread(_el$36, mergeProps(props, {
        get ["class"]() {
          return classNames('ShopItemRewardDetail', props.className);
        }
      }), true);
      insert(_el$36, createComponent(Show, {
        get when() {
          return getHasOtherReward();
        },
        get children() {
          const _el$37 = createElement("Panel", {
              get ["class"]() {
                return classNames('RewardRow', 'Rarity_' + (getShopItemRarity() + 1));
              },
              onmouseout: HideTooltip
            }, null),
            _el$38 = createElement("Panel", {
              "class": "Body"
            }, _el$37);
          setProp(_el$37, "onmouseover", p => {
            ShowTooltip(p, 'shopitem_tooltip', {
              'tShopItemCfg': props.tShopItemCfg,
              'bOnly': true
            });
          });
          setProp(_el$37, "onmouseout", HideTooltip);
          insert(_el$38, createComponent(Yzy_ServiceItem, {
            get data() {
              return {
                'id': getShopItemID()
              };
            },
            get rarity() {
              return getShopItemRarity();
            }
          }));
          effect(_$p => setProp(_el$37, "class", classNames('RewardRow', 'Rarity_' + (getShopItemRarity() + 1)), _$p));
          return _el$37;
        }
      }), null);
      insert(_el$36, createComponent(Index, {
        get each() {
          return getShopItemRewardList().filter(k => !(String(k[0]).startsWith(118..toString()) || String(k[0]).startsWith(106..toString())));
        },
        children: (getReward, i) => {
          const getItemID = () => getReward()[0];
          const getItemCount = () => getReward()[1];
          const getItemRarity = () => {
            var _a, _b, _c;
            return (_c = (_b = (_a = CfgGetter_shop_items()) === null || _a === void 0 ? void 0 : _a[getItemID()]) === null || _b === void 0 ? void 0 : _b['rarity']) !== null && _c !== void 0 ? _c : getShopItemRarity();
          };
          return (() => {
            const _el$39 = createElement("Panel", {
                get ["class"]() {
                  return classNames('RewardRow', 'Rarity_' + (getItemRarity() + 1));
                }
              }, null),
              _el$40 = createElement("Panel", {
                "class": "Body"
              }, _el$39);
            insert(_el$40, createComponent(Yzy_ServiceItem, {
              get data() {
                return {
                  'id': String(getItemID()),
                  'count': getItemCount()
                };
              },
              get rarity() {
                return getItemRarity();
              }
            }));
            insert(_el$39, createComponent(Show, {
              get when() {
                return props.iCount != undefined && props.iCount > 1;
              },
              get children() {
                const _el$41 = createElement("Label", {
                  id: "ShopItemCount",
                  get text() {
                    return 'x' + props.iCount;
                  }
                }, null);
                effect(_$p => setProp(_el$41, "text", 'x' + props.iCount, _$p));
                return _el$41;
              }
            }), null);
            effect(_$p => setProp(_el$39, "class", classNames('RewardRow', 'Rarity_' + (getItemRarity() + 1)), _$p));
            return _el$39;
          })();
        }
      }), null);
      return _el$36;
    })();
  }
  function OpenShopPopupByProductID(product_id) {
    var _a, _b;
    const getShopItemCfg = () => CfgGetter_shop();
    if (((_b = (_a = getShopItemCfg()) === null || _a === void 0 ? void 0 : _a[product_id]) === null || _b === void 0 ? void 0 : _b.enable) != 1) return;
    const getShopItem = () => {
      var _a;
      return (_a = getShopItemCfg()) === null || _a === void 0 ? void 0 : _a[product_id];
    };
    const getBuyCount = () => {
      var _a, _b;
      return (_b = (_a = ServGetter_UserShopLimit()) === null || _a === void 0 ? void 0 : _a[product_id]) !== null && _b !== void 0 ? _b : 0;
    };
    const getLimitCount = () => getShopItem().limit_count || 0;
    if (getLimitCount() > 0 && getBuyCount() >= getLimitCount()) return ErrorMsg('#error_buy_limit');
    const getCurrencyID = () => {
      var _a, _b;
      return ((_b = (_a = getShopItem()) === null || _a === void 0 ? void 0 : _a.price) !== null && _b !== void 0 ? _b : '').split("=")[0];
    };
    if (getCurrencyID() == "2020000") {
      ShowPopup('shop_pay_popup', {
        'tShopItemCfg': getShopItem()
      });
    } else {
      ShowPopup('shop_buy_item_popup', {
        'tShopItemCfg': getShopItem()
      });
    }
  }
  function GetPriceString(sCurrencyID, tPrices, iCount = 1) {
    const sLanguage = $.Language();
    if (sCurrencyID == "2020000") {
      if (sLanguage.includes('schinese')) {
        return '￥' + (tPrices["1"] * iCount * 0.01).toFixed(2);
      }
      if (sLanguage.includes('russian')) {
        return '₽' + (tPrices["3"] * iCount * 0.01).toFixed(2);
      } else {
        return '$' + (tPrices["2"] * iCount * 0.01).toFixed(2);
      }
    } else {
      return tPrices[sCurrencyID] * iCount;
    }
  }
  function ParseShopPrice(price) {
    let tPrices = String(price).split('=');
    let tPrice = {};
    if (tPrices.length == 2 && tPrices[0] != "2020000") {
      tPrice[tPrices[0]] = Number(tPrices[1]);
    } else {
      for (let i = 0; i < tPrices.length; i++) {
        if (i == 0 && tPrices[0] != "2020000") {
          tPrices[tPrices[i]] = Number(tPrices[1]);
        } else {
          tPrice[i] = Number(tPrices[i]);
        }
      }
    }
    return tPrice;
  }

  function ShopPayPopup(props) {
    let refAlipayQRCode;
    let refWechatQRCode;
    const getShopItemID = () => {
      var _a;
      return String((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.product_id);
    };
    const getShopItemTitle = () => $.Localize("#" + getShopItemID());
    const getShopItemDescription = () => $.Localize("#" + getShopItemID() + '_Description');
    const getCurrencyID = () => {
      var _a, _b;
      return ((_b = (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.price) !== null && _b !== void 0 ? _b : '').split("=")[0];
    };
    const [getSelectedCount, setSelectedCount] = createSignal(1);
    const getLimitCount = () => {
      var _a;
      return (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.limit_count;
    };
    const getCanBuyCount = () => {
      var _a, _b;
      return getLimitCount() != undefined ? getLimitCount() - ((_b = (_a = ServGetter_UserShopLimit()) === null || _a === void 0 ? void 0 : _a[getShopItemID()]) !== null && _b !== void 0 ? _b : 0) : undefined;
    };
    const [getAlipayPayOrderInfo, setAlipayPayOrderInfo] = createSignal({
      link: '',
      order_id: ''
    });
    const [getWechatPayOrderInfo, setWechatPayOrderInfo] = createSignal({
      link: '',
      order_id: ''
    });
    const [getForeignPayOrderInfo, setForeignPayOrderInfo] = createSignal({
      link: '',
      order_id: ''
    });
    const [getForeignPayLoading, setForeignPayLoading] = createSignal(false);
    const [getOrderStatus, setOrderStatus] = createSignal(-1);
    const [getOrder] = useNetEventTable(t => t, 'shop', () => 'order_' + getter_iLocalPlayer());
    createEffect(() => {
      if (getOrder()) {
        for (const k in getOrder()) {
          const value = getOrder()[k];
          if (value.State == 2 && (value.OrderId == getAlipayPayOrderInfo().order_id || value.OrderId == getWechatPayOrderInfo().order_id || value.OrderId == getForeignPayOrderInfo().order_id)) {
            setOrderStatus(value.State);
            const tTeampShopItemCfg = props.tShopItemCfg;
            const iBuyCount = getSelectedCount();
            HidePopup();
            ShowPopup('shop_buy_item_success_popup', {
              'tShopItemCfg': tTeampShopItemCfg,
              'iCount': iBuyCount
            });
            return;
          }
        }
      }
      if (getAlipayPayOrderInfo().order_id != '' || getWechatPayOrderInfo().order_id != '' || getForeignPayOrderInfo().order_id != '') {
        setOrderStatus(0);
      } else {
        setOrderStatus(-1);
      }
    });
    createEffect(on(getSelectedCount, () => {
      setAlipayPayOrderInfo({
        link: '',
        order_id: ''
      });
      setWechatPayOrderInfo({
        link: '',
        order_id: ''
      });
      setForeignPayOrderInfo({
        link: '',
        order_id: ''
      });
      if (refAlipayQRCode) refAlipayQRCode.RemoveAndDeleteChildren();
      if (refWechatQRCode) refWechatQRCode.RemoveAndDeleteChildren();
      const id = Timer(() => {
        const isChinese = $.Language().toLowerCase().includes('chinese');
        if (isChinese) {
          Request('Shop_CreatePayOrder', {
            'item_id': props.tShopItemCfg.product_id,
            'payment': 2,
            'count': getSelectedCount(),
            'title': getShopItemTitle(),
            'description': getShopItemDescription(),
            'pm_id': '',
            'user_id': Number(Player_IDToAccount(Players.GetLocalPlayer()))
          }, 'Alipay').then(rep => {
            var _a;
            const data = rep === null || rep === void 0 ? void 0 : rep.data;
            if ((rep === null || rep === void 0 ? void 0 : rep.code) == 0 && data) {
              setAlipayPayOrderInfo({
                'link': data.link,
                'order_id': data.custom_id,
                'amount': data.amount
              });
              if (refAlipayQRCode) {
                CreateQRCode(data.link, refAlipayQRCode, 160);
              }
            } else {
              ErrorMsg((_a = rep === null || rep === void 0 ? void 0 : rep.msg) !== null && _a !== void 0 ? _a : 'error_service_time_out');
            }
          });
          Request('Shop_CreatePayOrder', {
            'item_id': props.tShopItemCfg.product_id,
            'payment': 1,
            'count': getSelectedCount(),
            'title': getShopItemTitle(),
            'description': getShopItemDescription(),
            'pm_id': '',
            'user_id': Number(Player_IDToAccount(Players.GetLocalPlayer()))
          }, 'Wechat').then(rep => {
            var _a;
            const data = rep === null || rep === void 0 ? void 0 : rep.data;
            if ((rep === null || rep === void 0 ? void 0 : rep.code) == 0 && data) {
              setWechatPayOrderInfo({
                'link': data.link,
                'order_id': data.custom_id,
                'amount': data.amount
              });
              if (refWechatQRCode) {
                CreateQRCode(data.link, refWechatQRCode, 160);
              }
            } else {
              ErrorMsg((_a = rep === null || rep === void 0 ? void 0 : rep.msg) !== null && _a !== void 0 ? _a : 'error_service_time_out');
            }
          });
        }
      }, 1, 'ShopPayPopup');
      onCleanup(() => StopTimer(id));
    }));
    return (() => {
      const _el$ = createElement("Panel", {
          id: "ShopPayPopup"
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
        createElement("Label", {
          "class": "TitleLabel",
          text: '#Shop_BuyItem'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$8 = createElement("Panel", {
          "class": "RightContent"
        }, _el$7),
        _el$9 = createElement("Panel", {
          "class": "ShopItemBuyCost"
        }, _el$8);
        createElement("Label", {
          "class": "ShopItemBuyCostTitle",
          text: '#Popup_ShopItemBuyCost'
        }, _el$9);
        const _el$1 = createElement("Label", {
          "class": "ShopItemBuyCostLabel",
          get text() {
            return GetPriceString(getCurrencyID(), ParseShopPrice(props.tShopItemCfg.price), getSelectedCount());
          }
        }, _el$9),
        _el$10 = createElement("Panel", {
          "class": "ShopItemBuyCount"
        }, _el$8);
        createElement("Label", {
          "class": "ShopItemBuyCountTitle",
          text: '#Popup_ShopItemBuyCount'
        }, _el$10);
        const _el$12 = createElement("Panel", {
          "class": "Body"
        }, _el$10),
        _el$13 = createElement("Panel", {
          get ["class"]() {
            return classNames('PayOrderStatus', 'PayOrderStatus_' + getOrderStatus());
          }
        }, _el$8),
        _el$14 = createElement("Label", {
          "class": "PayOrderStatusLabel",
          get text() {
            return "#PayOrderStatus_" + getOrderStatus();
          }
        }, _el$13),
        _el$16 = createElement("Panel", {
          "class": "QRCodeContent"
        }, _el$8),
        _el$17 = createElement("Panel", {
          get ["class"]() {
            return classNames('QRCode', 'Alipay');
          },
          hittest: false,
          hittestchildren: false
        }, _el$16),
        _el$18 = createElement("Panel", {
          "class": "Body"
        }, _el$17),
        _el$19 = createElement("Panel", {
          get ["class"]() {
            return classNames('QRCode', 'Wechat');
          },
          hittest: false,
          hittestchildren: false
        }, _el$16),
        _el$20 = createElement("Panel", {
          "class": "Body"
        }, _el$19),
        _el$21 = createElement("Panel", {
          "class": "ForeignContent"
        }, _el$8),
        _el$22 = createElement("Panel", {
          "class": "PaymentGroup"
        }, _el$21),
        _el$23 = createElement("Button", {
          id: "Paypal",
          "class": "PaymentButton"
        }, _el$22);
        createElement("Panel", {
          "class": "Icon"
        }, _el$23);
        const _el$25 = createElement("Panel", {
          "class": "PaymentLink"
        }, _el$21),
        _el$29 = createElement("Panel", {
          "class": "PayTip"
        }, _el$3);
      setProp(_el$, "onactivate", () => {});
      insert(_el$7, createComponent(ShopItem, {
        get tShopItemCfg() {
          return props.tShopItemCfg;
        },
        hittest: false,
        hittestchildren: false
      }), _el$8);
      insert(_el$8, createComponent(ShopItemDetail, {
        "class": 'ShopItemDetail',
        get tShopItemCfg() {
          return props.tShopItemCfg;
        }
      }), _el$9);
      insert(_el$12, createComponent(Yzy_NumberEntryAdjust, {
        get value() {
          return getSelectedCount();
        },
        get max() {
          return getCanBuyCount();
        },
        onChange: (p, value) => {
          setSelectedCount(value);
        }
      }));
      insert(_el$13, createComponent(Show, {
        get when() {
          return getOrderStatus() == 0;
        },
        get children() {
          return createElement("Label", {
            "class": "WaitPayLabel",
            text: ". . ."
          }, null);
        }
      }), null);
      const _ref$ = refAlipayQRCode;
      typeof _ref$ === "function" ? use(_ref$, _el$18) : refAlipayQRCode = _el$18;
      insert(_el$17, createComponent(Show, {
        get when() {
          return getAlipayPayOrderInfo().order_id != '';
        },
        get fallback() {
          return createComponent(Yzy_Loading, {
            type: "Wave"
          });
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": "PaymentIcon",
            type: "icon_alipay"
          });
        }
      }), null);
      const _ref$2 = refWechatQRCode;
      typeof _ref$2 === "function" ? use(_ref$2, _el$20) : refWechatQRCode = _el$20;
      insert(_el$19, createComponent(Show, {
        get when() {
          return getWechatPayOrderInfo().order_id != '';
        },
        get fallback() {
          return createComponent(Yzy_Loading, {
            type: "Wave"
          });
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": "PaymentIcon",
            type: "icon_wechat"
          });
        }
      }), null);
      setProp(_el$23, "onactivate", p => {
        setForeignPayLoading(true);
        setForeignPayOrderInfo({
          'link': '',
          'order_id': ''
        });
        Request('Shop_CreatePayOrder', {
          'item_id': props.tShopItemCfg.product_id,
          'payment': 3,
          'count': getSelectedCount(),
          'title': getShopItemTitle(),
          'description': getShopItemDescription(),
          'pm_id': '',
          'user_id': Number(Player_IDToAccount(Players.GetLocalPlayer()))
        }, 'Foreign').then(rep => {
          var _a;
          const data = rep === null || rep === void 0 ? void 0 : rep.data;
          if ((rep === null || rep === void 0 ? void 0 : rep.code) == 0 && data) {
            setForeignPayOrderInfo({
              'link': data.link,
              'order_id': data.custom_id,
              'amount': data.amount
            });
          } else {
            ErrorMsg((_a = rep === null || rep === void 0 ? void 0 : rep.msg) !== null && _a !== void 0 ? _a : 'error_service_time_out');
          }
          setForeignPayLoading(false);
        });
      });
      insert(_el$25, createComponent(Show, {
        get when() {
          return getForeignPayOrderInfo().link;
        },
        get fallback() {
          return (() => {
            const _el$30 = createElement("Panel", {
              "class": "LoadingIcon"
            }, null);
            effect(_$p => setProp(_el$30, "classList", {
              'Loading': getForeignPayLoading()
            }, _$p));
            return _el$30;
          })();
        },
        get children() {
          const _el$26 = createElement("Panel", {
              "class": "Body"
            }, null),
            _el$27 = createElement("Label", {
              html: true,
              get text() {
                return `<a href="${getForeignPayOrderInfo().link}">${$.Localize('#Shop_ClickJumpPayLink')}</a>`;
              }
            }, _el$26),
            _el$28 = createElement("Label", {
              "class": "PaymentLinkLabelBtn",
              text: "#Shop_ClickJumpExternalPayLink"
            }, _el$26);
          setProp(_el$28, "onactivate", () => {
            $.DispatchEvent("ExternalBrowserGoToURL", getForeignPayOrderInfo().link);
          });
          effect(_$p => setProp(_el$27, "text", `<a href="${getForeignPayOrderInfo().link}">${$.Localize('#Shop_ClickJumpPayLink')}</a>`, _$p));
          return _el$26;
        }
      }));
      insert(_el$29, () => Array(2).fill(null).map((_, i) => {
        return (() => {
          const _el$31 = createElement("Panel", {
              "class": "PayTipRow"
            }, null);
            createElement("Panel", {
              "class": "TipIcon"
            }, _el$31);
            const _el$33 = createElement("Label", {
              get text() {
                return $.Localize("#Shop_PayTip" + (i + 1));
              },
              html: true
            }, _el$31);
          effect(_$p => setProp(_el$33, "text", $.Localize("#Shop_PayTip" + (i + 1)), _$p));
          return _el$31;
        })();
      }));
      insert(_el$3, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_x",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      effect(_p$ => {
        const _v$ = {
            "NotSchinese": !$.Language().includes('chinese')
          },
          _v$2 = GetPriceString(getCurrencyID(), ParseShopPrice(props.tShopItemCfg.price), getSelectedCount()),
          _v$3 = classNames('PayOrderStatus', 'PayOrderStatus_' + getOrderStatus()),
          _v$4 = "#PayOrderStatus_" + getOrderStatus(),
          _v$5 = getOrderStatus() > -1,
          _v$6 = {
            'NotSchinese': !$.Language().includes('chinese')
          },
          _v$7 = classNames('QRCode', 'Alipay'),
          _v$8 = {
            Loading: getAlipayPayOrderInfo().order_id == ''
          },
          _v$9 = classNames('QRCode', 'Wechat'),
          _v$0 = {
            Loading: getWechatPayOrderInfo().order_id == ''
          },
          _v$1 = {
            'NotSchinese': !$.Language().includes('chinese')
          };
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "classList", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$1, "text", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$13, "class", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$14, "text", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$14, "visible", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$16, "classList", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$17, "class", _v$7, _p$._v$7));
        _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$17, "classList", _v$8, _p$._v$8));
        _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$19, "class", _v$9, _p$._v$9));
        _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$19, "classList", _v$0, _p$._v$0));
        _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$21, "classList", _v$1, _p$._v$1));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined,
        _v$7: undefined,
        _v$8: undefined,
        _v$9: undefined,
        _v$0: undefined,
        _v$1: undefined
      });
      return _el$;
    })();
  }

  function ShopBuyItemPopup(props) {
    const getShopItemID = () => {
      var _a;
      return String((_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.product_id);
    };
    const [getSelectedCount, setSelectedCount] = createSignal(1);
    const getLimitCount = () => {
      var _a;
      return (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.limit_count;
    };
    const getCanBuyCount = () => {
      var _a, _b;
      return getLimitCount() != undefined ? getLimitCount() - ((_b = (_a = ServGetter_UserShopLimit()) === null || _a === void 0 ? void 0 : _a[getShopItemID()]) !== null && _b !== void 0 ? _b : 0) : undefined;
    };
    const getCurrencyID = () => {
      var _a, _b;
      return ((_b = (_a = props.tShopItemCfg) === null || _a === void 0 ? void 0 : _a.price) !== null && _b !== void 0 ? _b : '').split("=")[0];
    };
    return (() => {
      const _el$ = createElement("Panel", {
          id: "ShopBuyItemPopup"
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
        createElement("Label", {
          "class": "TitleLabel",
          text: '#Shop_BuyItem'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$8 = createElement("Panel", {
          "class": "ShopItemBuyCost"
        }, _el$7);
        createElement("Label", {
          "class": "ShopItemBuyCostTitle",
          text: '#Popup_ShopItemBuyCost'
        }, _el$8);
        const _el$0 = createElement("Panel", {
          "class": "Body"
        }, _el$8),
        _el$1 = createElement("Label", {
          "class": "ShopItemBuyCostLabel",
          get text() {
            return GetPriceString(getCurrencyID(), ParseShopPrice(props.tShopItemCfg.price), getSelectedCount());
          }
        }, _el$0),
        _el$10 = createElement("Panel", {
          "class": "ShopItemBuyCount"
        }, _el$7);
        createElement("Label", {
          "class": "ShopItemBuyCountTitle",
          text: '#Popup_ShopItemBuyCount'
        }, _el$10);
        const _el$12 = createElement("Panel", {
          "class": "Body"
        }, _el$10);
      setProp(_el$, "onactivate", () => {});
      insert(_el$7, createComponent(ShopItem, {
        get tShopItemCfg() {
          return props.tShopItemCfg;
        },
        hittest: false,
        hittestchildren: false
      }), _el$8);
      insert(_el$7, createComponent(ShopItemDetail, {
        "class": 'ShopItemDetail',
        get tShopItemCfg() {
          return props.tShopItemCfg;
        }
      }), _el$8);
      insert(_el$0, createComponent(Yzy_ServiceTokenImage, {
        get item_id() {
          return getCurrencyID();
        }
      }), _el$1);
      insert(_el$12, createComponent(Yzy_NumberEntryAdjust, {
        get value() {
          return getSelectedCount();
        },
        get max() {
          return getCanBuyCount();
        },
        onChange: (p, value) => {
          setSelectedCount(value);
        }
      }));
      insert(_el$3, createComponent(Yzy_Button, {
        "class": "BuyItemBtn",
        text: "#Popup_BuyItemBtn",
        type: "btn_golden",
        onactivate: () => {
          ShowMouseProcessing();
          Request('Shop_Purchase', {
            'product_id': Number(getShopItemID()),
            'currency': Number(getCurrencyID()),
            'count': getSelectedCount(),
            'user_id': 0
          }).then(rep => {
            HideMouseProcessing();
            if ((rep === null || rep === void 0 ? void 0 : rep.code) == 0) {
              const tTeampShopItemCfg = props.tShopItemCfg;
              const iBuyCount = getSelectedCount();
              HidePopup();
              ShowPopup('shop_buy_item_success_popup', {
                'tShopItemCfg': tTeampShopItemCfg,
                iCount: iBuyCount
              });
            } else {
              if (rep === null || rep === void 0 ? void 0 : rep.msg) {
                ErrorMsg(`#${rep.msg}`);
              }
            }
          });
        }
      }), null);
      insert(_el$3, createComponent(Yzy_Button, {
        "class": "CancelBtn",
        text: "#Popup_CancelBtn",
        type: "btn_purple",
        onactivate: HidePopup
      }), null);
      insert(_el$3, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_x",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      effect(_$p => setProp(_el$1, "text", GetPriceString(getCurrencyID(), ParseShopPrice(props.tShopItemCfg.price), getSelectedCount()), _$p));
      return _el$;
    })();
  }

  function ShopBuyItemSuccessPopup(props) {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "ShopBuyItemSuccessPopup"
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
        createElement("Label", {
          "class": "TitleLabel",
          text: '#ShopBuyItemSuccessPopup'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3);
      setProp(_el$, "onactivate", () => {});
      insert(_el$7, createComponent(ShopItemRewardDetail, {
        "class": 'ShopItemRewardDetail',
        get tShopItemCfg() {
          return props.tShopItemCfg;
        },
        get iCount() {
          return props.iCount;
        }
      }));
      insert(_el$3, createComponent(Yzy_Button, {
        "class": "CloseBtn",
        type: "btn_grey",
        text: "#OFF",
        onactivate: HidePopup
      }), null);
      insert(_el$3, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_1",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      return _el$;
    })();
  }

  function CommonPopup(props) {
    return (() => {
      const _el$ = createElement("Panel", {
          id: "CommonPopup"
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
          "class": "TitleLabel",
          get text() {
            return props.sTitle;
          },
          html: true
        }, _el$4),
        _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3),
        _el$8 = createElement("Label", {
          "class": "ContextLabel",
          get text() {
            return props.sContext;
          },
          html: true
        }, _el$7),
        _el$9 = createElement("Panel", {
          "class": "OperateBtn"
        }, _el$3);
      setProp(_el$, "onactivate", () => {});
      insert(_el$9, createComponent(Yzy_Button, {
        "class": "CancelBtn",
        text: "#Popup_CancelBtn",
        type: "btn_purple",
        onactivate: p => {
          HidePopup();
          if (props.OnCancel) props.OnCancel(p);
        }
      }), null);
      insert(_el$9, createComponent(Show, {
        get when() {
          return props.OnConfirm;
        },
        get children() {
          return createComponent(Yzy_Button, {
            "class": "ConfirmBtn",
            text: "#Popup_ConfirmBtn",
            type: "btn_golden",
            onactivate: p => {
              HidePopup();
              if (props.OnConfirm) props.OnConfirm(p);
            }
          });
        }
      }), null);
      insert(_el$3, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_x",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      effect(_p$ => {
        const _v$ = props.sTitle,
          _v$2 = props.sContext;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$6, "text", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$8, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }

  function DrawRecordPopup(props) {
    var _a, _b, _c, _d, _e;
    const iSize = 10;
    const [getPage, setPage] = createSignal(1);
    const [getPageMax, setPageMax] = createSignal(0);
    const [getRecord, setRecord] = createSignal({});
    let ref;
    createEffect(() => {
      if (getRecord()[getPage()] == undefined) {
        Request('Box_GetBoxRecord', {
          'box_type': props.box_type,
          'box_id': props.box_id,
          'page_index': getPage(),
          'page_size': iSize
        }).then(res => {
          if (!res) return;
          if (ref == undefined || !ref.IsValid()) return;
          if (res.code != 0) {
            if (res.msg) {
              ErrorMsg(res.msg);
            }
            return;
          }
          if (res.data) {
            const tReward2 = Object.assign({}, getRecord());
            tReward2[getPage()] = res.data.list.sort((a, b) => b.id - a.id);
            batch(() => {
              setRecord(tReward2);
              setPageMax(Math.ceil(res.data.count / iSize));
            });
          }
        }).catch(err => {
          UploadError(err);
        });
      }
    });
    return (() => {
      const _el$ = createElement("Panel", {
          "class": "DrawRecordPopup"
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
          text: "#Draw_History"
        }, _el$4);
        const _el$6 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$3),
        _el$7 = createElement("Panel", {
          "class": "Header",
          hittest: false
        }, _el$6),
        _el$8 = createElement("Label", {
          get ["class"]() {
            return classNames('DrawRecordTitle', 'DrawRecordDataTitle');
          },
          text: "#Draw_RecordData"
        }, _el$7),
        _el$9 = createElement("Label", {
          get ["class"]() {
            return classNames('DrawRecordTitle', 'DrawRecordNameTitle');
          },
          text: "#Draw_RecordName"
        }, _el$7),
        _el$0 = createElement("Label", {
          get ["class"]() {
            return classNames('DrawRecordTitle', 'DrawRecordCountTitle');
          },
          text: "#Draw_RecordCount"
        }, _el$7),
        _el$1 = createElement("Label", {
          get ["class"]() {
            return classNames('DrawRecordTitle', 'DrawRecordRewardBoxTitle');
          },
          text: "#Draw_RecordReward"
        }, _el$7),
        _el$10 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$6),
        _el$12 = createElement("Panel", {
          "class": "PageSwitchBtnBox"
        }, _el$6),
        _el$13 = createElement("Button", {
          id: "LeftBtn"
        }, _el$12),
        _el$14 = createElement("Label", {
          get text() {
            return getPage();
          }
        }, _el$12),
        _el$15 = createElement("Button", {
          id: "RightBtn"
        }, _el$12);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$) : ref = _el$;
      insert(_el$10, createComponent(For, {
        get each() {
          return (_b = (_a = getRecord()) === null || _a === void 0 ? void 0 : _a[getPage()]) !== null && _b !== void 0 ? _b : [];
        },
        children: (t, i) => {
          var _a;
          return (() => {
            const _el$16 = createElement("Panel", {
                get ["class"]() {
                  return classNames("DrawRecordRow", i() % 2 == 0 ? 'EvenRow' : 'OddRow');
                }
              }, null),
              _el$17 = createElement("Label", {
                "class": "DrawRecordData",
                get text() {
                  return FormatDate(t.created_at / 1000, 'M/D h:m:s');
                }
              }, _el$16),
              _el$18 = createElement("Label", {
                "class": "DrawRecordName",
                get text() {
                  return '#Draw_box_type_' + t['box_type'];
                }
              }, _el$16),
              _el$19 = createElement("Label", {
                "class": "DrawRecordCount",
                get text() {
                  return t['count'];
                }
              }, _el$16),
              _el$20 = createElement("Panel", {
                "class": "DrawRecordRewardBox"
              }, _el$16),
              _el$21 = createElement("Panel", {}, _el$20);
            setProp(_el$21, "className", "Body");
            insert(_el$21, createComponent(For, {
              get each() {
                return (_a = t.result.data) !== null && _a !== void 0 ? _a : [];
              },
              children: reward => {
                const tData = reward;
                const tItem = tData === null || tData === void 0 ? void 0 : tData.items;
                const sItemID = tItem === null || tItem === void 0 ? void 0 : tItem.id;
                const iCount = tItem === null || tItem === void 0 ? void 0 : tItem.count;
                const iRarity = {
                  N: 1,
                  R: 2,
                  SR: 3,
                  SSR: 4,
                  UR: 5
                }[tData.rarity];
                return (() => {
                  const _el$22 = createElement("Panel", {}, null);
                  insert(_el$22, createComponent(Yzy_ServiceItem, {
                    data: {
                      'id': sItemID,
                      count: iCount
                    },
                    rarity: iRarity
                  }));
                  effect(_$p => setProp(_el$22, "className", classNames("DrawRecordReward"), _$p));
                  return _el$22;
                })();
              }
            }));
            effect(_p$ => {
              const _v$8 = classNames("DrawRecordRow", i() % 2 == 0 ? 'EvenRow' : 'OddRow'),
                _v$9 = FormatDate(t.created_at / 1000, 'M/D h:m:s'),
                _v$0 = '#Draw_box_type_' + t['box_type'],
                _v$1 = t['count'];
              _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$16, "class", _v$8, _p$._v$8));
              _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$17, "text", _v$9, _p$._v$9));
              _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$18, "text", _v$0, _p$._v$0));
              _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$19, "text", _v$1, _p$._v$1));
              return _p$;
            }, {
              _v$8: undefined,
              _v$9: undefined,
              _v$0: undefined,
              _v$1: undefined
            });
            return _el$16;
          })();
        }
      }));
      insert(_el$6, createComponent(Show, {
        get when() {
          return ((_c = getRecord()) === null || _c === void 0 ? void 0 : _c[getPage()]) == undefined;
        },
        get children() {
          return createComponent(Yzy_Loading, {
            type: "Circle"
          });
        }
      }), _el$12);
      insert(_el$6, createComponent(Show, {
        get when() {
          return memo(() => ((_d = getRecord()) === null || _d === void 0 ? void 0 : _d[getPage()]) != undefined)() && ((_e = getRecord()) === null || _e === void 0 ? void 0 : _e[getPage()].length) == 0;
        },
        get children() {
          return createElement("Label", {
            "class": "DrawRecordEmptyLabel",
            text: "#Draw_RecordEmpty"
          }, null);
        }
      }), _el$12);
      setProp(_el$13, "onactivate", () => {
        setPage(getPage() - 1);
      });
      setProp(_el$15, "onactivate", () => {
        setPage(getPage() + 1);
      });
      effect(_p$ => {
        const _v$ = classNames('DrawRecordTitle', 'DrawRecordDataTitle'),
          _v$2 = classNames('DrawRecordTitle', 'DrawRecordNameTitle'),
          _v$3 = classNames('DrawRecordTitle', 'DrawRecordCountTitle'),
          _v$4 = classNames('DrawRecordTitle', 'DrawRecordRewardBoxTitle'),
          _v$5 = getPage() > 1,
          _v$6 = getPage(),
          _v$7 = getPage() < getPageMax();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$8, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$9, "class", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$0, "class", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$1, "class", _v$4, _p$._v$4));
        _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$13, "enabled", _v$5, _p$._v$5));
        _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$14, "text", _v$6, _p$._v$6));
        _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$15, "enabled", _v$7, _p$._v$7));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined,
        _v$4: undefined,
        _v$5: undefined,
        _v$6: undefined,
        _v$7: undefined
      });
      return _el$;
    })();
  }

  function DrawContentPopup({
    items
  }) {
    var _a;
    const tRarityItems = {};
    for (const t of items) {
      tRarityItems[t.rarity] = (_a = tRarityItems[t.rarity]) !== null && _a !== void 0 ? _a : [];
      tRarityItems[t.rarity].push(t);
    }
    return (() => {
      const _el$ = createElement("Panel", {
          "class": "DrawContentPopup"
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
          "class": "Title",
          text: "#Draw_RewardPoolTitle"
        }, _el$4);
        createElement("Label", {
          "class": "Description",
          html: true,
          text: "#Draw_RewardPoolDescription"
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3);
      insert(_el$7, createComponent(Index, {
        each: ['n', 'r', 'sr', 'ssr', 'ur'],
        children: (getRarity, i) => {
          return (() => {
            const _el$8 = createElement("Panel", {
                get ["class"]() {
                  return classNames('RewardRarityRow', 'Rarity_' + (i + 1));
                }
              }, null),
              _el$9 = createElement("Panel", {
                "class": "Header"
              }, _el$8),
              _el$0 = createElement("Label", {
                "class": "Title",
                get text() {
                  return '#Draw_Rarity_' + getRarity();
                }
              }, _el$9),
              _el$1 = createElement("Panel", {}, _el$8);
            setProp(_el$1, "className", "Body");
            insert(_el$1, () => (tRarityItems[getRarity()] || []).map((t, i) => {
              return createComponent(Yzy_ServiceItem, {
                get data() {
                  return {
                    'id': String(t.item_id)
                  };
                },
                get rarity() {
                  return {
                    'n': 1,
                    'r': 2,
                    'sr': 3,
                    'ssr': 4,
                    'ur': 5
                  }[getRarity()];
                }
              });
            }));
            effect(_p$ => {
              const _v$ = classNames('RewardRarityRow', 'Rarity_' + (i + 1)),
                _v$2 = '#Draw_Rarity_' + getRarity();
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$8, "class", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$0, "text", _v$2, _p$._v$2));
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

  const CfgGetter_destiny_hero = useSystemConfig('destiny_hero');

  function ServiceItem2Type(item_id) {
    var _a;
    return Number((_a = String(item_id)) === null || _a === void 0 ? void 0 : _a.substring(0, 3));
  }
  function ServiceItem2Name(item_id) {
    switch (ServiceItem2Type(item_id)) {
      case 210:
      case 106:
        const sName = $.Localize("#" + item_id);
        return SpanText(sName, 'AttributeName');
      default:
        return $.Localize("#" + item_id);
    }
  }

  const ServGetter_UserDestinyHero = useNetEventTable(t => t, 'service', () => 'UserDestinyHero_' + getter_iLocalPlayer())[0];

  const ServGetter_UserDestinyMibao = useNetEventTable(t => t, 'service', () => 'UserDestinyMibao_' + getter_iLocalPlayer())[0];

  const CfgGetter_destiny_mibao = useSystemConfig('destiny_mibao');

  function DrawWishPopup(props) {
    var _a, _b, _c, _d, _e;
    const [getItemID, setItemID] = createSignal((_a = props.item_id) !== null && _a !== void 0 ? _a : 0);
    const getCfg = () => {
      return {
        '3': CfgGetter_destiny_hero,
        '4': CfgGetter_destiny_mibao
      }[props.pool_id];
    };
    const getDestinyStar = id => {
      var _a, _b, _c, _d, _e, _f;
      return ((_c = (_b = (_a = ServGetter_UserDestinyHero()) === null || _a === void 0 ? void 0 : _a[id]) === null || _b === void 0 ? void 0 : _b.level) !== null && _c !== void 0 ? _c : 0) + ((_f = (_e = (_d = ServGetter_UserDestinyMibao()) === null || _d === void 0 ? void 0 : _d[id]) === null || _e === void 0 ? void 0 : _e.level) !== null && _f !== void 0 ? _f : 0);
    };
    createEffect(() => {
      CopyStringToClipboard(JSON.stringify(props.pool_data));
    });
    return (() => {
      const _el$ = createElement("Panel", {
          "class": "DrawWishPopup",
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "Header"
        }, _el$);
        createElement("Panel", {
          "class": "BG",
          hittest: false
        }, _el$);
        const _el$4 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$5 = createElement("Panel", {
          "class": "WishContainer"
        }, _el$4);
        createElement("Label", {
          "class": "WishTitle",
          text: '#WishTitle'
        }, _el$5);
        const _el$7 = createElement("Panel", {
          "class": "WishImageBox"
        }, _el$5),
        _el$0 = createElement("Label", {
          "class": "WishItemLab",
          get text() {
            return memo(() => getItemID() == 0)() ? '#WishListEmpty' : ServiceItem2Name(getItemID());
          }
        }, _el$5);
        createElement("Label", {
          "class": "WishTips",
          text: '#WishTips'
        }, _el$5);
        const _el$10 = createElement("TextButton", {
          "class": "SaveBtn",
          text: "#WishSave"
        }, _el$5),
        _el$11 = createElement("Panel", {
          "class": "WishList"
        }, _el$4);
      setProp(_el$4, "onactivate", () => HidePopup);
      insert(_el$7, createComponent(Show, {
        get when() {
          return getItemID() != 0;
        },
        get children() {
          const _el$8 = createElement("Image", {
            "class": "WishImage",
            get src() {
              return `file://{images}/custom_game/service/items/${getItemID()}.png`;
            }
          }, null);
          effect(_$p => setProp(_el$8, "src", `file://{images}/custom_game/service/items/${getItemID()}.png`, _$p));
          return _el$8;
        }
      }));
      insert(_el$5, createComponent(Show, {
        get when() {
          return getItemID() != 0;
        },
        get children() {
          const _el$9 = createElement("Panel", {
            "class": "DestinyStar"
          }, null);
          insert(_el$9, createComponent(Index, {
            get each() {
              return Array((_d = (_c = ((_b = getCfg()) !== null && _b !== void 0 ? _b : {})[getItemID()]) === null || _c === void 0 ? void 0 : _c['max_level']) !== null && _d !== void 0 ? _d : 0).fill(null);
            },
            children: (_, i) => {
              return createComponent(Yzy_Icon, {
                type: "icon_destiny_star",
                get classList() {
                  return {
                    Active: i < getDestinyStar(getItemID())
                  };
                }
              });
            }
          }));
          return _el$9;
        }
      }), _el$0);
      setProp(_el$10, "onactivate", () => {
        HidePopup();
      });
      insert(_el$11, createComponent(Index, {
        get each() {
          return memo(() => !!((_e = props.pool_data) === null || _e === void 0))() ? void 0 : _e.content.filter(k => k.rarity == 'ur').sort((a, b) => Number(a.item_id) < Number(b.item_id) ? -1 : 1);
        },
        children: (item, i) => {
          var _a, _b, _c, _d, _e, _f, _g;
          return (() => {
            const _el$12 = createElement("Panel", {
                "class": "WishItemRow"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$12);
              const _el$14 = createElement("Image", {
                "class": "WishImage",
                get src() {
                  return `file://{images}/custom_game/service/items/${(_b = item()) === null || _b === void 0 ? void 0 : _b.item_id}.png`;
                }
              }, _el$12),
              _el$15 = createElement("Label", {
                "class": "WishName",
                get text() {
                  return ServiceItem2Name((_c = item()) === null || _c === void 0 ? void 0 : _c.item_id);
                }
              }, _el$12),
              _el$16 = createElement("Panel", {
                "class": "DestinyStar"
              }, _el$12);
            setProp(_el$12, "onactivate", () => {
              var _a, _b, _c;
              setItemID(Number((_b = (_a = item()) === null || _a === void 0 ? void 0 : _a.item_id) !== null && _b !== void 0 ? _b : 0));
              (_c = props.OnWish) === null || _c === void 0 ? void 0 : _c.call(props, getItemID());
            });
            insert(_el$16, createComponent(Index, {
              get each() {
                return Array((_g = (_f = ((_d = getCfg()) !== null && _d !== void 0 ? _d : {})[(_e = item()) === null || _e === void 0 ? void 0 : _e.item_id]) === null || _f === void 0 ? void 0 : _f['max_level']) !== null && _g !== void 0 ? _g : 0).fill(null);
              },
              children: (_, i) => {
                var _a;
                return createComponent(Yzy_Icon, {
                  type: "icon_destiny_star",
                  get classList() {
                    return {
                      Active: i < getDestinyStar((_a = item()) === null || _a === void 0 ? void 0 : _a.item_id)
                    };
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$ = {
                  'Selected': String(getItemID()) == ((_a = item()) === null || _a === void 0 ? void 0 : _a.item_id)
                },
                _v$2 = `file://{images}/custom_game/service/items/${(_b = item()) === null || _b === void 0 ? void 0 : _b.item_id}.png`,
                _v$3 = ServiceItem2Name((_c = item()) === null || _c === void 0 ? void 0 : _c.item_id);
              _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$12, "classList", _v$, _p$._v$));
              _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$14, "src", _v$2, _p$._v$2));
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$15, "text", _v$3, _p$._v$3));
              return _p$;
            }, {
              _v$: undefined,
              _v$2: undefined,
              _v$3: undefined
            });
            return _el$12;
          })();
        }
      }));
      insert(_el$4, createComponent(Yzy_IconButton, {
        "class": "CloseBtn_x",
        type: "icon_btn_close_1",
        onactivate: HidePopup
      }), null);
      effect(_$p => setProp(_el$0, "text", memo(() => getItemID() == 0)() ? '#WishListEmpty' : ServiceItem2Name(getItemID()), _$p));
      return _el$;
    })();
  }

  function Popup() {
    const [getPopup, setPopup] = createSignal({
      sPopup: ''
    });
    const id = EventManager.Reg('popup/ShowPopup', tPopup => {
      setPopup(tPopup);
    });
    onCleanup(() => {
      EventManager.Unreg('popup/ShowPopup', id);
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "Popup",
          get ["class"]() {
            return classNames({
              'ShowPopup': getPopup().sPopup != ''
            });
          }
        }, null),
        _el$2 = createElement("Button", {
          "class": "BG"
        }, _el$),
        _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$);
      setProp(_el$2, "onactivate", p => {
        HidePopup();
      });
      insert(_el$3, createComponent(Switch, {
        get children() {
          return [createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'common_popup';
            },
            get children() {
              return createComponent(CommonPopup, mergeProps(() => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'shop_pay_popup';
            },
            get children() {
              return createComponent(ShopPayPopup, mergeProps({
                get tShopItemCfg() {
                  return getPopup().params;
                }
              }, () => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'shop_buy_item_popup';
            },
            get children() {
              return createComponent(ShopBuyItemPopup, mergeProps(() => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'shop_buy_item_success_popup';
            },
            get children() {
              return createComponent(ShopBuyItemSuccessPopup, mergeProps(() => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'show_reward_popup';
            },
            get children() {
              return [memo(() => Game.EmitSound('DrawReward.GoodReward')), createComponent(RewardPopup, mergeProps(() => getPopup().params))];
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'draw_wish_popup';
            },
            get children() {
              return createComponent(DrawWishPopup, mergeProps(() => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'draw_content_popup';
            },
            get children() {
              return createComponent(DrawContentPopup, mergeProps(() => getPopup().params));
            }
          }), createComponent(Match, {
            get when() {
              return getPopup().sPopup == 'draw_record_popup';
            },
            get children() {
              return createComponent(DrawRecordPopup, mergeProps(() => getPopup().params));
            }
          })];
        }
      }));
      effect(_$p => setProp(_el$, "class", classNames({
        'ShowPopup': getPopup().sPopup != ''
      }), _$p));
      return _el$;
    })();
  }
  try {
    render(() => createComponent(Popup, {}), $("#PopupRoot"));
  } catch (error) {
    UploadError(error, 'Popup');
  }
  try {
    render(() => createComponent(Processing, {}), $("#ProcessingRoot"));
  } catch (error) {
    UploadError(error, 'Processing');
  }

}));