--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_026"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_026"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.freeRefreshCount = 0
end
function j.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.SHOP_REFRESH_REFUND] = function()
			return self.freeRefreshCount > 0 and 100 or 0
		end,
	}
end
function j.prototype.EventListener(self)
	return {
		dungeon_room_start = function(k, l)
			local m = l.room
			if m == nil or m:GetRoomType() ~= RoomType.SHOP then
				self.freeRefreshCount = 0
				return
			end
			local n = self:GetSpecialValueFor("refresh_count")
			self.freeRefreshCount = n
			local o = print
			local p = string.format
			local q = self:GetCaster()
			o(p("玩家 %d 进入商店，获得了 %d 次免费刷新机会", q and q:GetPlayerID(), n))
		end,
		shop_refresh_purchased = function(k, r)
			local s = r.playerID
			if s == nil then
				return
			end
			local t = self:GetCaster()
			if not IsValid(t) or t:GetPlayerID() ~= s then
				return
			end
			if self.freeRefreshCount <= 0 then
				return
			end
			self.freeRefreshCount = self.freeRefreshCount - 1
			print(
				string.format(
					"玩家 %d 使用了特权提供的免费刷新机会，剩余免费刷新次数: %d",
					s,
					self.freeRefreshCount
				)
			)
		end,
	}
end
j = e({ i(nil) }, j)
return f