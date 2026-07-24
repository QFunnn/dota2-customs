--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_swashbuckle_custom_dash", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_HORIZONTAL)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_attacks", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_wait", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_handler", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_handler_debuff", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_handler_debuff_hidden", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_pangolier_swashbuckle_custom_debuff", "heroes/npc_dota_hero_pangolier_custom/pangolier_swashbuckle_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_swashbuckle_custom = class({})
pangolier_swashbuckle_custom.modifier_pangolier_8 = {-1,-2,-3}
pangolier_swashbuckle_custom.modifier_pangolier_9 = {150,300}
pangolier_swashbuckle_custom.modifier_pangolier_10 = {20,40}
pangolier_swashbuckle_custom.modifier_pangolier_12 = {8,16,24}
pangolier_swashbuckle_custom.modifier_pangolier_14 = 150
pangolier_swashbuckle_custom.modifier_pangolier_14_attacks = 5

function pangolier_swashbuckle_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" , context )
    PrecacheResource( "particle", "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", context )
end

function pangolier_swashbuckle_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_pangolier_8") then
        bonus = self.modifier_pangolier_8[self:GetCaster():GetTalentLevel("modifier_pangolier_8")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function pangolier_swashbuckle_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_pangolier_3") then
        return 0 
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function pangolier_swashbuckle_custom:GetCastPoint()
    if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") then
        return 0
    end
    return self.BaseClass.GetCastPoint(self)
end

function pangolier_swashbuckle_custom:GetIntrinsicModifierName()
    return "modifier_pangolier_swashbuckle_custom_handler"
end

function pangolier_swashbuckle_custom:OnVectorCastStart(vStartLocation, vDirection)
    local caster = self:GetCaster()
    local is_use_from_ulti = false
    local modifier_pangolier_rollup_custom = caster:FindModifierByName("modifier_pangolier_rollup_custom")
    if modifier_pangolier_rollup_custom then
        is_use_from_ulti = true
        modifier_pangolier_rollup_custom:Destroy()
    end
    local modifier_pangolier_gyroshell_custom = caster:FindModifierByName("modifier_pangolier_gyroshell_custom")
    if modifier_pangolier_gyroshell_custom then
        is_use_from_ulti = true
        modifier_pangolier_gyroshell_custom:Destroy()
    end
    caster:StartGesture(ACT_DOTA_CAST_ABILITY_1)
    local point = vStartLocation
    local vector_point = point + vDirection*self:GetSpecialValueFor("range")
    local speed = self:GetSpecialValueFor( "dash_speed" )
    local direction = vDirection
    local vector = (point-caster:GetOrigin())
    local dist = vector:Length2D()
    vector.z = 0
    vector = vector:Normalized()
    caster:SetForwardVector( direction )
    caster:AddNewModifier(caster, self, "modifier_pangolier_swashbuckle_custom_dash", 
    {
        x = point.x, 
        y = point.y, 
        z = point.z, 
        dist = dist,
        attacks_x = direction.x,
        attacks_y = direction.y,
        duration = dist/speed,
    })

    if is_use_from_ulti and self:GetCaster():HasModifier("modifier_pangolier_11") then
        Timers:CreateTimer(FrameTime(), function()
            self:EndCooldown()
        end)
    end
end

function pangolier_swashbuckle_custom:DealDamage(target, id)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local modifier_unique = target:FindModifierByName("modifier_pangolier_swashbuckle_custom_handler_debuff_hidden")
    if modifier_unique and modifier_unique.id ~= id then
        return
    end
    self.passive = caster:FindAbilityByName("pangolier_lucky_shot_custom")
    if self.passive and self.passive:GetLevel() > 0 then 
        self.passive:ProcPassive(target, false)
    end
    caster:PerformAttack( target, true, true, true, false, false, false, true )
    target:EmitSound("Hero_Pangolier.Swashbuckle.Damage")
    target:AddNewModifier(self:GetCaster(), self, "modifier_pangolier_swashbuckle_custom_debuff", {duration = self:GetSpecialValueFor("slow_duration") * (1-target:GetStatusResistance())})
    local modifier_pangolier_swashbuckle_custom_handler_debuff_hidden = target:AddNewModifier(self:GetCaster(), self, "modifier_pangolier_swashbuckle_custom_handler_debuff_hidden", {duration = 0.2})
    if modifier_pangolier_swashbuckle_custom_handler_debuff_hidden then
        modifier_pangolier_swashbuckle_custom_handler_debuff_hidden.id = id
    end
end
    
modifier_pangolier_swashbuckle_custom_dash = class({})
function modifier_pangolier_swashbuckle_custom_dash:IsDebuff() return false end
function modifier_pangolier_swashbuckle_custom_dash:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_dash:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_dash:GetOverrideAnimation() return ACT_DOTA_CAST_ABILITY_1 end
function modifier_pangolier_swashbuckle_custom_dash:GetModifierDisableTurning() return 1 end
function modifier_pangolier_swashbuckle_custom_dash:GetEffectName() return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" end

function modifier_pangolier_swashbuckle_custom_dash:OnCreated(kv)
    if not IsServer() then return end
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Cast")
    self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Layer")
    self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_wait", {duration = self:GetRemainingTime() + 0.1})
    self.point = Vector(kv.x, kv.y, kv.z)
    self.angle = (self.point - self.parent:GetAbsOrigin()):Normalized()
    self.distance = kv.dist / ( self:GetDuration() / FrameTime())
    self.direction = Vector(kv.attacks_x, kv.attacks_y, 0):Normalized()
    self.targets = {}
    if self:ApplyHorizontalMotionController() == false then
        self:Destroy()
    end
end

function modifier_pangolier_swashbuckle_custom_dash:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_pangolier_swashbuckle_custom_dash:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true
    }
