--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_visage_4=class({})

function modifier_visage_4:IsHidden() return true end
function modifier_visage_4:IsPurgable() return false end
function modifier_visage_4:IsPurgeException() return false end
function modifier_visage_4:RemoveOnDeath() return false end

function modifier_visage_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local visage_soul_assumption_custom = self:GetCaster():FindAbilityByName("visage_soul_assumption_custom")
	if visage_soul_assumption_custom then
		visage_soul_assumption_custom:SetHidden(true)
		visage_soul_assumption_custom:SetActivated(false)
	end
	local modifier_visage_soul_assumption_custom = self:GetCaster():FindModifierByName("modifier_visage_soul_assumption_custom")
	if modifier_visage_soul_assumption_custom then
		modifier_visage_soul_assumption_custom:DisableForTalent4()
	end
end

function modifier_visage_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end