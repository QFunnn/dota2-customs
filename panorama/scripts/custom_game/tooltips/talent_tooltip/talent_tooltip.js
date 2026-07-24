--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
(function (global, factory) {
  typeof exports === 'object' && typeof module !== 'undefined' ? factory(exports) :
  typeof define === 'function' && define.amd ? define(['exports'], factory) :
  (global = typeof globalThis !== 'undefined' ? globalThis : global || self, factory(global.talent_tooltip = {}));
})(this, (function (exports) { 'use strict';

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
  const { render: _render, effect, memo, createComponent, createElement, insert, spread, setProp, mergeProps} = createRenderer({
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
  function RedText(text, className = "") {
    return ColorText(text, "#ff0000", className);
  }
  function SpanText(text, className = "") {
    return `<span class="${className}">${text}</span>`;
  }
  function ColorText(text, color, className = "") {
    const sClass = className != "" ? `class="${className}"` : undefined;
    if (sClass) return `<font color="${color}" ${sClass} >${text}</font>`;
    return `<font color="${color}">${text}</font>`;
  }

  function Clamp(num, min, max) {
    return num <= min ? min : num >= max ? max : num;
  }
  function IsEmptyObject(obj) {
    for (let _ in obj) return false;
    return true;
  }
  function Round(fNumber, prec = 0) {
    let i = Math.pow(10, prec);
    return Math.round(fNumber * i) / i;
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

  function GetTooltipParams(sTooltipName, pContext) {
    let t = GameUI.CustomUIConfig()[sTooltipName];
    if (pContext != undefined && t != undefined) {
      t['context'] = pContext;
    }
    return t;
  }

  const getter_iLocalPlayer = useLocalPlayer();

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

  const getter_bAltDown = useAltDown();

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

  if ($.GetContextPanel().paneltype == 'TooltipContents') {
    $.GetContextPanel().ClearPanelEvent("ontooltiploaded");
    $.GetContextPanel().SetPanelEvent("ontooltiploaded", () => {
      var _a;
      const {
        sTalentName,
        iEntID
      } = (_a = GetTooltipParams('talent_tooltip', $.GetContextPanel())) !== null && _a !== void 0 ? _a : {};
      render(() => createComponent(TalentTooltip, {
        sTalentName: sTalentName,
        iEntID: iEntID
      }), $.GetContextPanel());
    });
  }
  function TalentTooltip({
    sTalentName,
    iEntID = -1,
    iLevel = 1
  }) {
    var _a, _b;
    const tKv = (_a = AbilitiesKv[sTalentName]) !== null && _a !== void 0 ? _a : {};
    let iAbltID = -1;
    if (-1 != iEntID) {
      iAbltID = Entities.GetAbilityByName(iEntID, sTalentName);
      if (iLevel == undefined && -1 != iAbltID) {
        iLevel = Abilities.GetLevel(iAbltID);
      }
    }
    const tAttributeValues = createMemo(() => {
      const aAttributeKey = [];
      Object.keys((tKv === null || tKv === void 0 ? void 0 : tKv['AbilityValues']) || {}).map((sKey, i) => {
        if (sKey.substring(0, 3) == 'sx_') {
          aAttributeKey.push(sKey);
        }
      });
      return aAttributeKey;
    });
    let tSpecials = {};
    for (const sKey in tKv.AbilityValues) {
      let sDescription = `#${sTalentName}_${sKey}`;
      let sDescriptionLocalize = $.Localize(sDescription);
      if (sDescriptionLocalize != sDescription) {
        tSpecials[sKey] = {
          sDescription: sDescriptionLocalize,
          sVal: String(tKv.AbilityValues[sKey])
        };
      }
    }
    const tSelectedAffix = NetEventData.GetTableValue('abilities', 'selected_affix_' + getter_iLocalPlayer());
    const getAbltAffix = createMemo(() => {
      return (tSelectedAffix === null || tSelectedAffix === void 0 ? void 0 : tSelectedAffix.filter(v => {
        var _a;
        return ((_a = AbilitiesKv[v === null || v === void 0 ? void 0 : v.name]) === null || _a === void 0 ? void 0 : _a['AmpAblt']) == 'base_1';
      })) || [];
    });
    return (() => {
      const _el$ = createElement("Panel", {}, null),
        _el$2 = createElement("Panel", {}, _el$),
        _el$3 = createElement("Panel", {}, _el$),
        _el$4 = createElement("Panel", {}, _el$3),
        _el$5 = createElement("Panel", {}, _el$4),
        _el$6 = createElement("Image", {
          "class": "Icon HeaderImage",
          src: `file://{images}/custom_game/talent/${sTalentName !== null && sTalentName !== void 0 ? sTalentName : 'empty'}.png`
        }, _el$4),
        _el$7 = createElement("Label", {
          id: "TalentName",
          get text() {
            return $.Localize("#" + sTalentName);
          },
          html: true
        }, _el$4),
        _el$0 = createElement("Panel", {
          id: "CostBox"
        }, _el$3);
      setProp(_el$2, "className", "BG");
      setProp(_el$3, "className", "Body");
      setProp(_el$4, "className", "Hander");
      setProp(_el$5, "className", "BG");
      setProp(_el$6, "src", `file://{images}/custom_game/talent/${sTalentName !== null && sTalentName !== void 0 ? sTalentName : 'empty'}.png`);
      insert(_el$3, createComponent(Show, {
        get when() {
          return tAttributeValues().length > 0;
        },
        get children() {
          const _el$8 = createElement("Panel", {
            id: "AbilityAttribute"
          }, null);
          insert(_el$8, () => Object.values(tAttributeValues()).map((sKey, i) => {
            var _a;
            let sAttributeID = sKey.substring(3);
            let fVal = (_a = tKv['AbilityValues'][sKey]) !== null && _a !== void 0 ? _a : 0;
            return createComponent(Yzy_Attribute, {
              id: sAttributeID,
              val: fVal
            });
          }));
          return _el$8;
        }
      }), _el$0);
      insert(_el$3, createComponent(Show, {
        get when() {
          return $.Localize(`#${sTalentName}_Description`) != `#${sTalentName}_Description`;
        },
        get children() {
          return createComponent(Yzy_Description, {
            name: sTalentName,
            get text() {
              return ReplaceAbltVals(sTalentName, $.Localize(`#${sTalentName}_Description`), {
                'entid': iEntID,
                'level': iLevel,
                'count': getter_bAltDown()
              });
            }
          });
        }
      }), _el$0);
      insert(_el$3, (() => {
        const _c$ = memo(() => !!!IsEmptyObject(tSpecials));
        return () => _c$() ? (() => {
          const _el$1 = createElement("Panel", {
            id: "AbilitySpecialBox"
          }, null);
          insert(_el$1, () => Object.keys(tSpecials).map(sKey => {
            let {
              sDescription,
              sVal
            } = tSpecials[sKey];
            if (sDescription.search(/\[.*?\]/) != -1) {
              let s = ReplaceAbltVals(sTalentName, sDescription, {
                'level': iLevel,
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
                const _el$10 = createElement("Panel", {}, null),
                  _el$11 = createElement("Label", {
                    id: "AbilitySpecialKey",
                    text: sKey2,
                    html: true
                  }, _el$10);
                setProp(_el$10, "className", "AbilitySpecialPanel");
                setProp(_el$11, "text", sKey2);
                insert(_el$10, sVal2 != undefined ? (() => {
                  const _el$12 = createElement("Label", {
                    id: "AbilitySpecialVal",
                    text: sVal2,
                    html: true
                  }, null);
                  setProp(_el$12, "text", sVal2);
                  return _el$12;
                })() : undefined, null);
                return _el$10;
              })();
            } else {
              let bPct = sDescription[0] == '%';
              if (bPct) {
                sDescription = sDescription.substring(1);
              }
              let sVal2 = '';
              let tVal = sVal.split(' ');
              {
                sVal2 = tVal[Clamp(iLevel - 1, 0, tVal.length - 1)];
              }
              if (bPct) sVal2 += '%';
              sVal2 = SpanText(sVal2, 'CurLevel');
              return (() => {
                const _el$13 = createElement("Panel", {}, null),
                  _el$14 = createElement("Label", {
                    id: "AbilitySpecialKey",
                    text: sDescription
                  }, _el$13),
                  _el$15 = createElement("Label", {
                    id: "AbilitySpecialVal",
                    text: sVal2,
                    html: true
                  }, _el$13);
                setProp(_el$13, "className", "AbilitySpecialPanel");
                setProp(_el$14, "text", sDescription);
                setProp(_el$15, "text", sVal2);
                return _el$13;
              })();
            }
          }));
          return _el$1;
        })() : [];
      })(), _el$0);
      insert(_el$3, createComponent(Show, {
        get when() {
          return iEntID != -1 && ((_b = getAbltAffix()) === null || _b === void 0 ? void 0 : _b.length) >= 0;
        },
        get children() {
          const _el$9 = createElement("Panel", {
            id: "AbilityAffixBox"
          }, null);
          insert(_el$9, createComponent(Index, {
            get each() {
              return getAbltAffix();
            },
            children: (getAffix, i) => {
              const sAbltAffix = () => getAffix().name;
              const iAbltAffixCount = () => getAffix().count;
              const getName = () => $.Localize(`#DOTA_TOOLTIP_ability_${sAbltAffix()}`);
              const getKv = () => AbilitiesKv === null || AbilitiesKv === void 0 ? void 0 : AbilitiesKv[sAbltAffix()];
              const getAttributeValues = createMemo(() => {
                var _a;
                const aAttributeKey = [];
                Object.keys(((_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues']) || {}).map((sKey, i) => {
                  if (sKey.substring(0, 3) == 'sx_') {
                    aAttributeKey.push(sKey);
                  }
                });
                return aAttributeKey;
              });
              return (() => {
                const _el$16 = createElement("Panel", {
                    "class": "AbltAffixRow"
                  }, null),
                  _el$17 = createElement("Label", {
                    id: "Name",
                    get text() {
                      return getName();
                    }
                  }, _el$16),
                  _el$18 = createElement("Label", {
                    id: "Count",
                    get text() {
                      return `(${iAbltAffixCount()}): `;
                    },
                    html: true
                  }, _el$16);
                insert(_el$16, createComponent(Show, {
                  get when() {
                    return getAttributeValues().length > 0;
                  },
                  get children() {
                    const _el$19 = createElement("Panel", {
                      id: "AbltAffixAttribute"
                    }, null);
                    insert(_el$19, () => Object.values(getAttributeValues()).map((sKey, i) => {
                      var _a, _b;
                      let sAttributeID = sKey.substring(3);
                      let fVal = (_b = (_a = getKv()) === null || _a === void 0 ? void 0 : _a['AbilityValues'][sKey]) !== null && _b !== void 0 ? _b : 0;
                      return createComponent(Yzy_Attribute, {
                        id: sAttributeID,
                        val: fVal
                      });
                    }));
                    return _el$19;
                  }
                }), null);
                insert(_el$16, createComponent(Show, {
                  get when() {
                    return $.Localize(`#DOTA_TOOLTIP_ability_${sAbltAffix()}_Description`) != `#DOTA_TOOLTIP_ability_${sAbltAffix()}_Description`;
                  },
                  get children() {
                    return createComponent(Yzy_Description, {
                      get name() {
                        return sAbltAffix();
                      },
                      get text() {
                        return ReplaceAbltVals(sAbltAffix(), $.Localize(`#DOTA_TOOLTIP_ability_${sAbltAffix()}_Description`), {
                          'entid': iEntID,
                          'level': iLevel,
                          'count': getter_bAltDown()
                        });
                      }
                    });
                  }
                }), null);
                effect(_p$ => {
                  const _v$3 = getName(),
                    _v$4 = `(${iAbltAffixCount()}): `;
                  _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$17, "text", _v$3, _p$._v$3));
                  _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$18, "text", _v$4, _p$._v$4));
                  return _p$;
                }, {
                  _v$3: undefined,
                  _v$4: undefined
                });
                return _el$16;
              })();
            }
          }));
          return _el$9;
        }
      }), _el$0);
      insert(_el$0, () => {
        let sCD = '0';
        if (iAbltID != -1) {
          sCD = Abilities.GetCooldownModified(iAbltID).toString();
        } else if (undefined != tKv.AbilityCooldown) {
          let t = String(tKv.AbilityCooldown).split(' ');
          sCD = t[Clamp(iLevel, 0, t.length - 1)];
        }
        if (Number(sCD) != 0) {
          return (() => {
            const _el$20 = createElement("Panel", {
                id: "CDPanel"
              }, null),
              _el$21 = createElement("Label", {
                get text() {
                  return Round(Number(sCD), 2);
                },
                html: true
              }, _el$20);
            effect(_$p => setProp(_el$21, "text", Round(Number(sCD), 2), _$p));
            return _el$20;
          })();
        }
      }, null);
      insert(_el$0, () => {
        let sMana = '';
        if (undefined != tKv.AbilityManaCost && 0 != tKv.AbilityManaCost) {
          if (iAbltID != -1) {
            sMana = String(Abilities.GetManaCostModified(iAbltID));
          } else {
            let t = String(tKv.AbilityManaCost).split(' ');
            sMana = t[Clamp(iLevel, 0, t.length - 1)];
          }
        }
        return (() => {
          const _el$22 = createElement("Panel", {
              id: "ManaPanel"
            }, null),
            _el$23 = createElement("Label", {
              text: sMana,
              html: true
            }, _el$22);
          setProp(_el$23, "text", sMana);
          effect(_$p => setProp(_el$22, "className", classNames({
            Hidden: sMana == ''
          }), _$p));
          return _el$22;
        })();
      }, null);
      effect(_p$ => {
        const _v$ = classNames('TalentTooltip'),
          _v$2 = $.Localize("#" + sTalentName);
        _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$, "className", _v$, _p$._v$));
        _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$7, "text", _v$2, _p$._v$2));
        return _p$;
      }, {
        _v$: undefined,
        _v$2: undefined
      });
      return _el$;
    })();
  }

  exports.TalentTooltip = TalentTooltip;

}));