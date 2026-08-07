--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_vip_003"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.PrivilegeValue
local l = i.RegisterPrivilege
local m = c()
m.name = "privilege_vip_003"
d(m, j)
function m.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.effectValue = 0
end
function m.prototype.OnCreated(self)
	self:RefreshEffectValue()
end
function m.prototype.OnRefresh(self)
	j.prototype.OnRefresh(self)
	self:RefreshEffectValue()
end
function m.prototype.EventListener(self)
	return {
		service_data_change = function(n, o)
			if o.playerID ~= self:GetPlayerID() then
				return
			end
			if o.key ~= "player_collection_treasures" then
				return
			end
			self:RefreshEffectValue()
		end,
	}
end
function m.prototype.RefreshEffectValue(self)
	local p = 0
	if self.per_level <= 0 then
		self:ApplyStaticProperties(p)
		return
	end
	local q = PlayerData:GetCollectionTreasureTotalLevel(self:GetPlayerID(), self.target_rarity)
	local r = math.floor(q / self.per_level) * self.per_level_effect
	p = math.min(self.effect_max, r)
	self:ApplyStaticProperties(p)
end
function m.prototype.ApplyStaticProperties(self, p)
	self.effectValue = p
	local s = self:GetCaster()
	if not IsValid(s) then
		return
	end
	PropertySystem:RemoveStaticProperty(s:entindex(), self.privilegeName)
	PropertySystem:AddStaticProperty(s:entindex(), "damage_intensity_boost", self.privilegeName, self.effectValue)
	PropertySystem:AddStaticProperty(s:entindex(), "defense_intensity_boost", self.privilegeName, self.effectValue)
end
e({ k(nil) }, m.prototype, "per_level", nil)
e({ k(nil) }, m.prototype, "per_level_effect", nil)
e({ k(nil) }, m.prototype, "effect_max", nil)
e({ k(nil) }, m.prototype, "target_rarity", nil)
m = e({ h, l(nil) }, m)
return f