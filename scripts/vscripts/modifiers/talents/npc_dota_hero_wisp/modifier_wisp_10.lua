--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_wisp_10_aura", "modifiers/talents/npc_dota_hero_wisp/modifier_wisp_10", LUA_MODIFIER_MOTION_NONE )

modifier_wisp_10=class({})

function modifier_wisp_10:IsHidden() return true end
function modifier_wisp_10:IsPurgable() return false end
function modifier_wisp_10:IsPurgeException() return false end
function modifier_wisp_10:RemoveOnDeath() return false end

function modifier_wisp_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local modifier_wisp_spirits_custom = self:GetCaster():FindModifierByName("modifier_wisp_spirits_custom")
    if modifier_wisp_spirits_custom then
        modifier_wisp_spirits_custom:Destroy()
    end
    local wisp_spirits_custom = self:GetCaster():FindAbilityByName("wisp_spirits_custom")
    if wisp_spirits_custom then
        wisp_spirits_custom:SetHidden(true)
        wisp_spirits_custom:SetActivated(false)
    end
end

function modifier_wisp_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_wisp_10:IsAura()
    return true
end

function modifier_wisp_10:GetModifierAura()
    return "modifier_wisp_10_aura"
end

function modifier_wisp_10:GetAuraRadius()
    return 1200
end

function modifier_wisp_10:GetAuraDuration()
    return 0
end

function modifier_wisp_10:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_wisp_10:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_wisp_10:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE
end

modifier_wisp_10_aura = class({})

function modifier_wisp_10_aura:GetTexture() return "wisp_10" end

function modifier_wisp_10_aura:OnCreated()
    self.bonus = {20, 40}
end

function modifier_wisp_10_aura:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_wisp_10_aura:GetModifierAttackSpeedBonus_Constant()
    return self.bonus[self:GetCaster():GetTalentLevel("modifier_wisp_10")]
end