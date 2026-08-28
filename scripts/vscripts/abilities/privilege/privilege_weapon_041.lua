--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_041"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_weapon_041"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.consumedCount = 0
end
function l.prototype.EventListener(self)
	return {
		tome_property_reward = function(m, n)
			local o = self:GetCaster()
			if not IsValid(o) or n.unit ~= o then
				return
			end
			local p = self:GetSpecialValueFor("count")
			if self.consumedCount >= p then
				return
			end
			self.consumedCount = self.consumedCount + 1
			local q = self:GetSpecialValueFor("skill_damage")
			local r = n.gains
			r[#r + 1] = {
				property = PropertyFunction.SKILL_DAMAGE_AMPLIFY,
				value = q,
				source = "privilege_weapon_041",
				onApplied = function(m, s)
					Notification:CombatToPlayer(
						self:GetPlayerID(),
						{ message = "Notify_privilege_weapon_041", item_name = "item_tome_of_prop", int_skill_damage = s }
					)
				end,
			}
		end,
		GameModeStarted = function()
			self.consumedCount = 0
		end,
		GameModeExited = function()
			self.consumedCount = 0
		end,
	}
end
l = e({ h, k(nil) }, l)
return f