--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_4"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 2,
		["10"] = 2,
		["11"] = 3,
		["12"] = 3,
		["14"] = 6,
		["15"] = 14,
		["16"] = 6,
		["17"] = 14,
		["18"] = 16,
		["19"] = 17,
		["20"] = 18,
		["21"] = 20,
		["22"] = 24,
		["25"] = 16,
		["26"] = 28,
		["27"] = 29,
		["28"] = 30,
		["29"] = 31,
		["31"] = 28,
		["32"] = 34,
		["33"] = 35,
		["34"] = 34,
		["35"] = 40,
		["36"] = 41,
		["37"] = 42,
		["38"] = 44,
		["39"] = 48,
		["42"] = 40,
		["43"] = 52,
		["44"] = 53,
		["45"] = 54,
		["46"] = 55,
		["48"] = 52,
		["49"] = 58,
		["50"] = 60,
		["51"] = 61,
		["52"] = 62,
		["53"] = 62,
		["54"] = 62,
		["55"] = 63,
		["56"] = 64,
		["58"] = 66,
		["59"] = 67,
		["61"] = 62,
		["62"] = 62,
		["64"] = 72,
		["65"] = 58,
		["66"] = 14,
		["67"] = 6,
		["68"] = 6,
		["69"] = 6,
		["70"] = 6,
		["71"] = 6,
		["72"] = 6,
		["73"] = 6,
		["74"] = 6,
		["75"] = 14,
		["77"] = 14,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.registerEOMModifier
local k = require("modifiers.city_effect.city_effect_modifier")
local l = k.CityEffectModifier
h.modifier_city_4 = c()
local m = h.modifier_city_4
m.name = "modifier_city_4"
d(m, l)
function m.prototype.OnCreated(self, n)
	if IsServer() then
		if GameState:getStateName() == "GameState_Prepare" and not GameState:isNowNeutralBattleRound() then
			self.battleData = MatchBattleNew:getBattleData()
			self:updateNetTable()
		end
	end
end
function m.prototype.OnDestroy(self)
	if IsServer() then
		self.battleData = nil
		self:updateNetTable()
	end
end
function m.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START_BEFORE] = { -1, -1 },
	}
end
function m.prototype.OnPrepare(self, n)
	if IsServer() then
		if not GameState:isNowNeutralBattleRound() then
			self.battleData = MatchBattleNew:getBattleData()
			self:updateNetTable()
		end
	end
end
function m.prototype.OnBattleStartBefore(self, n)
	if self.battleData then
		self.battleData = nil
		self:updateNetTable()
	end
end
function m.prototype.updateNetTable(self)
	local o = {}
	if self.battleData and #self.battleData > 0 then
		e(self.battleData, function(p, q)
			if not q.customerPlayer.illusion then
				o[q.customerPlayer.PlayerID] = q.mainPlayer.PlayerID
			end
			if not q.mainPlayer.illusion then
				o[q.mainPlayer.PlayerID] = q.customerPlayer.PlayerID
			end
		end)
	end
	CustomNetTables:SetTableValue("common", "enemy_prophecy", { data = o })
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
h.modifier_city_4 = m
return h