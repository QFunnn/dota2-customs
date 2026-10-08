--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_203"
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
		["62"] = 44,
		["63"] = 45,
		["64"] = 31,
		["65"] = 46,
		["66"] = 47,
		["67"] = 48,
		["68"] = 49,
		["69"] = 50,
		["70"] = 46,
		["71"] = 52,
		["72"] = 53,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 53,
		["77"] = 55,
		["78"] = 55,
		["79"] = 55,
		["80"] = 53,
		["81"] = 53,
		["82"] = 53,
		["83"] = 52,
		["84"] = 59,
		["85"] = 60,
		["86"] = 59,
		["87"] = 62,
		["88"] = 63,
		["89"] = 62,
		["90"] = 65,
		["91"] = 66,
		["94"] = 67,
		["97"] = 68,
		["98"] = 69,
		["99"] = 70,
		["100"] = 70,
		["101"] = 70,
		["102"] = 70,
		["103"] = 70,
		["104"] = 70,
		["105"] = 71,
		["106"] = 71,
		["107"] = 71,
		["108"] = 71,
		["109"] = 71,
		["110"] = 71,
		["111"] = 72,
		["112"] = 73,
		["113"] = 65,
		["114"] = 39,
		["115"] = 31,
		["116"] = 31,
		["117"] = 31,
		["118"] = 31,
		["119"] = 31,
		["120"] = 31,
		["121"] = 31,
		["122"] = 31,
		["123"] = 39,
		["125"] = 39,
		["126"] = 77,
		["127"] = 84,
		["128"] = 77,
		["129"] = 84,
		["130"] = 86,
		["131"] = 87,
		["132"] = 86,
		["133"] = 89,
		["134"] = 90,
		["135"] = 89,
		["136"] = 84,
		["137"] = 77,
		["138"] = 77,
		["139"] = 77,
		["140"] = 77,
		["141"] = 77,
		["142"] = 77,
		["143"] = 77,
		["144"] = 84,
		["146"] = 84,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_203 = c()
local n = g.trait_203
n.name = "trait_203"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_203"
end
n = e({ j(nil) }, n)
g.trait_203 = n
g.modifier_trait_203 = c()
local o = g.modifier_trait_203
o.name = "modifier_trait_203"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_203_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_203_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_203 = o
g.modifier_trait_203_buff = c()
local q = g.modifier_trait_203_buff
q.name = "modifier_trait_203_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.stack = 0
	self.pending = false
end
function q.prototype.GetAbilitySpecialValue(self)
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
	self.damage_per_stack = self:GetAbilitySpecialValueFor("damage_per_stack")
	self.duration = self:GetAbilitySpecialValueFor("duration")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FULLY_CAST] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.pending = false
end
function q.prototype.OnCustomAbilityFullyCast(self, r)
	self.pending = true
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	if not self.pending then
		return
	end
	self.pending = false
	local s = self:GetParent()
	s:DealDamage(
		r.target,
		self:GetAbility(),
		self.damage + self.stack * self.damage_per_stack,
		EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL
	)
	r.target:AddNewModifier(s, self:GetAbility(), "modifier_trait_203_debuff", { duration = self.duration })
	self.stack = self.stack + 1
	self:SetStackCount(self.stack)
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
g.modifier_trait_203_buff = q
g.modifier_trait_203_debuff = c()
local t = g.modifier_trait_203_debuff
t.name = "modifier_trait_203_debuff"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.attackspeed_reduce = self:GetAbilitySpecialValueFor("attackspeed_reduce")
end
function t.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE] = -self.attackspeed_reduce }
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = true, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_203_debuff = t
return g