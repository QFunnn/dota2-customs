--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


require("libraries/chat_wheel/chat_wheel_rings")
require("libraries/chat_wheel/chat_wheel_heroes")
require("libraries/chat_wheel/chat_wheel_pre_generation")

ChatWheel = ChatWheel or {}

function ChatWheel:Init()
	self.timer = {}
	self.counter = {}
	self.favorites = {}


	self.mute_state = {
		voice = {},
		text = {},
	}

	for player_id = 0, 24 do
		self.mute_state.voice[player_id] = {}
		self.mute_state.text[player_id] = {}
	end

	EventStream:Listen("chat_wheel:get_rings", self.UpdateClientRings, self)
	EventStream:Listen("chat_wheel:say", self.Say, self)
	EventStream:Listen("chat_wheel:update_favorites", self.UpdateFavorites, self)
	EventStream:Listen("chat_wheel:get_phrases_for_collection", self.UpdateCollectionPhrases, self)

	EventStream:Listen("GameMode:set_muted_players", self.SetMutedPlayers, self)
end

function ChatWheel:UpdateCollectionPhrases(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local non_filtered_favs = WebSettings:GetSettingValue(player_id, "chat_wheel_favorites", {})
	local filtered_favs = ChatWheel:FilterValidFavorites(player_id, non_filtered_favs)

	self.favorites[player_id] = filtered_favs

	if not table.deep_compare(non_filtered_favs, filtered_favs) then
		WebSettings:SetSettingValue(player_id, "chat_wheel_favorites", filtered_favs)
	else
		print("[Chat Wheel] backend update discarded - filtered result matches initial!")
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "chat_wheel:update_phrases_for_collection", CHAT_WHEEL_GROUPED_FOR_COLLECTION)
end

function ChatWheel:UpdateClientRings(event)
	local player_id = event.PlayerID
	if not player_id then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	local hero_name = string.gsub(PlayerResource:GetSelectedHeroName(player_id) or "", "npc_dota_hero_", "")

	if not hero_name or not CHAT_WHEEL_HEROES[hero_name] then return end

	local muted_heroes_lines = {}
	local selected_heroes = {}

	for _p_id = 0, 24 do
		local _hero_name = PlayerResource:GetSelectedHeroName(_p_id)
		if _hero_name then selected_heroes[_hero_name] = true end
	end

	for _hero_name, hero_phrases in pairs(CHAT_WHEEL_HEROES) do
		if not selected_heroes[_hero_name] then
			for _, _phrase in pairs(hero_phrases) do
				muted_heroes_lines[_phrase[1]] = _hero_name
			end
		end
	end

	CustomGameEventManager:Send_ServerToPlayer(player, "chat_wheel:fill_rings", {
		rings = CHAT_WHEEL_RINGS,
		hero_phrases = CHAT_WHEEL_HEROES[hero_name],
		muted_heroes_lines = muted_heroes_lines,
	})
end
function ChatWheel:IsCooldownForPlayer(player, player_id)
	self.counter[player_id] = self.counter[player_id] or 0
	self.timer[player_id] = self.timer[player_id] or -9999999

	if GameRules:GetGameTime() - self.timer[player_id] > 5 + self.counter[player_id] then
		if not GameMode:IsDeveloper(player_id) then
			self.timer[player_id] = GameRules:GetGameTime()
			self.counter[player_id] = self.counter[player_id] + 1
		end
		return false
	else
		local remaining_cd = string.format("%.1f", 5 + self.counter[player_id] - (GameRules:GetGameTime() - self.timer[player_id]))
		CustomGameEventManager:Send_ServerToPlayer(player, "display_custom_error_with_value", {
			message = "#wheel_cooldown",
			values = {
				["sec"] = remaining_cd,
			},
		})
		return true
	end
end

function ChatWheel:TriggerDefaultPhraseLine(player_id, phrase_key)
	if not phrase_key or not CHAT_WHEEL_SOUNDS_DICTIONARY[phrase_key] then return end

	local sound = CHAT_WHEEL_SOUNDS_DICTIONARY[phrase_key]
	if not sound then return end

	local message = CHAT_WHEEL_TEXT_MESSAGES_DICTIONARY[sound] or "#" .. phrase_key

	CustomChat:MessageToAll(player_id, "chat_wheel_sound_message_chat", {}, nil, {
		chat_wheel_phrase = message,
	})

	ChatWheel:EmitSound(sound, player_id)
