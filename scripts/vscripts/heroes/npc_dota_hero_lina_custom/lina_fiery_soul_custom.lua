--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_lina_fiery_soul_custom", "heroes/npc_dota_hero_lina_custom/lina_fiery_soul_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_lina_fiery_soul_custom_fired", "heroes/npc_dota_hero_lina_custom/lina_fiery_soul_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_generic_knockback_lua", "modifiers/modifier_generic_knockback_lua", LUA_MODIFIER_MOTION_BOTH )

lina_fiery_soul_custom = class({})
lina_fiery_soul_custom.modifier_lina_10_attack_speed = {4,8}
lina_fiery_soul_custom.modifier_lina_10_move_speed = {0.25,0.5}
lina_fiery_soul_custom.modifier_lina_20 = {4,8,12}
lina_fiery_soul_custom.modifier_lina_19 = {20,40}
lina_fiery_soul_custom.modifier_lina_19_duration = 3

function lina_fiery_soul_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf", context)
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_lina.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_lina.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_lina.vpcf", context)
    PrecacheResource("particle", "particles/lina/ember_spirit_hit.vpcf", context)
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context )
end

function lina_fiery_soul_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_lina_20") then
        return "lina_20"
    end
    return "lina_fiery_soul"
end

function lina_fiery_soul_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_lina_20") then
        return 30
    end
end

function lina_fiery_soul_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_lina_20") then
        return 700
    end
end

function lina_fiery_soul_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_lina_20") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

function lina_fiery_soul_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_lina_20") then
        return 400
    end
end

