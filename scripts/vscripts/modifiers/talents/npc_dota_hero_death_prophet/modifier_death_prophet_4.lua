--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_4_aura", "modifiers/talents/npc_dota_hero_death_prophet/modifier_death_prophet_4", LUA_MODIFIER_MOTION_NONE)

modifier_death_prophet_4=class({})

function modifier_death_prophet_4:IsHidden() return true end
function modifier_death_prophet_4:IsPurgable() return false end
function modifier_death_prophet_4:IsPurgeException() return false end
function modifier_death_prophet_4:RemoveOnDeath() return false end

function modifier_death_prophet_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_death_prophet_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_death_prophet_4:IsAura()
	return true
end

function modifier_death_prophet_4:GetModifierAura()
	return "modifier_death_prophet_4_aura"
end

function modifier_death_prophet_4:GetAuraRadius()
	return 900
end

function modifier_death_prophet_4:GetAuraDuration()
	return 0
end

function modifier_death_prophet_4:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_death_prophet_4:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_death_prophet_4:GetAuraEntityReject(target)
	if IsServer() then
		if target ~= self:GetCaster() and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return true
		else
			return false
		end
	end
end

modifier_death_prophet_4_aura = class({})

function modifier_death_prophet_4_aura:IsDebuff() return true end
function modifier_death_prophet_4_aura:IsPurgable() return false end
function modifier_death_prophet_4_aura:IsPurgeException() return false end

function modifier_death_prophet_4_aura:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_DIRECT_MODIFICATION 
	}
end

function modifier_death_prophet_4_aura:GetModifierMagicalResistanceDirectModification()
	local bonus = {-20,-40}
	return bonus[self:GetCaster():GetTalentLevel("modifier_death_prophet_4")]
end

function modifier_death_prophet_4_aura:GetTexture()
	return "death_prophet_4"
end