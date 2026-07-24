--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- Модуль для оптимального спавна крипов, их AI

Creeps = Creeps or class({})

-- Константы типов поведения крипов
-- Используются для определения, как крипы должны взаимодействовать с героями с различными модификаторами
CREEP_BEHAVIOR_MOVE_TO_HERO = 1       -- Только двигаться к герою (не атаковать, не кастовать)
CREEP_BEHAVIOR_MOVE_AND_CAST = 2      -- Двигаться к герою и кастовать способности
CREEP_BEHAVIOR_LOCK_IN_PLACE = 3      -- Замереть на месте
CREEP_BEHAVIOR_ATTACK = 4             -- Атаковать героя (поведение по умолчанию)

-- Приоритеты поведения (от высшего к низшему)
BEHAVIOR_PRIORITIES = {
    CREEP_BEHAVIOR_ATTACK,
    CREEP_BEHAVIOR_MOVE_AND_CAST,
    CREEP_BEHAVIOR_MOVE_TO_HERO,
    CREEP_BEHAVIOR_LOCK_IN_PLACE
}

-- Таблицы модификаторов, сгруппированные по типам поведения
-- Для удобного добавления новых модификаторов и поддержки кода

-- Модификаторы, при которых крипы только двигаются к герою (не атакуют, не кастуют)
local MOVE_TO_HERO_MODIFIERS = {
    "modifier_slark_shadow_dance",                  -- Slark's Shadow Dance
    "modifier_slark_shadow_dance_custom_shard",     -- Slark's Depth Shroud (Shard)
    "modifier_tusk_snowball_movement",              -- Tusk's Snowball
    "modifier_kez_raptor_dance_immune",              -- Kez Raptor Dance (неуязвимость)
    "modifier_stranger_test",
    "modifier_item_book_of_shadows_custom"
}

-- Модификаторы, при которых крипы двигаются к герою и кастуют способности
local MOVE_AND_CAST_MODIFIERS = {
    "modifier_phantom_assassin_blur_custom_active", -- PA's Blur (Active)
    "modifier_smoke_of_deceit_cha_custom",    -- Smoke of Deceit
    "modifier_ninja_gear_custom",             -- Ninja Gear
    "modifier_eul_cyclone",                   -- Eul's Scepter
    "modifier_wind_waker"                     -- Wind Waker
}

-- Модификаторы, при которых крипы замирают на месте и ждут
local LOCK_IN_PLACE_MODIFIERS = {
    --"modifier_item_invisibility_edge_windwalk",
    "modifier_puck_phase_shift_custom",
    "modifier_obsidian_destroyer_astral_imprisonment_prison"
}


function Creeps:Init()
    print("[Creeps] Module loaded!")
    self.bStarted = false

    self.SpawnSchedule = {}

    self.DeleteSchedule = {}

    self.CreepsAI = {}

    self.CreepsCache = {}

    ListenToGameEvent('game_rules_state_change', Dynamic_Wrap( Creeps, "GameStateChanged"), self)
end

function Creeps:GameStateChanged()
    local State = GameRules:State_Get()
    if State == DOTA_GAMERULES_STATE_STRATEGY_TIME then
        GameRules:GetGameModeEntity():SetThink("SpawnThink", self, "CREEP_SPAWN_THINK", 0)

        GameRules:GetGameModeEntity():SetThink("DeleteDeathUnitsThink", self, "CREEP_DELETE_THINK", 1)

        GameRules:GetGameModeEntity():SetThink("CreepsAIThink", self, "CREEP_AI_THINK", 0.1)
    end
end

