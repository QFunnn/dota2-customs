--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_024"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__ArrayFilter
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("lib.tstl-utils")
local j = i.reloadable
local k = require("abilities.eom_privilege")
local l = k.EOMPrivilege
local m = k.PrivilegeValue
local n = k.RegisterPrivilege
local o = { "item_healing_bandage", "item_regen_moss_medicine" }
local p = c()
p.name = "privilege_bless_024"
d(p, l)
function p.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.triggerCount = 0
end
function p.prototype.EventListener(self)
	return {
		shop_item_purchased = function(q, r)
			if r.playerID ~= self:GetPlayerID() then
				return
			end
			if r.source ~= "TravelingMerchant" then
				return
			end
			if self.triggerCount >= self.max_count or not self:PRD(self.chance) then
				return
			end
			local s = self:GetCaster()
			if not IsValid(s) or not IsValid(r.item) then
				return
			end
			local t = r.item:GetLevel()
			local u = math.max(0, math.floor(self.extra_count))
			local v = 0
			do
				local w = 0
				while w < u do
					local x = f(Artifact:GetSelectableArtifactOptions(r.playerID, "Meepo", t), function(q, y)
						return not e(o, y.name)
					end)
					if #x <= 0 then
						break
					end
					local y = x[RandomInt(0, #x - 1) + 1]
					local z = y.name
					local A = s:AddItemByName(z, t)
					if IsValid(A) then
						v = v + 1
						Notification:CombatToPlayer(
							r.playerID,
							{ message = "Notify_privilege_bless_024", item_name = z, item_name_rarity = t }
						)
					end
					w = w + 1
				end
			end
			if v <= 0 then
				return
			end
			self.triggerCount = self.triggerCount + 1
		end,
	}
end
g({ m(nil) }, p.prototype, "chance", nil)
g({ m(nil) }, p.prototype, "extra_count", nil)
g({ m(nil) }, p.prototype, "max_count", nil)
p = g({ j, n(nil) }, p)
return h