--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
var SecurityState;
(function (SecurityState) {
    SecurityState[SecurityState["NONE"] = 0] = "NONE";
    SecurityState[SecurityState["PENDING"] = 1] = "PENDING";
    SecurityState[SecurityState["READY"] = 2] = "READY";
})(SecurityState || (SecurityState = {}));
const SECURITY_SET_KEY_EVENT = "set_security_key";
const SECURITY_CONFIRM_EVENT = "security_key_confirmed";
const SECURITY_REISSUE_REQUEST_EVENT = "request_security_key_reissue";
const gameEvents = GameEvents;
const securityRuntime = (_a = gameEvents.uiSecurityRuntime) !== null && _a !== void 0 ? _a : (gameEvents.uiSecurityRuntime = { state: SecurityState.NONE });
PatchGameEventsSubscribe();
PatchGameEventSenders();
securityRuntime.securityKey = undefined;
securityRuntime.state = SecurityState.NONE;
function IsSecurityKeyValid(securityKey) {
    return securityRuntime.securityKey === securityKey;
}
function GetSecurityKey() {
    return securityRuntime.securityKey;
}
if (securityRuntime.keyListener != undefined) {
    GameEvents.Unsubscribe(securityRuntime.keyListener);
}
securityRuntime.keyListener = GameEvents.SubscribeUnprotected(SECURITY_SET_KEY_EVENT, (event) => {
    const securityKey = event.security_key;
    if (typeof securityKey !== "string") {
        return;
    }
    if (securityRuntime.state !== SecurityState.NONE) {
        return;
    }
    securityRuntime.securityKey = securityKey;
    securityRuntime.state = SecurityState.PENDING;
    GameEvents.Unsubscribe(securityRuntime.keyListener);
    securityRuntime.keyListener = undefined;
    GameEvents.SendCustomGameEventToServer(SECURITY_CONFIRM_EVENT, { security_key: securityKey });
});
if (securityRuntime.netTableListener == undefined) {
    securityRuntime.netTableListener = CustomNetTables.SubscribeNetTableListener("security", (_, key, value) => {
        if (String(key) !== String(Players.GetLocalPlayer())) {
            return;
        }
        if (value.confirmed === 1) {
            securityRuntime.state = SecurityState.READY;
            return;
        }
        securityRuntime.securityKey = undefined;
        securityRuntime.state = SecurityState.NONE;
        if (securityRuntime.keyListener != undefined) {
            GameEvents.Unsubscribe(securityRuntime.keyListener);
        }
        securityRuntime.keyListener = GameEvents.SubscribeUnprotected(SECURITY_SET_KEY_EVENT, (event) => {
            const securityKey = event.security_key;
            if (typeof securityKey !== "string" || securityRuntime.state !== SecurityState.NONE) {
                return;
            }
            securityRuntime.securityKey = securityKey;
            securityRuntime.state = SecurityState.PENDING;
            GameEvents.Unsubscribe(securityRuntime.keyListener);
            securityRuntime.keyListener = undefined;
            GameEvents.SendCustomGameEventToServer(SECURITY_CONFIRM_EVENT, { security_key: securityKey });
        });
    });
}
if (Game.IsInToolsMode() && securityRuntime.state === SecurityState.NONE) {
    RequestSecurityKeyReissue();
}
function RequestSecurityKeyReissue() {
    GameEvents.SendCustomGameEventToServer(SECURITY_REISSUE_REQUEST_EVENT, {});
}