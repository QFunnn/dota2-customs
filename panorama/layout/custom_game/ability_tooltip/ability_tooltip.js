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

const ability_tooltip_block_icons = {Diff: "dota", Features: "dota", Buildings: "buildings"}

const ability_tooltip_costs = ["AbilityCooldown", "AbilityManaCost", "AbilityHealthCost", "AbilityCastPoint", "AbilityCastRange"]

const ability_tooltip_fields =
{
	abilityduration: "AbilityDuration",
	abilitycastpoint: "AbilityCastPoint",
	abilitycastrange: "AbilityCastRange",
	abilitychargerestoretime: "AbilityChargeRestoreTime",
}

const ability_tooltip_status =
{
	aghs: {native: "DOTAHUDAghsStatusTooltip", show: "DOTAShowAghsStatusDisplayTooltip", hide: "DOTAHideAghsStatusDisplayTooltip"},
	innate: {native: "DOTAHUDInnateStatusTooltip", show: "DOTAShowInnateDisplayTooltip", hide: "DOTAHideInnateDisplayTooltip"},
}

const ability_tooltip_branches = (() =>
{
	let result = []

	for (let mask = 1; mask < 16; mask++)
		result.push(["q", "w", "e", "r"].filter((branch, index) => mask & (1 << index)).join(""))

	return result
})()

let ability_tooltip_schedule = null
let ability_tooltip_panel = null
let ability_tooltip_stretch = 0
let ability_tooltip_reveal = 0
let ability_tooltip_tooltips = null
let ability_tooltip_colors = {}
let ability_tooltip_status_schedule = {}

function AbilityTooltipNative(id)
{
	if (!ability_tooltip_tooltips || !ability_tooltip_tooltips.IsValid())
		ability_tooltip_tooltips = ability_tooltip_hud.FindChildTraverse("Tooltips")

	return ability_tooltip_tooltips ? ability_tooltip_tooltips.FindChildTraverse(id) : null
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

	let native = AbilityTooltipNative("DOTAAbilityTooltip")
	let entity = unit !== -1 ? Entities.GetAbilityByName(unit, ability_name) : -1
	let custom = entity !== -1 && panel.id !== "ItemImage" && !Abilities.IsItem(entity)

	if (native)
		native.style.opacity = custom ? "0" : null

	if (!custom)
		return

	ability_tooltip_panel = panel
	ability_tooltip_schedule = $.Schedule(0, () =>
	{
		ability_tooltip_schedule = null
		$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, "ability_tooltip", "file://{resources}/layout/custom_game/ability_tooltip/ability_tooltip.xml", "entity=" + entity + "&ability=" + ability_name)
	})
}

function AbilityTooltipLeave(panel)
{
	if (panel && ability_tooltip_panel && panel !== ability_tooltip_panel)
		return

	AbilityTooltipCancel()
	AbilityTooltipHide()
}

function AbilityTooltipHide()
{
	if (!ability_tooltip_panel)
		return

	if (ability_tooltip_panel.IsValid())
		$.DispatchEvent("UIHideCustomLayoutTooltip", ability_tooltip_panel, "ability_tooltip")

	let native = AbilityTooltipNative("DOTAAbilityTooltip")

	if (native)
		native.style.opacity = null

	ability_tooltip_panel = null
}

function AbilityTooltipNumber(value)
{
	return String(Number(value.toFixed(2)))
}

function AbilityTooltipActive(count, level, max, orb)
{
	if (count === 1)
		return 0

	if (orb)
		return orb.active

	return count === max ? level - 1 : -1
}

function AbilityTooltipOrbs(caster, keys)
{
	let result = {}
	let orbs = {}
	let extra = null

	for (let key in keys)
	{
		let levelkey = keys[key]

		if (levelkey === "dynamic")
			continue

		if (!(levelkey in orbs))
		{
			if (extra === null)
				extra = Number(Game.GetTalentValue("modifier_invoker_invoke_4", "level", Entities.GetPlayerOwnerID(caster), true)) || 0

			let orb = Entities.GetAbilityByName(caster, "invoker_" + levelkey.replace("level", "") + "_custom")
			orbs[levelkey] = orb !== -1 ? {count: Abilities.GetMaxLevel(orb) + extra, active: Abilities.GetLevel(orb) - 1 + extra} : null
		}

		if (orbs[levelkey])
			result[key] = orbs[levelkey]
	}

	return result
}

function AbilityTooltipSpans(values, active, damage)
{
	let type = damage ? " " + damage : ""
	let spans = values.map((value, index) => "<span class='GameplayValues" + type + (index === active ? " GameplayVariable" : "") + "'>" + value + "</span>")

	return spans.join("<span class='GameplayValues'> / </span>")
}

