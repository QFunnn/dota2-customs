--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5e0d361 
  ~ auto-generated — do not edit
]]


/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./commonLib/base/singleton.ts"
/*!*************************************!*\
  !*** ./commonLib/base/singleton.ts ***!
  \*************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   "default": () => (/* binding */ Singleton)
/* harmony export */ });
/**单例基类 */
class Singleton {
    static getInstance() {
        if (!this.instance) {
            this.instance = new this();
        }
        return this.instance;
    }
}


/***/ },

/***/ "./commonLib/modules/evt/local_event_utils.ts"
/*!****************************************************!*\
  !*** ./commonLib/modules/evt/local_event_utils.ts ***!
  \****************************************************/
(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

/* harmony export */ __webpack_require__.d(__webpack_exports__, {
/* harmony export */   onLocalEvent: () => (/* binding */ onLocalEvent)
/* harmony export */ });
/* unused harmony exports emitLocalEvent, onceLocalEvent, offLocalEvent, onLocalEventWithPrecondition, onLocalEventAndDoFirst, clearAllLocalEventListeners, checkAndClearOnReload */
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
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
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
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry needs to be wrapped in an IIFE because it needs to be isolated against other modules in the chunk.
(() => {
/*!**********************************************!*\
  !*** ./commonLib/modules/popup/popup_mgr.ts ***!
  \**********************************************/
/* unused harmony export default */
/* harmony import */ var _base_singleton__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ../../base/singleton */ "./commonLib/base/singleton.ts");
/* harmony import */ var _evt_local_event_utils__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ../evt/local_event_utils */ "./commonLib/modules/evt/local_event_utils.ts");


class PopupMgr extends _base_singleton__WEBPACK_IMPORTED_MODULE_0__["default"] {
    constructor() {
        super(...arguments);
        this._dataKeepMap = new Map();
    }
    keepData(type, data) {
        this._dataKeepMap.set(type, data);
    }
    getData(type) {
        return this._dataKeepMap.get(type);
    }
}
const popupMgr = PopupMgr.getInstance();
(0,_evt_local_event_utils__WEBPACK_IMPORTED_MODULE_1__.onLocalEvent)("popup_window", evt => {
    popupMgr.keepData(evt.type, evt.payload);
    OpenPopupWindow(evt.type);
});
function OpenPopupWindow(type) {
    if (GameUI.CustomUIConfig().PopupSingletonMap[type]) {
        $.DispatchEvent("UIShowCustomLayoutPopup", `popup_${type}`, "");
        return;
    }
    const page = GameUI.CustomUIConfig().PopupXmlPathRec[type];
    if (!page) {
        $.Warning("popup page is undefined, type = ", type);
        return;
    }
    $.Msg("OpenPopupWindow ", type);
    $.DispatchEvent("UIShowCustomLayoutPopupParameters", `popup_${type}`, `file://{resources}/layout/custom_game/${GameUI.CustomUIConfig().PopupXmlPathRec[type]}.xml`, "");
}
GameUI.CustomUIConfig().PopupMgr = popupMgr;
GameUI.CustomUIConfig().PopupXmlPathRec = {};
GameUI.CustomUIConfig().PopupSingletonMap = {};
GameUI.CustomUIConfig().PopupXmlPathRec.purchase = "view/purchase/purchase";
//$.Msg("PopupMgr inited");

})();

/******/ })()
;