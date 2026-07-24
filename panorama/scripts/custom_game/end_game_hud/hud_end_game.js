--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
(() => {
    const ITEM_SLOT_MIN = 0;
    const ITEM_SLOT_MAX = 5;
    const MAX_ABILITY_INDEX = 32;
    const ctx = $.GetContextPanel();
    const root = ctx.FindChildTraverse("CustomEndGame_root");
    const titleLabel = ctx.FindChildTraverse("title_text");
    const pvpTitle = ctx.FindChildTraverse("pvp_title");
    const pveTitle = ctx.FindChildTraverse("pve_title");
    const pvpContent = ctx.FindChildTraverse("pvp_content");
    const pveContent = ctx.FindChildTraverse("pve_content");
    let gameType = "";
    function find(parent, id) {
        return parent.FindChildTraverse(id);
    }
    function showRoot() {
        if (root)
            root.visible = true;
    }
    function collectAbilities(hero) {
        const list = [];
        for (let i = 0; i < MAX_ABILITY_INDEX; i++) {
            const ability = Entities.GetAbility(hero, i);
            const abilityName = Abilities.GetAbilityName(ability);
            if (Game.IsValidAbility(ability) || abilityName === "wisp_spirits_lua") {
                if (list.length <= 5) {
                    list.push(abilityName);
                }
            }
        }
        return list;
    }
    function collectItems(hero) {
        const list = [];
        for (let slot = ITEM_SLOT_MIN; slot <= ITEM_SLOT_MAX; slot++) {
            const item = Entities.GetItemInSlot(hero, slot);
            if (item !== undefined && item !== -1) {
                list.push(Abilities.GetAbilityName(item));
            }
        }
        return list;
    }
    function fillAbilities(container, abilities) {
        container.RemoveAndDeleteChildren();
        for (const abilityName of abilities) {
            const img = $.CreatePanel("DOTAAbilityImage", container, "abilityImage");
            img.abilityname = abilityName;
            img.SetPanelEvent("onmouseover", () => {
                $.DispatchEvent("DOTAShowAbilityTooltip", img, img.abilityname);
            });
            img.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideAbilityTooltip", img);
            });
        }
    }
    function fillItems(container, items) {
        container.RemoveAndDeleteChildren();
        for (const itemName of items) {
            const slot = $.CreatePanel("Panel", container, "itemSlot");
            const img = $.CreatePanel("DOTAItemImage", slot, "itemImage");
            img.itemname = itemName;
            img.SetPanelEvent("onmouseover", () => {
                $.DispatchEvent("DOTAShowAbilityTooltip", img, img.itemname);
            });
            img.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideAbilityTooltip", img);
            });
        }
    }
    function fillBasicInfo(rowPanel, playerId, hero) {
        const heroImg = find(rowPanel, "basicInfo_img");
        if (heroImg && hero !== -1) {
            heroImg.heroname = Entities.GetUnitName(hero);
            heroImg.heroimagestyle = "landscape";
        }
        const nameLabel = find(rowPanel, "PlayerName");
        if (nameLabel) {
            nameLabel.text = Players.GetPlayerName(playerId);
        }
        const heroInfo = find(rowPanel, "heroInfo");
        if (heroInfo && hero !== -1) {
            const unitName = Entities.GetUnitName(hero);
            heroInfo.text = "Lv" + Entities.GetLevel(hero) + "  " + $.Localize("#" + unitName);
        }
        const abilityContainer = find(rowPanel, "ability");
        if (abilityContainer) {
            fillAbilities(abilityContainer, hero !== -1 ? collectAbilities(hero) : []);
        }
        const itemsContainer = find(rowPanel, "items");
        if (itemsContainer) {
            fillItems(itemsContainer, hero !== -1 ? collectItems(hero) : []);
        }
        fillBooks(rowPanel, playerId);
    }
    function fillBooks(rowPanel, playerId) {
        var _a, _b;
        const books = CustomNetTables.GetTableValue("player_books", playerId);
        const relearnLabel = find(rowPanel, "relearn_book_count");
        if (relearnLabel)
            relearnLabel.text = String((_a = books === null || books === void 0 ? void 0 : books["item_relearn_book_lua"]) !== null && _a !== void 0 ? _a : 0);
        const tornLabel = find(rowPanel, "torn_page_count");
        if (tornLabel)
            tornLabel.text = String((_b = books === null || books === void 0 ? void 0 : books["item_relearn_torn_page_lua"]) !== null && _b !== void 0 ? _b : 0);
    }
    function buildPvpPlayerRow(teamPanel, playerId, score, origin) {
        var _a, _b, _c, _d, _e;
        const hero = Players.GetPlayerHeroEntityIndex(playerId);
        const pvpRecord = CustomNetTables.GetTableValue("pvp_record", playerId);
        const winCount = (_a = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.win) !== null && _a !== void 0 ? _a : 0;
        const loseCount = (_b = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.lose) !== null && _b !== void 0 ? _b : 0;
        const betReward = (_c = pvpRecord === null || pvpRecord === void 0 ? void 0 : pvpRecord.total_bet_reward) !== null && _c !== void 0 ? _c : 0;
        const gold = (_e = (_d = CustomNetTables.GetTableValue("player_info", playerId)) === null || _d === void 0 ? void 0 : _d.gold) !== null && _e !== void 0 ? _e : 0;
        const scoreChange = score - origin;
        // Создаём панель строки сразу с id="PlayerInfo": BLoadLayoutSnippet кладёт колонки
        // её детьми, и тогда применяются CSS-правила фикс-ширин колонок (#...#PlayerInfo #col),
        // иначе колонки без ширины и весь ряд схлопывается. find(row, ...) ищет колонки внутри.
        const row = $.CreatePanel("Panel", teamPanel, "PlayerInfo");
        row.BLoadLayoutSnippet("EndGamePvpPlayerSnippet");
        row.SetHasClass("Self", playerId === Players.GetLocalPlayer());
        fillBasicInfo(row, playerId, hero);
        const winLabel = find(row, "pvp_record_win");
        if (winLabel)
            winLabel.text = winCount + " " + $.Localize("#Hud_Scoreboard_winCount");
        const loseLabel = find(row, "pvp_record_lose");
        if (loseLabel)
            loseLabel.text = loseCount + " " + $.Localize("#Hud_Scoreboard_loseCount");
        const goldLabel = find(row, "gold_text");
        if (goldLabel)
            goldLabel.text = String(gold);
        const betLabel = find(row, "bet_reward_text");
        if (betLabel)
            betLabel.text = String(betReward);
        const scoreLabel = find(row, "score_text");
        if (scoreLabel) {
            // Прибавка рейтинга — зелёным, потеря — красным.
            const color = scoreChange >= 0 ? "#7cd15a" : "#fa7070";
            const sign = scoreChange >= 0 ? "+" : "";
            scoreLabel.text = score + "(" + `<font color='${color}'>${sign + scoreChange}</font>` + ")";
        }
    }
    function buildPvp(data) {
        var _a, _b, _c;
        if (!pvpContent)
            return;
        const hasPlayers = Object.values(data !== null && data !== void 0 ? data : {}).some(team => Object.keys(team !== null && team !== void 0 ? team : {}).length > 0);
        if (!hasPlayers)
            return;
        gameType = "pvp";
        let isWinner = false;
        const firstTeam = (_a = Object.entries(data)[0]) === null || _a === void 0 ? void 0 : _a[1];
        if (firstTeam) {
            for (const playerIdStr in firstTeam) {
                if (Number(playerIdStr) === Players.GetLocalPlayer()) {
                    isWinner = true;
                    break;
                }
            }
        }
        if (titleLabel) {
            titleLabel.text = $.Localize(isWinner ? "#congrates_first_place" : "#encourage_runner_ups");
        }
        if (pvpTitle)
            pvpTitle.visible = true;
        if (pveTitle)
            pveTitle.visible = false;
        pvpContent.RemoveAndDeleteChildren();
        for (const [, teamInfo] of Object.entries(data)) {
            const teamPanel = $.CreatePanel("Panel", pvpContent, "teamInfo");
            for (const [playerIdStr, value] of Object.entries(teamInfo)) {
                buildPvpPlayerRow(teamPanel, Number(playerIdStr), (_b = value === null || value === void 0 ? void 0 : value.score) !== null && _b !== void 0 ? _b : 0, (_c = value === null || value === void 0 ? void 0 : value.origin) !== null && _c !== void 0 ? _c : 0);
            }
        }
        pvpContent.visible = true;
        if (pveContent)
            pveContent.visible = false;
        showRoot();
    }
    function buildPve(data) {
        var _a, _b, _c;
        if (!pveContent)
            return;
        gameType = "pve";
        const playerId = Players.GetLocalPlayer();
        const hero = Players.GetPlayerHeroEntityIndex(playerId);
        const reward = (_b = (_a = data === null || data === void 0 ? void 0 : data.reward) === null || _a === void 0 ? void 0 : _a.moonstone) !== null && _b !== void 0 ? _b : 0;
        const round = (_c = data === null || data === void 0 ? void 0 : data.round_num) !== null && _c !== void 0 ? _c : 0;
        if (titleLabel)
            titleLabel.text = $.Localize("#congrates_first_place");
        if (pveTitle)
            pveTitle.visible = true;
        if (pvpTitle)
            pvpTitle.visible = false;
        const row = find(pveContent, "PlayerInfo");
        if (row) {
            fillBasicInfo(row, playerId, hero);
            const roundLabel = find(row, "round_text");
            if (roundLabel)
                roundLabel.text = String(round);
            const rewardLabel = find(row, "reward_text");
            if (rewardLabel)
                rewardLabel.text = String(reward);
        }
        pveContent.visible = true;
        if (pvpContent)
            pvpContent.visible = false;
        showRoot();
    }
    function hideAll() {
        if (root)
            root.visible = false;
        if (pvpTitle)
            pvpTitle.visible = false;
        if (pveTitle)
            pveTitle.visible = false;
        if (pvpContent)
            pvpContent.visible = false;
        if (pveContent)
            pveContent.visible = false;
    }
    (function init() {
        hideAll();
        // Debug-хук для превью (hud_end_game_stub.ts). Кладём в общий объект
        // GameUI.CustomUIConfig() (идиома проекта для разделяемых данных) и ДО подписок,
        // чтобы он точно выставился, даже если колбэк подписки на end_game что-то бросит.
        GameUI.CustomUIConfig().EndGameDebug = {
            renderPvp: (data) => buildPvp(data),
            renderPve: (data) => buildPve(data),
            hide: () => hideAll(),
        };
        const quitButton = ctx.FindChildTraverse("EndGameQuitButton");
        quitButton === null || quitButton === void 0 ? void 0 : quitButton.SetPanelEvent("onactivate", () => {
            Game.LeaveCurrentGame();
        });
        SubscribeAndFireNetTableByKey("end_game", "pvp", (_t, _k, value) => {
            if (value !== undefined && gameType !== "pvp") {
                buildPvp(value);
            }
        });
        SubscribeAndFireNetTableByKey("end_game", "pve", (_t, _k, value) => {
            if (value !== undefined && gameType !== "pve") {
                buildPve(value);
            }
        });
    })();
})();