function AbilityTooltipKey(text)
{
	return text.replace(/<[^>]*>/g, "").replace(/^[%+$\-]+/, "").replace(/:\s*$/, "").trim().toUpperCase()
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
	let ability_keys = (CustomNetTables.GetTableValue("custom_pick", "ability_keys_" + hero) || {})[ability_name] || {}
	let bonus = {value: {}, percent: {}, all: {}, replace: {}, changed: {}, talents: {}, levels: {}, keys: ability_keys, orbs: AbilityTooltipOrbs(caster, ability_keys)}

	if (!talents || !spells)
		return bonus

	for (let name in talents)
	{
		let data = talents[name]

		if (!data.tooltip)
			continue

		let rules = data.alt_talent && Game.HasTalent(player_id, data.alt_talent) ? data.tooltip_alt : data.tooltip

		if (!rules)
			continue

		let spell = spells[data.skill_number]
		let keys = rules[ability_name] || (spell && spell.name === ability_name ? rules.default : undefined)

		if (!keys)
			continue

		let taken = Game.HasTalent(player_id, name)
		let talent = {hero: hero, icon: data.mini_icon, rarity: data.rarity, taken: taken}
		let buff = taken && data.mod_name ? Game.FindModifier(caster, data.mod_name) : -1
		let stacks = buff !== -1 ? Buffs.GetStackCount(caster, buff) : 0

		for (let key in keys)
		{
			let penalty = keys[key].trim().startsWith("~")
			let expression = keys[key].trim().replace(/^~/, "")

			if (!taken)
			{
				if (!penalty)
					(bonus.talents[key] = bonus.talents[key] || []).push(talent)

				continue
			}

			let marker = ability_tooltip_costs.includes(key) || expression === "icon"
			let add = 0
			let percent = 0
			let all = 0
			let replace = marker && expression === "=0" ? 0 : undefined
			let plain = false

			for (let term of marker ? [] : expression.split("+"))
			{
				if (term.trim() === "")
				{
					plain = true
					continue
				}

				let parts = term.trim().replace(/^=/, "").split("*")
				let mult = parts.length > 1 ? parts.pop() : (!plain && ability_tooltip_attributes[parts[0]] ? parts[0] : undefined)
				plain = false
				let value = parts.reduce((result, part) =>
				{
					let field = part.replace(/%$/, "")
					let number = Number(field)

					if (field === "stacks")
						number = stacks
					else if (isNaN(number))
						number = Number(Game.GetTalentValue(name, field, player_id, true))

					return result*(part.endsWith("%") ? number/100 : number)
				}, 1)

				if (term.trim().startsWith("="))
				{
					replace = value
					continue
				}

				if (mult === "kv")
				{
					percent += value
					continue
				}

				if (mult === "all")
				{
					all += value
					continue
				}

				if (mult === "perma")
					value = Math.round(value*stacks/data.max)
				else if (mult)
				{
					let stat_value = AbilityTooltipStat(caster, player_id, mult)

					if (stat_value === undefined)
						continue

					value = Math.round(value*stat_value/100)
				}

				add += value
			}

			if (!marker && add === 0 && percent === 0 && all === 0 && replace === undefined)
				continue

			if (replace !== undefined)
				bonus.replace[key] = replace

			if (!marker)
				bonus.changed[key] = true

			bonus.value[key] = (bonus.value[key] || 0) + add
			bonus.percent[key] = (bonus.percent[key] || 0) + percent
			bonus.all[key] = (bonus.all[key] || 0) + all

			if (!penalty)
				(bonus.talents[key] = bonus.talents[key] || []).push(talent)
		}
	}

	return bonus
}

function AbilityTooltipTalentIcon(parent, talent)
{
	let icon = $.CreatePanel("Panel", parent, "")
	icon.AddClass("AbilityTalentIcon")
	icon.AddClass("AbilityTalentIcon_" + talent.rarity)
	icon.SetHasClass("AbilityTalentIcon_off", !talent.taken)

	let image = $.CreatePanel("Panel", icon, "")
	image.AddClass("AbilityTalentIconImage")
	image.style.backgroundImage = 'url("file://{images}/custom_game/icons/mini/' + talent.hero + '/' + talent.icon + '.png")'
	image.style.backgroundSize = "contain"

	return icon
}


function AbilityTooltipLevels(entity, key, max, bonus)
{
	if (bonus.levels[key])
		return bonus.levels[key]

	let name = ability_tooltip_fields[key] || key
	let orb = bonus.orbs[key]
	let values = []

	for (let i = 0; i < (orb ? orb.count : max); i++)
	{
		let base = bonus.replace[key] !== undefined ? bonus.replace[key] : Abilities.GetLevelSpecialValueFor(entity, name, i)
		values.push(AbilityTooltipNumber((base*(1 + (bonus.percent[key] || 0)/100) + (bonus.value[key] || 0))*(1 + (bonus.all[key] || 0)/100)))
	}

	if (values.every(value => value === values[0]))
		values = [values[0]]

	bonus.levels[key] = values

	return values
}

