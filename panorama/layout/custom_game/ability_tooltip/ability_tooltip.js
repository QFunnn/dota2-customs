--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";

const ability_tooltip_hud = (() =>
{
	let panel = $.GetContextPanel()

	while (panel && panel.id !== "DotaHud")
		panel = panel.GetParent()

	return panel
})()

const ability_tooltip_damage = {1: "DamageTypePhysical", 2: "DamageTypeMagical", 4: "DamageTypePure"}

const ability_tooltip_stats =
{
	IsStatPhysicalDamage: "DamageTypePhysical",
	IsStatPhysicalDamagePercentage: "DamageTypePhysical",
	IsStatMagicalDamage: "DamageTypeMagical",
	IsStatMagicalDamagePercentage: "DamageTypeMagical",
	IsStatPureDamage: "DamageTypePure",
	IsStatHealthPercentageAsPureDamage: "DamageTypePure",
}

const ability_tooltip_attributes = {str: true, agi: true, int: true, stats: true}

const ability_tooltip_fields =
{
	abilityduration: "AbilityDuration",
	abilitycastpoint: "AbilityCastPoint",
	abilitycastrange: "AbilityCastRange",
	abilitychargerestoretime: "AbilityChargeRestoreTime",
}

let ability_tooltip_schedule = null
let ability_tooltip_panel = null
let ability_tooltip_stretch = 0

function AbilityTooltipNative()
{
	let tooltips = ability_tooltip_hud.FindChildTraverse("Tooltips")

	return tooltips ? tooltips.FindChildTraverse("DOTAAbilityTooltip") : null
}

function AbilityTooltipCancel()
{
	if (!ability_tooltip_schedule)
		return

	$.CancelScheduled(ability_tooltip_schedule)
	ability_tooltip_schedule = null
}

function AbilityTooltipShow(panel, ability_name, unit)
{
	AbilityTooltipCancel()
	AbilityTooltipHide()

	let native = AbilityTooltipNative()
	let entity = unit !== -1 ? Entities.GetAbilityByName(unit, ability_name) : -1
	let custom = entity !== -1 && panel.id !== "ItemImage" && !Abilities.IsItem(entity)

	if (native)
		native.style.opacity = custom ? "0" : null

	if (!custom)
		return

	ability_tooltip_panel = panel
	ability_tooltip_schedule = $.Schedule(0, () =>
	{
		$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "ability_tooltip", "file://{resources}/layout/custom_game/ability_tooltip/ability_tooltip.xml", "entity=" + entity + "&ability=" + ability_name)
		ability_tooltip_schedule = $.Schedule(0.1, AbilityTooltipWatch)
	})
}

function AbilityTooltipWatch()
{
	ability_tooltip_schedule = null

	if (ability_tooltip_panel.IsValid() && ability_tooltip_panel.BHasHoverStyle())
	{
		ability_tooltip_schedule = $.Schedule(0.1, AbilityTooltipWatch)
		return
	}

	AbilityTooltipHide()
}

function AbilityTooltipHide()
{
	if (!ability_tooltip_panel)
		return

	if (ability_tooltip_panel.IsValid())
		$.DispatchEvent("UIHideCustomLayoutTooltip", ability_tooltip_panel, "ability_tooltip")

	let native = AbilityTooltipNative()

	if (native)
		native.style.opacity = null

	ability_tooltip_panel = null
}

function AbilityTooltipNumber(value)
{
	return String(Number(value.toFixed(3)))
}

function AbilityTooltipActive(count, level, max)
{
	if (count === 1)
		return 0

	return count === max ? level - 1 : -1
}

function AbilityTooltipSpans(values, active, damage)
{
	let type = damage ? " " + damage : ""
	let spans = values.map((value, index) => "<span class='GameplayValues" + type + (index === active ? " GameplayVariable" : "") + "'>" + value + "</span>")

	return spans.join("<span class='GameplayValues'> / </span>")
}

function AbilityTooltipKey(text)
{
	return text.replace(/^[%+$\-]+/, "").replace(/:\s*$/, "").trim().toUpperCase()
}

function AbilityTooltipCopy(details, id, visible)
{
	let source = details.FindChildTraverse(id)
	let target = $("#" + id)
	let show = visible && source !== null && !source.BHasClass("Hidden") && source.text !== "" && source.text !== "0"

	target.SetHasClass("Hidden", !show)

	if (show)
		target.text = source.text

	return show
}

function AbilityTooltipCost(details, id, level, max)
{
	if (!AbilityTooltipCopy(details, id, true))
		return

	let target = $("#" + id)
	let values = target.text.split(" / ")

	target.text = AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max), "")
}

