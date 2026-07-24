--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_emp_lua = class({})

LinkLuaModifier("modifier_invoker_emp_lua_thinker", "heroes/hero_invoker/modifier_invoker_emp_lua_thinker", LUA_MODIFIER_MOTION_NONE)

function invoker_emp_lua:GetAOERadius()
    return self:GetSpecialValueFor("area_of_effect")
end

function invoker_emp_lua:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local delay = self:GetSpecialValueFor("delay")
    CreateModifierThinker( caster, self, "modifier_invoker_emp_lua_thinker", { duration = delay }, point, caster:GetTeamNumber(), false )
    self:GetCaster():EmitSound("Hero_Invoker.EMP.Cast")
end

function invoker_emp_lua:GetCastAnimation()
    return ACT_DOTA_CAST_EMP
end