function AbilityTooltipValues(text, entity, level, max, bonus)
{
	text = text.replace(/%([A-Za-z0-9_]+)%(%%)?/g, (match, value_name, percent) =>
	{
		let values = AbilityTooltipLevels(entity, value_name, max, bonus).map(value => value.replace("-", "") + (percent ? "%" : ""))

		return AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max, bonus.orbs[value_name]), "")
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

function AbilityTooltipLegendary(container, prefix, entity, level, max, bonus)
{
	let caster = Abilities.GetCaster(entity)
	let player_id = Entities.GetPlayerOwnerID(caster)
	let talents = Game.talents_values[Entities.GetUnitName(caster)] || {}
	let legendary = {}

	for (let name in talents)
	{
		let data = talents[name]
		let branch = ["q", "w", "e", "r"][data.skill_number - 1]

		if (data.rarity === "orange" && branch && !legendary[branch])
			legendary[branch] = {icon: data.skill_icon, build: data.build_type, taken: Game.HasTalent(player_id, name)}
	}

	let taken = Object.keys(legendary).some(branch => legendary[branch].taken)
	let variants = []
	container.RemoveAndDeleteChildren()

	for (let branches of ability_tooltip_branches)
	{
		let key = prefix + branches
		let text = $.Localize(key)

		if (text === key)
			continue

		let shown = branches.split("")

		if (taken && !shown.some(branch => legendary[branch] && legendary[branch].taken))
			continue

		let build = shown.map(branch => legendary[branch] && legendary[branch].build).find(value => value) || 0
		variants.push({shown: shown, build: build, text: text})
	}

	variants.sort((a, b) => (a.build || 3) - (b.build || 3))

	for (let variant of variants)
	{
		let block = $.CreatePanel("Panel", container, "")
		block.AddClass("AbilityLegendaryBlock")
		block.AddClass("AbilityLegendaryBuild_" + variant.build)

		let header = $.CreatePanel("Panel", block, "")
		header.AddClass("AbilityLegendaryHeader")

		let title = $.CreatePanel("Label", header, "")
		title.AddClass("AbilityLegendaryTitle")
		title.text = $.Localize("#tooltip_ability_legendary")

		for (let index = 0; index < variant.shown.length; index++)
		{
			let branch = variant.shown[index]

			if (index > 0)
			{
				let or = $.CreatePanel("Label", header, "")
				or.AddClass("AbilityLegendaryTitle")
				or.AddClass("AbilityLegendaryOr")
				or.text = $.Localize("#tooltip_ability_or")
			}

			if (legendary[branch])
			{
				let icon = $.CreatePanel("Panel", header, "")
				icon.AddClass("AbilityLegendaryIcon")
				icon.style.backgroundImage = "url('file://{images}/custom_game/icons/skills/" + legendary[branch].icon + ".png')"
				icon.style.backgroundSize = "100% 100%"
				continue
			}

			let letter = $.CreatePanel("Label", header, "")
			letter.AddClass("AbilityLegendaryTitle")
			letter.text = branch.toUpperCase()
		}

		let separator = $.CreatePanel("Panel", block, "")
		separator.AddClass("AbilityLegendarySeparator")

		let label = $.CreatePanel("Label", block, "")
		label.html = true
		label.AddClass("AbilityLegendaryText")
		label.text = AbilityTooltipValues(variant.text, entity, level, max, bonus)
	}

	container.SetHasClass("Hidden", container.GetChildCount() === 0)
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
	let row_orbs = {}
	let dynamic = {}

	for (let key of new Set(Object.keys(bonus.talents).concat(Object.keys(bonus.changed), Object.keys(bonus.keys))))
	{
		let label_key = "#DOTA_Tooltip_ability_" + ability_name + "_" + key
		let label = $.Localize(label_key)

		if (label === label_key)
			continue

		let line_key = AbilityTooltipKey(label)
		let percent = label.trim().startsWith("%") ? "%" : ""

		if (bonus.orbs[key] || bonus.changed[key])
			overrides[line_key] = AbilityTooltipLevels(entity, key, max, bonus).map(value => value + percent)

		sources[line_key] = bonus.talents[key] || []
		row_orbs[line_key] = bonus.orbs[key]
		dynamic[line_key] = bonus.keys[key] === "dynamic"
	}

	let caster = Abilities.GetCaster(entity)
	let hero = Entities.GetUnitName(caster)

	let paint = text => text.replace(/\(([^)]+)\)/g, (match, word) =>
	{
		if (!ability_tooltip_colors[hero])
		{
			ability_tooltip_colors[hero] = {}

			for (let i = 0; i < Entities.GetAbilityCount(caster); i++)
			{
				let ability = Entities.GetAbility(caster, i)

				if (ability === -1)
					continue

				for (let color of $.Localize("#DOTA_Tooltip_ability_" + Abilities.GetAbilityName(ability) + "_Description").matchAll(/<font color='(#[0-9a-fA-F]+)'>([^<]+?):?<\/font>/g))
					ability_tooltip_colors[hero][color[2].trim().toUpperCase()] = color[1]
			}
		}

		let color = ability_tooltip_colors[hero][word.toUpperCase()]

		return color ? "(<font color='" + color + "'>" + word + "</font>)" : match
	})

	let container = $("#AbilityExtraAttributes")
	let lines = source.text.split("\n").filter(line => line.trim() !== "")
	let rows = []

	for (let index = 0; index < lines.length; index++)
	{
		let line = lines[index]
		let wrap = line.trim().endsWith(":") && index + 1 < lines.length && lines[index + 1].indexOf(":") === -1

		if (wrap)
			line = line.trim() + " " + lines[++index].trim()

		let split = line.indexOf(": ")
		rows.push({line: line, wrap: wrap, split: split, key: split === -1 ? "" : AbilityTooltipKey(line.substring(0, split + 1))})
	}

	container.RemoveAndDeleteChildren()

	for (let data of rows.filter(data => !dynamic[data.key]).concat(rows.filter(data => dynamic[data.key])))
	{
		let row = $.CreatePanel("Panel", container, "")
		row.AddClass("AbilityStatRow")

		let text = $.CreatePanel("Label", row, "")
		text.html = true
		text.AddClass("AbilityStatText")

		if (data.split === -1)
		{
			text.text = paint(data.line.replace(/-(?=\d)/g, ""))
			continue
		}

		let label = data.line.substring(0, data.split + 1)
		let values = (overrides[data.key] || data.line.substring(data.split + 2).split(" / ")).map(value => value.replace("-", ""))

		let spans = AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max, row_orbs[data.key]), stats[data.key] || "")
		text.text = paint(label) + (data.wrap ? "" : " " + spans)

		if (data.wrap)
		{
			row = $.CreatePanel("Panel", container, "")
			row.AddClass("AbilityStatRow")
			text = $.CreatePanel("Label", row, "")
			text.html = true
			text.AddClass("AbilityStatText")
			text.text = spans
		}

		for (let talent of sources[data.key] || [])
			AbilityTooltipTalentIcon(row, talent)
	}

	return rows.length
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

	for (let id of ["AbilityDescription", "AbilityDescriptionAfter", "AbilityLore"])
		$("#" + id).style.width = (330 + extra) + "px"

	for (let name of ["AbilityLegendaryBlock", "AbilityLegendaryText", "AbilityCreeps", "AbilityCreepsLine"])
	{
		for (let panel of $.GetContextPanel().FindChildrenWithClassTraverse(name))
			panel.style.width = (322 + extra) + "px"
	}

}