-- Запрос на создание крипа асинхронно
function Creeps:SpawnUnitByName(sUnitName, vLocation, bClearSpace, hOwner, hPlayerOwner, iTeam, check_callback, callback)
    if sUnitName == nil then
        print("sUnitName is nil")
        return
    end
    if vLocation == nil then
        print("vLocation is nil")
        return
    end
    if bClearSpace == nil then
        print("bClearSpace is nil")
        return
    end
    if iTeam == nil then
        print("iTeam is nil")
        return
    end

    -- Проверяем, нужно ли всё-еще спавнить крипа или нет
    if check_callback ~= nil and check_callback() then
        return
    end

    table.insert(self.SpawnSchedule, {
        sUnitName = sUnitName,
        vLocation = vLocation,
        bClearSpace = bClearSpace,
        hOwner = hOwner,
        hPlayerOwner = hPlayerOwner,
        iTeam = iTeam,
        check_callback = check_callback,
        callback = callback,
    })
end

-- Финк, который разрешает создать крипов раз в какое-то время
function Creeps:SpawnThink()
    local limit = 0

    self.SpawnSchedule = ArrayRemove(self.SpawnSchedule, function(t, i, j)
        if t[i] and t[i].check_callback ~= nil and t[i].check_callback() then
            return false
        end

        return true
    end)

    while true do 
        local SpawnRequestInfo = self.SpawnSchedule[1]
    
        if not SpawnRequestInfo then 
            break
        end

        table.remove(self.SpawnSchedule,1)
        self:_SpawnUnitByName(SpawnRequestInfo)

        limit = limit + 1
        if limit >= MAX_UNITS_SPAWN_PER_TICK then 
            break
        end
    end

    return FrameTime()+0.2
end

function Creeps:DeleteUnitAsync(hUnit, bIsRoundSpawned)
    if hUnit == nil or hUnit:IsNull() then return end

    local sUnitName = hUnit:GetUnitName() or "unknown"

    local SpawnGroup = nil
    if hUnit._is_round_spawned == true or bIsRoundSpawned == true then
        -- Повторная проверка IsNull перед GetSpawnGroupHandle — entity мог стать невалидным
        -- GetSpawnGroupHandle на невалидном entity = native crash сервера
        if hUnit:IsNull() then return end
        SpawnGroup = hUnit:GetSpawnGroupHandle()
    end

    -- Финальная проверка перед добавлением в расписание удаления
    if hUnit:IsNull() then
        table.insert(self.DeleteSchedule, {unit = nil, time = GameRules:GetGameTime() + 10, spawngroup = SpawnGroup, unit_name = sUnitName})
        return
    end

    table.insert(self.DeleteSchedule, {unit = hUnit, time = GameRules:GetGameTime() + 10, spawngroup = SpawnGroup, unit_name = sUnitName})
end

function Creeps:DeleteDeathUnitsThink()
    if #self.DeleteSchedule > 0 then
        local CurrentTime = GameRules:GetGameTime()

        self.DeleteSchedule = ArrayRemove(self.DeleteSchedule, function(t, i, j)
            local UnitInfo = t[i]
            if CurrentTime >= UnitInfo.time and UnitInfo.unit ~= nil and not UnitInfo.unit:IsNull() and not UnitInfo.unit:IsAlive() then
                UTIL_Remove(UnitInfo.unit)
                UnitInfo.unit = nil

                -- if UnitInfo.spawngroup ~= nil then
                --     Rounds:AddSpawnGroupToRound(UnitInfo.spawngroup)
                --     UnitInfo.spawngroup = nil
                -- end

                return false
            end
            if UnitInfo.unit == nil or UnitInfo.unit:IsNull() then
                -- if UnitInfo.spawngroup ~= nil then
                --     Rounds:AddSpawnGroupToRound(UnitInfo.spawngroup)
                --     UnitInfo.spawngroup = nil
                -- end

                return false
            end

            return true
        end)
    end

    return 1
end

function Creeps:AddAIToCreep(hUnit)
	table.insert(self.CreepsAI, {unit = hUnit, next_time = GameRules:GetGameTime() + RandomFloat(0.5, 1)})
end

