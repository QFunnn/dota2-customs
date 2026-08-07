--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_ultimate"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bleed_ultimate"
d(j, h)
function j.prototype.EventListener(self)
	return {
		ability_cast_complete = function(k, l)
			local m = self:GetCaster()
			if m ~= l.caster or l.abilityTag ~= AbilityTag.Ultimate then
				return
			end
			local n = self:GetSpecialValueFor("radius")
			local o = self:GetSpecialValueFor("damage")
			local p = FindUnitsInRadiusWithAbility(m, m:GetAbsOrigin(), n, self)
			for q, r in ipairs(p) do
				m:Bleed(r, o)
				r:KnockBack(CalcDirection2D(r, m), math.max(50, n - CalcDistance(r, m)), 0, 0.5)
			end
			local s = ParticleManager:CreateParticle(
				"particles/units/benediction/huskar_inner_fire.vpcf",
				PATTACH_ABSORIGIN,
				m
			)
			ParticleManager:ReleaseParticleIndex(s)
			m:EmitSound("Hero_Huskar.Inner_Fire.Cast")
		end,
	}
end
j = e({ i(nil) }, j)
return f