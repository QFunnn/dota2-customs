--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../node_modules/object-inspect/index.js"
/*!*****************************************************!*\
  !*** ../../../node_modules/object-inspect/index.js ***!
  \*****************************************************/
(module, __unused_webpack_exports, __webpack_require__) {

var hasMap = typeof Map === 'function' && Map.prototype;
var mapSizeDescriptor = Object.getOwnPropertyDescriptor && hasMap ? Object.getOwnPropertyDescriptor(Map.prototype, 'size') : null;
var mapSize = hasMap && mapSizeDescriptor && typeof mapSizeDescriptor.get === 'function' ? mapSizeDescriptor.get : null;
var mapForEach = hasMap && Map.prototype.forEach;
var hasSet = typeof Set === 'function' && Set.prototype;
var setSizeDescriptor = Object.getOwnPropertyDescriptor && hasSet ? Object.getOwnPropertyDescriptor(Set.prototype, 'size') : null;
var setSize = hasSet && setSizeDescriptor && typeof setSizeDescriptor.get === 'function' ? setSizeDescriptor.get : null;
var setForEach = hasSet && Set.prototype.forEach;
var hasWeakMap = typeof WeakMap === 'function' && WeakMap.prototype;
var weakMapHas = hasWeakMap ? WeakMap.prototype.has : null;
var hasWeakSet = typeof WeakSet === 'function' && WeakSet.prototype;
var weakSetHas = hasWeakSet ? WeakSet.prototype.has : null;
var hasWeakRef = typeof WeakRef === 'function' && WeakRef.prototype;
var weakRefDeref = hasWeakRef ? WeakRef.prototype.deref : null;
var booleanValueOf = Boolean.prototype.valueOf;
var objectToString = Object.prototype.toString;
var functionToString = Function.prototype.toString;
var $match = String.prototype.match;
var $slice = String.prototype.slice;
var $replace = String.prototype.replace;
var $toUpperCase = String.prototype.toUpperCase;
var $toLowerCase = String.prototype.toLowerCase;
var $test = RegExp.prototype.test;
var $concat = Array.prototype.concat;
var $join = Array.prototype.join;
var $arrSlice = Array.prototype.slice;
var $floor = Math.floor;
var bigIntValueOf = typeof BigInt === 'function' ? BigInt.prototype.valueOf : null;
var gOPS = Object.getOwnPropertySymbols;
var symToString = typeof Symbol === 'function' && typeof Symbol.iterator === 'symbol' ? Symbol.prototype.toString : null;
var hasShammedSymbols = typeof Symbol === 'function' && typeof Symbol.iterator === 'object';
// ie, `has-tostringtag/shams
var toStringTag = typeof Symbol === 'function' && Symbol.toStringTag && (typeof Symbol.toStringTag === hasShammedSymbols ? 'object' : 'symbol')
    ? Symbol.toStringTag
    : null;
var isEnumerable = Object.prototype.propertyIsEnumerable;

var gPO = (typeof Reflect === 'function' ? Reflect.getPrototypeOf : Object.getPrototypeOf) || (
    [].__proto__ === Array.prototype // eslint-disable-line no-proto
        ? function (O) {
            return O.__proto__; // eslint-disable-line no-proto
        }
        : null
);

function addNumericSeparator(num, str) {
    if (
        num === Infinity
        || num === -Infinity
        || num !== num
        || (num && num > -1000 && num < 1000)
        || $test.call(/e/, str)
    ) {
        return str;
    }
    var sepRegex = /[0-9](?=(?:[0-9]{3})+(?![0-9]))/g;
    if (typeof num === 'number') {
        var int = num < 0 ? -$floor(-num) : $floor(num); // trunc(num)
        if (int !== num) {
            var intStr = String(int);
            var dec = $slice.call(str, intStr.length + 1);
            return $replace.call(intStr, sepRegex, '$&_') + '.' + $replace.call($replace.call(dec, /([0-9]{3})/g, '$&_'), /_$/, '');
        }
    }
    return $replace.call(str, sepRegex, '$&_');
}

var utilInspect = __webpack_require__(/*! ./util.inspect */ "?4860");
var inspectCustom = utilInspect.custom;
var inspectSymbol = isSymbol(inspectCustom) ? inspectCustom : null;

var quotes = {
    __proto__: null,
    'double': '"',
    single: "'"
};
var quoteREs = {
    __proto__: null,
    'double': /(["\\])/g,
    single: /(['\\])/g
};

module.exports = function inspect_(obj, options, depth, seen) {
    var opts = options || {};

    if (has(opts, 'quoteStyle') && !has(quotes, opts.quoteStyle)) {
        throw new TypeError('option "quoteStyle" must be "single" or "double"');
    }
    if (
        has(opts, 'maxStringLength') && (typeof opts.maxStringLength === 'number'
            ? opts.maxStringLength < 0 && opts.maxStringLength !== Infinity
            : opts.maxStringLength !== null
        )
    ) {
        throw new TypeError('option "maxStringLength", if provided, must be a positive integer, Infinity, or `null`');
    }
    var customInspect = has(opts, 'customInspect') ? opts.customInspect : true;
    if (typeof customInspect !== 'boolean' && customInspect !== 'symbol') {
        throw new TypeError('option "customInspect", if provided, must be `true`, `false`, or `\'symbol\'`');
    }

    if (
        has(opts, 'indent')
        && opts.indent !== null
        && opts.indent !== '\t'
        && !(parseInt(opts.indent, 10) === opts.indent && opts.indent > 0)
    ) {
        throw new TypeError('option "indent" must be "\\t", an integer > 0, or `null`');
    }
    if (has(opts, 'numericSeparator') && typeof opts.numericSeparator !== 'boolean') {
        throw new TypeError('option "numericSeparator", if provided, must be `true` or `false`');
    }
    var numericSeparator = opts.numericSeparator;

    if (typeof obj === 'undefined') {
        return 'undefined';
    }
    if (obj === null) {
        return 'null';
    }
    if (typeof obj === 'boolean') {
        return obj ? 'true' : 'false';
    }

    if (typeof obj === 'string') {
        return inspectString(obj, opts);
    }
    if (typeof obj === 'number') {
        if (obj === 0) {
            return Infinity / obj > 0 ? '0' : '-0';
        }
        var str = String(obj);
        return numericSeparator ? addNumericSeparator(obj, str) : str;
    }
    if (typeof obj === 'bigint') {
        var bigIntStr = String(obj) + 'n';
        return numericSeparator ? addNumericSeparator(obj, bigIntStr) : bigIntStr;
    }

    var maxDepth = typeof opts.depth === 'undefined' ? 5 : opts.depth;
    if (typeof depth === 'undefined') { depth = 0; }
    if (depth >= maxDepth && maxDepth > 0 && typeof obj === 'object') {
        return isArray(obj) ? '[Array]' : '[Object]';
    }

    var indent = getIndent(opts, depth);

    if (typeof seen === 'undefined') {
        seen = [];
    } else if (indexOf(seen, obj) >= 0) {
        return '[Circular]';
    }

    function inspect(value, from, noIndent) {
        if (from) {
            seen = $arrSlice.call(seen);
            seen.push(from);
        }
        if (noIndent) {
            var newOpts = {
                depth: opts.depth
            };
            if (has(opts, 'quoteStyle')) {
                newOpts.quoteStyle = opts.quoteStyle;
            }
            return inspect_(value, newOpts, depth + 1, seen);
        }
        return inspect_(value, opts, depth + 1, seen);
    }

    if (typeof obj === 'function' && !isRegExp(obj)) { // in older engines, regexes are callable
        var name = nameOf(obj);
        var keys = arrObjKeys(obj, inspect);
        return '[Function' + (name ? ': ' + name : ' (anonymous)') + ']' + (keys.length > 0 ? ' { ' + $join.call(keys, ', ') + ' }' : '');
    }
    if (isSymbol(obj)) {
        var symString = hasShammedSymbols ? $replace.call(String(obj), /^(Symbol\(.*\))_[^)]*$/, '$1') : symToString.call(obj);
        return typeof obj === 'object' && !hasShammedSymbols ? markBoxed(symString) : symString;
    }
    if (isElement(obj)) {
        var s = '<' + $toLowerCase.call(String(obj.nodeName));
        var attrs = obj.attributes || [];
        for (var i = 0; i < attrs.length; i++) {
            s += ' ' + attrs[i].name + '=' + wrapQuotes(quote(attrs[i].value), 'double', opts);
        }
        s += '>';
        if (obj.childNodes && obj.childNodes.length) { s += '...'; }
        s += '</' + $toLowerCase.call(String(obj.nodeName)) + '>';
        return s;
    }
    if (isArray(obj)) {
        if (obj.length === 0) { return '[]'; }
        var xs = arrObjKeys(obj, inspect);
        if (indent && !singleLineValues(xs)) {
            return '[' + indentedJoin(xs, indent) + ']';
        }
        return '[ ' + $join.call(xs, ', ') + ' ]';
    }
    if (isError(obj)) {
        var parts = arrObjKeys(obj, inspect);
        if (!('cause' in Error.prototype) && 'cause' in obj && !isEnumerable.call(obj, 'cause')) {
            return '{ [' + String(obj) + '] ' + $join.call($concat.call('[cause]: ' + inspect(obj.cause), parts), ', ') + ' }';
        }
        if (parts.length === 0) { return '[' + String(obj) + ']'; }
        return '{ [' + String(obj) + '] ' + $join.call(parts, ', ') + ' }';
    }
    if (typeof obj === 'object' && customInspect) {
        if (inspectSymbol && typeof obj[inspectSymbol] === 'function' && utilInspect) {
            return utilInspect(obj, { depth: maxDepth - depth });
        } else if (customInspect !== 'symbol' && typeof obj.inspect === 'function') {
            return obj.inspect();
        }
    }
    if (isMap(obj)) {
        var mapParts = [];
        if (mapForEach) {
            mapForEach.call(obj, function (value, key) {
                mapParts.push(inspect(key, obj, true) + ' => ' + inspect(value, obj));
            });
        }
        return collectionOf('Map', mapSize.call(obj), mapParts, indent);
    }
    if (isSet(obj)) {
        var setParts = [];
        if (setForEach) {
            setForEach.call(obj, function (value) {
                setParts.push(inspect(value, obj));
            });
        }
        return collectionOf('Set', setSize.call(obj), setParts, indent);
    }
    if (isWeakMap(obj)) {
        return weakCollectionOf('WeakMap');
    }
    if (isWeakSet(obj)) {
        return weakCollectionOf('WeakSet');
    }
    if (isWeakRef(obj)) {
        return weakCollectionOf('WeakRef');
    }
    if (isNumber(obj)) {
        return markBoxed(inspect(Number(obj)));
    }
    if (isBigInt(obj)) {
        return markBoxed(inspect(bigIntValueOf.call(obj)));
    }
    if (isBoolean(obj)) {
        return markBoxed(booleanValueOf.call(obj));
    }
    if (isString(obj)) {
        return markBoxed(inspect(String(obj)));
    }
    // note: in IE 8, sometimes `global !== window` but both are the prototypes of each other
    /* eslint-env browser */
    if (typeof window !== 'undefined' && obj === window) {
        return '{ [object Window] }';
    }
    if (
        (typeof globalThis !== 'undefined' && obj === globalThis)
        || (typeof __webpack_require__.g !== 'undefined' && obj === __webpack_require__.g)
    ) {
        return '{ [object globalThis] }';
    }
    if (!isDate(obj) && !isRegExp(obj)) {
        var ys = arrObjKeys(obj, inspect);
        var isPlainObject = gPO ? gPO(obj) === Object.prototype : obj instanceof Object || obj.constructor === Object;
        var protoTag = obj instanceof Object ? '' : 'null prototype';
        var stringTag = !isPlainObject && toStringTag && Object(obj) === obj && toStringTag in obj ? $slice.call(toStr(obj), 8, -1) : protoTag ? 'Object' : '';
        var constructorTag = isPlainObject || typeof obj.constructor !== 'function' ? '' : obj.constructor.name ? obj.constructor.name + ' ' : '';
        var tag = constructorTag + (stringTag || protoTag ? '[' + $join.call($concat.call([], stringTag || [], protoTag || []), ': ') + '] ' : '');
        if (ys.length === 0) { return tag + '{}'; }
        if (indent) {
            return tag + '{' + indentedJoin(ys, indent) + '}';
        }
        return tag + '{ ' + $join.call(ys, ', ') + ' }';
    }
    return String(obj);
};

function wrapQuotes(s, defaultStyle, opts) {
    var style = opts.quoteStyle || defaultStyle;
    var quoteChar = quotes[style];
    return quoteChar + s + quoteChar;
}

function quote(s) {
    return $replace.call(String(s), /"/g, '&quot;');
}

function canTrustToString(obj) {
    return !toStringTag || !(typeof obj === 'object' && (toStringTag in obj || typeof obj[toStringTag] !== 'undefined'));
}
function isArray(obj) { return toStr(obj) === '[object Array]' && canTrustToString(obj); }
function isDate(obj) { return toStr(obj) === '[object Date]' && canTrustToString(obj); }
function isRegExp(obj) { return toStr(obj) === '[object RegExp]' && canTrustToString(obj); }
function isError(obj) { return toStr(obj) === '[object Error]' && canTrustToString(obj); }
function isString(obj) { return toStr(obj) === '[object String]' && canTrustToString(obj); }
function isNumber(obj) { return toStr(obj) === '[object Number]' && canTrustToString(obj); }
function isBoolean(obj) { return toStr(obj) === '[object Boolean]' && canTrustToString(obj); }

// Symbol and BigInt do have Symbol.toStringTag by spec, so that can't be used to eliminate false positives
function isSymbol(obj) {
    if (hasShammedSymbols) {
        return obj && typeof obj === 'object' && obj instanceof Symbol;
    }
    if (typeof obj === 'symbol') {
        return true;
    }
    if (!obj || typeof obj !== 'object' || !symToString) {
        return false;
    }
    try {
        symToString.call(obj);
        return true;
    } catch (e) {}
    return false;
}

function isBigInt(obj) {
    if (!obj || typeof obj !== 'object' || !bigIntValueOf) {
        return false;
    }
    try {
        bigIntValueOf.call(obj);
        return true;
    } catch (e) {}
    return false;
}

var hasOwn = Object.prototype.hasOwnProperty || function (key) { return key in this; };
function has(obj, key) {
    return hasOwn.call(obj, key);
}

function toStr(obj) {
    return objectToString.call(obj);
}

function nameOf(f) {
    if (f.name) { return f.name; }
    var m = $match.call(functionToString.call(f), /^function\s*([\w$]+)/);
    if (m) { return m[1]; }
    return null;
}

function indexOf(xs, x) {
    if (xs.indexOf) { return xs.indexOf(x); }
    for (var i = 0, l = xs.length; i < l; i++) {
        if (xs[i] === x) { return i; }
    }
    return -1;
}

function isMap(x) {
    if (!mapSize || !x || typeof x !== 'object') {
        return false;
    }
    try {
        mapSize.call(x);
        try {
            setSize.call(x);
        } catch (s) {
            return true;
        }
        return x instanceof Map; // core-js workaround, pre-v2.5.0
    } catch (e) {}
    return false;
}

function isWeakMap(x) {
    if (!weakMapHas || !x || typeof x !== 'object') {
        return false;
    }
    try {
        weakMapHas.call(x, weakMapHas);
        try {
            weakSetHas.call(x, weakSetHas);
        } catch (s) {
            return true;
        }
        return x instanceof WeakMap; // core-js workaround, pre-v2.5.0
    } catch (e) {}
    return false;
}

function isWeakRef(x) {
    if (!weakRefDeref || !x || typeof x !== 'object') {
        return false;
    }
    try {
        weakRefDeref.call(x);
        return true;
    } catch (e) {}
    return false;
}

function isSet(x) {
    if (!setSize || !x || typeof x !== 'object') {
        return false;
    }
    try {
        setSize.call(x);
        try {
            mapSize.call(x);
        } catch (m) {
            return true;
        }
        return x instanceof Set; // core-js workaround, pre-v2.5.0
    } catch (e) {}
    return false;
}

function isWeakSet(x) {
    if (!weakSetHas || !x || typeof x !== 'object') {
        return false;
    }
    try {
        weakSetHas.call(x, weakSetHas);
        try {
            weakMapHas.call(x, weakMapHas);
        } catch (s) {
            return true;
        }
        return x instanceof WeakSet; // core-js workaround, pre-v2.5.0
    } catch (e) {}
    return false;
}

function isElement(x) {
    if (!x || typeof x !== 'object') { return false; }
    if (typeof HTMLElement !== 'undefined' && x instanceof HTMLElement) {
        return true;
    }
    return typeof x.nodeName === 'string' && typeof x.getAttribute === 'function';
}

function inspectString(str, opts) {
    if (str.length > opts.maxStringLength) {
        var remaining = str.length - opts.maxStringLength;
        var trailer = '... ' + remaining + ' more character' + (remaining > 1 ? 's' : '');
        return inspectString($slice.call(str, 0, opts.maxStringLength), opts) + trailer;
    }
    var quoteRE = quoteREs[opts.quoteStyle || 'single'];
    quoteRE.lastIndex = 0;
    // eslint-disable-next-line no-control-regex
    var s = $replace.call($replace.call(str, quoteRE, '\\$1'), /[\x00-\x1f]/g, lowbyte);
    return wrapQuotes(s, 'single', opts);
}

function lowbyte(c) {
    var n = c.charCodeAt(0);
    var x = {
        8: 'b',
        9: 't',
        10: 'n',
        12: 'f',
        13: 'r'
    }[n];
    if (x) { return '\\' + x; }
    return '\\x' + (n < 0x10 ? '0' : '') + $toUpperCase.call(n.toString(16));
}

function markBoxed(str) {
    return 'Object(' + str + ')';
}

function weakCollectionOf(type) {
    return type + ' { ? }';
}

function collectionOf(type, size, entries, indent) {
    var joinedEntries = indent ? indentedJoin(entries, indent) : $join.call(entries, ', ');
    return type + ' (' + size + ') {' + joinedEntries + '}';
}

function singleLineValues(xs) {
    for (var i = 0; i < xs.length; i++) {
        if (indexOf(xs[i], '\n') >= 0) {
            return false;
        }
    }
    return true;
}

function getIndent(opts, depth) {
    var baseIndent;
    if (opts.indent === '\t') {
        baseIndent = '\t';
    } else if (typeof opts.indent === 'number' && opts.indent > 0) {
        baseIndent = $join.call(Array(opts.indent + 1), ' ');
    } else {
        return null;
    }
    return {
        base: baseIndent,
        prev: $join.call(Array(depth + 1), baseIndent)
    };
}

function indentedJoin(xs, indent) {
    if (xs.length === 0) { return ''; }
    var lineJoiner = '\n' + indent.prev + indent.base;
    return lineJoiner + $join.call(xs, ',' + lineJoiner) + '\n' + indent.prev;
}

function arrObjKeys(obj, inspect) {
    var isArr = isArray(obj);
    var xs = [];
    if (isArr) {
        xs.length = obj.length;
        for (var i = 0; i < obj.length; i++) {
            xs[i] = has(obj, i) ? inspect(obj[i], obj) : '';
        }
    }
    var syms = typeof gOPS === 'function' ? gOPS(obj) : [];
    var symMap;
    if (hasShammedSymbols) {
        symMap = {};
        for (var k = 0; k < syms.length; k++) {
            symMap['$' + syms[k]] = syms[k];
        }
    }

    for (var key in obj) { // eslint-disable-line no-restricted-syntax
        if (!has(obj, key)) { continue; } // eslint-disable-line no-restricted-syntax, no-continue
        if (isArr && String(Number(key)) === key && key < obj.length) { continue; } // eslint-disable-line no-restricted-syntax, no-continue
        if (hasShammedSymbols && symMap['$' + key] instanceof Symbol) {
            // this is to prevent shammed Symbols, which are stored as strings, from being included in the string key section
            continue; // eslint-disable-line no-restricted-syntax, no-continue
        } else if ($test.call(/[^\w$]/, key)) {
            xs.push(inspect(key, obj) + ': ' + inspect(obj[key], obj));
        } else {
            xs.push(key + ': ' + inspect(obj[key], obj));
        }
    }
    if (typeof gOPS === 'function') {
        for (var j = 0; j < syms.length; j++) {
            if (isEnumerable.call(obj, syms[j])) {
                xs.push('[' + inspect(syms[j]) + ']: ' + inspect(obj[syms[j]], obj));
            }
        }
    }
    return xs;
}


/***/ },

/***/ "../../../node_modules/panorama-polyfill-x/lib/console.js"
/*!****************************************************************!*\
  !*** ../../../node_modules/panorama-polyfill-x/lib/console.js ***!
  \****************************************************************/
(__unused_webpack_module, __unused_webpack___webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var _utils_console__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./utils/console */ "../../../node_modules/panorama-polyfill-x/lib/utils/console.js");

globalThis.console = _utils_console__WEBPACK_IMPORTED_MODULE_0__.console;


/***/ },

/***/ "../../../node_modules/panorama-polyfill-x/lib/utils/console.js"
/*!**********************************************************************!*\
  !*** ../../../node_modules/panorama-polyfill-x/lib/utils/console.js ***!
  \**********************************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   console: () => (/* binding */ console)
/* harmony export */ });
/* harmony import */ var _format__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./format */ "../../../node_modules/panorama-polyfill-x/lib/utils/format.js");

