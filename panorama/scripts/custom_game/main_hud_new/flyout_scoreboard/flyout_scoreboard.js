--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const DOTA_ITEM_SLOT_MIN = 0;
const DOTA_ITEM_SLOT_MAX = 5;
const DOTA_ITEM_NEUTRAL_SLOT = 16;
let lastRebuildTime = 0;
let scoreBoardList;
let windowState = false;
let teamPlayers = [];
const flyoutKnownInnateAbilityNames = new Set();
const MUTE_ICON_ON = "file://{images}/custom_game/extract/button_audio_on_png.png";
const MUTE_ICON_OFF = "file://{images}/custom_game/extract/button_audio_off_png.png";
function isPlayerMuted(playerId) {
    return Game.IsPlayerMuted(playerId);
}
function refreshMuteButton(button, icon, playerId) {
    if (!button || !icon) {
        return;
    }
    button.SetHasClass("Hidden", playerId === Players.GetLocalPlayer());
    icon.SetHasClass("Muted", isPlayerMuted(playerId));
    icon.SetImage(isPlayerMuted(playerId) ? MUTE_ICON_OFF : MUTE_ICON_ON);
}
function getTeamPlayers() {
    const teamPlayerArray = [];
    for (const teamID of Game.GetAllTeamIDs()) {
        const teamPlayersOnTeam = Game.GetPlayerIDsOnTeam(teamID);
        for (const playerId of teamPlayersOnTeam) {
            let team = teamPlayerArray.find(v => v.TeamID === teamID);
            if (team) {
                team.TeamPlayers.push(playerId);
            }
            else {
                teamPlayerArray.push({
                    TeamID: teamID,
                    TeamPlayers: [playerId],
                });
            }
        }
    }
    return teamPlayerArray;
}
function getGoldForPlayer(playerId) {
    var _a;
    const info = CustomNetTables.GetTableValue("player_info", playerId);
    return (_a = info === null || info === void 0 ? void 0 : info.gold) !== null && _a !== void 0 ? _a : 0;
}
function getPvpRecord(playerId) {
    var _a, _b;
    const record = CustomNetTables.GetTableValue("pvp_record", playerId);
    return {
        win: (_a = record === null || record === void 0 ? void 0 : record.win) !== null && _a !== void 0 ? _a : 0,
        lose: (_b = record === null || record === void 0 ? void 0 : record.lose) !== null && _b !== void 0 ? _b : 0,
    };
}
function sortTeamsByGold(teams) {
    teams.sort((teamA, teamB) => {
        let totalA = 0;
        let totalB = 0;
        for (const pid of teamA.TeamPlayers)
            totalA += getGoldForPlayer(pid);
        for (const pid of teamB.TeamPlayers)
            totalB += getGoldForPlayer(pid);
        return totalB - totalA;
    });
}
function setWindowVisible(visible) {
    windowState = visible;
    const root = $("#HudScoreboardMainContainer");
    if (!root) {
        $.Msg("[FlyoutScoreboard] ERROR: #HudScoreboardMainContainer not found!");
        return;
    }
    root.visible = visible;
    root.SetHasClass("Show", visible);
}
function setFlyoutScoreboardVisible(bVisible) {
    const becameVisible = bVisible && !windowState;
    const becameHidden = !bVisible && windowState;
    windowState = bVisible;
    setWindowVisible(bVisible);
    if (becameVisible) {
        rebuildScoreboard();
    }
}
function createScoreTeamPanel(parent, teamInfo) {
    const teamPanel = $.CreatePanel("Panel", parent, "TeamContainer_" + teamInfo.TeamID);
    teamPanel.BLoadLayoutSnippet("TeamInfoSnippet");
    teamPanel.RemoveAndDeleteChildren();
    for (const playerId of teamInfo.TeamPlayers) {
        createPlayerInfoPanel(teamPanel, playerId);
    }
}
function createPlayerInfoPanel(parent, playerId) {
    const hero = Players.GetPlayerHeroEntityIndex(playerId);
    if (hero === -1) {
        $.Msg("[ERROR] createPlayerInfoPanel = -1...return");
        return;
    }
    const pvpRecord = getPvpRecord(playerId);
    const gold = getGoldForPlayer(playerId);
    const hasScepter = Entities.HasScepter(hero);
    const hasShard = Entities.HasBuff(hero, "modifier_item_aghanims_shard");
    const abilities = [];
    for (let i = 0; i < Entities.GetAbilityCount(hero); i++) {
        const ability = Entities.GetAbility(hero, i);
        if (ability === -1)
            continue;
        if (Abilities.GetAbilityType(ability) === 2)
            continue;
        if (!Game.IsValidAbility(ability))
            continue;
        if ((Abilities.GetBehavior(ability) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_INNATE_UI) !== 0)
            continue;
        const abilityName = Abilities.GetAbilityName(ability);
        if (flyoutKnownInnateAbilityNames.has(abilityName))
            continue;
        abilities.push(ability);
    }
    const abilityCount = abilities.length;
    for (let i = 0; i < 6 - abilityCount; i++) {
        abilities.push(-1);
    }
    const items = [];
    for (let slot = DOTA_ITEM_SLOT_MIN; slot <= DOTA_ITEM_SLOT_MAX; slot++) {
        const item = Entities.GetItemInSlot(hero, slot);
        items.push(item);
    }
    const itemNeutral = Entities.GetItemInSlot(hero, DOTA_ITEM_NEUTRAL_SLOT);
    const playerPanel = $.CreatePanel("Panel", parent, "");
    playerPanel.BLoadLayoutSnippet("PlayerInfoSnippet");
    const heroImg = playerPanel.FindChildTraverse("PlayerInfoHeroIconImg");
    if (heroImg) {
        heroImg.heroname = Entities.GetUnitName(hero);
        heroImg.heroimagestyle = "landscape";
        //todo добавить $.DispatchEvent на открытие профиля
    }
    const nameLabel = playerPanel.FindChildTraverse("PlayerInfoPlayerName");
    if (nameLabel) {
        nameLabel.text = Players.GetPlayerName(playerId);
        //todo добавить $.DispatchEvent на открытие профиля
    }
    const muteButton = playerPanel.FindChildTraverse("PlayerInfoMuteButton");
    const muteButtonIcon = playerPanel.FindChildTraverse("PlayerInfoMuteButtonIcon");
    refreshMuteButton(muteButton, muteButtonIcon, playerId);
    muteButton === null || muteButton === void 0 ? void 0 : muteButton.SetPanelEvent("onactivate", () => {
        Game.SetPlayerMuted(playerId, !Game.IsPlayerMuted(playerId));
        refreshMuteButton(muteButton, muteButtonIcon, playerId);
    });
    const heroLvlNum = playerPanel.FindChildTraverse("PlayerInfoHeroLvlNum");
    if (heroLvlNum) {
        heroLvlNum.text = Entities.GetLevel(hero).toString();
    }
    const heroLvlTitle = playerPanel.FindChildTraverse("PlayerInfoHeroLvlTitle");
    if (heroLvlTitle) {
        heroLvlTitle.text = $.Localize("#custom_end_screen_legend_level");
    }
    const heroNameLabel = playerPanel.FindChildTraverse("PlayerInfoHeroName");
    if (heroNameLabel) {
        const unitName = Entities.GetUnitName(hero);
        heroNameLabel.text = $.Localize(`#${unitName}`);
    }
    const goldLabel = playerPanel.FindChildTraverse("PlayerInfoGoldValue");
    if (goldLabel) {
        goldLabel.text = gold.toString();
    }
    const winLabel = playerPanel.FindChildTraverse("PvpRecordWinCount");
    const loseLabel = playerPanel.FindChildTraverse("PvpRecordLoseCount");
    if (winLabel)
        winLabel.text = pvpRecord.win.toString();
    if (loseLabel)
        loseLabel.text = pvpRecord.lose.toString();
    const abilitiesContainer = playerPanel.FindChildTraverse("PlayerInfoAbilitiesContainer");
    if (abilitiesContainer) {
        abilitiesContainer.RemoveAndDeleteChildren();
        for (let i = 0; i < abilities.length; i++) {
            const ability = abilities[i];
            const img = $.CreatePanel("DOTAAbilityImage", abilitiesContainer, "");
            img.AddClass("ImageAbility");
            if (ability !== -1) {
                const abilityName = Abilities.GetAbilityName(ability);
                img.abilityname = abilityName;
                $.Schedule(0, (() => {
                    if (img.BHasClass("UseInnateIcon")) {
                        flyoutKnownInnateAbilityNames.add(abilityName);
                        img.DeleteAsync(0);
                        return;
                    }
                    img.SetPanelEvent("onmouseover", () => {
                        $.DispatchEvent("DOTAShowAbilityTooltip", img, img.abilityname);
                    });
                    img.SetPanelEvent("onmouseout", () => {
                        $.DispatchEvent("DOTAHideAbilityTooltip", img);
                    });
                }));
            }
        }
    }
    const itemsScepter = playerPanel.FindChildTraverse("PlayerInfoItemsScepterContainer");
    const itemsShard = playerPanel.FindChildTraverse("PlayerInfoItemsShardContainer");
    if (itemsScepter)
        itemsScepter.SetHasClass("Active", hasScepter);
    if (itemsShard)
        itemsShard.SetHasClass("Active", hasShard);
    const itemsMain = playerPanel.FindChildTraverse("PlayerInfoItemsContainer");
    if (itemsMain) {
        itemsMain.RemoveAndDeleteChildren();
        for (let i = 0; i < 6; i++) {
            const item = items[i];
            const itemImg = $.CreatePanel("DOTAItemImage", itemsMain, "");
            itemImg.AddClass("ItemImage");
            if (item !== -1) {
                itemImg.itemname = Abilities.GetAbilityName(item);
                itemImg.SetPanelEvent("onmouseover", () => {
                    $.DispatchEvent("DOTAShowAbilityTooltip", itemImg, itemImg.itemname);
                });
                itemImg.SetPanelEvent("onmouseout", () => {
                    $.DispatchEvent("DOTAHideAbilityTooltip", itemImg);
                });
            }
        }
    }
    const neutralSlot = playerPanel.FindChildTraverse("PlayerInfoItemNeutralSlotContainer");
    if (neutralSlot) {
        neutralSlot.RemoveAndDeleteChildren();
        const neutralImg = $.CreatePanel("DOTAItemImage", neutralSlot, "");
        neutralImg.AddClass("ItemNeutral");
        if (itemNeutral !== -1) {
            neutralImg.itemname = Abilities.GetAbilityName(itemNeutral);
            neutralImg.SetPanelEvent("onmouseover", () => {
                $.DispatchEvent("DOTAShowAbilityTooltip", neutralImg, neutralImg.itemname);
            });
            neutralImg.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideAbilityTooltip", neutralImg);
            });
        }
    }
    const playerBooksInfo = CustomNetTables.GetTableValue("player_books", playerId);
    // $.Msg(JSON.stringify(playerBooksInfo, null, "\t"))
    const relearnBookContainer = playerPanel.FindChildTraverse("PlayerInfoRelearnBookContainer");
    if (relearnBookContainer) {
        relearnBookContainer.RemoveAndDeleteChildren();
        const relearnImg = $.CreatePanel("DOTAItemImage", relearnBookContainer, "");
        relearnImg.AddClass("BookImage");
        relearnImg.itemname = "item_relearn_book_lua";
        const bookCount = $.CreatePanel("Label", relearnBookContainer, "");
        bookCount.AddClass("CountLabel");
        if (playerBooksInfo && playerBooksInfo["item_relearn_book_lua"])
            bookCount.text = playerBooksInfo["item_relearn_book_lua"].toString();
        else
            bookCount.text = "0";
    }
    const tornPageContainer = playerPanel.FindChildTraverse("PlayerInfoTornPageContainer");
    if (tornPageContainer) {
        tornPageContainer.RemoveAndDeleteChildren();
        const relearnImg = $.CreatePanel("DOTAItemImage", tornPageContainer, "");
        relearnImg.AddClass("BookImage");
        relearnImg.itemname = "item_relearn_torn_page_lua";
        const bookCount = $.CreatePanel("Label", tornPageContainer, "");
        bookCount.AddClass("CountLabel");
        if (playerBooksInfo && playerBooksInfo["item_relearn_torn_page_lua"])
            bookCount.text = playerBooksInfo["item_relearn_torn_page_lua"].toString();
        else
            bookCount.text = "0";
    }
}
function rebuildScoreboard() {
    // $.Msg("[FlyoutScoreboard] Rebuild start");
    if (!scoreBoardList) {
        $.Msg("[FlyoutScoreboard] ERROR: HudScoreboardTeamsContainer not found!");
        return;
    }
    teamPlayers = getTeamPlayers();
    sortTeamsByGold(teamPlayers);
    scoreBoardList.RemoveAndDeleteChildren();
    for (let i = 0; i < teamPlayers.length; i++) {
        const teamInfo = teamPlayers[i];
        if (!teamInfo)
            continue;
        createScoreTeamPanel(scoreBoardList, teamInfo);
    }
}
function scoreboardUpdateLoop() {
    $.Schedule(0.2, scoreboardUpdateLoop);
    if (!windowState)
        return;
    const now = Game.GetGameTime();
    if (now - lastRebuildTime >= 2.0) {
        lastRebuildTime = now;
        rebuildScoreboard();
    }
}
(function init() {
    const ctx = $.GetContextPanel();
    scoreBoardList = ctx.FindChildTraverse("HudScoreboardTeamsContainer");
    $.RegisterEventHandler("DOTACustomUI_SetFlyoutScoreboardVisible", ctx, setFlyoutScoreboardVisible);
    setWindowVisible(false);
    //scoreboardUpdateLoop();
})();