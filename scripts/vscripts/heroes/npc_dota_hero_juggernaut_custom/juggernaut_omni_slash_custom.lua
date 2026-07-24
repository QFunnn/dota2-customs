--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_juggernaut_omni_slash_custom", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_omni_slash_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_juggernaut_omni_slash_custom_effect", "heroes/npc_dota_hero_juggernaut_custom/juggernaut_omni_slash_custom", LUA_MODIFIER_MOTION_NONE)

juggernaut_omni_slash_custom = class({})

function juggernaut_omni_slash_custom:Precache(context)
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf", context )
    PrecacheResource( "particle", "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt_scepter.vpcf", context )
    PrecacheResource( "particle", "particles/juggernaut_trail_swift.vpcf", context )
end

juggernaut_omni_slash_custom.modifier_juggernaut_10 = {-15,-25,-35}
juggernaut_omni_slash_custom.modifier_juggernaut_11 = {0.25,0.5}

function juggernaut_omni_slash_custom:GetCooldown(level)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_juggernaut_10") then
        bonus = self.modifier_juggernaut_10[self:GetCaster():GetTalentLevel("modifier_juggernaut_10")]
    end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function juggernaut_omni_slash_custom:OnSpellStart()
    if not IsServer() then return end
    self.duration = self:GetSpecialValueFor("duration")
    if self:GetCaster():HasModifier("modifier_juggernaut_11") then
        self.duration = self.duration + self.modifier_juggernaut_11[self:GetCaster():GetTalentLevel("modifier_juggernaut_11")]
    end
    self.target = self:GetCursorTarget():GetAbsOrigin()
    self:GetCaster():Purge(false, true, false, false, false)
    self:Omnislash(self:GetCaster(), self.target, self.duration, false)
end

function juggernaut_omni_slash_custom:Omnislash( caster , target , duration)
    if not IsServer() then return end
    self.caster = caster

    if caster:HasModifier("modifier_juggernaut_omni_slash_custom") then 
        caster:RemoveModifierByName("modifier_juggernaut_omni_slash_custom")
    end

    self.caster:EmitSound("Hero_Juggernaut.OmniSlash")

    local position = self.caster:GetAbsOrigin()

    FindClearSpaceForUnit(self.caster, target, false)

    local radius = 10

    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), target, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
    local first_target = targets[1] 

    if first_target ~= nil and not first_target:IsUntargetableFrom(self.caster) then 
        self.caster:AddNewModifier(self.caster, self, "modifier_juggernaut_omni_slash_custom", {duration = duration, first_target = first_target:entindex(), scepter = false})
    end   

    if self.caster:IsRealHero() then 
        PlayerResource:SetCameraTarget(self.caster:GetPlayerOwnerID(), self.caster)
        PlayerResource:SetCameraTarget(self.caster:GetPlayerOwnerID(), nil)
    end

    local position2 = self.caster:GetAbsOrigin()
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:SetParticleControl(particle, 1, position2)
    ParticleManager:ReleaseParticleIndex(particle)
end

modifier_juggernaut_omni_slash_custom = class({})
function modifier_juggernaut_omni_slash_custom:IsPurgable() return false end

function modifier_juggernaut_omni_slash_custom:OnCreated(table)
    local omni = self:GetAbility()
    self.ability = self:GetParent():FindAbilityByName("juggernaut_omni_slash_custom")
    if table.scepter == 1 then 
        self.ability = self:GetParent():FindAbilityByName("juggernaut_swift_slash_custom")
        omni = self:GetParent():FindAbilityByName("juggernaut_omni_slash_custom")
    end
    self.scepter = table.scepter
    self.damage = omni:GetSpecialValueFor("bonus_damage")
    self.speed = omni:GetSpecialValueFor("bonus_attack_speed")
    self.radius = omni:GetSpecialValueFor("omni_slash_radius")
    self.ishitting = false
    self.lastenemy = nil
    if not IsServer() then return end 
    self.arcana = false
    if self:GetParent() ~= nil and self:GetParent():IsHero() then
        local children = self:GetParent():GetChildren()
        for k,child in pairs(children) do
            if child:GetClassname() == "dota_item_wearable" then
                if child:GetModelName() == "models/items/juggernaut/arcana/juggernaut_arcana_mask.vmdl" then
                    self.arcana = true 
                    break
                end
            end
        end
    end 

    self.first_target = EntIndexToHScript(table.first_target)
    self.turn = self:GetCaster():GetForwardVector()
    self.omni = self:GetParent():FindAbilityByName("juggernaut_omni_slash_custom")
    self.fury = self:GetParent():FindAbilityByName("juggernaut_blade_fury_custom")
    if not self:GetCaster():HasModifier("modifier_juggernaut_20") then
        if self.fury then  self.fury:SetActivated(false) end 
    end
    self.crit = self:GetParent():FindAbilityByName("custom_juggernaut_blade_dance")
    self:SetHasCustomTransmitterData(true)
    self.bonusrate = omni:GetSpecialValueFor("attack_rate_multiplier")

    Timers:CreateTimer(FrameTime(),function()
        self:slash(true)
        self.rate = (1/self:GetParent():GetAttacksPerSecond(true))/self.bonusrate
        self:StartIntervalThink(self.rate)    
    end)
