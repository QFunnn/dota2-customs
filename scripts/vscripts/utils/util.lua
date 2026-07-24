--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Util == nil then
    Util = class({}) ---@class Util
end

local abilityCleanerByAbilityName = {
    ["broodmother_spin_web"] = Util.CleanWeb,
    ["witch_doctor_death_ward"] = Util.CleanDeathWard,
    ["visage_summon_familiars"] = Util.CleanFamiliar
}

---Перемещает определенного героя на фонтан
---@param playerId integer
---@param isPvpEnd? boolean
function Util:MoveHeroToCenter(playerId, isPvpEnd)
    isPvpEnd = isPvpEnd or false
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
    if not IsValid(hHero) then return end ---@cast hHero CDOTA_BaseNPC_Hero

    local nTeamNumber = hHero:GetTeamNumber()
    local vTargetLocation = GameMode.teamStartLocationMap[nTeamNumber]

    local hObservingTarget = Util:ChooseObservingTarget(playerId)
    if PlayerResource:GetConnectionState(playerId) ~= DOTA_CONNECTION_STATE_ABANDONED then
        if not hHero:IsAlive() then
            hHero:RespawnHero(false, false)
            if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                hHero:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
            end
        end
    end

    Util:MoveHeroToLocation(playerId, vTargetLocation, hObservingTarget, "prepare", isPvpEnd)
end

---Проверка на null. После проверки использовать с ---@cast variable CLASS, чтобы IDE не ругалась на nil
---@param object any?
---@return boolean
function IsValid(object)
    return object ~= nil and object.IsNull ~= nil and not object:IsNull()
end

---Возвращает героя за которым будем наблюдать
---@param playerId integer
---@return CDOTA_BaseNPC_Hero?
function Util:ChooseObservingTarget(playerId)
    if PvpModule.homeTeamId and Settings:Get(playerId, SettingsKey.AUTO_VIEW_PVP) == true and (not PvpModule.IsPvpEnd) then
        for i = 1, PlayerResource:GetPlayerCountForTeam(PvpModule.homeTeamId) do
            local tempPlayerId = PlayerResource:GetNthPlayerIDOnTeam(PvpModule.homeTeamId, i)
            local tempTargetHero = PlayerResource:GetSelectedHeroEntity(tempPlayerId)
            if tempTargetHero and (tempTargetHero:IsAlive() or tempTargetHero:IsReincarnating()) then
                return tempTargetHero
            end
        end
    end

    if Settings:Get(playerId, SettingsKey.AUTO_VIEW_PVE) == true and GameMode.currentRound and (not GameMode.currentRound.isEnd) then
        local killProgress = 100
        local targetTeamNumber
        for teamNumber, isAlive in pairs(GameMode.aliveTeamMap) do
            if isAlive and GameMode.currentRound.spawners[teamNumber] and false == GameMode.currentRound.spawners[teamNumber].isProgressFinished then
                if killProgress > GameMode.currentRound.spawners[teamNumber].killProgress then
                    targetTeamNumber = teamNumber
                end
            end
        end
        if targetTeamNumber then
            for i = 1, PlayerResource:GetPlayerCountForTeam(targetTeamNumber) do
                local playerID = PlayerResource:GetNthPlayerIDOnTeam(targetTeamNumber, i)
                local tempTargetHero = PlayerResource:GetSelectedHeroEntity(playerID)
                if tempTargetHero and (tempTargetHero:IsAlive() or tempTargetHero:IsReincarnating()) then
                    return tempTargetHero
                end
            end
        end
    end

    return PlayerResource:GetSelectedHeroEntity(playerId)
end

