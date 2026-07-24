--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


invoker_alacrity_lua = class({})
LinkLuaModifier("modifier_invoker_alacrity_lua", "heroes/hero_invoker/modifier_invoker_alacrity_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_invoker_alacrity_talent", "heroes/hero_invoker/modifier_invoker_alacrity_talent", LUA_MODIFIER_MOTION_NONE)

--------------------------------------------------------------------------------
-- Ability Start
function invoker_alacrity_lua:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    -- load data
    local duration = self:GetSpecialValueFor("duration")

    if IsValid(target) then
        -- add modifier
        target:AddNewModifier(
        caster, -- player source
        self, -- ability source
        "modifier_invoker_alacrity_lua", -- modifier name
        { duration = duration } -- kv
        )
    end

end

function invoker_alacrity_lua:GetCastAnimation()
    return ACT_DOTA_CAST_ALACRITY
end