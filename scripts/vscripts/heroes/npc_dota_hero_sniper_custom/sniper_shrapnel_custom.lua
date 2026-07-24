--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_sniper_shrapnel_custom", "heroes/npc_dota_hero_sniper_custom/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_damage", "heroes/npc_dota_hero_sniper_custom/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_sniper_shrapnel_custom_thinker", "heroes/npc_dota_hero_sniper_custom/sniper_shrapnel_custom", LUA_MODIFIER_MOTION_NONE )

sniper_shrapnel_custom = class({})
sniper_shrapnel_custom.modifier_sniper_18_cooldown = {-1,-2,-3}
sniper_shrapnel_custom.modifier_sniper_18 = {20,40,60}
sniper_shrapnel_custom.modifier_sniper_19_radius = 125
sniper_shrapnel_custom.modifier_sniper_19_damage = 50
sniper_shrapnel_custom.modifier_sniper_18_delay = {-0.3,-0.6,-0.9}
sniper_shrapnel_custom.modifier_sniper_15 = {-10,-15,-20}

function sniper_shrapnel_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf", context )
    PrecacheResource( "particle","particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf", context )
    PrecacheResource( "particle","particles/generic_gameplay/generic_silenced.vpcf", context )
    PrecacheResource( "particle","particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel.vpcf", context )
    PrecacheResource( "particle","particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel_launch.vpcf", context )
end

function sniper_shrapnel_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_sniper_19") then
        return "sniper_fall20_shrapnel"
    end
    return "sniper_shrapnel"
end

function sniper_shrapnel_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_sniper_19") then
        bonus = self.modifier_sniper_19_radius
    end
    return self:GetSpecialValueFor( "radius" ) + bonus
end

