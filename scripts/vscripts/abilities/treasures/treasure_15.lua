--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_15"
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
		["14"] = 4,
		["15"] = 5,
		["16"] = 4,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 6,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["25"] = 5,
		["26"] = 10,
		["27"] = 17,
		["28"] = 10,
		["29"] = 17,
		["30"] = 24,
		["31"] = 25,
		["32"] = 26,
		["33"] = 27,
		["34"] = 24,
		["35"] = 29,
		["36"] = 30,
		["37"] = 31,
		["39"] = 29,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["48"] = 34,
		["49"] = 43,
		["50"] = 44,
		["51"] = 43,
		["52"] = 48,
		["53"] = 49,
		["54"] = 50,
		["55"] = 51,
		["56"] = 52,
		["57"] = 53,
		["58"] = 54,
		["59"] = 55,
		["60"] = 56,
		["61"] = 57,
		["62"] = 58,
		["63"] = 59,
		["65"] = 61,
		["66"] = 61,
		["67"] = 61,
		["68"] = 61,
		["69"] = 61,
		["70"] = 61,
		["71"] = 61,
		["72"] = 61,
		["75"] = 68,
		["76"] = 69,
		["77"] = 70,
		["80"] = 48,
		["81"] = 74,
		["82"] = 75,
		["83"] = 74,
		["84"] = 79,
		["85"] = 80,
		["86"] = 80,
		["87"] = 80,
		["88"] = 80,
		["89"] = 80,
		["90"] = 80,
		["92"] = 80,
		["93"] = 81,
		["94"] = 82,
		["95"] = 83,
		["96"] = 84,
		["97"] = 89,
		["98"] = 90,
		["100"] = 91,
		["101"] = 91,
		["102"] = 92,
		["103"] = 92,
		["104"] = 92,
		["105"] = 93,
		["106"] = 94,
		["107"] = 94,
		["108"] = 94,
		["109"] = 94,
		["110"] = 94,
		["111"] = 94,
		["112"] = 94,
		["113"] = 94,
		["114"] = 99,
		["115"] = 99,
		["116"] = 99,
		["117"] = 99,
		["118"] = 99,
		["119"] = 91,
		["122"] = 101,
		["123"] = 102,
		["124"] = 103,
		["126"] = 79,
		["127"] = 17,
		["128"] = 10,
		["129"] = 10,
		["130"] = 10,
		["131"] = 10,
		["132"] = 10,
		["133"] = 10,
		["134"] = 10,
		["135"] = 17,
		["137"] = 17,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
g.treasure_15 = c()
local n = g.treasure_15
n.name = "treasure_15"
d(n, i)
function n.prototype.GetIntrinsicModifierName(self)
	return "modifier_treasure_15"
end
n = e({ j(nil) }, n)
g.treasure_15 = n
g.modifier_treasure_15 = c()
local o = g.modifier_treasure_15
o.name = "modifier_treasure_15"
d(o, l)
function o.prototype.GetAbilitySpecialValue(self)
	self.count2 = self:GetAbilitySpecialValueFor("count2")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function o.prototype.OnCreated(self, p)
	if IsServer() then
		self:SetStackCount(self.count)
	end
end
function o.prototype.OnDestroy(self)
	if IsServer() then
		local q = self:GetParent():GetPlayerOwnerID()
		local r = PlayerData:getHero(q)
		if self.tempData then
			r:modifyTempAbilityUpgrade(self.tempData, true)
		end
	end
end
function o.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function o.prototype.OnBattleEndStateEnd(self, p)
	local s = Rounds:getCurrentRound()
	if self.round_record and s - self.round_record >= self.round then
		if self.tempData then
			local q = self:GetParent():GetPlayerOwnerID()
			local r = PlayerData:getHero(q)
			for t, u in pairs(self.tempData) do
				local v = "notify_card_loss"
				local w = KeyValues.AbilityUpgradesKvs[t]
				if w then
					if w.rarity ~= "n" then
						v = (v .. "_") .. tostring(w.rarity)
					end
					Notification:combatToPlayer(
						q,
						{
							message = v,
							string_card = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. t,
						}
					)
				end
			end
			r:modifyTempAbilityUpgrade(self.tempData, true)
			self.tempData = nil
			self.round_record = nil
		end
	end
end
function o.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_AVOID_LETHAL_DAMAGE }
end
function o.prototype.EOM_GetModifierPlayerAvoidLethalDamage(self, p)
	local x = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "AnotherLife")
	if x == nil then
		x = 0
	end
	if x < 1 and self:GetStackCount() > 0 then
		local y = self:GetParent()
		self:DecrementStackCount()
		local q = y:GetPlayerOwnerID()
		local z = AbilityShop:getRandomAbility(
			q,
			self.count2,
			{ specifyRarity = "sr", specifyRarityIgnoreRule = true, isAbilityShop = false }
		)
		self.tempData = {}
		local r = PlayerData:getHero(q)
		do
			local A = 0
			while A < #z do
				local B = z[A + 1]
				local t = B.aid
				local C = B.rarity
				self.tempData[t] = 1
				Notification:combatToPlayer(
					q,
					{
						message = "notify_temp_ability_" .. C,
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. t,
					}
				)
				PlayerData:getplayerData(q):addArtifactAbilities(self:GetAbility():entindex(), t, A == #z - 1)
				A = A + 1
			end
		end
		r:modifyTempAbilityUpgrade(self.tempData)
		self.round_record = Rounds:getCurrentRound()
		return 1
	end
end
o = e(
	{ m(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	o
)
g.modifier_treasure_15 = o
return g