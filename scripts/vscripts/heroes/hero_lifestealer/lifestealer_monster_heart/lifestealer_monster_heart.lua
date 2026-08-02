--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


lifestealer_monster_heart = class({})
LinkLuaModifier(
	"modifier_lifestealer_monster_heart",
	"heroes/hero_lifestealer/lifestealer_monster_heart/lifestealer_monster_heart",
	LUA_MODIFIER_MOTION_NONE
)

function lifestealer_monster_heart:GetIntrinsicModifierName()
	return "modifier_lifestealer_monster_heart"
end

modifier_lifestealer_monster_heart = class({})

function modifier_lifestealer_monster_heart:IsHidden()
	return true
end

function modifier_lifestealer_monster_heart:IsPurgable()
	return false
end

function modifier_lifestealer_monster_heart:OnCreated(kv)
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")
	self:StartIntervalThink(1)
end

function modifier_lifestealer_monster_heart:OnRefresh(kv)
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.bonus_str = self:GetAbility():GetSpecialValueFor("bonus_str")

	if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int3") ~= nil then
		if self:GetCaster():FindAbilityByName("special_bonus_lifestealer_int3"):GetLevel() > 0 then
			self.regen = self:GetAbility():GetSpecialValueFor("regen") + 1.5
		end
	end
end

function modifier_lifestealer_monster_heart:OnIntervalThink()
	self:OnRefresh()
end

function modifier_lifestealer_monster_heart:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
	}

	return funcs
end

function modifier_lifestealer_monster_heart:GetModifierHealthRegenPercentage(params)
	if self:GetParent():PassivesDisabled() then
		return
	end
	return self.regen
end

function modifier_lifestealer_monster_heart:GetModifierBonusStats_Strength(params)
	if IsServer() then
		if self:GetParent():PassivesDisabled() then
			return
		end
		return self.bonus_str
	end
end