--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_153"
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
		["26"] = 11,
		["27"] = 18,
		["28"] = 11,
		["29"] = 18,
		["30"] = 19,
		["31"] = 20,
		["32"] = 21,
		["33"] = 21,
		["34"] = 20,
		["35"] = 19,
		["36"] = 24,
		["37"] = 25,
		["38"] = 26,
		["39"] = 26,
		["40"] = 26,
		["41"] = 26,
		["42"] = 26,
		["43"] = 26,
		["44"] = 24,
		["45"] = 18,
		["46"] = 11,
		["47"] = 11,
		["48"] = 11,
		["49"] = 11,
		["50"] = 11,
		["51"] = 11,
		["52"] = 11,
		["53"] = 18,
		["55"] = 18,
		["56"] = 30,
		["57"] = 37,
		["58"] = 30,
		["59"] = 37,
		["60"] = 41,
		["61"] = 42,
		["62"] = 43,
		["63"] = 44,
		["64"] = 41,
		["65"] = 47,
		["66"] = 48,
		["67"] = 47,
		["68"] = 53,
		["69"] = 54,
		["70"] = 53,
		["71"] = 56,
		["72"] = 57,
		["73"] = 56,
		["74"] = 62,
		["75"] = 63,
		["76"] = 63,
		["77"] = 63,
		["78"] = 63,
		["79"] = 62,
		["80"] = 66,
		["81"] = 67,
		["82"] = 68,
		["83"] = 66,
		["84"] = 72,
		["85"] = 73,
		["86"] = 74,
		["87"] = 75,
		["89"] = 72,
		["90"] = 79,
		["91"] = 80,
		["92"] = 79,
		["93"] = 37,
		["94"] = 30,
		["95"] = 30,
		["96"] = 30,
		["97"] = 30,
		["98"] = 30,
		["99"] = 30,
		["100"] = 30,
		["101"] = 37,
		["103"] = 37,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_153 = c()
local n = g.trait_153
n.name = "trait_153"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_153"
end
n = e({ j(nil) }, n)
g.trait_153 = n
g.modifier_trait_153 = c()
local o = g.modifier_trait_153
o.name = "modifier_trait_153"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_153_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_153_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_153 = o
g.modifier_trait_153_buff = c()
local q = g.modifier_trait_153_buff
q.name = "modifier_trait_153_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.loss_hp_trigger = self:GetAbilitySpecialValueFor("loss_hp_trigger")
	self.dmg_outgoing = self:GetAbilitySpecialValueFor("dmg_outgoing")
	self.dmg_outgoing_max = self:GetAbilitySpecialValueFor("dmg_outgoing_max")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
	}
end
function q.prototype.OnBattleStartBefore(self, p)
	self:StartIntervalThink(1)
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_OUTGOING_DAMAGE_PERCENTAGE }
end
function q.prototype.EOM_GetModifierOutgoingDamagePercentage(self, p)
	return math.min(self.dmg_outgoing_max, self.dmg_outgoing * self:GetStackCount())
end
function q.prototype.GetOutgoingStack(self)
	local r = self.parent:GetMaxHealth() - self.parent:GetHealth()
	return math.floor(r / self.loss_hp_trigger) or 0
end
function q.prototype.OnBattleEnd(self, p)
	local s = self.parent:GetPlayerOwnerID()
	if s == p.losePlayerID or s == p.winPlayerID then
		self.parent:RemoveModifierByName("modifier_trait_153_buff")
	end
end
function q.prototype.OnIntervalThink(self)
	self:SetStackCount(self:GetOutgoingStack())
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_153_buff = q
return g