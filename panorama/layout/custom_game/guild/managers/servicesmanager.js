--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/** @typedef {"rare" | "epic" | "legendary"} ServiceRarity */

/**
 * @typedef {Object} ServicePrice
 * @property {number} gp
 * @property {number} crystals
 */

/**
 * @typedef {Object} ServiceConfig
 * @property {string} id
 * @property {number} order
 * @property {ServiceRarity} rarity
 * @property {string} icon
 * @property {ServicePrice} price
 * @property {number} stock
 * @property {number} discount
 * @property {number} [required_level]
 * @property {number} [unlock_for_each_n_level]
 */

/** @typedef {Object.<string, ServiceConfig>} ServicesConfig */

/**
 * @typedef {Object} ServiceData
 * @property {string} id
 * @property {number} purchases_count
 */

/** @typedef {Object.<string, ServiceData>} ServicesData */

/**
 * @typedef {Object} ServicePatchData
 * @property {number} [purchases_count]
 */

/** @typedef {Object.<string, ServicePatchData>} ServicesPatchData */

class ServicesManager extends BaseManager {
	/**
	 * @type {Collection<string, Service>}
	 */
	cache = new Collection()

	/**
	 * @param {ServicesConfig} servicessConfig
	 * @param {Guild} guild
	 */
	constructor(servicesConfig, guild) {
		super({ guild })

		Object.values(servicesConfig)
			.forEach((serviceConfig) => {
				const service = new Service(serviceConfig, guild, this)

				this.cache.set(service.id, service)
			})

		this.cache.sort(({ order: o1 }, { order: o2 }) => o1 - o2)
	}

	/**
	 * @param {ServicesData} servicesData
	 */
	populate(servicesData) {
		Object.values(servicesData)
			.forEach((serviceData) => {
				const service = this.cache.get(String(serviceData.id))
				if (!service) return

				service.populate(serviceData)
			})
	}

	/**
	 * @param {ServicesPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([serviceId, servicePatchData]) => {
				const service = this.cache.get(String(serviceId))
				if (!service) return

				service.patch(servicePatchData)
			})
	}

	reset() {
		super.reset()

		this.cache.forEach((service) => {
			service.reset()
		})
	}

	/**
	 * @param {string} serviceId
	 */
	isPurchased(serviceId) {
		const service = this.cache.get(serviceId)
		
		return service ? service.purchases > 0 : false
	}
}