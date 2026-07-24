--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
let strategyHudArleadyInit = false;
let strategyTeamPickRoot = panel("TeamPickStrategyRoot");
const localStrategyListenerId = GameEvents.Subscribe("update_hero_select_state", (event) => {
    if (event.PlayerID != Players.GetLocalPlayer())
        return;
    TryInitStrategyHud();
    GameEvents.Unsubscribe(localStrategyListenerId);
});
const localStrategyListenerId2 = GameEvents.SubscribeUnprotected("game_rules_state_change", () => {
    if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME)) {
        TryInitStrategyHud();
    }
    if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_PRE_GAME)) {
        GameEvents.Unsubscribe(localStrategyListenerId);
        GameEvents.Unsubscribe(localStrategyListenerId2);
        GameEvents.Unsubscribe(localStrategyListenerId3);
    }
});
const localStrategyListenerId3 = GameEvents.Subscribe("update_hero_select_state", (event) => {
    if (!strategyHudArleadyInit)
        return;
    UpdateTeamRootStrategyBySelectedHero(event.PlayerID, event.heroName);
});
function TryInitStrategyHud() {
    if (strategyHudArleadyInit)
        return;
    const dotaHud = getDotaHud();
    const headerCenter = dotaHud.FindChildTraverse("HeaderCenter");
    const heroLoadoutTabButton = dotaHud.FindChildTraverse("HeroLoadoutTabButton");
    if (headerCenter)
        headerCenter.visible = true;
    if (heroLoadoutTabButton) {
        $.Schedule(1, () => {
            $.DispatchEvent("Activated", heroLoadoutTabButton, "mouse");
        });
    }
    strategyHudArleadyInit = true;
    BuildTeamRootSlotsForStrategy();
}
function BuildTeamRootSlotsForStrategy() {
    if (!strategyTeamPickRoot) {
        $.Schedule(0, () => BuildTeamRootForHeroPickSlots());
        return;
    }
    let j = 0;
    // for (let i = 0; i < 6; i++) //для тестов кол-во команд
    for (const team of Game.GetAllTeamIDs()) {
        const teamInfo = Game.GetTeamDetails(team);
        if (teamInfo.team_num_players == 0)
            continue;
        const teamContainer = $.CreatePanel("Panel", strategyTeamPickRoot, `TeamContainer${team}`);
        teamContainer.AddClass("TeamContainerInfo");
        const teamPlayersOnTeam = Game.GetPlayerIDsOnTeam(team);
        // for (let i = 0; i < 2; i++) //для тестов кол-во игроков
        for (const playerId of teamPlayersOnTeam) {
            if (!Players.IsValidPlayerID(playerId)) {
                continue;
            }
            const overflowPanel = $.CreatePanel("Panel", teamContainer, "");
            overflowPanel.AddClass("PlayerPickContainer");
            const heroPickingPanel = $.CreatePanel("DOTAHudHeroPickingPlayer", overflowPanel, `HeroPicking${playerId}`);
            PopulateTeamSlotStrategy(heroPickingPanel, playerId, j);
        }
        j++;
    }
    // $.Schedule(5, () => UpdateTeamRootBySelectedHero(Players.GetLocalPlayer(), "npc_dota_hero_crystal_maiden")) //для тестов
}
function PopulateTeamSlotStrategy(teamSlot, player_id, slot) {
    teamSlot.style.opacity = "1";
    teamSlot.AddClass("RankDataMissing");
    const info = Game.GetPlayerInfo(player_id);
    teamSlot.AddClass(`Slot${slot}`);
    teamSlot.AddClass("HeroPickNone");
    if (info.player_connection_state == DOTAConnectionState_t.DOTA_CONNECTION_STATE_CONNECTED)
        teamSlot.AddClass("PlayerConnected");
    if (Players.GetLocalPlayer() == player_id) {
        teamSlot.AddClass("IsLocalPlayerPawn");
    }
    teamSlot.AddClass("PlayerInControl");
    teamSlot.SetDialogVariable("player_name", info.player_name);
    const heroId = Players.GetSelectedHeroID(player_id);
    if (heroId !== 0) {
        UpdateTeamRootStrategyBySelectedHero(player_id, Players.GetPlayerSelectedHero(player_id));
    }
}
function UpdateTeamRootStrategyBySelectedHero(selectedPlayerIdhero, heroName) {
    const teamSlot = strategyTeamPickRoot === null || strategyTeamPickRoot === void 0 ? void 0 : strategyTeamPickRoot.FindChildTraverse(`HeroPicking${selectedPlayerIdhero}`);
    if (!teamSlot)
        return;
    const heroImage = teamSlot.FindChildTraverse("HeroImage");
    heroImage.heroname = heroName;
    teamSlot.RemoveClass("HeroPickNone");
    teamSlot.RemoveClass("PlayerInControl");
    teamSlot.AddClass("HeroPickLocked");
}