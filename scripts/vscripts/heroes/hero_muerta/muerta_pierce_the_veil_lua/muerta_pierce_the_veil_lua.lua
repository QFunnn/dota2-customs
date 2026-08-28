--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


muerta_pierce_the_veil_lua = class({})
LinkLuaModifier(
	"modifier_muerta_pierce_the_veil_lua",
	"heroes/hero_muerta/muerta_pierce_the_veil_lua/muerta_pierce_the_veil_lua",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_muerta_pierce_the_veil_lua_undisarm",
	"heroes/hero_muerta/muerta_pierce_the_veil_lua/muerta_pierce_the_veil_lua",
	LUA_MODIFIER_MOTION_NONE
)

function muerta_pierce_the_veil_lua:GetCastAnimation()
	return ACT_DOTA_CAST_ABILITY_4
end

function muerta_pierce_the_veil_lua:OnSpellStart()
	local caster = self:GetCaster()
	local duration = self:GetSpecialValueFor("duration")
	local transform_duration = self:GetSpecialValueFor("transform_duration")

	caster:Purge(false, true, false, false, false)
	ProjectileManager:ProjectileDodge(caster)

	caster:AddNewModifier(
		caster,
		self,
		"modifier_muerta_pierce_the_veil_lua",
		{ duration = duration + transform_duration }
	)

	EmitSoundOn("Hero_Muerta.PierceTheVeil.Cast", caster)
end

---------------------------------------------------------------------------------------------------

modifier_muerta_pierce_the_veil_lua = class({})

local disarm_modifier_whitelist = {
	["modifier_item_ethereal_blade_ethereal"] = true,
	["modifier_ghost_state"] = true,
}
local disarm_modifier_blacklist = {
	["modifier_heavens_halberd_debuff"] = true,
}

function modifier_muerta_pierce_the_veil_lua:IsHidden()
	return false
end

function modifier_muerta_pierce_the_veil_lua:IsDebuff()
	return false
end

function modifier_muerta_pierce_the_veil_lua:IsPurgable()
	return false
end

function modifier_muerta_pierce_the_veil_lua:OnCreated(kv)
	self.parent = self:GetParent()
	self.ability = self:GetAbility()
	self.modelscale = self:GetAbility():GetSpecialValueFor("modelscale")
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
	self.transform_duration = self:GetAbility():GetSpecialValueFor("transform_duration")
	self.self_magical_resist_reduction = self:GetAbility():GetSpecialValueFor("self_magical_resist_reduction")

	self.transforming = true
	self:StartIntervalThink(self.transform_duration)

	if not IsServer() then
		return
	end

	self.undisarm_modifier = nil
	self:PlayEffectsStart()
end

function modifier_muerta_pierce_the_veil_lua:OnRefresh(kv) end

function modifier_muerta_pierce_the_veil_lua:OnRemoved() end

function modifier_muerta_pierce_the_veil_lua:OnDestroy()
	if not IsServer() then
		return
	end

	if self.undisarm_modifier then
		self.undisarm_modifier:Destroy()
		self.undisarm_modifier = nil
	end

	self:PlayEffectsEnd()
end

function modifier_muerta_pierce_the_veil_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_TRANSLATE_ATTACK_SOUND,

		MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_OVERRIDE_ATTACK_MAGICAL,

		--	MODIFIER_PROPERTY_ALWAYS_ALLOW_ATTACK,
		MODIFIER_EVENT_ON_ATTACK_FINISHED,
		MODIFIER_EVENT_ON_ATTACK_CANCELLED,

		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DECREPIFY_UNIQUE,

		MODIFIER_EVENT_ON_TAKEDAMAGE,
		-- -- not working
		-- MODIFIER_PROPERTY_ALWAYS_ETHEREAL_ATTACK,
		-- MODIFIER_PROPERTY_PROCATTACK_CONVERT_PHYSICAL_TO_MAGICAL,
		-- MODIFIER_PROPERTY_PHYSICALDAMAGEOUTGOING_PERCENTAGE,
	}
	return funcs
end

function modifier_muerta_pierce_the_veil_lua:GetModifierMagicalResistanceDecrepifyUnique()
	return -self.self_magical_resist_reduction
end

function modifier_muerta_pierce_the_veil_lua:GetModifierModelChange()
	return "models/heroes/muerta/muerta_ult.vmdl"
end

function modifier_muerta_pierce_the_veil_lua:GetModifierModelScale()
	return self.modelscale
end

function modifier_muerta_pierce_the_veil_lua:GetModifierProjectileName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_projectile.vpcf"
end

function modifier_muerta_pierce_the_veil_lua:GetAttackSound()
	return "Hero_Muerta.PierceTheVeil.Attack"
