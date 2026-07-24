--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_blood_magic_custom", "heroes/npc_dota_hero_huskar_custom/huskar_blood_magic_custom", LUA_MODIFIER_MOTION_NONE)

huskar_blood_magic_custom = class({})

function huskar_blood_magic_custom:Spawn()
    if not IsServer() then return end
    if not self:IsTrained() then
        self:SetLevel(1)
    end
end

function huskar_blood_magic_custom:GetIntrinsicModifierName()
    return "modifier_huskar_blood_magic_custom"
end

modifier_huskar_blood_magic_custom = class({})
function modifier_huskar_blood_magic_custom:GetTexture() return "npc_dota_hero_huskar" end
function modifier_huskar_blood_magic_custom:IsPurgeException() return false end
function modifier_huskar_blood_magic_custom:IsPurgable() return false end
function modifier_huskar_blood_magic_custom:RemoveOnDeath() return false end