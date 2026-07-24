--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_ogre_magi_smash_custom_buff", "heroes/npc_dota_hero_ogre_magi_custom/ogre_magi_smash_custom", LUA_MODIFIER_MOTION_NONE )

ogre_magi_smash_custom = class({})

ogre_magi_smash_custom.modifier_ogre_magi_4_radius = 450
ogre_magi_smash_custom.modifier_ogre_magi_4_duration = {3,6,9}
ogre_magi_smash_custom.modifier_ogre_magi_5_cd = {-2,-4,-6}
ogre_magi_smash_custom.modifier_ogre_magi_4 = 200

function ogre_magi_smash_custom:GetBehavior()
    local behavior = self.BaseClass.GetBehavior(self)
    if self:GetCaster():HasModifier("modifier_ogre_magi_5") then
        behavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET + DOTA_ABILITY_BEHAVIOR_IMMEDIATE
    end
    return behavior
end

function ogre_magi_smash_custom:Precache(context)
    PrecacheResource("particle", "particles/ogre_magi_spell/ogre_magi_spell.vpcf", context)
end

function ogre_magi_smash_custom:GetCooldown(iLevel)
    local cooldown = self.BaseClass.GetCooldown(self, iLevel)
    if self:GetCaster():HasModifier("modifier_ogre_magi_5") then
        cooldown = cooldown + self.modifier_ogre_magi_5_cd[self:GetCaster():GetTalentLevel("modifier_ogre_magi_5")]
    end
    return cooldown
end

function ogre_magi_smash_custom:OnSpellStart(new_target)
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if new_target then
        target = new_target
    end
    target:RemoveModifierByName("modifier_ogre_magi_smash_custom_buff")
    target:EmitSound("Hero_OgreMagi.FireShield.Target")
    local duration = self:GetSpecialValueFor("duration")
    target:AddNewModifier(caster, self, "modifier_ogre_magi_smash_custom_buff", {duration = duration})
end

function ogre_magi_smash_custom:OnProjectileHit(target, vLocation)
    if not target then return end
    local damage = self:GetSpecialValueFor("damage") + (self:GetCaster():GetStrength() / 100 * self:GetSpecialValueFor("damage_str"))
    ApplyDamage( { victim = target, attacker = self:GetCaster(), damage = damage, damage_type = self:GetAbilityDamageType(), ability = self } )
    target:EmitSound("Hero_OgreMagi.FireShield.Damage")
end

modifier_ogre_magi_smash_custom_buff = class({})
function modifier_ogre_magi_smash_custom_buff:IsHidden() return false end

function modifier_ogre_magi_smash_custom_buff:OnCreated()
    self.parent = self:GetParent()
    self.ability = self:GetAbility()
    self.speed = self.ability:GetSpecialValueFor("projectile_speed")
    self.damage_reduce = self.ability:GetSpecialValueFor("damage_reduce")
    self.max_stacks = self.ability:GetSpecialValueFor("attacks")
    self.add_stacks = self.ability:GetSpecialValueFor("attacks_multi")
    self.max = self.ability:GetSpecialValueFor("max")
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle( "particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield.vpcf", PATTACH_CENTER_FOLLOW, self.parent )
    ParticleManager:SetParticleControlEnt(self.particle, 0, self.parent, PATTACH_CENTER_FOLLOW , nil, self.parent:GetOrigin(), true )
    ParticleManager:SetParticleControl(self.particle, 1, Vector( 3, 0, 0 ) )
    ParticleManager:SetParticleControl(self.particle, 9, Vector( 1, 0, 0 ) )
    ParticleManager:SetParticleControl(self.particle, 10, Vector( 1, 0, 0 ) )
    ParticleManager:SetParticleControl(self.particle, 11, Vector( 1, 0, 0 ) )
    self:AddParticle(self.particle,false, false, -1, false, false)
    self:SetStackCount(self.max_stacks)
end

