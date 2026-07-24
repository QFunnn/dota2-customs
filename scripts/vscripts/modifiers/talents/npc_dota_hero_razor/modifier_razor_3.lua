--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_razor_3=class({})

function modifier_razor_3:IsHidden() return true end
function modifier_razor_3:IsPurgable() return false end
function modifier_razor_3:IsPurgeException() return false end
function modifier_razor_3:RemoveOnDeath() return false end

function modifier_razor_3:OnCreated()
	self.bonus = 1
    self.bonus_2 = {15, 10}
	if not IsServer() then return end
	self:SetStackCount(1)
    self:SetHasCustomTransmitterData( true )
    self:StartIntervalThink(0.1)
end

function modifier_razor_3:OnIntervalThink()
    if not IsServer() then return end
    self.hero_damage = self:GetParent():GetAverageTrueAttackDamage(nil)
    self:SendBuffRefreshToClients()
end

function modifier_razor_3:OnRefresh()
	self.bonus = 1
    self.bonus_2 = {15, 10}
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_razor_3:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
	}
end

function modifier_razor_3:GetModifierSpellAmplify_Percentage()
	return self.bonus * (self.hero_damage / self.bonus_2[self:GetStackCount()])
end

function modifier_razor_3:AddCustomTransmitterData()
	local data = 
    {
		hero_damage = self.hero_damage,
	}
	return data
end

function modifier_razor_3:HandleCustomTransmitterData( data )
	self.hero_damage = data.hero_damage
end