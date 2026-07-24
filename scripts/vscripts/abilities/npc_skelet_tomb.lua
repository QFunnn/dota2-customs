--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_skelet_tomb_cd", "abilities/npc_skelet_tomb.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_skelet_tomb", "abilities/npc_skelet_tomb.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_tomb_thinker", "abilities/npc_skelet_tomb.lua", LUA_MODIFIER_MOTION_NONE)

npc_skelet_tomb = class({})



function npc_skelet_tomb:OnSpellStart()


self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_skelet_tomb_cd", {duration = self:GetCooldownTimeRemaining()})

self.radius = self:GetSpecialValueFor("radius")
if not IsServer() then return end

self:GetCaster():EmitSound("Hero_Undying.Tombstone")
local new_tomb = CreateUnitByName("npc_skelet_tomb", self:GetAbsOrigin()+RandomVector(RandomInt(-1, 1)+self.radius), true, nil, nil, DOTA_TEAM_CUSTOM_5)
new_tomb:AddNewModifier(self:GetCaster(), self, "modifier_tomb_thinker", {})
new_tomb:SetBaseMaxHealth(self:GetSpecialValueFor("hits"))
--new_tomb:SetHealth(self:GetSpecialValueFor("hits"))
new_tomb.host_team = self:GetCaster().host_team
new_tomb:AddNewModifier(nil, nil, "modifier_waveupgrade", {})
end

modifier_tomb_thinker = class({})

function modifier_tomb_thinker:IsHidden() return true end

function modifier_tomb_thinker:IsPurgable() return false end

function modifier_tomb_thinker:IsAura() return true end

function modifier_tomb_thinker:GetAuraDuration() return 0.1 end

function modifier_tomb_thinker:GetAuraRadius() return 1200
 end


function modifier_tomb_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_tomb_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO end

function modifier_tomb_thinker:GetModifierAura() return "modifier_skelet_tomb" end

function modifier_tomb_thinker:GetAuraEntityReject(hTarget)
    return hTarget:GetUnitName() == "npc_skelet_tomb" or hTarget.player_unit
end




modifier_skelet_tomb = class({})

function modifier_skelet_tomb:OnCreated(table)
self.parent = self:GetParent()
self.regen = self:GetAbility():GetSpecialValueFor("regen")
end

function modifier_skelet_tomb:IsHidden() return false end
function modifier_skelet_tomb:IsPurgable() return false end
function modifier_skelet_tomb:GetTexture() return "undying_tombstone" end
function modifier_skelet_tomb:DeclareFunctions()
return
{
    MODIFIER_PROPERTY_MIN_HEALTH,
    MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE

}
end

function modifier_skelet_tomb:GetModifierHealthRegenPercentage() return self.regen end

function modifier_skelet_tomb:GetMinHealth() 
if self.parent:HasModifier("modifier_death") then return end
    return 1 
end

modifier_skelet_tomb_cd = class({})

function modifier_skelet_tomb_cd:IsHidden() return false end
function modifier_skelet_tomb_cd:IsPurgable() return false end