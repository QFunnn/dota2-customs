--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_pangolier_21=class({})

function modifier_pangolier_21:IsHidden() return true end
function modifier_pangolier_21:IsPurgable() return false end
function modifier_pangolier_21:IsPurgeException() return false end
function modifier_pangolier_21:RemoveOnDeath() return false end

function modifier_pangolier_21:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_pangolier_21:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end

function modifier_pangolier_21:GetModifierConstantHealthRegen()
    return self:GetParent():GetManaRegen()
end