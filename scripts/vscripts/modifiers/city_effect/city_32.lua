--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_32"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayIncludes
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 2,
		["12"] = 2,
		["14"] = 5,
		["15"] = 13,
		["16"] = 5,
		["17"] = 13,
		["19"] = 13,
		["20"] = 16,
		["21"] = 5,
		["22"] = 19,
		["23"] = 20,
		["24"] = 21,
		["25"] = 19,
		["26"] = 23,
		["27"] = 24,
		["28"] = 25,
		["29"] = 26,
		["30"] = 27,
		["31"] = 28,
		["32"] = 26,
		["35"] = 23,
		["36"] = 33,
		["37"] = 34,
		["38"] = 35,
		["39"] = 36,
		["41"] = 33,
		["42"] = 39,
		["43"] = 40,
		["44"] = 39,
		["45"] = 44,
		["46"] = 45,
		["49"] = 48,
		["50"] = 48,
		["51"] = 49,
		["52"] = 50,
		["53"] = 44,
		["54"] = 52,
		["55"] = 53,
		["56"] = 54,
		["57"] = 55,
		["58"] = 56,
		["59"] = 57,
		["60"] = 55,
		["62"] = 52,
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
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.registerEOMModifier
local k = require("modifiers.city_effect.city_effect_modifier")
local l = k.CityEffectModifier
h.modifier_city_32 = c()
local m = h.modifier_city_32
m.name = "modifier_city_32"
d(m, l)
function m.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.enable = true
end
function m.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
	self.level = self:GetAbilitySpecialValueFor("level")
end
function m.prototype.OnDestroy(self)
	if IsServer() then
		if PlayerResource then
			PlayerData:eachAlivePlayerHero(function(n, o, p)
				local q = PlayerData:getplayerData(p)
				q:setChangeEquipLevelValues(-1, -1)
			end)
		end
	end
end
function m.prototype.OnCreated(self, r)
	if IsServer() then
		self.refreshList = {}
		self:EffectFunc()
	end
end
function m.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_SELECT_NEUTRAL_EQUIP] = { -1, -1 } }
end
function m.prototype.OnSelectNeutalEquip(self, r)
	if e(self.refreshList, r.playerID) then
		return
	end
	local s = self.refreshList
	s[#s + 1] = r.playerID
	local t = PlayerData:getplayerData(r.playerID)
	t:updateEquipment()
end
function m.prototype.EffectFunc(self)
	if self.enable then
		self.enable = false
		PlayerData:eachAlivePlayerHero(function(n, o, p)
			local q = PlayerData:getplayerData(p)
			q:setChangeEquipLevelValues(self.round, self.level)
		end)
	end
end
m = f(
	{
		j(
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
	m
)
h.modifier_city_32 = m
return h