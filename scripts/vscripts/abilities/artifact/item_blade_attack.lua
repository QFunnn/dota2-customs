--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_blade_attack"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_blade_attack"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if l.attacker ~= m or l.damage_category ~= DOTA_DAMAGE_CATEGORY_ATTACK then
				return
			end
			if not self:PRD(self:GetSpecialValueFor("chance")) then
				return
			end
			local n = self
			local o = m:GetAbsOrigin()
			local p = self:GetCursorPosition()
			local q = self:GetSpecialValueFor("distance")
			local r = self:GetSpecialValueFor("damage")
			local s = p - o
			s.z = 0
			if s == vec3_zero then
				s = m:GetForwardVector()
			end
			local t = ParticleManager:CreateParticle(
				"particles/units/heroes/hero_kez/kez_katana_echo_strike_survivors.vpcf",
				PATTACH_ABSORIGIN,
				m
			)
			ParticleManager:SetParticleControl(t, 0, o)
			ParticleManager:SetParticleControl(t, 1, o + s:Normalized() * q)
			ParticleManager:SetParticleControl(t, 2, Vector(3000, 200, 1.5))
			ParticleManager:ReleaseParticleIndex(t)
			Bullet:CreateLinearBullet({
				caster = m,
				ability = n,
				spawnOrigin = o,
				direction = s:Normalized(),
				startRadius = 200,
				endRadius = 200,
				debug = true,
				teamFilter = DOTA_UNIT_TARGET_TEAM_ENEMY,
				typeFilter = DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				flagFilter = DOTA_UNIT_TARGET_FLAG_NONE,
				moveSpeed = 3000,
				distance = q,
				OnBulletHit = function(u, v, w)
					m:DealDamage(u, n, r)
				end,
			})
		end,
	}
end
j = e({ i(nil) }, j)
return f