end

function modifier_pangolier_swashbuckle_custom_dash:OnDestroy()
    if not IsServer() then return end
    self.parent:InterruptMotionControllers( true )
    local dir = self.parent:GetForwardVector()
    dir.z = 0
    self.parent:SetForwardVector(dir)
    self.parent:FaceTowards(self.parent:GetAbsOrigin() + dir*10)
    FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), false)
    self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1)
    if self:GetRemainingTime() < 0.1 then 
        self.parent:AddNewModifier(self.parent, self.ability, "modifier_pangolier_swashbuckle_custom_attacks", {dir_x = self.direction.x, dir_y = self.direction.y, duration = 3})
    else 
        self.parent:RemoveModifierByName("modifier_pangolier_swashbuckle_custom_wait")
    end
end

function modifier_pangolier_swashbuckle_custom_dash:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    local pos = self.parent:GetAbsOrigin()
    local pos_p = self.angle * self.distance
    local next_pos = GetGroundPosition(pos + pos_p, self.parent)
    self.parent:SetAbsOrigin(next_pos)
end

function modifier_pangolier_swashbuckle_custom_dash:OnHorizontalMotionInterrupted()
    self:Destroy()
end

modifier_pangolier_swashbuckle_custom_attacks = class({})
function modifier_pangolier_swashbuckle_custom_attacks:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_attacks:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_attacks:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_pangolier_swashbuckle_custom_attacks:OnCreated( kv )
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.range = self.ability:GetSpecialValueFor( "range" )
    if self:GetCaster():HasModifier("modifier_pangolier_9") then
        self.range = self.range + self:GetAbility().modifier_pangolier_9[self:GetCaster():GetTalentLevel("modifier_pangolier_9")]
    end
    self.speed = self.ability:GetSpecialValueFor( "dash_speed" )
    self.radius = self.ability:GetSpecialValueFor( "start_radius" )
    self.interval = self.ability:GetSpecialValueFor( "attack_interval" )
    self.strikes = self.ability:GetSpecialValueFor( "strikes" )
    if kv.new_strikes then
        self.strikes = kv.new_strikes
    end
    if not IsServer() then return end
    self.attacks = kv.attacks
    self.swash_id = DoUniqueString("swashbucle")

    self.damage = self.ability:GetSpecialValueFor( "damage" )
    if self:GetCaster():HasModifier("modifier_pangolier_10") then
        self.damage = self.damage + self:GetAbility().modifier_pangolier_10[self:GetCaster():GetTalentLevel("modifier_pangolier_10")]
    end
    if self:GetCaster():HasModifier("modifier_pangolier_12") then
        self.damage = self.damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_pangolier_12[self:GetCaster():GetTalentLevel("modifier_pangolier_12")])
    end
    if not kv.new_strikes then
        self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
    end
    self.origin = self.parent:GetOrigin()
    self.direction = Vector( kv.dir_x, kv.dir_y, 0 )
    if kv.new_strikes then
        self.origin = self.origin + self.direction * (self.radius * 1.3)
        self.swash = true
    end
    self.target = self.origin + self.direction*self.range
    self.count = 0
    self:StartIntervalThink( self.interval )
    self:OnIntervalThink()
