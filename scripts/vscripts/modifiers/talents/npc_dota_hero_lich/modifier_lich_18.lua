--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_lich_18=class({})

function modifier_lich_18:IsHidden() return true end
function modifier_lich_18:IsPurgable() return false end
function modifier_lich_18:IsPurgeException() return false end
function modifier_lich_18:RemoveOnDeath() return false end

function modifier_lich_18:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("lich_sinister_gaze_custom", "lich_frost_nova_line_custom")
end

function modifier_lich_18:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lich_18:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	ability2:SetLevel(1)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end