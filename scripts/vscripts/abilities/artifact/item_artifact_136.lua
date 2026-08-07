--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_136"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArraySlice
local g = b.__TS__ArrayIncludes
local h = b.__TS__StringSplit
local i = b.__TS__ArraySome
local j = b.__TS__ObjectKeys
local k = b.__TS__ArrayFilter
local l = b.__TS__SourceMapTraceBack
l(
	debug.getinfo(1).short_src,
	{
		["14"] = 1,
		["15"] = 1,
		["16"] = 1,
		["17"] = 2,
		["18"] = 2,
		["19"] = 2,
		["20"] = 4,
		["21"] = 5,
		["22"] = 4,
		["23"] = 5,
		["24"] = 6,
		["25"] = 7,
		["26"] = 6,
		["27"] = 5,
		["28"] = 4,
		["29"] = 5,
		["31"] = 5,
		["32"] = 11,
		["33"] = 19,
		["34"] = 11,
		["35"] = 19,
		["36"] = 22,
		["37"] = 23,
		["38"] = 22,
		["39"] = 26,
		["40"] = 27,
		["41"] = 26,
		["42"] = 32,
		["43"] = 33,
		["46"] = 34,
		["47"] = 35,
		["50"] = 36,
		["53"] = 37,
		["54"] = 38,
		["57"] = 39,
		["58"] = 40,
		["59"] = 41,
		["62"] = 42,
		["63"] = 43,
		["64"] = 44,
		["65"] = 44,
		["66"] = 45,
		["67"] = 45,
		["69"] = 46,
		["70"] = 46,
		["71"] = 46,
		["72"] = 47,
		["73"] = 48,
		["74"] = 48,
		["76"] = 49,
		["77"] = 49,
		["78"] = 49,
		["79"] = 49,
		["80"] = 49,
		["82"] = 50,
		["83"] = 51,
		["84"] = 46,
		["85"] = 46,
		["86"] = 53,
		["89"] = 54,
		["90"] = 55,
		["91"] = 56,
		["92"] = 57,
		["95"] = 58,
		["96"] = 59,
		["97"] = 59,
		["98"] = 59,
		["99"] = 59,
		["100"] = 59,
		["101"] = 60,
		["102"] = 60,
		["103"] = 60,
		["104"] = 60,
		["105"] = 60,
		["106"] = 60,
		["107"] = 60,
		["108"] = 60,
		["109"] = 32,
		["110"] = 19,
		["111"] = 11,
		["112"] = 11,
		["113"] = 11,
		["114"] = 11,
		["115"] = 11,
		["116"] = 11,
		["117"] = 11,
		["118"] = 11,
		["119"] = 19,
		["121"] = 19,
	}
)
local m = {}
local n = require("lib.dota_ts_adapter")
local o = n.BaseItem
local p = n.registerAbility
local q = require("modifiers.eom_modifier")
local r = q.EOMModifier
local s = q.registerEOMModifier
m.item_artifact_136 = c()
local t = m.item_artifact_136
t.name = "item_artifact_136"
d(t, o)
function t.prototype.GetIntrinsicModifierName(self)
	return "modifier_item_artifact_136"
end
t = e({ p(nil) }, t)
m.item_artifact_136 = t
m.modifier_item_artifact_136 = c()
local u = m.modifier_item_artifact_136
u.name = "modifier_item_artifact_136"
d(u, r)
function u.prototype.GetAbilitySpecialValue(self)
	self.chance = self:GetAbilitySpecialValueFor("chance")
end
function u.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 } }
end
function u.prototype.OnBattleEnd(self, v)
	if v.isNeutral or v.illusionPlayerID then
		return
	end
	local w = self:GetParent():GetPlayerOwnerID()
	if v.winPlayerID ~= w or v.illusionPlayerID == w then
		return
	end
	if not RollPercentage(self.chance) then
		return
	end
	local x = v.losePlayerID ~= nil and v.losePlayerID or v.illusionPlayerID
	if x == nil then
		return
	end
	local y = PlayerData:getHero(w)
	local z = PlayerData:getHero(x)
	if not y or not z then
		return
	end
	local A = y:getAbilityUpgradeData()
	local B = f(AbilityShop.banList)
	local C = PlayerData:getplayerData(w)
	local D = C and C.bannedSect
	if D then
		B[#B + 1] = D
	end
	local E = k(j(z:getAbilityUpgradeData()), function(F, G)
		local H = KeyValues.AbilityUpgradesKvs[G]
		if not H then
			return false
		end
		if i(h(H.sect, "|"), function(F, I)
			return g(B, I)
		end) then
			return false
		end
		local J = SECT_ABILITY_LEVEL[H.rarity]
		return A[G] == nil or A[G].level < J
	end)
	if #E == 0 then
		return
	end
	local G = GetRandomElement(E)
	local K = PlayerData:getplayerData(w)
	local L = self:GetAbility()
	if not G or not K or not L then
		return
	end
	y:learnAbility(G, true)
	K:addArtifactAbilities(L:entindex(), G, true)
	Notification:combatToPlayer(
		w,
		{
			message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[G].rarity),
			string_itemname_artifact = "DOTA_Tooltip_ability_" .. L:GetAbilityName(),
			string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. G,
		}
	)
end
u = e(
	{
		s(
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
	u
)
m.modifier_item_artifact_136 = u
return m