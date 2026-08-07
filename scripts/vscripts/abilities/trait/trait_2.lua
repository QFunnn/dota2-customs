--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_2"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__StringSplit
local g = b.__TS__ArraySome
local h = b.__TS__Delete
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 1,
		["12"] = 1,
		["13"] = 1,
		["14"] = 2,
		["15"] = 2,
		["16"] = 2,
		["17"] = 5,
		["18"] = 6,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["22"] = 8,
		["23"] = 7,
		["24"] = 6,
		["25"] = 5,
		["26"] = 6,
		["28"] = 6,
		["29"] = 12,
		["30"] = 19,
		["31"] = 12,
		["32"] = 19,
		["33"] = 22,
		["34"] = 23,
		["35"] = 22,
		["36"] = 25,
		["37"] = 26,
		["38"] = 27,
		["39"] = 28,
		["40"] = 29,
		["41"] = 30,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["46"] = 35,
		["48"] = 37,
		["49"] = 39,
		["50"] = 40,
		["51"] = 40,
		["52"] = 40,
		["53"] = 40,
		["54"] = 41,
		["55"] = 42,
		["56"] = 42,
		["57"] = 42,
		["58"] = 42,
		["59"] = 42,
		["60"] = 42,
		["61"] = 42,
		["62"] = 42,
		["63"] = 47,
		["64"] = 47,
		["65"] = 47,
		["66"] = 47,
		["67"] = 47,
		["68"] = 48,
		["69"] = 48,
		["70"] = 48,
		["71"] = 48,
		["72"] = 48,
		["76"] = 25,
		["77"] = 53,
		["78"] = 54,
		["79"] = 53,
		["80"] = 58,
		["81"] = 59,
		["82"] = 60,
		["83"] = 61,
		["84"] = 62,
		["85"] = 63,
		["86"] = 64,
		["87"] = 65,
		["88"] = 66,
		["89"] = 67,
		["90"] = 67,
		["91"] = 67,
		["92"] = 67,
		["93"] = 68,
		["94"] = 69,
		["95"] = 70,
		["96"] = 72,
		["97"] = 75,
		["100"] = 78,
		["101"] = 79,
		["102"] = 80,
		["103"] = 81,
		["104"] = 82,
		["105"] = 83,
		["106"] = 84,
		["107"] = 84,
		["108"] = 84,
		["109"] = 84,
		["110"] = 84,
		["111"] = 84,
		["112"] = 84,
		["113"] = 84,
		["114"] = 89,
		["115"] = 89,
		["116"] = 89,
		["117"] = 89,
		["118"] = 89,
		["122"] = 93,
		["126"] = 58,
		["127"] = 19,
		["128"] = 12,
		["129"] = 12,
		["130"] = 12,
		["131"] = 12,
		["132"] = 12,
		["133"] = 12,
		["134"] = 12,
		["135"] = 19,
		["137"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_2 = c()
local q = j.trait_2
q.name = "trait_2"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_2"
end
q = e({ m(nil) }, q)
j.trait_2 = q
j.modifier_trait_2 = c()
local r = j.modifier_trait_2
r.name = "modifier_trait_2"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function r.prototype.OnCreated(self, s)
	if IsServer() then
		local t = self:GetParent():GetPlayerOwnerID()
		local u = PlayerData:getHero(t)
		local v = AbilityShop:GetRecommendSectByHeroName(u.unitName)
		local w = PlayerData:getplayerData(t)
		local x
		if v ~= "sect_none" then
			x = f(v, "|")
		else
			x = PickList(AbilityShop.pickList, 1, false)
		end
		self.recommendSect = x[RandomInt(0, #x - 1) + 1]
		for y, z in pairs(KeyValues.AbilityUpgradesKvs) do
			if
				z.rarity == "n"
				and (string.find(z.sect, "|", nil, true) or 0) - 1 == -1
				and self.recommendSect == z.sect
				and g(AbilityShop.pickList, function(A, B)
					return (string.find(z.sect, B, nil, true) or 0) - 1 ~= -1
				end)
			then
				PlayerData:getHero(t):learnAbility(y, true)
				Notification:combatToPlayer(
					t,
					{
						message = "notify_artifact_ability_" .. tostring(z.rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbility():GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
					}
				)
				PlayerData:getplayerData(t):addArtifactAbilities(self:GetAbility():entindex(), y, true)
				w:modifyArtifactExtraStringData(
					self:GetAbility():entindex(),
					"DOTA_Tooltip_ability_trait_recommendsect_effect",
					"#DOTA_Tooltip_ability_" .. self.recommendSect
				)
			end
		end
	end
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function r.prototype.OnRoundStart(self, s)
	if self.round > 0 then
		self.round = self.round - 1
		local t = self:GetParent():GetPlayerOwnerID()
		local w = PlayerData:getplayerData(t)
		local C = { self.recommendSect }
		local D = false
		while not D do
			if #C > 0 then
				local E = table.remove(C, RandomInt(1, #C))
				local F = AbilityShop:getAbilityPoolNew("n", E, nil, false)
				local G = w.hero:getAbilityUpgradeData()
				for y, z in pairs(F.tList) do
					if
						(string.find(KeyValues.AbilityUpgradesKvs[y].sect, "|", nil, true) or 0) - 1 ~= -1
						or G[y] ~= nil and G[y].level >= SECT_ABILITY_LEVEL[KeyValues.AbilityUpgradesKvs[y].rarity]
					then
						h(F.tList, y)
					end
				end
				F:update()
				if F:count() > 0 then
					local H = F:random()
					if H then
						D = true
						PlayerData:getHero(t):learnAbility(H, true)
						Notification:combatToPlayer(
							t,
							{
								message = "notify_artifact_ability_"
									.. tostring(KeyValues.AbilityUpgradesKvs[H].rarity),
								string_itemname_artifact = "DOTA_Tooltip_ability_trait_2",
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. H,
							}
						)
						PlayerData:getplayerData(t):addArtifactAbilities(self:GetAbility():entindex(), H, true)
					end
				end
			else
				D = true
			end
		end
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_2 = r
return j