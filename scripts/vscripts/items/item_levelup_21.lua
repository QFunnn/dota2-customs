--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


item_levelup_21 = class({})

function item_levelup_21:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	hero_card_system:KillChallengeUnit(caster:GetPlayerOwnerID())
	ConsumeLevelUpItemCharge(caster, ability)
end