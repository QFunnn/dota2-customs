--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/modifier_ultra"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["12"] = 5,
		["13"] = 13,
		["14"] = 5,
		["15"] = 13,
		["17"] = 13,
		["18"] = 19,
		["19"] = 5,
		["20"] = 20,
		["21"] = 21,
		["22"] = 22,
		["23"] = 23,
		["24"] = 24,
		["25"] = 26,
		["26"] = 20,
		["27"] = 28,
		["28"] = 41,
		["29"] = 28,
		["30"] = 43,
		["31"] = 44,
		["32"] = 45,
		["33"] = 46,
		["34"] = 47,
		["36"] = 43,
		["37"] = 51,
		["38"] = 52,
		["39"] = 52,
		["40"] = 56,
		["41"] = 56,
		["42"] = 56,
		["43"] = 52,
		["44"] = 52,
		["45"] = 51,
		["46"] = 13,
		["47"] = 5,
		["48"] = 5,
		["49"] = 5,
		["50"] = 5,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 13,
		["57"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_ultra = c()
local k = g.modifier_ultra
k.name = "modifier_ultra"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.mana_regen_interval = FRAME_TIME
end
function k.prototype.OnIntervalThink(self)
	local l = self:GetParent()
	local m = GetManaRegen(self:GetParent())
	local n = Round(m * self.mana_regen_interval, 4)
	Restore(l, n, false)
	tryCastAbility(l)
end
function k.prototype.OnBattleStart(self, o)
	self:StartIntervalThink(self.mana_regen_interval)
end
function k.prototype.OnBattleEnd(self, o)
	local l = self:GetParent()
	local p = l:GetPlayerOwnerID()
	if p == o.winPlayerID or p == o.losePlayerID then
		self:StartIntervalThink(-1)
	end
end
function k.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
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
				AllowIllusionDuplicate = false,
				RemoveOnDeath = false,
			}
		),
	},
	k
)
g.modifier_ultra = k
return g