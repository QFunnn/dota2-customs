--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 19:52:08 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_1", "items/item_levelup_1", LUA_MODIFIER_MOTION_NONE)

item_levelup_1 = class({})

function item_levelup_1:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local modifier_item_levelup_1 = caster:FindModifierByName("modifier_item_levelup_1")
	if modifier_item_levelup_1 then
		duration = modifier_item_levelup_1:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_1", { duration = duration })
	if services and services.OnLevelUpFlaskUsed then
		services:OnLevelUpFlaskUsed(caster, ability)
	end
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_1 = class({})
function modifier_item_levelup_1:IsPurgable()
	return false
end
function modifier_item_levelup_1:IsPurgeException()
	return false
end

function modifier_item_levelup_1:OnCreated(params)
	self.bonus_health = self:GetAbility():GetSpecialValueFor("bonus_health")
	self.bonus_health_regen = self:GetAbility():GetSpecialValueFor("bonus_health_regen")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
	self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not IsServer() then
		return
	end
	self.source_key = self.caster:LevelUpGetSourceKey(self.ability, self.ability:GetAbilityName())
	if not self.source_key then
		return
	end
	self.caster:LevelUpSetCustomStatsBonus(self.source_key, {
		base = { health_regen_pct = self.bonus_health_regen, health_pct = self.bonus_health, armor = self.bonus_armor },
		bonus = {},
	})
end

function modifier_item_levelup_1:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_item_levelup_1:GetModifierModelScale()
	return self.model_scale
end

function modifier_item_levelup_1:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.source_key then
		return
	end
	self.caster:LevelUpClearCustomStatsBonus(self.source_key)
end