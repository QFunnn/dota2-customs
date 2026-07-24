--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_19=class({})

function modifier_ogre_magi_19:IsHidden() return true end
function modifier_ogre_magi_19:IsPurgable() return false end
function modifier_ogre_magi_19:IsPurgeException() return false end
function modifier_ogre_magi_19:RemoveOnDeath() return false end

function modifier_ogre_magi_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ogre_magi_lightning_shield_custom = self:GetCaster():FindAbilityByName("ogre_magi_lightning_shield_custom")
	if ogre_magi_lightning_shield_custom then
		ogre_magi_lightning_shield_custom:SetHidden(false)
		ogre_magi_lightning_shield_custom:SetActivated(true)
		ogre_magi_lightning_shield_custom:SetLevel(1)
        self:GetCaster():SwapAbilities("ogre_magi_lightning_shield_custom", "ogre_magi_multicast_custom", true, true)
	end
end

function modifier_ogre_magi_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local ogre_magi_lightning_shield_custom = self:GetCaster():FindAbilityByName("ogre_magi_lightning_shield_custom")
	if ogre_magi_lightning_shield_custom then
		ogre_magi_lightning_shield_custom:SetLevel(self:GetStackCount())
	end
end