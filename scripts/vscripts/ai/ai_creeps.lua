--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


local THINK_INTERVAL = 0.5
local RETREAT_DISTANCE = 1500
local SEARCH_DISTANCE = 1500

local LIMITED_CAST_SET = {
	["item_guardian_greaves"] = true,
	["item_satanic"] = true,
	["item_bloodstone"] = true,
	["item_crimson_guard"] = true,
	["item_pipe"] = true,
	["item_glimmer_cape"] = true,
	["creep_freezing_field_lua"] = true,
	["creep_purification_lua"] = true,
}

local CAST_HP_PCT = 80

function Spawn(entityKeyValues)
	if not IsServer() or not thisEntity then
		return
	end
	thisEntity.refresh = 0
	thisEntity.spells = {}
	thisEntity.items = {}
	thisEntity.bInitialized = false
	thisEntity.fTimeOfLastRetreat = 0
	thisEntity:SetContextThink("NeutralThink", function()
		return NeutralThink()
	end, THINK_INTERVAL)
end

function UpdateAbilitiesAndItems()
	thisEntity.spells = {}

	local abilityCount = thisEntity:GetAbilityCount()
	for i = 0, abilityCount - 1 do
		local ability = thisEntity:GetAbilityByIndex(i)
		if ability and not ability:IsAttributeBonus() and not ability:IsHidden() and not ability:IsPassive() then
			table.insert(thisEntity.spells, ability)
		end
	end

	thisEntity.items = {}
	for i = 0, 5 do
		local item = thisEntity:GetItemInSlot(i)
		if item then
			table.insert(thisEntity.items, item)
		end
	end
end

