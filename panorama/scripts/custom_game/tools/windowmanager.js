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

const DragDropToDragTypes = {
    'Floor': [],
    'PublicPack': ['PackItem', 'GameItem', 'PackItem_game_item'],
    'PlayerPack': ['PackItem', 'GameItem', 'PackItem_game_item'],
    'GameItemSlot': ['GameItem', 'PackItem_game_item'],
    'EquipPack': ['Service_EquipItem'],
    'EquipDecompose': ['Service_EquipItem'],
    'EquipLock': ['Service_EquipItem'],
    'EquipWearSlot': ['Service_EquipItem'],
    'EquipSlot': ['Service_EquipItem'],
    'TradeGoodsOnItemBox': ['Service_EquipItem'],
};

function RegDraggleDrop(pDropPanel, type, params, callback = {}) {
    pDropPanel['draggle/drop/params'] = () => ({
        type: type,
        params: params,
    });
    pDropPanel['draggle/drop/callback'] = callback;
    for (const event of [
        'DragEnter',
        'DragLeave',
        'DragDrop',
    ]) {
        $.RegisterEventHandler(event, pDropPanel, (_, pDragPanel) => {
            var _a, _b, _c, _d;
            if (pDragPanel['drag_type'] == undefined)
                return;
            const tDropInfo = pDropPanel['draggle/drop/params']();
            const tDropTypes = DragDropToDragTypes[tDropInfo.type];
            if (tDropTypes.length > 0 && !tDropTypes.includes(pDragPanel['drag_type']))
                return;
            try {
                (_b = (_a = pDragPanel['callback'])['on' + event]) === null || _b === void 0 ? void 0 : _b.call(_a, pDragPanel, { type: pDragPanel['drag_type'], params: pDragPanel['params'] }, tDropInfo, pDropPanel);
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
            }
            try {
                (_d = (_c = pDropPanel['draggle/drop/callback'])['on' + event]) === null || _d === void 0 ? void 0 : _d.call(_c, pDragPanel, { type: pDragPanel['drag_type'], params: pDragPanel['params'] }, tDropInfo, pDropPanel);
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
            }
        });
    }
    for (const [sEvent, sFunc] of [
        ['ON_DRAG_START', 'onDragStart'],
        ['ON_DRAG_END', 'onDragEnd'],
    ]) {
        GameUI.CustomUIConfig().tools.EventManager.Reg(sEvent, ({ pDragPanel, info }) => {
            var _a, _b;
            if (!pDropPanel.IsValid()) {
                return true;
            }
            if (info.type == undefined)
                return;
            const tDropInfo = pDropPanel['draggle/drop/params']();
            const tDropTypes = DragDropToDragTypes[tDropInfo.type];
            if (tDropTypes.length > 0 && !tDropTypes.includes(info.type))
                return;
            try {
                (_b = (_a = pDropPanel['draggle/drop/callback'])[sFunc]) === null || _b === void 0 ? void 0 : _b.call(_a, pDragPanel, { type: info.type, params: pDragPanel['params'] }, tDropInfo, pDropPanel);
            }
            catch (error) {
                GameUI.CustomUIConfig().UploadError(error);
            }
        }, pDropPanel);
    }
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
    let WindowManager = class WindowManager {
        static Init(bReload) {
            const pDOTAHud = $.GetContextPanel().GetParent().GetParent().GetParent();
            if (this.pFloor == undefined) {
                for (let i = pDOTAHud.GetChildCount() - 1; i >= 0; --i) {
                    const p = pDOTAHud.GetChild(i);
                    if (p.id == 'WindowManager_Floor') {
                        this.pFloor = p;
                        break;
                    }
                }
                if (this.pFloor == undefined) {
                    this.pFloor = $.CreatePanel('Panel', pDOTAHud, 'WindowManager_Floor', { hittest: true });
                    this.pFloor.visible = false;
                    RegDraggleDrop(this.pFloor, 'Floor', undefined, {
                        'onDragDrop': (pDragPanel) => {
                            GameUI.CustomUIConfig().tools.EventManager.Fire('ON_DRAG_DROP_ON_FLOOR', pDragPanel);
                        }
                    });
                }
            }
            if (0 != pDOTAHud.GetChildIndex(this.pFloor)) {
                pDOTAHud.MoveChildBefore(this.pFloor, pDOTAHud.GetChild(0));
            }
            this.pFloor.style.width = "100%";
            this.pFloor.style.height = "100%";
        }
    };
    WindowManager = __decorate([
        reloadlock()
    ], WindowManager);
    tools.WindowManager = WindowManager;
})(tools || (tools = {}));
GameUI.CustomUIConfig().tools = tools;