--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_suit_006"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.tstl-utils")
local h = g.reloadable
local i = require("abilities.eom_privilege")
local j = i.EOMPrivilege
local k = i.RegisterPrivilege
local l = c()
l.name = "privilege_suit_006"
d(l, j)
function l.prototype.EventListener(self)
	return {
		dash_start = function(m, n)
			local o = self:GetCaster()
			if n.caster == o then
				local p = self:GetSpecialValueFor("shield")
				if self.bulletID then
					Bullet:DestroyBulletByID(self.bulletID)
					self.bulletID = nil
				end
				self.bulletID = Bullet:CreateCustomBullet({
					caster = o,
					spawnOrigin = o:GetAbsOrigin(),
					teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
					typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
					radius = 160,
					lifeTime = 2,
					PathFunction = function(q, r)
						return o:GetAbsOrigin()
					end,
					FuncUnitFinder = function(s, q, t, r)
						return FindUnitsInRadius(
							o:GetTeamNumber(),
							q,
							nil,
							t,
							DOTA_UNIT_TARGET_TEAM_ENEMY,
							DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
							DOTA_UNIT_TARGET_FLAG_NONE,
							FIND_ANY_ORDER,
							false
						)
					end,
					OnBulletHit = function(u, v, w)
						o:AddShield(p)
					end,
				})
			end
		end,
		dash_end = function(m, n)
			local o = self:GetCaster()
			if n.caster == o and self.bulletID then
				Bullet:DestroyBulletByID(self.bulletID)
				self.bulletID = nil
			end
		end,
	}
end
l = e({ h, k(nil) }, l)
return f