function AbilityTooltipBody(details, details_v2, entity, ability_name, level, max)
{
	AbilityTooltipCost(details, "AbilityCooldown", level, max)
	AbilityTooltipCost(details, "AbilityManaCost", level, max)
	AbilityTooltipCost(details, "AbilityHealthCost", level, max)
	AbilityTooltipCost(details, "AbilityCastRange", level, max)

	let immediate = (Abilities.GetBehavior(entity) & DOTA_ABILITY_BEHAVIOR.DOTA_ABILITY_BEHAVIOR_IMMEDIATE) !== 0
	let cast_point = immediate ? 0 : Abilities.GetCastPoint(entity)
	$("#AbilityCastPoint").SetHasClass("Hidden", Abilities.IsPassive(entity) || level === 0)
	$("#AbilityCastPoint").text = AbilityTooltipSpans([AbilityTooltipNumber(cast_point)], 0, "")

	let bonus = AbilityTooltipBonus(entity, ability_name)

	for (let id of ability_tooltip_costs)
	{
		let label = $("#" + id)

		if (label.BHasClass("Hidden") && bonus.replace[id] === 0 && level > 0)
		{
			label.text = AbilityTooltipSpans(["0"], 0, "")
			label.SetHasClass("Hidden", false)
		}

		let box = $("#" + id + "Talents")
		let talents = label.BHasClass("Hidden") ? [] : bonus.talents[id] || []
		box.RemoveAndDeleteChildren()
		box.SetHasClass("Hidden", talents.length === 0)

		for (let talent of talents)
			AbilityTooltipTalentIcon(box, talent).AddClass("AbilityCostTalent")
	}

	$("#AbilityCastPointIcon").SetHasClass("Hidden", $("#AbilityCastPoint").BHasClass("Hidden"))
	$("#AbilityCostsSeparator").SetHasClass("Hidden", ability_tooltip_costs.every(id => $("#" + id).BHasClass("Hidden")))

	let description = AbilityTooltipDescription(entity, ability_name, level, max, bonus).split(/(?:\s*<br>)*\s*\*legendary\*\s*(?:<br>\s*)*/)
	let after = description.slice(1).join("")

	$("#AbilityDescription").SetHasClass("Hidden", description[0] === "")
	$("#AbilityDescription").text = description[0]
	$("#AbilityDescriptionAfter").SetHasClass("Hidden", after === "")
	$("#AbilityDescriptionAfter").text = after

	AbilityTooltipLegendary($("#AbilityLegendary"), "#DOTA_Tooltip_ability_" + ability_name + "_legendary_", entity, level, max, bonus)

	let blocks = {Diff: [], Features: [], Creeps: [], Buildings: []}
	let creeps_damage = AbilityTooltipLevels(entity, "creeps_damage", max, bonus)

	if (creeps_damage.some(value => value !== "0"))
	{
		let type = creeps_damage.some(value => value.startsWith("-")) ? "nerf" : "buff"
		blocks.Creeps.push(AbilityTooltipValues($.Localize("#tooltip_ability_creeps_damage_" + type), entity, level, max, bonus))
	}

	for (let group in blocks)
	{
		let block = blocks[group]

		for (let i = 1; ; i++)
		{
			let key = "#DOTA_Tooltip_ability_" + ability_name + "_" + group.toLowerCase() + i
			let text = $.Localize(key)

			if (text === key)
				break

			block.push(AbilityTooltipValues(text, entity, level, max, bonus))
		}

		let panel = $("#Ability" + group)
		panel.SetHasClass("Hidden", block.length === 0)

		if (block.length > 0 && ability_tooltip_block_icons[group])
		{
			let icon = panel.FindChildrenWithClassTraverse("AbilityCreepsIcon")[0]
			icon.style.backgroundImage = "url('file://{images}/custom_game/icons/mini/info_table/" + ability_tooltip_block_icons[group] + ".png')"
			icon.style.backgroundSize = "contain"
		}

		let lines = $("#Ability" + group + "Text")
		lines.RemoveAndDeleteChildren()

		for (let line of block)
		{
			let label = $.CreatePanel("Label", lines, "")
			label.html = true
			label.AddClass("AbilityCreepsLine")
			label.text = line
		}
	}

	let extra = AbilityTooltipExtra(details, details_v2, entity, ability_name, level, max, bonus)
	$("#AbilityExtraAttributes").SetHasClass("Hidden", extra === 0)
	$("#AbilityCostsSeparator").SetHasClass("AfterText", extra === 0)

	return bonus
}

