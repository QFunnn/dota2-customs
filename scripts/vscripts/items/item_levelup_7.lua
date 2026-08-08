--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


item_levelup_7 = class({})

local function spawn_skeleton_warrior(caster, ability, hero_max_health, hero_attack_damage)
	local spawn_position = GetGroundPosition(caster:GetAbsOrigin() + RandomVector(RandomInt(90, 180)), nil)
	local skeleton = CreateUnitByName(
		"npc_levelup_book_of_dead_skeleton_warrior",
		spawn_position,
		true,
		caster,
		caster,
		DOTA_TEAM_GOODGUYS
	)
	if not IsValid(skeleton) then
		return nil
	end

	FindClearSpaceForUnit(skeleton, spawn_position, true)
	if wave_manager then
		wave_manager:InitializeConfiguredCustomHealthUnit(skeleton)
		wave_manager:ApplyAggroSettings(skeleton)
	end

	skeleton:LevelUpSetMaxHealth(hero_max_health)
	skeleton:LevelUpSetHealth(hero_max_health)
	skeleton._levelup_custom_attack_damage_min = math.floor(hero_attack_damage + 0.5)
	skeleton._levelup_custom_attack_damage_max = skeleton._levelup_custom_attack_damage_min

	if card_system and card_system.RegisterOwnedSummonedUnit then
		card_system:RegisterOwnedSummonedUnit(caster, skeleton)
	end

	skeleton:AddNewModifier(caster, ability, "modifier_levelup_simple_summon_ai", {})
	return skeleton
end

function item_levelup_7:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	if not IsValid(caster) then
		return
	end

	local count = self:GetSpecialValueFor("max_count")
	local creep_bonus_pct = self:GetSpecialValueFor("creep_bonus") * 0.01
	local duration = self:GetSpecialValueFor("duration")
	local hero_handler = caster.GetLevelUpHeroHandlerModifier and caster:GetLevelUpHeroHandlerModifier() or nil
	local hero_max_health = (tonumber(caster._levelup_max_health) or 0) * creep_bonus_pct
	local hero_attack_damage = (
		(hero_handler and (hero_handler:GetCustomDamageBonus() + hero_handler:GetCustomProcAttackPhysicalBonus())) or 0
	) * creep_bonus_pct

	local skeletons = {}
	for _ = 1, count do
		local skeleton = spawn_skeleton_warrior(caster, ability, hero_max_health, hero_attack_damage)
		if IsValid(skeleton) then
			table.insert(skeletons, skeleton:entindex())
		end
	end

	if #skeletons > 0 then
		local player_id = caster:GetPlayerOwnerID()
		if player_id ~= nil and player_id >= 0 and player_data and player_data.AddHiddenAchievementCounter then
			local uses = player_data:AddHiddenAchievementCounter(player_id, "book_of_dead_uses", 1)
			if uses >= 10 and services and services.CompleteAchievement then
				services:CompleteAchievement(player_id, "hidden_wabi_babu")
			end

			local alive_book_skeletons = 0
			if card_system and card_system.GetOwnedSummonedUnits then
				for _, unit in ipairs(card_system:GetOwnedSummonedUnits(caster)) do
					if IsValid(unit) and unit:GetUnitName() == "npc_levelup_book_of_dead_skeleton_warrior" then
						alive_book_skeletons = alive_book_skeletons + 1
					end
				end
			end
			if alive_book_skeletons >= 12 and services and services.CompleteAchievement then
				services:CompleteAchievement(player_id, "hidden_skeleton_meeting")
			end
		end

		Timers:CreateTimer(duration, function()
			for _, entindex in ipairs(skeletons) do
				local unit = EntIndexToHScript(entindex)
				if not IsValid(unit) then
					return
				end
				unit:ForceKill(false)
			end
			return nil
		end)
	end

	ConsumeLevelUpItemCharge(caster, ability)
end