--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_riki_poison_dart_custom_sleep", "heroes/npc_dota_hero_riki_custom/riki_poison_dart_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_riki_poison_dart_custom_debuff", "heroes/npc_dota_hero_riki_custom/riki_poison_dart_custom", LUA_MODIFIER_MOTION_NONE)

riki_poison_dart_custom = class({})

function riki_poison_dart_custom:Precache(context)
    PrecacheResource("particle", "particles/riki_shard_proj.vpcf", context)
    PrecacheResource("particle", "particles/riki_sleep_status_effect.vpcf", context)
    PrecacheResource("particle", "particles/riki_shard_cast.vpcf", context)
    PrecacheResource("particle", "particles/riki_shard_debuff.vpcf", context)
end

function riki_poison_dart_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    local projectile = 
    {
        Target = target,
        Source = self:GetCaster(),
        Ability = self,
        EffectName = "particles/riki_shard_proj.vpcf",
        iMoveSpeed = self:GetSpecialValueFor("projectile_speed"),
        vSourceLoc = self:GetCaster():GetAbsOrigin(),
        bDrawsOnMinimap = false,
        bDodgeable = true,
        bIsAttack = false,
        bVisibleToEnemies = true,
    }
    ProjectileManager:CreateTrackingProjectile(projectile)
    self:GetCaster():EmitSound("Hero_Riki.SleepDart.Cast")
    local particle = ParticleManager:CreateParticle("particles/riki_shard_cast.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
    ParticleManager:SetParticleControl(particle, 0, self:GetCaster():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle)
end

function riki_poison_dart_custom:OnProjectileHit(target, vLocation)
    if target == nil then return end
    if target:TriggerSpellAbsorb(self) then return end
    target:EmitSound("Hero_Riki.SleepDart.Target")
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier(self:GetCaster(), self, "modifier_riki_poison_dart_custom_sleep", {duration = duration * (1 - target:GetStatusResistance())})
end

modifier_riki_poison_dart_custom_sleep = class({})

function modifier_riki_poison_dart_custom_sleep:OnCreated()
    if not IsServer() then return end
    self.current_damage = 0
    self.incoming_unsleep = self:GetAbility():GetSpecialValueFor("incoming_unsleep")
end

function modifier_riki_poison_dart_custom_sleep:OnTakeDamage(params)
    if params.unit ~= self:GetParent() then return end
    self.current_damage = self.current_damage + params.damage
    if self.current_damage >= self.incoming_unsleep then
        self:Destroy()
    end
end

function modifier_riki_poison_dart_custom_sleep:GetEffectName()
    return "particles/riki_shard_debuff.vpcf"
end

function modifier_riki_poison_dart_custom_sleep:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_riki_poison_dart_custom_sleep:GetStatusEffectName()
    return "particles/riki_sleep_status_effect.vpcf"
end

function modifier_riki_poison_dart_custom_sleep:StatusEffectPriority()
    return 10
end

function modifier_riki_poison_dart_custom_sleep:CheckState()
    return
    {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_riki_poison_dart_custom_sleep:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("Hero_Riki.SleepDart.Damage")
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_riki_poison_dart_custom_debuff", {duration = self:GetAbility():GetSpecialValueFor("debuff_duration") * (1 - self:GetParent():GetStatusResistance())})
    ApplyDamage({ victim = self:GetParent(), attacker = self:GetCaster(), damage = self:GetAbility():GetSpecialValueFor("damage"), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility() })
end

modifier_riki_poison_dart_custom_debuff = class({})

function modifier_riki_poison_dart_custom_debuff:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE
    }
end

function modifier_riki_poison_dart_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    return self:GetAbility():GetSpecialValueFor("movement_slow")
end