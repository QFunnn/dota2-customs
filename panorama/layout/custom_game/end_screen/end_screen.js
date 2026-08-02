--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const ROOT_PANEL = $.GetContextPanel()
// const ROOT_CONTAINER = $("#EndScreenContainer")

let isWin = Game.GetGameWinner() === 2

function setFirstChildTextByClass(parent, elClass, text) {
	const child = parent.FindChildrenWithClassTraverse(elClass)[0]
	if (!child) return

	child.text = text

	return child
}

function setFirstChildTextById(parent, elId, text) {
	const child = parent.FindChildTraverse(elId)
	if (!child) return

	child.text = text

	return child
}

function setDamageSummaryChildTooltip(child, damage, damageOriginal) {
	if (!child) return

	const text = `${$.Localize("#dota_page_post_game_damage_received_reduced")} ${Math.floor((damageOriginal - damage) / Math.max(1, damageOriginal) * 100)}% (<font color=\"rgb(255, 180, 0)\">${getPrettyNumber(damageOriginal)}</font>)`

	child.SetPanelEvent("onmouseover", function() {
		$.DispatchEvent("DOTAShowTextTooltip", child, text);
	});
	child.SetPanelEvent("onmouseout", function() {
		$.DispatchEvent("DOTAHideTextTooltip", child);
	})
}

function getPrettyNumber(number) {
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, " ");
}

function hideChildByClassname(parent, childClass) {
	const child = parent.FindChildrenWithClassTraverse(childClass)[0]
	if (!child) return

	child.visible = false
}

