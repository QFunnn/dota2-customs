--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


modifier_boss_damage_boost = class({})

function modifier_boss_damage_boost:IsHidden()
	return true
end
function modifier_boss_damage_boost:IsPurgable()
	return false
end
function modifier_boss_damage_boost:RemoveOnDeath()
	return false
end
function modifier_boss_damage_boost:IsPermanent()
	return true
end

function modifier_boss_damage_boost:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
		MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE,
	}
end

-- function modifier_boss_damage_boost:OnCreated(kv)
--     if not IsServer() then return end
--     self:SetHasCustomTransmitterData(true)
--     self:CalculateValue()
-- end

function modifier_boss_damage_boost:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:SetHasCustomTransmitterData(true)
	self:CalculateValue()
	self:StartIntervalThink(1.0)
end

function modifier_boss_damage_boost:OnIntervalThink()
	if not IsServer() then
		return
	end

	local current_diff = _G.Game_Difficulty - 1
	if self.fDifficulty ~= current_diff then
		self:CalculateValue()
	end
end

function modifier_boss_damage_boost:CalculateValue()
	local ability = self:GetAbility()
	if not ability or ability:IsNull() then
		return
	end

	self.fDifficulty = _G.Game_Difficulty - 1
	self:SendBuffRefreshToClients()
end

-- function modifier_boss_damage_boost:CalculateValue()
--     local ability = self:GetAbility()
--     if not ability or ability:IsNull() then return end

--     self.fDifficulty = _G.Game_Difficulty - 1

--     self:SendBuffRefreshToClients()
-- end

function modifier_boss_damage_boost:AddCustomTransmitterData()
	return {
		fDifficulty = self.fDifficulty,
	}
end

function modifier_boss_damage_boost:HandleCustomTransmitterData(data)
	self.fDifficulty = data.fDifficulty
end

function modifier_boss_damage_boost:GetModifierOverrideAbilitySpecial(params)
	if not params.ability or params.ability:IsNull() then
		return 0
	end

	local name = params.ability_special_value
	if name == "diff_boost_damage" or name == "diff_boost_additional" then
		return 1
	end
	return 0
end

function modifier_boss_damage_boost:GetModifierOverrideAbilitySpecialValue(params)
	if not self.fDifficulty then
		return 0
	end

	local ability = params.ability
	if not ability or ability:IsNull() then
		return 0
	end

	local name = params.ability_special_value
	local level = ability:GetLevel() - 1
	if level < 0 then
		level = 0
	end

	local base_value = ability:GetLevelSpecialValueNoOverride(name, level)

	return base_value * self.fDifficulty
end