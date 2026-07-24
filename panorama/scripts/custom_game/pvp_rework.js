--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
const HUD_WINDOW_NAME = "HUD_PVP";
const PVP_DOTA_ITEM_SLOT_MIN = 0;
const PVP_DOTA_ITEM_SLOT_MAX = 5;
const PVP_DOTA_BACKPACK_SLOT_MIN = 6;
const PVP_DOTA_BACKPACK_SLOT_MAX = 8;
function formatBetGoldDisplay(n) {
    return String(Math.max(0, Math.floor(n))).replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}
let selfPvp = false;
let canBet = true;
let bPass = true;
let bFlip = Game.IsHUDFlipped();
let hidePvpOnRoundStart = false;
let pvpWindowState = false;
let page = 0;
let showBet = true;
let hasPlacedBet = false;
let betTime = 0;
let dataList = {};
let betMap = {};
let potentialBetWin = 0;
const pendingBetByTeam = {};
const pendingQuickKeyByTeam = {};
let playerTagTable = (_a = CustomNetTables.GetTableValue("service", "player_tag")) !== null && _a !== void 0 ? _a : {};
const knownInnateAbilityNames = new Set();
const betInputs = [];
const root = $.GetContextPanel();
const hud = root.FindChildTraverse("HUD_PVP");
const topToggleButton = root.FindChildTraverse("ToggleButton");
const toggleImage = root.FindChildTraverse("ToggleImage");
const bottom = root.FindChildTraverse("Bottom");
const tags = root.FindChildTraverse("Tags");
const tagDivider = root.FindChildTraverse("TagDivider");
const mainPage = root.FindChildTraverse("MainPage");
const historyPanel = root.FindChildTraverse("History");
const historySummary = root.FindChildTraverse("SummaryLabel");
const historyList = root.FindChildTraverse("BetList");
const footerMinBet = root.FindChildTraverse("FooterMinBet");
const footerMaxBet = root.FindChildTraverse("FooterMaxBet");
const footerBetTimeText = root.FindChildTraverse("FooterBetTimeText");
const footerBetTimeValue = root.FindChildTraverse("FooterBetTimeValue");
const pvpStatus = root.FindChildTraverse("PvpBetTimer");
const pvpStatusIcon = root.FindChildTraverse("PvpBetTimerIcon");
const pvpStatusText = root.FindChildTraverse("PvpBetTimerText");
const pvpStatusValue = root.FindChildTraverse("PvpBetTimerValue");
if (!hud ||
    !topToggleButton ||
    !toggleImage ||
    !bottom ||
    !tags ||
    !mainPage ||
    !historyPanel ||
    !historySummary ||
    !historyList) {
    $.Msg("[pvp_rework] Missing required layout panels");
}
else {
    init();
}
SubscribeAndFireNetTableByKey("player_settings", String(getSteamId32(Players.GetLocalPlayer())), (_, __, value) => {
    if (value) {
        hidePvpOnRoundStart = readNetBool(value.hidePvpOnRoundStart);
    }
});
function init() {
    hud.SetHasClass("Flip", bFlip);
    const tag0 = tags.GetChild(0);
    const tag1 = tags.GetChild(1);
    if (tag0) {
        tag0.SetPanelEvent("onactivate", () => {
            page = 0;
            refreshView();
        });
    }
    if (tag1) {
        tag1.SetPanelEvent("onactivate", () => {
            page = 1;
            refreshView();
        });
    }
    topToggleButton.SetPanelEvent("onactivate", () => {
        toggleWindow();
    });
    GameEvents.Subscribe("custom_ui_toggle_windows", (event) => {
        if (!event) {
            return;
        }
        if (event.window_name === HUD_WINDOW_NAME) {
            if (typeof event.show_state === "boolean") {
                pvpWindowState = event.show_state;
            }
            else {
                pvpWindowState = !pvpWindowState;
            }
        }
        else {
            pvpWindowState = false;
        }
        refreshView();
    });
    GameEvents.Subscribe("ShowPvpBet", (event) => {
        if (!event || !event.dataList) {
            return;
        }
        const nextDataList = {};
        let willLocalPlayerPvp = false;
        for (const teamId in event.dataList) {
            const players = event.dataList[teamId];
            nextDataList[teamId] = [];
            if (Number(teamId) === Players.GetTeam(Players.GetLocalPlayer())) {
                willLocalPlayerPvp = true;
            }
            for (const key in players) {
                const playerInfo = players[key];
                if (playerInfo) {
                    nextDataList[teamId].push(playerInfo);
                }
            }
        }
        selfPvp = willLocalPlayerPvp;
        const canBetRaw = event.can_bet;
        canBet = canBetRaw === true || canBetRaw === 1 || canBetRaw === "1";
        betMap = {};
        hasPlacedBet = false;
        potentialBetWin = 0;
        for (const k in pendingBetByTeam)
            delete pendingBetByTeam[k];
        for (const k in pendingQuickKeyByTeam)
            delete pendingQuickKeyByTeam[k];
        page = 0;
        showBet = !selfPvp && canBet;
        dataList = nextDataList;
        toggleWindow(true);
    });
    GameEvents.Subscribe("UpdateConfirmButton", (event) => {
        if (!event) {
            return;
        }
        betTime = Math.max(0, Number(event.totalTime) - Number(event.currentTime));
        updateBetButtonsText();
    });
    GameEvents.Subscribe("CreateQuest", (event) => {
        if (!event || event.bRoundStart) {
            return;
        }
        clearBetInputs();
        // Участникам дуэли окно скрывается всегда; не-участникам — только если включена
        // настройка hidePvpOnRoundStart (тогда они «просто уходят на раунд» без окна PvP).
        if (selfPvp || hidePvpOnRoundStart) {
            toggleWindow(false);
            return;
        }
        refreshView();
    });
    GameEvents.Subscribe("ShowPvpBrief", (event) => {
        var _a;
        betMap = (_a = event === null || event === void 0 ? void 0 : event.betMap) !== null && _a !== void 0 ? _a : {};
        const hasBetRaw = event === null || event === void 0 ? void 0 : event.has_placed_bet;
        const hasBet = hasBetRaw === true || hasBetRaw === 1 || hasBetRaw === "1";
        if (hasBet) {
            hasPlacedBet = true;
            potentialBetWin = Math.max(0, Math.floor(Number(event === null || event === void 0 ? void 0 : event.potential_win) || 0));
        }
        else {
            potentialBetWin = 0;
        }
        showBet = false;
        if (!hidePvpOnRoundStart) {
            toggleWindow(true);
        }
    });
    GameEvents.Subscribe("PvpBetAccepted", (event) => {
        var _a;
        if (!event) {
            return;
        }
        betMap = (_a = event.betMap) !== null && _a !== void 0 ? _a : betMap;
        const isSelfRaw = event.is_self;
        const isSelf = isSelfRaw === true || isSelfRaw === 1 || isSelfRaw === "1";
        const nextPotentialWin = Math.max(0, Math.floor(Number(event.potential_win) || 0));
        if (!isSelf) {
            if (hasPlacedBet) {
                potentialBetWin = nextPotentialWin;
                updatePvpStatus();
                refreshTeamBetSummaries();
            }
            return;
        }
        potentialBetWin = nextPotentialWin;
        hasPlacedBet = true;
        showBet = false;
        refreshView();
    });
    GameEvents.Subscribe("TeamWin", () => {
        toggleWindow(false);
    });
    $.Schedule(1, updateLoop);
    refreshView();
}
function updateLoop() {
    if (pvpWindowState && page === 0) {
        updateDynamicValues();
    }
    $.Schedule(1, updateLoop);
}
function toggleWindow(wishState) {
    if (typeof ToggleWindows === "function") {
        ToggleWindows(HUD_WINDOW_NAME, wishState);
        return;
    }
    if (typeof wishState === "boolean") {
        pvpWindowState = wishState;
    }
    else {
        pvpWindowState = !pvpWindowState;
    }
    refreshView();
}
function refreshView() {
    toggleImage.SetHasClass("Show", pvpWindowState);
    bottom.SetHasClass("Show", pvpWindowState);
    const tag0 = tags.GetChild(0);
    const tag1 = tags.GetChild(1);
    if (tag0) {
        tag0.SetHasClass("Selected", page === 0);
    }
    if (tag1) {
        tag1.SetHasClass("Selected", page === 1);
    }
    mainPage.visible = pvpWindowState && page === 0;
    historyPanel.visible = pvpWindowState && page === 1;
    bottom.SetHasClass("HistoryMode", page === 1);
    if (tagDivider) {
        tagDivider.SetHasClass("HistoryMode", page === 1);
        if (pvpStatus && pvpStatus.GetParent() !== tagDivider) {
            pvpStatus.SetParent(tagDivider);
        }
    }
    updatePvpStatus();
    if (!pvpWindowState) {
        return;
    }
    if (page === 0) {
        refreshMainPage();
        updateDynamicValues();
    }
    else {
        refreshHistoryPage();
    }
}
function refreshMainPage() {
    betInputs.length = 0;
    mainPage.RemoveAndDeleteChildren();
    const duelists = new Set();
    for (const teamId in dataList) {
        const duelTeam = dataList[teamId];
        if (!duelTeam) {
            continue;
        }
        for (const info of duelTeam) {
            if (info.iPlayerID !== undefined && info.iPlayerID !== -1) {
                duelists.add(info.iPlayerID);
            }
        }
    }
    const teamIds = Object.keys(dataList);
    for (let index = 0; index < teamIds.length; index++) {
        const teamId = teamIds[index];
        const teamInfo = dataList[teamId];
        if (!teamInfo) {
            continue;
        }
        const teamPanel = $.CreatePanel("Panel", mainPage, "Team");
        teamPanel.SetHasClass("TopTeam", index === 0);
        teamPanel.SetHasClass("BottomTeam", index !== 0);
        const teamMain = $.CreatePanel("Panel", teamPanel, "TeamMain");
        const teamLeft = $.CreatePanel("Panel", teamMain, "TeamLeft");
        const teamHeroList = $.CreatePanel("Panel", teamLeft, "TeamHeroList");
        for (const info of teamInfo) {
            createPlayerInfo(teamHeroList, info);
        }
        const localTeam = Players.GetTeam(Players.GetLocalPlayer());
        const rowTeam = Number(teamId);
        const betEnabled = showBet && canBet && !selfPvp && rowTeam !== localTeam;
        const showTeamBetSummary = !showBet && !selfPvp;
        const betParent = showTeamBetSummary ? teamLeft : teamMain;
        createBetPanel(betParent, Number(teamId), betEnabled, showTeamBetSummary);
        const teamRight = betParent.FindChildTraverse("TeamRight");
        if (teamRight) {
            const teamBetSection = $.CreatePanel("Panel", teamRight, "TeamBetListSection");
            teamBetSection.SetAttributeInt("team_id", Number(teamId));
            teamBetSection.style.visibility = showTeamBetSummary ? "visible" : "collapse";
            if (showTeamBetSummary) {
                populateTeamBetSummary(teamBetSection, betMap[teamId], duelists);
            }
            else {
                teamBetSection.RemoveAndDeleteChildren();
            }
        }
        const versus = $.CreatePanel("Panel", teamPanel, "Versus");
        versus.style.visibility = index === 0 ? "visible" : "collapse";
        $.CreatePanel("Panel", versus, "").AddClass("PvpVersusLine");
        $.CreatePanel("Panel", versus, "").AddClass("PvpVersusGap");
        const versusLabel = $.CreatePanel("Label", versus, "VersusLabel");
        versusLabel.text = selfPvp ? $.Localize("#PvP_WillPVPTag_text") : $.Localize("#PvP_bet_History_entry_versus");
        $.CreatePanel("Panel", versus, "").AddClass("PvpVersusGap");
        $.CreatePanel("Panel", versus, "").AddClass("PvpVersusLine");
    }
}
function createPlayerInfo(parent, info) {
    var _a, _b, _c, _d, _e, _f;
    const iPlayerID = (_a = info.iPlayerID) !== null && _a !== void 0 ? _a : -1;
    if (iPlayerID === -1) {
        return;
    }
    const hero = Players.GetPlayerHeroEntityIndex(iPlayerID);
    const hasHero = hero !== -1;
    const playerPanel = $.CreatePanel("Panel", parent, "PlayerInfo");
    playerPanel.SetAttributeInt("player_id", iPlayerID);
    const playerInfo = Game.GetPlayerInfo(iPlayerID);
    const steamId64 = (_b = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.player_steamid) !== null && _b !== void 0 ? _b : "";
    const steamId32 = convertToSteamId32(steamId64);
    const tagInfo = playerTagTable[steamId32];
    const title = $.CreatePanel("Panel", playerPanel, "Title");
    const playerNamePanel = $.CreatePanel("Panel", title, "PlayerName");
    const playerNameLabel = $.CreatePanel("Label", playerNamePanel, "PlayerNameText");
    playerNameLabel.text = Players.GetPlayerName(iPlayerID);
    if (tagInfo) {
        const rolePanel = $.CreatePanel("Panel", title, "PlayerRole");
        if (tagInfo.icon) {
            const icon = $.CreatePanel("Image", rolePanel, "PlayerRoleIcon");
            icon.SetImage(`file://{images}/custom_game/role_icons/${tagInfo.icon}.png`);
        }
        const roleLabel = $.CreatePanel("Label", rolePanel, "PlayerRoleTag");
        roleLabel.text = (_c = tagInfo.name) !== null && _c !== void 0 ? _c : "";
        if (tagInfo.colorHex) {
            roleLabel.style.color = tagInfo.colorHex;
        }
    }
    const top = $.CreatePanel("Panel", playerPanel, "Top");
    const heroPanel = $.CreatePanel("Panel", top, "Hero");
    if (hasHero) {
        heroPanel.SetPanelEvent("onactivate", () => {
            GameUI.SetCameraTargetPosition(Entities.GetAbsOrigin(hero), 0.01);
        });
    }
    const heroImage = $.CreatePanel("DOTAHeroImage", heroPanel, "HeroImage");
    heroImage.heroname = hasHero ? Entities.GetUnitName(hero) : Players.GetPlayerSelectedHero(iPlayerID);
    heroImage.heroimagestyle = "landscape";
    const levelOuter = $.CreatePanel("Panel", heroPanel, "HeroLevelOuter");
    const levelContainer = $.CreatePanel("Panel", levelOuter, "HeroLevelContainer");
    const levelLabel = $.CreatePanel("Label", levelContainer, "LevelNumber");
    levelLabel.text = hasHero ? String(Entities.GetLevel(hero)) : "?";
    const hpMana = $.CreatePanel("Panel", top, "HPMana");
    if (hasHero) {
        const maxHP = Math.max(Entities.GetMaxHealth(hero), 1);
        const hp = Math.max(Entities.GetHealth(hero), 0);
        createProgressBar(hpMana, "HP", hp, maxHP, `${hp} / ${maxHP}`, "HPLabel");
        const maxMana = Math.max(Entities.GetMaxMana(hero), 0);
        const mana = Math.max(Entities.GetMana(hero), 0);
        createProgressBar(hpMana, "Mana", mana, Math.max(1, maxMana), `${mana} / ${maxMana}`, "ManaLabel");
    }
    else {
        hpMana.style.visibility = "collapse";
    }
    const rankData = (_d = info.tRankData) !== null && _d !== void 0 ? _d : {};
    const bonusInfo = $.CreatePanel("Panel", top, "PlayerBonusInfo");
    const rank = $.CreatePanel("Label", bonusInfo, "Rank");
    rank.text = `${$.Localize("#Score")}: ${(_e = rankData.score) !== null && _e !== void 0 ? _e : "?"}`;
    const matches = $.CreatePanel("Label", bonusInfo, "Matches");
    matches.text = `${$.Localize("#play_time")}: ${(_f = rankData.play_time) !== null && _f !== void 0 ? _f : "?"}`;
    const scepterShard = $.CreatePanel("Panel", top, "ScepterShard");
    const scepter = $.CreatePanel("Panel", scepterShard, "Scepter");
    const shard = $.CreatePanel("Panel", scepterShard, "Shard");
    if (hasHero) {
        scepter.SetHasClass("Active", Entities.HasScepter(hero));
        shard.SetHasClass("Active", hasBuff(hero, "modifier_item_aghanims_shard"));
    }
    else {
        scepter.SetHasClass("Active", false);
        shard.SetHasClass("Active", false);
    }
    const main = $.CreatePanel("Panel", playerPanel, "Main");
    const items = $.CreatePanel("Panel", main, "Items");
    const inventory = $.CreatePanel("Panel", items, "Inventory");
    const createItemSlot = (container, slot, panelId = "Item") => {
        const itemPanel = $.CreatePanel("Panel", container, panelId);
        itemPanel.SetAttributeInt("item_slot", slot);
        const itemImage = $.CreatePanel("DOTAItemImage", itemPanel, "ItemImage");
        const itemCooldownOverlay = $.CreatePanel("Panel", itemPanel, "ItemCooldownOverlay");
        itemCooldownOverlay.hittest = false;
        itemCooldownOverlay.style.visibility = "collapse";
        const itemCooldownLabel = $.CreatePanel("Label", itemPanel, "ItemCooldownLabel");
        itemCooldownLabel.visible = false;
        itemCooldownLabel.text = "";
        itemPanel.SetPanelEvent("onactivate", () => {
            if (!GameUI.IsAltDown()) {
                return;
            }
            if (!hasHero) {
                return;
            }
            const currentHero = Players.GetPlayerHeroEntityIndex(iPlayerID);
            if (currentHero === -1) {
                return;
            }
            const item = Entities.GetItemInSlot(currentHero, slot);
            if (item === -1) {
                return;
            }
            pvpPingItem(currentHero, item, iPlayerID);
        });
        itemPanel.SetPanelEvent("onmouseover", () => {
            if (!hasHero) {
                return;
            }
            const currentHero = Players.GetPlayerHeroEntityIndex(iPlayerID);
            if (currentHero === -1) {
                return;
            }
            const item = Entities.GetItemInSlot(currentHero, slot);
            if (item === -1) {
                return;
            }
            $.DispatchEvent("DOTAShowAbilityTooltip", itemPanel, Abilities.GetAbilityName(item));
        });
        itemPanel.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideAbilityTooltip", itemPanel);
        });
    };
    for (let slot = PVP_DOTA_ITEM_SLOT_MIN; slot <= PVP_DOTA_ITEM_SLOT_MAX; slot++) {
        createItemSlot(inventory, slot);
    }
    const backpack = $.CreatePanel("Panel", items, "Backpack");
    for (let slot = PVP_DOTA_BACKPACK_SLOT_MIN; slot <= PVP_DOTA_BACKPACK_SLOT_MAX; slot++) {
        createItemSlot(backpack, slot, "BackpackItem");
    }
    const neutralSmoke = $.CreatePanel("Panel", items, "NeutralSmoke");
    const neutralContainer = $.CreatePanel("Panel", neutralSmoke, "NeutralItem");
    const neutralCooldownOverlay = $.CreatePanel("Panel", neutralContainer, "ItemCooldownOverlay");
    neutralCooldownOverlay.hittest = false;
    neutralCooldownOverlay.style.visibility = "collapse";
    const neutralCooldownLabel = $.CreatePanel("Label", neutralContainer, "ItemCooldownLabel");
    neutralCooldownLabel.visible = false;
    neutralCooldownLabel.text = "";
    neutralContainer.SetPanelEvent("onactivate", () => {
        if (!GameUI.IsAltDown()) {
            return;
        }
        if (!hasHero) {
            return;
        }
        const currentHero = Players.GetPlayerHeroEntityIndex(iPlayerID);
        if (currentHero === -1) {
            return;
        }
        const neutralItem = Entities.GetItemInSlot(currentHero, 16);
        if (neutralItem === -1) {
            return;
        }
        pvpPingItem(currentHero, neutralItem, iPlayerID);
    });
    neutralContainer.SetPanelEvent("onmouseover", () => {
        if (!hasHero) {
            return;
        }
        const currentHero = Players.GetPlayerHeroEntityIndex(iPlayerID);
        if (currentHero === -1) {
            return;
        }
        const neutralItem = Entities.GetItemInSlot(currentHero, 16);
        if (neutralItem === -1) {
            return;
        }
        $.DispatchEvent("DOTAShowAbilityTooltip", neutralContainer, Abilities.GetAbilityName(neutralItem));
    });
    neutralContainer.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideAbilityTooltip", neutralContainer);
    });
    const abilityPanel = $.CreatePanel("Panel", main, "Abilities");
    if (hasHero) {
        syncAbilityPanel(abilityPanel, hero, iPlayerID);
    }
    else {
        abilityPanel.style.visibility = "collapse";
    }
    updatePlayerPanel(playerPanel);
}
function createBetPanel(teamMain, teamID, enabled, showTeamBetSummary) {
    const teamRight = $.CreatePanel("Panel", teamMain, "TeamRight");
    teamRight.style.visibility = "visible";
    teamRight.SetHasClass("SummaryMode", showTeamBetSummary);
    const teamBetListHeader = $.CreatePanel("Label", teamRight, "TeamBetListHeader");
    teamBetListHeader.AddClass("TeamBetListHeaderLabel");
    teamBetListHeader.text = $.Localize("#PvP_team_player_bets");
    teamBetListHeader.style.visibility = showTeamBetSummary ? "visible" : "collapse";
    const bet = $.CreatePanel("Panel", teamRight, "Bet");
    bet.style.visibility = enabled ? "visible" : "collapse";
    const top = $.CreatePanel("Panel", bet, "Top");
    const minusButton = $.CreatePanel("Button", top, "BetDecrease");
    minusButton.AddClass("BetChangeButton");
    const valueField = $.CreatePanel("Panel", top, "BetValueField");
    const textEntry = $.CreatePanel("TextEntry", valueField, "BetInputEntry", {
        placeholder: "",
        maxchars: "5",
        textmode: "numeric",
    });
    const valueDisplay = $.CreatePanel("Label", valueField, "BetValueDisplay");
    valueDisplay.hittest = false;
    betInputs.push(textEntry);
    const plusButton = $.CreatePanel("Button", top, "BetIncrease");
    plusButton.AddClass("BetChangeButton");
    const teamKey = String(teamID);
    const rememberPendingBet = () => {
        pendingBetByTeam[teamKey] = Math.max(0, Number(textEntry.text) || 0);
    };
    {
        const playerGold = Players.GetGold(Players.GetLocalPlayer());
        const maxBet = Math.floor(playerGold * 0.5);
        const remembered = pendingBetByTeam[teamKey];
        const initial = remembered !== undefined ? Math.max(0, Math.min(maxBet, remembered)) : 0;
        textEntry.text = String(initial);
    }
    const refreshValueDisplay = () => {
        const rawText = textEntry.text.trim();
        const editing = valueField.BHasClass("Editing");
        const numericValue = Number(rawText) || 0;
        const text = rawText === "" ? "" : formatBetGoldDisplay(numericValue);
        valueDisplay.SetHasClass("Empty", rawText === "" && !editing);
        valueField.SetHasClass("Pristine", numericValue <= 0);
        valueDisplay.text = rawText === "" ? (editing ? "|" : "0") : editing ? `${text}|` : text;
    };
    const setEditing = (editing) => {
        valueField.SetHasClass("Editing", editing);
        refreshValueDisplay();
    };
    // Allow click-to-edit.
    valueField.SetPanelEvent("onmouseactivate", () => {
        setEditing(true);
        setSelectedQuick(null);
        textEntry.text = "";
        refreshValueDisplay();
        textEntry.SetFocus();
    });
    textEntry.SetPanelEvent("onfocus", () => setEditing(true));
    textEntry.SetPanelEvent("onblur", () => setEditing(false));
    const quickRow = $.CreatePanel("Panel", bet, "QuickRow");
    const quickButtons = [
        { id: "Quick10", label: "10%", fraction: 0.1 },
        { id: "Quick25", label: "25%", fraction: 0.25 },
        { id: "Quick50", label: "50%", fraction: 0.5 },
        { id: "Quick75", label: "75%", fraction: 0.75 },
    ];
    const quickSlots = [];
    const setSelectedQuick = (selectedKey) => {
        for (const s of quickSlots) {
            s.btn.SetHasClass("Selected", selectedKey !== null && s.key === selectedKey);
        }
        if (selectedKey) {
            pendingQuickKeyByTeam[teamKey] = selectedKey;
        }
        else {
            delete pendingQuickKeyByTeam[teamKey];
        }
    };
    const setBetFraction = (fraction, selectedKey) => {
        const playerGold = Players.GetGold(Players.GetLocalPlayer());
        const maxBet = Math.floor(playerGold * 0.5);
        const desired = Math.floor(maxBet * fraction);
        textEntry.text = String(Math.max(0, Math.min(maxBet, desired)));
        rememberPendingBet();
        refreshValueDisplay();
        if (selectedKey) {
            setSelectedQuick(selectedKey);
        }
    };
    const bindQuickBet = (btn, fn) => {
        btn.SetPanelEvent("onactivate", fn);
        btn.SetPanelEvent("onmouseactivate", fn);
    };
    for (const def of quickButtons) {
        const btn = $.CreatePanel("TextButton", quickRow, def.id);
        btn.AddClass("BetQuickButton");
        btn.text = def.label;
        quickSlots.push({ key: def.id, btn });
        bindQuickBet(btn, () => setBetFraction(def.fraction, def.id));
    }
    const maxRow = $.CreatePanel("Panel", bet, "MaxRow");
    const maxBtn = $.CreatePanel("TextButton", maxRow, "QuickMax");
    maxBtn.AddClass("BetQuickButton");
    maxBtn.AddClass("Max");
    maxBtn.AddClass("MaxOnly");
    maxBtn.text = $.Localize("#PvP_bet_all_in").trim();
    quickSlots.push({ key: "QuickMax", btn: maxBtn });
    bindQuickBet(maxBtn, () => setBetFraction(1.0, "QuickMax"));
    const rememberedQuickKey = pendingQuickKeyByTeam[teamKey];
    if (rememberedQuickKey) {
        setSelectedQuick(rememberedQuickKey);
    }
    minusButton.SetPanelEvent("onactivate", () => {
        const current = Number(textEntry.text) || 0;
        textEntry.text = String(Math.max(0, current - 100));
        rememberPendingBet();
        refreshValueDisplay();
    });
    plusButton.SetPanelEvent("onactivate", () => {
        const playerGold = Players.GetGold(Players.GetLocalPlayer());
        const maxBet = Math.floor(playerGold * 0.5);
        const current = Number(textEntry.text) || 0;
        textEntry.text = String(Math.min(maxBet, current + 100));
        rememberPendingBet();
        refreshValueDisplay();
    });
    textEntry.SetPanelEvent("ontextentrychange", () => {
        onBetNumberChange(textEntry);
        rememberPendingBet();
        if (valueField.BHasClass("Editing")) {
            setSelectedQuick(null);
        }
        refreshValueDisplay();
    });
    const bottomPanel = $.CreatePanel("Panel", bet, "Bottom");
    const betButton = $.CreatePanel("TextButton", bottomPanel, "BetButton");
    betButton.AddClass("BetButtons");
    betButton.text = $.Localize("#PvP_bet_timer").replace("([d:time]с)", "").replace("([d:time]s)", "").replace("[d:time]", "").trim();
    betButton.enabled = enabled;
    let betSubmitted = false;
    betButton.SetPanelEvent("onactivate", () => {
        if (!enabled || betSubmitted) {
            return;
        }
        const betValue = Number(textEntry.text) || 0;
        if (betValue <= 0) {
            return;
        }
        betSubmitted = true;
        betButton.enabled = false;
        betButton.AddClass("Submitted");
        GameEvents.SendCustomGameEventToServer("ConfirmBet", {
            value: betValue,
            wish_team_id: teamID,
        });
    });
    refreshValueDisplay();
    setEditing(false);
}
function populateTeamBetSummary(parent, summary, duelists) {
    var _a, _b;
    parent.RemoveAndDeleteChildren();
    if (!summary) {
        summary = {};
    }
    const entries = [];
    for (const key in summary) {
        const entry = summary[key];
        if (!entry)
            continue;
        const iPlayerID = ((_a = entry.nPlayerId) !== null && _a !== void 0 ? _a : -1);
        const iGold = (_b = entry.nValue) !== null && _b !== void 0 ? _b : 0;
        if (iPlayerID === -1)
            continue;
        if (duelists.has(iPlayerID)) {
            continue;
        }
        entries.push({ playerId: iPlayerID, gold: iGold });
    }
    entries.sort((a, b) => b.gold - a.gold);
    if (entries.length === 0) {
        const empty = $.CreatePanel("Label", parent, "NoBetRecords");
        empty.text = $.Localize("#PvP_team_no_bets");
        return;
    }
    for (const e of entries) {
        createTeamBetRecord(parent, e);
    }
}
function createTeamBetRecord(parent, e) {
    const heroName = Players.GetPlayerSelectedHero(e.playerId);
    const record = $.CreatePanel("Panel", parent, "BetRecord");
    record.hittest = false;
    const heroIcon = $.CreatePanel("DOTAHeroImage", record, "HeroIcon");
    heroIcon.hittest = false;
    heroIcon.heroname = heroName;
    heroIcon.heroimagestyle = "icon";
    const goldIcon = $.CreatePanel("Image", record, "GoldIcon");
    goldIcon.hittest = false;
    goldIcon.SetImage("s2r://panorama/images/hud/reborn/gold_small_psd.vtex");
    const goldLabel = $.CreatePanel("Label", record, "BetGold");
    goldLabel.hittest = false;
    goldLabel.text = formatBetGoldDisplay(e.gold);
}
function refreshHistoryPage() {
    var _a, _b, _c, _d, _e;
    const record = CustomNetTables.GetTableValue("pvp_record", String(Players.GetLocalPlayer()));
    const totalReward = (_a = record === null || record === void 0 ? void 0 : record.total_bet_reward) !== null && _a !== void 0 ? _a : 0;
    historyList.RemoveAndDeleteChildren();
    const historySource = (_b = record === null || record === void 0 ? void 0 : record.bet_history) !== null && _b !== void 0 ? _b : {};
    const entries = [];
    for (const key in historySource) {
        const item = historySource[key];
        if (item) {
            entries.push(item);
        }
    }
    entries.reverse();
    let wins = 0;
    let losses = 0;
    for (const entry of entries) {
        if (((_c = entry.value) !== null && _c !== void 0 ? _c : 0) > 0) {
            wins++;
        }
        else {
            losses++;
        }
    }
    let streak = 0;
    let streakWon = false;
    if (entries.length > 0) {
        streakWon = ((_d = entries[0].value) !== null && _d !== void 0 ? _d : 0) > 0;
        for (const entry of entries) {
            const won = ((_e = entry.value) !== null && _e !== void 0 ? _e : 0) > 0;
            if (won === streakWon) {
                streak++;
            }
            else {
                break;
            }
        }
    }
    let summary = `${$.Localize("#PvP_bet_History_summary")}${totalReward}`;
    if (entries.length > 0) {
        const streakSign = streakWon ? "▲" : "▼";
        summary += `   ·   ${wins}W / ${losses}L   ·   ${streakSign}${streak}`;
    }
    historySummary.text = summary;
    const historyLimit = bPass ? 500 : 3;
    for (let i = 0; i < entries.length && i < historyLimit; i++) {
        const entry = entries[i];
        createHistoryRecord(entry);
    }
}
function updateDynamicValues() {
    if (!mainPage || !mainPage.IsValid()) {
        return;
    }
    updateBetButtonsText();
    const panels = [];
    collectPanelsById(mainPage, "PlayerInfo", panels);
    for (const panel of panels) {
        updatePlayerPanel(panel);
    }
}
function refreshTeamBetSummaries() {
    if (!mainPage || !mainPage.IsValid()) {
        return;
    }
    const sections = [];
    collectPanelsById(mainPage, "TeamBetListSection", sections);
    if (sections.length === 0) {
        return;
    }
    const duelists = new Set();
    for (const teamId in dataList) {
        const duelTeam = dataList[teamId];
        if (!duelTeam)
            continue;
        for (const info of duelTeam) {
            if (info.iPlayerID !== undefined && info.iPlayerID !== -1) {
                duelists.add(info.iPlayerID);
            }
        }
    }
    for (const section of sections) {
        if (section.style.visibility === "collapse") {
            continue;
        }
        const teamId = section.GetAttributeInt("team_id", -1);
        if (teamId === -1) {
            continue;
        }
        populateTeamBetSummary(section, betMap[String(teamId)], duelists);
    }
}
function updateBetButtonsText() {
    if (!mainPage || !mainPage.IsValid()) {
        return;
    }
    const playerGold = Players.GetGold(Players.GetLocalPlayer());
    const maxBet = Math.floor(playerGold * 0.5);
    const betButtons = [];
    collectPanelsById(mainPage, "BetButton", betButtons);
    for (const button of betButtons) {
        const textButton = button;
        textButton.text = $.Localize("#PvP_bet_timer")
            .replace("([d:time]с)", "")
            .replace("([d:time]s)", "")
            .replace("[d:time]", "")
            .trim();
    }
    const maxButtons = [];
    collectPanelsById(mainPage, "MaxButton", maxButtons);
    for (const button of maxButtons) {
        const textButton = button;
        textButton.text = `${$.Localize("#PvP_bet_all_in")}(${maxBet})`;
    }
    if (footerMinBet)
        footerMinBet.text = `${$.Localize("#pvp_footer_min_bet")} 1`;
    if (footerMaxBet)
        footerMaxBet.text = `${$.Localize("#pvp_footer_max_bet")} ${maxBet}`;
    updatePvpStatus();
}
function updatePvpStatus() {
    if (!pvpStatus || !pvpStatusText || !pvpStatusValue) {
        return;
    }
    const visible = pvpWindowState && page === 0;
    pvpStatus.visible = visible;
    if (!visible) {
        return;
    }
    pvpStatusValue.style.color = "#64d64f";
    pvpStatus.SetHasClass("PotentialWin", false);
    setPvpStatusKind("Betting");
    if (showBet && canBet && !selfPvp) {
        pvpStatusText.text = `${$.Localize("#pvp_footer_time")} `;
        pvpStatusValue.text = `${betTime}${$.Localize("#pvp_footer_seconds")}`;
        return;
    }
    pvpStatusText.text = "";
    pvpStatusValue.text = "";
    if (hasPlacedBet) {
        if (potentialBetWin > 0) {
            setPvpStatusKind("Potential");
            pvpStatus.SetHasClass("PotentialWin", true);
            pvpStatusText.text = `${$.Localize("#pvp_status_potential_profit")} `;
            pvpStatusValue.text = `+${formatBetGoldDisplay(potentialBetWin)}`;
        }
        pvpStatusValue.style.color = "#64d64f";
    }
}
function setPvpStatusKind(kind) {
    if (!pvpStatus) {
        return;
    }
    for (const cls of ["StatusBetting", "StatusPotential", "StatusPlaced", "StatusSelfDuel", "StatusDuelLive"]) {
        pvpStatus.SetHasClass(cls, false);
    }
    pvpStatus.SetHasClass(`Status${kind}`, true);
    if (!pvpStatusIcon) {
        return;
    }
    const iconByKind = {
        Betting: "s2r://panorama/images/control_icons/history_png.vtex",
        Potential: "s2r://panorama/images/control_icons/history_png.vtex",
        Placed: "s2r://panorama/images/control_icons/history_png.vtex",
        SelfDuel: "s2r://panorama/images/control_icons/history_png.vtex",
        DuelLive: "s2r://panorama/images/control_icons/history_png.vtex",
    };
    pvpStatusIcon.SetImage(iconByKind[kind]);
}
function updatePlayerPanel(panel) {
    const playerId = panel.GetAttributeInt("player_id", -1);
    if (playerId === -1) {
        return;
    }
    const hero = Players.GetPlayerHeroEntityIndex(playerId);
    if (hero === -1) {
        return;
    }
    const hpPanel = panel.FindChildTraverse("HP");
    if (hpPanel) {
        const maxHP = Math.max(Entities.GetMaxHealth(hero), 1);
        const hp = Math.max(Entities.GetHealth(hero), 0);
        updateProgressBar(hpPanel, hp, maxHP, `${hp} / ${maxHP}`, "HPLabel");
    }
    const manaPanel = panel.FindChildTraverse("Mana");
    if (manaPanel) {
        const maxMana = Math.max(Entities.GetMaxMana(hero), 0);
        const mana = Math.max(Entities.GetMana(hero), 0);
        manaPanel.style.visibility = maxMana > 0 ? "visible" : "collapse";
        updateProgressBar(manaPanel, mana, Math.max(1, maxMana), `${mana} / ${maxMana}`, "ManaLabel");
    }
    const scepter = panel.FindChildTraverse("Scepter");
    const shard = panel.FindChildTraverse("Shard");
    if (scepter)
        scepter.SetHasClass("Active", Entities.HasScepter(hero));
    if (shard)
        shard.SetHasClass("Active", hasBuff(hero, "modifier_item_aghanims_shard"));
    const inventory = panel.FindChildTraverse("Inventory");
    if (inventory) {
        for (let slot = PVP_DOTA_ITEM_SLOT_MIN; slot <= PVP_DOTA_ITEM_SLOT_MAX; slot++) {
            const itemPanel = inventory.GetChild(slot);
            if (!itemPanel) {
                continue;
            }
            const itemImage = itemPanel.FindChildTraverse("ItemImage");
            if (!itemImage) {
                continue;
            }
            const item = Entities.GetItemInSlot(hero, slot);
            itemImage.itemname = item === -1 ? "" : Abilities.GetAbilityName(item);
            const itemCooldownOverlay = itemPanel.FindChildTraverse("ItemCooldownOverlay");
            const itemCooldownLabel = itemPanel.FindChildTraverse("ItemCooldownLabel");
            const itemCooldown = item === -1 ? 0 : Math.floor(Abilities.GetCooldownTimeRemaining(item));
            const showItemCooldown = itemCooldown > 0 && !selfPvp;
            if (itemCooldownOverlay) {
                itemCooldownOverlay.style.visibility = showItemCooldown ? "visible" : "collapse";
            }
            if (itemCooldownLabel) {
                itemCooldownLabel.visible = showItemCooldown;
                itemCooldownLabel.text = showItemCooldown ? String(itemCooldown) : "";
            }
        }
    }
    const backpack = panel.FindChildTraverse("Backpack");
    if (backpack) {
        for (let slot = PVP_DOTA_BACKPACK_SLOT_MIN; slot <= PVP_DOTA_BACKPACK_SLOT_MAX; slot++) {
            const itemPanel = backpack.GetChild(slot - PVP_DOTA_BACKPACK_SLOT_MIN);
            if (!itemPanel) {
                continue;
            }
            const itemImage = itemPanel.FindChildTraverse("ItemImage");
            if (!itemImage) {
                continue;
            }
            const item = Entities.GetItemInSlot(hero, slot);
            itemImage.itemname = item === -1 ? "" : Abilities.GetAbilityName(item);
            const itemCooldownOverlay = itemPanel.FindChildTraverse("ItemCooldownOverlay");
            const itemCooldownLabel = itemPanel.FindChildTraverse("ItemCooldownLabel");
            const itemCooldown = item === -1 ? 0 : Math.floor(Abilities.GetCooldownTimeRemaining(item));
            const showItemCooldown = itemCooldown > 0 && !selfPvp;
            if (itemCooldownOverlay) {
                itemCooldownOverlay.style.visibility = showItemCooldown ? "visible" : "collapse";
            }
            if (itemCooldownLabel) {
                itemCooldownLabel.visible = showItemCooldown;
                itemCooldownLabel.text = showItemCooldown ? String(itemCooldown) : "";
            }
        }
    }
    const neutralContainer = panel.FindChildTraverse("NeutralItem");
    if (neutralContainer) {
        const neutralItem = Entities.GetItemInSlot(hero, 16);
        let neutralImage = neutralContainer.FindChildTraverse("NeutralItemImage");
        if (neutralItem === -1) {
            if (neutralImage) {
                neutralImage.DeleteAsync(0);
            }
        }
        else {
            if (!neutralImage) {
                neutralImage = $.CreatePanel("DOTAItemImage", neutralContainer, "NeutralItemImage");
            }
            neutralImage.itemname = Abilities.GetAbilityName(neutralItem);
        }
        const neutralCooldownOverlay = neutralContainer.FindChildTraverse("ItemCooldownOverlay");
        const neutralCooldownLabel = neutralContainer.FindChildTraverse("ItemCooldownLabel");
        const neutralCooldown = neutralItem === -1 ? 0 : Math.floor(Abilities.GetCooldownTimeRemaining(neutralItem));
        const showNeutralCooldown = neutralCooldown > 0 && !selfPvp;
        if (neutralCooldownOverlay) {
            neutralCooldownOverlay.style.visibility = showNeutralCooldown ? "visible" : "collapse";
        }
        if (neutralCooldownLabel) {
            neutralCooldownLabel.visible = showNeutralCooldown;
            neutralCooldownLabel.text = showNeutralCooldown ? String(neutralCooldown) : "";
        }
    }
    const abilityPanel = panel.FindChildTraverse("Abilities");
    if (abilityPanel) {
        syncAbilityPanel(abilityPanel, hero, playerId);
        const count = abilityPanel.GetChildCount();
        for (let i = 0; i < count; i++) {
            const abilitySlot = abilityPanel.GetChild(i);
            if (!abilitySlot)
                continue;
            const abilityIndex = abilitySlot.GetAttributeInt("ability_index", -1);
            if (abilityIndex === -1)
                continue;
            const abilityLevel = Abilities.GetLevel(abilityIndex);
            const cooldown = Math.floor(Abilities.GetCooldownTimeRemaining(abilityIndex));
            const abilityImage = abilitySlot.FindChildTraverse("AbilityImage");
            if (abilityImage) {
                abilityImage.SetHasClass("UnLearned", abilityLevel <= 0);
            }
            const cooldownOverlay = abilitySlot.FindChildTraverse("CooldownOverlay");
            if (cooldownOverlay) {
                cooldownOverlay.style.visibility = cooldown > 0 && !selfPvp ? "visible" : "collapse";
            }
            const cooldownLabel = abilitySlot.FindChildTraverse("CooldownLabel");
            if (cooldownLabel) {
                cooldownLabel.visible = cooldown > 0 && !selfPvp;
                cooldownLabel.text = String(cooldown);
            }
            const levelOverlay = abilitySlot.FindChildTraverse("LevelOverlay");
            if (levelOverlay) {
                levelOverlay.visible = !selfPvp;
            }
            const levelLabel = abilitySlot.FindChildTraverse("LevelLabel");
            if (levelLabel) {
                levelLabel.text = String(abilityLevel);
            }
        }
    }
}
function collectHeroAbilities(hero) {
    const list = [];
    for (let index = 0; index < Entities.GetAbilityCount(hero); index++) {
        const ability = Entities.GetAbility(hero, index);
        if (ability === -1) {
            continue;
        }
        if (Abilities.GetAbilityType(ability) === 2) {
            continue;
        }
        if (Abilities.IsHidden(ability)) {
            continue;
        }
        if ((Abilities.GetBehavior(ability) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_INNATE_UI) !== 0) {
            continue;
        }
        const abilityName = Abilities.GetAbilityName(ability);
        if (knownInnateAbilityNames.has(abilityName)) {
            continue;
        }
        list.push(ability);
    }
    return list;
}
function syncAbilityPanel(abilityPanel, hero, playerId) {
    const desired = collectHeroAbilities(hero);
    const current = [];
    const count = abilityPanel.GetChildCount();
    for (let i = 0; i < count; i++) {
        const slot = abilityPanel.GetChild(i);
        const abilityIndex = slot.GetAttributeInt("ability_index", -1);
        if (abilityIndex !== -1) {
            current.push(abilityIndex);
        }
    }
    let needsRebuild = desired.length !== current.length;
    if (!needsRebuild) {
        for (let i = 0; i < desired.length; i++) {
            if (desired[i] !== current[i]) {
                needsRebuild = true;
                break;
            }
        }
    }
    if (!needsRebuild) {
        return;
    }
    abilityPanel.RemoveAndDeleteChildren();
    for (const ability of desired) {
        createAbilitySlot(abilityPanel, ability, playerId);
    }
}
function createAbilitySlot(abilityPanel, ability, playerId) {
    const abilityName = Abilities.GetAbilityName(ability);
    const abilityLevel = Abilities.GetLevel(ability);
    const cooldown = Math.floor(Abilities.GetCooldownTimeRemaining(ability));
    const abilitySlot = $.CreatePanel("Panel", abilityPanel, "Ability");
    abilitySlot.SetAttributeInt("ability_index", ability);
    abilitySlot.SetPanelEvent("onactivate", () => {
        if (!GameUI.IsAltDown()) {
            return;
        }
        const currentHero = Players.GetPlayerHeroEntityIndex(playerId);
        if (currentHero === -1) {
            return;
        }
        pvpPingAbility(currentHero, ability, playerId);
    });
    abilitySlot.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAShowAbilityTooltip", abilitySlot, abilityName);
    });
    abilitySlot.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHideAbilityTooltip", abilitySlot);
    });
    const abilityImage = $.CreatePanel("DOTAAbilityImage", abilitySlot, "AbilityImage");
    abilityImage.abilityname = abilityName;
    abilityImage.SetHasClass("UnLearned", abilityLevel <= 0);
    $.Schedule(0, () => {
        if (!abilitySlot.IsValid() || !abilityImage.IsValid()) {
            return;
        }
        if (abilityImage.BHasClass("UseInnateIcon")) {
            knownInnateAbilityNames.add(abilityName);
            abilitySlot.DeleteAsync(0);
        }
    });
    const cooldownOverlay = $.CreatePanel("Panel", abilitySlot, "CooldownOverlay");
    cooldownOverlay.hittest = false;
    cooldownOverlay.style.visibility = cooldown > 0 && !selfPvp ? "visible" : "collapse";
    const cooldownLabel = $.CreatePanel("Label", abilitySlot, "CooldownLabel");
    cooldownLabel.visible = cooldown > 0 && !selfPvp;
    cooldownLabel.text = String(cooldown);
    const levelOverlay = $.CreatePanel("Panel", abilitySlot, "LevelOverlay");
    levelOverlay.hittest = false;
    levelOverlay.visible = !selfPvp;
    const levelContainer = $.CreatePanel("Panel", levelOverlay, "LevelContainer");
    const levelText = $.CreatePanel("Label", levelContainer, "LevelLabel");
    levelText.text = String(abilityLevel);
}
function collectPanelsById(rootPanel, id, result) {
    if (!rootPanel) {
        return;
    }
    if (rootPanel.id === id) {
        result.push(rootPanel);
    }
    const count = rootPanel.GetChildCount();
    for (let i = 0; i < count; i++) {
        const child = rootPanel.GetChild(i);
        collectPanelsById(child, id, result);
    }
}
function createHistoryRecord(entry) {
    var _a, _b, _c, _d, _e, _f;
    const winners = (_a = entry.winners) !== null && _a !== void 0 ? _a : {};
    const losers = (_b = entry.losers) !== null && _b !== void 0 ? _b : {};
    const value = (_c = entry.value) !== null && _c !== void 0 ? _c : 0;
    const bet = (_d = entry.bet) !== null && _d !== void 0 ? _d : 0;
    const multiplier = (_e = entry.multiplier) !== null && _e !== void 0 ? _e : 0;
    const pool = (_f = entry.pool) !== null && _f !== void 0 ? _f : 0;
    const betOnWinner = value > 0;
    const record = $.CreatePanel("Panel", historyList, "BetRecord");
    const playersPanel = $.CreatePanel("Panel", record, "Players");
    const winnersPanel = $.CreatePanel("Panel", playersPanel, "Winners");
    winnersPanel.AddClass("PlayerList");
    addHistoryHeroList(winnersPanel, winners);
    const versus = $.CreatePanel("Panel", playersPanel, "Versus");
    const versusLabel = $.CreatePanel("Label", versus, "VersusLabel");
    versusLabel.text = "VS";
    const losersPanel = $.CreatePanel("Panel", playersPanel, "Losers");
    losersPanel.AddClass("PlayerList");
    addHistoryHeroList(losersPanel, losers);
    const values = $.CreatePanel("Panel", record, "Values");
    const pill = $.CreatePanel("Panel", values, "ValuePill");
    pill.SetHasClass("Win", value > 0);
    pill.SetHasClass("Lose", value <= 0);
    const betValue = $.CreatePanel("Label", pill, "BetValue");
    betValue.text = value > 0 ? `+${value}` : String(value);
    betValue.SetHasClass("Win", value > 0);
    const goldIcon = $.CreatePanel("Image", pill, "GoldIcon");
    goldIcon.SetImage("s2r://panorama/images/hud/reborn/gold_small_psd.vtex");
    if (bet > 0 || pool > 0 || (betOnWinner && multiplier > 0)) {
        const meta = $.CreatePanel("Panel", values, "ValueMeta");
        if (pool > 0) {
            createMetaPair(meta, "pool", String(pool));
        }
        if (bet > 0) {
            createMetaPair(meta, "bet", String(bet));
        }
        if (betOnWinner && multiplier > 0) {
            const mult = $.CreatePanel("Label", meta, "");
            mult.AddClass("MetaMult");
            mult.text = `×${multiplier.toFixed(2)}`;
        }
    }
}
function createMetaPair(parent, labelKey, valueText) {
    const pair = $.CreatePanel("Panel", parent, "");
    pair.AddClass("MetaPair");
    const label = $.CreatePanel("Label", pair, "");
    label.AddClass("MetaLabel");
    label.text = labelKey;
    const value = $.CreatePanel("Label", pair, "");
    value.AddClass("MetaValue");
    value.text = valueText;
}
function addHistoryHeroList(parent, list) {
    for (const key in list) {
        const iPlayerID = list[key];
        if (iPlayerID === -1) {
            continue;
        }
        const heroImage = $.CreatePanel("DOTAHeroImage", parent, "HeroImage");
        heroImage.heroimagestyle = "icon";
        heroImage.heroname = Players.GetPlayerSelectedHero(iPlayerID);
    }
}
function createProgressBar(parent, id, value, max, text, labelId) {
    const panel = $.CreatePanel("Panel", parent, id);
    panel.AddClass("ProgressBar");
    const left = $.CreatePanel("Panel", panel, "");
    left.AddClass("ProgressBarLeft");
    const right = $.CreatePanel("Panel", panel, "");
    right.AddClass("ProgressBarRight");
    const label = $.CreatePanel("Label", panel, labelId);
    updateProgressBar(panel, value, max, text, labelId);
}
function updateProgressBar(panel, value, max, text, labelId) {
    const left = panel.GetChild(0);
    const right = panel.GetChild(1);
    const label = panel.FindChildTraverse(labelId);
    const normalized = Math.max(0, Math.min(1, max > 0 ? value / max : 0));
    const leftWidth = Math.floor(normalized * 100);
    if (left) {
        left.style.width = `${leftWidth}%`;
    }
    if (right) {
        right.style.width = `${100 - leftWidth}%`;
    }
    if (label) {
        label.text = text;
    }
}
function onBetNumberChange(textEntry) {
    const value = Number(textEntry.text) || 0;
    const playerGold = Players.GetGold(Players.GetLocalPlayer());
    const maxBet = Math.floor(playerGold * 0.5);
    if (value > maxBet) {
        textEntry.text = String(maxBet);
        return;
    }
    if (value < 0) {
        textEntry.text = "0";
    }
}
function clearBetInputs() {
    for (const input of betInputs) {
        if (input && input.IsValid()) {
            input.text = "";
        }
    }
}
function hasBuff(unit, buffName) {
    for (let i = 0; i < Entities.GetNumBuffs(unit); i++) {
        const buff = Entities.GetBuff(unit, i);
        if (Buffs.GetName(unit, buff) === buffName) {
            return true;
        }
    }
    return false;
}
function convertToSteamId32(steamId64) {
    if (!steamId64 || steamId64.length <= 3) {
        return "";
    }
    const body = Number(steamId64.substring(3));
    if (isNaN(body)) {
        return "";
    }
    return String(body - 61197960265728);
}
function pvpPingAbility(hero, ability, iPlayerID) {
    let alert = "";
    if (Entities.IsEnemy(hero)) {
        alert = $.Localize("#PvP_playerinfo_alert_ability_enemy")
            .replace("[s:hero]", $.Localize(`#${Entities.GetUnitName(hero)}`))
            .replace("[s:ability]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(ability)}`));
    }
    else if (iPlayerID === Players.GetLocalPlayer()) {
        alert = $.Localize("#PvP_playerinfo_alert_ability_self")
            .replace("[s:ability]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(ability)}`));
    }
    else {
        alert = $.Localize("#PvP_playerinfo_alert_ability_ally")
            .replace("[s:hero]", $.Localize(`#${Entities.GetUnitName(hero)}`))
            .replace("[s:ability]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(ability)}`));
    }
    alert = alert.replace(/<font color='#\w+'>/g, "").replace(/<\/font>/g, "");
    Game.ServerCmd(`say ${alert}`);
}
function pvpPingItem(hero, item, iPlayerID) {
    if (!GameUI.IsAltDown() || item === -1) {
        return;
    }
    let alert = "";
    if (Entities.IsEnemy(hero)) {
        alert = $.Localize("#PvP_playerinfo_alert_item_enemy")
            .replace("[s:hero]", $.Localize(`#${Entities.GetUnitName(hero)}`))
            .replace("[s:item]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(item)}`));
    }
    else if (iPlayerID === Players.GetLocalPlayer()) {
        alert = $.Localize("#PvP_playerinfo_alert_item_self")
            .replace("[s:item]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(item)}`));
    }
    else {
        alert = $.Localize("#PvP_playerinfo_alert_item_ally")
            .replace("[s:hero]", $.Localize(`#${Entities.GetUnitName(hero)}`))
            .replace("[s:item]", $.Localize(`#DOTA_Tooltip_ability_${Abilities.GetAbilityName(item)}`));
    }
    alert = alert.replace(/<font color='#\w+'>/g, "").replace(/<\/font>/g, "");
    Game.ServerCmd(`say ${alert}`);
}