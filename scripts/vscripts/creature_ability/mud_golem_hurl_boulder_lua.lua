--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


mud_golem_hurl_boulder_lua = class({})
--------------------------------------------------------------------------------

function mud_golem_hurl_boulder_lua:OnSpellStart()
	local bolt_speed = self:GetSpecialValueFor( "speed" )

	local info = {
			EffectName = "particles/neutral_fx/mud_golem_hurl_boulder.vpcf",
			Ability = self,
			iMoveSpeed = bolt_speed,
			Source = self:GetCaster(),
			Target = self:GetCursorTarget(),
			bDodgeable = true,
			bProvidesVision = true,
			iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
			iVisionRadius = 100,
			iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_2, 
		}

	ProjectileManager:CreateTrackingProjectile( info )
	EmitSoundOn( "n_mud_golem.Boulder.Cast", self:GetCaster() )
end

--------------------------------------------------------------------------------

function mud_golem_hurl_boulder_lua:OnProjectileHit( hTarget, vLocation )

	if not self:IsNull() and  not self:GetCaster():IsNull() and  hTarget ~= nil and ( not hTarget:IsInvulnerable() ) and ( not hTarget:TriggerSpellAbsorb( self ) ) then
		EmitSoundOn( "n_mud_golem.Boulder.Target", hTarget )
		local damage = self:GetSpecialValueFor( "damage" )
		local duration = self:GetSpecialValueFor( "duration" )

		local vDamage = {
			victim = hTarget,
			attacker = self:GetCaster(),
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
		}
		ApplyDamage( vDamage )
		if  self and hTarget and not hTarget:IsNull() then
		  hTarget:AddNewModifier( self:GetCaster(), self, "modifier_stunned", { duration = duration } )
		end
	end 

	return true
end
--------------------------------------------------------------------------------