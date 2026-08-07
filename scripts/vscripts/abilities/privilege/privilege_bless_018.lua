--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_018"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_018"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.triggerCountOwned = 0
	self.triggerCount = 0
	self.pendingLevels = 0
end
function j.prototype.EventListener(self)
	return {
		hero_level_up = function(k, l)
			local m = self:GetCaster()
			if m ~= l.unit then
				return
			end
			local n = m:GetPlayerOwnerID()
			if n == nil then
				return
			end
			local o = self:GetSpecialValueFor("level")
			local p = self:GetSpecialValueFor("count")
			local q = self:GetSpecialValueFor("max_count")
			if self.triggerCount >= q then
				return
			end
			self.pendingLevels = self.pendingLevels + l.level - l.old_level
			local r = math.floor(self.pendingLevels / o)
			local s = math.min(r, q - self.triggerCount)
			if s <= 0 then
				return
			end
			do
				local t = 0
				while t < s do
					do
						local u = ArtifactUpgrade:GetUpgradeableArtifactOptions(n, p)
						if u == nil or #u == 0 then
							goto v
						end
						do
							local w = 0
							while w < #u do
								ArtifactUpgrade:UpgradePlayerArtifact(n, u[w + 1].name, u[w + 1].rarity)
								w = w + 1
							end
						end
						self.triggerCount = self.triggerCount + 1
						self.pendingLevels = self.pendingLevels - o
						print(
							(
								(
									(
										(
											(("privilege_bless_018: player " .. tostring(n)) .. " upgraded ")
											.. tostring(p)
										) .. " artifacts, triggerCount="
									) .. tostring(self.triggerCount)
								) .. ", pendingLevels="
							) .. tostring(self.pendingLevels)
						)
					end
					::v::
					t = t + 1
				end
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f