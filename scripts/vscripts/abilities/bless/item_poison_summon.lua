--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_summon"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_poison_summon"
d(k, j)
function k.prototype.OnCreated(self)
	self.wisp = self:GetCaster():CreateWisp("poison_summon", { attack = 0 })
end
function k.prototype.OnDestroy(self)
	if IsValid(self.wisp) then
		self:GetCaster():RemoveWisp(self.wisp)
		self.wisp = nil
	end
end
function k.prototype.EventListener(self)
	return {
		damage_event = function(l, m)
			if m.attacker == self.wisp then
				local n = self:GetCaster()
				local o = self:GetSpecialValueFor("poison") * (1 + GetWispDamage(n) / 100)
				n:Poison(m.target, o)
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f