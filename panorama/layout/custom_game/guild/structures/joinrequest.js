--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


class JoinRequest extends BaseStructure {
	/**
	 * @param {JoinRequestData} data
	 * @param {Guild} guild
	 * @param {JoinRequestsManager} manager
	 */
	constructor(data, guild, manager) {
		super({ guild, manager })

		this.id = String(data.id)

		this.sid64 = String(data.sid64)

		this.level = parseNumber(data.level)
		this.timestamp = parseDateTime(data.timestamp)
	}

	/** @type {string} */
	get formattedTimestamp() {
		const hours = Math.floor((Date.now() - this.timestamp) / 1000 / 60 / 60)

		if (hours <= 0)
			return $.Localize("#guild_join_requests_recently")

		if (hours < 24)
			return pluralLocalize("#guild_join_requests_hours", hours).replace("{HOURS}", hours)

		const days = Math.max(1, Math.floor(hours / 24))

		return pluralLocalize("#guild_join_requestse_days", days).replace("{DAYS}", days)
	}
}