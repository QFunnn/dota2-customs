--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


item_upgrade_test_stats = class({})

function item_upgrade_test_stats:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local bonus_str = self:GetSpecialValueFor("bonus_str")
	local source_key = caster:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not source_key then
		return
	end
	caster:LevelUpSetCustomStatsBonus(source_key, {
		base = { str = bonus_str },
		bonus = {},
	})
	caster:TakeItem(ability)
end