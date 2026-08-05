--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 * @param {Panel} child
 * @param {string} parentKey
 */
function handleParentKey(parent, child, parentKey) {
	if (!parentKey) return

	Object.defineProperty(parent, parentKey, {
		enumerable: false,
		writable: true,
		value: child,
	})

	child.SetHasClass(camelCaseTo(parentKey, "param"), true)
}

/**
 * @param {Panel} element
 * @param {string} className
 */
function handleClassName(element, className) {
	if (!className) return

	className.split(" ").forEach((subClassName) => {
		element.SetHasClass(camelCaseTo(subClassName, "param"), true)
	})
}

// ---------------------------------------------------------------------------
// UI Sounds (UX defaults)
// ---------------------------------------------------------------------------

const UI_SOUNDS = Object.freeze({
	// From game_sounds_ui_imported.vsndevts:
	click: "General.ButtonClick",
	hover: "ui_select_arrow",

	// Context / affordance:
	windowOpen: "ui_window_open",
	windowClose: "ui_window_close",
	chatOpen: "ui.chat_open",
	chatClose: "ui.chat_close",
	chatMessageReceived: "Chat.All.Received",
})

/**
 * @param {string | undefined | null} soundName
 */
function emitUISound(soundName) {
	if (!soundName) return
	try {
		Game.EmitSound(soundName)
	} catch (e) { }
}

/**
 * Adds panel event handler without clobbering existing handlers.
 * (Panorama `SetPanelEvent` overwrites; this keeps a handler list.)
 *
 * @param {Panel} panel
 * @param {string} eventName
 * @param {(...args: any[]) => void} handler
 */
function addPanelEvent(panel, eventName, handler) {
	if (!panel) return

	/** @type {{ [eventName: string]: Array<(...args: any[]) => void> }} */
	let handlersByEvent = panel.__handlersByEvent
	if (!handlersByEvent) {
		handlersByEvent = {}
		Object.defineProperty(panel, "__handlersByEvent", {
			enumerable: false,
			writable: true,
			value: handlersByEvent,
		})
	}

	if (!handlersByEvent[eventName]) {
		handlersByEvent[eventName] = []
		panel.SetPanelEvent(eventName, function (...args) {
			const handlers = panel.__handlersByEvent && panel.__handlersByEvent[eventName]
			if (!handlers) return

			for (const h of handlers) {
				try {
					h(...args)
				} catch (error) {
					try {
						if (typeof handleError === "function") handleError(error)
						else $.Msg(error)
					} catch (e) { }
				}
			}
		})
	}

	handlersByEvent[eventName].push(handler)
}

/**
 * @param {any} soundParam
 * @param {"click" | "hover"} kind
 * @returns {string | undefined}
 */
function resolveUISound(soundParam, kind) {
	// sound: false  -> disabled
	if (soundParam === false) return

	// sound: "Some.Event" -> explicit for both
	if (typeof soundParam === "string") return soundParam

	// sound: {click, hover}
	if (soundParam && typeof soundParam === "object") {
		const value = soundParam[kind]
		if (value === false) return
		if (typeof value === "string") return value
		if (value === true) return UI_SOUNDS[kind]
	}

	// sound omitted / true -> default
	return UI_SOUNDS[kind]
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string}} [param1]
 * @returns {Panel}
 */
function div(parent, { parentKey, id, className } = {}) {
	/**
	 * @type {Panel}
	 */
	const div = $.CreatePanel("Panel", parent, id ?? "", {})

	handleParentKey(parent, div, parentKey)

	handleClassName(div, className)

	return div
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, onRightClick?: () => void, onLeftClick?: () => void, sound?: any}} [param1]
 * @returns {Panel}
 */
