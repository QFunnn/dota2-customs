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
  (_a = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a, "EventManager"), _a.sEnvName = ENV_NAME, _a);
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
  var EachPlayer = _Player.EachPlayer.bind(_Player);
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
  GameUI.CustomUIConfig().UploadError;

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

  render(() => createComponent(OverHead, {}), $.GetContextPanel());
  function OverHead() {
    return (() => {
      const _el$ = createElement("Panel", {
        hittest: false
      }, null);
      setProp(_el$, "className", "OverHead");
      insert(_el$, createComponent(PlayerHpBarBox, {}), null);
      insert(_el$, createComponent(TowerOverhead, {}), null);
      insert(_el$, createComponent(NpcFountain, {}), null);
      insert(_el$, createComponent(NpcNeutral, {}), null);
      insert(_el$, createComponent(NpcChallenge, {}), null);
      insert(_el$, createComponent(NpcMainChallenge, {}), null);
      insert(_el$, createComponent(NpcAdventure, {}), null);
      insert(_el$, createComponent(NpcArchiveChallenge, {}), null);
      insert(_el$, createComponent(NpcBoss, {}), null);
      insert(_el$, createComponent(NpcBossTreasure, {}), null);
      insert(_el$, createComponent(NpcArchive, {}), null);
      insert(_el$, createComponent(NpcRaidChallenge, {}), null);
      insert(_el$, createComponent(NpcBoss5_6, {}), null);
      return _el$;
    })();
  }
  function PlayerHpBarBox() {
    let ref;
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        if (!ref) return;
        EachPlayer(iPlayerID => {
          const p = ref.FindChild('PlayerHpBar' + iPlayerID);
          if (!p) return;
          const iEntID = Players.GetPlayerHeroEntityIndex(iPlayerID);
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) return;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) return;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          fPct = Number(Number(Entities.GetMana(iEntID) / Math.max(Entities.GetMaxMana(iEntID), 1) * 100).toFixed(2));
          pBar = p.FindChildInLayoutFile('MpFG');
          if (pBar) {
            pBar.style.transform = `translateX(-${100 - fPct || 0}%)`;
          }
        });
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    const getPlayers = createMemo(() => {
      const t = [];
      EachPlayer(iPlayerID => {
        t.push(iPlayerID);
      });
      return t;
    });
    return (() => {
      const _el$2 = createElement("Panel", {
        id: "PlayerHpBarBox",
        hittest: false
      }, null);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$2) : ref = _el$2;
      insert(_el$2, createComponent(For, {
        get each() {
          return getPlayers();
        },
        children: getPlayerID => {
          return createComponent(PlayerHpBar, {
            getPlayerID: getPlayerID
          });
        }
      }));
      return _el$2;
    })();
  }
  function PlayerHpBar(props) {
    const getter = PropsGetter(props);
    const [getCosplayTitle] = useNetEventTable(t => {
      var _a;
      return (_a = t === null || t === void 0 ? void 0 : t[4]) === null || _a === void 0 ? void 0 : _a.item_id;
    }, 'service', () => 'UserCosplay_' + props.getPlayerID);
    const tCosplayTitleFX = {};
    return (() => {
      const _el$3 = createElement("Panel", {
          get id() {
            return 'PlayerHpBar' + getter.getPlayerID();
          },
          get style() {
            return {
              zIndex: getter.getPlayerID() == Players.GetLocalPlayer() ? 1 : 0
            };
          },
          hittest: false
        }, null),
        _el$5 = createElement("Panel", {
          hittest: false
        }, _el$3),
        _el$6 = createElement("Panel", {
          "class": "PlayerDetial"
        }, _el$5),
        _el$7 = createElement("Panel", {
          id: "TitlePanel"
        }, _el$6),
        _el$8 = createElement("Label", {
          html: true,
          text: "{g:dota_player_name:nh:nc:player_id}",
          get dialogVariables() {
            return {
              player_id: getter.getPlayerID()
            };
          }
        }, _el$7),
        _el$9 = createElement("Panel", {
          hittest: false
        }, _el$5),
        _el$0 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$9),
        _el$1 = createElement("Panel", {}, _el$0),
        _el$10 = createElement("Panel", {
          id: "HpBar"
        }, _el$1),
        _el$11 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$10),
        _el$12 = createElement("Panel", {
          id: "HpFG"
        }, _el$10);
        createElement("DOTAScenePanel", {
          map: "scenes/hud/healthbarburner",
          camera: "camera_1",
          renderdeferred: false,
          rendershadows: false,
          hittest: false,
          particleonly: true
        }, _el$12);
        const _el$14 = createElement("Panel", {
          id: "MpBar"
        }, _el$1),
        _el$15 = createElement("Panel", {
          id: "MpFG"
        }, _el$14);
        createElement("DOTAScenePanel", {
          map: "scenes/hud/healthbarburner",
          camera: "camera_1",
          renderdeferred: false,
          rendershadows: false,
          hittest: false,
          particleonly: true
        }, _el$15);
      setProp(_el$3, "className", "PlayerHpBar");
      insert(_el$3, createComponent(Show, {
        get when() {
          return tCosplayTitleFX[getCosplayTitle()];
        },
        get children() {
          const _el$4 = createElement("DOTAParticleScenePanel", {
            "class": "CosplayTitle_FX",
            get particleName() {
              return tCosplayTitleFX[getCosplayTitle()];
            },
            cameraOrigin: "300 0 0",
            lookAt: "0 0 0",
            fov: 90,
            hittest: false
          }, null);
          effect(_$p => setProp(_el$4, "particleName", tCosplayTitleFX[getCosplayTitle()], _$p));
          return _el$4;
        }
      }), _el$5);
      setProp(_el$5, "className", "Body");
      insert(_el$6, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return getter.getPlayerID();
        },
        hittest: false,
        hittestchildren: false
      }), _el$7);
      setProp(_el$8, "className", "TitleLabel");
      setProp(_el$9, "className", "Body");
      setProp(_el$1, "className", "Body");
      setProp(_el$11, "className", "BufferPanel");
      setProp(_el$12, "className", "FG");
      setProp(_el$15, "className", "FG");
      effect(_p$ => {
        const _v$ = 'PlayerHpBar' + getter.getPlayerID(),
          _v$2 = {
            zIndex: getter.getPlayerID() == Players.GetLocalPlayer() ? 1 : 0
          },
          _v$3 = {
            player_id: getter.getPlayerID()
          };
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$3, "id", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$3, "style", _v$2, _p$._v$2));
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$8, "dialogVariables", _v$3, _p$._v$3));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined,
        _v$3: undefined
      });
      return _el$3;
    })();
  }
  function TowerOverhead() {
    const [getDoor] = useNetEventTable(t => t, 'tower', 'door');
    return (() => {
      const _el$17 = createElement("Panel", {
        id: 'TowerOverhead',
        hittest: false
      }, null);
      insert(_el$17, createComponent(Show, {
        get when() {
          return getDoor();
        },
        get children() {
          return createComponent(TowerDoorBar, {
            get entid() {
              return getDoor();
            }
          });
        }
      }));
      return _el$17;
    })();
  }
  function TowerDoorBar(props) {
    let ref;
    const getter = PropsGetter(props);
    createEffect(() => {
      const iEntID = getter.entid();
      const id = Timer(() => {
        if (!UpdateOverheadPanel(ref, iEntID, {
          no_health_bar: false
        })) return 0;
        return 0;
      }, 0, 'TowerDoorBar');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$18 = createElement("Panel", {
          id: "TowerDoorBar"
        }, null);
        createElement("Label", {
          id: "UnitName",
          text: '#npc_tower_door'
        }, _el$18);
      const _ref$2 = ref;
      typeof _ref$2 === "function" ? use(_ref$2, _el$18) : ref = _el$18;
      return _el$18;
    })();
  }
  function NpcFountain() {
    let ref;
    const [getNpcFountain] = useNetEventTable(t => t, 'common', 'fountain');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        if (!ref) return;
        const p = ref.FindChild('NpcFountainHpBar');
        if (!p) return;
        if (!getNpcFountain()) return 0;
        const iEntID = getNpcFountain();
        if (!UpdateOverheadPanel(p, iEntID, {
          no_health_bar: false
        })) return 0;
        fUpCD -= Game.GetGameFrameTime();
        if (fUpCD > 0) return 0;
        fUpCD = 0.1;
        let fPct = Entities.GetHealthPercent(iEntID);
        let pBar = p.FindChildInLayoutFile('HpBufferPanel');
        let s = `translateX(-${100 - fPct || 0}%)`;
        if (pBar) {
          pBar.style.transform = s;
        }
        pBar = p.FindChildInLayoutFile('HpFG');
        if (pBar) {
          pBar.style.transform = s;
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$20 = createElement("Panel", {
          id: "NpcFountain",
          hittest: false
        }, null),
        _el$21 = createElement("Panel", {
          id: "NpcFountainHpBar",
          hittest: false
        }, _el$20),
        _el$22 = createElement("Panel", {
          "class": "Body",
          hittest: false
        }, _el$21),
        _el$23 = createElement("Panel", {
          "class": "Body"
        }, _el$22),
        _el$24 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$23),
        _el$25 = createElement("Panel", {}, _el$24),
        _el$26 = createElement("Panel", {
          id: "HpBar"
        }, _el$25),
        _el$27 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$26),
        _el$28 = createElement("Panel", {
          id: "HpFG"
        }, _el$26);
        createElement("DOTAScenePanel", {
          map: "scenes/hud/healthbarburner",
          camera: "camera_1",
          renderdeferred: false,
          rendershadows: false,
          hittest: false,
          particleonly: true
        }, _el$28);
      const _ref$3 = ref;
      typeof _ref$3 === "function" ? use(_ref$3, _el$20) : ref = _el$20;
      setProp(_el$25, "className", "Body");
      setProp(_el$27, "className", "BufferPanel");
      setProp(_el$28, "className", "FG");
      effect(_$p => setProp(_el$20, "visible", getNpcFountain() != undefined, _$p));
      return _el$20;
    })();
  }
  function NpcNeutral() {
    let ref;
    const [getNeutral, setNeutral] = useNetEventTable(t => t, 'neutral', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getNeutral()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('NeutralHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$30 = createElement("Panel", {
        id: "NpcNeutral",
        hittest: false
      }, null);
      const _ref$4 = ref;
      typeof _ref$4 === "function" ? use(_ref$4, _el$30) : ref = _el$30;
      insert(_el$30, createComponent(For, {
        get each() {
          return Object.keys(getNeutral() || {});
        },
        children: getEntID => {
          return createComponent(NeutralHpBar, {
            get entid() {
              return Number(getEntID);
            }
          });
        }
      }));
      return _el$30;
    })();
  }
  function NeutralHpBar(props) {
    const getter = PropsGetter(props);
    return (() => {
      const _el$31 = createElement("Panel", {
          get id() {
            return 'NeutralHpBar_' + getter.entid();
          }
        }, null);
        createElement("Label", {
          id: "NameLabel",
          text: "{s:name}"
        }, _el$31);
        const _el$33 = createElement("Panel", {}, _el$31),
        _el$34 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$33),
        _el$35 = createElement("Panel", {
          "class": "Body"
        }, _el$34),
        _el$36 = createElement("Panel", {
          id: "HpBar"
        }, _el$35),
        _el$37 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$36),
        _el$38 = createElement("Panel", {
          id: "HpFG"
        }, _el$36);
      setProp(_el$31, "className", "NeutralHpBar");
      setProp(_el$33, "className", "Body");
      setProp(_el$37, "className", "BufferPanel");
      setProp(_el$38, "className", "FG");
      effect(_$p => setProp(_el$31, "id", 'NeutralHpBar_' + getter.entid(), _$p));
      return _el$31;
    })();
  }
  function NpcChallenge() {
    let ref;
    const [getChallenge, setChallenge] = useNetEventTable(t => t, 'challenge', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        var _a, _b;
        for (const key in getChallenge()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('ChallengeHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', ReplaceTextVariable($.Localize(`#${Entities.GetUnitName(iEntID)}`), {
            'val': (((_b = (_a = getChallenge()) === null || _a === void 0 ? void 0 : _a[iEntID]) === null || _b === void 0 ? void 0 : _b.count) || 0) + 1
          }));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$39 = createElement("Panel", {
        id: "NpcChallenge",
        hittest: false
      }, null);
      const _ref$5 = ref;
      typeof _ref$5 === "function" ? use(_ref$5, _el$39) : ref = _el$39;
      insert(_el$39, createComponent(For, {
        get each() {
          return Object.keys(getChallenge() || {});
        },
        children: getEntID => {
          var _a, _b, _c, _d;
          return createComponent(ChallengeHpBar, {
            get entid() {
              return Number(getEntID);
            },
            get player_id() {
              return (_b = (_a = getChallenge()) === null || _a === void 0 ? void 0 : _a[getEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getChallenge()) === null || _c === void 0 ? void 0 : _c[getEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          });
        }
      }));
      return _el$39;
    })();
  }
  function ChallengeHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$40 = createElement("Panel", {
          get id() {
            return 'ChallengeHpBar_' + getter.entid();
          }
        }, null),
        _el$41 = createElement("Panel", {}, _el$40),
        _el$43 = createElement("Panel", {
          "class": "Detial"
        }, _el$41),
        _el$44 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$43),
        _el$45 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$41),
        _el$46 = createElement("Panel", {
          "class": "Body"
        }, _el$45),
        _el$47 = createElement("Panel", {
          id: "HpBar"
        }, _el$46),
        _el$48 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$47),
        _el$49 = createElement("Panel", {
          id: "HpFG"
        }, _el$47);
      setProp(_el$40, "className", "ChallengeHpBar");
      setProp(_el$41, "className", "Body");
      insert(_el$41, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$43);
      insert(_el$43, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$44);
      setProp(_el$48, "className", "BufferPanel");
      setProp(_el$49, "className", "FG");
      effect(_$p => setProp(_el$40, "id", 'ChallengeHpBar_' + getter.entid(), _$p));
      return _el$40;
    })();
  }
  function NpcMainChallenge() {
    let ref;
    const [getMainChallenge, setMainChallenge] = useNetEventTable(t => t, 'main_challenge', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getMainChallenge()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('MainChallengeHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$50 = createElement("Panel", {
        id: "NpcMainChallenge",
        hittest: false
      }, null);
      const _ref$6 = ref;
      typeof _ref$6 === "function" ? use(_ref$6, _el$50) : ref = _el$50;
      insert(_el$50, createComponent(For, {
        get each() {
          return Object.keys(getMainChallenge() || {});
        },
        children: getEntID => {
          var _a, _b, _c, _d;
          return createComponent(MainChallengeHpBar, {
            get entid() {
              return Number(getEntID);
            },
            get player_id() {
              return (_b = (_a = getMainChallenge()) === null || _a === void 0 ? void 0 : _a[getEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getMainChallenge()) === null || _c === void 0 ? void 0 : _c[getEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          });
        }
      }));
      return _el$50;
    })();
  }
  function MainChallengeHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$51 = createElement("Panel", {
          get id() {
            return 'MainChallengeHpBar_' + getter.entid();
          }
        }, null),
        _el$52 = createElement("Panel", {}, _el$51),
        _el$54 = createElement("Panel", {
          "class": "Detial"
        }, _el$52),
        _el$55 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$54),
        _el$56 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$52),
        _el$57 = createElement("Panel", {
          "class": "Body"
        }, _el$56),
        _el$58 = createElement("Panel", {
          id: "HpBar"
        }, _el$57),
        _el$59 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$58),
        _el$60 = createElement("Panel", {
          id: "HpFG"
        }, _el$58);
      setProp(_el$51, "className", "MainChallengeHpBar");
      setProp(_el$52, "className", "Body");
      insert(_el$52, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$54);
      insert(_el$54, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$55);
      setProp(_el$59, "className", "BufferPanel");
      setProp(_el$60, "className", "FG");
      effect(_$p => setProp(_el$51, "id", 'MainChallengeHpBar_' + getter.entid(), _$p));
      return _el$51;
    })();
  }
  function NpcAdventure() {
    let ref;
    const [getAdventure, setAdventure] = useNetEventTable(t => t, 'adventure', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getAdventure()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('AdventureHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$61 = createElement("Panel", {
        id: "NpcAdventure",
        hittest: false
      }, null);
      const _ref$7 = ref;
      typeof _ref$7 === "function" ? use(_ref$7, _el$61) : ref = _el$61;
      insert(_el$61, createComponent(For, {
        get each() {
          return Object.keys(getAdventure() || {});
        },
        children: getEntID => {
          var _a, _b, _c, _d;
          return createComponent(AdventureHpBar, {
            get entid() {
              return Number(getEntID);
            },
            get player_id() {
              return (_b = (_a = getAdventure()) === null || _a === void 0 ? void 0 : _a[getEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getAdventure()) === null || _c === void 0 ? void 0 : _c[getEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          });
        }
      }));
      return _el$61;
    })();
  }
  function AdventureHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$62 = createElement("Panel", {
          get id() {
            return 'AdventureHpBar_' + getter.entid();
          }
        }, null),
        _el$63 = createElement("Panel", {}, _el$62),
        _el$65 = createElement("Panel", {
          "class": "Detial"
        }, _el$63),
        _el$66 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$65),
        _el$67 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$63),
        _el$68 = createElement("Panel", {
          "class": "Body"
        }, _el$67),
        _el$69 = createElement("Panel", {
          id: "HpBar"
        }, _el$68),
        _el$70 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$69),
        _el$71 = createElement("Panel", {
          id: "HpFG"
        }, _el$69);
      setProp(_el$62, "className", "AdventureHpBar");
      setProp(_el$63, "className", "Body");
      insert(_el$63, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$65);
      insert(_el$65, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$66);
      setProp(_el$70, "className", "BufferPanel");
      setProp(_el$71, "className", "FG");
      effect(_$p => setProp(_el$62, "id", 'AdventureHpBar_' + getter.entid(), _$p));
      return _el$62;
    })();
  }
  function NpcArchiveChallenge() {
    let ref;
    const [getEntities, setEntities] = useNetEventTable(t => t, 'archive_challenge', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getEntities()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('HpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$72 = createElement("Panel", {
        id: "NpcArchiveChallenge",
        hittest: false
      }, null);
      const _ref$8 = ref;
      typeof _ref$8 === "function" ? use(_ref$8, _el$72) : ref = _el$72;
      insert(_el$72, createComponent(For, {
        get each() {
          return Object.keys(getEntities() || {});
        },
        children: getEntID => {
          var _a, _b, _c, _d;
          return createComponent(ArchiveChallengeHpBar, {
            get entid() {
              return Number(getEntID);
            },
            get player_id() {
              return (_b = (_a = getEntities()) === null || _a === void 0 ? void 0 : _a[getEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getEntities()) === null || _c === void 0 ? void 0 : _c[getEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          });
        }
      }));
      return _el$72;
    })();
  }
  function ArchiveChallengeHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$73 = createElement("Panel", {
          get id() {
            return 'HpBar_' + getter.entid();
          }
        }, null),
        _el$74 = createElement("Panel", {}, _el$73),
        _el$76 = createElement("Panel", {
          "class": "Detial"
        }, _el$74),
        _el$77 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$76),
        _el$78 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$74),
        _el$79 = createElement("Panel", {
          "class": "Body"
        }, _el$78),
        _el$80 = createElement("Panel", {
          id: "HpBar"
        }, _el$79),
        _el$81 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$80),
        _el$82 = createElement("Panel", {
          id: "HpFG"
        }, _el$80);
      setProp(_el$73, "className", "ArchiveChallengeHpBar");
      setProp(_el$74, "className", "Body");
      insert(_el$74, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$76);
      insert(_el$76, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$77);
      setProp(_el$81, "className", "BufferPanel");
      setProp(_el$82, "className", "FG");
      effect(_$p => setProp(_el$73, "id", 'HpBar_' + getter.entid(), _$p));
      return _el$73;
    })();
  }
  function NpcBoss() {
    let ref;
    const [getBoss, setBoss] = useNetEventTable(t => t, 'boss_entities', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getBoss()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('BossHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$92 = createElement("Panel", {
        id: "NpcBoss",
        hittest: false
      }, null);
      const _ref$0 = ref;
      typeof _ref$0 === "function" ? use(_ref$0, _el$92) : ref = _el$92;
      insert(_el$92, () => {
        var _a, _b, _c, _d;
        const t = [];
        for (const sEntID in getBoss()) {
          t.push(createComponent(BossHpBar, {
            get entid() {
              return Number(sEntID);
            },
            get player_id() {
              return (_b = (_a = getBoss()) === null || _a === void 0 ? void 0 : _a[sEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getBoss()) === null || _c === void 0 ? void 0 : _c[sEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          }));
        }
        return t;
      });
      return _el$92;
    })();
  }
  function BossHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$93 = createElement("Panel", {
          get id() {
            return 'BossHpBar_' + getter.entid();
          }
        }, null),
        _el$94 = createElement("Panel", {}, _el$93),
        _el$96 = createElement("Panel", {
          "class": "Detial"
        }, _el$94),
        _el$97 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$96),
        _el$98 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$94),
        _el$99 = createElement("Panel", {
          "class": "Body"
        }, _el$98),
        _el$100 = createElement("Panel", {
          id: "HpBar"
        }, _el$99),
        _el$101 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$100),
        _el$102 = createElement("Panel", {
          id: "HpFG"
        }, _el$100);
      setProp(_el$93, "className", "BossHpBar");
      setProp(_el$94, "className", "Body");
      insert(_el$94, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$96);
      insert(_el$96, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$97);
      setProp(_el$101, "className", "BufferPanel");
      setProp(_el$102, "className", "FG");
      effect(_$p => setProp(_el$93, "id", 'BossHpBar_' + getter.entid(), _$p));
      return _el$93;
    })();
  }
  function NpcBossTreasure() {
    let ref;
    const [getBossTreasure, setBossTreasure] = useNetEventTable(t => t, 'boss_treasure', 'entities');
    createEffect(() => {
      let fUpCD = 0;
      const i = Timer(() => {
        for (const key in getBossTreasure()) {
          const iEntID = Number(key);
          const p = ref === null || ref === void 0 ? void 0 : ref.FindChild('BossTreasureHpBar_' + iEntID);
          if (!p) continue;
          if (!UpdateOverheadPanel(p, iEntID, {
            no_health_bar: false
          })) continue;
          fUpCD -= Game.GetGameFrameTime();
          if (fUpCD > 0) continue;
          fUpCD = 0.1;
          let fPct = Entities.GetHealthPercent(iEntID);
          let pBar = p.FindChildInLayoutFile('HpBufferPanel');
          let s = `translateX(-${100 - fPct || 0}%)`;
          if (pBar) {
            pBar.style.transform = s;
          }
          pBar = p.FindChildInLayoutFile('HpFG');
          if (pBar) {
            pBar.style.transform = s;
          }
          p.SetDialogVariable('name', $.Localize(`#${Entities.GetUnitName(iEntID)}`));
        }
        return 0;
      }, 0);
      onCleanup(() => {
        StopTimer(i);
      });
    });
    return (() => {
      const _el$103 = createElement("Panel", {
        id: "NpcBossTreasure",
        hittest: false
      }, null);
      const _ref$1 = ref;
      typeof _ref$1 === "function" ? use(_ref$1, _el$103) : ref = _el$103;
      insert(_el$103, () => {
        var _a, _b, _c, _d;
        const t = [];
        for (const sEntID in getBossTreasure()) {
          t.push(createComponent(BossTreasureHpBar, {
            get entid() {
              return Number(sEntID);
            },
            get player_id() {
              return (_b = (_a = getBossTreasure()) === null || _a === void 0 ? void 0 : _a[sEntID]) === null || _b === void 0 ? void 0 : _b.player_id;
            },
            get end_time() {
              return (_d = (_c = getBossTreasure()) === null || _c === void 0 ? void 0 : _c[sEntID]) === null || _d === void 0 ? void 0 : _d.end_time;
            }
          }));
        }
        return t;
      });
      return _el$103;
    })();
  }
  function BossTreasureHpBar(props) {
    var _a, _b;
    const getter = PropsGetter(props);
    return (() => {
      const _el$104 = createElement("Panel", {
          get id() {
            return 'BossTreasureHpBar_' + getter.entid();
          }
        }, null),
        _el$105 = createElement("Panel", {}, _el$104),
        _el$107 = createElement("Panel", {
          "class": "Detial"
        }, _el$105),
        _el$108 = createElement("Label", {
          id: "NameLabel",
          text: "{s:name}",
          html: true
        }, _el$107),
        _el$109 = createElement("Panel", {
          id: "HpMpPanel"
        }, _el$105),
        _el$110 = createElement("Panel", {
          "class": "Body"
        }, _el$109),
        _el$111 = createElement("Panel", {
          id: "HpBar"
        }, _el$110),
        _el$112 = createElement("Panel", {
          id: "HpBufferPanel"
        }, _el$111),
        _el$113 = createElement("Panel", {
          id: "HpFG"
        }, _el$111);
      setProp(_el$104, "className", "BossTreasureHpBar");
      setProp(_el$105, "className", "Body");
      insert(_el$105, createComponent(Show, {
        get when() {
          return ((_a = getter.end_time) === null || _a === void 0 ? void 0 : _a.call(getter)) != undefined;
        },
        get children() {
          return createComponent(CountDown, {
            get fTimeEnd() {
              return getter.end_time;
            },
            get children() {
              return createElement("Label", {
                text: "{s:countdown_time}"
              }, null);
            }
          });
        }
      }), _el$107);
      insert(_el$107, createComponent(PlayerAvatar, {
        get iPlayerID() {
          return memo(() => !!((_b = getter.player_id) === null || _b === void 0))() ? void 0 : _b.call(getter);
        },
        hittest: false,
        hittestchildren: false
      }), _el$108);
      setProp(_el$112, "className", "BufferPanel");
      setProp(_el$113, "className", "FG");
      effect(_$p => setProp(_el$104, "id", 'BossTreasureHpBar_' + getter.entid(), _$p));
      return _el$104;
    })();
  }
  function NpcArchive() {
    let ref;
    const [getArchive] = useNetEventTable(t => t, 'common', 'npc_archive');
    createEffect(() => {
      const id = Timer(() => {
        if (getArchive() == undefined) return 0;
        if (!UpdateOverheadPanel(ref, getArchive(), {
          no_health_bar: false
        })) return 0;
        return 0;
      }, 0, 'NpcArchive');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$126 = createElement("Panel", {
          id: "NpcArchive",
          get ["class"]() {
            return classNames({
              'Show': getArchive() != undefined
            });
          },
          hittest: false
        }, null),
        _el$127 = createElement("Panel", {
          "class": "NpcArchiveBar",
          hittest: false
        }, _el$126),
        _el$128 = createElement("Panel", {
          "class": "Body"
        }, _el$127);
        createElement("Panel", {
          "class": "BG"
        }, _el$128);
        const _el$130 = createElement("Panel", {
          "class": "Body"
        }, _el$128);
        createElement("Label", {
          id: "UnitName",
          text: '#npc_archive'
        }, _el$130);
      const _ref$11 = ref;
      typeof _ref$11 === "function" ? use(_ref$11, _el$127) : ref = _el$127;
      effect(_$p => setProp(_el$126, "class", classNames({
        'Show': getArchive() != undefined
      }), _$p));
      return _el$126;
    })();
  }
  function NpcRaidChallenge() {
    let ref;
    const [getNpc] = useNetEventTable(t => t, 'raid_challenge', 'npc_entindex');
    const [getStatus] = useNetEventTable(t => t, 'raid_challenge', 'status_info');
    const getShow = () => {
      var _a;
      return getNpc() != undefined && !(((_a = getStatus()) === null || _a === void 0 ? void 0 : _a.start_time) != undefined && !getStatus().is_finished);
    };
    createEffect(() => {
      const id = Timer(() => {
        if (!getShow()) return 0;
        if (!UpdateOverheadPanel(ref, getNpc(), {
          no_health_bar: false
        })) return 0;
        return 0;
      }, 0, 'NpcRaidChallenge');
      onCleanup(() => {
        StopTimer(id);
      });
    });
    return (() => {
      const _el$132 = createElement("Panel", {
          id: "NpcRaidChallenge",
          get ["class"]() {
            return classNames({
              'Show': getShow()
            });
          },
          hittest: false
        }, null),
        _el$133 = createElement("Panel", {
          "class": "NpcRaidChallengeBar",
          hittest: false
        }, _el$132),
        _el$134 = createElement("Panel", {
          "class": "Body"
        }, _el$133);
        createElement("Panel", {
          "class": "BG"
        }, _el$134);
        const _el$136 = createElement("Panel", {
          "class": "Body"
        }, _el$134);
        createElement("Label", {
          id: "UnitName",
          text: '#npc_raid_challenge'
        }, _el$136);
      const _ref$12 = ref;
      typeof _ref$12 === "function" ? use(_ref$12, _el$133) : ref = _el$133;
      effect(_$p => setProp(_el$132, "class", classNames({
        'Show': getShow()
      }), _$p));
      return _el$132;
    })();
  }
  function NpcBoss5_6() {
    const [getTips] = useNetEventTable(t => {
      return t !== null && t !== void 0 ? t : [];
    }, 'boss_ability', 'boss_5_6');
    return (() => {
      const _el$138 = createElement("Panel", {
          id: "NpcBoss5_6",
          hittest: false
        }, null),
        _el$139 = createElement("Panel", {}, _el$138);
      setProp(_el$139, "className", "Body");
      insert(_el$139, () => getTips().map((v, i) => {
        let index = v.index;
        let bFirst = i == 0 && !v.bUse || !v.bUse && getTips()[i - 1].bUse;
        return (() => {
          const _el$140 = createElement("Panel", {}, null),
            _el$141 = createElement("Label", {
              get text() {
                return $.Localize("#boss_5_6_" + index);
              }
            }, _el$140);
          insert(_el$140, bFirst ? [createElement("DOTAParticleScenePanel", {
            hittest: false,
            squarePixels: true,
            particleonly: true,
            particleName: "particles/boss/lina/boss_4_6/wenzi.vpcf",
            cameraOrigin: "0 50 50",
            lookAt: "0 50 0",
            fov: 90
          }, null), createElement("DOTAScenePanel", {
            map: "scenes/hud/levelupburst",
            camera: "camera_1",
            particleonly: false,
            hittest: true
          }, null)] : undefined, null);
          effect(_p$ => {
            const _v$4 = classNames({
                'first': bFirst
              }, "boss_5_6_" + index, {
                'Hidden': v.bUse
              }),
              _v$5 = $.Localize("#boss_5_6_" + index);
            _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$140, "className", _v$4, _p$._v$4));
            _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$141, "text", _v$5, _p$._v$5));
            return _p$;
          }, {
            _v$4: undefined,
            _v$5: undefined
          });
          return _el$140;
        })();
      }));
      return _el$138;
    })();
  }

}));