function Creeps:CreepsAIThink()
    if not Rounds:StateIs(GAME_STATES.IN_ACTION) or GameRules:IsGamePaused() then return 0.1 end

    self.CreepsAI = ArrayRemove(self.CreepsAI, function(t, i, j)
        if t[i].unit == nil or t[i].unit:IsNull() or (not t[i].unit:IsAlive() and not t[i].unit:IsReincarnating()) then
            return false
        end
        return true
    end)

    local CurrentTime = GameRules:GetGameTime()

    for _, CreepInfo in ipairs(self.CreepsAI) do
        if CurrentTime >= CreepInfo.next_time then
            CreepInfo.next_time = CurrentTime + self:ThinkDefaultAI(CreepInfo.unit)
        end
    end

    return 0.1
end

-- Функция для определения типа поведения крипа в зависимости от модификаторов цели
-- @param hUnit - юнит (крип)
-- @param hTarget - цель (герой)
-- @return - тип поведения (CREEP_BEHAVIOR_*), имя модификатора, вызвавшего это поведение
function Creeps:GetBehaviorForTarget(hUnit, hTarget)
    -- Приоритет 1: LOCK_IN_PLACE модификаторы всегда имеют высший приоритет
    for _, modifier in ipairs(LOCK_IN_PLACE_MODIFIERS) do
        if hTarget:HasModifier(modifier) then
            return CREEP_BEHAVIOR_LOCK_IN_PLACE, modifier
        end
    end
    
    -- Получаем последний примененный модификатор из других групп
    local modCount = hTarget:GetModifierCount()
    for i = modCount - 1, 0, -1 do -- От последнего к первому
        local modName = hTarget:GetModifierNameByIndex(i)
        if modName ~= nil and modName ~= "" then

            -- Проверяем MOVE_AND_CAST
            if table.contains(MOVE_AND_CAST_MODIFIERS, modName) then
                return CREEP_BEHAVIOR_MOVE_AND_CAST, modName
            end
            
            -- Проверяем MOVE_TO_HERO
            if table.contains(MOVE_TO_HERO_MODIFIERS, modName) then
                return CREEP_BEHAVIOR_MOVE_TO_HERO, modName
            end
        end
    end
    
    -- По умолчанию - атака
    return CREEP_BEHAVIOR_ATTACK, nil
end

function Creeps:FindMainArenaTarget(hUnit)
    local hCurrentTarget = nil
    local Team = DOTA_TEAM_NEUTRALS
    local TargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY
    if hUnit.Team ~= nil then
        Team = hUnit.Team
        TargetTeam = DOTA_UNIT_TARGET_TEAM_FRIENDLY
    end

    local PossibleTargets = FindUnitsInRadius(
        Team, 
        hUnit:GetOrigin(), 
        nil, 
        2500, 
        TargetTeam, 
        DOTA_UNIT_TARGET_HERO, 
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, 
        FIND_CLOSEST, 
        false
    )

    for _, Target in ipairs(PossibleTargets) do
        if Target and not Target:IsNull() and Target:IsAlive() and Players:IsUnitCanAttackOrCastOnThis(hUnit, Target) then
            hCurrentTarget = Target
            break
        end
    end

    return hCurrentTarget
end

-- Вспомогательная функция для получения позиции с отступом от цели
function Creeps:GetOffsetPositionToTarget(hUnit, hTarget, offset)
    local targetPos = hTarget:GetAbsOrigin()
    local direction = CalculateDirection(hTarget, hUnit)
    return targetPos - direction * offset
end

function Creeps:SafeIssueOrder(hUnit, orderType, target, position)
    local needNew = false
    local currentTime = GameRules:GetGameTime()
    
    -- Инициализация времени последнего приказа
    if not hUnit.lastOrderTime then
        hUnit.lastOrderTime = 0
    end
    
    -- 1. Если тип приказа поменялся
    if hUnit.lastOrderType ~= orderType then
        needNew = true
    end

    -- 2. Если цель поменялась
    if target and (hUnit.lastTarget ~= target) then
        needNew = true
    end

    -- 3. Если позиция поменялась
    if position and (not hUnit.lastPosition or CalculateDistance(hUnit.lastPosition, position) > 100) then
        needNew = true
    end
    
    -- 4. Если прошло более 1 секунды с последнего приказа
    if currentTime - hUnit.lastOrderTime > 0.19 then
        needNew = true
    end

    if needNew and not hUnit:IsCommandRestricted() then
        local order = {
            UnitIndex = hUnit:entindex(),
            OrderType = orderType,
            Queue = false,
        }
        if target then order.TargetIndex = target:entindex() end
        if position then order.Position = position end

        ExecuteOrderFromTable(order)

        -- print("Order executed", hUnit:entindex(), orderType, target, position)
        -- local info = debug.getinfo(2, "Sl")
        -- print(string.format("Вызвана из %s:%d", info.short_src, info.currentline))
        
        -- Обновляем время последнего приказа
        hUnit.lastOrderTime = currentTime
        
        -- кэшируем
        hUnit.lastOrderType = orderType
        hUnit.lastTarget = target
        hUnit.lastPosition = position
    end
