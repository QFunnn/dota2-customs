--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_13"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 8,
		["14"] = 9,
		["15"] = 10,
		["16"] = 11,
		["17"] = 12,
		["18"] = 13,
		["19"] = 14,
		["20"] = 8,
		["21"] = 20,
		["22"] = 21,
		["25"] = 24,
		["26"] = 25,
		["27"] = 26,
		["30"] = 29,
		["31"] = 30,
		["33"] = 32,
		["35"] = 34,
		["36"] = 35,
		["37"] = 36,
		["38"] = 20,
		["39"] = 38,
		["40"] = 39,
		["41"] = 40,
		["42"] = 41,
		["43"] = 42,
		["44"] = 43,
		["47"] = 46,
		["49"] = 48,
		["50"] = 49,
		["51"] = 50,
		["52"] = 38,
		["53"] = 52,
		["54"] = 53,
		["55"] = 54,
		["56"] = 55,
		["57"] = 56,
		["59"] = 62,
		["60"] = 52,
		["61"] = 64,
		["62"] = 65,
		["63"] = 66,
		["64"] = 67,
		["65"] = 68,
		["66"] = 3,
		["67"] = 64,
	}
)
local f = {}
local g = require("abilities.card_effect.card_effect_base")
local h = g.CardEffectBase
f.card_effect_13 = c()
local i = f.card_effect_13
i.name = "card_effect_13"
d(i, h)
function i.prototype.spawn(self)
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_START, self.OnBattleStart)
	self.id_end = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END, self.OnBattleEnd)
	local j = self:getPlayerID()
	local k = self:getSpecialValueFor("gold")
	PlayerData:modifyGold(j, k)
	Notification:combatToPlayer(
		j,
		{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName, int_gold = k }
	)
end
function i.prototype.OnBattleEnd(self, l)
	if l.isNeutral ~= nil then
		return
	end
	local m = self:getPlayerID()
	local n = (l.winPlayerID == m or l.losePlayerID == m) and (l.illusionPlayerID == nil or l.illusionPlayerID ~= m)
	if not n then
		return
	end
	if l.winPlayerID == m then
		self.enemyPlayerID = l.losePlayerID
	else
		self.enemyPlayerID = l.winPlayerID
	end
	self:RemoveModifierEvent(self.id)
	self:RemoveModifierEvent(self.id_end)
	self.id2 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE, self.OnPrepare)
end
function i.prototype.OnBattleStart(self, o)
	local j = self:getPlayerID()
	local p = PlayerData:getHero(j).hero
	local q = p and p:GetEnemy()
	if IsValid(p) and IsValid(q) then
		if q:GetPlayerOwnerID() == j then
			return
		end
		self.enemyPlayerID = q:GetPlayerOwnerID()
	end
	self:RemoveModifierEvent(self.id)
	self:RemoveModifierEvent(self.id_end)
	self.id2 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_PREPARE, self.OnPrepare)
end
function i.prototype.OnPrepare(self, o)
	if self.enemyPlayerID ~= nil then
		local k = self:getSpecialValueFor("gold")
		PlayerData:modifyGold(self.enemyPlayerID, k)
		Notification:combatToPlayer(
			self.enemyPlayerID,
			{ message = "notify_bonus_gold", string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName, int_gold = k }
		)
	end
	self:RemoveModifierEvent(self.id2)
end
function i.prototype.dispose(self)
	self.enemyPlayerID = nil
	self:RemoveModifierEvent(self.id)
	self:RemoveModifierEvent(self.id_end)
	self:RemoveModifierEvent(self.id2)
	h.prototype.dispose(self)
end
return f