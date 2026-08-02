--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


{
	const real$Schedule = $.Schedule

	$.Schedule = function (seconds, callback) {
		return real$Schedule(seconds, function () {
			try {
				return callback()
			} catch (error) {
				handleError(error)
			}
		})
	}
}

/**
 * @param {string} name
 * @param {() => void} callback
 * @returns {number} id to use with `$.Unsubscribe`
 */
const GameEventsSubscribe = function (name, callback) {
	GameEvents.Subscribe(name, function (data) {
		try {
			return callback(data)
		} catch (error) {
			handleError(error)
		}
	})
}