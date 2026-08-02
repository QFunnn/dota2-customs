--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier(
	"modifier_broodmother_ult",
	"heroes/hero_broodmother/broodmother_ult/broodmother_ult",
	LUA_MODIFIER_MOTION_NONE
)

broodmother_ult = class({})

function broodmother_ult:GetIntrinsicModifierName()
	return "modifier_broodmother_ult"
end

--------------------------------------------------------------------------

modifier_broodmother_ult = class({})

function modifier_broodmother_ult:IsHidden()
	return false
end

function modifier_broodmother_ult:IsPurgable()
	return false
end

function modifier_broodmother_ult:RemoveOnDeath()
	return false
end

function modifier_broodmother_ult:OnCreated(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.ms = self:GetAbility():GetSpecialValueFor("ms")
	if IsServer() then
		self:SetStackCount(0)
	end
end

function modifier_broodmother_ult:OnRefresh(kv)
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.regen = self:GetAbility():GetSpecialValueFor("regen")
	self.ms = self:GetAbility():GetSpecialValueFor("ms")
end

function modifier_broodmother_ult:DeclareFunctions()
	local funcs = {
		MODIFIER_EVENT_ON_DEATH,
		MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
		MODIFIER_PROPERTY_TOOLTIP,
		MODIFIER_PROPERTY_TOOLTIP2,
	}
	return funcs
end

function modifier_broodmother_ult:OnTooltip()
	return self:GetStackCount() * (self.damage + talent(self:GetCaster()))
end

function modifier_broodmother_ult:OnTooltip2()
	return self:GetStackCount() * (self.regen + talent(self:GetCaster()))
end

function modifier_broodmother_ult:OnDeath(params)
	local parent = self:GetParent()
	if parent:PassivesDisabled() then
		return
	end

	local attacker = params.attacker
	if attacker ~= parent or attacker:HasModifier("modifier_guild_event") then
		return
	end

	local target = params.unit
	if target == parent or target:IsBuilding() or target:IsIllusion() then
		return
	end

	if not _G.excludedUnitsLookup[params.unit:GetUnitName()] then
		return
	end

	self:IncrementStackCount()
end

---------------------------------------------------------

function talent(caster)
	local ability = caster:FindAbilityByName("special_bonus_broodmother_4")
	if ability ~= nil and ability:GetLevel() > 0 then
		return 0.2
	end
	return 0
end

function modifier_broodmother_ult:GetModifierBaseAttack_BonusDamage()
	return self:GetStackCount() * (self.damage + talent(self:GetCaster()))
end

function modifier_broodmother_ult:GetModifierConstantHealthRegen()
	return self:GetStackCount() * (self.regen + talent(self:GetCaster()))
end

function modifier_broodmother_ult:GetModifierMoveSpeedBonus_Constant()
	return self:GetStackCount() * (self.ms + talent(self:GetCaster()))
end

function modifier_broodmother_ult:GetModifierIgnoreMovespeedLimit()
	return 1
end