function AbilityTooltipLoaded()
{
	let reveal = ++ability_tooltip_reveal
	$.GetContextPanel().AddClass("TooltipPending")
	$.Schedule(0.06, () =>
	{
		if (reveal === ability_tooltip_reveal && $.GetContextPanel().IsValid())
			$.GetContextPanel().RemoveClass("TooltipPending")
	})

	let mode = $.GetContextPanel().GetAttributeString("mode", "")
	$.GetContextPanel().SetHasClass("AghsMode", mode === "aghs")
	$.GetContextPanel().SetHasClass("InnateMode", mode === "innate")

	if (mode === "aghs")
	{
		AghsTooltipLoaded()
		return
	}

	if (mode === "innate")
	{
		InnateTooltipLoaded()
		return
	}

	let entity = Number($.GetContextPanel().GetAttributeString("entity", "-1"))
	let ability_name = $.GetContextPanel().GetAttributeString("ability", "")
	let native = AbilityTooltipNative("DOTAAbilityTooltip")

	if (entity === -1 || !native)
		return

	for (let id of ["AbilityDescription", "AbilityDescriptionAfter", "AbilityLore", "AbilityDiff", "AbilityFeatures", "AbilityCreeps", "AbilityBuildings"])
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

	$("#CurrentAbilityCharges").SetHasClass("Hidden", charges <= 1)
	$("#CurrentAbilityCharges").text = charges + " " + $.Localize("#tooltip_ability_charges_" + charges_form)
	AbilityTooltipBody(details, details_v2, entity, ability_name, level, max)
}

if (!$.GetContextPanel().BHasClass("AbilityTooltip") && !$.DbgIsReloadingScript())
{
	$.RegisterEventHandler("DOTAShowAbilityTooltip", ability_tooltip_hud, (panel, ability_name) => AbilityTooltipShow(panel, ability_name, -1))
	$.RegisterEventHandler("DOTAShowAbilityTooltipForEntityIndex", ability_tooltip_hud, (panel, ability_name, unit) => AbilityTooltipShow(panel, ability_name, unit))
	$.RegisterEventHandler("DOTAHideAbilityTooltip", ability_tooltip_hud, panel => AbilityTooltipLeave(panel))
}

function StatusTooltipShow(panel, mode)
{
	let status = ability_tooltip_status[mode]
	let native = AbilityTooltipNative(status.native)

	if (native)
		native.style.opacity = "0"

	$.DispatchEvent(status.show, panel)

	if (ability_tooltip_status_schedule[mode])
		$.CancelScheduled(ability_tooltip_status_schedule[mode])

	ability_tooltip_status_schedule[mode] = $.Schedule(0, () =>
	{
		ability_tooltip_status_schedule[mode] = null

		let tooltip = AbilityTooltipNative(status.native)

		if (tooltip)
			tooltip.style.opacity = "0"

		$.DispatchEvent("UIShowCustomLayoutParametersTooltip", panel, mode + "_tooltip", "file://{resources}/layout/custom_game/ability_tooltip/ability_tooltip.xml", "mode=" + mode + "&unit=" + Players.GetLocalPlayerPortraitUnit())
	})
}

