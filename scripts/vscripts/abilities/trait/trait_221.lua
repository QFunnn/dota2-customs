--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_221"
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
		["76"] = 52,
		["77"] = 53,
		["78"] = 53,
		["79"] = 53,
		["80"] = 53,
		["81"] = 53,
		["82"] = 53,
		["83"] = 49,
		["84"] = 39,
		["85"] = 31,
		["86"] = 31,
		["87"] = 31,
		["88"] = 31,
		["89"] = 31,
		["90"] = 31,
		["91"] = 31,
		["92"] = 31,
		["93"] = 39,
		["95"] = 39,
		["96"] = 57,
		["97"] = 64,
		["98"] = 57,
		["99"] = 64,
		["100"] = 67,
		["101"] = 68,
		["102"] = 69,
		["103"] = 67,
		["104"] = 71,
		["105"] = 72,
		["106"] = 71,
		["107"] = 64,
		["108"] = 57,
		["109"] = 57,
		["110"] = 57,
		["111"] = 57,
		["112"] = 57,
		["113"] = 57,
		["114"] = 57,
		["115"] = 64,
		["117"] = 64,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_221 = c()
local n = g.trait_221
n.name = "trait_221"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_221"
end
n = e({ j(nil) }, n)
g.trait_221 = n
g.modifier_trait_221 = c()
local o = g.modifier_trait_221
o.name = "modifier_trait_221"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_221_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_221_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_221 = o
g.modifier_trait_221_buff = c()
local q = g.modifier_trait_221_buff
q.name = "modifier_trait_221_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SHIELD_GAINED] = { -1, self:GetParent() } }
end
function q.prototype.OnShieldGained(self, p)
	if not IsServer() then
		return
	end
	if p.origin == "trait_221" then
		return
	end
	local r = self:GetParent()
	r:AddNewModifier(r, self:GetAbility(), "modifier_trait_221_speed", { duration = self.duration })
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
g.modifier_trait_221_buff = q
g.modifier_trait_221_speed = c()
local s = g.modifier_trait_221_speed
s.name = "modifier_trait_221_speed"
d(s, l)
function s.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.reduce = self:GetAbilitySpecialValueFor("reduce")
end
function s.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = self.attackspeed,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE] = -self.reduce,
	}
end
s = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
g.modifier_trait_221_speed = s
return g