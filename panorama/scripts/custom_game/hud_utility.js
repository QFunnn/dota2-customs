--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
(() => {
    const root = $.GetContextPanel();
    const TAB_LAYOUTS = {
        damage: "file://{resources}/layout/custom_game/hud_utility/damage_view.xml",
        rounds: "file://{resources}/layout/custom_game/hud_utility/rounds_view.xml",
    };
    const tabButtons = {
        damage: "HudUtilityTabDamage",
        rounds: "HudUtilityTabRounds",
    };
    let activeTab = "damage";
    let isShopOpen = false;
    let isHiddenByUser = false;
    const loadedTabPanels = {};
    let playerInfoShopListener;
    let damageState = {
        max: 0,
        total: 0,
        list: [],
    };
    let nextRounds = [];
    function findPanel(id) {
        const panel = root.FindChildTraverse(id);
        if (panel == null) {
            throw new Error(`Panel ${id} not found`);
        }
        return panel;
    }
    function maybePanel(id) {
        return root.FindChildTraverse(id);
    }
    function fixNumber(num) {
        let damage = Number(num.toFixed(0));
        let unit = "";
        if (damage > 1000000) {
            damage = Number((damage / 1000000).toPrecision(3));
            unit = "M";
        }
        else if (damage > 1000) {
            damage = Number((damage / 1000).toPrecision(3));
            unit = "K";
        }
        return `${damage}${unit}`;
    }
    function getAbilityDisplayName(abilityName) {
        if (abilityName.indexOf("AttackDamage") !== -1) {
            return $.Localize("#DOTA_Tooltip_ability_default_attack");
        }
        if (abilityName.indexOf("special_bonus") !== -1) {
            return $.Localize("#DOTA_AbilityBuild_Talent_Title");
        }
        return $.Localize(`#DOTA_Tooltip_ability_${abilityName}`).replace(/<[^>]*>/g, "");
    }
    function getTooltipAbilityName(abilityName) {
        if (abilityName.indexOf("AttackDamage") !== -1) {
            return undefined;
        }
        return abilityName;
    }
    function hasLocalPlayerSubscription() {
        var _a;
        const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()));
        const status = typeof (playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_status) === "string"
            ? playerInfo.subscription_status.toLowerCase()
            : "";
        return Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.subscription_active) !== null && _a !== void 0 ? _a : 0) === 1 || status === "active" || status === "subscribed";
    }
    function isAttackDamageEntry(abilityName) {
        return abilityName.indexOf("AttackDamage") !== -1;
    }
    function createLabel(parent, className, text) {
        const label = $.CreatePanel("Label", parent, "");
        label.AddClass(className);
        label.text = text;
        return label;
    }
    function setLabelStyle(label, color, fontSize, width, height) {
        label.style.color = color;
        label.style.fontSize = `${fontSize}px`;
        label.style.textShadow = "0px 1px 2px 2 #000000cc";
        label.style.textOverflow = "shrink";
        if (width) {
            label.style.width = width;
        }
        if (height) {
            label.style.height = height;
        }
    }
    function renderDamageView() {
        const totalDamage = maybePanel("TotalDamage");
        const details = maybePanel("DamageDetails");
        const empty = maybePanel("DamageEmpty");
        if (!totalDamage || !details || !empty) {
            return;
        }
        totalDamage.text = `${$.Localize("#Hud_DamageCounter_CurrentTotal")} ${fixNumber(damageState.total)}`;
        setLabelStyle(totalDamage, "#dde6f0", 15, "100%", "20px");
        totalDamage.style.marginLeft = "8px";
        totalDamage.style.marginRight = "8px";
        const summary = maybePanel("DamageSummary");
        if (summary) {
            summary.style.height = "0px";
            summary.style.visibility = "collapse";
        }
        details.style.width = "100%";
        details.style.height = "fit-children";
        details.style.maxHeight = "210px";
        details.style.flowChildren = "down";
        details.style.overflow = "squish scroll";
        details.style.marginTop = "0px";
        details.style.padding = "0px 5px 3px 5px";
        details.RemoveAndDeleteChildren();
        for (const entry of damageState.list) {
            if (typeof entry.abilityName !== "string") {
                continue;
            }
            const damageNumber = Number(entry.damage) || 0;
            const pct = damageNumber > damageState.max * 0.001
                ? damageNumber / (damageState.total === 0 ? 1 : damageState.total) * 100
                : 0;
            const row = $.CreatePanel("Panel", details, "");
            row.AddClass("DamageEntry");
            row.style.width = "100%";
            row.style.height = "32px";
            row.style.padding = "0px";
            row.style.flowChildren = "none";
            row.style.marginBottom = "3px";
            row.style.backgroundColor = "gradient(linear, 0% 0%, 100% 0%, from(#0b111acc), to(#05080db8))";
            row.style.border = "1px solid #ffffff14";
            row.style.borderRadius = "3px";
            const accent = $.CreatePanel("Panel", row, "");
            accent.AddClass("DamageEntryAccent");
            accent.style.width = "3px";
            accent.style.height = "100%";
            accent.style.backgroundColor = getDamageTypeColor(entry.damage_type);
            accent.style.borderRadius = "2px 0px 0px 2px";
            const bar = $.CreatePanel("Panel", row, "");
            bar.AddClass("DamageEntryBar");
            bar.AddClass(`DamageType${entry.damage_type}`);
            bar.style.backgroundColor = getDamageTypeColor(entry.damage_type);
            bar.style.height = "3px";
            bar.style.verticalAlign = "bottom";
            bar.style.opacity = "0.9";
            bar.style.border = "0px";
            bar.style.borderRadius = "0px 2px 2px 0px";
            bar.style.marginLeft = "3px";
            bar.style.marginRight = "0px";
            bar.style.width = `${pct}%`;
            const isAttackDamage = isAttackDamageEntry(entry.abilityName);
            const tooltipAbilityName = getTooltipAbilityName(entry.abilityName);
            let hasSourceIcon = false;
            if (isAttackDamage) {
                const icon = $.CreatePanel("DOTAHeroImage", row, "");
                icon.AddClass("DamageEntryAbilityIcon");
                icon.style.width = "24px";
                icon.style.height = "24px";
                icon.style.borderRadius = "2px";
                icon.style.marginLeft = "7px";
                icon.style.verticalAlign = "center";
                icon.heroname = entry.abilityName.replace("AttackDamage", "");
                icon.heroimagestyle = "icon";
                icon.hittest = false;
                hasSourceIcon = true;
            }
            else if (tooltipAbilityName) {
                const icon = $.CreatePanel("DOTAAbilityImage", row, "");
                icon.AddClass("DamageEntryAbilityIcon");
                icon.style.width = "24px";
                icon.style.height = "24px";
                icon.style.borderRadius = "2px";
                icon.style.marginLeft = "7px";
                icon.style.verticalAlign = "center";
                icon.abilityname = tooltipAbilityName;
                attachAbilityTooltip(icon, tooltipAbilityName);
                hasSourceIcon = true;
            }
            const nameLabel = createLabel(row, "DamageEntryAbilityName", "");
            nameLabel.html = true;
            nameLabel.text = getAbilityDisplayName(entry.abilityName);
            setLabelStyle(nameLabel, "#f2f5f8", 16, hasSourceIcon ? "144px" : "176px", "24px");
            nameLabel.style.horizontalAlign = "left";
            nameLabel.style.verticalAlign = "center";
            nameLabel.style.marginLeft = hasSourceIcon ? "40px" : "8px";
            nameLabel.style.transform = "translateY(2px)";
            const damageLabel = createLabel(row, "DamageEntryValue", "");
            damageLabel.html = true;
            damageLabel.text = `${fixNumber(damageNumber)} <font color='#aeb7c2'>(${(Math.floor(pct * 10) / 10).toFixed(1)}%)</font>`;
            setLabelStyle(damageLabel, "#dde6f0", 16, "96px", "24px");
            damageLabel.style.horizontalAlign = "right";
            damageLabel.style.verticalAlign = "center";
            damageLabel.style.textAlign = "right";
            damageLabel.style.marginRight = "9px";
            damageLabel.style.transform = "translateY(2px)";
        }
        empty.text = $.Localize("#Hud_DamageCounter_NoData");
        setLabelStyle(empty, "#aeb7c2", 16, "100%", "32px");
        empty.style.textAlign = "center";
        empty.style.marginTop = "4px";
        empty.style.visibility = damageState.list.length === 0 ? "visible" : "collapse";
    }
    function getDamageTypeColor(damageType) {
        if (damageType === 1) {
            return "#ae2f28";
        }
        if (damageType === 2) {
            return "#5b93d1";
        }
        if (damageType === 4) {
            return "#d8ae53";
        }
        return "#8d949e";
    }
    function normalizeAbilityList(abilities) {
        if (!abilities) {
            return [];
        }
        return abilities
            .split(",")
            .map((ability) => ability.trim())
            .filter((ability) => ability !== "")
            .slice(0, 3);
    }
    function localizeRoundName(name) {
        if (!name) {
            return $.Localize("#Hud_NextRounds_Unknown");
        }
        return $.Localize(name[0] === "#" ? name : `#${name}`);
    }
    function attachAbilityTooltip(panel, abilityName) {
        panel.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityName);
        });
        panel.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideAbilityTooltip", panel);
        });
    }
    function renderRoundEntry(parent, entry, index) {
        const row = $.CreatePanel("Panel", parent, "");
        row.AddClass("NextRoundEntry");
        row.SetHasClass("CurrentPhase", index === 0);
        row.style.width = "100%";
        row.style.height = "40px";
        row.style.padding = "2px 7px";
        row.style.flowChildren = "right";
        row.style.backgroundColor = index === 0 ? "#ffffff06" : "#00000010";
        const numberLabel = createLabel(row, "NextRoundNumber", entry.number != null ? String(entry.number) : "-");
        setLabelStyle(numberLabel, "#d94a42", 18, "38px", "26px");
        numberLabel.style.fontWeight = "bold";
        numberLabel.style.textAlign = "center";
        numberLabel.style.verticalAlign = "center";
        const body = $.CreatePanel("Panel", row, "");
        body.AddClass("NextRoundBody");
        body.style.width = "fill-parent-flow(1.0)";
        body.style.height = "fit-children";
        body.style.flowChildren = "down";
        body.style.verticalAlign = "center";
        const nameLabel = createLabel(body, "NextRoundName", localizeRoundName(entry.name));
        setLabelStyle(nameLabel, "#f2f5f8", 18, "154px", "23px");
        const metaLabel = createLabel(body, "NextRoundMeta", `${$.Localize("#Hud_NextRounds_Creeps")}: ${entry.count != null ? entry.count : "-"}`);
        setLabelStyle(metaLabel, "#aeb7c2", 16, "154px", "19px");
        const abilities = $.CreatePanel("Panel", row, "");
        abilities.AddClass("NextRoundAbilities");
        abilities.style.width = "70px";
        abilities.style.height = "24px";
        abilities.style.flowChildren = "left";
        abilities.style.verticalAlign = "center";
        abilities.style.horizontalAlign = "right";
        abilities.style.overflow = "clip";
        for (const abilityName of normalizeAbilityList(entry.abilities)) {
            const image = $.CreatePanel("DOTAAbilityImage", abilities, "");
            image.abilityname = abilityName;
            image.style.width = "22px";
            image.style.height = "22px";
            image.style.borderRadius = "3px";
            image.style.marginLeft = "1px";
            image.style.marginRight = "1px";
            attachAbilityTooltip(image, abilityName);
        }
    }
    function renderRoundsView() {
        const countLabel = maybePanel("NextRoundsCount");
        const list = maybePanel("NextRoundsList");
        const empty = maybePanel("NextRoundsEmpty");
        if (!list || !empty) {
            return;
        }
        const header = maybePanel("NextRoundsHeader");
        const headerText = maybePanel("NextRoundsHeaderText");
        if (header) {
            header.style.width = "100%";
            header.style.height = "30px";
            header.style.backgroundColor = "#00000018";
            header.style.border = "1px solid #ffffff08";
            header.style.borderRadius = "3px";
        }
        if (headerText) {
            headerText.text = $.Localize("#Hud_NextRounds_Header");
            setLabelStyle(headerText, "#c8d0dc", 16, "100%", "22px");
            headerText.style.textTransform = "uppercase";
            headerText.style.horizontalAlign = "center";
            headerText.style.verticalAlign = "center";
            headerText.style.textAlign = "center";
            headerText.style.marginLeft = "0px";
        }
        if (countLabel) {
            countLabel.text = "";
            countLabel.style.visibility = "collapse";
        }
        list.style.width = "100%";
        list.style.height = "fit-children";
        list.style.flowChildren = "down";
        list.style.overflow = "clip";
        list.style.marginTop = "4px";
        list.RemoveAndDeleteChildren();
        for (let i = 0; i < nextRounds.length; i++) {
            renderRoundEntry(list, nextRounds[i], i);
        }
        empty.text = $.Localize("#Hud_NextRounds_Empty");
        setLabelStyle(empty, "#aeb7c2", 15, "100%", "30px");
        empty.style.textAlign = "center";
        empty.style.marginTop = "4px";
        empty.style.visibility = nextRounds.length === 0 ? "visible" : "collapse";
    }
    function renderActiveTab() {
        if (activeTab === "damage") {
            renderDamageView();
        }
        else {
            renderRoundsView();
        }
    }
    function setActiveTabButton(nextTab) {
        for (const [tab, buttonId] of Object.entries(tabButtons)) {
            const button = maybePanel(buttonId);
            if (button) {
                button.SetHasClass("Selected", tab === nextTab);
            }
        }
    }
    function updateRoundListAccess() {
        const hasSubscription = hasLocalPlayerSubscription();
        const roundsButton = maybePanel(tabButtons.rounds);
        if (roundsButton) {
            roundsButton.style.visibility = "visible";
            roundsButton.SetHasClass("Locked", !hasSubscription);
            roundsButton.SetPanelEvent("onmouseover", () => {
                if (!hasLocalPlayerSubscription()) {
                    $.DispatchEvent("DOTAShowTextTooltip", roundsButton, $.Localize("#Hud_NextRounds_SubscriptionTooltip"));
                }
            });
            roundsButton.SetPanelEvent("onmouseout", () => {
                $.DispatchEvent("DOTAHideTextTooltip", roundsButton);
            });
        }
        if (!hasSubscription && activeTab === "rounds") {
            showTab("damage");
            return;
        }
        if (hasSubscription && activeTab === "rounds") {
            renderRoundsView();
        }
    }
    function showTab(nextTab) {
        const body = findPanel("HudUtilityBody");
        if (nextTab === "rounds" && !hasLocalPlayerSubscription()) {
            nextTab = "damage";
        }
        activeTab = nextTab;
        setActiveTabButton(nextTab);
        for (const [tab, panelInstance] of Object.entries(loadedTabPanels)) {
            panelInstance.visible = tab === nextTab;
        }
        if (!loadedTabPanels[nextTab]) {
            const contentPanel = $.CreatePanel("Panel", body, "");
            contentPanel.AddClass("HudUtilityTabContent");
            contentPanel.BLoadLayout(TAB_LAYOUTS[nextTab], false, false);
            loadedTabPanels[nextTab] = contentPanel;
        }
        renderActiveTab();
    }
    function applyWindowState() {
        const window = findPanel("HudUtilityWindow");
        const restoreButton = findPanel("HudUtilityRestoreButton");
        const hidden = isShopOpen || isHiddenByUser;
        window.SetHasClass("Flip", Game.IsHUDFlipped());
        window.SetHasClass("Hidden", hidden);
        window.SetHasClass("Show", !hidden);
        restoreButton.SetHasClass("Flip", Game.IsHUDFlipped());
        restoreButton.SetHasClass("Show", isHiddenByUser && !isShopOpen);
    }
    function updateWindowState() {
        applyWindowState();
        $.Schedule(1, updateWindowState);
    }
    function parseDamageData(data) {
        let max = 0;
        let total = 0;
        const list = [];
        for (const key in data) {
            const info = data[key];
            if (info == null || typeof info.abilityName !== "string") {
                continue;
            }
            const damage = Number(info.damage) || 0;
            max = Math.max(max, damage);
            total += damage;
            list.push({
                abilityName: info.abilityName,
                damage,
                damage_type: info.damage_type,
            });
        }
        list.sort((a, b) => b.damage - a.damage);
        return { max, total, list };
    }
    function toOrderedRoundList(data) {
        if (!(data === null || data === void 0 ? void 0 : data.entries)) {
            return [];
        }
        return Object.keys(data.entries)
            .sort((a, b) => Number(a) - Number(b))
            .map((key) => { var _a; return (_a = data.entries) === null || _a === void 0 ? void 0 : _a[key]; })
            .filter((entry) => entry != null)
            .slice(0, 10);
    }
    function readNextRounds() {
        nextRounds = toOrderedRoundList(CustomNetTables.GetTableValue("rounds", "next"));
        if (activeTab === "rounds") {
            renderRoundsView();
        }
    }
    function bindEvents() {
        const hideButton = maybePanel("HudUtilityHideButton");
        if (hideButton) {
            hideButton.SetPanelEvent("onactivate", () => {
                isHiddenByUser = true;
                applyWindowState();
            });
        }
        const restoreButton = maybePanel("HudUtilityRestoreButton");
        if (restoreButton) {
            restoreButton.SetPanelEvent("onactivate", () => {
                isHiddenByUser = false;
                applyWindowState();
            });
        }
        GameEvents.Subscribe("UpdateDamageData", (data) => {
            damageState = parseDamageData(data);
            if (activeTab === "damage") {
                renderDamageView();
            }
        });
        CustomNetTables.SubscribeNetTableListener("rounds", (_, key, value) => {
            if (String(key) !== "next") {
                return;
            }
            nextRounds = toOrderedRoundList(value);
            if (activeTab === "rounds") {
                renderRoundsView();
            }
        });
        if (playerInfoShopListener !== undefined) {
            CustomNetTables.UnsubscribeNetTableListener(playerInfoShopListener);
        }
        playerInfoShopListener = CustomNetTables.SubscribeNetTableListener("player_info_shop", (_, key) => {
            if (String(key) !== String(Players.GetLocalPlayer())) {
                return;
            }
            updateRoundListAccess();
        });
        $.RegisterForUnhandledEvent("DOTAHUDShopOpened", () => {
            isShopOpen = true;
            applyWindowState();
        });
        $.RegisterForUnhandledEvent("DOTAHUDShopClosed", () => {
            isShopOpen = false;
            applyWindowState();
        });
    }
    GameUI.SwitchHudUtilityTab = (tabId) => {
        showTab(tabId);
    };
    GameUI.SetHudUtilityHidden = (hidden) => {
        isHiddenByUser = hidden;
        applyWindowState();
    };
    function init() {
        bindEvents();
        readNextRounds();
        showTab("damage");
        updateRoundListAccess();
        updateWindowState();
    }
    init();
})();