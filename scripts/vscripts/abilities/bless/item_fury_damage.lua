--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_fury_damage"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_fury_damage"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.isDamageBonusActive = false
end
function j.prototype.OnCreated(self)
	self:UpdateDamageBonus(true)
	self:StartThink(0.3, "fury_damage", function()
		self:UpdateDamageBonus()
	end)
end
function j.prototype.OnRefresh(self)
	self:UpdateDamageBonus(true)
end
function j.prototype.OnDestroy(self)
	self:StartThink(-1, "fury_damage")
end
function j.prototype.StaticProperty(self)
	return {
		[PropertyFunction.DAMAGE_AMPLIFY] = self.isDamageBonusActive and self:GetSpecialValueFor("damage_bonus_pct")
			or 0,
	}
end
function j.prototype.UpdateDamageBonus(self, k)
	if k == nil then
		k = false
	end
	local l = self:GetCaster()
	if not IsValid(l) then
		return
	end
	local m = l:GetMaxMana() * self:GetSpecialValueFor("mana_threshold_pct") * 0.01
	local n = l:GetMana() >= m
	if not k and n == self.isDamageBonusActive then
		return
	end
	self.isDamageBonusActive = n
	self:RefreshStaticProperty()
end
j = e({ i(nil) }, j)
return f