---Перемещает определенного игрока в указанное место
---@param playerId integer
---@param vLocation Vector
---@param hObservingTarget CBaseEntity?
---@param roomName string
---@param isPvpEnd boolean?
function Util:MoveHeroToLocation(playerId, vLocation, hObservingTarget, roomName, isPvpEnd)
    isPvpEnd = isPvpEnd or false
    local units = {}
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hHero then
        Util:RemoveMovemenModifier(hHero)

        do
            local pfx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_start.vpcf", PATTACH_ABSORIGIN,
                hHero)
            ParticleManager:ReleaseParticleIndex(pfx)
        end

        if Util.supposedRooms == nil then Util.supposedRooms = {} end

        Util.supposedRooms[playerId] = roomName or "prepare"
        units = FindUnitsInRadius(PlayerResource:GetTeam(playerId),
            hHero:GetAbsOrigin(), nil, 4000,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY,
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            DOTA_UNIT_TARGET_FLAG_INVULNERABLE +
            DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD +
            DOTA_UNIT_TARGET_FLAG_DEAD,
            FIND_ANY_ORDER, false)
        FindClearSpaceForUnit(hHero, vLocation, true)

        do
            local pfx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf",
                PATTACH_ABSORIGIN_FOLLOW, hHero)
            ParticleManager:ReleaseParticleIndex(pfx)
        end

        hHero:EmitSound("DOTA_Item.BlinkDagger.Activate")

        if hObservingTarget == nil then hObservingTarget = hHero end

        PlayerResource:SetCameraTarget(playerId, hObservingTarget)

        Timers:CreateTimer({
            endTime = 0.3,
            callback = function()
                PlayerResource:SetCameraTarget(playerId, nil)
                return nil
            end
        })
    end

    for _, unit in pairs(units) do
        if IsValid(unit) and unit:IsAlive() and unit ~= hHero and unit:GetPlayerOwnerID() == playerId and unit:GetUnitName() ~= "npc_dummy_cosmetic_caster" then
            if unit:HasMovementCapability() then
                if unit:HasModifier("modifier_ogre_multicast_lua_bonus") then
                    unit:ForceKill(false)
                else
                    FindClearSpaceForUnit(unit, vLocation, true)
                    if roomName == nil or roomName == "prepare" then
                        if not Features:GetFeatureState(Features.Keys.HeroRefreshingDisabled) then
                            unit:AddNewModifier(hHero, nil, "modifier_hero_refreshing", {})
                        end
                    else
                        unit:RemoveModifierByName("modifier_hero_refreshing")
                    end
                    if isPvpEnd then
                        Util:RefreshAbilityAndItem(unit, {})
                    end
                end
            end
        end
    end
end

---Сбросывает перезарядку умений и предметов у определенного героя.
---@param hUnit CDOTA_BaseNPC?
---@param exceptions table | nil
function Util:RefreshAbilityAndItem(hUnit, exceptions)
    if exceptions == nil then exceptions = {} end

    if not IsValid(hUnit) then return end ---@cast hUnit CDOTA_BaseNPC

    for i = 0, hUnit:GetAbilityCount() - 1 do
        local hAbility = hUnit:GetAbilityByIndex(i)
        if hAbility and hAbility:GetAbilityType() ~= DOTA_ABILITY_TYPE_ATTRIBUTES then
            if exceptions[hAbility:GetAbilityName()] == nil then
                hAbility:RefreshCharges()
                hAbility:EndCooldown()
            end
        end
    end

    for i = DOTA_ITEM_SLOT_1, DOTA_ITEM_NEUTRAL_SLOT do
        if not (i == DOTA_ITEM_TP_SCROLL) then
            local hItem = hUnit:GetItemInSlot(i)
            if hItem then
                hItem:EndCooldown()
                if hItem:GetName() == "item_hand_of_midas_lua" then
                    hItem:SetCurrentCharges(2) --todo поправить костыль
                end
            end
        end
    end

    local neutralItem = hUnit:GetItemInSlot(DOTA_ITEM_NEUTRAL_SLOT)
    if neutralItem ~= nil then neutralItem:EndCooldown() end

    -- Также сбрасываем КД у предметов в кастомном extender_stash (хранятся
    -- в инвентаре скрытого npc_chc_stash_holder, поэтому слотовый цикл выше
    -- их не видит). Делаем только для реальных героев с валидным владельцем.
    if hUnit.IsRealHero and hUnit:IsRealHero() and hUnit.GetPlayerOwnerID then
        local playerId = hUnit:GetPlayerOwnerID()
        if playerId ~= nil and playerId ~= -1
            and ExtenderStash and ExtenderStash.RefreshItemsCooldown then
            ExtenderStash:RefreshItemsCooldown(playerId, exceptions)
        end
    end
