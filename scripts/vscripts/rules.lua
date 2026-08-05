--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


require("essentials")
require("data")

if rules == nil then
	_G.rules = class({})
end

-- Таблица для хранения событий, которые нужно отправить при реконнекте
_G.reconnect_events = {}

function rules:init()
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(rules, "OnGameStateChanged"), self)
	ListenToGameEvent("player_connect", Dynamic_Wrap(rules, "OnPlayerConnect"), self)
	CustomGameEventManager:RegisterListener(
		"request_npc_interactions_data",
		Dynamic_Wrap(rules, "request_npc_interactions_data")
	)
	CustomGameEventManager:RegisterListener(
		"adjust_damage_challenge_stats",
		Dynamic_Wrap(rules, "adjust_damage_challenge_stats")
	)
	CustomGameEventManager:RegisterListener("RequestDifficultData", Dynamic_Wrap(rules, "RequestDifficultData"))
	CustomGameEventManager:RegisterListener("skin_equip", Dynamic_Wrap(rules, "skin_equip"))
	CustomGameEventManager:RegisterListener("skin_unequip", Dynamic_Wrap(rules, "skin_unequip"))
end

_G.player_original_model = {}
_G.player_equipped_skin = {}

------------------------------------------------------ ERROR LOGGER -------------------------------------------------

function rules:SafeCall(callback)
	local result = xpcall(callback, function(err)
		local stackTrace = debug.traceback(err)
		local arr = { message = tostring(err), trace = stackTrace }
		local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_errors/?key=" .. _G.key)
		req:SetHTTPRequestGetOrPostParameter("arr", json.encode(arr))
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			print(res.StatusCode)
		end)
	end, function(e)
		print("-------------Error-------------")
		print(e)
		print("-------------Error-------------")
	end)

	if result then
		print("all ok")
	else
		print("error")
	end
end

------------------------------------------------------ BAN -------------------------------------------------

function rules:BanPlayers(playerIDs, reason)
	if #playerIDs == 0 then
		return
	end

	local players = {}
	for _, pid in ipairs(playerIDs) do
		players[tostring(pid)] = { sid = tostring(PlayerResource:GetSteamID(pid)) }
	end

	local arr = json.encode({ players = players, reason = reason })

	local req = CreateHTTPRequestScriptVM("POST", _G.host .. "/api_ban/?key=" .. _G.key)
	req:SetHTTPRequestGetOrPostParameter("arr", arr)
	req:SetHTTPRequestAbsoluteTimeoutMS(100000)
	req:Send(function(res)
		if res.StatusCode == 200 and res.Body ~= nil then
			for _, pid in ipairs(playerIDs) do
				local hero = PlayerResource:GetSelectedHeroEntity(pid)
				if hero and not hero:IsNull() then
					hero:AddNewModifier(hero, nil, "modifier_ban", {})
				end
			end
		else
			print(res.StatusCode)
		end
	end)
end

function rules:getPlayerSkills(t)
	local result = {}
	local hero = PlayerResource:GetSelectedHeroEntity(t.PlayerID)
	for _, plArr in pairs(HeroList.arr) do
		for _, plAbi in pairs(plArr.skill_list) do
			for _, abiName in pairs(plAbi) do
				if hero:FindAbilityByName(abiName) then
					table.insert(result, plAbi)
					break
				end
			end
		end
	end
	return result
end

------------------------------------------------- CLEAR ZONE POINTS ---------------------------------------------------

function rules:clear_zone(name, start_count, end_count)
	Timers:CreateTimer(5, function()
		for i = start_count, end_count do
			local point = Entities:FindByName(nil, name .. i)
			if point then
				UTIL_Remove(point)
			end
		end
	end)
end

------------------------------------------------- GET PLAYER COUNT ------------------------------------------------------

function rules:GetAllPlayers()
	count = 0
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero(nPlayerID) then
				count = count + 1
			end
		end
	end
	return count
end

------------------------------------------------- DISPLAY ERROR ------------------------------------------------------

function rules:DisplayError(playerID, message)
	local player = PlayerResource:GetPlayer(playerID)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "CreateIngameErrorMessage", { message = message })
	end
