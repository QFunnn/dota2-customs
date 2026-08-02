--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "content/c4/scripts/vscripts/modifiers/team_card/modifier_team_card_18.ts"
local b = getfenv()
if b then
	b.__TUI_FILEPATH = a
end
local c = require("lualib_bundle")
local d = c.__TS__Class
local e = c.__TS__ClassExtends
local f = c.__TS__DecorateLegacy
local g = c.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 9,
		["13"] = 3,
		["14"] = 9,
		["15"] = 11,
		["16"] = 12,
		["17"] = 13,
		["18"] = 11,
		["19"] = 15,
		["20"] = 16,
		["21"] = 15,
		["22"] = 20,
		["23"] = 20,
		["24"] = 23,
		["25"] = 23,
		["26"] = 9,
		["27"] = 3,
		["28"] = 9,
		["30"] = 9,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
h.modifier_team_card_18 = d()
local l = h.modifier_team_card_18
l.name = "modifier_team_card_18"
e(l, j)
function l.prototype.OnCreated(self, m)
	print("添加modifier_18")
	self.teammateID = m.teammateID
end
function l.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function l.prototype.OnRoundChange(self, m) end
function l.prototype.OnDestroy(self) end
l = f({ k(nil, { IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false }) }, l)
h.modifier_team_card_18 = l
return h