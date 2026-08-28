--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} MessageData
 * @property {string} id
 * @property {number | string} timestamp
 * @property {string} author_sid64
 * @property {string} content
 */

/**
 * @typedef {Object} MessagesPatchData
 * @property {"update" | "add" | "delete"} type
 * @property {Object.<string, MessageData> | MessageData | { id: string }} data
 */

class MessagesManager extends BaseManager {
	/**
	 * @type {Collection<string, Message>}
	 */
	cache = new Collection()

	/**
	 * @param {Guild} guild
	 */
	constructor(guild) {
		super({ guild })

		this.setupRequestUpdate("Guild:RequestMessages", 3, 3 * 60)
	}

	populate() {
		this.startRepeatableRequestUpdate(true)
	}

	onPreSendUpdateRequest() {
		super.onPreSendUpdateRequest()

		this.cache.clear()
	}

	/**
	 * @param {MessagesPatchData} patchData
	 */
	patch(patchData) {
		switch (patchData.type) {
			case "update": {
				this.cache.clear()

				/** @type {Object.<string, MessageData>} */
				const { data: updateData } = patchData

				Object.values(updateData)
					.forEach((messageData) => {
						const message = new Message(messageData, this.guild, this)

						this.cache.set(message.id, message)
					})

				this.cache.sort(({ timestamp: t1 }, { timestamp: t2 }) => t2 - t1)
				
				GuildEvents.Call("Messages:Update", {
					messages: this.cache,
				})
				break
			}
			case "add": {
				const message = new Message(patchData.data, this.guild, this)

				this.cache.set(message.id, message)

				this.cache.sort(({ timestamp: t1 }, { timestamp: t2 }) => t2 - t1)

				GuildEvents.Call("Messages:Add", {
					message,
				})
				break
			}
			case "delete": {
				const id = String(patchData.data.id)

				this.cache.delete(id)

				GuildEvents.Call("Messages:Delete", {
					id,
				})
				break
			}
		}
	}

	reset() {
		super.reset()

		this.cache.clear()
	}

	/**
	 * @param {Message} message
	 */
	canDeleteMessage(message) {
		if (message.isSystem) return false

		const { me } = this.guild

		const { authorId } = message
		if (authorId === me.id) return true

		if (!me.can("DeleteMessages")) return false

		const author = this.guild.members.cache.get(authorId)
		if (!author) return true
		
		if (author.isLeader) return false
		if (me.isDeputy && author.isDeputy) return false

		return true
	}
}