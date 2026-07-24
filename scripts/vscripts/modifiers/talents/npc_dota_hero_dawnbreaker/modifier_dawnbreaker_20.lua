--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_dawnbreaker_20=class({})

function modifier_dawnbreaker_20:IsHidden() return true end
function modifier_dawnbreaker_20:IsPurgable() return false end
function modifier_dawnbreaker_20:IsPurgeException() return false end
function modifier_dawnbreaker_20:RemoveOnDeath() return false end

function modifier_dawnbreaker_20:OnCreated()
    self.bonus = {2,4}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_dawnbreaker_20:OnRefresh()
    self.bonus = {2,4}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_dawnbreaker_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_dawnbreaker_20:GetModifierPhysicalArmorBonus()
    return self.bonus[self:GetStackCount()]
end