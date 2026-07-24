--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


if not CustomTables then
    _G.CustomTables = class({})
    CustomTables.TableData = {}
    CustomTables.LastSentTableData = {}
    CustomTables.DebugSentEnable = false
    CustomTables.DebugHowMuchTablesUpdated = {}
    CustomTables.DebugDisableEvents = false
    CustomTables.AutoUpdateSendDelay = 0.1
    CustomTables.DebugDisableEventsList = {}
    CustomTables.TablesAutoUpdate =
    {
        ["health_data"] = 0.1,
        ["currency_data"] = 0.25,

        ["damage_stats"] = 3,
        ["economy_stats"] = 3,
        ["player_stats"] = 2,
        ["ultimate_state"] = 2,
        ["player_cards_data"] = 2,
        ["neutral_roshan_state"] = 1,
    }
    CustomTables.TablesForPlayer =
    {
        ["abilities_cost"] = true,
        ["artefact_state"] = true,
        ["ultimate_state"] = true,
        ["currency_data"] = true,
        ["player_stats"] = true,
        ["player_cards_data"] = true,
        ["black_store_data"] = true,
        ["detail_player_stats"] = true,
        ["player_settings"] = true,
        ["services_player"] = true,
        ["afk_mode_state"] = true,
        ["infinity_mode_best"] = true,
    }
    CustomTables.IgnoreOrder =
    {
        ["detail_player_stats"] = true,
        ["health_data"] = true,
        ["services_player"] = true,
    }
    CustomTables.DeleteMarkerKey = "__custom_table_delete"
end

function CustomTables:Init()
    CustomGameEventManager:RegisterListener("event_game_request_custom_tables", Dynamic_Wrap(self, "OnRequestCustomTables"))
    self:InitAutoUpdater()
    if CustomTables.DebugSentEnable then
        Timers:CreateTimer(1, function()
            local data = CustomTables.DebugHowMuchTablesUpdated
            local count = #data
            CustomGameEventManager:Send_ServerToAllClients("event_update_debug_tables", data)
            CustomTables.DebugHowMuchTablesUpdated = {}
            return 1
        end)
    end
end

