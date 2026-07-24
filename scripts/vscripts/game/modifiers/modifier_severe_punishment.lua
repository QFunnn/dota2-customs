--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_severe_punishment = modifier_severe_punishment or class({})


function modifier_severe_punishment:IsPurgable() return false end
function modifier_severe_punishment:RemoveOnDeath() return false end
function modifier_severe_punishment:GetPriority() return 10000 end

function modifier_severe_punishment:CheckState()
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
	}
end


function modifier_severe_punishment:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_MODEL_CHANGE,
		MODIFIER_PROPERTY_MODEL_SCALE
	}
end


function modifier_severe_punishment:GetModifierTotalDamageOutgoing_Percentage()
	return -100
end


function modifier_severe_punishment:GetModifierModelChange()
	return "models/props_gameplay/rat_balloon.vmdl"
end


function modifier_severe_punishment:GetModifierModelScale()
    return 60
end