end

function modifier_pangolier_swashbuckle_custom_attacks:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ATTACK_DAMAGE,
    }
end

function modifier_pangolier_swashbuckle_custom_attacks:GetModifierOverrideAttackDamage()
    return self.damage
end

function modifier_pangolier_swashbuckle_custom_attacks:CheckState()
    if self.attacks then return end
    return 
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_pangolier_swashbuckle_custom_attacks:OnIntervalThink()
    if not IsServer() then return end
    if self.parent:IsHexed() then 
        self:Destroy()
        return
    end
    self.count = self.count+1
    if self.count>self.strikes then
        self:Destroy()
        return
    end
    if self.count%6 == 0 then 
        self.parent:FadeGesture(ACT_DOTA_CAST_ABILITY_1_END)
        self.parent:StartGesture(ACT_DOTA_CAST_ABILITY_1_END)
    end
    local enemies = FindUnitsInLine(self.parent:GetTeamNumber(), self.origin, self.target, nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,  0 )
    self.parent:EmitSound("Hero_Pangolier.Swashbuckle")
    for _,enemy in pairs(enemies) do
        self.ability:DealDamage(enemy, self.swash_id)
    end
    self:PlayEffects()
end

function modifier_pangolier_swashbuckle_custom_attacks:GetEffectName() 
    return "particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash.vpcf" 
end

function modifier_pangolier_swashbuckle_custom_attacks:PlayEffects()
    local effect_cast
    if self.swash then
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_WORLDORIGIN, self.parent )
        ParticleManager:SetParticleControl( effect_cast, 0, self.origin )
        ParticleManager:SetParticleControlForward( effect_cast, 0, self.direction )
        ParticleManager:SetParticleControl( effect_cast, 1, self.direction*self.ability:GetSpecialValueFor("range") )
        ParticleManager:SetParticleControl( effect_cast, 3, self.direction*self.ability:GetSpecialValueFor("range") )
        self:AddParticle( effect_cast, false,  false, -1,  false, false )
    else
        effect_cast = ParticleManager:CreateParticle( "particles/units/heroes/hero_pangolier/pangolier_swashbuckler.vpcf", PATTACH_POINT_FOLLOW, self.parent )
        ParticleManager:SetParticleControlEnt( effect_cast, 0, self.parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", self.parent:GetOrigin(), true )
        ParticleManager:SetParticleControl( effect_cast, 1, self.direction*self.ability:GetSpecialValueFor("range") )
        ParticleManager:SetParticleControl( effect_cast, 3, self.direction*self.ability:GetSpecialValueFor("range") )
        self:AddParticle( effect_cast, false,  false, -1,  false, false )
    end
    Timers:CreateTimer(0.2, function()
        if effect_cast then
            ParticleManager:DestroyParticle(effect_cast, false)
            ParticleManager:ReleaseParticleIndex(effect_cast)
        end
    end)
    self.parent:EmitSound("Hero_Pangolier.Swashbuckle.Attack")
end

modifier_pangolier_swashbuckle_custom_wait = class({})
function modifier_pangolier_swashbuckle_custom_wait:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_wait:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_wait:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true
    }
