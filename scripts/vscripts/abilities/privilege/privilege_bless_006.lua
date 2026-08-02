--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_006"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_006"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.triggerCount = 0
end
function j.prototype.EventListener(self)
	return {
		wishing_pool_reward = function(k, l)
			if l.playerID ~= self.playerID then
				return
			end
			local m = self:GetSpecialValueFor("max_count")
			if self.triggerCount >= m then
				return
			end
			self:IncrementStackCount()
			local n = self:GetSpecialValueFor("wish_times")
			if self:GetStackCount() == n then
				self.triggerCount = self.triggerCount + 1
				self:SetStackCount(0)
				Bless:DrawBlessSelection(self.playerID, 3)
				print(
					(
						(
							(
								(
									("在许愿池中累计进行" .. tostring(n))
									.. "次许愿额外获得1个祝福升级三选一(已触发"
								) .. tostring(self.triggerCount)
							) .. "/"
						) .. tostring(m)
					) .. "次)"
				)
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f