end

------------------------------------------------- RECONNECT EVENTS ------------------------------------------------------

-- Функция для сохранения события для последующей отправки при реконнекте
function rules:SaveReconnectEvent(eventName, eventData)
	table.insert(_G.reconnect_events, {
		event = eventName,
		data = eventData,
	})
end

-- Функция для отправки всех сохраненных событий игроку
function rules:SendReconnectEvents(playerID)
	local player = PlayerResource:GetPlayer(playerID)
	if player then
		for _, eventInfo in pairs(_G.reconnect_events) do
			CustomGameEventManager:Send_ServerToPlayer(player, eventInfo.event, eventInfo.data)
		end
	end
end

-- Обработчик подключения игрока
function rules:OnPlayerConnect(keys)
	local playerID = keys.PlayerID
	if playerID and PlayerResource:IsValidPlayerID(playerID) then
		-- Небольшая задержка, чтобы убедиться, что игрок полностью подключился
		Timers:CreateTimer(1.0, function()
			if PlayerResource:GetPlayer(playerID) then
				rules:SendReconnectEvents(playerID)
			end
		end)
	end
end

-- Функция для очистки всех сохраненных событий (можно вызвать при перезапуске игры)
function rules:ClearReconnectEvents()
	_G.reconnect_events = {}
end

------------------------------------------------- SPAWNS ------------------------------------------------------

function rules:OnGameStateChanged()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_PRE_GAME then
		-- if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		-- Очищаем события реконнекта при начале новой игры
		rules:ClearReconnectEvents()
		checkpoint()
		box_spawn()
		create_box_traps()
		dummy_spawn()
		rules:bosses_upgrade()
	end
end

------------------------------------------------- SPAWNS ------------------------------------------------------

function checkpoint()
	local hBuilding = Entities:FindByName(nil, "checkpoint00_building")
	hBuilding:SetTeam(DOTA_TEAM_GOODGUYS)
	EmitGlobalSound("DOTA_Item.Refresher.Activate")
end

