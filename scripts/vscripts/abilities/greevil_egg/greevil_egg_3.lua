--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_egg/greevil_egg_3"
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
		["13"] = 8,
		["14"] = 9,
		["15"] = 9,
		["16"] = 9,
		["17"] = 9,
		["18"] = 8,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["23"] = 15,
		["24"] = 16,
		["25"] = 16,
		["26"] = 16,
		["27"] = 17,
		["28"] = 18,
		["29"] = 19,
		["30"] = 20,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["42"] = 29,
		["43"] = 29,
		["44"] = 29,
		["45"] = 29,
		["49"] = 16,
		["50"] = 16,
		["51"] = 11,
	}
)
local f = {}
local g = require("abilities.greevil_egg.greevil_egg_base")
local h = g.GreevilEggBase
f.greevil_egg_3 = c()
local i = f.greevil_egg_3
i.name = "greevil_egg_3"
d(i, h)
function i.prototype.OnRoundGain(self, j)
	Greevil:fixGreevilLevel(self:getPlayerID(), true)
end
function i.prototype.spawn(self)
	self.record = 0
	self.gold = self:getSpecialValueFor("gold")
	self.lv1 = self:getSpecialValueFor("lv1")
	self.lv2 = self:getSpecialValueFor("lv2")
	self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_GOLD_MODIFY, function(k, l, m)
		if m == self:getPlayerID() then
			local n = l.modify_value
			if n < 0 then
				self.record = self.record + -n
			end
			if self.record >= self.gold then
				local o = math.floor(self.record / self.gold)
				self.record = self.record % self.gold
				local p = Greevil:getPlayerData(self:getPlayerID())
				if not p.shop_enabled then
					PlayerData:modifyGreevilEnergy(self:getPlayerID(), self.lv1 * o)
				else
					PlayerData:modifyGreevilEnergy(self:getPlayerID(), self.lv2 * o)
				end
			end
		end
	end)
end
return f