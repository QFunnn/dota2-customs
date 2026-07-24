--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_vengefulspirit_6_aura", "modifiers/talents/npc_dota_hero_vengefulspirit/modifier_vengefulspirit_6", LUA_MODIFIER_MOTION_NONE )

modifier_vengefulspirit_6 = class({})

function modifier_vengefulspirit_6:IsHidden() return true end
function modifier_vengefulspirit_6:IsPurgable() return false end
function modifier_vengefulspirit_6:IsPurgeException() return false end
function modifier_vengefulspirit_6:RemoveOnDeath() return false end

function modifier_vengefulspirit_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_vengefulspirit_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_vengefulspirit_6:IsAura()
    return true
end

function modifier_vengefulspirit_6:GetModifierAura()
    return "modifier_vengefulspirit_6_aura"
end

function modifier_vengefulspirit_6:GetAuraRadius()
    return -1
end

function modifier_vengefulspirit_6:GetAuraDuration()
    return 3
end

function modifier_vengefulspirit_6:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_vengefulspirit_6:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_vengefulspirit_6:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_vengefulspirit_6:GetAuraEntityReject(target)
	if target:IsIllusion() then
		return false
	else
		return true
	end
end

modifier_vengefulspirit_6_aura = class({})

function modifier_vengefulspirit_6_aura:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_vengefulspirit_6_aura:GetModifierDamageOutgoing_Percentage()
	local bonus = {15,30}
    return bonus[self:GetAuraOwner():GetTalentLevel("modifier_vengefulspirit_6")]
end