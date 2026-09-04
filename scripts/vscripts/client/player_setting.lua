--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local EMPTY_SETTING = {}
local currentSetting = {}
local function getPlayerSettingKey(self, playerId)
	return "custom_settings_" .. tostring(playerId)
end
local function normalizeSetting(self, raw)
	if raw == nil or type(raw) ~= "table" then
		return {}
	end
	return raw
end
local function refreshSettingFromNetTable(self)
	local playerId = GetLocalPlayerID()
	if playerId == nil or playerId < 0 then
		currentSetting = {}
		return
	end
	local key = getPlayerSettingKey(nil, playerId)
	currentSetting = normalizeSetting(nil, CustomNetTables:GetTableValue("custom_value", key))
end
--- 获取当前玩家设置快照（只读语义）
function ____exports.getPlayerSetting(self)
	refreshSettingFromNetTable(nil)
	return currentSetting or EMPTY_SETTING
end
--- 便捷读取布尔设置
function ____exports.getPlayerSettingBoolean(self, key, defaultValue)
	refreshSettingFromNetTable(nil)
	local value = currentSetting[key]
	if value == nil then
		return defaultValue
	end
	return value == true or value == 1 or value == "1"
end
--- 便捷读取数值设置
function ____exports.getPlayerSettingNumber(self, key, defaultValue)
	refreshSettingFromNetTable(nil)
	local value = currentSetting[key]
	if value == nil or type(value) ~= "number" then
		return defaultValue
	end
	return value
end
--- 便捷读取文本设置
function ____exports.getPlayerSettingString(self, key, defaultValue)
	refreshSettingFromNetTable(nil)
	local value = currentSetting[key]
	if value == nil or type(value) ~= "string" then
		return defaultValue
	end
	return value
end
refreshSettingFromNetTable(nil)
return ____exports