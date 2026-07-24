--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_kez_falcon_rush_custom", "heroes/npc_dota_hero_kez_custom/kez_falcon_rush_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_falcon_rush_custom_speed", "heroes/npc_dota_hero_kez_custom/kez_falcon_rush_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_falcon_rush_custom_clone", "heroes/npc_dota_hero_kez_custom/kez_falcon_rush_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_falcon_rush_custom_barrier", "heroes/npc_dota_hero_kez_custom/kez_falcon_rush_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_kez_falcon_rush_custom_damage", "heroes/npc_dota_hero_kez_custom/kez_falcon_rush_custom", LUA_MODIFIER_MOTION_NONE)

kez_falcon_rush_custom = class({})

kez_falcon_rush_custom.modifier_kez_11 = 70
kez_falcon_rush_custom.modifier_kez_11_max = 7
kez_falcon_rush_custom.modifier_kez_16 = {25,50,75}
kez_falcon_rush_custom.modifier_kez_16_status = {5,10,15}
kez_falcon_rush_custom.modifier_kez_10 = {100,200,300}
kez_falcon_rush_custom.modifier_kez_10_barrier = {100,200,300}
kez_falcon_rush_custom.modifier_kez_10_duration = 7

function kez_falcon_rush_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_kez_11") then
        local cooldown_reduced = self:GetCaster():GetAgility() / self.modifier_kez_11
        cooldown = math.max(self.modifier_kez_11_max, cooldown - cooldown_reduced)
    end
    return cooldown
end

function kez_falcon_rush_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_afterimage_buff.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_kez/kez_sai_afterimage_tracking.vpcf", context )
end

function kez_falcon_rush_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_falcon_rush_custom", {duration = duration})
    self:GetCaster():EmitSound("Hero_Kez.FalconRush.Sai.Cast")
    if self:GetCaster():HasModifier("modifier_kez_10") then
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_kez_falcon_rush_custom_barrier", {duration = self.modifier_kez_10_duration})
    end
    ---------------------------------------------------------------------------------------------
    if self:GetCaster():HasModifier("modifier_kez_21") then return end
    local kez_echo_slash_custom = self:GetCaster():FindAbilityByName("kez_echo_slash_custom")
    if kez_echo_slash_custom then
        kez_echo_slash_custom:UseResources(false, false, false, true)
    end
end

modifier_kez_falcon_rush_custom = class({})

function modifier_kez_falcon_rush_custom:IsPurgable() return not self:GetCaster():HasModifier("modifier_kez_9") end

function modifier_kez_falcon_rush_custom:OnCreated()
    self.slow_resist = self:GetAbility():GetSpecialValueFor("slow_resist")
    self.break_range = self:GetAbility():GetSpecialValueFor("break_range")
    if not IsServer() then return end
    self.rush_range = self:GetAbility():GetSpecialValueFor("rush_range")
    if self:GetCaster():HasModifier("modifier_kez_10") then
        self.rush_range = self.rush_range + self:GetAbility().modifier_kez_10[self:GetCaster():GetTalentLevel("modifier_kez_10")]
    end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_afterimage_buff.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_l", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 2, self:GetParent(), PATTACH_POINT_FOLLOW, "eye_r", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 3, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack1", self:GetParent():GetAbsOrigin(), true)
    ParticleManager:SetParticleControlEnt(particle, 4, self:GetParent(), PATTACH_POINT_FOLLOW, "attach_attack2", self:GetParent():GetAbsOrigin(), true)
    self:AddParticle(particle, false, false, -1, false, false)
    self:StartIntervalThink(0.1)
end

function modifier_kez_falcon_rush_custom:GetStatusEffectName()
    return "particles/units/heroes/hero_kez/status_effect_kez_afterimage_buff.vpcf"
end

function modifier_kez_falcon_rush_custom:StatusEffectPriority()
    return 10000
end

function modifier_kez_falcon_rush_custom:DeclareFunctions()
	return 
    {
		MODIFIER_EVENT_ON_ORDER,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_SLOW_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_PSEUDORANDOM_BONUS
	}
end

function modifier_kez_falcon_rush_custom:GetModifierPropertyPseudoRandomBonus(params)
    if not self:GetCaster().MissChanceActive then return end
    return -self:GetAbility():GetSpecialValueFor("echo_proc_chance_reduction")
end

