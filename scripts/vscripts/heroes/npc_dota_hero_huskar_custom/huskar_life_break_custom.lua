--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_huskar_life_break_custom_debuff_immune", "heroes/npc_dota_hero_huskar_custom/huskar_life_break_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_life_break_custom_debuff", "heroes/npc_dota_hero_huskar_custom/huskar_life_break_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_huskar_life_break_custom", "heroes/npc_dota_hero_huskar_custom/huskar_life_break_custom", LUA_MODIFIER_MOTION_BOTH)
LinkLuaModifier("modifier_huskar_life_break_custom_debuff_aggresive", "heroes/npc_dota_hero_huskar_custom/huskar_life_break_custom", LUA_MODIFIER_MOTION_NONE)

huskar_life_break_custom = class({})

huskar_life_break_custom.modifier_huskar_13 = {-2,-4}
huskar_life_break_custom.modifier_huskar_7 = 3
huskar_life_break_custom.modifier_huskar_7_cast_range = 250
huskar_life_break_custom.modifier_huskar_7_movespeed = 550

function huskar_life_break_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_life_break.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_huskar_lifebreak.vpcf", context )
    PrecacheResource( "particle", "particles/status_fx/status_effect_beserkers_call.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_huskar/huskar_life_break_spellstart.vpcf", context )
end

function huskar_life_break_custom:GetManaCost(iLevel)
    if IsServer() then return end
    if self:GetCaster():HasModifier("modifier_huskar_15") then
        return self:GetSpecialValueFor("health_cost_percent") * self:GetCaster():GetMana()
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function huskar_life_break_custom:GetCooldown( level )
	local bonus = 0
	if self:GetCaster():HasModifier("modifier_huskar_13") then
		bonus = self.modifier_huskar_13[self:GetCaster():GetTalentLevel("modifier_huskar_13")]
	end
	return self.BaseClass.GetCooldown( self, level ) + bonus
end

function huskar_life_break_custom:GetCastRange( location, target )
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_huskar_7") then
        bonus = self.modifier_huskar_7_cast_range
    end
    return self.BaseClass.GetCastRange( self, location, target ) + bonus
end

function huskar_life_break_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    if target:TriggerSpellAbsorb(self) then return end
    self:GetCaster():EmitSound("Hero_Huskar.Life_Break")
    self:GetCaster():Purge(false, true, false, false, false)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_huskar_life_break_custom_debuff_immune", {})
    local modifier_huskar_life_break_custom = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_huskar_life_break_custom", {target = target:entindex(), duration = 10})
end

modifier_huskar_life_break_custom_debuff_immune = class({})
function modifier_huskar_life_break_custom_debuff_immune:IsHidden() return true end
function modifier_huskar_life_break_custom_debuff_immune:IsPurgable() return false end
function modifier_huskar_life_break_custom_debuff_immune:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_life_break_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    self:AddParticle(particle,false, false, -1, false, false)
end
function modifier_huskar_life_break_custom_debuff_immune:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end
function modifier_huskar_life_break_custom_debuff_immune:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
    }
end
function modifier_huskar_life_break_custom_debuff_immune:GetOverrideAnimation()
    return ACT_DOTA_CAST_LIFE_BREAK_START
end
function modifier_huskar_life_break_custom_debuff_immune:GetModifierDisableTurning()
    return 1
end

function modifier_huskar_life_break_custom_debuff_immune:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_huskar_life_break_custom_debuff_immune:GetModifierMagicalResistanceBonus(params)
    if IsClient() then 
        return 65
    end
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 65
    end
end

modifier_huskar_life_break_custom  = class({})
function modifier_huskar_life_break_custom:IsHidden()   return true end
function modifier_huskar_life_break_custom:IsPurgable() return false end
function modifier_huskar_life_break_custom:OnCreated(params)
    self.break_range  = 1450
    if not IsServer() then return end
    self.health_cost_percent = self:GetAbility():GetSpecialValueFor("health_cost_percent")
    self.health_damage = self:GetAbility():GetSpecialValueFor("health_damage")
    self.charge_speed = self:GetAbility():GetSpecialValueFor("charge_speed")
    if self:GetParent():HasModifier("modifier_huskar_6_buff") then
        self.health_damage = self.health_damage + (self:GetParent():GetModifierStackCount("modifier_huskar_6_buff", self:GetParent()) / 100)
    end
    if params.target then 
        self.target = EntIndexToHScript(params.target)
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_life_break_spellstart.vpcf", PATTACH_POINT_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
    ParticleManager:SetParticleControlEnt( particle, 5, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetOrigin(), true )
    ParticleManager:ReleaseParticleIndex(particle)
    if self:ApplyHorizontalMotionController() == false then 
        self:Destroy()
        return
    end
    if not self:ApplyVerticalMotionController() then
        self:Destroy()
    end
end

function modifier_huskar_life_break_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_OBSTRUCTIONS] = true,
        [MODIFIER_STATE_ALLOW_PATHING_THROUGH_BASE_BLOCKER] = true,
        [MODIFIER_STATE_FLYING_FOR_PATHING_PURPOSES_ONLY] = true,
    }
end

function modifier_huskar_life_break_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE
    }
end

function modifier_huskar_life_break_custom:GetModifierIgnoreCastAngle()
    return 1
end

function modifier_huskar_life_break_custom:UpdateHorizontalMotion( me, dt )
    if not IsServer() then return end
    local target = self.target:GetAbsOrigin()
    me:FaceTowards(target)
    local distance = (target - me:GetOrigin()):Normalized()
    local new_point = me:GetOrigin() + distance * self.charge_speed * dt
    me:SetAbsOrigin( new_point )
    if (self.target and (self.target:GetAbsOrigin() - me:GetOrigin()):Length2D() <= 128)
    or (self.target and (self.target:GetAbsOrigin() - me:GetAbsOrigin()):Length2D() > self.break_range)
    or (not me:IsDebuffImmune() and me:IsStunned()) or (self.target and not self.target:IsAlive()) then
        self:Destroy()
        return
    end