function StatusTooltipHide(panel, mode)
{
	let status = ability_tooltip_status[mode]

	if (ability_tooltip_status_schedule[mode])
	{
		$.CancelScheduled(ability_tooltip_status_schedule[mode])
		ability_tooltip_status_schedule[mode] = null
	}

	$.DispatchEvent("UIHideCustomLayoutTooltip", panel, mode + "_tooltip")
	$.DispatchEvent(status.hide, panel)

	let native = AbilityTooltipNative(status.native)

	if (native)
		native.style.opacity = null
}

function AghsTooltipText(card, text, prefix, entity, level, max, bonus)
{
	let parts = text.split(/(?:\s*<br>)*\s*\*legendary\*\s*(?:<br>\s*)*/)

	for (let index = 0; index < parts.length; index++)
	{
		if (index > 0)
		{
			let legendary = $.CreatePanel("Panel", card, "")
			legendary.AddClass("AghsLegendary")
			AbilityTooltipLegendary(legendary, prefix, entity, level, max, bonus)
		}

		if (parts[index] === "")
			continue

		let label = $.CreatePanel("Label", card, "")
		label.html = true
		label.AddClass("AghsCardText")
		label.text = parts[index]
	}

	if (parts.length > 1)
		return

	let legendary = $.CreatePanel("Panel", card, "")
	legendary.AddClass("AghsLegendary")
	AbilityTooltipLegendary(legendary, prefix, entity, level, max, bonus)
}

function AghsTooltipCard(cards, unit, kind, ability_name, granted, source)
{
	let entity = ability_name !== "" ? Entities.GetAbilityByName(unit, ability_name) : -1

	let card = $.CreatePanel("Panel", cards, "")
	card.AddClass("AghsCard")
	card.SetHasClass("AghsGranted", granted)

	let header = $.CreatePanel("Panel", card, "")
	header.AddClass("AghsCardHeader")

	if (ability_name !== "")
	{
		let icon = $.CreatePanel("DOTAAbilityImage", header, "")
		icon.AddClass("AghsCardIcon")
		icon.abilityname = ability_name

		if (entity !== -1)
			icon.contextEntityIndex = entity
	}

	let titles = $.CreatePanel("Panel", header, "")
	titles.AddClass("AghsCardTitles")

	let line = $.CreatePanel("Panel", card, "")
	line.AddClass("AghsCardSeparator")

	let info = $.CreatePanel("Panel", card, "")
	info.AddClass("AghsCardInfo")

	if (ability_name !== "")
	{
		let name = $.CreatePanel("Label", titles, "")
		name.AddClass("AghsCardName")
		name.text = $.Localize("#DOTA_Tooltip_ability_" + ability_name)
	}

	let tag = $.CreatePanel("Label", titles, "")
	tag.AddClass("AghsCardTag")
	tag.text = $.Localize(granted ? "#DOTA_AbilityTooltip_Aghs_New_Ability" : "#DOTA_AbilityTooltip_Upgrade")

	if (entity === -1)
	{
		let native = source ? source.FindChildrenWithClassTraverse("AbilityDescription")[0] : null
		let label = $.CreatePanel("Label", info, "")
		label.html = true
		label.AddClass("AghsCardText")
		label.AddClass("AghsCardLast")
		label.text = native ? native.text : ""
		return
	}

	let level = Abilities.GetLevel(entity)
	let max = Abilities.GetMaxLevel(entity)
	let bonus = AbilityTooltipBonus(entity, ability_name)
	let suffixes = granted ? ["_Description"] : kind === "Scepter" ? ["_scepter_description", "_aghanim_description"] : ["_shard_description"]
	let text = ""

	for (let suffix of suffixes)
	{
		let key = "#DOTA_Tooltip_ability_" + ability_name + suffix
		let value = $.Localize(key)

		if (value !== key)
		{
			text = value
			break
		}
	}

	let prefix = "#DOTA_Tooltip_ability_" + ability_name + (granted ? "_legendary_" : kind === "Scepter" ? "_scepter_legendary_" : "_shard_legendary_")
	AghsTooltipText(info, AbilityTooltipValues(text, entity, level, max, bonus), prefix, entity, level, max, bonus)

	let keys = source ? source.FindChildrenWithClassTraverse("AbilitySpecialKeys")[0] : null
	let lines = keys ? keys.text.split("\n").filter(line => line.trim() !== "") : []

	if (lines.length > 0)
	{
		let container = $.CreatePanel("Panel", info, "")
		container.AddClass("AghsCardKeys")

		for (let line of lines)
		{
			let row = $.CreatePanel("Label", container, "")
			row.html = true
			row.AddClass("AbilityStatText")

			let split = line.indexOf(": ")

			if (split === -1)
			{
				row.text = line
				continue
			}

			let values = line.substring(split + 2).split(" / ").map(value => value.replace("-", ""))
			row.text = line.substring(0, split + 1) + " " + AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max), "")
		}
	}

	let separator = $.CreatePanel("Panel", info, "")
	separator.AddClass("AghsCardCostsSeparator")
	separator.SetHasClass("AfterText", lines.length === 0)

	let costs = $.CreatePanel("Panel", info, "")
	costs.AddClass("AghsCardCosts")

	for (let id of ["AbilityCooldown", "AbilityManaCost"])
	{
		let native = source ? source.FindChildTraverse(id) : null

		if (!native || !native.visible || native.BHasClass("Hidden") || native.text === "" || native.text === "0")
			continue

		let values = native.text.split(" / ")
		let label = $.CreatePanel("Label", costs, "")
		label.html = true
		label.AddClass(id === "AbilityCooldown" ? "Cooldown" : "ManaCost")
		label.text = AbilityTooltipSpans(values, AbilityTooltipActive(values.length, level, max), "")
	}

	costs.SetHasClass("Hidden", costs.GetChildCount() === 0)
	separator.SetHasClass("Hidden", costs.GetChildCount() === 0)

	let visible = info.Children().filter(child => !child.BHasClass("Hidden"))

	if (visible.length > 0)
		visible[visible.length - 1].AddClass("AghsCardLast")
}

