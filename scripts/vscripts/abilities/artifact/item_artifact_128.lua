--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_128"
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
		["13"] = 2,
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 11,
		["27"] = 19,
		["28"] = 11,
		["29"] = 19,
		["30"] = 20,
		["31"] = 21,
		["32"] = 20,
		["33"] = 26,
		["34"] = 27,
		["37"] = 30,
		["38"] = 31,
		["41"] = 34,
		["42"] = 34,
		["43"] = 35,
		["46"] = 38,
		["47"] = 41,
		["48"] = 42,
		["49"] = 43,
		["50"] = 43,
		["51"] = 43,
		["52"] = 43,
		["53"] = 43,
		["54"] = 43,
		["55"] = 43,
		["57"] = 26,
		["58"] = 47,
		["59"] = 48,
		["61"] = 47,
		["62"] = 19,
		["63"] = 11,
		["64"] = 11,
		["65"] = 11,
		["66"] = 11,
		["67"] = 11,
		["68"] = 11,
		["69"] = 11,
		["70"] = 11,
		["71"] = 19,
		["73"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.item_artifact_128 = c()
local n = g.item_artifact_128
n.name = "item_artifact_128"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_128"
end
n = e({ j(nil) }, n)
g.item_artifact_128 = n
g.modifier_item_artifact_128 = c()
local o = g.modifier_item_artifact_128
o.name = "modifier_item_artifact_128"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_ARTIFACT] = { -1, -1 } }
end
function o.prototype.OnSelectArtifact(self, p)
	if p.gift then
		return
	end
	local q = self:GetParent():GetPlayerOwnerID()
	if p.playerID ~= q then
		return
	end
	local r = PlayerData:getplayerData(q)
	local s = r and r.artifacts
	if not s then
		return
	end
	local t = GameState:getArtifactRounds()
	if #s == 3 and #t >= 3 then
		PlayerData:removeArtifact(q, "item_artifact_128")
		PlayerData:selectArtifactByRound(q, t[3], "item_artifact_128", nil, true)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
	end
end
o = e(
	{
		m(
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
g.modifier_item_artifact_128 = o
return g