function modifier_kez_falcon_rush_custom:GetModifierStatusResistanceStacking()
    if self:GetCaster():HasModifier("modifier_kez_16") then
        return self:GetAbility().modifier_kez_16_status[self:GetCaster():GetTalentLevel("modifier_kez_16")]
    end
end

function modifier_kez_falcon_rush_custom:GetModifierConstantHealthRegen()
    if self:GetCaster():HasModifier("modifier_kez_16") then
        return self:GetAbility().modifier_kez_16[self:GetCaster():GetTalentLevel("modifier_kez_16")]
    end
end

function modifier_kez_falcon_rush_custom:GetModifierConstantManaRegen()
    if self:GetCaster():HasModifier("modifier_kez_16") then
        return self:GetAbility().modifier_kez_16[self:GetCaster():GetTalentLevel("modifier_kez_16")]
    end
end

function modifier_kez_falcon_rush_custom:GetModifierSlowResistance_Stacking()
    return self.slow_resist
end

function modifier_kez_falcon_rush_custom:OnIntervalThink()
    if self:GetParent():GetAggroTarget() ~= self.target then return end
    local distance = 0
    if self.target then
        distance = (self.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
        if distance >= self.break_range then
            if self:GetParent():HasModifier("modifier_kez_falcon_rush_custom_speed") then
                self:GetParent():RemoveModifierByName("modifier_kez_falcon_rush_custom_speed")
                return
            end
        end
    end
    if not self.bRushChecking then return end
    if distance > self.rush_range then 
        return 
    end
    self:GetParent():EmitSound("Hero_Kez.FalconRush.Sai.Rush")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kez_falcon_rush_custom_speed", {duration = 5})
	self.bRushChecking = false
end

function modifier_kez_falcon_rush_custom:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    if not self:GetParent().spell_attack then
        if params.no_attack_cooldown then return end
    end
    local modifier_kez_falcon_rush_custom_speed = self:GetParent():FindModifierByName("modifier_kez_falcon_rush_custom_speed")
    if modifier_kez_falcon_rush_custom_speed then
        modifier_kez_falcon_rush_custom_speed:Destroy()
    end
    if self:GetCaster():HasModifier("modifier_kez_16") then return end
    params.target:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kez_falcon_rush_custom_clone", {})
end

function modifier_kez_falcon_rush_custom:OnOrder(params)
    if params.unit ~= self:GetParent() then return end
    local modifier_kez_falcon_rush_custom_speed = self:GetParent():FindModifierByName("modifier_kez_falcon_rush_custom_speed")
    if params.order_type ~= DOTA_UNIT_ORDER_ATTACK_TARGET then
        if modifier_kez_falcon_rush_custom_speed then
            modifier_kez_falcon_rush_custom_speed:Destroy()
        end
        self.bRushChecking = false
        return 
    end
    if params.target == nil then
        if modifier_kez_falcon_rush_custom_speed then
            modifier_kez_falcon_rush_custom_speed:Destroy()
        end
        self.bRushChecking = false
        return 
    end
    local distance = (params.target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Length2D()
    if distance > self.rush_range then
        if modifier_kez_falcon_rush_custom_speed then
            modifier_kez_falcon_rush_custom_speed:Destroy()
        end
        self.target = params.target
        self.bRushChecking = true
        return 
    end
    self:GetParent():EmitSound("Hero_Kez.FalconRush.Sai.Rush")
	self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kez_falcon_rush_custom_speed", {duration = 5})
    self.target = params.target
    self.bRushChecking = true
end

function modifier_kez_falcon_rush_custom:CheckState()
    return
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_kez_falcon_rush_custom:OnDestroy()
    if not IsServer() then return end
    local modifier_kez_falcon_rush_custom_speed = self:GetParent():FindModifierByName("modifier_kez_falcon_rush_custom_speed")
    if modifier_kez_falcon_rush_custom_speed then
        modifier_kez_falcon_rush_custom_speed:Destroy()
    end
end

modifier_kez_falcon_rush_custom_speed = class({})
function modifier_kez_falcon_rush_custom_speed:IsHidden() return true end
function modifier_kez_falcon_rush_custom_speed:IsPurgable() return false end
function modifier_kez_falcon_rush_custom_speed:OnCreated()
    self.rush_speed = self:GetAbility():GetSpecialValueFor("rush_speed")
    if not IsServer() then return end
    self:StartIntervalThink(0.1)
end
function modifier_kez_falcon_rush_custom_speed:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE
    }
end
function modifier_kez_falcon_rush_custom_speed:GetModifierMoveSpeed_Absolute()
    if not IsServer() then return end
    return self.rush_speed
end

modifier_kez_falcon_rush_custom_clone = class({})
function modifier_kez_falcon_rush_custom_clone:IsHidden() return true end
function modifier_kez_falcon_rush_custom_clone:IsPurgable() return false end
function modifier_kez_falcon_rush_custom_clone:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_kez_falcon_rush_custom_clone:OnCreated()
    if not IsServer() then return end
    self.attack = false
    self.random_position = self:GetCaster():GetAbsOrigin()
    self.direction = (self:GetParent():GetAbsOrigin() - self.random_position):Normalized()
    self:StartIntervalThink(0.3)
end
function modifier_kez_falcon_rush_custom_clone:OnIntervalThink()
    if not IsServer() then return end
    if not self.attack then
        local anim = 0
        if self:GetCaster():HasModifier("modifier_kez_switch_weapons_custom") then
            anim = 1
        end
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_kez/kez_sai_afterimage_tracking.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControlEnt(particle, 1, self:GetParent(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,0), true)
        ParticleManager:SetParticleControlEnt(particle, 4, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(particle, 5, Vector(anim, 0, 0))
        ParticleManager:SetParticleControlEnt(particle, 7, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
        ParticleManager:ReleaseParticleIndex(particle)
        self.attack = true
        return
    end
    local modifier_kez_falcon_rush_custom_damage = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_kez_falcon_rush_custom_damage", {})
    if modifier_kez_falcon_rush_custom_damage then
        self:GetCaster().MissChanceActive = true
        self:GetCaster():PerformAttack(self:GetParent(), true, true, true, false, false, false, self:GetCaster():GetChanceToEvasion(self:GetParent()))
        self:GetCaster().MissChanceActive = nil
        modifier_kez_falcon_rush_custom_damage:Destroy()
    end
    self:Destroy()
end

modifier_kez_falcon_rush_custom_barrier = class({})

function modifier_kez_falcon_rush_custom_barrier:GetTexture() return "kez_10" end

function modifier_kez_falcon_rush_custom_barrier:OnCreated( kv )
	self.caster = self:GetCaster()
	self.parent = self:GetParent()
	self.barrier = self:GetAbility().modifier_kez_10_barrier[self:GetCaster():GetTalentLevel("modifier_kez_10")]
	if not IsServer() then return end
	self.max_shield = self.barrier
	self.current_shield = self.barrier
	self:SetHasCustomTransmitterData( true )
end

function modifier_kez_falcon_rush_custom_barrier:AddCustomTransmitterData()
	local data = 
    {
		max_shield = self.max_shield,
		current_shield = self.current_shield
	}
	return data
end

function modifier_kez_falcon_rush_custom_barrier:HandleCustomTransmitterData( data )
	self.max_shield = data.max_shield
	self.current_shield = data.current_shield
end

function modifier_kez_falcon_rush_custom_barrier:DeclareFunctions()
	local funcs = 
    {
		MODIFIER_PROPERTY_INCOMING_SPELL_DAMAGE_CONSTANT,
	}
	return funcs
end

function modifier_kez_falcon_rush_custom_barrier:GetModifierIncomingSpellDamageConstant( params )
	if not IsServer() then
		if params.report_max then
			return self.max_shield
		else
			return self.current_shield
		end
	end
	if params.damage >= self.current_shield then
		self:Destroy()
		return -self.current_shield
	else
		self.current_shield = self.current_shield-params.damage
		self:SendBuffRefreshToClients()
		return -params.damage
	end
end

modifier_kez_falcon_rush_custom_damage = class({})
function modifier_kez_falcon_rush_custom_damage:IsHidden() return true end
function modifier_kez_falcon_rush_custom_damage:IsPurgable() return false end
function modifier_kez_falcon_rush_custom_damage:IsPurgeException() return false end
function modifier_kez_falcon_rush_custom_damage:RemoveOnDeath() return false end
function modifier_kez_falcon_rush_custom_damage:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
    }
end
function modifier_kez_falcon_rush_custom_damage:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("base_echo_damage") - 100
end