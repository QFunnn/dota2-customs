--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_octar=class({})

function modifier_woda_talent_octar:IsHidden() return true end
function modifier_woda_talent_octar:IsPurgable() return false end
function modifier_woda_talent_octar:IsPurgeException() return false end
function modifier_woda_talent_octar:RemoveOnDeath() return false end

-- drow_ranger_marksmanship_custom ( тут уменьшать )

function modifier_woda_talent_octar:OnCreated()
	self.bonus={100,200}
	if not IsServer() then return end
	self:SetStackCount(1)
end

function modifier_woda_talent_octar:OnRefresh()
	self.bonus={100,200}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_woda_talent_octar:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_CAST_RANGE_BONUS_STACKING
	}
end

function modifier_woda_talent_octar:GetModifierCastRangeBonusStacking()
	return self.bonus[self:GetStackCount()]
end