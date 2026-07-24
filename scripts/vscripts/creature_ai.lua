--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


---@class CBaseEntity
---@field nSpawnerTeamNumber integer | nil

function Spawn(spawnData)
    if not IsServer() then return end
    if thisEntity == nil then return end
    if thisEntity:GetTeam() ~= DOTA_TEAM_NEUTRALS then return end

    local activeAbilities = {}
    for abilityIndex = 0, thisEntity:GetAbilityCount() - 1 do
        local ability = thisEntity:GetAbilityByIndex(abilityIndex)

        if ability and ability.IsPassive and not ability:IsPassive() then
            ability:StartCooldown(0.5)
            table.insert(activeAbilities, BuildAbilityRecord(ability))

            if ability:GetAbilityName() == "harpy_storm_chain_lightning_lua" then
                Timers:CreateTimer({
                    endTime = 0.45,
                    callback = function()
                        local mapName = GetMapName()
                        if mapName == "2x6" then
                            ability:SetLevel(2)
                        else
                            ability:SetLevel(3)
                        end
                    end
                })
            end

            -- if ability:GetAbilityName() == "golem_anti_blademail" then --один хуй не работает
            --     Timers:CreateTimer({
            --         endTime = 0.45,
            --         callback = function()
            --             local unitName = thisEntity:GetUnitName()
            --             if unitName == "npc_dota_mud_golem" then
            --                 ability:SetLevel(1)
            --             elseif unitName == "npc_dota_rock_golem" then
            --                 ability:SetLevel(2)
            --             elseif unitName == "npc_dota_granite_golem" then
            --                 ability:SetLevel(3)
            --             end
            --         end
            --     })
            -- end
        end
    end
    thisEntity.activeAbilities = activeAbilities
    thisEntity.consumeAbility = thisEntity:FindAbilityByName("life_stealer_consume")

    thisEntity:SetContextThink("CreepThink", CreepThink, 0.5)
end

--- @return number
function CreepThinkBody()
    if not IsEntityReadyForAI() then return Jitter(1.0) end

    TryCastLifeStealerConsume()

    if thisEntity:IsChanneling() then return Jitter(0.2) end

    local target = GetOrFindAttackTarget()

    if not target then return IdleBehavior() end

    local castDelay = TryCastAbility(target)
    if castDelay then return castDelay end

    AttackTarget(target)
    return Jitter(0.5)
end

--- @return number
function CreepThink()
    local success, delay = xpcall(CreepThinkBody, HandleCreepAIError)

    return success and delay or Jitter(1.0)
end

function Jitter(base)
    return base + RandomFloat(0, 0.3)
end

---@return boolean
function IsEntityReadyForAI()
    if not thisEntity or not thisEntity:IsAlive() then
        return false
    end
    if GameRulesCustom:IsGamePaused() then
        return false
    end
    return true
end

function TryCastLifeStealerConsume()
    local ability = thisEntity.consumeAbility
    if ability and ability:IsFullyCastable() then
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
            AbilityIndex = ability:entindex()
        })
    end
end

CREEP_AI_SEARCH_RADIUS = 3000
CREEP_AI_SEARCH_COOLDOWN = 1.0

---@return CDOTA_BaseNPC | nil
function GetOrFindAttackTarget()
    if IsValid(thisEntity.attackTarget) and thisEntity.attackTarget:IsAlive() and
        not thisEntity.attackTarget:IsUnselectable() then
        return thisEntity.attackTarget
    end

    if thisEntity.nextTargetSearch and GameRulesCustom:GetGameTime() < thisEntity.nextTargetSearch then
        return nil
    end

    local potentialTargets = {}
    if thisEntity.nSpawnerTeamNumber ~= nil then
        potentialTargets = FindUnitsInRadius(
            thisEntity.nSpawnerTeamNumber,
            thisEntity:GetOrigin(),
            thisEntity,
            2600,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
            DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
            FIND_CLOSEST,
            true
        )
    else
        potentialTargets = FindUnitsInRadius(
            DOTA_TEAM_NEUTRALS,
            thisEntity:GetOrigin(),
            nil,
            CREEP_AI_SEARCH_RADIUS,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
            DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
            FIND_CLOSEST,
            false
        )
    end

    for _, enemy in pairs(potentialTargets) do
        if IsValid(enemy) and enemy:IsAlive() and not enemy:IsUnselectable() then
            thisEntity.attackTarget = enemy
            thisEntity.nextTargetSearch = nil
            return enemy
        end
    end

    thisEntity.attackTarget = nil
    thisEntity.nextTargetSearch = GameRulesCustom:GetGameTime() + CREEP_AI_SEARCH_COOLDOWN
    return nil
