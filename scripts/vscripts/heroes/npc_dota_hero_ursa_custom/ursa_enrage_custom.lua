--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_ursa_enrage_custom", "heroes/npc_dota_hero_ursa_custom/ursa_enrage_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ursa_enrage_custom_debuff", "heroes/npc_dota_hero_ursa_custom/ursa_enrage_custom", LUA_MODIFIER_MOTION_NONE )

ursa_enrage_custom = class({})

ursa_enrage_custom.modifier_ursa_1 = {80,100,120}
ursa_enrage_custom.modifier_ursa_1_radius = 400
ursa_enrage_custom.modifier_ursa_7 = 2
ursa_enrage_custom.modifier_ursa_21_damage = 350
ursa_enrage_custom.modifier_ursa_21_radius = 900
ursa_enrage_custom.modifier_ursa_21_duration = 1.6
ursa_enrage_custom.modifier_ursa_10 = {100,150}
ursa_enrage_custom.modifier_ursa_20 = {0,20}

function ursa_enrage_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_ursa_20") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE + DOTA_ABILITY_BEHAVIOR_IGNORE_PSEUDO_QUEUE + DOTA_ABILITY_BEHAVIOR_UNRESTRICTED
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function ursa_enrage_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf", context )
    PrecacheResource( "particle", "particles/ursa_custom_fx/ursa_scream.vpcf", context )
    PrecacheResource( "particle", "particles/custom_ursa_fx/generic_muted.vpcf", context )
    PrecacheResource( "particle", "particles/items5_fx/wraith_pact_pulses.vpcf", context )
end

function ursa_enrage_custom:OnSpellStart(new_duration, earth_shock)
	if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_ursa_7") then
        duration = duration + self.modifier_ursa_7
    end
    if new_duration then
        duration = new_duration
    end
    if not earth_shock then
	    self:GetCaster():Purge(false, true, false, true, false)
    end
    local modifier_ursa_enrage_custom = self:GetCaster():FindModifierByName("modifier_ursa_enrage_custom")
    if modifier_ursa_enrage_custom and new_duration then
        modifier_ursa_enrage_custom:SetDuration(modifier_ursa_enrage_custom:GetRemainingTime() + new_duration, true)
    else
        self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_ursa_enrage_custom", { duration = duration })
    end
	self:GetCaster():EmitSound("Hero_Ursa.Enrage")

    if self:GetCaster():HasModifier("modifier_ursa_21") then
        local particle = ParticleManager:CreateParticle("particles/ursa_custom_fx/ursa_scream.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
        ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(particle)
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self.modifier_ursa_21_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
        for _, enemy in pairs(enemies) do
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self.modifier_ursa_21_damage, ability = self, damage_type = DAMAGE_TYPE_PURE})
            enemy:AddNewModifier(self:GetCaster(), self, "modifier_ursa_enrage_custom_debuff", {duration = self.modifier_ursa_21_duration})
        end
    end
end

modifier_ursa_enrage_custom = class({})
function modifier_ursa_enrage_custom:IsPurgable() return false end
function modifier_ursa_enrage_custom:IsPurgeException() return false end

function modifier_ursa_enrage_custom:OnCreated()
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
    if not IsServer() then return end
    self:GetCaster():SetRenderColor(255,0,0)
    if self:GetCaster():HasModifier("modifier_ursa_1") then
        self:StartIntervalThink(0.5)
    end
end

function modifier_ursa_enrage_custom:OnIntervalThink()
    if not IsServer() then return end
    local units = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCaster():GetAoeBonus(self:GetAbility().modifier_ursa_1_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false )
    local damage = (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_ursa_1[self:GetCaster():GetTalentLevel("modifier_ursa_1")]) * 0.5
    for _,unit in pairs(units) do
        ApplyDamage({ victim = unit, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility(), damage_flags = DOTA_DAMAGE_FLAG_BYPASSES_PHYSICAL_BLOCK  })
    end
    local particle = ParticleManager:CreateParticle("particles/items5_fx/wraith_pact_pulses.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 1, Vector(400/2.2,0,0))
    ParticleManager:ReleaseParticleIndex(particle)
end

function modifier_ursa_enrage_custom:OnRefresh()
	self.damage_reduction = self:GetAbility():GetSpecialValueFor("damage_reduction")
	self.status_resistance = self:GetAbility():GetSpecialValueFor("status_resistance")
end

function modifier_ursa_enrage_custom:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():SetRenderColor(255,255,255)
end

function modifier_ursa_enrage_custom:DeclareFunctions()
	return
    {
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_STATUS_RESISTANCE_STACKING,
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
	}
end

function modifier_ursa_enrage_custom:GetModifierConstantHealthRegen()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_ursa_10") then
        bonus = self:GetAbility().modifier_ursa_10[self:GetCaster():GetTalentLevel("modifier_ursa_10")]
    end
	return bonus
end

function modifier_ursa_enrage_custom:GetModifierIncomingDamage_Percentage()
    if self:GetCaster():HasModifier("modifier_ursa_7") then return end
	return self.damage_reduction
end

function modifier_ursa_enrage_custom:GetModifierTotalDamageOutgoing_Percentage()
    if not self:GetCaster():HasModifier("modifier_ursa_7") then return end
	return self.damage_reduction * (-1)
end

function modifier_ursa_enrage_custom:GetModifierStatusResistanceStacking()
	return self.status_resistance
end

function modifier_ursa_enrage_custom:GetModifierModelScale()
	return 30
end

function modifier_ursa_enrage_custom:GetEffectName()
	return "particles/units/heroes/hero_ursa/ursa_enrage_buff.vpcf"
end

function modifier_ursa_enrage_custom:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_ursa_enrage_custom:CustomIncreaseModifierDuration()
    if self:GetCaster():HasModifier("modifier_ursa_20") then
        return self:GetAbility().modifier_ursa_20[self:GetCaster():GetTalentLevel("modifier_ursa_20")]
    end
end

modifier_ursa_enrage_custom_debuff = class({})

function modifier_ursa_enrage_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_MUTED] = true,
    }
end

function modifier_ursa_enrage_custom_debuff:GetEffectName()
    return "particles/custom_ursa_fx/generic_muted.vpcf"
end

function modifier_ursa_enrage_custom_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end