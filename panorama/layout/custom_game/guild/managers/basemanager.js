--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
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