--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_poison_kill"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("lib.dota_ts_adapter")
local h = g.registerAbility
local i = require("abilities.eom_ability")
local j = i.EOMItem
local k = c()
k.name = "item_poison_kill"
d(k, j)
function k.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.enable = true
end
function k.prototype.EventListener(self)
	return {
		entity_killed = function(l, m)
			if m.attacker == self:GetCaster() and m.victim:IsPoisoned() and self.enable then
				self.enable = false
				local n = self:GetCaster()
				local o = m.victim:GetPoisonStack(n)
				local p = self:GetSpecialValueFor("damage")
				local q = self:GetSpecialValueFor("radius")
				local r = ParticleManager:CreateParticle(
					"particles/units/heroes/hero_sandking/sandking_caustic_finale_crimson_explode.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(r, 0, m.victim:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(r)
				local s = FindUnitsInRadiusWithAbility(n, m.victim:GetAbsOrigin(), q, self)
				for t, u in ipairs(s) do
					n:DealDamage(u, self, p, nil)
				end
				for t, u in ipairs(s) do
					n:Poison(u, o)
				end
				n:EmitSound("Ability.SandKing_CausticFinale", m.victim:GetAbsOrigin())
				self.enable = true
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f