function AbilityTooltipStat(caster, player_id, stat)
{
	if (stat === "max_health")
		return Entities.GetMaxHealth(caster)

	if (stat === "max_mana")
		return Entities.GetMaxMana(caster)

	if (stat === "attack")
		return (Entities.GetDamageMin(caster) + Entities.GetDamageMax(caster))/2 + Entities.GetDamageBonus(caster)

	let stats = Game.player_stats[player_id]

	if (!stats)
		return undefined

	return stat === "stats" ? stats.str + stats.agi + stats.int : stats[stat]
}

function AbilityTooltipBonus(entity, ability_name)
{
	let caster = Abilities.GetCaster(entity)
	let hero = Entities.GetUnitName(caster)
	let player_id = Entities.GetPlayerOwnerID(caster)
	let talents = Game.talents_values[hero]
	let spells = Game.spells_by_number[hero]
	let bonus = {value: {}, percent: {}, talents: {}}

	if (!talents || !spells)
		return bonus

	for (let name in talents)
	{
		let data = talents[name]

		if (!data.tooltip || !Game.HasTalent(player_id, name))
			continue

		let spell = spells[data.skill_number]

		if ((data.tooltip_ability || (spell && spell.name)) !== ability_name)
			continue

		let rules = data.alt_talent && Game.HasTalent(player_id, data.alt_talent) ? data.tooltip_alt : data.tooltip

		if (!rules)
			continue

		for (let key in rules)
		{
			let add = 0
			let percent = 0

			for (let term of rules[key].split("+"))
			{
				let parts = term.trim().split("*")
				let mult = parts[1] || (ability_tooltip_attributes[parts[0]] ? parts[0] : undefined)
				let value = Number(Game.GetTalentValue(name, parts[0], player_id, true))

				if (mult === "kv")
				{
					percent += value
					continue
				}

				if (mult === "perma")
				{
					let buff = Game.FindModifier(caster, data.mod_name)
					value = buff !== -1 ? Math.round(value*Buffs.GetStackCount(caster, buff)/data.max) : 0
				}
				else if (mult)
				{
					let stat_value = AbilityTooltipStat(caster, player_id, mult)

					if (stat_value === undefined)
						continue

					value = Math.round(value*stat_value/100)
				}

				add += value
			}

			if (add === 0 && percent === 0)
				continue

			bonus.value[key] = (bonus.value[key] || 0) + add
			bonus.percent[key] = (bonus.percent[key] || 0) + percent
			bonus.talents[key] = (bonus.talents[key] || []).concat([{hero: hero, icon: data.mini_icon, rarity: data.rarity}])
		}
	}

	return bonus
}

function AbilityTooltipLevels(entity, key, max, bonus)
{
	let name = ability_tooltip_fields[key] || key
	let values = []

	for (let i = 0; i < max; i++)
		values.push(AbilityTooltipNumber(Abilities.GetLevelSpecialValueFor(entity, name, i)*(1 + (bonus.percent[key] || 0)/100) + (bonus.value[key] || 0)))

	if (values.every(value => value === values[0]))
		values = [values[0]]

	return values
}

function AbilityTooltipValues(text, entity, level, max, bonus)
{
	text = text.replace(/%([A-Za-z0-9_]+)%(%%)?/g, (match, value_name, percent) =>
	{
		let values = AbilityTooltipLevels(entity, value_name, max, bonus).map(value => value.replace("-", "") + (percent ? "%" : ""))

		return AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max), "")
	})

	return text.replace(/%%/g, "%")
}

function AbilityTooltipDescription(entity, ability_name, level, max, bonus)
{
	let key = "#DOTA_Tooltip_ability_" + ability_name + "_Description"
	let text = $.Localize(key)

	if (text === key)
		return ""

	return AbilityTooltipValues(text, entity, level, max, bonus)
}

