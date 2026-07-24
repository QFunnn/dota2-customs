--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_neutral_cast = class({})

function modifier_neutral_cast:IsHidden() return true end
function modifier_neutral_cast:IsPurgable() return false end

function modifier_neutral_cast:CheckState() 
	return 
	{
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_ROOTED] = true 
	}
end


function modifier_neutral_cast:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_DISABLE_TURNING
	}
end

function modifier_neutral_cast:GetModifierDisableTurning() 
	return 1
end 