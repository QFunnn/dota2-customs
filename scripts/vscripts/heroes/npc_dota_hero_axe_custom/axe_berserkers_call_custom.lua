--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_axe_berserkers_call_custom_buff", "heroes/npc_dota_hero_axe_custom/axe_berserkers_call_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_berserkers_call_custom_debuff", "heroes/npc_dota_hero_axe_custom/axe_berserkers_call_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_axe_berserkers_call_custom_fear", "heroes/npc_dota_hero_axe_custom/axe_berserkers_call_custom", LUA_MODIFIER_MOTION_NONE )

axe_berserkers_call_custom = class({})
axe_berserkers_call_custom.modifier_axe_1 = {25,50}
axe_berserkers_call_custom.modifier_axe_1_self = {25,50}
axe_berserkers_call_custom.modifier_axe_15 = 100
axe_berserkers_call_custom.modifier_axe_15_int = {80,120}
axe_berserkers_call_custom.modifier_axe_17 = {50,100}
axe_berserkers_call_custom.modifier_axe_17_armor = {5,10}

function axe_berserkers_call_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf", context)
    PrecacheResource("particle", "particles/status_fx/status_effect_beserkers_call.vpcf", context)
    PrecacheResource("particle", "particles/econ/items/juggernaut/bladekeeper_bladefury/_dc_juggernaut_blade_fury.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_juggernaut/juggernaut_blade_fury_tgt.vpcf", context)
end

function axe_berserkers_call_custom:OnAbilityPhaseInterrupted()
    self:GetCaster():StopSound("Hero_Axe.BerserkersCall.Start")
end

function axe_berserkers_call_custom:OnAbilityPhaseStart()
    self:GetCaster():EmitSound("Hero_Axe.BerserkersCall.Start")
    return true
end

function axe_berserkers_call_custom:GetCastRange(vLocation, hTarget)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_axe_17") then
        bonus = bonus + self.modifier_axe_17[self:GetCaster():GetTalentLevel("modifier_axe_17")]
    end
    return self:GetSpecialValueFor("radius") + bonus
end

function axe_berserkers_call_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_axe_11") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_DONT_RESUME_MOVEMENT
end

function axe_berserkers_call_custom:OnSpellStart()
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local radius = self:GetSpecialValueFor("radius")
    local axe_battle_hunger_custom = self:GetCaster():FindAbilityByName("axe_battle_hunger_custom")
    if self:GetCaster():HasModifier("modifier_axe_17") then
        radius = radius + self.modifier_axe_17[self:GetCaster():GetTalentLevel("modifier_axe_17")]
    end
    local modifier_name = "modifier_axe_berserkers_call_custom_debuff"
    if self:GetCaster():HasModifier("modifier_axe_21") then
        modifier_name = "modifier_axe_berserkers_call_custom_fear"
    end
    self:GetCaster():AddNewModifier( self:GetCaster(), self, "modifier_axe_berserkers_call_custom_buff", { duration = duration } )
    self:GetCaster():EmitSound("Hero_Axe.Berserkers_Call")
    local particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_axe/axe_beserkers_call_owner.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
    ParticleManager:SetParticleControlEnt( particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_mouth", Vector(0,0,0), true )
    ParticleManager:SetParticleControl(particle, 2, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex( particle )
    local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, 0, false )
    for _,enemy in pairs(enemies) do
        enemy:AddNewModifier( self:GetCaster(), self, modifier_name, { duration = duration * (1 - enemy:GetStatusResistance()) })
        if self:GetCaster():HasModifier("modifier_axe_15") then
            local damage = self.modifier_axe_15 + self:GetCaster():GetIntellect(false) / 100 * self.modifier_axe_15_int[self:GetCaster():GetTalentLevel("modifier_axe_15")]
            ApplyDamage({ victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self})
        end
        if self:GetCaster():HasModifier("modifier_axe_18") and axe_battle_hunger_custom and axe_battle_hunger_custom:GetLevel() > 0 then
            axe_battle_hunger_custom:AddTarget(enemy)
        end
    end
end

modifier_axe_berserkers_call_custom_buff = class({})
function modifier_axe_berserkers_call_custom_buff:IsPurgable() return false end

function modifier_axe_berserkers_call_custom_buff:OnCreated( kv )
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
    if self:GetCaster():HasModifier("modifier_axe_17") then
        self.bonus_armor = self.bonus_armor + self:GetAbility().modifier_axe_17_armor[self:GetCaster():GetTalentLevel("modifier_axe_17")] 
    end
end

function modifier_axe_berserkers_call_custom_buff:OnRefresh( kv )
	self.bonus_armor = self:GetAbility():GetSpecialValueFor( "bonus_armor" )
    if self:GetCaster():HasModifier("modifier_axe_17") then
        self.bonus_armor = self.bonus_armor + self:GetAbility().modifier_axe_17_armor[self:GetCaster():GetTalentLevel("modifier_axe_17")]
    end
end

function modifier_axe_berserkers_call_custom_buff:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_axe_berserkers_call_custom_buff:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_axe_berserkers_call_custom_buff:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_axe_1") then
        return self:GetAbility().modifier_axe_1_self[self:GetCaster():GetTalentLevel("modifier_axe_1")]
    end
end

function modifier_axe_berserkers_call_custom_buff:GetEffectName()
	return "particles/units/heroes/hero_axe/axe_beserkers_call.vpcf"
end

function modifier_axe_berserkers_call_custom_buff:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

modifier_axe_berserkers_call_custom_debuff = class({})
function modifier_axe_berserkers_call_custom_debuff:IsPurgable() return false end

function modifier_axe_berserkers_call_custom_debuff:OnCreated( kv )
    if not IsServer() then return end
	self:GetParent():SetForceAttackTarget( self:GetCaster() )
	self:GetParent():MoveToTargetToAttack( self:GetCaster() )
    self:StartIntervalThink(FrameTime())
end

function modifier_axe_berserkers_call_custom_debuff:OnIntervalThink()
	if not IsServer() then return end
	if not self:GetCaster():IsAlive() then
		self:Destroy()
	end
end

function modifier_axe_berserkers_call_custom_debuff:OnDestroy()
	if not IsServer() then return end
	self:GetParent():SetForceAttackTarget( nil )
end

function modifier_axe_berserkers_call_custom_debuff:CheckState()
	return
    {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_TAUNTED] = true,
	}
