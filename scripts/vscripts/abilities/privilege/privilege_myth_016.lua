--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_016"
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
k.name = "privilege_myth_016"
d(k, h)
function k.prototype.EventListener(self)
	return {
		lightning_storm = function(l, m)
			local n = self:GetCaster()
			if n == m.caster then
				local o = m.target:GetAbsOrigin()
				local p = FindEnemiesInRadius(n, o, self:GetSpecialValueFor("radius"), FIND_CLOSEST)
				do
					local q = 0
					while q < #p do
						do
							local r = p[q + 1]
							if r == m.target then
								goto s
							end
							local t = CalcDirection(o, r:GetAbsOrigin())
							local u = math.min(self.value, CalcDistance(o, r:GetAbsOrigin()))
							if u <= 0 or not r:IsAlive() or r:HasState(StateEnum.KNOCKBACK_IMMUNE) then
								goto s
							end
							local v = ParticleManager:CreateParticle(
								"particles/units/heroes/hero_stormspirit/stormspirit_electric_vortex.vpcf",
								PATTACH_ABSORIGIN,
								n
							)
							ParticleManager:SetParticleControl(v, 0, o)
							ParticleManager:SetParticleControlEnt(
								v,
								1,
								r,
								PATTACH_ABSORIGIN_FOLLOW,
								"attach_hitloc",
								r:GetAbsOrigin(),
								true
							)
							local w = false
							local function x()
								if w then
									return
								end
								w = true
								ParticleManager:DestroyParticle(v, true)
								ParticleManager:ReleaseParticleIndex(v)
							end
							r:KnockBack(t, u, 80, 0.8, x)
							Timer:GameTimer(0.9, x)
						end
						::s::
						q = q + 1
					end
				end
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f