function ShowEndGameScreen() {
	ROOT_PANEL.SetHasClass("SummaryHidden", false)

	let gameSummaryContainer = ROOT_PANEL.FindChildTraverse("GameSummaryContainer")
	if (gameSummaryContainer == null) {
		gameSummaryContainer = $.CreatePanel("Panel", ROOT_PANEL, "GameSummaryContainer")
	}

	gameSummaryContainer.RemoveAndDeleteChildren()
	gameSummaryContainer.BLoadLayoutSnippet("EndGameSummary")

	const resultPanel = setFirstChildTextById(gameSummaryContainer, "GameSummaryResultLabel", $.Localize(isWin ? "#dota_match_history_win" : "#dota_match_history_loss"))
	if (resultPanel)
		resultPanel.SetHasClass(isWin ? "IsWin" : "IsLose", true)

	const extraData = CustomNetTables.GetTableValue("players_summary", "extra_data")

	if (extraData) {
		if (extraData.loseReason) {
			const loseReasonLabel = $("#GameSummaryLoseReasonLabel")
			if (loseReasonLabel) {
				loseReasonLabel.text = $.Localize(extraData.loseReason)
				loseReasonLabel.SetHasClass("Hidden", false)
			}
		}

		if (extraData.difficulty)
			setFirstChildTextById(gameSummaryContainer, "GameSummaryDifficultyLabel", `${$.Localize("#Diff")} ${extraData.difficulty}`)
	}

	const playersSummaryContainer = gameSummaryContainer.FindChildTraverse("PlayersSummaryContainer")
	
	const playersSummaryData = CustomNetTables.GetTableValue("players_summary", "data")

	if (!playersSummaryData)
		return
	
	for (let playerId = 0; playerId < 5; playerId++) {
		const playerSummary = playersSummaryData[String(playerId)]

		if (playerSummary == null)
			continue

		const heroUnitName = playerSummary.heroUnitName
		const heroName = $.Localize(`#${heroUnitName}`)

		if (playersSummaryContainer) {
			const playerSummaryRow = $.CreatePanel("Panel", playersSummaryContainer, "")
			playerSummaryRow.BLoadLayoutSnippet("EndGamePlayerSummary")

			const playerSummaryHeroContainer = playerSummaryRow.FindChildrenWithClassTraverse("PlayerSummaryHeroContainer")[0]
			if (playerSummaryHeroContainer) {
				const heroAvatar = playerSummaryHeroContainer.FindChildrenWithClassTraverse("PlayerHeroImage")[0]
				if (heroAvatar)
					heroAvatar.SetUnit(heroUnitName, "default", true)

				const playerInfoContainer = playerSummaryRow.FindChildrenWithClassTraverse("PlayerInfoContainer")[0]
				if (playerInfoContainer) {
					const playerInfo = Game.GetPlayerInfo(playerId)
					const playerSteamId = playerInfo ? playerInfo.player_steamid : "0"
					
					if (playerSteamId === "0") {
						hideChildByClassname(playerInfoContainer, "PlayerName")

						const botPlayerNameLabel = playerSummaryRow.FindChildrenWithClassTraverse("BotPlayerName")[0]
						if (botPlayerNameLabel)
							botPlayerNameLabel.text = playerInfo ? playerInfo.player_name : "???"
					} else {
						hideChildByClassname(playerInfoContainer, "BotPlayerName")

						const playerNamePanel = playerSummaryRow.FindChildrenWithClassTraverse("PlayerName")[0]
						if (playerNamePanel) {
							playerNamePanel.steamid = playerSteamId
							playerNamePanel.SetPanelEvent("onmouseover", function() {
								$.DispatchEvent("DOTAShowProfileCardTooltip", playerNamePanel, playerSteamId, false);
							})
							playerNamePanel.SetPanelEvent("onmouseout", function() {
								$.DispatchEvent("DOTAHideProfileCardTooltip", playerNamePanel);
							})
						}
					}
				}

				setFirstChildTextByClass(playerSummaryHeroContainer, "HeroName", `${heroName} ${$.Localize("#DOTA_UnitLevel").replace("%s1", Players.GetLevel(playerId))}`)
				setFirstChildTextByClass(playerSummaryHeroContainer, "PlayerAccountLevel", $.Localize("#EndGame_PlayerAccountLevel").replace("%s", playerSummary.accountLevel))
				
				const rewardsContainer = playerSummaryHeroContainer.FindChildrenWithClassTraverse("PlayerRewardsContainer")[0]
				if (rewardsContainer) {
					const shieldsChild = rewardsContainer.GetChild(1)
					if (shieldsChild)
						shieldsChild.text = playerSummary ? `+${getPrettyNumber(Math.floor(playerSummary.shieldsReceived))}` : "+0"
					
					const accountExpChild = rewardsContainer.GetChild(3)
					if (accountExpChild)
						accountExpChild.text = playerSummary ? `+${getPrettyNumber(Math.floor(playerSummary.accountExpReceived))}` : "+0"
					
					const guildExpChild = rewardsContainer.GetChild(5)
					if (guildExpChild)
						guildExpChild.text = playerSummary ? `+${getPrettyNumber(Math.floor(playerSummary.guildExpReceived))}` : "+0"
				}
			}

			setFirstChildTextByClass(playerSummaryRow, "DeathsSummary", getPrettyNumber(playerSummary.deaths))
			setFirstChildTextByClass(playerSummaryRow, "KillsSummary", getPrettyNumber(playerSummary.creepsKilled))
			setFirstChildTextByClass(playerSummaryRow, "GoldSummary", getPrettyNumber(Math.floor(playerSummary.goldReceived)))
			setFirstChildTextByClass(playerSummaryRow, "ExpSummary", getPrettyNumber(Math.floor(playerSummary.expReceived)))

			for (
				const damageColumnInfo of [
					{key: "damageDealt", 	class: "DamageDealtSummary"},
					{key: "damageReceived", class: "DamageReceivedSummary"},
				]
			) {
				const parent = playerSummaryRow.FindChildrenWithClassTraverse(damageColumnInfo.class)[0]
				if (!parent)
					continue

				const summaryPart = playerSummary[damageColumnInfo.key]

				setDamageSummaryChildTooltip(setFirstChildTextByClass(parent, "PhysicalDamageSummary", getPrettyNumber(Math.floor(summaryPart.physical))), summaryPart.physical, summaryPart.physicalOriginal)
				setDamageSummaryChildTooltip(setFirstChildTextByClass(parent, "MagicalDamageSummary", getPrettyNumber(Math.floor(summaryPart.magical))), summaryPart.magical, summaryPart.magicalOriginal)
				setFirstChildTextByClass(parent, "PureDamageSummary", getPrettyNumber(Math.floor(summaryPart.pure)))
				setDamageSummaryChildTooltip(setFirstChildTextByClass(parent, "TotalDamageSummary", getPrettyNumber(Math.floor(summaryPart.total))), summaryPart.total, summaryPart.totalOriginal)
			}			
		}
	}
}

;(() => {
	ROOT_PANEL.SetHasClass("SummaryHidden", true)

	$.Schedule(1, () => {
		isWin = Game.GetGameWinner() === 2

		if (isWin) {
			ROOT_PANEL.SetHasClass("Win", true)
		} else {
			ROOT_PANEL.SetHasClass("Lose", true)
		}

		ShowEndGameScreen()
	})
})()