end

function Creeps:TryCastAbilitites(hUnit, Target)
    -- Базовые проверки
    if hUnit.next_try_cast_ability ~= nil and hUnit.next_try_cast_ability > GameRules:GetGameTime() then return end
    if hUnit:IsSilenced() or hUnit:IsHexed() then return end

    -- Определяем, можно ли кастовать на невидимую цель
    local canCastOnInvisible = (self:GetBehaviorForTarget(hUnit, Target) == CREEP_BEHAVIOR_MOVE_AND_CAST)
    local castDelay = RandomFloat(0.1, 0.3)
    
    for i=0, hUnit:GetAbilityCount()-1 do
        local hAbility = hUnit:GetAbilityByIndex(i)
        if hAbility and not hAbility:IsPassive() and hAbility:IsFullyCastable() then

            local Behavior = hAbility:GetBehaviorInt()
            local TargetTeam = hAbility:GetAbilityTargetTeam()
            local abilityCooldown = hAbility:GetCooldown(hAbility:GetLevel() - 1)

            -- Таргетные способности
            if ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET) and not ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_ATTACK) then
                -- Вражеские способности
                if (ContainsValue(TargetTeam, DOTA_UNIT_TARGET_TEAM_ENEMY) or ContainsValue(TargetTeam, DOTA_UNIT_TARGET_TEAM_CUSTOM) or ContainsValue(TargetTeam, DOTA_UNIT_TARGET_TEAM_BOTH)) and
                (not Target:IsInvisibleForUnit(hUnit) or canCastOnInvisible) then
                    hUnit:CastAbilityOnTarget(Target, hAbility, -1)
                    hUnit.next_try_cast_ability = GameRules:GetGameTime() + abilityCooldown
                    return hAbility:GetCastPoint() + castDelay
                end

                -- Дружественные способности
                if ContainsValue(TargetTeam, DOTA_UNIT_TARGET_TEAM_FRIENDLY) or ContainsValue(TargetTeam, DOTA_UNIT_TARGET_TEAM_BOTH) then
                    hUnit:CastAbilityOnTarget(hUnit, hAbility, -1)
                    hUnit.next_try_cast_ability = GameRules:GetGameTime() + abilityCooldown
                    return hAbility:GetCastPoint() + castDelay
                end
            -- Поинт-таргет способности
            elseif ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_POINT) and
                (not Target:IsInvisibleForUnit(hUnit) or canCastOnInvisible) then
                local vTargetPos = Target:GetOrigin() + Target:GetForwardVector() * RandomInt(25, 75)
                hUnit:CastAbilityOnPosition(vTargetPos, hAbility, -1)
                hUnit.next_try_cast_ability = GameRules:GetGameTime() + abilityCooldown
                return hAbility:GetCastPoint() + castDelay
            -- No-target способности
            elseif ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET) and
                not ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_AUTOCAST) then
                hUnit:CastAbilityNoTarget(hAbility, -1)
                hUnit.next_try_cast_ability = GameRules:GetGameTime() + abilityCooldown
                return hAbility:GetCastPoint() + castDelay
            -- Автокаст
            elseif ContainsValue(Behavior, DOTA_ABILITY_BEHAVIOR_AUTOCAST) and not hAbility:GetAutoCastState() then
                hUnit:CastAbilityToggle(hAbility, -1)

                return 0
            end
        end
    end
