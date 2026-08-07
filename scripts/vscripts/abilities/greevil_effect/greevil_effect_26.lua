--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_26"
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
		["14"] = 3,
		["15"] = 4,
		["16"] = 3,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 7,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 10,
		["26"] = 12,
		["27"] = 7,
		["28"] = 7,
		["29"] = 14,
		["30"] = 14,
		["31"] = 14,
		["32"] = 15,
		["33"] = 16,
		["35"] = 14,
		["36"] = 14,
		["37"] = 19,
		["38"] = 19,
		["39"] = 19,
		["40"] = 20,
		["41"] = 21,
		["43"] = 19,
		["44"] = 19,
		["45"] = 5,
	}
)
local f = {}
local g = require("abilities.greevil_effect.greevil_effect_base")
local h = g.GreevilEffectBase
f.greevil_effect_26 = c()
local i = f.greevil_effect_26
i.name = "greevil_effect_26"
d(i, h)
function i.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.flag = false
end
function i.prototype.spawn(self)
	local j = self:getSpecialValueFor("free_refresh_count")
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE, function()
		if not self.flag then
			PlayerData:ModifyFreeRefresh(self.playerID, j)
			PlayerData:ModifyFreeRefreshByKey(self.playerID, "greevil_effect_26", j)
		end
		self.flag = false
	end)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY, function(k, l, m)
		if self.playerID == m then
			self.flag = true
		end
	end)
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_SHOP_RANDOM, function(k, l, m)
		if self.playerID == m then
			self.flag = true
		end
	end)
end
return f