--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function openGuildsList() {
	const hasGuild = GUILD.isValid

	const container = hasGuild
		? openModal("guilds-list")
		: divbtn(ROOT_MAIN_LAYER, { parentKey: "guildsList" })

	if (!container) return

	div(container, { parentKey: "header" })

	img(container.header, { parentKey: "icon", image: ImageUtils.resolve("🏰") })
	span(container.header, { parentKey: "label", text: "#guilds_list_header" })
	btn(container.header, {
		parentKey: "close", onLeftClick: () => {
			if (container.close) {
				container.close()
			} else {
				DotaHUD.WindowClose("guild")
			}
		}
	})
	div(container.header.close, { parentKey: "icon" })
	
	// Обработка нужна только в случае, если список гильдий открыт не в формате модального окна
	// т.к. модальные окна по умолчанию закрываются при клике вне панели
	if (!hasGuild)
		listenToMouseEvent((event, button) => {
			if (!container.IsValid()) return [true]
			if (!isLMBorRMB(event, button)) return
			if (openedModals.size > 1 || activeContextMenuLayer) return
			if (isCursorOverPanel(container)) return

			if (container.close) {
				container.close()
			} else {
				DotaHUD.WindowClose("guild")
			}
		})
	
	div(container, { className: "line" })

	div(container, { parentKey: "filters" })

	btn(container.filters, { parentKey: "update", text: "#guild_join_requests_update" })
	container.filters.update.onLeftClick = () => {
		if (!container.IsValid()) return

		if (!GUILDS.requestUpdate({
			"fromGuildsList": !hasGuild,
		})) return

		container.list.RemoveAndDeleteChildren()

		deleteChildByKey(container.list, "loading")
		div(container.list, { parentKey: "loading" })
		div(container.list.loading, { parentKey: "inner" })
	}

	div(container.filters, { parentKey: "search" })
	textEntry(container.filters.search, { parentKey: "textEntry", image: ImageUtils.resolve("🔍"), placeholder: "#guilds_list_text_area_placeholder", maxChars: 30 })
	container.filters.search.textEntry.onChange = () => {
		container.list.filterGuilds()
	}

	checkBox(container.filters, { parentKey: "notLocked", text: "#guilds_list_not_locked" })
	container.filters.notLocked.onChecked = () => {
		container.list.filterGuilds()
	}

	checkBox(container.filters, { parentKey: "notFull", text: "#guilds_list_not_full" })
	container.filters.notFull.onChecked = () => {
		container.list.filterGuilds()
	}

	div(container, { className: "line" })

	/** @type {Collection<string, { panel: Panel, guild: PartialGuild }>} */
	const guildPanelsData = new Collection()

	divbtn(container, { parentKey: "list" })
	container.list.fill = () => {
		if (!container.list.IsValid()) return

		container.list.RemoveAndDeleteChildren()

		GUILDS.cache.forEach((guild) => {
			const guildPanel = divbtn(container.list, { className: "guild" })

			div(guildPanel, { parentKey: "inner" })

			div(guildPanel.inner, { parentKey: "header" })

			div(guildPanel.inner.header, { parentKey: "avatar" })
			img(guildPanel.inner.header.avatar, { parentKey: "inner", image: guild.image })

			if (guild.place)
				img(guildPanel.inner.header.avatar, { parentKey: "medal", className: `place-${guild.place}`, image: ImageUtils.resolve(GUILDS_LIST_PLACE_ICON[guild.place]) })

			div(guildPanel.inner.header, { parentKey: "nameLocked" })
			span(guildPanel.inner.header.nameLocked, { parentKey: "name", text: guild.name })

			if (guild.isLocked) {
				div(guildPanel.inner.header.nameLocked, { parentKey: "locked" })
				img(guildPanel.inner.header.nameLocked.locked, { parentKey: "icon", image: ImageUtils.resolve("🔒") })
				span(guildPanel.inner.header.nameLocked.locked, { parentKey: "label", text: "#guilds_list_guild_closed" })
			}

			div(guildPanel.inner, { parentKey: "details" })

			div(guildPanel.inner.details, { parentKey: "level", className: "detail" })
			img(guildPanel.inner.details.level, { parentKey: "icon", image: ImageUtils.resolve("⬆️") })
			span(guildPanel.inner.details.level, { parentKey: "label", text: "#guilds_list_guild_level" })
			span(guildPanel.inner.details.level, { parentKey: "value", text: guild.level })

			div(guildPanel.inner.details, { className: "line" })

			div(guildPanel.inner.details, { parentKey: "members", className: "detail" })
			img(guildPanel.inner.details.members, { parentKey: "icon", image: ImageUtils.resolve("👥") })
			span(guildPanel.inner.details.members, { parentKey: "label", text: "#guilds_list_guild_members" })
			span(guildPanel.inner.details.members, { parentKey: "value", text: `${guild.membersCount} / ${guild.membersMax}` })

			div(guildPanel.inner.details, { className: "line" })

			div(guildPanel.inner.details, { parentKey: "merits", className: "detail" })
			img(guildPanel.inner.details.merits, { parentKey: "icon", image: ImageUtils.resolve("⭐") })
			span(guildPanel.inner.details.merits, { parentKey: "label", text: "#guilds_list_guild_merits" })
			span(guildPanel.inner.details.merits, { parentKey: "value", text: formatNumber(guild.merits) })

			div(guildPanel.inner, { parentKey: "description" })
			div(guildPanel.inner.description, { parentKey: "header" })
			img(guildPanel.inner.description.header, { parentKey: "icon", image: ImageUtils.resolve("📜") })
			span(guildPanel.inner.description.header, { parentKey: "label", text: "#guilds_list_guild_description" })
			div(guildPanel.inner.description, { parentKey: "line" })
			span(guildPanel.inner.description, { parentKey: "label", text: guild.description ?? "#guilds_list_guild_no_description" })

			if (guild.leader) {
				div(guildPanel.inner, { parentKey: "leader" })

				div(guildPanel.inner.leader, { parentKey: "header" })
				img(guildPanel.inner.leader.header, { parentKey: "icon", image: ImageUtils.resolve("👑") })
				span(guildPanel.inner.leader.header, { parentKey: "label", text: "#guilds_list_guild_leader" })

				div(guildPanel.inner.leader, { className: "line" })

				div(guildPanel.inner.leader, { parentKey: "player" })
				playerAvatar(guildPanel.inner.leader.player, { parentKey: "avatar", steamId: guild.leader })
				playerName(guildPanel.inner.leader.player, { parentKey: "name", steamId: guild.leader })
			}

			if (!hasGuild) {
				div(guildPanel.inner, { className: "line" })

				if (guild.isLocked) {
					btn(guildPanel.inner, { parentKey: "join", className: "disabled", enabled: false, text: "#guilds_list_guild_join_locked" })
				} else if (guild.isFull) {
					btn(guildPanel.inner, { parentKey: "join", className: "disabled", enabled: false, text: "#guilds_list_guild_join_is_full" })
				} else {
					btn(guildPanel.inner, { parentKey: "join", text: "#guilds_list_guild_join", onLeftClick: function () { GameEvents.SendCustomGameEventToServer("Guild:SendJoinRequest", { guildId: guild.id }) } })
				}
			}

			guildPanelsData.set(guild.id, { panel: guildPanel, guild })
		})

		container.list.updateGap()

		if (guildPanelsData.size === 0) {
			div(container.list, { parentKey: "empty" })
			span(container.list.empty, { parentKey: "label", text: "#guild_empty" })
		}
	}
	container.list.filterGuilds = () => {
		const notLockedOnly = container.filters.notLocked.isChecked()
		const notFullOnly = container.filters.notFull.isChecked()
		const searchText = (container.filters.search.textEntry.input.text ?? "").trim().toLowerCase()

		guildPanelsData.forEach(({ panel, guild }) => {
			panel.visible = (!notLockedOnly || !guild.isLocked)
				&& (!notFullOnly || !guild.isFull)
				&& (!searchText || guild.name.toLowerCase().includes(searchText))
				&& (!guild.isStealth || searchText === guild.name.toLowerCase())
		})

		container.list.updateGap()
	}
	container.list.updateGap = () => {
		let column = 0

		guildPanelsData.forEach(({ panel }) => {
			if (!panel.visible) {
				panel.style.paddingLeft = "0px"
				panel.style.paddingRight = "0px"
				return
			}

			switch (column) {
				case 0: {
					panel.style.paddingLeft = "0px"
					panel.style.paddingRight = "8px"
					break
				}
				case 1: {
					panel.style.paddingLeft = "4px"
					panel.style.paddingRight = "4px"
					break
				}
				case 2: {
					panel.style.paddingLeft = "8px"
					panel.style.paddingRight = "0px"
					break
				}
			}

			column = (column + 1) % 3
		})
	}

	GuildEvents.PremadeEvents.GuildsUpdate(() => {
		container.list.fill()
		container.list.filterGuilds()
	}, container)

	div(container, { className: "line" })

	div(container, { parentKey: "footer" })
	btn(container.footer, { parentKey: "create", enabled: !hasGuild, onLeftClick: () => openCreateGuildModal() })
	span(container.footer.create, { parentKey: "label", text: "#guilds_list_create_guild" })
	div(container.footer.create, { parentKey: "price" })
	img(container.footer.create.price, { parentKey: "icon", image: ICON.CRYSTAL })
	span(container.footer.create.price, { parentKey: "label", text: GUILD.createGuildPrice })

	container.filters.update.onLeftClick()

	return container
}