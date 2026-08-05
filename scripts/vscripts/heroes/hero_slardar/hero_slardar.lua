--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


---------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Slardar's Slithereen Crush ------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

lua_slardar_slithereen_crush = class({})
LinkLuaModifier("modifier_lua_slithereen_crush_stun", "heroes/hero_slardar/hero_slardar", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lua_slithereen_crush_slow", "heroes/hero_slardar/hero_slardar", LUA_MODIFIER_MOTION_NONE)

function lua_slardar_slithereen_crush:OnAbilityPhaseStart()
	local caster = self:GetCaster()
	local particle_start = "particles/units/heroes/hero_slardar/slardar_crush_start.vpcf"
	local particle_start_fx = ParticleManager:CreateParticle(particle_start, PATTACH_ABSORIGIN, caster)
	ParticleManager:SetParticleControl(particle_start_fx, 0, caster:GetAbsOrigin())
	return true
end

function lua_slardar_slithereen_crush:OnSpellStart()
	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor("AbilityCastRange")
	local stun_duration = self:GetSpecialValueFor("stun_duration")
	local slow_duration = self:GetSpecialValueFor("slow_duration")
	local damage = self:GetSpecialValueFor("damage")

	EmitSoundOn("Hero_Slardar.Slithereen_Crush", caster)

	local particle_splash_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_crush.vpcf",
		PATTACH_ABSORIGIN,
		caster
	)
	ParticleManager:SetParticleControl(particle_splash_fx, 0, caster:GetAbsOrigin())
	ParticleManager:SetParticleControl(particle_splash_fx, 1, Vector(1, 1, radius + 100))

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		caster:GetAbsOrigin(),
		caster,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)
	for _, enemy in pairs(enemies) do
		if not enemy:IsMagicImmune() then
			local particle_hit_fx = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_slardar/slardar_crush_entity.vpcf",
				PATTACH_ABSORIGIN,
				enemy
			)
			ParticleManager:SetParticleControl(particle_hit_fx, 0, enemy:GetAbsOrigin())

			-- Damage nearby enemies
			local damageTable = {
				victim = enemy,
				attacker = caster,
				damage = damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self,
			}

			ApplyDamage(damageTable)
			enemy:AddNewModifier(
				caster,
				self,
				"modifier_lua_slithereen_crush_stun",
				{ duration = stun_duration * (1 - enemy:GetStatusResistance()) }
			)
			enemy:AddNewModifier(
				caster,
				self,
				"modifier_lua_slithereen_crush_slow",
				{ duration = (stun_duration + slow_duration) * (1 - enemy:GetStatusResistance()) }
			)
		end
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_slithereen_crush_stun = class({})

function modifier_lua_slithereen_crush_stun:IsDebuff()
	return true
end

function modifier_lua_slithereen_crush_stun:IsHidden()
	return false
end

function modifier_lua_slithereen_crush_stun:IsPurgeException()
	return true
end

function modifier_lua_slithereen_crush_stun:IsStunDebuff()
	return true
end

function modifier_lua_slithereen_crush_stun:CheckState()
	local state = { [MODIFIER_STATE_STUNNED] = true }
	return state
end

function modifier_lua_slithereen_crush_stun:DeclareFunctions()
	return { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
end

function modifier_lua_slithereen_crush_stun:GetOverrideAnimation()
	return ACT_DOTA_DISABLED
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_slithereen_crush_slow = class({})

function modifier_lua_slithereen_crush_slow:IsDebuff()
	return true
end

function modifier_lua_slithereen_crush_slow:IsHidden()
	return false
end

function modifier_lua_slithereen_crush_slow:IsPurgable()
	return true
end

function modifier_lua_slithereen_crush_slow:DeclareFunctions()
	local decFuncs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }

	return decFuncs
end

function modifier_lua_slithereen_crush_slow:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("ms_slow_pct")
end