end

---Очищает данные последнего PVP
---@param nTeamNumber integer
---@return table
function Util:CleanPvpPair(nTeamNumber)
    local i, max = 1, #PvpModule.PvpPairs
    while i <= max do
        local pair = PvpModule.PvpPairs[i]
        if nTeamNumber == pair.nFirstTeamId or nTeamNumber ==
            pair.nSecondeTeamId then
            table.remove(PvpModule.PvpPairs, i)
            i = i - 1
            max = max - 1
        end
        i = i + 1
    end
    return PvpModule.PvpPairs
end

---Удалить модификаторы движения с героя
---@param hHero CDOTA_BaseNPC_Hero
function Util:RemoveMovemenModifier(hHero)
    hHero:Stop()
    hHero:RemoveModifierByName("modifier_magnataur_skewer_movement")
    hHero:RemoveModifierByName("modifier_phoenix_icarus_dive")
    hHero:RemoveModifierByName("modifier_mirana_leap")
    hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot")
    hHero:RemoveModifierByName("modifier_kunkka_x_marks_the_spot_thinker")
    hHero:RemoveModifierByName("modifier_riki_tricks_of_the_trade_phase")
    hHero:RemoveModifierByName("modifier_monkey_king_bounce_perch")
    hHero:RemoveModifierByName("modifier_void_spirit_dissimilate_phase")
    hHero:RemoveModifierByName("modifier_monkey_king_bounce_leap")
    hHero:RemoveModifierByName("modifier_monkey_king_tree_dance_activity")
    hHero:RemoveModifierByName("modifier_sandking_burrowstrike")
    hHero:RemoveModifierByName("modifier_phantomlancer_dopplewalk_phase")
    hHero:RemoveModifierByName("modifier_life_stealer_infest")
    hHero:RemoveModifierByName("modifier_phoenix_sun_ray")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_in_progress")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster")
    hHero:RemoveModifierByName("modifier_ember_spirit_sleight_of_fist_caster_invulnerability")

    -- False Promise: возврат к фонтану не восстанавливает здоровье
    if hHero:HasModifier("modifier_oracle_false_promise") then
        Timers:CreateTimer(1, function()
            hHero:RemoveModifierByName("modifier_oracle_false_promise")
            return nil
        end)
    end

    hHero:RemoveModifierByName("modifier_brewmaster_primal_split")
    hHero:RemoveModifierByName("modifier_invoker_tornado_lua")
    hHero:RemoveModifierByName("modifier_invoker_tornado")

    if hHero:HasAbility("puck_ethereal_jaunt") then
        hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(false)
        -- Отпустить через 3 секунды
        Timers:CreateTimer({
            endTime = 3,
            callback = function()
                if hHero:HasAbility("puck_ethereal_jaunt") then
                    hHero:FindAbilityByName("puck_ethereal_jaunt"):SetActivated(true)
                end
                return nil
            end
        })
    end

    if hHero:HasModifier("modifier_ember_spirit_fire_remnant_remnant_tracker") then
        hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_timer")
        hHero:RemoveModifierByName("modifier_ember_spirit_fire_remnant_remnant_tracker")
        hHero:AddNewModifier(hHero, hHero:FindAbilityByName("ember_spirit_fire_remnant"),
            "modifier_ember_spirit_fire_remnant_remnant_tracker", {
            })
    end

    if hHero:HasModifier("modifier_weaver_timelapse") then
        hHero:RemoveModifierByName("modifier_weaver_timelapse")
        hHero:AddNewModifier(hHero, hHero:FindAbilityByName("weaver_time_lapse"), "modifier_weaver_timelapse", {})
    end
end

---Зачищает мусор с карты и модификаторы определенных способостей у выбранного героя
---@param hHero CDOTA_BaseNPC
---@param abilityName string
function Util:RemoveAbilityClean(hHero, abilityName)
    logger:Log("removing ability clean")
    local cleanerFunc = abilityCleanerByAbilityName[abilityName]
    if cleanerFunc then
        cleanerFunc(self, hHero)
    end
