--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
(() => {
    const DOTA_ITEM_SLOT_MIN = 0;
    const DOTA_ITEM_SLOT_MAX = 5;
    const MAX_ABILITY_INDEX = 32;
    const MAX_ABILITY_COUNT = 6;
    const root = $.GetContextPanel();
    const localPlayer = Players.GetLocalPlayer();
    let gameType = "";
    function findPanel(id) {
        const found = root.FindChildTraverse(id);
        if (found == null) {
            throw new Error(`Panel ${id} not found`);
        }
        return found;
    }
    function attachTooltip(image, name) {
        image.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowAbilityTooltip", image, name);
        });
        image.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideAbilityTooltip", image);
        });
    }
    function collectAbilities(hero) {
        const abilities = [];
        for (let index = 0; index < MAX_ABILITY_INDEX; index++) {
            const ability = Entities.GetAbility(hero, index);
            const abilityName = Abilities.GetAbilityName(ability);
            if (Game.IsValidAbility(ability) || abilityName === "wisp_spirits_lua") {
                if (abilities.length < MAX_ABILITY_COUNT) {
                    abilities.push(abilityName);
                }
            }
        }
        return abilities;
    }
    function collectItems(hero) {
        const items = [];
        for (let slot = DOTA_ITEM_SLOT_MIN; slot <= DOTA_ITEM_SLOT_MAX; slot++) {
            const item = Entities.GetItemInSlot(hero, slot);
            if (item != undefined) {
                items.push(Abilities.GetAbilityName(item));
            }
        }
        return items;
    }
    function createBasicInfo(parent, hero, playerId) {
        const basicInfo = $.CreatePanel("Panel", parent, "basicInfo");
        const heroImage = $.CreatePanel("DOTAHeroImage", basicInfo, "basicInfo_img");
        heroImage.heroimagestyle = "landscape";
        heroImage.heroname = Entities.GetUnitName(hero);
        const infoText = $.CreatePanel("Panel", basicInfo, "InfoText");
        const nameLabel = $.CreatePanel("Label", infoText, "PlayerName");
        nameLabel.text = Players.GetPlayerName(playerId);
        const heroInfo = $.CreatePanel("Label", infoText, "heroInfo");
        heroInfo.text = `Lv${Entities.GetLevel(hero)}  ${$.Localize(`#${Entities.GetUnitName(hero)}`)}`;
    }
    function createAbilities(parent, abilities) {
        const abilityPanel = $.CreatePanel("Panel", parent, "ability");
        for (const abilityName of abilities) {
            const image = $.CreatePanel("DOTAAbilityImage", abilityPanel, "abilityImage");
            image.abilityname = abilityName;
            attachTooltip(image, abilityName);
        }
    }
    function createItems(parent, items) {
        const itemsPanel = $.CreatePanel("Panel", parent, "items");
        for (const itemName of items) {
            const itemSlot = $.CreatePanel("Panel", itemsPanel, "itemSlot");
            const image = $.CreatePanel("DOTAItemImage", itemSlot, "itemImage");
            image.itemname = itemName;
            attachTooltip(image, itemName);
        }
    }
    function createBookStat(parent, itemName, count) {
        const group = $.CreatePanel("Panel", parent, "bookStat");
        const image = $.CreatePanel("DOTAItemImage", group, "bookImage");
        image.itemname = itemName;
        const label = $.CreatePanel("Label", group, "bookCount");
        label.text = String(count);
    }
    function createBooks(parent, playerId) {
        var _a, _b;
        const books = CustomNetTables.GetTableValue("player_books", playerId);
        const panel = $.CreatePanel("Panel", parent, "books");
        const inner = $.CreatePanel("Panel", panel, "booksInner");
        createBookStat(inner, "item_relearn_book_lua", (_a = books === null || books === void 0 ? void 0 : books["item_relearn_book_lua"]) !== null && _a !== void 0 ? _a : 0);
        createBookStat(inner, "item_relearn_torn_page_lua", (_b = books === null || books === void 0 ? void 0 : books["item_relearn_torn_page_lua"]) !== null && _b !== void 0 ? _b : 0);
    }
    function createValue(parent, panelId, labelId, text, html = false) {
        const container = $.CreatePanel("Panel", parent, panelId);
        const label = $.CreatePanel("Label", container, labelId);
        label.html = html;
        label.text = text;
    }
    function isLocalPlayerInFirstTeam(data) {
        const firstTeam = Object.values(data)[0];
        if (!firstTeam) {
            return false;
        }
        for (const playerId in firstTeam) {
            if (Number(playerId) === localPlayer) {
                return true;
            }
        }
        return false;
    }
    function buildPvpPlayer(parent, playerIdKey, playerData) {
        var _a, _b, _c, _d, _e, _f, _g;
        const playerId = Number(playerIdKey);
        const hero = Players.GetPlayerHeroEntityIndex(playerId);
        const pvpRecord = CustomNetTables.GetTableValue("pvp_record", playerId);
        const winCount = (_a = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.win) !== null && _a !== void 0 ? _a : 0;
        const loseCount = (_b = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.lose) !== null && _b !== void 0 ? _b : 0;
        const betReward = (_c = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.total_bet_reward) !== null && _c !== void 0 ? _c : 0;
        const gold = (_e = (_d = CustomNetTables.GetTableValue("player_info", playerId)) === null || _d === void 0 ? void 0 : _d.gold) !== null && _e !== void 0 ? _e : 0;
        const score = (_f = playerData.score) !== null && _f !== void 0 ? _f : 0;
        const origin = (_g = playerData.origin) !== null && _g !== void 0 ? _g : 0;
        const scoreChange = score - origin;
        const playerPanel = $.CreatePanel("Panel", parent, "PlayerInfo");
        playerPanel.SetHasClass("Self", playerId === localPlayer);
        createBasicInfo(playerPanel, hero, playerId);
        const record = $.CreatePanel("Panel", playerPanel, "pvp_record");
        const recordInner = $.CreatePanel("Panel", record, "pvp_record_inner");
        const winLabel = $.CreatePanel("Label", recordInner, "pvp_record_win");
        winLabel.text = String(winCount);
        const colonLabel = $.CreatePanel("Label", recordInner, "pvp_record_colon");
        colonLabel.text = ":";
        const loseLabel = $.CreatePanel("Label", recordInner, "pvp_record_lose");
        loseLabel.text = String(loseCount);
        createAbilities(playerPanel, collectAbilities(hero));
        createItems(playerPanel, collectItems(hero));
        createBooks(playerPanel, playerId);
        createValue(playerPanel, "gold", "gold_text", String(gold));
        createValue(playerPanel, "bet_reward", "bet_reward_text", String(betReward));
        const scoreColor = scoreChange >= 0 ? "#7cd15a" : "#fa7070";
        const scoreSign = scoreChange >= 0 ? "+" : "";
        const scoreText = `${score}(<font color='${scoreColor}'>${scoreSign}${scoreChange}</font>)`;
        createValue(playerPanel, "score", "score_text", scoreText, true);
    }
    function buildPvp(data) {
        const content = findPanel("CustomEndGame_content");
        const pvpContent = $.CreatePanel("Panel", content, "pvp_content");
        for (const teamData of Object.values(data)) {
            const teamPanel = $.CreatePanel("Panel", pvpContent, "teamInfo");
            for (const playerIdKey in teamData) {
                buildPvpPlayer(teamPanel, playerIdKey, teamData[playerIdKey]);
            }
        }
    }
    function buildPve(data) {
        var _a, _b, _c;
        const content = findPanel("CustomEndGame_content");
        const pveContent = $.CreatePanel("Panel", content, "pve_content");
        const playerId = localPlayer;
        const hero = Players.GetPlayerHeroEntityIndex(playerId);
        const reward = (_b = (_a = data.reward) === null || _a === void 0 ? void 0 : _a.moonstone) !== null && _b !== void 0 ? _b : 0;
        const round = (_c = data.round_num) !== null && _c !== void 0 ? _c : 0;
        const playerPanel = $.CreatePanel("Panel", pveContent, "PlayerInfo");
        playerPanel.AddClass("Self");
        createBasicInfo(playerPanel, hero, playerId);
        createAbilities(playerPanel, collectAbilities(hero));
        createItems(playerPanel, collectItems(hero));
        createValue(playerPanel, "round", "round_text", String(round));
        createValue(playerPanel, "reward", "reward_text", String(reward));
    }
    function setTitle(winner) {
        const title = findPanel("title_text");
        title.text = winner || gameType === "pve" ? $.Localize("#HUD_EndGame_title_victory") : $.Localize("#HUD_EndGame_title_defeat");
    }
    function show() {
        findPanel("CustomEndGame_root").style.visibility = "visible";
    }
    function tryBuild() {
        if (gameType !== "") {
            return;
        }
        const pvpData = CustomNetTables.GetTableValue("end_game", "pvp");
        if (pvpData != undefined) {
            gameType = "pvp";
            findPanel("pvp_title").style.visibility = "visible";
            buildPvp(pvpData);
            setTitle(isLocalPlayerInFirstTeam(pvpData));
            show();
            return;
        }
        const pveData = CustomNetTables.GetTableValue("end_game", "pve");
        if (pveData != undefined) {
            gameType = "pve";
            findPanel("pve_title").style.visibility = "visible";
            buildPve(pveData);
            setTitle(true);
            show();
        }
    }
    function bindQuitButton() {
        findPanel("CustomEndGame_QuitButton").SetPanelEvent("onactivate", () => {
            Game.LeaveCurrentGame();
        });
    }
    function init() {
        bindQuitButton();
        CustomNetTables.SubscribeNetTableListener("end_game", () => tryBuild());
        tryBuild();
    }
    init();
})();