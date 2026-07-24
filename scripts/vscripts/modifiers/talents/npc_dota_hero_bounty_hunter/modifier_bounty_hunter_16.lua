--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_bounty_hunter_16_active", "modifiers/talents/npc_dota_hero_bounty_hunter/modifier_bounty_hunter_16", LUA_MODIFIER_MOTION_NONE)

modifier_bounty_hunter_16=class({})

function modifier_bounty_hunter_16:IsHidden() return true end
function modifier_bounty_hunter_16:IsPurgable() return false end
function modifier_bounty_hunter_16:IsPurgeException() return false end
function modifier_bounty_hunter_16:RemoveOnDeath() return false end

function modifier_bounty_hunter_16:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_bounty_hunter_16:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end