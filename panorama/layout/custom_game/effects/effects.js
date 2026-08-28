--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


let can_use_spray = true;
let can_use_highfive = true;
const playerID = Players.GetLocalPlayer()
let localPlayerHeroId = Players.GetPlayerHeroEntityIndex(playerID)

function FindDotaHudElement(panel) {
	return $.GetContextPanel().GetParent().GetParent().GetParent().FindChildTraverse(panel);
}

function OnClickSpray(t) {
	$.Msg(t)
	if (t == "spray"){
		var spray = CustomNetTables.GetTableValue( "sprays", playerID);
		if (spray != null){
			if(can_use_spray) {
					GameEvents.SendCustomGameEventToServer( "CastSpray", {} )
					timer(15)	
				}
			can_use_spray = false
		}	
	}else{
		var spray = CustomNetTables.GetTableValue( "highfive", playerID);
		if (spray != null){
			if(can_use_highfive) {
					GameEvents.SendCustomGameEventToServer( "HighFive", {} )
					timer2(15)	
				}
			can_use_highfive = false
		}	
	}
}

function timer(i) {
	const pan = FindDotaHudElement("CustomAbility_spray_custom");
	text_timer = pan.FindChildTraverse("CosmeticAbility_text")
	if (i > 0) {
		text_timer.text = (i - 1)
	}
	if (i == 0) {
		text_timer.text = ""
		can_use_spray = true
		return
	}
	i--;
	$.Schedule(1, function () {
		timer(i)
	});
}

function timer2(i) {
	const pan = FindDotaHudElement("CustomAbility_highfive_custom");
	text_timer = pan.FindChildTraverse("CosmeticAbility_text")
	if (i > 0) {
		text_timer.text = (i - 1)
	}
	if (i == 0) {
		text_timer.text = ""
		can_use_highfive = true
		return
	}
	i--;
	$.Schedule(1, function () {
		timer2(i)
	});
}
//////////////////////////////////////////////////////////FIX HERO ICON////////////////////////////////////////////

