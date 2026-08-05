--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function QuestsTab(parent) {
	const questsTab = divbtn(parent, { className: "quests-tab" })

	div(questsTab, { parentKey: "header" })

	div(questsTab.header, { parentKey: "primary" })
	img(questsTab.header.primary, { parentKey: "icon", image: ImageUtils.resolve("📋") })
	span(questsTab.header.primary, { parentKey: "label", text: "#guild_quests_header_primary_text" })

	span(questsTab.header, { parentKey: "secondary", text: "#guild_quests_header_secondary_text" })

	div(questsTab, { parentKey: "tabs" })

	div(questsTab, { parentKey: "list" })

	function updateTabTimers() {
		if (!questsTab.IsValid()) return

		if (questsTab.visible)
			tabs.forEach(({ button, panel }, category) => {
				button.updateTimer()

				if (GUILD.quests.tryCategoryReset(category)) {
					panel.update()
				}
			})

		$.Schedule(0.2, updateTabTimers)
	}
	$.Schedule(0, function () {
		tabs.forEach(({ button, panel }, category) => {
			if (!button.IsValid())
				return

			button.updateTimer()

			if (GUILD.quests.tryCategoryReset(category)) {
				panel.update()
			}
		})

		updateTabTimers()
	})

	/**
	 * @type {Collection<QuestCategory, {button: Button, panel: Panel}>}
	 */
	const tabs = new Collection()

	/**
	 * @type {Collection<string, Panel>}
	 */
	const questPanels = new Collection()

	let activeTabButton

	for (const category of ["daily", "weekly", "guild"]) {
		const tabButton = btn(questsTab.tabs, {
			onLeftClick: () => {
				if (activeTabButton) {
					activeTabButton.SetHasClass("active", false)

					const tab = tabs.get(activeTabButton.category)
					if (tab && tab.panel && tab.panel.IsValid())
						tab.panel.visible = false
				}

				tabButton.SetHasClass("active", true)

				const tab = tabs.get(category)
				if (tab && tab.panel && tab.panel.IsValid())
					tab.panel.visible = true

				activeTabButton = tabButton
				activeTabButton.category = category
			},
		})
		tabButton.updateTimer = () => {
			tabButton.wrapper.top.expireTime.text = GUILD.quests.getFormattedCategoryExpireTime(category)
		}
		tabButton.updateProgress = () => {
			const completedQuestsCount = GUILD.quests.categoriesCache.get(category).count((quest) => quest.isCompleted)
			const categoryQuestsCount = GUILD.quests.categoriesCache.get(category).size

			tabButton.wrapper.bottom.progress.text = `${completedQuestsCount} / ${categoryQuestsCount}`

			tabButton.indicator.visible = categoryQuestsCount > completedQuestsCount
		}

		div(tabButton, { parentKey: "wrapper" })

		div(tabButton.wrapper, { parentKey: "top" })
		span(tabButton.wrapper.top, { parentKey: "expireTime", text: `0:00:00` })

		div(tabButton.wrapper, { parentKey: "bottom" })
		img(tabButton.wrapper.bottom, { parentKey: "icon", image: ImageUtils.resolve(QUEST_CATEGORY_ICON[category]) })
		span(tabButton.wrapper.bottom, { parentKey: "name", text: `#guild_quests_${category}_name` })
		span(tabButton.wrapper.bottom, { parentKey: "progress", text: `0 / 0` })

		div(tabButton, { parentKey: "indicator" })
		span(tabButton.indicator, { parentKey: "inner", text: "!" })

		const tabPanel = div(questsTab.list, { className: category, className: "content" })
		tabPanel.update = () => {
			tabButton.updateProgress()

			tabPanel.questPanels.forEach((questPanel) => {
				questPanel.update()
			})
		}
		tabPanel.visible = false

		/**
		 * @type {Collection<string, Panel>}
		 */
		tabPanel.questPanels = new Collection()

		GUILD.quests.categoriesCache.get(category).forEach((quest) => {
			const questPanel = divbtn(tabPanel, { className: `quest ${category}` })
			questPanel.update = () => {
				if (quest.isDonation) {
					if (questPanel.inner.details.donation.shields) {
						const progress = quest.progress.shields
						const progressPct = Math.floor(progress / quest.target.shields * 100)

						questPanel.inner.details.donation.shields.progress.numerical.text = `${formatNumber(progress)} / ${formatNumber(quest.target.shields)}`
						questPanel.inner.details.donation.shields.progress.percentage.text = `(${progressPct}%)`

						if (progressPct === 100) {
							questPanel.inner.details.donation.shields.donate.textEntry.visible = false
							questPanel.inner.details.donation.shields.donate.donate.SetHasClass("done", true)
							questPanel.inner.details.donation.shields.donate.donate.label.visible = false
							questPanel.inner.details.donation.shields.donate.donate.done.visible = true
						} else {
							questPanel.inner.details.donation.shields.donate.textEntry.visible = true
							questPanel.inner.details.donation.shields.donate.donate.SetHasClass("done", false)
							questPanel.inner.details.donation.shields.donate.donate.label.visible = true
							questPanel.inner.details.donation.shields.donate.donate.done.visible = false
						}
					}

					if (questPanel.inner.details.donation.crystals) {
						const progress = quest.progress.crystals
						const progressPct = Math.floor(progress / quest.target.crystals * 100)

						questPanel.inner.details.donation.crystals.progress.numerical.text = `${formatNumber(progress)} / ${formatNumber(quest.target.crystals)}`
						questPanel.inner.details.donation.crystals.progress.percentage.text = `(${progressPct}%)`

						if (progressPct === 100) {
							questPanel.inner.details.donation.crystals.donate.textEntry.visible = false
							questPanel.inner.details.donation.crystals.donate.donate.SetHasClass("done", true)
							questPanel.inner.details.donation.crystals.donate.donate.label.visible = false
							questPanel.inner.details.donation.crystals.donate.donate.done.visible = true
						} else {
							questPanel.inner.details.donation.crystals.donate.textEntry.visible = true
							questPanel.inner.details.donation.crystals.donate.donate.SetHasClass("done", false)
							questPanel.inner.details.donation.crystals.donate.donate.label.visible = true
							questPanel.inner.details.donation.crystals.donate.donate.done.visible = false
						}
					}
				} else {
					const progress = quest.progress.value
					const progressPct = Math.floor(progress / quest.target * 100)

					questPanel.inner.details.progress.labels.numerical.text = `${formatNumber(progress)} / ${formatNumber(quest.target)}`
					questPanel.inner.details.progress.labels.percentage.text = `${progressPct}%`

					questPanel.inner.details.progress.bar.filler.style.width = `${progressPct}%`

					questPanel.inner.details.progress.SetHasClass("completed", quest.isCompleted)
				}

				if (questPanel.inner.details.contributors) {
					questPanel.inner.details.contributors.label.text = $.Localize("#guild_quests_guild_contributers").replace("{VALUE}", formatNumber(quest.contributorsCount))
				}

				questPanel.SetHasClass("completed", quest.isCompleted)

				questPanel.inner.details.header.right.top.status.visible = quest.isCompleted
			}

			div(questPanel, { parentKey: "inner", className: category })

			div(questPanel.inner, { parentKey: "mark", className: category })

			div(questPanel.inner, { parentKey: "details" })

			div(questPanel.inner.details, { parentKey: "header" })

			img(questPanel.inner.details.header, { parentKey: "icon", image: quest.image })

			div(questPanel.inner.details.header, { parentKey: "right" })
			div(questPanel.inner.details.header.right, { parentKey: "top" })
			span(questPanel.inner.details.header.right.top, { parentKey: "name", text: quest.name })
			div(questPanel.inner.details.header.right.top, { parentKey: "status" })
			// img(questPanel.inner.details.header.right.top.status, { parentKey: "icon", image: ImageUtils.resolve(CHECK_SYMBOL.YES) })
			span(questPanel.inner.details.header.right.top.status, { parentKey: "label", text: "#guild_quests_completed" })
			span(questPanel.inner.details.header.right, { parentKey: "desc", text: quest.description })

			if (quest.isDonation) {
				div(questPanel.inner.details, { parentKey: "donation" })

				if (quest.target.shields) {
					div(questPanel.inner.details.donation, { parentKey: "shields", className: "currency" })

					div(questPanel.inner.details.donation.shields, { parentKey: "progress" })
					img(questPanel.inner.details.donation.shields.progress, { parentKey: "icon", image: ICON.SHIELD })
					span(questPanel.inner.details.donation.shields.progress, { parentKey: "numerical", text: "0 / 0" })
					span(questPanel.inner.details.donation.shields.progress, { parentKey: "percentage", text: "0%" })

					div(questPanel.inner.details.donation.shields, { parentKey: "donate" })

					textEntry(questPanel.inner.details.donation.shields.donate, { parentKey: "textEntry", placeholder: "#guild_quests_donate_placeholder", textMode: "numeric", maxChars: 10 })
					questPanel.inner.details.donation.shields.donate.textEntry.onChange = function () {
						const text = this.input.text
						if (!text.length) return

						const value = Number(text)
						if (Number.isNaN(value)) return

						const neededAmount = quest.target.shields - quest.progress.shields
						if (neededAmount >= value) return

						this.raiseChangeEvents = false
						this.input.text = Math.min(neededAmount, value)
						this.raiseChangeEvents = true
					}

					btn(questPanel.inner.details.donation.shields.donate, { parentKey: "donate", text: "#guild_quests_donate" })
					img(questPanel.inner.details.donation.shields.donate.donate, { parentKey: "done", image: ImageUtils.resolve(CHECK_SYMBOL.YES) })
					
					questPanel.inner.details.donation.shields.donate.donate.onLeftClick = () => {
						const shieldsCount = parseNumber(questPanel.inner.details.donation.shields.donate.textEntry.input.text)
						if (!shieldsCount) return

						this.raiseChangeEvents = false
						questPanel.inner.details.donation.shields.donate.textEntry.input.text = ""
						this.raiseChangeEvents = true

						GameEvents.SendCustomGameEventToServer("Guild:QuestDonate", { questId: quest.id, currency: "shields", amount: shieldsCount })
					}
				}

				if (quest.target.crystals) {
					div(questPanel.inner.details.donation, { parentKey: "crystals", className: "currency" })

					div(questPanel.inner.details.donation.crystals, { parentKey: "progress" })
					img(questPanel.inner.details.donation.crystals.progress, { parentKey: "icon", image: ICON.CRYSTAL })
					span(questPanel.inner.details.donation.crystals.progress, { parentKey: "numerical", text: "0 / 0" })
					span(questPanel.inner.details.donation.crystals.progress, { parentKey: "percentage", text: "0%" })

					div(questPanel.inner.details.donation.crystals, { parentKey: "donate" })

					textEntry(questPanel.inner.details.donation.crystals.donate, { parentKey: "textEntry", placeholder: "#guild_quests_donate_placeholder", textMode: "numeric", maxChars: 10 })
					questPanel.inner.details.donation.crystals.donate.textEntry.onChange = function () {
						const text = this.input.text
						if (!text.length) return

						const value = Number(text)
						if (Number.isNaN(value)) return

						const neededAmount = quest.target.crystals - quest.progress.crystals
						if (neededAmount >= value) return

						this.raiseChangeEvents = false
						this.input.text = Math.min(neededAmount, value)
						this.raiseChangeEvents = true
					}

					btn(questPanel.inner.details.donation.crystals.donate, { parentKey: "donate", text: "#guild_quests_donate" })
					img(questPanel.inner.details.donation.crystals.donate.donate, { parentKey: "done", image: ImageUtils.resolve(CHECK_SYMBOL.YES) })
					
					questPanel.inner.details.donation.crystals.donate.donate.onLeftClick = () => {
						const crystalsCount = parseNumber(questPanel.inner.details.donation.crystals.donate.textEntry.input.text)
						if (!crystalsCount) return

						this.raiseChangeEvents = false
						questPanel.inner.details.donation.crystals.donate.textEntry.input.text = ""
						this.raiseChangeEvents = true

						GameEvents.SendCustomGameEventToServer("Guild:QuestDonate", { questId: quest.id, currency: "crystals", amount: crystalsCount })
					}
				}
			} else {
				div(questPanel.inner.details, { parentKey: "progress" })

				div(questPanel.inner.details.progress, { parentKey: "labels" })
				span(questPanel.inner.details.progress.labels, { parentKey: "numerical" })
				span(questPanel.inner.details.progress.labels, { parentKey: "percentage" })

				div(questPanel.inner.details.progress, { parentKey: "bar" })
				div(questPanel.inner.details.progress.bar, { parentKey: "filler" })
				div(questPanel.inner.details.progress.bar.filler, { parentKey: "animation" })
			}

			if (quest.isGuildQuest) {
				div(questPanel.inner.details, { parentKey: "contributors" })
				img(questPanel.inner.details.contributors, { parentKey: "icon", image: ImageUtils.resolve("👥") })
				span(questPanel.inner.details.contributors, { parentKey: "label" })
			}

			div(questPanel.inner.details, { parentKey: "line" })

			div(questPanel.inner.details, { parentKey: "rewards" })

			if (quest.rewards.merits) {
				const meritsRewardPanel = div(questPanel.inner.details.rewards, { parentKey: "merits", className: "reward" })
				img(questPanel.inner.details.rewards.merits, { parentKey: "icon", image: ICON.MERITS })
				span(questPanel.inner.details.rewards.merits, { parentKey: "value", text: formatNumber(quest.rewards.merits) })

				const isPersonalQuest = category !== "guild"

				meritsRewardPanel.SetPanelEvent("onmouseover", () => {
					$.DispatchEvent(
						"DOTAShowTextTooltip",
						meritsRewardPanel,
						$.Localize(isPersonalQuest ? "#guild_quests_personal_reward" : "#guild_quests_guild_reward")
					)
				})
				meritsRewardPanel.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))
			}

			if (quest.rewards.gp) {
				div(questPanel.inner.details.rewards, { parentKey: "gp", className: "reward" })
				img(questPanel.inner.details.rewards.gp, { parentKey: "icon", image: ICON.GP })
				span(questPanel.inner.details.rewards.gp, { parentKey: "value", text: formatNumber(quest.rewards.gp) })
			}

			if (quest.rewards.exp) {
				div(questPanel.inner.details.rewards, { parentKey: "exp", className: "reward" })
				img(questPanel.inner.details.rewards.exp, { parentKey: "icon", image: ICON.EXP })
				span(questPanel.inner.details.rewards.exp, { parentKey: "value", text: formatNumber(quest.rewards.exp) })
			}

			tabPanel.questPanels.set(quest.id, questPanel)
			questPanels.set(quest.id, questPanel)
		})

		tabPanel.update()

		tabs.set(category, {
			button: tabButton,
			panel: tabPanel,
		})

		if (!activeTabButton)
			tabButton.onLeftClick()
	}

	GuildEvents.PremadeEvents.QuestPatch(({ quest }) => {
		const questPanel = questPanels.get(quest.id)
		if (questPanel && questPanel.IsValid())
			questPanel.update()

		const categoryTab = tabs.get(quest.category)
		if (categoryTab) {
			const categoryTabButton = categoryTab.button
			if (categoryTabButton && categoryTabButton.IsValid()) {
				categoryTabButton.updateProgress()
			}
		}
	}, questsTab)

	return questsTab
}