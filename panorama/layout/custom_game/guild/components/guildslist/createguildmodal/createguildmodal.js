--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


function openCreateGuildModal() {
	const modal = openModal("create-guild")
	if (!modal) return

	div(modal, { parentKey: "header" })

	img(modal.header, { parentKey: "icon", image: ImageUtils.resolve("🏰") })
	span(modal.header, { parentKey: "label", text: "#guild_create_title" })
	btn(modal.header, { parentKey: "close", onLeftClick: () => modal.close() })
	div(modal.header.close, { parentKey: "icon" })

	div(modal, { className: "line" })

	div(modal, { parentKey: "content" })

	div(modal.content, { parentKey: "avatar", className: "field" })

	div(modal.content.avatar, { parentKey: "title" })
	span(modal.content.avatar.title, { parentKey: "label", text: "#guild_create_avatar" })
	div(modal.content.avatar.title, { parentKey: "line" })

	div(modal.content.avatar, { parentKey: "list" })

	/** @type {Button} */
	let activeAvatarButton

	for (let avatarNum = 1; avatarNum <= 8; avatarNum++) {
		const avatarButton = btn(modal.content.avatar.list, { className: "avatar" })
		avatarButton.onLeftClick = function () {
			if (avatarButton === activeAvatarButton)
				return

			if (activeAvatarButton)
				activeAvatarButton.SetHasClass("active", false)

			avatarButton.SetHasClass("active", true)
			activeAvatarButton = avatarButton

			onSomethingChange()
		}
		avatarButton.avatarNum = avatarNum

		const avatarImage = ImageUtils.resolveGuildImage(String(avatarNum))

		avatarButton.avatarImage = avatarImage

		img(avatarButton, { className: "image", image: avatarImage })
	}

	div(modal.content, { parentKey: "name", className: "field" })

	div(modal.content.name, { parentKey: "title" })
	span(modal.content.name.title, { parentKey: "label", text: $.Localize("#guild_create_name_title").replace("{MIN}", GUILD.guildNameMinLength).replace("{MAX}", GUILD.guildNameMaxLength) })
	div(modal.content.name.title, { parentKey: "line" })

	textEntry(modal.content.name, { parentKey: "textEntry", placeholder: "#guild_create_name_placeholder", maxChars: GUILD.guildNameMaxLength })
	modal.content.name.textEntry.onChange = function () {
		onSomethingChange()
	}
	span(modal.content.name, { parentKey: "occupied", text: "#guild_create_name_occupied" })
		.visible = false

	div(modal.content, { parentKey: "preview" })
	div(modal.content.preview, { parentKey: "avatar" })
	img(modal.content.preview.avatar, { parentKey: "inner" })
	span(modal.content.preview, { parentKey: "name", text: "#guild_create_name" })

	div(modal, { className: "line" })

	div(modal, { parentKey: "footer" })
	btn(modal.footer, { parentKey: "create", enabled: false })
	span(modal.footer.create, { parentKey: "label", text: "#guild_create_submit" })
	div(modal.footer.create, { parentKey: "price" })
	img(modal.footer.create.price, { parentKey: "icon", image: ICON.CRYSTAL })
	span(modal.footer.create.price, { parentKey: "label", text: GUILD.createGuildPrice })
	modal.footer.create.onLeftClick = function() {
		GameEvents.SendCustomGameEventToServer("Guild:CreateGuild", { avatarNum: activeAvatarButton.avatarNum, name: modal.content.name.textEntry.input.text, locale: $.Language() })
	}

	function onSomethingChange() {
		const avatar = activeAvatarButton ? activeAvatarButton.avatarImage : null
		const name = modal.content.name.textEntry.input.text

		if (avatar)
			modal.content.preview.avatar.inner.SetImage(avatar)

		modal.content.preview.name.text = name.length > 0 ? name : $.Localize("#guild_create_name")

		const nameIsOccupied = GUILDS.cache.some((g) => g.name === name)

		modal.content.name.occupied.visible = nameIsOccupied

		modal.footer.create.enabled = activeAvatarButton && name.length >= GUILD.guildNameMinLength && !nameIsOccupied
	}

	const avatarsList = modal.content.avatar.list

	avatarsList.GetChild(Math.floor(Math.random() * avatarsList.GetChildCount())).onLeftClick()
}