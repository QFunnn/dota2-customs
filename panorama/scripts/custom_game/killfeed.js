--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


"use strict";

let kill_feed_pending = []
let kill_feed_victims = []
let kill_feed_glyphs = []
let kill_feed_manager = null

function KillFeedSplit(value, separator)
{
	return value ? String(value).split(separator) : []
}

function KillFeedTeam(ids_value, heroes_value, colors_value)
{
	let ids = KillFeedSplit(ids_value, ",")
	let heroes = KillFeedSplit(heroes_value, ",")
	let colors = KillFeedSplit(colors_value, ",")
	let team = []

	for (let i = 0; i < ids.length; i++)
	{
		if (ids[i] !== "")
			team.push({id: Number(ids[i]), hero: heroes[i], color: colors[i]})
	}

	return team
}

function KillFeedGold(kv)
{
	let team = KillFeedTeam(kv.team_ids, kv.team_heroes, kv.team_colors)
	let victim = Number(kv.victim)

	let other_ids = KillFeedSplit(kv.other_ids, ";")
	let other_heroes = KillFeedSplit(kv.other_heroes, ";")
	let other_gold = KillFeedSplit(kv.other_gold, ";")
	let others = []

	for (let i = 0; i < other_ids.length; i++)
	{
		if (other_ids[i] !== "")
			others.push({team: KillFeedTeam(other_ids[i], other_heroes[i], ""), gold: Number(other_gold[i])})
	}

	let entry = {team: team, victim: victim, victim_hero: kv.victim_hero, victim_color: kv.victim_color, victim_streak: kv.victim_streak, name: Players.GetPlayerName(victim), gold: kv.gold, others: others, time: Game.Time()}

	kill_feed_pending.push(entry)

	if (entry.victim_streak >= 3)
		kill_feed_victims.push(entry)

	while (kill_feed_pending.length > 0 && Game.Time() - kill_feed_pending[0].time > 5.0)
		kill_feed_pending.shift()

	while (kill_feed_victims.length > 0 && Game.Time() - kill_feed_victims[0].time > 5.0)
		kill_feed_victims.shift()

	KillFeedScan(false)
}

function KillFeedGlyph(kv)
{
	let min = Math.floor(kv.time/60)
	let sec = String(kv.time - min*60)

	if (sec.length < 2)
		sec = "0" + sec

	let local_team = Players.GetTeam(Game.GetLocalPlayerID())

	kill_feed_glyphs.push({team: KillFeedTeam(kv.ids, kv.heroes, ""), clock: String(min) + ":" + sec, time: Game.Time()})

	if (kv.team != 2 && kv.team != 3)
		GameEvents.SendEventClientSide("dota_glyph_used", {teamnumber: local_team == 2 ? 3 : 2})

	Game.EmitSound("Glyph.Used")
	KillFeedScan(false)
}

function KillFeedMatch(text, age)
{
	for (let i = 0; i < kill_feed_pending.length; i++)
	{
		let entry = kill_feed_pending[i]

		if (entry.name && text.indexOf(entry.name) !== -1)
			return kill_feed_pending.splice(i, 1)[0]
	}

	if (kill_feed_pending.length > 0 && age < 1.0 && Game.Time() - kill_feed_pending[0].time < 1.0)
		return kill_feed_pending.shift()

	return null
}

function KillFeedPortrait(parent, id, hero)
{
	let image = $.CreatePanel("Panel", parent, "")
	image.AddClass("KillFeedPortrait")
	image.style.backgroundImage = 'url("file://{images}/heroes/icons/' + Game.GetHeroImage(String(id), hero) + '.png")'
}

function KillFeedName(parent, id, color)
{
	let label = $.CreatePanel("Label", parent, "")
	label.AddClass("KillFeedName")
	label.text = Players.GetPlayerName(id)

	if (color)
		label.style.color = color.charAt(0) === "#" ? color : "#" + color
}

function KillFeedLabel(parent, text, name)
{
	let label = $.CreatePanel("Label", parent, "")
	label.AddClass(name)
	label.text = text
}

function KillFeedReward(parent, gold)
{
	KillFeedLabel(parent, String(gold), "KillFeedGold")
	$.CreatePanel("Panel", parent, "").AddClass("KillFeedCoin")
}

function KillFeedAge(row)
{
	let seen = row.GetAttributeString("killfeed_seen", "")

	if (seen === "")
	{
		seen = String(Game.Time())
		row.SetAttributeString("killfeed_seen", seen)
	}

	return Game.Time() - parseFloat(seen)
}

