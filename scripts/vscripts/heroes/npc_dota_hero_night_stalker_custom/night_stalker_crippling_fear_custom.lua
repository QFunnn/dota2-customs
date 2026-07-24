--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_crippling_fear_custom", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_crippling_fear_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_crippling_fear_custom_debuff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_crippling_fear_custom", LUA_MODIFIER_MOTION_NONE)

night_stalker_crippling_fear_custom = class({})

night_stalker_crippling_fear_custom.modifier_night_stalker_15 = {15,30,45}
night_stalker_crippling_fear_custom.modifier_night_stalker_15_cooldown = {-2,-4,-6}
night_stalker_crippling_fear_custom.modifier_night_stalker_19 = {20,30,40}

function night_stalker_crippling_fear_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        return DOTA_ABILITY_BEHAVIOR_PASSIVE
    end
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
end

function night_stalker_crippling_fear_custom:GetManaCost(iLevel)
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        return 0
    end
    return self.BaseClass.GetManaCost(self, iLevel)
end

function night_stalker_crippling_fear_custom:GetCooldown(iLevel)
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        return 0
    end
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_night_stalker_15") then
        bonus = self.modifier_night_stalker_15_cooldown[self:GetCaster():GetTalentLevel("modifier_night_stalker_15")]
    end
    return self.BaseClass.GetCooldown(self, iLevel) + bonus
end

function night_stalker_crippling_fear_custom:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius")
end

function night_stalker_crippling_fear_custom:OnSpellStart()
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration_day")
    if self:GetCaster():HasModifier("modifier_night_stalker_darkness_custom") or not GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_void_custom_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_7") then
	    duration = self:GetSpecialValueFor("duration_night")
    end
	self:GetCaster():EmitSound("Hero_Nightstalker.Trickling_Fear")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_crippling_fear_custom", {duration = duration})
end

function night_stalker_crippling_fear_custom:StartPassive()
    if not IsServer() then return end
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_crippling_fear_custom", {})
end

modifier_night_stalker_crippling_fear_custom = class({})

function modifier_night_stalker_crippling_fear_custom:IsPurgable() return false end
function modifier_night_stalker_crippling_fear_custom:RemoveOnDeath() return not self:GetCaster():HasModifier("modifier_night_stalker_21") end

function modifier_night_stalker_crippling_fear_custom:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self:GetParent():EmitSound("Hero_Nightstalker.Trickling_Fear_lp")
    self:AddEffect()
    self:StartIntervalThink(FrameTime())
end

function modifier_night_stalker_crippling_fear_custom:AddEffect()
    if not IsServer() then return end
    if self.particle then return end
    local effect = "particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura.vpcf"
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        effect = "particles/econ/items/nightstalker/nightstalker_ti10_silence/nightstalker_ti10.vpcf"
    end
    local particle = ParticleManager:CreateParticle(effect, PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        ParticleManager:SetParticleControlEnt(particle, 1, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_hitloc", self:GetCaster():GetAbsOrigin(), true)
    end
	ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    self.particle = particle
end

function modifier_night_stalker_crippling_fear_custom:OnIntervalThink()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        if self:GetParent():PassivesDisabled() or not self:GetParent():IgnoreWispAndInvisAndRelax(true, true, true) then
            if self.particle then
                ParticleManager:DestroyParticle(self.particle, false)
                self.particle = nil
            end
        else
            self:AddEffect()
        end
    end
end

function modifier_night_stalker_crippling_fear_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Nightstalker.Trickling_Fear_end")
    self:GetParent():StopSound("Hero_Nightstalker.Trickling_Fear_lp")
end

function modifier_night_stalker_crippling_fear_custom:IsAura()
    if self:GetCaster():HasModifier("modifier_night_stalker_21") then
        if self:GetParent():PassivesDisabled() then return end
        if not self:GetParent():IgnoreWispAndInvisAndRelax(true, true, true) then return end
    end
    return true
end

function modifier_night_stalker_crippling_fear_custom:GetModifierAura()
    return "modifier_night_stalker_crippling_fear_custom_debuff"
end

function modifier_night_stalker_crippling_fear_custom:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_crippling_fear_custom:GetAuraDuration()
    return 0
end

function modifier_night_stalker_crippling_fear_custom:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_night_stalker_crippling_fear_custom:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_night_stalker_crippling_fear_custom:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_night_stalker_crippling_fear_custom_debuff = class({})

function modifier_night_stalker_crippling_fear_custom_debuff:OnCreated()
    if not IsServer() then return end
    local tick_rate = self:GetAbility():GetSpecialValueFor("tick_rate")
    local damage = self:GetAbility():GetSpecialValueFor("dps")
    if self:GetCaster():HasModifier("modifier_night_stalker_15") then
        damage = damage + self:GetAbility().modifier_night_stalker_15[self:GetCaster():GetTalentLevel("modifier_night_stalker_15")]
    end
    if self:GetCaster():HasModifier("modifier_night_stalker_19") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_night_stalker_19[self:GetCaster():GetTalentLevel("modifier_night_stalker_19")])
    end
    self.dps = damage * tick_rate
    self:StartIntervalThink(tick_rate)
end

function modifier_night_stalker_crippling_fear_custom_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.dps, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_night_stalker_crippling_fear_custom_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_SILENCED] = true,
    }
end