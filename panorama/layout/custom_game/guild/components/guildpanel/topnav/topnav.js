--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 * @returns {Panel}
 */
function TopNav(parent) {
	const topNav = div(parent, { className: "top-nav" })

	topNav.navTabButtons = {}

	div(topNav, { parentKey: "navTabs" })

	let activeTabButton

	for (const tab of NAV_TABS) {
		const tabId = tab.id

		const tabButton = btn(topNav.navTabs, {
			className: "tab",
			onLeftClick: function () {
				if (tabButton === activeTabButton)
					return
				
				if (activeTabButton) {
					ROOT_MAIN_LAYER.guildPanel.contentContainer.chatBlur.onLeftClick()

					activeTabButton.SetHasClass("active", false)
					if (parent.contentContainer.tabs[activeTabButton.tabId])
						parent.contentContainer.tabs[activeTabButton.tabId].visible = false
				}

				tabButton.SetHasClass("active", true)
				if (parent.contentContainer.tabs[tabId])
					parent.contentContainer.tabs[tabId].visible = true

				activeTabButton = tabButton
			}
		})
		tabButton.tabId = tabId

		div(tabButton, { parentKey: "wrapper" })

		div(tabButton.wrapper, { parentKey: "icon" })
		img(tabButton.wrapper.icon, { className: "inner", image: ImageUtils.resolve(tab.icon) })
		span(tabButton.wrapper, { parentKey: "label", text: `#guild_tab_${tabId}` })

		topNav.navTabButtons[tabId] = tabButton
	}

	ChatButton(topNav)
	
	btn(topNav, { parentKey: "update", text: "#guild_update" })
	topNav.update.onLeftClick = () => {
		if (!GUILD.requestUpdate({ isUpdate: true })) return

		closeEverything()
	}

	// topNav.update.SetPanelEvent("onmouseover", () => {
	// 	$.DispatchEvent(
	// 		"DOTAShowTextTooltip",
	// 		topNav.update,
	// 		$.Localize("#guild_update_hint")
	// 	)
	// })
	// topNav.update.SetPanelEvent("onmouseout", () => $.DispatchEvent("DOTAHideTextTooltip"))

	btn(topNav, {
		parentKey: "close", onLeftClick: () => {
			closeChat()
			
			DotaHUD.WindowClose("guild")
		}
	})
	div(topNav.close, { parentKey: "icon" })

	return topNav
}