--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_030"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_030"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.count = 0
end
function j.prototype.OnCreated(self)
	self.count = self:GetSpecialValueFor("count")
end
function j.prototype.OnRefresh(self)
	self.count = self.count + self:GetSpecialValueFor("count")
end
function j.prototype.EventListener(self)
	return {
		tome_property_reward = function(k, l)
			if l.unit ~= self:GetCaster() or self.count <= 0 then
				return
			end
			local m = self:GetSpecialValueFor("spell_damage")
			self.count = self.count - 1
			local n = l.gains
			n[#n + 1] = {
				property = PropertyFunction.SPELL_DAMAGE_AMPLIFY,
				value = m,
				source = "privilege_weapon_030",
				onApplied = function(k, o)
					Notification:CombatToPlayer(
						self:GetPlayerID(),
						{ message = "Notify_privilege_weapon_030", item_name = "item_tome_of_prop", int_spell_damage = o }
					)
				end,
			}
		end,
	}
end
j = e({ i(nil) }, j)
return f