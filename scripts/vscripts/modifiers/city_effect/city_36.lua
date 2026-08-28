--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "modifiers/city_effect/city_36"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__DecorateLegacy
local g = b.__TS__ObjectKeys
local h = b.__TS__ArrayFilter
local i = b.__TS__SourceMapTraceBack
i(
	debug.getinfo(1).short_src,
	{
		["11"] = 3,
		["12"] = 3,
		["13"] = 3,
		["14"] = 4,
		["15"] = 4,
		["17"] = 7,
		["18"] = 15,
		["19"] = 7,
		["20"] = 15,
		["22"] = 15,
		["23"] = 17,
		["24"] = 18,
		["25"] = 7,
		["26"] = 19,
		["27"] = 20,
		["28"] = 21,
		["29"] = 22,
		["30"] = 23,
		["31"] = 24,
		["32"] = 25,
		["33"] = 26,
		["34"] = 26,
		["37"] = 21,
		["39"] = 19,
		["40"] = 32,
		["41"] = 33,
		["42"] = 34,
		["43"] = 34,
		["44"] = 34,
		["45"] = 35,
		["46"] = 36,
		["48"] = 34,
		["49"] = 34,
		["51"] = 32,
		["52"] = 15,
		["53"] = 7,
		["54"] = 7,
		["55"] = 7,
		["56"] = 7,
		["57"] = 7,
		["58"] = 7,
		["59"] = 7,
		["60"] = 7,
		["61"] = 15,
		["63"] = 15,
		["64"] = 43,
		["65"] = 51,
		["66"] = 43,
		["67"] = 51,
		["69"] = 51,
		["70"] = 53,
		["71"] = 43,
		["72"] = 58,
		["73"] = 59,
		["74"] = 58,
		["75"] = 62,
		["76"] = 63,
		["77"] = 62,
		["78"] = 70,
		["79"] = 71,
		["80"] = 72,
		["81"] = 73,
		["82"] = 74,
		["84"] = 75,
		["85"] = 75,
		["86"] = 76,
		["87"] = 77,
		["88"] = 77,
		["89"] = 77,
		["90"] = 78,
		["91"] = 79,
		["92"] = 80,
		["93"] = 81,
		["94"] = 82,
		["95"] = 83,
		["97"] = 85,
		["98"] = 86,
		["100"] = 88,
		["101"] = 77,
		["102"] = 77,
		["103"] = 92,
		["106"] = 93,
		["107"] = 94,
		["108"] = 95,
		["109"] = 96,
		["111"] = 98,
		["112"] = 75,
		["115"] = 100,
		["116"] = 70,
		["117"] = 103,
		["118"] = 104,
		["119"] = 105,
		["120"] = 106,
		["121"] = 107,
		["123"] = 108,
		["124"] = 108,
		["125"] = 109,
		["126"] = 110,
		["127"] = 110,
		["128"] = 111,
		["129"] = 112,
		["130"] = 113,
		["131"] = 114,
		["132"] = 115,
		["133"] = 116,
		["135"] = 118,
		["136"] = 119,
		["138"] = 121,
		["139"] = 110,
		["140"] = 110,
		["141"] = 125,
		["144"] = 126,
		["145"] = 127,
		["146"] = 128,
		["147"] = 129,
		["149"] = 131,
		["150"] = 108,
		["153"] = 133,
		["154"] = 133,
		["155"] = 133,
		["156"] = 133,
		["158"] = 103,
		["159"] = 137,
		["160"] = 138,
		["163"] = 139,
		["164"] = 140,
		["165"] = 141,
		["166"] = 142,
		["168"] = 137,
		["169"] = 146,
		["170"] = 149,
		["171"] = 150,
		["172"] = 151,
		["173"] = 151,
		["174"] = 151,
		["175"] = 152,
		["176"] = 153,
		["177"] = 153,
		["178"] = 153,
		["179"] = 153,
		["180"] = 153,
		["181"] = 153,
		["182"] = 153,
		["183"] = 153,
		["184"] = 158,
		["185"] = 151,
		["186"] = 151,
		["188"] = 161,
		["190"] = 146,
		["191"] = 51,
		["192"] = 43,
		["193"] = 43,
		["194"] = 43,
		["195"] = 43,
		["196"] = 43,
		["197"] = 43,
		["198"] = 43,
		["199"] = 43,
		["200"] = 51,
		["202"] = 51,
	}
)
local j = {}
local k = require("modifiers.eom_modifier")
local l = k.EOMModifier
local m = k.registerEOMModifier
local n = require("modifiers.city_effect.city_effect_modifier")
local o = n.CityEffectModifier
j.modifier_city_36 = c()
local p = j.modifier_city_36
p.name = "modifier_city_36"
d(p, o)
function p.prototype.____constructor(self, ...)
	o.prototype.____constructor(self, ...)
	self.modifierList = {}
	self.particleIDList = {}
