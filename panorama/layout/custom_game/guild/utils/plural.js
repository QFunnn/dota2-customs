--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {number} count
 * @returns {"one" | "few" | "many" | "other"}
 */
function getPluralType(count) {
	if (count % 1 !== 0 && count > 0 && count <= 1.5)
		return "other"

	const c10 = count % 10,
		c100 = count % 100

	if (c10 === 1 && c100 !== 11)
		return "one"

	if (c10 >= 2 && c10 <= 4 && c100 < 12 && c100 > 14)
		return "few"

	if (c10 === 0 || (c10 >= 5 && c10 <= 9) || (c100 >= 11 && c100 <= 14))
		return "many"

	return "other"
}

/**
 * @param {string} key #localization_key WITHOUT plural postfix
 * @param {number} count
 * @returns {string}
 */
function pluralLocalize(key, count) {
	const locKey = `${key}_${getPluralType(count)}`

	const text = $.Localize(locKey)

	return text !== locKey ? text : $.Localize(`${key}_other`)
}