function KillFeedRow(row)
{
	let label = row.FindChildTraverse("EventLabel")

	if (!label)
	{
		row.AddClass("KillFeedDone")
		return
	}

	let age = KillFeedAge(row)
	let entry = KillFeedMatch(label.text, age)

	if (!entry)
	{
		if (age > 1.5)
			row.AddClass("KillFeedDone")

		return
	}

	let line = $.CreatePanel("Panel", $.GetContextPanel(), "")
	line.AddClass("KillFeedLine")

	if (row.BHasClass("AllyEvent"))
		line.AddClass("Ally")

	for (let member of entry.team)
		KillFeedPortrait(line, member.id, member.hero)

	if (entry.team.length > 0)
		KillFeedName(line, entry.team[0].id, entry.team[0].color)
	else
		KillFeedLabel(line, $.Localize("#killfeed_creeps"), "KillFeedName")

	$.CreatePanel("Panel", line, "").AddClass("KillFeedSword")

	KillFeedPortrait(line, entry.victim, entry.victim_hero)
	KillFeedName(line, entry.victim, entry.victim_color)

	if (entry.gold > 0)
		KillFeedReward(line, entry.gold)

	if (entry.others.length > 0)
	{
		let others = $.CreatePanel("Panel", line, "")
		others.AddClass("KillFeedOthers")
		KillFeedLabel(others, "(", "KillFeedBracket")

		for (let other of entry.others)
		{
			let group = $.CreatePanel("Panel", others, "")
			group.AddClass("KillFeedOther")

			for (let member of other.team)
				KillFeedPortrait(group, member.id, member.hero)

			KillFeedLabel(group, String(other.gold), "KillFeedGold")
		}

		KillFeedLabel(others, ")", "KillFeedBracket")
	}

	line.SetParent(row)
	row.MoveChildAfter(line, label)
	label.visible = false
	row.AddClass("KillFeedDone")
}

function KillFeedGlyphRow(row)
{
	let label = row.FindChildTraverse("EventLabel")

	if (!label)
	{
		row.AddClass("KillFeedDone")
		return
	}

	let age = KillFeedAge(row)

	while (kill_feed_glyphs.length > 0 && Game.Time() - kill_feed_glyphs[0].time > 1.5)
		kill_feed_glyphs.shift()

	if (age > 1.5)
	{
		row.AddClass("KillFeedDone")
		return
	}

	if (kill_feed_glyphs.length === 0)
		return

	let entry = kill_feed_glyphs.shift()

	let slash = row.FindChildTraverse("SlashContainer")
	if (slash)
		slash.style.backgroundColor = "#00000088"

	let bar = row.FindChildTraverse("TeamColorBar")
	if (bar)
	{
		bar.style.visibility = "visible"
		bar.style.backgroundColor = "gradient( linear, 100% 0%, 100% 100%, from( #8cb8f5 ), to( #5f8fd8 ) )"
	}

	let line = $.CreatePanel("Panel", $.GetContextPanel(), "")
	line.AddClass("KillFeedLine")
	line.AddClass("Glyph")

	$.CreatePanel("Panel", line, "").AddClass("KillFeedGlyph")

	for (let member of entry.team)
		KillFeedPortrait(line, member.id, member.hero)

	KillFeedLabel(line, $.Localize(entry.team.length > 1 ? "#glyph_used_2" : "#glyph_used"), "KillFeedName")
	KillFeedLabel(line, entry.clock, "KillFeedTime")

	line.SetParent(row)
	row.MoveChildAfter(line, label)
	label.visible = false
	row.AddClass("KillFeedDone")
}

function KillFeedStreakRow(row)
{
	let label = row.FindChildTraverse("EventLabel")

	if (!label)
	{
		row.AddClass("KillFeedDone")
		return
	}

	if (KillFeedAge(row) > 1.5)
	{
		row.AddClass("KillFeedDone")
		return
	}

	let index = kill_feed_victims.findIndex(victim => victim.name && label.text.indexOf(victim.name) !== -1)

	if (index === -1)
		return

	let entry = kill_feed_victims.splice(index, 1)[0]

	let line = $.CreatePanel("Panel", $.GetContextPanel(), "")
	line.AddClass("KillFeedLine")

	if (row.BHasClass("AllyEvent"))
		line.AddClass("Ally")

	KillFeedPortrait(line, entry.victim, entry.victim_hero)
	KillFeedName(line, entry.victim, entry.victim_color)
	KillFeedLabel(line, $.Localize("#killfeed_streak_ended").replace("{count}", String(entry.victim_streak)), "KillFeedName")

	line.SetParent(row)
	row.MoveChildAfter(line, label)
	label.visible = false
	row.AddClass("KillFeedDone")
}

function KillFeedScan(initial)
{
	if (!kill_feed_manager)
	{
		let events = FindDotaHudElement("combat_events")
		if (!events)
			return

		kill_feed_manager = events.FindChildTraverse("ToastManager")
		if (!kill_feed_manager)
			return

		if (initial)
		{
			for (let row of kill_feed_manager.Children())
				row.AddClass("KillFeedDone")
		}
	}

	for (let row of kill_feed_manager.Children())
	{
		if (row.BHasClass("KillFeedDone"))
			continue

		if (row.BHasClass("event_dota_player_kill"))
			KillFeedRow(row)
		else if (row.BHasClass("event_dota_glyph_used"))
			KillFeedGlyphRow(row)
		else
			KillFeedStreakRow(row)
	}
}


function OnStyleClassesChanged(panel)
{
	if (!panel)
		return

	if (panel.GetParent() !== kill_feed_manager && !panel.BHasClass("event_dota_player_kill") && !panel.BHasClass("event_dota_glyph_used"))
		return

	$.Schedule(0, () => KillFeedScan(false))
}


(function()
{
	GameEvents.Subscribe_custom("kill_feed_gold", KillFeedGold)
	GameEvents.Subscribe_custom("glyph_used", KillFeedGlyph)
	$.RegisterForUnhandledEvent("StyleClassesChanged", OnStyleClassesChanged)
	KillFeedScan(true)
})()