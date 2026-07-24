--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function CDOTA_BaseNPC:IsMonkeyClone()
	return (self:HasModifier("modifier_monkey_king_fur_army_soldier") or self:HasModifier("modifier_wukongs_command_warrior"))
end

function CDOTA_BaseNPC:IsMainHero()
	return self and (not self:IsNull()) and self:IsRealHero() and (not self:IsTempestDouble()) and (not self:IsMonkeyClone())
end

-- Has Aghanim's Shard
function CDOTA_BaseNPC:HasShard()
	if not self or self:IsNull() then return end
	return self:HasModifier("modifier_item_aghanims_shard")
end

-- Talent handling
function CDOTA_BaseNPC:HasTalent(talent_name)
	if not self or self:IsNull() then return end

	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() > 0 then return true end
end

function CDOTA_BaseNPC:FindTalentValue(talent_name, key)
	if self:HasTalent(talent_name) then
		local value_name = key or "value"
		return self:FindAbilityByName(talent_name):GetSpecialValueFor(value_name)
	end
	return 0
end

function CDOTA_BaseNPC:IsUnitInPVP()
	if not self or self:IsNull() then return false end

	local RealUnit = GetRealUnit(self)
	if RealUnit and RealUnit:IsRealHero() then
		-- Mass arena также PvP-режим: курса (modifier_loser_curse) и любые
		-- другие проверки на «не пенальти в PvP» должны исключать оба режима.
		-- Раньше функция учитывала только дуэли; масс-арена ловится через
		-- modifier_mass_arena_player, который вешается в players.lua при заходе
		-- игрока в арену и снимается при выходе.
		if RealUnit:HasModifier("modifier_mass_arena_player") then
			return true
		end
		local PlayerID = RealUnit:GetPlayerID()
		return Rounds:IsPlayerInPVPDuel(PlayerID)
	end

	return false
end

function CDOTA_BaseNPC:IsTruesightImmune()
	if not self or self:IsNull() then return false end
	local AllModifs = self:FindAllModifiers()
	for _, modif in ipairs(AllModifs) do
		local States = {}
		modif:CheckStateToTable(States)

		if States[tostring(MODIFIER_STATE_TRUESIGHT_IMMUNE)] == true then
			return true
		end
	end

	return false
end

function CDOTA_BaseNPC:IsInvisibleForUnit(hUnit)
	if not self or self:IsNull() then return false end
	if not hUnit or hUnit:IsNull() then return false end

	if self:IsInvisible() then
		local bHasImmune = self:IsTruesightImmune()
		local bHasTruesight = false
		local TruesightModifs = self:FindAllModifiersByName("modifier_truesight")
		for _, modif in ipairs(TruesightModifs) do
			-- if modif:GetCaster() then
			-- 	print(modif ~= nil, not modif:IsNull(), modif:GetCaster() ~= nil, modif:GetCaster():GetTeamNumber(), hUnit:GetTeamNumber())
			-- end
			if modif and not modif:IsNull() and modif:GetCaster() and modif:GetCaster():GetTeamNumber() == hUnit:GetTeamNumber() then
				bHasTruesight = true
				break
			end
		end

		if hUnit:GetTeamNumber() ~= self:GetTeamNumber() then
			if bHasTruesight and not bHasImmune then
				return false
			end
		end

		return true
	end

	return false
end

function CDOTA_BaseNPC:IsCustomHasDebuffImmune()
    return self:IsDebuffImmune()
end

function CDOTA_BaseNPC:GetTalentValue(talent_name)
	local talent = self:FindAbilityByName(talent_name)
	if talent and talent:GetLevel() >= 1 then return talent:GetSpecialValueFor("value") end

	return 0
end

function CDOTA_BaseNPC:RemoveAbilityForEmpty(ability_name)
	local ability = self:FindAbilityByName(ability_name)
	if not ability then return end
	
	ability:Disable()
	ability:SetRemovalTimer()
end

function CDOTA_BaseNPC:RemoveAbilityWithRestructure(ability_name)
	local ability = self:FindAbilityByName(ability_name)
	if not ability then return end

	ability:Disable()
	ability:SetRemovalTimer()
	-- if index > 5 then return end
	-- Timers:CreateTimer(function()
	-- 	for i = index, self:GetAbilityCount()-1 do
	-- 		local next_ability = self:GetAbilityByIndex(i + 1)
	-- 		if next_ability and not next_ability.placeholder and not next_ability:IsHidden() then
	-- 			local next_ability_name = next_ability:GetAbilityName()
	-- 			if not next_ability_name:find("special_bonus") and not next_ability.ignore_ability_structure then
	-- 				self:SwapAbilities(placeholder_name, next_ability_name, false, true)
	-- 			end
	-- 		end
	-- 	end
	-- end)
end

function CDOTA_BaseNPC:GetNextAbilityFromIndex(Index)
	local Count = self:GetAbilityCount() - 1

	for i=Index+1, Count do
		local ab = self:GetAbilityByIndex(i)
		if ab and not ab:IsAttributeBonus() and not ab:IsHidden() then
			return ab
		end
	end
	return nil
end

function CDOTA_BaseNPC:ResolvePassivesPositions()
	for i = 0, self:GetAbilityCount()-1 do
		local Ability = self:GetAbilityByIndex(i)
		local NextAbility = self:GetNextAbilityFromIndex(i)
		if Ability and not Ability:IsAttributeBonus() and not Ability:IsShouldEnabledInSwap() and NextAbility then
			self:SwapAbilities(Ability:GetAbilityName(), NextAbility:GetAbilityName(), Ability:IsShouldEnabledInSwap(), NextAbility:IsShouldEnabledInSwap())
			break
		end
	end
end

function CDOTA_BaseNPC:FindHotKeyForAbility(sAbilityName)
	Timers:CreateTimer(function()
		for i = 0, self:GetAbilityCount()-1 do
			local hPlaceholderAability = self:GetAbilityByIndex(i)
			if hPlaceholderAability and hPlaceholderAability:GetAbilityName()	 then
				local sPlaceholderAbilityName = hPlaceholderAability:GetAbilityName()	
				if sPlaceholderAbilityName == sAbilityName then
					break  
			   end
			   if hPlaceholderAability.nPlaceholder then		
				    self:SwapAbilities(sPlaceholderAbilityName, sAbilityName, false, true)
				    break
				end
			end
		end
	end)
end

_G.vanillaSwapAbilities = _G.vanillaSwapAbilities or CDOTA_BaseNPC.SwapAbilities

function CDOTA_BaseNPC:SwapAbilities(name1, name2, enabled1, enabled2)
	if not self or self:IsNull() then return end

	local Ability1 = self:FindAbilityByName(name1)
	local Ability2 = self:FindAbilityByName(name2)

	vanillaSwapAbilities(self, name1, name2, enabled1, enabled2)

	-- Timers:CreateTimer(0, function()
		if enabled1 and Ability1 and not Ability1:IsNull() then
			Ability1:SetHidden(false)
		end
		if enabled2 and Ability2 and not Ability2:IsNull() then
			Ability2:SetHidden(false)
		end
	-- end)
end

_G.vanillaAddNewModifier = _G.vanillaAddNewModifier or CDOTA_BaseNPC.AddNewModifier

function CDOTA_BaseNPC:AddNewModifier(caster, ability, modifierName, modifierTable)
	if not self or self:IsNull() or modifierName == nil or modifierName == "" then return end

	local AbilityToApply = ability
	if AbilityToApply == nil then
		AbilityToApply = Bans:GetEmptyAbility()
	end

	return vanillaAddNewModifier(self, caster, AbilityToApply, modifierName, modifierTable)
end