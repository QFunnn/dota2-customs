--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_generic_flying_movement_upgrade = modifier_generic_flying_movement_upgrade or class({})


function modifier_generic_flying_movement_upgrade:IsHidden() return false end
function modifier_generic_flying_movement_upgrade:IsPurgable() return false end


function modifier_generic_flying_movement_upgrade:CheckState()
	return {
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
	}
end


function modifier_generic_flying_movement_upgrade:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_VISUAL_Z_DELTA, -- GetVisualZDelta
	}
end


function modifier_generic_flying_movement_upgrade:GetVisualZDelta()
	return 48
end


function modifier_generic_flying_movement_upgrade:GetEffectName()
	return "particles/econ/items/zeus/arcana_chariot/zeus_arcana_chariot.vpcf"
end


function modifier_generic_flying_movement_upgrade:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end