--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function ShopTab(parent) {
	const shopTab = div(parent, { className: "shop-tab" })

	div(shopTab, { parentKey: "header" })

	div(shopTab.header, { parentKey: "labels" })

	div(shopTab.header.labels, { parentKey: "primary" })
	img(shopTab.header.labels.primary, { parentKey: "icon", image: ImageUtils.resolve("🏪") })
	span(shopTab.header.labels.primary, { parentKey: "label", text: "#guild_shop_header_primary_text" })

	span(shopTab.header.labels, { parentKey: "secondary", text: "#guild_shop_header_secondary_text" })

	div(shopTab.header, { parentKey: "balance" })
	shopTab.header.balance.update = function () {
		shopTab.header.balance.gp.top.right.value.text = formatNumber(GUILD.gp)
		shopTab.header.balance.crystals.top.right.value.text = formatNumber(GUILD.crystals)
	}

	GuildEvents.PremadeEvents.GuildPatch(({ key }) => {
		if (!["gp", "crystals"].includes(key)) return

		shopTab.header.balance.update()
	}, shopTab)

	div(shopTab.header.balance, { parentKey: "crystals", className: "currency" })
	div(shopTab.header.balance.crystals, { parentKey: "top" })
	img(shopTab.header.balance.crystals.top, { parentKey: "icon", image: ICON.CRYSTAL })
	div(shopTab.header.balance.crystals.top, { parentKey: "right" })
	span(shopTab.header.balance.crystals.top.right, { parentKey: "title", text: "#guild_shop_crystals" })
	span(shopTab.header.balance.crystals.top.right, { parentKey: "value" })

	div(shopTab.header.balance.crystals, { parentKey: "bottom" })
	textEntry(shopTab.header.balance.crystals.bottom, { parentKey: "textEntry", placeholder: "#guild_shop_donate_placeholder", textMode: "numeric", maxChars: 10 })
	btn(shopTab.header.balance.crystals.bottom, { parentKey: "donate", text: "#guild_shop_donate" })
	const donateCrystals = () => {
		const crystalsCount = parseNumber(shopTab.header.balance.crystals.bottom.textEntry.input.text)
		if (!crystalsCount) return

		shopTab.header.balance.crystals.bottom.textEntry.input.text = ""

		GameEvents.SendCustomGameEventToServer("Guild:ShopDonate", { amount: crystalsCount })
	}
	shopTab.header.balance.crystals.bottom.donate.onLeftClick = donateCrystals
	shopTab.header.balance.crystals.bottom.textEntry.onInputSubmit = donateCrystals

	div(shopTab.header.balance, { parentKey: "gp", className: "currency" })
	div(shopTab.header.balance.gp, { parentKey: "top" })
	img(shopTab.header.balance.gp.top, { parentKey: "icon", image: ICON.GP })
	div(shopTab.header.balance.gp.top, { parentKey: "right" })
	span(shopTab.header.balance.gp.top.right, { parentKey: "title", text: "#guild_shop_gp" })
	span(shopTab.header.balance.gp.top.right, { parentKey: "value" })

	shopTab.header.balance.update()

	divbtn(shopTab, { parentKey: "list" })

	/**
	 * @type {Collection<string, Panel>}
	 */
	const servicePanels = new Collection()

	for (const [serviceId, service] of GUILD.services.cache) {
		const servicePanel = divbtn(shopTab.list, { className: "service" })
		servicePanel.update = function () {
			let disabled = false

			if (serviceId === "discord_guild_role") {
				const leaderMember = GUILD.members.cache.find((member) => member.role.isLeader)
				if (!leaderMember || !leaderMember.discordId) {
					disabled = true
				}
			}

			if (!service.price.crystals) {
				servicePanel.inner.details.bottom.defaultPrice.crystals.visible = false
			} else {
				servicePanel.inner.details.bottom.defaultPrice.crystals.visible = true

				servicePanel.inner.details.bottom.defaultPrice.crystals.value.text = formatNumber(service.price.crystals)
			}

			if (!service.price.gp) {
				servicePanel.inner.details.bottom.defaultPrice.gp.visible = false
			} else {
				servicePanel.inner.details.bottom.defaultPrice.gp.visible = true

				servicePanel.inner.details.bottom.defaultPrice.gp.value.text = formatNumber(service.price.gp)
			}

			servicePanel.inner.details.bottom.defaultPrice.or.visible = service.price.crystals && service.price.gp

			if (!service.hasDiscount) {
				servicePanel.inner.details.bottom.defaultPrice.line.visible = false
				servicePanel.inner.details.bottom.discountPrice.visible = false
			} else {
				servicePanel.inner.details.bottom.defaultPrice.line.visible = true
				servicePanel.inner.details.bottom.discountPrice.visible = true

				const priceCrystals = service.discountPrice.crystals
				const priceGP = service.discountPrice.gp

				if (!priceCrystals) {
					servicePanel.inner.details.bottom.discountPrice.crystals.visible = false
				} else {
					servicePanel.inner.details.bottom.discountPrice.crystals.visible = true

					servicePanel.inner.details.bottom.discountPrice.crystals.value.text = formatNumber(priceCrystals)
					servicePanel.inner.details.bottom.discountPrice.crystals.discountValue.text = `(-${Math.ceil(service.discount)}%)`
				}

				if (!priceGP) {
					servicePanel.inner.details.bottom.discountPrice.gp.visible = false
				} else {
					servicePanel.inner.details.bottom.discountPrice.gp.visible = true

					servicePanel.inner.details.bottom.discountPrice.gp.value.text = formatNumber(priceGP)
					servicePanel.inner.details.bottom.discountPrice.gp.discountValue.text = `(-${Math.ceil(service.discount)}%)`
				}

				servicePanel.inner.details.bottom.discountPrice.or.visible = service.price.crystals && service.price.gp
			}

			if (!service.hasEnoughCurrency) {
				disabled = true

				servicePanel.inner.details.bottom.buy.label.text = $.Localize("#guild_shop_not_enough_money")
			}

			const requiredLevel = service.requiredLevel

			if (!requiredLevel) {
				servicePanel.inner.details.bottom.levelRequirement.visible = false
			} else {
				servicePanel.inner.details.bottom.levelRequirement.visible = true

				servicePanel.inner.details.bottom.levelRequirement.text = $.Localize("#guild_shop_requires_level").replace("{VALUE}", requiredLevel)

				if (GUILD.level >= requiredLevel) {
					servicePanel.inner.details.bottom.levelRequirement.SetHasClass("met", true)
				} else {
					servicePanel.inner.details.bottom.levelRequirement.SetHasClass("met", false)

					disabled = true

					servicePanel.inner.details.bottom.buy.label.text = $.Localize("#guild_shop_requirement_not_met")
				}
			}

			if (service.isInfinityStock) {
				servicePanel.inner.details.bottom.stock.visible = false
			} else {
				servicePanel.inner.details.bottom.stock.visible = true

				const remainingCount = Math.max(0, service.stock - service.purchases)

				if (remainingCount > 0) {
					servicePanel.inner.details.bottom.stock.SetHasClass("out", false)
				} else {
					disabled = true

					servicePanel.inner.details.bottom.buy.label.text = $.Localize("#guild_shop_out_of_stock")

					servicePanel.inner.details.bottom.stock.SetHasClass("out", true)
				}

				servicePanel.inner.details.bottom.stock.text = $.Localize("#guild_shop_remaining").replace("{VALUE}", remainingCount)
			}

			if (disabled) {
				this.SetHasClass("disabled", true)

				servicePanel.inner.details.bottom.buy.enabled = false
			} else {
				this.SetHasClass("disabled", false)

				servicePanel.inner.details.bottom.buy.enabled = me.can("BuyServicesForGP") || me.can("BuyServicesForCrystals")
				servicePanel.inner.details.bottom.buy.label.text = $.Localize("#guild_shop_buy")
			}
		}

		div(servicePanel, { parentKey: "inner", className: service.rarity })

		div(servicePanel.inner, { parentKey: "mark", className: service.rarity })

		div(servicePanel.inner, { parentKey: "details" })

		div(servicePanel.inner.details, { parentKey: "top" })

		img(servicePanel.inner.details.top, { parentKey: "icon", className: service.rarity, image: service.image })
		span(servicePanel.inner.details.top, { parentKey: "name", text: service.name })
		span(servicePanel.inner.details.top, { parentKey: "desc", text: service.description })

		div(servicePanel.inner.details, { parentKey: "bottom" })

		div(servicePanel.inner.details.bottom, { parentKey: "line" })

		for (const priceCategory of ["defaultPrice", "discountPrice"]) {
			const pricePanel = div(servicePanel.inner.details.bottom, { parentKey: priceCategory })

			div(pricePanel, { parentKey: "crystals", className: "currency" })
			img(pricePanel.crystals, { parentKey: "icon", image: ICON.CRYSTAL })
			span(pricePanel.crystals, { parentKey: "value" })
			if (priceCategory === "discountPrice")
				span(pricePanel.crystals, { parentKey: "discountValue" })

			span(pricePanel, { parentKey: "or", text: "#guild_shop_or" })

			div(pricePanel, { parentKey: "gp", className: "currency" })
			img(pricePanel.gp, { parentKey: "icon", image: ICON.GP })
			span(pricePanel.gp, { parentKey: "value" })
			if (priceCategory === "discountPrice")
				span(pricePanel.gp, { parentKey: "discountValue" })

			div(pricePanel, { parentKey: "line" }).visible = false
		}

		span(servicePanel.inner.details.bottom, { parentKey: "levelRequirement" })
		span(servicePanel.inner.details.bottom, { parentKey: "stock" })

		const { me } = GUILD

		btn(servicePanel.inner.details.bottom, { parentKey: "buy", text: true, onLeftClick: () => openBuyServiceModal(service) })

		servicePanel.update()

		servicePanels.set(serviceId, servicePanel)
	}

	GuildEvents.PremadeEvents.GuildPatch(({ key }) => {
		if (!["level", "gp", "crystals"].includes(key)) return

		servicePanels.forEach((servicePanel) => {
			if (!servicePanel || !servicePanel.IsValid()) return

			servicePanel.update()
		})
	}, shopTab)

	GuildEvents.PremadeEvents.ServicePatch(({ service }) => {
		const servicePanel = servicePanels.get(service.id)
		if (!servicePanel || !servicePanel.IsValid()) return

		servicePanel.update()
	}, shopTab)

	return shopTab
}