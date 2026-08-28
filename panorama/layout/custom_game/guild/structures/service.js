--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


class Service extends BaseStructure {
	/**
	 * @type {ServicesManager}
	 */
	manager

	/**
	 * @param {ServiceConfig} config
	 * @param {Guild} guild
	 * @param {ServicesManager} manager
	 */
	constructor(config, guild, manager) {
		super({ guild, manager })

		this.purchases = Number()

		this.id = String(config.id)

		this.order = parseNumber(config.order, 999)

		/**
		 * @type {string}
		 */
		this.name = $.Localize(`#guild_shop_${this.id}_name`)

		/**
		 * @type {string}
		 */
		this.description = $.Localize(`#guild_shop_${this.id}_description`)
		if (this.id === "guild_exp_booster") {
			this.description = this.description.replace("{VALUE}", Math.floor(guild.expBoosterValue * 100))
		}

		this.rarity = String(config.rarity)

		this.image = ImageUtils.resolve(String(config.icon))

		/**
		 * @type {ServicePrice}
		 */
		this.price = {
			gp: config.price ? parseNumber(config.price.gp) : 0,
			crystals: config.price ? parseNumber(config.price.crystals) : 0,
		}

		this.stock = parseNumber(config.stock, -1)

		this.isInfinityStock = this.stock === -1
		
		this.discount = parseNumber(config.discount)
		this.hasDiscount = this.discount > 0

		/**
		 * @type {ServicePrice}
		 */
		this.discountPrice = {
			gp: this.price.gp * (100 - this.discount) / 100,
			crystals: this.price.crystals * (100 - this.discount) / 100,
		}

		this.staticRequiredLevel = parseNumber(config.required_level)
		this.unlockForEachNLevel = parseNumber(config.unlock_for_each_n_level)
	}

	/**
	 * @param {ServiceData} serviceData
	 */
	populate(serviceData) {
		this.purchases = serviceData ? parseNumber(serviceData.purchases_count) : 0
	}

	/**
	 * @param {ServicePatchData} patchData
	 */
	patch(patchData) {
		if ("purchases_count" in patchData) this.purchases = parseNumber(patchData.purchases_count)

		GuildEvents.Call("Service:Patch", {
			service: this,
		})
	}

	reset() {
		this.purchases = Number()
	}

	get hasEnoughCurrency() {
		let priceGP, priceCrytals

		if (this.hasDiscount) {
			const discountPrice = this.discountPrice

			priceGP = discountPrice.gp
			priceCrytals = discountPrice.crystals
		} else {
			const price = this.price

			priceGP = price.gp
			priceCrytals = price.crystals
		}

		if (priceGP > 0 && this.guild.gp >= priceGP)
			return true

		if (priceCrytals > 0 && this.guild.crystals >= priceCrytals)
			return true

		return false
	}

	get requiredLevel() {
		if (this.staticRequiredLevel)
			return this.staticRequiredLevel

		if (this.unlockForEachNLevel)
			return (this.purchases + 1) * this.unlockForEachNLevel

		return 0
	}
	get isRequiredLevelMet() {
		const requiredLevel = this.requiredLevel

		return !requiredLevel || this.guild.level >= requiredLevel
	}
	
	get remainingCount() {
		return Math.max(0, this.stock - this.purchases)
	}
	get isOutOfStock() {
		return !this.isInfinityStock && this.purchases >= this.stock
	}

	get finalPrice() {
		return this.hasDiscount ? this.discountPrice : this.price
	}
}