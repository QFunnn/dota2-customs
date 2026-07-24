--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


local heroes_tags = {"_laugh", "_thank", "_deny", "_1", "_2", "_3", "_4", "_5"}

CHAT_WHEEL_HEROES_BY_PHRASES = {}

function GenerateHeroPhrasesTable(hero_name, phrases)
	local r = {}
	for idx, phrase in ipairs(phrases) do
		if heroes_tags[idx] then
			local phrase_key = hero_name .. heroes_tags[idx]
			local is_empty = phrase == ""
			table.insert(r, { is_empty and "" or phrase_key, phrase })

			if not is_empty then
				CHAT_WHEEL_HEROES_BY_PHRASES[phrase_key] = "npc_dota_hero_" .. hero_name
			end
		end
	end
	return r
end

CHAT_WHEEL_HEROES = {}

for hero, phrases in pairs(_CHAT_WHEEL_HEROES_PHRASES) do
	CHAT_WHEEL_HEROES[hero] = GenerateHeroPhrasesTable(hero, phrases)
end

CHAT_WHEEL_SOUNDS_DICTIONARY = {}
_CHAT_WHEEL_NON_HERO_SOUNDS_DICTIONARY = {}
CHAT_WHEEL_TEXT_MESSAGES_DICTIONARY = {}

for _, phrases in pairs(CHAT_WHEEL_HEROES) do
	for _, phrase_data in pairs(phrases) do
		if phrase_data[1] and phrase_data[1] ~= "" and phrase_data[2] then
			CHAT_WHEEL_SOUNDS_DICTIONARY[phrase_data[1]] = phrase_data[2]
			if phrase_data[2] ~= "" then
				CHAT_WHEEL_TEXT_MESSAGES_DICTIONARY[phrase_data[2]] = "#dota_chatwheel_message_" .. phrase_data[1]
			end
		end
	end
end

CHAT_WHEEL_GROUPED_FOR_COLLECTION = {}
for group_name, ring_info in pairs(CHAT_WHEEL_RINGS) do
	for _, ring_line in pairs(ring_info) do
		if type(ring_line) == "table" and ring_line[1] and ring_line[2] then
			CHAT_WHEEL_SOUNDS_DICTIONARY[ring_line[1]] = ring_line[2]
			_CHAT_WHEEL_NON_HERO_SOUNDS_DICTIONARY[ring_line[2]] = ring_line[1]

			local group_name_without_n = group_name:gsub("_%d*$", "")
			CHAT_WHEEL_GROUPED_FOR_COLLECTION[group_name_without_n] = CHAT_WHEEL_GROUPED_FOR_COLLECTION[group_name_without_n] or {}

			table.insert(CHAT_WHEEL_GROUPED_FOR_COLLECTION[group_name_without_n], {
				text = ring_line[1],
				sound = ring_line[2]
			})
		end
	end
end

local dota_chat_wheel = LoadKeyValues("scripts/chat_wheel.txt")

if dota_chat_wheel and dota_chat_wheel.messages then
	for _, phrase_info in pairs(dota_chat_wheel.messages) do
		if phrase_info.sound and phrase_info.message and _CHAT_WHEEL_NON_HERO_SOUNDS_DICTIONARY[phrase_info.sound] then
			CHAT_WHEEL_TEXT_MESSAGES_DICTIONARY[phrase_info.sound] = phrase_info.message
		end
	end
end