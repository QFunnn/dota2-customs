--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
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