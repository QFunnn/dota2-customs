--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_037"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_037"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.trig_count = 0
	self.kill_enemy = 0
	self.kill_enemy_max = 0
end
function j.prototype.OnCreated(self)
	self.kill_enemy_max = self:GetSpecialValueFor("enemy_count") or 0
end
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function(k, l)
			self.trig_count = self:GetSpecialValueFor("trig_count_max") or 0
			self.kill_enemy = 0
		end,
		entity_killed = function(k, l)
			local m = self.kill_enemy_max
			if m <= 0 then
				return
			end
			if self.trig_count <= 0 then
				return
			end
			local n = self:GetCaster()
			if not IsValid(n) then
				return
			end
			local o = n:GetPlayerOwnerID()
			local p = l.attacker:GetPlayerOwnerID()
			if o ~= p then
				return
			end
			self.kill_enemy = self.kill_enemy + 1
			if self.kill_enemy < m then
				return
			end
			self.kill_enemy = 0
			self.trig_count = self.trig_count - 1
			n:AddItemByName("item_tome_of_prop_single")
			Notification:CombatToPlayer(o, { message = "Notify_privilege_weapon_037", item_name = "item_tome_of_prop" })
		end,
	}
end
j = e({ i(nil) }, j)
return f