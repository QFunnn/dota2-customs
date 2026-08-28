--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} TalentPriceConfig
 * @property {number} [gp]
 * @property {number} [crystals]
 */

/**
 * @typedef {Object} TalentLevelConfig
 * @property {number} required_level
 * @property {number} value
 * @property {TalentPriceConfig} price
 */

/**
 * @typedef {Object} TalentConfig
 * @property {string} id
 * @property {number} order
 * @property {string} icon
 * @property {Object.<string, TalentLevelConfig>} [levels]
 * @property {number} [value]
 * @property {boolean} [is_guild_power]
 */

/** @typedef {Object.<string, TalentConfig>} TalentsConfig */

/**
 * @typedef {Object} TalentData
 * @property {string} id
 * @property {number} level
 */

/** @typedef {Object.<string, TalentData>} TalentsData */

/**
 * @typedef {Object} TalentPatchData
 * @property {number} [level]
 */

/** @typedef {Object.<string, TalentPatchData>} TalentsPatchData */

class TalentsManager extends BaseManager {
	/**
	 * @type {Collection<string, Talent>}
	 */
	cache = new Collection()

	/**
	 * @param {TalentsConfig} talentsConfig
	 * @param {Guild} guild
	 */
	constructor(talentsConfig, guild) {
		super({ guild })

		Object.values(talentsConfig)
			.forEach((talentConfig) => {
				const talent = new Talent(talentConfig, guild, this)

				this.cache.set(talent.id, talent)
			})

		this.cache.sort(({ order: o1 }, { order: o2 }) => o1 - o2)
	}

	/**
	 * @param {TalentsData} talentsData
	 */
	populate(talentsData) {
		Object.values(talentsData)
			.forEach((talentData) => {
				const talent = this.cache.get(String(talentData.id))
				if (!talent) return

				talent.populate(talentData)
			})
	}

	/**
	 * @param {TalentsPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([talentId, talentPatchData]) => {
				const talent = this.cache.get(String(talentId))
				if (!talent) return

				talent.patch(talentPatchData)
			})
	}

	reset() {
		super.reset()

		this.cache.forEach((talent) => {
			talent.reset()
		})
	}
}