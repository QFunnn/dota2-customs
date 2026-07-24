--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_death_prophet_6_aura", "modifiers/talents/npc_dota_hero_death_prophet/modifier_death_prophet_6", LUA_MODIFIER_MOTION_NONE)

modifier_death_prophet_6=class({})

function modifier_death_prophet_6:IsHidden() return true end
function modifier_death_prophet_6:IsPurgable() return false end
function modifier_death_prophet_6:IsPurgeException() return false end
function modifier_death_prophet_6:RemoveOnDeath() return false end

function modifier_death_prophet_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_death_prophet_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_death_prophet_6:IsAura()
	return true
end

function modifier_death_prophet_6:GetModifierAura()
	return "modifier_death_prophet_6_aura"
end

function modifier_death_prophet_6:GetAuraRadius()
	return 900
end

function modifier_death_prophet_6:GetAuraDuration()
	return 0
end

function modifier_death_prophet_6:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_BOTH
end

function modifier_death_prophet_6:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_death_prophet_6:GetAuraEntityReject(target)
	if IsServer() then
		if target ~= self:GetCaster() and target:GetTeamNumber() == self:GetCaster():GetTeamNumber() then
			return true
		else
			return false
		end
	end
end

modifier_death_prophet_6_aura = class({})

function modifier_death_prophet_6_aura:IsDebuff() return true end
function modifier_death_prophet_6_aura:IsPurgable() return false end
function modifier_death_prophet_6_aura:IsPurgeException() return false end

function modifier_death_prophet_6_aura:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_RESTORATION_AMPLIFICATION,
	}
end

function modifier_death_prophet_6_aura:GetModifierPropertyRestorationAmplification()
	local bonus = {-20,-40}
	return bonus[self:GetCaster():GetTalentLevel("modifier_death_prophet_6")]
end

function modifier_death_prophet_6_aura:GetTexture()
	return "death_prophet_6"
end