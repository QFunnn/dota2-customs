--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_tinker_6=class({})

function modifier_tinker_6:IsHidden() return true end
function modifier_tinker_6:IsPurgable() return false end
function modifier_tinker_6:IsPurgeException() return false end
function modifier_tinker_6:RemoveOnDeath() return false end

function modifier_tinker_6:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_tinker_6:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetCaster():CalculateStatBonus(true)
end

function modifier_tinker_6:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
    }
end

function modifier_tinker_6:GetModifierSpellAmplify_Percentage(params)
    local strength = math.min(self:GetCaster():GetStrength(), 600)
    local bonus = strength / 12 * 1
    return bonus
end