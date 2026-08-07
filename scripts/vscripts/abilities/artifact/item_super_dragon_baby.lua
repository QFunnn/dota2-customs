--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_super_dragon_baby"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_super_dragon_baby"
d(m, k)
function m.prototype.OnCreated(self)
	self.wisp = self:GetCaster():CreateWisp(
		"super_baby_dragon",
		{ attack = 0, attack_speed = 200, attack_ability_name = "super_baby_dragon_attack" }
	)
	local n = self.wisp
	if n ~= nil then
		n:AddNewModifier(self:GetCaster(), self, "modifier_item_super_dragon_baby_wisp", nil)
	end
end
function m.prototype.OnDestroy(self)
	if IsValid(self.wisp) then
		self:GetCaster():RemoveWisp(self.wisp)
		self.wisp = nil
	end
end
m = e({ l(nil) }, m)
local o = c()
o.name = "modifier_item_super_dragon_baby_wisp"
d(o, h)
function o.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.attack = 0
	self.attackspeed = 0
end
function o.prototype.EventListener(self)
	return {
		attack_event = function(p, q)
			local r = self:GetCaster()
			if q.attacker == self:GetParent() and IsValid(r) then
				self.attack = r:GetAttackDamage() * 2
				self:RegisterStaticProperties()
			end
		end,
	}
end
function o.prototype.StaticProperty(self)
	return { [PropertyFunction.ATTACK] = self.attack }
end
o = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	o
)
return f