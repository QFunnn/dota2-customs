--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_lich_chain_frost_custom_slow", "heroes/npc_dota_hero_lich_custom/lich_chain_frost_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lich_chain_frost_custom_frostbound", "heroes/npc_dota_hero_lich_custom/lich_chain_frost_custom", LUA_MODIFIER_MOTION_NONE)

lich_chain_frost_custom = class({})

lich_chain_frost_custom.modifier_lich_7 = -35
lich_chain_frost_custom.modifier_lich_7_count = 7
lich_chain_frost_custom.modifier_lich_5 = {2,4,6}
lich_chain_frost_custom.modifier_lich_5_duration = {0.5,1,1.5}

function lich_chain_frost_custom:GetCooldown(level)
    local bonus = 0
	if self:GetCaster():HasModifier("modifier_lich_7") then
		bonus = self.modifier_lich_7
	end
    return self.BaseClass.GetCooldown( self, level ) + bonus
end

function lich_chain_frost_custom:Precache( context )
    if self:GetCaster() and self:GetCaster():IsIllusion() then return end
    PrecacheResource("particle", "particles/new_year/anniversary_10th_hat_ambient_npc_dota_hero_lich.vpcf", context)
    PrecacheResource("particle", "particles/new_year_2/anniversary_10th_hat_ambient_npc_dota_hero_lich.vpcf", context)
    PrecacheResource("particle", "particles/econ/events/anniversary_10th/anniversary_10th_hat_ambient_npc_dota_hero_lich.vpcf", context)
end

function lich_chain_frost_custom:CastFilterResultTarget( hTarget )

    if hTarget:IsHero() and hTarget:GetTeamNumber() == self:GetCaster():GetTeamNumber() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_FRIENDLY
    end
    
    if hTarget:IsBuilding() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_BUILDING 
    end

    if hTarget:IsOther() and hTarget:GetUnitName() ~= "npc_dota_lich_ice_spire" then
        return UF_FAIL_OTHER
    end

    if hTarget and hTarget:GetUnitName() == "npc_dota_techies_remote_mine" then
        return UF_FAIL_OTHER
    end

    if not IsServer() then return UF_SUCCESS end

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
    if not IsServer() then return end
    local caster = self:GetCaster()
    
    local projectile_base_speed = self:GetSpecialValueFor("initial_projectile_speed")

    local projectile_vision = self:GetSpecialValueFor("vision_radius")

    local num_bounces = self:GetSpecialValueFor("jumps")
    if self:GetCaster():HasModifier("modifier_lich_7") then
        num_bounces = num_bounces + self.modifier_lich_7_count
    end

    self:GetCaster():EmitSound("Hero_Lich.ChainFrost")

    local damage = self:GetSpecialValueFor("damage")
    if self:GetCaster():HasModifier("modifier_lich_5") then
        damage = damage + (self:GetCaster():GetMaxHealth() / 100 * self.modifier_lich_5[self:GetCaster():GetTalentLevel("modifier_lich_5")])
    end

    local chain_frost_projectile = 
    {
        Target = target,
        Source = source,
        Ability = self,
        EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
        iMoveSpeed = projectile_base_speed,
        bDodgeable = false,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        bProvidesVision = true,
        iVisionRadius = projectile_vision,
        iVisionTeamNumber = caster:GetTeamNumber(),
        ExtraData = {bounces_left = num_bounces, current_projectile_speed = projectile_base_speed, damage = damage, start = 1}
    }

    ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)
end

