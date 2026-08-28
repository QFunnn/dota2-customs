--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_017"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_017"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.rewardCount = 0
end
function j.prototype.EventListener(self)
	return {
		wishing_pool_reward = function(k, l)
			if self.rewardCount >= 1 then
				return
			end
			local m = l.playerID
			local n = self:GetCaster()
			if not IsValid(n) then
				return
			end
			if m ~= self:GetPlayerID() then
				return
			end
			local o = Player:GetHero(m)
			if not IsValid(o) then
				return
			end
			o:AddItemByName("item_ball_attack_single")
			self.rewardCount = self.rewardCount + 1
			Notification:CombatToPlayer(m, { message = "Notify_privilege_weapon_017", item_name = "item_ball_attack" })
		end,
	}
end
j = e({ i(nil) }, j)
return f