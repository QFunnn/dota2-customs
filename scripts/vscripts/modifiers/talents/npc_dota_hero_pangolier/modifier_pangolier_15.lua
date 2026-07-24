--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pangolier_15=class({})

function modifier_pangolier_15:IsHidden() return true end
function modifier_pangolier_15:IsPurgable() return false end
function modifier_pangolier_15:IsPurgeException() return false end
function modifier_pangolier_15:RemoveOnDeath() return false end

function modifier_pangolier_15:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_pangolier_15:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_pangolier_15:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
    }
end

function modifier_pangolier_15:GetModifierSpellAmplify_Percentage()
    return self:GetParent():GetManaRegen() / 5
end

function modifier_pangolier_15:GetModifierConstantManaRegen()
    return 5
end