end

function Creeps:FindNearbyEnemy(hUnit)
    local CreepTeam = hUnit.Team
    local CreepAttackRange = hUnit:Script_GetAttackRange() + 150
    if CreepTeam == nil then
        local nearbyTarget = nil
        local enemies = FindUnitsInRadius(
            hUnit:GetTeamNumber(),
            hUnit:GetAbsOrigin(),
            nil,
            CreepAttackRange,
            DOTA_UNIT_TARGET_TEAM_ENEMY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
            FIND_CLOSEST,
            false
        )

        -- print("Getted new enemies table with no team cache")

        -- Находим первую подходящую цель
        for _, enemy in ipairs(enemies) do
            if not enemy:IsInvisibleForUnit(hUnit) and not enemy:IsInvulnerable() and 
            not enemy:IsAttackImmune() and Players:IsUnitCanAttackOrCastOnThis(hUnit, enemy) then
                nearbyTarget = enemy
                break
            end
        end
        return nearbyTarget
    else
        if self.CreepsCache[CreepTeam] == nil then
            self.CreepsCache[CreepTeam] = {
                next_search = 0,
                enemies = {},
            }
        end

        -- print("Trying to get enemies table")

        if self.CreepsCache[CreepTeam].next_search <= GameRules:GetGameTime() then
            self.CreepsCache[CreepTeam].next_search = GameRules:GetGameTime() + 0.1
            local enemies = FindUnitsInRadius(
                hUnit:GetTeamNumber(),
                hUnit:GetAbsOrigin(),
                nil,
                2500,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
                FIND_ANY_ORDER,
                false
            )

            -- print("Getted new enemies table")

            self.CreepsCache[CreepTeam].enemies = enemies
        end

        local nearbyTarget, minDist = nil, 99999
        for _, enemy in ipairs(self.CreepsCache[CreepTeam].enemies) do
            if enemy and not enemy:IsNull() and enemy:IsAlive() and not enemy:IsInvisibleForUnit(hUnit) and not enemy:IsInvulnerable() and 
            not enemy:IsAttackImmune() and Players:IsUnitCanAttackOrCastOnThis(hUnit, enemy) then
                local Dist = CalculateDistance(enemy, hUnit)
                if Dist < minDist and Dist <= CreepAttackRange then
                    minDist = Dist
                    nearbyTarget = enemy
                end
            end
        end

        return nearbyTarget
    end

    return nil
end

