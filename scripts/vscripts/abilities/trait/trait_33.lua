--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_33"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArraySplice
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
		["33"] = 19,
		["34"] = 23,
		["35"] = 12,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 25,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["45"] = 34,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["49"] = 38,
		["51"] = 40,
		["52"] = 41,
		["53"] = 41,
		["54"] = 41,
		["55"] = 44,
		["57"] = 45,
		["58"] = 45,
		["59"] = 46,
		["60"] = 47,
		["62"] = 45,
		["65"] = 50,
		["67"] = 54,
		["68"] = 54,
		["69"] = 55,
		["70"] = 56,
		["71"] = 57,
		["72"] = 58,
		["73"] = 58,
		["74"] = 58,
		["75"] = 58,
		["76"] = 58,
		["77"] = 58,
		["78"] = 58,
		["79"] = 58,
		["80"] = 63,
		["81"] = 63,
		["82"] = 63,
		["83"] = 63,
		["84"] = 63,
		["85"] = 64,
		["86"] = 64,
		["87"] = 64,
		["88"] = 64,
		["89"] = 64,
		["90"] = 54,
		["93"] = 41,
		["94"] = 41,
		["96"] = 69,
		["98"] = 73,
		["99"] = 73,
		["100"] = 74,
		["101"] = 75,
		["102"] = 76,
		["103"] = 77,
		["104"] = 77,
		["105"] = 77,
		["106"] = 77,
		["107"] = 77,
		["108"] = 77,
		["109"] = 77,
		["110"] = 77,
		["111"] = 82,
		["112"] = 82,
		["113"] = 82,
		["114"] = 82,
		["115"] = 82,
		["116"] = 73,
		["122"] = 29,
		["123"] = 94,
		["124"] = 95,
		["125"] = 94,
		["126"] = 97,
		["127"] = 98,
		["128"] = 99,
		["129"] = 100,
		["130"] = 100,
		["131"] = 101,
		["132"] = 102,
		["133"] = 103,
		["136"] = 107,
		["137"] = 111,
		["138"] = 115,
		["140"] = 116,
		["141"] = 116,
		["142"] = 117,
		["143"] = 116,
		["146"] = 123,
		["147"] = 97,
		["148"] = 19,
		["149"] = 12,
		["150"] = 12,
		["151"] = 12,
		["152"] = 12,
		["153"] = 12,
		["154"] = 12,
		["155"] = 12,
		["156"] = 19,
		["158"] = 19,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_33 = c()
local p = i.trait_33
p.name = "trait_33"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_33"
end
p = e({ l(nil) }, p)
i.trait_33 = p
i.modifier_trait_33 = c()
local q = i.modifier_trait_33
q.name = "modifier_trait_33"
d(q, n)
function q.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.getReward = true
end
function q.prototype.GetAbilitySpecialValue(self)
	self.card = self:GetAbilitySpecialValueFor("card")
	self.count = self:GetAbilitySpecialValueFor("count")
end
function q.prototype.OnCreated(self, r)
	if IsServer() then
		local s = self:GetParent()
		self.playerID = s:GetPlayerOwnerID()
		local t = PlayerData:getplayerData(self.playerID)
		if t then
			local u = t.heroName
			local v = AbilityShop:GetRecommendSectByHeroName(u)
			if v ~= "sect_none" then
				self.recommendSects = f(v, "|")
			end
			if self.recommendSects and #self.recommendSects > 1 then
				PlayerData:requestSectSelection(
					self.playerID,
					{ sects = self.recommendSects, ability_name = "trait_33" },
					function(w, x, y)
						do
							local z = 0
							while z < #self.recommendSects do
								if self.recommendSects[z + 1] ~= y then
									g(self.recommendSects, z, 1)
								end
								z = z + 1
							end
						end
						local A = AbilityShop:getRandomAbility(
							self.playerID,
							self.card,
							{ isAbilityShop = false, specifySect = self.recommendSects }
						)
						do
							local z = 0
							while z < #A do
								local B = A[z + 1].aid
								local C = A[z + 1].rarity
								t.hero:learnAbility(B, true)
								Notification:combatToPlayer(
									self.playerID,
									{
										message = "notify_artifact_ability_" .. C,
										string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
											:GetAbilityName(),
										string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
									}
								)
								PlayerData:getplayerData(self.playerID)
									:addArtifactAbilities(self:GetAbility():entindex(), B, z == #A - 1)
								t:modifyArtifactExtraStringData(
									self:GetAbility():entindex(),
									"DOTA_Tooltip_ability_trait_recommendsect_effect",
									"#DOTA_Tooltip_ability_" .. self.recommendSects[1]
								)
								z = z + 1
							end
						end
					end
				)
			else
				local A = AbilityShop:getRandomAbility(
					self.playerID,
					self.card,
					{ isAbilityShop = false, specifySect = self.recommendSects }
				)
				do
					local z = 0
					while z < #A do
						local B = A[z + 1].aid
						local C = A[z + 1].rarity
						t.hero:learnAbility(B, true)
						Notification:combatToPlayer(
							self.playerID,
							{
								message = "notify_artifact_ability_" .. C,
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility()
									:GetAbilityName(),
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
							}
						)
						PlayerData:getplayerData(self.playerID)
							:addArtifactAbilities(self:GetAbility():entindex(), B, z == #A - 1)
						z = z + 1
					end
				end
			end
		end
	end
end
function q.prototype.EDeclareFunctions(self)
	return { EOMModifierFunction.EOM_MODIFIER_PROPERTY_CUSTOM_SHOP_REFRESH_LIST }
end
function q.prototype.EOM_GetModifierCustomShopRefreshList(self, r)
	local s = self:GetParent()
	local x = s:GetPlayerOwnerID()
	local D = PlayerData:getplayerData(x)
	local u = D and D.heroName
	local E = r.excludelist
	local v = AbilityShop:GetRecommendSectByHeroName(u)
	if v == "sect_none" then
		return
	end
	local F = {}
	F = AbilityShop:getRandomAbility(x, self.count, { excludedAbility = E, specifySect = self.recommendSects })
	local A = {}
	do
		local z = 0
		while z < #F do
			A[#A + 1] = { aid = F[z + 1].aid, gold = KeyValues.AbilityUpgradesKvs[F[z + 1].aid].cost, type = "trait" }
			z = z + 1
		end
	end
	return A
end
q = e(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	q
)
i.modifier_trait_33 = q
return i