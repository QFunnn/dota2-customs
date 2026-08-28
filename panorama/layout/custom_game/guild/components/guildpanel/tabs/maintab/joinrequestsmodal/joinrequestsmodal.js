--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function openJoinRequestsModal() {
	const modal = openModal("join-requests")
	if (!modal) return

	const { joinRequests } = GUILD

	div(modal, { parentKey: "header" })

	img(modal.header, { parentKey: "icon", image: ImageUtils.resolve("📨") })
	span(modal.header, { parentKey: "label", text: "#guild_join_requests_title" })
	btn(modal.header, { parentKey: "close", onLeftClick: () => modal.close() })
	div(modal.header.close, { parentKey: "icon" })

	div(modal, { className: "line" })

	/**
	 * @type {Collection<string, Panel>}
	 */
	const requestsRows = new Collection()

	divbtn(modal, { parentKey: "list" })
	modal.list.fill = () => {
		if (!modal.list.IsValid()) return

		requestsRows.clear()
		modal.list.RemoveAndDeleteChildren()

		joinRequests.cache.forEach((joinRequest) => {
			const requestRow = divbtn(modal.list, { className: "request" })

			span(requestRow, { parentKey: "status" })
			requestRow.status.visible = false

			playerAvatar(requestRow, { parentKey: "avatar", steamId: joinRequest.sid64 })

			div(requestRow, { parentKey: "nameLevelTime" })
			playerName(requestRow.nameLevelTime, { parentKey: "name", steamId: joinRequest.sid64 })
			div(requestRow.nameLevelTime, { parentKey: "levelTime" })
			span(requestRow.nameLevelTime.levelTime, { parentKey: "level", text: $.Localize("#guild_join_requests_player_level").replace("{VALUE}", joinRequest.level) })
			span(requestRow.nameLevelTime.levelTime, { parentKey: "dot", text: "•" })
			span(requestRow.nameLevelTime.levelTime, { parentKey: "time", text: joinRequest.formattedTimestamp })

			const guildIsFull = GUILD.isFull

			div(requestRow, { parentKey: "buttons" })

			btn(requestRow.buttons, { parentKey: "accept", className: "button", enabled: !guildIsFull })
			img(requestRow.buttons.accept, { parentKey: "icon", image: ImageUtils.resolve("✔") })
			requestRow.buttons.accept.onLeftClick = () => {
				requestRow.buttons.accept.onLeftClick = undefined
				GameEvents.SendCustomGameEventToServer("Guild:ManageJoinRequest", { id: joinRequest.id, accept: true })
			}
			if (guildIsFull) {
				const acceptButton = requestRow.buttons.accept

				acceptButton.SetPanelEvent("onmouseover", () => {
					$.DispatchEvent(
						"DOTAShowTextTooltip",
						acceptButton,
						$.Localize("#guild_join_requests_guild_is_full")
					)
				})
				acceptButton.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))
			}

			btn(requestRow.buttons, { parentKey: "reject", className: "button" })
			img(requestRow.buttons.reject, { parentKey: "icon", image: ImageUtils.resolve("❌") })
			requestRow.buttons.reject.onLeftClick = () => {
				requestRow.buttons.reject.onLeftClick = undefined
				GameEvents.SendCustomGameEventToServer("Guild:ManageJoinRequest", { id: joinRequest.id, accept: false })
			}

			requestsRows.set(joinRequest.id, requestRow)
		})

		if (requestsRows.size === 0) {
			div(modal.list, { parentKey: "empty" })
			span(modal.list.empty, { parentKey: "label", text: "#guild_empty" })
		}
	}
	modal.list.fill()

	GuildEvents.PremadeEvents.JoinRequestsUpdate(() => {
		modal.list.fill()
	}, modal)

	GuildEvents.PremadeEvents.AcceptJoinRequest(({ id }) => {
		const requestRow = requestsRows.get(id)
		if (!requestRow) return

		safeDeletePanel(requestRow.buttons)

		requestRow.status.visible = true

		requestRow.status.SetHasClass("accepted", true)
		requestRow.status.text = $.Localize("#guild_join_requests_player_accepted")
	}, modal)
	GuildEvents.PremadeEvents.RejectJoinRequest(({ id }) => {
		const requestRow = requestsRows.get(id)
		if (!requestRow) return

		safeDeletePanel(requestRow.buttons)

		requestRow.status.visible = true

		requestRow.status.SetHasClass("rejected", true)
		requestRow.status.text = $.Localize("#guild_join_requests_player_rejected")
	}, modal)
	GuildEvents.PremadeEvents.InvalidJoinRequest(({ id }) => {
		const requestRow = requestsRows.get(id)
		if (!requestRow) return

		safeDeletePanel(requestRow.buttons)

		requestRow.status.visible = true

		requestRow.status.SetHasClass("invalid", true)
		requestRow.status.text = $.Localize("#guild_join_requests_player_invalid")
	}, modal)

	div(modal, { className: "line" })

	btn(modal, { parentKey: "update", text: "#guild_join_requests_update" })
	modal.update.onLeftClick = () => {
		if (!modal.IsValid()) return

		if (!joinRequests.requestUpdate()) return

		requestsRows.clear()
		modal.list.RemoveAndDeleteChildren()

		deleteChildByKey(modal.list, "loading")
		div(modal.list, { parentKey: "loading" })
		div(modal.list.loading, { parentKey: "inner" })
	}
}