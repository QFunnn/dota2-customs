--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_nevermore_3=class({})

function modifier_nevermore_3:IsHidden() return true end
function modifier_nevermore_3:IsPurgable() return false end
function modifier_nevermore_3:IsPurgeException() return false end
function modifier_nevermore_3:RemoveOnDeath() return false end

function modifier_nevermore_3:OnCreated()
	self.bonus = {0.3,0.6,0.9}
	if not IsServer() then return end
	self:SetStackCount(1)
    local nevermore_frenzy_custom = self:GetParent():FindAbilityByName("nevermore_frenzy_custom")
    if nevermore_frenzy_custom then
        nevermore_frenzy_custom:SetHidden(true)
        nevermore_frenzy_custom:SetActivated(false)
    end
end

function modifier_nevermore_3:OnRefresh()
	self.bonus = {0.3,0.6,0.9}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    local nevermore_frenzy_custom = self:GetParent():FindAbilityByName("nevermore_frenzy_custom")
    if nevermore_frenzy_custom then
        nevermore_frenzy_custom:SetHidden(true)
        nevermore_frenzy_custom:SetActivated(false)
    end
end

function modifier_nevermore_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE
	}
end

function modifier_nevermore_3:GetModifierHealthRegenPercentage()
	return self.bonus[self:GetStackCount()]
end