-- Основная функция AI крипов
function Creeps:ThinkDefaultAI(hUnit)
    if STOP_ALL_ORDERS then 
        if hUnit.lastOrderType ~= nil then
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_STOP, nil, nil)
            hUnit.lastOrderType = nil
        end
        return 0.1 
    end

    -- Базовые проверки состояния крипа
    if hUnit:HasModifier("modifier_creep_spawner_cha_ready") then return 0.1 end
    if hUnit:HasModifier("modifier_command_restricted") or hUnit:IsCommandRestricted() then 
        hUnit.lastOrderType = nil
        return 0.25 
    end
    if hUnit:IsChanneling() or hUnit:GetCurrentActiveAbility() ~= nil then return 0.1 end
    
    -- Проверка на активность команды -allstop
    if hUnit.allStopActive and Debugger and Debugger.allStopActive then
        -- Если крип уже достиг центра арены, просто стоим на месте
        if not hUnit.reachedCenter then
            local targetPos = hUnit.allStopTargetPos
            
            -- Если у крипа нет сохраненной целевой позиции, пытаемся определить ее
            if not targetPos then
                -- Сначала проверяем, есть ли у крипа команда
                local creepTeam = hUnit.Team
                if creepTeam then
                    -- Получаем арену команды крипа
                    local teamArena = nil
                    local teamInfo = Players:GetTeam(creepTeam)
                    if teamInfo and teamInfo.arena then
                        teamArena = teamInfo.arena
                        local arenaInfo = Map:GetArenaInfo(teamArena)
                        if arenaInfo and arenaInfo.center then
                            targetPos = arenaInfo.center
                        end
                    end
                end
                
                -- Если не удалось получить позицию через команду, определяем по текущей позиции
                if not targetPos then
                    local creepArena = Map:GetPositionArena(hUnit:GetAbsOrigin())
                    if creepArena then
                        local arenaInfo = Map:GetArenaInfo(creepArena)
                        if arenaInfo and arenaInfo.center then
                            targetPos = arenaInfo.center
                        end
                    end
                end
                
                -- Если все еще нет целевой позиции, используем основную арену
                if not targetPos then
                    local mainArenaInfo = Map:GetArenaInfo("MAIN")
                    if mainArenaInfo then
                        targetPos = mainArenaInfo.center
                    end
                end
                
                -- Сохраняем найденную позицию
                if targetPos then
                    hUnit.allStopTargetPos = targetPos
                end
            end
            
            if targetPos then
                local distToTarget = CalculateDistance(hUnit:GetAbsOrigin(), targetPos)
                
                if distToTarget <= 150 then
                    -- Крип достиг центра, останавливаем его
                    hUnit.reachedCenter = true
                    self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_STOP, nil, nil)
                else
                    -- Крип еще не достиг центра, продолжаем движение
                    self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, targetPos)
                end
            end
        end
        return 0.5
    end
    
    -- Сбрасываем флаги, если команда -allstop больше не активна
    if (hUnit.reachedCenter or hUnit.allStopTargetPos) and (not Debugger or not Debugger.allStopActive) then
        hUnit.reachedCenter = false
        hUnit.allStopTargetPos = nil
    end

    -- Инициализация при первом вызове
    if not hUnit.FirstCall then
        hUnit.FirstCall = true

        hUnit.next_try_cast_ability = GameRules:GetGameTime() + RandomFloat(0.5, 2)

        -- Случайная задержка задействования крипа - должно распределить нагрузку на сервер
        return RandomFloat(0, 1)
    end

    -- Сброс цели при определенных состояниях
    if hUnit:IsStunned() or hUnit:IsFrozen() or hUnit:IsHexed() or hUnit:IsDisarmed() or hUnit:IsRooted() then
        hUnit.lastTarget = nil
    end

    if hUnit:IsStunned() or hUnit:IsFrozen() then
        return 0.1
    end

    -- Получение текущей цели
    local hCurrentTarget = hUnit.hCurrentTarget
    if not hCurrentTarget or hCurrentTarget:IsNull() or not hCurrentTarget:IsAlive() then
        hCurrentTarget = self:FindMainArenaTarget(hUnit)
        hUnit.hCurrentTarget = hCurrentTarget
    end

    if not hCurrentTarget then
        hUnit.lastOrderType = nil
        hUnit.lastTarget = nil
        hUnit.lastPosition = nil
        return 0.1
    end



    -- print("Last order is", hUnit.lastOrderType)
    
    -- Определение поведения на основе модификаторов цели
    local behaviorType = self:GetBehaviorForTarget(hUnit, hCurrentTarget)
    
    -- Обработка LOCK_IN_PLACE (высший приоритет)
    if behaviorType == CREEP_BEHAVIOR_LOCK_IN_PLACE then
        if not hUnit.lockInPlaceHold then
            hUnit.lockInPlaceHold = true
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_STOP, nil, nil)
        end
        return 0.1
    elseif hUnit.lockInPlaceHold then
        hUnit.lockInPlaceHold = false
    end
    
    -- Поиск ближайших врагов в радиусе атаки
    local nearbyTarget = self:FindNearbyEnemy(hUnit)

    -- Обработка ближайшего врага, если найден
    if nearbyTarget and not hUnit:IsHexed() and not hUnit:IsDisarmed() then
        local CastTime = self:TryCastAbilitites(hUnit, nearbyTarget)
        if CastTime ~= nil then 
            hUnit.lastOrderType = nil
            if CastTime > 0 then
                return CastTime 
            end
        end
        
        -- Всегда отдаем команду атаковать
        self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_ATTACK_TARGET, nearbyTarget, nil)
        return 0.1
    end

    -- Обработка основной цели по типу поведения
    if hCurrentTarget:IsOutOfGame() and behaviorType ~= CREEP_BEHAVIOR_MOVE_TO_HERO then
        self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_STOP, nil, nil)
    elseif behaviorType == CREEP_BEHAVIOR_MOVE_AND_CAST then
        -- MOVE_AND_CAST: Используем способность и двигаемся к цели
        local CastTime = self:TryCastAbilitites(hUnit, hCurrentTarget)
        if CastTime ~= nil then 
            hUnit.lastOrderType = nil
            if CastTime > 0 then
                return CastTime 
            end
        end
        
        if hCurrentTarget:IsInvisibleForUnit(hUnit) then
            -- Двигаемся к цели, но оставляем небольшое расстояние (75 юнитов)
            local offsetPos = self:GetOffsetPositionToTarget(hUnit, hCurrentTarget, 75)
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, offsetPos)
        else
            -- print("Trying to call MOVE TO TARGET WITH CREEP_BEHAVIOR_MOVE_AND_CAST")
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_TARGET, hCurrentTarget, nil)
        end
    elseif behaviorType == CREEP_BEHAVIOR_MOVE_TO_HERO then
        if hCurrentTarget:IsInvisibleForUnit(hUnit) then
            -- Двигаемся к цели, но оставляем небольшое расстояние (75 юнитов)
            local offsetPos = self:GetOffsetPositionToTarget(hUnit, hCurrentTarget, 75)
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, offsetPos)
        else
            -- print("Trying to call MOVE TO TARGET WITH CREEP_BEHAVIOR_MOVE_TO_HERO")
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_TARGET, hCurrentTarget, nil)
        end
    elseif hCurrentTarget:IsAttackImmune() or hCurrentTarget:IsInvulnerable() or 
           hCurrentTarget:IsInvisibleForUnit(hUnit) or 
           (not hUnit:IsAttacking() and CalculateDistance(hUnit, hCurrentTarget) > 150) or
           hUnit:IsHexed() or hUnit:IsDisarmed() or
           -- Специальная проверка для комбинации иммунитетов (физический + магический)
           (hCurrentTarget:IsMagicImmune() and hCurrentTarget:IsAttackImmune()) then
        -- Цель недоступна для атаки или крип только что использовал способность: двигаемся к цели
        local CastTime = self:TryCastAbilitites(hUnit, hCurrentTarget)
        if CastTime ~= nil then 
            hUnit.lastOrderType = nil
            if CastTime > 0 then
                return CastTime 
            end
        end
        
        if hCurrentTarget:IsInvisibleForUnit(hUnit) then
            -- Двигаемся к цели, но оставляем небольшое расстояние (75 юнитов)
            local offsetPos = self:GetOffsetPositionToTarget(hUnit, hCurrentTarget, 75)
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_POSITION, nil, offsetPos)
        else
            -- print("Trying to call MOVE TO TARGET WITH MY CHECKS")
            self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_MOVE_TO_TARGET, hCurrentTarget, nil)
        end
    else
        -- Стандартная атака: Пробуем способность и атакуем
        local CastTime = self:TryCastAbilitites(hUnit, hCurrentTarget)
        if CastTime ~= nil then 
            hUnit.lastOrderType = nil
            if CastTime > 0 then
                return CastTime 
            end
        end
        
        -- Всегда атакуем цель
        self:SafeIssueOrder(hUnit, DOTA_UNIT_ORDER_ATTACK_TARGET, hCurrentTarget, nil)
    end
    
    return 0.1
