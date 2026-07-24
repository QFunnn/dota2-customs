--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_techies_18=class({})

function modifier_techies_18:IsHidden() return true end
function modifier_techies_18:IsPurgable() return false end
function modifier_techies_18:IsPurgeException() return false end
function modifier_techies_18:RemoveOnDeath() return false end

function modifier_techies_18:OnCreated()
	if not IsServer() then return end
    self.bonus={300}
	self:SetStackCount(1)
    self:GetParent():CalculateStatBonus(true)
    Timers:CreateTimer(0.1, function()
        local techies_minefield_sign_custom = self:GetParent():FindAbilityByName("techies_minefield_sign_custom")
        if techies_minefield_sign_custom then
            techies_minefield_sign_custom:RefreshCharges()
        end
    end)
end

function modifier_techies_18:OnRefresh()
	if not IsServer() then return end
    self.bonus={300}
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_techies_18:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_BONUS
    }
end

function modifier_techies_18:GetModifierHealthBonus()
    return self.bonus[self:GetStackCount()]
end