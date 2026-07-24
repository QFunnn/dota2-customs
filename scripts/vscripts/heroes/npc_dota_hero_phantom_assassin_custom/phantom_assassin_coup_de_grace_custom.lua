--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier( "modifier_phantom_assassin_coup_de_grace_custom", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_coup_de_grace_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_coup_de_grace_custom_active", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_coup_de_grace_custom", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_phantom_assassin_coup_de_grace_custom_focus", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_coup_de_grace_custom", LUA_MODIFIER_MOTION_NONE )
  
phantom_assassin_coup_de_grace_custom = class({})

function phantom_assassin_coup_de_grace_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", context )
    PrecacheResource( "particle", "particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", context )
end

phantom_assassin_coup_de_grace_custom.modifier_phantom_assassin_7_perc = 3
phantom_assassin_coup_de_grace_custom.modifier_phantom_assassin_7_str = 30
phantom_assassin_coup_de_grace_custom.modifier_phantom_assassin_19 = 10 

function phantom_assassin_coup_de_grace_custom:GetIntrinsicModifierName()
    return "modifier_phantom_assassin_coup_de_grace_custom"
end

function phantom_assassin_coup_de_grace_custom:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_phantom_assassin_coup_de_grace_custom_active") then
        return "phantom_assassin_19"
    end
    return "phantom_assassin_coup_de_grace"
end

function phantom_assassin_coup_de_grace_custom:OnSpellStart()
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Terrorblade.ConjureImage")
    self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_coup_de_grace_custom_focus", {})
end

function phantom_assassin_coup_de_grace_custom:GetCooldown(level)
    local cooldown = 0
    if self:GetCaster():HasModifier("modifier_phantom_assassin_19") then
        return self.modifier_phantom_assassin_19
    end
    return 0
end

function phantom_assassin_coup_de_grace_custom:GetBehavior()
    if self:GetCaster():HasModifier("modifier_phantom_assassin_19") then
        return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return DOTA_ABILITY_BEHAVIOR_PASSIVE
end

modifier_phantom_assassin_coup_de_grace_custom = class({})

function modifier_phantom_assassin_coup_de_grace_custom:IsHidden()
    return true
end

function modifier_phantom_assassin_coup_de_grace_custom:IsPurgable()
    return false
end

function modifier_phantom_assassin_coup_de_grace_custom:DeclareFunctions()
    return
    {
         
    }
end

function modifier_phantom_assassin_coup_de_grace_custom:OnAttackLanded(params)
    if not IsServer() then return end
    if params.target == nil then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsBuilding() then return end
    if self:GetParent():PassivesDisabled() then return end
    self:GetCriticalStrikeModifier()
end

function modifier_phantom_assassin_coup_de_grace_custom:GetCriticalStrikeModifier()
    if not IsServer() then return end
    if self:GetCaster():GetStrength() <= 0 then return end
    local chance = self:GetAbility():GetSpecialValueFor( "crit_chance" )
    local duration = self:GetAbility():GetSpecialValueFor("duration")
    if self:GetParent():HasModifier("modifier_phantom_assassin_stifling_dagger_custom") then
        chance = self:GetAbility():GetSpecialValueFor("dagger_crit_chance")
    end
    if self:GetCaster():HasModifier("modifier_phantom_assassin_7") then
        local bonus_chance = (self:GetCaster():GetStrength() / self:GetAbility().modifier_phantom_assassin_7_str) * self:GetAbility().modifier_phantom_assassin_7_perc
        chance = chance + bonus_chance
    end
    local random = RollPseudoRandomPercentage(chance, 415, self:GetParent())
    if random or self:GetCaster():HasModifier("modifier_phantom_assassin_coup_de_grace_custom_active") then
        self:GetParent():RemoveModifierByName("modifier_phantom_assassin_coup_de_grace_custom_focus")
        self:GetParent():RemoveModifierByName("modifier_phantom_assassin_coup_de_grace_custom_active")
        self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_phantom_assassin_coup_de_grace_custom_focus", {duration = duration})
    end
end

--------------------------------------------------------------------------------------------------

modifier_phantom_assassin_coup_de_grace_custom_active = class({})

function modifier_phantom_assassin_coup_de_grace_custom_active:IsPurgable() return false end

function modifier_phantom_assassin_coup_de_grace_custom_active:GetEffectName()
    return "particles/phantom_19_arcana.vpcf"
end

---------------------------------------------------------------------------------------------------


modifier_phantom_assassin_coup_de_grace_custom_focus = class({})

function modifier_phantom_assassin_coup_de_grace_custom_focus:IsPurgable() return false end
function modifier_phantom_assassin_coup_de_grace_custom_focus:IsPurgeException() return false end

function modifier_phantom_assassin_coup_de_grace_custom_focus:GetEffectName()
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_mark_overhead.vpcf"
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
    }
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:OnCreated()
    if not IsServer() then return end
    self.record = nil
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:GetCritDamage()
	return self:GetAbility():GetSpecialValueFor("crit_bonus") 
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:GetModifierPreAttack_CriticalStrike( params )
    if not IsServer() then return end
    self.record = params.record
    return self:GetAbility():GetSpecialValueFor( "crit_bonus" ) 
end

function modifier_phantom_assassin_coup_de_grace_custom_focus:GetModifierProcAttack_Feedback( params )
    if not IsServer() then return end
    if not self.record then return end
    local target = params.target

    local coup_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControlEnt(coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    ParticleManager:SetParticleControl(coup_pfx, 1, target:GetAbsOrigin())

    local line = (target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
    ParticleManager:SetParticleControlTransformForward( coup_pfx, 1, target:GetOrigin(), -line )
    ParticleManager:ReleaseParticleIndex(coup_pfx)

    target:EmitSound("Hero_PhantomAssassin.CoupDeGrace")

    if self:GetCaster():GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
        target:EmitSound("Hero_PhantomAssassin.Arcana_Layer")
        local coup_pfx = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
        ParticleManager:SetParticleControlEnt(coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
        ParticleManager:SetParticleControl(coup_pfx, 1, target:GetAbsOrigin())
        local line = (target:GetAbsOrigin() - self:GetParent():GetAbsOrigin()):Normalized()
        ParticleManager:SetParticleControlTransformForward( coup_pfx, 1, target:GetOrigin(), -line )
        ParticleManager:ReleaseParticleIndex(coup_pfx)
    end

    self:Destroy()
end