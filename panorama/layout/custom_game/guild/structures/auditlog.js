--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


class AuditLog extends BaseStructure {
	/** @type {string | undefined} */
	executorId

	/**
	 * 
	 * @param {AuditLogData} data 
	 * @param {Guild} guild 
	 * @param {AuditLogsManager} manager 
	 */
	constructor(data, guild, manager) {
		super({ guild, manager })

		this.id = String(data.id)
		this.timestamp = parseDateTime(data.timestamp)
		if (data.executor_sid64 === "0" || !data.executor_sid64) {
			this.executorId = undefined
		} else {
			this.executorId = String(data.executor_sid64)
		}

		/** @type {AuditLogType} */
		this.type = String(data.type)

		switch (this.type) {
			case "member_add":
			case "member_delete": {
				this.targetId = String(data.target_id)
				break
			}
			case "member_add":
			case "member_role_change": {
				this.targetId = String(data.target_id)
				this.oldRoleId = String(data.data.old)
				this.newRoleId = String(data.data.new)
				break
			}
			case "talent_upgrade":
			case "service_buy": {
				this.targetId = String(data.target_id)
				this.currency = String(data.data.currency)
				this.price = parseNumber(data.data.price)
				break
			}
			case "event_ticket_buy": {
				this.targetId = String(data.target_id)
				this.amount = String(data.data.amount)
				this.currency = String(data.data.currency)
				this.price = parseNumber(data.data.price)
				break
			}
			case "event_ticket_use": {
				this.targetId = String(data.target_id)
				/** @type {string[]} */
				this.players = Object.values(data.data.players)
				break
			}
		}

		this.fullTimestampString = formatFullDate(this.timestamp)
	}
}