end

function modifier_muerta_pierce_the_veil_lua:GetModifierPreAttack_BonusDamage()
	return self.bonus_damage
end

function modifier_muerta_pierce_the_veil_lua:GetOverrideAttackMagical(params)
	return 1
end

function modifier_muerta_pierce_the_veil_lua:GetModifierTotalDamageOutgoing_Percentage(params)
	if params.inflictor then
		return 0
	end
	if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
		return 0
	end
	if params.damage_type ~= DAMAGE_TYPE_PHYSICAL then
		return 0
	end
	if not params.target:IsMagicImmune() then
		self.damage = 0
		self.damage = params.original_damage
	else
		EmitSoundOn("Hero_Muerta.PierceTheVeil.ProjectileImpact.MagicImmune", params.target)
	end
	return -200
end

function modifier_muerta_pierce_the_veil_lua:OnTakeDamage(params)
	if IsServer() then
		if params.attacker ~= self:GetParent() then
			return
		end
		if self:GetParent():GetTeamNumber() == params.unit:GetTeamNumber() then
			return
		end

		if params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
			if params.damage_flags == DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION then
				return
			end
			ApplyDamage({
				victim = params.unit,
				attacker = params.attacker,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				damage_flags = DOTA_DAMAGE_FLAG_REFLECTION
					+ DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
					+ DOTA_DAMAGE_FLAG_DONT_DISPLAY_DAMAGE_IF_SOURCE_HIDDEN,
			})
			EmitSoundOn("Hero_Muerta.PierceTheVeil.ProjectileImpact", params.unit)
		end
	end
	return 0
end

function modifier_muerta_pierce_the_veil_lua:GetAlwaysAllowAttack(params)
	local should_disarm = false
	for modifier, _ in pairs(disarm_modifier_blacklist) do
		if self.parent:HasModifier(modifier) then
			should_disarm = true
			break
		end
	end
	if should_disarm then
		return 0
	end

	self.undisarm_modifier = self.parent:AddNewModifier(
		self.parent,
		self.ability,
		"modifier_muerta_pierce_the_veil_lua_undisarm",
		{ duration = 1 }
	)
	return 1
end

function modifier_muerta_pierce_the_veil_lua:OnAttackFinished(params)
	if params.attacker ~= self.parent then
		return
	end
	if self.undisarm_modifier then
		self.undisarm_modifier:Destroy()
		self.undisarm_modifier = nil
	end
end

function modifier_muerta_pierce_the_veil_lua:OnAttackCancelled(params)
	self:OnAttackFinished(params)
end

function modifier_muerta_pierce_the_veil_lua:CheckState()
	local state = {
		[MODIFIER_STATE_STUNNED] = self.transforming,
		[MODIFIER_STATE_CANNOT_TARGET_BUILDINGS] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
	return state
end

function modifier_muerta_pierce_the_veil_lua:OnIntervalThink()
	self.transforming = false
end

function modifier_muerta_pierce_the_veil_lua:GetEffectName()
	return "particles/units/heroes/hero_muerta/muerta_ultimate_form_ethereal.vpcf"
end

function modifier_muerta_pierce_the_veil_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_muerta_pierce_the_veil_lua:PlayEffectsStart()
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_ultimate_form_screen_effect.vpcf"
	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:SetParticleControl(effect_cast, 1, Vector(1, 0, 0))

	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end

function modifier_muerta_pierce_the_veil_lua:PlayEffectsEnd()
	local particle_cast = "particles/units/heroes/hero_muerta/muerta_ultimate_form_finish.vpcf"
	local sound_cast = "Hero_Muerta.PierceTheVeil.End"

	local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self.parent)
	ParticleManager:ReleaseParticleIndex(effect_cast)

	EmitSoundOn(sound_cast, target)
end

-------------------------------------------

modifier_muerta_pierce_the_veil_lua_undisarm = class({})

function modifier_muerta_pierce_the_veil_lua_undisarm:IsHidden()
	return true
end

function modifier_muerta_pierce_the_veil_lua_undisarm:IsDebuff()
	return false
end

function modifier_muerta_pierce_the_veil_lua_undisarm:IsPurgable()
	return false
end

function modifier_muerta_pierce_the_veil_lua_undisarm:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnCreated(kv)
	if not IsServer() then
		return
	end
end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnRefresh(kv) end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnRemoved() end

function modifier_muerta_pierce_the_veil_lua_undisarm:OnDestroy() end

function modifier_muerta_pierce_the_veil_lua_undisarm:CheckState()
	local state = {
		[MODIFIER_STATE_DISARMED] = false,
	}

	return state
end