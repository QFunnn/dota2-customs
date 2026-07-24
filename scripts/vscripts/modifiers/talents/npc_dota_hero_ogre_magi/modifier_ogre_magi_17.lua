--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_17=class({})

function modifier_ogre_magi_17:IsHidden() return true end
function modifier_ogre_magi_17:IsPurgable() return false end
function modifier_ogre_magi_17:IsPurgeException() return false end
function modifier_ogre_magi_17:RemoveOnDeath() return false end

function modifier_ogre_magi_17:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ogre_magi_bloodlust_custom = self:GetCaster():FindAbilityByName("ogre_magi_bloodlust_custom")
	if ogre_magi_bloodlust_custom then
		ogre_magi_bloodlust_custom:SetHidden(true)
		ogre_magi_bloodlust_custom:SetActivated(false)
	end
    self:GetParent():RemoveModifierByName("modifier_ogre_magi_bloodlust_custom_aura")
end

function modifier_ogre_magi_17:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end