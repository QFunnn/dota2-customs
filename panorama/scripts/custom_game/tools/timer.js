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
    var Timer_1;
    let Timer = Timer_1 = class Timer {
        static Init(bReload) {
            if (bReload) {
                if (undefined != Timer_1.iSchedule) {
                    $.CancelScheduled(Timer_1.iSchedule);
                    Timer_1.iSchedule = $.Schedule(0, Timer_1._Callback);
                }
            }
            tools.EventManager.Reg('ON_LOAD_XML', ({ sEnvName, bReload }) => {
                if (bReload && sEnvName != Timer_1.sEnvName) {
                    Timer_1.StopTimerByEnv(sEnvName);
                }
            });
        }
        static Timer(func, fDelay = -1, id = (++Timer_1.iBindID), sTag) {
            if (undefined == Timer_1.iSchedule) {
                Timer_1.iSchedule = $.Schedule(0, Timer_1._Callback);
            }
            if (0 > fDelay) {
                try {
                    let fDelay2 = func();
                    if (typeof fDelay2 == 'number' && fDelay2 >= 0) {
                        fDelay = fDelay2;
                    }
                    else {
                        return id;
                    }
                }
                catch (error) {
                    GameUI.CustomUIConfig().UploadError(error);
                    return id;
                }
            }
            Timer_1.tCallback[id] = {
                fTime: Game.Time() + fDelay,
                getTime: () => Game.Time(),
                func: func,
                id: id,
                sEnvName: this.sEnvName,
                sTag: sTag,
            };
            return id;
        }
        static GameTimer(func, fDelay = -1, id = (++Timer_1.iBindID), sTag) {
            if (undefined == Timer_1.iSchedule) {
                Timer_1.iSchedule = $.Schedule(0, Timer_1._Callback);
            }
            if (0 > fDelay) {
                try {
                    let fDelay2 = func();
                    if (typeof fDelay2 == 'number' && fDelay2 >= 0) {
                        fDelay = fDelay2;
                    }
                    else {
                        return id;
                    }
                }
                catch (error) {
                    GameUI.CustomUIConfig().UploadError(error);
                    return id;
                }
            }
            Timer_1.tCallback[id] = {
                fTime: Game.GetGameTime() + fDelay,
                getTime: () => Game.GetGameTime(),
                func: func,
                id: id,
                sEnvName: this.sEnvName,
                sTag: sTag,
            };
            return id;
        }
        static StopTimer(id) {
            delete Timer_1.tCallback[id];
        }
        static HasTimer(id) {
            return Timer_1.tCallback[id] != undefined;
        }
        static _Callback() {
            var _a, _b, _c;
            Timer_1.iSchedule = $.Schedule(0, Timer_1._Callback);
            let tTimeDatas = [];
            for (const id in Timer_1.tCallback) {
                let t = Timer_1.tCallback[id];
                if (t.fTime < t.getTime()) {
                    tTimeDatas.push(t);
                }
            }
            for (let i = tTimeDatas.length - 1; i >= 0; --i) {
                let t = Timer_1.tCallback[tTimeDatas[i].id];
                if (t != undefined) {
                    try {
                        let fDelay;
                        if (Timer_1.tTimerDebug != undefined) {
                            const tData = Timer_1.tTimerDebug[(_a = t.sTag) !== null && _a !== void 0 ? _a : t.id] = (_c = Timer_1.tTimerDebug[(_b = t.sTag) !== null && _b !== void 0 ? _b : t.id]) !== null && _c !== void 0 ? _c : {
                                'fDelay': -1,
                                'tOneSecSpend': [],
                                'fSpendMax': 0,
                                'fTime': -1,
                                'sEnvName': t.sEnvName,
                                'tLastSec': {
                                    'last_spend': 0,
                                    'last_time': 0,
                                    'cur_spend': 0,
                                }
                            };
                            if (tData.bPause) {
                                continue;
                            }
                            const fSysTime_Start = new Date().getTime();
                            fDelay = t.func();
                            const fSpend = new Date().getTime() - fSysTime_Start;
                            tData.fSpend = fSpend;
                            tData.fSpendMax = Math.max(fSpend, tData.fSpendMax);
                            tData.fDelay = typeof (fDelay) != 'number' ? -1 : fDelay;
                            tData.fTime = typeof (fDelay) != 'number' ? -1 : t.getTime() + fDelay;
                            tData.tLastSec.cur_spend += fSpend;
                            if (new Date().getTime() - tData.tLastSec.last_time >= 1000) {
                                tData.tLastSec.last_time = new Date().getTime();
                                tData.tLastSec.last_spend = tData.tLastSec.cur_spend;
                                tData.tLastSec.cur_spend = 0;
                            }
                        }
                        else {
                            fDelay = t.func();
                        }
                        if (typeof (fDelay) != 'number') {
                            delete Timer_1.tCallback[t.id];
                        }
                        else {
                            t.fTime = t.getTime() + fDelay;
                        }
                    }
                    catch (error) {
                        delete Timer_1.tCallback[t.id];
                        GameUI.CustomUIConfig().UploadError(error);
                    }
                }
            }
        }
        static StopTimerByEnv(sEnvName) {
            for (const id in Timer_1.tCallback) {
                if (sEnvName == Timer_1.tCallback[id].sEnvName) {
                    delete Timer_1.tCallback[id];
                }
            }
        }
    };
    Timer.tCallback = {};
    Timer.iBindID = 0;
    Timer.sEnvName = $.GetContextPanel().layoutfile;
    Timer = Timer_1 = __decorate([
        reloadlock()
    ], Timer);
    tools.Timer = Timer;
    Timer.StopTimerByEnv($.GetContextPanel().layoutfile);
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;