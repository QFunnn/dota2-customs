--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_125"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArrayForEach
local h = b.__TS__SourceMapTraceBack
h(
	debug.getinfo(1).short_src,
	{
		["10"] = 1,
		["11"] = 1,
		["12"] = 1,
		["13"] = 2,
		["14"] = 2,
		["15"] = 2,
		["16"] = 5,
		["17"] = 6,
		["18"] = 5,
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["22"] = 7,
		["23"] = 6,
		["24"] = 5,
		["25"] = 6,
		["27"] = 6,
		["28"] = 12,
		["29"] = 19,
		["30"] = 12,
		["31"] = 19,
		["32"] = 24,
		["33"] = 25,
		["34"] = 24,
		["35"] = 27,
		["36"] = 28,
		["37"] = 29,
		["38"] = 30,
		["39"] = 31,
		["40"] = 32,
		["42"] = 27,
		["43"] = 35,
		["44"] = 36,
		["45"] = 35,
		["46"] = 40,
		["47"] = 41,
		["48"] = 42,
		["50"] = 40,
		["51"] = 45,
		["52"] = 46,
		["53"] = 47,
		["54"] = 48,
		["55"] = 49,
		["56"] = 50,
		["57"] = 51,
		["58"] = 52,
		["59"] = 53,
		["60"] = 54,
		["61"] = 55,
		["62"] = 56,
		["64"] = 58,
		["65"] = 64,
		["66"] = 64,
		["67"] = 64,
		["68"] = 64,
		["69"] = 64,
		["70"] = 64,
		["71"] = 64,
		["72"] = 65,
		["73"] = 65,
		["74"] = 65,
		["75"] = 65,
		["76"] = 65,
		["77"] = 65,
		["78"] = 65,
		["79"] = 65,
		["80"] = 70,
		["81"] = 71,
		["82"] = 71,
		["83"] = 71,
		["84"] = 71,
		["85"] = 71,
		["86"] = 64,
		["87"] = 64,
		["89"] = 74,
		["90"] = 75,
		["91"] = 76,
		["92"] = 77,
		["93"] = 78,
		["94"] = 79,
		["96"] = 81,
		["97"] = 87,
		["98"] = 87,
		["99"] = 87,
		["100"] = 87,
		["101"] = 87,
		["102"] = 87,
		["103"] = 87,
		["104"] = 88,
		["105"] = 88,
		["106"] = 88,
		["107"] = 88,
		["108"] = 88,
		["109"] = 88,
		["110"] = 88,
		["111"] = 88,
		["112"] = 93,
		["113"] = 94,
		["114"] = 94,
		["115"] = 94,
		["116"] = 94,
		["117"] = 94,
		["118"] = 87,
		["119"] = 87,
		["121"] = 97,
		["122"] = 98,
		["123"] = 99,
		["124"] = 100,
		["125"] = 101,
		["126"] = 102,
		["128"] = 104,
		["129"] = 110,
		["130"] = 110,
		["131"] = 110,
		["132"] = 110,
		["133"] = 110,
		["134"] = 110,
		["135"] = 110,
		["136"] = 111,
		["137"] = 111,
		["138"] = 111,
		["139"] = 111,
		["140"] = 111,
		["141"] = 111,
		["142"] = 111,
		["143"] = 111,
		["144"] = 116,
		["145"] = 117,
		["146"] = 117,
		["147"] = 117,
		["148"] = 117,
		["149"] = 117,
		["150"] = 110,
		["151"] = 110,
		["155"] = 45,
		["156"] = 19,
		["157"] = 12,
		["158"] = 12,
		["159"] = 12,
		["160"] = 12,
		["161"] = 12,
		["162"] = 12,
		["163"] = 12,
		["164"] = 19,
		["166"] = 19,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_125 = c()
local p = i.trait_125
p.name = "trait_125"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_125"
end
p = e({ l(nil) }, p)
i.trait_125 = p
i.modifier_trait_125 = c()
local q = i.modifier_trait_125
q.name = "modifier_trait_125"
d(q, n)
function q.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		self.lv1 = self:GetAbilitySpecialValueFor("lv1")
		self.lv2 = self:GetAbilitySpecialValueFor("lv2")
		self.lv3 = self:GetAbilitySpecialValueFor("lv3")
		self:CheckEffect()
	end
end
function q.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_HERO_LEVEL_UP] = { -1, -1 } }
end
function q.prototype.OnHeroLevelUp(self, r)
	if r.player_id == self:GetParent():GetPlayerOwnerID() then
		self:CheckEffect()
	end
end
function q.prototype.CheckEffect(self)
	if IsServer() then
		local s = self:GetParent():GetPlayerOwnerID()
		local t = PlayerData:getHero(s)
		if t then
			local u = t:getLevel()
			if self.lv1 > 0 and u >= self.lv1 then
				self.lv1 = 0
				local v = AbilityShop:GetRecommendSectByHeroName(t.unitName)
				local w
				if v ~= "sect_none" then
					w = f(v, "|")
				end
				local x = AbilityShop:getRandomAbility(
					s,
					self.count,
					{ isAbilityShop = false, specifyRarity = "n", specifyRarityIgnoreRule = true, specifySect = w }
				)
				g(x, function(y, z, A)
					local B
					local C
					C = z.aid
					B = z.rarity
					Notification:combatToPlayer(
						s,
						{
							message = "notify_artifact_ability_" .. B,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
						}
					)
					t:learnAbility(C, true)
					PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), C, A == #x - 1)
				end)
			end
			if self.lv2 > 0 and u >= self.lv2 then
				self.lv2 = 0
				local v = AbilityShop:GetRecommendSectByHeroName(t.unitName)
				local w
				if v ~= "sect_none" then
					w = f(v, "|")
				end
				local x = AbilityShop:getRandomAbility(
					s,
					self.count,
					{ isAbilityShop = false, specifyRarity = "r", specifyRarityIgnoreRule = true, specifySect = w }
				)
				g(x, function(y, z, A)
					local B
					local C
					C = z.aid
					B = z.rarity
					Notification:combatToPlayer(
						s,
						{
							message = "notify_artifact_ability_" .. B,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
						}
					)
					t:learnAbility(C, true)
					PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), C, A == #x - 1)
				end)
			end
			if self.lv3 > 0 and u >= self.lv3 then
				self.lv3 = 0
				local v = AbilityShop:GetRecommendSectByHeroName(t.unitName)
				local w
				if v ~= "sect_none" then
					w = f(v, "|")
				end
				local x = AbilityShop:getRandomAbility(
					s,
					self.count,
					{ isAbilityShop = false, specifySect = w, specifyRarity = "r", specifyRarityIgnoreRule = true }
				)
				g(x, function(y, z, A)
					local B
					local C
					C = z.aid
					B = z.rarity
					Notification:combatToPlayer(
						s,
						{
							message = "notify_artifact_ability_" .. B,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
						}
					)
					t:learnAbility(C, true)
					PlayerData:getplayerData(s):addArtifactAbilities(self:GetAbility():entindex(), C, A == #x - 1)
				end)
			end
		end
	end
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_125 = q
return i