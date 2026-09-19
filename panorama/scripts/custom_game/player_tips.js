--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const PLAYER_TIP_TOAST_DURATION_SECONDS = 10;
const PLAYER_TIP_SOUND = "General.Sell";
function getPlayerName(playerId) {
    var _a, _b;
    return (_b = (_a = Game.GetPlayerInfo(playerId)) === null || _a === void 0 ? void 0 : _a.player_name) !== null && _b !== void 0 ? _b : `Player ${playerId}`;
}
function getPlayerHeroName(playerId) {
    const info = Game.GetPlayerInfo(playerId);
    return (info === null || info === void 0 ? void 0 : info.player_selected_hero) && info.player_selected_hero !== ""
        ? info.player_selected_hero
        : "npc_dota_hero_wisp";
}
function getPlayerColor(playerId) {
    var _a;
    const teamId = (_a = Game.GetPlayerInfo(playerId)) === null || _a === void 0 ? void 0 : _a.player_team_id;
    const teamColors = GameUI.CustomUIConfig().team_colors;
    const teamColor = teamId != undefined ? teamColors === null || teamColors === void 0 ? void 0 : teamColors[teamId] : undefined;
    if (teamColor && teamColor !== "") {
        return teamColor.replace(";", "");
    }
    const color = Players.GetPlayerColor(playerId);
    const hex = color.toString(16);
    const paddedHex = ("00000000" + hex).slice(-8);
    return `#${paddedHex.slice(6, 8)}${paddedHex.slice(4, 6)}${paddedHex.slice(2, 4)}`;
}
function getBoostedPlayerColor(playerId) {
    const color = getPlayerColor(playerId).replace("#", "").replace(";", "");
    if (color.length !== 6) {
        return getPlayerColor(playerId);
    }
    const r = parseInt(color.slice(0, 2), 16) / 255;
    const g = parseInt(color.slice(2, 4), 16) / 255;
    const b = parseInt(color.slice(4, 6), 16) / 255;
    const max = Math.max(r, g, b);
    const min = Math.min(r, g, b);
    let h = 0;
    let s = 0;
    const l = (max + min) / 2;
    if (max !== min) {
        const d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        if (max === r) {
            h = (g - b) / d + (g < b ? 6 : 0);
        }
        else if (max === g) {
            h = (b - r) / d + 2;
        }
        else {
            h = (r - g) / d + 4;
        }
        h /= 6;
    }
    const boostedS = Math.min(1, s * 1.35 + 0.08);
    const boostedL = Math.min(0.72, l * 1.18 + 0.04);
    const hueToRgb = (p, q, t) => {
        let value = t;
        if (value < 0)
            value += 1;
        if (value > 1)
            value -= 1;
        if (value < 1 / 6)
            return p + (q - p) * 6 * value;
        if (value < 1 / 2)
            return q;
        if (value < 2 / 3)
            return p + (q - p) * (2 / 3 - value) * 6;
        return p;
    };
    const q = boostedL < 0.5 ? boostedL * (1 + boostedS) : boostedL + boostedS - boostedL * boostedS;
    const p = 2 * boostedL - q;
    const toHex = (value) => Math.round(value * 255).toString(16).padStart(2, "0");
    return `#${toHex(hueToRgb(p, q, h + 1 / 3))}${toHex(hueToRgb(p, q, h))}${toHex(hueToRgb(p, q, h - 1 / 3))}`;
}
function createPlayerTipHero(parent, playerId) {
    const block = $.CreatePanel("Panel", parent, "");
    block.AddClass("PlayerTipHeroBlock");
    const heroImage = $.CreatePanel("DOTAHeroImage", block, "");
    heroImage.AddClass("PlayerTipHeroImage");
    heroImage.heroname = getPlayerHeroName(playerId);
    heroImage.heroimagestyle = "landscape";
    const nameRow = $.CreatePanel("Panel", block, "");
    nameRow.AddClass("PlayerTipPlayerNameRow");
    const nameLabel = $.CreatePanel("Label", nameRow, "");
    nameLabel.AddClass("PlayerTipPlayerName");
    nameLabel.hittest = false;
    nameLabel.text = getPlayerName(playerId);
    nameLabel.style.color = getBoostedPlayerColor(playerId);
    nameLabel.style.width = "fit-children";
    nameLabel.style.maxWidth = "112px";
    nameLabel.style.horizontalAlign = "center";
}
function createPlayerTipToast(event) {
    const stack = $("#PlayerTipsStack");
    if (!stack) {
        return;
    }
    Game.EmitSound(PLAYER_TIP_SOUND);
    const toast = $.CreatePanel("Panel", stack, `PlayerTipToast_${Date.now()}`);
    toast.AddClass("PlayerTipToast");
    toast.AddClass("Intro");
    createPlayerTipHero(toast, event.tipper_player_id);
    const middle = $.CreatePanel("Panel", toast, "");
    middle.AddClass("PlayerTipMiddle");
    const action = $.CreatePanel("Label", middle, "");
    action.AddClass("PlayerTipAction");
    action.text = $.Localize("#DOTA_TipNotification");
    const cost = $.CreatePanel("Panel", middle, "");
    cost.AddClass("PlayerTipCost");
    $.CreatePanel("Panel", cost, "").AddClass("PlayerTipCostIcon");
    const costValue = $.CreatePanel("Label", cost, "");
    costValue.AddClass("PlayerTipCostValue");
    costValue.text = String(event.cost);
    createPlayerTipHero(toast, event.target_player_id);
    $.Schedule(0.03, () => {
        if (toast.IsValid()) {
            toast.RemoveClass("Intro");
        }
    });
    $.Schedule(PLAYER_TIP_TOAST_DURATION_SECONDS, () => {
        if (!toast.IsValid()) {
            return;
        }
        toast.AddClass("Outro");
        toast.DeleteAsync(0.2);
    });
}
GameEvents.Subscribe("player_tip_toast", createPlayerTipToast);