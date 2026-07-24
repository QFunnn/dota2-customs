--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_astral_mind_debuff", "modifiers/talents/npc_dota_hero_death_prophet/modifier_death_prophet_21", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_death_prophet_astral_mind_buff", "modifiers/talents/npc_dota_hero_death_prophet/modifier_death_prophet_21", LUA_MODIFIER_MOTION_NONE)

modifier_death_prophet_21=class({})

function modifier_death_prophet_21:IsHidden() return false end
function modifier_death_prophet_21:IsPurgable() return false end
function modifier_death_prophet_21:IsPurgeException() return false end
function modifier_death_prophet_21:RemoveOnDeath() return false end
function modifier_death_prophet_21:GetTexture() return "death_prophet_21" end

function modifier_death_prophet_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_death_prophet_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_death_prophet_21:IsAura()
	return true
end

function modifier_death_prophet_21:GetModifierAura()
	return "modifier_death_prophet_astral_mind_debuff"
end

function modifier_death_prophet_21:GetAuraRadius()
	return 1200
end

function modifier_death_prophet_21:GetAuraDuration()
	return 0
end

function modifier_death_prophet_21:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_death_prophet_21:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

modifier_death_prophet_astral_mind_debuff = class({})

function modifier_death_prophet_astral_mind_debuff:GetTexture() return "death_prophet_21" end

function modifier_death_prophet_astral_mind_debuff:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS
	}
end

function modifier_death_prophet_astral_mind_debuff:GetModifierMagicalResistanceBonus()
	return -20
end