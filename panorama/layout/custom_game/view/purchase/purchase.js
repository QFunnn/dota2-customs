--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


/******/ (() => { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "../../../node_modules/dayjs/dayjs.min.js"
/*!************************************************!*\
  !*** ../../../node_modules/dayjs/dayjs.min.js ***!
  \************************************************/
(module) {

!function(t,e){ true?module.exports=e():0}(this,(function(){"use strict";var t=1e3,e=6e4,n=36e5,r="millisecond",i="second",s="minute",u="hour",a="day",o="week",c="month",f="quarter",h="year",d="date",l="Invalid Date",$=/^(\d{4})[-/]?(\d{1,2})?[-/]?(\d{0,2})[Tt\s]*(\d{1,2})?:?(\d{1,2})?:?(\d{1,2})?[.:]?(\d+)?$/,y=/\[([^\]]+)]|Y{1,4}|M{1,4}|D{1,2}|d{1,4}|H{1,2}|h{1,2}|a|A|m{1,2}|s{1,2}|Z{1,2}|SSS/g,M={name:"en",weekdays:"Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),months:"January_February_March_April_May_June_July_August_September_October_November_December".split("_"),ordinal:function(t){var e=["th","st","nd","rd"],n=t%100;return"["+t+(e[(n-20)%10]||e[n]||e[0])+"]"}},m=function(t,e,n){var r=String(t);return!r||r.length>=e?t:""+Array(e+1-r.length).join(n)+t},v={s:m,z:function(t){var e=-t.utcOffset(),n=Math.abs(e),r=Math.floor(n/60),i=n%60;return(e<=0?"+":"-")+m(r,2,"0")+":"+m(i,2,"0")},m:function t(e,n){if(e.date()<n.date())return-t(n,e);var r=12*(n.year()-e.year())+(n.month()-e.month()),i=e.clone().add(r,c),s=n-i<0,u=e.clone().add(r+(s?-1:1),c);return+(-(r+(n-i)/(s?i-u:u-i))||0)},a:function(t){return t<0?Math.ceil(t)||0:Math.floor(t)},p:function(t){return{M:c,y:h,w:o,d:a,D:d,h:u,m:s,s:i,ms:r,Q:f}[t]||String(t||"").toLowerCase().replace(/s$/,"")},u:function(t){return void 0===t}},g="en",D={};D[g]=M;var p="$isDayjsObject",S=function(t){return t instanceof _||!(!t||!t[p])},w=function t(e,n,r){var i;if(!e)return g;if("string"==typeof e){var s=e.toLowerCase();D[s]&&(i=s),n&&(D[s]=n,i=s);var u=e.split("-");if(!i&&u.length>1)return t(u[0])}else{var a=e.name;D[a]=e,i=a}return!r&&i&&(g=i),i||!r&&g},O=function(t,e){if(S(t))return t.clone();var n="object"==typeof e?e:{};return n.date=t,n.args=arguments,new _(n)},b=v;b.l=w,b.i=S,b.w=function(t,e){return O(t,{locale:e.$L,utc:e.$u,x:e.$x,$offset:e.$offset})};var _=function(){function M(t){this.$L=w(t.locale,null,!0),this.parse(t),this.$x=this.$x||t.x||{},this[p]=!0}var m=M.prototype;return m.parse=function(t){this.$d=function(t){var e=t.date,n=t.utc;if(null===e)return new Date(NaN);if(b.u(e))return new Date;if(e instanceof Date)return new Date(e);if("string"==typeof e&&!/Z$/i.test(e)){var r=e.match($);if(r){var i=r[2]-1||0,s=(r[7]||"0").substring(0,3);return n?new Date(Date.UTC(r[1],i,r[3]||1,r[4]||0,r[5]||0,r[6]||0,s)):new Date(r[1],i,r[3]||1,r[4]||0,r[5]||0,r[6]||0,s)}}return new Date(e)}(t),this.init()},m.init=function(){var t=this.$d;this.$y=t.getFullYear(),this.$M=t.getMonth(),this.$D=t.getDate(),this.$W=t.getDay(),this.$H=t.getHours(),this.$m=t.getMinutes(),this.$s=t.getSeconds(),this.$ms=t.getMilliseconds()},m.$utils=function(){return b},m.isValid=function(){return!(this.$d.toString()===l)},m.isSame=function(t,e){var n=O(t);return this.startOf(e)<=n&&n<=this.endOf(e)},m.isAfter=function(t,e){return O(t)<this.startOf(e)},m.isBefore=function(t,e){return this.endOf(e)<O(t)},m.$g=function(t,e,n){return b.u(t)?this[e]:this.set(n,t)},m.unix=function(){return Math.floor(this.valueOf()/1e3)},m.valueOf=function(){return this.$d.getTime()},m.startOf=function(t,e){var n=this,r=!!b.u(e)||e,f=b.p(t),l=function(t,e){var i=b.w(n.$u?Date.UTC(n.$y,e,t):new Date(n.$y,e,t),n);return r?i:i.endOf(a)},$=function(t,e){return b.w(n.toDate()[t].apply(n.toDate("s"),(r?[0,0,0,0]:[23,59,59,999]).slice(e)),n)},y=this.$W,M=this.$M,m=this.$D,v="set"+(this.$u?"UTC":"");switch(f){case h:return r?l(1,0):l(31,11);case c:return r?l(1,M):l(0,M+1);case o:var g=this.$locale().weekStart||0,D=(y<g?y+7:y)-g;return l(r?m-D:m+(6-D),M);case a:case d:return $(v+"Hours",0);case u:return $(v+"Minutes",1);case s:return $(v+"Seconds",2);case i:return $(v+"Milliseconds",3);default:return this.clone()}},m.endOf=function(t){return this.startOf(t,!1)},m.$set=function(t,e){var n,o=b.p(t),f="set"+(this.$u?"UTC":""),l=(n={},n[a]=f+"Date",n[d]=f+"Date",n[c]=f+"Month",n[h]=f+"FullYear",n[u]=f+"Hours",n[s]=f+"Minutes",n[i]=f+"Seconds",n[r]=f+"Milliseconds",n)[o],$=o===a?this.$D+(e-this.$W):e;if(o===c||o===h){var y=this.clone().set(d,1);y.$d[l]($),y.init(),this.$d=y.set(d,Math.min(this.$D,y.daysInMonth())).$d}else l&&this.$d[l]($);return this.init(),this},m.set=function(t,e){return this.clone().$set(t,e)},m.get=function(t){return this[b.p(t)]()},m.add=function(r,f){var d,l=this;r=Number(r);var $=b.p(f),y=function(t){var e=O(l);return b.w(e.date(e.date()+Math.round(t*r)),l)};if($===c)return this.set(c,this.$M+r);if($===h)return this.set(h,this.$y+r);if($===a)return y(1);if($===o)return y(7);var M=(d={},d[s]=e,d[u]=n,d[i]=t,d)[$]||1,m=this.$d.getTime()+r*M;return b.w(m,this)},m.subtract=function(t,e){return this.add(-1*t,e)},m.format=function(t){var e=this,n=this.$locale();if(!this.isValid())return n.invalidDate||l;var r=t||"YYYY-MM-DDTHH:mm:ssZ",i=b.z(this),s=this.$H,u=this.$m,a=this.$M,o=n.weekdays,c=n.months,f=n.meridiem,h=function(t,n,i,s){return t&&(t[n]||t(e,r))||i[n].slice(0,s)},d=function(t){return b.s(s%12||12,t,"0")},$=f||function(t,e,n){var r=t<12?"AM":"PM";return n?r.toLowerCase():r};return r.replace(y,(function(t,r){return r||function(t){switch(t){case"YY":return String(e.$y).slice(-2);case"YYYY":return b.s(e.$y,4,"0");case"M":return a+1;case"MM":return b.s(a+1,2,"0");case"MMM":return h(n.monthsShort,a,c,3);case"MMMM":return h(c,a);case"D":return e.$D;case"DD":return b.s(e.$D,2,"0");case"d":return String(e.$W);case"dd":return h(n.weekdaysMin,e.$W,o,2);case"ddd":return h(n.weekdaysShort,e.$W,o,3);case"dddd":return o[e.$W];case"H":return String(s);case"HH":return b.s(s,2,"0");case"h":return d(1);case"hh":return d(2);case"a":return $(s,u,!0);case"A":return $(s,u,!1);case"m":return String(u);case"mm":return b.s(u,2,"0");case"s":return String(e.$s);case"ss":return b.s(e.$s,2,"0");case"SSS":return b.s(e.$ms,3,"0");case"Z":return i}return null}(t)||i.replace(":","")}))},m.utcOffset=function(){return 15*-Math.round(this.$d.getTimezoneOffset()/15)},m.diff=function(r,d,l){var $,y=this,M=b.p(d),m=O(r),v=(m.utcOffset()-this.utcOffset())*e,g=this-m,D=function(){return b.m(y,m)};switch(M){case h:$=D()/12;break;case c:$=D();break;case f:$=D()/3;break;case o:$=(g-v)/6048e5;break;case a:$=(g-v)/864e5;break;case u:$=g/n;break;case s:$=g/e;break;case i:$=g/t;break;default:$=g}return l?$:b.a($)},m.daysInMonth=function(){return this.endOf(c).$D},m.$locale=function(){return D[this.$L]},m.locale=function(t,e){if(!t)return this.$L;var n=this.clone(),r=w(t,e,!0);return r&&(n.$L=r),n},m.clone=function(){return b.w(this.$d,this)},m.toDate=function(){return new Date(this.valueOf())},m.toJSON=function(){return this.isValid()?this.toISOString():null},m.toISOString=function(){return this.$d.toISOString()},m.toString=function(){return this.$d.toUTCString()},M}(),k=_.prototype;return O.prototype=k,[["$ms",r],["$s",i],["$m",s],["$H",u],["$W",a],["$M",c],["$y",h],["$D",d]].forEach((function(t){k[t[1]]=function(e){return this.$g(e,t[0],t[1])}})),O.extend=function(t,e){return t.$i||(t(e,_,O),t.$i=!0),O},O.locale=w,O.isDayjs=S,O.unix=function(t){return O(1e3*t)},O.en=D[g],O.Ls=D,O.p={},O}));

/***/ },

/***/ "../../../node_modules/object-assign/index.js"
/*!****************************************************!*\
  !*** ../../../node_modules/object-assign/index.js ***!
  \****************************************************/
(module) {

"use strict";
/*
object-assign
(c) Sindre Sorhus
@license MIT
*/


/* eslint-disable no-unused-vars */
var getOwnPropertySymbols = Object.getOwnPropertySymbols;
var hasOwnProperty = Object.prototype.hasOwnProperty;
var propIsEnumerable = Object.prototype.propertyIsEnumerable;

function toObject(val) {
	if (val === null || val === undefined) {
		throw new TypeError('Object.assign cannot be called with null or undefined');
	}

	return Object(val);
}

function shouldUseNative() {
	try {
		if (!Object.assign) {
			return false;
		}

		// Detect buggy property enumeration order in older V8 versions.

		// https://bugs.chromium.org/p/v8/issues/detail?id=4118
		var test1 = new String('abc');  // eslint-disable-line no-new-wrappers
		test1[5] = 'de';
		if (Object.getOwnPropertyNames(test1)[0] === '5') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test2 = {};
		for (var i = 0; i < 10; i++) {
			test2['_' + String.fromCharCode(i)] = i;
		}
		var order2 = Object.getOwnPropertyNames(test2).map(function (n) {
			return test2[n];
		});
		if (order2.join('') !== '0123456789') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test3 = {};
		'abcdefghijklmnopqrst'.split('').forEach(function (letter) {
			test3[letter] = letter;
		});
		if (Object.keys(Object.assign({}, test3)).join('') !==
				'abcdefghijklmnopqrst') {
			return false;
		}

		return true;
	} catch (err) {
		// We don't expect any of the above to throw, but better to be safe.
		return false;
	}
}

module.exports = shouldUseNative() ? Object.assign : function (target, source) {
	var from;
	var to = toObject(target);
	var symbols;

	for (var s = 1; s < arguments.length; s++) {
		from = Object(arguments[s]);

		for (var key in from) {
			if (hasOwnProperty.call(from, key)) {
				to[key] = from[key];
			}
		}

		if (getOwnPropertySymbols) {
			symbols = getOwnPropertySymbols(from);
			for (var i = 0; i < symbols.length; i++) {
				if (propIsEnumerable.call(from, symbols[i])) {
					to[symbols[i]] = from[symbols[i]];
				}
			}
		}
	}

	return to;
};


/***/ },

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

/***/ "../../../node_modules/panorama-polyfill-x/lib/timers.js"
/*!***************************************************************!*\
  !*** ../../../node_modules/panorama-polyfill-x/lib/timers.js ***!
  \***************************************************************/
(__unused_webpack_module, __unused_webpack___webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var _utils_timers__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./utils/timers */ "../../../node_modules/panorama-polyfill-x/lib/utils/timers.js");

globalThis.setInterval = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.setInterval;
globalThis.clearInterval = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.clearInterval;
globalThis.setTimeout = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.setTimeout;
globalThis.clearTimeout = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.clearTimeout;
globalThis.setImmediate = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.setImmediate;
globalThis.clearImmediate = _utils_timers__WEBPACK_IMPORTED_MODULE_0__.clearImmediate;


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

/***/ "../../../node_modules/panorama-polyfill-x/lib/utils/timers.js"
/*!*********************************************************************!*\
  !*** ../../../node_modules/panorama-polyfill-x/lib/utils/timers.js ***!
  \*********************************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   clearImmediate: () => (/* binding */ clearTimer),
/* harmony export */   clearInterval: () => (/* binding */ clearTimer),
/* harmony export */   clearTimeout: () => (/* binding */ clearTimer),
/* harmony export */   setImmediate: () => (/* binding */ setImmediate),
/* harmony export */   setInterval: () => (/* binding */ setInterval),
/* harmony export */   setTimeout: () => (/* binding */ setTimeout)
/* harmony export */ });
const intervals = new Map();
let nextIntervalId = -100000;
const setTimeout = (callback, timeout = 0, ...args) => $.Schedule(timeout / 1000, () => callback(...args));
function setInterval(callback, timeout = 0, ...args) {
    timeout /= 1000;
    nextIntervalId -= 1;
    const intervalId = nextIntervalId;
    const run = () => {
        intervals.set(intervalId, $.Schedule(timeout, run));
        callback(...args);
    };
    intervals.set(intervalId, $.Schedule(timeout, run));
    return intervalId;
}
const setImmediate = (callback, ...args) => $.Schedule(0, () => callback(...args));
function clearTimer(handle) {
    if (typeof handle === 'number') {
        // $.CancelScheduled throws on expired or non-existent timer handles
        try {
            if (handle < -100000) {
                $.CancelScheduled(intervals.get(handle));
            }
            else {
                $.CancelScheduled(handle);
            }
        }
        catch (_a) { }
    }
}



/***/ },

/***/ "../../../node_modules/prop-types/checkPropTypes.js"
/*!**********************************************************!*\
  !*** ../../../node_modules/prop-types/checkPropTypes.js ***!
  \**********************************************************/
(module, __unused_webpack_exports, __webpack_require__) {

"use strict";
/**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */



var printWarning = function() {};

if (true) {
  var ReactPropTypesSecret = __webpack_require__(/*! ./lib/ReactPropTypesSecret */ "../../../node_modules/prop-types/lib/ReactPropTypesSecret.js");
  var loggedTypeFailures = {};
  var has = __webpack_require__(/*! ./lib/has */ "../../../node_modules/prop-types/lib/has.js");

  printWarning = function(text) {
    var message = 'Warning: ' + text;
    if (typeof console !== 'undefined') {
      console.error(message);
    }
    try {
      // --- Welcome to debugging React ---
      // This error was thrown as a convenience so that you can use this stack
      // to find the callsite that caused this warning to fire.
      throw new Error(message);
    } catch (x) { /**/ }
  };
}

/**
 * Assert that the values match with the type specs.
 * Error messages are memorized and will only be shown once.
 *
 * @param {object} typeSpecs Map of name to a ReactPropType
 * @param {object} values Runtime values that need to be type-checked
 * @param {string} location e.g. "prop", "context", "child context"
 * @param {string} componentName Name of the component for error messages.
 * @param {?Function} getStack Returns the component stack.
 * @private
 */
function checkPropTypes(typeSpecs, values, location, componentName, getStack) {
  if (true) {
    for (var typeSpecName in typeSpecs) {
      if (has(typeSpecs, typeSpecName)) {
        var error;
        // Prop type validation may throw. In case they do, we don't want to
        // fail the render phase where it didn't fail before. So we log it.
        // After these have been cleaned up, we'll let them throw.
        try {
          // This is intentionally an invariant that gets caught. It's the same
          // behavior as without this statement except with a better message.
          if (typeof typeSpecs[typeSpecName] !== 'function') {
            var err = Error(
              (componentName || 'React class') + ': ' + location + ' type `' + typeSpecName + '` is invalid; ' +
              'it must be a function, usually from the `prop-types` package, but received `' + typeof typeSpecs[typeSpecName] + '`.' +
              'This often happens because of typos such as `PropTypes.function` instead of `PropTypes.func`.'
            );
            err.name = 'Invariant Violation';
            throw err;
          }
          error = typeSpecs[typeSpecName](values, typeSpecName, componentName, location, null, ReactPropTypesSecret);
        } catch (ex) {
          error = ex;
        }
        if (error && !(error instanceof Error)) {
          printWarning(
            (componentName || 'React class') + ': type specification of ' +
            location + ' `' + typeSpecName + '` is invalid; the type checker ' +
            'function must return `null` or an `Error` but returned a ' + typeof error + '. ' +
            'You may have forgotten to pass an argument to the type checker ' +
            'creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and ' +
            'shape all require an argument).'
          );
        }
        if (error instanceof Error && !(error.message in loggedTypeFailures)) {
          // Only monitor this failure once because there tends to be a lot of the
          // same error.
          loggedTypeFailures[error.message] = true;

          var stack = getStack ? getStack() : '';

          printWarning(
            'Failed ' + location + ' type: ' + error.message + (stack != null ? stack : '')
          );
        }
      }
    }
  }
}

/**
 * Resets warning cache when testing.
 *
 * @private
 */
checkPropTypes.resetWarningCache = function() {
  if (true) {
    loggedTypeFailures = {};
  }
}

module.exports = checkPropTypes;


/***/ },

/***/ "../../../node_modules/prop-types/lib/ReactPropTypesSecret.js"
/*!********************************************************************!*\
  !*** ../../../node_modules/prop-types/lib/ReactPropTypesSecret.js ***!
  \********************************************************************/
(module) {

"use strict";
/**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */



var ReactPropTypesSecret = 'SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED';

module.exports = ReactPropTypesSecret;


/***/ },

/***/ "../../../node_modules/prop-types/lib/has.js"
/*!***************************************************!*\
  !*** ../../../node_modules/prop-types/lib/has.js ***!
  \***************************************************/
(module) {

module.exports = Function.call.bind(Object.prototype.hasOwnProperty);


/***/ },

/***/ "../../../node_modules/react-panorama-x/dist/esm/react-panorama.development.js"
/*!*************************************************************************************!*\
  !*** ../../../node_modules/react-panorama-x/dist/esm/react-panorama.development.js ***!
  \*************************************************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   render: () => (/* binding */ render),
/* harmony export */   useGameEvent: () => (/* binding */ useGameEvent)
/* harmony export */ });
/* unused harmony exports createPortal, useNetTableKey, useNetTableValues, useRegisterForUnhandledEvent */
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");
/* harmony import */ var panorama_polyfill_x_lib_console__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! panorama-polyfill-x/lib/console */ "../../../node_modules/panorama-polyfill-x/lib/console.js");
/* harmony import */ var panorama_polyfill_x_lib_timers__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! panorama-polyfill-x/lib/timers */ "../../../node_modules/panorama-polyfill-x/lib/timers.js");
/**
 * React Panorama (https://github.com/XavierCHN/react-panorama)
 * @version 0.4.0
 * @license MIT
 */




/**
 * Executes `callback` every time `eventName` game event is fired.
 */
function useGameEvent(eventName, callback, dependencies) {
    (0,react__WEBPACK_IMPORTED_MODULE_0__.useLayoutEffect)(() => {
        const id = GameEvents.Subscribe(eventName, callback);
        return () => GameEvents.Unsubscribe(id);
    }, dependencies);
}
/**
 * Executes `callback` every time `event` UI event is fired.
 */
function useRegisterForUnhandledEvent(event, callback, dependencies) {
    (0,react__WEBPACK_IMPORTED_MODULE_0__.useLayoutEffect)(() => {
        const id = $.RegisterForUnhandledEvent(event, callback);
        return () => $.UnregisterForUnhandledEvent(event, id);
    }, dependencies);
}
/**
 * Gets the value of a key in a custom NetTable and updates component when it changes.
 */
function useNetTableKey(name, key) {
    const [value, setValue] = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(() => CustomNetTables.GetTableValue(name, key));
    (0,react__WEBPACK_IMPORTED_MODULE_0__.useLayoutEffect)(() => {
        const listener = CustomNetTables.SubscribeNetTableListener(name, (_, eventKey, eventValue) => {
            if (key === eventKey) {
                setValue(eventValue);
            }
        });
        return () => CustomNetTables.UnsubscribeNetTableListener(listener);
    }, [name, key]);
    return value;
}
/**
 * Gets all values in a custom NetTable and updates component when it changes.
 */
function useNetTableValues(name) {
    const [values, setValue] = (0,react__WEBPACK_IMPORTED_MODULE_0__.useState)(() => CustomNetTables.GetAllTableValues(name).reduce((accumulator, pair) => (Object.assign(Object.assign({}, accumulator), { [pair.key]: pair.value })), {}));
    (0,react__WEBPACK_IMPORTED_MODULE_0__.useLayoutEffect)(() => {
        const listener = CustomNetTables.SubscribeNetTableListener(name, (_, eventKey, eventValue) => {
            setValue((current) => (Object.assign(Object.assign({}, current), { [eventKey]: eventValue })));
        });
        return () => CustomNetTables.UnsubscribeNetTableListener(listener);
    }, [name]);
    return values;
}

var _a, _b;
const noop = () => { };
const microtaskPromise = Promise.resolve();
function queueMicrotask(callback) {
    // eslint-disable-next-line @typescript-eslint/no-floating-promises, promise/catch-or-return, promise/prefer-await-to-then, promise/no-callback-in-promise
    microtaskPromise.then(callback);
}
const reactPanoramaSymbol = Symbol('_reactPanoramaSymbol');
// TODO: Put it into a shared library?
const windowRoot = (() => {
    let panel = $.GetContextPanel();
    while (panel) {
        if (panel.BHasClass('WindowRoot'))
            return panel;
        panel = panel.GetParent();
    }
})();
const temporaryPanelHost = (_a = windowRoot.FindChildTraverse('__react_panorama_temporary_host__')) !== null && _a !== void 0 ? _a : $.CreatePanel('Panel', windowRoot, '__react_panorama_temporary_host__');
temporaryPanelHost.RemoveAndDeleteChildren();
temporaryPanelHost.visible = false;
const temporaryScenePanelHost = (_b = windowRoot.FindChildTraverse('__react_panorama_temporary_scene_host__')) !== null && _b !== void 0 ? _b : $.CreatePanel('Panel', windowRoot, '__react_panorama_temporary_scene_host__');
temporaryScenePanelHost.RemoveAndDeleteChildren();
temporaryScenePanelHost.visible = false;
GameUI.CustomUIConfig().temporaryScheduleHandle = -1;
const checkFunc = () => {
    for (let i = 0; i < temporaryScenePanelHost.GetChildCount(); i += 1) {
        const child = temporaryScenePanelHost.GetChild(i);
        if (child !== null) {
            if (child.BHasClass('SceneLoaded')) {
                child.SetParent(temporaryPanelHost);
            }
        }
    }
    temporaryPanelHost.RemoveAndDeleteChildren();
    GameUI.CustomUIConfig().temporaryScheduleHandle = $.Schedule(1, checkFunc);
};
if (GameUI.CustomUIConfig().temporaryScheduleHandle !== -1) {
    try {
        $.CancelScheduled(GameUI.CustomUIConfig().temporaryScheduleHandle);
    }
    catch (_c) { }
    GameUI.CustomUIConfig().temporaryScheduleHandle = -1;
}
checkFunc();

for (const panelName of [
    'Panel',
    'Label',
    'Image',
    'DOTAAbilityImage',
    'DOTAItemImage',
    'DOTAHeroImage',
    'DOTALeagueImage',
    'EconItemImage',
    'AnimatedImageStrip',
    'DOTAEmoticon',
    'Movie',
    'DOTAHeroMovie',
    'DOTAScenePanel',
    'DOTAParticleScenePanel',
    'DOTAEconItem',
    'ProgressBar',
    'CircularProgressBar',
    'ProgressBarWithMiddle',
    'DOTAUserName',
    'DOTAUserRichPresence',
    'DOTAAvatarImage',
    'Countdown',
    'Button',
    'TextButton',
    'ToggleButton',
    'RadioButton',
    'TextEntry',
    'NumberEntry',
    'Slider',
    'SlottedSlider',
    'DropDown',
    'ContextMenuScript',
    'Carousel',
    'CarouselNav',
    'DOTAHUDOverlayMap',
    'DOTAMinimap',
    'HTML',
    'TabButton',
    'TabContents',
    'CustomLayoutPanel',
    'GenericPanel',
]) {
    globalThis[panelName] = panelName;
}

function createCommonjsModule(fn, basedir, module) {
	return module = {
	  path: basedir,
	  exports: {},
	  require: function (path, base) {
      return commonjsRequire(path, (base === undefined || base === null) ? module.path : base);
    }
	}, fn(module, module.exports), module.exports;
}

function commonjsRequire () {
	throw new Error('Dynamic requires are not currently supported by @rollup/plugin-commonjs');
}

/*
object-assign
(c) Sindre Sorhus
@license MIT
*/
/* eslint-disable no-unused-vars */
var getOwnPropertySymbols = Object.getOwnPropertySymbols;
var hasOwnProperty = Object.prototype.hasOwnProperty;
var propIsEnumerable = Object.prototype.propertyIsEnumerable;

function toObject(val) {
	if (val === null || val === undefined) {
		throw new TypeError('Object.assign cannot be called with null or undefined');
	}

	return Object(val);
}

function shouldUseNative() {
	try {
		if (!Object.assign) {
			return false;
		}

		// Detect buggy property enumeration order in older V8 versions.

		// https://bugs.chromium.org/p/v8/issues/detail?id=4118
		var test1 = new String('abc');  // eslint-disable-line no-new-wrappers
		test1[5] = 'de';
		if (Object.getOwnPropertyNames(test1)[0] === '5') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test2 = {};
		for (var i = 0; i < 10; i++) {
			test2['_' + String.fromCharCode(i)] = i;
		}
		var order2 = Object.getOwnPropertyNames(test2).map(function (n) {
			return test2[n];
		});
		if (order2.join('') !== '0123456789') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test3 = {};
		'abcdefghijklmnopqrst'.split('').forEach(function (letter) {
			test3[letter] = letter;
		});
		if (Object.keys(Object.assign({}, test3)).join('') !==
				'abcdefghijklmnopqrst') {
			return false;
		}

		return true;
	} catch (err) {
		// We don't expect any of the above to throw, but better to be safe.
		return false;
	}
}

var D__Git_reactPanorama_node_modules_objectAssign = shouldUseNative() ? Object.assign : function (target, source) {
	var from;
	var to = toObject(target);
	var symbols;

	for (var s = 1; s < arguments.length; s++) {
		from = Object(arguments[s]);

		for (var key in from) {
			if (hasOwnProperty.call(from, key)) {
				to[key] = from[key];
			}
		}

		if (getOwnPropertySymbols) {
			symbols = getOwnPropertySymbols(from);
			for (var i = 0; i < symbols.length; i++) {
				if (propIsEnumerable.call(from, symbols[i])) {
					to[symbols[i]] = from[symbols[i]];
				}
			}
		}
	}

	return to;
};

/**
 * Copyright (c) 2013-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

var ReactPropTypesSecret = 'SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED';

var ReactPropTypesSecret_1 = ReactPropTypesSecret;

var printWarning = function() {};

{
  var ReactPropTypesSecret$1 = ReactPropTypesSecret_1;
  var loggedTypeFailures = {};
  var has = Function.call.bind(Object.prototype.hasOwnProperty);

  printWarning = function(text) {
    var message = 'Warning: ' + text;
    if (typeof console !== 'undefined') {
      console.error(message);
    }
    try {
      // --- Welcome to debugging React ---
      // This error was thrown as a convenience so that you can use this stack
      // to find the callsite that caused this warning to fire.
      throw new Error(message);
    } catch (x) {}
  };
}

/**
 * Assert that the values match with the type specs.
 * Error messages are memorized and will only be shown once.
 *
 * @param {object} typeSpecs Map of name to a ReactPropType
 * @param {object} values Runtime values that need to be type-checked
 * @param {string} location e.g. "prop", "context", "child context"
 * @param {string} componentName Name of the component for error messages.
 * @param {?Function} getStack Returns the component stack.
 * @private
 */
function checkPropTypes(typeSpecs, values, location, componentName, getStack) {
  {
    for (var typeSpecName in typeSpecs) {
      if (has(typeSpecs, typeSpecName)) {
        var error;
        // Prop type validation may throw. In case they do, we don't want to
        // fail the render phase where it didn't fail before. So we log it.
        // After these have been cleaned up, we'll let them throw.
        try {
          // This is intentionally an invariant that gets caught. It's the same
          // behavior as without this statement except with a better message.
          if (typeof typeSpecs[typeSpecName] !== 'function') {
            var err = Error(
              (componentName || 'React class') + ': ' + location + ' type `' + typeSpecName + '` is invalid; ' +
              'it must be a function, usually from the `prop-types` package, but received `' + typeof typeSpecs[typeSpecName] + '`.'
            );
            err.name = 'Invariant Violation';
            throw err;
          }
          error = typeSpecs[typeSpecName](values, typeSpecName, componentName, location, null, ReactPropTypesSecret$1);
        } catch (ex) {
          error = ex;
        }
        if (error && !(error instanceof Error)) {
          printWarning(
            (componentName || 'React class') + ': type specification of ' +
            location + ' `' + typeSpecName + '` is invalid; the type checker ' +
            'function must return `null` or an `Error` but returned a ' + typeof error + '. ' +
            'You may have forgotten to pass an argument to the type checker ' +
            'creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and ' +
            'shape all require an argument).'
          );
        }
        if (error instanceof Error && !(error.message in loggedTypeFailures)) {
          // Only monitor this failure once because there tends to be a lot of the
          // same error.
          loggedTypeFailures[error.message] = true;

          var stack = getStack ? getStack() : '';

          printWarning(
            'Failed ' + location + ' type: ' + error.message + (stack != null ? stack : '')
          );
        }
      }
    }
  }
}

/**
 * Resets warning cache when testing.
 *
 * @private
 */
checkPropTypes.resetWarningCache = function() {
  {
    loggedTypeFailures = {};
  }
};

var checkPropTypes_1 = checkPropTypes;

var scheduler_development = createCommonjsModule(function (module, exports) {



{
  (function() {

var enableSchedulerDebugging = false;
var enableProfiling = true;

var requestHostCallback;
var requestHostTimeout;
var cancelHostTimeout;
var shouldYieldToHost;
var requestPaint;

if ( // If Scheduler runs in a non-DOM environment, it falls back to a naive
// implementation using setTimeout.
typeof window === 'undefined' || // Check if MessageChannel is supported, too.
typeof MessageChannel !== 'function') {
  // If this accidentally gets imported in a non-browser environment, e.g. JavaScriptCore,
  // fallback to a naive implementation.
  var _callback = null;
  var _timeoutID = null;

  var _flushCallback = function () {
    if (_callback !== null) {
      try {
        var currentTime = exports.unstable_now();
        var hasRemainingTime = true;

        _callback(hasRemainingTime, currentTime);

        _callback = null;
      } catch (e) {
        setTimeout(_flushCallback, 0);
        throw e;
      }
    }
  };

  var initialTime = Date.now();

  exports.unstable_now = function () {
    return Date.now() - initialTime;
  };

  requestHostCallback = function (cb) {
    if (_callback !== null) {
      // Protect against re-entrancy.
      setTimeout(requestHostCallback, 0, cb);
    } else {
      _callback = cb;
      setTimeout(_flushCallback, 0);
    }
  };

  requestHostTimeout = function (cb, ms) {
    _timeoutID = setTimeout(cb, ms);
  };

  cancelHostTimeout = function () {
    clearTimeout(_timeoutID);
  };

  shouldYieldToHost = function () {
    return false;
  };

  requestPaint = exports.unstable_forceFrameRate = function () {};
} else {
  // Capture local references to native APIs, in case a polyfill overrides them.
  var performance = window.performance;
  var _Date = window.Date;
  var _setTimeout = window.setTimeout;
  var _clearTimeout = window.clearTimeout;

  if (typeof console !== 'undefined') {
    // TODO: Scheduler no longer requires these methods to be polyfilled. But
    // maybe we want to continue warning if they don't exist, to preserve the
    // option to rely on it in the future?
    var requestAnimationFrame = window.requestAnimationFrame;
    var cancelAnimationFrame = window.cancelAnimationFrame; // TODO: Remove fb.me link

    if (typeof requestAnimationFrame !== 'function') {
      // Using console['error'] to evade Babel and ESLint
      console['error']("This browser doesn't support requestAnimationFrame. " + 'Make sure that you load a ' + 'polyfill in older browsers. https://fb.me/react-polyfills');
    }

    if (typeof cancelAnimationFrame !== 'function') {
      // Using console['error'] to evade Babel and ESLint
      console['error']("This browser doesn't support cancelAnimationFrame. " + 'Make sure that you load a ' + 'polyfill in older browsers. https://fb.me/react-polyfills');
    }
  }

  if (typeof performance === 'object' && typeof performance.now === 'function') {
    exports.unstable_now = function () {
      return performance.now();
    };
  } else {
    var _initialTime = _Date.now();

    exports.unstable_now = function () {
      return _Date.now() - _initialTime;
    };
  }

  var isMessageLoopRunning = false;
  var scheduledHostCallback = null;
  var taskTimeoutID = -1; // Scheduler periodically yields in case there is other work on the main
  // thread, like user events. By default, it yields multiple times per frame.
  // It does not attempt to align with frame boundaries, since most tasks don't
  // need to be frame aligned; for those that do, use requestAnimationFrame.

  var yieldInterval = 5;
  var deadline = 0; // TODO: Make this configurable

  {
    // `isInputPending` is not available. Since we have no way of knowing if
    // there's pending input, always yield at the end of the frame.
    shouldYieldToHost = function () {
      return exports.unstable_now() >= deadline;
    }; // Since we yield every frame regardless, `requestPaint` has no effect.


    requestPaint = function () {};
  }

  exports.unstable_forceFrameRate = function (fps) {
    if (fps < 0 || fps > 125) {
      // Using console['error'] to evade Babel and ESLint
      console['error']('forceFrameRate takes a positive int between 0 and 125, ' + 'forcing framerates higher than 125 fps is not unsupported');
      return;
    }

    if (fps > 0) {
      yieldInterval = Math.floor(1000 / fps);
    } else {
      // reset the framerate
      yieldInterval = 5;
    }
  };

  var performWorkUntilDeadline = function () {
    if (scheduledHostCallback !== null) {
      var currentTime = exports.unstable_now(); // Yield after `yieldInterval` ms, regardless of where we are in the vsync
      // cycle. This means there's always time remaining at the beginning of
      // the message event.

      deadline = currentTime + yieldInterval;
      var hasTimeRemaining = true;

      try {
        var hasMoreWork = scheduledHostCallback(hasTimeRemaining, currentTime);

        if (!hasMoreWork) {
          isMessageLoopRunning = false;
          scheduledHostCallback = null;
        } else {
          // If there's more work, schedule the next message event at the end
          // of the preceding one.
          port.postMessage(null);
        }
      } catch (error) {
        // If a scheduler task throws, exit the current browser task so the
        // error can be observed.
        port.postMessage(null);
        throw error;
      }
    } else {
      isMessageLoopRunning = false;
    } // Yielding to the browser will give it a chance to paint, so we can
  };

  var channel = new MessageChannel();
  var port = channel.port2;
  channel.port1.onmessage = performWorkUntilDeadline;

  requestHostCallback = function (callback) {
    scheduledHostCallback = callback;

    if (!isMessageLoopRunning) {
      isMessageLoopRunning = true;
      port.postMessage(null);
    }
  };

  requestHostTimeout = function (callback, ms) {
    taskTimeoutID = _setTimeout(function () {
      callback(exports.unstable_now());
    }, ms);
  };

  cancelHostTimeout = function () {
    _clearTimeout(taskTimeoutID);

    taskTimeoutID = -1;
  };
}

function push(heap, node) {
  var index = heap.length;
  heap.push(node);
  siftUp(heap, node, index);
}
function peek(heap) {
  var first = heap[0];
  return first === undefined ? null : first;
}
function pop(heap) {
  var first = heap[0];

  if (first !== undefined) {
    var last = heap.pop();

    if (last !== first) {
      heap[0] = last;
      siftDown(heap, last, 0);
    }

    return first;
  } else {
    return null;
  }
}

function siftUp(heap, node, i) {
  var index = i;

  while (true) {
    var parentIndex = index - 1 >>> 1;
    var parent = heap[parentIndex];

    if (parent !== undefined && compare(parent, node) > 0) {
      // The parent is larger. Swap positions.
      heap[parentIndex] = node;
      heap[index] = parent;
      index = parentIndex;
    } else {
      // The parent is smaller. Exit.
      return;
    }
  }
}

function siftDown(heap, node, i) {
  var index = i;
  var length = heap.length;

  while (index < length) {
    var leftIndex = (index + 1) * 2 - 1;
    var left = heap[leftIndex];
    var rightIndex = leftIndex + 1;
    var right = heap[rightIndex]; // If the left or right node is smaller, swap with the smaller of those.

    if (left !== undefined && compare(left, node) < 0) {
      if (right !== undefined && compare(right, left) < 0) {
        heap[index] = right;
        heap[rightIndex] = node;
        index = rightIndex;
      } else {
        heap[index] = left;
        heap[leftIndex] = node;
        index = leftIndex;
      }
    } else if (right !== undefined && compare(right, node) < 0) {
      heap[index] = right;
      heap[rightIndex] = node;
      index = rightIndex;
    } else {
      // Neither child is smaller. Exit.
      return;
    }
  }
}

function compare(a, b) {
  // Compare sort index first, then task id.
  var diff = a.sortIndex - b.sortIndex;
  return diff !== 0 ? diff : a.id - b.id;
}

// TODO: Use symbols?
var NoPriority = 0;
var ImmediatePriority = 1;
var UserBlockingPriority = 2;
var NormalPriority = 3;
var LowPriority = 4;
var IdlePriority = 5;

var runIdCounter = 0;
var mainThreadIdCounter = 0;
var profilingStateSize = 4;
var sharedProfilingBuffer =  // $FlowFixMe Flow doesn't know about SharedArrayBuffer
typeof SharedArrayBuffer === 'function' ? new SharedArrayBuffer(profilingStateSize * Int32Array.BYTES_PER_ELEMENT) : // $FlowFixMe Flow doesn't know about ArrayBuffer
typeof ArrayBuffer === 'function' ? new ArrayBuffer(profilingStateSize * Int32Array.BYTES_PER_ELEMENT) : null // Don't crash the init path on IE9
;
var profilingState =  sharedProfilingBuffer !== null ? new Int32Array(sharedProfilingBuffer) : []; // We can't read this but it helps save bytes for null checks

var PRIORITY = 0;
var CURRENT_TASK_ID = 1;
var CURRENT_RUN_ID = 2;
var QUEUE_SIZE = 3;

{
  profilingState[PRIORITY] = NoPriority; // This is maintained with a counter, because the size of the priority queue
  // array might include canceled tasks.

  profilingState[QUEUE_SIZE] = 0;
  profilingState[CURRENT_TASK_ID] = 0;
} // Bytes per element is 4


var INITIAL_EVENT_LOG_SIZE = 131072;
var MAX_EVENT_LOG_SIZE = 524288; // Equivalent to 2 megabytes

var eventLogSize = 0;
var eventLogBuffer = null;
var eventLog = null;
var eventLogIndex = 0;
var TaskStartEvent = 1;
var TaskCompleteEvent = 2;
var TaskErrorEvent = 3;
var TaskCancelEvent = 4;
var TaskRunEvent = 5;
var TaskYieldEvent = 6;
var SchedulerSuspendEvent = 7;
var SchedulerResumeEvent = 8;

function logEvent(entries) {
  if (eventLog !== null) {
    var offset = eventLogIndex;
    eventLogIndex += entries.length;

    if (eventLogIndex + 1 > eventLogSize) {
      eventLogSize *= 2;

      if (eventLogSize > MAX_EVENT_LOG_SIZE) {
        // Using console['error'] to evade Babel and ESLint
        console['error']("Scheduler Profiling: Event log exceeded maximum size. Don't " + 'forget to call `stopLoggingProfilingEvents()`.');
        stopLoggingProfilingEvents();
        return;
      }

      var newEventLog = new Int32Array(eventLogSize * 4);
      newEventLog.set(eventLog);
      eventLogBuffer = newEventLog.buffer;
      eventLog = newEventLog;
    }

    eventLog.set(entries, offset);
  }
}

function startLoggingProfilingEvents() {
  eventLogSize = INITIAL_EVENT_LOG_SIZE;
  eventLogBuffer = new ArrayBuffer(eventLogSize * 4);
  eventLog = new Int32Array(eventLogBuffer);
  eventLogIndex = 0;
}
function stopLoggingProfilingEvents() {
  var buffer = eventLogBuffer;
  eventLogSize = 0;
  eventLogBuffer = null;
  eventLog = null;
  eventLogIndex = 0;
  return buffer;
}
function markTaskStart(task, ms) {
  {
    profilingState[QUEUE_SIZE]++;

    if (eventLog !== null) {
      // performance.now returns a float, representing milliseconds. When the
      // event is logged, it's coerced to an int. Convert to microseconds to
      // maintain extra degrees of precision.
      logEvent([TaskStartEvent, ms * 1000, task.id, task.priorityLevel]);
    }
  }
}
function markTaskCompleted(task, ms) {
  {
    profilingState[PRIORITY] = NoPriority;
    profilingState[CURRENT_TASK_ID] = 0;
    profilingState[QUEUE_SIZE]--;

    if (eventLog !== null) {
      logEvent([TaskCompleteEvent, ms * 1000, task.id]);
    }
  }
}
function markTaskCanceled(task, ms) {
  {
    profilingState[QUEUE_SIZE]--;

    if (eventLog !== null) {
      logEvent([TaskCancelEvent, ms * 1000, task.id]);
    }
  }
}
function markTaskErrored(task, ms) {
  {
    profilingState[PRIORITY] = NoPriority;
    profilingState[CURRENT_TASK_ID] = 0;
    profilingState[QUEUE_SIZE]--;

    if (eventLog !== null) {
      logEvent([TaskErrorEvent, ms * 1000, task.id]);
    }
  }
}
function markTaskRun(task, ms) {
  {
    runIdCounter++;
    profilingState[PRIORITY] = task.priorityLevel;
    profilingState[CURRENT_TASK_ID] = task.id;
    profilingState[CURRENT_RUN_ID] = runIdCounter;

    if (eventLog !== null) {
      logEvent([TaskRunEvent, ms * 1000, task.id, runIdCounter]);
    }
  }
}
function markTaskYield(task, ms) {
  {
    profilingState[PRIORITY] = NoPriority;
    profilingState[CURRENT_TASK_ID] = 0;
    profilingState[CURRENT_RUN_ID] = 0;

    if (eventLog !== null) {
      logEvent([TaskYieldEvent, ms * 1000, task.id, runIdCounter]);
    }
  }
}
function markSchedulerSuspended(ms) {
  {
    mainThreadIdCounter++;

    if (eventLog !== null) {
      logEvent([SchedulerSuspendEvent, ms * 1000, mainThreadIdCounter]);
    }
  }
}
function markSchedulerUnsuspended(ms) {
  {
    if (eventLog !== null) {
      logEvent([SchedulerResumeEvent, ms * 1000, mainThreadIdCounter]);
    }
  }
}

/* eslint-disable no-var */
// Math.pow(2, 30) - 1
// 0b111111111111111111111111111111

var maxSigned31BitInt = 1073741823; // Times out immediately

var IMMEDIATE_PRIORITY_TIMEOUT = -1; // Eventually times out

var USER_BLOCKING_PRIORITY = 250;
var NORMAL_PRIORITY_TIMEOUT = 5000;
var LOW_PRIORITY_TIMEOUT = 10000; // Never times out

var IDLE_PRIORITY = maxSigned31BitInt; // Tasks are stored on a min heap

var taskQueue = [];
var timerQueue = []; // Incrementing id counter. Used to maintain insertion order.

var taskIdCounter = 1; // Pausing the scheduler is useful for debugging.
var currentTask = null;
var currentPriorityLevel = NormalPriority; // This is set while performing work, to prevent re-entrancy.

var isPerformingWork = false;
var isHostCallbackScheduled = false;
var isHostTimeoutScheduled = false;

function advanceTimers(currentTime) {
  // Check for tasks that are no longer delayed and add them to the queue.
  var timer = peek(timerQueue);

  while (timer !== null) {
    if (timer.callback === null) {
      // Timer was cancelled.
      pop(timerQueue);
    } else if (timer.startTime <= currentTime) {
      // Timer fired. Transfer to the task queue.
      pop(timerQueue);
      timer.sortIndex = timer.expirationTime;
      push(taskQueue, timer);

      {
        markTaskStart(timer, currentTime);
        timer.isQueued = true;
      }
    } else {
      // Remaining timers are pending.
      return;
    }

    timer = peek(timerQueue);
  }
}

function handleTimeout(currentTime) {
  isHostTimeoutScheduled = false;
  advanceTimers(currentTime);

  if (!isHostCallbackScheduled) {
    if (peek(taskQueue) !== null) {
      isHostCallbackScheduled = true;
      requestHostCallback(flushWork);
    } else {
      var firstTimer = peek(timerQueue);

      if (firstTimer !== null) {
        requestHostTimeout(handleTimeout, firstTimer.startTime - currentTime);
      }
    }
  }
}

function flushWork(hasTimeRemaining, initialTime) {
  {
    markSchedulerUnsuspended(initialTime);
  } // We'll need a host callback the next time work is scheduled.


  isHostCallbackScheduled = false;

  if (isHostTimeoutScheduled) {
    // We scheduled a timeout but it's no longer needed. Cancel it.
    isHostTimeoutScheduled = false;
    cancelHostTimeout();
  }

  isPerformingWork = true;
  var previousPriorityLevel = currentPriorityLevel;

  try {
    if (enableProfiling) {
      try {
        return workLoop(hasTimeRemaining, initialTime);
      } catch (error) {
        if (currentTask !== null) {
          var currentTime = exports.unstable_now();
          markTaskErrored(currentTask, currentTime);
          currentTask.isQueued = false;
        }

        throw error;
      }
    }
  } finally {
    currentTask = null;
    currentPriorityLevel = previousPriorityLevel;
    isPerformingWork = false;

    {
      var _currentTime = exports.unstable_now();

      markSchedulerSuspended(_currentTime);
    }
  }
}

function workLoop(hasTimeRemaining, initialTime) {
  var currentTime = initialTime;
  advanceTimers(currentTime);
  currentTask = peek(taskQueue);

  while (currentTask !== null && !(enableSchedulerDebugging )) {
    if (currentTask.expirationTime > currentTime && (!hasTimeRemaining || shouldYieldToHost())) {
      // This currentTask hasn't expired, and we've reached the deadline.
      break;
    }

    var callback = currentTask.callback;

    if (callback !== null) {
      currentTask.callback = null;
      currentPriorityLevel = currentTask.priorityLevel;
      var didUserCallbackTimeout = currentTask.expirationTime <= currentTime;
      markTaskRun(currentTask, currentTime);
      var continuationCallback = callback(didUserCallbackTimeout);
      currentTime = exports.unstable_now();

      if (typeof continuationCallback === 'function') {
        currentTask.callback = continuationCallback;
        markTaskYield(currentTask, currentTime);
      } else {
        {
          markTaskCompleted(currentTask, currentTime);
          currentTask.isQueued = false;
        }

        if (currentTask === peek(taskQueue)) {
          pop(taskQueue);
        }
      }

      advanceTimers(currentTime);
    } else {
      pop(taskQueue);
    }

    currentTask = peek(taskQueue);
  } // Return whether there's additional work


  if (currentTask !== null) {
    return true;
  } else {
    var firstTimer = peek(timerQueue);

    if (firstTimer !== null) {
      requestHostTimeout(handleTimeout, firstTimer.startTime - currentTime);
    }

    return false;
  }
}

function unstable_runWithPriority(priorityLevel, eventHandler) {
  switch (priorityLevel) {
    case ImmediatePriority:
    case UserBlockingPriority:
    case NormalPriority:
    case LowPriority:
    case IdlePriority:
      break;

    default:
      priorityLevel = NormalPriority;
  }

  var previousPriorityLevel = currentPriorityLevel;
  currentPriorityLevel = priorityLevel;

  try {
    return eventHandler();
  } finally {
    currentPriorityLevel = previousPriorityLevel;
  }
}

function unstable_next(eventHandler) {
  var priorityLevel;

  switch (currentPriorityLevel) {
    case ImmediatePriority:
    case UserBlockingPriority:
    case NormalPriority:
      // Shift down to normal priority
      priorityLevel = NormalPriority;
      break;

    default:
      // Anything lower than normal priority should remain at the current level.
      priorityLevel = currentPriorityLevel;
      break;
  }

  var previousPriorityLevel = currentPriorityLevel;
  currentPriorityLevel = priorityLevel;

  try {
    return eventHandler();
  } finally {
    currentPriorityLevel = previousPriorityLevel;
  }
}

function unstable_wrapCallback(callback) {
  var parentPriorityLevel = currentPriorityLevel;
  return function () {
    // This is a fork of runWithPriority, inlined for performance.
    var previousPriorityLevel = currentPriorityLevel;
    currentPriorityLevel = parentPriorityLevel;

    try {
      return callback.apply(this, arguments);
    } finally {
      currentPriorityLevel = previousPriorityLevel;
    }
  };
}

function timeoutForPriorityLevel(priorityLevel) {
  switch (priorityLevel) {
    case ImmediatePriority:
      return IMMEDIATE_PRIORITY_TIMEOUT;

    case UserBlockingPriority:
      return USER_BLOCKING_PRIORITY;

    case IdlePriority:
      return IDLE_PRIORITY;

    case LowPriority:
      return LOW_PRIORITY_TIMEOUT;

    case NormalPriority:
    default:
      return NORMAL_PRIORITY_TIMEOUT;
  }
}

function unstable_scheduleCallback(priorityLevel, callback, options) {
  var currentTime = exports.unstable_now();
  var startTime;
  var timeout;

  if (typeof options === 'object' && options !== null) {
    var delay = options.delay;

    if (typeof delay === 'number' && delay > 0) {
      startTime = currentTime + delay;
    } else {
      startTime = currentTime;
    }

    timeout = typeof options.timeout === 'number' ? options.timeout : timeoutForPriorityLevel(priorityLevel);
  } else {
    timeout = timeoutForPriorityLevel(priorityLevel);
    startTime = currentTime;
  }

  var expirationTime = startTime + timeout;
  var newTask = {
    id: taskIdCounter++,
    callback: callback,
    priorityLevel: priorityLevel,
    startTime: startTime,
    expirationTime: expirationTime,
    sortIndex: -1
  };

  {
    newTask.isQueued = false;
  }

  if (startTime > currentTime) {
    // This is a delayed task.
    newTask.sortIndex = startTime;
    push(timerQueue, newTask);

    if (peek(taskQueue) === null && newTask === peek(timerQueue)) {
      // All tasks are delayed, and this is the task with the earliest delay.
      if (isHostTimeoutScheduled) {
        // Cancel an existing timeout.
        cancelHostTimeout();
      } else {
        isHostTimeoutScheduled = true;
      } // Schedule a timeout.


      requestHostTimeout(handleTimeout, startTime - currentTime);
    }
  } else {
    newTask.sortIndex = expirationTime;
    push(taskQueue, newTask);

    {
      markTaskStart(newTask, currentTime);
      newTask.isQueued = true;
    } // Schedule a host callback, if needed. If we're already performing work,
    // wait until the next time we yield.


    if (!isHostCallbackScheduled && !isPerformingWork) {
      isHostCallbackScheduled = true;
      requestHostCallback(flushWork);
    }
  }

  return newTask;
}

function unstable_pauseExecution() {
}

function unstable_continueExecution() {

  if (!isHostCallbackScheduled && !isPerformingWork) {
    isHostCallbackScheduled = true;
    requestHostCallback(flushWork);
  }
}

function unstable_getFirstCallbackNode() {
  return peek(taskQueue);
}

function unstable_cancelCallback(task) {
  {
    if (task.isQueued) {
      var currentTime = exports.unstable_now();
      markTaskCanceled(task, currentTime);
      task.isQueued = false;
    }
  } // Null out the callback to indicate the task has been canceled. (Can't
  // remove from the queue because you can't remove arbitrary nodes from an
  // array based heap, only the first one.)


  task.callback = null;
}

function unstable_getCurrentPriorityLevel() {
  return currentPriorityLevel;
}

function unstable_shouldYield() {
  var currentTime = exports.unstable_now();
  advanceTimers(currentTime);
  var firstTask = peek(taskQueue);
  return firstTask !== currentTask && currentTask !== null && firstTask !== null && firstTask.callback !== null && firstTask.startTime <= currentTime && firstTask.expirationTime < currentTask.expirationTime || shouldYieldToHost();
}

var unstable_requestPaint = requestPaint;
var unstable_Profiling =  {
  startLoggingProfilingEvents: startLoggingProfilingEvents,
  stopLoggingProfilingEvents: stopLoggingProfilingEvents,
  sharedProfilingBuffer: sharedProfilingBuffer
} ;

exports.unstable_IdlePriority = IdlePriority;
exports.unstable_ImmediatePriority = ImmediatePriority;
exports.unstable_LowPriority = LowPriority;
exports.unstable_NormalPriority = NormalPriority;
exports.unstable_Profiling = unstable_Profiling;
exports.unstable_UserBlockingPriority = UserBlockingPriority;
exports.unstable_cancelCallback = unstable_cancelCallback;
exports.unstable_continueExecution = unstable_continueExecution;
exports.unstable_getCurrentPriorityLevel = unstable_getCurrentPriorityLevel;
exports.unstable_getFirstCallbackNode = unstable_getFirstCallbackNode;
exports.unstable_next = unstable_next;
exports.unstable_pauseExecution = unstable_pauseExecution;
exports.unstable_requestPaint = unstable_requestPaint;
exports.unstable_runWithPriority = unstable_runWithPriority;
exports.unstable_scheduleCallback = unstable_scheduleCallback;
exports.unstable_shouldYield = unstable_shouldYield;
exports.unstable_wrapCallback = unstable_wrapCallback;
  })();
}
});

var D__Git_reactPanorama_node_modules_scheduler = createCommonjsModule(function (module) {

{
  module.exports = scheduler_development;
}
});

var schedulerTracing_development = createCommonjsModule(function (module, exports) {



{
  (function() {

var DEFAULT_THREAD_ID = 0; // Counters used to generate unique IDs.

var interactionIDCounter = 0;
var threadIDCounter = 0; // Set of currently traced interactions.
// Interactions "stack"–
// Meaning that newly traced interactions are appended to the previously active set.
// When an interaction goes out of scope, the previous set (if any) is restored.

exports.__interactionsRef = null; // Listener(s) to notify when interactions begin and end.

exports.__subscriberRef = null;

{
  exports.__interactionsRef = {
    current: new Set()
  };
  exports.__subscriberRef = {
    current: null
  };
}
function unstable_clear(callback) {

  var prevInteractions = exports.__interactionsRef.current;
  exports.__interactionsRef.current = new Set();

  try {
    return callback();
  } finally {
    exports.__interactionsRef.current = prevInteractions;
  }
}
function unstable_getCurrent() {
  {
    return exports.__interactionsRef.current;
  }
}
function unstable_getThreadID() {
  return ++threadIDCounter;
}
function unstable_trace(name, timestamp, callback) {
  var threadID = arguments.length > 3 && arguments[3] !== undefined ? arguments[3] : DEFAULT_THREAD_ID;

  var interaction = {
    __count: 1,
    id: interactionIDCounter++,
    name: name,
    timestamp: timestamp
  };
  var prevInteractions = exports.__interactionsRef.current; // Traced interactions should stack/accumulate.
  // To do that, clone the current interactions.
  // The previous set will be restored upon completion.

  var interactions = new Set(prevInteractions);
  interactions.add(interaction);
  exports.__interactionsRef.current = interactions;
  var subscriber = exports.__subscriberRef.current;
  var returnValue;

  try {
    if (subscriber !== null) {
      subscriber.onInteractionTraced(interaction);
    }
  } finally {
    try {
      if (subscriber !== null) {
        subscriber.onWorkStarted(interactions, threadID);
      }
    } finally {
      try {
        returnValue = callback();
      } finally {
        exports.__interactionsRef.current = prevInteractions;

        try {
          if (subscriber !== null) {
            subscriber.onWorkStopped(interactions, threadID);
          }
        } finally {
          interaction.__count--; // If no async work was scheduled for this interaction,
          // Notify subscribers that it's completed.

          if (subscriber !== null && interaction.__count === 0) {
            subscriber.onInteractionScheduledWorkCompleted(interaction);
          }
        }
      }
    }
  }

  return returnValue;
}
function unstable_wrap(callback) {
  var threadID = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : DEFAULT_THREAD_ID;

  var wrappedInteractions = exports.__interactionsRef.current;
  var subscriber = exports.__subscriberRef.current;

  if (subscriber !== null) {
    subscriber.onWorkScheduled(wrappedInteractions, threadID);
  } // Update the pending async work count for the current interactions.
  // Update after calling subscribers in case of error.


  wrappedInteractions.forEach(function (interaction) {
    interaction.__count++;
  });
  var hasRun = false;

  function wrapped() {
    var prevInteractions = exports.__interactionsRef.current;
    exports.__interactionsRef.current = wrappedInteractions;
    subscriber = exports.__subscriberRef.current;

    try {
      var returnValue;

      try {
        if (subscriber !== null) {
          subscriber.onWorkStarted(wrappedInteractions, threadID);
        }
      } finally {
        try {
          returnValue = callback.apply(undefined, arguments);
        } finally {
          exports.__interactionsRef.current = prevInteractions;

          if (subscriber !== null) {
            subscriber.onWorkStopped(wrappedInteractions, threadID);
          }
        }
      }

      return returnValue;
    } finally {
      if (!hasRun) {
        // We only expect a wrapped function to be executed once,
        // But in the event that it's executed more than once–
        // Only decrement the outstanding interaction counts once.
        hasRun = true; // Update pending async counts for all wrapped interactions.
        // If this was the last scheduled async work for any of them,
        // Mark them as completed.

        wrappedInteractions.forEach(function (interaction) {
          interaction.__count--;

          if (subscriber !== null && interaction.__count === 0) {
            subscriber.onInteractionScheduledWorkCompleted(interaction);
          }
        });
      }
    }
  }

  wrapped.cancel = function cancel() {
    subscriber = exports.__subscriberRef.current;

    try {
      if (subscriber !== null) {
        subscriber.onWorkCanceled(wrappedInteractions, threadID);
      }
    } finally {
      // Update pending async counts for all wrapped interactions.
      // If this was the last scheduled async work for any of them,
      // Mark them as completed.
      wrappedInteractions.forEach(function (interaction) {
        interaction.__count--;

        if (subscriber && interaction.__count === 0) {
          subscriber.onInteractionScheduledWorkCompleted(interaction);
        }
      });
    }
  };

  return wrapped;
}

var subscribers = null;

{
  subscribers = new Set();
}

function unstable_subscribe(subscriber) {
  {
    subscribers.add(subscriber);

    if (subscribers.size === 1) {
      exports.__subscriberRef.current = {
        onInteractionScheduledWorkCompleted: onInteractionScheduledWorkCompleted,
        onInteractionTraced: onInteractionTraced,
        onWorkCanceled: onWorkCanceled,
        onWorkScheduled: onWorkScheduled,
        onWorkStarted: onWorkStarted,
        onWorkStopped: onWorkStopped
      };
    }
  }
}
function unstable_unsubscribe(subscriber) {
  {
    subscribers.delete(subscriber);

    if (subscribers.size === 0) {
      exports.__subscriberRef.current = null;
    }
  }
}

function onInteractionTraced(interaction) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onInteractionTraced(interaction);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

function onInteractionScheduledWorkCompleted(interaction) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onInteractionScheduledWorkCompleted(interaction);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

function onWorkScheduled(interactions, threadID) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onWorkScheduled(interactions, threadID);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

function onWorkStarted(interactions, threadID) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onWorkStarted(interactions, threadID);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

function onWorkStopped(interactions, threadID) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onWorkStopped(interactions, threadID);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

function onWorkCanceled(interactions, threadID) {
  var didCatchError = false;
  var caughtError = null;
  subscribers.forEach(function (subscriber) {
    try {
      subscriber.onWorkCanceled(interactions, threadID);
    } catch (error) {
      if (!didCatchError) {
        didCatchError = true;
        caughtError = error;
      }
    }
  });

  if (didCatchError) {
    throw caughtError;
  }
}

exports.unstable_clear = unstable_clear;
exports.unstable_getCurrent = unstable_getCurrent;
exports.unstable_getThreadID = unstable_getThreadID;
exports.unstable_subscribe = unstable_subscribe;
exports.unstable_trace = unstable_trace;
exports.unstable_unsubscribe = unstable_unsubscribe;
exports.unstable_wrap = unstable_wrap;
  })();
}
});

var tracing = createCommonjsModule(function (module) {

{
  module.exports = schedulerTracing_development;
}
});

var reactReconciler_development = createCommonjsModule(function (module) {

{
  module.exports = function $$$reconciler($$$hostConfig) {

var _assign = D__Git_reactPanorama_node_modules_objectAssign;
var React = react__WEBPACK_IMPORTED_MODULE_0__;
var checkPropTypes = checkPropTypes_1;
var Scheduler = D__Git_reactPanorama_node_modules_scheduler;
var tracing$1 = tracing;

var ReactSharedInternals = React.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED; // Prevent newer renderers from RTE when used with older react package versions.
// Current owner and dispatcher used to share the same ref,
// but PR #14548 split them out to better support the react-debug-tools package.

if (!ReactSharedInternals.hasOwnProperty('ReactCurrentDispatcher')) {
  ReactSharedInternals.ReactCurrentDispatcher = {
    current: null
  };
}

if (!ReactSharedInternals.hasOwnProperty('ReactCurrentBatchConfig')) {
  ReactSharedInternals.ReactCurrentBatchConfig = {
    suspense: null
  };
}

// by calls to these methods by a Babel plugin.
//
// In PROD (or in packages without access to React internals),
// they are left as they are instead.

function warn(format) {
  {
    for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
      args[_key - 1] = arguments[_key];
    }

    printWarning('warn', format, args);
  }
}
function error(format) {
  {
    for (var _len2 = arguments.length, args = new Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
      args[_key2 - 1] = arguments[_key2];
    }

    printWarning('error', format, args);
  }
}

function printWarning(level, format, args) {
  // When changing this logic, you might want to also
  // update consoleWithStackDev.www.js as well.
  {
    var hasExistingStack = args.length > 0 && typeof args[args.length - 1] === 'string' && args[args.length - 1].indexOf('\n    in') === 0;

    if (!hasExistingStack) {
      var ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;
      var stack = ReactDebugCurrentFrame.getStackAddendum();

      if (stack !== '') {
        format += '%s';
        args = args.concat([stack]);
      }
    }

    var argsWithFormat = args.map(function (item) {
      return '' + item;
    }); // Careful: RN currently depends on this prefix

    argsWithFormat.unshift('Warning: ' + format); // We intentionally don't use spread (or .apply) directly because it
    // breaks IE9: https://github.com/facebook/react/issues/13610
    // eslint-disable-next-line react-internal/no-production-logging

    Function.prototype.apply.call(console[level], console, argsWithFormat);

    try {
      // --- Welcome to debugging React ---
      // This error was thrown as a convenience so that you can use this stack
      // to find the callsite that caused this warning to fire.
      var argIndex = 0;
      var message = 'Warning: ' + format.replace(/%s/g, function () {
        return args[argIndex++];
      });
      throw new Error(message);
    } catch (x) {}
  }
}

var FunctionComponent = 0;
var ClassComponent = 1;
var IndeterminateComponent = 2; // Before we know whether it is function or class

var HostRoot = 3; // Root of a host tree. Could be nested inside another node.

var HostPortal = 4; // A subtree. Could be an entry point to a different renderer.

var HostComponent = 5;
var HostText = 6;
var Fragment = 7;
var Mode = 8;
var ContextConsumer = 9;
var ContextProvider = 10;
var ForwardRef = 11;
var Profiler = 12;
var SuspenseComponent = 13;
var MemoComponent = 14;
var SimpleMemoComponent = 15;
var LazyComponent = 16;
var IncompleteClassComponent = 17;
var DehydratedFragment = 18;
var SuspenseListComponent = 19;
var FundamentalComponent = 20;
var ScopeComponent = 21;
var Block = 22;

/**
 * `ReactInstanceMap` maintains a mapping from a public facing stateful
 * instance (key) and the internal representation (value). This allows public
 * methods to accept the user facing instance as an argument and map them back
 * to internal methods.
 *
 * Note that this module is currently shared and assumed to be stateless.
 * If this becomes an actual Map, that will break.
 */
function get(key) {
  return key._reactInternalFiber;
}
function set(key, value) {
  key._reactInternalFiber = value;
}

// The Symbol used to tag the ReactElement-like types. If there is no native Symbol
// nor polyfill, then a plain number is used for performance.
var hasSymbol = typeof Symbol === 'function' && Symbol.for;
var REACT_ELEMENT_TYPE = hasSymbol ? Symbol.for('react.element') : 0xeac7;
var REACT_PORTAL_TYPE = hasSymbol ? Symbol.for('react.portal') : 0xeaca;
var REACT_FRAGMENT_TYPE = hasSymbol ? Symbol.for('react.fragment') : 0xeacb;
var REACT_STRICT_MODE_TYPE = hasSymbol ? Symbol.for('react.strict_mode') : 0xeacc;
var REACT_PROFILER_TYPE = hasSymbol ? Symbol.for('react.profiler') : 0xead2;
var REACT_PROVIDER_TYPE = hasSymbol ? Symbol.for('react.provider') : 0xeacd;
var REACT_CONTEXT_TYPE = hasSymbol ? Symbol.for('react.context') : 0xeace; // TODO: We don't use AsyncMode or ConcurrentMode anymore. They were temporary
var REACT_CONCURRENT_MODE_TYPE = hasSymbol ? Symbol.for('react.concurrent_mode') : 0xeacf;
var REACT_FORWARD_REF_TYPE = hasSymbol ? Symbol.for('react.forward_ref') : 0xead0;
var REACT_SUSPENSE_TYPE = hasSymbol ? Symbol.for('react.suspense') : 0xead1;
var REACT_SUSPENSE_LIST_TYPE = hasSymbol ? Symbol.for('react.suspense_list') : 0xead8;
var REACT_MEMO_TYPE = hasSymbol ? Symbol.for('react.memo') : 0xead3;
var REACT_LAZY_TYPE = hasSymbol ? Symbol.for('react.lazy') : 0xead4;
var REACT_BLOCK_TYPE = hasSymbol ? Symbol.for('react.block') : 0xead9;
var MAYBE_ITERATOR_SYMBOL = typeof Symbol === 'function' && Symbol.iterator;
var FAUX_ITERATOR_SYMBOL = '@@iterator';
function getIteratorFn(maybeIterable) {
  if (maybeIterable === null || typeof maybeIterable !== 'object') {
    return null;
  }

  var maybeIterator = MAYBE_ITERATOR_SYMBOL && maybeIterable[MAYBE_ITERATOR_SYMBOL] || maybeIterable[FAUX_ITERATOR_SYMBOL];

  if (typeof maybeIterator === 'function') {
    return maybeIterator;
  }

  return null;
}

var Uninitialized = -1;
var Pending = 0;
var Resolved = 1;
var Rejected = 2;
function refineResolvedLazyComponent(lazyComponent) {
  return lazyComponent._status === Resolved ? lazyComponent._result : null;
}
function initializeLazyComponentType(lazyComponent) {
  if (lazyComponent._status === Uninitialized) {
    lazyComponent._status = Pending;
    var ctor = lazyComponent._ctor;
    var thenable = ctor();
    lazyComponent._result = thenable;
    thenable.then(function (moduleObject) {
      if (lazyComponent._status === Pending) {
        var defaultExport = moduleObject.default;

        {
          if (defaultExport === undefined) {
            error('lazy: Expected the result of a dynamic import() call. ' + 'Instead received: %s\n\nYour code should look like: \n  ' + "const MyComponent = lazy(() => import('./MyComponent'))", moduleObject);
          }
        }

        lazyComponent._status = Resolved;
        lazyComponent._result = defaultExport;
      }
    }, function (error) {
      if (lazyComponent._status === Pending) {
        lazyComponent._status = Rejected;
        lazyComponent._result = error;
      }
    });
  }
}

function getWrappedName(outerType, innerType, wrapperName) {
  var functionName = innerType.displayName || innerType.name || '';
  return outerType.displayName || (functionName !== '' ? wrapperName + "(" + functionName + ")" : wrapperName);
}

function getComponentName(type) {
  if (type == null) {
    // Host root, text node or just invalid type.
    return null;
  }

  {
    if (typeof type.tag === 'number') {
      error('Received an unexpected object in getComponentName(). ' + 'This is likely a bug in React. Please file an issue.');
    }
  }

  if (typeof type === 'function') {
    return type.displayName || type.name || null;
  }

  if (typeof type === 'string') {
    return type;
  }

  switch (type) {
    case REACT_FRAGMENT_TYPE:
      return 'Fragment';

    case REACT_PORTAL_TYPE:
      return 'Portal';

    case REACT_PROFILER_TYPE:
      return "Profiler";

    case REACT_STRICT_MODE_TYPE:
      return 'StrictMode';

    case REACT_SUSPENSE_TYPE:
      return 'Suspense';

    case REACT_SUSPENSE_LIST_TYPE:
      return 'SuspenseList';
  }

  if (typeof type === 'object') {
    switch (type.$$typeof) {
      case REACT_CONTEXT_TYPE:
        return 'Context.Consumer';

      case REACT_PROVIDER_TYPE:
        return 'Context.Provider';

      case REACT_FORWARD_REF_TYPE:
        return getWrappedName(type, type.render, 'ForwardRef');

      case REACT_MEMO_TYPE:
        return getComponentName(type.type);

      case REACT_BLOCK_TYPE:
        return getComponentName(type.render);

      case REACT_LAZY_TYPE:
        {
          var thenable = type;
          var resolvedThenable = refineResolvedLazyComponent(thenable);

          if (resolvedThenable) {
            return getComponentName(resolvedThenable);
          }

          break;
        }
    }
  }

  return null;
}

// Don't change these two values. They're used by React Dev Tools.
var NoEffect =
/*              */
0;
var PerformedWork =
/*         */
1; // You can change the rest (and add more).

var Placement =
/*             */
2;
var Update =
/*                */
4;
var PlacementAndUpdate =
/*    */
6;
var Deletion =
/*              */
8;
var ContentReset =
/*          */
16;
var Callback =
/*              */
32;
var DidCapture =
/*            */
64;
var Ref =
/*                   */
128;
var Snapshot =
/*              */
256;
var Passive =
/*               */
512;
var Hydrating =
/*             */
1024;
var HydratingAndUpdate =
/*    */
1028; // Passive & Update & Callback & Ref & Snapshot

var LifecycleEffectMask =
/*   */
932; // Union of all host effects

var HostEffectMask =
/*        */
2047;
var Incomplete =
/*            */
2048;
var ShouldCapture =
/*         */
4096;

var enableProfilerTimer = true; // Trace which interactions trigger each commit.

var enableFundamentalAPI = false; // Experimental Scope support.
var warnAboutStringRefs = false;

var ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner;
function getNearestMountedFiber(fiber) {
  var node = fiber;
  var nearestMounted = fiber;

  if (!fiber.alternate) {
    // If there is no alternate, this might be a new tree that isn't inserted
    // yet. If it is, then it will have a pending insertion effect on it.
    var nextNode = node;

    do {
      node = nextNode;

      if ((node.effectTag & (Placement | Hydrating)) !== NoEffect) {
        // This is an insertion or in-progress hydration. The nearest possible
        // mounted fiber is the parent but we need to continue to figure out
        // if that one is still mounted.
        nearestMounted = node.return;
      }

      nextNode = node.return;
    } while (nextNode);
  } else {
    while (node.return) {
      node = node.return;
    }
  }

  if (node.tag === HostRoot) {
    // TODO: Check if this was a nested HostRoot when used with
    // renderContainerIntoSubtree.
    return nearestMounted;
  } // If we didn't hit the root, that means that we're in an disconnected tree
  // that has been unmounted.


  return null;
}
function isFiberMounted(fiber) {
  return getNearestMountedFiber(fiber) === fiber;
}
function isMounted(component) {
  {
    var owner = ReactCurrentOwner.current;

    if (owner !== null && owner.tag === ClassComponent) {
      var ownerFiber = owner;
      var instance = ownerFiber.stateNode;

      if (!instance._warnedAboutRefsInRender) {
        error('%s is accessing isMounted inside its render() function. ' + 'render() should be a pure function of props and state. It should ' + 'never access something that requires stale data from the previous ' + 'render, such as refs. Move this logic to componentDidMount and ' + 'componentDidUpdate instead.', getComponentName(ownerFiber.type) || 'A component');
      }

      instance._warnedAboutRefsInRender = true;
    }
  }

  var fiber = get(component);

  if (!fiber) {
    return false;
  }

  return getNearestMountedFiber(fiber) === fiber;
}

function assertIsMounted(fiber) {
  if (!(getNearestMountedFiber(fiber) === fiber)) {
    {
      throw Error( "Unable to find node on an unmounted component." );
    }
  }
}

function findCurrentFiberUsingSlowPath(fiber) {
  var alternate = fiber.alternate;

  if (!alternate) {
    // If there is no alternate, then we only need to check if it is mounted.
    var nearestMounted = getNearestMountedFiber(fiber);

    if (!(nearestMounted !== null)) {
      {
        throw Error( "Unable to find node on an unmounted component." );
      }
    }

    if (nearestMounted !== fiber) {
      return null;
    }

    return fiber;
  } // If we have two possible branches, we'll walk backwards up to the root
  // to see what path the root points to. On the way we may hit one of the
  // special cases and we'll deal with them.


  var a = fiber;
  var b = alternate;

  while (true) {
    var parentA = a.return;

    if (parentA === null) {
      // We're at the root.
      break;
    }

    var parentB = parentA.alternate;

    if (parentB === null) {
      // There is no alternate. This is an unusual case. Currently, it only
      // happens when a Suspense component is hidden. An extra fragment fiber
      // is inserted in between the Suspense fiber and its children. Skip
      // over this extra fragment fiber and proceed to the next parent.
      var nextParent = parentA.return;

      if (nextParent !== null) {
        a = b = nextParent;
        continue;
      } // If there's no parent, we're at the root.


      break;
    } // If both copies of the parent fiber point to the same child, we can
    // assume that the child is current. This happens when we bailout on low
    // priority: the bailed out fiber's child reuses the current child.


    if (parentA.child === parentB.child) {
      var child = parentA.child;

      while (child) {
        if (child === a) {
          // We've determined that A is the current branch.
          assertIsMounted(parentA);
          return fiber;
        }

        if (child === b) {
          // We've determined that B is the current branch.
          assertIsMounted(parentA);
          return alternate;
        }

        child = child.sibling;
      } // We should never have an alternate for any mounting node. So the only
      // way this could possibly happen is if this was unmounted, if at all.


      {
        {
          throw Error( "Unable to find node on an unmounted component." );
        }
      }
    }

    if (a.return !== b.return) {
      // The return pointer of A and the return pointer of B point to different
      // fibers. We assume that return pointers never criss-cross, so A must
      // belong to the child set of A.return, and B must belong to the child
      // set of B.return.
      a = parentA;
      b = parentB;
    } else {
      // The return pointers point to the same fiber. We'll have to use the
      // default, slow path: scan the child sets of each parent alternate to see
      // which child belongs to which set.
      //
      // Search parent A's child set
      var didFindChild = false;
      var _child = parentA.child;

      while (_child) {
        if (_child === a) {
          didFindChild = true;
          a = parentA;
          b = parentB;
          break;
        }

        if (_child === b) {
          didFindChild = true;
          b = parentA;
          a = parentB;
          break;
        }

        _child = _child.sibling;
      }

      if (!didFindChild) {
        // Search parent B's child set
        _child = parentB.child;

        while (_child) {
          if (_child === a) {
            didFindChild = true;
            a = parentB;
            b = parentA;
            break;
          }

          if (_child === b) {
            didFindChild = true;
            b = parentB;
            a = parentA;
            break;
          }

          _child = _child.sibling;
        }

        if (!didFindChild) {
          {
            throw Error( "Child was not found in either parent set. This indicates a bug in React related to the return pointer. Please file an issue." );
          }
        }
      }
    }

    if (!(a.alternate === b)) {
      {
        throw Error( "Return fibers should always be each others' alternates. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  } // If the root is not a host container, we're in a disconnected tree. I.e.
  // unmounted.


  if (!(a.tag === HostRoot)) {
    {
      throw Error( "Unable to find node on an unmounted component." );
    }
  }

  if (a.stateNode.current === a) {
    // We've determined that A is the current branch.
    return fiber;
  } // Otherwise B has to be current branch.


  return alternate;
}
function findCurrentHostFiber(parent) {
  var currentParent = findCurrentFiberUsingSlowPath(parent);

  if (!currentParent) {
    return null;
  } // Next we'll drill down this component to find the first HostComponent/Text.


  var node = currentParent;

  while (true) {
    if (node.tag === HostComponent || node.tag === HostText) {
      return node;
    } else if (node.child) {
      node.child.return = node;
      node = node.child;
      continue;
    }

    if (node === currentParent) {
      return null;
    }

    while (!node.sibling) {
      if (!node.return || node.return === currentParent) {
        return null;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;
  } // Flow needs the return null here, but ESLint complains about it.
  // eslint-disable-next-line no-unreachable


  return null;
}
function findCurrentHostFiberWithNoPortals(parent) {
  var currentParent = findCurrentFiberUsingSlowPath(parent);

  if (!currentParent) {
    return null;
  } // Next we'll drill down this component to find the first HostComponent/Text.


  var node = currentParent;

  while (true) {
    if (node.tag === HostComponent || node.tag === HostText || enableFundamentalAPI ) {
      return node;
    } else if (node.child && node.tag !== HostPortal) {
      node.child.return = node;
      node = node.child;
      continue;
    }

    if (node === currentParent) {
      return null;
    }

    while (!node.sibling) {
      if (!node.return || node.return === currentParent) {
        return null;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;
  } // Flow needs the return null here, but ESLint complains about it.
  // eslint-disable-next-line no-unreachable


  return null;
}

// This is a host config that's used for the `react-reconciler` package on npm.
// It is only used by third-party renderers.
//
// Its API lets you pass the host config as an argument.
// However, inside the `react-reconciler` we treat host config as a module.
// This file is a shim between two worlds.
//
// It works because the `react-reconciler` bundle is wrapped in something like:
//
// module.exports = function ($$$config) {
//   /* reconciler code */
// }
//
// So `$$$config` looks like a global variable, but it's
// really an argument to a top-level wrapping function.
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
// eslint-disable-line no-undef
var getPublicInstance = $$$hostConfig.getPublicInstance;
var getRootHostContext = $$$hostConfig.getRootHostContext;
var getChildHostContext = $$$hostConfig.getChildHostContext;
var prepareForCommit = $$$hostConfig.prepareForCommit;
var resetAfterCommit = $$$hostConfig.resetAfterCommit;
var createInstance = $$$hostConfig.createInstance;
var appendInitialChild = $$$hostConfig.appendInitialChild;
var finalizeInitialChildren = $$$hostConfig.finalizeInitialChildren;
var prepareUpdate = $$$hostConfig.prepareUpdate;
var shouldSetTextContent = $$$hostConfig.shouldSetTextContent;
var shouldDeprioritizeSubtree = $$$hostConfig.shouldDeprioritizeSubtree;
var createTextInstance = $$$hostConfig.createTextInstance;
var scheduleTimeout = $$$hostConfig.setTimeout;
var cancelTimeout = $$$hostConfig.clearTimeout;
var noTimeout = $$$hostConfig.noTimeout;
var now = $$$hostConfig.now;
var isPrimaryRenderer = $$$hostConfig.isPrimaryRenderer;
var warnsIfNotActing = $$$hostConfig.warnsIfNotActing;
var supportsMutation = $$$hostConfig.supportsMutation;
var supportsPersistence = $$$hostConfig.supportsPersistence;
var supportsHydration = $$$hostConfig.supportsHydration;
var DEPRECATED_mountResponderInstance = $$$hostConfig.DEPRECATED_mountResponderInstance;
var DEPRECATED_unmountResponderInstance = $$$hostConfig.DEPRECATED_unmountResponderInstance;
var getFundamentalComponentInstance = $$$hostConfig.getFundamentalComponentInstance;
var mountFundamentalComponent = $$$hostConfig.mountFundamentalComponent;
var shouldUpdateFundamentalComponent = $$$hostConfig.shouldUpdateFundamentalComponent;
var getInstanceFromNode = $$$hostConfig.getInstanceFromNode;
var beforeRemoveInstance = $$$hostConfig.beforeRemoveInstance; // -------------------
//      Mutation
//     (optional)
// -------------------

var appendChild = $$$hostConfig.appendChild;
var appendChildToContainer = $$$hostConfig.appendChildToContainer;
var commitTextUpdate = $$$hostConfig.commitTextUpdate;
var commitMount = $$$hostConfig.commitMount;
var commitUpdate = $$$hostConfig.commitUpdate;
var insertBefore = $$$hostConfig.insertBefore;
var insertInContainerBefore = $$$hostConfig.insertInContainerBefore;
var removeChild = $$$hostConfig.removeChild;
var removeChildFromContainer = $$$hostConfig.removeChildFromContainer;
var resetTextContent = $$$hostConfig.resetTextContent;
var hideInstance = $$$hostConfig.hideInstance;
var hideTextInstance = $$$hostConfig.hideTextInstance;
var unhideInstance = $$$hostConfig.unhideInstance;
var unhideTextInstance = $$$hostConfig.unhideTextInstance;
var updateFundamentalComponent = $$$hostConfig.updateFundamentalComponent;
var unmountFundamentalComponent = $$$hostConfig.unmountFundamentalComponent; // -------------------
//     Persistence
//     (optional)
// -------------------

var cloneInstance = $$$hostConfig.cloneInstance;
var createContainerChildSet = $$$hostConfig.createContainerChildSet;
var appendChildToContainerChildSet = $$$hostConfig.appendChildToContainerChildSet;
var finalizeContainerChildren = $$$hostConfig.finalizeContainerChildren;
var replaceContainerChildren = $$$hostConfig.replaceContainerChildren;
var cloneHiddenInstance = $$$hostConfig.cloneHiddenInstance;
var cloneHiddenTextInstance = $$$hostConfig.cloneHiddenTextInstance;
var cloneFundamentalInstance = $$$hostConfig.cloneInstance; // -------------------
//     Hydration
//     (optional)
// -------------------

var canHydrateInstance = $$$hostConfig.canHydrateInstance;
var canHydrateTextInstance = $$$hostConfig.canHydrateTextInstance;
var canHydrateSuspenseInstance = $$$hostConfig.canHydrateSuspenseInstance;
var isSuspenseInstancePending = $$$hostConfig.isSuspenseInstancePending;
var isSuspenseInstanceFallback = $$$hostConfig.isSuspenseInstanceFallback;
var registerSuspenseInstanceRetry = $$$hostConfig.registerSuspenseInstanceRetry;
var getNextHydratableSibling = $$$hostConfig.getNextHydratableSibling;
var getFirstHydratableChild = $$$hostConfig.getFirstHydratableChild;
var hydrateInstance = $$$hostConfig.hydrateInstance;
var hydrateTextInstance = $$$hostConfig.hydrateTextInstance;
var hydrateSuspenseInstance = $$$hostConfig.hydrateSuspenseInstance;
var getNextHydratableInstanceAfterSuspenseInstance = $$$hostConfig.getNextHydratableInstanceAfterSuspenseInstance;
var commitHydratedContainer = $$$hostConfig.commitHydratedContainer;
var commitHydratedSuspenseInstance = $$$hostConfig.commitHydratedSuspenseInstance;
var clearSuspenseBoundary = $$$hostConfig.clearSuspenseBoundary;
var clearSuspenseBoundaryFromContainer = $$$hostConfig.clearSuspenseBoundaryFromContainer;
var didNotMatchHydratedContainerTextInstance = $$$hostConfig.didNotMatchHydratedContainerTextInstance;
var didNotMatchHydratedTextInstance = $$$hostConfig.didNotMatchHydratedTextInstance;
var didNotHydrateContainerInstance = $$$hostConfig.didNotHydrateContainerInstance;
var didNotHydrateInstance = $$$hostConfig.didNotHydrateInstance;
var didNotFindHydratableContainerInstance = $$$hostConfig.didNotFindHydratableContainerInstance;
var didNotFindHydratableContainerTextInstance = $$$hostConfig.didNotFindHydratableContainerTextInstance;
var didNotFindHydratableContainerSuspenseInstance = $$$hostConfig.didNotFindHydratableContainerSuspenseInstance;
var didNotFindHydratableInstance = $$$hostConfig.didNotFindHydratableInstance;
var didNotFindHydratableTextInstance = $$$hostConfig.didNotFindHydratableTextInstance;
var didNotFindHydratableSuspenseInstance = $$$hostConfig.didNotFindHydratableSuspenseInstance;

var BEFORE_SLASH_RE = /^(.*)[\\\/]/;
function describeComponentFrame (name, source, ownerName) {
  var sourceInfo = '';

  if (source) {
    var path = source.fileName;
    var fileName = path.replace(BEFORE_SLASH_RE, '');

    {
      // In DEV, include code for a common special case:
      // prefer "folder/index.js" instead of just "index.js".
      if (/^index\./.test(fileName)) {
        var match = path.match(BEFORE_SLASH_RE);

        if (match) {
          var pathBeforeSlash = match[1];

          if (pathBeforeSlash) {
            var folderName = pathBeforeSlash.replace(BEFORE_SLASH_RE, '');
            fileName = folderName + '/' + fileName;
          }
        }
      }
    }

    sourceInfo = ' (at ' + fileName + ':' + source.lineNumber + ')';
  } else if (ownerName) {
    sourceInfo = ' (created by ' + ownerName + ')';
  }

  return '\n    in ' + (name || 'Unknown') + sourceInfo;
}

var ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;

function describeFiber(fiber) {
  switch (fiber.tag) {
    case HostRoot:
    case HostPortal:
    case HostText:
    case Fragment:
    case ContextProvider:
    case ContextConsumer:
      return '';

    default:
      var owner = fiber._debugOwner;
      var source = fiber._debugSource;
      var name = getComponentName(fiber.type);
      var ownerName = null;

      if (owner) {
        ownerName = getComponentName(owner.type);
      }

      return describeComponentFrame(name, source, ownerName);
  }
}

function getStackByFiberInDevAndProd(workInProgress) {
  var info = '';
  var node = workInProgress;

  do {
    info += describeFiber(node);
    node = node.return;
  } while (node);

  return info;
}
var current = null;
var isRendering = false;
function getCurrentFiberOwnerNameInDevOrNull() {
  {
    if (current === null) {
      return null;
    }

    var owner = current._debugOwner;

    if (owner !== null && typeof owner !== 'undefined') {
      return getComponentName(owner.type);
    }
  }

  return null;
}
function getCurrentFiberStackInDev() {
  {
    if (current === null) {
      return '';
    } // Safe because if current fiber exists, we are reconciling,
    // and it is guaranteed to be the work-in-progress version.


    return getStackByFiberInDevAndProd(current);
  }
}
function resetCurrentFiber() {
  {
    ReactDebugCurrentFrame.getCurrentStack = null;
    current = null;
    isRendering = false;
  }
}
function setCurrentFiber(fiber) {
  {
    ReactDebugCurrentFrame.getCurrentStack = getCurrentFiberStackInDev;
    current = fiber;
    isRendering = false;
  }
}
function setIsRendering(rendering) {
  {
    isRendering = rendering;
  }
}

// Prefix measurements so that it's possible to filter them.
// Longer prefixes are hard to read in DevTools.
var reactEmoji = "\u269B";
var warningEmoji = "\u26D4";
var supportsUserTiming = typeof performance !== 'undefined' && typeof performance.mark === 'function' && typeof performance.clearMarks === 'function' && typeof performance.measure === 'function' && typeof performance.clearMeasures === 'function'; // Keep track of current fiber so that we know the path to unwind on pause.
// TODO: this looks the same as nextUnitOfWork in scheduler. Can we unify them?

var currentFiber = null; // If we're in the middle of user code, which fiber and method is it?
// Reusing `currentFiber` would be confusing for this because user code fiber
// can change during commit phase too, but we don't need to unwind it (since
// lifecycles in the commit phase don't resemble a tree).

var currentPhase = null;
var currentPhaseFiber = null; // Did lifecycle hook schedule an update? This is often a performance problem,
// so we will keep track of it, and include it in the report.
// Track commits caused by cascading updates.

var isCommitting = false;
var hasScheduledUpdateInCurrentCommit = false;
var hasScheduledUpdateInCurrentPhase = false;
var commitCountInCurrentWorkLoop = 0;
var effectCountInCurrentCommit = 0;
// to avoid stretch the commit phase with measurement overhead.

var labelsInCurrentCommit = new Set();

var formatMarkName = function (markName) {
  return reactEmoji + " " + markName;
};

var formatLabel = function (label, warning) {
  var prefix = warning ? warningEmoji + " " : reactEmoji + " ";
  var suffix = warning ? " Warning: " + warning : '';
  return "" + prefix + label + suffix;
};

var beginMark = function (markName) {
  performance.mark(formatMarkName(markName));
};

var clearMark = function (markName) {
  performance.clearMarks(formatMarkName(markName));
};

var endMark = function (label, markName, warning) {
  var formattedMarkName = formatMarkName(markName);
  var formattedLabel = formatLabel(label, warning);

  try {
    performance.measure(formattedLabel, formattedMarkName);
  } catch (err) {} // If previous mark was missing for some reason, this will throw.
  // This could only happen if React crashed in an unexpected place earlier.
  // Don't pile on with more errors.
  // Clear marks immediately to avoid growing buffer.


  performance.clearMarks(formattedMarkName);
  performance.clearMeasures(formattedLabel);
};

var getFiberMarkName = function (label, debugID) {
  return label + " (#" + debugID + ")";
};

var getFiberLabel = function (componentName, isMounted, phase) {
  if (phase === null) {
    // These are composite component total time measurements.
    return componentName + " [" + (isMounted ? 'update' : 'mount') + "]";
  } else {
    // Composite component methods.
    return componentName + "." + phase;
  }
};

var beginFiberMark = function (fiber, phase) {
  var componentName = getComponentName(fiber.type) || 'Unknown';
  var debugID = fiber._debugID;
  var isMounted = fiber.alternate !== null;
  var label = getFiberLabel(componentName, isMounted, phase);

  if (isCommitting && labelsInCurrentCommit.has(label)) {
    // During the commit phase, we don't show duplicate labels because
    // there is a fixed overhead for every measurement, and we don't
    // want to stretch the commit phase beyond necessary.
    return false;
  }

  labelsInCurrentCommit.add(label);
  var markName = getFiberMarkName(label, debugID);
  beginMark(markName);
  return true;
};

var clearFiberMark = function (fiber, phase) {
  var componentName = getComponentName(fiber.type) || 'Unknown';
  var debugID = fiber._debugID;
  var isMounted = fiber.alternate !== null;
  var label = getFiberLabel(componentName, isMounted, phase);
  var markName = getFiberMarkName(label, debugID);
  clearMark(markName);
};

var endFiberMark = function (fiber, phase, warning) {
  var componentName = getComponentName(fiber.type) || 'Unknown';
  var debugID = fiber._debugID;
  var isMounted = fiber.alternate !== null;
  var label = getFiberLabel(componentName, isMounted, phase);
  var markName = getFiberMarkName(label, debugID);
  endMark(label, markName, warning);
};

var shouldIgnoreFiber = function (fiber) {
  // Host components should be skipped in the timeline.
  // We could check typeof fiber.type, but does this work with RN?
  switch (fiber.tag) {
    case HostRoot:
    case HostComponent:
    case HostText:
    case HostPortal:
    case Fragment:
    case ContextProvider:
    case ContextConsumer:
    case Mode:
      return true;

    default:
      return false;
  }
};

var clearPendingPhaseMeasurement = function () {
  if (currentPhase !== null && currentPhaseFiber !== null) {
    clearFiberMark(currentPhaseFiber, currentPhase);
  }

  currentPhaseFiber = null;
  currentPhase = null;
  hasScheduledUpdateInCurrentPhase = false;
};

var pauseTimers = function () {
  // Stops all currently active measurements so that they can be resumed
  // if we continue in a later deferred loop from the same unit of work.
  var fiber = currentFiber;

  while (fiber) {
    if (fiber._debugIsCurrentlyTiming) {
      endFiberMark(fiber, null, null);
    }

    fiber = fiber.return;
  }
};

var resumeTimersRecursively = function (fiber) {
  if (fiber.return !== null) {
    resumeTimersRecursively(fiber.return);
  }

  if (fiber._debugIsCurrentlyTiming) {
    beginFiberMark(fiber, null);
  }
};

var resumeTimers = function () {
  // Resumes all measurements that were active during the last deferred loop.
  if (currentFiber !== null) {
    resumeTimersRecursively(currentFiber);
  }
};

function recordEffect() {
  {
    effectCountInCurrentCommit++;
  }
}
function recordScheduleUpdate() {
  {
    if (isCommitting) {
      hasScheduledUpdateInCurrentCommit = true;
    }

    if (currentPhase !== null && currentPhase !== 'componentWillMount' && currentPhase !== 'componentWillReceiveProps') {
      hasScheduledUpdateInCurrentPhase = true;
    }
  }
}
function startWorkTimer(fiber) {
  {
    if (!supportsUserTiming || shouldIgnoreFiber(fiber)) {
      return;
    } // If we pause, this is the fiber to unwind from.


    currentFiber = fiber;

    if (!beginFiberMark(fiber, null)) {
      return;
    }

    fiber._debugIsCurrentlyTiming = true;
  }
}
function cancelWorkTimer(fiber) {
  {
    if (!supportsUserTiming || shouldIgnoreFiber(fiber)) {
      return;
    } // Remember we shouldn't complete measurement for this fiber.
    // Otherwise flamechart will be deep even for small updates.


    fiber._debugIsCurrentlyTiming = false;
    clearFiberMark(fiber, null);
  }
}
function stopWorkTimer(fiber) {
  {
    if (!supportsUserTiming || shouldIgnoreFiber(fiber)) {
      return;
    } // If we pause, its parent is the fiber to unwind from.


    currentFiber = fiber.return;

    if (!fiber._debugIsCurrentlyTiming) {
      return;
    }

    fiber._debugIsCurrentlyTiming = false;
    endFiberMark(fiber, null, null);
  }
}
function stopFailedWorkTimer(fiber) {
  {
    if (!supportsUserTiming || shouldIgnoreFiber(fiber)) {
      return;
    } // If we pause, its parent is the fiber to unwind from.


    currentFiber = fiber.return;

    if (!fiber._debugIsCurrentlyTiming) {
      return;
    }

    fiber._debugIsCurrentlyTiming = false;
    var warning = fiber.tag === SuspenseComponent ? 'Rendering was suspended' : 'An error was thrown inside this error boundary';
    endFiberMark(fiber, null, warning);
  }
}
function startPhaseTimer(fiber, phase) {
  {
    if (!supportsUserTiming) {
      return;
    }

    clearPendingPhaseMeasurement();

    if (!beginFiberMark(fiber, phase)) {
      return;
    }

    currentPhaseFiber = fiber;
    currentPhase = phase;
  }
}
function stopPhaseTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    if (currentPhase !== null && currentPhaseFiber !== null) {
      var warning = hasScheduledUpdateInCurrentPhase ? 'Scheduled a cascading update' : null;
      endFiberMark(currentPhaseFiber, currentPhase, warning);
    }

    currentPhase = null;
    currentPhaseFiber = null;
  }
}
function startWorkLoopTimer(nextUnitOfWork) {
  {
    currentFiber = nextUnitOfWork;

    if (!supportsUserTiming) {
      return;
    }

    commitCountInCurrentWorkLoop = 0; // This is top level call.
    // Any other measurements are performed within.

    beginMark('(React Tree Reconciliation)'); // Resume any measurements that were in progress during the last loop.

    resumeTimers();
  }
}
function stopWorkLoopTimer(interruptedBy, didCompleteRoot) {
  {
    if (!supportsUserTiming) {
      return;
    }

    var warning = null;

    if (interruptedBy !== null) {
      if (interruptedBy.tag === HostRoot) {
        warning = 'A top-level update interrupted the previous render';
      } else {
        var componentName = getComponentName(interruptedBy.type) || 'Unknown';
        warning = "An update to " + componentName + " interrupted the previous render";
      }
    } else if (commitCountInCurrentWorkLoop > 1) {
      warning = 'There were cascading updates';
    }

    commitCountInCurrentWorkLoop = 0;
    var label = didCompleteRoot ? '(React Tree Reconciliation: Completed Root)' : '(React Tree Reconciliation: Yielded)'; // Pause any measurements until the next loop.

    pauseTimers();
    endMark(label, '(React Tree Reconciliation)', warning);
  }
}
function startCommitTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    isCommitting = true;
    hasScheduledUpdateInCurrentCommit = false;
    labelsInCurrentCommit.clear();
    beginMark('(Committing Changes)');
  }
}
function stopCommitTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    var warning = null;

    if (hasScheduledUpdateInCurrentCommit) {
      warning = 'Lifecycle hook scheduled a cascading update';
    } else if (commitCountInCurrentWorkLoop > 0) {
      warning = 'Caused by a cascading update in earlier commit';
    }

    hasScheduledUpdateInCurrentCommit = false;
    commitCountInCurrentWorkLoop++;
    isCommitting = false;
    labelsInCurrentCommit.clear();
    endMark('(Committing Changes)', '(Committing Changes)', warning);
  }
}
function startCommitSnapshotEffectsTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    effectCountInCurrentCommit = 0;
    beginMark('(Committing Snapshot Effects)');
  }
}
function stopCommitSnapshotEffectsTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    var count = effectCountInCurrentCommit;
    effectCountInCurrentCommit = 0;
    endMark("(Committing Snapshot Effects: " + count + " Total)", '(Committing Snapshot Effects)', null);
  }
}
function startCommitHostEffectsTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    effectCountInCurrentCommit = 0;
    beginMark('(Committing Host Effects)');
  }
}
function stopCommitHostEffectsTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    var count = effectCountInCurrentCommit;
    effectCountInCurrentCommit = 0;
    endMark("(Committing Host Effects: " + count + " Total)", '(Committing Host Effects)', null);
  }
}
function startCommitLifeCyclesTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    effectCountInCurrentCommit = 0;
    beginMark('(Calling Lifecycle Methods)');
  }
}
function stopCommitLifeCyclesTimer() {
  {
    if (!supportsUserTiming) {
      return;
    }

    var count = effectCountInCurrentCommit;
    effectCountInCurrentCommit = 0;
    endMark("(Calling Lifecycle Methods: " + count + " Total)", '(Calling Lifecycle Methods)', null);
  }
}

var valueStack = [];
var fiberStack;

{
  fiberStack = [];
}

var index = -1;

function createCursor(defaultValue) {
  return {
    current: defaultValue
  };
}

function pop(cursor, fiber) {
  if (index < 0) {
    {
      error('Unexpected pop.');
    }

    return;
  }

  {
    if (fiber !== fiberStack[index]) {
      error('Unexpected Fiber popped.');
    }
  }

  cursor.current = valueStack[index];
  valueStack[index] = null;

  {
    fiberStack[index] = null;
  }

  index--;
}

function push(cursor, value, fiber) {
  index++;
  valueStack[index] = cursor.current;

  {
    fiberStack[index] = fiber;
  }

  cursor.current = value;
}

var warnedAboutMissingGetChildContext;

{
  warnedAboutMissingGetChildContext = {};
}

var emptyContextObject = {};

{
  Object.freeze(emptyContextObject);
} // A cursor to the current merged context object on the stack.


var contextStackCursor = createCursor(emptyContextObject); // A cursor to a boolean indicating whether the context has changed.

var didPerformWorkStackCursor = createCursor(false); // Keep track of the previous context object that was on the stack.
// We use this to get access to the parent context after we have already
// pushed the next context provider, and now need to merge their contexts.

var previousContext = emptyContextObject;

function getUnmaskedContext(workInProgress, Component, didPushOwnContextIfProvider) {
  {
    if (didPushOwnContextIfProvider && isContextProvider(Component)) {
      // If the fiber is a context provider itself, when we read its context
      // we may have already pushed its own child context on the stack. A context
      // provider should not "see" its own child context. Therefore we read the
      // previous (parent) context instead for a context provider.
      return previousContext;
    }

    return contextStackCursor.current;
  }
}

function cacheContext(workInProgress, unmaskedContext, maskedContext) {
  {
    var instance = workInProgress.stateNode;
    instance.__reactInternalMemoizedUnmaskedChildContext = unmaskedContext;
    instance.__reactInternalMemoizedMaskedChildContext = maskedContext;
  }
}

function getMaskedContext(workInProgress, unmaskedContext) {
  {
    var type = workInProgress.type;
    var contextTypes = type.contextTypes;

    if (!contextTypes) {
      return emptyContextObject;
    } // Avoid recreating masked context unless unmasked context has changed.
    // Failing to do this will result in unnecessary calls to componentWillReceiveProps.
    // This may trigger infinite loops if componentWillReceiveProps calls setState.


    var instance = workInProgress.stateNode;

    if (instance && instance.__reactInternalMemoizedUnmaskedChildContext === unmaskedContext) {
      return instance.__reactInternalMemoizedMaskedChildContext;
    }

    var context = {};

    for (var key in contextTypes) {
      context[key] = unmaskedContext[key];
    }

    {
      var name = getComponentName(type) || 'Unknown';
      checkPropTypes(contextTypes, context, 'context', name, getCurrentFiberStackInDev);
    } // Cache unmasked context so we can avoid recreating masked context unless necessary.
    // Context is created before the class component is instantiated so check for instance.


    if (instance) {
      cacheContext(workInProgress, unmaskedContext, context);
    }

    return context;
  }
}

function hasContextChanged() {
  {
    return didPerformWorkStackCursor.current;
  }
}

function isContextProvider(type) {
  {
    var childContextTypes = type.childContextTypes;
    return childContextTypes !== null && childContextTypes !== undefined;
  }
}

function popContext(fiber) {
  {
    pop(didPerformWorkStackCursor, fiber);
    pop(contextStackCursor, fiber);
  }
}

function popTopLevelContextObject(fiber) {
  {
    pop(didPerformWorkStackCursor, fiber);
    pop(contextStackCursor, fiber);
  }
}

function pushTopLevelContextObject(fiber, context, didChange) {
  {
    if (!(contextStackCursor.current === emptyContextObject)) {
      {
        throw Error( "Unexpected context found on stack. This error is likely caused by a bug in React. Please file an issue." );
      }
    }

    push(contextStackCursor, context, fiber);
    push(didPerformWorkStackCursor, didChange, fiber);
  }
}

function processChildContext(fiber, type, parentContext) {
  {
    var instance = fiber.stateNode;
    var childContextTypes = type.childContextTypes; // TODO (bvaughn) Replace this behavior with an invariant() in the future.
    // It has only been added in Fiber to match the (unintentional) behavior in Stack.

    if (typeof instance.getChildContext !== 'function') {
      {
        var componentName = getComponentName(type) || 'Unknown';

        if (!warnedAboutMissingGetChildContext[componentName]) {
          warnedAboutMissingGetChildContext[componentName] = true;

          error('%s.childContextTypes is specified but there is no getChildContext() method ' + 'on the instance. You can either define getChildContext() on %s or remove ' + 'childContextTypes from it.', componentName, componentName);
        }
      }

      return parentContext;
    }

    var childContext;
    startPhaseTimer(fiber, 'getChildContext');
    childContext = instance.getChildContext();
    stopPhaseTimer();

    for (var contextKey in childContext) {
      if (!(contextKey in childContextTypes)) {
        {
          throw Error( (getComponentName(type) || 'Unknown') + ".getChildContext(): key \"" + contextKey + "\" is not defined in childContextTypes." );
        }
      }
    }

    {
      var name = getComponentName(type) || 'Unknown';
      checkPropTypes(childContextTypes, childContext, 'child context', name, // In practice, there is one case in which we won't get a stack. It's when
      // somebody calls unstable_renderSubtreeIntoContainer() and we process
      // context from the parent component instance. The stack will be missing
      // because it's outside of the reconciliation, and so the pointer has not
      // been set. This is rare and doesn't matter. We'll also remove that API.
      getCurrentFiberStackInDev);
    }

    return _assign({}, parentContext, {}, childContext);
  }
}

function pushContextProvider(workInProgress) {
  {
    var instance = workInProgress.stateNode; // We push the context as early as possible to ensure stack integrity.
    // If the instance does not exist yet, we will push null at first,
    // and replace it on the stack later when invalidating the context.

    var memoizedMergedChildContext = instance && instance.__reactInternalMemoizedMergedChildContext || emptyContextObject; // Remember the parent context so we can merge with it later.
    // Inherit the parent's did-perform-work value to avoid inadvertently blocking updates.

    previousContext = contextStackCursor.current;
    push(contextStackCursor, memoizedMergedChildContext, workInProgress);
    push(didPerformWorkStackCursor, didPerformWorkStackCursor.current, workInProgress);
    return true;
  }
}

function invalidateContextProvider(workInProgress, type, didChange) {
  {
    var instance = workInProgress.stateNode;

    if (!instance) {
      {
        throw Error( "Expected to have an instance by this point. This error is likely caused by a bug in React. Please file an issue." );
      }
    }

    if (didChange) {
      // Merge parent and own context.
      // Skip this if we're not updating due to sCU.
      // This avoids unnecessarily recomputing memoized values.
      var mergedContext = processChildContext(workInProgress, type, previousContext);
      instance.__reactInternalMemoizedMergedChildContext = mergedContext; // Replace the old (or empty) context with the new one.
      // It is important to unwind the context in the reverse order.

      pop(didPerformWorkStackCursor, workInProgress);
      pop(contextStackCursor, workInProgress); // Now push the new context and mark that it has changed.

      push(contextStackCursor, mergedContext, workInProgress);
      push(didPerformWorkStackCursor, didChange, workInProgress);
    } else {
      pop(didPerformWorkStackCursor, workInProgress);
      push(didPerformWorkStackCursor, didChange, workInProgress);
    }
  }
}

function findCurrentUnmaskedContext(fiber) {
  {
    // Currently this is only used with renderSubtreeIntoContainer; not sure if it
    // makes sense elsewhere
    if (!(isFiberMounted(fiber) && fiber.tag === ClassComponent)) {
      {
        throw Error( "Expected subtree parent to be a mounted class component. This error is likely caused by a bug in React. Please file an issue." );
      }
    }

    var node = fiber;

    do {
      switch (node.tag) {
        case HostRoot:
          return node.stateNode.context;

        case ClassComponent:
          {
            var Component = node.type;

            if (isContextProvider(Component)) {
              return node.stateNode.__reactInternalMemoizedMergedChildContext;
            }

            break;
          }
      }

      node = node.return;
    } while (node !== null);

    {
      {
        throw Error( "Found unexpected detached subtree parent. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  }
}

var BlockingRoot = 1;
var ConcurrentRoot = 2;

var Scheduler_runWithPriority = Scheduler.unstable_runWithPriority,
    Scheduler_scheduleCallback = Scheduler.unstable_scheduleCallback,
    Scheduler_cancelCallback = Scheduler.unstable_cancelCallback,
    Scheduler_shouldYield = Scheduler.unstable_shouldYield,
    Scheduler_requestPaint = Scheduler.unstable_requestPaint,
    Scheduler_now = Scheduler.unstable_now,
    Scheduler_getCurrentPriorityLevel = Scheduler.unstable_getCurrentPriorityLevel,
    Scheduler_ImmediatePriority = Scheduler.unstable_ImmediatePriority,
    Scheduler_UserBlockingPriority = Scheduler.unstable_UserBlockingPriority,
    Scheduler_NormalPriority = Scheduler.unstable_NormalPriority,
    Scheduler_LowPriority = Scheduler.unstable_LowPriority,
    Scheduler_IdlePriority = Scheduler.unstable_IdlePriority;

{
  // Provide explicit error message when production+profiling bundle of e.g.
  // react-dom is used with production (non-profiling) bundle of
  // scheduler/tracing
  if (!(tracing$1.__interactionsRef != null && tracing$1.__interactionsRef.current != null)) {
    {
      throw Error( "It is not supported to run the profiling version of a renderer (for example, `react-dom/profiling`) without also replacing the `scheduler/tracing` module with `scheduler/tracing-profiling`. Your bundler might have a setting for aliasing both modules. Learn more at http://fb.me/react-profiling" );
    }
  }
}

var fakeCallbackNode = {}; // Except for NoPriority, these correspond to Scheduler priorities. We use
// ascending numbers so we can compare them like numbers. They start at 90 to
// avoid clashing with Scheduler's priorities.

var ImmediatePriority = 99;
var UserBlockingPriority = 98;
var NormalPriority = 97;
var LowPriority = 96;
var IdlePriority = 95; // NoPriority is the absence of priority. Also React-only.

var NoPriority = 90;
var shouldYield = Scheduler_shouldYield;
var requestPaint = // Fall back gracefully if we're running an older version of Scheduler.
Scheduler_requestPaint !== undefined ? Scheduler_requestPaint : function () {};
var syncQueue = null;
var immediateQueueCallbackNode = null;
var isFlushingSyncQueue = false;
var initialTimeMs = Scheduler_now(); // If the initial timestamp is reasonably small, use Scheduler's `now` directly.
// This will be the case for modern browsers that support `performance.now`. In
// older browsers, Scheduler falls back to `Date.now`, which returns a Unix
// timestamp. In that case, subtract the module initialization time to simulate
// the behavior of performance.now and keep our times small enough to fit
// within 32 bits.
// TODO: Consider lifting this into Scheduler.

var now$1 = initialTimeMs < 10000 ? Scheduler_now : function () {
  return Scheduler_now() - initialTimeMs;
};
function getCurrentPriorityLevel() {
  switch (Scheduler_getCurrentPriorityLevel()) {
    case Scheduler_ImmediatePriority:
      return ImmediatePriority;

    case Scheduler_UserBlockingPriority:
      return UserBlockingPriority;

    case Scheduler_NormalPriority:
      return NormalPriority;

    case Scheduler_LowPriority:
      return LowPriority;

    case Scheduler_IdlePriority:
      return IdlePriority;

    default:
      {
        {
          throw Error( "Unknown priority level." );
        }
      }

  }
}

function reactPriorityToSchedulerPriority(reactPriorityLevel) {
  switch (reactPriorityLevel) {
    case ImmediatePriority:
      return Scheduler_ImmediatePriority;

    case UserBlockingPriority:
      return Scheduler_UserBlockingPriority;

    case NormalPriority:
      return Scheduler_NormalPriority;

    case LowPriority:
      return Scheduler_LowPriority;

    case IdlePriority:
      return Scheduler_IdlePriority;

    default:
      {
        {
          throw Error( "Unknown priority level." );
        }
      }

  }
}

function runWithPriority(reactPriorityLevel, fn) {
  var priorityLevel = reactPriorityToSchedulerPriority(reactPriorityLevel);
  return Scheduler_runWithPriority(priorityLevel, fn);
}
function scheduleCallback(reactPriorityLevel, callback, options) {
  var priorityLevel = reactPriorityToSchedulerPriority(reactPriorityLevel);
  return Scheduler_scheduleCallback(priorityLevel, callback, options);
}
function scheduleSyncCallback(callback) {
  // Push this callback into an internal queue. We'll flush these either in
  // the next tick, or earlier if something calls `flushSyncCallbackQueue`.
  if (syncQueue === null) {
    syncQueue = [callback]; // Flush the queue in the next tick, at the earliest.

    immediateQueueCallbackNode = Scheduler_scheduleCallback(Scheduler_ImmediatePriority, flushSyncCallbackQueueImpl);
  } else {
    // Push onto existing queue. Don't need to schedule a callback because
    // we already scheduled one when we created the queue.
    syncQueue.push(callback);
  }

  return fakeCallbackNode;
}
function cancelCallback(callbackNode) {
  if (callbackNode !== fakeCallbackNode) {
    Scheduler_cancelCallback(callbackNode);
  }
}
function flushSyncCallbackQueue() {
  if (immediateQueueCallbackNode !== null) {
    var node = immediateQueueCallbackNode;
    immediateQueueCallbackNode = null;
    Scheduler_cancelCallback(node);
  }

  flushSyncCallbackQueueImpl();
}

function flushSyncCallbackQueueImpl() {
  if (!isFlushingSyncQueue && syncQueue !== null) {
    // Prevent re-entrancy.
    isFlushingSyncQueue = true;
    var i = 0;

    try {
      var _isSync = true;
      var queue = syncQueue;
      runWithPriority(ImmediatePriority, function () {
        for (; i < queue.length; i++) {
          var callback = queue[i];

          do {
            callback = callback(_isSync);
          } while (callback !== null);
        }
      });
      syncQueue = null;
    } catch (error) {
      // If something throws, leave the remaining callbacks on the queue.
      if (syncQueue !== null) {
        syncQueue = syncQueue.slice(i + 1);
      } // Resume flushing in the next tick


      Scheduler_scheduleCallback(Scheduler_ImmediatePriority, flushSyncCallbackQueue);
      throw error;
    } finally {
      isFlushingSyncQueue = false;
    }
  }
}

var NoMode = 0;
var StrictMode = 1; // TODO: Remove BlockingMode and ConcurrentMode by reading from the root
// tag instead

var BlockingMode = 2;
var ConcurrentMode = 4;
var ProfileMode = 8;

// Max 31 bit integer. The max integer size in V8 for 32-bit systems.
// Math.pow(2, 30) - 1
// 0b111111111111111111111111111111
var MAX_SIGNED_31_BIT_INT = 1073741823;

var NoWork = 0; // TODO: Think of a better name for Never. The key difference with Idle is that
// Never work can be committed in an inconsistent state without tearing the UI.
// The main example is offscreen content, like a hidden subtree. So one possible
// name is Offscreen. However, it also includes dehydrated Suspense boundaries,
// which are inconsistent in the sense that they haven't finished yet, but
// aren't visibly inconsistent because the server rendered HTML matches what the
// hydrated tree would look like.

var Never = 1; // Idle is slightly higher priority than Never. It must completely finish in
// order to be consistent.

var Idle = 2; // Continuous Hydration is slightly higher than Idle and is used to increase
// priority of hover targets.

var ContinuousHydration = 3;
var Sync = MAX_SIGNED_31_BIT_INT;
var Batched = Sync - 1;
var UNIT_SIZE = 10;
var MAGIC_NUMBER_OFFSET = Batched - 1; // 1 unit of expiration time represents 10ms.

function msToExpirationTime(ms) {
  // Always subtract from the offset so that we don't clash with the magic number for NoWork.
  return MAGIC_NUMBER_OFFSET - (ms / UNIT_SIZE | 0);
}
function expirationTimeToMs(expirationTime) {
  return (MAGIC_NUMBER_OFFSET - expirationTime) * UNIT_SIZE;
}

function ceiling(num, precision) {
  return ((num / precision | 0) + 1) * precision;
}

function computeExpirationBucket(currentTime, expirationInMs, bucketSizeMs) {
  return MAGIC_NUMBER_OFFSET - ceiling(MAGIC_NUMBER_OFFSET - currentTime + expirationInMs / UNIT_SIZE, bucketSizeMs / UNIT_SIZE);
} // TODO: This corresponds to Scheduler's NormalPriority, not LowPriority. Update
// the names to reflect.


var LOW_PRIORITY_EXPIRATION = 5000;
var LOW_PRIORITY_BATCH_SIZE = 250;
function computeAsyncExpiration(currentTime) {
  return computeExpirationBucket(currentTime, LOW_PRIORITY_EXPIRATION, LOW_PRIORITY_BATCH_SIZE);
}
function computeSuspenseExpiration(currentTime, timeoutMs) {
  // TODO: Should we warn if timeoutMs is lower than the normal pri expiration time?
  return computeExpirationBucket(currentTime, timeoutMs, LOW_PRIORITY_BATCH_SIZE);
} // We intentionally set a higher expiration time for interactive updates in
// dev than in production.
//
// If the main thread is being blocked so long that you hit the expiration,
// it's a problem that could be solved with better scheduling.
//
// People will be more likely to notice this and fix it with the long
// expiration time in development.
//
// In production we opt for better UX at the risk of masking scheduling
// problems, by expiring fast.

var HIGH_PRIORITY_EXPIRATION =  500 ;
var HIGH_PRIORITY_BATCH_SIZE = 100;
function computeInteractiveExpiration(currentTime) {
  return computeExpirationBucket(currentTime, HIGH_PRIORITY_EXPIRATION, HIGH_PRIORITY_BATCH_SIZE);
}
function inferPriorityFromExpirationTime(currentTime, expirationTime) {
  if (expirationTime === Sync) {
    return ImmediatePriority;
  }

  if (expirationTime === Never || expirationTime === Idle) {
    return IdlePriority;
  }

  var msUntil = expirationTimeToMs(expirationTime) - expirationTimeToMs(currentTime);

  if (msUntil <= 0) {
    return ImmediatePriority;
  }

  if (msUntil <= HIGH_PRIORITY_EXPIRATION + HIGH_PRIORITY_BATCH_SIZE) {
    return UserBlockingPriority;
  }

  if (msUntil <= LOW_PRIORITY_EXPIRATION + LOW_PRIORITY_BATCH_SIZE) {
    return NormalPriority;
  } // TODO: Handle LowPriority
  // Assume anything lower has idle priority


  return IdlePriority;
}

/**
 * inlined Object.is polyfill to avoid requiring consumers ship their own
 * https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/is
 */
function is(x, y) {
  return x === y && (x !== 0 || 1 / x === 1 / y) || x !== x && y !== y // eslint-disable-line no-self-compare
  ;
}

var objectIs = typeof Object.is === 'function' ? Object.is : is;

var hasOwnProperty = Object.prototype.hasOwnProperty;
/**
 * Performs equality by iterating through keys on an object and returning false
 * when any key has values which are not strictly equal between the arguments.
 * Returns true when the values of all keys are strictly equal.
 */

function shallowEqual(objA, objB) {
  if (objectIs(objA, objB)) {
    return true;
  }

  if (typeof objA !== 'object' || objA === null || typeof objB !== 'object' || objB === null) {
    return false;
  }

  var keysA = Object.keys(objA);
  var keysB = Object.keys(objB);

  if (keysA.length !== keysB.length) {
    return false;
  } // Test for A's keys different from B.


  for (var i = 0; i < keysA.length; i++) {
    if (!hasOwnProperty.call(objB, keysA[i]) || !objectIs(objA[keysA[i]], objB[keysA[i]])) {
      return false;
    }
  }

  return true;
}

var ReactStrictModeWarnings = {
  recordUnsafeLifecycleWarnings: function (fiber, instance) {},
  flushPendingUnsafeLifecycleWarnings: function () {},
  recordLegacyContextWarning: function (fiber, instance) {},
  flushLegacyContextWarning: function () {},
  discardPendingWarnings: function () {}
};

{
  var findStrictRoot = function (fiber) {
    var maybeStrictRoot = null;
    var node = fiber;

    while (node !== null) {
      if (node.mode & StrictMode) {
        maybeStrictRoot = node;
      }

      node = node.return;
    }

    return maybeStrictRoot;
  };

  var setToSortedString = function (set) {
    var array = [];
    set.forEach(function (value) {
      array.push(value);
    });
    return array.sort().join(', ');
  };

  var pendingComponentWillMountWarnings = [];
  var pendingUNSAFE_ComponentWillMountWarnings = [];
  var pendingComponentWillReceivePropsWarnings = [];
  var pendingUNSAFE_ComponentWillReceivePropsWarnings = [];
  var pendingComponentWillUpdateWarnings = [];
  var pendingUNSAFE_ComponentWillUpdateWarnings = []; // Tracks components we have already warned about.

  var didWarnAboutUnsafeLifecycles = new Set();

  ReactStrictModeWarnings.recordUnsafeLifecycleWarnings = function (fiber, instance) {
    // Dedup strategy: Warn once per component.
    if (didWarnAboutUnsafeLifecycles.has(fiber.type)) {
      return;
    }

    if (typeof instance.componentWillMount === 'function' && // Don't warn about react-lifecycles-compat polyfilled components.
    instance.componentWillMount.__suppressDeprecationWarning !== true) {
      pendingComponentWillMountWarnings.push(fiber);
    }

    if (fiber.mode & StrictMode && typeof instance.UNSAFE_componentWillMount === 'function') {
      pendingUNSAFE_ComponentWillMountWarnings.push(fiber);
    }

    if (typeof instance.componentWillReceiveProps === 'function' && instance.componentWillReceiveProps.__suppressDeprecationWarning !== true) {
      pendingComponentWillReceivePropsWarnings.push(fiber);
    }

    if (fiber.mode & StrictMode && typeof instance.UNSAFE_componentWillReceiveProps === 'function') {
      pendingUNSAFE_ComponentWillReceivePropsWarnings.push(fiber);
    }

    if (typeof instance.componentWillUpdate === 'function' && instance.componentWillUpdate.__suppressDeprecationWarning !== true) {
      pendingComponentWillUpdateWarnings.push(fiber);
    }

    if (fiber.mode & StrictMode && typeof instance.UNSAFE_componentWillUpdate === 'function') {
      pendingUNSAFE_ComponentWillUpdateWarnings.push(fiber);
    }
  };

  ReactStrictModeWarnings.flushPendingUnsafeLifecycleWarnings = function () {
    // We do an initial pass to gather component names
    var componentWillMountUniqueNames = new Set();

    if (pendingComponentWillMountWarnings.length > 0) {
      pendingComponentWillMountWarnings.forEach(function (fiber) {
        componentWillMountUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingComponentWillMountWarnings = [];
    }

    var UNSAFE_componentWillMountUniqueNames = new Set();

    if (pendingUNSAFE_ComponentWillMountWarnings.length > 0) {
      pendingUNSAFE_ComponentWillMountWarnings.forEach(function (fiber) {
        UNSAFE_componentWillMountUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingUNSAFE_ComponentWillMountWarnings = [];
    }

    var componentWillReceivePropsUniqueNames = new Set();

    if (pendingComponentWillReceivePropsWarnings.length > 0) {
      pendingComponentWillReceivePropsWarnings.forEach(function (fiber) {
        componentWillReceivePropsUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingComponentWillReceivePropsWarnings = [];
    }

    var UNSAFE_componentWillReceivePropsUniqueNames = new Set();

    if (pendingUNSAFE_ComponentWillReceivePropsWarnings.length > 0) {
      pendingUNSAFE_ComponentWillReceivePropsWarnings.forEach(function (fiber) {
        UNSAFE_componentWillReceivePropsUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingUNSAFE_ComponentWillReceivePropsWarnings = [];
    }

    var componentWillUpdateUniqueNames = new Set();

    if (pendingComponentWillUpdateWarnings.length > 0) {
      pendingComponentWillUpdateWarnings.forEach(function (fiber) {
        componentWillUpdateUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingComponentWillUpdateWarnings = [];
    }

    var UNSAFE_componentWillUpdateUniqueNames = new Set();

    if (pendingUNSAFE_ComponentWillUpdateWarnings.length > 0) {
      pendingUNSAFE_ComponentWillUpdateWarnings.forEach(function (fiber) {
        UNSAFE_componentWillUpdateUniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutUnsafeLifecycles.add(fiber.type);
      });
      pendingUNSAFE_ComponentWillUpdateWarnings = [];
    } // Finally, we flush all the warnings
    // UNSAFE_ ones before the deprecated ones, since they'll be 'louder'


    if (UNSAFE_componentWillMountUniqueNames.size > 0) {
      var sortedNames = setToSortedString(UNSAFE_componentWillMountUniqueNames);

      error('Using UNSAFE_componentWillMount in strict mode is not recommended and may indicate bugs in your code. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move code with side effects to componentDidMount, and set initial state in the constructor.\n' + '\nPlease update the following components: %s', sortedNames);
    }

    if (UNSAFE_componentWillReceivePropsUniqueNames.size > 0) {
      var _sortedNames = setToSortedString(UNSAFE_componentWillReceivePropsUniqueNames);

      error('Using UNSAFE_componentWillReceiveProps in strict mode is not recommended ' + 'and may indicate bugs in your code. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move data fetching code or side effects to componentDidUpdate.\n' + "* If you're updating state whenever props change, " + 'refactor your code to use memoization techniques or move it to ' + 'static getDerivedStateFromProps. Learn more at: https://fb.me/react-derived-state\n' + '\nPlease update the following components: %s', _sortedNames);
    }

    if (UNSAFE_componentWillUpdateUniqueNames.size > 0) {
      var _sortedNames2 = setToSortedString(UNSAFE_componentWillUpdateUniqueNames);

      error('Using UNSAFE_componentWillUpdate in strict mode is not recommended ' + 'and may indicate bugs in your code. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move data fetching code or side effects to componentDidUpdate.\n' + '\nPlease update the following components: %s', _sortedNames2);
    }

    if (componentWillMountUniqueNames.size > 0) {
      var _sortedNames3 = setToSortedString(componentWillMountUniqueNames);

      warn('componentWillMount has been renamed, and is not recommended for use. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move code with side effects to componentDidMount, and set initial state in the constructor.\n' + '* Rename componentWillMount to UNSAFE_componentWillMount to suppress ' + 'this warning in non-strict mode. In React 17.x, only the UNSAFE_ name will work. ' + 'To rename all deprecated lifecycles to their new names, you can run ' + '`npx react-codemod rename-unsafe-lifecycles` in your project source folder.\n' + '\nPlease update the following components: %s', _sortedNames3);
    }

    if (componentWillReceivePropsUniqueNames.size > 0) {
      var _sortedNames4 = setToSortedString(componentWillReceivePropsUniqueNames);

      warn('componentWillReceiveProps has been renamed, and is not recommended for use. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move data fetching code or side effects to componentDidUpdate.\n' + "* If you're updating state whenever props change, refactor your " + 'code to use memoization techniques or move it to ' + 'static getDerivedStateFromProps. Learn more at: https://fb.me/react-derived-state\n' + '* Rename componentWillReceiveProps to UNSAFE_componentWillReceiveProps to suppress ' + 'this warning in non-strict mode. In React 17.x, only the UNSAFE_ name will work. ' + 'To rename all deprecated lifecycles to their new names, you can run ' + '`npx react-codemod rename-unsafe-lifecycles` in your project source folder.\n' + '\nPlease update the following components: %s', _sortedNames4);
    }

    if (componentWillUpdateUniqueNames.size > 0) {
      var _sortedNames5 = setToSortedString(componentWillUpdateUniqueNames);

      warn('componentWillUpdate has been renamed, and is not recommended for use. ' + 'See https://fb.me/react-unsafe-component-lifecycles for details.\n\n' + '* Move data fetching code or side effects to componentDidUpdate.\n' + '* Rename componentWillUpdate to UNSAFE_componentWillUpdate to suppress ' + 'this warning in non-strict mode. In React 17.x, only the UNSAFE_ name will work. ' + 'To rename all deprecated lifecycles to their new names, you can run ' + '`npx react-codemod rename-unsafe-lifecycles` in your project source folder.\n' + '\nPlease update the following components: %s', _sortedNames5);
    }
  };

  var pendingLegacyContextWarning = new Map(); // Tracks components we have already warned about.

  var didWarnAboutLegacyContext = new Set();

  ReactStrictModeWarnings.recordLegacyContextWarning = function (fiber, instance) {
    var strictRoot = findStrictRoot(fiber);

    if (strictRoot === null) {
      error('Expected to find a StrictMode component in a strict mode tree. ' + 'This error is likely caused by a bug in React. Please file an issue.');

      return;
    } // Dedup strategy: Warn once per component.


    if (didWarnAboutLegacyContext.has(fiber.type)) {
      return;
    }

    var warningsForRoot = pendingLegacyContextWarning.get(strictRoot);

    if (fiber.type.contextTypes != null || fiber.type.childContextTypes != null || instance !== null && typeof instance.getChildContext === 'function') {
      if (warningsForRoot === undefined) {
        warningsForRoot = [];
        pendingLegacyContextWarning.set(strictRoot, warningsForRoot);
      }

      warningsForRoot.push(fiber);
    }
  };

  ReactStrictModeWarnings.flushLegacyContextWarning = function () {
    pendingLegacyContextWarning.forEach(function (fiberArray, strictRoot) {
      if (fiberArray.length === 0) {
        return;
      }

      var firstFiber = fiberArray[0];
      var uniqueNames = new Set();
      fiberArray.forEach(function (fiber) {
        uniqueNames.add(getComponentName(fiber.type) || 'Component');
        didWarnAboutLegacyContext.add(fiber.type);
      });
      var sortedNames = setToSortedString(uniqueNames);
      var firstComponentStack = getStackByFiberInDevAndProd(firstFiber);

      error('Legacy context API has been detected within a strict-mode tree.' + '\n\nThe old API will be supported in all 16.x releases, but applications ' + 'using it should migrate to the new version.' + '\n\nPlease update the following components: %s' + '\n\nLearn more about this warning here: https://fb.me/react-legacy-context' + '%s', sortedNames, firstComponentStack);
    });
  };

  ReactStrictModeWarnings.discardPendingWarnings = function () {
    pendingComponentWillMountWarnings = [];
    pendingUNSAFE_ComponentWillMountWarnings = [];
    pendingComponentWillReceivePropsWarnings = [];
    pendingUNSAFE_ComponentWillReceivePropsWarnings = [];
    pendingComponentWillUpdateWarnings = [];
    pendingUNSAFE_ComponentWillUpdateWarnings = [];
    pendingLegacyContextWarning = new Map();
  };
}

var resolveFamily = null; // $FlowFixMe Flow gets confused by a WeakSet feature check below.

var failedBoundaries = null;
var setRefreshHandler = function (handler) {
  {
    resolveFamily = handler;
  }
};
function resolveFunctionForHotReloading(type) {
  {
    if (resolveFamily === null) {
      // Hot reloading is disabled.
      return type;
    }

    var family = resolveFamily(type);

    if (family === undefined) {
      return type;
    } // Use the latest known implementation.


    return family.current;
  }
}
function resolveClassForHotReloading(type) {
  // No implementation differences.
  return resolveFunctionForHotReloading(type);
}
function resolveForwardRefForHotReloading(type) {
  {
    if (resolveFamily === null) {
      // Hot reloading is disabled.
      return type;
    }

    var family = resolveFamily(type);

    if (family === undefined) {
      // Check if we're dealing with a real forwardRef. Don't want to crash early.
      if (type !== null && type !== undefined && typeof type.render === 'function') {
        // ForwardRef is special because its resolved .type is an object,
        // but it's possible that we only have its inner render function in the map.
        // If that inner render function is different, we'll build a new forwardRef type.
        var currentRender = resolveFunctionForHotReloading(type.render);

        if (type.render !== currentRender) {
          var syntheticType = {
            $$typeof: REACT_FORWARD_REF_TYPE,
            render: currentRender
          };

          if (type.displayName !== undefined) {
            syntheticType.displayName = type.displayName;
          }

          return syntheticType;
        }
      }

      return type;
    } // Use the latest known implementation.


    return family.current;
  }
}
function isCompatibleFamilyForHotReloading(fiber, element) {
  {
    if (resolveFamily === null) {
      // Hot reloading is disabled.
      return false;
    }

    var prevType = fiber.elementType;
    var nextType = element.type; // If we got here, we know types aren't === equal.

    var needsCompareFamilies = false;
    var $$typeofNextType = typeof nextType === 'object' && nextType !== null ? nextType.$$typeof : null;

    switch (fiber.tag) {
      case ClassComponent:
        {
          if (typeof nextType === 'function') {
            needsCompareFamilies = true;
          }

          break;
        }

      case FunctionComponent:
        {
          if (typeof nextType === 'function') {
            needsCompareFamilies = true;
          } else if ($$typeofNextType === REACT_LAZY_TYPE) {
            // We don't know the inner type yet.
            // We're going to assume that the lazy inner type is stable,
            // and so it is sufficient to avoid reconciling it away.
            // We're not going to unwrap or actually use the new lazy type.
            needsCompareFamilies = true;
          }

          break;
        }

      case ForwardRef:
        {
          if ($$typeofNextType === REACT_FORWARD_REF_TYPE) {
            needsCompareFamilies = true;
          } else if ($$typeofNextType === REACT_LAZY_TYPE) {
            needsCompareFamilies = true;
          }

          break;
        }

      case MemoComponent:
      case SimpleMemoComponent:
        {
          if ($$typeofNextType === REACT_MEMO_TYPE) {
            // TODO: if it was but can no longer be simple,
            // we shouldn't set this.
            needsCompareFamilies = true;
          } else if ($$typeofNextType === REACT_LAZY_TYPE) {
            needsCompareFamilies = true;
          }

          break;
        }

      default:
        return false;
    } // Check if both types have a family and it's the same one.


    if (needsCompareFamilies) {
      // Note: memo() and forwardRef() we'll compare outer rather than inner type.
      // This means both of them need to be registered to preserve state.
      // If we unwrapped and compared the inner types for wrappers instead,
      // then we would risk falsely saying two separate memo(Foo)
      // calls are equivalent because they wrap the same Foo function.
      var prevFamily = resolveFamily(prevType);

      if (prevFamily !== undefined && prevFamily === resolveFamily(nextType)) {
        return true;
      }
    }

    return false;
  }
}
function markFailedErrorBoundaryForHotReloading(fiber) {
  {
    if (resolveFamily === null) {
      // Hot reloading is disabled.
      return;
    }

    if (typeof WeakSet !== 'function') {
      return;
    }

    if (failedBoundaries === null) {
      failedBoundaries = new WeakSet();
    }

    failedBoundaries.add(fiber);
  }
}
var scheduleRefresh = function (root, update) {
  {
    if (resolveFamily === null) {
      // Hot reloading is disabled.
      return;
    }

    var staleFamilies = update.staleFamilies,
        updatedFamilies = update.updatedFamilies;
    flushPassiveEffects();
    flushSync(function () {
      scheduleFibersWithFamiliesRecursively(root.current, updatedFamilies, staleFamilies);
    });
  }
};
var scheduleRoot = function (root, element) {
  {
    if (root.context !== emptyContextObject) {
      // Super edge case: root has a legacy _renderSubtree context
      // but we don't know the parentComponent so we can't pass it.
      // Just ignore. We'll delete this with _renderSubtree code path later.
      return;
    }

    flushPassiveEffects();
    syncUpdates(function () {
      updateContainer(element, root, null, null);
    });
  }
};

function scheduleFibersWithFamiliesRecursively(fiber, updatedFamilies, staleFamilies) {
  {
    var alternate = fiber.alternate,
        child = fiber.child,
        sibling = fiber.sibling,
        tag = fiber.tag,
        type = fiber.type;
    var candidateType = null;

    switch (tag) {
      case FunctionComponent:
      case SimpleMemoComponent:
      case ClassComponent:
        candidateType = type;
        break;

      case ForwardRef:
        candidateType = type.render;
        break;
    }

    if (resolveFamily === null) {
      throw new Error('Expected resolveFamily to be set during hot reload.');
    }

    var needsRender = false;
    var needsRemount = false;

    if (candidateType !== null) {
      var family = resolveFamily(candidateType);

      if (family !== undefined) {
        if (staleFamilies.has(family)) {
          needsRemount = true;
        } else if (updatedFamilies.has(family)) {
          if (tag === ClassComponent) {
            needsRemount = true;
          } else {
            needsRender = true;
          }
        }
      }
    }

    if (failedBoundaries !== null) {
      if (failedBoundaries.has(fiber) || alternate !== null && failedBoundaries.has(alternate)) {
        needsRemount = true;
      }
    }

    if (needsRemount) {
      fiber._debugNeedsRemount = true;
    }

    if (needsRemount || needsRender) {
      scheduleWork(fiber, Sync);
    }

    if (child !== null && !needsRemount) {
      scheduleFibersWithFamiliesRecursively(child, updatedFamilies, staleFamilies);
    }

    if (sibling !== null) {
      scheduleFibersWithFamiliesRecursively(sibling, updatedFamilies, staleFamilies);
    }
  }
}

var findHostInstancesForRefresh = function (root, families) {
  {
    var hostInstances = new Set();
    var types = new Set(families.map(function (family) {
      return family.current;
    }));
    findHostInstancesForMatchingFibersRecursively(root.current, types, hostInstances);
    return hostInstances;
  }
};

function findHostInstancesForMatchingFibersRecursively(fiber, types, hostInstances) {
  {
    var child = fiber.child,
        sibling = fiber.sibling,
        tag = fiber.tag,
        type = fiber.type;
    var candidateType = null;

    switch (tag) {
      case FunctionComponent:
      case SimpleMemoComponent:
      case ClassComponent:
        candidateType = type;
        break;

      case ForwardRef:
        candidateType = type.render;
        break;
    }

    var didMatch = false;

    if (candidateType !== null) {
      if (types.has(candidateType)) {
        didMatch = true;
      }
    }

    if (didMatch) {
      // We have a match. This only drills down to the closest host components.
      // There's no need to search deeper because for the purpose of giving
      // visual feedback, "flashing" outermost parent rectangles is sufficient.
      findHostInstancesForFiberShallowly(fiber, hostInstances);
    } else {
      // If there's no match, maybe there will be one further down in the child tree.
      if (child !== null) {
        findHostInstancesForMatchingFibersRecursively(child, types, hostInstances);
      }
    }

    if (sibling !== null) {
      findHostInstancesForMatchingFibersRecursively(sibling, types, hostInstances);
    }
  }
}

function findHostInstancesForFiberShallowly(fiber, hostInstances) {
  {
    var foundHostInstances = findChildHostInstancesForFiberShallowly(fiber, hostInstances);

    if (foundHostInstances) {
      return;
    } // If we didn't find any host children, fallback to closest host parent.


    var node = fiber;

    while (true) {
      switch (node.tag) {
        case HostComponent:
          hostInstances.add(node.stateNode);
          return;

        case HostPortal:
          hostInstances.add(node.stateNode.containerInfo);
          return;

        case HostRoot:
          hostInstances.add(node.stateNode.containerInfo);
          return;
      }

      if (node.return === null) {
        throw new Error('Expected to reach root first.');
      }

      node = node.return;
    }
  }
}

function findChildHostInstancesForFiberShallowly(fiber, hostInstances) {
  {
    var node = fiber;
    var foundHostInstances = false;

    while (true) {
      if (node.tag === HostComponent) {
        // We got a match.
        foundHostInstances = true;
        hostInstances.add(node.stateNode); // There may still be more, so keep searching.
      } else if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      }

      if (node === fiber) {
        return foundHostInstances;
      }

      while (node.sibling === null) {
        if (node.return === null || node.return === fiber) {
          return foundHostInstances;
        }

        node = node.return;
      }

      node.sibling.return = node.return;
      node = node.sibling;
    }
  }

  return false;
}

function resolveDefaultProps(Component, baseProps) {
  if (Component && Component.defaultProps) {
    // Resolve default props. Taken from ReactElement
    var props = _assign({}, baseProps);

    var defaultProps = Component.defaultProps;

    for (var propName in defaultProps) {
      if (props[propName] === undefined) {
        props[propName] = defaultProps[propName];
      }
    }

    return props;
  }

  return baseProps;
}
function readLazyComponentType(lazyComponent) {
  initializeLazyComponentType(lazyComponent);

  if (lazyComponent._status !== Resolved) {
    throw lazyComponent._result;
  }

  return lazyComponent._result;
}

var valueCursor = createCursor(null);
var rendererSigil;

{
  // Use this to detect multiple renderers using the same context
  rendererSigil = {};
}

var currentlyRenderingFiber = null;
var lastContextDependency = null;
var lastContextWithAllBitsObserved = null;
var isDisallowedContextReadInDEV = false;
function resetContextDependencies() {
  // This is called right before React yields execution, to ensure `readContext`
  // cannot be called outside the render phase.
  currentlyRenderingFiber = null;
  lastContextDependency = null;
  lastContextWithAllBitsObserved = null;

  {
    isDisallowedContextReadInDEV = false;
  }
}
function enterDisallowedContextReadInDEV() {
  {
    isDisallowedContextReadInDEV = true;
  }
}
function exitDisallowedContextReadInDEV() {
  {
    isDisallowedContextReadInDEV = false;
  }
}
function pushProvider(providerFiber, nextValue) {
  var context = providerFiber.type._context;

  if (isPrimaryRenderer) {
    push(valueCursor, context._currentValue, providerFiber);
    context._currentValue = nextValue;

    {
      if (context._currentRenderer !== undefined && context._currentRenderer !== null && context._currentRenderer !== rendererSigil) {
        error('Detected multiple renderers concurrently rendering the ' + 'same context provider. This is currently unsupported.');
      }

      context._currentRenderer = rendererSigil;
    }
  } else {
    push(valueCursor, context._currentValue2, providerFiber);
    context._currentValue2 = nextValue;

    {
      if (context._currentRenderer2 !== undefined && context._currentRenderer2 !== null && context._currentRenderer2 !== rendererSigil) {
        error('Detected multiple renderers concurrently rendering the ' + 'same context provider. This is currently unsupported.');
      }

      context._currentRenderer2 = rendererSigil;
    }
  }
}
function popProvider(providerFiber) {
  var currentValue = valueCursor.current;
  pop(valueCursor, providerFiber);
  var context = providerFiber.type._context;

  if (isPrimaryRenderer) {
    context._currentValue = currentValue;
  } else {
    context._currentValue2 = currentValue;
  }
}
function calculateChangedBits(context, newValue, oldValue) {
  if (objectIs(oldValue, newValue)) {
    // No change
    return 0;
  } else {
    var changedBits = typeof context._calculateChangedBits === 'function' ? context._calculateChangedBits(oldValue, newValue) : MAX_SIGNED_31_BIT_INT;

    {
      if ((changedBits & MAX_SIGNED_31_BIT_INT) !== changedBits) {
        error('calculateChangedBits: Expected the return value to be a ' + '31-bit integer. Instead received: %s', changedBits);
      }
    }

    return changedBits | 0;
  }
}
function scheduleWorkOnParentPath(parent, renderExpirationTime) {
  // Update the child expiration time of all the ancestors, including
  // the alternates.
  var node = parent;

  while (node !== null) {
    var alternate = node.alternate;

    if (node.childExpirationTime < renderExpirationTime) {
      node.childExpirationTime = renderExpirationTime;

      if (alternate !== null && alternate.childExpirationTime < renderExpirationTime) {
        alternate.childExpirationTime = renderExpirationTime;
      }
    } else if (alternate !== null && alternate.childExpirationTime < renderExpirationTime) {
      alternate.childExpirationTime = renderExpirationTime;
    } else {
      // Neither alternate was updated, which means the rest of the
      // ancestor path already has sufficient priority.
      break;
    }

    node = node.return;
  }
}
function propagateContextChange(workInProgress, context, changedBits, renderExpirationTime) {
  var fiber = workInProgress.child;

  if (fiber !== null) {
    // Set the return pointer of the child to the work-in-progress fiber.
    fiber.return = workInProgress;
  }

  while (fiber !== null) {
    var nextFiber = void 0; // Visit this fiber.

    var list = fiber.dependencies;

    if (list !== null) {
      nextFiber = fiber.child;
      var dependency = list.firstContext;

      while (dependency !== null) {
        // Check if the context matches.
        if (dependency.context === context && (dependency.observedBits & changedBits) !== 0) {
          // Match! Schedule an update on this fiber.
          if (fiber.tag === ClassComponent) {
            // Schedule a force update on the work-in-progress.
            var update = createUpdate(renderExpirationTime, null);
            update.tag = ForceUpdate; // TODO: Because we don't have a work-in-progress, this will add the
            // update to the current fiber, too, which means it will persist even if
            // this render is thrown away. Since it's a race condition, not sure it's
            // worth fixing.

            enqueueUpdate(fiber, update);
          }

          if (fiber.expirationTime < renderExpirationTime) {
            fiber.expirationTime = renderExpirationTime;
          }

          var alternate = fiber.alternate;

          if (alternate !== null && alternate.expirationTime < renderExpirationTime) {
            alternate.expirationTime = renderExpirationTime;
          }

          scheduleWorkOnParentPath(fiber.return, renderExpirationTime); // Mark the expiration time on the list, too.

          if (list.expirationTime < renderExpirationTime) {
            list.expirationTime = renderExpirationTime;
          } // Since we already found a match, we can stop traversing the
          // dependency list.


          break;
        }

        dependency = dependency.next;
      }
    } else if (fiber.tag === ContextProvider) {
      // Don't scan deeper if this is a matching provider
      nextFiber = fiber.type === workInProgress.type ? null : fiber.child;
    } else {
      // Traverse down.
      nextFiber = fiber.child;
    }

    if (nextFiber !== null) {
      // Set the return pointer of the child to the work-in-progress fiber.
      nextFiber.return = fiber;
    } else {
      // No child. Traverse to next sibling.
      nextFiber = fiber;

      while (nextFiber !== null) {
        if (nextFiber === workInProgress) {
          // We're back to the root of this subtree. Exit.
          nextFiber = null;
          break;
        }

        var sibling = nextFiber.sibling;

        if (sibling !== null) {
          // Set the return pointer of the sibling to the work-in-progress fiber.
          sibling.return = nextFiber.return;
          nextFiber = sibling;
          break;
        } // No more siblings. Traverse up.


        nextFiber = nextFiber.return;
      }
    }

    fiber = nextFiber;
  }
}
function prepareToReadContext(workInProgress, renderExpirationTime) {
  currentlyRenderingFiber = workInProgress;
  lastContextDependency = null;
  lastContextWithAllBitsObserved = null;
  var dependencies = workInProgress.dependencies;

  if (dependencies !== null) {
    var firstContext = dependencies.firstContext;

    if (firstContext !== null) {
      if (dependencies.expirationTime >= renderExpirationTime) {
        // Context list has a pending update. Mark that this fiber performed work.
        markWorkInProgressReceivedUpdate();
      } // Reset the work-in-progress list


      dependencies.firstContext = null;
    }
  }
}
function readContext(context, observedBits) {
  {
    // This warning would fire if you read context inside a Hook like useMemo.
    // Unlike the class check below, it's not enforced in production for perf.
    if (isDisallowedContextReadInDEV) {
      error('Context can only be read while React is rendering. ' + 'In classes, you can read it in the render method or getDerivedStateFromProps. ' + 'In function components, you can read it directly in the function body, but not ' + 'inside Hooks like useReducer() or useMemo().');
    }
  }

  if (lastContextWithAllBitsObserved === context) ; else if (observedBits === false || observedBits === 0) ; else {
    var resolvedObservedBits; // Avoid deopting on observable arguments or heterogeneous types.

    if (typeof observedBits !== 'number' || observedBits === MAX_SIGNED_31_BIT_INT) {
      // Observe all updates.
      lastContextWithAllBitsObserved = context;
      resolvedObservedBits = MAX_SIGNED_31_BIT_INT;
    } else {
      resolvedObservedBits = observedBits;
    }

    var contextItem = {
      context: context,
      observedBits: resolvedObservedBits,
      next: null
    };

    if (lastContextDependency === null) {
      if (!(currentlyRenderingFiber !== null)) {
        {
          throw Error( "Context can only be read while React is rendering. In classes, you can read it in the render method or getDerivedStateFromProps. In function components, you can read it directly in the function body, but not inside Hooks like useReducer() or useMemo()." );
        }
      } // This is the first dependency for this component. Create a new list.


      lastContextDependency = contextItem;
      currentlyRenderingFiber.dependencies = {
        expirationTime: NoWork,
        firstContext: contextItem,
        responders: null
      };
    } else {
      // Append a new context item.
      lastContextDependency = lastContextDependency.next = contextItem;
    }
  }

  return isPrimaryRenderer ? context._currentValue : context._currentValue2;
}

var UpdateState = 0;
var ReplaceState = 1;
var ForceUpdate = 2;
var CaptureUpdate = 3; // Global state that is reset at the beginning of calling `processUpdateQueue`.
// It should only be read right after calling `processUpdateQueue`, via
// `checkHasForceUpdateAfterProcessing`.

var hasForceUpdate = false;
var didWarnUpdateInsideUpdate;
var currentlyProcessingQueue;

{
  didWarnUpdateInsideUpdate = false;
  currentlyProcessingQueue = null;
}

function initializeUpdateQueue(fiber) {
  var queue = {
    baseState: fiber.memoizedState,
    baseQueue: null,
    shared: {
      pending: null
    },
    effects: null
  };
  fiber.updateQueue = queue;
}
function cloneUpdateQueue(current, workInProgress) {
  // Clone the update queue from current. Unless it's already a clone.
  var queue = workInProgress.updateQueue;
  var currentQueue = current.updateQueue;

  if (queue === currentQueue) {
    var clone = {
      baseState: currentQueue.baseState,
      baseQueue: currentQueue.baseQueue,
      shared: currentQueue.shared,
      effects: currentQueue.effects
    };
    workInProgress.updateQueue = clone;
  }
}
function createUpdate(expirationTime, suspenseConfig) {
  var update = {
    expirationTime: expirationTime,
    suspenseConfig: suspenseConfig,
    tag: UpdateState,
    payload: null,
    callback: null,
    next: null
  };
  update.next = update;

  {
    update.priority = getCurrentPriorityLevel();
  }

  return update;
}
function enqueueUpdate(fiber, update) {
  var updateQueue = fiber.updateQueue;

  if (updateQueue === null) {
    // Only occurs if the fiber has been unmounted.
    return;
  }

  var sharedQueue = updateQueue.shared;
  var pending = sharedQueue.pending;

  if (pending === null) {
    // This is the first update. Create a circular list.
    update.next = update;
  } else {
    update.next = pending.next;
    pending.next = update;
  }

  sharedQueue.pending = update;

  {
    if (currentlyProcessingQueue === sharedQueue && !didWarnUpdateInsideUpdate) {
      error('An update (setState, replaceState, or forceUpdate) was scheduled ' + 'from inside an update function. Update functions should be pure, ' + 'with zero side-effects. Consider using componentDidUpdate or a ' + 'callback.');

      didWarnUpdateInsideUpdate = true;
    }
  }
}
function enqueueCapturedUpdate(workInProgress, update) {
  var current = workInProgress.alternate;

  if (current !== null) {
    // Ensure the work-in-progress queue is a clone
    cloneUpdateQueue(current, workInProgress);
  } // Captured updates go only on the work-in-progress queue.


  var queue = workInProgress.updateQueue; // Append the update to the end of the list.

  var last = queue.baseQueue;

  if (last === null) {
    queue.baseQueue = update.next = update;
    update.next = update;
  } else {
    update.next = last.next;
    last.next = update;
  }
}

function getStateFromUpdate(workInProgress, queue, update, prevState, nextProps, instance) {
  switch (update.tag) {
    case ReplaceState:
      {
        var payload = update.payload;

        if (typeof payload === 'function') {
          // Updater function
          {
            enterDisallowedContextReadInDEV();

            if ( workInProgress.mode & StrictMode) {
              payload.call(instance, prevState, nextProps);
            }
          }

          var nextState = payload.call(instance, prevState, nextProps);

          {
            exitDisallowedContextReadInDEV();
          }

          return nextState;
        } // State object


        return payload;
      }

    case CaptureUpdate:
      {
        workInProgress.effectTag = workInProgress.effectTag & ~ShouldCapture | DidCapture;
      }
    // Intentional fallthrough

    case UpdateState:
      {
        var _payload = update.payload;
        var partialState;

        if (typeof _payload === 'function') {
          // Updater function
          {
            enterDisallowedContextReadInDEV();

            if ( workInProgress.mode & StrictMode) {
              _payload.call(instance, prevState, nextProps);
            }
          }

          partialState = _payload.call(instance, prevState, nextProps);

          {
            exitDisallowedContextReadInDEV();
          }
        } else {
          // Partial state object
          partialState = _payload;
        }

        if (partialState === null || partialState === undefined) {
          // Null and undefined are treated as no-ops.
          return prevState;
        } // Merge the partial state and the previous state.


        return _assign({}, prevState, partialState);
      }

    case ForceUpdate:
      {
        hasForceUpdate = true;
        return prevState;
      }
  }

  return prevState;
}

function processUpdateQueue(workInProgress, props, instance, renderExpirationTime) {
  // This is always non-null on a ClassComponent or HostRoot
  var queue = workInProgress.updateQueue;
  hasForceUpdate = false;

  {
    currentlyProcessingQueue = queue.shared;
  } // The last rebase update that is NOT part of the base state.


  var baseQueue = queue.baseQueue; // The last pending update that hasn't been processed yet.

  var pendingQueue = queue.shared.pending;

  if (pendingQueue !== null) {
    // We have new updates that haven't been processed yet.
    // We'll add them to the base queue.
    if (baseQueue !== null) {
      // Merge the pending queue and the base queue.
      var baseFirst = baseQueue.next;
      var pendingFirst = pendingQueue.next;
      baseQueue.next = pendingFirst;
      pendingQueue.next = baseFirst;
    }

    baseQueue = pendingQueue;
    queue.shared.pending = null; // TODO: Pass `current` as argument

    var current = workInProgress.alternate;

    if (current !== null) {
      var currentQueue = current.updateQueue;

      if (currentQueue !== null) {
        currentQueue.baseQueue = pendingQueue;
      }
    }
  } // These values may change as we process the queue.


  if (baseQueue !== null) {
    var first = baseQueue.next; // Iterate through the list of updates to compute the result.

    var newState = queue.baseState;
    var newExpirationTime = NoWork;
    var newBaseState = null;
    var newBaseQueueFirst = null;
    var newBaseQueueLast = null;

    if (first !== null) {
      var update = first;

      do {
        var updateExpirationTime = update.expirationTime;

        if (updateExpirationTime < renderExpirationTime) {
          // Priority is insufficient. Skip this update. If this is the first
          // skipped update, the previous update/state is the new base
          // update/state.
          var clone = {
            expirationTime: update.expirationTime,
            suspenseConfig: update.suspenseConfig,
            tag: update.tag,
            payload: update.payload,
            callback: update.callback,
            next: null
          };

          if (newBaseQueueLast === null) {
            newBaseQueueFirst = newBaseQueueLast = clone;
            newBaseState = newState;
          } else {
            newBaseQueueLast = newBaseQueueLast.next = clone;
          } // Update the remaining priority in the queue.


          if (updateExpirationTime > newExpirationTime) {
            newExpirationTime = updateExpirationTime;
          }
        } else {
          // This update does have sufficient priority.
          if (newBaseQueueLast !== null) {
            var _clone = {
              expirationTime: Sync,
              // This update is going to be committed so we never want uncommit it.
              suspenseConfig: update.suspenseConfig,
              tag: update.tag,
              payload: update.payload,
              callback: update.callback,
              next: null
            };
            newBaseQueueLast = newBaseQueueLast.next = _clone;
          } // Mark the event time of this update as relevant to this render pass.
          // TODO: This should ideally use the true event time of this update rather than
          // its priority which is a derived and not reverseable value.
          // TODO: We should skip this update if it was already committed but currently
          // we have no way of detecting the difference between a committed and suspended
          // update here.


          markRenderEventTimeAndConfig(updateExpirationTime, update.suspenseConfig); // Process this update.

          newState = getStateFromUpdate(workInProgress, queue, update, newState, props, instance);
          var callback = update.callback;

          if (callback !== null) {
            workInProgress.effectTag |= Callback;
            var effects = queue.effects;

            if (effects === null) {
              queue.effects = [update];
            } else {
              effects.push(update);
            }
          }
        }

        update = update.next;

        if (update === null || update === first) {
          pendingQueue = queue.shared.pending;

          if (pendingQueue === null) {
            break;
          } else {
            // An update was scheduled from inside a reducer. Add the new
            // pending updates to the end of the list and keep processing.
            update = baseQueue.next = pendingQueue.next;
            pendingQueue.next = first;
            queue.baseQueue = baseQueue = pendingQueue;
            queue.shared.pending = null;
          }
        }
      } while (true);
    }

    if (newBaseQueueLast === null) {
      newBaseState = newState;
    } else {
      newBaseQueueLast.next = newBaseQueueFirst;
    }

    queue.baseState = newBaseState;
    queue.baseQueue = newBaseQueueLast; // Set the remaining expiration time to be whatever is remaining in the queue.
    // This should be fine because the only two other things that contribute to
    // expiration time are props and context. We're already in the middle of the
    // begin phase by the time we start processing the queue, so we've already
    // dealt with the props. Context in components that specify
    // shouldComponentUpdate is tricky; but we'll have to account for
    // that regardless.

    markUnprocessedUpdateTime(newExpirationTime);
    workInProgress.expirationTime = newExpirationTime;
    workInProgress.memoizedState = newState;
  }

  {
    currentlyProcessingQueue = null;
  }
}

function callCallback(callback, context) {
  if (!(typeof callback === 'function')) {
    {
      throw Error( "Invalid argument passed as callback. Expected a function. Instead received: " + callback );
    }
  }

  callback.call(context);
}

function resetHasForceUpdateBeforeProcessing() {
  hasForceUpdate = false;
}
function checkHasForceUpdateAfterProcessing() {
  return hasForceUpdate;
}
function commitUpdateQueue(finishedWork, finishedQueue, instance) {
  // Commit the effects
  var effects = finishedQueue.effects;
  finishedQueue.effects = null;

  if (effects !== null) {
    for (var i = 0; i < effects.length; i++) {
      var effect = effects[i];
      var callback = effect.callback;

      if (callback !== null) {
        effect.callback = null;
        callCallback(callback, instance);
      }
    }
  }
}

var ReactCurrentBatchConfig = ReactSharedInternals.ReactCurrentBatchConfig;
function requestCurrentSuspenseConfig() {
  return ReactCurrentBatchConfig.suspense;
}

var fakeInternalInstance = {};
var isArray = Array.isArray; // React.Component uses a shared frozen object by default.
// We'll use it to determine whether we need to initialize legacy refs.

var emptyRefsObject = new React.Component().refs;
var didWarnAboutStateAssignmentForComponent;
var didWarnAboutUninitializedState;
var didWarnAboutGetSnapshotBeforeUpdateWithoutDidUpdate;
var didWarnAboutLegacyLifecyclesAndDerivedState;
var didWarnAboutUndefinedDerivedState;
var warnOnUndefinedDerivedState;
var warnOnInvalidCallback;
var didWarnAboutDirectlyAssigningPropsToState;
var didWarnAboutContextTypeAndContextTypes;
var didWarnAboutInvalidateContextType;

{
  didWarnAboutStateAssignmentForComponent = new Set();
  didWarnAboutUninitializedState = new Set();
  didWarnAboutGetSnapshotBeforeUpdateWithoutDidUpdate = new Set();
  didWarnAboutLegacyLifecyclesAndDerivedState = new Set();
  didWarnAboutDirectlyAssigningPropsToState = new Set();
  didWarnAboutUndefinedDerivedState = new Set();
  didWarnAboutContextTypeAndContextTypes = new Set();
  didWarnAboutInvalidateContextType = new Set();
  var didWarnOnInvalidCallback = new Set();

  warnOnInvalidCallback = function (callback, callerName) {
    if (callback === null || typeof callback === 'function') {
      return;
    }

    var key = callerName + "_" + callback;

    if (!didWarnOnInvalidCallback.has(key)) {
      didWarnOnInvalidCallback.add(key);

      error('%s(...): Expected the last optional `callback` argument to be a ' + 'function. Instead received: %s.', callerName, callback);
    }
  };

  warnOnUndefinedDerivedState = function (type, partialState) {
    if (partialState === undefined) {
      var componentName = getComponentName(type) || 'Component';

      if (!didWarnAboutUndefinedDerivedState.has(componentName)) {
        didWarnAboutUndefinedDerivedState.add(componentName);

        error('%s.getDerivedStateFromProps(): A valid state object (or null) must be returned. ' + 'You have returned undefined.', componentName);
      }
    }
  }; // This is so gross but it's at least non-critical and can be removed if
  // it causes problems. This is meant to give a nicer error message for
  // ReactDOM15.unstable_renderSubtreeIntoContainer(reactDOM16Component,
  // ...)) which otherwise throws a "_processChildContext is not a function"
  // exception.


  Object.defineProperty(fakeInternalInstance, '_processChildContext', {
    enumerable: false,
    value: function () {
      {
        {
          throw Error( "_processChildContext is not available in React 16+. This likely means you have multiple copies of React and are attempting to nest a React 15 tree inside a React 16 tree using unstable_renderSubtreeIntoContainer, which isn't supported. Try to make sure you have only one copy of React (and ideally, switch to ReactDOM.createPortal)." );
        }
      }
    }
  });
  Object.freeze(fakeInternalInstance);
}

function applyDerivedStateFromProps(workInProgress, ctor, getDerivedStateFromProps, nextProps) {
  var prevState = workInProgress.memoizedState;

  {
    if ( workInProgress.mode & StrictMode) {
      // Invoke the function an extra time to help detect side-effects.
      getDerivedStateFromProps(nextProps, prevState);
    }
  }

  var partialState = getDerivedStateFromProps(nextProps, prevState);

  {
    warnOnUndefinedDerivedState(ctor, partialState);
  } // Merge the partial state and the previous state.


  var memoizedState = partialState === null || partialState === undefined ? prevState : _assign({}, prevState, partialState);
  workInProgress.memoizedState = memoizedState; // Once the update queue is empty, persist the derived state onto the
  // base state.

  if (workInProgress.expirationTime === NoWork) {
    // Queue is always non-null for classes
    var updateQueue = workInProgress.updateQueue;
    updateQueue.baseState = memoizedState;
  }
}
var classComponentUpdater = {
  isMounted: isMounted,
  enqueueSetState: function (inst, payload, callback) {
    var fiber = get(inst);
    var currentTime = requestCurrentTimeForUpdate();
    var suspenseConfig = requestCurrentSuspenseConfig();
    var expirationTime = computeExpirationForFiber(currentTime, fiber, suspenseConfig);
    var update = createUpdate(expirationTime, suspenseConfig);
    update.payload = payload;

    if (callback !== undefined && callback !== null) {
      {
        warnOnInvalidCallback(callback, 'setState');
      }

      update.callback = callback;
    }

    enqueueUpdate(fiber, update);
    scheduleWork(fiber, expirationTime);
  },
  enqueueReplaceState: function (inst, payload, callback) {
    var fiber = get(inst);
    var currentTime = requestCurrentTimeForUpdate();
    var suspenseConfig = requestCurrentSuspenseConfig();
    var expirationTime = computeExpirationForFiber(currentTime, fiber, suspenseConfig);
    var update = createUpdate(expirationTime, suspenseConfig);
    update.tag = ReplaceState;
    update.payload = payload;

    if (callback !== undefined && callback !== null) {
      {
        warnOnInvalidCallback(callback, 'replaceState');
      }

      update.callback = callback;
    }

    enqueueUpdate(fiber, update);
    scheduleWork(fiber, expirationTime);
  },
  enqueueForceUpdate: function (inst, callback) {
    var fiber = get(inst);
    var currentTime = requestCurrentTimeForUpdate();
    var suspenseConfig = requestCurrentSuspenseConfig();
    var expirationTime = computeExpirationForFiber(currentTime, fiber, suspenseConfig);
    var update = createUpdate(expirationTime, suspenseConfig);
    update.tag = ForceUpdate;

    if (callback !== undefined && callback !== null) {
      {
        warnOnInvalidCallback(callback, 'forceUpdate');
      }

      update.callback = callback;
    }

    enqueueUpdate(fiber, update);
    scheduleWork(fiber, expirationTime);
  }
};

function checkShouldComponentUpdate(workInProgress, ctor, oldProps, newProps, oldState, newState, nextContext) {
  var instance = workInProgress.stateNode;

  if (typeof instance.shouldComponentUpdate === 'function') {
    {
      if ( workInProgress.mode & StrictMode) {
        // Invoke the function an extra time to help detect side-effects.
        instance.shouldComponentUpdate(newProps, newState, nextContext);
      }
    }

    startPhaseTimer(workInProgress, 'shouldComponentUpdate');
    var shouldUpdate = instance.shouldComponentUpdate(newProps, newState, nextContext);
    stopPhaseTimer();

    {
      if (shouldUpdate === undefined) {
        error('%s.shouldComponentUpdate(): Returned undefined instead of a ' + 'boolean value. Make sure to return true or false.', getComponentName(ctor) || 'Component');
      }
    }

    return shouldUpdate;
  }

  if (ctor.prototype && ctor.prototype.isPureReactComponent) {
    return !shallowEqual(oldProps, newProps) || !shallowEqual(oldState, newState);
  }

  return true;
}

function checkClassInstance(workInProgress, ctor, newProps) {
  var instance = workInProgress.stateNode;

  {
    var name = getComponentName(ctor) || 'Component';
    var renderPresent = instance.render;

    if (!renderPresent) {
      if (ctor.prototype && typeof ctor.prototype.render === 'function') {
        error('%s(...): No `render` method found on the returned component ' + 'instance: did you accidentally return an object from the constructor?', name);
      } else {
        error('%s(...): No `render` method found on the returned component ' + 'instance: you may have forgotten to define `render`.', name);
      }
    }

    if (instance.getInitialState && !instance.getInitialState.isReactClassApproved && !instance.state) {
      error('getInitialState was defined on %s, a plain JavaScript class. ' + 'This is only supported for classes created using React.createClass. ' + 'Did you mean to define a state property instead?', name);
    }

    if (instance.getDefaultProps && !instance.getDefaultProps.isReactClassApproved) {
      error('getDefaultProps was defined on %s, a plain JavaScript class. ' + 'This is only supported for classes created using React.createClass. ' + 'Use a static property to define defaultProps instead.', name);
    }

    if (instance.propTypes) {
      error('propTypes was defined as an instance property on %s. Use a static ' + 'property to define propTypes instead.', name);
    }

    if (instance.contextType) {
      error('contextType was defined as an instance property on %s. Use a static ' + 'property to define contextType instead.', name);
    }

    {
      if (instance.contextTypes) {
        error('contextTypes was defined as an instance property on %s. Use a static ' + 'property to define contextTypes instead.', name);
      }

      if (ctor.contextType && ctor.contextTypes && !didWarnAboutContextTypeAndContextTypes.has(ctor)) {
        didWarnAboutContextTypeAndContextTypes.add(ctor);

        error('%s declares both contextTypes and contextType static properties. ' + 'The legacy contextTypes property will be ignored.', name);
      }
    }

    if (typeof instance.componentShouldUpdate === 'function') {
      error('%s has a method called ' + 'componentShouldUpdate(). Did you mean shouldComponentUpdate()? ' + 'The name is phrased as a question because the function is ' + 'expected to return a value.', name);
    }

    if (ctor.prototype && ctor.prototype.isPureReactComponent && typeof instance.shouldComponentUpdate !== 'undefined') {
      error('%s has a method called shouldComponentUpdate(). ' + 'shouldComponentUpdate should not be used when extending React.PureComponent. ' + 'Please extend React.Component if shouldComponentUpdate is used.', getComponentName(ctor) || 'A pure component');
    }

    if (typeof instance.componentDidUnmount === 'function') {
      error('%s has a method called ' + 'componentDidUnmount(). But there is no such lifecycle method. ' + 'Did you mean componentWillUnmount()?', name);
    }

    if (typeof instance.componentDidReceiveProps === 'function') {
      error('%s has a method called ' + 'componentDidReceiveProps(). But there is no such lifecycle method. ' + 'If you meant to update the state in response to changing props, ' + 'use componentWillReceiveProps(). If you meant to fetch data or ' + 'run side-effects or mutations after React has updated the UI, use componentDidUpdate().', name);
    }

    if (typeof instance.componentWillRecieveProps === 'function') {
      error('%s has a method called ' + 'componentWillRecieveProps(). Did you mean componentWillReceiveProps()?', name);
    }

    if (typeof instance.UNSAFE_componentWillRecieveProps === 'function') {
      error('%s has a method called ' + 'UNSAFE_componentWillRecieveProps(). Did you mean UNSAFE_componentWillReceiveProps()?', name);
    }

    var hasMutatedProps = instance.props !== newProps;

    if (instance.props !== undefined && hasMutatedProps) {
      error('%s(...): When calling super() in `%s`, make sure to pass ' + "up the same props that your component's constructor was passed.", name, name);
    }

    if (instance.defaultProps) {
      error('Setting defaultProps as an instance property on %s is not supported and will be ignored.' + ' Instead, define defaultProps as a static property on %s.', name, name);
    }

    if (typeof instance.getSnapshotBeforeUpdate === 'function' && typeof instance.componentDidUpdate !== 'function' && !didWarnAboutGetSnapshotBeforeUpdateWithoutDidUpdate.has(ctor)) {
      didWarnAboutGetSnapshotBeforeUpdateWithoutDidUpdate.add(ctor);

      error('%s: getSnapshotBeforeUpdate() should be used with componentDidUpdate(). ' + 'This component defines getSnapshotBeforeUpdate() only.', getComponentName(ctor));
    }

    if (typeof instance.getDerivedStateFromProps === 'function') {
      error('%s: getDerivedStateFromProps() is defined as an instance method ' + 'and will be ignored. Instead, declare it as a static method.', name);
    }

    if (typeof instance.getDerivedStateFromError === 'function') {
      error('%s: getDerivedStateFromError() is defined as an instance method ' + 'and will be ignored. Instead, declare it as a static method.', name);
    }

    if (typeof ctor.getSnapshotBeforeUpdate === 'function') {
      error('%s: getSnapshotBeforeUpdate() is defined as a static method ' + 'and will be ignored. Instead, declare it as an instance method.', name);
    }

    var _state = instance.state;

    if (_state && (typeof _state !== 'object' || isArray(_state))) {
      error('%s.state: must be set to an object or null', name);
    }

    if (typeof instance.getChildContext === 'function' && typeof ctor.childContextTypes !== 'object') {
      error('%s.getChildContext(): childContextTypes must be defined in order to ' + 'use getChildContext().', name);
    }
  }
}

function adoptClassInstance(workInProgress, instance) {
  instance.updater = classComponentUpdater;
  workInProgress.stateNode = instance; // The instance needs access to the fiber so that it can schedule updates

  set(instance, workInProgress);

  {
    instance._reactInternalInstance = fakeInternalInstance;
  }
}

function constructClassInstance(workInProgress, ctor, props) {
  var isLegacyContextConsumer = false;
  var unmaskedContext = emptyContextObject;
  var context = emptyContextObject;
  var contextType = ctor.contextType;

  {
    if ('contextType' in ctor) {
      var isValid = // Allow null for conditional declaration
      contextType === null || contextType !== undefined && contextType.$$typeof === REACT_CONTEXT_TYPE && contextType._context === undefined; // Not a <Context.Consumer>

      if (!isValid && !didWarnAboutInvalidateContextType.has(ctor)) {
        didWarnAboutInvalidateContextType.add(ctor);
        var addendum = '';

        if (contextType === undefined) {
          addendum = ' However, it is set to undefined. ' + 'This can be caused by a typo or by mixing up named and default imports. ' + 'This can also happen due to a circular dependency, so ' + 'try moving the createContext() call to a separate file.';
        } else if (typeof contextType !== 'object') {
          addendum = ' However, it is set to a ' + typeof contextType + '.';
        } else if (contextType.$$typeof === REACT_PROVIDER_TYPE) {
          addendum = ' Did you accidentally pass the Context.Provider instead?';
        } else if (contextType._context !== undefined) {
          // <Context.Consumer>
          addendum = ' Did you accidentally pass the Context.Consumer instead?';
        } else {
          addendum = ' However, it is set to an object with keys {' + Object.keys(contextType).join(', ') + '}.';
        }

        error('%s defines an invalid contextType. ' + 'contextType should point to the Context object returned by React.createContext().%s', getComponentName(ctor) || 'Component', addendum);
      }
    }
  }

  if (typeof contextType === 'object' && contextType !== null) {
    context = readContext(contextType);
  } else {
    unmaskedContext = getUnmaskedContext(workInProgress, ctor, true);
    var contextTypes = ctor.contextTypes;
    isLegacyContextConsumer = contextTypes !== null && contextTypes !== undefined;
    context = isLegacyContextConsumer ? getMaskedContext(workInProgress, unmaskedContext) : emptyContextObject;
  } // Instantiate twice to help detect side-effects.


  {
    if ( workInProgress.mode & StrictMode) {
      new ctor(props, context); // eslint-disable-line no-new
    }
  }

  var instance = new ctor(props, context);
  var state = workInProgress.memoizedState = instance.state !== null && instance.state !== undefined ? instance.state : null;
  adoptClassInstance(workInProgress, instance);

  {
    if (typeof ctor.getDerivedStateFromProps === 'function' && state === null) {
      var componentName = getComponentName(ctor) || 'Component';

      if (!didWarnAboutUninitializedState.has(componentName)) {
        didWarnAboutUninitializedState.add(componentName);

        error('`%s` uses `getDerivedStateFromProps` but its initial state is ' + '%s. This is not recommended. Instead, define the initial state by ' + 'assigning an object to `this.state` in the constructor of `%s`. ' + 'This ensures that `getDerivedStateFromProps` arguments have a consistent shape.', componentName, instance.state === null ? 'null' : 'undefined', componentName);
      }
    } // If new component APIs are defined, "unsafe" lifecycles won't be called.
    // Warn about these lifecycles if they are present.
    // Don't warn about react-lifecycles-compat polyfilled methods though.


    if (typeof ctor.getDerivedStateFromProps === 'function' || typeof instance.getSnapshotBeforeUpdate === 'function') {
      var foundWillMountName = null;
      var foundWillReceivePropsName = null;
      var foundWillUpdateName = null;

      if (typeof instance.componentWillMount === 'function' && instance.componentWillMount.__suppressDeprecationWarning !== true) {
        foundWillMountName = 'componentWillMount';
      } else if (typeof instance.UNSAFE_componentWillMount === 'function') {
        foundWillMountName = 'UNSAFE_componentWillMount';
      }

      if (typeof instance.componentWillReceiveProps === 'function' && instance.componentWillReceiveProps.__suppressDeprecationWarning !== true) {
        foundWillReceivePropsName = 'componentWillReceiveProps';
      } else if (typeof instance.UNSAFE_componentWillReceiveProps === 'function') {
        foundWillReceivePropsName = 'UNSAFE_componentWillReceiveProps';
      }

      if (typeof instance.componentWillUpdate === 'function' && instance.componentWillUpdate.__suppressDeprecationWarning !== true) {
        foundWillUpdateName = 'componentWillUpdate';
      } else if (typeof instance.UNSAFE_componentWillUpdate === 'function') {
        foundWillUpdateName = 'UNSAFE_componentWillUpdate';
      }

      if (foundWillMountName !== null || foundWillReceivePropsName !== null || foundWillUpdateName !== null) {
        var _componentName = getComponentName(ctor) || 'Component';

        var newApiName = typeof ctor.getDerivedStateFromProps === 'function' ? 'getDerivedStateFromProps()' : 'getSnapshotBeforeUpdate()';

        if (!didWarnAboutLegacyLifecyclesAndDerivedState.has(_componentName)) {
          didWarnAboutLegacyLifecyclesAndDerivedState.add(_componentName);

          error('Unsafe legacy lifecycles will not be called for components using new component APIs.\n\n' + '%s uses %s but also contains the following legacy lifecycles:%s%s%s\n\n' + 'The above lifecycles should be removed. Learn more about this warning here:\n' + 'https://fb.me/react-unsafe-component-lifecycles', _componentName, newApiName, foundWillMountName !== null ? "\n  " + foundWillMountName : '', foundWillReceivePropsName !== null ? "\n  " + foundWillReceivePropsName : '', foundWillUpdateName !== null ? "\n  " + foundWillUpdateName : '');
        }
      }
    }
  } // Cache unmasked context so we can avoid recreating masked context unless necessary.
  // ReactFiberContext usually updates this cache but can't for newly-created instances.


  if (isLegacyContextConsumer) {
    cacheContext(workInProgress, unmaskedContext, context);
  }

  return instance;
}

function callComponentWillMount(workInProgress, instance) {
  startPhaseTimer(workInProgress, 'componentWillMount');
  var oldState = instance.state;

  if (typeof instance.componentWillMount === 'function') {
    instance.componentWillMount();
  }

  if (typeof instance.UNSAFE_componentWillMount === 'function') {
    instance.UNSAFE_componentWillMount();
  }

  stopPhaseTimer();

  if (oldState !== instance.state) {
    {
      error('%s.componentWillMount(): Assigning directly to this.state is ' + "deprecated (except inside a component's " + 'constructor). Use setState instead.', getComponentName(workInProgress.type) || 'Component');
    }

    classComponentUpdater.enqueueReplaceState(instance, instance.state, null);
  }
}

function callComponentWillReceiveProps(workInProgress, instance, newProps, nextContext) {
  var oldState = instance.state;
  startPhaseTimer(workInProgress, 'componentWillReceiveProps');

  if (typeof instance.componentWillReceiveProps === 'function') {
    instance.componentWillReceiveProps(newProps, nextContext);
  }

  if (typeof instance.UNSAFE_componentWillReceiveProps === 'function') {
    instance.UNSAFE_componentWillReceiveProps(newProps, nextContext);
  }

  stopPhaseTimer();

  if (instance.state !== oldState) {
    {
      var componentName = getComponentName(workInProgress.type) || 'Component';

      if (!didWarnAboutStateAssignmentForComponent.has(componentName)) {
        didWarnAboutStateAssignmentForComponent.add(componentName);

        error('%s.componentWillReceiveProps(): Assigning directly to ' + "this.state is deprecated (except inside a component's " + 'constructor). Use setState instead.', componentName);
      }
    }

    classComponentUpdater.enqueueReplaceState(instance, instance.state, null);
  }
} // Invokes the mount life-cycles on a previously never rendered instance.


function mountClassInstance(workInProgress, ctor, newProps, renderExpirationTime) {
  {
    checkClassInstance(workInProgress, ctor, newProps);
  }

  var instance = workInProgress.stateNode;
  instance.props = newProps;
  instance.state = workInProgress.memoizedState;
  instance.refs = emptyRefsObject;
  initializeUpdateQueue(workInProgress);
  var contextType = ctor.contextType;

  if (typeof contextType === 'object' && contextType !== null) {
    instance.context = readContext(contextType);
  } else {
    var unmaskedContext = getUnmaskedContext(workInProgress, ctor, true);
    instance.context = getMaskedContext(workInProgress, unmaskedContext);
  }

  {
    if (instance.state === newProps) {
      var componentName = getComponentName(ctor) || 'Component';

      if (!didWarnAboutDirectlyAssigningPropsToState.has(componentName)) {
        didWarnAboutDirectlyAssigningPropsToState.add(componentName);

        error('%s: It is not recommended to assign props directly to state ' + "because updates to props won't be reflected in state. " + 'In most cases, it is better to use props directly.', componentName);
      }
    }

    if (workInProgress.mode & StrictMode) {
      ReactStrictModeWarnings.recordLegacyContextWarning(workInProgress, instance);
    }

    {
      ReactStrictModeWarnings.recordUnsafeLifecycleWarnings(workInProgress, instance);
    }
  }

  processUpdateQueue(workInProgress, newProps, instance, renderExpirationTime);
  instance.state = workInProgress.memoizedState;
  var getDerivedStateFromProps = ctor.getDerivedStateFromProps;

  if (typeof getDerivedStateFromProps === 'function') {
    applyDerivedStateFromProps(workInProgress, ctor, getDerivedStateFromProps, newProps);
    instance.state = workInProgress.memoizedState;
  } // In order to support react-lifecycles-compat polyfilled components,
  // Unsafe lifecycles should not be invoked for components using the new APIs.


  if (typeof ctor.getDerivedStateFromProps !== 'function' && typeof instance.getSnapshotBeforeUpdate !== 'function' && (typeof instance.UNSAFE_componentWillMount === 'function' || typeof instance.componentWillMount === 'function')) {
    callComponentWillMount(workInProgress, instance); // If we had additional state updates during this life-cycle, let's
    // process them now.

    processUpdateQueue(workInProgress, newProps, instance, renderExpirationTime);
    instance.state = workInProgress.memoizedState;
  }

  if (typeof instance.componentDidMount === 'function') {
    workInProgress.effectTag |= Update;
  }
}

function resumeMountClassInstance(workInProgress, ctor, newProps, renderExpirationTime) {
  var instance = workInProgress.stateNode;
  var oldProps = workInProgress.memoizedProps;
  instance.props = oldProps;
  var oldContext = instance.context;
  var contextType = ctor.contextType;
  var nextContext = emptyContextObject;

  if (typeof contextType === 'object' && contextType !== null) {
    nextContext = readContext(contextType);
  } else {
    var nextLegacyUnmaskedContext = getUnmaskedContext(workInProgress, ctor, true);
    nextContext = getMaskedContext(workInProgress, nextLegacyUnmaskedContext);
  }

  var getDerivedStateFromProps = ctor.getDerivedStateFromProps;
  var hasNewLifecycles = typeof getDerivedStateFromProps === 'function' || typeof instance.getSnapshotBeforeUpdate === 'function'; // Note: During these life-cycles, instance.props/instance.state are what
  // ever the previously attempted to render - not the "current". However,
  // during componentDidUpdate we pass the "current" props.
  // In order to support react-lifecycles-compat polyfilled components,
  // Unsafe lifecycles should not be invoked for components using the new APIs.

  if (!hasNewLifecycles && (typeof instance.UNSAFE_componentWillReceiveProps === 'function' || typeof instance.componentWillReceiveProps === 'function')) {
    if (oldProps !== newProps || oldContext !== nextContext) {
      callComponentWillReceiveProps(workInProgress, instance, newProps, nextContext);
    }
  }

  resetHasForceUpdateBeforeProcessing();
  var oldState = workInProgress.memoizedState;
  var newState = instance.state = oldState;
  processUpdateQueue(workInProgress, newProps, instance, renderExpirationTime);
  newState = workInProgress.memoizedState;

  if (oldProps === newProps && oldState === newState && !hasContextChanged() && !checkHasForceUpdateAfterProcessing()) {
    // If an update was already in progress, we should schedule an Update
    // effect even though we're bailing out, so that cWU/cDU are called.
    if (typeof instance.componentDidMount === 'function') {
      workInProgress.effectTag |= Update;
    }

    return false;
  }

  if (typeof getDerivedStateFromProps === 'function') {
    applyDerivedStateFromProps(workInProgress, ctor, getDerivedStateFromProps, newProps);
    newState = workInProgress.memoizedState;
  }

  var shouldUpdate = checkHasForceUpdateAfterProcessing() || checkShouldComponentUpdate(workInProgress, ctor, oldProps, newProps, oldState, newState, nextContext);

  if (shouldUpdate) {
    // In order to support react-lifecycles-compat polyfilled components,
    // Unsafe lifecycles should not be invoked for components using the new APIs.
    if (!hasNewLifecycles && (typeof instance.UNSAFE_componentWillMount === 'function' || typeof instance.componentWillMount === 'function')) {
      startPhaseTimer(workInProgress, 'componentWillMount');

      if (typeof instance.componentWillMount === 'function') {
        instance.componentWillMount();
      }

      if (typeof instance.UNSAFE_componentWillMount === 'function') {
        instance.UNSAFE_componentWillMount();
      }

      stopPhaseTimer();
    }

    if (typeof instance.componentDidMount === 'function') {
      workInProgress.effectTag |= Update;
    }
  } else {
    // If an update was already in progress, we should schedule an Update
    // effect even though we're bailing out, so that cWU/cDU are called.
    if (typeof instance.componentDidMount === 'function') {
      workInProgress.effectTag |= Update;
    } // If shouldComponentUpdate returned false, we should still update the
    // memoized state to indicate that this work can be reused.


    workInProgress.memoizedProps = newProps;
    workInProgress.memoizedState = newState;
  } // Update the existing instance's state, props, and context pointers even
  // if shouldComponentUpdate returns false.


  instance.props = newProps;
  instance.state = newState;
  instance.context = nextContext;
  return shouldUpdate;
} // Invokes the update life-cycles and returns false if it shouldn't rerender.


function updateClassInstance(current, workInProgress, ctor, newProps, renderExpirationTime) {
  var instance = workInProgress.stateNode;
  cloneUpdateQueue(current, workInProgress);
  var oldProps = workInProgress.memoizedProps;
  instance.props = workInProgress.type === workInProgress.elementType ? oldProps : resolveDefaultProps(workInProgress.type, oldProps);
  var oldContext = instance.context;
  var contextType = ctor.contextType;
  var nextContext = emptyContextObject;

  if (typeof contextType === 'object' && contextType !== null) {
    nextContext = readContext(contextType);
  } else {
    var nextUnmaskedContext = getUnmaskedContext(workInProgress, ctor, true);
    nextContext = getMaskedContext(workInProgress, nextUnmaskedContext);
  }

  var getDerivedStateFromProps = ctor.getDerivedStateFromProps;
  var hasNewLifecycles = typeof getDerivedStateFromProps === 'function' || typeof instance.getSnapshotBeforeUpdate === 'function'; // Note: During these life-cycles, instance.props/instance.state are what
  // ever the previously attempted to render - not the "current". However,
  // during componentDidUpdate we pass the "current" props.
  // In order to support react-lifecycles-compat polyfilled components,
  // Unsafe lifecycles should not be invoked for components using the new APIs.

  if (!hasNewLifecycles && (typeof instance.UNSAFE_componentWillReceiveProps === 'function' || typeof instance.componentWillReceiveProps === 'function')) {
    if (oldProps !== newProps || oldContext !== nextContext) {
      callComponentWillReceiveProps(workInProgress, instance, newProps, nextContext);
    }
  }

  resetHasForceUpdateBeforeProcessing();
  var oldState = workInProgress.memoizedState;
  var newState = instance.state = oldState;
  processUpdateQueue(workInProgress, newProps, instance, renderExpirationTime);
  newState = workInProgress.memoizedState;

  if (oldProps === newProps && oldState === newState && !hasContextChanged() && !checkHasForceUpdateAfterProcessing()) {
    // If an update was already in progress, we should schedule an Update
    // effect even though we're bailing out, so that cWU/cDU are called.
    if (typeof instance.componentDidUpdate === 'function') {
      if (oldProps !== current.memoizedProps || oldState !== current.memoizedState) {
        workInProgress.effectTag |= Update;
      }
    }

    if (typeof instance.getSnapshotBeforeUpdate === 'function') {
      if (oldProps !== current.memoizedProps || oldState !== current.memoizedState) {
        workInProgress.effectTag |= Snapshot;
      }
    }

    return false;
  }

  if (typeof getDerivedStateFromProps === 'function') {
    applyDerivedStateFromProps(workInProgress, ctor, getDerivedStateFromProps, newProps);
    newState = workInProgress.memoizedState;
  }

  var shouldUpdate = checkHasForceUpdateAfterProcessing() || checkShouldComponentUpdate(workInProgress, ctor, oldProps, newProps, oldState, newState, nextContext);

  if (shouldUpdate) {
    // In order to support react-lifecycles-compat polyfilled components,
    // Unsafe lifecycles should not be invoked for components using the new APIs.
    if (!hasNewLifecycles && (typeof instance.UNSAFE_componentWillUpdate === 'function' || typeof instance.componentWillUpdate === 'function')) {
      startPhaseTimer(workInProgress, 'componentWillUpdate');

      if (typeof instance.componentWillUpdate === 'function') {
        instance.componentWillUpdate(newProps, newState, nextContext);
      }

      if (typeof instance.UNSAFE_componentWillUpdate === 'function') {
        instance.UNSAFE_componentWillUpdate(newProps, newState, nextContext);
      }

      stopPhaseTimer();
    }

    if (typeof instance.componentDidUpdate === 'function') {
      workInProgress.effectTag |= Update;
    }

    if (typeof instance.getSnapshotBeforeUpdate === 'function') {
      workInProgress.effectTag |= Snapshot;
    }
  } else {
    // If an update was already in progress, we should schedule an Update
    // effect even though we're bailing out, so that cWU/cDU are called.
    if (typeof instance.componentDidUpdate === 'function') {
      if (oldProps !== current.memoizedProps || oldState !== current.memoizedState) {
        workInProgress.effectTag |= Update;
      }
    }

    if (typeof instance.getSnapshotBeforeUpdate === 'function') {
      if (oldProps !== current.memoizedProps || oldState !== current.memoizedState) {
        workInProgress.effectTag |= Snapshot;
      }
    } // If shouldComponentUpdate returned false, we should still update the
    // memoized props/state to indicate that this work can be reused.


    workInProgress.memoizedProps = newProps;
    workInProgress.memoizedState = newState;
  } // Update the existing instance's state, props, and context pointers even
  // if shouldComponentUpdate returns false.


  instance.props = newProps;
  instance.state = newState;
  instance.context = nextContext;
  return shouldUpdate;
}

var didWarnAboutMaps;
var didWarnAboutGenerators;
var didWarnAboutStringRefs;
var ownerHasKeyUseWarning;
var ownerHasFunctionTypeWarning;

var warnForMissingKey = function (child) {};

{
  didWarnAboutMaps = false;
  didWarnAboutGenerators = false;
  didWarnAboutStringRefs = {};
  /**
   * Warn if there's no key explicitly set on dynamic arrays of children or
   * object keys are not valid. This allows us to keep track of children between
   * updates.
   */

  ownerHasKeyUseWarning = {};
  ownerHasFunctionTypeWarning = {};

  warnForMissingKey = function (child) {
    if (child === null || typeof child !== 'object') {
      return;
    }

    if (!child._store || child._store.validated || child.key != null) {
      return;
    }

    if (!(typeof child._store === 'object')) {
      {
        throw Error( "React Component in warnForMissingKey should have a _store. This error is likely caused by a bug in React. Please file an issue." );
      }
    }

    child._store.validated = true;
    var currentComponentErrorInfo = 'Each child in a list should have a unique ' + '"key" prop. See https://fb.me/react-warning-keys for ' + 'more information.' + getCurrentFiberStackInDev();

    if (ownerHasKeyUseWarning[currentComponentErrorInfo]) {
      return;
    }

    ownerHasKeyUseWarning[currentComponentErrorInfo] = true;

    error('Each child in a list should have a unique ' + '"key" prop. See https://fb.me/react-warning-keys for ' + 'more information.');
  };
}

var isArray$1 = Array.isArray;

function coerceRef(returnFiber, current, element) {
  var mixedRef = element.ref;

  if (mixedRef !== null && typeof mixedRef !== 'function' && typeof mixedRef !== 'object') {
    {
      // TODO: Clean this up once we turn on the string ref warning for
      // everyone, because the strict mode case will no longer be relevant
      if ((returnFiber.mode & StrictMode || warnAboutStringRefs) && // We warn in ReactElement.js if owner and self are equal for string refs
      // because these cannot be automatically converted to an arrow function
      // using a codemod. Therefore, we don't have to warn about string refs again.
      !(element._owner && element._self && element._owner.stateNode !== element._self)) {
        var componentName = getComponentName(returnFiber.type) || 'Component';

        if (!didWarnAboutStringRefs[componentName]) {
          {
            error('A string ref, "%s", has been found within a strict mode tree. ' + 'String refs are a source of potential bugs and should be avoided. ' + 'We recommend using useRef() or createRef() instead. ' + 'Learn more about using refs safely here: ' + 'https://fb.me/react-strict-mode-string-ref%s', mixedRef, getStackByFiberInDevAndProd(returnFiber));
          }

          didWarnAboutStringRefs[componentName] = true;
        }
      }
    }

    if (element._owner) {
      var owner = element._owner;
      var inst;

      if (owner) {
        var ownerFiber = owner;

        if (!(ownerFiber.tag === ClassComponent)) {
          {
            throw Error( "Function components cannot have string refs. We recommend using useRef() instead. Learn more about using refs safely here: https://fb.me/react-strict-mode-string-ref" );
          }
        }

        inst = ownerFiber.stateNode;
      }

      if (!inst) {
        {
          throw Error( "Missing owner for string ref " + mixedRef + ". This error is likely caused by a bug in React. Please file an issue." );
        }
      }

      var stringRef = '' + mixedRef; // Check if previous string ref matches new string ref

      if (current !== null && current.ref !== null && typeof current.ref === 'function' && current.ref._stringRef === stringRef) {
        return current.ref;
      }

      var ref = function (value) {
        var refs = inst.refs;

        if (refs === emptyRefsObject) {
          // This is a lazy pooled frozen object, so we need to initialize.
          refs = inst.refs = {};
        }

        if (value === null) {
          delete refs[stringRef];
        } else {
          refs[stringRef] = value;
        }
      };

      ref._stringRef = stringRef;
      return ref;
    } else {
      if (!(typeof mixedRef === 'string')) {
        {
          throw Error( "Expected ref to be a function, a string, an object returned by React.createRef(), or null." );
        }
      }

      if (!element._owner) {
        {
          throw Error( "Element ref was specified as a string (" + mixedRef + ") but no owner was set. This could happen for one of the following reasons:\n1. You may be adding a ref to a function component\n2. You may be adding a ref to a component that was not created inside a component's render method\n3. You have multiple copies of React loaded\nSee https://fb.me/react-refs-must-have-owner for more information." );
        }
      }
    }
  }

  return mixedRef;
}

function throwOnInvalidObjectType(returnFiber, newChild) {
  if (returnFiber.type !== 'textarea') {
    var addendum = '';

    {
      addendum = ' If you meant to render a collection of children, use an array ' + 'instead.' + getCurrentFiberStackInDev();
    }

    {
      {
        throw Error( "Objects are not valid as a React child (found: " + (Object.prototype.toString.call(newChild) === '[object Object]' ? 'object with keys {' + Object.keys(newChild).join(', ') + '}' : newChild) + ")." + addendum );
      }
    }
  }
}

function warnOnFunctionType() {
  {
    var currentComponentErrorInfo = 'Functions are not valid as a React child. This may happen if ' + 'you return a Component instead of <Component /> from render. ' + 'Or maybe you meant to call this function rather than return it.' + getCurrentFiberStackInDev();

    if (ownerHasFunctionTypeWarning[currentComponentErrorInfo]) {
      return;
    }

    ownerHasFunctionTypeWarning[currentComponentErrorInfo] = true;

    error('Functions are not valid as a React child. This may happen if ' + 'you return a Component instead of <Component /> from render. ' + 'Or maybe you meant to call this function rather than return it.');
  }
} // This wrapper function exists because I expect to clone the code in each path
// to be able to optimize each path individually by branching early. This needs
// a compiler or we can do it manually. Helpers that don't need this branching
// live outside of this function.


function ChildReconciler(shouldTrackSideEffects) {
  function deleteChild(returnFiber, childToDelete) {
    if (!shouldTrackSideEffects) {
      // Noop.
      return;
    } // Deletions are added in reversed order so we add it to the front.
    // At this point, the return fiber's effect list is empty except for
    // deletions, so we can just append the deletion to the list. The remaining
    // effects aren't added until the complete phase. Once we implement
    // resuming, this may not be true.


    var last = returnFiber.lastEffect;

    if (last !== null) {
      last.nextEffect = childToDelete;
      returnFiber.lastEffect = childToDelete;
    } else {
      returnFiber.firstEffect = returnFiber.lastEffect = childToDelete;
    }

    childToDelete.nextEffect = null;
    childToDelete.effectTag = Deletion;
  }

  function deleteRemainingChildren(returnFiber, currentFirstChild) {
    if (!shouldTrackSideEffects) {
      // Noop.
      return null;
    } // TODO: For the shouldClone case, this could be micro-optimized a bit by
    // assuming that after the first child we've already added everything.


    var childToDelete = currentFirstChild;

    while (childToDelete !== null) {
      deleteChild(returnFiber, childToDelete);
      childToDelete = childToDelete.sibling;
    }

    return null;
  }

  function mapRemainingChildren(returnFiber, currentFirstChild) {
    // Add the remaining children to a temporary map so that we can find them by
    // keys quickly. Implicit (null) keys get added to this set with their index
    // instead.
    var existingChildren = new Map();
    var existingChild = currentFirstChild;

    while (existingChild !== null) {
      if (existingChild.key !== null) {
        existingChildren.set(existingChild.key, existingChild);
      } else {
        existingChildren.set(existingChild.index, existingChild);
      }

      existingChild = existingChild.sibling;
    }

    return existingChildren;
  }

  function useFiber(fiber, pendingProps) {
    // We currently set sibling to null and index to 0 here because it is easy
    // to forget to do before returning it. E.g. for the single child case.
    var clone = createWorkInProgress(fiber, pendingProps);
    clone.index = 0;
    clone.sibling = null;
    return clone;
  }

  function placeChild(newFiber, lastPlacedIndex, newIndex) {
    newFiber.index = newIndex;

    if (!shouldTrackSideEffects) {
      // Noop.
      return lastPlacedIndex;
    }

    var current = newFiber.alternate;

    if (current !== null) {
      var oldIndex = current.index;

      if (oldIndex < lastPlacedIndex) {
        // This is a move.
        newFiber.effectTag = Placement;
        return lastPlacedIndex;
      } else {
        // This item can stay in place.
        return oldIndex;
      }
    } else {
      // This is an insertion.
      newFiber.effectTag = Placement;
      return lastPlacedIndex;
    }
  }

  function placeSingleChild(newFiber) {
    // This is simpler for the single child case. We only need to do a
    // placement for inserting new children.
    if (shouldTrackSideEffects && newFiber.alternate === null) {
      newFiber.effectTag = Placement;
    }

    return newFiber;
  }

  function updateTextNode(returnFiber, current, textContent, expirationTime) {
    if (current === null || current.tag !== HostText) {
      // Insert
      var created = createFiberFromText(textContent, returnFiber.mode, expirationTime);
      created.return = returnFiber;
      return created;
    } else {
      // Update
      var existing = useFiber(current, textContent);
      existing.return = returnFiber;
      return existing;
    }
  }

  function updateElement(returnFiber, current, element, expirationTime) {
    if (current !== null) {
      if (current.elementType === element.type || ( // Keep this check inline so it only runs on the false path:
       isCompatibleFamilyForHotReloading(current, element) )) {
        // Move based on index
        var existing = useFiber(current, element.props);
        existing.ref = coerceRef(returnFiber, current, element);
        existing.return = returnFiber;

        {
          existing._debugSource = element._source;
          existing._debugOwner = element._owner;
        }

        return existing;
      }
    } // Insert


    var created = createFiberFromElement(element, returnFiber.mode, expirationTime);
    created.ref = coerceRef(returnFiber, current, element);
    created.return = returnFiber;
    return created;
  }

  function updatePortal(returnFiber, current, portal, expirationTime) {
    if (current === null || current.tag !== HostPortal || current.stateNode.containerInfo !== portal.containerInfo || current.stateNode.implementation !== portal.implementation) {
      // Insert
      var created = createFiberFromPortal(portal, returnFiber.mode, expirationTime);
      created.return = returnFiber;
      return created;
    } else {
      // Update
      var existing = useFiber(current, portal.children || []);
      existing.return = returnFiber;
      return existing;
    }
  }

  function updateFragment(returnFiber, current, fragment, expirationTime, key) {
    if (current === null || current.tag !== Fragment) {
      // Insert
      var created = createFiberFromFragment(fragment, returnFiber.mode, expirationTime, key);
      created.return = returnFiber;
      return created;
    } else {
      // Update
      var existing = useFiber(current, fragment);
      existing.return = returnFiber;
      return existing;
    }
  }

  function createChild(returnFiber, newChild, expirationTime) {
    if (typeof newChild === 'string' || typeof newChild === 'number') {
      // Text nodes don't have keys. If the previous node is implicitly keyed
      // we can continue to replace it without aborting even if it is not a text
      // node.
      var created = createFiberFromText('' + newChild, returnFiber.mode, expirationTime);
      created.return = returnFiber;
      return created;
    }

    if (typeof newChild === 'object' && newChild !== null) {
      switch (newChild.$$typeof) {
        case REACT_ELEMENT_TYPE:
          {
            var _created = createFiberFromElement(newChild, returnFiber.mode, expirationTime);

            _created.ref = coerceRef(returnFiber, null, newChild);
            _created.return = returnFiber;
            return _created;
          }

        case REACT_PORTAL_TYPE:
          {
            var _created2 = createFiberFromPortal(newChild, returnFiber.mode, expirationTime);

            _created2.return = returnFiber;
            return _created2;
          }
      }

      if (isArray$1(newChild) || getIteratorFn(newChild)) {
        var _created3 = createFiberFromFragment(newChild, returnFiber.mode, expirationTime, null);

        _created3.return = returnFiber;
        return _created3;
      }

      throwOnInvalidObjectType(returnFiber, newChild);
    }

    {
      if (typeof newChild === 'function') {
        warnOnFunctionType();
      }
    }

    return null;
  }

  function updateSlot(returnFiber, oldFiber, newChild, expirationTime) {
    // Update the fiber if the keys match, otherwise return null.
    var key = oldFiber !== null ? oldFiber.key : null;

    if (typeof newChild === 'string' || typeof newChild === 'number') {
      // Text nodes don't have keys. If the previous node is implicitly keyed
      // we can continue to replace it without aborting even if it is not a text
      // node.
      if (key !== null) {
        return null;
      }

      return updateTextNode(returnFiber, oldFiber, '' + newChild, expirationTime);
    }

    if (typeof newChild === 'object' && newChild !== null) {
      switch (newChild.$$typeof) {
        case REACT_ELEMENT_TYPE:
          {
            if (newChild.key === key) {
              if (newChild.type === REACT_FRAGMENT_TYPE) {
                return updateFragment(returnFiber, oldFiber, newChild.props.children, expirationTime, key);
              }

              return updateElement(returnFiber, oldFiber, newChild, expirationTime);
            } else {
              return null;
            }
          }

        case REACT_PORTAL_TYPE:
          {
            if (newChild.key === key) {
              return updatePortal(returnFiber, oldFiber, newChild, expirationTime);
            } else {
              return null;
            }
          }
      }

      if (isArray$1(newChild) || getIteratorFn(newChild)) {
        if (key !== null) {
          return null;
        }

        return updateFragment(returnFiber, oldFiber, newChild, expirationTime, null);
      }

      throwOnInvalidObjectType(returnFiber, newChild);
    }

    {
      if (typeof newChild === 'function') {
        warnOnFunctionType();
      }
    }

    return null;
  }

  function updateFromMap(existingChildren, returnFiber, newIdx, newChild, expirationTime) {
    if (typeof newChild === 'string' || typeof newChild === 'number') {
      // Text nodes don't have keys, so we neither have to check the old nor
      // new node for the key. If both are text nodes, they match.
      var matchedFiber = existingChildren.get(newIdx) || null;
      return updateTextNode(returnFiber, matchedFiber, '' + newChild, expirationTime);
    }

    if (typeof newChild === 'object' && newChild !== null) {
      switch (newChild.$$typeof) {
        case REACT_ELEMENT_TYPE:
          {
            var _matchedFiber = existingChildren.get(newChild.key === null ? newIdx : newChild.key) || null;

            if (newChild.type === REACT_FRAGMENT_TYPE) {
              return updateFragment(returnFiber, _matchedFiber, newChild.props.children, expirationTime, newChild.key);
            }

            return updateElement(returnFiber, _matchedFiber, newChild, expirationTime);
          }

        case REACT_PORTAL_TYPE:
          {
            var _matchedFiber2 = existingChildren.get(newChild.key === null ? newIdx : newChild.key) || null;

            return updatePortal(returnFiber, _matchedFiber2, newChild, expirationTime);
          }
      }

      if (isArray$1(newChild) || getIteratorFn(newChild)) {
        var _matchedFiber3 = existingChildren.get(newIdx) || null;

        return updateFragment(returnFiber, _matchedFiber3, newChild, expirationTime, null);
      }

      throwOnInvalidObjectType(returnFiber, newChild);
    }

    {
      if (typeof newChild === 'function') {
        warnOnFunctionType();
      }
    }

    return null;
  }
  /**
   * Warns if there is a duplicate or missing key
   */


  function warnOnInvalidKey(child, knownKeys) {
    {
      if (typeof child !== 'object' || child === null) {
        return knownKeys;
      }

      switch (child.$$typeof) {
        case REACT_ELEMENT_TYPE:
        case REACT_PORTAL_TYPE:
          warnForMissingKey(child);
          var key = child.key;

          if (typeof key !== 'string') {
            break;
          }

          if (knownKeys === null) {
            knownKeys = new Set();
            knownKeys.add(key);
            break;
          }

          if (!knownKeys.has(key)) {
            knownKeys.add(key);
            break;
          }

          error('Encountered two children with the same key, `%s`. ' + 'Keys should be unique so that components maintain their identity ' + 'across updates. Non-unique keys may cause children to be ' + 'duplicated and/or omitted — the behavior is unsupported and ' + 'could change in a future version.', key);

          break;
      }
    }

    return knownKeys;
  }

  function reconcileChildrenArray(returnFiber, currentFirstChild, newChildren, expirationTime) {
    // This algorithm can't optimize by searching from both ends since we
    // don't have backpointers on fibers. I'm trying to see how far we can get
    // with that model. If it ends up not being worth the tradeoffs, we can
    // add it later.
    // Even with a two ended optimization, we'd want to optimize for the case
    // where there are few changes and brute force the comparison instead of
    // going for the Map. It'd like to explore hitting that path first in
    // forward-only mode and only go for the Map once we notice that we need
    // lots of look ahead. This doesn't handle reversal as well as two ended
    // search but that's unusual. Besides, for the two ended optimization to
    // work on Iterables, we'd need to copy the whole set.
    // In this first iteration, we'll just live with hitting the bad case
    // (adding everything to a Map) in for every insert/move.
    // If you change this code, also update reconcileChildrenIterator() which
    // uses the same algorithm.
    {
      // First, validate keys.
      var knownKeys = null;

      for (var i = 0; i < newChildren.length; i++) {
        var child = newChildren[i];
        knownKeys = warnOnInvalidKey(child, knownKeys);
      }
    }

    var resultingFirstChild = null;
    var previousNewFiber = null;
    var oldFiber = currentFirstChild;
    var lastPlacedIndex = 0;
    var newIdx = 0;
    var nextOldFiber = null;

    for (; oldFiber !== null && newIdx < newChildren.length; newIdx++) {
      if (oldFiber.index > newIdx) {
        nextOldFiber = oldFiber;
        oldFiber = null;
      } else {
        nextOldFiber = oldFiber.sibling;
      }

      var newFiber = updateSlot(returnFiber, oldFiber, newChildren[newIdx], expirationTime);

      if (newFiber === null) {
        // TODO: This breaks on empty slots like null children. That's
        // unfortunate because it triggers the slow path all the time. We need
        // a better way to communicate whether this was a miss or null,
        // boolean, undefined, etc.
        if (oldFiber === null) {
          oldFiber = nextOldFiber;
        }

        break;
      }

      if (shouldTrackSideEffects) {
        if (oldFiber && newFiber.alternate === null) {
          // We matched the slot, but we didn't reuse the existing fiber, so we
          // need to delete the existing child.
          deleteChild(returnFiber, oldFiber);
        }
      }

      lastPlacedIndex = placeChild(newFiber, lastPlacedIndex, newIdx);

      if (previousNewFiber === null) {
        // TODO: Move out of the loop. This only happens for the first run.
        resultingFirstChild = newFiber;
      } else {
        // TODO: Defer siblings if we're not at the right index for this slot.
        // I.e. if we had null values before, then we want to defer this
        // for each null value. However, we also don't want to call updateSlot
        // with the previous one.
        previousNewFiber.sibling = newFiber;
      }

      previousNewFiber = newFiber;
      oldFiber = nextOldFiber;
    }

    if (newIdx === newChildren.length) {
      // We've reached the end of the new children. We can delete the rest.
      deleteRemainingChildren(returnFiber, oldFiber);
      return resultingFirstChild;
    }

    if (oldFiber === null) {
      // If we don't have any more existing children we can choose a fast path
      // since the rest will all be insertions.
      for (; newIdx < newChildren.length; newIdx++) {
        var _newFiber = createChild(returnFiber, newChildren[newIdx], expirationTime);

        if (_newFiber === null) {
          continue;
        }

        lastPlacedIndex = placeChild(_newFiber, lastPlacedIndex, newIdx);

        if (previousNewFiber === null) {
          // TODO: Move out of the loop. This only happens for the first run.
          resultingFirstChild = _newFiber;
        } else {
          previousNewFiber.sibling = _newFiber;
        }

        previousNewFiber = _newFiber;
      }

      return resultingFirstChild;
    } // Add all children to a key map for quick lookups.


    var existingChildren = mapRemainingChildren(returnFiber, oldFiber); // Keep scanning and use the map to restore deleted items as moves.

    for (; newIdx < newChildren.length; newIdx++) {
      var _newFiber2 = updateFromMap(existingChildren, returnFiber, newIdx, newChildren[newIdx], expirationTime);

      if (_newFiber2 !== null) {
        if (shouldTrackSideEffects) {
          if (_newFiber2.alternate !== null) {
            // The new fiber is a work in progress, but if there exists a
            // current, that means that we reused the fiber. We need to delete
            // it from the child list so that we don't add it to the deletion
            // list.
            existingChildren.delete(_newFiber2.key === null ? newIdx : _newFiber2.key);
          }
        }

        lastPlacedIndex = placeChild(_newFiber2, lastPlacedIndex, newIdx);

        if (previousNewFiber === null) {
          resultingFirstChild = _newFiber2;
        } else {
          previousNewFiber.sibling = _newFiber2;
        }

        previousNewFiber = _newFiber2;
      }
    }

    if (shouldTrackSideEffects) {
      // Any existing children that weren't consumed above were deleted. We need
      // to add them to the deletion list.
      existingChildren.forEach(function (child) {
        return deleteChild(returnFiber, child);
      });
    }

    return resultingFirstChild;
  }

  function reconcileChildrenIterator(returnFiber, currentFirstChild, newChildrenIterable, expirationTime) {
    // This is the same implementation as reconcileChildrenArray(),
    // but using the iterator instead.
    var iteratorFn = getIteratorFn(newChildrenIterable);

    if (!(typeof iteratorFn === 'function')) {
      {
        throw Error( "An object is not an iterable. This error is likely caused by a bug in React. Please file an issue." );
      }
    }

    {
      // We don't support rendering Generators because it's a mutation.
      // See https://github.com/facebook/react/issues/12995
      if (typeof Symbol === 'function' && // $FlowFixMe Flow doesn't know about toStringTag
      newChildrenIterable[Symbol.toStringTag] === 'Generator') {
        if (!didWarnAboutGenerators) {
          error('Using Generators as children is unsupported and will likely yield ' + 'unexpected results because enumerating a generator mutates it. ' + 'You may convert it to an array with `Array.from()` or the ' + '`[...spread]` operator before rendering. Keep in mind ' + 'you might need to polyfill these features for older browsers.');
        }

        didWarnAboutGenerators = true;
      } // Warn about using Maps as children


      if (newChildrenIterable.entries === iteratorFn) {
        if (!didWarnAboutMaps) {
          error('Using Maps as children is unsupported and will likely yield ' + 'unexpected results. Convert it to a sequence/iterable of keyed ' + 'ReactElements instead.');
        }

        didWarnAboutMaps = true;
      } // First, validate keys.
      // We'll get a different iterator later for the main pass.


      var _newChildren = iteratorFn.call(newChildrenIterable);

      if (_newChildren) {
        var knownKeys = null;

        var _step = _newChildren.next();

        for (; !_step.done; _step = _newChildren.next()) {
          var child = _step.value;
          knownKeys = warnOnInvalidKey(child, knownKeys);
        }
      }
    }

    var newChildren = iteratorFn.call(newChildrenIterable);

    if (!(newChildren != null)) {
      {
        throw Error( "An iterable object provided no iterator." );
      }
    }

    var resultingFirstChild = null;
    var previousNewFiber = null;
    var oldFiber = currentFirstChild;
    var lastPlacedIndex = 0;
    var newIdx = 0;
    var nextOldFiber = null;
    var step = newChildren.next();

    for (; oldFiber !== null && !step.done; newIdx++, step = newChildren.next()) {
      if (oldFiber.index > newIdx) {
        nextOldFiber = oldFiber;
        oldFiber = null;
      } else {
        nextOldFiber = oldFiber.sibling;
      }

      var newFiber = updateSlot(returnFiber, oldFiber, step.value, expirationTime);

      if (newFiber === null) {
        // TODO: This breaks on empty slots like null children. That's
        // unfortunate because it triggers the slow path all the time. We need
        // a better way to communicate whether this was a miss or null,
        // boolean, undefined, etc.
        if (oldFiber === null) {
          oldFiber = nextOldFiber;
        }

        break;
      }

      if (shouldTrackSideEffects) {
        if (oldFiber && newFiber.alternate === null) {
          // We matched the slot, but we didn't reuse the existing fiber, so we
          // need to delete the existing child.
          deleteChild(returnFiber, oldFiber);
        }
      }

      lastPlacedIndex = placeChild(newFiber, lastPlacedIndex, newIdx);

      if (previousNewFiber === null) {
        // TODO: Move out of the loop. This only happens for the first run.
        resultingFirstChild = newFiber;
      } else {
        // TODO: Defer siblings if we're not at the right index for this slot.
        // I.e. if we had null values before, then we want to defer this
        // for each null value. However, we also don't want to call updateSlot
        // with the previous one.
        previousNewFiber.sibling = newFiber;
      }

      previousNewFiber = newFiber;
      oldFiber = nextOldFiber;
    }

    if (step.done) {
      // We've reached the end of the new children. We can delete the rest.
      deleteRemainingChildren(returnFiber, oldFiber);
      return resultingFirstChild;
    }

    if (oldFiber === null) {
      // If we don't have any more existing children we can choose a fast path
      // since the rest will all be insertions.
      for (; !step.done; newIdx++, step = newChildren.next()) {
        var _newFiber3 = createChild(returnFiber, step.value, expirationTime);

        if (_newFiber3 === null) {
          continue;
        }

        lastPlacedIndex = placeChild(_newFiber3, lastPlacedIndex, newIdx);

        if (previousNewFiber === null) {
          // TODO: Move out of the loop. This only happens for the first run.
          resultingFirstChild = _newFiber3;
        } else {
          previousNewFiber.sibling = _newFiber3;
        }

        previousNewFiber = _newFiber3;
      }

      return resultingFirstChild;
    } // Add all children to a key map for quick lookups.


    var existingChildren = mapRemainingChildren(returnFiber, oldFiber); // Keep scanning and use the map to restore deleted items as moves.

    for (; !step.done; newIdx++, step = newChildren.next()) {
      var _newFiber4 = updateFromMap(existingChildren, returnFiber, newIdx, step.value, expirationTime);

      if (_newFiber4 !== null) {
        if (shouldTrackSideEffects) {
          if (_newFiber4.alternate !== null) {
            // The new fiber is a work in progress, but if there exists a
            // current, that means that we reused the fiber. We need to delete
            // it from the child list so that we don't add it to the deletion
            // list.
            existingChildren.delete(_newFiber4.key === null ? newIdx : _newFiber4.key);
          }
        }

        lastPlacedIndex = placeChild(_newFiber4, lastPlacedIndex, newIdx);

        if (previousNewFiber === null) {
          resultingFirstChild = _newFiber4;
        } else {
          previousNewFiber.sibling = _newFiber4;
        }

        previousNewFiber = _newFiber4;
      }
    }

    if (shouldTrackSideEffects) {
      // Any existing children that weren't consumed above were deleted. We need
      // to add them to the deletion list.
      existingChildren.forEach(function (child) {
        return deleteChild(returnFiber, child);
      });
    }

    return resultingFirstChild;
  }

  function reconcileSingleTextNode(returnFiber, currentFirstChild, textContent, expirationTime) {
    // There's no need to check for keys on text nodes since we don't have a
    // way to define them.
    if (currentFirstChild !== null && currentFirstChild.tag === HostText) {
      // We already have an existing node so let's just update it and delete
      // the rest.
      deleteRemainingChildren(returnFiber, currentFirstChild.sibling);
      var existing = useFiber(currentFirstChild, textContent);
      existing.return = returnFiber;
      return existing;
    } // The existing first child is not a text node so we need to create one
    // and delete the existing ones.


    deleteRemainingChildren(returnFiber, currentFirstChild);
    var created = createFiberFromText(textContent, returnFiber.mode, expirationTime);
    created.return = returnFiber;
    return created;
  }

  function reconcileSingleElement(returnFiber, currentFirstChild, element, expirationTime) {
    var key = element.key;
    var child = currentFirstChild;

    while (child !== null) {
      // TODO: If key === null and child.key === null, then this only applies to
      // the first item in the list.
      if (child.key === key) {
        switch (child.tag) {
          case Fragment:
            {
              if (element.type === REACT_FRAGMENT_TYPE) {
                deleteRemainingChildren(returnFiber, child.sibling);
                var existing = useFiber(child, element.props.children);
                existing.return = returnFiber;

                {
                  existing._debugSource = element._source;
                  existing._debugOwner = element._owner;
                }

                return existing;
              }

              break;
            }

          case Block:

          // We intentionally fallthrough here if enableBlocksAPI is not on.
          // eslint-disable-next-lined no-fallthrough

          default:
            {
              if (child.elementType === element.type || ( // Keep this check inline so it only runs on the false path:
               isCompatibleFamilyForHotReloading(child, element) )) {
                deleteRemainingChildren(returnFiber, child.sibling);

                var _existing3 = useFiber(child, element.props);

                _existing3.ref = coerceRef(returnFiber, child, element);
                _existing3.return = returnFiber;

                {
                  _existing3._debugSource = element._source;
                  _existing3._debugOwner = element._owner;
                }

                return _existing3;
              }

              break;
            }
        } // Didn't match.


        deleteRemainingChildren(returnFiber, child);
        break;
      } else {
        deleteChild(returnFiber, child);
      }

      child = child.sibling;
    }

    if (element.type === REACT_FRAGMENT_TYPE) {
      var created = createFiberFromFragment(element.props.children, returnFiber.mode, expirationTime, element.key);
      created.return = returnFiber;
      return created;
    } else {
      var _created4 = createFiberFromElement(element, returnFiber.mode, expirationTime);

      _created4.ref = coerceRef(returnFiber, currentFirstChild, element);
      _created4.return = returnFiber;
      return _created4;
    }
  }

  function reconcileSinglePortal(returnFiber, currentFirstChild, portal, expirationTime) {
    var key = portal.key;
    var child = currentFirstChild;

    while (child !== null) {
      // TODO: If key === null and child.key === null, then this only applies to
      // the first item in the list.
      if (child.key === key) {
        if (child.tag === HostPortal && child.stateNode.containerInfo === portal.containerInfo && child.stateNode.implementation === portal.implementation) {
          deleteRemainingChildren(returnFiber, child.sibling);
          var existing = useFiber(child, portal.children || []);
          existing.return = returnFiber;
          return existing;
        } else {
          deleteRemainingChildren(returnFiber, child);
          break;
        }
      } else {
        deleteChild(returnFiber, child);
      }

      child = child.sibling;
    }

    var created = createFiberFromPortal(portal, returnFiber.mode, expirationTime);
    created.return = returnFiber;
    return created;
  } // This API will tag the children with the side-effect of the reconciliation
  // itself. They will be added to the side-effect list as we pass through the
  // children and the parent.


  function reconcileChildFibers(returnFiber, currentFirstChild, newChild, expirationTime) {
    // This function is not recursive.
    // If the top level item is an array, we treat it as a set of children,
    // not as a fragment. Nested arrays on the other hand will be treated as
    // fragment nodes. Recursion happens at the normal flow.
    // Handle top level unkeyed fragments as if they were arrays.
    // This leads to an ambiguity between <>{[...]}</> and <>...</>.
    // We treat the ambiguous cases above the same.
    var isUnkeyedTopLevelFragment = typeof newChild === 'object' && newChild !== null && newChild.type === REACT_FRAGMENT_TYPE && newChild.key === null;

    if (isUnkeyedTopLevelFragment) {
      newChild = newChild.props.children;
    } // Handle object types


    var isObject = typeof newChild === 'object' && newChild !== null;

    if (isObject) {
      switch (newChild.$$typeof) {
        case REACT_ELEMENT_TYPE:
          return placeSingleChild(reconcileSingleElement(returnFiber, currentFirstChild, newChild, expirationTime));

        case REACT_PORTAL_TYPE:
          return placeSingleChild(reconcileSinglePortal(returnFiber, currentFirstChild, newChild, expirationTime));
      }
    }

    if (typeof newChild === 'string' || typeof newChild === 'number') {
      return placeSingleChild(reconcileSingleTextNode(returnFiber, currentFirstChild, '' + newChild, expirationTime));
    }

    if (isArray$1(newChild)) {
      return reconcileChildrenArray(returnFiber, currentFirstChild, newChild, expirationTime);
    }

    if (getIteratorFn(newChild)) {
      return reconcileChildrenIterator(returnFiber, currentFirstChild, newChild, expirationTime);
    }

    if (isObject) {
      throwOnInvalidObjectType(returnFiber, newChild);
    }

    {
      if (typeof newChild === 'function') {
        warnOnFunctionType();
      }
    }

    if (typeof newChild === 'undefined' && !isUnkeyedTopLevelFragment) {
      // If the new child is undefined, and the return fiber is a composite
      // component, throw an error. If Fiber return types are disabled,
      // we already threw above.
      switch (returnFiber.tag) {
        case ClassComponent:
          {
            {
              var instance = returnFiber.stateNode;

              if (instance.render._isMockFunction) {
                // We allow auto-mocks to proceed as if they're returning null.
                break;
              }
            }
          }
        // Intentionally fall through to the next case, which handles both
        // functions and classes
        // eslint-disable-next-lined no-fallthrough

        case FunctionComponent:
          {
            var Component = returnFiber.type;

            {
              {
                throw Error( (Component.displayName || Component.name || 'Component') + "(...): Nothing was returned from render. This usually means a return statement is missing. Or, to render nothing, return null." );
              }
            }
          }
      }
    } // Remaining cases are all treated as empty.


    return deleteRemainingChildren(returnFiber, currentFirstChild);
  }

  return reconcileChildFibers;
}

var reconcileChildFibers = ChildReconciler(true);
var mountChildFibers = ChildReconciler(false);
function cloneChildFibers(current, workInProgress) {
  if (!(current === null || workInProgress.child === current.child)) {
    {
      throw Error( "Resuming work not yet implemented." );
    }
  }

  if (workInProgress.child === null) {
    return;
  }

  var currentChild = workInProgress.child;
  var newChild = createWorkInProgress(currentChild, currentChild.pendingProps);
  workInProgress.child = newChild;
  newChild.return = workInProgress;

  while (currentChild.sibling !== null) {
    currentChild = currentChild.sibling;
    newChild = newChild.sibling = createWorkInProgress(currentChild, currentChild.pendingProps);
    newChild.return = workInProgress;
  }

  newChild.sibling = null;
} // Reset a workInProgress child set to prepare it for a second pass.

function resetChildFibers(workInProgress, renderExpirationTime) {
  var child = workInProgress.child;

  while (child !== null) {
    resetWorkInProgress(child, renderExpirationTime);
    child = child.sibling;
  }
}

var NO_CONTEXT = {};
var contextStackCursor$1 = createCursor(NO_CONTEXT);
var contextFiberStackCursor = createCursor(NO_CONTEXT);
var rootInstanceStackCursor = createCursor(NO_CONTEXT);

function requiredContext(c) {
  if (!(c !== NO_CONTEXT)) {
    {
      throw Error( "Expected host context to exist. This error is likely caused by a bug in React. Please file an issue." );
    }
  }

  return c;
}

function getRootHostContainer() {
  var rootInstance = requiredContext(rootInstanceStackCursor.current);
  return rootInstance;
}

function pushHostContainer(fiber, nextRootInstance) {
  // Push current root instance onto the stack;
  // This allows us to reset root when portals are popped.
  push(rootInstanceStackCursor, nextRootInstance, fiber); // Track the context and the Fiber that provided it.
  // This enables us to pop only Fibers that provide unique contexts.

  push(contextFiberStackCursor, fiber, fiber); // Finally, we need to push the host context to the stack.
  // However, we can't just call getRootHostContext() and push it because
  // we'd have a different number of entries on the stack depending on
  // whether getRootHostContext() throws somewhere in renderer code or not.
  // So we push an empty value first. This lets us safely unwind on errors.

  push(contextStackCursor$1, NO_CONTEXT, fiber);
  var nextRootContext = getRootHostContext(nextRootInstance); // Now that we know this function doesn't throw, replace it.

  pop(contextStackCursor$1, fiber);
  push(contextStackCursor$1, nextRootContext, fiber);
}

function popHostContainer(fiber) {
  pop(contextStackCursor$1, fiber);
  pop(contextFiberStackCursor, fiber);
  pop(rootInstanceStackCursor, fiber);
}

function getHostContext() {
  var context = requiredContext(contextStackCursor$1.current);
  return context;
}

function pushHostContext(fiber) {
  var rootInstance = requiredContext(rootInstanceStackCursor.current);
  var context = requiredContext(contextStackCursor$1.current);
  var nextContext = getChildHostContext(context, fiber.type, rootInstance); // Don't push this Fiber's context unless it's unique.

  if (context === nextContext) {
    return;
  } // Track the context and the Fiber that provided it.
  // This enables us to pop only Fibers that provide unique contexts.


  push(contextFiberStackCursor, fiber, fiber);
  push(contextStackCursor$1, nextContext, fiber);
}

function popHostContext(fiber) {
  // Do not pop unless this Fiber provided the current context.
  // pushHostContext() only pushes Fibers that provide unique contexts.
  if (contextFiberStackCursor.current !== fiber) {
    return;
  }

  pop(contextStackCursor$1, fiber);
  pop(contextFiberStackCursor, fiber);
}

var DefaultSuspenseContext = 0; // The Suspense Context is split into two parts. The lower bits is
// inherited deeply down the subtree. The upper bits only affect
// this immediate suspense boundary and gets reset each new
// boundary or suspense list.

var SubtreeSuspenseContextMask = 1; // Subtree Flags:
// InvisibleParentSuspenseContext indicates that one of our parent Suspense
// boundaries is not currently showing visible main content.
// Either because it is already showing a fallback or is not mounted at all.
// We can use this to determine if it is desirable to trigger a fallback at
// the parent. If not, then we might need to trigger undesirable boundaries
// and/or suspend the commit to avoid hiding the parent content.

var InvisibleParentSuspenseContext = 1; // Shallow Flags:
// ForceSuspenseFallback can be used by SuspenseList to force newly added
// items into their fallback state during one of the render passes.

var ForceSuspenseFallback = 2;
var suspenseStackCursor = createCursor(DefaultSuspenseContext);
function hasSuspenseContext(parentContext, flag) {
  return (parentContext & flag) !== 0;
}
function setDefaultShallowSuspenseContext(parentContext) {
  return parentContext & SubtreeSuspenseContextMask;
}
function setShallowSuspenseContext(parentContext, shallowContext) {
  return parentContext & SubtreeSuspenseContextMask | shallowContext;
}
function addSubtreeSuspenseContext(parentContext, subtreeContext) {
  return parentContext | subtreeContext;
}
function pushSuspenseContext(fiber, newContext) {
  push(suspenseStackCursor, newContext, fiber);
}
function popSuspenseContext(fiber) {
  pop(suspenseStackCursor, fiber);
}

function shouldCaptureSuspense(workInProgress, hasInvisibleParent) {
  // If it was the primary children that just suspended, capture and render the
  // fallback. Otherwise, don't capture and bubble to the next boundary.
  var nextState = workInProgress.memoizedState;

  if (nextState !== null) {
    if (nextState.dehydrated !== null) {
      // A dehydrated boundary always captures.
      return true;
    }

    return false;
  }

  var props = workInProgress.memoizedProps; // In order to capture, the Suspense component must have a fallback prop.

  if (props.fallback === undefined) {
    return false;
  } // Regular boundaries always capture.


  if (props.unstable_avoidThisFallback !== true) {
    return true;
  } // If it's a boundary we should avoid, then we prefer to bubble up to the
  // parent boundary if it is currently invisible.


  if (hasInvisibleParent) {
    return false;
  } // If the parent is not able to handle it, we must handle it.


  return true;
}
function findFirstSuspended(row) {
  var node = row;

  while (node !== null) {
    if (node.tag === SuspenseComponent) {
      var state = node.memoizedState;

      if (state !== null) {
        var dehydrated = state.dehydrated;

        if (dehydrated === null || isSuspenseInstancePending(dehydrated) || isSuspenseInstanceFallback(dehydrated)) {
          return node;
        }
      }
    } else if (node.tag === SuspenseListComponent && // revealOrder undefined can't be trusted because it don't
    // keep track of whether it suspended or not.
    node.memoizedProps.revealOrder !== undefined) {
      var didSuspend = (node.effectTag & DidCapture) !== NoEffect;

      if (didSuspend) {
        return node;
      }
    } else if (node.child !== null) {
      node.child.return = node;
      node = node.child;
      continue;
    }

    if (node === row) {
      return null;
    }

    while (node.sibling === null) {
      if (node.return === null || node.return === row) {
        return null;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;
  }

  return null;
}

function createDeprecatedResponderListener(responder, props) {
  var eventResponderListener = {
    responder: responder,
    props: props
  };

  {
    Object.freeze(eventResponderListener);
  }

  return eventResponderListener;
}

var HasEffect =
/* */
1; // Represents the phase in which the effect (not the clean-up) fires.

var Layout =
/*    */
2;
var Passive$1 =
/*   */
4;

var ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher,
    ReactCurrentBatchConfig$1 = ReactSharedInternals.ReactCurrentBatchConfig;
var didWarnAboutMismatchedHooksForComponent;

{
  didWarnAboutMismatchedHooksForComponent = new Set();
}

// These are set right before calling the component.
var renderExpirationTime = NoWork; // The work-in-progress fiber. I've named it differently to distinguish it from
// the work-in-progress hook.

var currentlyRenderingFiber$1 = null; // Hooks are stored as a linked list on the fiber's memoizedState field. The
// current hook list is the list that belongs to the current fiber. The
// work-in-progress hook list is a new list that will be added to the
// work-in-progress fiber.

var currentHook = null;
var workInProgressHook = null; // Whether an update was scheduled at any point during the render phase. This
// does not get reset if we do another render pass; only when we're completely
// finished evaluating this component. This is an optimization so we know
// whether we need to clear render phase updates after a throw.

var didScheduleRenderPhaseUpdate = false;
var RE_RENDER_LIMIT = 25; // In DEV, this is the name of the currently executing primitive hook

var currentHookNameInDev = null; // In DEV, this list ensures that hooks are called in the same order between renders.
// The list stores the order of hooks used during the initial render (mount).
// Subsequent renders (updates) reference this list.

var hookTypesDev = null;
var hookTypesUpdateIndexDev = -1; // In DEV, this tracks whether currently rendering component needs to ignore
// the dependencies for Hooks that need them (e.g. useEffect or useMemo).
// When true, such Hooks will always be "remounted". Only used during hot reload.

var ignorePreviousDependencies = false;

function mountHookTypesDev() {
  {
    var hookName = currentHookNameInDev;

    if (hookTypesDev === null) {
      hookTypesDev = [hookName];
    } else {
      hookTypesDev.push(hookName);
    }
  }
}

function updateHookTypesDev() {
  {
    var hookName = currentHookNameInDev;

    if (hookTypesDev !== null) {
      hookTypesUpdateIndexDev++;

      if (hookTypesDev[hookTypesUpdateIndexDev] !== hookName) {
        warnOnHookMismatchInDev(hookName);
      }
    }
  }
}

function checkDepsAreArrayDev(deps) {
  {
    if (deps !== undefined && deps !== null && !Array.isArray(deps)) {
      // Verify deps, but only on mount to avoid extra checks.
      // It's unlikely their type would change as usually you define them inline.
      error('%s received a final argument that is not an array (instead, received `%s`). When ' + 'specified, the final argument must be an array.', currentHookNameInDev, typeof deps);
    }
  }
}

function warnOnHookMismatchInDev(currentHookName) {
  {
    var componentName = getComponentName(currentlyRenderingFiber$1.type);

    if (!didWarnAboutMismatchedHooksForComponent.has(componentName)) {
      didWarnAboutMismatchedHooksForComponent.add(componentName);

      if (hookTypesDev !== null) {
        var table = '';
        var secondColumnStart = 30;

        for (var i = 0; i <= hookTypesUpdateIndexDev; i++) {
          var oldHookName = hookTypesDev[i];
          var newHookName = i === hookTypesUpdateIndexDev ? currentHookName : oldHookName;
          var row = i + 1 + ". " + oldHookName; // Extra space so second column lines up
          // lol @ IE not supporting String#repeat

          while (row.length < secondColumnStart) {
            row += ' ';
          }

          row += newHookName + '\n';
          table += row;
        }

        error('React has detected a change in the order of Hooks called by %s. ' + 'This will lead to bugs and errors if not fixed. ' + 'For more information, read the Rules of Hooks: https://fb.me/rules-of-hooks\n\n' + '   Previous render            Next render\n' + '   ------------------------------------------------------\n' + '%s' + '   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^\n', componentName, table);
      }
    }
  }
}

function throwInvalidHookError() {
  {
    {
      throw Error( "Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://fb.me/react-invalid-hook-call for tips about how to debug and fix this problem." );
    }
  }
}

function areHookInputsEqual(nextDeps, prevDeps) {
  {
    if (ignorePreviousDependencies) {
      // Only true when this component is being hot reloaded.
      return false;
    }
  }

  if (prevDeps === null) {
    {
      error('%s received a final argument during this render, but not during ' + 'the previous render. Even though the final argument is optional, ' + 'its type cannot change between renders.', currentHookNameInDev);
    }

    return false;
  }

  {
    // Don't bother comparing lengths in prod because these arrays should be
    // passed inline.
    if (nextDeps.length !== prevDeps.length) {
      error('The final argument passed to %s changed size between renders. The ' + 'order and size of this array must remain constant.\n\n' + 'Previous: %s\n' + 'Incoming: %s', currentHookNameInDev, "[" + prevDeps.join(', ') + "]", "[" + nextDeps.join(', ') + "]");
    }
  }

  for (var i = 0; i < prevDeps.length && i < nextDeps.length; i++) {
    if (objectIs(nextDeps[i], prevDeps[i])) {
      continue;
    }

    return false;
  }

  return true;
}

function renderWithHooks(current, workInProgress, Component, props, secondArg, nextRenderExpirationTime) {
  renderExpirationTime = nextRenderExpirationTime;
  currentlyRenderingFiber$1 = workInProgress;

  {
    hookTypesDev = current !== null ? current._debugHookTypes : null;
    hookTypesUpdateIndexDev = -1; // Used for hot reloading:

    ignorePreviousDependencies = current !== null && current.type !== workInProgress.type;
  }

  workInProgress.memoizedState = null;
  workInProgress.updateQueue = null;
  workInProgress.expirationTime = NoWork; // The following should have already been reset
  // currentHook = null;
  // workInProgressHook = null;
  // didScheduleRenderPhaseUpdate = false;
  // TODO Warn if no hooks are used at all during mount, then some are used during update.
  // Currently we will identify the update render as a mount because memoizedState === null.
  // This is tricky because it's valid for certain types of components (e.g. React.lazy)
  // Using memoizedState to differentiate between mount/update only works if at least one stateful hook is used.
  // Non-stateful hooks (e.g. context) don't get added to memoizedState,
  // so memoizedState would be null during updates and mounts.

  {
    if (current !== null && current.memoizedState !== null) {
      ReactCurrentDispatcher.current = HooksDispatcherOnUpdateInDEV;
    } else if (hookTypesDev !== null) {
      // This dispatcher handles an edge case where a component is updating,
      // but no stateful hooks have been used.
      // We want to match the production code behavior (which will use HooksDispatcherOnMount),
      // but with the extra DEV validation to ensure hooks ordering hasn't changed.
      // This dispatcher does that.
      ReactCurrentDispatcher.current = HooksDispatcherOnMountWithHookTypesInDEV;
    } else {
      ReactCurrentDispatcher.current = HooksDispatcherOnMountInDEV;
    }
  }

  var children = Component(props, secondArg); // Check if there was a render phase update

  if (workInProgress.expirationTime === renderExpirationTime) {
    // Keep rendering in a loop for as long as render phase updates continue to
    // be scheduled. Use a counter to prevent infinite loops.
    var numberOfReRenders = 0;

    do {
      workInProgress.expirationTime = NoWork;

      if (!(numberOfReRenders < RE_RENDER_LIMIT)) {
        {
          throw Error( "Too many re-renders. React limits the number of renders to prevent an infinite loop." );
        }
      }

      numberOfReRenders += 1;

      {
        // Even when hot reloading, allow dependencies to stabilize
        // after first render to prevent infinite render phase updates.
        ignorePreviousDependencies = false;
      } // Start over from the beginning of the list


      currentHook = null;
      workInProgressHook = null;
      workInProgress.updateQueue = null;

      {
        // Also validate hook order for cascading updates.
        hookTypesUpdateIndexDev = -1;
      }

      ReactCurrentDispatcher.current =  HooksDispatcherOnRerenderInDEV ;
      children = Component(props, secondArg);
    } while (workInProgress.expirationTime === renderExpirationTime);
  } // We can assume the previous dispatcher is always this one, since we set it
  // at the beginning of the render phase and there's no re-entrancy.


  ReactCurrentDispatcher.current = ContextOnlyDispatcher;

  {
    workInProgress._debugHookTypes = hookTypesDev;
  } // This check uses currentHook so that it works the same in DEV and prod bundles.
  // hookTypesDev could catch more cases (e.g. context) but only in DEV bundles.


  var didRenderTooFewHooks = currentHook !== null && currentHook.next !== null;
  renderExpirationTime = NoWork;
  currentlyRenderingFiber$1 = null;
  currentHook = null;
  workInProgressHook = null;

  {
    currentHookNameInDev = null;
    hookTypesDev = null;
    hookTypesUpdateIndexDev = -1;
  }

  didScheduleRenderPhaseUpdate = false;

  if (!!didRenderTooFewHooks) {
    {
      throw Error( "Rendered fewer hooks than expected. This may be caused by an accidental early return statement." );
    }
  }

  return children;
}
function bailoutHooks(current, workInProgress, expirationTime) {
  workInProgress.updateQueue = current.updateQueue;
  workInProgress.effectTag &= ~(Passive | Update);

  if (current.expirationTime <= expirationTime) {
    current.expirationTime = NoWork;
  }
}
function resetHooksAfterThrow() {
  // We can assume the previous dispatcher is always this one, since we set it
  // at the beginning of the render phase and there's no re-entrancy.
  ReactCurrentDispatcher.current = ContextOnlyDispatcher;

  if (didScheduleRenderPhaseUpdate) {
    // There were render phase updates. These are only valid for this render
    // phase, which we are now aborting. Remove the updates from the queues so
    // they do not persist to the next render. Do not remove updates from hooks
    // that weren't processed.
    //
    // Only reset the updates from the queue if it has a clone. If it does
    // not have a clone, that means it wasn't processed, and the updates were
    // scheduled before we entered the render phase.
    var hook = currentlyRenderingFiber$1.memoizedState;

    while (hook !== null) {
      var queue = hook.queue;

      if (queue !== null) {
        queue.pending = null;
      }

      hook = hook.next;
    }
  }

  renderExpirationTime = NoWork;
  currentlyRenderingFiber$1 = null;
  currentHook = null;
  workInProgressHook = null;

  {
    hookTypesDev = null;
    hookTypesUpdateIndexDev = -1;
    currentHookNameInDev = null;
  }

  didScheduleRenderPhaseUpdate = false;
}

function mountWorkInProgressHook() {
  var hook = {
    memoizedState: null,
    baseState: null,
    baseQueue: null,
    queue: null,
    next: null
  };

  if (workInProgressHook === null) {
    // This is the first hook in the list
    currentlyRenderingFiber$1.memoizedState = workInProgressHook = hook;
  } else {
    // Append to the end of the list
    workInProgressHook = workInProgressHook.next = hook;
  }

  return workInProgressHook;
}

function updateWorkInProgressHook() {
  // This function is used both for updates and for re-renders triggered by a
  // render phase update. It assumes there is either a current hook we can
  // clone, or a work-in-progress hook from a previous render pass that we can
  // use as a base. When we reach the end of the base list, we must switch to
  // the dispatcher used for mounts.
  var nextCurrentHook;

  if (currentHook === null) {
    var current = currentlyRenderingFiber$1.alternate;

    if (current !== null) {
      nextCurrentHook = current.memoizedState;
    } else {
      nextCurrentHook = null;
    }
  } else {
    nextCurrentHook = currentHook.next;
  }

  var nextWorkInProgressHook;

  if (workInProgressHook === null) {
    nextWorkInProgressHook = currentlyRenderingFiber$1.memoizedState;
  } else {
    nextWorkInProgressHook = workInProgressHook.next;
  }

  if (nextWorkInProgressHook !== null) {
    // There's already a work-in-progress. Reuse it.
    workInProgressHook = nextWorkInProgressHook;
    nextWorkInProgressHook = workInProgressHook.next;
    currentHook = nextCurrentHook;
  } else {
    // Clone from the current hook.
    if (!(nextCurrentHook !== null)) {
      {
        throw Error( "Rendered more hooks than during the previous render." );
      }
    }

    currentHook = nextCurrentHook;
    var newHook = {
      memoizedState: currentHook.memoizedState,
      baseState: currentHook.baseState,
      baseQueue: currentHook.baseQueue,
      queue: currentHook.queue,
      next: null
    };

    if (workInProgressHook === null) {
      // This is the first hook in the list.
      currentlyRenderingFiber$1.memoizedState = workInProgressHook = newHook;
    } else {
      // Append to the end of the list.
      workInProgressHook = workInProgressHook.next = newHook;
    }
  }

  return workInProgressHook;
}

function createFunctionComponentUpdateQueue() {
  return {
    lastEffect: null
  };
}

function basicStateReducer(state, action) {
  // $FlowFixMe: Flow doesn't like mixed types
  return typeof action === 'function' ? action(state) : action;
}

function mountReducer(reducer, initialArg, init) {
  var hook = mountWorkInProgressHook();
  var initialState;

  if (init !== undefined) {
    initialState = init(initialArg);
  } else {
    initialState = initialArg;
  }

  hook.memoizedState = hook.baseState = initialState;
  var queue = hook.queue = {
    pending: null,
    dispatch: null,
    lastRenderedReducer: reducer,
    lastRenderedState: initialState
  };
  var dispatch = queue.dispatch = dispatchAction.bind(null, currentlyRenderingFiber$1, queue);
  return [hook.memoizedState, dispatch];
}

function updateReducer(reducer, initialArg, init) {
  var hook = updateWorkInProgressHook();
  var queue = hook.queue;

  if (!(queue !== null)) {
    {
      throw Error( "Should have a queue. This is likely a bug in React. Please file an issue." );
    }
  }

  queue.lastRenderedReducer = reducer;
  var current = currentHook; // The last rebase update that is NOT part of the base state.

  var baseQueue = current.baseQueue; // The last pending update that hasn't been processed yet.

  var pendingQueue = queue.pending;

  if (pendingQueue !== null) {
    // We have new updates that haven't been processed yet.
    // We'll add them to the base queue.
    if (baseQueue !== null) {
      // Merge the pending queue and the base queue.
      var baseFirst = baseQueue.next;
      var pendingFirst = pendingQueue.next;
      baseQueue.next = pendingFirst;
      pendingQueue.next = baseFirst;
    }

    current.baseQueue = baseQueue = pendingQueue;
    queue.pending = null;
  }

  if (baseQueue !== null) {
    // We have a queue to process.
    var first = baseQueue.next;
    var newState = current.baseState;
    var newBaseState = null;
    var newBaseQueueFirst = null;
    var newBaseQueueLast = null;
    var update = first;

    do {
      var updateExpirationTime = update.expirationTime;

      if (updateExpirationTime < renderExpirationTime) {
        // Priority is insufficient. Skip this update. If this is the first
        // skipped update, the previous update/state is the new base
        // update/state.
        var clone = {
          expirationTime: update.expirationTime,
          suspenseConfig: update.suspenseConfig,
          action: update.action,
          eagerReducer: update.eagerReducer,
          eagerState: update.eagerState,
          next: null
        };

        if (newBaseQueueLast === null) {
          newBaseQueueFirst = newBaseQueueLast = clone;
          newBaseState = newState;
        } else {
          newBaseQueueLast = newBaseQueueLast.next = clone;
        } // Update the remaining priority in the queue.


        if (updateExpirationTime > currentlyRenderingFiber$1.expirationTime) {
          currentlyRenderingFiber$1.expirationTime = updateExpirationTime;
          markUnprocessedUpdateTime(updateExpirationTime);
        }
      } else {
        // This update does have sufficient priority.
        if (newBaseQueueLast !== null) {
          var _clone = {
            expirationTime: Sync,
            // This update is going to be committed so we never want uncommit it.
            suspenseConfig: update.suspenseConfig,
            action: update.action,
            eagerReducer: update.eagerReducer,
            eagerState: update.eagerState,
            next: null
          };
          newBaseQueueLast = newBaseQueueLast.next = _clone;
        } // Mark the event time of this update as relevant to this render pass.
        // TODO: This should ideally use the true event time of this update rather than
        // its priority which is a derived and not reverseable value.
        // TODO: We should skip this update if it was already committed but currently
        // we have no way of detecting the difference between a committed and suspended
        // update here.


        markRenderEventTimeAndConfig(updateExpirationTime, update.suspenseConfig); // Process this update.

        if (update.eagerReducer === reducer) {
          // If this update was processed eagerly, and its reducer matches the
          // current reducer, we can use the eagerly computed state.
          newState = update.eagerState;
        } else {
          var action = update.action;
          newState = reducer(newState, action);
        }
      }

      update = update.next;
    } while (update !== null && update !== first);

    if (newBaseQueueLast === null) {
      newBaseState = newState;
    } else {
      newBaseQueueLast.next = newBaseQueueFirst;
    } // Mark that the fiber performed work, but only if the new state is
    // different from the current state.


    if (!objectIs(newState, hook.memoizedState)) {
      markWorkInProgressReceivedUpdate();
    }

    hook.memoizedState = newState;
    hook.baseState = newBaseState;
    hook.baseQueue = newBaseQueueLast;
    queue.lastRenderedState = newState;
  }

  var dispatch = queue.dispatch;
  return [hook.memoizedState, dispatch];
}

function rerenderReducer(reducer, initialArg, init) {
  var hook = updateWorkInProgressHook();
  var queue = hook.queue;

  if (!(queue !== null)) {
    {
      throw Error( "Should have a queue. This is likely a bug in React. Please file an issue." );
    }
  }

  queue.lastRenderedReducer = reducer; // This is a re-render. Apply the new render phase updates to the previous
  // work-in-progress hook.

  var dispatch = queue.dispatch;
  var lastRenderPhaseUpdate = queue.pending;
  var newState = hook.memoizedState;

  if (lastRenderPhaseUpdate !== null) {
    // The queue doesn't persist past this render pass.
    queue.pending = null;
    var firstRenderPhaseUpdate = lastRenderPhaseUpdate.next;
    var update = firstRenderPhaseUpdate;

    do {
      // Process this render phase update. We don't have to check the
      // priority because it will always be the same as the current
      // render's.
      var action = update.action;
      newState = reducer(newState, action);
      update = update.next;
    } while (update !== firstRenderPhaseUpdate); // Mark that the fiber performed work, but only if the new state is
    // different from the current state.


    if (!objectIs(newState, hook.memoizedState)) {
      markWorkInProgressReceivedUpdate();
    }

    hook.memoizedState = newState; // Don't persist the state accumulated from the render phase updates to
    // the base state unless the queue is empty.
    // TODO: Not sure if this is the desired semantics, but it's what we
    // do for gDSFP. I can't remember why.

    if (hook.baseQueue === null) {
      hook.baseState = newState;
    }

    queue.lastRenderedState = newState;
  }

  return [newState, dispatch];
}

function mountState(initialState) {
  var hook = mountWorkInProgressHook();

  if (typeof initialState === 'function') {
    // $FlowFixMe: Flow doesn't like mixed types
    initialState = initialState();
  }

  hook.memoizedState = hook.baseState = initialState;
  var queue = hook.queue = {
    pending: null,
    dispatch: null,
    lastRenderedReducer: basicStateReducer,
    lastRenderedState: initialState
  };
  var dispatch = queue.dispatch = dispatchAction.bind(null, currentlyRenderingFiber$1, queue);
  return [hook.memoizedState, dispatch];
}

function updateState(initialState) {
  return updateReducer(basicStateReducer);
}

function rerenderState(initialState) {
  return rerenderReducer(basicStateReducer);
}

function pushEffect(tag, create, destroy, deps) {
  var effect = {
    tag: tag,
    create: create,
    destroy: destroy,
    deps: deps,
    // Circular
    next: null
  };
  var componentUpdateQueue = currentlyRenderingFiber$1.updateQueue;

  if (componentUpdateQueue === null) {
    componentUpdateQueue = createFunctionComponentUpdateQueue();
    currentlyRenderingFiber$1.updateQueue = componentUpdateQueue;
    componentUpdateQueue.lastEffect = effect.next = effect;
  } else {
    var lastEffect = componentUpdateQueue.lastEffect;

    if (lastEffect === null) {
      componentUpdateQueue.lastEffect = effect.next = effect;
    } else {
      var firstEffect = lastEffect.next;
      lastEffect.next = effect;
      effect.next = firstEffect;
      componentUpdateQueue.lastEffect = effect;
    }
  }

  return effect;
}

function mountRef(initialValue) {
  var hook = mountWorkInProgressHook();
  var ref = {
    current: initialValue
  };

  {
    Object.seal(ref);
  }

  hook.memoizedState = ref;
  return ref;
}

function updateRef(initialValue) {
  var hook = updateWorkInProgressHook();
  return hook.memoizedState;
}

function mountEffectImpl(fiberEffectTag, hookEffectTag, create, deps) {
  var hook = mountWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  currentlyRenderingFiber$1.effectTag |= fiberEffectTag;
  hook.memoizedState = pushEffect(HasEffect | hookEffectTag, create, undefined, nextDeps);
}

function updateEffectImpl(fiberEffectTag, hookEffectTag, create, deps) {
  var hook = updateWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  var destroy = undefined;

  if (currentHook !== null) {
    var prevEffect = currentHook.memoizedState;
    destroy = prevEffect.destroy;

    if (nextDeps !== null) {
      var prevDeps = prevEffect.deps;

      if (areHookInputsEqual(nextDeps, prevDeps)) {
        pushEffect(hookEffectTag, create, destroy, nextDeps);
        return;
      }
    }
  }

  currentlyRenderingFiber$1.effectTag |= fiberEffectTag;
  hook.memoizedState = pushEffect(HasEffect | hookEffectTag, create, destroy, nextDeps);
}

function mountEffect(create, deps) {
  {
    // $FlowExpectedError - jest isn't a global, and isn't recognized outside of tests
    if ('undefined' !== typeof jest) {
      warnIfNotCurrentlyActingEffectsInDEV(currentlyRenderingFiber$1);
    }
  }

  return mountEffectImpl(Update | Passive, Passive$1, create, deps);
}

function updateEffect(create, deps) {
  {
    // $FlowExpectedError - jest isn't a global, and isn't recognized outside of tests
    if ('undefined' !== typeof jest) {
      warnIfNotCurrentlyActingEffectsInDEV(currentlyRenderingFiber$1);
    }
  }

  return updateEffectImpl(Update | Passive, Passive$1, create, deps);
}

function mountLayoutEffect(create, deps) {
  return mountEffectImpl(Update, Layout, create, deps);
}

function updateLayoutEffect(create, deps) {
  return updateEffectImpl(Update, Layout, create, deps);
}

function imperativeHandleEffect(create, ref) {
  if (typeof ref === 'function') {
    var refCallback = ref;

    var _inst = create();

    refCallback(_inst);
    return function () {
      refCallback(null);
    };
  } else if (ref !== null && ref !== undefined) {
    var refObject = ref;

    {
      if (!refObject.hasOwnProperty('current')) {
        error('Expected useImperativeHandle() first argument to either be a ' + 'ref callback or React.createRef() object. Instead received: %s.', 'an object with keys {' + Object.keys(refObject).join(', ') + '}');
      }
    }

    var _inst2 = create();

    refObject.current = _inst2;
    return function () {
      refObject.current = null;
    };
  }
}

function mountImperativeHandle(ref, create, deps) {
  {
    if (typeof create !== 'function') {
      error('Expected useImperativeHandle() second argument to be a function ' + 'that creates a handle. Instead received: %s.', create !== null ? typeof create : 'null');
    }
  } // TODO: If deps are provided, should we skip comparing the ref itself?


  var effectDeps = deps !== null && deps !== undefined ? deps.concat([ref]) : null;
  return mountEffectImpl(Update, Layout, imperativeHandleEffect.bind(null, create, ref), effectDeps);
}

function updateImperativeHandle(ref, create, deps) {
  {
    if (typeof create !== 'function') {
      error('Expected useImperativeHandle() second argument to be a function ' + 'that creates a handle. Instead received: %s.', create !== null ? typeof create : 'null');
    }
  } // TODO: If deps are provided, should we skip comparing the ref itself?


  var effectDeps = deps !== null && deps !== undefined ? deps.concat([ref]) : null;
  return updateEffectImpl(Update, Layout, imperativeHandleEffect.bind(null, create, ref), effectDeps);
}

function mountDebugValue(value, formatterFn) {// This hook is normally a no-op.
  // The react-debug-hooks package injects its own implementation
  // so that e.g. DevTools can display custom hook values.
}

var updateDebugValue = mountDebugValue;

function mountCallback(callback, deps) {
  var hook = mountWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  hook.memoizedState = [callback, nextDeps];
  return callback;
}

function updateCallback(callback, deps) {
  var hook = updateWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  var prevState = hook.memoizedState;

  if (prevState !== null) {
    if (nextDeps !== null) {
      var prevDeps = prevState[1];

      if (areHookInputsEqual(nextDeps, prevDeps)) {
        return prevState[0];
      }
    }
  }

  hook.memoizedState = [callback, nextDeps];
  return callback;
}

function mountMemo(nextCreate, deps) {
  var hook = mountWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  var nextValue = nextCreate();
  hook.memoizedState = [nextValue, nextDeps];
  return nextValue;
}

function updateMemo(nextCreate, deps) {
  var hook = updateWorkInProgressHook();
  var nextDeps = deps === undefined ? null : deps;
  var prevState = hook.memoizedState;

  if (prevState !== null) {
    // Assume these are defined. If they're not, areHookInputsEqual will warn.
    if (nextDeps !== null) {
      var prevDeps = prevState[1];

      if (areHookInputsEqual(nextDeps, prevDeps)) {
        return prevState[0];
      }
    }
  }

  var nextValue = nextCreate();
  hook.memoizedState = [nextValue, nextDeps];
  return nextValue;
}

function mountDeferredValue(value, config) {
  var _mountState = mountState(value),
      prevValue = _mountState[0],
      setValue = _mountState[1];

  mountEffect(function () {
    var previousConfig = ReactCurrentBatchConfig$1.suspense;
    ReactCurrentBatchConfig$1.suspense = config === undefined ? null : config;

    try {
      setValue(value);
    } finally {
      ReactCurrentBatchConfig$1.suspense = previousConfig;
    }
  }, [value, config]);
  return prevValue;
}

function updateDeferredValue(value, config) {
  var _updateState = updateState(),
      prevValue = _updateState[0],
      setValue = _updateState[1];

  updateEffect(function () {
    var previousConfig = ReactCurrentBatchConfig$1.suspense;
    ReactCurrentBatchConfig$1.suspense = config === undefined ? null : config;

    try {
      setValue(value);
    } finally {
      ReactCurrentBatchConfig$1.suspense = previousConfig;
    }
  }, [value, config]);
  return prevValue;
}

function rerenderDeferredValue(value, config) {
  var _rerenderState = rerenderState(),
      prevValue = _rerenderState[0],
      setValue = _rerenderState[1];

  updateEffect(function () {
    var previousConfig = ReactCurrentBatchConfig$1.suspense;
    ReactCurrentBatchConfig$1.suspense = config === undefined ? null : config;

    try {
      setValue(value);
    } finally {
      ReactCurrentBatchConfig$1.suspense = previousConfig;
    }
  }, [value, config]);
  return prevValue;
}

function startTransition(setPending, config, callback) {
  var priorityLevel = getCurrentPriorityLevel();
  runWithPriority(priorityLevel < UserBlockingPriority ? UserBlockingPriority : priorityLevel, function () {
    setPending(true);
  });
  runWithPriority(priorityLevel > NormalPriority ? NormalPriority : priorityLevel, function () {
    var previousConfig = ReactCurrentBatchConfig$1.suspense;
    ReactCurrentBatchConfig$1.suspense = config === undefined ? null : config;

    try {
      setPending(false);
      callback();
    } finally {
      ReactCurrentBatchConfig$1.suspense = previousConfig;
    }
  });
}

function mountTransition(config) {
  var _mountState2 = mountState(false),
      isPending = _mountState2[0],
      setPending = _mountState2[1];

  var start = mountCallback(startTransition.bind(null, setPending, config), [setPending, config]);
  return [start, isPending];
}

function updateTransition(config) {
  var _updateState2 = updateState(),
      isPending = _updateState2[0],
      setPending = _updateState2[1];

  var start = updateCallback(startTransition.bind(null, setPending, config), [setPending, config]);
  return [start, isPending];
}

function rerenderTransition(config) {
  var _rerenderState2 = rerenderState(),
      isPending = _rerenderState2[0],
      setPending = _rerenderState2[1];

  var start = updateCallback(startTransition.bind(null, setPending, config), [setPending, config]);
  return [start, isPending];
}

function dispatchAction(fiber, queue, action) {
  {
    if (typeof arguments[3] === 'function') {
      error("State updates from the useState() and useReducer() Hooks don't support the " + 'second callback argument. To execute a side effect after ' + 'rendering, declare it in the component body with useEffect().');
    }
  }

  var currentTime = requestCurrentTimeForUpdate();
  var suspenseConfig = requestCurrentSuspenseConfig();
  var expirationTime = computeExpirationForFiber(currentTime, fiber, suspenseConfig);
  var update = {
    expirationTime: expirationTime,
    suspenseConfig: suspenseConfig,
    action: action,
    eagerReducer: null,
    eagerState: null,
    next: null
  };

  {
    update.priority = getCurrentPriorityLevel();
  } // Append the update to the end of the list.


  var pending = queue.pending;

  if (pending === null) {
    // This is the first update. Create a circular list.
    update.next = update;
  } else {
    update.next = pending.next;
    pending.next = update;
  }

  queue.pending = update;
  var alternate = fiber.alternate;

  if (fiber === currentlyRenderingFiber$1 || alternate !== null && alternate === currentlyRenderingFiber$1) {
    // This is a render phase update. Stash it in a lazily-created map of
    // queue -> linked list of updates. After this render pass, we'll restart
    // and apply the stashed updates on top of the work-in-progress hook.
    didScheduleRenderPhaseUpdate = true;
    update.expirationTime = renderExpirationTime;
    currentlyRenderingFiber$1.expirationTime = renderExpirationTime;
  } else {
    if (fiber.expirationTime === NoWork && (alternate === null || alternate.expirationTime === NoWork)) {
      // The queue is currently empty, which means we can eagerly compute the
      // next state before entering the render phase. If the new state is the
      // same as the current state, we may be able to bail out entirely.
      var lastRenderedReducer = queue.lastRenderedReducer;

      if (lastRenderedReducer !== null) {
        var prevDispatcher;

        {
          prevDispatcher = ReactCurrentDispatcher.current;
          ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;
        }

        try {
          var currentState = queue.lastRenderedState;
          var eagerState = lastRenderedReducer(currentState, action); // Stash the eagerly computed state, and the reducer used to compute
          // it, on the update object. If the reducer hasn't changed by the
          // time we enter the render phase, then the eager state can be used
          // without calling the reducer again.

          update.eagerReducer = lastRenderedReducer;
          update.eagerState = eagerState;

          if (objectIs(eagerState, currentState)) {
            // Fast path. We can bail out without scheduling React to re-render.
            // It's still possible that we'll need to rebase this update later,
            // if the component re-renders for a different reason and by that
            // time the reducer has changed.
            return;
          }
        } catch (error) {// Suppress the error. It will throw again in the render phase.
        } finally {
          {
            ReactCurrentDispatcher.current = prevDispatcher;
          }
        }
      }
    }

    {
      // $FlowExpectedError - jest isn't a global, and isn't recognized outside of tests
      if ('undefined' !== typeof jest) {
        warnIfNotScopedWithMatchingAct(fiber);
        warnIfNotCurrentlyActingUpdatesInDev(fiber);
      }
    }

    scheduleWork(fiber, expirationTime);
  }
}

var ContextOnlyDispatcher = {
  readContext: readContext,
  useCallback: throwInvalidHookError,
  useContext: throwInvalidHookError,
  useEffect: throwInvalidHookError,
  useImperativeHandle: throwInvalidHookError,
  useLayoutEffect: throwInvalidHookError,
  useMemo: throwInvalidHookError,
  useReducer: throwInvalidHookError,
  useRef: throwInvalidHookError,
  useState: throwInvalidHookError,
  useDebugValue: throwInvalidHookError,
  useResponder: throwInvalidHookError,
  useDeferredValue: throwInvalidHookError,
  useTransition: throwInvalidHookError
};
var HooksDispatcherOnMountInDEV = null;
var HooksDispatcherOnMountWithHookTypesInDEV = null;
var HooksDispatcherOnUpdateInDEV = null;
var HooksDispatcherOnRerenderInDEV = null;
var InvalidNestedHooksDispatcherOnMountInDEV = null;
var InvalidNestedHooksDispatcherOnUpdateInDEV = null;
var InvalidNestedHooksDispatcherOnRerenderInDEV = null;

{
  var warnInvalidContextAccess = function () {
    error('Context can only be read while React is rendering. ' + 'In classes, you can read it in the render method or getDerivedStateFromProps. ' + 'In function components, you can read it directly in the function body, but not ' + 'inside Hooks like useReducer() or useMemo().');
  };

  var warnInvalidHookAccess = function () {
    error('Do not call Hooks inside useEffect(...), useMemo(...), or other built-in Hooks. ' + 'You can only call Hooks at the top level of your React function. ' + 'For more information, see ' + 'https://fb.me/rules-of-hooks');
  };

  HooksDispatcherOnMountInDEV = {
    readContext: function (context, observedBits) {
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      mountHookTypesDev();
      checkDepsAreArrayDev(deps);
      return mountCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      mountHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      mountHookTypesDev();
      checkDepsAreArrayDev(deps);
      return mountEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      mountHookTypesDev();
      checkDepsAreArrayDev(deps);
      return mountImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      mountHookTypesDev();
      checkDepsAreArrayDev(deps);
      return mountLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      mountHookTypesDev();
      checkDepsAreArrayDev(deps);
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      mountHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      mountHookTypesDev();
      return mountRef(initialValue);
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      mountHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      mountHookTypesDev();
      return mountDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      mountHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      mountHookTypesDev();
      return mountDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      mountHookTypesDev();
      return mountTransition(config);
    }
  };
  HooksDispatcherOnMountWithHookTypesInDEV = {
    readContext: function (context, observedBits) {
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      updateHookTypesDev();
      return mountCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      updateHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      updateHookTypesDev();
      return mountEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      updateHookTypesDev();
      return mountImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      updateHookTypesDev();
      return mountLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      updateHookTypesDev();
      return mountRef(initialValue);
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      updateHookTypesDev();
      return mountDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      updateHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      updateHookTypesDev();
      return mountDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      updateHookTypesDev();
      return mountTransition(config);
    }
  };
  HooksDispatcherOnUpdateInDEV = {
    readContext: function (context, observedBits) {
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      updateHookTypesDev();
      return updateCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      updateHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      updateHookTypesDev();
      return updateEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      updateHookTypesDev();
      return updateImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      updateHookTypesDev();
      return updateLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      updateHookTypesDev();
      return updateRef();
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      updateHookTypesDev();
      return updateDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      updateHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      updateHookTypesDev();
      return updateDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      updateHookTypesDev();
      return updateTransition(config);
    }
  };
  HooksDispatcherOnRerenderInDEV = {
    readContext: function (context, observedBits) {
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      updateHookTypesDev();
      return updateCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      updateHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      updateHookTypesDev();
      return updateEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      updateHookTypesDev();
      return updateImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      updateHookTypesDev();
      return updateLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnRerenderInDEV;

      try {
        return updateMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnRerenderInDEV;

      try {
        return rerenderReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      updateHookTypesDev();
      return updateRef();
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnRerenderInDEV;

      try {
        return rerenderState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      updateHookTypesDev();
      return updateDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      updateHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      updateHookTypesDev();
      return rerenderDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      updateHookTypesDev();
      return rerenderTransition(config);
    }
  };
  InvalidNestedHooksDispatcherOnMountInDEV = {
    readContext: function (context, observedBits) {
      warnInvalidContextAccess();
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      warnInvalidHookAccess();
      mountHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      warnInvalidHookAccess();
      mountHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountRef(initialValue);
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      warnInvalidHookAccess();
      mountHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnMountInDEV;

      try {
        return mountState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      warnInvalidHookAccess();
      mountHookTypesDev();
      return mountTransition(config);
    }
  };
  InvalidNestedHooksDispatcherOnUpdateInDEV = {
    readContext: function (context, observedBits) {
      warnInvalidContextAccess();
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateRef();
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateTransition(config);
    }
  };
  InvalidNestedHooksDispatcherOnRerenderInDEV = {
    readContext: function (context, observedBits) {
      warnInvalidContextAccess();
      return readContext(context, observedBits);
    },
    useCallback: function (callback, deps) {
      currentHookNameInDev = 'useCallback';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateCallback(callback, deps);
    },
    useContext: function (context, observedBits) {
      currentHookNameInDev = 'useContext';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return readContext(context, observedBits);
    },
    useEffect: function (create, deps) {
      currentHookNameInDev = 'useEffect';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateEffect(create, deps);
    },
    useImperativeHandle: function (ref, create, deps) {
      currentHookNameInDev = 'useImperativeHandle';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateImperativeHandle(ref, create, deps);
    },
    useLayoutEffect: function (create, deps) {
      currentHookNameInDev = 'useLayoutEffect';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateLayoutEffect(create, deps);
    },
    useMemo: function (create, deps) {
      currentHookNameInDev = 'useMemo';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return updateMemo(create, deps);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useReducer: function (reducer, initialArg, init) {
      currentHookNameInDev = 'useReducer';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return rerenderReducer(reducer, initialArg, init);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useRef: function (initialValue) {
      currentHookNameInDev = 'useRef';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateRef();
    },
    useState: function (initialState) {
      currentHookNameInDev = 'useState';
      warnInvalidHookAccess();
      updateHookTypesDev();
      var prevDispatcher = ReactCurrentDispatcher.current;
      ReactCurrentDispatcher.current = InvalidNestedHooksDispatcherOnUpdateInDEV;

      try {
        return rerenderState(initialState);
      } finally {
        ReactCurrentDispatcher.current = prevDispatcher;
      }
    },
    useDebugValue: function (value, formatterFn) {
      currentHookNameInDev = 'useDebugValue';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return updateDebugValue();
    },
    useResponder: function (responder, props) {
      currentHookNameInDev = 'useResponder';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return createDeprecatedResponderListener(responder, props);
    },
    useDeferredValue: function (value, config) {
      currentHookNameInDev = 'useDeferredValue';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return rerenderDeferredValue(value, config);
    },
    useTransition: function (config) {
      currentHookNameInDev = 'useTransition';
      warnInvalidHookAccess();
      updateHookTypesDev();
      return rerenderTransition(config);
    }
  };
}

var now$2 = Scheduler.unstable_now;
var commitTime = 0;
var profilerStartTime = -1;

function getCommitTime() {
  return commitTime;
}

function recordCommitTime() {

  commitTime = now$2();
}

function startProfilerTimer(fiber) {

  profilerStartTime = now$2();

  if (fiber.actualStartTime < 0) {
    fiber.actualStartTime = now$2();
  }
}

function stopProfilerTimerIfRunning(fiber) {

  profilerStartTime = -1;
}

function stopProfilerTimerIfRunningAndRecordDelta(fiber, overrideBaseTime) {

  if (profilerStartTime >= 0) {
    var elapsedTime = now$2() - profilerStartTime;
    fiber.actualDuration += elapsedTime;

    if (overrideBaseTime) {
      fiber.selfBaseDuration = elapsedTime;
    }

    profilerStartTime = -1;
  }
}

// This may have been an insertion or a hydration.

var hydrationParentFiber = null;
var nextHydratableInstance = null;
var isHydrating = false;

function enterHydrationState(fiber) {
  if (!supportsHydration) {
    return false;
  }

  var parentInstance = fiber.stateNode.containerInfo;
  nextHydratableInstance = getFirstHydratableChild(parentInstance);
  hydrationParentFiber = fiber;
  isHydrating = true;
  return true;
}

function deleteHydratableInstance(returnFiber, instance) {
  {
    switch (returnFiber.tag) {
      case HostRoot:
        didNotHydrateContainerInstance(returnFiber.stateNode.containerInfo, instance);
        break;

      case HostComponent:
        didNotHydrateInstance(returnFiber.type, returnFiber.memoizedProps, returnFiber.stateNode, instance);
        break;
    }
  }

  var childToDelete = createFiberFromHostInstanceForDeletion();
  childToDelete.stateNode = instance;
  childToDelete.return = returnFiber;
  childToDelete.effectTag = Deletion; // This might seem like it belongs on progressedFirstDeletion. However,
  // these children are not part of the reconciliation list of children.
  // Even if we abort and rereconcile the children, that will try to hydrate
  // again and the nodes are still in the host tree so these will be
  // recreated.

  if (returnFiber.lastEffect !== null) {
    returnFiber.lastEffect.nextEffect = childToDelete;
    returnFiber.lastEffect = childToDelete;
  } else {
    returnFiber.firstEffect = returnFiber.lastEffect = childToDelete;
  }
}

function insertNonHydratedInstance(returnFiber, fiber) {
  fiber.effectTag = fiber.effectTag & ~Hydrating | Placement;

  {
    switch (returnFiber.tag) {
      case HostRoot:
        {
          var parentContainer = returnFiber.stateNode.containerInfo;

          switch (fiber.tag) {
            case HostComponent:
              var type = fiber.type;
              var props = fiber.pendingProps;
              didNotFindHydratableContainerInstance(parentContainer, type, props);
              break;

            case HostText:
              var text = fiber.pendingProps;
              didNotFindHydratableContainerTextInstance(parentContainer, text);
              break;

            case SuspenseComponent:
              didNotFindHydratableContainerSuspenseInstance(parentContainer);
              break;
          }

          break;
        }

      case HostComponent:
        {
          var parentType = returnFiber.type;
          var parentProps = returnFiber.memoizedProps;
          var parentInstance = returnFiber.stateNode;

          switch (fiber.tag) {
            case HostComponent:
              var _type = fiber.type;
              var _props = fiber.pendingProps;
              didNotFindHydratableInstance(parentType, parentProps, parentInstance, _type, _props);
              break;

            case HostText:
              var _text = fiber.pendingProps;
              didNotFindHydratableTextInstance(parentType, parentProps, parentInstance, _text);
              break;

            case SuspenseComponent:
              didNotFindHydratableSuspenseInstance(parentType, parentProps, parentInstance);
              break;
          }

          break;
        }

      default:
        return;
    }
  }
}

function tryHydrate(fiber, nextInstance) {
  switch (fiber.tag) {
    case HostComponent:
      {
        var type = fiber.type;
        var props = fiber.pendingProps;
        var instance = canHydrateInstance(nextInstance, type, props);

        if (instance !== null) {
          fiber.stateNode = instance;
          return true;
        }

        return false;
      }

    case HostText:
      {
        var text = fiber.pendingProps;
        var textInstance = canHydrateTextInstance(nextInstance, text);

        if (textInstance !== null) {
          fiber.stateNode = textInstance;
          return true;
        }

        return false;
      }

    case SuspenseComponent:
      {

        return false;
      }

    default:
      return false;
  }
}

function tryToClaimNextHydratableInstance(fiber) {
  if (!isHydrating) {
    return;
  }

  var nextInstance = nextHydratableInstance;

  if (!nextInstance) {
    // Nothing to hydrate. Make it an insertion.
    insertNonHydratedInstance(hydrationParentFiber, fiber);
    isHydrating = false;
    hydrationParentFiber = fiber;
    return;
  }

  var firstAttemptedInstance = nextInstance;

  if (!tryHydrate(fiber, nextInstance)) {
    // If we can't hydrate this instance let's try the next one.
    // We use this as a heuristic. It's based on intuition and not data so it
    // might be flawed or unnecessary.
    nextInstance = getNextHydratableSibling(firstAttemptedInstance);

    if (!nextInstance || !tryHydrate(fiber, nextInstance)) {
      // Nothing to hydrate. Make it an insertion.
      insertNonHydratedInstance(hydrationParentFiber, fiber);
      isHydrating = false;
      hydrationParentFiber = fiber;
      return;
    } // We matched the next one, we'll now assume that the first one was
    // superfluous and we'll delete it. Since we can't eagerly delete it
    // we'll have to schedule a deletion. To do that, this node needs a dummy
    // fiber associated with it.


    deleteHydratableInstance(hydrationParentFiber, firstAttemptedInstance);
  }

  hydrationParentFiber = fiber;
  nextHydratableInstance = getFirstHydratableChild(nextInstance);
}

function prepareToHydrateHostInstance(fiber, rootContainerInstance, hostContext) {
  if (!supportsHydration) {
    {
      {
        throw Error( "Expected prepareToHydrateHostInstance() to never be called. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  }

  var instance = fiber.stateNode;
  var updatePayload = hydrateInstance(instance, fiber.type, fiber.memoizedProps, rootContainerInstance, hostContext, fiber); // TODO: Type this specific to this type of component.

  fiber.updateQueue = updatePayload; // If the update payload indicates that there is a change or if there
  // is a new ref we mark this as an update.

  if (updatePayload !== null) {
    return true;
  }

  return false;
}

function prepareToHydrateHostTextInstance(fiber) {
  if (!supportsHydration) {
    {
      {
        throw Error( "Expected prepareToHydrateHostTextInstance() to never be called. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  }

  var textInstance = fiber.stateNode;
  var textContent = fiber.memoizedProps;
  var shouldUpdate = hydrateTextInstance(textInstance, textContent, fiber);

  {
    if (shouldUpdate) {
      // We assume that prepareToHydrateHostTextInstance is called in a context where the
      // hydration parent is the parent host component of this host text.
      var returnFiber = hydrationParentFiber;

      if (returnFiber !== null) {
        switch (returnFiber.tag) {
          case HostRoot:
            {
              var parentContainer = returnFiber.stateNode.containerInfo;
              didNotMatchHydratedContainerTextInstance(parentContainer, textInstance, textContent);
              break;
            }

          case HostComponent:
            {
              var parentType = returnFiber.type;
              var parentProps = returnFiber.memoizedProps;
              var parentInstance = returnFiber.stateNode;
              didNotMatchHydratedTextInstance(parentType, parentProps, parentInstance, textInstance, textContent);
              break;
            }
        }
      }
    }
  }

  return shouldUpdate;
}

function skipPastDehydratedSuspenseInstance(fiber) {
  if (!supportsHydration) {
    {
      {
        throw Error( "Expected skipPastDehydratedSuspenseInstance() to never be called. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  }

  var suspenseState = fiber.memoizedState;
  var suspenseInstance = suspenseState !== null ? suspenseState.dehydrated : null;

  if (!suspenseInstance) {
    {
      throw Error( "Expected to have a hydrated suspense instance. This error is likely caused by a bug in React. Please file an issue." );
    }
  }

  return getNextHydratableInstanceAfterSuspenseInstance(suspenseInstance);
}

function popToNextHostParent(fiber) {
  var parent = fiber.return;

  while (parent !== null && parent.tag !== HostComponent && parent.tag !== HostRoot && parent.tag !== SuspenseComponent) {
    parent = parent.return;
  }

  hydrationParentFiber = parent;
}

function popHydrationState(fiber) {
  if (!supportsHydration) {
    return false;
  }

  if (fiber !== hydrationParentFiber) {
    // We're deeper than the current hydration context, inside an inserted
    // tree.
    return false;
  }

  if (!isHydrating) {
    // If we're not currently hydrating but we're in a hydration context, then
    // we were an insertion and now need to pop up reenter hydration of our
    // siblings.
    popToNextHostParent(fiber);
    isHydrating = true;
    return false;
  }

  var type = fiber.type; // If we have any remaining hydratable nodes, we need to delete them now.
  // We only do this deeper than head and body since they tend to have random
  // other nodes in them. We also ignore components with pure text content in
  // side of them.
  // TODO: Better heuristic.

  if (fiber.tag !== HostComponent || type !== 'head' && type !== 'body' && !shouldSetTextContent(type, fiber.memoizedProps)) {
    var nextInstance = nextHydratableInstance;

    while (nextInstance) {
      deleteHydratableInstance(fiber, nextInstance);
      nextInstance = getNextHydratableSibling(nextInstance);
    }
  }

  popToNextHostParent(fiber);

  if (fiber.tag === SuspenseComponent) {
    nextHydratableInstance = skipPastDehydratedSuspenseInstance(fiber);
  } else {
    nextHydratableInstance = hydrationParentFiber ? getNextHydratableSibling(fiber.stateNode) : null;
  }

  return true;
}

function resetHydrationState() {
  if (!supportsHydration) {
    return;
  }

  hydrationParentFiber = null;
  nextHydratableInstance = null;
  isHydrating = false;
}

var ReactCurrentOwner$1 = ReactSharedInternals.ReactCurrentOwner;
var didReceiveUpdate = false;
var didWarnAboutBadClass;
var didWarnAboutModulePatternComponent;
var didWarnAboutContextTypeOnFunctionComponent;
var didWarnAboutGetDerivedStateOnFunctionComponent;
var didWarnAboutFunctionRefs;
var didWarnAboutReassigningProps;
var didWarnAboutRevealOrder;
var didWarnAboutTailOptions;

{
  didWarnAboutBadClass = {};
  didWarnAboutModulePatternComponent = {};
  didWarnAboutContextTypeOnFunctionComponent = {};
  didWarnAboutGetDerivedStateOnFunctionComponent = {};
  didWarnAboutFunctionRefs = {};
  didWarnAboutReassigningProps = false;
  didWarnAboutRevealOrder = {};
  didWarnAboutTailOptions = {};
}

function reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime) {
  if (current === null) {
    // If this is a fresh new component that hasn't been rendered yet, we
    // won't update its child set by applying minimal side-effects. Instead,
    // we will add them all to the child before it gets rendered. That means
    // we can optimize this reconciliation pass by not tracking side-effects.
    workInProgress.child = mountChildFibers(workInProgress, null, nextChildren, renderExpirationTime);
  } else {
    // If the current child is the same as the work in progress, it means that
    // we haven't yet started any work on these children. Therefore, we use
    // the clone algorithm to create a copy of all the current children.
    // If we had any progressed work already, that is invalid at this point so
    // let's throw it out.
    workInProgress.child = reconcileChildFibers(workInProgress, current.child, nextChildren, renderExpirationTime);
  }
}

function forceUnmountCurrentAndReconcile(current, workInProgress, nextChildren, renderExpirationTime) {
  // This function is fork of reconcileChildren. It's used in cases where we
  // want to reconcile without matching against the existing set. This has the
  // effect of all current children being unmounted; even if the type and key
  // are the same, the old child is unmounted and a new child is created.
  //
  // To do this, we're going to go through the reconcile algorithm twice. In
  // the first pass, we schedule a deletion for all the current children by
  // passing null.
  workInProgress.child = reconcileChildFibers(workInProgress, current.child, null, renderExpirationTime); // In the second pass, we mount the new children. The trick here is that we
  // pass null in place of where we usually pass the current child set. This has
  // the effect of remounting all children regardless of whether their
  // identities match.

  workInProgress.child = reconcileChildFibers(workInProgress, null, nextChildren, renderExpirationTime);
}

function updateForwardRef(current, workInProgress, Component, nextProps, renderExpirationTime) {
  // TODO: current can be non-null here even if the component
  // hasn't yet mounted. This happens after the first render suspends.
  // We'll need to figure out if this is fine or can cause issues.
  {
    if (workInProgress.type !== workInProgress.elementType) {
      // Lazy component props can't be validated in createElement
      // because they're only guaranteed to be resolved here.
      var innerPropTypes = Component.propTypes;

      if (innerPropTypes) {
        checkPropTypes(innerPropTypes, nextProps, // Resolved props
        'prop', getComponentName(Component), getCurrentFiberStackInDev);
      }
    }
  }

  var render = Component.render;
  var ref = workInProgress.ref; // The rest is a fork of updateFunctionComponent

  var nextChildren;
  prepareToReadContext(workInProgress, renderExpirationTime);

  {
    ReactCurrentOwner$1.current = workInProgress;
    setIsRendering(true);
    nextChildren = renderWithHooks(current, workInProgress, render, nextProps, ref, renderExpirationTime);

    if ( workInProgress.mode & StrictMode) {
      // Only double-render components with Hooks
      if (workInProgress.memoizedState !== null) {
        nextChildren = renderWithHooks(current, workInProgress, render, nextProps, ref, renderExpirationTime);
      }
    }

    setIsRendering(false);
  }

  if (current !== null && !didReceiveUpdate) {
    bailoutHooks(current, workInProgress, renderExpirationTime);
    return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;
  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function updateMemoComponent(current, workInProgress, Component, nextProps, updateExpirationTime, renderExpirationTime) {
  if (current === null) {
    var type = Component.type;

    if (isSimpleFunctionComponent(type) && Component.compare === null && // SimpleMemoComponent codepath doesn't resolve outer props either.
    Component.defaultProps === undefined) {
      var resolvedType = type;

      {
        resolvedType = resolveFunctionForHotReloading(type);
      } // If this is a plain function component without default props,
      // and with only the default shallow comparison, we upgrade it
      // to a SimpleMemoComponent to allow fast path updates.


      workInProgress.tag = SimpleMemoComponent;
      workInProgress.type = resolvedType;

      {
        validateFunctionComponentInDev(workInProgress, type);
      }

      return updateSimpleMemoComponent(current, workInProgress, resolvedType, nextProps, updateExpirationTime, renderExpirationTime);
    }

    {
      var innerPropTypes = type.propTypes;

      if (innerPropTypes) {
        // Inner memo component props aren't currently validated in createElement.
        // We could move it there, but we'd still need this for lazy code path.
        checkPropTypes(innerPropTypes, nextProps, // Resolved props
        'prop', getComponentName(type), getCurrentFiberStackInDev);
      }
    }

    var child = createFiberFromTypeAndProps(Component.type, null, nextProps, null, workInProgress.mode, renderExpirationTime);
    child.ref = workInProgress.ref;
    child.return = workInProgress;
    workInProgress.child = child;
    return child;
  }

  {
    var _type = Component.type;
    var _innerPropTypes = _type.propTypes;

    if (_innerPropTypes) {
      // Inner memo component props aren't currently validated in createElement.
      // We could move it there, but we'd still need this for lazy code path.
      checkPropTypes(_innerPropTypes, nextProps, // Resolved props
      'prop', getComponentName(_type), getCurrentFiberStackInDev);
    }
  }

  var currentChild = current.child; // This is always exactly one child

  if (updateExpirationTime < renderExpirationTime) {
    // This will be the props with resolved defaultProps,
    // unlike current.memoizedProps which will be the unresolved ones.
    var prevProps = currentChild.memoizedProps; // Default to shallow comparison

    var compare = Component.compare;
    compare = compare !== null ? compare : shallowEqual;

    if (compare(prevProps, nextProps) && current.ref === workInProgress.ref) {
      return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
    }
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;
  var newChild = createWorkInProgress(currentChild, nextProps);
  newChild.ref = workInProgress.ref;
  newChild.return = workInProgress;
  workInProgress.child = newChild;
  return newChild;
}

function updateSimpleMemoComponent(current, workInProgress, Component, nextProps, updateExpirationTime, renderExpirationTime) {
  // TODO: current can be non-null here even if the component
  // hasn't yet mounted. This happens when the inner render suspends.
  // We'll need to figure out if this is fine or can cause issues.
  {
    if (workInProgress.type !== workInProgress.elementType) {
      // Lazy component props can't be validated in createElement
      // because they're only guaranteed to be resolved here.
      var outerMemoType = workInProgress.elementType;

      if (outerMemoType.$$typeof === REACT_LAZY_TYPE) {
        // We warn when you define propTypes on lazy()
        // so let's just skip over it to find memo() outer wrapper.
        // Inner props for memo are validated later.
        outerMemoType = refineResolvedLazyComponent(outerMemoType);
      }

      var outerPropTypes = outerMemoType && outerMemoType.propTypes;

      if (outerPropTypes) {
        checkPropTypes(outerPropTypes, nextProps, // Resolved (SimpleMemoComponent has no defaultProps)
        'prop', getComponentName(outerMemoType), getCurrentFiberStackInDev);
      } // Inner propTypes will be validated in the function component path.

    }
  }

  if (current !== null) {
    var prevProps = current.memoizedProps;

    if (shallowEqual(prevProps, nextProps) && current.ref === workInProgress.ref && ( // Prevent bailout if the implementation changed due to hot reload.
     workInProgress.type === current.type )) {
      didReceiveUpdate = false;

      if (updateExpirationTime < renderExpirationTime) {
        // The pending update priority was cleared at the beginning of
        // beginWork. We're about to bail out, but there might be additional
        // updates at a lower priority. Usually, the priority level of the
        // remaining updates is accumlated during the evaluation of the
        // component (i.e. when processing the update queue). But since since
        // we're bailing out early *without* evaluating the component, we need
        // to account for it here, too. Reset to the value of the current fiber.
        // NOTE: This only applies to SimpleMemoComponent, not MemoComponent,
        // because a MemoComponent fiber does not have hooks or an update queue;
        // rather, it wraps around an inner component, which may or may not
        // contains hooks.
        // TODO: Move the reset at in beginWork out of the common path so that
        // this is no longer necessary.
        workInProgress.expirationTime = current.expirationTime;
        return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
      }
    }
  }

  return updateFunctionComponent(current, workInProgress, Component, nextProps, renderExpirationTime);
}

function updateFragment(current, workInProgress, renderExpirationTime) {
  var nextChildren = workInProgress.pendingProps;
  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function updateMode(current, workInProgress, renderExpirationTime) {
  var nextChildren = workInProgress.pendingProps.children;
  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function updateProfiler(current, workInProgress, renderExpirationTime) {
  {
    workInProgress.effectTag |= Update;
  }

  var nextProps = workInProgress.pendingProps;
  var nextChildren = nextProps.children;
  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function markRef(current, workInProgress) {
  var ref = workInProgress.ref;

  if (current === null && ref !== null || current !== null && current.ref !== ref) {
    // Schedule a Ref effect
    workInProgress.effectTag |= Ref;
  }
}

function updateFunctionComponent(current, workInProgress, Component, nextProps, renderExpirationTime) {
  {
    if (workInProgress.type !== workInProgress.elementType) {
      // Lazy component props can't be validated in createElement
      // because they're only guaranteed to be resolved here.
      var innerPropTypes = Component.propTypes;

      if (innerPropTypes) {
        checkPropTypes(innerPropTypes, nextProps, // Resolved props
        'prop', getComponentName(Component), getCurrentFiberStackInDev);
      }
    }
  }

  var context;

  {
    var unmaskedContext = getUnmaskedContext(workInProgress, Component, true);
    context = getMaskedContext(workInProgress, unmaskedContext);
  }

  var nextChildren;
  prepareToReadContext(workInProgress, renderExpirationTime);

  {
    ReactCurrentOwner$1.current = workInProgress;
    setIsRendering(true);
    nextChildren = renderWithHooks(current, workInProgress, Component, nextProps, context, renderExpirationTime);

    if ( workInProgress.mode & StrictMode) {
      // Only double-render components with Hooks
      if (workInProgress.memoizedState !== null) {
        nextChildren = renderWithHooks(current, workInProgress, Component, nextProps, context, renderExpirationTime);
      }
    }

    setIsRendering(false);
  }

  if (current !== null && !didReceiveUpdate) {
    bailoutHooks(current, workInProgress, renderExpirationTime);
    return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;
  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function updateClassComponent(current, workInProgress, Component, nextProps, renderExpirationTime) {
  {
    if (workInProgress.type !== workInProgress.elementType) {
      // Lazy component props can't be validated in createElement
      // because they're only guaranteed to be resolved here.
      var innerPropTypes = Component.propTypes;

      if (innerPropTypes) {
        checkPropTypes(innerPropTypes, nextProps, // Resolved props
        'prop', getComponentName(Component), getCurrentFiberStackInDev);
      }
    }
  } // Push context providers early to prevent context stack mismatches.
  // During mounting we don't know the child context yet as the instance doesn't exist.
  // We will invalidate the child context in finishClassComponent() right after rendering.


  var hasContext;

  if (isContextProvider(Component)) {
    hasContext = true;
    pushContextProvider(workInProgress);
  } else {
    hasContext = false;
  }

  prepareToReadContext(workInProgress, renderExpirationTime);
  var instance = workInProgress.stateNode;
  var shouldUpdate;

  if (instance === null) {
    if (current !== null) {
      // A class component without an instance only mounts if it suspended
      // inside a non-concurrent tree, in an inconsistent state. We want to
      // treat it like a new mount, even though an empty version of it already
      // committed. Disconnect the alternate pointers.
      current.alternate = null;
      workInProgress.alternate = null; // Since this is conceptually a new fiber, schedule a Placement effect

      workInProgress.effectTag |= Placement;
    } // In the initial pass we might need to construct the instance.


    constructClassInstance(workInProgress, Component, nextProps);
    mountClassInstance(workInProgress, Component, nextProps, renderExpirationTime);
    shouldUpdate = true;
  } else if (current === null) {
    // In a resume, we'll already have an instance we can reuse.
    shouldUpdate = resumeMountClassInstance(workInProgress, Component, nextProps, renderExpirationTime);
  } else {
    shouldUpdate = updateClassInstance(current, workInProgress, Component, nextProps, renderExpirationTime);
  }

  var nextUnitOfWork = finishClassComponent(current, workInProgress, Component, shouldUpdate, hasContext, renderExpirationTime);

  {
    var inst = workInProgress.stateNode;

    if (inst.props !== nextProps) {
      if (!didWarnAboutReassigningProps) {
        error('It looks like %s is reassigning its own `this.props` while rendering. ' + 'This is not supported and can lead to confusing bugs.', getComponentName(workInProgress.type) || 'a component');
      }

      didWarnAboutReassigningProps = true;
    }
  }

  return nextUnitOfWork;
}

function finishClassComponent(current, workInProgress, Component, shouldUpdate, hasContext, renderExpirationTime) {
  // Refs should update even if shouldComponentUpdate returns false
  markRef(current, workInProgress);
  var didCaptureError = (workInProgress.effectTag & DidCapture) !== NoEffect;

  if (!shouldUpdate && !didCaptureError) {
    // Context providers should defer to sCU for rendering
    if (hasContext) {
      invalidateContextProvider(workInProgress, Component, false);
    }

    return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
  }

  var instance = workInProgress.stateNode; // Rerender

  ReactCurrentOwner$1.current = workInProgress;
  var nextChildren;

  if (didCaptureError && typeof Component.getDerivedStateFromError !== 'function') {
    // If we captured an error, but getDerivedStateFromError is not defined,
    // unmount all the children. componentDidCatch will schedule an update to
    // re-render a fallback. This is temporary until we migrate everyone to
    // the new API.
    // TODO: Warn in a future release.
    nextChildren = null;

    {
      stopProfilerTimerIfRunning();
    }
  } else {
    {
      setIsRendering(true);
      nextChildren = instance.render();

      if ( workInProgress.mode & StrictMode) {
        instance.render();
      }

      setIsRendering(false);
    }
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;

  if (current !== null && didCaptureError) {
    // If we're recovering from an error, reconcile without reusing any of
    // the existing children. Conceptually, the normal children and the children
    // that are shown on error are two different sets, so we shouldn't reuse
    // normal children even if their identities match.
    forceUnmountCurrentAndReconcile(current, workInProgress, nextChildren, renderExpirationTime);
  } else {
    reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  } // Memoize state using the values we just used to render.
  // TODO: Restructure so we never read values from the instance.


  workInProgress.memoizedState = instance.state; // The context might have changed so we need to recalculate it.

  if (hasContext) {
    invalidateContextProvider(workInProgress, Component, true);
  }

  return workInProgress.child;
}

function pushHostRootContext(workInProgress) {
  var root = workInProgress.stateNode;

  if (root.pendingContext) {
    pushTopLevelContextObject(workInProgress, root.pendingContext, root.pendingContext !== root.context);
  } else if (root.context) {
    // Should always be set
    pushTopLevelContextObject(workInProgress, root.context, false);
  }

  pushHostContainer(workInProgress, root.containerInfo);
}

function updateHostRoot(current, workInProgress, renderExpirationTime) {
  pushHostRootContext(workInProgress);
  var updateQueue = workInProgress.updateQueue;

  if (!(current !== null && updateQueue !== null)) {
    {
      throw Error( "If the root does not have an updateQueue, we should have already bailed out. This error is likely caused by a bug in React. Please file an issue." );
    }
  }

  var nextProps = workInProgress.pendingProps;
  var prevState = workInProgress.memoizedState;
  var prevChildren = prevState !== null ? prevState.element : null;
  cloneUpdateQueue(current, workInProgress);
  processUpdateQueue(workInProgress, nextProps, null, renderExpirationTime);
  var nextState = workInProgress.memoizedState; // Caution: React DevTools currently depends on this property
  // being called "element".

  var nextChildren = nextState.element;

  if (nextChildren === prevChildren) {
    // If the state is the same as before, that's a bailout because we had
    // no work that expires at this time.
    resetHydrationState();
    return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
  }

  var root = workInProgress.stateNode;

  if (root.hydrate && enterHydrationState(workInProgress)) {
    // If we don't have any current children this might be the first pass.
    // We always try to hydrate. If this isn't a hydration pass there won't
    // be any children to hydrate which is effectively the same thing as
    // not hydrating.
    var child = mountChildFibers(workInProgress, null, nextChildren, renderExpirationTime);
    workInProgress.child = child;
    var node = child;

    while (node) {
      // Mark each child as hydrating. This is a fast path to know whether this
      // tree is part of a hydrating tree. This is used to determine if a child
      // node has fully mounted yet, and for scheduling event replaying.
      // Conceptually this is similar to Placement in that a new subtree is
      // inserted into the React tree here. It just happens to not need DOM
      // mutations because it already exists.
      node.effectTag = node.effectTag & ~Placement | Hydrating;
      node = node.sibling;
    }
  } else {
    // Otherwise reset hydration state in case we aborted and resumed another
    // root.
    reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
    resetHydrationState();
  }

  return workInProgress.child;
}

function updateHostComponent(current, workInProgress, renderExpirationTime) {
  pushHostContext(workInProgress);

  if (current === null) {
    tryToClaimNextHydratableInstance(workInProgress);
  }

  var type = workInProgress.type;
  var nextProps = workInProgress.pendingProps;
  var prevProps = current !== null ? current.memoizedProps : null;
  var nextChildren = nextProps.children;
  var isDirectTextChild = shouldSetTextContent(type, nextProps);

  if (isDirectTextChild) {
    // We special case a direct text child of a host node. This is a common
    // case. We won't handle it as a reified child. We will instead handle
    // this in the host environment that also has access to this prop. That
    // avoids allocating another HostText fiber and traversing it.
    nextChildren = null;
  } else if (prevProps !== null && shouldSetTextContent(type, prevProps)) {
    // If we're switching from a direct text child to a normal child, or to
    // empty, we need to schedule the text content to be reset.
    workInProgress.effectTag |= ContentReset;
  }

  markRef(current, workInProgress); // Check the host config to see if the children are offscreen/hidden.

  if (workInProgress.mode & ConcurrentMode && renderExpirationTime !== Never && shouldDeprioritizeSubtree(type, nextProps)) {
    {
      markSpawnedWork(Never);
    } // Schedule this fiber to re-render at offscreen priority. Then bailout.


    workInProgress.expirationTime = workInProgress.childExpirationTime = Never;
    return null;
  }

  reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  return workInProgress.child;
}

function updateHostText(current, workInProgress) {
  if (current === null) {
    tryToClaimNextHydratableInstance(workInProgress);
  } // Nothing to do here. This is terminal. We'll do the completion step
  // immediately after.


  return null;
}

function mountLazyComponent(_current, workInProgress, elementType, updateExpirationTime, renderExpirationTime) {
  if (_current !== null) {
    // A lazy component only mounts if it suspended inside a non-
    // concurrent tree, in an inconsistent state. We want to treat it like
    // a new mount, even though an empty version of it already committed.
    // Disconnect the alternate pointers.
    _current.alternate = null;
    workInProgress.alternate = null; // Since this is conceptually a new fiber, schedule a Placement effect

    workInProgress.effectTag |= Placement;
  }

  var props = workInProgress.pendingProps; // We can't start a User Timing measurement with correct label yet.
  // Cancel and resume right after we know the tag.

  cancelWorkTimer(workInProgress);
  var Component = readLazyComponentType(elementType); // Store the unwrapped component in the type.

  workInProgress.type = Component;
  var resolvedTag = workInProgress.tag = resolveLazyComponentTag(Component);
  startWorkTimer(workInProgress);
  var resolvedProps = resolveDefaultProps(Component, props);
  var child;

  switch (resolvedTag) {
    case FunctionComponent:
      {
        {
          validateFunctionComponentInDev(workInProgress, Component);
          workInProgress.type = Component = resolveFunctionForHotReloading(Component);
        }

        child = updateFunctionComponent(null, workInProgress, Component, resolvedProps, renderExpirationTime);
        return child;
      }

    case ClassComponent:
      {
        {
          workInProgress.type = Component = resolveClassForHotReloading(Component);
        }

        child = updateClassComponent(null, workInProgress, Component, resolvedProps, renderExpirationTime);
        return child;
      }

    case ForwardRef:
      {
        {
          workInProgress.type = Component = resolveForwardRefForHotReloading(Component);
        }

        child = updateForwardRef(null, workInProgress, Component, resolvedProps, renderExpirationTime);
        return child;
      }

    case MemoComponent:
      {
        {
          if (workInProgress.type !== workInProgress.elementType) {
            var outerPropTypes = Component.propTypes;

            if (outerPropTypes) {
              checkPropTypes(outerPropTypes, resolvedProps, // Resolved for outer only
              'prop', getComponentName(Component), getCurrentFiberStackInDev);
            }
          }
        }

        child = updateMemoComponent(null, workInProgress, Component, resolveDefaultProps(Component.type, resolvedProps), // The inner type can have defaults too
        updateExpirationTime, renderExpirationTime);
        return child;
      }
  }

  var hint = '';

  {
    if (Component !== null && typeof Component === 'object' && Component.$$typeof === REACT_LAZY_TYPE) {
      hint = ' Did you wrap a component in React.lazy() more than once?';
    }
  } // This message intentionally doesn't mention ForwardRef or MemoComponent
  // because the fact that it's a separate type of work is an
  // implementation detail.


  {
    {
      throw Error( "Element type is invalid. Received a promise that resolves to: " + Component + ". Lazy element type must resolve to a class or function." + hint );
    }
  }
}

function mountIncompleteClassComponent(_current, workInProgress, Component, nextProps, renderExpirationTime) {
  if (_current !== null) {
    // An incomplete component only mounts if it suspended inside a non-
    // concurrent tree, in an inconsistent state. We want to treat it like
    // a new mount, even though an empty version of it already committed.
    // Disconnect the alternate pointers.
    _current.alternate = null;
    workInProgress.alternate = null; // Since this is conceptually a new fiber, schedule a Placement effect

    workInProgress.effectTag |= Placement;
  } // Promote the fiber to a class and try rendering again.


  workInProgress.tag = ClassComponent; // The rest of this function is a fork of `updateClassComponent`
  // Push context providers early to prevent context stack mismatches.
  // During mounting we don't know the child context yet as the instance doesn't exist.
  // We will invalidate the child context in finishClassComponent() right after rendering.

  var hasContext;

  if (isContextProvider(Component)) {
    hasContext = true;
    pushContextProvider(workInProgress);
  } else {
    hasContext = false;
  }

  prepareToReadContext(workInProgress, renderExpirationTime);
  constructClassInstance(workInProgress, Component, nextProps);
  mountClassInstance(workInProgress, Component, nextProps, renderExpirationTime);
  return finishClassComponent(null, workInProgress, Component, true, hasContext, renderExpirationTime);
}

function mountIndeterminateComponent(_current, workInProgress, Component, renderExpirationTime) {
  if (_current !== null) {
    // An indeterminate component only mounts if it suspended inside a non-
    // concurrent tree, in an inconsistent state. We want to treat it like
    // a new mount, even though an empty version of it already committed.
    // Disconnect the alternate pointers.
    _current.alternate = null;
    workInProgress.alternate = null; // Since this is conceptually a new fiber, schedule a Placement effect

    workInProgress.effectTag |= Placement;
  }

  var props = workInProgress.pendingProps;
  var context;

  {
    var unmaskedContext = getUnmaskedContext(workInProgress, Component, false);
    context = getMaskedContext(workInProgress, unmaskedContext);
  }

  prepareToReadContext(workInProgress, renderExpirationTime);
  var value;

  {
    if (Component.prototype && typeof Component.prototype.render === 'function') {
      var componentName = getComponentName(Component) || 'Unknown';

      if (!didWarnAboutBadClass[componentName]) {
        error("The <%s /> component appears to have a render method, but doesn't extend React.Component. " + 'This is likely to cause errors. Change %s to extend React.Component instead.', componentName, componentName);

        didWarnAboutBadClass[componentName] = true;
      }
    }

    if (workInProgress.mode & StrictMode) {
      ReactStrictModeWarnings.recordLegacyContextWarning(workInProgress, null);
    }

    setIsRendering(true);
    ReactCurrentOwner$1.current = workInProgress;
    value = renderWithHooks(null, workInProgress, Component, props, context, renderExpirationTime);
    setIsRendering(false);
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;

  if (typeof value === 'object' && value !== null && typeof value.render === 'function' && value.$$typeof === undefined) {
    {
      var _componentName = getComponentName(Component) || 'Unknown';

      if (!didWarnAboutModulePatternComponent[_componentName]) {
        error('The <%s /> component appears to be a function component that returns a class instance. ' + 'Change %s to a class that extends React.Component instead. ' + "If you can't use a class try assigning the prototype on the function as a workaround. " + "`%s.prototype = React.Component.prototype`. Don't use an arrow function since it " + 'cannot be called with `new` by React.', _componentName, _componentName, _componentName);

        didWarnAboutModulePatternComponent[_componentName] = true;
      }
    } // Proceed under the assumption that this is a class instance


    workInProgress.tag = ClassComponent; // Throw out any hooks that were used.

    workInProgress.memoizedState = null;
    workInProgress.updateQueue = null; // Push context providers early to prevent context stack mismatches.
    // During mounting we don't know the child context yet as the instance doesn't exist.
    // We will invalidate the child context in finishClassComponent() right after rendering.

    var hasContext = false;

    if (isContextProvider(Component)) {
      hasContext = true;
      pushContextProvider(workInProgress);
    } else {
      hasContext = false;
    }

    workInProgress.memoizedState = value.state !== null && value.state !== undefined ? value.state : null;
    initializeUpdateQueue(workInProgress);
    var getDerivedStateFromProps = Component.getDerivedStateFromProps;

    if (typeof getDerivedStateFromProps === 'function') {
      applyDerivedStateFromProps(workInProgress, Component, getDerivedStateFromProps, props);
    }

    adoptClassInstance(workInProgress, value);
    mountClassInstance(workInProgress, Component, props, renderExpirationTime);
    return finishClassComponent(null, workInProgress, Component, true, hasContext, renderExpirationTime);
  } else {
    // Proceed under the assumption that this is a function component
    workInProgress.tag = FunctionComponent;

    {

      if ( workInProgress.mode & StrictMode) {
        // Only double-render components with Hooks
        if (workInProgress.memoizedState !== null) {
          value = renderWithHooks(null, workInProgress, Component, props, context, renderExpirationTime);
        }
      }
    }

    reconcileChildren(null, workInProgress, value, renderExpirationTime);

    {
      validateFunctionComponentInDev(workInProgress, Component);
    }

    return workInProgress.child;
  }
}

function validateFunctionComponentInDev(workInProgress, Component) {
  {
    if (Component) {
      if (Component.childContextTypes) {
        error('%s(...): childContextTypes cannot be defined on a function component.', Component.displayName || Component.name || 'Component');
      }
    }

    if (workInProgress.ref !== null) {
      var info = '';
      var ownerName = getCurrentFiberOwnerNameInDevOrNull();

      if (ownerName) {
        info += '\n\nCheck the render method of `' + ownerName + '`.';
      }

      var warningKey = ownerName || workInProgress._debugID || '';
      var debugSource = workInProgress._debugSource;

      if (debugSource) {
        warningKey = debugSource.fileName + ':' + debugSource.lineNumber;
      }

      if (!didWarnAboutFunctionRefs[warningKey]) {
        didWarnAboutFunctionRefs[warningKey] = true;

        error('Function components cannot be given refs. ' + 'Attempts to access this ref will fail. ' + 'Did you mean to use React.forwardRef()?%s', info);
      }
    }

    if (typeof Component.getDerivedStateFromProps === 'function') {
      var _componentName2 = getComponentName(Component) || 'Unknown';

      if (!didWarnAboutGetDerivedStateOnFunctionComponent[_componentName2]) {
        error('%s: Function components do not support getDerivedStateFromProps.', _componentName2);

        didWarnAboutGetDerivedStateOnFunctionComponent[_componentName2] = true;
      }
    }

    if (typeof Component.contextType === 'object' && Component.contextType !== null) {
      var _componentName3 = getComponentName(Component) || 'Unknown';

      if (!didWarnAboutContextTypeOnFunctionComponent[_componentName3]) {
        error('%s: Function components do not support contextType.', _componentName3);

        didWarnAboutContextTypeOnFunctionComponent[_componentName3] = true;
      }
    }
  }
}

var SUSPENDED_MARKER = {
  dehydrated: null,
  retryTime: NoWork
};

function shouldRemainOnFallback(suspenseContext, current, workInProgress) {
  // If the context is telling us that we should show a fallback, and we're not
  // already showing content, then we should show the fallback instead.
  return hasSuspenseContext(suspenseContext, ForceSuspenseFallback) && (current === null || current.memoizedState !== null);
}

function updateSuspenseComponent(current, workInProgress, renderExpirationTime) {
  var mode = workInProgress.mode;
  var nextProps = workInProgress.pendingProps; // This is used by DevTools to force a boundary to suspend.

  {
    if (shouldSuspend(workInProgress)) {
      workInProgress.effectTag |= DidCapture;
    }
  }

  var suspenseContext = suspenseStackCursor.current;
  var nextDidTimeout = false;
  var didSuspend = (workInProgress.effectTag & DidCapture) !== NoEffect;

  if (didSuspend || shouldRemainOnFallback(suspenseContext, current)) {
    // Something in this boundary's subtree already suspended. Switch to
    // rendering the fallback children.
    nextDidTimeout = true;
    workInProgress.effectTag &= ~DidCapture;
  } else {
    // Attempting the main content
    if (current === null || current.memoizedState !== null) {
      // This is a new mount or this boundary is already showing a fallback state.
      // Mark this subtree context as having at least one invisible parent that could
      // handle the fallback state.
      // Boundaries without fallbacks or should be avoided are not considered since
      // they cannot handle preferred fallback states.
      if (nextProps.fallback !== undefined && nextProps.unstable_avoidThisFallback !== true) {
        suspenseContext = addSubtreeSuspenseContext(suspenseContext, InvisibleParentSuspenseContext);
      }
    }
  }

  suspenseContext = setDefaultShallowSuspenseContext(suspenseContext);
  pushSuspenseContext(workInProgress, suspenseContext); // This next part is a bit confusing. If the children timeout, we switch to
  // showing the fallback children in place of the "primary" children.
  // However, we don't want to delete the primary children because then their
  // state will be lost (both the React state and the host state, e.g.
  // uncontrolled form inputs). Instead we keep them mounted and hide them.
  // Both the fallback children AND the primary children are rendered at the
  // same time. Once the primary children are un-suspended, we can delete
  // the fallback children — don't need to preserve their state.
  //
  // The two sets of children are siblings in the host environment, but
  // semantically, for purposes of reconciliation, they are two separate sets.
  // So we store them using two fragment fibers.
  //
  // However, we want to avoid allocating extra fibers for every placeholder.
  // They're only necessary when the children time out, because that's the
  // only time when both sets are mounted.
  //
  // So, the extra fragment fibers are only used if the children time out.
  // Otherwise, we render the primary children directly. This requires some
  // custom reconciliation logic to preserve the state of the primary
  // children. It's essentially a very basic form of re-parenting.

  if (current === null) {
    // If we're currently hydrating, try to hydrate this boundary.
    // But only if this has a fallback.
    if (nextProps.fallback !== undefined) {
      tryToClaimNextHydratableInstance(workInProgress); // This could've been a dehydrated suspense component.
    } // This is the initial mount. This branch is pretty simple because there's
    // no previous state that needs to be preserved.


    if (nextDidTimeout) {
      // Mount separate fragments for primary and fallback children.
      var nextFallbackChildren = nextProps.fallback;
      var primaryChildFragment = createFiberFromFragment(null, mode, NoWork, null);
      primaryChildFragment.return = workInProgress;

      if ((workInProgress.mode & BlockingMode) === NoMode) {
        // Outside of blocking mode, we commit the effects from the
        // partially completed, timed-out tree, too.
        var progressedState = workInProgress.memoizedState;
        var progressedPrimaryChild = progressedState !== null ? workInProgress.child.child : workInProgress.child;
        primaryChildFragment.child = progressedPrimaryChild;
        var progressedChild = progressedPrimaryChild;

        while (progressedChild !== null) {
          progressedChild.return = primaryChildFragment;
          progressedChild = progressedChild.sibling;
        }
      }

      var fallbackChildFragment = createFiberFromFragment(nextFallbackChildren, mode, renderExpirationTime, null);
      fallbackChildFragment.return = workInProgress;
      primaryChildFragment.sibling = fallbackChildFragment; // Skip the primary children, and continue working on the
      // fallback children.

      workInProgress.memoizedState = SUSPENDED_MARKER;
      workInProgress.child = primaryChildFragment;
      return fallbackChildFragment;
    } else {
      // Mount the primary children without an intermediate fragment fiber.
      var nextPrimaryChildren = nextProps.children;
      workInProgress.memoizedState = null;
      return workInProgress.child = mountChildFibers(workInProgress, null, nextPrimaryChildren, renderExpirationTime);
    }
  } else {
    // This is an update. This branch is more complicated because we need to
    // ensure the state of the primary children is preserved.
    var prevState = current.memoizedState;

    if (prevState !== null) {
      // wrapped in a fragment fiber.


      var currentPrimaryChildFragment = current.child;
      var currentFallbackChildFragment = currentPrimaryChildFragment.sibling;

      if (nextDidTimeout) {
        // Still timed out. Reuse the current primary children by cloning
        // its fragment. We're going to skip over these entirely.
        var _nextFallbackChildren2 = nextProps.fallback;

        var _primaryChildFragment2 = createWorkInProgress(currentPrimaryChildFragment, currentPrimaryChildFragment.pendingProps);

        _primaryChildFragment2.return = workInProgress;

        if ((workInProgress.mode & BlockingMode) === NoMode) {
          // Outside of blocking mode, we commit the effects from the
          // partially completed, timed-out tree, too.
          var _progressedState = workInProgress.memoizedState;

          var _progressedPrimaryChild = _progressedState !== null ? workInProgress.child.child : workInProgress.child;

          if (_progressedPrimaryChild !== currentPrimaryChildFragment.child) {
            _primaryChildFragment2.child = _progressedPrimaryChild;
            var _progressedChild2 = _progressedPrimaryChild;

            while (_progressedChild2 !== null) {
              _progressedChild2.return = _primaryChildFragment2;
              _progressedChild2 = _progressedChild2.sibling;
            }
          }
        } // Because primaryChildFragment is a new fiber that we're inserting as the
        // parent of a new tree, we need to set its treeBaseDuration.


        if ( workInProgress.mode & ProfileMode) {
          // treeBaseDuration is the sum of all the child tree base durations.
          var _treeBaseDuration = 0;
          var _hiddenChild = _primaryChildFragment2.child;

          while (_hiddenChild !== null) {
            _treeBaseDuration += _hiddenChild.treeBaseDuration;
            _hiddenChild = _hiddenChild.sibling;
          }

          _primaryChildFragment2.treeBaseDuration = _treeBaseDuration;
        } // Clone the fallback child fragment, too. These we'll continue
        // working on.


        var _fallbackChildFragment2 = createWorkInProgress(currentFallbackChildFragment, _nextFallbackChildren2);

        _fallbackChildFragment2.return = workInProgress;
        _primaryChildFragment2.sibling = _fallbackChildFragment2;
        _primaryChildFragment2.childExpirationTime = NoWork; // Skip the primary children, and continue working on the
        // fallback children.

        workInProgress.memoizedState = SUSPENDED_MARKER;
        workInProgress.child = _primaryChildFragment2;
        return _fallbackChildFragment2;
      } else {
        // No longer suspended. Switch back to showing the primary children,
        // and remove the intermediate fragment fiber.
        var _nextPrimaryChildren = nextProps.children;
        var currentPrimaryChild = currentPrimaryChildFragment.child;
        var primaryChild = reconcileChildFibers(workInProgress, currentPrimaryChild, _nextPrimaryChildren, renderExpirationTime); // If this render doesn't suspend, we need to delete the fallback
        // children. Wait until the complete phase, after we've confirmed the
        // fallback is no longer needed.
        // TODO: Would it be better to store the fallback fragment on
        // the stateNode?
        // Continue rendering the children, like we normally do.

        workInProgress.memoizedState = null;
        return workInProgress.child = primaryChild;
      }
    } else {
      // The current tree has not already timed out. That means the primary
      // children are not wrapped in a fragment fiber.
      var _currentPrimaryChild = current.child;

      if (nextDidTimeout) {
        // Timed out. Wrap the children in a fragment fiber to keep them
        // separate from the fallback children.
        var _nextFallbackChildren3 = nextProps.fallback;

        var _primaryChildFragment3 = createFiberFromFragment( // It shouldn't matter what the pending props are because we aren't
        // going to render this fragment.
        null, mode, NoWork, null);

        _primaryChildFragment3.return = workInProgress;
        _primaryChildFragment3.child = _currentPrimaryChild;

        if (_currentPrimaryChild !== null) {
          _currentPrimaryChild.return = _primaryChildFragment3;
        } // Even though we're creating a new fiber, there are no new children,
        // because we're reusing an already mounted tree. So we don't need to
        // schedule a placement.
        // primaryChildFragment.effectTag |= Placement;


        if ((workInProgress.mode & BlockingMode) === NoMode) {
          // Outside of blocking mode, we commit the effects from the
          // partially completed, timed-out tree, too.
          var _progressedState2 = workInProgress.memoizedState;

          var _progressedPrimaryChild2 = _progressedState2 !== null ? workInProgress.child.child : workInProgress.child;

          _primaryChildFragment3.child = _progressedPrimaryChild2;
          var _progressedChild3 = _progressedPrimaryChild2;

          while (_progressedChild3 !== null) {
            _progressedChild3.return = _primaryChildFragment3;
            _progressedChild3 = _progressedChild3.sibling;
          }
        } // Because primaryChildFragment is a new fiber that we're inserting as the
        // parent of a new tree, we need to set its treeBaseDuration.


        if ( workInProgress.mode & ProfileMode) {
          // treeBaseDuration is the sum of all the child tree base durations.
          var _treeBaseDuration2 = 0;
          var _hiddenChild2 = _primaryChildFragment3.child;

          while (_hiddenChild2 !== null) {
            _treeBaseDuration2 += _hiddenChild2.treeBaseDuration;
            _hiddenChild2 = _hiddenChild2.sibling;
          }

          _primaryChildFragment3.treeBaseDuration = _treeBaseDuration2;
        } // Create a fragment from the fallback children, too.


        var _fallbackChildFragment3 = createFiberFromFragment(_nextFallbackChildren3, mode, renderExpirationTime, null);

        _fallbackChildFragment3.return = workInProgress;
        _primaryChildFragment3.sibling = _fallbackChildFragment3;
        _fallbackChildFragment3.effectTag |= Placement;
        _primaryChildFragment3.childExpirationTime = NoWork; // Skip the primary children, and continue working on the
        // fallback children.

        workInProgress.memoizedState = SUSPENDED_MARKER;
        workInProgress.child = _primaryChildFragment3;
        return _fallbackChildFragment3;
      } else {
        // Still haven't timed out. Continue rendering the children, like we
        // normally do.
        workInProgress.memoizedState = null;
        var _nextPrimaryChildren2 = nextProps.children;
        return workInProgress.child = reconcileChildFibers(workInProgress, _currentPrimaryChild, _nextPrimaryChildren2, renderExpirationTime);
      }
    }
  }
}

function scheduleWorkOnFiber(fiber, renderExpirationTime) {
  if (fiber.expirationTime < renderExpirationTime) {
    fiber.expirationTime = renderExpirationTime;
  }

  var alternate = fiber.alternate;

  if (alternate !== null && alternate.expirationTime < renderExpirationTime) {
    alternate.expirationTime = renderExpirationTime;
  }

  scheduleWorkOnParentPath(fiber.return, renderExpirationTime);
}

function propagateSuspenseContextChange(workInProgress, firstChild, renderExpirationTime) {
  // Mark any Suspense boundaries with fallbacks as having work to do.
  // If they were previously forced into fallbacks, they may now be able
  // to unblock.
  var node = firstChild;

  while (node !== null) {
    if (node.tag === SuspenseComponent) {
      var state = node.memoizedState;

      if (state !== null) {
        scheduleWorkOnFiber(node, renderExpirationTime);
      }
    } else if (node.tag === SuspenseListComponent) {
      // If the tail is hidden there might not be an Suspense boundaries
      // to schedule work on. In this case we have to schedule it on the
      // list itself.
      // We don't have to traverse to the children of the list since
      // the list will propagate the change when it rerenders.
      scheduleWorkOnFiber(node, renderExpirationTime);
    } else if (node.child !== null) {
      node.child.return = node;
      node = node.child;
      continue;
    }

    if (node === workInProgress) {
      return;
    }

    while (node.sibling === null) {
      if (node.return === null || node.return === workInProgress) {
        return;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;
  }
}

function findLastContentRow(firstChild) {
  // This is going to find the last row among these children that is already
  // showing content on the screen, as opposed to being in fallback state or
  // new. If a row has multiple Suspense boundaries, any of them being in the
  // fallback state, counts as the whole row being in a fallback state.
  // Note that the "rows" will be workInProgress, but any nested children
  // will still be current since we haven't rendered them yet. The mounted
  // order may not be the same as the new order. We use the new order.
  var row = firstChild;
  var lastContentRow = null;

  while (row !== null) {
    var currentRow = row.alternate; // New rows can't be content rows.

    if (currentRow !== null && findFirstSuspended(currentRow) === null) {
      lastContentRow = row;
    }

    row = row.sibling;
  }

  return lastContentRow;
}

function validateRevealOrder(revealOrder) {
  {
    if (revealOrder !== undefined && revealOrder !== 'forwards' && revealOrder !== 'backwards' && revealOrder !== 'together' && !didWarnAboutRevealOrder[revealOrder]) {
      didWarnAboutRevealOrder[revealOrder] = true;

      if (typeof revealOrder === 'string') {
        switch (revealOrder.toLowerCase()) {
          case 'together':
          case 'forwards':
          case 'backwards':
            {
              error('"%s" is not a valid value for revealOrder on <SuspenseList />. ' + 'Use lowercase "%s" instead.', revealOrder, revealOrder.toLowerCase());

              break;
            }

          case 'forward':
          case 'backward':
            {
              error('"%s" is not a valid value for revealOrder on <SuspenseList />. ' + 'React uses the -s suffix in the spelling. Use "%ss" instead.', revealOrder, revealOrder.toLowerCase());

              break;
            }

          default:
            error('"%s" is not a supported revealOrder on <SuspenseList />. ' + 'Did you mean "together", "forwards" or "backwards"?', revealOrder);

            break;
        }
      } else {
        error('%s is not a supported value for revealOrder on <SuspenseList />. ' + 'Did you mean "together", "forwards" or "backwards"?', revealOrder);
      }
    }
  }
}

function validateTailOptions(tailMode, revealOrder) {
  {
    if (tailMode !== undefined && !didWarnAboutTailOptions[tailMode]) {
      if (tailMode !== 'collapsed' && tailMode !== 'hidden') {
        didWarnAboutTailOptions[tailMode] = true;

        error('"%s" is not a supported value for tail on <SuspenseList />. ' + 'Did you mean "collapsed" or "hidden"?', tailMode);
      } else if (revealOrder !== 'forwards' && revealOrder !== 'backwards') {
        didWarnAboutTailOptions[tailMode] = true;

        error('<SuspenseList tail="%s" /> is only valid if revealOrder is ' + '"forwards" or "backwards". ' + 'Did you mean to specify revealOrder="forwards"?', tailMode);
      }
    }
  }
}

function validateSuspenseListNestedChild(childSlot, index) {
  {
    var isArray = Array.isArray(childSlot);
    var isIterable = !isArray && typeof getIteratorFn(childSlot) === 'function';

    if (isArray || isIterable) {
      var type = isArray ? 'array' : 'iterable';

      error('A nested %s was passed to row #%s in <SuspenseList />. Wrap it in ' + 'an additional SuspenseList to configure its revealOrder: ' + '<SuspenseList revealOrder=...> ... ' + '<SuspenseList revealOrder=...>{%s}</SuspenseList> ... ' + '</SuspenseList>', type, index, type);

      return false;
    }
  }

  return true;
}

function validateSuspenseListChildren(children, revealOrder) {
  {
    if ((revealOrder === 'forwards' || revealOrder === 'backwards') && children !== undefined && children !== null && children !== false) {
      if (Array.isArray(children)) {
        for (var i = 0; i < children.length; i++) {
          if (!validateSuspenseListNestedChild(children[i], i)) {
            return;
          }
        }
      } else {
        var iteratorFn = getIteratorFn(children);

        if (typeof iteratorFn === 'function') {
          var childrenIterator = iteratorFn.call(children);

          if (childrenIterator) {
            var step = childrenIterator.next();
            var _i = 0;

            for (; !step.done; step = childrenIterator.next()) {
              if (!validateSuspenseListNestedChild(step.value, _i)) {
                return;
              }

              _i++;
            }
          }
        } else {
          error('A single row was passed to a <SuspenseList revealOrder="%s" />. ' + 'This is not useful since it needs multiple rows. ' + 'Did you mean to pass multiple children or an array?', revealOrder);
        }
      }
    }
  }
}

function initSuspenseListRenderState(workInProgress, isBackwards, tail, lastContentRow, tailMode, lastEffectBeforeRendering) {
  var renderState = workInProgress.memoizedState;

  if (renderState === null) {
    workInProgress.memoizedState = {
      isBackwards: isBackwards,
      rendering: null,
      renderingStartTime: 0,
      last: lastContentRow,
      tail: tail,
      tailExpiration: 0,
      tailMode: tailMode,
      lastEffect: lastEffectBeforeRendering
    };
  } else {
    // We can reuse the existing object from previous renders.
    renderState.isBackwards = isBackwards;
    renderState.rendering = null;
    renderState.renderingStartTime = 0;
    renderState.last = lastContentRow;
    renderState.tail = tail;
    renderState.tailExpiration = 0;
    renderState.tailMode = tailMode;
    renderState.lastEffect = lastEffectBeforeRendering;
  }
} // This can end up rendering this component multiple passes.
// The first pass splits the children fibers into two sets. A head and tail.
// We first render the head. If anything is in fallback state, we do another
// pass through beginWork to rerender all children (including the tail) with
// the force suspend context. If the first render didn't have anything in
// in fallback state. Then we render each row in the tail one-by-one.
// That happens in the completeWork phase without going back to beginWork.


function updateSuspenseListComponent(current, workInProgress, renderExpirationTime) {
  var nextProps = workInProgress.pendingProps;
  var revealOrder = nextProps.revealOrder;
  var tailMode = nextProps.tail;
  var newChildren = nextProps.children;
  validateRevealOrder(revealOrder);
  validateTailOptions(tailMode, revealOrder);
  validateSuspenseListChildren(newChildren, revealOrder);
  reconcileChildren(current, workInProgress, newChildren, renderExpirationTime);
  var suspenseContext = suspenseStackCursor.current;
  var shouldForceFallback = hasSuspenseContext(suspenseContext, ForceSuspenseFallback);

  if (shouldForceFallback) {
    suspenseContext = setShallowSuspenseContext(suspenseContext, ForceSuspenseFallback);
    workInProgress.effectTag |= DidCapture;
  } else {
    var didSuspendBefore = current !== null && (current.effectTag & DidCapture) !== NoEffect;

    if (didSuspendBefore) {
      // If we previously forced a fallback, we need to schedule work
      // on any nested boundaries to let them know to try to render
      // again. This is the same as context updating.
      propagateSuspenseContextChange(workInProgress, workInProgress.child, renderExpirationTime);
    }

    suspenseContext = setDefaultShallowSuspenseContext(suspenseContext);
  }

  pushSuspenseContext(workInProgress, suspenseContext);

  if ((workInProgress.mode & BlockingMode) === NoMode) {
    // Outside of blocking mode, SuspenseList doesn't work so we just
    // use make it a noop by treating it as the default revealOrder.
    workInProgress.memoizedState = null;
  } else {
    switch (revealOrder) {
      case 'forwards':
        {
          var lastContentRow = findLastContentRow(workInProgress.child);
          var tail;

          if (lastContentRow === null) {
            // The whole list is part of the tail.
            // TODO: We could fast path by just rendering the tail now.
            tail = workInProgress.child;
            workInProgress.child = null;
          } else {
            // Disconnect the tail rows after the content row.
            // We're going to render them separately later.
            tail = lastContentRow.sibling;
            lastContentRow.sibling = null;
          }

          initSuspenseListRenderState(workInProgress, false, // isBackwards
          tail, lastContentRow, tailMode, workInProgress.lastEffect);
          break;
        }

      case 'backwards':
        {
          // We're going to find the first row that has existing content.
          // At the same time we're going to reverse the list of everything
          // we pass in the meantime. That's going to be our tail in reverse
          // order.
          var _tail = null;
          var row = workInProgress.child;
          workInProgress.child = null;

          while (row !== null) {
            var currentRow = row.alternate; // New rows can't be content rows.

            if (currentRow !== null && findFirstSuspended(currentRow) === null) {
              // This is the beginning of the main content.
              workInProgress.child = row;
              break;
            }

            var nextRow = row.sibling;
            row.sibling = _tail;
            _tail = row;
            row = nextRow;
          } // TODO: If workInProgress.child is null, we can continue on the tail immediately.


          initSuspenseListRenderState(workInProgress, true, // isBackwards
          _tail, null, // last
          tailMode, workInProgress.lastEffect);
          break;
        }

      case 'together':
        {
          initSuspenseListRenderState(workInProgress, false, // isBackwards
          null, // tail
          null, // last
          undefined, workInProgress.lastEffect);
          break;
        }

      default:
        {
          // The default reveal order is the same as not having
          // a boundary.
          workInProgress.memoizedState = null;
        }
    }
  }

  return workInProgress.child;
}

function updatePortalComponent(current, workInProgress, renderExpirationTime) {
  pushHostContainer(workInProgress, workInProgress.stateNode.containerInfo);
  var nextChildren = workInProgress.pendingProps;

  if (current === null) {
    // Portals are special because we don't append the children during mount
    // but at commit. Therefore we need to track insertions which the normal
    // flow doesn't do during mount. This doesn't happen at the root because
    // the root always starts with a "current" with a null child.
    // TODO: Consider unifying this with how the root works.
    workInProgress.child = reconcileChildFibers(workInProgress, null, nextChildren, renderExpirationTime);
  } else {
    reconcileChildren(current, workInProgress, nextChildren, renderExpirationTime);
  }

  return workInProgress.child;
}

function updateContextProvider(current, workInProgress, renderExpirationTime) {
  var providerType = workInProgress.type;
  var context = providerType._context;
  var newProps = workInProgress.pendingProps;
  var oldProps = workInProgress.memoizedProps;
  var newValue = newProps.value;

  {
    var providerPropTypes = workInProgress.type.propTypes;

    if (providerPropTypes) {
      checkPropTypes(providerPropTypes, newProps, 'prop', 'Context.Provider', getCurrentFiberStackInDev);
    }
  }

  pushProvider(workInProgress, newValue);

  if (oldProps !== null) {
    var oldValue = oldProps.value;
    var changedBits = calculateChangedBits(context, newValue, oldValue);

    if (changedBits === 0) {
      // No change. Bailout early if children are the same.
      if (oldProps.children === newProps.children && !hasContextChanged()) {
        return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
      }
    } else {
      // The context value changed. Search for matching consumers and schedule
      // them to update.
      propagateContextChange(workInProgress, context, changedBits, renderExpirationTime);
    }
  }

  var newChildren = newProps.children;
  reconcileChildren(current, workInProgress, newChildren, renderExpirationTime);
  return workInProgress.child;
}

var hasWarnedAboutUsingContextAsConsumer = false;

function updateContextConsumer(current, workInProgress, renderExpirationTime) {
  var context = workInProgress.type; // The logic below for Context differs depending on PROD or DEV mode. In
  // DEV mode, we create a separate object for Context.Consumer that acts
  // like a proxy to Context. This proxy object adds unnecessary code in PROD
  // so we use the old behaviour (Context.Consumer references Context) to
  // reduce size and overhead. The separate object references context via
  // a property called "_context", which also gives us the ability to check
  // in DEV mode if this property exists or not and warn if it does not.

  {
    if (context._context === undefined) {
      // This may be because it's a Context (rather than a Consumer).
      // Or it may be because it's older React where they're the same thing.
      // We only want to warn if we're sure it's a new React.
      if (context !== context.Consumer) {
        if (!hasWarnedAboutUsingContextAsConsumer) {
          hasWarnedAboutUsingContextAsConsumer = true;

          error('Rendering <Context> directly is not supported and will be removed in ' + 'a future major release. Did you mean to render <Context.Consumer> instead?');
        }
      }
    } else {
      context = context._context;
    }
  }

  var newProps = workInProgress.pendingProps;
  var render = newProps.children;

  {
    if (typeof render !== 'function') {
      error('A context consumer was rendered with multiple children, or a child ' + "that isn't a function. A context consumer expects a single child " + 'that is a function. If you did pass a function, make sure there ' + 'is no trailing or leading whitespace around it.');
    }
  }

  prepareToReadContext(workInProgress, renderExpirationTime);
  var newValue = readContext(context, newProps.unstable_observedBits);
  var newChildren;

  {
    ReactCurrentOwner$1.current = workInProgress;
    setIsRendering(true);
    newChildren = render(newValue);
    setIsRendering(false);
  } // React DevTools reads this flag.


  workInProgress.effectTag |= PerformedWork;
  reconcileChildren(current, workInProgress, newChildren, renderExpirationTime);
  return workInProgress.child;
}

function markWorkInProgressReceivedUpdate() {
  didReceiveUpdate = true;
}

function bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime) {
  cancelWorkTimer(workInProgress);

  if (current !== null) {
    // Reuse previous dependencies
    workInProgress.dependencies = current.dependencies;
  }

  {
    // Don't update "base" render times for bailouts.
    stopProfilerTimerIfRunning();
  }

  var updateExpirationTime = workInProgress.expirationTime;

  if (updateExpirationTime !== NoWork) {
    markUnprocessedUpdateTime(updateExpirationTime);
  } // Check if the children have any pending work.


  var childExpirationTime = workInProgress.childExpirationTime;

  if (childExpirationTime < renderExpirationTime) {
    // The children don't have any work either. We can skip them.
    // TODO: Once we add back resuming, we should check if the children are
    // a work-in-progress set. If so, we need to transfer their effects.
    return null;
  } else {
    // This fiber doesn't have work, but its subtree does. Clone the child
    // fibers and continue.
    cloneChildFibers(current, workInProgress);
    return workInProgress.child;
  }
}

function remountFiber(current, oldWorkInProgress, newWorkInProgress) {
  {
    var returnFiber = oldWorkInProgress.return;

    if (returnFiber === null) {
      throw new Error('Cannot swap the root fiber.');
    } // Disconnect from the old current.
    // It will get deleted.


    current.alternate = null;
    oldWorkInProgress.alternate = null; // Connect to the new tree.

    newWorkInProgress.index = oldWorkInProgress.index;
    newWorkInProgress.sibling = oldWorkInProgress.sibling;
    newWorkInProgress.return = oldWorkInProgress.return;
    newWorkInProgress.ref = oldWorkInProgress.ref; // Replace the child/sibling pointers above it.

    if (oldWorkInProgress === returnFiber.child) {
      returnFiber.child = newWorkInProgress;
    } else {
      var prevSibling = returnFiber.child;

      if (prevSibling === null) {
        throw new Error('Expected parent to have a child.');
      }

      while (prevSibling.sibling !== oldWorkInProgress) {
        prevSibling = prevSibling.sibling;

        if (prevSibling === null) {
          throw new Error('Expected to find the previous sibling.');
        }
      }

      prevSibling.sibling = newWorkInProgress;
    } // Delete the old fiber and place the new one.
    // Since the old fiber is disconnected, we have to schedule it manually.


    var last = returnFiber.lastEffect;

    if (last !== null) {
      last.nextEffect = current;
      returnFiber.lastEffect = current;
    } else {
      returnFiber.firstEffect = returnFiber.lastEffect = current;
    }

    current.nextEffect = null;
    current.effectTag = Deletion;
    newWorkInProgress.effectTag |= Placement; // Restart work from the new fiber.

    return newWorkInProgress;
  }
}

function beginWork(current, workInProgress, renderExpirationTime) {
  var updateExpirationTime = workInProgress.expirationTime;

  {
    if (workInProgress._debugNeedsRemount && current !== null) {
      // This will restart the begin phase with a new fiber.
      return remountFiber(current, workInProgress, createFiberFromTypeAndProps(workInProgress.type, workInProgress.key, workInProgress.pendingProps, workInProgress._debugOwner || null, workInProgress.mode, workInProgress.expirationTime));
    }
  }

  if (current !== null) {
    var oldProps = current.memoizedProps;
    var newProps = workInProgress.pendingProps;

    if (oldProps !== newProps || hasContextChanged() || ( // Force a re-render if the implementation changed due to hot reload:
     workInProgress.type !== current.type )) {
      // If props or context changed, mark the fiber as having performed work.
      // This may be unset if the props are determined to be equal later (memo).
      didReceiveUpdate = true;
    } else if (updateExpirationTime < renderExpirationTime) {
      didReceiveUpdate = false; // This fiber does not have any pending work. Bailout without entering
      // the begin phase. There's still some bookkeeping we that needs to be done
      // in this optimized path, mostly pushing stuff onto the stack.

      switch (workInProgress.tag) {
        case HostRoot:
          pushHostRootContext(workInProgress);
          resetHydrationState();
          break;

        case HostComponent:
          pushHostContext(workInProgress);

          if (workInProgress.mode & ConcurrentMode && renderExpirationTime !== Never && shouldDeprioritizeSubtree(workInProgress.type, newProps)) {
            {
              markSpawnedWork(Never);
            } // Schedule this fiber to re-render at offscreen priority. Then bailout.


            workInProgress.expirationTime = workInProgress.childExpirationTime = Never;
            return null;
          }

          break;

        case ClassComponent:
          {
            var Component = workInProgress.type;

            if (isContextProvider(Component)) {
              pushContextProvider(workInProgress);
            }

            break;
          }

        case HostPortal:
          pushHostContainer(workInProgress, workInProgress.stateNode.containerInfo);
          break;

        case ContextProvider:
          {
            var newValue = workInProgress.memoizedProps.value;
            pushProvider(workInProgress, newValue);
            break;
          }

        case Profiler:
          {
            // Profiler should only call onRender when one of its descendants actually rendered.
            var hasChildWork = workInProgress.childExpirationTime >= renderExpirationTime;

            if (hasChildWork) {
              workInProgress.effectTag |= Update;
            }
          }

          break;

        case SuspenseComponent:
          {
            var state = workInProgress.memoizedState;

            if (state !== null) {
              // whether to retry the primary children, or to skip over it and
              // go straight to the fallback. Check the priority of the primary
              // child fragment.


              var primaryChildFragment = workInProgress.child;
              var primaryChildExpirationTime = primaryChildFragment.childExpirationTime;

              if (primaryChildExpirationTime !== NoWork && primaryChildExpirationTime >= renderExpirationTime) {
                // The primary children have pending work. Use the normal path
                // to attempt to render the primary children again.
                return updateSuspenseComponent(current, workInProgress, renderExpirationTime);
              } else {
                pushSuspenseContext(workInProgress, setDefaultShallowSuspenseContext(suspenseStackCursor.current)); // The primary children do not have pending work with sufficient
                // priority. Bailout.

                var child = bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);

                if (child !== null) {
                  // The fallback children have pending work. Skip over the
                  // primary children and work on the fallback.
                  return child.sibling;
                } else {
                  return null;
                }
              }
            } else {
              pushSuspenseContext(workInProgress, setDefaultShallowSuspenseContext(suspenseStackCursor.current));
            }

            break;
          }

        case SuspenseListComponent:
          {
            var didSuspendBefore = (current.effectTag & DidCapture) !== NoEffect;

            var _hasChildWork = workInProgress.childExpirationTime >= renderExpirationTime;

            if (didSuspendBefore) {
              if (_hasChildWork) {
                // If something was in fallback state last time, and we have all the
                // same children then we're still in progressive loading state.
                // Something might get unblocked by state updates or retries in the
                // tree which will affect the tail. So we need to use the normal
                // path to compute the correct tail.
                return updateSuspenseListComponent(current, workInProgress, renderExpirationTime);
              } // If none of the children had any work, that means that none of
              // them got retried so they'll still be blocked in the same way
              // as before. We can fast bail out.


              workInProgress.effectTag |= DidCapture;
            } // If nothing suspended before and we're rendering the same children,
            // then the tail doesn't matter. Anything new that suspends will work
            // in the "together" mode, so we can continue from the state we had.


            var renderState = workInProgress.memoizedState;

            if (renderState !== null) {
              // Reset to the "together" mode in case we've started a different
              // update in the past but didn't complete it.
              renderState.rendering = null;
              renderState.tail = null;
            }

            pushSuspenseContext(workInProgress, suspenseStackCursor.current);

            if (_hasChildWork) {
              break;
            } else {
              // If none of the children had any work, that means that none of
              // them got retried so they'll still be blocked in the same way
              // as before. We can fast bail out.
              return null;
            }
          }
      }

      return bailoutOnAlreadyFinishedWork(current, workInProgress, renderExpirationTime);
    } else {
      // An update was scheduled on this fiber, but there are no new props
      // nor legacy context. Set this to false. If an update queue or context
      // consumer produces a changed value, it will set this to true. Otherwise,
      // the component will assume the children have not changed and bail out.
      didReceiveUpdate = false;
    }
  } else {
    didReceiveUpdate = false;
  } // Before entering the begin phase, clear pending update priority.
  // TODO: This assumes that we're about to evaluate the component and process
  // the update queue. However, there's an exception: SimpleMemoComponent
  // sometimes bails out later in the begin phase. This indicates that we should
  // move this assignment out of the common path and into each branch.


  workInProgress.expirationTime = NoWork;

  switch (workInProgress.tag) {
    case IndeterminateComponent:
      {
        return mountIndeterminateComponent(current, workInProgress, workInProgress.type, renderExpirationTime);
      }

    case LazyComponent:
      {
        var elementType = workInProgress.elementType;
        return mountLazyComponent(current, workInProgress, elementType, updateExpirationTime, renderExpirationTime);
      }

    case FunctionComponent:
      {
        var _Component = workInProgress.type;
        var unresolvedProps = workInProgress.pendingProps;
        var resolvedProps = workInProgress.elementType === _Component ? unresolvedProps : resolveDefaultProps(_Component, unresolvedProps);
        return updateFunctionComponent(current, workInProgress, _Component, resolvedProps, renderExpirationTime);
      }

    case ClassComponent:
      {
        var _Component2 = workInProgress.type;
        var _unresolvedProps = workInProgress.pendingProps;

        var _resolvedProps = workInProgress.elementType === _Component2 ? _unresolvedProps : resolveDefaultProps(_Component2, _unresolvedProps);

        return updateClassComponent(current, workInProgress, _Component2, _resolvedProps, renderExpirationTime);
      }

    case HostRoot:
      return updateHostRoot(current, workInProgress, renderExpirationTime);

    case HostComponent:
      return updateHostComponent(current, workInProgress, renderExpirationTime);

    case HostText:
      return updateHostText(current, workInProgress);

    case SuspenseComponent:
      return updateSuspenseComponent(current, workInProgress, renderExpirationTime);

    case HostPortal:
      return updatePortalComponent(current, workInProgress, renderExpirationTime);

    case ForwardRef:
      {
        var type = workInProgress.type;
        var _unresolvedProps2 = workInProgress.pendingProps;

        var _resolvedProps2 = workInProgress.elementType === type ? _unresolvedProps2 : resolveDefaultProps(type, _unresolvedProps2);

        return updateForwardRef(current, workInProgress, type, _resolvedProps2, renderExpirationTime);
      }

    case Fragment:
      return updateFragment(current, workInProgress, renderExpirationTime);

    case Mode:
      return updateMode(current, workInProgress, renderExpirationTime);

    case Profiler:
      return updateProfiler(current, workInProgress, renderExpirationTime);

    case ContextProvider:
      return updateContextProvider(current, workInProgress, renderExpirationTime);

    case ContextConsumer:
      return updateContextConsumer(current, workInProgress, renderExpirationTime);

    case MemoComponent:
      {
        var _type2 = workInProgress.type;
        var _unresolvedProps3 = workInProgress.pendingProps; // Resolve outer props first, then resolve inner props.

        var _resolvedProps3 = resolveDefaultProps(_type2, _unresolvedProps3);

        {
          if (workInProgress.type !== workInProgress.elementType) {
            var outerPropTypes = _type2.propTypes;

            if (outerPropTypes) {
              checkPropTypes(outerPropTypes, _resolvedProps3, // Resolved for outer only
              'prop', getComponentName(_type2), getCurrentFiberStackInDev);
            }
          }
        }

        _resolvedProps3 = resolveDefaultProps(_type2.type, _resolvedProps3);
        return updateMemoComponent(current, workInProgress, _type2, _resolvedProps3, updateExpirationTime, renderExpirationTime);
      }

    case SimpleMemoComponent:
      {
        return updateSimpleMemoComponent(current, workInProgress, workInProgress.type, workInProgress.pendingProps, updateExpirationTime, renderExpirationTime);
      }

    case IncompleteClassComponent:
      {
        var _Component3 = workInProgress.type;
        var _unresolvedProps4 = workInProgress.pendingProps;

        var _resolvedProps4 = workInProgress.elementType === _Component3 ? _unresolvedProps4 : resolveDefaultProps(_Component3, _unresolvedProps4);

        return mountIncompleteClassComponent(current, workInProgress, _Component3, _resolvedProps4, renderExpirationTime);
      }

    case SuspenseListComponent:
      {
        return updateSuspenseListComponent(current, workInProgress, renderExpirationTime);
      }
  }

  {
    {
      throw Error( "Unknown unit of work tag (" + workInProgress.tag + "). This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function markUpdate(workInProgress) {
  // Tag the fiber with an update effect. This turns a Placement into
  // a PlacementAndUpdate.
  workInProgress.effectTag |= Update;
}

function markRef$1(workInProgress) {
  workInProgress.effectTag |= Ref;
}

var appendAllChildren;
var updateHostContainer;
var updateHostComponent$1;
var updateHostText$1;

if (supportsMutation) {
  // Mutation mode
  appendAllChildren = function (parent, workInProgress, needsVisibilityToggle, isHidden) {
    // We only have the top Fiber that was created but we need recurse down its
    // children to find all the terminal nodes.
    var node = workInProgress.child;

    while (node !== null) {
      if (node.tag === HostComponent || node.tag === HostText) {
        appendInitialChild(parent, node.stateNode);
      } else if (node.tag === HostPortal) ; else if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      }

      if (node === workInProgress) {
        return;
      }

      while (node.sibling === null) {
        if (node.return === null || node.return === workInProgress) {
          return;
        }

        node = node.return;
      }

      node.sibling.return = node.return;
      node = node.sibling;
    }
  };

  updateHostContainer = function (workInProgress) {// Noop
  };

  updateHostComponent$1 = function (current, workInProgress, type, newProps, rootContainerInstance) {
    // If we have an alternate, that means this is an update and we need to
    // schedule a side-effect to do the updates.
    var oldProps = current.memoizedProps;

    if (oldProps === newProps) {
      // In mutation mode, this is sufficient for a bailout because
      // we won't touch this node even if children changed.
      return;
    } // If we get updated because one of our children updated, we don't
    // have newProps so we'll have to reuse them.
    // TODO: Split the update API as separate for the props vs. children.
    // Even better would be if children weren't special cased at all tho.


    var instance = workInProgress.stateNode;
    var currentHostContext = getHostContext(); // TODO: Experiencing an error where oldProps is null. Suggests a host
    // component is hitting the resume path. Figure out why. Possibly
    // related to `hidden`.

    var updatePayload = prepareUpdate(instance, type, oldProps, newProps, rootContainerInstance, currentHostContext); // TODO: Type this specific to this type of component.

    workInProgress.updateQueue = updatePayload; // If the update payload indicates that there is a change or if there
    // is a new ref we mark this as an update. All the work is done in commitWork.

    if (updatePayload) {
      markUpdate(workInProgress);
    }
  };

  updateHostText$1 = function (current, workInProgress, oldText, newText) {
    // If the text differs, mark it as an update. All the work in done in commitWork.
    if (oldText !== newText) {
      markUpdate(workInProgress);
    }
  };
} else if (supportsPersistence) {
  // Persistent host tree mode
  appendAllChildren = function (parent, workInProgress, needsVisibilityToggle, isHidden) {
    // We only have the top Fiber that was created but we need recurse down its
    // children to find all the terminal nodes.
    var node = workInProgress.child;

    while (node !== null) {
      // eslint-disable-next-line no-labels
       if (node.tag === HostComponent) {
        var instance = node.stateNode;

        if (needsVisibilityToggle && isHidden) {
          // This child is inside a timed out tree. Hide it.
          var props = node.memoizedProps;
          var type = node.type;
          instance = cloneHiddenInstance(instance, type, props, node);
        }

        appendInitialChild(parent, instance);
      } else if (node.tag === HostText) {
        var _instance = node.stateNode;

        if (needsVisibilityToggle && isHidden) {
          // This child is inside a timed out tree. Hide it.
          var text = node.memoizedProps;
          _instance = cloneHiddenTextInstance(_instance, text, node);
        }

        appendInitialChild(parent, _instance);
      } else if (node.tag === HostPortal) ; else if (node.tag === SuspenseComponent) {
        if ((node.effectTag & Update) !== NoEffect) {
          // Need to toggle the visibility of the primary children.
          var newIsHidden = node.memoizedState !== null;

          if (newIsHidden) {
            var primaryChildParent = node.child;

            if (primaryChildParent !== null) {
              if (primaryChildParent.child !== null) {
                primaryChildParent.child.return = primaryChildParent;
                appendAllChildren(parent, primaryChildParent, true, newIsHidden);
              }

              var fallbackChildParent = primaryChildParent.sibling;

              if (fallbackChildParent !== null) {
                fallbackChildParent.return = node;
                node = fallbackChildParent;
                continue;
              }
            }
          }
        }

        if (node.child !== null) {
          // Continue traversing like normal
          node.child.return = node;
          node = node.child;
          continue;
        }
      } else if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      } // $FlowFixMe This is correct but Flow is confused by the labeled break.


      node = node;

      if (node === workInProgress) {
        return;
      }

      while (node.sibling === null) {
        if (node.return === null || node.return === workInProgress) {
          return;
        }

        node = node.return;
      }

      node.sibling.return = node.return;
      node = node.sibling;
    }
  }; // An unfortunate fork of appendAllChildren because we have two different parent types.


  var appendAllChildrenToContainer = function (containerChildSet, workInProgress, needsVisibilityToggle, isHidden) {
    // We only have the top Fiber that was created but we need recurse down its
    // children to find all the terminal nodes.
    var node = workInProgress.child;

    while (node !== null) {
      // eslint-disable-next-line no-labels
       if (node.tag === HostComponent) {
        var instance = node.stateNode;

        if (needsVisibilityToggle && isHidden) {
          // This child is inside a timed out tree. Hide it.
          var props = node.memoizedProps;
          var type = node.type;
          instance = cloneHiddenInstance(instance, type, props, node);
        }

        appendChildToContainerChildSet(containerChildSet, instance);
      } else if (node.tag === HostText) {
        var _instance3 = node.stateNode;

        if (needsVisibilityToggle && isHidden) {
          // This child is inside a timed out tree. Hide it.
          var text = node.memoizedProps;
          _instance3 = cloneHiddenTextInstance(_instance3, text, node);
        }

        appendChildToContainerChildSet(containerChildSet, _instance3);
      } else if (node.tag === HostPortal) ; else if (node.tag === SuspenseComponent) {
        if ((node.effectTag & Update) !== NoEffect) {
          // Need to toggle the visibility of the primary children.
          var newIsHidden = node.memoizedState !== null;

          if (newIsHidden) {
            var primaryChildParent = node.child;

            if (primaryChildParent !== null) {
              if (primaryChildParent.child !== null) {
                primaryChildParent.child.return = primaryChildParent;
                appendAllChildrenToContainer(containerChildSet, primaryChildParent, true, newIsHidden);
              }

              var fallbackChildParent = primaryChildParent.sibling;

              if (fallbackChildParent !== null) {
                fallbackChildParent.return = node;
                node = fallbackChildParent;
                continue;
              }
            }
          }
        }

        if (node.child !== null) {
          // Continue traversing like normal
          node.child.return = node;
          node = node.child;
          continue;
        }
      } else if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      } // $FlowFixMe This is correct but Flow is confused by the labeled break.


      node = node;

      if (node === workInProgress) {
        return;
      }

      while (node.sibling === null) {
        if (node.return === null || node.return === workInProgress) {
          return;
        }

        node = node.return;
      }

      node.sibling.return = node.return;
      node = node.sibling;
    }
  };

  updateHostContainer = function (workInProgress) {
    var portalOrRoot = workInProgress.stateNode;
    var childrenUnchanged = workInProgress.firstEffect === null;

    if (childrenUnchanged) ; else {
      var container = portalOrRoot.containerInfo;
      var newChildSet = createContainerChildSet(container); // If children might have changed, we have to add them all to the set.

      appendAllChildrenToContainer(newChildSet, workInProgress, false, false);
      portalOrRoot.pendingChildren = newChildSet; // Schedule an update on the container to swap out the container.

      markUpdate(workInProgress);
      finalizeContainerChildren(container, newChildSet);
    }
  };

  updateHostComponent$1 = function (current, workInProgress, type, newProps, rootContainerInstance) {
    var currentInstance = current.stateNode;
    var oldProps = current.memoizedProps; // If there are no effects associated with this node, then none of our children had any updates.
    // This guarantees that we can reuse all of them.

    var childrenUnchanged = workInProgress.firstEffect === null;

    if (childrenUnchanged && oldProps === newProps) {
      // No changes, just reuse the existing instance.
      // Note that this might release a previous clone.
      workInProgress.stateNode = currentInstance;
      return;
    }

    var recyclableInstance = workInProgress.stateNode;
    var currentHostContext = getHostContext();
    var updatePayload = null;

    if (oldProps !== newProps) {
      updatePayload = prepareUpdate(recyclableInstance, type, oldProps, newProps, rootContainerInstance, currentHostContext);
    }

    if (childrenUnchanged && updatePayload === null) {
      // No changes, just reuse the existing instance.
      // Note that this might release a previous clone.
      workInProgress.stateNode = currentInstance;
      return;
    }

    var newInstance = cloneInstance(currentInstance, updatePayload, type, oldProps, newProps, workInProgress, childrenUnchanged, recyclableInstance);

    if (finalizeInitialChildren(newInstance, type, newProps, rootContainerInstance, currentHostContext)) {
      markUpdate(workInProgress);
    }

    workInProgress.stateNode = newInstance;

    if (childrenUnchanged) {
      // If there are no other effects in this tree, we need to flag this node as having one.
      // Even though we're not going to use it for anything.
      // Otherwise parents won't know that there are new children to propagate upwards.
      markUpdate(workInProgress);
    } else {
      // If children might have changed, we have to add them all to the set.
      appendAllChildren(newInstance, workInProgress, false, false);
    }
  };

  updateHostText$1 = function (current, workInProgress, oldText, newText) {
    if (oldText !== newText) {
      // If the text content differs, we'll create a new text instance for it.
      var rootContainerInstance = getRootHostContainer();
      var currentHostContext = getHostContext();
      workInProgress.stateNode = createTextInstance(newText, rootContainerInstance, currentHostContext, workInProgress); // We'll have to mark it as having an effect, even though we won't use the effect for anything.
      // This lets the parents know that at least one of their children has changed.

      markUpdate(workInProgress);
    } else {
      workInProgress.stateNode = current.stateNode;
    }
  };
} else {
  // No host operations
  updateHostContainer = function (workInProgress) {// Noop
  };

  updateHostComponent$1 = function (current, workInProgress, type, newProps, rootContainerInstance) {// Noop
  };

  updateHostText$1 = function (current, workInProgress, oldText, newText) {// Noop
  };
}

function cutOffTailIfNeeded(renderState, hasRenderedATailFallback) {
  switch (renderState.tailMode) {
    case 'hidden':
      {
        // Any insertions at the end of the tail list after this point
        // should be invisible. If there are already mounted boundaries
        // anything before them are not considered for collapsing.
        // Therefore we need to go through the whole tail to find if
        // there are any.
        var tailNode = renderState.tail;
        var lastTailNode = null;

        while (tailNode !== null) {
          if (tailNode.alternate !== null) {
            lastTailNode = tailNode;
          }

          tailNode = tailNode.sibling;
        } // Next we're simply going to delete all insertions after the
        // last rendered item.


        if (lastTailNode === null) {
          // All remaining items in the tail are insertions.
          renderState.tail = null;
        } else {
          // Detach the insertion after the last node that was already
          // inserted.
          lastTailNode.sibling = null;
        }

        break;
      }

    case 'collapsed':
      {
        // Any insertions at the end of the tail list after this point
        // should be invisible. If there are already mounted boundaries
        // anything before them are not considered for collapsing.
        // Therefore we need to go through the whole tail to find if
        // there are any.
        var _tailNode = renderState.tail;
        var _lastTailNode = null;

        while (_tailNode !== null) {
          if (_tailNode.alternate !== null) {
            _lastTailNode = _tailNode;
          }

          _tailNode = _tailNode.sibling;
        } // Next we're simply going to delete all insertions after the
        // last rendered item.


        if (_lastTailNode === null) {
          // All remaining items in the tail are insertions.
          if (!hasRenderedATailFallback && renderState.tail !== null) {
            // We suspended during the head. We want to show at least one
            // row at the tail. So we'll keep on and cut off the rest.
            renderState.tail.sibling = null;
          } else {
            renderState.tail = null;
          }
        } else {
          // Detach the insertion after the last node that was already
          // inserted.
          _lastTailNode.sibling = null;
        }

        break;
      }
  }
}

function completeWork(current, workInProgress, renderExpirationTime) {
  var newProps = workInProgress.pendingProps;

  switch (workInProgress.tag) {
    case IndeterminateComponent:
    case LazyComponent:
    case SimpleMemoComponent:
    case FunctionComponent:
    case ForwardRef:
    case Fragment:
    case Mode:
    case Profiler:
    case ContextConsumer:
    case MemoComponent:
      return null;

    case ClassComponent:
      {
        var Component = workInProgress.type;

        if (isContextProvider(Component)) {
          popContext(workInProgress);
        }

        return null;
      }

    case HostRoot:
      {
        popHostContainer(workInProgress);
        popTopLevelContextObject(workInProgress);
        var fiberRoot = workInProgress.stateNode;

        if (fiberRoot.pendingContext) {
          fiberRoot.context = fiberRoot.pendingContext;
          fiberRoot.pendingContext = null;
        }

        if (current === null || current.child === null) {
          // If we hydrated, pop so that we can delete any remaining children
          // that weren't hydrated.
          var wasHydrated = popHydrationState(workInProgress);

          if (wasHydrated) {
            // If we hydrated, then we'll need to schedule an update for
            // the commit side-effects on the root.
            markUpdate(workInProgress);
          }
        }

        updateHostContainer(workInProgress);
        return null;
      }

    case HostComponent:
      {
        popHostContext(workInProgress);
        var rootContainerInstance = getRootHostContainer();
        var type = workInProgress.type;

        if (current !== null && workInProgress.stateNode != null) {
          updateHostComponent$1(current, workInProgress, type, newProps, rootContainerInstance);

          if (current.ref !== workInProgress.ref) {
            markRef$1(workInProgress);
          }
        } else {
          if (!newProps) {
            if (!(workInProgress.stateNode !== null)) {
              {
                throw Error( "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue." );
              }
            } // This can happen when we abort work.


            return null;
          }

          var currentHostContext = getHostContext(); // TODO: Move createInstance to beginWork and keep it on a context
          // "stack" as the parent. Then append children as we go in beginWork
          // or completeWork depending on whether we want to add them top->down or
          // bottom->up. Top->down is faster in IE11.

          var _wasHydrated = popHydrationState(workInProgress);

          if (_wasHydrated) {
            // TODO: Move this and createInstance step into the beginPhase
            // to consolidate.
            if (prepareToHydrateHostInstance(workInProgress, rootContainerInstance, currentHostContext)) {
              // If changes to the hydrated node need to be applied at the
              // commit-phase we mark this as such.
              markUpdate(workInProgress);
            }
          } else {
            var instance = createInstance(type, newProps, rootContainerInstance, currentHostContext, workInProgress);
            appendAllChildren(instance, workInProgress, false, false); // This needs to be set before we mount Flare event listeners

            workInProgress.stateNode = instance;
            // (eg DOM renderer supports auto-focus for certain elements).
            // Make sure such renderers get scheduled for later work.


            if (finalizeInitialChildren(instance, type, newProps, rootContainerInstance, currentHostContext)) {
              markUpdate(workInProgress);
            }
          }

          if (workInProgress.ref !== null) {
            // If there is a ref on a host node we need to schedule a callback
            markRef$1(workInProgress);
          }
        }

        return null;
      }

    case HostText:
      {
        var newText = newProps;

        if (current && workInProgress.stateNode != null) {
          var oldText = current.memoizedProps; // If we have an alternate, that means this is an update and we need
          // to schedule a side-effect to do the updates.

          updateHostText$1(current, workInProgress, oldText, newText);
        } else {
          if (typeof newText !== 'string') {
            if (!(workInProgress.stateNode !== null)) {
              {
                throw Error( "We must have new props for new mounts. This error is likely caused by a bug in React. Please file an issue." );
              }
            } // This can happen when we abort work.

          }

          var _rootContainerInstance = getRootHostContainer();

          var _currentHostContext = getHostContext();

          var _wasHydrated2 = popHydrationState(workInProgress);

          if (_wasHydrated2) {
            if (prepareToHydrateHostTextInstance(workInProgress)) {
              markUpdate(workInProgress);
            }
          } else {
            workInProgress.stateNode = createTextInstance(newText, _rootContainerInstance, _currentHostContext, workInProgress);
          }
        }

        return null;
      }

    case SuspenseComponent:
      {
        popSuspenseContext(workInProgress);
        var nextState = workInProgress.memoizedState;

        if ((workInProgress.effectTag & DidCapture) !== NoEffect) {
          // Something suspended. Re-render with the fallback children.
          workInProgress.expirationTime = renderExpirationTime; // Do not reset the effect list.

          return workInProgress;
        }

        var nextDidTimeout = nextState !== null;
        var prevDidTimeout = false;

        if (current === null) {
          if (workInProgress.memoizedProps.fallback !== undefined) {
            popHydrationState(workInProgress);
          }
        } else {
          var prevState = current.memoizedState;
          prevDidTimeout = prevState !== null;

          if (!nextDidTimeout && prevState !== null) {
            // We just switched from the fallback to the normal children.
            // Delete the fallback.
            // TODO: Would it be better to store the fallback fragment on
            // the stateNode during the begin phase?
            var currentFallbackChild = current.child.sibling;

            if (currentFallbackChild !== null) {
              // Deletions go at the beginning of the return fiber's effect list
              var first = workInProgress.firstEffect;

              if (first !== null) {
                workInProgress.firstEffect = currentFallbackChild;
                currentFallbackChild.nextEffect = first;
              } else {
                workInProgress.firstEffect = workInProgress.lastEffect = currentFallbackChild;
                currentFallbackChild.nextEffect = null;
              }

              currentFallbackChild.effectTag = Deletion;
            }
          }
        }

        if (nextDidTimeout && !prevDidTimeout) {
          // If this subtreee is running in blocking mode we can suspend,
          // otherwise we won't suspend.
          // TODO: This will still suspend a synchronous tree if anything
          // in the concurrent tree already suspended during this render.
          // This is a known bug.
          if ((workInProgress.mode & BlockingMode) !== NoMode) {
            // TODO: Move this back to throwException because this is too late
            // if this is a large tree which is common for initial loads. We
            // don't know if we should restart a render or not until we get
            // this marker, and this is too late.
            // If this render already had a ping or lower pri updates,
            // and this is the first time we know we're going to suspend we
            // should be able to immediately restart from within throwException.
            var hasInvisibleChildContext = current === null && workInProgress.memoizedProps.unstable_avoidThisFallback !== true;

            if (hasInvisibleChildContext || hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext)) {
              // If this was in an invisible tree or a new render, then showing
              // this boundary is ok.
              renderDidSuspend();
            } else {
              // Otherwise, we're going to have to hide content so we should
              // suspend for longer if possible.
              renderDidSuspendDelayIfPossible();
            }
          }
        }

        if (supportsPersistence) {
          // TODO: Only schedule updates if not prevDidTimeout.
          if (nextDidTimeout) {
            // If this boundary just timed out, schedule an effect to attach a
            // retry listener to the promise. This flag is also used to hide the
            // primary children.
            workInProgress.effectTag |= Update;
          }
        }

        if (supportsMutation) {
          // TODO: Only schedule updates if these values are non equal, i.e. it changed.
          if (nextDidTimeout || prevDidTimeout) {
            // If this boundary just timed out, schedule an effect to attach a
            // retry listener to the promise. This flag is also used to hide the
            // primary children. In mutation mode, we also need the flag to
            // *unhide* children that were previously hidden, so check if this
            // is currently timed out, too.
            workInProgress.effectTag |= Update;
          }
        }

        return null;
      }

    case HostPortal:
      popHostContainer(workInProgress);
      updateHostContainer(workInProgress);
      return null;

    case ContextProvider:
      // Pop provider fiber
      popProvider(workInProgress);
      return null;

    case IncompleteClassComponent:
      {
        // Same as class component case. I put it down here so that the tags are
        // sequential to ensure this switch is compiled to a jump table.
        var _Component = workInProgress.type;

        if (isContextProvider(_Component)) {
          popContext(workInProgress);
        }

        return null;
      }

    case SuspenseListComponent:
      {
        popSuspenseContext(workInProgress);
        var renderState = workInProgress.memoizedState;

        if (renderState === null) {
          // We're running in the default, "independent" mode.
          // We don't do anything in this mode.
          return null;
        }

        var didSuspendAlready = (workInProgress.effectTag & DidCapture) !== NoEffect;
        var renderedTail = renderState.rendering;

        if (renderedTail === null) {
          // We just rendered the head.
          if (!didSuspendAlready) {
            // This is the first pass. We need to figure out if anything is still
            // suspended in the rendered set.
            // If new content unsuspended, but there's still some content that
            // didn't. Then we need to do a second pass that forces everything
            // to keep showing their fallbacks.
            // We might be suspended if something in this render pass suspended, or
            // something in the previous committed pass suspended. Otherwise,
            // there's no chance so we can skip the expensive call to
            // findFirstSuspended.
            var cannotBeSuspended = renderHasNotSuspendedYet() && (current === null || (current.effectTag & DidCapture) === NoEffect);

            if (!cannotBeSuspended) {
              var row = workInProgress.child;

              while (row !== null) {
                var suspended = findFirstSuspended(row);

                if (suspended !== null) {
                  didSuspendAlready = true;
                  workInProgress.effectTag |= DidCapture;
                  cutOffTailIfNeeded(renderState, false); // If this is a newly suspended tree, it might not get committed as
                  // part of the second pass. In that case nothing will subscribe to
                  // its thennables. Instead, we'll transfer its thennables to the
                  // SuspenseList so that it can retry if they resolve.
                  // There might be multiple of these in the list but since we're
                  // going to wait for all of them anyway, it doesn't really matter
                  // which ones gets to ping. In theory we could get clever and keep
                  // track of how many dependencies remain but it gets tricky because
                  // in the meantime, we can add/remove/change items and dependencies.
                  // We might bail out of the loop before finding any but that
                  // doesn't matter since that means that the other boundaries that
                  // we did find already has their listeners attached.

                  var newThennables = suspended.updateQueue;

                  if (newThennables !== null) {
                    workInProgress.updateQueue = newThennables;
                    workInProgress.effectTag |= Update;
                  } // Rerender the whole list, but this time, we'll force fallbacks
                  // to stay in place.
                  // Reset the effect list before doing the second pass since that's now invalid.


                  if (renderState.lastEffect === null) {
                    workInProgress.firstEffect = null;
                  }

                  workInProgress.lastEffect = renderState.lastEffect; // Reset the child fibers to their original state.

                  resetChildFibers(workInProgress, renderExpirationTime); // Set up the Suspense Context to force suspense and immediately
                  // rerender the children.

                  pushSuspenseContext(workInProgress, setShallowSuspenseContext(suspenseStackCursor.current, ForceSuspenseFallback));
                  return workInProgress.child;
                }

                row = row.sibling;
              }
            }
          } else {
            cutOffTailIfNeeded(renderState, false);
          } // Next we're going to render the tail.

        } else {
          // Append the rendered row to the child list.
          if (!didSuspendAlready) {
            var _suspended = findFirstSuspended(renderedTail);

            if (_suspended !== null) {
              workInProgress.effectTag |= DidCapture;
              didSuspendAlready = true; // Ensure we transfer the update queue to the parent so that it doesn't
              // get lost if this row ends up dropped during a second pass.

              var _newThennables = _suspended.updateQueue;

              if (_newThennables !== null) {
                workInProgress.updateQueue = _newThennables;
                workInProgress.effectTag |= Update;
              }

              cutOffTailIfNeeded(renderState, true); // This might have been modified.

              if (renderState.tail === null && renderState.tailMode === 'hidden' && !renderedTail.alternate) {
                // We need to delete the row we just rendered.
                // Reset the effect list to what it was before we rendered this
                // child. The nested children have already appended themselves.
                var lastEffect = workInProgress.lastEffect = renderState.lastEffect; // Remove any effects that were appended after this point.

                if (lastEffect !== null) {
                  lastEffect.nextEffect = null;
                } // We're done.


                return null;
              }
            } else if ( // The time it took to render last row is greater than time until
            // the expiration.
            now$1() * 2 - renderState.renderingStartTime > renderState.tailExpiration && renderExpirationTime > Never) {
              // We have now passed our CPU deadline and we'll just give up further
              // attempts to render the main content and only render fallbacks.
              // The assumption is that this is usually faster.
              workInProgress.effectTag |= DidCapture;
              didSuspendAlready = true;
              cutOffTailIfNeeded(renderState, false); // Since nothing actually suspended, there will nothing to ping this
              // to get it started back up to attempt the next item. If we can show
              // them, then they really have the same priority as this render.
              // So we'll pick it back up the very next render pass once we've had
              // an opportunity to yield for paint.

              var nextPriority = renderExpirationTime - 1;
              workInProgress.expirationTime = workInProgress.childExpirationTime = nextPriority;

              {
                markSpawnedWork(nextPriority);
              }
            }
          }

          if (renderState.isBackwards) {
            // The effect list of the backwards tail will have been added
            // to the end. This breaks the guarantee that life-cycles fire in
            // sibling order but that isn't a strong guarantee promised by React.
            // Especially since these might also just pop in during future commits.
            // Append to the beginning of the list.
            renderedTail.sibling = workInProgress.child;
            workInProgress.child = renderedTail;
          } else {
            var previousSibling = renderState.last;

            if (previousSibling !== null) {
              previousSibling.sibling = renderedTail;
            } else {
              workInProgress.child = renderedTail;
            }

            renderState.last = renderedTail;
          }
        }

        if (renderState.tail !== null) {
          // We still have tail rows to render.
          if (renderState.tailExpiration === 0) {
            // Heuristic for how long we're willing to spend rendering rows
            // until we just give up and show what we have so far.
            var TAIL_EXPIRATION_TIMEOUT_MS = 500;
            renderState.tailExpiration = now$1() + TAIL_EXPIRATION_TIMEOUT_MS; // TODO: This is meant to mimic the train model or JND but this
            // is a per component value. It should really be since the start
            // of the total render or last commit. Consider using something like
            // globalMostRecentFallbackTime. That doesn't account for being
            // suspended for part of the time or when it's a new render.
            // It should probably use a global start time value instead.
          } // Pop a row.


          var next = renderState.tail;
          renderState.rendering = next;
          renderState.tail = next.sibling;
          renderState.lastEffect = workInProgress.lastEffect;
          renderState.renderingStartTime = now$1();
          next.sibling = null; // Restore the context.
          // TODO: We can probably just avoid popping it instead and only
          // setting it the first time we go from not suspended to suspended.

          var suspenseContext = suspenseStackCursor.current;

          if (didSuspendAlready) {
            suspenseContext = setShallowSuspenseContext(suspenseContext, ForceSuspenseFallback);
          } else {
            suspenseContext = setDefaultShallowSuspenseContext(suspenseContext);
          }

          pushSuspenseContext(workInProgress, suspenseContext); // Do a pass over the next row.

          return next;
        }

        return null;
      }
  }

  {
    {
      throw Error( "Unknown unit of work tag (" + workInProgress.tag + "). This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function unwindWork(workInProgress, renderExpirationTime) {
  switch (workInProgress.tag) {
    case ClassComponent:
      {
        var Component = workInProgress.type;

        if (isContextProvider(Component)) {
          popContext(workInProgress);
        }

        var effectTag = workInProgress.effectTag;

        if (effectTag & ShouldCapture) {
          workInProgress.effectTag = effectTag & ~ShouldCapture | DidCapture;
          return workInProgress;
        }

        return null;
      }

    case HostRoot:
      {
        popHostContainer(workInProgress);
        popTopLevelContextObject(workInProgress);
        var _effectTag = workInProgress.effectTag;

        if (!((_effectTag & DidCapture) === NoEffect)) {
          {
            throw Error( "The root failed to unmount after an error. This is likely a bug in React. Please file an issue." );
          }
        }

        workInProgress.effectTag = _effectTag & ~ShouldCapture | DidCapture;
        return workInProgress;
      }

    case HostComponent:
      {
        // TODO: popHydrationState
        popHostContext(workInProgress);
        return null;
      }

    case SuspenseComponent:
      {
        popSuspenseContext(workInProgress);

        var _effectTag2 = workInProgress.effectTag;

        if (_effectTag2 & ShouldCapture) {
          workInProgress.effectTag = _effectTag2 & ~ShouldCapture | DidCapture; // Captured a suspense effect. Re-render the boundary.

          return workInProgress;
        }

        return null;
      }

    case SuspenseListComponent:
      {
        popSuspenseContext(workInProgress); // SuspenseList doesn't actually catch anything. It should've been
        // caught by a nested boundary. If not, it should bubble through.

        return null;
      }

    case HostPortal:
      popHostContainer(workInProgress);
      return null;

    case ContextProvider:
      popProvider(workInProgress);
      return null;

    default:
      return null;
  }
}

function unwindInterruptedWork(interruptedWork) {
  switch (interruptedWork.tag) {
    case ClassComponent:
      {
        var childContextTypes = interruptedWork.type.childContextTypes;

        if (childContextTypes !== null && childContextTypes !== undefined) {
          popContext(interruptedWork);
        }

        break;
      }

    case HostRoot:
      {
        popHostContainer(interruptedWork);
        popTopLevelContextObject(interruptedWork);
        break;
      }

    case HostComponent:
      {
        popHostContext(interruptedWork);
        break;
      }

    case HostPortal:
      popHostContainer(interruptedWork);
      break;

    case SuspenseComponent:
      popSuspenseContext(interruptedWork);
      break;

    case SuspenseListComponent:
      popSuspenseContext(interruptedWork);
      break;

    case ContextProvider:
      popProvider(interruptedWork);
      break;
  }
}

function createCapturedValue(value, source) {
  // If the value is an error, call this function immediately after it is thrown
  // so the stack is accurate.
  return {
    value: value,
    source: source,
    stack: getStackByFiberInDevAndProd(source)
  };
}

var invokeGuardedCallbackImpl = function (name, func, context, a, b, c, d, e, f) {
  var funcArgs = Array.prototype.slice.call(arguments, 3);

  try {
    func.apply(context, funcArgs);
  } catch (error) {
    this.onError(error);
  }
};

{
  // In DEV mode, we swap out invokeGuardedCallback for a special version
  // that plays more nicely with the browser's DevTools. The idea is to preserve
  // "Pause on exceptions" behavior. Because React wraps all user-provided
  // functions in invokeGuardedCallback, and the production version of
  // invokeGuardedCallback uses a try-catch, all user exceptions are treated
  // like caught exceptions, and the DevTools won't pause unless the developer
  // takes the extra step of enabling pause on caught exceptions. This is
  // unintuitive, though, because even though React has caught the error, from
  // the developer's perspective, the error is uncaught.
  //
  // To preserve the expected "Pause on exceptions" behavior, we don't use a
  // try-catch in DEV. Instead, we synchronously dispatch a fake event to a fake
  // DOM node, and call the user-provided callback from inside an event handler
  // for that fake event. If the callback throws, the error is "captured" using
  // a global event handler. But because the error happens in a different
  // event loop context, it does not interrupt the normal program flow.
  // Effectively, this gives us try-catch behavior without actually using
  // try-catch. Neat!
  // Check that the browser supports the APIs we need to implement our special
  // DEV version of invokeGuardedCallback
  if (typeof window !== 'undefined' && typeof window.dispatchEvent === 'function' && typeof document !== 'undefined' && typeof document.createEvent === 'function') {
    var fakeNode = document.createElement('react');

    var invokeGuardedCallbackDev = function (name, func, context, a, b, c, d, e, f) {
      // If document doesn't exist we know for sure we will crash in this method
      // when we call document.createEvent(). However this can cause confusing
      // errors: https://github.com/facebookincubator/create-react-app/issues/3482
      // So we preemptively throw with a better message instead.
      if (!(typeof document !== 'undefined')) {
        {
          throw Error( "The `document` global was defined when React was initialized, but is not defined anymore. This can happen in a test environment if a component schedules an update from an asynchronous callback, but the test has already finished running. To solve this, you can either unmount the component at the end of your test (and ensure that any asynchronous operations get canceled in `componentWillUnmount`), or you can change the test itself to be asynchronous." );
        }
      }

      var evt = document.createEvent('Event'); // Keeps track of whether the user-provided callback threw an error. We
      // set this to true at the beginning, then set it to false right after
      // calling the function. If the function errors, `didError` will never be
      // set to false. This strategy works even if the browser is flaky and
      // fails to call our global error handler, because it doesn't rely on
      // the error event at all.

      var didError = true; // Keeps track of the value of window.event so that we can reset it
      // during the callback to let user code access window.event in the
      // browsers that support it.

      var windowEvent = window.event; // Keeps track of the descriptor of window.event to restore it after event
      // dispatching: https://github.com/facebook/react/issues/13688

      var windowEventDescriptor = Object.getOwnPropertyDescriptor(window, 'event'); // Create an event handler for our fake event. We will synchronously
      // dispatch our fake event using `dispatchEvent`. Inside the handler, we
      // call the user-provided callback.

      var funcArgs = Array.prototype.slice.call(arguments, 3);

      function callCallback() {
        // We immediately remove the callback from event listeners so that
        // nested `invokeGuardedCallback` calls do not clash. Otherwise, a
        // nested call would trigger the fake event handlers of any call higher
        // in the stack.
        fakeNode.removeEventListener(evtType, callCallback, false); // We check for window.hasOwnProperty('event') to prevent the
        // window.event assignment in both IE <= 10 as they throw an error
        // "Member not found" in strict mode, and in Firefox which does not
        // support window.event.

        if (typeof window.event !== 'undefined' && window.hasOwnProperty('event')) {
          window.event = windowEvent;
        }

        func.apply(context, funcArgs);
        didError = false;
      } // Create a global error event handler. We use this to capture the value
      // that was thrown. It's possible that this error handler will fire more
      // than once; for example, if non-React code also calls `dispatchEvent`
      // and a handler for that event throws. We should be resilient to most of
      // those cases. Even if our error event handler fires more than once, the
      // last error event is always used. If the callback actually does error,
      // we know that the last error event is the correct one, because it's not
      // possible for anything else to have happened in between our callback
      // erroring and the code that follows the `dispatchEvent` call below. If
      // the callback doesn't error, but the error event was fired, we know to
      // ignore it because `didError` will be false, as described above.


      var error; // Use this to track whether the error event is ever called.

      var didSetError = false;
      var isCrossOriginError = false;

      function handleWindowError(event) {
        error = event.error;
        didSetError = true;

        if (error === null && event.colno === 0 && event.lineno === 0) {
          isCrossOriginError = true;
        }

        if (event.defaultPrevented) {
          // Some other error handler has prevented default.
          // Browsers silence the error report if this happens.
          // We'll remember this to later decide whether to log it or not.
          if (error != null && typeof error === 'object') {
            try {
              error._suppressLogging = true;
            } catch (inner) {// Ignore.
            }
          }
        }
      } // Create a fake event type.


      var evtType = "react-" + (name ? name : 'invokeguardedcallback'); // Attach our event handlers

      window.addEventListener('error', handleWindowError);
      fakeNode.addEventListener(evtType, callCallback, false); // Synchronously dispatch our fake event. If the user-provided function
      // errors, it will trigger our global error handler.

      evt.initEvent(evtType, false, false);
      fakeNode.dispatchEvent(evt);

      if (windowEventDescriptor) {
        Object.defineProperty(window, 'event', windowEventDescriptor);
      }

      if (didError) {
        if (!didSetError) {
          // The callback errored, but the error event never fired.
          error = new Error('An error was thrown inside one of your components, but React ' + "doesn't know what it was. This is likely due to browser " + 'flakiness. React does its best to preserve the "Pause on ' + 'exceptions" behavior of the DevTools, which requires some ' + "DEV-mode only tricks. It's possible that these don't work in " + 'your browser. Try triggering the error in production mode, ' + 'or switching to a modern browser. If you suspect that this is ' + 'actually an issue with React, please file an issue.');
        } else if (isCrossOriginError) {
          error = new Error("A cross-origin error was thrown. React doesn't have access to " + 'the actual error object in development. ' + 'See https://fb.me/react-crossorigin-error for more information.');
        }

        this.onError(error);
      } // Remove our event listeners


      window.removeEventListener('error', handleWindowError);
    };

    invokeGuardedCallbackImpl = invokeGuardedCallbackDev;
  }
}

var invokeGuardedCallbackImpl$1 = invokeGuardedCallbackImpl;

var hasError = false;
var caughtError = null; // Used by event system to capture/rethrow the first error.
var reporter = {
  onError: function (error) {
    hasError = true;
    caughtError = error;
  }
};
/**
 * Call a function while guarding against errors that happens within it.
 * Returns an error if it throws, otherwise null.
 *
 * In production, this is implemented using a try-catch. The reason we don't
 * use a try-catch directly is so that we can swap out a different
 * implementation in DEV mode.
 *
 * @param {String} name of the guard to use for logging or debugging
 * @param {Function} func The function to invoke
 * @param {*} context The context to use when calling the function
 * @param {...*} args Arguments for function
 */

function invokeGuardedCallback(name, func, context, a, b, c, d, e, f) {
  hasError = false;
  caughtError = null;
  invokeGuardedCallbackImpl$1.apply(reporter, arguments);
}
function hasCaughtError() {
  return hasError;
}
function clearCaughtError() {
  if (hasError) {
    var error = caughtError;
    hasError = false;
    caughtError = null;
    return error;
  } else {
    {
      {
        throw Error( "clearCaughtError was called but no error was captured. This error is likely caused by a bug in React. Please file an issue." );
      }
    }
  }
}

function logCapturedError(capturedError) {

  var error = capturedError.error;

  {
    var componentName = capturedError.componentName,
        componentStack = capturedError.componentStack,
        errorBoundaryName = capturedError.errorBoundaryName,
        errorBoundaryFound = capturedError.errorBoundaryFound,
        willRetry = capturedError.willRetry; // Browsers support silencing uncaught errors by calling
    // `preventDefault()` in window `error` handler.
    // We record this information as an expando on the error.

    if (error != null && error._suppressLogging) {
      if (errorBoundaryFound && willRetry) {
        // The error is recoverable and was silenced.
        // Ignore it and don't print the stack addendum.
        // This is handy for testing error boundaries without noise.
        return;
      } // The error is fatal. Since the silencing might have
      // been accidental, we'll surface it anyway.
      // However, the browser would have silenced the original error
      // so we'll print it first, and then print the stack addendum.


      console['error'](error); // Don't transform to our wrapper
      // For a more detailed description of this block, see:
      // https://github.com/facebook/react/pull/13384
    }

    var componentNameMessage = componentName ? "The above error occurred in the <" + componentName + "> component:" : 'The above error occurred in one of your React components:';
    var errorBoundaryMessage; // errorBoundaryFound check is sufficient; errorBoundaryName check is to satisfy Flow.

    if (errorBoundaryFound && errorBoundaryName) {
      if (willRetry) {
        errorBoundaryMessage = "React will try to recreate this component tree from scratch " + ("using the error boundary you provided, " + errorBoundaryName + ".");
      } else {
        errorBoundaryMessage = "This error was initially handled by the error boundary " + errorBoundaryName + ".\n" + "Recreating the tree from scratch failed so React will unmount the tree.";
      }
    } else {
      errorBoundaryMessage = 'Consider adding an error boundary to your tree to customize error handling behavior.\n' + 'Visit https://fb.me/react-error-boundaries to learn more about error boundaries.';
    }

    var combinedMessage = "" + componentNameMessage + componentStack + "\n\n" + ("" + errorBoundaryMessage); // In development, we provide our own message with just the component stack.
    // We don't include the original error message and JS stack because the browser
    // has already printed it. Even if the application swallows the error, it is still
    // displayed by the browser thanks to the DEV-only fake event trick in ReactErrorUtils.

    console['error'](combinedMessage); // Don't transform to our wrapper
  }
}

var didWarnAboutUndefinedSnapshotBeforeUpdate = null;

{
  didWarnAboutUndefinedSnapshotBeforeUpdate = new Set();
}

var PossiblyWeakSet = typeof WeakSet === 'function' ? WeakSet : Set;
function logError(boundary, errorInfo) {
  var source = errorInfo.source;
  var stack = errorInfo.stack;

  if (stack === null && source !== null) {
    stack = getStackByFiberInDevAndProd(source);
  }

  var capturedError = {
    componentName: source !== null ? getComponentName(source.type) : null,
    componentStack: stack !== null ? stack : '',
    error: errorInfo.value,
    errorBoundary: null,
    errorBoundaryName: null,
    errorBoundaryFound: false,
    willRetry: false
  };

  if (boundary !== null && boundary.tag === ClassComponent) {
    capturedError.errorBoundary = boundary.stateNode;
    capturedError.errorBoundaryName = getComponentName(boundary.type);
    capturedError.errorBoundaryFound = true;
    capturedError.willRetry = true;
  }

  try {
    logCapturedError(capturedError);
  } catch (e) {
    // This method must not throw, or React internal state will get messed up.
    // If console.error is overridden, or logCapturedError() shows a dialog that throws,
    // we want to report this error outside of the normal stack as a last resort.
    // https://github.com/facebook/react/issues/13188
    setTimeout(function () {
      throw e;
    });
  }
}

var callComponentWillUnmountWithTimer = function (current, instance) {
  startPhaseTimer(current, 'componentWillUnmount');
  instance.props = current.memoizedProps;
  instance.state = current.memoizedState;
  instance.componentWillUnmount();
  stopPhaseTimer();
}; // Capture errors so they don't interrupt unmounting.


function safelyCallComponentWillUnmount(current, instance) {
  {
    invokeGuardedCallback(null, callComponentWillUnmountWithTimer, null, current, instance);

    if (hasCaughtError()) {
      var unmountError = clearCaughtError();
      captureCommitPhaseError(current, unmountError);
    }
  }
}

function safelyDetachRef(current) {
  var ref = current.ref;

  if (ref !== null) {
    if (typeof ref === 'function') {
      {
        invokeGuardedCallback(null, ref, null, null);

        if (hasCaughtError()) {
          var refError = clearCaughtError();
          captureCommitPhaseError(current, refError);
        }
      }
    } else {
      ref.current = null;
    }
  }
}

function safelyCallDestroy(current, destroy) {
  {
    invokeGuardedCallback(null, destroy, null);

    if (hasCaughtError()) {
      var error = clearCaughtError();
      captureCommitPhaseError(current, error);
    }
  }
}

function commitBeforeMutationLifeCycles(current, finishedWork) {
  switch (finishedWork.tag) {
    case FunctionComponent:
    case ForwardRef:
    case SimpleMemoComponent:
    case Block:
      {
        return;
      }

    case ClassComponent:
      {
        if (finishedWork.effectTag & Snapshot) {
          if (current !== null) {
            var prevProps = current.memoizedProps;
            var prevState = current.memoizedState;
            startPhaseTimer(finishedWork, 'getSnapshotBeforeUpdate');
            var instance = finishedWork.stateNode; // We could update instance props and state here,
            // but instead we rely on them being set during last render.
            // TODO: revisit this when we implement resuming.

            {
              if (finishedWork.type === finishedWork.elementType && !didWarnAboutReassigningProps) {
                if (instance.props !== finishedWork.memoizedProps) {
                  error('Expected %s props to match memoized props before ' + 'getSnapshotBeforeUpdate. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }

                if (instance.state !== finishedWork.memoizedState) {
                  error('Expected %s state to match memoized state before ' + 'getSnapshotBeforeUpdate. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }
              }
            }

            var snapshot = instance.getSnapshotBeforeUpdate(finishedWork.elementType === finishedWork.type ? prevProps : resolveDefaultProps(finishedWork.type, prevProps), prevState);

            {
              var didWarnSet = didWarnAboutUndefinedSnapshotBeforeUpdate;

              if (snapshot === undefined && !didWarnSet.has(finishedWork.type)) {
                didWarnSet.add(finishedWork.type);

                error('%s.getSnapshotBeforeUpdate(): A snapshot value (or null) ' + 'must be returned. You have returned undefined.', getComponentName(finishedWork.type));
              }
            }

            instance.__reactInternalSnapshotBeforeUpdate = snapshot;
            stopPhaseTimer();
          }
        }

        return;
      }

    case HostRoot:
    case HostComponent:
    case HostText:
    case HostPortal:
    case IncompleteClassComponent:
      // Nothing to do for these component types
      return;
  }

  {
    {
      throw Error( "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function commitHookEffectListUnmount(tag, finishedWork) {
  var updateQueue = finishedWork.updateQueue;
  var lastEffect = updateQueue !== null ? updateQueue.lastEffect : null;

  if (lastEffect !== null) {
    var firstEffect = lastEffect.next;
    var effect = firstEffect;

    do {
      if ((effect.tag & tag) === tag) {
        // Unmount
        var destroy = effect.destroy;
        effect.destroy = undefined;

        if (destroy !== undefined) {
          destroy();
        }
      }

      effect = effect.next;
    } while (effect !== firstEffect);
  }
}

function commitHookEffectListMount(tag, finishedWork) {
  var updateQueue = finishedWork.updateQueue;
  var lastEffect = updateQueue !== null ? updateQueue.lastEffect : null;

  if (lastEffect !== null) {
    var firstEffect = lastEffect.next;
    var effect = firstEffect;

    do {
      if ((effect.tag & tag) === tag) {
        // Mount
        var create = effect.create;
        effect.destroy = create();

        {
          var destroy = effect.destroy;

          if (destroy !== undefined && typeof destroy !== 'function') {
            var addendum = void 0;

            if (destroy === null) {
              addendum = ' You returned null. If your effect does not require clean ' + 'up, return undefined (or nothing).';
            } else if (typeof destroy.then === 'function') {
              addendum = '\n\nIt looks like you wrote useEffect(async () => ...) or returned a Promise. ' + 'Instead, write the async function inside your effect ' + 'and call it immediately:\n\n' + 'useEffect(() => {\n' + '  async function fetchData() {\n' + '    // You can await here\n' + '    const response = await MyAPI.getData(someId);\n' + '    // ...\n' + '  }\n' + '  fetchData();\n' + "}, [someId]); // Or [] if effect doesn't need props or state\n\n" + 'Learn more about data fetching with Hooks: https://fb.me/react-hooks-data-fetching';
            } else {
              addendum = ' You returned: ' + destroy;
            }

            error('An effect function must not return anything besides a function, ' + 'which is used for clean-up.%s%s', addendum, getStackByFiberInDevAndProd(finishedWork));
          }
        }
      }

      effect = effect.next;
    } while (effect !== firstEffect);
  }
}

function commitPassiveHookEffects(finishedWork) {
  if ((finishedWork.effectTag & Passive) !== NoEffect) {
    switch (finishedWork.tag) {
      case FunctionComponent:
      case ForwardRef:
      case SimpleMemoComponent:
      case Block:
        {
          // TODO (#17945) We should call all passive destroy functions (for all fibers)
          // before calling any create functions. The current approach only serializes
          // these for a single fiber.
          commitHookEffectListUnmount(Passive$1 | HasEffect, finishedWork);
          commitHookEffectListMount(Passive$1 | HasEffect, finishedWork);
          break;
        }
    }
  }
}

function commitLifeCycles(finishedRoot, current, finishedWork, committedExpirationTime) {
  switch (finishedWork.tag) {
    case FunctionComponent:
    case ForwardRef:
    case SimpleMemoComponent:
    case Block:
      {
        // At this point layout effects have already been destroyed (during mutation phase).
        // This is done to prevent sibling component effects from interfering with each other,
        // e.g. a destroy function in one component should never override a ref set
        // by a create function in another component during the same commit.
        commitHookEffectListMount(Layout | HasEffect, finishedWork);

        return;
      }

    case ClassComponent:
      {
        var instance = finishedWork.stateNode;

        if (finishedWork.effectTag & Update) {
          if (current === null) {
            startPhaseTimer(finishedWork, 'componentDidMount'); // We could update instance props and state here,
            // but instead we rely on them being set during last render.
            // TODO: revisit this when we implement resuming.

            {
              if (finishedWork.type === finishedWork.elementType && !didWarnAboutReassigningProps) {
                if (instance.props !== finishedWork.memoizedProps) {
                  error('Expected %s props to match memoized props before ' + 'componentDidMount. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }

                if (instance.state !== finishedWork.memoizedState) {
                  error('Expected %s state to match memoized state before ' + 'componentDidMount. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }
              }
            }

            instance.componentDidMount();
            stopPhaseTimer();
          } else {
            var prevProps = finishedWork.elementType === finishedWork.type ? current.memoizedProps : resolveDefaultProps(finishedWork.type, current.memoizedProps);
            var prevState = current.memoizedState;
            startPhaseTimer(finishedWork, 'componentDidUpdate'); // We could update instance props and state here,
            // but instead we rely on them being set during last render.
            // TODO: revisit this when we implement resuming.

            {
              if (finishedWork.type === finishedWork.elementType && !didWarnAboutReassigningProps) {
                if (instance.props !== finishedWork.memoizedProps) {
                  error('Expected %s props to match memoized props before ' + 'componentDidUpdate. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }

                if (instance.state !== finishedWork.memoizedState) {
                  error('Expected %s state to match memoized state before ' + 'componentDidUpdate. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
                }
              }
            }

            instance.componentDidUpdate(prevProps, prevState, instance.__reactInternalSnapshotBeforeUpdate);
            stopPhaseTimer();
          }
        }

        var updateQueue = finishedWork.updateQueue;

        if (updateQueue !== null) {
          {
            if (finishedWork.type === finishedWork.elementType && !didWarnAboutReassigningProps) {
              if (instance.props !== finishedWork.memoizedProps) {
                error('Expected %s props to match memoized props before ' + 'processing the update queue. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
              }

              if (instance.state !== finishedWork.memoizedState) {
                error('Expected %s state to match memoized state before ' + 'processing the update queue. ' + 'This might either be because of a bug in React, or because ' + 'a component reassigns its own `this.props`. ' + 'Please file an issue.', getComponentName(finishedWork.type) || 'instance');
              }
            }
          } // We could update instance props and state here,
          // but instead we rely on them being set during last render.
          // TODO: revisit this when we implement resuming.


          commitUpdateQueue(finishedWork, updateQueue, instance);
        }

        return;
      }

    case HostRoot:
      {
        var _updateQueue = finishedWork.updateQueue;

        if (_updateQueue !== null) {
          var _instance = null;

          if (finishedWork.child !== null) {
            switch (finishedWork.child.tag) {
              case HostComponent:
                _instance = getPublicInstance(finishedWork.child.stateNode);
                break;

              case ClassComponent:
                _instance = finishedWork.child.stateNode;
                break;
            }
          }

          commitUpdateQueue(finishedWork, _updateQueue, _instance);
        }

        return;
      }

    case HostComponent:
      {
        var _instance2 = finishedWork.stateNode; // Renderers may schedule work to be done after host components are mounted
        // (eg DOM renderer may schedule auto-focus for inputs and form controls).
        // These effects should only be committed when components are first mounted,
        // aka when there is no current/alternate.

        if (current === null && finishedWork.effectTag & Update) {
          var type = finishedWork.type;
          var props = finishedWork.memoizedProps;
          commitMount(_instance2, type, props, finishedWork);
        }

        return;
      }

    case HostText:
      {
        // We have no life-cycles associated with text.
        return;
      }

    case HostPortal:
      {
        // We have no life-cycles associated with portals.
        return;
      }

    case Profiler:
      {
        {
          var onRender = finishedWork.memoizedProps.onRender;

          if (typeof onRender === 'function') {
            {
              onRender(finishedWork.memoizedProps.id, current === null ? 'mount' : 'update', finishedWork.actualDuration, finishedWork.treeBaseDuration, finishedWork.actualStartTime, getCommitTime(), finishedRoot.memoizedInteractions);
            }
          }
        }

        return;
      }

    case SuspenseComponent:
      {
        commitSuspenseHydrationCallbacks(finishedRoot, finishedWork);
        return;
      }

    case SuspenseListComponent:
    case IncompleteClassComponent:
    case FundamentalComponent:
    case ScopeComponent:
      return;
  }

  {
    {
      throw Error( "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function hideOrUnhideAllChildren(finishedWork, isHidden) {
  if (supportsMutation) {
    // We only have the top Fiber that was inserted but we need to recurse down its
    // children to find all the terminal nodes.
    var node = finishedWork;

    while (true) {
      if (node.tag === HostComponent) {
        var instance = node.stateNode;

        if (isHidden) {
          hideInstance(instance);
        } else {
          unhideInstance(node.stateNode, node.memoizedProps);
        }
      } else if (node.tag === HostText) {
        var _instance3 = node.stateNode;

        if (isHidden) {
          hideTextInstance(_instance3);
        } else {
          unhideTextInstance(_instance3, node.memoizedProps);
        }
      } else if (node.tag === SuspenseComponent && node.memoizedState !== null && node.memoizedState.dehydrated === null) {
        // Found a nested Suspense component that timed out. Skip over the
        // primary child fragment, which should remain hidden.
        var fallbackChildFragment = node.child.sibling;
        fallbackChildFragment.return = node;
        node = fallbackChildFragment;
        continue;
      } else if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      }

      if (node === finishedWork) {
        return;
      }

      while (node.sibling === null) {
        if (node.return === null || node.return === finishedWork) {
          return;
        }

        node = node.return;
      }

      node.sibling.return = node.return;
      node = node.sibling;
    }
  }
}

function commitAttachRef(finishedWork) {
  var ref = finishedWork.ref;

  if (ref !== null) {
    var instance = finishedWork.stateNode;
    var instanceToUse;

    switch (finishedWork.tag) {
      case HostComponent:
        instanceToUse = getPublicInstance(instance);
        break;

      default:
        instanceToUse = instance;
    } // Moved outside to ensure DCE works with this flag

    if (typeof ref === 'function') {
      ref(instanceToUse);
    } else {
      {
        if (!ref.hasOwnProperty('current')) {
          error('Unexpected ref object provided for %s. ' + 'Use either a ref-setter function or React.createRef().%s', getComponentName(finishedWork.type), getStackByFiberInDevAndProd(finishedWork));
        }
      }

      ref.current = instanceToUse;
    }
  }
}

function commitDetachRef(current) {
  var currentRef = current.ref;

  if (currentRef !== null) {
    if (typeof currentRef === 'function') {
      currentRef(null);
    } else {
      currentRef.current = null;
    }
  }
} // User-originating errors (lifecycles and refs) should not interrupt
// deletion, so don't let them throw. Host-originating errors should
// interrupt deletion, so it's okay


function commitUnmount(finishedRoot, current, renderPriorityLevel) {
  onCommitUnmount(current);

  switch (current.tag) {
    case FunctionComponent:
    case ForwardRef:
    case MemoComponent:
    case SimpleMemoComponent:
    case Block:
      {
        var updateQueue = current.updateQueue;

        if (updateQueue !== null) {
          var lastEffect = updateQueue.lastEffect;

          if (lastEffect !== null) {
            var firstEffect = lastEffect.next;

            {
              // When the owner fiber is deleted, the destroy function of a passive
              // effect hook is called during the synchronous commit phase. This is
              // a concession to implementation complexity. Calling it in the
              // passive effect phase (like they usually are, when dependencies
              // change during an update) would require either traversing the
              // children of the deleted fiber again, or including unmount effects
              // as part of the fiber effect list.
              //
              // Because this is during the sync commit phase, we need to change
              // the priority.
              //
              // TODO: Reconsider this implementation trade off.
              var priorityLevel = renderPriorityLevel > NormalPriority ? NormalPriority : renderPriorityLevel;
              runWithPriority(priorityLevel, function () {
                var effect = firstEffect;

                do {
                  var _destroy = effect.destroy;

                  if (_destroy !== undefined) {
                    safelyCallDestroy(current, _destroy);
                  }

                  effect = effect.next;
                } while (effect !== firstEffect);
              });
            }
          }
        }

        return;
      }

    case ClassComponent:
      {
        safelyDetachRef(current);
        var instance = current.stateNode;

        if (typeof instance.componentWillUnmount === 'function') {
          safelyCallComponentWillUnmount(current, instance);
        }

        return;
      }

    case HostComponent:
      {

        safelyDetachRef(current);
        return;
      }

    case HostPortal:
      {
        // TODO: this is recursive.
        // We are also not using this parent because
        // the portal will get pushed immediately.
        if (supportsMutation) {
          unmountHostComponents(finishedRoot, current, renderPriorityLevel);
        } else if (supportsPersistence) {
          emptyPortalContainer(current);
        }

        return;
      }

    case FundamentalComponent:
      {

        return;
      }

    case DehydratedFragment:
      {

        return;
      }

    case ScopeComponent:
      {

        return;
      }
  }
}

function commitNestedUnmounts(finishedRoot, root, renderPriorityLevel) {
  // While we're inside a removed host node we don't want to call
  // removeChild on the inner nodes because they're removed by the top
  // call anyway. We also want to call componentWillUnmount on all
  // composites before this host node is removed from the tree. Therefore
  // we do an inner loop while we're still inside the host node.
  var node = root;

  while (true) {
    commitUnmount(finishedRoot, node, renderPriorityLevel); // Visit children because they may contain more composite or host nodes.
    // Skip portals because commitUnmount() currently visits them recursively.

    if (node.child !== null && ( // If we use mutation we drill down into portals using commitUnmount above.
    // If we don't use mutation we drill down into portals here instead.
    !supportsMutation || node.tag !== HostPortal)) {
      node.child.return = node;
      node = node.child;
      continue;
    }

    if (node === root) {
      return;
    }

    while (node.sibling === null) {
      if (node.return === null || node.return === root) {
        return;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;
  }
}

function detachFiber(current) {
  var alternate = current.alternate; // Cut off the return pointers to disconnect it from the tree. Ideally, we
  // should clear the child pointer of the parent alternate to let this
  // get GC:ed but we don't know which for sure which parent is the current
  // one so we'll settle for GC:ing the subtree of this child. This child
  // itself will be GC:ed when the parent updates the next time.

  current.return = null;
  current.child = null;
  current.memoizedState = null;
  current.updateQueue = null;
  current.dependencies = null;
  current.alternate = null;
  current.firstEffect = null;
  current.lastEffect = null;
  current.pendingProps = null;
  current.memoizedProps = null;
  current.stateNode = null;

  if (alternate !== null) {
    detachFiber(alternate);
  }
}

function emptyPortalContainer(current) {
  if (!supportsPersistence) {
    return;
  }

  var portal = current.stateNode;
  var containerInfo = portal.containerInfo;
  var emptyChildSet = createContainerChildSet(containerInfo);
  replaceContainerChildren(containerInfo, emptyChildSet);
}

function commitContainer(finishedWork) {
  if (!supportsPersistence) {
    return;
  }

  switch (finishedWork.tag) {
    case ClassComponent:
    case HostComponent:
    case HostText:
    case FundamentalComponent:
      {
        return;
      }

    case HostRoot:
    case HostPortal:
      {
        var portalOrRoot = finishedWork.stateNode;
        var containerInfo = portalOrRoot.containerInfo,
            pendingChildren = portalOrRoot.pendingChildren;
        replaceContainerChildren(containerInfo, pendingChildren);
        return;
      }
  }

  {
    {
      throw Error( "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function getHostParentFiber(fiber) {
  var parent = fiber.return;

  while (parent !== null) {
    if (isHostParent(parent)) {
      return parent;
    }

    parent = parent.return;
  }

  {
    {
      throw Error( "Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function isHostParent(fiber) {
  return fiber.tag === HostComponent || fiber.tag === HostRoot || fiber.tag === HostPortal;
}

function getHostSibling(fiber) {
  // We're going to search forward into the tree until we find a sibling host
  // node. Unfortunately, if multiple insertions are done in a row we have to
  // search past them. This leads to exponential search for the next sibling.
  // TODO: Find a more efficient way to do this.
  var node = fiber;

  siblings: while (true) {
    // If we didn't find anything, let's try the next sibling.
    while (node.sibling === null) {
      if (node.return === null || isHostParent(node.return)) {
        // If we pop out of the root or hit the parent the fiber we are the
        // last sibling.
        return null;
      }

      node = node.return;
    }

    node.sibling.return = node.return;
    node = node.sibling;

    while (node.tag !== HostComponent && node.tag !== HostText && node.tag !== DehydratedFragment) {
      // If it is not host node and, we might have a host node inside it.
      // Try to search down until we find one.
      if (node.effectTag & Placement) {
        // If we don't have a child, try the siblings instead.
        continue siblings;
      } // If we don't have a child, try the siblings instead.
      // We also skip portals because they are not part of this host tree.


      if (node.child === null || node.tag === HostPortal) {
        continue siblings;
      } else {
        node.child.return = node;
        node = node.child;
      }
    } // Check if this host node is stable or about to be placed.


    if (!(node.effectTag & Placement)) {
      // Found it!
      return node.stateNode;
    }
  }
}

function commitPlacement(finishedWork) {
  if (!supportsMutation) {
    return;
  } // Recursively insert all host nodes into the parent.


  var parentFiber = getHostParentFiber(finishedWork); // Note: these two variables *must* always be updated together.

  var parent;
  var isContainer;
  var parentStateNode = parentFiber.stateNode;

  switch (parentFiber.tag) {
    case HostComponent:
      parent = parentStateNode;
      isContainer = false;
      break;

    case HostRoot:
      parent = parentStateNode.containerInfo;
      isContainer = true;
      break;

    case HostPortal:
      parent = parentStateNode.containerInfo;
      isContainer = true;
      break;

    case FundamentalComponent:

    // eslint-disable-next-line-no-fallthrough

    default:
      {
        {
          throw Error( "Invalid host parent fiber. This error is likely caused by a bug in React. Please file an issue." );
        }
      }

  }

  if (parentFiber.effectTag & ContentReset) {
    // Reset the text content of the parent before doing any insertions
    resetTextContent(parent); // Clear ContentReset from the effect tag

    parentFiber.effectTag &= ~ContentReset;
  }

  var before = getHostSibling(finishedWork); // We only have the top Fiber that was inserted but we need to recurse down its
  // children to find all the terminal nodes.

  if (isContainer) {
    insertOrAppendPlacementNodeIntoContainer(finishedWork, before, parent);
  } else {
    insertOrAppendPlacementNode(finishedWork, before, parent);
  }
}

function insertOrAppendPlacementNodeIntoContainer(node, before, parent) {
  var tag = node.tag;
  var isHost = tag === HostComponent || tag === HostText;

  if (isHost || enableFundamentalAPI ) {
    var stateNode = isHost ? node.stateNode : node.stateNode.instance;

    if (before) {
      insertInContainerBefore(parent, stateNode, before);
    } else {
      appendChildToContainer(parent, stateNode);
    }
  } else if (tag === HostPortal) ; else {
    var child = node.child;

    if (child !== null) {
      insertOrAppendPlacementNodeIntoContainer(child, before, parent);
      var sibling = child.sibling;

      while (sibling !== null) {
        insertOrAppendPlacementNodeIntoContainer(sibling, before, parent);
        sibling = sibling.sibling;
      }
    }
  }
}

function insertOrAppendPlacementNode(node, before, parent) {
  var tag = node.tag;
  var isHost = tag === HostComponent || tag === HostText;

  if (isHost || enableFundamentalAPI ) {
    var stateNode = isHost ? node.stateNode : node.stateNode.instance;

    if (before) {
      insertBefore(parent, stateNode, before);
    } else {
      appendChild(parent, stateNode);
    }
  } else if (tag === HostPortal) ; else {
    var child = node.child;

    if (child !== null) {
      insertOrAppendPlacementNode(child, before, parent);
      var sibling = child.sibling;

      while (sibling !== null) {
        insertOrAppendPlacementNode(sibling, before, parent);
        sibling = sibling.sibling;
      }
    }
  }
}

function unmountHostComponents(finishedRoot, current, renderPriorityLevel) {
  // We only have the top Fiber that was deleted but we need to recurse down its
  // children to find all the terminal nodes.
  var node = current; // Each iteration, currentParent is populated with node's host parent if not
  // currentParentIsValid.

  var currentParentIsValid = false; // Note: these two variables *must* always be updated together.

  var currentParent;
  var currentParentIsContainer;

  while (true) {
    if (!currentParentIsValid) {
      var parent = node.return;

      findParent: while (true) {
        if (!(parent !== null)) {
          {
            throw Error( "Expected to find a host parent. This error is likely caused by a bug in React. Please file an issue." );
          }
        }

        var parentStateNode = parent.stateNode;

        switch (parent.tag) {
          case HostComponent:
            currentParent = parentStateNode;
            currentParentIsContainer = false;
            break findParent;

          case HostRoot:
            currentParent = parentStateNode.containerInfo;
            currentParentIsContainer = true;
            break findParent;

          case HostPortal:
            currentParent = parentStateNode.containerInfo;
            currentParentIsContainer = true;
            break findParent;

        }

        parent = parent.return;
      }

      currentParentIsValid = true;
    }

    if (node.tag === HostComponent || node.tag === HostText) {
      commitNestedUnmounts(finishedRoot, node, renderPriorityLevel); // After all the children have unmounted, it is now safe to remove the
      // node from the tree.

      if (currentParentIsContainer) {
        removeChildFromContainer(currentParent, node.stateNode);
      } else {
        removeChild(currentParent, node.stateNode);
      } // Don't visit children because we already visited them.

    } else if (node.tag === HostPortal) {
      if (node.child !== null) {
        // When we go into a portal, it becomes the parent to remove from.
        // We will reassign it back when we pop the portal on the way up.
        currentParent = node.stateNode.containerInfo;
        currentParentIsContainer = true; // Visit children because portals might contain host components.

        node.child.return = node;
        node = node.child;
        continue;
      }
    } else {
      commitUnmount(finishedRoot, node, renderPriorityLevel); // Visit children because we may find more host components below.

      if (node.child !== null) {
        node.child.return = node;
        node = node.child;
        continue;
      }
    }

    if (node === current) {
      return;
    }

    while (node.sibling === null) {
      if (node.return === null || node.return === current) {
        return;
      }

      node = node.return;

      if (node.tag === HostPortal) {
        // When we go out of the portal, we need to restore the parent.
        // Since we don't keep a stack of them, we will search for it.
        currentParentIsValid = false;
      }
    }

    node.sibling.return = node.return;
    node = node.sibling;
  }
}

function commitDeletion(finishedRoot, current, renderPriorityLevel) {
  if (supportsMutation) {
    // Recursively delete all host nodes from the parent.
    // Detach refs and call componentWillUnmount() on the whole subtree.
    unmountHostComponents(finishedRoot, current, renderPriorityLevel);
  } else {
    // Detach refs and call componentWillUnmount() on the whole subtree.
    commitNestedUnmounts(finishedRoot, current, renderPriorityLevel);
  }

  detachFiber(current);
}

function commitWork(current, finishedWork) {
  if (!supportsMutation) {
    switch (finishedWork.tag) {
      case FunctionComponent:
      case ForwardRef:
      case MemoComponent:
      case SimpleMemoComponent:
      case Block:
        {
          // Layout effects are destroyed during the mutation phase so that all
          // destroy functions for all fibers are called before any create functions.
          // This prevents sibling component effects from interfering with each other,
          // e.g. a destroy function in one component should never override a ref set
          // by a create function in another component during the same commit.
          commitHookEffectListUnmount(Layout | HasEffect, finishedWork);
          return;
        }

      case Profiler:
        {
          return;
        }

      case SuspenseComponent:
        {
          commitSuspenseComponent(finishedWork);
          attachSuspenseRetryListeners(finishedWork);
          return;
        }

      case SuspenseListComponent:
        {
          attachSuspenseRetryListeners(finishedWork);
          return;
        }

      case HostRoot:
        {
          if (supportsHydration) {
            var root = finishedWork.stateNode;

            if (root.hydrate) {
              // We've just hydrated. No need to hydrate again.
              root.hydrate = false;
              commitHydratedContainer(root.containerInfo);
            }
          }

          break;
        }
    }

    commitContainer(finishedWork);
    return;
  }

  switch (finishedWork.tag) {
    case FunctionComponent:
    case ForwardRef:
    case MemoComponent:
    case SimpleMemoComponent:
    case Block:
      {
        // Layout effects are destroyed during the mutation phase so that all
        // destroy functions for all fibers are called before any create functions.
        // This prevents sibling component effects from interfering with each other,
        // e.g. a destroy function in one component should never override a ref set
        // by a create function in another component during the same commit.
        commitHookEffectListUnmount(Layout | HasEffect, finishedWork);
        return;
      }

    case ClassComponent:
      {
        return;
      }

    case HostComponent:
      {
        var instance = finishedWork.stateNode;

        if (instance != null) {
          // Commit the work prepared earlier.
          var newProps = finishedWork.memoizedProps; // For hydration we reuse the update path but we treat the oldProps
          // as the newProps. The updatePayload will contain the real change in
          // this case.

          var oldProps = current !== null ? current.memoizedProps : newProps;
          var type = finishedWork.type; // TODO: Type the updateQueue to be specific to host components.

          var updatePayload = finishedWork.updateQueue;
          finishedWork.updateQueue = null;

          if (updatePayload !== null) {
            commitUpdate(instance, updatePayload, type, oldProps, newProps, finishedWork);
          }
        }

        return;
      }

    case HostText:
      {
        if (!(finishedWork.stateNode !== null)) {
          {
            throw Error( "This should have a text node initialized. This error is likely caused by a bug in React. Please file an issue." );
          }
        }

        var textInstance = finishedWork.stateNode;
        var newText = finishedWork.memoizedProps; // For hydration we reuse the update path but we treat the oldProps
        // as the newProps. The updatePayload will contain the real change in
        // this case.

        var oldText = current !== null ? current.memoizedProps : newText;
        commitTextUpdate(textInstance, oldText, newText);
        return;
      }

    case HostRoot:
      {
        if (supportsHydration) {
          var _root = finishedWork.stateNode;

          if (_root.hydrate) {
            // We've just hydrated. No need to hydrate again.
            _root.hydrate = false;
            commitHydratedContainer(_root.containerInfo);
          }
        }

        return;
      }

    case Profiler:
      {
        return;
      }

    case SuspenseComponent:
      {
        commitSuspenseComponent(finishedWork);
        attachSuspenseRetryListeners(finishedWork);
        return;
      }

    case SuspenseListComponent:
      {
        attachSuspenseRetryListeners(finishedWork);
        return;
      }

    case IncompleteClassComponent:
      {
        return;
      }
  }

  {
    {
      throw Error( "This unit of work tag should not have side-effects. This error is likely caused by a bug in React. Please file an issue." );
    }
  }
}

function commitSuspenseComponent(finishedWork) {
  var newState = finishedWork.memoizedState;
  var newDidTimeout;
  var primaryChildParent = finishedWork;

  if (newState === null) {
    newDidTimeout = false;
  } else {
    newDidTimeout = true;
    primaryChildParent = finishedWork.child;
    markCommitTimeOfFallback();
  }

  if (supportsMutation && primaryChildParent !== null) {
    hideOrUnhideAllChildren(primaryChildParent, newDidTimeout);
  }
}

function commitSuspenseHydrationCallbacks(finishedRoot, finishedWork) {
  if (!supportsHydration) {
    return;
  }

  var newState = finishedWork.memoizedState;

  if (newState === null) {
    var current = finishedWork.alternate;

    if (current !== null) {
      var prevState = current.memoizedState;

      if (prevState !== null) {
        var suspenseInstance = prevState.dehydrated;

        if (suspenseInstance !== null) {
          commitHydratedSuspenseInstance(suspenseInstance);
        }
      }
    }
  }
}

function attachSuspenseRetryListeners(finishedWork) {
  // If this boundary just timed out, then it will have a set of thenables.
  // For each thenable, attach a listener so that when it resolves, React
  // attempts to re-render the boundary in the primary (pre-timeout) state.
  var thenables = finishedWork.updateQueue;

  if (thenables !== null) {
    finishedWork.updateQueue = null;
    var retryCache = finishedWork.stateNode;

    if (retryCache === null) {
      retryCache = finishedWork.stateNode = new PossiblyWeakSet();
    }

    thenables.forEach(function (thenable) {
      // Memoize using the boundary fiber to prevent redundant listeners.
      var retry = resolveRetryThenable.bind(null, finishedWork, thenable);

      if (!retryCache.has(thenable)) {
        {
          if (thenable.__reactDoNotTraceInteractions !== true) {
            retry = tracing$1.unstable_wrap(retry);
          }
        }

        retryCache.add(thenable);
        thenable.then(retry, retry);
      }
    });
  }
}

function commitResetTextContent(current) {
  if (!supportsMutation) {
    return;
  }

  resetTextContent(current.stateNode);
}

var PossiblyWeakMap = typeof WeakMap === 'function' ? WeakMap : Map;

function createRootErrorUpdate(fiber, errorInfo, expirationTime) {
  var update = createUpdate(expirationTime, null); // Unmount the root by rendering null.

  update.tag = CaptureUpdate; // Caution: React DevTools currently depends on this property
  // being called "element".

  update.payload = {
    element: null
  };
  var error = errorInfo.value;

  update.callback = function () {
    onUncaughtError(error);
    logError(fiber, errorInfo);
  };

  return update;
}

function createClassErrorUpdate(fiber, errorInfo, expirationTime) {
  var update = createUpdate(expirationTime, null);
  update.tag = CaptureUpdate;
  var getDerivedStateFromError = fiber.type.getDerivedStateFromError;

  if (typeof getDerivedStateFromError === 'function') {
    var error$1 = errorInfo.value;

    update.payload = function () {
      logError(fiber, errorInfo);
      return getDerivedStateFromError(error$1);
    };
  }

  var inst = fiber.stateNode;

  if (inst !== null && typeof inst.componentDidCatch === 'function') {
    update.callback = function callback() {
      {
        markFailedErrorBoundaryForHotReloading(fiber);
      }

      if (typeof getDerivedStateFromError !== 'function') {
        // To preserve the preexisting retry behavior of error boundaries,
        // we keep track of which ones already failed during this batch.
        // This gets reset before we yield back to the browser.
        // TODO: Warn in strict mode if getDerivedStateFromError is
        // not defined.
        markLegacyErrorBoundaryAsFailed(this); // Only log here if componentDidCatch is the only error boundary method defined

        logError(fiber, errorInfo);
      }

      var error$1 = errorInfo.value;
      var stack = errorInfo.stack;
      this.componentDidCatch(error$1, {
        componentStack: stack !== null ? stack : ''
      });

      {
        if (typeof getDerivedStateFromError !== 'function') {
          // If componentDidCatch is the only error boundary method defined,
          // then it needs to call setState to recover from errors.
          // If no state update is scheduled then the boundary will swallow the error.
          if (fiber.expirationTime !== Sync) {
            error('%s: Error boundaries should implement getDerivedStateFromError(). ' + 'In that method, return a state update to display an error message or fallback UI.', getComponentName(fiber.type) || 'Unknown');
          }
        }
      }
    };
  } else {
    update.callback = function () {
      markFailedErrorBoundaryForHotReloading(fiber);
    };
  }

  return update;
}

function attachPingListener(root, renderExpirationTime, thenable) {
  // Attach a listener to the promise to "ping" the root and retry. But
  // only if one does not already exist for the current render expiration
  // time (which acts like a "thread ID" here).
  var pingCache = root.pingCache;
  var threadIDs;

  if (pingCache === null) {
    pingCache = root.pingCache = new PossiblyWeakMap();
    threadIDs = new Set();
    pingCache.set(thenable, threadIDs);
  } else {
    threadIDs = pingCache.get(thenable);

    if (threadIDs === undefined) {
      threadIDs = new Set();
      pingCache.set(thenable, threadIDs);
    }
  }

  if (!threadIDs.has(renderExpirationTime)) {
    // Memoize using the thread ID to prevent redundant listeners.
    threadIDs.add(renderExpirationTime);
    var ping = pingSuspendedRoot.bind(null, root, thenable, renderExpirationTime);
    thenable.then(ping, ping);
  }
}

function throwException(root, returnFiber, sourceFiber, value, renderExpirationTime) {
  // The source fiber did not complete.
  sourceFiber.effectTag |= Incomplete; // Its effect list is no longer valid.

  sourceFiber.firstEffect = sourceFiber.lastEffect = null;

  if (value !== null && typeof value === 'object' && typeof value.then === 'function') {
    // This is a thenable.
    var thenable = value;

    if ((sourceFiber.mode & BlockingMode) === NoMode) {
      // Reset the memoizedState to what it was before we attempted
      // to render it.
      var currentSource = sourceFiber.alternate;

      if (currentSource) {
        sourceFiber.updateQueue = currentSource.updateQueue;
        sourceFiber.memoizedState = currentSource.memoizedState;
        sourceFiber.expirationTime = currentSource.expirationTime;
      } else {
        sourceFiber.updateQueue = null;
        sourceFiber.memoizedState = null;
      }
    }

    var hasInvisibleParentBoundary = hasSuspenseContext(suspenseStackCursor.current, InvisibleParentSuspenseContext); // Schedule the nearest Suspense to re-render the timed out view.

    var _workInProgress = returnFiber;

    do {
      if (_workInProgress.tag === SuspenseComponent && shouldCaptureSuspense(_workInProgress, hasInvisibleParentBoundary)) {
        // Found the nearest boundary.
        // Stash the promise on the boundary fiber. If the boundary times out, we'll
        // attach another listener to flip the boundary back to its normal state.
        var thenables = _workInProgress.updateQueue;

        if (thenables === null) {
          var updateQueue = new Set();
          updateQueue.add(thenable);
          _workInProgress.updateQueue = updateQueue;
        } else {
          thenables.add(thenable);
        } // If the boundary is outside of blocking mode, we should *not*
        // suspend the commit. Pretend as if the suspended component rendered
        // null and keep rendering. In the commit phase, we'll schedule a
        // subsequent synchronous update to re-render the Suspense.
        //
        // Note: It doesn't matter whether the component that suspended was
        // inside a blocking mode tree. If the Suspense is outside of it, we
        // should *not* suspend the commit.


        if ((_workInProgress.mode & BlockingMode) === NoMode) {
          _workInProgress.effectTag |= DidCapture; // We're going to commit this fiber even though it didn't complete.
          // But we shouldn't call any lifecycle methods or callbacks. Remove
          // all lifecycle effect tags.

          sourceFiber.effectTag &= ~(LifecycleEffectMask | Incomplete);

          if (sourceFiber.tag === ClassComponent) {
            var currentSourceFiber = sourceFiber.alternate;

            if (currentSourceFiber === null) {
              // This is a new mount. Change the tag so it's not mistaken for a
              // completed class component. For example, we should not call
              // componentWillUnmount if it is deleted.
              sourceFiber.tag = IncompleteClassComponent;
            } else {
              // When we try rendering again, we should not reuse the current fiber,
              // since it's known to be in an inconsistent state. Use a force update to
              // prevent a bail out.
              var update = createUpdate(Sync, null);
              update.tag = ForceUpdate;
              enqueueUpdate(sourceFiber, update);
            }
          } // The source fiber did not complete. Mark it with Sync priority to
          // indicate that it still has pending work.


          sourceFiber.expirationTime = Sync; // Exit without suspending.

          return;
        } // Confirmed that the boundary is in a concurrent mode tree. Continue
        // with the normal suspend path.
        //
        // After this we'll use a set of heuristics to determine whether this
        // render pass will run to completion or restart or "suspend" the commit.
        // The actual logic for this is spread out in different places.
        //
        // This first principle is that if we're going to suspend when we complete
        // a root, then we should also restart if we get an update or ping that
        // might unsuspend it, and vice versa. The only reason to suspend is
        // because you think you might want to restart before committing. However,
        // it doesn't make sense to restart only while in the period we're suspended.
        //
        // Restarting too aggressively is also not good because it starves out any
        // intermediate loading state. So we use heuristics to determine when.
        // Suspense Heuristics
        //
        // If nothing threw a Promise or all the same fallbacks are already showing,
        // then don't suspend/restart.
        //
        // If this is an initial render of a new tree of Suspense boundaries and
        // those trigger a fallback, then don't suspend/restart. We want to ensure
        // that we can show the initial loading state as quickly as possible.
        //
        // If we hit a "Delayed" case, such as when we'd switch from content back into
        // a fallback, then we should always suspend/restart. SuspenseConfig applies to
        // this case. If none is defined, JND is used instead.
        //
        // If we're already showing a fallback and it gets "retried", allowing us to show
        // another level, but there's still an inner boundary that would show a fallback,
        // then we suspend/restart for 500ms since the last time we showed a fallback
        // anywhere in the tree. This effectively throttles progressive loading into a
        // consistent train of commits. This also gives us an opportunity to restart to
        // get to the completed state slightly earlier.
        //
        // If there's ambiguity due to batching it's resolved in preference of:
        // 1) "delayed", 2) "initial render", 3) "retry".
        //
        // We want to ensure that a "busy" state doesn't get force committed. We want to
        // ensure that new initial loading states can commit as soon as possible.


        attachPingListener(root, renderExpirationTime, thenable);
        _workInProgress.effectTag |= ShouldCapture;
        _workInProgress.expirationTime = renderExpirationTime;
        return;
      } // This boundary already captured during this render. Continue to the next
      // boundary.


      _workInProgress = _workInProgress.return;
    } while (_workInProgress !== null); // No boundary was found. Fallthrough to error mode.
    // TODO: Use invariant so the message is stripped in prod?


    value = new Error((getComponentName(sourceFiber.type) || 'A React component') + ' suspended while rendering, but no fallback UI was specified.\n' + '\n' + 'Add a <Suspense fallback=...> component higher in the tree to ' + 'provide a loading indicator or placeholder to display.' + getStackByFiberInDevAndProd(sourceFiber));
  } // We didn't find a boundary that could handle this type of exception. Start
  // over and traverse parent path again, this time treating the exception
  // as an error.


  renderDidError();
  value = createCapturedValue(value, sourceFiber);
  var workInProgress = returnFiber;

  do {
    switch (workInProgress.tag) {
      case HostRoot:
        {
          var _errorInfo = value;
          workInProgress.effectTag |= ShouldCapture;
          workInProgress.expirationTime = renderExpirationTime;

          var _update = createRootErrorUpdate(workInProgress, _errorInfo, renderExpirationTime);

          enqueueCapturedUpdate(workInProgress, _update);
          return;
        }

      case ClassComponent:
        // Capture and retry
        var errorInfo = value;
        var ctor = workInProgress.type;
        var instance = workInProgress.stateNode;

        if ((workInProgress.effectTag & DidCapture) === NoEffect && (typeof ctor.getDerivedStateFromError === 'function' || instance !== null && typeof instance.componentDidCatch === 'function' && !isAlreadyFailedLegacyErrorBoundary(instance))) {
          workInProgress.effectTag |= ShouldCapture;
          workInProgress.expirationTime = renderExpirationTime; // Schedule the error boundary to re-render using updated state

          var _update2 = createClassErrorUpdate(workInProgress, errorInfo, renderExpirationTime);

          enqueueCapturedUpdate(workInProgress, _update2);
          return;
        }

        break;
    }

    workInProgress = workInProgress.return;
  } while (workInProgress !== null);
}

var ceil = Math.ceil;
var ReactCurrentDispatcher$1 = ReactSharedInternals.ReactCurrentDispatcher,
    ReactCurrentOwner$2 = ReactSharedInternals.ReactCurrentOwner,
    IsSomeRendererActing = ReactSharedInternals.IsSomeRendererActing;
var NoContext =
/*                    */
0;
var BatchedContext =
/*               */
1;
var EventContext =
/*                 */
2;
var DiscreteEventContext =
/*         */
4;
var LegacyUnbatchedContext =
/*       */
8;
var RenderContext =
/*                */
16;
var CommitContext =
/*                */
32;
var RootIncomplete = 0;
var RootFatalErrored = 1;
var RootErrored = 2;
var RootSuspended = 3;
var RootSuspendedWithDelay = 4;
var RootCompleted = 5;
// Describes where we are in the React execution stack
var executionContext = NoContext; // The root we're working on

var workInProgressRoot = null; // The fiber we're working on

var workInProgress = null; // The expiration time we're rendering

var renderExpirationTime$1 = NoWork; // Whether to root completed, errored, suspended, etc.

var workInProgressRootExitStatus = RootIncomplete; // A fatal error, if one is thrown

var workInProgressRootFatalError = null; // Most recent event time among processed updates during this render.
// This is conceptually a time stamp but expressed in terms of an ExpirationTime
// because we deal mostly with expiration times in the hot path, so this avoids
// the conversion happening in the hot path.

var workInProgressRootLatestProcessedExpirationTime = Sync;
var workInProgressRootLatestSuspenseTimeout = Sync;
var workInProgressRootCanSuspendUsingConfig = null; // The work left over by components that were visited during this render. Only
// includes unprocessed updates, not work in bailed out children.

var workInProgressRootNextUnprocessedUpdateTime = NoWork; // If we're pinged while rendering we don't always restart immediately.
// This flag determines if it might be worthwhile to restart if an opportunity
// happens latere.

var workInProgressRootHasPendingPing = false; // The most recent time we committed a fallback. This lets us ensure a train
// model where we don't commit new loading states in too quick succession.

var globalMostRecentFallbackTime = 0;
var FALLBACK_THROTTLE_MS = 500;
var nextEffect = null;
var hasUncaughtError = false;
var firstUncaughtError = null;
var legacyErrorBoundariesThatAlreadyFailed = null;
var rootDoesHavePassiveEffects = false;
var rootWithPendingPassiveEffects = null;
var pendingPassiveEffectsRenderPriority = NoPriority;
var pendingPassiveEffectsExpirationTime = NoWork;
var rootsWithPendingDiscreteUpdates = null; // Use these to prevent an infinite loop of nested updates

var NESTED_UPDATE_LIMIT = 50;
var nestedUpdateCount = 0;
var rootWithNestedUpdates = null;
var NESTED_PASSIVE_UPDATE_LIMIT = 50;
var nestedPassiveUpdateCount = 0;
var interruptedBy = null; // Marks the need to reschedule pending interactions at these expiration times
// during the commit phase. This enables them to be traced across components
// that spawn new work during render. E.g. hidden boundaries, suspended SSR
// hydration or SuspenseList.

var spawnedWorkDuringRender = null; // Expiration times are computed by adding to the current time (the start
// time). However, if two updates are scheduled within the same event, we
// should treat their start times as simultaneous, even if the actual clock
// time has advanced between the first and second call.
// In other words, because expiration times determine how updates are batched,
// we want all updates of like priority that occur within the same event to
// receive the same expiration time. Otherwise we get tearing.

var currentEventTime = NoWork;
function requestCurrentTimeForUpdate() {
  if ((executionContext & (RenderContext | CommitContext)) !== NoContext) {
    // We're inside React, so it's fine to read the actual time.
    return msToExpirationTime(now$1());
  } // We're not inside React, so we may be in the middle of a browser event.


  if (currentEventTime !== NoWork) {
    // Use the same start time for all updates until we enter React again.
    return currentEventTime;
  } // This is the first update since React yielded. Compute a new start time.


  currentEventTime = msToExpirationTime(now$1());
  return currentEventTime;
}
function getCurrentTime() {
  return msToExpirationTime(now$1());
}
function computeExpirationForFiber(currentTime, fiber, suspenseConfig) {
  var mode = fiber.mode;

  if ((mode & BlockingMode) === NoMode) {
    return Sync;
  }

  var priorityLevel = getCurrentPriorityLevel();

  if ((mode & ConcurrentMode) === NoMode) {
    return priorityLevel === ImmediatePriority ? Sync : Batched;
  }

  if ((executionContext & RenderContext) !== NoContext) {
    // Use whatever time we're already rendering
    // TODO: Should there be a way to opt out, like with `runWithPriority`?
    return renderExpirationTime$1;
  }

  var expirationTime;

  if (suspenseConfig !== null) {
    // Compute an expiration time based on the Suspense timeout.
    expirationTime = computeSuspenseExpiration(currentTime, suspenseConfig.timeoutMs | 0 || LOW_PRIORITY_EXPIRATION);
  } else {
    // Compute an expiration time based on the Scheduler priority.
    switch (priorityLevel) {
      case ImmediatePriority:
        expirationTime = Sync;
        break;

      case UserBlockingPriority:
        // TODO: Rename this to computeUserBlockingExpiration
        expirationTime = computeInteractiveExpiration(currentTime);
        break;

      case NormalPriority:
      case LowPriority:
        // TODO: Handle LowPriority
        // TODO: Rename this to... something better.
        expirationTime = computeAsyncExpiration(currentTime);
        break;

      case IdlePriority:
        expirationTime = Idle;
        break;

      default:
        {
          {
            throw Error( "Expected a valid priority level" );
          }
        }

    }
  } // If we're in the middle of rendering a tree, do not update at the same
  // expiration time that is already rendering.
  // TODO: We shouldn't have to do this if the update is on a different root.
  // Refactor computeExpirationForFiber + scheduleUpdate so we have access to
  // the root when we check for this condition.


  if (workInProgressRoot !== null && expirationTime === renderExpirationTime$1) {
    // This is a trick to move this update into a separate batch
    expirationTime -= 1;
  }

  return expirationTime;
}
function scheduleUpdateOnFiber(fiber, expirationTime) {
  checkForNestedUpdates();
  warnAboutRenderPhaseUpdatesInDEV(fiber);
  var root = markUpdateTimeFromFiberToRoot(fiber, expirationTime);

  if (root === null) {
    warnAboutUpdateOnUnmountedFiberInDEV(fiber);
    return;
  }

  checkForInterruption(fiber, expirationTime);
  recordScheduleUpdate(); // TODO: computeExpirationForFiber also reads the priority. Pass the
  // priority as an argument to that function and this one.

  var priorityLevel = getCurrentPriorityLevel();

  if (expirationTime === Sync) {
    if ( // Check if we're inside unbatchedUpdates
    (executionContext & LegacyUnbatchedContext) !== NoContext && // Check if we're not already rendering
    (executionContext & (RenderContext | CommitContext)) === NoContext) {
      // Register pending interactions on the root to avoid losing traced interaction data.
      schedulePendingInteractions(root, expirationTime); // This is a legacy edge case. The initial mount of a ReactDOM.render-ed
      // root inside of batchedUpdates should be synchronous, but layout updates
      // should be deferred until the end of the batch.

      performSyncWorkOnRoot(root);
    } else {
      ensureRootIsScheduled(root);
      schedulePendingInteractions(root, expirationTime);

      if (executionContext === NoContext) {
        // Flush the synchronous work now, unless we're already working or inside
        // a batch. This is intentionally inside scheduleUpdateOnFiber instead of
        // scheduleCallbackForFiber to preserve the ability to schedule a callback
        // without immediately flushing it. We only do this for user-initiated
        // updates, to preserve historical behavior of legacy mode.
        flushSyncCallbackQueue();
      }
    }
  } else {
    ensureRootIsScheduled(root);
    schedulePendingInteractions(root, expirationTime);
  }

  if ((executionContext & DiscreteEventContext) !== NoContext && ( // Only updates at user-blocking priority or greater are considered
  // discrete, even inside a discrete event.
  priorityLevel === UserBlockingPriority || priorityLevel === ImmediatePriority)) {
    // This is the result of a discrete event. Track the lowest priority
    // discrete update per root so we can flush them early, if needed.
    if (rootsWithPendingDiscreteUpdates === null) {
      rootsWithPendingDiscreteUpdates = new Map([[root, expirationTime]]);
    } else {
      var lastDiscreteTime = rootsWithPendingDiscreteUpdates.get(root);

      if (lastDiscreteTime === undefined || lastDiscreteTime > expirationTime) {
        rootsWithPendingDiscreteUpdates.set(root, expirationTime);
      }
    }
  }
}
var scheduleWork = scheduleUpdateOnFiber; // This is split into a separate function so we can mark a fiber with pending
// work without treating it as a typical update that originates from an event;
// e.g. retrying a Suspense boundary isn't an update, but it does schedule work
// on a fiber.

function markUpdateTimeFromFiberToRoot(fiber, expirationTime) {
  // Update the source fiber's expiration time
  if (fiber.expirationTime < expirationTime) {
    fiber.expirationTime = expirationTime;
  }

  var alternate = fiber.alternate;

  if (alternate !== null && alternate.expirationTime < expirationTime) {
    alternate.expirationTime = expirationTime;
  } // Walk the parent path to the root and update the child expiration time.


  var node = fiber.return;
  var root = null;

  if (node === null && fiber.tag === HostRoot) {
    root = fiber.stateNode;
  } else {
    while (node !== null) {
      alternate = node.alternate;

      if (node.childExpirationTime < expirationTime) {
        node.childExpirationTime = expirationTime;

        if (alternate !== null && alternate.childExpirationTime < expirationTime) {
          alternate.childExpirationTime = expirationTime;
        }
      } else if (alternate !== null && alternate.childExpirationTime < expirationTime) {
        alternate.childExpirationTime = expirationTime;
      }

      if (node.return === null && node.tag === HostRoot) {
        root = node.stateNode;
        break;
      }

      node = node.return;
    }
  }

  if (root !== null) {
    if (workInProgressRoot === root) {
      // Received an update to a tree that's in the middle of rendering. Mark
      // that's unprocessed work on this root.
      markUnprocessedUpdateTime(expirationTime);

      if (workInProgressRootExitStatus === RootSuspendedWithDelay) {
        // The root already suspended with a delay, which means this render
        // definitely won't finish. Since we have a new update, let's mark it as
        // suspended now, right before marking the incoming update. This has the
        // effect of interrupting the current render and switching to the update.
        // TODO: This happens to work when receiving an update during the render
        // phase, because of the trick inside computeExpirationForFiber to
        // subtract 1 from `renderExpirationTime` to move it into a
        // separate bucket. But we should probably model it with an exception,
        // using the same mechanism we use to force hydration of a subtree.
        // TODO: This does not account for low pri updates that were already
        // scheduled before the root started rendering. Need to track the next
        // pending expiration time (perhaps by backtracking the return path) and
        // then trigger a restart in the `renderDidSuspendDelayIfPossible` path.
        markRootSuspendedAtTime(root, renderExpirationTime$1);
      }
    } // Mark that the root has a pending update.


    markRootUpdatedAtTime(root, expirationTime);
  }

  return root;
}

function getNextRootExpirationTimeToWorkOn(root) {
  // Determines the next expiration time that the root should render, taking
  // into account levels that may be suspended, or levels that may have
  // received a ping.
  var lastExpiredTime = root.lastExpiredTime;

  if (lastExpiredTime !== NoWork) {
    return lastExpiredTime;
  } // "Pending" refers to any update that hasn't committed yet, including if it
  // suspended. The "suspended" range is therefore a subset.


  var firstPendingTime = root.firstPendingTime;

  if (!isRootSuspendedAtTime(root, firstPendingTime)) {
    // The highest priority pending time is not suspended. Let's work on that.
    return firstPendingTime;
  } // If the first pending time is suspended, check if there's a lower priority
  // pending level that we know about. Or check if we received a ping. Work
  // on whichever is higher priority.


  var lastPingedTime = root.lastPingedTime;
  var nextKnownPendingLevel = root.nextKnownPendingLevel;
  var nextLevel = lastPingedTime > nextKnownPendingLevel ? lastPingedTime : nextKnownPendingLevel;

  if ( nextLevel <= Idle && firstPendingTime !== nextLevel) {
    // Don't work on Idle/Never priority unless everything else is committed.
    return NoWork;
  }

  return nextLevel;
} // Use this function to schedule a task for a root. There's only one task per
// root; if a task was already scheduled, we'll check to make sure the
// expiration time of the existing task is the same as the expiration time of
// the next level that the root has work on. This function is called on every
// update, and right before exiting a task.


function ensureRootIsScheduled(root) {
  var lastExpiredTime = root.lastExpiredTime;

  if (lastExpiredTime !== NoWork) {
    // Special case: Expired work should flush synchronously.
    root.callbackExpirationTime = Sync;
    root.callbackPriority = ImmediatePriority;
    root.callbackNode = scheduleSyncCallback(performSyncWorkOnRoot.bind(null, root));
    return;
  }

  var expirationTime = getNextRootExpirationTimeToWorkOn(root);
  var existingCallbackNode = root.callbackNode;

  if (expirationTime === NoWork) {
    // There's nothing to work on.
    if (existingCallbackNode !== null) {
      root.callbackNode = null;
      root.callbackExpirationTime = NoWork;
      root.callbackPriority = NoPriority;
    }

    return;
  } // TODO: If this is an update, we already read the current time. Pass the
  // time as an argument.


  var currentTime = requestCurrentTimeForUpdate();
  var priorityLevel = inferPriorityFromExpirationTime(currentTime, expirationTime); // If there's an existing render task, confirm it has the correct priority and
  // expiration time. Otherwise, we'll cancel it and schedule a new one.

  if (existingCallbackNode !== null) {
    var existingCallbackPriority = root.callbackPriority;
    var existingCallbackExpirationTime = root.callbackExpirationTime;

    if ( // Callback must have the exact same expiration time.
    existingCallbackExpirationTime === expirationTime && // Callback must have greater or equal priority.
    existingCallbackPriority >= priorityLevel) {
      // Existing callback is sufficient.
      return;
    } // Need to schedule a new task.
    // TODO: Instead of scheduling a new task, we should be able to change the
    // priority of the existing one.


    cancelCallback(existingCallbackNode);
  }

  root.callbackExpirationTime = expirationTime;
  root.callbackPriority = priorityLevel;
  var callbackNode;

  if (expirationTime === Sync) {
    // Sync React callbacks are scheduled on a special internal queue
    callbackNode = scheduleSyncCallback(performSyncWorkOnRoot.bind(null, root));
  } else {
    callbackNode = scheduleCallback(priorityLevel, performConcurrentWorkOnRoot.bind(null, root), // Compute a task timeout based on the expiration time. This also affects
    // ordering because tasks are processed in timeout order.
    {
      timeout: expirationTimeToMs(expirationTime) - now$1()
    });
  }

  root.callbackNode = callbackNode;
} // This is the entry point for every concurrent task, i.e. anything that
// goes through Scheduler.


function performConcurrentWorkOnRoot(root, didTimeout) {
  // Since we know we're in a React event, we can clear the current
  // event time. The next update will compute a new event time.
  currentEventTime = NoWork;

  if (didTimeout) {
    // The render task took too long to complete. Mark the current time as
    // expired to synchronously render all expired work in a single batch.
    var currentTime = requestCurrentTimeForUpdate();
    markRootExpiredAtTime(root, currentTime); // This will schedule a synchronous callback.

    ensureRootIsScheduled(root);
    return null;
  } // Determine the next expiration time to work on, using the fields stored
  // on the root.


  var expirationTime = getNextRootExpirationTimeToWorkOn(root);

  if (expirationTime !== NoWork) {
    var originalCallbackNode = root.callbackNode;

    if (!((executionContext & (RenderContext | CommitContext)) === NoContext)) {
      {
        throw Error( "Should not already be working." );
      }
    }

    flushPassiveEffects(); // If the root or expiration time have changed, throw out the existing stack
    // and prepare a fresh one. Otherwise we'll continue where we left off.

    if (root !== workInProgressRoot || expirationTime !== renderExpirationTime$1) {
      prepareFreshStack(root, expirationTime);
      startWorkOnPendingInteractions(root, expirationTime);
    } // If we have a work-in-progress fiber, it means there's still work to do
    // in this root.


    if (workInProgress !== null) {
      var prevExecutionContext = executionContext;
      executionContext |= RenderContext;
      var prevDispatcher = pushDispatcher();
      var prevInteractions = pushInteractions(root);
      startWorkLoopTimer(workInProgress);

      do {
        try {
          workLoopConcurrent();
          break;
        } catch (thrownValue) {
          handleError(root, thrownValue);
        }
      } while (true);

      resetContextDependencies();
      executionContext = prevExecutionContext;
      popDispatcher(prevDispatcher);

      {
        popInteractions(prevInteractions);
      }

      if (workInProgressRootExitStatus === RootFatalErrored) {
        var fatalError = workInProgressRootFatalError;
        stopInterruptedWorkLoopTimer();
        prepareFreshStack(root, expirationTime);
        markRootSuspendedAtTime(root, expirationTime);
        ensureRootIsScheduled(root);
        throw fatalError;
      }

      if (workInProgress !== null) {
        // There's still work left over. Exit without committing.
        stopInterruptedWorkLoopTimer();
      } else {
        // We now have a consistent tree. The next step is either to commit it,
        // or, if something suspended, wait to commit it after a timeout.
        stopFinishedWorkLoopTimer();
        var finishedWork = root.finishedWork = root.current.alternate;
        root.finishedExpirationTime = expirationTime;
        finishConcurrentRender(root, finishedWork, workInProgressRootExitStatus, expirationTime);
      }

      ensureRootIsScheduled(root);

      if (root.callbackNode === originalCallbackNode) {
        // The task node scheduled for this root is the same one that's
        // currently executed. Need to return a continuation.
        return performConcurrentWorkOnRoot.bind(null, root);
      }
    }
  }

  return null;
}

function finishConcurrentRender(root, finishedWork, exitStatus, expirationTime) {
  // Set this to null to indicate there's no in-progress render.
  workInProgressRoot = null;

  switch (exitStatus) {
    case RootIncomplete:
    case RootFatalErrored:
      {
        {
          {
            throw Error( "Root did not complete. This is a bug in React." );
          }
        }
      }
    // Flow knows about invariant, so it complains if I add a break
    // statement, but eslint doesn't know about invariant, so it complains
    // if I do. eslint-disable-next-line no-fallthrough

    case RootErrored:
      {
        // If this was an async render, the error may have happened due to
        // a mutation in a concurrent event. Try rendering one more time,
        // synchronously, to see if the error goes away. If there are
        // lower priority updates, let's include those, too, in case they
        // fix the inconsistency. Render at Idle to include all updates.
        // If it was Idle or Never or some not-yet-invented time, render
        // at that time.
        markRootExpiredAtTime(root, expirationTime > Idle ? Idle : expirationTime); // We assume that this second render pass will be synchronous
        // and therefore not hit this path again.

        break;
      }

    case RootSuspended:
      {
        markRootSuspendedAtTime(root, expirationTime);
        var lastSuspendedTime = root.lastSuspendedTime;

        if (expirationTime === lastSuspendedTime) {
          root.nextKnownPendingLevel = getRemainingExpirationTime(finishedWork);
        } // We have an acceptable loading state. We need to figure out if we
        // should immediately commit it or wait a bit.
        // If we have processed new updates during this render, we may now
        // have a new loading state ready. We want to ensure that we commit
        // that as soon as possible.


        var hasNotProcessedNewUpdates = workInProgressRootLatestProcessedExpirationTime === Sync;

        if (hasNotProcessedNewUpdates && // do not delay if we're inside an act() scope
        !( IsThisRendererActing.current)) {
          // If we have not processed any new updates during this pass, then
          // this is either a retry of an existing fallback state or a
          // hidden tree. Hidden trees shouldn't be batched with other work
          // and after that's fixed it can only be a retry. We're going to
          // throttle committing retries so that we don't show too many
          // loading states too quickly.
          var msUntilTimeout = globalMostRecentFallbackTime + FALLBACK_THROTTLE_MS - now$1(); // Don't bother with a very short suspense time.

          if (msUntilTimeout > 10) {
            if (workInProgressRootHasPendingPing) {
              var lastPingedTime = root.lastPingedTime;

              if (lastPingedTime === NoWork || lastPingedTime >= expirationTime) {
                // This render was pinged but we didn't get to restart
                // earlier so try restarting now instead.
                root.lastPingedTime = expirationTime;
                prepareFreshStack(root, expirationTime);
                break;
              }
            }

            var nextTime = getNextRootExpirationTimeToWorkOn(root);

            if (nextTime !== NoWork && nextTime !== expirationTime) {
              // There's additional work on this root.
              break;
            }

            if (lastSuspendedTime !== NoWork && lastSuspendedTime !== expirationTime) {
              // We should prefer to render the fallback of at the last
              // suspended level. Ping the last suspended level to try
              // rendering it again.
              root.lastPingedTime = lastSuspendedTime;
              break;
            } // The render is suspended, it hasn't timed out, and there's no
            // lower priority work to do. Instead of committing the fallback
            // immediately, wait for more data to arrive.


            root.timeoutHandle = scheduleTimeout(commitRoot.bind(null, root), msUntilTimeout);
            break;
          }
        } // The work expired. Commit immediately.


        commitRoot(root);
        break;
      }

    case RootSuspendedWithDelay:
      {
        markRootSuspendedAtTime(root, expirationTime);
        var _lastSuspendedTime = root.lastSuspendedTime;

        if (expirationTime === _lastSuspendedTime) {
          root.nextKnownPendingLevel = getRemainingExpirationTime(finishedWork);
        }

        if ( // do not delay if we're inside an act() scope
        !( IsThisRendererActing.current)) {
          // We're suspended in a state that should be avoided. We'll try to
          // avoid committing it for as long as the timeouts let us.
          if (workInProgressRootHasPendingPing) {
            var _lastPingedTime = root.lastPingedTime;

            if (_lastPingedTime === NoWork || _lastPingedTime >= expirationTime) {
              // This render was pinged but we didn't get to restart earlier
              // so try restarting now instead.
              root.lastPingedTime = expirationTime;
              prepareFreshStack(root, expirationTime);
              break;
            }
          }

          var _nextTime = getNextRootExpirationTimeToWorkOn(root);

          if (_nextTime !== NoWork && _nextTime !== expirationTime) {
            // There's additional work on this root.
            break;
          }

          if (_lastSuspendedTime !== NoWork && _lastSuspendedTime !== expirationTime) {
            // We should prefer to render the fallback of at the last
            // suspended level. Ping the last suspended level to try
            // rendering it again.
            root.lastPingedTime = _lastSuspendedTime;
            break;
          }

          var _msUntilTimeout;

          if (workInProgressRootLatestSuspenseTimeout !== Sync) {
            // We have processed a suspense config whose expiration time we
            // can use as the timeout.
            _msUntilTimeout = expirationTimeToMs(workInProgressRootLatestSuspenseTimeout) - now$1();
          } else if (workInProgressRootLatestProcessedExpirationTime === Sync) {
            // This should never normally happen because only new updates
            // cause delayed states, so we should have processed something.
            // However, this could also happen in an offscreen tree.
            _msUntilTimeout = 0;
          } else {
            // If we don't have a suspense config, we're going to use a
            // heuristic to determine how long we can suspend.
            var eventTimeMs = inferTimeFromExpirationTime(workInProgressRootLatestProcessedExpirationTime);
            var currentTimeMs = now$1();
            var timeUntilExpirationMs = expirationTimeToMs(expirationTime) - currentTimeMs;
            var timeElapsed = currentTimeMs - eventTimeMs;

            if (timeElapsed < 0) {
              // We get this wrong some time since we estimate the time.
              timeElapsed = 0;
            }

            _msUntilTimeout = jnd(timeElapsed) - timeElapsed; // Clamp the timeout to the expiration time. TODO: Once the
            // event time is exact instead of inferred from expiration time
            // we don't need this.

            if (timeUntilExpirationMs < _msUntilTimeout) {
              _msUntilTimeout = timeUntilExpirationMs;
            }
          } // Don't bother with a very short suspense time.


          if (_msUntilTimeout > 10) {
            // The render is suspended, it hasn't timed out, and there's no
            // lower priority work to do. Instead of committing the fallback
            // immediately, wait for more data to arrive.
            root.timeoutHandle = scheduleTimeout(commitRoot.bind(null, root), _msUntilTimeout);
            break;
          }
        } // The work expired. Commit immediately.


        commitRoot(root);
        break;
      }

    case RootCompleted:
      {
        // The work completed. Ready to commit.
        if ( // do not delay if we're inside an act() scope
        !( IsThisRendererActing.current) && workInProgressRootLatestProcessedExpirationTime !== Sync && workInProgressRootCanSuspendUsingConfig !== null) {
          // If we have exceeded the minimum loading delay, which probably
          // means we have shown a spinner already, we might have to suspend
          // a bit longer to ensure that the spinner is shown for
          // enough time.
          var _msUntilTimeout2 = computeMsUntilSuspenseLoadingDelay(workInProgressRootLatestProcessedExpirationTime, expirationTime, workInProgressRootCanSuspendUsingConfig);

          if (_msUntilTimeout2 > 10) {
            markRootSuspendedAtTime(root, expirationTime);
            root.timeoutHandle = scheduleTimeout(commitRoot.bind(null, root), _msUntilTimeout2);
            break;
          }
        }

        commitRoot(root);
        break;
      }

    default:
      {
        {
          {
            throw Error( "Unknown root exit status." );
          }
        }
      }
  }
} // This is the entry point for synchronous tasks that don't go
// through Scheduler


function performSyncWorkOnRoot(root) {
  // Check if there's expired work on this root. Otherwise, render at Sync.
  var lastExpiredTime = root.lastExpiredTime;
  var expirationTime = lastExpiredTime !== NoWork ? lastExpiredTime : Sync;

  if (!((executionContext & (RenderContext | CommitContext)) === NoContext)) {
    {
      throw Error( "Should not already be working." );
    }
  }

  flushPassiveEffects(); // If the root or expiration time have changed, throw out the existing stack
  // and prepare a fresh one. Otherwise we'll continue where we left off.

  if (root !== workInProgressRoot || expirationTime !== renderExpirationTime$1) {
    prepareFreshStack(root, expirationTime);
    startWorkOnPendingInteractions(root, expirationTime);
  } // If we have a work-in-progress fiber, it means there's still work to do
  // in this root.


  if (workInProgress !== null) {
    var prevExecutionContext = executionContext;
    executionContext |= RenderContext;
    var prevDispatcher = pushDispatcher();
    var prevInteractions = pushInteractions(root);
    startWorkLoopTimer(workInProgress);

    do {
      try {
        workLoopSync();
        break;
      } catch (thrownValue) {
        handleError(root, thrownValue);
      }
    } while (true);

    resetContextDependencies();
    executionContext = prevExecutionContext;
    popDispatcher(prevDispatcher);

    {
      popInteractions(prevInteractions);
    }

    if (workInProgressRootExitStatus === RootFatalErrored) {
      var fatalError = workInProgressRootFatalError;
      stopInterruptedWorkLoopTimer();
      prepareFreshStack(root, expirationTime);
      markRootSuspendedAtTime(root, expirationTime);
      ensureRootIsScheduled(root);
      throw fatalError;
    }

    if (workInProgress !== null) {
      // This is a sync render, so we should have finished the whole tree.
      {
        {
          throw Error( "Cannot commit an incomplete root. This error is likely caused by a bug in React. Please file an issue." );
        }
      }
    } else {
      // We now have a consistent tree. Because this is a sync render, we
      // will commit it even if something suspended.
      stopFinishedWorkLoopTimer();
      root.finishedWork = root.current.alternate;
      root.finishedExpirationTime = expirationTime;
      finishSyncRender(root);
    } // Before exiting, make sure there's a callback scheduled for the next
    // pending level.


    ensureRootIsScheduled(root);
  }

  return null;
}

function finishSyncRender(root) {
  // Set this to null to indicate there's no in-progress render.
  workInProgressRoot = null;
  commitRoot(root);
}

function flushRoot(root, expirationTime) {
  markRootExpiredAtTime(root, expirationTime);
  ensureRootIsScheduled(root);

  if ((executionContext & (RenderContext | CommitContext)) === NoContext) {
    flushSyncCallbackQueue();
  }
}
function flushDiscreteUpdates() {
  // TODO: Should be able to flush inside batchedUpdates, but not inside `act`.
  // However, `act` uses `batchedUpdates`, so there's no way to distinguish
  // those two cases. Need to fix this before exposing flushDiscreteUpdates
  // as a public API.
  if ((executionContext & (BatchedContext | RenderContext | CommitContext)) !== NoContext) {
    {
      if ((executionContext & RenderContext) !== NoContext) {
        error('unstable_flushDiscreteUpdates: Cannot flush updates when React is ' + 'already rendering.');
      }
    } // We're already rendering, so we can't synchronously flush pending work.
    // This is probably a nested event dispatch triggered by a lifecycle/effect,
    // like `el.focus()`. Exit.


    return;
  }

  flushPendingDiscreteUpdates(); // If the discrete updates scheduled passive effects, flush them now so that
  // they fire before the next serial event.

  flushPassiveEffects();
}
function deferredUpdates(fn) {
  // TODO: Remove in favor of Scheduler.next
  return runWithPriority(NormalPriority, fn);
}
function syncUpdates(fn, a, b, c) {
  return runWithPriority(ImmediatePriority, fn.bind(null, a, b, c));
}

function flushPendingDiscreteUpdates() {
  if (rootsWithPendingDiscreteUpdates !== null) {
    // For each root with pending discrete updates, schedule a callback to
    // immediately flush them.
    var roots = rootsWithPendingDiscreteUpdates;
    rootsWithPendingDiscreteUpdates = null;
    roots.forEach(function (expirationTime, root) {
      markRootExpiredAtTime(root, expirationTime);
      ensureRootIsScheduled(root);
    }); // Now flush the immediate queue.

    flushSyncCallbackQueue();
  }
}

function batchedUpdates(fn, a) {
  var prevExecutionContext = executionContext;
  executionContext |= BatchedContext;

  try {
    return fn(a);
  } finally {
    executionContext = prevExecutionContext;

    if (executionContext === NoContext) {
      // Flush the immediate callbacks that were scheduled during this batch
      flushSyncCallbackQueue();
    }
  }
}
function batchedEventUpdates(fn, a) {
  var prevExecutionContext = executionContext;
  executionContext |= EventContext;

  try {
    return fn(a);
  } finally {
    executionContext = prevExecutionContext;

    if (executionContext === NoContext) {
      // Flush the immediate callbacks that were scheduled during this batch
      flushSyncCallbackQueue();
    }
  }
}
function discreteUpdates(fn, a, b, c, d) {
  var prevExecutionContext = executionContext;
  executionContext |= DiscreteEventContext;

  try {
    // Should this
    return runWithPriority(UserBlockingPriority, fn.bind(null, a, b, c, d));
  } finally {
    executionContext = prevExecutionContext;

    if (executionContext === NoContext) {
      // Flush the immediate callbacks that were scheduled during this batch
      flushSyncCallbackQueue();
    }
  }
}
function unbatchedUpdates(fn, a) {
  var prevExecutionContext = executionContext;
  executionContext &= ~BatchedContext;
  executionContext |= LegacyUnbatchedContext;

  try {
    return fn(a);
  } finally {
    executionContext = prevExecutionContext;

    if (executionContext === NoContext) {
      // Flush the immediate callbacks that were scheduled during this batch
      flushSyncCallbackQueue();
    }
  }
}
function flushSync(fn, a) {
  if ((executionContext & (RenderContext | CommitContext)) !== NoContext) {
    {
      {
        throw Error( "flushSync was called from inside a lifecycle method. It cannot be called when React is already rendering." );
      }
    }
  }

  var prevExecutionContext = executionContext;
  executionContext |= BatchedContext;

  try {
    return runWithPriority(ImmediatePriority, fn.bind(null, a));
  } finally {
    executionContext = prevExecutionContext; // Flush the immediate callbacks that were scheduled during this batch.
    // Note that this will happen even if batchedUpdates is higher up
    // the stack.

    flushSyncCallbackQueue();
  }
}
function flushControlled(fn) {
  var prevExecutionContext = executionContext;
  executionContext |= BatchedContext;

  try {
    runWithPriority(ImmediatePriority, fn);
  } finally {
    executionContext = prevExecutionContext;

    if (executionContext === NoContext) {
      // Flush the immediate callbacks that were scheduled during this batch
      flushSyncCallbackQueue();
    }
  }
}

function prepareFreshStack(root, expirationTime) {
  root.finishedWork = null;
  root.finishedExpirationTime = NoWork;
  var timeoutHandle = root.timeoutHandle;

  if (timeoutHandle !== noTimeout) {
    // The root previous suspended and scheduled a timeout to commit a fallback
    // state. Now that we have additional work, cancel the timeout.
    root.timeoutHandle = noTimeout; // $FlowFixMe Complains noTimeout is not a TimeoutID, despite the check above

    cancelTimeout(timeoutHandle);
  }

  if (workInProgress !== null) {
    var interruptedWork = workInProgress.return;

    while (interruptedWork !== null) {
      unwindInterruptedWork(interruptedWork);
      interruptedWork = interruptedWork.return;
    }
  }

  workInProgressRoot = root;
  workInProgress = createWorkInProgress(root.current, null);
  renderExpirationTime$1 = expirationTime;
  workInProgressRootExitStatus = RootIncomplete;
  workInProgressRootFatalError = null;
  workInProgressRootLatestProcessedExpirationTime = Sync;
  workInProgressRootLatestSuspenseTimeout = Sync;
  workInProgressRootCanSuspendUsingConfig = null;
  workInProgressRootNextUnprocessedUpdateTime = NoWork;
  workInProgressRootHasPendingPing = false;

  {
    spawnedWorkDuringRender = null;
  }

  {
    ReactStrictModeWarnings.discardPendingWarnings();
  }
}

function handleError(root, thrownValue) {
  do {
    try {
      // Reset module-level state that was set during the render phase.
      resetContextDependencies();
      resetHooksAfterThrow();
      resetCurrentFiber();

      if (workInProgress === null || workInProgress.return === null) {
        // Expected to be working on a non-root fiber. This is a fatal error
        // because there's no ancestor that can handle it; the root is
        // supposed to capture all errors that weren't caught by an error
        // boundary.
        workInProgressRootExitStatus = RootFatalErrored;
        workInProgressRootFatalError = thrownValue; // Set `workInProgress` to null. This represents advancing to the next
        // sibling, or the parent if there are no siblings. But since the root
        // has no siblings nor a parent, we set it to null. Usually this is
        // handled by `completeUnitOfWork` or `unwindWork`, but since we're
        // interntionally not calling those, we need set it here.
        // TODO: Consider calling `unwindWork` to pop the contexts.

        workInProgress = null;
        return null;
      }

      if (enableProfilerTimer && workInProgress.mode & ProfileMode) {
        // Record the time spent rendering before an error was thrown. This
        // avoids inaccurate Profiler durations in the case of a
        // suspended render.
        stopProfilerTimerIfRunningAndRecordDelta(workInProgress, true);
      }

      throwException(root, workInProgress.return, workInProgress, thrownValue, renderExpirationTime$1);
      workInProgress = completeUnitOfWork(workInProgress);
    } catch (yetAnotherThrownValue) {
      // Something in the return path also threw.
      thrownValue = yetAnotherThrownValue;
      continue;
    } // Return to the normal work loop.


    return;
  } while (true);
}

function pushDispatcher(root) {
  var prevDispatcher = ReactCurrentDispatcher$1.current;
  ReactCurrentDispatcher$1.current = ContextOnlyDispatcher;

  if (prevDispatcher === null) {
    // The React isomorphic package does not include a default dispatcher.
    // Instead the first renderer will lazily attach one, in order to give
    // nicer error messages.
    return ContextOnlyDispatcher;
  } else {
    return prevDispatcher;
  }
}

function popDispatcher(prevDispatcher) {
  ReactCurrentDispatcher$1.current = prevDispatcher;
}

function pushInteractions(root) {
  {
    var prevInteractions = tracing$1.__interactionsRef.current;
    tracing$1.__interactionsRef.current = root.memoizedInteractions;
    return prevInteractions;
  }
}

function popInteractions(prevInteractions) {
  {
    tracing$1.__interactionsRef.current = prevInteractions;
  }
}

function markCommitTimeOfFallback() {
  globalMostRecentFallbackTime = now$1();
}
function markRenderEventTimeAndConfig(expirationTime, suspenseConfig) {
  if (expirationTime < workInProgressRootLatestProcessedExpirationTime && expirationTime > Idle) {
    workInProgressRootLatestProcessedExpirationTime = expirationTime;
  }

  if (suspenseConfig !== null) {
    if (expirationTime < workInProgressRootLatestSuspenseTimeout && expirationTime > Idle) {
      workInProgressRootLatestSuspenseTimeout = expirationTime; // Most of the time we only have one config and getting wrong is not bad.

      workInProgressRootCanSuspendUsingConfig = suspenseConfig;
    }
  }
}
function markUnprocessedUpdateTime(expirationTime) {
  if (expirationTime > workInProgressRootNextUnprocessedUpdateTime) {
    workInProgressRootNextUnprocessedUpdateTime = expirationTime;
  }
}
function renderDidSuspend() {
  if (workInProgressRootExitStatus === RootIncomplete) {
    workInProgressRootExitStatus = RootSuspended;
  }
}
function renderDidSuspendDelayIfPossible() {
  if (workInProgressRootExitStatus === RootIncomplete || workInProgressRootExitStatus === RootSuspended) {
    workInProgressRootExitStatus = RootSuspendedWithDelay;
  } // Check if there's a lower priority update somewhere else in the tree.


  if (workInProgressRootNextUnprocessedUpdateTime !== NoWork && workInProgressRoot !== null) {
    // Mark the current render as suspended, and then mark that there's a
    // pending update.
    // TODO: This should immediately interrupt the current render, instead
    // of waiting until the next time we yield.
    markRootSuspendedAtTime(workInProgressRoot, renderExpirationTime$1);
    markRootUpdatedAtTime(workInProgressRoot, workInProgressRootNextUnprocessedUpdateTime);
  }
}
function renderDidError() {
  if (workInProgressRootExitStatus !== RootCompleted) {
    workInProgressRootExitStatus = RootErrored;
  }
} // Called during render to determine if anything has suspended.
// Returns false if we're not sure.

function renderHasNotSuspendedYet() {
  // If something errored or completed, we can't really be sure,
  // so those are false.
  return workInProgressRootExitStatus === RootIncomplete;
}

function inferTimeFromExpirationTime(expirationTime) {
  // We don't know exactly when the update was scheduled, but we can infer an
  // approximate start time from the expiration time.
  var earliestExpirationTimeMs = expirationTimeToMs(expirationTime);
  return earliestExpirationTimeMs - LOW_PRIORITY_EXPIRATION;
}

function inferTimeFromExpirationTimeWithSuspenseConfig(expirationTime, suspenseConfig) {
  // We don't know exactly when the update was scheduled, but we can infer an
  // approximate start time from the expiration time by subtracting the timeout
  // that was added to the event time.
  var earliestExpirationTimeMs = expirationTimeToMs(expirationTime);
  return earliestExpirationTimeMs - (suspenseConfig.timeoutMs | 0 || LOW_PRIORITY_EXPIRATION);
} // The work loop is an extremely hot path. Tell Closure not to inline it.

/** @noinline */


function workLoopSync() {
  // Already timed out, so perform work without checking if we need to yield.
  while (workInProgress !== null) {
    workInProgress = performUnitOfWork(workInProgress);
  }
}
/** @noinline */


function workLoopConcurrent() {
  // Perform work until Scheduler asks us to yield
  while (workInProgress !== null && !shouldYield()) {
    workInProgress = performUnitOfWork(workInProgress);
  }
}

function performUnitOfWork(unitOfWork) {
  // The current, flushed, state of this fiber is the alternate. Ideally
  // nothing should rely on this, but relying on it here means that we don't
  // need an additional field on the work in progress.
  var current = unitOfWork.alternate;
  startWorkTimer(unitOfWork);
  setCurrentFiber(unitOfWork);
  var next;

  if ( (unitOfWork.mode & ProfileMode) !== NoMode) {
    startProfilerTimer(unitOfWork);
    next = beginWork$1(current, unitOfWork, renderExpirationTime$1);
    stopProfilerTimerIfRunningAndRecordDelta(unitOfWork, true);
  } else {
    next = beginWork$1(current, unitOfWork, renderExpirationTime$1);
  }

  resetCurrentFiber();
  unitOfWork.memoizedProps = unitOfWork.pendingProps;

  if (next === null) {
    // If this doesn't spawn new work, complete the current work.
    next = completeUnitOfWork(unitOfWork);
  }

  ReactCurrentOwner$2.current = null;
  return next;
}

function completeUnitOfWork(unitOfWork) {
  // Attempt to complete the current unit of work, then move to the next
  // sibling. If there are no more siblings, return to the parent fiber.
  workInProgress = unitOfWork;

  do {
    // The current, flushed, state of this fiber is the alternate. Ideally
    // nothing should rely on this, but relying on it here means that we don't
    // need an additional field on the work in progress.
    var current = workInProgress.alternate;
    var returnFiber = workInProgress.return; // Check if the work completed or if something threw.

    if ((workInProgress.effectTag & Incomplete) === NoEffect) {
      setCurrentFiber(workInProgress);
      var next = void 0;

      if ( (workInProgress.mode & ProfileMode) === NoMode) {
        next = completeWork(current, workInProgress, renderExpirationTime$1);
      } else {
        startProfilerTimer(workInProgress);
        next = completeWork(current, workInProgress, renderExpirationTime$1); // Update render duration assuming we didn't error.

        stopProfilerTimerIfRunningAndRecordDelta(workInProgress, false);
      }

      stopWorkTimer(workInProgress);
      resetCurrentFiber();
      resetChildExpirationTime(workInProgress);

      if (next !== null) {
        // Completing this fiber spawned new work. Work on that next.
        return next;
      }

      if (returnFiber !== null && // Do not append effects to parents if a sibling failed to complete
      (returnFiber.effectTag & Incomplete) === NoEffect) {
        // Append all the effects of the subtree and this fiber onto the effect
        // list of the parent. The completion order of the children affects the
        // side-effect order.
        if (returnFiber.firstEffect === null) {
          returnFiber.firstEffect = workInProgress.firstEffect;
        }

        if (workInProgress.lastEffect !== null) {
          if (returnFiber.lastEffect !== null) {
            returnFiber.lastEffect.nextEffect = workInProgress.firstEffect;
          }

          returnFiber.lastEffect = workInProgress.lastEffect;
        } // If this fiber had side-effects, we append it AFTER the children's
        // side-effects. We can perform certain side-effects earlier if needed,
        // by doing multiple passes over the effect list. We don't want to
        // schedule our own side-effect on our own list because if end up
        // reusing children we'll schedule this effect onto itself since we're
        // at the end.


        var effectTag = workInProgress.effectTag; // Skip both NoWork and PerformedWork tags when creating the effect
        // list. PerformedWork effect is read by React DevTools but shouldn't be
        // committed.

        if (effectTag > PerformedWork) {
          if (returnFiber.lastEffect !== null) {
            returnFiber.lastEffect.nextEffect = workInProgress;
          } else {
            returnFiber.firstEffect = workInProgress;
          }

          returnFiber.lastEffect = workInProgress;
        }
      }
    } else {
      // This fiber did not complete because something threw. Pop values off
      // the stack without entering the complete phase. If this is a boundary,
      // capture values if possible.
      var _next = unwindWork(workInProgress); // Because this fiber did not complete, don't reset its expiration time.


      if ( (workInProgress.mode & ProfileMode) !== NoMode) {
        // Record the render duration for the fiber that errored.
        stopProfilerTimerIfRunningAndRecordDelta(workInProgress, false); // Include the time spent working on failed children before continuing.

        var actualDuration = workInProgress.actualDuration;
        var child = workInProgress.child;

        while (child !== null) {
          actualDuration += child.actualDuration;
          child = child.sibling;
        }

        workInProgress.actualDuration = actualDuration;
      }

      if (_next !== null) {
        // If completing this work spawned new work, do that next. We'll come
        // back here again.
        // Since we're restarting, remove anything that is not a host effect
        // from the effect tag.
        // TODO: The name stopFailedWorkTimer is misleading because Suspense
        // also captures and restarts.
        stopFailedWorkTimer(workInProgress);
        _next.effectTag &= HostEffectMask;
        return _next;
      }

      stopWorkTimer(workInProgress);

      if (returnFiber !== null) {
        // Mark the parent fiber as incomplete and clear its effect list.
        returnFiber.firstEffect = returnFiber.lastEffect = null;
        returnFiber.effectTag |= Incomplete;
      }
    }

    var siblingFiber = workInProgress.sibling;

    if (siblingFiber !== null) {
      // If there is more work to do in this returnFiber, do that next.
      return siblingFiber;
    } // Otherwise, return to the parent


    workInProgress = returnFiber;
  } while (workInProgress !== null); // We've reached the root.


  if (workInProgressRootExitStatus === RootIncomplete) {
    workInProgressRootExitStatus = RootCompleted;
  }

  return null;
}

function getRemainingExpirationTime(fiber) {
  var updateExpirationTime = fiber.expirationTime;
  var childExpirationTime = fiber.childExpirationTime;
  return updateExpirationTime > childExpirationTime ? updateExpirationTime : childExpirationTime;
}

function resetChildExpirationTime(completedWork) {
  if (renderExpirationTime$1 !== Never && completedWork.childExpirationTime === Never) {
    // The children of this component are hidden. Don't bubble their
    // expiration times.
    return;
  }

  var newChildExpirationTime = NoWork; // Bubble up the earliest expiration time.

  if ( (completedWork.mode & ProfileMode) !== NoMode) {
    // In profiling mode, resetChildExpirationTime is also used to reset
    // profiler durations.
    var actualDuration = completedWork.actualDuration;
    var treeBaseDuration = completedWork.selfBaseDuration; // When a fiber is cloned, its actualDuration is reset to 0. This value will
    // only be updated if work is done on the fiber (i.e. it doesn't bailout).
    // When work is done, it should bubble to the parent's actualDuration. If
    // the fiber has not been cloned though, (meaning no work was done), then
    // this value will reflect the amount of time spent working on a previous
    // render. In that case it should not bubble. We determine whether it was
    // cloned by comparing the child pointer.

    var shouldBubbleActualDurations = completedWork.alternate === null || completedWork.child !== completedWork.alternate.child;
    var child = completedWork.child;

    while (child !== null) {
      var childUpdateExpirationTime = child.expirationTime;
      var childChildExpirationTime = child.childExpirationTime;

      if (childUpdateExpirationTime > newChildExpirationTime) {
        newChildExpirationTime = childUpdateExpirationTime;
      }

      if (childChildExpirationTime > newChildExpirationTime) {
        newChildExpirationTime = childChildExpirationTime;
      }

      if (shouldBubbleActualDurations) {
        actualDuration += child.actualDuration;
      }

      treeBaseDuration += child.treeBaseDuration;
      child = child.sibling;
    }

    completedWork.actualDuration = actualDuration;
    completedWork.treeBaseDuration = treeBaseDuration;
  } else {
    var _child = completedWork.child;

    while (_child !== null) {
      var _childUpdateExpirationTime = _child.expirationTime;
      var _childChildExpirationTime = _child.childExpirationTime;

      if (_childUpdateExpirationTime > newChildExpirationTime) {
        newChildExpirationTime = _childUpdateExpirationTime;
      }

      if (_childChildExpirationTime > newChildExpirationTime) {
        newChildExpirationTime = _childChildExpirationTime;
      }

      _child = _child.sibling;
    }
  }

  completedWork.childExpirationTime = newChildExpirationTime;
}

function commitRoot(root) {
  var renderPriorityLevel = getCurrentPriorityLevel();
  runWithPriority(ImmediatePriority, commitRootImpl.bind(null, root, renderPriorityLevel));
  return null;
}

function commitRootImpl(root, renderPriorityLevel) {
  do {
    // `flushPassiveEffects` will call `flushSyncUpdateQueue` at the end, which
    // means `flushPassiveEffects` will sometimes result in additional
    // passive effects. So we need to keep flushing in a loop until there are
    // no more pending effects.
    // TODO: Might be better if `flushPassiveEffects` did not automatically
    // flush synchronous work at the end, to avoid factoring hazards like this.
    flushPassiveEffects();
  } while (rootWithPendingPassiveEffects !== null);

  flushRenderPhaseStrictModeWarningsInDEV();

  if (!((executionContext & (RenderContext | CommitContext)) === NoContext)) {
    {
      throw Error( "Should not already be working." );
    }
  }

  var finishedWork = root.finishedWork;
  var expirationTime = root.finishedExpirationTime;

  if (finishedWork === null) {
    return null;
  }

  root.finishedWork = null;
  root.finishedExpirationTime = NoWork;

  if (!(finishedWork !== root.current)) {
    {
      throw Error( "Cannot commit the same tree as before. This error is likely caused by a bug in React. Please file an issue." );
    }
  } // commitRoot never returns a continuation; it always finishes synchronously.
  // So we can clear these now to allow a new callback to be scheduled.


  root.callbackNode = null;
  root.callbackExpirationTime = NoWork;
  root.callbackPriority = NoPriority;
  root.nextKnownPendingLevel = NoWork;
  startCommitTimer(); // Update the first and last pending times on this root. The new first
  // pending time is whatever is left on the root fiber.

  var remainingExpirationTimeBeforeCommit = getRemainingExpirationTime(finishedWork);
  markRootFinishedAtTime(root, expirationTime, remainingExpirationTimeBeforeCommit);

  if (root === workInProgressRoot) {
    // We can reset these now that they are finished.
    workInProgressRoot = null;
    workInProgress = null;
    renderExpirationTime$1 = NoWork;
  } // This indicates that the last root we worked on is not the same one that
  // we're committing now. This most commonly happens when a suspended root
  // times out.
  // Get the list of effects.


  var firstEffect;

  if (finishedWork.effectTag > PerformedWork) {
    // A fiber's effect list consists only of its children, not itself. So if
    // the root has an effect, we need to add it to the end of the list. The
    // resulting list is the set that would belong to the root's parent, if it
    // had one; that is, all the effects in the tree including the root.
    if (finishedWork.lastEffect !== null) {
      finishedWork.lastEffect.nextEffect = finishedWork;
      firstEffect = finishedWork.firstEffect;
    } else {
      firstEffect = finishedWork;
    }
  } else {
    // There is no effect on the root.
    firstEffect = finishedWork.firstEffect;
  }

  if (firstEffect !== null) {
    var prevExecutionContext = executionContext;
    executionContext |= CommitContext;
    var prevInteractions = pushInteractions(root); // Reset this to null before calling lifecycles

    ReactCurrentOwner$2.current = null; // The commit phase is broken into several sub-phases. We do a separate pass
    // of the effect list for each phase: all mutation effects come before all
    // layout effects, and so on.
    // The first phase a "before mutation" phase. We use this phase to read the
    // state of the host tree right before we mutate it. This is where
    // getSnapshotBeforeUpdate is called.

    startCommitSnapshotEffectsTimer();
    prepareForCommit(root.containerInfo);
    nextEffect = firstEffect;

    do {
      {
        invokeGuardedCallback(null, commitBeforeMutationEffects, null);

        if (hasCaughtError()) {
          if (!(nextEffect !== null)) {
            {
              throw Error( "Should be working on an effect." );
            }
          }

          var error = clearCaughtError();
          captureCommitPhaseError(nextEffect, error);
          nextEffect = nextEffect.nextEffect;
        }
      }
    } while (nextEffect !== null);

    stopCommitSnapshotEffectsTimer();

    {
      // Mark the current commit time to be shared by all Profilers in this
      // batch. This enables them to be grouped later.
      recordCommitTime();
    } // The next phase is the mutation phase, where we mutate the host tree.


    startCommitHostEffectsTimer();
    nextEffect = firstEffect;

    do {
      {
        invokeGuardedCallback(null, commitMutationEffects, null, root, renderPriorityLevel);

        if (hasCaughtError()) {
          if (!(nextEffect !== null)) {
            {
              throw Error( "Should be working on an effect." );
            }
          }

          var _error = clearCaughtError();

          captureCommitPhaseError(nextEffect, _error);
          nextEffect = nextEffect.nextEffect;
        }
      }
    } while (nextEffect !== null);

    stopCommitHostEffectsTimer();
    resetAfterCommit(root.containerInfo); // The work-in-progress tree is now the current tree. This must come after
    // the mutation phase, so that the previous tree is still current during
    // componentWillUnmount, but before the layout phase, so that the finished
    // work is current during componentDidMount/Update.

    root.current = finishedWork; // The next phase is the layout phase, where we call effects that read
    // the host tree after it's been mutated. The idiomatic use case for this is
    // layout, but class component lifecycles also fire here for legacy reasons.

    startCommitLifeCyclesTimer();
    nextEffect = firstEffect;

    do {
      {
        invokeGuardedCallback(null, commitLayoutEffects, null, root, expirationTime);

        if (hasCaughtError()) {
          if (!(nextEffect !== null)) {
            {
              throw Error( "Should be working on an effect." );
            }
          }

          var _error2 = clearCaughtError();

          captureCommitPhaseError(nextEffect, _error2);
          nextEffect = nextEffect.nextEffect;
        }
      }
    } while (nextEffect !== null);

    stopCommitLifeCyclesTimer();
    nextEffect = null; // Tell Scheduler to yield at the end of the frame, so the browser has an
    // opportunity to paint.

    requestPaint();

    {
      popInteractions(prevInteractions);
    }

    executionContext = prevExecutionContext;
  } else {
    // No effects.
    root.current = finishedWork; // Measure these anyway so the flamegraph explicitly shows that there were
    // no effects.
    // TODO: Maybe there's a better way to report this.

    startCommitSnapshotEffectsTimer();
    stopCommitSnapshotEffectsTimer();

    {
      recordCommitTime();
    }

    startCommitHostEffectsTimer();
    stopCommitHostEffectsTimer();
    startCommitLifeCyclesTimer();
    stopCommitLifeCyclesTimer();
  }

  stopCommitTimer();
  var rootDidHavePassiveEffects = rootDoesHavePassiveEffects;

  if (rootDoesHavePassiveEffects) {
    // This commit has passive effects. Stash a reference to them. But don't
    // schedule a callback until after flushing layout work.
    rootDoesHavePassiveEffects = false;
    rootWithPendingPassiveEffects = root;
    pendingPassiveEffectsExpirationTime = expirationTime;
    pendingPassiveEffectsRenderPriority = renderPriorityLevel;
  } else {
    // We are done with the effect chain at this point so let's clear the
    // nextEffect pointers to assist with GC. If we have passive effects, we'll
    // clear this in flushPassiveEffects.
    nextEffect = firstEffect;

    while (nextEffect !== null) {
      var nextNextEffect = nextEffect.nextEffect;
      nextEffect.nextEffect = null;
      nextEffect = nextNextEffect;
    }
  } // Check if there's remaining work on this root


  var remainingExpirationTime = root.firstPendingTime;

  if (remainingExpirationTime !== NoWork) {
    {
      if (spawnedWorkDuringRender !== null) {
        var expirationTimes = spawnedWorkDuringRender;
        spawnedWorkDuringRender = null;

        for (var i = 0; i < expirationTimes.length; i++) {
          scheduleInteractions(root, expirationTimes[i], root.memoizedInteractions);
        }
      }

      schedulePendingInteractions(root, remainingExpirationTime);
    }
  } else {
    // If there's no remaining work, we can clear the set of already failed
    // error boundaries.
    legacyErrorBoundariesThatAlreadyFailed = null;
  }

  {
    if (!rootDidHavePassiveEffects) {
      // If there are no passive effects, then we can complete the pending interactions.
      // Otherwise, we'll wait until after the passive effects are flushed.
      // Wait to do this until after remaining work has been scheduled,
      // so that we don't prematurely signal complete for interactions when there's e.g. hidden work.
      finishPendingInteractions(root, expirationTime);
    }
  }

  if (remainingExpirationTime === Sync) {
    // Count the number of times the root synchronously re-renders without
    // finishing. If there are too many, it indicates an infinite update loop.
    if (root === rootWithNestedUpdates) {
      nestedUpdateCount++;
    } else {
      nestedUpdateCount = 0;
      rootWithNestedUpdates = root;
    }
  } else {
    nestedUpdateCount = 0;
  }

  onCommitRoot(finishedWork.stateNode, expirationTime); // Always call this before exiting `commitRoot`, to ensure that any
  // additional work on this root is scheduled.

  ensureRootIsScheduled(root);

  if (hasUncaughtError) {
    hasUncaughtError = false;
    var _error3 = firstUncaughtError;
    firstUncaughtError = null;
    throw _error3;
  }

  if ((executionContext & LegacyUnbatchedContext) !== NoContext) {
    // This is a legacy edge case. We just committed the initial mount of
    // a ReactDOM.render-ed root inside of batchedUpdates. The commit fired
    // synchronously, but layout updates should be deferred until the end
    // of the batch.
    return null;
  } // If layout work was scheduled, flush it now.


  flushSyncCallbackQueue();
  return null;
}

function commitBeforeMutationEffects() {
  while (nextEffect !== null) {
    var effectTag = nextEffect.effectTag;

    if ((effectTag & Snapshot) !== NoEffect) {
      setCurrentFiber(nextEffect);
      recordEffect();
      var current = nextEffect.alternate;
      commitBeforeMutationLifeCycles(current, nextEffect);
      resetCurrentFiber();
    }

    if ((effectTag & Passive) !== NoEffect) {
      // If there are passive effects, schedule a callback to flush at
      // the earliest opportunity.
      if (!rootDoesHavePassiveEffects) {
        rootDoesHavePassiveEffects = true;
        scheduleCallback(NormalPriority, function () {
          flushPassiveEffects();
          return null;
        });
      }
    }

    nextEffect = nextEffect.nextEffect;
  }
}

function commitMutationEffects(root, renderPriorityLevel) {
  // TODO: Should probably move the bulk of this function to commitWork.
  while (nextEffect !== null) {
    setCurrentFiber(nextEffect);
    var effectTag = nextEffect.effectTag;

    if (effectTag & ContentReset) {
      commitResetTextContent(nextEffect);
    }

    if (effectTag & Ref) {
      var current = nextEffect.alternate;

      if (current !== null) {
        commitDetachRef(current);
      }
    } // The following switch statement is only concerned about placement,
    // updates, and deletions. To avoid needing to add a case for every possible
    // bitmap value, we remove the secondary effects from the effect tag and
    // switch on that value.


    var primaryEffectTag = effectTag & (Placement | Update | Deletion | Hydrating);

    switch (primaryEffectTag) {
      case Placement:
        {
          commitPlacement(nextEffect); // Clear the "placement" from effect tag so that we know that this is
          // inserted, before any life-cycles like componentDidMount gets called.
          // TODO: findDOMNode doesn't rely on this any more but isMounted does
          // and isMounted is deprecated anyway so we should be able to kill this.

          nextEffect.effectTag &= ~Placement;
          break;
        }

      case PlacementAndUpdate:
        {
          // Placement
          commitPlacement(nextEffect); // Clear the "placement" from effect tag so that we know that this is
          // inserted, before any life-cycles like componentDidMount gets called.

          nextEffect.effectTag &= ~Placement; // Update

          var _current = nextEffect.alternate;
          commitWork(_current, nextEffect);
          break;
        }

      case Hydrating:
        {
          nextEffect.effectTag &= ~Hydrating;
          break;
        }

      case HydratingAndUpdate:
        {
          nextEffect.effectTag &= ~Hydrating; // Update

          var _current2 = nextEffect.alternate;
          commitWork(_current2, nextEffect);
          break;
        }

      case Update:
        {
          var _current3 = nextEffect.alternate;
          commitWork(_current3, nextEffect);
          break;
        }

      case Deletion:
        {
          commitDeletion(root, nextEffect, renderPriorityLevel);
          break;
        }
    } // TODO: Only record a mutation effect if primaryEffectTag is non-zero.


    recordEffect();
    resetCurrentFiber();
    nextEffect = nextEffect.nextEffect;
  }
}

function commitLayoutEffects(root, committedExpirationTime) {
  // TODO: Should probably move the bulk of this function to commitWork.
  while (nextEffect !== null) {
    setCurrentFiber(nextEffect);
    var effectTag = nextEffect.effectTag;

    if (effectTag & (Update | Callback)) {
      recordEffect();
      var current = nextEffect.alternate;
      commitLifeCycles(root, current, nextEffect);
    }

    if (effectTag & Ref) {
      recordEffect();
      commitAttachRef(nextEffect);
    }

    resetCurrentFiber();
    nextEffect = nextEffect.nextEffect;
  }
}

function flushPassiveEffects() {
  if (pendingPassiveEffectsRenderPriority !== NoPriority) {
    var priorityLevel = pendingPassiveEffectsRenderPriority > NormalPriority ? NormalPriority : pendingPassiveEffectsRenderPriority;
    pendingPassiveEffectsRenderPriority = NoPriority;
    return runWithPriority(priorityLevel, flushPassiveEffectsImpl);
  }
}

function flushPassiveEffectsImpl() {
  if (rootWithPendingPassiveEffects === null) {
    return false;
  }

  var root = rootWithPendingPassiveEffects;
  var expirationTime = pendingPassiveEffectsExpirationTime;
  rootWithPendingPassiveEffects = null;
  pendingPassiveEffectsExpirationTime = NoWork;

  if (!((executionContext & (RenderContext | CommitContext)) === NoContext)) {
    {
      throw Error( "Cannot flush passive effects while already rendering." );
    }
  }

  var prevExecutionContext = executionContext;
  executionContext |= CommitContext;
  var prevInteractions = pushInteractions(root);

  {
    // Note: This currently assumes there are no passive effects on the root fiber
    // because the root is not part of its own effect list.
    // This could change in the future.
    var _effect2 = root.current.firstEffect;

    while (_effect2 !== null) {
      {
        setCurrentFiber(_effect2);
        invokeGuardedCallback(null, commitPassiveHookEffects, null, _effect2);

        if (hasCaughtError()) {
          if (!(_effect2 !== null)) {
            {
              throw Error( "Should be working on an effect." );
            }
          }

          var _error5 = clearCaughtError();

          captureCommitPhaseError(_effect2, _error5);
        }

        resetCurrentFiber();
      }

      var nextNextEffect = _effect2.nextEffect; // Remove nextEffect pointer to assist GC

      _effect2.nextEffect = null;
      _effect2 = nextNextEffect;
    }
  }

  {
    popInteractions(prevInteractions);
    finishPendingInteractions(root, expirationTime);
  }

  executionContext = prevExecutionContext;
  flushSyncCallbackQueue(); // If additional passive effects were scheduled, increment a counter. If this
  // exceeds the limit, we'll fire a warning.

  nestedPassiveUpdateCount = rootWithPendingPassiveEffects === null ? 0 : nestedPassiveUpdateCount + 1;
  return true;
}

function isAlreadyFailedLegacyErrorBoundary(instance) {
  return legacyErrorBoundariesThatAlreadyFailed !== null && legacyErrorBoundariesThatAlreadyFailed.has(instance);
}
function markLegacyErrorBoundaryAsFailed(instance) {
  if (legacyErrorBoundariesThatAlreadyFailed === null) {
    legacyErrorBoundariesThatAlreadyFailed = new Set([instance]);
  } else {
    legacyErrorBoundariesThatAlreadyFailed.add(instance);
  }
}

function prepareToThrowUncaughtError(error) {
  if (!hasUncaughtError) {
    hasUncaughtError = true;
    firstUncaughtError = error;
  }
}

var onUncaughtError = prepareToThrowUncaughtError;

function captureCommitPhaseErrorOnRoot(rootFiber, sourceFiber, error) {
  var errorInfo = createCapturedValue(error, sourceFiber);
  var update = createRootErrorUpdate(rootFiber, errorInfo, Sync);
  enqueueUpdate(rootFiber, update);
  var root = markUpdateTimeFromFiberToRoot(rootFiber, Sync);

  if (root !== null) {
    ensureRootIsScheduled(root);
    schedulePendingInteractions(root, Sync);
  }
}

function captureCommitPhaseError(sourceFiber, error) {
  if (sourceFiber.tag === HostRoot) {
    // Error was thrown at the root. There is no parent, so the root
    // itself should capture it.
    captureCommitPhaseErrorOnRoot(sourceFiber, sourceFiber, error);
    return;
  }

  var fiber = sourceFiber.return;

  while (fiber !== null) {
    if (fiber.tag === HostRoot) {
      captureCommitPhaseErrorOnRoot(fiber, sourceFiber, error);
      return;
    } else if (fiber.tag === ClassComponent) {
      var ctor = fiber.type;
      var instance = fiber.stateNode;

      if (typeof ctor.getDerivedStateFromError === 'function' || typeof instance.componentDidCatch === 'function' && !isAlreadyFailedLegacyErrorBoundary(instance)) {
        var errorInfo = createCapturedValue(error, sourceFiber);
        var update = createClassErrorUpdate(fiber, errorInfo, // TODO: This is always sync
        Sync);
        enqueueUpdate(fiber, update);
        var root = markUpdateTimeFromFiberToRoot(fiber, Sync);

        if (root !== null) {
          ensureRootIsScheduled(root);
          schedulePendingInteractions(root, Sync);
        }

        return;
      }
    }

    fiber = fiber.return;
  }
}
function pingSuspendedRoot(root, thenable, suspendedTime) {
  var pingCache = root.pingCache;

  if (pingCache !== null) {
    // The thenable resolved, so we no longer need to memoize, because it will
    // never be thrown again.
    pingCache.delete(thenable);
  }

  if (workInProgressRoot === root && renderExpirationTime$1 === suspendedTime) {
    // Received a ping at the same priority level at which we're currently
    // rendering. We might want to restart this render. This should mirror
    // the logic of whether or not a root suspends once it completes.
    // TODO: If we're rendering sync either due to Sync, Batched or expired,
    // we should probably never restart.
    // If we're suspended with delay, we'll always suspend so we can always
    // restart. If we're suspended without any updates, it might be a retry.
    // If it's early in the retry we can restart. We can't know for sure
    // whether we'll eventually process an update during this render pass,
    // but it's somewhat unlikely that we get to a ping before that, since
    // getting to the root most update is usually very fast.
    if (workInProgressRootExitStatus === RootSuspendedWithDelay || workInProgressRootExitStatus === RootSuspended && workInProgressRootLatestProcessedExpirationTime === Sync && now$1() - globalMostRecentFallbackTime < FALLBACK_THROTTLE_MS) {
      // Restart from the root. Don't need to schedule a ping because
      // we're already working on this tree.
      prepareFreshStack(root, renderExpirationTime$1);
    } else {
      // Even though we can't restart right now, we might get an
      // opportunity later. So we mark this render as having a ping.
      workInProgressRootHasPendingPing = true;
    }

    return;
  }

  if (!isRootSuspendedAtTime(root, suspendedTime)) {
    // The root is no longer suspended at this time.
    return;
  }

  var lastPingedTime = root.lastPingedTime;

  if (lastPingedTime !== NoWork && lastPingedTime < suspendedTime) {
    // There's already a lower priority ping scheduled.
    return;
  } // Mark the time at which this ping was scheduled.


  root.lastPingedTime = suspendedTime;

  ensureRootIsScheduled(root);
  schedulePendingInteractions(root, suspendedTime);
}

function retryTimedOutBoundary(boundaryFiber, retryTime) {
  // The boundary fiber (a Suspense component or SuspenseList component)
  // previously was rendered in its fallback state. One of the promises that
  // suspended it has resolved, which means at least part of the tree was
  // likely unblocked. Try rendering again, at a new expiration time.
  if (retryTime === NoWork) {
    var suspenseConfig = null; // Retries don't carry over the already committed update.

    var currentTime = requestCurrentTimeForUpdate();
    retryTime = computeExpirationForFiber(currentTime, boundaryFiber, suspenseConfig);
  } // TODO: Special case idle priority?


  var root = markUpdateTimeFromFiberToRoot(boundaryFiber, retryTime);

  if (root !== null) {
    ensureRootIsScheduled(root);
    schedulePendingInteractions(root, retryTime);
  }
}
function resolveRetryThenable(boundaryFiber, thenable) {
  var retryTime = NoWork; // Default

  var retryCache;

  {
    retryCache = boundaryFiber.stateNode;
  }

  if (retryCache !== null) {
    // The thenable resolved, so we no longer need to memoize, because it will
    // never be thrown again.
    retryCache.delete(thenable);
  }

  retryTimedOutBoundary(boundaryFiber, retryTime);
} // Computes the next Just Noticeable Difference (JND) boundary.
// The theory is that a person can't tell the difference between small differences in time.
// Therefore, if we wait a bit longer than necessary that won't translate to a noticeable
// difference in the experience. However, waiting for longer might mean that we can avoid
// showing an intermediate loading state. The longer we have already waited, the harder it
// is to tell small differences in time. Therefore, the longer we've already waited,
// the longer we can wait additionally. At some point we have to give up though.
// We pick a train model where the next boundary commits at a consistent schedule.
// These particular numbers are vague estimates. We expect to adjust them based on research.

function jnd(timeElapsed) {
  return timeElapsed < 120 ? 120 : timeElapsed < 480 ? 480 : timeElapsed < 1080 ? 1080 : timeElapsed < 1920 ? 1920 : timeElapsed < 3000 ? 3000 : timeElapsed < 4320 ? 4320 : ceil(timeElapsed / 1960) * 1960;
}

function computeMsUntilSuspenseLoadingDelay(mostRecentEventTime, committedExpirationTime, suspenseConfig) {
  var busyMinDurationMs = suspenseConfig.busyMinDurationMs | 0;

  if (busyMinDurationMs <= 0) {
    return 0;
  }

  var busyDelayMs = suspenseConfig.busyDelayMs | 0; // Compute the time until this render pass would expire.

  var currentTimeMs = now$1();
  var eventTimeMs = inferTimeFromExpirationTimeWithSuspenseConfig(mostRecentEventTime, suspenseConfig);
  var timeElapsed = currentTimeMs - eventTimeMs;

  if (timeElapsed <= busyDelayMs) {
    // If we haven't yet waited longer than the initial delay, we don't
    // have to wait any additional time.
    return 0;
  }

  var msUntilTimeout = busyDelayMs + busyMinDurationMs - timeElapsed; // This is the value that is passed to `setTimeout`.

  return msUntilTimeout;
}

function checkForNestedUpdates() {
  if (nestedUpdateCount > NESTED_UPDATE_LIMIT) {
    nestedUpdateCount = 0;
    rootWithNestedUpdates = null;

    {
      {
        throw Error( "Maximum update depth exceeded. This can happen when a component repeatedly calls setState inside componentWillUpdate or componentDidUpdate. React limits the number of nested updates to prevent infinite loops." );
      }
    }
  }

  {
    if (nestedPassiveUpdateCount > NESTED_PASSIVE_UPDATE_LIMIT) {
      nestedPassiveUpdateCount = 0;

      error('Maximum update depth exceeded. This can happen when a component ' + "calls setState inside useEffect, but useEffect either doesn't " + 'have a dependency array, or one of the dependencies changes on ' + 'every render.');
    }
  }
}

function flushRenderPhaseStrictModeWarningsInDEV() {
  {
    ReactStrictModeWarnings.flushLegacyContextWarning();

    {
      ReactStrictModeWarnings.flushPendingUnsafeLifecycleWarnings();
    }
  }
}

function stopFinishedWorkLoopTimer() {
  var didCompleteRoot = true;
  stopWorkLoopTimer(interruptedBy, didCompleteRoot);
  interruptedBy = null;
}

function stopInterruptedWorkLoopTimer() {
  // TODO: Track which fiber caused the interruption.
  var didCompleteRoot = false;
  stopWorkLoopTimer(interruptedBy, didCompleteRoot);
  interruptedBy = null;
}

function checkForInterruption(fiberThatReceivedUpdate, updateExpirationTime) {
  if ( workInProgressRoot !== null && updateExpirationTime > renderExpirationTime$1) {
    interruptedBy = fiberThatReceivedUpdate;
  }
}

var didWarnStateUpdateForUnmountedComponent = null;

function warnAboutUpdateOnUnmountedFiberInDEV(fiber) {
  {
    var tag = fiber.tag;

    if (tag !== HostRoot && tag !== ClassComponent && tag !== FunctionComponent && tag !== ForwardRef && tag !== MemoComponent && tag !== SimpleMemoComponent && tag !== Block) {
      // Only warn for user-defined components, not internal ones like Suspense.
      return;
    }
    // the problematic code almost always lies inside that component.


    var componentName = getComponentName(fiber.type) || 'ReactComponent';

    if (didWarnStateUpdateForUnmountedComponent !== null) {
      if (didWarnStateUpdateForUnmountedComponent.has(componentName)) {
        return;
      }

      didWarnStateUpdateForUnmountedComponent.add(componentName);
    } else {
      didWarnStateUpdateForUnmountedComponent = new Set([componentName]);
    }

    error("Can't perform a React state update on an unmounted component. This " + 'is a no-op, but it indicates a memory leak in your application. To ' + 'fix, cancel all subscriptions and asynchronous tasks in %s.%s', tag === ClassComponent ? 'the componentWillUnmount method' : 'a useEffect cleanup function', getStackByFiberInDevAndProd(fiber));
  }
}

var beginWork$1;

{
  var dummyFiber = null;

  beginWork$1 = function (current, unitOfWork, expirationTime) {
    // If a component throws an error, we replay it again in a synchronously
    // dispatched event, so that the debugger will treat it as an uncaught
    // error See ReactErrorUtils for more information.
    // Before entering the begin phase, copy the work-in-progress onto a dummy
    // fiber. If beginWork throws, we'll use this to reset the state.
    var originalWorkInProgressCopy = assignFiberPropertiesInDEV(dummyFiber, unitOfWork);

    try {
      return beginWork(current, unitOfWork, expirationTime);
    } catch (originalError) {
      if (originalError !== null && typeof originalError === 'object' && typeof originalError.then === 'function') {
        // Don't replay promises. Treat everything else like an error.
        throw originalError;
      } // Keep this code in sync with handleError; any changes here must have
      // corresponding changes there.


      resetContextDependencies();
      resetHooksAfterThrow(); // Don't reset current debug fiber, since we're about to work on the
      // same fiber again.
      // Unwind the failed stack frame

      unwindInterruptedWork(unitOfWork); // Restore the original properties of the fiber.

      assignFiberPropertiesInDEV(unitOfWork, originalWorkInProgressCopy);

      if ( unitOfWork.mode & ProfileMode) {
        // Reset the profiler timer.
        startProfilerTimer(unitOfWork);
      } // Run beginWork again.


      invokeGuardedCallback(null, beginWork, null, current, unitOfWork, expirationTime);

      if (hasCaughtError()) {
        var replayError = clearCaughtError(); // `invokeGuardedCallback` sometimes sets an expando `_suppressLogging`.
        // Rethrow this error instead of the original one.

        throw replayError;
      } else {
        // This branch is reachable if the render phase is impure.
        throw originalError;
      }
    }
  };
}

var didWarnAboutUpdateInRender = false;
var didWarnAboutUpdateInRenderForAnotherComponent;

{
  didWarnAboutUpdateInRenderForAnotherComponent = new Set();
}

function warnAboutRenderPhaseUpdatesInDEV(fiber) {
  {
    if (isRendering && (executionContext & RenderContext) !== NoContext) {
      switch (fiber.tag) {
        case FunctionComponent:
        case ForwardRef:
        case SimpleMemoComponent:
          {
            var renderingComponentName = workInProgress && getComponentName(workInProgress.type) || 'Unknown'; // Dedupe by the rendering component because it's the one that needs to be fixed.

            var dedupeKey = renderingComponentName;

            if (!didWarnAboutUpdateInRenderForAnotherComponent.has(dedupeKey)) {
              didWarnAboutUpdateInRenderForAnotherComponent.add(dedupeKey);
              var setStateComponentName = getComponentName(fiber.type) || 'Unknown';

              error('Cannot update a component (`%s`) while rendering a ' + 'different component (`%s`). To locate the bad setState() call inside `%s`, ' + 'follow the stack trace as described in https://fb.me/setstate-in-render', setStateComponentName, renderingComponentName, renderingComponentName);
            }

            break;
          }

        case ClassComponent:
          {
            if (!didWarnAboutUpdateInRender) {
              error('Cannot update during an existing state transition (such as ' + 'within `render`). Render methods should be a pure ' + 'function of props and state.');

              didWarnAboutUpdateInRender = true;
            }

            break;
          }
      }
    }
  }
} // a 'shared' variable that changes when act() opens/closes in tests.


var IsThisRendererActing = {
  current: false
};
function warnIfNotScopedWithMatchingAct(fiber) {
  {
    if (warnsIfNotActing === true && IsSomeRendererActing.current === true && IsThisRendererActing.current !== true) {
      error("It looks like you're using the wrong act() around your test interactions.\n" + 'Be sure to use the matching version of act() corresponding to your renderer:\n\n' + '// for react-dom:\n' + "import {act} from 'react-dom/test-utils';\n" + '// ...\n' + 'act(() => ...);\n\n' + '// for react-test-renderer:\n' + "import TestRenderer from 'react-test-renderer';\n" + 'const {act} = TestRenderer;\n' + '// ...\n' + 'act(() => ...);' + '%s', getStackByFiberInDevAndProd(fiber));
    }
  }
}
function warnIfNotCurrentlyActingEffectsInDEV(fiber) {
  {
    if (warnsIfNotActing === true && (fiber.mode & StrictMode) !== NoMode && IsSomeRendererActing.current === false && IsThisRendererActing.current === false) {
      error('An update to %s ran an effect, but was not wrapped in act(...).\n\n' + 'When testing, code that causes React state updates should be ' + 'wrapped into act(...):\n\n' + 'act(() => {\n' + '  /* fire events that update state */\n' + '});\n' + '/* assert on the output */\n\n' + "This ensures that you're testing the behavior the user would see " + 'in the browser.' + ' Learn more at https://fb.me/react-wrap-tests-with-act' + '%s', getComponentName(fiber.type), getStackByFiberInDevAndProd(fiber));
    }
  }
}

function warnIfNotCurrentlyActingUpdatesInDEV(fiber) {
  {
    if (warnsIfNotActing === true && executionContext === NoContext && IsSomeRendererActing.current === false && IsThisRendererActing.current === false) {
      error('An update to %s inside a test was not wrapped in act(...).\n\n' + 'When testing, code that causes React state updates should be ' + 'wrapped into act(...):\n\n' + 'act(() => {\n' + '  /* fire events that update state */\n' + '});\n' + '/* assert on the output */\n\n' + "This ensures that you're testing the behavior the user would see " + 'in the browser.' + ' Learn more at https://fb.me/react-wrap-tests-with-act' + '%s', getComponentName(fiber.type), getStackByFiberInDevAndProd(fiber));
    }
  }
}

var warnIfNotCurrentlyActingUpdatesInDev = warnIfNotCurrentlyActingUpdatesInDEV; // In tests, we want to enforce a mocked scheduler.

var didWarnAboutUnmockedScheduler = false; // TODO Before we release concurrent mode, revisit this and decide whether a mocked
// scheduler is the actual recommendation. The alternative could be a testing build,
// a new lib, or whatever; we dunno just yet. This message is for early adopters
// to get their tests right.

function warnIfUnmockedScheduler(fiber) {
  {
    if (didWarnAboutUnmockedScheduler === false && Scheduler.unstable_flushAllWithoutAsserting === undefined) {
      if (fiber.mode & BlockingMode || fiber.mode & ConcurrentMode) {
        didWarnAboutUnmockedScheduler = true;

        error('In Concurrent or Sync modes, the "scheduler" module needs to be mocked ' + 'to guarantee consistent behaviour across tests and browsers. ' + 'For example, with jest: \n' + "jest.mock('scheduler', () => require('scheduler/unstable_mock'));\n\n" + 'For more info, visit https://fb.me/react-mock-scheduler');
      }
    }
  }
}

function computeThreadID(root, expirationTime) {
  // Interaction threads are unique per root and expiration time.
  return expirationTime * 1000 + root.interactionThreadID;
}

function markSpawnedWork(expirationTime) {

  if (spawnedWorkDuringRender === null) {
    spawnedWorkDuringRender = [expirationTime];
  } else {
    spawnedWorkDuringRender.push(expirationTime);
  }
}

function scheduleInteractions(root, expirationTime, interactions) {

  if (interactions.size > 0) {
    var pendingInteractionMap = root.pendingInteractionMap;
    var pendingInteractions = pendingInteractionMap.get(expirationTime);

    if (pendingInteractions != null) {
      interactions.forEach(function (interaction) {
        if (!pendingInteractions.has(interaction)) {
          // Update the pending async work count for previously unscheduled interaction.
          interaction.__count++;
        }

        pendingInteractions.add(interaction);
      });
    } else {
      pendingInteractionMap.set(expirationTime, new Set(interactions)); // Update the pending async work count for the current interactions.

      interactions.forEach(function (interaction) {
        interaction.__count++;
      });
    }

    var subscriber = tracing$1.__subscriberRef.current;

    if (subscriber !== null) {
      var threadID = computeThreadID(root, expirationTime);
      subscriber.onWorkScheduled(interactions, threadID);
    }
  }
}

function schedulePendingInteractions(root, expirationTime) {

  scheduleInteractions(root, expirationTime, tracing$1.__interactionsRef.current);
}

function startWorkOnPendingInteractions(root, expirationTime) {
  // we can accurately attribute time spent working on it, And so that cascading
  // work triggered during the render phase will be associated with it.


  var interactions = new Set();
  root.pendingInteractionMap.forEach(function (scheduledInteractions, scheduledExpirationTime) {
    if (scheduledExpirationTime >= expirationTime) {
      scheduledInteractions.forEach(function (interaction) {
        return interactions.add(interaction);
      });
    }
  }); // Store the current set of interactions on the FiberRoot for a few reasons:
  // We can re-use it in hot functions like performConcurrentWorkOnRoot()
  // without having to recalculate it. We will also use it in commitWork() to
  // pass to any Profiler onRender() hooks. This also provides DevTools with a
  // way to access it when the onCommitRoot() hook is called.

  root.memoizedInteractions = interactions;

  if (interactions.size > 0) {
    var subscriber = tracing$1.__subscriberRef.current;

    if (subscriber !== null) {
      var threadID = computeThreadID(root, expirationTime);

      try {
        subscriber.onWorkStarted(interactions, threadID);
      } catch (error) {
        // If the subscriber throws, rethrow it in a separate task
        scheduleCallback(ImmediatePriority, function () {
          throw error;
        });
      }
    }
  }
}

function finishPendingInteractions(root, committedExpirationTime) {

  var earliestRemainingTimeAfterCommit = root.firstPendingTime;
  var subscriber;

  try {
    subscriber = tracing$1.__subscriberRef.current;

    if (subscriber !== null && root.memoizedInteractions.size > 0) {
      var threadID = computeThreadID(root, committedExpirationTime);
      subscriber.onWorkStopped(root.memoizedInteractions, threadID);
    }
  } catch (error) {
    // If the subscriber throws, rethrow it in a separate task
    scheduleCallback(ImmediatePriority, function () {
      throw error;
    });
  } finally {
    // Clear completed interactions from the pending Map.
    // Unless the render was suspended or cascading work was scheduled,
    // In which case– leave pending interactions until the subsequent render.
    var pendingInteractionMap = root.pendingInteractionMap;
    pendingInteractionMap.forEach(function (scheduledInteractions, scheduledExpirationTime) {
      // Only decrement the pending interaction count if we're done.
      // If there's still work at the current priority,
      // That indicates that we are waiting for suspense data.
      if (scheduledExpirationTime > earliestRemainingTimeAfterCommit) {
        pendingInteractionMap.delete(scheduledExpirationTime);
        scheduledInteractions.forEach(function (interaction) {
          interaction.__count--;

          if (subscriber !== null && interaction.__count === 0) {
            try {
              subscriber.onInteractionScheduledWorkCompleted(interaction);
            } catch (error) {
              // If the subscriber throws, rethrow it in a separate task
              scheduleCallback(ImmediatePriority, function () {
                throw error;
              });
            }
          }
        });
      }
    });
  }
}

var onScheduleFiberRoot = null;
var onCommitFiberRoot = null;
var onCommitFiberUnmount = null;
var hasLoggedError = false;
var isDevToolsPresent = typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ !== 'undefined';
function injectInternals(internals) {
  if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ === 'undefined') {
    // No DevTools
    return false;
  }

  var hook = __REACT_DEVTOOLS_GLOBAL_HOOK__;

  if (hook.isDisabled) {
    // This isn't a real property on the hook, but it can be set to opt out
    // of DevTools integration and associated warnings and logs.
    // https://github.com/facebook/react/issues/3877
    return true;
  }

  if (!hook.supportsFiber) {
    {
      error('The installed version of React DevTools is too old and will not work ' + 'with the current version of React. Please update React DevTools. ' + 'https://fb.me/react-devtools');
    } // DevTools exists, even though it doesn't support Fiber.


    return true;
  }

  try {
    var rendererID = hook.inject(internals); // We have successfully injected, so now it is safe to set up hooks.

    if (true) {
      // Only used by Fast Refresh
      if (typeof hook.onScheduleFiberRoot === 'function') {
        onScheduleFiberRoot = function (root, children) {
          try {
            hook.onScheduleFiberRoot(rendererID, root, children);
          } catch (err) {
            if ( true && !hasLoggedError) {
              hasLoggedError = true;

              error('React instrumentation encountered an error: %s', err);
            }
          }
        };
      }
    }

    onCommitFiberRoot = function (root, expirationTime) {
      try {
        var didError = (root.current.effectTag & DidCapture) === DidCapture;

        if (enableProfilerTimer) {
          var currentTime = getCurrentTime();
          var priorityLevel = inferPriorityFromExpirationTime(currentTime, expirationTime);
          hook.onCommitFiberRoot(rendererID, root, priorityLevel, didError);
        }
      } catch (err) {
        if (true) {
          if (!hasLoggedError) {
            hasLoggedError = true;

            error('React instrumentation encountered an error: %s', err);
          }
        }
      }
    };

    onCommitFiberUnmount = function (fiber) {
      try {
        hook.onCommitFiberUnmount(rendererID, fiber);
      } catch (err) {
        if (true) {
          if (!hasLoggedError) {
            hasLoggedError = true;

            error('React instrumentation encountered an error: %s', err);
          }
        }
      }
    };
  } catch (err) {
    // Catch all errors because it is unsafe to throw during initialization.
    {
      error('React instrumentation encountered an error: %s.', err);
    }
  } // DevTools exists


  return true;
}
function onScheduleRoot(root, children) {
  if (typeof onScheduleFiberRoot === 'function') {
    onScheduleFiberRoot(root, children);
  }
}
function onCommitRoot(root, expirationTime) {
  if (typeof onCommitFiberRoot === 'function') {
    onCommitFiberRoot(root, expirationTime);
  }
}
function onCommitUnmount(fiber) {
  if (typeof onCommitFiberUnmount === 'function') {
    onCommitFiberUnmount(fiber);
  }
}

var hasBadMapPolyfill;

{
  hasBadMapPolyfill = false;

  try {
    var nonExtensibleObject = Object.preventExtensions({});
    var testMap = new Map([[nonExtensibleObject, null]]);
    var testSet = new Set([nonExtensibleObject]); // This is necessary for Rollup to not consider these unused.
    // https://github.com/rollup/rollup/issues/1771
    // TODO: we can remove these if Rollup fixes the bug.

    testMap.set(0, 0);
    testSet.add(0);
  } catch (e) {
    // TODO: Consider warning about bad polyfills
    hasBadMapPolyfill = true;
  }
}

var debugCounter = 1;

function FiberNode(tag, pendingProps, key, mode) {
  // Instance
  this.tag = tag;
  this.key = key;
  this.elementType = null;
  this.type = null;
  this.stateNode = null; // Fiber

  this.return = null;
  this.child = null;
  this.sibling = null;
  this.index = 0;
  this.ref = null;
  this.pendingProps = pendingProps;
  this.memoizedProps = null;
  this.updateQueue = null;
  this.memoizedState = null;
  this.dependencies = null;
  this.mode = mode; // Effects

  this.effectTag = NoEffect;
  this.nextEffect = null;
  this.firstEffect = null;
  this.lastEffect = null;
  this.expirationTime = NoWork;
  this.childExpirationTime = NoWork;
  this.alternate = null;

  {
    // Note: The following is done to avoid a v8 performance cliff.
    //
    // Initializing the fields below to smis and later updating them with
    // double values will cause Fibers to end up having separate shapes.
    // This behavior/bug has something to do with Object.preventExtension().
    // Fortunately this only impacts DEV builds.
    // Unfortunately it makes React unusably slow for some applications.
    // To work around this, initialize the fields below with doubles.
    //
    // Learn more about this here:
    // https://github.com/facebook/react/issues/14365
    // https://bugs.chromium.org/p/v8/issues/detail?id=8538
    this.actualDuration = Number.NaN;
    this.actualStartTime = Number.NaN;
    this.selfBaseDuration = Number.NaN;
    this.treeBaseDuration = Number.NaN; // It's okay to replace the initial doubles with smis after initialization.
    // This won't trigger the performance cliff mentioned above,
    // and it simplifies other profiler code (including DevTools).

    this.actualDuration = 0;
    this.actualStartTime = -1;
    this.selfBaseDuration = 0;
    this.treeBaseDuration = 0;
  } // This is normally DEV-only except www when it adds listeners.
  // TODO: remove the User Timing integration in favor of Root Events.


  {
    this._debugID = debugCounter++;
    this._debugIsCurrentlyTiming = false;
  }

  {
    this._debugSource = null;
    this._debugOwner = null;
    this._debugNeedsRemount = false;
    this._debugHookTypes = null;

    if (!hasBadMapPolyfill && typeof Object.preventExtensions === 'function') {
      Object.preventExtensions(this);
    }
  }
} // This is a constructor function, rather than a POJO constructor, still
// please ensure we do the following:
// 1) Nobody should add any instance methods on this. Instance methods can be
//    more difficult to predict when they get optimized and they are almost
//    never inlined properly in static compilers.
// 2) Nobody should rely on `instanceof Fiber` for type testing. We should
//    always know when it is a fiber.
// 3) We might want to experiment with using numeric keys since they are easier
//    to optimize in a non-JIT environment.
// 4) We can easily go from a constructor to a createFiber object literal if that
//    is faster.
// 5) It should be easy to port this to a C struct and keep a C implementation
//    compatible.


var createFiber = function (tag, pendingProps, key, mode) {
  // $FlowFixMe: the shapes are exact here but Flow doesn't like constructors
  return new FiberNode(tag, pendingProps, key, mode);
};

function shouldConstruct(Component) {
  var prototype = Component.prototype;
  return !!(prototype && prototype.isReactComponent);
}

function isSimpleFunctionComponent(type) {
  return typeof type === 'function' && !shouldConstruct(type) && type.defaultProps === undefined;
}
function resolveLazyComponentTag(Component) {
  if (typeof Component === 'function') {
    return shouldConstruct(Component) ? ClassComponent : FunctionComponent;
  } else if (Component !== undefined && Component !== null) {
    var $$typeof = Component.$$typeof;

    if ($$typeof === REACT_FORWARD_REF_TYPE) {
      return ForwardRef;
    }

    if ($$typeof === REACT_MEMO_TYPE) {
      return MemoComponent;
    }
  }

  return IndeterminateComponent;
} // This is used to create an alternate fiber to do work on.

function createWorkInProgress(current, pendingProps) {
  var workInProgress = current.alternate;

  if (workInProgress === null) {
    // We use a double buffering pooling technique because we know that we'll
    // only ever need at most two versions of a tree. We pool the "other" unused
    // node that we're free to reuse. This is lazily created to avoid allocating
    // extra objects for things that are never updated. It also allow us to
    // reclaim the extra memory if needed.
    workInProgress = createFiber(current.tag, pendingProps, current.key, current.mode);
    workInProgress.elementType = current.elementType;
    workInProgress.type = current.type;
    workInProgress.stateNode = current.stateNode;

    {
      // DEV-only fields
      {
        workInProgress._debugID = current._debugID;
      }

      workInProgress._debugSource = current._debugSource;
      workInProgress._debugOwner = current._debugOwner;
      workInProgress._debugHookTypes = current._debugHookTypes;
    }

    workInProgress.alternate = current;
    current.alternate = workInProgress;
  } else {
    workInProgress.pendingProps = pendingProps; // We already have an alternate.
    // Reset the effect tag.

    workInProgress.effectTag = NoEffect; // The effect list is no longer valid.

    workInProgress.nextEffect = null;
    workInProgress.firstEffect = null;
    workInProgress.lastEffect = null;

    {
      // We intentionally reset, rather than copy, actualDuration & actualStartTime.
      // This prevents time from endlessly accumulating in new commits.
      // This has the downside of resetting values for different priority renders,
      // But works for yielding (the common case) and should support resuming.
      workInProgress.actualDuration = 0;
      workInProgress.actualStartTime = -1;
    }
  }

  workInProgress.childExpirationTime = current.childExpirationTime;
  workInProgress.expirationTime = current.expirationTime;
  workInProgress.child = current.child;
  workInProgress.memoizedProps = current.memoizedProps;
  workInProgress.memoizedState = current.memoizedState;
  workInProgress.updateQueue = current.updateQueue; // Clone the dependencies object. This is mutated during the render phase, so
  // it cannot be shared with the current fiber.

  var currentDependencies = current.dependencies;
  workInProgress.dependencies = currentDependencies === null ? null : {
    expirationTime: currentDependencies.expirationTime,
    firstContext: currentDependencies.firstContext,
    responders: currentDependencies.responders
  }; // These will be overridden during the parent's reconciliation

  workInProgress.sibling = current.sibling;
  workInProgress.index = current.index;
  workInProgress.ref = current.ref;

  {
    workInProgress.selfBaseDuration = current.selfBaseDuration;
    workInProgress.treeBaseDuration = current.treeBaseDuration;
  }

  {
    workInProgress._debugNeedsRemount = current._debugNeedsRemount;

    switch (workInProgress.tag) {
      case IndeterminateComponent:
      case FunctionComponent:
      case SimpleMemoComponent:
        workInProgress.type = resolveFunctionForHotReloading(current.type);
        break;

      case ClassComponent:
        workInProgress.type = resolveClassForHotReloading(current.type);
        break;

      case ForwardRef:
        workInProgress.type = resolveForwardRefForHotReloading(current.type);
        break;
    }
  }

  return workInProgress;
} // Used to reuse a Fiber for a second pass.

function resetWorkInProgress(workInProgress, renderExpirationTime) {
  // This resets the Fiber to what createFiber or createWorkInProgress would
  // have set the values to before during the first pass. Ideally this wouldn't
  // be necessary but unfortunately many code paths reads from the workInProgress
  // when they should be reading from current and writing to workInProgress.
  // We assume pendingProps, index, key, ref, return are still untouched to
  // avoid doing another reconciliation.
  // Reset the effect tag but keep any Placement tags, since that's something
  // that child fiber is setting, not the reconciliation.
  workInProgress.effectTag &= Placement; // The effect list is no longer valid.

  workInProgress.nextEffect = null;
  workInProgress.firstEffect = null;
  workInProgress.lastEffect = null;
  var current = workInProgress.alternate;

  if (current === null) {
    // Reset to createFiber's initial values.
    workInProgress.childExpirationTime = NoWork;
    workInProgress.expirationTime = renderExpirationTime;
    workInProgress.child = null;
    workInProgress.memoizedProps = null;
    workInProgress.memoizedState = null;
    workInProgress.updateQueue = null;
    workInProgress.dependencies = null;

    {
      // Note: We don't reset the actualTime counts. It's useful to accumulate
      // actual time across multiple render passes.
      workInProgress.selfBaseDuration = 0;
      workInProgress.treeBaseDuration = 0;
    }
  } else {
    // Reset to the cloned values that createWorkInProgress would've.
    workInProgress.childExpirationTime = current.childExpirationTime;
    workInProgress.expirationTime = current.expirationTime;
    workInProgress.child = current.child;
    workInProgress.memoizedProps = current.memoizedProps;
    workInProgress.memoizedState = current.memoizedState;
    workInProgress.updateQueue = current.updateQueue; // Clone the dependencies object. This is mutated during the render phase, so
    // it cannot be shared with the current fiber.

    var currentDependencies = current.dependencies;
    workInProgress.dependencies = currentDependencies === null ? null : {
      expirationTime: currentDependencies.expirationTime,
      firstContext: currentDependencies.firstContext,
      responders: currentDependencies.responders
    };

    {
      // Note: We don't reset the actualTime counts. It's useful to accumulate
      // actual time across multiple render passes.
      workInProgress.selfBaseDuration = current.selfBaseDuration;
      workInProgress.treeBaseDuration = current.treeBaseDuration;
    }
  }

  return workInProgress;
}
function createHostRootFiber(tag) {
  var mode;

  if (tag === ConcurrentRoot) {
    mode = ConcurrentMode | BlockingMode | StrictMode;
  } else if (tag === BlockingRoot) {
    mode = BlockingMode | StrictMode;
  } else {
    mode = NoMode;
  }

  if ( isDevToolsPresent) {
    // Always collect profile timings when DevTools are present.
    // This enables DevTools to start capturing timing at any point–
    // Without some nodes in the tree having empty base times.
    mode |= ProfileMode;
  }

  return createFiber(HostRoot, null, null, mode);
}
function createFiberFromTypeAndProps(type, // React$ElementType
key, pendingProps, owner, mode, expirationTime) {
  var fiber;
  var fiberTag = IndeterminateComponent; // The resolved type is set if we know what the final type will be. I.e. it's not lazy.

  var resolvedType = type;

  if (typeof type === 'function') {
    if (shouldConstruct(type)) {
      fiberTag = ClassComponent;

      {
        resolvedType = resolveClassForHotReloading(resolvedType);
      }
    } else {
      {
        resolvedType = resolveFunctionForHotReloading(resolvedType);
      }
    }
  } else if (typeof type === 'string') {
    fiberTag = HostComponent;
  } else {
    getTag: switch (type) {
      case REACT_FRAGMENT_TYPE:
        return createFiberFromFragment(pendingProps.children, mode, expirationTime, key);

      case REACT_CONCURRENT_MODE_TYPE:
        fiberTag = Mode;
        mode |= ConcurrentMode | BlockingMode | StrictMode;
        break;

      case REACT_STRICT_MODE_TYPE:
        fiberTag = Mode;
        mode |= StrictMode;
        break;

      case REACT_PROFILER_TYPE:
        return createFiberFromProfiler(pendingProps, mode, expirationTime, key);

      case REACT_SUSPENSE_TYPE:
        return createFiberFromSuspense(pendingProps, mode, expirationTime, key);

      case REACT_SUSPENSE_LIST_TYPE:
        return createFiberFromSuspenseList(pendingProps, mode, expirationTime, key);

      default:
        {
          if (typeof type === 'object' && type !== null) {
            switch (type.$$typeof) {
              case REACT_PROVIDER_TYPE:
                fiberTag = ContextProvider;
                break getTag;

              case REACT_CONTEXT_TYPE:
                // This is a consumer
                fiberTag = ContextConsumer;
                break getTag;

              case REACT_FORWARD_REF_TYPE:
                fiberTag = ForwardRef;

                {
                  resolvedType = resolveForwardRefForHotReloading(resolvedType);
                }

                break getTag;

              case REACT_MEMO_TYPE:
                fiberTag = MemoComponent;
                break getTag;

              case REACT_LAZY_TYPE:
                fiberTag = LazyComponent;
                resolvedType = null;
                break getTag;

              case REACT_BLOCK_TYPE:
                fiberTag = Block;
                break getTag;

            }
          }

          var info = '';

          {
            if (type === undefined || typeof type === 'object' && type !== null && Object.keys(type).length === 0) {
              info += ' You likely forgot to export your component from the file ' + "it's defined in, or you might have mixed up default and " + 'named imports.';
            }

            var ownerName = owner ? getComponentName(owner.type) : null;

            if (ownerName) {
              info += '\n\nCheck the render method of `' + ownerName + '`.';
            }
          }

          {
            {
              throw Error( "Element type is invalid: expected a string (for built-in components) or a class/function (for composite components) but got: " + (type == null ? type : typeof type) + "." + info );
            }
          }
        }
    }
  }

  fiber = createFiber(fiberTag, pendingProps, key, mode);
  fiber.elementType = type;
  fiber.type = resolvedType;
  fiber.expirationTime = expirationTime;
  return fiber;
}
function createFiberFromElement(element, mode, expirationTime) {
  var owner = null;

  {
    owner = element._owner;
  }

  var type = element.type;
  var key = element.key;
  var pendingProps = element.props;
  var fiber = createFiberFromTypeAndProps(type, key, pendingProps, owner, mode, expirationTime);

  {
    fiber._debugSource = element._source;
    fiber._debugOwner = element._owner;
  }

  return fiber;
}
function createFiberFromFragment(elements, mode, expirationTime, key) {
  var fiber = createFiber(Fragment, elements, key, mode);
  fiber.expirationTime = expirationTime;
  return fiber;
}

function createFiberFromProfiler(pendingProps, mode, expirationTime, key) {
  {
    if (typeof pendingProps.id !== 'string' || typeof pendingProps.onRender !== 'function') {
      error('Profiler must specify an "id" string and "onRender" function as props');
    }
  }

  var fiber = createFiber(Profiler, pendingProps, key, mode | ProfileMode); // TODO: The Profiler fiber shouldn't have a type. It has a tag.

  fiber.elementType = REACT_PROFILER_TYPE;
  fiber.type = REACT_PROFILER_TYPE;
  fiber.expirationTime = expirationTime;
  return fiber;
}

function createFiberFromSuspense(pendingProps, mode, expirationTime, key) {
  var fiber = createFiber(SuspenseComponent, pendingProps, key, mode); // TODO: The SuspenseComponent fiber shouldn't have a type. It has a tag.
  // This needs to be fixed in getComponentName so that it relies on the tag
  // instead.

  fiber.type = REACT_SUSPENSE_TYPE;
  fiber.elementType = REACT_SUSPENSE_TYPE;
  fiber.expirationTime = expirationTime;
  return fiber;
}
function createFiberFromSuspenseList(pendingProps, mode, expirationTime, key) {
  var fiber = createFiber(SuspenseListComponent, pendingProps, key, mode);

  {
    // TODO: The SuspenseListComponent fiber shouldn't have a type. It has a tag.
    // This needs to be fixed in getComponentName so that it relies on the tag
    // instead.
    fiber.type = REACT_SUSPENSE_LIST_TYPE;
  }

  fiber.elementType = REACT_SUSPENSE_LIST_TYPE;
  fiber.expirationTime = expirationTime;
  return fiber;
}
function createFiberFromText(content, mode, expirationTime) {
  var fiber = createFiber(HostText, content, null, mode);
  fiber.expirationTime = expirationTime;
  return fiber;
}
function createFiberFromHostInstanceForDeletion() {
  var fiber = createFiber(HostComponent, null, null, NoMode); // TODO: These should not need a type.

  fiber.elementType = 'DELETED';
  fiber.type = 'DELETED';
  return fiber;
}
function createFiberFromPortal(portal, mode, expirationTime) {
  var pendingProps = portal.children !== null ? portal.children : [];
  var fiber = createFiber(HostPortal, pendingProps, portal.key, mode);
  fiber.expirationTime = expirationTime;
  fiber.stateNode = {
    containerInfo: portal.containerInfo,
    pendingChildren: null,
    // Used by persistent updates
    implementation: portal.implementation
  };
  return fiber;
} // Used for stashing WIP properties to replay failed work in DEV.

function assignFiberPropertiesInDEV(target, source) {
  if (target === null) {
    // This Fiber's initial properties will always be overwritten.
    // We only use a Fiber to ensure the same hidden class so DEV isn't slow.
    target = createFiber(IndeterminateComponent, null, null, NoMode);
  } // This is intentionally written as a list of all properties.
  // We tried to use Object.assign() instead but this is called in
  // the hottest path, and Object.assign() was too slow:
  // https://github.com/facebook/react/issues/12502
  // This code is DEV-only so size is not a concern.


  target.tag = source.tag;
  target.key = source.key;
  target.elementType = source.elementType;
  target.type = source.type;
  target.stateNode = source.stateNode;
  target.return = source.return;
  target.child = source.child;
  target.sibling = source.sibling;
  target.index = source.index;
  target.ref = source.ref;
  target.pendingProps = source.pendingProps;
  target.memoizedProps = source.memoizedProps;
  target.updateQueue = source.updateQueue;
  target.memoizedState = source.memoizedState;
  target.dependencies = source.dependencies;
  target.mode = source.mode;
  target.effectTag = source.effectTag;
  target.nextEffect = source.nextEffect;
  target.firstEffect = source.firstEffect;
  target.lastEffect = source.lastEffect;
  target.expirationTime = source.expirationTime;
  target.childExpirationTime = source.childExpirationTime;
  target.alternate = source.alternate;

  {
    target.actualDuration = source.actualDuration;
    target.actualStartTime = source.actualStartTime;
    target.selfBaseDuration = source.selfBaseDuration;
    target.treeBaseDuration = source.treeBaseDuration;
  }

  {
    target._debugID = source._debugID;
  }

  target._debugSource = source._debugSource;
  target._debugOwner = source._debugOwner;
  target._debugIsCurrentlyTiming = source._debugIsCurrentlyTiming;
  target._debugNeedsRemount = source._debugNeedsRemount;
  target._debugHookTypes = source._debugHookTypes;
  return target;
}

function FiberRootNode(containerInfo, tag, hydrate) {
  this.tag = tag;
  this.current = null;
  this.containerInfo = containerInfo;
  this.pendingChildren = null;
  this.pingCache = null;
  this.finishedExpirationTime = NoWork;
  this.finishedWork = null;
  this.timeoutHandle = noTimeout;
  this.context = null;
  this.pendingContext = null;
  this.hydrate = hydrate;
  this.callbackNode = null;
  this.callbackPriority = NoPriority;
  this.firstPendingTime = NoWork;
  this.firstSuspendedTime = NoWork;
  this.lastSuspendedTime = NoWork;
  this.nextKnownPendingLevel = NoWork;
  this.lastPingedTime = NoWork;
  this.lastExpiredTime = NoWork;

  {
    this.interactionThreadID = tracing$1.unstable_getThreadID();
    this.memoizedInteractions = new Set();
    this.pendingInteractionMap = new Map();
  }
}

function createFiberRoot(containerInfo, tag, hydrate, hydrationCallbacks) {
  var root = new FiberRootNode(containerInfo, tag, hydrate);
  // stateNode is any.


  var uninitializedFiber = createHostRootFiber(tag);
  root.current = uninitializedFiber;
  uninitializedFiber.stateNode = root;
  initializeUpdateQueue(uninitializedFiber);
  return root;
}
function isRootSuspendedAtTime(root, expirationTime) {
  var firstSuspendedTime = root.firstSuspendedTime;
  var lastSuspendedTime = root.lastSuspendedTime;
  return firstSuspendedTime !== NoWork && firstSuspendedTime >= expirationTime && lastSuspendedTime <= expirationTime;
}
function markRootSuspendedAtTime(root, expirationTime) {
  var firstSuspendedTime = root.firstSuspendedTime;
  var lastSuspendedTime = root.lastSuspendedTime;

  if (firstSuspendedTime < expirationTime) {
    root.firstSuspendedTime = expirationTime;
  }

  if (lastSuspendedTime > expirationTime || firstSuspendedTime === NoWork) {
    root.lastSuspendedTime = expirationTime;
  }

  if (expirationTime <= root.lastPingedTime) {
    root.lastPingedTime = NoWork;
  }

  if (expirationTime <= root.lastExpiredTime) {
    root.lastExpiredTime = NoWork;
  }
}
function markRootUpdatedAtTime(root, expirationTime) {
  // Update the range of pending times
  var firstPendingTime = root.firstPendingTime;

  if (expirationTime > firstPendingTime) {
    root.firstPendingTime = expirationTime;
  } // Update the range of suspended times. Treat everything lower priority or
  // equal to this update as unsuspended.


  var firstSuspendedTime = root.firstSuspendedTime;

  if (firstSuspendedTime !== NoWork) {
    if (expirationTime >= firstSuspendedTime) {
      // The entire suspended range is now unsuspended.
      root.firstSuspendedTime = root.lastSuspendedTime = root.nextKnownPendingLevel = NoWork;
    } else if (expirationTime >= root.lastSuspendedTime) {
      root.lastSuspendedTime = expirationTime + 1;
    } // This is a pending level. Check if it's higher priority than the next
    // known pending level.


    if (expirationTime > root.nextKnownPendingLevel) {
      root.nextKnownPendingLevel = expirationTime;
    }
  }
}
function markRootFinishedAtTime(root, finishedExpirationTime, remainingExpirationTime) {
  // Update the range of pending times
  root.firstPendingTime = remainingExpirationTime; // Update the range of suspended times. Treat everything higher priority or
  // equal to this update as unsuspended.

  if (finishedExpirationTime <= root.lastSuspendedTime) {
    // The entire suspended range is now unsuspended.
    root.firstSuspendedTime = root.lastSuspendedTime = root.nextKnownPendingLevel = NoWork;
  } else if (finishedExpirationTime <= root.firstSuspendedTime) {
    // Part of the suspended range is now unsuspended. Narrow the range to
    // include everything between the unsuspended time (non-inclusive) and the
    // last suspended time.
    root.firstSuspendedTime = finishedExpirationTime - 1;
  }

  if (finishedExpirationTime <= root.lastPingedTime) {
    // Clear the pinged time
    root.lastPingedTime = NoWork;
  }

  if (finishedExpirationTime <= root.lastExpiredTime) {
    // Clear the expired time
    root.lastExpiredTime = NoWork;
  }
}
function markRootExpiredAtTime(root, expirationTime) {
  var lastExpiredTime = root.lastExpiredTime;

  if (lastExpiredTime === NoWork || lastExpiredTime > expirationTime) {
    root.lastExpiredTime = expirationTime;
  }
}

var didWarnAboutMessageChannel = false;
var enqueueTaskImpl = null;
function enqueueTask(task) {
  if (enqueueTaskImpl === null) {
    try {
      // read require off the module object to get around the bundlers.
      // we don't want them to detect a require and bundle a Node polyfill.
      var requireString = ('require' + Math.random()).slice(0, 7);
      var nodeRequire = module && module[requireString]; // assuming we're in node, let's try to get node's
      // version of setImmediate, bypassing fake timers if any.

      enqueueTaskImpl = nodeRequire('timers').setImmediate;
    } catch (_err) {
      // we're in a browser
      // we can't use regular timers because they may still be faked
      // so we try MessageChannel+postMessage instead
      enqueueTaskImpl = function (callback) {
        {
          if (didWarnAboutMessageChannel === false) {
            didWarnAboutMessageChannel = true;

            if (typeof MessageChannel === 'undefined') {
              error('This browser does not have a MessageChannel implementation, ' + 'so enqueuing tasks via await act(async () => ...) will fail. ' + 'Please file an issue at https://github.com/facebook/react/issues ' + 'if you encounter this warning.');
            }
          }
        }

        var channel = new MessageChannel();
        channel.port1.onmessage = callback;
        channel.port2.postMessage(undefined);
      };
    }
  }

  return enqueueTaskImpl(task);
}

var didWarnAboutNestedUpdates;
var didWarnAboutFindNodeInStrictMode;

{
  didWarnAboutNestedUpdates = false;
  didWarnAboutFindNodeInStrictMode = {};
}

function getContextForSubtree(parentComponent) {
  if (!parentComponent) {
    return emptyContextObject;
  }

  var fiber = get(parentComponent);
  var parentContext = findCurrentUnmaskedContext(fiber);

  if (fiber.tag === ClassComponent) {
    var Component = fiber.type;

    if (isContextProvider(Component)) {
      return processChildContext(fiber, Component, parentContext);
    }
  }

  return parentContext;
}

function findHostInstance(component) {
  var fiber = get(component);

  if (fiber === undefined) {
    if (typeof component.render === 'function') {
      {
        {
          throw Error( "Unable to find node on an unmounted component." );
        }
      }
    } else {
      {
        {
          throw Error( "Argument appears to not be a ReactComponent. Keys: " + Object.keys(component) );
        }
      }
    }
  }

  var hostFiber = findCurrentHostFiber(fiber);

  if (hostFiber === null) {
    return null;
  }

  return hostFiber.stateNode;
}

function findHostInstanceWithWarning(component, methodName) {
  {
    var fiber = get(component);

    if (fiber === undefined) {
      if (typeof component.render === 'function') {
        {
          {
            throw Error( "Unable to find node on an unmounted component." );
          }
        }
      } else {
        {
          {
            throw Error( "Argument appears to not be a ReactComponent. Keys: " + Object.keys(component) );
          }
        }
      }
    }

    var hostFiber = findCurrentHostFiber(fiber);

    if (hostFiber === null) {
      return null;
    }

    if (hostFiber.mode & StrictMode) {
      var componentName = getComponentName(fiber.type) || 'Component';

      if (!didWarnAboutFindNodeInStrictMode[componentName]) {
        didWarnAboutFindNodeInStrictMode[componentName] = true;

        if (fiber.mode & StrictMode) {
          error('%s is deprecated in StrictMode. ' + '%s was passed an instance of %s which is inside StrictMode. ' + 'Instead, add a ref directly to the element you want to reference. ' + 'Learn more about using refs safely here: ' + 'https://fb.me/react-strict-mode-find-node%s', methodName, methodName, componentName, getStackByFiberInDevAndProd(hostFiber));
        } else {
          error('%s is deprecated in StrictMode. ' + '%s was passed an instance of %s which renders StrictMode children. ' + 'Instead, add a ref directly to the element you want to reference. ' + 'Learn more about using refs safely here: ' + 'https://fb.me/react-strict-mode-find-node%s', methodName, methodName, componentName, getStackByFiberInDevAndProd(hostFiber));
        }
      }
    }

    return hostFiber.stateNode;
  }
}

function createContainer(containerInfo, tag, hydrate, hydrationCallbacks) {
  return createFiberRoot(containerInfo, tag, hydrate);
}
function updateContainer(element, container, parentComponent, callback) {
  {
    onScheduleRoot(container, element);
  }

  var current$1 = container.current;
  var currentTime = requestCurrentTimeForUpdate();

  {
    // $FlowExpectedError - jest isn't a global, and isn't recognized outside of tests
    if ('undefined' !== typeof jest) {
      warnIfUnmockedScheduler(current$1);
      warnIfNotScopedWithMatchingAct(current$1);
    }
  }

  var suspenseConfig = requestCurrentSuspenseConfig();
  var expirationTime = computeExpirationForFiber(currentTime, current$1, suspenseConfig);
  var context = getContextForSubtree(parentComponent);

  if (container.context === null) {
    container.context = context;
  } else {
    container.pendingContext = context;
  }

  {
    if (isRendering && current !== null && !didWarnAboutNestedUpdates) {
      didWarnAboutNestedUpdates = true;

      error('Render methods should be a pure function of props and state; ' + 'triggering nested component updates from render is not allowed. ' + 'If necessary, trigger nested updates in componentDidUpdate.\n\n' + 'Check the render method of %s.', getComponentName(current.type) || 'Unknown');
    }
  }

  var update = createUpdate(expirationTime, suspenseConfig); // Caution: React DevTools currently depends on this property
  // being called "element".

  update.payload = {
    element: element
  };
  callback = callback === undefined ? null : callback;

  if (callback !== null) {
    {
      if (typeof callback !== 'function') {
        error('render(...): Expected the last optional `callback` argument to be a ' + 'function. Instead received: %s.', callback);
      }
    }

    update.callback = callback;
  }

  enqueueUpdate(current$1, update);
  scheduleWork(current$1, expirationTime);
  return expirationTime;
}
function getPublicRootInstance(container) {
  var containerFiber = container.current;

  if (!containerFiber.child) {
    return null;
  }

  switch (containerFiber.child.tag) {
    case HostComponent:
      return getPublicInstance(containerFiber.child.stateNode);

    default:
      return containerFiber.child.stateNode;
  }
}
function attemptSynchronousHydration(fiber) {
  switch (fiber.tag) {
    case HostRoot:
      var root = fiber.stateNode;

      if (root.hydrate) {
        // Flush the first scheduled "update".
        flushRoot(root, root.firstPendingTime);
      }

      break;

    case SuspenseComponent:
      flushSync(function () {
        return scheduleWork(fiber, Sync);
      }); // If we're still blocked after this, we need to increase
      // the priority of any promises resolving within this
      // boundary so that they next attempt also has higher pri.

      var retryExpTime = computeInteractiveExpiration(requestCurrentTimeForUpdate());
      markRetryTimeIfNotHydrated(fiber, retryExpTime);
      break;
  }
}

function markRetryTimeImpl(fiber, retryTime) {
  var suspenseState = fiber.memoizedState;

  if (suspenseState !== null && suspenseState.dehydrated !== null) {
    if (suspenseState.retryTime < retryTime) {
      suspenseState.retryTime = retryTime;
    }
  }
} // Increases the priority of thennables when they resolve within this boundary.


function markRetryTimeIfNotHydrated(fiber, retryTime) {
  markRetryTimeImpl(fiber, retryTime);
  var alternate = fiber.alternate;

  if (alternate) {
    markRetryTimeImpl(alternate, retryTime);
  }
}

function attemptUserBlockingHydration(fiber) {
  if (fiber.tag !== SuspenseComponent) {
    // We ignore HostRoots here because we can't increase
    // their priority and they should not suspend on I/O,
    // since you have to wrap anything that might suspend in
    // Suspense.
    return;
  }

  var expTime = computeInteractiveExpiration(requestCurrentTimeForUpdate());
  scheduleWork(fiber, expTime);
  markRetryTimeIfNotHydrated(fiber, expTime);
}
function attemptContinuousHydration(fiber) {
  if (fiber.tag !== SuspenseComponent) {
    // We ignore HostRoots here because we can't increase
    // their priority and they should not suspend on I/O,
    // since you have to wrap anything that might suspend in
    // Suspense.
    return;
  }

  scheduleWork(fiber, ContinuousHydration);
  markRetryTimeIfNotHydrated(fiber, ContinuousHydration);
}
function attemptHydrationAtCurrentPriority(fiber) {
  if (fiber.tag !== SuspenseComponent) {
    // We ignore HostRoots here because we can't increase
    // their priority other than synchronously flush it.
    return;
  }

  var currentTime = requestCurrentTimeForUpdate();
  var expTime = computeExpirationForFiber(currentTime, fiber, null);
  scheduleWork(fiber, expTime);
  markRetryTimeIfNotHydrated(fiber, expTime);
}
function findHostInstanceWithNoPortals(fiber) {
  var hostFiber = findCurrentHostFiberWithNoPortals(fiber);

  if (hostFiber === null) {
    return null;
  }

  if (hostFiber.tag === FundamentalComponent) {
    return hostFiber.stateNode.instance;
  }

  return hostFiber.stateNode;
}

var shouldSuspendImpl = function (fiber) {
  return false;
};

function shouldSuspend(fiber) {
  return shouldSuspendImpl(fiber);
}
var overrideHookState = null;
var overrideProps = null;
var scheduleUpdate = null;
var setSuspenseHandler = null;

{
  var copyWithSetImpl = function (obj, path, idx, value) {
    if (idx >= path.length) {
      return value;
    }

    var key = path[idx];
    var updated = Array.isArray(obj) ? obj.slice() : _assign({}, obj); // $FlowFixMe number or string is fine here

    updated[key] = copyWithSetImpl(obj[key], path, idx + 1, value);
    return updated;
  };

  var copyWithSet = function (obj, path, value) {
    return copyWithSetImpl(obj, path, 0, value);
  }; // Support DevTools editable values for useState and useReducer.


  overrideHookState = function (fiber, id, path, value) {
    // For now, the "id" of stateful hooks is just the stateful hook index.
    // This may change in the future with e.g. nested hooks.
    var currentHook = fiber.memoizedState;

    while (currentHook !== null && id > 0) {
      currentHook = currentHook.next;
      id--;
    }

    if (currentHook !== null) {
      var newState = copyWithSet(currentHook.memoizedState, path, value);
      currentHook.memoizedState = newState;
      currentHook.baseState = newState; // We aren't actually adding an update to the queue,
      // because there is no update we can add for useReducer hooks that won't trigger an error.
      // (There's no appropriate action type for DevTools overrides.)
      // As a result though, React will see the scheduled update as a noop and bailout.
      // Shallow cloning props works as a workaround for now to bypass the bailout check.

      fiber.memoizedProps = _assign({}, fiber.memoizedProps);
      scheduleWork(fiber, Sync);
    }
  }; // Support DevTools props for function components, forwardRef, memo, host components, etc.


  overrideProps = function (fiber, path, value) {
    fiber.pendingProps = copyWithSet(fiber.memoizedProps, path, value);

    if (fiber.alternate) {
      fiber.alternate.pendingProps = fiber.pendingProps;
    }

    scheduleWork(fiber, Sync);
  };

  scheduleUpdate = function (fiber) {
    scheduleWork(fiber, Sync);
  };

  setSuspenseHandler = function (newShouldSuspendImpl) {
    shouldSuspendImpl = newShouldSuspendImpl;
  };
}

function injectIntoDevTools(devToolsConfig) {
  var findFiberByHostInstance = devToolsConfig.findFiberByHostInstance;
  var ReactCurrentDispatcher = ReactSharedInternals.ReactCurrentDispatcher;
  return injectInternals(_assign({}, devToolsConfig, {
    overrideHookState: overrideHookState,
    overrideProps: overrideProps,
    setSuspenseHandler: setSuspenseHandler,
    scheduleUpdate: scheduleUpdate,
    currentDispatcherRef: ReactCurrentDispatcher,
    findHostInstanceByFiber: function (fiber) {
      var hostFiber = findCurrentHostFiber(fiber);

      if (hostFiber === null) {
        return null;
      }

      return hostFiber.stateNode;
    },
    findFiberByHostInstance: function (instance) {
      if (!findFiberByHostInstance) {
        // Might not be implemented by the renderer.
        return null;
      }

      return findFiberByHostInstance(instance);
    },
    // React Refresh
    findHostInstancesForRefresh:  findHostInstancesForRefresh ,
    scheduleRefresh:  scheduleRefresh ,
    scheduleRoot:  scheduleRoot ,
    setRefreshHandler:  setRefreshHandler ,
    // Enables DevTools to append owner stacks to error messages in DEV mode.
    getCurrentFiber:  function () {
      return current;
    } 
  }));
}
var IsSomeRendererActing$1 = ReactSharedInternals.IsSomeRendererActing;
var isSchedulerMocked = typeof Scheduler.unstable_flushAllWithoutAsserting === 'function';

var flushWork = Scheduler.unstable_flushAllWithoutAsserting || function () {
  var didFlushWork = false;

  while (flushPassiveEffects()) {
    didFlushWork = true;
  }

  return didFlushWork;
};

function flushWorkAndMicroTasks(onDone) {
  try {
    flushWork();
    enqueueTask(function () {
      if (flushWork()) {
        flushWorkAndMicroTasks(onDone);
      } else {
        onDone();
      }
    });
  } catch (err) {
    onDone(err);
  }
} // we track the 'depth' of the act() calls with this counter,
// so we can tell if any async act() calls try to run in parallel.


var actingUpdatesScopeDepth = 0;

function act(callback) {

  var previousActingUpdatesScopeDepth = actingUpdatesScopeDepth;
  var previousIsSomeRendererActing;
  var previousIsThisRendererActing;
  actingUpdatesScopeDepth++;
  previousIsSomeRendererActing = IsSomeRendererActing$1.current;
  previousIsThisRendererActing = IsThisRendererActing.current;
  IsSomeRendererActing$1.current = true;
  IsThisRendererActing.current = true;

  function onDone() {
    actingUpdatesScopeDepth--;
    IsSomeRendererActing$1.current = previousIsSomeRendererActing;
    IsThisRendererActing.current = previousIsThisRendererActing;

    {
      if (actingUpdatesScopeDepth > previousActingUpdatesScopeDepth) {
        // if it's _less than_ previousActingUpdatesScopeDepth, then we can assume the 'other' one has warned
        error('You seem to have overlapping act() calls, this is not supported. ' + 'Be sure to await previous act() calls before making a new one. ');
      }
    }
  }

  var result;

  try {
    result = batchedUpdates(callback);
  } catch (error) {
    // on sync errors, we still want to 'cleanup' and decrement actingUpdatesScopeDepth
    onDone();
    throw error;
  }

  if (result !== null && typeof result === 'object' && typeof result.then === 'function') {
    // setup a boolean that gets set to true only
    // once this act() call is await-ed
    var called = false;

    {
      if (typeof Promise !== 'undefined') {
        //eslint-disable-next-line no-undef
        Promise.resolve().then(function () {}).then(function () {
          if (called === false) {
            error('You called act(async () => ...) without await. ' + 'This could lead to unexpected testing behaviour, interleaving multiple act ' + 'calls and mixing their scopes. You should - await act(async () => ...);');
          }
        });
      }
    } // in the async case, the returned thenable runs the callback, flushes
    // effects and  microtasks in a loop until flushPassiveEffects() === false,
    // and cleans up


    return {
      then: function (resolve, reject) {
        called = true;
        result.then(function () {
          if (actingUpdatesScopeDepth > 1 || isSchedulerMocked === true && previousIsSomeRendererActing === true) {
            onDone();
            resolve();
            return;
          } // we're about to exit the act() scope,
          // now's the time to flush tasks/effects


          flushWorkAndMicroTasks(function (err) {
            onDone();

            if (err) {
              reject(err);
            } else {
              resolve();
            }
          });
        }, function (err) {
          onDone();
          reject(err);
        });
      }
    };
  } else {
    {
      if (result !== undefined) {
        error('The callback passed to act(...) function ' + 'must return undefined, or a Promise. You returned %s', result);
      }
    } // flush effects until none remain, and cleanup


    try {
      if (actingUpdatesScopeDepth === 1 && (isSchedulerMocked === false || previousIsSomeRendererActing === false)) {
        // we're about to exit the act() scope,
        // now's the time to flush effects
        flushWork();
      }

      onDone();
    } catch (err) {
      onDone();
      throw err;
    } // in the sync case, the returned thenable only warns *if* await-ed


    return {
      then: function (resolve) {
        {
          error('Do not await the result of calling act(...) with sync logic, it is not a Promise.');
        }

        resolve();
      }
    };
  }
}

var ReactFiberReconciler = /*#__PURE__*/Object.freeze({
  __proto__: null,
  createContainer: createContainer,
  updateContainer: updateContainer,
  batchedEventUpdates: batchedEventUpdates,
  batchedUpdates: batchedUpdates,
  unbatchedUpdates: unbatchedUpdates,
  deferredUpdates: deferredUpdates,
  syncUpdates: syncUpdates,
  discreteUpdates: discreteUpdates,
  flushDiscreteUpdates: flushDiscreteUpdates,
  flushControlled: flushControlled,
  flushSync: flushSync,
  flushPassiveEffects: flushPassiveEffects,
  IsThisRendererActing: IsThisRendererActing,
  getPublicRootInstance: getPublicRootInstance,
  attemptSynchronousHydration: attemptSynchronousHydration,
  attemptUserBlockingHydration: attemptUserBlockingHydration,
  attemptContinuousHydration: attemptContinuousHydration,
  attemptHydrationAtCurrentPriority: attemptHydrationAtCurrentPriority,
  findHostInstance: findHostInstance,
  findHostInstanceWithWarning: findHostInstanceWithWarning,
  findHostInstanceWithNoPortals: findHostInstanceWithNoPortals,
  shouldSuspend: shouldSuspend,
  injectIntoDevTools: injectIntoDevTools,
  act: act
});

function getCjsExportFromNamespace (n) {
	return n && n['default'] || n;
}

var ReactFiberReconciler$1 = getCjsExportFromNamespace(ReactFiberReconciler);

// TODO: decide on the top-level export form.
// This is hacky but makes it work with both Rollup and Jest.


var reactReconciler = ReactFiberReconciler$1.default || ReactFiberReconciler$1;

module.exports = reactReconciler;
    var $$$renderer = module.exports;
    module.exports = $$$reconciler;
    return $$$renderer;
  };
}
});

var reactReconciler = createCommonjsModule(function (module) {

{
  module.exports = reactReconciler_development;
}
});

const panelBaseNames = new Set([
    'CircularProgressBar',
    'Slider',
    'SlottedSlider',
]);
function fixPanelBase(panel) {
    for (const [key, value] of Object.entries(temporaryPanelHost)) {
        if (typeof value === 'function') {
            panel[key] = value;
        }
    }
}

/* eslint-disable @typescript-eslint/prefer-optional-chain */
const panelPropertyInformation = {};
function definePanelPropertyInformation(name, properties) {
    panelPropertyInformation[name] = properties;
}
const PANORAMA_INVALID_DATE = 2 ** 52;
const propertiesInformation = {
    id: { type: 2 /* INITIAL_ONLY */, initial: false },
    enabled: { type: 0 /* SET */, name: 'enabled' },
    visible: { type: 0 /* SET */, name: 'visible' },
    hittest: { type: 0 /* SET */, name: 'hittest', initial: true, throwOnIncomplete: true },
    hittestchildren: {
        type: 0 /* SET */,
        name: 'hittestchildren',
        initial: true,
        throwOnIncomplete: true,
    },
    acceptsfocus: { type: 1 /* SETTER */, name: 'SetAcceptsFocus', initial: true },
    // @ts-expect-error tabindex setter accepts 'auto'
    tabindex: { type: 0 /* SET */, name: 'tabindex', initial: true, throwOnIncomplete: true },
    inputnamespace: {
        type: 0 /* SET */,
        name: 'inputnamespace',
        initial: true,
        throwOnIncomplete: true,
    },
    useglobalcontext: { type: 2 /* INITIAL_ONLY */, initial: true },
    disallowedstyleflags: { type: 2 /* INITIAL_ONLY */, initial: true },
    'never-cache-composition-layer': { type: 2 /* INITIAL_ONLY */, initial: true },
    'always-cache-composition-layer': { type: 2 /* INITIAL_ONLY */, initial: true },
    'require-composition-layer': { type: 2 /* INITIAL_ONLY */, initial: true },
    registerforreadyevents: { type: 2 /* INITIAL_ONLY */, initial: true },
    readyfordisplay: { type: 2 /* INITIAL_ONLY */, initial: true },
    clipaftertransform: { type: 2 /* INITIAL_ONLY */, initial: true },
    rememberchildfocus: { type: 2 /* INITIAL_ONLY */, initial: true },
    keepscrolltobottom: { type: 2 /* INITIAL_ONLY */, initial: true },
    sendchildscrolledintoviewevents: { type: 2 /* INITIAL_ONLY */, initial: true },
    'overscroll-x': { type: 2 /* INITIAL_ONLY */, initial: true },
    'overscroll-y': { type: 2 /* INITIAL_ONLY */, initial: true },
    scrollparenttofitwhenfocused: { type: 2 /* INITIAL_ONLY */, initial: true },
    acceptsinput: { type: 2 /* INITIAL_ONLY */, initial: true },
    analogstickscroll: { type: 2 /* INITIAL_ONLY */, initial: true },
    childfocusonhover: { type: 2 /* INITIAL_ONLY */, initial: true },
    focusonhover: { type: 2 /* INITIAL_ONLY */, initial: true },
    mousecanactivate: { type: 2 /* INITIAL_ONLY */, initial: true },
    defaultfocus: { type: 2 /* INITIAL_ONLY */, initial: true },
    dialogVariables: {
        type: 3 /* CUSTOM */,
        update(panel, newValue = {}, oldValue = {}) {
            function unassignDialogVariable(key, old) {
                if (old !== undefined)
                    return;
                if (typeof old === 'string') {
                    panel.SetDialogVariable(key, `[!s:${key}]`);
                }
                else if (typeof old === 'number') {
                    // eslint-disable-next-line unicorn/prefer-number-properties
                    panel.SetDialogVariableInt(key, NaN);
                }
                else {
                    panel.SetDialogVariableTime(key, PANORAMA_INVALID_DATE);
                }
            }
            for (const key in newValue) {
                const value = newValue[key];
                if (value !== oldValue[key]) {
                    // eslint-disable-next-line @typescript-eslint/no-unnecessary-condition
                    if (value === undefined) {
                        unassignDialogVariable(key, oldValue[key]);
                    }
                    else if (typeof value === 'string') {
                        panel.SetDialogVariable(key, value);
                    }
                    else if (typeof value === 'number') {
                        panel.SetDialogVariableInt(key, value);
                    }
                    else {
                        panel.SetDialogVariableTime(key, Math.floor(value.getTime() / 1000));
                    }
                }
            }
            for (const key in oldValue) {
                if (!(key in newValue)) {
                    unassignDialogVariable(key, oldValue[key]);
                }
            }
        },
    },
    style: {
        type: 3 /* CUSTOM */,
        update(panel, newValue = {}, oldValue = {}) {
            for (const styleName in newValue) {
                if (newValue[styleName] !== oldValue[styleName]) {
                    panel.style[styleName] = newValue[styleName];
                }
            }
            for (const styleName in oldValue) {
                if (!(styleName in newValue)) {
                    panel.style[styleName] = null;
                }
            }
        },
        throwOnIncomplete: true,
    },
    className: {
        type: 3 /* CUSTOM */,
        initial: 'class',
        update(panel, newValue = '', oldValue = '') {
            const newClasses = newValue.split(' ');
            for (const className of newClasses) {
                panel.AddClass(className);
            }
            for (const className of oldValue.split(' ')) {
                if (!newClasses.includes(className)) {
                    panel.RemoveClass(className);
                }
            }
        },
    },
    draggable: { type: 1 /* SETTER */, name: 'SetDraggable' },
};
const labelTextAttributes = {
    text: {
        type: 3 /* CUSTOM */,
        update(panel, newValue) {
            if (typeof newValue === 'function') {
                panel.text = newValue(panel);
            }
            else {
                panel.text = newValue;
            }
        },
    },
    localizedText: { type: 2 /* INITIAL_ONLY */, initial: 'text' },
};
definePanelPropertyInformation('Label', Object.assign(Object.assign({}, labelTextAttributes), { allowtextselection: { type: 2 /* INITIAL_ONLY */, initial: true }, unlocalized: { type: 2 /* INITIAL_ONLY */, initial: true }, imgscaling: { type: 2 /* INITIAL_ONLY */, initial: true }, html: { type: 2 /* INITIAL_ONLY */, initial: true } }));
const imageAttributes = {
    svgfillrule: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgopacity: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgstrokeopacity: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgstrokelinejoin: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgstrokelinecap: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgstrokewidth: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgstroke: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgfillopacity: { type: 2 /* INITIAL_ONLY */, initial: true },
    svgfill: { type: 2 /* INITIAL_ONLY */, initial: true },
    texturewidth: { type: 2 /* INITIAL_ONLY */, initial: true },
    textureheight: { type: 2 /* INITIAL_ONLY */, initial: true },
    srcset: { type: 2 /* INITIAL_ONLY */, initial: true },
    animate: { type: 2 /* INITIAL_ONLY */, initial: true },
    defaultsrc: { type: 2 /* INITIAL_ONLY */, initial: true },
    src: { type: 1 /* SETTER */, name: 'SetImage', initial: true },
    verticalalign: { type: 2 /* INITIAL_ONLY */, initial: true },
    horizontalalign: { type: 2 /* INITIAL_ONLY */, initial: true },
    scaling: { type: 1 /* SETTER */, name: 'SetScaling', initial: true },
};
definePanelPropertyInformation('Image', imageAttributes);
definePanelPropertyInformation('DOTAAbilityImage', Object.assign(Object.assign({}, imageAttributes), { abilityname: { type: 0 /* SET */, name: 'abilityname', initial: true }, contextEntityIndex: { type: 0 /* SET */, name: 'contextEntityIndex' }, showtooltip: { type: 2 /* INITIAL_ONLY */, initial: true }, abilityid: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('DOTAItemImage', Object.assign(Object.assign({}, imageAttributes), { itemname: { type: 0 /* SET */, name: 'itemname', initial: true }, contextEntityIndex: { type: 0 /* SET */, name: 'contextEntityIndex' }, showtooltip: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('DOTAHeroImage', Object.assign(Object.assign({}, imageAttributes), { heroid: { type: 0 /* SET */, name: 'heroid', initial: true }, heroname: { type: 0 /* SET */, name: 'heroname', initial: true }, heroimagestyle: { type: 0 /* SET */, name: 'heroimagestyle', initial: true }, persona: { type: 0 /* SET */, name: 'persona', initial: true }, usedefaultimage: { type: 2 /* INITIAL_ONLY */, initial: true }, defaultimage: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('DOTALeagueImage', Object.assign(Object.assign({}, imageAttributes), { leagueid: { type: 0 /* SET */, name: 'leagueid', initial: true }, leagueimagestyle: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('EconItemImage', Object.assign(Object.assign({}, imageAttributes), { itemdef: { type: 2 /* INITIAL_ONLY */, initial: true }, itemstyle: { type: 2 /* INITIAL_ONLY */, initial: 'styleindex' } }));
const animatedImageStripAttributes = Object.assign(Object.assign({}, imageAttributes), { framewidth: { type: 2 /* INITIAL_ONLY */, initial: true }, frameheight: { type: 2 /* INITIAL_ONLY */, initial: true }, frametime: { type: 2 /* INITIAL_ONLY */, initial: true }, defaultframe: { type: 2 /* INITIAL_ONLY */, initial: true }, animating: { type: 2 /* INITIAL_ONLY */, initial: true } });
definePanelPropertyInformation('AnimatedImageStrip', animatedImageStripAttributes);
definePanelPropertyInformation('DOTAEmoticon', Object.assign(Object.assign({}, animatedImageStripAttributes), { emoticonid: { type: 2 /* INITIAL_ONLY */, initial: true }, alias: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('Movie', {
    src: { type: 1 /* SETTER */, name: 'SetMovie', initial: true },
    volume: { type: 1 /* SETTER */, name: 'SetPlaybackVolume', initial: true },
    muted: { type: 2 /* INITIAL_ONLY */, initial: true },
    repeat: { type: 1 /* SETTER */, name: 'SetRepeat', initial: true },
    notreadybehavior: { type: 2 /* INITIAL_ONLY */, initial: true },
    loadbehavior: { type: 2 /* INITIAL_ONLY */, initial: true },
    autoplay: { type: 2 /* INITIAL_ONLY */, initial: true },
    title: { type: 1 /* SETTER */, name: 'SetTitle', initial: true },
    controls: { type: 1 /* SETTER */, name: 'SetControls', initial: true },
});
definePanelPropertyInformation('DOTAHeroMovie', {
    src: { type: 2 /* INITIAL_ONLY */, initial: true },
    volume: { type: 2 /* INITIAL_ONLY */, initial: true },
    muted: { type: 2 /* INITIAL_ONLY */, initial: true },
    repeat: { type: 2 /* INITIAL_ONLY */, initial: true },
    notreadybehavior: { type: 2 /* INITIAL_ONLY */, initial: true },
    loadbehavior: { type: 2 /* INITIAL_ONLY */, initial: true },
    autoplay: { type: 2 /* INITIAL_ONLY */, initial: true },
    heroid: { type: 0 /* SET */, name: 'heroid', initial: true },
    heroname: { type: 0 /* SET */, name: 'heroname', initial: true },
    persona: { type: 0 /* SET */, name: 'persona', initial: true },
});
const createSceneRotationSetter = (propName) => ({
    type: 3 /* CUSTOM */,
    update(panel, newValue) {
        if (panel._rotateParams === undefined)
            panel._rotateParams = {};
        panel._rotateParams[propName] = newValue;
        panel.SetRotateParams(panel._rotateParams.yawmin || 0, panel._rotateParams.yawmax || 0, panel._rotateParams.pitchmin || 0, panel._rotateParams.pitchmax || 0);
    },
});
const scenePanelAttributes = {
    'post-process-fade': { type: 2 /* INITIAL_ONLY */, initial: true },
    'post-process-material': { type: 2 /* INITIAL_ONLY */, initial: true },
    'animate-during-pause': { type: 2 /* INITIAL_ONLY */, initial: true },
    'pin-fov': { type: 2 /* INITIAL_ONLY */, initial: true },
    'live-mode': { type: 2 /* INITIAL_ONLY */, initial: true },
    'no-intro-effects': { type: 2 /* INITIAL_ONLY */, initial: true },
    environment: { type: 2 /* INITIAL_ONLY */, initial: true },
    'activity-modifier': { type: 2 /* INITIAL_ONLY */, initial: true },
    unit: { type: 2 /* INITIAL_ONLY */, initial: true },
    map: { type: 2 /* INITIAL_ONLY */, initial: true },
    camera: { type: 2 /* INITIAL_ONLY */, initial: true },
    light: { type: 2 /* INITIAL_ONLY */, initial: true },
    pitchmin: createSceneRotationSetter('pitchmin'),
    pitchmax: createSceneRotationSetter('pitchmax'),
    yawmin: createSceneRotationSetter('yawmin'),
    yawmax: createSceneRotationSetter('yawmax'),
    acceleration: { type: 2 /* INITIAL_ONLY */, initial: true },
    autorotatespeed: { type: 2 /* INITIAL_ONLY */, initial: true },
    allowrotation: { type: 2 /* INITIAL_ONLY */, initial: true },
    rotateonhover: { type: 2 /* INITIAL_ONLY */, initial: true },
    rotateonmousemove: { type: 2 /* INITIAL_ONLY */, initial: true },
    antialias: { type: 2 /* INITIAL_ONLY */, initial: true },
    deferredalpha: { type: 2 /* INITIAL_ONLY */, initial: true },
    drawbackground: { type: 2 /* INITIAL_ONLY */, initial: true },
    panoramasurfaceheight: { type: 2 /* INITIAL_ONLY */, initial: true },
    panoramasurfacewidth: { type: 2 /* INITIAL_ONLY */, initial: true },
    panoramasurfacexml: { type: 2 /* INITIAL_ONLY */, initial: true },
    particleonly: { type: 2 /* INITIAL_ONLY */, initial: true },
    renderdeferred: { type: 2 /* INITIAL_ONLY */, initial: true },
    rendershadows: { type: 2 /* INITIAL_ONLY */, initial: true },
    renderwaterreflections: { type: 2 /* INITIAL_ONLY */, initial: true },
    allowsuspendrepaint: { type: 2 /* INITIAL_ONLY */, initial: true },
};
definePanelPropertyInformation('DOTAScenePanel', scenePanelAttributes);
definePanelPropertyInformation('DOTAParticleScenePanel', Object.assign(Object.assign({}, scenePanelAttributes), { syncSpawn: { type: 2 /* INITIAL_ONLY */, initial: true }, fov: { type: 2 /* INITIAL_ONLY */, initial: true }, startActive: { type: 2 /* INITIAL_ONLY */, initial: true }, squarePixels: { type: 2 /* INITIAL_ONLY */, initial: true }, farPlane: { type: 2 /* INITIAL_ONLY */, initial: true }, lookAt: {
        type: 2 /* INITIAL_ONLY */,
        initial: true,
        preOperation(value) {
            if (Array.isArray(value)) {
                value = value.join(' ');
            }
            return value;
        },
    }, cameraOrigin: {
        type: 2 /* INITIAL_ONLY */,
        initial: true,
        preOperation(value) {
            if (Array.isArray(value)) {
                value = value.join(' ');
            }
            return value;
        },
    }, useMapCamera: { type: 2 /* INITIAL_ONLY */, initial: true }, particleName: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('DOTAEconItem', {
    itemdef: {
        type: 3 /* CUSTOM */,
        initial: true,
        update(panel, newValue) {
            panel._econItemDef = newValue;
            panel.SetItemByDefinitionAndStyle(panel._econItemDef || 0, panel._econItemStyle || 0);
        },
    },
    itemstyle: {
        type: 3 /* CUSTOM */,
        initial: 'styleindex',
        update(panel, newValue) {
            panel._econItemStyle = newValue;
            panel.SetItemByDefinitionAndStyle(panel._econItemDef || 0, panel._econItemStyle || 0);
        },
    },
});
const progressBarAttributes = {
    value: { type: 0 /* SET */, name: 'value', initial: true },
    min: { type: 0 /* SET */, name: 'min', initial: true },
    max: { type: 0 /* SET */, name: 'max', initial: true },
};
definePanelPropertyInformation('ProgressBar', progressBarAttributes);
definePanelPropertyInformation('CircularProgressBar', progressBarAttributes);
definePanelPropertyInformation('ProgressBarWithMiddle', {
    lowervalue: { type: 0 /* SET */, name: 'lowervalue', initial: true },
    uppervalue: { type: 0 /* SET */, name: 'uppervalue', initial: true },
    min: { type: 0 /* SET */, name: 'min', initial: true },
    max: { type: 0 /* SET */, name: 'max', initial: true },
});
const steamIdAttribute = {
    type: 3 /* CUSTOM */,
    initial: true,
    update(panel, newValue = '0') {
        // XML attribute supports "local" value, but JS setter doesn't
        if (newValue === 'local') {
            panel.steamid = Game.GetLocalPlayerInfo().player_steamid;
        }
        else {
            panel.steamid = newValue;
        }
    },
};
definePanelPropertyInformation('DOTAUserName', { steamid: steamIdAttribute });
definePanelPropertyInformation('DOTAUserRichPresence', { steamid: steamIdAttribute });
definePanelPropertyInformation('DOTAAvatarImage', {
    steamid: steamIdAttribute,
    nocompendiumborder: { type: 2 /* INITIAL_ONLY */, initial: true },
    lazy: { type: 2 /* INITIAL_ONLY */, initial: true },
});
definePanelPropertyInformation('Countdown', {
    startTime: { type: 0 /* SET */, name: 'startTime', initial: 'start-time' },
    endTime: { type: 0 /* SET */, name: 'endTime', initial: 'end-time' },
    updateInterval: { type: 0 /* SET */, name: 'updateInterval' },
    timeDialogVariable: { type: 0 /* SET */, name: 'timeDialogVariable' },
});
definePanelPropertyInformation('TextButton', Object.assign(Object.assign({}, labelTextAttributes), { unlocalized: { type: 2 /* INITIAL_ONLY */, initial: true }, html: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('ToggleButton', Object.assign(Object.assign({}, labelTextAttributes), { unlocalized: { type: 2 /* INITIAL_ONLY */, initial: true }, html: { type: 2 /* INITIAL_ONLY */, initial: true }, selected: { type: 0 /* SET */, name: 'checked' } }));
definePanelPropertyInformation('RadioButton', {
    global: { type: 2 /* INITIAL_ONLY */, initial: true },
    group: { type: 2 /* INITIAL_ONLY */, initial: true },
    text: { type: 2 /* INITIAL_ONLY */, initial: true },
    html: { type: 2 /* INITIAL_ONLY */, initial: true },
    selected: { type: 0 /* SET */, name: 'checked' },
});
definePanelPropertyInformation('TextEntry', {
    autocompleteposition: { type: 2 /* INITIAL_ONLY */, initial: true },
    multiline: { type: 2 /* INITIAL_ONLY */, initial: true },
    placeholder: { type: 2 /* INITIAL_ONLY */, initial: true },
    maxchars: { type: 1 /* SETTER */, name: 'SetMaxChars', initial: true },
    textmode: { type: 2 /* INITIAL_ONLY */, initial: true },
    capslockwarn: { type: 2 /* INITIAL_ONLY */, initial: true },
    undohistory: { type: 2 /* INITIAL_ONLY */, initial: true },
    text: { type: 0 /* SET */, name: 'text' },
});
definePanelPropertyInformation('NumberEntry', {
    value: { type: 0 /* SET */, name: 'value', initial: true },
    increment: { type: 0 /* SET */, name: 'increment', initial: true },
    // panel.value = panel.value refreshes increment and decrement buttons
    /* eslint-disable no-self-assign */
    min: {
        type: 3 /* CUSTOM */,
        initial: true,
        update(panel, newValue = 0) {
            panel.min = newValue;
            panel.value = panel.value;
        },
    },
    max: {
        type: 3 /* CUSTOM */,
        initial: true,
        update(panel, newValue = 1000000) {
            panel.max = newValue;
            panel.value = panel.value;
        },
    },
});
const sliderAttributes = {
    // panel.SetDirection doesn't seem to work
    direction: { type: 2 /* INITIAL_ONLY */, initial: true },
    value: { type: 1 /* SETTER */, name: 'SetValueNoEvents' },
    min: { type: 0 /* SET */, name: 'min' },
    max: { type: 0 /* SET */, name: 'max' },
};
definePanelPropertyInformation('Slider', sliderAttributes);
definePanelPropertyInformation('SlottedSlider', Object.assign(Object.assign({}, sliderAttributes), { notches: { type: 2 /* INITIAL_ONLY */, initial: true } }));
definePanelPropertyInformation('DropDown', {
    selected: {
        type: 3 /* CUSTOM */,
        update(panel, newValue) {
            // Defer update until children are created
            queueMicrotask(() => newValue && panel.SetSelected(newValue));
        },
    },
});
definePanelPropertyInformation('Carousel', {
    focus: { type: 2 /* INITIAL_ONLY */, initial: true },
    'focus-offset': { type: 2 /* INITIAL_ONLY */, initial: true },
    wrap: { type: 2 /* INITIAL_ONLY */, initial: true },
    'panels-visible': { type: 2 /* INITIAL_ONLY */, initial: true },
    AllowOversized: { type: 2 /* INITIAL_ONLY */, initial: true },
    'autoscroll-delay': { type: 2 /* INITIAL_ONLY */, initial: true },
    'x-offset': { type: 2 /* INITIAL_ONLY */, initial: true },
});
definePanelPropertyInformation('CarouselNav', {
    carouselid: { type: 2 /* INITIAL_ONLY */, initial: true },
});
definePanelPropertyInformation('DOTAHUDOverlayMap', {
    maptexture: { type: 0 /* SET */, name: 'maptexture', initial: true },
    mapscale: { type: 0 /* SET */, name: 'mapscale', initial: true },
    mapscroll: { type: 0 /* SET */, name: 'mapscroll' },
    fixedoffsetenabled: { type: 0 /* SET */, name: 'fixedoffsetenabled' },
    fixedOffset: {
        type: 3 /* CUSTOM */,
        update(panel, newValue = {}) {
            panel.SetFixedOffset(newValue.x || 0, newValue.y || 0);
        },
    },
    fixedBackgroundTexturePosition: {
        type: 3 /* CUSTOM */,
        update(panel, newValue = {}) {
            panel.SetFixedBackgroundTexturePosition(newValue.size || 0, newValue.x || 0, newValue.y || 0);
        },
    },
});
definePanelPropertyInformation('HTML', {
    url: { type: 1 /* SETTER */, name: 'SetURL', initial: true },
});
definePanelPropertyInformation('TabButton', {
    group: { type: 2 /* INITIAL_ONLY */, initial: true },
    localizedText: { type: 2 /* INITIAL_ONLY */, initial: 'text' },
    html: { type: 2 /* INITIAL_ONLY */, initial: true },
    selected: { type: 0 /* SET */, name: 'checked' },
});
definePanelPropertyInformation('TabContents', {
    group: { type: 2 /* INITIAL_ONLY */, initial: true },
    tabid: { type: 2 /* INITIAL_ONLY */, initial: true },
    selected: { type: 0 /* SET */, name: 'checked' },
});
definePanelPropertyInformation('CustomLayoutPanel', {
    layout: { type: 2 /* INITIAL_ONLY */, initial: true },
});
const genericPanelPropertyInfo = {
    type: 2 /* INITIAL_ONLY */,
    initial: true,
};
const uiEventPropertyInfo = {
    type: 3 /* CUSTOM */,
    update(panel, newValue, _oldValue, propName) {
        var _a;
        (_a = panel._eventHandlers) !== null && _a !== void 0 ? _a : (panel._eventHandlers = {});
        // eslint-disable-next-line @typescript-eslint/no-unnecessary-condition
        if (panel._eventHandlers[propName] === undefined) {
            $.RegisterEventHandler(propName.slice(6), panel, (...args) => panel._eventHandlers[propName](...args));
        }
        panel._eventHandlers[propName] = newValue !== undefined ? newValue : noop;
    },
};
const panelEventPropertyInfo = {
    type: 3 /* CUSTOM */,
    update(panel, newValue, _oldValue, propName) {
        var _a;
        // Unlike UI event handlers, it's not required to use an object here,
        // because SetPanelEvent overrides previous listener,
        // but we're still using it here as a potential performance optimization
        (_a = panel._eventHandlers) !== null && _a !== void 0 ? _a : (panel._eventHandlers = {});
        // eslint-disable-next-line @typescript-eslint/no-unnecessary-condition
        if (panel._eventHandlers[propName] === undefined) {
            panel.SetPanelEvent(propName, () => panel._eventHandlers[propName](panel));
        }
        panel._eventHandlers[propName] = newValue !== undefined ? newValue : noop;
    },
};
function getPropertyInfo(type, propName) {
    var _a;
    const propertyInformation = propertiesInformation[propName];
    if (
    // eslint-disable-next-line @typescript-eslint/no-unnecessary-condition
    propertyInformation !== undefined &&
        !(panelBaseNames.has(type) && propertyInformation.type === 0 /* SET */)) {
        return propertyInformation;
    }
    const panelProperty = (_a = panelPropertyInformation[type]) === null || _a === void 0 ? void 0 : _a[propName];
    if (panelProperty)
        return panelProperty;
    if (propName === 'children')
        return undefined;
    if (propName.startsWith('on-ui-'))
        return uiEventPropertyInfo;
    if (propName.startsWith('on'))
        return panelEventPropertyInfo;
    if (type === 'GenericPanel')
        return genericPanelPropertyInfo;
}
function splitInitialProps(type, props) {
    let hasInitialProps = false;
    const initialProps = {};
    const otherProps = {};
    for (const propName in props) {
        let value = props[propName];
        const propertyInformation = getPropertyInfo(type, propName);
        if (propertyInformation && typeof propertyInformation.preOperation === 'function') {
            value = propertyInformation.preOperation(value);
        }
        if (propertyInformation && propertyInformation.initial) {
            const initialName = typeof propertyInformation.initial === 'string' ? propertyInformation.initial : propName;
            hasInitialProps = true;
            initialProps[initialName] = value;
        }
        else if (propName !== 'id') {
            otherProps[propName] = value;
        }
    }
    return { initialProps: hasInitialProps ? initialProps : undefined, otherProps };
}
function updateProperty(type, panel, propName, oldValue, newValue) {
    const propertyInformation = getPropertyInfo(type, propName);
    if (!propertyInformation) {
        // Ignore unknown properties
        return;
    }
    if (panelBaseNames.has(type) && propertyInformation.throwOnIncomplete) {
        throw new Error(`Attribute "${propName}" cannot be ${propertyInformation.initial ? 'changed on' : 'added to'} incomplete ${type} panel type.${propertyInformation.initial ? ' Add a "key" attribute to force re-mount.' : ''}`);
    }
    if (typeof propertyInformation.preOperation === 'function') {
        newValue = propertyInformation.preOperation(newValue);
    }
    switch (propertyInformation.type) {
        case 0 /* SET */:
            panel[propertyInformation.name] = newValue;
            break;
        case 1 /* SETTER */:
            panel[propertyInformation.name](newValue);
            break;
        case 2 /* INITIAL_ONLY */:
            throw new Error(`Attribute "${propName}" cannot be changed. Add a "key" attribute to force re-mount.`);
        case 3 /* CUSTOM */:
            propertyInformation.update(panel, newValue, oldValue, propName);
            break;
    }
}

const rootHostContext = {};
const childHostContext = {};
function appendChild(parent, child) {
    if (parent.paneltype === 'DropDown') {
        parent.AddOption(child);
        return;
    }
    if (parent.paneltype === 'ContextMenuScript') {
        parent = parent.GetContentsPanel();
    }
    if (parent === child.GetParent()) {
        parent.MoveChildAfter(child, parent.GetChild(parent.GetChildCount() - 1));
    }
    else {
        child.SetParent(parent);
    }
}
function insertBefore(parent, child, beforeChild) {
    if (parent.paneltype === 'DropDown') {
        parent.AddOption(child);
        parent.AccessDropDownMenu().MoveChildBefore(child, beforeChild);
        return;
    }
    if (parent.paneltype === 'ContextMenuScript') {
        parent = parent.GetContentsPanel();
    }
    child.SetParent(parent);
    parent.MoveChildBefore(child, beforeChild);
}
function removeChild(parent, child) {
    if (parent.paneltype === 'DropDown') {
        parent.RemoveOption(child.id);
    }
    else if ((child.paneltype === 'DOTAScenePanel' || child.paneltype === 'DOTAParticleScenePanel') &&
        !child.BHasClass('SceneLoaded')) {
        child.SetParent(temporaryScenePanelHost);
    }
    else {
        child.SetParent(temporaryPanelHost);
        temporaryPanelHost.RemoveAndDeleteChildren();
        // TODO: child.DeleteAsync(0)?
    }
}
const hostConfig = {
    getPublicInstance: (instance) => instance,
    getRootHostContext: () => rootHostContext,
    getChildHostContext: () => childHostContext,
    prepareForCommit: noop,
    resetAfterCommit: noop,
    // https://github.com/facebook/react/pull/14984
    scheduleDeferredCallback: undefined,
    cancelDeferredCallback: undefined,
    // https://github.com/facebook/react/pull/19124
    shouldDeprioritizeSubtree: undefined,
    // @ts-ignore
    setTimeout,
    // @ts-ignore
    clearTimeout,
    noTimeout: -1,
    now: Date.now,
    isPrimaryRenderer: true,
    supportsMutation: true,
    supportsPersistence: false,
    supportsHydration: false,
    shouldSetTextContent: () => false,
    createInstance(type, newProps) {
        const { initialProps, otherProps } = splitInitialProps(type, newProps);
        if (type === 'GenericPanel')
            type = newProps.type;
        const panel = $.CreatePanel(type, $.GetContextPanel(), newProps.id || '', 
        // @ts-ignore
        initialProps !== null && 
        // @ts-ignore
        initialProps !== void 0 ? 
        // @ts-ignore
        initialProps : {});
        if (panelBaseNames.has(type)) {
            fixPanelBase(panel);
        }
        for (const propName in otherProps) {
            updateProperty(type, panel, propName, undefined, otherProps[propName]);
        }
        return panel;
    },
    createTextInstance() {
        throw new Error('react-panorama does not support text nodes. Use <Label /> element instead.');
    },
    appendInitialChild: appendChild,
    finalizeInitialChildren: () => false,
    appendChild,
    appendChildToContainer: appendChild,
    insertBefore,
    insertInContainerBefore: insertBefore,
    removeChild,
    removeChildFromContainer: removeChild,
    // https://github.com/facebook/react/pull/8607
    prepareUpdate: () => true,
    commitUpdate(panel, _updatePayload, type, oldProps, newProps) {
        for (const propName in newProps) {
            let oldValue = oldProps[propName];
            let newValue = newProps[propName];
            const propertyInformation = getPropertyInfo(type, propName);
            if (propertyInformation && typeof propertyInformation.preOperation === 'function') {
                newValue = propertyInformation.preOperation(newValue);
                oldValue = propertyInformation.preOperation(oldValue);
            }
            if (oldValue !== newValue) {
                updateProperty(type, panel, propName, oldValue, newValue);
            }
        }
        for (const propName in oldProps) {
            if (!(propName in newProps)) {
                updateProperty(type, panel, propName, undefined, oldProps[propName]);
            }
        }
    },
};
const reconciler = reactReconciler(hostConfig);

/**
 * Render a React element into the layout in the supplied container.
 *
 * See [ReactDOM.render](https://reactjs.org/docs/react-dom.html#render) for more information.
 */
function render(element, container, callback) {
    var _a;
    const panel = container;
    if (panel._reactPanoramaSymbol !== reactPanoramaSymbol) {
        panel._reactPanoramaSymbol = reactPanoramaSymbol;
        // Container was used in the previous reload cycle
        panel._rootContainer = undefined;
    }
    (_a = panel._rootContainer) !== null && _a !== void 0 ? _a : (panel._rootContainer = reconciler.createContainer(panel, false, false));
    // @ts-expect-error callback type should be nullable
    reconciler.updateContainer(element, panel._rootContainer, null, callback);
}
// https://github.com/facebook/react/blob/master/packages/react-reconciler/src/ReactPortal.js
const REACT_PORTAL_TYPE = Symbol.for('react.portal');
/**
 * Creates a [React Portal](https://reactjs.org/docs/portals.html).
 */
function createPortal(children, container, key) {
    const portal = {
        $$typeof: REACT_PORTAL_TYPE,
        key: key == null ? null : String(key),
        children,
        containerInfo: container,
    };
    return portal;
}




/***/ },

/***/ "../../../node_modules/react/cjs/react-jsx-runtime.development.js"
/*!************************************************************************!*\
  !*** ../../../node_modules/react/cjs/react-jsx-runtime.development.js ***!
  \************************************************************************/
(__unused_webpack_module, exports, __webpack_require__) {

"use strict";
/** @license React v16.14.0
 * react-jsx-runtime.development.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */



if (true) {
  (function() {
'use strict';

var React = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");

// ATTENTION
// When adding new symbols to this file,
// Please consider also adding to 'react-devtools-shared/src/backend/ReactSymbols'
// The Symbol used to tag the ReactElement-like types. If there is no native Symbol
// nor polyfill, then a plain number is used for performance.
var REACT_ELEMENT_TYPE = 0xeac7;
var REACT_PORTAL_TYPE = 0xeaca;
exports.Fragment = 0xeacb;
var REACT_STRICT_MODE_TYPE = 0xeacc;
var REACT_PROFILER_TYPE = 0xead2;
var REACT_PROVIDER_TYPE = 0xeacd;
var REACT_CONTEXT_TYPE = 0xeace;
var REACT_FORWARD_REF_TYPE = 0xead0;
var REACT_SUSPENSE_TYPE = 0xead1;
var REACT_SUSPENSE_LIST_TYPE = 0xead8;
var REACT_MEMO_TYPE = 0xead3;
var REACT_LAZY_TYPE = 0xead4;
var REACT_BLOCK_TYPE = 0xead9;
var REACT_SERVER_BLOCK_TYPE = 0xeada;
var REACT_FUNDAMENTAL_TYPE = 0xead5;
var REACT_SCOPE_TYPE = 0xead7;
var REACT_OPAQUE_ID_TYPE = 0xeae0;
var REACT_DEBUG_TRACING_MODE_TYPE = 0xeae1;
var REACT_OFFSCREEN_TYPE = 0xeae2;
var REACT_LEGACY_HIDDEN_TYPE = 0xeae3;

if (typeof Symbol === 'function' && Symbol.for) {
  var symbolFor = Symbol.for;
  REACT_ELEMENT_TYPE = symbolFor('react.element');
  REACT_PORTAL_TYPE = symbolFor('react.portal');
  exports.Fragment = symbolFor('react.fragment');
  REACT_STRICT_MODE_TYPE = symbolFor('react.strict_mode');
  REACT_PROFILER_TYPE = symbolFor('react.profiler');
  REACT_PROVIDER_TYPE = symbolFor('react.provider');
  REACT_CONTEXT_TYPE = symbolFor('react.context');
  REACT_FORWARD_REF_TYPE = symbolFor('react.forward_ref');
  REACT_SUSPENSE_TYPE = symbolFor('react.suspense');
  REACT_SUSPENSE_LIST_TYPE = symbolFor('react.suspense_list');
  REACT_MEMO_TYPE = symbolFor('react.memo');
  REACT_LAZY_TYPE = symbolFor('react.lazy');
  REACT_BLOCK_TYPE = symbolFor('react.block');
  REACT_SERVER_BLOCK_TYPE = symbolFor('react.server.block');
  REACT_FUNDAMENTAL_TYPE = symbolFor('react.fundamental');
  REACT_SCOPE_TYPE = symbolFor('react.scope');
  REACT_OPAQUE_ID_TYPE = symbolFor('react.opaque.id');
  REACT_DEBUG_TRACING_MODE_TYPE = symbolFor('react.debug_trace_mode');
  REACT_OFFSCREEN_TYPE = symbolFor('react.offscreen');
  REACT_LEGACY_HIDDEN_TYPE = symbolFor('react.legacy_hidden');
}

var MAYBE_ITERATOR_SYMBOL = typeof Symbol === 'function' && Symbol.iterator;
var FAUX_ITERATOR_SYMBOL = '@@iterator';
function getIteratorFn(maybeIterable) {
  if (maybeIterable === null || typeof maybeIterable !== 'object') {
    return null;
  }

  var maybeIterator = MAYBE_ITERATOR_SYMBOL && maybeIterable[MAYBE_ITERATOR_SYMBOL] || maybeIterable[FAUX_ITERATOR_SYMBOL];

  if (typeof maybeIterator === 'function') {
    return maybeIterator;
  }

  return null;
}

var ReactSharedInternals = React.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED;

function error(format) {
  {
    for (var _len2 = arguments.length, args = new Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
      args[_key2 - 1] = arguments[_key2];
    }

    printWarning('error', format, args);
  }
}

function printWarning(level, format, args) {
  // When changing this logic, you might want to also
  // update consoleWithStackDev.www.js as well.
  {
    var ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;
    var stack = '';

    if (currentlyValidatingElement) {
      var name = getComponentName(currentlyValidatingElement.type);
      var owner = currentlyValidatingElement._owner;
      stack += describeComponentFrame(name, currentlyValidatingElement._source, owner && getComponentName(owner.type));
    }

    stack += ReactDebugCurrentFrame.getStackAddendum();

    if (stack !== '') {
      format += '%s';
      args = args.concat([stack]);
    }

    var argsWithFormat = args.map(function (item) {
      return '' + item;
    }); // Careful: RN currently depends on this prefix

    argsWithFormat.unshift('Warning: ' + format); // We intentionally don't use spread (or .apply) directly because it
    // breaks IE9: https://github.com/facebook/react/issues/13610
    // eslint-disable-next-line react-internal/no-production-logging

    Function.prototype.apply.call(console[level], console, argsWithFormat);
  }
}

// Filter certain DOM attributes (e.g. src, href) if their values are empty strings.

var enableScopeAPI = false; // Experimental Create Event Handle API.

function isValidElementType(type) {
  if (typeof type === 'string' || typeof type === 'function') {
    return true;
  } // Note: typeof might be other than 'symbol' or 'number' (e.g. if it's a polyfill).


  if (type === exports.Fragment || type === REACT_PROFILER_TYPE || type === REACT_DEBUG_TRACING_MODE_TYPE || type === REACT_STRICT_MODE_TYPE || type === REACT_SUSPENSE_TYPE || type === REACT_SUSPENSE_LIST_TYPE || type === REACT_LEGACY_HIDDEN_TYPE || enableScopeAPI ) {
    return true;
  }

  if (typeof type === 'object' && type !== null) {
    if (type.$$typeof === REACT_LAZY_TYPE || type.$$typeof === REACT_MEMO_TYPE || type.$$typeof === REACT_PROVIDER_TYPE || type.$$typeof === REACT_CONTEXT_TYPE || type.$$typeof === REACT_FORWARD_REF_TYPE || type.$$typeof === REACT_FUNDAMENTAL_TYPE || type.$$typeof === REACT_BLOCK_TYPE || type[0] === REACT_SERVER_BLOCK_TYPE) {
      return true;
    }
  }

  return false;
}


var BEFORE_SLASH_RE = /^(.*)[\\\/]/;
function describeComponentFrame (name, source, ownerName) {
  var sourceInfo = '';

  if (source) {
    var path = source.fileName;
    var fileName = path.replace(BEFORE_SLASH_RE, '');

    {
      // In DEV, include code for a common special case:
      // prefer "folder/index.js" instead of just "index.js".
      if (/^index\./.test(fileName)) {
        var match = path.match(BEFORE_SLASH_RE);

        if (match) {
          var pathBeforeSlash = match[1];

          if (pathBeforeSlash) {
            var folderName = pathBeforeSlash.replace(BEFORE_SLASH_RE, '');
            fileName = folderName + '/' + fileName;
          }
        }
      }
    }

    sourceInfo = ' (at ' + fileName + ':' + source.lineNumber + ')';
  } else if (ownerName) {
    sourceInfo = ' (created by ' + ownerName + ')';
  }

  return '\n    in ' + (name || 'Unknown') + sourceInfo;
}

var Resolved = 1;
function refineResolvedLazyComponent(lazyComponent) {
  return lazyComponent._status === Resolved ? lazyComponent._result : null;
}

function getWrappedName(outerType, innerType, wrapperName) {
  var functionName = innerType.displayName || innerType.name || '';
  return outerType.displayName || (functionName !== '' ? wrapperName + "(" + functionName + ")" : wrapperName);
}

function getComponentName(type) {
  if (type == null) {
    // Host root, text node or just invalid type.
    return null;
  }

  {
    if (typeof type.tag === 'number') {
      error('Received an unexpected object in getComponentName(). ' + 'This is likely a bug in React. Please file an issue.');
    }
  }

  if (typeof type === 'function') {
    return type.displayName || type.name || null;
  }

  if (typeof type === 'string') {
    return type;
  }

  switch (type) {
    case exports.Fragment:
      return 'Fragment';

    case REACT_PORTAL_TYPE:
      return 'Portal';

    case REACT_PROFILER_TYPE:
      return "Profiler";

    case REACT_STRICT_MODE_TYPE:
      return 'StrictMode';

    case REACT_SUSPENSE_TYPE:
      return 'Suspense';

    case REACT_SUSPENSE_LIST_TYPE:
      return 'SuspenseList';
  }

  if (typeof type === 'object') {
    switch (type.$$typeof) {
      case REACT_CONTEXT_TYPE:
        return 'Context.Consumer';

      case REACT_PROVIDER_TYPE:
        return 'Context.Provider';

      case REACT_FORWARD_REF_TYPE:
        return getWrappedName(type, type.render, 'ForwardRef');

      case REACT_MEMO_TYPE:
        return getComponentName(type.type);

      case REACT_BLOCK_TYPE:
        return getComponentName(type.render);

      case REACT_LAZY_TYPE:
        {
          var thenable = type;
          var resolvedThenable = refineResolvedLazyComponent(thenable);

          if (resolvedThenable) {
            return getComponentName(resolvedThenable);
          }

          break;
        }
    }
  }

  return null;
}

var loggedTypeFailures = {};
var ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;
var currentlyValidatingElement = null;

function setCurrentlyValidatingElement(element) {
  {
    currentlyValidatingElement = element;
  }
}

function checkPropTypes(typeSpecs, values, location, componentName, element) {
  {
    // $FlowFixMe This is okay but Flow doesn't know it.
    var has = Function.call.bind(Object.prototype.hasOwnProperty);

    for (var typeSpecName in typeSpecs) {
      if (has(typeSpecs, typeSpecName)) {
        var error$1 = void 0; // Prop type validation may throw. In case they do, we don't want to
        // fail the render phase where it didn't fail before. So we log it.
        // After these have been cleaned up, we'll let them throw.

        try {
          // This is intentionally an invariant that gets caught. It's the same
          // behavior as without this statement except with a better message.
          if (typeof typeSpecs[typeSpecName] !== 'function') {
            var err = Error((componentName || 'React class') + ': ' + location + ' type `' + typeSpecName + '` is invalid; ' + 'it must be a function, usually from the `prop-types` package, but received `' + typeof typeSpecs[typeSpecName] + '`.' + 'This often happens because of typos such as `PropTypes.function` instead of `PropTypes.func`.');
            err.name = 'Invariant Violation';
            throw err;
          }

          error$1 = typeSpecs[typeSpecName](values, typeSpecName, componentName, location, null, 'SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED');
        } catch (ex) {
          error$1 = ex;
        }

        if (error$1 && !(error$1 instanceof Error)) {
          setCurrentlyValidatingElement(element);

          error('%s: type specification of %s' + ' `%s` is invalid; the type checker ' + 'function must return `null` or an `Error` but returned a %s. ' + 'You may have forgotten to pass an argument to the type checker ' + 'creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and ' + 'shape all require an argument).', componentName || 'React class', location, typeSpecName, typeof error$1);

          setCurrentlyValidatingElement(null);
        }

        if (error$1 instanceof Error && !(error$1.message in loggedTypeFailures)) {
          // Only monitor this failure once because there tends to be a lot of the
          // same error.
          loggedTypeFailures[error$1.message] = true;
          setCurrentlyValidatingElement(element);

          error('Failed %s type: %s', location, error$1.message);

          setCurrentlyValidatingElement(null);
        }
      }
    }
  }
}

var ReactCurrentOwner = ReactSharedInternals.ReactCurrentOwner;
var hasOwnProperty = Object.prototype.hasOwnProperty;
var RESERVED_PROPS = {
  key: true,
  ref: true,
  __self: true,
  __source: true
};
var specialPropKeyWarningShown;
var specialPropRefWarningShown;
var didWarnAboutStringRefs;

{
  didWarnAboutStringRefs = {};
}

function hasValidRef(config) {
  {
    if (hasOwnProperty.call(config, 'ref')) {
      var getter = Object.getOwnPropertyDescriptor(config, 'ref').get;

      if (getter && getter.isReactWarning) {
        return false;
      }
    }
  }

  return config.ref !== undefined;
}

function hasValidKey(config) {
  {
    if (hasOwnProperty.call(config, 'key')) {
      var getter = Object.getOwnPropertyDescriptor(config, 'key').get;

      if (getter && getter.isReactWarning) {
        return false;
      }
    }
  }

  return config.key !== undefined;
}

function warnIfStringRefCannotBeAutoConverted(config, self) {
  {
    if (typeof config.ref === 'string' && ReactCurrentOwner.current && self && ReactCurrentOwner.current.stateNode !== self) {
      var componentName = getComponentName(ReactCurrentOwner.current.type);

      if (!didWarnAboutStringRefs[componentName]) {
        error('Component "%s" contains the string ref "%s". ' + 'Support for string refs will be removed in a future major release. ' + 'This case cannot be automatically converted to an arrow function. ' + 'We ask you to manually fix this case by using useRef() or createRef() instead. ' + 'Learn more about using refs safely here: ' + 'https://reactjs.org/link/strict-mode-string-ref', getComponentName(ReactCurrentOwner.current.type), config.ref);

        didWarnAboutStringRefs[componentName] = true;
      }
    }
  }
}

function defineKeyPropWarningGetter(props, displayName) {
  {
    var warnAboutAccessingKey = function () {
      if (!specialPropKeyWarningShown) {
        specialPropKeyWarningShown = true;

        error('%s: `key` is not a prop. Trying to access it will result ' + 'in `undefined` being returned. If you need to access the same ' + 'value within the child component, you should pass it as a different ' + 'prop. (https://reactjs.org/link/special-props)', displayName);
      }
    };

    warnAboutAccessingKey.isReactWarning = true;
    Object.defineProperty(props, 'key', {
      get: warnAboutAccessingKey,
      configurable: true
    });
  }
}

function defineRefPropWarningGetter(props, displayName) {
  {
    var warnAboutAccessingRef = function () {
      if (!specialPropRefWarningShown) {
        specialPropRefWarningShown = true;

        error('%s: `ref` is not a prop. Trying to access it will result ' + 'in `undefined` being returned. If you need to access the same ' + 'value within the child component, you should pass it as a different ' + 'prop. (https://reactjs.org/link/special-props)', displayName);
      }
    };

    warnAboutAccessingRef.isReactWarning = true;
    Object.defineProperty(props, 'ref', {
      get: warnAboutAccessingRef,
      configurable: true
    });
  }
}
/**
 * Factory method to create a new React element. This no longer adheres to
 * the class pattern, so do not use new to call it. Also, instanceof check
 * will not work. Instead test $$typeof field against Symbol.for('react.element') to check
 * if something is a React Element.
 *
 * @param {*} type
 * @param {*} props
 * @param {*} key
 * @param {string|object} ref
 * @param {*} owner
 * @param {*} self A *temporary* helper to detect places where `this` is
 * different from the `owner` when React.createElement is called, so that we
 * can warn. We want to get rid of owner and replace string `ref`s with arrow
 * functions, and as long as `this` and owner are the same, there will be no
 * change in behavior.
 * @param {*} source An annotation object (added by a transpiler or otherwise)
 * indicating filename, line number, and/or other information.
 * @internal
 */


var ReactElement = function (type, key, ref, self, source, owner, props) {
  var element = {
    // This tag allows us to uniquely identify this as a React Element
    $$typeof: REACT_ELEMENT_TYPE,
    // Built-in properties that belong on the element
    type: type,
    key: key,
    ref: ref,
    props: props,
    // Record the component responsible for creating this element.
    _owner: owner
  };

  {
    // The validation flag is currently mutative. We put it on
    // an external backing store so that we can freeze the whole object.
    // This can be replaced with a WeakMap once they are implemented in
    // commonly used development environments.
    element._store = {}; // To make comparing ReactElements easier for testing purposes, we make
    // the validation flag non-enumerable (where possible, which should
    // include every environment we run tests in), so the test framework
    // ignores it.

    Object.defineProperty(element._store, 'validated', {
      configurable: false,
      enumerable: false,
      writable: true,
      value: false
    }); // self and source are DEV only properties.

    Object.defineProperty(element, '_self', {
      configurable: false,
      enumerable: false,
      writable: false,
      value: self
    }); // Two elements created in two different places should be considered
    // equal for testing purposes and therefore we hide it from enumeration.

    Object.defineProperty(element, '_source', {
      configurable: false,
      enumerable: false,
      writable: false,
      value: source
    });

    if (Object.freeze) {
      Object.freeze(element.props);
      Object.freeze(element);
    }
  }

  return element;
};
/**
 * https://github.com/reactjs/rfcs/pull/107
 * @param {*} type
 * @param {object} props
 * @param {string} key
 */

function jsxDEV(type, config, maybeKey, source, self) {
  {
    var propName; // Reserved names are extracted

    var props = {};
    var key = null;
    var ref = null; // Currently, key can be spread in as a prop. This causes a potential
    // issue if key is also explicitly declared (ie. <div {...props} key="Hi" />
    // or <div key="Hi" {...props} /> ). We want to deprecate key spread,
    // but as an intermediary step, we will use jsxDEV for everything except
    // <div {...props} key="Hi" />, because we aren't currently able to tell if
    // key is explicitly declared to be undefined or not.

    if (maybeKey !== undefined) {
      key = '' + maybeKey;
    }

    if (hasValidKey(config)) {
      key = '' + config.key;
    }

    if (hasValidRef(config)) {
      ref = config.ref;
      warnIfStringRefCannotBeAutoConverted(config, self);
    } // Remaining properties are added to a new props object


    for (propName in config) {
      if (hasOwnProperty.call(config, propName) && !RESERVED_PROPS.hasOwnProperty(propName)) {
        props[propName] = config[propName];
      }
    } // Resolve default props


    if (type && type.defaultProps) {
      var defaultProps = type.defaultProps;

      for (propName in defaultProps) {
        if (props[propName] === undefined) {
          props[propName] = defaultProps[propName];
        }
      }
    }

    if (key || ref) {
      var displayName = typeof type === 'function' ? type.displayName || type.name || 'Unknown' : type;

      if (key) {
        defineKeyPropWarningGetter(props, displayName);
      }

      if (ref) {
        defineRefPropWarningGetter(props, displayName);
      }
    }

    return ReactElement(type, key, ref, self, source, ReactCurrentOwner.current, props);
  }
}

var ReactCurrentOwner$1 = ReactSharedInternals.ReactCurrentOwner;
var ReactDebugCurrentFrame$1 = ReactSharedInternals.ReactDebugCurrentFrame;

function setCurrentlyValidatingElement$1(element) {
  currentlyValidatingElement = element;
}

var propTypesMisspellWarningShown;

{
  propTypesMisspellWarningShown = false;
}
/**
 * Verifies the object is a ReactElement.
 * See https://reactjs.org/docs/react-api.html#isvalidelement
 * @param {?object} object
 * @return {boolean} True if `object` is a ReactElement.
 * @final
 */

function isValidElement(object) {
  {
    return typeof object === 'object' && object !== null && object.$$typeof === REACT_ELEMENT_TYPE;
  }
}

function getDeclarationErrorAddendum() {
  {
    if (ReactCurrentOwner$1.current) {
      var name = getComponentName(ReactCurrentOwner$1.current.type);

      if (name) {
        return '\n\nCheck the render method of `' + name + '`.';
      }
    }

    return '';
  }
}

function getSourceInfoErrorAddendum(source) {
  {
    if (source !== undefined) {
      var fileName = source.fileName.replace(/^.*[\\\/]/, '');
      var lineNumber = source.lineNumber;
      return '\n\nCheck your code at ' + fileName + ':' + lineNumber + '.';
    }

    return '';
  }
}
/**
 * Warn if there's no key explicitly set on dynamic arrays of children or
 * object keys are not valid. This allows us to keep track of children between
 * updates.
 */


var ownerHasKeyUseWarning = {};

function getCurrentComponentErrorInfo(parentType) {
  {
    var info = getDeclarationErrorAddendum();

    if (!info) {
      var parentName = typeof parentType === 'string' ? parentType : parentType.displayName || parentType.name;

      if (parentName) {
        info = "\n\nCheck the top-level render call using <" + parentName + ">.";
      }
    }

    return info;
  }
}
/**
 * Warn if the element doesn't have an explicit key assigned to it.
 * This element is in an array. The array could grow and shrink or be
 * reordered. All children that haven't already been validated are required to
 * have a "key" property assigned to it. Error statuses are cached so a warning
 * will only be shown once.
 *
 * @internal
 * @param {ReactElement} element Element that requires a key.
 * @param {*} parentType element's parent's type.
 */


function validateExplicitKey(element, parentType) {
  {
    if (!element._store || element._store.validated || element.key != null) {
      return;
    }

    element._store.validated = true;
    var currentComponentErrorInfo = getCurrentComponentErrorInfo(parentType);

    if (ownerHasKeyUseWarning[currentComponentErrorInfo]) {
      return;
    }

    ownerHasKeyUseWarning[currentComponentErrorInfo] = true; // Usually the current owner is the offender, but if it accepts children as a
    // property, it may be the creator of the child that's responsible for
    // assigning it a key.

    var childOwner = '';

    if (element && element._owner && element._owner !== ReactCurrentOwner$1.current) {
      // Give the component that originally created this child.
      childOwner = " It was passed a child from " + getComponentName(element._owner.type) + ".";
    }

    setCurrentlyValidatingElement$1(element);

    error('Each child in a list should have a unique "key" prop.' + '%s%s See https://reactjs.org/link/warning-keys for more information.', currentComponentErrorInfo, childOwner);

    setCurrentlyValidatingElement$1(null);
  }
}
/**
 * Ensure that every element either is passed in a static location, in an
 * array with an explicit keys property defined, or in an object literal
 * with valid key property.
 *
 * @internal
 * @param {ReactNode} node Statically passed child of any type.
 * @param {*} parentType node's parent's type.
 */


function validateChildKeys(node, parentType) {
  {
    if (typeof node !== 'object') {
      return;
    }

    if (Array.isArray(node)) {
      for (var i = 0; i < node.length; i++) {
        var child = node[i];

        if (isValidElement(child)) {
          validateExplicitKey(child, parentType);
        }
      }
    } else if (isValidElement(node)) {
      // This element was passed in a valid location.
      if (node._store) {
        node._store.validated = true;
      }
    } else if (node) {
      var iteratorFn = getIteratorFn(node);

      if (typeof iteratorFn === 'function') {
        // Entry iterators used to provide implicit keys,
        // but now we print a separate warning for them later.
        if (iteratorFn !== node.entries) {
          var iterator = iteratorFn.call(node);
          var step;

          while (!(step = iterator.next()).done) {
            if (isValidElement(step.value)) {
              validateExplicitKey(step.value, parentType);
            }
          }
        }
      }
    }
  }
}
/**
 * Given an element, validate that its props follow the propTypes definition,
 * provided by the type.
 *
 * @param {ReactElement} element
 */


function validatePropTypes(element) {
  {
    var type = element.type;

    if (type === null || type === undefined || typeof type === 'string') {
      return;
    }

    var propTypes;

    if (typeof type === 'function') {
      propTypes = type.propTypes;
    } else if (typeof type === 'object' && (type.$$typeof === REACT_FORWARD_REF_TYPE || // Note: Memo only checks outer props here.
    // Inner props are checked in the reconciler.
    type.$$typeof === REACT_MEMO_TYPE)) {
      propTypes = type.propTypes;
    } else {
      return;
    }

    if (propTypes) {
      // Intentionally inside to avoid triggering lazy initializers:
      var name = getComponentName(type);
      checkPropTypes(propTypes, element.props, 'prop', name, element);
    } else if (type.PropTypes !== undefined && !propTypesMisspellWarningShown) {
      propTypesMisspellWarningShown = true; // Intentionally inside to avoid triggering lazy initializers:

      var _name = getComponentName(type);

      error('Component %s declared `PropTypes` instead of `propTypes`. Did you misspell the property assignment?', _name || 'Unknown');
    }

    if (typeof type.getDefaultProps === 'function' && !type.getDefaultProps.isReactClassApproved) {
      error('getDefaultProps is only used on classic React.createClass ' + 'definitions. Use a static property named `defaultProps` instead.');
    }
  }
}
/**
 * Given a fragment, validate that it can only be provided with fragment props
 * @param {ReactElement} fragment
 */


function validateFragmentProps(fragment) {
  {
    var keys = Object.keys(fragment.props);

    for (var i = 0; i < keys.length; i++) {
      var key = keys[i];

      if (key !== 'children' && key !== 'key') {
        setCurrentlyValidatingElement$1(fragment);

        error('Invalid prop `%s` supplied to `React.Fragment`. ' + 'React.Fragment can only have `key` and `children` props.', key);

        setCurrentlyValidatingElement$1(null);
        break;
      }
    }

    if (fragment.ref !== null) {
      setCurrentlyValidatingElement$1(fragment);

      error('Invalid attribute `ref` supplied to `React.Fragment`.');

      setCurrentlyValidatingElement$1(null);
    }
  }
}

function jsxWithValidation(type, props, key, isStaticChildren, source, self) {
  {
    var validType = isValidElementType(type); // We warn in this case but don't throw. We expect the element creation to
    // succeed and there will likely be errors in render.

    if (!validType) {
      var info = '';

      if (type === undefined || typeof type === 'object' && type !== null && Object.keys(type).length === 0) {
        info += ' You likely forgot to export your component from the file ' + "it's defined in, or you might have mixed up default and named imports.";
      }

      var sourceInfo = getSourceInfoErrorAddendum(source);

      if (sourceInfo) {
        info += sourceInfo;
      } else {
        info += getDeclarationErrorAddendum();
      }

      var typeString;

      if (type === null) {
        typeString = 'null';
      } else if (Array.isArray(type)) {
        typeString = 'array';
      } else if (type !== undefined && type.$$typeof === REACT_ELEMENT_TYPE) {
        typeString = "<" + (getComponentName(type.type) || 'Unknown') + " />";
        info = ' Did you accidentally export a JSX literal instead of a component?';
      } else {
        typeString = typeof type;
      }

      error('React.jsx: type is invalid -- expected a string (for ' + 'built-in components) or a class/function (for composite ' + 'components) but got: %s.%s', typeString, info);
    }

    var element = jsxDEV(type, props, key, source, self); // The result can be nullish if a mock or a custom function is used.
    // TODO: Drop this when these are no longer allowed as the type argument.

    if (element == null) {
      return element;
    } // Skip key warning if the type isn't valid since our key validation logic
    // doesn't expect a non-string/function type and can throw confusing errors.
    // We don't want exception behavior to differ between dev and prod.
    // (Rendering will throw with a helpful message and as soon as the type is
    // fixed, the key warnings will appear.)


    if (validType) {
      var children = props.children;

      if (children !== undefined) {
        if (isStaticChildren) {
          if (Array.isArray(children)) {
            for (var i = 0; i < children.length; i++) {
              validateChildKeys(children[i], type);
            }

            if (Object.freeze) {
              Object.freeze(children);
            }
          } else {
            error('React.jsx: Static children should always be an array. ' + 'You are likely explicitly calling React.jsxs or React.jsxDEV. ' + 'Use the Babel transform instead.');
          }
        } else {
          validateChildKeys(children, type);
        }
      }
    }

    if (type === exports.Fragment) {
      validateFragmentProps(element);
    } else {
      validatePropTypes(element);
    }

    return element;
  }
} // These two functions exist to still get child warnings in dev
// even with the prod transform. This means that jsxDEV is purely
// opt-in behavior for better messages but that we won't stop
// giving you warnings if you use production apis.

function jsxWithValidationStatic(type, props, key) {
  {
    return jsxWithValidation(type, props, key, true);
  }
}
function jsxWithValidationDynamic(type, props, key) {
  {
    return jsxWithValidation(type, props, key, false);
  }
}

var jsx =  jsxWithValidationDynamic ; // we may want to special case jsxs internally to take advantage of static children.
// for now we can ship identical prod functions

var jsxs =  jsxWithValidationStatic ;

exports.jsx = jsx;
exports.jsxs = jsxs;
  })();
}


/***/ },

/***/ "../../../node_modules/react/cjs/react.development.js"
/*!************************************************************!*\
  !*** ../../../node_modules/react/cjs/react.development.js ***!
  \************************************************************/
(__unused_webpack_module, exports, __webpack_require__) {

"use strict";
/** @license React v16.14.0
 * react.development.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */





if (true) {
  (function() {
'use strict';

var _assign = __webpack_require__(/*! object-assign */ "../../../node_modules/object-assign/index.js");
var checkPropTypes = __webpack_require__(/*! prop-types/checkPropTypes */ "../../../node_modules/prop-types/checkPropTypes.js");

var ReactVersion = '16.14.0';

// The Symbol used to tag the ReactElement-like types. If there is no native Symbol
// nor polyfill, then a plain number is used for performance.
var hasSymbol = typeof Symbol === 'function' && Symbol.for;
var REACT_ELEMENT_TYPE = hasSymbol ? Symbol.for('react.element') : 0xeac7;
var REACT_PORTAL_TYPE = hasSymbol ? Symbol.for('react.portal') : 0xeaca;
var REACT_FRAGMENT_TYPE = hasSymbol ? Symbol.for('react.fragment') : 0xeacb;
var REACT_STRICT_MODE_TYPE = hasSymbol ? Symbol.for('react.strict_mode') : 0xeacc;
var REACT_PROFILER_TYPE = hasSymbol ? Symbol.for('react.profiler') : 0xead2;
var REACT_PROVIDER_TYPE = hasSymbol ? Symbol.for('react.provider') : 0xeacd;
var REACT_CONTEXT_TYPE = hasSymbol ? Symbol.for('react.context') : 0xeace; // TODO: We don't use AsyncMode or ConcurrentMode anymore. They were temporary
var REACT_CONCURRENT_MODE_TYPE = hasSymbol ? Symbol.for('react.concurrent_mode') : 0xeacf;
var REACT_FORWARD_REF_TYPE = hasSymbol ? Symbol.for('react.forward_ref') : 0xead0;
var REACT_SUSPENSE_TYPE = hasSymbol ? Symbol.for('react.suspense') : 0xead1;
var REACT_SUSPENSE_LIST_TYPE = hasSymbol ? Symbol.for('react.suspense_list') : 0xead8;
var REACT_MEMO_TYPE = hasSymbol ? Symbol.for('react.memo') : 0xead3;
var REACT_LAZY_TYPE = hasSymbol ? Symbol.for('react.lazy') : 0xead4;
var REACT_BLOCK_TYPE = hasSymbol ? Symbol.for('react.block') : 0xead9;
var REACT_FUNDAMENTAL_TYPE = hasSymbol ? Symbol.for('react.fundamental') : 0xead5;
var REACT_RESPONDER_TYPE = hasSymbol ? Symbol.for('react.responder') : 0xead6;
var REACT_SCOPE_TYPE = hasSymbol ? Symbol.for('react.scope') : 0xead7;
var MAYBE_ITERATOR_SYMBOL = typeof Symbol === 'function' && Symbol.iterator;
var FAUX_ITERATOR_SYMBOL = '@@iterator';
function getIteratorFn(maybeIterable) {
  if (maybeIterable === null || typeof maybeIterable !== 'object') {
    return null;
  }

  var maybeIterator = MAYBE_ITERATOR_SYMBOL && maybeIterable[MAYBE_ITERATOR_SYMBOL] || maybeIterable[FAUX_ITERATOR_SYMBOL];

  if (typeof maybeIterator === 'function') {
    return maybeIterator;
  }

  return null;
}

/**
 * Keeps track of the current dispatcher.
 */
var ReactCurrentDispatcher = {
  /**
   * @internal
   * @type {ReactComponent}
   */
  current: null
};

/**
 * Keeps track of the current batch's configuration such as how long an update
 * should suspend for if it needs to.
 */
var ReactCurrentBatchConfig = {
  suspense: null
};

/**
 * Keeps track of the current owner.
 *
 * The current owner is the component who should own any components that are
 * currently being constructed.
 */
var ReactCurrentOwner = {
  /**
   * @internal
   * @type {ReactComponent}
   */
  current: null
};

var BEFORE_SLASH_RE = /^(.*)[\\\/]/;
function describeComponentFrame (name, source, ownerName) {
  var sourceInfo = '';

  if (source) {
    var path = source.fileName;
    var fileName = path.replace(BEFORE_SLASH_RE, '');

    {
      // In DEV, include code for a common special case:
      // prefer "folder/index.js" instead of just "index.js".
      if (/^index\./.test(fileName)) {
        var match = path.match(BEFORE_SLASH_RE);

        if (match) {
          var pathBeforeSlash = match[1];

          if (pathBeforeSlash) {
            var folderName = pathBeforeSlash.replace(BEFORE_SLASH_RE, '');
            fileName = folderName + '/' + fileName;
          }
        }
      }
    }

    sourceInfo = ' (at ' + fileName + ':' + source.lineNumber + ')';
  } else if (ownerName) {
    sourceInfo = ' (created by ' + ownerName + ')';
  }

  return '\n    in ' + (name || 'Unknown') + sourceInfo;
}

var Resolved = 1;
function refineResolvedLazyComponent(lazyComponent) {
  return lazyComponent._status === Resolved ? lazyComponent._result : null;
}

function getWrappedName(outerType, innerType, wrapperName) {
  var functionName = innerType.displayName || innerType.name || '';
  return outerType.displayName || (functionName !== '' ? wrapperName + "(" + functionName + ")" : wrapperName);
}

function getComponentName(type) {
  if (type == null) {
    // Host root, text node or just invalid type.
    return null;
  }

  {
    if (typeof type.tag === 'number') {
      error('Received an unexpected object in getComponentName(). ' + 'This is likely a bug in React. Please file an issue.');
    }
  }

  if (typeof type === 'function') {
    return type.displayName || type.name || null;
  }

  if (typeof type === 'string') {
    return type;
  }

  switch (type) {
    case REACT_FRAGMENT_TYPE:
      return 'Fragment';

    case REACT_PORTAL_TYPE:
      return 'Portal';

    case REACT_PROFILER_TYPE:
      return "Profiler";

    case REACT_STRICT_MODE_TYPE:
      return 'StrictMode';

    case REACT_SUSPENSE_TYPE:
      return 'Suspense';

    case REACT_SUSPENSE_LIST_TYPE:
      return 'SuspenseList';
  }

  if (typeof type === 'object') {
    switch (type.$$typeof) {
      case REACT_CONTEXT_TYPE:
        return 'Context.Consumer';

      case REACT_PROVIDER_TYPE:
        return 'Context.Provider';

      case REACT_FORWARD_REF_TYPE:
        return getWrappedName(type, type.render, 'ForwardRef');

      case REACT_MEMO_TYPE:
        return getComponentName(type.type);

      case REACT_BLOCK_TYPE:
        return getComponentName(type.render);

      case REACT_LAZY_TYPE:
        {
          var thenable = type;
          var resolvedThenable = refineResolvedLazyComponent(thenable);

          if (resolvedThenable) {
            return getComponentName(resolvedThenable);
          }

          break;
        }
    }
  }

  return null;
}

var ReactDebugCurrentFrame = {};
var currentlyValidatingElement = null;
function setCurrentlyValidatingElement(element) {
  {
    currentlyValidatingElement = element;
  }
}

{
  // Stack implementation injected by the current renderer.
  ReactDebugCurrentFrame.getCurrentStack = null;

  ReactDebugCurrentFrame.getStackAddendum = function () {
    var stack = ''; // Add an extra top frame while an element is being validated

    if (currentlyValidatingElement) {
      var name = getComponentName(currentlyValidatingElement.type);
      var owner = currentlyValidatingElement._owner;
      stack += describeComponentFrame(name, currentlyValidatingElement._source, owner && getComponentName(owner.type));
    } // Delegate to the injected renderer-specific implementation


    var impl = ReactDebugCurrentFrame.getCurrentStack;

    if (impl) {
      stack += impl() || '';
    }

    return stack;
  };
}

/**
 * Used by act() to track whether you're inside an act() scope.
 */
var IsSomeRendererActing = {
  current: false
};

var ReactSharedInternals = {
  ReactCurrentDispatcher: ReactCurrentDispatcher,
  ReactCurrentBatchConfig: ReactCurrentBatchConfig,
  ReactCurrentOwner: ReactCurrentOwner,
  IsSomeRendererActing: IsSomeRendererActing,
  // Used by renderers to avoid bundling object-assign twice in UMD bundles:
  assign: _assign
};

{
  _assign(ReactSharedInternals, {
    // These should not be included in production.
    ReactDebugCurrentFrame: ReactDebugCurrentFrame,
    // Shim for React DOM 16.0.0 which still destructured (but not used) this.
    // TODO: remove in React 17.0.
    ReactComponentTreeHook: {}
  });
}

// by calls to these methods by a Babel plugin.
//
// In PROD (or in packages without access to React internals),
// they are left as they are instead.

function warn(format) {
  {
    for (var _len = arguments.length, args = new Array(_len > 1 ? _len - 1 : 0), _key = 1; _key < _len; _key++) {
      args[_key - 1] = arguments[_key];
    }

    printWarning('warn', format, args);
  }
}
function error(format) {
  {
    for (var _len2 = arguments.length, args = new Array(_len2 > 1 ? _len2 - 1 : 0), _key2 = 1; _key2 < _len2; _key2++) {
      args[_key2 - 1] = arguments[_key2];
    }

    printWarning('error', format, args);
  }
}

function printWarning(level, format, args) {
  // When changing this logic, you might want to also
  // update consoleWithStackDev.www.js as well.
  {
    var hasExistingStack = args.length > 0 && typeof args[args.length - 1] === 'string' && args[args.length - 1].indexOf('\n    in') === 0;

    if (!hasExistingStack) {
      var ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;
      var stack = ReactDebugCurrentFrame.getStackAddendum();

      if (stack !== '') {
        format += '%s';
        args = args.concat([stack]);
      }
    }

    var argsWithFormat = args.map(function (item) {
      return '' + item;
    }); // Careful: RN currently depends on this prefix

    argsWithFormat.unshift('Warning: ' + format); // We intentionally don't use spread (or .apply) directly because it
    // breaks IE9: https://github.com/facebook/react/issues/13610
    // eslint-disable-next-line react-internal/no-production-logging

    Function.prototype.apply.call(console[level], console, argsWithFormat);

    try {
      // --- Welcome to debugging React ---
      // This error was thrown as a convenience so that you can use this stack
      // to find the callsite that caused this warning to fire.
      var argIndex = 0;
      var message = 'Warning: ' + format.replace(/%s/g, function () {
        return args[argIndex++];
      });
      throw new Error(message);
    } catch (x) {}
  }
}

var didWarnStateUpdateForUnmountedComponent = {};

function warnNoop(publicInstance, callerName) {
  {
    var _constructor = publicInstance.constructor;
    var componentName = _constructor && (_constructor.displayName || _constructor.name) || 'ReactClass';
    var warningKey = componentName + "." + callerName;

    if (didWarnStateUpdateForUnmountedComponent[warningKey]) {
      return;
    }

    error("Can't call %s on a component that is not yet mounted. " + 'This is a no-op, but it might indicate a bug in your application. ' + 'Instead, assign to `this.state` directly or define a `state = {};` ' + 'class property with the desired state in the %s component.', callerName, componentName);

    didWarnStateUpdateForUnmountedComponent[warningKey] = true;
  }
}
/**
 * This is the abstract API for an update queue.
 */


var ReactNoopUpdateQueue = {
  /**
   * Checks whether or not this composite component is mounted.
   * @param {ReactClass} publicInstance The instance we want to test.
   * @return {boolean} True if mounted, false otherwise.
   * @protected
   * @final
   */
  isMounted: function (publicInstance) {
    return false;
  },

  /**
   * Forces an update. This should only be invoked when it is known with
   * certainty that we are **not** in a DOM transaction.
   *
   * You may want to call this when you know that some deeper aspect of the
   * component's state has changed but `setState` was not called.
   *
   * This will not invoke `shouldComponentUpdate`, but it will invoke
   * `componentWillUpdate` and `componentDidUpdate`.
   *
   * @param {ReactClass} publicInstance The instance that should rerender.
   * @param {?function} callback Called after component is updated.
   * @param {?string} callerName name of the calling function in the public API.
   * @internal
   */
  enqueueForceUpdate: function (publicInstance, callback, callerName) {
    warnNoop(publicInstance, 'forceUpdate');
  },

  /**
   * Replaces all of the state. Always use this or `setState` to mutate state.
   * You should treat `this.state` as immutable.
   *
   * There is no guarantee that `this.state` will be immediately updated, so
   * accessing `this.state` after calling this method may return the old value.
   *
   * @param {ReactClass} publicInstance The instance that should rerender.
   * @param {object} completeState Next state.
   * @param {?function} callback Called after component is updated.
   * @param {?string} callerName name of the calling function in the public API.
   * @internal
   */
  enqueueReplaceState: function (publicInstance, completeState, callback, callerName) {
    warnNoop(publicInstance, 'replaceState');
  },

  /**
   * Sets a subset of the state. This only exists because _pendingState is
   * internal. This provides a merging strategy that is not available to deep
   * properties which is confusing. TODO: Expose pendingState or don't use it
   * during the merge.
   *
   * @param {ReactClass} publicInstance The instance that should rerender.
   * @param {object} partialState Next partial state to be merged with state.
   * @param {?function} callback Called after component is updated.
   * @param {?string} Name of the calling function in the public API.
   * @internal
   */
  enqueueSetState: function (publicInstance, partialState, callback, callerName) {
    warnNoop(publicInstance, 'setState');
  }
};

var emptyObject = {};

{
  Object.freeze(emptyObject);
}
/**
 * Base class helpers for the updating state of a component.
 */


function Component(props, context, updater) {
  this.props = props;
  this.context = context; // If a component has string refs, we will assign a different object later.

  this.refs = emptyObject; // We initialize the default updater but the real one gets injected by the
  // renderer.

  this.updater = updater || ReactNoopUpdateQueue;
}

Component.prototype.isReactComponent = {};
/**
 * Sets a subset of the state. Always use this to mutate
 * state. You should treat `this.state` as immutable.
 *
 * There is no guarantee that `this.state` will be immediately updated, so
 * accessing `this.state` after calling this method may return the old value.
 *
 * There is no guarantee that calls to `setState` will run synchronously,
 * as they may eventually be batched together.  You can provide an optional
 * callback that will be executed when the call to setState is actually
 * completed.
 *
 * When a function is provided to setState, it will be called at some point in
 * the future (not synchronously). It will be called with the up to date
 * component arguments (state, props, context). These values can be different
 * from this.* because your function may be called after receiveProps but before
 * shouldComponentUpdate, and this new state, props, and context will not yet be
 * assigned to this.
 *
 * @param {object|function} partialState Next partial state or function to
 *        produce next partial state to be merged with current state.
 * @param {?function} callback Called after state is updated.
 * @final
 * @protected
 */

Component.prototype.setState = function (partialState, callback) {
  if (!(typeof partialState === 'object' || typeof partialState === 'function' || partialState == null)) {
    {
      throw Error( "setState(...): takes an object of state variables to update or a function which returns an object of state variables." );
    }
  }

  this.updater.enqueueSetState(this, partialState, callback, 'setState');
};
/**
 * Forces an update. This should only be invoked when it is known with
 * certainty that we are **not** in a DOM transaction.
 *
 * You may want to call this when you know that some deeper aspect of the
 * component's state has changed but `setState` was not called.
 *
 * This will not invoke `shouldComponentUpdate`, but it will invoke
 * `componentWillUpdate` and `componentDidUpdate`.
 *
 * @param {?function} callback Called after update is complete.
 * @final
 * @protected
 */


Component.prototype.forceUpdate = function (callback) {
  this.updater.enqueueForceUpdate(this, callback, 'forceUpdate');
};
/**
 * Deprecated APIs. These APIs used to exist on classic React classes but since
 * we would like to deprecate them, we're not going to move them over to this
 * modern base class. Instead, we define a getter that warns if it's accessed.
 */


{
  var deprecatedAPIs = {
    isMounted: ['isMounted', 'Instead, make sure to clean up subscriptions and pending requests in ' + 'componentWillUnmount to prevent memory leaks.'],
    replaceState: ['replaceState', 'Refactor your code to use setState instead (see ' + 'https://github.com/facebook/react/issues/3236).']
  };

  var defineDeprecationWarning = function (methodName, info) {
    Object.defineProperty(Component.prototype, methodName, {
      get: function () {
        warn('%s(...) is deprecated in plain JavaScript React classes. %s', info[0], info[1]);

        return undefined;
      }
    });
  };

  for (var fnName in deprecatedAPIs) {
    if (deprecatedAPIs.hasOwnProperty(fnName)) {
      defineDeprecationWarning(fnName, deprecatedAPIs[fnName]);
    }
  }
}

function ComponentDummy() {}

ComponentDummy.prototype = Component.prototype;
/**
 * Convenience component with default shallow equality check for sCU.
 */

function PureComponent(props, context, updater) {
  this.props = props;
  this.context = context; // If a component has string refs, we will assign a different object later.

  this.refs = emptyObject;
  this.updater = updater || ReactNoopUpdateQueue;
}

var pureComponentPrototype = PureComponent.prototype = new ComponentDummy();
pureComponentPrototype.constructor = PureComponent; // Avoid an extra prototype jump for these methods.

_assign(pureComponentPrototype, Component.prototype);

pureComponentPrototype.isPureReactComponent = true;

// an immutable object with a single mutable value
function createRef() {
  var refObject = {
    current: null
  };

  {
    Object.seal(refObject);
  }

  return refObject;
}

var hasOwnProperty = Object.prototype.hasOwnProperty;
var RESERVED_PROPS = {
  key: true,
  ref: true,
  __self: true,
  __source: true
};
var specialPropKeyWarningShown, specialPropRefWarningShown, didWarnAboutStringRefs;

{
  didWarnAboutStringRefs = {};
}

function hasValidRef(config) {
  {
    if (hasOwnProperty.call(config, 'ref')) {
      var getter = Object.getOwnPropertyDescriptor(config, 'ref').get;

      if (getter && getter.isReactWarning) {
        return false;
      }
    }
  }

  return config.ref !== undefined;
}

function hasValidKey(config) {
  {
    if (hasOwnProperty.call(config, 'key')) {
      var getter = Object.getOwnPropertyDescriptor(config, 'key').get;

      if (getter && getter.isReactWarning) {
        return false;
      }
    }
  }

  return config.key !== undefined;
}

function defineKeyPropWarningGetter(props, displayName) {
  var warnAboutAccessingKey = function () {
    {
      if (!specialPropKeyWarningShown) {
        specialPropKeyWarningShown = true;

        error('%s: `key` is not a prop. Trying to access it will result ' + 'in `undefined` being returned. If you need to access the same ' + 'value within the child component, you should pass it as a different ' + 'prop. (https://fb.me/react-special-props)', displayName);
      }
    }
  };

  warnAboutAccessingKey.isReactWarning = true;
  Object.defineProperty(props, 'key', {
    get: warnAboutAccessingKey,
    configurable: true
  });
}

function defineRefPropWarningGetter(props, displayName) {
  var warnAboutAccessingRef = function () {
    {
      if (!specialPropRefWarningShown) {
        specialPropRefWarningShown = true;

        error('%s: `ref` is not a prop. Trying to access it will result ' + 'in `undefined` being returned. If you need to access the same ' + 'value within the child component, you should pass it as a different ' + 'prop. (https://fb.me/react-special-props)', displayName);
      }
    }
  };

  warnAboutAccessingRef.isReactWarning = true;
  Object.defineProperty(props, 'ref', {
    get: warnAboutAccessingRef,
    configurable: true
  });
}

function warnIfStringRefCannotBeAutoConverted(config) {
  {
    if (typeof config.ref === 'string' && ReactCurrentOwner.current && config.__self && ReactCurrentOwner.current.stateNode !== config.__self) {
      var componentName = getComponentName(ReactCurrentOwner.current.type);

      if (!didWarnAboutStringRefs[componentName]) {
        error('Component "%s" contains the string ref "%s". ' + 'Support for string refs will be removed in a future major release. ' + 'This case cannot be automatically converted to an arrow function. ' + 'We ask you to manually fix this case by using useRef() or createRef() instead. ' + 'Learn more about using refs safely here: ' + 'https://fb.me/react-strict-mode-string-ref', getComponentName(ReactCurrentOwner.current.type), config.ref);

        didWarnAboutStringRefs[componentName] = true;
      }
    }
  }
}
/**
 * Factory method to create a new React element. This no longer adheres to
 * the class pattern, so do not use new to call it. Also, instanceof check
 * will not work. Instead test $$typeof field against Symbol.for('react.element') to check
 * if something is a React Element.
 *
 * @param {*} type
 * @param {*} props
 * @param {*} key
 * @param {string|object} ref
 * @param {*} owner
 * @param {*} self A *temporary* helper to detect places where `this` is
 * different from the `owner` when React.createElement is called, so that we
 * can warn. We want to get rid of owner and replace string `ref`s with arrow
 * functions, and as long as `this` and owner are the same, there will be no
 * change in behavior.
 * @param {*} source An annotation object (added by a transpiler or otherwise)
 * indicating filename, line number, and/or other information.
 * @internal
 */


var ReactElement = function (type, key, ref, self, source, owner, props) {
  var element = {
    // This tag allows us to uniquely identify this as a React Element
    $$typeof: REACT_ELEMENT_TYPE,
    // Built-in properties that belong on the element
    type: type,
    key: key,
    ref: ref,
    props: props,
    // Record the component responsible for creating this element.
    _owner: owner
  };

  {
    // The validation flag is currently mutative. We put it on
    // an external backing store so that we can freeze the whole object.
    // This can be replaced with a WeakMap once they are implemented in
    // commonly used development environments.
    element._store = {}; // To make comparing ReactElements easier for testing purposes, we make
    // the validation flag non-enumerable (where possible, which should
    // include every environment we run tests in), so the test framework
    // ignores it.

    Object.defineProperty(element._store, 'validated', {
      configurable: false,
      enumerable: false,
      writable: true,
      value: false
    }); // self and source are DEV only properties.

    Object.defineProperty(element, '_self', {
      configurable: false,
      enumerable: false,
      writable: false,
      value: self
    }); // Two elements created in two different places should be considered
    // equal for testing purposes and therefore we hide it from enumeration.

    Object.defineProperty(element, '_source', {
      configurable: false,
      enumerable: false,
      writable: false,
      value: source
    });

    if (Object.freeze) {
      Object.freeze(element.props);
      Object.freeze(element);
    }
  }

  return element;
};
/**
 * Create and return a new ReactElement of the given type.
 * See https://reactjs.org/docs/react-api.html#createelement
 */

function createElement(type, config, children) {
  var propName; // Reserved names are extracted

  var props = {};
  var key = null;
  var ref = null;
  var self = null;
  var source = null;

  if (config != null) {
    if (hasValidRef(config)) {
      ref = config.ref;

      {
        warnIfStringRefCannotBeAutoConverted(config);
      }
    }

    if (hasValidKey(config)) {
      key = '' + config.key;
    }

    self = config.__self === undefined ? null : config.__self;
    source = config.__source === undefined ? null : config.__source; // Remaining properties are added to a new props object

    for (propName in config) {
      if (hasOwnProperty.call(config, propName) && !RESERVED_PROPS.hasOwnProperty(propName)) {
        props[propName] = config[propName];
      }
    }
  } // Children can be more than one argument, and those are transferred onto
  // the newly allocated props object.


  var childrenLength = arguments.length - 2;

  if (childrenLength === 1) {
    props.children = children;
  } else if (childrenLength > 1) {
    var childArray = Array(childrenLength);

    for (var i = 0; i < childrenLength; i++) {
      childArray[i] = arguments[i + 2];
    }

    {
      if (Object.freeze) {
        Object.freeze(childArray);
      }
    }

    props.children = childArray;
  } // Resolve default props


  if (type && type.defaultProps) {
    var defaultProps = type.defaultProps;

    for (propName in defaultProps) {
      if (props[propName] === undefined) {
        props[propName] = defaultProps[propName];
      }
    }
  }

  {
    if (key || ref) {
      var displayName = typeof type === 'function' ? type.displayName || type.name || 'Unknown' : type;

      if (key) {
        defineKeyPropWarningGetter(props, displayName);
      }

      if (ref) {
        defineRefPropWarningGetter(props, displayName);
      }
    }
  }

  return ReactElement(type, key, ref, self, source, ReactCurrentOwner.current, props);
}
function cloneAndReplaceKey(oldElement, newKey) {
  var newElement = ReactElement(oldElement.type, newKey, oldElement.ref, oldElement._self, oldElement._source, oldElement._owner, oldElement.props);
  return newElement;
}
/**
 * Clone and return a new ReactElement using element as the starting point.
 * See https://reactjs.org/docs/react-api.html#cloneelement
 */

function cloneElement(element, config, children) {
  if (!!(element === null || element === undefined)) {
    {
      throw Error( "React.cloneElement(...): The argument must be a React element, but you passed " + element + "." );
    }
  }

  var propName; // Original props are copied

  var props = _assign({}, element.props); // Reserved names are extracted


  var key = element.key;
  var ref = element.ref; // Self is preserved since the owner is preserved.

  var self = element._self; // Source is preserved since cloneElement is unlikely to be targeted by a
  // transpiler, and the original source is probably a better indicator of the
  // true owner.

  var source = element._source; // Owner will be preserved, unless ref is overridden

  var owner = element._owner;

  if (config != null) {
    if (hasValidRef(config)) {
      // Silently steal the ref from the parent.
      ref = config.ref;
      owner = ReactCurrentOwner.current;
    }

    if (hasValidKey(config)) {
      key = '' + config.key;
    } // Remaining properties override existing props


    var defaultProps;

    if (element.type && element.type.defaultProps) {
      defaultProps = element.type.defaultProps;
    }

    for (propName in config) {
      if (hasOwnProperty.call(config, propName) && !RESERVED_PROPS.hasOwnProperty(propName)) {
        if (config[propName] === undefined && defaultProps !== undefined) {
          // Resolve default props
          props[propName] = defaultProps[propName];
        } else {
          props[propName] = config[propName];
        }
      }
    }
  } // Children can be more than one argument, and those are transferred onto
  // the newly allocated props object.


  var childrenLength = arguments.length - 2;

  if (childrenLength === 1) {
    props.children = children;
  } else if (childrenLength > 1) {
    var childArray = Array(childrenLength);

    for (var i = 0; i < childrenLength; i++) {
      childArray[i] = arguments[i + 2];
    }

    props.children = childArray;
  }

  return ReactElement(element.type, key, ref, self, source, owner, props);
}
/**
 * Verifies the object is a ReactElement.
 * See https://reactjs.org/docs/react-api.html#isvalidelement
 * @param {?object} object
 * @return {boolean} True if `object` is a ReactElement.
 * @final
 */

function isValidElement(object) {
  return typeof object === 'object' && object !== null && object.$$typeof === REACT_ELEMENT_TYPE;
}

var SEPARATOR = '.';
var SUBSEPARATOR = ':';
/**
 * Escape and wrap key so it is safe to use as a reactid
 *
 * @param {string} key to be escaped.
 * @return {string} the escaped key.
 */

function escape(key) {
  var escapeRegex = /[=:]/g;
  var escaperLookup = {
    '=': '=0',
    ':': '=2'
  };
  var escapedString = ('' + key).replace(escapeRegex, function (match) {
    return escaperLookup[match];
  });
  return '$' + escapedString;
}
/**
 * TODO: Test that a single child and an array with one item have the same key
 * pattern.
 */


var didWarnAboutMaps = false;
var userProvidedKeyEscapeRegex = /\/+/g;

function escapeUserProvidedKey(text) {
  return ('' + text).replace(userProvidedKeyEscapeRegex, '$&/');
}

var POOL_SIZE = 10;
var traverseContextPool = [];

function getPooledTraverseContext(mapResult, keyPrefix, mapFunction, mapContext) {
  if (traverseContextPool.length) {
    var traverseContext = traverseContextPool.pop();
    traverseContext.result = mapResult;
    traverseContext.keyPrefix = keyPrefix;
    traverseContext.func = mapFunction;
    traverseContext.context = mapContext;
    traverseContext.count = 0;
    return traverseContext;
  } else {
    return {
      result: mapResult,
      keyPrefix: keyPrefix,
      func: mapFunction,
      context: mapContext,
      count: 0
    };
  }
}

function releaseTraverseContext(traverseContext) {
  traverseContext.result = null;
  traverseContext.keyPrefix = null;
  traverseContext.func = null;
  traverseContext.context = null;
  traverseContext.count = 0;

  if (traverseContextPool.length < POOL_SIZE) {
    traverseContextPool.push(traverseContext);
  }
}
/**
 * @param {?*} children Children tree container.
 * @param {!string} nameSoFar Name of the key path so far.
 * @param {!function} callback Callback to invoke with each child found.
 * @param {?*} traverseContext Used to pass information throughout the traversal
 * process.
 * @return {!number} The number of children in this subtree.
 */


function traverseAllChildrenImpl(children, nameSoFar, callback, traverseContext) {
  var type = typeof children;

  if (type === 'undefined' || type === 'boolean') {
    // All of the above are perceived as null.
    children = null;
  }

  var invokeCallback = false;

  if (children === null) {
    invokeCallback = true;
  } else {
    switch (type) {
      case 'string':
      case 'number':
        invokeCallback = true;
        break;

      case 'object':
        switch (children.$$typeof) {
          case REACT_ELEMENT_TYPE:
          case REACT_PORTAL_TYPE:
            invokeCallback = true;
        }

    }
  }

  if (invokeCallback) {
    callback(traverseContext, children, // If it's the only child, treat the name as if it was wrapped in an array
    // so that it's consistent if the number of children grows.
    nameSoFar === '' ? SEPARATOR + getComponentKey(children, 0) : nameSoFar);
    return 1;
  }

  var child;
  var nextName;
  var subtreeCount = 0; // Count of children found in the current subtree.

  var nextNamePrefix = nameSoFar === '' ? SEPARATOR : nameSoFar + SUBSEPARATOR;

  if (Array.isArray(children)) {
    for (var i = 0; i < children.length; i++) {
      child = children[i];
      nextName = nextNamePrefix + getComponentKey(child, i);
      subtreeCount += traverseAllChildrenImpl(child, nextName, callback, traverseContext);
    }
  } else {
    var iteratorFn = getIteratorFn(children);

    if (typeof iteratorFn === 'function') {

      {
        // Warn about using Maps as children
        if (iteratorFn === children.entries) {
          if (!didWarnAboutMaps) {
            warn('Using Maps as children is deprecated and will be removed in ' + 'a future major release. Consider converting children to ' + 'an array of keyed ReactElements instead.');
          }

          didWarnAboutMaps = true;
        }
      }

      var iterator = iteratorFn.call(children);
      var step;
      var ii = 0;

      while (!(step = iterator.next()).done) {
        child = step.value;
        nextName = nextNamePrefix + getComponentKey(child, ii++);
        subtreeCount += traverseAllChildrenImpl(child, nextName, callback, traverseContext);
      }
    } else if (type === 'object') {
      var addendum = '';

      {
        addendum = ' If you meant to render a collection of children, use an array ' + 'instead.' + ReactDebugCurrentFrame.getStackAddendum();
      }

      var childrenString = '' + children;

      {
        {
          throw Error( "Objects are not valid as a React child (found: " + (childrenString === '[object Object]' ? 'object with keys {' + Object.keys(children).join(', ') + '}' : childrenString) + ")." + addendum );
        }
      }
    }
  }

  return subtreeCount;
}
/**
 * Traverses children that are typically specified as `props.children`, but
 * might also be specified through attributes:
 *
 * - `traverseAllChildren(this.props.children, ...)`
 * - `traverseAllChildren(this.props.leftPanelChildren, ...)`
 *
 * The `traverseContext` is an optional argument that is passed through the
 * entire traversal. It can be used to store accumulations or anything else that
 * the callback might find relevant.
 *
 * @param {?*} children Children tree object.
 * @param {!function} callback To invoke upon traversing each child.
 * @param {?*} traverseContext Context for traversal.
 * @return {!number} The number of children in this subtree.
 */


function traverseAllChildren(children, callback, traverseContext) {
  if (children == null) {
    return 0;
  }

  return traverseAllChildrenImpl(children, '', callback, traverseContext);
}
/**
 * Generate a key string that identifies a component within a set.
 *
 * @param {*} component A component that could contain a manual key.
 * @param {number} index Index that is used if a manual key is not provided.
 * @return {string}
 */


function getComponentKey(component, index) {
  // Do some typechecking here since we call this blindly. We want to ensure
  // that we don't block potential future ES APIs.
  if (typeof component === 'object' && component !== null && component.key != null) {
    // Explicit key
    return escape(component.key);
  } // Implicit key determined by the index in the set


  return index.toString(36);
}

function forEachSingleChild(bookKeeping, child, name) {
  var func = bookKeeping.func,
      context = bookKeeping.context;
  func.call(context, child, bookKeeping.count++);
}
/**
 * Iterates through children that are typically specified as `props.children`.
 *
 * See https://reactjs.org/docs/react-api.html#reactchildrenforeach
 *
 * The provided forEachFunc(child, index) will be called for each
 * leaf child.
 *
 * @param {?*} children Children tree container.
 * @param {function(*, int)} forEachFunc
 * @param {*} forEachContext Context for forEachContext.
 */


function forEachChildren(children, forEachFunc, forEachContext) {
  if (children == null) {
    return children;
  }

  var traverseContext = getPooledTraverseContext(null, null, forEachFunc, forEachContext);
  traverseAllChildren(children, forEachSingleChild, traverseContext);
  releaseTraverseContext(traverseContext);
}

function mapSingleChildIntoContext(bookKeeping, child, childKey) {
  var result = bookKeeping.result,
      keyPrefix = bookKeeping.keyPrefix,
      func = bookKeeping.func,
      context = bookKeeping.context;
  var mappedChild = func.call(context, child, bookKeeping.count++);

  if (Array.isArray(mappedChild)) {
    mapIntoWithKeyPrefixInternal(mappedChild, result, childKey, function (c) {
      return c;
    });
  } else if (mappedChild != null) {
    if (isValidElement(mappedChild)) {
      mappedChild = cloneAndReplaceKey(mappedChild, // Keep both the (mapped) and old keys if they differ, just as
      // traverseAllChildren used to do for objects as children
      keyPrefix + (mappedChild.key && (!child || child.key !== mappedChild.key) ? escapeUserProvidedKey(mappedChild.key) + '/' : '') + childKey);
    }

    result.push(mappedChild);
  }
}

function mapIntoWithKeyPrefixInternal(children, array, prefix, func, context) {
  var escapedPrefix = '';

  if (prefix != null) {
    escapedPrefix = escapeUserProvidedKey(prefix) + '/';
  }

  var traverseContext = getPooledTraverseContext(array, escapedPrefix, func, context);
  traverseAllChildren(children, mapSingleChildIntoContext, traverseContext);
  releaseTraverseContext(traverseContext);
}
/**
 * Maps children that are typically specified as `props.children`.
 *
 * See https://reactjs.org/docs/react-api.html#reactchildrenmap
 *
 * The provided mapFunction(child, key, index) will be called for each
 * leaf child.
 *
 * @param {?*} children Children tree container.
 * @param {function(*, int)} func The map function.
 * @param {*} context Context for mapFunction.
 * @return {object} Object containing the ordered map of results.
 */


function mapChildren(children, func, context) {
  if (children == null) {
    return children;
  }

  var result = [];
  mapIntoWithKeyPrefixInternal(children, result, null, func, context);
  return result;
}
/**
 * Count the number of children that are typically specified as
 * `props.children`.
 *
 * See https://reactjs.org/docs/react-api.html#reactchildrencount
 *
 * @param {?*} children Children tree container.
 * @return {number} The number of children.
 */


function countChildren(children) {
  return traverseAllChildren(children, function () {
    return null;
  }, null);
}
/**
 * Flatten a children object (typically specified as `props.children`) and
 * return an array with appropriately re-keyed children.
 *
 * See https://reactjs.org/docs/react-api.html#reactchildrentoarray
 */


function toArray(children) {
  var result = [];
  mapIntoWithKeyPrefixInternal(children, result, null, function (child) {
    return child;
  });
  return result;
}
/**
 * Returns the first child in a collection of children and verifies that there
 * is only one child in the collection.
 *
 * See https://reactjs.org/docs/react-api.html#reactchildrenonly
 *
 * The current implementation of this function assumes that a single child gets
 * passed without a wrapper, but the purpose of this helper function is to
 * abstract away the particular structure of children.
 *
 * @param {?object} children Child collection structure.
 * @return {ReactElement} The first and only `ReactElement` contained in the
 * structure.
 */


function onlyChild(children) {
  if (!isValidElement(children)) {
    {
      throw Error( "React.Children.only expected to receive a single React element child." );
    }
  }

  return children;
}

function createContext(defaultValue, calculateChangedBits) {
  if (calculateChangedBits === undefined) {
    calculateChangedBits = null;
  } else {
    {
      if (calculateChangedBits !== null && typeof calculateChangedBits !== 'function') {
        error('createContext: Expected the optional second argument to be a ' + 'function. Instead received: %s', calculateChangedBits);
      }
    }
  }

  var context = {
    $$typeof: REACT_CONTEXT_TYPE,
    _calculateChangedBits: calculateChangedBits,
    // As a workaround to support multiple concurrent renderers, we categorize
    // some renderers as primary and others as secondary. We only expect
    // there to be two concurrent renderers at most: React Native (primary) and
    // Fabric (secondary); React DOM (primary) and React ART (secondary).
    // Secondary renderers store their context values on separate fields.
    _currentValue: defaultValue,
    _currentValue2: defaultValue,
    // Used to track how many concurrent renderers this context currently
    // supports within in a single renderer. Such as parallel server rendering.
    _threadCount: 0,
    // These are circular
    Provider: null,
    Consumer: null
  };
  context.Provider = {
    $$typeof: REACT_PROVIDER_TYPE,
    _context: context
  };
  var hasWarnedAboutUsingNestedContextConsumers = false;
  var hasWarnedAboutUsingConsumerProvider = false;

  {
    // A separate object, but proxies back to the original context object for
    // backwards compatibility. It has a different $$typeof, so we can properly
    // warn for the incorrect usage of Context as a Consumer.
    var Consumer = {
      $$typeof: REACT_CONTEXT_TYPE,
      _context: context,
      _calculateChangedBits: context._calculateChangedBits
    }; // $FlowFixMe: Flow complains about not setting a value, which is intentional here

    Object.defineProperties(Consumer, {
      Provider: {
        get: function () {
          if (!hasWarnedAboutUsingConsumerProvider) {
            hasWarnedAboutUsingConsumerProvider = true;

            error('Rendering <Context.Consumer.Provider> is not supported and will be removed in ' + 'a future major release. Did you mean to render <Context.Provider> instead?');
          }

          return context.Provider;
        },
        set: function (_Provider) {
          context.Provider = _Provider;
        }
      },
      _currentValue: {
        get: function () {
          return context._currentValue;
        },
        set: function (_currentValue) {
          context._currentValue = _currentValue;
        }
      },
      _currentValue2: {
        get: function () {
          return context._currentValue2;
        },
        set: function (_currentValue2) {
          context._currentValue2 = _currentValue2;
        }
      },
      _threadCount: {
        get: function () {
          return context._threadCount;
        },
        set: function (_threadCount) {
          context._threadCount = _threadCount;
        }
      },
      Consumer: {
        get: function () {
          if (!hasWarnedAboutUsingNestedContextConsumers) {
            hasWarnedAboutUsingNestedContextConsumers = true;

            error('Rendering <Context.Consumer.Consumer> is not supported and will be removed in ' + 'a future major release. Did you mean to render <Context.Consumer> instead?');
          }

          return context.Consumer;
        }
      }
    }); // $FlowFixMe: Flow complains about missing properties because it doesn't understand defineProperty

    context.Consumer = Consumer;
  }

  {
    context._currentRenderer = null;
    context._currentRenderer2 = null;
  }

  return context;
}

function lazy(ctor) {
  var lazyType = {
    $$typeof: REACT_LAZY_TYPE,
    _ctor: ctor,
    // React uses these fields to store the result.
    _status: -1,
    _result: null
  };

  {
    // In production, this would just set it on the object.
    var defaultProps;
    var propTypes;
    Object.defineProperties(lazyType, {
      defaultProps: {
        configurable: true,
        get: function () {
          return defaultProps;
        },
        set: function (newDefaultProps) {
          error('React.lazy(...): It is not supported to assign `defaultProps` to ' + 'a lazy component import. Either specify them where the component ' + 'is defined, or create a wrapping component around it.');

          defaultProps = newDefaultProps; // Match production behavior more closely:

          Object.defineProperty(lazyType, 'defaultProps', {
            enumerable: true
          });
        }
      },
      propTypes: {
        configurable: true,
        get: function () {
          return propTypes;
        },
        set: function (newPropTypes) {
          error('React.lazy(...): It is not supported to assign `propTypes` to ' + 'a lazy component import. Either specify them where the component ' + 'is defined, or create a wrapping component around it.');

          propTypes = newPropTypes; // Match production behavior more closely:

          Object.defineProperty(lazyType, 'propTypes', {
            enumerable: true
          });
        }
      }
    });
  }

  return lazyType;
}

function forwardRef(render) {
  {
    if (render != null && render.$$typeof === REACT_MEMO_TYPE) {
      error('forwardRef requires a render function but received a `memo` ' + 'component. Instead of forwardRef(memo(...)), use ' + 'memo(forwardRef(...)).');
    } else if (typeof render !== 'function') {
      error('forwardRef requires a render function but was given %s.', render === null ? 'null' : typeof render);
    } else {
      if (render.length !== 0 && render.length !== 2) {
        error('forwardRef render functions accept exactly two parameters: props and ref. %s', render.length === 1 ? 'Did you forget to use the ref parameter?' : 'Any additional parameter will be undefined.');
      }
    }

    if (render != null) {
      if (render.defaultProps != null || render.propTypes != null) {
        error('forwardRef render functions do not support propTypes or defaultProps. ' + 'Did you accidentally pass a React component?');
      }
    }
  }

  return {
    $$typeof: REACT_FORWARD_REF_TYPE,
    render: render
  };
}

function isValidElementType(type) {
  return typeof type === 'string' || typeof type === 'function' || // Note: its typeof might be other than 'symbol' or 'number' if it's a polyfill.
  type === REACT_FRAGMENT_TYPE || type === REACT_CONCURRENT_MODE_TYPE || type === REACT_PROFILER_TYPE || type === REACT_STRICT_MODE_TYPE || type === REACT_SUSPENSE_TYPE || type === REACT_SUSPENSE_LIST_TYPE || typeof type === 'object' && type !== null && (type.$$typeof === REACT_LAZY_TYPE || type.$$typeof === REACT_MEMO_TYPE || type.$$typeof === REACT_PROVIDER_TYPE || type.$$typeof === REACT_CONTEXT_TYPE || type.$$typeof === REACT_FORWARD_REF_TYPE || type.$$typeof === REACT_FUNDAMENTAL_TYPE || type.$$typeof === REACT_RESPONDER_TYPE || type.$$typeof === REACT_SCOPE_TYPE || type.$$typeof === REACT_BLOCK_TYPE);
}

function memo(type, compare) {
  {
    if (!isValidElementType(type)) {
      error('memo: The first argument must be a component. Instead ' + 'received: %s', type === null ? 'null' : typeof type);
    }
  }

  return {
    $$typeof: REACT_MEMO_TYPE,
    type: type,
    compare: compare === undefined ? null : compare
  };
}

function resolveDispatcher() {
  var dispatcher = ReactCurrentDispatcher.current;

  if (!(dispatcher !== null)) {
    {
      throw Error( "Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://fb.me/react-invalid-hook-call for tips about how to debug and fix this problem." );
    }
  }

  return dispatcher;
}

function useContext(Context, unstable_observedBits) {
  var dispatcher = resolveDispatcher();

  {
    if (unstable_observedBits !== undefined) {
      error('useContext() second argument is reserved for future ' + 'use in React. Passing it is not supported. ' + 'You passed: %s.%s', unstable_observedBits, typeof unstable_observedBits === 'number' && Array.isArray(arguments[2]) ? '\n\nDid you call array.map(useContext)? ' + 'Calling Hooks inside a loop is not supported. ' + 'Learn more at https://fb.me/rules-of-hooks' : '');
    } // TODO: add a more generic warning for invalid values.


    if (Context._context !== undefined) {
      var realContext = Context._context; // Don't deduplicate because this legitimately causes bugs
      // and nobody should be using this in existing code.

      if (realContext.Consumer === Context) {
        error('Calling useContext(Context.Consumer) is not supported, may cause bugs, and will be ' + 'removed in a future major release. Did you mean to call useContext(Context) instead?');
      } else if (realContext.Provider === Context) {
        error('Calling useContext(Context.Provider) is not supported. ' + 'Did you mean to call useContext(Context) instead?');
      }
    }
  }

  return dispatcher.useContext(Context, unstable_observedBits);
}
function useState(initialState) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useState(initialState);
}
function useReducer(reducer, initialArg, init) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useReducer(reducer, initialArg, init);
}
function useRef(initialValue) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useRef(initialValue);
}
function useEffect(create, deps) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useEffect(create, deps);
}
function useLayoutEffect(create, deps) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useLayoutEffect(create, deps);
}
function useCallback(callback, deps) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useCallback(callback, deps);
}
function useMemo(create, deps) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useMemo(create, deps);
}
function useImperativeHandle(ref, create, deps) {
  var dispatcher = resolveDispatcher();
  return dispatcher.useImperativeHandle(ref, create, deps);
}
function useDebugValue(value, formatterFn) {
  {
    var dispatcher = resolveDispatcher();
    return dispatcher.useDebugValue(value, formatterFn);
  }
}

var propTypesMisspellWarningShown;

{
  propTypesMisspellWarningShown = false;
}

function getDeclarationErrorAddendum() {
  if (ReactCurrentOwner.current) {
    var name = getComponentName(ReactCurrentOwner.current.type);

    if (name) {
      return '\n\nCheck the render method of `' + name + '`.';
    }
  }

  return '';
}

function getSourceInfoErrorAddendum(source) {
  if (source !== undefined) {
    var fileName = source.fileName.replace(/^.*[\\\/]/, '');
    var lineNumber = source.lineNumber;
    return '\n\nCheck your code at ' + fileName + ':' + lineNumber + '.';
  }

  return '';
}

function getSourceInfoErrorAddendumForProps(elementProps) {
  if (elementProps !== null && elementProps !== undefined) {
    return getSourceInfoErrorAddendum(elementProps.__source);
  }

  return '';
}
/**
 * Warn if there's no key explicitly set on dynamic arrays of children or
 * object keys are not valid. This allows us to keep track of children between
 * updates.
 */


var ownerHasKeyUseWarning = {};

function getCurrentComponentErrorInfo(parentType) {
  var info = getDeclarationErrorAddendum();

  if (!info) {
    var parentName = typeof parentType === 'string' ? parentType : parentType.displayName || parentType.name;

    if (parentName) {
      info = "\n\nCheck the top-level render call using <" + parentName + ">.";
    }
  }

  return info;
}
/**
 * Warn if the element doesn't have an explicit key assigned to it.
 * This element is in an array. The array could grow and shrink or be
 * reordered. All children that haven't already been validated are required to
 * have a "key" property assigned to it. Error statuses are cached so a warning
 * will only be shown once.
 *
 * @internal
 * @param {ReactElement} element Element that requires a key.
 * @param {*} parentType element's parent's type.
 */


function validateExplicitKey(element, parentType) {
  if (!element._store || element._store.validated || element.key != null) {
    return;
  }

  element._store.validated = true;
  var currentComponentErrorInfo = getCurrentComponentErrorInfo(parentType);

  if (ownerHasKeyUseWarning[currentComponentErrorInfo]) {
    return;
  }

  ownerHasKeyUseWarning[currentComponentErrorInfo] = true; // Usually the current owner is the offender, but if it accepts children as a
  // property, it may be the creator of the child that's responsible for
  // assigning it a key.

  var childOwner = '';

  if (element && element._owner && element._owner !== ReactCurrentOwner.current) {
    // Give the component that originally created this child.
    childOwner = " It was passed a child from " + getComponentName(element._owner.type) + ".";
  }

  setCurrentlyValidatingElement(element);

  {
    error('Each child in a list should have a unique "key" prop.' + '%s%s See https://fb.me/react-warning-keys for more information.', currentComponentErrorInfo, childOwner);
  }

  setCurrentlyValidatingElement(null);
}
/**
 * Ensure that every element either is passed in a static location, in an
 * array with an explicit keys property defined, or in an object literal
 * with valid key property.
 *
 * @internal
 * @param {ReactNode} node Statically passed child of any type.
 * @param {*} parentType node's parent's type.
 */


function validateChildKeys(node, parentType) {
  if (typeof node !== 'object') {
    return;
  }

  if (Array.isArray(node)) {
    for (var i = 0; i < node.length; i++) {
      var child = node[i];

      if (isValidElement(child)) {
        validateExplicitKey(child, parentType);
      }
    }
  } else if (isValidElement(node)) {
    // This element was passed in a valid location.
    if (node._store) {
      node._store.validated = true;
    }
  } else if (node) {
    var iteratorFn = getIteratorFn(node);

    if (typeof iteratorFn === 'function') {
      // Entry iterators used to provide implicit keys,
      // but now we print a separate warning for them later.
      if (iteratorFn !== node.entries) {
        var iterator = iteratorFn.call(node);
        var step;

        while (!(step = iterator.next()).done) {
          if (isValidElement(step.value)) {
            validateExplicitKey(step.value, parentType);
          }
        }
      }
    }
  }
}
/**
 * Given an element, validate that its props follow the propTypes definition,
 * provided by the type.
 *
 * @param {ReactElement} element
 */


function validatePropTypes(element) {
  {
    var type = element.type;

    if (type === null || type === undefined || typeof type === 'string') {
      return;
    }

    var name = getComponentName(type);
    var propTypes;

    if (typeof type === 'function') {
      propTypes = type.propTypes;
    } else if (typeof type === 'object' && (type.$$typeof === REACT_FORWARD_REF_TYPE || // Note: Memo only checks outer props here.
    // Inner props are checked in the reconciler.
    type.$$typeof === REACT_MEMO_TYPE)) {
      propTypes = type.propTypes;
    } else {
      return;
    }

    if (propTypes) {
      setCurrentlyValidatingElement(element);
      checkPropTypes(propTypes, element.props, 'prop', name, ReactDebugCurrentFrame.getStackAddendum);
      setCurrentlyValidatingElement(null);
    } else if (type.PropTypes !== undefined && !propTypesMisspellWarningShown) {
      propTypesMisspellWarningShown = true;

      error('Component %s declared `PropTypes` instead of `propTypes`. Did you misspell the property assignment?', name || 'Unknown');
    }

    if (typeof type.getDefaultProps === 'function' && !type.getDefaultProps.isReactClassApproved) {
      error('getDefaultProps is only used on classic React.createClass ' + 'definitions. Use a static property named `defaultProps` instead.');
    }
  }
}
/**
 * Given a fragment, validate that it can only be provided with fragment props
 * @param {ReactElement} fragment
 */


function validateFragmentProps(fragment) {
  {
    setCurrentlyValidatingElement(fragment);
    var keys = Object.keys(fragment.props);

    for (var i = 0; i < keys.length; i++) {
      var key = keys[i];

      if (key !== 'children' && key !== 'key') {
        error('Invalid prop `%s` supplied to `React.Fragment`. ' + 'React.Fragment can only have `key` and `children` props.', key);

        break;
      }
    }

    if (fragment.ref !== null) {
      error('Invalid attribute `ref` supplied to `React.Fragment`.');
    }

    setCurrentlyValidatingElement(null);
  }
}
function createElementWithValidation(type, props, children) {
  var validType = isValidElementType(type); // We warn in this case but don't throw. We expect the element creation to
  // succeed and there will likely be errors in render.

  if (!validType) {
    var info = '';

    if (type === undefined || typeof type === 'object' && type !== null && Object.keys(type).length === 0) {
      info += ' You likely forgot to export your component from the file ' + "it's defined in, or you might have mixed up default and named imports.";
    }

    var sourceInfo = getSourceInfoErrorAddendumForProps(props);

    if (sourceInfo) {
      info += sourceInfo;
    } else {
      info += getDeclarationErrorAddendum();
    }

    var typeString;

    if (type === null) {
      typeString = 'null';
    } else if (Array.isArray(type)) {
      typeString = 'array';
    } else if (type !== undefined && type.$$typeof === REACT_ELEMENT_TYPE) {
      typeString = "<" + (getComponentName(type.type) || 'Unknown') + " />";
      info = ' Did you accidentally export a JSX literal instead of a component?';
    } else {
      typeString = typeof type;
    }

    {
      error('React.createElement: type is invalid -- expected a string (for ' + 'built-in components) or a class/function (for composite ' + 'components) but got: %s.%s', typeString, info);
    }
  }

  var element = createElement.apply(this, arguments); // The result can be nullish if a mock or a custom function is used.
  // TODO: Drop this when these are no longer allowed as the type argument.

  if (element == null) {
    return element;
  } // Skip key warning if the type isn't valid since our key validation logic
  // doesn't expect a non-string/function type and can throw confusing errors.
  // We don't want exception behavior to differ between dev and prod.
  // (Rendering will throw with a helpful message and as soon as the type is
  // fixed, the key warnings will appear.)


  if (validType) {
    for (var i = 2; i < arguments.length; i++) {
      validateChildKeys(arguments[i], type);
    }
  }

  if (type === REACT_FRAGMENT_TYPE) {
    validateFragmentProps(element);
  } else {
    validatePropTypes(element);
  }

  return element;
}
var didWarnAboutDeprecatedCreateFactory = false;
function createFactoryWithValidation(type) {
  var validatedFactory = createElementWithValidation.bind(null, type);
  validatedFactory.type = type;

  {
    if (!didWarnAboutDeprecatedCreateFactory) {
      didWarnAboutDeprecatedCreateFactory = true;

      warn('React.createFactory() is deprecated and will be removed in ' + 'a future major release. Consider using JSX ' + 'or use React.createElement() directly instead.');
    } // Legacy hook: remove it


    Object.defineProperty(validatedFactory, 'type', {
      enumerable: false,
      get: function () {
        warn('Factory.type is deprecated. Access the class directly ' + 'before passing it to createFactory.');

        Object.defineProperty(this, 'type', {
          value: type
        });
        return type;
      }
    });
  }

  return validatedFactory;
}
function cloneElementWithValidation(element, props, children) {
  var newElement = cloneElement.apply(this, arguments);

  for (var i = 2; i < arguments.length; i++) {
    validateChildKeys(arguments[i], newElement.type);
  }

  validatePropTypes(newElement);
  return newElement;
}

{

  try {
    var frozenObject = Object.freeze({});
    var testMap = new Map([[frozenObject, null]]);
    var testSet = new Set([frozenObject]); // This is necessary for Rollup to not consider these unused.
    // https://github.com/rollup/rollup/issues/1771
    // TODO: we can remove these if Rollup fixes the bug.

    testMap.set(0, 0);
    testSet.add(0);
  } catch (e) {
  }
}

var createElement$1 =  createElementWithValidation ;
var cloneElement$1 =  cloneElementWithValidation ;
var createFactory =  createFactoryWithValidation ;
var Children = {
  map: mapChildren,
  forEach: forEachChildren,
  count: countChildren,
  toArray: toArray,
  only: onlyChild
};

exports.Children = Children;
exports.Component = Component;
exports.Fragment = REACT_FRAGMENT_TYPE;
exports.Profiler = REACT_PROFILER_TYPE;
exports.PureComponent = PureComponent;
exports.StrictMode = REACT_STRICT_MODE_TYPE;
exports.Suspense = REACT_SUSPENSE_TYPE;
exports.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = ReactSharedInternals;
exports.cloneElement = cloneElement$1;
exports.createContext = createContext;
exports.createElement = createElement$1;
exports.createFactory = createFactory;
exports.createRef = createRef;
exports.forwardRef = forwardRef;
exports.isValidElement = isValidElement;
exports.lazy = lazy;
exports.memo = memo;
exports.useCallback = useCallback;
exports.useContext = useContext;
exports.useDebugValue = useDebugValue;
exports.useEffect = useEffect;
exports.useImperativeHandle = useImperativeHandle;
exports.useLayoutEffect = useLayoutEffect;
exports.useMemo = useMemo;
exports.useReducer = useReducer;
exports.useRef = useRef;
exports.useState = useState;
exports.version = ReactVersion;
  })();
}


/***/ },

/***/ "../../../node_modules/react/index.js"
/*!********************************************!*\
  !*** ../../../node_modules/react/index.js ***!
  \********************************************/
(module, __unused_webpack_exports, __webpack_require__) {

"use strict";


if (false) // removed by dead control flow
{} else {
  module.exports = __webpack_require__(/*! ./cjs/react.development.js */ "../../../node_modules/react/cjs/react.development.js");
}


/***/ },

/***/ "../../../node_modules/react/jsx-runtime.js"
/*!**************************************************!*\
  !*** ../../../node_modules/react/jsx-runtime.js ***!
  \**************************************************/
(module, __unused_webpack_exports, __webpack_require__) {

"use strict";


if (false) // removed by dead control flow
{} else {
  module.exports = __webpack_require__(/*! ./cjs/react-jsx-runtime.development.js */ "../../../node_modules/react/cjs/react-jsx-runtime.development.js");
}


/***/ },

/***/ "./commonLib/components/error_boundary.tsx"
/*!*************************************************!*\
  !*** ./commonLib/components/error_boundary.tsx ***!
  \*************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   ErrorBoundary: () => (/* binding */ ErrorBoundary)
/* harmony export */ });
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-runtime */ "../../../node_modules/react/jsx-runtime.js");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");


class ErrorBoundary extends react__WEBPACK_IMPORTED_MODULE_1__.Component {
    constructor() {
        super(...arguments);
        this.state = {
            hasError: false,
            error: new Error(),
        };
    }
    static getDerivedStateFromError(error) {
        return { hasError: true, error };
    }
    componentDidCatch(error, errorInfo) {
        this.setState({ hasError: true, error: error });
        console.warn(`ErrorBoundary Msg: ${error}`);
        console.warn(`ErrorBoundary ComponentStack:`, errorInfo.componentStack);
        if (this.props.onError) {
            this.props.onError(error, errorInfo);
        }
    }
    render() {
        var _a;
        if (this.state.hasError) {
            try {
                if (this.props.renderError) {
                    return this.props.renderError(this.state.error);
                }
                else {
                    return (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { text: (_a = this.props.errorMessage) !== null && _a !== void 0 ? _a : $.Localize(`#react_ui_error_boundary`) });
                }
            }
            catch (e) {
                // fallback 渲染也失败了（例如组件树正在被销毁），返回空面板避免级联崩溃
                return (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, {});
            }
        }
        return this.props.children;
    }
    recover() {
        this.setState({ hasError: false });
        if (this.props.onRecover) {
            this.props.onRecover();
        }
    }
}


/***/ },

/***/ "./commonLib/components/loading/loading.tsx"
/*!**************************************************!*\
  !*** ./commonLib/components/loading/loading.tsx ***!
  \**************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   Loading: () => (/* binding */ Loading)
/* harmony export */ });
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-runtime */ "../../../node_modules/react/jsx-runtime.js");

/**
 * loading animation
 * @param num
 * @returns
 */
function Loading(props) {
    var _a, _b, _c;
    let num = (_a = props.num) !== null && _a !== void 0 ? _a : 5;
    const color = (_b = props.color) !== null && _b !== void 0 ? _b : "#1c1c1c";
    if (num > 8) {
        num = 8;
    }
    if (num < 1) {
        num = 1;
    }
    const className = (_c = props.className) !== null && _c !== void 0 ? _c : "";
    return ((0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: `loadingAnimation ${className}` }, { children: [...Array(num)].map((dot, index) => {
            const animationdelay = `${0.2 * index}s`;
            return ((0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { style: {
                    animationDelay: animationdelay,
                    backgroundColor: color,
                }, className: `loading${index} dot` }, index));
        }) })));
}


/***/ },

/***/ "./commonLib/components/react_encapsulation.tsx"
/*!******************************************************!*\
  !*** ./commonLib/components/react_encapsulation.tsx ***!
  \******************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   EBRender: () => (/* binding */ EBRender)
/* harmony export */ });
/* unused harmony export onError */
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-runtime */ "../../../node_modules/react/jsx-runtime.js");
/* harmony import */ var _commonLib_components_error_boundary__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @commonLib/components/error_boundary */ "./commonLib/components/error_boundary.tsx");
/* harmony import */ var react_panorama_x__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! react-panorama-x */ "../../../node_modules/react-panorama-x/dist/esm/react-panorama.development.js");



function stringifyUnknownError(error) {
    if (error instanceof Error) {
        return {
            name: error.name,
            message: error.message,
            stack: error.stack,
            raw: "",
        };
    }
    if (typeof error === "string") {
        return {
            name: "NonErrorThrown",
            message: error,
            stack: "",
            raw: error,
        };
    }
    let raw = "";
    try {
        raw = JSON.stringify(error);
    }
    catch (_a) {
        raw = String(error);
    }
    return {
        name: "NonErrorThrown",
        message: String(error),
        stack: "",
        raw,
    };
}
const onError = (error, errorInfo) => {
    const normalizedError = stringifyUnknownError(error);
    GameEvents.SendCustomGameEventToServer("c2s_save_ui_error_super_mid", {
        error: `errorName:${normalizedError.name}: errorMessage:${normalizedError.message}:errorStack:${normalizedError.stack} rawError:${normalizedError.raw} \n componentStack:${errorInfo.componentStack}`,
    });
};
function EBRender(element, container, callback) {
    let elem = element;
    if (elem != null) {
        elem = (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(_commonLib_components_error_boundary__WEBPACK_IMPORTED_MODULE_1__.ErrorBoundary, Object.assign({ onError: onError }, { children: elem }));
    }
    (0,react_panorama_x__WEBPACK_IMPORTED_MODULE_2__.render)(elem, container, callback);
}


/***/ },

/***/ "./commonLib/ext/dollor_extension.ts"
/*!*******************************************!*\
  !*** ./commonLib/ext/dollor_extension.ts ***!
  \*******************************************/
(__unused_webpack_module, __unused_webpack___webpack_exports__, __webpack_require__) {

"use strict";
/* harmony import */ var _commonLib_utils_string_utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @commonLib/utils/string_utils */ "./commonLib/utils/string_utils.ts");

// 打印日志，参数间空格分隔
$.log = (...args) => {
    // if (!Game.IsInToolsMode()) {
    //     return;
    // }
    const _args = [];
    args.forEach(value => {
        _args.push(value, " ");
    });
    $.Msg(..._args);
};
//分行打印超长字符串
$.printFullStr = (str) => {
    const lineLen = 200;
    const lineCount = Math.ceil(str.length / lineLen);
    for (let i = 0; i < lineCount; i++) {
        $.log(str.substring(i * lineLen, (i + 1) * lineLen));
    }
    $.log("");
};
//  封装的多语言函数
//  可扩展追踪未使用本地化key的字符串，和未定义的本地化key
$.lang = (str, ...args) => {
    let result = str;
    if (str.startsWith("#")) {
        result = $.Localize(str);
        // 需要时放开
        // if (result == str) {
        //     $.log("未定义的本地化key:", str);
        // }
    }
    else {
        // 需要时放开
        //$.log("未使用本地化key的字符串:", str);
    }
    if (args.length == 0) {
        return result;
    }
    return (0,_commonLib_utils_string_utils__WEBPACK_IMPORTED_MODULE_0__.str4mat)(result, ...args);
};


/***/ },

/***/ "./commonLib/hooks/useLocalEvent.ts"
/*!******************************************!*\
  !*** ./commonLib/hooks/useLocalEvent.ts ***!
  \******************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   useLocalEvent: () => (/* binding */ useLocalEvent)
/* harmony export */ });
/* harmony import */ var _commonLib_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @commonLib/modules/evt/local_event_utils */ "./commonLib/modules/evt/local_event_utils.ts");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");


function useLocalEvent(eventName, listener, dependencies = [], enabled = true) {
    (0,react__WEBPACK_IMPORTED_MODULE_1__.useLayoutEffect)(() => {
        if (!enabled) {
            return;
        }
        (0,_commonLib_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__.onLocalEvent)(eventName, listener);
        return () => {
            (0,_commonLib_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__.offLocalEvent)(eventName, listener);
        };
    }, dependencies);
}


/***/ },

/***/ "./commonLib/modules/evt/local_event_utils.ts"
/*!****************************************************!*\
  !*** ./commonLib/modules/evt/local_event_utils.ts ***!
  \****************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   emitLocalEvent: () => (/* binding */ emitLocalEvent),
/* harmony export */   offLocalEvent: () => (/* binding */ offLocalEvent),
/* harmony export */   onLocalEvent: () => (/* binding */ onLocalEvent)
/* harmony export */ });
/* unused harmony exports onceLocalEvent, onLocalEventWithPrecondition, onLocalEventAndDoFirst, clearAllLocalEventListeners, checkAndClearOnReload */
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

/***/ "./commonLib/modules/evt/net_event_utils.ts"
/*!**************************************************!*\
  !*** ./commonLib/modules/evt/net_event_utils.ts ***!
  \**************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   sendNetEvent: () => (/* binding */ sendNetEvent),
/* harmony export */   sendNetEventDebounce: () => (/* binding */ sendNetEventDebounce)
/* harmony export */ });
/* unused harmony exports onNetEvent, offNetEvent, onNetTable, useNetTableEvent, offNetTable, onPlayerNetTable, getPlayerNetTableKey, getNetTableKey, onGameEvent */
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");

/**
 * 侦听网络事件
 * @param eventName
 * @param listener
 * @returns
 */
function onNetEvent(eventName, listener) {
    const id = GameEvents.Subscribe(eventName, listener);
    return id;
}
/**
 * 移除网络侦听事件
 * @param id
 */
function offNetEvent(id) {
    GameEvents.Unsubscribe(id);
}
/**
 * 发送网络事件
 * @param eventName
 * @param data
 */
function sendNetEvent(eventName, data, signalHandler) {
    // AddNetEventBuffer(eventName, data ?? {}, signalHandler);
    GameEvents.SendCustomGameEventToServer(eventName, data !== null && data !== void 0 ? data : {});
}
/**
 * 发送网络事件(防抖)
 * @param eventName
 * @param data
 * @param wait 防抖延迟
 */
function sendNetEventDebounce(eventName, data, wait, message, debounceKeySuffix = "", signalHandler) {
    //暂时没有找到原因
    GameEvents.SendCustomGameEventToServer(eventName, data);
    // return debounceCallWithMessage(`${eventName}${String(debounceKeySuffix)}`, AddNetEventBuffer, wait, message, [
    //     eventName,
    //     data ?? {},
    //     signalHandler,
    // ]);
}
/**
 * 侦听无关于玩家的网表更新
 * @param tableName
 * @param callback
 * @returns
 */
function onNetTable(tableName, key, callback) {
    const value = CustomNetTables.GetTableValue(tableName, key);
    if (value) {
        callback(value);
    }
    const id = CustomNetTables.SubscribeNetTableListener(tableName, (tblName, k, v) => {
        if (k == key) {
            callback(v);
        }
    });
    //Game.netTableListenerPool.push(id);
    return id;
}
function useNetTableEvent(tableName, key, callback) {
    const data = CustomNetTables.GetTableValue(tableName, key);
    // if (data) {
    //     callback(data as V);
    // }
    (0,react__WEBPACK_IMPORTED_MODULE_0__.useEffect)(() => {
        const id = CustomNetTables.SubscribeNetTableListener(tableName, (tblName, k, v) => {
            if (k == key) {
                callback(v);
            }
        });
        return () => {
            CustomNetTables.UnsubscribeNetTableListener(id);
        };
    }, []);
}
/**
 * 移除网表更新侦听
 * @param id
 */
function offNetTable(id) {
    CustomNetTables.UnsubscribeNetTableListener(id);
}
/**
 * 侦听与玩家有关的网表更新
 * @param tableName
 * @param key
 * @param listener
 * @param playerId
 */
function onPlayerNetTable(tableName, key, listener, playerId = Game.GetLocalPlayerID()) {
    const playerKey = `${key}${playerId}`;
    //@ts-expect-error: TS2554: Expected 'T' to be of type 'string' but got 'number'.
    const value = CustomNetTables.GetTableValue(tableName, playerKey);
    if (value) {
        listener(value, tableName, playerKey);
    }
    const id = CustomNetTables.SubscribeNetTableListener(tableName, (tblName, k, value) => {
        if (String(k) == playerKey) {
            listener(value, tblName, playerKey);
        }
    });
    //Game.netTableListenerPool.push(id);
    return id;
}
/**
 * 获取与玩家有关网表数据
 * @param name
 * @param key
 * @param playerId
 * @returns
 */
function getPlayerNetTableKey(name, key, playerId = Game.GetLocalPlayerID()) {
    //@ts-expect-error: TS2554: Expected 'T' to be of type 'string' but got 'number'.
    return CustomNetTables.GetTableValue(name, `${key}${playerId}`);
}
/**
 * 获取与玩家有关网表数据
 * @param name
 * @param key
 * @param playerId
 * @returns
 */
function getNetTableKey(name, key) {
    //@ts-expect-error: TS2554: Expected 'T' to be of type 'string' but got 'number'.
    return CustomNetTables.GetTableValue(name, `${key}`);
}
function onGameEvent(eventName, listener) {
    const event = GameEvents.Subscribe(eventName, listener);
    return event;
}


/***/ },

/***/ "./commonLib/modules/tooltip/tooltip_utils.ts"
/*!****************************************************!*\
  !*** ./commonLib/modules/tooltip/tooltip_utils.ts ***!
  \****************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   GetTooltipDisplayProp: () => (/* binding */ GetTooltipDisplayProp)
/* harmony export */ });
/* unused harmony export SetupTooltips */
/* harmony import */ var react_panorama_x__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react-panorama-x */ "../../../node_modules/react-panorama-x/dist/esm/react-panorama.development.js");

/**
 * 去掉Tooltip默认样式
 * @param contextPanel
 * @param renderer
 */
function SetupTooltips(contextPanel, renderer, noShadow = false) {
    var _a;
    contextPanel.SetPanelEvent(`ontooltiploaded`, () => {
        const data = GameUI.CustomUIConfig().GetCurTooltipData();
        if (data) {
            (0,react_panorama_x__WEBPACK_IMPORTED_MODULE_0__.render)(renderer(data), contextPanel);
        }
    });
    let parent = contextPanel.GetParent();
    _hideArrowPanel(parent, "LeftArrow");
    _hideArrowPanel(parent, "RightArrow");
    parent = (_a = parent === null || parent === void 0 ? void 0 : parent.GetParent()) !== null && _a !== void 0 ? _a : null;
    _hideArrowPanel(parent, "TopArrow");
    _hideArrowPanel(parent, "BottomArrow");
    contextPanel.style.padding = `0px`;
    contextPanel.style.backgroundColor = `#00000000`;
    contextPanel.style.border = `0px solid #00000000`;
    if (noShadow) {
        contextPanel.style.boxShadow = "#00000000 0px 0px 0px 0px";
    }
}
function _hideArrowPanel(parent, arrowName) {
    const arrow = parent === null || parent === void 0 ? void 0 : parent.FindChildTraverse(arrowName);
    arrow && (arrow.style.opacity = "0");
}
/**
 * 获得带有鼠标移入移出事件的对象，用于向任何对象添加tooltip显示功能，但如果向已注册相关事件的对象添加该属性，会出问题
 * @param type
 * @param data
 * @returns
 */
function GetTooltipDisplayProp(type, data, disabled = false) {
    if (!data) {
        return {};
    }
    return {
        onmouseover: (panel) => {
            if (!disabled) {
                GameUI.CustomUIConfig().ShowTooltip(type, panel, data);
            }
        },
        onmouseout: () => {
            if (!disabled) {
                GameUI.CustomUIConfig().HideTooltip();
            }
        },
    };
}


/***/ },

/***/ "./commonLib/utils/player_utils.ts"
/*!*****************************************!*\
  !*** ./commonLib/utils/player_utils.ts ***!
  \*****************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   isChinese: () => (/* binding */ isChinese)
/* harmony export */ });
/* unused harmony exports getAllPlayerState, isLocalPlayer, GetPlayerInfo, GetLocalPlayerInfo, GetLocalPlayerTeam, getPlayerState, hasPlayerAbandon, isOb */
/**
 * 玩家相关工具方法
 */
/**
 * 返回所有玩家的连接状态
 * @returns
 */
function getAllPlayerState() {
    const allPlayer = Game.GetAllPlayerIDs();
    const allPlayerStateRecord = {};
    allPlayer.forEach(playerId => {
        var _a;
        const player_connection_state = (_a = Game.GetPlayerInfo(playerId)) === null || _a === void 0 ? void 0 : _a.player_connection_state;
        if (player_connection_state) {
            allPlayerStateRecord[playerId] = player_connection_state;
        }
    });
    return allPlayerStateRecord;
}
function isLocalPlayer(PlayerID) {
    return Game.GetLocalPlayerID() == PlayerID;
}
function GetPlayerInfo(playerId) {
    var _a;
    return (_a = Game.GetPlayerInfo(Number(playerId))) !== null && _a !== void 0 ? _a : {};
}
function GetLocalPlayerInfo() {
    return Game.GetPlayerInfo(Game.GetLocalPlayerID());
}
function GetLocalPlayerTeam() {
    var _a;
    return (_a = GetLocalPlayerInfo()) === null || _a === void 0 ? void 0 : _a.player_team_id;
}
/**
 * 返回某个玩家的连接状态
 */
function getPlayerState(playerId) {
    var _a;
    if (!playerId)
        return 0;
    const player_connection_state = (_a = Game.GetPlayerInfo(playerId)) === null || _a === void 0 ? void 0 : _a.player_connection_state;
    return player_connection_state;
}
/**
 * 是否有玩家放弃比赛
 * @returns
 */
function hasPlayerAbandon() {
    const allState = getAllPlayerState();
    const hasAbandon = Object.values(allState).includes(DOTAConnectionState_t.DOTA_CONNECTION_STATE_ABANDONED);
    return hasAbandon;
}
/**
 * 是否是ob
 */
function isOb() {
    const localPlayerID = Game.GetLocalPlayerID();
    const ourTeam = Players.GetTeam(localPlayerID);
    const isOb = ourTeam == 5 || ourTeam == -1;
    return isOb;
}
/**
 * 客户端语言是否为中文
 */
function isChinese() {
    const language = $.Language().toLowerCase();
    if (language == "schinese" || language == "tchinese") {
        return true;
    }
    else {
        return false;
    }
}


/***/ },

/***/ "./commonLib/utils/string_utils.ts"
/*!*****************************************!*\
  !*** ./commonLib/utils/string_utils.ts ***!
  \*****************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   str4mat: () => (/* binding */ str4mat)
/* harmony export */ });
/* unused harmony exports ToFixedString, IntToARGB, formatSecond, ShortenNumber, GetShortenNumberStr, ToComparableNumber, CompareNumber, SpreadScientificNotation, convertToChinaNum, GetRoughTimeStr, GetAccurateTimeStr, compact, formatStringToGoods, toHHmmss, formatDate, formatStringToAttrubuteInfo, progressNum */
/* harmony import */ var dayjs__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! dayjs */ "../../../node_modules/dayjs/dayjs.min.js");
/* harmony import */ var dayjs__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(dayjs__WEBPACK_IMPORTED_MODULE_0__);
/**
 * 字符串相关工具方法
 */

/**
 * 四舍五入精确到某位数字的digits位小数，并返回字符串形式
 * @export
 * @param {number} value
 * @param {number} digits
 * @return {*}
 */
function ToFixedString(value, digits) {
    const m = Math.pow(10, digits);
    return (Math.round(value * m) / m).toString();
}
function IntToARGB(i) {
    return (("00" + (i & 0xff).toString(16)).substr(-2) +
        ("00" + ((i >> 8) & 0xff).toString(16)).substr(-2) +
        ("00" + ((i >> 16) & 0xff).toString(16)).substr(-2) +
        ("00" + ((i >> 24) & 0xff).toString(16)).substr(-2));
}
/**
 * 格式化秒数
 * @param sec
 * @param template
 * @returns
 */
function formatSecond(sec, template) {
    const totalMins = Math.floor(sec / 60000);
    const hours = Math.floor(totalMins / 60);
    let mins = totalMins % 60;
    let secs = Math.floor((sec % 60000) / 1000);
    const msecs = sec % 1000;
    const hasH = template.includes("h");
    const hasM = template.includes("m");
    if (!hasH) {
        mins += hours * 60;
    }
    if (!hasM) {
        secs += mins * 60;
    }
    let hourStr = String(hours);
    let minStr = String(mins);
    let secStr = String(secs);
    let msecStr = String(msecs);
    if (template.includes("hh")) {
        hourStr = hourStr.padStart(2, "0");
    }
    if (template.includes("mm")) {
        minStr = minStr.padStart(2, "0");
    }
    if (template.includes("ss")) {
        secStr = secStr.padStart(2, "0");
    }
    if (template.includes("lll")) {
        msecStr = msecStr.padStart(3, "0");
    }
    return template
        .replace("hh", hourStr)
        .replace("h", hourStr)
        .replace("mm", minStr)
        .replace("m", minStr)
        .replace("ss", secStr)
        .replace("s", secStr)
        .replace("lll", msecStr)
        .replace("l", msecStr);
}
//5-万 9亿 13万亿 17万万亿 21亿亿 25万亿亿
const unitList = [
    "",
    "万",
    "亿",
    "兆",
    "京",
    "垓",
    "秭",
    "穰",
    "沟",
    "涧",
    "正",
    "载",
    "极",
    "恒沙河",
    "阿僧祗",
    "那由他",
    "不可思议",
    "无量",
    "大数",
];
const unitList_E = [
    "",
    "K",
    "M",
    "B",
    "T",
    "Qa",
    "Qi",
    "Sx",
    "Sp",
    "Oc",
    "No",
    "Dc",
    "UDc",
    "DDc",
    "TDc",
    "QaDc",
    "QiDc",
    "SxDc",
    "SpDc",
    "Odc",
    "NDc",
    "Vg",
    "Uvg",
    "DVg",
    "TVg",
    "QaVg",
    "QiVg",
    "SxVg",
    "SpVg",
    "Ovg",
    "NVg",
    "Tg",
    "Qd",
    "Qt",
];
/***
 * num 数字
 * threshold 阈值
 * floatLen 小数位
 */
function ShortenNumber(num, threshold = 7, floatLen = 2) {
    const inputStr = String(num);
    const isNegative = inputStr.startsWith("-");
    // 1. 先检查是否是科学计数法（指数 >= 19），直接处理
    const expMatch = inputStr.match(/^-?(\.?\d+\.?\d*)e\+?(\d+)$/i);
    if (expMatch) {
        const exponent = Number(expMatch[2]);
        if (exponent >= 19) {
            const mantissa = Number(expMatch[1]) * (isNegative ? -1 : 1);
            const mantissaRounded = Math.round(mantissa * 10) / 10;
            return [mantissaRounded, `E${exponent}`];
        }
    }
    // 2. 正常处理：展开科学计数法或直接使用
    let numStr = SpreadScientificNotation(num).toString();
    if (isNegative) {
        numStr = numStr.substring(1);
    }
    numStr = numStr.replace(/\.\d*$/, "").replace(/^0+/, "") || "0";
    const len = numStr.length;
    if (len === 0 || numStr === "0") {
        return [0, ""];
    }
    // 3. 如果数字长度对应的指数 >= 19，返回科学计数法
    if (len - 1 >= 19) {
        const mantissa = Number(`${numStr[0]}.${numStr[1] || "0"}`) * (isNegative ? -1 : 1);
        return [mantissa, `E${len - 1}`];
    }
    // 4. 小于阈值，直接返回
    if (len < threshold) {
        return [Number(numStr) * (isNegative ? -1 : 1), ""];
    }
    // 5. 格式化处理
    const formatNumber = (scale) => {
        const maxDigital = Math.floor((len - 1) / scale);
        const floatIndex = len - maxDigital * scale;
        const intPart = numStr.substring(0, floatIndex);
        let formattedStr = intPart;
        if (floatLen > 0 && floatIndex < numStr.length) {
            formattedStr += "." + numStr.substring(floatIndex, floatIndex + floatLen);
        }
        return [formattedStr, maxDigital];
    };
    const sign = isNegative ? -1 : 1;
    if ($.Language() === "schinese") {
        const [formattedStr, maxDigital] = formatNumber(4);
        const unitIndex = Math.min(maxDigital, unitList.length - 1);
        return [Number(formattedStr) * sign, unitList[unitIndex]];
    }
    else {
        const [formattedStr, maxDigital] = formatNumber(3);
        const safeIndex = Math.min(maxDigital, unitList_E.length - 1);
        return [Number(formattedStr) * sign, unitList_E[safeIndex]];
    }
}
function GetShortenNumberStr(num, threshold = 7, floatLen = 2) {
    return ShortenNumber(num, threshold, floatLen).join("");
}
/**
 * 将数字（可能是科学计数法字符串）转换为可比较的数值
 * 用于排序和比较
 * @param num 数字或科学计数法字符串
 * @returns 可比较的数值（对于超大数字，返回 Infinity）
 */
function ToComparableNumber(num) {
    if (typeof num === "number") {
        return num;
    }
    const str = String(num);
    // 检查是否是科学计数法
    const expMatch = str.match(/^-?(\.?\d+\.?\d*)e\+?(\d+)$/i);
    if (expMatch) {
        const mantissa = Number(expMatch[1]);
        const exponent = Number(expMatch[2]);
        // 如果指数太大，返回 Infinity（用于比较）
        if (exponent > 308) {
            return mantissa > 0 ? Infinity : -Infinity;
        }
        return mantissa * Math.pow(10, exponent);
    }
    return Number(str);
}
/**
 * 比较两个数字（支持科学计数法字符串）
 * @param a 数字1
 * @param b 数字2
 * @returns 负数表示 a < b，0 表示 a === b，正数表示 a > b
 */
function CompareNumber(a, b) {
    const numA = ToComparableNumber(a);
    const numB = ToComparableNumber(b);
    return numA - numB;
}
/**
 * 展开科学计数法的数字
 * @param input
 * @returns
 */
function SpreadScientificNotation(input) {
    const inputStr = String(input);
    if (/^-?(\.\d+|\d+\.?\d*)$/.test(inputStr)) {
        return inputStr;
    }
    const expReg = /^-?(\.\d+|\d+\.?\d*)e(\+|\-)(\d+)$/;
    if (!expReg.test(inputStr)) {
        // $.log("SpreadScientificNotation:fail", inputStr);
        return inputStr;
    }
    const sign = inputStr.charAt(0) == "-" ? "-" : "";
    const [numStrRaw, moveDir, dotOffset] = inputStr.replace(expReg, "$1 $2 $3").split(" ");
    let numStr = numStrRaw;
    if (numStr.charAt(0) == ".") {
        numStr = `0${numStr}`;
    }
    let dotIndex = numStr.indexOf(".");
    let intLen;
    let floatLen;
    if (dotIndex == -1) {
        dotIndex = numStr.length;
        intLen = dotIndex;
        floatLen = 0;
    }
    else {
        intLen = dotIndex;
        floatLen = numStr.length - dotIndex - 1;
    }
    const pureNumStr = numStr.replace(".", "");
    let resStr = "";
    if (moveDir == "+") {
        dotIndex += Number(dotOffset);
        if (dotIndex < pureNumStr.length) {
            resStr = `${pureNumStr.substring(0, dotIndex)}.${pureNumStr.substring(dotIndex)}`;
        }
        else {
            const zeroStr = "0".repeat(Number(dotOffset) - floatLen);
            resStr = `${pureNumStr}${zeroStr}`;
        }
    }
    else {
        dotIndex -= Number(dotOffset);
        if (dotIndex > 0) {
            resStr = `${pureNumStr.substring(0, dotIndex)}.${pureNumStr.substring(dotIndex)}`;
        }
        else {
            const zeroStr = "0".repeat(Math.abs(dotIndex));
            resStr = `0.${zeroStr}${pureNumStr}`;
        }
    }
    resStr = resStr.replace(/^0+(?!\.)/, "");
    if (resStr.indexOf(".") > 0) {
        resStr = resStr.replace(/0+$/, "");
    }
    resStr = resStr.replace(/\.$/, "");
    resStr = `${sign}${resStr}`;
    resStr = resStr.replace(/^\s+/, "").replace(/\s+$/, "");
    return resStr;
}
function convertToChinaNum(num) {
    const arr1 = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九"];
    const arr2 = ["", "十", "百", "千", "万", "十", "百", "千", "亿", "十", "百", "千", "万", "十", "百", "千", "亿"]; //可继续追加更高位转换值
    if (!num || isNaN(num)) {
        return "零";
    }
    const english = num.toString().split("");
    let result = "";
    for (let i = 0; i < english.length; i++) {
        const des_i = english.length - 1 - i; //倒序排列设值
        result = arr2[i] + result;
        const arr1_index = english[des_i];
        result = arr1[Number(arr1_index)] + result;
    }
    result = result.replace(/零(千|百|十)/g, "零").replace(/十零/g, "十");
    result = result.replace(/零+/g, "零");
    result = result.replace(/零亿/g, "亿").replace(/零万/g, "万");
    result = result.replace(/亿万/g, "亿");
    result = result.replace(/零+$/, "");
    result = result.replace(/^一十/g, "十");
    return result;
}
/**
 * 格式化字符串
 * @param str
 * @param args
 * @returns
 */
function str4mat(str, ...args) {
    var _a, _b;
    if (!str) {
        return str;
    }
    let replacement;
    if (args.length > 1) {
        replacement = args;
    }
    else {
        replacement = (_a = args[0]) !== null && _a !== void 0 ? _a : {};
        if (typeof replacement != "object") {
            replacement = [replacement];
        }
    }
    (_b = str.match(/\{[\w@#%&]+\}/g)) === null || _b === void 0 ? void 0 : _b.forEach(value => {
        const key = value.slice(1, -1);
        if (replacement[key] != undefined) {
            str = str.replace(value, replacement[key]);
        }
        else {
            //$.log(`str4mat no key ${key} in ${str}`)
        }
    });
    return str;
}
/**
 * 将秒数转成大致时间
 */
function GetRoughTimeStr(msecs) {
    const time = Math.floor((msecs !== null && msecs !== void 0 ? msecs : 0) / 1000);
    let result = 0;
    let suffix = "";
    if (time < 60) {
        result = 1;
        suffix = "分钟";
    }
    else if (time < 3600) {
        result = Math.floor(time / 60);
        suffix = "分钟";
    }
    else if (time < 86400) {
        result = Math.floor(time / 3600);
        suffix = "小时";
    }
    else {
        result = Math.floor(time / 86400);
        suffix = "天";
    }
    return [result, suffix];
}
/**
 * 将 毫秒 转成 时间
 */
function GetAccurateTimeStr(msecs, lang = "cn") {
    const 进制 = [1000, 60, 60, 24, 30, 12, 60];
    const 单位 = {
        cn: ["", "秒", "分", "时", "天", "月", "年", "甲子"],
        en: ["", "sec", "min", "hour", "day", "month", "year", "sixty"],
    };
    const result = [];
    进制.reduce((pro, cur, i) => {
        if (pro == 0) {
            return 0;
        }
        const target = pro % cur;
        if (target != 0) {
            result.push(单位[lang][i], target);
        }
        return (pro - target) / cur;
    }, msecs);
    return result.reverse().join("");
}
// 删除数组中的空值
function compact(array) {
    let resIndex = 0;
    const result = [];
    if (array == null) {
        return result;
    }
    for (const value of array) {
        if (value) {
            result[resIndex++] = value;
        }
    }
    return result;
}
// 物品goodsId数量count数组对象结构返回
function formatStringToGoods(needs) {
    var _a;
    const arr = (_a = needs === null || needs === void 0 ? void 0 : needs.split("&")) !== null && _a !== void 0 ? _a : [];
    const goodsList = [];
    for (const item of arr) {
        const [goodsId, count] = item.split("_");
        goodsList.push({
            goodsId: Number(goodsId),
            num: Number(count),
        });
    }
    return goodsList;
}
function toHHmmss(timeData) {
    // let hours = Math.floor((timeData / 1000 / 60 / 60 % 24));  //时
    // let minutes = Math.floor((timeData / 1000 / 60 % 60));  //分
    // let seconds = Math.floor((timeData / 1000 % 60));  //秒
    const dd = Math.floor(timeData / (1000 * 60 * 60 * 24));
    const hours = Math.floor((timeData / (1000 * 60 * 60)) % 24);
    const minutes = Math.floor((timeData / (1000 * 60)) % 60);
    const seconds = Math.floor((timeData / 1000) % 60);
    // return day+'天'+hours+'小时'+minutes+'分钟'+seconds+'秒'
    const hh = hours < 10 ? "0" + hours : hours;
    const mm = minutes < 10 ? "0" + minutes : minutes;
    const ss = seconds < 10 ? "0" + seconds : seconds;
    return { dd, hh, mm, ss };
}
function formatDate(time, template = "YYYY-MM-DD HH:mm:ss") {
    return dayjs__WEBPACK_IMPORTED_MODULE_0___default()(time).format(template);
}
function formatStringToAttrubuteInfo(attrubute) {
    const item = attrubute.split(" ");
    const param = {
        propertyName: item[0],
        value: Number(item[1]),
        propertyId: -1,
        qua: 1,
    };
    return param;
}
/**进度条 返回一个百分比  一个text*/
function progressNum(num, maxNum) {
    if (isNaN(Number(num)) || isNaN(Number(maxNum))) {
        return [0, ""];
    }
    const pct = num / maxNum;
    if (isNaN(pct) || pct == 0)
        return [0, ""];
    const [newnum, numunit] = ShortenNumber(num);
    const [newmaxnum, maxnumunit] = ShortenNumber(maxNum);
    return [Number(pct), `${parseFloat(newnum.toFixed(1))}${numunit}/${parseFloat(newmaxnum.toFixed(1))}${maxnumunit}`];
}


/***/ },

/***/ "./commonLib/utils/window_utils.ts"
/*!*****************************************!*\
  !*** ./commonLib/utils/window_utils.ts ***!
  \*****************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   OpenPopup: () => (/* binding */ OpenPopup)
/* harmony export */ });
/* unused harmony exports ToggleWindows, ToggleSubPanel */
/* harmony import */ var _modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../modules/evt/local_event_utils */ "./commonLib/modules/evt/local_event_utils.ts");
/**
 * 窗口相关工具方法
 */

// 开关窗口
function ToggleWindows(name, open, extraData) {
    // GameUI.panelAgent.ToggleTopPanel(name, open, extraData);
    (0,_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__.emitLocalEvent)("toggle_window", { name, open: open !== null && open !== void 0 ? open : false, extraData });
}
/**
 *
 * @param id popup 名
 * @param data
 */
function OpenPopup(id, data) {
    (0,_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__.emitLocalEvent)("popup_window", { type: id, payload: data });
}
// /**
//  * 开关二级面板
//  * @param name
//  * @param open
//  * @param extraData
//  */
function ToggleSubPanel(name, open, extraData) {
    Game.UpdaterPool.CallLaterFrame(() => {
        (0,_modules_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_0__.emitLocalEvent)("toggle_sub_panel", { name, open: open !== null && open !== void 0 ? open : false, extraData });
    });
}


/***/ },

/***/ "./def/order_def.ts"
/*!**************************!*\
  !*** ./def/order_def.ts ***!
  \**************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   CashPayType: () => (/* binding */ CashPayType)
/* harmony export */ });
var CashPayType;
(function (CashPayType) {
    CashPayType[CashPayType["ALIPAY"] = 1000] = "ALIPAY";
    CashPayType[CashPayType["WECHATPAY"] = 2000] = "WECHATPAY";
    CashPayType[CashPayType["PAYMENTWALL"] = 6000] = "PAYMENTWALL";
})(CashPayType || (CashPayType = {}));


/***/ },

/***/ "./def/sounds_def.ts"
/*!***************************!*\
  !*** ./def/sounds_def.ts ***!
  \***************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   EmitUiSound: () => (/* binding */ EmitUiSound),
/* harmony export */   UiSounds: () => (/* binding */ UiSounds)
/* harmony export */ });
var UiSounds;
(function (UiSounds) {
    UiSounds["ui_store_common"] = "ui.store_common";
    /**页签导航点击*/
    UiSounds["ui_settings_open"] = "ui.settings_open";
    UiSounds["ui_contract_complete"] = "ui.contract_complete";
    UiSounds["ui_contract_assign"] = "ui.contract_assign";
    UiSounds["ui_contract_fail"] = "ui.contract_fail";
    UiSounds["ItemStormcrafterLightning"] = "Item.Stormcrafter.Lightning";
    // browser_click_common = "ui.browser_click_common",
    /**常规按钮点击*/
    UiSounds["ui_generic_button_click"] = "ui_generic_button_click";
    /**常规2*/
    UiSounds["ButtonClick"] = "General.ButtonClick";
    /**常规3*/
    UiSounds["ButtonClickRelease"] = "General.ButtonClickRelease";
    /**选择密藏*/
    UiSounds["Quickbuy_Available"] = "Quickbuy.Available";
    /**刷新密藏*/
    UiSounds["General_CompendiumLevelUp"] = "General.CompendiumLevelUp";
    /**购买道具、物品不够钱的提示音*/
    UiSounds["CastFail_InvalidTarget_Item"] = "General.CastFail_InvalidTarget_Item";
    /**出售技能音效*/
    UiSounds["General_Sell"] = "General.Sell";
    /**购买道具音效*/
    UiSounds["General_Buy"] = "General.Buy";
    /**技能品质1-4 升至满级*/
    UiSounds["underdraft_levelup_1"] = "underdraft_levelup_1";
    /**技能品质5 升至满级*/
    UiSounds["underdraft_levelup_2"] = "underdraft_levelup_2";
    /**左侧弹出信息面板提示 */
    UiSounds["underdraft_drafted"] = "underdraft_drafted";
    /**交换技能位置 */
    UiSounds["ui_treasure_count"] = "ui.treasure_count";
    /**选择难度词条 */
    UiSounds["ui_keybind_set"] = "ui.keybind_set";
    /**选择初始角色面板点击角色 和 角色初始技能 ||
     * 选择难度面板 点击难度 ||
     * 局内商店页面 点击主要、次要 ||
     * 收集页面点击任意收集品  ||
     * */
    /**选择难度面板 切换章节难度 一级面板打开音效 */
    UiSounds["ui_settings_multi"] = "ui_settings_multi";
    /**商店页面 锁住和解锁 道具、技能 */
    UiSounds["ui_treasure_unlock_wav"] = "ui.treasure_unlock.wav";
    /** 装备任务裤衩 */
    UiSounds["ui_inv_equip_metalsmall"] = "ui.inv_equip_metalsmall";
    /** 区服，难度选择确认 */
    UiSounds["weekend_tournament_team_icon_stamp"] = "ui.weekend_tournament_team_icon_stamp";
    //三选一
    UiSounds["ui_trophy_new"] = "ui.trophy_new";
    /**取消*/
    UiSounds["ui_pick_repick"] = "ui.pick_repick";
    /**点击任意宠物，图鉴*/
    UiSounds["ui_inv_sort"] = "ui.inv_sort";
    /**宠物图鉴升星*/
    UiSounds["ui_report_positive"] = "ui.report_positive";
    /*主副宠物*/
    UiSounds["ui_inv_equip_metalheavy"] = "ui.inv_equip_metalheavy";
    //厄里斯魔镜
    UiSounds["ui_trophy_levelup"] = "ui.trophy_levelup";
    UiSounds["ui_treasure_01"] = "ui.treasure_01";
    UiSounds["Item_Pavise_Target"] = "Item.Pavise.Target";
    UiSounds["Item_GreevilWhistle_Return"] = "Item.GreevilWhistle.Return";
    UiSounds["Item_Brooch_Cast"] = "Item.Brooch.Cast";
    UiSounds["ui_treasure_reveal"] = "ui.treasure_reveal";
    UiSounds["compendium_points"] = "compendium_points";
    UiSounds["ui_set_guard"] = "ui_set_guard";
    UiSounds["ui_common_click_1"] = "ui_common_click_1";
    UiSounds["ui_tactics_random"] = "ui_tactics_random";
    UiSounds["ui_common_reward"] = "ui_common_reward";
    UiSounds["ui_common_click_0"] = "ui_common_click_0";
    UiSounds["underdraft_reroll"] = "underdraft_reroll";
})(UiSounds || (UiSounds = {}));
function EmitUiSound(soundName) {
    Game.EmitSound(soundName);
}


/***/ },

/***/ "./shared/client_shared_declarations.ts"
/*!**********************************************!*\
  !*** ./shared/client_shared_declarations.ts ***!
  \**********************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   CashTypeEnum: () => (/* binding */ CashTypeEnum)
/* harmony export */ });
/* unused harmony exports CustomBlessTags, CustomHeroTags, BlessQuality, BlessDrawReason, BlessCfgType, CustomAttr, ErrorTipCode, ErrorPanelCode, GameFlowAction, GameFlowState, CustomItem, DotaAbility, DotaItem, CustomAbility, Dota2Modifier, NeutralItem, DotaHero, NeutralEnhancement, PseudoRandom, TeamShuffleVoteValue, TeamShufflePhase, CustomRuneType, AbilityAmpType, PurgeType, TriggerAbilityType, URLs, GoodsTypeEnum, ServerErrorCodeEnum, SettlementTitle, GameType */
/**
 * 这个文件由后端shared文件夹内的声明编译而成。仅用于使用。查看可到game目录下的shared文件夹内查看
 */
var CustomBlessTags;
(function (CustomBlessTags) {
    /** 近战英雄 */
    CustomBlessTags["melee"] = "melee";
    /** 远程英雄 */
    CustomBlessTags["range"] = "range";
    /** 触发类福佑 */
    CustomBlessTags["b_trg"] = "b_trg";
    /** 全局唯一 */
    CustomBlessTags["uni_glb"] = "uni_glb";
    /** 队伍唯一 */
    CustomBlessTags["uni_team"] = "uni_team";
    /** 全才英雄 */
    CustomBlessTags["uni"] = "uni";
    /** 力量英雄 */
    CustomBlessTags["str"] = "str";
    /** 智力英雄 */
    CustomBlessTags["int"] = "int";
    /** 敏捷英雄 */
    CustomBlessTags["agi"] = "agi";
    /** 1肉 */
    CustomBlessTags["rou"] = "1r";
    /** 2物 */
    CustomBlessTags["wuli"] = "2w";
    /** 3刺 */
    CustomBlessTags["cike"] = "3c";
    /** 4法 */
    CustomBlessTags["fashi"] = "4f";
    /** 仅能通过抽取获得 */
    CustomBlessTags["only_draw_on_level"] = "only_draw_on_level";
    /** 随机类福佑 */
    CustomBlessTags["rnd"] = "rnd";
})(CustomBlessTags || (CustomBlessTags = {}));
var CustomHeroTags;
(function (CustomHeroTags) {
    /** 近战英雄 */
    CustomHeroTags["melee"] = "melee";
    /** 远程英雄 */
    CustomHeroTags["range"] = "range";
    /** 全才英雄 */
    CustomHeroTags["uni"] = "uni";
    /** 力量英雄 */
    CustomHeroTags["str"] = "str";
    /** 智力英雄 */
    CustomHeroTags["int"] = "int";
    /** 敏捷英雄 */
    CustomHeroTags["agi"] = "agi";
    /** 1肉 */
    CustomHeroTags["rou"] = "1r";
    /** 2物 */
    CustomHeroTags["wuli"] = "2w";
    /** 3刺 */
    CustomHeroTags["cike"] = "3c";
    /** 4法 */
    CustomHeroTags["fashi"] = "4f";
})(CustomHeroTags || (CustomHeroTags = {}));
var BlessQuality;
(function (BlessQuality) {
    /** 普通 */
    BlessQuality[BlessQuality["R"] = 1] = "R";
    /** 稀有 */
    BlessQuality[BlessQuality["SR"] = 2] = "SR";
    /** 超稀有 */
    BlessQuality[BlessQuality["SSR"] = 3] = "SSR";
})(BlessQuality || (BlessQuality = {}));
/** 抽取福佑3选1原因枚举 */
var BlessDrawReason;
(function (BlessDrawReason) {
    BlessDrawReason[BlessDrawReason["level_1"] = 1] = "level_1";
    BlessDrawReason[BlessDrawReason["level_5"] = 5] = "level_5";
    BlessDrawReason[BlessDrawReason["level_10"] = 10] = "level_10";
    BlessDrawReason[BlessDrawReason["level_15"] = 15] = "level_15";
    BlessDrawReason[BlessDrawReason["level_20"] = 20] = "level_20";
    BlessDrawReason[BlessDrawReason["level_25"] = 25] = "level_25";
    BlessDrawReason[BlessDrawReason["level_30"] = 30] = "level_30";
    /** 商店物品 福佑礼盒 蓝 */
    BlessDrawReason[BlessDrawReason["item_bless_box_1"] = 1001] = "item_bless_box_1";
    /** 商店物品 福佑礼盒 紫 */
    BlessDrawReason[BlessDrawReason["item_bless_box_2"] = 1002] = "item_bless_box_2";
    /** 商店物品 福佑礼盒 橙 */
    BlessDrawReason[BlessDrawReason["item_bless_box_3"] = 1003] = "item_bless_box_3";
})(BlessDrawReason || (BlessDrawReason = {}));
var BlessCfgType;
(function (BlessCfgType) {
    /** 享受技能增强 */
    BlessCfgType["ability_amplify"] = "amp";
    /** 享受技能吸血 */
    BlessCfgType["ability_life_steal"] = "als";
    /** 增益效果是否可驱散 */
    BlessCfgType["buff_purgeable"] = "bp";
    /** 减益效果是否可驱散 */
    BlessCfgType["debuff_purgeable"] = "dbp";
})(BlessCfgType || (BlessCfgType = {}));
/** 要同步给客户端，不用数字 */
var CustomAttr;
(function (CustomAttr) {
    /** 最大生命值 */
    CustomAttr["HP_MAX"] = "sm";
    /** 最大生命值百分比 */
    CustomAttr["HP_MAX_PCT"] = "smI";
    /** 最大魔法值 */
    CustomAttr["MP_MAX"] = "mf";
    /** 最大魔法值百分比 */
    CustomAttr["MP_MAX_PCT"] = "mfI";
    /** 基础攻击力（白字） */
    CustomAttr["BASE_ATTACK"] = "gjb";
    /** 额外攻击力（绿字） */
    CustomAttr["PRE_ATTACK"] = "gjl";
    /** 基础攻击力百分比 */
    CustomAttr["BASE_ATTACK_PCT"] = "gjbI";
    /** 总攻击力百分比 */
    CustomAttr["TOTAL_ATTACK_PCT"] = "gjI";
    /** 技能增强（百分比 加算） */
    CustomAttr["SPELL_AMPLIFY"] = "jnzq";
    /** 护甲 */
    CustomAttr["ARMOR"] = "hj";
    /** 魔抗（百分比、乘算） */
    CustomAttr["MAGIC_RESISTANCE"] = "mk";
    /** 吸血 */
    CustomAttr["LIFESTEAL"] = "xx";
    /** 技能吸血 */
    CustomAttr["SPELL_LIFESTEAL"] = "jnxx";
    /** 全能吸血 */
    CustomAttr["ALL_LIFESTEAL"] = "qnxx";
    /** 对英雄吸血 */
    CustomAttr["HERO_LIFESTEAL"] = "yxxx";
    /** 对英雄技能吸血 */
    CustomAttr["HERO_SPELL_LIFESTEAL"] = "yxjnxx";
    /** 对英雄全能吸血 */
    CustomAttr["HERO_ALL_LIFESTEAL"] = "yxqnxx";
    /** 攻速百分比 */
    CustomAttr["ATTACK_SPEED_PCT"] = "gsI";
    /** 攻速 */
    CustomAttr["ATTACK_SPEED"] = "gs";
    /** 冷却时间减少(百分比 乘算) */
    CustomAttr["COOLDOWN_PCT"] = "lq";
    /** 移速 */
    CustomAttr["MOVE_SPEED"] = "ys";
    /** 移速百分比 */
    CustomAttr["MOVE_SPEED_PCT"] = "ysI";
    /** 攻击距离 */
    CustomAttr["ATTACK_RANGE"] = "gjjl";
    /** 闪避(百分比 乘算) */
    CustomAttr["EVASION_PCT"] = "sb";
    /** 施法距离 */
    CustomAttr["CAST_RANGE"] = "sfjl";
    /** 技能范围 */
    CustomAttr["AOE_RADIUS"] = "jnfw";
    /** 技能范围百分比 */
    CustomAttr["AOE_RADIUS_PCT"] = "jnfwI";
    /** 力量 */
    CustomAttr["STRENGTH"] = "ll";
    /** 力量百分比 */
    // STRENGTH_PCT = "llI",
    /** 敏捷 */
    CustomAttr["AGILITY"] = "mj";
    /** 敏捷百分比 */
    // AGILITY_PCT = "mjI",
    /** 智力 */
    CustomAttr["INTELLECT"] = "zl";
    /** 智力百分比 */
    // INTELLECT_PCT = "zlI",
    /** 主属性 */
    CustomAttr["MAIN_STATS"] = "zsx";
    /** 主属性百分比 */
    // MAIN_STATS_PCT = "zsxI",
    /** 全属性 */
    CustomAttr["ALL_STATS"] = "qss";
    /** 全属性百分比 */
    // ALL_STATS_PCT = "qssI",
    // TODO 用负值状态抗性来做？GetModifierStatusResistanceCaster
    /** 负面状态持续时间(百分比) */
    CustomAttr["DEBUFF_DURATION_PCT"] = "fm";
    /** 状态抗性(百分比 乘算) */
    CustomAttr["STATUS_RESISTANCE_PCT"] = "ztkx";
    /** 基础攻击间隔(取最高的覆盖) */
    CustomAttr["BASE_ATTACK_TIME"] = "gjjg";
    /** 每秒生命恢复常量 */
    CustomAttr["HP_REGEN_CONSTANT"] = "smhf";
    /** 每秒最大生命值回复百分比 */
    CustomAttr["HP_REGEN_PCT"] = "smhfI";
    /** 生命回复增强百分比 */
    CustomAttr["HP_REGEN_AMPLIFY_PCT"] = "smhfzqI";
    /** 魔法恢复常量 */
    CustomAttr["MP_REGEN_CONSTANT"] = "mfhf";
    /** 魔法恢复增强百分比 */
    CustomAttr["MP_REGEN_AMPLIFY_PCT"] = "mfhfzqI";
    /** 承受伤害百分比 */
    CustomAttr["TAKE_DAMAGE_PCT"] = "csshI";
    /** 总伤害提升百分比 */
    CustomAttr["TOTAL_DAMAGE_PCT"] = "shI";
    /** 福佑触发伤害提升百分比 */
    CustomAttr["TRIGGER_BLESS_DAMAGE_PCT"] = "cffyshI";
    /** 道具触发伤害提升百分比 */
    CustomAttr["TRIGGER_ITEM_DAMAGE_PCT"] = "cfdjshI";
    /** 复活时间减少 */
    CustomAttr["RESPAWN_TIME_REDUCE"] = "fhsj";
    /** 复活时间减少百分比 */
    CustomAttr["RESPAWN_TIME_REDUCE_PCT"] = "fhsjI";
    /** 模型大小百分比修改值 */
    CustomAttr["MODEL_SCALE_PCT"] = "mxI";
    /** 会心攻击倍率 */
    CustomAttr["STRIKE_CRITICAL_PCT"] = "hxgjbl";
    /** 会心攻击概率 */
    CustomAttr["STRIKE_CRITICAL_CHANCE"] = "hxgjgl";
    /** 平衡性 总承受伤害修正百分比 承受伤害增加/降低 最终伤害除区 */
    CustomAttr["BALANCE_TOTAL_TAKE_DAMAGE_PCT"] = "phcs";
    /** 平衡性 总造成伤害修正百分比 造成伤害增加/降低 最终伤害乘区 */
    CustomAttr["BALANCE_TOTAL_APPLY_DAMAGE_PCT"] = "phzs";
    /** 巨人刚戒层数倍率 */
    CustomAttr["GIANT_RING_LAYER_PCT"] = "gangpct";
})(CustomAttr || (CustomAttr = {}));
// #region 提示
/** 错误提示编码 */
var ErrorTipCode;
(function (ErrorTipCode) {
    /** 断线重连倒计时 */
    ErrorTipCode["COUNT_DOWN_MIN_5"] = "count_down_min_5";
    ErrorTipCode["COUNT_DOWN_MIN_4"] = "count_down_min_4";
    ErrorTipCode["COUNT_DOWN_MIN_3"] = "count_down_min_3";
    ErrorTipCode["COUNT_DOWN_MIN_2"] = "count_down_min_2";
    ErrorTipCode["COUNT_DOWN_MIN_1"] = "count_down_min_1";
    ErrorTipCode["COUNT_DOWN_MIN_0"] = "count_down_min_0";
    /** 测试错误 */
    ErrorTipCode["TEST_ERROR_TIP"] = "error_tip_test_error_tip";
    /** 禁止对目标英雄施法 */
    ErrorTipCode["dota_hud_error_cant_cast_on_considered_hero"] = "dota_hud_error_cant_cast_on_considered_hero";
    /** 中路模式 禁止购买物品 */
    ErrorTipCode["mid_mode_can_not_purchase"] = "mid_mode_can_not_purchase";
    /** 禁止释放终极技能 */
    ErrorTipCode["can_not_cast_ultimate_ability"] = "can_not_cast_ultimate_ability";
    /** 禁止选择福佑 */
    ErrorTipCode["forbid_choose_bless"] = "forbid_choose_bless";
    /** 禁止重铸福佑 */
    ErrorTipCode["forbid_recraft_bless"] = "forbid_recraft_bless";
    /** 该福佑无法重铸 */
    ErrorTipCode["cannot_recraft_bless"] = "cannot_recraft_bless";
    /** 无法重铸，数值已满 */
    ErrorTipCode["cannot_recraft_bless_value_max"] = "cannot_recraft_bless_value_max";
    /** 调试禁止重铸福佑 */
    ErrorTipCode["debug_forbid_recraft_bless"] = "debug_forbid_recraft_bless";
    /** 调试禁止重roll福佑 */
    ErrorTipCode["debug_forbid_reroll_bless"] = "debug_forbid_reroll_bless";
    /** 道具不足，不能重roll福佑 */
    ErrorTipCode["cant_reroll_bless"] = "cant_reroll_bless";
    /** 道具不足，不能重铸福佑 */
    ErrorTipCode["cant_recraft_bless"] = "cant_recraft_bless";
    /** 道具不足，不能刷新英雄 */
    ErrorTipCode["cant_refresh_hero"] = "cant_refresh_hero";
    /** 请先选择英雄 */
    ErrorTipCode["please_select_hero"] = "please_select_hero";
    /** 已达到最大刷新次数 */
    ErrorTipCode["max_refresh_count"] = "max_refresh_count";
    /** 无法从英雄池中选择英雄 */
    ErrorTipCode["cant_select_hero"] = "cant_select_hero";
    /** 英雄不在总英雄池中 */
    ErrorTipCode["hero_not_in_pool"] = "hero_not_in_pool";
    /** 已选择英雄，无法刷新 */
    ErrorTipCode["already_selected_hero"] = "already_selected_hero";
    /** 索引无效 */
    ErrorTipCode["invalid_index"] = "invalid_index";
    /** 玩家英雄池大小不正确 */
    ErrorTipCode["player_hero_pool_size_incorrect"] = "player_hero_pool_size_incorrect";
    /** 队伍英雄池为空 */
    ErrorTipCode["team_hero_pool_empty"] = "team_hero_pool_empty";
    /** 总英雄池为空 */
    ErrorTipCode["total_hero_pool_empty"] = "total_hero_pool_empty";
    /** 该英雄已被其他玩家选择 */
    ErrorTipCode["hero_already_selected"] = "hero_already_selected";
    /** 等待接口返回数据中 */
    ErrorTipCode["wait_http_return"] = "wait_http_return";
    /** 点击过快 */
    ErrorTipCode["click_too_fast"] = "click_too_fast";
    /** 当前不在选人阶段 */
    ErrorTipCode["not_in_bp_phase"] = "not_in_bp_phase";
    /** 物品已使用 */
    ErrorTipCode["item_already_used"] = "item_already_used";
    /** 祝福10079 输入慢了 */
    ErrorTipCode["bless_10079_not_kill_recently"] = "bless_10079_not_kill_recently";
    /** 当前有正在选择的福佑池 */
    ErrorTipCode["has_chosing_bless_pool"] = "has_chosing_bless_pool";
    /** 洗牌阶段 黑店分布为 442 / 433 / 333 或 >5人黑，判定为无效局 */
    ErrorTipCode["team_shuffle_result_invalid"] = "team_shuffle_result_invalid";
    /** 英雄死亡，请稍后再试！ */
    ErrorTipCode["HERO_IS_DEAD"] = "hero_is_dead";
})(ErrorTipCode || (ErrorTipCode = {}));
// #region 面板
/** 错误面板编码 */
var ErrorPanelCode;
(function (ErrorPanelCode) {
    /** 测试错误面板 */
    ErrorPanelCode["TEST_ERROR_PANEL"] = "error_panel_test_error_panel";
})(ErrorPanelCode || (ErrorPanelCode = {}));
var GameFlowAction;
(function (GameFlowAction) {
    /** 无阶段 -> 加载阶段 */
    GameFlowAction["NoneToLoading"] = "NoneToLoading";
    /** 加载阶段 -> 洗牌阶段 */
    GameFlowAction["LoadingToShuffle"] = "LoadingToShuffle";
    /** 洗牌阶段 -> 比赛开始阶段 */
    GameFlowAction["ShuffleToMatchStart"] = "ShuffleToMatchStart";
    /** 比赛开始阶段 -> BP阶段 */
    GameFlowAction["MatchStartToBanPick"] = "MatchStartToBanPick";
    /** BP阶段 -> 生成英雄阶段 */
    GameFlowAction["BanPickToSpawnHero"] = "BanPickToSpawnHero";
    /** 生成英雄阶段 -> 策略阶段 */
    GameFlowAction["SpawnHeroToStrategy"] = "SpawnHeroToStrategy";
    /** 策略阶段 -> 游戏前阶段 */
    GameFlowAction["StrategyToPreGame"] = "StrategyToPreGame";
    /** 游戏前阶段 -> 游戏中阶段 */
    GameFlowAction["PreGameToGame"] = "PreGameToGame";
    /** 任何阶段 -> 结算阶段 */
    GameFlowAction["AnyToSettle"] = "AnyToSettle";
    /** 任何阶段 -> 游戏结束阶段 */
    GameFlowAction["AnyToOver"] = "AnyToOver";
})(GameFlowAction || (GameFlowAction = {}));
var GameFlowState;
(function (GameFlowState) {
    /** 无阶段 */
    GameFlowState[GameFlowState["None"] = 1] = "None";
    /** 加载服务器数据阶段 */
    GameFlowState[GameFlowState["Loading"] = 2] = "Loading";
    /** 赛前洗牌阶段 */
    GameFlowState[GameFlowState["Shuffle"] = 3] = "Shuffle";
    /** 比赛开始阶段 */
    GameFlowState[GameFlowState["MatchStart"] = 4] = "MatchStart";
    /** BP阶段 */
    GameFlowState[GameFlowState["BanPick"] = 5] = "BanPick";
    /** 生成英雄阶段 */
    GameFlowState[GameFlowState["SpawnHero"] = 6] = "SpawnHero";
    /** 策略阶段(选命石/预购装备) */
    GameFlowState[GameFlowState["Strategy"] = 7] = "Strategy";
    /** 游戏前阶段 */
    GameFlowState[GameFlowState["PreGame"] = 8] = "PreGame";
    /** 游戏中阶段 */
    GameFlowState[GameFlowState["Game"] = 9] = "Game";
    /** 结算阶段 */
    GameFlowState[GameFlowState["Settle"] = 10] = "Settle";
    /** 游戏结束阶段 */
    GameFlowState[GameFlowState["Over"] = 11] = "Over";
})(GameFlowState || (GameFlowState = {}));
var CustomItem;
(function (CustomItem) {
    /** 草木之灵 */
    CustomItem["item_apothesis"] = "item_apothesis";
    /** 炼化之手 */
    CustomItem["item_hand_of_blood"] = "item_hand_of_blood";
    /** 火焰斗篷 */
    CustomItem["item_flame_cloak"] = "item_flame_cloak";
    /** 巨人刚戒 */
    CustomItem["item_super_giant_ring"] = "item_super_giant_ring";
    /** 雷神之锤（伪） */
    CustomItem["item_mjollnir_fake"] = "item_mjollnir_fake";
    /** 经验之书 */
    CustomItem["item_exp_book"] = "item_exp_book";
    /** 定情信物 */
    CustomItem["item_bless_10139"] = "item_bless_10139";
    /** 蓝色福佑礼盒 */
    CustomItem["item_bless_box_1"] = "item_bless_box_1";
    /** 紫色福佑礼盒 */
    CustomItem["item_bless_box_2"] = "item_bless_box_2";
    /** 橙色福佑礼盒 */
    CustomItem["item_bless_box_3"] = "item_bless_box_3";
})(CustomItem || (CustomItem = {}));
/** 补充dota2技能 */
var DotaAbility;
(function (DotaAbility) {
    DotaAbility["ability_capture"] = "ability_capture";
    DotaAbility["abyssal_underlord_portal_warp"] = "abyssal_underlord_portal_warp";
    DotaAbility["twin_gate_portal_warp"] = "twin_gate_portal_warp";
    DotaAbility["ability_lamp_use"] = "ability_lamp_use";
})(DotaAbility || (DotaAbility = {}));
/** 补充dota2道具 */
var DotaItem;
(function (DotaItem) {
    /** 远行鞋2 */
    DotaItem["travel_boots_2"] = "item_travel_boots_2";
})(DotaItem || (DotaItem = {}));
var CustomAbility;
(function (CustomAbility) {
    /** 全局thinker */
    CustomAbility["global_thinker"] = "ability_global_thinker";
    /** 中路模式 - 防御塔魔法恢复光环 */
    CustomAbility["mid_mode_tower_magic_regen_aura"] = "mid_mode_tower_magic_regen_aura";
    /** 中路模式 - 防御塔古代保护 */
    CustomAbility["mid_mode_tower_ancient_protection"] = "mid_mode_tower_ancient_protection";
    /** 中路模式 - 防御塔增强 */
    CustomAbility["mid_mode_tower_amplify"] = "mid_mode_tower_amplify";
    /** 中路模式 - 基地增强 */
    CustomAbility["mid_mode_fort_amplify"] = "mid_mode_fort_amplify";
    /** 福佑 猫猫技能 撤退 */
    CustomAbility["bless_10169_cat_ability_1"] = "bless_10169_cat_ability_1";
    /** 福佑 猫猫技能 集火 */
    CustomAbility["bless_10169_cat_ability_2"] = "bless_10169_cat_ability_2";
    /** 福佑 猫猫技能 保护 */
    CustomAbility["bless_10169_cat_ability_3"] = "bless_10169_cat_ability_3";
})(CustomAbility || (CustomAbility = {}));
// 记录一些常用的dota2的modifier
var Dota2Modifier;
(function (Dota2Modifier) {
    /** 神杖buff */
    Dota2Modifier["scepter"] = "modifier_item_ultimate_scepter";
    /** 神杖buff 福佑 */
    Dota2Modifier["scepter_consumed"] = "modifier_item_ultimate_scepter_consumed";
    /** 神杖buff 炼金 */
    Dota2Modifier["scepter_consumed_alchemist"] = "modifier_item_ultimate_scepter_consumed_alchemist";
    /** 魔晶 */
    Dota2Modifier["shard"] = "modifier_item_aghanims_shard";
    /** 幻象 */
    Dota2Modifier["illusion"] = "modifier_illusion";
    /** 猴子猴孙脱离隐藏状态时会获得的buff */
    Dota2Modifier["monkey_king_soldier_in_position"] = "modifier_monkey_king_fur_army_soldier_in_position";
    /** 猴子猴孙进入隐藏状态 */
    Dota2Modifier["monkey_king_soldier_hide"] = "modifier_monkey_king_fur_army_soldier_hidden";
    /** 卡尔球的自带增益buff */
    Dota2Modifier["invoke_bonus"] = "modifier_invoke_bonuses";
    /** 泉水无敌 */
    Dota2Modifier["fountain_invulnerability"] = "modifier_fountain_invulnerability";
    /** 小小 - 长大 */
    Dota2Modifier["tiny_grow"] = "modifier_tiny_grow";
    /** 风行者 - 一路顺风 */
    Dota2Modifier["windrunner_tailwind"] = "modifier_windrunner_tailwind_intrinsic";
    /** 否决 - 负面效果 */
    Dota2Modifier["item_nullifier_mute"] = "modifier_item_nullifier_mute";
    /** 鱼叉 拉扯 */
    Dota2Modifier["item_harpoon_pull"] = "modifier_item_harpoon_pull";
    /** 击退 */
    Dota2Modifier["knockback"] = "modifier_knockback";
    /** 眩晕 */
    Dota2Modifier["stunned"] = "modifier_stunned";
    /** 击晕 */
    Dota2Modifier["bashed"] = "modifier_bashed";
    /** 临时攻击速度提升（连击刀） */
    Dota2Modifier["temp_attack_speed"] = "modifier_temp_attack_speed_boosted";
    /** 剑刃风暴 */
    Dota2Modifier["juggernaut_blade_fury"] = "modifier_juggernaut_blade_fury";
    /** 影魔 - 支配死灵 */
    Dota2Modifier["nevermore_necromastery"] = "modifier_nevermore_necromastery";
    /** 混沌骑士 - 实相裂隙 */
    Dota2Modifier["chaos_knight_reality_rift"] = "modifier_chaos_knight_reality_rift_debuff";
    /** 暗夜魔王 - 虚空 */
    Dota2Modifier["night_stalker_void"] = "modifier_night_stalker_void";
    /** 莉娜 - 炽魂 */
    Dota2Modifier["lina_fiery_soul"] = "modifier_lina_fiery_soul";
    /** 人马 - 先天开足马力 */
    Dota2Modifier["centaur_horsepower"] = "modifier_centaur_horsepower";
})(Dota2Modifier || (Dota2Modifier = {}));
(function (DotaItem) {
    /** 不朽之守护 */
    DotaItem["aegis"] = "item_aegis";
})(DotaItem || (DotaItem = {}));
var NeutralItem;
(function (NeutralItem) {
    /** 一包狂石 */
    NeutralItem["madstone_bundle"] = "item_madstone_bundle";
})(NeutralItem || (NeutralItem = {}));
/** Dota原生技能 */
(function (DotaAbility) {
    /** 法力损毁 */
    DotaAbility["antimage_mana_break"] = "antimage_mana_break";
    /** 绝人之路 */
    DotaAbility["antimage_persectur"] = "antimage_persectur";
    /** 闪烁 */
    DotaAbility["antimage_blink"] = "antimage_blink";
    /** 法术反制 */
    DotaAbility["antimage_counterspell"] = "antimage_counterspell";
    /** 法力虚空 */
    DotaAbility["antimage_mana_void"] = "antimage_mana_void";
    /** 暗影突袭 */
    DotaAbility["queenofpain_shadow_strike"] = "queenofpain_shadow_strike";
    /** 闪烁 */
    DotaAbility["queenofpain_blink"] = "queenofpain_blink";
    /** 痛苦尖叫 */
    DotaAbility["queenofpain_scream_of_pain"] = "queenofpain_scream_of_pain";
    /** 超声冲击波 */
    DotaAbility["queenofpain_sonic_wave"] = "queenofpain_sonic_wave";
    /** 受虐成狂 (命石技能) */
    DotaAbility["queenofpain_masochist"] = "queenofpain_masochist";
    /** 魅魔 (命石技能) */
    DotaAbility["queenofpain_succubus"] = "queenofpain_succubus";
    /** 束手束脚 (命石技能) */
    DotaAbility["queenofpain_bondage"] = "queenofpain_bondage";
    /** 龙破斩 */
    DotaAbility["lina_dragon_slave"] = "lina_dragon_slave";
    /** 光击阵 */
    DotaAbility["lina_light_strike_array"] = "lina_light_strike_array";
    /** 炽魂 */
    DotaAbility["lina_fiery_soul"] = "lina_fiery_soul";
    /** 神灭斩 */
    DotaAbility["lina_laguna_blade"] = "lina_laguna_blade";
    /** 腾焰斗篷 */
    DotaAbility["lina_flame_cloak"] = "lina_flame_cloak";
    /** 慢热 (命石技能) */
    DotaAbility["lina_slow_burn"] = "lina_slow_burn";
    /** 月神之箭 */
    DotaAbility["mirana_arrow"] = "mirana_arrow";
    /** 月之暗面 (命石技能) */
    DotaAbility["mirana_invis"] = "mirana_invis";
    /** 跳跃 */
    DotaAbility["mirana_leap"] = "mirana_leap";
    /** 群星风暴 */
    DotaAbility["mirana_starfall"] = "mirana_starfall";
    /** 天界箭袋 */
    DotaAbility["mirana_celestial_quiver"] = "mirana_celestial_quiver";
    /** 太阳金辉 (命石技能) */
    DotaAbility["mirana_solar_flare"] = "mirana_solar_flare";
    /** 狂暴 (命石技能) */
    DotaAbility["life_stealer_rage"] = "life_stealer_rage";
    /** 肆意狂怒 (命石技能) */
    DotaAbility["life_stealer_unfettered"] = "life_stealer_unfettered";
    /** 盛宴 */
    DotaAbility["life_stealer_feast"] = "life_stealer_feast";
    /** 尸鬼狂怒 */
    DotaAbility["life_stealer_ghoul_frenzy"] = "life_stealer_ghoul_frenzy";
    /** 撕裂伤口 */
    DotaAbility["life_stealer_open_wounds"] = "life_stealer_open_wounds";
    /** 感染 */
    DotaAbility["life_stealer_infest"] = "life_stealer_infest";
    /** 吞灭 */
    DotaAbility["life_stealer_consume"] = "life_stealer_consume";
    /** 发芽 */
    DotaAbility["furion_sprout"] = "furion_sprout";
    /** 传送 */
    DotaAbility["furion_teleportation"] = "furion_teleportation";
    /** 自然的呼唤 */
    DotaAbility["furion_force_of_nature"] = "furion_force_of_nature";
    /** 青森诅咒 */
    DotaAbility["furion_curse_of_the_forest"] = "furion_curse_of_the_forest";
    /** 自然之怒 */
    DotaAbility["furion_wrath_of_nature"] = "furion_wrath_of_nature";
    /** 丛林之魂 */
    DotaAbility["furion_spirit_of_the_forest"] = "furion_spirit_of_the_forest";
    /** 自然先富 (命石技能) */
    DotaAbility["furion_natures_profit"] = "furion_natures_profit";
    /** 集中火力 */
    DotaAbility["windrunner_focusfire"] = "windrunner_focusfire";
    /** 集中火力取消 */
    DotaAbility["windrunner_focusfire_cancel"] = "windrunner_focusfire_cancel";
    /** 强力击 */
    DotaAbility["windrunner_powershot"] = "windrunner_powershot";
    /** 束缚击 */
    DotaAbility["windrunner_shackleshot"] = "windrunner_shackleshot";
    /** 风行 */
    DotaAbility["windrunner_windrun"] = "windrunner_windrun";
    /** 狂风之力 */
    DotaAbility["windrunner_gale_force"] = "windrunner_gale_force";
    /** 一路顺风 */
    DotaAbility["windrunner_tailwind"] = "windrunner_tailwind";
    /** 裂地尖刺 */
    DotaAbility["lion_impale"] = "lion_impale";
    /** 妖术 */
    DotaAbility["lion_voodoo"] = "lion_voodoo";
    /** 法力吸取 */
    DotaAbility["lion_mana_drain"] = "lion_mana_drain";
    /** 死亡之指 */
    DotaAbility["lion_finger_of_death"] = "lion_finger_of_death";
    /** 下地狱再上来 */
    DotaAbility["lion_to_hell_and_back"] = "lion_to_hell_and_back";
    /** 魔法箭 */
    DotaAbility["vengefulspirit_magic_missile"] = "vengefulspirit_magic_missile";
    /** 恐怖波动 */
    DotaAbility["vengefulspirit_wave_of_terror"] = "vengefulspirit_wave_of_terror";
    /** 复仇光环 */
    DotaAbility["vengefulspirit_command_aura"] = "vengefulspirit_command_aura";
    /** 移形换位 */
    DotaAbility["vengefulspirit_nether_swap"] = "vengefulspirit_nether_swap";
    /** 灵魂打击 (命石技能) */
    DotaAbility["vengefulspirit_soul_strike"] = "vengefulspirit_soul_strike";
    /** 恶有恶报 */
    DotaAbility["vengefulspirit_retribution"] = "vengefulspirit_retribution";
    /** 麻痹药剂 */
    DotaAbility["witch_doctor_paralyzing_cask"] = "witch_doctor_paralyzing_cask";
    /** 巫毒疗法 */
    DotaAbility["witch_doctor_voodoo_restoration"] = "witch_doctor_voodoo_restoration";
    /** 巫蛊咒术 */
    DotaAbility["witch_doctor_maledict"] = "witch_doctor_maledict";
    /** 死亡守卫 */
    DotaAbility["witch_doctor_death_ward"] = "witch_doctor_death_ward";
    /** 巫毒变身术 */
    DotaAbility["witch_doctor_voodoo_switcheroo"] = "witch_doctor_voodoo_switcheroo";
    /** 驱邪护符 */
    DotaAbility["witch_doctor_gris_gris"] = "witch_doctor_gris_gris";
    /** 撕裂大地 */
    DotaAbility["leshrac_split_earth"] = "leshrac_split_earth";
    /** 恶魔敕令 */
    DotaAbility["leshrac_diabolic_edict"] = "leshrac_diabolic_edict";
    /** 闪电风暴 */
    DotaAbility["leshrac_lightning_storm"] = "leshrac_lightning_storm";
    /** 虚无主义 */
    DotaAbility["leshrac_greater_lightning_storm"] = "leshrac_greater_lightning_storm";
    /** 脉冲新星 */
    DotaAbility["leshrac_pulse_nova"] = "leshrac_pulse_nova";
    /** 大肆污染 */
    DotaAbility["leshrac_defilement"] = "leshrac_defilement";
    /** 时光滋养 (命石技能) */
    DotaAbility["leshrac_chronoptic_nourishment"] = "leshrac_chronoptic_nourishment";
    /** 剑刃风暴 */
    DotaAbility["juggernaut_blade_fury"] = "juggernaut_blade_fury";
    /** 治疗守卫 */
    DotaAbility["juggernaut_healing_ward"] = "juggernaut_healing_ward";
    /** 剑舞 */
    DotaAbility["juggernaut_blade_dance"] = "juggernaut_blade_dance";
    /** 无敌斩 */
    DotaAbility["juggernaut_omni_slash"] = "juggernaut_omni_slash";
    /** 迅风斩 */
    DotaAbility["juggernaut_swift_slash"] = "juggernaut_swift_slash";
    /** 剑心犹在 (命石技能) */
    DotaAbility["juggernaut_bladeform"] = "juggernaut_bladeform";
    /** 肉钩 */
    DotaAbility["pudge_meat_hook"] = "pudge_meat_hook";
    /** 腐烂 */
    DotaAbility["pudge_rot"] = "pudge_rot";
    /** 肉盾 */
    DotaAbility["pudge_flesh_heap"] = "pudge_flesh_heap";
    /** 腐肉堆积 */
    DotaAbility["pudge_innate_graft_flesh"] = "pudge_innate_graft_flesh";
    /** 肢解 */
    DotaAbility["pudge_dismember"] = "pudge_dismember";
    /** 虚弱 */
    DotaAbility["bane_enfeeble"] = "bane_enfeeble";
    /** 蚀脑 */
    DotaAbility["bane_brain_sap"] = "bane_brain_sap";
    /** 噩梦 */
    DotaAbility["bane_nightmare"] = "bane_nightmare";
    /** 噩梦终止 */
    DotaAbility["bane_nightmare_end"] = "bane_nightmare_end";
    /** 妮塔莎脓血 */
    DotaAbility["bane_ichor_of_nyctasha"] = "bane_ichor_of_nyctasha";
    /** 魔爪 */
    DotaAbility["bane_fiends_grip"] = "bane_fiends_grip";
    /** 沟壑 */
    DotaAbility["earthshaker_fissure"] = "earthshaker_fissure";
    /** 强化图腾 */
    DotaAbility["earthshaker_enchant_totem"] = "earthshaker_enchant_totem";
    /** 余震 */
    DotaAbility["earthshaker_aftershock"] = "earthshaker_aftershock";
    /** 强击图腾 */
    DotaAbility["earthshaker_slugger"] = "earthshaker_slugger";
    /** 回音击 */
    DotaAbility["earthshaker_echo_slam"] = "earthshaker_echo_slam";
    /** 掘地穿刺 */
    DotaAbility["sandking_burrowstrike"] = "sandking_burrowstrike";
    /** 沙尘暴 */
    DotaAbility["sandking_sand_storm"] = "sandking_sand_storm";
    /** 腐尸毒 */
    DotaAbility["sandking_caustic_finale"] = "sandking_caustic_finale";
    /** 地震 */
    DotaAbility["sandking_epicenter"] = "sandking_epicenter";
    /** 尾刺 */
    DotaAbility["sandking_scorpion_strike"] = "sandking_scorpion_strike";
    /** 毁灭阴影 */
    DotaAbility["nevermore_shadowraze1"] = "nevermore_shadowraze1";
    /** 毁灭阴影 */
    DotaAbility["nevermore_shadowraze2"] = "nevermore_shadowraze2";
    /** 毁灭阴影 */
    DotaAbility["nevermore_shadowraze3"] = "nevermore_shadowraze3";
    /** 支配死灵 */
    DotaAbility["nevermore_necromastery"] = "nevermore_necromastery";
    /** 魔王降临 */
    DotaAbility["nevermore_dark_lord"] = "nevermore_dark_lord";
    /** 灵魂盛宴 */
    DotaAbility["nevermore_frenzy"] = "nevermore_frenzy";
    /** 魂之挽歌 */
    DotaAbility["nevermore_requiem"] = "nevermore_requiem";
    /** 风暴之拳 */
    DotaAbility["sven_storm_bolt"] = "sven_storm_bolt";
    /** 巨力挥舞 */
    DotaAbility["sven_great_cleave"] = "sven_great_cleave";
    /** 战吼 */
    DotaAbility["sven_warcry"] = "sven_warcry";
    /** 神之力量 */
    DotaAbility["sven_gods_strength"] = "sven_gods_strength";
    /** 神之愤怒 (命石技能) */
    DotaAbility["sven_wrath_of_god"] = "sven_wrath_of_god";
    /** 飘忽不定 */
    DotaAbility["phantom_assassin_immaterial"] = "phantom_assassin_immaterial";
    /** 窒碍短匕 */
    DotaAbility["phantom_assassin_stifling_dagger"] = "phantom_assassin_stifling_dagger";
    /** 幻影突袭 */
    DotaAbility["phantom_assassin_phantom_strike"] = "phantom_assassin_phantom_strike";
    /** 魅影无形 */
    DotaAbility["phantom_assassin_blur"] = "phantom_assassin_blur";
    /** 恩赐解脱 */
    DotaAbility["phantom_assassin_coup_de_grace"] = "phantom_assassin_coup_de_grace";
    /** 刀阵旋风 */
    DotaAbility["phantom_assassin_fan_of_knives"] = "phantom_assassin_fan_of_knives";
    /** 冥火爆击 */
    DotaAbility["skeleton_king_hellfire_blast"] = "skeleton_king_hellfire_blast";
    /** 白骨护卫 (命石技能) */
    DotaAbility["skeleton_king_bone_guard"] = "skeleton_king_bone_guard";
    /** 幽魂之剑 (命石技能) */
    DotaAbility["skeleton_king_spectral_blade"] = "skeleton_king_spectral_blade";
    /** 本命一击 */
    DotaAbility["skeleton_king_mortal_strike"] = "skeleton_king_mortal_strike";
    /** 绝冥再生 */
    DotaAbility["skeleton_king_reincarnation"] = "skeleton_king_reincarnation";
    /** 吸血灵魂 */
    DotaAbility["skeleton_king_vampiric_spirit"] = "skeleton_king_vampiric_spirit";
    /** 霜冻之箭 */
    DotaAbility["drow_ranger_frost_arrows"] = "drow_ranger_frost_arrows";
    /** 数箭齐发 */
    DotaAbility["drow_ranger_multishot"] = "drow_ranger_multishot";
    /** 狂风 */
    DotaAbility["drow_ranger_wave_of_silence"] = "drow_ranger_wave_of_silence";
    /** 精准光环 */
    DotaAbility["drow_ranger_trueshot"] = "drow_ranger_trueshot";
    /** 射手天赋 */
    DotaAbility["drow_ranger_marksmanship"] = "drow_ranger_marksmanship";
    /** 冰川 */
    DotaAbility["drow_ranger_glacier"] = "drow_ranger_glacier";
    /** 波浪形态 */
    DotaAbility["morphling_waveform"] = "morphling_waveform";
    /** 变体打击 */
    DotaAbility["morphling_adaptive_strike_agi"] = "morphling_adaptive_strike_agi";
    /** 潮涨潮落 */
    DotaAbility["morphling_ebb_and_flow"] = "morphling_ebb_and_flow";
    /** 属性变换（敏捷获取） */
    DotaAbility["morphling_morph_agi"] = "morphling_morph_agi";
    /** 属性变换（力量获取） */
    DotaAbility["morphling_morph_str"] = "morphling_morph_str";
    /** 变形 */
    DotaAbility["morphling_replicate"] = "morphling_replicate";
    /** 替换复制体 */
    DotaAbility["morphling_morph_replicate"] = "morphling_morph_replicate";
    /** 潮涨 (命石技能) */
    DotaAbility["morphling_ebb"] = "morphling_ebb";
    /** 潮落 (命石技能) */
    DotaAbility["morphling_flow"] = "morphling_flow";
    /** 血怒 */
    DotaAbility["bloodseeker_bloodrage"] = "bloodseeker_bloodrage";
    /** 血祭 */
    DotaAbility["bloodseeker_blood_bath"] = "bloodseeker_blood_bath";
    /** 焦渴 */
    DotaAbility["bloodseeker_thirst"] = "bloodseeker_thirst";
    /** 食血动物 */
    DotaAbility["bloodseeker_sanguivore"] = "bloodseeker_sanguivore";
    /** 割裂 */
    DotaAbility["bloodseeker_rupture"] = "bloodseeker_rupture";
    /** 狂战士之吼 */
    DotaAbility["axe_berserkers_call"] = "axe_berserkers_call";
    /** 战斗饥渴 */
    DotaAbility["axe_battle_hunger"] = "axe_battle_hunger";
    /** 反击螺旋 */
    DotaAbility["axe_counter_helix"] = "axe_counter_helix";
    /** 淘汰之刃 */
    DotaAbility["axe_culling_blade"] = "axe_culling_blade";
    /** 一人之军 */
    DotaAbility["axe_one_man_army"] = "axe_one_man_army";
    /** 灵魂之矛 */
    DotaAbility["phantom_lancer_spirit_lance"] = "phantom_lancer_spirit_lance";
    /** 神行百变 */
    DotaAbility["phantom_lancer_doppelwalk"] = "phantom_lancer_doppelwalk";
    /** 幻影冲锋 */
    DotaAbility["phantom_lancer_phantom_edge"] = "phantom_lancer_phantom_edge";
    /** 并列 */
    DotaAbility["phantom_lancer_juxtapose"] = "phantom_lancer_juxtapose";
    /** 灵幻兵械 */
    DotaAbility["phantom_lancer_illusory_armaments"] = "phantom_lancer_illusory_armaments";
    /** 等离子场 */
    DotaAbility["razor_plasma_field"] = "razor_plasma_field";
    /** 静电连接 */
    DotaAbility["razor_static_link"] = "razor_static_link";
    /** 风暴涌动 */
    DotaAbility["razor_storm_surge"] = "razor_storm_surge";
    /** 风暴之眼 */
    DotaAbility["razor_eye_of_the_storm"] = "razor_eye_of_the_storm";
    /** 雷电交加 (命石技能) */
    DotaAbility["razor_dynamo"] = "razor_dynamo";
    /** 不稳定电流 */
    DotaAbility["razor_unstable_current"] = "razor_unstable_current";
    /** 通电 */
    DotaAbility["storm_spirit_galvanized"] = "storm_spirit_galvanized";
    /** 残影 */
    DotaAbility["storm_spirit_static_remnant"] = "storm_spirit_static_remnant";
    /** 电子涡流 */
    DotaAbility["storm_spirit_electric_vortex"] = "storm_spirit_electric_vortex";
    /** 超负荷 */
    DotaAbility["storm_spirit_overload"] = "storm_spirit_overload";
    /** 球状闪电 */
    DotaAbility["storm_spirit_ball_lightning"] = "storm_spirit_ball_lightning";
    /** 冰霜新星 */
    DotaAbility["crystal_maiden_crystal_nova"] = "crystal_maiden_crystal_nova";
    /** 冰封禁制 */
    DotaAbility["crystal_maiden_frostbite"] = "crystal_maiden_frostbite";
    /** 奥术光环 */
    DotaAbility["crystal_maiden_brilliance_aura"] = "crystal_maiden_brilliance_aura";
    /** 极寒领域 */
    DotaAbility["crystal_maiden_freezing_field"] = "crystal_maiden_freezing_field";
    /** 停止极寒领域 */
    DotaAbility["crystal_maiden_freezing_field_stop"] = "crystal_maiden_freezing_field_stop";
    /** 冰晶克隆 */
    DotaAbility["crystal_maiden_crystal_clone"] = "crystal_maiden_crystal_clone";
    /** 冰川护体 */
    DotaAbility["crystal_maiden_glacial_guard"] = "crystal_maiden_glacial_guard";
    /** 洪流 */
    DotaAbility["kunkka_torrent"] = "kunkka_torrent";
    /** 潮汐使者 */
    DotaAbility["kunkka_tidebringer"] = "kunkka_tidebringer";
    /** x标记 */
    DotaAbility["kunkka_x_marks_the_spot"] = "kunkka_x_marks_the_spot";
    /** 送回 */
    DotaAbility["kunkka_return"] = "kunkka_return";
    /** 幽灵船 */
    DotaAbility["kunkka_ghostship"] = "kunkka_ghostship";
    /** 潮汐波 */
    DotaAbility["kunkka_tidal_wave"] = "kunkka_tidal_wave";
    /** 统帅朗姆酒 */
    DotaAbility["kunkka_admirals_rum"] = "kunkka_admirals_rum";
    /** 致命连接 */
    DotaAbility["warlock_fatal_bonds"] = "warlock_fatal_bonds";
    /** 暗言术 */
    DotaAbility["warlock_shadow_word"] = "warlock_shadow_word";
    /** 剧变 */
    DotaAbility["warlock_upheaval"] = "warlock_upheaval";
    /** 混乱之祭 */
    DotaAbility["warlock_rain_of_chaos"] = "warlock_rain_of_chaos";
    /** 邪术召唤 */
    DotaAbility["warlock_eldritch_summoning"] = "warlock_eldritch_summoning";
    /** 黑暗魔典 (命石技能) */
    DotaAbility["warlock_black_grimoire"] = "warlock_black_grimoire";
    /** 弧形闪电 */
    DotaAbility["zuus_arc_lightning"] = "zuus_arc_lightning";
    /** 雷击 */
    DotaAbility["zuus_lightning_bolt"] = "zuus_lightning_bolt";
    /** 静电场 */
    DotaAbility["zuus_static_field"] = "zuus_static_field";
    /** 雷神之怒 */
    DotaAbility["zuus_thundergods_wrath"] = "zuus_thundergods_wrath";
    /** 雷云 */
    DotaAbility["zuus_cloud"] = "zuus_cloud";
    /** 神圣一跳 */
    DotaAbility["zuus_heavenly_jump"] = "zuus_heavenly_jump";
    /** 霹雳之手 */
    DotaAbility["zuus_lightning_hands"] = "zuus_lightning_hands";
    /** 山崩 */
    DotaAbility["tiny_avalanche"] = "tiny_avalanche";
    /** 投掷 */
    DotaAbility["tiny_toss"] = "tiny_toss";
    /** 长大 */
    DotaAbility["tiny_grow"] = "tiny_grow";
    /** 抓树 */
    DotaAbility["tiny_tree_grab"] = "tiny_tree_grab";
    /** 扔树 */
    DotaAbility["tiny_toss_tree"] = "tiny_toss_tree";
    /** 树木连掷 */
    DotaAbility["tiny_tree_channel"] = "tiny_tree_channel";
    /** 不可逾越 (命石技能) */
    DotaAbility["tiny_insurmountable"] = "tiny_insurmountable";
    /** 幻象法球 */
    DotaAbility["puck_illusory_orb"] = "puck_illusory_orb";
    /** 新月之痕 */
    DotaAbility["puck_waning_rift"] = "puck_waning_rift";
    /** 相位转移 */
    DotaAbility["puck_phase_shift"] = "puck_phase_shift";
    /** 梦境缠绕 */
    DotaAbility["puck_dream_coil"] = "puck_dream_coil";
    /** 灵动之翼 */
    DotaAbility["puck_ethereal_jaunt"] = "puck_ethereal_jaunt";
    /** 顽皮克敌 */
    DotaAbility["puck_puckish"] = "puck_puckish";
    /** 剧毒之触 */
    DotaAbility["dazzle_poison_touch"] = "dazzle_poison_touch";
    /** 薄葬 */
    DotaAbility["dazzle_shallow_grave"] = "dazzle_shallow_grave";
    /** 暗影波 */
    DotaAbility["dazzle_shadow_wave"] = "dazzle_shadow_wave";
    /** 编织 */
    DotaAbility["dazzle_innate_weave"] = "dazzle_innate_weave";
    /** 虚无投影 */
    DotaAbility["dazzle_nothl_projection"] = "dazzle_nothl_projection";
    /** 结束投影 */
    DotaAbility["dazzle_nothl_projection_end"] = "dazzle_nothl_projection_end";
    /** 虚无之恩 (命石技能) */
    DotaAbility["dazzle_nothl_boon"] = "dazzle_nothl_boon";
    /** 弹幕冲击 */
    DotaAbility["rattletrap_battery_assault"] = "rattletrap_battery_assault";
    /** 能量齿轮 */
    DotaAbility["rattletrap_power_cogs"] = "rattletrap_power_cogs";
    /** 照明火箭 */
    DotaAbility["rattletrap_rocket_flare"] = "rattletrap_rocket_flare";
    /** 发射钩爪 */
    DotaAbility["rattletrap_hookshot"] = "rattletrap_hookshot";
    /** 超速运转 */
    DotaAbility["rattletrap_overclocking"] = "rattletrap_overclocking";
    /** 喷气背包开关 */
    DotaAbility["rattletrap_jetpack_toggle"] = "rattletrap_jetpack_toggle";
    /** 喷气背包 */
    DotaAbility["rattletrap_jetpack"] = "rattletrap_jetpack";
    /** 装甲力量 */
    DotaAbility["rattletrap_armor_power"] = "rattletrap_armor_power";
    /** 寒霜爆发 */
    DotaAbility["lich_frost_nova"] = "lich_frost_nova";
    /** 阴邪凝视 */
    DotaAbility["lich_sinister_gaze"] = "lich_sinister_gaze";
    /** 冰霜魔盾 */
    DotaAbility["lich_frost_shield"] = "lich_frost_shield";
    /** 连环霜冻 */
    DotaAbility["lich_chain_frost"] = "lich_chain_frost";
    /** 寒冰尖柱 */
    DotaAbility["lich_ice_spire"] = "lich_ice_spire";
    /** 献身 */
    DotaAbility["lich_death_charge"] = "lich_death_charge";
    /** 巨浪 */
    DotaAbility["tidehunter_gush"] = "tidehunter_gush";
    /** 海妖外壳 */
    DotaAbility["tidehunter_kraken_shell"] = "tidehunter_kraken_shell";
    /** 锚击 */
    DotaAbility["tidehunter_anchor_smash"] = "tidehunter_anchor_smash";
    /** 毁灭 */
    DotaAbility["tidehunter_ravage"] = "tidehunter_ravage";
    /** 重如铁锚 */
    DotaAbility["tidehunter_dead_in_the_water"] = "tidehunter_dead_in_the_water";
    /** 利维坦的渔获 (命石技能) */
    DotaAbility["tidehunter_krill_eater"] = "tidehunter_krill_eater";
    /** 苍穹震击 */
    DotaAbility["shadow_shaman_ether_shock"] = "shadow_shaman_ether_shock";
    /** 妖术 */
    DotaAbility["shadow_shaman_voodoo"] = "shadow_shaman_voodoo";
    /** 枷锁 */
    DotaAbility["shadow_shaman_shackles"] = "shadow_shaman_shackles";
    /** 群蛇守卫 */
    DotaAbility["shadow_shaman_mass_serpent_ward"] = "shadow_shaman_mass_serpent_ward";
    /** 巨蟒之瓮 */
    DotaAbility["shadow_shaman_urnaconda"] = "shadow_shaman_urnaconda";
    /** 鸡手指 (命石技能) */
    DotaAbility["shadow_shaman_voodoo_hands"] = "shadow_shaman_voodoo_hands";
    /** 禽戏 */
    DotaAbility["shadow_shaman_fowl_play"] = "shadow_shaman_fowl_play";
    /** 烟幕 */
    DotaAbility["riki_smoke_screen"] = "riki_smoke_screen";
    /** 刀光谍影 */
    DotaAbility["riki_backstab"] = "riki_backstab";
    /** 背刺 */
    DotaAbility["riki_innate_backstab"] = "riki_innate_backstab";
    /** 闪烁突袭 */
    DotaAbility["riki_blink_strike"] = "riki_blink_strike";
    /** 绝杀秘技 */
    DotaAbility["riki_tricks_of_the_trade"] = "riki_tricks_of_the_trade";
    /** 憎恶 */
    DotaAbility["enigma_malefice"] = "enigma_malefice";
    /** 恶魔召唤 */
    DotaAbility["enigma_demonic_conversion"] = "enigma_demonic_conversion";
    /** 午夜凋零 */
    DotaAbility["enigma_midnight_pulse"] = "enigma_midnight_pulse";
    /** 黑洞 */
    DotaAbility["enigma_black_hole"] = "enigma_black_hole";
    /** 事件视界 */
    DotaAbility["enigma_event_horizon"] = "enigma_event_horizon";
    /** 激光 */
    DotaAbility["tinker_laser"] = "tinker_laser";
    /** 折跃耀光 */
    DotaAbility["tinker_warp_grenade"] = "tinker_warp_grenade";
    /** 机械行军 */
    DotaAbility["tinker_march_of_the_machines"] = "tinker_march_of_the_machines";
    /** 再装填 */
    DotaAbility["tinker_rearm"] = "tinker_rearm";
    /** 基恩载具 */
    DotaAbility["tinker_keen_teleport"] = "tinker_keen_teleport";
    /** 尤里卡！ */
    DotaAbility["tinker_eureka"] = "tinker_eureka";
    /** 部署炮塔 */
    DotaAbility["tinker_deploy_turrets"] = "tinker_deploy_turrets";
    /** 榴霰弹 */
    DotaAbility["sniper_shrapnel"] = "sniper_shrapnel";
    /** 爆头 */
    DotaAbility["sniper_headshot"] = "sniper_headshot";
    /** 瞄准 */
    DotaAbility["sniper_take_aim"] = "sniper_take_aim";
    /** 暗杀 */
    DotaAbility["sniper_assassinate"] = "sniper_assassinate";
    /** 基恩瞄准镜 */
    DotaAbility["sniper_keen_scope"] = "sniper_keen_scope";
    /** 震荡手雷 */
    DotaAbility["sniper_concussive_grenade"] = "sniper_concussive_grenade";
    /** 死亡脉冲 */
    DotaAbility["necrolyte_death_pulse"] = "necrolyte_death_pulse";
    /** 竭心光环 */
    DotaAbility["necrolyte_heartstopper_aura"] = "necrolyte_heartstopper_aura";
    /** 施虐之心 */
    DotaAbility["necrolyte_sadist"] = "necrolyte_sadist";
    /** 幽魂护罩 */
    DotaAbility["necrolyte_ghost_shroud"] = "necrolyte_ghost_shroud";
    /** 死神镰刀 */
    DotaAbility["necrolyte_reapers_scythe"] = "necrolyte_reapers_scythe";
    /** 死亡搜寻 */
    DotaAbility["necrolyte_death_seeker"] = "necrolyte_death_seeker";
    /** 汪洋前哨 */
    DotaAbility["slardar_seaborn_sentinel"] = "slardar_seaborn_sentinel";
    /** 守卫冲刺 */
    DotaAbility["slardar_sprint"] = "slardar_sprint";
    /** 鱼人碎击 */
    DotaAbility["slardar_slithereen_crush"] = "slardar_slithereen_crush";
    /** 深海重击 */
    DotaAbility["slardar_bash"] = "slardar_bash";
    /** 侵蚀雾霭 */
    DotaAbility["slardar_amplify_damage"] = "slardar_amplify_damage";
    /** 野性之斧 */
    DotaAbility["beastmaster_wild_axes"] = "beastmaster_wild_axes";
    /** 召唤刀背兽 */
    DotaAbility["beastmaster_summon_razorback"] = "beastmaster_summon_razorback";
    /** 召唤猛禽 */
    DotaAbility["beastmaster_summon_raptor"] = "beastmaster_summon_raptor";
    /** 野性之心 */
    DotaAbility["beastmaster_inner_beast"] = "beastmaster_inner_beast";
    /** 原始咆哮 */
    DotaAbility["beastmaster_primal_roar"] = "beastmaster_primal_roar";
    /** 斯洛姆战鼓 */
    DotaAbility["beastmaster_drums_of_slom"] = "beastmaster_drums_of_slom";
    /** 瘴气 */
    DotaAbility["venomancer_venomous_gale"] = "venomancer_venomous_gale";
    /** 毒刺 */
    DotaAbility["venomancer_poison_sting"] = "venomancer_poison_sting";
    /** 瘟疫守卫 */
    DotaAbility["venomancer_plague_ward"] = "venomancer_plague_ward";
    /** 恶性瘟疫 */
    DotaAbility["venomancer_noxious_plague"] = "venomancer_noxious_plague";
    /** 毒蛇撕咬 */
    DotaAbility["venomancer_snakebite"] = "venomancer_snakebite";
    /** 时间漫游 */
    DotaAbility["faceless_void_time_walk"] = "faceless_void_time_walk";
    /** 反时间漫游 */
    DotaAbility["faceless_void_time_walk_reverse"] = "faceless_void_time_walk_reverse";
    /** 时间膨胀 */
    DotaAbility["faceless_void_time_dilation"] = "faceless_void_time_dilation";
    /** 时间锁定 */
    DotaAbility["faceless_void_time_lock"] = "faceless_void_time_lock";
    /** 时间结界 (命石技能) */
    DotaAbility["faceless_void_chronosphere"] = "faceless_void_chronosphere";
    /** 逆转时空 (命石技能) */
    DotaAbility["faceless_void_time_zone"] = "faceless_void_time_zone";
    /** 扭曲力场 */
    DotaAbility["faceless_void_distortion_field"] = "faceless_void_distortion_field";
    /** 巫术精研 */
    DotaAbility["death_prophet_witchcraft"] = "death_prophet_witchcraft";
    /** 地穴虫群 */
    DotaAbility["death_prophet_carrion_swarm"] = "death_prophet_carrion_swarm";
    /** 沉默魔法 */
    DotaAbility["death_prophet_silence"] = "death_prophet_silence";
    /** 吸魂巫术 */
    DotaAbility["death_prophet_spirit_siphon"] = "death_prophet_spirit_siphon";
    /** 驱使恶灵 */
    DotaAbility["death_prophet_exorcism"] = "death_prophet_exorcism";
    /** 灵魂收集 (命石技能) */
    DotaAbility["death_prophet_spirit_collector"] = "death_prophet_spirit_collector";
    /** 哀悼仪式 (命石技能) */
    DotaAbility["death_prophet_mourning_ritual"] = "death_prophet_mourning_ritual";
    /** 幽冥爆轰 */
    DotaAbility["pugna_nether_blast"] = "pugna_nether_blast";
    /** 衰老 */
    DotaAbility["pugna_decrepify"] = "pugna_decrepify";
    /** 幽冥守卫 */
    DotaAbility["pugna_nether_ward"] = "pugna_nether_ward";
    /** 生命汲取 */
    DotaAbility["pugna_life_drain"] = "pugna_life_drain";
    /** 湮灭专家 */
    DotaAbility["pugna_oblivion_savant"] = "pugna_oblivion_savant";
    /** 折光 */
    DotaAbility["templar_assassin_refraction"] = "templar_assassin_refraction";
    /** 隐匿 */
    DotaAbility["templar_assassin_meld"] = "templar_assassin_meld";
    /** 灵能之刃 */
    DotaAbility["templar_assassin_psi_blades"] = "templar_assassin_psi_blades";
    /** 心怀安宁 */
    DotaAbility["templar_assassin_inner_peace"] = "templar_assassin_inner_peace";
    /** 灵能陷阱 */
    DotaAbility["templar_assassin_psionic_trap"] = "templar_assassin_psionic_trap";
    /** 触发陷阱 */
    DotaAbility["templar_assassin_trap"] = "templar_assassin_trap";
    /** 灵能投射 */
    DotaAbility["templar_assassin_trap_teleport"] = "templar_assassin_trap_teleport";
    /** 毒性攻击 */
    DotaAbility["viper_poison_attack"] = "viper_poison_attack";
    /** 幽冥剧毒 */
    DotaAbility["viper_nethertoxin"] = "viper_nethertoxin";
    /** 腐蚀皮肤 */
    DotaAbility["viper_corrosive_skin"] = "viper_corrosive_skin";
    /** 蝮蛇突袭 */
    DotaAbility["viper_viper_strike"] = "viper_viper_strike";
    /** 极恶俯冲 */
    DotaAbility["viper_nose_dive"] = "viper_nose_dive";
    /** 掠食 */
    DotaAbility["viper_predator"] = "viper_predator";
    /** 月光 */
    DotaAbility["luna_lucent_beam"] = "luna_lucent_beam";
    /** 月刃 */
    DotaAbility["luna_moon_glaive"] = "luna_moon_glaive";
    /** 月之祝福 */
    DotaAbility["luna_lunar_blessing"] = "luna_lunar_blessing";
    /** 环月 */
    DotaAbility["luna_lunar_orbit"] = "luna_lunar_orbit";
    /** 月蚀 */
    DotaAbility["luna_eclipse"] = "luna_eclipse";
    /** 火焰气息 */
    DotaAbility["dragon_knight_breathe_fire"] = "dragon_knight_breathe_fire";
    /** 神龙摆尾 */
    DotaAbility["dragon_knight_dragon_tail"] = "dragon_knight_dragon_tail";
    /** 龙族血统 */
    DotaAbility["dragon_knight_dragon_blood"] = "dragon_knight_dragon_blood";
    /** 飞龙之怒 */
    DotaAbility["dragon_knight_wyrms_wrath"] = "dragon_knight_wyrms_wrath";
    /** 古龙形态 */
    DotaAbility["dragon_knight_elder_dragon_form"] = "dragon_knight_elder_dragon_form";
    /** 龙炎火球 */
    DotaAbility["dragon_knight_fireball"] = "dragon_knight_fireball";
    /** 真空 */
    DotaAbility["dark_seer_vacuum"] = "dark_seer_vacuum";
    /** 离子外壳 */
    DotaAbility["dark_seer_ion_shell"] = "dark_seer_ion_shell";
    /** 奔腾 */
    DotaAbility["dark_seer_surge"] = "dark_seer_surge";
    /** 复制之墙 */
    DotaAbility["dark_seer_wall_of_replica"] = "dark_seer_wall_of_replica";
    /** 普通一拳 */
    DotaAbility["dark_seer_normal_punch"] = "dark_seer_normal_punch";
    /** 才思敏捷 */
    DotaAbility["dark_seer_aggrandize"] = "dark_seer_aggrandize";
    /** 才思敏捷 (命石技能) */
    DotaAbility["dark_seer_quick_wit"] = "dark_seer_quick_wit";
    /** 战斗之心 (命石技能) */
    DotaAbility["dark_seer_heart_of_battle"] = "dark_seer_heart_of_battle";
    /** 炽烈火雨 */
    DotaAbility["clinkz_burning_barrage"] = "clinkz_burning_barrage";
    /** 灼热之箭 */
    DotaAbility["clinkz_searing_arrows"] = "clinkz_searing_arrows";
    /** 扫射 */
    DotaAbility["clinkz_strafe"] = "clinkz_strafe";
    /** 骨隐步 */
    DotaAbility["clinkz_wind_walk"] = "clinkz_wind_walk";
    /** 死亡契约 */
    DotaAbility["clinkz_death_pact"] = "clinkz_death_pact";
    /** 烈焰之军 */
    DotaAbility["clinkz_burning_army"] = "clinkz_burning_army";
    /** 地狱之裂 */
    DotaAbility["clinkz_infernal_shred"] = "clinkz_infernal_shred";
    /** 不可侵犯 */
    DotaAbility["enchantress_untouchable"] = "enchantress_untouchable";
    /** 魅惑 */
    DotaAbility["enchantress_enchant"] = "enchantress_enchant";
    /** 自然之助 */
    DotaAbility["enchantress_natures_attendants"] = "enchantress_natures_attendants";
    /** 推进 */
    DotaAbility["enchantress_impetus"] = "enchantress_impetus";
    /** 密友 */
    DotaAbility["enchantress_little_friends"] = "enchantress_little_friends";
    /** 跃动 */
    DotaAbility["enchantress_bunny_hop"] = "enchantress_bunny_hop";
    /** 煽动野怪 */
    DotaAbility["enchantress_rabblerouser"] = "enchantress_rabblerouser";
    /** 洗礼 */
    DotaAbility["omniknight_purification"] = "omniknight_purification";
    /** 疗伤之锤 (命石技能) */
    DotaAbility["omniknight_healing_hammer"] = "omniknight_healing_hammer";
    /** 退化光环 */
    DotaAbility["omniknight_degen_aura"] = "omniknight_degen_aura";
    /** 驱逐 */
    DotaAbility["omniknight_martyr"] = "omniknight_martyr";
    /** 守护天使 */
    DotaAbility["omniknight_guardian_angel"] = "omniknight_guardian_angel";
    /** 纯洁之锤 */
    DotaAbility["omniknight_hammer_of_purity"] = "omniknight_hammer_of_purity";
    /** 心炎 */
    DotaAbility["huskar_inner_fire"] = "huskar_inner_fire";
    /** 沸血之矛 */
    DotaAbility["huskar_burning_spear"] = "huskar_burning_spear";
    /** 血魔法 */
    DotaAbility["huskar_blood_magic"] = "huskar_blood_magic";
    /** 狂战士之血 */
    DotaAbility["huskar_berserkers_blood"] = "huskar_berserkers_blood";
    /** 牺牲 */
    DotaAbility["huskar_life_break"] = "huskar_life_break";
    /** 虚空 */
    DotaAbility["night_stalker_void"] = "night_stalker_void";
    /** 伤残恐惧 */
    DotaAbility["night_stalker_crippling_fear"] = "night_stalker_crippling_fear";
    /** 暗夜猎影 */
    DotaAbility["night_stalker_hunter_in_the_night"] = "night_stalker_hunter_in_the_night";
    /** 黑暗飞升 */
    DotaAbility["night_stalker_darkness"] = "night_stalker_darkness";
    /** 长夜之治 (命石技能) */
    DotaAbility["night_stalker_night_reign"] = "night_stalker_night_reign";
    /** 午夜盛宴 */
    DotaAbility["night_stalker_midnight_feast"] = "night_stalker_midnight_feast";
    /** 孵化蜘蛛 */
    DotaAbility["broodmother_spawn_spiderlings"] = "broodmother_spawn_spiderlings";
    /** 蛛纱陷阱 */
    DotaAbility["broodmother_sticky_snare"] = "broodmother_sticky_snare";
    /** 织网 */
    DotaAbility["broodmother_spin_web"] = "broodmother_spin_web";
    /** 麻痹之咬 */
    DotaAbility["broodmother_incapacitating_bite"] = "broodmother_incapacitating_bite";
    /** 极度饥渴 */
    DotaAbility["broodmother_insatiable_hunger"] = "broodmother_insatiable_hunger";
    /** 蜘蛛奶 */
    DotaAbility["broodmother_spiders_milk"] = "broodmother_spiders_milk";
    /** 投掷飞镖 */
    DotaAbility["bounty_hunter_shuriken_toss"] = "bounty_hunter_shuriken_toss";
    /** 忍术 */
    DotaAbility["bounty_hunter_jinada"] = "bounty_hunter_jinada";
    /** 暗影步 */
    DotaAbility["bounty_hunter_wind_walk"] = "bounty_hunter_wind_walk";
    /** 暗影情谊 */
    DotaAbility["bounty_hunter_wind_walk_ally"] = "bounty_hunter_wind_walk_ally";
    /** 追踪术 */
    DotaAbility["bounty_hunter_track"] = "bounty_hunter_track";
    /** 妙手空空 (命石技能) */
    DotaAbility["bounty_hunter_cutpurse"] = "bounty_hunter_cutpurse";
    /** 职业猎人 */
    DotaAbility["bounty_hunter_big_game_hunter"] = "bounty_hunter_big_game_hunter";
    /** 虫群 */
    DotaAbility["weaver_the_swarm"] = "weaver_the_swarm";
    /** 缩地 */
    DotaAbility["weaver_shukuchi"] = "weaver_shukuchi";
    /** 连击 */
    DotaAbility["weaver_geminate_attack"] = "weaver_geminate_attack";
    /** 时光倒流 */
    DotaAbility["weaver_time_lapse"] = "weaver_time_lapse";
    /** 命运之线 */
    DotaAbility["weaver_threads_of_fate"] = "weaver_threads_of_fate";
    /** 冰火交加 */
    DotaAbility["jakiro_dual_breath"] = "jakiro_dual_breath";
    /** 冰封路径 */
    DotaAbility["jakiro_ice_path"] = "jakiro_ice_path";
    /** 摧毁冰封路径 (命石技能) */
    DotaAbility["jakiro_ice_path_detonate"] = "jakiro_ice_path_detonate";
    /** 液态火 (命石技能) */
    DotaAbility["jakiro_liquid_fire"] = "jakiro_liquid_fire";
    /** 液态冰 (命石技能) */
    DotaAbility["jakiro_liquid_ice"] = "jakiro_liquid_ice";
    /** 烈焰焚身 */
    DotaAbility["jakiro_macropyre"] = "jakiro_macropyre";
    /** 天生一对 */
    DotaAbility["jakiro_double_trouble"] = "jakiro_double_trouble";
    /** 粘性燃油 */
    DotaAbility["batrider_sticky_napalm"] = "batrider_sticky_napalm";
    /** 施加时伤害： */
    DotaAbility["batrider_sticky_napalm_application_damage"] = "batrider_sticky_napalm_application_damage";
    /** 烈焰破击 */
    DotaAbility["batrider_flamebreak"] = "batrider_flamebreak";
    /** 火焰飞行 */
    DotaAbility["batrider_firefly"] = "batrider_firefly";
    /** 燃烧枷锁 */
    DotaAbility["batrider_flaming_lasso"] = "batrider_flaming_lasso";
    /** 闷烧树脂 */
    DotaAbility["batrider_smoldering_resin"] = "batrider_smoldering_resin";
    /** 赎罪 */
    DotaAbility["chen_penitence"] = "chen_penitence";
    /** 神力恩泽 */
    DotaAbility["chen_divine_favor"] = "chen_divine_favor";
    /** 神圣劝化 */
    DotaAbility["chen_holy_persuasion"] = "chen_holy_persuasion";
    /** 上帝之手 */
    DotaAbility["chen_hand_of_god"] = "chen_hand_of_god";
    /** 狂热者 */
    DotaAbility["chen_zealot"] = "chen_zealot";
    /** 幽鬼之刃 */
    DotaAbility["spectre_spectral_dagger"] = "spectre_spectral_dagger";
    /** 荒芜 */
    DotaAbility["spectre_desolate"] = "spectre_desolate";
    /** 折射 */
    DotaAbility["spectre_dispersion"] = "spectre_dispersion";
    /** 鬼影重重 */
    DotaAbility["spectre_haunt"] = "spectre_haunt";
    /** 空降 */
    DotaAbility["spectre_reality"] = "spectre_reality";
    /** 如影随形 */
    DotaAbility["spectre_shadow_step"] = "spectre_shadow_step";
    /** 吞噬 */
    DotaAbility["doom_bringer_devour"] = "doom_bringer_devour";
    /** 恶魔的交易 (命石技能) */
    DotaAbility["doom_bringer_devils_bargain"] = "doom_bringer_devils_bargain";
    /** 等级？痛苦 */
    DotaAbility["doom_bringer_lvl_pain"] = "doom_bringer_lvl_pain";
    /** 焦土 */
    DotaAbility["doom_bringer_scorched_earth"] = "doom_bringer_scorched_earth";
    /** 阎刃 */
    DotaAbility["doom_bringer_infernal_blade"] = "doom_bringer_infernal_blade";
    /** 末日 */
    DotaAbility["doom_bringer_doom"] = "doom_bringer_doom";
    /** 技能（来自吞噬） */
    DotaAbility["doom_bringer_empty1"] = "doom_bringer_empty1";
    /** 技能（来自吞噬） */
    DotaAbility["doom_bringer_empty2"] = "doom_bringer_empty2";
    /** 寒霜之足 */
    DotaAbility["ancient_apparition_cold_feet"] = "ancient_apparition_cold_feet";
    /** 冰霜漩涡 */
    DotaAbility["ancient_apparition_ice_vortex"] = "ancient_apparition_ice_vortex";
    /** 极寒之触 */
    DotaAbility["ancient_apparition_chilling_touch"] = "ancient_apparition_chilling_touch";
    /** 刺骨严寒 */
    DotaAbility["ancient_apparition_bone_chill"] = "ancient_apparition_bone_chill";
    /** 冰晶爆轰 */
    DotaAbility["ancient_apparition_ice_blast"] = "ancient_apparition_ice_blast";
    /** 释放 */
    DotaAbility["ancient_apparition_ice_blast_release"] = "ancient_apparition_ice_blast_release";
    /** 震撼大地 */
    DotaAbility["ursa_earthshock"] = "ursa_earthshock";
    /** 超强力量 */
    DotaAbility["ursa_overpower"] = "ursa_overpower";
    /** 怒意狂击 */
    DotaAbility["ursa_fury_swipes"] = "ursa_fury_swipes";
    /** 激怒 */
    DotaAbility["ursa_enrage"] = "ursa_enrage";
    /** 暴烈之爪 */
    DotaAbility["ursa_maul"] = "ursa_maul";
    /** 熊心勃勃 (命石技能) */
    DotaAbility["ursa_bear_down"] = "ursa_bear_down";
    /** 加力燃烧器 */
    DotaAbility["gyrocopter_afterburner"] = "gyrocopter_afterburner";
    /** 火箭弹幕 */
    DotaAbility["gyrocopter_rocket_barrage"] = "gyrocopter_rocket_barrage";
    /** 追踪导弹 */
    DotaAbility["gyrocopter_homing_missile"] = "gyrocopter_homing_missile";
    /** 高射火炮 */
    DotaAbility["gyrocopter_flak_cannon"] = "gyrocopter_flak_cannon";
    /** 侧翼机枪 */
    DotaAbility["gyrocopter_side_gunner_spawn_ability"] = "gyrocopter_side_gunner_spawn_ability";
    /** 召唤飞弹 */
    DotaAbility["gyrocopter_call_down"] = "gyrocopter_call_down";
    /** 暗影冲刺 */
    DotaAbility["spirit_breaker_charge_of_darkness"] = "spirit_breaker_charge_of_darkness";
    /** 威吓 */
    DotaAbility["spirit_breaker_bulldoze"] = "spirit_breaker_bulldoze";
    /** 巨力重击 */
    DotaAbility["spirit_breaker_greater_bash"] = "spirit_breaker_greater_bash";
    /** 幽冥一击 */
    DotaAbility["spirit_breaker_nether_strike"] = "spirit_breaker_nether_strike";
    /** 位面空洞 */
    DotaAbility["spirit_breaker_planar_pocket"] = "spirit_breaker_planar_pocket";
    /** 神行太保 */
    DotaAbility["spirit_breaker_bull_rush"] = "spirit_breaker_bull_rush";
    /** 酸性喷雾 */
    DotaAbility["alchemist_acid_spray"] = "alchemist_acid_spray";
    /** 投掷不稳定化合物 */
    DotaAbility["alchemist_unstable_concoction_throw"] = "alchemist_unstable_concoction_throw";
    /** 不稳定化合物 */
    DotaAbility["alchemist_unstable_concoction"] = "alchemist_unstable_concoction";
    /** 贪魔的贪婪 */
    DotaAbility["alchemist_goblins_greed"] = "alchemist_goblins_greed";
    /** 化学狂暴 */
    DotaAbility["alchemist_chemical_rage"] = "alchemist_chemical_rage";
    /** 腐蚀兵械 */
    DotaAbility["alchemist_corrosive_weaponry"] = "alchemist_corrosive_weaponry";
    /** 狂暴药剂 */
    DotaAbility["alchemist_berserk_potion"] = "alchemist_berserk_potion";
    /** 冰 */
    DotaAbility["invoker_quas"] = "invoker_quas";
    /** 雷 */
    DotaAbility["invoker_wex"] = "invoker_wex";
    /** 火 */
    DotaAbility["invoker_exort"] = "invoker_exort";
    /** 祈唤技能 */
    DotaAbility["invoker_empty1"] = "invoker_empty1";
    /** 祈唤技能 */
    DotaAbility["invoker_empty2"] = "invoker_empty2";
    /** 元素祈唤 */
    DotaAbility["invoker_invoke"] = "invoker_invoke";
    /** 急速冷却 */
    DotaAbility["invoker_cold_snap"] = "invoker_cold_snap";
    /** 幽灵漫步 */
    DotaAbility["invoker_ghost_walk"] = "invoker_ghost_walk";
    /** 强袭飓风 */
    DotaAbility["invoker_tornado"] = "invoker_tornado";
    /** 电磁脉冲 */
    DotaAbility["invoker_emp"] = "invoker_emp";
    /** 灵动迅捷 */
    DotaAbility["invoker_alacrity"] = "invoker_alacrity";
    /** 混沌陨石 */
    DotaAbility["invoker_chaos_meteor"] = "invoker_chaos_meteor";
    /** 阳炎冲击 */
    DotaAbility["invoker_sun_strike"] = "invoker_sun_strike";
    /** 熔炉精灵 */
    DotaAbility["invoker_forge_spirit"] = "invoker_forge_spirit";
    /** 寒冰之墙 */
    DotaAbility["invoker_ice_wall"] = "invoker_ice_wall";
    /** 超震声波 */
    DotaAbility["invoker_deafening_blast"] = "invoker_deafening_blast";
    /** 急速冷却（omg） */
    DotaAbility["invoker_cold_snap_ad"] = "invoker_cold_snap_ad";
    /** 幽灵漫步（omg） */
    DotaAbility["invoker_ghost_walk_ad"] = "invoker_ghost_walk_ad";
    /** 强袭飓风（omg） */
    DotaAbility["invoker_tornado_ad"] = "invoker_tornado_ad";
    /** 电磁脉冲（omg） */
    DotaAbility["invoker_emp_ad"] = "invoker_emp_ad";
    /** 灵动迅捷（omg） */
    DotaAbility["invoker_alacrity_ad"] = "invoker_alacrity_ad";
    /** 混沌陨石（omg） */
    DotaAbility["invoker_chaos_meteor_ad"] = "invoker_chaos_meteor_ad";
    /** 阳炎冲击（omg） */
    DotaAbility["invoker_sun_strike_ad"] = "invoker_sun_strike_ad";
    /** 熔炉精灵（omg） */
    DotaAbility["invoker_forge_spirit_ad"] = "invoker_forge_spirit_ad";
    /** 寒冰之墙（omg） */
    DotaAbility["invoker_ice_wall_ad"] = "invoker_ice_wall_ad";
    /** 超震声波（omg） */
    DotaAbility["invoker_deafening_blast_ad"] = "invoker_deafening_blast_ad";
    /** 奥术诅咒 */
    DotaAbility["silencer_curse_of_the_silent"] = "silencer_curse_of_the_silent";
    /** 默默受苦 (命石技能) */
    DotaAbility["silencer_oppressive_silence"] = "silencer_oppressive_silence";
    /** 默默受苦 */
    DotaAbility["silencer_brain_drain"] = "silencer_brain_drain";
    /** 智慧之刃 */
    DotaAbility["silencer_glaives_of_wisdom"] = "silencer_glaives_of_wisdom";
    /** 遗言 */
    DotaAbility["silencer_last_word"] = "silencer_last_word";
    /** 全领域静默 */
    DotaAbility["silencer_global_silence"] = "silencer_global_silence";
    /** 奥术天球 */
    DotaAbility["obsidian_destroyer_arcane_orb"] = "obsidian_destroyer_arcane_orb";
    /** 星体禁锢 */
    DotaAbility["obsidian_destroyer_astral_imprisonment"] = "obsidian_destroyer_astral_imprisonment";
    /** 精华变迁 */
    DotaAbility["obsidian_destroyer_equilibrium"] = "obsidian_destroyer_equilibrium";
    /** 责难 */
    DotaAbility["obsidian_destroyer_objurgation"] = "obsidian_destroyer_objurgation";
    /** 神智之蚀 */
    DotaAbility["obsidian_destroyer_sanity_eclipse"] = "obsidian_destroyer_sanity_eclipse";
    /** 召狼 */
    DotaAbility["lycan_summon_wolves"] = "lycan_summon_wolves";
    /** 嗥叫 */
    DotaAbility["lycan_howl"] = "lycan_howl";
    /** 野性驱使 */
    DotaAbility["lycan_feral_impulse"] = "lycan_feral_impulse";
    /** 变身 */
    DotaAbility["lycan_shapeshift"] = "lycan_shapeshift";
    /** 饿狼撕咬 */
    DotaAbility["lycan_wolf_bite"] = "lycan_wolf_bite";
    /** 顶级掠食者 */
    DotaAbility["lycan_apex_predator"] = "lycan_apex_predator";
    /** 熊灵伙伴 */
    DotaAbility["lone_druid_spirit_bear"] = "lone_druid_spirit_bear";
    /** 缠绕之根 */
    DotaAbility["lone_druid_entangle"] = "lone_druid_entangle";
    /** 灵魂链接 */
    DotaAbility["lone_druid_spirit_link"] = "lone_druid_spirit_link";
    /** 熊亦求精 (命石技能) */
    DotaAbility["lone_druid_bear_necessities"] = "lone_druid_bear_necessities";
    /** 野蛮咆哮 */
    DotaAbility["lone_druid_savage_roar"] = "lone_druid_savage_roar";
    /** 真熊形态 */
    DotaAbility["lone_druid_true_form"] = "lone_druid_true_form";
    /** 雷霆一击 */
    DotaAbility["brewmaster_thunder_clap"] = "brewmaster_thunder_clap";
    /** 余烬佳酿 */
    DotaAbility["brewmaster_cinder_brew"] = "brewmaster_cinder_brew";
    /** 醉拳 */
    DotaAbility["brewmaster_drunken_brawler"] = "brewmaster_drunken_brawler";
    /** 壮胆酒 */
    DotaAbility["brewmaster_liquid_courage"] = "brewmaster_liquid_courage";
    /** 元素分离 */
    DotaAbility["brewmaster_primal_split"] = "brewmaster_primal_split";
    /** 崩裂禁锢 */
    DotaAbility["shadow_demon_disruption"] = "shadow_demon_disruption";
    /** 暗影剧毒 */
    DotaAbility["shadow_demon_shadow_poison"] = "shadow_demon_shadow_poison";
    /** 释放暗影毒 */
    DotaAbility["shadow_demon_shadow_poison_release"] = "shadow_demon_shadow_poison_release";
    /** 邪恶净化 */
    DotaAbility["shadow_demon_demonic_purge"] = "shadow_demon_demonic_purge";
    /** 邪恶净愈 */
    DotaAbility["shadow_demon_demonic_cleanse"] = "shadow_demon_demonic_cleanse";
    /** 散播 */
    DotaAbility["shadow_demon_disseminate"] = "shadow_demon_disseminate";
    /** 灵魂猎手 (命石技能) */
    DotaAbility["shadow_demon_shadow_servant"] = "shadow_demon_shadow_servant";
    /** 威胁 */
    DotaAbility["shadow_demon_menace"] = "shadow_demon_menace";
    /** 混乱之箭 */
    DotaAbility["chaos_knight_chaos_bolt"] = "chaos_knight_chaos_bolt";
    /** 实相裂隙 */
    DotaAbility["chaos_knight_reality_rift"] = "chaos_knight_reality_rift";
    /** 混沌一击 */
    DotaAbility["chaos_knight_chaos_strike"] = "chaos_knight_chaos_strike";
    /** 混沌之军 */
    DotaAbility["chaos_knight_phantasm"] = "chaos_knight_phantasm";
    /** 千变幻景 (命石技能) */
    DotaAbility["chaos_knight_phantasmagoria"] = "chaos_knight_phantasmagoria";
    /** 基本法则锻造 (命石技能) */
    DotaAbility["chaos_knight_fundamental_forging"] = "chaos_knight_fundamental_forging";
    /** 傻福 */
    DotaAbility["ogre_magi_dumb_luck"] = "ogre_magi_dumb_luck";
    /** 火焰爆轰 */
    DotaAbility["ogre_magi_fireblast"] = "ogre_magi_fireblast";
    /** 未精通的火焰爆轰 */
    DotaAbility["ogre_magi_unrefined_fireblast"] = "ogre_magi_unrefined_fireblast";
    /** 引燃 */
    DotaAbility["ogre_magi_ignite"] = "ogre_magi_ignite";
    /** 嗜血术 */
    DotaAbility["ogre_magi_bloodlust"] = "ogre_magi_bloodlust";
    /** 多重施法 */
    DotaAbility["ogre_magi_multicast"] = "ogre_magi_multicast";
    /** 烈火护盾 */
    DotaAbility["ogre_magi_smash"] = "ogre_magi_smash";
    /** 自然蔽护 */
    DotaAbility["treant_natures_guise"] = "treant_natures_guise";
    /** 自然卷握 */
    DotaAbility["treant_natures_grasp"] = "treant_natures_grasp";
    /** 寄生种子 */
    DotaAbility["treant_leech_seed"] = "treant_leech_seed";
    /** 活体护甲 */
    DotaAbility["treant_living_armor"] = "treant_living_armor";
    /** 疯狂生长 */
    DotaAbility["treant_overgrowth"] = "treant_overgrowth";
    /** 丛林之眼 */
    DotaAbility["treant_eyes_in_the_forest"] = "treant_eyes_in_the_forest";
    /** 地之束缚 */
    DotaAbility["meepo_earthbind"] = "meepo_earthbind";
    /** 忽悠 */
    DotaAbility["meepo_poof"] = "meepo_poof";
    /** 洗劫 */
    DotaAbility["meepo_ransack"] = "meepo_ransack";
    /** 分则能成 */
    DotaAbility["meepo_divided_we_stand"] = "meepo_divided_we_stand";
    /** 地卜术 */
    DotaAbility["meepo_geomancy"] = "meepo_geomancy";
    /** 掘地 */
    DotaAbility["meepo_petrify"] = "meepo_petrify";
    /** 超大米波 */
    DotaAbility["meepo_megameepo"] = "meepo_megameepo";
    /** 超大米波摔扔 */
    DotaAbility["meepo_megameepo_fling"] = "meepo_megameepo_fling";
    /** 囤积狂鼠 (命石技能) */
    DotaAbility["meepo_pack_rat"] = "meepo_pack_rat";
    /** 黄泉颤抖 */
    DotaAbility["visage_grave_chill"] = "visage_grave_chill";
    /** 灵魂超度 */
    DotaAbility["visage_soul_assumption"] = "visage_soul_assumption";
    /** 陵卫斗篷 */
    DotaAbility["visage_gravekeepers_cloak"] = "visage_gravekeepers_cloak";
    /** 召唤佣兽 */
    DotaAbility["visage_summon_familiars"] = "visage_summon_familiars";
    /** 石像形态 */
    DotaAbility["visage_summon_familiars_stone_form"] = "visage_summon_familiars_stone_form";
    /** 石像形态 */
    DotaAbility["visage_stone_form_self_cast"] = "visage_stone_form_self_cast";
    /** 静如古墓 */
    DotaAbility["visage_silent_as_the_grave"] = "visage_silent_as_the_grave";
    /** 腐朽 */
    DotaAbility["undying_decay"] = "undying_decay";
    /** 噬魂 */
    DotaAbility["undying_soul_rip"] = "undying_soul_rip";
    /** 墓碑 */
    DotaAbility["undying_tombstone"] = "undying_tombstone";
    /** 挽歌犹唱 */
    DotaAbility["undying_ceaseless_dirge"] = "undying_ceaseless_dirge";
    /** 血肉傀儡 */
    DotaAbility["undying_flesh_golem"] = "undying_flesh_golem";
    /** 隔空取物 */
    DotaAbility["rubick_telekinesis"] = "rubick_telekinesis";
    /** 隔空取物着陆 */
    DotaAbility["rubick_telekinesis_land"] = "rubick_telekinesis_land";
    /** 隔空取物着陆 */
    DotaAbility["rubick_telekinesis_land_self"] = "rubick_telekinesis_land_self";
    /** 弱化能流 */
    DotaAbility["rubick_fade_bolt"] = "rubick_fade_bolt";
    /** 奥术至尊 */
    DotaAbility["rubick_arcane_supremacy"] = "rubick_arcane_supremacy";
    /** 奇心 */
    DotaAbility["rubick_curiosity"] = "rubick_curiosity";
    /** 技能窃取 */
    DotaAbility["rubick_spell_steal"] = "rubick_spell_steal";
    /** 窃取的魔法 */
    DotaAbility["rubick_empty1"] = "rubick_empty1";
    /** 窃取的魔法 */
    DotaAbility["rubick_empty2"] = "rubick_empty2";
    /** 风雷之击 */
    DotaAbility["disruptor_thunder_strike"] = "disruptor_thunder_strike";
    /** 恶念瞥视 */
    DotaAbility["disruptor_glimpse"] = "disruptor_glimpse";
    /** 动能力场 */
    DotaAbility["disruptor_kinetic_field"] = "disruptor_kinetic_field";
    /** 静态风暴 */
    DotaAbility["disruptor_static_storm"] = "disruptor_static_storm";
    /** 动能栅栏 (命石技能) */
    DotaAbility["disruptor_kinetic_fence"] = "disruptor_kinetic_fence";
    /** 电磁排斥 */
    DotaAbility["disruptor_electromagnetic_repulsion"] = "disruptor_electromagnetic_repulsion";
    /** 穿刺 */
    DotaAbility["nyx_assassin_impale"] = "nyx_assassin_impale";
    /** 尖刺外壳 */
    DotaAbility["nyx_assassin_spiked_carapace"] = "nyx_assassin_spiked_carapace";
    /** 复仇 */
    DotaAbility["nyx_assassin_vendetta"] = "nyx_assassin_vendetta";
    /** 钻地 */
    DotaAbility["nyx_assassin_burrow"] = "nyx_assassin_burrow";
    /** 现身 */
    DotaAbility["nyx_assassin_unburrow"] = "nyx_assassin_unburrow";
    /** 神智爆裂 */
    DotaAbility["nyx_assassin_jolt"] = "nyx_assassin_jolt";
    /** 法力燃烧 */
    DotaAbility["nyx_assassin_neuro_sting"] = "nyx_assassin_neuro_sting";
    /** 镜像 */
    DotaAbility["naga_siren_mirror_image"] = "naga_siren_mirror_image";
    /** 诱捕 */
    DotaAbility["naga_siren_ensnare"] = "naga_siren_ensnare";
    /** 激流 (命石技能) */
    DotaAbility["naga_siren_rip_tide"] = "naga_siren_rip_tide";
    /** 海妖之歌 */
    DotaAbility["naga_siren_song_of_the_siren"] = "naga_siren_song_of_the_siren";
    /** 终止海妖之歌 */
    DotaAbility["naga_siren_song_of_the_siren_cancel"] = "naga_siren_song_of_the_siren_cancel";
    /** 洪水 (命石技能) */
    DotaAbility["naga_siren_deluge"] = "naga_siren_deluge";
    /** 鳗鱼皮 */
    DotaAbility["naga_siren_eelskin"] = "naga_siren_eelskin";
    /** 捕捞 */
    DotaAbility["naga_siren_reel_in"] = "naga_siren_reel_in";
    /** 冲击波 */
    DotaAbility["keeper_of_the_light_illuminate"] = "keeper_of_the_light_illuminate";
    /** 释放冲击波 */
    DotaAbility["keeper_of_the_light_illuminate_end"] = "keeper_of_the_light_illuminate_end";
    /** 炎阳之缚 (命石技能) */
    DotaAbility["keeper_of_the_light_radiant_bind"] = "keeper_of_the_light_radiant_bind";
    /** 查克拉魔法 */
    DotaAbility["keeper_of_the_light_chakra_magic"] = "keeper_of_the_light_chakra_magic";
    /** 灵光 */
    DotaAbility["keeper_of_the_light_will_o_wisp"] = "keeper_of_the_light_will_o_wisp";
    /** 灵魂形态 */
    DotaAbility["keeper_of_the_light_spirit_form"] = "keeper_of_the_light_spirit_form";
    /** 召回 (命石技能) */
    DotaAbility["keeper_of_the_light_recall"] = "keeper_of_the_light_recall";
    /** 致盲之光 */
    DotaAbility["keeper_of_the_light_blinding_light"] = "keeper_of_the_light_blinding_light";
    /** 光明速度 */
    DotaAbility["keeper_of_the_light_bright_speed"] = "keeper_of_the_light_bright_speed";
    /** 衡势 */
    DotaAbility["wisp_equilibrium"] = "wisp_equilibrium";
    /** 羁绊 */
    DotaAbility["wisp_tether"] = "wisp_tether";
    /** 断开连接 */
    DotaAbility["wisp_tether_break"] = "wisp_tether_break";
    /** 幽魂 */
    DotaAbility["wisp_spirits"] = "wisp_spirits";
    /** 拉近幽魂 */
    DotaAbility["wisp_spirits_in"] = "wisp_spirits_in";
    /** 拉远幽魂 */
    DotaAbility["wisp_spirits_out"] = "wisp_spirits_out";
    /** 过载 */
    DotaAbility["wisp_overcharge"] = "wisp_overcharge";
    /** 降临 */
    DotaAbility["wisp_relocate"] = "wisp_relocate";
    /** 黑暗契约 */
    DotaAbility["slark_dark_pact"] = "slark_dark_pact";
    /** 突袭 */
    DotaAbility["slark_pounce"] = "slark_pounce";
    /** 能量转移 */
    DotaAbility["slark_essence_shift"] = "slark_essence_shift";
    /** 暗影之舞 */
    DotaAbility["slark_shadow_dance"] = "slark_shadow_dance";
    /** 海浪短刀 */
    DotaAbility["slark_saltwater_shiv"] = "slark_saltwater_shiv";
    /** 深海护罩 */
    DotaAbility["slark_depth_shroud"] = "slark_depth_shroud";
    /** 分裂箭 */
    DotaAbility["medusa_split_shot"] = "medusa_split_shot";
    /** 秘术异蛇 */
    DotaAbility["medusa_mystic_snake"] = "medusa_mystic_snake";
    /** 魔法盾 */
    DotaAbility["medusa_mana_shield"] = "medusa_mana_shield";
    /** 石化凝视 */
    DotaAbility["medusa_stone_gaze"] = "medusa_stone_gaze";
    /** 冷血动物 */
    DotaAbility["medusa_cold_blooded"] = "medusa_cold_blooded";
    /** 罗网箭阵 */
    DotaAbility["medusa_gorgon_grasp"] = "medusa_gorgon_grasp";
    /** 不动如蛇 (命石技能) */
    DotaAbility["medusa_undulation"] = "medusa_undulation";
    /** 狂战士之怒 */
    DotaAbility["troll_warlord_berserkers_rage"] = "troll_warlord_berserkers_rage";
    /** 战斗姿态 */
    DotaAbility["troll_warlord_switch_stance"] = "troll_warlord_switch_stance";
    /** 旋风飞斧（远程） */
    DotaAbility["troll_warlord_whirling_axes_ranged"] = "troll_warlord_whirling_axes_ranged";
    /** 旋风飞斧（近战） */
    DotaAbility["troll_warlord_whirling_axes_melee"] = "troll_warlord_whirling_axes_melee";
    /** 热血战魂 */
    DotaAbility["troll_warlord_fervor"] = "troll_warlord_fervor";
    /** 战斗专注 */
    DotaAbility["troll_warlord_battle_trance"] = "troll_warlord_battle_trance";
    /** 马蹄践踏 */
    DotaAbility["centaur_hoof_stomp"] = "centaur_hoof_stomp";
    /** 双刃剑 */
    DotaAbility["centaur_double_edge"] = "centaur_double_edge";
    /** 反伤 */
    DotaAbility["centaur_return"] = "centaur_return";
    /** 奔袭冲撞 */
    DotaAbility["centaur_stampede"] = "centaur_stampede";
    /** 马到成功 */
    DotaAbility["centaur_work_horse"] = "centaur_work_horse";
    /** 便车 */
    DotaAbility["centaur_mount"] = "centaur_mount";
    /** 开足马力 (命石技能) */
    DotaAbility["centaur_horsepower"] = "centaur_horsepower";
    /** 震荡波 */
    DotaAbility["magnataur_shockwave"] = "magnataur_shockwave";
    /** 授予力量 */
    DotaAbility["magnataur_empower"] = "magnataur_empower";
    /** 巨角冲撞 */
    DotaAbility["magnataur_skewer"] = "magnataur_skewer";
    /** 两极反转 */
    DotaAbility["magnataur_reverse_polarity"] = "magnataur_reverse_polarity";
    /** 长角抛物 */
    DotaAbility["magnataur_horn_toss"] = "magnataur_horn_toss";
    /** 坚固核心 */
    DotaAbility["magnataur_solid_core"] = "magnataur_solid_core";
    /** 死亡旋风 */
    DotaAbility["shredder_whirling_death"] = "shredder_whirling_death";
    /** 伐木锯链 */
    DotaAbility["shredder_timber_chain"] = "shredder_timber_chain";
    /** 活性护甲 */
    DotaAbility["shredder_reactive_armor"] = "shredder_reactive_armor";
    /** 锯齿飞轮 */
    DotaAbility["shredder_chakram"] = "shredder_chakram";
    /** 收回锯齿飞轮 */
    DotaAbility["shredder_return_chakram"] = "shredder_return_chakram";
    /** 喷火装置 */
    DotaAbility["shredder_flamethrower"] = "shredder_flamethrower";
    /** 锯齿轮旋 (命石技能) */
    DotaAbility["shredder_twisted_chakram"] = "shredder_twisted_chakram";
    /** 暴露疗法 */
    DotaAbility["shredder_exposure_therapy"] = "shredder_exposure_therapy";
    /** 粘稠鼻液 */
    DotaAbility["bristleback_viscous_nasal_goo"] = "bristleback_viscous_nasal_goo";
    /** 刺针扫射 */
    DotaAbility["bristleback_quill_spray"] = "bristleback_quill_spray";
    /** 钢毛后背 */
    DotaAbility["bristleback_bristleback"] = "bristleback_bristleback";
    /** 战意 */
    DotaAbility["bristleback_warpath"] = "bristleback_warpath";
    /** 毛团 */
    DotaAbility["bristleback_hairball"] = "bristleback_hairball";
    /** 尖刺在背 */
    DotaAbility["bristleback_prickly"] = "bristleback_prickly";
    /** 寒冰碎片 */
    DotaAbility["tusk_ice_shards"] = "tusk_ice_shards";
    /** 雪球 */
    DotaAbility["tusk_snowball"] = "tusk_snowball";
    /** 雪球滚滚 */
    DotaAbility["tusk_launch_snowball"] = "tusk_launch_snowball";
    /** 摔角行家 (命石技能) */
    DotaAbility["tusk_tag_team"] = "tusk_tag_team";
    /** 酒友 (命石技能) */
    DotaAbility["tusk_drinking_buddies"] = "tusk_drinking_buddies";
    /** 严寒 */
    DotaAbility["tusk_bitter_chill"] = "tusk_bitter_chill";
    /** 海象神拳！ */
    DotaAbility["tusk_walrus_punch"] = "tusk_walrus_punch";
    /** 海象飞踢 */
    DotaAbility["tusk_walrus_kick"] = "tusk_walrus_kick";
    /** 天裔之盾 (命石技能) */
    DotaAbility["skywrath_mage_shield_of_the_scion"] = "skywrath_mage_shield_of_the_scion";
    /** 天裔之杖 (命石技能) */
    DotaAbility["skywrath_mage_staff_of_the_scion"] = "skywrath_mage_staff_of_the_scion";
    /** 奥法鹰隼 */
    DotaAbility["skywrath_mage_arcane_bolt"] = "skywrath_mage_arcane_bolt";
    /** 震荡光弹 */
    DotaAbility["skywrath_mage_concussive_shot"] = "skywrath_mage_concussive_shot";
    /** 上古封印 */
    DotaAbility["skywrath_mage_ancient_seal"] = "skywrath_mage_ancient_seal";
    /** 神秘之耀 */
    DotaAbility["skywrath_mage_mystic_flare"] = "skywrath_mage_mystic_flare";
    /** 迷雾缠绕 */
    DotaAbility["abaddon_death_coil"] = "abaddon_death_coil";
    /** 无光之盾 */
    DotaAbility["abaddon_aphotic_shield"] = "abaddon_aphotic_shield";
    /** 凋零迷雾 */
    DotaAbility["abaddon_withering_mist"] = "abaddon_withering_mist";
    /** 魔霭诅咒 */
    DotaAbility["abaddon_frostmourne"] = "abaddon_frostmourne";
    /** 回光返照 */
    DotaAbility["abaddon_borrowed_time"] = "abaddon_borrowed_time";
    /** 回音重踏 */
    DotaAbility["elder_titan_echo_stomp"] = "elder_titan_echo_stomp";
    /** 灵体游魂 */
    DotaAbility["elder_titan_ancestral_spirit"] = "elder_titan_ancestral_spirit";
    /** 动量 */
    DotaAbility["elder_titan_momentum"] = "elder_titan_momentum";
    /** 灵体游魂回归 */
    DotaAbility["elder_titan_return_spirit"] = "elder_titan_return_spirit";
    /** 移动灵体游魂 */
    DotaAbility["elder_titan_move_spirit"] = "elder_titan_move_spirit";
    /** 自然秩序 */
    DotaAbility["elder_titan_natural_order"] = "elder_titan_natural_order";
    /** 裂地沟壑 */
    DotaAbility["elder_titan_earth_splitter"] = "elder_titan_earth_splitter";
    /** 压倒性优势 */
    DotaAbility["legion_commander_overwhelming_odds"] = "legion_commander_overwhelming_odds";
    /** 强攻 */
    DotaAbility["legion_commander_press_the_attack"] = "legion_commander_press_the_attack";
    /** 勇气之霎 */
    DotaAbility["legion_commander_moment_of_courage"] = "legion_commander_moment_of_courage";
    /** 决斗 */
    DotaAbility["legion_commander_duel"] = "legion_commander_duel";
    /** 迎难而战！ */
    DotaAbility["legion_commander_outfight_them"] = "legion_commander_outfight_them";
    /** 炎阳索 */
    DotaAbility["ember_spirit_searing_chains"] = "ember_spirit_searing_chains";
    /** 无影拳 */
    DotaAbility["ember_spirit_sleight_of_fist"] = "ember_spirit_sleight_of_fist";
    /** 烈火罩 */
    DotaAbility["ember_spirit_flame_guard"] = "ember_spirit_flame_guard";
    /** 献祭心 */
    DotaAbility["ember_spirit_immolation"] = "ember_spirit_immolation";
    /** 激活残焰 */
    DotaAbility["ember_spirit_activate_fire_remnant"] = "ember_spirit_activate_fire_remnant";
    /** 残焰 */
    DotaAbility["ember_spirit_fire_remnant"] = "ember_spirit_fire_remnant";
    /** 巨石冲击 */
    DotaAbility["earth_spirit_boulder_smash"] = "earth_spirit_boulder_smash";
    /** 巨石翻滚 */
    DotaAbility["earth_spirit_rolling_boulder"] = "earth_spirit_rolling_boulder";
    /** 地磁之握 */
    DotaAbility["earth_spirit_geomagnetic_grip"] = "earth_spirit_geomagnetic_grip";
    /** 残岩 */
    DotaAbility["earth_spirit_stone_caller"] = "earth_spirit_stone_caller";
    /** 磁化 */
    DotaAbility["earth_spirit_magnetize"] = "earth_spirit_magnetize";
    /** 残岩魔咒 */
    DotaAbility["earth_spirit_petrify"] = "earth_spirit_petrify";
    /** 火焰风暴 */
    DotaAbility["abyssal_underlord_firestorm"] = "abyssal_underlord_firestorm";
    /** 怨念深渊 */
    DotaAbility["abyssal_underlord_pit_of_malice"] = "abyssal_underlord_pit_of_malice";
    /** 衰退光环 */
    DotaAbility["abyssal_underlord_atrophy_aura"] = "abyssal_underlord_atrophy_aura";
    /** 恶魔之扉 */
    DotaAbility["abyssal_underlord_dark_portal"] = "abyssal_underlord_dark_portal";
    /** 侵略大军 */
    DotaAbility["abyssal_underlord_raid_boss"] = "abyssal_underlord_raid_boss";
    /** 深渊大军 (命石技能) */
    DotaAbility["abyssal_underlord_abyssal_horde"] = "abyssal_underlord_abyssal_horde";
    /** 凤凰冲击 */
    DotaAbility["phoenix_icarus_dive"] = "phoenix_icarus_dive";
    /** 终止凤凰冲击 */
    DotaAbility["phoenix_icarus_dive_stop"] = "phoenix_icarus_dive_stop";
    /** 烈火精灵 */
    DotaAbility["phoenix_fire_spirits"] = "phoenix_fire_spirits";
    /** 发动烈火精灵 */
    DotaAbility["phoenix_launch_fire_spirit"] = "phoenix_launch_fire_spirit";
    /** 烈日炙烤 */
    DotaAbility["phoenix_sun_ray"] = "phoenix_sun_ray";
    /** 终止烈日炙烤 */
    DotaAbility["phoenix_sun_ray_stop"] = "phoenix_sun_ray_stop";
    /** 切换移动状态 */
    DotaAbility["phoenix_sun_ray_toggle_move"] = "phoenix_sun_ray_toggle_move";
    /** 超新星 */
    DotaAbility["phoenix_supernova"] = "phoenix_supernova";
    /** 消逝之光 (命石技能) */
    DotaAbility["phoenix_dying_light"] = "phoenix_dying_light";
    /** 倒影 */
    DotaAbility["terrorblade_reflection"] = "terrorblade_reflection";
    /** 惑幻 */
    DotaAbility["terrorblade_conjure_image"] = "terrorblade_conjure_image";
    /** 魔化 */
    DotaAbility["terrorblade_metamorphosis"] = "terrorblade_metamorphosis";
    /** 魂断 */
    DotaAbility["terrorblade_sunder"] = "terrorblade_sunder";
    /** 怵潮 */
    DotaAbility["terrorblade_terror_wave"] = "terrorblade_terror_wave";
    /** 狂魔 */
    DotaAbility["terrorblade_demon_zeal"] = "terrorblade_demon_zeal";
    /** 暗黑团结 */
    DotaAbility["terrorblade_dark_unity"] = "terrorblade_dark_unity";
    /** 气运之末 */
    DotaAbility["oracle_fortunes_end"] = "oracle_fortunes_end";
    /** 命运敕令 */
    DotaAbility["oracle_fates_edict"] = "oracle_fates_edict";
    /** 涤罪之焰 */
    DotaAbility["oracle_purifying_flames"] = "oracle_purifying_flames";
    /** 虚妄之诺 */
    DotaAbility["oracle_false_promise"] = "oracle_false_promise";
    /** 预言家诅咒 (命石技能) */
    DotaAbility["oracle_clairvoyant_curse"] = "oracle_clairvoyant_curse";
    /** 预言家疗伤 (命石技能) */
    DotaAbility["oracle_clairvoyant_cure"] = "oracle_clairvoyant_cure";
    /** 天命之雨 */
    DotaAbility["oracle_rain_of_destiny"] = "oracle_rain_of_destiny";
    /** 预言 */
    DotaAbility["oracle_prognosticate"] = "oracle_prognosticate";
    /** 占卜师牌组 */
    DotaAbility["oracle_diviners_deck"] = "oracle_diviners_deck";
    /** 感应地雷 */
    DotaAbility["techies_land_mines"] = "techies_land_mines";
    /** 爆破起飞！ */
    DotaAbility["techies_suicide"] = "techies_suicide";
    /** 粘性炸弹 */
    DotaAbility["techies_sticky_bomb"] = "techies_sticky_bomb";
    /** 活性电击 */
    DotaAbility["techies_reactive_tazer"] = "techies_reactive_tazer";
    /** 引爆电击 */
    DotaAbility["techies_reactive_tazer_stop"] = "techies_reactive_tazer_stop";
    /** 引爆同归于尽 */
    DotaAbility["techies_focused_detonate"] = "techies_focused_detonate";
    /** 雷区标识 */
    DotaAbility["techies_minefield_sign"] = "techies_minefield_sign";
    /** 同归于尽 */
    DotaAbility["techies_mutually_assured_destruction"] = "techies_mutually_assured_destruction";
    /** 斯奎的瞄准镜 (命石技能) */
    DotaAbility["techies_squees_scope"] = "techies_squees_scope";
    /** 斯布恩的藏品 (命石技能) */
    DotaAbility["techies_spoons_stash"] = "techies_spoons_stash";
    /** 严寒烧灼 */
    DotaAbility["winter_wyvern_arctic_burn"] = "winter_wyvern_arctic_burn";
    /** 碎裂冲击 */
    DotaAbility["winter_wyvern_splinter_blast"] = "winter_wyvern_splinter_blast";
    /** 极寒之拥 */
    DotaAbility["winter_wyvern_cold_embrace"] = "winter_wyvern_cold_embrace";
    /** 寒冬诅咒 */
    DotaAbility["winter_wyvern_winters_curse"] = "winter_wyvern_winters_curse";
    /** 蓝心精华 (命石技能) */
    DotaAbility["winter_wyvern_essence_of_the_blueheart"] = "winter_wyvern_essence_of_the_blueheart";
    /** 飞龙视野 (命石技能) */
    DotaAbility["winter_wyvern_dragon_sight"] = "winter_wyvern_dragon_sight";
    /** 古龙诗集 */
    DotaAbility["winter_wyvern_eldwurms_edda"] = "winter_wyvern_eldwurms_edda";
    /** 乱流 */
    DotaAbility["arc_warden_flux"] = "arc_warden_flux";
    /** 磁场 */
    DotaAbility["arc_warden_magnetic_field"] = "arc_warden_magnetic_field";
    /** 闪光幽魂 */
    DotaAbility["arc_warden_spark_wraith"] = "arc_warden_spark_wraith";
    /** 风暴双雄 */
    DotaAbility["arc_warden_tempest_double"] = "arc_warden_tempest_double";
    /** 神符灌注 */
    DotaAbility["arc_warden_runic_infusion"] = "arc_warden_runic_infusion";
    /** 丛林之舞 */
    DotaAbility["monkey_king_tree_dance"] = "monkey_king_tree_dance";
    /** 乾坤之跃 */
    DotaAbility["monkey_king_primal_spring"] = "monkey_king_primal_spring";
    /** 马上跃出 */
    DotaAbility["monkey_king_primal_spring_early"] = "monkey_king_primal_spring_early";
    /** 棒击大地 */
    DotaAbility["monkey_king_boundless_strike"] = "monkey_king_boundless_strike";
    /** 如意棒法 */
    DotaAbility["monkey_king_jingu_mastery"] = "monkey_king_jingu_mastery";
    /** 七十二变 */
    DotaAbility["monkey_king_mischief"] = "monkey_king_mischief";
    /** 出神入化 (命石技能) */
    DotaAbility["monkey_king_transfiguration"] = "monkey_king_transfiguration";
    /** 变回原状 */
    DotaAbility["monkey_king_untransform"] = "monkey_king_untransform";
    /** 猴子猴孙 */
    DotaAbility["monkey_king_wukongs_command"] = "monkey_king_wukongs_command";
    /** 荆棘迷宫 */
    DotaAbility["dark_willow_bramble_maze"] = "dark_willow_bramble_maze";
    /** 暗影之境 */
    DotaAbility["dark_willow_shadow_realm"] = "dark_willow_shadow_realm";
    /** 诅咒王冠 */
    DotaAbility["dark_willow_cursed_crown"] = "dark_willow_cursed_crown";
    /** 恐吓 */
    DotaAbility["dark_willow_terrorize"] = "dark_willow_terrorize";
    /** 作祟 */
    DotaAbility["dark_willow_bedlam"] = "dark_willow_bedlam";
    /** 仙灵粉尘 */
    DotaAbility["dark_willow_pixie_dust"] = "dark_willow_pixie_dust";
    /** 虚张声势 */
    DotaAbility["pangolier_swashbuckle"] = "pangolier_swashbuckle";
    /** 甲盾冲击 */
    DotaAbility["pangolier_shield_crash"] = "pangolier_shield_crash";
    /** 幸运一击 */
    DotaAbility["pangolier_lucky_shot"] = "pangolier_lucky_shot";
    /** 天佑勇者 */
    DotaAbility["pangolier_fortune_favors_the_bold"] = "pangolier_fortune_favors_the_bold";
    /** 地雷滚滚 */
    DotaAbility["pangolier_gyroshell"] = "pangolier_gyroshell";
    /** 停止滚动 */
    DotaAbility["pangolier_gyroshell_stop"] = "pangolier_gyroshell_stop";
    /** 卷土重来 */
    DotaAbility["pangolier_rollup"] = "pangolier_rollup";
    /** 中止卷土重来 */
    DotaAbility["pangolier_rollup_stop"] = "pangolier_rollup_stop";
    /** 绝笔 */
    DotaAbility["grimstroke_dark_artistry"] = "grimstroke_dark_artistry";
    /** 戾影 */
    DotaAbility["grimstroke_ink_creature"] = "grimstroke_ink_creature";
    /** 墨涌 */
    DotaAbility["grimstroke_spirit_walk"] = "grimstroke_spirit_walk";
    /** 缚魂 */
    DotaAbility["grimstroke_soul_chain"] = "grimstroke_soul_chain";
    /** 暗绘 */
    DotaAbility["grimstroke_dark_portrait"] = "grimstroke_dark_portrait";
    /** 墨痕 */
    DotaAbility["grimstroke_ink_trail"] = "grimstroke_ink_trail";
    /** 无畏 */
    DotaAbility["mars_dauntless"] = "mars_dauntless";
    /** 战神迅矛 */
    DotaAbility["mars_spear"] = "mars_spear";
    /** 神之谴戒 */
    DotaAbility["mars_gods_rebuke"] = "mars_gods_rebuke";
    /** 护身甲盾 */
    DotaAbility["mars_bulwark"] = "mars_bulwark";
    /** 热血竞技场 */
    DotaAbility["mars_arena_of_blood"] = "mars_arena_of_blood";
    /** 残阴 */
    DotaAbility["void_spirit_aether_remnant"] = "void_spirit_aether_remnant";
    /** 异化 */
    DotaAbility["void_spirit_dissimilate"] = "void_spirit_dissimilate";
    /** 太虚之径 */
    DotaAbility["void_spirit_astral_step"] = "void_spirit_astral_step";
    /** 内在优势 */
    DotaAbility["void_spirit_intrinsic_edge"] = "void_spirit_intrinsic_edge";
    /** 共鸣脉冲 */
    DotaAbility["void_spirit_resonant_pulse"] = "void_spirit_resonant_pulse";
    /** 对称 (命石技能) */
    DotaAbility["void_spirit_symmetry"] = "void_spirit_symmetry";
    /** 电光石火 */
    DotaAbility["snapfire_scatterblast"] = "snapfire_scatterblast";
    /** 龙炎饼干 */
    DotaAbility["snapfire_firesnap_cookie"] = "snapfire_firesnap_cookie";
    /** 猎枪 */
    DotaAbility["snapfire_boomstick"] = "snapfire_boomstick";
    /** 霹雳铁手 */
    DotaAbility["snapfire_lil_shredder"] = "snapfire_lil_shredder";
    /** 蜥蜴绝吻 */
    DotaAbility["snapfire_mortimer_kisses"] = "snapfire_mortimer_kisses";
    /** 血盆大口 */
    DotaAbility["snapfire_gobble_up"] = "snapfire_gobble_up";
    /** 喷吐 */
    DotaAbility["snapfire_spit_creep"] = "snapfire_spit_creep";
    /** 爆栗出击 */
    DotaAbility["hoodwink_acorn_shot"] = "hoodwink_acorn_shot";
    /** 野地奇袭 */
    DotaAbility["hoodwink_bushwhack"] = "hoodwink_bushwhack";
    /** 密林奔走 */
    DotaAbility["hoodwink_scurry"] = "hoodwink_scurry";
    /** 林渊旅人 */
    DotaAbility["hoodwink_mistwoods_wayfarer"] = "hoodwink_mistwoods_wayfarer";
    /** 一箭穿心 */
    DotaAbility["hoodwink_sharpshooter"] = "hoodwink_sharpshooter";
    /** 中止一箭穿心 */
    DotaAbility["hoodwink_sharpshooter_release"] = "hoodwink_sharpshooter_release";
    /** 诱敌奇术 */
    DotaAbility["hoodwink_decoy"] = "hoodwink_decoy";
    /** 猎手旋镖 */
    DotaAbility["hoodwink_hunters_boomerang"] = "hoodwink_hunters_boomerang";
    /** 天光现世 */
    DotaAbility["dawnbreaker_solar_guardian"] = "dawnbreaker_solar_guardian";
    /** 辰星破晓 */
    DotaAbility["dawnbreaker_break_of_dawn"] = "dawnbreaker_break_of_dawn";
    /** 星破天惊 */
    DotaAbility["dawnbreaker_fire_wreath"] = "dawnbreaker_fire_wreath";
    /** 会合 */
    DotaAbility["dawnbreaker_converge"] = "dawnbreaker_converge";
    /** 上界重锤 */
    DotaAbility["dawnbreaker_celestial_hammer"] = "dawnbreaker_celestial_hammer";
    /** 熠熠生辉 */
    DotaAbility["dawnbreaker_luminosity"] = "dawnbreaker_luminosity";
    /** 过肩摔 */
    DotaAbility["marci_grapple"] = "marci_grapple";
    /** 怒拳破 */
    DotaAbility["marci_unleash"] = "marci_unleash";
    /** 回身踢 */
    DotaAbility["marci_companion_run"] = "marci_companion_run";
    /** 特快专递 */
    DotaAbility["marci_special_delivery"] = "marci_special_delivery";
    /** 护卫术 (命石技能) */
    DotaAbility["marci_bodyguard"] = "marci_bodyguard";
    /** 踏 */
    DotaAbility["primal_beast_trample"] = "primal_beast_trample";
    /** 捶 */
    DotaAbility["primal_beast_pulverize"] = "primal_beast_pulverize";
    /** 突 */
    DotaAbility["primal_beast_onslaught"] = "primal_beast_onslaught";
    /** 正在突进 */
    DotaAbility["primal_beast_onslaught_release"] = "primal_beast_onslaught_release";
    /** 砸 */
    DotaAbility["primal_beast_rock_throw"] = "primal_beast_rock_throw";
    /** 咤 */
    DotaAbility["primal_beast_uproar"] = "primal_beast_uproar";
    /** 庞 */
    DotaAbility["primal_beast_colossal"] = "primal_beast_colossal";
    /** 弹无虚发 */
    DotaAbility["muerta_dead_shot"] = "muerta_dead_shot";
    /** 唤魂 */
    DotaAbility["muerta_the_calling"] = "muerta_the_calling";
    /** 越界 */
    DotaAbility["muerta_pierce_the_veil"] = "muerta_pierce_the_veil";
    /** 神枪在手 */
    DotaAbility["muerta_gunslinger"] = "muerta_gunslinger";
    /** 祭台 (命石技能) */
    DotaAbility["muerta_ofrenda"] = "muerta_ofrenda";
    /** 超自然 */
    DotaAbility["muerta_supernatural"] = "muerta_supernatural";
    /** 幽魂子弹 */
    DotaAbility["muerta_spectral_slug"] = "muerta_spectral_slug";
    /** 聚光灯 */
    DotaAbility["ringmaster_spotlight"] = "ringmaster_spotlight";
    /** 驯兽术 */
    DotaAbility["ringmaster_tame_the_beasts"] = "ringmaster_tame_the_beasts";
    /** 鞭打 */
    DotaAbility["ringmaster_tame_the_beasts_crack"] = "ringmaster_tame_the_beasts_crack";
    /** 逃生技 */
    DotaAbility["ringmaster_the_box"] = "ringmaster_the_box";
    /** 奇观轮 */
    DotaAbility["ringmaster_wheel"] = "ringmaster_wheel";
    /** 尖刀戏 */
    DotaAbility["ringmaster_impalement"] = "ringmaster_impalement";
    /** 纪念品栏位 */
    DotaAbility["ringmaster_empty_souvenir"] = "ringmaster_empty_souvenir";
    /** 暗黑狂欢主持 */
    DotaAbility["ringmaster_dark_carnival_souvenirs"] = "ringmaster_dark_carnival_souvenirs";
    /** 哈哈镜 (命石技能) */
    DotaAbility["ringmaster_funhouse_mirror"] = "ringmaster_funhouse_mirror";
    /** 整蛊垫 (命石技能) */
    DotaAbility["ringmaster_whoopee_cushion"] = "ringmaster_whoopee_cushion";
    /** 强力水 (命石技能) */
    DotaAbility["ringmaster_strongman_tonic"] = "ringmaster_strongman_tonic";
    /** 超重派 (命石技能) */
    DotaAbility["ringmaster_weighted_pie"] = "ringmaster_weighted_pie";
    /** 独轮车 (命石技能) */
    DotaAbility["ringmaster_summon_unicycle"] = "ringmaster_summon_unicycle";
    /** 水晶球 (命石技能) */
    DotaAbility["ringmaster_crystal_ball"] = "ringmaster_crystal_ball";
    /** 流派变换 */
    DotaAbility["kez_switch_weapons"] = "kez_switch_weapons";
    /** 回音重斩 */
    DotaAbility["kez_echo_slash"] = "kez_echo_slash";
    /** 制敌爪钩 */
    DotaAbility["kez_grappling_claw"] = "kez_grappling_claw";
    /** 影武长刀 */
    DotaAbility["kez_kazurai_katana"] = "kez_kazurai_katana";
    /** 猛禽之舞 */
    DotaAbility["kez_raptor_dance"] = "kez_raptor_dance";
    /** 天隼冲击 */
    DotaAbility["kez_falcon_rush"] = "kez_falcon_rush";
    /** 利爪飞掷 */
    DotaAbility["kez_talon_toss"] = "kez_talon_toss";
    /** 翔影之钗 */
    DotaAbility["kez_shodo_sai"] = "kez_shodo_sai";
    /** 取消 */
    DotaAbility["kez_shodo_sai_parry_cancel"] = "kez_shodo_sai_parry_cancel";
    /** 渡鸦之纱 */
    DotaAbility["kez_ravens_veil"] = "kez_ravens_veil";
    /** 安可 */
    DotaAbility["largo_encore"] = "largo_encore";
    /** 两栖狂想曲 */
    DotaAbility["largo_amphibian_rhapsody"] = "largo_amphibian_rhapsody";
    /** 巨腹闪电战 */
    DotaAbility["largo_song_fight_song"] = "largo_song_fight_song";
    /** 疾步生风 */
    DotaAbility["largo_song_double_time"] = "largo_song_double_time";
    /** 大屿灵药 */
    DotaAbility["largo_song_good_vibrations"] = "largo_song_good_vibrations";
    /** 蛙力千钧 */
    DotaAbility["largo_frogstomp"] = "largo_frogstomp";
    /** 灵呱一闪 */
    DotaAbility["largo_croak_of_genius"] = "largo_croak_of_genius";
    /** 动人之舐 */
    DotaAbility["largo_catchy_lick"] = "largo_catchy_lick";
})(DotaAbility || (DotaAbility = {}));
/** Dota原生英雄 */
var DotaHero;
(function (DotaHero) {
    /** 敌法师 */
    DotaHero["antimage"] = "npc_dota_hero_antimage";
    /** 痛苦女王 */
    DotaHero["queenofpain"] = "npc_dota_hero_queenofpain";
    /** 莉娜 */
    DotaHero["lina"] = "npc_dota_hero_lina";
    /** 米拉娜 */
    DotaHero["mirana"] = "npc_dota_hero_mirana";
    /** 噬魂鬼 */
    DotaHero["life_stealer"] = "npc_dota_hero_life_stealer";
    /** 自然先知 */
    DotaHero["furion"] = "npc_dota_hero_furion";
    /** 风行者 */
    DotaHero["windrunner"] = "npc_dota_hero_windrunner";
    /** 莱恩 */
    DotaHero["lion"] = "npc_dota_hero_lion";
    /** 复仇之魂 */
    DotaHero["vengefulspirit"] = "npc_dota_hero_vengefulspirit";
    /** 巫医 */
    DotaHero["witch_doctor"] = "npc_dota_hero_witch_doctor";
    /** 拉席克 */
    DotaHero["leshrac"] = "npc_dota_hero_leshrac";
    /** 主宰 */
    DotaHero["juggernaut"] = "npc_dota_hero_juggernaut";
    /** 帕吉 */
    DotaHero["pudge"] = "npc_dota_hero_pudge";
    /** 祸乱之源 */
    DotaHero["bane"] = "npc_dota_hero_bane";
    /** 撼地者 */
    DotaHero["earthshaker"] = "npc_dota_hero_earthshaker";
    /** 沙王 */
    DotaHero["sand_king"] = "npc_dota_hero_sand_king";
    /** 影魔 */
    DotaHero["nevermore"] = "npc_dota_hero_nevermore";
    /** 斯温 */
    DotaHero["sven"] = "npc_dota_hero_sven";
    /** 幻影刺客 */
    DotaHero["phantom_assassin"] = "npc_dota_hero_phantom_assassin";
    /** 冥魂大帝 */
    DotaHero["skeleton_king"] = "npc_dota_hero_skeleton_king";
    /** 卓尔游侠 */
    DotaHero["drow_ranger"] = "npc_dota_hero_drow_ranger";
    /** 变体精灵 */
    DotaHero["morphling"] = "npc_dota_hero_morphling";
    /** 血魔 */
    DotaHero["bloodseeker"] = "npc_dota_hero_bloodseeker";
    /** 斧王 */
    DotaHero["axe"] = "npc_dota_hero_axe";
    /** 幻影长矛手 */
    DotaHero["phantom_lancer"] = "npc_dota_hero_phantom_lancer";
    /** 雷泽 */
    DotaHero["razor"] = "npc_dota_hero_razor";
    /** 风暴之灵 */
    DotaHero["storm_spirit"] = "npc_dota_hero_storm_spirit";
    /** 水晶室女 */
    DotaHero["crystal_maiden"] = "npc_dota_hero_crystal_maiden";
    /** 昆卡 */
    DotaHero["kunkka"] = "npc_dota_hero_kunkka";
    /** 术士 */
    DotaHero["warlock"] = "npc_dota_hero_warlock";
    /** 宙斯 */
    DotaHero["zuus"] = "npc_dota_hero_zuus";
    /** 小小 */
    DotaHero["tiny"] = "npc_dota_hero_tiny";
    /** 帕克 */
    DotaHero["puck"] = "npc_dota_hero_puck";
    /** 戴泽 */
    DotaHero["dazzle"] = "npc_dota_hero_dazzle";
    /** 发条技师 */
    DotaHero["rattletrap"] = "npc_dota_hero_rattletrap";
    /** 巫妖 */
    DotaHero["lich"] = "npc_dota_hero_lich";
    /** 潮汐猎人 */
    DotaHero["tidehunter"] = "npc_dota_hero_tidehunter";
    /** 暗影萨满 */
    DotaHero["shadow_shaman"] = "npc_dota_hero_shadow_shaman";
    /** 力丸 */
    DotaHero["riki"] = "npc_dota_hero_riki";
    /** 谜团 */
    DotaHero["enigma"] = "npc_dota_hero_enigma";
    /** 修补匠 */
    DotaHero["tinker"] = "npc_dota_hero_tinker";
    /** 狙击手 */
    DotaHero["sniper"] = "npc_dota_hero_sniper";
    /** 瘟疫法师 */
    DotaHero["necrolyte"] = "npc_dota_hero_necrolyte";
    /** 斯拉达 */
    DotaHero["slardar"] = "npc_dota_hero_slardar";
    /** 兽王 */
    DotaHero["beastmaster"] = "npc_dota_hero_beastmaster";
    /** 剧毒术士 */
    DotaHero["venomancer"] = "npc_dota_hero_venomancer";
    /** 虚空假面 */
    DotaHero["faceless_void"] = "npc_dota_hero_faceless_void";
    /** 死亡先知 */
    DotaHero["death_prophet"] = "npc_dota_hero_death_prophet";
    /** 帕格纳 */
    DotaHero["pugna"] = "npc_dota_hero_pugna";
    /** 圣堂刺客 */
    DotaHero["templar_assassin"] = "npc_dota_hero_templar_assassin";
    /** 冥界亚龙 */
    DotaHero["viper"] = "npc_dota_hero_viper";
    /** 露娜 */
    DotaHero["luna"] = "npc_dota_hero_luna";
    /** 龙骑士 */
    DotaHero["dragon_knight"] = "npc_dota_hero_dragon_knight";
    /** 黑暗贤者 */
    DotaHero["dark_seer"] = "npc_dota_hero_dark_seer";
    /** 克林克兹 */
    DotaHero["clinkz"] = "npc_dota_hero_clinkz";
    /** 魅惑魔女 */
    DotaHero["enchantress"] = "npc_dota_hero_enchantress";
    /** 全能骑士 */
    DotaHero["omniknight"] = "npc_dota_hero_omniknight";
    /** 哈斯卡 */
    DotaHero["huskar"] = "npc_dota_hero_huskar";
    /** 暗夜魔王 */
    DotaHero["night_stalker"] = "npc_dota_hero_night_stalker";
    /** 育母蜘蛛 */
    DotaHero["broodmother"] = "npc_dota_hero_broodmother";
    /** 赏金猎人 */
    DotaHero["bounty_hunter"] = "npc_dota_hero_bounty_hunter";
    /** 编织者 */
    DotaHero["weaver"] = "npc_dota_hero_weaver";
    /** 杰奇洛 */
    DotaHero["jakiro"] = "npc_dota_hero_jakiro";
    /** 蝙蝠骑士 */
    DotaHero["batrider"] = "npc_dota_hero_batrider";
    /** 陈 */
    DotaHero["chen"] = "npc_dota_hero_chen";
    /** 幽鬼 */
    DotaHero["spectre"] = "npc_dota_hero_spectre";
    /** 末日使者 */
    DotaHero["doom_bringer"] = "npc_dota_hero_doom_bringer";
    /** 远古冰魄 */
    DotaHero["ancient_apparition"] = "npc_dota_hero_ancient_apparition";
    /** 熊战士 */
    DotaHero["ursa"] = "npc_dota_hero_ursa";
    /** 矮人直升机 */
    DotaHero["gyrocopter"] = "npc_dota_hero_gyrocopter";
    /** 裂魂人 */
    DotaHero["spirit_breaker"] = "npc_dota_hero_spirit_breaker";
    /** 炼金术士 */
    DotaHero["alchemist"] = "npc_dota_hero_alchemist";
    /** 祈求者 */
    DotaHero["invoker"] = "npc_dota_hero_invoker";
    /** 沉默术士 */
    DotaHero["silencer"] = "npc_dota_hero_silencer";
    /** 殁境神蚀者 */
    DotaHero["obsidian_destroyer"] = "npc_dota_hero_obsidian_destroyer";
    /** 狼人 */
    DotaHero["lycan"] = "npc_dota_hero_lycan";
    /** 独行德鲁伊 */
    DotaHero["lone_druid"] = "npc_dota_hero_lone_druid";
    /** 酒仙 */
    DotaHero["brewmaster"] = "npc_dota_hero_brewmaster";
    /** 暗影恶魔 */
    DotaHero["shadow_demon"] = "npc_dota_hero_shadow_demon";
    /** 混沌骑士 */
    DotaHero["chaos_knight"] = "npc_dota_hero_chaos_knight";
    /** 食人魔魔法师 */
    DotaHero["ogre_magi"] = "npc_dota_hero_ogre_magi";
    /** 树精卫士 */
    DotaHero["treant"] = "npc_dota_hero_treant";
    /** 米波 */
    DotaHero["meepo"] = "npc_dota_hero_meepo";
    /** 维萨吉 */
    DotaHero["visage"] = "npc_dota_hero_visage";
    /** 不朽尸王 */
    DotaHero["undying"] = "npc_dota_hero_undying";
    /** 拉比克 */
    DotaHero["rubick"] = "npc_dota_hero_rubick";
    /** 干扰者 */
    DotaHero["disruptor"] = "npc_dota_hero_disruptor";
    /** 司夜刺客 */
    DotaHero["nyx_assassin"] = "npc_dota_hero_nyx_assassin";
    /** 娜迦海妖 */
    DotaHero["naga_siren"] = "npc_dota_hero_naga_siren";
    /** 光之守卫 */
    DotaHero["keeper_of_the_light"] = "npc_dota_hero_keeper_of_the_light";
    /** 艾欧 */
    DotaHero["wisp"] = "npc_dota_hero_wisp";
    /** 斯拉克 */
    DotaHero["slark"] = "npc_dota_hero_slark";
    /** 美杜莎 */
    DotaHero["medusa"] = "npc_dota_hero_medusa";
    /** 巨魔战将 */
    DotaHero["troll_warlord"] = "npc_dota_hero_troll_warlord";
    /** 半人马战行者 */
    DotaHero["centaur"] = "npc_dota_hero_centaur";
    /** 马格纳斯 */
    DotaHero["magnataur"] = "npc_dota_hero_magnataur";
    /** 伐木机 */
    DotaHero["shredder"] = "npc_dota_hero_shredder";
    /** 钢背兽 */
    DotaHero["bristleback"] = "npc_dota_hero_bristleback";
    /** 巨牙海民 */
    DotaHero["tusk"] = "npc_dota_hero_tusk";
    /** 天怒法师 */
    DotaHero["skywrath_mage"] = "npc_dota_hero_skywrath_mage";
    /** 亚巴顿 */
    DotaHero["abaddon"] = "npc_dota_hero_abaddon";
    /** 上古巨神 */
    DotaHero["elder_titan"] = "npc_dota_hero_elder_titan";
    /** 军团指挥官 */
    DotaHero["legion_commander"] = "npc_dota_hero_legion_commander";
    /** 灰烬之灵 */
    DotaHero["ember_spirit"] = "npc_dota_hero_ember_spirit";
    /** 大地之灵 */
    DotaHero["earth_spirit"] = "npc_dota_hero_earth_spirit";
    /** 孽主 */
    DotaHero["abyssal_underlord"] = "npc_dota_hero_abyssal_underlord";
    /** 凤凰 */
    DotaHero["phoenix"] = "npc_dota_hero_phoenix";
    /** 恐怖利刃 */
    DotaHero["terrorblade"] = "npc_dota_hero_terrorblade";
    /** 神谕者 */
    DotaHero["oracle"] = "npc_dota_hero_oracle";
    /** 工程师 */
    DotaHero["techies"] = "npc_dota_hero_techies";
    /** 寒冬飞龙 */
    DotaHero["winter_wyvern"] = "npc_dota_hero_winter_wyvern";
    /** 天穹守望者 */
    DotaHero["arc_warden"] = "npc_dota_hero_arc_warden";
    /** 齐天大圣 */
    DotaHero["monkey_king"] = "npc_dota_hero_monkey_king";
    /** 邪影芳灵 */
    DotaHero["dark_willow"] = "npc_dota_hero_dark_willow";
    /** 石鳞剑士 */
    DotaHero["pangolier"] = "npc_dota_hero_pangolier";
    /** 天涯墨客 */
    DotaHero["grimstroke"] = "npc_dota_hero_grimstroke";
    /** 玛尔斯 */
    DotaHero["mars"] = "npc_dota_hero_mars";
    /** 虚无之灵 */
    DotaHero["void_spirit"] = "npc_dota_hero_void_spirit";
    /** 电炎绝手 */
    DotaHero["snapfire"] = "npc_dota_hero_snapfire";
    /** 森海飞霞 */
    DotaHero["hoodwink"] = "npc_dota_hero_hoodwink";
    /** 破晓辰星 */
    DotaHero["dawnbreaker"] = "npc_dota_hero_dawnbreaker";
    /** 玛西 */
    DotaHero["marci"] = "npc_dota_hero_marci";
    /** 獸 */
    DotaHero["primal_beast"] = "npc_dota_hero_primal_beast";
    /** 琼英碧灵 */
    DotaHero["muerta"] = "npc_dota_hero_muerta";
    /** 百戏大王 */
    DotaHero["ringmaster"] = "npc_dota_hero_ringmaster";
    /** 凯 */
    DotaHero["kez"] = "npc_dota_hero_kez";
    /** 朗戈 */
    DotaHero["largo"] = "npc_dota_hero_largo";
})(DotaHero || (DotaHero = {}));
/** Dota原生道具 */
(function (DotaItem) {
    /** 深渊之刃 */
    DotaItem["abyssal_blade"] = "item_abyssal_blade";
    /** 莫尔迪基安的臂章 */
    DotaItem["armlet"] = "item_armlet";
    /** 强袭胸甲 */
    DotaItem["assault"] = "item_assault";
    /** 碎颅锤 */
    DotaItem["basher"] = "item_basher";
    /** 力量腰带 */
    DotaItem["belt_of_strength"] = "item_belt_of_strength";
    /** 狂战斧 */
    DotaItem["bfury"] = "item_bfury";
    /** 黑皇杖 */
    DotaItem["black_king_bar"] = "item_black_king_bar";
    /** 刃甲 */
    DotaItem["blade_mail"] = "item_blade_mail";
    /** 攻击之爪 */
    DotaItem["blades_of_attack"] = "item_blades_of_attack";
    /** 欢欣之刃 */
    DotaItem["blade_of_alacrity"] = "item_blade_of_alacrity";
    /** 闪烁匕首 */
    DotaItem["blink"] = "item_blink";
    /** 血精石 */
    DotaItem["bloodstone"] = "item_bloodstone";
    /** 速度之靴 */
    DotaItem["boots"] = "item_boots";
    /** 精灵布带 */
    DotaItem["boots_of_elves"] = "item_boots_of_elves";
    /** 魔瓶 */
    DotaItem["bottle"] = "item_bottle";
    /** 护腕 */
    DotaItem["bracer"] = "item_bracer";
    /** 铁树枝干 */
    DotaItem["branches"] = "item_branches";
    /** 阔剑 */
    DotaItem["broadsword"] = "item_broadsword";
    /** 玄冥盾牌 */
    DotaItem["buckler"] = "item_buckler";
    /** 蝴蝶 */
    DotaItem["butterfly"] = "item_butterfly";
    /** 锁子甲 */
    DotaItem["chainmail"] = "item_chainmail";
    /** 圆环 */
    DotaItem["circlet"] = "item_circlet";
    /** 王冠 */
    DotaItem["crown"] = "item_crown";
    /** 净化药水 */
    DotaItem["clarity"] = "item_clarity";
    /** 披巾 */
    DotaItem["shawl"] = "item_shawl";
    /** 抗魔斗篷 */
    DotaItem["cloak"] = "item_cloak";
    /** 仙灵之火 */
    DotaItem["faerie_fire"] = "item_faerie_fire";
    /** 凝魂之露 */
    DotaItem["infused_raindrop"] = "item_infused_raindrop";
    /** 风灵之纹 */
    DotaItem["wind_lace"] = "item_wind_lace";
    /** 枯萎之珠 */
    DotaItem["blight_stone"] = "item_blight_stone";
    /** 魔龙枪 */
    DotaItem["dragon_lance"] = "item_dragon_lance";
    /** 以太透镜 */
    DotaItem["aether_lens"] = "item_aether_lens";
    /** 大剑 */
    DotaItem["claymore"] = "item_claymore";
    /** 陨星锤 */
    DotaItem["meteor_hammer"] = "item_meteor_hammer";
    /** 否决坠饰 */
    DotaItem["nullifier"] = "item_nullifier";
    /** 永恒之盘 */
    DotaItem["aeon_disk"] = "item_aeon_disk";
    /** 慧光 */
    DotaItem["kaya"] = "item_kaya";
    /** 散慧对剑 */
    DotaItem["kaya_and_sange"] = "item_kaya_and_sange";
    /** 慧夜对剑 */
    DotaItem["yasha_and_kaya"] = "item_yasha_and_kaya";
    /** 魂之灵瓮 */
    DotaItem["spirit_vessel"] = "item_spirit_vessel";
    /** 精之灵器 */
    DotaItem["essence_distiller"] = "item_essence_distiller";
    /** 赤红甲 */
    DotaItem["crimson_guard"] = "item_crimson_guard";
    /** 圣化护服 */
    DotaItem["consecrated_wraps"] = "item_consecrated_wraps";
    /** 克莱拉牧杖 */
    DotaItem["crellas_crozier"] = "item_crellas_crozier";
    /** 风之杖 */
    DotaItem["wind_waker"] = "item_wind_waker";
    /** eul的神圣法杖 */
    DotaItem["cyclone"] = "item_cyclone";
    /** 达贡之神力 */
    DotaItem["dagon"] = "item_dagon";
    /** 恶魔刀锋 */
    DotaItem["demon_edge"] = "item_demon_edge";
    /** 黯灭 */
    DotaItem["desolator"] = "item_desolator";
    /** 净魂之刃 */
    DotaItem["diffusal_blade"] = "item_diffusal_blade";
    /** 显影之尘 */
    DotaItem["dust"] = "item_dust";
    /** 鹰歌弓 */
    DotaItem["eagle"] = "item_eagle";
    /** 能量之球 */
    DotaItem["energy_booster"] = "item_energy_booster";
    /** 虚灵之刃 */
    DotaItem["ethereal_blade"] = "item_ethereal_blade";
    /** 治疗药膏 */
    DotaItem["flask"] = "item_flask";
    /** 原力法杖 */
    DotaItem["force_staff"] = "item_force_staff";
    /** 力量手套 */
    DotaItem["gauntlets"] = "item_gauntlets";
    /** 真视宝石 */
    DotaItem["gem"] = "item_gem";
    /** 幽魂权杖 */
    DotaItem["ghost"] = "item_ghost";
    /** 加速手套 */
    DotaItem["gloves"] = "item_gloves";
    /** 代达罗斯之殇 */
    DotaItem["greater_crit"] = "item_greater_crit";
    /** 迈达斯之手 */
    DotaItem["hand_of_midas"] = "item_hand_of_midas";
    /** 恢复头巾 */
    DotaItem["headdress"] = "item_headdress";
    /** 恐鳌之心 */
    DotaItem["heart"] = "item_heart";
    /** 铁意头盔 */
    DotaItem["helm_of_iron_will"] = "item_helm_of_iron_will";
    /** 支配头盔 */
    DotaItem["helm_of_the_dominator"] = "item_helm_of_the_dominator";
    /** 统御头盔 */
    DotaItem["helm_of_the_overlord"] = "item_helm_of_the_overlord";
    /** 振奋宝石 */
    DotaItem["hyperstone"] = "item_hyperstone";
    /** 影刃 */
    DotaItem["invis_sword"] = "item_invis_sword";
    /** 白银之锋 */
    DotaItem["silver_edge"] = "item_silver_edge";
    /** 微光披风 */
    DotaItem["glimmer_cape"] = "item_glimmer_cape";
    /** 玲珑心 */
    DotaItem["octarine_core"] = "item_octarine_core";
    /** 魔法芒果 */
    DotaItem["enchanted_mango"] = "item_enchanted_mango";
    /** 清莲宝珠 */
    DotaItem["lotus_orb"] = "item_lotus_orb";
    /** 卫士胫甲 */
    DotaItem["guardian_greaves"] = "item_guardian_greaves";
    /** 炎阳纹章 */
    DotaItem["solar_crest"] = "item_solar_crest";
    /** 标枪 */
    DotaItem["javelin"] = "item_javelin";
    /** 水晶剑 */
    DotaItem["lesser_crit"] = "item_lesser_crit";
    /** 吸血面具 */
    DotaItem["lifesteal"] = "item_lifesteal";
    /** 巫毒面具 */
    DotaItem["voodoo_mask"] = "item_voodoo_mask";
    /** 林肯法球 */
    DotaItem["sphere"] = "item_sphere";
    /** 漩涡 */
    DotaItem["maelstrom"] = "item_maelstrom";
    /** 魔棒 */
    DotaItem["magic_stick"] = "item_magic_stick";
    /** 魔杖 */
    DotaItem["magic_wand"] = "item_magic_wand";
    /** 幻影斧 */
    DotaItem["manta"] = "item_manta";
    /** 智力斗篷 */
    DotaItem["mantle"] = "item_mantle";
    /** 疯狂面具 */
    DotaItem["mask_of_madness"] = "item_mask_of_madness";
    /** 梅肯斯姆 */
    DotaItem["mekansm"] = "item_mekansm";
    /** 秘银锤 */
    DotaItem["mithril_hammer"] = "item_mithril_hammer";
    /** 雷神之锤 */
    DotaItem["mjollnir"] = "item_mjollnir";
    /** 金箍棒 */
    DotaItem["monkey_king_bar"] = "item_monkey_king_bar";
    /** 神秘法杖 */
    DotaItem["mystic_staff"] = "item_mystic_staff";
    /** 空灵挂件 */
    DotaItem["null_talisman"] = "item_null_talisman";
    /** 飓风长戟 */
    DotaItem["hurricane_pike"] = "item_hurricane_pike";
    /** 空明杖 */
    DotaItem["oblivion_staff"] = "item_oblivion_staff";
    /** 巫师之刃 */
    DotaItem["witch_blade"] = "item_witch_blade";
    /** 食人魔之斧 */
    DotaItem["ogre_axe"] = "item_ogre_axe";
    /** 紫怨 */
    DotaItem["orchid"] = "item_orchid";
    /** 血棘 */
    DotaItem["bloodthorn"] = "item_bloodthorn";
    /** 坚韧球 */
    DotaItem["pers"] = "item_pers";
    /** 相位鞋 */
    DotaItem["phase_boots"] = "item_phase_boots";
    /** 洞察烟斗 */
    DotaItem["pipe"] = "item_pipe";
    /** 板甲 */
    DotaItem["platemail"] = "item_platemail";
    /** 精气之球 */
    DotaItem["point_booster"] = "item_point_booster";
    /** 动力鞋 */
    DotaItem["power_treads"] = "item_power_treads";
    /** 短棍 */
    DotaItem["quarterstaff"] = "item_quarterstaff";
    /** 闪电指套 */
    DotaItem["blitz_knuckles"] = "item_blitz_knuckles";
    /** 回音战刃 */
    DotaItem["echo_sabre"] = "item_echo_sabre";
    /** 压制之刃 */
    DotaItem["quelling_blade"] = "item_quelling_blade";
    /** 辉耀 */
    DotaItem["radiance"] = "item_radiance";
    /** 圣剑 */
    DotaItem["rapier"] = "item_rapier";
    /** 掠夺者之斧 */
    DotaItem["reaver"] = "item_reaver";
    /** 刷新球 */
    DotaItem["refresher"] = "item_refresher";
    /** 片甲 */
    DotaItem["splintmail"] = "item_splintmail";
    /** 圣者遗物 */
    DotaItem["relic"] = "item_relic";
    /** 王者之戒 */
    DotaItem["ring_of_basilius"] = "item_ring_of_basilius";
    /** 圣洁吊坠 */
    DotaItem["holy_locket"] = "item_holy_locket";
    /** 治疗指环 */
    DotaItem["ring_of_health"] = "item_ring_of_health";
    /** 守护指环 */
    DotaItem["ring_of_protection"] = "item_ring_of_protection";
    /** 回复戒指 */
    DotaItem["ring_of_regen"] = "item_ring_of_regen";
    /** 恐鳌之戒 */
    DotaItem["ring_of_tarrasque"] = "item_ring_of_tarrasque";
    /** 法师长袍 */
    DotaItem["robe"] = "item_robe";
    /** 阿托斯之棍 */
    DotaItem["rod_of_atos"] = "item_rod_of_atos";
    /** 散华 */
    DotaItem["sange"] = "item_sange";
    /** 天堂之戟 */
    DotaItem["heavens_halberd"] = "item_heavens_halberd";
    /** 散夜对剑 */
    DotaItem["sange_and_yasha"] = "item_sange_and_yasha";
    /** 撒旦之邪力 */
    DotaItem["satanic"] = "item_satanic";
    /** 邪恶镰刀 */
    DotaItem["sheepstick"] = "item_sheepstick";
    /** 希瓦的守护 */
    DotaItem["shivas_guard"] = "item_shivas_guard";
    /** 斯嘉蒂之眼 */
    DotaItem["skadi"] = "item_skadi";
    /** 敏捷便鞋 */
    DotaItem["slippers"] = "item_slippers";
    /** 贤者面罩 */
    DotaItem["sobi_mask"] = "item_sobi_mask";
    /** 振魂石 */
    DotaItem["soul_booster"] = "item_soul_booster";
    /** 灵魂之戒 */
    DotaItem["soul_ring"] = "item_soul_ring";
    /** 魔力法杖 */
    DotaItem["staff_of_wizardry"] = "item_staff_of_wizardry";
    /** 圆盾 */
    DotaItem["stout_shield"] = "item_stout_shield";
    /** 银月之晶 */
    DotaItem["moon_shard"] = "item_moon_shard";
    /** 闪避护符 */
    DotaItem["talisman_of_evasion"] = "item_talisman_of_evasion";
    /** 树之祭祀 */
    DotaItem["tango"] = "item_tango";
    /** 回城卷轴 */
    DotaItem["tpscroll"] = "item_tpscroll";
    /** 宽容之靴 */
    DotaItem["boots_of_bearing"] = "item_boots_of_bearing";
    /** 静谧之鞋 */
    DotaItem["tranquil_boots"] = "item_tranquil_boots";
    /** 远行鞋 */
    DotaItem["travel_boots"] = "item_travel_boots";
    /** 极限法球 */
    DotaItem["ultimate_orb"] = "item_ultimate_orb";
    /** 阿哈利姆神杖 */
    DotaItem["ultimate_scepter"] = "item_ultimate_scepter";
    /** 阿哈利姆魔晶 */
    DotaItem["aghanims_shard"] = "item_aghanims_shard";
    /** 影之灵龛 */
    DotaItem["urn_of_shadows"] = "item_urn_of_shadows";
    /** 巫师帽 */
    DotaItem["wizard_hat"] = "item_wizard_hat";
    /** 毛毛帽 */
    DotaItem["fluffy_hat"] = "item_fluffy_hat";
    /** 猎鹰战刃 */
    DotaItem["falcon_blade"] = "item_falcon_blade";
    /** 法师克星 */
    DotaItem["mage_slayer"] = "item_mage_slayer";
    /** 盛势闪光 */
    DotaItem["overwhelming_blink"] = "item_overwhelming_blink";
    /** 迅疾闪光 */
    DotaItem["swift_blink"] = "item_swift_blink";
    /** 秘奥闪光 */
    DotaItem["arcane_blink"] = "item_arcane_blink";
    /** 先锋盾 */
    DotaItem["vanguard"] = "item_vanguard";
    /** 活力之球 */
    DotaItem["vitality_booster"] = "item_vitality_booster";
    /** 弗拉迪米尔的祭品 */
    DotaItem["vladmir"] = "item_vladmir";
    /** 虚无宝石 */
    DotaItem["void_stone"] = "item_void_stone";
    /** 赛莉蒙妮之冠 */
    DotaItem["tiara_of_selemene"] = "item_tiara_of_selemene";
    /** 侦察守卫 */
    DotaItem["ward_observer"] = "item_ward_observer";
    /** 岗哨守卫 */
    DotaItem["ward_sentry"] = "item_ward_sentry";
    /** 怨灵系带 */
    DotaItem["wraith_band"] = "item_wraith_band";
    /** 夜叉 */
    DotaItem["yasha"] = "item_yasha";
    /** 奥术鞋 */
    DotaItem["arcane_boots"] = "item_arcane_boots";
    /** 淬毒之珠 */
    DotaItem["orb_of_venom"] = "item_orb_of_venom";
    /** 韧鼓 */
    DotaItem["ancient_janggo"] = "item_ancient_janggo";
    /** 诡计之雾 */
    DotaItem["smoke_of_deceit"] = "item_smoke_of_deceit";
    /** 纷争面纱 */
    DotaItem["veil_of_discord"] = "item_veil_of_discord";
    /** 英灵胸针 */
    DotaItem["revenants_brooch"] = "item_revenants_brooch";
    /** 圣斧 */
    DotaItem["devastator"] = "item_devastator";
    /** 暗影护符 */
    DotaItem["shadow_amulet"] = "item_shadow_amulet";
    /** 腐蚀之珠 */
    DotaItem["orb_of_corrosion"] = "item_orb_of_corrosion";
    /** 冰霜之珠 */
    DotaItem["orb_of_frost"] = "item_orb_of_frost";
    /** 缚灵索 */
    DotaItem["gungir"] = "item_gungir";
    /** 行家阵列 */
    DotaItem["specialists_array"] = "item_specialists_array";
    /** 散魂剑 */
    DotaItem["disperser"] = "item_disperser";
    /** 鱼叉 */
    DotaItem["harpoon"] = "item_harpoon";
    /** 灵匣 */
    DotaItem["phylactery"] = "item_phylactery";
    /** 绝刃 */
    DotaItem["angels_demise"] = "item_angels_demise";
    /** 宝冕 */
    DotaItem["diadem"] = "item_diadem";
    /** 血腥榴弹 */
    DotaItem["blood_grenade"] = "item_blood_grenade";
    /** 长盾 */
    DotaItem["pavise"] = "item_pavise";
    /** 怪蛇之息 */
    DotaItem["hydras_breath"] = "item_hydras_breath";
    /** 裂隙之石 */
    DotaItem["chasm_stone"] = "item_chasm_stone";
})(DotaItem || (DotaItem = {}));
/** Dota中立道具 */
(function (NeutralItem) {
    /** 穷鬼盾 */
    NeutralItem["poor_mans_shield"] = "item_poor_mans_shield";
    /** 勇气勋章 */
    NeutralItem["medallion_of_courage"] = "item_medallion_of_courage";
    /** 寂灭 */
    NeutralItem["desolator_2"] = "item_desolator_2";
    /** 网虫腿 */
    NeutralItem["spider_legs"] = "item_spider_legs";
    /** 精华指环 */
    NeutralItem["essence_ring"] = "item_essence_ring";
    /** 冥灵书 */
    NeutralItem["demonicon"] = "item_demonicon";
    /** 天崩 */
    NeutralItem["fallen_sky"] = "item_fallen_sky";
    /** 恶牛角 */
    NeutralItem["minotaur_horn"] = "item_minotaur_horn";
    /** 碎裂背心 */
    NeutralItem["chipped_vest"] = "item_chipped_vest";
    /** 火焰斗篷 */
    NeutralItem["cloak_of_flames"] = "item_cloak_of_flames";
    /** 附魂面具 */
    NeutralItem["possessed_mask"] = "item_possessed_mask";
    /** 杂技玩具 */
    NeutralItem["pogo_stick"] = "item_pogo_stick";
    /** 行巫之祸 */
    NeutralItem["heavy_blade"] = "item_heavy_blade";
    /** 风暴宝器 */
    NeutralItem["stormcrafter"] = "item_stormcrafter";
    /** 通灵头带 */
    NeutralItem["psychic_headband"] = "item_psychic_headband";
    /** 宁静种籽 */
    NeutralItem["seeds_of_serenity"] = "item_seeds_of_serenity";
    /** 玄奥手镯 */
    NeutralItem["occult_bracelet"] = "item_occult_bracelet";
    /** 瑞斯图尔尖匕 */
    NeutralItem["dagger_of_ristul"] = "item_dagger_of_ristul";
    /** 不羁甲壳 */
    NeutralItem["defiant_shell"] = "item_defiant_shell";
    /** 决斗家手套 */
    NeutralItem["duelist_gloves"] = "item_duelist_gloves";
    /** 蒲公英护符 */
    NeutralItem["dandelion_amulet"] = "item_dandelion_amulet";
    /** 回响之笼 */
    NeutralItem["rattlecage"] = "item_rattlecage";
    /** 魔力药水 */
    NeutralItem["mana_draught"] = "item_mana_draught";
    /** 致残之弩 */
    NeutralItem["crippling_crossbow"] = "item_crippling_crossbow";
    /** 火药手套 */
    NeutralItem["gunpowder_gauntlets"] = "item_gunpowder_gauntlets";
    /** 炽热纹章 */
    NeutralItem["searing_signet"] = "item_searing_signet";
    /** 锯齿短刀 */
    NeutralItem["serrated_shiv"] = "item_serrated_shiv";
    /** 蝌蚪护符 */
    NeutralItem["polliwog_charm"] = "item_polliwog_charm";
    /** 不屈之眼 */
    NeutralItem["unrelenting_eye"] = "item_unrelenting_eye";
    /** 狗头人酒杯 */
    NeutralItem["kobold_cup"] = "item_kobold_cup";
    /** 休眠珍品 */
    NeutralItem["dormant_curio"] = "item_dormant_curio";
    /** 基迪花粉袋 */
    NeutralItem["jidi_pollen_bag"] = "item_jidi_pollen_bag";
    /** 德尊血式 */
    NeutralItem["dezun_bloodrite"] = "item_dezun_bloodrite";
    /** 巨人之槌 */
    NeutralItem["giant_maul"] = "item_giant_maul";
    /** 天赐华冠 */
    NeutralItem["divine_regalia"] = "item_divine_regalia";
    /** 咏咒之坠 */
    NeutralItem["spellslinger"] = "item_spellslinger";
    /** 加重骰子 */
    NeutralItem["weighted_dice"] = "item_weighted_dice";
    /** 余烬军团战盾 */
    NeutralItem["ash_legion_shield"] = "item_ash_legion_shield";
    /** 先知灵摆 */
    NeutralItem["prophets_pendulum"] = "item_prophets_pendulum";
    /** 影墟棱晶 */
    NeutralItem["riftshadow_prism"] = "item_riftshadow_prism";
    /** 石羽小包 */
    NeutralItem["stonefeather_satchel"] = "item_stonefeather_satchel";
    /** 变态上颚 */
    NeutralItem["metamorphic_mandible"] = "item_metamorphic_mandible";
    /** 附魔师之椟 */
    NeutralItem["enchanters_bauble"] = "item_enchanters_bauble";
    /** 丝奎奥克神像 */
    NeutralItem["idol_of_screeauk"] = "item_idol_of_screeauk";
    /** 剥皮血囊 */
    NeutralItem["flayers_bota"] = "item_flayers_bota";
    /** 协和 */
    NeutralItem["harmonizer"] = "item_harmonizer";
    /** 咒术师触媒 */
    NeutralItem["conjurers_catalyst"] = "item_conjurers_catalyst";
    /** 采菌套具 */
    NeutralItem["foragers_kit"] = "item_foragers_kit";
    /** 天游烙印 */
    NeutralItem["partisans_brand"] = "item_partisans_brand";
})(NeutralItem || (NeutralItem = {}));
/** Dota中立道具附魔 */
var NeutralEnhancement;
(function (NeutralEnhancement) {
    /** 神秘 */
    NeutralEnhancement["enhancement_mystical"] = "item_enhancement_mystical";
    /** 壮实 */
    NeutralEnhancement["enhancement_brawny"] = "item_enhancement_brawny";
    /** 警觉 */
    NeutralEnhancement["enhancement_alert"] = "item_enhancement_alert";
    /** 坚强 */
    NeutralEnhancement["enhancement_tough"] = "item_enhancement_tough";
    /** 迅速 */
    NeutralEnhancement["enhancement_quickened"] = "item_enhancement_quickened";
    /** 犀利 */
    NeutralEnhancement["enhancement_keen_eyed"] = "item_enhancement_keen_eyed";
    /** 贪婪 */
    NeutralEnhancement["enhancement_greedy"] = "item_enhancement_greedy";
    /** 吸血鬼 */
    NeutralEnhancement["enhancement_vampiric"] = "item_enhancement_vampiric";
    /** 永恒 */
    NeutralEnhancement["enhancement_timeless"] = "item_enhancement_timeless";
    /** 巨神 */
    NeutralEnhancement["enhancement_titanic"] = "item_enhancement_titanic";
    /** 粗暴 */
    NeutralEnhancement["enhancement_crude"] = "item_enhancement_crude";
    /** 狂热 */
    NeutralEnhancement["enhancement_feverish"] = "item_enhancement_feverish";
    /** 捷足 */
    NeutralEnhancement["enhancement_fleetfooted"] = "item_enhancement_fleetfooted";
    /** 冒险 */
    NeutralEnhancement["enhancement_audacious"] = "item_enhancement_audacious";
    /** 进化 */
    NeutralEnhancement["enhancement_evolved"] = "item_enhancement_evolved";
    /** 轻快 */
    NeutralEnhancement["enhancement_nimble"] = "item_enhancement_nimble";
    /** 活力 */
    NeutralEnhancement["enhancement_vital"] = "item_enhancement_vital";
    /** 笨重 */
    NeutralEnhancement["enhancement_hulking"] = "item_enhancement_hulking";
    /** 癫狂 */
    NeutralEnhancement["enhancement_manic"] = "item_enhancement_manic";
})(NeutralEnhancement || (NeutralEnhancement = {}));
var PseudoRandom;
(function (PseudoRandom) {
    PseudoRandom[PseudoRandom["item_mjollnir_fake_shock"] = 1001] = "item_mjollnir_fake_shock";
    PseudoRandom[PseudoRandom["item_mjollnir_fake_chain"] = 1002] = "item_mjollnir_fake_chain";
    PseudoRandom[PseudoRandom["spell_crit"] = 1003] = "spell_crit";
    PseudoRandom[PseudoRandom["strike_critical"] = 1004] = "strike_critical";
    PseudoRandom[PseudoRandom["roushen"] = 1005] = "roushen";
    PseudoRandom[PseudoRandom["bless_10174"] = 1006] = "bless_10174";
    PseudoRandom[PseudoRandom["bless_10176_block"] = 1007] = "bless_10176_block";
    PseudoRandom[PseudoRandom["bless_10201"] = 1008] = "bless_10201";
})(PseudoRandom || (PseudoRandom = {}));
/** 投票值：1 表示同意，-1 表示拒绝，0 表示未选择 */
var TeamShuffleVoteValue;
(function (TeamShuffleVoteValue) {
    /** 同意 */
    TeamShuffleVoteValue[TeamShuffleVoteValue["Agree"] = 1] = "Agree";
    /** 拒绝 */
    TeamShuffleVoteValue[TeamShuffleVoteValue["Reject"] = -1] = "Reject";
    /** 未选择 */
    TeamShuffleVoteValue[TeamShuffleVoteValue["Unselected"] = 0] = "Unselected";
})(TeamShuffleVoteValue || (TeamShuffleVoteValue = {}));
/** 随机分队流程阶段 */
var TeamShufflePhase;
(function (TeamShufflePhase) {
    /** 空闲阶段 */
    TeamShufflePhase["Idle"] = "idle";
    /** 投票阶段 */
    TeamShufflePhase["Vote"] = "vote";
    /** 锁定阶段 */
    TeamShufflePhase["Locked"] = "locked";
    /** 无效局阶段 */
    TeamShufflePhase["Invalid"] = "invalid";
})(TeamShufflePhase || (TeamShufflePhase = {}));
/** 属性符文类型 */
var CustomRuneType;
(function (CustomRuneType) {
    /** 力量（坦克） */
    CustomRuneType["RUNE_TANK"] = "rune_tank";
    /** 力-敏（战士） */
    CustomRuneType["RUNE_WARRIOR"] = "rune_warrior";
    /** 力-智（重法） */
    CustomRuneType["RUNE_MAGIC_TANK"] = "rune_magic_tank";
    /** 敏捷（射手） */
    CustomRuneType["RUNE_ASSASSIN"] = "rune_assassin";
    /** 敏-力（游侠） */
    CustomRuneType["RUNE_RANGER"] = "rune_ranger";
    /** 敏-智（魔剑） */
    CustomRuneType["RUNE_SPELLBLADE"] = "rune_spellblade";
    /** 智力（法师） */
    CustomRuneType["RUNE_WIZARD"] = "rune_wizard";
    /** 智-力（魔战） */
    CustomRuneType["RUNE_MAGIC_WARRIOR"] = "rune_magic_warrior";
    /** 智-敏（灵弓） */
    CustomRuneType["RUNE_MAGIC_ARCHER"] = "rune_magic_archer";
    /** 全才 */
    CustomRuneType["RUNE_UNIVERSAL"] = "rune_universal";
    /** 蓝胖专属傻福（傻福） */
    CustomRuneType["RUNE_OGRE_MAGI"] = "rune_ogre_magi";
    /** 力量_pro（巨灵神） */
    CustomRuneType["RUNE_TANK_PRO"] = "rune_tank_pro";
    /** 力-敏_pro（狂战士） */
    CustomRuneType["RUNE_WARRIOR_PRO"] = "rune_warrior_pro";
    /** 力-智_pro（圣骑士） */
    CustomRuneType["RUNE_MAGIC_TANK_PRO"] = "rune_magic_tank_pro";
    /** 敏捷_pro（神射手） */
    CustomRuneType["RUNE_ASSASSIN_PRO"] = "rune_assassin_pro";
    /** 敏-力_pro（猎魔人） */
    CustomRuneType["RUNE_RANGER_PRO"] = "rune_ranger_pro";
    /** 敏-智_pro（影舞者） */
    CustomRuneType["RUNE_SPELLBLADE_PRO"] = "rune_spellblade_pro";
    /** 智力_pro（大法师） */
    CustomRuneType["RUNE_WIZARD_PRO"] = "rune_wizard_pro";
    /** 智-力_pro（血法师） */
    CustomRuneType["RUNE_MAGIC_WARRIOR_PRO"] = "rune_magic_warrior_pro";
    /** 智-敏_pro（附魔使） */
    CustomRuneType["RUNE_MAGIC_ARCHER_PRO"] = "rune_magic_archer_pro";
    /** 全才_pro（大宗师） */
    CustomRuneType["RUNE_UNIVERSAL_PRO"] = "rune_universal_pro";
    /** 蛇影 */
    CustomRuneType["RUNE_SHADOW_SHAMAN"] = "rune_shadow_shaman";
    /** 盗圣 */
    CustomRuneType["RUNE_BOUNTY_HUNTER"] = "rune_bounty_hunter";
})(CustomRuneType || (CustomRuneType = {}));
var AbilityAmpType;
(function (AbilityAmpType) {
    /** 百分比数值提升 */
    AbilityAmpType["percent_bonus"] = "a";
    /** 固定数值提升 */
    AbilityAmpType["constant_bonus"] = "b";
    /** 初始值覆盖 */
    AbilityAmpType["base_override"] = "c";
})(AbilityAmpType || (AbilityAmpType = {}));
var PurgeType;
(function (PurgeType) {
    /** 无法驱散 */
    PurgeType[PurgeType["UnPurgeable"] = 0] = "UnPurgeable";
    /** 可驱散 */
    PurgeType[PurgeType["Purgeable"] = 1] = "Purgeable";
    /** 仅强驱散 */
    PurgeType[PurgeType["Exception"] = 2] = "Exception";
})(PurgeType || (PurgeType = {}));
var TriggerAbilityType;
(function (TriggerAbilityType) {
    /** 道具技能 */
    TriggerAbilityType[TriggerAbilityType["ITEM_ABILITY"] = 1] = "ITEM_ABILITY";
    /** 单位技能 */
    TriggerAbilityType[TriggerAbilityType["UNIT_ABILITY"] = 2] = "UNIT_ABILITY";
})(TriggerAbilityType || (TriggerAbilityType = {}));
var URLs;
(function (URLs) {
    // 日志
    /** 日志上报 */
    URLs["GameLogSave"] = "/api/game/v1/gameLog/save";
    // 玩家
    /** 玩家登录 */
    URLs["PlayerLogin"] = "/api/game/v1/player/login";
    URLs["PlayerLoginV2"] = "/api/game/v1/player/loginV2";
    /**玩家在线轮询 */
    URLs["PlayerOnlinePing"] = "/api/game/v1/player/onlinePing";
    /**更新玩家设置 */
    URLs["PlayerUpdateSetting"] = "/api/game/v1/player/updateSetting";
    /**领取会员每日奖励 */
    URLs["PlayerReceiveMemberDailyReward"] = "/api/game/v1/player/receiveMemberDailyReward";
    /**设置玩家语言 */
    URLs["PlayerSetLanguage"] = "/api/game/v1/player/setLanguage";
    /** 获取微信公众号绑定二维码 */
    URLs["WechatDotaGameFind"] = "api/game/v1/dotaGame/find";
    /**获取玩家信息 */
    URLs["PlayerGetInfo"] = "/api/game/v1/player/getPlayerInfo";
    /** 玩家登录V3 */
    URLs["PlayerLoginV3"] = "/api/game/v1/player/loginV3";
    //比赛
    /**比赛开始 */
    URLs["MatchStart"] = "/api/game/v1/match/start";
    /** 选择英雄 */
    URLs["MatchPickHero"] = "/api/game/v1/match/pickHero";
    /**刷新英雄消耗 */
    URLs["MatchRefreshHeroCost"] = "/api/game/v1/match/refreshHeroCost";
    /**刷新福佑消耗 */
    URLs["MatchRefreshBlessCost"] = "/api/game/v1/match/refreshBlessCost";
    /**精炼福佑消耗 */
    URLs["MatchRefineBlessCost"] = "/api/game/v1/match/refineBlessCost";
    /**结算 */
    URLs["MatchSettle"] = "/api/game/v1/match/settle";
    /**提交反馈 (点赞举报)*/
    URLs["MatchSubmitFeedback"] = "/api/game/v1/match/submitFeedback";
    /**英雄胜率 */
    URLs["MatchHeroWinRate"] = "/api/game/v1/match/getHeroWinRate";
    /**点赞随机事件 */
    URLs["MatchLikeRandomEvent"] = "/api/game/v1/match/likeRandomEvent";
    /**获取游戏记录 */
    URLs["MatchGetGames"] = "/api/game/v1/match/getGames";
    /**比赛详情 */
    URLs["MatchGetDetail"] = "/api/game/v1/match/getMatchDetail";
    // 邮件
    /** 获取邮件头列表 */
    URLs["MailListHeader"] = "/api/game/v1/mail/listHeader";
    /** 读取邮件 */
    URLs["MailRead"] = "/api/game/v1/mail/read";
    /** 领取附件 */
    URLs["MailReceiveExtraData"] = "/api/game/v1/mail/receiveExtraData";
    /** 一件领取 */
    URLs["MailReceiveAllExtraData"] = "/api/game/v1/mail/receiveAllExtraData";
    /** 删除已读邮件 */
    URLs["MailDeleteRead"] = "/api/game/v1/mail/deleteRead";
    // 订单
    /** 游戏币订单 */
    URLs["OrderBuy"] = "/api/game/v1/order/buy";
    /** 获取商城限购 */
    URLs["OrderGetStoreQuota"] = "/api/game/v1/order/getStoreQuota";
    /** 创建现金订单 */
    URLs["OrderCreateOrderMoney"] = "/api/game/v1/order/createOrderMoney";
    /** 获取现金订单信息 */
    URLs["OrderListOrderMoneyByOrders"] = "/api/game/v1/order/listOrderMoneyByOrders";
    /** 补单 */
    URLs["OrderCheckOrderMoney"] = "/api/game/v1/order/checkOrderMoney";
    // 问题反馈
    /** 提交反馈 */
    URLs["QuestionFeedbackSubmit"] = "/api/game/v1/questionFeedback/submit";
    /**外观穿戴 */
    URLs["AvatarPropUse"] = "/api/game/v1/avatarProp/use";
    /**外观卸下 */
    URLs["AvatarPropUnuse"] = "/api/game/v1/avatarProp/unuse";
    // 服务器配置
    /** 获取服务器配置版本 */
    URLs["ServerSettingGetVersion"] = "/api/game/v1/serverSetting/getVersion";
    /** 根据配置编码获取服务器配置 */
    URLs["ServerSettingGetSettingDetailsBySettingCodes"] = "/api/game/v1/serverSetting/getSettingDetailsBySettingCodes";
    /** 获取所有服务器配置 */
    URLs["ServerSettingGetSettingDetails"] = "/api/game/v1/serverSetting/getSettingDetails";
    /** 兑换激活码 */
    URLs["ActivationCodeActivate"] = "/api/game/v1/activationCode/activate";
    /**获取排行榜 */
    URLs["RankListGet"] = "/api/game/v1/rank/getRankWithPlayer";
    /**获取排行榜奖励 */
    URLs["RankGetSeasonRankReward"] = "/api/game/v1/rank/getSeasonRankReward";
    /**领取排行榜奖励 */
    URLs["RankReceiveSeasonRankReward"] = "/api/game/v1/rank/receiveSeasonRankReward";
    //获取成就
    URLs["AchievementGet"] = "/api/game/v1/achievement/get";
    //领取成就奖励
    URLs["AchievementReceiveReward"] = "/api/game/v1/achievement/receiveReward";
    //添加成就进度
    URLs["AchievementAddProgress"] = "/api/game/v1/achievement/addProgress";
    //获取守卫剑阁2联动信息
    URLs["Activity1Jg2Get"] = "/api/game/v1/activity1Jg2/get";
    //领取守卫剑阁2联动奖励
    URLs["Activity1Jg2ReceiveReward"] = "/api/game/v1/activity1Jg2/receiveReward";
})(URLs || (URLs = {}));
/**
 * 物品类型
 */
var GoodsTypeEnum;
(function (GoodsTypeEnum) {
    /**货币*/
    GoodsTypeEnum[GoodsTypeEnum["MONEY"] = 11] = "MONEY";
    /**材料*/
    GoodsTypeEnum[GoodsTypeEnum["MATERIAL"] = 12] = "MATERIAL";
    /**战斗通行证*/
    GoodsTypeEnum[GoodsTypeEnum["BATTLE_PASS"] = 14] = "BATTLE_PASS";
    /**战斗通行证经验*/
    GoodsTypeEnum[GoodsTypeEnum["BATTLE_PASS_EXP"] = 15] = "BATTLE_PASS_EXP";
    /**特权卡*/
    GoodsTypeEnum[GoodsTypeEnum["VIP_CARD"] = 17] = "VIP_CARD";
    /**普通礼包*/
    GoodsTypeEnum[GoodsTypeEnum["NORMAL_BOX"] = 21] = "NORMAL_BOX";
    /**抽奖礼包*/
    GoodsTypeEnum[GoodsTypeEnum["RANDOM_BOX"] = 22] = "RANDOM_BOX";
    /**自选礼包*/
    GoodsTypeEnum[GoodsTypeEnum["SELECT_BOX"] = 23] = "SELECT_BOX";
    /**即开普通礼包*/
    GoodsTypeEnum[GoodsTypeEnum["AUTO_OPEN_NORMAL_BOX"] = 24] = "AUTO_OPEN_NORMAL_BOX";
    /**即开抽奖礼包*/
    GoodsTypeEnum[GoodsTypeEnum["AUTO_OPEN_RANDOM_BOX"] = 25] = "AUTO_OPEN_RANDOM_BOX";
    /**称号*/
    GoodsTypeEnum[GoodsTypeEnum["TITLE"] = 50] = "TITLE";
    /**头像框 */
    GoodsTypeEnum[GoodsTypeEnum["AVATAR"] = 51] = "AVATAR";
})(GoodsTypeEnum || (GoodsTypeEnum = {}));
/**
 * 付款类型
 */
var CashTypeEnum;
(function (CashTypeEnum) {
    /**支付宝*/
    CashTypeEnum[CashTypeEnum["ALIPAY"] = 1000] = "ALIPAY";
    /**微信*/
    CashTypeEnum[CashTypeEnum["WECHATPAY"] = 2000] = "WECHATPAY";
    /**PAYMENTWALL*/
    CashTypeEnum[CashTypeEnum["PAYMENTWALL"] = 6000] = "PAYMENTWALL";
})(CashTypeEnum || (CashTypeEnum = {}));
var ServerErrorCodeEnum;
(function (ServerErrorCodeEnum) {
    ServerErrorCodeEnum["SYSTEM_ERROR"] = "system_error";
})(ServerErrorCodeEnum || (ServerErrorCodeEnum = {}));
/**
 * 结算称号
 */
var SettlementTitle;
(function (SettlementTitle) {
    /**
     * MVP (胜方唯一)
     * （杀人*4+助攻*2）*（1+a+b+c） - 死亡*3
     * 如果自身伤害占己方总伤害比例超过40%/最高/第二高的人，a=0.25/0.15/0.07
     * 如果自身承伤占己方总承伤比例超过40%/最高/第二高的人，b=0.3/0.18/0.08
     * 如果自身控制时占己方总控时比例超过40%/最高/第二高的人，c=0.12/0.07/0.03
     */
    SettlementTitle[SettlementTitle["MVP"] = 0] = "MVP";
    /**
     * 狂 输出比超过40% (唯一)
     */
    SettlementTitle[SettlementTitle["KUANG"] = 1] = "KUANG";
    /**
     * 破 击杀最多 (唯一)
     */
    SettlementTitle[SettlementTitle["PO"] = 2] = "PO";
    /**
     * 奶 治疗最高 最小10000 (唯一)
     */
    SettlementTitle[SettlementTitle["NAI"] = 3] = "NAI";
    /**
     * 硬 承伤最高，且不为“猛” (唯一)
     */
    SettlementTitle[SettlementTitle["YING"] = 4] = "YING";
    /**
     * 稳 塔伤最高 最小4000 (唯一)
     */
    SettlementTitle[SettlementTitle["WEN"] = 5] = "WEN";
    /**
     * 扶 助攻最多，且不为MVP (唯一)
     */
    SettlementTitle[SettlementTitle["FU"] = 6] = "FU";
    /**
     * 壕 金钱最多 (唯一)
     */
    SettlementTitle[SettlementTitle["HAO"] = 7] = "HAO";
    /**
     * 劳 辅助道具消耗最多 (唯一)
     */
    SettlementTitle[SettlementTitle["LAO"] = 8] = "LAO";
    /**
     * 躺 自己杀人/己方总杀人<=5% (唯一)
     */
    SettlementTitle[SettlementTitle["TANG"] = 9] = "TANG";
    /**
     * 浪 自身击杀和死亡均处于己方前2名，取击杀最高的 (唯一)
     */
    SettlementTitle[SettlementTitle["LANG"] = 10] = "LANG";
    /**
     * 秀 击杀数>=20，击杀数处于己方第一名，死亡数处于倒数前两名（杀的多死得少） (不唯一)
     */
    SettlementTitle[SettlementTitle["XIU"] = 11] = "XIU";
    /**
     * 摆 输出小于5% (不唯一)
     */
    SettlementTitle[SettlementTitle["BAI"] = 12] = "BAI";
    /**
     * 失败方MVP (唯一)
     */
    SettlementTitle[SettlementTitle["SVP"] = 13] = "SVP";
    /**
     * 僵 失败方MVP值最低，且输出不为前2，且承伤不为前2 (唯一)
     */
    SettlementTitle[SettlementTitle["JIANG"] = 14] = "JIANG";
    /**
     * 天秀 击杀数>=25，击杀数处于己方第一名，死亡数处于倒数第一名（杀的多死得少） (不唯一)
     */
    SettlementTitle[SettlementTitle["XIU_2"] = 15] = "XIU_2";
    /**
     * 天之上 击杀数>=30，死亡<=3，击杀数处于己方第一名，死亡数处于倒数第一名（杀的多死得少） (不唯一)
     */
    SettlementTitle[SettlementTitle["XIU_3"] = 16] = "XIU_3";
    /**
     * 控 控制时间最长，且不为“震” (唯一)
     */
    SettlementTitle[SettlementTitle["KONG"] = 17] = "KONG";
    /**
     * 猛 承伤最高，且占己方总承伤比例超过40%
     */
    SettlementTitle[SettlementTitle["MENG"] = 18] = "MENG";
    /**
     * 震 控制时间最长，且占己方总控时比例超过40% 时间不低于300 (唯一)
     */
    SettlementTitle[SettlementTitle["ZHEN"] = 19] = "ZHEN";
    /**
     * 牛 对局结束时，生命值高于50000，且为全场最高，且高于第二名的120%，且承受伤害不低于队伍30%
     */
    SettlementTitle[SettlementTitle["NIU"] = 20] = "NIU";
    /**
     * 攻 对局结束时，攻击力高于1200，且为全场最高，且高于第二名的120%，且伤害不低于队伍30%
     */
    SettlementTitle[SettlementTitle["GONG"] = 21] = "GONG";
    /**
     * 速 对局结束时，攻击速度高于1000，且为全场最高，且高于第二名的120%，且伤害不低于队伍30%
     */
    SettlementTitle[SettlementTitle["SU"] = 22] = "SU";
    /**
     * 法 对局结束时，技能增强高于200%，且为全场最高，且高于第二名的120%，且伤害不低于队伍30%
     */
    SettlementTitle[SettlementTitle["FA"] = 23] = "FA";
    /**
     * 翻 对局前20分钟己方人头数落后于敌方、己方门牙塔先于敌方门牙塔被摧毁、最终获得胜利
     */
    SettlementTitle[SettlementTitle["FAN"] = 24] = "FAN";
    /**
     * 暴 获得过暴走
     */
    SettlementTitle[SettlementTitle["BAO"] = 25] = "BAO";
    /**
     * 团 拥有以下福佑数量最多：10034，10082，10084，10111，10115，10120，10145，10169，10177,最少2个
     */
    SettlementTitle[SettlementTitle["TUAN"] = 26] = "TUAN";
    /**
     * 拆 在己方都是单排，敌方有3/4/5人组队的情况下胜利
     */
    SettlementTitle[SettlementTitle["CHAI"] = 27] = "CHAI";
})(SettlementTitle || (SettlementTitle = {}));
var GameType;
(function (GameType) {
    /** 个人AI */
    GameType[GameType["PERSONAL_AI"] = 1] = "PERSONAL_AI";
    /** 组队练习 */
    GameType[GameType["TEAM_PRACTICE"] = 2] = "TEAM_PRACTICE";
    /** 正常比赛 */
    GameType[GameType["NORMAL_MATCH"] = 3] = "NORMAL_MATCH";
    /** 作弊模式 */
    GameType[GameType["CHEAT_MODE"] = 4] = "CHEAT_MODE";
    /** 系统异常 */
    GameType[GameType["SYSTEM_ERROR"] = 5] = "SYSTEM_ERROR";
    /** 因组队导致的无效局 */
    GameType[GameType["INVALID_PARTY"] = 6] = "INVALID_PARTY";
})(GameType || (GameType = {}));


/***/ },

/***/ "./view/purchase/utils/order_utils.ts"
/*!********************************************!*\
  !*** ./view/purchase/utils/order_utils.ts ***!
  \********************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   CreateCashOrder: () => (/* binding */ CreateCashOrder),
/* harmony export */   checkOrder: () => (/* binding */ checkOrder),
/* harmony export */   findOrder: () => (/* binding */ findOrder)
/* harmony export */ });
/* unused harmony exports CreateGameOrder, ClosePopupPanel, BuyGoods */
/* harmony import */ var _commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! @commonLib/modules/evt/net_event_utils */ "./commonLib/modules/evt/net_event_utils.ts");
/* harmony import */ var _commonLib_utils_window_utils__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @commonLib/utils/window_utils */ "./commonLib/utils/window_utils.ts");
/* harmony import */ var _def_sounds_def__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @def/sounds_def */ "./def/sounds_def.ts");



/**
 * @param key  goodsId
 * @param num
 * @param cashType //现金可以选 支付宝/微信/orpaypal
 */
function CreateCashOrder(goodsId, num, cashType) {
    $.Msg("CreateCashOrder goodsId = ", goodsId, " num = ", num, " cashType = ", cashType);
    (0,_commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__.sendNetEvent)("c2s_order_create_order_money", { key: goodsId, num, cashType });
}
/**
 * @param key  goodsId
 * @param num
 * @param payType -1/2
 */
function CreateGameOrder(goodsId, num, payType, wait) {
    if (wait) {
        (0,_commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__.sendNetEventDebounce)("c2s_order_check_order_money", { key: goodsId, num, payType }, wait);
    }
    else {
        (0,_commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__.sendNetEvent)("c2s_order_check_order_money", { key: goodsId, num, payType });
    }
    (0,_def_sounds_def__WEBPACK_IMPORTED_MODULE_2__.EmitUiSound)(_def_sounds_def__WEBPACK_IMPORTED_MODULE_2__.UiSounds.ui_generic_button_click);
}
function ClosePopupPanel(panel) {
    $.DispatchEvent("UIPopupButtonClicked", panel);
}
function findOrder(orderMoneyUnpaidId) {
    $.Msg("findOrder orderMoneyUnpaidId = ", orderMoneyUnpaidId);
    if (orderMoneyUnpaidId.length == 0) {
        return;
    }
    (0,_commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__.sendNetEvent)("c2s_order_list_order_money_by_orders", { orders: orderMoneyUnpaidId });
}
/**手动补单*/
function checkOrder() {
    (0,_commonLib_modules_evt_net_event_utils__WEBPACK_IMPORTED_MODULE_0__.sendNetEvent)("c2s_order_check_order_money", {});
    (0,_def_sounds_def__WEBPACK_IMPORTED_MODULE_2__.EmitUiSound)(_def_sounds_def__WEBPACK_IMPORTED_MODULE_2__.UiSounds.ui_generic_button_click);
}
/**
 * @param purchaseInfo 购买货物的信息
 */
function BuyGoods(purchaseInfo) {
    (0,_commonLib_utils_window_utils__WEBPACK_IMPORTED_MODULE_1__.OpenPopup)("purchase", purchaseInfo);
}


/***/ },

/***/ "./view/utils/game_localize_utils.ts"
/*!*******************************************!*\
  !*** ./view/utils/game_localize_utils.ts ***!
  \*******************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

"use strict";
/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   GetGoodsNameLocalize: () => (/* binding */ GetGoodsNameLocalize)
/* harmony export */ });
/* unused harmony export GetGoodsDescLocalize */
function GetGoodsNameLocalize(id) {
    var _a, _b;
    if (!id) {
        return "";
    }
    const goodsMgr = (_a = Game === null || Game === void 0 ? void 0 : Game.DataHub) === null || _a === void 0 ? void 0 : _a.GoodsDataMgr;
    return (_b = ((goodsMgr === null || goodsMgr === void 0 ? void 0 : goodsMgr.GetGoodsName(id)) || $.lang(`#goods_name_${id}`))) !== null && _b !== void 0 ? _b : "";
}
function GetGoodsDescLocalize(id) {
    var _a, _b;
    if (!id) {
        return "";
    }
    const goodsMgr = (_a = Game === null || Game === void 0 ? void 0 : Game.DataHub) === null || _a === void 0 ? void 0 : _a.GoodsDataMgr;
    return (_b = ((goodsMgr === null || goodsMgr === void 0 ? void 0 : goodsMgr.GetGoodsDescribe(id)) || $.lang(`#goods_desc_${id}`))) !== null && _b !== void 0 ? _b : "";
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
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Check if module exists (development only)
/******/ 		if (__webpack_modules__[moduleId] === undefined) {
/******/ 			var e = new Error("Cannot find module '" + moduleId + "'");
/******/ 			e.code = 'MODULE_NOT_FOUND';
/******/ 			throw e;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId].call(module.exports, module, module.exports, __webpack_require__);
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
/******/ 			var getter = module && module.__esModule ?
/******/ 				() => (module['default']) :
/******/ 				() => (module);
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
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
var __webpack_exports__ = {};
// This entry needs to be wrapped in an IIFE because it needs to be in strict mode.
(() => {
"use strict";
/*!************************************!*\
  !*** ./view/purchase/purchase.tsx ***!
  \************************************/
/* harmony import */ var react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! react/jsx-runtime */ "../../../node_modules/react/jsx-runtime.js");
/* harmony import */ var _commonLib_ext_dollor_extension__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! @commonLib/ext/dollor_extension */ "./commonLib/ext/dollor_extension.ts");
/* harmony import */ var _commonLib_components_react_encapsulation__WEBPACK_IMPORTED_MODULE_2__ = __webpack_require__(/*! @commonLib/components/react_encapsulation */ "./commonLib/components/react_encapsulation.tsx");
/* harmony import */ var _commonLib_hooks_useLocalEvent__WEBPACK_IMPORTED_MODULE_3__ = __webpack_require__(/*! @commonLib/hooks/useLocalEvent */ "./commonLib/hooks/useLocalEvent.ts");
/* harmony import */ var _commonLib_modules_tooltip_tooltip_utils__WEBPACK_IMPORTED_MODULE_4__ = __webpack_require__(/*! @commonLib/modules/tooltip/tooltip_utils */ "./commonLib/modules/tooltip/tooltip_utils.ts");
/* harmony import */ var _def_order_def__WEBPACK_IMPORTED_MODULE_5__ = __webpack_require__(/*! @def/order_def */ "./def/order_def.ts");
/* harmony import */ var _def_sounds_def__WEBPACK_IMPORTED_MODULE_6__ = __webpack_require__(/*! @def/sounds_def */ "./def/sounds_def.ts");
/* harmony import */ var react__WEBPACK_IMPORTED_MODULE_7__ = __webpack_require__(/*! react */ "../../../node_modules/react/index.js");
/* harmony import */ var _utils_order_utils__WEBPACK_IMPORTED_MODULE_8__ = __webpack_require__(/*! ./utils/order_utils */ "./view/purchase/utils/order_utils.ts");
/* harmony import */ var react_panorama_x__WEBPACK_IMPORTED_MODULE_9__ = __webpack_require__(/*! react-panorama-x */ "../../../node_modules/react-panorama-x/dist/esm/react-panorama.development.js");
/* harmony import */ var _commonLib_components_loading_loading__WEBPACK_IMPORTED_MODULE_10__ = __webpack_require__(/*! @commonLib/components/loading/loading */ "./commonLib/components/loading/loading.tsx");
/* harmony import */ var shared_client_shared_declarations__WEBPACK_IMPORTED_MODULE_11__ = __webpack_require__(/*! shared/client_shared_declarations */ "./shared/client_shared_declarations.ts");
/* harmony import */ var _view_utils_game_localize_utils__WEBPACK_IMPORTED_MODULE_12__ = __webpack_require__(/*! @view/utils/game_localize_utils */ "./view/utils/game_localize_utils.ts");
/* harmony import */ var _commonLib_utils_player_utils__WEBPACK_IMPORTED_MODULE_13__ = __webpack_require__(/*! @commonLib/utils/player_utils */ "./commonLib/utils/player_utils.ts");














function CreateQrCode(container, orderLink) {
    if (container && orderLink) {
        // @ts-ignore
        CreateQRCode(orderLink, container, 226);
    }
}
const orderArr = [];
let timerId = -1;
function PurchasePanel({ purchaseInfo }) {
    var _a, _b, _c, _d;
    $.Msg("PurchasePanel purchaseInfo = ", purchaseInfo);
    const storeInfo = (_b = (_a = Game.DataHub) === null || _a === void 0 ? void 0 : _a.StoreDataMgr) === null || _b === void 0 ? void 0 : _b.GetStoreInfoByKey(purchaseInfo === null || purchaseInfo === void 0 ? void 0 : purchaseInfo.goodsKey);
    const isCash = purchaseInfo.currencyId == 110000;
    (0,react__WEBPACK_IMPORTED_MODULE_7__.useLayoutEffect)(() => {
        if (isCash) {
            $.Msg("PurchasePanel CreateCashOrder", purchaseInfo.goodsKey, purchaseInfo.count, shared_client_shared_declarations__WEBPACK_IMPORTED_MODULE_11__.CashTypeEnum.ALIPAY);
            (0,_utils_order_utils__WEBPACK_IMPORTED_MODULE_8__.CreateCashOrder)(purchaseInfo.goodsKey, purchaseInfo.count, shared_client_shared_declarations__WEBPACK_IMPORTED_MODULE_11__.CashTypeEnum.ALIPAY);
            (0,_utils_order_utils__WEBPACK_IMPORTED_MODULE_8__.CreateCashOrder)(purchaseInfo.goodsKey, purchaseInfo.count, shared_client_shared_declarations__WEBPACK_IMPORTED_MODULE_11__.CashTypeEnum.WECHATPAY);
        }
    }, [isCash, purchaseInfo.count, purchaseInfo.goodsKey]);
    // 订单信息
    (0,react_panorama_x__WEBPACK_IMPORTED_MODULE_9__.useGameEvent)("s2c_order_create_order_money", _ => {
        const data = _.orderMoneyUnpaid;
        // // 生成二维码
        if (!(data === null || data === void 0 ? void 0 : data.isPaid)) {
            if (data.cashType == _def_order_def__WEBPACK_IMPORTED_MODULE_5__.CashPayType.WECHATPAY) {
                CreateQrCode($(`#wechatPayQrCodePage`), data.orderLink);
            }
            else if (data.cashType == _def_order_def__WEBPACK_IMPORTED_MODULE_5__.CashPayType.ALIPAY) {
                CreateQrCode($(`#aliyPayQrCodePage`), data.orderLink);
            }
            else if (data.cashType == _def_order_def__WEBPACK_IMPORTED_MODULE_5__.CashPayType.PAYMENTWALL) {
                $.DispatchEvent("ExternalBrowserGoToURL", data.orderLink); //打开外部浏览器
            }
        }
        if (!orderArr.includes(data.orderNo)) {
            orderArr.push(data.orderNo);
        }
    });
    // 返回的订单信息，如果没有付款那么返回的orderData对象是空的
    (0,react_panorama_x__WEBPACK_IMPORTED_MODULE_9__.useGameEvent)("s2c_service_store_buy_result", orderData => {
        $.Msg(`storeBuyResult-->`, orderData);
        Object.values(orderData).forEach(data => {
            if (data === null || data === void 0 ? void 0 : data.id) {
                _closePanel(); // 一旦查询到，这个页面就可以关闭了
                orderArr.length = 0;
                clearInterval(timerId);
            }
        });
    });
    (0,react__WEBPACK_IMPORTED_MODULE_7__.useEffect)(() => {
        clearInterval(timerId);
        timerId = setInterval(() => {
            (0,_utils_order_utils__WEBPACK_IMPORTED_MODULE_8__.findOrder)(orderArr);
        }, 2000);
        return () => {
            clearInterval(timerId);
        };
    }, []);
    (0,_commonLib_hooks_useLocalEvent__WEBPACK_IMPORTED_MODULE_3__.useLocalEvent)("on_popup_data_change", () => {
        _closePanel(); // 一旦查询到，这个页面就可以关闭了
    });
    const isOverseasActivityPlayer = Game.DataHub.PlayerInfoMgr.IsOverseasActivePlayer();
    if (!(0,_commonLib_utils_player_utils__WEBPACK_IMPORTED_MODULE_13__.isChinese)() && !Game.DataHub.InventoryDataMgr.IsMember() && !isOverseasActivityPlayer) {
        return (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.Fragment, {});
    }
    return ((0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "purchase-panel-wrapper", onactivate: _closePanel }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "purchase-panel", onactivate: () => { } }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, { onactivate: () => {
                        _closePanel();
                        (0,_def_sounds_def__WEBPACK_IMPORTED_MODULE_6__.EmitUiSound)(_def_sounds_def__WEBPACK_IMPORTED_MODULE_6__.UiSounds.ButtonClick);
                    }, className: "purchase-close-btn" }), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { className: "purchase-title", text: $.Localize("#buy_goods") }), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "purchase-preview-desc" }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { className: "name", html: true, text: (0,_view_utils_game_localize_utils__WEBPACK_IMPORTED_MODULE_12__.GetGoodsNameLocalize)((_d = (_c = storeInfo.goodsCfg) === null || _c === void 0 ? void 0 : _c.goodsId) !== null && _d !== void 0 ? _d : 0) }), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { className: "price", visible: isCash, text: purchaseInfo.price + "￥" })] })), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "purchase-buy-info" }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(CashPayment, { purchaseInfo: purchaseInfo }) }))] })) })));
}
/**
 * 主要指的是支付宝和微信121
 * @returns
 */
function CashPayment({ purchaseInfo }) {
    return ((0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "cash-payment" }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { className: "cash-payment-title", text: $.Localize("#cash_payment_title") }), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "cash-payment-container" }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "qr-container" }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "code-bg" }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "qr-code", id: "aliyPayQrCodePage" }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(_commonLib_components_loading_loading__WEBPACK_IMPORTED_MODULE_10__.Loading, {}) })), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, { className: "payment-icon alipay-icon" })] })) })), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "qr-container" }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsxs)(Panel, Object.assign({ className: "code-bg" }, { children: [(0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, Object.assign({ className: "qr-code", id: "wechatPayQrCodePage" }, { children: (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(_commonLib_components_loading_loading__WEBPACK_IMPORTED_MODULE_10__.Loading, {}) })), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Panel, { className: "payment-icon wechatpay-icon" })] })) }))] })), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, { className: "other-payment", text: $.Localize("#other_payment"), onactivate: () => {
                    (0,_utils_order_utils__WEBPACK_IMPORTED_MODULE_8__.CreateCashOrder)(purchaseInfo.goodsKey, purchaseInfo.count, shared_client_shared_declarations__WEBPACK_IMPORTED_MODULE_11__.CashTypeEnum.PAYMENTWALL);
                } }), (0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(Label, Object.assign({ className: "purchase-unreceived-btn", text: $.Localize("#unreceived_tips") }, (0,_commonLib_modules_tooltip_tooltip_utils__WEBPACK_IMPORTED_MODULE_4__.GetTooltipDisplayProp)(`text`, $.lang(`#auto_check_order`)), { onactivate: () => {
                    (0,_utils_order_utils__WEBPACK_IMPORTED_MODULE_8__.checkOrder)();
                } }))] })));
}
// function GameCurrencyPayment({ purchaseInfo }: { purchaseInfo: PurchaseInfo }) {
//     //const storeInfo = Game.DataHub?.StoreDataMgr.GetStoreInfoByKey(purchaseInfo.goodsKey);
//     //let maxBuyCount = (storeInfo?.maxBuyCount ?? 10000) - (storeInfo?.boughtCount ?? 0);
//     let maxBuyCount = 10000;
//     const [state] = useStateIfMounted({
//         count: 1,
//     });
//     const makeRender = useMakeRender();
//     function onCountChanged(count: number) {
//         state.count = count;
//         makeRender();
//     }
//     //const ownCount = Game.DataHub.InventoryDataMgr.GetInventoryCount(purchaseInfo.currencyId ?? 0);
//     const ownCount = 1000000; //测试用，避免买不起
//     const price = purchaseInfo.price ?? 1;
//     const maxCount = Clamp(Math.floor(ownCount / price), 0, maxBuyCount);
//     maxBuyCount = maxCount;
//     const priceNum = (purchaseInfo.price ?? 1) * state.count;
//     //const currencyCount = Game.DataHub.InventoryDataMgr.GetInventoryCount(purchaseInfo.currencyId ?? 0);
//     const currencyCount = 1000000; //测试用，避免买不起
//     //const goodsId = storeInfo.storeCfg.goodsId;
//     const goodsId = 123456;
//     //const goodsType = Game.DataHub.GoodsDataMgr.GetGoodsType(goodsId);
//     const goodsType = 11 as GoodsType;
//     /** vipCard和即开普通宝箱类型不显示图标 */
//     const showGoodsIcon = goodsType != GoodsType.VipCard && goodsType != GoodsType.AutoOpenNormalBox;
//     return (
//         <Panel className="game-currency-payment">
//             {/* <CommonGoods className="goods-item" goodsID={storeInfo.storeCfg.goodsId} count={1} visible={showGoodsIcon} /> */}
//             {/* <CommonGoods className="goods-item" goodsID={goodsId} count={1} visible={showGoodsIcon} /> */}
//             {/* <Label className="purchase-preview-desc" text={GetGoodsDescLocalize(goodsId)} /> */}
//             {/* <Label className="count-limit" text={$.lang(`#store_goods_limit`, { current: storeInfo.boughtCount, maxBuyCount: maxBuyCount })} /> */}
//             <Label className="count-limit" text={$.lang(`#store_goods_limit`, { current: 1, maxBuyCount: maxBuyCount })} />
//             <Image className="goods-item">
//                 <Image className="bg" />
//                 <Image className="icon" />
//                 <Label className="price" text="100" />
//             </Image>
//             <Panel className="game-currency-adjust-container">
//                 <Panel className="purchase-slider-container" visible={true}>
//                     <Panel className="buy-count" visible={true}>
//                         <Label className="count" text={state.count} />
//                     </Panel>
//                     <SliderAdjustment className="purchase-slider" min={1} max={maxBuyCount} onChanged={onCountChanged} value={state.count} />
//                 </Panel>
//             </Panel>
//             <ComExtraButtonGrey
//                 size="280"
//                 color="g"
//                 className="purchase-cancel-button"
//                 text={$.Localize("#equip_cancel")}
//                 onactivate={() => {
//                     _closePanel();
//                     EmitUiSound(UiSounds.ButtonClick);
//                 }}
//             />
//             <ComExtraButton
//                 size="280"
//                 color="g"
//                 enabled={currencyCount >= priceNum}
//                 className="purchase-buy-button"
//                 text={priceNum}
//                 onactivate={() => {
//                     if (state.count > 0) {
//                         CreateGameOrder(purchaseInfo.goodsKey, state.count, purchaseInfo.payType ?? 1, 1000);
//                     }
//                 }}
//             >
//                 <Image className="currency-icon" src={ExtraPathUtils.GoodsIcon(purchaseInfo.currencyId)} />
//             </ComExtraButton>
//         </Panel>
//     );
// }
function _closePanel() {
    $.DispatchEvent("UIPopupButtonClicked", pSelf);
    clearInterval(timerId);
}
const pSelf = $.GetContextPanel();
function onPanelLoad() {
    const purchaseInfo = GameUI.CustomUIConfig().PopupMgr.getData("purchase");
    $.log("purchaseInfo: ", purchaseInfo);
    if (purchaseInfo == null) {
        _closePanel();
        return;
    }
    // addListeners();
    (0,_commonLib_components_react_encapsulation__WEBPACK_IMPORTED_MODULE_2__.EBRender)((0,react_jsx_runtime__WEBPACK_IMPORTED_MODULE_0__.jsx)(PurchasePanel, { purchaseInfo: purchaseInfo }), pSelf);
}
function onPanelCancel() {
    _closePanel();
}
pSelf.SetPanelEvent("onload", onPanelLoad);
pSelf.SetPanelEvent("oncancel", onPanelCancel);

})();

/******/ })()
;