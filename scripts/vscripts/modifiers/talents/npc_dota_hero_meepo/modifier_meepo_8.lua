--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_meepo_8=class({})

function modifier_meepo_8:IsHidden() return true end
function modifier_meepo_8:IsPurgable() return false end
function modifier_meepo_8:IsPurgeException() return false end
function modifier_meepo_8:RemoveOnDeath() return false end

function modifier_meepo_8:OnCreated()
	self.bonus={10,20,30}
    self.bonus2={150,300,450}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_meepo_8:OnRefresh()
	self.bonus={10,20,30}
    self.bonus2={150,300,450}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_meepo_8:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS 
	}
end

function modifier_meepo_8:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end
function modifier_meepo_8:GetModifierProjectileSpeedBonus()
	return self.bonus2[self:GetStackCount()]
end