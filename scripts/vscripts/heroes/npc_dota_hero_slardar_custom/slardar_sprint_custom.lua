--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_slardar_sprint_custom", "heroes/npc_dota_hero_slardar_custom/slardar_sprint_custom", LUA_MODIFIER_MOTION_NONE )

slardar_sprint_custom = class({})

function slardar_sprint_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_slardar/slardar_sprint.vpcf", context )
end

slardar_sprint_custom.modifier_slardar_12 = {1,2,3}
slardar_sprint_custom.modifier_slardar_12_intellect = {10,20,30}

function slardar_sprint_custom:OnSpellStart()
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_slardar_12") then
        duration = duration + self.modifier_slardar_12[self:GetCaster():GetTalentLevel("modifier_slardar_12")]
    end
	self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_slardar_sprint_custom", { duration = duration } )
	self:GetCaster():EmitSound("Hero_Slardar.Sprint")
end

modifier_slardar_sprint_custom = class({})

function modifier_slardar_sprint_custom:IsPurgable() return not self:GetParent():HasModifier("modifier_slardar_13") end

function modifier_slardar_sprint_custom:OnCreated( kv )
    self.speed_burst_max_duration = self:GetAbility():GetSpecialValueFor("speed_burst_max_duration")
    self.slow_resistance_tooltip = self:GetAbility():GetSpecialValueFor("slow_resistance_tooltip")
	self.bonus_speed = self:GetAbility():GetSpecialValueFor("bonus_speed")
	if not IsServer() then return end
	self:GetParent():CalculateStatBonus(true)
end

function modifier_slardar_sprint_custom:OnRefresh( kv )
    self.speed_burst_max_duration = self:GetAbility():GetSpecialValueFor("speed_burst_max_duration")
    self.slow_resistance_tooltip = self:GetAbility():GetSpecialValueFor("slow_resistance_tooltip")
	self.bonus_speed = self:GetAbility():GetSpecialValueFor("bonus_speed")
	if not IsServer() then return end
end

function modifier_slardar_sprint_custom:DeclareFunctions()
	local funcs = 
	{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
	}
	return funcs
end

function modifier_slardar_sprint_custom:GetModifierBonusStats_Intellect()
    if self:GetCaster():HasModifier("modifier_slardar_12") then
        return self:GetAbility().modifier_slardar_12_intellect[self:GetCaster():GetTalentLevel("modifier_slardar_12")]
    end
    return 0
end

function modifier_slardar_sprint_custom:GetModifierSlowResistance_Stacking()
	local duration = self:GetDuration()
	local remaining = self:GetRemainingTime()
	local elapsed = duration - remaining
	if elapsed <= self.speed_burst_max_duration then
		return self.slow_resistance_tooltip
	end
	local fade_duration = duration - self.speed_burst_max_duration
	if fade_duration <= 0 then
		return 0
	end
	return self.slow_resistance_tooltip * (remaining / fade_duration)
end

function modifier_slardar_sprint_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.bonus_speed
end

function modifier_slardar_sprint_custom:CheckState()
	return
	{
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end

function modifier_slardar_sprint_custom:GetEffectName()
	return "particles/units/heroes/hero_slardar/slardar_sprint.vpcf"
end

function modifier_slardar_sprint_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end