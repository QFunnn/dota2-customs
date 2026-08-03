--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 22:18:26 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_bkb_visual = class({})

function modifier_generic_bkb_visual:IsHidden()
	return false
end
function modifier_generic_bkb_visual:GetTexture()
	return "buffs/press_root"
end
function modifier_generic_bkb_visual:IsPurgable()
	return false
end
function modifier_generic_bkb_visual:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end
function modifier_generic_bkb_visual:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_generic_bkb_visual:GetModifierModelScale()
	return 15
end