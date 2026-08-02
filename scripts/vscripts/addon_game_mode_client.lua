--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


if not IsClient() then
	return
end

require("utils/init")
require("extensions/client_init")
require("core_declarations")
require("libraries/game_perks/perks_definition")

require("game/modifiers/init") -- client-side modifier linking
require("modifiers/init") -- client-side modifier linking

print("[GameMode] - client - init finished!")

ListenToGameEvent("CustomChat:update_history_size", function()
	Convars:SetFloat("dota_hud_chat_history_lines", 1)
	Convars:SetFloat("dota_hud_chat_history_lines", 15)
end, nil)