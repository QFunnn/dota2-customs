--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_curse"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("abilities.eom_ability")
local h = g.EOMItem
local i = g.registerEOMAbility
local j = c()
j.name = "item_ice_curse"
d(j, h)
function j.prototype.____constructor(self, ...)
	h.prototype.____constructor(self, ...)
	self.enable = true
end
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if l.attacker == self:GetCaster() and not l.target:IsBreakable() and self.enable then
				self.enable = false
				local m = self:GetSpecialValueFor("threshold")
				local n = self:GetSpecialValueFor("radius")
				local o = self:GetSpecialValueFor("damage")
				if not l.target:IsAlive() or l.target:GetHealthPercent() <= m then
					local p = self:GetCaster()
					p:DealDamage(
						l.target,
						self,
						l.target:GetHealth(),
						EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE,
						EOM_DAMAGE_FLAGS.FREEZE_DAMAGE
					)
					local q = FindUnitsInRadiusWithAbility(p, l.target:GetAbsOrigin(), n, self)
					for r, s in ipairs(q) do
						p:Frozen(s)
						p:DealDamage(s, self, o, nil, EOM_DAMAGE_FLAGS.FREEZE_DAMAGE)
					end
					local t = ParticleManager:CreateParticle(
						"particles/units/benediction/ice_curse.vpcf",
						PATTACH_CUSTOMORIGIN,
						nil
					)
					ParticleManager:SetParticleControl(t, 3, l.target:GetAbsOrigin())
					ParticleManager:SetParticleControl(t, 1, Vector(n, n, n))
					ParticleManager:SetParticleControl(t, 2, Vector(n, 0, 0))
					ParticleManager:ReleaseParticleIndex(t)
					p:EmitSound("Hero_Crystal.CrystalNova")
				end
				self.enable = true
			end
		end,
	}
end
j = e({ i(nil) }, j)
return f