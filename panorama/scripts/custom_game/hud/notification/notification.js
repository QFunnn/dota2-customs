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

  var _a$1, _b, _c, _d, _e;
  if (GameUI.CustomUIConfig().tools == undefined) GameUI.CustomUIConfig().tools = {};
  ENV_NAME = $.GetContextPanel().layoutfile;
  var EventManager = (_a$1 = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a$1, "EventManager"), _a$1.sEnvName = ENV_NAME, _a$1);
  (_b = class extends GameUI.CustomUIConfig().tools.NetEventData {}, __setFunctionName(_b, "NetEventData"), _b.sEnvName = ENV_NAME, _b);
  (_c = class extends GameUI.CustomUIConfig().tools.Keybinds {}, __setFunctionName(_c, "Keybinds"), _c.sEnvName = ENV_NAME, _c);
  (_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {}, __setFunctionName(_d, "Mousebinds"), _d.sEnvName = ENV_NAME, _d);
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
  GameUI.CustomUIConfig().tools.Request;
  GameUI.CustomUIConfig().tools.UnregRequest;
  GameUI.CustomUIConfig().tools.WindowManager;
  var UploadError = GameUI.CustomUIConfig().UploadError;

  function RandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
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
  function GetSystemConfig(sCfg) {
    var _a;
    GameUI.CustomUIConfig()['__config__'] = (_a = GameUI.CustomUIConfig()['__config__']) !== null && _a !== void 0 ? _a : {};
    if (GameUI.CustomUIConfig()['__config__'][sCfg] != undefined) return GameUI.CustomUIConfig()['__config__'][sCfg];
    return GameUI.CustomUIConfig()['__config__'][sCfg] = GameUI.CustomUIConfig().tools.runlua(`return _G['${sCfg}']`);
  }
  function StringToVector(s) {
    return s.split(` `).map(s => Number(s));
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
  function Str2RewardMap(s, separator = '|') {
    let t = {};
    const rws = s.split(separator);
    for (const rw of rws) {
      const [k, v] = rw.split('=');
      t[k] = v;
    }
    return t;
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

  var _a;
  var ScreenPanel = (_a = class extends GameUI.CustomUIConfig().tools.ScreenPanel {
    static render(code, node) {
      return render(code, node);
    }
  }, __setFunctionName(_a, "ScreenPanel"), _a.pEnvContextPanel = $.GetContextPanel(), _a);

  function SideNotification() {
    let ref;
    const [getOpen, setOpen] = createSignal(false);
    createEffect(() => {
      if (ref == undefined) return;
      const id = GameEvents.Subscribe('Notification_SideMsg', tMsg => {
        if (!Players.IsSpectator(Players.GetLocalPlayer()) && tMsg.pid != undefined && tMsg.pid != Players.GetLocalPlayer()) return;
        if (ref) {
          ref === null || ref === void 0 ? void 0 : ref.QueueToast(createComponent(ParseMsgElements, {
            get sMsg() {
              return $.Localize('#Msg_' + tMsg.msg);
            },
            get sClass() {
              return tMsg.class;
            },
            get tParams() {
              return tMsg.params;
            }
          }));
        }
      });
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
      });
    });
    createEffect(() => {
      const pCombat_events = FindDotaHudElement('combat_events');
      if (pCombat_events == undefined) return;
      const id = GameTimer(() => {
        const bRevealCollapsed = pCombat_events.BHasClass('RevealCollapsed');
        if (getOpen() != bRevealCollapsed) {
          setOpen(bRevealCollapsed);
        }
        return 0;
      }, 0, undefined, 'SideNotification');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$ = createElement("Panel", {
          id: "SideNotification",
          hittest: false
        }, null),
        _el$2 = createElement("GenericPanel", {
          type: "ToastManager",
          "class": "Body",
          hittest: false,
          toastduration: "10s",
          maxtoastsvisible: "15",
          maxtoastbehavior: "deleteoldest",
          preservefadedtoasts: "true",
          delaytime: "0",
          addtoaststohead: "false"
        }, _el$);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$2) : ref = _el$2;
      effect(_$p => setProp(_el$, "className", classNames({
        'RevealCollapsed': getOpen()
      }), _$p));
      return _el$;
    })();
  }
  class ResetActions extends BaseAction {
    constructor(actions = []) {
      super();
      this.currentActionIndex = 0;
      this.currentActionStarted = false;
      this.actions = actions;
    }
    start() {
      this.actions = [];
      this.currentActionIndex = 0;
      this.currentActionStarted = false;
    }
    addAction(...actions) {
      this.actions.push(...actions);
    }
    reset() {
      if (this.currentActionStarted) {
        this.actions[this.currentActionIndex].finish();
      }
      this.actions = [];
      this.currentActionIndex = 0;
      this.currentActionStarted = false;
    }
    update() {
      while (this.currentActionIndex < this.actions.length) {
        if (!this.currentActionStarted) {
          this.actions[this.currentActionIndex].start();
          this.currentActionStarted = true;
        }
        if (!this.actions[this.currentActionIndex].update()) {
          this.actions[this.currentActionIndex].finish();
          this.currentActionIndex++;
          this.currentActionStarted = false;
        } else {
          return true;
        }
      }
      return false;
    }
    finish() {
      while (this.currentActionIndex < this.actions.length) {
        if (!this.currentActionStarted) {
          this.actions[this.currentActionIndex].start();
          this.currentActionStarted = true;
          this.actions[this.currentActionIndex].update();
        }
        this.actions[this.currentActionIndex].finish();
        this.currentActionIndex++;
        this.currentActionStarted = false;
      }
    }
  }
  function UpdateSingleAction(action) {
    action.start();
    let callback = function () {
      if (!action.update()) {
        action.finish();
      }
      $.Schedule(Game.GetGameFrameTime(), callback);
    };
    callback();
  }
  const TopNotificationSeq = new ResetActions();
  const TopNotificationTime = 3.0;
  UpdateSingleAction(TopNotificationSeq);
  function TopNotification() {
    let ref;
    createEffect(() => {
      if (ref == undefined) return;
      const id = GameEvents.Subscribe('Notification_TopMsg', tMsg => {
        if (ref) {
          if (tMsg.override) {
            TopNotificationSeq.reset();
          }
          const SingleSeq = new RunSequentialActions();
          let pPanel;
          let pParticle;
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pPanel = $.CreatePanel('Panel', ref, 'TopNotificationPanel', {
              hittest: false
            });
            pParticle = $.CreatePanel('DOTAParticleScenePanel', pPanel, 'TopNotificationParticle', {
              particleonly: "true",
              particleName: 'particles/ui/top_notification/top_notification.vpcf',
              cameraOrigin: "0 -150 460",
              lookAt: "0 -150 0",
              fov: "90",
              squarePixels: "true",
              hittest: false
            });
          }));
          SingleSeq.actions.push(new WaitAction(0.3));
          let pTitle;
          let pText;
          SingleSeq.actions.push(new RunFunctionAction(function () {
            if (pPanel) {
              pTitle = $.CreatePanel('Label', pPanel, 'TopNotificationTitle', {
                text: $.Localize('#Msg_' + tMsg.msg),
                hittest: false,
                html: true
              });
              pTitle.AddClass('PopOut');
              pText = $.CreatePanel('Panel', pPanel, 'TopNotificationText');
              render(() => createComponent(ParseMsgElements, {
                get sMsg() {
                  return $.Localize('#Msg_' + tMsg.msg + '_Description');
                },
                get tParams() {
                  return tMsg.params;
                }
              }), pText);
              pText.AddClass('PopOut');
            }
          }));
          SingleSeq.actions.push(new WaitAction(tMsg.duration || TopNotificationTime));
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pParticle === null || pParticle === void 0 ? void 0 : pParticle.StopParticlesWithEndcaps();
            pTitle.RemoveClass('PopOut');
            pText.RemoveClass('PopOut');
          }));
          SingleSeq.actions.push(new WaitAction(3));
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pPanel === null || pPanel === void 0 ? void 0 : pPanel.DeleteAsync(-1);
          }));
          TopNotificationSeq.actions.push(SingleSeq);
        }
      });
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
      });
    });
    return (() => {
      const _el$3 = createElement("Panel", {
        id: "TopNotification",
        hittest: false
      }, null);
      const _ref$2 = ref;
      typeof _ref$2 === "function" ? use(_ref$2, _el$3) : ref = _el$3;
      return _el$3;
    })();
  }
  function BulletNotification() {
    let ref;
    createEffect(() => {
      if (ref == undefined) return;
      const id = GameEvents.Subscribe('Notification_BulletMsg', tMsg => {
        if (!Players.IsSpectator(Players.GetLocalPlayer()) && tMsg.pid != undefined && tMsg.pid != Players.GetLocalPlayer()) return;
        if (ref) {
          const SingleSeq = new RunSequentialActions();
          let pPanel;
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pPanel = $.CreatePanel('Panel', ref, 'BulletNotificationPanel', {
              hittest: false,
              style: `margin-top:${RandomInt(0, 7) * 50}px;`
            });
          }));
          SingleSeq.actions.push(new WaitAction(0.3));
          let pText;
          SingleSeq.actions.push(new RunFunctionAction(function () {
            if (pPanel) {
              pText = $.CreatePanel('Panel', pPanel, 'BulletNotificationText');
              render(() => createComponent(ParseMsgElements, {
                get sMsg() {
                  return $.Localize('#Msg_' + tMsg.msg);
                },
                get tParams() {
                  return tMsg.params;
                }
              }), pText);
              pText.AddClass('PopOut');
            }
          }));
          SingleSeq.actions.push(new WaitAction(tMsg.duration || 10));
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pText.RemoveClass('PopOut');
          }));
          SingleSeq.actions.push(new WaitAction(3));
          SingleSeq.actions.push(new RunFunctionAction(function () {
            pPanel === null || pPanel === void 0 ? void 0 : pPanel.DeleteAsync(-1);
          }));
          UpdateSingleAction(SingleSeq);
        }
      });
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
      });
    });
    return (() => {
      const _el$4 = createElement("Panel", {
        id: "BulletNotification",
        hittest: false
      }, null);
      const _ref$3 = ref;
      typeof _ref$3 === "function" ? use(_ref$3, _el$4) : ref = _el$4;
      return _el$4;
    })();
  }
  function RewardNotification() {
    let refUID = 0;
    const [getItems, setItems] = createSignal([]);
    const refItems = [];
    const refItemsQueue = [];
    let fPushCD = 0;
    function onMsg(event) {
      for (const t of JSON.parse(event.items)) {
        refItemsQueue.push({
          uid: refUID++,
          item: t
        });
      }
      if (refItemsQueue.length > 0) {
        Timer(() => {
          const t = refItemsQueue.shift();
          t.end_time = Game.Time() + 1;
          refItems.push(t);
          setItems([...refItems]);
          let fDelay;
          if (refItems.length >= 5) {
            fDelay = Math.max(refItems[0].end_time - Game.Time() + 0.1, 0.1);
          } else {
            fDelay = 0.1;
          }
          fPushCD = Game.Time() + fDelay;
          if (refItemsQueue.length > 0) {
            return fDelay;
          }
        }, fPushCD - Game.Time(), 'RewardNotification');
      }
    }
    const id = GameEvents.Subscribe("Notification_RewardMsg", onMsg);
    const id2 = EventManager.Reg('Notification_RewardMsg', onMsg);
    onCleanup(() => {
      GameEvents.Unsubscribe(id);
      EventManager.Unreg('Notification_RewardMsg', id2);
      StopTimer('RewardNotification');
    });
    createEffect(() => {
      if (getItems().length == 0) return;
      const id = GameTimer(() => {
        for (let i = getItems().length - 1; i >= 0; --i) {
          const t = getItems()[i];
          if (Game.Time() >= t.end_time) {
            refItems.splice(0, i + 1);
            setItems([...refItems]);
            break;
          } else if (t.end_time - Game.Time() <= 0.2) {
            const p = $('#NotificationRewardPanel' + t.uid);
            if (p && p.IsValid() && !p.BHasClass('Disable')) {
              p.AddClass('Disable');
            }
          }
        }
        return 0;
      }, 0, undefined, 'RewardNotification');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$5 = createElement("Panel", {
        id: "RewardNotification",
        hittest: false
      }, null);
      insert(_el$5, createComponent(For, {
        get each() {
          return getItems();
        },
        children: t => {
          return (() => {
            const _el$6 = createElement("Panel", {
                get id() {
                  return "NotificationRewardPanel" + t.uid;
                },
                hittest: true
              }, null),
              _el$7 = createElement("Panel", {}, _el$6);
            setProp(_el$6, "className", "MsgPanel");
            setProp(_el$7, "className", "Body");
            insert(_el$7, createComponent(Yzy_ServiceItem, {
              get data() {
                return t.item;
              }
            }));
            effect(_$p => setProp(_el$6, "id", "NotificationRewardPanel" + t.uid, _$p));
            return _el$6;
          })();
        }
      }));
      return _el$5;
    })();
  }
  function SideRewardNotification() {
    let ref;
    const refItems = [];
    createEffect(() => {
      function onMsg(event) {
        var _a;
        for (const t of JSON.parse(event.items)) {
          let iRarity = 1;
          const getItemType = () => {
            var _a;
            return Number((_a = t.id) === null || _a === void 0 ? void 0 : _a.substring(0, 3));
          };
          if (getItemType() == 210) {
            iRarity = (_a = t.equips) === null || _a === void 0 ? void 0 : _a.rarity;
          }
          refItems.push({
            'data': t,
            'rarity': iRarity
          });
        }
      }
      const id = GameEvents.Subscribe('Notification_SideRewardMsg', onMsg);
      const id1 = EventManager.Reg('Notification_SideRewardMsg', onMsg);
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
        EventManager.Unreg('Notification_SideRewardMsg', id1);
      });
    });
    createEffect(() => {
      const id = GameTimer(() => {
        if (refItems.length == 0) return 0.3;
        const tItem = refItems.shift();
        if (tItem && ref) {
          ref.QueueToast((() => {
            const _el$8 = createElement("Panel", {
              get ["class"]() {
                return classNames('ItemRow', 'Rarity_' + tItem.rarity);
              }
            }, null);
            insert(_el$8, createComponent(Yzy_ServiceItem, {
              get data() {
                return tItem.data;
              }
            }), null);
            insert(_el$8, createComponent(Yzy_ServiceItemName, {
              get data() {
                return tItem.data;
              }
            }), null);
            effect(_$p => setProp(_el$8, "class", classNames('ItemRow', 'Rarity_' + tItem.rarity), _$p));
            return _el$8;
          })());
        }
        return 0.3;
      }, 0, 'SideRewardNotification');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$9 = createElement("Panel", {
          id: "SideRewardNotification",
          hittest: false
        }, null),
        _el$0 = createElement("Panel", {
          id: "SideRewardNotificationWrapper",
          hittest: false
        }, _el$9),
        _el$1 = createElement("GenericPanel", {
          type: "ToastManager",
          "class": "Body",
          hittest: false,
          toastduration: "2s",
          maxtoastsvisible: "5",
          maxtoastbehavior: "deleteoldest",
          preservefadedtoasts: "true",
          delaytime: "0",
          addtoaststohead: "false"
        }, _el$0);
      const _ref$4 = ref;
      typeof _ref$4 === "function" ? use(_ref$4, _el$1) : ref = _el$1;
      effect(_$p => setProp(_el$9, "className", classNames({}), _$p));
      return _el$9;
    })();
  }
  function AddCardAnimationNotification() {
    let p;
    createEffect(() => {
      function onMsg(event) {
        if (p === null || p === void 0 ? void 0 : p.IsValid()) {
          const vStart = StringToVector(event.vStart);
          const vEnd = StringToVector(event.vEnd);
          ScreenPanel.CreateOnPanel({
            'pTarget': p,
            'content': () => {
              let ref;
              Timer(() => {
                if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                  ref.style.transitionDuration = '0.8s';
                  ref.style.position = `${vEnd[0]}px ${vEnd[1]}px 0px`;
                  ref.style.opacity = '0';
                }
              }, 0.1);
              return (() => {
                const _el$10 = createElement("Panel", {
                    id: 'AddCard',
                    hittest: false,
                    get style() {
                      return {
                        width: `${Game.GetScreenWidth()}px`,
                        height: `${Game.GetScreenHeight()}px`
                      };
                    }
                  }, null),
                  _el$11 = createElement("Panel", {
                    get style() {
                      return {
                        width: '64px',
                        height: '64px',
                        position: `${vStart[0]}px ${vStart[1]}px 0px`
                      };
                    }
                  }, _el$10);
                setProp(_el$11, "onload", p1 => {
                  const tStyle = {
                    1: {
                      saturation: 0.1,
                      brightness: 0.7
                    }}[1];
                  ScreenPanel.CreateOnPanel({
                    'pTarget': p1,
                    'content': () => (() => {
                      const _el$12 = createElement("Panel", {
                          hittest: false
                        }, null),
                        _el$13 = createElement("DOTAParticleScenePanel", {
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
                        }, _el$12),
                        _el$14 = createElement("DOTAParticleScenePanel", {
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
                        }, _el$12);
                      effect(_p$ => {
                        const _v$3 = Object.assign({
                            width: '600px',
                            height: '600px'
                          }, tStyle),
                          _v$4 = Object.assign({
                            width: '600px',
                            height: '600px',
                            preTransformRotate2d: RandomInt(0, 360) + 'deg'
                          }, tStyle);
                        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$13, "style", _v$3, _p$._v$3));
                        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$14, "style", _v$4, _p$._v$4));
                        return _p$;
                      }, {
                        _v$3: undefined,
                        _v$4: undefined
                      });
                      return _el$12;
                    })(),
                    fInterval: 0.35,
                    fDuration: 1
                  });
                });
                insert(_el$10, createComponent(Yzy_ItemImage, {
                  ref(r$) {
                    const _ref$5 = ref;
                    typeof _ref$5 === "function" ? _ref$5(r$) : ref = r$;
                  },
                  get ["class"]() {
                    return classNames('FlyAni');
                  },
                  get name() {
                    return event.sCardName;
                  },
                  get style() {
                    return {
                      width: '64px',
                      height: '64px',
                      position: `${vStart[0]}px ${vStart[1]}px 0px`,
                      preTransformScale2d: '1',
                      transitionDuration: '0s'
                    };
                  }
                }), null);
                effect(_p$ => {
                  const _v$ = {
                      width: `${Game.GetScreenWidth()}px`,
                      height: `${Game.GetScreenHeight()}px`
                    },
                    _v$2 = {
                      width: '64px',
                      height: '64px',
                      position: `${vStart[0]}px ${vStart[1]}px 0px`
                    };
                  _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$10, "style", _v$, _p$._v$));
                  _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$11, "style", _v$2, _p$._v$2));
                  return _p$;
                }, {
                  _v$: undefined,
                  _v$2: undefined
                });
                return _el$10;
              })();
            },
            fDuration: 1,
            onStart: p => {}
          });
        }
      }
      const id = GameEvents.Subscribe('Notification_AddCardAnimation', onMsg);
      const id1 = EventManager.Reg('Notification_AddCardAnimation', onMsg);
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
        EventManager.Unreg('Notification_AddCardAnimation', id1);
      });
    });
    return (() => {
      const _el$15 = createElement("Panel", {
          id: "AddCardAnimationNotification",
          hittest: false
        }, null),
        _el$16 = createElement("Panel", {
          id: "AddCardAnimationPanel",
          hittest: false
        }, _el$15);
      const _ref$6 = p;
      typeof _ref$6 === "function" ? use(_ref$6, _el$16) : p = _el$16;
      effect(_$p => setProp(_el$15, "className", classNames({}), _$p));
      return _el$15;
    })();
  }
  function DevourCardAnimationNotification() {
    let p;
    createEffect(() => {
      function onMsg(event) {
        var _a;
        const vStart = (_a = GameUI.CustomUIConfig()) === null || _a === void 0 ? void 0 : _a[`CardRow_${event.index}`];
        if (vStart == undefined) return;
        if (p === null || p === void 0 ? void 0 : p.IsValid()) {
          ScreenPanel.CreateOnPanel({
            'pTarget': p,
            'content': () => {
              let ref;
              Timer(() => {
                if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                  ref.style.transitionDuration = '0.8s';
                  let resolution = [Game.GetScreenWidth(), Game.GetScreenHeight()];
                  if (resolution[1] / resolution[0] == 9 / 16) {
                    ref.style.position = '423px 912px 0px';
                  } else if (resolution[1] / resolution[0] == 10 / 16) {
                    ref.style.position = '423px 912px 0px';
                  } else if (resolution[1] / resolution[0] == 3 / 4) {
                    ref.style.position = '423px 912px 0px';
                  } else if (resolution[1] / resolution[0] == 9 / 21) {
                    ref.style.position = '75px 765px 0px';
                  } else {
                    ref.style.position = '423px 912px 0px';
                  }
                  ref.style.opacity = '0';
                }
              }, 0.1);
              return (() => {
                const _el$17 = createElement("Panel", {
                  id: 'DevourCard',
                  hittest: false,
                  get style() {
                    return {
                      width: `${Game.GetScreenWidth()}px`,
                      height: `${Game.GetScreenHeight()}px`
                    };
                  }
                }, null);
                insert(_el$17, createComponent(Yzy_ItemImage, {
                  ref(r$) {
                    const _ref$7 = ref;
                    typeof _ref$7 === "function" ? _ref$7(r$) : ref = r$;
                  },
                  get ["class"]() {
                    return classNames('FlyAni');
                  },
                  get name() {
                    return event.sCardName;
                  },
                  get style() {
                    return {
                      width: '64px',
                      height: '64px',
                      position: `${vStart[0]}px ${vStart[1]}px 0px`,
                      preTransformScale2d: '1',
                      transitionDuration: '0s'
                    };
                  },
                  onload: p1 => {
                    Timer(() => {
                      const tStyle = {
                        1: {
                          saturation: 0.1,
                          brightness: 0.7
                        }}[1];
                      ScreenPanel.CreateOnPanel({
                        'pTarget': p1,
                        'content': () => (() => {
                          const _el$18 = createElement("Panel", {
                              hittest: false
                            }, null),
                            _el$19 = createElement("DOTAParticleScenePanel", {
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
                            }, _el$18),
                            _el$20 = createElement("DOTAParticleScenePanel", {
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
                            }, _el$18);
                          effect(_p$ => {
                            const _v$5 = Object.assign({
                                width: '600px',
                                height: '600px'
                              }, tStyle),
                              _v$6 = Object.assign({
                                width: '600px',
                                height: '600px',
                                preTransformRotate2d: RandomInt(0, 360) + 'deg'
                              }, tStyle);
                            _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$19, "style", _v$5, _p$._v$5));
                            _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$20, "style", _v$6, _p$._v$6));
                            return _p$;
                          }, {
                            _v$5: undefined,
                            _v$6: undefined
                          });
                          return _el$18;
                        })(),
                        fInterval: 0.35,
                        fDuration: 1
                      });
                    }, 0.2, 'Notification.DevourCard.Particle');
                    Timer(() => {
                      ScreenPanel.CreateOnPanel({
                        'pTarget': p1,
                        'content': () => (() => {
                          const _el$21 = createElement("Panel", {
                            hittest: false
                          }, null);
                          setProp(_el$21, "onload", p1 => {
                            p1.style.transform = 'translateX(50%) translateY(-50%)';
                          });
                          setProp(_el$21, "style", {
                            width: '50px',
                            height: '50px',
                            backgroundColor: 'gradient( linear, 100% 0%, 0% 100%, from( #00000000 ), color-stop( 0.3, #00000000 ), color-stop( 0.45, #ffffffff ), color-stop( 0.55, #ffffffff ), color-stop( 0.7, #00000000 ), to( #00000000 ) )',
                            transform: 'translateX(-50%) translateY(50%)',
                            transitionDuration: '0.4s',
                            transitionTimingFunction: 'ease-in-out',
                            transitionProperty: 'transform'
                          });
                          return _el$21;
                        })(),
                        fDuration: 0.4
                      });
                    }, 1, 'Notification.DevourCard.Shine');
                  }
                }));
                effect(_$p => setProp(_el$17, "style", {
                  width: `${Game.GetScreenWidth()}px`,
                  height: `${Game.GetScreenHeight()}px`
                }, _$p));
                return _el$17;
              })();
            },
            fDuration: 1.5,
            onStart: p => {}
          });
        }
      }
      const id = GameEvents.Subscribe('Notification_DevourCardAnimation', onMsg);
      const id1 = EventManager.Reg('Notification_DevourCardAnimation', onMsg);
      onCleanup(() => {
        GameEvents.Unsubscribe(id);
        EventManager.Unreg('Notification_DevourCardAnimation', id1);
      });
    });
    return (() => {
      const _el$22 = createElement("Panel", {
          id: "DevourCardAnimationNotification",
          hittest: false
        }, null),
        _el$23 = createElement("Panel", {
          id: "DevourCardAnimationPanel",
          hittest: false
        }, _el$22);
      const _ref$8 = p;
      typeof _ref$8 === "function" ? use(_ref$8, _el$23) : p = _el$23;
      effect(_$p => setProp(_el$22, "className", classNames({}), _$p));
      return _el$22;
    })();
  }
  try {
    render(() => createComponent(SideNotification, {}), $('#SideNotificationRoot'));
  } catch (error) {
    UploadError(error, 'SideNotification');
  }
  try {
    render(() => createComponent(TopNotification, {}), $('#TopNotificationRoot'));
  } catch (error) {
    UploadError(error, 'TopNotification');
  }
  try {
    render(() => createComponent(BulletNotification, {}), $('#BulletNotificationRoot'));
  } catch (error) {
    UploadError(error, 'BulletNotification');
  }
  try {
    render(() => createComponent(RewardNotification, {}), $('#RewardNotificationRoot'));
  } catch (error) {
    UploadError(error, 'RewardNotification');
  }
  try {
    render(() => createComponent(SideRewardNotification, {}), $('#SideRewardNotificationRoot'));
  } catch (error) {
    UploadError(error, 'SideRewardNotification');
  }
  try {
    render(() => createComponent(AddCardAnimationNotification, {}), $('#AddCardAnimationNotificationRoot'));
  } catch (error) {
    UploadError(error, 'AddCardAnimationNotification');
  }
  try {
    render(() => createComponent(DevourCardAnimationNotification, {}), $('#DevourCardAnimationNotificationRoot'));
  } catch (error) {
    UploadError(error, 'DevourCardAnimationNotification');
  }
  function ParseMsgElements({
    sMsg,
    sClass,
    tParams = {}
  }) {
    var _a;
    const merge = mergeProps$1({}, tParams);
    let s = PreprocessMsg(sMsg, merge);
    let tKeyWordPanels = {};
    ((_a = s.match(/\[.*?\]/g)) !== null && _a !== void 0 ? _a : []).forEach(s2 => {
      var _a;
      let sKey = s2.substring(1, s2.length - 1);
      let func = KewWord2Panel(sKey, merge);
      if (func) {
        ((_a = tKeyWordPanels[s2]) !== null && _a !== void 0 ? _a : tKeyWordPanels[s2] = []).push(func());
      } else {
        let val = merge[sKey];
        if (val != undefined) {
          if (typeof val == 'number') {
            s = s.replace(s2, Number(val.toFixed(2)).toString());
          } else {
            if (typeof val == 'string' && val.startsWith('#')) {
              s = s.replace(s2, $.Localize(val));
            } else {
              s = s.replace(s2, val);
            }
          }
        }
      }
    });
    const tElements = [s];
    for (const s2 in tKeyWordPanels) {
      for (const panels of tKeyWordPanels[s2]) {
        for (let i = 0; i < tElements.length; ++i) {
          let v = tElements[i];
          if (typeof v == 'string') {
            let iPos = v.indexOf(s2);
            if (iPos != -1) {
              let sLeft = v.substring(0, iPos);
              let sRight = v.substring(iPos + s2.length);
              let t = [];
              if (sLeft != '') t.push(sLeft);
              t.push(panels);
              if (sRight != '') t.push(sRight);
              tElements.splice(i, 1, ...t);
              break;
            }
          }
        }
      }
    }
    for (let i = 0; i < tElements.length; ++i) {
      if (typeof tElements[i] == 'string') {
        tElements[i] = (() => {
          const _el$24 = createElement("Label", {
            get ["class"]() {
              return classNames('MsgLabel', tParams === null || tParams === void 0 ? void 0 : tParams.classLabel);
            },
            html: true,
            get text() {
              return tElements[i];
            }
          }, null);
          effect(_p$ => {
            const _v$7 = classNames('MsgLabel', tParams === null || tParams === void 0 ? void 0 : tParams.classLabel),
              _v$8 = tElements[i];
            _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$24, "class", _v$7, _p$._v$7));
            _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$24, "text", _v$8, _p$._v$8));
            return _p$;
          }, {
            _v$7: undefined,
            _v$8: undefined
          });
          return _el$24;
        })();
      }
    }
    return (() => {
      const _el$25 = createElement("Panel", {
        id: "MsgContainer",
        get ["class"]() {
          return classNames(sClass);
        }
      }, null);
      insert(_el$25, tElements);
      effect(_$p => setProp(_el$25, "class", classNames(sClass), _$p));
      return _el$25;
    })();
  }
  function KewWord2Panel(sKey, tParams) {
    switch (sKey) {
      case 'game_item':
        return () => (() => {
          const _el$26 = createElement("Image", {
            get src() {
              return `file://{images}/items/${tParams[sKey]}.png`;
            },
            hittest: true
          }, null);
          setProp(_el$26, "className", "MsgItemImage");
          effect(_$p => setProp(_el$26, "src", `file://{images}/items/${tParams[sKey]}.png`, _$p));
          return _el$26;
        })();
    }
    if (sKey.search(/\player_[0-9]+/) != -1) {
      let iPlayerID = tParams[sKey];
      if (iPlayerID == undefined) return;
      let tPlayerInfo = Game.GetPlayerInfo(iPlayerID);
      return () => {
        return (() => {
          const _el$27 = createElement("Panel", {
              get ["class"]() {
                return classNames("PlayerPanel", tParams === null || tParams === void 0 ? void 0 : tParams.classImage);
              },
              hittestchildren: false
            }, null),
            _el$28 = createElement("DOTAAvatarImage", {
              get steamid() {
                return tPlayerInfo === null || tPlayerInfo === void 0 ? void 0 : tPlayerInfo.player_steamid;
              },
              hittest: false
            }, _el$27),
            _el$29 = createElement("Label", {
              html: true,
              text: "{g:dota_player_name:nh:player_id}",
              dialogVariables: {
                'player_id': iPlayerID
              },
              hittest: false
            }, _el$27);
          setProp(_el$28, "style", {
            align: 'left center',
            height: '90%',
            width: 'height-percentage(100%)',
            margin: '4px'
          });
          setProp(_el$29, "className", "MsgLabel PlayerName");
          setProp(_el$29, "dialogVariables", {
            'player_id': iPlayerID
          });
          effect(_p$ => {
            const _v$9 = classNames("PlayerPanel", tParams === null || tParams === void 0 ? void 0 : tParams.classImage),
              _v$0 = tPlayerInfo === null || tPlayerInfo === void 0 ? void 0 : tPlayerInfo.player_steamid;
            _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$27, "class", _v$9, _p$._v$9));
            _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$28, "steamid", _v$0, _p$._v$0));
            return _p$;
          }, {
            _v$9: undefined,
            _v$0: undefined
          });
          return _el$27;
        })();
      };
    }
    if (sKey.search(/LOCALIZE(.*)/) != -1) {
      const s = sKey.slice(9, -1);
      if (sKey.search(/\>.*?\</g) != -1) {
        let iIndex = sKey.indexOf('>');
        let iIndex1 = sKey.lastIndexOf('<');
        let sNewKey = sKey.substring(iIndex + 1, iIndex1);
        if ($.Localize(`#${sNewKey}`) != "#" + sNewKey) {
          return () => (() => {
            const _el$30 = createElement("Label", {
              html: true,
              text: '#' + sNewKey,
              dialogVariables: tParams
            }, null);
            setProp(_el$30, "className", "MsgLabel");
            setProp(_el$30, "text", '#' + sNewKey);
            setProp(_el$30, "dialogVariables", tParams);
            setProp(_el$30, "onload", p => {
              p.text = ReplaceTextVariable(s.replace(sNewKey, p.text), tParams);
            });
            return _el$30;
          })();
        }
      }
      return () => (() => {
        const _el$31 = createElement("Label", {
          html: true,
          text: '#' + s,
          dialogVariables: tParams
        }, null);
        setProp(_el$31, "className", "MsgLabel");
        setProp(_el$31, "text", '#' + s);
        setProp(_el$31, "dialogVariables", tParams);
        setProp(_el$31, "onload", p => {
          p.text = ReplaceTextVariable(p.text, tParams);
        });
        return _el$31;
      })();
    }
    if (sKey.search(/LOCABLT(.*)/) != -1) {
      const [s, ablt] = sKey.slice(8, -1).split(',');
      let sAblt = ablt;
      let iLevel = 1;
      if (!isNaN(Number(ablt))) {
        sAblt = Abilities.GetAbilityName(Number(ablt));
        iLevel = Abilities.GetLevel(Number(ablt));
      }
      return () => (() => {
        const _el$32 = createElement("Label", {
          text: '#' + s,
          dialogVariables: tParams,
          html: true
        }, null);
        setProp(_el$32, "className", "MsgLabel");
        setProp(_el$32, "text", '#' + s);
        setProp(_el$32, "dialogVariables", tParams);
        setProp(_el$32, "onload", p => {
          let sText = ReplaceTextVariable(p.text, tParams);
          const tKv = AbilitiesKv[sAblt];
          if (tKv) {
            for (const sKey in tKv.AbilityValues) {
              let tVals = String(tKv.AbilityValues[sKey]).split(' ');
              let fVal = tVals[Math.min(iLevel - 1, tVals.length - 1)];
              sText = sText.replace(new RegExp(`%${sKey}%%%`, 'gm'), `${fVal}%`);
              sText = sText.replace(new RegExp(`%${sKey}%`, 'gm'), fVal);
            }
          }
          p.text = sText;
        });
        return _el$32;
      })();
    }
  }
  function PreprocessMsg(sMsg, tParams) {
    var _a;
    ((_a = sMsg.match(/\[[A-Z]*\(.*\)\]/g)) !== null && _a !== void 0 ? _a : []).forEach(s2 => {
      let s3 = s2;
      for (const sKey in tParams) {
        let s = `[${sKey}]`;
        while (s3.indexOf(s) != -1) {
          s3 = s3.replace(s, tParams[sKey]);
        }
      }
      sMsg = sMsg.replace(s2, s3);
    });
    return sMsg;
  }

}));