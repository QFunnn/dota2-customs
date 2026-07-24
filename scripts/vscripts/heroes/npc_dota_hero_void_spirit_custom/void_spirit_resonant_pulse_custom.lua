--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_void_spirit_resonant_pulse", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_resonant_pulse_silence", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_resonant_pulse_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_generic_ring_lua", "modifiers/modifier_generic_ring_lua", LUA_MODIFIER_MOTION_NONE)

void_spirit_resonant_pulse_custom = class({})

void_spirit_resonant_pulse_custom.modifier_void_spirit_8 = {75,150}
void_spirit_resonant_pulse_custom.modifier_void_spirit_11 = {1,1.5}
void_spirit_resonant_pulse_custom.modifier_void_spirit_15 = {30,50,70}

function void_spirit_resonant_pulse_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf", context )
end

function void_spirit_resonant_pulse_custom:OnSpellStart()
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor( "buff_duration" )
    caster:AddNewModifier(caster, self, "modifier_void_spirit_resonant_pulse", { duration = duration })
end

modifier_void_spirit_resonant_pulse = class({})

function modifier_void_spirit_resonant_pulse:IsPurgable() return not self:GetCaster():HasModifier("modifier_void_spirit_8") end

function modifier_void_spirit_resonant_pulse:CreateWave(caster, new_damage)
    self.radius = self:GetAbility():GetSpecialValueFor( "radius" ) + 90
    self.speed = self:GetAbility():GetSpecialValueFor( "speed" )
    self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_void_spirit_15") then
        self.damage = self.damage + ((self:GetCaster():GetStrength() + self:GetCaster():GetAgility() + self:GetCaster():GetIntellect(false)) / 100 * self:GetAbility().modifier_void_spirit_15[self:GetCaster():GetTalentLevel("modifier_void_spirit_15")])
    end
    self.return_speed = self:GetAbility():GetSpecialValueFor( "return_projectile_speed" )
    self.absorb_per_hero_hit = self:GetAbility():GetSpecialValueFor("absorb_per_hero_hit")
    if not IsServer() then return end
    local damageTable = {attacker = caster, damage = self.damage, damage_type = self:GetAbility():GetAbilityDamageType(), ability = self:GetAbility()}
    local pulse = caster:AddNewModifier(caster, self:GetAbility(), "modifier_generic_ring_lua", {end_radius = self.radius, speed = self.speed, target_team = DOTA_UNIT_TARGET_TEAM_ENEMY, target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC} )
    local pull_duration = self:GetAbility():GetSpecialValueFor( "duration" )
    local slow_duration = self:GetAbility():GetSpecialValueFor( "slow_duration" )
    local min_distance = self:GetAbility():GetSpecialValueFor( "min_distance" )
    local caster = self:GetCaster()
    local current_buff = self
    local ability = self:GetAbility()
    local duration = self:GetAbility():GetSpecialValueFor( "buff_duration" )

    pulse:SetCallback( function( enemy )
        damageTable.victim = enemy
        ApplyDamage(damageTable)
        if caster:HasModifier("modifier_void_spirit_11") then
            enemy:AddNewModifier(caster, ability, "modifier_void_spirit_resonant_pulse_silence", {duration = ability.modifier_void_spirit_11[caster:GetTalentLevel("modifier_void_spirit_11")] * (1-enemy:GetStatusResistance())})
        end
        if current_buff and current_buff:IsNull() then
            current_buff = caster:AddNewModifier(caster, ability, "modifier_void_spirit_resonant_pulse", { duration = duration, refresh = 1 })
        end
        if current_buff then 
            current_buff:PlayEffects3( enemy )
            if not enemy:IsHero() then return end
            current_buff:PlayEffects4( caster, enemy )
            current_buff:SetStackCount(current_buff:GetStackCount() + current_buff.absorb_per_hero_hit)
        end
    end)
    self:PlayEffects1(new_damage)
end

