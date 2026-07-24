--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_luna_eclipse_custom", "heroes/npc_dota_hero_luna_custom/luna_eclipse_custom", LUA_MODIFIER_MOTION_NONE )

luna_eclipse_custom = class({})
luna_eclipse_custom.modifier_luna_20 = {-20,-35,-50}
luna_eclipse_custom.modifier_luna_21 = 3

function luna_eclipse_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_luna_20") then
        bonus = self.modifier_luna_20[self:GetCaster():GetTalentLevel("modifier_luna_20")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function luna_eclipse_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_luna/luna_eclipse.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_luna.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_luna.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_luna.vpcf", context)
end

function luna_eclipse_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_luna_21") then
		return self:GetSpecialValueFor( "radius" )
	end
	return 0
end

function luna_eclipse_custom:GetCastRange(vlocation, target)
    if self:GetCaster():HasModifier("modifier_luna_21") then
        return 2500
    end
    return self.BaseClass.GetCastRange(self, vlocation, target)
end

function luna_eclipse_custom:GetManaCost(level)
    return self.BaseClass.GetManaCost(self, level)
end

function luna_eclipse_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_luna_21") then
        return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_OPTIONAL_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_POINT
    end
	return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

function luna_eclipse_custom:OnSpellStart()
    if not IsServer() then return end
    local night_duration = self:GetSpecialValueFor("night_duration")
    GameRules:BeginTemporaryNight( night_duration, 48 )
    if self:GetCaster():HasModifier("modifier_luna_21") then
        local target = self:GetCursorTarget()
        local point = self:GetCursorPosition()
        if target then
            target:AddNewModifier(self:GetCaster(), self, "modifier_luna_eclipse_custom", {})
		else
            self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_luna_eclipse_custom", {pointx = point.x, pointy = point.y})
		end
    else
	    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_luna_eclipse_custom", {})
    end
end

modifier_luna_eclipse_custom = class({})
function modifier_luna_eclipse_custom:IsPurgable() return false end
function modifier_luna_eclipse_custom:IsPurgeException() return false end
function modifier_luna_eclipse_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_luna_eclipse_custom:OnCreated( kv )
	self.beams = self:GetAbility():GetSpecialValueFor( "beams" )
	self.hit_count = self:GetAbility():GetSpecialValueFor( "hit_count" )
	self.beam_interval = self:GetAbility():GetSpecialValueFor( "beam_interval" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
    if self:GetCaster():HasModifier("modifier_luna_21") then
        self.beams = self.beams + self:GetAbility().modifier_luna_21
        self.hit_count = self.beams
        self.beam_interval = self.beam_interval / 2
    end
	self.parent = self:GetParent()
	self.caster = self:GetCaster()
    if not IsServer() then return end
    if kv.pointx then
        self.point = Vector( kv.pointx, kv.pointy, 0 )
        AddFOWViewer( self:GetCaster():GetTeamNumber(), self.point, self.radius + 75, self.beams*self.beam_interval, false)
    end
    self.counter = 0
    self.hits = {}
    if self.point then
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_eclipse.vpcf", PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( effect_cast, 0, self.point )
        EmitSoundOnLocationWithCaster( self.point, "Hero_Luna.Eclipse.Cast", self:GetParent() )
    else
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_eclipse.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
        EmitSoundOn( "Hero_Luna.Eclipse.Cast", self:GetParent() )
    end
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )
    self:AddParticle(effect_cast,false,false,-1,false,false)
    self.start = true
	self:StartIntervalThink(FrameTime())
end

function modifier_luna_eclipse_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.start then
        self:StartIntervalThink(self.beam_interval)
        self.start = false
    end
    self.counter = self.counter + 1
	local point = self.point or self.parent:GetOrigin()
	local units = FindUnitsInRadius(self.caster:GetTeamNumber(), point, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS, 0, false)
	local unit = nil
	if #units>0 then
		for i=1,#units do
			unit = units[i]
			self.hits[unit] = self.hits[unit] or 0
			self.hits[unit] = self.hits[unit] + 1
			if self.hits[unit] <= self.hit_count then
                local luna_lucent_beam_custom = self:GetCaster():FindAbilityByName("luna_lucent_beam_custom")
                if luna_lucent_beam_custom then
                    luna_lucent_beam_custom:CastBeamTarget(unit, true)
                else
				    ApplyDamage({ victim = unit, attacker = self.caster, damage = self:GetAbility().damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility()})
					local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit )
                    ParticleManager:SetParticleControl( effect_cast, 0, unit:GetOrigin() )
                    ParticleManager:SetParticleControlEnt(effect_cast,1,unit,PATTACH_ABSORIGIN_FOLLOW,"attach_hitloc",Vector(0,0,0),true)
                    ParticleManager:SetParticleControlEnt(effect_cast,5,unit,PATTACH_POINT_FOLLOW,"attach_hitloc",Vector(0,0,0),true)
                    ParticleManager:SetParticleControlEnt(effect_cast,6,unit,PATTACH_POINT_FOLLOW,"attach_hitloc",Vector(0,0,0),true)
                    ParticleManager:ReleaseParticleIndex( effect_cast )
                end
                break
			end
            unit = nil
		end
	end
	if self.counter >= self.beams then
		self:StartIntervalThink( -1 )
		self:Destroy()
	end
	if not unit then
		local vector = point + RandomVector( RandomInt( 0, self.radius ) )
	    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_luna/luna_lucent_beam.vpcf", PATTACH_CUSTOMORIGIN, nil )
        ParticleManager:SetParticleControl( effect_cast, 0, vector )
		ParticleManager:SetParticleControl( effect_cast, 1, vector )
		ParticleManager:SetParticleControl( effect_cast, 5, vector )
		ParticleManager:SetParticleControl( effect_cast, 6, vector )
		ParticleManager:ReleaseParticleIndex( effect_cast )
		EmitSoundOnLocationWithCaster( vector, "Hero_Luna.Eclipse.NoTarget", self.caster )
		return
	end
	EmitSoundOn( "Hero_Luna.Eclipse.Target", unit)
end