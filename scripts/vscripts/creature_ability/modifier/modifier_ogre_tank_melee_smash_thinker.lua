--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_ogre_tank_melee_smash_thinker = class({})

function modifier_ogre_tank_melee_smash_thinker:OnCreated( kv )
	if IsServer() then
        self.ability = self:GetAbility()
        self.caster = self:GetCaster()
        self.parent = self:GetParent()
		self.impact_radius = self.ability:GetSpecialValueFor( "impact_radius" )
		self.stun_duration = self.ability:GetSpecialValueFor( "stun_duration" )
		self.damage = self.ability:GetSpecialValueFor( "damage" )
		self:StartIntervalThink( 0.01 )
	end
end

function modifier_ogre_tank_melee_smash_thinker:OnIntervalThink()
	if IsServer() then
		if self.caster == nil or self.caster:IsNull() or self.caster:IsAlive() == false or self.caster:IsStunned() then
			self.bInvalid = true
			UTIL_Remove( self.parent )
			return -1
		end
	end
end

function modifier_ogre_tank_melee_smash_thinker:OnDestroy()
	if IsServer() then
		if self.caster ~= nil and self.caster:IsAlive() and true~=self.bInvalid then
			self.caster:EmitSound("OgreTank.GroundSmash")
			local nFXIndex = ParticleManager:CreateParticle( "particles/test_particle/ogre_melee_smash.vpcf", PATTACH_WORLDORIGIN,  self.caster  )
			ParticleManager:SetParticleControl( nFXIndex, 0, self.parent:GetOrigin() )
			ParticleManager:SetParticleControl( nFXIndex, 1, Vector( self.impact_radius, self.impact_radius, self.impact_radius ) )
			ParticleManager:ReleaseParticleIndex( nFXIndex )

			local enemies = FindUnitsInRadius( self.parent:GetTeamNumber(), self.parent:GetOrigin(), self.parent, self.impact_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
			for _,enemy in pairs( enemies ) do
				if enemy ~= nil and enemy:IsInvulnerable() == false then
					local damageInfo =
					{
						victim = enemy,
						attacker = self.caster,
						damage = self.damage,
						damage_type = DAMAGE_TYPE_PHYSICAL,
						ability = self.ability,
					}
					ApplyDamage( damageInfo )
					if enemy:IsAlive() == false then
						local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", PATTACH_CUSTOMORIGIN, nil )
						ParticleManager:SetParticleControlEnt( nFXIndex, 0, enemy, PATTACH_POINT_FOLLOW, "attach_hitloc", enemy:GetOrigin(), true )
						ParticleManager:SetParticleControl( nFXIndex, 1, enemy:GetOrigin() )
						ParticleManager:SetParticleControlForward( nFXIndex, 1, -self.caster:GetForwardVector() )
						ParticleManager:SetParticleControlEnt( nFXIndex, 10, enemy, PATTACH_ABSORIGIN_FOLLOW, nil, enemy:GetOrigin(), true )
						ParticleManager:ReleaseParticleIndex( nFXIndex )
						enemy:EmitSound("Dungeon.BloodSplatterImpact")
					else
						enemy:AddNewModifier( self.caster, self.ability, "modifier_stunned", { duration = self.stun_duration * (1-enemy:GetStatusResistance()) } )
					end
				end
			end
		end
		UTIL_Remove( self.parent )
	end
end