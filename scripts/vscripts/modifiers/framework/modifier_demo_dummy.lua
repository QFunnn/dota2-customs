--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/framework/modifier_demo_dummy"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.registerEOMModifier
local j = c()
j.name = "modifier_demo_dummy"
d(j, h)
function j.prototype.EventListener(self)
	return {
		damage_event = function(k, l)
			if l.target == self:GetParent() then
				l.target:StartGesture(ACT_DOTA_FLINCH)
			end
		end,
	}
end
function j.prototype.StaticProperty(self)
	return { [PropertyFunction.MIN_HEALTH] = 1 }
end
function j.prototype.StaticState(self)
	return { [StateEnum.KNOCKBACK_IMMUNE] = true }
end
j = e(
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
	j
)
return f