function lich_chain_frost_custom:OnProjectileHit_ExtraData(target, location, extradata)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local slow_duration = self:GetSpecialValueFor("slow_duration")
    local bounce_range = self:GetSpecialValueFor("jump_range")
    local bonus_jump_damage = self:GetSpecialValueFor("bonus_jump_damage")
    local projectile_speed = self:GetSpecialValueFor("projectile_speed")
    if not target then return nil end
    target:EmitSound("Hero_Lich.ChainFrostImpact.Hero")

    if extradata.bounces_left > 0 then
        Timers:CreateTimer(0.20, function()
            local enemies = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
            local spires = FindUnitsInRadius(caster:GetTeamNumber(), target:GetAbsOrigin(), nil, bounce_range, DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (target == enemies[i] or enemies[i]:GetName() == "npc_dota_unit_undying_zombie" or enemies[i]:GetUnitName() == "npc_dota_techies_remote_mine") then
                    table.remove(enemies, i)
                end
            end
            for i = #enemies, 1, -1 do
                if enemies[i] ~= nil and (enemies[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
                    table.remove(enemies, i)
                end
            end
            for _,spire in pairs(spires) do
                if spire:GetUnitName() == "npc_dota_lich_ice_spire" and target ~= spire then
                    table.insert(enemies, spire)
                end
            end
            if self:GetCaster():HasModifier("modifier_lich_7") then
                if target ~= self:GetCaster() then
                    if self:GetCaster():IsAlive() then
                        local distance_caster = (target:GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
                        if (distance_caster <= bounce_range) then
                            table.insert(enemies, self:GetCaster())
                        end
                    end
                end
            end
            if #enemies <= 0 then
                local bonus_duration = 0
                if self:GetCaster():HasModifier("modifier_lich_5") then
                    bonus_duration = self.modifier_lich_5_duration[self:GetCaster():GetTalentLevel("modifier_lich_5")]
                end
                local modifier_lich_chain_frost_custom_frostbound = target:AddNewModifier(caster, self, "modifier_lich_chain_frost_custom_frostbound", {duration = self:GetSpecialValueFor("frostbound_duration") + bonus_duration})
                if modifier_lich_chain_frost_custom_frostbound then
                    modifier_lich_chain_frost_custom_frostbound.extradata = extradata
                    modifier_lich_chain_frost_custom_frostbound:StartSearch()
                end
                return nil
            end
            local bounce_target = enemies[1]

            ------------------------------------------------------
            extradata.bounces_left = extradata.bounces_left - 1
            extradata.current_projectile_speed = projectile_speed
            extradata.damage = extradata.damage + bonus_jump_damage
            ---------------------------------------------------------

            local chain_frost_projectile = 
            {
                Target = bounce_target,
                Source = target,
                Ability = self,
                EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
                iMoveSpeed = extradata.current_projectile_speed,
                bDodgeable = false,
                bVisibleToEnemies = true,
                bReplaceExisting = false,
                bProvidesVision = true,
                iVisionRadius = projectile_vision,
                iVisionTeamNumber = caster:GetTeamNumber(),
                ExtraData = {bounces_left = extradata.bounces_left, current_projectile_speed = extradata.current_projectile_speed, damage = extradata.damage}
            }

            ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)
        end)
    end

    if extradata and extradata.start == 1 then
        if target:TriggerSpellAbsorb(self) then
            return nil
        end
    end

    local damageTable = 
    {
        victim = target,
        damage = extradata.damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        attacker = self:GetCaster(),
        ability = self
    }

    if target:GetTeamNumber() ~= self:GetCaster():GetTeamNumber() then
        ApplyDamage(damageTable)
        target:AddNewModifier(self:GetCaster(), self, "modifier_lich_chain_frost_custom_slow", {duration = slow_duration * (1 - target:GetStatusResistance())})
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

modifier_lich_chain_frost_custom_frostbound = class({})
function modifier_lich_chain_frost_custom_frostbound:IsPurgable() return false end
function modifier_lich_chain_frost_custom_frostbound:IsPurgeException() return false end

function modifier_lich_chain_frost_custom_frostbound:OnCreated()
    if not IsServer() then return end
    local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_lich/lich_chain_frost_frostbound.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
    self:AddParticle(particle, false, false, -1, false, true)
end

function modifier_lich_chain_frost_custom_frostbound:StartSearch()
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_lich_chain_frost_custom_frostbound:OnDestroy()
    if not IsServer() then return end
    print("delte")
end

function modifier_lich_chain_frost_custom_frostbound:OnIntervalThink()
    if not IsServer() then return end
    local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("jump_range"), DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
    local spires = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, self:GetAbility():GetSpecialValueFor("jump_range"), DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD + DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE, FIND_ANY_ORDER, false)
    
    for i = #enemies, 1, -1 do
        if enemies[i] ~= nil and (self:GetParent() == enemies[i] or enemies[i]:GetName() == "npc_dota_unit_undying_zombie" or enemies[i]:GetUnitName() == "npc_dota_techies_remote_mine") then
            table.remove(enemies, i)
        end
    end

    for i = #enemies, 1, -1 do
        if enemies[i] ~= nil and (enemies[i]:GetTeamNumber() == self:GetCaster():GetTeamNumber()) then
            table.remove(enemies, i)
        end
    end

    for _,spire in pairs(spires) do
        if spire:GetUnitName() == "npc_dota_lich_ice_spire" and self:GetParent() ~= spire then
            table.insert(enemies, spire)
        end
    end

    if self:GetCaster():HasModifier("modifier_lich_7") then
        if self:GetParent() ~= self:GetCaster() then
            if self:GetCaster():IsAlive() then
                local distance_caster = (self:GetParent():GetAbsOrigin() - self:GetCaster():GetAbsOrigin()):Length2D()
                if (distance_caster <= self:GetAbility():GetSpecialValueFor("jump_range")) then
                    table.insert(enemies, self:GetCaster())
                end
            end
        end
    end

    if #enemies <= 0 then
        return
    end

    local bounce_target = enemies[1]

    local chain_frost_projectile = 
    {
        Target = bounce_target,
        Source = self:GetParent(),
        Ability = self:GetAbility(),
        EffectName = "particles/units/heroes/hero_lich/lich_chain_frost.vpcf",
        iMoveSpeed = self.extradata.current_projectile_speed,
        bDodgeable = false,
        bVisibleToEnemies = true,
        bReplaceExisting = false,
        bProvidesVision = true,
        iVisionRadius = self:GetAbility():GetSpecialValueFor("vision_radius"),
        iVisionTeamNumber = self:GetCaster():GetTeamNumber(),
        ExtraData = self.extradata
    }

    ProjectileManager:CreateTrackingProjectile(chain_frost_projectile)

    self:Destroy()
end






