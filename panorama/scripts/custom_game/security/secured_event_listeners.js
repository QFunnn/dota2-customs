--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 05:45:25 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function PatchGameEventsSubscribe() {
    var _a;
    const patchedGameEvents = GameEvents;
    (_a = patchedGameEvents.SubscribeUnprotected) !== null && _a !== void 0 ? _a : (patchedGameEvents.SubscribeUnprotected = GameEvents.Subscribe.bind(GameEvents));
    if (patchedGameEvents.uiSecurityIsSubscribePatched) {
        return;
    }
    patchedGameEvents.uiSecurityIsSubscribePatched = true;
    GameEvents.Subscribe = function (pEventName, funcVal) {
        return patchedGameEvents.SubscribeUnprotected(pEventName, (event) => {
            if (!IsSecurityKeyValid(event.security_key)) {
                return;
            }
            funcVal(event);
        });
    };
}