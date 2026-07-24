--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_warlock_shadow_word_custom", "heroes/npc_dota_hero_warlock_custom/warlock_shadow_word_custom", LUA_MODIFIER_MOTION_NONE)

warlock_shadow_word_custom = class({})
warlock_shadow_word_custom.modifier_warlock_3 = {200,400}
warlock_shadow_word_custom.modifier_warlock_5 = {10,20,30}

function warlock_shadow_word_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_shadow_word_buff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_shadow_word_debuff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_warlock/warlock_shadow_word_damage.vpcf", context)
end

function warlock_shadow_word_custom:GetAOERadius()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_warlock_3") then
        bonus = self.modifier_warlock_3[self:GetCaster():GetTalentLevel("modifier_warlock_3")]
    end
    return self:GetSpecialValueFor("spell_aoe") + self:GetCaster():GetAoeBonus(bonus)
end

function warlock_shadow_word_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():GetTeamNumber() ~= target:GetTeamNumber() then
        duration = duration * (1-target:GetStatusResistance())
    end
    target:AddNewModifier(self:GetCaster(), self, "modifier_warlock_shadow_word_custom", {duration = duration})
end

modifier_warlock_shadow_word_custom = class({})
function modifier_warlock_shadow_word_custom:GetAttributes() return MODIFIER_ATTRIBUTE_MULTIPLE end
function modifier_warlock_shadow_word_custom:IsDebuff() return self:GetCaster():GetTeamNumber() ~= self:GetParent():GetTeamNumber() end
function modifier_warlock_shadow_word_custom:OnCreated()
	self.caster = self:GetCaster()
	self.ability = self:GetAbility()
	self.parent = self:GetParent()
    self.tick_interval = self:GetAbility():GetSpecialValueFor("tick_interval")
    self.spell_aoe = self:GetAbility():GetSpecialValueFor("spell_aoe")
    if self:GetCaster():HasModifier("modifier_warlock_3") then
        self.spell_aoe = self.spell_aoe + self:GetAbility().modifier_warlock_3[self:GetCaster():GetTalentLevel("modifier_warlock_3")]
    end
    self.spell_aoe = self:GetCaster():GetAoeBonus(self.spell_aoe)
    if not IsServer() then return end
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    local particle_name = "particles/units/heroes/hero_warlock/warlock_shadow_word_buff.vpcf"
    self.sound = "Hero_Warlock.ShadowWordCastGood"
    if self.parent:GetTeamNumber() ~= self.caster:GetTeamNumber() then
        self.sound = "Hero_Warlock.ShadowWordCastBad"
        particle_name = "particles/units/heroes/hero_warlock/warlock_shadow_word_debuff.vpcf"
    end
    local particle = ParticleManager:CreateParticle(particle_name, PATTACH_ABSORIGIN_FOLLOW, self.parent)
    ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 2, self.parent:GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():EmitSound(self.sound)
    self:GetParent():EmitSound("Hero_Warlock.ShadowWord")
	self:StartIntervalThink(self.tick_interval)
end

function modifier_warlock_shadow_word_custom:OnIntervalThink()
    if not IsServer() then return end
    local damage = self.damage
    if self:GetCaster():HasModifier("modifier_warlock_5") then
        damage = damage + (self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * self:GetAbility().modifier_warlock_5[self:GetCaster():GetTalentLevel("modifier_warlock_5")])
    end
    local units = FindUnitsInRadius(self.caster:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.spell_aoe, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
    for _, unit in pairs(units) do
        if unit:GetTeamNumber() == self.caster:GetTeamNumber() then
            unit:Heal(damage * self.tick_interval, self.ability)
            SendOverheadEventMessage( nil, OVERHEAD_ALERT_HEAL, unit, damage * self.tick_interval, unit:GetPlayerOwner() )
        else
            ApplyDamage({victim = unit, attacker = self.caster, damage = damage * self.tick_interval, damage_type = DAMAGE_TYPE_MAGICAL, ability = self.ability})
        end
        if unit ~= self.parent then
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_warlock/warlock_shadow_word_damage.vpcf", PATTACH_CUSTOMORIGIN_FOLLOW, self.parent)
            ParticleManager:SetParticleControlEnt(particle, 0, self.parent, PATTACH_POINT_FOLLOW, "attach_hitloc", self.parent:GetAbsOrigin(), true)
            ParticleManager:SetParticleControlEnt(particle, 1, unit, PATTACH_POINT_FOLLOW, "attach_hitloc", unit:GetAbsOrigin(), true)
            if unit:GetTeamNumber() == self.caster:GetTeamNumber() then
                ParticleManager:SetParticleControl(particle, 3, Vector(1,1,1))
            end
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
end

function modifier_warlock_shadow_word_custom:OnDestroy()
	if not IsServer() then return end
    self.parent:StopSound(self.sound)
    self.parent:StopSound("Hero_Warlock.ShadowWord")
end