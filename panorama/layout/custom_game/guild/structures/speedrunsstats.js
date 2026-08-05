--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} SpeedrunsPlaceStats
 * @property {number} place
 * @property {number} count
 * @property {number} maxDifficulty
 * @property {number} totalGP
 * @property {number} totalExp
 */


class SpeedrunsStats extends BaseManager {
	/** @type {Collection<SpeedrunPlace, SpeedrunsPlaceStats>} */
	cache = new Collection()

	/**
	 * @param {SpeedrunsStatsData} data
	 * @param {Guild} guild
	 */
	constructor(data, guild) {
		super({guild})

		Object.values(data)
			.forEach((placeStatsData) => {
				const place = parseNumber(placeStatsData.place)

				this.cache.set(place, {
					place,
					count: parseNumber(placeStatsData.count),
					max_difficulty: parseNumber(placeStatsData.max_difficulty),
					total_gp: parseNumber(placeStatsData.total_gp),
					total_exp: parseNumber(placeStatsData.total_exp),
				})
			})
		
		for (let place = 1; place <= 3; place++) {
			if (this.cache.get(place)) continue

			this.cache.set(place, {
				place,
				count: 0,
				max_difficulty: 0,
				total_gp: 0,
				total_exp: 0,
			})
		}
	}
}