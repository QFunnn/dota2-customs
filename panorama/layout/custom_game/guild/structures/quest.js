--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


class Quest extends BaseStructure {
	/**
	 * @type {QuestsManager}
	 */
	manager

	/**
	 * @type {number | DonationQuestConfigTarget}
	 */
	target

	/**
	 * @type {number | DonationQuestDataProgress}
	 */
	progress

	/**
	 * @param {QuestCategory} category
	 * @param {QuestConfig} config
	 * @param {Guild} guild
	 * @param {QuestsManager} manager
	 */
	constructor(category, config, guild, manager) {
		super({ guild, manager })

		this.category = String(category)

		this.isCompleted = Boolean()

		this.id = String(config.id)

		this.name = $.Localize(`#guild_quests_${this.id}_name`)

		this.order = parseNumber(config.order, 999)

		this.image = ImageUtils.resolve(String(config.icon))

		if (Boolean(config.is_donation)) {
			this.isDonation = true

			this.target = {
				shields: config.target ? parseNumber(config.target.shields) : 0,
				crystals: config.target ? parseNumber(config.target.crystals) : 0,
			}

			this.description = $.Localize(`#guild_quests_${this.id}_description`)
				.replace("{TARGET_SHIELDS}", formatNumber(this.target.shields))
				.replace("{TARGET_CRYSTALS}", formatNumber(this.target.crystals))

			this.progress = {
				shields: Number(),
				crystals: Number(),
			}
		} else {
			this.isDonation = false

			this.target = parseNumber(config.target)

			this.description = $.Localize(`#guild_quests_${this.id}_description`)
				.replace("{TARGET}", formatNumber(this.target))

			this.progress = {
				value: Number(),
			}
		}

		this.rewards = {
			merits: config.rewards ? parseNumber(config.rewards.merits) : 0,
			exp: config.rewards ? parseNumber(config.rewards.exp) : 0,
			gp: config.rewards ? parseNumber(config.rewards.gp) : 0,
		}

		this.isGuildQuest = Boolean(config.is_guild)
		if (this.isGuildQuest)
			this.contributorsCount = 0
	}

	/**
	 * @param {QuestData} questData
	 */
	populate(questData) {
		this.isCompleted = Boolean(questData.completed)

		if (this.isDonation) {
			this.progress = {
				shields: questData.progress ? parseNumber(questData.progress.shields) : 0,
				crystals: questData.progress ? parseNumber(questData.progress.crystals) : 0,
			}
		} else {
			this.progress = {
				value: questData.progress ? parseNumber(questData.progress.value) : 0,
			}
		}

		if (this.isGuildQuest)
			this.contributorsCount = questData.total_contributors
	}

	/**
	 * @param {QuestPatchData} patchData
	 */
	patch(patchData) {
		if ("completed" in patchData) this.isCompleted = Boolean(patchData.completed)

		if ("progress" in patchData) this.patchProgress(patchData.progress)

		if ("total_contributors" in patchData) this.contributorsCount = parseNumber(patchData.total_contributors)

		GuildEvents.Call("Quest:Patch", {
			quest: this,
		})
	}

	/**
	 * @param {QuestPatchData["progress"]} progressPatchData
	 */
	patchProgress(progressPatchData) {
		if (this.isDonation) {
			if ("shields" in progressPatchData)
				this.progress.shields = parseNumber(progressPatchData.shields)

			if ("crystals" in progressPatchData)
				this.progress.crystals = parseNumber(progressPatchData.crystals)
		} else {
			if ("value" in progressPatchData)
				this.progress.value = parseNumber(progressPatchData.value)
		}
	}

	reset() {
		this.isCompleted = Boolean()

		if (this.isDonation) {
			this.progress = {
				shields: Number(),
				crystals: Number(),
			}
		} else {
			this.progress = {
				value: Number(),
			}
		}

		if (this.isGuildQuest)
			this.contributorsCount = 0
	}
}