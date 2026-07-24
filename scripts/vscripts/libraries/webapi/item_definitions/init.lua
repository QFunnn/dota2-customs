--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1413b34 · 2026-07-24 17:22:14 UTC
  ~ auto-generated — do not edit
]]


-- wrapper to work around module loading order issue
-- (the fact that item definitions have to be loaded before other modules that depend on it, but might need item use callbacks)
function Resolve(function_name, context_name)
	return function(player_id, item_name, item_data, definition)
		if context_name then
			_G[context_name][function_name](_G[context_name], player_id, item_name, item_data, definition)
		else
			_G[function_name](player_id, item_name, item_data, definition)
		end
	end
end

require("libraries/webapi/item_definitions/kill_effects")
require("libraries/webapi/item_definitions/auras")
require("libraries/webapi/item_definitions/pets")
require("libraries/webapi/item_definitions/consumables")
require("libraries/webapi/item_definitions/hero_effects")
require("libraries/webapi/item_definitions/sprays")
require("libraries/webapi/item_definitions/cosmetic_skills")
require("libraries/webapi/item_definitions/high_fives")
require("libraries/webapi/item_definitions/misc")
require("libraries/webapi/item_definitions/treasures")
require("libraries/webapi/item_definitions/chat_wheel")