end

---Удаляет паутину бруды у определенного героя
---@param hUnit CDOTA_BaseNPC
function Util:CleanWeb(hUnit)
    local vWebs = Entities:FindAllByName("npc_dota_broodmother_web")
    for _, hWeb in pairs(vWebs) do
        if hWeb:GetOwner() == hUnit then UTIL_Remove(hWeb) end
    end
end

---Удаляет варды вич доктора у определенного героя
---@param hUnit CDOTA_BaseNPC
function Util:CleanDeathWard(hUnit)
    local vWards = Entities:FindAllByName("npc_dota_witch_doctor_death_ward")
    for _, vWard in pairs(vWards) do ---@cast vWard CDOTA_BaseNPC
        if vWard:GetOwner() == hUnit then
            UTIL_Remove(vWard)
        end
    end
end

---Удаляет гаргулей у определенного героя
---@param hHero CDOTA_BaseNPC
function Util:CleanFamiliar(hHero)
    local vFamiliars = Entities:FindAllByName("npc_dota_visage_familiar")
    for _, hFamiliar in pairs(vFamiliars) do ---@cast hFamiliar CDOTA_BaseNPC
        if hFamiliar:GetOwner() == hHero then
            hFamiliar:ForceKill(false)
        end
    end
end

-- Проверяет готовность перерождения от способности
---@param hUnit CDOTA_BaseNPC
---@return boolean
function Util:CheckReincarnationAbilityReady(hUnit)
    if hUnit:HasAbility("skeleton_king_reincarnation") then
        local hAbility = hUnit:FindAbilityByName("skeleton_king_reincarnation")
        if hAbility and hAbility:GetLevel() > 0 then
            if hAbility:IsCooldownReady() then
                return true
            end
        end
    end

    if hUnit:HasAbility("undying_ceaseless_dirge") then
        local hAbility = hUnit:FindAbilityByName("undying_ceaseless_dirge")
        if hAbility and hAbility:IsCooldownReady() then
            return true
        end
    end

    return false
end

-- Определяет, следует ли иницировать перерождение
---@param hUnit CDOTA_BaseNPC
---@return boolean
function Util:IsReincarnationWork(hUnit)
    local bSkeletonKingReincarnationWork = false
    if hUnit:HasAbility("skeleton_king_reincarnation") then
        local hAbility = hUnit:FindAbilityByName("skeleton_king_reincarnation")
        if hAbility and hAbility:GetLevel() > 0 then
            if hAbility:GetCooldownTimeRemaining() == hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1) then
                bSkeletonKingReincarnationWork = true
            end
        end
    end

    local bUndyingReincarnationWork = false
    if hUnit:HasAbility("undying_ceaseless_dirge") then
        local hAbility = hUnit:FindAbilityByName("undying_ceaseless_dirge")
        if hAbility and hAbility:GetCooldownTimeRemaining() == hAbility:GetEffectiveCooldown(hAbility:GetLevel() - 1) then
            bUndyingReincarnationWork = true
        end
    end

    return bSkeletonKingReincarnationWork or bUndyingReincarnationWork
end

---Возвращает таблицу статистики героя
---@param playerId integer
---@return table
function Util:GenerateHeroInfo(playerId)
    local heroInfo = {}
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if hHero then
        local sAbilities = ""
        if hHero.abilitiesList then
            for _, sAbilityName in ipairs(hHero.abilitiesList) do
                sAbilities = sAbilities .. sAbilityName .. ","
            end
        end

        if string.sub(sAbilities, string.len(sAbilities)) == "," then -- Удалить последнюю запятую
            sAbilities = string.sub(sAbilities, 0, string.len(sAbilities) - 1)
        end

        -- Учитываем ли расходники
        local sItems = ""
        if hHero.sConsumedItems then sItems = hHero.sConsumedItems end

        for i = 0, 20 do -- Перемещение предметов
            local hItem = hHero:GetItemInSlot(i)
            if hItem then sItems = sItems .. hItem:GetName() .. "," end
        end

        if string.sub(sItems, string.len(sItems)) == "," then -- Удалить последнюю запятую
            sItems = string.sub(sItems, 0, string.len(sItems) - 1)
        end

        heroInfo.hero_name = hHero:GetUnitName()
        heroInfo.abilities = sAbilities
        heroInfo.items = sItems
    end

    return heroInfo