function divbtn(parent, { parentKey, id, className, onRightClick, onLeftClick, sound } = {}) {
	/**
	 * @type {Panel}
	 */
	const divbtn = $.CreatePanel("Button", parent, id ?? "", {})

	divbtn.onLeftClick = onLeftClick
	divbtn.onRightClick = onRightClick

	addPanelEvent(divbtn, "onmouseover", function () {
		if (!divbtn.enabled) return
		if (!divbtn.onLeftClick && !divbtn.onRightClick && sound == null) return
		emitUISound(resolveUISound(sound, "hover"))
	})
	addPanelEvent(divbtn, "onmouseactivate", function () {
		dropInputFocus()
		if (!divbtn.enabled) return
		if (!divbtn.onLeftClick) return
		emitUISound(resolveUISound(sound, "click"))
		divbtn.onLeftClick()
	})
	addPanelEvent(divbtn, "oncontextmenu", function () {
		dropInputFocus()
		if (!divbtn.enabled) return
		if (!divbtn.onRightClick) return
		emitUISound(resolveUISound(sound, "click"))
		divbtn.onRightClick()
	})

	handleParentKey(parent, divbtn, parentKey)

	handleClassName(divbtn, className)

	return divbtn
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, text?: string, textColor?: string, html?: boolean}} [param1]
 * @returns {Label}
 */
function span(parent, { parentKey, id, className, text, textColor, html } = {}) {
	/**
	 * @type {Label}
	 */
	const span = $.CreatePanel("Label", parent, id ?? "", { text: text ?? "" })
	if (textColor)
		span.style.color = textColor
	if (html)
		span.html = Boolean(html)

	handleParentKey(parent, span, parentKey)

	handleClassName(span, className)

	return span
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, enabled?: boolean, onRightClick?: () => void, onLeftClick?: () => void, text?: string, textColor?: string | boolean, sound?: any}} [param1]
 * @returns {Button}
 */
function btn(parent, { parentKey, id, className, enabled, onRightClick, onLeftClick, text, textColor, sound } = {}) {
	/**
	 * @type {Button}
	 */
	const btn = $.CreatePanel("Button", parent, id ?? "", {})
	btn.onLeftClick = onLeftClick

	addPanelEvent(btn, "onmouseover", function () {
		if (!btn.enabled) return
		if (!btn.onLeftClick && !btn.onRightClick && sound == null) return
		emitUISound(resolveUISound(sound, "hover"))
	})

	addPanelEvent(btn, "onmouseactivate", function () {
		try {
			dropInputFocus()

			if (!btn.enabled) return
			if (!btn.onLeftClick) return

			emitUISound(resolveUISound(sound, "click"))
			btn.onLeftClick()
		} catch (error) {
			handleError(error)
		}
	})
	btn.onRightClick = onRightClick
	addPanelEvent(btn, "oncontextmenu", function () {
		try {
			dropInputFocus()

			if (!btn.enabled) return
			if (!btn.onRightClick) return

			emitUISound(resolveUISound(sound, "click"))
			btn.onRightClick()
		} catch (error) {
			handleError(error)
		}
	})

	if (enabled != null)
		btn.enabled = enabled

	if (text)
		if (typeof text === "string")
			span(btn, { parentKey: "label", className: "label", text: text, textColor })
		else
			span(btn, { parentKey: "label", className: "label", textColor })

	handleParentKey(parent, btn, parentKey)

	handleClassName(btn, className)

	return btn
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, image?: string}} [param1]
 * @returns {ImagePanel}
 */
function img(parent, { parentKey, id, className, image } = {}) {
	/**
	 * @type {ImagePanel}
	 */
	const img = $.CreatePanel("Image", parent, id ?? "", {})
	if (image)
		img.SetImage(ImageUtils.resolve(image))

	handleParentKey(parent, img, parentKey)

	handleClassName(img, className)

	return img
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, image?: string, text?: string, placeholder?: string, multiline?: boolean, maxLines?: number, textMode?: "normal" | "numeric" | "hex", maxChars?: number, onChange?: (this: Panel) => void, onInputSubmit?: (this: Panel) => void}, raiseChangeEvents?: boolean} [param1]
 * @returns {TextEntry}
 */
