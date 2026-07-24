--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pangolier_5=class({})

function modifier_pangolier_5:IsHidden() return true end
function modifier_pangolier_5:IsPurgable() return false end
function modifier_pangolier_5:IsPurgeException() return false end
function modifier_pangolier_5:RemoveOnDeath() return false end

function modifier_pangolier_5:OnCreated()
    self.bonus_damage = {-2,-4,-6}
    self.speed = {15,30,45}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_pangolier_5:OnRefresh()
    self.bonus_damage = {-2,-4,-6}
    self.speed = {15,30,45}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_pangolier_5:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_pangolier_5:GetModifierIncomingDamage_Percentage()
    return self.bonus_damage[self:GetStackCount()]
end

function modifier_pangolier_5:GetModifierMoveSpeedBonus_Constant()
    return self.speed[self:GetStackCount()]
end
