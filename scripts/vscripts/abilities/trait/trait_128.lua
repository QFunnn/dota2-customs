--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_128"
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
		["56"] = 32,
		["57"] = 40,
		["58"] = 32,
		["59"] = 40,
		["60"] = 46,
		["61"] = 47,
		["62"] = 48,
		["63"] = 49,
		["64"] = 50,
		["65"] = 51,
		["66"] = 52,
		["68"] = 46,
		["69"] = 55,
		["70"] = 56,
		["71"] = 55,
		["72"] = 60,
		["73"] = 61,
		["74"] = 62,
		["75"] = 63,
		["77"] = 60,
		["78"] = 66,
		["79"] = 67,
		["80"] = 67,
		["81"] = 67,
		["82"] = 67,
		["83"] = 66,
		["84"] = 73,
		["85"] = 74,
		["86"] = 75,
		["89"] = 78,
		["90"] = 79,
		["91"] = 73,
		["92"] = 81,
		["93"] = 82,
		["94"] = 81,
		["95"] = 84,
		["96"] = 85,
		["99"] = 88,
		["100"] = 89,
		["101"] = 90,
		["102"] = 90,
		["103"] = 90,
		["104"] = 90,
		["105"] = 90,
		["106"] = 90,
		["108"] = 92,
		["109"] = 93,
		["110"] = 94,
		["111"] = 95,
		["112"] = 95,
		["113"] = 95,
		["114"] = 95,
		["115"] = 95,
		["116"] = 95,
		["117"] = 95,
		["119"] = 97,
		["121"] = 84,
		["122"] = 40,
		["123"] = 32,
		["124"] = 32,
		["125"] = 32,
		["126"] = 32,
		["127"] = 32,
		["128"] = 32,
		["129"] = 32,
		["130"] = 32,
		["131"] = 40,
		["133"] = 40,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_128 = c()
local n = g.trait_128
n.name = "trait_128"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_128"
end
n = e({ j(nil) }, n)
g.trait_128 = n
g.modifier_trait_128 = c()
local o = g.modifier_trait_128
o.name = "modifier_trait_128"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_128_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_128_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_128 = o
g.modifier_trait_128_buff = c()
local q = g.modifier_trait_128_buff
q.name = "modifier_trait_128_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.tick = self:GetAbilitySpecialValueFor("tick")
	self.tick_1 = self:GetAbilitySpecialValueFor("tick_1")
	self.regen_pct = self:GetAbilitySpecialValueFor("regen_pct")
	if IsServer() then
		self.record = 0
		self.shield_record = 0
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_GAIN_REDUCTION_PERCENTAGE }
end
function q.prototype.EOM_GetModifierGainReductionPercentage(self, p)
	if p and p.type == "shield" and bit.band(p.flag, ShieldFlags.FLAG_NO_EXTRA) ~= ShieldFlags.FLAG_NO_EXTRA then
		self.shield_record = self.shield_record + p.count
		return 1000
	end
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HEAL] = { self:GetParent() },
	}
end
function q.prototype.OnBattleStart(self, p)
	if not IsValid(self:GetAbility()) then
		self:Destroy()
		return
	end
	self:StartThink(self.tick_1, "shield")
	self:StartThink(self.tick, "heal")
end
function q.prototype.OnHeal(self, p)
	self.record = self.record + math.max(0, p.current_health - p.origin_health)
end
function q.prototype.OnThink(self, r)
	if not IsValid(self:GetAbility()) then
		return
	end
	if r == "shield" then
		if self.shield_record > 0 then
			Heal(self:GetParent(), self.shield_record, self:GetAbility():GetAbilityName(), "Ability")
		end
		self.shield_record = 0
	elseif r == "heal" then
		if self.record > 0 then
			AddShield(
				self:GetParent(),
				self.record,
				self:GetAbility():GetAbilityName(),
				"Ability",
				ShieldFlags.FLAG_NO_EXTRA
			)
		end
		self.record = 0
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
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	q
)
g.modifier_trait_128_buff = q
return g