function write(text) {
    for (const line of text.split('\n')) {
        if (line.length > 2047) {
            const postfix = '... (line have been trimmed because of a length limit)';
            $.Warning(`${line.slice(0, 2047 - postfix.length)}${postfix}`);
        }
        else {
            $.Msg(line);
        }
    }
}
function assert(value, message = 'console.assert', ...args) {
    if (!value) {
        error(new Error(`Assertion failed: ${message}`), ...args);
    }
}
function error(...args) {
    $.Warning((0,_format__WEBPACK_IMPORTED_MODULE_0__.format)(...args));
}
const warn = error;
function log(...args) {
    write((0,_format__WEBPACK_IMPORTED_MODULE_0__.format)(...args));
}
const debug = log;
const info = log;
const times = new Map();
function time(label = 'default') {
    label = `${label}`;
    if (times.has(label)) {
        warn(`Timer '${label}' already exists`);
        return;
    }
    times.set(label, Date.now());
}
function timeEnd(label = 'default') {
    label = `${label}`;
    const startTime = times.get(label);
    if (startTime == null) {
        warn(`Timer '${label} does not exist'`);
        return;
    }
    times.delete(label);
    write(`${label}: ${Date.now() - startTime}ms`);
}
function trace(message = '', ...args) {
    const errorObject = {
        message: (0,_format__WEBPACK_IMPORTED_MODULE_0__.format)(message, ...args),
        name: 'Trace',
        stack: '',
    };
    Error.captureStackTrace(errorObject, trace);
    write((0,_format__WEBPACK_IMPORTED_MODULE_0__.format)(errorObject.stack));
}
function clear() { }
function dir() {
    throw new Error('console.dir is not implemented');
}
function dirxml() {
    throw new Error('console.dirxml is not implemented');
}
function table() {
    throw new Error('console.table is not implemented');
}
function count() {
    throw new Error('console.count is not implemented');
}
function countReset() {
    throw new Error('console.countReset is not implemented');
}
function group() {
    throw new Error('console.group is not implemented');
}
function groupCollapsed() {
    throw new Error('console.groupCollapsed is not implemented');
}
function groupEnd() {
    throw new Error('console.groupEnd is not implemented');
}
function profile() {
    throw new Error('console.profile is not implemented');
}
function profileEnd() {
    throw new Error('console.profileEnd is not implemented');
}
function timeStamp() {
    throw new Error('console.timeStamp is not implemented');
}
const console = {
    assert,
    warn,
    error,
    log,
    debug,
    info,
    time,
    timeEnd,
    trace,
    clear,
    dir,
    dirxml,
    table,
    count,
    countReset,
    group,
    groupCollapsed,
    groupEnd,
    profile,
    profileEnd,
    timeStamp,
};


