--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 * @param {string} timestamp
 * @returns {Panel}
 */
function AuditLogTimestamp(parent, timestamp) {
	return span(parent, { className: "timestamp", text: timestamp })
}

/**
 * @param {Panel} parent
 * @param {string} text
 * @returns {Panel}
 */
function AuditLogText(parent, text) {
	return span(parent, { className: "log-text", text })
}

/**
 * @param {Panel} parent
 * @returns {Panel}
 */
function AuditLogArrow(parent) {
	return div(parent, { className: "arrow" })
}

/**
 * @param {Panel} parent
 * @param {string} playerId
 * @returns {Panel}
 */
function AuditLogPlayer(parent, playerId, className) {
	const auditLogPlayer = div(parent, { className: className ? `player ${className}` : "player" })

	playerAvatar(auditLogPlayer, { className: "avatar", steamId: playerId })
	playerName(auditLogPlayer, { className: "name", steamId: playerId })

	return auditLogPlayer
}

/**
 * @param {Panel} parent
 * @param {string[]} playerIds
 * @returns {Panel}
 */
function AuditLogPlayers(parent, playerIds, className) {
	const auditLogPlayers = div(parent, { className: className ? `players ${className}` : "players" })

	playerIds.forEach((playerId) => {
		const auditLogPlayer = div(auditLogPlayers, { className: "player" })

		playerAvatar(auditLogPlayer, { className: "avatar", steamId: playerId })
		playerName(auditLogPlayer, { className: "name", steamId: playerId })
	})

	return auditLogPlayers
}

/**
 * @param {Panel} parent
 * @param {string} roleId
 * @returns {Panel}
 */
function AuditLogRole(parent, roleId) {
	const auditLogRole = div(parent, { className: "role" })
	span(auditLogRole, { parentKey: "label" })

	const role = GUILD.roles.cache.get(roleId)

	if (role) {
		auditLogRole.label.text = role.name

		const roleColor = role.color

		auditLogRole.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(${roleColor}20), to(${roleColor}0a))`
		auditLogRole.style.borderColor = `${roleColor}4d`
		auditLogRole.style.color = `${roleColor}e4`
	} else {
		auditLogRole.label.text = "?????"

		auditLogRole.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(#8a9ba820), to(#8a9ba80a))`
		auditLogRole.style.borderColor = `#8a9ba84d`
		auditLogRole.style.color = `#e5e0c5`
	}

	return auditLogRole
}

/**
 * @param {Panel} parent
 * @param {string} talentId
 * @param {string} [className]
 * @returns {Panel}
 */
function AuditLogTalent(parent, talentId, className) {
	const auditLogTalent = div(parent, { className: className ? `talent ${className}` : "talent" })

	const talent = GUILD.talents.cache.get(talentId)

	if (talent) {
		img(auditLogTalent, { className: "icon", image: talent.image })
		span(auditLogTalent, { className: "label", text: talent.name })
	} else {
		span(auditLogTalent, { className: "label unknown", text: "?????" })
	}

	return auditLogTalent
}

/**
 * @param {Panel} parent
 * @param {string} serviceId
 * @param {string} [className]
 * @returns {Panel}
 */
function AuditLogService(parent, serviceId, className) {
	const auditLogService = div(parent, { className: className ? `service ${className}` : "service" })

	const service = GUILD.services.cache.get(serviceId)

	if (service) {
		img(auditLogService, { className: "icon", image: service.image })
		span(auditLogService, { className: "label", text: service.name })
	} else {
		span(auditLogService, { className: "label unknown", text: "?????" })
	}

	return auditLogService
}

/**
 * @param {Panel} parent
 * @param {string} ticketId
 * @param {number} ticketsAmount
 * @param {string} [className]
 * @returns {Panel}
 */
function AuditLogEventTicket(parent, ticketId, ticketsAmount, className) {
	const auditLogEventTicket = div(parent, { className: className ? `ticket ${className}` : "ticket" })

	const eventTicket = GUILD.eventTickets.cache.get(ticketId)

	if (eventTicket) {
		img(auditLogEventTicket, { className: "icon", image: eventTicket.image })
		span(auditLogEventTicket, { className: "label", text: eventTicket.name })
		span(auditLogEventTicket, { className: "amount", text: `x${ticketsAmount}` })
	} else {
		span(auditLogEventTicket, { className: "label unknown", text: "?????" })
	}

	return auditLogEventTicket
}

/**
 * @param {Panel} parent
 * @param {AuditLogCurrency} currency
 * @param {number} price
 * @returns {Panel}
 */
function AuditLogPrice(parent, currency, price) {
	const auditLogPrice = div(parent, { className: "price" })

	img(auditLogPrice, { className: "icon", image: currency === "crystals" ? ICON.CRYSTAL : ICON.GP })
	span(auditLogPrice, { className: "label", text: price })

	return auditLogPrice
}

/**
 * @param {Panel} parent
 * @param {AuditLog} auditLog
 * @returns {Panel}
 */
