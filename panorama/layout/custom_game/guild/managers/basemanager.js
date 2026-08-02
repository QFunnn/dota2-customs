--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} BaseManagerConstructor
 * @property {Guild} [guild]
 */

class BaseManager extends UpdateManager {
	/**
	 * @type {Guild}
	 */
	guild

	/**
	 * @type {Collection}
	 */
	cache

	/**
	 * @param {BaseManagerConstructor} args
	 */
	constructor(args) {
		super()

		if (args.guild)
			Object.defineProperty(this, "guild", {
				enumerable: false,
				writable: true,
				value: args.guild,
			})
	}

	populate() { }
}