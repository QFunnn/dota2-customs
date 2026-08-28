--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


/**
 * @param {Panel} parent
 * @param {Member} member
*/
function MemberRow(parent, member) {
	const memberRow = btn(parent, { className: "member-row" })
	memberRow.onRightClick = () => {
		const contextMenuOptions = []

		if (GUILD.members.canKickMember(member))
			contextMenuOptions.push({
				id: "kick",
				type: "button",
				text: "#guild_members_actions_member_delete",
				image: ImageUtils.resolve("🚪"),
				onClick: () => openKickMemberModal(member.id),
			})

		if (GUILD.members.canChangeMemberRole(member))
			contextMenuOptions.push({
				id: "role",
				type: "subMenu",
				text: "#guild_members_actions_member_role",
				image: ImageUtils.resolve("👥"),
				options: GUILD.roles.cache
					.reduce((acc, role) => {
						acc.push({
							id: role.id,
							type: "checkbox",
							text: role.name,
							checked: member.role === role,
							onChecked: (checkbox, checked) => {
								if (!checked) {
									checkbox.setChecked(true)
									return
								}

								GameEvents.SendCustomGameEventToServer("Guild:ChangeMemberRole", { targetId: member.id, roleId: role.id })

								const parent = checkbox.GetParent()
								const childCount = parent.GetChildCount()

								for (let i = 0; i < childCount; i++) {
									const child = parent.GetChild(i)
									if (child === checkbox) continue

									child.setChecked(false)
								}
							},
						})

						return acc
					}, []),
			})

		const ctxMenu = contextMenu(contextMenuOptions)
		if (!ctxMenu) return
		
		if (ctxMenu.optionPanels.role) {
			const roleOptionPanels = ctxMenu.optionPanels.role.__contextSubMenuOptions.optionPanels

			const { role: selfRole } = GUILD.me

			GUILD.roles.cache.forEach((role) => {
				const roleOption = roleOptionPanels[role.id]
				if (!roleOption) return

				if (role.hasLimit) {
					const limitSpan = span(roleOption, { parentKey: "limit", text: `(${role.membersCount} / ${role.limit})` })
					
					limitSpan.style.verticalAlign = "center"
					limitSpan.style.marginLeft = "6px"

					limitSpan.style.color = "#e5e0c5"
					limitSpan.style.fontSize = "16px"
					limitSpan.style.fontWeight = "bold"
					limitSpan.style.textShadow = "2px 2px 4px #000000"
				}

				if (role.isLeader || (selfRole.isDeputy && role.isDeputy) || role.limitReached) {
					roleOption.enabled = false
					roleOption.SetHasClass("disabled", true)
				}

				const roleOptionLabel = roleOption.label
				const roleColor = role.color

				roleOptionLabel.style.padding = "2px 4px"

				roleOptionLabel.style.textAlign = "center"

				roleOptionLabel.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(${roleColor}20), to(${roleColor}0a))`
				roleOptionLabel.style.border = `1px solid ${roleColor}4d`
				roleOptionLabel.style.borderRadius = "4px"
				roleOptionLabel.style.color = `${roleColor}e4`
			})
		}
	}

	div(memberRow, { parentKey: "mark" })

	div(memberRow, { parentKey: "level", className: "level-column" })
	span(memberRow.level, { parentKey: "label", text: formatNumber(member.level) })

	div(memberRow, { parentKey: "member", className: "member-column" })
	playerAvatar(memberRow.member, { parentKey: "avatar", steamId: member.id })
	playerName(memberRow.member, { parentKey: "name", steamId: member.id })
	div(memberRow.member, { parentKey: "topMerits" })
	div(memberRow.member.topMerits, { parentKey: "pulse" })
	img(memberRow.member.topMerits, { parentKey: "inner", image: ImageUtils.resolve("🏆") })

	$.Schedule(0, function () {
		if (!memberRow.member.name.IsValid()) return
		const label = memberRow.member.name.GetChild(0)
		if (!label || !label.IsValid()) return

		memberRow.member.name.name = label.text
	})

	div(memberRow, { parentKey: "role", className: "role-column" })
	span(memberRow.role, { parentKey: "label" })
	memberRow.role.update = function () {
		const roleLabel = this.label

		roleLabel.text = member.role.name

		const roleColor = member.role.color

		roleLabel.style.backgroundColor = `gradient(linear, 0% 0%, 100% 50%, from(${roleColor}20), to(${roleColor}0a))`
		roleLabel.style.borderColor = `${roleColor}4d`
		roleLabel.style.color = `${roleColor}e4`
	}
	memberRow.role.update()

	div(memberRow, { parentKey: "exp", className: "exp-column stats" })
	div(memberRow.exp, { parentKey: "wrapper" })
	img(memberRow.exp.wrapper, { parentKey: "icon", image: ICON.EXP })
	span(memberRow.exp.wrapper, { parentKey: "value", text: formatNumber(member.expForLastWeek) })

	div(memberRow, { parentKey: "merits", className: "merits-column stats" })
	div(memberRow.merits, { parentKey: "wrapper" })
	img(memberRow.merits.wrapper, { parentKey: "icon", image: ICON.MERITS })
	span(memberRow.merits.wrapper, { parentKey: "value", text: formatNumber(member.merits) })

	div(memberRow, { parentKey: "crystals", className: "crystals-column stats" })
	div(memberRow.crystals, { parentKey: "wrapper" })
	img(memberRow.crystals.wrapper, { parentKey: "icon", image: ICON.CRYSTAL })
	span(memberRow.crystals.wrapper, { parentKey: "value", text: formatNumber(member.crystalsDonated) })

	div(memberRow, { parentKey: "status", className: "status-column" })
	div(memberRow.status, { parentKey: "wrapper", className: member.isOnline ? "online" : "offline" })
	div(memberRow.status.wrapper, { parentKey: "icon" })
	span(memberRow.status.wrapper, { parentKey: "label" })
	memberRow.status.update = () => {
		if (member.isOnline) {
			memberRow.SetHasClass("online", true)

			memberRow.status.wrapper.SetHasClass("online", true)
			memberRow.status.wrapper.SetHasClass("offline", false)

			memberRow.status.wrapper.label.text = $.Localize("#guild_members_row_status_online")
		} else {
			memberRow.SetHasClass("online", false)

			memberRow.status.wrapper.SetHasClass("online", false)
			memberRow.status.wrapper.SetHasClass("offline", true)

			memberRow.status.wrapper.label.text = member.formattedLastOnline
		}
	}

	return memberRow
}