--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_patrol_tormentor_shield_custom", "abilities/patrol_creeps/patrol_tormentor_shield_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_patrol_tormentor_shield_custom_heal_aura", "abilities/patrol_creeps/patrol_tormentor_shield_custom", LUA_MODIFIER_MOTION_NONE)


patrol_tormentor_shield_custom = class({})


function patrol_tormentor_shield_custom:Precache(context)
if self:GetCaster() and self:GetCaster():IsIllusion() then return end

end