end

function CDOTA_BaseNPC:AddEndChannelListener(listener)
    local endChannelListeners = self.EndChannelListeners or {}
    self.EndChannelListeners = endChannelListeners
    local index = #endChannelListeners + 1
    endChannelListeners[index] = listener
end

--- Удаляет обезьян от Wukongs Command
function Util:CleanFurArmySoldier()
    Timers:CreateTimer({
        endTime = 0.5,
        callback = function()
            local units = FindUnitsInRadius(DOTA_TEAM_NEUTRALS,
                Vector(0, 0, 0),
                nil,
                -1,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_ALL,
                DOTA_UNIT_TARGET_FLAG_DEAD + DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES +
                DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD,
                FIND_CLOSEST,
                false)
            for _, hUnit in ipairs(units) do
                if hUnit and not hUnit:IsNull() and (hUnit:HasModifier("modifier_monkey_king_fur_army_soldier") or hUnit:HasModifier("modifier_monkey_king_fur_army_soldier_hidden")) then
                    hUnit:ForceKill(false)
                    UTIL_Remove(hUnit)
                end
            end
            return nil
        end
    })
end

---Зафиксировать факт использования игроком одноразового предмета
---@param playerId integer
---@param itemName string
function Util:RecordConsumableItem(playerId, itemName)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
    if hHero then
        if hHero.sConsumedItems == nil then hHero.sConsumedItems = "" end
        hHero.sConsumedItems = hHero.sConsumedItems .. itemName .. ","
    end
end

function Util:GetBotEarnedGold(nPlayerID)
    local hHero = PlayerResource:GetSelectedHeroEntity(nPlayerID)
    if hHero then
        if GameRulesCustom.gameStartTime then
            local nGold = math.ceil(PlayerResource:GetGoldPerMin(nPlayerID) *
                    (GameRulesCustom:GetGameTime() - GameRulesCustom.gameStartTime) / 60) + 600 -
                PvpModule.TotalBetSum[nPlayerID]
            return nGold
        end
    end
    return 600
end

-- Электронный забор, цикл для определения правильности положения игрока. Если нет, телепортируется.
function Util:InitHeroFence()
    Util.flFenceRadius = 3000
    if GetMapName() == "5v5" then Util.flFenceRadius = 4100 end
end

-- Преобразовать текущее время в читаемую временную метку (в таймстамп?)
---@return string
function Util:GetServerDateTimeStr()
    local strDate = GetSystemDate() .. " " .. GetSystemTime()
    local _, _, m, d, y, hour, min, sec = string.find(strDate, "(%d+)/(%d+)/(%d+)%s*(%d+):(%d+):(%d+)");
    return (y .. m .. d .. hour .. min .. sec)
end

---Расчет перекрестного произведения
---@param p1 any
---@param p2 any
---@return unknown
function Util:GetCross(p1, p2) return p1.x * p2.y - p2.x * p1.y end

function Util:GetDotProduct(p1, p2) return p1.x * p2.x + p1.y * p2.y end

-- Чтобы определить, находится ли точка p внутри прямоугольника, передайте ее по порядку в верхний левый, нижний левый, верхний правый и нижний правый углы.
function Util:IsPointInsideRectangle(p, lu, ld, ru, rd)
    return
        (Util:GetCross(ru - lu, p - lu) * Util:GetCross(ld - rd, p - rd) >= 0) and
        (Util:GetCross(lu - ld, p - ld) * Util:GetCross(rd - ru, p - ru) >=
            0)
end

