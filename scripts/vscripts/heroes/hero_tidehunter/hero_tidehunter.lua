--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_tidehunter_gush_lua", "heroes/hero_tidehunter/hero_tidehunter", LUA_MODIFIER_MOTION_NONE)

tidehunter_gush_lua = class({})

function tidehunter_gush_lua:GetBehavior()
	local ability = self:GetCaster():FindAbilityByName("special_bonus_unique_tidehunter_5")
	if ability ~= nil and ability:GetLevel() > 0 then
		return DOTA_ABILITY_BEHAVIOR_POINT
	end
	return self.BaseClass.GetBehavior(self)
end

function tidehunter_gush_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local point = self:GetCursorPosition()

	local talent = caster:FindAbilityByName("special_bonus_unique_tidehunter_5")
	if talent ~= nil and talent:GetLevel() > 0 then
		if target then
			point = target:GetOrigin()
		end

		local name = "particles/units/heroes/hero_tidehunter/tidehunter_gush_upgrade.vpcf"
		local speed = self:GetSpecialValueFor("talent_speed")
		local radius = self:GetSpecialValueFor("talent_aoe")
		local range = self:GetCastRange(point, target)
		local direction = (point - caster:GetOrigin())
		direction.z = 0
		direction = direction:Normalized()

		local info = {
			Source = caster,
			Ability = self,
			vSpawnOrigin = caster:GetAbsOrigin(),
			bDeleteOnHit = false,
			iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
			iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
			iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			EffectName = name,
			fDistance = range,
			fStartRadius = radius,
			fEndRadius = radius,
			vVelocity = direction * speed,
			ExtraData = { talent = 1 },
		}
		ProjectileManager:CreateLinearProjectile(info)
	else
		local name = "particles/units/heroes/hero_tidehunter/tidehunter_gush.vpcf"
		local speed = self:GetSpecialValueFor("projectile_speed")

		local info = {
			Target = target,
			Source = caster,
			Ability = self,
			EffectName = name,
			iMoveSpeed = speed,
			bDodgeable = true,
			ExtraData = { talent = 0 },
		}
		ProjectileManager:CreateTrackingProjectile(info)
	end

	EmitSoundOn("Ability.GushCast", caster)
end

function tidehunter_gush_lua:OnProjectileHit_ExtraData(target, location, data)
	if not target then
		return
	end
	if data.talent == 0 and target:TriggerSpellAbsorb(self) then
		return
	end

	if data.talent == 1 then
		AddFOWViewer(self:GetCaster():GetTeamNumber(), target:GetOrigin(), 200, 2, true)
	end

	local damage = self:GetSpecialValueFor("gush_damage")
	local duration = self:GetSpecialValueFor("duration")

	target:AddNewModifier(self:GetCaster(), self, "modifier_tidehunter_gush_lua", { duration = duration })

	ApplyDamage({
		victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_MAGICAL,
		ability = self,
	})

	if data.talent == 0 then
		self:PlayEffects(target)
	end

	EmitSoundOn("Ability.GushImpact", target)
	return false
end

function tidehunter_gush_lua:PlayEffects(target)
	local particle_cast = "particles/units/heroes/hero_tidehunter/tidehunter_gush_splash.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		3,
		target,
		PATTACH_ABSORIGIN_FOLLOW,
		"attach_hitloc",
		Vector(0, 0, 0),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

modifier_tidehunter_gush_lua = class({})

function modifier_tidehunter_gush_lua:IsHidden()
	return false
end
function modifier_tidehunter_gush_lua:IsDebuff()
	return true
end
function modifier_tidehunter_gush_lua:IsPurgable()
	return true
end

function modifier_tidehunter_gush_lua:OnCreated(kv)
	self.slow = -self:GetAbility():GetSpecialValueFor("movement_speed")
	self.armor = -self:GetAbility():GetSpecialValueFor("negative_armor")
end

function modifier_tidehunter_gush_lua:OnRefresh(kv)
	self:OnCreated(kv)
end

function modifier_tidehunter_gush_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_tidehunter_gush_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end
function modifier_tidehunter_gush_lua:GetModifierPhysicalArmorBonus()
	return self.armor
end
function modifier_tidehunter_gush_lua:GetEffectName()
	return "particles/units/heroes/hero_tidehunter/tidehunter_gush_slow.vpcf"
end
function modifier_tidehunter_gush_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_tidehunter_kraken_shell_lua",
	"heroes/hero_tidehunter/hero_tidehunter",
	LUA_MODIFIER_MOTION_NONE
)

tidehunter_kraken_shell_lua = class({})

function tidehunter_kraken_shell_lua:GetIntrinsicModifierName()
	return "modifier_tidehunter_kraken_shell_lua"
