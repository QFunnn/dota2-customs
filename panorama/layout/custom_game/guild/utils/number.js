--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @param {any} value
 * @param {number} [defaultValue] default: 0
 * @returns
 */
function parseNumber(value, defaultValue = 0) {
	const number = Number(value)

	return Number.isNaN(number) ? defaultValue : number
}

/**
 * @param {number} number
 * @param {boolean} [decimal]
 */
function formatNumber(number) {
	if (!Number.isFinite(number))
		return ""

	if (Number.isInteger(number))
		return String(number).replace(/\B(?=(\d{3})+(?!\d))/g, " ")

	const fracValue = String(Math.floor(number % 1 * 100) / 100)
	const [_, fracString = "0"] = fracValue.split(".")

	return `${String(Math.floor(number)).replace(/\B(?=(\d{3})+(?!\d))/g, " ")}.${fracString}`
}

/**
 * @param {any} value
 * @param {number} [defaultValue] default: 0
 * @returns
 */
function parseDateTime(value, defaultValue = 0) {
	const dateTime = Number(value)
	if (!Number.isNaN(dateTime))
		return dateTime

	const date = new Date(value)
	if (!isNaN(date))
		return date.getTime()

	return defaultValue
}