--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_27"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayIncludes
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 5,
		["16"] = 7,
		["17"] = 9,
		["18"] = 10,
		["19"] = 12,
		["20"] = 12,
		["21"] = 12,
		["22"] = 14,
		["23"] = 15,
		["24"] = 12,
		["25"] = 12,
		["26"] = 5,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 23,
		["32"] = 24,
		["34"] = 26,
		["35"] = 26,
		["36"] = 26,
		["37"] = 26,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 27,
		["43"] = 28,
		["45"] = 29,
		["46"] = 29,
		["48"] = 30,
		["49"] = 31,
		["50"] = 31,
		["52"] = 33,
		["53"] = 33,
		["55"] = 34,
		["59"] = 36,
		["60"] = 38,
		["62"] = 38,
		["64"] = 39,
		["65"] = 39,
		["67"] = 40,
		["70"] = 48,
		["71"] = 49,
		["72"] = 50,
		["73"] = 51,
		["74"] = 52,
		["75"] = 53,
		["77"] = 55,
		["78"] = 56,
		["80"] = 56,
		["82"] = 57,
		["83"] = 57,
		["84"] = 57,
		["85"] = 57,
		["86"] = 57,
		["87"] = 57,
		["89"] = 58,
		["90"] = 58,
		["91"] = 58,
		["92"] = 58,
		["93"] = 58,
		["94"] = 58,
		["95"] = 58,
		["96"] = 58,
		["97"] = 58,
		["99"] = 66,
		["101"] = 66,
		["103"] = 67,
		["104"] = 67,
		["106"] = 68,
		["108"] = 19,
	}
)
local h = {}
local i = require("abilities.greevil_effect.greevil_effect_base")
local j = i.GreevilEffectBase
h.greevil_effect_27 = c()
local k = h.greevil_effect_27
k.name = "greevil_effect_27"
d(k, j)
function k.prototype.spawn(self)
	self:giveRandomAttributeFromShop()
	PlayerData:saveData(self.playerID, "greevil_27_free_available", true)
	Greevil:updateAttributeSlotCosts(self.playerID)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function()
		PlayerData:saveData(self.playerID, "greevil_27_free_available", true)
		Greevil:updateAttributeSlotCosts(self.playerID)
	end)
end
function k.prototype.giveRandomAttributeFromShop(self)
	local l = PlayerData:getplayerData(self.playerID)
	local m = Greevil:getPlayerGreevil(self.playerID)
	local n = {}
	if l and l.bannedSect then
		n[#n + 1] = l.bannedSect
	end
	e(AbilityShop.banList, function(o, p)
		local q = #n + 1
		n[q] = p
		return q
	end)
	local r = {}
	for s, t in pairs(KeyValues.GreevilShopKV) do
		do
			if t.Type ~= "attribute" then
				goto u
			end
			local v = tonumber(t.Weight) or 0
			if v <= 0 then
				goto u
			end
			if t.Pick ~= nil and f(n, t.Pick) then
				goto u
			end
			r[#r + 1] = s
		end
		::u::
	end
	if #r == 0 then
		local w = l and l.hero
		if w ~= nil then
			w:addProperty("item_health", 80)
		end
		if m ~= nil then
			m:RecordShopData("attribute", "item_health", "80")
		end
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_attribute_gain_str",
				string_attribute = "dota_tooltip_item_variable_item_health",
				string_value = "80",
				string_ability_name = "DOTA_Tooltip_ability_greevil_effect_27",
			}
		)
		return
	end
	local s = GetRandomElement(r)
	local t = KeyValues.GreevilShopKV[s]
	local x = t.Value
	local y = tonumber(t.Special) or 0
	if not f(ITEM_ATTRIBUTE, x) then
		x = "item_" .. x
	end
	if f(ITEM_ATTRIBUTE, x) and y ~= 0 then
		local z = l and l.hero
		if z ~= nil then
			z:addProperty(x, y)
		end
		if m ~= nil then
			m:RecordShopData("attribute", t.Value, tostring(y))
		end
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_attribute_gain_str",
				string_attribute = "dota_tooltip_item_variable_item_" .. t.Value,
				string_value = tostring(y),
				string_ability_name = "DOTA_Tooltip_ability_greevil_effect_27",
			}
		)
	else
		local A = l and l.hero
		if A ~= nil then
			A:addProperty("item_health", 80)
		end
		if m ~= nil then
			m:RecordShopData("attribute", "item_health", "80")
		end
		Notification:combatToPlayer(
			self.playerID,
			{
				message = "notify_attribute_gain_str",
				string_attribute = "dota_tooltip_item_variable_item_health",
				string_value = "80",
				string_ability_name = "DOTA_Tooltip_ability_greevil_effect_27",
			}
		)
	end
end
return h