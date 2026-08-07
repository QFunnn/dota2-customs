--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_170"
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
		["14"] = 5,
		["15"] = 6,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 6,
		["22"] = 5,
		["23"] = 6,
		["25"] = 6,
		["26"] = 12,
		["27"] = 19,
		["28"] = 12,
		["29"] = 19,
		["30"] = 21,
		["31"] = 21,
		["32"] = 24,
		["33"] = 25,
		["34"] = 26,
		["35"] = 26,
		["36"] = 26,
		["37"] = 27,
		["38"] = 31,
		["39"] = 31,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 31,
		["44"] = 31,
		["45"] = 32,
		["46"] = 33,
		["47"] = 34,
		["48"] = 35,
		["50"] = 26,
		["51"] = 26,
		["53"] = 24,
		["54"] = 19,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 19,
		["64"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_170 = c()
local n = g.trait_170
n.name = "trait_170"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_170"
end
n = e({ j(nil) }, n)
g.trait_170 = n
g.modifier_trait_170 = c()
local o = g.modifier_trait_170
o.name = "modifier_trait_170"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self) end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		GameTimer(GameRules:GetGameFrameTime(), function()
			local q = self:GetParent():GetPlayerOwnerID()
			local r = RuneTask:generateRandomRuneList(q, 1, RUNE_TASK_ROUNDS[1], { "trait_169" }, true)
			if r and #r > 0 then
				local s = r[1]
				PlayerData:setTraitAbility(q, s, 2)
				Notification:combatToPlayer(
					q,
					{
						message = "notify_artifact_ability_sr",
						string_itemname_artifact = "DOTA_Tooltip_ability_trait_170",
						string_ability_name = "DOTA_Tooltip_ability_" .. s,
					}
				)
			end
		end)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_170 = o
return g