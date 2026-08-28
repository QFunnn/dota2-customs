--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


const print = $.Msg

function handleError(error) {
	switch (true) {
		case typeof error === "object" && ("stack" in error): {
			$.Warning(error.stack)
			break
		}
		// case typeof error === "string":  {
		// 	const errorObj = new Error(error)
		// 	Error.captureStackTrace(errorObj)
		// 	handleError(errorObj)
		// 	break
		// }
		// default: {
		// 	$.Warning(error)
		// }
		default: {
			$.Warning(error)
		}
	}
}

/**
 * @param {string} text
 * @param {"snake" | "param"} caseType
 * @returns {string}
 */
function camelCaseTo(text, caseType) {
	switch (caseType) {
		case "snake": {
			return text
				.replace(/([a-z0-9])([A-Z])/g, '$1_$2')
				.toLowerCase()
		}
		case "param": {
			return text
				.replace(/([a-z0-9])([A-Z])/g, '$1-$2')
				.toLowerCase()
		}
	}
}

/**
 * @param {Panel} panel
 */
function safeDeletePanel(panel) {
	if (!panel || !panel.IsValid || !panel.IsValid()) return
	panel.visible = false
	panel.DeleteAsync(0)
}

/**
 * @param {number} ms
 * @param {boolean} [includeDays] default `true`
 */
function ms2DurationTable(ms, includeDays = true) {
	const totalSeconds = Math.floor(ms / 1000)
	const totalMinutes = Math.floor(totalSeconds / 60)
	const totalHours = Math.floor(totalMinutes / 60)

	const days = includeDays ? Math.floor(totalHours / 24) : 0
	const hours = includeDays ? (totalHours % 24) : totalHours

	return {
		days,
		hours,
		minutes: Math.max(0, totalMinutes % 60),
		seconds: Math.max(0, totalSeconds % 60),
	}
}

/**
 * @param {Panel} parent
 * @param {string} key
 * @param {(child: Panel) => boolean} [extraCheck] return true to delete
 */
function deleteChildByKey(parent, key, extraCheck) {
	/** @type {Panel} */
	const child = parent[key]
	if (!child) return

	if (!child.IsValid()) {
		parent[key] = undefined
		return
	}

	if (extraCheck && !extraCheck(child))
		return

	safeDeletePanel(child)
	parent[key] = undefined
}

/**
 * @param {number} time
 * @returns {string}
 */
function formatFullDate(time) {
	const date = new Date(time)

	const year = date.getFullYear()
	const month = String(date.getMonth() + 1).padStart(2, "0")
	const day = String(date.getDate()).padStart(2, "0")

	const hours = String(date.getHours()).padStart(2, "0")
	const minutes = String(date.getMinutes()).padStart(2, "0")
	const seconds = String(date.getSeconds()).padStart(2, "0")

	switch ($.Language()) {
		case "ukrainian":
		case "russian": {
			return `${day}.${month}.${year} ${hours}:${minutes}:${seconds}`
		}
		case "english": {
			return `${month}/${day}/${year} ${hours}:${minutes}:${seconds}`
		}
		case "tchinese":
		case "schinese": {
			return `${year}年${month}月${day}日 ${hours}:${minutes}:${seconds}`
		}
		default: {
			return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`
		}
	}
}

function dropInputFocus() {
	$.DispatchEvent("DropInputFocus")
}

/**
 * @param {string} hex
 */
function isValidHex(hex) {
	return /^#([0-9A-F]{3}){1,2}$/i.test(hex)
}

/**
 * @param {string} hex
 */
function resolveHex(hex) {
	if (!isValidHex(hex))
		return "#ffffff"

	if (hex.length === 7)
		return hex

	return "#" + hex
		.slice(1)
		.split("")
		.map((c) => c + c)
		.join("")
}

/**
 * @param {Panel} panel
 * @param {string} className
 * @param {number} seconds
 */
function addTimedClass(panel, className, seconds) {
	const scheduleIdPropertyName = `__${className}ScheduleId`

	if (panel[scheduleIdPropertyName]) {
		$.CancelScheduled(panel[scheduleIdPropertyName])
		panel[scheduleIdPropertyName] = undefined
	}

	panel.SetHasClass(className, true)

	panel[scheduleIdPropertyName] = $.Schedule(seconds, function () {
		if (!panel.IsValid()) return

		panel.SetHasClass(className, false)
		panel[scheduleIdPropertyName] = undefined
	})
}

/**
 * @param {string} locKey
 * @returns {string}
 */
function localizeOrUnknown(locKey) {
	const localizedText = $.Localize(locKey)

	return localizedText === locKey ? "???" : localizedText
}