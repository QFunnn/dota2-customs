--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_drow_ranger_12=class({})

function modifier_drow_ranger_12:IsHidden() return true end
function modifier_drow_ranger_12:IsPurgable() return false end
function modifier_drow_ranger_12:IsPurgeException() return false end
function modifier_drow_ranger_12:RemoveOnDeath() return false end

function modifier_drow_ranger_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self:Swap("drow_ranger_multishot_custom","drow_ranger_multishot_2_custom")
end

function modifier_drow_ranger_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end


function modifier_drow_ranger_12:Swap(name1, name2)
if not IsServer() then return end

local ability1 = self:GetParent():FindAbilityByName(name1)
local ability2 = self:GetParent():FindAbilityByName(name2)

ability1:SetHidden(true)
ability2:SetHidden(false)
ability2:SetLevel(ability1:GetLevel())


self:GetParent():SwapAbilities(name1, name2, false, true)

end