function textEntry(parent, { parentKey, id, className, image, text, placeholder, multiline, maxLines, textMode, maxChars, onChange, onInputSubmit, raiseChangeEvents } = {}) {
	const isNumericMode = textMode === "numeric"
	const isHexMode = textMode === "hex"

	/**
	 * @type {TextEntry}
	 */
	const textEntry = $.CreatePanel("Panel", parent, id ?? "", {})
	if (onChange)
		textEntry.onChange = onChange
	if (onInputSubmit)
		textEntry.onInputSubmit = onInputSubmit

	textEntry.raiseChangeEvents = raiseChangeEvents == null ? true : raiseChangeEvents

	if (image)
		img(textEntry, { parentKey: "icon", image: image })

	const input = $.CreatePanel("TextEntry", textEntry, "", { placeholder: placeholder ?? "", multiline: multiline ?? false })
	textEntry.input = input
	input.placeholderText = input.GetChild(0)
	if (multiline)
		input.multiline = multiline

	input.AddClass("input")

	input.prevText = ""
	input.SetPanelEvent("ontextentrychange", function () {
		if (!textEntry.raiseChangeEvents)
			return

		if (Math.abs(input.text.length - input.prevText.length) === 1) {
			const newLinesCountInNextText = input.text.split("\n").length
			const newLinesCountInPrevText = input.prevText.split("\n").length

			if (newLinesCountInNextText > newLinesCountInPrevText && !GameUI.IsShiftDown()) {
				const cursorOffset = input.GetCursorOffset()
				input.text = input.prevText
				input.SetCursorOffset(cursorOffset - 1)
				if (textEntry.onInputSubmit)
					textEntry.onInputSubmit(input)
				return
			}
		}

		if (placeholder)
			input.placeholderText.visible = input.text.length === 0

		if (textEntry.maxChars)
			textEntry.maxChars.text = maxChars - input.text.length

		if (isNumericMode) {
			const rawText = input.text
			const numericText = rawText.replace(/[^\d]/g, "")
			if (rawText !== numericText) {
				const cursorOffset = input.GetCursorOffset()
				input.text = numericText
				input.SetCursorOffset(cursorOffset - 1)
				return
			}
		} else if (isHexMode) {
			const rawText = input.text
			const hexText = rawText.replace(/^[^#0-9A-F]$/ig, "")
			if (rawText !== hexText) {
				const cursorOffset = input.GetCursorOffset()
				input.text = hexText
				input.SetCursorOffset(cursorOffset - 1)
				return
			}
		}

		if (maxLines) {
			const linesCount = input.text.split("\n").length

			if (linesCount > maxLines) {
				const cursorOffset = input.GetCursorOffset()
				input.text = input.prevText
				input.SetCursorOffset(cursorOffset - 1)
				return
			}
		}

		input.prevText = input.text

		if (!textEntry.onChange) return

		textEntry.onChange(input)
	})
	input.SetPanelEvent("oninputsubmit", function () {
		if (!textEntry.onInputSubmit) return

		textEntry.onInputSubmit(input)
	})
	input.SetPanelEvent("onfocus", function () {
		textEntry.SetHasClass("focused", true)

		function loop() {
			if (!input.IsValid())
				return

			if (!input.BHasKeyFocus())
				return textEntry.SetHasClass("focused", false)

			$.Schedule(0.02, function () {
				loop()
			})
		}

		loop()
	})

	if (isHexMode) {
		input.style.textTransform = "uppercase"
	}

	if (maxChars) {
		input.SetMaxChars(maxChars)

		span(textEntry, { parentKey: "maxChars", text: maxChars })
	}

	if (text)
		input.text = text

	handleParentKey(parent, textEntry, parentKey)

	handleClassName(textEntry, className)

	return textEntry
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, image?: string, text?: string, checked?: boolean, onChecked?: CheckBox["onChecked"]}} [param1]
 * @returns {CheckBox}
 */
function checkBox(parent, { parentKey, id, className, image, text, checked, onChecked } = {}) {
	const checkbox = btn(parent, { parentKey, id, className })
	/** @this {Panel} */
	checkbox.onLeftClick = function () {
		if (!this.enabled)
			return

		this.checked = !this.checked
		this.SetHasClass("checked", this.checked)

		if (this.onChecked)
			this.onChecked(checkbox, this.checked)
	}
	/** @this {Panel} */
	checkbox.setChecked = function (checked, callCallback) {
		this.checked = checked
		this.SetHasClass("checked", this.checked)

		if (callCallback && this.onChecked)
			this.onChecked(checkbox, this.checked)
	}
	/** @this {Panel} */
	checkbox.isChecked = function () {
		return this.checked
	}
	checkbox.setChecked(!!checked)

	checkbox.onChecked = onChecked

	div(checkbox, { parentKey: "box" })
	div(checkbox.box, { parentKey: "filler" })

	if (image)
		img(checkbox, { parentKey: "icon", image })

	switch (true) {
		case typeof text === "string": {
			span(checkbox, { parentKey: "label", text: text })
			break
		}
		case text === true: {
			span(checkbox, { parentKey: "label" })
			break
		}
	}

	return checkbox
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, steamId?: string}} [param1]
 * @returns {PlayerAvatar}
 */
