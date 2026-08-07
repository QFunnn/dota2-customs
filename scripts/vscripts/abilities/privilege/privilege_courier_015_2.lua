--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_courier_015_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_courier_015_2"
d(j, h)
function j.prototype.EventListener(self)
	return {
		give_up_bless = function(k, l)
			if l.playerID ~= self.playerID then
				return
			end
			local m = Bless:GetUpgradeableBlessOptions(self.playerID, 1)
			if m == nil or #m == 0 then
				return
			end
			self:IncrementStackCount()
			local n = self:GetSpecialValueFor("give_up_times")
			if self:GetStackCount() == n then
				local o = m[1]
				local p = o.name
				BlessUpgrade:UpgradePlayerBless(self.playerID, p)
				print("每局游戏前2次选择放弃祝福时，随机提升1个已有的祝福等级。")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f