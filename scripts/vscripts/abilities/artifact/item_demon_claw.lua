--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_demon_claw"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = require("abilities.eom_ability")
local k = j.EOMItem
local l = j.registerEOMAbility
local m = c()
m.name = "item_demon_claw"
d(m, k)
function m.prototype.EventListener(self)
	return {
		dash_start = function(n, o)
			local p = self:GetCaster()
			if o.caster == p then
				p:AddNewModifier(
					p,
					self,
					"modifier_item_demon_claw",
					{ duration = self:GetSpecialValueFor("duration") }
				)
			end
		end,
	}
end
m = e({ l(nil) }, m)
local q = c()
q.name = "modifier_item_demon_claw"
d(q, h)
function q.prototype.StaticProperty(self)
	return { [PropertyFunction.CRIT_CHANCE] = self:GetAbilitySpecialValueFor("crit_chance") }
end
q = e(
	{
		i(
			a,
			{
				IsHidden = false,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				IsStunDebuff = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	q
)
return f