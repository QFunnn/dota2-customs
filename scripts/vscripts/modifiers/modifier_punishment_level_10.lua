--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


modifier_punishment_level_10 = modifier_punishment_level_10 or class({})

function modifier_punishment_level_10:IsHidden()
	return false
end
function modifier_punishment_level_10:IsPurgable()
	return false
end
function modifier_punishment_level_10:RemoveOnDeath()
	return false
end
function modifier_punishment_level_10:GetPriority()
	return 99999
end
function modifier_punishment_level_10:GetAttributes()
	return MODIFIER_ATTRIBUTE_PERMANENT + MODIFIER_ATTRIBUTE_IGNORE_INVULNERABLE + MODIFIER_ATTRIBUTE_IGNORE_DODGE
end

function modifier_punishment_level_10:CheckState()
	return {
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_UNSELECTABLE] = true,
		[MODIFIER_STATE_LOW_ATTACK_PRIORITY] = true,
		[MODIFIER_STATE_BLIND] = true,
		[MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
		[MODIFIER_STATE_PASSIVES_DISABLED] = true,
		[MODIFIER_STATE_OUT_OF_GAME] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_ROOTED] = true,
		[MODIFIER_STATE_CANNOT_BE_MOTION_CONTROLLED] = true,
	}
end

function modifier_punishment_level_10:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_punishment_level_10:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end

function modifier_punishment_level_10:GetModifierModelChange()
	return "models/props_gameplay/rat_balloon.vmdl"
end

function modifier_punishment_level_10:GetModifierModelScale()
	return 60
end