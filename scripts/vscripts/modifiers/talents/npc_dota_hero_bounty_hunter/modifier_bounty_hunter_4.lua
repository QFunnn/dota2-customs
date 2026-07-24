--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bounty_hunter_4=class({})

function modifier_bounty_hunter_4:IsHidden() return true end
function modifier_bounty_hunter_4:IsPurgable() return false end
function modifier_bounty_hunter_4:IsPurgeException() return false end
function modifier_bounty_hunter_4:RemoveOnDeath() return false end

function modifier_bounty_hunter_4:OnCreated()
    self.gold = {2,4,6}
    self.bonus={100,200,300}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_bounty_hunter_4:OnRefresh()
    self.gold = {2,4,6}
    self.bonus={100,200,300}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_bounty_hunter_4:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_HEALTH_BONUS,
        MODIFIER_PROPERTY_MANA_BONUS
    }
end

function modifier_bounty_hunter_4:OnDeath(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not params.unit:IsNeutralUnitType() then return end
    self:GetParent():ModifyGold(self.gold[self:GetStackCount()], false, 0)
    SendOverheadEventMessage(self:GetCaster(), OVERHEAD_ALERT_GOLD, self:GetCaster(), self.gold[self:GetStackCount()], nil)
end

function modifier_bounty_hunter_4:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end

function modifier_bounty_hunter_4:GetModifierManaBonus()
    return self.bonus[self:GetStackCount()]
end