function playerAvatar(parent, { parentKey, id, className, steamId } = {}) {
	/**
	 * @type {PlayerAvatar}
	 */
	const playerAvatar = $.CreatePanel("Panel", parent, id ?? "", {})

	const avatarImg = $.CreatePanel("DOTAAvatarImage", playerAvatar, "", { steamid: steamId })
	avatarImg.steamid = steamId
	avatarImg.style.width = "100%"
	avatarImg.style.height = "100%"

	/**
	 * @param {string} steamId
	 */
	playerAvatar.setSteamId = function (steamId) {
		avatarImg.steamid = steamId
	}

	handleParentKey(parent, playerAvatar, parentKey)

	handleClassName(playerAvatar, className)

	return playerAvatar
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, steamId?: string}} [param1]
 * @returns {PlayerName}
 */
function playerName(parent, { parentKey, id, className, steamId } = {}) {
	/**
	 * @type {PlayerName}
	 */
	const playerName = $.CreatePanel("DOTAUserName", parent, id ?? "", { steamid: steamId })
	/**
	 * @param {string} steamId
	 */
	playerName.setSteamId = function (steamId) {
		this.steamid = steamId
	}

	handleParentKey(parent, playerName, parentKey)

	handleClassName(playerName, className)

	return playerName
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, heroName?: string, style?: "icon" | "portrait" | "landscape"}} [param1]
 * @returns {PlayerName}
 */
function heroImage(parent, { parentKey, id, className, heroName, style } = {}) {
	/**
	 * @type {PlayerName}
	 */
	const heroImage = $.CreatePanel("DOTAHeroImage", parent, id ?? "", { heroname: "npc_dota_hero_abaddon" })
	/**
	 * @param {string} heroName
	 */
	heroImage.setHero = function (heroName) {
		this.heroname = heroName
	}
	if (heroName)
		heroImage.heroname = heroName
	if (style)
		heroImage.style = style

	handleParentKey(parent, heroImage, parentKey)

	handleClassName(heroImage, className)

	return heroImage
}

/**
 * @param {Panel} parent
 * @param {{parentKey?: string, id?: string, className?: string, itemName?: string, showTooltip?: boolean}} [param1]
 * @returns {PlayerName}
 */
function itemImage(parent, { parentKey, id, className, itemName, showTooltip } = {}) {
	/**
	 * @type {PlayerName}
	 */
	const itemImage = $.CreatePanel("DOTAItemImage", parent, id ?? "", { itemname: "item_clarity" })
	/**
	 * @param {string} itemName
	 */
	itemImage.setItem = function (itemName) {
		this.itemname = itemName
	}
	if (itemName)
		itemImage.itemname = itemName
	if (showTooltip)
		itemImage.showtooltip = showTooltip

	handleParentKey(parent, itemImage, parentKey)

	handleClassName(itemImage, className)

	return itemImage
}

