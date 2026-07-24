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
    var Mousebinds_1;
    let MousebindsEvent;
    (function (MousebindsEvent) {
        MousebindsEvent[MousebindsEvent["pressed"] = 1] = "pressed";
        MousebindsEvent[MousebindsEvent["doublepressed"] = 2] = "doublepressed";
        MousebindsEvent[MousebindsEvent["wheeled"] = 4] = "wheeled";
        MousebindsEvent[MousebindsEvent["unpressed"] = 8] = "unpressed";
        MousebindsEvent[MousebindsEvent["dragged"] = 16] = "dragged";
        MousebindsEvent[MousebindsEvent["undragged"] = 32] = "undragged";
        MousebindsEvent[MousebindsEvent["_LAST"] = 64] = "_LAST";
        MousebindsEvent[MousebindsEvent["_ALL"] = 63] = "_ALL";
    })(MousebindsEvent || (MousebindsEvent = {}));
    let Mousebinds = Mousebinds_1 = class Mousebinds {
        static Init(bReload) {
            tools.EventManager.Reg('ON_LOAD_XML', ({ sEnvName, bReload }) => {
                if (bReload && sEnvName != Mousebinds_1.sEnvName) {
                    Mousebinds_1.UnbindByEnv(sEnvName);
                }
            });
            GameUI.SetMouseCallback(Mousebinds_1._Callback);
        }
        static Bind(func, type = 8128 | MousebindsEvent._ALL, bindKey = (++Mousebinds_1.iBindID)) {
            if (0 == (type & 8128))
                type |= 8128;
            if (0 == (type & MousebindsEvent._ALL))
                type |= MousebindsEvent._ALL;
            let tCallback = Mousebinds_1.tCallback[type];
            if (undefined == tCallback)
                tCallback = Mousebinds_1.tCallback[type] = {};
            tCallback[bindKey] = {
                func: func,
                bindKey: bindKey,
                sEnvName: this.sEnvName,
            };
            return bindKey;
        }
        static Unbind(bindKey) {
            for (const type in Mousebinds_1.tCallback) {
                const t = Mousebinds_1.tCallback[type];
                if (t[bindKey] != undefined) {
                    delete t[bindKey];
                    return;
                }
            }
        }
        static UnbindByEnv(sEnvName) {
            for (const type in Mousebinds_1.tCallback) {
                const t = Mousebinds_1.tCallback[type];
                for (const bindKey in t) {
                    if (sEnvName == t[bindKey].sEnvName) {
                        delete t[bindKey];
                    }
                }
            }
        }
        static _Callback(sEvent, iBtnNum, tExtraData = {}) {
            let bReturn = false;
            let typeEvent = MousebindsEvent[sEvent];
            let typeBtn;
            if (typeEvent == MousebindsEvent.wheeled) {
                if (-1 == iBtnNum)
                    typeBtn = 4096;
                else
                    typeBtn = 2048;
            }
            else
                typeBtn = 64 << iBtnNum;
            let t = [];
            for (let key in Mousebinds_1.tCallback) {
                let type = Number(key);
                if ((type & typeBtn) != typeBtn || (type & typeEvent) != typeEvent)
                    continue;
                const t2 = Mousebinds_1.tCallback[key];
                for (const i in t2) {
                    t.push([key, t2[i].bindKey]);
                }
            }
            for (let i = t.length - 1; i >= 0; --i) {
                let t2 = Mousebinds_1.tCallback[t[i][0]][t[i][1]];
                if (t2) {
                    let result;
                    try {
                        result = t2.func(sEvent, iBtnNum, tExtraData[i], typeEvent, typeBtn);
                    }
                    catch (error) {
                        GameUI.CustomUIConfig().UploadError(error);
                    }
                    if ('object' == typeof (result)) {
                        tExtraData[i] = result[1];
                        result = result[0];
                    }
                    if (result)
                        bReturn = true;
                }
            }
            if (typeEvent == MousebindsEvent.pressed) {
                let fTimeCheck = 0.075;
                let fTimeCheckCur = 0;
                let vDragBegin = GameUI.GetCursorPosition();
                let fVecCheck = 250;
                let bDrag = false;
                let UpdateCheckMouse = function () {
                    fTimeCheck += 0.01;
                    if (!bDrag) {
                        if (GameUI.IsMouseDown(iBtnNum) && fTimeCheckCur >= fTimeCheck) {
                            bDrag = true;
                        }
                        else {
                            let vCur = GameUI.GetCursorPosition();
                            let fDis = Game.Length2D([vCur[0], vCur[1], 0], [vDragBegin[0], vDragBegin[1], 0]);
                            let fVec = fDis / fTimeCheckCur;
                            if (fVec >= fVecCheck) {
                                bDrag = true;
                            }
                        }
                        if (bDrag) {
                            Mousebinds_1._Callback(MousebindsEvent[MousebindsEvent.dragged], iBtnNum, tExtraData);
                        }
                    }
                    if (!GameUI.IsMouseDown(iBtnNum)) {
                        if (bDrag) {
                            Mousebinds_1._Callback(MousebindsEvent[MousebindsEvent.undragged], iBtnNum, tExtraData);
                        }
                        else if (fTimeCheckCur < fTimeCheck) {
                            Mousebinds_1._Callback(MousebindsEvent[MousebindsEvent.unpressed], iBtnNum, tExtraData);
                        }
                        return;
                    }
                    return 0;
                };
                UpdateCheckMouse();
                tools.Timer.Timer(UpdateCheckMouse, 0, Mousebinds_1.name + typeBtn, 'Mousebinds.UpdateCheckMouse');
            }
            return bReturn;
        }
    };
    Mousebinds.tCallback = {};
    Mousebinds.iBindID = 0;
    Mousebinds.sEnvName = $.GetContextPanel().layoutfile;
    Mousebinds = Mousebinds_1 = __decorate([
        reloadlock()
    ], Mousebinds);
    tools.Mousebinds = Mousebinds;
    Mousebinds.UnbindByEnv($.GetContextPanel().layoutfile);
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;