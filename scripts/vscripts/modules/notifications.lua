--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if Notifications == nil then
	Notifications = class({})
end

function Notifications:Init()
    print('[Notifications] Module is active!')

    self.bStarted = true

    -- ID уведомлений
    self.CurrentID = 0

    -- Глобальный список уведомлений
    self.GlobalNotifications = {}

    -- Личные уведомления игроков
    self.PlayersNotifications = {}

    -- Очередь, для оптимизации отправки данных
    self.Schedule = {}

    -- Создание юнита и таймера на нём
    self.TimerEnt = Entities:CreateByClassname("info_target")
    self.TimerEnt:SetThink("ScheduleThink", self, "NOTIFICATIONS_THINK", 0)
end

function Notifications:ScheduleThink()
    local DataTable = {}
    
    local limit = 0
    local bHasData = false
    while true do
        local NotificationInfo = self.Schedule[1]
        if NotificationInfo == nil then break end
        bHasData = true

        local KeyName = NotificationInfo.PlayerID == nil and "global_notification_" or "player_"..NotificationInfo.PlayerID.."_notification_"

        DataTable[KeyName..NotificationInfo.ID] = NotificationInfo

        table.remove(self.Schedule, 1)

        limit = limit + 1
        if limit >= 10 then
            break
        end
    end

    if bHasData then
        PlayerTables:SetTableValues("notifications", DataTable)
    end

    return 0.1
end

-- Добавляет уведомление в список либо сразу всем, либо указанному игроку
function Notifications:AddNotification(nType, nRound, hValues, PlayerID)

    if not GAME_NOTIFICATIONS_ENABLED then return end

    -- Определяем куда будем заносить оповещение, в глобальный список или локальный список игрока
    local Container = self.GlobalNotifications
    if PlayerID ~= nil then
        if self.PlayersNotifications[PlayerID] == nil then
            self.PlayersNotifications[PlayerID] = {}
        end
        Container = self.PlayersNotifications[PlayerID]
    end

    -- Увеличиваем текущий ID
    self.CurrentID = self.CurrentID + 1

    -- Данные о уведомлении
    local Data = {
        ID = self.CurrentID,
        type = nType,
        round = nRound,
        values = hValues,
        PlayerID = PlayerID,
    }

    -- Заносим в контейнер уведомление
    table.insert(Container, Data)

    -- Заносим уведомление в очередь
    table.insert(self.Schedule, Data)

    -- -- Обновляем NetTables
    -- if PlayerID ~= nil then
    --     PlayerTables:SetTableValue("notifications", "player_"..PlayerID.."_notification_"..self.CurrentID, Data)
    -- else
    --     PlayerTables:SetTableValue("notifications", "global_notification_"..self.CurrentID, Data)
    -- end
end

function Notifications:ClearNotifications()
    local KeysToDelete = {}
    for _, NotificationInfo in ipairs(self.GlobalNotifications) do
        table.insert(KeysToDelete, "global_notification_"..NotificationInfo.ID)
    end
    for _, NotificationInfo in ipairs(self.PlayersNotifications) do
        table.insert(KeysToDelete, "player_"..NotificationInfo.PlayerID.."_notification_"..NotificationInfo.ID)
    end
    PlayerTables:DeleteTableKeys("notifications", KeysToDelete)
end

if not Notifications.bStarted then Notifications:Init() end