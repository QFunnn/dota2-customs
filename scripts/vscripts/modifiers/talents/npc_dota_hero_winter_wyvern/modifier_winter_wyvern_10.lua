--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_winter_wyvern_10=class({})

function modifier_winter_wyvern_10:IsHidden() return true end
function modifier_winter_wyvern_10:IsPurgable() return false end
function modifier_winter_wyvern_10:IsPurgeException() return false end
function modifier_winter_wyvern_10:RemoveOnDeath() return false end

function modifier_winter_wyvern_10:OnCreated()
    self.bonus = {-10,-15,-20}
    self.bonus2 = {100,200,300}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
    local winter_wyvern_cold_embrace_custom = self:GetParent():FindAbilityByName("winter_wyvern_cold_embrace_custom")
    if winter_wyvern_cold_embrace_custom then
        winter_wyvern_cold_embrace_custom:SetLevel(0)
        winter_wyvern_cold_embrace_custom:SetHidden(true)
    end
end

function modifier_winter_wyvern_10:OnRefresh()
    self.bonus = {-10,-15,-20}
    self.bonus2 = {100,200,300}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_winter_wyvern_10:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_winter_wyvern_10:GetModifierIncomingDamage_Percentage(params)
    if params.attacker and params.attacker:IsHero() then
        return self.bonus[self:GetStackCount()]
    end
end

function modifier_winter_wyvern_10:GetModifierHealthBonus()
    return self.bonus2[self:GetStackCount()]
end