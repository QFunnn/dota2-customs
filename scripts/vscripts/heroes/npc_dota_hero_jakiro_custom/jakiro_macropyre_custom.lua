--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_jakiro_macropyre_custom", "heroes/npc_dota_hero_jakiro_custom/jakiro_macropyre_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_macropyre_custom_thinker", "heroes/npc_dota_hero_jakiro_custom/jakiro_macropyre_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_macropyre_custom_thinker_aoe", "heroes/npc_dota_hero_jakiro_custom/jakiro_macropyre_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_macropyre_custom_handler", "heroes/npc_dota_hero_jakiro_custom/jakiro_macropyre_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_jakiro_macropyre_custom_thinker_wall", "heroes/npc_dota_hero_jakiro_custom/jakiro_macropyre_custom", LUA_MODIFIER_MOTION_NONE )

jakiro_macropyre_custom = class({})

jakiro_macropyre_custom.modifier_jakiro_5 = {-19,-38,-57}
jakiro_macropyre_custom.modifier_jakiro_10_duration = 2
jakiro_macropyre_custom.modifier_jakiro_10_radius = 250
jakiro_macropyre_custom.modifier_jakiro_10_attack_counter = {16,12}

function jakiro_macropyre_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf", context)
    PrecacheResource("particle", "particles/jakiro_custom/jakiro_macropyre_aoe.vpcf", context)
    PrecacheResource("particle", "particles/jakiro_custom/jakiro_fissure.vpcf", context)
end

