--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


earthshaker_echo_slam_custom = class({})

earthshaker_echo_slam_custom.modifier_earthshaker_20 = {-25,-50}
earthshaker_echo_slam_custom.modifier_earthshaker_21_echo = 5
earthshaker_echo_slam_custom.modifier_earthshaker_21_main = 25

function earthshaker_echo_slam_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_proj.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start.vpcf", context )
end

function earthshaker_echo_slam_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_earthshaker_20") then
		bonus = self.modifier_earthshaker_20[self:GetCaster():GetTalentLevel("modifier_earthshaker_20")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function earthshaker_echo_slam_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local damage = self:GetSpecialValueFor("echo_slam_initial_damage")
	local damage_range = self:GetSpecialValueFor("echo_slam_damage_range")
	local init_range = self:GetSpecialValueFor("echo_slam_echo_search_range")
	local echo_range = self:GetSpecialValueFor("echo_slam_echo_range")
	local echo_damage = self:GetSpecialValueFor("echo_slam_echo_damage")

	if self:GetCaster():HasModifier("modifier_earthshaker_21") then
		damage = damage + (self.modifier_earthshaker_21_main / 100 * self:GetCaster():GetMaxMana())
	end

	local effect = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam.vpcf"
	if self:GetCaster():HasModifier("modifier_earthshaker_21") then
		effect = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_proj.vpcf"
	end


	local info = 
	{
		Ability = self,	
		EffectName = effect,
		iMoveSpeed = 600,
		bDodgeable = true,
		bReplaceExisting = false,
	}

	ProjectileManager:CreateTrackingProjectile(info)

	local aftershock = self:GetCaster():FindModifierByName("modifier_earthshaker_aftershock_custom")
	if aftershock then
		aftershock:AfterShockApply(self:GetCaster():GetAbsOrigin())
	end

	local enemies = FindUnitsInRadius( caster:GetTeamNumber(), caster:GetOrigin(), nil, init_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )

	if #enemies<1 then
		self:PlayEffects( 0 )
		return
	end

	local echoes = 0
	for _,enemy in pairs(enemies) do
		if not enemy:IsMagicImmune() then
			ApplyDamage({ victim = enemy, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
		end

		local targets = FindUnitsInRadius( caster:GetTeamNumber(), enemy:GetOrigin(), nil, echo_range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_CLOSEST, false )

		for _,target in pairs(targets) do
			if target~=enemy then
				if echoes < 3 then
					info.Target = target
					info.Source = enemy
					ProjectileManager:CreateTrackingProjectile(info)
					echoes = echoes + 1
				end
				if enemy:IsRealHero() then
					ProjectileManager:CreateTrackingProjectile(info)
					echoes = echoes + 1
				end
			end
		end
	end

	self:PlayEffects( echoes )
end

function earthshaker_echo_slam_custom:OnProjectileHit( target, location )
	local damage = self:GetSpecialValueFor("echo_slam_echo_damage")
	if self:GetCaster():HasModifier("modifier_earthshaker_21") then
		damage = damage + (self.modifier_earthshaker_21_echo / 100 * self:GetCaster():GetMaxMana())
	end
	ApplyDamage({ victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self })
end

function earthshaker_echo_slam_custom:PlayEffects( echoes )
	local sound_cast = "Hero_EarthShaker.EchoSlam"

	if echoes<1 then
		sound_cast = "Hero_EarthShaker.EchoSlamSmall"
	end

	local effect = "particles/units/heroes/hero_earthshaker/earthshaker_echoslam_start.vpcf"
	if self:GetCaster():HasModifier("modifier_earthshaker_21") then
		effect = "particles/econ/items/earthshaker/earthshaker_arcana/earthshaker_arcana_echoslam_start.vpcf"
	end


	local effect_cast = ParticleManager:CreateParticle( effect, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( echoes, 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	self:GetCaster():EmitSound("Hero_EarthShaker.EchoSlamSmall")
end

function earthshaker_echo_slam_custom:GetAbilityTextureName()
	if self:GetCaster():HasModifier("modifier_earthshaker_21") then 
		return "earthshaker_21"
	end
	return "earthshaker_echo_slam"
end