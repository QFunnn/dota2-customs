--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_19_debuff", "modifiers/talents/npc_dota_hero_medusa/modifier_medusa_19", LUA_MODIFIER_MOTION_NONE)

modifier_medusa_19=class({})

function modifier_medusa_19:IsHidden() return true end
function modifier_medusa_19:IsPurgable() return false end
function modifier_medusa_19:IsPurgeException() return false end
function modifier_medusa_19:RemoveOnDeath() return false end

function modifier_medusa_19:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_medusa_19:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_medusa_19:IsAura()
    return true
end

function modifier_medusa_19:GetModifierAura()
    return "modifier_medusa_19_debuff"
end

function modifier_medusa_19:GetAuraRadius()
    return 1200
end

function modifier_medusa_19:GetAuraDuration()
    return 0
end

function modifier_medusa_19:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_medusa_19:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_medusa_19:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_medusa_19_debuff = class({})

function modifier_medusa_19_debuff:GetTexture() return "medusa_19" end

function modifier_medusa_19_debuff:OnCreated()
    self.bonus = {-5,-10,-15}
end

function modifier_medusa_19_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MP_REGEN_AMPLIFY_PERCENTAGE,
    }
end

function modifier_medusa_19_debuff:GetModifierHPRegenAmplify_Percentage()
    return self.bonus[self:GetStackCount()]
end

function modifier_medusa_19_debuff:GetModifierMPRegenAmplify_Percentage()
    return self.bonus[self:GetStackCount()]
end