function BlankTopLayer() {
	const blank = btn(ROOT_TOP_LAYER, { className: "blank" })

	return blank
}

/**
 * @param {Panel} panel
 * @param {(panel: Panel) => void} callback
 */
function awaitUntilRender(panel, callback) {
	if (!panel.IsValid())
		return

	panel.style.opacity = "0.01"

	let attempts = 0

	function loop() {
		attempts++

		if (!panel.IsValid())
			return

		if (panel.actuallayoutwidth > 0) {
			panel.style.opacity = "1"

			callback(panel)

			return
		}

		if (attempts > 15)
			return

		$.Schedule(0, loop)
	}

	loop()
}

/**
 * @param {Panel} contextMenu
 */
function setupContextMenuPosition(contextMenu) {
	awaitUntilRender(contextMenu, function () {
		if (!contextMenu || !contextMenu.IsValid())
			return

		let x, y, parentWidth, parentHeight

		if (contextMenu.__contextSubMenuParent) {
			const parent = contextMenu.__contextSubMenuParent

			parentWidth = parent.actuallayoutwidth
			parentHeight = parent.actuallayoutheight

			const pos = parent.GetPositionWithinWindow()

			x = pos.x + parentWidth
			y = pos.y
		} else {
			parentWidth = 0
			parentHeight = 0

			const cursor = GameUI.GetCursorPosition()

			x = cursor[0]
			y = cursor[1]
		}
	
		const { actuallayoutwidth: menuWidth, actuallayoutheight: menuHeight } = contextMenu

		const screenWidth = Game.GetScreenWidth()
		const screenHeight = Game.GetScreenHeight()

		if (x + menuWidth >= screenWidth) {
			x -= parentWidth + menuWidth
		}

		y = Math.max(0, Math.min(y, screenHeight - menuHeight))

		const scale = 1080 / screenHeight

		contextMenu.style.marginLeft = `${Math.round(x * scale)}px`
		contextMenu.style.marginTop = `${Math.round(y * scale)}px`
	})
}

/** @type {Panel} */
let activeContextMenuLayer

function closeActiveContextMenu() {
	if (!activeContextMenuLayer) return

	safeDeletePanel(activeContextMenuLayer)
	activeContextMenuLayer = undefined
}

/**
 * @param {*} options
 * @returns {Panel | undefined}
 */
function contextMenu(options) {
	closeActiveContextMenu()

	const contextMenuLayer = BlankTopLayer()

	function onLayerClick() {
		try {
			if (isCursorOverAnyPanel(contextMenu.contextMenuPanels)) return
		} catch { }

		closeActiveContextMenu()
	}

	contextMenuLayer.onLeftClick = onLayerClick
	contextMenuLayer.onRightClick = onLayerClick

	activeContextMenuLayer = contextMenuLayer

	const contextMenu = div(contextMenuLayer, { className: "context-menu" })
	contextMenu.__isContextMenuRoot = true
	contextMenu.contextMenuPanels = [contextMenu]

	setupContextMenuPosition(contextMenu)

	contextMenuOptions(contextMenu, contextMenu, options)

	if (!Object.keys(contextMenu.optionPanels).length)
		return closeActiveContextMenu()

	return contextMenu
}

/**
 * @param {Panel} contextMenuRoot
 * @param {Panel} parent
 * @param {*} options 
 * @param {number} depth
 */
