--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_003"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_003"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	local l = self:GetPlayerID()
	local m = PlayerResource:GetSelectedHeroName(l)
	if m ~= "npc_dota_hero_solthra" then
		return
	end
	local n = self:GetSpecialValueFor("crit_value")
	PropertySystem:AddStaticProperty(k:entindex(), "spell_crit_chance", "privilege_weapon_003", n)
end
function j.prototype.OnDestroy(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	PropertySystem:RemoveStaticProperty(k:entindex(), "privilege_weapon_003")
end
j = e({ i(nil) }, j)
return f