end

function ChatWheel:Say(event)
	local player_id = event.PlayerID

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	if ChatWheel:IsCooldownForPlayer(player, player_id) then return end

	local phrase_key = event.phrase_key

	self.favorites[player_id] = self.favorites[player_id] or {}

	local fav_data = self.favorites[player_id][tostring(event.fav_index or -1)]

	if event.is_favorite == 1 and fav_data then
		local validate_cw_item = function(name, key)
			local def = WebInventory:GetItemDefinition(name)
			if def and WebInventory:HasItem(player_id, name) then
				return def.chat_wheel_details[key]
			end
		end

		local sound = validate_cw_item(fav_data.phrase, "sound") or CHAT_WHEEL_SOUNDS_DICTIONARY[phrase_key]
		local emoji = validate_cw_item(fav_data.emoji, "emoji_id")
		local color = validate_cw_item(fav_data.color, "color")

		CustomChat:MessageToAll(player_id, "chat_wheel_sound_message_chat", {}, nil, {
			chat_wheel_phrase = fav_data.phrase,
			chat_wheel_color = color,
			chat_wheel_emoji = emoji,
		})

		if sound then
			ChatWheel:EmitSound(sound, player_id)
		end
	else
		ChatWheel:TriggerDefaultPhraseLine(player_id, phrase_key)
	end
end

function ChatWheel:EmitSound(sound, source_player_id)
	for player_id, hero in pairs(GameLoop.hero_by_player_id) do
		if hero:IsRealHero() and hero:IsControllableByAnyPlayer() then
			if player_id and not self.mute_state.voice[player_id][tostring(source_player_id)] then
				local player = PlayerResource:GetPlayer(player_id)
				CustomGameEventManager:Send_ServerToPlayer(player, "chat_wheel:emit_sound", {
					sound = sound
				})
			end
		end
	end
end

function ChatWheel:FilterValidPhrase(player_id, phrase)
	if WebInventory:GetItemDefinition(phrase) then
		return WebInventory:HasItem(player_id, phrase)
	end

	return CHAT_WHEEL_SOUNDS_DICTIONARY[phrase] ~= nil
end
function ChatWheel:FilterValidFavorites(player_id, favorites)
	local result = {}

	for id, f in pairs(favorites) do
		if type(f) == "table" then
			result[id] = {
				phrase = f.phrase and ChatWheel:FilterValidPhrase(player_id, f.phrase) and f.phrase or nil,
				emoji = f.emoji and WebInventory:HasItem(player_id, f.emoji) and f.emoji or nil,
				color =  f.color and WebInventory:HasItem(player_id, f.color) and f.color or nil,
			}
		else
			result[id] = {}
		end
	end

	return result
end

function ChatWheel:UpdateFavorites(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local player = PlayerResource:GetPlayer(player_id)
	if not IsValidEntity(player) then return end

	if not event.favorites then return end

	print(">> Before validation")
	DeepPrintTable(event.favorites)

	print(">> After validation")
	local valided_favorites = ChatWheel:FilterValidFavorites(player_id, event.favorites)
	DeepPrintTable(valided_favorites)

	self.favorites[player_id] = valided_favorites

	WebSettings:SetSettingValue(player_id, "chat_wheel_favorites", valided_favorites)
end

function ChatWheel:FilterValidPhrases(phrases, key_id)
	local result = {}
	for _, key in ipairs(phrases) do
		if key_id then key = key[key_id] end

		if key and CHAT_WHEEL_SOUNDS_DICTIONARY[key] then
			table.insert(result, key)
		end
	end
	return result
end



function ChatWheel:SetMutedPlayers(event)
	print("ChatWheel:SetMutedPlayers")
	DeepPrintTable(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	if not event.mute_data then return end

	for type, data in pairs(event.mute_data) do
		for target_player_id, is_voice_muted in pairs(data) do
			self.mute_state[type][player_id][target_player_id] = is_voice_muted == 1
		end
	end
end


ChatWheel:Init()