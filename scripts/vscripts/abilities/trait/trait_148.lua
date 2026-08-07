--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_148"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringSplit
local f = b.__TS__ArrayForEach
local g = b.__TS__DecorateLegacy
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
		["23"] = 10,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 17,
		["31"] = 18,
		["32"] = 19,
		["33"] = 20,
		["34"] = 20,
		["35"] = 20,
		["36"] = 21,
		["38"] = 21,
		["40"] = 21,
		["41"] = 22,
		["42"] = 23,
		["43"] = 23,
		["44"] = 23,
		["45"] = 24,
		["46"] = 23,
		["47"] = 23,
		["49"] = 20,
		["50"] = 20,
		["52"] = 29,
		["53"] = 29,
		["54"] = 29,
		["55"] = 30,
		["58"] = 33,
		["59"] = 34,
		["60"] = 35,
		["61"] = 36,
		["63"] = 29,
		["64"] = 29,
		["65"] = 39,
		["66"] = 40,
		["67"] = 40,
		["68"] = 40,
		["69"] = 41,
		["70"] = 42,
		["72"] = 40,
		["73"] = 40,
		["75"] = 46,
		["76"] = 46,
		["77"] = 46,
		["78"] = 49,
		["79"] = 50,
		["80"] = 51,
		["81"] = 46,
		["82"] = 46,
		["84"] = 10,
		["85"] = 6,
		["86"] = 5,
		["87"] = 6,
		["89"] = 6,
		["90"] = 57,
		["91"] = 64,
		["92"] = 57,
		["93"] = 64,
		["95"] = 64,
		["96"] = 67,
		["97"] = 57,
		["98"] = 68,
		["99"] = 69,
		["100"] = 68,
		["101"] = 72,
		["102"] = 73,
		["103"] = 74,
		["105"] = 72,
		["106"] = 78,
		["107"] = 79,
		["108"] = 78,
		["109"] = 82,
		["110"] = 83,
		["111"] = 82,
		["112"] = 88,
		["113"] = 89,
		["116"] = 90,
		["119"] = 91,
		["120"] = 92,
		["121"] = 93,
		["122"] = 94,
		["123"] = 95,
		["124"] = 96,
		["125"] = 97,
		["126"] = 98,
		["127"] = 99,
		["128"] = 100,
		["129"] = 101,
		["130"] = 101,
		["131"] = 101,
		["132"] = 102,
		["133"] = 101,
		["134"] = 101,
		["136"] = 105,
		["137"] = 106,
		["140"] = 112,
		["141"] = 113,
		["142"] = 118,
		["143"] = 118,
		["144"] = 118,
		["145"] = 118,
		["146"] = 118,
		["148"] = 88,
		["149"] = 64,
		["150"] = 57,
		["151"] = 57,
		["152"] = 57,
		["153"] = 57,
		["154"] = 57,
		["155"] = 57,
		["156"] = 57,
		["157"] = 64,
		["159"] = 64,
	}
)
local i = {}
local j = require("lib.dota_ts_adapter")
local k = j.BaseAbility
local l = j.registerAbility
local m = require("modifiers.eom_modifier")
local n = m.EOMModifier
local o = m.registerEOMModifier
i.trait_148 = c()
local p = i.trait_148
p.name = "trait_148"
d(p, k)
function p.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_148"
end
function p.prototype.Spawn(self)
	if IsServer() then
		local q = self:GetCaster()
		local r = q:GetPlayerOwnerID()
		local s = {}
		local t = PlayerData:getplayerData(r)
		local u = t and t.bannedSect and { t.bannedSect } or nil
		local v = {}
		if CityEffect:getCityEffect() == "city_38" then
			local w = CityEffect.player_extra_ability_data[r] or {}
			f(w, function(x, y)
				local z = KeyValues.AbilityUpgradesKvs[y]
				if z ~= nil then
					z = z.sect
				end
				local A = z
				if type(A) == "string" then
					f(e(A, "|"), function(x, B)
						v[B] = true
					end)
				end
			end)
		end
		f(AbilityShop.pickList, function(x, A)
			if v[A] then
				return
			end
			local C = AbilityShop:GetSectLegendCard(A) ~= ""
			local D = AbilityShop:getAbilityPoolNew("sr", A, u, false):count() > 0
			if C or D then
				s[#s + 1] = A
			end
		end)
		if #s <= 0 then
			f(AbilityShop.pickList, function(x, A)
				if not v[A] then
					s[#s + 1] = A
				end
			end)
		end
		PlayerData:requestSectSelection(r, { sects = s, ability_name = "trait_148" }, function(x, r, A)
			local E = q:FindModifierByName("modifier_trait_148")
			E:SetSelectSect(A)
		end)
	end
end
p = g({ l(nil) }, p)
i.trait_148 = p
i.modifier_trait_148 = c()
local F = i.modifier_trait_148
F.name = "modifier_trait_148"
d(F, n)
function F.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.has_trigger = false
end
function F.prototype.GetAbilitySpecialValue(self)
	self.wait_round = self:GetAbilitySpecialValueFor("wait_round")
end
function F.prototype.OnCreated(self, G)
	if IsServer() then
		self:SetStackCount(self.wait_round)
	end
end
function F.prototype.SetSelectSect(self, A)
	self.sect = A
end
function F.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function F.prototype.OnRoundStart(self, G)
	if self.has_trigger then
		return
	end
	if self.sect == nil then
		return
	end
	self:DecrementStackCount()
	if self:GetStackCount() <= 0 then
		self.has_trigger = true
		local q = self:GetCaster()
		local r = q:GetPlayerOwnerID()
		local t = PlayerData:getplayerData(r)
		local H = t.hero
		local I = AbilityShop:GetSectLegendCard(self.sect)
		if I == "" then
			local J = AbilityShop:getRandomAbility(
				r,
				1,
				{ specifySect = { self.sect }, specifyRarity = "sr", specifyRarityIgnoreRule = true }
			)
			f(J, function(x, K, L)
				I = K.aid
			end)
		end
		if I == "" then
			Notification:combatToPlayer(
				r,
				{ message = "notify_learn_ability_sr_failure", string_itemname_artifact = "DOTA_Tooltip_ability_trait_148" }
			)
			return
		end
		H:learnAbility(I, true)
		Notification:combatToPlayer(
			r,
			{
				message = "notify_artifact_ability_sr",
				string_itemname_artifact = "DOTA_Tooltip_ability_trait_148",
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. I,
			}
		)
		PlayerData:getplayerData(r):addArtifactAbilities(self:GetAbility():entindex(), I, true)
	end
end
F = g(
	{ o(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	F
)
i.modifier_trait_148 = F
return i