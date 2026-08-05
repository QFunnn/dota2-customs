--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {{talent: Talent, talentPanel: Button}} TalentPanelData
 * @typedef {Collection<string, TalentPanelData>} TalentPanelsData
 */

function TalentsTab(parent) {
	const talentsTab = div(parent, { className: "talents-tab" })

	div(talentsTab, { parentKey: "left" })

	div(talentsTab.left, { parentKey: "header" })

	div(talentsTab.left.header, { parentKey: "level" })
	div(talentsTab.left.header.level, { parentKey: "wrapper" })
	span(talentsTab.left.header.level.wrapper, { parentKey: "title", text: "#guild_talents_guild_level" })
	span(talentsTab.left.header.level.wrapper, { parentKey: "label", text: formatNumber(GUILD.level) })

	div(talentsTab.left.header, { parentKey: "balance" })
	span(talentsTab.left.header.balance, { parentKey: "title", text: "#guild_talents_guild_balance" })
	div(talentsTab.left.header.balance, { parentKey: "currencies" })

	div(talentsTab.left.header.balance.currencies, { parentKey: "gp", className: "currency" })
	div(talentsTab.left.header.balance.currencies.gp, { parentKey: "wrapper" })
	img(talentsTab.left.header.balance.currencies.gp.wrapper, { parentKey: "icon", image: ICON.GP })
	span(talentsTab.left.header.balance.currencies.gp.wrapper, { parentKey: "value", text: formatNumber(GUILD.gp) })

	div(talentsTab.left.header.balance.currencies, { parentKey: "crystals", className: "currency" })
	div(talentsTab.left.header.balance.currencies.crystals, { parentKey: "wrapper" })
	img(talentsTab.left.header.balance.currencies.crystals.wrapper, { parentKey: "icon", image: ICON.CRYSTAL })
	span(talentsTab.left.header.balance.currencies.crystals.wrapper, { parentKey: "value", text: formatNumber(GUILD.crystals) })

	GuildEvents.PremadeEvents.GuildPatch(({ guild, key }) => {
		switch (key) {
			case "level": {
				talentsTab.left.header.level.wrapper.label.text = formatNumber(guild.level)
				break
			}
			case "gp": {
				talentsTab.left.header.balance.currencies.gp.wrapper.value.text = formatNumber(guild.gp)
			}
			case "crystals": {
				talentsTab.left.header.balance.currencies.crystals.wrapper.value.text = formatNumber(guild.crystals)
			}
		}
	}, talentsTab)

	div(talentsTab.left, { parentKey: "search" })
	textEntry(talentsTab.left.search, { parentKey: "textEntry", image: ImageUtils.resolve("🔍"), placeholder: "#guild_talents_text_area_placeholder", maxChars: 45 })

	div(talentsTab.left, { parentKey: "filterSort" })

	div(talentsTab.left.filterSort, { parentKey: "filter" })
	span(talentsTab.left.filterSort.filter, { parentKey: "label" })
	div(talentsTab.left.filterSort.filter, { parentKey: "dropDown" })

	div(talentsTab.left.filterSort, { parentKey: "sort" })
	span(talentsTab.left.filterSort.sort, { parentKey: "label" })
	div(talentsTab.left.filterSort.sort, { parentKey: "dropDown" })

	divbtn(talentsTab.left, { parentKey: "list" })

	/**
	 * @type {TalentPanelsData}
	 */
	const talentPanelsData = new Collection()

	for (const [talentId, talent] of GUILD.talents.cache)  {
		const talentPanel = btn(talentsTab.left.list, { className: "talent-container" })
		talentPanel.onLeftClick = () => {
			showTalent(talent)
		}
		talentPanel.update = () => {
			const { isGuildPower, level, maxLevel, isMaxed, priceGP, priceCrystals } = talent

			if (isMaxed) {
				talentPanel.SetHasClass("maxed", true)
				talentPanel.details.header.right.level.label.text = $.Localize("#guild_talents_level_max")

				talentPanel.details.header.left.valueContainer.next.visible = false

				talentPanel.details.header.left.valueContainer.current.value.text = talent.formattedCurrentValue
				talentPanel.details.header.left.valueContainer.current.value.SetHasClass("NoBonus", false)
			} else {
				talentPanel.SetHasClass("maxed", false)
				talentPanel.details.header.right.level.label.text = `${level} / ${isGuildPower ? "∞" : maxLevel}`
				talentPanel.details.header.left.valueContainer.next.visible = true

				talentPanel.details.header.left.valueContainer.current.value.text = talent.formattedCurrentValue
				talentPanel.details.header.left.valueContainer.current.value.SetHasClass("NoBonus", level === 0)

				talentPanel.details.header.left.valueContainer.next.value.text = talent.formattedNextValue
			}

			if (isMaxed || isGuildPower) {
				talentPanel.details.progress.visible = false
			} else {
				talentPanel.details.progress.visible = true

				talentPanel.details.progress.bar.filler.style.width = `${Math.floor(level / maxLevel * 100)}%`
				talentPanel.details.progress.label.inner.text = `${Math.floor(level / maxLevel * 100)}%`
			}

			talentPanel.details.priceEff.visible = !isMaxed

			let hideDivider = false

			if (priceGP === 0) {
				hideDivider = true

				talentPanel.details.priceEff.price.gp.visible = false
			} else {
				talentPanel.details.priceEff.price.gp.visible = true

				talentPanel.details.priceEff.price.gp.label.text = formatNumber(priceGP)
				talentPanel.details.priceEff.price.gp.canEfford.SetImage(ImageUtils.resolve(talent.canEffordForGP ? CHECK_SYMBOL.YES : CHECK_SYMBOL.NO))
			}

			if (priceCrystals === 0) {
				hideDivider = true

				talentPanel.details.priceEff.price.crystals.visible = false
			} else {
				talentPanel.details.priceEff.price.crystals.visible = true

				talentPanel.details.priceEff.price.crystals.label.text = formatNumber(priceCrystals)
				talentPanel.details.priceEff.price.crystals.canEfford.SetImage(ImageUtils.resolve(talent.canEffordForCrystals ? CHECK_SYMBOL.YES : CHECK_SYMBOL.NO))
			}

			talentPanel.details.priceEff.price.divider.visible = !hideDivider

			talentPanel.SetHasClass("canUpgrade", talent.canUpgrade)
		}

		div(talentPanel, { parentKey: "mark" })

		img(talentPanel, { parentKey: "icon", image: talent.image })

		div(talentPanel, { parentKey: "details" })

		div(talentPanel.details, { parentKey: "header" })

		div(talentPanel.details.header, { parentKey: "left" })

		span(talentPanel.details.header.left, { parentKey: "name", text: talent.name })

		div(talentPanel.details.header.left, { parentKey: "valueContainer" })

		div(talentPanel.details.header.left.valueContainer, { parentKey: "current", className: "value" })
		span(talentPanel.details.header.left.valueContainer.current, { parentKey: "label", text: "#guild_talents_value_current" })
		span(talentPanel.details.header.left.valueContainer.current, { parentKey: "value" })

		div(talentPanel.details.header.left.valueContainer, { parentKey: "next", className: "value" })
		span(talentPanel.details.header.left.valueContainer.next, { parentKey: "label", text: "#guild_talents_value_next" })
		span(talentPanel.details.header.left.valueContainer.next, { parentKey: "value" })

		div(talentPanel.details.header, { parentKey: "right" })

		div(talentPanel.details.header.right, { parentKey: "level" })
		span(talentPanel.details.header.right.level, { parentKey: "label" })

		div(talentPanel.details, { parentKey: "progress" })

		div(talentPanel.details.progress, { parentKey: "bar" })
		div(talentPanel.details.progress.bar, { parentKey: "filler" })
		div(talentPanel.details.progress.bar.filler, { parentKey: "animation" })

		span(talentPanel.details.progress, { parentKey: "label" })
		span(talentPanel.details.progress.label, { parentKey: "inner" })

		div(talentPanel.details, { parentKey: "priceEff" })

		div(talentPanel.details.priceEff, { parentKey: "price" })

		div(talentPanel.details.priceEff.price, { parentKey: "gp", className: "currency" })
		img(talentPanel.details.priceEff.price.gp, { parentKey: "icon", image: ICON.GP })
		span(talentPanel.details.priceEff.price.gp, { parentKey: "label" })
		img(talentPanel.details.priceEff.price.gp, { parentKey: "canEfford" })

		div(talentPanel.details.priceEff.price, { parentKey: "divider" })
		span(talentPanel.details.priceEff.price.divider, { parentKey: "label", text: "/" })

		div(talentPanel.details.priceEff.price, { parentKey: "crystals", className: "currency" })
		img(talentPanel.details.priceEff.price.crystals, { parentKey: "icon", image: ICON.CRYSTAL })
		span(talentPanel.details.priceEff.price.crystals, { parentKey: "label" })
		img(talentPanel.details.priceEff.price.crystals, { parentKey: "canEfford" })

		talentPanel.update()

		talentPanelsData.set(talentId, {
			talent,
			talentPanel,
		})
	}
	
	GuildEvents.PremadeEvents.GuildPatch(({ key }) => {
		if (!["level", "gp", "crystals"].includes(key)) return

		talentPanelsData.forEach(({ talentPanel }) => {
			if (!talentPanel || !talentPanel.IsValid()) return
			talentPanel.update()
		})

		if (selectedTalent)
			showTalent(selectedTalent)
	}, talentsTab)

	GuildEvents.PremadeEvents.TalentPatch(({ talent }) => {
		const talentPanelData = talentPanelsData.get(talent.id)
		if (!talentPanelData) return
		
		const talentPanel = talentPanelData.talentPanel
		if (!talentPanel || !talentPanel.IsValid()) return

		talentPanel.update()
	}, talentsTab)

	/**
	 * @type {Talent}
	 */
	let selectedTalent

	/**
	 * @param {Talent} talent
	 */
	function showTalent(talent) {
		selectedTalent = talent

		const talentId = talent.id

		const { isMaxed, requiredLevelToUpgrade, isRequiredLevelMet, priceGP, canEffordForGP, priceCrystals, canEffordForCrystals } = talent

		talentsTab.right.header.icon.SetImage(talent.image)

		talentsTab.right.header.nameDesc.name.text = talent.name
		talentsTab.right.header.nameDesc.desc.text = talent.description

		if (isMaxed) {
			talentsTab.right.maxed.visible = true
			talentsTab.right.progression.visible = false
			talentsTab.right.requirements.visible = false
			talentsTab.right.down.shop.visible = false
			talentsTab.right.down.buttons.visible = false
		} else {
			talentsTab.right.maxed.visible = false
			talentsTab.right.progression.visible = true

			const currentLevel = talent.level

			talentsTab.right.progression.header.percent.inner.text = talent.isGuildPower
				? "∞"
				: `${Math.floor(currentLevel / talent.maxLevel * 100)}%`

			talentsTab.right.progression.levels.current.level.text = $.Localize("#guild_talents_progress_level").replace("{VALUE}", currentLevel)
			talentsTab.right.progression.levels.current.value.text = talent.formattedCurrentValue

			talentsTab.right.progression.levels.next.level.text = $.Localize("#guild_talents_progress_level").replace("{VALUE}", currentLevel + 1)
			talentsTab.right.progression.levels.next.value.text = talent.formattedNextValue

			if (requiredLevelToUpgrade === 0) {
				talentsTab.right.requirements.visible = false
			} else {
				talentsTab.right.requirements.visible = true

				talentsTab.right.requirements.SetHasClass("met", isRequiredLevelMet)

				talentsTab.right.requirements.level.icon.SetImage(ImageUtils.resolve(isRequiredLevelMet ? CHECK_SYMBOL.YES : CHECK_SYMBOL.NO))
				talentsTab.right.requirements.level.required.value.text = requiredLevelToUpgrade
			}

			talentsTab.right.down.buttons.visible = true

			if (priceGP === 0) {
				talentsTab.right.down.buttons.gp.visible = false
			} else {
				talentsTab.right.down.buttons.gp.visible = true

				talentsTab.right.down.buttons.gp.enabled = GUILD.me.can("UpgradeTalentsForGP") && isRequiredLevelMet && canEffordForGP
				talentsTab.right.down.buttons.gp.wrapper.label.text = formatNumber(priceGP)
			}

			if (priceCrystals === 0) {
				talentsTab.right.down.buttons.crystals.visible = false
			} else {
				talentsTab.right.down.buttons.crystals.visible = true

				talentsTab.right.down.buttons.crystals.enabled = GUILD.me.can("UpgradeTalentsForCrystals") && isRequiredLevelMet && canEffordForCrystals
				talentsTab.right.down.buttons.crystals.wrapper.label.text = formatNumber(priceCrystals)
			}

			const { me } = GUILD

			talentsTab.right.down.shop.visible = !(isMaxed || (isRequiredLevelMet && (canEffordForGP || canEffordForCrystals))) && (me.can("UpgradeTalentsForGP") || me.can("UpgradeTalentsForCrystals"))

			talentsTab.right.down.buttons.gp.SetHasClass("need-margin", talentsTab.right.down.buttons.gp.visible && talentsTab.right.down.buttons.crystals.visible)
		}
	}

	div(talentsTab, { parentKey: "right" })

	div(talentsTab.right, { parentKey: "header" })

	img(talentsTab.right.header, { parentKey: "icon", image: ImageUtils.resolve("🔍") })

	div(talentsTab.right.header, { parentKey: "nameDesc" })
	span(talentsTab.right.header.nameDesc, { parentKey: "name" })
	span(talentsTab.right.header.nameDesc, { parentKey: "desc", html: true })

	div(talentsTab.right, { parentKey: "maxed" })

	img(talentsTab.right.maxed, { parentKey: "icon", image: ImageUtils.resolve("⭐") })
	span(talentsTab.right.maxed, { parentKey: "label", text: "#guild_talents_max_level_reached" })

	div(talentsTab.right, { parentKey: "progression" })

	div(talentsTab.right.progression, { parentKey: "header" })

	span(talentsTab.right.progression.header, { parentKey: "title", text: "#guild_talents_progress" })
	div(talentsTab.right.progression.header, { parentKey: "percent" })
	span(talentsTab.right.progression.header.percent, { parentKey: "inner", text: "58%" })

	div(talentsTab.right.progression, { parentKey: "levels" })

	div(talentsTab.right.progression.levels, { parentKey: "current", className: "level" })
	span(talentsTab.right.progression.levels.current, { parentKey: "title", text: "#guild_talents_value_current" })
	span(talentsTab.right.progression.levels.current, { parentKey: "level" })
	span(talentsTab.right.progression.levels.current, { parentKey: "value" })

	div(talentsTab.right.progression.levels, { parentKey: "arrow" })
	img(talentsTab.right.progression.levels.arrow, { parentKey: "inner", image: ICON.GOLD_ARROW })

	div(talentsTab.right.progression.levels, { parentKey: "next", className: "level" })
	span(talentsTab.right.progression.levels.next, { parentKey: "title", text: "#guild_talents_value_next" })
	span(talentsTab.right.progression.levels.next, { parentKey: "level" })
	span(talentsTab.right.progression.levels.next, { parentKey: "value" })

	div(talentsTab.right, { parentKey: "requirements" })

	div(talentsTab.right.requirements, { parentKey: "level" })

	img(talentsTab.right.requirements.level, { parentKey: "icon", image: CHECK_SYMBOL.YES })

	div(talentsTab.right.requirements.level, { parentKey: "required" })
	span(talentsTab.right.requirements.level.required, { parentKey: "label", text: "#guild_talents_required_level" })
	span(talentsTab.right.requirements.level.required, { parentKey: "value" })

	div(talentsTab.right, { parentKey: "down" })

	const switchToShopTab = parent.GetParent().topNav.navTabButtons["shop"].onLeftClick

	btn(talentsTab.right.down, { parentKey: "shop", onLeftClick: () => switchToShopTab() })
	div(talentsTab.right.down.shop, { parentKey: "wrapper" })
	img(talentsTab.right.down.shop.wrapper, { parentKey: "icon", image: ImageUtils.resolve("🛒") })
	span(talentsTab.right.down.shop.wrapper, { parentKey: "label", text: "#guild_talents_open_shop" })

	div(talentsTab.right.down, { parentKey: "buttons" })

	btn(talentsTab.right.down.buttons, { parentKey: "gp", className: "button" })
	div(talentsTab.right.down.buttons.gp, { parentKey: "wrapper" })
	img(talentsTab.right.down.buttons.gp.wrapper, { parentKey: "icon", image: ICON.GP })
	span(talentsTab.right.down.buttons.gp.wrapper, { parentKey: "label" })
	talentsTab.right.down.buttons.gp.onLeftClick = () => {
		GameEvents.SendCustomGameEventToServer("Guild:UpgradeTalent", { talentId: selectedTalent.id, currency: "gp" })
	}

	btn(talentsTab.right.down.buttons, { parentKey: "crystals", className: "button" })
	div(talentsTab.right.down.buttons.crystals, { parentKey: "wrapper" })
	img(talentsTab.right.down.buttons.crystals.wrapper, { parentKey: "icon", image: ICON.CRYSTAL })
	span(talentsTab.right.down.buttons.crystals.wrapper, { parentKey: "label" })
	talentsTab.right.down.buttons.crystals.onLeftClick = () => {
		GameEvents.SendCustomGameEventToServer("Guild:UpgradeTalent", { talentId: selectedTalent.id, currency: "crystals" })
	}

	GuildEvents.PremadeEvents.TalentPatch(({ talent }) => {
		if (!selectedTalent || selectedTalent !== talent) return

		showTalent(talent)
	}, talentsTab)

	function filterTalents() {
		talentPanelsData.forEach(({ talentPanel }) => {
			talentPanel.visible = true
		})

		const searchText = (talentsTab.left.search.textEntry.input.text ?? "").trim().toLowerCase()
		if (searchText) {
			talentPanelsData.forEach(({ talentPanel, talent }) => {
				if (!talentPanel.visible)
					return

				talentPanel.visible = talent.name.toLowerCase().includes(searchText) || talent.description.toLowerCase().includes(searchText)
			})
		}
	}

	talentsTab.left.search.textEntry.onChange = () => {
		filterTalents()
	}

	showTalent(talentPanelsData.first().talent)

	return talentsTab
}