function modifier_ogre_magi_smash_custom_buff:OnRefresh()
    if not IsServer() then return end
    if self:GetStackCount() >= self.max then return end
    self:SetStackCount(self:GetStackCount() + self.add_stacks)
    if self.particle then
        ParticleManager:SetParticleControl(self.particle, 9, Vector( 1, 0, 0 ) )
        ParticleManager:SetParticleControl(self.particle, 10, Vector( 1, 0, 0 ) )
        ParticleManager:SetParticleControl(self.particle, 11, Vector( 1, 0, 0 ) )
    end
end

function modifier_ogre_magi_smash_custom_buff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_ogre_magi_smash_custom_buff:GetModifierIncomingDamage_Percentage(params)
    if not IsServer() then return end
    if not params.attacker then return end
    if params.inflictor then return end 
    if not params.attacker:IsHero() then return end
    self:RemoveStack(params.attacker)
    return self.damage_reduce
end

function modifier_ogre_magi_smash_custom_buff:RemoveStack(target)
    if not IsServer() then return end
    local info = 
    {
        Target = target,
        Source = self.parent,
        Ability = self.ability,	
        EffectName = "particles/units/heroes/hero_ogre_magi/ogre_magi_fire_shield_projectile.vpcf",
        iMoveSpeed = self.speed,
        bReplaceExisting = false,
        bProvidesVision = true,
        iVisionRadius = 50,
        iVisionTeamNumber = self.parent:GetTeamNumber(),			
    }
    ProjectileManager:CreateTrackingProjectile(info)
    self:DecrementStackCount()
    if self.particle then
        if self:GetStackCount() == 3 then
            ParticleManager:SetParticleControl(self.particle, 9, Vector( 1, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 10, Vector( 1, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 11, Vector( 1, 0, 0 ) )
        elseif self:GetStackCount() == 2 then
            ParticleManager:SetParticleControl(self.particle, 9, Vector( 1, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 10, Vector( 1, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 11, Vector( 0, 0, 0 ) )
        elseif self:GetStackCount() == 1 then
            ParticleManager:SetParticleControl(self.particle, 9, Vector( 1, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 10, Vector( 0, 0, 0 ) )
            ParticleManager:SetParticleControl(self.particle, 11, Vector( 0, 0, 0 ) )
        end
    end
    if self:GetStackCount() <= 0 then
        self:Destroy()
    end
end

function modifier_ogre_magi_smash_custom_buff:OnDestroy()
    if not IsServer() then return end
    local caster = self:GetCaster()
    if caster and not caster:IsNull() and caster:HasModifier("modifier_ogre_magi_4") then
        local ogre_magi_ignite_custom = caster:FindAbilityByName("ogre_magi_ignite_custom")
        if ogre_magi_ignite_custom then
            local particle = ParticleManager:CreateParticle("particles/ogre_magi_spell/ogre_magi_spell.vpcf", PATTACH_WORLDORIGIN, caster)
            ParticleManager:SetParticleControl(particle, 0, self.parent:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(particle)
            local duration = self:GetAbility().modifier_ogre_magi_4_duration[caster:GetTalentLevel("modifier_ogre_magi_4")]
            local enemies = FindUnitsInRadius(caster:GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetParent():GetAoeBonus(self:GetAbility().modifier_ogre_magi_4_radius), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
            for _, enemy in pairs(enemies) do
                if not caster:HasModifier("modifier_ogre_magi_10") then
                    local ignite_duration = duration * (1 - enemy:GetStatusResistance())
                    local modifier_ogre_magi_ignite_custom = enemy:FindModifierByName("modifier_ogre_magi_ignite_custom")
                    if modifier_ogre_magi_ignite_custom then
                        modifier_ogre_magi_ignite_custom:SetDuration(modifier_ogre_magi_ignite_custom:GetRemainingTime() + ignite_duration, true)
                    else
                        enemy:AddNewModifier(caster, ogre_magi_ignite_custom, "modifier_ogre_magi_ignite_custom", {duration = ignite_duration})
                    end
                end
                local strength_damage = self:GetCaster():GetStrength() / 100 * self:GetAbility().modifier_ogre_magi_4
                ApplyDamage({attacker = self:GetCaster(), victim = enemy, damage = strength_damage, ability = self:GetAbility(), damage_type = DAMAGE_TYPE_MAGICAL})
            end
        end
    end
end