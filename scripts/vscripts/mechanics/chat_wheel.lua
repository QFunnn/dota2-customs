--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if ChatWheel == nil then
    ChatWheel = class({}) ---@class ChatWheel
end

CHAT_WHEEL_COOLDOWN = 30
CHAT_WHEEL_MAX_BEFORE_COOLDOWN = 2

function ChatWheel:Init()
    self.bStarted = true

    self.Players = {}

    CustomNetTables:SetTableValue("chat_wheel", "list", CHAT_WHEEL_LIST)

    -- GameListener:SubscribeProtected("chat_wheel_item_selected", function(event)
    --     self:OnPlayerSelectedItem(event)
    -- end)
    -- GameListener:SubscribeProtected("chat_wheel_line_selected", function(event)
    --     self:OnPlayerSelectedLine(event)
    -- end)
end

function ChatWheel:LoadPlayer(PlayerID, ChatWheelTable)
    if self.Players[PlayerID] == nil then
        self.Players[PlayerID] = {}
    end

    local NormalTable = {}
    for LineID, ItemName in pairs(ChatWheelTable) do
        local LID = tonumber(LineID)
        if LID ~= nil then
            NormalTable[LID] = ItemName
        end
    end

    self.Players[PlayerID].ChatWheel = NormalTable
    self.Players[PlayerID].Cooldown = {}

    CustomNetTables:SetTableValue("chat_wheel", tostring(PlayerID), self.Players[PlayerID].ChatWheel)
end

function ChatWheel:OnPlayerSelectedItem(event)
    PrintTable(event)
    local PlayerID = tonumber(event.PlayerID)
    if PlayerID == nil or PlayerID < 0 then
        return
    end

    if self.Players[PlayerID] == nil then
        self.Players[PlayerID] = { ChatWheel = {}, Cooldown = {} }
    end

    local ItemName = event.item_name
    local LineID = tonumber(event.line_id)

    if ItemName == nil or LineID == nil then
        logger:Log("ItemName == nil or LineID == nil")
        return
    end

    if CHAT_WHEEL_LIST[ItemName] == nil then
        logger:Log("CHAT_WHEEL_LIST[ItemName] == nil")
        return
    end

    local canUseItem = false
    if Shop and Shop.CanPlayerUseChatWheelItem then
        canUseItem = Shop:CanPlayerUseChatWheelItem(PlayerID, ItemName)
    else
        local chatInfo = CHAT_WHEEL_LIST[ItemName]
        canUseItem = chatInfo and (chatInfo.free == true or chatInfo.free == 1) or false
    end

    if not canUseItem then
        logger:Log(string.format("Player %s tried to set locked chat wheel item '%s'", tostring(PlayerID),
            tostring(ItemName)))
        return
    end

    self.Players[PlayerID].ChatWheel[LineID] = ItemName

    CustomNetTables:SetTableValue("chat_wheel", tostring(PlayerID), self.Players[PlayerID].ChatWheel)

    -- Server:RecordChatWheelChanges(PlayerID, LineID, ItemName)
end

function ChatWheel:OnPlayerSelectedLine(event)
    local PlayerID = tonumber(event.PlayerID)
    if PlayerID == nil or PlayerID < 0 then return end

    if self.Players[PlayerID] == nil then return end

    local lineID = tonumber(event.line_id)

    if lineID == nil then return end

    if self.Players[PlayerID].ChatWheel[lineID] == nil or self.Players[PlayerID].ChatWheel[lineID] == "" then
        return
    end

    local itemName = self.Players[PlayerID].ChatWheel[lineID]

    if CHAT_WHEEL_LIST[itemName] == nil then return end
    local canUseItem = false
    if Shop and Shop.CanPlayerUseChatWheelItem then
        canUseItem = Shop:CanPlayerUseChatWheelItem(PlayerID, itemName)
    else
        local chatInfo = CHAT_WHEEL_LIST[itemName]
        canUseItem = chatInfo and (chatInfo.free == true or chatInfo.free == 1) or false
    end

    if not canUseItem then
        return
    end

    local chatWheelCooldown = self:GetCooldownInfo(PlayerID)
    if chatWheelCooldown then
        if chatWheelCooldown.free_charges > 0 then
            self:StartChargeCooldown(PlayerID)
            CustomGameEventManager:Send_ServerToAllClients("chat_wheel_say_line", {
                caller_player = PlayerID,
                item_name = itemName
            })
        else
            local player = PlayerResource:GetPlayer(PlayerID)
            if not player then return end
            CustomGameEventManager:Send_ServerToPlayer(player, "SendHudError", {
                message = "PLAYER_HUD_Error_Tip_Cooldown"
            })
        end
    end
end

---@param PlayerID number
function ChatWheel:StartChargeCooldown(PlayerID)
    if self.Players[PlayerID] == nil then return end

    table.insert(self.Players[PlayerID].Cooldown, GameRules:GetGameTime() + CHAT_WHEEL_COOLDOWN)
end

function ChatWheel:GetCooldownInfo(PlayerID)
    if self.Players[PlayerID] == nil then return nil end

    local CloseCooldown = 0

    if #self.Players[PlayerID].Cooldown > 0 then
        for i = #self.Players[PlayerID].Cooldown, 1, -1 do
            if GameRules:GetGameTime() >= self.Players[PlayerID].Cooldown[i] then
                table.remove(self.Players[PlayerID].Cooldown, i)
            end
        end
        table.sort(self.Players[PlayerID].Cooldown)

        CloseCooldown = self.Players[PlayerID].Cooldown[1]
    end

    local FreeCharges = CHAT_WHEEL_MAX_BEFORE_COOLDOWN - #self.Players[PlayerID].Cooldown

    local Info = {
        free_charges = FreeCharges,
        close_cooldown = CloseCooldown,
    }

    return Info
end

if not ChatWheel.bStarted then ChatWheel:Init() end