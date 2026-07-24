--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_wisp_start_arena_stunned = class({})
function modifier_wisp_start_arena_stunned:IsHidden() return true end
function modifier_wisp_start_arena_stunned:IsPurgable() return false end
function modifier_wisp_start_arena_stunned:IsPurgeException() return false end
function modifier_wisp_start_arena_stunned:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end