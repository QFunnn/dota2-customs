--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_002"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.PrivilegeValue
local l = i.RegisterPrivilege
local m = c()
m.name = "privilege_bless_002"
d(m, j)
function m.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.triggerCount = 0
	self.pendingLevels = 0
end
function m.prototype.EventListener(self)
	return {
		hero_level_up = function(n, o)
			local p = self:GetCaster()
			if p ~= o.unit then
				return
			end
			if self.level_interval <= 0 or self.count <= 0 or self.triggerCount >= self.max_count then
				return
			end
			local q = o.level - o.old_level
			self.pendingLevels = self.pendingLevels + q
			local r = math.floor(self.pendingLevels / self.level_interval)
			if r <= 0 then
				return
			end
			local s = p:GetPlayerOwnerID()
			if s == nil then
				return
			end
			local t = math.min(r, self.max_count - self.triggerCount)
			do
				local u = 0
				while u < t do
					do
						local v = Bless:GetUpgradeableBlessOptions(s, self.count)
						if v == nil or #v == 0 then
							goto w
						end
						local x = 0
						do
							local y = 0
							while y < #v do
								local z = v[y + 1]
								if BlessUpgrade:UpgradePlayerBless(s, z.name) then
									x = x + 1
									Notification:CombatToPlayer(
										s,
										{
											message = "Notify_privilege_bless_002",
											item_name = z.name,
											item_name_rarity = z.rarity + 1,
										}
									)
								end
								y = y + 1
							end
						end
						if x <= 0 then
							goto w
						end
						self.triggerCount = self.triggerCount + 1
						self.pendingLevels = self.pendingLevels - self.level_interval
					end
					::w::
					u = u + 1
				end
			end
		end,
	}
end
e({ k(nil, "level") }, m.prototype, "level_interval", nil)
e({ k(nil) }, m.prototype, "count", nil)
e({ k(nil) }, m.prototype, "max_count", nil)
m = e({ h, l(nil) }, m)
return f