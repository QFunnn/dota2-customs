--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_lina_fiery_soul_lua",
	"heroes/hero_lina/lina_fiery_soul_lua/lina_fiery_soul_lua",
	LUA_MODIFIER_MOTION_NONE
)

lina_fiery_soul_lua = class({})

function lina_fiery_soul_lua:Precache(context)
	PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf", context)
	PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context)
end

function lina_fiery_soul_lua:GetIntrinsicModifierName()
	return "modifier_lina_fiery_soul_lua"
end

---------------------------------------------

modifier_lina_fiery_soul_lua = class({})

function modifier_lina_fiery_soul_lua:IsHidden()
	return self:GetStackCount() == 0
end

function modifier_lina_fiery_soul_lua:IsDebuff()
	return false
end

function modifier_lina_fiery_soul_lua:IsPurgable()
	return false
end

function modifier_lina_fiery_soul_lua:DestroyOnExpire()
	return false
end

function modifier_lina_fiery_soul_lua:OnCreated(kv)
	self.max_stacks = self:GetAbility():GetSpecialValueFor("fiery_soul_max_stacks")
	self.duration = self:GetAbility():GetSpecialValueFor("fiery_soul_stack_duration")
	if not IsServer() then
		return
	end
	self:PlayEffects()
end

function modifier_lina_fiery_soul_lua:OnRefresh(kv)
	self.max_stacks = self:GetAbility():GetSpecialValueFor("fiery_soul_max_stacks")
	self.duration = self:GetAbility():GetSpecialValueFor("fiery_soul_stack_duration")
end

function modifier_lina_fiery_soul_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_ABILITY_EXECUTED,
	}
	return funcs
end

function modifier_lina_fiery_soul_lua:GetModifierMoveSpeedBonus_Percentage(params)
	self.ms_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_move_speed_bonus")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_4")
	if talent and talent:GetLevel() > 0 then
		self.ms_bonus = self.ms_bonus + 2
	end
	return self:GetStackCount() * self.ms_bonus
end

function modifier_lina_fiery_soul_lua:GetModifierAttackSpeedBonus_Constant(params)
	self.as_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_attack_speed_bonus")
	local talent = self:GetCaster():FindAbilityByName("special_bonus_lina_4")
	if talent and talent:GetLevel() > 0 then
		self.as_bonus = self.as_bonus + 20
	end
	return self:GetStackCount() * self.as_bonus
end

function modifier_lina_fiery_soul_lua:OnAbilityExecuted(params)
	if not IsServer() then
		return
	end
	if params.unit ~= self:GetParent() then
		return
	end
	if self:GetParent():PassivesDisabled() then
		return
	end
	if not params.ability then
		return
	end
	if params.ability:IsItem() or params.ability:IsToggle() then
		return
	end

	if self:GetStackCount() < self.max_stacks then
		self:IncrementStackCount()
	end

	self:SetDuration(self.duration, true)
	self:StartIntervalThink(self.duration)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self:GetStackCount(), 0, 0))
end

function modifier_lina_fiery_soul_lua:OnIntervalThink()
	self:StartIntervalThink(-1)
	self:SetStackCount(0)
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self:GetStackCount(), 0, 0))
end

function modifier_lina_fiery_soul_lua:PlayEffects()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf"

	-- Create Particle
	self.effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(self.effect_cast, 1, Vector(self:GetStackCount(), 0, 0))

	-- buff particle
	self:AddParticle(
		self.effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)
end