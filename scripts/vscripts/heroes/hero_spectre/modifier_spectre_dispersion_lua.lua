--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require( "util" )

modifier_spectre_dispersion_lua = class({})

function modifier_spectre_dispersion_lua:TakeDamageScriptModifier(event)

	if event.unit == self:GetParent() then
		local caster = self:GetParent()
		local post_damage = event.damage
		local original_damage = event.original_damage
		local ability = self:GetAbility()
		local damage_reflect_pct = ( ability:GetLevelSpecialValueFor( "damage_reflection_pct", ability:GetLevel()-1 ) ) * 0.01

		--Ignore damage
		if caster:IsAlive() then
			caster:SetHealth(caster:GetHealth() + (post_damage * damage_reflect_pct) )
		end

		local max_radius = ability:GetSpecialValueFor("max_radius")
		local min_radius = ability:GetSpecialValueFor("min_radius")

		units = FindUnitsInRadius(
						caster:GetTeamNumber(),
                        caster:GetAbsOrigin(),
                        nil,
                        max_radius,
                        DOTA_UNIT_TARGET_TEAM_ENEMY,
                        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                        DOTA_UNIT_TARGET_FLAG_NONE,
                        FIND_ANY_ORDER,
                        false
        )
		
		for _,unit in pairs(units) do

			if unit:GetTeam() ~= caster:GetTeam() then

				local vCaster = caster:GetAbsOrigin()
				local vUnit = unit:GetAbsOrigin()

				local reflect_damage = 0.0
				--local particle_name = ""
                
                reflect_damage = original_damage * damage_reflect_pct
                    
				local distance = (vUnit - vCaster):Length2D()
				
                --取消掉全部的效果粒子特效
				--Within 300 radius		
								
				if distance <= min_radius then
					reflect_damage = original_damage * damage_reflect_pct
					--particle_name = "particles/units/heroes/hero_spectre/spectre_dispersion.vpcf"
				--Between 301 and 475 radius
				elseif distance <= (min_radius+175) then
					reflect_damage = original_damage * ( damage_reflect_pct * (1- (distance-300) * 0.00142857 ) )
					--particle_name = "particles/units/heroes/hero_spectre/spectre_dispersion_fallback_mid.vpcf"
				--Same formula as previous statement but different particle
				else
					reflect_damage = original_damage * ( damage_reflect_pct * (1- (distance-300) * 0.00142857 ) )				
					--particle_name = "particles/units/heroes/hero_spectre/spectre_dispersion_b_fallback_low.vpcf"
				end

                if caster.pure_return~=nil then
                	reflect_damage=reflect_damage*(1+caster.pure_return*caster:GetStrength()/100)
                end
                
                --particle_name = "particles/units/heroes/hero_spectre/spectre_dispersion.vpcf"
				--Create particle
				--[[
				local particle = ParticleManager:CreateParticle( particle_name, PATTACH_POINT_FOLLOW, caster )
				ParticleManager:SetParticleControl(particle, 0, vCaster)
				ParticleManager:SetParticleControl(particle, 1, vUnit)
				ParticleManager:SetParticleControl(particle, 2, vCaster)
				]]
				

                if caster.pure_return~=nil then
                	reflect_damage=reflect_damage*(1+caster.pure_return*caster:GetStrength()/100)
                end
			end

		end

	end

end

function modifier_spectre_dispersion_lua:IsHidden()
	return true
end

function modifier_spectre_dispersion_lua:RemoveOnDeath()
	return false
end

function modifier_spectre_dispersion_lua:IsPurgable()
	return false
end