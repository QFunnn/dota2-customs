--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_light_strike_array_custom", "heroes/npc_dota_hero_lina_custom/lina_light_strike_array_custom", LUA_MODIFIER_MOTION_NONE )

lina_light_strike_array_custom = class({})
lina_light_strike_array_custom.modifier_lina_16 = {20,40}

function lina_light_strike_array_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_light_strike_array_ray_team.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", context)
end

function lina_light_strike_array_custom:GetAOERadius()
	return self:GetSpecialValueFor( "light_strike_array_aoe" )
end

function lina_light_strike_array_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local light_strike_array_delay_time = self:GetSpecialValueFor( "light_strike_array_delay_time" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_lina_light_strike_array_custom", { duration = light_strike_array_delay_time }, point, self:GetCaster():GetTeamNumber(), false)
end

modifier_lina_light_strike_array_custom = class({})
function modifier_lina_light_strike_array_custom:IsHidden() return true end
function modifier_lina_light_strike_array_custom:IsPurgable() return false end
function modifier_lina_light_strike_array_custom:OnCreated( kv )
	self.light_strike_array_stun_duration = self:GetAbility():GetSpecialValueFor( "light_strike_array_stun_duration" )
	self.damage = self:GetAbility():GetSpecialValueFor( "light_strike_array_damage" )
    if self:GetCaster():HasModifier("modifier_lina_16") then
        self.damage = self.damage + self:GetAbility().modifier_lina_16[self:GetCaster():GetTalentLevel("modifier_lina_16")]
    end
	self.radius = self:GetAbility():GetSpecialValueFor( "light_strike_array_aoe" )
	if not IsServer() then return end
    local particle = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_lina/lina_spell_light_strike_array_ray_team.vpcf", PATTACH_WORLDORIGIN, self:GetCaster(), self:GetCaster():GetTeamNumber() )
	ParticleManager:SetParticleControl( particle, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( particle, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( particle )
	EmitSoundOnLocationForAllies( self:GetParent():GetOrigin(), "Ability.PreLightStrikeArray", self:GetCaster() )
end

function modifier_lina_light_strike_array_custom:OnDestroy()
	if not IsServer() then return end
	GridNav:DestroyTreesAroundPoint( self:GetParent():GetOrigin(), self.radius, false )
	local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetParent():GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
	for _,enemy in pairs(enemies) do
		ApplyDamage( {attacker = self:GetCaster(), victim = enemy, damage = self.damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility()} )
		enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", { duration = self.light_strike_array_stun_duration * (1-enemy:GetStatusResistance()) })
        local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
        if modifier_lina_fiery_soul_custom then
            modifier_lina_fiery_soul_custom:AddStack()
        end
	end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_light_strike_array.vpcf", PATTACH_WORLDORIGIN, nil )
	ParticleManager:SetParticleControl( effect_cast, 0, self:GetParent():GetOrigin() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 1, 1 ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster( self:GetParent():GetOrigin(), "Ability.LightStrikeArray", self:GetCaster() )
end