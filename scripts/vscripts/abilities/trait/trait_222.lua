--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_222"
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
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 22,
		["34"] = 21,
		["35"] = 20,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 27,
		["43"] = 27,
		["44"] = 25,
		["45"] = 19,
		["46"] = 12,
		["47"] = 12,
		["48"] = 12,
		["49"] = 12,
		["50"] = 12,
		["51"] = 12,
		["52"] = 12,
		["53"] = 19,
		["55"] = 19,
		["56"] = 31,
		["57"] = 39,
		["58"] = 31,
		["59"] = 39,
		["60"] = 41,
		["61"] = 42,
		["62"] = 41,
		["63"] = 44,
		["64"] = 45,
		["65"] = 46,
		["66"] = 46,
		["67"] = 45,
		["68"] = 44,
		["69"] = 49,
		["70"] = 50,
		["73"] = 51,
		["74"] = 52,
		["75"] = 52,
		["76"] = 52,
		["77"] = 52,
		["78"] = 52,
		["79"] = 52,
		["80"] = 49,
		["81"] = 39,
		["82"] = 31,
		["83"] = 31,
		["84"] = 31,
		["85"] = 31,
		["86"] = 31,
		["87"] = 31,
		["88"] = 31,
		["89"] = 31,
		["90"] = 39,
		["92"] = 39,
		["93"] = 56,
		["94"] = 63,
		["95"] = 56,
		["96"] = 63,
		["97"] = 65,
		["98"] = 66,
		["99"] = 65,
		["100"] = 68,
		["101"] = 69,
		["102"] = 68,
		["103"] = 63,
		["104"] = 56,
		["105"] = 56,
		["106"] = 56,
		["107"] = 56,
		["108"] = 56,
		["109"] = 56,
		["110"] = 56,
		["111"] = 63,
		["113"] = 63,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_222 = c()
local n = g.trait_222
n.name = "trait_222"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_222"
end
n = e({ j(nil) }, n)
g.trait_222 = n
g.modifier_trait_222 = c()
local o = g.modifier_trait_222
o.name = "modifier_trait_222"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_222_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_222_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_222 = o
g.modifier_trait_222_buff = c()
local q = g.modifier_trait_222_buff
q.name = "modifier_trait_222_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 } }
end
function q.prototype.OnCustomAbilityFullyCast(self, r)
	if not IsServer() then
		return
	end
	local s = self:GetParent()
	s:AddNewModifier(s, self:GetAbility(), "modifier_trait_222_speed", { duration = self.duration })
end
q = e(
	{
		m(
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
	q
)
g.modifier_trait_222_buff = q
g.modifier_trait_222_speed = c()
local t = g.modifier_trait_222_speed
t.name = "modifier_trait_222_speed"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = self.attackspeed }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_222_speed = t
return g