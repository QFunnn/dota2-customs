--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_keeper_of_the_light_10=class({})

function modifier_keeper_of_the_light_10:IsHidden() return true end
function modifier_keeper_of_the_light_10:IsPurgable() return false end
function modifier_keeper_of_the_light_10:IsPurgeException() return false end
function modifier_keeper_of_the_light_10:RemoveOnDeath() return false end

function modifier_keeper_of_the_light_10:OnCreated()
    self.bonus2={100,200,300}
    self.bonus = {7,14,21}
    self.bonus_cooldown = 1
    self.bonus_cooldown_evasion = 10
	if not IsServer() then return end
    self.cooldown = 0
    self:SetHasCustomTransmitterData( true )
	self:SetStackCount(1)
    self:StartIntervalThink(0.1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_keeper_of_the_light_10:OnRefresh()
    self.bonus2={100,200,300}
    self.bonus = {7,14,21}
    self.bonus_cooldown = 1
    self.bonus_cooldown_evasion = 10
	if not IsServer() then return end
    self.cooldown = 0
	self:SetStackCount(self:GetStackCount() + 1)
    self:GetParent():CalculateStatBonus(true)
end

function modifier_keeper_of_the_light_10:OnIntervalThink()
	if not IsServer() then return end
	local evasion = (self:GetCaster():GetEvasion() * 100)
	self.cooldown = (evasion / self.bonus_cooldown_evasion) * self.bonus_cooldown
    self:SendBuffRefreshToClients()
end

function modifier_keeper_of_the_light_10:AddCustomTransmitterData()
    local data = 
    {
        cooldown = self.cooldown,
    }
    return data
end

function modifier_keeper_of_the_light_10:HandleCustomTransmitterData( data )
    self.cooldown = data.cooldown
end

function modifier_keeper_of_the_light_10:DeclareFunctions()
	return 
    {
		MODIFIER_PROPERTY_COOLDOWN_REDUCTION_CONSTANT,
        MODIFIER_PROPERTY_EVASION_CONSTANT,
        MODIFIER_PROPERTY_HEALTH_BONUS
	}
end

function modifier_keeper_of_the_light_10:GetModifierCooldownReduction_Constant(params)
	if params.ability and params.ability:GetName() == "keeper_of_the_light_light_illusion" then
        return self.cooldown
    end
end

function modifier_keeper_of_the_light_10:GetModifierEvasion_Constant()
    return self.bonus[self:GetStackCount()]
end

function modifier_keeper_of_the_light_10:GetModifierHealthBonus()
    return self.bonus2[self:GetStackCount()]
end