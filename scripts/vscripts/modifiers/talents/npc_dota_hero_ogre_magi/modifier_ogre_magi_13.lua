--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_ogre_magi_13=class({})

function modifier_ogre_magi_13:IsHidden() return true end
function modifier_ogre_magi_13:IsPurgable() return false end
function modifier_ogre_magi_13:IsPurgeException() return false end
function modifier_ogre_magi_13:RemoveOnDeath() return false end

function modifier_ogre_magi_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    if self:GetParent():HasModifier("modifier_ogre_magi_17") then return end
    local ogre_magi_bloodlust_custom = self:GetCaster():FindAbilityByName("ogre_magi_bloodlust_custom")
    if ogre_magi_bloodlust_custom then
        self:GetCaster():AddNewModifier(self:GetCaster(), ogre_magi_bloodlust_custom, "modifier_ogre_magi_bloodlust_custom_aura", {})
    end
end

function modifier_ogre_magi_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end