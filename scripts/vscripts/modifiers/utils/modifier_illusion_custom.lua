--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-05 05:42:45 UTC
  ~ auto-generated — do not edit
]]


modifier_illusion_custom = class({})
function modifier_illusion_custom:IsPurgable()
	return false
end
function modifier_illusion_custom:IsPurgeException()
	return false
end
function modifier_illusion_custom:IsHidden()
	return true
end
function modifier_illusion_custom:RemoveOnDeath()
	return false
end
function modifier_illusion_custom:GetStatusEffectName()
	if self:GetParent():HasModifier("modifier_status_effect_thinker_custom") then
		return
	end
	if self:GetParent():GetTeamNumber() ~= GetLocalPlayerTeam(GetLocalPlayerID()) then
		return
	end
	return "particles/status_fx/status_effect_illusion.vpcf"
end
function modifier_illusion_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_SUPER_ULTRA
end