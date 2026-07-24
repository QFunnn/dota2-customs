--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_2=class({})

function modifier_winter_wyvern_2:IsHidden() return true end
function modifier_winter_wyvern_2:IsPurgable() return false end
function modifier_winter_wyvern_2:IsPurgeException() return false end
function modifier_winter_wyvern_2:RemoveOnDeath() return false end

function modifier_winter_wyvern_2:OnCreated()
    self.bonus = {15,30,45}
    self.bonus2 = {2,4,6}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_winter_wyvern_2:OnRefresh()
    self.bonus = {15,30,45}
    self.bonus2 = {2,4,6}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_winter_wyvern_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_winter_wyvern_2:GetModifierPreAttack_BonusDamage()
    return self.bonus[self:GetStackCount()]
end

function modifier_winter_wyvern_2:GetModifierPhysicalArmorBonus()
    return self.bonus2[self:GetStackCount()]
end