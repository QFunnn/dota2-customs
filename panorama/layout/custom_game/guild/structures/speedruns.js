--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/** @typedef {1 | 2 | 3} SpeedrunPlace */

/**
 * @typedef {Object} SpeedrunsPlaceStatsData
 * @property {number} place
 * @property {number} count
 * @property {number} max_difficulty
 * @property {number} total_gp
 * @property {number} total_exp
 */

/**
 * @typedef {Object.<string, SpeedrunsPlaceStatsData>} SpeedrunsStatsData
 */

/**
 * @typedef {Object} SpeedrunsDataBase
 * @property {boolean} [is_active]
 * @property {boolean} [is_force_disabled]
 * @property {SpeedrunsStatsData} stats
 */

/**
 * @typedef {Object} SpeedrunPartialGuild
 * @property {string} id
 * @property {string} name
 * @property {string} image
 */

/**
 * @typedef {Object} SpeedrunPlayerData
 * @property {string} sid64
 * @property {string} hero_name
 * @property {Object.<string, string>} items
 */

/**
 * @typedef {Object} SpeedrunCategoryRunData
 * @property {number} place
 * @property {SpeedrunPartialGuild} guild
 * @property {number} gp
 * @property {number} exp
 * @property {number} game_time_seconds
 * @property {Object.<string, SpeedrunPlayerData>} players
 */

/**
 * @typedef {Object} SpeedrunCategoryData
 * @property {number} difficulty
 * @property {Object.<string, SpeedrunCategoryRunData>} games
 */

/**
 * @typedef {Object} CurrentTopSpeedrun
 * @property {number} difficulty
 * @property {number} place
 * @property {number} gp
 * @property {number} exp
 * @property {number} time
 * @property {Object.<string, string>} players
 */

/**
 * @typedef {Object} SpeedrunsDataActiveType
 * @property {true} is_active
 * @property {Object.<string, SpeedrunCategoryData>} categories
 * 
 * @typedef {SpeedrunsDataBase & SpeedrunsDataActiveType} SpeedrunsDataActive
 */

/**
 * @typedef {Object} SpeedrunTopTeamData
 * @property {number} place
 * @property {SpeedrunPartialGuild} guild
 * @property {number} difficulty
 * @property {number} time
 * @property {Object.<string, string>} players
 */

/**
 * @typedef {Object} SpeedrunsDataNonActiveType
 * @property {false} isActive
 * @property {Object.<string, SpeedrunTopTeamData>} [weekly_winners]
 * 
 * @typedef {SpeedrunsDataBase & SpeedrunsDataNonActiveType} SpeedrunsDataNonActive
 */

/**
 * @typedef {Object} SpeedrunPlayer
 * @property {string} id
 * @property {string} heroName
 * @property {string[]} items
 */

/**
 * @typedef {Object} SpeedrunCategoryRun
 * @property {number} difficulty
 * @property {number} place
 * @property {SpeedrunPartialGuild} guild
 * @property {number} gp
 * @property {number} exp
 * @property {number} time
 * @property {Set<SpeedrunPlayer>} players
 */

/**
 * @typedef {Object} SpeedrunCategory
 * @property {number} difficulty
 * @property {number} bestTime
 * @property {Collection<SpeedrunPlace, SpeedrunCategoryRun>} runs
 */

/**
 * @typedef {Object} SpeedrunTopTeam
 * @property {number} place
 * @property {SpeedrunPartialGuild} guild
 * @property {number} difficulty
 * @property {number} time
 * @property {Set<string>} players
 */

class Speedruns extends BaseManager {
	currentWeek = Time.weeksSinceFirstMonday

