--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
function requestTogglePause() {
    GameEvents.SendCustomGameEventToServer("toggle_game_pause", {});
}
function registerPauseKeyBind() {
    const key = Game.GetKeybindForCommand(DOTAKeybindCommand_t.DOTA_KEYBIND_PAUSE);
    const command = "rr_toggle_game_pause_" + Date.now();
    Game.CreateCustomKeyBind(key, "+" + command);
    Game.AddCommand("+" + command, () => requestTogglePause(), "", 1 << 31);
    Game.AddCommand("-" + command, () => { }, "", 1 << 31);
}
function showPauseError(message) {
    GameEvents.SendEventClientSide("dota_hud_error_message", {
        reason: 80,
        message,
        sequenceNumber: 1,
    });
}
function onUnpauseDenied(event) {
    showPauseError($.Localize("#rr_pause_unpause_denied").replace("{seconds}", String(event.remainingSeconds)));
}
function onPauseLimitReached(event) {
    showPauseError($.Localize("#rr_pause_limit_reached").replace("{max}", String(event.maxPauses)));
}
function onPauseNotAllowed() {
    showPauseError($.Localize("#rr_pause_not_allowed"));
}
registerPauseKeyBind();
GameEvents.Subscribe("pause_unpause_denied", onUnpauseDenied);
GameEvents.Subscribe("pause_limit_reached", onPauseLimitReached);
GameEvents.Subscribe("pause_not_allowed", onPauseNotAllowed);
const PAUSE_INFO_PANEL_ID = "RRPauseInfo";
const CONTAINER_LOOKUP_ATTEMPTS = 10;
let pauseCountdownLabel;
function findPausedContainer() {
    let node = $.GetContextPanel();
    let root = node;
    while (node) {
        root = node;
        node = node.GetParent();
    }
    return root.FindChildTraverse("PausedContainer");
}
function clearPauseInfo() {
    var _a, _b;
    pauseCountdownLabel = undefined;
    (_b = (_a = findPausedContainer()) === null || _a === void 0 ? void 0 : _a.FindChild(PAUSE_INFO_PANEL_ID)) === null || _b === void 0 ? void 0 : _b.DeleteAsync(0);
}
function setCountdownText(label, remaining) {
    if (remaining > 0) {
        label.text = $.Localize("#rr_pause_unlock_in").replace("{seconds}", String(remaining));
        return;
    }
    label.text = $.Localize("#rr_pause_unlock_now");
}
function getPauseOwnerColor(playerId) {
    var _a;
    const teamId = (_a = Game.GetPlayerInfo(playerId)) === null || _a === void 0 ? void 0 : _a.player_team_id;
    const teamColors = GameUI.CustomUIConfig().team_colors;
    const teamColor = teamId !== undefined ? teamColors === null || teamColors === void 0 ? void 0 : teamColors[teamId] : undefined;
    if (teamColor && teamColor !== "") {
        return teamColor.replace(";", "");
    }
    const color = Players.GetPlayerColor(playerId).toString(16);
    const paddedColor = ("00000000" + color).slice(-8);
    return `#${paddedColor.slice(6, 8)}${paddedColor.slice(4, 6)}${paddedColor.slice(2, 4)}`;
}
function getBoostedPauseOwnerColor(playerId) {
    const color = getPauseOwnerColor(playerId).replace("#", "").replace(";", "");
    if (color.length !== 6) {
        return getPauseOwnerColor(playerId);
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
function onPauseCountdown(event) {
    if (pauseCountdownLabel !== undefined) {
        setCountdownText(pauseCountdownLabel, event.remainingSeconds);
    }
}
function showPauseInfo(event, attempt) {
    const container = findPausedContainer();
    if (container === null) {
        if (attempt < CONTAINER_LOOKUP_ATTEMPTS) {
            $.Schedule(0.1, () => showPauseInfo(event, attempt + 1));
        }
        return;
    }
    clearPauseInfo();
    const ownerId = event.ownerId;
    const ownerInfo = Game.GetPlayerInfo(ownerId);
    container.style.flowChildren = "down";
    container.style.height = "140px";
    const pauseLabel = container.FindChildTraverse("PausedLabel");
    if (pauseLabel) {
        pauseLabel.style.marginTop = "5px";
    }
    const panel = $.CreatePanel("Panel", container, PAUSE_INFO_PANEL_ID);
    panel.style.flowChildren = "down";
    panel.style.horizontalAlign = "center";
    panel.style.width = "100%";
    panel.style.marginTop = "2px";
    panel.style.padding = "10px 18px";
    panel.style.borderRadius = "8px";
    const playerRow = $.CreatePanel("Panel", panel, "RRPauseInfoPlayerRow");
    playerRow.style.flowChildren = "right";
    playerRow.style.horizontalAlign = "center";
    const avatar = $.CreatePanel("DOTAAvatarImage", playerRow, "RRPauseInfoAvatar");
    avatar.style.width = "44px";
    avatar.style.height = "44px";
    avatar.style.borderRadius = "50%";
    avatar.style.marginRight = "12px";
    avatar.style.verticalAlign = "center";
    avatar.steamid = ownerInfo.player_steamid;
    const name = $.CreatePanel("Label", playerRow, "RRPauseInfoName");
    name.style.color = getBoostedPauseOwnerColor(ownerId);
    name.style.fontSize = "20px";
    name.style.verticalAlign = "center";
    name.text = ownerInfo.player_name;
    const countdown = $.CreatePanel("Label", panel, "RRPauseInfoCountdown");
    countdown.style.color = "#ffd76a";
    countdown.style.fontSize = "20px";
    countdown.style.horizontalAlign = "center";
    countdown.style.marginTop = "6px";
    countdown.style.textAlign = "center";
    countdown.style.width = "100%";
    pauseCountdownLabel = countdown;
    setCountdownText(countdown, event.windowSeconds);
}
GameEvents.Subscribe("pause_started", (event) => showPauseInfo(event, 0));
GameEvents.Subscribe("pause_ended", () => clearPauseInfo());
GameEvents.Subscribe("pause_countdown", onPauseCountdown);