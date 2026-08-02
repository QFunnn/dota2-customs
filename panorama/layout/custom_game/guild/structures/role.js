--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const localizedNames = {
	leader: $.Localize("#guild_role_leader"),
	deputy: $.Localize("#guild_role_deputy"),
	default: $.Localize("#guild_role_default"),
}

class Role extends BaseStructure {
	/**
	 * @type {RolesManager}
	 */
	manager
	
	/**
	 * @param {RoleData} data
	 * @param {Guild} guild
	 * @param {RolesManager} manager
	 */
	constructor(data, guild, manager) {
		super({ guild, manager })

		this.id = String(data.id)
		this.color = resolveHex(String(data.color))
		this.name = String(data.name)
		
		this.isLeader = (data.settings_bitfield & RoleSettingsFlags.IsLeader) === RoleSettingsFlags.IsLeader
		this.isDeputy = (data.settings_bitfield & RoleSettingsFlags.IsDeputy) === RoleSettingsFlags.IsDeputy
		this.isDefault = (data.settings_bitfield & RoleSettingsFlags.IsDefault) === RoleSettingsFlags.IsDefault

		this.limit = parseNumber(data.limit, -1)

		this.order = parseNumber(data.order)
	}
	
	/**
	 * @param {RolePatchData} patchData
	 */
	patch(patchData) {
		if ("color" in patchData) this.patchPropertyWithEvent("color", resolveHex(String(patchData.color)))
		if ("name" in patchData) this.patchPropertyWithEvent("name", String(patchData.name))

		if ("limit" in patchData) this.patchPropertyWithEvent("limit", parseNumber(patchData.limit))

		if ("order" in patchData) this.patchPropertyWithEvent("order", parseNumber(patchData.order))
	}

	patchPropertyWithEvent(key, value) {
		this[key] = value

		GuildEvents.Call("Role:Patch", {
			role: this,
			key,
		})
	}

	get hasLimit() {
		return this.limit !== -1
	}

	get limitReached() {
		if (this.limit === -1)
			return false

		return this.guild.members.cache.count((member) => member.role === this) >= this.limit
	}

	/**
	 * @param {keyof typeof DeputyPermissionsFlags} permissionFlag
	 */
	can(permissionFlag) {
		if (this.isLeader)
			return true

		if (this.isDeputy)
			return this.guild.deputyPermissions.has(permissionFlag)

		return false
	}

	get membersCount() {
		return this.guild.members.cache.toArray().filter((member) => member.role === this).length
	}
}