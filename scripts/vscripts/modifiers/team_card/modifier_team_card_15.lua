--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/team_card/modifier_team_card_15"
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
		["11"] = 3,
		["12"] = 12,
		["13"] = 3,
		["14"] = 12,
		["15"] = 14,
		["16"] = 15,
		["17"] = 14,
		["18"] = 17,
		["19"] = 18,
		["20"] = 19,
		["21"] = 20,
		["23"] = 17,
		["24"] = 23,
		["25"] = 24,
		["26"] = 25,
		["28"] = 23,
		["29"] = 28,
		["30"] = 29,
		["31"] = 28,
		["32"] = 33,
		["33"] = 34,
		["34"] = 33,
		["35"] = 12,
		["36"] = 3,
		["37"] = 3,
		["38"] = 3,
		["39"] = 3,
		["40"] = 3,
		["41"] = 3,
		["42"] = 3,
		["43"] = 3,
		["44"] = 3,
		["45"] = 12,
		["47"] = 12,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_team_card_15 = c()
local k = g.modifier_team_card_15
k.name = "modifier_team_card_15"
d(k, i)
function k.prototype.GetAbilitySpecialValue(self)
	self.crit_chance = self:GetAbilityTalentValue("team_card_15", "crit_chance")
end
function k.prototype.OnCreated(self, l)
	print("添加15")
	if IsServer() then
		self:IncrementStackCount()
	end
end
function k.prototype.OnRefresh(self, l)
	if IsServer() then
		self:IncrementStackCount()
	end
end
function k.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_TEAM_CARD_ATTRIBUTE_CRIT_CHANCE_BONUS }
end
function k.prototype.EOM_GetModifierTeamCardAttributeCritChanceBonus(self)
	return self:GetStackCount() * self.crit_chance
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
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_team_card_15 = k
return g