function AghsTooltipLoaded()
{
	let unit = Number($.GetContextPanel().GetAttributeString("unit", "-1"))
	let native = AbilityTooltipNative(ability_tooltip_status.aghs.native)

	if (unit === -1 || !native)
		return

	let upgrades = CustomNetTables.GetTableValue("custom_pick", "aghs_" + Entities.GetUnitName(unit)) || {}

	for (let kind of ["Scepter", "Shard"])
	{
		let cards = $("#Aghs" + kind + "Cards")
		let listed = {}
		let innate = {}
		let entries = []
		cards.RemoveAndDeleteChildren()
		$("#Aghs" + kind + "Section").SetHasClass("AghsOwned", native.BHasClass("Has" + kind))

		for (let index = 1; index <= 3; index++)
		{
			let source = native.FindChildTraverse("Aghs" + kind + "Container" + index)

			if (!source || source.BHasClass("Hidden"))
				continue

			let image = source.FindChildTraverse("ScepterAbilityImage")
			let ability_name = image ? image.abilityname : ""
			listed[ability_name] = true
			entries.push({name: ability_name, granted: source.FindChildrenWithClassTraverse("GrantedAbility").length > 0, source: source})
		}

		for (let index in upgrades)
		{
			let upgrade = upgrades[index]
			let type = upgrade[kind.toLowerCase()]
			innate[upgrade.name] = upgrade.innate === 1

			if (type > 0 && !listed[upgrade.name] && Entities.GetAbilityByName(unit, upgrade.name) !== -1)
				entries.push({name: upgrade.name, granted: type === 2, source: null})
		}

		entries.sort((a, b) => (innate[b.name] ? 1 : 0) - (innate[a.name] ? 1 : 0))

		for (let entry of entries)
			AghsTooltipCard(cards, unit, kind, entry.name, entry.granted, entry.source)

		if (cards.GetChildCount() > 0)
			continue

		let empty = $.CreatePanel("Label", cards, "")
		empty.AddClass("AghsEmpty")
		empty.text = $.Localize("#DOTA_AbilityTooltip_No_Aghs_Upgrade_Found")
	}

}

function AghsTooltipDisplays(panel, result)
{
	if (panel.id === "AghsStatusContainer")
		result.push(panel)

	for (let child of panel.Children())
		AghsTooltipDisplays(child, result)

	return result
}

function AghsTooltipHook(attempt)
{
	let branch = ability_tooltip_hud.FindChildTraverse("AbilitiesAndStatBranch")
	let displays = branch ? AghsTooltipDisplays(branch, []) : []

	if (displays.length === 0)
	{
		if (attempt < 30)
			$.Schedule(1, () => AghsTooltipHook(attempt + 1))

		return
	}

	for (let display of displays)
	{
		display.SetPanelEvent("onmouseover", () => StatusTooltipShow(display, "aghs"))
		display.SetPanelEvent("onmouseout", () => StatusTooltipHide(display, "aghs"))
	}

}

if (!$.GetContextPanel().BHasClass("AbilityTooltip"))
	AghsTooltipHook(0)

