--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_techies_mutually_assured_destruction_custom", "heroes/npc_dota_hero_techies_custom/techies_mutually_assured_destruction_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_remote_mines_custom", "heroes/npc_dota_hero_techies_custom/techies_mutually_assured_destruction_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_remote_mines_custom_invul", "heroes/npc_dota_hero_techies_custom/techies_mutually_assured_destruction_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_techies_remote_mines_custom_plant", "heroes/npc_dota_hero_techies_custom/techies_mutually_assured_destruction_custom", LUA_MODIFIER_MOTION_NONE)

techies_mutually_assured_destruction_custom = class({})
techies_mutually_assured_destruction_custom.modifier_techies_9 = 50
techies_mutually_assured_destruction_custom.modifier_techies_10 = {-10,-20}
techies_mutually_assured_destruction_custom.modifier_techies_10_cast_point = {30,60}
techies_mutually_assured_destruction_custom.modifier_techies_11 = {-0.4,-0.8,-1.2}
techies_mutually_assured_destruction_custom.modifier_techies_14 = 10
techies_mutually_assured_destruction_custom.modifier_techies_14_speed = 550

function techies_mutually_assured_destruction_custom:GetCooldown(iLevel)
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_techies_10") then
        bonus = self.modifier_techies_10[self:GetCaster():GetTalentLevel("modifier_techies_10")]
    end
    if self:GetCaster():HasModifier("modifier_techies_9") then
        return 30 + bonus
    end
end

function techies_mutually_assured_destruction_custom:GetCastPoint()
    local mult = 1
    if self:GetCaster():HasModifier("modifier_techies_10") then
        mult = mult - (self.modifier_techies_10_cast_point[self:GetCaster():GetTalentLevel("modifier_techies_10")] / 100)
    end
    return self.BaseClass.GetCastPoint(self) * mult
end


function techies_mutually_assured_destruction_custom:GetCastRange(vLocation, hTarget)
    if self:GetCaster():HasModifier("modifier_techies_9") then
        return 450
    end
end

function techies_mutually_assured_destruction_custom:GetIntrinsicModifierName()
    return "modifier_techies_mutually_assured_destruction_custom"
end

function techies_mutually_assured_destruction_custom:GetBehavior()
    local behavior = DOTA_ABILITY_BEHAVIOR_PASSIVE + DOTA_ABILITY_BEHAVIOR_HIDDEN + 562949953421312 + 1125899906842624
    if self:GetCaster():HasModifier("modifier_techies_9") then
        behavior = DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE + DOTA_ABILITY_BEHAVIOR_HIDDEN + 562949953421312 + 1125899906842624
    end
    return behavior
end

function techies_mutually_assured_destruction_custom:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function techies_mutually_assured_destruction_custom:OnSpellStart()
    if not IsServer() then return end
    local point = self:GetCursorPosition()
    self:CreateMine(point)
end

function techies_mutually_assured_destruction_custom:CreateMine(point, death)
    if not IsServer() then return end
    self:GetCaster():EmitSound("Hero_Techies.StickyBomb.Plant")
    local mine = CreateUnitByName("npc_dota_techies_innate_mine", point, true, self:GetCaster(), self:GetCaster(), self:GetCaster():GetTeamNumber())
    mine:SetOriginalModel("models/heroes/techies/fx_techies_remotebomb.vmdl")
    mine:SetModel("models/heroes/techies/fx_techies_remotebomb.vmdl")
    local duration = -1
    if death then
        duration = self:GetSpecialValueFor("explosion_delay")
        if self:GetCaster():HasModifier("modifier_techies_11") then
            duration = duration + self.modifier_techies_11[self:GetCaster():GetTalentLevel("modifier_techies_11")]
        end
    end
    local modifier_techies_remote_mines_custom = mine:AddNewModifier(self:GetCaster(), self, "modifier_techies_remote_mines_custom", {duration = duration})
    if death then
        if modifier_techies_remote_mines_custom then
            modifier_techies_remote_mines_custom:ActivatePlant(true)
        end
    else
        mine:AddNewModifier(self:GetCaster(), self, "modifier_techies_remote_mines_custom_plant", {})
        self.mine = mine
    end
    local max_health = mine:GetMaxHealth()
    if self:GetCaster():HasModifier("modifier_techies_9") then
        max_health = max_health + (self:GetCaster():GetMaxMana() / 100 * self.modifier_techies_9)
    end
    mine:SetBaseMaxHealth(max_health)
    mine:SetMaxHealth(max_health)
    mine:SetHealth(max_health)
    mine:SetControllableByPlayer(self:GetCaster():GetPlayerOwnerID(), true)
    return mine
