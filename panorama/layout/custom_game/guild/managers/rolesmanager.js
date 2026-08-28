--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} RoleData
 * @property {string} id
 * @property {string} color
 * @property {string} name
 * @property {number} settings_bitfield
 * @property {number} [limit]
 * @property {number} order
 */

/** @typedef {Object.<string, RoleData>} RolesData */

/**
 * @typedef {Object} RolePatchDataType
 * @property {boolean} [delete]
 * @property {boolean} [add]
 * 
 * @typedef {RoleData & RolePatchDataType} RolePatchData
 */

/** @typedef {Object.<string, RolePatchData>} RolesPatchData */

class RolesManager extends BaseManager {
	/**
	 * @type {Collection<string, Role>}
	 */
	cache = new Collection()
	
	/**
	 * @param {Guild} guild 
	 */
	constructor(guild) {
		super({ guild })
	}

	/**
	 * @param {RolesData} rolesData
	 */
	populate(rolesData) {
		Object.values(rolesData)
			.forEach((roleData) => {
				const role = new Role(roleData, this.guild, this)

				this.cache.set(role.id, role)

				if (role.isDefault)
					this.default = role
			})
		
		this.fixRolesOrder()
	}

	/**
	 * @param {RolesPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([roleId, rolePatchData]) => {
				if (rolePatchData.add) {
					const role = new Role(rolePatchData, this.guild, this)

					this.cache.set(role.id, role)

					GuildEvents.Call("Role:Add", {
						role,
					})
					return
				}

				if (rolePatchData.delete) {
					roleId = String(roleId)

					this.cache.delete(roleId)

					this.guild.members.cache.forEach((member) => {
						if (member.role.id !== roleId)
							return

						member.patch({ roleId: this.default.id })
					})

					GuildEvents.Call("Role:Delete", {
						roleId,
					})
					return
				}

				const role = this.cache.get(String(roleId))
				if (!role) return

				role.patch(rolePatchData)
			})
		
		this.fixRolesOrder()
	}

	reset() {
		super.reset()

		this.cache.clear()
	}

	/**
	 * @param {string} roleId
	 * @returns {Role}
	 */
	getOrDefault(roleId) {
		return this.cache.get(roleId) ?? this.default
	}

	/**
	 * @private
	 */
	fixRolesOrder() {
		this.cache.sort(({ order: o1 }, { order: o2 }) => o1 - o2)
		// let order = this.cache.first().order
		let order = 0
		this.cache.forEach((role) => {
			role.order = order
			order++
		})
	}
}