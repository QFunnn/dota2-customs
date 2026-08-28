--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function EventsTab(parent) {
	const eventsTab = div(parent, { className: "events-tab" })

	div(eventsTab, { parentKey: "header" })

	div(eventsTab.header, { parentKey: "labels" })

	div(eventsTab.header.labels, { parentKey: "primary" })
	img(eventsTab.header.labels.primary, { parentKey: "icon", image: ImageUtils.resolve("🎟️") })
	span(eventsTab.header.labels.primary, { parentKey: "label", text: "#guild_events_header_primary_text" })

	span(eventsTab.header.labels, { parentKey: "secondary", text: "#guild_events_header_secondary_text" })

	divbtn(eventsTab, { parentKey: "list" })

	/**
	 * @type {Collection<string, Panel>}
	 */
	const ticketPanels = new Collection()

	GUILD.eventTickets.cache.forEach((ticket) => {
		const ticketPanel = div(eventsTab.list, { className: "ticket" })
		ticketPanel.update = function () {
			ticketPanel.inner.bottom.buy.current.text = $.Localize("#guild_events_in_stock").replace("{VALUE}", ticket.amount)

			for (const currency of ["crystals", "gp"]) {
				const currencyPanel = ticketPanel.inner.bottom.buy.buttons[currency]
				if (!currencyPanel) continue

				currencyPanel.enabled = (me.isLeader || (me.isDeputy && GUILD.deputyPermissions.has(currency === "crystals" ? "BuyEventTicketsForCrystals" : "BuyEventTicketsForGP")))
					&& GUILD[currency] >= ticket.price[currency]
			}
						
			switch (ticket.id) {
				case "guild_farm": {
					const playersInGame = []

					let allPlayersIsMembers = true
					let allHeroesAre30Level = true

					for (let i = 0; i <= 4; i++) {
						const playerInfo = Game.GetPlayerInfo(i)
						if (!playerInfo)
							break

						playersInGame.push(playerInfo.player_steamid)

						if (!GUILD.members.cache.get(playerInfo.player_steamid))
							allPlayersIsMembers = false

						if (Players.GetLevel(i) < 30)
							allHeroesAre30Level = false
					}

					const enabled = allPlayersIsMembers && allHeroesAre30Level && playersInGame.length >= 5 && ticket.amount > 0

					ticketPanel.inner.bottom.use.button.enabled = enabled
					break
				}
				case "solo_farm": {
					ticketPanel.inner.bottom.use.button.enabled = Players.GetLevel(Players.GetLocalPlayer()) >= 30 && ticket.amount > 0
					break
				}
			}
		}

		div(ticketPanel, { parentKey: "inner" })

		div(ticketPanel.inner, { parentKey: "top" })

		div(ticketPanel.inner.top, { parentKey: "left" })

		img(ticketPanel.inner.top.left, { parentKey: "icon", image: ticket.image })
		div(ticketPanel.inner.top.left, { parentKey: "price" })

		for (const currency of ["crystals", "gp"]) {
			const currencyPrice = ticket.price[currency]
			if (!currencyPrice) continue

			div(ticketPanel.inner.top.left.price, { parentKey: currency, className: "currency" })

			img(ticketPanel.inner.top.left.price[currency], { parentKey: "icon", image: ICON[currency.toUpperCase()] })
			span(ticketPanel.inner.top.left.price[currency], { parentKey: "label", text: formatNumber(currencyPrice) })
		}

		div(ticketPanel.inner.top, { parentKey: "line" })

		div(ticketPanel.inner.top, { parentKey: "center" })

		span(ticketPanel.inner.top.center, { parentKey: "title", text: ticket.name })
		span(ticketPanel.inner.top.center, { parentKey: "desc", text: ticket.description })

		switch (ticket.id) {
			case "guild_farm": {
				div(ticketPanel.inner.top.center, { parentKey: "guildOnly" })

				span(ticketPanel.inner.top.center.guildOnly, { parentKey: "label", text: $.Localize("#guild_events_full_guild_only") })
				span(ticketPanel.inner.top.center.guildOnly, { parentKey: "needPlayers", text: $.Localize("#guild_events_need_players").replace("{VALUE}", 5) })
				break
			}
			case "solo_farm": {
				span(ticketPanel.inner.top.center, { parentKey: "canSolo", text: "#guild_events_can_solo" })
				break
			}
		}

		div(ticketPanel.inner.top, { parentKey: "line" })

		div(ticketPanel.inner.top, { parentKey: "right" })

		img(ticketPanel.inner.top.right, { parentKey: "barcode", image: "guild/event_ticket_barcode.png" })

		div(ticketPanel.inner, { parentKey: "bottom" })

		div(ticketPanel.inner.bottom, { parentKey: "buy" })

		span(ticketPanel.inner.bottom.buy, { parentKey: "current", text: $.Localize("#guild_events_in_stock").replace("{VALUE}", ticket.amount) })

		div(ticketPanel.inner.bottom.buy, { parentKey: "buttons" })

		const { me } = GUILD

		for (const currency of ["crystals", "gp"]) {
			const currencyPrice = ticket.price[currency]
			if (!currencyPrice) continue

			btn(ticketPanel.inner.bottom.buy.buttons, {
				parentKey: currency,
				className: "currency",
				enabled: false,
				onLeftClick: () => {
					GameEvents.SendCustomGameEventToServer("Guild:BuyEventTicket", { ticketId: ticket.id, currency })
				},
			})

			img(ticketPanel.inner.bottom.buy.buttons[currency], { parentKey: "icon", image: ICON[currency.toUpperCase()] })
			span(ticketPanel.inner.bottom.buy.buttons[currency], { parentKey: "label", text: formatNumber(currencyPrice) })
		}

		btn(ticketPanel.inner.bottom, { parentKey: "use" })

		btn(ticketPanel.inner.bottom.use, {
			parentKey: "button",
			text: "#guild_events_use",
			onLeftClick: () => {
				GameEvents.SendCustomGameEventToServer("Guild:UseEventTicket", { ticketId: ticket.id })
			},
		})
		
		ticketPanel.update()

		ticketPanels.set(ticket.id, ticketPanel)
	})

	function updateLoop() {
		if (!eventsTab.IsValid()) return

		if (DotaHUD.IsWindowOpen("guild"))
			ticketPanels.forEach((ticketPanel) => {
				ticketPanel.update()
			})
		
		$.Schedule(5, updateLoop)
	}
	updateLoop()

	GuildEvents.PremadeEvents.EventTicketPatch(({ ticket }) => {
		const ticketPanel = ticketPanels.get(ticket.id)
		if (ticketPanel)
			ticketPanel.update()
	}, eventsTab)

	return eventsTab
}