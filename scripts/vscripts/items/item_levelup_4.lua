--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_4", "items/item_levelup_4", LUA_MODIFIER_MOTION_NONE)

item_levelup_4 = class({})

function item_levelup_4:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local modifier_item_levelup_4 = caster:FindModifierByName("modifier_item_levelup_4")
	if modifier_item_levelup_4 then
		duration = modifier_item_levelup_4:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_4", { duration = duration })
	if services and services.OnLevelUpFlaskUsed then
		services:OnLevelUpFlaskUsed(caster, ability)
	end
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_4 = class({})
function modifier_item_levelup_4:IsPurgable()
	return false
end
function modifier_item_levelup_4:IsPurgeException()
	return false
end
function modifier_item_levelup_4:OnCreated(params)
	self.bonus_attack_speed = self:GetAbility():GetSpecialValueFor("bonus_attack_speed")
	self.bonus_cooldown_speed = self:GetAbility():GetSpecialValueFor("bonus_cooldown_speed")
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
		base = { cooldown_reduction = self.bonus_cooldown_speed, attack_speed = self.bonus_attack_speed },
		bonus = {},
	})
end

function modifier_item_levelup_4:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.source_key then
		return
	end
	self.caster:LevelUpClearCustomStatsBonus(self.source_key)
end