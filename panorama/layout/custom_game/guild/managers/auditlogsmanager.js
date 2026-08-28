--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {"member_add" | "member_delete" | "member_role_change" | "talent_upgrade" | "service_buy" | "event_ticket_buy" | "event_ticket_use"} AuditLogType
 * @typedef {"crystals" | "gp"} AuditLogCurrency
 */

/**
 * @typedef {Object} BaseAuditLogData
 * @property {string} id
 * @property {number} timestamp
 * @property {string} [executor_sid64]
 * @property {AuditLogType} type
 */

/**
 * @typedef {Object} MemberAddAuditLogDataType
 * @property {"member_add"} type
 * @property {string} target_id
 * 
 * @typedef {BaseAuditLogData & MemberAddAuditLogDataType} MemberAddAuditLogData
 */

/**
 * @typedef {Object} MemberDeleteAuditLogDataType
 * @property {"member_delete"} type
 * @property {string} target_id
 * 
 * @typedef {BaseAuditLogData & MemberDeleteAuditLogDataType} MemberDeleteAuditLogData
 */

/**
 * @typedef {Object} MemberRoleChangeAuditLogDataType
 * @property {"member_role_change"} type
 * @property {string} target_id
 * @property {Object} data
 * @property {string} data.old
 * @property {string} data.new
 * 
 * @typedef {BaseAuditLogData & MemberRoleChangeAuditLogDataType} MemberRoleChangeAuditLogData
 */

/**
 * @typedef {Object} TalentUpgradeAuditLogDataType
 * @property {"talent_upgrade"} type
 * @property {string} target_id
 * @property {Object} data
 * @property {AuditLogCurrency} data.currency
 * @property {number} data.price
 * 
 * @typedef {BaseAuditLogData & TalentUpgradeAuditLogDataType} TalentUpgradeAuditLogData
 */

/**
 * @typedef {Object} ServiceBuyAuditLogDataType
 * @property {"service_buy"} type
 * @property {string} target_id
 * @property {Object} data
 * @property {AuditLogCurrency} data.currency
 * @property {number} data.price
 * 
 * @typedef {BaseAuditLogData & ServiceBuyAuditLogDataType} ServiceBuyAuditLogData
 */

/**
 * @typedef {Object} EventTicketBuyAuditLogDataType
 * @property {"event_ticket_buy"} type
 * @property {string} target_id
 * @property {Object} data
 * @property {AuditLogCurrency} data.currency
 * @property {number} data.price
 * @property {number} data.amount
 * 
 * @typedef {BaseAuditLogData & EventTicketBuyAuditLogDataType} EventTicketBuyAuditLogData
 */

/**
 * @typedef {Object} EventTicketUseAuditLogDataType
 * @property {"event_ticket_buy"} type
 * @property {string} target_id
 * @property {Object} data
 * @property {Object.<string, string>} data.players
 * 
 * @typedef {BaseAuditLogData & EventTicketUseAuditLogDataType} EventTicketUseAuditLogData
 */

/**
 * @typedef {MemberAddAuditLogData | MemberDeleteAuditLogData | MemberRoleChangeAuditLogData | TalentUpgradeAuditLogData | ServiceBuyAuditLogData | EventTicketBuyAuditLogData | EventTicketUseAuditLogData} AuditLogData
 */

/**
 * @typedef {Object.<string, AuditLogData>} AuditLogsPatchData
 */

class AuditLogsManager extends BaseManager {
	/**
	 * @type {Collection<string, AuditLog>}
	 */
	cache = new Collection()

	updateWasNeverRequested = true
	
	/**
	 * @param {Guild} guild
	 */
	constructor(guild) {
		super({ guild })

		this.setupRequestUpdate("Guild:RequestAuditLogs", 3)
	}

	requestUpdate() {
		this.updateWasNeverRequested = false

		return super.requestUpdate()
	}

	onPreSendUpdateRequest() {
		super.onPreSendUpdateRequest()
		
		this.cache.clear()
	}

	/**
	 * @param {AuditLogsPatchData} patchData
	 */
	patch(patchData) {
		this.cache.clear()

		Object.values(patchData)
			.forEach((auditLogData) => {
				const auditLog = new AuditLog(auditLogData, this.guild, this)

				this.cache.set(auditLog.id, auditLog)
			})

		this.cache.sort(({ timestamp: t1 }, { timestamp: t2 }) => t2 - t1)

		GuildEvents.Call("AuditLogs:Update", {
			auditLogs: this.cache,
		})
	}

	reset() {
		super.reset()

		this.wasNeverUsed = true

		this.cache.clear()
	}
}