--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
function AppendEventPayloadWithSecurityKey(eventData) {
    const securityKey = GetSecurityKey();
    if (eventData.security_key == undefined && securityKey != undefined) {
        eventData.security_key = securityKey;
    }
}
function PatchGameEventSenders() {
    var _a, _b, _c, _d;
    const patchedGameEvents = GameEvents;
    (_a = patchedGameEvents.uiSecurityOriginalSendCustomGameEventToServer) !== null && _a !== void 0 ? _a : (patchedGameEvents.uiSecurityOriginalSendCustomGameEventToServer = GameEvents.SendCustomGameEventToServer.bind(GameEvents));
    (_b = patchedGameEvents.uiSecurityOriginalSendCustomGameEventToAllClients) !== null && _b !== void 0 ? _b : (patchedGameEvents.uiSecurityOriginalSendCustomGameEventToAllClients = GameEvents.SendCustomGameEventToAllClients.bind(GameEvents));
    (_c = patchedGameEvents.uiSecurityOriginalSendCustomGameEventToClient) !== null && _c !== void 0 ? _c : (patchedGameEvents.uiSecurityOriginalSendCustomGameEventToClient = GameEvents.SendCustomGameEventToClient.bind(GameEvents));
    (_d = patchedGameEvents.uiSecurityOriginalSendEventClientSide) !== null && _d !== void 0 ? _d : (patchedGameEvents.uiSecurityOriginalSendEventClientSide = GameEvents.SendEventClientSide.bind(GameEvents));
    if (patchedGameEvents.uiSecurityAreSendersPatched) {
        return;
    }
    patchedGameEvents.uiSecurityAreSendersPatched = true;
    GameEvents.SendCustomGameEventToServer = function (pEventName, eventData) {
        AppendEventPayloadWithSecurityKey(eventData);
        patchedGameEvents.uiSecurityOriginalSendCustomGameEventToServer(pEventName, eventData);
    };
    /**
     * @deprecated The method should not be used
     */
    GameEvents.SendCustomGameEventToAllClients = function (pEventName, eventData) {
    };
    /**
     * @deprecated The method should not be used
     */
    GameEvents.SendCustomGameEventToClient = function (pEventName, playerIndex, eventData) {
        //Отключен
    };
    GameEvents.SendEventClientSide = function (pEventName, eventData) {
        AppendEventPayloadWithSecurityKey(eventData);
        patchedGameEvents.uiSecurityOriginalSendEventClientSide(pEventName, eventData);
    };
}