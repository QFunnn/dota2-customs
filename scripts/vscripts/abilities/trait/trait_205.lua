--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_205"
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
		["61"] = 39,
		["62"] = 43,
		["63"] = 44,
		["64"] = 31,
		["65"] = 45,
		["66"] = 46,
		["67"] = 47,
		["68"] = 48,
		["69"] = 45,
		["70"] = 50,
		["71"] = 51,
		["72"] = 51,
		["73"] = 53,
		["74"] = 53,
		["75"] = 53,
		["76"] = 51,
		["77"] = 54,
		["78"] = 54,
		["79"] = 54,
		["80"] = 51,
		["81"] = 51,
		["82"] = 50,
		["83"] = 57,
		["84"] = 58,
		["85"] = 57,
		["86"] = 60,
		["87"] = 61,
		["90"] = 62,
		["91"] = 63,
		["92"] = 64,
		["93"] = 65,
		["94"] = 65,
		["95"] = 65,
		["96"] = 65,
		["97"] = 65,
		["98"] = 65,
		["99"] = 66,
		["100"] = 67,
		["102"] = 60,
		["103"] = 39,
		["104"] = 31,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 39,
		["114"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_205 = c()
local n = g.trait_205
n.name = "trait_205"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_205"
end
n = e({ j(nil) }, n)
g.trait_205 = n
g.modifier_trait_205 = c()
local o = g.modifier_trait_205
o.name = "modifier_trait_205"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_205_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_205_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_205 = o
g.modifier_trait_205_buff = c()
local q = g.modifier_trait_205_buff
q.name = "modifier_trait_205_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.attack_count = 0
	self.stack = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.damage_stack = self:GetAbilitySpecialValueFor("damage_stack")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.attack_count = 0
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	self.attack_count = self.attack_count + 1
	if self.attack_count % self.count == 0 then
		local s = self:GetParent()
		s:DealDamage(
			r.target,
			self:GetAbility(),
			self.damage + self.stack * self.damage_stack,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
		)
		self.stack = self.stack + 1
		self:SetStackCount(self.stack)
	end
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
g.modifier_trait_205_buff = q
return g