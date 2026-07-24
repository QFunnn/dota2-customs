--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


skywrath_mage_arcane_bolt_custom = class({})

function skywrath_mage_arcane_bolt_custom:GetAOERadius()
	return self:GetSpecialValueFor("radius_skill")
end

function skywrath_mage_arcane_bolt_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local projectile_speed = self:GetSpecialValueFor( "bolt_speed" )
	local projectile_vision = self:GetSpecialValueFor( "bolt_vision" )
	local base_damage = self:GetSpecialValueFor( "bolt_damage" )
	local multiplier = self:GetSpecialValueFor( "int_multiplier" )
	local damage = base_damage
	damage = damage + (self:GetCaster():GetIntellect(false) * multiplier)

	local cursor_target = self:GetCursorTarget()
	if cursor_target:TriggerSpellAbsorb(self) then return end

	if new_target then
		cursor_target = new_target
	end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), cursor_target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius_skill"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _, target in pairs(enemies) do
		local info = 
		{
			Target = target,
			Source = caster,
			Ability = self,	
			EffectName = "particles/units/heroes/hero_skywrath_mage/skywrath_mage_arcane_bolt.vpcf",
			iMoveSpeed = projectile_speed,
			bDodgeable = false,
			bVisibleToEnemies = true,
			bProvidesVision = true,
			iVisionRadius = projectile_vision,
			iVisionTeamNumber = caster:GetTeamNumber(),
			ExtraData = 
			{
				damage = damage,
			}
		}

		ProjectileManager:CreateTrackingProjectile(info)
	end

    if new_target ~= nil then return end

    local new_targets = 0
    if self:GetCaster():HasScepter() then
        new_targets = new_targets + 2
    end
    if self:GetCaster():HasTalent("special_bonus_unique_skywrath_2") then
        new_targets = new_targets + 1
    end
    local scepter_radius = self:GetSpecialValueFor( "scepter_radius" )
    if self:GetCaster():HasScepter() then
        print("lol")
		local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, 700, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
        print(#enemies)
		for _, enemy in pairs(enemies) do
			if enemy ~= cursor_target then
				self:OnSpellStart(enemy)
				new_targets = new_targets - 1
			end
			if new_targets <= 0 then
				break
			end
		end
	end

	caster:EmitSound("Hero_SkywrathMage.ArcaneBolt.Cast")
end

function skywrath_mage_arcane_bolt_custom:OnProjectileHit_ExtraData( target, location, extraData )
	if not target then return end	

	local damageTable = 
	{
		victim = target,
		attacker = self:GetCaster(),
		damage = extraData.damage,
		damage_type = self:GetAbilityDamageType(),
		ability = self
	}

	ApplyDamage(damageTable)

	target:AddNewModifier(self:GetCaster(), self, "modifier_skywrath_mage_arcane_bolt_lifesteal", {duration = self:GetSpecialValueFor("lifesteal_duration")})

	local vision = self:GetSpecialValueFor( "bolt_vision" )
	local duration = self:GetSpecialValueFor( "vision_duration" )

	AddFOWViewer( self:GetCaster():GetTeamNumber(), target:GetOrigin(), vision, duration, false )

	target:EmitSound("Hero_SkywrathMage.ArcaneBolt.Impact")
	self:GetCaster():StopSound("Hero_SkywrathMage.ArcaneBolt.Cast")
end