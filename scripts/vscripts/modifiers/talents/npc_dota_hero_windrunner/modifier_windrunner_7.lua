--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_windrunner_7=class({})

function modifier_windrunner_7:IsHidden() return true end
function modifier_windrunner_7:IsPurgable() return false end
function modifier_windrunner_7:IsPurgeException() return false end
function modifier_windrunner_7:RemoveOnDeath() return false end

function modifier_windrunner_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local windrunner_focusfire_whirlwind = self:GetCaster():FindAbilityByName("windrunner_focusfire_whirlwind")
    if windrunner_focusfire_whirlwind then
        windrunner_focusfire_whirlwind:SetHidden(false)
    end
end

function modifier_windrunner_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end