function modifier_lua_slithereen_crush_slow:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("as_slow")
end

function modifier_lua_slithereen_crush_slow:GetStatusEffectName()
	return "particles/status_fx/status_effect_slardar_crush.vpcf"
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- lua_slardar_guardian_sprint -----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

lua_slardar_guardian_sprint = class({})

LinkLuaModifier("modifier_lua_guardian_sprint_buff", "heroes/hero_slardar/hero_slardar", LUA_MODIFIER_MOTION_NONE)

function lua_slardar_guardian_sprint:OnSpellStart()
	local caster = self:GetCaster()
	EmitSoundOn("Hero_Slardar.Sprint", caster)
	local duration = self:GetSpecialValueFor("duration")
	local sprint = caster:AddNewModifier(caster, self, "modifier_lua_guardian_sprint_buff", { duration = duration })
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_guardian_sprint_buff = class({})

function modifier_lua_guardian_sprint_buff:IsHidden()
	return false
end
function modifier_lua_guardian_sprint_buff:IsDebuff()
	return false
end

function modifier_lua_guardian_sprint_buff:GetTexture()
	return "slardar_sprint"
end

function modifier_lua_guardian_sprint_buff:CheckState()
	local state = { [MODIFIER_STATE_NO_UNIT_COLLISION] = true }
	return state
end

function modifier_lua_guardian_sprint_buff:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return decFuncs
end

function modifier_lua_guardian_sprint_buff:GetActivityTranslationModifiers()
	return "sprint"
end

function modifier_lua_guardian_sprint_buff:GetModifierMoveSpeedBonus_Percentage()
	return self:GetAbility():GetSpecialValueFor("ms_bonus_pct")
end

function modifier_lua_guardian_sprint_buff:GetModifierAttackSpeedBonus_Constant()
	return self:GetAbility():GetSpecialValueFor("as_bonus")
end

function modifier_lua_guardian_sprint_buff:GetEffectName()
	return "particles/units/heroes/hero_slardar/slardar_sprint.vpcf"
end

function modifier_lua_guardian_sprint_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Slardar's Bash of the Deep -----------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

lua_slardar_bash_of_the_deep = class({})

LinkLuaModifier("modifier_lua_bash_of_the_deep_attack", "heroes/hero_slardar/hero_slardar", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lua_bash_of_the_deep_disarm", "heroes/hero_slardar/hero_slardar", LUA_MODIFIER_MOTION_NONE)

function lua_slardar_bash_of_the_deep:GetAbilityTextureName()
	return "slardar_bash"
end

function lua_slardar_bash_of_the_deep:GetIntrinsicModifierName()
	if not self:GetCaster():IsIllusion() then
		return "modifier_lua_bash_of_the_deep_attack"
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_bash_of_the_deep_attack = class({})

function modifier_lua_bash_of_the_deep_attack:IsHidden()
	return true
end

function modifier_lua_bash_of_the_deep_attack:IsDebuff()
	return false
end

function modifier_lua_bash_of_the_deep_attack:IsPurgable()
	return false
end

function modifier_lua_bash_of_the_deep_attack:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL,
	}
	return decFuncs
end

function modifier_lua_bash_of_the_deep_attack:GetModifierProcAttack_BonusDamage_Physical(keys)
	if IsServer() then
		local caster = self:GetCaster()
		local attacker = keys.attacker
		local target = keys.target

		local chance_pct = self:GetAbility():GetSpecialValueFor("chance_pct")
		local damage = self:GetAbility():GetSpecialValueFor("damage")
		local duration = self:GetAbility():GetSpecialValueFor("duration")

		if caster == attacker then
			if caster:PassivesDisabled() then
				return nil
			end

			if RandomInt(1, 100) <= chance_pct then
				EmitSoundOn("Hero_Slardar.Bash", target)
				target:AddNewModifier(
					caster,
					self:GetAbility(),
					"modifier_lua_bash_of_the_deep_disarm",
					{ duration = duration * (1 - target:GetStatusResistance()) }
				)
				return damage
			end
		end
		return 0
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_bash_of_the_deep_disarm = class({})

