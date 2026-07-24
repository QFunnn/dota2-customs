--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_loser_curse = class({}) ---@class modifier_loser_curse : CDOTA_Modifier_Lua

CURSE_DEBUFF_VALUE = 10

function modifier_loser_curse:GetTexture()
	return "necrolyte/apostle_of_decay_icons/necrolyte_death_pulse"
end

function modifier_loser_curse:IsHidden()
	return false
end

function modifier_loser_curse:IsDebuff()
	return true
end

function modifier_loser_curse:IsPurgable()
	return false
end

function modifier_loser_curse:IsPurgeException()
	return false
end

function modifier_loser_curse:IsPermanent()
	return true
end

function modifier_loser_curse:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
end

function modifier_loser_curse:OnCreated(params)
	if IsServer() then
		self:SetStackCount(1)
	end
end

function modifier_loser_curse:OnRefresh(params)
	if IsServer() then
		self:SetStackCount(self:GetStackCount() + (params.stack or 1))
	end
end

function modifier_loser_curse:GetModifierIncomingDamage_Percentage(params)
	if true == self:GetParent().bJoiningPvp then
		return 0
	else
		return CURSE_DEBUFF_VALUE * self:GetStackCount()
	end
end

function modifier_loser_curse:GetModifierTotalDamageOutgoing_Percentage(params)
	local hParent = self:GetParent()
	if not hParent:HasModifier("modifier_item_aeon_disk_lua_buff") then
		if true == self:GetParent().bJoiningPvp then
			return 0
		else
			return -CURSE_DEBUFF_VALUE * self:GetStackCount()
		end
	end
end

function modifier_loser_curse:GetModifierBonusStats_Strength(params)
	if true == self:GetParent().bJoiningPvp then
		return 0
	else
		return -CURSE_DEBUFF_VALUE / 100 * self:GetStackCount() * self:GetParent():GetBaseStrength()
	end
end

function modifier_loser_curse:GetModifierBonusStats_Agility(params)
	if true == self:GetParent().bJoiningPvp then
		return 0
	else
		return -CURSE_DEBUFF_VALUE / 100 * self:GetStackCount() * self:GetParent():GetBaseAgility()
	end
end

function modifier_loser_curse:GetModifierBonusStats_Intellect(params)
	if true == self:GetParent().bJoiningPvp then
		return 0
	else
		return -CURSE_DEBUFF_VALUE / 100 * self:GetStackCount() * self:GetParent():GetBaseIntellect()
	end
end