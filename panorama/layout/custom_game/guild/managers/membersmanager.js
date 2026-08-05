--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} MemberData
 * @property {string} sid64
 * @property {string} role_id
 * @property {number} level
 * @property {number} merits
 * @property {number} exp_for_last_week
 * @property {number} crystals_donated
 * @property {string} discord_id
 * @property {number | string} joined_at
 * @property {number | string} last_online
 */

/** @typedef {Object.<string, MemberData>} MembersData */

/**
 * @typedef {Object} MemberPatchDataType
 * @property {boolean} [delete]
 * @property {boolean} [add]
 * 
 * @typedef {MemberData & MemberPatchDataType} MemberPatchData
 */

/** @typedef {Object.<string, MemberPatchData>} MembersPatchData */

class MembersManager extends BaseManager {
	/**
	 * @type {Collection<string, Member>}
	 */
	cache = new Collection()

	/**
	 * @protected
	 * @type {number}
	 */
	updateMembersOnlineStatusScheduleId

	/**
	 * @param {Guild} guild 
	 */
	constructor(guild) {
		super({ guild })
	}

	/**
	 * @param {MembersData} membersData
	 */
	populate(membersData) {
		Object.values(membersData)
			.forEach((memberData) => {
				const member = new Member(memberData, this.guild, this)

				this.cache.set(member.id, member)
			})

		this.updateMembersOnlineStatusLoop()
	}

	/**
	 * @param {MembersPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([memberId, memberPatchData]) => {
				if (memberPatchData.add) {
					const member = new Member(memberPatchData, this.guild, this)

					this.cache.set(member.id, member)

					GuildEvents.Call("Member:Add", {
						member,
					})

					for (const [joinRequestId, joinRequest] of this.guild.joinRequests.cache) {
						if (joinRequest.sid64 === member.id) {
							this.guild.joinRequests.cache.delete(joinRequestId)
							break
						}
					}

					return
				}

				if (memberPatchData.delete) {
					memberId = String(memberId)

					if (memberId === this.guild.me.id) {
						safeDeletePanel(ROOT_MAIN_LAYER.guildPanel)
						ROOT_MAIN_LAYER.guildPanel = undefined
						GUILD.reset()
						return
					}
								
					const deleted = this.cache.delete(memberId)

					GuildEvents.Call("Member:Delete", {
						memberId,
					})

					return
				}

				const member = this.cache.get(String(memberId))
				if (!member) return

				member.patch(memberPatchData)
			})
	}

	reset() {
		super.reset()

		this.cache.clear()

		if (this.updateMembersOnlineStatusScheduleId)
			$.CancelScheduled(this.updateMembersOnlineStatusScheduleId)
	}

	updateMembersOnlineStatusLoop() {
		this.cache.forEach((member) => {
			member.updateOnlineStatus()
		})
		
		if (this.updateMembersOnlineStatusScheduleId)
			$.CancelScheduled(this.updateMembersOnlineStatusScheduleId)

		this.updateMembersOnlineStatusScheduleId = $.Schedule(15 * 60, function () {
			this.updateMembersOnlineStatusLoop()
		}.bind(this))
	}

	/**
	 * @param {Member} member
	 */
	canKickMember(member) {
		const { me } = this.guild
		if (!me.can("KickMembers")) return false

		if (me === member) return false

		if (member.isLeader) return false
		if (me.isDeputy && member.isDeputy) return false

		return true
	}

	/**
	 * @param {Member} member
	 */
	canChangeMemberRole(member) {
		const { me } = this.guild
		if (!me.can("ChangeMembersRole")) return false

		if (me === member) return false

		if (member.isLeader) return false
		if (me.isDeputy && member.isDeputy) return false

		return true
	}
}