--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_juggernaut_2=class({})

function modifier_juggernaut_2:IsHidden() return true end
function modifier_juggernaut_2:IsPurgable() return false end
function modifier_juggernaut_2:IsPurgeException() return false end
function modifier_juggernaut_2:RemoveOnDeath() return false end

function modifier_juggernaut_2:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("juggernaut_blade_fury_custom", "juggernaut_fire_ward_custom")
	local juggernaut_fire_ward_custom = self:GetParent():FindAbilityByName("juggernaut_fire_ward_custom")
	if juggernaut_fire_ward_custom then
		juggernaut_fire_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local juggernaut_fire_ward_custom = self:GetParent():FindAbilityByName("juggernaut_fire_ward_custom")
	if juggernaut_fire_ward_custom then
		juggernaut_fire_ward_custom:SetLevel(self:GetStackCount())
	end
end

function modifier_juggernaut_2:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(false)
	self:GetParent():SwapAbilities(name1, name2, false, true)
end