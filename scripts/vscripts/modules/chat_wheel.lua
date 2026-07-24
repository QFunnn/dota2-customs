--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if ChatWheel == nil then
	ChatWheel = class({})
end

function ChatWheel:Init()
    print('[ChatWheel] Module is active!')
    self.bStarted = true

    self.Players = {}

    CustomGameEventManager:RegisterListener("chat_wheel_item_selected", function(source, event) self:OnPlayerSelectedItem(event) end)
    CustomGameEventManager:RegisterListener("chat_wheel_line_selected", function(source, event) self:OnPlayerSelectedLine(event) end)

    CustomGameEventManager:RegisterListener("chat_wheel_mute_player", function(source, event) self:OnPlayerWantMuteOtherPlayer(event) end)
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
    self.Players[PlayerID].Mutes = {}

    PlayerTables:SetTableValue("player_"..PlayerID, "chat_wheel", self.Players[PlayerID].ChatWheel)

    PlayerTables:SetTableValue("player_"..PlayerID, "mutes", self.Players[PlayerID].Mutes)
end

function ChatWheel:OnPlayerSelectedItem(event)
    local PlayerID = event.PlayerID

    if self.Players[PlayerID] == nil then return end

    local ItemName = event.item_name
    local LineID = tonumber(event.line_id)

    if ItemName == nil or LineID == nil then return end

    if CHAT_WHEEL_LIST[ItemName] == nil then return end

    local ItemInfo = CHAT_WHEEL_LIST[ItemName]

    if ItemInfo.free == false and not Server:PlayerHasItem(PlayerID, ItemName) then return end

    self.Players[PlayerID].ChatWheel[LineID] = ItemName

    PlayerTables:SetTableValue("player_"..PlayerID, "chat_wheel", self.Players[PlayerID].ChatWheel)

    Server:RecordChatWheelChanges(PlayerID, LineID, ItemName)
end

function ChatWheel:OnPlayerSelectedLine(event)
    local PlayerID = event.PlayerID

    if self.Players[PlayerID] == nil then return end

    local LineID = tonumber(event.line_id)

    if LineID == nil then return end

    if self.Players[PlayerID].ChatWheel[LineID] == nil or self.Players[PlayerID].ChatWheel[LineID] == "" then
        return
    end

    local ItemName = self.Players[PlayerID].ChatWheel[LineID]

    if CHAT_WHEEL_LIST[ItemName] == nil then return end

    local ItemInfo = CHAT_WHEEL_LIST[ItemName]

    if ItemInfo.free == false and not Server:PlayerHasItem(PlayerID, ItemName) then return end

    local ChatWheelCooldown = self:GetCooldownInfo(PlayerID)
    if ChatWheelCooldown then
        if ChatWheelCooldown.free_charges > 0 then
            self:StartChargeCooldown(PlayerID)
            -- if ItemInfo.ForAll == true then
                CustomGameEventManager:Send_ServerToAllClients("chat_wheel_say_line", {caller_player = PlayerID, item_name = ItemName})
            -- else
            --     local Team = PlayerResource:GetTeam(PlayerID)
            --     CustomGameEventManager:Send_ServerToTeam(Team, "chat_wheel_say_line", {caller_player = PlayerID, item_name = ItemName})
            -- end
        else
            SendErrorToPlayer(PlayerID, "#PLAYER_HUD_Error_Tip_Cooldown")
        end
    end
end

function ChatWheel:OnPlayerWantMuteOtherPlayer(event)
    local PlayerID = event.PlayerID
    local MutedPlayerID = event.MutedPlayerID

    if self.Players[PlayerID] == nil then return end

    if self.Players[PlayerID].Mutes[MutedPlayerID] then
        self.Players[PlayerID].Mutes[MutedPlayerID] = false
    else
        self.Players[PlayerID].Mutes[MutedPlayerID] = true
    end

    PlayerTables:SetTableValue("player_"..PlayerID, "mutes", self.Players[PlayerID].Mutes)
end

function ChatWheel:StartChargeCooldown(PlayerID)
    if self.Players[PlayerID] == nil then return end

    table.insert(self.Players[PlayerID].Cooldown, GameRules:GetGameTime()+CHAT_WHEEL_COOLDOWN)
end

function ChatWheel:GetCooldownInfo(PlayerID)
    if self.Players[PlayerID] == nil then return nil end
    
    local CloseCooldown = 0

    if #self.Players[PlayerID].Cooldown > 0 then
        for i = #self.Players[PlayerID].Cooldown, 1, -1 do
            if GameRules:GetGameTime() >=  self.Players[PlayerID].Cooldown[i] then
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