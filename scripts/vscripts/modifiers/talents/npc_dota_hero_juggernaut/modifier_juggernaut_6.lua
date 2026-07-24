--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_6=class({})

function modifier_juggernaut_6:IsHidden() return true end
function modifier_juggernaut_6:IsPurgable() return false end
function modifier_juggernaut_6:IsPurgeException() return false end
function modifier_juggernaut_6:RemoveOnDeath() return false end

function modifier_juggernaut_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("juggernaut_omni_slash_custom", "juggernaut_ice_ward_custom")
	local juggernaut_ice_ward_custom = self:GetParent():FindAbilityByName("juggernaut_ice_ward_custom")
	if juggernaut_ice_ward_custom then
		juggernaut_ice_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local juggernaut_ice_ward_custom = self:GetParent():FindAbilityByName("juggernaut_ice_ward_custom")
	if juggernaut_ice_ward_custom then
		juggernaut_ice_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_6:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end