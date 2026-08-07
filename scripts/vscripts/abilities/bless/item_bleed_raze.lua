--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/bless/item_bleed_raze"
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
k.name = "item_bleed_raze"
d(k, j)
function k.prototype.EventListener(self)
	return {
		dash_start = function(l, m)
			if m.caster == self:GetCaster() then
				local n = self:GetSpecialValueFor("damage")
				local o = FindEnemiesInRadius(self:GetCaster(), m.start, self:GetSpecialValueFor("radius"))
				for p, q in ipairs(o) do
					self:GetCaster():DealDamage(q, self, n, EOM_DAMAGE_TYPES.DAMAGE_TYPE_NONE)
					local r = CalcDistance(m.start, q:GetAbsOrigin())
					local s = CalcDirection2D(m.start, q)
					q:KnockBack(s, r * 0.5, 0, 0.2)
				end
				local t = ParticleManager:CreateParticle(
					"particles/units/benediction/sf_fire_arcana_shadowraze.vpcf",
					PATTACH_CUSTOMORIGIN,
					nil
				)
				ParticleManager:SetParticleControl(t, 0, m.start)
				m.caster:EmitSound("Hero_Nevermore.Shadowraze")
			end
		end,
	}
end
k = e({ h(nil) }, k)
return f