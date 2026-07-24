--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_vengefulspirit_command_aura_custom", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_command_aura_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_vengefulspirit_command_aura_custom_aura", "heroes/npc_dota_hero_vengefulspirit_custom/vengefulspirit_command_aura_custom", LUA_MODIFIER_MOTION_NONE)

vengefulspirit_command_aura_custom = class({})
vengefulspirit_command_aura_custom.modifier_vengefulspirit_5 = {20,40}

function vengefulspirit_command_aura_custom:GetIntrinsicModifierName()
	if self:GetCaster():IsIllusion() then return end
	return "modifier_vengefulspirit_command_aura_custom"
end

modifier_vengefulspirit_command_aura_custom = class({})

function modifier_vengefulspirit_command_aura_custom:IsAura() return true end
function modifier_vengefulspirit_command_aura_custom:IsDebuff() return false end
function modifier_vengefulspirit_command_aura_custom:IsHidden() return true end
function modifier_vengefulspirit_command_aura_custom:IsPurgable() return false end
function modifier_vengefulspirit_command_aura_custom:IsPurgeException() return false end
function modifier_vengefulspirit_command_aura_custom:IsStunDebuff() return false end
function modifier_vengefulspirit_command_aura_custom:RemoveOnDeath() return false end
function modifier_vengefulspirit_command_aura_custom:IsAuraActiveOnDeath() return false end


function modifier_vengefulspirit_command_aura_custom:GetAuraEntityReject(target)
	if IsServer() then
		if self:GetParent():PassivesDisabled() then return true end
		return false
	end
end

function modifier_vengefulspirit_command_aura_custom:GetModifierAura()
	return "modifier_vengefulspirit_command_aura_custom_aura"
end

function modifier_vengefulspirit_command_aura_custom:GetAuraRadius()
	return self:GetAbility():GetSpecialValueFor("aura_radius")
end

function modifier_vengefulspirit_command_aura_custom:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD
end

function modifier_vengefulspirit_command_aura_custom:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_vengefulspirit_command_aura_custom:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end


modifier_vengefulspirit_command_aura_custom_aura = class({})
function modifier_vengefulspirit_command_aura_custom_aura:IsDebuff() return false end
function modifier_vengefulspirit_command_aura_custom_aura:IsHidden() return false end
function modifier_vengefulspirit_command_aura_custom_aura:IsPurgable() return false end
function modifier_vengefulspirit_command_aura_custom_aura:IsPurgeException() return false end
function modifier_vengefulspirit_command_aura_custom_aura:IsStunDebuff() return false end
function modifier_vengefulspirit_command_aura_custom_aura:RemoveOnDeath() return false end

function modifier_vengefulspirit_command_aura_custom_aura:OnCreated()
	self.bonus_base_damage		= self:GetAbility():GetSpecialValueFor("bonus_base_damage")
    self.self_multiplier = self:GetAbility():GetSpecialValueFor("self_multiplier")
end

function modifier_vengefulspirit_command_aura_custom_aura:OnRefresh()
	self.bonus_base_damage		= self:GetAbility():GetSpecialValueFor("bonus_base_damage")
    self.self_multiplier = self:GetAbility():GetSpecialValueFor("self_multiplier")
end


function modifier_vengefulspirit_command_aura_custom_aura:DeclareFunctions()
	local decFuncs =
	{
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
	}
	return decFuncs
end

function modifier_vengefulspirit_command_aura_custom_aura:GetModifierBaseDamageOutgoing_Percentage()
	local bonus = 0
    local multiplier = 1
    if self:GetCaster():HasModifier("modifier_vengefulspirit_5") then
        bonus = self:GetAbility().modifier_vengefulspirit_5[self:GetCaster():GetTalentLevel("modifier_vengefulspirit_5")]
    end
    if self:GetParent() == self:GetCaster() then
        multiplier = multiplier + ((self.self_multiplier + bonus) / 100)
    end
	return self.bonus_base_damage * multiplier
end