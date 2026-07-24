--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_death_prophet_7=class({})

function modifier_death_prophet_7:IsHidden() return false end
function modifier_death_prophet_7:IsPurgable() return false end
function modifier_death_prophet_7:IsPurgeException() return false end
function modifier_death_prophet_7:RemoveOnDeath() return false end

function modifier_death_prophet_7:OnCreated()
	if not IsServer() then return end
	self:SetStackCount(1)
	self.count = 0
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(FrameTime())
end

function modifier_death_prophet_7:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_death_prophet_7:OnIntervalThink()
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
	if count > 5 then
		self:GetCaster():CalculateStatBonus(true)
	end
	self:SendBuffRefreshToClients()
end

function modifier_death_prophet_7:AddCustomTransmitterData()
    return 
    {
        count = self.count,
    }
end

function modifier_death_prophet_7:HandleCustomTransmitterData( data )
    self.count = data.count
end

function modifier_death_prophet_7:DeclareFunctions()
	return 
	{
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
	}
end

function modifier_death_prophet_7:GetModifierBonusStats_Strength()
	if self.count ~= nil and self.count >= 5 then
		return 25
	end
end

function modifier_death_prophet_7:GetModifierBonusStats_Agility()
	if self.count ~= nil and self.count >= 5 then
		return 25
	end
end

function modifier_death_prophet_7:GetModifierBonusStats_Intellect()
	if self.count ~= nil and self.count >= 5 then
		return 25
	end
end

function modifier_death_prophet_7:GetModifierMoveSpeedBonus_Percentage()
	if self.count ~= nil and self.count >= 3 then
		return 25
	end
end

function modifier_death_prophet_7:CheckState()
	if not IsServer() then return end
	local state = 
	{
		
	}
	if self.count ~= nil and self.count >= 3 then
		state = 
		{
			[MODIFIER_STATE_FORCED_FLYING_VISION] = true,
			[MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
		}
	end
	return state
end

function modifier_death_prophet_7:GetTexture()
	return "death_prophet_7"
end