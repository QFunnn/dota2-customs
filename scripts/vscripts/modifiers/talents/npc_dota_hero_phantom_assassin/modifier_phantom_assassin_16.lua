--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phantom_assassin_16=class({})

function modifier_phantom_assassin_16:IsHidden() return true end
function modifier_phantom_assassin_16:IsPurgable() return false end
function modifier_phantom_assassin_16:IsPurgeException() return false end
function modifier_phantom_assassin_16:RemoveOnDeath() return false end

function modifier_phantom_assassin_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local phantom_assassin_fan_of_knives_custom = self:GetParent():FindAbilityByName("phantom_assassin_fan_of_knives_custom")
	if phantom_assassin_fan_of_knives_custom then
		phantom_assassin_fan_of_knives_custom:SetLevel(self:GetStackCount())
		phantom_assassin_fan_of_knives_custom:SetHidden(false)
	end
end

function modifier_phantom_assassin_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local phantom_assassin_fan_of_knives_custom = self:GetParent():FindAbilityByName("phantom_assassin_fan_of_knives_custom")
	if phantom_assassin_fan_of_knives_custom then
		phantom_assassin_fan_of_knives_custom:SetLevel(self:GetStackCount())
		phantom_assassin_fan_of_knives_custom:SetHidden(false)
	end
end