function FixHeroIcons() {
	const topbar = $.GetContextPanel().GetParent().GetParent().GetParent().GetParent().FindChildTraverse("topbar")
	const playerSlots = topbar.FindChildrenWithClassTraverse("TopBarPlayerSlot")
	for (k in playerSlots) {
		const img = playerSlots[k].FindChildTraverse("HeroImage")
		if (img.heroname.length != 0) {
			if (img.heroname == 'anakim' || img.heroname == 'dado' || img.heroname == 'triss' || img.heroname == 'destroyer') {
				img.SetImage("file://{images}/custom_game/heroes/npc_dota_hero_" + img.heroname + ".png")
			}
		}
	}



	$.Schedule(0.1, FixHeroIcons)
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

let EXTRA_ABILITIES_PANEL

const extraAbilitiesInfoList = []

let extraSpellsIsHidden = false

function updateExtraSpells() {
	if (Players.GetLocalPlayerPortraitUnit() !== localPlayerHeroId) {
		if (!extraSpellsIsHidden) {
			if (EXTRA_ABILITIES_PANEL && EXTRA_ABILITIES_PANEL.IsValid())
				EXTRA_ABILITIES_PANEL.visible = false
			extraSpellsIsHidden = true
		}
		$.Schedule(0.1, () => {
			updateExtraSpells()
		})
		return
	} else {
		if (extraSpellsIsHidden) {
			if (EXTRA_ABILITIES_PANEL && EXTRA_ABILITIES_PANEL.IsValid())
				EXTRA_ABILITIES_PANEL.visible = true
			extraSpellsIsHidden = false
		}
	}

	const hasAbilityPoint = Entities.GetAbilityPoints(localPlayerHeroId) > 0

	for (const extraAbilityInfoIndex in extraAbilitiesInfoList) {
		const extraAbilityInfo = extraAbilitiesInfoList[extraAbilityInfoIndex]

		const { container, imagePanel, keybind, keybindLabel, cooldownLabel, shifted } = extraAbilityInfo

		const cooldownTime = Abilities.GetCooldownTime(extraAbilityInfo.ability)

		if (cooldownTime > 0) {
			if (!imagePanel.BHasClass("OnCooldown")) {
				imagePanel.SetHasClass("Ready", false)
				imagePanel.SetHasClass("OnCooldown", true)
			}
			cooldownLabel.text = Math.ceil(cooldownTime)
		} else if (!imagePanel.BHasClass("Ready")) {
			imagePanel.SetHasClass("Ready", true)
			imagePanel.SetHasClass("OnCooldown", false)
			cooldownLabel.text = ""
		}

		if (hasAbilityPoint) {
			const ability = Entities.GetAbility(localPlayerHeroId, +extraAbilityInfoIndex)

			if (ability > 0 && Abilities.CanAbilityBeUpgraded(ability) === 0) {
				if (!shifted) {
					container.style.marginBottom = "31px"
					extraAbilityInfo.shifted = true
				}
			} else {
				container.style.marginBottom = "0px"
				extraAbilityInfo.shifted = false
			}
		} else {
			if (shifted) {
				container.style.marginBottom = "0px"
				extraAbilityInfo.shifted = false
			}
		}

		if (keybind && keybindLabel) {
			const keybindCommand = Game.GetKeybindForCommand(keybind)
			if (keybindCommand) {
				const newKeybindCommandStr = String(keybindCommand).toUpperCase()
				if (keybindLabel.text !== newKeybindCommandStr && extraAbilityInfo.registerKeyBind)
					extraAbilityInfo.registerKeyBind()

				keybindLabel.text = String(keybindCommand).toUpperCase()

				if (container.hasTooltipEvents) {
					container.ClearPanelEvent("onmouseover")
					container.ClearPanelEvent("onmouseout")
					
					container.hasTooltipEvents = false
				}
			} else {
				keybindLabel.text = ""

				if (!container.hasTooltipEvents) {
					container.SetPanelEvent("onmouseover", () => {
						$.DispatchEvent("DOTAShowTitleTextTooltip", container, $.Localize(`#hint_for_${keybind}_keybind_title`), $.Localize(`#hint_for_${keybind}_keybind_text`))
					})
					container.SetPanelEvent("onmouseout", () => {
						$.DispatchEvent("DOTAHideTitleTextTooltip")
					})
					
					container.hasTooltipEvents = true
				}
			}
		}
	}

	$.Schedule(0.1, () => {
		updateExtraSpells()
	})
}

const extraAbilitiesPanelInfo = [
	{
		abilityName: "new_year_snowball",
		id: "SnowballAbility",
		imageSrc: "file://{images}/spellicons/consumables/frostivus2018_throw_snowball.png",
		keybind: DOTAKeybindCommand_t.DOTA_KEYBIND_CONTROL_GROUP5,
		quickCastCheckbox: true,
		onClick: (snowballAbility) => {
			Abilities.ExecuteAbility(snowballAbility, localPlayerHeroId, false)
		},
	}
]

function setupExtraSpellPanel() {
	const AbilitiesAndStatBranch = FindDotaHudElement("AbilitiesAndStatBranch")

	const oldExtraSpells = AbilitiesAndStatBranch.FindChildTraverse("ExtraSpells")
	if (oldExtraSpells)
		oldExtraSpells.DeleteAsync(0)

	const extraAbilitiesPanel = $.CreatePanel("Panel", $.GetContextPanel(), "ExtraSpells")
	extraAbilitiesPanel.hittest = false

	for (const extraAbilityPanelInfoIndex in extraAbilitiesPanelInfo) {
		const extraAbilityPanelInfo = extraAbilitiesPanelInfo[extraAbilityPanelInfoIndex]
		const ability = Entities.GetAbilityByName(localPlayerHeroId, extraAbilityPanelInfo.abilityName)

		if (ability !== -1) {
			const extraAbilityPanel = $.CreatePanel("Panel", extraAbilitiesPanel, extraAbilityPanelInfo.id, {})
			extraAbilityPanel.BLoadLayoutSnippet("ExtraAbility")
			extraAbilityPanel
				.FindChildrenWithClassTraverse("ExtraAbilityImage")[0]
				.SetImage(extraAbilityPanelInfo.imageSrc)
			extraAbilityPanel
				.FindChildrenWithClassTraverse("ExtraAbilityButton")[0]
				.SetPanelEvent("onactivate", () => {
					extraAbilityPanelInfo.onClick(ability)
				})
			
			let registerKeyBind
			if (extraAbilityPanelInfo.keybind) {
				let quickCastToggleButton
				if (extraAbilityPanelInfo.quickCastCheckbox) {
					quickCastToggleButton = extraAbilityPanel.FindChildrenWithClassTraverse("ExtraAbilityQuickCast")[0]
					quickCastToggleButton.SetSelected(true)

					const quickCastTickBox = quickCastToggleButton.FindChildrenWithClassTraverse("TickBox")[0]
					quickCastTickBox.style.width = "13px"
					quickCastTickBox.style.height = "13px"
					quickCastTickBox.style.border = "2px solid #000000"
					quickCastTickBox.style.boxShadow = "#000 0 0 0 0"

					quickCastToggleButton.SetPanelEvent("onmouseover", () => {
						$.DispatchEvent("DOTAShowTextTooltip", quickCastToggleButton, $.Localize("#dota_settings_enable_quickcast"))
					})
					quickCastToggleButton.SetPanelEvent("onmouseout", () => {
						$.DispatchEvent("DOTAHideTextTooltip")
					})
				} else {
					extraAbilityPanel.FindChildrenWithClassTraverse("ExtraAbilityQuickCast")[0].visible = false
				}

				registerKeyBind = () => {
					$.Msg("registerKeyBind")
					const commandName = `BSA_CastExtraAbility${extraAbilityPanelInfoIndex}_${Math.floor(Math.random() * 1000000000)}`
					Game.AddCommand(commandName, () => {
						const withQuickCast = quickCastToggleButton && quickCastToggleButton.checked

						executeAbility(ability, localPlayerHeroId, withQuickCast)
					}, "", 0)
					Game.CreateCustomKeyBind(Game.GetKeybindForCommand(extraAbilityPanelInfo.keybind), commandName)
				}
			}

			extraAbilitiesInfoList.push({
				ability: ability,
				container: extraAbilityPanel,
				imagePanel: extraAbilityPanel.FindChildrenWithClassTraverse("ExtraAbilityImage")[0],
				registerKeyBind,
				keybind: extraAbilityPanelInfo.keybind,
				keybindLabel: extraAbilityPanelInfo.keybind ? extraAbilityPanel.FindChildrenWithClassTraverse("ExtraAbilityKeybindLabel")[0] : undefined,
				cooldownLabel: extraAbilityPanel.FindChildrenWithClassTraverse("ExtraAbilityCooldownLabel")[0],
				shifted: false,
			})
		}
	}

	extraAbilitiesPanel.SetParent(FindDotaHudElement("AbilitiesAndStatBranch"))

	$.Schedule(0, () => {
		EXTRA_ABILITIES_PANEL = FindDotaHudElement("AbilitiesAndStatBranch").FindChildTraverse("ExtraSpells")

		for (const extraAbilityInfoIndexStr in extraAbilitiesInfoList) {
			const extraAbilityInfoIndex = +extraAbilityInfoIndexStr
			extraAbilitiesInfoList[extraAbilityInfoIndex].button = EXTRA_ABILITIES_PANEL.GetChild(extraAbilityInfoIndex)
		}

		updateExtraSpells()
	})
}

function hasBits(n1, n2) {
	return (n1 & n2) == n2
}

function getEntityUnderCursorPos(pos) {
	const ents = GameUI.FindScreenEntities(pos)
	for (const ent of ents) {
		if (!ent.accurateCollision)
			continue

		return ent.entityIndex
	}

	return (ents && ents[0]) ? ents[0].entityIndex : -1
}

function executeAbility(ability, unit, withQuickCast) {
	if (!withQuickCast)
		return Abilities.ExecuteAbility(ability, unit, false)

	const unitOrder = {
		AbilityIndex: ability,
		UnitIndex: unit,
	}

	// const abilityTargetType = Abilities.GetAbilityTargetType(ability)
	const abilityBehavior = Abilities.GetBehavior(ability)

	const cursorPos = GameUI.GetCursorPosition()

	if (hasBits(abilityBehavior, DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_UNIT_TARGET)) {
		const targetEntity = getEntityUnderCursorPos(cursorPos)
		if (targetEntity !== -1) {
			unitOrder.OrderType = dotaunitorder_t.DOTA_UNIT_ORDER_CAST_TARGET
			unitOrder.TargetIndex = targetEntity
		}
	}

	if (!unitOrder.OrderType)
		return

	if (GameUI.IsShiftDown()) {
		Game.PrepareUnitOrders({
			OrderType: dotaunitorder_t.DOTA_UNIT_ORDER_STOP,
			TargetIndex: PlayerHero,
			QueueBehavior: OrderQueueBehavior_t.DOTA_ORDER_QUEUE_NEVER
		})
	}
	Game.PrepareUnitOrders(unitOrder)
}

(function () {
	FixHeroIcons()
	const centerBlock = FindDotaHudElement("center_block");
	let cosmetics = centerBlock.FindChildTraverse("BarOverItems");

	if (cosmetics) {
		cosmetics.DeleteAsync(0);
	}

	const ability = $.CreatePanel("Button", FindDotaHudElement("BarOverItems"), "CustomAbility_spray_custom");
	ability.BLoadLayoutSnippet("CosmeticAbility");

	const ability2 = $.CreatePanel("Button", FindDotaHudElement("BarOverItems"), "CustomAbility_highfive_custom");
	ability2.BLoadLayoutSnippet("CosmeticAbility2");

	if (!cosmetics) {
		$("#BarOverItems").SetParent(centerBlock);
	}

	const spray = FindDotaHudElement("CustomAbility_spray_custom");
	spray
		.FindChildTraverse("CosmeticAbilityImage")
		.SetImage("file://{images}/custom_game/spray_no_empty.png");
	FindDotaHudElement("BuffContainer").style.marginBottom = "43px;";

	const highfive = FindDotaHudElement("CustomAbility_highfive_custom");
	highfive
		.FindChildTraverse("CosmeticAbilityImage")
		.SetImage("file://{images}/custom_game/highfive.png");
	FindDotaHudElement("BuffContainer").style.marginBottom = "43px;";

	GameEvents.Subscribe("PlayerHeroInited", () => {
		$.Schedule(2, () => {
			localPlayerHeroId = Players.GetPlayerHeroEntityIndex(playerID)
			setupExtraSpellPanel()
		})
	})
})();