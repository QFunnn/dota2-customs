--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_ice_frostmourne"
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
k.name = "item_ice_frostmourne"
d(k, j)
function k.prototype.EventListener(self)
	return {
		frozen_attenation = function(l, m)
			local n = self:GetCaster()
			if m.caster == n then
				local o = self:GetSpecialValueFor("damage")
				n:DealDamage(
					m.target,
					self,
					math.ceil((m.oldStack - m.newStack) * o * 0.01),
					EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE,
					EOM_DAMAGE_FLAGS.FREEZE_DAMAGE
				)
				local p = ParticleManager:CreateParticle(
					"particles/units/benediction/ice_curse_blade.vpcf",
					PATTACH_ABSORIGIN_FOLLOW,
					m.target
				)
				ParticleManager:ReleaseParticleIndex(p)
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f