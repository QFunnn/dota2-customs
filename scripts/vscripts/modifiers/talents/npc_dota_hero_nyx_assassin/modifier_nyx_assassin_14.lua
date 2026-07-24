--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_nyx_assassin_14_buff", "modifiers/talents/npc_dota_hero_nyx_assassin/modifier_nyx_assassin_14", LUA_MODIFIER_MOTION_NONE)

modifier_nyx_assassin_14=class({})

function modifier_nyx_assassin_14:IsHidden() return true end
function modifier_nyx_assassin_14:IsPurgable() return false end
function modifier_nyx_assassin_14:IsPurgeException() return false end
function modifier_nyx_assassin_14:RemoveOnDeath() return false end

function modifier_nyx_assassin_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_nyx_assassin_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nyx_assassin_14:IsAura()
    return true
end

function modifier_nyx_assassin_14:GetModifierAura()
    return "modifier_nyx_assassin_14_buff"
end

function modifier_nyx_assassin_14:IsAuraActiveOnDeath()
    return true
end

function modifier_nyx_assassin_14:GetAuraRadius()
    return -1
end

function modifier_nyx_assassin_14:GetAuraDuration()
    return 0
end

function modifier_nyx_assassin_14:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_nyx_assassin_14:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_nyx_assassin_14:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_nyx_assassin_14:GetAuraEntityReject(hTarget)
    if not IsServer() then return end
    if hTarget:IsRealHero() and not hTarget:IsIllusion() then
        return true
    end
    if hTarget:GetOwner() == self:GetCaster() then
        return false
    end
    local modifier_illusion = hTarget:FindModifierByName("modifier_illusion")
    if modifier_illusion:GetCaster() == self:GetCaster() then
        return false
    end
    return true
end

modifier_nyx_assassin_14_buff = class({})

function modifier_nyx_assassin_14_buff:GetTexture()
    return "nyx_assassin_14"
end

function modifier_nyx_assassin_14_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_nyx_assassin_14_buff:GetModifierDamageOutgoing_Percentage()
    return 20
end

function modifier_nyx_assassin_14_buff:GetModifierIncomingDamage_Percentage()
    return -20
end