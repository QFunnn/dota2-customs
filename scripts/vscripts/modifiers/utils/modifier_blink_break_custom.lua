--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_blink_break_custom = class(mod_visible)
function modifier_blink_break_custom:IsDebuff() return true end
function modifier_blink_break_custom:GetTexture() return "item_blink" end