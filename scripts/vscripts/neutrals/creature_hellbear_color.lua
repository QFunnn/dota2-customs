--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_creature_hellbear_color", "neutrals/creature_hellbear_color", LUA_MODIFIER_MOTION_NONE)

creature_hellbear_color = class({})

function creature_hellbear_color:GetIntrinsicModifierName()
    return "modifier_creature_hellbear_color"
end

modifier_creature_hellbear_color = class({})
function modifier_creature_hellbear_color:IsHidden() return true end
function modifier_creature_hellbear_color:IsPurgable() return false end
function modifier_creature_hellbear_color:IsPurgeException() return false end
function modifier_creature_hellbear_color:OnCreated() 
    if IsClient() then return end
    local colors = 
    {
        npc_woda_boss_heal_bear_1       = Vector(255, 0, 0),
        npc_woda_boss_heal_bear_2    = Vector(255, 127, 0),
        npc_woda_boss_heal_bear_3    = Vector(255, 255, 30),
        npc_woda_boss_heal_bear_4     = Vector(60, 255, 60),
        npc_woda_boss_heal_bear_5      = Vector(127, 127, 255),
        npc_woda_boss_heal_bear_6    = Vector(244, 119, 255),
    }
    local color = colors[self:GetCaster():GetUnitName()]
    self:GetCaster():SetRenderColor(color.x, color.y, color.z)
end