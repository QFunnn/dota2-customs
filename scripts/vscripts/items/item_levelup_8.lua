--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_8", "items/item_levelup_8", LUA_MODIFIER_MOTION_NONE)

item_levelup_8 = class({})

local function GetAtlasStatValue(player_id, stat_id)
	if services and services.GetAtlasStat then
		return tonumber(services:GetAtlasStat(player_id, stat_id, { runtime_modifiers = true })) or 0
	end
	return 0
end

function item_levelup_8:OnSpellStart()
	local caster = self:GetCaster()
	local ability = self
	local duration = self:GetSpecialValueFor("duration")
	if services and services.GetRamPotionDuration then
		duration = services:GetRamPotionDuration(caster:GetPlayerOwnerID(), ability:GetAbilityName(), duration)
	end
	local modifier_item_levelup_8 = caster:FindModifierByName("modifier_item_levelup_8")
	if modifier_item_levelup_8 then
		duration = modifier_item_levelup_8:GetRemainingTime() + duration
	end
	caster:AddNewModifier(caster, ability, "modifier_item_levelup_8", { duration = duration })
	ConsumeLevelUpItemCharge(caster, ability)
end

modifier_item_levelup_8 = class({})
function modifier_item_levelup_8:IsPurgable()
	return false
end
function modifier_item_levelup_8:IsPurgeException()
	return false
end

function modifier_item_levelup_8:OnCreated(params)
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not IsServer() then
		return
	end
	self.bonus_str = self.bonus_str
		* (1 + GetAtlasStatValue(self.caster:GetPlayerOwnerID(), "str_potion_kill_effect_bonus_pct") / 100)
	self.source_key = self.caster:LevelUpGetSourceKey(self.ability, self.ability:GetAbilityName())
	if not self.source_key then
		return
	end
	self.caster:LevelUpSetCustomStatsBonus(self.source_key, {
		base = { str_per_kill = self.bonus_str },
		bonus = {},
	})
end

function modifier_item_levelup_8:OnDestroy()
	if not IsServer() then
		return
	end
	if not self.source_key then
		return
	end
	self.caster:LevelUpClearCustomStatsBonus(self.source_key)
end