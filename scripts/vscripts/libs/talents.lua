--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-06 21:23:18 UTC
  ~ auto-generated — do not edit
]]


require("configs/talents_list")

if WodaTalents == nil then
	_G.WodaTalents = class({})
	WodaTalents.playerstalents = {}
	WodaTalents.ATTRIBUTE_NAMES = {
		[1] = "str",
		[2] = "agi",
		[3] = "int",
	}
	WodaTalents.line_level_info = {
		[1] = 0,
		[2] = 4,
		[3] = 8,
		[4] = 12,
		[5] = 16,
		[6] = 20,
		[7] = 24,
	}
end

function WodaTalents:InitTalents()
	CustomGameEventManager:RegisterListener("talent_learn", Dynamic_Wrap(self, "talent_learn"))
	for heroname, talents in pairs(_G.herotalents) do
		CustomTables:SetTableValue("herotalents", heroname, talents)
	end
	for i = 0, 10 do
		if WodaTalents.playerstalents[i] == nil then
			WodaTalents.playerstalents[i] = {
				["maxpoints"] = 0,
				["points"] = 0,
				["points_level_saved"] = 1,
			}
		end
		self:AddPointTalent(i, 1)
	end
end

function WodaTalents:AddPointTalent(id, count)
	if not WodaTalents.playerstalents[id] then
		return
	end
	WodaTalents.playerstalents[id]["talantpoints"] = (WodaTalents.playerstalents[id]["talantpoints"] or 0) + count
	CustomTables:SetTableValue("playerstalents", tostring(id), WodaTalents.playerstalents[id])
end

function WodaTalents:OnHeroLevelUp(keys)
	WodaTalents:AddPointTalent(keys.PlayerID, 1)
	if WodaTalents.playerstalents[keys.PlayerID] then
		WodaTalents.playerstalents[keys.PlayerID]["points_level_saved"] = WodaTalents.playerstalents[keys.PlayerID]["points_level_saved"]
			+ 1
	end
end

function WodaTalents:UpdateReconnectPoints(player_id)
	local player_hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if player_hero then
		local hero_level = player_hero:GetLevel()
		local current_points = nil
		if WodaTalents.playerstalents[player_id] then
			current_points = WodaTalents.playerstalents[player_id]["points_level_saved"]
		end
		if current_points ~= nil then
			if hero_level > current_points then
				local new_points = hero_level - current_points
				if new_points > 0 then
					WodaTalents:AddPointTalent(player_id, new_points)
					WodaTalents.playerstalents[player_id]["points_level_saved"] = hero_level
					CustomTables:SetTableValue(
						"playerstalents",
						tostring(player_id),
						WodaTalents.playerstalents[player_id]
					)
				end
			end
		end
	end
end

function WodaTalents:AddPoint(id, count, no_effect)
	if not WodaTalents.playerstalents[id] then
		return
	end
	local hero = PlayerResource:GetSelectedHeroEntity(id)
	if hero == nil then
		return
	end
	if WodaTalents.playerstalents[id]["maxpoints"] >= 10 then
		WodaTalents.playerstalents[id]["points"] = 0
		WodaTalents.playerstalents[id]["hasmax"] = true
		CustomTables:SetTableValue("playerstalents", tostring(id), WodaTalents.playerstalents[id])
		return
	end
	WodaTalents.playerstalents[id]["points"] = (WodaTalents.playerstalents[id]["points"] or 0) + count
	if WodaTalents.playerstalents[id]["points"] >= 10 then
		WodaTalents.playerstalents[id]["points"] = WodaTalents.playerstalents[id]["points"] - 10
		self:AddPointTalent(id, 1)
		if hero and not no_effect then
			local fx = ParticleManager:CreateParticle(
				"particles/hero_levelup_fall_2021_godray2.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				hero
			)
			ParticleManager:ReleaseParticleIndex(fx)
		end
		WodaTalents.playerstalents[id]["maxpoints"] = WodaTalents.playerstalents[id]["maxpoints"] + 1
		if WodaTalents.playerstalents[id]["maxpoints"] >= 10 then
			WodaTalents.playerstalents[id]["points"] = 0
			WodaTalents.playerstalents[id]["hasmax"] = true
		end
		if not no_effect then
			CustomGameEventManager:Send_ServerToPlayer(
				PlayerResource:GetPlayer(id),
				"woda_client_sound",
				{ sound = "ui.treasure_02" }
			)
		end
	end
	CustomTables:SetTableValue("playerstalents", tostring(id), WodaTalents.playerstalents[id])
end

