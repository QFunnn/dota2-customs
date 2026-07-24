--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lina_laguna_blade_custom", "heroes/npc_dota_hero_lina_custom/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_lina_laguna_blade_custom_barrier", "heroes/npc_dota_hero_lina_custom/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_lina_laguna_blade_custom_buff", "heroes/npc_dota_hero_lina_custom/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_lina_laguna_blade_custom_activate_time", "heroes/npc_dota_hero_lina_custom/lina_laguna_blade_custom", LUA_MODIFIER_MOTION_NONE )

lina_laguna_blade_custom = class({})
lina_laguna_blade_custom.modifier_lina_6 = {-15,-30}
lina_laguna_blade_custom.modifier_lina_4 = {50,75}
lina_laguna_blade_custom.modifier_lina_4_duration = 7
lina_laguna_blade_custom.modifier_lina_11 = {8,10,12}
lina_laguna_blade_custom.modifier_lina_11_duration = 5
lina_laguna_blade_custom.modifier_lina_18 = {80,160}
lina_laguna_blade_custom.modifier_lina_7_duration = 5.5
lina_laguna_blade_custom.modifier_lina_7 = 250

function lina_laguna_blade_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_6") then
        bonus = self.modifier_lina_6[self:GetCaster():GetTalentLevel("modifier_lina_6")]
    end
    return self.BaseClass.GetCooldown( self, iLevel ) + bonus
end

function lina_laguna_blade_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lina_7") and not self:GetCaster():HasModifier("modifier_lina_laguna_blade_custom_activate_time") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    if self:GetCaster():HasModifier("modifier_lina_5") then
        return DOTA_ABILITY_BEHAVIOR_POINT
    end
    return self.BaseClass.GetBehavior(self)
end

function lina_laguna_blade_custom:GetManaCost(level)
    if self:GetCaster():HasModifier("modifier_lina_laguna_blade_custom_activate_time") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, level)
end

function lina_laguna_blade_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_lina_18") then
        return "lina_18"
    end
    if self:GetCaster():HasModifier("modifier_lina_laguna_blade_custom_activate_time") then
        return "lina_7"
    end
    return "lina_laguna_blade"
end

function lina_laguna_blade_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/lina/lina_ti6/lina_ti6_laguna_blade.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_base_attack_large.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_laguna_blade_shard_scorch.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_ember_spirit/ember_spirit_hit.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_spell_laguna_blade_shard_units_hit.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_lina/ultimate_timer.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context)
end

function lina_laguna_blade_custom:OnSpellStart(new_target)
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_lina_7") and not self:GetCaster():HasModifier("modifier_lina_laguna_blade_custom_activate_time") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_laguna_blade_custom_activate_time", {duration = self.modifier_lina_7_duration})
        self:EndCooldown()
        self:GetCaster():EmitSound("Ability.PreLightStrikeArray.ti7")
        return
    end
    if self:GetCaster():HasModifier("modifier_lina_7") then
        self:EndCooldown()
    end
    local target = self:GetCursorTarget()
    if self:GetCaster():HasModifier("modifier_lina_5") then
        local point = self:GetCursorPosition()
        if point == self:GetCaster():GetAbsOrigin() then
            point = point + self:GetCaster():GetForwardVector()
        end
        local direction = point - self:GetCaster():GetAbsOrigin()
        direction.z = 0
        direction = direction:Normalized()
        local range = self:GetCastRange(self:GetCaster():GetAbsOrigin(), nil) + self:GetCaster():GetCastRangeBonus()
        local end_point = self:GetCaster():GetAbsOrigin() + direction * range
        end_point = GetGroundPosition(end_point, nil)

        local laguna_particle = "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf"
        
        if self:GetCaster():HasModifier("modifier_lina_7") then
            laguna_particle = "particles/econ/items/lina/lina_ti6/lina_ti6_laguna_blade.vpcf"
        end
        
        local particle = ParticleManager:CreateParticle( laguna_particle, PATTACH_CUSTOMORIGIN, nil )
        ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
        ParticleManager:SetParticleControl(particle, 1, end_point)
        if self:GetCaster():HasModifier("modifier_lina_18") then
            ParticleManager:SetParticleControl(particle, 60, Vector(255,0,0))
            ParticleManager:SetParticleControl(particle, 61, Vector(1,1,1))
        end
        ParticleManager:ReleaseParticleIndex( particle )

        local particle_smoke = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade_shard_scorch.vpcf", PATTACH_CUSTOMORIGIN, self:GetCaster() )
        ParticleManager:SetParticleControlEnt( particle_smoke, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", Vector(0,0,0), true )
        ParticleManager:SetParticleControl(particle_smoke, 1, end_point)
        ParticleManager:ReleaseParticleIndex( particle_smoke )

        local units = FindUnitsInLine(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), end_point, nil, 150, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO, 0)
        for _, unit in pairs(units) do
            self:LagunaToTarget(unit, true)
        end

        self:GetCaster():EmitSound("Ability.LagunaBlade")
    else
        if target:TriggerSpellAbsorb( self ) then return end
        self:LagunaToTarget(target)
    end
    if self:GetCaster():HasModifier("modifier_lina_11") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lina_laguna_blade_custom_buff", {duration = self.modifier_lina_11_duration})
    end
    local modifier_lina_laguna_blade_custom_activate_time = self:GetCaster():FindModifierByName("modifier_lina_laguna_blade_custom_activate_time")
    if modifier_lina_laguna_blade_custom_activate_time then
        modifier_lina_laguna_blade_custom_activate_time:Destroy()
    end
