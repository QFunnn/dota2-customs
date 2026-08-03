--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local ____exports = {}
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- SLModifierBase Motion Both 基类
____exports.SLModifierBase_MotionBoth = __TS__Class()
local SLModifierBase_MotionBoth = ____exports.SLModifierBase_MotionBoth
SLModifierBase_MotionBoth.name = "SLModifierBase_MotionBoth"
__TS__ClassExtends(SLModifierBase_MotionBoth, SLModifierBase)
--- SLModifierBase Motion Horizontal 基类
____exports.SLModifierBase_MotionHorizontal = __TS__Class()
local SLModifierBase_MotionHorizontal = ____exports.SLModifierBase_MotionHorizontal
SLModifierBase_MotionHorizontal.name = "SLModifierBase_MotionHorizontal"
__TS__ClassExtends(SLModifierBase_MotionHorizontal, SLModifierBase)
--- SLModifierBase Motion Vertical 基类
____exports.SLModifierBase_MotionVertical = __TS__Class()
local SLModifierBase_MotionVertical = ____exports.SLModifierBase_MotionVertical
SLModifierBase_MotionVertical.name = "SLModifierBase_MotionVertical"
__TS__ClassExtends(SLModifierBase_MotionVertical, SLModifierBase)
return ____exports