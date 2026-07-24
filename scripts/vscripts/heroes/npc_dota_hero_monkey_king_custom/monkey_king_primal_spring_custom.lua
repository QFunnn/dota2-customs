--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_monkey_king_primal_spring_custom", "heroes/npc_dota_hero_monkey_king_custom/monkey_king_primal_spring_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_generic_arc_lua", "modifiers/modifier_generic_arc_lua", LUA_MODIFIER_MOTION_BOTH )

monkey_king_primal_spring_custom = class({})
monkey_king_primal_spring_custom.modifier_monkey_king_15 = {80,120,160}
monkey_king_primal_spring_custom.modifier_monkey_king_16 = {-1,-2}

function monkey_king_primal_spring_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_spring_channel.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_spring_cast.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_spring.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_monkey_king/monkey_king_spring_slow.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_monkey_king_spring_slow.vpcf", context )
end

function monkey_king_primal_spring_custom:GetChannelTime()
	if self:GetCaster():HasModifier("modifier_monkey_king_19") then
        return FrameTime()
    end
	return self.BaseClass.GetChannelTime(self)
end

function monkey_king_primal_spring_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_monkey_king_16") then
        bonus = self.modifier_monkey_king_16[self:GetCaster():GetTalentLevel("modifier_monkey_king_16")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function monkey_king_primal_spring_custom:Spawn()
    if not IsServer() then return end
    self:SetActivated(false)
end

function monkey_king_primal_spring_custom:CanBeCast()
    if not self or self:IsNull() then return false end
    local caster = self:GetCaster()
    if caster:HasModifier("modifier_monkey_king_17") and caster:HasModifier("modifier_monkey_king_mischief_custom") then return true end
    if caster:HasModifier("modifier_monkey_king_mischief_custom") then return false end 
    if caster:HasModifier("modifier_monkey_king_tree_dance_custom") then return true end 
    return false
end 

function monkey_king_primal_spring_custom:GetAOERadius()
    return self:GetSpecialValueFor("impact_radius")
end

function monkey_king_primal_spring_custom:GetCastRange(location, target)
    if IsServer() then 
        return 99999
    else 
        return self.BaseClass.GetCastRange(self, location, target)
    end
end

function monkey_king_primal_spring_custom:GetIntrinsicModifierName()
    return "modifier_monkey_king_primal_spring_custom_tracker"
end

function monkey_king_primal_spring_custom:OnSpellStart()
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    self.max_distance = 800 + caster:GetCastRangeBonus()
    local radius = self:GetSpecialValueFor( "impact_radius" )
    local direction = (point-caster:GetOrigin())
    direction.z = 0
    if direction:Length2D() > self.max_distance  then
        point = caster:GetOrigin() + direction:Normalized() * self.max_distance
        point.z = GetGroundHeight( point, caster )
    end
    AddFOWViewer(caster:GetTeamNumber(), point, radius, 2, false)
    caster:StartGesture(ACT_DOTA_MK_SPRING_CAST)
    self.point = point
    if not caster:HasModifier("modifier_monkey_king_tree_dance_custom") then 
        caster:SetOrigin(Vector(caster:GetAbsOrigin().x, caster:GetAbsOrigin().y, caster:GetAbsOrigin().z + 50))
    end
    if self.point == caster:GetAbsOrigin() then 
        self.point = caster:GetAbsOrigin() + caster:GetForwardVector()*25
    end
    self.sub = caster:FindAbilityByName("monkey_king_primal_spring_early_custom")
    self:PlayEffects1()
    self:PlayEffects2( self.point )
    self.new_pct = 0
    if self.sub and not self.sub:IsNull() then
        if caster:HasModifier("modifier_monkey_king_2") then return end
        caster:SwapAbilities( "monkey_king_primal_spring_custom", "monkey_king_primal_spring_early_custom",  false, true )
    end
end

function monkey_king_primal_spring_custom:OnChannelFinish( bInterrupted )
    local caster = self:GetCaster()
    caster:FadeGesture(ACT_DOTA_MK_SPRING_CAST)
    caster:FadeGesture(ACT_DOTA_MK_SPRING_END)
    caster:SetOrigin(Vector(caster:GetAbsOrigin().x, caster:GetAbsOrigin().y, caster:GetAbsOrigin().z - 50))
    local caster = caster
    local point = self.point
    local channel_pct =  math.min(1, (GameRules:GetGameTime() - self:GetChannelStartTime())/self:GetChannelTime() + 0.01)
    local direction = (point-caster:GetOrigin())
    direction.z = 0
    if direction:Length2D()> self.max_distance then
        point = caster:GetOrigin() + direction:Normalized() * self.max_distance
        point.z = GetGroundHeight( point, caster )
    end
    if self.new_pct ~= 0 then 
        channel_pct = self.new_pct
    end
    local speed = 1300
    local distance = (point-caster:GetOrigin()):Length2D()
    local perch_height = -192
    local ground = GetGroundPosition(caster:GetAbsOrigin(), nil)
    local perch_height = -1*(caster:GetAbsOrigin().z - ground.z)
    local height = 160
    if distance < 80 then 
        height = 0
    end
    caster:FaceTowards(point)
    caster:SetForwardVector(direction)
    local arc = caster:AddNewModifier(caster, self, "modifier_generic_arc_lua",
    {
        target_x = point.x,
        target_y = point.y,
        distance = distance,
        speed = speed,
        height = height,
        fix_end = false,
        isStun = true,
        activity = ACT_DOTA_MK_SPRING_SOAR,
        end_offset = perch_height,
        end_anim = ACT_DOTA_MK_SPRING_END,
    })
    if self.sub and not self.sub:IsNull() and not caster:HasModifier("modifier_monkey_king_2") then
        caster:SwapAbilities( "monkey_king_primal_spring_custom", "monkey_king_primal_spring_early_custom", true, false)
    end
    self:StopEffects()
    if not arc then return end
    self:PlayEffects4( arc )
    arc:SetEndCallback(function()
        local dir = caster:GetForwardVector()
        dir.z = 0
        if (caster:GetAbsOrigin() - point):Length2D() > 200 then 
            FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), false)
            return 
        end
        FindClearSpaceForUnit(caster, point, false)
        caster:SetForwardVector(dir)
        self:DealDamage(point, channel_pct)
    end)
