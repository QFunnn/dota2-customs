--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_woda_talent_agi6=class({})

function modifier_woda_talent_agi6:IsHidden() return true end
function modifier_woda_talent_agi6:IsPurgable() return false end
function modifier_woda_talent_agi6:IsPurgeException() return false end
function modifier_woda_talent_agi6:RemoveOnDeath() return false end

function modifier_woda_talent_agi6:OnCreated()
	self.bonus={0.5}
	if not IsServer() then return end
    if not self:GetParent().RealAttribute then
        self:GetParent().RealAttribute = self:GetParent():GetPrimaryAttribute()
    end
    self.attribute_damage = 0
	if self:GetParent():HasModifier("modifier_woda_talent_str6") and self:GetParent():HasModifier("modifier_woda_talent_int6") then
		self:GetParent():SetPrimaryAttribute(DOTA_ATTRIBUTE_ALL)
        self:GetParent().SetAttribute = DOTA_ATTRIBUTE_ALL
        if self:GetParent():IsRealHero() then
            player_system:PlayerQuestProgress(self:GetParent():GetPlayerOwnerID(), 81, 1)
            player_system:PlayerQuestProgress(self:GetParent():GetPlayerOwnerID(), 82, 1)
        end
        self.attribute_damage = 0.05
	else
        self:GetParent():SetPrimaryAttribute(DOTA_ATTRIBUTE_AGILITY)
        self:GetParent().SetAttribute = DOTA_ATTRIBUTE_AGILITY
        if self:GetParent():IsRealHero() then
            player_system:PlayerQuestProgress(self:GetParent():GetPlayerOwnerID(), 81, 1)
            player_system:PlayerQuestProgress(self:GetParent():GetPlayerOwnerID(), 82, 1)
        end
    end
	self:SetStackCount(1)
	self:GetParent():CalculateStatBonus(true)
    self:SetHasCustomTransmitterData( true )
end

function modifier_woda_talent_agi6:OnRefresh()
	self.bonus={0.5}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
	self:GetParent():CalculateStatBonus(true)
end

function modifier_woda_talent_agi6:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
        MODIFIER_PROPERTY_BASEATTACK_BONUSDAMAGE,
        MODIFIER_EVENT_ON_RESPAWN
	}
end

function modifier_woda_talent_agi6:OnRespawn(event)
    if not IsServer() then return end
    if event.unit == self:GetParent() then
        self:GetParent():SetPrimaryAttribute(self:GetParent().RealAttribute)
        Timers:CreateTimer(0.1, function()
            if self:GetParent():HasModifier("modifier_woda_talent_str6") and self:GetParent():HasModifier("modifier_woda_talent_int6") then
                self:GetParent():SetPrimaryAttribute(DOTA_ATTRIBUTE_ALL)
                self:GetParent().SetAttribute = DOTA_ATTRIBUTE_ALL
            else
                if self:GetParent().SetAttribute then
                    self:GetParent():SetPrimaryAttribute(self:GetParent().SetAttribute)
                else
                    self:GetParent():SetPrimaryAttribute(DOTA_ATTRIBUTE_AGILITY)
                end
            end
            self:GetParent():CalculateStatBonus(true)
        end)
    end
end

function modifier_woda_talent_agi6:GetModifierBaseAttack_BonusDamage()
    if self:GetParent():HasModifier("modifier_woda_talent_str6") and self:GetParent():HasModifier("modifier_woda_talent_int6") then
        return self.attribute_damage * (self:GetParent():GetStrength() + self:GetParent():GetAgility() + self:GetParent():GetIntellect(false))
    end
end

function modifier_woda_talent_agi6:GetModifierBonusStats_Agility()
	return self.bonus[self:GetStackCount()] * self:GetParent():GetLevel()
end

function modifier_woda_talent_agi6:AddCustomTransmitterData()
	local data = 
    {
		attribute_damage = self.attribute_damage,
	}
	return data
end

function modifier_woda_talent_agi6:HandleCustomTransmitterData( data )
	self.attribute_damage = data.attribute_damage
end