end

function techies_mutually_assured_destruction_custom:GetManaRegenOverride()
    return self:GetCaster():GetMaxMana() / 100 * self:GetSpecialValueFor("bonus_mana_as_mana_regen")
end

function techies_mutually_assured_destruction_custom:GetAbilityDamageMine()
    local bonus = 0
    if self:GetCaster():HasModifier("modifier_techies_14") then
        bonus = self.modifier_techies_14
    end
    return self:GetCaster():GetMaxMana() / 100 * (self:GetSpecialValueFor("max_mana_pct_as_damage") + bonus)
end

modifier_techies_mutually_assured_destruction_custom = class({})
function modifier_techies_mutually_assured_destruction_custom:IsHidden() return true end
function modifier_techies_mutually_assured_destruction_custom:IsPurgable() return false end
function modifier_techies_mutually_assured_destruction_custom:IsPurgeException() return false end
function modifier_techies_mutually_assured_destruction_custom:RemoveOnDeath() return false end
function modifier_techies_mutually_assured_destruction_custom:DeclareFunctions()
    return
    {
        MODIFIER_EVENT_ON_DEATH,
        MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL,
        MODIFIER_PROPERTY_OVERRIDE_ABILITY_SPECIAL_VALUE
    }
end
function modifier_techies_mutually_assured_destruction_custom:OnCreated()
    self.bonus_mana_as_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_as_mana_regen")
    self.max_mana_pct_as_damage = self:GetAbility():GetSpecialValueFor("max_mana_pct_as_damage")
end
function modifier_techies_mutually_assured_destruction_custom:OnRefresh()
    self.bonus_mana_as_mana_regen = self:GetAbility():GetSpecialValueFor("bonus_mana_as_mana_regen")
    self.max_mana_pct_as_damage = self:GetAbility():GetSpecialValueFor("max_mana_pct_as_damage")
end
function modifier_techies_mutually_assured_destruction_custom:OnDeath(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end
    if not params.unit:IsRealHero() then return end
    self:GetAbility():CreateMine(self:GetParent():GetAbsOrigin(), true)
end

function modifier_techies_mutually_assured_destruction_custom:GetModifierConstantManaRegen()
    return self:GetAbility():GetManaRegenOverride()
end

function modifier_techies_mutually_assured_destruction_custom:GetModifierOverrideAbilitySpecial(data)
    if data.ability:GetAbilityName() == "techies_mutually_assured_destruction_custom" and data.ability_special_value == "current_mana_regen" then
        return 1
    end
    if data.ability:GetAbilityName() == "techies_mutually_assured_destruction_custom" and data.ability_special_value == "current_damage" then
        return 1
    end
end

function modifier_techies_mutually_assured_destruction_custom:GetModifierOverrideAbilitySpecialValue(data)
    if data.ability:GetAbilityName() == "techies_mutually_assured_destruction_custom" and data.ability_special_value == "current_mana_regen" then
        return self:GetAbility():GetManaRegenOverride()
    end
    if data.ability:GetAbilityName() == "techies_mutually_assured_destruction_custom" and data.ability_special_value == "current_damage" then
        return self:GetAbility():GetAbilityDamageMine()
    end
end

modifier_techies_remote_mines_custom = class({})
function modifier_techies_remote_mines_custom:IsHidden() return true end
function modifier_techies_remote_mines_custom:IsPurgable() return false end
function modifier_techies_remote_mines_custom:IsPurgeException() return false end
function modifier_techies_remote_mines_custom:RemoveOnDeath() return false end
function modifier_techies_remote_mines_custom:OnCreated()
    if not IsServer() then return end
    local particle_mine_fx = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_remote_mine.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle_mine_fx, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(particle_mine_fx)
    self:GetParent():SetBaseMoveSpeed(0)
    --self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_NONE)
    self:StartIntervalThink(0.1)
end

