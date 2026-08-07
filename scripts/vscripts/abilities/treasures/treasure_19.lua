--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_19"
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
		["56"] = 29,
		["57"] = 36,
		["58"] = 29,
		["59"] = 36,
		["61"] = 36,
		["62"] = 39,
		["63"] = 29,
		["64"] = 40,
		["65"] = 41,
		["66"] = 42,
		["67"] = 40,
		["68"] = 44,
		["69"] = 45,
		["70"] = 44,
		["71"] = 47,
		["72"] = 48,
		["73"] = 47,
		["74"] = 50,
		["75"] = 54,
		["76"] = 55,
		["77"] = 55,
		["78"] = 54,
		["79"] = 50,
		["80"] = 58,
		["81"] = 59,
		["82"] = 59,
		["83"] = 59,
		["84"] = 59,
		["85"] = 60,
		["87"] = 58,
		["88"] = 36,
		["89"] = 29,
		["90"] = 29,
		["91"] = 29,
		["92"] = 29,
		["93"] = 29,
		["94"] = 29,
		["95"] = 29,
		["96"] = 36,
		["98"] = 36,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_19 = c()
local n = g.treasure_19
n.name = "treasure_19"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_19"
end
n = e({ j(nil) }, n)
g.treasure_19 = n
g.modifier_treasure_19 = c()
local o = g.modifier_treasure_19
o.name = "modifier_treasure_19"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_treasure_19_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_19_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_19 = o
g.modifier_treasure_19_buff = c()
local q = g.modifier_treasure_19_buff
q.name = "modifier_treasure_19_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.count = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.manaRegen = self:GetAbilitySpecialValueFor("mana_regen")
	self.limit = self:GetAbilitySpecialValueFor("max_ult_cnt")
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_MANA_REGEN_BONUS }
end
function q.prototype.EOM_GetModifierManaRegenBonus(self)
	return self.manaRegen
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function q.prototype.OnCustomAbilityFullyCast(self)
	local r, s = self, "count"
	local t = r[s] + 1
	r[s] = t
	if t >= self.limit then
		self:Destroy()
	end
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_19_buff = q
return g