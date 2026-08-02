--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} TalentPrice
 * @property {number} gp
 * @property {number} crystals
 */

/**
 * @typedef {Object} TalentLevel
 * @property {number} requiredLevel
 * @property {number} value
 * @property {TalentPrice} price
 */

class Talent extends BaseStructure {
	/**
	 * @type {TalentsManager}
	 */
	manager

	/**
	 * @param {TalentConfig} config
	 * @param {Guild} guild
	 * @param {TalentsManager} manager
	 */
	constructor(config, guild, manager) {
		super({ guild, manager })

		this.level = Number()

		this.id = String(config.id)

		this.order = parseNumber(config.order, 999)

		/**
		 * @type {string}
		 */
		this.name = $.Localize(`#guild_talents_${this.id}_name`)
		/**
		 * @type {string}
		 */
		this.description = $.Localize(`#guild_talents_${this.id}_description`)
		$.Schedule(0, function() {
			this.description = this.description.replace(/\{talent\.(\w+)\}/g, (match, talentId) => {
				const talent = manager.cache.get(talentId)
				if (!talent)
					return match

				return talent.name
			})
		}.bind(this))

		this.isGuildPower = Boolean(config.is_guild_power)

		this.image = ImageUtils.resolve(String(config.icon))

		if ("levels" in config) {
			/**
			 * @type {TalentLevel[]}
			 */
			this.levels = [
				{
					requiredLevel: 0,
					value: 0,
					price: {
						gp: 0,
						price: 0,
					}
				},
				...Object.values(config.levels)
					.reduce((acc, levelConfig) => {
						acc.push({
							requiredLevel: parseNumber(levelConfig.required_level),
							value: parseNumber(levelConfig.value),
							price: {
								gp: parseNumber(levelConfig.price.gp),
								crystals: parseNumber(levelConfig.price.crystals),
							}
						})

						return acc
					}, [])
			]

			this.maxLevel = this.levels.length - 1
		}

		if (this.isGuildPower) {
			this.maxLevel = -1
		}
	}

	/**
	 * @param {TalentData} talentData
	 */
	populate(talentData) {
		this.level = talentData ? parseNumber(talentData.level) : 0
	}

	/**
	 * @param {TalentPatchData} patchData
	 */
	patch(patchData) {
		if ("level" in patchData) this.level = parseNumber(patchData.level)

		GuildEvents.Call("Talent:Patch", {
			talent: this,
		})
	}

	reset() {
		this.level = Number()
	}

	get currentLevelConfig() {
		return this.levels[this.level]
	}
	get currentValue() {
		if (this.isGuildPower)
			return this.level * 0.05

		const levelConfig = this.currentLevelConfig

		return levelConfig ? levelConfig.value : 0
	}
	/**
	 * @type {string}
	 */
	get formattedCurrentValue() {
		const value = this.currentValue
		const valueString = formatNumber(value)

		return this.level === 0
			? $.Localize("#guild_talents_no_bonus")
			: pluralLocalize(`#guild_talents_${this.id}_progress`, value).replace("{VALUE}", valueString)
	}

	get nextLevelConfig() {
		return this.levels[this.level + 1]
	}
	get nextValue() {
		if (this.isGuildPower)
			return (this.level + 1) * 0.05

		const levelConfig = this.nextLevelConfig

		return levelConfig ? levelConfig.value : 0
	}
	/**
	 * @type {string}
	 */
	get formattedNextValue() {
		const nextValue = this.nextValue
		const nextValueString = formatNumber(nextValue)

		return pluralLocalize(`#guild_talents_${this.id}_progress`, nextValue).replace("{VALUE}", nextValueString)
	}

	get isMaxed() {
		return this.isGuildPower ? false : this.level >= this.maxLevel
	}
	get requiredLevelToUpgrade() {
		if (this.isGuildPower)
			return Math.ceil((this.level + 1) / 2) * 2

		return this.levels[this.level + 1] ? this.levels[this.level + 1].requiredLevel : 0
	}
	get isRequiredLevelMet() {
		return this.guild.level >= this.requiredLevelToUpgrade
	}

	get priceGP() {
		if (this.isGuildPower)
			return Math.ceil(2000 * Math.pow(1.3, this.level + 1))

		const levelConfig = this.nextLevelConfig

		return levelConfig ? levelConfig.price.gp : 0
	}
	get priceCrystals() {
		if (this.isGuildPower)
			return Math.ceil(20 * Math.pow(1.3, this.level + 1))

		const levelConfig = this.nextLevelConfig

		return levelConfig ? levelConfig.price.crystals : 0
	}
	get price() {
		return {
			gp: this.priceGP,
			crystals: this.priceCrystals,
		}
	}

	get canEffordForGP() {
		const priceGP = this.priceGP

		return priceGP !== 0 && this.guild.gp >= priceGP
	}
	get canEffordForCrystals() {
		const priceCrystals = this.priceCrystals

		return priceCrystals !== 0 && this.guild.crystals >= priceCrystals
	}

	get canUpgrade() {
		return !this.isMaxed && this.isRequiredLevelMet && (this.canEffordForGP || this.canEffordForCrystals)
	}
}