/***/ },

/***/ "../../../node_modules/panorama-polyfill-x/lib/utils/format.js"
/*!*********************************************************************!*\
  !*** ../../../node_modules/panorama-polyfill-x/lib/utils/format.js ***!
  \*********************************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   format: () => (/* binding */ format)
/* harmony export */ });
/* harmony import */ var object_inspect__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! object-inspect */ "../../../node_modules/object-inspect/index.js");
/* harmony import */ var object_inspect__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(object_inspect__WEBPACK_IMPORTED_MODULE_0__);

// Based on https://github.com/browserify/node-util/blob/4b1c0c79790d9968eabecd2e9c786454713e200f/util.js#L33
function format(value, ...substitutions) {
    if (typeof value !== 'string') {
        return [value, ...substitutions].map(inspect).join(' ');
    }
    let result = String(value).replace(/%[sdj%]/g, (x) => {
        if (x === '%%')
            return '%';
        if (substitutions.length === 0)
            return x;
        switch (x) {
            case '%s':
                return String(substitutions.unshift());
            case '%d':
                return String(Number(substitutions.unshift()));
            case '%j':
                try {
                    return JSON.stringify(substitutions.unshift());
                }
                catch (_a) {
                    return '[Circular]';
                }
            default:
                return x;
        }
    });
    for (const x of substitutions) {
        if (typeof x !== 'object' || x === null) {
            result += ` ${x}`;
        }
        else {
            result += ` ${inspect(x)}`;
        }
    }
    return result;
}
const inspect = (value) => object_inspect__WEBPACK_IMPORTED_MODULE_0___default()(transformValueForFormat(value));
function transformValueForFormat(originalValue) {
    const visitedValues = new Map();
    return transform(originalValue);
    function transform(value) {
        if (visitedValues.has(value))
            return visitedValues.get(value);
        const result = rawTransform(value);
        visitedValues.set(value, result);
        return result;
    }
    function rawTransform(value) {
        if (typeof value !== 'object' || value == null)
            return value;
        if (value instanceof Date || value instanceof RegExp)
            return value;
        if (Array.isArray(value))
            return value.map(transform);
        if (value instanceof Set)
            return new Set([...value].map(transform));
        if (value instanceof Map) {
            return new Map([...value].map(([k, v]) => [transform(k), transform(v)]));
        }
        if (isPanelBase(value)) {
            return Object.assign(Object.assign({}, value), { style: { inspect: () => '[VCSSStyleDeclaration]' } });
        }
        const newObject = {};
        for (const [k, v] of Object.entries(value)) {
            newObject[k] = transform(v);
        }
        Object.setPrototypeOf(newObject, Object.getPrototypeOf(value));
        return newObject;
    }
}
const isPanelBase = (value) => 'paneltype' in value &&
    'rememberchildfocus' in value &&
    'SetPanelEvent' in value &&
    'RunScriptInPanelContext' in value;


