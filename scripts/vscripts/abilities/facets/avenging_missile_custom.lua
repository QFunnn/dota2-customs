--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


vengefulspirit_avenging_missile_custom = class({})
LinkLuaModifier("modifier_vengefulspirit_avenging_missile_custom", "abilities/facets/avenging_missile_custom", LUA_MODIFIER_MOTION_NONE)

function vengefulspirit_avenging_missile_custom:GetIntrinsicModifierName()
	return "modifier_vengefulspirit_avenging_missile_custom"
end


---------------------------------------------------------------------------------------------------------------------------------------------------


modifier_vengefulspirit_avenging_missile_custom = class({})

function modifier_vengefulspirit_avenging_missile_custom:IsHidden() return true end
function modifier_vengefulspirit_avenging_missile_custom:IsPurgable() return false end
function modifier_vengefulspirit_avenging_missile_custom:IsDebuff() return false end
function modifier_vengefulspirit_avenging_missile_custom:RemoveOnDeath() return false end
function modifier_vengefulspirit_avenging_missile_custom:GetAttributes() return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE end

function modifier_vengefulspirit_avenging_missile_custom:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	if not IsValidEntity(self.caster) then return end
	if not IsValidEntity(self.ability) then return end

	self.spell_amp = self.ability:GetSpecialValueFor("spell_amp")
end

function modifier_vengefulspirit_avenging_missile_custom:OnRefresh()
	self:OnCreated()
end

function modifier_vengefulspirit_avenging_missile_custom:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
	}
end

function modifier_vengefulspirit_avenging_missile_custom:GetModifierSpellAmplify_Percentage(event)
	if not self or self:IsNull() then return 0 end
	if not IsValidEntity(event.attacker) then return 0 end
	if not IsValidEntity(event.target) then return 0 end
	if event.attacker:GetTeamNumber() == event.target:GetTeamNumber() then return 0 end
	if not event.target:IsRealHero() then return 0 end
	if not IsValidEntity(self.caster) then return 0 end
	if self.caster:PassivesDisabled() then return 0 end
	if not IsValidEntity(event.inflictor) or event.inflictor:GetAbilityName() ~= "vengefulspirit_magic_missile" then return 0 end

	local kills = event.target.GetKills and event.target:GetKills()

	return kills * self.spell_amp
end