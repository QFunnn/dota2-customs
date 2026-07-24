--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_phantom_assassin_stifling_dagger_custom", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_stifling_dagger_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_stifling_dagger_custom_debuff", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_stifling_dagger_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phantom_assassin_stifling_dagger_custom_talent", "heroes/npc_dota_hero_phantom_assassin_custom/phantom_assassin_stifling_dagger_custom", LUA_MODIFIER_MOTION_NONE)

phantom_assassin_stifling_dagger_custom = class({})

function phantom_assassin_stifling_dagger_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf", context )
end

phantom_assassin_stifling_dagger_custom.modifier_phantom_assassin_9 = {15,30}
phantom_assassin_stifling_dagger_custom.modifier_phantom_assassin_15 = {1,2}
phantom_assassin_stifling_dagger_custom.modifier_phantom_assassin_21 = 900

function phantom_assassin_stifling_dagger_custom:GetIntrinsicModifierName()
    return "modifier_phantom_assassin_stifling_dagger_custom_talent"
end

function phantom_assassin_stifling_dagger_custom:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    self:ThrowDagger(target)
    if self:GetCaster():HasModifier("modifier_phantom_assassin_15") then
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetCastRange(self:GetCaster():GetAbsOrigin(),self:GetCaster()), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false )
        local secondary_knives_thrown = 0
        for _, enemy in pairs(enemies) do
            if enemy ~= target then
                self:ThrowDagger(enemy)
                secondary_knives_thrown = secondary_knives_thrown + 1
            end
            if secondary_knives_thrown >= self.modifier_phantom_assassin_15[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_15")] then
                break
            end
        end
    end
end

function phantom_assassin_stifling_dagger_custom:ThrowDagger( target )
    if not IsServer() then return end
    local info = 
    {
        Target = target,
        Source = self:GetCaster(),
        Ability = self, 
        EffectName = "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger.vpcf",
        iMoveSpeed = self:GetSpecialValueFor("dagger_speed"),
        bReplaceExisting = false,                         
        bProvidesVision = true,                           
        iVisionRadius = 450,        
        iVisionTeamNumber = self:GetCaster():GetTeamNumber()        
    }
    self:GetCaster():EmitSound("Hero_PhantomAssassin.Dagger.Cast")
    ProjectileManager:CreateTrackingProjectile(info)
end

modifier_phantom_assassin_stifling_dagger_custom_talent = class({})

function modifier_phantom_assassin_stifling_dagger_custom_talent:IsHidden() return true end
function modifier_phantom_assassin_stifling_dagger_custom_talent:IsPurgable() return false end
function modifier_phantom_assassin_stifling_dagger_custom_talent:RemoveOnDeath() return false end

function modifier_phantom_assassin_stifling_dagger_custom_talent:DeclareFunctions()
    local funcs = 
    {
        MODIFIER_EVENT_ON_ABILITY_EXECUTED
    }
    return funcs
end

function modifier_phantom_assassin_stifling_dagger_custom_talent:OnAbilityExecuted( params )
    if not IsServer() then return end
    if params.unit~=self:GetParent() then return end
    if not params.ability then return end
    if params.ability:IsItem() or params.ability:IsToggle() then return end
    if not self:GetCaster():HasModifier("modifier_phantom_assassin_21") then return end
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetCaster():GetAbsOrigin(), nil, self:GetAbility().modifier_phantom_assassin_21, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false )
    if #enemies == 0 then return end
    self:GetAbility():ThrowDagger( enemies[1] )
end

function phantom_assassin_stifling_dagger_custom:OnProjectileHit( target, location )
    if not IsServer() then return end
    if target==nil then return end
    if target:IsInvulnerable() then return end
    if target:TriggerSpellAbsorb( self ) then return end

    local duration = self:GetSpecialValueFor("duration")

    --if not self:GetCaster():HasModifier("modifier_phantom_assassin_21") then
        local modifier = self:GetCaster():AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_stifling_dagger_custom", {})

        target:EmitSound( "Hero_PhantomAssassin.Dagger.Target" )

        self:GetCaster():PerformAttack(target, true, true, true, false, false, false, true)

        if not target:IsMagicImmune() then 
            target:AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_stifling_dagger_custom_debuff" ,{duration = duration * (1-target:GetStatusResistance())})
        end

        AddFOWViewer(self:GetCaster():GetTeamNumber(), location, 450, 3.35, false)

        if modifier then 
            modifier:Destroy()
        end
    --else
    --    local percentage = self:GetSpecialValueFor("attack_factor_tooltip")
