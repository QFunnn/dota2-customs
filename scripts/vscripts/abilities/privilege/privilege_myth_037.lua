--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/privilege/privilege_myth_037"
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
k.name = "privilege_myth_037"
d(k, h)
function k.prototype.OnCreated(self)
	self.interval = self:GetSpecialValueFor("interval")
end
function k.prototype.EventListener(self)
	return {
		ability_cast_complete = function(l, m)
			local n = self:GetCaster()
			if
				IsValid(n)
				and m.caster == n
				and self:IsCooldownReady()
				and m.abilityTag == AbilityTag.Ultimate
				and self:PRD(self.value)
			then
				local o = FindEnemiesInRadius(n, n:GetAbsOrigin(), n:Script_GetAttackRange(), FIND_CLOSEST)
				local p = self:GetSpecialValueFor("damage")
				local q = Vector(0, 0, 1)
				for r, s in ipairs(o) do
					local t = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(t, 1, s:GetAbsOrigin())
					local u = CalcDirection(s, n)
					local v = q:Cross(u):Normalized()
					ParticleManager:SetParticleControlOrientationFLU(t, 1, u, v, q)
					ParticleManager:ReleaseParticleIndex(t)
					n:DealDamage(s, nil, p, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE, EOM_DAMAGE_FLAGS.RETALIATED_DAMAGE)
				end
				self:StartCooldown(self.interval)
			end
		end,
	}
end
e({ i(nil) }, k.prototype, "value", nil)
k = e({ j(nil) }, k)
return f