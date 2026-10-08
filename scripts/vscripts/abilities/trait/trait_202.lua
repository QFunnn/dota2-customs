--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_202"
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
		["60"] = 44,
		["61"] = 45,
		["62"] = 46,
		["63"] = 47,
		["64"] = 48,
		["65"] = 44,
		["66"] = 50,
		["67"] = 51,
		["68"] = 51,
		["69"] = 53,
		["70"] = 53,
		["71"] = 53,
		["72"] = 51,
		["73"] = 51,
		["74"] = 50,
		["75"] = 56,
		["76"] = 57,
		["79"] = 58,
		["80"] = 59,
		["81"] = 59,
		["82"] = 59,
		["83"] = 59,
		["84"] = 59,
		["85"] = 59,
		["86"] = 60,
		["87"] = 56,
		["88"] = 62,
		["89"] = 63,
		["92"] = 64,
		["93"] = 65,
		["94"] = 66,
		["95"] = 67,
		["96"] = 67,
		["97"] = 67,
		["98"] = 67,
		["99"] = 67,
		["100"] = 67,
		["102"] = 69,
		["103"] = 62,
		["104"] = 71,
		["105"] = 72,
		["106"] = 71,
		["107"] = 39,
		["108"] = 31,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 39,
		["118"] = 39,
		["119"] = 76,
		["120"] = 83,
		["121"] = 76,
		["122"] = 83,
		["123"] = 85,
		["124"] = 86,
		["125"] = 85,
		["126"] = 88,
		["127"] = 89,
		["128"] = 88,
		["129"] = 83,
		["130"] = 76,
		["131"] = 76,
		["132"] = 76,
		["133"] = 76,
		["134"] = 76,
		["135"] = 76,
		["136"] = 76,
		["137"] = 83,
		["139"] = 83,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_202 = c()
local n = g.trait_202
n.name = "trait_202"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_202"
end
n = e({ j(nil) }, n)
g.trait_202 = n
g.modifier_trait_202 = c()
local o = g.modifier_trait_202
o.name = "modifier_trait_202"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_202_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_202_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_202 = o
g.modifier_trait_202_buff = c()
local q = g.modifier_trait_202_buff
q.name = "modifier_trait_202_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.invuln_duration = self:GetAbilitySpecialValueFor("invuln_duration")
	self.window = self:GetAbilitySpecialValueFor("window")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.self_damage = self:GetAbilitySpecialValueFor("self_damage")
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
	local r = self:GetParent()
	r:AddNewModifier(r, self:GetAbility(), "modifier_trait_202_invuln", { duration = self.invuln_duration })
	self:StartIntervalThink(self.window)
end
function q.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if IsInjurable(s) then
		r:DealDamage(
			r,
			self:GetAbility(),
			r:GetMaxHealth() * self.self_damage * 0.01,
			EOM_DAMAGE_TYPES.DAMAGE_TYPE_PURE
		)
	end
	self:StartIntervalThink(-1)
end
function q.prototype.OnBattleEnd(self, p)
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
g.modifier_trait_202_buff = q
g.modifier_trait_202_invuln = c()
local t = g.modifier_trait_202_invuln
t.name = "modifier_trait_202_invuln"
d(t, l)
function t.prototype.GetAbilitySpecialValue(self)
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
end
function t.prototype.EFunctionValues(self)
	return {
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ALL_BLOCK_CHANCE] = 100,
		[EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_BONUS] = self.attackspeed,
	}
end
t = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	t
)
g.modifier_trait_202_invuln = t
return g