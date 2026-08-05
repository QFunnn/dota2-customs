--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


function openGuildLeaveModal() {
	const modal = openModal("guild-leave-confirm")
	if (!modal) return

	span(modal, { parentKey: "title", text: "#guild_leave_modal_title" })

	if (GUILD.me.role.isLeader) {
		div(modal, { parentKey: "warning" })
		div(modal.warning, { parentKey: "inner" })

		div(modal.warning.inner, { parentKey: "header" })
		img(modal.warning.inner.header, { parentKey: "icon", image: ImageUtils.resolve("⚠️") })
		span(modal.warning.inner.header, { parentKey: "label", text: "#guild_leave_modal_leader_warning_prefix" })

		span(modal.warning.inner, { parentKey: "label", text: "#guild_leave_modal_leader_warning" })
	}

	div(modal, { parentKey: "buttons" })

	btn(modal.buttons, { parentKey: "confirm", className: "button" })
	div(modal.buttons.confirm, { parentKey: "filler", className: "fill" })
	span(modal.buttons.confirm, { parentKey: "label", text: "#guild_leave_modal_confirm" })
	const confirmButton = modal.buttons.confirm

	$.Schedule(5, function () {
		if (!confirmButton.IsValid())
			return

		confirmButton.SetHasClass("filled", true)

		safeDeletePanel(confirmButton.filler)

		confirmButton.onLeftClick = () => {
			modal.close()

			GameEvents.SendCustomGameEventToServer("Guild:Leave", {})
		}
	})

	btn(modal.buttons, { parentKey: "cancel", className: "button", text: "#guild_leave_modal_cancel" })
	modal.buttons.cancel.onLeftClick = () => {
		modal.close()
	}
}