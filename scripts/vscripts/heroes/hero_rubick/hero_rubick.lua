--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_hero_rubick", "heroes/hero_rubick/hero_rubick", LUA_MODIFIER_MOTION_NONE)

hero_rubick_ability = class({})

function hero_rubick_ability:GetBehavior()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_rubick_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
	end
	return DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_NOT_LEARNABLE
end

-- local rubick_ability = {
local unremovableAbilitiesMap = {
	["special_bonus_mp_600"] = true,
	["special_bonus_gold_income_60"] = true,
	["special_bonus_mana_reduction_11"] = true,
	["special_bonus_cast_speed_30"] = true,
	["special_bonus_spell_lifesteal_10"] = true,
	["special_bonus_cast_range_200"] = true,
	["special_bonus_all_stats_20"] = true,
	["special_bonus_unique_rubick_5"] = true,
	["hero_rubick_ability"] = true,
	["ability_capture_lua"] = true,
	["new_year_snowball"] = true,
	["pain_six_paths_authority"] = true,
	["itachi_crow_guard"] = true,
	["kisame_samehada_hunger"] = true,
	["hidan_ritual_of_blood"] = true,
	["tobi_phantom_strike"] = true,
	["zetsu_root_assimilation"] = true,
	["deidara_unstable_art"] = true,
	["konan_paper_dance"] = true,
	["kakuzu_earth_grudge_fear"] = true,
	["sasori_red_secret_technique"] = true,
}

local invalid_ability_names = {
	"special_bonus",
	"ability_lamp_use",
	"ability_pluck_famango",
	"twin_gate_portal_warp",
	"ability_capture",
	"hero_rubick_ability",
	"NoAbilityName",
	"generic_hidden",
	"abyssal_underlord_portal_warp",
	"techies_focused_detonate_lua",
	"techies_remote_mines_lua",
	-- akatsuki
	"hidan_",
	"kakuzu_",
	"konan_",
	"sasori_",
	"kisame_",
	"itachi_",
	"deidara_",
	"zetsu_",
	"tobi_",
	"pain_",
}

function is_invalid_ability(ability_name)
	for _, invalid_name in ipairs(invalid_ability_names) do
		if string.find(ability_name, invalid_name) then
			return true
		end
	end
	return false
end

function hero_rubick_ability:OnSpellStart()
	local hero = self:GetCaster()
	self.ability_level = {}
	local ability_list = {}
	local ability_list_ult = {}
	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)
		if ability and not ability:IsNull() then
			local ability_name = ability:GetAbilityName()
			if not unremovableAbilitiesMap[ability_name] then
				table.insert(self.ability_level, ability:GetLevel())
				hero:RemoveAbility(ability_name)
			end
		end
	end

	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
		if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero(nPlayerID) then
				local unit = PlayerResource:GetSelectedHeroEntity(nPlayerID)
				if unit ~= hero then
					for i = 0, 5 do
						local ability = unit:GetAbilityByIndex(i)
						if ability and not ability:IsNull() and not ability:IsHidden() then
							local ability_name = ability:GetAbilityName()
							if not is_invalid_ability(ability_name) and ability:GetAbilityType() ~= 2 then
								if ability:GetAbilityType() == 1 then
									table.insert(ability_list_ult, ability_name)
								else
									table.insert(ability_list, ability_name)
								end
							end
						end
					end
				end
			end
		end
	end

	for i = 0, 2 do
		if #ability_list == 0 then
			break
		end
		local new_ability_name = nil
		while true do
			new_ability_name = table.shuffle(ability_list)[1]
			if not new_ability_name then
				break
			end
			local existing_ability = hero:FindAbilityByName(new_ability_name)
			if not existing_ability then
				break
			end
		end
		if new_ability_name then
			local new_ability = hero:AddAbility(new_ability_name)
			if new_ability then
				local level = self.ability_level[i + 1] or 0
				new_ability:SetLevel(0)
				new_ability:SetLevel(level)
			end
		end
	end

	if #ability_list_ult > 0 then
		local new_ability_ult = table.shuffle(ability_list_ult)[1]
		if new_ability_ult then
			local new_ult = hero:AddAbility(new_ability_ult)
			if new_ult then
				local level = self.ability_level[4] or 0
				new_ult:SetLevel(0)
				new_ult:SetLevel(level)
			end
		end
	end
