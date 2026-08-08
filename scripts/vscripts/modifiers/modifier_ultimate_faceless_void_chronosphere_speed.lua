--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 5a808f3 · 2026-08-08 04:09:05 UTC
  ~ auto-generated — do not edit
]]


modifier_ultimate_faceless_void_chronosphere_speed = class({})

function modifier_ultimate_faceless_void_chronosphere_speed:IsHidden()
	return true
end
function modifier_ultimate_faceless_void_chronosphere_speed:IsPurgable()
	return false
end

function modifier_ultimate_faceless_void_chronosphere_speed:OnCreated(kv)
	self.move_speed = tonumber(kv and kv.move_speed) or 1000
end

function modifier_ultimate_faceless_void_chronosphere_speed:OnRefresh(kv)
	self.move_speed = tonumber(kv and kv.move_speed) or self.move_speed or 1000
end

function modifier_ultimate_faceless_void_chronosphere_speed:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE_MIN,
	}
end

function modifier_ultimate_faceless_void_chronosphere_speed:GetModifierMoveSpeed_AbsoluteMin()
	return self.move_speed or 1000
end