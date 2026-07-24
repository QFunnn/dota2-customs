--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
const MAX_ABILITY_IMAGE_WIDTH = "50px";
const HERO_NAME_PREFIX = "npc_dota_hero_";
const isCheatMode = Game.IsInToolsMode() ? true : Game.GetConvarInt("sv_cheats") == 1;
const UNABLE_TO_BAN_CLASS = "UnableToBan";
const heroSelectHud = findElement("Hud");
const pregame = heroSelectHud === null || heroSelectHud === void 0 ? void 0 : heroSelectHud.FindChildTraverse("PreGame");
const controls = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroPickControls");
const heroAbilitiesToShow = buildMainAbilitiesSet(GameUI.CustomUIConfig().AbilitiesPool);
const abilityToHero = buildAbilityToHeroMap(GameUI.CustomUIConfig().AbilitiesPool);
hideRedundantElements();
const banButton = createBanButton();
const banButtonLabel = banButton.FindChildTraverse("BanButtonLabel");
const heroSelectRoot = $.GetContextPanel();
let topBansAbilitiesPanel;
let bottomRecentAbilitiesBansPanel;
let bottomRecentBansHeroesPanel;
let bottomMyHeroesBansPanel;
let bottomMyAbilitiesBansPanel;
let banPresetsRoot;
let banPresetsListPanel;
let banPresetsToggleArrow;
let selectedBanPresetIndex = null;
let banPresetWasApplied = false;
const bannedAbilitiesSet = new Set();
const bannedHeroesSet = new Set();
const heroSelectListeners = [];
const heroSelectNetTablesListeners = [];
const heroSelectUnhandledListeners = {};
const testBanAbilitiesList = [
    "sven_storm_bolt",
    "sven_warcry",
    "sven_gods_strength",
    "tiny_avalanche",
    "tiny_toss",
    "tiny_tree_grab_lua",
    "tiny_grow",
    "kunkka_torrent",
    "kunkka_tidebringer",
    "kunkka_ghostship",
    "dragon_knight_breathe_fire",
    "dragon_knight_dragon_tail",
    "dragon_knight_dragon_blood",
    "dragon_knight_elder_dragon_form",
    "drow_ranger_frost_arrows",
    "drow_ranger_wave_of_silence",
    "drow_ranger_multishot",
    "drow_ranger_trueshot_lua",
    "drow_ranger_marksmanship",
    "phantom_lancer_spirit_lance",
    "phantom_lancer_doppelwalk",
    "phantom_lancer_phantom_edge",
    "storm_spirit_static_remnant",
    "storm_spirit_electric_vortex",
    "storm_spirit_overload",
    "storm_spirit_ball_lightning_lua",
    "windrunner_shackleshot",
    "windrunner_powershot",
    "windrunner_windrun",
    "windrunner_focusfire",
];
const testBanHeroesList = [
    "life_stealer",
    "phantom_lancer",
    "lina",
    "omniknight",
    "huskar",
    "alchemist",
    "brewmaster"
];
const testRecentBanAbilities = [
    "kunkka_tidebringer",
    "tiny_grow",
    "drow_ranger_multishot",
    "phantom_lancer_phantom_edge",
    "morphling_waveform",
    "rattletrap_power_cogs",
];
const testRecentBansHeroes = [
    "drow_ranger",
    "dragon_knight",
    "windrunner",
    "life_stealer",
    //"storm_spirit"
];
// const res = CustomNetTables.GetTableValue("hero_select", Game.GetLocalPlayerID().toString());
// $.Msg(JSON.stringify(res, null, "\t"))
const myCurrentBansHeroes = new Set([
    "npc_dota_hero_dragon_knight",
    "npc_dota_hero_dragon_knight",
]);
const myCurrentBansAbilities = new Set([
    "windrunner_powershot",
    "windrunner_powershot",
    "windrunner_powershot",
]);
let lastSelectedAbilityPanel = null;
let selectedAbilityPulseToken = 0;
$.RegisterEventHandler("DOTAHeroGridHeroSelected", pregame, (...args) => {
    const heroId = args[0];
    const panel = $.CreatePanel("DOTAHeroImage", teamPickRoot, ""); //это пиздец костыль но он работает. Иначе я хз как из хероИд получать херонейм на панораме
    panel.heroid = heroId;
    const heroName = panel.heroname;
    panel.DeleteAsync(0);
    $.Schedule(0, () => {
        updateHeroCard(heroName);
        toggleBanButton(heroName, BanType.HERO);
    });
});
function updateHeroCard(heroName) {
    const heroAbilitiesPanel = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroAbilities");
    if (heroAbilitiesPanel) {
        heroAbilitiesPanel.visible = false;
        updateHeroAbilitiesPanelState(heroAbilitiesPanel);
        heroAbilitiesPanel.style.flowChildren = "right-wrap";
        heroAbilitiesPanel.style.width = "100%";
        heroAbilitiesPanel.style.height = "fit-children";
        heroAbilitiesPanel.visible = true;
    }
    const heroSimpleDescription = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroSimpleDescription");
    if (heroSimpleDescription) {
        heroSimpleDescription.visible = false;
    }
    updateHeroInspectBanOverlay(heroInspect, heroName);
}
function getSelectedHeroName() {
    $.Msg("Ban button toggled");
    const playerId = Game.GetLocalPlayerID();
    const info = Game.GetPlayerInfo(playerId);
    if (!info)
        return null;
    if (info.player_selected_hero) {
        $.Msg("Return selected hero = " + info.player_selected_hero);
        return info.player_selected_hero;
    }
    if (info.possible_hero_selection) {
        $.Msg("Return possible hero = " + info.possible_hero_selection);
        return info.possible_hero_selection;
    }
    $.Msg("Return hero null");
    return null;
}
function buildMainAbilitiesSet(pool) {
    const set = new Set();
    for (const hero in pool) {
        const abilities = pool[hero];
        for (const key in abilities) {
            if (!isNaN(Number(key))) {
                const ability = abilities[key];
                set.add(ability);
            }
        }
    }
    return set;
}
function buildAbilityToHeroMap(pool) {
    const map = new Map();
    for (const hero in pool) {
        const abilities = pool[hero];
        for (const key in abilities) {
            if (!isNaN(Number(key))) {
                const ab = abilities[key];
                map.set(ab, hero);
            }
        }
    }
    return map;
}
function ensureAbilityBannedOverlay(abilityPanel) {
    let overlay = abilityPanel.FindChild("BannedOverlay");
    if (!overlay) {
        overlay = $.CreatePanel("Panel", abilityPanel, "BannedOverlay");
        overlay.AddClass("AbilityBannedOverlay");
        overlay.hittest = false;
        overlay.style.width = "100%";
        overlay.style.height = "100%";
        overlay.style.zIndex = 999;
        overlay.style.opacity = "0";
    }
    styleBannedOverlay(overlay, "#00000024");
    ensureBannedCircle(overlay, "BannedCircle", "AbilityBannedCircle", "82%", "3px", "#d34848cc");
    ensureBannedCrossLine(overlay, "BannedCrossA", "84%", "5px", "#d34848ff", "rotateZ(45deg)");
    ensureBannedCrossLine(overlay, "BannedCrossB", "84%", "5px", "#d34848ff", "rotateZ(-45deg)");
    return overlay;
}
function ensureHeroBannedOverlay(heroPanel, heroName) {
    let overlay = heroPanel.FindChild("BannedOverlay");
    if (!overlay) {
        overlay = $.CreatePanel("Panel", heroPanel, "BannedOverlay");
        overlay.AddClass("HeroBannedOverlay");
        overlay.hittest = false;
        overlay.style.width = "100%";
        overlay.style.height = "100%";
        overlay.style.zIndex = 999;
        overlay.style.opacity = "0";
    }
    styleBannedOverlay(overlay, "#00000024");
    ensureBannedCircle(overlay, "BannedCircle", "HeroBannedCircle", "78%", "58%", "4px", "#c83f3fcc");
    ensureBannedCrossLine(overlay, "BannedCrossA", "78%", "6px", "#c83f3fff", "rotateZ(45deg)");
    ensureBannedCrossLine(overlay, "BannedCrossB", "78%", "6px", "#c83f3fff", "rotateZ(-45deg)");
    return overlay;
}
function styleBannedOverlay(overlay, backgroundColor) {
    overlay.hittest = false;
    overlay.style.width = "100%";
    overlay.style.height = "100%";
    overlay.style.zIndex = 999;
    overlay.style.backgroundColor = backgroundColor;
}
function ensureBannedCircle(parent, id, className, width, heightOrBorderWidth, borderWidthOrColor, color) {
    let circle = parent.FindChild(id);
    if (!circle) {
        circle = $.CreatePanel("Panel", parent, id);
        circle.AddClass(className);
    }
    const height = color ? heightOrBorderWidth : width;
    const borderWidth = color ? borderWidthOrColor : heightOrBorderWidth;
    const borderColor = color !== null && color !== void 0 ? color : borderWidthOrColor;
    circle.hittest = false;
    circle.style.width = width;
    circle.style.height = height;
    circle.style.horizontalAlign = "center";
    circle.style.verticalAlign = "center";
    circle.style.border = `${borderWidth} solid ${borderColor}`;
    circle.style.borderRadius = "50%";
    circle.style.boxShadow = "0px 0px 3px #000000aa";
    circle.style.zIndex = 998;
    return circle;
}
function ensureBannedCrossLine(parent, id, width, height, color, transform) {
    let line = parent.FindChild(id);
    if (!line) {
        line = $.CreatePanel("Panel", parent, id);
    }
    line.hittest = false;
    line.style.width = width;
    line.style.height = height;
    line.style.horizontalAlign = "center";
    line.style.verticalAlign = "center";
    line.style.backgroundColor = color;
    line.style.boxShadow = "none";
    line.style.borderRadius = "2px";
    line.style.transform = transform;
    line.style.zIndex = 999;
    return line;
}
function updateHeroInspectBanOverlay(inspect, heroName) {
    var _a, _b, _c;
    if (!inspect)
        return;
    const movie = inspect.FindChildTraverse("HeroMovie");
    const playerInfo = Game.GetPlayerInfo(Game.GetLocalPlayerID());
    const resolvedHeroName = (_c = (_b = (_a = heroName !== null && heroName !== void 0 ? heroName : movie === null || movie === void 0 ? void 0 : movie.heroname) !== null && _a !== void 0 ? _a : playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.possible_hero_selection) !== null && _b !== void 0 ? _b : playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.player_selected_hero) !== null && _c !== void 0 ? _c : "";
    const normalizedHeroName = normalizeHeroName(resolvedHeroName);
    cleanupUnsafeHeroInspectOverlay(inspect, movie);
    const portrait = movie !== null && movie !== void 0 ? movie : inspect.FindChildTraverse("HeroPortraitContainer");
    if (!portrait || normalizedHeroName === HERO_NAME_PREFIX)
        return;
    const overlay = ensureHeroBannedOverlay(portrait, normalizedHeroName);
    overlay.style.opacity = bannedHeroesSet.has(normalizedHeroName) ? "1" : "0";
}
function cleanupUnsafeHeroInspectOverlay(inspect, safeTarget) {
    const unsafeTargets = [
        inspect.FindChildTraverse("HeroPortrait"),
        safeTarget === null || safeTarget === void 0 ? void 0 : safeTarget.GetParent(),
    ];
    unsafeTargets.forEach(target => {
        if (!target || target === safeTarget)
            return;
        const overlay = target.FindChild("BannedOverlay");
        if (overlay) {
            overlay.DeleteAsync(0);
        }
        target.RemoveClass("HeroInspectBannedPortrait");
    });
}
function updateHeroAbilitiesPanelState(root) {
    const children = root.Children();
    if (!children)
        return;
    children.forEach(child => {
        updateAbilityPanelState(child);
        updateNestedAbilityImageStates(child);
    });
}
function updateNestedAbilityImageStates(root) {
    const children = root.Children();
    if (!children)
        return;
    children.forEach(child => {
        if (child.paneltype === "DOTAAbilityImage")
            updateAbilityPanelState(child);
        updateNestedAbilityImageStates(child);
    });
}
function updateAbilityPanelState(abilityPanel) {
    var _a;
    const abilityName = abilityPanel.abilityname;
    if (!abilityPanel.IsValid()) {
        $.Msg("AbilityPanel not valid");
        return;
    }
    try {
        abilityPanel.style.width = MAX_ABILITY_IMAGE_WIDTH;
        abilityPanel.style.margin = "0px 5px 5px 0px";
        if (abilityPanel.paneltype == "DOTAAbilityImage") {
            const overlay = ensureAbilityBannedOverlay(abilityPanel);
            if (bannedAbilitiesSet.has(abilityName)) {
                overlay.style.opacity = "1";
                abilityPanel.SetPanelEvent("onmouseactivate", () => { });
                disableSelectedAbilityPanel(abilityPanel);
            }
            else if (heroAbilitiesToShow.has(abilityName) && ((_a = abilityPanel.GetParent()) === null || _a === void 0 ? void 0 : _a.id) !== "SelectedHeroAbilities") {
                abilityPanel.hittest = true;
                if (!isCheatMode) {
                    abilityPanel.SetPanelEvent("onmouseactivate", () => {
                        toggleBanButton(abilityName, BanType.ABILITY);
                        toggleSelectedAbilityPanel(abilityPanel);
                    });
                }
            }
            else {
                abilityPanel.style.washColor = 'rgba(82, 82, 82, 0.5)';
                abilityPanel.style.saturation = '0';
                abilityPanel.AddClass(UNABLE_TO_BAN_CLASS);
            }
        }
    }
    catch (e) {
        $.Msg("[ERROR] " + e);
    }
}
function disableSelectedAbilityPanel(abilityPanel) {
    selectedAbilityPulseToken++;
    abilityPanel.style.border = "0px";
    abilityPanel.style.boxShadow = "none";
    abilityPanel.style.transitionProperty = "none";
    abilityPanel.style.transitionDuration = "0s";
    abilityPanel.style.transitionTimingFunction = "ease-in-out";
}
function startSelectedAbilityPulse(abilityPanel) {
    if (!abilityPanel || !abilityPanel.IsValid())
        return;
    const pulseToken = ++selectedAbilityPulseToken;
    lastSelectedAbilityPanel = abilityPanel;
    let isBright = true;
    abilityPanel.style.transitionProperty = "box-shadow";
    abilityPanel.style.transitionDuration = "1.5s";
    abilityPanel.style.transitionTimingFunction = "ease-in-out";
    const pulse = () => {
        if (pulseToken !== selectedAbilityPulseToken ||
            !abilityPanel.IsValid() ||
            abilityPanel !== lastSelectedAbilityPanel) {
            return;
        }
        abilityPanel.style.boxShadow = isBright
            ? "inset 0px 0px 5px 1px #fa0707cc"
            : "inset 0px 0px 4px 0px #fa070755";
        isBright = !isBright;
        $.Schedule(1.5, pulse);
    };
    pulse();
}
function toggleSelectedAbilityPanel(abilityPanel) {
    if (lastSelectedAbilityPanel === null || lastSelectedAbilityPanel === void 0 ? void 0 : lastSelectedAbilityPanel.IsValid()) {
        disableSelectedAbilityPanel(lastSelectedAbilityPanel);
    }
    abilityPanel.style.border = "1px solid #fa070766";
    abilityPanel.style.boxShadow = "inset 0px 0px 4px 0px #fa070755";
    startSelectedAbilityPulse(abilityPanel);
}
function createBanButton() {
    let banButton = controls.FindChildTraverse("BanButtonCustom");
    controls.style.height = "50px";
    // banButton?.DeleteAsync(0)
    if (!banButton) {
        banButton = $.CreatePanel("Button", controls, "BanButtonCustom", {
            class: "PickButton",
            style: `
                border: 0px solid transparent;
                width: 100%;
                visibility: collapse;
            `
        });
        banButton.style.backgroundColor = isCheatMode ?
            "gradient( linear, 0% 0%, 0% 100%, from( #404D65dd ), to( #2B3445dd ))" //в чит режиме кнопка "выбрать"
            :
                "gradient( linear, 0% 0%, 0% 100%, from( #920202b0 ), to( #5c0202ad ))"; //в обычном кнопка "забанить"
        $.CreatePanel("Label", banButton, "BanButtonLabel", {
            text: $.Localize("#timeline_ban"),
            style: `
                vertical-align: center;
                horizontal-align: center;
                font-size: 25px;
                text-transform: uppercase;
                white-space: normal;
            `,
        });
    }
    return banButton;
}
function disableBanButton() {
    banButton.visible = false;
}
function hasUnlimitedBansOnUi() {
    const playerBanTable = CustomNetTables.GetTableValue("player_bans", String(Players.GetLocalPlayer()));
    return (playerBanTable === null || playerBanTable === void 0 ? void 0 : playerBanTable.hasUnlimitedBans) === 1;
}
function canSendBan(banName, banType) {
    var _a, _b;
    const hasUnlimitedBans = hasUnlimitedBansOnUi();
    const playerBans = CustomNetTables.GetTableValue("player_bans", String(Players.GetLocalPlayer()));
    switch (banType) {
        case BanType.ABILITY:
            return (hasUnlimitedBans || ((_a = playerBans === null || playerBans === void 0 ? void 0 : playerBans.abilities.left) !== null && _a !== void 0 ? _a : 0) > 0) &&
                !bannedAbilitiesSet.has(banName);
        case BanType.HERO:
            const normalizedHeroName = normalizeHeroName(banName);
            return (hasUnlimitedBans || ((_b = playerBans === null || playerBans === void 0 ? void 0 : playerBans.heroes.left) !== null && _b !== void 0 ? _b : 0) > 0) &&
                !bannedHeroesSet.has(normalizedHeroName);
        default:
            return false;
    }
}
function sendBanToServer(banName, banType) {
    if (!banName || !canSendBan(banName, banType))
        return false;
    if (banType === BanType.ABILITY) {
        GameEvents.SendCustomGameEventToServer("ban_ability", {
            PlayerID: Game.GetLocalPlayerID(),
            abilityName: banName
        });
        return true;
    }
    GameEvents.SendCustomGameEventToServer("ban_hero", {
        PlayerID: Game.GetLocalPlayerID(),
        heroName: denormalizeHeroName(banName)
    });
    return true;
}
function toggleBanButton(banName, banType) {
    if (!canSendBan(banName, banType)) {
        disableBanButton();
        return;
    }
    banButton.visible = true;
    if (!isCheatMode)
        banButtonLabel.text = `${$.Localize("#HUD_HeroSelect_Ban")} ${$.Localize(`#HUD_HeroSelect_Ban${banType}`)}`;
    else if (banType == BanType.HERO) {
        banButtonLabel.text = `${$.Localize("#DOTA_Hero_Selection_LOCKIN")}`;
    }
    banButton.info = {
        type: banType,
        name: banName !== null && banName !== void 0 ? banName : "undefiend"
    };
    banButton.SetPanelEvent("onactivate", () => {
        // $.Msg(`ban button pressed. banName = ${banName}, bantype = ${banType}`)
        if (!banName)
            return;
        if (isCheatMode) {
            GameEvents.SendCustomGameEventToServer("hero_selected", {
                heroName: banName
            });
            return;
        }
        if (sendBanToServer(banName, banType)) {
            disableBanButton();
        }
    });
}
function hideRedundantElements() {
    const heroPickRightColumn = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroPickRightColumn");
    const bottomPanels = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("BottomPanelsContainer");
    const headerCenter = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeaderCenter");
    const shopStrategyContainer = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("RightContainer");
    const strategyTab = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("StrategyTab");
    const guidesTab = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("GuidesTab");
    const manaHealthContainer = heroPickRightColumn === null || heroPickRightColumn === void 0 ? void 0 : heroPickRightColumn.FindChildrenWithClassTraverse("SectionHealthMana")[0];
    const heroLockedNav = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroLockedNav");
    manaHealthContainer.style.verticalAlign = "bottom";
    manaHealthContainer.style.marginBottom = "55px";
    if (guidesTab)
        guidesTab.visible = false;
    if (headerCenter) {
        headerCenter.style.marginTop = "900px";
    }
    if (shopStrategyContainer)
        shopStrategyContainer.visible = true;
    if (strategyTab)
        strategyTab.visible = false;
    if (heroLockedNav) {
        const strategyTabButton = heroLockedNav.FindChildTraverse("StrategyTabButton");
        const guidesTabButton = heroLockedNav.FindChildTraverse("GuidesTabButton");
        const heroLoadoutTabButton = heroLockedNav.FindChildTraverse("HeroLoadoutTabButton");
        const tabSeparators = heroLockedNav.Children().filter(x => x.BHasClass("StrategyPhaseTabSeparator"));
        if (strategyTabButton)
            strategyTabButton.visible = false;
        if (tabSeparators && tabSeparators.length > 0) {
            try {
                tabSeparators[0].visible = false;
                tabSeparators[2].visible = false;
            }
            catch (_a) {
                $.Msg("Strategy Tab separators not found");
            }
        }
        if (guidesTabButton)
            guidesTabButton.visible = false;
        if (heroLoadoutTabButton)
            $.DispatchEvent("Activated", heroLoadoutTabButton, "mouse");
    }
    if (controls) {
        controls.Children().forEach(child => {
            child.visible = false;
        });
    }
    if (bottomPanels)
        bottomPanels.visible = false;
    if (heroPickRightColumn)
        heroPickRightColumn.style.height = "580px";
}
//-------------------------------------------------------------
// Кастомные панели
//-------------------------------------------------------------
function initCustomPanels() {
    var _a, _b, _c;
    topBansAbilitiesPanel = $.GetContextPanel().FindChildTraverse("BanAbilitiesIcons");
    bottomRecentAbilitiesBansPanel = $.GetContextPanel().FindChildTraverse("RecentBansAbilities");
    bottomRecentBansHeroesPanel = $.GetContextPanel().FindChildTraverse("RecentBansHeroes");
    bottomMyHeroesBansPanel = $.GetContextPanel().FindChildTraverse("MyBansHeroes");
    bottomMyAbilitiesBansPanel = $.GetContextPanel().FindChildTraverse("MyBansAbilities");
    banPresetsRoot = panel("BanPresetsRoot");
    banPresetsListPanel = panel("BanPresetsList");
    banPresetsToggleArrow = panel("BanPresetsToggleArrow");
    const banPresetsToggle = panel("BanPresetsToggle");
    if (!topBansAbilitiesPanel ||
        !bottomRecentAbilitiesBansPanel ||
        !bottomRecentBansHeroesPanel ||
        !bottomMyHeroesBansPanel ||
        !bottomMyAbilitiesBansPanel ||
        !banPresetsRoot ||
        !banPresetsListPanel ||
        !banPresetsToggleArrow ||
        !banPresetsToggle) {
        $.Schedule(0.0, initCustomPanels);
        return;
    }
    banPresetsToggle.SetPanelEvent("onactivate", toggleBanPresetsPanel);
    updateTopBansPanel(topBansAbilitiesPanel, Array.from(bannedAbilitiesSet));
    //FillTopBanPanelTest(); // иммитация запросов с бека на бан способностей
    //FillBanHeroesTest(); // имитация запросов с бека на бан героев
    const playerSteamId = getSteamId32(Players.GetLocalPlayer());
    const allPlayersRecentBansAbilities = (_a = CustomNetTables.GetTableValue("service", "player_ban_ability")) !== null && _a !== void 0 ? _a : {};
    const currentPlayerRecentBansAbilities = netTableObjToArray(allPlayersRecentBansAbilities[playerSteamId]);
    const allPlayersRecentBansHeroes = (_b = CustomNetTables.GetTableValue("service", "player_ban_hero")) !== null && _b !== void 0 ? _b : {};
    const currentPlayerRecentBansHeroes = netTableObjToArray(allPlayersRecentBansHeroes[playerSteamId]);
    updateRecentBansAbilities(bottomRecentAbilitiesBansPanel, currentPlayerRecentBansAbilities);
    updateRecentBansHeroes(bottomRecentBansHeroesPanel, currentPlayerRecentBansHeroes);
    const allPlayerCurrentBansActions = (_c = CustomNetTables.GetTableValue("action_times", String(Players.GetLocalPlayer()))) !== null && _c !== void 0 ? _c : {};
    updateMyAbilitiesBansPanel(bottomMyAbilitiesBansPanel, netTableObjToArray(allPlayerCurrentBansActions.banAbility));
    updateMyHeroesBansPanel(bottomMyHeroesBansPanel, netTableObjToArray(allPlayerCurrentBansActions.banHero));
    updateBanPresetsPanel(CustomNetTables.GetTableValue("service", "player_ban_presets"));
    heroSelectNetTablesListeners.push(CustomNetTables.SubscribeNetTableListener("player_bans", (_, strPlayerId, banInfos) => {
        var _a;
        // $.Msg(JSON.stringify(banInfos, null, "\t"))
        if (strPlayerId == String(Players.GetLocalPlayer())) { //обработка своих банов
            const myBanAbilitiesArray = netTableObjToArray(banInfos.abilities.list);
            const myBanHeroesArray = netTableObjToArray(banInfos.heroes.list);
            updateMyAbilitiesBansPanel(bottomMyAbilitiesBansPanel, myBanAbilitiesArray);
            updateMyHeroesBansPanel(bottomMyHeroesBansPanel, myBanHeroesArray);
        }
        const allPlayerBans = (_a = CustomNetTables.GetAllTableValues("player_bans")) !== null && _a !== void 0 ? _a : {};
        for (const key of Object.values(allPlayerBans)) {
            netTableObjToArray(key.value.abilities.list).forEach(x => bannedAbilitiesSet.add(String(x)));
            netTableObjToArray(key.value.heroes.list).forEach(x => bannedHeroesSet.add(String(x)));
        }
        updateRecentBansAbilities(bottomRecentAbilitiesBansPanel, currentPlayerRecentBansAbilities);
        updateRecentBansHeroes(bottomRecentBansHeroesPanel, currentPlayerRecentBansHeroes);
        updateTopBansPanel(topBansAbilitiesPanel, Array.from(bannedAbilitiesSet));
    }));
    heroSelectNetTablesListeners.push(CustomNetTables.SubscribeNetTableListener("service", (_, key, value) => {
        if (key === "player_ban_presets") {
            updateBanPresetsPanel(value);
        }
    }));
}
function toggleBanPresetsPanel() {
    var _a;
    if (banPresetWasApplied)
        return;
    const isOpen = (_a = banPresetsRoot === null || banPresetsRoot === void 0 ? void 0 : banPresetsRoot.BHasClass("Open")) !== null && _a !== void 0 ? _a : false;
    setBanPresetsPanelOpen(!isOpen);
}
function setBanPresetsPanelOpen(isOpen) {
    if (!banPresetsRoot || !banPresetsToggleArrow)
        return;
    banPresetsRoot.SetHasClass("Open", isOpen);
    banPresetsToggleArrow.text = isOpen ? "<" : ">";
}
function updateBanPresetsPanel(allPlayerBanPresets) {
    if (!banPresetsListPanel)
        return;
    const playerSteamId = String(getSteamId32(Players.GetLocalPlayer()));
    const playerBanPresets = allPlayerBanPresets === null || allPlayerBanPresets === void 0 ? void 0 : allPlayerBanPresets[playerSteamId];
    const banPresets = netTableObjToArray(playerBanPresets);
    banPresetsListPanel.RemoveAndDeleteChildren();
    if (banPresets.length === 0 || banPresetWasApplied) {
        if (banPresetsRoot)
            banPresetsRoot.visible = false;
        setBanPresetsPanelOpen(false);
        selectedBanPresetIndex = null;
        return;
    }
    if (banPresetsRoot)
        banPresetsRoot.visible = true;
    banPresets.forEach((banPreset, index) => {
        createBanPresetRow(banPresetsListPanel, banPreset, index);
    });
}
function createBanPresetRow(parent, banPreset, presetIndex) {
    const row = $.CreatePanel("Button", parent, `BanPresetRow_${presetIndex}`);
    row.AddClass("BanPresetRow");
    row.SetHasClass("Selected", selectedBanPresetIndex === presetIndex);
    row.enabled = !banPresetWasApplied;
    const nameLabel = $.CreatePanel("Label", row, "");
    nameLabel.AddClass("BanPresetName");
    nameLabel.text = getBanPresetName(banPreset, presetIndex);
    row.SetPanelEvent("onactivate", () => selectBanPreset(banPreset, presetIndex));
}
function selectBanPreset(banPreset, presetIndex) {
    if (banPresetWasApplied)
        return;
    selectedBanPresetIndex = presetIndex;
    banPresetWasApplied = true;
    sendBanPresetToServer(banPreset);
    updateBanPresetsPanel(CustomNetTables.GetTableValue("service", "player_ban_presets"));
}
function getBanPresetName(banPreset, index) {
    return banPreset.name && banPreset.name.length > 0 ? banPreset.name : `Preset ${index + 1}`;
}
function sendBanPresetToServer(banPreset) {
    const heroes = netTableObjToArray(banPreset.heroes);
    const abilities = netTableObjToArray(banPreset.abilities);
    abilities.forEach(ability => sendBanToServer(ability, BanType.ABILITY));
    heroes.forEach(hero => sendBanToServer(hero, BanType.HERO));
}
function updateTopBansPanel(iconsPanel, list) {
    if (!iconsPanel)
        return;
    iconsPanel.RemoveAndDeleteChildren();
    const max = 42;
    for (let i = 0; i < max; i++) {
        createBanAbilitySlot(iconsPanel, list[i]);
    }
    updateHeroCard();
}
function updateRecentBansHeroes(panel, list) {
    if (!panel)
        return;
    panel.RemoveAndDeleteChildren();
    for (let i = 0; i < list.length; i++) {
        createBanHeroSlot(panel, list[i]);
    }
}
function updateRecentBansAbilities(panel, list) {
    if (!panel)
        return;
    panel.RemoveAndDeleteChildren();
    for (let i = 0; i < list.length; i++) {
        createBanAbilitySlot(panel, list[i]);
    }
}
function updateMyHeroesBansPanel(panel, list) {
    if (!panel)
        return;
    panel.RemoveAndDeleteChildren();
    const filledBans = list.filter((heroName) => heroName != null && heroName !== "");
    for (const heroName of filledBans) {
        createBanHeroSlot(panel, heroName);
    }
}
function updateMyAbilitiesBansPanel(panel, list) {
    if (!panel)
        return;
    panel.RemoveAndDeleteChildren();
    const filledBans = list.filter((abilityName) => abilityName != null && abilityName !== "");
    for (const abilityName of filledBans) {
        createBanAbilitySlot(panel, abilityName);
    }
}
function normalizeHeroName(hero) {
    return HERO_NAME_PREFIX + denormalizeHeroName(hero);
}
function denormalizeHeroName(hero) {
    let result = hero;
    while (result.startsWith(HERO_NAME_PREFIX)) {
        result = result.substring(HERO_NAME_PREFIX.length);
    }
    return result;
}
function createBanHeroSlot(parent, heroName) {
    const slot = $.CreatePanel("Panel", parent, "recent_hero_slot_" + heroName);
    slot.AddClass("BanHeroCard");
    slot.hittest = heroName != null;
    if (heroName == null)
        return;
    heroName = normalizeHeroName(heroName);
    const img = $.CreatePanel("DOTAHeroImage", slot, "recent_hero_img_" + heroName);
    img.AddClass("BanHeroCardImage");
    img.heroname = heroName;
    img.heroimagestyle = "portrait";
    const fade = $.CreatePanel("Panel", slot, "");
    fade.AddClass("BanHeroCardBottomFade");
    if (heroName != "npc_dota_hero_") {
        // $.Msg(heroName)
        slot.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowTextTooltip", slot, $.Localize(`#${heroName}`));
        });
        slot.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideTextTooltip", slot);
        });
    }
    if (bannedHeroesSet.has(heroName) && !parent.BHasClass("MyBansHeroes")) {
        const overlay = ensureHeroBannedOverlay(slot, heroName);
        overlay.style.opacity = "1";
    }
    slot.SetPanelEvent("onmouseactivate", () => {
        selectHeroInGrid(heroName);
        $.Schedule(0, () => toggleBanButton(heroName.replace("npc_dota_hero_", ""), BanType.HERO));
    });
}
function createBanAbilitySlot(parent, ability) {
    const slot = $.CreatePanel("Panel", parent, "ability_" + ability);
    slot.AddClass("BanAbilitySlot");
    if (ability != null) {
        const img = $.CreatePanel("DOTAAbilityImage", slot, "ability_" + ability);
        img.AddClass("BanAbilityIcon");
        img.abilityname = ability;
        if (ability != "") {
            slot.SetPanelEvent("onmouseover", () => {
                $.DispatchEvent("DOTAShowAbilityTooltip", slot, ability);
            });
            slot.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideAbilityTooltip", slot);
            });
        }
        if ((parent.BHasClass("RecentBansAbilities") ||
            parent.BHasClass("CustomHeroPickAbilitiesContainer")) &&
            bannedAbilitiesSet.has(ability)) {
            const overlay = ensureAbilityBannedOverlay(img);
            overlay.style.opacity = "1";
        }
        slot.SetPanelEvent("onmouseactivate", () => {
            focusHeroAndSelectAbility(ability);
        });
    }
}
//Иммитация банов способностей
function FillTopBanPanelTest() {
    for (let i = 0; i < testBanAbilitiesList.length; i++) {
        $.Schedule(i + 0.5, () => {
            bannedAbilitiesSet.add(testBanAbilitiesList[i]); // на каждый апдейт бана способности
            updateTopBansPanel(topBansAbilitiesPanel, Array.from(bannedAbilitiesSet)); // обновляем панельку со всеми банами
            updateRecentBansAbilities(bottomRecentAbilitiesBansPanel, testRecentBanAbilities); //обновляем панельку с последними банами
            // todo обновлять мои текущие баны
            $.Msg(`Ability ${testBanAbilitiesList[i]} was banned`);
        });
    }
}
//Иммитация банов героев
function FillBanHeroesTest() {
    for (let i = 0; i < testBanHeroesList.length; i++) {
        $.Schedule(i * 2 + 3.5, () => {
            const heroName = testBanHeroesList[i];
            bannedHeroesSet.add(heroName); // на каждый апдейт бана героя
            updateRecentBansHeroes(bottomRecentBansHeroesPanel, testRecentBansHeroes); // обновляем панельку с последними банами
            //applyHeroBanOverlay(heroName);
            $.Msg(`Hero ${heroName} was banned`);
        });
    }
}
function applyHeroBanOverlay(heroName) {
    heroName = normalizeHeroName(heroName);
    const card = findHeroCardInGrid(heroName);
    if (!card) {
        $.Msg("[applyHeroBanOverlay] HeroCard not found:", heroName);
        return;
    }
    const overlay = card.FindChildTraverse("BannedOverlay");
    if (overlay) {
        overlay.visible = true;
        overlay.style.opacity = "1";
    }
    card.SetHasClass("Banned", true); // на случай если Valve что-то привяжет к классу
}
$.Schedule(0.0, initCustomPanels);
//todo вынейсти типы в глобал
var BanType;
(function (BanType) {
    BanType["ABILITY"] = "ABILITY";
    BanType["HERO"] = "HERO";
})(BanType || (BanType = {}));
heroSelectListeners.push(GameEvents.Subscribe("dota_game_state_change", (event) => {
    if (Game.GameStateIs(DOTA_GameState.DOTA_GAMERULES_STATE_PLAYER_DRAFT)) {
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_HEADER, true);
        GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_HERO_SELECTION_CLOCK, true);
        return;
    }
    if (Game.GameStateIsAfter(DOTA_GameState.DOTA_GAMERULES_STATE_STRATEGY_TIME)) {
        heroSelectListeners.forEach(x => GameEvents.Unsubscribe(x));
        heroSelectNetTablesListeners.forEach(x => CustomNetTables.UnsubscribeNetTableListener(x));
        $.Msg("HeroSelection listeners was closed.");
    }
}));
//---------------------------------------------------
// Таймер фазы
//---------------------------------------------------
heroSelectListeners.push(GameEvents.Subscribe("UpdatePhaseTime", onUpdatePhaseTime));
let phaseTimeLeft = 0;
let phaseId = 0;
function onUpdatePhaseTime(event) {
    phaseTimeLeft = event.time;
    phaseId = event.phase;
    // $.Msg(`onUpdatePhaseTime. Phase = ${phaseId}`)
    // const title = panel<LabelPanel>("PhaseTimerTitle");
    switch (phaseId) {
        case 1:
            // title.text = $.Localize("#HUD_HeroSelect_Phase_Ban");
            switchUiForPhase(UiPhase.BANS);
            break;
        case 2:
            // title.text = $.Localize("#HUD_HeroSelect_Phase_Select");
            switchUiForPhase(UiPhase.PICK);
            initCustomPickSlots();
            break;
        default:
            break;
    }
    updateTimerTick();
}
function updateTimerTick() {
    const label = panel("PhaseTimerValue");
    if (!label)
        return;
    phaseTimeLeft--;
    const mins = Math.max(Math.floor(phaseTimeLeft / 60), 0);
    const secs = Math.max(Math.floor(phaseTimeLeft % 60), 0);
    const text = `${mins}:${secs < 10 ? "0" : ""}${secs}`;
    label.text = text;
}
var UiPhase;
(function (UiPhase) {
    UiPhase[UiPhase["BANS"] = 1] = "BANS";
    UiPhase[UiPhase["PICK"] = 2] = "PICK";
})(UiPhase || (UiPhase = {}));
const customPickRoot = $("#CustomHeroPickRoot");
const heroInspect = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroInspect");
const heroGrid = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroGrid");
const recentBansPanel = $.GetContextPanel().FindChildTraverse("RecentBansRoot");
const myBansPanel = $.GetContextPanel().FindChildTraverse("MyBansRoot");
const backHeroGridButton = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("BacktoHeroGrid");
const footer = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("Footer");
function switchUiForPhase(phase) {
    // $.Msg(`Switch UI for Phase. Phase = ${phase}`)
    if (!customPickRoot)
        return;
    if (phase === UiPhase.BANS) {
        customPickRoot.visible = false;
        if (heroGrid)
            heroGrid.visible = true;
        if (recentBansPanel)
            recentBansPanel.visible = true;
        if (myBansPanel)
            myBansPanel.visible = true;
        if (footer)
            footer.visible = true;
    }
    else if (phase === UiPhase.PICK) {
        banButton.visible = false;
        if (heroGrid)
            heroGrid.visible = false;
        if (backHeroGridButton)
            backHeroGridButton.visible = false;
        if (recentBansPanel)
            recentBansPanel.visible = false;
        if (myBansPanel)
            myBansPanel.visible = false;
        if (heroInspect)
            heroInspect.visible = false;
        if (footer)
            footer.visible = false;
    }
}
//-------------------------------------------------------------------
//--Логика для связи способности и героя в базовом HeroSelectionHud--
//-------------------------------------------------------------------
function findHeroCardInGrid(heroName) {
    if (!pregame)
        return null;
    const stack = [pregame];
    while (stack.length) {
        const p = stack.pop();
        const hn = p.heroname;
        if (hn && heroesEqual(hn, heroName)) {
            // поднимаемся вверх до HeroCard
            let cur = p;
            for (let i = 0; i < 8 && cur; i++) {
                if (cur.BHasClass && cur.BHasClass("HeroCard")) {
                    return cur;
                }
                cur = cur.GetParent();
            }
            return p;
        }
        const kids = p.Children();
        if (kids)
            for (let i = 0; i < kids.length; i++)
                stack.push(kids[i]);
    }
    return null;
}
function stripHeroPrefix(hero) {
    return hero.replace(/^npc_dota_hero_/, "");
}
function heroesEqual(a, b) {
    return stripHeroPrefix(a) === stripHeroPrefix(b);
}
function findClickableHeroPanel(root, heroName) {
    var _a;
    const stack = [root];
    while (stack.length) {
        const p = stack.pop();
        const hn = p.heroname;
        if (hn && heroesEqual(hn, heroName)) {
            if (p.visible && p.actuallayoutwidth > 10 && p.actuallayoutheight > 10) {
                return (_a = climbToClickableParent(p)) !== null && _a !== void 0 ? _a : p;
            }
        }
        const kids = p.Children();
        if (kids)
            for (let i = 0; i < kids.length; i++)
                stack.push(kids[i]);
    }
    return null;
}
function climbToClickableParent(p) {
    let cur = p;
    for (let i = 0; i < 6 && cur; i++) {
        if (cur.paneltype === "Button")
            return cur;
        cur = cur.GetParent();
    }
    return null;
}
function selectHeroInGrid(heroName) {
    if (!pregame)
        return;
    const heroPanel = findClickableHeroPanel(pregame, heroName);
    if (!heroPanel) {
        $.Msg("[selectHeroInGrid] hero panel not found for", heroName);
        return;
    }
    $.DispatchEvent("Activated", heroPanel, "mouse");
    // updateHeroCard();
}
function findHeroPanelInPregame(heroName) {
    var _a;
    const candidates = [];
    const heroList = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroList");
    if (heroList)
        candidates.push(heroList);
    const heroGrid = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroGrid");
    if (heroGrid)
        candidates.push(heroGrid);
    for (const root of candidates) {
        const all = (_a = root.FindChildrenWithClassTraverse) === null || _a === void 0 ? void 0 : _a.call(root, "");
        const found = findPanelByHeroName(root, heroName);
        if (found)
            return found;
    }
    return null;
}
function findPanelByHeroName(root, heroName) {
    const stack = [root];
    while (stack.length) {
        const p = stack.pop();
        const pn = p.heroname;
        if (pn === heroName)
            return p;
        const kids = p.Children();
        if (kids)
            stack.push(...kids);
    }
    return null;
}
function tryDispatchHeroSelect(heroName) {
    $.DispatchEvent("DOTAHeroGridSelectHero", pregame, heroName);
    $.DispatchEvent("DOTAHeroInspectHero", pregame, heroName);
}
function focusHeroAndSelectAbility(ability) {
    const heroName = abilityToHero.get(ability);
    if (!heroName) {
        $.Msg("[focusHeroAndSelectAbility] hero not found for", ability);
        return;
    }
    selectHeroInGrid(heroName);
    $.Schedule(0.05, () => focusAbilityRetry(ability, 5));
}
function focusAbilityRetry(ability, triesLeft) {
    const heroAbilitiesPanel = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("HeroAbilities");
    if (!heroAbilitiesPanel) {
        if (triesLeft > 0)
            $.Schedule(0.05, () => focusAbilityRetry(ability, triesLeft - 1));
        return;
    }
    const panels = heroAbilitiesPanel.Children();
    const target = panels === null || panels === void 0 ? void 0 : panels.find(p => p.abilityname === ability);
    if (target) {
        $.Msg("target found");
        toggleBanButton(ability, BanType.ABILITY);
        toggleSelectedAbilityPanel(target);
        return;
    }
    if (triesLeft > 0) {
        $.Schedule(0.05, () => focusAbilityRetry(ability, triesLeft - 1));
    }
}
//---------------------------------------------------
//              Логика кастомного пика
//---------------------------------------------------
let isArleadyInit = false;
function initCustomPickSlots() {
    if (isArleadyInit)
        return;
    isArleadyInit = true;
    customPickRoot.RemoveClass("Hidden");
    const playerHeroSelectNetTableListenr = SubscribeAndFireNetTableByKey("hero_select", String(Players.GetLocalPlayer()), (_, k, v) => {
        BuildHeroPickSlots(v.rerollButtonEnabled == 1, v);
    });
    BuildTeamRootForHeroPickSlots();
}
let teamPickRoot = panel("TeamPickRoot");
function BuildTeamRootForHeroPickSlots(createdTeamPickRoot) {
    if (createdTeamPickRoot) {
        $.Msg("team pick root was override");
        teamPickRoot = createdTeamPickRoot;
    }
    else if (!teamPickRoot) {
        $.Schedule(0, () => BuildTeamRootForHeroPickSlots());
        return;
    }
    let j = 0;
    // for (let i = 0; i < 6; i++) //для тестов кол-во команд
    for (const team of Game.GetAllTeamIDs()) {
        const teamInfo = Game.GetTeamDetails(team);
        if (teamInfo.team_num_players == 0)
            continue;
        // $.Msg(`Team valid. Num = ${teamInfo.team_id}`)
        const teamContainer = $.CreatePanel("Panel", teamPickRoot, `TeamContainer${team}`);
        teamContainer.AddClass("TeamContainerInfo");
        const teamPlayersOnTeam = Game.GetPlayerIDsOnTeam(team);
        // for (let i = 0; i < 2; i++) //для тестов кол-во игроков
        for (const playerId of teamPlayersOnTeam) {
            if (Players.IsValidPlayerID(playerId)) {
                // $.Msg(`Player valid. Id = ${playerId}`)
                const overflowPanel = $.CreatePanel("Panel", teamContainer, "");
                overflowPanel.AddClass("PlayerPickContainer");
                const heroPickingPanel = $.CreatePanel("DOTAHudHeroPickingPlayer", overflowPanel, `HeroPicking${playerId}`);
                populateTeamSlot(heroPickingPanel, playerId, j);
            }
        }
        j++;
    }
    // $.Schedule(5, () => UpdateTeamRootBySelectedHero(Players.GetLocalPlayer(), "npc_dota_hero_crystal_maiden")) //для тестов
}
function populateTeamSlot(teamSlot, player_id, slot) {
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
        UpdateTeamRootBySelectedHero(player_id, Players.GetPlayerSelectedHero(player_id));
    }
}
heroSelectListeners.push(GameEvents.Subscribe("update_hero_select_state", (event) => {
    if (event.PlayerID == Game.GetLocalPlayerID()) {
        RebuildSelectedHeroAbilities();
    }
    UpdateTeamRootBySelectedHero(event.PlayerID, event.heroName);
}));
function UpdateTeamRootBySelectedHero(selectedPlayerIdhero, heroName) {
    const teamSlot = teamPickRoot.FindChildTraverse(`HeroPicking${selectedPlayerIdhero}`);
    if (!teamSlot)
        return;
    const heroImage = teamSlot.FindChildTraverse("HeroImage");
    if (!heroImage)
        return;
    heroImage.heroname = heroName;
    teamSlot.RemoveClass("HeroPickNone");
    teamSlot.RemoveClass("PlayerInControl");
    teamSlot.AddClass("HeroPickLocked");
}
function RebuildSelectedHeroAbilities() {
    const abilitiesPanel = pregame === null || pregame === void 0 ? void 0 : pregame.FindChildTraverse("SelectedHeroAbilities");
    if (!abilitiesPanel) {
        return;
    }
    updateHeroAbilitiesPanelState(abilitiesPanel);
    abilitiesPanel.style.flowChildren = "right-wrap";
    abilitiesPanel.style.width = "100%";
}
function BuildHeroPickSlots(isRerollButtonEnabled, tableData) {
    $.Msg(`isRerollEnabled = ${isRerollButtonEnabled} -- ${JSON.stringify(tableData, null, "\t")}`);
    try {
        const rerollButton = panel("RerollButton");
        if (isRerollButtonEnabled)
            rerollButton.RemoveClass("Hidden");
        else
            rerollButton.AddClass("Hidden");
        const heroNamesList = netTableObjToArray(tableData.herolist[tableData.page]);
        fillCustomPickSlots(heroNamesList);
    }
    catch (e) {
        $.Msg("Error occured " + e);
    }
}
function OnRerollButtonClicked() {
    GameEvents.SendCustomGameEventToServer("RerollHeroes", {});
}
function fillCustomPickSlots(heroes) {
    for (let i = 0; i < 4; i++) {
        const slot = panel(`HeroSlot${i}`);
        const button = panel(`HeroPickButton${i}`);
        const heroName = heroes[i];
        if (!slot || !button || !heroName) {
            if (slot)
                slot.visible = false;
            if (button)
                button.visible = false;
            continue;
        }
        const inspect = ensureInspectInSlot(i);
        if (!inspect) {
            $.Msg(`No HeroInspect found in slot ${i}`);
            slot.visible = false;
            button.visible = false;
            continue;
        }
        slot.visible = true;
        button.visible = true;
        populateHeroInspect(inspect, heroName);
        button.SetPanelEvent("onactivate", () => {
            onCustomHeroPick(heroName);
        });
    }
    customPickRoot.visible = true;
}
function ensureInspectInSlot(slotIndex) {
    const container = panel(`HeroInspectContainer${slotIndex}`);
    if (!container) {
        $.Msg(`No container HeroInspectContainer${slotIndex}`);
        return null;
    }
    let inspect = container.FindChildTraverse("HeroInspect");
    if (inspect)
        return inspect;
    const ok = container.BLoadLayoutSnippet("CustomHeroInspect");
    if (!ok) {
        $.Msg(`Failed to BLoadLayoutSnippet("CustomHeroInspect") for slot ${slotIndex}`);
        return null;
    }
    inspect = container.FindChildTraverse("HeroInspect");
    if (!inspect) {
        $.Msg(`HeroInspect still not found in slot ${slotIndex} after BLoadLayoutSnippet`);
        return null;
    }
    return inspect;
}
function populateHeroInspect(inspect, heroName) {
    var _a;
    const simpleDescription = inspect.FindChildTraverse("HeroSimpleDescription");
    simpleDescription === null || simpleDescription === void 0 ? void 0 : simpleDescription.RemoveAndDeleteChildren();
    const heroComplexity = inspect.FindChildTraverse("ComplexityValue");
    heroComplexity === null || heroComplexity === void 0 ? void 0 : heroComplexity.DeleteAsync(0);
    const heroKv = GameUI.CustomUIConfig().heroesKv[heroName];
    if (!heroKv)
        return;
    inspect.RemoveClass("InspectHeroIntelligence");
    inspect.RemoveClass("InspectHeroAgility");
    inspect.RemoveClass("InspectHeroStrength");
    inspect.RemoveClass("InspectHeroAll");
    switch (heroKv["AttributePrimary"]) {
        case "DOTA_ATTRIBUTE_INTELLECT":
            inspect.AddClass("InspectHeroIntelligence");
            break;
        case "DOTA_ATTRIBUTE_AGILITY":
            inspect.AddClass("InspectHeroAgility");
            break;
        case "DOTA_ATTRIBUTE_STRENGTH":
            inspect.AddClass("InspectHeroStrength");
            break;
        default:
            inspect.AddClass("InspectHeroAll");
            break;
    }
    inspect.AddClass("InspectingHero");
    inspect.SetDialogVariableInt("inspect_hero_id", Number(heroKv["HeroID"]));
    inspect.SetDialogVariable("base_str", GetHeroBaseStr(heroKv));
    inspect.SetDialogVariable("str_per_level", Number(heroKv["AttributeStrengthGain"]).toFixed(1));
    inspect.SetDialogVariable("base_agi", GetHeroBaseAgi(heroKv));
    inspect.SetDialogVariable("agi_per_level", Number(heroKv["AttributeAgilityGain"]).toFixed(1));
    inspect.SetDialogVariable("base_int", GetHeroBaseInt(heroKv));
    inspect.SetDialogVariable("int_per_level", Number(heroKv["AttributeIntelligenceGain"]).toFixed(1));
    inspect.SetDialogVariableInt("damage", GetHeroDamage(heroKv));
    inspect.SetDialogVariable("armor", GetHeroArmor(heroKv));
    inspect.SetDialogVariableInt("movement_speed", Number(heroKv["MovementSpeed"]));
    inspect.SetDialogVariable("attack_rate", Number(heroKv["AttackRate"]).toFixed(1));
    inspect.SetDialogVariableInt("base_attack_speed", GetHeroAttackSpeed(heroKv));
    inspect.SetDialogVariableInt("attack_range", Number((_a = heroKv["AttackRange"]) !== null && _a !== void 0 ? _a : 0));
    const unitAttack = heroKv["AttackCapabilities"];
    if (unitAttack) {
        inspect.SetDialogVariable("inspected_hero_attack_type", unitAttack == "DOTA_UNIT_CAP_RANGED_ATTACK"
            ?
                $.Localize("#DOTA_HeroSelectorCategory_AttackRange_Ranged")
            :
                $.Localize("#DOTA_HeroSelectorCategory_AttackRange_Melee"));
    }
    inspect.SetDialogVariableInt("max_health", GetHeroMaxHealth(heroKv));
    inspect.SetDialogVariable("health_regen", GetHeroHealthRegen(heroKv));
    inspect.SetDialogVariableInt("max_mana", GetHeroMaxMana(heroKv));
    inspect.SetDialogVariable("mana_regen", GetHeroManaRegen(heroKv));
    const movie = inspect.FindChildTraverse("HeroMovie");
    if (movie) {
        movie.heroname = heroName;
    }
    updateHeroInspectBanOverlay(inspect, heroName);
    // const fasetContainer = inspect.FindChildTraverse("HeroFacetContainer")
    // fasetContainer?.RemoveAndDeleteChildren()
    // const facets = heroKv["Facets"] as Record<string, any>
    // for (const [facetName, facetData] of Object.entries(facets)) {
    //     if (facetData["Deprecated"])
    //         continue;
    //     //@ts-ignore
    //     const facetIcon = $.CreatePanel("DOTAFacetIcon", fasetContainer, "") as Panel;
    //     facetIcon.SetDialogVariableLocString("facet_name", `#DOTA_Tooltip_Facet_${facetName}`)
    //     facetIcon.AddClass(`facet_icon_${(facetData["Icon"] as string).toLowerCase()}`)
    //     facetIcon.AddClass(`facet_color_${(facetData["Color"] as string).toLowerCase()}_${facetData["GradientID"]}`)
    //     facetIcon.AddClass(`facet_gradient_${(facetData["Color"] as string).toLowerCase()}_${facetData["GradientID"]}`)
    //     facetIcon.AddClass("has_facet")
    //     facetIcon.style.margin = "3px"
    //     facetIcon.style.tooltipPosition = "bottom"
    //     facetIcon.style.uiScale = "108%"
    //     const facetContainer = facetIcon.FindChildTraverse("FacetContainer")!
    //     facetContainer.SetPanelEvent("onmouseover", () => {
    //         $.DispatchEvent("DOTAShowInnateDisplayTooltip", facetContainer)
    //         // $.Msg("Event dispatch")
    //     })
    //     facetContainer.SetPanelEvent("onmouseout", () => {
    //         $.DispatchEvent("DOTAHideInnateDisplayTooltip")
    //         // $.Msg("Event dispatch")
    //     }) //шляпа не работает. А ПОЕБАТЬ ВАЛЬВ УДАЛИЛИ АСПЕКТЫ АХАХАХАХАХАХАХ
    // }
    const manaHealthContainer = inspect.FindChildrenWithClassTraverse("SectionHealthMana")[0];
    manaHealthContainer.style.verticalAlign = "bottom";
    manaHealthContainer.style.marginBottom = "55px";
    const heroInspectAbilitiesContainer = inspect.FindChildTraverse("HeroAbilities");
    heroInspectAbilitiesContainer.AddClass("CustomHeroPickAbilitiesContainer");
    heroInspectAbilitiesContainer.style.flowChildren = "right-wrap";
    heroInspectAbilitiesContainer.style.width = "100%";
    heroInspectAbilitiesContainer.style.height = "fit-children";
    heroInspectAbilitiesContainer.RemoveAndDeleteChildren();
    const statBranch = $.CreatePanel("Panel", heroInspectAbilitiesContainer, "");
    statBranch.AddClass("StatBranch");
    statBranch.style.width = MAX_ABILITY_IMAGE_WIDTH;
    statBranch.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAHUDShowHeroStatBranchTooltip", statBranch, GetHeroID(heroName), -1);
    });
    statBranch.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHUDHideStatBranchTooltip");
    });
    let i = 1;
    while (heroKv[`Ability${i}`] != null) {
        const abilityName = heroKv[`Ability${i}`];
        i++;
        if (abilityName == "" ||
            abilityName.startsWith("generic") ||
            abilityName.startsWith("special_bonus") ||
            abilityName.endsWith("empty1") ||
            abilityName.endsWith("empty2") ||
            abilityName.endsWith("empty3") ||
            abilityName.endsWith("empty4") ||
            abilityName.startsWith("empty_"))
            continue;
        const img = $.CreatePanel("DOTAAbilityImage", heroInspectAbilitiesContainer, "");
        img.abilityname = abilityName;
        img.style.width = MAX_ABILITY_IMAGE_WIDTH;
        img.style.margin = "0px 5px 5px 0px";
        img.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowAbilityTooltip", img, abilityName);
        });
        img.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideAbilityTooltip", img);
        });
        if (bannedAbilitiesSet.has(abilityName)) {
            const overlay = ensureAbilityBannedOverlay(img);
            overlay.style.opacity = "1";
        }
    }
    const aghsContainer = $.CreatePanel("Panel", heroInspectAbilitiesContainer, "");
    aghsContainer.AddClass("ScepterDetails");
    aghsContainer.style.width = MAX_ABILITY_IMAGE_WIDTH;
    aghsContainer.SetPanelEvent("onmouseover", () => {
        $.DispatchEvent("DOTAHUDShowAghsStatusTooltip", aghsContainer, GetHeroID(heroName), 0);
    });
    aghsContainer.SetPanelEvent("onmouseout", () => {
        $.DispatchEvent("DOTAHUDHideAghsStatusTooltip", aghsContainer);
    });
}
function GetHeroAttackSpeed(heroKv) {
    var _a;
    return (Number((_a = heroKv["BaseAttackSpeed"]) !== null && _a !== void 0 ? _a : 100) + Number(GetHeroBaseAgi(heroKv)));
}
function GetHeroBaseInt(heroKv) {
    return Number(heroKv["AttributeBaseIntelligence"]).toFixed(0);
}
function GetHeroBaseAgi(heroKv) {
    return Number(heroKv["AttributeBaseAgility"]).toFixed(0);
}
function GetHeroBaseStr(heroKv) {
    return Number(heroKv["AttributeBaseStrength"]).toFixed(0);
}
function GetHeroMaxHealth(heroKv) {
    const baseHealth = 120;
    return (baseHealth + Number(GetHeroBaseStr(heroKv)) * 22);
}
function GetHeroHealthRegen(heroKv) {
    var _a;
    const baseHealthRegen = Number((_a = heroKv["StatusHealthRegen"]) !== null && _a !== void 0 ? _a : 0);
    return (baseHealthRegen + Number(GetHeroBaseInt(heroKv)) * 0.09).toFixed(1);
}
function GetHeroMaxMana(heroKv) {
    const baseMana = 75;
    return (baseMana + Number(GetHeroBaseInt(heroKv)) * 12);
}
function GetHeroManaRegen(heroKv) {
    const baseManaRegen = Number(heroKv["StatusManaRegen"]);
    return ((Number.isNaN(baseManaRegen) ? 0 : baseManaRegen) + Number(GetHeroBaseInt(heroKv)) * 0.05).toFixed(1);
}
function GetHeroArmor(heroKv) {
    const baseArmor = Number(heroKv["ArmorPhysical"]);
    return (baseArmor + Number(GetHeroBaseAgi(heroKv)) * 0.16).toFixed(1);
}
function GetHeroDamage(heroKv) {
    const maxBaseDamage = Number(heroKv["AttackDamageMax"]);
    switch (heroKv["AttributePrimary"]) {
        case "DOTA_ATTRIBUTE_INTELLECT":
            return (maxBaseDamage + Number(GetHeroBaseInt(heroKv)));
        case "DOTA_ATTRIBUTE_AGILITY":
            return (maxBaseDamage + Number(GetHeroBaseAgi(heroKv)));
        case "DOTA_ATTRIBUTE_STRENGTH":
            return (maxBaseDamage + Number(GetHeroBaseStr(heroKv)));
        default:
            return (maxBaseDamage +
                Number(GetHeroBaseInt(heroKv)) * 0.45 +
                Number(GetHeroBaseAgi(heroKv)) * 0.45 +
                Number(GetHeroBaseStr(heroKv)) * 0.45);
    }
}
function onCustomHeroPick(heroName) {
    GameEvents.SendCustomGameEventToServer("hero_selected", {
        heroName: heroName,
    });
}
heroSelectListeners.push(GameEvents.Subscribe("update_hero_select_state", (event) => {
    if (event.PlayerID != Players.GetLocalPlayer())
        return;
    const customPickRoot = panel("CustomHeroPickRoot");
    const teamPickRoot = panel("TeamPickRoot");
    const banAbilitiesRoot = panel("BanAbilitiesRoot");
    const rerollButton = panel("RerollButton");
    if (customPickRoot)
        customPickRoot.visible = false;
    if (teamPickRoot)
        teamPickRoot.visible = false;
    if (rerollButton)
        rerollButton.visible = false;
    if (banAbilitiesRoot)
        banAbilitiesRoot.visible = false;
}));
// updateHeroCard()
// fillCustomPickSlots(["npc_dota_hero_witch_doctor"])