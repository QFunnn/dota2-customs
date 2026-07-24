--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_4=class({})

function modifier_juggernaut_4:IsHidden() return true end
function modifier_juggernaut_4:IsPurgable() return false end
function modifier_juggernaut_4:IsPurgeException() return false end
function modifier_juggernaut_4:RemoveOnDeath() return false end

function modifier_juggernaut_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local juggernaut_blade_dance_custom = self:GetCaster():FindAbilityByName("juggernaut_blade_dance_custom")
	if juggernaut_blade_dance_custom then
		juggernaut_blade_dance_custom:SetLevel(0)
		self:GetCaster():RemoveModifierByName("modifier_juggernaut_blade_dance_custom")
	end
	self:Swap("juggernaut_blade_dance_custom", "juggernaut_wind_ward_custom")
	local juggernaut_wind_ward_custom = self:GetParent():FindAbilityByName("juggernaut_wind_ward_custom")
	if juggernaut_wind_ward_custom then
		juggernaut_wind_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local juggernaut_wind_ward_custom = self:GetParent():FindAbilityByName("juggernaut_wind_ward_custom")
	if juggernaut_wind_ward_custom then
		juggernaut_wind_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_4:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end