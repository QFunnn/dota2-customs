--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


if modifier_difficult == nil then
	modifier_difficult = class({})
end

function modifier_difficult:IsHidden()
	return false
end

function modifier_difficult:IsPurgable()
	return false
end

function modifier_difficult:RemoveOnDeath()
	return false
end

function modifier_difficult:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:SetupRewards(kv)
	self:SetHasCustomTransmitterData(true)
end

function modifier_difficult:SetupRewards(kv)
	if not IsServer() then
		return
	end
	local unit = self:GetParent()
	local start_health = unit:GetMaxHealth()
	local min_damage = unit:GetBaseDamageMin()
	local max_damage = unit:GetBaseDamageMax()
	local base_armor = unit:GetPhysicalArmorBaseValue()
	local base_resist = unit:GetBaseMagicalResistanceValue()

	unit:SetBaseDamageMin(min_damage * (0.4 + ((_G.Game_Difficulty - 1) * 0.4)))
	unit:SetBaseDamageMax(max_damage * (0.4 + ((_G.Game_Difficulty - 1) * 0.4)))
	unit:SetPhysicalArmorBaseValue(base_armor * (0.4 + ((_G.Game_Difficulty - 1) * 0.3)))
	unit:SetBaseMagicalResistanceValue(math.min(99, base_resist * (0.4 + ((_G.Game_Difficulty - 1) * 0.15))))

	-- unit:SetBaseDamageMin(min_damage * (0.5 + ((_G.Game_Difficulty - 1) * 0.3)))
	-- unit:SetBaseDamageMax(max_damage * (0.5 + ((_G.Game_Difficulty - 1) * 0.3)))
	-- unit:SetPhysicalArmorBaseValue(base_armor * (0.5 + ((_G.Game_Difficulty - 1) * 0.2)))
	-- unit:SetBaseMagicalResistanceValue(math.min(99, base_resist * (0.5 + ((_G.Game_Difficulty - 1) * 0.1))))

	self.cd = 100 - ((1.25 - _G.Game_Difficulty / 20) * 100)
	self.speed = (_G.Game_Difficulty - 1) * 5

	local set_health = start_health * (0.4 + ((_G.Game_Difficulty - 1) * 0.4))
	-- local set_health = start_health * (0.5 + ((_G.Game_Difficulty - 1) * 0.3))
	unit:SetMaxHealth(set_health)
	unit:SetBaseMaxHealth(set_health)
	unit:SetHealth(set_health)
end

function modifier_difficult:AddCustomTransmitterData()
	return {
		cd = self.cd,
		speed = self.speed,
	}
end

function modifier_difficult:HandleCustomTransmitterData(data)
	self.cd = data.cd
	self.speed = data.speed
end

function modifier_difficult:GetTexture()
	return "difficult"
end

function modifier_difficult:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_difficult:GetModifierPercentageCooldown()
	return self.cd
end

function modifier_difficult:GetModifierAttackSpeedBonus_Constant()
	return self.speed
end