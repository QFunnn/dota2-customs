--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_007"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_bless_007"
d(j, h)
function j.prototype.GetPriority(self)
	return 150
end
function j.prototype.EventListener(self)
	return {
		GameModeStarted = function(k, l)
			local m = self:GetCaster()
			if not m then
				return
			end
			m:AddItemByName("item_vip_card_4", 4)
			local n = self:GetPlayerID()
			Notification:CombatToPlayer(
				n,
				{ message = "Notify_privilege_bless_007", item_name = "item_vip_card_4", item_name_rarity = 4 }
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f