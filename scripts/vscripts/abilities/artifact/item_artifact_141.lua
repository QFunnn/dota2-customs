--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_141"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__StringSplit
local i = b.__TS__ArrayFilter
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 4,
		["19"] = 5,
		["20"] = 4,
		["21"] = 5,
		["22"] = 5,
		["23"] = 5,
		["24"] = 5,
		["25"] = 5,
		["26"] = 4,
		["27"] = 5,
		["29"] = 5,
		["30"] = 7,
		["31"] = 8,
		["32"] = 7,
		["33"] = 8,
		["34"] = 10,
		["35"] = 11,
		["36"] = 10,
		["37"] = 13,
		["38"] = 14,
		["39"] = 13,
		["40"] = 18,
		["41"] = 19,
		["42"] = 20,
		["45"] = 23,
		["46"] = 24,
		["49"] = 25,
		["50"] = 26,
		["51"] = 27,
		["54"] = 30,
		["55"] = 31,
		["56"] = 32,
		["57"] = 32,
		["58"] = 33,
		["59"] = 33,
		["61"] = 34,
		["62"] = 34,
		["63"] = 34,
		["64"] = 34,
		["65"] = 35,
		["66"] = 36,
		["67"] = 37,
		["68"] = 38,
		["71"] = 41,
		["72"] = 42,
		["73"] = 43,
		["74"] = 44,
		["75"] = 45,
		["76"] = 45,
		["77"] = 45,
		["78"] = 45,
		["79"] = 45,
		["80"] = 45,
		["81"] = 45,
		["82"] = 45,
		["85"] = 52,
		["86"] = 53,
		["87"] = 53,
		["88"] = 53,
		["89"] = 53,
		["90"] = 53,
		["91"] = 53,
		["92"] = 53,
		["93"] = 53,
		["94"] = 58,
		["95"] = 59,
		["96"] = 59,
		["97"] = 59,
		["98"] = 59,
		["99"] = 59,
		["100"] = 59,
		["101"] = 59,
		["102"] = 59,
		["103"] = 64,
		["104"] = 64,
		["105"] = 64,
		["106"] = 64,
		["107"] = 64,
		["108"] = 18,
		["109"] = 8,
		["110"] = 7,
		["111"] = 7,
		["112"] = 7,
		["113"] = 7,
		["114"] = 7,
		["115"] = 7,
		["116"] = 7,
		["117"] = 7,
		["118"] = 8,
		["120"] = 8,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseItem
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.item_artifact_141 = c()
local r = k.item_artifact_141
r.name = "item_artifact_141"
d(r, m)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_141"
end
r = e({ n(nil) }, r)
k.item_artifact_141 = r
k.modifier_item_artifact_141 = c()
local s = k.modifier_item_artifact_141
s.name = "modifier_item_artifact_141"
d(s, p)
function s.prototype.GetAbilitySpecialValue(self)
	self.gold = self:GetAbilitySpecialValueFor("gold")
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function s.prototype.OnBattleEnd(self, t)
	local u = self:GetParent():GetPlayerOwnerID()
	if t.isNeutral or t.illusionPlayerID or t.losePlayerID ~= u or t.winPlayerID == nil then
		return
	end
	local v = self:GetAbility()
	if not v then
		return
	end
	local w = PlayerData:getHero(t.winPlayerID)
	local x = PlayerData:getHero(u)
	if not w or not x then
		return
	end
	local y = AbilityShop:GetRecommendSectByHeroName(w.unitName)
	local z = f(AbilityShop.banList)
	local A = PlayerData:getplayerData(u)
	local B = A and A.bannedSect
	if B then
		z[#z + 1] = B
	end
	local C = i(y and y ~= "sect_none" and h(y, "|") or AbilityShop.pickList, function(D, E)
		return not g(z, E)
	end)
	local F = {}
	for G, H in pairs(KeyValues.AbilityUpgradesKvs) do
		if H.type == "inhibit" and g(C, H.sect) then
			F[#F + 1] = G
		end
	end
	local I = GetRandomElement(F)
	if not I or x:getAbilityUpgradeLevel(I) >= 5 then
		local J = 100
		PlayerData:modifyGold(u, J)
		Notification:combatToPlayer(
			u,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(),
				int_gold = J,
			}
		)
		return
	end
	PlayerData:modifyGold(t.winPlayerID, self.gold)
	Notification:combatToPlayer(
		t.winPlayerID,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(),
			int_gold = self.gold,
		}
	)
	x:learnAbility(I, true)
	Notification:combatToPlayer(
		u,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[I].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. I,
		}
	)
	PlayerData:getplayerData(u):addArtifactAbilities(v:entindex(), I, true)
end
s = e(
	{
		q(
			a,
			{
				IsHidden = true,
				IsDebuff = false,
				IsPurgable = false,
				IsPurgeException = false,
				AllowIllusionDuplicate = false,
				GetPriority = MODIFIER_PRIORITY_LOW,
			}
		),
	},
	s
)
k.modifier_item_artifact_141 = s
return k