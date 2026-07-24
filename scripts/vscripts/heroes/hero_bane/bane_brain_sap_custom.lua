--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


bane_brain_sap_custom = class({})

function bane_brain_sap_custom:GetCooldown( level )
	if self:GetCaster():HasScepter() then
		return 1.5
	end
	return self.BaseClass.GetCooldown( self, level )
end

function bane_brain_sap_custom:GetAOERadius()
	if self:GetCaster():HasShard() then
		return self:GetSpecialValueFor( "shard_radius" )
	end
	return 0
end

function bane_brain_sap_custom:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local damage = self:GetSpecialValueFor("brain_sap_damage")
	local radius = self:GetSpecialValueFor("shard_radius")

	if target:TriggerSpellAbsorb( self ) then
		return
	end

	if self:GetCaster():HasShard() then
		local targets = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
		for _,enemy in pairs(targets) do
			local heal = ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self })
			if enemy ~= target then
				heal = heal * ( self:GetSpecialValueFor("shard_secondary_target_heal_pct") / 100 )
			end
			self:GetCaster():Heal( heal, self )
			self:SuckEffect( enemy )
		end
	else
		local heal = ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PURE, ability = self })
		self:GetCaster():Heal( heal, self )
		self:SuckEffect( target )
	end
end

function bane_brain_sap_custom:SuckEffect( target )
	local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_bane/bane_sap.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
	ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetOrigin(), true )
	ParticleManager:ReleaseParticleIndex( particle )
	self:GetCaster():EmitSound("Hero_Bane.BrainSap")
	target:EmitSound("Hero_Bane.BrainSap.Target")
end