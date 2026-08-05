--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


omniknight_purification_lua = class({})

function omniknight_purification_lua:GetAOERadius()
	return self:GetSpecialValueFor("radius")
end

function omniknight_purification_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local heal = self:GetSpecialValueFor("heal")
	local radius = self:GetSpecialValueFor("radius")

	local talent = caster:FindAbilityByName("special_bonus_unique_omniknight_8")

	local repetitions = 0
	if talent and talent:GetLevel() > 0 then
		repetitions = 1
	end

	for i = 0, repetitions do
		Timers:CreateTimer(i * 0.5, function()
			if target and not target:IsNull() and target:IsAlive() then
				target:Heal(heal, self)

				local enemies = FindUnitsInRadius(
					caster:GetTeamNumber(),
					target:GetOrigin(),
					target,
					radius,
					DOTA_UNIT_TARGET_TEAM_ENEMY,
					DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
					0,
					0,
					false
				)

				local damageTable = {
					attacker = caster,
					victim = nil,
					damage = heal,
					damage_type = DAMAGE_TYPE_PURE,
					ability = self,
				}

				for _, enemy in pairs(enemies) do
					damageTable.victim = enemy
					ApplyDamage(damageTable)
					self:PlayEffects2(target, enemy)
				end

				self:PlayEffects1(target, radius)
			end
		end)
	end
end

function omniknight_purification_lua:PlayEffects1(target, radius)
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_purification_cast.vpcf"
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification.vpcf"
	local sound_target = "Hero_Omniknight.Purification"

	local effect_target = ParticleManager:CreateParticle(particle_target, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControl(effect_target, 1, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(effect_target)
	EmitSoundOn(sound_target, target)

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

function omniknight_purification_lua:PlayEffects2(origin, target)
	local particle_target = "particles/units/heroes/hero_omniknight/omniknight_purification_hit.vpcf"
	local effect_target = ParticleManager:CreateParticle(particle_target, PATTACH_ABSORIGIN_FOLLOW, target)
	ParticleManager:SetParticleControlEnt(
		effect_target,
		0,
		origin,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		origin:GetOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		effect_target,
		1,
		target,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		target:GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_target)
end

------------------------------------------------------------------------
------------------------------------------------------------------------

LinkLuaModifier("modifier_omniknight_repel_lua", "heroes/hero_omniknight/hero_omniknight", LUA_MODIFIER_MOTION_NONE)

omniknight_repel_lua = class({})

function omniknight_repel_lua:GetCooldown(level)
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_omniknight_2")
	if talent and talent:GetLevel() > 0 then
		return self.BaseClass.GetCooldown(self, level) - 5
	end
	return self.BaseClass.GetCooldown(self, level)
end

function omniknight_repel_lua:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local buffDuration = self:GetSpecialValueFor("duration")

	target:Purge(false, true, false, true, false)
	target:AddNewModifier(caster, self, "modifier_omniknight_repel_lua", { duration = buffDuration })

	self:PlayEffects()
end

function omniknight_repel_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_repel_cast.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		0,
		self:GetCaster(),
		PATTACH_POINT_FOLLOW,
		"attach_attack2",
		self:GetCaster():GetOrigin(),
		true
	)
	ParticleManager:ReleaseParticleIndex(effect_cast)
end

------------------------------------------------------------------------

modifier_omniknight_repel_lua = class({})

function modifier_omniknight_repel_lua:IsHidden()
	return false
end

function modifier_omniknight_repel_lua:IsDebuff()
	return false
end

function modifier_omniknight_repel_lua:IsPurgable()
	return false
end

function modifier_omniknight_repel_lua:OnCreated(kv)
	if IsServer() then
		self.sound_cast = "Hero_Omniknight.Repel"
		EmitSoundOn(self.sound_cast, self:GetParent())
	end
end

function modifier_omniknight_repel_lua:OnDestroy(kv)
	if IsServer() then
		StopSoundOn(self.sound_cast, self:GetParent())
	end
end

function modifier_omniknight_repel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_EXTRA_STRENGTH_BONUS,
	}
	return funcs
end

function modifier_omniknight_repel_lua:GetModifierExtraStrengthBonus()
	return self:GetParent():GetBaseStrength() * self:GetAbility():GetSpecialValueFor("str") / 100
end

function modifier_omniknight_repel_lua:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_omniknight_repel_lua:CheckState()
	local state = {
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
	}
	return state
end

function modifier_omniknight_repel_lua:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_repel_buff.vpcf"
end

function modifier_omniknight_repel_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------
------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_omniknight_degen_aura_lua",
	"heroes/hero_omniknight/hero_omniknight",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_omniknight_degen_aura_lua_effect",
	"heroes/hero_omniknight/hero_omniknight",
	LUA_MODIFIER_MOTION_NONE
)

omniknight_degen_aura_lua = class({})

function omniknight_degen_aura_lua:GetIntrinsicModifierName()
	return "modifier_omniknight_degen_aura_lua"
end

------------------------------------------------------------------------

modifier_omniknight_degen_aura_lua = class({})

function modifier_omniknight_degen_aura_lua:IsHidden()
	return true
end

