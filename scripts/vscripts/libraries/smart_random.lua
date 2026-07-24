--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SmartRandom = SmartRandom or {}

function SmartRandom:Init()
	SmartRandom.random_pool = {}

	EventStream:Listen("SmartRandom:execute", SmartRandom.PickRandomHero, SmartRandom)
end


function SmartRandom:SetPlayerInfo(player_id, heroes)
	local table = CustomNetTables:GetTableValue("game_state", "smart_random") or {}
	SmartRandom.random_pool[player_id] = heroes
	table[player_id] = heroes
	CustomNetTables:SetTableValue("game_state", "smart_random", table)
end


function SmartRandom:GetBannedHeroes()
	local internal_banned_heroes = GameRules:GetBannedHeroes()
	local full_banned_heroes = {}

	for _, hero_name in pairs(internal_banned_heroes or {}) do
		if string.starts(hero_name, "npc_dota_hero_") then
			table.insert(full_banned_heroes, hero_name)
		else
			table.insert(full_banned_heroes, "npc_dota_hero_" .. hero_name)
		end
	end

	return full_banned_heroes
end


function SmartRandom:PickRandomHero(event)
	local player_id = event.PlayerID

	if not IsValidPlayerID(player_id) then return end
	if GameRules:State_Get() > DOTA_GAMERULES_STATE_HERO_SELECTION then return end
	if PlayerResource:HasSelectedHero(player_id) then return end

	-- if WebPlayer:GetSubscriptionTier(player_id) < 1 then return end

	local player = PlayerResource:GetPlayer(player_id)

	if not IsValidEntity(player) then
		player:MakeRandomHeroSelection()
		return
	end

	local banned_hero_names = SmartRandom:GetBannedHeroes()

	print("[Smart Random] banned heroes:")
	DeepPrintTable(banned_hero_names)

	local available_heroes = table.array_filter(
		table.array_difference(SmartRandom.random_pool[player_id], banned_hero_names),
		function(k, v, t)
			return not PlayerResource:IsHeroSelected(v, false)
		end
	)

	print("[Smart Random] available heroes:")
	DeepPrintTable(available_heroes)

	if #available_heroes <= 0 then
		print("[Smart Random] not enough heroes available, selecting random")
		player:MakeRandomHeroSelection()
		return
	end

	local hero_name = table.random(available_heroes)

	print("[Smart Random] randomed", hero_name)

	UTIL_Remove(CreateHeroForPlayer(hero_name, player))

	-- TODO: replace with localized text (not viable for this method)
	GameRules:SendCustomMessage("%s1 has smart-randomed " .. (GetUnitKV(hero_name, "workshop_guide_name") or ""), player_id, -1)
end


SmartRandom:Init()