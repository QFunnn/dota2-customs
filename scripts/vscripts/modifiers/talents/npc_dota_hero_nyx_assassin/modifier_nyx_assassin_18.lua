--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-04 05:43:48 UTC
  ~ auto-generated — do not edit
]]


modifier_nyx_assassin_18 = class({})

function modifier_nyx_assassin_18:IsHidden()
	return true
end
function modifier_nyx_assassin_18:IsPurgable()
	return false
end
function modifier_nyx_assassin_18:IsPurgeException()
	return false
end
function modifier_nyx_assassin_18:RemoveOnDeath()
	return false
end

function modifier_nyx_assassin_18:OnCreated()
	if not IsServer() then
		return
	end
	self:SetStackCount(1)
end

function modifier_nyx_assassin_18:OnRefresh()
	if not IsServer() then
		return
	end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_nyx_assassin_18:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_BONUS_DAY_VISION,
		MODIFIER_PROPERTY_BONUS_NIGHT_VISION,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
	}
end

function modifier_nyx_assassin_18:GetModifierIncomingDamage_Percentage()
	return -4
end

function modifier_nyx_assassin_18:GetBonusDayVision()
	return 200
end

function modifier_nyx_assassin_18:GetBonusNightVision()
	return 300
end