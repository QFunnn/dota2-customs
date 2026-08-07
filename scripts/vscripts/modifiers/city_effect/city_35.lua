--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_35"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__SourceMapTraceBack
g(
	debug.getinfo(1).short_src,
	{
		["9"] = 1,
		["10"] = 1,
		["11"] = 1,
		["12"] = 2,
		["13"] = 2,
		["15"] = 5,
		["16"] = 13,
		["17"] = 5,
		["18"] = 13,
		["20"] = 13,
		["21"] = 14,
		["22"] = 15,
		["23"] = 5,
		["24"] = 16,
		["25"] = 17,
		["26"] = 18,
		["27"] = 19,
		["28"] = 20,
		["29"] = 21,
		["30"] = 22,
		["31"] = 23,
		["32"] = 23,
		["35"] = 18,
		["37"] = 16,
		["38"] = 29,
		["39"] = 30,
		["40"] = 31,
		["41"] = 31,
		["42"] = 31,
		["43"] = 32,
		["44"] = 33,
		["46"] = 31,
		["47"] = 31,
		["49"] = 29,
		["50"] = 13,
		["51"] = 5,
		["52"] = 5,
		["53"] = 5,
		["54"] = 5,
		["55"] = 5,
		["56"] = 5,
		["57"] = 5,
		["58"] = 5,
		["59"] = 13,
		["61"] = 13,
		["62"] = 40,
		["63"] = 48,
		["64"] = 40,
		["65"] = 48,
		["66"] = 51,
		["67"] = 52,
		["68"] = 53,
		["69"] = 51,
		["70"] = 56,
		["71"] = 57,
		["72"] = 56,
		["73"] = 63,
		["74"] = 64,
		["75"] = 65,
		["76"] = 66,
		["77"] = 67,
		["78"] = 68,
		["79"] = 69,
		["80"] = 70,
		["81"] = 71,
		["83"] = 69,
		["84"] = 74,
		["85"] = 75,
		["86"] = 76,
		["87"] = 77,
		["88"] = 78,
		["89"] = 78,
		["90"] = 79,
		["91"] = 80,
		["93"] = 81,
		["94"] = 81,
		["95"] = 82,
		["96"] = 83,
		["97"] = 81,
		["100"] = 89,
		["103"] = 92,
		["106"] = 63,
		["107"] = 48,
		["108"] = 40,
		["109"] = 40,
		["110"] = 40,
		["111"] = 40,
		["112"] = 40,
		["113"] = 40,
		["114"] = 40,
		["115"] = 40,
		["116"] = 48,
		["118"] = 48,
	}
)
local h = {}
local i = require("modifiers.eom_modifier")
local j = i.EOMModifier
local k = i.registerEOMModifier
local l = require("modifiers.city_effect.city_effect_modifier")
local m = l.CityEffectModifier
h.modifier_city_35 = c()
local n = h.modifier_city_35
n.name = "modifier_city_35"
d(n, m)
function n.prototype.____constructor(self, ...)
	m.prototype.____constructor(self, ...)
	self.modifierList = {}
	self.particleIDList = {}
end
function n.prototype.OnCreated(self, o)
	if IsServer() then
		PlayerData:eachPlayer(function(p, q)
			local r = PlayerResource:GetSelectedHeroEntity(q.playerID)
			if IsValid(r) then
				local s = r:AddNewModifier(r, nil, "modifier_city_35_buff", nil)
				if IsValid(s) then
					local t = self.modifierList
					t[#t + 1] = s
				end
			end
		end)
	end
end
function n.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(p, u)
			if IsValid(u) then
				u:Destroy()
			end
		end)
	end
end
n = f(
	{
		k(
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
	n
)
h.modifier_city_35 = n
h.modifier_city_35_buff = c()
local v = h.modifier_city_35_buff
v.name = "modifier_city_35_buff"
d(v, j)
function v.prototype.GetAbilitySpecialValue(self)
	self.round = CityEffect:GetSpecialValueFor("city_35", "round")
	self.level = CityEffect:GetSpecialValueFor("city_35", "level")
end
function v.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function v.prototype.OnRoundStart(self, o)
	if Rounds:getCurrentRound() % self.round == 0 then
		local w = self:GetParent():GetPlayerOwnerID()
		local x = PlayerData:getHero(w)
		local y = AbilityShop:getAbilityPoolNew("n", nil, nil, false)
		local z = x:getAbilityUpgradeData()
		y:each(function(p, A)
			if z[A] == nil or z[A].level > self.level then
				y:set(A, 0)
			end
		end)
		if #y.tName > 0 then
			local B = y:random()
			if B then
				local C = KeyValues.AbilityUpgradesKvs[B]
				local D = z[B]
				local E = D and D.level or 0
				local F = SECT_ABILITY_LEVEL[C.rarity]
				local G = F - E
				do
					local H = 0
					while H < G do
						x:learnAbility(B, true)
						Notification:combatToPlayer(
							w,
							{
								message = "notify_artifact_ability_n",
								string_itemname_artifact = "DOTA_Tooltip_ability_city_35",
								string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. B,
							}
						)
						H = H + 1
					end
				end
				CityEffect:addCityEffectAbilites(w, B, true)
			end
		else
			Notification:combatToPlayer(
				w,
				{ message = "notify_enemy_ability_self_none", string_itemname_artifact = "DOTA_Tooltip_ability_city_35" }
			)
		end
	end
end
v = f(
	{
		k(
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
	v
)
h.modifier_city_35_buff = v
return h