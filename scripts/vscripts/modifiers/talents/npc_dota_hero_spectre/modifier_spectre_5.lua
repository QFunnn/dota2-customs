--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spectre_5_aura", "modifiers/talents/npc_dota_hero_spectre/modifier_spectre_5", LUA_MODIFIER_MOTION_NONE )

modifier_spectre_5=class({})

function modifier_spectre_5:IsHidden() return true end
function modifier_spectre_5:IsPurgable() return false end
function modifier_spectre_5:IsPurgeException() return false end
function modifier_spectre_5:RemoveOnDeath() return false end

function modifier_spectre_5:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_spectre_5:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_spectre_5:IsAura()
    return true
end

function modifier_spectre_5:GetModifierAura()
    return "modifier_spectre_5_aura"
end

function modifier_spectre_5:GetAuraRadius()
    return 600
end

function modifier_spectre_5:GetAuraDuration()
    return 1
end

function modifier_spectre_5:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_spectre_5:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_spectre_5:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_spectre_5_aura = class({})

function modifier_spectre_5_aura:GetTexture() return "spectre_5" end

function modifier_spectre_5_aura:DeclareFunctions()
	return 
	{ 
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE, 
	} 
end

function modifier_spectre_5_aura:GetModifierIncomingDamage_Percentage(keys)
	if keys.damage_category == DOTA_DAMAGE_CATEGORY_SPELL then
		local bonus = {5,10,15}
		return bonus[self:GetCaster():GetTalentLevel("modifier_spectre_5")]
	end
end