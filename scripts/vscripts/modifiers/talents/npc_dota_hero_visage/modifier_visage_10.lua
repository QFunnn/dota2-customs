--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_visage_10_buff", "modifiers/talents/npc_dota_hero_visage/modifier_visage_10", LUA_MODIFIER_MOTION_NONE)

modifier_visage_10=class({})

function modifier_visage_10:IsHidden() return true end
function modifier_visage_10:IsPurgable() return false end
function modifier_visage_10:IsPurgeException() return false end
function modifier_visage_10:RemoveOnDeath() return false end

function modifier_visage_10:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:CheckStoneHearts()
end

function modifier_visage_10:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_visage_10:CheckStoneHearts()
    if self:GetCaster():HasModifier("modifier_visage_3") and self:GetCaster():HasModifier("modifier_visage_10") and self:GetCaster():HasModifier("modifier_visage_17") then
        self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_visage_10_buff", {})
    end
end

modifier_visage_10_buff = class({})
function modifier_visage_10_buff:IsPurgable() return false end
function modifier_visage_10_buff:IsPurgeException() return false end
function modifier_visage_10_buff:RemoveOnDeath() return false end
function modifier_visage_10_buff:GetTexture() return "visage_10" end
function modifier_visage_10_buff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_visage_10_buff:OnIntervalThink()
    if not IsServer() then return end
    if GetMapName() == "arena" then return end
    local kills_count = self:GetParent():GetKills()
    if self:GetStackCount() ~= kills_count then
        self:SetStackCount(kills_count)
        self:GetParent():CalculateStatBonus(false)
    end
end
function modifier_visage_10_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
    }
end
function modifier_visage_10_buff:GetModifierBonusStats_Strength()
    return self:GetStackCount() * 2
end
function modifier_visage_10_buff:GetModifierBonusStats_Agility()
    return self:GetStackCount() * 2
end
function modifier_visage_10_buff:GetModifierBonusStats_Intellect()
    return self:GetStackCount() * 2
end