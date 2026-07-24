--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebSettings = WebSettings or {}

-- to make new setting type - add name and enum value here
-- then to SETTING_TYPE and SETTING_SNIPPETS dicts (also define a snippet itself), then make an inherited class for that setting type
-- implementing logic for initialization and value update
-- then add that class to SETTING_CLASSES
SETTING_TYPE = {
	CHECKBOX = 1,
	SLIDER = 2,
}


-- these default values won't be included in backend request
WebSettings.known_defaults = {
	test_default_1 = 90,
	test_default_2 = {
		key = "value"
	},
	hide_streaks = false,
	disable_transparent_upgrade_ui = false,
	generic_from_subscription = false,
	auto_select_favorites = false,
	auto_select_favorites_delay = 2,
	disable_epic_path = false,
	ui_show_game_time = false,
	chat_wheel_favorites = {},
}


-- default value will be included from table above
-- or set to false for checkboxes / min value (or 0 if absent) for sliders
-- SETTINGS SHOULD ONLY BE MENTIONED HERE IF YOU NEED THEM TO BE PRESENT IN SETTINGS WINDOW
-- otherwise it's fine to just set them via SetSettingValue
WebSettings.manifest = {
	-- category name is localized as #settings_category_<category>, i.e. #settings_category_hero_selection
	hero_selection = {
		-- settings name is localized as #settings_entry_<name>, i.e. #settings_entry_hide_streaks
		-- optionally, you can localize tooltip as #settings_entry_tooltip_<name> - it won't be shown otherwise
		hide_streaks = {
			type = SETTING_TYPE.CHECKBOX
		},
		-- example of slider setting
		--[[
		test_default_1 = {
			type = SETTING_TYPE.SLIDER,
			min = 100,
			max = 120
		},
		]]
	},
	upgrade_selection = {
		disable_transparent_upgrade_ui = {
			type = SETTING_TYPE.CHECKBOX
		},
		generic_from_subscription = {
			type = SETTING_TYPE.CHECKBOX,
			-- have to have at least tier 1 sub to change this setting
			subscription_tier = 1,
		},
		auto_select_favorites = {
			type = SETTING_TYPE.CHECKBOX,
		},
	},
	gameplay = {
		disable_epic_path = {
			type = SETTING_TYPE.CHECKBOX
		},
		ui_show_game_time = {
			type = SETTING_TYPE.CHECKBOX,
		}
	},
}


function WebSettings:Init()
	WebSettings._scheduled_players = {}
	WebSettings._scheduled_timer = nil

	WebSettings._prepared_manifest = {}
	WebSettings.settings_definition = {}

	WebSettings:CreateDefinition()
	WebSettings:PrepareManifest()

	EventStream:Listen("WebSettings:set_setting_value", WebSettings.SetSettingValueEvent, WebSettings)
	EventStream:Listen("WebSettings:fetch_manifest", WebSettings.SendManifestEvent, WebSettings)
end


function WebSettings:CreateDefinition()
	for _, settings in pairs(WebSettings.manifest) do
		for setting_name, config in pairs(settings) do
			WebSettings.settings_definition[setting_name] = config
		end
	end

	for setting_name, default in pairs(WebSettings.known_defaults or {}) do
		WebSettings.settings_definition[setting_name] = WebSettings.settings_definition[setting_name] or {}
	end
end


function WebSettings:PrepareManifest()
	WebSettings._prepared_manifest = table.deepcopy(WebSettings.manifest)

	for _, settings in pairs(WebSettings._prepared_manifest or {}) do
		for setting_name, config in pairs(settings or {}) do
			if not config.type then error(setting_name .. " has no type specified! Every setting in settings manifest must have a type.") end
			if WebSettings.known_defaults[setting_name] then
				config.default = WebSettings.known_defaults[setting_name]
			else
				if config.type == SETTING_TYPE.CHECKBOX then config.default = false end
				if config.type == SETTING_TYPE.SLIDER then config.default = config.min or 0 end
			end
		end
	end
end


function WebSettings:SetSettingValueEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local setting_name = event.setting_name
	local setting_value = event.setting_value
	if not setting_name or not setting_value then return end

	-- attempt to cast input to proper type if default for it is known
	-- this is needed since Dota networking converts booleans to 0 / 1, and lua considers both to be TRUE in conditionals
	local default = WebSettings.known_defaults[event.setting_name]

	if default ~= nil and type(default) ~= type(setting_value) then
		if type(default) == "boolean" then setting_value = toboolean(setting_value) end
	end


	if not WebSettings:_ValidateSetting(player_id, setting_name, setting_value, true) then
		return DisplayError(player_id, "#dota_hud_error_invalid_setting")
	end

	WebSettings:SetSettingValue(player_id, event.setting_name, setting_value)
