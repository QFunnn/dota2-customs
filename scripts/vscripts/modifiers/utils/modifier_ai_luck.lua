--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/utils/modifier_ai_luck"
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
		["16"] = 14,
		["17"] = 15,
		["18"] = 16,
		["20"] = 14,
		["21"] = 19,
		["22"] = 20,
		["23"] = 19,
		["24"] = 22,
		["25"] = 23,
		["26"] = 22,
		["27"] = 27,
		["28"] = 28,
		["29"] = 27,
		["30"] = 32,
		["31"] = 33,
		["32"] = 32,
		["33"] = 35,
		["34"] = 36,
		["35"] = 36,
		["36"] = 36,
		["37"] = 36,
		["38"] = 36,
		["39"] = 36,
		["40"] = 36,
		["41"] = 35,
		["42"] = 12,
		["43"] = 4,
		["44"] = 4,
		["45"] = 4,
		["46"] = 4,
		["47"] = 4,
		["48"] = 4,
		["49"] = 4,
		["50"] = 4,
		["51"] = 12,
		["53"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_ai_luck = c()
local k = g.modifier_ai_luck
k.name = "modifier_ai_luck"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self:SetStackCount(l.maxLuck)
	end
end
function k.prototype.OnRefresh(self, l)
	self:OnCreated(l)
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_LUCK }
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function k.prototype.EOM_GetModifierLuck(self)
	return self.luck
end
function k.prototype.OnRoundStart(self)
	self.luck =
		Script_RemapValClamped(Rounds.roundNumber, 1, 16, math.ceil(self:GetStackCount() * 0.5), self:GetStackCount())
end
k = e(
	{
		j(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				RemoveOnDeath = false,
				AllowIllusionDuplicate = false,
			}
		),
	},
	k
)
g.modifier_ai_luck = k
return g