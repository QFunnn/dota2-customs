--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_omniknight_5=class({})

function modifier_omniknight_5:IsHidden() return true end
function modifier_omniknight_5:IsPurgable() return false end
function modifier_omniknight_5:IsPurgeException() return false end
function modifier_omniknight_5:RemoveOnDeath() return false end

function modifier_omniknight_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local ability = self:GetParent():FindAbilityByName("omniknight_martyr_custom")
	if ability then 
		self:GetParent():RemoveModifierByName("modifier_omniknight_martyr_custom")
		self:GetParent():AddNewModifier(self:GetParent(), ability, "modifier_omniknight_martyr_custom", {})
	end
end

function modifier_omniknight_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end