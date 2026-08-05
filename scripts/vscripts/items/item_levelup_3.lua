--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_3", "items/item_levelup_3", LUA_MODIFIER_MOTION_NONE)

item_levelup_3 = class({})

function item_levelup_3:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	local modifier_item_levelup_3 = caster:FindModifierByName("modifier_item_levelup_3")
	if modifier_item_levelup_3 then
		duration = modifier_item_levelup_3:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_3", { duration = duration })
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_3 = class({})
function modifier_item_levelup_3:IsPurgable()
	return false
end
function modifier_item_levelup_3:IsPurgeException()
	return false
end
function modifier_item_levelup_3:OnCreated(params)
	self.bonus_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_regen")
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
		base = { mana_regen = self.bonus_mana_regen },
		bonus = {},
	})
end

function modifier_item_levelup_3:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.source_key then
		return
	end
	self.caster:LevelUpClearCustomStatsBonus(self.source_key)
end