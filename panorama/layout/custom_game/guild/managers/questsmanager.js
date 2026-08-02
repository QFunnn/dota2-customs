--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @mixin
 * @typedef {Object} BaseQuestConfig
 * @property {boolean} is_donation
 * @property {string} id
 * @property {number} order
 * @property {string} icon
 * @property {Object} rewards
 * @property {number} rewards.merits
 * @property {number} rewards.exp
 * @property {number} rewards.gp
 */

/**
 * @typedef {Object} CommonQuestConfigType
 * @property {false} is_donation
 * @property {boolean} is_guild
 * @property {number} target
 * 
 * @typedef {BaseQuestConfig & CommonQuestConfigType} CommonQuestConfig
 */

/**
 * @typedef {Object} DonationQuestConfigTarget
 * @property {number} shields
 * @property {number} crystals
 */

/**
 * @typedef {Object} DonationQuestConfigType
 * @property {true} is_donation
 * @property {boolean} is_guild
 * @property {DonationQuestConfigTarget} target
 * 
 * @typedef {BaseQuestConfig & DonationQuestConfigType} DonationQuestConfig
 */

/** @typedef {CommonQuestConfig | DonationQuestConfig} QuestConfig */

/**
 * @typedef {Object} QuestsConfig
 * @property {Object.<string, QuestConfig>} daily
 * @property {Object.<string, QuestConfig>} weekly
 * @property {Object.<string, QuestConfig>} guild
 */

/**
 * @typedef {Object} BaseQuestData
 * @property {string} id
 * @property {boolean} completed
 */

/**
 * @typedef {Object} CommonQuestDataProgress
 * @property {number} value
 */

/**
 * @typedef {Object} CommonQuestDataType
 * @property {CommonQuestDataProgress} progress
 * 
 * @typedef {BaseQuestData & CommonQuestDataType} CommonQuestData
 */

/**
 * @typedef {Object} CommonGuildQuestDataType
 * @property {number} total_contributors
 * 
 * @typedef {CommonQuestData & CommonGuildQuestDataType} CommonGuildQuestData
 */

/**
 * @typedef {Object} DonationQuestDataProgress
 * @property {number} shields
 * @property {number} crystals
 */

/**
 * @typedef {Object} DonationQuestDataType
 * @property {true} is_donation
 * @property {DonationQuestDataProgress} progress
 * 
 * @typedef {BaseQuestData & DonationQuestDataType} DonationQuestData
 */

/**
 * @typedef {Object} DonationGuildQuestDataType
 * @property {number} total_contributors
 * 
 * @typedef {DonationQuestData & DonationGuildQuestDataType} DonationGuildQuestData
 */

/** @typedef {CommonQuestData | CommonGuildQuestData | DonationQuestData | DonationGuildQuestData} QuestData */

/** @typedef {Object.<string, QuestData>} QuestsData */

/** @typedef {"daily" | "weekly" | "guild"} QuestCategory */

/**
 * @typedef {Object} QuestPatchData
 * @property {boolean} [completed]
 * @property {CommonQuestData["progress"] | DonationQuestData["progress"]} [progress]
 * @property {number} [total_contributors]
 */

/** @typedef {Object.<string, QuestPatchData>} QuestsPatchData */

class QuestsManager extends BaseManager {
	/**
	 * @type {Collection<string, Quest>}
	 */
	cache = new Collection()

	/**
	 * @type {Collection<QuestCategory, Collection<string, Quest>>}
	 */
	categoriesCache = new Collection()

	/**
	 * @private
	 */
	categoriesTime = {
		day: Time.daysSinceFirstMonday,
		week: Time.weeksSinceFirstMonday,
	}

	/**
	 * @param {QuestsConfig} questsConfig
	 * @param {Guild} guild
	 */
	constructor(questsConfig, guild) {
		super({ guild })

		Object.entries(questsConfig)
			.forEach((
				/**
				* @type {[QuestCategory, Object.<string, QuestConfig>]}
				*/
				[category, categoryQuestsConfig]
			) => {
				const categoryCache = new Collection()

				Object.values(categoryQuestsConfig)
					.forEach((questConfig) => {
						const quest = new Quest(category, questConfig, guild, this)

						this.cache.set(quest.id, quest)
						categoryCache.set(quest.id, quest)
					})

				this.categoriesCache.set(category, categoryCache)

				this.categoriesCache.get(category).sort(({ order: o1 }, { order: o2 }) => o1 - o2)
			})

		this.cache.sort(({ order: o1 }, { order: o2 }) => o1 - o2)
	}

	/**
	 * @param {QuestsData} questsData
	 */
	populate(questsData) {
		Object.values(questsData)
			.forEach((questData) => {
				const quest = this.cache.get(String(questData.id))
				if (!quest) return

				quest.populate(questData)
			})
	}

	/**
	 * @param {QuestsPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([questId, questPatchData]) => {
				const quest = this.cache.get(String(questId))
				if (!quest) return

				quest.patch(questPatchData)
			})
	}

	reset() {
		super.reset()

		this.cache.forEach((quest) => {
			quest.reset()
		})
	}

	/**
	 * @param {QuestCategory} category
	 * @returns {number}
	 */
	getCategoryExpireTimeUTC(category) {
		switch (category) {
			case "daily": {
				return Time.nextDayStartUTC
			}
			case "weekly":
			case "guild": {
				return Time.nextWeekStartUTC
			}
			default:
				return 0
		}
	}

	/**
	 * @param {QuestCategory} category
	 * @returns {string}
	 */
	getFormattedCategoryExpireTime(category) {
		const durationTable = ms2DurationTable(this.getCategoryExpireTimeUTC(category) - Date.now())

		const { days } = durationTable
		if (days === 0)
			return $.Localize("#guild_quests_remaining_time")
				.replace(
					"{VALUE}",
					`${durationTable.hours}:${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`
				)

		const daysString = pluralLocalize("#guild_quests_remaining_days", days).replace("{DAYS}", days)

		return $.Localize("#guild_quests_remaining_time")
			.replace(
				"{VALUE}",
				`${daysString} ${durationTable.hours}:${String(durationTable.minutes).padStart(2, "0")}:${String(durationTable.seconds).padStart(2, "0")}`
			)
	}

	/**
	 * @param {QuestCategory} category
	 * @returns {boolean}
	 */
	isCategoryNeedReset(category) {
		switch (category) {
			case "daily":
				return this.categoriesTime.day !== Time.daysSinceFirstMonday
			case "weekly":
				return this.categoriesTime.week !== Time.weeksSinceFirstMonday
			case "guild":
				return this.categoriesTime.week !== Time.weeksSinceFirstMonday
			default:
				return false
		}
	}

	/**
	 * @param {QuestCategory} category
	 * @returns {boolean}
	 */
	updateCategoryTime(category) {
		switch (category) {
			case "daily": {
				const days = Time.daysSinceFirstMonday
				if (this.categoriesTime.day === days)
					return false

				this.categoriesTime.day = days

				return true
			}
			case "weekly":
			case "guild": {
				const weeks = Time.weeksSinceFirstMonday
				if (this.categoriesTime.week === weeks)
					return false

				this.categoriesTime.week = weeks

				return true
			}
			default:
				return false
		}
	}

	/**
	 * @param {QuestCategory} category
	 * @returns {boolean}
	 */
	tryCategoryReset(category) {
		if (!this.updateCategoryTime(category))
			return false

		this.categoriesCache.get(category)
			.forEach((quest) => {
				quest.reset()
			})

		return true
	}
}