/***/ },

/***/ "./commonLib/modules/evt/local_event_utils.ts"
/*!****************************************************!*\
  !*** ./commonLib/modules/evt/local_event_utils.ts ***!
  \****************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   emitLocalEvent: () => (/* binding */ emitLocalEvent)
/* harmony export */ });
/* unused harmony exports onLocalEvent, onceLocalEvent, offLocalEvent, onLocalEventWithPrecondition, onLocalEventAndDoFirst, clearAllLocalEventListeners, checkAndClearOnReload */
// 初始化监听器注册表（挂载到全局）
if (!Game.LocalEventListeners) {
    Game.LocalEventListeners = [];
}
function emitLocalEvent(eventName, eventData, ...args) {
    var _a;
    (_a = Game.EventBus) === null || _a === void 0 ? void 0 : _a.emit(eventName, eventData, ...args);
}
function onLocalEvent(eventName, listener) {
    if (Game.EventBus.listenerCount(eventName) == Game.EventBus.getMaxListeners()) {
        throw new Error("too many local event listeners, eventName = " + eventName);
    }
    const excloudList = ["x_net_table", "popup_window"];
    if (!excloudList.includes(eventName)) {
        // 记录监听器到注册表（挂载到全局）
        Game.LocalEventListeners.push({ eventName, listener });
    }
    Game.EventBus.on(eventName, listener);
}
function onceLocalEvent(eventName, listener) {
    Game.EventBus.once(eventName, listener);
    // once 事件也会记录，但会在触发后自动移除，所以这里也记录一下
    Game.LocalEventListeners.push({ eventName, listener });
}
function offLocalEvent(eventName, listener) {
    Game.EventBus.off(eventName, listener);
    // 从注册表中移除
    const index = Game.LocalEventListeners.findIndex(record => record.eventName === eventName && record.listener === listener);
    if (index !== -1) {
        Game.LocalEventListeners.splice(index, 1);
    }
}
function onLocalEventWithPrecondition(precondition, eventName, listener, keepListening = false) {
    if (precondition) {
        listener();
    }
    if (!precondition || keepListening) {
        onLocalEvent(eventName, listener);
    }
}
function onLocalEventAndDoFirst(eventName, listener) {
    listener();
    onLocalEvent(eventName, listener);
}
/**
 * 清理所有已注册的旧事件监听器（用于热重载时）
 */
