--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_roshan_slam_lua_slow", "abilities/creeps/roshan_slam_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_boss_damage_boost", "abilities/bosses/modifier_boss_damage_boost", LUA_MODIFIER_MOTION_NONE)

roshan_slam_lua = class({})

function roshan_slam_lua:GetIntrinsicModifierName()
	return "modifier_boss_damage_boost"
end

function roshan_slam_lua:OnSpellStart()
	if not IsServer() then
		return
	end

	local caster = self:GetCaster()
	if not caster or caster:IsNull() then
		return
	end

	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("duration")
	local base_damage = self:GetSpecialValueFor("damage")
	local diff_boost = self:GetSpecialValueFor("diff_boost_damage")

	local total_damage = base_damage + diff_boost

	caster:EmitSound("Roshan.GroundPound")
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_ursa/ursa_earthshock.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(particle)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)

	for _, enemy in pairs(enemies) do
		if enemy and not enemy:IsNull() and not enemy:IsMagicImmune() then
			ApplyDamage({
				victim = enemy,
				attacker = caster,
				damage = total_damage,
				damage_type = self:GetAbilityDamageType(),
				ability = self,
			})

			enemy:AddNewModifier(caster, self, "modifier_roshan_slam_lua_slow", { duration = duration })
		end
	end
end

--------------------------------------------------------------------------------

modifier_roshan_slam_lua_slow = class({})

function modifier_roshan_slam_lua_slow:IsHidden()
	return false
end
function modifier_roshan_slam_lua_slow:IsDebuff()
	return true
end
function modifier_roshan_slam_lua_slow:IsPurgable()
	return true
end

function modifier_roshan_slam_lua_slow:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_roshan_slam_lua_slow:GetModifierMoveSpeedBonus_Percentage()
	return -self:GetAbility():GetSpecialValueFor("slow_ms")
end

function modifier_roshan_slam_lua_slow:GetModifierAttackSpeedBonus_Constant()
	return -self:GetAbility():GetSpecialValueFor("slow_as")
end

function modifier_roshan_slam_lua_slow:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_earthshock_modifier.vpcf"
end