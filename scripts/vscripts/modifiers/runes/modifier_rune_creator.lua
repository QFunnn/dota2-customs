--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_creator = class({})

function modifier_rune_creator:IsHidden()
	return true
end
function modifier_rune_creator:IsPurgable()
	return false
end
function modifier_rune_creator:IsPurgeException()
	return false
end
function modifier_rune_creator:RemoveOnDeath()
	return false
end
function modifier_rune_creator:OnCreated()
	if IsServer() then
		self:GetParent():CalculateStatBonus(true)
	end
end
function modifier_rune_creator:OnRefresh()
	if IsServer() then
		self:GetParent():CalculateStatBonus(true)
	end
end