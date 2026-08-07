--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_025"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_025"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function j.prototype.EventListener(self)
	return {
		give_up_bless = function(k, l)
			local m = l.playerID
			local n = self:GetCaster()
			if not IsValid(n) then
				return
			end
			if m ~= n:GetPlayerOwnerID() then
				return
			end
			local o = self:GetSpecialValueFor("count_max")
			if self.consumedCount >= o then
				return
			end
			local p = Bless:GetUpgradeableBlessOptions(m, 1)
			if p == nil or #p == 0 then
				return
			end
			self.consumedCount = self.consumedCount + 1
			local q = p[1]
			local r = q.name
			BlessUpgrade:UpgradePlayerBless(m, r)
			print(
				string.format(
					"玩家 %d 放弃祝福，随机提升了祝福 %s 的等级（已消耗次数: %d/%d）",
					m,
					r,
					self.consumedCount,
					o
				)
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f