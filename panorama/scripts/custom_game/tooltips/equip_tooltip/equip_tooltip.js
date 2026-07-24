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
  function GetTooltipParams(sTooltipName, pContext) {
    let t = GameUI.CustomUIConfig()[sTooltipName];
    if (pContext != undefined && t != undefined) {
      t['context'] = pContext;
    }
    return t;
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
  var Player_AccountToID = _Player.Player_AccountToID.bind(_Player);
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
  GameUI.CustomUIConfig().UploadError;

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

  function Clamp(num, min, max) {
    return num <= min ? min : num >= max ? max : num;
  }
  function RandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
  }
  function GetSystemConfig(sCfg) {
    var _a;
    GameUI.CustomUIConfig()['__config__'] = (_a = GameUI.CustomUIConfig()['__config__']) !== null && _a !== void 0 ? _a : {};
    if (GameUI.CustomUIConfig()['__config__'][sCfg] != undefined) return GameUI.CustomUIConfig()['__config__'][sCfg];
    return GameUI.CustomUIConfig()['__config__'][sCfg] = GameUI.CustomUIConfig().tools.runlua(`return _G['${sCfg}']`);
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

  function AttrVal2Str(attrid, val, ratio = 1) {
    var _a, _b;
    const name = (_a = ID2Attribute[attrid]) === null || _a === void 0 ? void 0 : _a.name;
    if (name == undefined) return "";
    const sPct = (_b = PctUnitAttributes[name]) !== null && _b !== void 0 ? _b : "";
    return (val > 0 ? "+" : "") + NumFixRatio(val, ratio) + sPct;
  }
  function ValRangeStr(attrid, min, max) {
    var _a, _b;
    const name = (_a = ID2Attribute[attrid]) === null || _a === void 0 ? void 0 : _a.name;
    if (name == undefined) return "";
    const sPct = (_b = PctUnitAttributes[name]) !== null && _b !== void 0 ? _b : "";
    return `( ${min}${sPct} - ${max}${sPct} )`;
  }
  function NumFixRatio(val, ratio) {
    return Math.floor(val * Math.pow(10, ratio)) / Math.pow(10, ratio);
  }
  function ValuePct(pct, min, max, ratio = 0) {
    let val = Number(min) + (Number(max) - Number(min)) * pct * 0.01;
    if (ratio > 0) {
      return NumFixRatio(val, ratio);
    }
    return val;
  }
  function ExtractIsSpecial(data) {
    return data && (data === null || data === void 0 ? void 0 : data.special) == 1;
  }

  const CfgGetter_settings_common = useSystemConfig('settings_common');

  const CfgGetter_equipment_effect = useSystemConfig('equipment_effect');

  const CfgGetter_equipment_enhance_effect = useSystemConfig('equipment_enhance_effect');

  const CfgGetter_equipment_score = useSystemConfig('equipment_score');

  var _a;
  var ScreenPanel = (_a = class extends GameUI.CustomUIConfig().tools.ScreenPanel {
    static render(code, node) {
      return render(code, node);
    }
  }, __setFunctionName(_a, "ScreenPanel"), _a.pEnvContextPanel = $.GetContextPanel(), _a);

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

  const ServGetter_UserEquipWear = useNetEventTable(t => t, 'service', () => 'UserEquipWear_' + getter_iLocalPlayer())[0];

  const ServGetter_UserEquip = useNetEventTable(t => t, 'service', () => 'UserEquip_' + getter_iLocalPlayer())[0];

  const ServGetter_UserEquipExtract = useNetEventTable(t => t, 'service', () => 'UserEquipExtract_' + getter_iLocalPlayer())[0];

  const ServGetter_UserGem = useNetEventTable(t => t, 'service', () => 'UserGem_' + getter_iLocalPlayer())[0];

  const ServGetter_UserEquipEnhance = useNetEventTable(t => t, 'service', () => 'UserEquipEnhance_' + getter_iLocalPlayer())[0];

  const ServGetter_UserGemWear = useNetEventTable(t => t, 'service', () => 'UserGemWear_' + getter_iLocalPlayer())[0];

  const ServGetter_UserAncient = useNetEventTable(t => t, 'service', () => 'UserAncient_' + getter_iLocalPlayer())[0];

  const ServGetter_UserAncientWear = useNetEventTable(t => t, 'service', () => 'UserAncientWear_' + getter_iLocalPlayer())[0];

  const ServGetter_UserHoly = useNetEventTable(t => t, 'service', () => 'UserHoly_' + getter_iLocalPlayer())[0];

  const ServGetter_UserHolyWear = useNetEventTable(t => t, 'service', () => 'UserHolyWear_' + getter_iLocalPlayer())[0];

  const ServGetter_UserUse = useNetEventTable(t => t === null || t === void 0 ? void 0 : t[Player_IDToAccount(getter_iLocalPlayer())], 'service', 'GUserUse')[0];

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
  function PackExtractItem(params) {
    var _a;
    const [local, props] = splitProps(params, ['data', 'item_id']);
    const getData = (_a = local.data) !== null && _a !== void 0 ? _a : createMemo(() => {
      var _a;
      return ((_a = ServGetter_UserEquipExtract()) === null || _a === void 0 ? void 0 : _a[local.item_id]) || {};
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
    const getImage = () => {
      var _a, _b, _c, _d;
      let s = '';
      if (ExtractIsSpecial(getData())) {
        s = 'equip_extract_6';
      } else {
        s = `equip_extract_${(_c = {
        [4]: 3,
        [3]: 4,
        [2]: 5
      }[(_b = (_a = getData().affix) === null || _a === void 0 ? void 0 : _a.filter(t => t.c < 3).length) !== null && _b !== void 0 ? _b : 0]) !== null && _c !== void 0 ? _c : 1}`;
        let special10 = false;
        (_d = getData().affix) === null || _d === void 0 ? void 0 : _d.forEach(t => {
          if (t.l >= 10) {
            special10 = true;
          }
        });
        if (special10) {
          s = 'equip_extract_7';
        }
      }
      return `file://{images}/custom_game/service/equip/equip_part/${s}.png`;
    };
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
    const getIsSpecial = createMemo(() => {
      var _a;
      return (((_a = getData()) === null || _a === void 0 ? void 0 : _a.special) || 0) > 0;
    });
    return (() => {
      const _el$11 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames("PackExtractItem", 'Rarity_' + getRarity());
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$11);
        const _el$13 = createElement("Panel", {
          "class": "Body"
        }, _el$11),
        _el$14 = createElement("Image", {
          "class": "Image",
          get src() {
            return getImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$13);
      spread(_el$11, mergeProps(props, {
        get ["class"]() {
          return classNames("PackExtractItem", 'Rarity_' + getRarity());
        },
        "onmouseover": p => {
          var _a;
          (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
          ShowTooltip(p, 'equip_tooltip', {
            type: 'Extract',
            data: getData()
          });
        },
        "onmouseout": p => {
          var _a, _b;
          (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
          HideTooltip();
          if (getIsNew()) {
            GameUI.CustomUIConfig()['Equip_ExtractTouch'] = (_b = GameUI.CustomUIConfig()['Equip_ExtractTouch']) !== null && _b !== void 0 ? _b : [];
            GameUI.CustomUIConfig()['Equip_ExtractTouch'].push(getItemID());
            Timer(() => {
              Request('Equip_ExtractTouch', {
                'ids': GameUI.CustomUIConfig()['Equip_ExtractTouch']
              });
              delete GameUI.CustomUIConfig()['Equip_ExtractTouch'];
            }, 1, "Equip_ExtractTouch");
          }
        }
      }), true);
      insert(_el$13, createComponent(Show, {
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
      insert(_el$13, createComponent(Show, {
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
      insert(_el$13, createComponent(Show, {
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
      insert(_el$13, createComponent(Show, {
        get when() {
          return getClass() != undefined;
        },
        get children() {
          const _el$15 = createElement("Panel", {
              "class": "Class"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$15);
            const _el$17 = createElement("Label", {
              "class": "ClassLabel",
              get text() {
                return ReplaceTextVariable('#EquipClass', {
                  'val': getClass()
                });
              },
              html: true
            }, _el$15);
          effect(_$p => setProp(_el$17, "text", ReplaceTextVariable('#EquipClass', {
            'val': getClass()
          }), _$p));
          return _el$15;
        }
      }), null);
      insert(_el$13, createComponent(Show, {
        get when() {
          return !getIsSpecial();
        },
        get children() {
          const _el$18 = createElement("Image", {
            "class": "Part",
            get src() {
              return `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`;
            }
          }, null);
          effect(_$p => setProp(_el$18, "src", `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`, _$p));
          return _el$18;
        }
      }), null);
      effect(_$p => setProp(_el$14, "src", getImage(), _$p));
      return _el$11;
    })();
  }
  function PackGemItem(params) {
    var _a;
    const [local, props] = splitProps(params, ['data', 'item_id', 'hide_wear_icon']);
    const getData = (_a = local.data) !== null && _a !== void 0 ? _a : createMemo(() => {
      var _a;
      return ((_a = ServGetter_UserGem()) === null || _a === void 0 ? void 0 : _a[local.item_id]) || {};
    });
    const getItemID = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.id;
    });
    const getPart = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    });
    const getRarity = createMemo(() => {
      var _a;
      return Math.min(((_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) || 1, 6);
    });
    const getWearPage = createMemo(() => {
      var _a, _b;
      if (local.hide_wear_icon) return -1;
      for (let i = 1; i <= 5; i++) {
        const t = (_b = (_a = ServGetter_UserGemWear()) === null || _a === void 0 ? void 0 : _a[i]) === null || _b === void 0 ? void 0 : _b[getPart()];
        if (t && Object.values(t).some(v => v == getItemID())) {
          return i;
        }
      }
      return -1;
    });
    const getImage = () => {
      var _a;
      return `file://{images}/custom_game/service/equip/gem_part/gem_${((_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) || 1}.png`;
    };
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
    return (() => {
      const _el$19 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames("PackGemItem", 'Rarity_' + getRarity());
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$19);
        const _el$21 = createElement("Panel", {
          "class": "Body"
        }, _el$19),
        _el$22 = createElement("Image", {
          "class": "Image",
          get src() {
            return getImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$21),
        _el$23 = createElement("Image", {
          "class": "Part",
          get src() {
            return `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`;
          }
        }, _el$21);
      spread(_el$19, mergeProps(props, {
        get ["class"]() {
          return classNames("PackGemItem", 'Rarity_' + getRarity());
        },
        "onmouseover": p => {
          var _a;
          (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
          ShowTooltip(p, 'equip_tooltip', {
            type: 'Gem',
            data: getData()
          });
        },
        "onmouseout": p => {
          var _a, _b;
          (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
          HideTooltip();
          if (getIsNew()) {
            GameUI.CustomUIConfig()['Equip_GemTouch'] = (_b = GameUI.CustomUIConfig()['Equip_GemTouch']) !== null && _b !== void 0 ? _b : [];
            GameUI.CustomUIConfig()['Equip_GemTouch'].push(getItemID());
            Timer(() => {
              Request('Equip_GemTouch', {
                'ids': GameUI.CustomUIConfig()['Equip_GemTouch']
              });
              delete GameUI.CustomUIConfig()['Equip_GemTouch'];
            }, 1, "Equip_GemTouch");
          }
        }
      }), true);
      insert(_el$21, createComponent(Show, {
        get when() {
          return getIsLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'Lock',
            type: "icon_equip_lock"
          });
        }
      }), _el$23);
      insert(_el$21, createComponent(Show, {
        get when() {
          return getIsSystemLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'SystemLock',
            type: "icon_system_lock"
          });
        }
      }), _el$23);
      insert(_el$21, createComponent(Show, {
        get when() {
          return getIsNew();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'New',
            type: "icon_new"
          });
        }
      }), _el$23);
      insert(_el$21, createComponent(Show, {
        get when() {
          return getWearPage() != -1 && !local.hide_wear_icon;
        },
        get children() {
          const _el$24 = createElement("Panel", {
              "class": "Wear",
              hittest: false
            }, null),
            _el$25 = createElement("Label", {
              "class": "WearLabel",
              get text() {
                return `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getWearPage() - 1]}`;
              }
            }, _el$24);
          insert(_el$24, createComponent(Yzy_Icon, {
            "class": "BG",
            type: "icon_equip_wear",
            hittest: false
          }), _el$25);
          effect(_$p => setProp(_el$25, "text", `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getWearPage() - 1]}`, _$p));
          return _el$24;
        }
      }), null);
      effect(_p$ => {
        const _v$ = getImage(),
          _v$2 = `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`;
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$22, "src", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$23, "src", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$19;
    })();
  }
  function PackAncientItem(params) {
    var _a;
    const [local, props] = splitProps(params, ['data', 'item_id', 'hide_wear_icon', 'compareData', 'part_level']);
    const getData = (_a = local.data) !== null && _a !== void 0 ? _a : createMemo(() => {
      var _a;
      return ((_a = ServGetter_UserAncient()) === null || _a === void 0 ? void 0 : _a[local.item_id]) || {};
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
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.class;
    });
    const getImage = () => `file://{images}/custom_game/service/equip/equip_part/ancient_${getPart()}_${getClass()}.png`;
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
    const getPartEnhanceLevel = () => {
      var _a, _b;
      return ((_b = (_a = ServGetter_UserEquipEnhance()) === null || _a === void 0 ? void 0 : _a[`1${getPart()}01`]) === null || _b === void 0 ? void 0 : _b.enhance) || 0;
    };
    const getJuniorCount = createMemo(() => {
      var _a, _b, _c;
      return Math.max(((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.junior_max) !== null && _b !== void 0 ? _b : 0) - ((_c = getData().junior) !== null && _c !== void 0 ? _c : 0), 0);
    });
    const getSeniorCount = createMemo(() => {
      var _a, _b, _c;
      return Math.max(((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.senior_max) !== null && _b !== void 0 ? _b : 0) - ((_c = getData().senior) !== null && _c !== void 0 ? _c : 0), 0);
    });
    const [getHasWear, setHasWear] = createSignal(false);
    const [getOwnerPage, setOwnerPage] = createSignal(-1);
    if (!props.no_local) {
      createEffect(() => {
        const t = ServGetter_UserAncientWear();
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
      const _el$26 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames("PackAncientItem", 'Rarity_' + getRarity());
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$26);
        const _el$28 = createElement("Panel", {
          "class": "Body"
        }, _el$26),
        _el$29 = createElement("Image", {
          "class": "Image",
          get src() {
            return getImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$28);
      spread(_el$26, mergeProps(props, {
        get ["class"]() {
          return classNames("PackAncientItem", 'Rarity_' + getRarity());
        },
        "onmouseover": p => {
          var _a;
          (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
          ShowTooltip(p, 'equip_tooltip', {
            type: 'Ancient',
            data: getData(),
            compareData: local.compareData,
            part_level: () => {
              var _a;
              return ((_a = local.data) === null || _a === void 0 ? void 0 : _a.call(local)['part_level']) || getPartEnhanceLevel();
            }
          });
        },
        "onmouseout": p => {
          var _a, _b;
          (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
          HideTooltip();
          if (getIsNew()) {
            GameUI.CustomUIConfig()['Ancient_Touch'] = (_b = GameUI.CustomUIConfig()['Ancient_Touch']) !== null && _b !== void 0 ? _b : [];
            GameUI.CustomUIConfig()['Ancient_Touch'].push(getItemID());
            Timer(() => {
              Request('Equip_AncientTouch', {
                'ids': GameUI.CustomUIConfig()['Ancient_Touch']
              });
              delete GameUI.CustomUIConfig()['Ancient_Touch'];
            }, 1, "PackAncientItem_Touch");
          }
        }
      }), true);
      insert(_el$28, createComponent(Show, {
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
      insert(_el$28, createComponent(Show, {
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
      insert(_el$28, createComponent(Show, {
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
      insert(_el$28, createComponent(Show, {
        get when() {
          return getJuniorCount() > 0;
        },
        get children() {
          const _el$30 = createElement("Panel", {
              "class": "AncientJunior"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$30);
            const _el$32 = createElement("Label", {
              "class": "AncientLabel",
              get text() {
                return getJuniorCount();
              },
              html: true
            }, _el$30);
          effect(_$p => setProp(_el$32, "text", getJuniorCount(), _$p));
          return _el$30;
        }
      }), null);
      insert(_el$28, createComponent(Show, {
        get when() {
          return getSeniorCount() > 0;
        },
        get children() {
          const _el$33 = createElement("Panel", {
              "class": "AncientSenior"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$33);
            const _el$35 = createElement("Label", {
              "class": "AncientLabel",
              get text() {
                return getSeniorCount();
              },
              html: true
            }, _el$33);
          effect(_$p => setProp(_el$35, "text", getSeniorCount(), _$p));
          return _el$33;
        }
      }), null);
      insert(_el$28, createComponent(Show, {
        get when() {
          return getHasWear();
        },
        get children() {
          return [(() => {
            const _el$36 = createElement("Panel", {
                "class": "PartEnhance"
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$36);
              const _el$38 = createElement("Label", {
                "class": "PartEnhanceLabel",
                get text() {
                  return '+' + getPartEnhanceLevel();
                }
              }, _el$36);
            effect(_$p => setProp(_el$38, "text", '+' + getPartEnhanceLevel(), _$p));
            return _el$36;
          })(), (() => {
            const _el$39 = createElement("Panel", {
                "class": "Wear",
                hittest: false
              }, null),
              _el$40 = createElement("Label", {
                "class": "WearLabel",
                get text() {
                  return `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`;
                }
              }, _el$39);
            insert(_el$39, createComponent(Yzy_Icon, {
              "class": "BG",
              type: "icon_equip_wear",
              hittest: false
            }), _el$40);
            effect(_$p => setProp(_el$40, "text", `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`, _$p));
            return _el$39;
          })()];
        }
      }), null);
      effect(_$p => setProp(_el$29, "src", getImage(), _$p));
      return _el$26;
    })();
  }
  function PackHolyItem(params) {
    var _a;
    const [local, props] = splitProps(params, ['data', 'item_id', 'hide_wear_icon', 'compareData']);
    const getData = (_a = local.data) !== null && _a !== void 0 ? _a : createMemo(() => {
      var _a;
      return ((_a = ServGetter_UserHoly()) === null || _a === void 0 ? void 0 : _a[local.item_id]) || {};
    });
    const getItemID = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.id;
    });
    const getPart = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    });
    createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.class;
    });
    const getStrength = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.strength;
    });
    const getIsTrans = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.trans_lock) !== null && _b !== void 0 ? _b : false;
    });
    const getRarity = createMemo(() => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity;
    });
    const getImage = () => `file://{images}/custom_game/service/equip/equip_part/holy_${getPart()}_${getRarity()}.png`;
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
    if (!props.no_local) {
      createEffect(() => {
        const t = ServGetter_UserHolyWear();
        const data = getData();
        let bHasWear = false;
        let iOwnerPage = -1;
        if (t) {
          for (const sSlot in t) {
            if (data.id == t[sSlot]) {
              bHasWear = true;
              iOwnerPage = Number(sSlot.substring(1, 3));
              break;
            }
          }
        }
        setHasWear(bHasWear);
        setOwnerPage(iOwnerPage);
      });
    }
    const getHasTaigu = createMemo(() => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) === null || _b === void 0 ? void 0 : _b.some(affix => affix.taigu);
    });
    const getWearSuit = createMemo(() => {
      var _a, _b;
      const iUsePage = ((_a = ServGetter_UserUse()) === null || _a === void 0 ? void 0 : _a.holy) || 1;
      const t = ServGetter_UserHolyWear();
      const tSuitData = {};
      if (t) {
        for (const sSlot in t) {
          if (Number(sSlot.substring(1, 3)) == iUsePage) {
            const sId = t[sSlot];
            if (sId) {
              const tHoly = (_b = ServGetter_UserHoly()) === null || _b === void 0 ? void 0 : _b[sId];
              if (tHoly && tHoly.suit) {
                tSuitData[tHoly.suit] = (tSuitData[tHoly.suit] || 0) + 1;
              }
            }
          }
        }
      }
      return tSuitData;
    });
    return (() => {
      const _el$41 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames("PackHolyItem", 'Rarity_' + getRarity());
          }
        }), null);
        createElement("Panel", {
          "class": "BG"
        }, _el$41);
        const _el$43 = createElement("Panel", {
          "class": "Body"
        }, _el$41),
        _el$44 = createElement("Image", {
          "class": "Image",
          get src() {
            return getImage();
          },
          scaling: "stretch-to-fit-x-preserve-aspect",
          hittest: false
        }, _el$43),
        _el$50 = createElement("Image", {
          "class": "Part",
          get src() {
            return `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`;
          }
        }, _el$43);
      spread(_el$41, mergeProps(props, {
        get ["class"]() {
          return classNames("PackHolyItem", 'Rarity_' + getRarity());
        },
        "onmouseover": p => {
          var _a;
          (_a = props.onmouseover) === null || _a === void 0 ? void 0 : _a.call(props, p);
          if (props.noTooltip) return;
          ShowTooltip(p, 'equip_tooltip', {
            type: 'Holy',
            data: getData(),
            compareData: local.compareData,
            wear_suit: getWearSuit
          });
        },
        "onmouseout": p => {
          var _a, _b;
          (_a = props.onmouseout) === null || _a === void 0 ? void 0 : _a.call(props, p);
          HideTooltip();
          if (getIsNew()) {
            GameUI.CustomUIConfig()['Holy_Touch'] = (_b = GameUI.CustomUIConfig()['Holy_Touch']) !== null && _b !== void 0 ? _b : [];
            GameUI.CustomUIConfig()['Holy_Touch'].push(getItemID());
            Timer(() => {
              Request('Equip_HolyTouch', {
                'ids': GameUI.CustomUIConfig()['Holy_Touch']
              });
              delete GameUI.CustomUIConfig()['Holy_Touch'];
            }, 1, "PackHolyItem_Touch");
          }
        }
      }), true);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getIsLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'Lock',
            type: "icon_equip_lock"
          });
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getIsSystemLock();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'SystemLock',
            type: "icon_system_lock"
          });
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getIsNew();
        },
        get children() {
          return createComponent(Yzy_Icon, {
            "class": 'New',
            type: "icon_new"
          });
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getHasTaigu();
        },
        get children() {
          return createElement("Panel", {
            "class": "Taigu"
          }, null);
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getIsTrans();
        },
        get children() {
          return createElement("Panel", {
            "class": "Trans"
          }, null);
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getStrength() != undefined;
        },
        get children() {
          const _el$47 = createElement("Panel", {
              "class": "Class"
            }, null);
            createElement("Panel", {
              "class": "BG"
            }, _el$47);
            const _el$49 = createElement("Label", {
              "class": "ClassLabel",
              get text() {
                return '+' + getStrength();
              },
              html: true
            }, _el$47);
          effect(_$p => setProp(_el$49, "text", '+' + getStrength(), _$p));
          return _el$47;
        }
      }), _el$50);
      insert(_el$43, createComponent(Show, {
        get when() {
          return getHasWear() && !local.hide_wear_icon;
        },
        get children() {
          const _el$51 = createElement("Panel", {
              "class": "Wear",
              hittest: false
            }, null),
            _el$52 = createElement("Label", {
              "class": "WearLabel",
              get text() {
                return `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`;
              }
            }, _el$51);
          insert(_el$51, createComponent(Yzy_Icon, {
            "class": "BG",
            type: "icon_equip_wear",
            hittest: false
          }), _el$52);
          effect(_$p => setProp(_el$52, "text", `${$.Localize("#ServiceEquipHasWear")}${["Ⅰ", "Ⅱ", "Ⅲ", "Ⅳ", "Ⅴ"][getOwnerPage() - 1]}`, _$p));
          return _el$51;
        }
      }), null);
      effect(_p$ => {
        const _v$3 = getImage(),
          _v$4 = `file://{images}/custom_game/service/equip/equip_part/equip_part_icon/${getPart()}_1.png`;
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$44, "src", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$50, "src", _v$4, _p$._v$4));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined
      });
      return _el$41;
    })();
  }

  const getter_bDebugMode = useNetEventTable(t => t === null || t === void 0 ? void 0 : t.enable, 'debug', () => 'player_' + getter_iLocalPlayer())[0];

  const getter_bAltDown = useAltDown();

  const CfgGetter_gem_effect = useSystemConfig('gem_effect');

  const CfgGetter_ancient_effect = useSystemConfig('ancient_effect');

  const CfgGetter_ancient_level_effect = useSystemConfig('ancient_level_effect');

  const CfgGetter_ancient_score = useSystemConfig('ancient_score');

  const ServGetter_UserItem = useNetEventTable(t => t, 'service', () => 'UserItem_' + getter_iLocalPlayer())[0];

  const CfgGetter_holy_effect_part1_class = useSystemConfig('holy_effect_part1_class');

  const CfgGetter_holy_effect_trans_fixed = useSystemConfig('holy_effect_trans_fixed');

  const CfgGetter_holy_effect = useSystemConfig('holy_effect');
  const tDefaultHolyEffect = {
    value_down: 0,
    value_up: 0,
    ratio: 0
  };
  function GetHolyAffixEffect(iClass, affix) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m;
    const iAffixId = affix.a;
    if (affix.c == 1) {
      return (_c = (_b = (_a = CfgGetter_holy_effect_part1_class()) === null || _a === void 0 ? void 0 : _a[iClass]) === null || _b === void 0 ? void 0 : _b[iAffixId]) !== null && _c !== void 0 ? _c : tDefaultHolyEffect;
    }
    if ((_d = affix.trans) === null || _d === void 0 ? void 0 : _d.includes(3)) {
      return (_j = (_f = (_e = CfgGetter_holy_effect_trans_fixed()) === null || _e === void 0 ? void 0 : _e[iAffixId]) !== null && _f !== void 0 ? _f : (_h = (_g = CfgGetter_holy_effect()) === null || _g === void 0 ? void 0 : _g[iClass]) === null || _h === void 0 ? void 0 : _h[iAffixId]) !== null && _j !== void 0 ? _j : tDefaultHolyEffect;
    }
    return (_m = (_l = (_k = CfgGetter_holy_effect()) === null || _k === void 0 ? void 0 : _k[iClass]) === null || _l === void 0 ? void 0 : _l[iAffixId]) !== null && _m !== void 0 ? _m : tDefaultHolyEffect;
  }
  function GetHolyAffixBaseVal(affix, iClass, iTaiguPct) {
    const effect = GetHolyAffixEffect(iClass, affix);
    if (affix.taigu) {
      return effect.value_up * (1 + iTaiguPct * 0.01);
    }
    return ValuePct(affix.v, effect.value_down, effect.value_up, effect.ratio);
  }

  const CfgGetter_holy_settings = useSystemConfig('holy_settings');
  function GetHolySetting(iRarity, iClass) {
    var _a;
    if (iRarity == undefined || iClass == undefined) return undefined;
    const tByClass = (_a = CfgGetter_holy_settings()) === null || _a === void 0 ? void 0 : _a[iRarity];
    if (!tByClass) return undefined;
    const iCls = Number(iClass);
    for (const [sRange, tSetting] of Object.entries(tByClass)) {
      const [iMin, iMax] = String(sRange).split('|').map(Number);
      if (iCls >= iMin && iCls < iMax) return tSetting;
    }
    return undefined;
  }

  const CfgGetter_holy_suit = useSystemConfig('holy_suit');

  const CfgGetter_holy_score = useSystemConfig('holy_score');

  function EquipTooltip(props) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j;
    return (() => {
      const _el$ = createElement("Panel", {
        "class": "EquipTooltip",
        hittest: false
      }, null);
      insert(_el$, createComponent(Show, {
        get when() {
          return props.type == 'Equip';
        },
        get children() {
          return [createComponent(Show, {
            get when() {
              return memo(() => !!((_a = props.compareData) === null || _a === void 0))() ? void 0 : _a.call(props);
            },
            get children() {
              const _el$2 = createElement("Panel", {
                "class": "EquipInfoTooltipCompareContent"
              }, null);
              insert(_el$2, createComponent(EquipInfoTooltip, mergeProps(props, {
                get data() {
                  return memo(() => !!((_b = props.compareData) === null || _b === void 0))() ? void 0 : _b.call(props);
                }
              })), null);
              insert(_el$2, createComponent(EquipTooltipCompare, {
                get left() {
                  return memo(() => !!((_c = props.compareData) === null || _c === void 0))() ? void 0 : _c.call(props);
                },
                get right() {
                  return props.data;
                },
                get part_level() {
                  return props.part_level;
                }
              }), null);
              return _el$2;
            }
          }), createComponent(EquipInfoTooltip, props)];
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return props.type == 'Extract';
        },
        get children() {
          return createComponent(ExtractInfoTooltip, props);
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return props.type == 'Gem';
        },
        get children() {
          return createComponent(GemInfoTooltip, props);
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return props.type == 'Ancient';
        },
        get children() {
          return [createComponent(Show, {
            get when() {
              return memo(() => !!((_d = props.compareData) === null || _d === void 0))() ? void 0 : _d.call(props);
            },
            get children() {
              const _el$3 = createElement("Panel", {
                "class": "AncientTooltipCompareContent"
              }, null);
              insert(_el$3, createComponent(AncientInfoTooltip, mergeProps(props, {
                get data() {
                  return memo(() => !!((_e = props.compareData) === null || _e === void 0))() ? void 0 : _e.call(props);
                }
              })), null);
              insert(_el$3, createComponent(AncientTooltipCompare, {
                get left() {
                  return memo(() => !!((_f = props.compareData) === null || _f === void 0))() ? void 0 : _f.call(props);
                },
                get right() {
                  return props.data;
                },
                get part_level() {
                  return props.part_level;
                }
              }), null);
              return _el$3;
            }
          }), createComponent(AncientInfoTooltip, props)];
        }
      }), null);
      insert(_el$, createComponent(Show, {
        get when() {
          return props.type == 'Holy';
        },
        get children() {
          return [createComponent(Show, {
            get when() {
              return memo(() => !!((_g = props.compareData) === null || _g === void 0))() ? void 0 : _g.call(props);
            },
            get children() {
              const _el$4 = createElement("Panel", {
                "class": "HolyTooltipCompareContent"
              }, null);
              insert(_el$4, createComponent(HolyInfoTooltip, mergeProps(props, {
                get data() {
                  return memo(() => !!((_h = props.compareData) === null || _h === void 0))() ? void 0 : _h.call(props);
                },
                get wear_suit() {
                  return props.wear_suit;
                }
              })), null);
              insert(_el$4, createComponent(HolyTooltipCompare, {
                get left() {
                  return memo(() => !!((_j = props.compareData) === null || _j === void 0))() ? void 0 : _j.call(props);
                },
                get right() {
                  return props.data;
                }
              }), null);
              return _el$4;
            }
          }), createComponent(HolyInfoTooltip, mergeProps(props, {
            get data() {
              return props.data;
            },
            get wear_suit() {
              return props.wear_suit;
            }
          }))];
        }
      }), null);
      return _el$;
    })();
  }
  function EquipInfoTooltip(props) {
    var _a;
    const getPartLevel = () => {
      var _a, _b, _c;
      return ((_c = (_a = ServGetter_UserEquipEnhance()) === null || _a === void 0 ? void 0 : _a[`1${((_b = props.data) === null || _b === void 0 ? void 0 : _b.part) || 99}01`]) === null || _c === void 0 ? void 0 : _c.enhance) || 0;
    };
    props.part_level = (_a = props.part_level) !== null && _a !== void 0 ? _a : getPartLevel;
    return (() => {
      const _el$5 = createElement("Panel", {
        id: "EquipInfoTooltip",
        hittest: false
      }, null);
      insert(_el$5, createComponent(EquipTooltipHeader, props), null);
      insert(_el$5, createComponent(EquipTooltipAffix, props), null);
      return _el$5;
    })();
  }
  function EquipTooltipHeader(props) {
    const getData = () => props.data;
    const getPart = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    };
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) !== null && _b !== void 0 ? _b : 1;
    };
    const getClass = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.class) !== null && _b !== void 0 ? _b : 1;
    };
    const getScore = () => {
      var _a, _b;
      if (((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.score) !== null && _b !== void 0 ? _b : 0) > 0) {
        if (getter_bDebugMode()) {
          return `${getData().score}(UI=${CalcEquipScore(getData())})`;
        } else {
          return getData().score;
        }
      }
      return CalcEquipScore(getData());
    };
    return (() => {
      const _el$6 = createElement("Panel", {
          id: "EquipTooltipHeader",
          get ["class"]() {
            return classNames('TooltipHeader', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$7 = createElement("Panel", {
          "class": "BGPanel"
        }, _el$6);
        createElement("Panel", {
          "class": "BG2"
        }, _el$7);
        const _el$9 = createElement("Panel", {
          "class": "Image"
        }, _el$6),
        _el$0 = createElement("Panel", {
          "class": "Line"
        }, _el$6),
        _el$1 = createElement("Panel", {
          "class": "Score"
        }, _el$6),
        _el$10 = createElement("Label", {
          get text() {
            return getScore();
          }
        }, _el$1);
      insert(_el$9, createComponent(PackEquipItem, {
        data: getData
      }));
      insert(_el$6, createComponent(Yzy_Label, {
        "class": "Name",
        get rarity() {
          return getRarity();
        },
        get text() {
          return `#EquipInfoTitle_${getPart()}_${getClass()}`;
        }
      }), _el$0);
      insert(_el$1, createComponent(Yzy_Icon, {
        type: "icon_score"
      }), _el$10);
      effect(_p$ => {
        const _v$ = classNames('TooltipHeader', `Rarity_${getRarity()}`),
          _v$2 = getScore();
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$6, "class", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$10, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$6;
    })();
  }
  function EquipTooltipAffix(props) {
    let ref;
    const getData = () => props.data;
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) !== null && _b !== void 0 ? _b : 1;
    };
    const getAffix = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) || [];
    };
    const getAffixGroup = createMemo(() => {
      const tAffixGroup = {};
      for (const affix of getAffix()) {
        if (affix.c < 3) {
          if (tAffixGroup[affix.c] == undefined) {
            tAffixGroup[affix.c] = [];
          }
          tAffixGroup[affix.c].push(affix);
        }
      }
      return tAffixGroup;
    });
    const getRsnc = createMemo(() => {
      var _a;
      const tAffix = [];
      if ((_a = props.data) === null || _a === void 0 ? void 0 : _a.affix) {
        for (const affix of props.data.affix) {
          if (affix.c == 3) {
            tAffix.push(affix);
          }
        }
      }
      return tAffix;
    });
    const [getTitleShow, setTitleShow] = createSignal(getRsnc().length > 0);
    if (props.operate_state != undefined) {
      createEffect(() => {
        var _a, _b;
        if (((_a = props.operate_type) === null || _a === void 0 ? void 0 : _a.call(props)) == 'Extract') {
          createEffect(on(props.extract_result, () => {
            var _a;
            const tResult = (_a = props.extract_result) === null || _a === void 0 ? void 0 : _a.call(props);
            if (!!tResult) {
              const tActions = [];
              const tNeedRemove = props.data.affix.filter(t => {
                var _a;
                return !(t.c > 2) && !((_a = tResult.data_idx_map) !== null && _a !== void 0 ? _a : {})[t.idx];
              });
              while (tNeedRemove.length > 0) {
                const i = RandomInt(0, tNeedRemove.length - 1);
                const iAffixIndex = tNeedRemove[i].idx;
                tNeedRemove.splice(i, 1);
                tActions.push(() => {
                  var _a;
                  if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                    const pAffix = (_a = ref.FindChildrenWithClassTraverse(`EquipTooltipAffixRow_${iAffixIndex}`)) === null || _a === void 0 ? void 0 : _a[0];
                    if (pAffix) {
                      Timer(() => {
                        if (pAffix.IsValid()) {
                          pAffix.AddClass('Removed');
                          Game.EmitSound('EquipMix_AffixRemove');
                        }
                      }, 0.2, undefined, 'equip_info_tooltip2');
                      ScreenPanel.CreateOnPanel({
                        'pTarget': pAffix,
                        'content': () => (() => {
                          const _el$11 = createElement("DOTAParticleScenePanel", {
                            id: "Equip_SlashFX",
                            hittest: false,
                            get style() {
                              return {
                                'transform': (() => {
                                  if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                                })()
                              };
                            },
                            particleName: "particles/ui/events/discount_slash_counter_slash.vpcf",
                            squarePixels: true,
                            particleonly: true,
                            startActive: true,
                            cameraOrigin: "0 500 30",
                            lookAt: "0 0 30",
                            fov: "40"
                          }, null);
                          effect(_$p => setProp(_el$11, "style", {
                            'transform': (() => {
                              if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                            })()
                          }, _$p));
                          return _el$11;
                        })(),
                        'fDuration': 1.5
                      });
                    }
                  }
                });
              }
              for (const key in tResult.data_idx_map) {
                const iAffixIndex = Number(key);
                const iInsetIndex = RandomInt(Clamp(tActions.length - 3, 1, tActions.length), tActions.length);
                tActions.splice(iInsetIndex, 0, () => {
                  var _a;
                  if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                    const pAffix = (_a = ref.FindChildrenWithClassTraverse(`EquipTooltipAffixRow_${iAffixIndex}`)) === null || _a === void 0 ? void 0 : _a[0];
                    if (pAffix) {
                      Timer(() => {
                        if (pAffix.IsValid()) {
                          pAffix.AddClass('ExtractSelected');
                        }
                      }, 0.15, undefined, 'equip_info_tooltip3');
                      Game.EmitSound('EquipMix_AffixReplace');
                      ScreenPanel.CreateOnPanel({
                        'pTarget': pAffix,
                        'content': () => createElement("DOTAParticleScenePanel", {
                          "class": "Equip_AffixFlashFX",
                          hittest: false,
                          particleonly: true,
                          particleName: "particles/ui/strip_flash.vpcf",
                          cameraOrigin: "0 0 300",
                          lookAt: "0 0 0",
                          fov: 60
                        }, null),
                        'fDuration': 1.5
                      });
                    }
                  }
                });
              }
              tActions.push(() => {
                var _a;
                (_a = props.extract_result_show) === null || _a === void 0 ? void 0 : _a.call(props);
              });
              const id = Timer(() => {
                for (const func of tActions) {
                  func();
                }
              }, 0, undefined, 'equip_info_tooltip4');
              onCleanup(() => {
                StopTimer(id);
              });
            }
          }));
        } else if (((_b = props.operate_type) === null || _b === void 0 ? void 0 : _b.call(props)) == 'Insert') {
          createEffect(on(props.insert_result, () => {
            var _a;
            const tResult = props.insert_result();
            if (!!tResult) {
              const tActions = [];
              setTitleShow(true);
              if ((_a = tResult.process) === null || _a === void 0 ? void 0 : _a.is_special) {
                if (getRsnc().length > 0) {
                  tActions.push(() => {
                    for (const t of getRsnc()) {
                      const pAffix = ref.FindChildTraverse(`EquipTooltipRsncRow_${t.idx}`);
                      if (pAffix) {
                        if (props.operate_state() == 10) {
                          pAffix.AddClass('Removed');
                        } else {
                          Timer(() => {
                            if (pAffix.IsValid()) {
                              pAffix.AddClass('Removed');
                              Game.EmitSound('EquipMix_AffixRemove');
                            }
                          }, 0.2, undefined, 'equip_info_tooltip8');
                          ScreenPanel.CreateOnPanel({
                            'pTarget': pAffix,
                            'content': () => (() => {
                              const _el$13 = createElement("DOTAParticleScenePanel", {
                                id: "Equip_SlashFX",
                                hittest: false,
                                get style() {
                                  return {
                                    'transform': (() => {
                                      if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                                    })()
                                  };
                                },
                                particleName: "particles/ui/events/discount_slash_counter_slash.vpcf",
                                squarePixels: true,
                                particleonly: true,
                                startActive: true,
                                cameraOrigin: "0 500 30",
                                lookAt: "0 0 30",
                                fov: "40"
                              }, null);
                              effect(_$p => setProp(_el$13, "style", {
                                'transform': (() => {
                                  if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                                })()
                              }, _$p));
                              return _el$13;
                            })(),
                            'fDuration': 1.5
                          });
                        }
                      }
                    }
                    return 0.4666;
                  });
                }
                tActions.push(() => {
                  var _a, _b;
                  const pList = (_b = (_a = ref.FindChildTraverse('Part3')) === null || _a === void 0 ? void 0 : _a.FindChildrenWithClassTraverse('Body')) === null || _b === void 0 ? void 0 : _b[0];
                  if (pList) {
                    const tAffix = props.insert_extract().affix[0];
                    const pAffix = $.CreatePanel('Panel', pList, 'EquipInsertRsncBody', {});
                    render(() => createComponent(EquipTooltipRsncRow, {
                      affix: tAffix,
                      onload: p => {
                        Game.EmitSound('EquipMix_AffixReplace');
                        ScreenPanel.CreateOnPanel({
                          'pTarget': p,
                          'content': () => createElement("DOTAParticleScenePanel", {
                            "class": "Equip_AffixFlashFX",
                            hittest: false,
                            particleonly: true,
                            particleName: "particles/ui/strip_flash.vpcf",
                            cameraOrigin: "0 0 300",
                            lookAt: "0 0 0",
                            fov: 60
                          }, null),
                          'fDuration': 1.5
                        });
                      }
                    }), pAffix);
                  }
                });
                tActions.push(() => {
                  var _a;
                  (_a = props.extract_result_show) === null || _a === void 0 ? void 0 : _a.call(props);
                });
                tActions.reverse();
                const id = Timer(() => {
                  const fDelay = tActions.pop()();
                  if (tActions.length > 0) return fDelay !== null && fDelay !== void 0 ? fDelay : 0;
                }, 0, undefined, 'equip_info_tooltip9');
                onCleanup(() => {
                  StopTimer(id);
                });
              } else {
                tActions.push(() => {
                  var _a;
                  for (const key in tResult.process.idx_map) {
                    const iAffixIndex = tResult.process.idx_map[key];
                    if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                      const pAffix = (_a = ref.FindChildrenWithClassTraverse(`EquipTooltipAffixRow_${iAffixIndex}`)) === null || _a === void 0 ? void 0 : _a[0];
                      if (pAffix) {
                        if (props.operate_state() == 10) {
                          pAffix.AddClass('Removed');
                        } else {
                          Timer(() => {
                            if (pAffix.IsValid()) {
                              pAffix.AddClass('Removed');
                              Game.EmitSound('EquipMix_AffixRemove');
                            }
                          }, 0.2, undefined, 'equip_info_tooltip10');
                          ScreenPanel.CreateOnPanel({
                            'pTarget': pAffix,
                            'content': () => (() => {
                              const _el$15 = createElement("DOTAParticleScenePanel", {
                                id: "Equip_SlashFX",
                                hittest: false,
                                get style() {
                                  return {
                                    'transform': (() => {
                                      if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                                    })()
                                  };
                                },
                                particleName: "particles/ui/events/discount_slash_counter_slash.vpcf",
                                squarePixels: true,
                                particleonly: true,
                                startActive: true,
                                cameraOrigin: "0 500 30",
                                lookAt: "0 0 30",
                                fov: "40"
                              }, null);
                              effect(_$p => setProp(_el$15, "style", {
                                'transform': (() => {
                                  if (RandomInt(0, 1) == 1) return `translateX(20px) translateY(15px) rotateZ(${RandomInt(6, 18)}deg)`;else return `translateX(-20px) translateY(15px) rotateZ(${RandomInt(186, 198)}deg)`;
                                })()
                              }, _$p));
                              return _el$15;
                            })(),
                            'fDuration': 1.5
                          });
                        }
                      }
                    }
                  }
                  return 0.4666;
                });
                tActions.push(() => {
                  var _a;
                  for (const key in tResult.process.idx_map) {
                    const iAffixIndexExtract = Number(key);
                    const iAffixIndex = tResult.process.idx_map[key];
                    if (ref === null || ref === void 0 ? void 0 : ref.IsValid()) {
                      const pAffix = (_a = ref.FindChildrenWithClassTraverse(`EquipTooltipAffixRow_${iAffixIndex}`)) === null || _a === void 0 ? void 0 : _a[0];
                      if (pAffix) {
                        Timer(() => {
                          if (pAffix.IsValid()) {
                            pAffix.AddClass('ExtractInsertReplaced');
                            const pInsertAffix = pAffix.FindChildTraverse('ExtractInsertAffix');
                            if (pInsertAffix) {
                              const tAffix = props.insert_extract().affix.find(t => t.idx == iAffixIndexExtract);
                              if (tAffix) {
                                render(() => createComponent(EquipTooltipAffixRowBase, {
                                  affix: tAffix,
                                  inset_parent: pInsertAffix
                                }), pInsertAffix);
                              }
                            }
                          }
                        }, 0.15, undefined, 'equip_info_tooltip11');
                        if (props.operate_state() == 10) ; else {
                          Game.EmitSound('EquipMix_AffixReplace');
                          ScreenPanel.CreateOnPanel({
                            'pTarget': pAffix,
                            'content': () => createElement("DOTAParticleScenePanel", {
                              "class": "Equip_AffixFlashFX",
                              hittest: false,
                              particleonly: true,
                              particleName: "particles/ui/strip_flash.vpcf",
                              cameraOrigin: "0 0 300",
                              lookAt: "0 0 0",
                              fov: 60
                            }, null),
                            'fDuration': 1.5
                          });
                        }
                      }
                    }
                  }
                });
                tActions.push(() => {
                  var _a;
                  (_a = props.extract_result_show) === null || _a === void 0 ? void 0 : _a.call(props);
                });
                tActions.reverse();
                const id = Timer(() => {
                  const fDelay = tActions.pop()();
                  if (tActions.length > 0) return fDelay !== null && fDelay !== void 0 ? fDelay : 0.1;
                }, 0, 'equip_info_tooltip12');
                onCleanup(() => {
                  StopTimer(id);
                });
              }
            }
          }));
        }
      });
    }
    return (() => {
      const _el$17 = createElement("Panel", {
          id: "EquipTooltipAffix",
          get ["class"]() {
            return classNames('TooltipAffix', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$18 = createElement("Panel", {
          id: "Part3",
          "class": "AffixGroup"
        }, _el$17);
      const _ref$ = ref;
      typeof _ref$ === "function" ? use(_ref$, _el$17) : ref = _el$17;
      insert(_el$17, createComponent(Index, {
        get each() {
          return Object.entries(getAffixGroup());
        },
        children: (getValue, i) => {
          const getAffixType = () => getValue()[0];
          const getAffix = () => getValue()[1];
          return (() => {
            const _el$24 = createElement("Panel", {
                get id() {
                  return 'Part_' + getAffixType();
                },
                "class": "AffixGroup"
              }, null),
              _el$25 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, _el$24);
              createElement("Panel", {
                "class": "BG"
              }, _el$25);
              createElement("Panel", {
                "class": "Line"
              }, _el$25);
              const _el$28 = createElement("Label", {
                get text() {
                  return `#AffixTitle_${getAffixType()}`;
                },
                hittest: false
              }, _el$25),
              _el$29 = createElement("Panel", {
                "class": "Body"
              }, _el$24);
            insert(_el$29, createComponent(Index, {
              get each() {
                return getAffix().sort((a, b) => b.l - a.l);
              },
              children: (getAffix, i) => {
                var _a, _b, _c, _d, _e, _f;
                return createComponent(EquipTooltipAffixRow, {
                  get part_level() {
                    return props.part_level;
                  },
                  get prvg96() {
                    return props.prvg96;
                  },
                  get affix() {
                    return getAffix();
                  },
                  get operate_state() {
                    return props.operate_state;
                  },
                  get extract_lock_count() {
                    return props.extract_lock_count;
                  },
                  get extract_lock_idx() {
                    return props.extract_lock_idx;
                  },
                  get insert_lock_idx() {
                    return props.insert_lock_idx;
                  },
                  get className() {
                    return classNames({
                      'ExtractWaitRequest': ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 1,
                      'ExtractResultAnmt': ((_d = (_c = props.operate_state) === null || _c === void 0 ? void 0 : _c.call(props)) !== null && _d !== void 0 ? _d : 0) > 1 && ((_f = (_e = props.operate_state) === null || _e === void 0 ? void 0 : _e.call(props)) !== null && _f !== void 0 ? _f : 0) < 10
                    });
                  },
                  onload: p => {
                    if (props.extract_spawned_affix_show && p.BCanSeeInParentScroll()) {
                      Game.EmitSound('EquipMix_AffixReplace');
                      ScreenPanel.CreateOnPanel({
                        'pTarget': p,
                        'content': () => createElement("DOTAParticleScenePanel", {
                          "class": "Equip_AffixFlashFX",
                          hittest: false,
                          particleonly: true,
                          particleName: "particles/ui/strip_flash.vpcf",
                          cameraOrigin: "0 0 300",
                          lookAt: "0 0 0",
                          fov: 60
                        }, null),
                        'fDuration': 1.5
                      });
                    }
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$3 = 'Part_' + getAffixType(),
                _v$4 = `#AffixTitle_${getAffixType()}`;
              _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$24, "id", _v$3, _p$._v$3));
              _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$28, "text", _v$4, _p$._v$4));
              return _p$;
            }, {
              _v$3: undefined,
              _v$4: undefined
            });
            return _el$24;
          })();
        }
      }), _el$18);
      insert(_el$18, createComponent(Show, {
        get when() {
          return getTitleShow();
        },
        get children() {
          return [(() => {
            const _el$19 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$19);
              createElement("Panel", {
                "class": "Line"
              }, _el$19);
              const _el$22 = createElement("Label", {
                text: `#AffixTitle_3`,
                hittest: false
              }, _el$19);
            setProp(_el$22, "text", `#AffixTitle_3`);
            return _el$19;
          })(), (() => {
            const _el$23 = createElement("Panel", {
              "class": "Body"
            }, null);
            insert(_el$23, createComponent(Show, {
              get when() {
                return getRsnc().length > 0;
              },
              get children() {
                return createComponent(Index, {
                  get each() {
                    return getRsnc().sort((a, b) => a.idx - b.idx);
                  },
                  children: affix => {
                    return createComponent(EquipTooltipRsncRow, {
                      get affix() {
                        return affix();
                      }
                    });
                  }
                });
              }
            }));
            return _el$23;
          })()];
        }
      }));
      effect(_$p => setProp(_el$17, "class", classNames('TooltipAffix', `Rarity_${getRarity()}`), _$p));
      return _el$17;
    })();
  }
  function EquipTooltipCompare(params) {
    const [local, props] = splitProps(params, ['left', 'right']);
    const getEffect = (level, affix) => {
      var _a, _b;
      const cfg = (_b = (_a = CfgGetter_equipment_effect()) === null || _a === void 0 ? void 0 : _a[level]) === null || _b === void 0 ? void 0 : _b[affix];
      return cfg || {
        value_down: 0,
        value_up: 0,
        ratio: 0
      };
    };
    const getAffixCalc = (tEquip, affixType) => {
      var _a;
      const tAffix = tEquip.affix || [];
      const tAffixCalc = {};
      for (const affix of tAffix) {
        if (affix.c == affixType) {
          const tEffect = getEffect(affix.l, affix.a);
          const getVal = () => ValuePct(affix.v, tEffect.value_down, tEffect.value_up, tEffect.ratio);
          const getPartLevelRatio = () => {
            var _a, _b, _c, _d;
            return ((_d = (_a = CfgGetter_equipment_enhance_effect()) === null || _a === void 0 ? void 0 : _a[(_c = (_b = props === null || props === void 0 ? void 0 : props.part_level) === null || _b === void 0 ? void 0 : _b.call(props)) !== null && _c !== void 0 ? _c : 0]) === null || _d === void 0 ? void 0 : _d[affix.c]) || 0;
          };
          const getBonus = () => getVal() * getPartLevelRatio() / 10000;
          const getTotal = () => getVal() + getBonus();
          tAffixCalc[affix.a] = ((_a = tAffixCalc[affix.a]) !== null && _a !== void 0 ? _a : 0) + getTotal();
        }
      }
      return tAffixCalc;
    };
    const getCompareAffix = (left, right, affixType) => {
      const leftAffixCalc = getAffixCalc(left, affixType);
      const rightAffixCalc = getAffixCalc(right, affixType);
      return {
        gain: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] === undefined).sort((a, b) => rightAffixCalc[a] - rightAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key], getEffect(1, Number(key)).ratio)
        })),
        loss: Object.keys(leftAffixCalc).filter(key => rightAffixCalc[key] === undefined).sort((a, b) => leftAffixCalc[a] - leftAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key], getEffect(1, Number(key)).ratio).replace('+', '-')
        })),
        increase: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] > leftAffixCalc[key]).sort((a, b) => rightAffixCalc[a] - leftAffixCalc[a] - (rightAffixCalc[b] - leftAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key] - leftAffixCalc[key], getEffect(1, Number(key)).ratio)
        })),
        decrease: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] < leftAffixCalc[key]).sort((a, b) => leftAffixCalc[a] - rightAffixCalc[a] - (leftAffixCalc[b] - rightAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key] - rightAffixCalc[key], getEffect(1, Number(key)).ratio).replace('+', '-')
        }))
      };
    };
    const getBaseAffix = createMemo(() => {
      return getCompareAffix(local.left, local.right, 1);
    });
    const getAdvAffix = createMemo(() => {
      return getCompareAffix(local.left, local.right, 2);
    });
    const CompareAffixPanel = params2 => {
      const [local, props] = splitProps(params2, ['affixCompare', 'affixPart']);
      return (() => {
        const _el$31 = createElement("Panel", {
            get id() {
              return "Part_" + local.affixPart;
            },
            "class": "AffixGroup"
          }, null),
          _el$32 = createElement("Panel", {
            "class": "Title",
            hittest: false
          }, _el$31);
          createElement("Panel", {
            "class": "BG"
          }, _el$32);
          createElement("Panel", {
            "class": "Line"
          }, _el$32);
          const _el$35 = createElement("Label", {
            get text() {
              return `#AffixTitle_${local.affixPart}`;
            },
            hittest: false
          }, _el$32),
          _el$36 = createElement("Panel", {
            "class": "Body"
          }, _el$31);
        insert(_el$36, createComponent(Index, {
          get each() {
            return local.affixCompare.increase;
          },
          children: affix => {
            return (() => {
              const _el$37 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Increase EquipTooltipAffixRow"
                }, null),
                _el$38 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$37),
                _el$39 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$38),
                _el$40 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$38);
              setProp(_el$39, "className", "Name");
              setProp(_el$40, "className", "Value");
              effect(_p$ => {
                const _v$7 = $.Localize('#' + affix().a.toString()),
                  _v$8 = GreenText(affix().v);
                _v$7 !== _p$._v$7 && (_p$._v$7 = setProp(_el$39, "text", _v$7, _p$._v$7));
                _v$8 !== _p$._v$8 && (_p$._v$8 = setProp(_el$40, "text", _v$8, _p$._v$8));
                return _p$;
              }, {
                _v$7: undefined,
                _v$8: undefined
              });
              return _el$37;
            })();
          }
        }), null);
        insert(_el$36, createComponent(Index, {
          get each() {
            return local.affixCompare.gain;
          },
          children: affix => {
            return (() => {
              const _el$41 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Gain EquipTooltipAffixRow"
                }, null),
                _el$42 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$41),
                _el$43 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$42),
                _el$44 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$42);
              setProp(_el$43, "className", "Name");
              setProp(_el$44, "className", "Value");
              effect(_p$ => {
                const _v$9 = $.Localize('#' + affix().a.toString()),
                  _v$0 = GreenText(affix().v);
                _v$9 !== _p$._v$9 && (_p$._v$9 = setProp(_el$43, "text", _v$9, _p$._v$9));
                _v$0 !== _p$._v$0 && (_p$._v$0 = setProp(_el$44, "text", _v$0, _p$._v$0));
                return _p$;
              }, {
                _v$9: undefined,
                _v$0: undefined
              });
              return _el$41;
            })();
          }
        }), null);
        insert(_el$36, createComponent(Index, {
          get each() {
            return local.affixCompare.decrease;
          },
          children: affix => {
            return (() => {
              const _el$45 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Decrease EquipTooltipAffixRow"
                }, null),
                _el$46 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$45),
                _el$47 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$46),
                _el$48 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$46);
              setProp(_el$47, "className", "Name");
              setProp(_el$48, "className", "Value");
              effect(_p$ => {
                const _v$1 = $.Localize('#' + affix().a.toString()),
                  _v$10 = RedText(affix().v);
                _v$1 !== _p$._v$1 && (_p$._v$1 = setProp(_el$47, "text", _v$1, _p$._v$1));
                _v$10 !== _p$._v$10 && (_p$._v$10 = setProp(_el$48, "text", _v$10, _p$._v$10));
                return _p$;
              }, {
                _v$1: undefined,
                _v$10: undefined
              });
              return _el$45;
            })();
          }
        }), null);
        insert(_el$36, createComponent(Index, {
          get each() {
            return local.affixCompare.loss;
          },
          children: affix => {
            return (() => {
              const _el$49 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Loss EquipTooltipAffixRow"
                }, null),
                _el$50 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$49),
                _el$51 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$50),
                _el$52 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$50);
              setProp(_el$51, "className", "Name");
              setProp(_el$52, "className", "Value");
              effect(_p$ => {
                const _v$11 = $.Localize('#' + affix().a.toString()),
                  _v$12 = RedText(affix().v);
                _v$11 !== _p$._v$11 && (_p$._v$11 = setProp(_el$51, "text", _v$11, _p$._v$11));
                _v$12 !== _p$._v$12 && (_p$._v$12 = setProp(_el$52, "text", _v$12, _p$._v$12));
                return _p$;
              }, {
                _v$11: undefined,
                _v$12: undefined
              });
              return _el$49;
            })();
          }
        }), null);
        effect(_p$ => {
          const _v$5 = "Part_" + local.affixPart,
            _v$6 = `#AffixTitle_${local.affixPart}`;
          _v$5 !== _p$._v$5 && (_p$._v$5 = setProp(_el$31, "id", _v$5, _p$._v$5));
          _v$6 !== _p$._v$6 && (_p$._v$6 = setProp(_el$35, "text", _v$6, _p$._v$6));
          return _p$;
        }, {
          _v$5: undefined,
          _v$6: undefined
        });
        return _el$31;
      })();
    };
    return (() => {
      const _el$53 = createElement("Panel", {
        id: "EquipTooltipAffix",
        "class": "EquipTooltipCompare"
      }, null);
      insert(_el$53, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getBaseAffix();
        },
        affixPart: 1
      }), null);
      insert(_el$53, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getAdvAffix();
        },
        affixPart: 2
      }), null);
      return _el$53;
    })();
  }
  function AncientTooltipCompare(params) {
    const [local, props] = splitProps(params, ['left', 'right']);
    const getEffect = affix => {
      var _a;
      let data = {
        value_down: 0,
        value_up: 0,
        ratio: 1
      };
      let cfg = (_a = CfgGetter_ancient_effect()) === null || _a === void 0 ? void 0 : _a[String(affix.a)];
      if (cfg) {
        const f = CalcAncientEffectCoefficient(affix);
        data.ratio = cfg.ratio;
        data.value_down = NumFixRatio(cfg.value_down * f, cfg.ratio);
        data.value_up = NumFixRatio(cfg.value_up * f, cfg.ratio);
      }
      return data;
    };
    const getRatio = affixId => {
      var _a, _b, _c;
      return (_c = (_b = (_a = CfgGetter_ancient_effect()) === null || _a === void 0 ? void 0 : _a[String(affixId)]) === null || _b === void 0 ? void 0 : _b.ratio) !== null && _c !== void 0 ? _c : 1;
    };
    const getAffixCalc = (tAncient, affixType) => {
      var _a, _b, _c;
      const tAffix = tAncient.affix || [];
      const tAffixCalc = {};
      const partLevel = (_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0;
      for (const affix of tAffix) {
        if (affix.c == affixType) {
          const tEffect = getEffect(affix);
          const val = ValuePct(affix.v, tEffect.value_down, tEffect.value_up, tEffect.ratio);
          const bonus = val * CalcAncientEffectLevel(affix, partLevel) / 10000;
          tAffixCalc[affix.a] = ((_c = tAffixCalc[affix.a]) !== null && _c !== void 0 ? _c : 0) + val + bonus;
        }
      }
      const rsncBonus = AncientGetRsnc(AncientCalculateInfo(tAncient), partLevel);
      for (const key in rsncBonus) {
        if (tAffixCalc[key] !== undefined) {
          tAffixCalc[key] += rsncBonus[key];
        }
      }
      return tAffixCalc;
    };
    const getCompareAffix = (left, right, affixType) => {
      const leftAffixCalc = getAffixCalc(left, affixType);
      const rightAffixCalc = getAffixCalc(right, affixType);
      return {
        gain: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] === undefined).sort((a, b) => rightAffixCalc[a] - rightAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key], getRatio(Number(key)))
        })),
        loss: Object.keys(leftAffixCalc).filter(key => rightAffixCalc[key] === undefined).sort((a, b) => leftAffixCalc[a] - leftAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key], getRatio(Number(key))).replace('+', '-')
        })),
        increase: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] > leftAffixCalc[key]).sort((a, b) => rightAffixCalc[a] - leftAffixCalc[a] - (rightAffixCalc[b] - leftAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key] - leftAffixCalc[key], getRatio(Number(key)))
        })),
        decrease: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] < leftAffixCalc[key]).sort((a, b) => leftAffixCalc[a] - rightAffixCalc[a] - (leftAffixCalc[b] - rightAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key] - rightAffixCalc[key], getRatio(Number(key))).replace('+', '-')
        }))
      };
    };
    const getBaseAffix = createMemo(() => getCompareAffix(local.left, local.right, 1));
    const getAdvAffix = createMemo(() => getCompareAffix(local.left, local.right, 2));
    const CompareAffixPanel = params2 => {
      const [local2] = splitProps(params2, ['affixCompare', 'affixPart']);
      return (() => {
        const _el$54 = createElement("Panel", {
            get id() {
              return "Part_" + local2.affixPart;
            },
            "class": "AffixGroup"
          }, null),
          _el$55 = createElement("Panel", {
            "class": "Title",
            hittest: false
          }, _el$54);
          createElement("Panel", {
            "class": "BG"
          }, _el$55);
          createElement("Panel", {
            "class": "Line"
          }, _el$55);
          const _el$58 = createElement("Label", {
            get text() {
              return `#AffixTitle_${local2.affixPart}`;
            },
            hittest: false
          }, _el$55),
          _el$59 = createElement("Panel", {
            "class": "Body"
          }, _el$54);
        insert(_el$59, createComponent(Index, {
          get each() {
            return local2.affixCompare.increase;
          },
          children: affix => {
            return (() => {
              const _el$60 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Increase EquipTooltipAffixRow"
                }, null),
                _el$61 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$60),
                _el$62 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$61),
                _el$63 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$61);
              setProp(_el$62, "className", "Name");
              setProp(_el$63, "className", "Value");
              effect(_p$ => {
                const _v$15 = $.Localize('#' + affix().a.toString()),
                  _v$16 = GreenText(affix().v);
                _v$15 !== _p$._v$15 && (_p$._v$15 = setProp(_el$62, "text", _v$15, _p$._v$15));
                _v$16 !== _p$._v$16 && (_p$._v$16 = setProp(_el$63, "text", _v$16, _p$._v$16));
                return _p$;
              }, {
                _v$15: undefined,
                _v$16: undefined
              });
              return _el$60;
            })();
          }
        }), null);
        insert(_el$59, createComponent(Index, {
          get each() {
            return local2.affixCompare.gain;
          },
          children: affix => {
            return (() => {
              const _el$64 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Gain EquipTooltipAffixRow"
                }, null),
                _el$65 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$64),
                _el$66 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$65),
                _el$67 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$65);
              setProp(_el$66, "className", "Name");
              setProp(_el$67, "className", "Value");
              effect(_p$ => {
                const _v$17 = $.Localize('#' + affix().a.toString()),
                  _v$18 = GreenText(affix().v);
                _v$17 !== _p$._v$17 && (_p$._v$17 = setProp(_el$66, "text", _v$17, _p$._v$17));
                _v$18 !== _p$._v$18 && (_p$._v$18 = setProp(_el$67, "text", _v$18, _p$._v$18));
                return _p$;
              }, {
                _v$17: undefined,
                _v$18: undefined
              });
              return _el$64;
            })();
          }
        }), null);
        insert(_el$59, createComponent(Index, {
          get each() {
            return local2.affixCompare.decrease;
          },
          children: affix => {
            return (() => {
              const _el$68 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Decrease EquipTooltipAffixRow"
                }, null),
                _el$69 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$68),
                _el$70 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$69),
                _el$71 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$69);
              setProp(_el$70, "className", "Name");
              setProp(_el$71, "className", "Value");
              effect(_p$ => {
                const _v$19 = $.Localize('#' + affix().a.toString()),
                  _v$20 = RedText(affix().v);
                _v$19 !== _p$._v$19 && (_p$._v$19 = setProp(_el$70, "text", _v$19, _p$._v$19));
                _v$20 !== _p$._v$20 && (_p$._v$20 = setProp(_el$71, "text", _v$20, _p$._v$20));
                return _p$;
              }, {
                _v$19: undefined,
                _v$20: undefined
              });
              return _el$68;
            })();
          }
        }), null);
        insert(_el$59, createComponent(Index, {
          get each() {
            return local2.affixCompare.loss;
          },
          children: affix => {
            return (() => {
              const _el$72 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Loss EquipTooltipAffixRow"
                }, null),
                _el$73 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$72),
                _el$74 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$73),
                _el$75 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$73);
              setProp(_el$74, "className", "Name");
              setProp(_el$75, "className", "Value");
              effect(_p$ => {
                const _v$21 = $.Localize('#' + affix().a.toString()),
                  _v$22 = RedText(affix().v);
                _v$21 !== _p$._v$21 && (_p$._v$21 = setProp(_el$74, "text", _v$21, _p$._v$21));
                _v$22 !== _p$._v$22 && (_p$._v$22 = setProp(_el$75, "text", _v$22, _p$._v$22));
                return _p$;
              }, {
                _v$21: undefined,
                _v$22: undefined
              });
              return _el$72;
            })();
          }
        }), null);
        effect(_p$ => {
          const _v$13 = "Part_" + local2.affixPart,
            _v$14 = `#AffixTitle_${local2.affixPart}`;
          _v$13 !== _p$._v$13 && (_p$._v$13 = setProp(_el$54, "id", _v$13, _p$._v$13));
          _v$14 !== _p$._v$14 && (_p$._v$14 = setProp(_el$58, "text", _v$14, _p$._v$14));
          return _p$;
        }, {
          _v$13: undefined,
          _v$14: undefined
        });
        return _el$54;
      })();
    };
    return (() => {
      const _el$76 = createElement("Panel", {
        id: "AncientTooltipAffix",
        "class": "EquipTooltipCompare"
      }, null);
      insert(_el$76, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getBaseAffix();
        },
        affixPart: 1
      }), null);
      insert(_el$76, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getAdvAffix();
        },
        affixPart: 2
      }), null);
      return _el$76;
    })();
  }
  function HolyTooltipCompare(params) {
    const [local] = splitProps(params, ['left', 'right']);
    const getEffect = (holy, affix) => {
      var _a, _b;
      const iClass = (_a = holy.class) !== null && _a !== void 0 ? _a : 1;
      if (typeof affix === 'number') {
        const tAffix = (_b = holy.affix) === null || _b === void 0 ? void 0 : _b.find(a => a.a == affix);
        return GetHolyAffixEffect(iClass, tAffix !== null && tAffix !== void 0 ? tAffix : {
          a: affix
        });
      }
      return GetHolyAffixEffect(iClass, affix);
    };
    const getRatio = (holy, affixId) => {
      var _a;
      return (_a = getEffect(holy, affixId).ratio) !== null && _a !== void 0 ? _a : 1;
    };
    const getAffixTotalVal = (holy, affix) => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j;
      const iClass = (_a = holy.class) !== null && _a !== void 0 ? _a : 1;
      const strengthen = (_b = holy.strength) !== null && _b !== void 0 ? _b : 0;
      const strengthenMax = (_e = (_d = GetHolySetting((_c = holy.rarity) !== null && _c !== void 0 ? _c : 1, iClass)) === null || _d === void 0 ? void 0 : _d['strengthen_max']) !== null && _e !== void 0 ? _e : 0;
      const effect = getEffect(holy, affix);
      const tCfgSettingCommon = (_f = CfgGetter_settings_common()) !== null && _f !== void 0 ? _f : {};
      let baseVal = affix.v;
      if (affix.taigu) {
        baseVal = effect.value_up * (1 + ((_g = tCfgSettingCommon['holy_taigu_affix_pct']) !== null && _g !== void 0 ? _g : 0) * 0.01);
      } else {
        baseVal = ValuePct(affix.v, effect.value_down, effect.value_up, effect.ratio);
      }
      let strengthenVal = 0;
      if (strengthen > 0 && strengthenMax > 0) {
        const iCfgStrengthenPct = (_h = tCfgSettingCommon['holy_strengthen_pct']) !== null && _h !== void 0 ? _h : 0;
        strengthenVal = baseVal * (iCfgStrengthenPct * (strengthen / strengthenMax) * 0.01);
      }
      let finalVal = 0;
      if (affix.fin) {
        const iCfgStrengthenFinalPct = (_j = tCfgSettingCommon['holy_strengthen_final_pct']) !== null && _j !== void 0 ? _j : 0;
        finalVal = baseVal * (iCfgStrengthenFinalPct * 0.01);
      }
      return baseVal + strengthenVal + finalVal;
    };
    const getAffixCalc = (holy, affixType) => {
      var _a;
      const tAffixCalc = {};
      for (const affix of holy.affix || []) {
        if (affix.c == affixType) {
          tAffixCalc[affix.a] = ((_a = tAffixCalc[affix.a]) !== null && _a !== void 0 ? _a : 0) + getAffixTotalVal(holy, affix);
        }
      }
      return tAffixCalc;
    };
    const getCompareAffix = (left, right, affixType) => {
      const leftAffixCalc = getAffixCalc(left, affixType);
      const rightAffixCalc = getAffixCalc(right, affixType);
      return {
        gain: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] === undefined).sort((a, b) => rightAffixCalc[a] - rightAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key], getRatio(right, Number(key)))
        })),
        loss: Object.keys(leftAffixCalc).filter(key => rightAffixCalc[key] === undefined).sort((a, b) => leftAffixCalc[a] - leftAffixCalc[b]).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key], getRatio(left, Number(key))).replace('+', '-')
        })),
        increase: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] > leftAffixCalc[key]).sort((a, b) => rightAffixCalc[a] - leftAffixCalc[a] - (rightAffixCalc[b] - leftAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), rightAffixCalc[key] - leftAffixCalc[key], getRatio(right, Number(key)))
        })),
        decrease: Object.keys(rightAffixCalc).filter(key => leftAffixCalc[key] !== undefined && rightAffixCalc[key] < leftAffixCalc[key]).sort((a, b) => leftAffixCalc[a] - rightAffixCalc[a] - (leftAffixCalc[b] - rightAffixCalc[b])).map(key => ({
          a: Number(key),
          v: AttrVal2Str(Number(key), leftAffixCalc[key] - rightAffixCalc[key], getRatio(left, Number(key))).replace('+', '-')
        }))
      };
    };
    const getBaseAffix = createMemo(() => getCompareAffix(local.left, local.right, 1));
    const getAdvAffix = createMemo(() => getCompareAffix(local.left, local.right, 2));
    const CompareAffixPanel = params2 => {
      const [local2] = splitProps(params2, ['affixCompare', 'affixPart']);
      return (() => {
        const _el$77 = createElement("Panel", {
            get id() {
              return "Part_" + local2.affixPart;
            },
            "class": "AffixGroup"
          }, null),
          _el$78 = createElement("Panel", {
            "class": "Title",
            hittest: false
          }, _el$77);
          createElement("Panel", {
            "class": "BG"
          }, _el$78);
          createElement("Panel", {
            "class": "Line"
          }, _el$78);
          const _el$81 = createElement("Label", {
            get text() {
              return `#AffixTitle_${local2.affixPart}`;
            },
            hittest: false
          }, _el$78),
          _el$82 = createElement("Panel", {
            "class": "Body"
          }, _el$77);
        insert(_el$82, createComponent(Index, {
          get each() {
            return local2.affixCompare.increase;
          },
          children: affix => {
            return (() => {
              const _el$83 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Increase EquipTooltipAffixRow"
                }, null),
                _el$84 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$83),
                _el$85 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$84),
                _el$86 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$84);
              setProp(_el$85, "className", "Name");
              setProp(_el$86, "className", "Value");
              effect(_p$ => {
                const _v$25 = $.Localize('#' + affix().a.toString()),
                  _v$26 = GreenText(affix().v);
                _v$25 !== _p$._v$25 && (_p$._v$25 = setProp(_el$85, "text", _v$25, _p$._v$25));
                _v$26 !== _p$._v$26 && (_p$._v$26 = setProp(_el$86, "text", _v$26, _p$._v$26));
                return _p$;
              }, {
                _v$25: undefined,
                _v$26: undefined
              });
              return _el$83;
            })();
          }
        }), null);
        insert(_el$82, createComponent(Index, {
          get each() {
            return local2.affixCompare.gain;
          },
          children: affix => {
            return (() => {
              const _el$87 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Gain EquipTooltipAffixRow"
                }, null),
                _el$88 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$87),
                _el$89 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$88),
                _el$90 = createElement("Label", {
                  get text() {
                    return GreenText(affix().v);
                  },
                  html: true
                }, _el$88);
              setProp(_el$89, "className", "Name");
              setProp(_el$90, "className", "Value");
              effect(_p$ => {
                const _v$27 = $.Localize('#' + affix().a.toString()),
                  _v$28 = GreenText(affix().v);
                _v$27 !== _p$._v$27 && (_p$._v$27 = setProp(_el$89, "text", _v$27, _p$._v$27));
                _v$28 !== _p$._v$28 && (_p$._v$28 = setProp(_el$90, "text", _v$28, _p$._v$28));
                return _p$;
              }, {
                _v$27: undefined,
                _v$28: undefined
              });
              return _el$87;
            })();
          }
        }), null);
        insert(_el$82, createComponent(Index, {
          get each() {
            return local2.affixCompare.decrease;
          },
          children: affix => {
            return (() => {
              const _el$91 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Decrease EquipTooltipAffixRow"
                }, null),
                _el$92 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$91),
                _el$93 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$92),
                _el$94 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$92);
              setProp(_el$93, "className", "Name");
              setProp(_el$94, "className", "Value");
              effect(_p$ => {
                const _v$29 = $.Localize('#' + affix().a.toString()),
                  _v$30 = RedText(affix().v);
                _v$29 !== _p$._v$29 && (_p$._v$29 = setProp(_el$93, "text", _v$29, _p$._v$29));
                _v$30 !== _p$._v$30 && (_p$._v$30 = setProp(_el$94, "text", _v$30, _p$._v$30));
                return _p$;
              }, {
                _v$29: undefined,
                _v$30: undefined
              });
              return _el$91;
            })();
          }
        }), null);
        insert(_el$82, createComponent(Index, {
          get each() {
            return local2.affixCompare.loss;
          },
          children: affix => {
            return (() => {
              const _el$95 = createElement("Panel", {
                  id: "EquipTooltipCompareAffixRow",
                  "class": "Loss EquipTooltipAffixRow"
                }, null),
                _el$96 = createElement("Panel", {
                  "class": "Yzy_Attribute"
                }, _el$95),
                _el$97 = createElement("Label", {
                  get text() {
                    return $.Localize('#' + affix().a.toString());
                  },
                  html: true
                }, _el$96),
                _el$98 = createElement("Label", {
                  get text() {
                    return RedText(affix().v);
                  },
                  html: true
                }, _el$96);
              setProp(_el$97, "className", "Name");
              setProp(_el$98, "className", "Value");
              effect(_p$ => {
                const _v$31 = $.Localize('#' + affix().a.toString()),
                  _v$32 = RedText(affix().v);
                _v$31 !== _p$._v$31 && (_p$._v$31 = setProp(_el$97, "text", _v$31, _p$._v$31));
                _v$32 !== _p$._v$32 && (_p$._v$32 = setProp(_el$98, "text", _v$32, _p$._v$32));
                return _p$;
              }, {
                _v$31: undefined,
                _v$32: undefined
              });
              return _el$95;
            })();
          }
        }), null);
        effect(_p$ => {
          const _v$23 = "Part_" + local2.affixPart,
            _v$24 = `#AffixTitle_${local2.affixPart}`;
          _v$23 !== _p$._v$23 && (_p$._v$23 = setProp(_el$77, "id", _v$23, _p$._v$23));
          _v$24 !== _p$._v$24 && (_p$._v$24 = setProp(_el$81, "text", _v$24, _p$._v$24));
          return _p$;
        }, {
          _v$23: undefined,
          _v$24: undefined
        });
        return _el$77;
      })();
    };
    return (() => {
      const _el$99 = createElement("Panel", {
        id: "HolyTooltipAffix",
        "class": "EquipTooltipCompare"
      }, null);
      insert(_el$99, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getBaseAffix();
        },
        affixPart: 1
      }), null);
      insert(_el$99, createComponent(CompareAffixPanel, {
        get affixCompare() {
          return getAdvAffix();
        },
        affixPart: 2
      }), null);
      return _el$99;
    })();
  }
  function EquipTooltipAffixRow(props) {
    const getAffix = () => props.affix;
    const getIdx = () => getAffix().idx;
    const getExtractLockMaxCount = () => {
      var _a, _b;
      return (_b = (_a = props.extract_lock_count) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0;
    };
    const getIsExtractLock = () => props.extract_lock_idx != undefined && getExtractLockMaxCount() > 0;
    const getPrvg1185014 = () => {
      var _a, _b, _c;
      return (_c = (_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a['1185014']) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
    };
    const getInsertLockMaxCount = () => {
      var _a, _b;
      return ((_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['equip_insert_lock_default']) !== null && _b !== void 0 ? _b : 0) + getPrvg1185014();
    };
    const getIsInsertLock = () => props.insert_lock_idx != undefined && getInsertLockMaxCount() > 0;
    return (() => {
      const _el$100 = createElement("Panel", {
          get onload() {
            return props.onload;
          },
          get id() {
            return "EquipTooltipAffixRow_" + getIdx();
          },
          get ["class"]() {
            return classNames("EquipTooltipAffixRow", "EquipTooltipAffixRow_" + getIdx(), props.className, {
              'HasLock': getIsExtractLock() || getIsInsertLock()
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$100);
      insert(_el$100, createComponent(Show, {
        get when() {
          return getIsInsertLock();
        },
        get children() {
          return [() => {
            var _a, _b;
            let ref;
            const [getLockIdx, setLockIdx] = props.insert_lock_idx;
            const getIsLock = () => getLockIdx().includes(props.affix.idx);
            const getIsDisableSelect = () => getLockIdx().length >= getInsertLockMaxCount() && !getIsLock();
            createEffect(() => {
              if (ref) {
                ref.GetParent().SetHasClass('IsLock', getIsLock());
                if (ref.checked != getIsLock()) {
                  ref.checked = getIsLock();
                }
              }
            });
            return (() => {
              const _el$103 = createElement("ToggleButton", {
                get hittest() {
                  return ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0;
                },
                "class": "LockToggle",
                get selected() {
                  return getIsLock();
                }
              }, null);
              const _ref$2 = ref;
              typeof _ref$2 === "function" ? use(_ref$2, _el$103) : ref = _el$103;
              setProp(_el$103, "onselect", p => {
                if (getIsLock()) return;
                if (getIsDisableSelect()) {
                  p.checked = false;
                  return;
                }
                const t = [...getLockIdx()];
                t.push(props.affix.idx);
                setLockIdx(t);
              });
              setProp(_el$103, "ondeselect", p => {
                const t = [...getLockIdx()];
                const i = t.indexOf(props.affix.idx);
                if (i != -1) {
                  t.splice(i, 1);
                  setLockIdx(t);
                }
              });
              effect(_p$ => {
                const _v$36 = ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0,
                  _v$37 = {
                    'DisableSelect': getIsDisableSelect()
                  },
                  _v$38 = getIsLock();
                _v$36 !== _p$._v$36 && (_p$._v$36 = setProp(_el$103, "hittest", _v$36, _p$._v$36));
                _v$37 !== _p$._v$37 && (_p$._v$37 = setProp(_el$103, "classList", _v$37, _p$._v$37));
                _v$38 !== _p$._v$38 && (_p$._v$38 = setProp(_el$103, "selected", _v$38, _p$._v$38));
                return _p$;
              }, {
                _v$36: undefined,
                _v$37: undefined,
                _v$38: undefined
              });
              return _el$103;
            })();
          }, createElement("Panel", {
            id: "ExtractInsertAffix"
          }, null)];
        }
      }), null);
      insert(_el$100, createComponent(Show, {
        get when() {
          return getIsExtractLock();
        },
        children: () => {
          var _a, _b;
          if ((props === null || props === void 0 ? void 0 : props.extract_lock_idx) == undefined) return [];
          let ref;
          const [getLockIdx, setLockIdx] = props === null || props === void 0 ? void 0 : props.extract_lock_idx;
          const getIsLock = () => getLockIdx().includes(props.affix.idx);
          const getIsDisableSelect = () => {
            var _a, _b;
            return getLockIdx().length >= ((_b = (_a = props.extract_lock_count) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) && !getIsLock();
          };
          createEffect(() => {
            if (ref) {
              ref.GetParent().SetHasClass('IsLock', getIsLock());
              if (ref.checked != getIsLock()) {
                ref.checked = getIsLock();
              }
            }
          });
          return (() => {
            const _el$104 = createElement("ToggleButton", {
              get hittest() {
                return ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0;
              },
              "class": "LockToggle",
              get selected() {
                return getIsLock();
              }
            }, null);
            const _ref$3 = ref;
            typeof _ref$3 === "function" ? use(_ref$3, _el$104) : ref = _el$104;
            setProp(_el$104, "onselect", p => {
              if (getIsLock()) return;
              if (getIsDisableSelect()) {
                p.checked = false;
                return;
              }
              const t = [...getLockIdx()];
              t.push(props.affix.idx);
              setLockIdx(t);
            });
            setProp(_el$104, "ondeselect", p => {
              const t = [...getLockIdx()];
              const i = t.indexOf(props.affix.idx);
              if (i != -1) {
                t.splice(i, 1);
                setLockIdx(t);
              }
            });
            effect(_p$ => {
              const _v$39 = ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0,
                _v$40 = {
                  'DisableSelect': getIsDisableSelect()
                },
                _v$41 = getIsLock();
              _v$39 !== _p$._v$39 && (_p$._v$39 = setProp(_el$104, "hittest", _v$39, _p$._v$39));
              _v$40 !== _p$._v$40 && (_p$._v$40 = setProp(_el$104, "classList", _v$40, _p$._v$40));
              _v$41 !== _p$._v$41 && (_p$._v$41 = setProp(_el$104, "selected", _v$41, _p$._v$41));
              return _p$;
            }, {
              _v$39: undefined,
              _v$40: undefined,
              _v$41: undefined
            });
            return _el$104;
          })();
        }
      }), null);
      insert(_el$100, createComponent(EquipTooltipAffixRowBase, props), null);
      effect(_p$ => {
        const _v$33 = props.onload,
          _v$34 = "EquipTooltipAffixRow_" + getIdx(),
          _v$35 = classNames("EquipTooltipAffixRow", "EquipTooltipAffixRow_" + getIdx(), props.className, {
            'HasLock': getIsExtractLock() || getIsInsertLock()
          });
        _v$33 !== _p$._v$33 && (_p$._v$33 = setProp(_el$100, "onload", _v$33, _p$._v$33));
        _v$34 !== _p$._v$34 && (_p$._v$34 = setProp(_el$100, "id", _v$34, _p$._v$34));
        _v$35 !== _p$._v$35 && (_p$._v$35 = setProp(_el$100, "class", _v$35, _p$._v$35));
        return _p$;
      }, {
        _v$33: undefined,
        _v$34: undefined,
        _v$35: undefined
      });
      return _el$100;
    })();
  }
  function EquipTooltipAffixRowBase(props) {
    var _a, _b;
    const getPrvg96 = () => {
      var _a, _b;
      return (_b = (_a = props.prvg96) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0;
    };
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getAffix = () => props.affix;
    const getLevel = () => getAffix().l || 1;
    const getEffect = createMemo(() => {
      var _a, _b;
      const cfg = (_b = (_a = CfgGetter_equipment_effect()) === null || _a === void 0 ? void 0 : _a[getLevel()]) === null || _b === void 0 ? void 0 : _b[props.affix.a];
      return cfg || {
        value_down: 0,
        value_up: 0,
        ratio: 0
      };
    });
    const getPartLevelRatio = createMemo(() => {
      var _a, _b, _c, _d, _e;
      let iEnhancePct = ((_d = (_a = CfgGetter_equipment_enhance_effect()) === null || _a === void 0 ? void 0 : _a[(_c = (_b = props === null || props === void 0 ? void 0 : props.part_level) === null || _b === void 0 ? void 0 : _b.call(props)) !== null && _c !== void 0 ? _c : 0]) === null || _d === void 0 ? void 0 : _d[props.affix.c]) || 0;
      const iPrvg96 = getPrvg96();
      if (iPrvg96 > 0) {
        iEnhancePct = iEnhancePct * (100 + ((_e = AbilitiesKv['privilege_1180096']['AbilityValues']['val']) !== null && _e !== void 0 ? _e : 0) * iPrvg96) * 0.01;
      }
      return iEnhancePct;
    });
    const getVal = () => ValuePct(props.affix.v, getEffect().value_down, getEffect().value_up, getEffect().ratio);
    const getBonus = () => getVal() * getPartLevelRatio() / 10000;
    const getValStr = () => AttrVal2Str(props.affix.a, getVal(), getEffect().ratio);
    const getBonusStr = () => AttrVal2Str(props.affix.a, getBonus(), getEffect().ratio);
    const getTotalStr = () => AttrVal2Str(props.affix.a, getVal() + getBonus(), getEffect().ratio);
    const getRangeStr = () => ValRangeStr(props.affix.a, getEffect().value_down, NumFixRatio(getEffect().value_down + (getEffect().value_up - getEffect().value_down) * getRedLimit() * 0.01, getEffect().ratio));
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getLevelRarity = () => {
      const cfg = {
        [1]: 1,
        [6]: 2,
        [7]: 3,
        [8]: 4,
        [9]: 5,
        [10]: 6
      };
      let iRarity = 1;
      for (const [lvl, rarity] of Object.entries(cfg).sort((a, b) => Number(a[0]) - Number(b[0]))) {
        if (getLevel() < Number(lvl)) break;
        iRarity = Number(rarity);
      }
      return iRarity;
    };
    return (() => {
      const _el$105 = createElement("Panel", {
          get ["class"]() {
            return classNames('EquipTooltipAffixRowBase', {
              'Red': getIsRed()
            });
          },
          hittest: false
        }, null),
        _el$106 = createElement("Label", {
          id: "Level",
          get ["class"]() {
            return 'Rarity_' + getLevelRarity();
          },
          get text() {
            return getLevel();
          }
        }, _el$105),
        _el$107 = createElement("Label", {
          id: "Affix",
          html: true,
          get text() {
            return '#' + props.affix.a;
          }
        }, _el$105);
      insert(_el$105, createComponent(Show, {
        get when() {
          return memo(() => !!!getter_bAltDown())() && (props.inset_parent ? props.inset_parent.IsValid() : true);
        },
        get children() {
          return [(() => {
            const _el$108 = createElement("Label", {
              id: "Value",
              html: true,
              get text() {
                return getValStr();
              }
            }, null);
            effect(_$p => setProp(_el$108, "text", getValStr(), _$p));
            return _el$108;
          })(), (() => {
            const _el$109 = createElement("Label", {
              id: "Range",
              html: true,
              get text() {
                return getRangeStr();
              }
            }, null);
            effect(_$p => setProp(_el$109, "text", getRangeStr(), _$p));
            return _el$109;
          })(), createComponent(Show, {
            get when() {
              return memo(() => ((_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) > 0)() && (props.inset_parent ? props.inset_parent.IsValid() : true);
            },
            get children() {
              const _el$110 = createElement("Label", {
                hittest: false,
                id: "Bonus",
                html: true,
                get text() {
                  return getBonusStr();
                }
              }, null);
              effect(_$p => setProp(_el$110, "text", getBonusStr(), _$p));
              return _el$110;
            }
          })];
        }
      }), null);
      insert(_el$105, createComponent(Show, {
        get when() {
          return memo(() => !!getter_bAltDown())() && (props.inset_parent ? props.inset_parent.IsValid() : true);
        },
        get children() {
          const _el$111 = createElement("Label", {
            id: "Total",
            html: true,
            get text() {
              return getTotalStr();
            }
          }, null);
          effect(_$p => setProp(_el$111, "text", getTotalStr(), _$p));
          return _el$111;
        }
      }), null);
      effect(_p$ => {
        const _v$42 = classNames('EquipTooltipAffixRowBase', {
            'Red': getIsRed()
          }),
          _v$43 = 'Rarity_' + getLevelRarity(),
          _v$44 = getLevel(),
          _v$45 = '#' + props.affix.a;
        _v$42 !== _p$._v$42 && (_p$._v$42 = setProp(_el$105, "class", _v$42, _p$._v$42));
        _v$43 !== _p$._v$43 && (_p$._v$43 = setProp(_el$106, "class", _v$43, _p$._v$43));
        _v$44 !== _p$._v$44 && (_p$._v$44 = setProp(_el$106, "text", _v$44, _p$._v$44));
        _v$45 !== _p$._v$45 && (_p$._v$45 = setProp(_el$107, "text", _v$45, _p$._v$45));
        return _p$;
      }, {
        _v$42: undefined,
        _v$43: undefined,
        _v$44: undefined,
        _v$45: undefined
      });
      return _el$105;
    })();
  }
  function EquipTooltipRsncRow(props) {
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getTitle = () => '#equip_rsnc_' + props.affix.a;
    const getValues = tAffix => {
      var _a, _b, _c, _d, _e;
      const tKv = (_a = KvByID(tAffix.a)) !== null && _a !== void 0 ? _a : {};
      const tValues = Object.assign({}, (_b = tKv['AbilityValues']) !== null && _b !== void 0 ? _b : {});
      const iMax = (_c = tValues['max']) !== null && _c !== void 0 ? _c : 0;
      const iMin = (_d = tValues['min']) !== null && _d !== void 0 ? _d : 0;
      let val = iMin + (iMax - iMin) * tAffix.v * 0.01;
      const ratio = (_e = tValues['ratio']) !== null && _e !== void 0 ? _e : 1;
      if (ratio) {
        val = Number(val.toFixed(ratio));
      }
      tValues['min-max'] = val;
      tValues['min'] = iMin;
      tValues['max'] = NumFixRatio(iMin + (iMax - iMin) * getRedLimit() * 0.01, ratio);
      return tValues;
    };
    return (() => {
      const _el$112 = createElement("Panel", {
          get id() {
            return 'EquipTooltipRsncRow_' + props.affix.idx;
          },
          get ["class"]() {
            return classNames('EquipTooltipRsncRow', {
              'Red': getIsRed()
            });
          },
          get onload() {
            return props.onload;
          },
          hittest: false
        }, null),
        _el$113 = createElement("Label", {
          id: "Description",
          get text() {
            return '[' + $.Localize(getTitle()) + '] ' + ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
          },
          html: true
        }, _el$112);
      effect(_p$ => {
        const _v$46 = 'EquipTooltipRsncRow_' + props.affix.idx,
          _v$47 = classNames('EquipTooltipRsncRow', {
            'Red': getIsRed()
          }),
          _v$48 = props.onload,
          _v$49 = '[' + $.Localize(getTitle()) + '] ' + ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
        _v$46 !== _p$._v$46 && (_p$._v$46 = setProp(_el$112, "id", _v$46, _p$._v$46));
        _v$47 !== _p$._v$47 && (_p$._v$47 = setProp(_el$112, "class", _v$47, _p$._v$47));
        _v$48 !== _p$._v$48 && (_p$._v$48 = setProp(_el$112, "onload", _v$48, _p$._v$48));
        _v$49 !== _p$._v$49 && (_p$._v$49 = setProp(_el$113, "text", _v$49, _p$._v$49));
        return _p$;
      }, {
        _v$46: undefined,
        _v$47: undefined,
        _v$48: undefined,
        _v$49: undefined
      });
      return _el$112;
    })();
  }
  function ExtractInfoTooltip(props) {
    return (() => {
      const _el$114 = createElement("Panel", {
        id: "ExtractInfoTooltip",
        hittest: false
      }, null);
      insert(_el$114, createComponent(ExtractTooltipHeader, props), null);
      insert(_el$114, createComponent(ExtractTooltipAffix, props), null);
      return _el$114;
    })();
  }
  function ExtractTooltipHeader(props) {
    const getData = () => props.data;
    const getPart = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    };
    const getIsSpecial = createMemo(() => {
      var _a;
      return (((_a = getData()) === null || _a === void 0 ? void 0 : _a.special) || 0) > 0;
    });
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) !== null && _b !== void 0 ? _b : 1;
    };
    const getName = () => {
      if (getIsSpecial()) {
        return `#equipextractinfotitle_6`;
      }
      return `#equipextractinfotitle_${getPart()}_${getRarity()}`;
    };
    const getBind = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.bind) || 0;
    };
    const getScore = () => {
      var _a, _b;
      if (((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.score) !== null && _b !== void 0 ? _b : 0) > 0) {
        if (getter_bDebugMode()) {
          return `${getData().score}(UI=${CalcEquipScore(getData())})`;
        } else {
          return getData().score;
        }
      }
      return CalcEquipScore(getData());
    };
    return (() => {
      const _el$115 = createElement("Panel", {
          id: "ExtractTooltipHeader",
          get ["class"]() {
            return classNames('TooltipHeader', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$116 = createElement("Panel", {
          "class": "BGPanel"
        }, _el$115);
        createElement("Panel", {
          "class": "BG2"
        }, _el$116);
        const _el$118 = createElement("Panel", {
          "class": "Image"
        }, _el$115),
        _el$119 = createElement("Panel", {
          "class": "RightTopBox"
        }, _el$115),
        _el$121 = createElement("Panel", {
          "class": "Score"
        }, _el$115),
        _el$122 = createElement("Label", {
          get text() {
            return getScore();
          }
        }, _el$121);
      insert(_el$118, createComponent(PackExtractItem, {
        data: getData
      }));
      insert(_el$115, createComponent(Yzy_Label, {
        "class": "Name",
        get rarity() {
          return getRarity();
        },
        get text() {
          return getName();
        }
      }), _el$119);
      insert(_el$119, createComponent(Show, {
        get when() {
          return getBind() > 0;
        },
        get children() {
          const _el$120 = createElement("Label", {
            "class": "Bind",
            get text() {
              return ReplaceTextVariable('#EquipBind', {
                'val': getBind()
              });
            },
            html: true
          }, null);
          effect(_$p => setProp(_el$120, "text", ReplaceTextVariable('#EquipBind', {
            'val': getBind()
          }), _$p));
          return _el$120;
        }
      }));
      insert(_el$121, createComponent(Yzy_Icon, {
        type: "icon_score"
      }), _el$122);
      effect(_p$ => {
        const _v$50 = classNames('TooltipHeader', `Rarity_${getRarity()}`),
          _v$51 = getScore();
        _v$50 !== _p$._v$50 && (_p$._v$50 = setProp(_el$115, "class", _v$50, _p$._v$50));
        _v$51 !== _p$._v$51 && (_p$._v$51 = setProp(_el$122, "text", _v$51, _p$._v$51));
        return _p$;
      }, {
        _v$50: undefined,
        _v$51: undefined
      });
      return _el$115;
    })();
  }
  function ExtractTooltipAffix(props) {
    let ref;
    const getData = () => props.data;
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) !== null && _b !== void 0 ? _b : 1;
    };
    const getAffix = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) || [];
    };
    const getAffixGroup = createMemo(() => {
      const tAffixGroup = {};
      for (const affix of getAffix()) {
        if (affix.c < 3) {
          if (tAffixGroup[affix.c] == undefined) {
            tAffixGroup[affix.c] = [];
          }
          tAffixGroup[affix.c].push(affix);
        }
      }
      return tAffixGroup;
    });
    const getRsnc = createMemo(() => {
      var _a;
      const tAffix = [];
      if ((_a = props.data) === null || _a === void 0 ? void 0 : _a.affix) {
        for (const affix of props.data.affix) {
          if (affix.c == 3) {
            tAffix.push(affix);
          }
        }
      }
      return tAffix;
    });
    return (() => {
      const _el$123 = createElement("Panel", {
        id: "ExtractTooltipAffix",
        get ["class"]() {
          return classNames('TooltipAffix', `Rarity_${getRarity()}`);
        }
      }, null);
      const _ref$4 = ref;
      typeof _ref$4 === "function" ? use(_ref$4, _el$123) : ref = _el$123;
      insert(_el$123, createComponent(Index, {
        get each() {
          return Object.entries(getAffixGroup());
        },
        children: (getValue, i) => {
          const getAffixType = () => getValue()[0];
          const getAffix = () => getValue()[1];
          return (() => {
            const _el$131 = createElement("Panel", {
                get id() {
                  return 'Part_' + getAffixType();
                },
                "class": "AffixGroup"
              }, null),
              _el$132 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, _el$131);
              createElement("Panel", {
                "class": "BG"
              }, _el$132);
              createElement("Panel", {
                "class": "Line"
              }, _el$132);
              const _el$135 = createElement("Label", {
                get text() {
                  return `#AffixTitle_${getAffixType()}`;
                },
                hittest: false
              }, _el$132),
              _el$136 = createElement("Panel", {
                "class": "Body"
              }, _el$131);
            insert(_el$136, createComponent(Index, {
              get each() {
                return getAffix().sort((a, b) => b.l - a.l);
              },
              children: (getAffix, i) => {
                var _a, _b;
                return createComponent(ExtractTooltipAffixRow, {
                  get affix() {
                    return getAffix();
                  },
                  get className() {
                    return classNames({
                      'ExtractEnhance': ((_b = (_a = props.extract_enhance_result) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : -1) == getAffix().idx
                    });
                  },
                  onload: p => {
                    if (props.extract_spawned_affix_show && p.BCanSeeInParentScroll()) {
                      Game.EmitSound('EquipMix_AffixReplace');
                      ScreenPanel.CreateOnPanel({
                        'pTarget': p,
                        'content': () => createElement("DOTAParticleScenePanel", {
                          "class": "Equip_AffixFlashFX",
                          hittest: false,
                          particleonly: true,
                          particleName: "particles/ui/strip_flash.vpcf",
                          cameraOrigin: "0 0 300",
                          lookAt: "0 0 0",
                          fov: 60
                        }, null),
                        'fDuration': 1.5
                      });
                    }
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$52 = 'Part_' + getAffixType(),
                _v$53 = `#AffixTitle_${getAffixType()}`;
              _v$52 !== _p$._v$52 && (_p$._v$52 = setProp(_el$131, "id", _v$52, _p$._v$52));
              _v$53 !== _p$._v$53 && (_p$._v$53 = setProp(_el$135, "text", _v$53, _p$._v$53));
              return _p$;
            }, {
              _v$52: undefined,
              _v$53: undefined
            });
            return _el$131;
          })();
        }
      }), null);
      insert(_el$123, createComponent(Show, {
        get when() {
          return getRsnc().length > 0;
        },
        get children() {
          const _el$124 = createElement("Panel", {
              id: "Part3",
              "class": "AffixGroup"
            }, null),
            _el$125 = createElement("Panel", {
              "class": "Title",
              hittest: false
            }, _el$124);
            createElement("Panel", {
              "class": "BG"
            }, _el$125);
            createElement("Panel", {
              "class": "Line"
            }, _el$125);
            createElement("Label", {
              text: '#AffixTitle_3',
              hittest: false
            }, _el$125);
            const _el$129 = createElement("Panel", {
              "class": "Body"
            }, _el$124);
          insert(_el$129, createComponent(Index, {
            get each() {
              return getRsnc().sort((a, b) => a.idx - b.idx);
            },
            children: affix => {
              return createComponent(ExtractTooltipRsncRow, {
                get affix() {
                  return affix();
                }
              });
            }
          }));
          return _el$124;
        }
      }), null);
      insert(_el$123, createComponent(Show, {
        get when() {
          return getAffix().length <= 0;
        },
        get children() {
          return createElement("Label", {
            id: "UnknownAffix",
            hittest: false,
            text: '???'
          }, null);
        }
      }), null);
      effect(_$p => setProp(_el$123, "class", classNames('TooltipAffix', `Rarity_${getRarity()}`), _$p));
      return _el$123;
    })();
  }
  function ExtractTooltipAffixRow(props) {
    const getAffix = () => props.affix;
    const getIdx = () => getAffix().idx;
    return (() => {
      const _el$138 = createElement("Panel", {
          get onload() {
            return props.onload;
          },
          get id() {
            return "ExtractTooltipAffixRow_" + getIdx();
          },
          get ["class"]() {
            return classNames("ExtractTooltipAffixRow", "ExtractTooltipAffixRow_" + getIdx(), props.className);
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$138);
      insert(_el$138, createComponent(ExtractTooltipAffixRowBase, props), null);
      effect(_p$ => {
        const _v$54 = props.onload,
          _v$55 = "ExtractTooltipAffixRow_" + getIdx(),
          _v$56 = classNames("ExtractTooltipAffixRow", "ExtractTooltipAffixRow_" + getIdx(), props.className);
        _v$54 !== _p$._v$54 && (_p$._v$54 = setProp(_el$138, "onload", _v$54, _p$._v$54));
        _v$55 !== _p$._v$55 && (_p$._v$55 = setProp(_el$138, "id", _v$55, _p$._v$55));
        _v$56 !== _p$._v$56 && (_p$._v$56 = setProp(_el$138, "class", _v$56, _p$._v$56));
        return _p$;
      }, {
        _v$54: undefined,
        _v$55: undefined,
        _v$56: undefined
      });
      return _el$138;
    })();
  }
  function ExtractTooltipAffixRowBase(props) {
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getAffix = () => props.affix;
    const getLevel = () => getAffix().l || 1;
    const getEffect = createMemo(() => {
      var _a, _b;
      const cfg = (_b = (_a = CfgGetter_equipment_effect()) === null || _a === void 0 ? void 0 : _a[getLevel()]) === null || _b === void 0 ? void 0 : _b[props.affix.a];
      return cfg || {
        value_down: 0,
        value_up: 0,
        ratio: 0
      };
    });
    const getVal = () => ValuePct(props.affix.v, getEffect().value_down, getEffect().value_up, getEffect().ratio);
    const getValStr = () => AttrVal2Str(props.affix.a, getVal(), getEffect().ratio);
    const getRangeStr = () => ValRangeStr(props.affix.a, getEffect().value_down, NumFixRatio(getEffect().value_down + (getEffect().value_up - getEffect().value_down) * getRedLimit() * 0.01, getEffect().ratio));
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getLevelRarity = () => {
      const cfg = {
        [1]: 1,
        [6]: 2,
        [7]: 3,
        [8]: 4,
        [9]: 5,
        [10]: 6
      };
      let iRarity = 1;
      for (const [lvl, rarity] of Object.entries(cfg).sort((a, b) => Number(a[0]) - Number(b[0]))) {
        if (getLevel() < Number(lvl)) break;
        iRarity = Number(rarity);
      }
      return iRarity;
    };
    return (() => {
      const _el$140 = createElement("Panel", {
          get ["class"]() {
            return classNames('ExtractTooltipAffixRowBase', {
              'Red': getIsRed()
            });
          },
          hittest: false
        }, null),
        _el$141 = createElement("Label", {
          id: "Level",
          get ["class"]() {
            return 'Rarity_' + getLevelRarity();
          },
          get text() {
            return getLevel();
          }
        }, _el$140),
        _el$142 = createElement("Label", {
          id: "Affix",
          html: true,
          get text() {
            return '#' + props.affix.a;
          }
        }, _el$140),
        _el$143 = createElement("Label", {
          id: "Value",
          html: true,
          get text() {
            return getValStr();
          }
        }, _el$140),
        _el$144 = createElement("Label", {
          id: "Range",
          html: true,
          get text() {
            return getRangeStr();
          }
        }, _el$140);
      effect(_p$ => {
        const _v$57 = classNames('ExtractTooltipAffixRowBase', {
            'Red': getIsRed()
          }),
          _v$58 = 'Rarity_' + getLevelRarity(),
          _v$59 = getLevel(),
          _v$60 = '#' + props.affix.a,
          _v$61 = getValStr(),
          _v$62 = getRangeStr();
        _v$57 !== _p$._v$57 && (_p$._v$57 = setProp(_el$140, "class", _v$57, _p$._v$57));
        _v$58 !== _p$._v$58 && (_p$._v$58 = setProp(_el$141, "class", _v$58, _p$._v$58));
        _v$59 !== _p$._v$59 && (_p$._v$59 = setProp(_el$141, "text", _v$59, _p$._v$59));
        _v$60 !== _p$._v$60 && (_p$._v$60 = setProp(_el$142, "text", _v$60, _p$._v$60));
        _v$61 !== _p$._v$61 && (_p$._v$61 = setProp(_el$143, "text", _v$61, _p$._v$61));
        _v$62 !== _p$._v$62 && (_p$._v$62 = setProp(_el$144, "text", _v$62, _p$._v$62));
        return _p$;
      }, {
        _v$57: undefined,
        _v$58: undefined,
        _v$59: undefined,
        _v$60: undefined,
        _v$61: undefined,
        _v$62: undefined
      });
      return _el$140;
    })();
  }
  function ExtractTooltipRsncRow(props) {
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getTitle = () => '#equip_rsnc_' + props.affix.a;
    const getValues = tAffix => {
      var _a, _b, _c, _d, _e;
      const tKv = (_a = KvByID(tAffix.a)) !== null && _a !== void 0 ? _a : {};
      const tValues = Object.assign({}, (_b = tKv['AbilityValues']) !== null && _b !== void 0 ? _b : {});
      const iMax = (_c = tValues['max']) !== null && _c !== void 0 ? _c : 0;
      const iMin = (_d = tValues['min']) !== null && _d !== void 0 ? _d : 0;
      let val = iMin + (iMax - iMin) * tAffix.v * 0.01;
      const ratio = (_e = tValues['ratio']) !== null && _e !== void 0 ? _e : 1;
      if (ratio) {
        val = Number(val.toFixed(ratio));
      }
      tValues['min-max'] = val;
      tValues['min'] = iMin;
      tValues['max'] = NumFixRatio(iMin + (iMax - iMin) * getRedLimit() * 0.01, ratio);
      return tValues;
    };
    return (() => {
      const _el$145 = createElement("Panel", {
          get id() {
            return 'ExtractTooltipRsncRow_' + props.affix.idx;
          },
          get ["class"]() {
            return classNames('ExtractTooltipRsncRow', {
              'Red': getIsRed()
            });
          },
          get onload() {
            return props.onload;
          },
          hittest: false
        }, null),
        _el$146 = createElement("Label", {
          id: "Description",
          get text() {
            return '[' + $.Localize(getTitle()) + '] ' + ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
          },
          html: true
        }, _el$145);
      effect(_p$ => {
        const _v$63 = 'ExtractTooltipRsncRow_' + props.affix.idx,
          _v$64 = classNames('ExtractTooltipRsncRow', {
            'Red': getIsRed()
          }),
          _v$65 = props.onload,
          _v$66 = '[' + $.Localize(getTitle()) + '] ' + ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
        _v$63 !== _p$._v$63 && (_p$._v$63 = setProp(_el$145, "id", _v$63, _p$._v$63));
        _v$64 !== _p$._v$64 && (_p$._v$64 = setProp(_el$145, "class", _v$64, _p$._v$64));
        _v$65 !== _p$._v$65 && (_p$._v$65 = setProp(_el$145, "onload", _v$65, _p$._v$65));
        _v$66 !== _p$._v$66 && (_p$._v$66 = setProp(_el$146, "text", _v$66, _p$._v$66));
        return _p$;
      }, {
        _v$63: undefined,
        _v$64: undefined,
        _v$65: undefined,
        _v$66: undefined
      });
      return _el$145;
    })();
  }
  function HolyInfoTooltip(props) {
    return (() => {
      const _el$147 = createElement("Panel", {
        id: "HolyInfoTooltip",
        hittest: false
      }, null);
      insert(_el$147, createComponent(HolyTooltipHeader, {
        get data() {
          return props.data;
        }
      }), null);
      insert(_el$147, createComponent(HolyTooltipAffix, {
        get data() {
          return props.data;
        },
        get wear_suit() {
          return props.wear_suit;
        }
      }), null);
      return _el$147;
    })();
  }
  function HolyTooltipSuit(props) {
    const getSuit = () => props.data.suit;
    const getSuitCountData = createMemo(() => {
      var _a, _b;
      const tSuitCountData = [];
      const iSuit = getSuit();
      if (!iSuit) {
        return [];
      }
      const tSuitCfg = (_b = (_a = CfgGetter_holy_suit()) === null || _a === void 0 ? void 0 : _a[iSuit]) !== null && _b !== void 0 ? _b : {
        count: '',
        effect: ''
      };
      const tSuitEffect = tSuitCfg.effect.split('|');
      tSuitCfg.count.split('|').forEach((count, index) => {
        const iCount = Number(count);
        const iEffect = Number(tSuitEffect[index]);
        tSuitCountData.push({
          suitNum: iCount,
          effect: iEffect
        });
      });
      return tSuitCountData.sort((a, b) => a.suitNum - b.suitNum);
    });
    const getHasSuitCount = () => {
      var _a, _b, _c, _d;
      return (_d = ((_b = (_a = props.wear_suit) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : {})[(_c = getSuit()) !== null && _c !== void 0 ? _c : 0]) !== null && _d !== void 0 ? _d : 0;
    };
    return (() => {
      const _el$148 = createElement("Panel", {
          id: "HolyTooltipSuit",
          "class": "HolyTooltipSuit AffixGroup"
        }, null),
        _el$149 = createElement("Panel", {
          "class": "Title",
          hittest: false
        }, _el$148);
        createElement("Panel", {
          "class": "BG"
        }, _el$149);
        createElement("Panel", {
          "class": "Line"
        }, _el$149);
        createElement("Label", {
          "class": "Title",
          text: '#HolySuitTitle',
          hittest: false
        }, _el$149);
        const _el$153 = createElement("Label", {
          "class": "SuitEffect",
          html: true,
          get text() {
            return `#${getSuit()}`;
          }
        }, _el$148),
        _el$154 = createElement("Panel", {
          "class": "Body"
        }, _el$148);
      insert(_el$154, createComponent(Index, {
        get each() {
          return getSuitCountData();
        },
        children: suitCfg => {
          return (() => {
            const _el$155 = createElement("Panel", {
                "class": "SuitItem"
              }, null),
              _el$156 = createElement("Label", {
                "class": "SuitNum",
                get text() {
                  return `${getHasSuitCount()}/${suitCfg().suitNum}`;
                }
              }, _el$155);
            insert(_el$155, createComponent(Yzy_Attribute, {
              get id() {
                return suitCfg().effect.toString();
              },
              val: 1
            }), null);
            effect(_p$ => {
              const _v$69 = {
                  'NotActive': getHasSuitCount() < suitCfg().suitNum
                },
                _v$70 = `${getHasSuitCount()}/${suitCfg().suitNum}`;
              _v$69 !== _p$._v$69 && (_p$._v$69 = setProp(_el$155, "classList", _v$69, _p$._v$69));
              _v$70 !== _p$._v$70 && (_p$._v$70 = setProp(_el$156, "text", _v$70, _p$._v$70));
              return _p$;
            }, {
              _v$69: undefined,
              _v$70: undefined
            });
            return _el$155;
          })();
        }
      }));
      effect(_p$ => {
        const _v$67 = {
            'Active': Object.values(getSuitCountData()).length > 0
          },
          _v$68 = `#${getSuit()}`;
        _v$67 !== _p$._v$67 && (_p$._v$67 = setProp(_el$148, "classList", _v$67, _p$._v$67));
        _v$68 !== _p$._v$68 && (_p$._v$68 = setProp(_el$153, "text", _v$68, _p$._v$68));
        return _p$;
      }, {
        _v$67: undefined,
        _v$68: undefined
      });
      return _el$148;
    })();
  }
  function HolyTooltipHeader(props) {
    const getData = () => props.data;
    const getPart = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    };
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.rarity) !== null && _b !== void 0 ? _b : 1;
    };
    const getClass = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.class) !== null && _b !== void 0 ? _b : 1;
    };
    const getBind = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.bind) || 0;
    };
    const getScore = () => {
      var _a, _b;
      if (((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.score) !== null && _b !== void 0 ? _b : 0) > 0) {
        if (getter_bDebugMode()) {
          return `${getData().score}(UI=${CalcHolyScore(getData())})`;
        } else {
          return getData().score;
        }
      }
      return CalcHolyScore(getData());
    };
    const getTaiguCount = () => {
      var _a, _b, _c;
      return (_c = (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) === null || _b === void 0 ? void 0 : _b.filter(affix => affix.taigu).length) !== null && _c !== void 0 ? _c : 0;
    };
    const getTransLock = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.trans_lock) !== null && _b !== void 0 ? _b : false;
    };
    const getBaseStrengthen = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.strength) !== null && _b !== void 0 ? _b : 0;
    };
    const getStrengthenMax = () => {
      var _a, _b;
      return (_b = (_a = GetHolySetting(getRarity(), getClass())) === null || _a === void 0 ? void 0 : _a['strengthen_max']) !== null && _b !== void 0 ? _b : 0;
    };
    const getAttr10600527Val = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
      let bHas527 = false;
      for (const affix of (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) !== null && _b !== void 0 ? _b : []) {
        if (affix.a == 10600527) {
          bHas527 = true;
          break;
        }
      }
      if (!bHas527) {
        return 0;
      }
      let iAttr10600527Val = 0;
      const tCfgSettingCommon = (_c = CfgGetter_settings_common()) !== null && _c !== void 0 ? _c : {};
      for (const affix of (_e = (_d = getData()) === null || _d === void 0 ? void 0 : _d.affix) !== null && _e !== void 0 ? _e : []) {
        if (affix.a == 10600527) {
          let iTotalVal = 0;
          const iTaiguPct = (_f = tCfgSettingCommon['holy_taigu_affix_pct']) !== null && _f !== void 0 ? _f : 0;
          const iBaseVal = GetHolyAffixBaseVal(affix, getClass(), iTaiguPct);
          const iStrengthen = ((_g = affix.trans) === null || _g === void 0 ? void 0 : _g.includes(3)) ? (_h = affix.strength) !== null && _h !== void 0 ? _h : 0 : getBaseStrengthen();
          iTotalVal += iBaseVal;
          let iStrengthenVal = 0;
          if (iStrengthen > 0) {
            const iCfgStrengthenPct = (_j = tCfgSettingCommon['holy_strengthen_pct']) !== null && _j !== void 0 ? _j : 0;
            iStrengthenVal = iBaseVal * (iCfgStrengthenPct * (iStrengthen / getStrengthenMax()) * 0.01);
          }
          iTotalVal += iStrengthenVal;
          let iFinalVal = 0;
          if (affix.fin) {
            const iCfgStrengthenFinalPct = (_k = tCfgSettingCommon['holy_strengthen_final_pct']) !== null && _k !== void 0 ? _k : 0;
            iFinalVal = iBaseVal * (iCfgStrengthenFinalPct * 0.01);
          }
          iTotalVal += iFinalVal;
          iAttr10600527Val += iTotalVal;
        }
      }
      return Math.floor(iAttr10600527Val);
    };
    const getStrengthen = () => getBaseStrengthen() + getAttr10600527Val();
    return (() => {
      const _el$157 = createElement("Panel", {
          id: "HolyTooltipHeader",
          get ["class"]() {
            return classNames('TooltipHeader', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$158 = createElement("Panel", {
          "class": "BGPanel"
        }, _el$157);
        createElement("Panel", {
          "class": "BG2"
        }, _el$158);
        const _el$160 = createElement("Panel", {
          "class": "Image"
        }, _el$157),
        _el$161 = createElement("Panel", {
          "class": "Name"
        }, _el$157),
        _el$162 = createElement("Panel", {
          "class": "Taigu"
        }, _el$161);
        createElement("Panel", {
          "class": "Line"
        }, _el$157);
        const _el$164 = createElement("Panel", {
          "class": "RightTopBox"
        }, _el$157),
        _el$166 = createElement("Label", {
          "class": "Class",
          get text() {
            return ReplaceTextVariable('#HolyClassValue', getClass());
          },
          html: true
        }, _el$157),
        _el$167 = createElement("Label", {
          "class": "Strength",
          get text() {
            return ReplaceTextVariable('#HolyStrengthValue', `${getAttr10600527Val() > 0 ? getBaseStrengthen() + '+' + getAttr10600527Val() : getStrengthen()}`);
          },
          html: true
        }, _el$157),
        _el$168 = createElement("Panel", {
          "class": "TransLock"
        }, _el$157);
        createElement("Label", {
          text: '#HolyTransLock',
          html: true
        }, _el$168);
        const _el$170 = createElement("Panel", {
          "class": "Score"
        }, _el$157),
        _el$171 = createElement("Label", {
          get text() {
            return getScore();
          }
        }, _el$170);
      insert(_el$160, createComponent(PackHolyItem, {
        data: () => getData(),
        noTooltip: true
      }));
      insert(_el$161, createComponent(Yzy_Label, {
        "class": "Name",
        get rarity() {
          return getRarity();
        },
        get text() {
          return `#HolyInfoTitle_${getPart()}_${getRarity()}`;
        }
      }), _el$162);
      insert(_el$162, createComponent(Index, {
        get each() {
          return Array.from({
            length: getTaiguCount()
          });
        },
        children: (_, i) => {
          return createElement("Panel", {
            "class": "TaiguIcon"
          }, null);
        }
      }));
      insert(_el$164, createComponent(Show, {
        get when() {
          return getBind() > 0;
        },
        get children() {
          const _el$165 = createElement("Label", {
            "class": "Bind",
            get text() {
              return ReplaceTextVariable('#EquipBind', {
                'val': getBind()
              });
            },
            html: true
          }, null);
          effect(_$p => setProp(_el$165, "text", ReplaceTextVariable('#EquipBind', {
            'val': getBind()
          }), _$p));
          return _el$165;
        }
      }));
      insert(_el$170, createComponent(Yzy_Icon, {
        type: "icon_score"
      }), _el$171);
      effect(_p$ => {
        const _v$71 = classNames('TooltipHeader', `Rarity_${getRarity()}`),
          _v$72 = classNames('Rarity_' + getRarity()),
          _v$73 = ReplaceTextVariable('#HolyClassValue', getClass()),
          _v$74 = {
            ['show']: getStrengthen() > 0
          },
          _v$75 = ReplaceTextVariable('#HolyStrengthValue', `${getAttr10600527Val() > 0 ? getBaseStrengthen() + '+' + getAttr10600527Val() : getStrengthen()}`),
          _v$76 = {
            'Active': getTransLock()
          },
          _v$77 = getScore();
        _v$71 !== _p$._v$71 && (_p$._v$71 = setProp(_el$157, "class", _v$71, _p$._v$71));
        _v$72 !== _p$._v$72 && (_p$._v$72 = setProp(_el$161, "className", _v$72, _p$._v$72));
        _v$73 !== _p$._v$73 && (_p$._v$73 = setProp(_el$166, "text", _v$73, _p$._v$73));
        _v$74 !== _p$._v$74 && (_p$._v$74 = setProp(_el$167, "classList", _v$74, _p$._v$74));
        _v$75 !== _p$._v$75 && (_p$._v$75 = setProp(_el$167, "text", _v$75, _p$._v$75));
        _v$76 !== _p$._v$76 && (_p$._v$76 = setProp(_el$168, "classList", _v$76, _p$._v$76));
        _v$77 !== _p$._v$77 && (_p$._v$77 = setProp(_el$171, "text", _v$77, _p$._v$77));
        return _p$;
      }, {
        _v$71: undefined,
        _v$72: undefined,
        _v$73: undefined,
        _v$74: undefined,
        _v$75: undefined,
        _v$76: undefined,
        _v$77: undefined
      });
      return _el$157;
    })();
  }
  function HolyTooltipAffix(props) {
    const getData = () => props.data;
    const getRarity = () => {
      var _a;
      return (_a = getData().rarity) !== null && _a !== void 0 ? _a : 1;
    };
    const getClass = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.class) !== null && _b !== void 0 ? _b : 1;
    };
    const getBaseStrengthen = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.strength) !== null && _b !== void 0 ? _b : 0;
    };
    const getStrengthenMax = () => {
      var _a, _b;
      return (_b = (_a = GetHolySetting(getRarity(), getClass())) === null || _a === void 0 ? void 0 : _a['strengthen_max']) !== null && _b !== void 0 ? _b : 0;
    };
    const getAttr10600527Val = () => {
      var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k;
      let bHas527 = false;
      for (const affix of (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) !== null && _b !== void 0 ? _b : []) {
        if (affix.a == 10600527) {
          bHas527 = true;
          break;
        }
      }
      if (!bHas527) {
        return 0;
      }
      let iAttr10600527Val = 0;
      const tCfgSettingCommon = (_c = CfgGetter_settings_common()) !== null && _c !== void 0 ? _c : {};
      for (const affix of (_e = (_d = getData()) === null || _d === void 0 ? void 0 : _d.affix) !== null && _e !== void 0 ? _e : []) {
        if (affix.a == 10600527) {
          let iTotalVal = 0;
          const iTaiguPct = (_f = tCfgSettingCommon['holy_taigu_affix_pct']) !== null && _f !== void 0 ? _f : 0;
          const iBaseVal = GetHolyAffixBaseVal(affix, getClass(), iTaiguPct);
          const iStrengthen = ((_g = affix.trans) === null || _g === void 0 ? void 0 : _g.includes(3)) ? (_h = affix.strength) !== null && _h !== void 0 ? _h : 0 : getBaseStrengthen();
          iTotalVal += iBaseVal;
          let iStrengthenVal = 0;
          if (iStrengthen > 0) {
            const iCfgStrengthenPct = (_j = tCfgSettingCommon['holy_strengthen_pct']) !== null && _j !== void 0 ? _j : 0;
            iStrengthenVal = iBaseVal * (iCfgStrengthenPct * (iStrengthen / getStrengthenMax()) * 0.01);
          }
          iTotalVal += iStrengthenVal;
          let iFinalVal = 0;
          if (affix.fin) {
            const iCfgStrengthenFinalPct = (_k = tCfgSettingCommon['holy_strengthen_final_pct']) !== null && _k !== void 0 ? _k : 0;
            iFinalVal = iBaseVal * (iCfgStrengthenFinalPct * 0.01);
          }
          iTotalVal += iFinalVal;
          iAttr10600527Val += iTotalVal;
        }
      }
      return Math.floor(iAttr10600527Val);
    };
    const getStrengthen = () => getBaseStrengthen() + getAttr10600527Val();
    const getAffix = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) || [];
    };
    const getAffixGroup = createMemo(() => {
      const tAffixGroup = {};
      for (const affix of getAffix()) {
        if (props.onlyPart2 ? affix.c == 2 : true) {
          if (tAffixGroup[affix.c] == undefined) {
            tAffixGroup[affix.c] = [];
          }
          tAffixGroup[affix.c].push(affix);
        }
      }
      return tAffixGroup;
    });
    return (() => {
      const _el$173 = createElement("Panel", {
        id: "HolyTooltipAffix",
        get ["class"]() {
          return classNames('TooltipAffix', `Rarity_${getRarity()}`);
        }
      }, null);
      insert(_el$173, createComponent(Index, {
        get each() {
          return Object.entries(getAffixGroup());
        },
        children: getValue => {
          const getAffixType = () => getValue()[0];
          const getAffixList = () => getValue()[1];
          return (() => {
            const _el$174 = createElement("Panel", {
                get id() {
                  return 'Part_' + getAffixType();
                },
                "class": "AffixGroup"
              }, null),
              _el$175 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, _el$174);
              createElement("Panel", {
                "class": "BG"
              }, _el$175);
              createElement("Panel", {
                "class": "Line"
              }, _el$175);
              const _el$178 = createElement("Label", {
                get text() {
                  return `#AffixTitle_${getAffixType()}`;
                },
                hittest: false
              }, _el$175),
              _el$179 = createElement("Panel", {
                "class": "Body"
              }, _el$174);
            insert(_el$179, createComponent(Index, {
              get each() {
                return getAffixList().sort((a, b) => b.l - a.l);
              },
              children: getAffix => {
                var _a, _b, _c, _d;
                return createComponent(HolyTooltipAffixRow, {
                  get affix() {
                    return getAffix();
                  },
                  get iClass() {
                    return getClass();
                  },
                  get strengthen() {
                    return getStrengthen();
                  },
                  get strengthenMax() {
                    return getStrengthenMax();
                  },
                  get operate_state() {
                    return props.operate_state;
                  },
                  get holy_recast_lock_count() {
                    return props.holy_recast_lock_count;
                  },
                  get holy_recast_lock_idx() {
                    return props.holy_recast_lock_idx;
                  },
                  get className() {
                    return classNames({
                      'HolyRecast': ((_b = (_a = props.holy_recast_result) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : -1) == getAffix().a,
                      'HolyTrans': ((_d = (_c = props.holy_trans_result) === null || _c === void 0 ? void 0 : _c.call(props)) !== null && _d !== void 0 ? _d : -1) == getAffix().a
                    });
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$78 = 'Part_' + getAffixType(),
                _v$79 = `#AffixTitle_${getAffixType()}`;
              _v$78 !== _p$._v$78 && (_p$._v$78 = setProp(_el$174, "id", _v$78, _p$._v$78));
              _v$79 !== _p$._v$79 && (_p$._v$79 = setProp(_el$178, "text", _v$79, _p$._v$79));
              return _p$;
            }, {
              _v$78: undefined,
              _v$79: undefined
            });
            return _el$174;
          })();
        }
      }), null);
      insert(_el$173, (() => {
        const _c$ = memo(() => !!!props.onlyPart2);
        return () => _c$() && createComponent(HolyTooltipSuit, {
          get data() {
            return props.data;
          },
          get wear_suit() {
            return props.wear_suit;
          }
        });
      })(), null);
      effect(_$p => setProp(_el$173, "class", classNames('TooltipAffix', `Rarity_${getRarity()}`), _$p));
      return _el$173;
    })();
  }
  function HolyTooltipAffixRow(props) {
    const getIdx = () => props.affix.idx;
    const getRecastLockMaxCount = () => {
      var _a, _b;
      return (_b = (_a = props.holy_recast_lock_count) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0;
    };
    const getIsRecastLock = () => props.holy_recast_lock_idx != undefined && getRecastLockMaxCount() > 0;
    const getIsAffixUnselectable = () => {
      var _a;
      return ((_a = props.affix.trans) !== null && _a !== void 0 ? _a : []).length > 0 || !!props.affix.fin;
    };
    return (() => {
      const _el$180 = createElement("Panel", {
          get id() {
            return "HolyTooltipAffixRow_" + getIdx();
          },
          get ["class"]() {
            return classNames("HolyTooltipAffixRow", props.className, {
              'HasLock': getIsRecastLock()
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$180);
      insert(_el$180, createComponent(Show, {
        get when() {
          return getIsRecastLock();
        },
        children: () => {
          var _a, _b;
          if (props.holy_recast_lock_idx == undefined) return [];
          let ref;
          const [getLockIdx, setLockIdx] = props.holy_recast_lock_idx;
          const getIsLock = () => getLockIdx().includes(props.affix.idx);
          const getIsDisableSelect = () => getIsAffixUnselectable() || getLockIdx().length >= getRecastLockMaxCount() && !getIsLock();
          createEffect(() => {
            if (ref) {
              ref.GetParent().SetHasClass('IsLock', getIsLock());
              if (ref.checked != getIsLock()) {
                ref.checked = getIsLock();
              }
            }
          });
          return (() => {
            const _el$182 = createElement("ToggleButton", {
              get hittest() {
                return ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0;
              },
              "class": "LockToggle",
              get selected() {
                return getIsLock();
              }
            }, null);
            const _ref$5 = ref;
            typeof _ref$5 === "function" ? use(_ref$5, _el$182) : ref = _el$182;
            setProp(_el$182, "onselect", p => {
              if (getIsLock()) return;
              if (getIsDisableSelect()) {
                p.checked = false;
                return;
              }
              const t = [...getLockIdx()];
              t.push(props.affix.idx);
              setLockIdx(t);
            });
            setProp(_el$182, "ondeselect", p => {
              if (getIsAffixUnselectable()) {
                p.checked = true;
                return;
              }
              const t = [...getLockIdx()];
              const i = t.indexOf(props.affix.idx);
              if (i != -1) {
                t.splice(i, 1);
                setLockIdx(t);
              }
            });
            effect(_p$ => {
              const _v$82 = ((_b = (_a = props.operate_state) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) == 0,
                _v$83 = {
                  'DisableSelect': getIsDisableSelect()
                },
                _v$84 = getIsLock();
              _v$82 !== _p$._v$82 && (_p$._v$82 = setProp(_el$182, "hittest", _v$82, _p$._v$82));
              _v$83 !== _p$._v$83 && (_p$._v$83 = setProp(_el$182, "classList", _v$83, _p$._v$83));
              _v$84 !== _p$._v$84 && (_p$._v$84 = setProp(_el$182, "selected", _v$84, _p$._v$84));
              return _p$;
            }, {
              _v$82: undefined,
              _v$83: undefined,
              _v$84: undefined
            });
            return _el$182;
          })();
        }
      }), null);
      insert(_el$180, createComponent(HolyTooltipAffixRowBase, {
        get affix() {
          return props.affix;
        },
        get iClass() {
          return props.iClass;
        },
        get strengthen() {
          return props.strengthen;
        },
        get strengthenMax() {
          return props.strengthenMax;
        }
      }), null);
      effect(_p$ => {
        const _v$80 = "HolyTooltipAffixRow_" + getIdx(),
          _v$81 = classNames("HolyTooltipAffixRow", props.className, {
            'HasLock': getIsRecastLock()
          });
        _v$80 !== _p$._v$80 && (_p$._v$80 = setProp(_el$180, "id", _v$80, _p$._v$80));
        _v$81 !== _p$._v$81 && (_p$._v$81 = setProp(_el$180, "class", _v$81, _p$._v$81));
        return _p$;
      }, {
        _v$80: undefined,
        _v$81: undefined
      });
      return _el$180;
    })();
  }
  function HolyTooltipAffixRowBase(props) {
    const getClass = () => props.iClass;
    const getStrengthen = () => {
      var _a, _b;
      if ((_a = props.affix.trans) === null || _a === void 0 ? void 0 : _a.includes(3)) {
        return (_b = props.affix.strength) !== null && _b !== void 0 ? _b : 0;
      }
      return props.strengthen;
    };
    const getStrengthenMax = () => props.strengthenMax;
    const getAffix = () => props.affix;
    const getState = () => {
      const isTaigu = getAffix().taigu;
      const isFinal = getAffix().fin;
      if (isTaigu && isFinal) {
        return 'taigu_final';
      }
      if (isTaigu) {
        return 'taigu';
      }
      if (isFinal) {
        return 'final';
      }
      return 'normal';
    };
    const getIsFinal = () => {
      var _a;
      return (_a = getAffix().fin) !== null && _a !== void 0 ? _a : false;
    };
    const getIsTaigu = () => {
      var _a;
      return (_a = getAffix().taigu) !== null && _a !== void 0 ? _a : false;
    };
    const getIsTrans = () => {
      var _a;
      return ((_a = getAffix().trans) !== null && _a !== void 0 ? _a : []).length > 0;
    };
    const getEffect = () => {
      return GetHolyAffixEffect(getClass(), getAffix());
    };
    const getBaseVal = createMemo(() => {
      var _a, _b;
      const tCfgSettingCommon = (_a = CfgGetter_settings_common()) !== null && _a !== void 0 ? _a : {};
      let iVal = 0;
      if (getIsTaigu()) {
        iVal = getEffect().value_up * (1 + ((_b = tCfgSettingCommon['holy_taigu_affix_pct']) !== null && _b !== void 0 ? _b : 0) * 0.01);
      } else {
        iVal = ValuePct(getAffix().v, getEffect().value_down, getEffect().value_up, getEffect().ratio);
      }
      return iVal;
    });
    const getStrengthenVal = createMemo(() => {
      var _a, _b;
      const tCfgSettingCommon = (_a = CfgGetter_settings_common()) !== null && _a !== void 0 ? _a : {};
      if (getStrengthen() <= 0) {
        return 0;
      }
      const iCfgStrengthenPct = (_b = tCfgSettingCommon['holy_strengthen_pct']) !== null && _b !== void 0 ? _b : 0;
      let iVal = getBaseVal();
      return iVal * (iCfgStrengthenPct * (getStrengthen() / getStrengthenMax()) * 0.01);
    });
    const getFinalVal = createMemo(() => {
      var _a, _b;
      const tCfgSettingCommon = (_a = CfgGetter_settings_common()) !== null && _a !== void 0 ? _a : {};
      if (!getIsFinal()) {
        return 0;
      }
      const iCfgStrengthenFinalPct = (_b = tCfgSettingCommon['holy_strengthen_final_pct']) !== null && _b !== void 0 ? _b : 0;
      return getBaseVal() * (iCfgStrengthenFinalPct * 0.01);
    });
    const getTotalValStr = createMemo(() => {
      return AttrVal2Str(props.affix.a, getBaseVal() + getStrengthenVal() + getFinalVal(), getEffect().ratio);
    });
    const getRangeStr = createMemo(() => {
      if (getIsTaigu() || getAffix().c == 1) {
        return '';
      }
      return ValRangeStr(props.affix.a, getEffect().value_down, NumFixRatio(getEffect().value_up, getEffect().ratio));
    });
    return (() => {
      const _el$183 = createElement("Panel", {
          get ["class"]() {
            return classNames('HolyTooltipAffixRowBase');
          },
          hittest: false
        }, null),
        _el$184 = createElement("Panel", {
          "class": "Icon"
        }, _el$183);
        createElement("Panel", {
          "class": "filler"
        }, _el$184);
        createElement("Panel", {
          "class": "IconTrans"
        }, _el$184);
        createElement("Panel", {
          "class": "IconFinal"
        }, _el$184);
        createElement("Panel", {
          "class": "IconTaigu"
        }, _el$184);
        const _el$189 = createElement("Label", {
          id: "Affix",
          html: true,
          get text() {
            return '#' + props.affix.a;
          }
        }, _el$183),
        _el$190 = createElement("Label", {
          id: "Value",
          html: true,
          get text() {
            return getTotalValStr();
          }
        }, _el$183),
        _el$191 = createElement("Label", {
          id: "Range",
          html: true,
          get text() {
            return getRangeStr();
          }
        }, _el$183);
      effect(_p$ => {
        const _v$85 = classNames('HolyTooltipAffixRowBase'),
          _v$86 = {
            [getState()]: true,
            'trans': getIsTrans()
          },
          _v$87 = {
            [getState()]: true,
            'trans': getIsTrans()
          },
          _v$88 = '#' + props.affix.a,
          _v$89 = getTotalValStr(),
          _v$90 = getRangeStr();
        _v$85 !== _p$._v$85 && (_p$._v$85 = setProp(_el$183, "class", _v$85, _p$._v$85));
        _v$86 !== _p$._v$86 && (_p$._v$86 = setProp(_el$183, "classList", _v$86, _p$._v$86));
        _v$87 !== _p$._v$87 && (_p$._v$87 = setProp(_el$184, "classList", _v$87, _p$._v$87));
        _v$88 !== _p$._v$88 && (_p$._v$88 = setProp(_el$189, "text", _v$88, _p$._v$88));
        _v$89 !== _p$._v$89 && (_p$._v$89 = setProp(_el$190, "text", _v$89, _p$._v$89));
        _v$90 !== _p$._v$90 && (_p$._v$90 = setProp(_el$191, "text", _v$90, _p$._v$90));
        return _p$;
      }, {
        _v$85: undefined,
        _v$86: undefined,
        _v$87: undefined,
        _v$88: undefined,
        _v$89: undefined,
        _v$90: undefined
      });
      return _el$183;
    })();
  }
  function CalcHolyScore(tHoly) {
    var _a, _b, _c, _d, _e, _f, _g, _h, _j, _k, _l, _m, _o, _p, _q;
    const holy_score = CfgGetter_holy_score();
    const tCfgSettingCommon = (_a = CfgGetter_settings_common()) !== null && _a !== void 0 ? _a : {};
    if (holy_score == undefined) {
      return 0;
    }
    const iClass = (_b = tHoly.class) !== null && _b !== void 0 ? _b : 1;
    const iRarity = (_c = tHoly.rarity) !== null && _c !== void 0 ? _c : 1;
    const iStrengthenMax = (_e = (_d = GetHolySetting(iRarity, iClass)) === null || _d === void 0 ? void 0 : _d['strengthen_max']) !== null && _e !== void 0 ? _e : 0;
    const iTaiguPct = (_f = tCfgSettingCommon['holy_taigu_affix_pct']) !== null && _f !== void 0 ? _f : 0;
    const iStrengthenPct = (_g = tCfgSettingCommon['holy_strengthen_pct']) !== null && _g !== void 0 ? _g : 0;
    const iFinalPct = (_h = tCfgSettingCommon['holy_strengthen_final_pct']) !== null && _h !== void 0 ? _h : 0;
    const getEffect = affix => GetHolyAffixEffect(iClass, affix);
    const calcAffixTotalVal = (affix, iStrengthen) => {
      var _a, _b;
      const effect = getEffect(affix);
      let baseVal = affix.v;
      if (affix.taigu) {
        baseVal = effect.value_up * (1 + iTaiguPct * 0.01);
      } else {
        baseVal = ValuePct(affix.v, effect.value_down, effect.value_up, effect.ratio);
      }
      let iAffixStrengthen = iStrengthen;
      if ((_a = affix.trans) === null || _a === void 0 ? void 0 : _a.includes(3)) {
        iAffixStrengthen = (_b = affix.strength) !== null && _b !== void 0 ? _b : 0;
      }
      let strengthenVal = 0;
      if (iAffixStrengthen > 0 && iStrengthenMax > 0) {
        strengthenVal = baseVal * (iStrengthenPct * (iAffixStrengthen / iStrengthenMax) * 0.01);
      }
      let finalVal = 0;
      if (affix.fin) {
        finalVal = baseVal * (iFinalPct * 0.01);
      }
      return baseVal + strengthenVal + finalVal;
    };
    let iAttr10600527Val = 0;
    let bHas527 = false;
    for (const affix of tHoly.affix || []) {
      if (affix.a == 10600527) {
        bHas527 = true;
        break;
      }
    }
    if (bHas527) {
      const iBaseStrengthen = (_j = tHoly.strength) !== null && _j !== void 0 ? _j : 0;
      for (const affix of tHoly.affix || []) {
        if (affix.a != 10600527) continue;
        const iAffixStrengthen = ((_k = affix.trans) === null || _k === void 0 ? void 0 : _k.includes(3)) ? (_l = affix.strength) !== null && _l !== void 0 ? _l : 0 : iBaseStrengthen;
        const iBaseVal = GetHolyAffixBaseVal(affix, iClass, iTaiguPct);
        let iStrengthenVal = 0;
        if (iAffixStrengthen > 0 && iStrengthenMax > 0) {
          iStrengthenVal = iBaseVal * (iStrengthenPct * (iAffixStrengthen / iStrengthenMax) * 0.01);
        }
        let iFinalVal = 0;
        if (affix.fin) {
          iFinalVal = iBaseVal * (iFinalPct * 0.01);
        }
        iAttr10600527Val += iBaseVal + iStrengthenVal + iFinalVal;
      }
      iAttr10600527Val = Math.floor(iAttr10600527Val);
    }
    const iStrengthen = ((_m = tHoly.strength) !== null && _m !== void 0 ? _m : 0) + iAttr10600527Val;
    let iScore = 0;
    for (const affix of tHoly.affix || []) {
      if (((_o = affix.c) !== null && _o !== void 0 ? _o : 0) >= 3 || affix.a == undefined) continue;
      const fVal = calcAffixTotalVal(affix, iStrengthen);
      iScore += ((_q = (_p = holy_score[String(affix.a)]) === null || _p === void 0 ? void 0 : _p['single_score']) !== null && _q !== void 0 ? _q : 0) * fVal;
    }
    return Math.floor(iScore);
  }
  function GemInfoTooltip(props) {
    return (() => {
      const _el$192 = createElement("Panel", {
        id: "GemInfoTooltip"
      }, null);
      insert(_el$192, createComponent(GemTooltipHeader, props), null);
      insert(_el$192, createComponent(GemTooltipAffix, props), null);
      return _el$192;
    })();
  }
  function GemTooltipHeader(props) {
    const getData = () => props.data;
    const getRarity = () => {
      var _a;
      return (_a = getData().rarity) !== null && _a !== void 0 ? _a : 1;
    };
    return (() => {
      const _el$193 = createElement("Panel", {
          id: 'GemTooltipHeader',
          get ["class"]() {
            return classNames('TooltipHeader', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$194 = createElement("Panel", {
          "class": "BGPanel"
        }, _el$193);
        createElement("Panel", {
          "class": "BG2"
        }, _el$194);
        const _el$196 = createElement("Panel", {
          "class": "Image"
        }, _el$193);
      insert(_el$196, createComponent(PackGemItem, {
        data: getData
      }));
      insert(_el$193, createComponent(Yzy_Label, {
        "class": "Name",
        get rarity() {
          return getRarity();
        },
        get text() {
          return `#GemInfoTitle_${getRarity()}`;
        }
      }), null);
      effect(_$p => setProp(_el$193, "class", classNames('TooltipHeader', `Rarity_${getRarity()}`), _$p));
      return _el$193;
    })();
  }
  function GemTooltipAffix(props) {
    const getData = () => props.data;
    const getRarity = () => {
      var _a;
      return (_a = getData().rarity) !== null && _a !== void 0 ? _a : 1;
    };
    const getAffix = createMemo(() => {
      var _a, _b;
      return (_b = (_a = props.data) === null || _a === void 0 ? void 0 : _a.affix) === null || _b === void 0 ? void 0 : _b.filter(k => (k === null || k === void 0 ? void 0 : k.c) == 1).sort((a, b) => {
        var _a, _b, _c, _d;
        return Number((_b = (_a = CfgGetter_equipment_score()) === null || _a === void 0 ? void 0 : _a[a.a]) === null || _b === void 0 ? void 0 : _b['sort']) - Number((_d = (_c = CfgGetter_equipment_score()) === null || _c === void 0 ? void 0 : _c[b.a]) === null || _d === void 0 ? void 0 : _d['sort']);
      });
    });
    return (() => {
      const _el$197 = createElement("Panel", {
          "class": "GemTooltipAffix"
        }, null),
        _el$198 = createElement("Panel", {
          "class": "Title",
          hittest: false
        }, _el$197);
        createElement("Panel", {
          "class": "BG"
        }, _el$198);
        createElement("Panel", {
          "class": "Line"
        }, _el$198);
        createElement("Label", {
          text: '#AffixTitle_1',
          hittest: false
        }, _el$198);
        const _el$202 = createElement("Panel", {
          "class": "Body"
        }, _el$197);
      insert(_el$202, createComponent(Index, {
        get each() {
          return getAffix();
        },
        children: (getAffix, i) => {
          var _a, _b;
          const getIsPrivilege = () => {
            var _a;
            return (_a = getAffix().a) === null || _a === void 0 ? void 0 : _a.toString().startsWith('118');
          };
          return (() => {
            const _el$203 = createElement("Panel", {
              "class": "GemTooltipAffixRowParent"
            }, null);
            insert(_el$203, createComponent(Show, {
              get when() {
                return getIsPrivilege();
              },
              get fallback() {
                return createComponent(GemTooltipAffixRow, {
                  get affix() {
                    return getAffix();
                  },
                  get rarity() {
                    return getRarity();
                  }
                });
              },
              get children() {
                return createComponent(Yzy_Attribute, {
                  "class": "GemTooltipAffixRow",
                  get id() {
                    return (_b = (_a = getAffix().a) === null || _a === void 0 ? void 0 : _a.toString()) !== null && _b !== void 0 ? _b : '';
                  },
                  val: 1
                });
              }
            }));
            return _el$203;
          })();
        }
      }));
      return _el$197;
    })();
  }
  function GemTooltipAffixRow(props) {
    const isAltDown = useAltDown();
    const getEffect = createMemo(() => {
      var _a, _b;
      let cfg = (_b = (_a = CfgGetter_gem_effect()) === null || _a === void 0 ? void 0 : _a[props.rarity]) === null || _b === void 0 ? void 0 : _b[props.affix.a];
      return cfg !== null && cfg !== void 0 ? cfg : {
        value_down: 0,
        value_up: 0,
        ratio: 0
      };
    });
    const getVal = () => ValuePct(props.affix.v, getEffect().value_down, getEffect().value_up, getEffect().ratio);
    const getValStr = () => AttrVal2Str(props.affix.a, getVal(), getEffect().ratio);
    const getTotalStr = () => AttrVal2Str(props.affix.a, getVal(), getEffect().ratio);
    return (() => {
      const _el$204 = createElement("Panel", {
          get ["class"]() {
            return classNames("GemTooltipAffixRow");
          },
          hittest: false
        }, null),
        _el$205 = createElement("Label", {
          hittest: false,
          id: "Affix",
          html: true,
          get text() {
            return '#' + props.affix.a;
          }
        }, _el$204);
      insert(_el$204, createComponent(Show, {
        get when() {
          return !isAltDown();
        },
        get children() {
          const _el$206 = createElement("Label", {
            hittest: false,
            id: "Value",
            html: true,
            get text() {
              return getValStr();
            }
          }, null);
          effect(_$p => setProp(_el$206, "text", getValStr(), _$p));
          return _el$206;
        }
      }), null);
      insert(_el$204, createComponent(Show, {
        get when() {
          return isAltDown();
        },
        get children() {
          const _el$207 = createElement("Label", {
            hittest: false,
            id: "Total",
            html: true,
            get text() {
              return getTotalStr();
            }
          }, null);
          effect(_$p => setProp(_el$207, "text", getTotalStr(), _$p));
          return _el$207;
        }
      }), null);
      effect(_p$ => {
        const _v$91 = classNames("GemTooltipAffixRow"),
          _v$92 = '#' + props.affix.a;
        _v$91 !== _p$._v$91 && (_p$._v$91 = setProp(_el$204, "class", _v$91, _p$._v$91));
        _v$92 !== _p$._v$92 && (_p$._v$92 = setProp(_el$205, "text", _v$92, _p$._v$92));
        return _p$;
      }, {
        _v$91: undefined,
        _v$92: undefined
      });
      return _el$204;
    })();
  }
  function AncientInfoTooltip(props) {
    var _a;
    const getPartLevel = () => {
      var _a, _b, _c;
      return ((_c = (_a = ServGetter_UserEquipEnhance()) === null || _a === void 0 ? void 0 : _a[`1${((_b = props.data) === null || _b === void 0 ? void 0 : _b.part) || 99}01`]) === null || _c === void 0 ? void 0 : _c.enhance) || 0;
    };
    props.part_level = (_a = props.part_level) !== null && _a !== void 0 ? _a : getPartLevel;
    const getRsncMapAffixIDX = createMemo(() => {
      var _a, _b;
      const enhance = (_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0;
      const ancient_effect = CfgGetter_ancient_effect();
      const ancient_level_effect = CfgGetter_ancient_level_effect();
      if (!ancient_effect || !ancient_level_effect) {
        return {};
      }
      let tAncientInfo = AncientCalculateInfo(props.data);
      let lock_index = 0;
      let iMaxTag = 0;
      let cfg = ancient_level_effect;
      for (const [k, v] of Object.entries(cfg).sort((a, b) => {
        return Number(b[0]) - Number(a[0]);
      })) {
        if (v['tag_condition']) {
          if (enhance >= Number(k)) {
            lock_index = Math.max(lock_index, v['tag_condition']);
          }
          iMaxTag = Math.max(iMaxTag, v['tag_condition']);
        }
      }
      if (lock_index >= iMaxTag) {
        lock_index = 999;
      }
      const tAffix = {};
      for (const iRsncId in tAncientInfo.Rsnc.id_map_number) {
        const tKv = AbilitiesKv['ancient_rsnc_' + iRsncId];
        if (tKv == undefined) continue;
        const iRsncValueMin = tKv['AbilityValues']['min'];
        const iRsncValueMax = tKv['AbilityValues']['max'];
        let iRsncValue = 0;
        for (const val of tAncientInfo.Rsnc.id_map_number[iRsncId]) {
          if (lock_index + 100 >= val.idx) {
            iRsncValue += ValuePct(val.v, iRsncValueMin, iRsncValueMax);
          }
        }
        iRsncValue = iRsncValue * 0.01;
        const calculateValue1 = arr => {
          var _a;
          const tAffix1 = {};
          for (const tValue of arr) {
            const tAttrCfg = ancient_effect === null || ancient_effect === void 0 ? void 0 : ancient_effect[String(tValue.a)];
            if (tAttrCfg == undefined) {
              $.Warning('ancient_effect not find, affix: ' + tValue.a);
              continue;
            }
            const {
              value_down,
              value_up,
              coefficient
            } = tAttrCfg;
            if (tAffix1[tValue.idx] == undefined) {
              tAffix1[tValue.idx] = 0;
            }
            let iCoefficient = 0;
            if (coefficient) {
              for (let i = 1; i <= ((_a = tValue.l) !== null && _a !== void 0 ? _a : 1); i++) {
                let iVal = 0;
                for (const s of coefficient.toString().split('|')) {
                  const [lvl, val] = s.split('=').map(v => Number(v));
                  if (i < lvl) break;
                  iVal = val;
                }
                iCoefficient += iVal;
              }
            }
            tAffix1[tValue.idx] += ValuePct(tValue.v, value_down, value_up) * iRsncValue * (iCoefficient / 10000);
          }
          return tAffix1;
        };
        const calculateValue2 = (arr, bEven = true) => {
          const tCalculateValue2 = {};
          for (const attribute_id in arr) {
            const tValues = arr[attribute_id];
            if (bEven) {
              if (tValues.length % 2 == 0) {
                const tmp = calculateValue1(tValues);
                for (const iAffixIdx in tmp) {
                  if (tCalculateValue2[iAffixIdx] == undefined) {
                    tCalculateValue2[iAffixIdx] = 0;
                  }
                  tCalculateValue2[iAffixIdx] += tmp[iAffixIdx];
                }
              }
            } else {
              if (tValues.length % 2 != 0) {
                const tmp = calculateValue1(tValues);
                for (const iAffixIdx in tmp) {
                  if (tCalculateValue2[iAffixIdx] == undefined) {
                    tCalculateValue2[iAffixIdx] = 0;
                  }
                  tCalculateValue2[iAffixIdx] += tmp[iAffixIdx];
                }
              }
            }
          }
          return tCalculateValue2;
        };
        let tAffix2 = {};
        switch (iRsncId) {
          case '1201001':
            tAffix2 = calculateValue1(tAncientInfo.Base.affixs_level_max);
            break;
          case '1201002':
            tAffix2 = calculateValue1(tAncientInfo.Base.affixs_level_min);
            break;
          case '1201003':
            tAffix2 = calculateValue2(tAncientInfo.Base.id_map_number, false);
            break;
          case '1201004':
            tAffix2 = calculateValue2(tAncientInfo.Base.id_map_number, true);
            break;
          case '1201005':
            tAffix2 = calculateValue1(tAncientInfo.Advanced.affixs_level_max);
            break;
          case '1201006':
            tAffix2 = calculateValue1(tAncientInfo.Advanced.affixs_level_min);
            break;
          case '1201007':
            tAffix2 = calculateValue2(tAncientInfo.Advanced.id_map_number, false);
            break;
          case '1201008':
            tAffix2 = calculateValue2(tAncientInfo.Advanced.id_map_number, true);
            break;
        }
        for (const iAffixIdx in tAffix2) {
          if (tAffix[iAffixIdx] == undefined) {
            tAffix[iAffixIdx] = 0;
          }
          tAffix[iAffixIdx] += tAffix2[iAffixIdx];
        }
      }
      return tAffix;
    });
    return (() => {
      const _el$208 = createElement("Panel", {
        id: "AncientInfoTooltip",
        hittest: false
      }, null);
      insert(_el$208, createComponent(AncientTooltipHeader, props), null);
      insert(_el$208, createComponent(AncientTooltipAffix, mergeProps(props, {
        get rsnc_map_idx() {
          return getRsncMapAffixIDX();
        }
      })), null);
      return _el$208;
    })();
  }
  function AncientTooltipHeader(props) {
    const getData = () => props.data;
    const getPart = () => {
      var _a;
      return (_a = getData()) === null || _a === void 0 ? void 0 : _a.part;
    };
    const getRarity = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.class) !== null && _b !== void 0 ? _b : 1;
    };
    const getClass = () => {
      var _a, _b;
      return (_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.class) !== null && _b !== void 0 ? _b : 1;
    };
    const getBind = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.bind) || 0;
    };
    const getPrvg1185012 = () => {
      var _a, _b, _c;
      return (_c = (_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a['1185012']) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
    };
    const getPrvg1185013 = () => {
      var _a, _b, _c;
      return (_c = (_b = (_a = ServGetter_UserItem()) === null || _a === void 0 ? void 0 : _a['1185013']) === null || _b === void 0 ? void 0 : _b.count) !== null && _c !== void 0 ? _c : 0;
    };
    const getJuniorCount = createMemo(() => {
      var _a, _b, _c, _d;
      return Math.max(((_b = (_a = props.data) === null || _a === void 0 ? void 0 : _a.junior_max) !== null && _b !== void 0 ? _b : 0) - ((_d = (_c = props.data) === null || _c === void 0 ? void 0 : _c.junior) !== null && _d !== void 0 ? _d : 0), 0);
    });
    const getJuniorExtractCount = createMemo(() => {
      var _a, _b, _c, _d;
      if (((_a = props.data) === null || _a === void 0 ? void 0 : _a.junior) > ((_b = props.data) === null || _b === void 0 ? void 0 : _b.junior_max)) {
        return Math.max(0, getPrvg1185012() - (((_c = props.data) === null || _c === void 0 ? void 0 : _c.junior) - ((_d = props.data) === null || _d === void 0 ? void 0 : _d.junior_max)));
      }
      return getPrvg1185012();
    });
    const getSeniorCount = createMemo(() => {
      var _a, _b;
      return Math.max(((_a = props.data) === null || _a === void 0 ? void 0 : _a.senior_max) - ((_b = props.data) === null || _b === void 0 ? void 0 : _b.senior), 0);
    });
    const getSeniorExtractCount = createMemo(() => {
      var _a, _b, _c, _d;
      if (((_a = props.data) === null || _a === void 0 ? void 0 : _a.senior) > ((_b = props.data) === null || _b === void 0 ? void 0 : _b.senior_max)) {
        return Math.max(0, getPrvg1185013() - (((_c = props.data) === null || _c === void 0 ? void 0 : _c.senior) - ((_d = props.data) === null || _d === void 0 ? void 0 : _d.senior_max)));
      }
      return getPrvg1185013();
    });
    const getScore = () => {
      var _a, _b;
      if (((_b = (_a = getData()) === null || _a === void 0 ? void 0 : _a.score) !== null && _b !== void 0 ? _b : 0) > 0) {
        if (getter_bDebugMode()) {
          return `${getData().score}(UI=${CalcAncientScore(getData())})`;
        } else {
          return getData().score;
        }
      }
      return CalcAncientScore(getData());
    };
    return (() => {
      const _el$209 = createElement("Panel", {
          id: "AncientTooltipHeader",
          get ["class"]() {
            return classNames('TooltipHeader', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$210 = createElement("Panel", {
          "class": "BGPanel"
        }, _el$209);
        createElement("Panel", {
          "class": "BG2"
        }, _el$210);
        const _el$212 = createElement("Panel", {
          "class": "Image"
        }, _el$209),
        _el$213 = createElement("Panel", {
          "class": "Line"
        }, _el$209),
        _el$214 = createElement("Panel", {
          "class": "RightTopBox"
        }, _el$209),
        _el$216 = createElement("Label", {
          "class": "JuniorLabel",
          html: true,
          get text() {
            return ReplaceTextVariable('#ServiceJuniorCount', {
              v: getJuniorCount(),
              v1: getJuniorExtractCount()
            });
          }
        }, _el$214),
        _el$217 = createElement("Label", {
          "class": "SeniorLabel",
          html: true,
          get text() {
            return ReplaceTextVariable('#ServiceSeniorCount', {
              v: getSeniorCount(),
              v1: getSeniorExtractCount()
            });
          }
        }, _el$214),
        _el$218 = createElement("Panel", {
          "class": "Score"
        }, _el$209),
        _el$219 = createElement("Label", {
          get text() {
            return getScore();
          }
        }, _el$218);
      insert(_el$212, createComponent(PackAncientItem, {
        data: getData
      }));
      insert(_el$209, createComponent(Yzy_Label, {
        "class": "Name",
        get rarity() {
          return getRarity();
        },
        get text() {
          return `#AncientInfoTitle_${getPart()}_${getClass()}`;
        }
      }), _el$213);
      insert(_el$214, createComponent(Show, {
        get when() {
          return getBind() > 0;
        },
        get children() {
          const _el$215 = createElement("Label", {
            "class": "Bind",
            get text() {
              return ReplaceTextVariable('#EquipBind', {
                'val': getBind()
              });
            },
            html: true
          }, null);
          effect(_$p => setProp(_el$215, "text", ReplaceTextVariable('#EquipBind', {
            'val': getBind()
          }), _$p));
          return _el$215;
        }
      }), _el$216);
      insert(_el$218, createComponent(Yzy_Icon, {
        type: "icon_score"
      }), _el$219);
      effect(_p$ => {
        const _v$93 = classNames('TooltipHeader', `Rarity_${getRarity()}`),
          _v$94 = ReplaceTextVariable('#ServiceJuniorCount', {
            v: getJuniorCount(),
            v1: getJuniorExtractCount()
          }),
          _v$95 = ReplaceTextVariable('#ServiceSeniorCount', {
            v: getSeniorCount(),
            v1: getSeniorExtractCount()
          }),
          _v$96 = getScore();
        _v$93 !== _p$._v$93 && (_p$._v$93 = setProp(_el$209, "class", _v$93, _p$._v$93));
        _v$94 !== _p$._v$94 && (_p$._v$94 = setProp(_el$216, "text", _v$94, _p$._v$94));
        _v$95 !== _p$._v$95 && (_p$._v$95 = setProp(_el$217, "text", _v$95, _p$._v$95));
        _v$96 !== _p$._v$96 && (_p$._v$96 = setProp(_el$219, "text", _v$96, _p$._v$96));
        return _p$;
      }, {
        _v$93: undefined,
        _v$94: undefined,
        _v$95: undefined,
        _v$96: undefined
      });
      return _el$209;
    })();
  }
  function AncientTooltipAffix(props) {
    let ref;
    const getData = () => props.data;
    const getRarity = () => 1;
    const getAffix = () => {
      var _a;
      return ((_a = getData()) === null || _a === void 0 ? void 0 : _a.affix) || [];
    };
    const getAffixGroup = createMemo(() => {
      const tAffixGroup = {};
      for (const affix of getAffix()) {
        if (affix.c < 3) {
          if (tAffixGroup[affix.c] == undefined) {
            tAffixGroup[affix.c] = [];
          }
          tAffixGroup[affix.c].push(affix);
        }
      }
      return tAffixGroup;
    });
    const getRsnc = createMemo(() => {
      var _a;
      const tAffix = [];
      if ((_a = props.data) === null || _a === void 0 ? void 0 : _a.affix) {
        for (const affix of props.data.affix) {
          if (affix.c == 3) {
            tAffix.push(affix);
          }
        }
      }
      return tAffix;
    });
    const [getTitleShow, setTitleShow] = createSignal(getRsnc().length > 0);
    return (() => {
      const _el$220 = createElement("Panel", {
          id: "AncientTooltipAffix",
          get ["class"]() {
            return classNames('TooltipAffix', `Rarity_${getRarity()}`);
          }
        }, null),
        _el$221 = createElement("Panel", {
          id: "Part3",
          "class": "AffixGroup"
        }, _el$220);
      const _ref$6 = ref;
      typeof _ref$6 === "function" ? use(_ref$6, _el$220) : ref = _el$220;
      insert(_el$220, createComponent(Index, {
        get each() {
          return Object.entries(getAffixGroup());
        },
        children: (getValue, i) => {
          const getAffixType = () => getValue()[0];
          const getAffix = () => getValue()[1];
          return (() => {
            const _el$227 = createElement("Panel", {
                get id() {
                  return 'Part_' + getAffixType();
                },
                "class": "AffixGroup"
              }, null),
              _el$228 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, _el$227);
              createElement("Panel", {
                "class": "BG"
              }, _el$228);
              createElement("Panel", {
                "class": "Line"
              }, _el$228);
              const _el$231 = createElement("Label", {
                get text() {
                  return `#AffixTitle_${getAffixType()}`;
                },
                hittest: false
              }, _el$228),
              _el$232 = createElement("Panel", {
                "class": "Body"
              }, _el$227);
            insert(_el$232, createComponent(Index, {
              get each() {
                return getAffix().sort((a, b) => b.l - a.l);
              },
              children: (getAffix, i) => {
                var _a, _b, _c, _d, _e, _f, _g, _h;
                return createComponent(AncientTooltipAffixRow, {
                  get part_level() {
                    return props.part_level;
                  },
                  get affix() {
                    return getAffix();
                  },
                  get operate_state() {
                    return props.operate_state;
                  },
                  get ancient_remark_select() {
                    return props.ancient_remark_select;
                  },
                  get ancient_remark_select_count() {
                    return props.ancient_remark_select_count;
                  },
                  get ancient_remark_select_affix_type() {
                    return props.ancient_remark_select_affix_type;
                  },
                  get rsnc_map_idx() {
                    return props.rsnc_map_idx;
                  },
                  get className() {
                    return classNames({
                      'AncientEnhance': (_b = (_a = props.ancient_result) === null || _a === void 0 ? void 0 : _a.call(props)) === null || _b === void 0 ? void 0 : _b.includes(getAffix().idx),
                      'ExtractWaitRequest': ((_d = (_c = props.operate_state) === null || _c === void 0 ? void 0 : _c.call(props)) !== null && _d !== void 0 ? _d : 0) == 1,
                      'ExtractResultAnmt': ((_f = (_e = props.operate_state) === null || _e === void 0 ? void 0 : _e.call(props)) !== null && _f !== void 0 ? _f : 0) > 1 && ((_h = (_g = props.operate_state) === null || _g === void 0 ? void 0 : _g.call(props)) !== null && _h !== void 0 ? _h : 0) < 10
                    });
                  }
                });
              }
            }));
            effect(_p$ => {
              const _v$97 = 'Part_' + getAffixType(),
                _v$98 = `#AffixTitle_${getAffixType()}`;
              _v$97 !== _p$._v$97 && (_p$._v$97 = setProp(_el$227, "id", _v$97, _p$._v$97));
              _v$98 !== _p$._v$98 && (_p$._v$98 = setProp(_el$231, "text", _v$98, _p$._v$98));
              return _p$;
            }, {
              _v$97: undefined,
              _v$98: undefined
            });
            return _el$227;
          })();
        }
      }), _el$221);
      insert(_el$221, createComponent(Show, {
        get when() {
          return getTitleShow();
        },
        get children() {
          return [(() => {
            const _el$222 = createElement("Panel", {
                "class": "Title",
                hittest: false
              }, null);
              createElement("Panel", {
                "class": "BG"
              }, _el$222);
              createElement("Panel", {
                "class": "Line"
              }, _el$222);
              const _el$225 = createElement("Label", {
                text: `#AffixTitle_3`,
                hittest: false
              }, _el$222);
            setProp(_el$225, "text", `#AffixTitle_3`);
            return _el$222;
          })(), (() => {
            const _el$226 = createElement("Panel", {
              "class": "Body"
            }, null);
            insert(_el$226, createComponent(Show, {
              get when() {
                return getRsnc().length > 0;
              },
              get children() {
                return createComponent(Index, {
                  get each() {
                    return getRsnc().sort((a, b) => a.idx - b.idx);
                  },
                  children: affix => {
                    return createComponent(AncientTooltipRsncRow, {
                      get part_level() {
                        return props.part_level;
                      },
                      get affix() {
                        return affix();
                      }
                    });
                  }
                });
              }
            }));
            return _el$226;
          })()];
        }
      }));
      effect(_$p => setProp(_el$220, "class", classNames('TooltipAffix', `Rarity_${getRarity()}`), _$p));
      return _el$220;
    })();
  }
  function AncientTooltipAffixRow(props) {
    const getAffix = () => props.affix;
    const getIdx = () => getAffix().idx;
    const isHasAncientSelection = () => {
      var _a, _b, _c, _d;
      return props.ancient_remark_select != undefined && ((_b = (_a = props.ancient_remark_select_count) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) > 0 && (((_d = (_c = props.ancient_remark_select_affix_type) === null || _c === void 0 ? void 0 : _c.call(props)) !== null && _d !== void 0 ? _d : 0) == 0 || props.ancient_remark_select_affix_type() == props.affix.c);
    };
    return (() => {
      const _el$233 = createElement("Panel", {
          get onload() {
            return props.onload;
          },
          get id() {
            return "AncientTooltipAffixRow_" + getIdx();
          },
          get ["class"]() {
            return classNames("AncientTooltipAffixRow", "AncientTooltipAffixRow_" + getIdx(), props.className, {
              "HasSelected": isHasAncientSelection()
            });
          },
          hittest: false
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$233);
      insert(_el$233, createComponent(Show, {
        get when() {
          return isHasAncientSelection();
        },
        children: () => {
          let ref;
          const [getLock, setLock] = props.ancient_remark_select;
          const isSelected = () => getLock().includes(props.affix.idx);
          const isDisableSelect = () => getLock().length >= props.ancient_remark_select_count() && !isSelected();
          createEffect(() => {
            if (ref) {
              ref.hittest = true;
              if (ref.checked != isSelected()) {
                ref.checked = isSelected();
              }
            }
          });
          return (() => {
            const _el$235 = createElement("ToggleButton", {
              hittest: true,
              "class": "InfoAffixSelection AncientSelect",
              get selected() {
                return isSelected();
              }
            }, null);
            const _ref$7 = ref;
            typeof _ref$7 === "function" ? use(_ref$7, _el$235) : ref = _el$235;
            setProp(_el$235, "onselect", p => {
              if (isSelected()) return;
              if (isDisableSelect()) {
                p.checked = false;
                return;
              }
              const t = [...getLock()];
              t.push(props.affix.idx);
              setLock(t);
            });
            setProp(_el$235, "ondeselect", p => {
              const t = [...getLock()];
              const i = t.indexOf(props.affix.idx);
              if (i != -1) {
                t.splice(i, 1);
                setLock(t);
              }
            });
            effect(_p$ => {
              const _v$102 = {
                  'DisableSelect': isDisableSelect()
                },
                _v$103 = isSelected();
              _v$102 !== _p$._v$102 && (_p$._v$102 = setProp(_el$235, "classList", _v$102, _p$._v$102));
              _v$103 !== _p$._v$103 && (_p$._v$103 = setProp(_el$235, "selected", _v$103, _p$._v$103));
              return _p$;
            }, {
              _v$102: undefined,
              _v$103: undefined
            });
            return _el$235;
          })();
        }
      }), null);
      insert(_el$233, createComponent(AncientTooltipAffixRowBase, props), null);
      effect(_p$ => {
        const _v$99 = props.onload,
          _v$100 = "AncientTooltipAffixRow_" + getIdx(),
          _v$101 = classNames("AncientTooltipAffixRow", "AncientTooltipAffixRow_" + getIdx(), props.className, {
            "HasSelected": isHasAncientSelection()
          });
        _v$99 !== _p$._v$99 && (_p$._v$99 = setProp(_el$233, "onload", _v$99, _p$._v$99));
        _v$100 !== _p$._v$100 && (_p$._v$100 = setProp(_el$233, "id", _v$100, _p$._v$100));
        _v$101 !== _p$._v$101 && (_p$._v$101 = setProp(_el$233, "class", _v$101, _p$._v$101));
        return _p$;
      }, {
        _v$99: undefined,
        _v$100: undefined,
        _v$101: undefined
      });
      return _el$233;
    })();
  }
  function AncientTooltipAffixRowBase(props) {
    var _a, _b;
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getAffix = () => props.affix;
    const getLevel = () => getAffix().l || 1;
    const getEffect = createMemo(() => {
      var _a;
      let data = {
        value_down: 0,
        value_up: 0,
        ratio: 1
      };
      let cfg = (_a = CfgGetter_ancient_effect()) === null || _a === void 0 ? void 0 : _a[String(props.affix.a)];
      if (cfg) {
        const f = CalcAncientEffectCoefficient(props.affix);
        data.ratio = cfg['ratio'];
        data.value_down = NumFixRatio(cfg['value_down'] * f, cfg['ratio']);
        data.value_up = NumFixRatio(cfg['value_up'] * f, cfg['ratio']);
      }
      return data;
    });
    const getPartLevelRatio = createMemo(() => {
      var _a, _b;
      return CalcAncientEffectLevel(props.affix, (_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0);
    });
    const getVal = () => ValuePct(props.affix.v, getEffect().value_down, getEffect().value_up, getEffect().ratio);
    const getBonus = () => getVal() * getPartLevelRatio() / 10000;
    const getRsncVal = () => {
      if (props.rsnc_map_idx) {
        for (const idx in props.rsnc_map_idx) {
          if (Number(idx) == props.affix.idx) {
            const val1 = Number(props.rsnc_map_idx[idx].toFixed(2));
            return val1;
          }
        }
      }
      return 0;
    };
    const getValStr = () => AttrVal2Str(props.affix.a, getVal(), getEffect().ratio);
    const getBonusStr = () => AttrVal2Str(props.affix.a, getBonus(), getEffect().ratio);
    const getRsncStr = () => {
      return AttrVal2Str(props.affix.a, NumFixRatio(getRsncVal(), getEffect().ratio), getEffect().ratio);
    };
    const getTotalStr = () => AttrVal2Str(props.affix.a, getVal() + getBonus() + getRsncVal(), getEffect().ratio);
    const getRangeStr = () => ValRangeStr(props.affix.a, getEffect().value_down, NumFixRatio(getEffect().value_down + (getEffect().value_up - getEffect().value_down) * getRedLimit() * 0.01, getEffect().ratio));
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getLevelRarity = () => {
      const cfg = {
        [1]: 1,
        [6]: 2,
        [7]: 3,
        [8]: 4,
        [9]: 5,
        [10]: 6
      };
      let iRarity = 1;
      for (const [lvl, rarity] of Object.entries(cfg).sort((a, b) => Number(a[0]) - Number(b[0]))) {
        if (getLevel() < Number(lvl)) break;
        iRarity = Number(rarity);
      }
      return iRarity;
    };
    return (() => {
      const _el$236 = createElement("Panel", {
          get ["class"]() {
            return classNames('AncientTooltipAffixRowBase', {
              'Red': getIsRed()
            });
          },
          hittest: false
        }, null),
        _el$237 = createElement("Label", {
          id: "Level",
          get ["class"]() {
            return 'Rarity_' + getLevelRarity();
          },
          get text() {
            return getLevel();
          }
        }, _el$236),
        _el$238 = createElement("Label", {
          id: "Affix",
          html: true,
          get text() {
            return '#' + props.affix.a;
          }
        }, _el$236);
      insert(_el$236, createComponent(Show, {
        get when() {
          return memo(() => !!!getter_bAltDown())() && (props.inset_parent ? props.inset_parent.IsValid() : true);
        },
        get children() {
          return [(() => {
            const _el$239 = createElement("Label", {
              id: "Value",
              html: true,
              get text() {
                return getValStr();
              }
            }, null);
            effect(_$p => setProp(_el$239, "text", getValStr(), _$p));
            return _el$239;
          })(), (() => {
            const _el$240 = createElement("Label", {
              id: "Range",
              html: true,
              get text() {
                return getRangeStr();
              }
            }, null);
            effect(_$p => setProp(_el$240, "text", getRangeStr(), _$p));
            return _el$240;
          })(), createComponent(Show, {
            get when() {
              return memo(() => ((_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0) > 0)() && (props.inset_parent ? props.inset_parent.IsValid() : true);
            },
            get children() {
              const _el$241 = createElement("Label", {
                hittest: false,
                id: "Bonus",
                html: true,
                get text() {
                  return getBonusStr();
                }
              }, null);
              effect(_$p => setProp(_el$241, "text", getBonusStr(), _$p));
              return _el$241;
            }
          }), createComponent(Show, {
            get when() {
              return getRsncVal() > 0;
            },
            get children() {
              const _el$242 = createElement("Label", {
                hittest: false,
                id: "Rsnc",
                "class": "Abc",
                html: true,
                get text() {
                  return getRsncStr();
                }
              }, null);
              effect(_$p => setProp(_el$242, "text", getRsncStr(), _$p));
              return _el$242;
            }
          })];
        }
      }), null);
      insert(_el$236, createComponent(Show, {
        get when() {
          return memo(() => !!getter_bAltDown())() && (props.inset_parent ? props.inset_parent.IsValid() : true);
        },
        get children() {
          const _el$243 = createElement("Label", {
            id: "Total",
            html: true,
            get text() {
              return getTotalStr();
            }
          }, null);
          effect(_$p => setProp(_el$243, "text", getTotalStr(), _$p));
          return _el$243;
        }
      }), null);
      effect(_p$ => {
        const _v$104 = classNames('AncientTooltipAffixRowBase', {
            'Red': getIsRed()
          }),
          _v$105 = 'Rarity_' + getLevelRarity(),
          _v$106 = getLevel(),
          _v$107 = '#' + props.affix.a;
        _v$104 !== _p$._v$104 && (_p$._v$104 = setProp(_el$236, "class", _v$104, _p$._v$104));
        _v$105 !== _p$._v$105 && (_p$._v$105 = setProp(_el$237, "class", _v$105, _p$._v$105));
        _v$106 !== _p$._v$106 && (_p$._v$106 = setProp(_el$237, "text", _v$106, _p$._v$106));
        _v$107 !== _p$._v$107 && (_p$._v$107 = setProp(_el$238, "text", _v$107, _p$._v$107));
        return _p$;
      }, {
        _v$104: undefined,
        _v$105: undefined,
        _v$106: undefined,
        _v$107: undefined
      });
      return _el$236;
    })();
  }
  function AncientTooltipRsncRow(props) {
    var _a, _b, _c, _d;
    const getRedLimit = () => {
      var _a, _b;
      return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a['EquipRedLimit']) !== null && _b !== void 0 ? _b : 80;
    };
    const getIsRed = () => props.affix.v >= getRedLimit();
    const getTitle = () => '#ancient_rsnc_' + props.affix.a;
    const getValues = tAffix => {
      var _a, _b, _c, _d, _e;
      const tKv = (_a = KvByID(tAffix.a)) !== null && _a !== void 0 ? _a : {};
      const tValues = Object.assign({}, (_b = tKv['AbilityValues']) !== null && _b !== void 0 ? _b : {});
      const iMax = (_c = tValues['max']) !== null && _c !== void 0 ? _c : 0;
      const iMin = (_d = tValues['min']) !== null && _d !== void 0 ? _d : 0;
      let val = iMin + (iMax - iMin) * tAffix.v * 0.01;
      const ratio = (_e = tValues['ratio']) !== null && _e !== void 0 ? _e : 1;
      if (ratio) {
        val = Number(val.toFixed(ratio));
      }
      tValues['min-max'] = val;
      tValues['min'] = iMin;
      tValues['max'] = NumFixRatio(iMin + (iMax - iMin) * getRedLimit() * 0.01, ratio);
      return tValues;
    };
    const getEnhanceCondition = () => {
      var _a, _b, _c, _d;
      let tMap = {};
      let cfg = (_a = CfgGetter_ancient_level_effect()) !== null && _a !== void 0 ? _a : {};
      for (const [k, v] of Object.entries(cfg)) {
        if (v['tag_condition']) {
          tMap[String(v['tag_condition'])] = Number(k);
        }
      }
      let key = Math.min(((_c = (_b = props === null || props === void 0 ? void 0 : props.affix) === null || _b === void 0 ? void 0 : _b.idx) !== null && _c !== void 0 ? _c : 101) - 100, Object.keys(tMap).length);
      return (_d = tMap[String(key)]) !== null && _d !== void 0 ? _d : 0;
    };
    return (() => {
      const _el$244 = createElement("Panel", {
          get id() {
            return 'AncientTooltipRsncRow_' + props.affix.idx;
          },
          get ["class"]() {
            return classNames('AncientTooltipRsncRow', {
              'Red': getIsRed(),
              'RsncDisabled': !IsAncientRsncLock(props.affix, (_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0)
            });
          },
          get onload() {
            return props.onload;
          },
          hittest: false
        }, null),
        _el$245 = createElement("Label", {
          id: "Description",
          get text() {
            return ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
          },
          html: true
        }, _el$244);
      insert(_el$244, createComponent(Show, {
        get when() {
          return !IsAncientRsncLock(props.affix, (_d = (_c = props === null || props === void 0 ? void 0 : props.part_level) === null || _c === void 0 ? void 0 : _c.call(props)) !== null && _d !== void 0 ? _d : 0);
        },
        get children() {
          const _el$246 = createElement("Label", {
            id: "TipDescription",
            get text() {
              return ReplaceTextVariable(`#ServiceAncientEnhanceCondition`, {
                val: getEnhanceCondition()
              });
            },
            html: true
          }, null);
          effect(_$p => setProp(_el$246, "text", ReplaceTextVariable(`#ServiceAncientEnhanceCondition`, {
            val: getEnhanceCondition()
          }), _$p));
          return _el$246;
        }
      }), null);
      effect(_p$ => {
        const _v$108 = 'AncientTooltipRsncRow_' + props.affix.idx,
          _v$109 = classNames('AncientTooltipRsncRow', {
            'Red': getIsRed(),
            'RsncDisabled': !IsAncientRsncLock(props.affix, (_b = (_a = props === null || props === void 0 ? void 0 : props.part_level) === null || _a === void 0 ? void 0 : _a.call(props)) !== null && _b !== void 0 ? _b : 0)
          }),
          _v$110 = props.onload,
          _v$111 = ReplaceTextVariable(`${getTitle()}_Description`, getValues(props.affix));
        _v$108 !== _p$._v$108 && (_p$._v$108 = setProp(_el$244, "id", _v$108, _p$._v$108));
        _v$109 !== _p$._v$109 && (_p$._v$109 = setProp(_el$244, "class", _v$109, _p$._v$109));
        _v$110 !== _p$._v$110 && (_p$._v$110 = setProp(_el$244, "onload", _v$110, _p$._v$110));
        _v$111 !== _p$._v$111 && (_p$._v$111 = setProp(_el$245, "text", _v$111, _p$._v$111));
        return _p$;
      }, {
        _v$108: undefined,
        _v$109: undefined,
        _v$110: undefined,
        _v$111: undefined
      });
      return _el$244;
    })();
  }
  function CalcAncientEffectCoefficient(affix) {
    var _a, _b;
    let iCoefficient = 0;
    let cfg = (_a = CfgGetter_ancient_effect()) === null || _a === void 0 ? void 0 : _a[String(affix.a)];
    if (cfg) {
      for (let i = 1; i <= ((_b = affix.l) !== null && _b !== void 0 ? _b : 1); i++) {
        let iVal = 0;
        for (const s of cfg['coefficient'].split('|')) {
          const [lvl, val] = s.split('=').map(v => Number(v));
          if (i < lvl) break;
          iVal = val;
        }
        iCoefficient += iVal;
      }
    }
    return iCoefficient * 0.0001;
  }
  function CalcAncientEffectLevel(affix, part_level) {
    var _a;
    const cfg = (_a = CfgGetter_ancient_level_effect()) === null || _a === void 0 ? void 0 : _a[part_level];
    if (cfg) {
      if (affix.c == 1) return cfg['enhance_rate'];
      if (affix.c == 2) return cfg['enhance2_rate'];
    }
    return 0;
  }
  const IsAncientRsncLock = (affix, part_level) => {
    var _a, _b;
    if (part_level > 0) {
      let lock_index = 0;
      let iMaxTag = 0;
      let cfg = (_a = CfgGetter_ancient_level_effect()) !== null && _a !== void 0 ? _a : {};
      for (const [k, v] of Object.entries(cfg).sort((a, b) => Number(a[0]) - Number(b[0]))) {
        if (v['tag_condition']) {
          if (part_level >= Number(k)) lock_index = Math.max(lock_index, v['tag_condition']);
          iMaxTag = Math.max(iMaxTag, v['tag_condition']);
        }
      }
      if (lock_index >= iMaxTag) return true;
      return ((_b = affix === null || affix === void 0 ? void 0 : affix.idx) !== null && _b !== void 0 ? _b : 0) <= lock_index + 100;
    }
    return false;
  };
  function AncientCalculateInfo(tAncient) {
    var _a, _b;
    let tAncientInfo = {
      'Base': {
        affixs_level_min: [],
        affixs_level_max: [],
        id_map_number: {}
      },
      'Advanced': {
        affixs_level_min: [],
        affixs_level_max: [],
        id_map_number: {}
      },
      'Rsnc': {
        id_map_number: {}
      }
    };
    let affix_base_level_min = 99;
    let affix_base_level_max = 0;
    let affix_advanced_level_min = 99;
    let affix_advanced_level_max = 0;
    for (const tAffix of (_a = tAncient === null || tAncient === void 0 ? void 0 : tAncient.affix) !== null && _a !== void 0 ? _a : []) {
      if (tAffix.c == 1) {
        if (tAffix.l > affix_base_level_max) {
          affix_base_level_max = tAffix.l;
        }
        if (tAffix.l < affix_base_level_min) {
          affix_base_level_min = tAffix.l;
        }
      } else if (tAffix.c == 2) {
        if (tAffix.l > affix_advanced_level_max) {
          affix_advanced_level_max = tAffix.l;
        }
        if (tAffix.l < affix_advanced_level_min) {
          affix_advanced_level_min = tAffix.l;
        }
      }
    }
    for (const tAffix of (_b = tAncient === null || tAncient === void 0 ? void 0 : tAncient.affix) !== null && _b !== void 0 ? _b : []) {
      const tUseAffix = {
        a: tAffix.a,
        v: tAffix.v,
        l: tAffix.l,
        idx: tAffix.idx
      };
      if (tAffix.c == 1) {
        if (tAffix.l == affix_base_level_max) {
          tAncientInfo.Base.affixs_level_max.push(tUseAffix);
        }
        if (tAffix.l == affix_base_level_min) {
          tAncientInfo.Base.affixs_level_min.push(tUseAffix);
        }
        if (tAncientInfo.Base.id_map_number[tAffix.a] == undefined) {
          tAncientInfo.Base.id_map_number[tAffix.a] = [tUseAffix];
        } else {
          tAncientInfo.Base.id_map_number[tAffix.a].push(tUseAffix);
        }
      } else if (tAffix.c == 2) {
        if (tAffix.l == affix_advanced_level_max) {
          tAncientInfo.Advanced.affixs_level_max.push(tUseAffix);
        }
        if (tAffix.l == affix_advanced_level_min) {
          tAncientInfo.Advanced.affixs_level_min.push(tUseAffix);
        }
        if (tAncientInfo.Advanced.id_map_number[tAffix.a] == undefined) {
          tAncientInfo.Advanced.id_map_number[tAffix.a] = [tUseAffix];
        } else {
          tAncientInfo.Advanced.id_map_number[tAffix.a].push(tUseAffix);
        }
      } else if (tAffix.c == 3) {
        if (tAncientInfo.Rsnc.id_map_number[tAffix.a] == undefined) {
          tAncientInfo.Rsnc.id_map_number[tAffix.a] = [tUseAffix];
        } else {
          tAncientInfo.Rsnc.id_map_number[tAffix.a].push(tUseAffix);
        }
      }
    }
    return tAncientInfo;
  }
  function AncientCalcEffect(tAncients) {
    var _a, _b;
    const ancient_effect = GetSystemConfig('ancient_effect');
    const ancient_level_effect = GetSystemConfig('ancient_level_effect');
    const tAffix = {};
    for (const tPorp of tAncients) {
      const {
        tAncient,
        tEnhance
      } = tPorp;
      const tAncientInfo = AncientCalculateInfo(tAncient);
      if (tAncient.affix) {
        for (const tValue of tAncient.affix) {
          const sAffixId = String(tValue.a);
          if (tValue.c == 1 || tValue.c == 2) {
            const tAttrCfg = ancient_effect === null || ancient_effect === void 0 ? void 0 : ancient_effect[sAffixId];
            if (tAttrCfg == undefined) {
              $.Warning('ancient_effect not find, affix: ' + sAffixId);
              continue;
            }
            let {
              value_down,
              value_up,
              coefficient,
              ratio
            } = tAttrCfg;
            let iCoefficient = 0;
            for (let i = 1; i <= ((_a = tValue.l) !== null && _a !== void 0 ? _a : 1); i++) {
              let iVal = 0;
              for (const s of coefficient.toString().split('|')) {
                const [lvl, val] = s.split('=').map(v => Number(v));
                if (i < lvl) break;
                iVal = val;
              }
              iCoefficient += iVal;
            }
            iCoefficient = iCoefficient * 0.0001;
            value_down = NumFixRatio(value_down * iCoefficient, ratio);
            value_up = NumFixRatio(value_up * iCoefficient, ratio);
            let val = NumFixRatio(ValuePct(tValue.v, value_down, value_up), ratio);
            let iValue = 0;
            let iBonusValue = 0;
            if (tEnhance && tEnhance.enhance && tEnhance.enhance > 0) {
              const cfg = ancient_level_effect === null || ancient_level_effect === void 0 ? void 0 : ancient_level_effect[tEnhance.enhance];
              if (cfg == undefined) {
                $.Warning('ancient_level_effect not find, enhance: ' + tEnhance.enhance);
                continue;
              }
              if (tValue.c == 1) iValue = cfg['enhance_rate'];else if (tValue.c == 2) iValue = cfg['enhance2_rate'];
            }
            iBonusValue = val * iValue * 0.0001;
            let iTotalVal = NumFixRatio(val + iBonusValue, ratio);
            tAffix[sAffixId] = ((_b = tAffix[sAffixId]) !== null && _b !== void 0 ? _b : 0) + iTotalVal;
          }
        }
      }
      const tAffixTemp = AncientGetRsnc(tAncientInfo, tEnhance === null || tEnhance === void 0 ? void 0 : tEnhance.enhance);
      for (const iAffixId in tAffixTemp) {
        if (tAffix[iAffixId] == undefined) continue;
        tAffix[iAffixId] += tAffixTemp[iAffixId];
        tAffix[iAffixId] = NumFixRatio(tAffix[iAffixId], 1);
      }
    }
    return tAffix;
  }
  function AncientGetRsnc(tAncientInfo, enhance = 0) {
    const ancient_effect = GetSystemConfig('ancient_effect');
    const ancient_level_effect = GetSystemConfig('ancient_level_effect');
    let lock_index = 0;
    let iMaxTag = 0;
    let cfg = ancient_level_effect;
    for (const [k, v] of Object.entries(cfg).sort((a, b) => {
      return Number(b[0]) - Number(a[0]);
    })) {
      if (v['tag_condition']) {
        if (enhance >= Number(k)) {
          lock_index = Math.max(lock_index, v['tag_condition']);
        }
        iMaxTag = Math.max(iMaxTag, v['tag_condition']);
      }
    }
    if (lock_index >= iMaxTag) {
      lock_index = 999;
    }
    let tAffix = {};
    for (const iRsncId in tAncientInfo.Rsnc.id_map_number) {
      const tKv = AbilitiesKv['ancient_rsnc_' + iRsncId];
      if (tKv == undefined) continue;
      const iRsncValueMin = tKv['AbilityValues']['min'];
      const iRsncValueMax = tKv['AbilityValues']['min'];
      let iRsncValue = 0;
      for (const val of tAncientInfo.Rsnc.id_map_number[iRsncId]) {
        if (lock_index + 100 >= val.idx) {
          iRsncValue += ValuePct(val.v, iRsncValueMin, iRsncValueMax);
        }
      }
      iRsncValue = iRsncValue * 0.01;
      const calculateValue1 = arr => {
        const tAffix1 = {};
        for (const tValue of arr) {
          const tAttrCfg = ancient_effect === null || ancient_effect === void 0 ? void 0 : ancient_effect[String(tValue.a)];
          if (tAttrCfg == undefined) {
            $.Warning('ancient_effect not find, affix: ' + tValue.a);
            continue;
          }
          const {
            value_down,
            value_up,
            coefficient
          } = tAttrCfg;
          if (tAffix1[tValue.a] == undefined) {
            tAffix1[tValue.a] = 0;
          }
          let iCoefficient = 0;
          if (coefficient) {
            for (let i = 1; i <= tValue.l; i++) {
              let iVal = 0;
              for (const s of coefficient.toString().split('|')) {
                const [lvl, val] = s.split('=').map(v => Number(v));
                if (i < lvl) break;
                iVal = val;
              }
              iCoefficient += iVal;
            }
          }
          tAffix1[tValue.a] += ValuePct(tValue.v, value_down, value_up) * iRsncValue * (iCoefficient / 10000);
        }
        return tAffix1;
      };
      const calculateValue2 = (arr, bEven = true) => {
        const tAffix1 = {};
        for (const attribute_id in arr) {
          const tValues = arr[attribute_id];
          if (bEven) {
            if (tValues.length % 2 == 0) {
              const tmp = calculateValue1(tValues);
              for (const key in tmp) {
                if (tAffix1[key] == undefined) {
                  tAffix1[key] = 0;
                }
                tAffix1[key] += tmp[key];
              }
            }
          } else {
            if (tValues.length % 2 != 0) {
              const tmp = calculateValue1(tValues);
              for (const key in tmp) {
                if (tAffix1[key] == undefined) {
                  tAffix1[key] = 0;
                }
                tAffix1[key] += tmp[key];
              }
            }
          }
        }
        return tAffix1;
      };
      let tAffix2 = {};
      switch (iRsncId) {
        case '1201001':
          tAffix2 = calculateValue1(tAncientInfo.Base.affixs_level_max);
          break;
        case '1201002':
          tAffix2 = calculateValue1(tAncientInfo.Base.affixs_level_min);
          break;
        case '1201003':
          tAffix2 = calculateValue2(tAncientInfo.Base.id_map_number, false);
          break;
        case '1201004':
          tAffix2 = calculateValue2(tAncientInfo.Base.id_map_number, true);
          break;
        case '1201005':
          tAffix2 = calculateValue1(tAncientInfo.Advanced.affixs_level_max);
          break;
        case '1201006':
          tAffix2 = calculateValue1(tAncientInfo.Advanced.affixs_level_min);
          break;
        case '1201007':
          tAffix2 = calculateValue2(tAncientInfo.Advanced.id_map_number, false);
          break;
        case '1201008':
          tAffix2 = calculateValue2(tAncientInfo.Advanced.id_map_number, true);
          break;
      }
      for (const iAffixId in tAffix2) {
        if (tAffix[iAffixId] == undefined) {
          tAffix[iAffixId] = 0;
        }
        tAffix[iAffixId] += tAffix2[iAffixId];
      }
    }
    return tAffix;
  }
  function CalcAncientScore(tAncient, enhance) {
    var _a, _b, _c, _d;
    const ancient_score = CfgGetter_ancient_score();
    const ancient_effect = CfgGetter_ancient_effect();
    const equipment_enhance_effect = CfgGetter_equipment_enhance_effect();
    if (ancient_score == undefined || ancient_effect == undefined || equipment_enhance_effect == undefined) {
      return 0;
    }
    let iPlayerID = tAncient.user_id != undefined ? Player_AccountToID(Number(tAncient.user_id)) : Players.GetLocalPlayer();
    if (!Players.IsValidPlayerID(iPlayerID)) {
      return 0;
    }
    const tEnhance = (_b = (_a = NetEventData.GetTableValue('service', 'UserEquipEnhance_' + iPlayerID)) === null || _a === void 0 ? void 0 : _a[`1${tAncient.part}01`]) !== null && _b !== void 0 ? _b : {
      enhance: 0
    };
    const tEffect = AncientCalcEffect([{
      tAncient: tAncient,
      tEnhance: {
        enhance: tEnhance.enhance
      }
    }]);
    let iScore = 0;
    for (const [id, fVal] of Object.entries(tEffect)) {
      iScore += ((_d = (_c = ancient_score[String(id)]) === null || _c === void 0 ? void 0 : _c['single_score']) !== null && _d !== void 0 ? _d : 0) * fVal;
    }
    return Math.floor(iScore);
  }
  function CalcEquipScore(tEquip) {
    var _a, _b, _c, _d, _e, _f;
    const equipment_score = CfgGetter_equipment_score();
    const equipment_effect = CfgGetter_equipment_effect();
    const equipment_enhance_effect = CfgGetter_equipment_enhance_effect();
    if (equipment_score == undefined || equipment_effect == undefined || equipment_enhance_effect == undefined) {
      return 0;
    }
    let iPlayerID = tEquip.user_id != undefined ? Player_AccountToID(Number(tEquip.user_id)) : Players.GetLocalPlayer();
    if (!Players.IsValidPlayerID(iPlayerID)) {
      return 0;
    }
    const iPartLevel = ((_b = (_a = NetEventData.GetTableValue('service', 'UserEquipEnhance_' + iPlayerID)) === null || _a === void 0 ? void 0 : _a['1' + tEquip.part + '01']) === null || _b === void 0 ? void 0 : _b.enhance) || 0;
    let iScore = 0;
    const tRsnc = {};
    for (const t of (_c = tEquip.affix) !== null && _c !== void 0 ? _c : []) {
      if (t.c <= 2) {
        const tAttrCfg = (_d = equipment_effect[t.l || 1]) === null || _d === void 0 ? void 0 : _d[t.a];
        if (tAttrCfg == undefined) {
          $.Warning('equipment_effect not find, affix: ' + t.l + ' a =' + t.a);
          continue;
        }
        let {
          value_down,
          value_up,
          ratio
        } = tAttrCfg;
        value_down = NumFixRatio(value_down, ratio);
        value_up = NumFixRatio(value_up, ratio);
        let val = NumFixRatio(ValuePct(t.v, value_down, value_up), ratio);
        const iEnhance = ((_e = equipment_enhance_effect[iPartLevel]) === null || _e === void 0 ? void 0 : _e[t.c]) || 0;
        let iBonusValue = val * (iEnhance * 0.0001);
        let iTotalVal = NumFixRatio(val + iBonusValue, ratio);
        iScore += ((_f = equipment_score[String(t.a)]['single_score']) !== null && _f !== void 0 ? _f : 0) * iTotalVal;
      } else if (t.c == 3) {
        let iAffixId = String(t.a);
        if (tRsnc[iAffixId] == undefined) {
          tRsnc[iAffixId] = 0;
        }
        tRsnc[iAffixId] = Math.max(tRsnc[iAffixId], t.v);
      }
    }
    Object.entries(tRsnc).map(([iRsncId, value]) => {
      var _a, _b;
      iScore += ((_b = (_a = equipment_score[String(iRsncId)]) === null || _a === void 0 ? void 0 : _a['single_score']) !== null && _b !== void 0 ? _b : 0) * value;
    });
    return Math.floor(iScore);
  }

  if ($.GetContextPanel().paneltype == 'TooltipContents') {
    $.GetContextPanel().ClearPanelEvent("ontooltiploaded");
    $.GetContextPanel().SetPanelEvent("ontooltiploaded", () => {
      var _a;
      const props = (_a = GetTooltipParams('equip_tooltip', $.GetContextPanel())) !== null && _a !== void 0 ? _a : {};
      render(() => createComponent(EquipTooltip, props), $.GetContextPanel());
    });
  }

}));