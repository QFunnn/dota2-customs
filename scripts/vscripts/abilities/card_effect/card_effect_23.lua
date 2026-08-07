--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_23"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ObjectKeys
local f = b.__TS__ArrayFilter
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 3,
		["15"] = 8,
		["16"] = 9,
		["17"] = 8,
		["18"] = 11,
		["19"] = 12,
		["22"] = 15,
		["23"] = 16,
		["24"] = 11,
		["25"] = 18,
		["26"] = 19,
		["27"] = 20,
		["28"] = 21,
		["29"] = 22,
		["30"] = 23,
		["32"] = 25,
		["33"] = 26,
		["34"] = 18,
		["35"] = 28,
		["36"] = 29,
		["37"] = 30,
		["38"] = 31,
		["39"] = 32,
		["40"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 35,
		["45"] = 36,
		["46"] = 36,
		["47"] = 36,
		["48"] = 37,
		["49"] = 38,
		["50"] = 39,
		["51"] = 40,
		["52"] = 36,
		["53"] = 36,
		["54"] = 44,
		["57"] = 45,
		["58"] = 47,
		["59"] = 49,
		["60"] = 49,
		["61"] = 49,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 49,
		["67"] = 34,
		["71"] = 28,
	}
)
local h = {}
local i = require("abilities.card_effect.card_effect_base")
local j = i.CardEffectBase
h.card_effect_23 = c()
local k = h.card_effect_23
k.name = "card_effect_23"
d(k, j)
function k.prototype.spawn(self)
	self.id3 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, self.OnConfirmBattle)
end
function k.prototype.OnConfirmBattle(self, l)
	if l.isNeutral then
		return
	end
	self:RemoveModifierEvent(self.id3)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START, self.OnBattleStart)
end
function k.prototype.OnBattleStart(self, l)
	local m = self:getPlayerID()
	local n = PlayerData:getHero(m).hero
	local o = n and n:GetEnemy()
	if IsValid(n) and IsValid(o) then
		self.enemyPlayerID = o:GetPlayerOwnerID()
	end
	self.id2 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE, self.OnPrepare)
	self:RemoveModifierEvent(self.id)
end
function k.prototype.OnPrepare(self, l)
	self:RemoveModifierEvent(self.id2)
	if self.enemyPlayerID ~= nil then
		local p = self:getSpecialValueFor("count")
		local m = self:getPlayerID()
		local n = PlayerData:getHero(m)
		do
			local q = 0
			while q < p do
				local r = PlayerData:getHero(m):getAbilityUpgradeData()
				local s = PlayerData:getHero(self.enemyPlayerID)
				local t = f(e(s and s:getAbilityUpgradeData() or {}), function(u, v)
					local w = KeyValues.AbilityUpgradesKvs[v]
					local x = SECT_ABILITY_LEVEL[w.rarity]
					return r[v] == nil or r[v].level < x
				end)
				if #t <= 0 then
					return
				end
				local y = GetRandomElement(t)
				n:learnAbility(y, true)
				Notification:combatToPlayer(
					m,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[y].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
					}
				)
				q = q + 1
			end
		end
	end
end
return h