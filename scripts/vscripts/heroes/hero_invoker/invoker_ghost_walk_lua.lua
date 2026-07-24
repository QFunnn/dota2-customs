--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_ghost_walk_lua = class({})

LinkLuaModifier( "modifier_invoker_ghost_walk_lua_buff", "heroes/hero_invoker/modifier_invoker_ghost_walk_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_lua", "heroes/hero_invoker/modifier_invoker_ghost_walk_lua", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_invoker_ghost_walk_lua_debuff", "heroes/hero_invoker/modifier_invoker_ghost_walk_lua_debuff", LUA_MODIFIER_MOTION_NONE )

function invoker_ghost_walk_lua:OnSpellStart()
	if not IsServer() then return end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_GHOST_WALK)
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_invoker_ghost_walk_lua_buff", { duration = duration } )
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_invoker_ghost_walk_lua", { duration = duration } )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_invoker/invoker_ghost_walk.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetCaster():EmitSound("Hero_Invoker.GhostWalk")
end

function invoker_ghost_walk_lua:GetCooldown(level)
    return self.BaseClass.GetCooldown(self, level)
end