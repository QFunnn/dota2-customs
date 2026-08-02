--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


let listenerId = 0
const listeners = {}

/**
 * @typedef {"pressed" | "doublepressed" | "wheeled" | "released"} MouseEvent
 * @typedef {-1 | 0 | 1 | 2 | 3 | 4 | 5 | 6} MouseEventButton
 */

/**
 * @param {MouseEvent} event
 * @param {MouseEventButton} button
 * @returns {boolean}
 */
function isLMBorRMB(event, button) {
	return event === "pressed" && (button === 0 || button === 1)
}

/**
 * @param {(event: MouseEvent, button: MouseEventButton) => [unListen: boolean | undefined, suppress: boolean | undefined]} callback 
 * @returns {number} id to use with `unListenToMouseEvent`
 */
function listenToMouseEvent(callback) {
	listenerId++

	listeners[listenerId] = callback

	return listenerId
}

/**
 * @param {number} listenerId
 */
function unListenToMouseEvent(listenerId) {
	delete listeners[listenerId]
}

/**
 * @param {Panel} panel
 * @returns {boolean}
 */
function isCursorOverPanel(panel) {
	if (panel == null || !panel.IsValid())
		return false

	const cursorPos = GameUI.GetCursorPosition()

	const pos = panel.GetPositionWithinWindow()

	const x = pos.x
	const y = pos.y

	const width = panel.actuallayoutwidth
	const height = panel.actuallayoutheight

	return cursorPos[0] >= x
		&& (x + width) >= cursorPos[0]
		&& cursorPos[1] >= y
		&& (y + height) >= cursorPos[1]
}

/**
 * @param {Panel[]} panels
 * @returns {boolean}
 */
function isCursorOverAnyPanel(panels) {
	const cursorPos = GameUI.GetCursorPosition()

	return panels.some((panel) => {
		if (panel == null || !panel.IsValid())
			return false

		const pos = panel.GetPositionWithinWindow()

		const x = pos.x
		const y = pos.y

		const width = panel.actuallayoutwidth
		const height = panel.actuallayoutheight
		
		return cursorPos[0] >= x
			&& (x + width) >= cursorPos[0]
			&& cursorPos[1] >= y
			&& (y + height) >= cursorPos[1]
	})
}

/**
 * @param {MouseEvent} event
 * @param {MouseEventButton} button
 * @returns {boolean} suppress default click action
 */
function fireMouseEvent(event, button) {
	let suppress = false

	for (const listenerId of Object.keys(listeners)) {
		if (!listeners[listenerId])
			continue

		try {
			const result = listeners[listenerId](event, button)
			if (result) {
				if (result[0] === true)
					unListenToMouseEvent(listenerId)
				if (result[1] === true)
					suppress = true
			}
		} catch (err) {
			$.Msg("FireMouseEvent callback error")
			$.Msg(err)
			$.Msg(err.stack)
		}
	}

	return suppress
}

(function () {
	DotaHUD.ListenToMouseEvent(function (event, clickBehavior) {
		return fireMouseEvent(event, clickBehavior)
	})
})()