function modifier_lua_bash_of_the_deep_disarm:IsDebuff()
	return true
end

function modifier_lua_bash_of_the_deep_disarm:IsHidden()
	return false
end

function modifier_lua_bash_of_the_deep_disarm:IsPurgeException()
	return true
end

function modifier_lua_bash_of_the_deep_disarm:IsStunDebuff()
	return true
end

function modifier_lua_bash_of_the_deep_disarm:DeclareFunctions()
	local decFuncs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
	return decFuncs
end

function modifier_lua_bash_of_the_deep_disarm:GetModifierPhysicalArmorBonus(keys)
	return -self:GetAbility():GetSpecialValueFor("disarm")
end

---------------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------- Slardar's Corrosive Haze --------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------

lua_slardar_corrosive_haze = class({})
LinkLuaModifier(
	"modifier_lua_corrosive_haze_debuff",
	"heroes/hero_slardar/hero_slardar",
	LUA_MODIFIER_MOTION_HORIZONTAL
)

function lua_slardar_corrosive_haze:GetAbilityTextureName()
	return "slardar_amplify_damage"
end

function lua_slardar_corrosive_haze:OnSpellStart()
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local duration = self:GetSpecialValueFor("duration")

	if target:GetTeam() ~= caster:GetTeam() then
		if target:TriggerSpellAbsorb(self) then
			return nil
		end
	end

	EmitSoundOn("Hero_Slardar.Amplify_Damage", caster)

	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_unique_slardar_7")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		local enemies = FindUnitsInRadius(
			caster:GetTeamNumber(),
			target:GetAbsOrigin(),
			target,
			250,
			DOTA_UNIT_TARGET_TEAM_ENEMY,
			DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
			DOTA_UNIT_TARGET_FLAG_NONE,
			FIND_ANY_ORDER,
			false
		)
		for _, enemy in pairs(enemies) do
			enemy:AddNewModifier(
				caster,
				self,
				"modifier_lua_corrosive_haze_debuff",
				{ duration = duration * (1 - enemy:GetStatusResistance()) }
			)
		end
	else
		target:AddNewModifier(
			caster,
			self,
			"modifier_lua_corrosive_haze_debuff",
			{ duration = duration * (1 - target:GetStatusResistance()) }
		)
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------------------

modifier_lua_corrosive_haze_debuff = class({})

function modifier_lua_corrosive_haze_debuff:IsHidden()
	return false
end

function modifier_lua_corrosive_haze_debuff:IsDebuff()
	return true
end

function modifier_lua_corrosive_haze_debuff:OnCreated()
	if not IsServer() then
		return
	end

	self.particle_haze_fx = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slardar/slardar_amp_damage.vpcf",
		PATTACH_OVERHEAD_FOLLOW,
		self:GetParent()
	)
	ParticleManager:SetParticleControlEnt(
		self.particle_haze_fx,
		1,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		self.particle_haze_fx,
		2,
		self:GetParent(),
		PATTACH_OVERHEAD_FOLLOW,
		"attach_hitloc",
		self:GetParent():GetAbsOrigin(),
		true
	)
	self:AddParticle(self.particle_haze_fx, false, false, -1, false, true)
end

function modifier_lua_corrosive_haze_debuff:CheckState()
	return {
		[MODIFIER_STATE_PROVIDES_VISION] = true,
		[MODIFIER_STATE_INVISIBLE] = false,
	}
end

function modifier_lua_corrosive_haze_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_lua_corrosive_haze_debuff:GetModifierPhysicalArmorBonus()
	return -self:GetAbility():GetSpecialValueFor("armor_reduction")
end

function modifier_lua_corrosive_haze_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_slardar_amp_damage.vpcf"
end