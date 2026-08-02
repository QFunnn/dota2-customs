--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_39"
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
		["10"] = 2,
		["11"] = 2,
		["13"] = 5,
		["14"] = 13,
		["15"] = 5,
		["16"] = 13,
		["18"] = 13,
		["19"] = 16,
		["20"] = 5,
		["21"] = 17,
		["22"] = 18,
		["23"] = 17,
		["24"] = 20,
		["25"] = 21,
		["26"] = 22,
		["27"] = 23,
		["28"] = 24,
		["29"] = 25,
		["30"] = 23,
		["31"] = 27,
		["33"] = 20,
		["34"] = 30,
		["35"] = 31,
		["36"] = 30,
		["37"] = 36,
		["38"] = 37,
		["39"] = 38,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["45"] = 44,
		["48"] = 47,
		["49"] = 48,
		["50"] = 49,
		["51"] = 50,
		["52"] = 51,
		["53"] = 52,
		["54"] = 50,
		["55"] = 54,
		["57"] = 36,
		["58"] = 57,
		["59"] = 58,
		["60"] = 59,
		["62"] = 57,
		["63"] = 13,
		["64"] = 5,
		["65"] = 5,
		["66"] = 5,
		["67"] = 5,
		["68"] = 5,
		["69"] = 5,
		["70"] = 5,
		["71"] = 5,
		["72"] = 13,
		["74"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.registerEOMModifier
local j = require("modifiers.city_effect.city_effect_modifier")
local k = j.CityEffectModifier
g.modifier_city_39 = c()
local l = g.modifier_city_39
l.name = "modifier_city_39"
d(l, k)
function l.prototype.____constructor(self, ...)
	k.prototype.____constructor(self, ...)
	self.pendingPlayers = {}
end
function l.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function l.prototype.OnCreated(self, m)
	if IsServer() then
		self.record = Rounds:getCurrentRound()
		PlayerData:eachAlivePlayerHero(function(n, o, p)
			self.pendingPlayers[p] = true
			AbilityShop:setPlayerAbilityShopFreeCount(p, 1)
		end)
		self:SetStackCount(0)
	end
end
function l.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_CHANGE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_ABILITY_FREE] = { -1, -1 },
	}
end
function l.prototype.OnRoundChange(self, m)
	local q = Rounds:getCurrentRound()
	if self.record == q then
		return
	end
	for p, r in pairs(self.pendingPlayers) do
		print(p, r)
		if r then
			AbilityShop:setPlayerAbilityShopFreeCount(p, -1)
		end
	end
	self.record = q
	self:IncrementStackCount()
	if self:GetStackCount() >= self.round then
		PlayerData:eachAlivePlayerHero(function(n, o, p)
			self.pendingPlayers[p] = true
			AbilityShop:setPlayerAbilityShopFreeCount(p, 1)
		end)
		self:SetStackCount(0)
	end
end
function l.prototype.OnAbilityFree(self, m)
	if m.playerID ~= nil then
		self.pendingPlayers[m.playerID] = false
	end
end
l = e(
	{
		i(
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
	l
)
g.modifier_city_39 = l
return g