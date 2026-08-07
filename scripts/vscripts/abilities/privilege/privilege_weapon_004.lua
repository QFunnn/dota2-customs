--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_weapon_004"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_privilege")
local h = g.EOMPrivilege
local i = g.RegisterPrivilege
local j = c()
j.name = "privilege_weapon_004"
d(j, h)
function j.prototype.OnCreated(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	local l = self:GetPlayerID()
	local m = PlayerResource:GetSelectedHeroName(l)
	if m ~= "npc_dota_hero_seraphon" then
		print(
			string.format(
				"玩家 %d 选择的英雄是 %s，不满足圣骑出场的条件，无法获得最大生命值提升",
				l,
				m
			)
		)
		return
	end
	local n = self:GetSpecialValueFor("max_health_bonus")
	PropertySystem:AddStaticProperty(k:entindex(), "health", "privilege_weapon_004", n)
end
function j.prototype.OnDestroy(self)
	local k = self:GetCaster()
	if not IsValid(k) then
		return
	end
	PropertySystem:RemoveStaticProperty(k:entindex(), "privilege_weapon_004")
end
j = e({ i(nil) }, j)
return f