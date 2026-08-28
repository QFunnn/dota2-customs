--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_29"
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
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 23,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 30,
		["39"] = 30,
		["40"] = 30,
		["41"] = 30,
		["42"] = 30,
		["43"] = 30,
		["45"] = 28,
		["46"] = 34,
		["47"] = 35,
		["48"] = 34,
		["49"] = 40,
		["50"] = 41,
		["51"] = 40,
		["52"] = 45,
		["53"] = 46,
		["54"] = 45,
		["55"] = 50,
		["56"] = 51,
		["57"] = 52,
		["58"] = 52,
		["59"] = 52,
		["60"] = 52,
		["61"] = 52,
		["62"] = 52,
		["63"] = 52,
		["64"] = 50,
		["65"] = 54,
		["66"] = 55,
		["67"] = 54,
		["68"] = 19,
		["69"] = 12,
		["70"] = 12,
		["71"] = 12,
		["72"] = 12,
		["73"] = 12,
		["74"] = 12,
		["75"] = 12,
		["76"] = 19,
		["78"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_29 = c()
local n = g.trait_29
n.name = "trait_29"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_29"
end
n = e({ j(nil) }, n)
g.trait_29 = n
g.modifier_trait_29 = c()
local o = g.modifier_trait_29
o.name = "modifier_trait_29"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.interest_rate_reduce = self:GetAbilitySpecialValueFor("interest_rate_reduce")
	self.interest_bonus = self:GetAbilitySpecialValueFor("interest_bonus")
	self.interest_round = self:GetAbilitySpecialValueFor("interest_round")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):modifyArtifactExtraData(
			self:GetAbility():entindex(),
			"interest_rate_max",
			self.interest_bonus + self.interest_round * self:GetStackCount(),
			true,
			true
		)
	end
end
function o.prototype.EFunctionValues(self)
	return { [EOMModifierFunction.EOM_MODIFIER_PROPERTY_INTEREST_RATE_CONSTANT] = -self.interest_rate_reduce }
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_EXTRA_INTEREST_LIMIT }
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	self:IncrementStackCount()
	PlayerData:getplayerData(self:GetParent():GetPlayerOwnerID()):modifyArtifactExtraData(
		self:GetAbility():entindex(),
		"interest_rate_max",
		self.interest_bonus + self.interest_round * self:GetStackCount(),
		true,
		true
	)
end
function o.prototype.EOM_GetModifierExtraInterest_Limit(self, p)
	return self.interest_bonus + self.interest_round * self:GetStackCount()
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_29 = o
return g