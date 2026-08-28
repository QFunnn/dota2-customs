--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


--[[
	Author: kritth
	Date: 09.01.2015
	Reset cooldown after attack is landed
]]
function tidebringer_set_cooldown(keys)
	-- Variables
	local caster = keys.caster
	local ability = keys.ability
	local cooldown = ability:GetCooldown(ability:GetLevel())
	local modifierName = "modifier_tidebringer_splash_datadriven"

	-- Remove cooldown
	caster:RemoveModifierByName(modifierName)
	ability:StartCooldown(cooldown)
	Timers:CreateTimer(cooldown, function()
		ability:ApplyDataDrivenModifier(caster, caster, modifierName, {})
		return nil
	end)
end