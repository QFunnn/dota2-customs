--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 * @returns {Panel}
 */
function GuildSettings(parent) {
	const guildSettings = btn(parent, { className: "settings guild-settings" })
	/**
	 * @returns {boolean}
	 */
	guildSettings.isSomethingChanged = () => {
		if (guildSettings.primary.guildName.textEntry.input.text !== GUILD.name)
			return true

		/** @type {string} */
		const newDescription = guildSettings.primary.guildDescription.textEntry.input.text
		if (
			GUILD.description
				? newDescription !== GUILD.description
				: !!newDescription.length
		)
			return true
		if (newGuildSettings.bitfield !== GUILD.settings.bitfield)
			return true
		if (newDeputyPermissions.bitfield !== GUILD.deputyPermissions.bitfield)
			return true

		return false
	}
	guildSettings.hasAnyError = () => {
		if (guildSettings.primary.guildName.textEntry.BHasClass("error"))
			return true

		return false
	}

	div(guildSettings, { parentKey: "primary", className: "category" })

	div(guildSettings.primary, { parentKey: "title" })
	span(guildSettings.primary.title, { parentKey: "label", text: "#guild_settings_main_primary_title" })
	div(guildSettings.primary.title, { parentKey: "line" })

	if (GUILD.imageUploadToken && GUILD.imageUploadToken.length) {
		const guildImageService = GUILD.services.cache.get("guild_custom_image")
		if (guildImageService && guildImageService.purchases > 0) {
			div(guildSettings.primary, { parentKey: "guildImage" })
			span(guildSettings.primary.guildImage, { parentKey: "title", text: "#guild_settings_guild_image_title" })
			span(guildSettings.primary.guildImage, { parentKey: "desc", text: "#guild_settings_guild_image_desc" })
			btn(guildSettings.primary.guildImage, {
				parentKey: "openSite",
				text: "#guild_settings_guild_image_button",
				onLeftClick: () => {
					$.DispatchEvent("ExternalBrowserGoToURL", `https://boss-survival-adventure.com/guild/image/${GUILD.imageUploadToken}/edit/?steam_id=${GUILD.me.id}`)
				},
			})
		}
	}

	div(guildSettings.primary, { parentKey: "guildName" })
	div(guildSettings.primary.guildName, { parentKey: "title" })

	span(guildSettings.primary.guildName.title, { parentKey: "label", text: $.Localize("#guild_settings_guild_name_title").replace("{MIN}", GUILD.guildNameMinLength).replace("{MAX}", GUILD.guildNameMaxLength) })
	div(guildSettings.primary.guildName.title, { parentKey: "price" })
		.visible = false
	img(guildSettings.primary.guildName.title.price, { parentKey: "icon", image: ICON.CRYSTAL })
	span(guildSettings.primary.guildName.title.price, { parentKey: "label", text: GUILD.nameChangePrice })

	textEntry(guildSettings.primary.guildName, { parentKey: "textEntry", placeholder: "#guild_settings_guild_name", maxChars: GUILD.guildNameMaxLength })
	guildSettings.primary.guildName.textEntry.input.text = GUILD.name
	/** @this {TextEntry} */
	guildSettings.primary.guildName.textEntry.onChange = function () {
		const nameIsChanged = this.input.text !== GUILD.name

		if (!nameIsChanged) {
			guildSettings.primary.guildName.title.price.visible = false
			guildSettings.primary.guildName.time.visible = false
		} else {
			guildSettings.primary.guildName.title.price.visible = true
			guildSettings.primary.guildName.time.visible = true
		}

		this.SetHasClass("error", this.input.text.length < GUILD.guildNameMinLength || (nameIsChanged && !GUILD.canChangeName()))

		parent.updateFooterButtons()
	}

	div(guildSettings.primary.guildName, { parentKey: "time" })
		.visible = false
	img(guildSettings.primary.guildName.time, { parentKey: "icon", image: ImageUtils.resolve("⏱️") })
	span(guildSettings.primary.guildName.time, { parentKey: "label", text: GUILD.canChangeName() ? "#guild_settings_guild_name_change_delay" : $.Localize("#guild_settings_guild_name_change_date").replace("{DATE}", formatFullDate(GUILD.nameChangeUnavailableUntil)) })

	div(guildSettings.primary, { parentKey: "guildDescription" })
	span(guildSettings.primary.guildDescription, { parentKey: "title", text: "#guild_settings_guild_description" })
	textEntry(guildSettings.primary.guildDescription, { parentKey: "textEntry", placeholder: "#guild_settings_guild_description", multiline: true, maxLines: GUILD.guildDescriptionMaxLines, maxChars: GUILD.guildDescriptionMaxLength })
	guildSettings.primary.guildDescription.textEntry.input.text = GUILD.description ?? ""
	/** @this {TextEntry} */
	guildSettings.primary.guildDescription.textEntry.onChange = function () {
		parent.updateFooterButtons()
	}

	div(guildSettings, { parentKey: "secondary", className: "category" })

	div(guildSettings.secondary, { parentKey: "title" })
	span(guildSettings.secondary.title, { parentKey: "label", text: "#guild_settings_main_secondary_title" })
	div(guildSettings.secondary.title, { parentKey: "line" })

	const newGuildSettings = new SettingsBitField(GUILD.settings)

	for (const settingsFlag in SettingsFlags) {
		checkBox(guildSettings.secondary, {
			parentKey: settingsFlag,
			className: "bit",
			text: `#guild_settings_${camelCaseTo(settingsFlag, "snake")}`,
			checked: GUILD.settings.has(settingsFlag),
			onChecked: (_, checked) => {
				newGuildSettings[checked ? "add" : "remove"](settingsFlag)

				parent.updateFooterButtons()
			}
		})
	}

	span(guildSettings.secondary.DisableJoinRequests, { parentKey: "hint", text: "(?)" })
	guildSettings.secondary.DisableJoinRequests.hint.SetPanelEvent("onmouseover", () => {
		$.DispatchEvent(
			"DOTAShowTextTooltip",
			guildSettings.secondary.DisableJoinRequests.hint,
			"#guild_settings_disable_join_requests_tooltip"
		)
	})
	guildSettings.secondary.DisableJoinRequests.hint.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))

	div(guildSettings, { parentKey: "deputy", className: "category" })

	div(guildSettings.deputy, { parentKey: "title" })
	span(guildSettings.deputy.title, { parentKey: "label", text: "#guild_settings_main_deputy_title" })
	div(guildSettings.deputy.title, { parentKey: "line" })

	const newDeputyPermissions = new DeputyPermissionsBitField(GUILD.deputyPermissions)

	for (const deputyPermissionsFlag in DeputyPermissionsFlags) {
		checkBox(guildSettings.deputy, {
			parentKey: deputyPermissionsFlag,
			className: "bit",
			text: `#guild_settings_${camelCaseTo(deputyPermissionsFlag, "snake")}`,
			checked: GUILD.deputyPermissions.has(deputyPermissionsFlag),
			onChecked: (_, checked) => {
				newDeputyPermissions[checked ? "add" : "remove"](deputyPermissionsFlag)

				parent.updateFooterButtons()
			}
		})
	}

	guildSettings.onUndo = () => {
		guildSettings.primary.guildName.textEntry.input.text = GUILD.name
		guildSettings.primary.guildDescription.textEntry.input.text = GUILD.description ?? ""

		newGuildSettings.bitfield = GUILD.settings.bitfield

		for (const settingsFlag in SettingsFlags) {
			guildSettings.secondary[settingsFlag].setChecked(GUILD.settings.has(settingsFlag))
		}

		newDeputyPermissions.bitfield = GUILD.deputyPermissions.bitfield

		for (const deputyPermissionsFlag in DeputyPermissionsFlags) {
			guildSettings.deputy[deputyPermissionsFlag].setChecked(GUILD.deputyPermissions.has(deputyPermissionsFlag))
		}

		parent.updateFooterButtons()
	}
	guildSettings.onSave = () => {
		const newGuildName = guildSettings.primary.guildName.textEntry.input.text

		if (!newGuildName.length)
			return

		function send() {
			const changes = {}

			if (newGuildName !== GUILD.name)
				changes.name = newGuildName

			const newGuildDescription = guildSettings.primary.guildDescription.textEntry.input.text
			if (newGuildDescription !== (GUILD.description ?? ""))
				changes.description = newGuildDescription

			if (newGuildSettings.bitfield !== GUILD.settings.bitfield)
				changes.settings_bitfield = newGuildSettings.bitfield

			if (newDeputyPermissions.bitfield !== GUILD.deputyPermissions.bitfield)
				changes.deputy_permissions_bitfield = newDeputyPermissions.bitfield

			GameEvents.SendCustomGameEventToServer("Guild:EditSettings", { changes })
		}

		if (newGuildName !== GUILD.name) {
			openNameChangeConfirmModal(newGuildName, send)
			return
		}

		send()
	}
	guildSettings.allowTabSwitch = () => {
		return !guildSettings.isSomethingChanged()
	}

	const keysWhitelist = ["name", "description", "nameChangeUnavailableUntil", "settings", "deputyPermissions"]

	GuildEvents.PremadeEvents.GuildPatch(({ key }) => {
		if (!keysWhitelist.includes(key)) return

		if (key === "nameChangeUnavailableUntil") {
			guildSettings.primary.guildName.time.label.text = GUILD.canChangeName() ? $.Localize("#guild_settings_guild_name_change_delay") : $.Localize("#guild_settings_guild_name_change_date").replace("{DATE}", formatFullDate(GUILD.nameChangeUnavailableUntil))
			guildSettings.primary.guildName.textEntry.onChange()
		}

		parent.updateFooterButtons()
	}, guildSettings)

	return guildSettings
}

