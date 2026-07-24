--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skeleton_king_16_buff", "modifiers/talents/npc_dota_hero_skeleton_king/modifier_skeleton_king_16", LUA_MODIFIER_MOTION_NONE)

modifier_skeleton_king_16=class({})

function modifier_skeleton_king_16:IsHidden() return true end
function modifier_skeleton_king_16:IsPurgable() return false end
function modifier_skeleton_king_16:IsPurgeException() return false end
function modifier_skeleton_king_16:RemoveOnDeath() return false end

function modifier_skeleton_king_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skeleton_king_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skeleton_king_16:IsAura()
    return true
end

function modifier_skeleton_king_16:GetModifierAura()
    return "modifier_skeleton_king_16_buff"
end

function modifier_skeleton_king_16:GetAuraRadius()
    return 1200
end

function modifier_skeleton_king_16:GetAuraDuration()
    return 0
end

function modifier_skeleton_king_16:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_skeleton_king_16:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_skeleton_king_16:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_skeleton_king_16_buff = class({})

function modifier_skeleton_king_16_buff:GetTexture()
    return "modifier_skeleton_king_16"
end

function modifier_skeleton_king_16_buff:OnCreated()
    self.bonus = {10,20}
end

function modifier_skeleton_king_16_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_skeleton_king_16_buff:GetModifierAttackSpeedBonus_Constant()
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_skeleton_king_16")]
end

function modifier_skeleton_king_16_buff:GetModifierMoveSpeedBonus_Constant()
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_skeleton_king_16")]
end