---comment
---@param hUnit CDOTA_BaseNPC
---@return string
function Util:GetSupposeRoom(hUnit)
    if hUnit == nil then return "prepare" end

    if Util.supposedRooms == nil then
        Util.supposedRooms = {}
        Util.supposedRooms[hUnit:GetPlayerOwnerID()] = "prepare"
    end
    return Util.supposedRooms[hUnit:GetPlayerOwnerID()] or "prepare"
end

---comment
---@param roomName string
---@return unknown
function Util:GetRoomCenter(roomName)
    roomName = roomName or "prepare"
    local suppose_pos = nil
    if roomName == "prepare" then
        suppose_pos = (Entities:FindByName(nil, "prepare")):GetAbsOrigin()
    else
        suppose_pos = (Entities:FindByName(nil, roomName)):GetAbsOrigin()
    end

    return suppose_pos
end

---comment
---@param hUnit any
---@param vPos any
---@return boolean
function Util:IsEscaping(hUnit, vPos)
    vPos = vPos or hUnit:GetAbsOrigin()

    if hUnit:IsRealHero() then
        return not Util:IsInRoom(hUnit, nil, vPos)
    else
        return not (Util:IsInRoom(hUnit, "prepare", vPos) or Util:IsInRoom(hUnit, "center_" .. hUnit:GetTeamNumber(), vPos) or Util:IsInRoom(hUnit, nil, vPos))
    end
end

function Util:IsInRoom(hUnit, sRoomName, vPos)
    sRoomName = sRoomName or Util:GetSupposeRoom(hUnit)
    vPos = vPos or hUnit:GetAbsOrigin()
    local suppose_pos = Util:GetRoomCenter(sRoomName)
    local mapName = GetMapName()
    local RoomWidths = {
        ["1x8"] = {
            center_2 = 1824,
            center_3 = 1824,
            center_4 = 1824,
            center_5 = 1824,
            center_6 = 1824,
            center_7 = 1824,
            center_8 = 1824,
            center_9 = 1824,
            prepare = 2750
        },
        ["2x6"] = {
            enter_2 = 2240,
            center_3 = 2240,
            -- center_4 = 1824,
            -- center_5 = 1824,
            center_6 = 2240,
            center_7 = 2240,
            center_8 = 2240,
            center_9 = 2240,
            prepare = 2600
        },
        ["5v5"] = {
            center_single_pvp = 1792,
            center_2 = 3500,
            center_3 = 3500,
            center_4 = 3640,
            prepare = 3600
        }
    }

    local range = (RoomWidths[mapName][sRoomName] or 1824) * 0.5

    local point_lu = suppose_pos + Vector(-range, range, 0)
    local point_ld = suppose_pos + Vector(-range, -range, 0)
    local point_ru = suppose_pos + Vector(range, range, 0)
    local point_rd = suppose_pos + Vector(range, -range, 0)

    return Util:IsPointInsideRectangle(vPos, point_lu, point_ld, point_ru, point_rd)
end

-- Получите количество оставшихся игроков и удалите игроков, которые сдались.
function Util:GetActivePlayerCount()
    local count = 0
    for i = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        if PlayerResource:IsValidPlayer(i) and PlayerResource:GetConnectionState(i) ~= DOTA_CONNECTION_STATE_ABANDONED then
            count = count + 1
        end
    end
    return count
end

---Получить общие активы (деньги) игрока
---@param playerId integer
---@return integer
function Util:GetTotalGoldForPlayer(playerId)
    if PlayersGold == nil then _G.PlayersGold = {} end
    if PlayersGold[playerId] == nil then PlayersGold[playerId] = 600 end
    return PlayersGold[playerId] or 0
end

