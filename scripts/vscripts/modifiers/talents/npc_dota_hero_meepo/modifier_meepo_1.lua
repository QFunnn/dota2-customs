--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_meepo_1_aura", "modifiers/talents/npc_dota_hero_meepo/modifier_meepo_1", LUA_MODIFIER_MOTION_NONE)

modifier_meepo_1=class({})

function modifier_meepo_1:IsHidden() return true end
function modifier_meepo_1:IsPurgable() return false end
function modifier_meepo_1:IsPurgeException() return false end
function modifier_meepo_1:RemoveOnDeath() return false end

function modifier_meepo_1:OnCreated()
    if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_meepo_1:OnRefresh()
    if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_meepo_1:IsAura() return true end
function modifier_meepo_1:GetModifierAura() return "modifier_meepo_1_aura" end
function modifier_meepo_1:GetAuraRadius() return 900 end
function modifier_meepo_1:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_meepo_1:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_meepo_1:GetAuraDuration() return 0.1 end
function modifier_meepo_1:IsAuraActiveOnDeath() return false end

modifier_meepo_1_aura = class({})
function modifier_meepo_1_aura:GetTexture() return "aghanim_1" end
function modifier_meepo_1_aura:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
    }
end

function modifier_meepo_1_aura:GetModifierPhysicalArmorBonus()
    local bonus = {-2,-3,-4}
    return bonus[self:GetCaster():GetTalentLevel("modifier_meepo_1")]
end