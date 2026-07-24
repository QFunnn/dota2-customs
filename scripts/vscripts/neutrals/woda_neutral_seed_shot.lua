--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_seed_shot_thinker", "neutrals/woda_neutral_seed_shot", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_neutral_cast", "neutrals/modifier_neutral_cast", LUA_MODIFIER_MOTION_NONE)

woda_neutral_seed_shot = class({})

function woda_neutral_seed_shot:Precache(context)
    PrecacheResource( "particle", "particles/neutral_fx/pine_cone_seed_shot_tracking.vpcf", context )
end

function woda_neutral_seed_shot:OnSpellStart()
	if not IsServer() then return end
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()
	local thinker = CreateModifierThinker( self:GetCaster(), self, "modifier_woda_neutral_seed_shot_thinker", {  }, self:GetCaster():GetOrigin(), self:GetCaster():GetTeamNumber(), false )
	local mod = thinker:FindModifierByName( "modifier_woda_neutral_seed_shot_thinker" )
	
	self:GetCaster():StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_1, 1)
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_neutral_cast", {})
	
	Timers:CreateTimer(0, function()
		if not target then
			target = thinker
			thinker:SetOrigin( point )
		end

		mod.source = self:GetCaster()
		mod.target = target
		self:GetCaster():RemoveModifierByName("modifier_neutral_cast")
	end)
end

function woda_neutral_seed_shot:OnProjectileHit_ExtraData( target, location, ExtraData )
	local caster = self:GetCaster()
	local thinker = EntIndexToHScript( ExtraData.thinker )
	local mod = thinker:FindModifierByName( "modifier_woda_neutral_seed_shot_thinker" )
	
	if not mod then return end
	
	thinker:SetOrigin( location )
	
	mod:Bounce()

	if not target then
		mod:Destroy()
		return
	end

	if target:IsMagicImmune() then return end

	local damage = target:GetHealth() / 100 * self:GetSpecialValueFor("damage")

	ApplyDamage({victim = target, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})

	target:EmitSound("n_creep_warpine.SeedShot.Target")
end

modifier_woda_neutral_seed_shot_thinker = class({})

function modifier_woda_neutral_seed_shot_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.projectile_name = "particles/neutral_fx/pine_cone_seed_shot_tracking.vpcf"
	self.projectile_speed = 1000
	self.bounces = self:GetAbility():GetSpecialValueFor( "max_waves" )+1
	self.range = self:GetAbility():GetSpecialValueFor("radius")
	self.delay = 0.3

	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()

	self.info = {
		Ability = self.ability,	
		EffectName = "particles/neutral_fx/pine_cone_seed_shot_tracking.vpcf",
		iMoveSpeed = self.projectile_speed,
		bDodgeable = true,
		iSourceAttachment = DOTA_PROJECTILE_ATTACHMENT_HITLOCATION,
		bVisibleToEnemies = true,
		bProvidesVision = true,
		iVisionRadius = 400,
		iVisionTeamNumber = self.caster:GetTeamNumber(),
		ExtraData = {
			thinker = self.parent:entindex()
		}
	}

	self:StartIntervalThink( 0 )
end

function modifier_woda_neutral_seed_shot_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_woda_neutral_seed_shot_thinker:OnIntervalThink()
	self.bounces = self.bounces-1
	if self.bounces<0 then
		self:Destroy()
		return
	end
	self:StartIntervalThink(-1)
	local first = 0
	if not self.first then
		self.first = true
		first = 1
	else
		self.source = self.target
		local enemies = FindUnitsInRadius( self.caster:GetTeamNumber(), self.target:GetOrigin(), nil, self.range, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
		if #enemies<1 then
			self:Destroy()
			return
		end
		local next_target
		for _,enemy in pairs(enemies) do
			if enemy~=self.target then
				next_target = enemy
				break
			end
		end
		if not next_target then
			self:Destroy()
			return
		end
		self.target = next_target
	end
	self.info.Source = self.source
	self.info.Target = self.target
	self.info.ExtraData.first = first
    if self.source:IsNull() then return end
    if not self.source:IsAlive() then return end
    if self.target:IsNull() then return end
    if not self.target:IsAlive() then return end
	ProjectileManager:CreateTrackingProjectile( self.info )
	if self.source then
		self.source:EmitSound("n_creep_warpine.SeedShot.Cast")
	end
end

function modifier_woda_neutral_seed_shot_thinker:Bounce()
	self:StartIntervalThink( self.delay )
end