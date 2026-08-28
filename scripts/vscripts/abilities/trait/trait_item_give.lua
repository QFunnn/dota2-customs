--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_item_give"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["24"] = 4,
		["25"] = 16,
		["26"] = 17,
		["27"] = 17,
		["28"] = 18,
		["29"] = 18,
		["30"] = 17,
		["31"] = 18,
		["33"] = 16,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 21,
		["42"] = 21,
		["43"] = 21,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = c()
l.name = "trait_item_give"
d(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		local m = self:GetCaster():GetPlayerOwnerID()
		local n = PlayerData:getHero(m)
		local o = self:GetLevelSpecialAddedValueFor("item", "value")
		if o then
			n:addItemForPlayer(o, true, nil, true)
		end
	end
end
local function p(self, q)
	local r = c()
	r.name = "TraitAbility"
	d(r, l)
	r = e({ k(nil, q) }, r)
end
f({ "trait_130", "trait_131", "trait_133", "trait_134", "trait_137", "trait_138", "trait_145", "trait_156" }, p)
return h