-- Получить цель выброса
---@param last_target any
---@param team_number any
---@param position any
---@param radius any
---@param team_filter any
---@param type_filter any
---@param flag_filter any
---@param order any
---@param unit_table any
---@param can_bounce_bounced_unit any
---@return CDOTA_BaseNPC
function Util:GetBounceTarget(
    last_target,
    team_number,
    position,
    radius,
    team_filter,
    type_filter,
    flag_filter,
    order,
    unit_table,
    can_bounce_bounced_unit)
    local first_targets = FindUnitsInRadius(team_number, position, nil, radius, team_filter, type_filter, flag_filter,
        order, false)

    for i = #first_targets, 1, -1 do
        local unit = first_targets[i]
        if unit == last_target then table.remove(first_targets, i) end
    end

    local second_targets = {}
    for k, v in pairs(first_targets) do second_targets[k] = v end

    if unit_table and type(unit_table) == "table" then
        for i = #first_targets, 1, -1 do
            if TableFindKey(unit_table, first_targets[i]) then
                table.remove(first_targets, i)
            end
        end
    end

    local first_target = first_targets[1]
    local second_target = second_targets[1]

    if can_bounce_bounced_unit ~= nil and type(can_bounce_bounced_unit) ==
        "boolean" and can_bounce_bounced_unit == true then
        return first_target or second_target
    else
        return first_target
    end
end

-- Определите, является ли навык дополнительным
---comment
---@param abilityName string
---@return boolean
function Util:IsValidAbility(abilityName)
    return AbilityPool:Contains(abilityName)
end

---Возвращает количество навыков, которые игрок может выбрать
---@param playerId integer
---@return integer
function Util:GetPlayerAbilityCount(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        if hHero.abilitiesList ~= nil then
            return #hHero.abilitiesList
        else
            return 0
        end
    else
        return 6
    end
end

---Возвращает количество дополнительных навыков на панели навыков игрока.
---@param playerId integer
---@return integer
function Util:GetPlayerAbilityCountOnBar(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        local abilitylist = {}
        for i = 0, hHero:GetAbilityCount() - 1 do
            local ability = hHero:GetAbilityByIndex(i)
            if ability ~= nil and (not ability:IsHidden()) and Util:IsValidAbility(ability:GetAbilityName()) and string.find(ability:GetAbilityName(), "special_bonus_") == nil then
                table.insert(abilitylist, { ability_name = ability:GetAbilityName() })
            end
        end
        return #abilitylist
    else
        return 6
    end
end

---Возвращает количество дополнительных навыков на панели навыков игрока.
---@param playerId integer
---@return table
function Util:GetPlayerAllAbility(playerId)
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)

    if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        local abilitylist = {}
        for i = 0, hHero:GetAbilityCount() - 1 do
            local ability = hHero:GetAbilityByIndex(i)
            if ability ~= nil and
                Util:IsValidAbility(ability:GetAbilityName()) and
                string.find(ability:GetAbilityName(), "special_bonus_") == nil then
                table.insert(abilitylist, ability:GetAbilityName())
            end
        end
        return abilitylist
    else
        return {}
    end
end

---Возвращает текущий уровень дополнительной награды за игрока
---@param playerId integer
---@return integer
function Util:GetPlayerBonusGoldPercentage(playerId)
    local pct = 0
    local hHero = PlayerResource:GetSelectedHeroEntity(playerId)
    if IsValid(hHero) then ---@cast hHero CDOTA_BaseNPC_Hero
        if hHero:HasModifier("modifier_relief_fund") then
            local stack = hHero:FindModifierByName("modifier_relief_fund"):GetStackCount() or 0
            pct = pct + stack * 8
        end
    end
    return pct
end

---Определить, входит ли навык в пул навыков
---@param abilityName string
---@return boolean
function Util:IsAbilityInPool(abilityName)
    return AbilityPool:Contains(abilityName)
end

---Возвращает SteamId игрока
---@param playerId integer
---@return string
function GetSteamID(playerId)
    local playerSteamId = tostring(PlayerResource:GetSteamAccountID(playerId))
    if playerSteamId == "0" then
        playerSteamId = tostring(80000000 + playerId)
    end
    return playerSteamId
end

---@param func fun(playerId: PlayerID)
---@param skipFake boolean|nil
---@param allowInvalid boolean|nil
function ForEachPlayer(func, skipFake, allowInvalid)
    for playerId = 0, CHC_MAX_PLAYER_COUNT - 1 do
        if (allowInvalid or PlayerResource:IsValidPlayer(playerId))
            and not (skipFake and PlayerResource:IsFakeClient(playerId))
        then
            func(playerId)
        end
    end
end