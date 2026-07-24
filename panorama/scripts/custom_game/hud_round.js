--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


"use strict";
(() => {
    const root = $.GetContextPanel();
    const localPlayer = Players.GetLocalPlayer();
    let roundName = "";
    let roundNumber = "1";
    let roundTime = 100;
    let roundTotalTime = 100;
    let roundCount = 0;
    let roundTotalCount = 0;
    let roundAbilityList = "";
    let roundShowReady = false;
    let roundShowInfo = false;
    function findPanel(id) {
        const panel = root.FindChildTraverse(id);
        if (panel == null) {
            throw new Error(`Panel ${id} not found`);
        }
        return panel;
    }
    function getHud() {
        let panel = root;
        while (panel && panel.id !== "Hud") {
            panel = panel.GetParent();
        }
        return panel;
    }
    function attachAbilityTooltip(panel, abilityName) {
        panel.SetPanelEvent("onmouseover", () => {
            $.DispatchEvent("DOTAShowAbilityTooltip", panel, abilityName);
        });
        panel.SetPanelEvent("onmouseout", () => {
            $.DispatchEvent("DOTAHideAbilityTooltip", panel);
        });
    }
    function applyShopHudTweaks() {
        const hud = getHud();
        if (!hud) {
            return;
        }
        const shop = hud.FindChildTraverse("shop");
        if (shop) {
            const main = shop.FindChildTraverse("Main");
            if (main) {
                main.style.width = "430px";
            }
            const guideFlyout = shop.FindChildTraverse("GuideFlyout");
            if (guideFlyout) {
                guideFlyout.style.visibility = "collapse";
            }
            const gridNeutralItems = shop.FindChildTraverse("GridNeutralsCategory");
            if (gridNeutralItems) {
                gridNeutralItems.style.overflow = "squish scroll";
                const tiers = gridNeutralItems.FindChildrenWithClassTraverse("NeutralItemsTier");
                for (const tier of tiers) {
                    tier.style.minWidth = "310px";
                }
            }
            const gridBasicItemsCategory = shop.FindChildTraverse("GridBasicItemsCategory");
            if (gridBasicItemsCategory) {
                gridBasicItemsCategory.style.overflow = "squish scroll";
            }
            const gridUpgradesItemsCategory = shop.FindChildTraverse("GridUpgradesCategory");
            if (gridUpgradesItemsCategory) {
                gridUpgradesItemsCategory.style.overflow = "squish scroll";
            }
        }
        const toastManager = hud.FindChildTraverse("ToastManager");
        if (toastManager) {
            toastManager.style.visibility = "collapse";
        }
    }
    function scheduleClientLogin() {
        const sendLogin = () => {
            const playerInfo = Game.GetLocalPlayerInfo();
            if (!(playerInfo === null || playerInfo === void 0 ? void 0 : playerInfo.player_steamid)) {
                $.Schedule(0.5, sendLogin);
                return;
            }
            const steamId32 = String(Number(playerInfo.player_steamid.substr(3)) - 61197960265728);
            let uniqueKey = String(Math.floor(Date.now() / 1000));
            uniqueKey += steamId32.slice(0, 4);
            let language = $.Language().toLowerCase();
            if (language !== "schinese" && language !== "english" && language !== "russian") {
                language = "other";
            }
            uniqueKey += `|${language}`;
            GameEvents.SendEventClientSide("client_player_login", {
                uid: steamId32,
                sid: playerInfo.player_steamid,
                key: uniqueKey,
            });
            GameEvents.SendCustomEventToServer("client_player_login", {
                uid: steamId32,
                sid: playerInfo.player_steamid,
                key: uniqueKey,
            });
        };
        sendLogin();
    }
    function bindErrorMessages() {
        GameEvents.Subscribe("SendCustomErrorMessage", (params) => {
            if (!params.msg) {
                return;
            }
            const errorMessage = globalThis.ErrorMessage;
            errorMessage === null || errorMessage === void 0 ? void 0 : errorMessage(`#${params.msg}`, "General.InvalidTarget_Invulnerable");
        });
    }
    function createButtonLabel(parent, text) {
        const label = $.CreatePanel("Label", parent, "");
        label.text = text;
        return label;
    }
    function updateRoundInfoPanel() {
        const roundInfo = findPanel("RoundInfo");
        const roundNumberLabel = findPanel("RoundNumberLabel");
        const roundNameLabel = findPanel("RoundName");
        const readyGrid = findPanel("ReadyGrid");
        const remainingLabel = findPanel("RoundRemainingTime");
        const expireLabel = findPanel("RoundExpireTime");
        const abilityList = findPanel("RoundAbilityList");
        const progressLeft = findPanel("RoundProgressLeft");
        const progressRight = findPanel("RoundProgressRight");
        const readyGridContent = findPanel("ReadyGridContent");
        const flip = Game.IsHUDFlipped();
        roundInfo.SetHasClass("Show", roundShowInfo);
        roundInfo.SetHasClass("Flip", flip);
        roundNumberLabel.text = roundNumber;
        roundNameLabel.text = $.Localize(roundName) + (roundTotalCount > 0 ? `(${roundCount}/${roundTotalCount})` : "");
        readyGrid.SetHasClass("Show", roundShowReady);
        readyGridContent.hittest = false;
        remainingLabel.SetHasClass("Show", roundTime >= 0);
        expireLabel.SetHasClass("Show", roundTime < 0);
        const seconds = Math.floor(Math.abs(roundTime) % 60);
        const minutes = Math.floor(Math.abs(roundTime) / 60);
        remainingLabel.text = `${minutes}:${seconds >= 10 ? seconds : `0${seconds}`}`;
        expireLabel.text = `${$.Localize("#Hud_Round_berserk")}: ${Math.max(0, -roundTime)}`;
        const max = Math.max(1, roundTotalTime);
        const value = Math.min(Math.max(roundTime, 0), max);
        const percent = (value / max) * 100;
        progressLeft.style.width = `${percent}%`;
        progressRight.style.width = `${100 - percent}%`;
        abilityList.RemoveAndDeleteChildren();
        for (const abilityName of roundAbilityList.split(",")) {
            if (abilityName === "") {
                continue;
            }
            const image = $.CreatePanel("DOTAAbilityImage", abilityList, "");
            image.abilityname = abilityName;
            attachAbilityTooltip(image, abilityName);
        }
    }
    function bindRoundInfo() {
        const applyQuestEvent = (event, resetProgress) => {
            if (event.name === "RoundPrepare") {
                if (event.text_value != null) {
                    roundNumber = String(event.text_value);
                }
                if (event.text_value_2 != null) {
                    roundName = event.text_value_2;
                }
                if (event.svalue != null && event.evalue != null) {
                    roundTime = event.evalue - event.svalue;
                }
                if (event.evalue != null) {
                    roundTotalTime = event.evalue;
                }
                if (event.tAbilityList != null) {
                    roundAbilityList = event.tAbilityList;
                }
                if (resetProgress) {
                    roundCount = 0;
                    roundTotalCount = 0;
                }
                roundShowInfo = true;
            }
            if (event.name === "RoundTimeLimit") {
                if (event.svalue != null) {
                    roundTime = event.svalue;
                }
                if (event.evalue != null) {
                    roundTotalTime = event.evalue;
                }
            }
            if (event.name === "RoundProgress") {
                if (event.svalue != null) {
                    roundCount = event.svalue;
                }
                if (event.evalue != null) {
                    roundTotalCount = event.evalue;
                }
            }
            updateRoundInfoPanel();
        };
        GameEvents.Subscribe("CreateQuest", (event) => applyQuestEvent(event, true));
        GameEvents.Subscribe("RefreshQuest", (event) => applyQuestEvent(event, false));
        GameEvents.Subscribe("UpdateReadyButton", (event) => {
            roundShowReady = !Players.IsSpectator(localPlayer) && !!event.visible;
            updateRoundInfoPanel();
        });
        GameEvents.Subscribe("EndQuest", () => {
            roundShowInfo = false;
            updateRoundInfoPanel();
        });
    }
    function bindReadyButton() {
        const readyGrid = findPanel("ReadyGrid");
        readyGrid.SetPanelEvent("onactivate", () => {
            GameEvents.SendCustomGameEventToServer("PlayerReady", {
                PlayerID: localPlayer,
            });
        });
    }
    function keepKezClassesDisabled() {
        const tick = () => {
            const hud = getHud();
            const lowerHud = hud === null || hud === void 0 ? void 0 : hud.FindChildTraverse("lower_hud");
            if (lowerHud) {
                lowerHud.SetHasClass("IsKez", false);
                lowerHud.SetHasClass("KezSaiMode", false);
            }
            $.Schedule(0, tick);
        };
        tick();
    }
    function updateMiniMapFlip() {
        const minimap = findPanel("MiniMap");
        minimap.SetHasClass("Flip", Game.IsHUDFlipped());
        $.Schedule(1, updateMiniMapFlip);
    }
    function initButtons() {
        createButtonLabel(findPanel("ReadyGridContent"), $.Localize("#Ready"));
    }
    function init() {
        applyShopHudTweaks();
        initButtons();
        bindErrorMessages();
        bindRoundInfo();
        bindReadyButton();
        scheduleClientLogin();
        keepKezClassesDisabled();
        updateMiniMapFlip();
        updateRoundInfoPanel();
    }
    init();
})();