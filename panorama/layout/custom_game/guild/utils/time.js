--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


const MS_IN_DAY = 24 * 60 * 60 * 1000
const MS_IN_WEEK = MS_IN_DAY * 7

const EPOCH_FIRST_MONDAY_MS = Date.UTC(1970, 0, 5)

class Time {
	/**
	 * @returns {number} day count (0-based)
	 */
	static get daysSinceFirstMonday() {
		return Math.floor((Date.now() - EPOCH_FIRST_MONDAY_MS) / MS_IN_DAY)
	}
	/**
	 * @returns {number} week count (0-based)
	 */
	static get weeksSinceFirstMonday() {
		return Math.floor((Date.now() - EPOCH_FIRST_MONDAY_MS) / MS_IN_WEEK)
	}
	/**
	 * @returns {number} 0–6
	 */
	static get weekday() {
		return this.daysSinceFirstMonday % 7
	}

	static get nextFridayStartUTC() {
		return EPOCH_FIRST_MONDAY_MS
			+ (
				this.weekday >= 4
					? this.weeksSinceFirstMonday + 1
					: this.weeksSinceFirstMonday
			) * MS_IN_WEEK + 4 * MS_IN_DAY
	}
	static get nextMondayStartUTC() {
		return EPOCH_FIRST_MONDAY_MS + (this.weeksSinceFirstMonday + 1) * MS_IN_WEEK
	}

	static get nextDayStartUTC() {
		return Math.floor(Date.now() / MS_IN_DAY + 1) * MS_IN_DAY
	}
	static get nextWeekStartUTC() {
		return EPOCH_FIRST_MONDAY_MS + (this.weeksSinceFirstMonday + 1) * MS_IN_WEEK
	}
}