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
    var ScreenPanel_1;
    let ScreenPanel = ScreenPanel_1 = class ScreenPanel {
        static render(code, node) { return () => { }; }
        static CreateOnPoint({ content, vPos, fDuration, fInterval, onUpdate, onStart, onEnd, onDestroy, origin = [50, 50], limit_screen, }, bind = ++ScreenPanel_1.iBindID) {
            var _a, _b, _c;
            if (this.pRoot == undefined) {
                this.pRoot = $.CreatePanel('Panel', this.pEnvContextPanel, 'ScreenPanelRoot', {
                    hittest: "false",
                    style: 'width:100%;height:100%;overflow:noclip;z-index:10000;',
                });
            }
            const id = 'ScreenPanel_' + bind;
            if (ScreenPanel_1.tPanels[id] != undefined && ScreenPanel_1.tPanels[id].IsValid()) {
                const fDeleteDelay = (_c = (_b = (_a = ScreenPanel_1.tPanels[id])['onDestroy']) === null || _b === void 0 ? void 0 : _b.call(_a, ScreenPanel_1.tPanels[id])) !== null && _c !== void 0 ? _c : -1;
                GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' destroy');
                GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                    this.render(() => undefined, ScreenPanel_1.tPanels[id]);
                    ScreenPanel_1.tPanels[id].DeleteAsync(-1);
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' create');
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' update');
                }, fDeleteDelay, id + ' delete');
            }
            const pPanel = ScreenPanel_1.tPanels[id] = $.CreatePanel('Panel', this.pRoot, id, {
                class: 'ScreenPanel',
                hittest: "false",
            });
            pPanel.style.opacity = '0.001';
            pPanel['onDestroy'] = onDestroy;
            try {
                this.render(content, pPanel);
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
            }
            const fCheckTime = Game.Time() + 0.1;
            GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                if (pPanel.actuallayoutwidth == 0) {
                    if (Game.Time() > fCheckTime)
                        return;
                    return 0;
                }
                pPanel.style.opacity = '1';
                onStart === null || onStart === void 0 ? void 0 : onStart(pPanel);
                pPanel.SetPositionInPixels(Math.round((vPos[0] - pPanel.actuallayoutwidth * origin[0] * .01) / pPanel.actualuiscale_x), Math.round((vPos[1] - pPanel.actuallayoutheight * origin[1] * .01) / pPanel.actualuiscale_y), 0);
                if (limit_screen) {
                    this.LimitPanelInScreen(pPanel);
                }
                if (fInterval != undefined) {
                    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                        if (onUpdate) {
                            const fNewInterval = onUpdate(pPanel);
                            if (fNewInterval != undefined) {
                                if (fNewInterval < 0)
                                    return;
                                return fNewInterval;
                            }
                        }
                        return fInterval;
                    }, fInterval, id + ' update');
                }
                if (fDuration != undefined) {
                    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                        var _a, _b;
                        if (onEnd) {
                            fDuration = onEnd(pPanel);
                            if (fDuration != undefined && fDuration >= 0) {
                                return fDuration;
                            }
                        }
                        const fDeleteDelay = (_b = (_a = pPanel['onDestroy']) === null || _a === void 0 ? void 0 : _a.call(pPanel, pPanel)) !== null && _b !== void 0 ? _b : -1;
                        GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                            this.render(() => undefined, pPanel);
                            pPanel.DeleteAsync(-1);
                            GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' update');
                        }, fDeleteDelay, id + ' delete');
                    }, fDuration, id + ' destroy');
                }
            }, 0, id + ' create');
            return pPanel;
        }
        static CreateOnPanel({ pTarget, fInterval, align, content, fDuration, onStart, onUpdate, onEnd, onDestroy, origin = [50, 50], limit_screen, }, bind = ++ScreenPanel_1.iBindID) {
            var _a, _b, _c;
            if (this.pRoot == undefined) {
                this.pRoot = $.CreatePanel('Panel', this.pEnvContextPanel, 'ScreenPanelRoot', {
                    hittest: "false",
                    style: 'width:100%;height:100%;overflow:noclip;',
                });
            }
            const id = 'ScreenPanel_' + bind;
            if (ScreenPanel_1.tPanels[id] != undefined && ScreenPanel_1.tPanels[id].IsValid()) {
                const fDeleteDelay = (_c = (_b = (_a = ScreenPanel_1.tPanels[id])['onDestroy']) === null || _b === void 0 ? void 0 : _b.call(_a, ScreenPanel_1.tPanels[id])) !== null && _c !== void 0 ? _c : -1;
                GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' destroy');
                GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                    this.render(() => undefined, ScreenPanel_1.tPanels[id]);
                    ScreenPanel_1.tPanels[id].DeleteAsync(-1);
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' create');
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' update');
                }, fDeleteDelay, id + ' delete');
            }
            const pPanel = ScreenPanel_1.tPanels[id] = $.CreatePanel('Panel', this.pRoot, id, {
                class: 'ScreenPanel',
                hittest: "false",
            });
            pPanel.style.opacity = '0.001';
            pPanel['onDestroy'] = onDestroy;
            try {
                this.render(content, pPanel);
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
            }
            const fCheckTime = Game.Time() + 0.1;
            GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                if (pPanel.actuallayoutwidth == 0) {
                    if (Game.Time() > fCheckTime)
                        return;
                    return 0;
                }
                pPanel.style.opacity = '1';
                onStart === null || onStart === void 0 ? void 0 : onStart(pPanel);
                let vPos = pTarget.GetPositionWithinWindow();
                if (align) {
                    if (align[0] == 'center') {
                        vPos.x = vPos.x + pTarget.actuallayoutwidth * .5;
                    }
                    else if (align[0] == 'right') {
                        vPos.x = vPos.x + pTarget.actuallayoutwidth;
                    }
                    if (align[1] == 'center') {
                        vPos.y = vPos.y + pTarget.actuallayoutheight * .5;
                    }
                    else if (align[1] == 'bottom') {
                        vPos.y = vPos.y + pTarget.actuallayoutheight;
                    }
                }
                else {
                    vPos.x = vPos.x + pTarget.actuallayoutwidth * .5;
                    vPos.y = vPos.y + pTarget.actuallayoutheight * .5;
                }
                pPanel.SetPositionInPixels(Math.round((vPos.x - pPanel.actuallayoutwidth * origin[0] * .01) / pPanel.actualuiscale_x), Math.round((vPos.y - pPanel.actuallayoutheight * origin[1] * .01) / pPanel.actualuiscale_y), 0);
                if (limit_screen) {
                    this.LimitPanelInScreen(pPanel);
                }
                if (fInterval != undefined) {
                    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                        let vPos = pTarget.GetPositionWithinWindow();
                        pPanel.style.visibility = 'visible';
                        if (vPos.x < 0 || vPos.y < 0 || vPos.x > Game.GetScreenWidth() || vPos.y > Game.GetScreenHeight()) {
                            pPanel.style.visibility = 'collapse';
                        }
                        else {
                            if (align) {
                                if (align[0] == 'center') {
                                    vPos.x = vPos.x + pTarget.actuallayoutwidth * .5;
                                }
                                else if (align[0] == 'right') {
                                    vPos.x = vPos.x + pTarget.actuallayoutwidth;
                                }
                                if (align[1] == 'center') {
                                    vPos.y = vPos.y + pTarget.actuallayoutheight * .5;
                                }
                                else if (align[1] == 'bottom') {
                                    vPos.y = vPos.y + pTarget.actuallayoutheight;
                                }
                            }
                            else {
                                vPos.x = vPos.x + pTarget.actuallayoutwidth * .5;
                                vPos.y = vPos.y + pTarget.actuallayoutheight * .5;
                            }
                            pPanel.SetPositionInPixels(Math.round((vPos.x - pPanel.actuallayoutwidth * origin[0] * .01) / pPanel.actualuiscale_x), Math.round((vPos.y - pPanel.actuallayoutheight * origin[1] * .01) / pPanel.actualuiscale_y), 0);
                        }
                        if (onUpdate) {
                            const fNewInterval = onUpdate(pPanel);
                            if (fNewInterval != undefined) {
                                if (fNewInterval < 0)
                                    return;
                                return fNewInterval;
                            }
                        }
                        return fInterval;
                    }, fInterval, id + ' update');
                }
                if (fDuration != undefined) {
                    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                        var _a, _b;
                        if (onEnd) {
                            fDuration = onEnd(pPanel);
                            if (fDuration != undefined && fDuration >= 0) {
                                return fDuration;
                            }
                        }
                        const fDeleteDelay = (_b = (_a = pPanel['onDestroy']) === null || _a === void 0 ? void 0 : _a.call(pPanel, pPanel)) !== null && _b !== void 0 ? _b : -1;
                        GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                            this.render(() => undefined, pPanel);
                            pPanel.DeleteAsync(-1);
                            GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' update');
                        }, fDeleteDelay, id + ' delete');
                    }, fDuration, id + ' destroy');
                }
            }, 0, id + ' create');
            return pPanel;
        }
        static DestroyByPanel(p) {
            var _a, _b;
            if (ScreenPanel_1.tPanels[p.id] != undefined) {
                delete ScreenPanel_1.tPanels[p.id];
                const fDeleteDelay = (_b = (_a = p['onDestroy']) === null || _a === void 0 ? void 0 : _a.call(p, p)) !== null && _b !== void 0 ? _b : -1;
                GameUI.CustomUIConfig().tools.Timer.StopTimer(p.id + ' destroy');
                GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                    this.render(() => undefined, p);
                    p.DeleteAsync(-1);
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(p.id + ' create');
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(p.id + ' update');
                }, fDeleteDelay, p.id + ' delete');
            }
        }
        static DestroyByBind(bind) {
            var _a, _b;
            const id = 'ScreenPanel_' + bind;
            const p = ScreenPanel_1.tPanels[id];
            if (p != undefined) {
                delete ScreenPanel_1.tPanels[id];
                if (p.IsValid()) {
                    const fDeleteDelay = (_b = (_a = p['onDestroy']) === null || _a === void 0 ? void 0 : _a.call(p, p)) !== null && _b !== void 0 ? _b : -1;
                    GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' destroy');
                    GameUI.CustomUIConfig().tools.Timer.Timer(() => {
                        this.render(() => undefined, p);
                        p.DeleteAsync(-1);
                        GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' create');
                        GameUI.CustomUIConfig().tools.Timer.StopTimer(id + ' update');
                    }, fDeleteDelay, id + ' delete');
                }
            }
        }
        static LimitPanelInScreen(pPanel) {
            const vPosCur = pPanel.GetPositionWithinWindow();
            let fOffsetX;
            let fOffsetY;
            if (vPosCur.x < 0) {
                fOffsetX = -vPosCur.x;
            }
            else if ((vPosCur.x + pPanel.actuallayoutwidth) > Game.GetScreenWidth()) {
                fOffsetX = Game.GetScreenWidth() - (vPosCur.x + pPanel.actuallayoutwidth);
            }
            if (vPosCur.y < 0) {
                fOffsetY = -vPosCur.y;
            }
            else if ((vPosCur.y + pPanel.actuallayoutheight) > Game.GetScreenHeight()) {
                fOffsetY = Game.GetScreenHeight() - (vPosCur.y + pPanel.actuallayoutheight);
            }
            if (fOffsetX != undefined || fOffsetY != undefined) {
                if (fOffsetX != undefined)
                    vPosCur.x = vPosCur.x + fOffsetX;
                if (fOffsetY != undefined)
                    vPosCur.y = vPosCur.y + fOffsetY;
                pPanel.SetPositionInPixels(Math.round(vPosCur.x / pPanel.actualuiscale_x), Math.round(vPosCur.y / pPanel.actualuiscale_y), 0);
            }
        }
    };
    ScreenPanel.iBindID = 0;
    ScreenPanel.tPanels = {};
    ScreenPanel = ScreenPanel_1 = __decorate([
        reloadlock()
    ], ScreenPanel);
    tools.ScreenPanel = ScreenPanel;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;