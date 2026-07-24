--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_chaos_meteor_lua = class({})

LinkLuaModifier("modifier_invoker_chaos_meteor_lua_thinker", "heroes/hero_invoker/modifier_invoker_chaos_meteor_lua_thinker", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_chaos_meteor_lua_burn", "heroes/hero_invoker/modifier_invoker_chaos_meteor_lua_burn", LUA_MODIFIER_MOTION_NONE)

function invoker_chaos_meteor_lua:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()

    CreateModifierThinker( caster, self, "modifier_invoker_chaos_meteor_lua_thinker", {}, point, self:GetCaster():GetTeamNumber(), false )

    if caster:HasModifier("modifier_item_aghanims_shard") then
        local caster_point =caster:GetOrigin()
        local dir = (point-caster_point):Normalized()
        if dir:Length2D()<0.5 then
           print("shard direction is zero")
           dir = self:GetCaster():GetForwardVector()
        end
        CreateModifierThinker( caster, self, "modifier_invoker_chaos_meteor_lua_thinker", {}, RotatePosition(point, QAngle( 0, -90, 0 ), point+dir*200 ), self:GetCaster():GetTeamNumber(), false )
        CreateModifierThinker( caster, self, "modifier_invoker_chaos_meteor_lua_thinker", {}, RotatePosition(point, QAngle( 0, 90, 0 ), point+dir*200 ), self:GetCaster():GetTeamNumber(), false )
    end
end

function invoker_chaos_meteor_lua:GetCooldown(level)
    return self.BaseClass.GetCooldown(self, level)
end

function invoker_chaos_meteor_lua:GetCastAnimation()
    return ACT_DOTA_CAST_CHAOS_METEOR
end