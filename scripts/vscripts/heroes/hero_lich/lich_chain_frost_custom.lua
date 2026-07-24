--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_chain_frost_custom_slow", "heroes/hero_lich/lich_chain_frost_custom", LUA_MODIFIER_MOTION_NONE)

lich_chain_frost_custom = class({})

function lich_chain_frost_custom:CastFilterResultTarget( hTarget )
    if not IsServer() then return end
    
    if hTarget:IsHero() and hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_FRIENDLY
    end

    if hTarget:IsOther() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_OTHER
    end

    local nResult = UnitFilter(
        hTarget,
        self:GetAbilityTargetTeam(),
        self:GetAbilityTargetType(),
        self:GetAbilityTargetFlags(),
        self:GetCaster():GetTeamNumber()
    )

    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function lich_chain_frost_custom:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local ability = self
    local target = self:GetCursorTarget()
    self:LaunchProjectile(caster, target)
end

function lich_chain_frost_custom:LaunchProjectile(source, target)
    local caster = self:GetCaster()
    local ability = self
    local projectile_base_speed = ability:GetSpecialValueFor("initial_projectile_speed")
    local projectile_vision = ability:GetSpecialValueFor("vision_radius")
    local num_bounces = ability:GetSpecialValueFor("jumps")

    self:GetCaster():EmitSound("Hero_Lich.ChainFrost")

    local chain_frost_projectile = 
    {
        Target = target,
        Source = source,
        Ability = ability,
        EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
        iMoveSpeed = projectile_base_speed,
        bDodgeable = false,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        bProvidesVision = true,
        iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        ExtraData = {bounces_left = num_bounces, current_projectile_speed = projectile_base_speed, main_chain_frost = true, mega_main_frost = true, counter = 0, limit = 1}
    }

    ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)
end

