--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_75"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__ArrayFilter
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
		["24"] = 27,
		["25"] = 28,
		["26"] = 29,
		["27"] = 29,
		["28"] = 29,
		["29"] = 30,
		["30"] = 30,
		["32"] = 31,
		["33"] = 31,
		["34"] = 31,
		["35"] = 31,
		["36"] = 32,
		["39"] = 29,
		["40"] = 29,
		["41"] = 35,
		["42"] = 35,
		["43"] = 35,
		["44"] = 35,
		["45"] = 36,
		["46"] = 37,
		["47"] = 38,
		["48"] = 39,
		["49"] = 40,
		["50"] = 42,
		["53"] = 19,
		["54"] = 46,
		["55"] = 47,
		["56"] = 46,
		["57"] = 51,
		["58"] = 51,
		["59"] = 51,
		["61"] = 52,
		["64"] = 53,
		["65"] = 54,
		["66"] = 55,
		["67"] = 56,
		["69"] = 59,
		["70"] = 60,
		["71"] = 61,
		["72"] = 62,
		["73"] = 63,
		["74"] = 64,
		["75"] = 67,
		["77"] = 69,
		["79"] = 51,
		["80"] = 77,
		["81"] = 78,
		["82"] = 79,
		["85"] = 80,
		["86"] = 81,
		["87"] = 82,
		["88"] = 83,
		["89"] = 84,
		["90"] = 85,
		["91"] = 86,
		["92"] = 89,
		["94"] = 91,
		["96"] = 77,
		["97"] = 13,
		["98"] = 4,
		["99"] = 4,
		["100"] = 4,
		["101"] = 4,
		["102"] = 4,
		["103"] = 4,
		["104"] = 4,
		["105"] = 4,
		["106"] = 4,
		["107"] = 13,
		["109"] = 13,
	}
)
local i = {}
local j = require("modifiers.eom_modifier")
local k = j.EOMModifier
local l = j.registerEOMModifier
i.modifier_card_effect_75 = c()
local m = i.modifier_card_effect_75
m.name = "modifier_card_effect_75"
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
		e(q, function(r, s)
			if self.sect == "" then
				self.sect = s
			else
				local t = p and p:getAbilityData(true)[self.sect]
				local u = t and t.exp or 0
				local v = p and p:getAbilityData(true)[s]
				if u < (v and v.exp or 0) then
					self.sect = s
				end
			end
		end)
		q = f(q, function(r, s)
			return s ~= self.sect
		end)
		local w = #q
		local x = RandomInt(0, w - 1)
		self.sect = q[x + 1]
		self.pool = AbilityShop:getAbilityPoolNew("n", self.sect, nil, false)
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
function m.prototype.AddAbility(self, y)
	if y == nil then
		y = false
	end
	if not IsServer() then
		return
	end
	if Rounds:getCurrentRound() >= self.create_round and not self.has_trigger then
		self.has_trigger = true
		if y then
			self.create_round = self.create_round + 1
		end
		local o = self:GetParent():GetPlayerOwnerID()
		local p = PlayerData:getHero(o)
		for z, A in pairs(self.pool.tList) do
			local B = z
			local C = 5
			local q = { [B] = C }
			p:modifyTempAbilityUpgrade(q, false)
		end
		Notification:combatToPlayer(
			o,
			{
				message = "notify_card_effect",
				string_card1 = "DOTA_Tooltip_ability_card_effect_75",
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
		for z, A in pairs(self.pool.tList) do
			local B = z
			local C = 5
			local q = { [B] = C }
			p:modifyTempAbilityUpgrade(q, true)
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
i.modifier_card_effect_75 = m
return i