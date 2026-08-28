--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/card_effect/modifier_card_effect_76"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 2,
		["9"] = 2,
		["10"] = 2,
		["11"] = 4,
		["12"] = 13,
		["13"] = 4,
		["14"] = 13,
		["15"] = 19,
		["16"] = 20,
		["17"] = 21,
		["18"] = 22,
		["19"] = 23,
		["20"] = 24,
		["21"] = 25,
		["22"] = 27,
		["23"] = 28,
		["24"] = 29,
		["25"] = 30,
		["26"] = 31,
		["27"] = 32,
		["28"] = 33,
		["29"] = 34,
		["31"] = 36,
		["32"] = 37,
		["33"] = 39,
		["36"] = 19,
		["37"] = 43,
		["38"] = 43,
		["39"] = 43,
		["41"] = 44,
		["44"] = 45,
		["45"] = 46,
		["46"] = 47,
		["47"] = 48,
		["49"] = 51,
		["50"] = 52,
		["51"] = 53,
		["52"] = 54,
		["53"] = 55,
		["54"] = 56,
		["55"] = 59,
		["57"] = 61,
		["59"] = 43,
		["60"] = 68,
		["61"] = 69,
		["62"] = 68,
		["63"] = 74,
		["64"] = 75,
		["65"] = 76,
		["68"] = 77,
		["69"] = 78,
		["70"] = 79,
		["71"] = 80,
		["72"] = 81,
		["73"] = 82,
		["74"] = 83,
		["75"] = 86,
		["77"] = 88,
		["79"] = 74,
		["80"] = 13,
		["81"] = 4,
		["82"] = 4,
		["83"] = 4,
		["84"] = 4,
		["85"] = 4,
		["86"] = 4,
		["87"] = 4,
		["88"] = 4,
		["89"] = 4,
		["90"] = 13,
		["92"] = 13,
	}
)
local g = {}
local h = require("modifiers.eom_modifier")
local i = h.EOMModifier
local j = h.registerEOMModifier
g.modifier_card_effect_76 = c()
local k = g.modifier_card_effect_76
k.name = "modifier_card_effect_76"
d(k, i)
function k.prototype.OnCreated(self, l)
	if IsServer() then
		self.has_trigger = false
		self.is_end = false
		self.create_round = Rounds:getCurrentRound()
		local m = self:GetParent():GetPlayerOwnerID()
		local n = PlayerData:getHero(m)
		self.sect = ""
		local o = {}
		if n then
			local p = AbilityShop.pickList
			o = n:getAbilityUpgradeData()
			local q = #p
			local r = RandomInt(0, q - 1)
			self.sect = p[r + 1]
		end
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
function k.prototype.AddAbility(self, s)
	if s == nil then
		s = false
	end
	if not IsServer() then
		return
	end
	if Rounds:getCurrentRound() >= self.create_round and not self.has_trigger then
		self.has_trigger = true
		if s then
			self.create_round = self.create_round + 1
		end
		local m = self:GetParent():GetPlayerOwnerID()
		local n = PlayerData:getHero(m)
		for t, u in pairs(self.pool.tList) do
			local v = t
			local w = 3
			local p = { [v] = w }
			n:modifyTempAbilityUpgrade(p, false)
		end
		Notification:combatToPlayer(
			m,
			{
				message = "notify_card_effect",
				string_card1 = "DOTA_Tooltip_ability_card_effect_76",
				string_card2 = "DOTA_Tooltip_ability_" .. self.sect,
			}
		)
	end
end
function k.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function k.prototype.OnBattleEndStateEnd(self, l)
	self:AddAbility(true)
	if not IsServer() then
		return
	end
	if Rounds:getCurrentRound() >= self.create_round and self.has_trigger and not self.is_end then
		local m = self:GetParent():GetPlayerOwnerID()
		local n = PlayerData:getHero(m)
		for t, u in pairs(self.pool.tList) do
			local v = t
			local w = 3
			local p = { [v] = w }
			n:modifyTempAbilityUpgrade(p, true)
		end
		self:Destroy()
	end
end
k = e(
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
				GetAttributes = MODIFIER_ATTRIBUTE_MULTIPLE,
			}
		),
	},
	k
)
g.modifier_card_effect_76 = k
return g