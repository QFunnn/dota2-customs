--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_17"
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
		["57"] = 38,
		["58"] = 31,
		["59"] = 38,
		["60"] = 42,
		["61"] = 43,
		["62"] = 44,
		["63"] = 45,
		["64"] = 42,
		["65"] = 47,
		["66"] = 48,
		["67"] = 49,
		["69"] = 47,
		["70"] = 52,
		["71"] = 53,
		["72"] = 52,
		["73"] = 58,
		["74"] = 59,
		["75"] = 59,
		["76"] = 59,
		["77"] = 59,
		["78"] = 58,
		["79"] = 61,
		["80"] = 62,
		["81"] = 63,
		["82"] = 64,
		["85"] = 65,
		["86"] = 66,
		["87"] = 61,
		["88"] = 68,
		["89"] = 69,
		["90"] = 68,
		["91"] = 74,
		["92"] = 75,
		["93"] = 74,
		["94"] = 77,
		["95"] = 78,
		["96"] = 77,
		["97"] = 80,
		["98"] = 81,
		["99"] = 80,
		["100"] = 38,
		["101"] = 31,
		["102"] = 31,
		["103"] = 31,
		["104"] = 31,
		["105"] = 31,
		["106"] = 31,
		["107"] = 31,
		["108"] = 38,
		["110"] = 38,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_17 = c()
local n = g.trait_17
n.name = "trait_17"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_17"
end
n = e({ j(nil) }, n)
g.trait_17 = n
g.modifier_trait_17 = c()
local o = g.modifier_trait_17
o.name = "modifier_trait_17"
d(o, l)
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_TRAIT_INIT] = { self:GetParent(), -1 } }
end
function o.prototype.OnTraitInit(self, p)
	p.hero:RemoveModifierByName("modifier_trait_17_buff")
	p.hero:AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_trait_17_buff", {})
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_17 = o
g.modifier_trait_17_buff = c()
local q = g.modifier_trait_17_buff
q.name = "modifier_trait_17_buff"
d(q, l)
function q.prototype.GetAbilitySpecialValue(self)
	self.mana = self:GetAbilitySpecialValueFor("mana")
	self.ulti = self:GetAbilitySpecialValueFor("ulti")
	self.evade = self:GetAbilitySpecialValueFor("evade")
end
function q.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self:GetParent():GetHeroBase():getLevel())
	end
end
function q.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 },
	}
end
function q.prototype.OnBattleStart(self, p)
	Restore(self:GetParent(), self.mana)
end
function q.prototype.OnHeroLevelUp(self, p)
	local r = self:GetParent()
	local s = self:GetParent():GetPlayerOwnerID()
	if p.player_id ~= r:GetPlayerOwnerID() then
		return
	end
	local t = PlayerData:getHero(s)
	self:SetStackCount(t:getLevel())
end
function q.prototype.EDeclareFunctions(self)
	return {
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_ULTI_POWER,
		EOMModifierFunction.EOM_MODIFIER_PROPERTY_EVADE_DAMAGE_REDUCE_BONUS_PERCENT,
	}
end
function q.prototype.EOM_GetModifierUltiPower(self)
	return self:GetStackCount() * self.ulti
end
function q.prototype.EOM_GetModifierEvadeDamageReduceBonusPercent(self, p)
	return -self.evade
end
function q.prototype.ECheckState(self)
	return {}
end
q = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
g.modifier_trait_17_buff = q
return g