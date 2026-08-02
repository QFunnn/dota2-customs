--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @typedef {Object} BaseStructureConstructor
 * @property {Guild} [guild]
 * @property {BaseManager} [manager]
 */

class BaseStructure {
	/**
	 * @type {Guild}
	 */
	guild

	/**
	 * @type {BaseManager}
	 */
	manager

	/**
	 * @param {BaseStructureConstructor} args
	 */
	constructor(args) {
		if (args.guild)
			Object.defineProperty(this, "guild", {
				enumerable: false,
				writable: true,
				value: args.guild,
			})

		if (args.manager) {
			Object.defineProperty(this, "manager", {
				enumerable: false,
				writable: true,
				value: args.manager,
			})
		}
	}
}