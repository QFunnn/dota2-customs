--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_chen_14=class({})

function modifier_chen_14:IsHidden() return true end
function modifier_chen_14:IsPurgable() return false end
function modifier_chen_14:IsPurgeException() return false end
function modifier_chen_14:RemoveOnDeath() return false end

function modifier_chen_14:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_chen_14:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_chen_14:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_STATS_AGILITY_BONUS
    }
end

function modifier_chen_14:GetModifierBonusStats_Agility()
    return 35
end