--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_brand_of_fire_custom", "heroes/npc_dota_hero_lina_custom/lina_brand_of_fire_custom", LUA_MODIFIER_MOTION_NONE )

lina_brand_of_fire_custom = class({})
lina_brand_of_fire_custom.modifier_lina_2 = {5,10}
lina_brand_of_fire_custom.modifier_lina_2_radius = {50,100}
lina_brand_of_fire_custom.modifier_lina_2_cd = {-1.5,-3}
lina_brand_of_fire_custom.modifier_lina_3 = {150,250,350}

function lina_brand_of_fire_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf", context)
    PrecacheResource("particle", "particles/lina_mark_ability.vpcf", context)
end

function lina_brand_of_fire_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_2") then
        bonus = self.modifier_lina_2_cd[self:GetCaster():GetTalentLevel("modifier_lina_2")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function lina_brand_of_fire_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_2") then
        bonus = self.modifier_lina_2_radius[self:GetCaster():GetTalentLevel("modifier_lina_2")]
    end
	return self:GetSpecialValueFor( "radius" ) + bonus
end

function lina_brand_of_fire_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local duration = self:GetSpecialValueFor( "duration" )
    if self:GetCaster():HasModifier("modifier_lina_2") then
        duration = duration + self.modifier_lina_2[self:GetCaster():GetTalentLevel("modifier_lina_2")]
    end
	CreateModifierThinker( self:GetCaster(), self, "modifier_lina_brand_of_fire_custom", { duration = duration }, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_lina_brand_of_fire_custom = class({})
function modifier_lina_brand_of_fire_custom:IsHidden() return true end
function modifier_lina_brand_of_fire_custom:IsPurgable() return false end
function modifier_lina_brand_of_fire_custom:OnCreated( kv )
	self.stun_duration = self:GetAbility():GetSpecialValueFor( "stun_duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	self.damage_delay = self:GetAbility():GetSpecialValueFor( "damage_delay" )
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_lina_2") then
        self.radius = self.radius + self:GetAbility().modifier_lina_2_radius[self:GetCaster():GetTalentLevel("modifier_lina_2")]
    end
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/lina_mark_ability.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 1, Vector(self.radius, 1, 1))
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(FrameTime())
end

function modifier_lina_brand_of_fire_custom:OnIntervalThink()
    if self.triggered then return end
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    if #units > 0 then
        self.triggered = true
        self:StartIntervalThink(-1)
        self:SetDuration(self.damage_delay, true)
    end
end

function modifier_lina_brand_of_fire_custom:OnDestroy()
	if not IsServer() then return end
    if not self.triggered then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Ability.LightStrikeArray", self:GetCaster() )
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_lina_3") then
        damage = damage + (self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_lina_3[self:GetCaster():GetTalentLevel("modifier_lina_3")])
    end
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    for _, enemy in pairs(units) do
        ApplyDamage( {attacker = self:GetCaster(), victim = enemy, damage = damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility()} )
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self.stun_duration * (1-enemy:GetStatusResistance()) })
        local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
        if modifier_lina_fiery_soul_custom then
            modifier_lina_fiery_soul_custom:AddStack()
        end
    end
end