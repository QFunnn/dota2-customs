--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_22"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["13"] = 5,
		["14"] = 5,
		["15"] = 5,
		["16"] = 5,
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 7,
		["22"] = 8,
		["23"] = 9,
		["24"] = 10,
		["25"] = 11,
		["26"] = 7,
		["27"] = 19,
		["28"] = 27,
		["29"] = 19,
		["30"] = 27,
		["31"] = 29,
		["32"] = 30,
		["33"] = 29,
		["34"] = 32,
		["35"] = 33,
		["36"] = 32,
		["37"] = 36,
		["38"] = 37,
		["39"] = 36,
		["40"] = 27,
		["41"] = 19,
		["42"] = 19,
		["43"] = 19,
		["44"] = 19,
		["45"] = 19,
		["46"] = 19,
		["47"] = 19,
		["48"] = 19,
		["49"] = 27,
		["51"] = 27,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_22 = c()
local m = g.greevil_effect_22
m.name = "greevil_effect_22"
d(m, l)
function m.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.flag = false
end
function m.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_22", {})
	local n = self:getSpecialValueFor("gold")
	PlayerData:modifyGold(self.playerID, n)
	Notification:combatToPlayer(
		self.playerID,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.name, int_gold = n }
	)
end
g.modifier_greevil_effect_22 = c()
local o = g.modifier_greevil_effect_22
o.name = "modifier_greevil_effect_22"
d(o, i)
function o.prototype.GetAbilitySpecialValue(self)
	self.interest_limit_bonus = self:GetGreevilEffectValueFor("greevil_effect_22", "interest_limit_bonus")
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self, p)
	return self.interest_limit_bonus
end
o = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	o
)
g.modifier_greevil_effect_22 = o
return g