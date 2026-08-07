--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_46"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayForEach
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["14"] = 2,
		["15"] = 5,
		["16"] = 6,
		["17"] = 5,
		["18"] = 6,
		["19"] = 7,
		["20"] = 8,
		["21"] = 7,
		["22"] = 6,
		["23"] = 5,
		["24"] = 6,
		["26"] = 6,
		["27"] = 12,
		["28"] = 19,
		["29"] = 12,
		["30"] = 19,
		["31"] = 26,
		["32"] = 27,
		["33"] = 28,
		["34"] = 29,
		["35"] = 26,
		["36"] = 31,
		["37"] = 32,
		["38"] = 33,
		["40"] = 31,
		["41"] = 36,
		["42"] = 37,
		["43"] = 38,
		["44"] = 39,
		["45"] = 40,
		["46"] = 41,
		["49"] = 36,
		["50"] = 45,
		["51"] = 46,
		["52"] = 45,
		["53"] = 50,
		["54"] = 51,
		["55"] = 52,
		["56"] = 53,
		["57"] = 54,
		["58"] = 55,
		["59"] = 56,
		["60"] = 57,
		["61"] = 58,
		["62"] = 59,
		["63"] = 60,
		["64"] = 61,
		["66"] = 63,
		["67"] = 63,
		["68"] = 63,
		["69"] = 63,
		["70"] = 63,
		["71"] = 63,
		["72"] = 63,
		["73"] = 63,
		["76"] = 70,
		["77"] = 71,
		["78"] = 72,
		["81"] = 50,
		["82"] = 76,
		["83"] = 77,
		["84"] = 76,
		["85"] = 81,
		["86"] = 82,
		["87"] = 82,
		["88"] = 82,
		["89"] = 82,
		["90"] = 82,
		["91"] = 82,
		["93"] = 82,
		["94"] = 83,
		["95"] = 84,
		["96"] = 85,
		["97"] = 86,
		["98"] = 91,
		["99"] = 92,
		["100"] = 93,
		["101"] = 93,
		["102"] = 93,
		["103"] = 93,
		["104"] = 93,
		["105"] = 93,
		["106"] = 93,
		["107"] = 94,
		["108"] = 95,
		["109"] = 95,
		["110"] = 95,
		["111"] = 95,
		["112"] = 95,
		["113"] = 95,
		["114"] = 95,
		["115"] = 95,
		["116"] = 100,
		["117"] = 100,
		["118"] = 100,
		["119"] = 100,
		["120"] = 100,
		["121"] = 93,
		["122"] = 93,
		["123"] = 102,
		["124"] = 103,
		["125"] = 104,
		["127"] = 81,
		["128"] = 19,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 12,
		["135"] = 12,
		["136"] = 19,
		["138"] = 19,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
local l = require("modifiers.eom_modifier")
local m = l.EOMModifier
local n = l.registerEOMModifier
h.trait_46 = c()
local o = h.trait_46
o.name = "trait_46"
d(o, j)
function o.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_46"
end
o = e({ k(nil) }, o)
h.trait_46 = o
h.modifier_trait_46 = c()
local p = h.modifier_trait_46
p.name = "modifier_trait_46"
d(p, m)
function p.prototype.GetAbilitySpecialValue(self)
	self.count2 = self:GetAbilitySpecialValueFor("count2")
	self.count = self:GetAbilitySpecialValueFor("count")
	self.round = self:GetAbilitySpecialValueFor("round")
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		self:SetStackCount(self.count)
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		local r = self:GetParent():GetPlayerOwnerID()
		local s = PlayerData:getHero(r)
		if self.tempData then
			s:modifyTempAbilityUpgrade(self.tempData, true)
		end
	end
end
function p.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END_STATE_END] = { -1, -1 } }
end
function p.prototype.OnBattleEndStateEnd(self, q)
	local t = Rounds:getCurrentRound()
	if self.round_record and t - self.round_record >= self.round then
		if self.tempData then
			local r = self:GetParent():GetPlayerOwnerID()
			local s = PlayerData:getHero(r)
			for u, v in pairs(self.tempData) do
				local w = "notify_card_loss"
				local x = KeyValues.AbilityUpgradesKvs[u]
				if x then
					if x.rarity ~= "n" then
						w = (w .. "_") .. tostring(x.rarity)
					end
					Notification:combatToPlayer(
						r,
						{
							message = w,
							string_card = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
						}
					)
				end
			end
			s:modifyTempAbilityUpgrade(self.tempData, true)
			self.tempData = nil
			self.round_record = nil
		end
	end
end
function p.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_PLAYER_AVOID_LETHAL_DAMAGE }
end
function p.prototype.EOM_GetModifierPlayerAvoidLethalDamage(self, q)
	local y = PlayerData:loadData(self.parent:GetPlayerOwnerID(), "AnotherLife")
	if y == nil then
		y = 0
	end
	if y < 1 and self:GetStackCount() > 0 then
		local z = self:GetParent()
		self:DecrementStackCount()
		local r = z:GetPlayerOwnerID()
		local A = AbilityShop:getRandomAbility(
			r,
			self.count2,
			{ specifyRarity = "sr", specifyRarityIgnoreRule = true, isAbilityShop = false }
		)
		self.tempData = {}
		local s = PlayerData:getHero(r)
		f(A, function(B, C, D)
			local E
			local u
			u = C.aid
			E = C.rarity
			self.tempData[u] = 1
			Notification:combatToPlayer(
				r,
				{
					message = "notify_temp_ability_" .. E,
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. u,
				}
			)
			PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), u, D == #A - 1)
		end)
		s:modifyTempAbilityUpgrade(self.tempData)
		self.round_record = Rounds:getCurrentRound()
		return 1
	end
end
p = e(
	{ n(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	p
)
h.modifier_trait_46 = p
return h