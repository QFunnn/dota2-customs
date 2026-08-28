--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} JoinRequestData
 * @property {number} id
 * @property {number} sid64
 * @property {number} level
 * @property {string} timestamp
 */

/**
 * @typedef {Object} JoinRequestsPatchData
 * @property {"update" | "accept" | "reject" | "invalid"} type
 * @property {Object.<string, JoinRequestData> | { id: string }} data
 */

class JoinRequestsManager extends BaseManager {
	/**
	 * @type {Collection<string, JoinRequest>}
	 */
	cache = new Collection()

	/**
	 * @param {Guild} guild
	 */
	constructor(guild) {
		super({ guild })

		this.setupRequestUpdate("Guild:RequestJoinRequests", 3, 5 * 60)
	}

	populate() {
		this.startRepeatableRequestUpdate(true)
	}

	canProcessRepeatableUpdate() {
		return !isModalOpened("join-requests")
	}

	onPreSendUpdateRequest() {
		super.onPreSendUpdateRequest()
		
		this.cache.clear()
	}

	/**
	 * @param {JoinRequestsPatchData} patchData
	 */
	patch(patchData) {
		if (patchData.type === "update") {
			this.cache.clear()

			/** @type {Object.<string, JoinRequestData>} */
			const { data: updateData } = patchData

			Object.values(updateData)
				.forEach((joinRequestData) => {
					const joinRequest = new JoinRequest(joinRequestData, this.guild, this)

					this.cache.set(joinRequest.id, joinRequest)
				})

			this.cache.sort(({ timestamp: t1 }, { timestamp: t2 }) => t2 - t1)

			GuildEvents.Call("JoinRequests:Update", {
				joinRequests: this.cache,
			})
		} else {
			/** @type {{ id: string }} */
			const id = String(patchData.data.id)

			this.cache.delete(id)

			switch (patchData.type) {
				case "accept": {
					GuildEvents.Call("JoinRequests:Accept", {
						id,
					})
					break
				}
				case "reject": {
					GuildEvents.Call("JoinRequests:Reject", {
						id,
					})
					break
				}
				case "invalid": {
					GuildEvents.Call("JoinRequests:Invalid", {
						id,
					})
					break
				}
			}
		}
	}

	reset() {
		super.reset()

		this.cache.clear()
	}
}