function contextMenuOptions(contextMenuRoot, parent, options, depth = 1) {
	Object.defineProperty(parent, "optionPanels", {
		enumerable: false,
		writable: true,
		value: {},
	})

	options.forEach(function (option) {
		switch (option.type) {
			case "button": {
				const onClick = option.onClick

				const button = btn(parent, { className: `button ${option.id}` })
				button.onLeftClick = function () {
					closeActiveContextMenu()

					if (onClick)
						onClick()
				}

				if (option.image)
					img(button, { parentKey: "icon", image: option.image })

				span(button, { parentKey: "label", text: option.text })

				parent.optionPanels[option.id] = button

				break
			}
			case "checkbox": {
				parent.optionPanels[option.id] = checkBox(parent, {
					className: `checkbox ${option.id}`,
					image: option.image,
					text: option.text,
					checked: option.checked,
					onChecked: option.onChecked,
				})

				break
			}
			case "subMenu": {
				const subMenu = btn(parent, { className: `sub-menu ${option.id}` })

				if (option.image)
					img(subMenu, { parentKey: "icon", image: option.image })

				span(subMenu, { parentKey: "label", text: option.text })

				span(subMenu, { parentKey: "arrow", text: ">" })

				parent.optionPanels[option.id] = subMenu

				const subMenuOptions = div(parent.GetParent(), { className: "sub-menu-options" })
				subMenuOptions.visible = false

				contextMenuRoot.contextMenuPanels.push(subMenuOptions)

				Object.defineProperty(subMenuOptions, "__contextSubMenuParent", {
					enumerable: false,
					writable: true,
					value: subMenu,
				})
				Object.defineProperty(subMenu, "__contextSubMenuOptions", {
					enumerable: false,
					writable: true,
					value: subMenuOptions,
				})

				addPanelEvent(subMenu, "onmouseover", function () {
					setupContextMenuPosition(subMenuOptions)

					subMenuOptions.visible = true
				})
				addPanelEvent(subMenu, "onmouseout", function () {
					if (isCursorOverPanel(subMenuOptions) || !subMenuOptions.IsValid())
						return

					subMenuOptions.visible = false
				})

				addPanelEvent(subMenuOptions, "onmouseout", function () {
					let subMenu = subMenuOptions.__contextSubMenuParent
					for (let _ = 0; _ <= 100; _++) {
						if (!subMenu || !subMenu.IsValid())
							break

						const subMenuOptions = subMenu.__contextSubMenuOptions

						if (isCursorOverPanel(subMenuOptions)) {
							break
						}

						if (isCursorOverPanel(subMenu)) {
							break
						}

						subMenuOptions.visible = false

						const parent = subMenu.GetParent()
						if (parent.__isContextMenuRoot)
							break

						subMenu.visible = false

						subMenu = parent.__contextSubMenuParent
					}
				})

				contextMenuOptions(contextMenuRoot, subMenuOptions, option.options, depth + 1)

				break
			}
		}
	})
}

/** @type {Map<string, Panel>} */
let openedModals = new Map()

/**
 * @param {string} modalName
 * @returns {boolean}
 */
function isModalOpened(modalName) {
	const modalLayer = openedModals.get(modalName)
	return modalLayer && modalLayer.IsValid()
}

function closeAllModals() {
	openedModals.forEach((modalLayer, name) => {
		safeDeletePanel(modalLayer)

		openedModals.delete(name)
	})
}

/**
 * @param {string} name
 * @returns {Panel & {close: () => void}}
 */
function openModal(name) {
	if (!name)
		throw new Error("[Modal] modal cannot be opened without name argument")

	{
		const modalLayer = openedModals.get(name)
		if (modalLayer) {
			safeDeletePanel(modalLayer)

			openedModals.delete(name)
		}
	}

	const modalLayer = BlankTopLayer()
	modalLayer.SetHasClass("modal-layer", true)

	function onLayerClick() {
		try {
			if (isCursorOverPanel(modal)) return
		} catch { }

		safeDeletePanel(modalLayer)
	}

	modalLayer.onLeftClick = onLayerClick
	modalLayer.onRightClick = onLayerClick

	const modal = div(modalLayer, { className: `modal ${name}` })
	modal.close = function () {
		safeDeletePanel(modalLayer)
	}

	openedModals.set(name, modalLayer)

	return modal
}