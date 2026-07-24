--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_vengefulspirit_21=class({})

function modifier_vengefulspirit_21:IsHidden() return true end
function modifier_vengefulspirit_21:IsPurgable() return false end
function modifier_vengefulspirit_21:IsPurgeException() return false end
function modifier_vengefulspirit_21:RemoveOnDeath() return false end

function modifier_vengefulspirit_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local vengefulspirit_magic_meteor = self:GetCaster():FindAbilityByName("vengefulspirit_magic_meteor")
	if vengefulspirit_magic_meteor then
		vengefulspirit_magic_meteor:SetLevel(1)
		vengefulspirit_magic_meteor:SetHidden(false)
	end
end

function modifier_vengefulspirit_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end