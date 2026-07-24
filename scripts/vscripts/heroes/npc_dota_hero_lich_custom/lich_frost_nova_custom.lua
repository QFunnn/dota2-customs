--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_frost_nova_custom", "heroes/npc_dota_hero_lich_custom/lich_frost_nova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_nova_custom_hp_regen", "heroes/npc_dota_hero_lich_custom/lich_frost_nova_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_frost_nova_custom_thinker_cast", "heroes/npc_dota_hero_lich_custom/lich_frost_nova_custom", LUA_MODIFIER_MOTION_NONE)

lich_frost_nova_custom = class({})

lich_frost_nova_custom.modifier_lich_20 = {40,80,120}
lich_frost_nova_custom.modifier_lich_19_max_stacks = 15
lich_frost_nova_custom.modifier_lich_19_duration = 7
lich_frost_nova_custom.modifier_lich_19 = {5,8,11}

function lich_frost_nova_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lich_20") then
        bonus = self.modifier_lich_20[self:GetCaster():GetTalentLevel("modifier_lich_20")]
    end
	return self:GetSpecialValueFor( "radius" ) + bonus
end

function lich_frost_nova_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    self:CastFrostNova(target, nil)
    self:ApplyFrostStack()
end

function lich_frost_nova_custom:ApplyFrostStack()
    if self:GetCaster():HasModifier("modifier_lich_19") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_lich_frost_nova_custom_hp_regen", {duration = self.modifier_lich_19_duration})
    end
end

