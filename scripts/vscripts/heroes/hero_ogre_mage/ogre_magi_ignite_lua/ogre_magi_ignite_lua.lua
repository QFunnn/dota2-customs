--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_ogre_magi_ignite_lua",
	"heroes/hero_ogre_mage/ogre_magi_ignite_lua/ogre_magi_ignite_lua",
	LUA_MODIFIER_MOTION_NONE
)

ogre_magi_ignite_lua = class({})

function ogre_magi_ignite_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local projectile_name = "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite.vpcf"
	local projectile_speed = self:GetSpecialValueFor("projectile_speed")

	local info = {
		Target = target,
		Source = caster,
		Ability = self,

		EffectName = projectile_name,
		iMoveSpeed = projectile_speed,
		bDodgeable = true, -- Optional
	}
	ProjectileManager:CreateTrackingProjectile(info)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(), -- int, your team number
		caster:GetOrigin(), -- point, center point
		caster, -- handle, cacheUnit. (not known)
		self:GetCastRange(target:GetOrigin(), target), -- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY, -- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
		DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, -- int, flag filter
		0, -- int, order filter
		false -- bool, can grow cache
	)

	local target_2 = nil
	for _, enemy in pairs(enemies) do
		if enemy ~= target and (not enemy:HasModifier("modifier_ogre_magi_ignite_lua")) then
			target_2 = enemy
			break
		end
	end

	if target_2 then
		info.Target = target_2
		ProjectileManager:CreateTrackingProjectile(info)
	end

	local sound_cast = "Hero_OgreMagi.Ignite.Cast"
	EmitSoundOn(sound_cast, caster)
end

function ogre_magi_ignite_lua:OnProjectileHit(target, location)
	if not target then
		return
	end
	if target:TriggerSpellAbsorb(self) then
		return
	end
	local duration = self:GetSpecialValueFor("duration")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_8")
	if ability ~= nil and ability:GetLevel() > 0 then
		duration = duration + 3
	end

	target:AddNewModifier(
		self:GetCaster(), -- player source
		self, -- ability source
		"modifier_ogre_magi_ignite_lua", -- modifier name
		{ duration = duration } -- kv
	)
	local sound_cast = "Hero_OgreMagi.Ignite.Target"
	EmitSoundOn(sound_cast, self:GetCaster())
end

-----------------------------------------------------------------------------------

modifier_ogre_magi_ignite_lua = class({})

function modifier_ogre_magi_ignite_lua:IsHidden()
	return false
end

function modifier_ogre_magi_ignite_lua:IsDebuff()
	return true
end

function modifier_ogre_magi_ignite_lua:IsStunDebuff()
	return false
end

function modifier_ogre_magi_ignite_lua:IsPurgable()
	return true
end

function modifier_ogre_magi_ignite_lua:OnCreated(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed_pct")
	local damage = self:GetAbility():GetSpecialValueFor("burn_damage")
	if not IsServer() then
		return
	end
	local interval = 1

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_2")
	if ability ~= nil and ability:GetLevel() > 0 then
		damage = damage + 20
	end

	self.damageTable = {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		ability = self, --Optional.
	}
	self:StartIntervalThink(interval)
end

function modifier_ogre_magi_ignite_lua:OnRefresh(kv)
	self.slow = self:GetAbility():GetSpecialValueFor("slow_movement_speed_pct")
	local damage = self:GetAbility():GetSpecialValueFor("burn_damage")

	local ability = self:GetCaster():FindAbilityByName("special_bonus_ogre_magi_2")
	if ability ~= nil and ability:GetLevel() > 0 then
		damage = damage + 20
	end

	if not IsServer() then
		return
	end
	self.damageTable.damage = damage
end

function modifier_ogre_magi_ignite_lua:OnRemoved() end

function modifier_ogre_magi_ignite_lua:OnDestroy() end

function modifier_ogre_magi_ignite_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
	return funcs
end

function modifier_ogre_magi_ignite_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_ogre_magi_ignite_lua:OnIntervalThink()
	ApplyDamage(self.damageTable)
	local sound_cast = "Hero_OgreMagi.Ignite.Damage"
	EmitSoundOn(sound_cast, self:GetParent())
end

function modifier_ogre_magi_ignite_lua:GetEffectName()
	return "particles/units/heroes/hero_ogre_magi/ogre_magi_ignite_debuff.vpcf"
end

function modifier_ogre_magi_ignite_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end