function NeutralThink()
	if not thisEntity:IsAlive() then
		return -1
	end
	if thisEntity:IsStunned() or thisEntity:IsSilenced() or GameRules:IsGamePaused() then
		return THINK_INTERVAL
	end

	if not thisEntity.bInitializedSpells then
		UpdateAbilitiesAndItems()
		thisEntity.bInitializedSpells = true
	end

	if not thisEntity.bInitialized then
		thisEntity.vInitialSpawnPos = thisEntity:GetAbsOrigin()
		thisEntity.bInitialized = true
	end

	local enemies = FindUnitsInRadius(
		thisEntity:GetTeamNumber(),
		thisEntity:GetOrigin(),
		thisEntity,
		SEARCH_DISTANCE,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_ALL,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
		FIND_CLOSEST,
		false
	)

	local filteredEnemiesForCast = {}
	local retreat_enemy = nil

	for _, enemy in pairs(enemies) do
		-- Проверяем, что сущность существует в движке и не была удалена
		if enemy and not enemy:IsNull() and IsValidEntity(enemy) and enemy:IsAlive() then
			local unitName = enemy:GetUnitName()

			-- Логика фильтрации для каста
			if enemy:GetTeamNumber() == DOTA_TEAM_GOODGUYS and unitName ~= "npc_dota_observer_wards" then
				table.insert(filteredEnemiesForCast, enemy)
			end

			-- Логика отступления для дальнего боя
			if thisEntity:IsRangedAttacker() and not retreat_enemy then
				if (enemy:GetOrigin() - thisEntity:GetOrigin()):Length2D() < 400 then
					local gameTime = GameRules:GetGameTime()
					if not thisEntity.fTimeOfLastRetreat or (gameTime > thisEntity.fTimeOfLastRetreat + 4) then
						retreat_enemy = enemy
					end
				end
			end
		end
	end

	if #enemies == 0 then
		-- Проверка без кэша: кэш мог быть устаревшим (TTL 0.1с)
		local realCheck = _G.OldFindUnitsInRadius(
			thisEntity:GetTeamNumber(),
			thisEntity:GetOrigin(),
			nil,
			SEARCH_DISTANCE,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_ALL,
			DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
			FIND_CLOSEST,
			false
		)
		if #realCheck > 0 then
			enemies = realCheck
		else
			if not thisEntity:HasModifier("modifier_creep_antilag") then
				thisEntity:AddNewModifier(thisEntity, nil, "modifier_creep_antilag", {})
			end
			if (thisEntity:GetAbsOrigin() - thisEntity.vInitialSpawnPos):Length2D() > 100 then
				return RetreatHome()
			end
			return THINK_INTERVAL
		end
	end

	thisEntity:RemoveModifierByName("modifier_creep_antilag")

	thisEntity.castables = {}
	if #filteredEnemiesForCast > 0 then
		thisEntity.target = filteredEnemiesForCast[RandomInt(1, #filteredEnemiesForCast)]

		local sources = { thisEntity.spells, thisEntity.items }
		for _, source in ipairs(sources) do
			for _, ability in ipairs(source) do
				if ability and not ability:IsNull() and ability:IsFullyCastable() then
					local name = ability:GetName()
					local dist = (thisEntity.target:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length2D()
					local range = ability:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity.target)
						+ thisEntity:GetCastRangeBonus()
					if range <= 0 then
						range = thisEntity:GetAcquisitionRange()
					end

					local canCast = true
					if LIMITED_CAST_SET[name] and thisEntity:GetHealthPercent() >= CAST_HP_PCT then
						canCast = false
					end
					if name == "item_octarine_core" and thisEntity.refresh < 5 then
						canCast = false
					end

					if canCast and dist <= (range - 100) then
						table.insert(thisEntity.castables, ability)
					end
				end
			end
		end
	end

	if retreat_enemy then
		return Retreat(retreat_enemy)
	end

	if #thisEntity.castables > 0 and thisEntity.target then
		local spell = thisEntity.castables[RandomInt(1, #thisEntity.castables)]
		ExecuteSmartCast(spell, thisEntity.target)
		return THINK_INTERVAL
	end

	return THINK_INTERVAL
end

function ExecuteSmartCast(ability, target)
	if not ability or ability:IsNull() or not target or target:IsNull() then
		return
	end

	local behavior = ability:GetBehaviorInt()
	local targetTeam = ability:GetAbilityTargetTeam()
	local targetType = ability:GetAbilityTargetType()

	if target:IsUnselectable() or target:IsInvulnerable() or target:IsOther() then
		return
	end

	local order = {
		UnitIndex = thisEntity:entindex(),
		AbilityIndex = ability:entindex(),
		Queue = false,
	}

	if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
		local finalTarget = target

		if bit.band(targetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0 then
			local castRange = ability:GetCastRange(thisEntity:GetAbsOrigin(), nil) + thisEntity:GetCastRangeBonus()

			local friendlies = FindUnitsInRadius(
				thisEntity:GetTeamNumber(),
				thisEntity:GetAbsOrigin(),
				thisEntity,
				castRange,
				DOTA_UNIT_TARGET_TEAM_FRIENDLY,
				targetType,
				DOTA_UNIT_TARGET_FLAG_NONE,
				FIND_ANY_ORDER,
				false
			)

			local weakestFriendly = nil
			local lowestHealthPct = 1.1

			for _, friend in pairs(friendlies) do
				if friend and not friend:IsNull() and friend:IsAlive() and not friend:IsInvulnerable() then
					local healthPct = friend:GetHealth() / friend:GetMaxHealth()
					if healthPct < lowestHealthPct then
						lowestHealthPct = healthPct
						weakestFriendly = friend
					end
				end
			end

			if weakestFriendly then
				finalTarget = weakestFriendly
			else
				return
			end
		end

		local isTargetHero = finalTarget:IsHero()
		local allowsHeroes = bit.band(targetType, DOTA_UNIT_TARGET_HERO) ~= 0
		local allowsBasic = bit.band(targetType, DOTA_UNIT_TARGET_BASIC) ~= 0

		if isTargetHero and not allowsHeroes then
			return
		end
		if not isTargetHero and not allowsBasic then
			return
		end

		order.OrderType = DOTA_UNIT_ORDER_CAST_TARGET
		order.TargetIndex = finalTarget:entindex()
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
		order.OrderType = DOTA_UNIT_ORDER_CAST_POSITION
		order.Position = target:GetAbsOrigin()

		local fDist = (target:GetOrigin() - thisEntity:GetOrigin()):Length2D()
		if fDist > 400 and target:IsMoving() then
			local vLeadingOffset = target:GetForwardVector() * RandomInt(200, 400)
			order.Position = target:GetOrigin() + vLeadingOffset
		end
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
		order.OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET
	elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE) == DOTA_ABILITY_BEHAVIOR_TOGGLE then
		if not ability:GetToggleState() then
			ability:ToggleAbility()
		end
		return
	else
		return
	end

	if string.find(ability:GetName(), "item_octarine_core") then
		thisEntity.refresh = 0
	else
		thisEntity.refresh = thisEntity.refresh + 1
	end

	if order.OrderType then
		ExecuteOrderFromTable(order)
	end
end

function RetreatHome()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = thisEntity.vInitialSpawnPos,
	})
	return THINK_INTERVAL
end

function Retreat(target)
	local vAwayFromEnemy = thisEntity:GetOrigin() - target:GetOrigin()
	vAwayFromEnemy = vAwayFromEnemy:Normalized()
	local vMoveToPos = thisEntity:GetOrigin() + vAwayFromEnemy * thisEntity:GetIdealSpeed()

	thisEntity.fTimeOfLastRetreat = GameRules:GetGameTime()

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
		Position = vMoveToPos,
	})

	return THINK_INTERVAL * 2
