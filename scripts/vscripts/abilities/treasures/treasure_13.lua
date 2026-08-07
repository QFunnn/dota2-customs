--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_13"
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
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 20,
		["34"] = 19,
		["35"] = 18,
		["36"] = 23,
		["37"] = 24,
		["38"] = 25,
		["39"] = 25,
		["40"] = 25,
		["41"] = 25,
		["42"] = 25,
		["43"] = 25,
		["44"] = 23,
		["45"] = 17,
		["46"] = 10,
		["47"] = 10,
		["48"] = 10,
		["49"] = 10,
		["50"] = 10,
		["51"] = 10,
		["52"] = 10,
		["53"] = 17,
		["55"] = 17,
		["56"] = 28,
		["57"] = 35,
		["58"] = 28,
		["59"] = 35,
		["60"] = 37,
		["61"] = 38,
		["62"] = 37,
		["63"] = 40,
		["64"] = 41,
		["65"] = 42,
		["66"] = 43,
		["67"] = 44,
		["68"] = 45,
		["69"] = 46,
		["70"] = 47,
		["72"] = 47,
		["74"] = 47,
		["75"] = 48,
		["78"] = 51,
		["80"] = 40,
		["81"] = 54,
		["82"] = 55,
		["83"] = 54,
		["84"] = 57,
		["85"] = 58,
		["86"] = 57,
		["87"] = 35,
		["88"] = 28,
		["89"] = 28,
		["90"] = 28,
		["91"] = 28,
		["92"] = 28,
		["93"] = 28,
		["94"] = 28,
		["95"] = 35,
		["97"] = 35,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_13 = c()
local n = g.treasure_13
n.name = "treasure_13"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_13"
end
n = e({ j(nil) }, n)
g.treasure_13 = n
g.modifier_treasure_13 = c()
local o = g.modifier_treasure_13
o.name = "modifier_treasure_13"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_13_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_13_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_13 = o
g.modifier_treasure_13_buff = c()
local q = g.modifier_treasure_13_buff
q.name = "modifier_treasure_13_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.damageBonus = self:GetAbilitySpecialValueFor("damage_bonus")
end
function q.prototype.OnCreated(self)
	if IsServer() then
		local r = self:GetParent():GetHeroBase()
		local s = r and r:getAbilityUpgradeData(true, true) or {}
		local t = 0
		for u, v in pairs(s) do
			local w = tostring(u)
			local x = KeyValues.AbilityUpgradesKvs[w]
			if x ~= nil then
				x = x.rarity
			end
			if x == "n" and v.level >= SECT_ABILITY_LEVEL.n then
				t = t + 1
			end
		end
		self:SetStackCount(t)
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function q.prototype.EOM_GetModifierOutgoingDamagePercentage(self)
	return self.damageBonus * self:GetStackCount()
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_13_buff = q
return g