end

--------------------------------------------------------------------------------

modifier_tidehunter_kraken_shell_lua = class({})

function modifier_tidehunter_kraken_shell_lua:IsHidden()
	return true
end
function modifier_tidehunter_kraken_shell_lua:IsDebuff()
	return false
end
function modifier_tidehunter_kraken_shell_lua:IsPurgable()
	return false
end
function modifier_tidehunter_kraken_shell_lua:AllowIllusionDuplicate()
	return true
end

function modifier_tidehunter_kraken_shell_lua:OnCreated()
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.damage = 0
	self:UpdateValues()
end

function modifier_tidehunter_kraken_shell_lua:OnRefresh()
	self:UpdateValues()
end

function modifier_tidehunter_kraken_shell_lua:UpdateValues()
	if not self.ability or self.ability:IsNull() then
		return
	end
	self.damage_cleanse = self.ability:GetSpecialValueFor("damage_cleanse")
	self.damage_reduction = self.ability:GetSpecialValueFor("damage_reduction")
end

function modifier_tidehunter_kraken_shell_lua:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_TAKEDAMAGE,
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
	}
end

function modifier_tidehunter_kraken_shell_lua:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self.parent or self.parent:PassivesDisabled() then
		return
	end
	if not self.ability or self.ability:IsNull() then
		return
	end

	self.damage = self.damage + params.damage

	if self.damage >= self.damage_cleanse and self.ability:IsFullyCastable() then
		self.damage = 0

		self.parent:Purge(false, true, false, true, true)

		self.ability:UseResources(false, false, false, true)
		self:PlayEffects()
	end
end

function modifier_tidehunter_kraken_shell_lua:GetModifierPhysical_ConstantBlock()
	if self.parent:PassivesDisabled() then
		return 0
	end
	return self.damage_reduction
end

function modifier_tidehunter_kraken_shell_lua:PlayEffects()
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.parent
	)
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOn("Hero_Tidehunter.KrakenShell", self.parent)
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_tidehunter_anchor_smash_lua",
	"heroes/hero_tidehunter/hero_tidehunter",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_tidehunter_anchor_smash_lua_buff",
	"heroes/hero_tidehunter/hero_tidehunter",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_tidehunter_anchor_smash_lua_talent",
	"heroes/hero_tidehunter/hero_tidehunter",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_tidehunter_anchor_smash_lua_cd",
	"heroes/hero_tidehunter/hero_tidehunter",
	LUA_MODIFIER_MOTION_NONE
)

tidehunter_anchor_smash_lua = class({})

function tidehunter_anchor_smash_lua:GetIntrinsicModifierName()
	return "modifier_tidehunter_anchor_smash_lua_talent"
end

function tidehunter_anchor_smash_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local duration = self:GetSpecialValueFor("reduction_duration")
	local bonus_damage = self:GetSpecialValueFor("attack_damage")

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
		0,
		false
	)

	local buff =
		caster:AddNewModifier(caster, self, "modifier_tidehunter_anchor_smash_lua_buff", { bonus = bonus_damage })

	for _, enemy in pairs(enemies) do
		enemy:AddNewModifier(caster, self, "modifier_tidehunter_anchor_smash_lua", { duration = duration })
		caster:PerformAttack(enemy, true, true, true, true, false, false, true)
	end

	if buff then
		buff:Destroy()
	end

	self:PlayEffects()
end

function tidehunter_anchor_smash_lua:PlayEffects()
	local caster = self:GetCaster()
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tidehunter/tidehunter_anchor_hero.vpcf",
		PATTACH_WORLDORIGIN,
		nil
	)
	ParticleManager:SetParticleControl(effect, 0, caster:GetOrigin())
	ParticleManager:ReleaseParticleIndex(effect)
	EmitSoundOn("Hero_Tidehunter.AnchorSmash", caster)
end

--------------------------------------------------------------------------------

modifier_tidehunter_anchor_smash_lua = class({})

function modifier_tidehunter_anchor_smash_lua:IsDebuff()
	return true
end

function modifier_tidehunter_anchor_smash_lua:OnCreated()
	self.reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
end

function modifier_tidehunter_anchor_smash_lua:OnRefresh()
	self:OnCreated()
end

function modifier_tidehunter_anchor_smash_lua:DeclareFunctions()
	return { MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE }
end

function modifier_tidehunter_anchor_smash_lua:GetModifierBaseDamageOutgoing_Percentage()
	return -self.reduction
end

--------------------------------------------------------------------------------

modifier_tidehunter_anchor_smash_lua_buff = class({})

function modifier_tidehunter_anchor_smash_lua_buff:IsHidden()
	return true
