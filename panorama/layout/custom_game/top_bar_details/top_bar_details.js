--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const ROOT_PANEL = $.GetContextPanel()

const DOTA_HUD_ROOT = $.GetContextPanel().GetParent().GetParent().GetParent()

const difficultyData = {
	difficulty: 1,
	extraAbilities: {
		boss: undefined,
		creeps: undefined,
	},
}

function updateDifficulty() {
	const difficultyContainer = ROOT_PANEL.FindChildTraverse("DifficultyContainer")
	if (!difficultyContainer) return

	const difficultyLabelValue = difficultyContainer.FindChildTraverse("DifficultyValue")
	if (!difficultyLabelValue) return

	difficultyLabelValue.text = String(difficultyData.difficulty)
}

function updateExtraAbilities() {
	const extraAbilities = ROOT_PANEL.FindChildTraverse("ExtraAbilitiesContainer")
	if (!extraAbilities) return

	for (const { id, key } of [
		{id: "BossAbilityContainer", key: "boss"},
		{id: "CreepsAbility", key: "creeps"},
	]) {
		const extraAbilityContainer = extraAbilities.FindChildTraverse(id)
		if (!extraAbilityContainer) continue

		const extraAbility = extraAbilityContainer.FindChildrenWithClassTraverse("Ability")[0]
		if (extraAbility) {
			const abilityData = difficultyData.extraAbilities[key]
			if (abilityData && abilityData.name) {
				extraAbility.abilityname = abilityData.name
				
				extraAbility.SetPanelEvent("onmouseover", function () {
					$.DispatchEvent("DOTAShowAbilityTooltipForLevel", extraAbility, abilityData.name, abilityData.level)
				});
				extraAbility.SetPanelEvent("onmouseout", function () {
					$.DispatchEvent("DOTAHideAbilityTooltip")
				});

				extraAbilityContainer.visible = true
			} else {
				extraAbilityContainer.visible = false
			}
		}
	}
}

;(function () {
	const topBarDireTeam = DOTA_HUD_ROOT.FindChildTraverse("TopBarDireTeam")
	if (topBarDireTeam)
		topBarDireTeam.visible = false

	if (ROOT_PANEL.GetParent().id !== "TopBarDireTeamContainer") {
		const HUD_ELEMENTS = DOTA_HUD_ROOT.FindChildTraverse("HUDElements")
		if (HUD_ELEMENTS) {
			const TOP_BAR = HUD_ELEMENTS.FindChildTraverse("topbar")
			if (TOP_BAR) {
				const TOP_BAR_DIRE_TEAM = TOP_BAR.FindChildTraverse("TopBarDireTeamContainer")

				if (TOP_BAR_DIRE_TEAM)
					ROOT_PANEL.SetParent(TOP_BAR_DIRE_TEAM)
			}
		}
	}

	for (const containerId of ["BossAbilityContainer", "CreepsAbility"]) {
		const container = $(`#${containerId}`)

		if (!container) continue

		const hintPanel = container.FindChildrenWithClassTraverse("TypeHintIcon")[0]
		if (hintPanel) {
			hintPanel.SetPanelEvent("onmouseover", function () {
    			$.DispatchEvent("DOTAShowTextTooltip", hintPanel, $.Localize(`#top_bar_details_hint_type_${hintPanel.id}`))
			});
			hintPanel.SetPanelEvent("onmouseout", function () {
				$.DispatchEvent("DOTAHideTextTooltip")
			});
		}
	}

	GameEvents.Subscribe("UpdateDifficultData:Difficulty", ({ difficulty }) => {
		difficultyData.difficulty = difficulty

		updateDifficulty()
	});
	GameEvents.Subscribe("UpdateDifficultData:ExtraAbilities", (extraAbilities) => {
		difficultyData.extraAbilities = extraAbilities

		updateExtraAbilities()
	});
	GameEvents.Subscribe("UpdateDifficultData:Full", ({ difficulty, extraAbilities }) => {
		difficultyData.difficulty = difficulty
		difficultyData.extraAbilities = extraAbilities

		updateDifficulty()
		updateExtraAbilities()
	});

	GameEvents.SendCustomGameEventToServer("RequestDifficultData", {})

	updateExtraAbilities()
})()