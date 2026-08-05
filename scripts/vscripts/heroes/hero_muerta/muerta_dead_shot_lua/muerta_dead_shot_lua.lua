--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


muerta_dead_shot_lua = class({})
LinkLuaModifier(
	"modifier_muerta_dead_shot_lua",
	"heroes/hero_muerta/muerta_dead_shot_lua/muerta_dead_shot_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_muerta_dead_shot_lua_slow",
	"heroes/hero_muerta/muerta_dead_shot_lua/muerta_dead_shot_lua",
	LUA_MODIFIER_MOTION_NONE
)

function muerta_dead_shot_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_muerta/muerta_deadshot_linear_tree.vpcf", context)
	PrecacheResource("particle_folder", "particles/units/heroes/hero_muerta", context)
end

function muerta_dead_shot_lua:OnSpellStart()
	local caster = self:GetCaster()

	local projectile_radius = self:GetSpecialValueFor("radius")
	local projectile_direction = (self:GetCursorPosition() - caster:GetOrigin()):Normalized()
	projectile_direction.z = 0

	ProjectileManager:CreateLinearProjectile({
		Source = caster,
		Ability = self,
		vSpawnOrigin = caster:GetAbsOrigin() + Vector(0, 0, 50),

		iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
		iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
		iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,

		EffectName = "particles/units/heroes/hero_muerta/muerta_deadshot_linear_tree.vpcf",
		fDistance = 800,
		fStartRadius = projectile_radius,
		fEndRadius = projectile_radius,
		vVelocity = projectile_direction * self:GetSpecialValueFor("speed"),
	})
	EmitSoundOn("Hero_Muerta.DeadShot.Cast", caster)
	EmitSoundOn("Hero_Muerta.DeadShot.Layer", caster)
end

function muerta_dead_shot_lua:OnProjectileHitHandle(target, location, handle)
	if not target then
		return
	end
	if not IsServer() then
		return
	end

	ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = self:GetSpecialValueFor("damage")
			+ self:GetCaster():ExtraIntelligenceDamage() * self:GetSpecialValueFor("ExtraIntelligenceDamage"),
		damage_type = self:GetAbilityDamageType(),
		ability = self, --Optional.
	})

	target:AddNewModifier(
		self:GetCaster(),
		self,
		"modifier_muerta_dead_shot_lua_slow",
		{ duration = self:GetSpecialValueFor("duration") }
	)
	EmitSoundOn("Hero_Muerta.DeadShot.Slow", target)
end

-----------------------------------------------------------

modifier_muerta_dead_shot_lua_slow = class({})

function modifier_muerta_dead_shot_lua_slow:IsHidden()
	return false
end

function modifier_muerta_dead_shot_lua_slow:IsDebuff()
	return true
end

function modifier_muerta_dead_shot_lua_slow:IsPurgable()
	return true
end

function modifier_muerta_dead_shot_lua_slow:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
	if not IsServer() then
		return
	end
end

function modifier_muerta_dead_shot_lua_slow:OnRefresh(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow")
end

function modifier_muerta_dead_shot_lua_slow:OnRemoved() end

function modifier_muerta_dead_shot_lua_slow:OnDestroy() end

function modifier_muerta_dead_shot_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_muerta_dead_shot_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_muerta_dead_shot_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_deadshot_debuff_slow.vpcf"
end

function modifier_muerta_dead_shot_lua_slow:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end