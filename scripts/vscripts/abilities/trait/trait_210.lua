--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_210"
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
		["63"] = 31,
		["64"] = 44,
		["65"] = 45,
		["66"] = 46,
		["67"] = 47,
		["68"] = 44,
		["69"] = 49,
		["70"] = 50,
		["71"] = 50,
		["72"] = 52,
		["73"] = 52,
		["74"] = 52,
		["75"] = 50,
		["76"] = 53,
		["77"] = 53,
		["78"] = 53,
		["79"] = 50,
		["80"] = 54,
		["81"] = 54,
		["82"] = 54,
		["83"] = 50,
		["84"] = 50,
		["85"] = 49,
		["86"] = 57,
		["87"] = 58,
		["88"] = 59,
		["89"] = 57,
		["90"] = 61,
		["91"] = 62,
		["92"] = 61,
		["93"] = 64,
		["94"] = 65,
		["95"] = 66,
		["96"] = 64,
		["97"] = 68,
		["98"] = 69,
		["101"] = 70,
		["104"] = 71,
		["105"] = 72,
		["106"] = 73,
		["107"] = 74,
		["108"] = 74,
		["109"] = 74,
		["110"] = 74,
		["111"] = 74,
		["112"] = 74,
		["113"] = 75,
		["114"] = 76,
		["115"] = 68,
		["116"] = 78,
		["117"] = 79,
		["120"] = 80,
		["123"] = 81,
		["124"] = 82,
		["125"] = 78,
		["126"] = 39,
		["127"] = 31,
		["128"] = 31,
		["129"] = 31,
		["130"] = 31,
		["131"] = 31,
		["132"] = 31,
		["133"] = 31,
		["134"] = 31,
		["135"] = 39,
		["137"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_210 = c()
local n = g.trait_210
n.name = "trait_210"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_210"
end
n = e({ j(nil) }, n)
g.trait_210 = n
g.modifier_trait_210 = c()
local o = g.modifier_trait_210
o.name = "modifier_trait_210"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_210_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_210_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_210 = o
g.modifier_trait_210_buff = c()
local q = g.modifier_trait_210_buff
q.name = "modifier_trait_210_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.ready = false
end
function q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.lifesteal = self:GetAbilitySpecialValueFor("lifesteal")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ATTACK_LANDED] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_KILLED] = { self:GetParent(), -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.ready = false
	self:StartIntervalThink(self.interval)
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function q.prototype.OnIntervalThink(self)
	self.ready = true
	self:StartIntervalThink(-1)
end
function q.prototype.OnCustomAttackLanded(self, r)
	if not IsServer() then
		return
	end
	if not self.ready then
		return
	end
	self.ready = false
	local s = self:GetParent()
	local t = self.damage
	s:DealDamage(r.target, self:GetAbility(), t, EOM_DAMAGE_TYPES.DAMAGE_TYPE_PHYSICAL)
	Heal(s, t * self.lifesteal * 0.01, "trait_210", "Ability")
	self:StartIntervalThink(self.interval)
end
function q.prototype.OnKilled(self, p)
	if not IsServer() then
		return
	end
	if p.attacker ~= self:GetParent() then
		return
	end
	self.ready = true
	self:StartIntervalThink(-1)
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
g.modifier_trait_210_buff = q
return g