--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_67"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 4,
		["14"] = 5,
		["15"] = 6,
		["16"] = 7,
		["17"] = 8,
		["18"] = 9,
		["19"] = 10,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 14,
		["24"] = 15,
		["25"] = 16,
		["26"] = 17,
		["27"] = 19,
		["29"] = 19,
		["34"] = 4,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_65 = c()
local i = f.card_effect_65
i.name = "card_effect_65"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = PlayerData:getHero(j).hero
	if IsValid(k) then
		local l = IsTurboMode(nil) and NEUTRAL_ROUND_TURBO or NEUTRAL_ROUND
		local m = IsTurboMode(nil) and NEUTRAL_LEVEL_TURBO or NEUTRAL_LEVEL
		local n = NEUTRAL_DROP_ITEM_LEVEL[m[table.remove(shallowcopy(l))]]
		local o = PlayerData:getEquipmentPoolWithLevel(j, n, false)
		local p = o:random()
		if p then
			local q = CreateItem(p, nil, nil)
			if q then
				q:SetPurchaseTime(0)
				k:AddItem(q)
				local r = self.hero:FindModifierByName("modifier_hero")
				if r ~= nil then
					r:RefreshInventory()
				end
			end
		end
	end
end
return f