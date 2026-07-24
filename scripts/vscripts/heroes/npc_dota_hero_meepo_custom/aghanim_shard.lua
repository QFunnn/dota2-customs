--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_aghanim_shard_thinker", "heroes/npc_dota_hero_meepo_custom/aghanim_shard", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_shard_debuff", "heroes/npc_dota_hero_meepo_custom/aghanim_shard", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier("modifier_aghanim_shard_debuff_break", "heroes/npc_dota_hero_meepo_custom/aghanim_shard", LUA_MODIFIER_MOTION_NONE )

aghanim_shard = class({})
aghanim_shard.modifier_meepo_5 = {0.5,1,1.5}
aghanim_shard.modifier_meepo_3_manacost = 50
aghanim_shard.modifier_meepo_5_damage_health = {2,4,6}

function aghanim_shard:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts", context )
end

function aghanim_shard:GetManaCost(iLevel)
    local cost = 1
    if self:GetCaster():HasModifier("modifier_meepo_3") then
        cost = cost - (self.modifier_meepo_3_manacost / 100)
    end
    return self.BaseClass.GetManaCost(self, iLevel) * cost
end

function aghanim_shard:GetAbilityTextureName()
    if self:GetCaster():HasModifier("modifier_meepo_3") then
        return "aghanim_3"
    end
    return "shard_blast"
end

function aghanim_shard:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    local distance = self:GetSpecialValueFor("max_distance") + self:GetCaster():GetCastRangeBonus()
    local spawnPos = self:GetCaster():GetOrigin()

    local direction = point-self:GetCaster():GetAbsOrigin()
    direction.z = 0
    direction = direction:Normalized()

    local effect = "particles/shard/aghanim_crystal_attack.vpcf"
    if self:GetCaster():HasModifier("modifier_meepo_3") then
        effect = "particles/shard/aghanim_crystal_attack_red.vpcf"
    end

    self:GetCaster():EmitSound("Hero_Winter_Wyvern.SplinterBlast.Cast")

    local point_start = self:GetCaster():GetAttachmentOrigin(self:GetCaster():ScriptLookupAttachment("attach_staff_fx"))

    local info = 
    {
        Source = self:GetCaster(),
        Ability = self,
        vSpawnOrigin = self:GetCaster():GetAbsOrigin(),
        bDeleteOnHit = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetFlags = DOTA_UNIT_TARGET_FLAG_NONE,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        EffectName = effect,
        fDistance = distance,
        fStartRadius = 105,
        fEndRadius = 105,
        vVelocity = direction * self:GetSpecialValueFor("orb_speed"),
        iSourceAttachment   = DOTA_PROJECTILE_ATTACHMENT_ATTACK_1,
        bHasFrontalCone = false,
        bReplaceExisting = false,
        bProvidesVision = false,
        ExtraData = {main = 1}
    }

    ProjectileManager:CreateLinearProjectile(info)
end

function aghanim_shard:ApplyEffect(target)
    if not IsServer() then return end
    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_meepo_5") then
        damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self.modifier_meepo_5_damage_health[self:GetCaster():GetTalentLevel("modifier_meepo_5")])
    end
    target:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Target")
    target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_shard_debuff", {duration = self:GetSpecialValueFor("debuff_duration") * (1-target:GetStatusResistance())})
    local damage_type = DAMAGE_TYPE_MAGICAL
    if self:GetCaster():HasModifier("modifier_meepo_3") then
        damage_type = DAMAGE_TYPE_PHYSICAL
    end
    if self:GetCaster():HasModifier("modifier_meepo_5") then
        target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_shard_debuff_break", {duration = self.modifier_meepo_5[self:GetCaster():GetTalentLevel("modifier_meepo_5")] * (1-target:GetStatusResistance())})
    end
    ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = damage_type})
end