function lich_chain_frost_custom:OnProjectileHit_ExtraData(target, location, extradata)
    local caster = self:GetCaster()
    local ability = self
    local slow_duration = ability:GetSpecialValueFor("slow_duration")
    local bounce_range = ability:GetSpecialValueFor("jump_range")
    local damage = ability:GetSpecialValueFor("damage")
    if not target then return nil end
    extradata.counter = extradata.counter + 1
    target:EmitSound("Hero_Lich.ChainFrostImpact.Hero")

    if extradata.main_chain_frost == 1 then
        Timers:CreateTimer(0.25, function()
            if not self:GetCaster():HasScepter() then
                if extradata.bounces_left <= 0 then
                    return nil
                end
            end

            local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

            local spires = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (target == enemies[i] or enemies[i]:GetName() == "npc_dota_unit_undying_zombie" or enemies[i]:HasModifier("modifier_creep_spawner_cha_ready")) then
                    table.remove(enemies, i)
                end
            end

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (enemies[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
                    table.remove(enemies, i)
                end
            end

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (enemies[i]:IsNull() or not enemies[i]:IsAlive()) then
                    table.remove(enemies, i)
                end
            end

            for _,spire in pairs(spires) do
                if spire:GetUnitName() == "npc_dota_lich_ice_spire" and target ~= spire then
                    table.insert(enemies, spire)
                end
            end

            if #enemies <= 0 then
                return nil
            end

            local projectile_speed = extradata.current_projectile_speed

            if not self:GetCaster():HasScepter() then
                extradata.bounces_left = extradata.bounces_left - 1
            end
            local bounce_target = enemies[1]
            
            local chain_frost_projectile

            chain_frost_projectile = {
                Target = bounce_target,
                Source = target,
                Ability = ability,
                EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
                iMoveSpeed = projectile_speed,
                bDodgeable = false,
                bVisibleToEnemies = true,
                bReplaceExisting = false,
                bProvidesVision = true,
                iVisionRadius = projectile_vision,
                iVisionTeamNumber = caster:GetTeamNumber(),
                ExtraData = {}
            }

            chain_frost_projectile.ExtraData = {bounces_left = extradata.bounces_left, current_projectile_speed = projectile_speed, main_chain_frost = true, mega_main_frost = extradata.mega_main_frost, counter = extradata.counter, limit = extradata.limit}
            ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)
        end)
    end







    if extradata.mega_main_frost == 1 and self:GetCaster():HasTalent("special_bonus_unique_lich_5") then
        if extradata.counter % 10 == 0 and extradata.counter > 0 and extradata.limit < 5 then

            local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE, FIND_ANY_ORDER, false)

            local spires = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false)

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (target == enemies[i] or enemies[i]:GetName() == "npc_dota_unit_undying_zombie" or enemies[i]:HasModifier("modifier_creep_spawner_cha_ready")) then
                    table.remove(enemies, i)
                end
            end

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (enemies[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
                    table.remove(enemies, i)
                end
            end

            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (enemies[i]:IsNull() or not enemies[i]:IsAlive()) then
                    table.remove(enemies, i)
                end
            end

            for _,spire in pairs(spires) do
                if spire:GetUnitName() == "npc_dota_lich_ice_spire" and target ~= spire then
                    table.insert(enemies, spire)
                end
            end

            extradata.limit = extradata.limit + 1

            if #enemies > 0 then
                local projectile_speed = extradata.current_projectile_speed
                local bounces_left = self:GetSpecialValueFor("jumps")
                local bounce_target = enemies[RandomInt(1, #enemies)]
                
                local chain_frost_projectile

                chain_frost_projectile = {
                    Target = bounce_target,
                    Source = target,
                    Ability = ability,
                    EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
                    iMoveSpeed = projectile_speed,
                    bDodgeable = false,
                    bVisibleToEnemies = true,
                    bReplaceExisting = false,
                    bProvidesVision = true,
                    iVisionRadius = projectile_vision,
                    iVisionTeamNumber = caster:GetTeamNumber(),
                    ExtraData = {}
                }

                chain_frost_projectile.ExtraData = {bounces_left = bounces_left, current_projectile_speed = projectile_speed, main_chain_frost = true, mega_main_frost = false, counter = 0, limit = extradata.limit}
                ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)
            end
        end
    end

    if target:GetTeam() ~= caster:GetTeam() then
        if extradata.counter == 0 and target:TriggerSpellAbsorb(ability) then
            return nil
        end
    end

    if target:IsMagicImmune() then
        return nil
    end

    local damageTable = 
    {
        victim = target,
        damage = damage + (self:GetSpecialValueFor("bonus_jump_damage") * extradata.counter),
        damage_type = DAMAGE_TYPE_MAGICAL,
        attacker = caster,
        ability = ability
    }

    if target:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        ApplyDamage(damageTable)
        target:AddNewModifier(caster, ability, "modifier_lich_chain_frost_custom_slow", {duration = slow_duration * (1 - target:GetStatusResistance())})
    end
end

modifier_lich_chain_frost_custom_slow = class({})

function modifier_lich_chain_frost_custom_slow:OnCreated()
    self.caster = self:GetCaster()
    self.ability = self:GetAbility()
    self.ms_slow_pct = self.ability:GetSpecialValueFor("slow_movement_speed")
    self.as_slow = self.ability:GetSpecialValueFor("slow_attack_speed")
end

function modifier_lich_chain_frost_custom_slow:IsHidden() return false end
function modifier_lich_chain_frost_custom_slow:IsPurgable() return true end
function modifier_lich_chain_frost_custom_slow:IsDebuff() return true end

function modifier_lich_chain_frost_custom_slow:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_lich_chain_frost_custom_slow:GetModifierMoveSpeedBonus_Percentage()
    return self.ms_slow_pct
end

function modifier_lich_chain_frost_custom_slow:GetModifierAttackSpeedBonus_Constant()
    return self.as_slow
end

function modifier_lich_chain_frost_custom_slow:GetStatusEffectName()
    return "particles/status_fx/status_effect_frost_lich.vpcf"
end