function modifier_omniknight_degen_aura_lua:IsDebuff()
	return false
end

function modifier_omniknight_degen_aura_lua:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_lua:IsAura()
	return true
end

function modifier_omniknight_degen_aura_lua:GetModifierAura()
	return "modifier_omniknight_degen_aura_lua_effect"
end

function modifier_omniknight_degen_aura_lua:GetAuraRadius()
	return self.radius
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_omniknight_degen_aura_lua:GetAuraSearchFlags()
	return 0
end

function modifier_omniknight_degen_aura_lua:GetAuraDuration()
	return 0.5
end

function modifier_omniknight_degen_aura_lua:OnCreated(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_omniknight_degen_aura_lua:OnRefresh(kv)
	self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_omniknight_degen_aura_lua:PlayEffects()
	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_degen_aura.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(self.radius, 1, 1))
	self:AddParticle(effect_cast, false, false, -1, false, false)
end

------------------------------------------------------------------------

modifier_omniknight_degen_aura_lua_effect = class({})

function modifier_omniknight_degen_aura_lua_effect:IsHidden()
	return false
end

function modifier_omniknight_degen_aura_lua_effect:IsDebuff()
	return true
end

function modifier_omniknight_degen_aura_lua_effect:IsPurgable()
	return false
end

function modifier_omniknight_degen_aura_lua_effect:OnCreated(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_bonus")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("speed_bonus")
end

function modifier_omniknight_degen_aura_lua_effect:OnRefresh(kv)
	self.as_slow = self:GetAbility():GetSpecialValueFor("attack_bonus")
	self.ms_slow = self:GetAbility():GetSpecialValueFor("speed_bonus")
end

function modifier_omniknight_degen_aura_lua_effect:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
	}

	return funcs
end
function modifier_omniknight_degen_aura_lua_effect:GetModifierMoveSpeedBonus_Percentage()
	return -self.ms_slow
end
function modifier_omniknight_degen_aura_lua_effect:GetModifierAttackSpeedBonus_Constant()
	return -self.as_slow
end

function modifier_omniknight_degen_aura_lua_effect:GetModifierDamageOutgoing_Percentage()
	local talent = self:GetCaster():FindAbilityByName("special_bonus_unique_omniknight_5")
	if talent and talent:GetLevel() > 0 then
		return -5
	end
	return
end

function modifier_omniknight_degen_aura_lua_effect:GetEffectName()
	return "particles/units/heroes/hero_omniknight/omniknight_degen_aura_debuff.vpcf"
end

function modifier_omniknight_degen_aura_lua_effect:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

------------------------------------------------------------------------
------------------------------------------------------------------------

LinkLuaModifier(
	"modifier_omniknight_guardian_angel_lua",
	"heroes/hero_omniknight/hero_omniknight",
	LUA_MODIFIER_MOTION_NONE
)

omniknight_guardian_angel_lua = class({})

function omniknight_guardian_angel_lua:OnSpellStart()
	local caster = self:GetCaster()
	local buffDuration = self:GetSpecialValueFor("duration")
	local radius = self:GetSpecialValueFor("radius")

	local allies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_FRIENDLY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		0,
		0,
		false
	)

	local ability_heal = caster:FindAbilityByName("omniknight_purification_lua")
	local talent = caster:FindAbilityByName("special_bonus_unique_omniknight_7")

	for _, ally in pairs(allies) do
		ally:AddNewModifier(caster, self, "modifier_omniknight_guardian_angel_lua", { duration = buffDuration })

		if talent and talent:GetLevel() > 0 and ability_heal and ability_heal:GetLevel() > 0 then
			caster:SetCursorCastTarget(ally)
			ability_heal:OnSpellStart()
		end
	end

	EmitSoundOn("Hero_Omniknight.GuardianAngel.Cast", caster)
end

------------------------------------------------------------------------

modifier_omniknight_guardian_angel_lua = class({})

function modifier_omniknight_guardian_angel_lua:IsHidden()
	return false
end

function modifier_omniknight_guardian_angel_lua:IsDebuff()
	return false
end

function modifier_omniknight_guardian_angel_lua:IsPurgable()
	return true
end

function modifier_omniknight_guardian_angel_lua:OnCreated(kv)
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_omniknight_guardian_angel_lua:OnRefresh(kv)
	if IsServer() then
		self:PlayEffects()
	end
end

function modifier_omniknight_guardian_angel_lua:OnDestroy(kv) end

function modifier_omniknight_guardian_angel_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
	}
end

function modifier_omniknight_guardian_angel_lua:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_omniknight_guardian_angel_lua:PlayEffects()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local sound_cast = "Hero_Omniknight.GuardianAngel"

	EmitSoundOn(sound_cast, parent)

	local particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_ally.vpcf"
	if parent == caster then
		particle_cast = "particles/units/heroes/hero_omniknight/omniknight_guardian_angel_omni.vpcf"
	end

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:SetParticleControlEnt(
		effect_cast,
		5,
		parent,
		PATTACH_POINT_FOLLOW,
		"attach_hitloc",
		parent:GetOrigin(),
		true
	)

	self:AddParticle(effect_cast, false, false, -1, false, false)
end