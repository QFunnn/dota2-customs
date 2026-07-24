--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_weaver_4=class({})

function modifier_weaver_4:IsHidden() return true end
function modifier_weaver_4:IsPurgable() return false end
function modifier_weaver_4:IsPurgeException() return false end
function modifier_weaver_4:RemoveOnDeath() return false end

function modifier_weaver_4:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local weaver_weaver_snare = self:GetCaster():FindAbilityByName("weaver_weaver_snare")
    if weaver_weaver_snare then
        weaver_weaver_snare:SetLevel(self:GetStackCount())
        weaver_weaver_snare:SetHidden(false)
    end
end

function modifier_weaver_4:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local weaver_weaver_snare = self:GetCaster():FindAbilityByName("weaver_weaver_snare")
    if weaver_weaver_snare then
        weaver_weaver_snare:SetLevel(self:GetStackCount())
        weaver_weaver_snare:SetHidden(false)
    end
end