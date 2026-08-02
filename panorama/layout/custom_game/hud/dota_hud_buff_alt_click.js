--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


const LocalizeFormat = function (...args) {
	let formatted = $.Localize(args[0])
	for (let i = 1; i < args.length; i++) {
		const regex = new RegExp(`%s${i}`, 'g')
		formatted = formatted.replace(regex, args[i])
	}
	return formatted
}

const GetPlayerColorHex = (playerID) => {
	let color = Players.GetPlayerColor(playerID).toString(16)
	color = color.substring(6, 8) + color.substring(4, 6) + color.substring(2, 4) + color.substring(0, 2)
	return `#${color}`
}

const AlertBehavior_Skip = Symbol("AlertBehavior_Skip")
const ExplicitBehaviors = {
	["modifier_player_exp"]: function (data) {
		const { playerid, ent, serial } = data
		
		const targetEntOwnerPlayer = Entities.GetPlayerOwnerID(ent)

		const isEnemy = Entities.IsEnemy(ent)
		const locString = targetEntOwnerPlayer == playerid
			? "#DOTA_Modifier_Alert"
			: Entities.IsHero(ent)
				? isEnemy
					? "#DOTA_Modifier_Alert_Enemy_Hero"
					: "#DOTA_Modifier_Alert_Ally_Hero"
				: isEnemy
					? "#DOTA_Modifier_Alert_Enemy_Unit"
					: "#DOTA_Modifier_Alert_Ally_Unit"
		const stackCount = Buffs.GetStackCount(ent, serial)

		const s1 = Buffs.IsDebuff(ent, serial) ? "#ff0000" : "#00ff00"
		const s2 = $.Localize("#DOTA_Tooltip_modifier_player_exp")
		const s3 = ` ${stackCount}%`
		switch (locString) {
			case "#DOTA_Modifier_Alert": {
				return [
					locString,
					[s1, s2, s3, ""]
				]
			}
			default: {
				const s4 = GetPlayerColorHex(targetEntOwnerPlayer)
				const s5 = $.Localize(`#${Entities.GetUnitName(ent)}`)
				return [
					locString,
					[s1, s2, s3, s4, s5]
				]
			}
		}
	},
	modifier_ability_test_passive: function (data) {
		// Custom behavior example
		const { playerid, ent, serial, hasstacks } = data
		return [
			"#Custom_Modifier_Alert", // loc_string like "%s1 is %s2 affected by %s3"
			[
				//params
			]
		]
	}
}

GameEvents.Subscribe("cdota_buff_alert", function (data) {
	const { playerid, ent, serial, hasstacks } = data

	if (Players.GetTeam(playerid) != Players.GetTeam(Players.GetLocalPlayer())) return

	const name = Buffs.GetName(ent, serial)
	if (name === "") return

	const behavior = ExplicitBehaviors[name]
	if (behavior) {
		const [loc_string, values] = behavior(data)
		$.DispatchEvent("DOTAChatMessagePrintf", LocalizeFormat(loc_string, ...values), playerid, 0)
	} else {
		const locKey = "#DOTA_Tooltip_" + name
		const s3 = $.Localize(locKey)
		if (s3 === locKey) return

		const targetEntOwnerPlayer = Entities.GetPlayerOwnerID(ent)

		const remainingTime = Buffs.GetRemainingTime(ent, serial)
		const hasDuration = Buffs.GetDuration(ent, serial) > 0 && remainingTime > 0
		const isEnemy = Entities.IsEnemy(ent)
		const loc_string = targetEntOwnerPlayer == playerid
			? "#DOTA_Modifier_Alert"
			: Entities.IsHero(ent)
				? isEnemy
					? "#DOTA_Modifier_Alert_Enemy_Hero"
					: "#DOTA_Modifier_Alert_Ally_Hero"
				: isEnemy
					? "#DOTA_Modifier_Alert_Enemy_Unit"
					: "#DOTA_Modifier_Alert_Ally_Unit"
		const stackCount = Buffs.GetStackCount(ent, serial)

		const s1 = Buffs.IsDebuff(ent, serial) ? "#ff0000" : "#00ff00"
		const s2 = hasstacks || stackCount > 1 ? `${stackCount} ` : ""
		switch (loc_string) {
			case "#DOTA_Modifier_Alert": {
				const s4 = hasDuration ? LocalizeFormat("#DOTA_Modifier_Alert_Time_Remaining", remainingTime.toFixed(1)) : ""
				$.DispatchEvent("DOTAChatMessagePrintf", LocalizeFormat(loc_string, s1, s2, s3, s4), playerid, 0)
				break
			}
			default: {
				const s4 = GetPlayerColorHex(targetEntOwnerPlayer)
				const s5 = $.Localize(`#${Entities.GetUnitName(ent)}`)
				const s6 = hasDuration ? LocalizeFormat("#DOTA_Modifier_Alert_Time_Remaining", remainingTime.toFixed(1)) : ""
				$.DispatchEvent("DOTAChatMessagePrintf", LocalizeFormat(loc_string, s1, s2, s3, s4, s5, s6), playerid, 0)
			}
		}
	}
})

let ping_stacks = 2
let ping_cooldown = 5

$.RegisterForUnhandledEvent("DOTAShowBuffTooltip", function (buffpanel, ent, serial) {
	const button = buffpanel.GetChild(0)
	if (button) {
		const name = Buffs.GetName(ent, serial)
		button.SetPanelEvent("onactivate", function () {
			if (ExplicitBehaviors[name] == AlertBehavior_Skip) {
				Players.BuffClicked(ent, serial, IsDotaAltPressed())
			} else if (IsDotaAltPressed()) {
				if (ping_stacks <= 0) {
					return
				}
				ping_stacks--
				$.Schedule(ping_cooldown, () => {
					ping_stacks++
				})
				GameEvents.SendCustomGameEventToAllClients("cdota_buff_alert", {
					playerid: Players.GetLocalPlayer(),
					ent: ent,
					serial: serial,
					hasstacks: buffpanel.BHasClass("has_stacks"),
				})
			}
		})
	}
})