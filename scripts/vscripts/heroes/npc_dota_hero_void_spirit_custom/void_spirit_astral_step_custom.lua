--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_void_spirit_astral_step_custom", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_custom_handler", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_custom_thinker", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_custom_thinker_debuff", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_void_spirit_astral_step_custom_10_buff", "heroes/npc_dota_hero_void_spirit_custom/void_spirit_astral_step_custom", LUA_MODIFIER_MOTION_NONE)

void_spirit_astral_step_custom = class({})

void_spirit_astral_step_custom.modifier_void_spirit_13 = {8,16,24}
void_spirit_astral_step_custom.modifier_void_spirit_9 = {8,12}
void_spirit_astral_step_custom.modifier_void_spirit_9_default_damage = 65
void_spirit_astral_step_custom.modifier_void_spirit_9_default_slow = -20
void_spirit_astral_step_custom.modifier_void_spirit_14 = 75
void_spirit_astral_step_custom.modifier_void_spirit_12 = 3
void_spirit_astral_step_custom.modifier_void_spirit_12_width = 250
void_spirit_astral_step_custom.modifier_void_spirit_12_damage = {25, 50, 75}
void_spirit_astral_step_custom.modifier_void_spirit_10_radius = 800
void_spirit_astral_step_custom.modifier_void_spirit_10_duration = 3
void_spirit_astral_step_custom.modifier_void_spirit_10_speed = 20

function void_spirit_astral_step_custom:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("max_travel_distance")
    end
end

function void_spirit_astral_step_custom:GetAbilityChargeRestoreTime(level)
    local cooldown_reduction = 0
    if self:GetCaster():HasModifier("modifier_void_spirit_14") then
        cooldown_reduction = math.min(self:GetCaster():GetAgility(), 300) / self.modifier_void_spirit_14
    end
    return math.max(1, self.BaseClass.GetAbilityChargeRestoreTime( self, level ) - cooldown_reduction)
end

function void_spirit_astral_step_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf", context )
    PrecacheResource( "particle", "particles/items2_fx/refresher_void_spirit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_thinker.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf", context )
end

function void_spirit_astral_step_custom:Spawn()
    if not IsServer() then return end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_void_spirit_astral_step_custom_handler", {})
end

function void_spirit_astral_step_custom:AddMark(enemy)
    local delay = self:GetSpecialValueFor( "pop_damage_delay" )
    if self:GetLevel() <= 0 then
        delay = 1.25
    end
    enemy:AddNewModifier( self:GetCaster(), self, "modifier_void_spirit_astral_step_custom", {duration = delay} )
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy )
    ParticleManager:ReleaseParticleIndex( effect_cast )
end

