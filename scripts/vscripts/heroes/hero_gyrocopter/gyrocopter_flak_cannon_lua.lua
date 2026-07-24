--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


gyrocopter_flak_cannon_lua = class({})
LinkLuaModifier("modifier_gyrocopter_flak_cannon_lua", "heroes/hero_gyrocopter/gyrocopter_flak_cannon_lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_gyrocopter_flak_cannon_lua_scepter", "heroes/hero_gyrocopter/gyrocopter_flak_cannon_lua", LUA_MODIFIER_MOTION_NONE)

function gyrocopter_flak_cannon_lua:GetAOERadius()
    return self:GetSpecialValueFor("radius")
end

function gyrocopter_flak_cannon_lua:GetCooldown(level)
    return self.BaseClass.GetCooldown(self, level)
end

function gyrocopter_flak_cannon_lua:GetIntrinsicModifierName()
    return "modifier_gyrocopter_flak_cannon_lua_scepter"
end

function gyrocopter_flak_cannon_lua:OnSpellStart(...)
    if not IsServer() then return end

    local hCaster = self:GetCaster()

    if not hCaster or hCaster:IsNull() then return false end

    local flDuration = self:GetDuration()
    local max_attacks = self:GetSpecialValueFor("max_attacks") +
                            hCaster:GetTalentValue(
                                "special_bonus_unique_gyrocopter_2")

    if hCaster and not hCaster:IsNull() then
        local hModifier = hCaster:AddNewModifier(hCaster, self,
                                                 "modifier_gyrocopter_flak_cannon_lua",
                                                 {duration = flDuration})
        if hModifier then hModifier:SetStackCount(max_attacks) end
    end

    hCaster:EmitSound("Hero_Gyrocopter.FlackCannon.Activate")

end

modifier_gyrocopter_flak_cannon_lua = class({})

function modifier_gyrocopter_flak_cannon_lua:IsPurgable() return false end
function modifier_gyrocopter_flak_cannon_lua:IsPurgeException() return false end

function modifier_gyrocopter_flak_cannon_lua:OnCreated()
    if not IsServer() then return end
end

function modifier_gyrocopter_flak_cannon_lua:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_gyrocopter_flak_cannon_lua:GetEffectName()
    return
        "particles/units/heroes/hero_gyrocopter/gyro_flak_cannon_overhead.vpcf"
end

function modifier_gyrocopter_flak_cannon_lua:AttackModifier(params)

    if params.attacker ~= self:GetParent() then return end

    if params.no_attack_cooldown then return end

    local hParent = self:GetParent()
    local hAbility = self:GetAbility()

    if (not hParent) or hParent:IsNull() then return end

    if (not hAbility) or hAbility:IsNull() then return end

    local flRadius = hAbility:GetSpecialValueFor("radius") +
                         hParent:GetTalentValue(
                             "special_bonus_unique_gyrocopter_4")

    hParent:EmitSound("Hero_Gyrocopter.FlackCannon")

    local flDelay = hAbility:GetSpecialValueFor("attack_delay")

    local enemies = FindUnitsInRadius(hParent:GetTeamNumber(),
                                      hParent:GetAbsOrigin(), nil, flRadius,
                                      DOTA_UNIT_TARGET_TEAM_ENEMY,
                                      DOTA_UNIT_TARGET_HERO +
                                          DOTA_UNIT_TARGET_BASIC,
                                      DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
                                      FIND_CLOSEST, false)

    -- 性能原因,给每个攻击单位加上延迟
    -- 第四个参数 很关键 skipCooldown, 加上以后 避免大部分情况重复触发
    for i, hEnemy in pairs(enemies) do
        Timers:CreateTimer(flDelay * i, function()
            if not hEnemy or hEnemy:IsNull() then return end
            -- A1: не бить невидимых без детекта (раньше Flak попадал в инвиз без вардов)
            if hEnemy:IsInvisible() and not hParent:CanEntityBeSeenByMyTeam(hEnemy) then return end
            if hEnemy:IsAttackImmune() or hEnemy:IsInvulnerable() then
                return
            end
            if not hEnemy:IsAlive() then return end
            hParent:PerformAttack(hEnemy, false, false, true, false, true,
                                  false, false)
        end)
    end

    local nStackCount = self:GetStackCount()
    if nStackCount <= 1 then
        self:Destroy()
    else
        self:SetStackCount(nStackCount - 1)
    end

end

modifier_gyrocopter_flak_cannon_lua_scepter = class({})
function modifier_gyrocopter_flak_cannon_lua_scepter:OnCreated()
    if not IsServer() then return end
    Timers:CreateTimer(2, function()
        if self and (not self:IsNull()) then
            local flInterval = 1.2
            self:StartIntervalThink(flInterval)
        end
    end)
end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsHidden() return true end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsPurgable() return false end
function modifier_gyrocopter_flak_cannon_lua_scepter:IsPurgeException() return false end
function modifier_gyrocopter_flak_cannon_lua_scepter:RemoveOnDeath() return false end
function modifier_gyrocopter_flak_cannon_lua_scepter:OnIntervalThink()
    if not IsServer() then return end
    local hParent = self:GetParent()
    if (not hParent) or hParent:IsNull() then return end
    -- A39: пассивка скипетра (RemoveOnDeath=false) продолжала бить после смерти героя — стоп, пока мёртв
    if not hParent:IsAlive() then return end
    if not hParent:HasScepter() then return end
    if hParent:IsInvisible() then return end
    local enemies = FindUnitsInRadius(hParent:GetTeamNumber(), hParent:GetAbsOrigin(), nil, 700, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES, FIND_FARTHEST, false)
    local attack_count = 1
    if self:GetParent():HasModifier("modifier_gyrocopter_flak_cannon_lua") then
        attack_count = 2
    end
    for _, enemy in pairs(enemies) do
        -- A1: не бить невидимых без детекта (раньше Flak попадал в инвиз без вардов)
        if enemy and not enemy:IsAttackImmune() and not enemy:IsInvulnerable() and
            enemy:IsAlive() and
            (not enemy:IsInvisible() or hParent:CanEntityBeSeenByMyTeam(enemy)) then
            hParent:PerformAttack(enemy, true, true, true, false, true, false, false)
            attack_count = attack_count - 1
            if attack_count <= 0 then break end
        end
    end
end
