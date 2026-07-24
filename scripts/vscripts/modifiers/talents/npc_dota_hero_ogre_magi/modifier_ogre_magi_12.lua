--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_12=class({})

function modifier_ogre_magi_12:IsHidden() return true end
function modifier_ogre_magi_12:IsPurgable() return false end
function modifier_ogre_magi_12:IsPurgeException() return false end
function modifier_ogre_magi_12:RemoveOnDeath() return false end

function modifier_ogre_magi_12:OnCreated()
    self.multicast = self:GetCaster():FindAbilityByName("ogre_magi_multicast_custom")
	self.damage_per_pct = {1,2}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_ogre_magi_12:OnRefresh()
    self.multicast = self:GetCaster():FindAbilityByName("ogre_magi_multicast_custom")
	self.damage_per_pct = {1,2}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_ogre_magi_12:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE
	}
end

function modifier_ogre_magi_12:GetModifierBaseAttack_BonusDamage()
	local multicast = self.multicast
	if not multicast then return 0 end
	return self.damage_per_pct[self:GetStackCount()] * multicast:GetMulticastChance(4)
end