end

modifier_pangolier_swashbuckle_custom_handler = class({})
function modifier_pangolier_swashbuckle_custom_handler:IsHidden() return not self:GetCaster():HasModifier("modifier_pangolier_14") end
function modifier_pangolier_swashbuckle_custom_handler:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_handler:IsPurgeException() return false end
function modifier_pangolier_swashbuckle_custom_handler:RemoveOnDeath() return false end
function modifier_pangolier_swashbuckle_custom_handler:GetTexture() return "pangolier_14" end
function modifier_pangolier_swashbuckle_custom_handler:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
         
    }
end
function modifier_pangolier_swashbuckle_custom_handler:GetModifierAttackRangeBonus()
    if self:GetCaster():HasModifier("modifier_pangolier_14") then
        return self:GetAbility().modifier_pangolier_14
    end
end
function modifier_pangolier_swashbuckle_custom_handler:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
end
function modifier_pangolier_swashbuckle_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.no_attack_cooldown then return end
    if self:GetCaster():HasModifier("modifier_pangolier_14") then
        self:IncrementStackCount()
        if self:GetStackCount() == self:GetAbility().modifier_pangolier_14_attacks then
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_swashbuckle_custom_handler_debuff", {})
            self:SetStackCount(0)
            local modifier_pangolier_swashbuckle_custom_handler_debuff = self:GetParent():FindModifierByName("modifier_pangolier_swashbuckle_custom_handler_debuff")
            if modifier_pangolier_swashbuckle_custom_handler_debuff then
                modifier_pangolier_swashbuckle_custom_handler_debuff:Destroy()
            end
            local direction = self:GetParent():GetForwardVector()
            direction.z = 0
            self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_swashbuckle_custom_attacks", {dir_x = direction.x, dir_y = direction.y, duration = 3, attacks = 1})
        end
    end
end

modifier_pangolier_swashbuckle_custom_handler_debuff = class({})
function modifier_pangolier_swashbuckle_custom_handler_debuff:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_handler_debuff:IsPurgable() return false end
function modifier_pangolier_swashbuckle_custom_handler_debuff:IsPurgeException() return false end
function modifier_pangolier_swashbuckle_custom_handler_debuff:RemoveOnDeath() return false end
function modifier_pangolier_swashbuckle_custom_handler_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_pangolier_swashbuckle_custom_handler_debuff:GetModifierTotalDamageOutgoing_Percentage(params)
    if not IsServer() then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
    return -200
end


modifier_pangolier_swashbuckle_custom_handler_debuff_hidden = class({})
function modifier_pangolier_swashbuckle_custom_handler_debuff_hidden:IsHidden() return true end
function modifier_pangolier_swashbuckle_custom_handler_debuff_hidden:IsPurgable() return false end


modifier_pangolier_swashbuckle_custom_debuff = class({})
function modifier_pangolier_swashbuckle_custom_debuff:IsPurgable() return true end
function modifier_pangolier_swashbuckle_custom_debuff:IsHidden() return false end

function modifier_pangolier_swashbuckle_custom_debuff:OnCreated(table)
    self.slow = self:GetAbility():GetSpecialValueFor("slow_percent")
end

function modifier_pangolier_swashbuckle_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_pangolier_swashbuckle_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.slow
end

function modifier_pangolier_swashbuckle_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_snapfire/hero_snapfire_shotgun_debuff.vpcf"
end

function modifier_pangolier_swashbuckle_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_swashbuckle_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_snapfire_slow.vpcf"
end

function modifier_pangolier_swashbuckle_custom_debuff:StatusEffectPriority()
    return MODIFIER_PRIORITY_NORMAL
end