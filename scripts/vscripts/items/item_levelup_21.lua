--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_levelup_21 = class({})

function item_levelup_21:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	hero_card_system:KillChallengeUnit(caster:GetPlayerOwnerID())
	ConsumeLevelUpItemCharge(caster, ability)
end