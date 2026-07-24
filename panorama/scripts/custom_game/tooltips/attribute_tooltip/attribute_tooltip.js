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
      mergeProps: mergeProps$1,
      effect: createRenderEffect,
      memo,
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
  const { render: _render, effect, createComponent, createElement, insert, spread, setProp, mergeProps} = createRenderer({
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

  function GetTooltipParams(sTooltipName, pContext) {
    let t = GameUI.CustomUIConfig()[sTooltipName];
    if (pContext != undefined && t != undefined) {
      t['context'] = pContext;
    }
    return t;
  }

  function GetSystemConfig(sCfg) {
    var _a;
    GameUI.CustomUIConfig()['__config__'] = (_a = GameUI.CustomUIConfig()['__config__']) !== null && _a !== void 0 ? _a : {};
    if (GameUI.CustomUIConfig()['__config__'][sCfg] != undefined) return GameUI.CustomUIConfig()['__config__'][sCfg];
    return GameUI.CustomUIConfig()['__config__'][sCfg] = GameUI.CustomUIConfig().tools.runlua(`return _G['${sCfg}']`);
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

  var AttributeKind$1 = GameUI.CustomUIConfig().tools.AttributeKind;
  const ID2Attribute = {
    '10600001': AttributeKind$1.Main,
    '10600002': AttributeKind$1.Main.BASE,
    '10600003': AttributeKind$1.Main.BONUS,
    '10600004': AttributeKind$1.Main.PCT,
    '10600005': AttributeKind$1.Main.AMP,
    '10600006': AttributeKind$1.Secondary,
    '10600007': AttributeKind$1.Secondary.BASE,
    '10600008': AttributeKind$1.Secondary.BONUS,
    '10600009': AttributeKind$1.Secondary.PCT,
    '10600010': AttributeKind$1.Secondary.AMP,
    '10600011': AttributeKind$1.AllStats,
    '10600012': AttributeKind$1.AllStats.BASE,
    '10600013': AttributeKind$1.AllStats.BONUS,
    '10600014': AttributeKind$1.AllStats.PCT,
    '10600015': AttributeKind$1.AllStats.AMP,
    '10600016': AttributeKind$1.Strength,
    '10600017': AttributeKind$1.Strength.BASE,
    '10600018': AttributeKind$1.Strength.BONUS,
    '10600019': AttributeKind$1.Strength.PCT,
    '10600020': AttributeKind$1.Strength.AMP,
    '10600021': AttributeKind$1.Agility,
    '10600022': AttributeKind$1.Agility.BASE,
    '10600023': AttributeKind$1.Agility.BONUS,
    '10600024': AttributeKind$1.Agility.PCT,
    '10600025': AttributeKind$1.Agility.AMP,
    '10600026': AttributeKind$1.Intellect,
    '10600027': AttributeKind$1.Intellect.BASE,
    '10600028': AttributeKind$1.Intellect.BONUS,
    '10600029': AttributeKind$1.Intellect.PCT,
    '10600030': AttributeKind$1.Intellect.AMP,
    '10600031': AttributeKind$1.Atk,
    '10600032': AttributeKind$1.Atk.BASE,
    '10600033': AttributeKind$1.Atk.BONUS,
    '10600034': AttributeKind$1.Atk.PCT,
    '10600035': AttributeKind$1.Atk.AMP,
    '10600036': AttributeKind$1.PhyFixDmg,
    '10600037': AttributeKind$1.PhyFixDmg.BASE,
    '10600038': AttributeKind$1.PhyFixDmg.BONUS,
    '10600039': AttributeKind$1.PhyFixDmg.PCT,
    '10600040': AttributeKind$1.PhyFixDmg.AMP,
    '10600041': AttributeKind$1.MgcFixDmg,
    '10600042': AttributeKind$1.MgcFixDmg.BASE,
    '10600043': AttributeKind$1.MgcFixDmg.BONUS,
    '10600044': AttributeKind$1.MgcFixDmg.PCT,
    '10600045': AttributeKind$1.MgcFixDmg.AMP,
    '10600046': AttributeKind$1.AtkPure,
    '10600047': AttributeKind$1.AtkPure.BASE,
    '10600048': AttributeKind$1.AtkPure.BONUS,
    '10600049': AttributeKind$1.AtkPure.PCT,
    '10600050': AttributeKind$1.AtkPure.AMP,
    '10600051': AttributeKind$1.HpLimit,
    '10600052': AttributeKind$1.HpLimit.BASE,
    '10600053': AttributeKind$1.HpLimit.BONUS,
    '10600054': AttributeKind$1.HpLimit.PCT,
    '10600055': AttributeKind$1.HpLimit.AMP,
    '10600056': AttributeKind$1.HpRegen,
    '10600057': AttributeKind$1.HpRegen.BASE,
    '10600058': AttributeKind$1.HpRegen.BONUS,
    '10600059': AttributeKind$1.HpRegen.PCT,
    '10600060': AttributeKind$1.HpRegen.AMP,
    '10600061': AttributeKind$1.HpRegen.HP_PCT,
    '10600062': AttributeKind$1.MpLimit,
    '10600063': AttributeKind$1.MpLimit.BASE,
    '10600064': AttributeKind$1.MpLimit.BONUS,
    '10600065': AttributeKind$1.MpLimit.PCT,
    '10600066': AttributeKind$1.MpLimit.AMP,
    '10600067': AttributeKind$1.MpRegen,
    '10600068': AttributeKind$1.MpRegen.BASE,
    '10600069': AttributeKind$1.MpRegen.BONUS,
    '10600070': AttributeKind$1.MpRegen.PCT,
    '10600071': AttributeKind$1.MpRegen.AMP,
    '10600072': AttributeKind$1.MpRegen.MP_PCT,
    '10600073': AttributeKind$1.Armor,
    '10600074': AttributeKind$1.Armor.BASE,
    '10600075': AttributeKind$1.Armor.BONUS,
    '10600076': AttributeKind$1.Armor.PCT,
    '10600077': AttributeKind$1.Armor.AMP,
    '10600078': AttributeKind$1.AtkSpd,
    '10600079': AttributeKind$1.AtkSpd.BASE,
    '10600080': AttributeKind$1.AtkSpd.BONUS,
    '10600081': AttributeKind$1.AtkSpd.PCT,
    '10600082': AttributeKind$1.AtkTime,
    '10600083': AttributeKind$1.AtkTime.BASE,
    '10600084': AttributeKind$1.MoveSpd,
    '10600085': AttributeKind$1.MoveSpd.BASE,
    '10600086': AttributeKind$1.MoveSpd.BONUS,
    '10600087': AttributeKind$1.MoveSpd.PCT,
    '10600088': AttributeKind$1.AtkRange,
    '10600089': AttributeKind$1.AtkRange.BASE,
    '10600090': AttributeKind$1.AtkRange.BONUS,
    '10600091': AttributeKind$1.AtkRange.PCT,
    '10600092': AttributeKind$1.PrjctSpd,
    '10600093': AttributeKind$1.PrjctSpd.BASE,
    '10600094': AttributeKind$1.PrjctSpd.BONUS,
    '10600095': AttributeKind$1.PrjctSpd.PCT,
    '10600096': AttributeKind$1.CastRange,
    '10600097': AttributeKind$1.CastRange.BASE,
    '10600098': AttributeKind$1.CastRange.BONUS,
    '10600099': AttributeKind$1.CastRange.PCT,
    '10600100': AttributeKind$1.Cooldown,
    '10600101': AttributeKind$1.Cooldown.BASE,
    '10600102': AttributeKind$1.Cooldown.BONUS,
    '10600103': AttributeKind$1.Cooldown.PCT,
    '10600104': AttributeKind$1.StaResist,
    '10600105': AttributeKind$1.DebuffAmp,
    '10600106': AttributeKind$1.Hit,
    '10600107': AttributeKind$1.Evasion,
    '10600108': AttributeKind$1.Heal,
    '10600109': AttributeKind$1.ModelScale,
    '10600110': AttributeKind$1.ModelScale.PCT,
    '10600111': AttributeKind$1.ArmorPenetrate,
    '10600112': AttributeKind$1.ArmorPenetrate.BASE,
    '10600113': AttributeKind$1.ArmorPenetrate.BONUS,
    '10600114': AttributeKind$1.ArmorPenetrate.PCT,
    '10600115': AttributeKind$1.ArmorPenetrate.AMP,
    '10600116': AttributeKind$1.ArmorIgnore,
    '10600117': AttributeKind$1.ArmorIgnore.BASE,
    '10600118': AttributeKind$1.PhyCritChance,
    '10600119': AttributeKind$1.PhyCritChance.BASE,
    '10600120': AttributeKind$1.MgcCritChance,
    '10600121': AttributeKind$1.MgcCritChance.BASE,
    '10600122': AttributeKind$1.PureCritChance,
    '10600123': AttributeKind$1.PureCritChance.BASE,
    '10600124': AttributeKind$1.PhyCritDmg,
    '10600125': AttributeKind$1.PhyCritDmg.BASE,
    '10600126': AttributeKind$1.MgcCritDmg,
    '10600127': AttributeKind$1.MgcCritDmg.BASE,
    '10600128': AttributeKind$1.PureCritDmg,
    '10600129': AttributeKind$1.PureCritDmg.BASE,
    '10600130': AttributeKind$1.MultCount,
    '10600131': AttributeKind$1.MultDmg,
    '10600132': AttributeKind$1.BounceCount,
    '10600133': AttributeKind$1.BounceDmg,
    '10600134': AttributeKind$1.CleaveCount,
    '10600135': AttributeKind$1.CleaveDmg,
    '10600136': AttributeKind$1.StrGain,
    '10600137': AttributeKind$1.AgiGain,
    '10600138': AttributeKind$1.IntGain,
    '10600139': AttributeKind$1.AtkGain,
    '10600140': AttributeKind$1.AtkPureGain,
    '10600141': AttributeKind$1.HpGain,
    '10600142': AttributeKind$1.PhyFixedGain,
    '10600143': AttributeKind$1.MgcFixedGain,
    '10600144': AttributeKind$1.CreepDmg,
    '10600145': AttributeKind$1.CreepDmg.BASE,
    '10600146': AttributeKind$1.EliteDmg,
    '10600147': AttributeKind$1.EliteDmg.BASE,
    '10600148': AttributeKind$1.ChallengeDmg,
    '10600149': AttributeKind$1.ChallengeDmg.BASE,
    '10600150': AttributeKind$1.BossDmg,
    '10600151': AttributeKind$1.BossDmg.BASE,
    '10600152': AttributeKind$1.AtkDmg,
    '10600153': AttributeKind$1.AtkDmg.BASE,
    '10600154': AttributeKind$1.AbltDmg,
    '10600155': AttributeKind$1.AbltDmg.BASE,
    '10600156': AttributeKind$1.PhyDmg,
    '10600157': AttributeKind$1.PhyDmg.BASE,
    '10600158': AttributeKind$1.MgcDmg,
    '10600159': AttributeKind$1.MgcDmg.BASE,
    '10600160': AttributeKind$1.PureDmg,
    '10600161': AttributeKind$1.PureDmg.BASE,
    '10600162': AttributeKind$1.AllDmg,
    '10600163': AttributeKind$1.AllDmg.BASE,
    '10600164': AttributeKind$1.DmgFinal,
    '10600165': AttributeKind$1.DmgFinal.BASE,
    '10600166': AttributeKind$1.DmgReduce,
    '10600167': AttributeKind$1.DmgReduce.BASE,
    '10600168': AttributeKind$1.GoldPct,
    '10600169': AttributeKind$1.WoodPct,
    '10600170': AttributeKind$1.KillPct,
    '10600171': AttributeKind$1.ExpPct,
    '10600172': AttributeKind$1.PerSecAllStats,
    '10600173': AttributeKind$1.PerSecStr,
    '10600174': AttributeKind$1.PerSecAgi,
    '10600175': AttributeKind$1.PerSecInt,
    '10600176': AttributeKind$1.PerSecHp,
    '10600177': AttributeKind$1.PerSecAtk,
    '10600178': AttributeKind$1.PerSecAtkPure,
    '10600179': AttributeKind$1.PerSecPhyFixDmg,
    '10600180': AttributeKind$1.PerSecMgcFixDmg,
    '10600181': AttributeKind$1.PerSecGold,
    '10600182': AttributeKind$1.PerSecWood,
    '10600183': AttributeKind$1.PerSecKill,
    '10600184': AttributeKind$1.PerSecExp,
    '10600185': AttributeKind$1.KillAllStats,
    '10600186': AttributeKind$1.KillStr,
    '10600187': AttributeKind$1.KillAgi,
    '10600188': AttributeKind$1.KillInt,
    '10600189': AttributeKind$1.KillHp,
    '10600190': AttributeKind$1.KillAtk,
    '10600191': AttributeKind$1.KillAtkPure,
    '10600192': AttributeKind$1.KillPhyFixDmg,
    '10600193': AttributeKind$1.KillMgcFixDmg,
    '10600194': AttributeKind$1.KillGold,
    '10600195': AttributeKind$1.KillWood,
    '10600196': AttributeKind$1.KillKill,
    '10600197': AttributeKind$1.KillExp,
    '10600198': AttributeKind$1.KillRegenHp,
    '10600199': AttributeKind$1.RespawnChance,
    '10600200': AttributeKind$1.RespawnTime,
    '10600201': AttributeKind$1.RespawnTime.BASE,
    '10600202': AttributeKind$1.RespawnTime.PCT,
    '10600203': AttributeKind$1.SummonDoubleChance,
    '10600204': AttributeKind$1.SummonDuration,
    '10600205': AttributeKind$1.SummonDmg,
    '10600206': AttributeKind$1.HolyDmg,
    '10600207': AttributeKind$1.HolyDmg.BASE,
    '10600208': AttributeKind$1.NatureDmg,
    '10600209': AttributeKind$1.NatureDmg.BASE,
    '10600210': AttributeKind$1.FrostDmg,
    '10600211': AttributeKind$1.FrostDmg.BASE,
    '10600212': AttributeKind$1.FireDmg,
    '10600213': AttributeKind$1.FireDmg.BASE,
    '10600214': AttributeKind$1.PhysicalDmg,
    '10600215': AttributeKind$1.PhysicalDmg.BASE,
    '10600216': AttributeKind$1.ShadowDmg,
    '10600217': AttributeKind$1.ShadowDmg.BASE,
    '10600218': AttributeKind$1.AllFlagDmg,
    '10600219': AttributeKind$1.HolyPenetrate,
    '10600220': AttributeKind$1.NaturePenetrate,
    '10600221': AttributeKind$1.FrostPenetrate,
    '10600222': AttributeKind$1.FirePenetrate,
    '10600223': AttributeKind$1.PhysicalPenetrate,
    '10600224': AttributeKind$1.ShadowPenetrate,
    '10600225': AttributeKind$1.HolyResist,
    '10600226': AttributeKind$1.NatureResist,
    '10600227': AttributeKind$1.FrostResist,
    '10600228': AttributeKind$1.FireResist,
    '10600229': AttributeKind$1.PhysicalResist,
    '10600230': AttributeKind$1.ShadowResist,
    '10600231': AttributeKind$1.InitGood,
    '10600232': AttributeKind$1.InitWood,
    '10600233': AttributeKind$1.InitKill,
    '10600234': AttributeKind$1.GainDoubleChance,
    '10600235': AttributeKind$1.GainDoubleChance.BASE,
    '10600236': AttributeKind$1.DoubleCastChance,
    '10600237': AttributeKind$1.DoubleCastChance.BASE,
    '10600238': AttributeKind$1.AtkPureChance,
    '10600239': AttributeKind$1.MgcPureChance,
    '10600240': AttributeKind$1.AtkCleaveChance,
    '10600241': AttributeKind$1.AtkCleaveChance.BASE,
    '10600242': AttributeKind$1.AtkCleaveRadius,
    '10600243': AttributeKind$1.AtkCleaveDmg,
    '10600244': AttributeKind$1.PureCleaveChance,
    '10600245': AttributeKind$1.PureCleaveChance.BASE,
    '10600246': AttributeKind$1.PureCleaveRadius,
    '10600247': AttributeKind$1.PureCleaveDmg,
    '10600248': AttributeKind$1.AtkBadDmgChance,
    '10600249': AttributeKind$1.AtkBadDmgChance.BASE,
    '10600250': AttributeKind$1.AtkBadDmg,
    '10600251': AttributeKind$1.AtkBadDuration,
    '10600252': AttributeKind$1.BadEffect,
    '10600253': AttributeKind$1.CardEffect,
    '10600254': AttributeKind$1.FatalBlow,
    '10600255': AttributeKind$1.PenetrateCount,
    '10600256': AttributeKind$1.BurnDmg,
    '10600257': AttributeKind$1.IceDmg,
    '10600258': AttributeKind$1.GoldChallengeCount,
    '10600259': AttributeKind$1.WoodChallengeCount,
    '10600260': AttributeKind$1.ExpChallengeCount,
    '10600261': AttributeKind$1.ChallengeDuration,
    '10600262': AttributeKind$1.ShiftDistance,
    '10600263': AttributeKind$1.SpawnRatePct,
    '10600264': AttributeKind$1.VertRefreshSR,
    '10600265': AttributeKind$1.VertRefreshSSR,
    '10600266': AttributeKind$1.BottleMaxStack,
    '10600267': AttributeKind$1.BlockDmg,
    '10600268': AttributeKind$1.StrGain.BASE,
    '10600269': AttributeKind$1.StrGain.BONUS,
    '10600270': AttributeKind$1.StrGain.PCT,
    '10600271': AttributeKind$1.StrGain.AMP,
    '10600272': AttributeKind$1.AgiGain.BASE,
    '10600273': AttributeKind$1.AgiGain.BONUS,
    '10600274': AttributeKind$1.AgiGain.PCT,
    '10600275': AttributeKind$1.AgiGain.AMP,
    '10600276': AttributeKind$1.IntGain.BASE,
    '10600277': AttributeKind$1.IntGain.BONUS,
    '10600278': AttributeKind$1.IntGain.PCT,
    '10600279': AttributeKind$1.IntGain.AMP,
    '10600280': AttributeKind$1.AtkGain.BASE,
    '10600281': AttributeKind$1.AtkGain.BONUS,
    '10600282': AttributeKind$1.AtkGain.PCT,
    '10600283': AttributeKind$1.AtkGain.AMP,
    '10600284': AttributeKind$1.AtkPureGain.BASE,
    '10600285': AttributeKind$1.AtkPureGain.BONUS,
    '10600286': AttributeKind$1.AtkPureGain.PCT,
    '10600287': AttributeKind$1.AtkPureGain.AMP,
    '10600288': AttributeKind$1.HpGain.BASE,
    '10600289': AttributeKind$1.HpGain.BONUS,
    '10600290': AttributeKind$1.HpGain.PCT,
    '10600291': AttributeKind$1.HpGain.AMP,
    '10600292': AttributeKind$1.PhyFixedGain.BASE,
    '10600293': AttributeKind$1.PhyFixedGain.BONUS,
    '10600294': AttributeKind$1.PhyFixedGain.PCT,
    '10600295': AttributeKind$1.PhyFixedGain.AMP,
    '10600296': AttributeKind$1.MgcFixedGain.BASE,
    '10600297': AttributeKind$1.MgcFixedGain.BONUS,
    '10600298': AttributeKind$1.MgcFixedGain.PCT,
    '10600299': AttributeKind$1.MgcFixedGain.AMP,
    '10600300': AttributeKind$1.KillGoldPct,
    '10600301': AttributeKind$1.KillWoodPct,
    '10600302': AttributeKind$1.KillKillPct,
    '10600303': AttributeKind$1.KillExpPct,
    '10600304': AttributeKind$1.GameShopDiscount,
    '10600305': AttributeKind$1.PerSecGameShopExp,
    '10600306': AttributeKind$1.BaseAtkDmg,
    '10600307': AttributeKind$1.ShadowArrowCount,
    '10600308': AttributeKind$1.ShadowArrowDmg,
    '10600309': AttributeKind$1.ShadowArrowCooldown,
    '10600310': AttributeKind$1.ShadowArrowAoeDmg,
    '10600311': AttributeKind$1.ShadowArrowAoeRadius,
    '10600312': AttributeKind$1.ShadowSecondaryArrowCount,
    '10600313': AttributeKind$1.ShadowSecondaryArrowDmg,
    '10600314': AttributeKind$1.GameShopRefreshCostReduce,
    '10600315': AttributeKind$1.WeaponStatsPct,
    '10600316': AttributeKind$1.BlazingArrowHitDmg,
    '10600317': AttributeKind$1.BlazingArrowBoomDmg,
    '10600318': AttributeKind$1.BlazingArrowDmg,
    '10600319': AttributeKind$1.BlazingArrowAoeRadius,
    '10600320': AttributeKind$1.BlazingArrowCooldown,
    '10600321': AttributeKind$1.BlazingArrowPenetrateCount,
    '10600322': AttributeKind$1.IceArrowDmg,
    '10600323': AttributeKind$1.IceArrowCount,
    '10600324': AttributeKind$1.IceArrowCleaveCount,
    '10600325': AttributeKind$1.IceArrowProjectSpd,
    '10600326': AttributeKind$1.SmallIceArrowDmg,
    '10600327': AttributeKind$1.SkyThunderDmg,
    '10600328': AttributeKind$1.MagneticStormDmg,
    '10600329': AttributeKind$1.MagneticStormRadius,
    '10600330': AttributeKind$1.EMFieldDmg,
    '10600331': AttributeKind$1.BlitzballDmg,
    '10600332': AttributeKind$1.SwordDmg,
    '10600333': AttributeKind$1.SwordProjectSpd,
    '10600334': AttributeKind$1.SwordScale,
    '10600335': AttributeKind$1.SwordCooldown,
    '10600336': AttributeKind$1.ArcaneLaserDmg,
    '10600337': AttributeKind$1.ArcaneLaserKeepTime,
    '10600338': AttributeKind$1.ArcaneLaserCooldown,
    '10600339': AttributeKind$1.ArcaneLaserRadius,
    '10600340': AttributeKind$1.ArcaneRayDmg,
    '10600341': AttributeKind$1.ArcaneRayKeepTime,
    '10600342': AttributeKind$1.ArcaneRayCount,
    '10600343': AttributeKind$1.FrostNovaDmg,
    '10600344': AttributeKind$1.FrostNovaRadius,
    '10600345': AttributeKind$1.FrostNovaCount,
    '10600346': AttributeKind$1.FrostNovaCooldown,
    '10600347': AttributeKind$1.IceArrowCooldown,
    '10600348': AttributeKind$1.LightningChainDmg,
    '10600349': AttributeKind$1.LightningChainCount,
    '10600350': AttributeKind$1.LonBlastingRadius,
    '10600351': AttributeKind$1.LonBlastingDmg,
    '10600352': AttributeKind$1.LightningChainCooldown,
    '10600353': AttributeKind$1.SkyThunderCooldown,
    '10600354': AttributeKind$1.EarthQuakeDmg,
    '10600355': AttributeKind$1.EarthQuakeRadius,
    '10600356': AttributeKind$1.EmbersDmg,
    '10600357': AttributeKind$1.TornadoDmg,
    '10600358': AttributeKind$1.TornadoKeepTime,
    '10600359': AttributeKind$1.TornadoRadius,
    '10600360': AttributeKind$1.TornadoMoveSpd,
    '10600361': AttributeKind$1.DianCiWangDmg,
    '10600362': AttributeKind$1.DianCiWangRadius,
    '10600363': AttributeKind$1.DianCiWangCooldown,
    '10600364': AttributeKind$1.MeteoriteDmg,
    '10600365': AttributeKind$1.MeteoriteCooldown,
    '10600366': AttributeKind$1.MeteoriteRadius,
    '10600367': AttributeKind$1.MeteoriteCount,
    '10600368': AttributeKind$1.MeteoriteFragmentsCount,
    '10600369': AttributeKind$1.FireBallDmg,
    '10600370': AttributeKind$1.FireBallKeepTime,
    '10600371': AttributeKind$1.FireBallRadius,
    '10600372': AttributeKind$1.FireBallMoveSpd,
    '10600373': AttributeKind$1.FireBallCount,
    '10600374': AttributeKind$1.BurntFrostDmg,
    '10600375': AttributeKind$1.HurricaneDmg,
    '10600376': AttributeKind$1.SmallHurricaneCount,
    '10600377': AttributeKind$1.VacuumDmg,
    '10600378': AttributeKind$1.Main.AMP_1,
    '10600379': AttributeKind$1.Secondary.AMP_1,
    '10600380': AttributeKind$1.AllStats.AMP_1,
    '10600381': AttributeKind$1.Strength.AMP_1,
    '10600382': AttributeKind$1.Agility.AMP_1,
    '10600383': AttributeKind$1.Intellect.AMP_1,
    '10600384': AttributeKind$1.Atk.AMP_1,
    '10600385': AttributeKind$1.AtkPure.AMP_1,
    '10600386': AttributeKind$1.PhyFixDmg.AMP_1,
    '10600387': AttributeKind$1.MgcFixDmg.AMP_1,
    '10600388': AttributeKind$1.HpLimit.AMP_1,
    '10600389': AttributeKind$1.Armor.AMP_1,
    '10600390': AttributeKind$1.GameShopRefreshInterval,
    '10600391': AttributeKind$1.HolyAbilitySpellRadius,
    '10600392': AttributeKind$1.NatureAbilitySpellRadius,
    '10600393': AttributeKind$1.FrostAbilitySpellRadius,
    '10600394': AttributeKind$1.FireAbilitySpellRadius,
    '10600395': AttributeKind$1.PhysicalAbilitySpellRadius,
    '10600396': AttributeKind$1.ShadowAbilitySpellRadius,
    '10600397': AttributeKind$1.HolyAbilityCooldown,
    '10600398': AttributeKind$1.NatureAbilityCooldown,
    '10600399': AttributeKind$1.FrostAbilityCooldown,
    '10600400': AttributeKind$1.FireAbilityCooldown,
    '10600401': AttributeKind$1.PhysicalAbilityCooldown,
    '10600402': AttributeKind$1.ShadowAbilityCooldown,
    '10600403': AttributeKind$1.HolyReduceResistPct,
    '10600404': AttributeKind$1.NatureReduceResistPct,
    '10600405': AttributeKind$1.FrostReduceResistPct,
    '10600406': AttributeKind$1.FireReduceResistPct,
    '10600407': AttributeKind$1.PhysicalReduceResistPct,
    '10600408': AttributeKind$1.ShadowReduceResistPct,
    '10600409': AttributeKind$1.MiningSpd,
    '10600410': AttributeKind$1.GameShopCostReduce,
    '10600411': AttributeKind$1.ArchiveDmg,
    '10600412': AttributeKind$1.ArchiveDmg.BASE,
    '10600413': AttributeKind$1.Main.AMP_2,
    '10600414': AttributeKind$1.Secondary.AMP_2,
    '10600415': AttributeKind$1.AllStats.AMP_2,
    '10600416': AttributeKind$1.Strength.AMP_2,
    '10600417': AttributeKind$1.Agility.AMP_2,
    '10600418': AttributeKind$1.Intellect.AMP_2,
    '10600419': AttributeKind$1.Atk.AMP_2,
    '10600420': AttributeKind$1.AtkPure.AMP_2,
    '10600421': AttributeKind$1.PhyFixDmg.AMP_2,
    '10600422': AttributeKind$1.MgcFixDmg.AMP_2,
    '10600423': AttributeKind$1.HpLimit.AMP_2,
    '10600424': AttributeKind$1.Armor.AMP_2,
    '10600425': AttributeKind$1.ShadowArrowPenetrateCount,
    '10600426': AttributeKind$1.IceArrowPenetrateCount,
    '10600427': AttributeKind$1.HurricanePenetrateCount,
    '10600428': AttributeKind$1.ThunderDmgFactor,
    '10600429': AttributeKind$1.ArcaneRayCooldown,
    '10600430': AttributeKind$1.LightningBounceCount,
    '10600431': AttributeKind$1.EarthquakeCooldown,
    '10600432': AttributeKind$1.TornadoCooldown,
    '10600433': AttributeKind$1.HurricaneCooldown,
    '10600434': AttributeKind$1.FireballDuration,
    '10600435': AttributeKind$1.FireballCooldown,
    '10600436': AttributeKind$1.ArcaneRayRange,
    '10600437': AttributeKind$1.HpRegen.OVERRIDE,
    '10600438': AttributeKind$1.MpRegen.OVERRIDE,
    '10600439': AttributeKind$1.Armor.OVERRIDE,
    '10600440': AttributeKind$1.FinalDamageCalculation,
    '10600441': AttributeKind$1.Main.AMP_3,
    '10600442': AttributeKind$1.Secondary.AMP_3,
    '10600443': AttributeKind$1.AllStats.AMP_3,
    '10600444': AttributeKind$1.Strength.AMP_3,
    '10600445': AttributeKind$1.Agility.AMP_3,
    '10600446': AttributeKind$1.Intellect.AMP_3,
    '10600447': AttributeKind$1.Atk.AMP_3,
    '10600448': AttributeKind$1.AtkPure.AMP_3,
    '10600449': AttributeKind$1.PhyFixDmg.AMP_3,
    '10600450': AttributeKind$1.MgcFixDmg.AMP_3,
    '10600451': AttributeKind$1.HpLimit.AMP_3,
    '10600452': AttributeKind$1.Armor.AMP_3,
    '10600453': AttributeKind$1.StrGain.AMP_3,
    '10600454': AttributeKind$1.AgiGain.AMP_3,
    '10600455': AttributeKind$1.IntGain.AMP_3,
    '10600456': AttributeKind$1.AtkGain.AMP_3,
    '10600457': AttributeKind$1.PhyFixedGain.AMP_3,
    '10600458': AttributeKind$1.MgcFixedGain.AMP_3,
    '10600459': AttributeKind$1.HpGain.AMP_3,
    '10600460': AttributeKind$1.PhyCritDmg.AMP,
    '10600461': AttributeKind$1.MgcCritDmg.AMP,
    '10600462': AttributeKind$1.CreepDmg.AMP,
    '10600463': AttributeKind$1.EliteDmg.AMP,
    '10600464': AttributeKind$1.ChallengeDmg.AMP,
    '10600465': AttributeKind$1.BossDmg.AMP,
    '10600466': AttributeKind$1.AtkDmg.AMP,
    '10600467': AttributeKind$1.AbltDmg.AMP,
    '10600468': AttributeKind$1.PhyDmg.AMP,
    '10600469': AttributeKind$1.MgcDmg.AMP,
    '10600470': AttributeKind$1.PureDmg.AMP,
    '10600471': AttributeKind$1.HolyDmg.AMP,
    '10600472': AttributeKind$1.NatureDmg.AMP,
    '10600473': AttributeKind$1.FrostDmg.AMP,
    '10600474': AttributeKind$1.FireDmg.AMP,
    '10600475': AttributeKind$1.PhysicalDmg.AMP,
    '10600476': AttributeKind$1.ShadowDmg.AMP,
    '10600477': AttributeKind$1.FinalDamageCalculation1,
    '10600478': AttributeKind$1.HolyDmg.AMP2,
    '10600479': AttributeKind$1.NatureDmg.AMP2,
    '10600480': AttributeKind$1.FrostDmg.AMP2,
    '10600481': AttributeKind$1.FireDmg.AMP2,
    '10600482': AttributeKind$1.PhysicalDmg.AMP2,
    '10600483': AttributeKind$1.ShadowDmg.AMP2,
    '10600484': AttributeKind$1.FinalHpRegen,
    '10600485': AttributeKind$1.AtkSpd.TOTAL,
    '10600486': AttributeKind$1.DmgAmp,
    '10600487': AttributeKind$1.AllDmg.AMP,
    '10600488': AttributeKind$1.FinalAllDmg,
    '10600489': AttributeKind$1.FinalPhyDmg,
    '10600490': AttributeKind$1.FinalMagDmg,
    '10600492': AttributeKind$1.ArcaneLaserCount,
    '10600493': AttributeKind$1.DianCiWangFixRadius,
    '10600494': AttributeKind$1.Main.AMP_4,
    '10600495': AttributeKind$1.Secondary.AMP_4,
    '10600496': AttributeKind$1.AllStats.AMP_4,
    '10600497': AttributeKind$1.Strength.AMP_4,
    '10600498': AttributeKind$1.Agility.AMP_4,
    '10600499': AttributeKind$1.Intellect.AMP_4,
    '10600500': AttributeKind$1.Atk.AMP_4,
    '10600501': AttributeKind$1.PhyFixDmg.AMP_4,
    '10600502': AttributeKind$1.MgcFixDmg.AMP_4,
    '10600503': AttributeKind$1.AtkPure.AMP_4,
    '10600504': AttributeKind$1.HpLimit.AMP_4,
    '10600505': AttributeKind$1.Armor.AMP_4,
    '10600506': AttributeKind$1.PhyCritDmg.AMP_1,
    '10600507': AttributeKind$1.MgcCritDmg.AMP_1,
    '10600508': AttributeKind$1.PureCritDmg.AMP_1,
    '10600509': AttributeKind$1.CreepDmg.AMP_1,
    '10600510': AttributeKind$1.EliteDmg.AMP_1,
    '10600511': AttributeKind$1.ChallengeDmg.AMP_1,
    '10600512': AttributeKind$1.BossDmg.AMP_1,
    '10600513': AttributeKind$1.ArchiveDmg.AMP_1,
    '10600514': AttributeKind$1.AtkDmg.AMP_1,
    '10600515': AttributeKind$1.AbltDmg.AMP_1,
    '10600516': AttributeKind$1.PhyDmg.AMP_1,
    '10600517': AttributeKind$1.MgcDmg.AMP_1,
    '10600518': AttributeKind$1.PureDmg.AMP_1,
    '10600519': AttributeKind$1.AllDmg.AMP_1,
    '10600520': AttributeKind$1.DmgFinal.AMP_1,
    '10600521': AttributeKind$1.HolyDmg.AMP_1,
    '10600522': AttributeKind$1.NatureDmg.AMP_1,
    '10600523': AttributeKind$1.FrostDmg.AMP_1,
    '10600524': AttributeKind$1.FireDmg.AMP_1,
    '10600525': AttributeKind$1.PhysicalDmg.AMP_1,
    '10600526': AttributeKind$1.ShadowDmg.AMP_1,
    '10600527': AttributeKind$1.HolyRairty,
    '10600528': AttributeKind$1.HolyAbilityLevel,
    '10600529': AttributeKind$1.NatureAbilityLevel,
    '10600530': AttributeKind$1.FrostAbilityLevel,
    '10600531': AttributeKind$1.FireAbilityLevel,
    '10600532': AttributeKind$1.PhysicalAbilityLevel,
    '10600533': AttributeKind$1.ShadowAbilityLevel
  };
  const PctUnitAttributes = {
    [AttributeKind$1.Main.PCT.name]: '%',
    [AttributeKind$1.Main.AMP.name]: '%',
    [AttributeKind$1.Secondary.PCT.name]: '%',
    [AttributeKind$1.Secondary.AMP.name]: '%',
    [AttributeKind$1.AllStats.PCT.name]: '%',
    [AttributeKind$1.AllStats.AMP.name]: '%',
    [AttributeKind$1.Strength.PCT.name]: '%',
    [AttributeKind$1.Strength.AMP.name]: '%',
    [AttributeKind$1.Agility.PCT.name]: '%',
    [AttributeKind$1.Agility.AMP.name]: '%',
    [AttributeKind$1.Intellect.PCT.name]: '%',
    [AttributeKind$1.Intellect.AMP.name]: '%',
    [AttributeKind$1.Atk.PCT.name]: '%',
    [AttributeKind$1.Atk.AMP.name]: '%',
    [AttributeKind$1.PhyFixDmg.PCT.name]: '%',
    [AttributeKind$1.PhyFixDmg.AMP.name]: '%',
    [AttributeKind$1.MgcFixDmg.PCT.name]: '%',
    [AttributeKind$1.MgcFixDmg.AMP.name]: '%',
    [AttributeKind$1.AtkPure.PCT.name]: '%',
    [AttributeKind$1.AtkPure.AMP.name]: '%',
    [AttributeKind$1.HpLimit.PCT.name]: '%',
    [AttributeKind$1.HpLimit.AMP.name]: '%',
    [AttributeKind$1.HpRegen.PCT.name]: '%',
    [AttributeKind$1.HpRegen.AMP.name]: '%',
    [AttributeKind$1.HpRegen.HP_PCT.name]: '%',
    [AttributeKind$1.MpLimit.PCT.name]: '%',
    [AttributeKind$1.MpLimit.AMP.name]: '%',
    [AttributeKind$1.MpRegen.PCT.name]: '%',
    [AttributeKind$1.MpRegen.AMP.name]: '%',
    [AttributeKind$1.MpRegen.MP_PCT.name]: '%',
    [AttributeKind$1.Armor.PCT.name]: '%',
    [AttributeKind$1.Armor.AMP.name]: '%',
    [AttributeKind$1.AtkSpd.PCT.name]: '%',
    [AttributeKind$1.MoveSpd.PCT.name]: '%',
    [AttributeKind$1.AtkRange.PCT.name]: '%',
    [AttributeKind$1.PrjctSpd.PCT.name]: '%',
    [AttributeKind$1.CastRange.PCT.name]: '%',
    [AttributeKind$1.Cooldown.PCT.name]: '%',
    [AttributeKind$1.StaResist.name]: '%',
    [AttributeKind$1.DebuffAmp.name]: '%',
    [AttributeKind$1.Heal.name]: '%',
    [AttributeKind$1.ModelScale.PCT.name]: '%',
    [AttributeKind$1.ArmorPenetrate.PCT.name]: '%',
    [AttributeKind$1.ArmorPenetrate.AMP.name]: '%',
    [AttributeKind$1.ArmorIgnore.name]: '%',
    [AttributeKind$1.ArmorIgnore.BASE.name]: '%',
    [AttributeKind$1.PhyCritChance.name]: '%',
    [AttributeKind$1.PhyCritChance.BASE.name]: '%',
    [AttributeKind$1.MgcCritChance.name]: '%',
    [AttributeKind$1.MgcCritChance.BASE.name]: '%',
    [AttributeKind$1.PureCritChance.name]: '%',
    [AttributeKind$1.PureCritChance.BASE.name]: '%',
    [AttributeKind$1.PhyCritDmg.name]: '%',
    [AttributeKind$1.PhyCritDmg.BASE.name]: '%',
    [AttributeKind$1.MgcCritDmg.name]: '%',
    [AttributeKind$1.MgcCritDmg.BASE.name]: '%',
    [AttributeKind$1.PureCritDmg.name]: '%',
    [AttributeKind$1.PureCritDmg.BASE.name]: '%',
    [AttributeKind$1.MultDmg.name]: '%',
    [AttributeKind$1.BounceDmg.name]: '%',
    [AttributeKind$1.CleaveDmg.name]: '%',
    [AttributeKind$1.CreepDmg.name]: '%',
    [AttributeKind$1.CreepDmg.BASE.name]: '%',
    [AttributeKind$1.EliteDmg.name]: '%',
    [AttributeKind$1.EliteDmg.BASE.name]: '%',
    [AttributeKind$1.ChallengeDmg.name]: '%',
    [AttributeKind$1.ChallengeDmg.BASE.name]: '%',
    [AttributeKind$1.BossDmg.name]: '%',
    [AttributeKind$1.BossDmg.BASE.name]: '%',
    [AttributeKind$1.AtkDmg.name]: '%',
    [AttributeKind$1.AtkDmg.BASE.name]: '%',
    [AttributeKind$1.AbltDmg.name]: '%',
    [AttributeKind$1.AbltDmg.BASE.name]: '%',
    [AttributeKind$1.PhyDmg.name]: '%',
    [AttributeKind$1.PhyDmg.BASE.name]: '%',
    [AttributeKind$1.MgcDmg.name]: '%',
    [AttributeKind$1.MgcDmg.BASE.name]: '%',
    [AttributeKind$1.PureDmg.name]: '%',
    [AttributeKind$1.PureDmg.BASE.name]: '%',
    [AttributeKind$1.AllDmg.name]: '%',
    [AttributeKind$1.AllDmg.BASE.name]: '%',
    [AttributeKind$1.DmgFinal.name]: '%',
    [AttributeKind$1.DmgFinal.BASE.name]: '%',
    [AttributeKind$1.DmgReduce.name]: '%',
    [AttributeKind$1.DmgReduce.BASE.name]: '%',
    [AttributeKind$1.GoldPct.name]: '%',
    [AttributeKind$1.WoodPct.name]: '%',
    [AttributeKind$1.KillPct.name]: '%',
    [AttributeKind$1.ExpPct.name]: '%',
    [AttributeKind$1.RespawnChance.name]: '%',
    [AttributeKind$1.RespawnTime.PCT.name]: '%',
    [AttributeKind$1.SummonDoubleChance.name]: '%',
    [AttributeKind$1.SummonDuration.name]: '%',
    [AttributeKind$1.SummonDmg.name]: '%',
    [AttributeKind$1.HolyDmg.name]: '%',
    [AttributeKind$1.HolyDmg.BASE.name]: '%',
    [AttributeKind$1.NatureDmg.name]: '%',
    [AttributeKind$1.NatureDmg.BASE.name]: '%',
    [AttributeKind$1.FrostDmg.name]: '%',
    [AttributeKind$1.FrostDmg.BASE.name]: '%',
    [AttributeKind$1.FireDmg.name]: '%',
    [AttributeKind$1.FireDmg.BASE.name]: '%',
    [AttributeKind$1.PhysicalDmg.name]: '%',
    [AttributeKind$1.PhysicalDmg.BASE.name]: '%',
    [AttributeKind$1.ShadowDmg.name]: '%',
    [AttributeKind$1.ShadowDmg.BASE.name]: '%',
    [AttributeKind$1.AllFlagDmg.name]: '%',
    [AttributeKind$1.HolyPenetrate.name]: '%',
    [AttributeKind$1.NaturePenetrate.name]: '%',
    [AttributeKind$1.FrostPenetrate.name]: '%',
    [AttributeKind$1.FirePenetrate.name]: '%',
    [AttributeKind$1.PhysicalPenetrate.name]: '%',
    [AttributeKind$1.ShadowPenetrate.name]: '%',
    [AttributeKind$1.HolyResist.name]: '%',
    [AttributeKind$1.NatureResist.name]: '%',
    [AttributeKind$1.FrostResist.name]: '%',
    [AttributeKind$1.FireResist.name]: '%',
    [AttributeKind$1.PhysicalResist.name]: '%',
    [AttributeKind$1.ShadowResist.name]: '%',
    [AttributeKind$1.GainDoubleChance.name]: '%',
    [AttributeKind$1.GainDoubleChance.BASE.name]: '%',
    [AttributeKind$1.DoubleCastChance.name]: '%',
    [AttributeKind$1.DoubleCastChance.BASE.name]: '%',
    [AttributeKind$1.AtkPureChance.name]: '%',
    [AttributeKind$1.MgcPureChance.name]: '%',
    [AttributeKind$1.AtkCleaveChance.name]: '%',
    [AttributeKind$1.AtkCleaveChance.BASE.name]: '%',
    [AttributeKind$1.AtkCleaveDmg.name]: '%',
    [AttributeKind$1.PureCleaveChance.name]: '%',
    [AttributeKind$1.PureCleaveChance.BASE.name]: '%',
    [AttributeKind$1.PureCleaveDmg.name]: '%',
    [AttributeKind$1.AtkBadDmgChance.name]: '%',
    [AttributeKind$1.AtkBadDmgChance.BASE.name]: '%',
    [AttributeKind$1.AtkBadDmg.name]: '%',
    [AttributeKind$1.AtkBadDuration.name]: '%',
    [AttributeKind$1.BadEffect.name]: '%',
    [AttributeKind$1.CardEffect.name]: '%',
    [AttributeKind$1.FatalBlow.name]: '%',
    [AttributeKind$1.BurnDmg.name]: '%',
    [AttributeKind$1.IceDmg.name]: '%',
    [AttributeKind$1.ChallengeDuration.name]: '%',
    [AttributeKind$1.SpawnRatePct.name]: '%',
    [AttributeKind$1.VertRefreshSR.name]: '%',
    [AttributeKind$1.VertRefreshSSR.name]: '%',
    [AttributeKind$1.StrGain.PCT.name]: '%',
    [AttributeKind$1.StrGain.AMP.name]: '%',
    [AttributeKind$1.AgiGain.PCT.name]: '%',
    [AttributeKind$1.AgiGain.AMP.name]: '%',
    [AttributeKind$1.IntGain.PCT.name]: '%',
    [AttributeKind$1.IntGain.AMP.name]: '%',
    [AttributeKind$1.AtkGain.PCT.name]: '%',
    [AttributeKind$1.AtkGain.AMP.name]: '%',
    [AttributeKind$1.AtkPureGain.PCT.name]: '%',
    [AttributeKind$1.AtkPureGain.AMP.name]: '%',
    [AttributeKind$1.HpGain.PCT.name]: '%',
    [AttributeKind$1.HpGain.AMP.name]: '%',
    [AttributeKind$1.PhyFixedGain.PCT.name]: '%',
    [AttributeKind$1.PhyFixedGain.AMP.name]: '%',
    [AttributeKind$1.MgcFixedGain.PCT.name]: '%',
    [AttributeKind$1.MgcFixedGain.AMP.name]: '%',
    [AttributeKind$1.KillGoldPct.name]: '%',
    [AttributeKind$1.KillWoodPct.name]: '%',
    [AttributeKind$1.KillKillPct.name]: '%',
    [AttributeKind$1.KillExpPct.name]: '%',
    [AttributeKind$1.GameShopDiscount.name]: '%',
    [AttributeKind$1.BaseAtkDmg.name]: '%',
    [AttributeKind$1.ShadowArrowDmg.name]: '%',
    [AttributeKind$1.ShadowArrowCooldown.name]: '%',
    [AttributeKind$1.ShadowArrowAoeDmg.name]: '%',
    [AttributeKind$1.ShadowArrowAoeRadius.name]: '%',
    [AttributeKind$1.ShadowSecondaryArrowDmg.name]: '%',
    [AttributeKind$1.GameShopRefreshCostReduce.name]: '%',
    [AttributeKind$1.WeaponStatsPct.name]: '%',
    [AttributeKind$1.BlazingArrowHitDmg.name]: '%',
    [AttributeKind$1.BlazingArrowBoomDmg.name]: '%',
    [AttributeKind$1.BlazingArrowDmg.name]: '%',
    [AttributeKind$1.BlazingArrowAoeRadius.name]: '%',
    [AttributeKind$1.BlazingArrowCooldown.name]: '%',
    [AttributeKind$1.IceArrowDmg.name]: '%',
    [AttributeKind$1.IceArrowProjectSpd.name]: '%',
    [AttributeKind$1.SmallIceArrowDmg.name]: '%',
    [AttributeKind$1.SkyThunderDmg.name]: '%',
    [AttributeKind$1.MagneticStormDmg.name]: '%',
    [AttributeKind$1.MagneticStormRadius.name]: '%',
    [AttributeKind$1.EMFieldDmg.name]: '%',
    [AttributeKind$1.BlitzballDmg.name]: '%',
    [AttributeKind$1.SwordDmg.name]: '%',
    [AttributeKind$1.SwordProjectSpd.name]: '%',
    [AttributeKind$1.SwordScale.name]: '%',
    [AttributeKind$1.SwordCooldown.name]: '%',
    [AttributeKind$1.ArcaneLaserDmg.name]: '%',
    [AttributeKind$1.ArcaneLaserKeepTime.name]: '%',
    [AttributeKind$1.ArcaneLaserCooldown.name]: '%',
    [AttributeKind$1.ArcaneLaserRadius.name]: '%',
    [AttributeKind$1.ArcaneRayDmg.name]: '%',
    [AttributeKind$1.ArcaneRayKeepTime.name]: '%',
    [AttributeKind$1.FrostNovaDmg.name]: '%',
    [AttributeKind$1.FrostNovaRadius.name]: '%',
    [AttributeKind$1.FrostNovaCooldown.name]: '%',
    [AttributeKind$1.IceArrowCooldown.name]: '%',
    [AttributeKind$1.LightningChainDmg.name]: '%',
    [AttributeKind$1.LonBlastingRadius.name]: '%',
    [AttributeKind$1.LonBlastingDmg.name]: '%',
    [AttributeKind$1.LightningChainCooldown.name]: '%',
    [AttributeKind$1.SkyThunderCooldown.name]: '%',
    [AttributeKind$1.EarthQuakeDmg.name]: '%',
    [AttributeKind$1.EarthQuakeRadius.name]: '%',
    [AttributeKind$1.EmbersDmg.name]: '%',
    [AttributeKind$1.TornadoDmg.name]: '%',
    [AttributeKind$1.TornadoKeepTime.name]: '%',
    [AttributeKind$1.TornadoRadius.name]: '%',
    [AttributeKind$1.TornadoMoveSpd.name]: '%',
    [AttributeKind$1.DianCiWangDmg.name]: '%',
    [AttributeKind$1.DianCiWangRadius.name]: '%',
    [AttributeKind$1.DianCiWangCooldown.name]: '%',
    [AttributeKind$1.MeteoriteDmg.name]: '%',
    [AttributeKind$1.MeteoriteCooldown.name]: '%',
    [AttributeKind$1.MeteoriteRadius.name]: '%',
    [AttributeKind$1.FireBallDmg.name]: '%',
    [AttributeKind$1.FireBallKeepTime.name]: '%',
    [AttributeKind$1.FireBallRadius.name]: '%',
    [AttributeKind$1.FireBallMoveSpd.name]: '%',
    [AttributeKind$1.BurntFrostDmg.name]: '%',
    [AttributeKind$1.HurricaneDmg.name]: '%',
    [AttributeKind$1.VacuumDmg.name]: '%',
    [AttributeKind$1.Main.AMP_1.name]: '%',
    [AttributeKind$1.Secondary.AMP_1.name]: '%',
    [AttributeKind$1.AllStats.AMP_1.name]: '%',
    [AttributeKind$1.Strength.AMP_1.name]: '%',
    [AttributeKind$1.Agility.AMP_1.name]: '%',
    [AttributeKind$1.Intellect.AMP_1.name]: '%',
    [AttributeKind$1.Atk.AMP_1.name]: '%',
    [AttributeKind$1.AtkPure.AMP_1.name]: '%',
    [AttributeKind$1.PhyFixDmg.AMP_1.name]: '%',
    [AttributeKind$1.MgcFixDmg.AMP_1.name]: '%',
    [AttributeKind$1.HpLimit.AMP_1.name]: '%',
    [AttributeKind$1.Armor.AMP_1.name]: '%',
    [AttributeKind$1.HolyAbilitySpellRadius.name]: '%',
    [AttributeKind$1.NatureAbilitySpellRadius.name]: '%',
    [AttributeKind$1.FrostAbilitySpellRadius.name]: '%',
    [AttributeKind$1.FireAbilitySpellRadius.name]: '%',
    [AttributeKind$1.PhysicalAbilitySpellRadius.name]: '%',
    [AttributeKind$1.ShadowAbilitySpellRadius.name]: '%',
    [AttributeKind$1.HolyAbilityCooldown.name]: '%',
    [AttributeKind$1.NatureAbilityCooldown.name]: '%',
    [AttributeKind$1.FrostAbilityCooldown.name]: '%',
    [AttributeKind$1.FireAbilityCooldown.name]: '%',
    [AttributeKind$1.PhysicalAbilityCooldown.name]: '%',
    [AttributeKind$1.ShadowAbilityCooldown.name]: '%',
    [AttributeKind$1.HolyReduceResistPct.name]: '%',
    [AttributeKind$1.NatureReduceResistPct.name]: '%',
    [AttributeKind$1.FrostReduceResistPct.name]: '%',
    [AttributeKind$1.FireReduceResistPct.name]: '%',
    [AttributeKind$1.PhysicalReduceResistPct.name]: '%',
    [AttributeKind$1.ShadowReduceResistPct.name]: '%',
    [AttributeKind$1.MiningSpd.name]: '%',
    [AttributeKind$1.GameShopCostReduce.name]: '%',
    [AttributeKind$1.ArchiveDmg.name]: '%',
    [AttributeKind$1.ArchiveDmg.BASE.name]: '%',
    [AttributeKind$1.Main.AMP_2.name]: '%',
    [AttributeKind$1.Secondary.AMP_2.name]: '%',
    [AttributeKind$1.AllStats.AMP_2.name]: '%',
    [AttributeKind$1.Strength.AMP_2.name]: '%',
    [AttributeKind$1.Agility.AMP_2.name]: '%',
    [AttributeKind$1.Intellect.AMP_2.name]: '%',
    [AttributeKind$1.Atk.AMP_2.name]: '%',
    [AttributeKind$1.AtkPure.AMP_2.name]: '%',
    [AttributeKind$1.PhyFixDmg.AMP_2.name]: '%',
    [AttributeKind$1.MgcFixDmg.AMP_2.name]: '%',
    [AttributeKind$1.HpLimit.AMP_2.name]: '%',
    [AttributeKind$1.Armor.AMP_2.name]: '%',
    [AttributeKind$1.ThunderDmgFactor.name]: '%',
    [AttributeKind$1.ArcaneRayCooldown.name]: '%',
    [AttributeKind$1.LightningBounceCount.name]: '%',
    [AttributeKind$1.EarthquakeCooldown.name]: '%',
    [AttributeKind$1.TornadoCooldown.name]: '%',
    [AttributeKind$1.HurricaneCooldown.name]: '%',
    [AttributeKind$1.FireballCooldown.name]: '%',
    [AttributeKind$1.FinalDamageCalculation.name]: '%',
    [AttributeKind$1.Main.AMP_3.name]: '%',
    [AttributeKind$1.Secondary.AMP_3.name]: '%',
    [AttributeKind$1.AllStats.AMP_3.name]: '%',
    [AttributeKind$1.Strength.AMP_3.name]: '%',
    [AttributeKind$1.Agility.AMP_3.name]: '%',
    [AttributeKind$1.Intellect.AMP_3.name]: '%',
    [AttributeKind$1.Atk.AMP_3.name]: '%',
    [AttributeKind$1.AtkPure.AMP_3.name]: '%',
    [AttributeKind$1.PhyFixDmg.AMP_3.name]: '%',
    [AttributeKind$1.MgcFixDmg.AMP_3.name]: '%',
    [AttributeKind$1.HpLimit.AMP_3.name]: '%',
    [AttributeKind$1.Armor.AMP_3.name]: '%',
    [AttributeKind$1.StrGain.AMP_3.name]: '%',
    [AttributeKind$1.AgiGain.AMP_3.name]: '%',
    [AttributeKind$1.IntGain.AMP_3.name]: '%',
    [AttributeKind$1.AtkGain.AMP_3.name]: '%',
    [AttributeKind$1.PhyFixedGain.AMP_3.name]: '%',
    [AttributeKind$1.MgcFixedGain.AMP_3.name]: '%',
    [AttributeKind$1.HpGain.AMP_3.name]: '%',
    [AttributeKind$1.PhyCritDmg.AMP.name]: '%',
    [AttributeKind$1.MgcCritDmg.AMP.name]: '%',
    [AttributeKind$1.CreepDmg.AMP.name]: '%',
    [AttributeKind$1.EliteDmg.AMP.name]: '%',
    [AttributeKind$1.ChallengeDmg.AMP.name]: '%',
    [AttributeKind$1.BossDmg.AMP.name]: '%',
    [AttributeKind$1.AtkDmg.AMP.name]: '%',
    [AttributeKind$1.AbltDmg.AMP.name]: '%',
    [AttributeKind$1.PhyDmg.AMP.name]: '%',
    [AttributeKind$1.MgcDmg.AMP.name]: '%',
    [AttributeKind$1.PureDmg.AMP.name]: '%',
    [AttributeKind$1.HolyDmg.AMP.name]: '%',
    [AttributeKind$1.NatureDmg.AMP.name]: '%',
    [AttributeKind$1.FrostDmg.AMP.name]: '%',
    [AttributeKind$1.FireDmg.AMP.name]: '%',
    [AttributeKind$1.PhysicalDmg.AMP.name]: '%',
    [AttributeKind$1.ShadowDmg.AMP.name]: '%',
    [AttributeKind$1.FinalDamageCalculation1.name]: '%',
    [AttributeKind$1.HolyDmg.AMP2.name]: '%',
    [AttributeKind$1.NatureDmg.AMP2.name]: '%',
    [AttributeKind$1.FrostDmg.AMP2.name]: '%',
    [AttributeKind$1.FireDmg.AMP2.name]: '%',
    [AttributeKind$1.PhysicalDmg.AMP2.name]: '%',
    [AttributeKind$1.ShadowDmg.AMP2.name]: '%',
    [AttributeKind$1.FinalHpRegen.name]: '%',
    [AttributeKind$1.AtkSpd.TOTAL.name]: '%',
    [AttributeKind$1.DmgAmp.name]: '%',
    [AttributeKind$1.AllDmg.AMP.name]: '%',
    [AttributeKind$1.FinalAllDmg.name]: '%',
    [AttributeKind$1.FinalPhyDmg.name]: '%',
    [AttributeKind$1.FinalMagDmg.name]: '%',
    [AttributeKind$1.Main.AMP_4.name]: '%',
    [AttributeKind$1.Secondary.AMP_4.name]: '%',
    [AttributeKind$1.AllStats.AMP_4.name]: '%',
    [AttributeKind$1.Strength.AMP_4.name]: '%',
    [AttributeKind$1.Agility.AMP_4.name]: '%',
    [AttributeKind$1.Intellect.AMP_4.name]: '%',
    [AttributeKind$1.Atk.AMP_4.name]: '%',
    [AttributeKind$1.PhyFixDmg.AMP_4.name]: '%',
    [AttributeKind$1.MgcFixDmg.AMP_4.name]: '%',
    [AttributeKind$1.AtkPure.AMP_4.name]: '%',
    [AttributeKind$1.HpLimit.AMP_4.name]: '%',
    [AttributeKind$1.Armor.AMP_4.name]: '%',
    [AttributeKind$1.PhyCritDmg.AMP_1.name]: '%',
    [AttributeKind$1.MgcCritDmg.AMP_1.name]: '%',
    [AttributeKind$1.PureCritDmg.AMP_1.name]: '%',
    [AttributeKind$1.CreepDmg.AMP_1.name]: '%',
    [AttributeKind$1.EliteDmg.AMP_1.name]: '%',
    [AttributeKind$1.ChallengeDmg.AMP_1.name]: '%',
    [AttributeKind$1.BossDmg.AMP_1.name]: '%',
    [AttributeKind$1.ArchiveDmg.AMP_1.name]: '%',
    [AttributeKind$1.AtkDmg.AMP_1.name]: '%',
    [AttributeKind$1.AbltDmg.AMP_1.name]: '%',
    [AttributeKind$1.PhyDmg.AMP_1.name]: '%',
    [AttributeKind$1.MgcDmg.AMP_1.name]: '%',
    [AttributeKind$1.PureDmg.AMP_1.name]: '%',
    [AttributeKind$1.AllDmg.AMP_1.name]: '%',
    [AttributeKind$1.DmgFinal.AMP_1.name]: '%',
    [AttributeKind$1.HolyDmg.AMP_1.name]: '%',
    [AttributeKind$1.NatureDmg.AMP_1.name]: '%',
    [AttributeKind$1.FrostDmg.AMP_1.name]: '%',
    [AttributeKind$1.FireDmg.AMP_1.name]: '%',
    [AttributeKind$1.PhysicalDmg.AMP_1.name]: '%',
    [AttributeKind$1.ShadowDmg.AMP_1.name]: '%'
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

  var _a, _b, _c, _d, _e;
  if (GameUI.CustomUIConfig().tools == undefined) GameUI.CustomUIConfig().tools = {};
  ENV_NAME = $.GetContextPanel().layoutfile;
  var EventManager = (_a = class extends GameUI.CustomUIConfig().tools.EventManager {}, __setFunctionName(_a, "EventManager"), _a.sEnvName = ENV_NAME, _a);
  var NetEventData = (_b = class extends GameUI.CustomUIConfig().tools.NetEventData {}, __setFunctionName(_b, "NetEventData"), _b.sEnvName = ENV_NAME, _b);
  (_c = class extends GameUI.CustomUIConfig().tools.Keybinds {}, __setFunctionName(_c, "Keybinds"), _c.sEnvName = ENV_NAME, _c);
  (_d = class extends GameUI.CustomUIConfig().tools.Mousebinds {}, __setFunctionName(_d, "Mousebinds"), _d.sEnvName = ENV_NAME, _d);
  GameUI.CustomUIConfig().tools.ParticleManager_s2c;
  GameUI.CustomUIConfig().tools.AttributeSystem;
  var AttributeKind = GameUI.CustomUIConfig().tools.AttributeKind;
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

  const CfgGetter_settings_common = useSystemConfig('settings_common');

  $.GetContextPanel().ClearPanelEvent("ontooltiploaded");
  $.GetContextPanel().SetPanelEvent('ontooltiploaded', () => {
    var _a;
    const {
      iEntID
    } = (_a = GetTooltipParams('attribute_tooltip', $.GetContextPanel())) !== null && _a !== void 0 ? _a : {};
    render(() => createComponent(AttributeTooltip, {
      iEntID: iEntID
    }), $.GetContextPanel());
  });
  function AttributeTooltip(props) {
    NetEventData.GetTableValue('hero_' + props.iEntID, 'name');
    const tGroup1 = ['10600078', '10600088', '10600036', '10600118', '10600120', '10600156', '10600152', '10600162', '10600100', '10600130', '10600132', '10600486'];
    const tGroup2 = ['10600082', '10600106', '10600041', '10600124', '10600126', '10600158', '10600154', '10600164', '10600150', '10600131', '10600133', '10600477'];
    const tGroup3 = ['10600019', '10600024', '10600029', '10600034', '10600039', '10600044', '10600054', '10600076', '10600177', '10600173', '10600174', '10600175'];
    const tGroup4 = ['10600020', '10600025', '10600030', '10600035', '10600040', '10600045', '10600055', '10600077', '10600190', '10600186', '10600187', '10600188'];
    const tGroup5 = ['10600381', '10600382', '10600383', '10600384', '10600386', '10600387', '10600388', '10600389', '10600300', '10600301', '10600303', '10600302'];
    const tGroup6 = ['10600416', '10600417', '10600418', '10600419', '10600421', '10600422', '10600423', '10600424', '10600181', '10600182', '10600184', '10600183'];
    const tGroup7 = ['10600214', '10600212', '10600206', '10600146', '10600256', '10600061', '10600056', '10600116', '10600255'];
    const tGroup8 = ['10600216', '10600210', '10600208', '10600148', '10600257', '10600108', '10600198', '10600111', '10600166'];
    const tGroup9 = ['10600444', '10600445', '10600446', '10600447', '10600449', '10600450', '10600451', '10600452'];
    const tGroup10 = ['10600460', '10600461', '10600462', '10600463', '10600464', '10600465', '10600466', '10600467', '10600468', '10600469'];
    const tGroup11 = ['10600471', '10600472', '10600473', '10600474', '10600475', '10600476'];
    const tGroup12 = ['10600497', '10600498', '10600499', '10600500', '10600501', '10600502', '10600504', '10600505'];
    const tGroup13 = ['10600506', '10600507', '10600509', '10600510', '10600511', '10600512', '10600514', '10600515', '10600516', '10600517'];
    const tGroup14 = ['10600521', '10600522', '10600523', '10600524', '10600525', '10600526'];
    const tGroup15 = ['10600136', '10600137', '10600138', '10600139', '10600141', '10600142', '10600143'];
    return (() => {
      const _el$ = createElement("Panel", {
          "class": "AttributeTooltip"
        }, null);
        createElement("Panel", {
          "class": "BG"
        }, _el$);
        const _el$3 = createElement("Panel", {
          "class": "Body"
        }, _el$),
        _el$4 = createElement("Panel", {
          "class": "Head"
        }, _el$3);
        createElement("Panel", {
          "class": "Line"
        }, _el$4);
        createElement("Label", {
          text: '#AttributeTooltipTitle'
        }, _el$4);
        const _el$7 = createElement("Panel", {
          "class": "Body"
        }, _el$3);
      insert(_el$7, createComponent(Show, {
        get when() {
          return Entities.IsRealHero(props.iEntID);
        },
        get children() {
          return [(() => {
            const _el$8 = createElement("Panel", {
                "class": "Body"
              }, null),
              _el$9 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$0 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$1 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$10 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$11 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$12 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$13 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$14 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$15 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$16 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$17 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$18 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$19 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$20 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8),
              _el$21 = createElement("Panel", {
                "class": "AttributeBody"
              }, _el$8);
            insert(_el$9, createComponent(Index, {
              each: tGroup1,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$0, createComponent(Index, {
              each: tGroup2,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$1, createComponent(Index, {
              each: tGroup3,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$10, createComponent(Index, {
              each: tGroup4,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$11, createComponent(Index, {
              each: tGroup5,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$12, createComponent(Index, {
              each: tGroup6,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$13, createComponent(Index, {
              each: tGroup7,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$14, createComponent(Index, {
              each: tGroup8,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$15, createComponent(Index, {
              each: tGroup9,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$16, createComponent(Index, {
              each: tGroup10,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$17, createComponent(Index, {
              each: tGroup11,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$18, createComponent(Index, {
              each: tGroup12,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$19, createComponent(Index, {
              each: tGroup13,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$20, createComponent(Index, {
              each: tGroup14,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            insert(_el$21, createComponent(Index, {
              each: tGroup15,
              children: (getID, i) => {
                return createComponent(AttributeRow, {
                  get id() {
                    return getID();
                  },
                  get ent_id() {
                    return props.iEntID;
                  }
                });
              }
            }));
            return _el$8;
          })(), (() => {
            const _el$22 = createElement("Panel", {
              "class": "AttributeDetails"
            }, null);
            insert(_el$22, createComponent(Index, {
              get each() {
                return [AttributeKind.Strength, AttributeKind.Agility, AttributeKind.Intellect];
              },
              children: (getAttribute, i) => {
                const getName = () => getAttribute().name;
                const getDetails = () => {
                  var _a, _b;
                  return (_b = (_a = CfgGetter_settings_common()) === null || _a === void 0 ? void 0 : _a[`${getName()}2OtherAttributes`]) === null || _b === void 0 ? void 0 : _b.split('|');
                };
                return (() => {
                  const _el$23 = createElement("Panel", {
                      get id() {
                        return getName();
                      },
                      get ["class"]() {
                        return classNames('AttributeDetailRow');
                      }
                    }, null);
                    createElement("Panel", {
                      "class": "AttributeIcon"
                    }, _el$23);
                    const _el$25 = createElement("Panel", {
                      "class": "Body"
                    }, _el$23);
                  insert(_el$25, createComponent(Index, {
                    get each() {
                      return getDetails();
                    },
                    children: (getDetail, i) => {
                      const getID = () => getDetail().split('=')[0];
                      const getVal = () => getDetail().split('=')[1];
                      const getTotalVal = () => {
                        let fVal = Math.max(getAttribute().Get(props.iEntID) * Number(getVal()), 0);
                        return fVal;
                      };
                      return (() => {
                        const _el$26 = createElement("Label", {
                          id: "Details",
                          text: "#AttributeDetails",
                          html: true,
                          get dialogVariables() {
                            return {
                              'val': getVal(),
                              'id': $.Localize('#' + getID()),
                              'total_val': FormatNumber(getTotalVal(), 2)
                            };
                          }
                        }, null);
                        effect(_$p => setProp(_el$26, "dialogVariables", {
                          'val': getVal(),
                          'id': $.Localize('#' + getID()),
                          'total_val': FormatNumber(getTotalVal(), 2)
                        }, _$p));
                        return _el$26;
                      })();
                    }
                  }));
                  effect(_p$ => {
                    const _v$ = getName(),
                      _v$2 = classNames('AttributeDetailRow');
                    _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$23, "id", _v$, _p$._v$));
                    _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$23, "class", _v$2, _p$._v$2));
                    return _p$;
                  }, {
                    _v$: undefined,
                    _v$2: undefined
                  });
                  return _el$23;
                })();
              }
            }));
            return _el$22;
          })()];
        }
      }));
      return _el$;
    })();
  }
  function AttributeRow(params) {
    const [local, props] = splitProps(params, ['id', 'val', 'ent_id']);
    const getName = () => $.Localize("#" + local.id);
    const getVal = () => {
      var _a;
      return (local.val ? local.val : FormatNumber(ID2Attribute[local.id].Get(local.ent_id), 2)) + ((_a = PctUnitAttributes[ID2Attribute[local.id].name]) !== null && _a !== void 0 ? _a : '');
    };
    return (() => {
      const _el$27 = createElement("Panel", mergeProps(props, {
          get ["class"]() {
            return classNames('AttributeRow');
          }
        }), null),
        _el$28 = createElement("Label", {
          get text() {
            return getName();
          }
        }, _el$27),
        _el$29 = createElement("Label", {
          get text() {
            return getVal();
          },
          html: true
        }, _el$27);
      spread(_el$27, mergeProps(props, {
        get ["class"]() {
          return classNames('AttributeRow');
        }
      }), true);
      setProp(_el$28, "className", "Name");
      setProp(_el$29, "className", "Value");
      effect(_p$ => {
        const _v$3 = getName(),
          _v$4 = getVal();
        _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$28, "text", _v$3, _p$._v$3));
        _v$4 !== _p$._v$4 && (_p$._v$4 = setProp(_el$29, "text", _v$4, _p$._v$4));
        return _p$;
      }, {
        _v$3: undefined,
        _v$4: undefined
      });
      return _el$27;
    })();
  }

}));