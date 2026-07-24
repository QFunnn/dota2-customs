--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


SeasonalEvents = SeasonalEvents or {}

function SeasonalEvents:Init()
	SeasonalEvents._halloween_dates = {
		["10/27/22"] = true, -- just in case of US timezone things
		["10/28/22"] = true,
		["10/29/22"] = true,
		["10/30/22"] = true,
	}

	SeasonalEvents._christmas_dates = {
		["12/23/22"] = true, -- Friday
		["12/24/22"] = true, -- Saturday
		["12/25/22"] = true, -- Sunday
		["12/26/22"] = true, -- Monday, for extended fun
	}

	-- populated from before-match response
	SeasonalEvents._first_weekends_dates = {}

	EventStream:Listen("SeasonalEvents:get_events", SeasonalEvents.SendEvents, SeasonalEvents)
end


--- Parses and saves first weekend dates of this month to verify current dedicated server date to
--- And activate epic events if needed
---@param input_dates string[] @ input dates - list of strings formatted as 2023-01-30 (yyyy-mm-dd)
function SeasonalEvents:SetFirstWeekends(input_dates)
	-- GetSystemDate uses american-esque format of mm-dd-yy, so have to transform
	-- doing it here cause execution on valve servers costs us nothing lmao
	for _, date in pairs(input_dates) do
		local year, month, day = unpack(string.split(date, "-"))
		local formatted_date_string = string.format("%02d/%02d/%d", month, day, string.sub(year, -2))
		SeasonalEvents._first_weekends_dates[formatted_date_string] = true
	end

	CustomNetTables:SetTableValue("game_state", "weekends_event_info", {
		dates = input_dates,
		is_event_active = SeasonalEvents:IsMonthlyEventActive(),
	})
end


function SeasonalEvents:SendEvents(event)
	local player_id = event.PlayerID
	if not player_id or not PlayerResource:IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "SeasonalEvents:update_events", {
		halloween = SeasonalEvents:IsHalloween(),
		christmas = SeasonalEvents:IsChristmas(),
	})
end


function SeasonalEvents:IsHalloween()
	-- return SeasonalEvents._halloween_dates[GetSystemDate()] or false
	return false
end


function SeasonalEvents:IsChristmas()
	-- return SeasonalEvents._christmas_dates[GetSystemDate()] or false
	return false
end


--- Is monthly epic event running?
--- Currently set to be active first full weekend (sunday-saturday consecutive) every month
---@return boolean
function SeasonalEvents:IsMonthlyEventActive()
	return SeasonalEvents._first_weekends_dates[GetSystemDate()] or false
end


--- Is any event running that needs to enforce epic drops?
---@return boolean
function SeasonalEvents:IsAnyEpicEventRunning()
	return SeasonalEvents:IsHalloween() or SeasonalEvents:IsMonthlyEventActive()
end

SeasonalEvents:Init()