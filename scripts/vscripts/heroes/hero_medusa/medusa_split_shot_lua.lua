--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


LinkLuaModifier("modifier_medusa_split_shot_lua", "heroes/hero_medusa/medusa_split_shot_lua", LUA_MODIFIER_MOTION_NONE)
medusa_split_shot_lua = class({}) ---@class medusa_split_shot_lua : CDOTA_Ability_Lua

function medusa_split_shot_lua:OnToggle()
    if not IsServer() then return end

    local caster = self:GetCaster()
    if self:GetToggleState() then
        caster:AddNewModifier(caster, self, "modifier_medusa_split_shot_lua", {})
    else
        caster:RemoveModifierByName("modifier_medusa_split_shot_lua")
    end
end

---@param target CDOTA_BaseNPC?
---@param location Vector?
function medusa_split_shot_lua:OnProjectileHit(target, location)
    if not target then return end

    self.split_shot_attack = true
    self:GetCaster():PerformAttack(
        target, -- hTarget
        false,  -- bUseCastAttackOrb
        false,  -- bProcessProcs
        true,   -- bSkipCooldown
        false,  -- bIgnoreInvis
        false,  -- bUseProjectile
        false,  -- bFakeAttack
        false   -- bNeverMiss
    )
    self.split_shot_attack = false
end

----------------------------------------------------------------------------
modifier_medusa_split_shot_lua = class({}) ---@class CDOTA_Modifier_Lua

function modifier_medusa_split_shot_lua:IsHidden()
    return true
end

---@return boolean
function modifier_medusa_split_shot_lua:IsPurgable()
    return false
end

---@return modifierpriority
function modifier_medusa_split_shot_lua:GetPriority()
    return MODIFIER_PRIORITY_HIGH
end

---@param event table
function modifier_medusa_split_shot_lua:OnCreated(event)
    local ability = self:GetAbility()
    if not ability then return end

    self.reduction = ability:GetSpecialValueFor("damage_modifier")
    self.count = ability:GetSpecialValueFor("arrow_count")
    self.bonus_range = ability:GetSpecialValueFor("split_shot_bonus_range")
    self.cache_interval = ability:GetSpecialValueFor("target_cache_interval")
    if self.cache_interval <= 0 then
        self.cache_interval = 0.25
    end
    self.use_modifier = ability:GetSpecialValueFor("process_procs") == 1 and true or false
    self.parent = self:GetParent()
    self.cache_expire_time = 0
    self.cache_enemies = nil
    self.cache_origin = self.parent:GetAbsOrigin()

    if not IsServer() then return end
    self.projectile_name = self.parent:GetRangedProjectileName()
    self.projectile_speed = self.parent:GetProjectileSpeed()
end

---@param event table
function modifier_medusa_split_shot_lua:OnRefresh(event)
    local ability = self:GetAbility()
    if not ability then return end

    self.reduction = ability:GetSpecialValueFor("damage_modifier")
    self.count = ability:GetSpecialValueFor("arrow_count")
    self.bonus_range = ability:GetSpecialValueFor("split_shot_bonus_range")
    self.cache_interval = ability:GetSpecialValueFor("target_cache_interval")
    if self.cache_interval <= 0 then
        self.cache_interval = 0.25
    end
    self.use_modifier = ability:GetSpecialValueFor("process_procs") == 1 and true or false
end

---@return modifierfunction[]
function modifier_medusa_split_shot_lua:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE,
    }
end

---@param params ModifierAttackEvent
function modifier_medusa_split_shot_lua:OnAttack(params)
    if not IsServer() then return end

    local ability = self:GetAbility()
    if not ability then return end

    if ability.split_shot_attack then return end

    if params.attacker ~= self.parent then return end

    if params.target:GetTeamNumber() == params.attacker:GetTeamNumber() then return end

    if self.parent:PassivesDisabled() then return end

    if not params.process_procs then return end

    if self.split_shot then return end

    local targets = self:GetSplitTargets(params.target)
    if #targets == 0 then return end

    if self.use_modifier then
        self:SplitShotModifier(targets)
    else
        self:SplitShotNoModifier(targets)
    end
