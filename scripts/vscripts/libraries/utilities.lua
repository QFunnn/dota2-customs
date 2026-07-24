--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


for _, listener_id in ipairs(registered_game_events_listeners or {}) do
	StopListeningToGameEvent(listener_id)
end

registered_game_events_listeners = {}

function RegisterGameEventListener(event_name, callback)
	local listener_id = ListenToGameEvent(event_name, callback, nil)
	table.insert(registered_game_events_listeners, listener_id)
end


function DisplayError(player_id, message)
	local player = PlayerResource:GetPlayer(player_id)
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error", { message = message })
	end
end


function toboolean(value)
	if not value then return value end
	local val_type = type(value)
	if val_type == "boolean" then return value end
	if val_type == "number"	then return value ~= 0 end
	if val_type == "string" then return string.len(value) > 0 end
	-- return true for anything we can't explicitly measure
	return true
end


--- Verifies validity of passed player id
---@param player_id number
---@return boolean
function IsValidPlayerID(player_id)
	return player_id ~= nil and PlayerResource:IsValidPlayerID(player_id)
end


function DebugMessage(...)
	-- we have to convert all arguments that aren't strings or numbers, cause table.concat doesn't handle other types
	-- arg is reserved internal name to reference ...
	local args = {...}
	for i, argument in pairs(args) do
		local arg_type = type(argument)
		if arg_type == "table" then
			args[i] = table.to_string(argument)
		elseif arg_type ~= "string" and arg_type ~= "number" then
			args[i] = tostring(argument) or ""
		end
	end

	local message = table.concat({"[DEBUG]", unpack(args)}, " ")

	print(message)
	CustomGameEventManager:Send_ServerToAllClients("server_print", { message = message })
end


function GetHeroNameByID(hero_id)
	local hero_name = DOTAGameManager:GetHeroNameByID(hero_id)

	if not hero_name then return end

	return "npc_dota_hero_" .. hero_name
end

-- after minute 5 creep abilities are leveled to 2 on creep ability being obtained
-- after 10 - to 3
local creep_ability_level_from_time = {
	{5 * 60, 2},
	{10 * 60, 3},
}

function GetCreepAbilityLevel()
	local current_time = GameRules:GetGameTime()

	for _, level_data in ipairs_rev(creep_ability_level_from_time) do
		if current_time >= level_data[1] then return level_data[2] end
	end

	return 1
end


--- Lookup of (possible) hero from which illusion was created
--- simple search by unit name, and won't work for games that allow same-hero
---@param illusion any
function GetIllusionSource(illusion)
	local unit_name = illusion:GetUnitName()
	local _, hero = table.find_element(GameLoop.hero_by_player_id, function(t, k, v) return v:GetUnitName() == unit_name end)
	return hero
end

--- Checks if date_2 is after date_1
---@param date_1 any
---@param date_2 any
function DateOlder(date_1, date_2)
	local m1, d1, y1 = unpack(string.split(date_1, "/"))
	local m2, d2, y2 = unpack(string.split(date_2, "/"))

	-- print(m1, d1, y1)
	-- print(m2, d2, y2)

	if y2 > y1 then
		return true
	elseif y2 < y1 then
		return false
	end

	if m2 > m1 then
		return true
	elseif m2 < m1 then
		return false
	end

	if d2 >= d1 then
		return true
	elseif d2 < d1 then
		return false
	end

	return false
end