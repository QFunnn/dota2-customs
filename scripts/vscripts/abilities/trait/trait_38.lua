--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_38"
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
		["36"] = 31,
		["37"] = 32,
		["38"] = 32,
		["39"] = 32,
		["40"] = 32,
		["41"] = 33,
		["43"] = 28,
		["44"] = 37,
		["45"] = 38,
		["46"] = 37,
		["47"] = 43,
		["48"] = 45,
		["49"] = 46,
		["52"] = 49,
		["53"] = 50,
		["54"] = 52,
		["55"] = 53,
		["56"] = 53,
		["57"] = 53,
		["58"] = 53,
		["59"] = 54,
		["61"] = 43,
		["62"] = 19,
		["63"] = 12,
		["64"] = 12,
		["65"] = 12,
		["66"] = 12,
		["67"] = 12,
		["68"] = 12,
		["69"] = 12,
		["70"] = 19,
		["72"] = 19,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.trait_38 = c()
local n = g.trait_38
n.name = "trait_38"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_38"
end
n = e({ j(nil) }, n)
g.trait_38 = n
g.modifier_trait_38 = c()
local o = g.modifier_trait_38
o.name = "modifier_trait_38"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self.record = Rounds:getCurrentRound()
		AbilityShop:setPlayerAbilityShopFreeCount(self:GetParent():GetPlayerOwnerID(), self.count)
		self:SetStackCount(0)
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 } }
end
function o.prototype.OnRoundChange(self, p)
	local q = Rounds:getCurrentRound()
	if self.record == q then
		return
	end
	self:IncrementStackCount()
	if self:GetStackCount() >= self.round then
		self.record = Rounds:getCurrentRound()
		AbilityShop:setPlayerAbilityShopFreeCount(self:GetParent():GetPlayerOwnerID(), self.count)
		self:SetStackCount(0)
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_trait_38 = o
return g