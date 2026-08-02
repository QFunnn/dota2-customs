--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
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