end

function modifier_huskar_life_break_custom:UpdateVerticalMotion( me, dt )
    if not IsServer() then return end
    local height = me:GetOrigin().z
    local ground_height = GetGroundHeight(me:GetOrigin(), me)
    if height > ground_height and ground_height > 0 then
        me:SetOrigin(Vector(me:GetOrigin().x, me:GetOrigin().y, ground_height))
    else
        me:SetOrigin(Vector(me:GetOrigin().x, me:GetOrigin().y, math.max(height, ground_height)))
    end
end

function modifier_huskar_life_break_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():RemoveHorizontalMotionController( self )
    self:GetParent():RemoveModifierByName("modifier_huskar_life_break_custom_debuff_immune")
    if (self.target and (self.target:GetAbsOrigin() - self:GetParent():GetOrigin()):Length2D() <= 128) then
        self:GetParent():StartGesture(ACT_DOTA_CAST_LIFE_BREAK_END)
        self.target:EmitSound("Hero_Huskar.Life_Break.Impact")
        if not self:GetCaster():HasModifier("modifier_huskar_14") then
            if self:GetCaster():HasModifier("modifier_huskar_15") then
                self:GetCaster():SpendMana(self.health_cost_percent * self:GetParent():GetMana(), self:GetAbility())
            else
                ApplyDamage({ victim = self:GetParent(), attacker = self:GetParent(), damage = self.health_cost_percent * self:GetParent():GetHealth(), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_NON_LETHAL})
            end
        else
            local heal_hero = (self.health_cost_percent * self:GetParent():GetHealth()) * 0.3
            if self:GetCaster():HasModifier("modifier_huskar_15") then
                self:GetCaster():SpendMana(self.health_cost_percent * self:GetParent():GetMana(), self:GetAbility())
                heal_hero = (self.health_cost_percent * self:GetParent():GetMana()) * 0.3
            end
            self:GetCaster():Heal(heal_hero, self:GetAbility())
        end
        self:ImpactDamage(self.target)
        if not self:GetCaster():GetCurrentActiveAbility() then
            self:GetParent():MoveToTargetToAttack( self.target )
        end
    end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
end

function modifier_huskar_life_break_custom:ImpactEffect(target)
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_life_break.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, target:GetOrigin())
    ParticleManager:SetParticleControl(particle, 1, target:GetOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
    local duration = self:GetAbility():GetSpecialValueFor("slow_duration_tooltip")
    target:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_huskar_life_break_custom_debuff", {duration = duration * (1 - target:GetStatusResistance() ) })
    if self:GetCaster():HasModifier("modifier_huskar_7") then
        target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_huskar_life_break_custom_debuff_aggresive", {duration = self:GetAbility().modifier_huskar_7 * (1-target:GetStatusResistance())})
    end
end

function modifier_huskar_life_break_custom:OnHorizontalMotionInterrupted()
	self:Destroy()
end

function modifier_huskar_life_break_custom:ImpactDamage(target)
    if not IsServer() then return end
    self:ImpactEffect(target)
    local damage = target:GetHealth() * self.health_damage
    ApplyDamage({victim = target, attacker = self:GetParent(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

























modifier_huskar_life_break_custom_debuff = class({})
function modifier_huskar_life_break_custom_debuff:IsHidden() return false end
function modifier_huskar_life_break_custom_debuff:IsPurgable() return not self:GetCaster():HasModifier("modifier_huskar_13") end

function modifier_huskar_life_break_custom_debuff:OnCreated()
    self.attackspeed = self:GetAbility():GetSpecialValueFor("attack_speed")
    self.movespeed  = self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_huskar_life_break_custom_debuff:OnRefresh()
    self:OnCreated()
end

function modifier_huskar_life_break_custom_debuff:GetStatusEffectName()
    return "particles/status_fx/status_effect_huskar_lifebreak.vpcf"
end

function modifier_huskar_life_break_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    }
end

function modifier_huskar_life_break_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    return self.attackspeed
end

function modifier_huskar_life_break_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self.movespeed
end

modifier_huskar_life_break_custom_debuff_aggresive = class({})
function modifier_huskar_life_break_custom_debuff_aggresive:IsPurgable() return false end
function modifier_huskar_life_break_custom_debuff_aggresive:OnCreated( kv )
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( self:GetCaster() )
    self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    self:StartIntervalThink(FrameTime())
end

function modifier_huskar_life_break_custom_debuff_aggresive:OnIntervalThink( kv )
    if not IsServer() then return end
    if not self:GetCaster():IsAlive() then
        self:Destroy()
    else
        self:GetParent():SetForceAttackTarget( self:GetCaster() )
        self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    end
end

function modifier_huskar_life_break_custom_debuff_aggresive:OnRemoved()
    if not IsServer() then return end
    self:GetParent():SetForceAttackTarget( nil )
end

function modifier_huskar_life_break_custom_debuff_aggresive:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
    }
end

function modifier_huskar_life_break_custom_debuff_aggresive:GetModifierMoveSpeed_Absolute()
    return self:GetAbility().modifier_huskar_7_movespeed
end

function modifier_huskar_life_break_custom_debuff_aggresive:CheckState()
    return
    {
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_TAUNTED] = true,
    }
end

function modifier_huskar_life_break_custom_debuff_aggresive:GetStatusEffectName()
    return "particles/status_fx/status_effect_beserkers_call.vpcf"
end