--
    --    if self:GetCaster():HasModifier("modifier_phantom_assassin_9") then
    --        percentage = percentage + self.modifier_phantom_assassin_9[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_9")]
    --    end
--
    --    local damage = ( self:GetCaster():GetAverageTrueAttackDamage(nil) / 100 * percentage ) + self:GetSpecialValueFor( "base_damage" )
--
    --    local phantom_assassin_coup_de_grace_custom = self:GetCaster():FindAbilityByName("phantom_assassin_coup_de_grace_custom")
    --    if phantom_assassin_coup_de_grace_custom and phantom_assassin_coup_de_grace_custom:GetLevel() > 0 then
    --        if not self:GetCaster():PassivesDisabled() then
    --            local chance = phantom_assassin_coup_de_grace_custom:GetSpecialValueFor("crit_chance")
--
    --            if self:GetCaster():HasModifier("modifier_phantom_assassin_7") then
    --                local bonus_chance = (self:GetCaster():GetStrength() / phantom_assassin_coup_de_grace_custom.modifier_phantom_assassin_7_str) * phantom_assassin_coup_de_grace_custom.modifier_phantom_assassin_7_perc
    --                chance = chance + bonus_chance
    --            end
--
    --            local critical_damage = phantom_assassin_coup_de_grace_custom:GetSpecialValueFor("crit_bonus")
    --            if RollPseudoRandomPercentage(chance, 20, self:GetCaster()) or self:GetCaster():HasModifier("modifier_phantom_assassin_coup_de_grace_custom_active") then
    --                self:GetCaster():RemoveModifierByName("modifier_phantom_assassin_coup_de_grace_custom_active")
    --                damage = damage / 100 * critical_damage
--
    --                local coup_pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    --                ParticleManager:SetParticleControlEnt(coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    --                ParticleManager:SetParticleControl(coup_pfx, 1, target:GetAbsOrigin())
--
    --                local line = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
    --                ParticleManager:SetParticleControlOrientation(coup_pfx, 1, line*-1, self:GetCaster():GetRightVector(), self:GetCaster():GetUpVector())
    --                ParticleManager:ReleaseParticleIndex(coup_pfx)
--
    --                target:EmitSound("Hero_PhantomAssassin.CoupDeGrace")
--
    --                SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, target, damage, nil)
--
    --                if self:GetCaster():GetModelName() == "models/heroes/phantom_assassin/pa_arcana.vmdl" then 
    --                    target:EmitSound("Hero_PhantomAssassin.Arcana_Layer")
    --                    local coup_pfx = ParticleManager:CreateParticle("particles/econ/items/phantom_assassin/phantom_assassin_arcana_elder_smith/phantom_assassin_crit_arcana_swoop.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    --                    ParticleManager:SetParticleControlEnt(coup_pfx, 0, target, PATTACH_POINT_FOLLOW, "attach_hitloc", target:GetAbsOrigin(), true)
    --                    ParticleManager:SetParticleControl(coup_pfx, 1, target:GetAbsOrigin())
    --                    local line = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Normalized()
    --                    ParticleManager:SetParticleControlOrientation(coup_pfx, 1, line*-1, self:GetCaster():GetRightVector(), self:GetCaster():GetUpVector())
    --                    ParticleManager:ReleaseParticleIndex(coup_pfx)
    --                end
    --                self:GetCaster().block_crit = true
    --            end
    --        end
    --    end
--
    --    if not target:IsMagicImmune() then
    --        ApplyDamage({victim = target, attacker = self:GetCaster(), ability = self, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})
    --        target:AddNewModifier(self:GetCaster(), self, "modifier_phantom_assassin_stifling_dagger_custom_debuff" ,{duration = duration * (1-target:GetStatusResistance())})
    --    end
--
    --    self:GetCaster().block_crit = nil
--
    --    target:EmitSound( "Hero_PhantomAssassin.Dagger.Target" )
    --    self:GetCaster():PerformAttack(target, true, true, true, false, false, true, true)
    --    AddFOWViewer(self:GetCaster():GetTeamNumber(), location, 450, 3.35, false)
    --end
end











































modifier_phantom_assassin_stifling_dagger_custom = class({})

function modifier_phantom_assassin_stifling_dagger_custom:IsHidden() return true end
function modifier_phantom_assassin_stifling_dagger_custom:IsPurgable() return false end
function modifier_phantom_assassin_stifling_dagger_custom:RemoveOnDeath() return false end

function modifier_phantom_assassin_stifling_dagger_custom:OnCreated( kv )
    self.base_damage = self:GetAbility():GetSpecialValueFor( "base_damage" )  
    self.attack_factor = self:GetAbility():GetSpecialValueFor( "attack_factor" )

    if self:GetCaster():HasModifier("modifier_phantom_assassin_9") then
        self.attack_factor = self.attack_factor + self:GetAbility().modifier_phantom_assassin_9[self:GetCaster():GetTalentLevel("modifier_phantom_assassin_9")]
    end
end

function modifier_phantom_assassin_stifling_dagger_custom:DeclareFunctions()
    return   
    {
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_phantom_assassin_stifling_dagger_custom:GetModifierDamageOutgoing_Percentage( params )
    if IsServer() then
        return self.attack_factor
    end
end

function modifier_phantom_assassin_stifling_dagger_custom:GetModifierPreAttack_BonusDamage( params )
    if IsServer() then
        return self.base_damage * 100/(100+self.attack_factor)
    end
end


modifier_phantom_assassin_stifling_dagger_custom_debuff = class({})

function modifier_phantom_assassin_stifling_dagger_custom_debuff:OnCreated( kv )
    self.move_slow = self:GetAbility():GetSpecialValueFor( "move_slow" )
end

function modifier_phantom_assassin_stifling_dagger_custom_debuff:OnRefresh( kv )
    self.move_slow = self:GetAbility():GetSpecialValueFor( "move_slow" )  
end

function modifier_phantom_assassin_stifling_dagger_custom_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
    }
end

function modifier_phantom_assassin_stifling_dagger_custom_debuff:GetModifierMoveSpeedBonus_Percentage()
    if self:GetParent():IsDebuffImmune() then return end
    return self.move_slow
end

function modifier_phantom_assassin_stifling_dagger_custom_debuff:GetEffectName()
    return "particles/units/heroes/hero_phantom_assassin/phantom_assassin_stifling_dagger_debuff.vpcf"
end

function modifier_phantom_assassin_stifling_dagger_custom_debuff:GetEffectAttachType()
    return PATTACH_ABSORIGIN_FOLLOW
end