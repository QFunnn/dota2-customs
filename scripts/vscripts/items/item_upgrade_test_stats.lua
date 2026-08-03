--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
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