function void_spirit_astral_step_custom:OnSpellStart()
    if not IsServer() then return end
    self:CastSpell(self:GetCaster(), self:GetCursorPosition())
    if self:GetCaster():HasModifier("modifier_void_spirit_13") then
        if RollPercentage(self.modifier_void_spirit_13[self:GetCaster():GetTalentLevel("modifier_void_spirit_13")]) then
            Timers:CreateTimer(FrameTime(), function()
                if self:GetCurrentAbilityCharges() < self:GetMaxAbilityCharges(self:GetLevel()) then
                    self:SetCurrentAbilityCharges(self:GetCurrentAbilityCharges() + 1)
                    local particle = ParticleManager:CreateParticle("particles/items2_fx/refresher_void_spirit.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
                    ParticleManager:SetParticleControlEnt(particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
                    ParticleManager:ReleaseParticleIndex(particle)
                end
            end)
        end
    end
end

function void_spirit_astral_step_custom:CastSpell(caster, point)
    local origin = caster:GetOrigin()
    local max_dist = self:GetSpecialValueFor( "max_travel_distance" )
    local min_dist = self:GetSpecialValueFor( "min_travel_distance" )
    if point == origin then 
        point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector()*10
    end
    local vec = (point - caster:GetAbsOrigin())
    if vec:Length2D() > max_dist + caster:GetCastRangeBonus() then 
        point = caster:GetAbsOrigin() + vec:Normalized()*(max_dist + caster:GetCastRangeBonus())
    else 
        if vec:Length2D() < min_dist then 
            point = caster:GetAbsOrigin() + vec:Normalized()*min_dist
        end
    end
    self:Strike(point)
end

function void_spirit_astral_step_custom:Strike(point)
    local caster = self:GetCaster()
    local origin = self:GetCaster():GetAbsOrigin()
    local radius = self:GetSpecialValueFor( "radius" )
    local target = GetGroundPosition( point, nil )
    self:GetCaster():EmitSound("Hero_VoidSpirit.AstralStep.Start")
    FindClearSpaceForUnit( caster, target, true )
    self:GetCaster():EmitSound("Hero_VoidSpirit.AstralStep.End")
    local enemies = FindUnitsInLine( caster:GetTeamNumber(), origin, target, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES )
    for _,enemy in pairs(enemies) do
        self:AddMark(enemy)
        caster:PerformAttack( enemy, true, true, true, false, true, false, true )
    end
    self:GetCaster():StartGesture(ACT_DOTA_CAST_ABILITY_2_END)

    if not self:GetCaster():HasModifier("modifier_void_spirit_12") then
        local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
        ParticleManager:SetParticleControl( effect_cast, 0, origin )
        ParticleManager:SetParticleControl( effect_cast, 1, target )
        ParticleManager:ReleaseParticleIndex( effect_cast )
    end

    if self:GetCaster():HasModifier("modifier_void_spirit_12") then
        CreateModifierThinker(self:GetCaster(), self, "modifier_void_spirit_astral_step_custom_thinker", {point_start_x = origin.x, point_start_y = origin.y, point_start_z = origin.z, point_end_x = target.x, point_end_y = target.y, point_end_z = target.z, duration = self.modifier_void_spirit_12}, origin, self:GetCaster():GetTeamNumber(), false)
    end

    local void_spirit_aether_remnant_custom = self:GetCaster():FindAbilityByName("void_spirit_aether_remnant_custom")
    if self:GetCaster():HasModifier("modifier_void_spirit_7") and void_spirit_aether_remnant_custom then
        local direction = target - origin
        direction.z = 0
        direction = direction:Normalized()
        CreateModifierThinker( self:GetCaster(), void_spirit_aether_remnant_custom, "modifier_custom_void_remnant_thinker", 
        {
            dir_x = direction.x, 
            dir_y = direction.y, 
            dir_z = direction.z,
            new_point_x = origin.x,
            new_point_y = origin.y,
            new_point_z = origin.z,
            new_duration = 4
        },
        origin - self:GetCaster():GetForwardVector() * 10, self:GetCaster():GetTeamNumber(), false)
    end

    if self:GetCaster():HasModifier("modifier_void_spirit_10") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_void_spirit_astral_step_custom_10_buff", {duration = self.modifier_void_spirit_10_duration})
    end
end

modifier_void_spirit_astral_step_custom_thinker = class({})

function modifier_void_spirit_astral_step_custom_thinker:OnCreated(params)
    if not IsServer() then return end
    local origin = Vector(params.point_start_x, params.point_start_y, params.point_start_z)
    local target = Vector(params.point_end_x, params.point_end_y, params.point_end_z)
    self.origin = origin
    self.target = target
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_thinker.vpcf", PATTACH_WORLDORIGIN, self:GetCaster() )
	ParticleManager:SetParticleControl( effect_cast, 0, origin )
	ParticleManager:SetParticleControl( effect_cast, 1, target )
	self:AddParticle( effect_cast, false, false, -1, false, false )
    self:StartIntervalThink(0.2)
end

function modifier_void_spirit_astral_step_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    local enemies = FindUnitsInLine( self:GetCaster():GetTeamNumber(), self.origin, self.target, nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_void_spirit_12_width), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES )
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_void_spirit_astral_step_custom_thinker_debuff", {duration = 0.3})
    end
end

modifier_void_spirit_astral_step_custom = class({})
function modifier_void_spirit_astral_step_custom:IsHidden() return false end
function modifier_void_spirit_astral_step_custom:IsDebuff() return true end
function modifier_void_spirit_astral_step_custom:IsStunDebuff() return false end
function modifier_void_spirit_astral_step_custom:IsPurgable() return true end
function modifier_void_spirit_astral_step_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_void_spirit_astral_step_custom:OnCreated( kv )
    self.slow = -self:GetAbility():GetSpecialValueFor( "movement_slow_pct" )
    if self:GetAbility():GetLevel() <= 0 then
        self.slow = self:GetAbility().modifier_void_spirit_9_default_slow
    end
    if not IsServer() then return end
end

function modifier_void_spirit_astral_step_custom:OnDestroy()
    if not IsServer() then return end
    if not self:GetParent() then return end
    if self:GetParent():IsNull() then return end
    if not self:GetParent():IsAlive() then return end
    self.damage = self:GetAbility():GetSpecialValueFor( "pop_damage" )
    if self:GetAbility():GetLevel() <= 0 then
        self.damage = self:GetAbility().modifier_void_spirit_9_default_damage
    end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_dmg.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:GetParent():EmitSound("Hero_VoidSpirit.AstralStep.MarkExplosion")
end

function modifier_void_spirit_astral_step_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
	}
