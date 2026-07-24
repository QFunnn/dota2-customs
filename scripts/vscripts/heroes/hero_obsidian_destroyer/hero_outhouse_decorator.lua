--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


--[[ 	Author: Hewdraw
		Date: 17.05.2015	]]

function RestoreMana( keys )
	local caster = keys.caster
	local target = keys.unit
	local ability = keys.ability

    if not ability or ability:IsNull() then 
        return 
    end

	local ability_level = ability:GetLevel() - 1
	local cast_ability = keys.event_ability
	local essence_particle = keys.essence_particle
	local essence_sound = keys.essence_sound
    
	-- Parameters
	local restore_amount = ability:GetLevelSpecialValueFor("restore_amount", ability_level)
	local mana_restore = target:GetMaxMana() * restore_amount / 100

	-- If the ability just cast uses mana, restore mana accordingly
	if cast_ability and cast_ability:GetManaCost( cast_ability:GetLevel() - 1 ) > 0 then
		-- Restores mana
		target:GiveMana(mana_restore)
		-- Plays sound and effect
		local essence_fx = ParticleManager:CreateParticle(essence_particle, PATTACH_ABSORIGIN_FOLLOW, target)
		target:EmitSound("essence_sound")
	end

	if cast_ability and cast_ability:GetAbilityName()=="obsidian_destroyer_arcane_orb" then
		-- Restores mana
		target:GiveMana(mana_restore)
		-- Plays sound and effect
		local essence_fx = ParticleManager:CreateParticle(essence_particle, PATTACH_ABSORIGIN_FOLLOW, target)
		target:EmitSound("essence_sound")
	end
end

