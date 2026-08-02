--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_rune_time = class({})

function modifier_rune_time:IsHidden()
	return true
end
function modifier_rune_time:IsPurgable()
	return false
end
function modifier_rune_time:IsPurgeException()
	return false
end
function modifier_rune_time:RemoveOnDeath()
	return false
end
function modifier_rune_time:OnCreated()
	if IsServer() then
		self:GetParent():CalculateStatBonus(true)
	end
end
function modifier_rune_time:OnRefresh()
	if IsServer() then
		self:GetParent():CalculateStatBonus(true)
	end
end