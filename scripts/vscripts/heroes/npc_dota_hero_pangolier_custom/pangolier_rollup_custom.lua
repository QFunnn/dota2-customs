--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_pangolier_rollup_custom", "heroes/npc_dota_hero_pangolier_custom/pangolier_rollup_custom", LUA_MODIFIER_MOTION_NONE)

pangolier_rollup_custom = class({})

function pangolier_rollup_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", context)
end

function pangolier_rollup_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_pangolier_gyroshell_custom") and self:GetCaster():HasModifier("modifier_pangolier_17") then 
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    if self:GetCaster():HasModifier("modifier_pangolier_17") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET +  DOTA_ABILITY_BEHAVIOR_HIDDEN
end

function pangolier_rollup_custom:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    caster:StartGestureWithPlaybackRate(ACT_DOTA_CAST_ABILITY_4, 3)
    self.cast_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_gyroshell_cast.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt( self.cast_effect, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlEnt( self.cast_effect, 3, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true )
    ParticleManager:SetParticleControlForward( self.cast_effect, 0,  caster:GetForwardVector())
    ParticleManager:SetParticleControlForward( self.cast_effect, 3,  caster:GetForwardVector())
    return true
end

function  pangolier_rollup_custom:OnAbilityPhaseInterrupted()
    local caster = self:GetCaster()
    if self.cast_effect then 
        ParticleManager:DestroyParticle(self.cast_effect, true)
        ParticleManager:ReleaseParticleIndex(self.cast_effect)
    end
    caster:FadeGesture(ACT_DOTA_CAST_ABILITY_4)
end

function pangolier_rollup_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():FadeGesture(ACT_DOTA_CAST_ABILITY_4)
    if self.cast_effect then 
        ParticleManager:DestroyParticle(self.cast_effect, true)
        ParticleManager:ReleaseParticleIndex(self.cast_effect)
    end
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_pangolier_rollup_custom", {duration = self:GetSpecialValueFor("duration")})
end

modifier_pangolier_rollup_custom = class({})
function modifier_pangolier_rollup_custom:IsPurgable() return false end
function modifier_pangolier_rollup_custom:IsPurgeException() return false end
function modifier_pangolier_rollup_custom:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    self:GetParent():Stop()
    self.old_duration = nil
    self.ability = self:GetCaster():FindAbilityByName("pangolier_gyroshell_custom")
    local modifier = self:GetCaster():FindModifierByName("modifier_pangolier_gyroshell_custom")
    if modifier then
        self.old_duration = modifier:GetRemainingTime()
        modifier.early_stop = true
        modifier:Destroy()
    end
    local hit_effect = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_shard_rollup_cast_dust_poof.vpcf", PATTACH_ABSORIGIN, self:GetCaster())
    ParticleManager:ReleaseParticleIndex(hit_effect)
    self:GetParent():SwapAbilities("pangolier_rollup_custom", "pangolier_rollup_stop_custom", false, true)
    self.parent = self:GetParent()
    if self:GetParent():HasAbility("pangolier_rollup_stop_custom") then 
	    self:GetParent():FindAbilityByName("pangolier_rollup_stop_custom"):StartCooldown(0.5)
    end 
    self.turn_rate = self:GetAbility():GetSpecialValueFor("turn_rate_boosted")
    local first_point = self:GetCaster():GetAbsOrigin() + self:GetCaster():GetForwardVector() * 100
    self:SetDirection( Vector(first_point.x, first_point.y, 0) ) 
    self.current_dir = self.target_dir
    self.turn_speed = FrameTime()*self.turn_rate
    self.proj_time = 0
    self:GetParent():StartGesture(ACT_DOTA_SPAWN)
    self:GetParent():EmitSound("Hero_Pangolier.Gyroshell.Layer")
    self:StartIntervalThink(FrameTime())
    self:OnIntervalThink()
end

function modifier_pangolier_rollup_custom:DeclareFunctions()
	return
	{
		MODIFIER_PROPERTY_MODEL_CHANGE,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_MOVESPEED_LIMIT,
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE
	}
end

function modifier_pangolier_rollup_custom:GetEffectName()
    return "particles/items_fx/black_king_bar_avatar.vpcf"
end

function modifier_pangolier_rollup_custom:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_pangolier_rollup_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_avatar.vpcf"
end

function modifier_pangolier_rollup_custom:StatusEffectPriority()
    return 99999
end

function modifier_pangolier_rollup_custom:GetAbsoluteNoDamagePure(params)
    if IsServer() then
        if params.inflictor then 
            if bit.band(params.inflictor:GetAbilityTargetFlags(), DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES) ~= 0 then
                return 0
            end
        end
        return 1
    end
end

function modifier_pangolier_rollup_custom:GetModifierMagicalResistanceBonus(params)
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

function modifier_pangolier_rollup_custom:GetOverrideAnimation()
    return ACT_DOTA_IDLE
end

function modifier_pangolier_rollup_custom:OnAttack(params)
    if not IsServer() then return end
    if params.attacker == self:GetParent() then return end
    if params.target ~= self:GetParent() then return end
    if self:GetParent():HasModifier("modifier_pangolier_gyroshell_custom_shard_damage_cd") then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_pangolier_gyroshell_custom_shard_damage_cd", {duration = self:GetAbility():GetSpecialValueFor("damage_cd")})
    self:GetCaster():RemoveGesture(ACT_DOTA_SPAWN)
    self:GetParent():StartGesture(ACT_DOTA_SPAWN)
    local smash = ParticleManager:CreateParticle("particles/units/heroes/hero_pangolier/pangolier_tailthump.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(smash, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:DestroyParticle(smash, false)
    ParticleManager:ReleaseParticleIndex(smash)
    local direction = (self:GetParent():GetAbsOrigin() - params.attacker:GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self:GetParent():SetForwardVector(direction)
    self:GetCaster():AddNewModifier(self:GetCaster(), self.ability, "modifier_pangolier_gyroshell_custom_rollup", {duration = 0.75})
end

function modifier_pangolier_rollup_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():RemoveGesture(ACT_DOTA_SPAWN)
    self:GetParent():StopSound("Hero_Pangolier.Gyroshell.Layer")
    if not self.early_stop and self.old_duration == nil then 
        self:GetParent():StartGesture(ACT_DOTA_CAST_ABILITY_4_END)
        self:GetParent():EmitSound("Hero_Pangolier.Gyroshell.Stop")
    end
    if self.old_duration ~= nil then
        if self:GetCaster():IsAlive() then 
            self:GetCaster():AddNewModifier(self:GetCaster(), self.ability, "modifier_pangolier_gyroshell_custom", {duration = self.old_duration})
        end
    end
    self:GetParent():SwapAbilities("pangolier_rollup_stop_custom", "pangolier_rollup_custom", false, true)
    if not self:GetParent():IsAlive() then
        local pangolier_gyroshell_custom = self:GetParent():FindAbilityByName("pangolier_gyroshell_custom")
        if pangolier_gyroshell_custom then
            pangolier_gyroshell_custom:SetActivated(true)
        end
    end
end

function modifier_pangolier_rollup_custom:GetModifierModelChange()
    return "models/heroes/pangolier/pangolier_gyroshell2.vmdl"
end

function modifier_pangolier_rollup_custom:GetModifierMoveSpeed_Limit()
    return 0.1
end

function modifier_pangolier_rollup_custom:GetModifierDisableTurning()
    return 1
end

function modifier_pangolier_rollup_custom:OnOrder( params )
    if params.unit~=self:GetParent() then return end
    if  params.order_type==DOTA_UNIT_ORDER_MOVE_TO_POSITION or
        params.order_type==DOTA_UNIT_ORDER_MOVE_TO_DIRECTION
    then
        self:SetDirection( params.new_pos )
    elseif 
        params.order_type==DOTA_UNIT_ORDER_MOVE_TO_TARGET or
        params.order_type==DOTA_UNIT_ORDER_ATTACK_TARGET
    then
        self:SetDirection( params.target:GetOrigin() )
    end
end

function modifier_pangolier_rollup_custom:SetDirection( vec )
    if vec.x == self:GetCaster():GetAbsOrigin().x and vec.y == self:GetCaster():GetAbsOrigin().y then 
        vec = self:GetCaster():GetAbsOrigin() + 100*self:GetCaster():GetForwardVector()
    end
    self.target_dir = ((vec-self.parent:GetOrigin())*Vector(1,1,0)):Normalized()
    self.face_target = false
end

function modifier_pangolier_rollup_custom:OnIntervalThink()
    if not IsServer() then return end
    self:TurnLogic()
end

function modifier_pangolier_rollup_custom:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_DEBUFF_IMMUNE] = true,
    }
end

function modifier_pangolier_rollup_custom:TurnLogic()
    if self.face_target then return end
    local current_angle = VectorToAngles( self.current_dir ).y
    local target_angle = VectorToAngles( self.target_dir ).y
    local angle_diff = AngleDiff( current_angle, target_angle )
    local sign = -1
    if angle_diff<0 then sign = 1 end
    if math.abs( angle_diff )<1.1*self.turn_speed then
        self.current_dir = self.target_dir
        self.face_target = true
    else
        self.current_dir = RotatePosition( Vector(0,0,0), QAngle(0, sign*self.turn_speed, 0), self.current_dir )
    end
    local a = self.parent:IsCurrentlyHorizontalMotionControlled()
    local b = self.parent:IsCurrentlyVerticalMotionControlled()
    if not (a or b) then
        self.parent:SetForwardVector( self.current_dir )
    end
end

pangolier_rollup_stop_custom = class({})

function pangolier_rollup_stop_custom:OnSpellStart()
	if not IsServer() then return end
	self:GetCaster():RemoveModifierByName("modifier_pangolier_rollup_custom")
end