function box_spawn()
	local Point = Entities:FindByName(nil, "invis_box_zone_1_" .. RandomInt(1, 2)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_1_point_" .. RandomInt(1, 2)):GetAbsOrigin()
	local hUnit = CreateUnitByName("small_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_3_point_" .. RandomInt(1, 3)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_ice_point_" .. RandomInt(1, 3)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_trap_point_" .. RandomInt(1, 2)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_sea_point_" .. RandomInt(1, 2)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_desert_point_1"):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	local Point = Entities:FindByName(nil, "zone_forest_point_" .. RandomInt(1, 2)):GetAbsOrigin()
	local hUnit = CreateUnitByName("invis_box", Point, true, nil, nil, DOTA_TEAM_NEUTRALS)

	for i = 1, 8 do
		local Point = Entities:FindByName(nil, "crate" .. i):GetAbsOrigin()
		for i = 1, 3 do
			local hUnit = CreateUnitByName(
				"npc_dota_crate",
				Point + RandomVector(RandomInt(50, 50)),
				true,
				nil,
				nil,
				DOTA_TEAM_NEUTRALS
			)
		end
	end
	rules:clear_zone("crate", 1, 8)
end

function create_box_traps()
	local runeEntity = Entities:FindByName(nil, "rune_illusion")
	if runeEntity then
		CreateRune(runeEntity:GetAbsOrigin(), DOTA_RUNE_ILLUSION)
	end
	count = rules:GetAllPlayers()
	for i = 1, 5 - count do
		local boxEntity = Entities:FindByName(nil, "box_" .. i)
		if boxEntity then
			local point = boxEntity:GetAbsOrigin()
			local hUnit = CreateUnitByName("npc_dota_crate2", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
		end
	end
end

local npcsInteractionData = {}

function dummy_spawn()
	if not IsServer() then
		return
	end

	local blacksmith = CreateUnitByName("blacksmith", Vector(-15360, -14191, 384), false, nil, nil, DOTA_TEAM_GOODGUYS) --
	blacksmith:AddNewModifier(blacksmith, nil, "modifier_blacksmith_meepo", {})
	blacksmith:SetAngles(0, -90, 0)
	local blacksmithEvent = { unit_id = blacksmith:entindex(), distance = 400, name = "#blacksmith" }
	table.insert(npcsInteractionData, blacksmithEvent)

	local trade = CreateUnitByName("blacksmith", Vector(-14720, -14191, 384), false, nil, nil, DOTA_TEAM_GOODGUYS) --
	trade:AddNewModifier(blacksmith, nil, "modifier_trade_meepo", {})
	trade:SetAngles(0, 180, 0)
	local tradeEvent = { unit_id = trade:entindex(), distance = 400, name = "#trade" }
	table.insert(npcsInteractionData, tradeEvent)

	local dungeon_master =
		CreateUnitByName("blacksmith", Vector(-14837, -15519, 300), false, nil, nil, DOTA_TEAM_GOODGUYS)
	dungeon_master:AddNewModifier(dungeon_master, nil, "modifier_trade_meepo", {})
	dungeon_master:SetAngles(0, 90, 0)
	local dungeonMasterEvent = { unit_id = dungeon_master:entindex(), distance = 400, name = "#dungeon_master" }
	table.insert(npcsInteractionData, dungeonMasterEvent)

	-- local unit = CreateUnitByName( "npc_dota_hero_target_dummy", Vector(-15509,-15370,299), false, nil, nil, DOTA_TEAM_NEUTRALS)
	-- local angle = unit:GetAngles()
	-- local new_angle = RotateOrientation(angle, QAngle(0,60,0))
	-- unit:SetAngles(new_angle[1], new_angle[2], new_angle[3])
	-- unit:SetAbilityPoints( 0 )
	-- unit:Hold()
	-- unit:SetIdleAcquire( false )
	-- unit:SetAcquisitionRange( 0 )

	_G.npc_creeps_passives =
		CreateUnitByName("npc_creeps_passives", Vector(-4823, -14380, 384), false, nil, nil, DOTA_TEAM_NEUTRALS)
	npc_creeps_passives:AddNewModifier(npc_creeps_passives, nil, "modifier_dummy", {})

	local damage_challenge_spawn_pos = Vector(-15352, -15430, 512)

	AddFOWViewer(DOTA_TEAM_GOODGUYS, damage_challenge_spawn_pos, 250, 3, false)

	LinkLuaModifier("modifier_damage_challenge", "modifiers/modifier_damage_challenge", LUA_MODIFIER_MOTION_NONE) --
	local damage_challenge =
		CreateUnitByName("npc_unit_damage_challenge", damage_challenge_spawn_pos, false, nil, nil, DOTA_TEAM_NEUTRALS)
	damage_challenge:AddNewModifier(damage_challenge, nil, "modifier_damage_challenge", {})
	damage_challenge:SetAngles(0, 20, 0)
	_G.DamageChallengeEnt = damage_challenge

	LinkLuaModifier("modifier_players_summary", "modifiers/modifier_players_summary", LUA_MODIFIER_MOTION_NONE)
	local playersSummary = CreateUnitByName(
		"npc_players_summary",
		Entities:FindByName(nil, "easy_target"):GetAbsOrigin(),
		true,
		nil,
		nil,
		DOTA_TEAM_NEUTRALS
	)
	playersSummary:AddNewModifier(playersSummary, nil, "modifier_players_summary", {})
end

---------------------------------------------------

DIFFICULT_EXTRA_ABILITIES = {
	boss = nil,
	creeps = nil,
}

function rules:updateExtraAbility(typeExtra, abilityName)
	local ability = _G.npc_creeps_passives and _G.npc_creeps_passives:FindAbilityByName(abilityName)

	DIFFICULT_EXTRA_ABILITIES[typeExtra] = DIFFICULT_EXTRA_ABILITIES[typeExtra] or {}
	DIFFICULT_EXTRA_ABILITIES[typeExtra].name = abilityName
	DIFFICULT_EXTRA_ABILITIES[typeExtra].level = ability and ability:GetLevel() or 0

	CustomGameEventManager:Send_ServerToAllClients("UpdateDifficultData:ExtraAbilities", DIFFICULT_EXTRA_ABILITIES)
end

creeps_other = {
	"npc_dota_zone_2_unit_4",
	"npc_dota_zone_2_unit_2",
	"npc_dota_zone_2_unit_3",
	"npc_dota_boss_ursa",
	"npc_dota_boss_undying",
	"npc_dota_boss_lich",
	"npc_dota_boss_tiny",
	"npc_dota_boss_guardian",
	"npc_dota_boss_nyx_1",
	"npc_dota_boss_nyx_2",
	"npc_dota_boss_slardar",
	"npc_dota_boss_bristleback",
	"npc_dota_boss_furion",
	"npc_dota_boss_doom",
	"npc_dota_boss_medusa",
	"npc_dota_boss_arc_warden",
	"npc_dota_boss_necrolyte",
	"npc_dota_zone_1_unit_quest",
	"npc_hidden_earth_boss",
	"npc_hidden_snow_boss",
	"npc_dota_boss_minion_ursa",
	"npc_dota_roshan",
	"roshan_npc",
	"npc_xdes",
}

big_units = {
	"npc_dota_zone_1_unit_6",
	"npc_dota_zone_1_unit_3",
	"npc_dota_zone_1_unit_1",
	"npc_dota_zone_2_unit_3",
	"npc_dota_zone_3_unit_1",
	"npc_dota_zone_4_unit_2",
	"npc_dota_zone_5_unit_3",
	"npc_dota_zone_8_unit_6",
	"npc_dota_zone_9_unit_2",
	"npc_dota_zone_10_unit_1",
	"npc_dota_zone_11_unit_3",
	"npc_dota_zone_12_unit_3",
}

bosses_invu = {
	"npc_dota_boss_guardian",
	"npc_dota_boss_ursa",
	"npc_dota_boss_undying",
	"npc_dota_boss_lich",
	"npc_dota_boss_tiny",
	"npc_dota_boss_nyx_1",
	"npc_dota_boss_nyx_2",
	"npc_dota_boss_slardar",
	"npc_dota_boss_bristleback",
	"npc_dota_boss_furion",
	"npc_dota_boss_doom",
	"npc_dota_boss_medusa",
	"npc_dota_boss_arc_warden",
	"npc_dota_boss_necrolyte",
	"npc_hidden_earth_boss",
	"npc_hidden_snow_boss",
	"npc_dota_zone_2_unit_2",
	"npc_dota_zone_2_unit_3",
	"npc_dota_zone_2_unit_4",
}

function rules:bosses_upgrade()
	random_ability = passive[RandomInt(1, #passive)]
	if _G.Game_Difficulty >= 12 then
		rules:updateExtraAbility("boss", random_ability)
	end

	local enemies = FindUnitsInRadius(
		DOTA_TEAM_NEUTRALS,
		Vector(0, 0, 0),
		nil,
		FIND_UNITS_EVERYWHERE,
		DOTA_UNIT_TARGET_TEAM_BOTH,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_CLOSEST,
		false
	)

	for _, unit in pairs(enemies) do
		if table.contains(creeps_other, unit:GetUnitName()) then
			rules:aura_dif(unit, random_ability)
		end
	end
	invulnerable(enemies)
	rules:bosses_hats(enemies)
end

function invulnerable(enemies)
	for _, unit in pairs(enemies) do
		if table.contains(bosses_invu, unit:GetUnitName()) then
			unit:AddNewModifier(unit, nil, "modifier_invulnerable", {})
			unit:AddNewModifier(unit, nil, "modifier_medusa_stone_gaze_stone", {})
			unit:AddNewModifier(unit, nil, "modifier_magic_immune", {})
		end
	end
end

function rules:bosses_hats(enemies)
	if not isNewYearNow() then
		return
	end

	for _, unit in pairs(enemies) do
		unit:SetupHat(HAT_TYPE.NEW_YEAR)
	end
end

function rules:aura_dif(unit, random_ability)
	if _G.guild_event_team then
		return
	end

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if _G.guild_events.solo_active_players[nPlayerID] then
			local spawn_ent = Entities:FindByName(nil, "solo_event_point_" .. nPlayerID)
			if spawn_ent and (unit:GetAbsOrigin() - spawn_ent:GetAbsOrigin()):Length2D() < 2000 then
				return
			end
		end
	end

	unit:AddNewModifier(unit, nil, "modifier_difficult", {}):SetStackCount(_G.Game_Difficulty)
	local abi = _G.npc_creeps_passives:FindAbilityByName(random_ability)
	if abi then
		if _G.Game_Difficulty >= 12 then
			unit:AddNewModifier(unit, abi, abi:GetIntrinsicModifierName(), {})
		end
		if _G.Game_Difficulty >= 16 then
			local random_ability2 = passive[RandomInt(1, #passive)]
			local abi2 = _G.npc_creeps_passives:FindAbilityByName(random_ability2)
			if abi2 then
				unit:AddNewModifier(unit, abi2, abi2:GetIntrinsicModifierName(), {})
			end
		end
	end
end

function rules:boss_invulnerable(t)
	local unit = Entities:FindByName(nil, t)
	if not unit or unit:IsNull() or not unit:IsAlive() then
		return
	end
	unit:RemoveModifierByName("modifier_invulnerable")
	unit:RemoveModifierByName("modifier_medusa_stone_gaze_stone")
	unit:RemoveModifierByName("modifier_magic_immune")
	essentials:createCustomHpBarFor(unit)
end

function rules:request_npc_interactions_data(t)
	local player = PlayerResource:GetPlayer(t.PlayerID)

	for _, npcData in pairs(npcsInteractionData) do
		CustomGameEventManager:Send_ServerToPlayer(player, "create_npc_button", npcData)
	end
end

function rules:adjust_damage_challenge_stats(t)
	if not DamageChallengeEnt or DamageChallengeEnt:IsNull() then
		return
	end

	local modifier = DamageChallengeEnt:FindModifierByName("modifier_damage_challenge")
	if not modifier or modifier:IsNull() or modifier.stage ~= "ready" then
		return
	end

	if t.type == "armor" then
		local currentArmor = DamageChallengeEnt:GetPhysicalArmorBaseValue()

		if t.inc == 1 and currentArmor < 4000 then
			DamageChallengeEnt:SetPhysicalArmorBaseValue(currentArmor + 10)
		elseif t.inc == 0 and currentArmor > -2000 then
			DamageChallengeEnt:SetPhysicalArmorBaseValue(currentArmor - 10)
		end
	elseif t.type == "magic_armor" then
		local currentMagicRes = DamageChallengeEnt:GetBaseMagicalResistanceValue()

		if t.inc == 1 and currentMagicRes < 98 then
			DamageChallengeEnt:SetBaseMagicalResistanceValue(math.min(99, currentMagicRes + 5))
		elseif t.inc == 0 and currentMagicRes > -100 then
			DamageChallengeEnt:SetBaseMagicalResistanceValue((currentMagicRes >= 98 and 95 or currentMagicRes - 5))
		end
	end
end

function rules:RequestDifficultData(t)
	CustomGameEventManager:Send_ServerToPlayer(PlayerResource:GetPlayer(t.PlayerID), "UpdateDifficultData:Full", {
		difficulty = _G.Game_Difficulty,
		extraAbilities = DIFFICULT_EXTRA_ABILITIES,
	})
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_skin_model_override", "rules", LUA_MODIFIER_MOTION_NONE)

modifier_skin_model_override = class({})

function modifier_skin_model_override:IsHidden()
	return true
end
function modifier_skin_model_override:IsPurgable()
	return false
end
function modifier_skin_model_override:RemoveOnDeath()
	return false
end
function modifier_skin_model_override:OnCreated(kv)
	self._model = kv.model
	self._scale = kv.scale
end
function modifier_skin_model_override:DeclareFunctions()
	return { MODIFIER_PROPERTY_MODEL_CHANGE, MODIFIER_PROPERTY_MODEL_SCALE }
end
function modifier_skin_model_override:GetModifierModelChange()
	return self._model or ""
end
function modifier_skin_model_override:GetModifierModelScale()
	return (self._scale * 50) or 1.0
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

local SKIN_DATA = {
	pain = {
		model = "models/naruto/pain/pain.vmdl",
		scale = 2.0,
		attack = "melee",
		ability = "pain_six_paths_authority",
	},
	itachi = {
		model = "models/naruto/itachi/itachi.vmdl",
		scale = 2.0,
		attack = "melee",
		ability = "itachi_crow_guard",
	},
	kisame = {
		model = "models/naruto/kisame/kisame.vmdl",
		scale = 2.0,
		attack = "melee",
		ability = "kisame_samehada_hunger",
	},
	hidan = {
		model = "models/naruto/hidan/hidan.vmdl",
		scale = 2.0,
		attack = "melee",
		ability = "hidan_ritual_of_blood",
	},
	tobi = {
		model = "models/naruto/tobi/tobi.vmdl",
		scale = 2.0,
		attack = "melee",
		ability = "tobi_phantom_strike",
	},
	zetsu = {
		model = "models/naruto/zecu/zecu.vmdl",
		scale = 2.0,
		attack = "ranged",
		ability = "zetsu_root_assimilation",
	},
	konan = {
		model = "models/naruto/konan/konan.vmdl",
		scale = 2.0,
		attack = "ranged",
		ability = "konan_paper_dance",
	},
	deidara = {
		model = "models/naruto/deidara/deidara.vmdl",
		scale = 2.0,
		attack = "ranged",
		ability = "deidara_unstable_art",
	},
	kakuzu = {
		model = "models/naruto/kakuzu/kakuzu.vmdl",
		scale = 2.0,
		attack = "ranged",
		ability = "kakuzu_earth_grudge_fear",
	},
	sasori = {
		model = "models/naruto/sasori/sasori.vmdl",
		scale = 2.0,
		attack = "ranged",
		ability = "sasori_red_secret_technique",
	},
}

function rules:skin_equip(t)
	local pid = t.PlayerID
	local skin = SKIN_DATA[t.skin_id]
	if not skin then
		return
	end

	if _G.ability_mode then
		rules:DisplayError(pid, "#skin_equip_ability_mode")
		return
	end

	if GameRules:GetDOTATime(false, false) > 300 then
		rules:DisplayError(pid, "#skin_equip_time_expired")
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	if not hero or hero:IsNull() then
		return
	end

	local hero_attack = hero:IsRangedAttacker() and "ranged" or "melee"
	if hero_attack ~= skin.attack then
		rules:DisplayError(pid, "#skin_wrong_attack_type")
		return
	end

	-- Владение скином проверяем на сервере: клиент может прислать skin_equip напрямую
	if not Shop or not Shop.skin_ensure then
		-- В инструментах магазин не подключён — разрешаем, чтобы можно было тестировать локально
		if IsInToolsMode() then
			rules:ApplySkin(pid, t.skin_id, 0)
		else
			rules:DisplayError(pid, "#skin_not_owned")
		end
		return
	end

	Shop:skin_ensure(pid, function(ok)
		local expires = ok and Shop:skin_owned_expires(pid, t.skin_id) or nil
		if not expires or expires <= 0 then
			rules:DisplayError(pid, ok and "#skin_not_owned" or "#skin_check_failed")
			-- Возвращаем клиенту актуальное состояние карточки
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(pid),
				"skin_state_update",
				{ skin_id = t.skin_id, owned = 0, equipped = 0, expires = 0 }
			)
			return
		end
		rules:ApplySkin(pid, t.skin_id, expires)
	end)
end

-- Непосредственное надевание скина. Вызывается только после проверки владения.
function rules:ApplySkin(pid, skin_id, expires)
	local skin = SKIN_DATA[skin_id]
	if not skin then
		return
	end

	-- Проверки повторяем: между запросом и ответом бэкенда прошло время
	if GameRules:GetDOTATime(false, false) > 300 then
		rules:DisplayError(pid, "#skin_equip_time_expired")
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	if not hero or hero:IsNull() then
		return
	end

	local hero_attack = hero:IsRangedAttacker() and "ranged" or "melee"
	if hero_attack ~= skin.attack then
		rules:DisplayError(pid, "#skin_wrong_attack_type")
		return
	end

	-- Сохраняем оригинальную модель перед заменой
	if not _G.player_original_model[pid] then
		_G.player_original_model[pid] = {
			model = hero:GetModelName(),
			scale = hero:GetModelScale(),
		}
	end

	-- Удаляем способность предыдущего скина при прямой смене
	local prev_skin_id = _G.player_equipped_skin[pid]
	if prev_skin_id and prev_skin_id ~= skin_id then
		local prev_skin = SKIN_DATA[prev_skin_id]
		if prev_skin and prev_skin.ability ~= "" and hero:FindAbilityByName(prev_skin.ability) then
			hero:RemoveAbility(prev_skin.ability)
		end
	end

	-- -- Сбрасываем партиклы от предметов: снимаем и надеваем обратно
	-- local saved_items = {}
	-- for slot = 0, 14 do
	-- 	local item = hero:GetItemInSlot(slot)
	-- 	if item then
	-- 		saved_items[slot] = item
	-- 		hero:RemoveItem(item)
	-- 	end
	-- end

	hero:RemoveModifierByName("modifier_skin_model_override")
	hero:AddNewModifier(hero, nil, "modifier_skin_model_override", { model = skin.model, scale = skin.scale })

	-- for slot, item in pairs(saved_items) do
	-- 	hero:AddItem(item)
	-- end

	if skin.ability ~= "" and not hero:FindAbilityByName(skin.ability) then
		local ab = hero:AddAbility(skin.ability)
		local new_level = math.min(math.floor(hero:GetLevel() / 5) + 1, ab:GetMaxLevel())
		ab:SetLevel(new_level)
	end

	_G.player_equipped_skin[pid] = skin_id

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(pid),
		"skin_state_update",
		{ skin_id = skin_id, owned = 1, equipped = 1, expires = expires or 0 }
	)
end

function rules:skin_unequip(t)
	local pid = t.PlayerID
	local skin = SKIN_DATA[t.skin_id]
	if not skin then
		return
	end

	local hero = PlayerResource:GetSelectedHeroEntity(pid)
	if not hero or hero:IsNull() then
		return
	end

	-- local saved_items = {}
	-- for slot = 0, 14 do
	-- 	local item = hero:GetItemInSlot(slot)
	-- 	if item then
	-- 		saved_items[slot] = item
	-- 		hero:RemoveItem(item)
	-- 	end
	-- end

	hero:RemoveModifierByName("modifier_skin_model_override")
	_G.player_original_model[pid] = nil

	-- for slot, item in pairs(saved_items) do
	-- 	hero:AddItem(item)
	-- end

	if skin.ability ~= "" and hero:FindAbilityByName(skin.ability) then
		hero:RemoveAbility(skin.ability)
	end

	_G.player_equipped_skin[pid] = nil

	local expires = (Shop and Shop.skin_owned_expires) and Shop:skin_owned_expires(pid, t.skin_id) or 0

	CustomGameEventManager:Send_ServerToPlayer(
		PlayerResource:GetPlayer(pid),
		"skin_state_update",
		{ skin_id = t.skin_id, owned = 1, equipped = 0, expires = expires or 0 }
	)
end

---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------

local SKIN_ABILITY_NAMES = {}
for _, skin in pairs(SKIN_DATA) do
	if skin.ability ~= "" then
		SKIN_ABILITY_NAMES[skin.ability] = true
	end
end

function rules:CheckMultipleSkinAbilities()
	local pl = {}

	for pid = 0, DOTA_MAX_PLAYERS - 1 do
		if PlayerResource:IsValidPlayerID(pid) then
			local hero = PlayerResource:GetSelectedHeroEntity(pid)
			if hero and not hero:IsNull() then
				local count = 0
				for i = 0, hero:GetAbilityCount() - 1 do
					local ability = hero:GetAbilityByIndex(i)
					if ability and SKIN_ABILITY_NAMES[ability:GetAbilityName()] then
						count = count + 1
					end
				end

				if count > 1 then
					table.insert(pl, pid)
				end
			end
		end
	end

	rules:BanPlayers(pl, "exploit: multiple_skin_abilities")
end