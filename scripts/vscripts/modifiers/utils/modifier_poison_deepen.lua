--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_poison_deepen"
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
		["12"] = 4,
		["13"] = 12,
		["14"] = 4,
		["15"] = 12,
		["16"] = 13,
		["17"] = 14,
		["18"] = 13,
		["19"] = 16,
		["20"] = 17,
		["21"] = 18,
		["22"] = 19,
		["24"] = 16,
		["25"] = 22,
		["26"] = 23,
		["27"] = 24,
		["28"] = 24,
		["29"] = 24,
		["30"] = 24,
		["31"] = 24,
		["32"] = 24,
		["33"] = 24,
		["34"] = 25,
		["36"] = 22,
		["37"] = 28,
		["38"] = 29,
		["39"] = 28,
		["40"] = 33,
		["41"] = 34,
		["42"] = 33,
		["43"] = 12,
		["44"] = 4,
		["45"] = 4,
		["46"] = 4,
		["47"] = 4,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 4,
		["52"] = 12,
		["54"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_poison_deepen = c()
local k = g.modifier_poison_deepen
k.name = "modifier_poison_deepen"
d(k, i)
function k.prototype.GetTexture(self)
	return "viper_nethertoxin"
end
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:OnIntervalThink()
		self:StartIntervalThink(0.1)
	end
end
function k.prototype.OnIntervalThink(self)
	if IsServer() then
		local m = GetModifierProperty(self:GetParent(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DEEPEN)
			+ GetModifierProperty(self:GetCaster(), EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_PERMANENT_SOURCE)
		self:SetStackCount(m)
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_POISON_DAMAGE_BONUS_TARGET }
end
function k.prototype.EOM_GetModifierPoisonDamageBonusTarget(self)
	return self:GetStackCount()
end
k = e(
	{
		j(
			a,
			{
				IsHidden = false,
				IsDebuff = true,
				IsPurgable = false,
				IsPurgeException = true,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	k
)
g.modifier_poison_deepen = k
return g