end


function WebSettings:SendManifestEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	CustomGameEventManager:Send_ServerToPlayer(player, "WebSettings:update_manifest", {
		manifest = WebSettings._prepared_manifest
	})
end

--- Sets settings value of `name` to `value`.
--- Schedules an update to backend server, invokes update of player state on panorama.
---@param player_id number
---@param name string
---@param value any
function WebSettings:SetSettingValue(player_id, name, value)
	WebPlayer.players_data[player_id] = WebPlayer.players_data[player_id] or {}
	local player = WebPlayer.players_data[player_id]

	player.settings = player.settings or {}

	player.settings[name] = value

	EventDriver:Dispatch("WebSettings:settings_changed", {
		player_id = player_id,
		setting_name = name,
		setting_value = value
	})

	WebSettings:ScheduleUpdate(player_id)
	WebPlayer:UpdateClient(player_id)
end


--- Returns table of player settings
---@param player_id number
---@return table
function WebSettings:GetSettings(player_id)
	return (WebPlayer.players_data[player_id] or {}).settings or {}
end


--- Returns value of setting at `name` for a given player, or `default` if player doesn't have setting
---@param player_id number
---@param name string
---@return any
function WebSettings:GetSettingValue(player_id, name, default)
	if WebSettings:GetSettings(player_id)[name] ~= nil then
		return WebSettings:GetSettings(player_id)[name]
	end
	return default
end


--- Schedules backend update of modified player settings
--- Cancels running timer, effectively updating settings only if `SETTINGS_REQUEST_DELAY` seconds passed since last modification
---@param player_id number
function WebSettings:ScheduleUpdate(player_id)
	WebSettings._scheduled_players[player_id] = true
	if WebSettings._scheduled_timer then Timers:RemoveTimer(WebSettings._scheduled_timer) end

	WebSettings._scheduled_timer = Timers:CreateTimer(SETTINGS_REQUEST_DELAY, function()
		WebSettings:CommitChanges()
	end)
end


--- Injects default values into settings table if default keys are not defined
--- This way we can avoid declaring those at panorama side
--- WARNING: this method **mutates** passed table.
---@param settings_table table
function WebSettings:IncludeDefaults(settings_table)
	for key, value in pairs(WebSettings.known_defaults or {}) do
		if not settings_table[key] then
			settings_table[key] = value
		end
	end
end


--- Validate passed setting (by name and value) against known definition
---@param player_id number
---@param setting_name string
---@param setting_value any
---@param strict boolean @ if strict is set to true, missing definition considered invalid setting (for event purposes mainly)
function WebSettings:_ValidateSetting(player_id, setting_name, setting_value, strict)
	local definition = WebSettings.settings_definition and WebSettings.settings_definition[setting_name]

	if not definition then return not strict end

	local subscription_tier = WebPlayer:GetSubscriptionTier(player_id)

	if definition.subscription_tier and definition.subscription_tier > subscription_tier then
		return false
	end

	return true
end


--- Validate incoming settings in case incoming value is outside of bounds set by definition
--- i.e. if player subscription tier expired
---@param player_id number
---@param settings_table table<string, any>
function WebSettings:Validate(player_id, settings_table)
	for setting_name, setting_value in pairs(settings_table or {}) do
		local default_setting = WebSettings.known_defaults[setting_name]

		if not WebSettings:_ValidateSetting(player_id, setting_name, setting_value, false) then
			print("[WebSettings] INVALID SETTING", player_id, setting_name, setting_value)
			settings_table[setting_name] = default_setting
		end
	end
end


--- Returns a **copy** of settings table with defaults removed
--- Needed mainly to send that to backend, to avoid cluttering database with default settings values
---@param settings_table any
function WebSettings:ExcludeDefaults(settings_table)
	-- deepcopy original table so defaults exclusion won't affect it
	local filtered_settings = table.deepcopy(settings_table)

	for key, value in pairs(settings_table) do
		local known_default = WebSettings.known_defaults[key]
		if known_default ~= nil and known_default == value then
			filtered_settings[key] = nil
		end
	end

	return filtered_settings
end


function WebSettings:CommitChanges()
	local new_settings = {}

	for player_id, _ in pairs(WebSettings._scheduled_players) do
		local steam_id = tostring(PlayerResource:GetSteamID(player_id))
		new_settings[steam_id] = WebSettings:ExcludeDefaults(WebSettings:GetSettings(player_id))
	end

	WebApi:Send(
		"api/lua/match/update_settings",
		{
			new_settings = new_settings,
		},
		function()
			print("[WebSettings] successfully updated scheduled players settings")
		end,
		function()
			print("[WebSettings] failed to update scheduled players settings")
		end
	)

	WebSettings._scheduled_players = {}
end


WebSettings:Init()