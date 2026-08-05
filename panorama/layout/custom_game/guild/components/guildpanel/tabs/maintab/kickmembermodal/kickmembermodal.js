--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {string} memberId
 */
function openKickMemberModal(memberId) {
	const modal = openModal("kick-member-confirm")
	if (!modal) return

	span(modal, { parentKey: "title", text: "#guild_member_delete_modal_title" })

	playerAvatar(modal, { parentKey: "avatar", steamId: memberId })
	playerName(modal, { parentKey: "name", steamId: memberId })

	div(modal, { parentKey: "buttons" })

	btn(modal.buttons, { parentKey: "confirm", className: "button" })
	div(modal.buttons.confirm, { parentKey: "filler", className: "fill" })
	span(modal.buttons.confirm, { parentKey: "label", text: "#guild_member_delete_modal_confirm" })
	const confirmButton = modal.buttons.confirm

	$.Schedule(1, function () {
		if (!confirmButton.IsValid())
			return

		confirmButton.SetHasClass("filled", true)

		safeDeletePanel(confirmButton.filler)

		confirmButton.onLeftClick = () => {
			modal.close()

			GameEvents.SendCustomGameEventToServer("Guild:KickMember", { targetId: memberId })
		}
	})

	btn(modal.buttons, { parentKey: "cancel", className: "button", text: "#guild_member_delete_modal_cancel" })
	modal.buttons.cancel.onLeftClick = () => {
		modal.close()
	}
}