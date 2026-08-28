--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function openDiscordLinkModal() {
	const modal = openModal("discord-link")
	if (!modal) return

	div(modal, { parentKey: "header" })

	img(modal.header, { parentKey: "icon", image: ImageUtils.resolve("guild/discord.png") })
	span(modal.header, { parentKey: "label", text: "#guild_discord_link_title" })
	btn(modal.header, { parentKey: "close", onLeftClick: () => modal.close() })
	div(modal.header.close, { parentKey: "icon" })

	div(modal, { className: "line" })

	span(modal, { parentKey: "desc", text: "#guild_discord_link_for_what" })

	div(modal, { parentKey: "discordId" })
	span(modal.discordId, { parentKey: "title", text: "#guild_discord_link_input_title" })
	textEntry(modal.discordId, { parentKey: "textEntry", placeholder: "#guild_discord_link_input_placeholder", maxLines: 1, maxChars: 21, textMode: "numeric" })
	modal.discordId.textEntry.onChange = function () {
		/** @type {string} */
		const discordId = this.input.text

		const isValid = discordId.length >= 17

		this.SetHasClass("error", !isValid)

		modal.buttons.confirm.enabled = isValid && (GUILD.me.discordId !== discordId)
	}
	
	span(modal, { parentKey: "subDesc", text: "#guild_discord_link_can_change_anytime" })

	div(modal, { parentKey: "buttons" })

	btn(modal.buttons, { parentKey: "confirm", className: "button", enabled: false })
	span(modal.buttons.confirm, { parentKey: "label", text: "#guild_discord_link_submit" })
	modal.buttons.confirm.onLeftClick = () => {
		modal.close()

		GameEvents.SendCustomGameEventToServer("Guild:LinkDiscord", { discordId: modal.discordId.textEntry.input.text })
	}

	btn(modal.buttons, { parentKey: "cancel", className: "button", text: "#guild_leave_modal_cancel" })
	modal.buttons.cancel.onLeftClick = () => {
		modal.close()
	}
	
	span(modal, { parentKey: "afterSubmit", text: "#guild_discord_link_after_submit" })

	div(modal, { parentKey: "afterSubmitWarning"})
	img(modal.afterSubmitWarning, { parentKey: "icon", image: ImageUtils.resolve("⚠️")})
	span(modal.afterSubmitWarning, { parentKey: "label", text: "#guild_discord_link_after_submit_warning" })
	
	if (GUILD.me.discordId)
		modal.discordId.textEntry.input.text = GUILD.me.discordId
}