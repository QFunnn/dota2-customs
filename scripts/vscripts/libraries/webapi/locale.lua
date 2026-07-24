--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


WebLocale = WebLocale or {}


function WebLocale:Init()
	WebLocale.__players_locale = {}

	EventStream:Listen("WebLocale:set_player_locale", WebLocale.SetPlayerLocaleEvent, WebLocale)
end


function WebLocale:SetPlayerLocaleEvent(event)
	local player_id = event.PlayerID
	if not IsValidPlayerID(player_id) then return end

	local client_locale = string.lower(event.locale or "")

	local known_alias = KNOWN_LOCALE_ALIASES[client_locale]
	if known_alias then client_locale = known_alias end

	print("[WebLocale] assigned player locale", player_id, client_locale)

	WebLocale.__players_locale[player_id] = client_locale
end


--- Return player locale, if any is set, or nil
---@param player_id number
---@return string | nil
function WebLocale:GetPlayerLocale(player_id)
	return WebLocale.__players_locale[player_id]
end



WebLocale:Init()