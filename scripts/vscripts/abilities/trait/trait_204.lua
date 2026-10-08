--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_204"
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
		["72"] = 52,
		["73"] = 54,
		["74"] = 54,
		["75"] = 54,
		["76"] = 52,
		["77"] = 52,
		["78"] = 51,
		["79"] = 57,
		["80"] = 58,
		["81"] = 58,
		["83"] = 57,
		["84"] = 60,
		["85"] = 61,
		["88"] = 62,
		["89"] = 63,
		["90"] = 64,
		["91"] = 65,
		["92"] = 65,
		["93"] = 65,
		["94"] = 65,
		["95"] = 65,
		["96"] = 65,
		["97"] = 65,
		["98"] = 65,
		["100"] = 60,
		["101"] = 68,
		["102"] = 69,
		["103"] = 70,
		["106"] = 71,
		["107"] = 72,
		["108"] = 73,
		["109"] = 74,
		["111"] = 68,
		["112"] = 77,
		["113"] = 78,
		["114"] = 77,
		["115"] = 82,
		["116"] = 83,
		["117"] = 82,
		["118"] = 85,
		["119"] = 86,
		["120"] = 85,
		["121"] = 39,
		["122"] = 31,
		["123"] = 31,
		["124"] = 31,
		["125"] = 31,
		["126"] = 31,
		["127"] = 31,
		["128"] = 31,
		["129"] = 31,
		["130"] = 39,
		["132"] = 39,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_204 = c()
local n = g.trait_204
n.name = "trait_204"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_204"
end
n = e({ j(nil) }, n)
g.trait_204 = n
g.modifier_trait_204 = c()
local o = g.modifier_trait_204
o.name = "modifier_trait_204"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_204_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_204_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_204 = o
g.modifier_trait_204_buff = c()
local q = g.modifier_trait_204_buff
q.name = "modifier_trait_204_buff"
d(q, l)
function q.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.stack = 0
end
function q.prototype.GetAbilitySpecialValue(self)
	self.health_pct = self:GetAbilitySpecialValueFor("health_pct")
	self.injury = self:GetAbilitySpecialValueFor("injury")
	self.interval = self:GetAbilitySpecialValueFor("interval")
	self.health_stack = self:GetAbilitySpecialValueFor("health_stack")
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
function q.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	local r = self:GetParent()
	local s = r:GetEnemy()
	if IsInjurable(s) then
		AddInjury(r, s, self.injury, "trait_204", "Ability", InjuryFlags.INJURY_FLAG_NO_EXTRA)
	end
end
function q.prototype.OnBattleEnd(self, p)
	self:StartIntervalThink(-1)
	if not IsServer() then
		return
	end
	local t = self:GetParent():GetPlayerOwnerID()
	if p.illusionPlayerID ~= t and p.winPlayerID == t then
		self.stack = self.stack + 1
		self:SetStackCount(self.stack)
	end
end
function q.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS_PERCENTAGE] = self.health_pct }
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_HEALTH_BONUS }
end
function q.prototype.EOM_GetModifierHealthBonus(self)
	return self.stack * self.health_stack
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
g.modifier_trait_204_buff = q
return g