function AbilityTooltipExtra(details, details_v2, entity, ability_name, level, max, bonus)
{
	let source = details.FindChildTraverse("AbilityExtraAttributes")
	let stats = {}

	for (let row of details_v2.FindChildrenWithClassTraverse("StatRow"))
	{
		let label = row.FindChildrenWithClassTraverse("StatLabel")[0]

		if (!label)
			continue

		for (let name in ability_tooltip_stats)
		{
			if (row.BHasClass(name))
				stats[AbilityTooltipKey(label.text)] = ability_tooltip_stats[name]
		}
	}

	let overrides = {}
	let sources = {}

	for (let key in bonus.talents)
	{
		let label_key = "#DOTA_Tooltip_ability_" + ability_name + "_" + key
		let label = $.Localize(label_key)

		if (label === label_key)
			continue

		let percent = label.trim().startsWith("%") ? "%" : ""
		overrides[AbilityTooltipKey(label)] = AbilityTooltipLevels(entity, key, max, bonus).map(value => value + percent)
		sources[AbilityTooltipKey(label)] = bonus.talents[key]
	}

	let colors = null
	let caster = Abilities.GetCaster(entity)

	let paint = text => text.replace(/\(([^)]+)\)/g, (match, word) =>
	{
		if (!colors)
		{
			colors = {}

			for (let i = 0; i < Entities.GetAbilityCount(caster); i++)
			{
				let ability = Entities.GetAbility(caster, i)

				if (ability === -1)
					continue

				for (let color of $.Localize("#DOTA_Tooltip_ability_" + Abilities.GetAbilityName(ability) + "_Description").matchAll(/<font color='(#[0-9a-fA-F]+)'>([^<]+?):?<\/font>/g))
					colors[color[2].trim().toUpperCase()] = color[1]
			}
		}

		let color = colors[word.toUpperCase()]

		return color ? "(<font color='" + color + "'>" + word + "</font>)" : match
	})
	let container = $("#AbilityExtraAttributes")
	let lines = source.text.split("\n").filter(line => line.trim() !== "")

	container.RemoveAndDeleteChildren()

	for (let line of lines)
	{
		let row = $.CreatePanel("Panel", container, "")
		row.AddClass("AbilityStatRow")

		let text = $.CreatePanel("Label", row, "")
		text.html = true
		text.AddClass("AbilityStatText")

		let split = line.indexOf(": ")

		if (split === -1)
		{
			text.text = paint(line.replace(/-(?=\d)/g, ""))
			continue
		}

		let label = line.substring(0, split + 1)
		let line_key = AbilityTooltipKey(label)
		let values = (overrides[line_key] || line.substring(split + 2).split(" / ")).map(value => value.replace("-", ""))

		text.text = paint(label) + " " + AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max), stats[line_key] || "")

		for (let talent of sources[line_key] || [])
		{
			let icon = $.CreatePanel("Panel", row, "")
			icon.AddClass("AbilityTalentIcon")
			icon.AddClass("AbilityTalentIcon_" + talent.rarity)
			icon.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + talent.hero + '/' + talent.icon + '.png")'
			icon.style.backgroundSize = "contain"
		}
	}

	return lines.length
}

function AbilityTooltipStretch(id, attempt)
{
	let header = $("#AbilityHeader")
	let description = $("#AbilityDescription")

	if (id !== ability_tooltip_stretch || !header.IsValid())
		return

	if (header.actuallayoutwidth === 0 && attempt < 10)
	{
		$.Schedule(0, () => AbilityTooltipStretch(id, attempt + 1))
		return
	}

	let scale = header.actualuiscale_x
	let extra = Math.floor((header.actuallayoutwidth - description.actuallayoutwidth)/scale) - 10

	if (description.BHasClass("Hidden") || extra <= 0)
		return

	description.style.width = (330 + extra) + "px"
	$("#AbilityLore").style.width = (330 + extra) + "px"

	for (let panel of $.GetContextPanel().FindChildrenWithClassTraverse("AbilityCreeps"))
		panel.style.width = (322 + extra) + "px"

	for (let panel of $.GetContextPanel().FindChildrenWithClassTraverse("AbilityCreepsLine"))
		panel.style.width = (322 + extra) + "px"
}

