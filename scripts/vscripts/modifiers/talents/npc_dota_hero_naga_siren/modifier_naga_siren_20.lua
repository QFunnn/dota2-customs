--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_naga_siren_20=class({})

function modifier_naga_siren_20:IsHidden() return true end
function modifier_naga_siren_20:IsPurgable() return false end
function modifier_naga_siren_20:IsPurgeException() return false end
function modifier_naga_siren_20:RemoveOnDeath() return false end

function modifier_naga_siren_20:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_naga_siren_20:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_naga_siren_20:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_naga_siren_20:GetModifierSpellAmplify_Percentage()
    local count = math.min(self:GetParent():GetIntellect(false), 600) / 12
    return count
end