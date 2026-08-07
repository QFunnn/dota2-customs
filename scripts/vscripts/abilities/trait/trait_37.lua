--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_37"
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
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 24,
		["34"] = 28,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 32,
		["42"] = 33,
		["44"] = 28,
		["45"] = 37,
		["46"] = 38,
		["47"] = 38,
		["48"] = 38,
		["49"] = 38,
		["50"] = 37,
		["51"] = 43,
		["52"] = 44,
		["53"] = 45,
		["54"] = 46,
		["55"] = 47,
		["56"] = 48,
		["57"] = 49,
		["58"] = 49,
		["59"] = 49,
		["60"] = 49,
		["61"] = 50,
		["64"] = 43,
		["65"] = 55,
		["66"] = 56,
		["67"] = 57,
		["68"] = 58,
		["69"] = 59,
		["72"] = 55,
		["73"] = 19,
		["74"] = 12,
		["75"] = 12,
		["76"] = 12,
		["77"] = 12,
		["78"] = 12,
		["79"] = 12,
		["80"] = 12,
		["81"] = 19,
		["83"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_37 = c()
local n = g.trait_37
n.name = "trait_37"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_37"
end
n = e({ j(nil) }, n)
g.trait_37 = n
g.modifier_trait_37 = c()
local o = g.modifier_trait_37
o.name = "modifier_trait_37"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.enable = false
		self.record = 0
		AbilityShop:setPlayerAbilityShopFreeCount(self:GetParent():GetPlayerOwnerID(), self.count)
		self:SetStackCount(0)
	end
end
function o.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_BUY] = { self:GetParent() },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
	}
end
function o.prototype.OnRoundChange(self, p)
	if self.enable then
		self:IncrementStackCount()
		if self:GetStackCount() >= self.round then
			self.enable = false
			self.record = 0
			AbilityShop:setPlayerAbilityShopFreeCount(self:GetParent():GetPlayerOwnerID(), self.count)
			self:SetStackCount(0)
		end
	end
end
function o.prototype.OnAbilityBuy(self, p)
	if p.cost == 0 and not self.enable then
		self.record = self.record + 1
		if self.record >= self.count then
			self.enable = true
		end
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_37 = o
return g