--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_antimage_14_aura", "modifiers/talents/npc_dota_hero_antimage/modifier_antimage_14", LUA_MODIFIER_MOTION_NONE )

modifier_antimage_14 = class({})

function modifier_antimage_14:IsHidden() return true end
function modifier_antimage_14:IsPurgable() return false end
function modifier_antimage_14:IsPurgeException() return false end
function modifier_antimage_14:RemoveOnDeath() return false end

function modifier_antimage_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_antimage_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_antimage_14:IsAura() 
    return true
end

function modifier_antimage_14:GetModifierAura()
    return "modifier_antimage_14_aura"
end

function modifier_antimage_14:GetAuraRadius()
    return -1
end

function modifier_antimage_14:GetAuraDuration()
    return 3
end

function modifier_antimage_14:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_antimage_14:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_antimage_14:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_antimage_14:GetAuraEntityReject(target)
	if target:IsIllusion() then
		return false
	else
		return true
	end
end

modifier_antimage_14_aura = class({})

function modifier_antimage_14_aura:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_antimage_14_aura:GetModifierDamageOutgoing_Percentage()
    return 15
end