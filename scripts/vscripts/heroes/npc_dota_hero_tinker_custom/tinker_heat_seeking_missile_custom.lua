--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


tinker_heat_seeking_missile_custom = class({})
tinker_heat_seeking_missile_custom.modifier_tinker_16 = 0.5
tinker_heat_seeking_missile_custom.modifier_tinker_16_damage = 100

function tinker_heat_seeking_missile_custom:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_tinker_16") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_tinker_16_damage)
    end
	local targets = self:GetSpecialValueFor("targets")
	local projectile_speed = self:GetSpecialValueFor("speed")
	local enemies = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
	local creeps = FindUnitsInRadius(caster:GetTeamNumber(), caster:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false)
    local info = 
    {
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_tinker/tinker_missile.vpcf",
		iMoveSpeed = projectile_speed,
		bDodgeable = true,
        iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_ATTACK_3,
		ExtraData = 
        {
			damage = damage,
		}
	}

    for _, hero in pairs(enemies) do
        if targets <= 0 then break end
        info.Target = hero
		ProjectileManager:CreateTrackingProjectile( info )
        targets = targets - 1
    end

    if targets > 0 then
        for _, hero in pairs(creeps) do
            if targets <= 0 then break end
            info.Target = hero
            ProjectileManager:CreateTrackingProjectile( info )
            targets = targets - 1
        end
    end

	if #enemies<1 and #creeps<1 then
		local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_missile_dud.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
        ParticleManager:SetParticleControl( particle, 0, self:GetCaster():GetAttachmentOrigin( self:GetCaster():ScriptLookupAttachment( "attach_attack3" ) ) )
        ParticleManager:SetParticleControlForward( particle, 0, self:GetCaster():GetForwardVector() )
        ParticleManager:ReleaseParticleIndex( particle )
        caster:EmitSound("Hero_Tinker.Heat-Seeking_Missile_Dud")
	else
		caster:EmitSound("Hero_Tinker.Heat-Seeking_Missile")
	end
end

function tinker_heat_seeking_missile_custom:OnProjectileHit_ExtraData( target, location, extraData )
	ApplyDamage( { victim = target, attacker = self:GetCaster(), damage = extraData.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self } )
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_tinker/tinker_missle_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( particle )
    target:EmitSound("Hero_Tinker.Heat-Seeking_Missile.Impact")
    if self:GetCaster():HasModifier("modifier_tinker_16") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = self.modifier_tinker_16 * (1-target:GetStatusResistance())})
    end
end