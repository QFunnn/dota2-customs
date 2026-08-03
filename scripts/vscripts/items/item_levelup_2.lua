--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_2", "items/item_levelup_2", LUA_MODIFIER_MOTION_NONE)

item_levelup_2 = class({})

function item_levelup_2:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local modifier_item_levelup_2 = caster:FindModifierByName("modifier_item_levelup_2")
	if modifier_item_levelup_2 then
		duration = modifier_item_levelup_2:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_2", { duration = duration })
	if services and services.OnLevelUpFlaskUsed then
		services:OnLevelUpFlaskUsed(caster, ability)
	end
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_2 = class({})
function modifier_item_levelup_2:IsPurgable()
	return false
end
function modifier_item_levelup_2:IsPurgeException()
	return false
end

function modifier_item_levelup_2:OnCreated(params)
	self.bonus_damage = self:GetAbility():GetSpecialValueFor("bonus_damage")
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
		base = { damage_increase = self.bonus_damage },
		bonus = {},
	})
end

function modifier_item_levelup_2:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.source_key then
		return
	end
	self.caster:LevelUpClearCustomStatsBonus(self.source_key)
end