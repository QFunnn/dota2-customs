--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/boss/boss_axe/boss_axe_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.AbilityValue
local i = g.EOMAbility
local j = g.registerEOMAbility
local k = c()
k.name = "boss_axe_1"
d(k, i)
function k.prototype.OnAbilityPhaseStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = l:GetAbsOrigin()
	local o = self:GetCastRange(vec3_zero, nil)
	local p = CalcDirection2D(m, n)
	local q = n + p * o
	self:LineWarning(n, q, self.radius, self:GetCastPoint())
	return true
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetCursorPosition()
	local n = l:GetAbsOrigin()
	local p = CalcDirection2D(m, n)
	local o = self:GetCastRange(vec3_zero, nil)
	local r = self:GetSpecialValueFor("damage")
	l:StartGesture(ACT_SCRIPT_CUSTOM_2)
	local s = o / self.speed
	l:SimulateCast({ duration = s })
	l:Dash(p, o, 0, s, function()
		l:FadeGesture(ACT_SCRIPT_CUSTOM_2)
	end)
	Bullet:CreateCustomBullet({
		caster = l,
		spawnOrigin = n,
		lifeTime = s,
		radius = self.radius,
		PathFunction = function(t)
			return l:GetAbsOrigin()
		end,
		FuncUnitFinder = function(u, v, w, x)
			local y = Bullet:FindUnitInLine(
				l:GetTeamNumber(),
				u,
				v,
				w,
				w,
				DOTA_UNIT_TARGET_TEAM_ENEMY,
				DOTA_UNIT_TARGET_HEROES_AND_CREEPS,
				DOTA_UNIT_TARGET_FLAG_NONE
			)
			local z = {}
			do
				local A = 0
				while A < #y do
					local B = y[A + 1]
					local C = B:GetAbsOrigin() - v
					if C.x * p.x + C.y * p.y > 0 then
						z[#z + 1] = B
					end
					A = A + 1
				end
			end
			return z
		end,
		OnBulletHit = function(B, v, x)
			l:DealDamage(B, nil, r)
		end,
	})
end
e({ h(nil) }, k.prototype, "speed", nil)
e({ h(nil) }, k.prototype, "distance", nil)
e({ h(nil) }, k.prototype, "radius", nil)
k = e({ j(nil) }, k)
return f