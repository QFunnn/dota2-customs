--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_neutral_upgrade_lua", "creature_ability/neutral_upgrade_lua.lua", LUA_MODIFIER_MOTION_NONE)

if neutral_upgrade_lua == nil then
	neutral_upgrade_lua = class({}) ---@class neutral_upgrade_lua : CDOTA_Ability_Lua
end

function neutral_upgrade_lua:GetIntrinsicModifierName()
	return "modifier_neutral_upgrade_lua"
end

---------------------------------------------------------------------
if modifier_neutral_upgrade_lua == nil then
	modifier_neutral_upgrade_lua = class({}) ---@class modifier_neutral_upgrade_lua : CDOTA_Modifier_Lua
end

function modifier_neutral_upgrade_lua:IsHidden()
	return false
end

function modifier_neutral_upgrade_lua:IsDebuff()
	return false
end

function modifier_neutral_upgrade_lua:IsPurgable()
	return false
end

function modifier_neutral_upgrade_lua:OnCreated()
	if self:GetParent():GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then return end

	local ability = self:GetAbility()
	if not ability then return end

	self.base_attack_time_reduction = ability:GetSpecialValueFor("base_attack_time_reduction")
	self.attack_speed = ability:GetSpecialValueFor("attack_speed")
	self.min_base_attack_time_reduction = ability:GetSpecialValueFor("min_base_attack_time_reduction")
	if not IsServer() then return end

	self:StartIntervalThink(1)
	self:RecalculateStats()
	self:SetHasCustomTransmitterData(true)
	self:SendBuffRefreshToClients()
end

function modifier_neutral_upgrade_lua:OnRefresh()
	if self:GetParent():GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then return end

	local ability = self:GetAbility()
	if not ability then return end
	self.base_attack_time_reduction = ability:GetSpecialValueFor("base_attack_time_reduction")
	self.attack_speed = ability:GetSpecialValueFor("attack_speed")
	self.min_base_attack_time_reduction = ability:GetSpecialValueFor("min_base_attack_time_reduction")
	if not IsServer() then return end

	self:RecalculateStats()
	self:SendBuffRefreshToClients()
end

function modifier_neutral_upgrade_lua:OnIntervalThink()
	if GameMode.currentRound.roundTimeExceeded == true then
		local parent = self:GetParent()
		if not parent:HasModifier("modifier_creature_berserk") then
			parent:AddNewModifier(parent, nil, "modifier_creature_berserk", {})
		end

		self:RecalculateStats()
		self:SendBuffRefreshToClients()
	end
end

function modifier_neutral_upgrade_lua:RecalculateStats()
	local parent = self:GetParent()
	parent:RemoveModifierByName("modifier_roshan_inherent_buffs")
	if (parent:HasAbility("roshan_devotion")) then
		parent:RemoveAbility("roshan_devotion")
	end
	self:SetStackCount(GameMode.currentRound.roundNumber or 1)

	local stack = self:GetStackCount()

	local reduction_pct = 0
	if stack > 70 then
		reduction_pct = math.min(99, 0.67 * stack - 17)
	else
		reduction_pct = math.min(99, 0.01 * math.pow(stack, 1.407 + stack * 0.0068))
	end
	self.bonus_armor = ReductionToArmor(reduction_pct)
	self.bonus_magical_resistance = reduction_pct

	local tKv = GetUnitKeyValuesByName(parent:GetUnitName())
	if tKv.AttackRate then
		local AttackRate = tonumber(tKv.AttackRate)
		self.AttackRate = math.max(self.min_base_attack_time_reduction,
			AttackRate - stack * self.base_attack_time_reduction)
	end
	local fDamageMin = tKv.AttackDamageMin
	local fDamageMax = tKv.AttackDamageMax
	if fDamageMax and fDamageMin then
		local fDamageAverage = (fDamageMax + fDamageMin) * 0.5
		local flDamageMultiple = 1

		if stack <= 10 then
			flDamageMultiple = math.pow(1.165, stack)
		elseif stack > 10 and stack <= 20 then
			flDamageMultiple = math.pow(1.165, 10) * math.pow(1.124, stack - 10)
		elseif stack > 20 and stack <= 30 then
			flDamageMultiple = math.pow(1.165, 10) * math.pow(1.124, 10) * math.pow(1.113, stack - 20)
		elseif stack > 30 then
			flDamageMultiple = math.pow(1.165, 10) * math.pow(1.124, 10) * math.pow(1.113, 10) *
				math.pow(1.11, stack - 30)
		end

		self.bonus_base_damage = math.min(108000000, fDamageAverage * flDamageMultiple * 0.85 - fDamageAverage)
	end
	local fHealth = tKv.StatusHealth
	if fHealth then
		local fHPMultiple = 1

		if stack <= 10 then
			fHPMultiple = math.pow(1.196, stack)
		elseif stack > 10 and stack <= 20 then
			fHPMultiple = math.pow(1.196, 10) * math.pow(1.145, stack - 10)
		elseif stack > 20 and stack <= 30 then
			fHPMultiple = math.pow(1.196, 10) * math.pow(1.145, 10) * math.pow(1.125, stack - 20)
		elseif stack > 30 then
			fHPMultiple = math.pow(1.196, 10) * math.pow(1.145, 10) * math.pow(1.125, 10) *
				math.pow(1.12, stack - 30)
		end
		self.bonus_hp = math.min(99990000, fHealth * fHPMultiple * 0.6 - fHealth)
	end
end

function modifier_neutral_upgrade_lua:AddCustomTransmitterData()
	return {
		AttackRate = self.AttackRate,
		bonus_base_damage = self.bonus_base_damage,
		bonus_hp = self.bonus_hp,
		bonus_armor = self.bonus_armor,
		bonus_magical_resistance = self.bonus_magical_resistance,
	}
end

function modifier_neutral_upgrade_lua:HandleCustomTransmitterData(t)
	self.AttackRate = t.AttackRate
	self.bonus_base_damage = t.bonus_base_damage
	self.bonus_hp = t.bonus_hp
	self.bonus_armor = t.bonus_armor
	self.bonus_magical_resistance = t.bonus_magical_resistance
end

function modifier_neutral_upgrade_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BASE_ATTACK_TIME_CONSTANT,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_EXTRA_HEALTH_BONUS,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
end

function modifier_neutral_upgrade_lua:GetModifierBaseAttackTimeConstant()
	return self.AttackRate or 0
end

function modifier_neutral_upgrade_lua:GetModifierAttackSpeedBonus_Constant()
	return (self.attack_speed or 0) * self:GetStackCount()
end

function modifier_neutral_upgrade_lua:GetModifierBaseAttack_BonusDamage()
	return self.bonus_base_damage or 0
end

function modifier_neutral_upgrade_lua:GetModifierExtraHealthBonus()
	return self.bonus_hp or 0
end

function modifier_neutral_upgrade_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_neutral_upgrade_lua:GetModifierMagicalResistanceBonus()
	return self.bonus_magical_resistance
end