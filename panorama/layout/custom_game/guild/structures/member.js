--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


class Member extends BaseStructure {
	/**
	 * @type {MembersManager}
	 */
	manager

	/**
	 * @param {MemberData} data
	 * @param {Guild} guild
	 * @param {MembersManager} manager
	 */
	constructor(data, guild, manager) {
		super({ guild, manager })

		this.id = String(data.sid64)
		this.id32 = String(parseNumber(this.id.substr(-16, 16)) - 6561197960265728)

		this.role = this.guild.roles.getOrDefault(String(data.role_id))

		this.level = parseNumber(data.level)
		this.merits = parseNumber(data.merits)
		this.expForLastWeek = parseNumber(data.exp_for_last_week)
		this.crystalsDonated = parseNumber(data.crystals_donated)

		this.joinAt = parseDateTime(data.joined_at)
		this.lastOnline = parseDateTime(data.last_online)

		if ("discord_id" in data)
			this.discordId = String(data.discord_id)

		this.isOnline = false
		this.isActive = false

		this.updateOnlineStatus()
	}

	/**
	 * @param {MemberPatchData} patchData
	 */
	patch(patchData) {
		if ("role_id" in patchData) this.patchPropertyWithEvent("role", this.guild.roles.getOrDefault(String(patchData.role_id)))

		if ("level" in patchData) this.patchPropertyWithEvent("level", parseNumber(patchData.level))
		if ("merits" in patchData) this.patchPropertyWithEvent("merits", parseNumber(patchData.merits))
		if ("exp_for_last_week" in patchData) this.patchPropertyWithEvent("expForLastWeek", parseNumber(patchData.exp_for_last_week))
		if ("crystals_donated" in patchData) this.patchPropertyWithEvent("crystalsDonated", parseNumber(patchData.crystals_donated))

		if ("discord_id" in patchData) this.patchPropertyWithEvent("discordId", String(patchData.discord_id))

		if ("last_online" in patchData) {
			this.patchPropertyWithEvent("lastOnline", parseDateTime(patchData.last_online))
			
			this.updateOnlineStatus()
		}
	}

	patchPropertyWithEvent(key, value) {
		this[key] = value

		GuildEvents.Call("Member:Patch", {
			member: this,
			key,
		})
	}

	get isLeader() {
		return this.role.isLeader
	}
	get isDeputy() {
		return this.role.isDeputy
	}

	get roleName() {
		return this.role.name
	}
	get formattedLastOnline() {
		const hours = Math.floor((Date.now() - this.lastOnline) / 1000 / 60 / 60)

		if (hours <= 0)
			return $.Localize("#guild_members_row_status_offline_recently")

		if (hours < 24)
			return $.Localize(`#guild_members_row_status_offline_hours_${getPluralType(hours)}`).replace("{HOURS}", hours)

		const days = Math.max(1, Math.floor(hours / 24))

		return $.Localize(`#guild_members_row_status_offline_days_${getPluralType(days)}`).replace("{DAYS}", days)
	}

	onlineThreshold = 15 * 60 * 1000
	activeThreshold = 24 * 60 * 60 * 1000

	updateOnlineStatus() {
		const diff = Date.now() - this.lastOnline

		const isOnline = this.isOnline
		const isActive = this.isActive

		this.isOnline = diff <= this.onlineThreshold
		this.isActive = diff <= this.activeThreshold
		
		if (isOnline !== this.isOnline || isActive !== this.isActive)
			GuildEvents.Call("Member:Patch", {
				member: this,
				key: "status"
			})
	}

	/**
	 * @param {keyof typeof DeputyPermissionsFlags} permissionFlag
	 */
	can(permissionFlag) {
		return this.role.can(permissionFlag)
	}
}