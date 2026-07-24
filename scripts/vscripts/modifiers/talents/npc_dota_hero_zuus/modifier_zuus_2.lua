--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_zuus_2=class({})

function modifier_zuus_2:IsHidden() return true end
function modifier_zuus_2:IsPurgable() return false end
function modifier_zuus_2:IsPurgeException() return false end
function modifier_zuus_2:RemoveOnDeath() return false end

function modifier_zuus_2:OnCreated()
	self.bonus={20,40}
	if not IsServer() then return end
	self:SetStackCount(1)
    local zuus_arc_lightning_custom = self:GetParent():FindAbilityByName("zuus_arc_lightning_custom")
    if zuus_arc_lightning_custom then
        zuus_arc_lightning_custom:SetHidden(true)
        zuus_arc_lightning_custom:SetLevel(0)
    end
end

function modifier_zuus_2:OnRefresh()
	self.bonus={20,40}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_zuus_2:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_zuus_2:GetModifierAttackSpeedBonus_Constant()
	return self.bonus[self:GetStackCount()]
end