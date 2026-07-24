--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lina_14_buff", "modifiers/talents/npc_dota_hero_lina/modifier_lina_14", LUA_MODIFIER_MOTION_NONE)

modifier_lina_14=class({})

function modifier_lina_14:IsHidden() return true end
function modifier_lina_14:IsPurgable() return false end
function modifier_lina_14:IsPurgeException() return false end
function modifier_lina_14:RemoveOnDeath() return false end

function modifier_lina_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_lina_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_lina_14:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.ability == nil then return end
    if params.ability:IsItem() then return end
    self:GetParent():AddNewModifier(self:GetParent(), nil, "modifier_lina_14_buff", {duration = 3})
end

modifier_lina_14_buff = class({})
function modifier_lina_14_buff:GetTexture() return "lina_14" end
function modifier_lina_14_buff:IsPurgable() return false end
function modifier_lina_14_buff:IsPurgeException() return false end
function modifier_lina_14_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    }
end
function modifier_lina_14_buff:GetModifierPreAttack_CriticalStrike()
    return 150
end