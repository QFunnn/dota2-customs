--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_siltbreaker_model", "heroes/siltbreaker_model", LUA_MODIFIER_MOTION_NONE)

siltbreaker_model = class({})

function siltbreaker_model:GetIntrinsicModifierName()
	return "modifier_siltbreaker_model"
end

modifier_siltbreaker_model = class({})

function modifier_siltbreaker_model:IsHidden()
	return true
end

function modifier_siltbreaker_model:OnCreated()
	if not IsServer() then
		return
	end
	self:GetParent():SetMaterialGroup("2")
end