--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_chaos_knight_chaos_walk", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_chaos_walk", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chaos_knight_chaos_walk_thinker", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_chaos_walk", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_chaos_knight_chaos_walk_debuff", "heroes/npc_dota_hero_chaos_knight_custom/chaos_knight_chaos_walk", LUA_MODIFIER_MOTION_NONE)

chaos_knight_chaos_walk = class({})

function chaos_knight_chaos_walk:GetIntrinsicModifierName()
    return "modifier_chaos_knight_chaos_walk"
end

function chaos_knight_chaos_walk:Precache(context)
    PrecacheResource("particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_burning_trail.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_dawnbreaker/dawnbreaker_converge_debuff.vpcf", context)
    PrecacheResource("particle", "particles/chaos_trail.vpcf", context)
end

modifier_chaos_knight_chaos_walk = class({})
function modifier_chaos_knight_chaos_walk:IsPurgable() return false end
function modifier_chaos_knight_chaos_walk:IsPurgeException() return false end
function modifier_chaos_knight_chaos_walk:RemoveOnDeath() return false end
function modifier_chaos_knight_chaos_walk:IsHidden() return true end

function modifier_chaos_knight_chaos_walk:OnCreated()
    self.parent = self:GetParent()
    self.caster = self:GetCaster()
    self.model_scale = self:GetAbility():GetSpecialValueFor("model_scale")
    self.damage_percent = self:GetAbility():GetSpecialValueFor("damage_percent")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self.path_duration = self:GetAbility():GetSpecialValueFor("path_duration")
    if not IsServer() then return end
    self.distance = 0
    self.spawner_time = 0
    self.pos = self:GetParent():GetAbsOrigin()
    self:StartIntervalThink(0.1)
end

function modifier_chaos_knight_chaos_walk:OnIntervalThink()
    if not IsServer() then return end
    if not self.parent:IsAlive() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    local length = (self.pos - self:GetParent():GetAbsOrigin()):Length2D()
    if length >= 1200 then
        self.pos = self:GetParent():GetAbsOrigin()
        return 
    end
    self.distance = self.distance - length
    self.spawner_time = self.spawner_time - 0.1
    if self:GetParent():IgnoreWispAndInvisAndRelax(true, true, true) then
        if self.distance <= 0 or self.spawner_time <= 0 then
            if self.distance <= 0 then
                self.distance = (self.radius / 2)
            end
            if self.spawner_time <= 0 then
                self.spawner_time = 0.5
            end
            CreateModifierThinker( self.caster, self:GetAbility(), "modifier_chaos_knight_chaos_walk_thinker", { duration = self.path_duration, x = self.pos.x, y = self.pos.y }, self.parent:GetOrigin(), self.caster:GetTeamNumber(), false )
        end
    end
    self.pos = self:GetParent():GetAbsOrigin()
end

function modifier_chaos_knight_chaos_walk:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_TREES] = true,
    }
end

function modifier_chaos_knight_chaos_walk:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MODEL_SCALE,
    }
end

function modifier_chaos_knight_chaos_walk:GetModifierModelScale()
    return self.model_scale
end

modifier_chaos_knight_chaos_walk_thinker = class({})

function modifier_chaos_knight_chaos_walk_thinker:IsHidden()
	return true
end

function modifier_chaos_knight_chaos_walk_thinker:IsDebuff()
	return false
end

function modifier_chaos_knight_chaos_walk_thinker:IsPurgable()
	return false
end

function modifier_chaos_knight_chaos_walk_thinker:OnCreated( kv )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	if not IsServer() then return end
	self.prev_pos = Vector( kv.x, kv.y, 0 )
	self.prev_pos = GetGroundPosition( self.prev_pos, self:GetParent() )
	self:PlayEffects( kv.duration )
end

function modifier_chaos_knight_chaos_walk_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_chaos_knight_chaos_walk_thinker:IsAura()
	return true
end

function modifier_chaos_knight_chaos_walk_thinker:GetModifierAura()
	return "modifier_chaos_knight_chaos_walk_debuff"
end

function modifier_chaos_knight_chaos_walk_thinker:GetAuraRadius()
	return self.radius
end

function modifier_chaos_knight_chaos_walk_thinker:GetAuraDuration()
	return 0.5
end

function modifier_chaos_knight_chaos_walk_thinker:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_chaos_knight_chaos_walk_thinker:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_chaos_knight_chaos_walk_thinker:GetAuraSearchFlags()
	return 0
end

function modifier_chaos_knight_chaos_walk_thinker:PlayEffects( duration )
    local particle = ParticleManager:CreateParticle("particles/chaos_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, Vector(duration-FrameTime(), 0, 0))
    ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 4, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 5, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

modifier_chaos_knight_chaos_walk_debuff = class({})

function modifier_chaos_knight_chaos_walk_debuff:OnCreated( kv )
	if not IsServer() then return end
    self.damage_percent = self:GetAbility():GetSpecialValueFor("damage_percent")
	self:StartIntervalThink(0.5)
	self:OnIntervalThink()
end

function modifier_chaos_knight_chaos_walk_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self.damage_percent
    ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility()})
end