end

---@return number nextThinkDelay
function IdleBehavior()
    if not thisEntity:IsAttacking() then
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
            Position = thisEntity:GetOrigin()
        })
    end
    return Jitter(0.9)
end

---@param target CDOTA_BaseNPC
function AttackTarget(target)
    if not thisEntity:IsAttacking() then
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
            Position = target:GetOrigin()
        })
    end
end

---@param err string
function HandleCreepAIError(err)
    logger:LogError("[HandleCreepAIError] " .. err)
end

---@param targetUnit CDOTA_BaseNPC
---@return integer?
function TryCastAbility(targetUnit)
    local k = CastAbility(targetUnit)
    if k then
        return k
    else
        return nil
    end
end

function ContainsValue(m, n)
    if type(m) == "userdata" then
        m = tonumber(tostring(m))
    end
    if bit:_and(m, n) == n then
        return true
    else
        return false
    end
end

--- @param ability CDOTABaseAbility
function BuildAbilityRecord(ability)
    local targetTeam = ability:GetAbilityTargetTeam()
    return {
        ability = ability,
        isUnitTarget = ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_UNIT_TARGET),
        isAttack = ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_ATTACK),
        isPoint = ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_POINT),
        isNoTarget = ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_NO_TARGET),
        isAutocast = ability:HasBehavior(DOTA_ABILITY_BEHAVIOR_AUTOCAST),
        castOnEnemy = ContainsValue(targetTeam, DOTA_UNIT_TARGET_TEAM_ENEMY)
            or ContainsValue(targetTeam, DOTA_UNIT_TARGET_TEAM_CUSTOM),
        castOnFriendly = ContainsValue(targetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY),
    }
end

--- @param target CDOTA_BaseNPC
--- @return integer|nil
function CastAbility(target)
    local activeAbilities = thisEntity.activeAbilities
    if not activeAbilities then return end

    for _, rec in ipairs(activeAbilities) do
        local ability = rec.ability
        if ability and not ability:IsNull() and ability:IsFullyCastable() and not ability:IsHidden() then
            if rec.isUnitTarget and not rec.isAttack then
                if rec.castOnEnemy then
                    ExecuteOrderFromTable({
                        UnitIndex = thisEntity:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                        AbilityIndex = ability:entindex(),
                        TargetIndex = target:entindex()
                    })
                    return ability:GetCastPoint() + RandomFloat(0.1, 0.3)
                end
                if rec.castOnFriendly then
                    ExecuteOrderFromTable({
                        UnitIndex = thisEntity:entindex(),
                        OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                        AbilityIndex = ability:entindex(),
                        TargetIndex = thisEntity:entindex()
                    })
                    return ability:GetCastPoint() + RandomFloat(0.1, 0.3)
                end
            end
            if rec.isPoint then
                local targetVector = target:GetForwardVector() * RandomInt(25, 75)
                local position = target:GetOrigin() + targetVector
                ExecuteOrderFromTable({
                    UnitIndex = thisEntity:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                    Position = position,
                    AbilityIndex = ability:entindex()
                })
                return ability:GetCastPoint() + RandomFloat(0.1, 0.3)
            end
            if rec.isNoTarget and not rec.isAutocast then
                ExecuteOrderFromTable({
                    UnitIndex = thisEntity:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
                    AbilityIndex = ability:entindex()
                })
                return ability:GetCastPoint() + RandomFloat(0.1, 0.3)
            end
            if rec.isAutocast then
                if not ability:GetAutoCastState() then
                    ability:ToggleAutoCast()
                end
            end
        end
    end
end