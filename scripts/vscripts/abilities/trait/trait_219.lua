--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_219"
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
		["60"] = 43,
		["61"] = 44,
		["62"] = 45,
		["63"] = 46,
		["64"] = 43,
		["65"] = 48,
		["66"] = 49,
		["67"] = 49,
		["68"] = 51,
		["69"] = 51,
		["70"] = 51,
		["71"] = 49,
		["72"] = 49,
		["73"] = 48,
		["74"] = 54,
		["75"] = 55,
		["76"] = 55,
		["78"] = 54,
		["79"] = 57,
		["80"] = 58,
		["81"] = 57,
		["82"] = 60,
		["83"] = 61,
		["86"] = 62,
		["87"] = 63,
		["88"] = 64,
		["91"] = 65,
		["92"] = 65,
		["93"] = 65,
		["94"] = 65,
		["95"] = 65,
		["96"] = 65,
		["97"] = 66,
		["98"] = 66,
		["99"] = 66,
		["100"] = 66,
		["101"] = 66,
		["102"] = 66,
		["103"] = 60,
		["104"] = 39,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 39,
		["115"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_219 = c()
local n = g.trait_219
n.name = "trait_219"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_219"
end
n = e({ j(nil) }, n)
g.trait_219 = n
g.modifier_trait_219 = c()
local o = g.modifier_trait_219
o.name = "modifier_trait_219"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_219_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_219_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_219 = o
g.modifier_trait_219_buff = c()
local q = g.modifier_trait_219_buff
q.name = "modifier_trait_219_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.stun = self:GetAbilitySpecialValueFor("stun")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	if IsServer() then
		self:StartIntervalThink(self.interval)
	end
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function q.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if not IsInjurable(s) then
		return
	end
	r:DealDamage(s, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
	AddStun(r, s, self:GetAbility(), self.stun)
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
g.modifier_trait_219_buff = q
return g