function WodaTalents:talent_learn(params)
	if params.PlayerID == nil then
		return
	end
	local player_id = params.PlayerID
	local player_talents = WodaTalents.playerstalents[player_id]
	if player_talents == nil then
		return
	end
	local hero = PlayerResource:GetSelectedHeroEntity(player_id)
	if hero == nil then
		return
	end
	local hero_name = hero:GetUnitName()
	-- Данные таланта берем из конфига, а не из того, что прислал клиент
	local info = WodaTalents:GetTalentInfo(params.talentname, hero_name)
	if info == nil or info.attribute == nil then
		return
	end
	local talent_name = info.name
	local line_requirement = WodaTalents.line_level_info[info.line]
	if line_requirement == nil then
		return
	end
	-- Проверка на плохую связь талантов
	if LockedTalents[hero_name] then
		if LockedTalents[hero_name][talent_name] then
			local is_avialable = true
			for _, talent_checkout in pairs(LockedTalents[hero_name][talent_name]) do
				if player_talents[talent_checkout] then
					is_avialable = false
					break
				end
			end
			if not is_avialable then
				return
			end
		end
	end
	-- Проверка сколько нужно талантов в ветке, чтобы прокачаться дальше
	if (tonumber(player_talents[info.attribute]) or 0) < line_requirement then
		return
	end
	-- Прокачан ли талант, от которого зависит этот
	if info.require_name then
		local require_talent = player_talents[info.require_name]
		if type(require_talent) ~= "table" or (tonumber(require_talent["level"]) or 0) < (info.require_level or 0) then
			return
		end
	end
	-- Перезарядка на прочивание таланта
	if hero.cooldown_talents then
		return
	end
	hero.cooldown_talents = true
	Timers:CreateTimer(0.2, function()
		hero.cooldown_talents = nil
	end)
	-- Есть ли уже уровень таланта, если он максимальный, то не идем дальше
	local talent_table = player_talents[talent_name]
	local talent_level = 0
	if type(talent_table) == "table" then
		talent_level = tonumber(talent_table["level"]) or 0
	end
	if talent_level >= info.max_level then
		return
	end
	-- Какое количество поинтов у игрока
	if (tonumber(player_talents["talantpoints"]) or 0) <= 0 then
		return
	end
	-- Создание таблицы таланта
	if type(talent_table) ~= "table" then
		talent_table = {}
		player_talents[talent_name] = talent_table
	end
	-- Прокачивание таланта
	talent_table["level"] = talent_level + 1
	player_talents[info.attribute] = (tonumber(player_talents[info.attribute]) or 0) + 1
	player_talents["talantpoints"] = (tonumber(player_talents["talantpoints"]) or 0) - 1
	-- Сохранение визуала
	CustomTables:SetTableValue("playerstalents", tostring(player_id), player_talents)
	-- Добавление модификатора

	if not hero.talents_timers_list then
		hero.talents_timers_list = {}
	end

	table.insert(hero.talents_timers_list, talent_name)

	if not hero.RespawnTimer then
		hero.RespawnTimer = Timers:CreateTimer(0, function()
			if not hero.RespawnTimer then
				return
			end
			if hero and not hero:IsAlive() then
				return 0.1
			end
			if hero.talents_timers_list and #hero.talents_timers_list > 0 then
				for i = 1, #hero.talents_timers_list do
					local talent_name_backup = table.remove(hero.talents_timers_list, 1)
					if talent_name_backup then
						hero:AddNewModifier(hero, nil, talent_name_backup, {})
					end
				end
			end
			hero.RespawnTimer = nil
		end)
	end

	-- Квесты на талант
	if info.attribute == "str" then
		player_system:PlayerQuestProgress(player_id, 15, 1)
		player_system:PlayerQuestProgress(player_id, 16, 1)
	elseif info.attribute == "agi" then
		player_system:PlayerQuestProgress(player_id, 37, 1)
		player_system:PlayerQuestProgress(player_id, 38, 1)
	elseif info.attribute == "int" then
		player_system:PlayerQuestProgress(player_id, 59, 1)
		player_system:PlayerQuestProgress(player_id, 60, 1)
	end
end

function WodaTalents:GetTalentInfo(ftalent, fhero)
	local hero_tree = _G.herotalents[tostring(fhero)]
	if hero_tree == nil then
		return nil
	end
	local talent_name = tostring(ftalent)
	for attribute_index, attribute_skilltable in ipairs(hero_tree) do
		for line, line_skilltable in ipairs(attribute_skilltable) do
			for talent_number, talent_info in ipairs(line_skilltable) do
				if not string.find(talent_info[1], "empty") then
					if talent_info[1] == talent_name then
						return {
							name = talent_info[1],
							attribute = WodaTalents.ATTRIBUTE_NAMES[attribute_index],
							line = line,
							max_level = tonumber(talent_info[3]) or 0,
							require_name = talent_info[5] and talent_info[5][1] or nil,
							require_level = talent_info[5] and tonumber(talent_info[5][2]) or nil,
						}
					end
				end
			end
		end
	end
	return nil
end