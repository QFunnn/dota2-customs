--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_9=class({})

function modifier_tinker_9:IsHidden() return true end
function modifier_tinker_9:IsPurgable() return false end
function modifier_tinker_9:IsPurgeException() return false end
function modifier_tinker_9:RemoveOnDeath() return false end

function modifier_tinker_9:OnCreated()
    self.bonus = {20,40,60}
    self.bonus2 = {300,600,900}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_tinker_9:OnRefresh()
    self.bonus = {20,40,60}
    self.bonus2 = {300,600,900}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_tinker_9:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MANACOST_PERCENTAGE_STACKING,
        MODIFIER_PROPERTY_PROJECTILE_SPEED_BONUS
    }
end

function modifier_tinker_9:GetModifierPercentageManacostStacking(params)
    if params.ability and params.ability:GetAbilityName() == "tinker_deploy_turrets_custom" then
        return self.bonus[self:GetStackCount()]
    end
end

function modifier_tinker_9:GetModifierProjectileSpeedBonus()
    return self.bonus2[self:GetStackCount()]
end