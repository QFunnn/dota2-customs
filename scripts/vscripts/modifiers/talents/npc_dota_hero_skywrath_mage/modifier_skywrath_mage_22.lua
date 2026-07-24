--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skywrath_mage_22=class({})

function modifier_skywrath_mage_22:IsHidden() return true end
function modifier_skywrath_mage_22:IsPurgable() return false end
function modifier_skywrath_mage_22:IsPurgeException() return false end
function modifier_skywrath_mage_22:RemoveOnDeath() return false end

function modifier_skywrath_mage_22:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_skywrath_mage_22:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_skywrath_mage_22:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
	}
end

function modifier_skywrath_mage_22:GetModifierCastRangeBonusStacking()
	return 150
end