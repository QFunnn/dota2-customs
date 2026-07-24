--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_9=class({})

function modifier_winter_wyvern_9:IsHidden() return true end
function modifier_winter_wyvern_9:IsPurgable() return false end
function modifier_winter_wyvern_9:IsPurgeException() return false end
function modifier_winter_wyvern_9:RemoveOnDeath() return false end

function modifier_winter_wyvern_9:OnCreated()
    self.bonus = {6,12,18}
    self.bonus2 = {12,24,36}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_winter_wyvern_9:OnRefresh()
    self.bonus = {6,12,18}
    self.bonus2 = {12,24,36}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_winter_wyvern_9:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    }
end

function modifier_winter_wyvern_9:GetModifierBonusStats_Agility()
    return self.bonus[self:GetStackCount()]
end

function modifier_winter_wyvern_9:GetModifierConstantManaRegen()
    return self:GetParent():GetAgility() / 100 * self.bonus2[self:GetStackCount()]
end