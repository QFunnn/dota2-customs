--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_dodge"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bleed_dodge"
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
			local n = self:GetSpecialValueFor("radius")
			local o = self:GetSpecialValueFor("damage")
			local p = self:GetSpecialValueFor("count")
			m:EmitSound("Hero_Shredder.WhirlingDeath.Cast")
			self.bulletID = Bullet:CreateCustomBullet({
				caster = m,
				spawnOrigin = m:GetAbsOrigin(),
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				radius = n,
				ParticleCreator = function(q)
					local r = ParticleManager:CreateParticle(
						"particles/econ/items/shredder/hero_shredder_icefx/shredder_chakram_spin_ice.vpcf",
						PATTACH_CUSTOMORIGIN,
						m
					)
					ParticleManager:SetParticleControlEnt(
						r,
						0,
						m,
						PATTACH_CENTER_FOLLOW,
						"attach_hitloc",
						m:GetAbsOrigin(),
						true
					)
					ParticleManager:SetParticleControlEnt(
						r,
						3,
						m,
						PATTACH_CENTER_FOLLOW,
						"attach_hitloc",
						m:GetAbsOrigin(),
						true
					)
					return r
				end,
				PathFunction = function(s, q)
					return m:GetAbsOrigin()
				end,
				FuncUnitFinder = function(t, s, n, q)
					return FindUnitsInRadius(
						m:GetTeamNumber(),
						s,
						nil,
						n,
						DOTA_UNIT_TARGET_TEAM_ENEMY,
						DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
						DOTA_UNIT_TARGET_FLAG_NONE,
						FIND_ANY_ORDER,
						false
					)
				end,
				OnBulletHit = function(u, v, w)
					u:TriggerBleed(m, p)
				end,
			})
		end,
		dash_end = function(k, l)
			if l.caster ~= self:GetCaster() then
				return
			end
			if self.bulletID ~= nil then
				Bullet:DestroyBulletByID(self.bulletID)
				self.bulletID = nil
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f