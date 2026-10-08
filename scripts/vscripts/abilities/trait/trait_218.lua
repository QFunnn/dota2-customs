--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_218"
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
		["74"] = 52,
		["75"] = 51,
		["76"] = 56,
		["77"] = 57,
		["80"] = 58,
		["81"] = 59,
		["84"] = 60,
		["87"] = 61,
		["88"] = 62,
		["89"] = 62,
		["91"] = 63,
		["92"] = 64,
		["94"] = 66,
		["95"] = 56,
		["96"] = 68,
		["97"] = 69,
		["98"] = 68,
		["99"] = 75,
		["100"] = 76,
		["101"] = 75,
		["102"] = 78,
		["103"] = 79,
		["104"] = 78,
		["105"] = 81,
		["106"] = 82,
		["107"] = 81,
		["108"] = 39,
		["109"] = 31,
		["110"] = 31,
		["111"] = 31,
		["112"] = 31,
		["113"] = 31,
		["114"] = 31,
		["115"] = 31,
		["116"] = 31,
		["117"] = 39,
		["119"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_218 = c()
local n = g.trait_218
n.name = "trait_218"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_218"
end
n = e({ j(nil) }, n)
g.trait_218 = n
g.modifier_trait_218 = c()
local o = g.modifier_trait_218
o.name = "modifier_trait_218"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_218_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_218_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_218 = o
g.modifier_trait_218_buff = c()
local q = g.modifier_trait_218_buff
q.name = "modifier_trait_218_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.stack = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.attack = self:GetAbilitySpecialValueFor("attack")
	self.attackspeed = self:GetAbilitySpecialValueFor("attackspeed")
	self.heal_reduce = self:GetAbilitySpecialValueFor("heal_reduce")
	self.max_stack = self:GetAbilitySpecialValueFor("max_stack")
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { self:GetParent(), self:GetParent() } }
end
function q.prototype.OnBattleEnd(self, p)
	if not IsServer() then
		return
	end
	local r = self:GetParent():GetPlayerOwnerID()
	if p.isNeutral then
		return
	end
	if p.illusionPlayerID == r then
		return
	end
	if p.winPlayerID == r then
		if self.stack < self.max_stack then
			self.stack = self.stack + 1
		end
	elseif p.losePlayerID == r then
		self.stack = math.floor(self.stack * 0.5)
	end
	self:SetStackCount(self.stack)
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACK_DAMAGE_BONUS,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ATTACKSPEED_TOTAL_PERCENTAGE,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEAL_AMPLIFY,
	}
end
function q.prototype.EOM_GetModifierAttackDamageBonus(self)
	return self.stack * self.attack
end
function q.prototype.EOM_GetModifierAttackSpeedTotalPercentage(self)
	return self.stack * self.attackspeed
end
function q.prototype.EOM_GetModifierHealAmplity(self)
	return -self.stack * self.heal_reduce
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
g.modifier_trait_218_buff = q
return g