function CustomTables:SendTableValueToAllClients(stringTableName, stringKeyName, script_tableValue)
    if CustomTables.DebugDisableEvents then return end
    if CustomTables.DebugDisableEventsList[stringTableName] then return end
    self.LastSentTableData = self.LastSentTableData or {}
    self.LastSentTableData[stringTableName] = self.LastSentTableData[stringTableName] or {}
    local last_value = self.LastSentTableData[stringTableName][stringKeyName]
    if last_value ~= nil and table.deep_equal(last_value, script_tableValue) then
        return false
    end
    local payload_snapshot = table.deepcopy(script_tableValue)
    local payload_patch = self:BuildTablePatch(last_value, payload_snapshot)
    if payload_patch == nil then
        return false
    end
    local is_for_player = nil
    if CustomTables.TablesForPlayer[stringTableName] then
        is_for_player = PlayerResource:GetPlayer(tonumber(stringKeyName))
    end
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_INIT then
        Timers:CreateTimer(0.1, function()
            if GameRules:State_Get() == DOTA_GAMERULES_STATE_INIT then
                return 0.1
            end
            local delayed_last_value = self.LastSentTableData[stringTableName] and self.LastSentTableData[stringTableName][stringKeyName] or nil
            local delayed_payload_patch = self:BuildTablePatch(delayed_last_value, payload_snapshot)
            if delayed_payload_patch == nil then
                return nil
            end
            if is_for_player then
                CustomGameEventManager:Send_ServerToPlayer(is_for_player, "game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = delayed_payload_patch})
            else
                CustomGameEventManager:Send_ServerToAllClients("game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = delayed_payload_patch})
            end
            --table.insert(CustomTables.DebugHowMuchTablesUpdated, stringTableName .. " " .. stringKeyName)
            self.LastSentTableData[stringTableName][stringKeyName] = table.deepcopy(payload_snapshot)
            return nil
        end)
    else
        if is_for_player then
            CustomGameEventManager:Send_ServerToPlayer(is_for_player, "game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = payload_patch})
        else
            CustomGameEventManager:Send_ServerToAllClients("game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = payload_patch})
        end
        --table.insert(CustomTables.DebugHowMuchTablesUpdated, stringTableName .. " " .. stringKeyName)
        self.LastSentTableData[stringTableName][stringKeyName] = table.deepcopy(payload_snapshot)
    end
    return true
end

function CustomTables:SendTablePatchToAllClients(stringTableName, stringKeyName, patch_data, full_value)
    if CustomTables.DebugDisableEvents then return end
    if CustomTables.DebugDisableEventsList[stringTableName] then return end
    if patch_data == nil then return false end

    self.LastSentTableData = self.LastSentTableData or {}
    self.LastSentTableData[stringTableName] = self.LastSentTableData[stringTableName] or {}

    local full_snapshot = table.deepcopy(full_value)
    local payload_patch = table.deepcopy(patch_data)
    local is_for_player = nil
    if CustomTables.TablesForPlayer[stringTableName] then
        is_for_player = PlayerResource:GetPlayer(tonumber(stringKeyName))
    end

    if is_for_player then
        CustomGameEventManager:Send_ServerToPlayer(is_for_player, "game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = payload_patch})
    else
        CustomGameEventManager:Send_ServerToAllClients("game_event_update_custom_tables", {table_name = stringTableName, key = stringKeyName, data = payload_patch})
    end

    --table.insert(CustomTables.DebugHowMuchTablesUpdated, stringTableName .. " " .. stringKeyName)
    self.LastSentTableData[stringTableName][stringKeyName] = full_snapshot
    return true
end

function CustomTables:GetDeleteMarker()
    local marker = {}
    marker[self.DeleteMarkerKey or "__custom_table_delete"] = true
    return marker
end

function CustomTables:IsDeleteMarker(value)
    return type(value) == "table" and value[self.DeleteMarkerKey or "__custom_table_delete"] == true
end

function CustomTables:BuildNormalizedKeyIndex(value)
    local result = {}
    if type(value) ~= "table" then return result end

    for key, _ in pairs(value) do
        result[tostring(key)] = key
    end

    return result
end

function CustomTables:BuildTablePatch(old_value, new_value)
    if new_value == nil then
        if old_value == nil then return nil end
        return self:GetDeleteMarker()
    end

    if old_value == nil then
        return table.deepcopy(new_value)
    end

    if type(old_value) ~= "table" or type(new_value) ~= "table" then
        if old_value == new_value then return nil end
        return table.deepcopy(new_value)
    end

    local patch = {}
    local has_changes = false
    local old_key_index = self:BuildNormalizedKeyIndex(old_value)
    local new_key_index = self:BuildNormalizedKeyIndex(new_value)

    for key, value in pairs(new_value) do
        local normalized_key = tostring(key)
        local old_key = old_key_index[normalized_key]
        local old_child_value = nil
        if old_key ~= nil then
            old_child_value = old_value[old_key]
        end
        local child_patch = self:BuildTablePatch(old_child_value, value)
        if child_patch ~= nil then
            patch[normalized_key] = child_patch
            has_changes = true
        end
    end

    for key, _ in pairs(old_value) do
        local normalized_key = tostring(key)
        if new_key_index[normalized_key] == nil then
            patch[normalized_key] = self:GetDeleteMarker()
            has_changes = true
        end
    end

    if not has_changes then return nil end
    return patch
end

function CustomTables:ApplyTablePatch(target, patch)
    if type(patch) ~= "table" then
        return table.deepcopy(patch)
    end

    if self:IsDeleteMarker(patch) then
        return nil
    end

    local result = type(target) == "table" and target or {}
    for key, value in pairs(patch) do
        local normalized_key = tostring(key)
        if self:IsDeleteMarker(value) then
            result[normalized_key] = nil
        else
            result[normalized_key] = self:ApplyTablePatch(result[normalized_key], value)
        end
    end
    return result
end

function CustomTables:MergePatchData(target_patch, patch_data)
    if type(patch_data) ~= "table" or self:IsDeleteMarker(patch_data) then
        return table.deepcopy(patch_data)
    end

    local result = type(target_patch) == "table" and target_patch or {}
    for key, value in pairs(patch_data) do
        local normalized_key = tostring(key)
        if self:IsDeleteMarker(value) then
            result[normalized_key] = table.deepcopy(value)
        elseif type(value) == "table" then
            result[normalized_key] = self:MergePatchData(result[normalized_key], value)
        else
            result[normalized_key] = value
        end
    end
    return result
end

function CustomTables:AccumulatePendingPatch(stringTableName, stringKeyName, patch_data)
    self.PendingPatchData = self.PendingPatchData or {}
    self.PendingPatchData[stringTableName] = self.PendingPatchData[stringTableName] or {}
    local current_patch = self.PendingPatchData[stringTableName][stringKeyName] or {}
    self.PendingPatchData[stringTableName][stringKeyName] = self:MergePatchData(current_patch, patch_data) or {}
end

function CustomTables:MarkTableValueDirty(stringTableName, stringKeyName)
    self.DirtyTableData = self.DirtyTableData or {}
    self.DirtyTableData[stringTableName] = self.DirtyTableData[stringTableName] or {}
    self.DirtyTableData[stringTableName][stringKeyName] = true
end

function CustomTables:EnqueueAutoUpdateValue(stringTableName, stringKeyName)
    if self.IgnoreOrder and self.IgnoreOrder[stringTableName] then
        local table_data = self.TableData and self.TableData[stringTableName] or nil
        local value = table_data and table_data[stringKeyName] or nil
        return self:SendTableValueToAllClients(stringTableName, stringKeyName, value)
    end
    self.AutoUpdateQueue = self.AutoUpdateQueue or {}
    self.AutoUpdateQueuedKeys = self.AutoUpdateQueuedKeys or {}
    self.AutoUpdateQueuedKeys[stringTableName] = self.AutoUpdateQueuedKeys[stringTableName] or {}
    if self.AutoUpdateQueuedKeys[stringTableName][stringKeyName] then return false end
    self.AutoUpdateQueuedKeys[stringTableName][stringKeyName] = true
    table.insert(self.AutoUpdateQueue, {table_name = stringTableName, key_name = stringKeyName})
    return true
end

function CustomTables:StartAutoUpdateQueueProcessor()
    if self._auto_update_queue_processor_initialized then return end
    self._auto_update_queue_processor_initialized = true
    local send_delay = self.AutoUpdateSendDelay
    Timers:CreateTimer(send_delay, function()
        local queue = self.AutoUpdateQueue or {}
        local queued_keys = self.AutoUpdateQueuedKeys or {}
        local item = table.remove(queue, 1)
        if item then
            if queued_keys[item.table_name] then
                queued_keys[item.table_name][item.key_name] = nil
            end
            local table_data = self.TableData and self.TableData[item.table_name] or nil
            local value = table_data and table_data[item.key_name] or nil
            local pending_patch = self.PendingPatchData and self.PendingPatchData[item.table_name] and self.PendingPatchData[item.table_name][item.key_name] or nil
            if pending_patch ~= nil then
                self.PendingPatchData[item.table_name][item.key_name] = nil
                self:SendTablePatchToAllClients(item.table_name, item.key_name, pending_patch, value)
            else
                self:SendTableValueToAllClients(item.table_name, item.key_name, value)
            end
        end
        return send_delay
    end)
end

function CustomTables:FlushAutoUpdateTable(stringTableName)
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_INIT then return end
    local dirty_table = self.DirtyTableData and self.DirtyTableData[stringTableName] or nil
    local table_data = self.TableData and self.TableData[stringTableName] or nil
    if not dirty_table or not table_data then return end
    local dirty_keys = {}
    for key_name, _ in pairs(dirty_table) do
        table.insert(dirty_keys, key_name)
    end
    table.sort(dirty_keys, function(a, b)
        local number_a = tonumber(a)
        local number_b = tonumber(b)
        if number_a and number_b then
            return number_a < number_b
        end
        return tostring(a) < tostring(b)
    end)
    for _, key_name in ipairs(dirty_keys) do
        local value = table_data[key_name]
        self:EnqueueAutoUpdateValue(stringTableName, key_name)
        dirty_table[key_name] = nil
    end
end

function CustomTables:InitAutoUpdater()
    if self._auto_updater_initialized then return end
    self._auto_updater_initialized = true
    self.DirtyTableData = self.DirtyTableData or {}
    self.AutoUpdateQueue = self.AutoUpdateQueue or {}
    self.AutoUpdateQueuedKeys = self.AutoUpdateQueuedKeys or {}
    self:StartAutoUpdateQueueProcessor()
    for table_name, interval in pairs(self.TablesAutoUpdate or {}) do
        local auto_table_name = table_name
        local update_interval = interval
        self.DirtyTableData[auto_table_name] = self.DirtyTableData[auto_table_name] or {}
        Timers:CreateTimer(update_interval, function()
            self:FlushAutoUpdateTable(auto_table_name)
            return update_interval
        end)
    end
end

function CustomTables:SetTableValue(stringTableName, stringKeyName, script_tableValue, fast_update)
    if not CustomTables.TableData[stringTableName] then
        CustomTables.TableData[stringTableName] = {}
    end
    if script_tableValue ~= nil and not CustomTables.TableData[stringTableName][stringKeyName] then
        CustomTables.TableData[stringTableName][stringKeyName] = {}
    end
    CustomTables.TableData[stringTableName][stringKeyName] = script_tableValue
    if self.TablesAutoUpdate and self.TablesAutoUpdate[stringTableName] and not fast_update then
        self:MarkTableValueDirty(stringTableName, stringKeyName)
        return
    end
    self:SendTableValueToAllClients(stringTableName, stringKeyName, script_tableValue)
end

function CustomTables:SetTablePatchValue(stringTableName, stringKeyName, patch_data, fast_update)
    if patch_data == nil then return false end
    if not CustomTables.TableData[stringTableName] then
        CustomTables.TableData[stringTableName] = {}
    end

    CustomTables.TableData[stringTableName][stringKeyName] = self:ApplyTablePatch(CustomTables.TableData[stringTableName][stringKeyName], patch_data) or {}
    if self.TablesAutoUpdate and self.TablesAutoUpdate[stringTableName] and not fast_update then
        self:AccumulatePendingPatch(stringTableName, stringKeyName, patch_data)
        self:MarkTableValueDirty(stringTableName, stringKeyName)
        return true
    end
    return self:SendTablePatchToAllClients(stringTableName, stringKeyName, patch_data, CustomTables.TableData[stringTableName][stringKeyName])
end

function CustomTables:GetTableValue(stringTableName, stringKeyName)
    return (CustomTables.TableData[stringTableName] and CustomTables.TableData[stringTableName][stringKeyName]) and CustomTables.TableData[stringTableName][stringKeyName] or {}
end

function CustomTables:OnRequestCustomTables(data)
    local player_id = data.PlayerID
    local player = PlayerResource:GetPlayer(player_id)
    for table_name, key in pairs(CustomTables.TableData) do
        for key_name, value in pairs(key) do
            if not CustomTables.TablesForPlayer[table_name] or tostring(key_name) == tostring(player_id) then
                CustomGameEventManager:Send_ServerToPlayer(player, "game_event_update_custom_tables", {table_name = table_name, key = key_name, data = value, full = true})
            end
        end
    end
end

CustomTables:Init()