function aghanim_shard:OnProjectileHit_ExtraData(target, vLocation, table)

    if target ~= nil then
        if table.main == 1 then
            local point = GetGroundPosition(vLocation, nil)

            local effect = "particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf"

            if self:GetCaster():HasModifier("modifier_meepo_3") then
                effect = "particles/creatures/aghanim/aghanim_crystal_attack_impact_red.vpcf"
            end

            local particle = ParticleManager:CreateParticle(effect, PATTACH_WORLDORIGIN, nil)

            
            ParticleManager:SetParticleControl(particle, 0, point)

            local dummy = CreateUnitByName( "npc_dota_companion", target:GetAbsOrigin(), false, nil, nil, self:GetCaster():GetTeamNumber() )
            dummy:SetAbsOrigin(target:GetAbsOrigin())
            dummy:AddNewModifier(dummy, self, "modifier_aghanim_shard_thinker", {duration = 3})
            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), target:GetAbsOrigin(), nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

            EmitSoundOnLocationWithCaster(point, "Hero_Winter_Wyvern.SplinterBlast.Splinter", self:GetCaster())

            for _,enemy in pairs( enemies ) do
                local info = 
                {
                    Target = enemy,
                    Source = dummy,
                    Ability = self, 
                    EffectName = "particles/creatures/aghanim/aghanim_crystal_attack.vpcf",
                    iMoveSpeed = 800,
                    bReplaceExisting = false,
                    bProvidesVision = true,
                    iVisionRadius = 25,
                    iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
                    ExtraData = {main = 0}
                }
                ProjectileManager:CreateTrackingProjectile(info)
            end
        end

        if table.main == 0 then
            local damage = self:GetSpecialValueFor("damage")
            if self:GetCaster():HasModifier("modifier_meepo_5") then
                damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self.modifier_meepo_5_damage_health[self:GetCaster():GetTalentLevel("modifier_meepo_5")])
            end
            target:EmitSound("Hero_Winter_Wyvern.SplinterBlast.Target")
            target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_shard_debuff", {duration = self:GetSpecialValueFor("debuff_duration") * (1-target:GetStatusResistance())})
            local damage_type = DAMAGE_TYPE_MAGICAL
            if self:GetCaster():HasModifier("modifier_meepo_3") then
                damage_type = DAMAGE_TYPE_PHYSICAL
            end
            if self:GetCaster():HasModifier("modifier_meepo_5") then
                target:AddNewModifier(self:GetCaster(), self, "modifier_aghanim_shard_debuff_break", {duration = self.modifier_meepo_5[self:GetCaster():GetTalentLevel("modifier_meepo_5")] * (1-target:GetStatusResistance())})
            end
            ApplyDamage({attacker = self:GetCaster(), victim = target, ability = self, damage = damage, damage_type = damage_type})
        end
        return true
    end

    if target == nil then
        if table.main == 1 then
            local point = GetGroundPosition(vLocation, nil)
            local particle = ParticleManager:CreateParticle("particles/creatures/aghanim/aghanim_crystal_attack_impact.vpcf", PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(particle, 0, point)

            local dummy = CreateUnitByName( "npc_dota_companion", point, false, nil, nil, self:GetCaster():GetTeamNumber() )
            dummy:SetAbsOrigin(point)
            dummy:AddNewModifier(dummy, self, "modifier_aghanim_shard_thinker", {duration = 3})
            local enemies = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), point, nil, self:GetSpecialValueFor("radius"), DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, 0, false )

            EmitSoundOnLocationWithCaster(point, "Hero_Winter_Wyvern.SplinterBlast.Splinter", self:GetCaster())

            for _,enemy in pairs( enemies ) do
                
                local info = 
                {
                    Target = enemy,
                    Source = dummy,
                    Ability = self, 
                    EffectName = "particles/creatures/aghanim/aghanim_crystal_attack.vpcf",
                    iMoveSpeed = 800,
                    bReplaceExisting = false,
                    bProvidesVision = true,
                    iVisionRadius = 25,
                    iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
                    ExtraData = {main = 0}
                }
                EmitSoundOnLocationWithCaster(point, "Hero_Winter_Wyvern.SplinterBlast.Splinter", self:GetCaster())

                ProjectileManager:CreateTrackingProjectile(info)
            end
        end
    end
end

modifier_aghanim_shard_debuff = class({})

function modifier_aghanim_shard_debuff:OnCreated()
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/aghs_crystal_debuff.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    self:AddParticle(self.particle, false, false, -1, false, true)
end

function modifier_aghanim_shard_debuff:DeclareFunctions()
    return 
    {
        MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE
    }
end
function modifier_aghanim_shard_debuff:GetModifierTotalDamageOutgoing_Percentage()
    return self:GetAbility():GetSpecialValueFor("damage_outgoing")
end

modifier_aghanim_shard_thinker = class({})

function modifier_aghanim_shard_thinker:IsHidden() return true end
function modifier_aghanim_shard_thinker:IsPurgable() return false end
function modifier_aghanim_shard_thinker:RemoveOnDeath() return false end

function modifier_aghanim_shard_thinker:CheckState()
    return 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_NOT_ON_MINIMAP] = true,
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_aghanim_shard_thinker:OnDestroy()
    if not IsServer() then return end
    UTIL_Remove(self:GetParent())
end

modifier_aghanim_shard_debuff_break = class({})
function modifier_aghanim_shard_debuff_break:GetTexture() return "aghanim_5" end
function modifier_aghanim_shard_debuff_break:IsHidden() return false end
function modifier_aghanim_shard_debuff_break:IsPurgable() return false end
function modifier_aghanim_shard_debuff_break:CheckState() return {[MODIFIER_STATE_PASSIVES_DISABLED] = true} end
function modifier_aghanim_shard_debuff_break:GetEffectName() return "particles/items3_fx/silver_edge.vpcf" end
function modifier_aghanim_shard_debuff_break:OnCreated(table)
    if not IsServer() then return end
    self.particle = ParticleManager:CreateParticle("particles/generic_gameplay/generic_break.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(self.particle, 1, self:GetParent():GetAbsOrigin())
    self:AddParticle(self.particle, false, false, -1, false, false)
end

aghanim_shard_charge = aghanim_shard