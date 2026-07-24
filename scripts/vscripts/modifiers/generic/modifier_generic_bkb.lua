--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]



modifier_generic_bkb = class({})

function modifier_generic_bkb:IsHidden() return false end
function modifier_generic_bkb:GetTexture() return "buffs/press_root" end
function modifier_generic_bkb:IsPurgable() return false end 
function modifier_generic_bkb:GetEffectName() return "particles/items_fx/black_king_bar_avatar.vpcf" end
function modifier_generic_bkb:CheckState() return {[MODIFIER_STATE_MAGIC_IMMUNE] = true} end