function lina_fiery_soul_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local radius = 400
    local particle = ParticleManager:CreateParticle("particles/lina/ember_spirit_hit.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, point)
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(particle)
    EmitSoundOnLocationWithCaster(point, "Hero_EmberSpirit.FireRemnant.Explode", self:GetCaster())
    local modifier_lina_fiery_soul_custom = self:GetCaster():FindModifierByName("modifier_lina_fiery_soul_custom")
    local units = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        local distance = (unit:GetAbsOrigin() - point):Length2D()
        local knockback_distance = radius - distance
        local dir = (unit:GetAbsOrigin() - point)
        dir.z = 0
        dir = dir:Normalized()
        if modifier_lina_fiery_soul_custom and unit:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
            modifier_lina_fiery_soul_custom:AddStack()
        end
        unit:AddNewModifier( self:GetCaster(), self, "modifier_generic_knockback_lua", { duration = 0.2, distance = knockback_distance, height = 0, direction_x = dir.x, direction_y = dir.y})
    end
end

function lina_fiery_soul_custom:GetIntrinsicModifierName()
    return "modifier_lina_fiery_soul_custom"
end

modifier_lina_fiery_soul_custom = class({})
function modifier_lina_fiery_soul_custom:IsHidden() return self:GetStackCount() == 0 end
function modifier_lina_fiery_soul_custom:IsPurgable() return false end
function modifier_lina_fiery_soul_custom:DestroyOnExpire() return false end
function modifier_lina_fiery_soul_custom:GetTexture() return "lina_fiery_soul" end

function modifier_lina_fiery_soul_custom:IsAura()
    return self:GetCaster():HasModifier("modifier_lina_19")
end

function modifier_lina_fiery_soul_custom:GetModifierAura()
    return "modifier_lina_fiery_soul_custom_fired"
end

function modifier_lina_fiery_soul_custom:GetAuraRadius()
    return self:GetCaster():GetAoeBonus(375)
end

function modifier_lina_fiery_soul_custom:GetAuraDuration()
    return self:GetAbility().modifier_lina_19_duration
end

function modifier_lina_fiery_soul_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_lina_fiery_soul_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_lina_fiery_soul_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

function modifier_lina_fiery_soul_custom:OnCreated()
    self.fiery_soul_attack_speed_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_attack_speed_bonus")
    self.fiery_soul_move_speed_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_move_speed_bonus")
    self.fiery_soul_max_stacks = self:GetAbility():GetSpecialValueFor("fiery_soul_max_stacks")
    self.fiery_soul_stack_duration = self:GetAbility():GetSpecialValueFor("fiery_soul_stack_duration")
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_lina/lina_fiery_soul.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:SetParticleControl( self.particle, 1, Vector( self:GetStackCount(), 0, 0 ) )
    self:AddParticle( self.particle, false, false, -1, false, false  )
end

function modifier_lina_fiery_soul_custom:OnRefresh( kv )
    self.fiery_soul_attack_speed_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_attack_speed_bonus")
    self.fiery_soul_move_speed_bonus = self:GetAbility():GetSpecialValueFor("fiery_soul_move_speed_bonus")
    self.fiery_soul_max_stacks = self:GetAbility():GetSpecialValueFor("fiery_soul_max_stacks")
    self.fiery_soul_stack_duration = self:GetAbility():GetSpecialValueFor("fiery_soul_stack_duration")
end

function modifier_lina_fiery_soul_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_lina_fiery_soul_custom:AddStack()
    if not IsServer() then return end 
    local fiery_soul_max_stacks = self.fiery_soul_max_stacks
    local modifier_lina_laguna_blade_custom_buff = self:GetParent():FindModifierByName("modifier_lina_laguna_blade_custom_buff")
    if modifier_lina_laguna_blade_custom_buff then
        fiery_soul_max_stacks = modifier_lina_laguna_blade_custom_buff:GetAbility().modifier_lina_11[self:GetCaster():GetTalentLevel("modifier_lina_11")]
    end
    local update_stack = math.min(self:GetStackCount() + 1, fiery_soul_max_stacks)
    self:SetStackCount(update_stack)
    self:SetDuration( self.fiery_soul_stack_duration, true )
    self:StartIntervalThink( self.fiery_soul_stack_duration )
    ParticleManager:SetParticleControl( self.particle, 1, Vector( self:GetStackCount(), 0, 0 ) )
end

function modifier_lina_fiery_soul_custom:SetMaxStacks(full, no_upd_time)
    if not IsServer() then return end 
    local fiery_soul_max_stacks = self.fiery_soul_max_stacks
    local modifier_lina_laguna_blade_custom_buff = self:GetParent():FindModifierByName("modifier_lina_laguna_blade_custom_buff")
    if modifier_lina_laguna_blade_custom_buff and full then
        fiery_soul_max_stacks = modifier_lina_laguna_blade_custom_buff:GetAbility().modifier_lina_11[self:GetCaster():GetTalentLevel("modifier_lina_11")]
    end
    self:SetStackCount(fiery_soul_max_stacks)
    if not no_upd_time then
        self:SetDuration( self.fiery_soul_stack_duration, true )
        self:StartIntervalThink( self.fiery_soul_stack_duration )
    end
    ParticleManager:SetParticleControl( self.particle, 1, Vector( self:GetStackCount(), 0, 0 ) )
end 

function modifier_lina_fiery_soul_custom:GetModifierMoveSpeedBonus_Percentage( params )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_10") then
        bonus = self:GetAbility().modifier_lina_10_move_speed[self:GetCaster():GetTalentLevel("modifier_lina_10")]
    end
    return self:GetStackCount() * (self.fiery_soul_move_speed_bonus + bonus)
end

function modifier_lina_fiery_soul_custom:GetModifierAttackSpeedBonus_Constant( params )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_10") then
        bonus = self:GetAbility().modifier_lina_10_attack_speed[self:GetCaster():GetTalentLevel("modifier_lina_10")]
    end
    return self:GetStackCount() * (self.fiery_soul_attack_speed_bonus + bonus)
end

function modifier_lina_fiery_soul_custom:GetModifierConstantHealthRegen()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_lina_20") then
        bonus = self:GetAbility().modifier_lina_20[self:GetCaster():GetTalentLevel("modifier_lina_20")]
    end
    return bonus * self:GetStackCount()
end

function modifier_lina_fiery_soul_custom:OnIntervalThink()
    if not IsServer() then return end
    self:StartIntervalThink( -1 )
    self:SetStackCount( 0 )
    ParticleManager:SetParticleControl( self.particle, 1, Vector( self:GetStackCount(), 0, 0 ) )
end

function modifier_lina_fiery_soul_custom:OnTakeDamage(params)
    if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end
	if self:GetParent():PassivesDisabled() then return end
	if not params.inflictor then return end
	if params.inflictor:IsItem() or params.inflictor:IsToggle() then return end
    if self:GetParent():GetUnitName() == "npc_dota_hero_lina" then return end
	self:AddStack()
end

modifier_lina_fiery_soul_custom_fired = class({})
function modifier_lina_fiery_soul_custom_fired:GetTexture() return "lina_19" end

function modifier_lina_fiery_soul_custom_fired:OnCreated()
    if not IsServer() then return end
    self.damage = self:GetAbility().modifier_lina_19[self:GetCaster():GetTalentLevel("modifier_lina_19")]
    self:StartIntervalThink(0.5)
end

function modifier_lina_fiery_soul_custom_fired:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_lina_fiery_soul_custom_fired:GetEffectName()
    return "particles/units/heroes/hero_jakiro/jakiro_liquid_fire_debuff.vpcf"
end

function modifier_lina_fiery_soul_custom_fired:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end