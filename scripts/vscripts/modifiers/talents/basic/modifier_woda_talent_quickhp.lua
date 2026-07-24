--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_quickhp=class({})

function modifier_woda_talent_quickhp:IsHidden() return true end
function modifier_woda_talent_quickhp:IsPurgable() return false end
function modifier_woda_talent_quickhp:IsPurgeException() return false end
function modifier_woda_talent_quickhp:RemoveOnDeath() return false end

function modifier_woda_talent_quickhp:OnCreated()
	--self.bonus={7,14}
	self.bonus2 = {-4,-8}
	if not IsServer() then return end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_quickhp:OnRefresh()
	--self.bonus={7,14}
	self.bonus2 = {-4,-8}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_quickhp:DeclareFunctions()
	return
	{
		--MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
	}
end

--function modifier_woda_talent_quickhp:GetModifierHPRegenAmplify_Percentage()
--	return self.bonus[self:GetStackCount()]
--end

function modifier_woda_talent_quickhp:GetModifierIncomingDamage_Percentage(params)
    if params.attacker and params.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK then
        return self.bonus2[self:GetStackCount()]
    end
end