function lich_frost_nova_custom:CastFrostNova(target, point, new_caster)
    if not IsServer() then return end
    local damage = self:GetAbilityDamage()
	local duration = self:GetDuration()
	local damage_aoe = self:GetSpecialValueFor("aoe_damage")
	local radius = self:GetSpecialValueFor("radius")
    local caster = self:GetCaster()
    if new_caster then
        caster = new_caster
    end

    if caster:HasModifier("modifier_lich_20") then
        damage = damage + self.modifier_lich_20[caster:GetTalentLevel("modifier_lich_20")]
        damage_aoe = damage_aoe + self.modifier_lich_20[caster:GetTalentLevel("modifier_lich_20")]
        radius = radius + self.modifier_lich_20[caster:GetTalentLevel("modifier_lich_20")]
    end

    if target ~= nil then
        if target:TriggerSpellAbsorb( self ) then
            self:PlayEffects()
            return
        end
        local enemies = FindUnitsInRadius( caster:GetTeamNumber(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        local damageTable = { victim = target, attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
        if target:GetTeamNumber() ~= caster:GetTeamNumber() then
            ApplyDamage(damageTable)
        end
        damageTable.damage = damage_aoe
        for _,enemy in pairs(enemies) do
            damageTable.victim = enemy
            ApplyDamage( damageTable )
            enemy:AddNewModifier( caster, self, "modifier_lich_frost_nova_custom", { duration = duration * (1-enemy:GetStatusResistance()) } )
        end
        self:PlayEffects( target, radius )
    end

    if point ~= nil then
        local enemies = FindUnitsInRadius( caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )
        local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self }
        for _,enemy in pairs(enemies) do
            damageTable.victim = enemy
            ApplyDamage( damageTable )
            enemy:AddNewModifier( caster, self, "modifier_lich_frost_nova_custom", { duration = duration * (1-enemy:GetStatusResistance()) } )
        end
        self:PlayEffectsPoint( point, radius )
    end 
end

function lich_frost_nova_custom:PlayEffects( target, radius )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lich/lich_frost_nova.vpcf", PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	target:EmitSound("Ability.FrostNova")
end

function lich_frost_nova_custom:PlayEffectsPoint( point, radius )
	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_lich/lich_frost_nova.vpcf", PATTACH_WORLDORIGIN, nil )
    ParticleManager:SetParticleControl( effect_cast, 0, point )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
	ParticleManager:ReleaseParticleIndex( effect_cast )
	EmitSoundOnLocationWithCaster(point, "Ability.FrostNova", self:GetCaster())
end

modifier_lich_frost_nova_custom = class({})

function modifier_lich_frost_nova_custom:OnCreated( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_primary" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" )
end

function modifier_lich_frost_nova_custom:OnRefresh( kv )
	self.as_slow = self:GetAbility():GetSpecialValueFor( "slow_attack_speed_primary" )
	self.ms_slow = self:GetAbility():GetSpecialValueFor( "slow_movement_speed" )
end

function modifier_lich_frost_nova_custom:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end
function modifier_lich_frost_nova_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.ms_slow
end
function modifier_lich_frost_nova_custom:GetModifierAttackSpeedBonus_Constant()
	return self.as_slow
end
function modifier_lich_frost_nova_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_frost_lich.vpcf"
end

modifier_lich_frost_nova_custom_hp_regen = class({})
function modifier_lich_frost_nova_custom_hp_regen:GetTexture() return "lich_19" end
function modifier_lich_frost_nova_custom_hp_regen:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(1)
end
function modifier_lich_frost_nova_custom_hp_regen:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() < self:GetAbility().modifier_lich_19_max_stacks then
        self:IncrementStackCount()
    end
    self:GetCaster():CalculateStatBonus(true)
end
function modifier_lich_frost_nova_custom_hp_regen:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT
    }
end
function modifier_lich_frost_nova_custom_hp_regen:GetModifierConstantHealthRegen()
    return self:GetStackCount() * self:GetAbility().modifier_lich_19[self:GetCaster():GetTalentLevel("modifier_lich_19")]
end

--------------------------------------------------------------------------------------------------------------------------------

lich_frost_nova_ring_custom = class({})

function lich_frost_nova_ring_custom:OnSpellStart()
    if not IsServer() then return end
    local points = {}
    local i = 0
    local delay = 0.1
    local number = 5
    local radius = self:GetSpecialValueFor("radius")
    local line_position = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * radius
    local qangle_rotation_rate = 360 / number

    for i = 1, number do
        local qangle = QAngle(0, qangle_rotation_rate, 0)
        line_position = RotatePosition(self:GetCaster():GetAbsOrigin() , qangle, line_position)
        local pos = line_position
        Timers:CreateTimer(delay*i, function()
            CreateModifierThinker(self:GetCaster(), self, "modifier_lich_frost_nova_custom_thinker_cast", {duration = 0.5}, pos, self:GetCaster():GetTeamNumber(), false)
        end)
    end

    local lich_frost_nova_custom = self:GetCaster():FindAbilityByName("lich_frost_nova_custom")
    if lich_frost_nova_custom then
        lich_frost_nova_custom:ApplyFrostStack()
    end
end

lich_frost_nova_line_custom = class({})

function lich_frost_nova_line_custom:OnSpellStart()
    if not IsServer() then return end
    local points = {}
    local i = 0
    local delay = 0.1
    local number = 5
    local point = self:GetCursorPosition()
    local direction = point - self:GetCaster():GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()
    local range = self:GetSpecialValueFor("range") + self:GetCaster():GetCastRangeBonus()
    local step = range / number
    for i = 1, number do
        local pos = self:GetCaster():GetAbsOrigin() + direction * (i*step)
        Timers:CreateTimer(delay*i, function()
            CreateModifierThinker(self:GetCaster(), self, "modifier_lich_frost_nova_custom_thinker_cast", {duration = 0.5}, pos, self:GetCaster():GetTeamNumber(), false)
        end)
    end
    local lich_frost_nova_custom = self:GetCaster():FindAbilityByName("lich_frost_nova_custom")
    if lich_frost_nova_custom then
        lich_frost_nova_custom:ApplyFrostStack()
    end
end

modifier_lich_frost_nova_custom_thinker_cast = class({})
function modifier_lich_frost_nova_custom_thinker_cast:IsHidden() return false end
function modifier_lich_frost_nova_custom_thinker_cast:IsPurgable() return false end
function modifier_lich_frost_nova_custom_thinker_cast:OnCreated(table)
    if not IsServer() then return end
    local caster_original = self:GetCaster()
    if self:GetAbility().original_owner then
        caster_original = self:GetAbility().original_owner
    end
    local lich_frost_nova_custom = caster_original:FindAbilityByName("lich_frost_nova_custom")
    local radius = lich_frost_nova_custom:GetSpecialValueFor("radius")
    if caster_original:HasModifier("modifier_lich_20") then
        radius = radius + lich_frost_nova_custom.modifier_lich_20[caster_original:GetTalentLevel("modifier_lich_20")]
    end
    self.effect_cast = ParticleManager:CreateParticle("particles/units/heroes/hero_snapfire/hero_snapfire_ultimate_calldown.vpcf", PATTACH_CUSTOMORIGIN, self:GetParent())
    ParticleManager:SetParticleControl( self.effect_cast, 0, self:GetParent():GetOrigin() )
    ParticleManager:SetParticleControl( self.effect_cast, 1, Vector( radius, 0, -radius) )
    ParticleManager:SetParticleControl( self.effect_cast, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
end
function modifier_lich_frost_nova_custom_thinker_cast:OnDestroy(table)
    if not IsServer() then return end
    if self.effect_cast then
        ParticleManager:DestroyParticle( self.effect_cast, true )
        ParticleManager:ReleaseParticleIndex( self.effect_cast )
    end
    local caster_original = self:GetCaster()
    if self:GetAbility().original_owner then
        caster_original = self:GetAbility().original_owner
    end
    local lich_frost_nova_custom = caster_original:FindAbilityByName("lich_frost_nova_custom")
    if lich_frost_nova_custom and lich_frost_nova_custom:GetLevel() > 0 then
        lich_frost_nova_custom:CastFrostNova(nil, self:GetParent():GetAbsOrigin(), self:GetCaster())
    end
end





