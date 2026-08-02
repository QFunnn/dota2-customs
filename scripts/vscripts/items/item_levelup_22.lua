--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


item_levelup_22 = class({})

function item_levelup_22:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	if caster:ChangeStatsStoneActivate({ percent = self:GetSpecialValueFor("percent") }) then
		ConsumeLevelUpItemCharge(caster, ability)
	end
end