end

-- local THINK_INTERVAL = 0.5
-- local IDLE_THINK_INTERVAL = 1.0 -- реже думают милишники без активок (им скан не нужен)
-- local RETREAT_DISTANCE = 1500
-- local SEARCH_DISTANCE = 900 -- было 1500; у крипов acquisition range ~800, 1500 избыточен и дорог в плотных волнах

-- local LIMITED_CAST_SET = {
--     ["item_guardian_greaves"] = true, ["item_satanic"] = true, ["item_bloodstone"] = true,
--     ["item_crimson_guard"] = true, ["item_pipe"] = true, ["item_glimmer_cape"] = true,
--     ["creep_freezing_field_lua"] = true, ["creep_purification_lua"] = true
-- }

-- local CAST_HP_PCT = 80

-- function Spawn(entityKeyValues)
--     if not IsServer() or not thisEntity then return end
--     thisEntity.refresh = 0
--     thisEntity.spells = {}
--     thisEntity.items = {}
--     thisEntity.bInitialized = false
--     thisEntity.fTimeOfLastRetreat = 0
--     thisEntity:SetContextThink("NeutralThink", function() return NeutralThink() end, THINK_INTERVAL)
-- end

-- function UpdateAbilitiesAndItems()
--     thisEntity.spells = {}

--     local abilityCount = thisEntity:GetAbilityCount()
--     for i = 0, abilityCount - 1 do
--         local ability = thisEntity:GetAbilityByIndex(i)
--         if ability and not ability:IsAttributeBonus() and not ability:IsHidden() and not ability:IsPassive() then
--             table.insert(thisEntity.spells, ability)
--         end
--     end

--     thisEntity.items = {}
--     for i = 0, 5 do
--         local item = thisEntity:GetItemInSlot(i)
--         if item then
--             table.insert(thisEntity.items, item)
--         end
--     end
-- end

-- function NeutralThink()
--     if not thisEntity:IsAlive() then return -1 end
--     if thisEntity:IsStunned() or thisEntity:IsSilenced() or GameRules:IsGamePaused() then return THINK_INTERVAL end

--     if not thisEntity.bInitializedSpells then
--         UpdateAbilitiesAndItems()
--         thisEntity.bInitializedSpells = true
--     end

--     if not thisEntity.bInitialized then
--         thisEntity.vInitialSpawnPos = thisEntity:GetAbsOrigin()
--         thisEntity.bInitialized = true
--     end

