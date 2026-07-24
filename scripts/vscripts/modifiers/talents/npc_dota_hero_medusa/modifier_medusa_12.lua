--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_medusa_12=class({})

function modifier_medusa_12:IsHidden() return true end
function modifier_medusa_12:IsPurgable() return false end
function modifier_medusa_12:IsPurgeException() return false end
function modifier_medusa_12:RemoveOnDeath() return false end

function modifier_medusa_12:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    local medusa_stone_ability = self:GetCaster():FindAbilityByName("medusa_stone_ability")
    if medusa_stone_ability then
        medusa_stone_ability:SetLevel(1)
        medusa_stone_ability:SetHidden(false)
    end
end

function modifier_medusa_12:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end