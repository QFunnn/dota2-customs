--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


modifier_skeleton_king_2=class({})

function modifier_skeleton_king_2:IsHidden() return true end
function modifier_skeleton_king_2:IsPurgable() return false end
function modifier_skeleton_king_2:IsPurgeException() return false end
function modifier_skeleton_king_2:RemoveOnDeath() return false end

function modifier_skeleton_king_2:OnCreated()
	if not IsServer() then return end
	self:SetHasCustomTransmitterData(true)
	self.attack_speed = 0
	self:SetStackCount(1)
	self:StartIntervalThink(0.1)
    local skeleton_king_vampiric_aura_custom = self:GetParent():FindAbilityByName("skeleton_king_vampiric_aura_custom")
    if skeleton_king_vampiric_aura_custom then
        skeleton_king_vampiric_aura_custom:SetLevel(0)
        skeleton_king_vampiric_aura_custom:SetHidden(true)
        skeleton_king_vampiric_aura_custom:SetActivated(false)
    end
end

function modifier_skeleton_king_2:OnRefresh()
	if not IsServer() then return end
	self:SetStackCount(self:GetStackCount() + 1)
    self:SendBuffRefreshToClients()
    local skeleton_king_vampiric_aura_custom = self:GetParent():FindAbilityByName("skeleton_king_vampiric_aura_custom")
    if skeleton_king_vampiric_aura_custom then
        skeleton_king_vampiric_aura_custom:SetLevel(0)
        skeleton_king_vampiric_aura_custom:SetHidden(true)
        skeleton_king_vampiric_aura_custom:SetActivated(false)
    end
end

function modifier_skeleton_king_2:OnIntervalThink()
	if not IsServer() then return end
	self.attack_speed = self:GetParent():GetHealthRegen()
	self:SendBuffRefreshToClients()
end

function modifier_skeleton_king_2:AddCustomTransmitterData()
    return {
        attack_speed = self.attack_speed,
    }
end

function modifier_skeleton_king_2:HandleCustomTransmitterData( data )
    self.attack_speed = data.attack_speed
end

function modifier_skeleton_king_2:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_skeleton_king_2:GetModifierAttackSpeedBonus_Constant()
    return self.attack_speed
end