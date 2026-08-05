--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {Service} service
 */
function openBuyServiceModal(service) {
	const modal = openModal("buy-service-confirm")
	if (!modal) return

	span(modal, { parentKey: "title", text: "#guild_shop_modal_title" })

	div(modal, { parentKey: "service" })
	img(modal.service, { parentKey: "icon", className: service.rarity, image: service.image })
	span(modal.service, { parentKey: "name", text: service.name })
	span(modal.service, { parentKey: "desc", text: service.description })

	div(modal, { parentKey: "currencies" })

	/** @type {Panel} */
	let activeCurrencyButton,
		/** @type {"crystals" | "gp"} */
		selectedCurrency

	/**
	 * @param {"crystals" | "gp"} currency
	 */
	function onCurrencyClickFactory(currency) {
		/**
		 * @this {Panel}
		 */
		return function () {
			if (activeCurrencyButton) {
				activeCurrencyButton.SetHasClass("selected", false)
			} else {
				const confirmButton = modal.buttons.confirm

				confirmButton.filler.SetHasClass("fill", true)

				$.Schedule(0.7, function () {
					if (!confirmButton.IsValid())
						return

					confirmButton.SetHasClass("filled", true)

					safeDeletePanel(confirmButton.filler)

					confirmButton.onLeftClick = () => {
						modal.close()

						GameEvents.SendCustomGameEventToServer("Guild:BuyService", { serviceId: service.id, currency: selectedCurrency, locale: $.Language() })
					}
				})
			}

			activeCurrencyButton = this
			activeCurrencyButton.SetHasClass("selected", true)

			selectedCurrency = currency
		}
	}

	const price = service.finalPrice

	if (price.crystals) {
		btn(modal.currencies, { parentKey: "crystals", className: "currency" })
		div(modal.currencies.crystals, { parentKey: "wrapper" })
		img(modal.currencies.crystals.wrapper, { parentKey: "icon", image: ICON.CRYSTAL })
		span(modal.currencies.crystals.wrapper, { parentKey: "value", text: price.crystals })
		modal.currencies.crystals.enabled = GUILD.me.can("BuyServicesForCrystals") && GUILD.crystals >= price.crystals
		modal.currencies.crystals.onLeftClick = onCurrencyClickFactory("crystals")
	}

	if (price.gp) {
		btn(modal.currencies, { parentKey: "gp", className: "currency" })
		div(modal.currencies.gp, { parentKey: "wrapper" })
		img(modal.currencies.gp.wrapper, { parentKey: "icon", image: ICON.GP })
		span(modal.currencies.gp.wrapper, { parentKey: "value", text: price.gp })
		modal.currencies.gp.enabled = GUILD.me.can("BuyServicesForGP") && GUILD.gp >= price.gp
		modal.currencies.gp.onLeftClick = onCurrencyClickFactory("gp")
	}

	div(modal, { parentKey: "buttons" })

	btn(modal.buttons, { parentKey: "confirm", className: "button" })
	div(modal.buttons.confirm, { parentKey: "filler" })
	span(modal.buttons.confirm, { parentKey: "label", text: "#guild_shop_modal_confirm" })

	btn(modal.buttons, { parentKey: "cancel", className: "button", text: "#guild_shop_modal_canel" })
	modal.buttons.cancel.onLeftClick = () => {
		modal.close()
	}
}