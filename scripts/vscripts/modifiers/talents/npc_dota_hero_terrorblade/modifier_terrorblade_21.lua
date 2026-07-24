--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_terrorblade_21=class({})

function modifier_terrorblade_21:IsHidden() return true end
function modifier_terrorblade_21:IsPurgable() return false end
function modifier_terrorblade_21:IsPurgeException() return false end
function modifier_terrorblade_21:RemoveOnDeath() return false end

function modifier_terrorblade_21:OnCreated()
	if not IsServer() then return end
    self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis_transform")
    self:GetParent():RemoveModifierByName("modifier_custom_terrorblade_metamorphosis")
    self:Swap("terrorblade_metamorphosis_custom", "terrorblade_demon_hunter")
    local terrorblade_conjure_image_custom = self:GetParent():FindAbilityByName("terrorblade_conjure_image_custom")
    if terrorblade_conjure_image_custom then
        terrorblade_conjure_image_custom:SetLevel(0)
        terrorblade_conjure_image_custom:SetHidden(true)
    end
	self:SetStackCount(1)
	self:SetHasCustomTransmitterData(true)
	self:StartIntervalThink(FrameTime())
end

function modifier_terrorblade_21:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
end

function modifier_terrorblade_21:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_HEALTH_BONUS,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_terrorblade_21:AddCustomTransmitterData()
    return 
    {
        attackspeed = self.attackspeed,
    }
end

function modifier_terrorblade_21:HandleCustomTransmitterData( data )
    self.attackspeed = data.attackspeed
end

function modifier_terrorblade_21:OnIntervalThink()
	if not IsServer() then return end

	local strength = self:GetCaster():GetStrength()
	local agility = self:GetCaster():GetAgility()
	local intellect = self:GetCaster():GetIntellect(false)

	local remove_hp_str = (strength * 22) * -1
	local remove_at_agi = (agility * 1) * -1
	local add_hp_int = intellect * 16
	local add_at_int = intellect * 1

	self.health = add_hp_int + remove_hp_str
	self.attackspeed = add_at_int + remove_at_agi
	self:SendBuffRefreshToClients()
	self:GetCaster():CalculateStatBonus(true)
end


function modifier_terrorblade_21:GetModifierHealthBonus()
	return self.health
end

function modifier_terrorblade_21:GetModifierAttackSpeedBonus_Constant()
	return self.attackspeed
end

function modifier_terrorblade_21:Swap(name1, name2)
	if not IsServer() then return end
	local ability1 = self:GetParent():FindAbilityByName(name1)
	local ability2 = self:GetParent():FindAbilityByName(name2)
	ability1:SetHidden(true)
	ability2:SetHidden(true)
	self:GetParent():SwapAbilities(name1, name2, false, false)
end