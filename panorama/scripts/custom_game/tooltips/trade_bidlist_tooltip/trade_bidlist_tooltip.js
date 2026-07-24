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
  function Index(props) {
    const fallback = "fallback" in props && {
      fallback: () => props.fallback
    };
    return createMemo(indexArray(() => props.each, props.children, fallback || undefined));
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
      createComponent: createComponent$1,
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
      return $.CreatePanel('Panel', root, '', {
          style: 'visibility: collapse;'
      });
  })();
  const { render: _render, effect, createComponent, createElement, insert, setProp} = createRenderer({
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

  var lib = {};

  var cuint = {};

  var uint32$1 = {exports: {}};

  /**
  	C-like unsigned 32 bits integers in Javascript
  	Copyright (C) 2013, Pierre Curto
  	MIT license
   */
  var uint32 = uint32$1.exports;

  var hasRequiredUint32;

  function requireUint32 () {
  	if (hasRequiredUint32) return uint32$1.exports;
  	hasRequiredUint32 = 1;
  	(function (module) {
  (function (root) {

  			// Local cache for typical radices
  			({
  				36: UINT32( Math.pow(36, 5) )
  			,	16: UINT32( Math.pow(16, 7) )
  			,	10: UINT32( Math.pow(10, 9) )
  			,	2:  UINT32( Math.pow(2, 30) )
  			});
  			({
  				36: UINT32(36)
  			,	16: UINT32(16)
  			,	10: UINT32(10)
  			,	2:  UINT32(2)
  			});

  			/**
  			 *	Represents an unsigned 32 bits integer
  			 * @constructor
  			 * @param {Number|String|Number} low bits     | integer as a string 		 | integer as a number
  			 * @param {Number|Number|Undefined} high bits | radix (optional, default=10)
  			 * @return 
  			 */
  			function UINT32 (l, h) {
  				if ( !(this instanceof UINT32) )
  					return new UINT32(l, h)

  				this._low = 0;
  				this._high = 0;
  				this.remainder = null;
  				if (typeof h == 'undefined')
  					return fromNumber.call(this, l)

  				if (typeof l == 'string')
  					return fromString.call(this, l, h)

  				fromBits.call(this, l, h);
  			}

  			/**
  			 * Set the current _UINT32_ object with its low and high bits
  			 * @method fromBits
  			 * @param {Number} low bits
  			 * @param {Number} high bits
  			 * @return ThisExpression
  			 */
  			function fromBits (l, h) {
  				this._low = l | 0;
  				this._high = h | 0;

  				return this
  			}
  			UINT32.prototype.fromBits = fromBits;

  			/**
  			 * Set the current _UINT32_ object from a number
  			 * @method fromNumber
  			 * @param {Number} number
  			 * @return ThisExpression
  			 */
  			function fromNumber (value) {
  				this._low = value & 0xFFFF;
  				this._high = value >>> 16;

  				return this
  			}
  			UINT32.prototype.fromNumber = fromNumber;

  			/**
  			 * Set the current _UINT32_ object from a string
  			 * @method fromString
  			 * @param {String} integer as a string
  			 * @param {Number} radix (optional, default=10)
  			 * @return ThisExpression
  			 */
  			function fromString (s, radix) {
  				var value = parseInt(s, radix || 10);

  				this._low = value & 0xFFFF;
  				this._high = value >>> 16;

  				return this
  			}
  			UINT32.prototype.fromString = fromString;

  			/**
  			 * Convert this _UINT32_ to a number
  			 * @method toNumber
  			 * @return {Number} the converted UINT32
  			 */
  			UINT32.prototype.toNumber = function () {
  				return (this._high * 65536) + this._low
  			};

  			/**
  			 * Convert this _UINT32_ to a string
  			 * @method toString
  			 * @param {Number} radix (optional, default=10)
  			 * @return {String} the converted UINT32
  			 */
  			UINT32.prototype.toString = function (radix) {
  				return this.toNumber().toString(radix || 10)
  			};

  			/**
  			 * Add two _UINT32_. The current _UINT32_ stores the result
  			 * @method add
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.add = function (other) {
  				var a00 = this._low + other._low;
  				var a16 = a00 >>> 16;

  				a16 += this._high + other._high;

  				this._low = a00 & 0xFFFF;
  				this._high = a16 & 0xFFFF;

  				return this
  			};

  			/**
  			 * Subtract two _UINT32_. The current _UINT32_ stores the result
  			 * @method subtract
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.subtract = function (other) {
  				//TODO inline
  				return this.add( other.clone().negate() )
  			};

  			/**
  			 * Multiply two _UINT32_. The current _UINT32_ stores the result
  			 * @method multiply
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.multiply = function (other) {
  				/*
  					a = a00 + a16
  					b = b00 + b16
  					a*b = (a00 + a16)(b00 + b16)
  						= a00b00 + a00b16 + a16b00 + a16b16

  					a16b16 overflows the 32bits
  				 */
  				var a16 = this._high;
  				var a00 = this._low;
  				var b16 = other._high;
  				var b00 = other._low;

  		/* Removed to increase speed under normal circumstances (i.e. not multiplying by 0 or 1)
  				// this == 0 or other == 1: nothing to do
  				if ((a00 == 0 && a16 == 0) || (b00 == 1 && b16 == 0)) return this

  				// other == 0 or this == 1: this = other
  				if ((b00 == 0 && b16 == 0) || (a00 == 1 && a16 == 0)) {
  					this._low = other._low
  					this._high = other._high
  					return this
  				}
  		*/

  				var c16, c00;
  				c00 = a00 * b00;
  				c16 = c00 >>> 16;

  				c16 += a16 * b00;
  				c16 &= 0xFFFF;		// Not required but improves performance
  				c16 += a00 * b16;

  				this._low = c00 & 0xFFFF;
  				this._high = c16 & 0xFFFF;

  				return this
  			};

  			/**
  			 * Divide two _UINT32_. The current _UINT32_ stores the result.
  			 * The remainder is made available as the _remainder_ property on
  			 * the _UINT32_ object. It can be null, meaning there are no remainder.
  			 * @method div
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.div = function (other) {
  				if ( (other._low == 0) && (other._high == 0) ) throw Error('division by zero')

  				// other == 1
  				if (other._high == 0 && other._low == 1) {
  					this.remainder = new UINT32(0);
  					return this
  				}

  				// other > this: 0
  				if ( other.gt(this) ) {
  					this.remainder = this.clone();
  					this._low = 0;
  					this._high = 0;
  					return this
  				}
  				// other == this: 1
  				if ( this.eq(other) ) {
  					this.remainder = new UINT32(0);
  					this._low = 1;
  					this._high = 0;
  					return this
  				}

  				// Shift the divisor left until it is higher than the dividend
  				var _other = other.clone();
  				var i = -1;
  				while ( !this.lt(_other) ) {
  					// High bit can overflow the default 16bits
  					// Its ok since we right shift after this loop
  					// The overflown bit must be kept though
  					_other.shiftLeft(1, true);
  					i++;
  				}

  				// Set the remainder
  				this.remainder = this.clone();
  				// Initialize the current result to 0
  				this._low = 0;
  				this._high = 0;
  				for (; i >= 0; i--) {
  					_other.shiftRight(1);
  					// If shifted divisor is smaller than the dividend
  					// then subtract it from the dividend
  					if ( !this.remainder.lt(_other) ) {
  						this.remainder.subtract(_other);
  						// Update the current result
  						if (i >= 16) {
  							this._high |= 1 << (i - 16);
  						} else {
  							this._low |= 1 << i;
  						}
  					}
  				}

  				return this
  			};

  			/**
  			 * Negate the current _UINT32_
  			 * @method negate
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.negate = function () {
  				var v = ( ~this._low & 0xFFFF ) + 1;
  				this._low = v & 0xFFFF;
  				this._high = (~this._high + (v >>> 16)) & 0xFFFF;

  				return this
  			};

  			/**
  			 * Equals
  			 * @method eq
  			 * @param {Object} other UINT32
  			 * @return {Boolean}
  			 */
  			UINT32.prototype.equals = UINT32.prototype.eq = function (other) {
  				return (this._low == other._low) && (this._high == other._high)
  			};

  			/**
  			 * Greater than (strict)
  			 * @method gt
  			 * @param {Object} other UINT32
  			 * @return {Boolean}
  			 */
  			UINT32.prototype.greaterThan = UINT32.prototype.gt = function (other) {
  				if (this._high > other._high) return true
  				if (this._high < other._high) return false
  				return this._low > other._low
  			};

  			/**
  			 * Less than (strict)
  			 * @method lt
  			 * @param {Object} other UINT32
  			 * @return {Boolean}
  			 */
  			UINT32.prototype.lessThan = UINT32.prototype.lt = function (other) {
  				if (this._high < other._high) return true
  				if (this._high > other._high) return false
  				return this._low < other._low
  			};

  			/**
  			 * Bitwise OR
  			 * @method or
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.or = function (other) {
  				this._low |= other._low;
  				this._high |= other._high;

  				return this
  			};

  			/**
  			 * Bitwise AND
  			 * @method and
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.and = function (other) {
  				this._low &= other._low;
  				this._high &= other._high;

  				return this
  			};

  			/**
  			 * Bitwise NOT
  			 * @method not
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.not = function() {
  				this._low = ~this._low & 0xFFFF;
  				this._high = ~this._high & 0xFFFF;

  				return this
  			};

  			/**
  			 * Bitwise XOR
  			 * @method xor
  			 * @param {Object} other UINT32
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.xor = function (other) {
  				this._low ^= other._low;
  				this._high ^= other._high;

  				return this
  			};

  			/**
  			 * Bitwise shift right
  			 * @method shiftRight
  			 * @param {Number} number of bits to shift
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.shiftRight = UINT32.prototype.shiftr = function (n) {
  				if (n > 16) {
  					this._low = this._high >> (n - 16);
  					this._high = 0;
  				} else if (n == 16) {
  					this._low = this._high;
  					this._high = 0;
  				} else {
  					this._low = (this._low >> n) | ( (this._high << (16-n)) & 0xFFFF );
  					this._high >>= n;
  				}

  				return this
  			};

  			/**
  			 * Bitwise shift left
  			 * @method shiftLeft
  			 * @param {Number} number of bits to shift
  			 * @param {Boolean} allow overflow
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.shiftLeft = UINT32.prototype.shiftl = function (n, allowOverflow) {
  				if (n > 16) {
  					this._high = this._low << (n - 16);
  					this._low = 0;
  					if (!allowOverflow) {
  						this._high &= 0xFFFF;
  					}
  				} else if (n == 16) {
  					this._high = this._low;
  					this._low = 0;
  				} else {
  					this._high = (this._high << n) | (this._low >> (16-n));
  					this._low = (this._low << n) & 0xFFFF;
  					if (!allowOverflow) {
  						// Overflow only allowed on the high bits...
  						this._high &= 0xFFFF;
  					}
  				}

  				return this
  			};

  			/**
  			 * Bitwise rotate left
  			 * @method rotl
  			 * @param {Number} number of bits to rotate
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.rotateLeft = UINT32.prototype.rotl = function (n) {
  				var v = (this._high << 16) | this._low;
  				v = (v << n) | (v >>> (32 - n));
  				this._low = v & 0xFFFF;
  				this._high = v >>> 16;

  				return this
  			};

  			/**
  			 * Bitwise rotate right
  			 * @method rotr
  			 * @param {Number} number of bits to rotate
  			 * @return ThisExpression
  			 */
  			UINT32.prototype.rotateRight = UINT32.prototype.rotr = function (n) {
  				var v = (this._high << 16) | this._low;
  				v = (v >>> n) | (v << (32 - n));
  				this._low = v & 0xFFFF;
  				this._high = v >>> 16;

  				return this
  			};

  			/**
  			 * Clone the current _UINT32_
  			 * @method clone
  			 * @return {Object} cloned UINT32
  			 */
  			UINT32.prototype.clone = function () {
  				return new UINT32(this._low, this._high)
  			};

  			if (module.exports) {
  				// Node.js
  				module.exports = UINT32;
  			} else {
  				// Browser
  				root['UINT32'] = UINT32;
  			}

  		})(uint32); 
  	} (uint32$1));
  	return uint32$1.exports;
  }

  var uint64$1 = {exports: {}};

  /**
  	C-like unsigned 64 bits integers in Javascript
  	Copyright (C) 2013, Pierre Curto
  	MIT license
   */
  var uint64 = uint64$1.exports;

  var hasRequiredUint64;

  function requireUint64 () {
  	if (hasRequiredUint64) return uint64$1.exports;
  	hasRequiredUint64 = 1;
  	(function (module) {
  (function (root) {

  			// Local cache for typical radices
  			var radixPowerCache = {
  				16: UINT64( Math.pow(16, 5) )
  			,	10: UINT64( Math.pow(10, 5) )
  			,	2:  UINT64( Math.pow(2, 5) )
  			};
  			var radixCache = {
  				16: UINT64(16)
  			,	10: UINT64(10)
  			,	2:  UINT64(2)
  			};

  			/**
  			 *	Represents an unsigned 64 bits integer
  			 * @constructor
  			 * @param {Number} first low bits (8)
  			 * @param {Number} second low bits (8)
  			 * @param {Number} first high bits (8)
  			 * @param {Number} second high bits (8)
  			 * or
  			 * @param {Number} low bits (32)
  			 * @param {Number} high bits (32)
  			 * or
  			 * @param {String|Number} integer as a string 		 | integer as a number
  			 * @param {Number|Undefined} radix (optional, default=10)
  			 * @return 
  			 */
  			function UINT64 (a00, a16, a32, a48) {
  				if ( !(this instanceof UINT64) )
  					return new UINT64(a00, a16, a32, a48)

  				this.remainder = null;
  				if (typeof a00 == 'string')
  					return fromString.call(this, a00, a16)

  				if (typeof a16 == 'undefined')
  					return fromNumber.call(this, a00)

  				fromBits.apply(this, arguments);
  			}

  			/**
  			 * Set the current _UINT64_ object with its low and high bits
  			 * @method fromBits
  			 * @param {Number} first low bits (8)
  			 * @param {Number} second low bits (8)
  			 * @param {Number} first high bits (8)
  			 * @param {Number} second high bits (8)
  			 * or
  			 * @param {Number} low bits (32)
  			 * @param {Number} high bits (32)
  			 * @return ThisExpression
  			 */
  			function fromBits (a00, a16, a32, a48) {
  				if (typeof a32 == 'undefined') {
  					this._a00 = a00 & 0xFFFF;
  					this._a16 = a00 >>> 16;
  					this._a32 = a16 & 0xFFFF;
  					this._a48 = a16 >>> 16;
  					return this
  				}

  				this._a00 = a00 | 0;
  				this._a16 = a16 | 0;
  				this._a32 = a32 | 0;
  				this._a48 = a48 | 0;

  				return this
  			}
  			UINT64.prototype.fromBits = fromBits;

  			/**
  			 * Set the current _UINT64_ object from a number
  			 * @method fromNumber
  			 * @param {Number} number
  			 * @return ThisExpression
  			 */
  			function fromNumber (value) {
  				this._a00 = value & 0xFFFF;
  				this._a16 = value >>> 16;
  				this._a32 = 0;
  				this._a48 = 0;

  				return this
  			}
  			UINT64.prototype.fromNumber = fromNumber;

  			/**
  			 * Set the current _UINT64_ object from a string
  			 * @method fromString
  			 * @param {String} integer as a string
  			 * @param {Number} radix (optional, default=10)
  			 * @return ThisExpression
  			 */
  			function fromString (s, radix) {
  				radix = radix || 10;

  				this._a00 = 0;
  				this._a16 = 0;
  				this._a32 = 0;
  				this._a48 = 0;

  				/*
  					In Javascript, bitwise operators only operate on the first 32 bits 
  					of a number, even though parseInt() encodes numbers with a 53 bits 
  					mantissa.
  					Therefore UINT64(<Number>) can only work on 32 bits.
  					The radix maximum value is 36 (as per ECMA specs) (26 letters + 10 digits)
  					maximum input value is m = 32bits as 1 = 2^32 - 1
  					So the maximum substring length n is:
  					36^(n+1) - 1 = 2^32 - 1
  					36^(n+1) = 2^32
  					(n+1)ln(36) = 32ln(2)
  					n = 32ln(2)/ln(36) - 1
  					n = 5.189644915687692
  					n = 5
  				 */
  				var radixUint = radixPowerCache[radix] || new UINT64( Math.pow(radix, 5) );

  				for (var i = 0, len = s.length; i < len; i += 5) {
  					var size = Math.min(5, len - i);
  					var value = parseInt( s.slice(i, i + size), radix );
  					this.multiply(
  							size < 5
  								? new UINT64( Math.pow(radix, size) )
  								: radixUint
  						)
  						.add( new UINT64(value) );
  				}

  				return this
  			}
  			UINT64.prototype.fromString = fromString;

  			/**
  			 * Convert this _UINT64_ to a number (last 32 bits are dropped)
  			 * @method toNumber
  			 * @return {Number} the converted UINT64
  			 */
  			UINT64.prototype.toNumber = function () {
  				return (this._a16 * 65536) + this._a00
  			};

  			/**
  			 * Convert this _UINT64_ to a string
  			 * @method toString
  			 * @param {Number} radix (optional, default=10)
  			 * @return {String} the converted UINT64
  			 */
  			UINT64.prototype.toString = function (radix) {
  				radix = radix || 10;
  				var radixUint = radixCache[radix] || new UINT64(radix);

  				if ( !this.gt(radixUint) ) return this.toNumber().toString(radix)

  				var self = this.clone();
  				var res = new Array(64);
  				for (var i = 63; i >= 0; i--) {
  					self.div(radixUint);
  					res[i] = self.remainder.toNumber().toString(radix);
  					if ( !self.gt(radixUint) ) break
  				}
  				res[i-1] = self.toNumber().toString(radix);

  				return res.join('')
  			};

  			/**
  			 * Add two _UINT64_. The current _UINT64_ stores the result
  			 * @method add
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.add = function (other) {
  				var a00 = this._a00 + other._a00;

  				var a16 = a00 >>> 16;
  				a16 += this._a16 + other._a16;

  				var a32 = a16 >>> 16;
  				a32 += this._a32 + other._a32;

  				var a48 = a32 >>> 16;
  				a48 += this._a48 + other._a48;

  				this._a00 = a00 & 0xFFFF;
  				this._a16 = a16 & 0xFFFF;
  				this._a32 = a32 & 0xFFFF;
  				this._a48 = a48 & 0xFFFF;

  				return this
  			};

  			/**
  			 * Subtract two _UINT64_. The current _UINT64_ stores the result
  			 * @method subtract
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.subtract = function (other) {
  				return this.add( other.clone().negate() )
  			};

  			/**
  			 * Multiply two _UINT64_. The current _UINT64_ stores the result
  			 * @method multiply
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.multiply = function (other) {
  				/*
  					a = a00 + a16 + a32 + a48
  					b = b00 + b16 + b32 + b48
  					a*b = (a00 + a16 + a32 + a48)(b00 + b16 + b32 + b48)
  						= a00b00 + a00b16 + a00b32 + a00b48
  						+ a16b00 + a16b16 + a16b32 + a16b48
  						+ a32b00 + a32b16 + a32b32 + a32b48
  						+ a48b00 + a48b16 + a48b32 + a48b48

  					a16b48, a32b32, a48b16, a48b32 and a48b48 overflow the 64 bits
  					so it comes down to:
  					a*b	= a00b00 + a00b16 + a00b32 + a00b48
  						+ a16b00 + a16b16 + a16b32
  						+ a32b00 + a32b16
  						+ a48b00
  						= a00b00
  						+ a00b16 + a16b00
  						+ a00b32 + a16b16 + a32b00
  						+ a00b48 + a16b32 + a32b16 + a48b00
  				 */
  				var a00 = this._a00;
  				var a16 = this._a16;
  				var a32 = this._a32;
  				var a48 = this._a48;
  				var b00 = other._a00;
  				var b16 = other._a16;
  				var b32 = other._a32;
  				var b48 = other._a48;

  				var c00 = a00 * b00;

  				var c16 = c00 >>> 16;
  				c16 += a00 * b16;
  				var c32 = c16 >>> 16;
  				c16 &= 0xFFFF;
  				c16 += a16 * b00;

  				c32 += c16 >>> 16;
  				c32 += a00 * b32;
  				var c48 = c32 >>> 16;
  				c32 &= 0xFFFF;
  				c32 += a16 * b16;
  				c48 += c32 >>> 16;
  				c32 &= 0xFFFF;
  				c32 += a32 * b00;

  				c48 += c32 >>> 16;
  				c48 += a00 * b48;
  				c48 &= 0xFFFF;
  				c48 += a16 * b32;
  				c48 &= 0xFFFF;
  				c48 += a32 * b16;
  				c48 &= 0xFFFF;
  				c48 += a48 * b00;

  				this._a00 = c00 & 0xFFFF;
  				this._a16 = c16 & 0xFFFF;
  				this._a32 = c32 & 0xFFFF;
  				this._a48 = c48 & 0xFFFF;

  				return this
  			};

  			/**
  			 * Divide two _UINT64_. The current _UINT64_ stores the result.
  			 * The remainder is made available as the _remainder_ property on
  			 * the _UINT64_ object. It can be null, meaning there are no remainder.
  			 * @method div
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.div = function (other) {
  				if ( (other._a16 == 0) && (other._a32 == 0) && (other._a48 == 0) ) {
  					if (other._a00 == 0) throw Error('division by zero')

  					// other == 1: this
  					if (other._a00 == 1) {
  						this.remainder = new UINT64(0);
  						return this
  					}
  				}

  				// other > this: 0
  				if ( other.gt(this) ) {
  					this.remainder = this.clone();
  					this._a00 = 0;
  					this._a16 = 0;
  					this._a32 = 0;
  					this._a48 = 0;
  					return this
  				}
  				// other == this: 1
  				if ( this.eq(other) ) {
  					this.remainder = new UINT64(0);
  					this._a00 = 1;
  					this._a16 = 0;
  					this._a32 = 0;
  					this._a48 = 0;
  					return this
  				}

  				// Shift the divisor left until it is higher than the dividend
  				var _other = other.clone();
  				var i = -1;
  				while ( !this.lt(_other) ) {
  					// High bit can overflow the default 16bits
  					// Its ok since we right shift after this loop
  					// The overflown bit must be kept though
  					_other.shiftLeft(1, true);
  					i++;
  				}

  				// Set the remainder
  				this.remainder = this.clone();
  				// Initialize the current result to 0
  				this._a00 = 0;
  				this._a16 = 0;
  				this._a32 = 0;
  				this._a48 = 0;
  				for (; i >= 0; i--) {
  					_other.shiftRight(1);
  					// If shifted divisor is smaller than the dividend
  					// then subtract it from the dividend
  					if ( !this.remainder.lt(_other) ) {
  						this.remainder.subtract(_other);
  						// Update the current result
  						if (i >= 48) {
  							this._a48 |= 1 << (i - 48);
  						} else if (i >= 32) {
  							this._a32 |= 1 << (i - 32);
  						} else if (i >= 16) {
  							this._a16 |= 1 << (i - 16);
  						} else {
  							this._a00 |= 1 << i;
  						}
  					}
  				}

  				return this
  			};

  			/**
  			 * Negate the current _UINT64_
  			 * @method negate
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.negate = function () {
  				var v = ( ~this._a00 & 0xFFFF ) + 1;
  				this._a00 = v & 0xFFFF;
  				v = (~this._a16 & 0xFFFF) + (v >>> 16);
  				this._a16 = v & 0xFFFF;
  				v = (~this._a32 & 0xFFFF) + (v >>> 16);
  				this._a32 = v & 0xFFFF;
  				this._a48 = (~this._a48 + (v >>> 16)) & 0xFFFF;

  				return this
  			};

  			/**

  			 * @method eq
  			 * @param {Object} other UINT64
  			 * @return {Boolean}
  			 */
  			UINT64.prototype.equals = UINT64.prototype.eq = function (other) {
  				return (this._a48 == other._a48) && (this._a00 == other._a00)
  					 && (this._a32 == other._a32) && (this._a16 == other._a16)
  			};

  			/**
  			 * Greater than (strict)
  			 * @method gt
  			 * @param {Object} other UINT64
  			 * @return {Boolean}
  			 */
  			UINT64.prototype.greaterThan = UINT64.prototype.gt = function (other) {
  				if (this._a48 > other._a48) return true
  				if (this._a48 < other._a48) return false
  				if (this._a32 > other._a32) return true
  				if (this._a32 < other._a32) return false
  				if (this._a16 > other._a16) return true
  				if (this._a16 < other._a16) return false
  				return this._a00 > other._a00
  			};

  			/**
  			 * Less than (strict)
  			 * @method lt
  			 * @param {Object} other UINT64
  			 * @return {Boolean}
  			 */
  			UINT64.prototype.lessThan = UINT64.prototype.lt = function (other) {
  				if (this._a48 < other._a48) return true
  				if (this._a48 > other._a48) return false
  				if (this._a32 < other._a32) return true
  				if (this._a32 > other._a32) return false
  				if (this._a16 < other._a16) return true
  				if (this._a16 > other._a16) return false
  				return this._a00 < other._a00
  			};

  			/**
  			 * Bitwise OR
  			 * @method or
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.or = function (other) {
  				this._a00 |= other._a00;
  				this._a16 |= other._a16;
  				this._a32 |= other._a32;
  				this._a48 |= other._a48;

  				return this
  			};

  			/**
  			 * Bitwise AND
  			 * @method and
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.and = function (other) {
  				this._a00 &= other._a00;
  				this._a16 &= other._a16;
  				this._a32 &= other._a32;
  				this._a48 &= other._a48;

  				return this
  			};

  			/**
  			 * Bitwise XOR
  			 * @method xor
  			 * @param {Object} other UINT64
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.xor = function (other) {
  				this._a00 ^= other._a00;
  				this._a16 ^= other._a16;
  				this._a32 ^= other._a32;
  				this._a48 ^= other._a48;

  				return this
  			};

  			/**
  			 * Bitwise NOT
  			 * @method not
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.not = function() {
  				this._a00 = ~this._a00 & 0xFFFF;
  				this._a16 = ~this._a16 & 0xFFFF;
  				this._a32 = ~this._a32 & 0xFFFF;
  				this._a48 = ~this._a48 & 0xFFFF;

  				return this
  			};

  			/**
  			 * Bitwise shift right
  			 * @method shiftRight
  			 * @param {Number} number of bits to shift
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.shiftRight = UINT64.prototype.shiftr = function (n) {
  				n %= 64;
  				if (n >= 48) {
  					this._a00 = this._a48 >> (n - 48);
  					this._a16 = 0;
  					this._a32 = 0;
  					this._a48 = 0;
  				} else if (n >= 32) {
  					n -= 32;
  					this._a00 = ( (this._a32 >> n) | (this._a48 << (16-n)) ) & 0xFFFF;
  					this._a16 = (this._a48 >> n) & 0xFFFF;
  					this._a32 = 0;
  					this._a48 = 0;
  				} else if (n >= 16) {
  					n -= 16;
  					this._a00 = ( (this._a16 >> n) | (this._a32 << (16-n)) ) & 0xFFFF;
  					this._a16 = ( (this._a32 >> n) | (this._a48 << (16-n)) ) & 0xFFFF;
  					this._a32 = (this._a48 >> n) & 0xFFFF;
  					this._a48 = 0;
  				} else {
  					this._a00 = ( (this._a00 >> n) | (this._a16 << (16-n)) ) & 0xFFFF;
  					this._a16 = ( (this._a16 >> n) | (this._a32 << (16-n)) ) & 0xFFFF;
  					this._a32 = ( (this._a32 >> n) | (this._a48 << (16-n)) ) & 0xFFFF;
  					this._a48 = (this._a48 >> n) & 0xFFFF;
  				}

  				return this
  			};

  			/**
  			 * Bitwise shift left
  			 * @method shiftLeft
  			 * @param {Number} number of bits to shift
  			 * @param {Boolean} allow overflow
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.shiftLeft = UINT64.prototype.shiftl = function (n, allowOverflow) {
  				n %= 64;
  				if (n >= 48) {
  					this._a48 = this._a00 << (n - 48);
  					this._a32 = 0;
  					this._a16 = 0;
  					this._a00 = 0;
  				} else if (n >= 32) {
  					n -= 32;
  					this._a48 = (this._a16 << n) | (this._a00 >> (16-n));
  					this._a32 = (this._a00 << n) & 0xFFFF;
  					this._a16 = 0;
  					this._a00 = 0;
  				} else if (n >= 16) {
  					n -= 16;
  					this._a48 = (this._a32 << n) | (this._a16 >> (16-n));
  					this._a32 = ( (this._a16 << n) | (this._a00 >> (16-n)) ) & 0xFFFF;
  					this._a16 = (this._a00 << n) & 0xFFFF;
  					this._a00 = 0;
  				} else {
  					this._a48 = (this._a48 << n) | (this._a32 >> (16-n));
  					this._a32 = ( (this._a32 << n) | (this._a16 >> (16-n)) ) & 0xFFFF;
  					this._a16 = ( (this._a16 << n) | (this._a00 >> (16-n)) ) & 0xFFFF;
  					this._a00 = (this._a00 << n) & 0xFFFF;
  				}
  				if (!allowOverflow) {
  					this._a48 &= 0xFFFF;
  				}

  				return this
  			};

  			/**
  			 * Bitwise rotate left
  			 * @method rotl
  			 * @param {Number} number of bits to rotate
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.rotateLeft = UINT64.prototype.rotl = function (n) {
  				n %= 64;
  				if (n == 0) return this
  				if (n >= 32) {
  					// A.B.C.D
  					// B.C.D.A rotl(16)
  					// C.D.A.B rotl(32)
  					var v = this._a00;
  					this._a00 = this._a32;
  					this._a32 = v;
  					v = this._a48;
  					this._a48 = this._a16;
  					this._a16 = v;
  					if (n == 32) return this
  					n -= 32;
  				}

  				var high = (this._a48 << 16) | this._a32;
  				var low = (this._a16 << 16) | this._a00;

  				var _high = (high << n) | (low >>> (32 - n));
  				var _low = (low << n) | (high >>> (32 - n));

  				this._a00 = _low & 0xFFFF;
  				this._a16 = _low >>> 16;
  				this._a32 = _high & 0xFFFF;
  				this._a48 = _high >>> 16;

  				return this
  			};

  			/**
  			 * Bitwise rotate right
  			 * @method rotr
  			 * @param {Number} number of bits to rotate
  			 * @return ThisExpression
  			 */
  			UINT64.prototype.rotateRight = UINT64.prototype.rotr = function (n) {
  				n %= 64;
  				if (n == 0) return this
  				if (n >= 32) {
  					// A.B.C.D
  					// D.A.B.C rotr(16)
  					// C.D.A.B rotr(32)
  					var v = this._a00;
  					this._a00 = this._a32;
  					this._a32 = v;
  					v = this._a48;
  					this._a48 = this._a16;
  					this._a16 = v;
  					if (n == 32) return this
  					n -= 32;
  				}

  				var high = (this._a48 << 16) | this._a32;
  				var low = (this._a16 << 16) | this._a00;

  				var _high = (high >>> n) | (low << (32 - n));
  				var _low = (low >>> n) | (high << (32 - n));

  				this._a00 = _low & 0xFFFF;
  				this._a16 = _low >>> 16;
  				this._a32 = _high & 0xFFFF;
  				this._a48 = _high >>> 16;

  				return this
  			};

  			/**
  			 * Clone the current _UINT64_
  			 * @method clone
  			 * @return {Object} cloned UINT64
  			 */
  			UINT64.prototype.clone = function () {
  				return new UINT64(this._a00, this._a16, this._a32, this._a48)
  			};

  			if (module.exports) {
  				// Node.js
  				module.exports = UINT64;
  			} else {
  				// Browser
  				root['UINT64'] = UINT64;
  			}

  		})(uint64); 
  	} (uint64$1));
  	return uint64$1.exports;
  }

  var hasRequiredCuint;

  function requireCuint () {
  	if (hasRequiredCuint) return cuint;
  	hasRequiredCuint = 1;
  	cuint.UINT32 = /*@__PURE__*/ requireUint32();
  	cuint.UINT64 = /*@__PURE__*/ requireUint64();
  	return cuint;
  }

  var enums = {};

  var hasRequiredEnums;

  function requireEnums () {
  	if (hasRequiredEnums) return enums;
  	hasRequiredEnums = 1;
  	(function (exports) {
  		Object.defineProperty(exports, "__esModule", { value: true });
  		exports.TypeChar = exports.Instance = exports.Type = exports.Universe = void 0;
  		(function (Universe) {
  		    Universe[Universe["INVALID"] = 0] = "INVALID";
  		    Universe[Universe["PUBLIC"] = 1] = "PUBLIC";
  		    Universe[Universe["BETA"] = 2] = "BETA";
  		    Universe[Universe["INTERNAL"] = 3] = "INTERNAL";
  		    Universe[Universe["DEV"] = 4] = "DEV";
  		})(exports.Universe || (exports.Universe = {}));
  		(function (Type) {
  		    Type[Type["INVALID"] = 0] = "INVALID";
  		    Type[Type["INDIVIDUAL"] = 1] = "INDIVIDUAL";
  		    Type[Type["MULTISEAT"] = 2] = "MULTISEAT";
  		    Type[Type["GAMESERVER"] = 3] = "GAMESERVER";
  		    Type[Type["ANON_GAMESERVER"] = 4] = "ANON_GAMESERVER";
  		    Type[Type["PENDING"] = 5] = "PENDING";
  		    Type[Type["CONTENT_SERVER"] = 6] = "CONTENT_SERVER";
  		    Type[Type["CLAN"] = 7] = "CLAN";
  		    Type[Type["CHAT"] = 8] = "CHAT";
  		    Type[Type["P2P_SUPER_SEEDER"] = 9] = "P2P_SUPER_SEEDER";
  		    Type[Type["ANON_USER"] = 10] = "ANON_USER";
  		})(exports.Type || (exports.Type = {}));
  		(function (Instance) {
  		    Instance[Instance["ALL"] = 0] = "ALL";
  		    Instance[Instance["DESKTOP"] = 1] = "DESKTOP";
  		    Instance[Instance["CONSOLE"] = 2] = "CONSOLE";
  		    Instance[Instance["WEB"] = 4] = "WEB";
  		})(exports.Instance || (exports.Instance = {}));
  		(function (TypeChar) {
  		    TypeChar[TypeChar["I"] = 0] = "I";
  		    TypeChar[TypeChar["U"] = 1] = "U";
  		    TypeChar[TypeChar["M"] = 2] = "M";
  		    TypeChar[TypeChar["G"] = 3] = "G";
  		    TypeChar[TypeChar["A"] = 4] = "A";
  		    TypeChar[TypeChar["P"] = 5] = "P";
  		    TypeChar[TypeChar["C"] = 6] = "C";
  		    TypeChar[TypeChar["g"] = 7] = "g";
  		    TypeChar[TypeChar["T"] = 8] = "T";
  		    TypeChar[TypeChar["a"] = 10] = "a";
  		})(exports.TypeChar || (exports.TypeChar = {})); 
  	} (enums));
  	return enums;
  }

  var hasRequiredLib;

  function requireLib () {
  	if (hasRequiredLib) return lib;
  	hasRequiredLib = 1;
  	(function (exports) {
  		var __createBinding = (lib && lib.__createBinding) || (Object.create ? (function(o, m, k, k2) {
  		    if (k2 === undefined) k2 = k;
  		    Object.defineProperty(o, k2, { enumerable: true, get: function() { return m[k]; } });
  		}) : (function(o, m, k, k2) {
  		    if (k2 === undefined) k2 = k;
  		    o[k2] = m[k];
  		}));
  		var __exportStar = (lib && lib.__exportStar) || function(m, exports) {
  		    for (var p in m) if (p !== "default" && !Object.prototype.hasOwnProperty.call(exports, p)) __createBinding(exports, m, p);
  		};
  		Object.defineProperty(exports, "__esModule", { value: true });
  		exports.fromIndividualAccountID = exports.fromAccountID = exports.ID = exports.ChatInstanceFlags = exports.AccountInstanceMask = exports.AccountIDMask = void 0;
  		var cuint_1 = /*@__PURE__*/ requireCuint();
  		var enums_1 = /*@__PURE__*/ requireEnums();
  		exports.AccountIDMask = 0xFFFFFFFF;
  		exports.AccountInstanceMask = 0x000FFFFF;
  		exports.ChatInstanceFlags = {
  		    Clan: (exports.AccountInstanceMask + 1) >> 1,
  		    Lobby: (exports.AccountInstanceMask + 1) >> 2,
  		    MMSLobby: (exports.AccountInstanceMask + 1) >> 3,
  		};
  		var regex = {
  		    steam2: /^STEAM_([0-5]):([0-1]):([0-9]+)$/,
  		    steam3: /^\[([a-zA-Z]):([0-5]):([0-9]+)(:[0-9]+)?\]$/,
  		};
  		var getTypeFromChar = function (char) {
  		    if (enums_1.TypeChar[char])
  		        return enums_1.TypeChar[char];
  		    return enums_1.Type.INVALID;
  		};
  		var ID = (function () {
  		    function ID(input) {
  		        var _this = this;
  		        this.isValid = function () {
  		            if (_this.type <= enums_1.Type.INVALID || _this.type > enums_1.Type.ANON_USER) {
  		                return false;
  		            }
  		            if (_this.universe <= enums_1.Universe.INVALID || _this.universe > enums_1.Universe.DEV) {
  		                return false;
  		            }
  		            if (_this.type === enums_1.Type.INDIVIDUAL && (_this.accountid === 0 || _this.instance > enums_1.Instance.WEB)) {
  		                return false;
  		            }
  		            if (_this.type === enums_1.Type.CLAN && (_this.accountid === 0 || _this.instance !== enums_1.Instance.ALL)) {
  		                return false;
  		            }
  		            if (_this.type === enums_1.Type.GAMESERVER && _this.accountid === 0) {
  		                return false;
  		            }
  		            return true;
  		        };
  		        this.isGroupChat = function () {
  		            return !!(_this.type === enums_1.Type.CHAT && _this.instance & exports.ChatInstanceFlags.Clan);
  		        };
  		        this.isLobby = function () {
  		            return !!(_this.type === enums_1.Type.CHAT && (_this.instance & exports.ChatInstanceFlags.Lobby || _this.instance & exports.ChatInstanceFlags.MMSLobby));
  		        };
  		        this.getSteamID2 = function (format) {
  		            if (_this.type !== enums_1.Type.INDIVIDUAL) {
  		                throw new Error("Can't get Steam2 rendered ID for non-individual ID");
  		            }
  		            else {
  		                var universe = _this.universe;
  		                if (!format && universe === 1) {
  		                    universe = 0;
  		                }
  		                return "STEAM_" + universe + ":" + (_this.accountid & 1) + ":" + Math.floor(_this.accountid / 2);
  		            }
  		        };
  		        this.getSteamID3 = function () {
  		            var char = enums_1.TypeChar[_this.type] || 'i';
  		            if (_this.instance & exports.ChatInstanceFlags.Clan) {
  		                char = 'c';
  		            }
  		            else if (_this.instance & exports.ChatInstanceFlags.Lobby) {
  		                char = 'L';
  		            }
  		            var renderInstance = (_this.type === enums_1.Type.ANON_GAMESERVER ||
  		                _this.type === enums_1.Type.MULTISEAT ||
  		                (_this.type === enums_1.Type.INDIVIDUAL && _this.instance !== enums_1.Instance.DESKTOP));
  		            return "[" + char + ":" + _this.universe + ":" + _this.accountid + (renderInstance ? ':' + _this.instance : '') + "]";
  		        };
  		        this.getSteamID64 = function () {
  		            return new cuint_1.UINT64(_this.accountid, (_this.universe << 24) | (_this.type << 20) | (_this.instance)).toString();
  		        };
  		        this.get2 = this.getSteamID2;
  		        this.steam2 = this.getSteamID2;
  		        this.getSteam2RenderedID = this.getSteamID2;
  		        this.get3 = this.getSteamID3;
  		        this.steam3 = this.getSteamID3;
  		        this.getSteam3RenderedID = this.getSteamID3;
  		        this.get64 = this.getSteamID64;
  		        this.steam64 = this.getSteamID64;
  		        this.toString = this.getSteamID64;
  		        this.getUniverse = function () {
  		            return enums_1.Universe[_this.universe];
  		        };
  		        this.getType = function () {
  		            return enums_1.Type[_this.type];
  		        };
  		        this.getInstance = function () {
  		            return enums_1.Instance[_this.instance];
  		        };
  		        this.getUniverseID = function () {
  		            return _this.universe;
  		        };
  		        this.getTypeID = function () {
  		            return _this.type;
  		        };
  		        this.getInstanceID = function () {
  		            return _this.instance;
  		        };
  		        this.getAccountID = function () {
  		            return _this.accountid;
  		        };
  		        this.getFormat = function () {
  		            return _this.format;
  		        };
  		        this.universe = enums_1.Universe.INVALID;
  		        this.type = enums_1.Type.INVALID;
  		        this.instance = enums_1.Instance.ALL;
  		        this.accountid = 0;
  		        this.format = 'none';
  		        if (!input) {
  		            return;
  		        }
  		        if (regex.steam2.test(input)) {
  		            var matches = input.match(regex.steam2);
  		            this.format = 'steam2';
  		            this.universe = parseInt(matches[1], 10) || enums_1.Universe.PUBLIC;
  		            this.type = enums_1.Type.INDIVIDUAL;
  		            this.instance = enums_1.Instance.DESKTOP;
  		            this.accountid = (parseInt(matches[3], 10) * 2) + parseInt(matches[2], 10);
  		        }
  		        else if (regex.steam3.test(input)) {
  		            var matches = input.match(regex.steam3);
  		            var char = matches[1];
  		            this.format = 'steam3';
  		            this.universe = parseInt(matches[2], 10);
  		            this.accountid = parseInt(matches[3], 10);
  		            if (matches[4]) {
  		                this.instance = parseInt(matches[4].substring(1), 10);
  		            }
  		            else if (char === 'U') {
  		                this.instance = enums_1.Instance.DESKTOP;
  		            }
  		            if (char === 'c') {
  		                this.instance |= exports.ChatInstanceFlags.Clan;
  		                this.type = enums_1.Type.CHAT;
  		            }
  		            else if (char === 'L') {
  		                this.instance |= exports.ChatInstanceFlags.Lobby;
  		                this.type = enums_1.Type.CHAT;
  		            }
  		            else {
  		                this.type = getTypeFromChar(char);
  		            }
  		        }
  		        else if (isNaN(input)) {
  		            throw new Error("Unknown SteamID input format \"" + input + "\"");
  		        }
  		        else {
  		            var x = new cuint_1.UINT64(input.toString(), 10);
  		            this.format = 'steam64';
  		            this.accountid = (x.toNumber() & 0xFFFFFFFF) >>> 0;
  		            this.instance = x.shiftRight(32).toNumber() & 0xFFFFF;
  		            this.type = x.shiftRight(20).toNumber() & 0xF;
  		            this.universe = x.shiftRight(4).toNumber();
  		        }
  		    }
  		    return ID;
  		}());
  		exports.ID = ID;
  		var fromAccountID = function (accountid) {
  		    var x = new ID();
  		    x.universe = enums_1.Universe.PUBLIC;
  		    x.type = enums_1.Type.INDIVIDUAL;
  		    x.instance = enums_1.Instance.DESKTOP;
  		    x.accountid = isNaN(accountid) ? 0 : accountid;
  		    x.format = 'accountid';
  		    return x;
  		};
  		exports.fromAccountID = fromAccountID;
  		exports.fromIndividualAccountID = exports.fromAccountID;
  		__exportStar(/*@__PURE__*/ requireEnums(), exports); 
  	} (lib));
  	return lib;
  }

  var libExports = /*@__PURE__*/ requireLib();

  function AccountID2SteamID(account) {
    return libExports.fromAccountID(Number(account) || 0).getSteamID64();
  }

  if ($.GetContextPanel().paneltype == 'TooltipContents') {
    $.GetContextPanel().ClearPanelEvent("ontooltiploaded");
    $.GetContextPanel().SetPanelEvent("ontooltiploaded", () => {
      var _a;
      const {
        list
      } = (_a = GetTooltipParams('trade_bidlist_tooltip', $.GetContextPanel())) !== null && _a !== void 0 ? _a : {};
      render(() => createComponent(TradeBidListTooltip, {
        list: list
      }), $.GetContextPanel());
    });
  }
  function TradeBidListTooltip(props) {
    return (() => {
      const _el$ = createElement("Panel", {
        id: "TradeBidListTooltip"
      }, null);
      insert(_el$, createComponent(Index, {
        get each() {
          return props.list;
        },
        children: (item, i) => (() => {
          const _el$2 = createElement("Panel", {
              "class": "PriceBidItem"
            }, null),
            _el$3 = createElement("DOTAAvatarImage", {
              nocompendiumborder: true,
              lazy: true,
              get steamid() {
                return AccountID2SteamID(item().buyer_id.toString());
              }
            }, _el$2),
            _el$4 = createElement("DOTAUserName", {
              get steamid() {
                return AccountID2SteamID(item().buyer_id.toString());
              },
              "class": "UserName"
            }, _el$2),
            _el$5 = createElement("Panel", {
              "class": "PriceBox"
            }, _el$2),
            _el$6 = createElement("Label", {
              "class": "Price",
              get text() {
                return item().price;
              }
            }, _el$5);
            createElement("Panel", {
              "class": "Icon"
            }, _el$5);
          setProp(_el$2, "classList", {
            'Valid': i == 0
          });
          setProp(_el$3, "style", {
            width: '36px',
            height: '36px'
          });
          effect(_p$ => {
            const _v$ = AccountID2SteamID(item().buyer_id.toString()),
              _v$2 = AccountID2SteamID(item().buyer_id.toString()),
              _v$3 = item().price;
            _v$ !== _p$._v$ && (_p$._v$ = setProp(_el$3, "steamid", _v$, _p$._v$));
            _v$2 !== _p$._v$2 && (_p$._v$2 = setProp(_el$4, "steamid", _v$2, _p$._v$2));
            _v$3 !== _p$._v$3 && (_p$._v$3 = setProp(_el$6, "text", _v$3, _p$._v$3));
            return _p$;
          }, {
            _v$: undefined,
            _v$2: undefined,
            _v$3: undefined
          });
          return _el$2;
        })()
      }));
      return _el$;
    })();
  }

}));