--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_phoenix_21=class({})

function modifier_phoenix_21:IsHidden() return true end
function modifier_phoenix_21:IsPurgable() return false end
function modifier_phoenix_21:IsPurgeException() return false end
function modifier_phoenix_21:RemoveOnDeath() return false end

function modifier_phoenix_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_phoenix_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_phoenix_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_phoenix_21:GetModifierTotalDamageOutgoing_Percentage(params)
    if params.target and params.target:IsStunned() then
        return 60
    end
end