--     local hasCastables = (#thisEntity.spells > 0) or (#thisEntity.items > 0)
--     local isRanged = thisEntity:IsRangedAttacker()

--     -- ЛЁГКИЙ ПУТЬ: обычный милишник без активных способностей/предметов.
--     -- Ему не нужен дорогой FindUnitsInRadius — нативный аггро сам атакует.
--     -- Лизинг (возврат домой) определяем по GetAggroTarget() — это бесплатно.
--     if not hasCastables and not isRanged then
--         if not thisEntity:GetAggroTarget() then
--             if (thisEntity:GetAbsOrigin() - thisEntity.vInitialSpawnPos):Length2D() > 100 then
--                 return RetreatHome()
--             end
--         end
--         return IDLE_THINK_INTERVAL
--     end

--     local enemies = FindUnitsInRadius(
--         thisEntity:GetTeamNumber(),
--         thisEntity:GetOrigin(),
--         thisEntity,
--         SEARCH_DISTANCE,
--         DOTA_UNIT_TARGET_TEAM_ENEMY,
--         DOTA_UNIT_TARGET_ALL,
--         DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
--         FIND_CLOSEST,
--         false
--     )

--     local filteredEnemiesForCast = {}
--     local retreat_enemy = nil

--     if hasCastables or isRanged then
--         for _, enemy in pairs(enemies) do
--             -- Проверяем, что сущность существует в движке и не была удалена
--             if enemy and not enemy:IsNull() and IsValidEntity(enemy) and enemy:IsAlive() then
--                 local unitName = enemy:GetUnitName()

--                 -- Логика фильтрации для каста
--                 if enemy:GetTeamNumber() == DOTA_TEAM_GOODGUYS and unitName ~= 'npc_dota_observer_wards' then
--                     table.insert(filteredEnemiesForCast, enemy)
--                 end

--                 -- Логика отступления для дальнего боя
--                 if isRanged and not retreat_enemy then
--                     if (enemy:GetOrigin() - thisEntity:GetOrigin()):Length2D() < 400 then
--                         local gameTime = GameRules:GetGameTime()
--                         if (not thisEntity.fTimeOfLastRetreat or (gameTime > thisEntity.fTimeOfLastRetreat + 4)) then
--                             retreat_enemy = enemy
--                         end
--                     end
--                 end
--             end
--         end
--     end

--     if #enemies == 0 then
--         if thisEntity:HasModifier('modifier_creep_antilag') then
--             if (thisEntity:GetAbsOrigin() - thisEntity.vInitialSpawnPos):Length2D() > 100 then return RetreatHome() end
--             return THINK_INTERVAL
--         end
--         local realCheck = _G.OldFindUnitsInRadius(
--             thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), nil,
--             SEARCH_DISTANCE, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL,
--             DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
--             FIND_CLOSEST, false
--         )
--         if #realCheck > 0 then
--             enemies = realCheck
--         else
--             thisEntity:AddNewModifier(thisEntity, nil, 'modifier_creep_antilag', {})
--             if (thisEntity:GetAbsOrigin() - thisEntity.vInitialSpawnPos):Length2D() > 100 then return RetreatHome() end
--             return THINK_INTERVAL
--         end
--     end

--     thisEntity:RemoveModifierByName('modifier_creep_antilag')

