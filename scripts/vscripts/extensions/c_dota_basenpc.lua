--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


function C_DOTA_BaseNPC:HasShard()
	return self:HasModifier("modifier_item_aghanims_shard")
end

function C_DOTA_BaseNPC:IsClone()
	return not self:IsRealHero() and not self:IsIllusion() and self:HasModifier("modifier_meepo_divided_we_stand")
end

function C_DOTA_BaseNPC:IsConsideredRangedAttacker()
	if self:HasModifier("modifier_vengefulspirit_soul_strike") then
		return false
	end
	return self:IsRangedAttacker()
end