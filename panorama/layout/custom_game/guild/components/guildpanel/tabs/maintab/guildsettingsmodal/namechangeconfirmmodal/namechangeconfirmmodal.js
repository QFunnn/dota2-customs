--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


/**
 * @param {string} newGuildName
 * @param {() => void} onConfirm
 */
function openNameChangeConfirmModal(newGuildName, onConfirm) {
	const modal = openModal("name-change-confirm")
	if (!modal) return

	span(modal, { parentKey: "title", text: "#guild_settings_name_change_modal_title" })

	div(modal, { parentKey: "price" })
	div(modal.price, { parentKey: "wrapper" })
	img(modal.price.wrapper, { parentKey: "icon", image: ICON.CRYSTAL })
	span(modal.price.wrapper, { parentKey: "label", text: GUILD.nameChangePrice })

	div(modal, { parentKey: "guildName" })
	span(modal.guildName, { parentKey: "old", text: GUILD.name })
	div(modal.guildName, { parentKey: "arrow" })
	span(modal.guildName, { parentKey: "new", text: newGuildName })

	div(modal, { parentKey: "buttons" })

	btn(modal.buttons, { parentKey: "confirm", className: "button" })
	div(modal.buttons.confirm, { parentKey: "filler", className: "fill" })
	span(modal.buttons.confirm, { parentKey: "label", text: "#guild_settings_name_change_modal_confirm" })
	const confirmButton = modal.buttons.confirm

	$.Schedule(1.5, function () {
		if (!confirmButton.IsValid())
			return

		confirmButton.SetHasClass("filled", true)

		safeDeletePanel(confirmButton.filler)

		confirmButton.onLeftClick = () => {
			modal.close()

			onConfirm()
		}
	})

	btn(modal.buttons, { parentKey: "cancel", className: "button", text: "#guild_settings_name_change_modal_cancel" })
	modal.buttons.cancel.onLeftClick = () => {
		modal.close()
	}
}