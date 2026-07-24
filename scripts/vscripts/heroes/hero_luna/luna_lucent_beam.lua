--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_luna_lucent_beam_custom", "heroes/hero_luna/luna_lucent_beam", LUA_MODIFIER_MOTION_NONE )

luna_lucent_beam_custom = class({})

function luna_lucent_beam_custom:GetIntrinsicModifierName()
	return "modifier_luna_lucent_beam_custom"
end

function luna_lucent_beam_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function luna_lucent_beam_custom:OnAbilityPhaseStart()
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam_precast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( particle, 1, Vector(0.4,0,0) )
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( particle )
	return true
end

function luna_lucent_beam_custom:OnSpellStart()
	if not IsServer() then return end
	
	local target = self:GetCursorTarget()
	if target:TriggerSpellAbsorb( self ) then return end
	local duration = self:GetSpecialValueFor("stun_duration")
	local damage = self:GetSpecialValueFor("beam_damage")
	
	local radius = self:GetSpecialValueFor("radius")
	
	local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_CLOSEST, false )
	
	self:GetCaster():EmitSound("Hero_Luna.LucentBeam.Cast")

	for _, unit in pairs(units) do
		ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self, damage_flags = DOTA_DAMAGE_FLAG_NONE })
		unit:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = duration})
		local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
		ParticleManager:SetParticleControl( particle, 0, unit:GetOrigin() )
		ParticleManager:SetParticleControlEnt( particle, 1, unit, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:SetParticleControlEnt( particle, 5, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
		ParticleManager:SetParticleControlEnt( particle, 6, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
		ParticleManager:ReleaseParticleIndex( particle )
		unit:EmitSound("Hero_Luna.LucentBeam.Target")

		if self:GetCaster():HasShard() then
			self:GetCaster():PerformAttack(unit, true, true, true, false, self:GetCaster():IsRangedAttacker(), false, false)
		end
	end
end

modifier_luna_lucent_beam_custom = class({
	IsHidden                = function(self) return true end,
    IsPurgable              = function(self) return false end,
    IsPurgeException        = function(self) return false end,
    IsDebuff                = function(self) return false end,

	GetModifierProcAttack_Feedback			= function(self, event)
		if not self.ability or self.ability:IsNull() or self.Chance == 0 then return end
	
		if event.no_attack_cooldown then return end

		if RollPseudoRandomPercentage(self.Chance, DOTA_PSEUDO_RANDOM_CUSTOM_GAME_1, self:GetParent()) then
			self.ability:GetCaster():SetCursorCastTarget(event.target)
			self.ability:OnSpellStart()
		end
	end,

	DeclareFunctions 		= function(self)
		return {
			MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
		}
	end,

	OnCreated				= function(self)
		local ability = self:GetAbility()
		if ability then
			self.Chance = ability:GetSpecialValueFor("attack_chance")
			self.ability = ability
		end
	end,

	OnRefresh				= function(self)
		self:OnCreated()
	end,
})