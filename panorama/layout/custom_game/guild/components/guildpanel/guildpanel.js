--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 */
function openGuildPanel() {
	const guildPanel = divbtn(ROOT_MAIN_LAYER, { parentKey: "guildPanel" })
	guildPanel.toggleVisibility = function () {
		if (!this.visible) {
			this.show()
		} else {
			this.hide()
		}
	}
	guildPanel.show = function () {
		this.visible = true
	}
	guildPanel.hide = function () {
		this.visible = false

		closeChat()
	}
	guildPanel.update = function () {
		
	}

	guildPanel.topNav = TopNav(guildPanel)

	guildPanel.contentContainer = div(guildPanel, { className: "content" })

	btn(guildPanel.contentContainer, {
		parentKey: "chatBlur",
		onLeftClick: () => closeChat(),
	})
		.visible = false

	guildPanel.contentContainer.tabs = {}

	guildPanel.contentContainer.tabs[NAV_TABS[0].id] = MainTab(guildPanel.contentContainer)
	guildPanel.contentContainer.tabs[NAV_TABS[1].id] = TalentsTab(guildPanel.contentContainer)
	guildPanel.contentContainer.tabs[NAV_TABS[2].id] = SpeedrunsTab(guildPanel.contentContainer)
	guildPanel.contentContainer.tabs[NAV_TABS[3].id] = QuestsTab(guildPanel.contentContainer)
	guildPanel.contentContainer.tabs[NAV_TABS[4].id] = EventsTab(guildPanel.contentContainer)
	guildPanel.contentContainer.tabs[NAV_TABS[5].id] = ShopTab(guildPanel.contentContainer)

	for (const tabId in guildPanel.contentContainer.tabs)
		guildPanel.contentContainer.tabs[tabId].visible = false

	guildPanel.topNav.navTabButtons[NAV_TABS[0].id].onLeftClick()
	// guildPanel.topNav.navTabButtons[NAV_TABS[1].id].onLeftClick()
	// guildPanel.topNav.navTabButtons[NAV_TABS[2].id].onLeftClick()
	// guildPanel.topNav.navTabButtons[NAV_TABS[3].id].onLeftClick()
	// guildPanel.topNav.navTabButtons[NAV_TABS[4].id].onLeftClick()
	// guildPanel.topNav.navTabButtons[NAV_TABS[5].id].onLeftClick()

	Chat(guildPanel.contentContainer)

	listenToMouseEvent((event, button) => {
		if (!guildPanel.IsValid()) return [true]
		if (!guildPanel.visible) return
		if (!isLMBorRMB(event, button)) return
		if (openedModals.size > 1 || activeContextMenuLayer) return
		if (isCursorOverPanel(guildPanel)) return

		DotaHUD.WindowClose("guild")
	})

	return guildPanel
}