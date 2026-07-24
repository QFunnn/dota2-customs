--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_16=class({})

function modifier_nyx_assassin_16:IsHidden() return true end
function modifier_nyx_assassin_16:IsPurgable() return false end
function modifier_nyx_assassin_16:IsPurgeException() return false end
function modifier_nyx_assassin_16:RemoveOnDeath() return false end

function modifier_nyx_assassin_16:OnCreated()
    self.bonus_health = {150,300,450}
    self.bonus_resist = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_nyx_assassin_16:OnRefresh()
    self.bonus_health = {150,300,450}
    self.bonus_resist = {3,6,9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_nyx_assassin_16:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MANA_BONUS,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_nyx_assassin_16:GetModifierManaBonus()
	return self.bonus_health[self:GetStackCount()]
end

function modifier_nyx_assassin_16:GetModifierMagicalResistanceBonus()
    return self.bonus_resist[self:GetStackCount()]
end