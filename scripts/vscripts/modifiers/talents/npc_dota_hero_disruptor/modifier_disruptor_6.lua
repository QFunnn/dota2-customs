--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua.lua", LUA_MODIFIER_MOTION_BOTH )

modifier_disruptor_6=class({})

function modifier_disruptor_6:IsHidden() return true end
function modifier_disruptor_6:IsPurgable() return false end
function modifier_disruptor_6:IsPurgeException() return false end
function modifier_disruptor_6:RemoveOnDeath() return false end

function modifier_disruptor_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_disruptor_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end