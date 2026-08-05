--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_slark_shadow_dance_custom",
	"heroes/hero_slark/slark_shadow_dance_custom/slark_shadow_dance_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_shadow_dance_custom_passive",
	"heroes/hero_slark/slark_shadow_dance_custom/slark_shadow_dance_custom",
	LUA_MODIFIER_MOTION_NONE
)
LinkLuaModifier(
	"modifier_slark_shadow_dance_custom_attack",
	"heroes/hero_slark/slark_shadow_dance_custom/slark_shadow_dance_custom",
	LUA_MODIFIER_MOTION_NONE
)

slark_shadow_dance_custom = class({})

function slark_shadow_dance_custom:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_slark_shadow_dance.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_regen.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_shard_depth_shroud.vpcf", context)
	PrecacheResource("particle", "particles/status_fx/status_effect_slark_shadow_dance.vpcf", context)
	PrecacheResource("particle", "particles/units/heroes/hero_slark/slark_pounce_leash.vpcf", context)
end

function slark_shadow_dance_custom:OnSpellStart()
	if not IsServer() then
		return
	end
	local duration = self:GetSpecialValueFor("duration")
	self:GetCaster()
		:AddNewModifier(self:GetCaster(), self, "modifier_slark_shadow_dance_custom", { duration = duration })
end

function slark_shadow_dance_custom:GetIntrinsicModifierName()
	return "modifier_slark_shadow_dance_custom_passive"
end

modifier_slark_shadow_dance_custom = class({})

function modifier_slark_shadow_dance_custom:IsHidden()
	return false
end

function modifier_slark_shadow_dance_custom:IsPurgable()
	return false
end

function modifier_slark_shadow_dance_custom:IsPurgeException()
	return false
end

function modifier_slark_shadow_dance_custom:GetPriority()
	return MODIFIER_PRIORITY_HIGH
end

function modifier_slark_shadow_dance_custom:OnCreated(kv)
	if not IsServer() then
		return
	end
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_slark_shadow_dance", {})
	self:GetParent():EmitSound("Hero_Slark.ShadowDance")
	self.thinker = CreateModifierThinker(
		self:GetCaster(),
		self:GetAbility(),
		"modifier_kill",
		{},
		self:GetParent():GetAbsOrigin(),
		self:GetParent():GetTeamNumber(),
		false
	)
	local particle = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slark/slark_shadow_dance_dummy.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self.thinker
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		0,
		self.thinker,
		PATTACH_POINT_FOLLOW,
		nil,
		self.thinker:GetAbsOrigin(),
		true
	)
	ParticleManager:SetParticleControlEnt(
		particle,
		1,
		self.thinker,
		PATTACH_POINT_FOLLOW,
		nil,
		self.thinker:GetAbsOrigin(),
		true
	)
	self:AddParticle(particle, false, false, -1, false, false)
	self:StartIntervalThink(FrameTime())
end

function modifier_slark_shadow_dance_custom:OnIntervalThink(kv)
	if not IsServer() then
		return
	end
	self:GetParent():RemoveModifierByName("modifier_gem_active_truesight")
	self:GetParent():RemoveModifierByName("modifier_truesight")
	self:GetParent():RemoveModifierByName("modifier_item_dustofappearance")
	if self.thinker then
		self.thinker:SetAbsOrigin(self:GetParent():GetAbsOrigin())
	end
end

function modifier_slark_shadow_dance_custom:OnDestroy(kv)
	if not IsServer() then
		return
	end
	self:GetParent():RemoveModifierByName("modifier_slark_shadow_dance")
	UTIL_Remove(self.thinker)
	self:GetParent():StopSound("Hero_Slark.ShadowDance")
end

function modifier_slark_shadow_dance_custom:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_INVISIBILITY_LEVEL,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
		MODIFIER_PROPERTY_ALWAYS_AUTOATTACK_WHILE_HOLD_POSITION,
		MODIFIER_PROPERTY_INVISIBILITY_ATTACK_BEHAVIOR_EXCEPTION,
	}
	return funcs
end

function modifier_slark_shadow_dance_custom:GetModifierInvisibilityAttackBehaviorException()
	return 1
end

function modifier_slark_shadow_dance_custom:GetModifierPersistentInvisibility()
	return 1
end

function modifier_slark_shadow_dance_custom:GetAlwaysAutoAttackWhileHoldPosition()
	return 1
