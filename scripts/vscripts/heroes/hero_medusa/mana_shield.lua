--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


function ManaShield( event )
	local caster = event.caster
	local ability = event.ability
	local damage_per_mana = ability:GetLevelSpecialValueFor("damage_per_mana", ability:GetLevel() - 1 )
	local absorption_percent = ability:GetLevelSpecialValueFor("absorption_tooltip", ability:GetLevel() - 1 ) * 0.01
	local damage = event.Damage * absorption_percent
	local not_reduced_damage = event.Damage - damage

	local caster_mana = caster:GetMana()
	local mana_needed = damage / damage_per_mana

	-- Check if the not reduced damage kills the caster
	local oldHealth = caster.OldHealth - not_reduced_damage

	-- If it doesnt then do the HP calculation
	if oldHealth >= 1 then
		print("Damage taken "..damage.." | Mana needed: "..mana_needed.." | Current Mana: "..caster_mana)

		-- If the caster has enough mana, fully heal for the damage done
		if mana_needed <= caster_mana then
			caster:SpendMana(mana_needed, ability)
			caster:SetHealth(oldHealth)
			
			-- Impact particle based on damage absorbed
			local particleName = "particles/units/heroes/hero_medusa/medusa_mana_shield_impact.vpcf"
			local particle = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN_FOLLOW, caster)
			ParticleManager:SetParticleControl(particle, 0, caster:GetAbsOrigin())
			ParticleManager:SetParticleControl(particle, 1, Vector(mana_needed,0,0))
		else
			local newHealth = oldHealth - damage
			caster:SpendMana(mana_needed, ability)
			caster:SetHealth(newHealth)
		end
	end	
end

-- Keeps track of the targets health
function ManaShieldHealth( event )
	local caster = event.caster
	caster.OldHealth = caster:GetHealth()
end