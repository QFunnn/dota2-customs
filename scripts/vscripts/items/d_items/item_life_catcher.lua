--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_life_catcher_passive", "items/d_items/item_life_catcher", LUA_MODIFIER_MOTION_NONE)

item_life_catcher = item_life_catcher or class({})
item_life_catcher2 = item_life_catcher or class({})
item_life_catcher3 = item_life_catcher or class({})
item_life_catcher4 = item_life_catcher or class({})
item_life_catcher5 = item_life_catcher or class({})

function item_life_catcher:Spawn()
	self.required_level = self:GetSpecialValueFor("required_level")
end

function item_life_catcher:OnHeroLevelUp()
	if IsServer() then
		if self:GetCaster():GetLevel() == self.required_level and self:IsInBackpack() == false then
			self:OnUnequip()
			self:OnEquip()
		end
	end
end

function item_life_catcher:IsMuted()
	if self.required_level > self:GetCaster():GetLevel() then
		return true
	end
	return self.BaseClass.IsMuted(self)
end

function item_life_catcher:GetIntrinsicModifierName()
	return "modifier_life_catcher_passive"
end

function item_life_catcher:CreateParticle(sParticleName, hSource, hTarget, bDodgeable)
	local info = {
		Target = hTarget,
		Source = hSource,
		Ability = self,
		EffectName = sParticleName,
		iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
		vSourceLoc = hSource:GetAbsOrigin(),
		bDrawsOnMinimap = false,
		bDodgeable = bDodgeable,
		bIsAttack = false,
		bVisibleToEnemies = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 10,
		bProvidesVision = false,
	}
	ProjectileManager:CreateTrackingProjectile(info)
end

function item_life_catcher:OnSpellStart()
	local target = self:GetCursorTarget()

	if not IsServer() then
		return
	end

	if target:TriggerSpellAbsorb(self) or target:TriggerSpellReflect(self) then
		return
	end

	self:CreateParticle("particles/life_catcher/life_catcher_out.vpcf", self:GetCaster(), target, true)
	EmitSoundOn("Hero_Bane.BrainSap", self:GetParent())
end

function item_life_catcher:OnProjectileHitEnemy(hTarget, value)
	local caster = self:GetCaster()

	ApplyDamage({
		victim = hTarget,
		attacker = caster,
		damage = value,
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	})

	self:CreateParticle("particles/life_catcher/life_catcher_in.vpcf", hTarget, caster, false)
end

function item_life_catcher:OnProjectileHitFriend(hTarget, value)
	hTarget:Heal(value, self)
end

function item_life_catcher:OnProjectileHit(hTarget, vLocation)
	if not self then
		return
	end

	local caster = self:GetCaster()
	local att_damage = caster:GetPrimaryStatValue() * (self:GetSpecialValueFor("mainstat_to_dmg") / 100)

	if hTarget == caster then
		self:OnProjectileHitFriend(hTarget, att_damage)
	else
		self:OnProjectileHitEnemy(hTarget, att_damage + self:GetSpecialValueFor("damage"))
	end
end

---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------

modifier_life_catcher_passive = class({})

function modifier_life_catcher_passive:IsHidden()
	return true
end

function modifier_life_catcher_passive:IsPurgable()
	return false
end

function modifier_life_catcher_passive:DestroyOnExpire()
	return false
end

function modifier_life_catcher_passive:OnCreated(kv)
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self.hp_regen = self:GetAbility():GetSpecialValueFor("bonus_hpregen")
	self.bonus_dmg = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.dmg_to_exp = self:GetAbility():GetSpecialValueFor("damage_to_exp") / 100
	self.min_exp = self:GetAbility():GetSpecialValueFor("min_exp")
	self.exp_cooldown = self:GetAbility():GetSpecialValueFor("exp_cooldown")
	self.melee_hero_mult = self:GetAbility():GetSpecialValueFor("melee_hero_mult")
	self.cooldown_modifier = "modifier_life_catcher_passive_exp_cd"
end

function modifier_life_catcher_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_ATTRIBUTE_NONE,
	}
	return funcs
end

function modifier_life_catcher_passive:GetModifierBonusStats_Strength(params)
	return self.bonus_str
end

function modifier_life_catcher_passive:GetModifierConstantHealthRegen(params)
	return self.hp_regen
end

function modifier_life_catcher_passive:GetModifierPreAttack_BonusDamage(params)
	return self.bonus_dmg
end