end

function modifier_slark_shadow_dance_custom:GetActivityTranslationModifiers()
	return "shadow_dance"
end

function modifier_slark_shadow_dance_custom:GetModifierInvisibilityLevel()
	return 1
end

function modifier_slark_shadow_dance_custom:CheckState()
	local state = {
		[MODIFIER_STATE_INVISIBLE] = true,
		[MODIFIER_STATE_TRUESIGHT_IMMUNE] = true,
	}

	return state
end

function modifier_slark_shadow_dance_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_slark_shadow_dance.vpcf"
end

function modifier_slark_shadow_dance_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

modifier_slark_shadow_dance_custom_passive = class({})

function modifier_slark_shadow_dance_custom_passive:IsHidden()
	return self:GetStackCount() == 1
end

function modifier_slark_shadow_dance_custom_passive:IsDebuff()
	return false
end

function modifier_slark_shadow_dance_custom_passive:IsPurgable()
	return false
end

function modifier_slark_shadow_dance_custom_passive:OnCreated(kv)
	self.interval = self:GetAbility():GetSpecialValueFor("activation_delay")
	self.bonus_regen = self:GetAbility():GetSpecialValueFor("bonus_regen")
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
	if not IsServer() then
		return
	end
	self:StartIntervalThink(self.interval)
	self:OnIntervalThink()
end

function modifier_slark_shadow_dance_custom_passive:OnRefresh(kv)
	self.bonus_regen = self:GetAbility():GetSpecialValueFor("bonus_regen")
	self.bonus_movespeed = self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end

function modifier_slark_shadow_dance_custom_passive:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_EVENT_ON_TAKEDAMAGE,
	}
	return funcs
end

function modifier_slark_shadow_dance_custom_passive:OnTakeDamage(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if params.attacker == self:GetParent() then
		return
	end
	if params.attacker == nil then
		return
	end
	if params.attacker:IsHero() then
		return
	end
	self:GetParent()
		:AddNewModifier(self:GetParent(), nil, "modifier_slark_shadow_dance_custom_attack", { duration = 2 })
end

function modifier_slark_shadow_dance_custom_passive:GetModifierConstantHealthRegen()
	return self.bonus_regen * (1 - self:GetStackCount())
end

function modifier_slark_shadow_dance_custom_passive:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_movespeed * (1 - self:GetStackCount())
end

function modifier_slark_shadow_dance_custom_passive:OnIntervalThink()
	local active = true
	local targets = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),
		self:GetParent():GetAbsOrigin(),
		nil,
		1800,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO,
		0,
		DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
			+ DOTA_UNIT_TARGET_FLAG_INVULNERABLE
			+ DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
		false
	)
	for _, enemy in pairs(targets) do
		if enemy:CanEntityBeSeenByMyTeam(self:GetParent()) then
			active = false
		end
	end
	if self:GetParent():HasModifier("modifier_slark_shadow_dance_custom_attack") then
		active = false
	end
	if self:GetParent():HasModifier("modifier_slark_shadow_dance_custom") then
		active = true
	end
	if not active then
		self:SetStackCount(1)
	else
		self:SetStackCount(0)
	end
end

function modifier_slark_shadow_dance_custom_passive:OnStackCountChanged(prev)
	if not IsServer() then
		return
	end
	if prev == self:GetStackCount() then
		return
	end
	if self:GetStackCount() == 0 then
		self:PlayEffects()
	elseif self:GetStackCount() == 1 then
		self:StopEffects()
	end
end

function modifier_slark_shadow_dance_custom_passive:PlayEffects()
	local effect_cast = ParticleManager:CreateParticle(
		"particles/units/heroes/hero_slark/slark_regen.vpcf",
		PATTACH_ABSORIGIN_FOLLOW,
		self:GetParent()
	)
	self.effect_cast = effect_cast
end

function modifier_slark_shadow_dance_custom_passive:StopEffects()
	if not self.effect_cast then
		return
	end
	ParticleManager:DestroyParticle(self.effect_cast, false)
	ParticleManager:ReleaseParticleIndex(self.effect_cast)
	self.effect_cast = nil
end

modifier_slark_shadow_dance_custom_attack = class({})
function modifier_slark_shadow_dance_custom_attack:IsHidden()
	return true
end
function modifier_slark_shadow_dance_custom_attack:IsPurgable()
	return false
end