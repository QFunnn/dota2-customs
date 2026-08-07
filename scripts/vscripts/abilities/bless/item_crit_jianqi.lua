--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_crit_jianqi"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_crit_jianqi"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.stack = 0
end
function j.prototype.OnCreated(self)
	self:StartThink(0.1, function()
		self.stack = math.min(self.stack + 0.1, SWORD_INTENT_MAX_STACK)
	end)
end
function j.prototype.EventListener(self)
	return {
		attack_event = function(k, l)
			local m = self:GetCaster()
			if l.attacker ~= m then
				return
			end
			local n = m:GetAbsOrigin()
			local o = CalcDirection2D(l.position, n)
			local p = self:GetSpecialValueFor("damage")
			m:SwordWave(m:GetAbsOrigin(), o, p, self.stack)
			self.stack = 0
		end,
	}
end
j = e({ i(nil) }, j)
return f