function InnateTooltipLegendary(unit)
{
	let legendary = Game.GetLocalLegendary()
	let talent = legendary[1]
	let hero = Entities.GetUnitName(unit)
	let talents = Game.talents_values[hero]
	let data = talent && talents ? talents[talent] : null

	$("#InnateLegendary").SetHasClass("InnateNoLegendary", !data)
	$("#InnateConnector").SetHasClass("InnateNoLegendary", !data)

	if (!data)
		return

	let spells = Game.spells_by_number[hero]
	let spell = spells ? spells[data.skill_number] : null
	let image = $("#InnateLegendaryImage")

	if (spell)
	{
		let ability = Entities.GetAbilityByName(Players.GetPlayerHeroEntityIndex(Entities.GetPlayerOwnerID(unit)), spell.name)

		if (ability !== -1)
			image.contextEntityIndex = ability

		image.abilityname = spell.name
	}

	$("#InnateLegendaryName").text = $.Localize("#DOTA_Tooltip_ability_" + legendary[2])
	$("#InnateLegendaryText").text = Game.ShowTalentValues("#upgrade_disc_" + talent, talent, 0, false, true, true)
}

function InnateTooltipLoaded()
{
	let unit = Number($.GetContextPanel().GetAttributeString("unit", "-1"))
	let native = AbilityTooltipNative(ability_tooltip_status.innate.native)

	if (unit === -1 || !native)
		return

	InnateTooltipLegendary(unit)

	let image = native.FindChildTraverse("InnateImage")
	let ability_name = image ? image.abilityname : ""
	let entity = ability_name !== "" ? Entities.GetAbilityByName(unit, ability_name) : -1

	if (entity === -1 && image && typeof image.contextEntityIndex === "number")
		entity = image.contextEntityIndex

	let empty = native.BHasClass("NoInnate") || ability_name === "" || typeof entity !== "number" || entity === -1
	$("#AbilityCard").SetHasClass("InnateEmpty", empty)

	if (empty)
		return

	let linked = !native.BHasClass("TrueInnateAbility")
	let icon = $("#InnateAbilityImage")
	icon.abilityname = ability_name
	icon.contextEntityIndex = entity

	$("#InnateLinkedImage").SetHasClass("Hidden", !linked)
	$("#InnateDefaultImage").SetHasClass("Hidden", linked)
	$("#InnateName").text = $.Localize("#DOTA_Tooltip_ability_" + ability_name)

	let details = native.FindChildTraverse("InnateAbilityDetails")
	let level = Abilities.GetLevel(entity)
	let max = Abilities.GetMaxLevel(entity)
	let bonus = AbilityTooltipBody(details, details, entity, ability_name, level, max)

	let dependency = details.FindChildTraverse("AbilityDependency")
	let dependency_text = dependency && !dependency.BHasClass("Hidden") ? dependency.text : ""
	let dependency_name = dependency_text.substring(dependency_text.indexOf(":") + 1).replace(/<[^>]*>/g, "").trim()
	$("#InnateDependency").text = dependency_text
	$("#InnateDependency").SetHasClass("Hidden", dependency_text.indexOf(":") === -1 || dependency_name === "" || dependency_name.includes("{"))

	let native_cooldown = details.FindChildTraverse("AbilityCooldown")
	let cooldowns = native_cooldown && !native_cooldown.BHasClass("Hidden") && native_cooldown.text !== "" ? native_cooldown.text.split(" / ") : []

	for (let key of ["cooldown", "cd"])
	{
		let label_key = "#DOTA_Tooltip_ability_" + ability_name + "_" + key
		let label = $.Localize(label_key)

		if (cooldowns.length > 0 || label === label_key)
			continue

		cooldowns = AbilityTooltipLevels(entity, key, max, bonus)

		let attributes = $("#AbilityExtraAttributes")
		let line_key = AbilityTooltipKey(label) + ":"

		for (let row of attributes.Children())
		{
			let text = row.GetChild(0)

			if (text && text.text.startsWith(line_key))
				row.AddClass("Hidden")
		}

		attributes.SetHasClass("Hidden", attributes.Children().every(row => row.BHasClass("Hidden")))
		$("#AbilityCostsSeparator").SetHasClass("AfterText", attributes.BHasClass("Hidden"))

		let cooldown = $("#AbilityCooldown")
		cooldown.text = AbilityTooltipSpans(cooldowns, AbilityTooltipActive(cooldowns.length, level, max), "")
		cooldown.SetHasClass("Hidden", false)
		$("#AbilityCostsSeparator").SetHasClass("Hidden", false)
	}

}

function InnateTooltipHook(attempt)
{
	let branch = ability_tooltip_hud.FindChildTraverse("AbilitiesAndStatBranch")
	let icon = branch ? branch.FindChildTraverse("InnateIcon") : null

	if (!icon)
	{
		if (attempt < 30)
			$.Schedule(1, () => InnateTooltipHook(attempt + 1))

		return
	}

	icon.SetPanelEvent("onmouseover", () => StatusTooltipShow(icon, "innate"))
	icon.SetPanelEvent("onmouseout", () => StatusTooltipHide(icon, "innate"))
}

if (!$.GetContextPanel().BHasClass("AbilityTooltip"))
	InnateTooltipHook(0)