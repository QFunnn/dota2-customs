--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_shodo_sai_custom", "heroes/npc_dota_hero_kez_custom/kez_shodo_sai_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_shodo_sai_custom_handler", "heroes/npc_dota_hero_kez_custom/kez_shodo_sai_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_shodo_sai_custom_mark", "heroes/npc_dota_hero_kez_custom/kez_shodo_sai_custom", LUA_MODIFIER_MOTION_NONE)

kez_shodo_sai_custom = class({})

kez_shodo_sai_custom.modifier_kez_8 = 5
kez_shodo_sai_custom.modifier_kez_12 = {10,20,30}

function kez_shodo_sai_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_parry.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_ultimate_crit.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf", context )
end

function kez_shodo_sai_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_kez_14") then
        cooldown = cooldown + 2
    end
    return cooldown
end

function kez_shodo_sai_custom:GetIntrinsicModifierName()
    return "modifier_kez_shodo_sai_custom_handler"
end

function kez_shodo_sai_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    if point == self:GetCaster():GetAbsOrigin() then
        point = point + self:GetCaster():GetForwardVector()
    end
    local parry_duration = self:GetSpecialValueFor("parry_duration")
    local direction = (point - self:GetCaster():GetAbsOrigin())
    direction.z = 0
    direction = direction:Normalized()
    self:GetCaster():SetForwardVector(direction)
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_shodo_sai_custom", {duration = parry_duration})
end

function kez_shodo_sai_custom:ParryEffect(target)
    local parry_stun_duration = self:GetSpecialValueFor("parry_stun_duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_stunned", {duration = parry_stun_duration * (1 - target:GetStatusResistance())})
    target:EmitSound("Hero_Kez.Parry.Sai.Block")
end

function kez_shodo_sai_custom:AttackBashed(target, parry)
    local stun_duration = self:GetSpecialValueFor("stun_duration")
    if parry then
        stun_duration = stun_duration
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_bashed", {duration = stun_duration * (1 - target:GetStatusResistance())})
    target:EmitSound("Hero_Kez.Sai.Crit")
    local coup_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_ultimate_crit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(coup_pfx, 1, target:GetAbsOrigin())
    local line = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
    ParticleManager:SetParticleControlTransformForward( coup_pfx, 1, target:GetOrigin(), -line )
    ParticleManager:ReleaseParticleIndex(coup_pfx)
end

function kez_shodo_sai_custom:AddTargetMark(target, parry, full_chance)
    local vuln_duration = self:GetSpecialValueFor("vuln_duration")
    local chance = 100
    if not full_chance then
        chance = self:GetSpecialValueFor("sai_proc_vuln_chance")
    end
    if RollPercentage(chance) then
        target:AddNewModifier(self:GetCaster(), self, "modifier_kez_shodo_sai_custom_mark", {duration = vuln_duration * (1 - target:GetStatusResistance()), parry = parry})
    end
end

modifier_kez_shodo_sai_custom = class({})
function modifier_kez_shodo_sai_custom:IsPurgable() return true end
function modifier_kez_shodo_sai_custom:IsPurgeException() return true end

function modifier_kez_shodo_sai_custom:OnCreated()
    self.speed_penalty = self:GetAbility():GetSpecialValueFor("speed_penalty")
    if not IsServer() then return end
    if not self:GetCaster():HasModifier("modifier_kez_14") then
        Timers:CreateTimer(FrameTime(), function()
            self:GetCaster():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
        end)
    end
    self:GetParent():EmitSound("Hero_Kez.Parry.Sai.Cast")
    local position = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_parry.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 0, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(particle, 1, position + Vector(0,0,50))
    self.particle = particle
    self.targets = {}
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():SwapAbilities("kez_shodo_sai_custom", "kez_shodo_sai_parry_cancel_custom", false, true)
    self:StartIntervalThink(FrameTime())
end

function modifier_kez_shodo_sai_custom:OnIntervalThink()
    if not IsServer() then return end
    if self.particle then
        local position = self:GetParent():GetAbsOrigin() + self:GetParent():GetForwardVector() * 100
        ParticleManager:SetParticleControl(self.particle, 1, position + Vector(0,0,50))
    end
end

