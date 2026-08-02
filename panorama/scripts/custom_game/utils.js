--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const dotaHud = (() => {
    let panel = $.GetContextPanel();
    while (panel) {
        if (panel.id === "DotaHud")
            return panel;
        panel = panel.GetParent();
    }
    return panel;
})();
const GetPlayerColorHex = (playerID) => {
    let color = Players.GetPlayerColor(playerID).toString(16);
    color = color.substring(6, 8) + color.substring(4, 6) + color.substring(2, 4) + color.substring(0, 2);
    return `#${color}`;
};
const FindDotaHudElement = (id) => {
    return dotaHud.FindChildTraverse(id);
};
const TipPlayer = (playerID) => {
    if (playerID === -1)
        return;

    GameEvents.SendCustomGameEventToServer_custom("TipPlayer", { target: playerID });

};