function AbilityTooltipLoaded()
{
	let entity = Number($.GetContextPanel().GetAttributeString("entity", "-1"))
	let ability_name = $.GetContextPanel().GetAttributeString("ability", "")
	let native = AbilityTooltipNative()

	if (entity === -1 || !native)
		return

	for (let id of ["AbilityDescription", "AbilityLore", "AbilityCreeps_buff", "AbilityCreeps_nerf"])
		$("#" + id).style.width = null

	let stretch = ++ability_tooltip_stretch
	$.Schedule(0, () => AbilityTooltipStretch(stretch, 0))

	let details = native.FindChildTraverse("AbilityDetails")
	let details_v2 = native.FindChildTraverse("AbilityDetailsV2")
	let level = Abilities.GetLevel(entity)
	let max = Abilities.GetMaxLevel(entity)

	AbilityTooltipCopy(details, "AbilityName", true)
	AbilityTooltipCopy(details, "AbilitySpellImmunityType", true)
	AbilityTooltipCopy(details, "AbilityDispelType", true)
	AbilityTooltipCopy(details, "AbilityBreakable", details.BHasClass("is_breakable"))
	$("#AbilityLoreBox").SetHasClass("Hidden", !AbilityTooltipCopy(details, "AbilityLore", !details.BHasClass("HideLore")))

	let damage = ability_tooltip_damage[Abilities.GetAbilityDamageType(entity)]

	if (AbilityTooltipCopy(details, "AbilityDamageType", true) && damage)
	{
		let damage_label = $("#AbilityDamageType")
		let split = damage_label.text.indexOf(": ")

		if (split !== -1)
			damage_label.text = damage_label.text.substring(0, split + 2) + "<span class='GameplayValues " + damage + "'>" + damage_label.text.substring(split + 2) + "</span>"
	}

	let target = ["AbilityDamageType", "AbilitySpellImmunityType", "AbilityDispelType", "AbilityBreakable"].some(id => !$("#" + id).BHasClass("Hidden"))
	$("#AbilityTarget").SetHasClass("Hidden", !target)
	$("#AbilityDescription").SetHasClass("AfterHeader", !target)

	let cooldown = details.FindChildTraverse("AbilityCooldown")
	let cooldowns = cooldown && !cooldown.BHasClass("Hidden") ? cooldown.text.split(" / ") : []
	let current_cooldown = cooldowns[Math.min(Math.max(level, 1), cooldowns.length) - 1]

	$("#CurrentAbilityCooldown").SetHasClass("Hidden", !current_cooldown || current_cooldown === "0")
	$("#CurrentAbilityCooldown").text = current_cooldown || ""

	let charges = Abilities.UsesAbilityCharges(entity) ? Abilities.GetMaxAbilityCharges(entity) : 0
	let charges_form = charges % 10 === 1 && charges % 100 !== 11 ? 1 : charges % 10 >= 2 && charges % 10 <= 4 && (charges % 100 < 10 || charges % 100 >= 20) ? 2 : 5

	$("#CurrentAbilityCharges").SetHasClass("Hidden", charges <= 0)
	$("#CurrentAbilityCharges").text = charges + " " + $.Localize("#tooltip_ability_charges_" + charges_form)
	AbilityTooltipCost(details, "AbilityCooldown", level, max)
	AbilityTooltipCost(details, "AbilityManaCost", level, max)
	AbilityTooltipCost(details, "AbilityHealthCost", level, max)
	AbilityTooltipCost(details, "AbilityCastRange", level, max)

	$("#AbilityCostsSeparator").SetHasClass("Hidden", ["AbilityCooldown", "AbilityManaCost", "AbilityHealthCost", "AbilityCastRange"].every(id => $("#" + id).BHasClass("Hidden")))

	let bonus = AbilityTooltipBonus(entity, ability_name)

	let description = AbilityTooltipDescription(entity, ability_name, level, max, bonus)
	$("#AbilityDescription").SetHasClass("Hidden", description === "")
	$("#AbilityDescription").text = description

	let creeps = {buff: [], nerf: []}
	let creeps_damage = AbilityTooltipLevels(entity, "creeps_damage", max, bonus)

	if (creeps_damage.some(value => value !== "0"))
	{
		let type = creeps_damage.some(value => value.startsWith("-")) ? "nerf" : "buff"
		creeps[type].push(AbilityTooltipValues($.Localize("#tooltip_ability_creeps_damage_" + type), entity, level, max, bonus))
	}

	for (let type in creeps)
	{
		for (let i = 1; ; i++)
		{
			let key = "#DOTA_Tooltip_ability_" + ability_name + "_creeps_" + type + i
			let text = $.Localize(key)

			if (text === key)
				break

			creeps[type].push(AbilityTooltipValues(text, entity, level, max, bonus))
		}

		$("#AbilityCreeps_" + type).SetHasClass("Hidden", creeps[type].length === 0)

		let lines = $("#AbilityCreepsText_" + type)
		lines.RemoveAndDeleteChildren()

		for (let line of creeps[type])
		{
			let label = $.CreatePanel("Label", lines, "")
			label.html = true
			label.AddClass("AbilityCreepsLine")
			label.text = line
		}
	}

	let extra = AbilityTooltipExtra(details, details_v2, entity, ability_name, level, max, bonus)
	$("#AbilityExtraAttributes").SetHasClass("Hidden", extra === 0)
}

if (!$.GetContextPanel().BHasClass("AbilityTooltip") && !$.DbgIsReloadingScript())
{
	$.RegisterEventHandler("DOTAShowAbilityTooltip", ability_tooltip_hud, (panel, ability_name) => AbilityTooltipShow(panel, ability_name, -1))
	$.RegisterEventHandler("DOTAShowAbilityTooltipForEntityIndex", ability_tooltip_hud, (panel, ability_name, unit) => AbilityTooltipShow(panel, ability_name, unit))
}