--     thisEntity.castables = {}
--     if #filteredEnemiesForCast > 0 then
--         thisEntity.target = filteredEnemiesForCast[RandomInt(1, #filteredEnemiesForCast)]

--         local sources = {thisEntity.spells, thisEntity.items}
--         for _, source in ipairs(sources) do
--             for _, ability in ipairs(source) do
--                 if ability and not ability:IsNull() and ability:IsFullyCastable() then
--                     local name = ability:GetName()
--                     local dist = (thisEntity.target:GetAbsOrigin() - thisEntity:GetAbsOrigin()):Length2D()
--                     local range = ability:GetCastRange(thisEntity:GetAbsOrigin(), thisEntity.target) + thisEntity:GetCastRangeBonus()
--                     if range <= 0 then range = thisEntity:GetAcquisitionRange() end

--                     local canCast = true
--                     if LIMITED_CAST_SET[name] and thisEntity:GetHealthPercent() >= CAST_HP_PCT then canCast = false end
--                     if name == "item_octarine_core" and thisEntity.refresh < 5 then canCast = false end

--                     if canCast and dist <= (range - 100) then
--                         table.insert(thisEntity.castables, ability)
--                     end
--                 end
--             end
--         end
--     end

--     if retreat_enemy then return Retreat(retreat_enemy) end

--     if #thisEntity.castables > 0 and thisEntity.target then
--         local spell = thisEntity.castables[RandomInt(1, #thisEntity.castables)]
--         ExecuteSmartCast(spell, thisEntity.target)
--         return THINK_INTERVAL
--     end

--     return THINK_INTERVAL
-- end

-- function ExecuteSmartCast(ability, target)
--     if not ability or ability:IsNull() or not target or target:IsNull() then return end

--     local behavior = ability:GetBehaviorInt()
--     local targetTeam = ability:GetAbilityTargetTeam()
--     local targetType = ability:GetAbilityTargetType()

--     if target:IsUnselectable() or target:IsInvulnerable() or target:IsOther() then
--         return
--     end

--     local order = {
--         UnitIndex = thisEntity:entindex(),
--         AbilityIndex = ability:entindex(),
--         Queue = false
--     }

--     if bit.band(behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then

--         local finalTarget = target

--         if bit.band(targetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) ~= 0 then
--             local castRange = ability:GetCastRange(thisEntity:GetAbsOrigin(), nil) + thisEntity:GetCastRangeBonus()

--             local friendlies = FindUnitsInRadius(
--                 thisEntity:GetTeamNumber(),
--                 thisEntity:GetAbsOrigin(),
--                 thisEntity,
--                 castRange,
--                 DOTA_UNIT_TARGET_TEAM_FRIENDLY,
--                 targetType,
--                 DOTA_UNIT_TARGET_FLAG_NONE,
--                 FIND_ANY_ORDER,
--                 false
--             )

--             local weakestFriendly = nil
--             local lowestHealthPct = 1.1

--             for _, friend in pairs(friendlies) do
--                 if friend and not friend:IsNull() and friend:IsAlive() and not friend:IsInvulnerable() then
--                     local healthPct = friend:GetHealth() / friend:GetMaxHealth()
--                     if healthPct < lowestHealthPct then
--                         lowestHealthPct = healthPct
--                         weakestFriendly = friend
--                     end
--                 end
--             end

--             if weakestFriendly then
--                 finalTarget = weakestFriendly
--             else
--                 return
--             end
--         end

--         local isTargetHero = finalTarget:IsHero()
--         local allowsHeroes = bit.band(targetType, DOTA_UNIT_TARGET_HERO) ~= 0
--         local allowsBasic = bit.band(targetType, DOTA_UNIT_TARGET_BASIC) ~= 0

--         if isTargetHero and not allowsHeroes then return end
--         if not isTargetHero and not allowsBasic then return end

--         order.OrderType = DOTA_UNIT_ORDER_CAST_TARGET
--         order.TargetIndex = finalTarget:entindex()

--     elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_POINT) == DOTA_ABILITY_BEHAVIOR_POINT then
--         order.OrderType = DOTA_UNIT_ORDER_CAST_POSITION
--         order.Position = target:GetAbsOrigin()

--         local fDist = (target:GetOrigin() - thisEntity:GetOrigin()):Length2D()
--         if fDist > 400 and target:IsMoving() then
--             local vLeadingOffset = target:GetForwardVector() * RandomInt(200, 400)
--             order.Position = target:GetOrigin() + vLeadingOffset
--         end

--     elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
--         order.OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET

--     elseif bit.band(behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE) == DOTA_ABILITY_BEHAVIOR_TOGGLE then
--         if not ability:GetToggleState() then
--             ability:ToggleAbility()
--         end
--         return
--     else
--         return
--     end

--     if string.find(ability:GetName(), "item_octarine_core") then
--         thisEntity.refresh = 0
--     else
--         thisEntity.refresh = thisEntity.refresh + 1
--     end

--     if order.OrderType then
--         ExecuteOrderFromTable(order)
--     end
-- end

-- function RetreatHome()
-- 	ExecuteOrderFromTable({
-- 		UnitIndex = thisEntity:entindex(),
-- 		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
-- 		Position = thisEntity.vInitialSpawnPos,
-- 	})
-- 	return THINK_INTERVAL
-- end

-- function Retreat(target)
-- 	local vAwayFromEnemy = thisEntity:GetOrigin() - target:GetOrigin()
-- 	vAwayFromEnemy = vAwayFromEnemy:Normalized()
-- 	local vMoveToPos = thisEntity:GetOrigin() + vAwayFromEnemy * thisEntity:GetIdealSpeed()

-- 	thisEntity.fTimeOfLastRetreat = GameRules:GetGameTime()

-- 	ExecuteOrderFromTable({
-- 		UnitIndex = thisEntity:entindex(),
-- 		OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
-- 		Position = vMoveToPos,
-- 	})

-- 	return THINK_INTERVAL * 2
-- end