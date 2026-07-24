--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_abaddon_aphotic_shield_custom", "heroes/npc_dota_hero_abaddon_custom/abaddon_aphotic_shield_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_abaddon_aphotic_shield_custom_handler", "heroes/npc_dota_hero_abaddon_custom/abaddon_aphotic_shield_custom", LUA_MODIFIER_MOTION_NONE )

abaddon_aphotic_shield_custom = class({})

abaddon_aphotic_shield_custom.modifier_abaddon_20 = {30,60,90}

function abaddon_aphotic_shield_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_abaddon.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_abaddon.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_abaddon.vpcf", context)
end

function abaddon_aphotic_shield_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_abaddon_19") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end

function abaddon_aphotic_shield_custom:GetIntrinsicModifierName()
    return "modifier_abaddon_aphotic_shield_custom_handler"
end

function abaddon_aphotic_shield_custom:OnSpellStart(new_target)
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor( "duration" )
    local target = self:GetCursorTarget()
    if new_target then
        target = new_target
    end
    target:RemoveModifierByName("modifier_abaddon_aphotic_shield_custom")
	target:AddNewModifier( self:GetCaster(), self, "modifier_abaddon_aphotic_shield_custom", {duration = duration} )
	target:Purge( false, true, false, true, true)
end

modifier_abaddon_aphotic_shield_custom = class({})
function modifier_abaddon_aphotic_shield_custom:IsPurgable() return true end

function modifier_abaddon_aphotic_shield_custom:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = self:GetAbility():GetSpecialValueFor( "damage_absorb" )
    if self:GetCaster():HasModifier("modifier_abaddon_20") then
        self.barrier = self.barrier + self:GetAbility().modifier_abaddon_20[self:GetCaster():GetTalentLevel("modifier_abaddon_20")]
    end
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
	self.damageTable = { attacker = self:GetCaster(), damage = self.barrier, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility() }
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield.vpcf", PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
	EmitSoundOn("Hero_Abaddon.AphoticShield.Cast", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
end

function modifier_abaddon_aphotic_shield_custom:OnDestroy()
	if not IsServer() then return end
	local enemies = FindUnitsInRadius( self.caster:GetTeamNumber(), self.parent:GetOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
	for _,enemy in pairs(enemies) do
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )
	end
	StopSoundOn("Hero_Abaddon.AphoticShield.Loop", self.parent)
	EmitSoundOn("Hero_Abaddon.AphoticShield.Destroy", self.parent)
end

function modifier_abaddon_aphotic_shield_custom:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_abaddon_aphotic_shield_custom:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_abaddon_aphotic_shield_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_abaddon_aphotic_shield_custom:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_abaddon/abaddon_aphotic_shield_hit.vpcf", PATTACH_POINT_FOLLOW, self.parent )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector(80,80,80) )
	ParticleManager:ReleaseParticleIndex( effect_cast )

	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

modifier_abaddon_aphotic_shield_custom_handler = class({})
function modifier_abaddon_aphotic_shield_custom_handler:IsHidden() return true end
function modifier_abaddon_aphotic_shield_custom_handler:IsPurgable() return false end
function modifier_abaddon_aphotic_shield_custom_handler:IsPurgeException() return false end
function modifier_abaddon_aphotic_shield_custom_handler:RemoveOnDeath() return false end

function modifier_abaddon_aphotic_shield_custom_handler:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end

function modifier_abaddon_aphotic_shield_custom_handler:OnIntervalThink()
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_abaddon_19") then return end
    if self:GetAbility():IsFullyCastable() then
        self:GetAbility():OnSpellStart(self:GetCaster())
        self:GetAbility():UseResources(true, false, false, true)
    end
end