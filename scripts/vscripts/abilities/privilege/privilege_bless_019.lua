--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_019"
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
local m = "item_dragon_egg"
local n = c()
n.name = "privilege_bless_019"
d(n, j)
function n.prototype.GetPriority(self)
	return 150
end
function n.prototype.EventListener(self)
	return {
		GameModeStarted = function()
			local o = self:GetCaster()
			if not IsValid(o) then
				return
			end
			do
				local p = 0
				while p < self.item_count do
					o:AddItemByName(m, self.rarity)
					Notification:CombatToPlayer(
						self:GetPlayerID(),
						{ message = "Notify_privilege_bless_019", item_name = m, item_name_rarity = self.rarity }
					)
					p = p + 1
				end
			end
		end,
	}
end
e({ k(nil) }, n.prototype, "item_count", nil)
e({ k(nil) }, n.prototype, "rarity", nil)
n = e({ h, l(nil) }, n)
return f