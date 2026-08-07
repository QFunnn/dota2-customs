--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_counter"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_bleed_counter"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enableTime = GameRules:GetGameTime()
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			local m = self:GetCaster()
			if m ~= l.target then
				return
			end
			if self.enableTime > GameRules:GetGameTime() then
				return
			end
			local n = self:GetSpecialValueFor("damage")
			local o = self:GetSpecialValueFor("distance")
			self.enableTime = GameRules:GetGameTime() + COUNTER_CD
			local p = FindEnemiesInRadius(m, m:GetAbsOrigin(), o)
			for q, r in ipairs(p) do
				m:DealDamage(r, nil, n)
				r:KnockBack(CalcDirection2D(r, m), 150, 0, 0.3)
			end
			local s = ParticleManager:CreateParticle(
				"particles/econ/items/axe/axe_weapon_bloodchaser/axe_attack_blur_counterhelix_bloodchaser.vpcf",
				PATTACH_ABSORIGIN_FOLLOW,
				m
			)
			ParticleManager:ReleaseParticleIndex(s)
			m:EmitSound("Hero_Axe.CounterHelix_Blood_Chaser")
		end,
	}
end
j = e({ i(nil) }, j)
return f