function AuditLogRow(parent, auditLog) {
	const auditLogRow = divbtn(parent, { className: "log" })

	const { fullTimestampString, executorId, type } = auditLog

	AuditLogTimestamp(auditLogRow, fullTimestampString)

	div(auditLogRow, { className: "line" })

	const logDataLines = div(auditLogRow, { className: "log-data-lines" })

	const primaryLogDataRow = div(logDataLines, { className: "line" })

	switch (auditLog.type) {
		case "member_add": {
			if (executorId) {
				AuditLogPlayer(primaryLogDataRow, executorId, "executor")
				AuditLogText(primaryLogDataRow, "#guild_audit_logs_member_add")
				AuditLogPlayer(primaryLogDataRow, auditLog.targetId, "target")
			} else {
				AuditLogPlayer(primaryLogDataRow, auditLog.targetId, "target")
				AuditLogText(primaryLogDataRow, "#guild_audit_logs_member_add_auto")
			}
			break
		}
		case "member_delete": {
			if (executorId) {
				AuditLogPlayer(primaryLogDataRow, executorId, "executor")
				AuditLogText(primaryLogDataRow, "#guild_audit_logs_member_delete")
				AuditLogPlayer(primaryLogDataRow, auditLog.targetId, "target")
			} else {
				AuditLogPlayer(primaryLogDataRow, auditLog.targetId, "target")
				AuditLogText(primaryLogDataRow, "#guild_audit_logs_member_leave")
			}
			break
		}
		case "member_role_change": {
			AuditLogPlayer(primaryLogDataRow, executorId, "executor")
			AuditLogText(primaryLogDataRow, "#guild_audit_logs_member_role_change")
			AuditLogPlayer(primaryLogDataRow, auditLog.targetId, "target")

			const secondaryLogDataRow = div(logDataLines, { className: "line" })

			AuditLogRole(secondaryLogDataRow, auditLog.oldRoleId)
			AuditLogArrow(secondaryLogDataRow)
			AuditLogRole(secondaryLogDataRow, auditLog.newRoleId)
			break
		}
		case "talent_upgrade": {
			AuditLogPlayer(primaryLogDataRow, executorId, "executor")
			AuditLogText(primaryLogDataRow, "#guild_audit_logs_talent_upgrade")
			AuditLogTalent(primaryLogDataRow, auditLog.targetId)

			const secondaryLogDataRow = div(logDataLines, { className: "line" })

			AuditLogPrice(secondaryLogDataRow, auditLog.currency, auditLog.price)
			break
		}
		case "service_buy": {
			AuditLogPlayer(primaryLogDataRow, executorId, "executor")
			AuditLogText(primaryLogDataRow, "#guild_audit_logs_service_buy")
			AuditLogService(primaryLogDataRow, auditLog.targetId)

			const secondaryLogDataRow = div(logDataLines, { className: "line" })

			AuditLogPrice(secondaryLogDataRow, auditLog.currency, auditLog.price)
			break
		}
		case "event_ticket_buy": {
			AuditLogPlayer(primaryLogDataRow, executorId, "executor")
			AuditLogText(primaryLogDataRow, "#guild_audit_logs_event_ticket_buy")
			AuditLogEventTicket(primaryLogDataRow, auditLog.targetId, auditLog.amount)

			const secondaryLogDataRow = div(logDataLines, { className: "line" })

			AuditLogPrice(secondaryLogDataRow, auditLog.currency, auditLog.price)
			break
		}
		case "event_ticket_use": {
			AuditLogText(primaryLogDataRow, "#guild_audit_logs_event_ticket_use")
			AuditLogEventTicket(primaryLogDataRow, auditLog.targetId, auditLog.players.length)
			
			const secondaryLogDataRow = div(logDataLines, { className: "line" })

			AuditLogPlayers(secondaryLogDataRow, auditLog.players)
			break
		}
	}

	return auditLogRow
}

function openAuditLogsModal() {
	const modal = openModal("audit-logs")
	if (!modal) return

	const { auditLogs } = GUILD

	div(modal, { parentKey: "header" })

	img(modal.header, { parentKey: "icon", image: ImageUtils.resolve("📚") })
	span(modal.header, { parentKey: "label", text: "#guild_audit_logs_title" })
	btn(modal.header, { parentKey: "close", onLeftClick: () => modal.close() })
	div(modal.header.close, { parentKey: "icon" })

	div(modal, { className: "line" })

	divbtn(modal, { parentKey: "list" })
	modal.list.fill = function () {
		if (!this.IsValid()) return

		this.RemoveAndDeleteChildren()

		auditLogs.cache.forEach((auditLog) => {
			AuditLogRow(this, auditLog)
		})
		
		if (this.GetChildCount() === 0) {
			div(this, { parentKey: "empty" })
			span(this.empty, { parentKey: "label", text: "#guild_empty" })
		}
	}
	modal.list.fill()

	GuildEvents.PremadeEvents.AuditLogsUpdate(() => {
		modal.list.fill()
	}, modal)

	div(modal, { className: "line" })

	btn(modal, { parentKey: "update", text: "#guild_audit_logs_update" })
	modal.update.onLeftClick = () => {
		if (!modal.IsValid()) return

		if (!auditLogs.requestUpdate()) return

		modal.list.RemoveAndDeleteChildren()

		deleteChildByKey(modal.list, "loading")
		div(modal.list, { parentKey: "loading" })
		div(modal.list.loading, { parentKey: "inner" })
	}

	if (auditLogs.updateWasNeverRequested)
		auditLogs.requestUpdate()
}