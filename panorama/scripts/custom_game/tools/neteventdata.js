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
    var NetEventData_1;
    let NetEventData = NetEventData_1 = class NetEventData {
        static Init(bReload) {
            GameEvents.Subscribe('net_event_data', this._OnUpdate.bind(this));
            tools.EventManager.Reg('ON_LOAD_XML', ({ sEnvName, bReload }) => {
                if (bReload && sEnvName != NetEventData_1.sEnvName) {
                    NetEventData_1.UnbindByEnv(sEnvName);
                }
            });
            tools.Timer.Timer(() => {
                const tRefresh = tools.js2lua('NetEvent_CheckTimeout');
                if (tRefresh != undefined) {
                    for (const tSend of tRefresh) {
                        GameEvents.SendCustomGameEventToServer('net_event_refresh', tSend);
                    }
                }
                return 1;
            }, 1, 'NetEventData.CheckTimeout');
            tools.Timer.Timer(() => {
                var _a;
                const tChangeData = tools.js2lua('NetEvent_Callback');
                if (tChangeData != undefined) {
                    for (const sTable in tChangeData) {
                        for (const sKey in tChangeData[sTable]) {
                            if (((_a = NetEventData_1.tData[sTable]) === null || _a === void 0 ? void 0 : _a[sKey]) != undefined) {
                                delete NetEventData_1.tData[sTable][sKey];
                            }
                            NetEventData_1._Callback(sTable, sKey);
                        }
                    }
                }
                return 0;
            }, 0, 'NetEventData.Callback');
        }
        static Bind(sTable, sKey = '', func, bindKey = (++NetEventData_1.iBindID)) {
            let tCallback = NetEventData_1.tCallback[sTable];
            if (tCallback == undefined) {
                tCallback = {};
                NetEventData_1.tCallback[sTable] = tCallback;
            }
            if (tCallback[sKey] == undefined) {
                tCallback[sKey] = {};
            }
            tCallback[sKey][bindKey] = {
                func: func,
                bindKey: bindKey,
                sEnvName: this.sEnvName,
            };
            return bindKey;
        }
        static BindDo(sTable, sKey = '', func, bindKey = (++NetEventData_1.iBindID)) {
            const id = this.Bind(sTable, sKey, func, bindKey);
            if ('' == sKey) {
                for (const tKV of this.GetAllTableValues(sTable)) {
                    try {
                        func(tKV.value, tKV.key, sTable);
                    }
                    catch (error) {
                        GameUI.CustomUIConfig().UploadError(error, `table:${sTable !== null && sTable !== void 0 ? sTable : ''}`);
                    }
                }
            }
            else {
                let t = this.GetTableValue(sTable, sKey);
                try {
                    func(t, sKey, sTable);
                }
                catch (error) {
                    GameUI.CustomUIConfig().UploadError(error, `table:${sTable !== null && sTable !== void 0 ? sTable : ''} key:${(sKey !== null && sKey !== void 0 ? sKey : '')}`);
                }
            }
            return id;
        }
        static Unbind(bindKey, sTable, sKey) {
            if (sTable != undefined) {
                let t = NetEventData_1.tCallback[sTable];
                if (t) {
                    if (sKey) {
                        t = t[sKey];
                        if (t) {
                            delete t[bindKey];
                        }
                    }
                    else {
                        for (const _ in t) {
                            const t2 = t[_];
                            if (t2[bindKey] != undefined) {
                                delete t2[bindKey];
                                return;
                            }
                        }
                    }
                }
            }
            else {
                for (const _ in NetEventData_1.tCallback) {
                    const t = NetEventData_1.tCallback[_];
                    for (const _ in t) {
                        const t2 = t[_];
                        if (t2[bindKey] != undefined) {
                            delete t2[bindKey];
                            return;
                        }
                    }
                }
            }
        }
        static GetAllTableValues(sTable) {
            var _a;
            return (_a = tools.js2lua('NetEvent_GetAllTableValues', { sTable })) !== null && _a !== void 0 ? _a : [];
        }
        static GetTableValue(sTable, sKey) {
            if (NetEventData_1.tData[sTable] == undefined)
                NetEventData_1.tData[sTable] = {};
            if (NetEventData_1.tData[sTable][sKey] == undefined)
                return NetEventData_1.tData[sTable][sKey] = tools.js2lua('NetEvent_GetTableValue', { sTable, sKey });
            return NetEventData_1.tData[sTable][sKey];
        }
        static UnbindByEnv(sEnvName) {
            for (const _ in NetEventData_1.tCallback) {
                const t = NetEventData_1.tCallback[_];
                for (const _ in t) {
                    const t2 = t[_];
                    for (const bindKey in t2) {
                        const t3 = t2[bindKey];
                        if (sEnvName == t3.sEnvName) {
                            delete t2[bindKey];
                        }
                    }
                }
            }
        }
        static _Callback(sTable, sKey) {
            let tTable = NetEventData_1.tCallback[sTable];
            if (tTable == undefined)
                return;
            let funcs = [];
            let tCallback = tTable[sKey];
            if (tCallback != undefined) {
                for (const bindKey in tCallback) {
                    funcs.push([bindKey, tCallback]);
                }
            }
            tCallback = tTable[''];
            if (tCallback != undefined) {
                for (const bindKey in tCallback) {
                    funcs.push([bindKey, tCallback]);
                }
            }
            if (funcs.length > 0) {
                const tData = NetEventData_1.GetTableValue(sTable, sKey);
                for (let i = funcs.length - 1; i >= 0; --i) {
                    let [bindKey, tCallback] = funcs[i];
                    let t = tCallback[bindKey];
                    if (t != undefined) {
                        try {
                            t.func(tData, sKey, sTable);
                        }
                        catch (error) {
                            GameUI.CustomUIConfig().UploadError(error, `table:${sTable !== null && sTable !== void 0 ? sTable : ''} key:${sKey !== null && sKey !== void 0 ? sKey : ''}`);
                        }
                    }
                }
            }
        }
        static _OnUpdate(tEvent) {
            if (tEvent.r) {
                const tReloadingPlayer = JSON.parse(tEvent.r);
                if (tReloadingPlayer[Players.GetLocalPlayer()]) {
                    return;
                }
            }
            GameEvents.SendEventClientSide("net_event_data_local", tEvent);
        }
    };
    NetEventData.tData = {};
    NetEventData.tCallback = {};
    NetEventData.iBindID = 0;
    NetEventData.sEnvName = $.GetContextPanel().layoutfile;
    NetEventData = NetEventData_1 = __decorate([
        reloadlock()
    ], NetEventData);
    tools.NetEventData = NetEventData;
    NetEventData.UnbindByEnv($.GetContextPanel().layoutfile);
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;