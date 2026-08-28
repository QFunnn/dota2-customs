--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_22"
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
		["18"] = 7,
		["19"] = 8,
		["20"] = 7,
		["21"] = 10,
		["22"] = 11,
		["23"] = 10,
		["24"] = 5,
		["25"] = 4,
		["26"] = 5,
		["28"] = 5,
		["29"] = 14,
		["30"] = 21,
		["31"] = 14,
		["32"] = 21,
		["33"] = 23,
		["34"] = 24,
		["35"] = 23,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 28,
		["40"] = 27,
		["41"] = 26,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 34,
		["50"] = 34,
		["52"] = 31,
		["53"] = 21,
		["54"] = 14,
		["55"] = 14,
		["56"] = 14,
		["57"] = 14,
		["58"] = 14,
		["59"] = 14,
		["60"] = 14,
		["61"] = 21,
		["63"] = 21,
		["64"] = 38,
		["65"] = 45,
		["66"] = 38,
		["67"] = 45,
		["68"] = 47,
		["69"] = 48,
		["70"] = 47,
		["71"] = 50,
		["72"] = 51,
		["73"] = 52,
		["75"] = 50,
		["76"] = 54,
		["77"] = 55,
		["78"] = 54,
		["79"] = 57,
		["80"] = 58,
		["81"] = 59,
		["83"] = 60,
		["84"] = 61,
		["85"] = 62,
		["86"] = 63,
		["87"] = 64,
		["88"] = 65,
		["89"] = 66,
		["91"] = 68,
		["92"] = 57,
		["93"] = 45,
		["94"] = 38,
		["95"] = 38,
		["96"] = 38,
		["97"] = 38,
		["98"] = 38,
		["99"] = 38,
		["100"] = 38,
		["101"] = 45,
		["103"] = 45,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_22 = c()
local n = g.treasure_22
n.name = "treasure_22"
d(n, i)
function n.prototype.Spawn(self)
	self.count = self:GetSpecialValueFor("count")
end
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_22"
end
n = e({ j(nil) }, n)
g.treasure_22 = n
g.modifier_treasure_22 = c()
local o = g.modifier_treasure_22
o.name = "modifier_treasure_22"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	if self:GetAbility().count > 0 then
		p.hero:RemoveModifierByName("modifier_treasure_22_buff")
		p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_treasure_22_buff", {})
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_22 = o
g.modifier_treasure_22_buff = c()
local q = g.modifier_treasure_22_buff
q.name = "modifier_treasure_22_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.hpPct = self:GetAbilitySpecialValueFor("hp_pct")
end
function q.prototype.OnCreated(self)
	if IsServer() then
		self:SetStackCount(1)
	end
end
function q.prototype.EDeclareFunctionsWithPriority(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_AVOID_DAMAGE }
end
function q.prototype.EOM_GetModifierAvoidDamage(self, p)
	if
		bit.band(p.damage_flags, DamageFlags.DAMAGE_FLAG_NO_LETHAL) == DamageFlags.DAMAGE_FLAG_NO_LETHAL
		or self:GetStackCount() <= 0
		or p.damage < p.target:GetHealth()
	then
		return 0
	end
	local r = self:GetParent()
	r:SetHealth(r:GetMaxHealth() * self.hpPct * 0.01)
	PurgeDebuff(r)
	self:DecrementStackCount()
	if not r:IsCustomIllusion() then
		local s = self:GetAbility()
		s.count = s.count - 1
	end
	return 1
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_treasure_22_buff = q
return g