--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_omniknight_7=class({})

function modifier_omniknight_7:IsHidden() return true end
function modifier_omniknight_7:IsPurgable() return false end
function modifier_omniknight_7:IsPurgeException() return false end
function modifier_omniknight_7:RemoveOnDeath() return false end

function modifier_omniknight_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("omniknight_rain_of_purification")
	if ability then 
		ability:SetLevel(1)
		ability:SetHidden(false)
	end
end

function modifier_omniknight_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end