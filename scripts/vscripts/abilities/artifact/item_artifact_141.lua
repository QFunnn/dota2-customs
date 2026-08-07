--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
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
		["51"] = 26,
		["52"] = 26,
		["53"] = 26,
		["54"] = 26,
		["55"] = 26,
		["56"] = 26,
		["57"] = 26,
		["58"] = 31,
		["59"] = 32,
		["60"] = 33,
		["63"] = 36,
		["64"] = 37,
		["65"] = 38,
		["66"] = 38,
		["67"] = 39,
		["68"] = 39,
		["70"] = 40,
		["71"] = 40,
		["72"] = 40,
		["73"] = 40,
		["74"] = 41,
		["75"] = 42,
		["76"] = 43,
		["77"] = 44,
		["80"] = 47,
		["81"] = 48,
		["82"] = 49,
		["83"] = 50,
		["84"] = 50,
		["85"] = 50,
		["86"] = 50,
		["87"] = 50,
		["88"] = 50,
		["89"] = 50,
		["90"] = 50,
		["93"] = 57,
		["94"] = 58,
		["95"] = 58,
		["96"] = 58,
		["97"] = 58,
		["98"] = 58,
		["99"] = 58,
		["100"] = 58,
		["101"] = 58,
		["102"] = 63,
		["103"] = 63,
		["104"] = 63,
		["105"] = 63,
		["106"] = 63,
		["107"] = 18,
		["108"] = 8,
		["109"] = 7,
		["110"] = 7,
		["111"] = 7,
		["112"] = 7,
		["113"] = 7,
		["114"] = 7,
		["115"] = 7,
		["116"] = 7,
		["117"] = 8,
		["119"] = 8,
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
	PlayerData:modifyGold(t.winPlayerID, self.gold)
	Notification:combatToPlayer(
		t.winPlayerID,
		{
			message = "notify_bonus_gold",
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(),
			int_gold = self.gold,
		}
	)
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
		PlayerData:modifyGold(u, self.gold)
		Notification:combatToPlayer(
			u,
			{
				message = "notify_bonus_gold",
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. v:GetAbilityName(),
				int_gold = self.gold,
			}
		)
		return
	end
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