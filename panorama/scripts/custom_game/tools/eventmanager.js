--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


var global = this;
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


function __decorate(decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
}

function reloadlock() {
    return (c) => {
        var _a;
        let __reloadlock__ = GameUI.CustomUIConfig().__reloadlock__ = (_a = GameUI.CustomUIConfig().__reloadlock__) !== null && _a !== void 0 ? _a : {};
        if (__reloadlock__[c.name] == undefined) {
            __reloadlock__[c.name] = c;
            return c;
        }
        let C = __reloadlock__[c.name];
        for (const k of Object.getOwnPropertyNames(c)) {
            let v = c[k];
            if (C[k] == undefined || typeof (v) == 'function') {
                C[k] = v;
            }
        }
        if (c.prototype) {
            if (C.prototype == undefined) {
                C.prototype = c.prototype;
            }
            else {
                for (const k of Object.getOwnPropertyNames(c.prototype)) {
                    let v = c.prototype[k];
                    if (C.prototype[k] == undefined || typeof (v) == 'function') {
                        C.prototype[k] = v;
                    }
                }
            }
        }
        return C;
    };
}

var tools;
(function (tools) {
    var EventManager_1;
    let EventManager = EventManager_1 = class EventManager {
        static Init(bReload) {
            EventManager_1.Reg('ON_LOAD_XML', ({ sEnvName, bReload }) => {
                if (bReload && sEnvName != EventManager_1.sEnvName) {
                    EventManager_1.UnregEnv(sEnvName);
                }
            });
        }
        static Reg(sEvent, func, bindKey, iOrder = 1) {
            if (bindKey == undefined) {
                bindKey = ++EventManager_1.iBindID;
            }
            else {
                EventManager_1.Unreg(sEvent, bindKey);
            }
            let t = EventManager_1.tData[sEvent];
            if (t == undefined) {
                t = [];
                EventManager_1.tData[sEvent] = t;
            }
            for (let i = t.length - 1; i >= 0; --i) {
                if (t[i][2] <= iOrder) {
                    t.splice(i + 1, 0, [func, bindKey, iOrder, this.sEnvName]);
                    return bindKey;
                }
            }
            t.splice(0, 0, [func, bindKey, iOrder, this.sEnvName]);
            return bindKey;
        }
        static Unreg(sEvent, bindKey) {
            let t = EventManager_1.tData[sEvent];
            if (t == undefined)
                return;
            for (let i = 0; i < t.length; ++i) {
                const v = t[i];
                if (v[1] == bindKey) {
                    t.splice(i, 1);
                    return true;
                }
            }
            return false;
        }
        static Fire(sEvent, event) {
            if (EventManager_1.tLockFire != undefined) {
                EventManager_1.tLockFire.push([sEvent, event]);
                return;
            }
            let t = EventManager_1.tData[sEvent];
            if (t == undefined)
                return;
            let t2 = [...t];
            for (let i = t2.length - 1; i >= 0; --i) {
                let [func, bindKey] = t2[i];
                if (typeof (bindKey) == 'object') {
                    try {
                        if (func.call(bindKey, event)) {
                            t.splice(i, 1);
                        }
                    }
                    catch (error) {
                        GameUI.CustomUIConfig().UploadError(error, `event:${sEvent !== null && sEvent !== void 0 ? sEvent : ''}`);
                    }
                }
                else {
                    try {
                        if (func(event)) {
                            t.splice(i, 1);
                        }
                    }
                    catch (error) {
                        GameUI.CustomUIConfig().UploadError(error, `event:${sEvent !== null && sEvent !== void 0 ? sEvent : ''}`);
                    }
                }
            }
        }
        static Lock() {
            if (EventManager_1.tLockFire == undefined) {
                EventManager_1.tLockFire = [];
            }
        }
        static Unlock() {
            if (EventManager_1.tLockFire == undefined)
                return;
            let t = EventManager_1.tLockFire;
            EventManager_1.tLockFire = undefined;
            for (const v of t) {
                EventManager_1.Fire(v[0], v[1]);
            }
        }
        static UnregEnv(sEnvName) {
            for (const k in EventManager_1.tData) {
                let t = EventManager_1.tData[k];
                for (let i = t.length - 1; i >= 0; --i) {
                    const v = t[i];
                    if (v[3] == sEnvName) {
                        t.splice(i, 1);
                    }
                }
            }
        }
    };
    EventManager.iBindID = 0;
    EventManager.tData = {};
    EventManager.sEnvName = $.GetContextPanel().layoutfile;
    EventManager = EventManager_1 = __decorate([
        reloadlock()
    ], EventManager);
    tools.EventManager = EventManager;
    EventManager.UnregEnv($.GetContextPanel().layoutfile);
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;