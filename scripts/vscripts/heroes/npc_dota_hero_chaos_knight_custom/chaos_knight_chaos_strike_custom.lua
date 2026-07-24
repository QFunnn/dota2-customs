--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_chaos_knight_chaos_strike_custom", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_chaos_strike_custom", LUA_MODIFIER_MOTION_NONE )

chaos_knight_chaos_strike_custom = class({})
chaos_knight_chaos_strike_custom.modifier_chaos_knight_5 = {10,20}
chaos_knight_chaos_strike_custom.modifier_chaos_knight_6_health = 20 
chaos_knight_chaos_strike_custom.modifier_chaos_knight_6 = {11.11,22.22,33.33}

function chaos_knight_chaos_strike_custom:GetIntrinsicModifierName()
	return "modifier_chaos_knight_chaos_strike_custom"
end

modifier_chaos_knight_chaos_strike_custom = class({})
function modifier_chaos_knight_chaos_strike_custom:IsHidden() return true end
function modifier_chaos_knight_chaos_strike_custom:IsPurgable() return false end
function modifier_chaos_knight_chaos_strike_custom:IsPurgeException() return false end
function modifier_chaos_knight_chaos_strike_custom:RemoveOnDeath() return false end

function modifier_chaos_knight_chaos_strike_custom:OnCreated( kv )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.crit_min = self:GetAbility():GetSpecialValueFor( "crit_min" )
    self.crit_max = self:GetAbility():GetSpecialValueFor("crit_max")
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" )
end

function modifier_chaos_knight_chaos_strike_custom:OnRefresh( kv )
	self.chance = self:GetAbility():GetSpecialValueFor( "chance" )
	self.crit_min = self:GetAbility():GetSpecialValueFor( "crit_min" )
    self.crit_max = self:GetAbility():GetSpecialValueFor("crit_max")
	self.lifesteal = self:GetAbility():GetSpecialValueFor( "lifesteal" )
end

function modifier_chaos_knight_chaos_strike_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_PROPERTY_PHYSICAL_LIFESTEAL
	}
end

function modifier_chaos_knight_chaos_strike_custom:GetModifierPreAttack_CriticalStrike( params )
	if IsServer() and (not self:GetParent():PassivesDisabled()) then
        if self:GetParent():HasModifier("modifier_chaos_knight_19") then return end
        local bonus_chance = 0
        if self:GetCaster():HasModifier("modifier_chaos_knight_6") then
            if self:GetCaster():GetHealthPercent() < self:GetAbility().modifier_chaos_knight_6_health then
                bonus_chance = self:GetAbility().modifier_chaos_knight_6[self:GetCaster():GetTalentLevel("modifier_chaos_knight_6")]
            end
        end
		if RollPseudoRandomPercentage(self.chance + bonus_chance, DOTA_PSEUDO_RANDOM_CHAOS_CRIT, self:GetParent() ) then
			self.record = params.record
            local bonus = 0
            if self:GetCaster():HasModifier("modifier_chaos_knight_5") then
                bonus = self:GetAbility().modifier_chaos_knight_5[self:GetCaster():GetTalentLevel("modifier_chaos_knight_5")]
            end
			return self:Expand(math.random(), self.crit_min + bonus, self.crit_max + bonus )
		end
	end
end

function modifier_chaos_knight_chaos_strike_custom:Expand( value, min, max )
	return (max-min)*value + min
end

function modifier_chaos_knight_chaos_strike_custom:GetModifierProperty_PhysicalLifesteal( params )
    if not IsServer() then return end
    if self.record and params.record == self.record then
        return self.lifesteal
    end
end

function modifier_chaos_knight_chaos_strike_custom:OnTakeDamage( params )
	if not IsServer() then return end
    local pass = false
    if self.record and params.record == self.record then
        pass = true
        self.record = nil
    end
    if pass then
        self:GetParent():EmitSound("Hero_ChaosKnight.ChaosStrike")
    end
end