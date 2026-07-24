--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_undying_13_aura_attack_speed", "modifiers/talents/npc_dota_hero_undying/modifier_undying_13", LUA_MODIFIER_MOTION_NONE)

modifier_undying_13=class({})

function modifier_undying_13:IsHidden() return true end
function modifier_undying_13:IsPurgable() return false end
function modifier_undying_13:IsPurgeException() return false end
function modifier_undying_13:RemoveOnDeath() return false end
function modifier_undying_13:IsAura() return true end
function modifier_undying_13:GetAuraDuration() return 0 end

function modifier_undying_13:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_undying_13:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_undying_13:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY 
end

function modifier_undying_13:GetAuraSearchType()
    return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO
end

function modifier_undying_13:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

function modifier_undying_13:GetModifierAura()
    return "modifier_undying_13_aura_attack_speed"
end

function modifier_undying_13:GetTexture() return "undying_13" end

function modifier_undying_13:GetAuraRadius()
    return 1200
end

modifier_undying_13_aura_attack_speed = class({})

function modifier_undying_13_aura_attack_speed:GetTexture() return "undying_13" end

function modifier_undying_13_aura_attack_speed:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_undying_13_aura_attack_speed:GetModifierAttackSpeedBonus_Constant()
	return 60
end