function modifier_kez_shodo_sai_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():SwapAbilities("kez_shodo_sai_parry_cancel_custom", "kez_shodo_sai_custom", false, true)
    self:GetCaster():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_3)
end

function modifier_kez_shodo_sai_custom:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_DISABLE_TURNING,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_AVOID_DAMAGE,
    }
end

function modifier_kez_shodo_sai_custom:OnAbilityFullyCast(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if params.ability == nil then return end
    if params.ability == self:GetAbility() then return end
    self:Destroy()
end

function modifier_kez_shodo_sai_custom:GetActivityTranslationModifiers()
    return "parry"
end

function modifier_kez_shodo_sai_custom:GetModifierDisableTurning()
    if self:GetCaster():HasModifier("modifier_kez_14") then return end
    return 1
end

function modifier_kez_shodo_sai_custom:GetModifierMoveSpeedBonus_Percentage()
    if self:GetCaster():HasModifier("modifier_kez_14") then return end
    return self.speed_penalty
end

function modifier_kez_shodo_sai_custom:CheckState()
    if self:GetCaster():HasModifier("modifier_kez_14") then return end
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end

function modifier_kez_shodo_sai_custom:GetModifierAvoidDamage(params)
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then return end
  	local forwardVector = self:GetParent():GetForwardVector()
  	local forwardAngle = math.deg(math.atan2(forwardVector.x, forwardVector.y))
  	local reverseEnemyVector = (self:GetParent():GetAbsOrigin() - params.attacker:GetAbsOrigin()):Normalized()
  	local reverseEnemyAngle = math.deg(math.atan2(reverseEnemyVector.x, reverseEnemyVector.y))
  	local difference = math.abs(forwardAngle - reverseEnemyAngle)
    local vector = self:GetCaster():GetOrigin()-self:GetParent():GetOrigin()
    local center_angle = VectorToAngles( vector ).y
    local facing_angle = VectorToAngles( self:GetParent():GetForwardVector() ).y
    if (difference >= 120) and (difference <= 280) then
        if not self.targets[params.attacker:entindex()] and params.attacker:IsHero() then
            self.targets[params.attacker:entindex()] = true
            self:GetAbility():ParryEffect(params.attacker)
            self:GetAbility():AddTargetMark(params.attacker, nil, true)
        end
        return 1
    end
end

modifier_kez_shodo_sai_custom_handler = class({})
function modifier_kez_shodo_sai_custom_handler:IsHidden() return true end
function modifier_kez_shodo_sai_custom_handler:IsPurgable() return false end
function modifier_kez_shodo_sai_custom_handler:IsPurgeException() return false end
function modifier_kez_shodo_sai_custom_handler:RemoveOnDeath() return false end
function modifier_kez_shodo_sai_custom_handler:OnCreated()
    self.sai_proc_vuln_chance = self:GetAbility():GetSpecialValueFor("sai_proc_vuln_chance")
    self.vuln_slow = self:GetAbility():GetSpecialValueFor("vuln_slow")
    self.vuln_duration = self:GetAbility():GetSpecialValueFor("vuln_duration")
    self.parry_stun_duration = self:GetAbility():GetSpecialValueFor("parry_stun_duration")
    self.is_mark_attack = false
end
function modifier_kez_shodo_sai_custom_handler:OnRefresh()
    self.sai_proc_vuln_chance = self:GetAbility():GetSpecialValueFor("sai_proc_vuln_chance")
    self.vuln_slow = self:GetAbility():GetSpecialValueFor("vuln_slow")
    self.vuln_duration = self:GetAbility():GetSpecialValueFor("vuln_duration")
    self.parry_stun_duration = self:GetAbility():GetSpecialValueFor("parry_stun_duration")
end
function modifier_kez_shodo_sai_custom_handler:DeclareFunctions()
    return
    {
         
        MODIFIER_EVENT_ON_ATTACK_START,
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
    }
end

function modifier_kez_shodo_sai_custom_handler:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.inflictor == nil then return end
    if params.inflictor:IsItem() then return end
    if params.inflictor:GetAbilityName() == "kez_kazurai_katana_custom" then return end
    local modifier_kez_shodo_sai_custom_mark = params.unit:FindModifierByName("modifier_kez_shodo_sai_custom_mark")
    if modifier_kez_shodo_sai_custom_mark then
        self:GetAbility():AttackBashed(params.unit, modifier_kez_shodo_sai_custom_mark.parry)
        modifier_kez_shodo_sai_custom_mark:Destroy()
    end
end

function modifier_kez_shodo_sai_custom_handler:OnAttackStart(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local modifier_kez_shodo_sai_custom_mark = params.target:FindModifierByName("modifier_kez_shodo_sai_custom_mark")
    if modifier_kez_shodo_sai_custom_mark then
        self.is_mark_attack = true
    else
        self.is_mark_attack = false
    end
end

function modifier_kez_shodo_sai_custom_handler:CheckState()
	local state = {}
	if self.is_mark_attack then
		state = {[MODIFIER_STATE_CANNOT_MISS] = true}
	end
	return state
end

function modifier_kez_shodo_sai_custom_handler:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    local modifier_kez_shodo_sai_custom_mark = params.target:FindModifierByName("modifier_kez_shodo_sai_custom_mark")
    if modifier_kez_shodo_sai_custom_mark then
        self:GetAbility():AttackBashed(params.target, modifier_kez_shodo_sai_custom_mark.parry)
        modifier_kez_shodo_sai_custom_mark:Destroy()
    end
    self.is_mark_attack = false
end

function modifier_kez_shodo_sai_custom_handler:GetModifierPreAttack_CriticalStrike( params )
    if self:GetAbility():IsHidden() then return end
    local chance = self.sai_proc_vuln_chance
    if self:GetCaster():HasModifier("modifier_kez_8") then
        chance = chance + self:GetAbility().modifier_kez_8
    end
	if params.target and not params.target:HasModifier("modifier_kez_shodo_sai_custom_mark") and RollPercentage(chance) then
        return self:GetAbility():GetSpecialValueFor("base_crit_pct")
    end
end

kez_shodo_sai_parry_cancel_custom = class({})
function kez_shodo_sai_parry_cancel_custom:OnSpellStart()
    local modifier_kez_shodo_sai_custom = self:GetCaster():FindModifierByName("modifier_kez_shodo_sai_custom")
    if modifier_kez_shodo_sai_custom then
        modifier_kez_shodo_sai_custom:Destroy()
    end
end

modifier_kez_shodo_sai_custom_mark = class({})
function modifier_kez_shodo_sai_custom_mark:IsPurgable() return false end
function modifier_kez_shodo_sai_custom_mark:IsPurgeException() return false end
function modifier_kez_shodo_sai_custom_mark:OnCreated(params)
    self.vuln_slow = self:GetAbility():GetSpecialValueFor("vuln_slow")
    self.base_crit_pct = self:GetAbility():GetSpecialValueFor("base_crit_pct")
    self.parry_bonus_crit = self:GetAbility():GetSpecialValueFor("parry_bonus_crit")
    if not IsServer() then return end
    self.parry = params.parry
    if self:GetParent():IsHero() then
        local effect_name = "particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf"
        if self.parry then
            effect_name = "particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf"
        end
        local particle = ParticleManager:CreateParticle(effect_name, PATTACH_OVERHEAD_FOLLOW, self:GetParent())
        self:AddParticle(particle, false, false, -1, false, true)
    else
        if not self.parry then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_vulnerable_marker.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
            self:AddParticle(particle, false, false, -1, false, true)
        end
    end
end

function modifier_kez_shodo_sai_custom_mark:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_TARGET_CRITICALSTRIKE,
    }
end

function modifier_kez_shodo_sai_custom_mark:GetModifierMoveSpeedBonus_Percentage()
    return self.vuln_slow
end

function modifier_kez_shodo_sai_custom_mark:GetModifierPreAttack_Target_CriticalStrike(params)
    if params.attacker ~= self:GetCaster() then return end

    --local sai = self:GetCaster():FindAbilityByName("kez_shodo_sai_custom")
    --if not sai or sai:IsHidden() then return end

    local bonus = 0
    if self:GetCaster():HasModifier("modifier_kez_12") then
        bonus = self:GetAbility().modifier_kez_12[self:GetCaster():GetTalentLevel("modifier_kez_12")]
    end
    local critical_bonus = self.base_crit_pct + bonus
    if self.parry then
        critical_bonus = critical_bonus + self.parry_bonus_crit
    end
    return critical_bonus
end