function jakiro_macropyre_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_jakiro_5") then
        bonus = self.modifier_jakiro_5[self:GetCaster():GetTalentLevel("modifier_jakiro_5")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function jakiro_macropyre_custom:GetIntrinsicModifierName()
    return "modifier_jakiro_macropyre_custom_handler"
end

function jakiro_macropyre_custom:OnSpellStart()
    if not IsServer() then return end
	local point = self:GetCursorPosition()
	local dir = point - self:GetCaster():GetOrigin()
	dir.z = 0
	dir = dir:Normalized()
	local duration = self:GetSpecialValueFor( "duration" )
	CreateModifierThinker( self:GetCaster(), self, "modifier_jakiro_macropyre_custom_thinker", { duration = duration, x = dir.x, y = dir.y}, self:GetCaster():GetOrigin(), self:GetCaster():GetTeamNumber(), false)
	self:GetCaster():EmitSound("Hero_Jakiro.Macropyre.Cast")
end

function jakiro_macropyre_custom:CreateTargetAoeMacropyre(target)
    CreateModifierThinker( self:GetCaster(), self, "modifier_jakiro_macropyre_custom_thinker_aoe", { duration = self.modifier_jakiro_10_duration }, target:GetOrigin(), self:GetCaster():GetTeamNumber(), false)
end

modifier_jakiro_macropyre_custom_thinker = class({})

function modifier_jakiro_macropyre_custom_thinker:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
    self.effect_duration = self:GetAbility():GetSpecialValueFor("duration")
	self.radius = self:GetAbility():GetSpecialValueFor( "path_width" ) / 2
	self.duration = self:GetAbility():GetSpecialValueFor( "linger_duration" )
	self.interval = self:GetAbility():GetSpecialValueFor( "burn_interval" )
	self.range = self:GetAbility():GetCastRange( self.parent:GetAbsOrigin(), nil ) + self.caster:GetCastRangeBonus()
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
	local start_range = 234
	self.direction = Vector( kv.x, kv.y, 0 )
	self.startpoint = self.parent:GetOrigin() + self.direction * start_range
	self.endpoint = self.startpoint + self.direction * self.range

	local step = 0
	while step < self.range do
		local loc = self.startpoint + self.direction * step
		step = step + self.radius
	end

    self.walls = {}

    if self:GetCaster():HasModifier("modifier_jakiro_7") then
        self:CreateWalls(self.startpoint, self.endpoint, "left", self.direction)
        self:CreateWalls(self.startpoint, self.endpoint, "right", self.direction)
    end

	local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_jakiro/jakiro_macropyre.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.startpoint )
	ParticleManager:SetParticleControl( effect_cast, 1, self.endpoint )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.effect_duration, 0, 0 ) )
    ParticleManager:SetParticleControl( effect_cast, 4, Vector( self.radius, 0, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
    self:GetParent():EmitSound("hero_jakiro.macropyre")
    self:StartIntervalThink( self.interval )
end

function modifier_jakiro_macropyre_custom_thinker:CreateWalls(startpoint, endpoint, pos, dir)
    if pos == "right" then
        startpoint = RotatePosition(startpoint, QAngle(0,90,0), startpoint + dir * self.radius)
        endpoint = RotatePosition(endpoint, QAngle(0,90,0), endpoint + dir * self.radius)
    else
        startpoint = RotatePosition(startpoint, QAngle(0,-90,0), startpoint + dir * self.radius)
        endpoint = RotatePosition(endpoint, QAngle(0,-90,0), endpoint + dir * self.radius)
    end
    local direction = (endpoint - startpoint):Normalized()
    local length = (endpoint - startpoint):Length()
    local block_width = 24
	local block_delta = 8.25
    local block_spacing = (block_delta+2*block_width)
	local blocks = self.range/block_spacing
	local block_pos = self:GetCaster():GetHullRadius() + block_delta + block_width
	for i=1, blocks do
		local block_vec = startpoint + direction * block_pos
		local blocker = CreateModifierThinker( self:GetCaster(), self:GetAbility(), "modifier_jakiro_macropyre_custom_thinker_wall", { duration = self:GetRemainingTime() }, block_vec, self:GetCaster():GetTeamNumber(), true )
		blocker:SetHullRadius( block_width )
        ResolveNPCPositions( block_vec, block_width )
		block_pos = block_pos + block_spacing
        table.insert(self.walls, blocker)
	end
    local particle = ParticleManager:CreateParticle("particles/jakiro_custom/jakiro_fissure.vpcf", PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl( particle, 0, startpoint )
	ParticleManager:SetParticleControl( particle, 1, endpoint )
	ParticleManager:SetParticleControl( particle, 2, Vector( self:GetRemainingTime(), 0, 0 ) )
	ParticleManager:ReleaseParticleIndex( particle )
end

function modifier_jakiro_macropyre_custom_thinker:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
    if #self.walls > 0 then
        for _, wall in pairs(self.walls) do
            if wall and not wall:IsNull() then
                UTIL_Remove(wall)
            end
        end
    end
end

function modifier_jakiro_macropyre_custom_thinker:OnIntervalThink()
    print(self.radius)
	local enemies = FindUnitsInLine( self.caster:GetTeamNumber(), self.startpoint, self.endpoint, nil, self.radius, self.abilityTargetTeam, self.abilityTargetType, self.abilityTargetFlags )
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( self.caster, self:GetAbility(), "modifier_jakiro_macropyre_custom", {duration = self.duration, interval = self.interval, damage = self.damage * self.interval, damage_type = self.abilityDamageType})
	end
end

modifier_jakiro_macropyre_custom = class({})

function modifier_jakiro_macropyre_custom:OnCreated( kv )
	if not IsServer() then return end
	local interval = kv.interval
	local damage = kv.damage
	local damage_type = kv.damage_type
    local ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_jakiro_7") then
        damage_type = DAMAGE_TYPE_PURE
        ability = self:GetCaster():FindAbilityByName("jakiro_macropyre_custom_magic_immune")
    end
	self.damageTable = 
    {
		victim = self:GetParent(),
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = damage_type,
		ability = ability,
        damage_flags = flag
	}
	self:StartIntervalThink( interval )
end

function modifier_jakiro_macropyre_custom:OnRefresh( kv )
	if not IsServer() then return end
	local damage = kv.damage
	local damage_type = kv.damage_type
    local ability = self:GetAbility()
    if self:GetCaster():HasModifier("modifier_jakiro_7") then
        damage_type = DAMAGE_TYPE_PURE
        ability = self:GetCaster():FindAbilityByName("jakiro_macropyre_custom_magic_immune")
    end
	self.damageTable.damage = damage
	self.damageTable.damage_type = damage_type
    self.damageTable.damage_flags = flag
    self.damageTable.ability = ability
end

function modifier_jakiro_macropyre_custom:OnIntervalThink()
	ApplyDamage( self.damageTable )
end

function modifier_jakiro_macropyre_custom:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_jakiro_macropyre_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_jakiro_macropyre_custom_handler = class({})
function modifier_jakiro_macropyre_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_jakiro_10") end
function modifier_jakiro_macropyre_custom_handler:GetTexture() return "jakiro_10" end
function modifier_jakiro_macropyre_custom_handler:IsPurgable() return false end
function modifier_jakiro_macropyre_custom_handler:IsPurgeException() return false end
function modifier_jakiro_macropyre_custom_handler:RemoveOnDeath() return false end
function modifier_jakiro_macropyre_custom_handler:DeclareFunctions()
    return
    {
         
    }
end
function modifier_jakiro_macropyre_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetCaster():HasModifier("modifier_jakiro_10") then return end
    if self:GetCaster():HasModifier("modifier_jakiro_16") then return end
    self:IncrementStackCount()
    if self:GetStackCount() >= self:GetAbility().modifier_jakiro_10_attack_counter[self:GetCaster():GetTalentLevel("modifier_jakiro_10")] then
        self:GetAbility():CreateTargetAoeMacropyre(params.target)
        self:SetStackCount(0)
    end
end

modifier_jakiro_macropyre_custom_thinker_aoe = class({})

function modifier_jakiro_macropyre_custom_thinker_aoe:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
    self.effect_duration = self:GetAbility():GetSpecialValueFor("duration")
	self.radius = self:GetCaster():GetAoeBonus(self:GetAbility():GetSpecialValueFor( "path_width" ))
	self.duration = self:GetAbility():GetSpecialValueFor( "linger_duration" )
	self.interval = self:GetAbility():GetSpecialValueFor( "burn_interval" )
	self.range = self:GetAbility():GetCastRange( self.parent:GetAbsOrigin(), nil ) + self.caster:GetCastRangeBonus()
	self.damage = self:GetAbility():GetSpecialValueFor( "damage" )
	if not IsServer() then return end
	self.abilityDamageType = self:GetAbility():GetAbilityDamageType()
	self.abilityTargetTeam = self:GetAbility():GetAbilityTargetTeam()
	self.abilityTargetType = self:GetAbility():GetAbilityTargetType()
	self.abilityTargetFlags = self:GetAbility():GetAbilityTargetFlags()
	local start_range = 234
	self.direction = Vector( kv.x, kv.y, 0 )
	self.startpoint = self.parent:GetOrigin() + self.direction * start_range
	self.endpoint = self.startpoint + self.direction * self.range
	local effect_cast = ParticleManager:CreateParticle( "particles/jakiro_custom/jakiro_macropyre_aoe.vpcf", PATTACH_WORLDORIGIN, self.parent )
	ParticleManager:SetParticleControl( effect_cast, 0, self.startpoint )
	ParticleManager:SetParticleControl( effect_cast, 1, self.endpoint )
	ParticleManager:SetParticleControl( effect_cast, 2, Vector( self.effect_duration, 170, 0 ) )
	self:AddParticle( effect_cast, false, false, -1, false, false )
    self:GetParent():EmitSound("hero_jakiro.macropyre")
    self:StartIntervalThink( self.interval )
end

function modifier_jakiro_macropyre_custom_thinker_aoe:OnDestroy()
	if not IsServer() then return end
	UTIL_Remove( self:GetParent() )
end

function modifier_jakiro_macropyre_custom_thinker_aoe:OnIntervalThink()
	local enemies = FindUnitsInLine( self.caster:GetTeamNumber(), self.startpoint, self.endpoint, nil, self.radius, self.abilityTargetTeam, self.abilityTargetType, self.abilityTargetFlags )
	for _,enemy in pairs(enemies) do
		enemy:AddNewModifier( self.caster, self:GetAbility(), "modifier_jakiro_macropyre_custom", {duration = self.duration, interval = self.interval, damage = self.damage * self.interval, damage_type = self.abilityDamageType})
	end
end

modifier_jakiro_macropyre_custom_thinker_wall = class({})

function modifier_jakiro_macropyre_custom_thinker_wall:IsAura()
    return true
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetModifierAura()
    return "modifier_earthshaker_fissure_shard_pathing"
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraEntityReject(hEntity)
    if hEntity == self:GetCaster() then
        return false
    end
    return true
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraRadius()
    return 150
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraDuration()
    return 0.5
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_jakiro_macropyre_custom_thinker_wall:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end