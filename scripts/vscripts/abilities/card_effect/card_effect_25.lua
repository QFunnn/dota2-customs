--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/card_effect/card_effect_25"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["15"] = 3,
		["16"] = 6,
		["17"] = 3,
		["18"] = 7,
		["19"] = 8,
		["20"] = 9,
		["21"] = 10,
		["22"] = 11,
		["23"] = 16,
		["24"] = 16,
		["25"] = 16,
		["26"] = 16,
		["27"] = 16,
		["28"] = 16,
		["29"] = 16,
		["30"] = 17,
		["31"] = 18,
		["32"] = 16,
		["33"] = 16,
		["34"] = 24,
		["35"] = 25,
		["36"] = 27,
		["37"] = 28,
		["38"] = 29,
		["40"] = 31,
		["41"] = 32,
		["43"] = 34,
		["44"] = 7,
		["45"] = 36,
		["46"] = 37,
		["49"] = 40,
		["50"] = 41,
		["51"] = 36,
		["52"] = 43,
		["53"] = 44,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 48,
		["58"] = 48,
		["59"] = 48,
		["60"] = 48,
		["61"] = 48,
		["62"] = 48,
		["65"] = 43,
	}
)
local g = {}
local h = require("abilities.card_effect.card_effect_base")
local i = h.CardEffectBase
g.card_effect_25 = c()
local j = g.card_effect_25
j.name = "card_effect_25"
d(j, i)
function j.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.dead = false
end
function j.prototype.spawn(self)
	local k = self:getPlayerID()
	local l = PlayerData:getHero(k)
	local m = self:getSpecialValueFor("count")
	local n = AbilityShop:getRandomAbility(
		k,
		m,
		{ specifyRarity = "sr", specifyRarityIgnoreRule = true, isAbilityShop = false }
	)
	e(n, function(o, p, q)
		local r
		local s
		s = p.aid
		r = p.rarity
		l:learnAbility(s, true)
		Notification:combatToPlayer(
			k,
			{
				message = "notify_artifact_ability_" .. r,
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self.cardName,
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. s,
			}
		)
	end)
	local t = self:getSpecialValueFor("cost")
	local u = PlayerData.playerData[k].health
	local v = math.min(t, u - 1)
	if v > 0 then
		PlayerData:modifyHealth(k, -v, true)
	end
	if u - t <= 0 then
		self.dead = true
	end
	self.id = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE, self.OnConfirmBattle)
end
function j.prototype.OnConfirmBattle(self, w)
	if w.isNeutral then
		return
	end
	self:RemoveModifierEvent(self.id)
	self.id2 = self:ModifierEvent(EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END, self.OnBattleEndStateStart)
end
function j.prototype.OnBattleEndStateStart(self, w)
	self:RemoveModifierEvent(self.id2)
	if self.dead then
		self.dead = false
		if PlayerData:getAlivePlayerCount() > 1 then
			PlayerData:playerTakenDamage(self:getPlayerID(), -1, 99, false)
		end
	end
end
return g