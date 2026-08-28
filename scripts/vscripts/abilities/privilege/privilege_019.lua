--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_019"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_019"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function j.prototype.EventListener(self)
	return {
		tome_property_reward = function(k, l)
			local m = self:GetCaster()
			if not IsValid(m) or l.unit ~= m then
				return
			end
			local n = m:GetPlayerID()
			if n == nil then
				return
			end
			local o = self:GetSpecialValueFor("extra_count")
			if self.consumedCount >= o then
				return
			end
			local p = self:GetSpecialValueFor("extra_attack")
			self.consumedCount = self.consumedCount + 1
			local q = l.gains
			q[#q + 1] = {
				property = PropertyFunction.ATTACK,
				value = p,
				source = "privilege_019",
				onApplied = function(k, r)
					Notification:CombatToPlayer(
						n,
						{ message = "Notify_privilege_019", item_name = "item_tome_of_prop", int_extra_attack = r }
					)
				end,
			}
		end,
		GameModeExited = function()
			self.consumedCount = 0
			print(string.format("[privilege_019] Player %d GameEnd, consumedCount reset", self:GetPlayerID()))
		end,
		GameModeStarted = function()
			self.consumedCount = 0
			print(string.format("[privilege_019] Player %d GameStart, consumedCount reset", self:GetPlayerID()))
		end,
	}
end
j = e({ i(nil) }, j)
return f