end

---@return number
function modifier_medusa_split_shot_lua:GetModifierDamageOutgoing_Percentage()
    return self.reduction
end

---@return number
function modifier_medusa_split_shot_lua:GetCurrentSplitRange()
    return self.parent:Script_GetAttackRange() + self.bonus_range
end

---@param a Vector
---@param b Vector
---@return number
function modifier_medusa_split_shot_lua:GetDistance2DSquared(a, b)
    local dx = a.x - b.x
    local dy = a.y - b.y
    return (dx * dx) + (dy * dy)
end

---@param enemy CDOTA_BaseNPC
---@param primary_target CDOTA_BaseNPC
---@param radius_sq number
---@return boolean
function modifier_medusa_split_shot_lua:IsValidSplitTarget(enemy, primary_target, radius_sq)
    if not enemy or enemy:IsNull() or not enemy:IsAlive() then return false end
    if enemy == primary_target then return false end
    if enemy:GetTeamNumber() == self.parent:GetTeamNumber() then return false end
    if not self.parent:CanEntityBeSeenByMyTeam(enemy) then return false end

    local distance_sq = self:GetDistance2DSquared(enemy:GetAbsOrigin(), self.parent:GetAbsOrigin())
    if distance_sq > radius_sq then return false end

    return true
end

---@return CDOTA_BaseNPC[]
function modifier_medusa_split_shot_lua:GetEnemiesCached()
    local now = GameRules:GetGameTime()
    local max_shift = 64 * 64
    local moved_sq = self:GetDistance2DSquared(self.parent:GetAbsOrigin(), self.cache_origin)

    if self.cache_enemies and now < self.cache_expire_time and moved_sq <= max_shift then
        return self.cache_enemies
    end

    local radius = self:GetCurrentSplitRange()
    self.cache_enemies = FindUnitsInRadius(
        self.parent:GetTeamNumber(),
        self.parent:GetOrigin(),
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_COURIER,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        FIND_CLOSEST,
        false
    )
    self.cache_expire_time = now + self.cache_interval
    self.cache_origin = self.parent:GetAbsOrigin()

    return self.cache_enemies
end

---@param primary_target CDOTA_BaseNPC
---@return CDOTA_BaseNPC[]
function modifier_medusa_split_shot_lua:GetSplitTargets(primary_target)
    local enemies = self:GetEnemiesCached()
    local radius = self:GetCurrentSplitRange()
    local radius_sq = radius * radius
    local targets = {}

    for i = 1, #enemies do
        local enemy = enemies[i]
        if self:IsValidSplitTarget(enemy, primary_target, radius_sq) then
            targets[#targets + 1] = enemy
            if #targets >= self.count then break end
        end
    end

    return targets
end

---@param targets CDOTA_BaseNPC[]
function modifier_medusa_split_shot_lua:SplitShotModifier(targets)
    for i = 1, #targets do
        self.split_shot = true
        self.parent:PerformAttack(
            targets[i],        -- hTarget
            false,             -- bUseCastAttackOrb
            self.use_modifier, -- bProcessProcs
            true,              -- bSkipCooldown
            false,             -- bIgnoreInvis
            true,              -- bUseProjectile
            false,             -- bFakeAttack
            false              -- bNeverMiss
        )
        self.split_shot = false
    end

    if #targets > 0 then
        EmitSoundOn("Hero_Medusa.AttackSplit", self.parent)
    end
end

---@param targets CDOTA_BaseNPC[]
function modifier_medusa_split_shot_lua:SplitShotNoModifier(targets)
    for i = 1, #targets do
        local info = {
            Target = targets[i],
            Source = self.parent,
            Ability = self:GetAbility(),
            EffectName = self.projectile_name,
            iMoveSpeed = self.projectile_speed,
            bDodgeable = true, -- Optional
        } ---@type CreateTrackingProjectileOptions
        ProjectileManager:CreateTrackingProjectile(info)
    end

    if #targets > 0 then
        EmitSoundOn("Hero_Medusa.AttackSplit", self.parent)
    end
end