end

function monkey_king_primal_spring_custom:DealDamage(point, channel_pct, not_ignore_channel, ignores_targets)
    if not self or self:IsNull() then return end
    if not ignores_targets then ignores_targets = {} end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor( "impact_radius" )
    local damage = self:GetSpecialValueFor( "impact_damage" )
    local duration = self:GetSpecialValueFor( "impact_slow_duration" )
    if self:GetCaster():HasModifier("modifier_monkey_king_15") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_monkey_king_15[self:GetCaster():GetTalentLevel("modifier_monkey_king_15")])
    end
    if self:GetCaster():HasModifier("modifier_monkey_king_19") and not not_ignore_channel then
        channel_pct = 1
    end
    local slow = self:GetSpecialValueFor( "impact_movement_slow" ) * channel_pct
    damage = damage * channel_pct
    local enemies = FindUnitsInRadius( caster:GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false)
    local damageTable = {attacker = caster, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self}
    for _,enemy in pairs(enemies) do
        if not ignores_targets[enemy] then
            damageTable.victim = enemy
            ApplyDamage(damageTable)
            local mod = enemy:FindModifierByName("modifier_monkey_king_primal_spring_custom")
            if not mod then 
                mod = enemy:AddNewModifier( caster, self, "modifier_monkey_king_primal_spring_custom", {duration = duration})
            end
            if mod and mod:GetStackCount() < slow then 
                mod:SetStackCount(slow)
            end
        end
    end
    self:PlayEffects3( point, radius )
end

