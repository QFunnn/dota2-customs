--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} EventTicketPriceConfig
 * @property {number} [gp]
 * @property {number} [crystals]
 */

/**
 * @typedef {Object} EventTicketConfig
 * @property {string} id
 * @property {number} order
 * @property {string} icon
 * @property {EventTicketPriceConfig} price
 */

/** @typedef {Object.<string, EventTicketConfig>} EventTicketsConfig */

/**
 * @typedef {Object} EventTicketData
 * @property {number} amount
 */

/** @typedef {Object.<string, EventTicketData>} EventTicketsData */

/**
 * @typedef {Object} EventTicketPatchData
 * @property {number} [amount]
 */

/** @typedef {Object.<string, EventTicketPatchData>} EventTicketsPatchData */

class EventTicketsManager extends BaseManager {
	/**
	 * @type {Collection<string, EventTicket>}
	 */
	cache = new Collection()

	/**
	 * @param {EventTicketConfig} eventTicketsConfig
	 * @param {Guild} guild
	 */
	constructor(eventTicketsConfig, guild) {
		super({ guild })

		Object.values(eventTicketsConfig)
			.forEach((eventTicketConfig) => {
				const eventTicket = new EventTicket(eventTicketConfig, guild, this)

				this.cache.set(eventTicket.id, eventTicket)
			})

		this.cache.sort(({ order: o1 }, { order: o2 }) => o1 - o2)
	}

	/**
	 * @param {EventTicketsData} eventTicketsData
	 */
	populate(eventTicketsData) {
		Object.entries(eventTicketsData)
			.forEach(([ticketId, ticketData]) => {
				const ticket = this.cache.get(String(ticketId))
				if (!ticket) return

				ticket.populate(ticketData)
			})
	}

	/**
	 * @param {EventTicketsPatchData} patchData
	 */
	patch(patchData) {
		Object.entries(patchData)
			.forEach(([ticketId, ticketPatchData]) => {
				const ticket = this.cache.get(String(ticketId))
				if (!ticket) return

				ticket.patch(ticketPatchData)
			})
	}

	reset() {
		super.reset()

		this.cache.forEach((ticket) => {
			ticket.reset()
		})
	}
}