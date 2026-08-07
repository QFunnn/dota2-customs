--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


function ReapersScythe(keys)
	local caster = keys.caster
	local target = keys.target
	local ability = keys.ability
	local target_missing_hp = target:GetMaxHealth() - target:GetHealth()
	local damage_per_health = ability:GetLevelSpecialValueFor("damage_per_health", (ability:GetLevel() - 1))
	local damage_table = {}
	damage_table.attacker = caster
	damage_table.victim = target
	damage_table.ability = ability
	damage_table.damage_type = ability:GetAbilityDamageType()
	damage_table.damage = target_missing_hp * damage_per_health
	ApplyDamage(damage_table)
end