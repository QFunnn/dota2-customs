--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_boss_status_resist", "abilities/bosses/boss_status_resist", LUA_MODIFIER_MOTION_NONE)

boss_status_resist = class({})

function boss_status_resist:GetIntrinsicModifierName()
	return "modifier_boss_status_resist"
end

---------------------------------------------------------------------

modifier_boss_status_resist = class({})

function modifier_boss_status_resist:IsHidden()
	return true
end

function modifier_boss_status_resist:IsDebuff()
	return false
end

function modifier_boss_status_resist:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_STATUS_RESISTANCE,
	}
	return funcs
end

function modifier_boss_status_resist:GetModifierStatusResistance()
	return self:GetCaster():GetLevel()
end