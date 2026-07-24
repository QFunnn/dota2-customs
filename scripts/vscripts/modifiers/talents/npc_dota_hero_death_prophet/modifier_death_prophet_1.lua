--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_death_prophet_1=class({})

function modifier_death_prophet_1:IsHidden() return false end
function modifier_death_prophet_1:IsPurgable() return false end
function modifier_death_prophet_1:IsPurgeException() return false end
function modifier_death_prophet_1:RemoveOnDeath() return false end

function modifier_death_prophet_1:OnCreated()
	if not IsServer() then return end
	self.count = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)

	local death_prophet_carrion_swarm_custom = self:GetParent():FindAbilityByName("death_prophet_carrion_swarm_custom")
	if death_prophet_carrion_swarm_custom then
		death_prophet_carrion_swarm_custom:SetActivated(false)
		death_prophet_carrion_swarm_custom:SetHidden(true)
	end
	
	local death_prophet_exorcism_custom = self:GetParent():FindAbilityByName("death_prophet_exorcism_custom")
	if death_prophet_exorcism_custom then
		death_prophet_exorcism_custom:SetActivated(false)
		death_prophet_exorcism_custom:SetHidden(true)
	end

	local death_prophet_silence_custom = self:GetParent():FindAbilityByName("death_prophet_silence_custom")
	if death_prophet_silence_custom then
		death_prophet_silence_custom:SetActivated(false)
		death_prophet_silence_custom:SetHidden(true)
	end

	local death_prophet_spirit_siphon_custom = self:GetParent():FindAbilityByName("death_prophet_spirit_siphon_custom")
	if death_prophet_spirit_siphon_custom then
		death_prophet_spirit_siphon_custom:SetActivated(false)
		death_prophet_spirit_siphon_custom:SetHidden(true)
	end

	local modifier_death_prophet_exorcism_custom = self:GetCaster():FindModifierByName("modifier_death_prophet_exorcism_custom")
	if modifier_death_prophet_exorcism_custom then
		modifier_death_prophet_exorcism_custom:DeleteSpirits()
	end

	self:GetParent():RemoveModifierByName("modifier_death_prophet_exorcism_custom")
	self:GetParent():RemoveModifierByName("modifier_death_prophet_spirit_siphon_custom")
end

function modifier_death_prophet_1:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_death_prophet_1:OnIntervalThink()
	if not IsServer() then return end
	local count = 0
	if self:GetParent():HasModifier("modifier_death_prophet_2_aura") then
		count = count + 1
	end
	if self:GetParent():HasModifier("modifier_death_prophet_3_aura") then
		count = count + 1
	end
	if self:GetParent():HasModifier("modifier_death_prophet_4_aura") then
		count = count + 1
	end
	if self:GetParent():HasModifier("modifier_death_prophet_5_aura") then
		count = count + 1
	end
	if self:GetParent():HasModifier("modifier_death_prophet_6_aura") then
		count = count + 1
	end
	self.count = count
end

function modifier_death_prophet_1:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
	}
end

function modifier_death_prophet_1:GetModifierBonusStats_Strength()
	return 10
end

function modifier_death_prophet_1:GetModifierBonusStats_Agility()
	return 10
end

function modifier_death_prophet_1:GetModifierBonusStats_Intellect()
	return 10
end

function modifier_death_prophet_1:GetModifierTotalDamageOutgoing_Percentage()
	local bonus = {3,6,9}
	return bonus[self:GetStackCount()] * self.count
end

function modifier_death_prophet_1:GetTexture()
	return "death_prophet_1"
end