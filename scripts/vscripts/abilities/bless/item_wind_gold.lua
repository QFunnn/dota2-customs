--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_wind_gold"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__New
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("class.drop_item")
local i = h.DropItem
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_wind_gold"
d(m, k)
function m.prototype.EventListener(self)
	return {
		entity_killed = function(n, o)
			if o.victim:IsBreakable() and self:PRD(self:GetSpecialValueFor("chance")) then
				local p = DungeonManager:GetCurrentRoom()
				if not p then
					return
				end
				local q = o.attacker:GetPlayerOwnerID()
				local r = e(i, "item_coin_stack", o.victim:GetAbsOrigin(), q)
				local s = p.dropItems
				s[#s + 1] = r
				local t = Interaction:RegisterInteract(r.entity, InteractType.Chest, 200, function(n, u)
					u:AddItemByName("item_coin_stack")
					r:dispose()
				end, nil, q, "item_coin_stack")
				if t ~= -1 then
					local v = p.registeredInteracts
					v[#v + 1] = t
				end
			end
		end,
	}
end
m = f({ l(nil) }, m)
return g