--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_bless_030"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__DecorateLegacy
local g = {}
local h = require("abilities.eom_privilege")
local i = h.EOMPrivilege
local j = h.RegisterPrivilege
local k = c()
k.name = "privilege_bless_030"
d(k, i)
function k.prototype.OnCreated(self)
	self:RefreshDamageBonus()
end
function k.prototype.OnRefresh(self)
	i.prototype.OnRefresh(self)
	self:RefreshDamageBonus()
end
function k.prototype.EventListener(self)
	return {
		bless_suit_changed = function(l, m)
			if m.playerID == self:GetPlayerID() then
				self:RefreshDamageBonus()
			end
		end,
	}
end
function k.prototype.RefreshDamageBonus(self)
	local n = self:GetCaster()
	if not n then
		return
	end
	local o = #e(n:GetAllItems(), function(l, p)
		return p:GetAccess() == "Bless" and Bless:IsBlessOfSuit(p:GetAbilityName(), "Wind")
	end)
	local q = o * self:GetSpecialValueFor("damage_per_bless")
	if self.damageBonus == q then
		return
	end
	self.damageBonus = q
	self:RefreshStaticProperty()
	print(string.format("[privilege_bless_030] Player %d wind blessings=%d damage bonus=%g", self:GetPlayerID(), o, q))
end
function k.prototype.StaticProperty(self)
	return {
		[PropertyFunction.PHYSICAL_DAMAGE_AMPLIFY] = self.damageBonus or 0,
		[PropertyFunction.MAGICAL_DAMAGE_AMPLIFY] = self.damageBonus or 0,
	}
end
k = f({ j(nil) }, k)
return g