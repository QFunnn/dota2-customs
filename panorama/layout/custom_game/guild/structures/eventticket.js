--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} EventTicketPrice
 * @property {number} gp
 * @property {number} crystals
 */

class EventTicket extends BaseStructure {
	/**
	 * @type {EventTicketsManager}
	 */
	manager

	/**
	 * @param {EventTicketConfig} config
	 * @param {Guild} guild
	 * @param {EventTicketsManager} manager
	 */
	constructor(config, guild, manager) {
		super({ guild, manager })

		this.amount = Number()

		this.id = String(config.id)

		this.order = parseNumber(config.order, 999)

		this.image = ImageUtils.resolve(String(config.icon))

		/**
		 * @type {string}
		 */
		this.name = $.Localize(`#guild_event_tickets_${this.id}_name`)
		/**
		 * @type {string}
		 */
		this.description = $.Localize(`#guild_event_tickets_${this.id}_description`)

		/**
		 * @type {EventTicketPrice}
		 */
		this.price = {
			gp: config.price ? parseNumber(config.price.gp) : 0,
			crystals: config.price ? parseNumber(config.price.crystals) : 0,
		}
	}

	/**
	 * @param {EventTicketData} eventTicketData
	 */
	populate(eventTicketData) {
		this.amount = eventTicketData ? parseNumber(eventTicketData.amount) : 0
	}

	/**
	 * @param {EventTicketPatchData} patchData
	 */
	patch(patchData) {
		if ("amount" in patchData) this.amount = parseNumber(patchData.amount)

		GuildEvents.Call("EventTicket:Patch", {
			ticket: this,
		})
	}

	reset() {
		this.amount = Number()
	}
}