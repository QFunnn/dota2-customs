--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_74"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 2,
		["11"] = 2,
		["12"] = 2,
		["13"] = 4,
		["14"] = 13,
		["15"] = 4,
		["16"] = 13,
		["17"] = 19,
		["18"] = 20,
		["19"] = 21,
		["20"] = 22,
		["21"] = 23,
		["22"] = 24,
		["23"] = 25,
		["24"] = 26,
		["25"] = 27,
		["26"] = 30,
		["27"] = 30,
		["28"] = 31,
		["29"] = 32,
		["30"] = 33,
		["31"] = 34,
		["33"] = 39,
		["34"] = 40,
		["35"] = 40,
		["36"] = 40,
		["37"] = 41,
		["38"] = 41,
		["40"] = 43,
		["41"] = 43,
		["42"] = 43,
		["43"] = 43,
		["44"] = 44,
		["47"] = 40,
		["48"] = 40,
		["49"] = 58,
		["50"] = 59,
		["51"] = 61,
		["54"] = 19,
		["55"] = 65,
		["56"] = 66,
		["57"] = 65,
		["58"] = 70,
		["59"] = 70,
		["60"] = 70,
		["62"] = 71,
		["65"] = 72,
		["66"] = 73,
		["67"] = 74,
		["69"] = 76,
		["70"] = 78,
		["71"] = 79,
		["72"] = 80,
		["73"] = 81,
		["74"] = 82,
		["75"] = 83,
		["76"] = 86,
		["78"] = 88,
		["80"] = 70,
		["81"] = 96,
		["82"] = 97,
		["83"] = 98,
		["86"] = 99,
		["87"] = 100,
		["88"] = 101,
		["89"] = 102,
		["90"] = 103,
		["91"] = 104,
		["92"] = 105,
		["93"] = 108,
		["95"] = 110,
		["97"] = 96,
		["98"] = 13,
		["99"] = 4,
		["100"] = 4,
		["101"] = 4,
		["102"] = 4,
		["103"] = 4,
		["104"] = 4,
		["105"] = 4,
		["106"] = 4,
		["107"] = 4,
		["108"] = 13,
		["110"] = 13,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
i.modifier_card_effect_74 = c()
local m = i.modifier_card_effect_74
m.name = "modifier_card_effect_74"
d(m, k)
function m.prototype.OnCreated(self, n)
	if IsServer() then
		self.has_trigger = false
		self.is_end = false
		self.create_round = Rounds:getCurrentRound()
		local o = self:GetParent():GetPlayerOwnerID()
		local p = PlayerData:getHero(o)
		self.sect = ""
		local q = AbilityShop.pickList
		local r = PlayerData:getplayerData(o)
		local s = r and r.heroName
		local t = AbilityShop:GetRecommendSectByHeroName(s)
		local u
		if t ~= "sect_none" then
			u = e(t, "|")
		end
		local v = u and u or q
		f(v, function(w, x)
			if self.sect == "" then
				self.sect = x
			else
				local y = p and p:getAbilityData(true)[self.sect]
				local z = y and y.exp or 0
				local A = p and p:getAbilityData(true)[x]
				if z > (A and A.exp or 0) then
					self.sect = x
				end
			end
		end)
		self.pool = AbilityShop:getAbilityPoolNew("r", self.sect, nil, false)
		if
			GameState:getState():getStateName() == "GameState_Prepare"
			or GameState:getState():getStateName() == "GameState_SpecialSelection"
			or GameState:getState():getStateName() == "GameState_ArtifactSelection"
		then
			self:AddAbility()
		end
	end
end
function m.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function m.prototype.AddAbility(self, B)
	if B == nil then
		B = false
	end
	if not IsServer() then
		return
	end
	if Rounds:getCurrentRound() >= self.create_round and not self.has_trigger then
		if B then
			self.create_round = self.create_round + 1
		end
		self.has_trigger = true
		local o = self:GetParent():GetPlayerOwnerID()
		local p = PlayerData:getHero(o)
		for C, D in pairs(self.pool.tList) do
			local E = C
			local F = 3
			local G = { [E] = F }
			p:modifyTempAbilityUpgrade(G, false)
		end
		Notification:combatToPlayer(
			o,
			{
				message = "notify_card_effect",
				string_card1 = "DOTA_Tooltip_ability_card_effect_74",
				string_card2 = "DOTA_Tooltip_ability_" .. self.sect,
			}
		)
	end
end
function m.prototype.OnBattleEndStateEnd(self, n)
	self:AddAbility(true)
	if not IsServer() then
		return
	end
	if Rounds:getCurrentRound() >= self.create_round and self.has_trigger and not self.is_end then
		local o = self:GetParent():GetPlayerOwnerID()
		local p = PlayerData:getHero(o)
		for C, D in pairs(self.pool.tList) do
			local E = C
			local F = 3
			local G = { [E] = F }
			p:modifyTempAbilityUpgrade(G, true)
		end
		self:Destroy()
	end
end
m = g(
	{
		l(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	m
)
i.modifier_card_effect_74 = m
return i