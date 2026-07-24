--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_treasure_courier = modifier_treasure_courier or class({})


function modifier_treasure_courier:IsHidden() return true end
function modifier_treasure_courier:IsPurgable() return false end


function modifier_treasure_courier:CheckState()
	return {
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_ATTACK_IMMUNE] = true,
		[MODIFIER_STATE_MAGIC_IMMUNE] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_PROVIDES_VISION] = true,
	}
end


function modifier_treasure_courier:GetEffectName()
	return "particles/items_fx/black_king_bar_avatar.vpcf"
end


function modifier_treasure_courier:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end


function modifier_treasure_courier:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROVIDES_FOW_POSITION
	}
end


function modifier_treasure_courier:GetModifierProvidesFOWVision()
	return 1
end