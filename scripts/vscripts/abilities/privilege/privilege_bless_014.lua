--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_014"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("class.drop_item")
local i = h.DropItem
local j = require("abilities.eom_privilege")
local k = j.EOMPrivilege
local l = j.RegisterPrivilege
local m = c()
m.name = "privilege_bless_014"
d(m, k)
function m.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.drop_chance = 0
	self.drop_count_max = 0
	self.drop_count = 0
end
function m.prototype.OnCreated(self)
	self.drop_chance = self:GetSpecialValueFor("drop_chance")
	self.drop_count_max = self:GetSpecialValueFor("drop_count_max")
end
function m.prototype.EventListener(self)
	return {
		dungeon_room_clear = function(n, o)
			local p = o.position
			if self.drop_count < self.drop_count_max and RollPercentage(self.drop_chance) then
				self.drop_count = self.drop_count + 1
				local q = PickList(TAVERN_ITEMS, 1)
				local r = q[1]
				local s = p + RandomVector(RandomFloat(0, 100))
				local t = e(i, r, s)
				Interaction:RegisterInteract(t.entity, InteractType.Chest, 200, function(n, u, v)
					u:AddItemByName(r, nil, false)
					t:dispose()
				end, nil, self:GetPlayerID(), r)
			end
		end,
	}
end
m = f({ l(nil) }, m)
return g