--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_woda_neutral_self_purge", "neutrals/woda_neutral_self_purge", LUA_MODIFIER_MOTION_NONE)

woda_neutral_self_purge = class({})

function woda_neutral_self_purge:GetIntrinsicModifierName()
	return "modifier_woda_neutral_self_purge"
end

modifier_woda_neutral_self_purge = class({})
function modifier_woda_neutral_self_purge:IsHidden() return true end
function modifier_woda_neutral_self_purge:IsPurgable() return false end
function modifier_woda_neutral_self_purge:IsPurgeException() return false end
function modifier_woda_neutral_self_purge:OnCreated()
	if not IsServer() then return end
	self:StartIntervalThink(10)
end
function modifier_woda_neutral_self_purge:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():Purge(false, true, false, true, true)
end