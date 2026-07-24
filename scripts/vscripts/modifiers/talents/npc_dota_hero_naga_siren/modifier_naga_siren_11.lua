--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_naga_siren_11_aura", "modifiers/talents/npc_dota_hero_naga_siren/modifier_naga_siren_11", LUA_MODIFIER_MOTION_NONE )

modifier_naga_siren_11 = class({})

function modifier_naga_siren_11:IsHidden() return true end
function modifier_naga_siren_11:IsPurgable() return false end
function modifier_naga_siren_11:IsPurgeException() return false end
function modifier_naga_siren_11:RemoveOnDeath() return false end

function modifier_naga_siren_11:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_naga_siren_11:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_11:IsAura()
    return true
end

function modifier_naga_siren_11:GetModifierAura()
    return "modifier_naga_siren_11_aura"
end

function modifier_naga_siren_11:GetAuraRadius()
    return -1
end

function modifier_naga_siren_11:GetAuraDuration()
    return 3
end

function modifier_naga_siren_11:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_naga_siren_11:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_naga_siren_11:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_naga_siren_11:GetAuraEntityReject(target)
	if target:IsIllusion() then
		return false
	else
		return true
	end
end

modifier_naga_siren_11_aura = class({})

function modifier_naga_siren_11_aura:IsHidden() return true end

function modifier_naga_siren_11_aura:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_naga_siren_11_aura:GetModifierDamageOutgoing_Percentage()
    local bonus = {10,20}
    return bonus[self:GetCaster():GetTalentLevel("modifier_naga_siren_11")]
end