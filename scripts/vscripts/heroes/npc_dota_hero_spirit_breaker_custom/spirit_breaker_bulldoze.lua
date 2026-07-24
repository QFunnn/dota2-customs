--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_spirit_breaker_bulldoze_custom", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_bulldoze", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spirit_breaker_bulldoze_custom_health_regen", "heroes/npc_dota_hero_spirit_breaker_custom/spirit_breaker_bulldoze", LUA_MODIFIER_MOTION_NONE )

spirit_breaker_bulldoze_custom = class({})

spirit_breaker_bulldoze_custom.modifier_spirit_breaker_3 = {-3,-6,-9}
spirit_breaker_bulldoze_custom.modifier_spirit_breaker_5 = {6,12}
spirit_breaker_bulldoze_custom.modifier_spirit_breaker_4 = {150,300,450}
spirit_breaker_bulldoze_custom.modifier_spirit_breaker_2 = {100,150}
spirit_breaker_bulldoze_custom.modifier_spirit_breaker_2_base = 20
spirit_breaker_bulldoze_custom.modifier_spirit_breaker_2_radius = 300

function spirit_breaker_bulldoze_custom:GetCooldown(level)
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_spirit_breaker_3") then
		bonus = self.modifier_spirit_breaker_3[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_3")]
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function spirit_breaker_bulldoze_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf", context )
    PrecacheResource( "particle", "particles/spirit_breaker_buldoze_damage_aura.vpcf", context )
end

function spirit_breaker_bulldoze_custom:OnSpellStart()
	if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():RemoveModifierByName("modifier_spirit_breaker_bulldoze_custom")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_spirit_breaker_bulldoze_custom", {duration = duration})
end

modifier_spirit_breaker_bulldoze_custom = class({})

function modifier_spirit_breaker_bulldoze_custom:IsPurgable() return not self:GetCaster():HasModifier("modifier_spirit_breaker_7") end

function modifier_spirit_breaker_bulldoze_custom:OnCreated( kv )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.resistance = self:GetAbility():GetSpecialValueFor( "status_resistance" )
    if self:GetCaster():HasModifier("modifier_spirit_breaker_5") then
        self.movespeed = self.movespeed + self:GetAbility().modifier_spirit_breaker_5[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_5")]
        self.resistance = self.resistance + self:GetAbility().modifier_spirit_breaker_5[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_5")]
    end
	if not IsServer() then return end
    self.has_shield = self:GetCaster():HasModifier("modifier_spirit_breaker_4")
    if self:GetCaster():HasModifier("modifier_spirit_breaker_4") then
        self.barrier = self:GetAbility().modifier_spirit_breaker_4[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_4")]
        self.max_shield = self.barrier
	    self.current_shield = self.barrier
        self:SetHasCustomTransmitterData( true )
        self:SendBuffRefreshToClients()
    end
	self:GetParent():EmitSound("Hero_Spirit_Breaker.Bulldoze.Cast")
    if self:GetCaster():HasModifier("modifier_spirit_breaker_2") then
        self.pfx_radius = (self:GetCaster():GetAoeBonus(self:GetAbility().modifier_spirit_breaker_2_radius)) + 120
        local particle = ParticleManager:CreateParticle("particles/spirit_breaker_buldoze_damage_aura.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 2, Vector(self.pfx_radius, self.pfx_radius, self.pfx_radius))
        self:AddParticle(particle, false, false, -1, false, false)
        self.pfx = particle
        self:StartIntervalThink(0.5)
    end
end

function modifier_spirit_breaker_bulldoze_custom:GetModifierIncomingDamageConstant( params )
    if not self.has_shield then return end
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local dodge = self.current_shield
        self.current_shield = 0
        self:SendBuffRefreshToClients()
		return -dodge
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

function modifier_spirit_breaker_bulldoze_custom:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield,
        has_shield = self.has_shield
	}
	return data
end

function modifier_spirit_breaker_bulldoze_custom:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
    self.has_shield = data.has_shield
end

function modifier_spirit_breaker_bulldoze_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.pfx then
        ParticleManager:SetParticleControl(self.pfx, 2, Vector(self.pfx_radius, self.pfx_radius, self.pfx_radius))
    end
    local enemies = FindUnitsInRadius( self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_spirit_breaker_2_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
    local damage = self:GetParent():GetHealthRegen() / 100 * self:GetAbility().modifier_spirit_breaker_2[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_2")]  + self:GetAbility().modifier_spirit_breaker_2_base
	for _,enemy in pairs(enemies) do
        ApplyDamage({ victim = enemy, attacker = self:GetParent(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
    end
end

function modifier_spirit_breaker_bulldoze_custom:OnRefresh( kv )
	self.movespeed = self:GetAbility():GetSpecialValueFor( "movement_speed" )
	self.resistance = self:GetAbility():GetSpecialValueFor( "status_resistance" )
    if self:GetCaster():HasModifier("modifier_spirit_breaker_5") then
        self.movespeed = self.movespeed + self:GetAbility().modifier_spirit_breaker_5[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_5")]
        self.resistance = self.resistance + self:GetAbility().modifier_spirit_breaker_5[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_5")]
    end
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Spirit_Breaker.Bulldoze.Cast")
end

function modifier_spirit_breaker_bulldoze_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT
	}
	return funcs
end

function modifier_spirit_breaker_bulldoze_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.movespeed
end

function modifier_spirit_breaker_bulldoze_custom:GetModifierStatusResistanceStacking()
	return self.resistance
end

function modifier_spirit_breaker_bulldoze_custom:GetEffectName()
	return "particles/units/heroes/hero_spirit_breaker/spirit_breaker_haste_owner.vpcf"
end

function modifier_spirit_breaker_bulldoze_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_spirit_breaker_bulldoze_custom_health_regen = class({})
function modifier_spirit_breaker_bulldoze_custom_health_regen:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end
function modifier_spirit_breaker_bulldoze_custom_health_regen:OnCreated()
    if not IsServer() then return end
    local bonus = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_spirit_breaker_4[self:GetCaster():GetTalentLevel("modifier_spirit_breaker_4")]
    self:SetStackCount(bonus)
end
function modifier_spirit_breaker_bulldoze_custom_health_regen:GetModifierConstantHealthRegen()
    return self:GetStackCount()
end
function modifier_spirit_breaker_bulldoze_custom_health_regen:GetTexture() return "spirit_breaker_4" end