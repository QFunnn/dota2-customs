--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_wraith_king_sceleton",
	"heroes/hero_skeleton/wraith_king_sceleton/wraith_king_sceleton",
	LUA_MODIFIER_MOTION_NONE
)

wraith_king_sceleton = class({})

function wraith_king_sceleton:GetIntrinsicModifierName()
	return "modifier_wraith_king_sceleton"
end

if modifier_wraith_king_sceleton == nil then
	modifier_wraith_king_sceleton = class({})
end

function modifier_wraith_king_sceleton:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
	}
end

function modifier_wraith_king_sceleton:OnDeath(params)
	local parent = self:GetParent()
	if IsMyKilledBadGuys2(parent, params) then
		self:IncrementStackCount()
		parent:CalculateStatBonus(true)
	end
end

function modifier_wraith_king_sceleton:GetModifierPhysicalArmorBonus()
	return self:GetAbility():GetSpecialValueFor("bonus")
end

function modifier_wraith_king_sceleton:GetModifierConstantHealthRegen(params)
	silencer_bonus = self:GetAbility():GetSpecialValueFor("stack_bonus")
	local talent_ability = self:GetCaster():FindAbilityByName("special_bonus_skeleton_king_tal1")
	if talent_ability ~= nil and talent_ability:GetLevel() > 0 then
		silencer_bonus = self:GetAbility():GetSpecialValueFor("stack_bonus") + 0.2
	end
	return self:GetStackCount() * silencer_bonus
end

function modifier_wraith_king_sceleton:IsHidden()
	return false
end

function modifier_wraith_king_sceleton:IsPurgable()
	return false
end

function modifier_wraith_king_sceleton:RemoveOnDeath()
	return false
end

function modifier_wraith_king_sceleton:OnCreated(kv) end

function IsMyKilledBadGuys2(hero, params)
	if params.unit:GetTeamNumber() ~= DOTA_TEAM_NEUTRALS then
		return false
	end
	local attacker = params.attacker
	if hero ~= attacker or attacker:HasModifier("modifier_guild_event") then
		return false
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return false
	end

	return true
end