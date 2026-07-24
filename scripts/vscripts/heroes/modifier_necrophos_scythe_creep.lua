--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_necrolyte_reapers_scythe_respawn_time_custom", "heroes/modifier_necrophos_scythe_creep", LUA_MODIFIER_MOTION_NONE)

modifier_necrophos_scythe_creep = class({})

function modifier_necrophos_scythe_creep:IsPurgable() return false end
function modifier_necrophos_scythe_creep:IsHidden() return true end

function modifier_necrophos_scythe_creep:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_necrophos_scythe_creep:OnCreated()
    if IsServer() then
        local caster = self:GetCaster()
        local target = self:GetParent()
        self.ability = self:GetAbility()
        self.damage_per_health = self.ability:GetSpecialValueFor("damage_per_health")

        local stun_fx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
        self:AddParticle(stun_fx, false, false, -1, false, false)

        local scythe_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(scythe_fx, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(scythe_fx, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(scythe_fx, 60, Vector(252,1,1));
        ParticleManager:ReleaseParticleIndex(scythe_fx)

        self:StartIntervalThink(0.1)
    end
end
--necrolyte_reapers_scythe
function modifier_necrophos_scythe_creep:OnRefresh()
    if IsServer() then
        local caster = self:GetCaster()
        local target = self:GetParent()
        self.ability = self:GetAbility()
        self.damage_per_health = self.ability:GetSpecialValueFor("damage_per_health")

        local stun_fx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, target)
        self:AddParticle(stun_fx, false, false, -1, false, false)

        local scythe_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_necrolyte/necrolyte_scythe_start.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(scythe_fx, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", caster:GetAbsOrigin(), true)
        ParticleManager:SetParticleControlEnt(scythe_fx, 1, target, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(scythe_fx, 60, Vector(252,1,1));
        ParticleManager:ReleaseParticleIndex(scythe_fx)
    end
end

function modifier_necrophos_scythe_creep:GetEffectName()
    return "particles/units/heroes/hero_necrolyte/necrolyte_scythe.vpcf"
end

function modifier_necrophos_scythe_creep:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrophos_scythe_creep:GetPriority()
    return MODIFIER_PRIORITY_ULTRA
end

function modifier_necrophos_scythe_creep:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_necrophos_scythe_creep:CheckState()
    local state =
        {
            [MODIFIER_STATE_STUNNED] = true
        }
    return state
end

function modifier_necrophos_scythe_creep:OnDestroy()
    if IsServer() then
        local caster = self:GetCaster()
        local target = self:GetParent()
        
        if target:IsAlive() and self.ability then
            target:AddNewModifier(caster, self:GetAbility(), "modifier_stunned", {duration=FrameTime()})
            self.damage = self.damage_per_health * (target:GetMaxHealth() - target:GetHealth())
            local actually_dmg = ApplyDamage({attacker = caster, victim = target, ability = self.ability, damage = self.damage, damage_type = DAMAGE_TYPE_MAGICAL})
            SendOverheadEventMessage(nil, OVERHEAD_ALERT_DAMAGE, target, actually_dmg, nil)

        end
        if not target:IsAlive() and self:GetAbility().bRoundDueled == false then
            self:GetAbility().bRoundDueled = true
            local modifier = self:GetCaster():FindModifierByName("modifier_necrolyte_reapers_scythe_respawn_time_custom")
            if modifier then
                modifier:IncrementStackCount()
            else
                modifier = self:GetCaster():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_necrolyte_reapers_scythe_respawn_time_custom", {})
                modifier:IncrementStackCount()
            end
        end
    end
end

modifier_necrolyte_reapers_scythe_respawn_time_custom = class({})

function modifier_necrolyte_reapers_scythe_respawn_time_custom:IsPurgable() return false end
function modifier_necrolyte_reapers_scythe_respawn_time_custom:RemoveOnDeath() return false end

function modifier_necrolyte_reapers_scythe_respawn_time_custom:DeclareFunctions()
  local funcs = 
  {
       MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
       MODIFIER_PROPERTY_MANA_REGEN_CONSTANT
  }

  return funcs
end

function modifier_necrolyte_reapers_scythe_respawn_time_custom:GetModifierConstantHealthRegen()
    return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("hp_per_kill")
end

function modifier_necrolyte_reapers_scythe_respawn_time_custom:GetModifierConstantManaRegen()
    return self:GetStackCount() * self:GetAbility():GetSpecialValueFor("mana_per_kill")
end