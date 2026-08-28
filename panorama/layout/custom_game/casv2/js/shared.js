--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


(function() {
    "use strict";
    // Общее состояние казино: FSM (idle→anticipation→spinning→result), валюта, ставка, данные с сервера.
    var FSM_STATE = {
        IDLE: "idle",
        ANTICIPATION: "anticipation",
        SPINNING: "spinning",
        RESULT: "result",
        PAUSED: "paused"
    };

    var FSM_TRANSITIONS = {
        "idle": ["anticipation", "paused"],
        "anticipation": ["spinning", "paused"],
        "spinning": ["result", "paused"],
        "result": ["idle", "anticipation", "paused"],
        "paused": ["idle", "result", "spinning"]
    };

    var state = {
        initialized: false,
        fsmState: FSM_STATE.IDLE,
        spinTimeoutId: null,
        slotCardIds: ["SlotCard1", "SlotCard2", "SlotCard3"],
        selectedSpeed: 1,
        autospinMode: "off",
        autospinRemaining: 0,
        autospinPaused: false,
        selectedCurrency: "shield",
        selectedBet: 10,
        selectedBetShield: 10,
        selectedBetCrystal: 1,
        loadingPanelId: null,
        slotsLoadingPanelId: null,
        serverNowDate: null,
        serverNowClientMs: 0,
        historyLastId: null,
        historyHasMore: false,
        isLoadingHistory: false,
        isDataReady: false,
        isLoading: false,
        casinoOpenPending: false,
        casinoMainPanel: null,
        casinoDataReady: false,
        casinoData: { inventory: [], claimed_history: [], sold_history: [], sold_totals: { ruby: 0, shield: 0 }, inventory_sell_totals: { ruby: 0, shield: 0 }, jackpot_history: [] },
        pendingSellIds: [],
        pendingClaimIds: [],
        inventoryLoadMorePending: false,
        lastSellClickTime: 0,
        lastClaimClickTime: 0,
        inventoryTotalCount: null,
        claimedTotalCount: null,
        soldTotalCount: null,
        jackpotTotalCount: null,
        inventoryHasMore: false,
        claimedHasMore: false,
        soldHasMore: false,
        inventoryActiveTab: "items",
        lastSpinIsWin: false,
        lastSpinIsJackpot: false,
        lastWinValue: null,
        lastWinCurrency: null,
        playButtonDebounce: false,
        skipEnabled: false,
        fsmStateBeforePause: null,
        lastCasinoDataRequestKey: null,
        casinoLeftLoadingPanelId: null,
        casinoRightLoadingPanelId: null
    };

    function canTransition(fromState, toState) {
        var allowed = FSM_TRANSITIONS[fromState];
        return allowed && allowed.indexOf(toState) !== -1;
    }

    function transitionTo(newState, reason) {
        var currentState = state.fsmState;
        if (!canTransition(currentState, newState)) return false;
        state.fsmState = newState;
        return true;
    }

    function getIsSpinning() {
        return state.fsmState === FSM_STATE.ANTICIPATION || state.fsmState === FSM_STATE.SPINNING;
    }

    function getPluralForm(count, formOne, formFew, formMany) {
        var n = Math.abs(count) % 100;
        var digit = n % 10;
        if (n > 10 && n < 20) return formMany;
        if (digit === 1) return formOne;
        if (digit >= 2 && digit <= 4) return formFew;
        return formMany;
    }

    function parseIsoDate(isoString) {
        if (!isoString || typeof isoString !== "string") return null;
        var normalized = isoString.trim().replace(/(\.\d{3})\d+/, "$1").replace(/\+00:00$/, "Z");
        var date = new Date(normalized);
        return isNaN(date.getTime()) ? null : date;
    }

    function getNowForHistory() {
        if (state.serverNowDate) {
            var deltaMs = Math.max(0, (new Date()).getTime() - state.serverNowClientMs);
            return new Date(state.serverNowDate.getTime() + deltaMs);
        }
        return new Date();
    }

    function formatNumber(num) {
        if (num == null) return "0";
        return String(num).replace(/\B(?=(\d{3})+(?!\d))/g, " ");
    }

    function formatTimeAgo(isoString) {
        var date = parseIsoDate(isoString);
        if (!date) return "\u2014";
        var diffMs = Math.max(0, getNowForHistory() - date);
        var s = Math.floor(diffMs / 1000), m = Math.floor(s / 60), h = Math.floor(m / 60), d = Math.floor(h / 24);
        if (s < 60) return $.Localize("#ui_casv2_just_now");
        if (m < 60) return m + " " + getPluralForm(m, $.Localize("#ui_casv2_minute_one"), $.Localize("#ui_casv2_minute_few"), $.Localize("#ui_casv2_minute_many")) + " " + $.Localize("#ui_casv2_ago");
        if (h < 24) return h + " " + getPluralForm(h, $.Localize("#ui_casv2_hour_one"), $.Localize("#ui_casv2_hour_few"), $.Localize("#ui_casv2_hour_many")) + " " + $.Localize("#ui_casv2_ago");
        return d + " " + getPluralForm(d, $.Localize("#ui_casv2_day_one"), $.Localize("#ui_casv2_day_few"), $.Localize("#ui_casv2_day_many")) + " " + $.Localize("#ui_casv2_ago");
    }

    function normalizeToArray(val) {
        if (val == null) return [];
        if (Array.isArray(val)) return val;
        if (typeof val === "object") return Object.keys(val).map(function(k) { return val[k]; });
        return [];
    }

    var Casv2Shared = {
        state: state,
        FSM_STATE: FSM_STATE,
        transitionTo: transitionTo,
        getIsSpinning: getIsSpinning,
        parseIsoDate: parseIsoDate,
        getNowForHistory: getNowForHistory,
        formatNumber: formatNumber,
        formatTimeAgo: formatTimeAgo,
        normalizeToArray: normalizeToArray
    };

    if (!GameUI.CustomUIConfig().Casv2Shared) GameUI.CustomUIConfig().Casv2Shared = Casv2Shared;
})();