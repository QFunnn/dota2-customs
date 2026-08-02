--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_holy_bleed"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_holy_bleed"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function j.prototype.EventListener(self)
	return {
		consume_shield = function(k, l)
			local m = self:GetCaster()
			local n = l.damageEvent
			if m == n.target then
				if self.enableTime > GameRules:GetGameTime() then
					return
				end
				local o = m:GetAbsOrigin()
				local p = CalcDirection2D(n.attacker, m)
				local q = self:GetSpecialValueFor("damage")
				local r = 500
				local s = 140
				self.enableTime = GameRules:GetGameTime() + COUNTER_CD
				local t = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_mars/mars_shield_bash.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControlTransformForward(t, 0, m:GetAbsOrigin(), p)
				ParticleManager:SetParticleControl(t, 1, Vector(r, r, r))
				ParticleManager:ReleaseParticleIndex(t)
				local u = FindUnitsInSector(
					m:GetTeamNumber(),
					o,
					r,
					p,
					s,
					self:GetAbilityTargetTeam(),
					self:GetAbilityTargetType(),
					self:GetAbilityTargetFlags(),
					FIND_ANY_ORDER
				)
				for v, w in ipairs(u) do
					local t = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_mars/mars_shield_bash_crit.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControlTransformForward(t, 0, w:GetAbsOrigin(), CalcDirection(w, m))
					m:DealDamage(w, self, q)
					w:KnockBack(CalcDirection2D(w, m), 100, 0, 0.3)
				end
				m:EmitSound("Hero_Mars.Shield.Cast")
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f