end

function modifier_void_spirit_astral_step_custom:GetModifierMoveSpeedBonus_Percentage()
	return self.slow
end

function modifier_void_spirit_astral_step_custom:GetEffectName()
	return "particles/units/heroes/hero_void_spirit/astral_step/void_spirit_astral_step_debuff.vpcf"
end

function modifier_void_spirit_astral_step_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_void_spirit_astral_step_custom:GetStatusEffectName()
	return "particles/status_fx/status_effect_void_spirit_astral_step_debuff.vpcf"
end

function modifier_void_spirit_astral_step_custom:StatusEffectPriority()
	return MODIFIER_PRIORITY_NORMAL
end

modifier_void_spirit_astral_step_custom_handler = class({})
function modifier_void_spirit_astral_step_custom_handler:IsHidden() return true end
function modifier_void_spirit_astral_step_custom_handler:IsPurgable() return false end
function modifier_void_spirit_astral_step_custom_handler:IsPurgeException() return false end
function modifier_void_spirit_astral_step_custom_handler:RemoveOnDeath() return false end
function modifier_void_spirit_astral_step_custom_handler:DeclareFunctions()
    return
    {
         
    }
end

function modifier_void_spirit_astral_step_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if not self:GetParent():HasModifier("modifier_void_spirit_9") then return end
    if RollPercentage(self:GetAbility().modifier_void_spirit_9[self:GetCaster():GetTalentLevel("modifier_void_spirit_9")]) then
        self:GetAbility():AddMark(params.target)
    end
end

modifier_void_spirit_astral_step_custom_10_buff = class({})

function modifier_void_spirit_astral_step_custom_10_buff:GetTexture() return "void_spirit_10" end

function modifier_void_spirit_astral_step_custom_10_buff:OnCreated()
    if not IsServer() then return end
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_void_spirit/pulse/void_spirit_pulse_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    self:StartIntervalThink(FrameTime())
end

function modifier_void_spirit_astral_step_custom_10_buff:OnIntervalThink()
    if not IsServer() then return end
    AddFOWViewer(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), self:GetAbility().modifier_void_spirit_10_radius, FrameTime(), false)
end

function modifier_void_spirit_astral_step_custom_10_buff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_void_spirit_astral_step_custom_10_buff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility().modifier_void_spirit_10_speed
end

modifier_void_spirit_astral_step_custom_thinker_debuff = class({})
function modifier_void_spirit_astral_step_custom_thinker_debuff:IsPurgable() return false end
function modifier_void_spirit_astral_step_custom_thinker_debuff:IsPurgeException() return false end

function modifier_void_spirit_astral_step_custom_thinker_debuff:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.5)
    self:OnIntervalThink()
end

function modifier_void_spirit_astral_step_custom_thinker_debuff:OnIntervalThink()
    if not IsServer() then return end
    local damage = self:GetCaster():GetAgility() / 100 * self:GetAbility().modifier_void_spirit_12_damage[self:GetCaster():GetTalentLevel("modifier_void_spirit_12")]
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = damage * 0.5, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end