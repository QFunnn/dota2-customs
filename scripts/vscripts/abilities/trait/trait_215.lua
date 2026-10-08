--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_215"
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
		["63"] = 31,
		["64"] = 45,
		["65"] = 46,
		["66"] = 47,
		["67"] = 48,
		["68"] = 49,
		["69"] = 45,
		["70"] = 51,
		["71"] = 52,
		["72"] = 53,
		["73"] = 53,
		["74"] = 53,
		["75"] = 52,
		["76"] = 52,
		["77"] = 52,
		["78"] = 51,
		["79"] = 57,
		["80"] = 58,
		["81"] = 57,
		["82"] = 60,
		["83"] = 61,
		["86"] = 62,
		["89"] = 63,
		["90"] = 64,
		["93"] = 65,
		["94"] = 66,
		["95"] = 67,
		["96"] = 68,
		["97"] = 68,
		["98"] = 68,
		["99"] = 68,
		["100"] = 68,
		["101"] = 68,
		["102"] = 69,
		["103"] = 69,
		["104"] = 69,
		["105"] = 69,
		["106"] = 69,
		["107"] = 69,
		["109"] = 71,
		["110"] = 60,
		["111"] = 39,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 31,
		["117"] = 31,
		["118"] = 31,
		["119"] = 31,
		["120"] = 39,
		["122"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_215 = c()
local n = g.trait_215
n.name = "trait_215"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_215"
end
n = e({ j(nil) }, n)
g.trait_215 = n
g.modifier_trait_215 = c()
local o = g.modifier_trait_215
o.name = "modifier_trait_215"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_215_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_215_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_215 = o
g.modifier_trait_215_buff = c()
local q = g.modifier_trait_215_buff
q.name = "modifier_trait_215_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.triggered = false
end
function q.prototype.GetAbilitySpecialValue(self)
	self.hp_threshold = self:GetAbilitySpecialValueFor("hp_threshold")
	self.damage = self:GetAbilitySpecialValueFor("damage")
	self.stun = self:GetAbilitySpecialValueFor("stun")
	self.heal = self:GetAbilitySpecialValueFor("heal")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_TAKEDAMAGE] = { self:GetParent(), -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	self.triggered = false
end
function q.prototype.OnCustomTakeDamage(self, r)
	if not IsServer() then
		return
	end
	if self.triggered then
		return
	end
	local s = self:GetParent()
	if s:GetHealthPercent() * 100 > self.hp_threshold then
		return
	end
	self.triggered = true
	local t = s:GetEnemy()
	if IsInjurable(t) then
		s:DealDamage(t, self:GetAbility(), self.damage, EOM_DAMAGE_TYPES.DAMAGE_TYPE_MAGICAL)
		AddStun(s, t, self:GetAbility(), self.stun)
	end
	Heal(s, self.heal, "trait_215", "Ability")
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
g.modifier_trait_215_buff = q
return g