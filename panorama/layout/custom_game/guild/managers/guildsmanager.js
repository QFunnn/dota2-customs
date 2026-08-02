--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} PartialGuildData
 * @property {number} id
 * @property {string} name
 * @property {string} image
 * @property {string} owner_sid64
 * @property {number} level
 * @property {number} members_max
 * @property {number} merits
 * @property {boolean} [is_stealth]
 * @property {number} settings_bitfield
 * @property {number} members_count
 * @property {boolean} locked
 */

/**
 * @typedef {Object} PartialGuild
 * @property {string} id
 * @property {number} [place]
 * @property {string} name
 * @property {string} image
 * @property {string} [leader]
 * @property {string} [description]
 * @property {number} level
 * @property {number} membersCount
 * @property {number} membersMax
 * @property {number} merits
 * @property {boolean} isFull
 * @property {boolean} isLocked
 * @property {boolean} isStealth
 */

class GuildsManager extends UpdateManager {
	/** @type {Collection<string, PartialGuild>} */
	cache = new Collection()

	createGuildPrice = 0

	constructor() {
		super()

		this.setupRequestUpdate("Guild:RequestGuilds", 3)
	}

	onPreSendUpdateRequest() {
		super.onPreSendUpdateRequest()
		
		this.cache.clear()
	}

	/**
	 * 
	 * @param {Object.<string, PartialGuildData>} patchData 
	 */
	patch(patchData) {
		this.cache.clear()

		Object.values(patchData)
			.forEach((particalGuildData) => {
				const id = String(particalGuildData.id)

				const partialGuild = {
					id,
					name: String(particalGuildData.name),
					image: ImageUtils.resolveGuildImage(String(particalGuildData.image)),
					leader: particalGuildData.owner_sid64 ? String(particalGuildData.owner_sid64) : null,
					description: particalGuildData.description ? String(particalGuildData.description) : null,
					level: parseNumber(particalGuildData.level),
					membersCount: parseNumber(particalGuildData.members_count),
					membersMax: parseNumber(particalGuildData.members_max),
					merits: parseNumber(particalGuildData.merits),
					isStealth: particalGuildData.is_stealth ? Boolean(particalGuildData.is_stealth) : false,
					isLocked: particalGuildData.locked ? Boolean(particalGuildData.locked) : false,
				}

				partialGuild.isFull = partialGuild.membersCount >= partialGuild.membersMax

				this.cache.set(id, partialGuild)
			})

		this.cache.sort(({ level: l1 }, { level: l2 }) => l2 - l1)

		this.cache.first(3).forEach((guild, num) => {
			guild.place = num + 1
		})

		GuildEvents.Call("Guilds:Update", {
			guilds: this.cache,
		})
	}

	reset() {
		super.reset()

		this.cache.clear()
	}
}