end

function hero_rubick_ability:GetIntrinsicModifierName()
	return "modifier_hero_rubick"
end

function hero_rubick_ability:IsRefreshable()
	return false
end

---------------------------------------------------------------------------------------

modifier_hero_rubick = class({})

function modifier_hero_rubick:IsHidden()
	return true
end

function modifier_hero_rubick:IsPurgeException()
	return false
end

function modifier_hero_rubick:IsPurgable()
	return false
end

function modifier_hero_rubick:RemoveOnDeath()
	return false
end

function modifier_hero_rubick:OnCreated(kv)
	local hero = self:GetCaster()
	self:clear(hero)
	self:StartIntervalThink(0.1)
end

function modifier_hero_rubick:clear(hero)
	self.ability_level = {}
	if not IsServer() then
		return
	end
	for i = 0, hero:GetAbilityCount() - 1 do
		local ability = hero:GetAbilityByIndex(i)
		if ability and not ability:IsNull() then
			local ability_name = ability:GetAbilityName()
			if not unremovableAbilitiesMap[ability_name] then
				table.insert(self.ability_level, ability:GetLevel())
				hero:RemoveAbility(ability_name)
			end
		end
	end
end

function modifier_hero_rubick:OnIntervalThink()
	if IsServer() then
		local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_rubick_5")
		if ability == nil or ability:GetLevel() == 0 then
			local ability = self:GetAbility()
			local caster = self:GetCaster()
			local ability_list = {}
			local ability_list_ult = {}
			if caster:IsRealHero() and caster:IsAlive() and ability:IsCooldownReady() then
				self:clear(caster)
				for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
					if PlayerResource:GetTeam(nPlayerID) == DOTA_TEAM_GOODGUYS then
						if PlayerResource:HasSelectedHero(nPlayerID) then
							local unit = PlayerResource:GetSelectedHeroEntity(nPlayerID)
							if unit ~= hero then
								for i = 0, 5 do
									local ability = unit:GetAbilityByIndex(i)
									if ability and not ability:IsNull() and not ability:IsHidden() then
										local ability_name = ability:GetAbilityName()
										if not is_invalid_ability(ability_name) and ability:GetAbilityType() ~= 2 then
											if ability:GetAbilityType() == 1 then
												table.insert(ability_list_ult, ability_name)
											else
												table.insert(ability_list, ability_name)
											end
										end
									end
								end
							end
						end
					end
				end
				for i = 0, 2 do
					if #ability_list == 0 then
						break
					end
					local new_ability_name = nil
					while true do
						new_ability_name = table.shuffle(ability_list)[1]
						if not new_ability_name then
							break
						end
						local existing_ability = caster:FindAbilityByName(new_ability_name)
						if not existing_ability then
							break
						end
					end
					if new_ability_name then
						local new_ability = caster:AddAbility(new_ability_name)
						if new_ability then
							local level = self.ability_level[i + 1] or 0
							new_ability:SetLevel(level)
						end
					end
				end

				if #ability_list_ult > 0 then
					local new_ability_ult = table.shuffle(ability_list_ult)[1]
					if new_ability_ult then
						local new_ult = caster:AddAbility(new_ability_ult)
						if new_ult then
							local level = self.ability_level[4] or 0
							new_ult:SetLevel(level)
						end
					end
				end
				ability:UseResources(false, false, false, true)
			end
		end
	else
		self:StartIntervalThink(-1)
	end
end