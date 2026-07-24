--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_night_stalker_creaping_smile", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_creaping_smile", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_night_stalker_creaping_smile_debuff", "heroes/npc_dota_hero_night_stalker_custom/night_stalker_creaping_smile", LUA_MODIFIER_MOTION_NONE)

night_stalker_creaping_smile = class({})

night_stalker_creaping_smile.modifier_night_stalker_15 = {15,30,45}
night_stalker_creaping_smile.modifier_night_stalker_19 = {10,20,30}

function night_stalker_creaping_smile:OnSpellStart()
    if not IsServer() then return end
	local duration = self:GetSpecialValueFor("duration_night")
    if GameRules:IsDaytime() or self:GetCaster():HasModifier("modifier_night_stalker_revelation_thinker_night_buff") or self:GetCaster():HasModifier("modifier_night_stalker_day_walker") or self:GetCaster():HasModifier("modifier_night_stalker_14") then 
	    duration = self:GetSpecialValueFor("duration_day")
    end
	self:GetCaster():EmitSound("Hero_Nightstalker.Trickling_Fear")
	self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_night_stalker_creaping_smile", {duration = duration})
end

function night_stalker_creaping_smile:GetCastRange(vLocation, hTarget)
    return self:GetSpecialValueFor("radius")
end

modifier_night_stalker_creaping_smile = class({})

function modifier_night_stalker_creaping_smile:IsPurgable() return false end

function modifier_night_stalker_creaping_smile:OnCreated()
    if not IsServer() then return end
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
    self:GetParent():EmitSound("Hero_Nightstalker.Trickling_Fear_lp")
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_night_stalker/nightstalker_crippling_fear_aura_day.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
	ParticleManager:SetParticleControl(particle, 1, self:GetParent():GetAbsOrigin())
	ParticleManager:SetParticleControl(particle, 2, Vector(self.radius, self.radius, self.radius))
	ParticleManager:SetParticleControl(particle, 3, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
end

function modifier_night_stalker_creaping_smile:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Nightstalker.Trickling_Fear_end")
    self:GetParent():StopSound("Hero_Nightstalker.Trickling_Fear_lp")
end

function modifier_night_stalker_creaping_smile:IsAura()
    return true
end

function modifier_night_stalker_creaping_smile:GetModifierAura()
    return "modifier_night_stalker_creaping_smile_debuff"
end

function modifier_night_stalker_creaping_smile:GetAuraRadius()
    return self.radius
end

function modifier_night_stalker_creaping_smile:GetAuraDuration()
    return 0
end

function modifier_night_stalker_creaping_smile:GetAuraSearchTeam()
    return DOTA_UNIT_TARGET_TEAM_ENEMY
end

function modifier_night_stalker_creaping_smile:GetAuraSearchType()
    return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_night_stalker_creaping_smile:GetAuraSearchFlags()
    return DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES
end

modifier_night_stalker_creaping_smile_debuff = class({})

function modifier_night_stalker_creaping_smile_debuff:OnCreated()
    if not IsServer() then return end
    local tick_rate = self:GetAbility():GetSpecialValueFor("tick_rate")
    local damage = self:GetAbility():GetSpecialValueFor("damage_per_second")
    if self:GetCaster():HasModifier("modifier_night_stalker_15") then
        damage = damage + self:GetAbility().modifier_night_stalker_15[self:GetCaster():GetTalentLevel("modifier_night_stalker_15")]
    end
    if self:GetCaster():HasModifier("modifier_night_stalker_19") then
        damage = damage + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility().modifier_night_stalker_19[self:GetCaster():GetTalentLevel("modifier_night_stalker_19")])
    end
    self.dps = damage * tick_rate
    self:StartIntervalThink(tick_rate)
end

function modifier_night_stalker_creaping_smile_debuff:OnIntervalThink()
    if not IsServer() then return end
    ApplyDamage({victim = self:GetParent(), attacker = self:GetCaster(), damage = self.dps, damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
end

function modifier_night_stalker_creaping_smile_debuff:CheckState()
    return
    {
        [MODIFIER_STATE_DISARMED] = true,
    }
end