	/**
	 * @param {SpeedrunsDataActive | SpeedrunsDataNonActive} data
	 * @param {Guild} guild
	 */
	constructor(data, guild) {
		super({ guild })

		if (Boolean(data.is_force_disabled)) {
			this.isForceDisabled = true
			return
		}

		this.isActive = Boolean(data.is_active)

		this.stats = new SpeedrunsStats(data.stats)

		if (this.isActive) {
			/** @type {SpeedrunsDataActive} */
			const activeData = data

			// const selfTopSpeedrun = activeData.selfTopSpeedrun

			// if (selfTopSpeedrun)
			// 	this.selfTopSpeedrun = {
			// 		difficulty: selfTopSpeedrun.difficulty,
			// 		place: selfTopSpeedrun.place,
			// 		gp: selfTopSpeedrun.gp,
			// 		exp: selfTopSpeedrun.exp,
			// 		time: selfTopSpeedrun.time * 1000,
			// 		players: new Set(Object.values(selfTopSpeedrun.players)),
			// 	}
			// else
			// 	this.selfTopSpeedrun = null

			const ownGuildId = guild.id

			/** @type {Collection<number, SpeedrunCategory>} */
			this.categories = new Collection()

			Object.values(activeData.categories)
				.forEach((speedrunCategoryData) => {
					const difficulty = parseNumber(speedrunCategoryData.difficulty)

					let bestTime

					const speedrunCategory = {
						difficulty,
						runs: Object.values(speedrunCategoryData.games)
							.reduce((/** @type {SpeedrunCategory["runs"]} */acc, runData) => {
								const place = parseNumber(runData.place)

								const time = parseNumber(runData.game_time_seconds) * 1000

								bestTime = bestTime ? Math.min(bestTime, time) : time

								const game = {
									place,
									difficulty,
									guild: this.resolveGuild(runData.guild),
									gp: parseNumber(runData.gp),
									exp: parseNumber(runData.exp),
									time,
									players: Object.values(runData.players)
										.reduce((/** @type {SpeedrunPlayer[]} */acc, playerData) => {
											acc.push({
												id: String(playerData.sid64),
												heroName: String(playerData.hero_name),
												items: Object.values(playerData.items ?? {})
											})

											return acc
										}, [])
								}

								acc.set(place, game)

								if (ownGuildId === game.guild.id) {
									this.selfTopSpeedrun = game
								}

								return acc
							}, new Collection())
					}

					speedrunCategory.bestTime = bestTime ?? 0

					this.categories.set(difficulty, speedrunCategory)
				})

			for (let difficulty = 10; difficulty <= 20; difficulty++) {
				if (this.categories.has(difficulty)) continue

				this.categories.set(difficulty, {
					difficulty,
					runs: new Collection(),
				})
			}
		} else {
			/** @type {SpeedrunsDataNonActive} */
			const nonActiveData = data

			/** @type {Collection<SpeedrunPlace, SpeedrunTopTeam>} */
			this.topTeams = new Collection()
			
			if (nonActiveData.weekly_winners)
				Object.values(nonActiveData.weekly_winners)
					.forEach((topTeamData) => {
						if (!Object.keys(topTeamData).length)
							return

						const place = parseNumber(topTeamData.place)

						this.topTeams.set(place, {
							place,
							guild: this.resolveGuild(topTeamData.guild),
							difficulty: parseNumber(topTeamData.difficulty),
							place: parseNumber(topTeamData.place),
							time: parseNumber(topTeamData.time) * 1000,
							players: new Set(Object.values(topTeamData.players)),
						})
					})
		}
	}

	/**
	 * @param {SpeedrunPartialGuild} guildData
	 * @returns {SpeedrunPartialGuild}
	 */
	resolveGuild(guildData) {
		/** @type {SpeedrunPartialGuild} */
		const partialGuild = {
			id: String(guildData.id),
			name: String(guildData.name),
			image: ImageUtils.resolveGuildImage(String(guildData.image))
		}

		return partialGuild
	}

	formatSpeedrunDuration(time) {
		const durationTable = ms2DurationTable(time, false)

		const hours = durationTable.hours
		if (!hours)
			return `${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`

		return `${String(hours)}:${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`

	}

	get isOutdated() {
		return this.week !== Time.weeksSinceFirstMonday
	}

	get timeUntilSpeedrunStart() {
		return ms2DurationTable(Time.nextFridayStartUTC - Date.now())
	}

	get timeUntilSpeedrunEnd() {
		return ms2DurationTable(Time.nextMondayStartUTC - Date.now())
	}
}