/**
 * @param {Panel} parent
 * @param {Role} role
 * @param {Panel[]} rolePanelsOrder
 * @param {() => void} updateFooterButtons
 * @returns {Panel}
 */
function RoleSettings(parent, role, rolePanelsOrder, updateFooterButtons) {
	const roleSettings = div(parent, { className: "role" })
	// roleSettings.__order = rolePanelsOrder.length
	roleSettings.__order = role.order
	roleSettings.__role = role

	roleSettings.handleReOrder = function () {
		if (role.isLeader || role.isDeputy) {
			this.up.enabled = false

			this.down.enabled = false
			return
		}

		const topPanel = rolePanelsOrder[this.__order - 1]
		this.up.enabled = !!topPanel && !(topPanel.__role.isLeader || topPanel.__role.isDeputy)
		this.down.enabled = !!rolePanelsOrder[this.__order + 1]
	}
	roleSettings.reset = function () {
		this.__order = role.order

		this.textEntries.nameTextEntry.input.text = role.name
		this.textEntries.colorTextEntry.input.text = role.color

		this.preview.update()
	}
	/**
	 * @returns {boolean}
	 */
	roleSettings.isSomethingChanged = () => {
		if (role.name !== roleSettings.textEntries.nameTextEntry.input.text)
			return true
		if (role.color !== roleSettings.textEntries.colorTextEntry.input.text)
			return true
		if (role.order !== roleSettings.__order)
			return true

		return false
	}
	roleSettings.getChangesData = () => {
		const changes = {}

		const newName = roleSettings.textEntries.nameTextEntry.input.text
		if (role.name !== newName)
			changes.name = newName

		const newColor = roleSettings.textEntries.colorTextEntry.input.text
		if (role.color !== roleSettings.textEntries.colorTextEntry.input.text)
			changes.color = newColor.replace("#", "")

		const newOrder = roleSettings.__order
		if (role.order !== newOrder)
			changes.order = newOrder

		return changes
	}
	/**
	 * @returns {boolean}
	 */
	roleSettings.hasAnyError = () => {
		const { textEntries } = roleSettings
		return textEntries.nameTextEntry.BHasClass("error") || textEntries.colorTextEntry.BHasClass("error")
	}

	rolePanelsOrder.push(roleSettings)

	btn(roleSettings, {
		parentKey: "up",
		className: "order",
		enabled: false,
		onLeftClick: () => {
			const topRolePanel = rolePanelsOrder[roleSettings.__order - 1]

			roleSettings.__order = [topRolePanel.__order, topRolePanel.__order = roleSettings.__order][0]

			parent.reOrderRoles()

			updateFooterButtons()
		},
	})
	div(roleSettings.up, { parentKey: "icon" })
	btn(roleSettings, {
		parentKey: "down",
		className: "order",
		enabled: false,
		onLeftClick: () => {
			const bottomRolePanel = rolePanelsOrder[roleSettings.__order + 1]

			roleSettings.__order = [bottomRolePanel.__order, bottomRolePanel.__order = roleSettings.__order][0]

			parent.reOrderRoles()

			updateFooterButtons()
		},
	})
	div(roleSettings.down, { parentKey: "icon" })

	div(roleSettings, { parentKey: "preview" })
	span(roleSettings.preview, { parentKey: "label" })
	roleSettings.preview.update = function () {
		this.label.text = roleSettings.textEntries.nameTextEntry.input.text

		const roleColor = resolveHex(roleSettings.textEntries.colorTextEntry.input.text)

		this.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(${roleColor}20), to(${roleColor}0a))`
		this.style.borderColor = `${roleColor}4d`
		this.style.color = `${roleColor}e4`
	}
	if (role.isDefault) {
		div(roleSettings, { parentKey: "isDefault" })
		span(roleSettings.isDefault, { parentKey: "label", text: "#guild_role_default_role" })

		roleSettings.isDefault.SetPanelEvent("onmouseover", () => {
			$.DispatchEvent(
				"DOTAShowTextTooltip",
				roleSettings.isDefault,
				"#guild_role_default_role_hint"
			)
		})
		roleSettings.isDefault.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))
	}

	div(roleSettings, { parentKey: "textEntries" })

	textEntry(roleSettings.textEntries, { parentKey: "nameTextEntry", text: role.name, placeholder: "#guild_settings_role_name", maxChars: GUILD.roleNameMaxLength })
	roleSettings.textEntries.nameTextEntry.onChange = function () {
		roleSettings.preview.update()

		this.SetHasClass("error", !this.input.text.length)

		updateFooterButtons()
	}

	textEntry(roleSettings.textEntries, { parentKey: "colorTextEntry", text: role.color, placeholder: "#FFFFFF", textMode: "hex", maxChars: 7 })
	roleSettings.textEntries.colorTextEntry.onChange = function () {
		roleSettings.preview.update()

		this.SetHasClass("error", !isValidHex(this.input.text))

		updateFooterButtons()
	}

	roleSettings.preview.update()

	return roleSettings
}

/**
 * @param {Panel} parent
 * @returns {Panel}
 */
function RolesSettings(parent) {
	const rolesSettings = btn(parent, { className: "settings roles-settings" })
	/**
	 * @returns {boolean}
	 */
	rolesSettings.isSomethingChanged = () => {
		return rolePanelsOrder.some((roleSettings) => {
			/** @type {Role} */
			const role = roleSettings.__role
			if (role.name !== roleSettings.textEntries.nameTextEntry.input.text)
				return true
			if (role.color !== roleSettings.textEntries.colorTextEntry.input.text)
				return true
			if (role.order !== roleSettings.__order) {
				return true
			}

			return false
		})
	}
	rolesSettings.collectChangesData = () => {
		return rolePanelsOrder.reduce((acc, roleSettings) => {
			const roleChanges = roleSettings.getChangesData()
			if (Object.keys(roleChanges).length > 0)
				acc[roleSettings.__role.id] = roleChanges

			return acc
		}, {})
	}
	/**
	 * @returns {boolean}
	 */
	rolesSettings.hasAnyError = () => {
		return rolePanelsOrder.some((roleSettings) => {
			return roleSettings.hasAnyError()
		})
	}

	rolesSettings.reOrderRoles = () => {
		rolePanelsOrder.sort(({ __order: o1 }, { __order: o2 }) => o1 - o2)

		/** @type {Panel} */
		let prevPanel

		rolePanelsOrder.forEach((roleSettings) => {
			roleSettings.handleReOrder()

			if (prevPanel) {
				rolesSettings.MoveChildAfter(roleSettings, prevPanel)
			}

			prevPanel = roleSettings
		})
	}

	/** @type {Collection<string, {role: Role, panel: Panel}>} */
	const roleSettingsPanelsData = new Collection()

	/** @type {Panel[]} */
	const rolePanelsOrder = []

	GUILD.roles.cache.forEach((role) => {
		roleSettingsPanelsData.set(role.id, {
			role,
			panel: RoleSettings(rolesSettings, role, rolePanelsOrder, parent.updateFooterButtons)
		})
	})

	rolePanelsOrder.forEach((panel) => {
		panel.handleReOrder()
	})

	rolesSettings.onUndo = () => {
		rolePanelsOrder.forEach((panel) => {
			panel.reset()
		})

		rolesSettings.reOrderRoles()

		parent.updateFooterButtons()
	}
	rolesSettings.onSave = () => {
		if (rolesSettings.hasAnyError())
			return

		GameEvents.SendCustomGameEventToServer("Guild:EditRoles", { changes: rolesSettings.collectChangesData() })
	}
	rolesSettings.allowTabSwitch = () => {
		return !rolesSettings.isSomethingChanged()
	}

	GuildEvents.PremadeEvents.RolePatch(() => {
		parent.updateFooterButtons()
	}, rolesSettings)

	return rolesSettings
}

function openGuildSettingsModal() {
	const modal = openModal("guild-settings")
	if (!modal) return

	div(modal, { parentKey: "header" })

	img(modal.header, { parentKey: "icon", image: ImageUtils.resolve("⚙️") })
	span(modal.header, { parentKey: "label", text: "#guild_settings_title" })
	btn(modal.header, { parentKey: "close", onLeftClick: () => modal.close() })
	div(modal.header.close, { parentKey: "icon" })

	div(modal, { className: "line" })

	div(modal, { parentKey: "tabButtons" })

	div(modal, { className: "line" })

	divbtn(modal, { parentKey: "tabContent" })
	modal.tabContent.updateFooterButtons = () => {
		const settingsPanel = tabsData.get(activeTabButton.tabId).panel

		let canSave = false,
			canUndo = false

		if (settingsPanel.isSomethingChanged()) {
			canUndo = true

			if (!settingsPanel.hasAnyError()) {
				canSave = true
			}
		}

		return modal.footer.setEnabled(canSave, canUndo)
	}

	div(modal, { className: "line" })

	div(modal, { parentKey: "footer" })
	btn(modal.footer, {
		parentKey: "save",
		className: "button",
		enabled: false,
		text: "#guild_settings_save",
		onLeftClick: () => {
			dropInputFocus()
			tabsData.get(activeTabButton.tabId).panel.onSave()
		},
	})
	btn(modal.footer, {
		parentKey: "undo",
		className: "button",
		enabled: false,
		text: "#guild_settings_undo",
		onLeftClick: () => {
			dropInputFocus()
			tabsData.get(activeTabButton.tabId).panel.onUndo()
		},
	})
	/**
	 * @param {boolean} saveEnabled
	 * @param {boolean} undoEnabled
	 */
	modal.footer.setEnabled = function (saveEnabled, undoEnabled) {
		this.save.enabled = !!saveEnabled
		this.undo.enabled = !!undoEnabled
	}

	/** @type {Collection<"mainSettings" | "rolesSettings", { button: Button, panel: Panel }>} */
	const tabsData = new Collection()

	let activeTabButton

	for (const [tabId, tabPanelConstructor] of [
		["main", GuildSettings],
		["roles", RolesSettings]
	]) {
		const tabButton = btn(modal.tabButtons, {
			parentKey: tabId,
			className: "tab-button",
			text: `#guild_settings_${tabId}`,
			onLeftClick: () => {
				if (tabButton === activeTabButton)
					return

				if (activeTabButton) {
					const activeTabPanel = tabsData.get(activeTabButton.tabId).panel

					if (activeTabPanel.allowTabSwitch && !activeTabPanel.allowTabSwitch()) {
						addTimedClass(tabButton, "error", 1)
						addTimedClass(activeTabPanel.hasAnyError() ? modal.footer.undo : modal.footer.save, "bounce", 1)
						return
					}

					activeTabButton.SetHasClass("active", false)
					tabsData.get(activeTabButton.tabId).panel.visible = false
				}

				tabButton.SetHasClass("active", true)
				tabsData.get(tabId).panel.visible = true

				activeTabButton = tabButton
			},
		})
		tabButton.tabId = tabId

		const tabPanel = tabPanelConstructor(modal.tabContent)
		tabPanel.visible = false

		tabsData.set(tabId, {
			button: tabButton,
			panel: tabPanel,
		})
	}

	tabsData.get("main").button.onLeftClick()
}