function modifier_void_spirit_resonant_pulse:OnCreated( kv )
    self.max_shield = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.is_all_barrier = self:GetAbility():GetSpecialValueFor( "is_all_barrier" )
    if self:GetCaster():HasModifier("modifier_void_spirit_8") then
        self.is_all_barrier = 1
        self.max_shield = self.max_shield + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_void_spirit_8[self:GetCaster():GetTalentLevel("modifier_void_spirit_8")])
    end
    self.parent = self:GetParent()
    if not IsServer() then return end
    self.shield = 0
    self.RemoveForDuel = true
    self:PlayEffects2()
    self:SetStackCount(self.max_shield)
    if (kv.refresh == 1) then return end
    self:CreateWave(self:GetCaster())
end

function modifier_void_spirit_resonant_pulse:OnRefresh(table)
    self.max_shield = self:GetAbility():GetSpecialValueFor( "base_absorb_amount" )
    self.parent = self:GetParent()
    if self:GetCaster():HasModifier("modifier_void_spirit_8") then
        self.max_shield = self.max_shield + (self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_void_spirit_8[self:GetCaster():GetTalentLevel("modifier_void_spirit_8")])
    end
    if not IsServer() then return end
    self:PlayEffects2()
    self:SetStackCount(self:GetStackCount() + self.max_shield)
    if (table.refresh == 1) then return end
    self:CreateWave(self:GetCaster())
end

function modifier_void_spirit_resonant_pulse:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_VoidSpirit.Pulse.Destroy")
end

function modifier_void_spirit_resonant_pulse:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_INCOMING_PHYSICAL_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK
    }
end
function modifier_void_spirit_resonant_pulse:GetModifierIncomingPhysicalDamageConstant( params )
    if self.is_all_barrier > 0 then return end
    if IsClient() then 
        if params.report_max then 
            return self.max_shield 
        else 
            return self:GetStackCount()
        end 
    end
    self:PlayEffects5()
    if params.damage >= self:GetStackCount() then
        self:Destroy()
        return -self:GetStackCount()
    else
        self:SetStackCount(self:GetStackCount()-params.damage)
        return -params.damage
    end
end

function modifier_void_spirit_resonant_pulse:GetModifierIncomingDamageConstant( params )
    if self.is_all_barrier <= 0 then return end
    if IsClient() then 
        if params.report_max then 
            return self.max_shield 
        else 
            return self:GetStackCount()
        end 
    end
    self:PlayEffects5()
    if params.damage>=self:GetStackCount() then
        self:Destroy()
        return -self:GetStackCount()
    else
        self:SetStackCount(self:GetStackCount()-params.damage)
        return -params.damage
    end
end

function modifier_void_spirit_resonant_pulse:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_pulse_buff.vpcf"
end

function modifier_void_spirit_resonant_pulse:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

function modifier_void_spirit_resonant_pulse:PlayEffects1(new_damage)
    if not self then return end
    local radius = self.radius * 2
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse.vpcf", PATTACH_CUSTOMORIGIN, nil )
    ParticleManager:SetParticleControlEnt(effect_cast, 0, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetParent():EmitSound("Hero_VoidSpirit.Pulse")
end

function modifier_void_spirit_resonant_pulse:PlayEffects2()
    if not self then return end
    local radius = 130
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
    self:AddParticle( effect_cast, false, false, -1, false, false )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetParent():EmitSound("Hero_VoidSpirit.Pulse.Cast")
end

function modifier_void_spirit_resonant_pulse:PlayEffects3( target )
    if not self then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Hero_VoidSpirit.Pulse.Target")
end

function modifier_void_spirit_resonant_pulse:PlayEffects4( parent, target )
    if not self then return end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_absorb.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0),  true )
	ParticleManager:SetParticleControlEnt( effect_cast, 1, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true  )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

function modifier_void_spirit_resonant_pulse:PlayEffects5()
    if not self then return end
	local radius = 100
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_shield_deflect.vpcf", PATTACH_POINT_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControlEnt( effect_cast, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end

modifier_void_spirit_resonant_pulse_silence = class({})

function modifier_void_spirit_resonant_pulse_silence:GetTexture() return "void_spirit_11" end

function modifier_void_spirit_resonant_pulse_silence:CheckState()
    local state = {[MODIFIER_STATE_SILENCED] = true}
    return state
end

function modifier_void_spirit_resonant_pulse_silence:GetEffectName()
    return "particles/generic_gameplay/generic_silence.vpcf"
end

function modifier_void_spirit_resonant_pulse_silence:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end