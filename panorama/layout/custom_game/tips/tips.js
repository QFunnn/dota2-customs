--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const DOTA_HUD_ROOT = $.GetContextPanel().GetParent().GetParent().GetParent()
const CONTEXT = $.GetContextPanel()
const quickSelectTipMenu = $("#QuickSelectTipMenu")
quickSelectTipMenu.visible = false

const topBarPlayersContainer = DOTA_HUD_ROOT.FindChildTraverse("TopBarRadiantPlayersContainer")
const localPlayerId = Players.GetLocalPlayer()
const localPlayerIdStr = String(localPlayerId)

let activeTip = CustomNetTables.GetTableValue( "active_player_tip", localPlayerIdStr)

const boughtTips = [
	// "ahjahja",
	// "cat_ahaha",
	// "facepalm",
	// "fotkayu",
	// "kekw",
	// "markaryan",
	// "okak",
	// "pepe_clown",
	// "peter_griffin",
	// "skebob",
	// "vodonos",
	// "vodonos_2",
]

function handleBoughtTips(data) {
	const tipsData = data[9]
	if (!tipsData) return

	boughtTips.splice(0, boughtTips.length)

	for (const tipNum in tipsData) {
		if (tipNum === "name") continue

		const tipItem = tipsData[tipNum]		
		if (tipItem.status === "buy") continue

		boughtTips.push(tipItem.tip)
	}

	if (quickSelectTipMenu.actuallayoutwidth === 0) {
		quickSelectTipMenu.visible = true
		quickSelectTipMenu.style.opacity = 0.01
		$.Schedule(1, () => {
			quickSelectTipMenu.visible = false
			quickSelectTipMenu.style.opacity = 1
		})
	}

	fillQuickSelectTipMenu()
}

function getTopBarPlayerContainers() {
	const topBarPlayerContainers = topBarPlayersContainer.GetChildCount()
	const topBarRealPlayerContainers = []
	
	for (let i = 0; i < topBarPlayerContainers; i++) {
		const playerContainer = topBarPlayersContainer.GetChild(i)

		const playerId = playerContainer?.id?.match(/[^-](\d+)/)?.[1]

		if (!playerId)
			continue

		topBarRealPlayerContainers.push({
			playerId: parseInt(playerId),
			container: playerContainer,
		})
	}

	return topBarRealPlayerContainers
}

function destroyOldTipButtons() {
	for (const playerContainerData of getTopBarPlayerContainers()) {
		const oldTipButton = playerContainerData.container.FindChildTraverse("PlayerTipButton");

		if (!oldTipButton?.IsValid())
			continue
		
		oldTipButton.DeleteAsync(0);
	}
}

const tipButtons = {}
let playersCount = 0

function initTipButtons() {
	const topBarPlayerContainers = getTopBarPlayerContainers()
	
	playersCount = topBarPlayerContainers.length

	for (const playerContainerData of topBarPlayerContainers) {
		const playerContainer = playerContainerData.container

		const tpIndicator = playerContainer.FindChildTraverse("TPIndicator")
		if (tpIndicator)
			tpIndicator.style.marginTop = "90px"

		const oldTipButton = playerContainer.FindChildTraverse("PlayerTipButton");

		if (oldTipButton?.IsValid())
			oldTipButton?.DeleteAsync(0);

		const playerId = playerContainerData.playerId

		if (playerId === localPlayerId)
			continue

		const tipButton = $.CreatePanel("Button", $("#TipsTempRoot"), "PlayerTipButton");
		tipButton.playerId = playerId
		tipButton.BLoadLayoutSnippet("PlayerTipButton");
		tipButton.SetPanelEvent("onmouseactivate", () => {
			if (tipButton.BHasClass("OnCooldown") || tipButton.BHasClass("NoActiveTip"))
				return

			GameEvents.SendCustomGameEventToServer( "do_player_tip", {targetId: playerId});
		})
		tipButton.SetPanelEvent("oncontextmenu", () => {
			if (boughtTips.length === 0) return

			openQuickSelectTipMenu(tipButton)
		})
		tipButton.SetHasClass("NoActiveTip", !activeTip)

		tipButton.SetParent(playerContainer)

		tipButtons[playerId] = tipButton
	}
}

function openQuickSelectTipMenu(tipButton) {
	quickSelectTipMenu.parentTipButton = tipButton
	recomposeQuickSelectTipMenu(true)
}

function recomposeQuickSelectTipMenu(makeVisible) {
	const tipButton = quickSelectTipMenu.parentTipButton
	if (!tipButton?.IsValid())
		return
	
	const tipButtonPos = tipButton.GetPositionWithinWindow();

	const x = tipButtonPos.x
	const y = tipButtonPos.y + tipButton.actuallayoutheight

	quickSelectTipMenu.style.marginLeft = `${Math.floor(x + (tipButton.actuallayoutwidth - quickSelectTipMenu.actuallayoutwidth) / 2)}px`
	quickSelectTipMenu.style.marginTop = `${Math.floor(y + 10)}px`

	if (makeVisible)
		quickSelectTipMenu.visible = true
}