end
function modifier_tidehunter_anchor_smash_lua_buff:IsPurgable()
	return false
end

function modifier_tidehunter_anchor_smash_lua_buff:OnCreated(kv)
	if not IsServer() then
		return
	end
	self.bonus = kv.bonus
end

function modifier_tidehunter_anchor_smash_lua_buff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_SUPPRESS_CLEAVE,
	}
end

function modifier_tidehunter_anchor_smash_lua_buff:GetModifierPreAttack_BonusDamage()
	return self.bonus
end
function modifier_tidehunter_anchor_smash_lua_buff:GetSuppressCleave()
	return 1
end

--------------------------------------------------------------------------------

modifier_tidehunter_anchor_smash_lua_talent = class({})

function modifier_tidehunter_anchor_smash_lua_talent:IsHidden()
	return true
end
function modifier_tidehunter_anchor_smash_lua_talent:IsPurgable()
	return false
end

function modifier_tidehunter_anchor_smash_lua_talent:DeclareFunctions()
	return { MODIFIER_EVENT_ON_ATTACK_LANDED }
end

function modifier_tidehunter_anchor_smash_lua_talent:OnAttackLanded(params)
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	local ability = self:GetAbility()

	if params.attacker ~= parent or parent:PassivesDisabled() or parent:IsIllusion() then
		return
	end
	if params.target:GetTeamNumber() == parent:GetTeamNumber() then
		return
	end

	local talent = parent:FindAbilityByName("special_bonus_unique_tidehunter_8")
	if talent and talent:GetLevel() > 0 and not parent:HasModifier("modifier_tidehunter_anchor_smash_lua_cd") then
		if RollPercentage(20) then
			parent:AddNewModifier(parent, ability, "modifier_tidehunter_anchor_smash_lua_cd", { duration = 0.15 })
			ability:OnSpellStart()
		end
	end
end

--------------------------------------------------------------------------------

modifier_tidehunter_anchor_smash_lua_cd = class({})
function modifier_tidehunter_anchor_smash_lua_cd:IsHidden()
	return true
end
function modifier_tidehunter_anchor_smash_lua_cd:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

LinkLuaModifier("modifier_generic_arc_lua", "heroes/generic/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_generic_ring_lua", "heroes/generic/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

tidehunter_ravage_lua = class({})

function tidehunter_ravage_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_tidehunter_6")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 30
	end
	return self.BaseClass.GetCooldown(self, level)
end

function tidehunter_ravage_lua:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("radius")
	local speed = self:GetSpecialValueFor("speed")
	local duration = self:GetSpecialValueFor("duration")

	local damageTable = {
		attacker = caster,
		damage = self:GetAbilityDamage(),
		damage_type = self:GetAbilityDamageType(),
		ability = self,
	}

	local thinker = CreateModifierThinker(caster, self, "modifier_generic_ring_lua", {
		start_radius = 250,
		end_radius = radius,
		speed = speed,
		width = 250,
		target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
		target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
	}, caster:GetOrigin(), caster:GetTeamNumber(), false)

	local ring = thinker:FindModifierByName("modifier_generic_ring_lua")
	if ring then
		ring:SetCallback(function(enemy)
			local knockback =
				enemy:AddNewModifier(caster, self, "modifier_generic_arc_lua", { duration = 0.5, height = 350 })

			if knockback then
				knockback:SetEndCallback(function()
					damageTable.victim = enemy
					ApplyDamage(damageTable)
					EmitSoundOn("Hero_Tidehunter.RavageDamage", enemy)
				end)
			end

			enemy:AddNewModifier(caster, self, "modifier_stunned", { duration = duration })
			self:PlayEffectsHit(enemy)
		end)
	end

	self:PlayEffectsCast(caster:GetOrigin(), radius)
end

function tidehunter_ravage_lua:PlayEffectsCast(center, radius)
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage.vpcf",
		PATTACH_WORLDORIGIN,
		self:GetCaster()
	)
	ParticleManager:SetParticleControl(effect, 0, center)
	for i = 1, 5 do
		ParticleManager:SetParticleControl(effect, i, Vector(radius / 5 * i, 1, 1))
	end
	ParticleManager:ReleaseParticleIndex(effect)

	local sound_cast = "Ability.Ravage"
	-- EmitSoundOnLocationWithCaster( center, sound_cast, self:GetCaster() )
	EmitSoundOn(sound_cast, self:GetCaster())
end

function tidehunter_ravage_lua:PlayEffectsHit(enemy)
	local effect = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_tidehunter/tidehunter_spell_ravage_hit.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		enemy
	)
	ParticleManager:ReleaseParticleIndex(effect)
end