end
function p.prototype.OnCreated(self, q)
	if IsServer() then
		PlayerData:eachPlayer(function(r, s)
			local t = PlayerResource:GetSelectedHeroEntity(s.playerID)
			if IsValid(t) then
				local u = t:AddNewModifier(t, nil, "modifier_city_36_buff", nil)
				if IsValid(u) then
					local v = self.modifierList
					v[#v + 1] = u
				end
			end
		end)
	end
end
function p.prototype.OnDestroy(self)
	if IsServer() then
		e(self.modifierList, function(r, w)
			if IsValid(w) then
				w:Destroy()
			end
		end)
	end
end
p = f(
	{
		m(
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
	p
)
j.modifier_city_36 = p
j.modifier_city_36_buff = c()
local x = j.modifier_city_36_buff
x.name = "modifier_city_36_buff"
d(x, l)
function x.prototype.____constructor(self, ...)
	l.prototype.____constructor(self, ...)
	self.neutralSectData = {}
end
function x.prototype.GetAbilitySpecialValue(self)
	self.count = CityEffect:GetSpecialValueFor("city_36", "count")
end
function x.prototype.EDeclareEvents(self)
	return {
		[EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_BATTLE_END] = { -1, -1 },
		[EOMModifierEvents.MODIFIER_EVENT_ON_CONFIRM_BATTLE] = { -1, -1 },
	}
end
function x.prototype.OnPlayerKilled(self, y)
	local z = self.parent:GetPlayerOwnerID()
	local A = PlayerData:getHero(z)
	local B = {}
	local C = {}
	do
		local D = 0
		while D < self.count do
			local E = PlayerData:getHero(z):getAbilityUpgradeData()
			local F = PlayerData:getHero(y.playerID)
			local G = h(g(F and F:getAbilityUpgradeData() or {}), function(r, H)
				local I = KeyValues.AbilityUpgradesKvs[H]
				local J = SECT_ABILITY_LEVEL[I.rarity]
				local K = 0
				if E[H] and E[H].level then
					K = E[H].level
				end
				if C[H] then
					K = K + C[H]
				end
				return K < J
			end)
			if #G <= 0 then
				break
			end
			local L = GetRandomElement(G)
			B[#B + 1] = L
			if C[L] == nil then
				C[L] = 0
			end
			C[L] = C[L] + 1
			D = D + 1
		end
	end
	self:GainAbility(B, A)
end
function x.prototype.OnBattleEnd(self, q)
	local z = self.parent:GetPlayerOwnerID()
	if (q.losePlayerID == z or q.winPlayerID == z) and q.isNeutral then
		local B = {}
		local C = {}
		do
			local D = 0
			while D < self.count do
				local E = PlayerData:getHero(z):getAbilityUpgradeData()
				local G = h(g(self.neutralSectData or {}), function(r, H)
					local I = KeyValues.AbilityUpgradesKvs[H]
					local J = SECT_ABILITY_LEVEL[I.rarity]
					local K = 0
					if E[H] and E[H].level then
						K = E[H].level
					end
					if C[H] then
						K = K + C[H]
					end
					return K < J
				end)
				if #G <= 0 then
					break
				end
				local L = GetRandomElement(G)
				B[#B + 1] = L
				if C[L] == nil then
					C[L] = 0
				end
				C[L] = C[L] + 1
				D = D + 1
			end
		end
		self:GainAbility(B, PlayerData:getHero(z))
	end
end
function x.prototype.OnConfirmBattle(self, q)
	if not q.isNeutral then
		return
	end
	local M = GameState:getState()
	local N = GameState:getStateName()
	if N == "GameState_ConfirmNeutral" or N == "GameState_Neutral" or N == "GameState_ConfirmRoshan" then
		self.neutralSectData = M and M.neutralSectData
	end
end
function x.prototype.GainAbility(self, B, A)
	local z = A.playerID
	if #B > 0 then
		e(B, function(r, O, P)
			A:learnAbility(O, true)
			Notification:combatToPlayer(
				z,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[O].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_city_36",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. O,
				}
			)
			CityEffect:addCityEffectAbilites(z, O, P == #B - 1)
		end)
	else
		Notification:combatToPlayer(
			z,
			{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_city_36" }
		)
	end
end
x = f(
	{
		m(
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
	x
)
j.modifier_city_36_buff = x
return j