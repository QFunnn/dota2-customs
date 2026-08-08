--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_item_levelup_tester", "items/levelup_tester", LUA_MODIFIER_MOTION_NONE)

item_levelup_tester = class({})

function item_levelup_tester:GetIntrinsicModifierName()
	return "modifier_item_levelup_tester"
end

modifier_item_levelup_tester = class({})

function modifier_item_levelup_tester:IsHidden()
	return true
end
function modifier_item_levelup_tester:IsPurgable()
	return false
end
function modifier_item_levelup_tester:IsPurgeException()
	return false
end
function modifier_item_levelup_tester:GetAttributes()
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_item_levelup_tester:OnCreated()
	if not IsServer() then
		return
	end

	local parent = self:GetParent()
	local ability = self:GetAbility()
	if not parent or parent:IsNull() then
		return
	end
	if not ability or ability:IsNull() then
		return
	end

	local damage = ability:GetSpecialValueFor("bonus_damage")
	local armor = ability:GetSpecialValueFor("bonus_armor")
	local health = ability:GetSpecialValueFor("bonus_health")
	local stats = ability:GetSpecialValueFor("bonus_all")

	self.source_key = parent:LevelUpGetSourceKey(ability, ability:GetAbilityName())
	if not self.source_key then
		return
	end

	parent:LevelUpSetCustomStatsBonus(self.source_key, {
		base = {
			str = stats,
			agi = stats,
			int = stats,
			health = health,
		},
		bonus = {
			damage = damage,
			armor = armor,
		},
	})
end

function modifier_item_levelup_tester:OnDestroy()
	if not IsServer() then
		return
	end
	local parent = self:GetParent()
	if not parent or parent:IsNull() then
		return
	end
	if not self.source_key then
		return
	end
	parent:LevelUpClearCustomStatsBonus(self.source_key)
end

function modifier_item_levelup_tester:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE,
	}
end

function modifier_item_levelup_tester:GetModifierMoveSpeedBonus_Special_Boots()
	if not self:GetAbility() then
		return 0
	end
	return self:GetAbility():GetSpecialValueFor("bonus_movement_speed")
end