function sniper_shrapnel_custom:GetAbilityChargeRestoreTime(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_sniper_15") then
        bonus = self.modifier_sniper_15[self:GetCaster():GetTalentLevel("modifier_sniper_15")]
    end
    return self.BaseClass.GetAbilityChargeRestoreTime(self, iLevel) + bonus
end

function sniper_shrapnel_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:StartShrapnel(point)
end

function sniper_shrapnel_custom:StartShrapnel(point)
    local caster = self:GetCaster()
    CreateModifierThinker( caster, self, "modifier_sniper_shrapnel_custom_thinker", {}, point, caster:GetTeamNumber(), false) 
    caster:EmitSound("sniper_snip_ability_shrapnel_0"..math.random(1,3))
    local particle_name = "particles/units/heroes/hero_sniper/sniper_shrapnel_launch.vpcf"
    if self:GetCaster():HasModifier("modifier_sniper_19") then
        particle_name = "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel_launch.vpcf"
    end
    local effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt(  effect_cast, 0,  caster,  PATTACH_POINT_FOLLOW,  "attach_attack1",  caster:GetOrigin(),  false )
    ParticleManager:SetParticleControl( effect_cast, 1, point + Vector( 0, 0, 2000 ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    caster:EmitSound("Hero_Sniper.ShrapnelShoot")
end

modifier_sniper_shrapnel_custom_thinker = class({})
function modifier_sniper_shrapnel_custom_thinker:IsHidden() return true end
function modifier_sniper_shrapnel_custom_thinker:IsPurgable() return false end
function modifier_sniper_shrapnel_custom_thinker:IsAura() return self.start end
function modifier_sniper_shrapnel_custom_thinker:GetModifierAura()  return "modifier_sniper_shrapnel_custom_damage" end
function modifier_sniper_shrapnel_custom_thinker:GetAuraRadius() return self.radius end
function modifier_sniper_shrapnel_custom_thinker:GetAuraDuration() return 0 end
function modifier_sniper_shrapnel_custom_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_sniper_shrapnel_custom_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end

function modifier_sniper_shrapnel_custom_thinker:OnCreated( kv )
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.delay = self.ability:GetSpecialValueFor( "damage_delay" )
    if self:GetCaster():HasModifier("modifier_sniper_18") then
        self.delay = self.delay + self:GetAbility().modifier_sniper_18_delay[self:GetCaster():GetTalentLevel("modifier_sniper_18")]
    end
    self.radius = self.ability:GetSpecialValueFor( "radius" )
    if self:GetCaster():HasModifier("modifier_sniper_19") then
        self.radius = self.radius + self:GetAbility().modifier_sniper_19_radius
    end
    self.damage = self.ability:GetSpecialValueFor( "shrapnel_damage" )
    self.duration = self.ability:GetSpecialValueFor( "duration" ) 
    if self:GetCaster():HasModifier("modifier_sniper_18") then
        self.duration = self.duration + self:GetAbility().modifier_sniper_18_cooldown[self:GetCaster():GetTalentLevel("modifier_sniper_18")]
    end
    self.interval = 1
    self.start = false
    if not IsServer() then return end
    self.direction = (self.parent:GetOrigin()-self.caster:GetOrigin()):Normalized()
    self.direction.z = 0
    self.parent:EmitSound("Hero_Sniper.ShrapnelShatter") 
    self:StartIntervalThink( self.delay )
end

function modifier_sniper_shrapnel_custom_thinker:OnIntervalThink()
    if not self.start then
        self.start = true
        self:SetDuration( self.duration + FrameTime()*2, true ) 
        AddFOWViewer( self.caster:GetTeamNumber(), self.parent:GetOrigin(), self.radius, self.duration, false )
        local particle_name = "particles/units/heroes/hero_sniper/sniper_shrapnel.vpcf"
        if self:GetCaster():HasModifier("modifier_sniper_19") then
            particle_name = "particles/econ/items/sniper/sniper_fall20_immortal/sniper_fall20_immortal_shrapnel.vpcf"
        end
        self.effect_cast = ParticleManager:CreateParticle( particle_name, PATTACH_WORLDORIGIN, nil )
        ParticleManager:SetParticleControl( self.effect_cast, 0, self.parent:GetOrigin() )
        ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( self.radius, 1, 1 ) )
        ParticleManager:SetParticleControlForward( self.effect_cast, 2, self.direction )
        self:AddParticle(self.effect_cast, false, false, -1, false, true)
    end
end

function modifier_sniper_shrapnel_custom_thinker:OnDestroy()
    if not IsServer() then return end
    self.parent:StopSound("Hero_Sniper.ShrapnelShatter")
end

modifier_sniper_shrapnel_custom_damage = class({})
function modifier_sniper_shrapnel_custom_damage:IsPurgable() return false end

function modifier_sniper_shrapnel_custom_damage:GetAttributes()
    if self:GetCaster():HasModifier("modifier_sniper_21") then
        return MODIFIER_ATTRIBUTE_MULTIPLE
    end
end

function modifier_sniper_shrapnel_custom_damage:OnCreated( kv )
    self.caster = self:GetCaster()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.slow_movement_speed = self.ability:GetSpecialValueFor( "slow_movement_speed" )
    local interval = 1
    self.caster = self.ability:GetCaster()
    if not IsServer() then return end
    self:StartIntervalThink( interval )
    self:OnIntervalThink()
end

function modifier_sniper_shrapnel_custom_damage:OnIntervalThink()
    if not IsServer() then return end
    local damage = self.ability:GetSpecialValueFor( "shrapnel_damage" )
    if self:GetCaster():HasModifier("modifier_sniper_19") then
        damage = damage + (self:GetCaster():GetManaRegen() / 100 * self:GetAbility().modifier_sniper_19_damage)
    end
    if self:GetCaster():HasModifier("modifier_sniper_18") then
        damage = damage + self:GetAbility().modifier_sniper_18[self:GetCaster():GetTalentLevel("modifier_sniper_18")]
    end
    local damageTable = { victim = self.parent, attacker = self.caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability}
    ApplyDamage(damageTable)
end

function modifier_sniper_shrapnel_custom_damage:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_sniper_shrapnel_custom_damage:GetModifierMoveSpeedBonus_Percentage()
    return self.slow_movement_speed
end