function monkey_king_primal_spring_custom:DealDamageOnTarget(target, channel_pct, not_ignore_channel, ignores_targets)
    if not self or self:IsNull() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor( "impact_radius" )
    local damage = self:GetSpecialValueFor( "impact_damage" )
    local duration = self:GetSpecialValueFor( "impact_slow_duration" )
    if self:GetCaster():HasModifier("modifier_monkey_king_15") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self.modifier_monkey_king_15[self:GetCaster():GetTalentLevel("modifier_monkey_king_15")])
    end
    if self:GetCaster():HasModifier("modifier_monkey_king_19") and not not_ignore_channel then
        channel_pct = 1
    end
    local slow = self:GetSpecialValueFor( "impact_movement_slow" ) * channel_pct
    damage = damage * channel_pct
    ApplyDamage({attacker = caster, victim = target, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self})
    local mod = target:FindModifierByName("modifier_monkey_king_primal_spring_custom")
    if not mod then 
        mod = target:AddNewModifier( caster, self, "modifier_monkey_king_primal_spring_custom", {duration = duration})
    end
    if mod and mod:GetStackCount() < slow then 
        mod:SetStackCount(slow)
    end
end

function monkey_king_primal_spring_custom:PlayEffects1()
    local caster = self:GetCaster()
    self.effect_cast1 = ParticleManager:CreateParticle( "particles/units/heroes/hero_monkey_king/monkey_king_spring_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster )
    ParticleManager:SetParticleControlEnt( self.effect_cast1, 1, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0,0,0), true)
end

function monkey_king_primal_spring_custom:PlayEffects2( point )
    local caster = self:GetCaster()
    self.effect_cast2 = ParticleManager:CreateParticleForTeam( "particles/units/heroes/hero_monkey_king/monkey_king_spring_cast.vpcf", PATTACH_WORLDORIGIN, caster, caster:GetTeamNumber())
    ParticleManager:SetParticleControl( self.effect_cast2, 0, point )
    ParticleManager:SetParticleControl( self.effect_cast2, 4, point )
    EmitSoundOnLocationWithCaster( point, "Hero_MonkeyKing.Spring.Channel", caster )
end

function monkey_king_primal_spring_custom:PlayEffects3( point, radius )
    local caster = self:GetCaster()
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_monkey_king/monkey_king_spring.vpcf", PATTACH_WORLDORIGIN, caster )
    ParticleManager:SetParticleControl( effect_cast, 0, point )
    ParticleManager:SetParticleControl( effect_cast, 1, Vector( radius, radius, radius ) )
    ParticleManager:ReleaseParticleIndex( effect_cast )
    EmitSoundOnLocationWithCaster( point, "Hero_MonkeyKing.Spring.Impact", caster )
end

function monkey_king_primal_spring_custom:PlayEffects4( modifier )
    local caster = self:GetCaster()
    local effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_monkey_king/monkey_king_jump_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    modifier:AddParticle(effect_cast, false, false,  -1, false, false )
    caster:EmitSound("Hero_MonkeyKing.TreeJump.Cast")
end

function monkey_king_primal_spring_custom:StopEffects()
    if self.effect_cast2 ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast2, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast2 )
    end
    if self.effect_cast1 ~= nil then
        ParticleManager:DestroyParticle( self.effect_cast1, false )
        ParticleManager:ReleaseParticleIndex( self.effect_cast1 )
    end
    StopSoundOn( "Hero_MonkeyKing.Spring.Channel", self:GetCaster() )
end

modifier_monkey_king_primal_spring_custom = class({})
function modifier_monkey_king_primal_spring_custom:IsHidden() return false end
function modifier_monkey_king_primal_spring_custom:IsPurgable() return true end
function modifier_monkey_king_primal_spring_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_monkey_king_primal_spring_custom:GetModifierMoveSpeedBonus_Percentage()
    return -self:GetStackCount()
end

function modifier_monkey_king_primal_spring_custom:GetEffectName()
    return "particles/units/heroes/hero_monkey_king/monkey_king_spring_slow.vpcf"
end

function modifier_monkey_king_primal_spring_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_monkey_king_primal_spring_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_monkey_king_spring_slow.vpcf"
end

function modifier_monkey_king_primal_spring_custom:StatusEffectPriority()
    return MODIFIER_PRIORITY_NORMAL
end

monkey_king_primal_spring_early_custom = class({})

function monkey_king_primal_spring_early_custom:GetAbilityTextureName()
    return "monkey_king_primal_spring"
end

function monkey_king_primal_spring_early_custom:OnSpellStart()
    if not self.main or self.main:IsNull() then return end
    self.main:EndChannel( true )
end