end

function lina_laguna_blade_custom:LagunaToTarget(target, no_visual)
    local delay = self:GetSpecialValueFor( "damage_delay" )
    if not no_visual then
        local laguna_particle = "particles/units/heroes/hero_lina/lina_spell_laguna_blade.vpcf"
        if self:GetCaster():HasModifier("modifier_lina_7") then
            laguna_particle = "particles/econ/items/lina/lina_ti6/lina_ti6_laguna_blade.vpcf"
        end
        local particle = ParticleManager:CreateParticle( laguna_particle, PATTACH_CUSTOMORIGIN, nil )
        ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetCaster():GetAbsOrigin(), true )
        ParticleManager:SetParticleControlEnt( particle, 1, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
        if self:GetCaster():HasModifier("modifier_lina_18") then
            ParticleManager:SetParticleControl(particle, 60, Vector(255,0,0))
            ParticleManager:SetParticleControl(particle, 61, Vector(1,1,1))
        end
        ParticleManager:ReleaseParticleIndex( particle )
        self:GetCaster():EmitSound("Ability.LagunaBlade")
    end
    local brew_time = nil
    local modifier_lina_laguna_blade_custom_activate_time = self:GetCaster():FindModifierByName("modifier_lina_laguna_blade_custom_activate_time")
    if modifier_lina_laguna_blade_custom_activate_time then
        brew_time = math.min( GameRules:GetGameTime() - modifier_lina_laguna_blade_custom_activate_time:GetCreationTime(), 5 )
    end
    target:AddNewModifier( self:GetCaster(), self, "modifier_lina_laguna_blade_custom", { duration = delay, brew_time = brew_time } )
end

modifier_lina_laguna_blade_custom = class({})
function modifier_lina_laguna_blade_custom:IsHidden() return true end
function modifier_lina_laguna_blade_custom:IsPurgable() return false end
function modifier_lina_laguna_blade_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_lina_laguna_blade_custom:OnCreated( kv )
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_spell_laguna_blade_shard_units_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:ReleaseParticleIndex(particle)
    self:GetParent():EmitSound("Ability.LagunaBladeImpact")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_lina_18") then
        self.damage = self.damage + self:GetAbility().modifier_lina_18[self:GetCaster():GetTalentLevel("modifier_lina_18")]
    end
    if kv.brew_time ~= nil then
        local max_damage = self.damage + (self.damage / 100 * self:GetAbility().modifier_lina_7)
        self.damage = ((kv.brew_time/5)*(max_damage-self.damage) + self.damage)
    end
end

function modifier_lina_laguna_blade_custom:OnDestroy()
    if not IsServer() then return end
    local end_damage = ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    if self:GetCaster():HasModifier("modifier_lina_4") then
        if end_damage > 0 then
            self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_lina_laguna_blade_custom_barrier", {duration = self:GetAbility().modifier_lina_4_duration, barrier = end_damage})
        end
    end
    local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
    if modifier_lina_fiery_soul_custom then
        modifier_lina_fiery_soul_custom:AddStack()
    end
end

modifier_lina_laguna_blade_custom_barrier = class({})
function modifier_lina_laguna_blade_custom_barrier:GetTexture() return "lina_4" end
function modifier_lina_laguna_blade_custom_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = (kv.barrier or 0) / 100 * self:GetAbility().modifier_lina_4[self:GetCaster():GetTalentLevel("modifier_lina_4")]
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_lina_laguna_blade_custom_barrier:OnRefresh(kv)
    self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = (kv.barrier or 0) / 100 * self:GetAbility().modifier_lina_4[self:GetCaster():GetTalentLevel("modifier_lina_4")]
	if not IsServer() then return end
	self.max_shield = self.max_shield + self.barrier
	self.current_shield = self.current_shield + self.barrier
    self:SendBuffRefreshToClients()
end

function modifier_lina_laguna_blade_custom_barrier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_lina_laguna_blade_custom_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_lina_laguna_blade_custom_barrier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_lina_laguna_blade_custom_barrier:GetModifierIncomingDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
        local shield = self.current_shield
		self:Destroy()
		return -shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

modifier_lina_laguna_blade_custom_buff = class({})
function modifier_lina_laguna_blade_custom_buff:GetTexture() return "lina_11" end

function modifier_lina_laguna_blade_custom_buff:OnCreated()
    if not IsServer() then return end
    self.modifier_lina_fiery_soul_custom = self:GetParent():FindModifierByName("modifier_lina_fiery_soul_custom")
    if self.modifier_lina_fiery_soul_custom then
        self.modifier_lina_fiery_soul_custom:SetMaxStacks(true)
    end
end

function modifier_lina_laguna_blade_custom_buff:OnDestroy()
    if not IsServer() then return end
    if self.modifier_lina_fiery_soul_custom then
        self.modifier_lina_fiery_soul_custom:SetMaxStacks(false, true)
    end
end

modifier_lina_laguna_blade_custom_activate_time = class({})
function modifier_lina_laguna_blade_custom_activate_time:GetTexture() return "lina_7" end
function modifier_lina_laguna_blade_custom_activate_time:IsPurgable() return false end
function modifier_lina_laguna_blade_custom_activate_time:IsPurgeException() return false end
function modifier_lina_laguna_blade_custom_activate_time:OnCreated( kv )
	if not IsServer() then return end
	self.tick_interval = 0.5
	self.tick = kv.duration
	self.tick_halfway = true
	self:StartIntervalThink( self.tick_interval )
    self:OnIntervalThink()
end

function modifier_lina_laguna_blade_custom_activate_time:OnIntervalThink()
	self.tick = self.tick - self.tick_interval
	if self.tick > 0 then
		self.tick_halfway = not self.tick_halfway
		self:PlayEffects2()
		return
	end
	self:Destroy()
end

function modifier_lina_laguna_blade_custom_activate_time:OnDestroy()
    if not IsServer() then return end
    if self.reset_cooldown then return end
    local duration = self:GetElapsedTime()
    local cooldown = self:GetAbility():GetEffectiveCooldown(-1)
    self:GetAbility():StartCooldown(cooldown - duration)
end

function modifier_lina_laguna_blade_custom_activate_time:PlayEffects2()
	local time = math.floor( self.tick )
	local mid = 1
	if self.tick_halfway then mid = 8 end
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/ultimate_timer.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( 1, time, mid ) )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( 2, 0, 0 ) )
	if time < 1 then
		ParticleManager:SetParticleControl( effect_cast, 2, Vector( 1, 0, 0 ) )
	end
	ParticleManager:ReleaseParticleIndex( effect_cast )
end