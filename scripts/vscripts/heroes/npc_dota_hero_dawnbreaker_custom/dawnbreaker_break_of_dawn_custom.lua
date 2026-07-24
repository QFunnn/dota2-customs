--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_dawnbreaker_break_of_dawn_custom", "heroes/npc_dota_hero_dawnbreaker_custom/dawnbreaker_break_of_dawn_custom", LUA_MODIFIER_MOTION_NONE)

dawnbreaker_break_of_dawn_custom = class({})

function dawnbreaker_break_of_dawn_custom:GetIntrinsicModifierName()
    return "modifier_dawnbreaker_break_of_dawn_custom"
end

modifier_dawnbreaker_break_of_dawn_custom = class({})
function modifier_dawnbreaker_break_of_dawn_custom:IsHidden() return true end
function modifier_dawnbreaker_break_of_dawn_custom:IsPurgable() return false end
function modifier_dawnbreaker_break_of_dawn_custom:IsPurgeException() return false end
function modifier_dawnbreaker_break_of_dawn_custom:RemoveOnDeath() return false end

function modifier_dawnbreaker_break_of_dawn_custom:OnCreated()
    self.max_dmg_pct = self:GetAbility():GetSpecialValueFor("max_dmg_pct")
    self.max_vision_pct = self:GetAbility():GetSpecialValueFor("max_vision_pct")
    if not IsServer() then return end
    self.max_damage = 0
    self.max_vision = 0
    self:SetHasCustomTransmitterData( true )
end

function modifier_dawnbreaker_break_of_dawn_custom:OnRefresh()
    self.max_dmg_pct = self:GetAbility():GetSpecialValueFor("max_dmg_pct")
    self.max_vision_pct = self:GetAbility():GetSpecialValueFor("max_vision_pct")
    if not IsServer() then return end
    self.max_damage = 0
    self.max_vision = 0
    self:StartIntervalThink(1)
end

function modifier_dawnbreaker_break_of_dawn_custom:OnIntervalThink()
    if not IsServer() then return end
    if GameRules:IsDaytime() then
        self.max_damage = self.max_dmg_pct
        self.max_vision = self.max_vision_pct
    else
        self.max_damage = 0
        self.max_vision = 0
    end
    print("current bonus", self.max_damage, self.max_vision)
    self:SendBuffRefreshToClients()
end

function modifier_dawnbreaker_break_of_dawn_custom:AddCustomTransmitterData()
	local data = 
    {
		max_damage = self.max_damage,
		max_vision = self.max_vision
	}
	return data
end

function modifier_dawnbreaker_break_of_dawn_custom:HandleCustomTransmitterData( data )
	self.max_damage = data.max_damage
	self.max_vision = data.max_vision
end

function modifier_dawnbreaker_break_of_dawn_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_BONUS_DAY_VISION_PERCENTAGE,
    }
end

function modifier_dawnbreaker_break_of_dawn_custom:GetModifierDamageOutgoing_Percentage()
    return self.max_damage
end

function modifier_dawnbreaker_break_of_dawn_custom:GetModifierBonusDayVisionPercentage()
    return self.max_vision
end