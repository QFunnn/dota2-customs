--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_16"
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
		["11"] = 3,
		["12"] = 3,
		["13"] = 5,
		["14"] = 5,
		["15"] = 5,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 6,
		["20"] = 12,
		["21"] = 21,
		["22"] = 12,
		["23"] = 21,
		["25"] = 21,
		["26"] = 22,
		["27"] = 12,
		["28"] = 23,
		["29"] = 24,
		["30"] = 23,
		["31"] = 28,
		["32"] = 29,
		["35"] = 30,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["39"] = 34,
		["40"] = 35,
		["41"] = 35,
		["42"] = 36,
		["44"] = 37,
		["45"] = 37,
		["46"] = 38,
		["47"] = 37,
		["52"] = 28,
		["53"] = 21,
		["54"] = 12,
		["55"] = 12,
		["56"] = 12,
		["57"] = 12,
		["58"] = 12,
		["59"] = 12,
		["60"] = 12,
		["61"] = 12,
		["62"] = 12,
		["63"] = 21,
		["65"] = 21,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
local k = require("abilities.greevil_effect.greevil_effect_base")
local l = k.GreevilEffectBase
g.greevil_effect_16 = c()
local m = g.greevil_effect_16
m.name = "greevil_effect_16"
d(m, l)
function m.prototype.spawn(self)
	self:AddCourierBuff("modifier_greevil_effect_16", {})
end
g.modifier_greevil_effect_16 = c()
local n = g.modifier_greevil_effect_16
n.name = "modifier_greevil_effect_16"
d(n, i)
function n.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.trigger = false
end
function n.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { -1, -1 } }
end
function n.prototype.OnAbilityBuy(self, o)
	if o.playerhero:GetPlayerOwnerID() ~= self:GetParent():GetPlayerOwnerID() then
		return
	end
	if not self.trigger then
		local p = KeyValues.AbilityUpgradesKvs[o.abilityname]
		if p and p.rarity == "r" then
			self.trigger = true
			local q = o.heroclass
			local r = q:getAbilityUpgradeData(true, true)[o.abilityname]
			local s = r and r.level or 1
			local t = SECT_ABILITY_LEVEL.r - s
			do
				local u = 0
				while u < t do
					q:learnAbility(o.abilityname, true)
					u = u + 1
				end
			end
		end
	end
end
n = e(
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
	n
)
g.modifier_greevil_effect_16 = n
return g