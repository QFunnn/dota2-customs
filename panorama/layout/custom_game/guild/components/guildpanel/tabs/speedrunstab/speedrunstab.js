--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function SpeedrunsTab(parent) {
	const speedrunsTab = divbtn(parent, { className: "speedruns-tab" })

	// div(speedrunsTab, {parentKey: "coomingSoon"})
	// span(speedrunsTab.coomingSoon, {parentKey: "label", text: "Cooming Soon..."})

	// return speedrunsTab
	speedrunsTab.update = function () {
		if (!this.IsValid()) return

		const speedruns = (typeof GUILD !== "undefined" && GUILD) ? GUILD.speedruns : undefined
		if (!speedruns) {
			// Данные ещё не загружены — не падаем, просто прячем содержимое
			speedrunsTab.selfTop.visible = false
			speedrunsTab.topTeams.visible = false
			speedrunsTab.categories.visible = false
			return
		}

		const isActive = !!speedruns.isActive

		if (isActive) {
			speedrunsTab.selfTop.visible = true
			speedrunsTab.topTeams.visible = false
			speedrunsTab.categories.visible = true

			speedrunsTab.countdown.isSpeedrunActive = true
			speedrunsTab.countdown.inner.label.text = $.Localize("#guild_speedruns_active_duration")

			speedrunsTab.selfTop.updateSelfTopRun()
			speedrunsTab.categories.updateCategories()
		} else {
			speedrunsTab.selfTop.visible = false
			speedrunsTab.topTeams.visible = true
			speedrunsTab.categories.visible = false

			speedrunsTab.countdown.isSpeedrunActive = false
			speedrunsTab.countdown.inner.label.text = $.Localize("#guild_speedruns_non_active_duration")

			this.topTeams.teamCards.updateTeams()
		}
		// speedrunsTab.selfTop.visible = false
		// speedrunsTab.topTeams.visible = false
		// speedrunsTab.countdown.visible = false
		// speedrunsTab.stats.visible = false

		const totalStats = {
			count: 0,
			totalGP: 0,
			totalExp: 0,
		}

		for (let place = 1; place <= 4; place++) {
			const isTotal = place === 4

			const placePanel = speedrunsTab.stats.places[place]

			const placeStats = (speedruns.stats && speedruns.stats.cache && speedruns.stats.cache.get)
				? (speedruns.stats.cache.get(place) ?? { count: 0, max_difficulty: 0, total_gp: 0, total_exp: 0 })
				: { count: 0, max_difficulty: 0, total_gp: 0, total_exp: 0 }

			if (isTotal)
				placePanel.count.text = formatNumber(totalStats.count)
			else {
				placePanel.count.text = formatNumber(placeStats.count)

				totalStats.count += placeStats.count
			}

			if (!isTotal)
				placePanel.details.difficulty.value.text = placeStats.max_difficulty

			if (isTotal)
				placePanel.details.totalGP.value.label.text = formatNumber(totalStats.totalGP)
			else {
				placePanel.details.totalGP.value.label.text = formatNumber(placeStats.total_gp)

				totalStats.totalGP += placeStats.total_gp
			}

			if (isTotal)
				placePanel.details.totalExp.value.label.text = formatNumber(totalStats.totalExp)
			else {
				placePanel.details.totalExp.value.label.text = formatNumber(placeStats.total_exp)

				totalStats.totalExp += placeStats.total_exp
			}
		}
	}

	div(speedrunsTab, { parentKey: "selfTop" })
	speedrunsTab.selfTop.updateSelfTopRun = () => {
		const selfTopRun = GUILD.speedruns.selfTopSpeedrun

		if (!selfTopRun) {
			speedrunsTab.selfTop.SetHasClass("empty", true)

			speedrunsTab.selfTop.noSelfTop.visible = true

			speedrunsTab.selfTop.header.visible = false
			speedrunsTab.selfTop.line.visible = false
			speedrunsTab.selfTop.details.visible = false
			speedrunsTab.selfTop.team.visible = false
			return
		}

		speedrunsTab.selfTop.SetHasClass("empty", false)

		speedrunsTab.selfTop.noSelfTop.visible = false

		speedrunsTab.selfTop.header.visible = true
		speedrunsTab.selfTop.line.visible = true
		speedrunsTab.selfTop.details.visible = true
		speedrunsTab.selfTop.team.visible = true

		speedrunsTab.selfTop.SetHasClass("place-1", selfTopRun.place === 1)
		speedrunsTab.selfTop.SetHasClass("place-2", selfTopRun.place === 2)
		speedrunsTab.selfTop.SetHasClass("place-3", selfTopRun.place === 3)

		speedrunsTab.selfTop.header.icon.inner.SetImage(ImageUtils.resolve(SPEEDRUN_PLACE_ICON[selfTopRun.place]))

		speedrunsTab.selfTop.header.place.value.text = $.Localize("#guild_speedruns_self_top_place_value").replace("{VALUE}", selfTopRun.place)

		speedrunsTab.selfTop.header.difficulty.value.text = selfTopRun.difficulty

		speedrunsTab.selfTop.details.gp.value.text = formatNumber(selfTopRun.gp)
		speedrunsTab.selfTop.details.exp.value.text = formatNumber(selfTopRun.exp)
		speedrunsTab.selfTop.details.time.value.text = GUILD.speedruns.formatSpeedrunDuration(selfTopRun.time)

		speedrunsTab.selfTop.team.players.RemoveAndDeleteChildren()

		selfTopRun.players.forEach(({ id }) => {
			const playerPanel = div(speedrunsTab.selfTop.team.players, { className: "player" })
			div(playerPanel, { parentKey: "inner" })
			playerAvatar(playerPanel.inner, { parentKey: "avatar", steamId: id })
			playerName(playerPanel.inner, { parentKey: "name", steamId: id })
		})
	}

	div(speedrunsTab.selfTop, { parentKey: "noSelfTop" })
	img(speedrunsTab.selfTop.noSelfTop, { parentKey: "icon", image: ImageUtils.resolve("📊") })
	span(speedrunsTab.selfTop.noSelfTop, { parentKey: "label", text: "#guild_speedruns_no_self_top_place" })

	div(speedrunsTab.selfTop, { parentKey: "header" })

	div(speedrunsTab.selfTop.header, { parentKey: "icon" })
	div(speedrunsTab.selfTop.header.icon, { parentKey: "pulse" })
	img(speedrunsTab.selfTop.header.icon, { parentKey: "inner" })

	div(speedrunsTab.selfTop.header, { parentKey: "place" })
	span(speedrunsTab.selfTop.header.place, { parentKey: "label", text: "#guild_speedruns_self_top_place" })
	span(speedrunsTab.selfTop.header.place, { parentKey: "value" })

	div(speedrunsTab.selfTop.header, { parentKey: "difficulty" })
	span(speedrunsTab.selfTop.header.difficulty, { parentKey: "label", text: "#guild_speedruns_difficulty" })
	span(speedrunsTab.selfTop.header.difficulty, { parentKey: "value" })

	div(speedrunsTab.selfTop, { parentKey: "line" })

	div(speedrunsTab.selfTop, { parentKey: "details" })

	div(speedrunsTab.selfTop.details, { parentKey: "gp", className: "detail" })
	img(speedrunsTab.selfTop.details.gp, { parentKey: "icon", image: ICON.GP })
	span(speedrunsTab.selfTop.details.gp, { parentKey: "value" })

	div(speedrunsTab.selfTop.details, { parentKey: "exp", className: "detail" })
	img(speedrunsTab.selfTop.details.exp, { parentKey: "icon", image: ICON.EXP })
	span(speedrunsTab.selfTop.details.exp, { parentKey: "value" })

	div(speedrunsTab.selfTop.details, { parentKey: "time", className: "detail" })
	img(speedrunsTab.selfTop.details.time, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
	span(speedrunsTab.selfTop.details.time, { parentKey: "value" })

	div(speedrunsTab.selfTop, { parentKey: "team" })
	span(speedrunsTab.selfTop.team, { parentKey: "title", text: "#guild_speedruns_team" })
	div(speedrunsTab.selfTop.team, { parentKey: "players" })

	div(speedrunsTab, { parentKey: "topTeams" })

	div(speedrunsTab.topTeams, { parentKey: "title" })
	img(speedrunsTab.topTeams.title, { parentKey: "icon", image: ImageUtils.resolve("🏆") })
	span(speedrunsTab.topTeams.title, { parentKey: "label", text: "#guild_speedruns_top_teams_title" })

	div(speedrunsTab.topTeams, { parentKey: "teamCards" })
	speedrunsTab.topTeams.teamCards.updateTeams = () => {
		speedrunsTab.topTeams.teamCards.RemoveAndDeleteChildren()

		const { topTeams } = GUILD.speedruns

		if (topTeams.size === 0) {
			speedrunsTab.topTeams.visible = false
			return
		}

		speedrunsTab.topTeams.visible = true

		for (let place = 1; place <= 3; place++) {
			const team = topTeams.get(place)
			if (!team || place >= 4) break

			const teamCard = div(speedrunsTab.topTeams.teamCards, { className: `card place-${place}` })

			div(teamCard, { parentKey: "guild" })
			img(teamCard.guild, { parentKey: "placeIcon", image: ImageUtils.resolve(SPEEDRUN_PLACE_ICON[place]) })
			img(teamCard.guild, { parentKey: "guildImage", image: team.guild.image })
			div(teamCard.guild, { parentKey: "namePos" })
			span(teamCard.guild.namePos, { parentKey: "name", text: team.guild.name })
			span(teamCard.guild.namePos, { parentKey: "place", text: $.Localize("#guild_speedruns_top_team").replace("{VALUE}", place) })

			div(teamCard, { className: "line" })

			div(teamCard, { parentKey: "details" })

			div(teamCard.details, { parentKey: "difficulty", className: "detail" })
			img(teamCard.details.difficulty, { parentKey: "icon", image: ImageUtils.resolve("🎯") })
			span(teamCard.details.difficulty, { parentKey: "value", text: team.difficulty })
			span(teamCard.details.difficulty, { parentKey: "label", text: "#guild_speedruns_top_team_difficulty" })

			div(teamCard.details, { parentKey: "place", className: "detail" })
			img(teamCard.details.place, { parentKey: "icon", image: ImageUtils.resolve("🏆") })
			span(teamCard.details.place, { parentKey: "value", text: $.Localize("#guild_speedruns_top_team_place_value").replace("{VALUE}", team.place) })
			span(teamCard.details.place, { parentKey: "label", text: "#guild_speedruns_top_team_place" })

			div(teamCard.details, { parentKey: "time", className: "detail" })
			img(teamCard.details.time, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
			span(teamCard.details.time, { parentKey: "value", text: GUILD.speedruns.formatSpeedrunDuration(team.time) })
			span(teamCard.details.time, { parentKey: "label", text: "#guild_speedruns_top_team_time" })

			div(teamCard, { className: "line" })

			div(teamCard, { parentKey: "team" })

			span(teamCard.team, { parentKey: "title", text: "#guild_speedruns_top_team_team" })

			div(teamCard.team, { parentKey: "players" })

			team.players.forEach((id) => {
				const playerPanel = div(teamCard.team.players, { className: "player" })
				div(playerPanel, { parentKey: "inner" })
				playerAvatar(playerPanel.inner, { parentKey: "avatar", steamId: id })
				// span(playerPanel.inner, { parentKey: "name", text: "sdfgsdfgdfgfsfoigjdsfiogjsdfiogjdfigfgoksdfgpokdsfgdfsdfgsdfg" })
				playerName(playerPanel.inner, { parentKey: "name", steamId: id })
			})

			// speedrunsTab.topTeams.teamCards[place] = teamCard
		}
	}

	const timeUnits = ["days", "hours", "minutes", "seconds"]

	div(speedrunsTab, { parentKey: "countdown" })
	div(speedrunsTab.countdown, { parentKey: "inner" })
	speedrunsTab.countdown.update = () => {
		// GUILD.speedruns может быть ещё не инициализирован на момент первого открытия панели
		const speedruns = (typeof GUILD !== "undefined" && GUILD && GUILD.speedruns) ? GUILD.speedruns : undefined
		if (!speedruns) return

		const timeTable = speedrunsTab.countdown.isSpeedrunActive ? speedruns.timeUntilSpeedrunEnd : speedruns.timeUntilSpeedrunStart
		if (!timeTable) return

		timeUnits.forEach((timeUnit) => {
			const value = Number(timeTable[timeUnit] ?? 0)

			speedrunsTab.countdown.inner.time[timeUnit].value.real.text = timeUnit !== "days" ? String(value).padStart(2, "0") : value
			speedrunsTab.countdown.inner.time[timeUnit].label.text = pluralLocalize(`#guild_speedruns_remaining_${timeUnit}`, value)
		})
	}

	img(speedrunsTab.countdown.inner, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
	span(speedrunsTab.countdown.inner, { parentKey: "label", text: "#guild_speedruns_non_active_duration" })

	div(speedrunsTab.countdown.inner, { parentKey: "time" })

	timeUnits.forEach((timeUnit) => {
		div(speedrunsTab.countdown.inner.time, { parentKey: timeUnit, className: "time-unit" })

		div(speedrunsTab.countdown.inner.time[timeUnit], { parentKey: "value" })
		span(speedrunsTab.countdown.inner.time[timeUnit].value, { parentKey: "phantom", text: timeUnit === "days" ? "0" : "00" })
		span(speedrunsTab.countdown.inner.time[timeUnit].value, { parentKey: "real" })
		span(speedrunsTab.countdown.inner.time[timeUnit], { parentKey: "label" })

		if (timeUnit !== "seconds") {
			span(speedrunsTab.countdown.inner.time, { parentKey: "divider", text: ":" })
		}
	})

	function countdownUpdateLoop() {
		if (!speedrunsTab.IsValid()) return

		if (speedrunsTab.visible)
			speedrunsTab.countdown.update()

		$.Schedule(0.1, countdownUpdateLoop)
	}

	countdownUpdateLoop()

	div(speedrunsTab, { parentKey: "stats" })

	div(speedrunsTab.stats, { parentKey: "header" })
	img(speedrunsTab.stats.header, { parentKey: "icon", image: ImageUtils.resolve("🏆") })
	span(speedrunsTab.stats.header, { parentKey: "label", text: "#guild_speedruns_statistics_title" })

	div(speedrunsTab.stats, { parentKey: "places" })

	for (let place = 1; place <= 4; place++) {
		const isTotal = place === 4

		const placePanel = div(speedrunsTab.stats.places, { className: `place ${isTotal ? "total" : `place-${place}`}` })
		div(placePanel, { parentKey: "header" })
		img(placePanel.header, { parentKey: "icon", image: ImageUtils.resolve(isTotal ? "⭐" : SPEEDRUN_PLACE_ICON[place]) })
		span(placePanel.header, { parentKey: "label", text: isTotal ? "#guild_speedruns_statistics_top_total" : $.Localize("#guild_speedruns_statistics_top").replace("{VALUE}", place) })

		span(placePanel, { parentKey: "count" })

		div(placePanel, { parentKey: "details" })

		if (!isTotal) {
			div(placePanel.details, { parentKey: "difficulty", className: "detail" })
			span(placePanel.details.difficulty, { parentKey: "label", text: "#guild_speedruns_statistics_max_difficulty" })
			span(placePanel.details.difficulty, { parentKey: "value" })
		}

		div(placePanel.details, { parentKey: "totalGP", className: "detail" })
		span(placePanel.details.totalGP, { parentKey: "label", text: "#guild_speedruns_statistics_total_gp" })
		div(placePanel.details.totalGP, { parentKey: "value" })
		img(placePanel.details.totalGP.value, { parentKey: "icon", image: ICON.GP })
		span(placePanel.details.totalGP.value, { parentKey: "label" })

		div(placePanel.details, { parentKey: "totalExp", className: "detail" })
		span(placePanel.details.totalExp, { parentKey: "label", text: "#guild_speedruns_statistics_total_exp" })
		div(placePanel.details.totalExp, { parentKey: "value" })
		img(placePanel.details.totalExp.value, { parentKey: "icon", image: ICON.EXP })
		span(placePanel.details.totalExp.value, { parentKey: "label" })

		speedrunsTab.stats.places[place] = placePanel
	}

	div(speedrunsTab, { parentKey: "categories" })
	speedrunsTab.categories.updateCategories = () => {
		const { categories } = GUILD.speedruns

		for (let difficulty = 10; difficulty <= 20; difficulty++) {
			const { bestTime, runs } = categories.get(difficulty)

			const { panel: difficultyPanel } = difficultyPanelsData.get(difficulty)

			if (!bestTime) {
				difficultyPanel.inner.header.right.bestTime.visible = false
			} else {
				difficultyPanel.inner.header.right.bestTime.visible = true
				difficultyPanel.inner.header.right.bestTime.value.text = GUILD.speedruns.formatSpeedrunDuration(bestTime)
			}

			if (!runs.get(1)) {
				difficultyPanel.inner.runs.noRuns.visible = true

				for (let place = 1; place <= 3; place++) {
					difficultyPanel.inner.header.teams[place].visible = false
					difficultyPanel.inner.runs[place].visible = false
				}
				continue
			}

			difficultyPanel.inner.runs.noRuns.visible = false

			for (let place = 1; place <= 3; place++) {
				const runPanel = difficultyPanel.inner.runs[place]
				runPanel.visible = true

				runPanel.SetHasClass("place-1", place === 1)
				runPanel.SetHasClass("place-2", place === 2)
				runPanel.SetHasClass("place-3", place === 3)

				const run = runs.get(place)
				if (!run) {
					difficultyPanel.inner.header.teams[place].visible = false

					runPanel.visible = false
					continue
				}

				difficultyPanel.inner.header.teams[place].visible = true
				runPanel.visible = true

				difficultyPanel.inner.header.teams[place].SetImage(run.guild.image)

				runPanel.header.place.icon.SetImage(ImageUtils.resolve(SPEEDRUN_PLACE_ICON[place]))
				runPanel.header.place.label.text = $.Localize("#guild_speedruns_difficulties_place").replace("{VALUE}", run.place)

				runPanel.header.guildImage.SetImage(run.guild.image)
				runPanel.header.guildName.text = run.guild.name

				runPanel.header.isSelf.visible = run.guild.name === GUILD.name

				runPanel.header.details.gp.value.text = formatNumber(run.gp)
				runPanel.header.details.exp.value.text = formatNumber(run.exp)
				runPanel.header.details.time.value.text = GUILD.speedruns.formatSpeedrunDuration(run.time)

				for (let playerNum = 0; playerNum <= 4; playerNum++) {
					const playerRow = runPanel.players[playerNum]

					const player = run.players[playerNum]
					if (!player) {
						playerRow.visible = false
						continue
					}

					playerRow.visible = true

					playerRow.hero.setHero(player.heroName)
					playerRow.avatar.setSteamId(player.id)
					playerRow.name.setSteamId(player.id)

					for (let itemNum = 0; itemNum <= 5; itemNum++) {
						const itemPanel = playerRow.items[itemNum]

						const itemName = player.items[itemNum]
						if (!itemName) {
							itemPanel.visible = false
							continue
						}

						itemPanel.visible = true

						itemPanel.setItem(itemName)
					}
				}
			}
		}
	}

	span(speedrunsTab.categories, { parentKey: "title", text: "#guild_speedruns_difficulties_title" })

	div(speedrunsTab.categories, { parentKey: "warning" })
	img(speedrunsTab.categories.warning, { parentKey: "icon", image: ImageUtils.resolve("⚠️") })
	span(speedrunsTab.categories.warning, { parentKey: "prefix", text: "#guild_speedruns_difficulties_warning_prefix" })
	span(speedrunsTab.categories.warning, { parentKey: "label", text: "#guild_speedruns_difficulties_warning" })

	div(speedrunsTab.categories, { parentKey: "list" })

	/**
	 * @type {Collection<number, {panel: Panel}>}
	 */
	const difficultyPanelsData = new Collection()

	for (let difficulty = 10; difficulty <= 20; difficulty++) {
		const difficultyPanel = div(speedrunsTab.categories.list, { className: "difficulty" })
		div(difficultyPanel, { parentKey: "inner" })

		btn(difficultyPanel.inner, { parentKey: "header", onLeftClick: () => difficultyPanel.ToggleClass("expanded") })

		div(difficultyPanel.inner.header, { parentKey: "value" })
		span(difficultyPanel.inner.header.value, { parentKey: "inner", text: difficulty })
		div(difficultyPanel.inner.header, { parentKey: "teams" })

		for (let teamNum = 1; teamNum <= 3; teamNum++) {
			const teamPanel = img(difficultyPanel.inner.header.teams)

			difficultyPanel.inner.header.teams[teamNum] = teamPanel
		}

		span(difficultyPanel.inner.header, { parentKey: "right" })
		div(difficultyPanel.inner.header.right, { parentKey: "bestTime" })
		img(difficultyPanel.inner.header.right.bestTime, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
		span(difficultyPanel.inner.header.right.bestTime, { parentKey: "value" })
		div(difficultyPanel.inner.header.right, { parentKey: "expand" })
		span(difficultyPanel.inner.header.right.expand, { parentKey: "label", text: "▲" })

		div(difficultyPanel.inner, { parentKey: "runs" })

		div(difficultyPanel.inner.runs, { parentKey: "noRuns" })
		div(difficultyPanel.inner.runs.noRuns, { parentKey: "inner" })
		img(difficultyPanel.inner.runs.noRuns.inner, { parentKey: "icon", image: ImageUtils.resolve("ℹ️") })
		span(difficultyPanel.inner.runs.noRuns.inner, { parentKey: "label", text: "#guild_speedruns_difficulties_no_runs" })

		for (let place = 1; place <= 3; place++) {
			const runPanel = div(difficultyPanel.inner.runs, { className: "run" })

			div(runPanel, { parentKey: "header" })

			div(runPanel.header, { parentKey: "place" })
			img(runPanel.header.place, { parentKey: "icon" })
			span(runPanel.header.place, { parentKey: "label" })

			img(runPanel.header, { parentKey: "guildImage" })
			span(runPanel.header, { parentKey: "guildName" })

			span(runPanel.header, { parentKey: "isSelf", text: "#guild_speedruns_difficulties_self_guild" })

			div(runPanel.header, { parentKey: "details" })

			div(runPanel.header.details, { parentKey: "gp", className: "detail" })
			img(runPanel.header.details.gp, { parentKey: "icon", image: ICON.GP })
			span(runPanel.header.details.gp, { parentKey: "value" })

			div(runPanel.header.details, { parentKey: "exp", className: "detail" })
			img(runPanel.header.details.exp, { parentKey: "icon", image: ICON.EXP })
			span(runPanel.header.details.exp, { parentKey: "value" })

			div(runPanel.header.details, { parentKey: "time", className: "detail" })
			img(runPanel.header.details.time, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
			span(runPanel.header.details.time, { parentKey: "value" })

			div(runPanel, { parentKey: "line" })

			div(runPanel, { parentKey: "players" })

			for (let playerNum = 0; playerNum <= 4; playerNum++) {
				const playerRow = div(runPanel.players, { className: "player" })

				heroImage(playerRow, { parentKey: "hero", heroName: "npc_dota_hero_muerta" })
				playerAvatar(playerRow, { parentKey: "avatar" })
				playerName(playerRow, { parentKey: "name" })
				// span(playerRow, { parentKey: "name", text: "sdfpoigsdfpgdfigjsdfiogjsdfoigjsdfiogjsdfoigjsdfiogjsdiohjsgifohjiogdfhjisdogjifodgjsiodfgjsodfigjsoidfjgsioposfdgksdfijghoerjgoidfsjghiosdfjgdisfogjdfgjisodfjgi" })

				div(playerRow, { parentKey: "items" })

				for (let itemNum = 0; itemNum <= 5; itemNum++) {
					const itemPanel = itemImage(playerRow.items, { className: "item", itemName: "item_heart_lua3" })

					playerRow.items[itemNum] = itemPanel
				}

				runPanel.players[playerNum] = playerRow
			}

			difficultyPanel.inner.runs[place] = runPanel
		}

		difficultyPanelsData.set(difficulty, {
			panel: difficultyPanel,
		})
	}

	speedrunsTab.update()

	return speedrunsTab
}