--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
(() => {
    function getDebugApi() {
        const api = GameUI.CustomUIConfig().EndGameDebug;
        if (!api) {
            $.Msg("[hud_end_game_stub] EndGameDebug ещё не готов — открыт ли layout hud_end_game?");
        }
        return api;
    }
    // Собираем фейковые данные PVP по реальным командам/игрокам лобби.
    function buildStubPvpData() {
        const data = {};
        let teamIndex = 0;
        for (const teamId of Game.GetAllTeamIDs()) {
            const players = Game.GetPlayerIDsOnTeam(teamId);
            if (players.length === 0)
                continue;
            const team = {};
            for (const playerId of players) {
                const origin = 1000 + Math.floor(Math.random() * 500);
                const delta = Math.floor(Math.random() * 200) - 100;
                team[playerId] = { origin, score: origin + delta };
            }
            data[teamIndex] = team;
            teamIndex++;
        }
        // Фолбэк: если игроков по командам не нашли — хотя бы локальный игрок.
        if (teamIndex === 0) {
            const local = Players.GetLocalPlayer();
            data[0] = { [local]: { origin: 1150, score: 1200 } };
        }
        return data;
    }
    // Диагностика: вывести реальные размеры ключевых панелей PVP-блока.
    function dumpPvpSizes() {
        var _a, _b;
        const ctx = $.GetContextPanel();
        const log = (label, p) => {
            if (!p) {
                $.Msg(`[dump] ${label}: NULL`);
                return;
            }
            const a = p;
            $.Msg(`[dump] ${label}: w=${a.actuallayoutwidth} h=${a.actuallayoutheight} content=${a.contentwidth}x${a.contentheight} visible=${p.visible} children=${p.GetChildCount()}`);
        };
        const pvp = ctx.FindChildTraverse("pvp_content");
        log("pvp_content", pvp);
        const team = pvp && pvp.GetChildCount() > 0 ? pvp.GetChild(0) : null;
        log("teamInfo", team);
        const wrap = team && team.GetChildCount() > 0 ? team.GetChild(0) : null;
        log("wrapper", wrap);
        if (wrap) {
            $.Msg(`[dump] wrapper.id="${wrap.id}" class="${(_b = (_a = wrap).GetAttributeString) === null || _b === void 0 ? void 0 : _b.call(_a, "class", "")}"`);
            for (let i = 0; i < wrap.GetChildCount(); i++) {
                const c = wrap.GetChild(i);
                $.Msg(`[dump]   child[${i}] id="${c === null || c === void 0 ? void 0 : c.id}" w=${c === null || c === void 0 ? void 0 : c.actuallayoutwidth}`);
            }
        }
        const anyPlayerInfo = pvp === null || pvp === void 0 ? void 0 : pvp.FindChildTraverse("PlayerInfo");
        log("PlayerInfo(anywhere)", anyPlayerInfo);
        log("basicInfo", wrap === null || wrap === void 0 ? void 0 : wrap.FindChildTraverse("basicInfo"));
        log("ability", wrap === null || wrap === void 0 ? void 0 : wrap.FindChildTraverse("ability"));
    }
    function showPvp() {
        var _a;
        $.Msg("[hud_end_game_stub] showPvp()");
        (_a = getDebugApi()) === null || _a === void 0 ? void 0 : _a.renderPvp(buildStubPvpData());
        $.Schedule(0.3, dumpPvpSizes);
    }
    function showPve() {
        var _a;
        $.Msg("[hud_end_game_stub] showPve()");
        (_a = getDebugApi()) === null || _a === void 0 ? void 0 : _a.renderPve({ round_num: 12, reward: { moonstone: 3 } });
    }
    function hide() {
        var _a;
        $.Msg("[hud_end_game_stub] hide()");
        (_a = getDebugApi()) === null || _a === void 0 ? void 0 : _a.hide();
    }
    function registerCommands() {
        Game.AddCommand("end_game_pvp", showPvp, "Превью экрана конца игры (PVP)", 0);
        Game.AddCommand("end_game_pve", showPve, "Превью экрана конца игры (PVE)", 0);
        Game.AddCommand("end_game_hide", hide, "Скрыть экран конца игры", 0);
    }
    // Диагностика загрузки всегда; команды/клавиши — только в tools-режиме (прод-безопасно).
    $.Msg("[hud_end_game_stub] loaded. tools=" + Game.IsInToolsMode());
    if (Game.IsInToolsMode()) {
        registerCommands();
        // Горячие клавиши (проверенный механизм проекта, не зависит от консоли):
        //   F9 — PVP-превью, F10 — PVE-превью, F11 — скрыть.
        CreateKeyCommand("F9", showPvp);
        CreateKeyCommand("F10", showPve);
        CreateKeyCommand("F11", hide);
        $.Msg("[hud_end_game_stub] команды: end_game_pvp|pve|hide; клавиши: F9=PVP, F10=PVE, F11=hide");
    }
})();