end

function Creeps:_SpawnUnitByName(SpawnInfo)
    if SpawnInfo.check_callback ~= nil and SpawnInfo.check_callback() then
        return
    end

    TryPrecacheUnitAsync(SpawnInfo.sUnitName, function(prec_Id)
        if SpawnInfo.check_callback ~= nil and SpawnInfo.check_callback() then
            print("Spawn unit is interrupted, precache_id:", prec_Id)
            return
        end
        CreateUnitByNameAsync(SpawnInfo.sUnitName, SpawnInfo.vLocation, SpawnInfo.bClearSpace, SpawnInfo.hOwner, SpawnInfo.hPlayerOwner, SpawnInfo.iTeam, function(hUnit)
            if hUnit and hUnit.GetSpawnGroupHandle ~= nil then
                Rounds:AddSpawnGroupToRound(hUnit:GetSpawnGroupHandle())
            end
            if not hUnit or hUnit:IsNull() then
                print("Spawned unit is nil")
                if hUnit.GetSpawnGroupHandle ~= nil then
                    print("precache_id:", hUnit:GetSpawnGroupHandle())

                    Creeps:DeleteUnitAsync(hUnit, true)
                end
                UTIL_Remove(hUnit)
            end

            if SpawnInfo.check_callback ~= nil and SpawnInfo.check_callback() then
                print("Spawned unit is no more needed, precache_id:", hUnit:GetSpawnGroupHandle())
                Creeps:DeleteUnitAsync(hUnit, true)
                UTIL_Remove(hUnit)
                return
            end

            -- Проверяем, активен ли режим -allstop
            if Debugger and Debugger.allStopActive then
                -- Устанавливаем флаг для нового крипа
                hUnit.allStopActive = true
                
                -- Определяем целевую позицию для нового крипа
                local targetPos = nil
                local creepTeam = hUnit.Team
                
                -- Если у крипа есть команда, используем центр арены этой команды
                if creepTeam and Debugger.playerArenas[creepTeam] then
                    targetPos = Debugger.playerArenas[creepTeam]
                else
                    -- Если не можем определить команду крипа, ищем ближайшую арену
                    local creepPos = hUnit:GetAbsOrigin()
                    local creepArena = Map:GetPositionArena(creepPos)
                    
                    if creepArena and Debugger.playerArenas[creepArena] then
                        targetPos = Debugger.playerArenas[creepArena]
                    else
                        -- Если не можем определить арену, выбираем ближайшую
                        local closestDist = 999999
                        local closestArena = nil
                        
                        for _, centerPos in pairs(Debugger.playerArenas) do
                            local dist = (creepPos - centerPos):Length2D()
                            if dist < closestDist then
                                closestDist = dist
                                closestArena = centerPos
                            end
                        end
                        
                        if closestArena then
                            targetPos = closestArena
                        elseif Debugger.playerArenas["default"] then
                            targetPos = Debugger.playerArenas["default"]
                        end
                    end
                end
                
                -- Если нашли целевую позицию, отправляем крипа туда
                if targetPos then
                    hUnit.allStopTargetPos = targetPos
                    
                    -- Отправляем крипа в центр соответствующей арены
                    ExecuteOrderFromTable({
                        UnitIndex = hUnit:entindex(),
                        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
                        Position = targetPos,
                        Queue = false
                    })
                    
                    -- Добавляем небольшую задержку и проверяем, достиг ли крип центра
                    hUnit:SetContextThink(DoUniqueString("CheckCreepPosition"), function()
                        if hUnit and not hUnit:IsNull() and hUnit:IsAlive() and hUnit.allStopActive and targetPos then
                            local distToTarget = CalculateDistance(hUnit:GetAbsOrigin(), targetPos)
                            
                            if distToTarget <= 150 then
                                -- Крип достиг центра, останавливаем его
                                hUnit.reachedCenter = true
                                ExecuteOrderFromTable({
                                    UnitIndex = hUnit:entindex(),
                                    OrderType = DOTA_UNIT_ORDER_STOP,
                                    Queue = false
                                })
                                return nil
                            end
                            return 0.5
                        end
                        return nil
                    end, 0.5)
                end
            end

            if SpawnInfo.callback then
                SpawnInfo.callback(hUnit)
            end
        end)
    end)
end

if not Creeps.bStarted then Creeps:Init() end