end

function modifier_axe_berserkers_call_custom_debuff:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

function modifier_axe_berserkers_call_custom_debuff:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA 
end

function modifier_axe_berserkers_call_custom_debuff:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_axe_berserkers_call_custom_debuff:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_axe_1") then
        return self:GetAbility().modifier_axe_1[self:GetCaster():GetTalentLevel("modifier_axe_1")]
    end
end

modifier_axe_berserkers_call_custom_fear = class({})
function modifier_axe_berserkers_call_custom_fear:GetTexture() return "axe_21" end
function modifier_axe_berserkers_call_custom_fear:IsPurgable() return false end

function modifier_axe_berserkers_call_custom_fear:OnCreated( kv )
	if not IsServer() then return end
	local pos = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin())
	pos.z = 0
	pos = pos:Normalized()
	self.position = self:GetParent():GetAbsOrigin() + pos * 3000
	if not self:GetParent():IsHero() then
		self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_disarmed", {duration = 0.1})
		self:GetParent():SetAggroTarget(nil)
	end
	self:GetParent():MoveToPosition( self.position )
    self:StartIntervalThink(0.1)
end

function modifier_axe_berserkers_call_custom_fear:OnIntervalThink()
	if not IsServer() then return end
	self:GetParent():MoveToPosition( self.position )
end

function modifier_axe_berserkers_call_custom_fear:OnDestroy()
	if not IsServer() then return end
	self:GetParent():Stop()
end

function modifier_axe_berserkers_call_custom_fear:CheckState()
	return
    {
		[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
		[MODIFIER_STATE_FEARED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
	}
end

function modifier_axe_berserkers_call_custom_fear:GetStatusEffectName()
	return "particles/status_fx/status_effect_beserkers_call.vpcf"
end

function modifier_axe_berserkers_call_custom_fear:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA 
end

function modifier_axe_berserkers_call_custom_fear:DeclareFunctions()
	return
    {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
end

function modifier_axe_berserkers_call_custom_fear:GetModifierAttackSpeedBonus_Constant()
    if self:GetCaster():HasModifier("modifier_axe_1") then
        return self:GetAbility().modifier_axe_1[self:GetCaster():GetTalentLevel("modifier_axe_1")]
    end
end