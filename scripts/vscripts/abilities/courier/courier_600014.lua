--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/courier/courier_600014"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.AbilityValue
local l = j.EOMAbility
local m = j.registerEOMAbility
local n = require("abilities.courier.courier_base")
local o = n.CourierModifierBase
local p = n.CourierBuffConfig
local q = n.CourierMainConfig
local r = c()
r.name = "courier_600014"
d(r, l)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_courier_600014"
end
r = e({ m(nil) }, r)
local s = c()
s.name = "modifier_courier_600014"
d(s, o)
function s.prototype.GetBuffModifierName(self)
	return "modifier_courier_600014_buff"
end
s = e({ i(a, q) }, s)
local t = c()
t.name = "modifier_courier_600014_buff"
d(t, h)
function t.prototype.OnCreated(self, u)
	self.combo_count = 0
end
function t.prototype.OnDestroy(self)
	if IsServer() then
		print("销毁 modifier:", "combo_count:", self.combo_count, self.count)
	end
end
function t.prototype.EventListener(self)
	return {
		damage_event = function(v, w)
			local x = self:GetParent()
			local y = self:GetAbility()
			if
				IsServer()
				and IsValid(y)
				and w.attacker == x
				and IsValid(w.target)
				and w.damage_category == DOTA_DAMAGE_CATEGORY_ATTACK
				and w.ability ~= y
			then
				if not y:IsCooldownReady() then
					return
				end
				if self.last_target ~= nil and self.last_target ~= w.target then
					self.combo_count = 0
				end
				self.combo_count = self.combo_count + 1
				self.last_target = w.target
				if self.combo_count >= self.count then
					y:StartCooldown(self:GetAbilitySpecialValueFor("cd"))
					self.combo_count = 0
					local z = FindEnemiesInRadius(x, w.target:GetAbsOrigin(), self.blast_radius)
					local A = self:GetAbilitySpecialValueFor("blast_damage", x)
					x:DealDamage(z, y, A, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
					local B = ParticleManager:CreateParticle(
						"particles/units/heroes/hero_ogre_magi/ogre_magi_unr_fireblast_c.vpcf",
						PATTACH_CUSTOMORIGIN,
						x
					)
					ParticleManager:SetParticleControl(B, 0, w.target:GetAbsOrigin())
					ParticleManager:ReleaseParticleIndex(B)
				end
			end
		end,
	}
end
e({ k(nil) }, t.prototype, "count", nil)
e({ k(nil) }, t.prototype, "blast_radius", nil)
t = e({ i(a, p) }, t)
return f