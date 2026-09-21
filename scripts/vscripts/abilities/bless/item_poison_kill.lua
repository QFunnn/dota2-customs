--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
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
				do
					local n, o = pcall(function()
						local p = self:GetCaster()
						local q = m.victim:GetPoisonStack(p)
						local r = self:GetSpecialValueFor("damage")
						local s = self:GetSpecialValueFor("radius")
						local t = m.victim:GetAbsOrigin()
						local u = ParticleManager:CreateParticle(
							"particles/units/heroes/hero_sandking/sandking_caustic_finale_crimson_explode.vpcf",
							PATTACH_CUSTOMORIGIN,
							nil
						)
						if u ~= -1 then
							ParticleManager:SetParticleControl(u, 0, t)
							ParticleManager:ReleaseParticleIndex(u)
						end
						local v = FindUnitsInRadiusWithAbility(p, t, s, self)
						for w, x in ipairs(v) do
							p:DealDamage(x, self, r, nil)
						end
						for w, x in ipairs(v) do
							p:Poison(x, q)
						end
						p:EmitSound("Ability.SandKing_CausticFinale", t)
					end)
					do
						self.enable = true
					end
					if not n then
						error(o, 0)
					end
				end
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f