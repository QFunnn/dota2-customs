--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ancient_apparition_cold_feet_custom", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_cold_feet_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_cold_feet_custom_stunned", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_cold_feet_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ancient_apparition_cold_feet_custom_talent_boom", "heroes/npc_dota_hero_ancient_apparition_custom/ancient_apparition_cold_feet_custom", LUA_MODIFIER_MOTION_NONE )

ancient_apparition_cold_feet_custom = class({})

ancient_apparition_cold_feet_custom.modifier_ancient_apparition_15 = {200,400}
ancient_apparition_cold_feet_custom.modifier_ancient_apparition_15_damage = {15,30}
ancient_apparition_cold_feet_custom.modifier_ancient_apparition_18 = {80,120,160}
ancient_apparition_cold_feet_custom.modifier_ancient_apparition_20 = 60 -- percent duration

function ancient_apparition_cold_feet_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_15") then
        return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
    end
    return DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IGNORE_BACKSWING
end

function ancient_apparition_cold_feet_custom:GetAOERadius()
    if self:GetCaster():HasModifier("modifier_ancient_apparition_15") then
        return self.modifier_ancient_apparition_15[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_15")]
    end
end

function ancient_apparition_cold_feet_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", context)
end

function ancient_apparition_cold_feet_custom:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration")
    if caster:HasModifier("modifier_ancient_apparition_15") then
        local point = self:GetCursorPosition()
        local radius = self.modifier_ancient_apparition_15[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_15")]
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), point, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
        for _, enemy in pairs(enemies) do
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom", {})
            if self:GetCaster():HasModifier("modifier_ancient_apparition_18") then
                enemy:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom_talent_boom", {duration = duration})
            end
        end
        return
    end
    if target:TriggerSpellAbsorb(self) then return end
	target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom", {})
    if self:GetCaster():HasModifier("modifier_ancient_apparition_18") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom_talent_boom", {duration = duration})
    end
end

function ancient_apparition_cold_feet_custom:TargetColdFeet(target)
    if not IsServer() then return end
    local duration = self:GetSpecialValueFor("duration")
    local stun_duration	= self:GetSpecialValueFor("stun_duration") / 100 * self.modifier_ancient_apparition_20
    if self:GetCaster():HasModifier("modifier_ancient_apparition_20") then
        if self:GetLevel() > 0 then
            target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom_stunned", {duration = stun_duration * (1 - target:GetStatusResistance())})
            if self:GetCaster():HasModifier("modifier_ancient_apparition_18") then
                target:AddNewModifier(self:GetCaster(), self, "modifier_ancient_apparition_cold_feet_custom_talent_boom", {duration = duration})
            end
        end
    end
end

modifier_ancient_apparition_cold_feet_custom = class({})

function modifier_ancient_apparition_cold_feet_custom:OnCreated()
	if not IsServer() then return end
	self.duration = self:GetAbility():GetSpecialValueFor("duration")
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.break_distance	= self:GetAbility():GetSpecialValueFor("break_distance")
	self.stun_duration	= self:GetAbility():GetSpecialValueFor("stun_duration")
    if self:GetCaster():HasModifier("modifier_ancient_apparition_15") then
        self.damage = self.damage + self:GetAbility().modifier_ancient_apparition_15_damage[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_15")]
    end

	self.damageTable = 
    {
		victim = self:GetParent(),
		damage = self.damage * 0.5,
		damage_type = self:GetAbility():GetAbilityDamageType(),
		damage_flags = DOTA_DAMAGE_FLAG_NONE,
		attacker = self:GetCaster(),
		ability = self:GetAbility()
	}

	self.original_position	= self:GetParent():GetAbsOrigin()
	self.counter			= 1
	self.ticks				= 0
	self.interval			= 0.1
	
	self:GetParent():EmitSound("Hero_Ancient_Apparition.ColdFeetCast")

	local cold_feet_marker_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_marker.vpcf", PATTACH_ABSORIGIN, self:GetParent())
	self:AddParticle(cold_feet_marker_particle, false, false, -1, false, false)

	local cold_feet_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
	self:AddParticle(cold_feet_particle, false, false, -1, false, false)

	self:OnIntervalThink()
	self:StartIntervalThink(self.interval)
end

function modifier_ancient_apparition_cold_feet_custom:OnIntervalThink()
	if (self:GetParent():GetAbsOrigin() - self.original_position):Length2D() < self.break_distance then
		self.counter = self.counter + self.interval
		if self.counter >= 0.5 then
			if (self.ticks / 2) < self.duration then
				EmitSoundOnClient("Hero_Ancient_Apparition.ColdFeetTick", self:GetParent():GetPlayerOwner())
				SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, self:GetParent(), self.damage * 0.5, nil)
				ApplyDamage(self.damageTable)
				self.ticks = self.ticks + 1
				self.counter = 0
			else
				self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_ancient_apparition_cold_feet_custom_stunned", {duration = self.stun_duration * (1 - self:GetParent():GetStatusResistance())})
				self:Destroy()
			end
		end
	else
		self:Destroy()
	end
end

modifier_ancient_apparition_cold_feet_custom_stunned = class({})

function modifier_ancient_apparition_cold_feet_custom_stunned:GetEffectName()
	return "particles/units/heroes/hero_ancient_apparition/ancient_apparition_cold_feet_frozen.vpcf"
end

function modifier_ancient_apparition_cold_feet_custom_stunned:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_ancient_apparition_cold_feet_custom_stunned:OnCreated()
	if not IsServer() then return end
	self:GetParent():EmitSound("Hero_Ancient_Apparition.ColdFeetFreeze")
end

function modifier_ancient_apparition_cold_feet_custom_stunned:CheckState()
	local state = 
	{
		[MODIFIER_STATE_STUNNED]	= true,
		[MODIFIER_STATE_FROZEN]		= true
	}
	return state
end

modifier_ancient_apparition_cold_feet_custom_talent_boom = class({})
function modifier_ancient_apparition_cold_feet_custom_talent_boom:IsHidden() return true end
function modifier_ancient_apparition_cold_feet_custom_talent_boom:IsPurgable() return false end
function modifier_ancient_apparition_cold_feet_custom_talent_boom:OnDestroy()
    if not IsServer() then return end
    if self:GetRemainingTime() <= 0 then
        local particle = ParticleManager:CreateParticle("particles/econ/items/lich/frozen_chains_ti6/lich_frozenchains_frostnova.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        local damage = self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_ancient_apparition_18[self:GetCaster():GetTalentLevel("modifier_ancient_apparition_18")]
        ApplyDamage({attacker = self:GetCaster(), victim = self:GetParent(), ability = self:GetAbility(), damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
    end
end