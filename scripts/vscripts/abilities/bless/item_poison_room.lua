--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_room"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayConcat
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = {}
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = i.registerEOMAbility
local l = c()
l.name = "item_poison_room"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.factor = 1
end
function l.prototype.OnCreated(self)
	self.bullet_poison = {}
	if IsServer() then
		self:PoisionBottle()
		self:StartThink(self:GetSpecialValueFor("intarval"), "poison_bottle_interval", function()
			self:PoisionBottle()
			return self:GetSpecialValueFor("intarval")
		end)
	end
end
function l.prototype.GetCircleRadius(self, m)
	if m == nil then
		m = self:GetCaster()
	end
	if not IsValid(m) then
		return 0
	end
	self.factor = m:IsRangedAttacker() and 0.6 or 1
	return m:Script_GetAttackRange() * self.factor
end
function l.prototype.PoisionBottle(self)
	local m = self:GetCaster()
	local n = self:GetSpecialValueFor("duration")
	if IsValid(m) then
		local o = m:PoisionBottle(
			n,
			self:GetSpecialValueFor("poison_stack"),
			self:GetCircleRadius(m),
			self:GetSpecialValueFor("speed")
		)
		if o and #o > 0 then
			self.poison_group = e(self.poison_group or {}, o)
		end
	end
end
function l.prototype.OnDestroy(self)
	if IsServer() and self.poison_group then
		f(self.poison_group, function(p, q)
			Bullet:DestroyBulletByID(q)
		end)
	end
end
l = g({ k(nil) }, l)
return h