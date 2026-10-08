--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_220"
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
		["77"] = 51,
		["78"] = 50,
		["79"] = 56,
		["80"] = 57,
		["83"] = 58,
		["84"] = 59,
		["85"] = 60,
		["86"] = 56,
		["87"] = 62,
		["88"] = 63,
		["89"] = 62,
		["90"] = 65,
		["91"] = 66,
		["94"] = 67,
		["95"] = 68,
		["96"] = 69,
		["97"] = 70,
		["100"] = 73,
		["101"] = 74,
		["102"] = 75,
		["103"] = 76,
		["104"] = 77,
		["105"] = 78,
		["106"] = 79,
		["109"] = 82,
		["110"] = 65,
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
g.trait_220 = c()
local n = g.trait_220
n.name = "trait_220"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_220"
end
n = e({ j(nil) }, n)
g.trait_220 = n
g.modifier_trait_220 = c()
local o = g.modifier_trait_220
o.name = "modifier_trait_220"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_220_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_220_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_220 = o
g.modifier_trait_220_buff = c()
local q = g.modifier_trait_220_buff
q.name = "modifier_trait_220_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.lastMana = -1
	self.gained = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.mana_per = self:GetAbilitySpecialValueFor("mana_per")
	self.shield = self:GetAbilitySpecialValueFor("shield")
	self.max_pct = self:GetAbilitySpecialValueFor("max_pct")
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	if not IsServer() then
		return
	end
	self.lastMana = self:GetParent():GetMana()
	self.gained = 0
	self:StartIntervalThink(0.25)
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
end
function q.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetMana()
	if self.lastMana < 0 then
		self.lastMana = s
		return
	end
	if s < self.lastMana then
		local t = self.lastMana - s
		local u = math.floor(t / self.mana_per) * self.shield
		local v = r:GetMaxHealth() * self.max_pct * 0.01
		if u > 0 and self.gained + u <= v then
			self.gained = self.gained + u
			AddShield(r, u, "trait_220", "Ability")
		end
	end
	self.lastMana = s
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
g.modifier_trait_220_buff = q
return g