function fillQuickSelectTipMenu() {
	quickSelectTipMenu.RemoveAndDeleteChildren()

	const quickSelectTipMenuInner = $.CreatePanel("Panel", quickSelectTipMenu, "QuickSelectTipMenuInner")

	for (const tip of boughtTips) {
		const selectTipButton = $.CreatePanel("Button", quickSelectTipMenuInner, "", {class: "SelectTipButton"})
		selectTipButton.SetPanelEvent("onmouseactivate", () => {
			const tipButton = quickSelectTipMenu.parentTipButton
			if (!tipButton?.IsValid() || tipButton.BHasClass("OnCooldown"))
				return

			GameEvents.SendCustomGameEventToServer( "do_player_tip", {targetId: tipButton.playerId, tip: tip});

			quickSelectTipMenu.visible = false
		})

		const selectTipButtonImage = $.CreatePanel("Image", selectTipButton, "")
        selectTipButtonImage.SetImage(`file://{images}/custom_game/tips/${tip}.png`);
	}
}

let nextTipTime = 0
let tipTextIsCooldown

const tipToastsContainer = $("#PlayerTipToastsContainer")

function setupToast(toastPanel, playerId, isSource) {
	const info = Game.GetPlayerInfo(playerId);

	const heroContainer = toastPanel.FindChildrenWithClassTraverse(isSource ? "SourceHeroContainer" : "TargetHeroContainer")[0];

	heroContainer.GetChild(0).SetImage(`file://{images}/heroes/${info.player_selected_hero}.png`)
	heroContainer.GetChild(1).text = info.player_name;
}

function successTip(data) {
	if (data.sourcePlayerId === localPlayerId) {
		nextTipTime = Game.GetGameTime() + data.cooldown
		handleTipCooldown()
	}

    Game.EmitSound(`Tips.${data.tip}`)

	const tipToast = $.CreatePanel("Panel", tipToastsContainer, "PlayerTipToastContainer");
    tipToast.BLoadLayoutSnippet("PlayerTipToast");

	setupToast(tipToast, data.sourcePlayerId, true);
	setupToast(tipToast, data.targetPlayerId, false);

	const tipImageContainer = tipToast.FindChildrenWithClassTraverse("TipTextContainer")[0];
	tipImageContainer.GetChild(0).SetImage(`file://{images}/custom_game/tips/${data.tip}.png`);

	tipToast.AddClass("IsVisisble");
	$.Schedule(5, () => {
		tipToast.RemoveClass("IsVisisble");
		tipToast.DeleteAsync(0.3);
	});
}

function handleTipCooldown() {
	const curTime = Game.GetGameTime()

	if (curTime > nextTipTime && !tipTextIsCooldown)
		return

	const reverseState = (nextTipTime - curTime) <= 1

	for (const playerId in tipButtons) {
		const tipButton = tipButtons[playerId]

		if (reverseState) {
			tipButton.FindChildrenWithClassTraverse('TipText')[0].text = "+++"
			tipButton.SetHasClass("OnCooldown", false)

			nextTipTime = 0
			tipTextIsCooldown = false
		} else {
			tipButton.FindChildrenWithClassTraverse('TipText')[0].text = String(Math.floor(nextTipTime - curTime))
			tipButton.SetHasClass("OnCooldown", true)

			tipTextIsCooldown = true
		}
	}
}

function updateTipButtons() {
	if (playersCount !== getTopBarPlayerContainers().length)
		initTipButtons()

	handleTipCooldown()

	$.Schedule(0.5, updateTipButtons)
}

function handleActiveTipChange() {
	for (const playerId in tipButtons) {
		const tipButton = tipButtons[playerId]
		
		tipButton.SetHasClass("NoActiveTip", !activeTip)
	}
}

function activeTipChanged(netTableName, key, value) {
    if (netTableName !== "active_player_tip") return
	if (key !== localPlayerIdStr) return
	if (!value || typeof value !== "object") return

	activeTip = value.tip

	handleActiveTipChange()
}

(function () {
	if (!topBarPlayersContainer)
		return $.Msg("[TIPS] TopBarRadiantPlayersContainer not found")

	destroyOldTipButtons()
	updateTipButtons()

	GameEvents.Subscribe("success_player_tip", successTip);
	GameEvents.Subscribe("initShop", handleBoughtTips)
	GameEvents.Subscribe("initShop2", handleBoughtTips)
	CustomNetTables.SubscribeNetTableListener("active_player_tip", activeTipChanged);

	GameUI.CustomUIConfig().DotaHUD.ListenToMouseEvent(function(eventType, arg) {
        if (quickSelectTipMenu && quickSelectTipMenu.visible && eventType === "pressed" && (arg === 0 || arg === 1)) {
			const cursorPos = GameUI.GetCursorPosition()
			const menuPos = quickSelectTipMenu.GetPositionWithinWindow()

			const width = quickSelectTipMenu.actuallayoutwidth
			const height = quickSelectTipMenu.actuallayoutheight

			if (cursorPos[0] < menuPos.x || menuPos.x + width < cursorPos[0] || cursorPos[1] < menuPos.y || cursorPos[1] < menuPos.y + height) {
				quickSelectTipMenu.visible = false
			}
		}

        return false;
    })
})();