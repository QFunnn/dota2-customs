--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


drow_ranger_marksmanship_lua = class({})
LinkLuaModifier("modifier_drow_ranger_marksmanship_lua", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drow_ranger_marksmanship_lua_debuff", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua_debuff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_drow_ranger_marksmanship_lua_effect", "heroes/hero_drow_ranger/modifier_drow_ranger_marksmanship_lua_effect", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Passive Modifier
function drow_ranger_marksmanship_lua:GetIntrinsicModifierName()
    return "modifier_drow_ranger_marksmanship_lua"
end

--------------------------------------------------------------------------------
-- Projectile
function drow_ranger_marksmanship_lua:OnProjectileHit_ExtraData(hTarget, location, ExtraData)
    local Target = EntIndexToHScript(ExtraData.Target)
    if not IsValid(Target) then
        return
    end
    if not Target:IsAlive() then
        return
    end

    local hCaster = self:GetCaster()
    -- perform attack
    self.split = true
    -- self.split_procs = ExtraData.procs == 1
    hCaster.split_attack = true
    --不能使用弹道
    -- self:GetCaster():PerformAttack( target, true, true, true, false, false, false, data.procs==1 )
    hCaster:Attack(Target, ATTACK_STATE_SKIPCOOLDOWN + ATTACK_STATE_IGNOREINVIS + ATTACK_STATE_NOT_USEPROJECTILE + ATTACK_STATE_NO_EXTENDATTACK + ATTACK_STATE_SKIPCOUNTING)
    hCaster.split_attack = false
    self.split = false
end