end

function modifier_juggernaut_omni_slash_custom:AddCustomTransmitterData() 
    return 
    {
        damage = self.damage,
        speed = self.speed
    }
end

function modifier_juggernaut_omni_slash_custom:HandleCustomTransmitterData(data)
    self.damage = data.damage
    self.speed = data.speed
end

function modifier_juggernaut_omni_slash_custom:StatusEffectPriority()
    return 20
end

function modifier_juggernaut_omni_slash_custom:GetStatusEffectName()
    return "particles/status_fx/status_effect_omnislash.vpcf"
end

function modifier_juggernaut_omni_slash_custom:OnIntervalThink()
    if not IsServer() then return end
    self.rate = (1/self:GetParent():GetAttacksPerSecond(true))/(self.bonusrate)
    self:slash()
    self:StartIntervalThink(self.rate-FrameTime())
end

function modifier_juggernaut_omni_slash_custom:TargetNear( target , near )
    if not IsServer() then return end
    for _,i in ipairs(near) do 
        if i == target then return true end
    end
    return false
end

function modifier_juggernaut_omni_slash_custom:slash( first )
    if not IsServer() then return end
    local order = FIND_ANY_ORDER

    if first then
        order = FIND_CLOSEST
        number = 1 
    else 
        number = number + 1 
    end

    print("lalala")

    self.ishitting = false

    local target = FindUnitsInRadius(self:GetParent():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self.radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, order, false)
    
    if #target >= 1 then 
        for _,enemy in ipairs(target) do
            local can_hit = true
            if enemy:GetUnitName() == "npc_dota_techies_remote_mine" or enemy:GetUnitName() == "npc_teleport" or enemy:IsCourier() then can_hit = false end
            if enemy:HasModifier("modifier_morphling_waveform_custom") then can_hit = false end
            if can_hit == true and not enemy:IsUntargetableFrom(self:GetCaster()) then
                self.ishitting = true
                self:GetParent():RemoveGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
                self:GetParent():StartGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
                local position1 = self:GetParent():GetAbsOrigin()
                if number%2 ~= 0 then       
                    local position = (enemy:GetAbsOrigin() - (self.turn)*70)
                    FindClearSpaceForUnit(self:GetParent(), position, false)
                else 
                    local position = (enemy:GetAbsOrigin() + (self.turn)*70)
                    FindClearSpaceForUnit(self:GetParent(), position, false)   
                end

                if number ~= 1 then  
                    local angel = (enemy:GetAbsOrigin() - self:GetParent():GetAbsOrigin())
                    angel.z = 0.0
                    angel = angel:Normalized()
                    self:GetParent():SetForwardVector(angel)
                    self:GetParent():FaceTowards(enemy:GetAbsOrigin())
                end

                local position2 = self:GetParent():GetAbsOrigin()


                local linken = false 
                if first and self:GetParent():IsRealHero() and self:GetCaster():GetName() == "npc_dota_hero_juggernaut" and not self:GetParent():HasModifier("modifier_juggernaut_omnislash_legendary")  then 
                    if enemy:TriggerSpellAbsorb(self.ability) then 
                        linken = true
                    end
                end

                if linken == false then
                    self:GetParent():PerformAttack(enemy, true, true, true, false, false, false, false)
                    self.root_target = enemy
                    enemy:EmitSound("Hero_Juggernaut.OmniSlash")
                end

                local effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt.vpcf"
                if self.scepter == 1 then effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_tgt_scepter.vpcf" end

                if self.arcana == true and self.scepter == 0 then 
                    local particle = ParticleManager:CreateParticle( effect, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
                    ParticleManager:SetParticleControlEnt( particle, 0, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true )
                    ParticleManager:SetParticleControlEnt( particle, 1, enemy, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc", enemy:GetAbsOrigin(), true )
                else 
                    local particle = ParticleManager:CreateParticle( effect, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster() )
                    ParticleManager:SetParticleControlEnt( particle, 0, self:GetCaster(), PATTACH_POINT_FOLLOW, "attach_sword", self:GetCaster():GetAbsOrigin(), true )
                    ParticleManager:SetParticleControl( particle, 1, position2 )
                    if self.scepter == 1 then
                        ParticleManager:SetParticleControl( particle, 60, Vector(238,0,255) )
                        ParticleManager:SetParticleControl( particle, 61, Vector(1,1,1) ) 
                    end
                end

                effect = "particles/units/heroes/hero_juggernaut/juggernaut_omni_slash_trail.vpcf"
                if self.scepter == 1 then effect = "particles/juggernaut_trail_swift.vpcf" end
                local trail_pfx = ParticleManager:CreateParticle(effect, PATTACH_ABSORIGIN, self:GetParent())
                ParticleManager:SetParticleControl(trail_pfx, 0, position1)
                ParticleManager:SetParticleControl(trail_pfx, 1, position2)
                ParticleManager:ReleaseParticleIndex(trail_pfx)
                self.lastenemy = enemy
                return
            end
        end
    end

    Timers:CreateTimer(0.15,function()
        if self then 
            if self ~= nil and not self:IsNull() and self.ishitting == false and self:GetParent() ~= nil then
                if not self:GetParent():IsRealHero() then 
                    self:GetParent():ForceKill(false)
                end  
                self:Destroy() 
            end
        end
    end)
end

function modifier_juggernaut_omni_slash_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_IGNORE_CAST_ANGLE,
         
    }
end

function modifier_juggernaut_omni_slash_custom:GetModifierAttackSpeedBonus_Constant()
    return self.speed
end

function modifier_juggernaut_omni_slash_custom:GetModifierPreAttack_BonusDamage() return self.damage end

function modifier_juggernaut_omni_slash_custom:OnDestroy()
    if not IsServer() then return end
    self:GetParent():FadeGesture(ACT_DOTA_OVERRIDE_ABILITY_4)
    self:GetParent():MoveToPositionAggressive(self:GetParent():GetAbsOrigin())
    self.fury = self:GetParent():FindAbilityByName("juggernaut_blade_fury_custom")
    if self.fury then self.fury:SetActivated(true) end 
end

function modifier_juggernaut_omni_slash_custom:CheckState()
    local state = 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
    return state
end

function modifier_juggernaut_omni_slash_custom:GetModifierIgnoreCastAngle()
    return 1
end

juggernaut_swift_slash_custom = class({})

function juggernaut_swift_slash_custom:OnSpellStart(target)
    if not IsServer() then return end
    self.target = self:GetCursorTarget()
    self:GetCaster():Purge(false, true, false, false, false)
    self.duration = self:GetSpecialValueFor("duration")
    self:Omnislash(self:GetCaster(), self.target:GetAbsOrigin(), self.duration)
end

function juggernaut_swift_slash_custom:Omnislash(caster, target, duration)
    if not IsServer() then return end
    self.caster = caster
    if caster:HasModifier("modifier_juggernaut_omni_slash_custom") then 
        caster:RemoveModifierByName("modifier_juggernaut_omni_slash_custom")
    end
    self.caster:EmitSound("Hero_Juggernaut.OmniSlash")
    local position = self.caster:GetAbsOrigin()
    FindClearSpaceForUnit(self.caster, target, false)
    local radius = 10
    local targets = FindUnitsInRadius(self.caster:GetTeamNumber(), target, nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_CLOSEST, false)
    local first_target = targets[1] 

    if first_target ~= nil then 
        self.caster:AddNewModifier(self.caster, self, "modifier_juggernaut_omni_slash_custom", {duration = duration, first_target = first_target:entindex(), scepter = true})
    end   

    if self.caster:IsRealHero() then 
        PlayerResource:SetCameraTarget(self.caster:GetPlayerOwnerID(), self.caster)
        PlayerResource:SetCameraTarget(self.caster:GetPlayerOwnerID(), nil)
    end

    local position2 = self.caster:GetAbsOrigin()
    local particle = ParticleManager:CreateParticle("particles/juggernaut_trail_swift.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:SetParticleControl(particle, 1, position2)
    ParticleManager:ReleaseParticleIndex(particle)
end