function modifier_techies_remote_mines_custom:ActivatePlant(death)
    if not IsServer() then return end
    self.activate_plant = true
    local radius = self:GetAbility():GetSpecialValueFor("radius")
    local particle = ParticleManager:CreateParticle("particles/ui_mouseactions/range_finder_tower_aoe.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:SetParticleControl(particle, 2, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(particle, 3, Vector(radius,radius,radius))
    ParticleManager:SetParticleControl(particle, 4, Vector(255,0,0))
    self:AddParticle(particle, false, false, -1, false, false)
    self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_techies_remote_mines_custom_invul", {})
    if not death then
        local duration = self:GetAbility():GetSpecialValueFor("explosion_delay")
        if self:GetCaster():HasModifier("modifier_techies_11") then
            duration = duration + self:GetAbility().modifier_techies_11[self:GetCaster():GetTalentLevel("modifier_techies_11")]
        end
        self:SetDuration(duration, true)
    end
    self:GetParent():EmitSound("Hero_Techies.RemoteMine.Activate")
end

function modifier_techies_remote_mines_custom:OnIntervalThink()
    if not IsServer() then return end
    if self:GetCaster():HasModifier("modifier_techies_14") then
        self:GetParent():SetBaseMoveSpeed(self:GetAbility().modifier_techies_14_speed)
        self:GetParent():SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)
    end
end

function modifier_techies_remote_mines_custom:OnDestroy()
    if not IsServer() then return end
    if self.activate_plant then
        local radius = self:GetAbility():GetSpecialValueFor("radius")
        local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_mad_explode.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(particle, 0, self:GetParent():GetAbsOrigin())
        ParticleManager:SetParticleControl(particle, 1, Vector(radius,radius,radius))
        ParticleManager:ReleaseParticleIndex(particle)
        self:GetParent():EmitSound("Hero_Techies.RemoteMine.Detonate")
        local enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), self:GetParent():GetAbsOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, 0, FIND_ANY_ORDER, false)
        for _, enemy in pairs(enemies) do
            ApplyDamage({victim = enemy, attacker = self:GetCaster(), damage = self:GetAbility():GetAbilityDamageMine(), damage_type = DAMAGE_TYPE_MAGICAL, ability = self:GetAbility()})
            local particle = ParticleManager:CreateParticle("particles/units/heroes/hero_techies/techies_mad_scorch.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
            ParticleManager:ReleaseParticleIndex(particle)
        end
    end
    self:GetParent():AddNoDraw()
    self:GetParent():ForceKill(true)
end

function modifier_techies_remote_mines_custom:CheckState()
    local state = 
    {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_ROOTED] = not self:GetCaster():HasModifier("modifier_techies_14"),
    }
    return state
end

function modifier_techies_remote_mines_custom:DeclareFunctions()
    return
    {
        MODIFIER_PROPERTY_IGNORE_MOVESPEED_LIMIT,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_DISABLE_HEALING,
    }
end

function modifier_techies_remote_mines_custom:GetDisableHealing() return 1 end
function modifier_techies_remote_mines_custom:GetModifierIgnoreMovespeedLimit() return 1 end


modifier_techies_remote_mines_custom_invul = class({})
function modifier_techies_remote_mines_custom_invul:IsHidden() return true end
function modifier_techies_remote_mines_custom_invul:IsPurgable() return false end
function modifier_techies_remote_mines_custom_invul:CheckState()
    local state = 
    {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_STUNNED] = true,
    }
    return state
end

modifier_techies_remote_mines_custom_plant = class({})
function modifier_techies_remote_mines_custom_plant:IsHidden() return true end
function modifier_techies_remote_mines_custom_plant:IsPurgable() return false end
function modifier_techies_remote_mines_custom_plant:IsPurgeException() return false end
function modifier_techies_remote_mines_custom_plant:OnCreated()
    if not IsServer() then return end
    self:GetCaster():SwapAbilities("techies_mutually_assured_destruction_custom", "techies_focused_detonate_custom", false, true)
    local techies_focused_detonate_custom = self:GetCaster():FindAbilityByName("techies_focused_detonate_custom")
    if techies_focused_detonate_custom then
        techies_focused_detonate_custom:SetLevel(1)
    end
end
function modifier_techies_remote_mines_custom_plant:OnDestroy()
    if not IsServer() then return end
    self:GetCaster():SwapAbilities("techies_focused_detonate_custom", "techies_mutually_assured_destruction_custom", false, true)
end

techies_focused_detonate_custom = class({})
function techies_focused_detonate_custom:OnSpellStart()
    if not IsServer() then return end
    local techies_mutually_assured_destruction_custom = self:GetCaster():FindAbilityByName("techies_mutually_assured_destruction_custom")
    if techies_mutually_assured_destruction_custom then
        techies_mutually_assured_destruction_custom.mine:RemoveModifierByName("modifier_techies_remote_mines_custom_plant")
        local modifier_techies_remote_mines_custom = techies_mutually_assured_destruction_custom.mine:FindModifierByName("modifier_techies_remote_mines_custom")
        if modifier_techies_remote_mines_custom then
            modifier_techies_remote_mines_custom:ActivatePlant()
        end
    end
end