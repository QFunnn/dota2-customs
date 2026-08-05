--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {{member: Member, memberRow: Button}} MemberRowData
 * @typedef {Collection<string, MemberRowData>} MemberRowsData
 */

/**
 * @param {Panel} parent
 * @returns {Panel}
 */
function MainTab(parent) {
	const mainTab = div(parent, { className: "main-tab" })

	div(mainTab, { parentKey: "left" })

	divbtn(mainTab.left, { parentKey: "guild" })

	GuildEvents.PremadeEvents.GuildPatch(({ guild, key }) => {
		switch (key) {
			case "name": {
				mainTab.left.guild.details.general.nameLevel.name.text = guild.name
				break
			}
			case "level":
			case "exp": {
				mainTab.left.guild.details.general.nameLevel.level.text = $.Localize("#guild_level").replace("{VALUE}", formatNumber(guild.level))

				mainTab.left.guild.details.progress.inner.labels.current.text = guild.level
				mainTab.left.guild.details.progress.inner.labels.exp.text = `${guild.exp} / ${guild.expToNextLevel}`
				mainTab.left.guild.details.progress.inner.labels.next.text = guild.level + 1

				mainTab.left.guild.details.progress.inner.bar.filler.style.width = `${Math.floor(guild.exp / guild.expToNextLevel * 100)}%`
				break
			}
			case "merits": {
				mainTab.left.guild.details.merits.labels.value.text = formatNumber(guild.merits)
				break
			}
			case "description": {
				mainTab.left.guild.details.description.label.text = guild.description ?? $.Localize("#guild_no_description")
				break
			}
			case "expForLastDay": {
				mainTab.left.guild.details.statistics.exp.update()
				break
			}
			case "meritsForLastDay": {
				mainTab.left.guild.details.statistics.merits.update()
				break
			}
			default:
				break
		}
	}, mainTab)

	GuildEvents.PremadeEvents.MemberPatch(({ key }) => {
		switch (key) {
			case "status": {
				mainTab.left.guild.details.statistics.online.update()
				mainTab.left.guild.details.statistics.active.update()
				break
			}
			default:
				break
		}
	}, mainTab)

	div(mainTab.left.guild, { parentKey: "details" })
	div(mainTab.left.guild.details, { parentKey: "general" })
	div(mainTab.left.guild.details.general, { parentKey: "image" })
	img(mainTab.left.guild.details.general.image, { parentKey: "inner", image: GUILD.image })

	div(mainTab.left.guild.details.general, { parentKey: "nameLevel" })
	span(mainTab.left.guild.details.general.nameLevel, { parentKey: "name", text: GUILD.name })
	span(mainTab.left.guild.details.general.nameLevel, { parentKey: "level", text: $.Localize("#guild_level").replace("{VALUE}", formatNumber(GUILD.level)) })

	div(mainTab.left.guild.details, { parentKey: "progress" })
	div(mainTab.left.guild.details.progress, { parentKey: "inner" })
	div(mainTab.left.guild.details.progress.inner, { parentKey: "labels" })
	span(mainTab.left.guild.details.progress.inner.labels, { parentKey: "current", text: GUILD.level })
	span(mainTab.left.guild.details.progress.inner.labels, { parentKey: "exp", text: `${GUILD.exp} / ${GUILD.expToNextLevel}` })
	span(mainTab.left.guild.details.progress.inner.labels, { parentKey: "next", text: GUILD.level + 1 })

	div(mainTab.left.guild.details.progress.inner, { parentKey: "bar" })
	div(mainTab.left.guild.details.progress.inner.bar, { parentKey: "filler" })
	div(mainTab.left.guild.details.progress.inner.bar.filler, { parentKey: "animation" })
	mainTab.left.guild.details.progress.inner.bar.filler.style.width = `${Math.floor(GUILD.exp / GUILD.expToNextLevel * 100)}%`

	const boosterValue = GUILD.expBoosterValue

	div(mainTab.left.guild.details, { parentKey: "booster" })
	div(mainTab.left.guild.details.booster, { parentKey: "top" })
	img(mainTab.left.guild.details.booster.top, { parentKey: "icon", image: GUILD.services.cache.get("guild_exp_booster").image })
	span(mainTab.left.guild.details.booster.top, { parentKey: "expire" })
	div(mainTab.left.guild.details.booster.top, { parentKey: "value" })
	img(mainTab.left.guild.details.booster.top.value, { parentKey: "icon", image: ICON.EXP })
	span(mainTab.left.guild.details.booster.top.value, { parentKey: "label", text: `${Math.floor((1 + boosterValue) * 100)}%` })

	div(mainTab.left.guild.details.booster, { parentKey: "bar" })
	div(mainTab.left.guild.details.booster.bar, { parentKey: "filler" })
	div(mainTab.left.guild.details.booster.bar.filler, { parentKey: "animation" })

	mainTab.left.guild.details.booster.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent(
			"DOTAShowTextTooltip",
			mainTab.left.guild.details.booster,
			$.Localize("#guild_exp_booster").replace("{VALUE}", `<font color='#ffd700'>${Math.floor(boosterValue * 100)}%</font>`)
		)
	})
	mainTab.left.guild.details.booster.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))

	mainTab.left.guild.details.booster.update = function () {
		if (!this.IsValid()) return

		$.Schedule(0.2, function () {
			this.update()
		}.bind(this))

		if (!mainTab.visible) return

		const { booster } = GUILD

		if (!booster) {
			this.visible = false
			return
		}

		const leftTime = booster.expiresAt - Date.now()
		if (leftTime <= 0) {
			this.visible = false
			return
		}

		if (!this.visible)
			this.visible = true

		this.top.expire.text = GUILD.formatBoosterLeftTime(leftTime)

		const expirePct = Math.ceil(leftTime / Math.max(1, booster.expiresAt - booster.boughtAt) * 100)

		this.bar.filler.style.width = `${expirePct}%`
	}
	mainTab.left.guild.details.booster.update()

	div(mainTab.left.guild.details, { parentKey: "merits" })
	div(mainTab.left.guild.details.merits, { parentKey: "icon" })
	div(mainTab.left.guild.details.merits.icon, { parentKey: "pulse" })
	img(mainTab.left.guild.details.merits.icon, { parentKey: "inner", image: ICON.MERITS })
	div(mainTab.left.guild.details.merits, { parentKey: "labels" })
	span(mainTab.left.guild.details.merits.labels, { parentKey: "title", text: "#guild_stat_merits_total" })
	span(mainTab.left.guild.details.merits.labels, { parentKey: "value", text: formatNumber(GUILD.merits) })

	div(mainTab.left.guild.details, { parentKey: "description" })
	div(mainTab.left.guild.details.description, { parentKey: "header" })
	img(mainTab.left.guild.details.description.header, { parentKey: "icon", image: ImageUtils.resolve("📜") })
	span(mainTab.left.guild.details.description.header, { parentKey: "label", text: "#guild_description_title" })
	div(mainTab.left.guild.details.description, { parentKey: "line" })
	span(mainTab.left.guild.details.description, { parentKey: "label", text: GUILD.description ?? "#guild_no_description" })

	const guildStatistics = [
		{
			key: "online",
			icon: "👥",
			getValue: () => GUILD.members.cache.count(({ isOnline }) => isOnline),
			name: "#guild_current_online",
			hint: () => $.Localize("#guild_current_online_hint").replace("{VALUE}", GUILD.members.cache.size),
		},
		{
			key: "active",
			icon: "⚡",
			getValue: () => GUILD.members.cache.count(({ isActive }) => isActive),
			name: "#guild_stat_active",
			hint: (value) => $.Localize("#guild_stat_active_hint").replace("{VALUE}", Math.floor(value / GUILD.members.cache.size * 100)),
		},
		{
			key: "exp",
			image: ICON.EXP,
			getValue: () => formatNumber(GUILD.expForLastDay),
			name: "#guild_stat_exp",
			hint: () => $.Localize("#guild_stat_exp_hint"),
		},
		{
			key: "merits",
			image: ICON.MERITS,
			getValue: () => formatNumber(GUILD.meritsForLastDay),
			name: "#guild_stat_merits",
			hint: () => $.Localize("#guild_stat_merits_hint"),
		},
	]

	div(mainTab.left.guild.details, { parentKey: "statistics" })

	guildStatistics.forEach((statisticsPart) => {
		const value = statisticsPart.getValue()

		const statPanel = div(mainTab.left.guild.details.statistics, { parentKey: statisticsPart.key, className: "stat" })
		statPanel.update = () => {
			const value = statisticsPart.getValue()

			statPanel.labels.value.text = value
			statPanel.labels.hint.text = statisticsPart.hint(value)
		}

		div(statPanel, { parentKey: "icon" })
		div(statPanel.icon, { parentKey: "pulse" })
		img(statPanel.icon, { parentKey: "inner", image: statisticsPart.image ?? ImageUtils.resolve(statisticsPart.icon) })
		div(statPanel, { parentKey: "labels" })
		span(statPanel.labels, { parentKey: "value", text: value })
		span(statPanel.labels, { parentKey: "name", text: statisticsPart.name })
		span(statPanel.labels, { parentKey: "hint", text: statisticsPart.hint(value) })
	})

	div(mainTab.left.guild, { parentKey: "actions" })

	btn(mainTab.left.guild.actions, { parentKey: "guildsList", className: "action", onLeftClick: () => openGuildsList() })
	div(mainTab.left.guild.actions.guildsList, { parentKey: "wrapper" })
	img(mainTab.left.guild.actions.guildsList.wrapper, { parentKey: "icon", image: ImageUtils.resolve("🏰") })
	span(mainTab.left.guild.actions.guildsList.wrapper, { parentKey: "label", text: "#guild_action_guilds_list" })

	if (GUILD.me.can("ManageJoinRequests")) {
		btn(mainTab.left.guild.actions, { parentKey: "joinRequests", className: "action", onLeftClick: () => openJoinRequestsModal() })
		div(mainTab.left.guild.actions.joinRequests, { parentKey: "wrapper" })
		img(mainTab.left.guild.actions.joinRequests.wrapper, { parentKey: "icon", image: ImageUtils.resolve("📨") })
		span(mainTab.left.guild.actions.joinRequests.wrapper, { parentKey: "label", text: "#guild_action_join_requests" })
		span(mainTab.left.guild.actions.joinRequests, { parentKey: "count", text: GUILD.joinRequests.cache.size })
			.visible = false

		GuildEvents.PremadeEvents.JoinRequestsUpdate(({ joinRequests }) => {
			if (joinRequests.size === 0)
				mainTab.left.guild.actions.joinRequests.count.visible = false
			else {
				mainTab.left.guild.actions.joinRequests.count.visible = true
				mainTab.left.guild.actions.joinRequests.count.text = joinRequests.size
			}
		}, mainTab)
		GuildEvents.PremadeEvents.AcceptJoinRequest(() => {
			const size = GUILD.joinRequests.cache.size
			if (size === 0)
				mainTab.left.guild.actions.joinRequests.count.visible = false
			else {
				mainTab.left.guild.actions.joinRequests.count.visible = true
				mainTab.left.guild.actions.joinRequests.count.text = size
			}
		}, mainTab)
		GuildEvents.PremadeEvents.RejectJoinRequest(() => {
			const size = GUILD.joinRequests.cache.size
			if (size === 0)
				mainTab.left.guild.actions.joinRequests.count.visible = false
			else {
				mainTab.left.guild.actions.joinRequests.count.visible = true
				mainTab.left.guild.actions.joinRequests.count.text = size
			}
		}, mainTab)
		GuildEvents.PremadeEvents.InvalidJoinRequest(() => {
			const size = GUILD.joinRequests.cache.size
			if (size === 0)
				mainTab.left.guild.actions.joinRequests.count.visible = false
			else {
				mainTab.left.guild.actions.joinRequests.count.visible = true
				mainTab.left.guild.actions.joinRequests.count.text = size
			}
		}, mainTab)
	}

	if (GUILD.me.isLeader) {
		btn(mainTab.left.guild.actions, { parentKey: "settings", className: "action", onLeftClick: () => openGuildSettingsModal() })
		div(mainTab.left.guild.actions.settings, { parentKey: "wrapper" })
		img(mainTab.left.guild.actions.settings.wrapper, { parentKey: "icon", image: ImageUtils.resolve("⚙️") })
		span(mainTab.left.guild.actions.settings.wrapper, { parentKey: "label", text: "#guild_action_settings" })
	}

	if (GUILD.me.isLeader || GUILD.me.isDeputy) {
		btn(mainTab.left.guild.actions, { parentKey: "audit", className: "action", onLeftClick: () => openAuditLogsModal() })
		div(mainTab.left.guild.actions.audit, { parentKey: "wrapper" })
		img(mainTab.left.guild.actions.audit.wrapper, { parentKey: "icon", image: ImageUtils.resolve("📚") })
		span(mainTab.left.guild.actions.audit.wrapper, { parentKey: "label", text: "#guild_action_audit_logs" })
	}

	btn(mainTab.left.guild.actions, { parentKey: "discord", className: "action", onLeftClick: function () { openDiscordLinkModal() } })
	div(mainTab.left.guild.actions.discord, { parentKey: "wrapper" })
	img(mainTab.left.guild.actions.discord.wrapper, { parentKey: "icon", image: ImageUtils.resolve("guild/discord.png") })
	span(mainTab.left.guild.actions.discord.wrapper, { parentKey: "label", text: "#guild_action_discord" })

	btn(mainTab.left.guild.actions, { parentKey: "leave", className: "action", onLeftClick: () => openGuildLeaveModal() })
	div(mainTab.left.guild.actions.leave, { parentKey: "wrapper" })
	img(mainTab.left.guild.actions.leave.wrapper, { parentKey: "icon", image: ImageUtils.resolve("🚪") })
	span(mainTab.left.guild.actions.leave.wrapper, { parentKey: "label", text: "#guild_action_leave" })

	div(mainTab.left, { parentKey: "player" })
	playerAvatar(mainTab.left.player, { parentKey: "avatar", steamId: GUILD.me.id })

	div(mainTab.left.player, { parentKey: "details" })

	div(mainTab.left.player.details, { parentKey: "name" })
	playerName(mainTab.left.player.details.name, { parentKey: "inner", steamId: GUILD.me.id })

	div(mainTab.left.player.details, { parentKey: "role" })
	span(mainTab.left.player.details.role, { parentKey: "inner", text: GUILD.me.role.name })
	mainTab.left.player.details.role.inner.style.color = GUILD.me.role.color

	div(mainTab.left.player.details, { parentKey: "merits" })
	img(mainTab.left.player.details.merits, { parentKey: "icon", image: ICON.MERITS })
	span(mainTab.left.player.details.merits, { parentKey: "value", text: formatNumber(GUILD.me.merits) })

	GuildEvents.PremadeEvents.MemberPatch(({ member, key }) => {
		if (member !== GUILD.me)
			return

		switch (key) {
			case "role": {
				mainTab.left.player.details.role.inner.text = member.role.name
				mainTab.left.player.details.role.inner.style.color = member.role.color
				break
			}
			case "merits": {
				mainTab.left.player.details.merits.value.text = formatNumber(member.merits)
				break
			}
		}
	}, mainTab)

	GuildEvents.PremadeEvents.RolePatch(({ role, key }) => {
		if (role !== GUILD.me.role)
			return

		if (key === "color") {
			mainTab.left.player.details.role.inner.style.color = role.color
		}
		if (key === "name") {
			mainTab.left.player.details.role.inner.text = role.name
		}
	}, mainTab)

	div(mainTab, { parentKey: "right" })
	span(mainTab.right, { parentKey: "title", text: pluralLocalize("#guild_members_title", GUILD.members.cache.size).replace("{VISIBLE}", GUILD.members.cache.size).replace("{TOTAL}", GUILD.members.cache.size).replace("{MAX}", GUILD.maxMembers) })
	mainTab.right.title.update = function () {
		this.text = pluralLocalize("#guild_members_title", GUILD.members.cache.size).replace("{VISIBLE}", memberRowsData.count(({ memberRow }) => !!memberRow.visible)).replace("{TOTAL}", GUILD.members.cache.size).replace("{MAX}", GUILD.maxMembers)
	}

	GuildEvents.PremadeEvents.ServicePatch(({ service }) => {
		mainTab.right.title.update
	}, mainTab)

	div(mainTab.right, { parentKey: "search" })
	textEntry(mainTab.right.search, { parentKey: "textEntry", image: ImageUtils.resolve("🔍"), placeholder: "#guild_members_text_area_placeholder", maxChars: 30 })

	div(mainTab.right, { parentKey: "table" })
	div(mainTab.right.table, { parentKey: "header" })

	for (const columnKey of [
		"level", "member", "role", "exp", "merits", "crystals", "status"
	]) {
		const column = btn(mainTab.right.table.header, { parentKey: columnKey, className: `${columnKey}-column` })
		column.columnKey = columnKey

		div(column, { parentKey: "wrapper" })
		div(column.wrapper, { parentKey: "sortArrow" }).visible = false
		span(column.wrapper, { parentKey: "label" })

		const columnTextLocKey = `#guild_members_column_${columnKey}`

		column.wrapper.label.text = $.Localize(columnTextLocKey)

		const columnHintTextLocKey = `${columnTextLocKey}_hint`
		const localizedColumnHintText = $.Localize(columnHintTextLocKey)
		if (columnHintTextLocKey !== localizedColumnHintText) {
			column.SetPanelEvent("onmouseover", function () {
				$.DispatchEvent(
					"DOTAShowTextTooltip",
					this,
					localizedColumnHintText
				)
			}.bind(column))
			column.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))
			column.style.tooltipPosition = "top left right bottom"
		}
	}

	div(mainTab.right.table, { parentKey: "content" })

	/**
	 * @type {MemberRowsData}
	 */
	const memberRowsData = new Collection()

	GuildEvents.PremadeEvents.MemberAdd(({ member }) => {
		const memberRow = MemberRow(mainTab.right.table.content, member)

		memberRowsData.set(member.id, {
			member,
			memberRow,
		})

		memberRow.status.update()
	}, mainTab)
	GuildEvents.PremadeEvents.MemberDelete(({ memberId }) => {
		const rowData = memberRowsData.get(memberId)
		if (!rowData) return

		safeDeletePanel(rowData.memberRow)

		updateTopMeritsMembers()
	}, mainTab)

	let batchMemberPatchScheduleId

	GuildEvents.PremadeEvents.MemberPatch(({ member, key }) => {
		const rowData = memberRowsData.get(member.id)
		if (!rowData) return

		const { memberRow } = rowData
		if (!memberRow || !memberRow.IsValid()) return

		switch (key) {
			case "level": {
				memberRow.level.label = formatNumber(member.level)
				break
			}
			case "role": {
				memberRow.role.update()
				break
			}
			case "expForLastWeek": {
				memberRow.exp.wrapper.value.text = formatNumber(member.expForLastWeek)
				break
			}
			case "merits": {
				memberRow.merits.wrapper.value.text = formatNumber(member.merits)
				break
			}
			case "crystalsDonated": {
				memberRow.crystals.wrapper.value.text = formatNumber(member.crystalsDonated)
				break
			}
			case "lastOnline": {
				memberRow.status.update()
				break
			}
		}

		if (batchMemberPatchScheduleId != null) {
			$.CancelScheduled(batchMemberPatchScheduleId)
			batchMemberPatchScheduleId = undefined
		}

		batchMemberPatchScheduleId = $.Schedule(0, function () {
			batchMemberPatchScheduleId = undefined

			updateTopMeritsMembers()
		})
	}, mainTab)

	GuildEvents.PremadeEvents.RolePatch(({ role }) => {
		GUILD.members.cache.forEach((member) => {
			const rowData = memberRowsData.get(member.id)
			if (!rowData) return

			const { memberRow } = rowData
			if (!memberRow || !memberRow.IsValid()) return

			memberRow.role.update()
		})
	}, mainTab)

	GUILD.members.cache.forEach((member) => {
		const memberRow = MemberRow(mainTab.right.table.content, member)

		memberRowsData.set(member.id, {
			member,
			memberRow,
		})
	})

	function updateTopMeritsMembers() {
		const desc = true

		const meritsTopMembers = GUILD.members.cache
			.toArray()
			.sort((m1, m2) => desc ? m2.merits - m1.merits : m1.merits - m2.merits)
			.slice(0, 3)

		memberRowsData.forEach(({ member, memberRow }) => {
			if (!memberRow.IsValid()) return

			const isTopMerits = meritsTopMembers.includes(member)

			memberRow.SetHasClass("is-top-merits", isTopMerits)
			memberRow.member.topMerits.visible = isTopMerits
		})
	}
	updateTopMeritsMembers()

	function updateMembersStatus() {
		if (!mainTab.IsValid()) return

		memberRowsData.forEach(({ memberRow }) => {
			memberRow.status.update()
		})

		$.Schedule(60, updateMembersStatus)
	}
	updateMembersStatus()

	function sortMembersBy(sortColumn, desc = true) {
		switch (sortColumn) {
			case "level": {
				memberRowsData.sort(({ member: m1 }, { member: m2 }) => desc ? m2.level - m1.level : m1.level - m2.level)
				break
			}
			case "member": {
				memberRowsData.sort(({ memberRow: r1 }, { memberRow: r2 }) => {
					let n1 = r1.member.name.name,
						n2 = r2.member.name.name

					if (!n1)
						n1 = r1.member.name.GetChild(0).text ?? ""

					if (!n2)
						n2 = r2.member.name.GetChild(0).text ?? ""

					n1 = String(n1).toLowerCase()
					n2 = String(n2).toLowerCase()

					return desc ? (n2 < n1 ? 1 : -1) : (n1 < n2 ? 1 : -1)
				})
				break
			}
			case "role": {
				memberRowsData.sort(({ member: { role: r1 } }, { member: { role: r2 } }) => {
					return desc ? r1.order - r2.order : r2.order - r1.order
				})
				break
			}
			case "exp": {
				memberRowsData.sort(({ member: m1 }, { member: m2 }) => desc ? m2.expForLastWeek - m1.expForLastWeek : m1.expForLastWeek - m2.expForLastWeek)
				break
			}
			case "merits": {
				memberRowsData.sort(({ member: m1 }, { member: m2 }) => desc ? m2.merits - m1.merits : m1.merits - m2.merits)
				break
			}
			case "crystals": {
				memberRowsData.sort(({ member: m1 }, { member: m2 }) => desc ? m2.crystalsDonated - m1.crystalsDonated : m1.crystalsDonated - m2.crystalsDonated)
				break
			}
			case "status": {
				memberRowsData.sort(({ member: m1 }, { member: m2 }) => desc ? m2.lastOnline - m1.lastOnline : m1.lastOnline - m2.lastOnline)
				break
			}
		}

		let prevRow

		memberRowsData.forEach(({ memberRow }) => {
			if (prevRow)
				mainTab.right.table.content.MoveChildAfter(memberRow, prevRow)

			prevRow = memberRow
		})
	}

	const sortColumns = ["level", "member", "role", "exp", "merits", "crystals", "status"]

	let currentSortButton

	sortColumns.forEach((sortColumn) => {
		const sortButton = mainTab.right.table.header[sortColumn]
		sortButton.onLeftClick = () => {
			if (currentSortButton && sortButton !== currentSortButton) {
				currentSortButton.wrapper.sortArrow.SetHasClass("flipped", currentSortButton.isDescSort)
				currentSortButton.wrapper.sortArrow.visible = false

				currentSortButton.isDescSort = !currentSortButton.isDescSort
			}

			currentSortButton = sortButton

			sortButton.isDescSort = !sortButton.isDescSort

			sortButton.wrapper.sortArrow.SetHasClass("flipped", currentSortButton.isDescSort)
			currentSortButton.wrapper.sortArrow.visible = true

			sortMembersBy(sortColumn, sortButton.isDescSort)
		}

		sortButton.wrapper.sortArrow.SetHasClass("flipped", true)
	})

	mainTab.right.table.header["merits"].onLeftClick()

	function filterMemberRows() {
		memberRowsData.forEach(({ memberRow }) => {
			memberRow.visible = true
		})

		const searchText = (mainTab.right.search.textEntry.input.text ?? "").trim().toLowerCase()
		if (searchText) {
			memberRowsData.forEach(({ memberRow, member }) => {
				if (!memberRow.visible)
					return

				let name = memberRow.member.name.name

				if (!name)
					name = memberRow.member.name.GetChild(0).text ?? ""

				name = String(name ?? "").toLowerCase()

				memberRow.visible = member.id.includes(searchText) || member.id32.includes(searchText) || name.includes(searchText) || (memberRow.role.label.text ?? "").toLowerCase().includes(searchText)
			})
		}

		mainTab.right.title.update()
	}

	mainTab.right.search.textEntry.onChange = () => {
		filterMemberRows()
	}

	return mainTab
}