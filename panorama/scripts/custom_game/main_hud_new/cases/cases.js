--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
var _a;
let currentCasesState;
let selectedCaseId = "";
let pendingOpenCaseId = "";
let selectedQuantity = 1;
let instantOpen = false;
let opening = false;
let openingSequence = 0;
let keepResultReel = false;
let idleReelRewardsSignature = "";
let renderedCaseRewardsSignature = "";
let activeRewardRevealSoundHandle = 0;
let shopItemsList = {};
const REEL_ITEM_WIDTH = 136;
const REEL_ITEM_MARGIN = 8;
const REEL_AREA_WIDTH = 1104;
const REEL_INSTANT_WINNER_INDEX = 3;
const REEL_WINNER_INDEX = 45;
const REEL_SPIN_DURATION = 7.2;
const REEL_FRAME_INTERVAL = 0.016;
const REEL_IDLE_MIN_OFFSET = Math.round(REEL_ITEM_WIDTH * 0.25);
const REEL_IDLE_MAX_OFFSET = Math.round(REEL_ITEM_WIDTH * 0.7);
const CASE_SOUND_REVEAL_DEFAULT = "Cases.RewardReveal.Default";
const CASE_SOUND_REVEAL_GREEN = "Cases.RewardReveal.Green";
const CASE_SOUND_REVEAL_GOLD = "Cases.RewardReveal.Gold";
const CASE_SOUND_REVEAL_RED = "Cases.RewardReveal.Red";
const CASE_SOUND_DUST = "Cases.RewardDust";
const CASE_SOUND_CLAIM = "Cases.RewardClaim";
const CASE_SOUND_OPEN = "Cases.Open";
function casesPanel(id) {
    return $.GetContextPanel().FindChildTraverse(id);
}
function casesToArray(data) {
    if (!data) {
        return [];
    }
    if (Array.isArray(data)) {
        return data;
    }
    return Object.keys(data).sort().map((key) => data[key]);
}
function localizeWithVars(token, vars) {
    let text = $.Localize(token);
    for (const key in vars) {
        text = text.replace(`{s:${key}}`, String(vars[key]));
    }
    return text;
}
function getLocalPlayerId() {
    return Players.GetLocalPlayer();
}
function getLocalCasesPlayerCoins() {
    var _a;
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(getLocalPlayerId()));
    return Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.gold) !== null && _a !== void 0 ? _a : 0);
}
function isCasesAvailable() {
    var _a;
    const casesEnabled = (currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.enabled) === 1 || (currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.enabled) === true;
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(getLocalPlayerId()));
    return casesEnabled && Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) === 1;
}
function getSelectedCase() {
    return casesToArray(currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.cases).find((caseInfo) => caseInfo.id === selectedCaseId);
}
function getCaseDisplayName(caseInfo) {
    const rawName = caseInfo.name ? $.Localize(caseInfo.name) : caseInfo.id;
    const baseName = rawName
        .replace(/^\s*(Кейс|Case)\s+/i, "")
        .replace(/\s+(кейс|case)\s*$/i, "")
        .trim();
    return `Кейс "${baseName || rawName}"`;
}
function getOwnedCaseCount(caseId = selectedCaseId) {
    var _a, _b;
    const playerCases = (_a = currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.player_cases) === null || _a === void 0 ? void 0 : _a[String(getLocalPlayerId())];
    return Number((_b = playerCases === null || playerCases === void 0 ? void 0 : playerCases[caseId]) !== null && _b !== void 0 ? _b : 0);
}
function renderCasePreview(parent, className) {
    const preview = $.CreatePanel("Panel", parent, "");
    preview.AddClass(className);
}
function getTotalOwnedCases() {
    var _a, _b;
    const playerCases = (_a = currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.player_cases) === null || _a === void 0 ? void 0 : _a[String(getLocalPlayerId())];
    if (!playerCases) {
        return 0;
    }
    let total = 0;
    for (const caseId in playerCases) {
        total += Number((_b = playerCases[caseId]) !== null && _b !== void 0 ? _b : 0);
    }
    return total;
}
function getRewardName(reward) {
    var _a;
    if (Number((_a = reward.currency) !== null && _a !== void 0 ? _a : 0) > 0) {
        return localizeWithVars("#HUD_Cases_currency_reward", { amount: Number(reward.currency) });
    }
    const itemName = reward.item_name || "";
    const localized = $.Localize(`#INVENTORY_ITEM_${itemName}`);
    return localized === `#INVENTORY_ITEM_${itemName}` ? itemName : localized;
}
function getRewardTier(reward) {
    var _a, _b, _c;
    const rarity = String((_a = reward.rarity) !== null && _a !== void 0 ? _a : "").toLowerCase();
    switch (rarity) {
        case "red":
            return "RarityRed";
        case "gold":
            return "RarityGold";
        case "green":
            return "RarityGreen";
        case "blue":
            return "RarityBlue";
        case "common":
            return "RarityCommon";
    }
    const currency = Number((_b = reward.currency) !== null && _b !== void 0 ? _b : 0);
    const dustCost = Number((_c = reward.dust_cost) !== null && _c !== void 0 ? _c : 0);
    const isExclusive = reward.case_exclusive === 1 || reward.case_exclusive === true;
    if (isExclusive || currency >= 6000) {
        return "TierTop";
    }
    if (currency >= 2000 || dustCost >= 500) {
        return "TierGood";
    }
    return "";
}
function getRewardRarityRank(reward) {
    const rank = Number(reward.rarity_rank);
    if (!isNaN(rank)) {
        return Math.max(0, Math.min(4, rank));
    }
    const tier = getRewardTier(reward);
    if (tier === "RarityRed") {
        return 4;
    }
    if (tier === "RarityGold" || tier === "TierTop") {
        return 3;
    }
    if (tier === "RarityGreen" || tier === "TierGood") {
        return 2;
    }
    if (tier === "RarityBlue") {
        return 1;
    }
    return 0;
}
function getSortedRewards(rewards) {
    return casesToArray(rewards).sort((a, b) => {
        var _a, _b;
        const rankDiff = getRewardRarityRank(b) - getRewardRarityRank(a);
        if (rankDiff !== 0) {
            return rankDiff;
        }
        return Number((_a = a.weight) !== null && _a !== void 0 ? _a : 0) - Number((_b = b.weight) !== null && _b !== void 0 ? _b : 0);
    });
}
function getRewardsSignature(caseInfo) {
    return casesToArray(caseInfo.rewards)
        .map((reward) => {
        var _a, _b, _c, _d, _e;
        return [
            reward.item_name || "",
            Number((_a = reward.currency) !== null && _a !== void 0 ? _a : 0),
            String((_b = reward.rarity) !== null && _b !== void 0 ? _b : ""),
            Number((_c = reward.rarity_rank) !== null && _c !== void 0 ? _c : 0),
            Number((_d = reward.weight) !== null && _d !== void 0 ? _d : 0),
            Number((_e = reward.dust_cost) !== null && _e !== void 0 ? _e : 0),
            reward.case_exclusive === 1 || reward.case_exclusive === true ? 1 : 0,
        ].join(":");
    })
        .join("|");
}
function getCaseRewardsRenderSignature(caseInfo) {
    return `${caseInfo.id}|${getRewardsSignature(caseInfo)}`;
}
function shuffleRewards(rewards) {
    const shuffled = rewards.slice();
    for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        const reward = shuffled[i];
        shuffled[i] = shuffled[j];
        shuffled[j] = reward;
    }
    return shuffled;
}
function playCaseSound(soundName) {
    return Game.EmitSound(soundName);
}
function stopRewardRevealSound() {
    if (activeRewardRevealSoundHandle !== 0) {
        Game.StopSound(activeRewardRevealSoundHandle);
        activeRewardRevealSoundHandle = 0;
    }
}
function playTrackedRewardRevealSound(soundName) {
    stopRewardRevealSound();
    activeRewardRevealSoundHandle = playCaseSound(soundName);
}
function playRewardRevealSound(reward) {
    switch (getRewardTier(reward)) {
        case "RarityRed":
            playTrackedRewardRevealSound(CASE_SOUND_REVEAL_RED);
            return;
        case "RarityGold":
        case "TierTop":
            playTrackedRewardRevealSound(CASE_SOUND_REVEAL_GOLD);
            return;
        case "RarityGreen":
        case "TierGood":
            playTrackedRewardRevealSound(CASE_SOUND_REVEAL_GREEN);
            return;
    }
    playTrackedRewardRevealSound(CASE_SOUND_REVEAL_DEFAULT);
}
function getRandomReward(rewards, fallback) {
    if (rewards.length === 0) {
        return fallback;
    }
    return rewards[Math.floor(Math.random() * rewards.length)] || fallback;
}
function getIdleReelOffset() {
    return REEL_IDLE_MIN_OFFSET + Math.floor(Math.random() * (REEL_IDLE_MAX_OFFSET - REEL_IDLE_MIN_OFFSET + 1));
}
function updateCasesCoins() {
    const coins = casesPanel("CasesCoinsValue");
    if (coins) {
        coins.text = String(getLocalCasesPlayerCoins());
    }
}
function updateOwnedCount() {
    const selectedCount = getOwnedCaseCount();
    const owned = casesPanel("CaseOwnedCount");
    if (owned) {
        owned.text = `${$.Localize("#HUD_Cases_owned_prefix")} ${selectedCount}`;
    }
    const totalCount = getTotalOwnedCases();
    const total = casesPanel("CasesOwnedTotal");
    if (total) {
        total.text = `${$.Localize("#HUD_Cases_total_owned_prefix")} ${totalCount}`;
    }
}
function updateCasesAvailability() {
    const banner = casesPanel("CasesUnavailableBanner");
    if (banner) {
        banner.SetHasClass("Hidden", isCasesAvailable());
    }
    updateActionButtons();
}
function updateActionButtons() {
    const buyButton = casesPanel("CasesBuyButton");
    const openButton = casesPanel("CasesOpenButton");
    const caseInfo = getSelectedCase();
    const available = isCasesAvailable() && !opening && !!caseInfo && selectedQuantity > 0 && selectedQuantity <= 10;
    if (buyButton) {
        buyButton.enabled = available && !!caseInfo && getLocalCasesPlayerCoins() >= caseInfo.cost * selectedQuantity;
    }
    if (openButton) {
        openButton.enabled = available && getOwnedCaseCount() >= 1;
    }
    const minusButton = casesPanel("CasesQuantityMinus");
    if (minusButton) {
        minusButton.enabled = !opening && selectedQuantity > 1;
    }
    const plusButton = casesPanel("CasesQuantityPlus");
    if (plusButton) {
        plusButton.enabled = !opening && selectedQuantity < 10;
    }
}
function setSelectedQuantity(quantity) {
    selectedQuantity = Math.max(1, Math.min(10, Math.round(quantity)));
    updateQuantityLabel();
}
function updateQuantityLabel() {
    const quantity = casesPanel("CasesQuantityValue");
    if (quantity) {
        quantity.text = String(selectedQuantity);
    }
    const total = casesPanel("CasesBuyTotalValue");
    const caseInfo = getSelectedCase();
    if (total) {
        if (!caseInfo) {
            total.text = "0";
        }
        else if (selectedQuantity <= 1) {
            total.text = String(caseInfo.cost);
        }
        else {
            total.text = `${caseInfo.cost} x ${selectedQuantity} = ${caseInfo.cost * selectedQuantity}`;
        }
    }
    updateActionButtons();
}
function renderCasesList() {
    const list = casesPanel("CasesList");
    if (!list) {
        return;
    }
    list.RemoveAndDeleteChildren();
    for (const caseInfo of casesToArray(currentCasesState === null || currentCasesState === void 0 ? void 0 : currentCasesState.cases)) {
        const card = $.CreatePanel("Button", list, `CaseCard_${caseInfo.id}`);
        card.AddClass("CaseCard");
        card.SetPanelEvent("onactivate", () => openCaseDetail(caseInfo.id));
        renderCasePreview(card, "CaseCardPreview");
        const name = $.CreatePanel("Label", card, "");
        name.AddClass("CaseCardName");
        name.text = getCaseDisplayName(caseInfo);
        const price = $.CreatePanel("Panel", card, "");
        price.AddClass("CaseCardPrice");
        const icon = $.CreatePanel("Panel", price, "");
        icon.AddClass("CasesCoinIcon");
        const value = $.CreatePanel("Label", price, "");
        value.AddClass("CaseCardPriceValue");
        value.text = String(caseInfo.cost);
        const owned = $.CreatePanel("Label", card, "");
        owned.AddClass("CaseCardOwned");
        owned.text = `${$.Localize("#HUD_Cases_owned_prefix")} ${getOwnedCaseCount(caseInfo.id)}`;
    }
}
function renderRewardPreview(parent, reward) {
    var _a;
    const preview = $.CreatePanel("Panel", parent, "");
    preview.AddClass("CaseRewardPreview");
    if (Number((_a = reward.currency) !== null && _a !== void 0 ? _a : 0) > 0) {
        const currency = $.CreatePanel("Panel", preview, "");
        currency.AddClass("CaseCurrencyPreview");
        $.CreatePanel("Panel", currency, "", { class: "CaseCurrencyIcon" });
        const amount = $.CreatePanel("Label", currency, "");
        amount.AddClass("CaseCurrencyAmount");
        amount.text = String(reward.currency);
        return;
    }
    const itemInfo = reward.item_name ? shopItemsList[reward.item_name] : undefined;
    if (!itemInfo || !itemInfo.preview_value) {
        return;
    }
    if (itemInfo.preview_type === 1) {
        preview.style.backgroundImage = `url('${itemInfo.preview_value}');`;
        preview.style.backgroundSize = "contain";
        preview.style.backgroundRepeat = "no-repeat";
        preview.style.backgroundPosition = "center";
        return;
    }
    if (itemInfo.preview_type === 2) {
        const previewParams = itemInfo.preview_params || {
            origin: "0 0 0",
            look_at: "0 0 0",
            fov: "60",
        };
        $.CreatePanel("DOTAParticleScenePanel", preview, "", {
            class: "CaseRewardPreviewPanel",
            hittest: "false",
            particleName: itemInfo.preview_value,
            startActive: "true",
            particleonly: "false",
            cameraOrigin: previewParams.origin || "0 0 0",
            lookAt: previewParams.look_at || "0 0 0",
            fov: previewParams.fov || "60",
            squarePixels: "true",
            drawbackground: "true",
        });
        return;
    }
    if (itemInfo.preview_type === 3) {
        $.CreatePanel("DOTAScenePanel", preview, "", {
            class: "CaseRewardPreviewPanel",
            hittest: "false",
            renderdeferred: "false",
            antialias: "false",
            particleonly: "false",
            drawbackground: "false",
            light: "light",
            camera: "camera1",
            unit: itemInfo.preview_value,
        });
        return;
    }
    if (itemInfo.preview_type === 4) {
        $.CreatePanel("Movie", preview, "", {
            class: "CaseRewardPreviewPanel",
            src: itemInfo.preview_value,
            repeat: "true",
            autoplay: "onload",
            hittest: "false",
        });
    }
}
function renderRewardPanel(container, reward, className, winner = false) {
    const item = $.CreatePanel("Panel", container, "");
    item.AddClass(className);
    item.SetHasClass("Winner", winner);
    const tier = getRewardTier(reward);
    if (tier) {
        item.AddClass(tier);
    }
    renderRewardPreview(item, reward);
    const name = $.CreatePanel("Label", item, "");
    name.AddClass("CaseRewardName");
    name.text = getRewardName(reward);
    return item;
}
function renderResultPreview(parent, reward) {
    const preview = $.CreatePanel("Panel", parent, "");
    preview.AddClass("CaseResultPreview");
    renderRewardPreview(preview, reward);
}
function renderCaseRewards(caseInfo, force = false) {
    const rewards = casesPanel("CasesRewards");
    if (!rewards) {
        return;
    }
    const signature = getCaseRewardsRenderSignature(caseInfo);
    if (!force && renderedCaseRewardsSignature === signature) {
        return;
    }
    renderedCaseRewardsSignature = signature;
    rewards.RemoveAndDeleteChildren();
    for (const reward of getSortedRewards(caseInfo.rewards)) {
        renderRewardPanel(rewards, reward, "CaseRewardItem");
    }
}
function renderIdleReel(caseInfo) {
    const reel = casesPanel("CasesReel");
    if (!reel) {
        return;
    }
    idleReelRewardsSignature = getRewardsSignature(caseInfo);
    reel.RemoveAndDeleteChildren();
    reel.style.transitionDuration = "0s";
    reel.style.transform = `translateX(-${getIdleReelOffset()}px)`;
    const rewards = shuffleRewards(casesToArray(caseInfo.rewards));
    for (let i = 0; i < 12; i++) {
        const reward = rewards[i % Math.max(1, rewards.length)];
        if (reward) {
            renderRewardPanel(reel, reward, "CaseReelItem");
        }
    }
}
function renderResultReel(caseInfo, result) {
    const reel = casesPanel("CasesReel");
    if (!reel) {
        return;
    }
    idleReelRewardsSignature = getRewardsSignature(caseInfo);
    reel.RemoveAndDeleteChildren();
    reel.style.transitionDuration = "0s";
    const rewards = getSortedRewards(caseInfo.rewards);
    const sequence = [];
    for (let i = 0; i < REEL_INSTANT_WINNER_INDEX; i++) {
        sequence.push(getRandomReward(rewards, result));
    }
    sequence.push(result);
    for (let i = 0; i < 8; i++) {
        sequence.push(getRandomReward(rewards, result));
    }
    sequence.forEach((reward, index) => renderRewardPanel(reel, reward, "CaseReelItem", index === REEL_INSTANT_WINNER_INDEX));
    reel.style.transform = `translateX(-${getReelTargetOffset(REEL_INSTANT_WINNER_INDEX)}px)`;
}
function openCaseDetail(caseId) {
    var _a, _b, _c, _d;
    selectedCaseId = caseId;
    keepResultReel = false;
    idleReelRewardsSignature = "";
    renderedCaseRewardsSignature = "";
    setSelectedQuantity(1);
    const caseInfo = getSelectedCase();
    if (!caseInfo) {
        return;
    }
    (_a = casesPanel("CasesListView")) === null || _a === void 0 ? void 0 : _a.AddClass("Hidden");
    (_b = casesPanel("CaseDetailView")) === null || _b === void 0 ? void 0 : _b.RemoveClass("Hidden");
    (_c = casesPanel("CustomCasesOverlay")) === null || _c === void 0 ? void 0 : _c.AddClass("CaseDetailMode");
    const name = casesPanel("CaseDetailName");
    if (name) {
        name.text = getCaseDisplayName(caseInfo);
    }
    const desc = casesPanel("CaseDetailDesc");
    if (desc) {
        desc.text = caseInfo.description ? $.Localize(caseInfo.description) : "";
    }
    const price = casesPanel("CaseDetailPrice");
    if (price) {
        price.text = String(caseInfo.cost);
    }
    (_d = casesPanel("CasesResults")) === null || _d === void 0 ? void 0 : _d.RemoveAndDeleteChildren();
    hideResultsOverlay();
    renderCaseRewards(caseInfo, true);
    renderIdleReel(caseInfo);
    updateOwnedCount();
    updateQuantityLabel();
}
function openExternalCase(caseId) {
    pendingOpenCaseId = caseId;
    if (!caseId || !currentCasesState) {
        return;
    }
    const caseInfo = casesToArray(currentCasesState.cases).find(info => info.id === caseId);
    if (!caseInfo) {
        return;
    }
    pendingOpenCaseId = "";
    openCaseDetail(caseId);
}
GameUI.BackToCasesList = () => {
    var _a, _b, _c;
    if (opening) {
        return;
    }
    selectedCaseId = "";
    keepResultReel = false;
    idleReelRewardsSignature = "";
    renderedCaseRewardsSignature = "";
    hideResultsOverlay();
    (_a = casesPanel("CaseDetailView")) === null || _a === void 0 ? void 0 : _a.AddClass("Hidden");
    (_b = casesPanel("CasesListView")) === null || _b === void 0 ? void 0 : _b.RemoveClass("Hidden");
    (_c = casesPanel("CustomCasesOverlay")) === null || _c === void 0 ? void 0 : _c.RemoveClass("CaseDetailMode");
};
GameUI.DecreaseCasesQuantity = () => {
    setSelectedQuantity(selectedQuantity - 1);
};
GameUI.IncreaseCasesQuantity = () => {
    setSelectedQuantity(selectedQuantity + 1);
};
GameUI.ToggleCasesInstant = () => {
    const toggle = casesPanel("CasesInstantToggle");
    instantOpen = (toggle === null || toggle === void 0 ? void 0 : toggle.checked) === true;
};
GameUI.OpenCustomCase = (caseId) => {
    openExternalCase(caseId);
};
GameUI.BuySelectedCase = () => {
    const caseInfo = getSelectedCase();
    if (!caseInfo || !isCasesAvailable() || opening) {
        return;
    }
    if (getLocalCasesPlayerCoins() < caseInfo.cost * selectedQuantity) {
        return;
    }
    GameEvents.SendCustomGameEventToServer("cases_buy", {
        case_id: selectedCaseId,
        quantity: selectedQuantity,
    });
};
GameUI.OpenSelectedCase = () => {
    var _a;
    const caseInfo = getSelectedCase();
    if (!caseInfo || !isCasesAvailable() || opening || getOwnedCaseCount() < 1) {
        return;
    }
    opening = true;
    openingSequence++;
    keepResultReel = false;
    idleReelRewardsSignature = "";
    updateActionButtons();
    (_a = casesPanel("CasesResults")) === null || _a === void 0 ? void 0 : _a.RemoveAndDeleteChildren();
    hideResultsOverlay();
    playCaseSound(CASE_SOUND_OPEN);
    GameEvents.SendCustomGameEventToServer("cases_open", {
        case_id: selectedCaseId,
        quantity: 1,
    });
};
function hideResultsOverlay() {
    var _a;
    stopRewardRevealSound();
    (_a = casesPanel("CasesResultsOverlay")) === null || _a === void 0 ? void 0 : _a.AddClass("Hidden");
}
function updateResultsOverlayVisibility() {
    const overlay = casesPanel("CasesResultsOverlay");
    const results = casesPanel("CasesResults");
    if (!overlay || !results) {
        return;
    }
    for (let i = 0; i < results.GetChildCount(); i++) {
        const child = results.GetChild(i);
        if (child === null || child === void 0 ? void 0 : child.BHasClass("Unresolved")) {
            overlay.RemoveClass("Hidden");
            return;
        }
    }
    overlay.AddClass("Hidden");
}
function renderResults(rewards) {
    var _a, _b, _c;
    const results = casesPanel("CasesResults");
    if (!results) {
        return;
    }
    results.RemoveAndDeleteChildren();
    (_a = casesPanel("CasesResultsOverlay")) === null || _a === void 0 ? void 0 : _a.SetHasClass("Hidden", rewards.length === 0);
    const reward = rewards[0];
    if (reward) {
        playRewardRevealSound(reward);
        const item = $.CreatePanel("Panel", results, "");
        item.AddClass("CaseResultItem");
        item.SetHasClass("Unresolved", true);
        const tier = getRewardTier(reward);
        if (tier) {
            item.AddClass(tier);
        }
        renderResultPreview(item, reward);
        const name = $.CreatePanel("Label", item, "");
        name.AddClass("CaseRewardName");
        name.text = getRewardName(reward);
        const actions = $.CreatePanel("Panel", item, "");
        actions.AddClass("CaseResultActions");
        const claim = $.CreatePanel("Button", actions, "");
        claim.AddClass("CaseResultButton");
        const isCurrency = Number((_b = reward.currency) !== null && _b !== void 0 ? _b : 0) > 0;
        const canClaimItem = reward.can_claim === 1 || reward.can_claim === true;
        claim.SetHasClass("Hidden", !isCurrency && !canClaimItem);
        claim.enabled = isCurrency || canClaimItem;
        const dust = $.CreatePanel("Button", actions, "");
        dust.AddClass("CaseResultButton");
        dust.AddClass("Dust");
        dust.SetHasClass("Hidden", isCurrency);
        claim.SetPanelEvent("onactivate", () => {
            stopRewardRevealSound();
            playCaseSound(CASE_SOUND_CLAIM);
            GameEvents.SendCustomGameEventToServer("cases_claim_reward", { reward_id: reward.reward_id });
            item.SetHasClass("Unresolved", false);
            claim.enabled = false;
            dust.enabled = false;
            updateResultsOverlayVisibility();
        });
        const claimText = $.CreatePanel("Label", claim, "");
        claimText.text = $.Localize("#HUD_Cases_claim");
        dust.SetPanelEvent("onactivate", () => {
            stopRewardRevealSound();
            playCaseSound(CASE_SOUND_DUST);
            GameEvents.SendCustomGameEventToServer("cases_dust_reward", { reward_id: reward.reward_id });
            item.SetHasClass("Unresolved", false);
            claim.enabled = false;
            dust.enabled = false;
            updateResultsOverlayVisibility();
        });
        const dustText = $.CreatePanel("Label", dust, "");
        dustText.AddClass("CaseResultDustText");
        dustText.text = $.Localize("#HUD_Cases_dust");
        const dustPrice = $.CreatePanel("Panel", dust, "");
        dustPrice.AddClass("CaseResultDustPrice");
        const dustAmount = $.CreatePanel("Label", dustPrice, "");
        dustAmount.AddClass("CaseResultDustAmount");
        dustAmount.text = String((_c = reward.dust_cost) !== null && _c !== void 0 ? _c : 0);
        $.CreatePanel("Panel", dustPrice, "", { class: "CaseDustCoinIcon" });
    }
}
function getReelTargetOffset(finalIndex) {
    const itemStride = REEL_ITEM_WIDTH + REEL_ITEM_MARGIN;
    const reelArea = casesPanel("CasesReelArea");
    const reelAreaWidth = Number(reelArea && reelArea.actuallayoutwidth ? reelArea.actuallayoutwidth : REEL_AREA_WIDTH);
    const pointerCenter = reelAreaWidth / 2;
    const itemCenter = REEL_ITEM_WIDTH / 2;
    return Math.max(0, Math.round(finalIndex * itemStride - pointerCenter + itemCenter));
}
function easeOutCubicCases(progress) {
    const inverse = 1 - progress;
    return 1 - inverse * inverse * inverse;
}
function animateReel(caseInfo, result, sequenceId, onComplete) {
    const reel = casesPanel("CasesReel");
    if (!reel) {
        onComplete();
        return;
    }
    const reelPanel = reel;
    reelPanel.RemoveAndDeleteChildren();
    reelPanel.style.transitionDuration = "0s";
    reelPanel.style.transform = "translateX(0px)";
    const rewards = getSortedRewards(caseInfo.rewards);
    const sequence = [];
    for (let i = 0; i < REEL_WINNER_INDEX; i++) {
        sequence.push(getRandomReward(rewards, result));
    }
    sequence.push(result);
    for (let i = 0; i < 24; i++) {
        sequence.push(getRandomReward(rewards, result));
    }
    sequence.forEach((reward, index) => renderRewardPanel(reelPanel, reward, "CaseReelItem", index === REEL_WINNER_INDEX));
    const targetOffset = getReelTargetOffset(REEL_WINNER_INDEX);
    const startTime = Date.now();
    function setReelOffset(offset) {
        reelPanel.style.transform = `translateX(-${Math.round(offset)}px)`;
    }
    function animateFrame() {
        if (sequenceId !== openingSequence || !opening) {
            return;
        }
        const elapsed = (Date.now() - startTime) / 1000;
        const progress = Math.max(0, Math.min(1, elapsed / REEL_SPIN_DURATION));
        setReelOffset(targetOffset * easeOutCubicCases(progress));
        if (progress < 1) {
            $.Schedule(REEL_FRAME_INTERVAL, animateFrame);
            return;
        }
        setReelOffset(targetOffset);
    }
    reelPanel.style.transitionDuration = "0s";
    setReelOffset(0);
    animateFrame();
    $.Schedule(REEL_SPIN_DURATION + 0.35, () => {
        if (sequenceId !== openingSequence || !opening) {
            return;
        }
        onComplete();
    });
}
function onCasesOpenResult(event) {
    const rewards = casesToArray(event.rewards);
    const caseInfo = getSelectedCase();
    const sequenceId = openingSequence;
    const finish = () => {
        if (sequenceId !== openingSequence) {
            return;
        }
        renderResults(rewards);
        const result = rewards[rewards.length - 1];
        keepResultReel = !!caseInfo && !!result;
        if (instantOpen && caseInfo && result) {
            renderResultReel(caseInfo, result);
        }
        opening = false;
        updateOwnedCount();
        updateActionButtons();
        if (caseInfo && !keepResultReel) {
            renderIdleReel(caseInfo);
        }
    };
    if (instantOpen || !caseInfo || rewards.length === 0) {
        finish();
        return;
    }
    animateReel(caseInfo, rewards[rewards.length - 1], sequenceId, finish);
}
function onCasesStateChanged(state) {
    currentCasesState = state;
    renderCasesList();
    if (pendingOpenCaseId) {
        openExternalCase(pendingOpenCaseId);
        return;
    }
    const caseInfo = getSelectedCase();
    if (caseInfo && !opening) {
        renderCaseRewards(caseInfo);
        if (!keepResultReel && idleReelRewardsSignature !== getRewardsSignature(caseInfo)) {
            renderIdleReel(caseInfo);
        }
    }
    updateOwnedCount();
    updateCasesAvailability();
}
GameEvents.Subscribe("cases_open_result", onCasesOpenResult);
CustomNetTables.SubscribeNetTableListener("cases", (_, key, value) => {
    if (key === "state") {
        onCasesStateChanged(value);
    }
});
CustomNetTables.SubscribeNetTableListener("items", (_, key, value) => {
    if (key === "list") {
        shopItemsList = (value !== null && value !== void 0 ? value : {});
        const caseInfo = getSelectedCase();
        if (caseInfo && !opening) {
            renderCaseRewards(caseInfo, true);
            if (!keepResultReel) {
                renderIdleReel(caseInfo);
            }
        }
    }
});
CustomNetTables.SubscribeNetTableListener("player_info_shop", (_, key) => {
    if (key === String(getLocalPlayerId())) {
        updateCasesCoins();
        updateCasesAvailability();
    }
});
shopItemsList = ((_a = CustomNetTables.GetTableValue("items", "list")) !== null && _a !== void 0 ? _a : {});
updateCasesCoins();
setSelectedQuantity(1);
$.Schedule(0.1, updateQuantityLabel);
onCasesStateChanged(CustomNetTables.GetTableValue("cases", "state"));