--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_vip_001"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.PrivilegeValue
local j = g.RegisterPrivilege
local k = c()
k.name = "privilege_vip_001"
d(k, h)
function k.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.effectValue = 0
	self.targetRarity = 2
end
function k.prototype.OnCreated(self)
	self:RefreshEffectValue()
end
function k.prototype.OnRefresh(self)
	h.prototype.OnRefresh(self)
	self:RefreshEffectValue()
end
function k.prototype.EventListener(self)
	return {
		service_data_change = function(l, m)
			if m.playerID ~= self:GetPlayerID() then
				return
			end
			if m.key ~= "player_collection_treasures" then
				return
			end
			self:RefreshEffectValue()
		end,
	}
end
function k.prototype.DynamicProperty(self)
	return {
		[PropertyFunction.ATTACK_CRIT_DAMAGE_BOOST] = function()
			return self.effectValue
		end,
		[PropertyFunction.SPELL_CRIT_DAMAGE] = function()
			return self.effectValue
		end,
	}
end
function k.prototype.RefreshEffectValue(self)
	if self.per_level <= 0 then
		self.effectValue = 0
		return
	end
	local n = PlayerData:GetCollectionTreasureTotalLevel(self:GetPlayerID(), self.targetRarity)
	local o = math.floor(n / self.per_level) * self.per_level_effect
	self.effectValue = math.min(self.effect_max, o)
end
e({ i(nil) }, k.prototype, "per_level", nil)
e({ i(nil) }, k.prototype, "per_level_effect", nil)
e({ i(nil) }, k.prototype, "effect_max", nil)
k = e({ j(nil) }, k)
return f