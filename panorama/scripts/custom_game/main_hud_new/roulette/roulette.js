--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";
const ROULETTE_COIN_ICON = "file://{images}/custom_game/ratten_coin_small.png";
const ROULETTE_MULTIPLIERS = [2, 3, 5, 10];
const DEFAULT_SECTOR_COUNT = 40;
const SPIN_ACCEL_DURATION = 1.2;
const SPIN_CRUISE_DURATION = 3;
const SPIN_ACCEL_TURNS = 1;
const SPIN_CRUISE_TURNS = 3;
const SPIN_DECEL_TURNS = 2;
const SPIN_FRAME_INTERVAL = 1 / 60;
let selectedMultiplier = 2;
let isSpinning = false;
let spinVisualActive = false;
let currentRotation = 0;
let spinAnimationId = 0;
let currentState;
let activeSpinRoundId;
let pendingSpinFinish;
function roulettePanel(id) {
    return $.GetContextPanel().FindChildTraverse(id);
}
function rouletteToArray(data) {
    if (!data) {
        return [];
    }
    if (data instanceof Array) {
        return data;
    }
    const result = [];
    for (const key of Object.keys(data)) {
        result.push(data[key]);
    }
    return result;
}
function getBetAmount() {
    var _a;
    const input = roulettePanel("RouletteBetAmount");
    const amount = Number((_a = input === null || input === void 0 ? void 0 : input.text) !== null && _a !== void 0 ? _a : 0);
    if (!isFinite(amount)) {
        return 0;
    }
    return Math.floor(amount);
}
function getLocalPlayerCoins() {
    var _a;
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()));
    return Math.max(0, Math.floor(Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.gold) !== null && _a !== void 0 ? _a : 0)));
}
function isRouletteBettingAvailableForLocalPlayer() {
    var _a;
    const rouletteEnabled = (currentState === null || currentState === void 0 ? void 0 : currentState.enabled) === 1 || (currentState === null || currentState === void 0 ? void 0 : currentState.enabled) === true;
    const playerInfo = CustomNetTables.GetTableValue("player_info_shop", String(Players.GetLocalPlayer()));
    return rouletteEnabled && Number((_a = playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.shop_available) !== null && _a !== void 0 ? _a : 0) === 1;
}
function updateRouletteUnavailableBanner() {
    const banner = roulettePanel("RouletteUnavailableBanner");
    if (!banner) {
        return;
    }
    banner.SetHasClass("Hidden", isRouletteBettingAvailableForLocalPlayer());
}
function updateRouletteCoins() {
    const coins = roulettePanel("RouletteCoinsValue");
    if (!coins) {
        return;
    }
    coins.text = `${getLocalPlayerCoins()}`;
}
function setBetAmount(amount) {
    const input = roulettePanel("RouletteBetAmount");
    if (!input) {
        return;
    }
    input.text = `${Math.max(0, Math.min(getLocalPlayerCoins(), Math.floor(amount)))}`;
}
function clampBetAmountToCoins() {
    const amount = getBetAmount();
    const maxCoins = getLocalPlayerCoins();
    if (amount > maxCoins) {
        setBetAmount(maxCoins);
        return maxCoins;
    }
    return amount;
}
function hasLocalPlayerJoined() {
    const localPlayerId = Players.GetLocalPlayer();
    return rouletteToArray(currentState === null || currentState === void 0 ? void 0 : currentState.participants).some((participant) => participant.player_id === localPlayerId);
}
function updateBetButton() {
    const button = roulettePanel("RouletteBetButton");
    if (!button) {
        return;
    }
    const amount = getBetAmount();
    button.enabled = isRouletteBettingAvailableForLocalPlayer() && (currentState === null || currentState === void 0 ? void 0 : currentState.phase) === "betting" && !hasLocalPlayerJoined() && amount > 0 && amount <= getLocalPlayerCoins();
}
function updateMultiplierButtons() {
    for (const multiplier of ROULETTE_MULTIPLIERS) {
        const button = roulettePanel(`RouletteMultiplier${multiplier}`);
        if (!button) {
            continue;
        }
        button.SetHasClass("Selected", multiplier === selectedMultiplier);
        button.enabled = isRouletteBettingAvailableForLocalPlayer() && (currentState === null || currentState === void 0 ? void 0 : currentState.phase) === "betting" && !hasLocalPlayerJoined();
    }
}
function updateTimer() {
    const timer = roulettePanel("RouletteTimer");
    if (!timer || !currentState) {
        return;
    }
    const isAvailable = isRouletteBettingAvailableForLocalPlayer();
    timer.SetHasClass("Hidden", !isAvailable);
    timer.text = isAvailable && currentState.phase === "betting" ? `${currentState.time_remaining}` : "0";
}
function setResultText(text) {
    const result = roulettePanel("RouletteResult");
    if (!result) {
        return;
    }
    result.text = text;
    result.SetHasClass("Hidden", text === "");
}
function renderParticipants() {
    const container = roulettePanel("RouletteParticipants");
    if (!container) {
        return;
    }
    container.RemoveAndDeleteChildren();
    const participants = rouletteToArray(currentState === null || currentState === void 0 ? void 0 : currentState.participants);
    if (participants.length === 0) {
        const empty = $.CreatePanel("Label", container, "");
        empty.text = $.Localize("#HUD_Roulette_no_players");
        empty.AddClass("RouletteParticipantBet");
        empty.AddClass("RouletteEmptyParticipants");
        return;
    }
    for (const participant of participants) {
        const row = $.CreatePanel("Panel", container, "");
        row.AddClass("RouletteParticipant");
        const heroImage = $.CreatePanel("Image", row, "");
        heroImage.AddClass("RouletteParticipantHero");
        const heroName = participant.hero_name || Players.GetPlayerSelectedHero(participant.player_id);
        heroImage.SetImage(`file://{images}/heroes/icons/${heroName}.png`);
        const amount = $.CreatePanel("Panel", row, "");
        amount.AddClass("RouletteParticipantAmount");
        const goldIcon = $.CreatePanel("Image", amount, "");
        goldIcon.AddClass("RouletteParticipantGoldIcon");
        goldIcon.SetImage(ROULETTE_COIN_ICON);
        const goldValue = $.CreatePanel("Label", amount, "");
        goldValue.AddClass("RouletteParticipantGoldValue");
        goldValue.text = `${participant.amount}`;
        const sector = $.CreatePanel("Panel", row, "");
        sector.AddClass("RouletteParticipantSector");
        sector.AddClass(`Mult${participant.multiplier}`);
        const sectorLabel = $.CreatePanel("Label", sector, "");
        sectorLabel.text = `x${participant.multiplier}`;
    }
}
function renderHistory() {
    const container = roulettePanel("RouletteHistory");
    if (!container) {
        return;
    }
    container.RemoveAndDeleteChildren();
    const history = rouletteToArray(currentState === null || currentState === void 0 ? void 0 : currentState.history).slice(0, 20);
    if (history.length === 0) {
        const empty = $.CreatePanel("Label", container, "");
        empty.text = $.Localize("#HUD_Roulette_no_rolls");
        empty.AddClass("RouletteParticipantBet");
        return;
    }
    for (const entry of history) {
        const item = $.CreatePanel("Panel", container, "");
        item.AddClass("RouletteHistoryItem");
        item.AddClass(`Mult${entry.multiplier}`);
        const label = $.CreatePanel("Label", item, "");
        label.text = `x${entry.multiplier}`;
    }
}
function renderState() {
    updateRouletteUnavailableBanner();
    updateRouletteCoins();
    updateTimer();
    renderParticipants();
    if (!spinVisualActive) {
        renderHistory();
    }
    updateBetButton();
    updateMultiplierButtons();
}
function easeInQuad(progress) {
    return progress * progress;
}
function easeOutCubic(progress) {
    const inverse = 1 - progress;
    return 1 - inverse * inverse * inverse;
}
function spinWheelToSector(sector, sectorCount, duration) {
    const wheel = roulettePanel("RouletteWheel");
    if (!wheel) {
        return;
    }
    const wheelPanel = wheel;
    spinAnimationId += 1;
    const animationId = spinAnimationId;
    const sectorDegrees = 360 / sectorCount;
    const sectorCenter = sector * sectorDegrees;
    const sectorSafePoint = sectorCenter;
    const startRotation = currentRotation;
    const accelDistance = SPIN_ACCEL_TURNS * 360;
    const cruiseDistance = SPIN_CRUISE_TURNS * 360;
    const decelStartRotation = startRotation + accelDistance + cruiseDistance;
    const targetRotation = (360 - sectorSafePoint) % 360;
    const decelStartRotationMod = ((decelStartRotation % 360) + 360) % 360;
    const deltaToTarget = (targetRotation - decelStartRotationMod + 360) % 360;
    const decelDistance = SPIN_DECEL_TURNS * 360 + deltaToTarget;
    const totalDecelDuration = Math.max(2.5, duration - SPIN_ACCEL_DURATION - SPIN_CRUISE_DURATION);
    const totalDuration = SPIN_ACCEL_DURATION + SPIN_CRUISE_DURATION + totalDecelDuration;
    const startTime = Date.now();
    wheelPanel.style.transitionProperty = "none";
    wheelPanel.style.transitionDuration = "0s";
    function setRotation(rotation) {
        currentRotation = rotation;
        wheelPanel.style.transform = `rotateZ(${currentRotation}deg)`;
    }
    function animateFrame() {
        if (animationId !== spinAnimationId) {
            return;
        }
        const elapsed = (Date.now() - startTime) / 1000;
        let nextRotation = startRotation;
        if (elapsed <= SPIN_ACCEL_DURATION) {
            const progress = Math.max(0, Math.min(1, elapsed / SPIN_ACCEL_DURATION));
            nextRotation = startRotation + accelDistance * easeInQuad(progress);
        }
        else if (elapsed <= SPIN_ACCEL_DURATION + SPIN_CRUISE_DURATION) {
            const cruiseElapsed = elapsed - SPIN_ACCEL_DURATION;
            const progress = Math.max(0, Math.min(1, cruiseElapsed / SPIN_CRUISE_DURATION));
            nextRotation = startRotation + accelDistance + cruiseDistance * progress;
        }
        else {
            const decelElapsed = elapsed - SPIN_ACCEL_DURATION - SPIN_CRUISE_DURATION;
            const progress = Math.max(0, Math.min(1, decelElapsed / totalDecelDuration));
            nextRotation = decelStartRotation + decelDistance * easeOutCubic(progress);
        }
        setRotation(nextRotation);
        if (elapsed < totalDuration) {
            $.Schedule(SPIN_FRAME_INTERVAL, animateFrame);
            return;
        }
        setRotation(decelStartRotation + decelDistance);
    }
    animateFrame();
}
GameUI.SelectRouletteMultiplier = (multiplier) => {
    if (!isRouletteBettingAvailableForLocalPlayer() || (currentState === null || currentState === void 0 ? void 0 : currentState.phase) !== "betting" || hasLocalPlayerJoined() || ROULETTE_MULTIPLIERS.indexOf(multiplier) === -1) {
        return;
    }
    selectedMultiplier = multiplier;
    updateMultiplierButtons();
};
GameUI.AdjustRouletteBet = (action) => {
    const amount = getBetAmount();
    if (!isRouletteBettingAvailableForLocalPlayer()) {
        updateBetButton();
        return;
    }
    if (action === "add100") {
        setBetAmount(amount + 100);
    }
    else if (action === "sub100") {
        setBetAmount(amount - 100);
    }
    else if (action === "double") {
        setBetAmount(amount * 2);
    }
    else if (action === "half") {
        setBetAmount(amount / 2);
    }
    updateBetButton();
};
GameUI.OnRouletteBetAmountChanged = () => {
    clampBetAmountToCoins();
    updateBetButton();
};
GameUI.MakeRouletteBet = () => {
    if (!isRouletteBettingAvailableForLocalPlayer() || (currentState === null || currentState === void 0 ? void 0 : currentState.phase) !== "betting" || hasLocalPlayerJoined()) {
        return;
    }
    const amount = clampBetAmountToCoins();
    if (amount <= 0) {
        updateBetButton();
        return;
    }
    GameEvents.SendCustomGameEventToServer("roulette_make_bet", {
        PlayerID: Players.GetLocalPlayer(),
        amount,
        multiplier: selectedMultiplier,
    });
};
function onRouletteStateChanged(state) {
    currentState = state;
    isSpinning = (state === null || state === void 0 ? void 0 : state.phase) === "spinning";
    renderState();
}
function onRouletteSpinStarted(event) {
    if (!isRouletteBettingAvailableForLocalPlayer()) {
        spinVisualActive = false;
        isSpinning = false;
        activeSpinRoundId = undefined;
        pendingSpinFinish = undefined;
        updateRouletteUnavailableBanner();
        return;
    }
    isSpinning = true;
    spinVisualActive = true;
    activeSpinRoundId = event.round_id;
    pendingSpinFinish = undefined;
    currentState = Object.assign(Object.assign({}, (currentState !== null && currentState !== void 0 ? currentState : { round_id: event.round_id, participants: [] })), { phase: "spinning", time_remaining: 0 });
    renderState();
    setResultText("");
    spinWheelToSector(event.sector, event.sector_count || DEFAULT_SECTOR_COUNT, event.spin_duration || 8.5);
    $.Schedule((event.spin_duration || 8.5) + 0.1, () => {
        if (activeSpinRoundId !== event.round_id) {
            return;
        }
        spinVisualActive = false;
        setResultText(`x${event.multiplier}`);
        if (pendingSpinFinish && pendingSpinFinish.round_id === event.round_id) {
            showSpinFinished(pendingSpinFinish);
        }
        else {
            renderHistory();
        }
    });
}
function showSpinFinished(event) {
    pendingSpinFinish = undefined;
    setResultText(`x${event.multiplier}`);
    renderHistory();
    const localPlayerId = Players.GetLocalPlayer();
    const localResult = rouletteToArray(event.results).find((result) => result.player_id === localPlayerId);
    if (!localResult) {
        return;
    }
    $.Msg(`[Roulette] ${localResult.win === 1 ? `Win +${localResult.payout}` : "Lost"} on x${event.multiplier}`);
}
function onRouletteSpinFinished(event) {
    if (!isRouletteBettingAvailableForLocalPlayer()) {
        spinVisualActive = false;
        isSpinning = false;
        activeSpinRoundId = undefined;
        pendingSpinFinish = undefined;
        updateRouletteUnavailableBanner();
        return;
    }
    if (spinVisualActive && activeSpinRoundId === event.round_id) {
        pendingSpinFinish = event;
        return;
    }
    showSpinFinished(event);
}
GameEvents.Subscribe("roulette_spin_started", onRouletteSpinStarted);
GameEvents.Subscribe("roulette_spin_finished", onRouletteSpinFinished);
CustomNetTables.SubscribeNetTableListener("roulette", (_, key, value) => {
    if (key === "state") {
        onRouletteStateChanged(value);
    }
});
CustomNetTables.SubscribeNetTableListener("player_info_shop", (_, key) => {
    if (key !== String(Players.GetLocalPlayer())) {
        return;
    }
    clampBetAmountToCoins();
    updateRouletteUnavailableBanner();
    updateRouletteCoins();
    updateTimer();
    updateBetButton();
    updateMultiplierButtons();
});
onRouletteStateChanged(CustomNetTables.GetTableValue("roulette", "state"));