function clearAllLocalEventListeners() {
    let clearedCount = 0;
    for (const record of Game.LocalEventListeners) {
        // $.Msg(`Record: ${record.eventName}`);
        Game.EventBus.off(record.eventName, record.listener);
        clearedCount++;
    }
    Game.LocalEventListeners = [];
    $.Msg(`[LocalEvent] 已清理 ${clearedCount} 个旧事件监听器`);
}
/**
 * 检查是否是热重载，如果是则清理旧监听器
 */
function checkAndClearOnReload() {
    if (Game.reloadCount && Game.reloadCount > 1) {
        $.Msg(`[LocalEvent] 检测到热重载 (重载次数: ${Game.reloadCount})，清理旧事件监听器`);
        clearAllLocalEventListeners();
    }
}


/***/ },

/***/ "?4860"
/*!********************************!*\
  !*** ./util.inspect (ignored) ***!
  \********************************/
() {

/* (ignored) */

/***/ }

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	const __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		const cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		const module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		if (!(moduleId in __webpack_modules__)) {
/******/ 			delete __webpack_module_cache__[moduleId];
/******/ 			const e = new Error("Cannot find module '" + moduleId + "'");
/******/ 			e.code = 'MODULE_NOT_FOUND';
/******/ 			throw e;
/******/ 		}
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat get default export */
/******/ 	(() => {
/******/ 		// getDefaultExport function for compatibility with non-harmony modules
/******/ 		__webpack_require__.n = (module) => {
/******/ 			const getter = module && module.__esModule ?
/******/ 				() => (module['default']) :
/******/ 				() => (module);
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter/value functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			if(Array.isArray(definition)) {
/******/ 				var i = 0;
/******/ 				while(i < definition.length) {
/******/ 					var key = definition[i++];
/******/ 					var binding = definition[i++];
/******/ 					if(!__webpack_require__.o(exports, key)) {
/******/ 						if(binding === 0) {
/******/ 							Object.defineProperty(exports, key, { enumerable: true, value: definition[i++] });
/******/ 						} else {
/******/ 							Object.defineProperty(exports, key, { enumerable: true, get: binding });
/******/ 						}
/******/ 					} else if(binding === 0) { i++; }
/******/ 				}
/******/ 			} else {
/******/ 				for(var key in definition) {
/******/ 					if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 						Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 					}
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/global */
/******/ 	(() => {
/******/ 		__webpack_require__.g = (function() {
/******/ 			if (typeof globalThis === 'object') return globalThis;
/******/ 			try {
/******/ 				return this || new Function('return this')();
/******/ 			} catch (e) {
/******/ 				if (typeof window === 'object') return window;
/******/ 			}
/******/ 		})();
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/************************************************************************/
let __webpack_exports__ = {};
// This entry needs to be wrapped in an IIFE because it needs to be in strict mode.
(() => {
"use strict";
/*!****************************************!*\
  !*** ./utils/x-nettable-dispatcher.ts ***!
  \****************************************/
/* unused harmony export dispatch */
/* harmony import */ var panorama_polyfill_x_lib_console__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! panorama-polyfill-x/lib/console */ "../../../node_modules/panorama-polyfill-x/lib/console.js");
/* harmony import */ var _commonLib_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../commonLib/modules/evt/local_event_utils */ "./commonLib/modules/evt/local_event_utils.ts");


(() => {
    GameUI.CustomUIConfig().__x_nettable_cache__ = {};
    GameEvents.Subscribe(`x_net_table`, received_object => {
        const content = received_object.data;
        if (typeof content != "object" || content == null) {
            console.warn(`[XNetTable] Invalid data format received:`, content);
            return;
        }
        try {
            const tableObject = content;
            // 验证必要字段
            if (!tableObject.table_name || !tableObject.key || tableObject.content == null) {
                console.warn(`[XNetTable] Missing required fields in data:`, tableObject);
                return;
            }
            // content 是 JSON 字符串，需要解析
            // const parsedContent = typeof tableObject.content == "string" ? JSON.parse(tableObject.content) : tableObject.content;
            const parsedContent = tableObject.content;
            // 分发数据
            dispatch(tableObject.table_name, tableObject.key, parsedContent);
        }
        catch (error) {
            console.error(`[XNetTable] Failed to process data: error: ${error} \n`);
        }
    });
})();
function dispatch(table_name, key, content) {
    var _a, _b;
    var _c, _d;
    try {
        (_a = (_c = GameUI.CustomUIConfig()).__x_nettable_cache__) !== null && _a !== void 0 ? _a : (_c.__x_nettable_cache__ = {});
        (_b = (_d = GameUI.CustomUIConfig().__x_nettable_cache__)[table_name]) !== null && _b !== void 0 ? _b : (_d[table_name] = {});
        GameUI.CustomUIConfig().__x_nettable_cache__[table_name][key] = content;
        const table_data = {
            table_name,
            key,
            content,
        };
        (0,_commonLib_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_1__.emitLocalEvent)(`x_net_table`, table_data);
    }
    catch (error) {
        console.log(`x_net_table dispatch error: ${table_name} -> ${key} -> ${content}`);
        if (Game.IsInToolsMode()) {
            throw error;
        }
    }
}

})();

/******/ })()
;