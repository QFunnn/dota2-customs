--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phantom_assassin_fan_of_knives_custom_thinker", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_fan_of_knives_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_fan_of_knives_custom", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_fan_of_knives_custom", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_fan_of_knives_custom = class({})

function phantom_assassin_fan_of_knives_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf", context )
end

phantom_assassin_fan_of_knives_custom.modifier_phantom_assassin_17 = {-2,-4}

function phantom_assassin_fan_of_knives_custom:GetCooldown(level)
    local cooldown = 0
    if self:GetCaster():HasModifier("modifier_phantom_assassin_17") then
        cooldown = self.modifier_phantom_assassin_17[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_17")]
    end
    return self.BaseClass.GetCooldown( self, level ) + cooldown
end

function phantom_assassin_fan_of_knives_custom:GetAOERadius() 
    return self:GetSpecialValueFor("radius")
end

function phantom_assassin_fan_of_knives_custom:OnSpellStart()
    self.caster = self:GetCaster()
    self.radius         = self:GetSpecialValueFor("radius") 
    self.projectile_speed   = self:GetSpecialValueFor("projectile_speed")
    self.location = self:GetCaster():GetAbsOrigin()
    self.duration       = self.radius / self.projectile_speed
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_PhantomAssassin.FanOfKnives.Cast")
    CreateModifierThinker(self.caster, self, "modifier_phantom_assassin_fan_of_knives_custom_thinker", {duration = self.duration}, self.location, self.caster:GetTeamNumber(), false)
end

modifier_phantom_assassin_fan_of_knives_custom_thinker = class({})

function modifier_phantom_assassin_fan_of_knives_custom_thinker:OnCreated()
    self.ability  = self:GetAbility()
    self.caster   = self:GetCaster()
    self.parent   = self:GetParent()
    self.radius  = self.ability:GetSpecialValueFor("radius")
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives.vpcf", PATTACH_ABSORIGIN, self.parent)
    ParticleManager:SetParticleControl(self.particle, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(self.particle, 3, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
    self.hit_enemies = {}
    self:StartIntervalThink(FrameTime())
end

function modifier_phantom_assassin_fan_of_knives_custom_thinker:OnIntervalThink()
    if not IsServer() then return end
    local radius_pct = math.min((self:GetDuration() - self:GetRemainingTime()) / self:GetDuration(), 1)
  
    local enemies = FindUnitsInRadius(self.parent:GetTeamNumber(), self.parent:GetAbsOrigin(), nil, self.radius * radius_pct, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_ANY_ORDER, false)
  
    for _, enemy in pairs(enemies) do
  
        local hit_already = false
  
        for _, hit_enemy in pairs(self.hit_enemies) do
            if hit_enemy == enemy then
                hit_already = true
                break
            end
        end

        if not hit_already and not enemy:IsMagicImmune() then
            local damage = self:GetAbility():GetSpecialValueFor("damage") + (self:GetCaster():GetIntellect(false) / 100 * self:GetAbility():GetSpecialValueFor("damage_intellect"))
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = damage, damage_type = DAMAGE_TYPE_PHYSICAL, ability = self:GetAbility()})
            local duration = self:GetAbility():GetSpecialValueFor("duration")*(1 - enemy:GetStatusResistance())
            enemy:AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_phantom_assassin_fan_of_knives_custom", {duration = duration})
            enemy:EmitSound("Hero_PhantomAssassin.Attack")
            table.insert(self.hit_enemies, enemy)
        end
    end
end

modifier_phantom_assassin_fan_of_knives_custom = class({})
function modifier_phantom_assassin_fan_of_knives_custom:IsHidden() return false end
function modifier_phantom_assassin_fan_of_knives_custom:IsPurgable() return true end
function modifier_phantom_assassin_fan_of_knives_custom:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_phantom_assassin_fan_of_knives_custom:GetEffectName() return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_shard_fan_of_knives_dot.vpcf" end