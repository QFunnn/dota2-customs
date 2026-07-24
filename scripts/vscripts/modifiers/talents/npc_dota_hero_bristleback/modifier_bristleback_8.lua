--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_bristleback_8=class({})

function modifier_bristleback_8:IsHidden() return true end
function modifier_bristleback_8:IsPurgable() return false end
function modifier_bristleback_8:IsPurgeException() return false end
function modifier_bristleback_8:RemoveOnDeath() return false end

function modifier_bristleback_8:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	local bristleback_quill_spray_custom = self:GetCaster():FindAbilityByName("bristleback_quill_spray_custom")
	if bristleback_quill_spray_custom then
		bristleback_quill_spray_custom:SetHidden(true)
		bristleback_quill_spray_custom:SetLevel(0)
	end
end

function modifier_bristleback_8:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	local bristleback_quill_spray_custom = self:GetCaster():FindAbilityByName("bristleback_quill_spray_custom")
	if bristleback_quill_spray_custom then
		bristleback_quill_spray_custom:SetHidden(true)
		bristleback_quill_spray_custom:SetLevel(0)
	end
end