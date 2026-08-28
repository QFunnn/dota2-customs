--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_wind_blade"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_wind_blade"
d(j, h)
function j.prototype.EventListener(self)
	return {
		dash_start = function(k, l)
			if l.caster ~= self:GetCaster() then
				return
			end
			if self.bulletID ~= nil then
				Bullet:DestroyBulletByID(self.bulletID)
				self.bulletID = nil
			end
			local m = self:GetCaster()
			self.bulletID = Bullet:CreateCustomBullet({
				caster = m,
				spawnOrigin = m:GetAbsOrigin(),
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				radius = 200,
				debug = true,
				PathFunction = function(n, o)
					return m:GetAbsOrigin()
				end,
				FuncUnitFinder = function(p, n, q, o)
					return FindUnitsInRadius(
						m:GetTeamNumber(),
						n,
						nil,
						q,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						DOTA_UNIT_TARGET_FLAG_NONE,
						FIND_ANY_ORDER,
						false
					)
				end,
				OnBulletHit = function(r, s, t)
					m:DealDamage(r, self, self:GetSpecialValueFor("damage"), EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
				end,
			})
		end,
		dash_end = function(k, l)
			if l.caster ~= self:GetCaster() then
				return
			end
			if self.bulletID ~= nil then
				Bullet:DestroyBulletByID(self.bulletID)
			end
		end,
	}
end
function j.prototype.OnDestroy(self)
	if self.bulletID ~= nil then
		Bullet:DestroyBulletByID(self.bulletID)
		self.bulletID = nil
	end
end
j = e({ i(nil) }, j)
return f