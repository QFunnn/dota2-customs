--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/key/modifier_debuff_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = {}
local g = require("modifiers.eom_modifier.eom_modifier")
local h = g.EOMModifier
local i = g.TransmitterData
local j = g.registerEOMModifier
local k = c()
k.name = "modifier_debuff_1"
d(k, h)
function k.prototype.OnCreated(self, l)
	self.level = l.level
end
function k.prototype.StaticProperty(self)
	return {
		[PropertyFunction.MOVESPEED_AMPLIFY] = KeyValues:GetKvAbilityValue(
			KeyValues.keys,
			"key_debuff_1",
			"speed_pct",
			self.level
		),
		[PropertyFunction.ATTACKSPEED_REDUCTION] = -KeyValues:GetKvAbilityValue(
			KeyValues.keys,
			"key_debuff_1",
			"speed_pct",
			self.level
		),
	}
end
e({ i(nil) }, k.prototype, "level", nil)
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				RemoveOnDeath = true,
			}
		),
	},
	k
)
return f