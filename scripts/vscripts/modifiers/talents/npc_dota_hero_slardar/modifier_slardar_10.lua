--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_slardar_10=class({})

function modifier_slardar_10:IsHidden() return true end
function modifier_slardar_10:IsPurgable() return false end
function modifier_slardar_10:IsPurgeException() return false end
function modifier_slardar_10:RemoveOnDeath() return false end

function modifier_slardar_10:OnCreated()
	self.bonus={7,14}
	self.bonus2={7,14}
	self.bonus3={14,28}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_slardar_10:OnRefresh()
	self.bonus={7,14}
	self.bonus2={7,14}
	self.bonus3={14,28}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_slardar_10:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_slardar_10:GetModifierProperty_PhysicalLifesteal(params)
    return self.bonus[self:GetStackCount()]
end

function modifier_slardar_10:GetModifierStatusResistanceStacking()
	return self.bonus2[self:GetStackCount()]
end

function modifier_slardar_10:GetModifierAttackSpeedBonus_Constant()
	return self.bonus3[self:GetStackCount()]
end