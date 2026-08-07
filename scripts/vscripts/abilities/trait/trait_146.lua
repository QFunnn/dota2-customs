--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_146"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ObjectKeys
local g = b.__TS__ArrayFilter
local h = b.__TS__ArrayForEach
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
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 23,
		["37"] = 28,
		["38"] = 29,
		["39"] = 28,
		["40"] = 34,
		["41"] = 35,
		["42"] = 36,
		["43"] = 37,
		["44"] = 38,
		["45"] = 39,
		["46"] = 40,
		["48"] = 42,
		["50"] = 43,
		["51"] = 44,
		["53"] = 45,
		["54"] = 45,
		["55"] = 46,
		["56"] = 47,
		["57"] = 47,
		["58"] = 47,
		["59"] = 48,
		["60"] = 49,
		["61"] = 50,
		["62"] = 51,
		["63"] = 52,
		["64"] = 53,
		["66"] = 55,
		["67"] = 56,
		["69"] = 58,
		["70"] = 47,
		["71"] = 47,
		["72"] = 62,
		["75"] = 63,
		["76"] = 64,
		["77"] = 64,
		["78"] = 64,
		["79"] = 64,
		["80"] = 64,
		["81"] = 64,
		["83"] = 66,
		["84"] = 67,
		["85"] = 75,
		["86"] = 76,
		["88"] = 78,
		["89"] = 45,
		["92"] = 80,
		["93"] = 81,
		["94"] = 82,
		["95"] = 82,
		["96"] = 82,
		["97"] = 83,
		["98"] = 84,
		["99"] = 84,
		["100"] = 84,
		["101"] = 84,
		["102"] = 84,
		["103"] = 84,
		["104"] = 84,
		["105"] = 84,
		["106"] = 89,
		["107"] = 89,
		["108"] = 89,
		["109"] = 89,
		["110"] = 89,
		["111"] = 82,
		["112"] = 82,
		["114"] = 92,
		["116"] = 34,
		["117"] = 19,
		["118"] = 12,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 19,
		["127"] = 19,
	}
)
local j = {}
local k = require("lib.dota_ts_adapter")
local l = k.BaseAbility
local m = k.registerAbility
local n = require("modifiers.eom_modifier")
local o = n.EOMModifier
local p = n.registerEOMModifier
j.trait_146 = c()
local q = j.trait_146
q.name = "trait_146"
d(q, l)
function q.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_146"
end
q = e({ m(nil) }, q)
j.trait_146 = q
j.modifier_trait_146 = c()
local r = j.modifier_trait_146
r.name = "modifier_trait_146"
d(r, o)
function r.prototype.GetAbilitySpecialValue(self)
	self.count = self:GetAbilitySpecialValueFor("count")
	self.first_count = self:GetAbilitySpecialValueFor("first_count")
end
function r.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_PLAYER_KILLED] = { -1, -1 } }
end
function r.prototype.OnPlayerKilled(self, s)
	local t = s.playerID
	local u = self:GetParent():GetPlayerOwnerID()
	local v = PlayerData:getHero(u)
	local w = PlayerData:getAlivePlayerCount()
	if w == 7 then
		self.realCount = self.first_count
	else
		self.realCount = self.count
	end
	local x = {}
	local y = {}
	do
		local z = 0
		while z < self.realCount do
			local A = PlayerData:getHero(u):getAbilityUpgradeData()
			local B = PlayerData:getHero(t)
			local C = g(f(B and B:getAbilityUpgradeData() or {}), function(D, E)
				local F = KeyValues.AbilityUpgradesKvs[E]
				local G = SECT_ABILITY_LEVEL[F.rarity]
				local H = 0
				if A[E] and A[E].level then
					H = A[E].level
				end
				if y[E] then
					H = H + y[E]
				end
				return H < G
			end)
			if #C <= 0 then
				break
			end
			if #C >= self.realCount then
				C = g(C, function(D, I)
					return y[I] == nil
				end)
			end
			local J = GetRandomElement(C)
			x[#x + 1] = J
			if y[J] == nil then
				y[J] = 0
			end
			y[J] = y[J] + 1
			z = z + 1
		end
	end
	local K = self:GetAbility():GetAbilityName()
	if #x > 0 then
		h(x, function(D, L, M)
			v:learnAbility(L, true)
			Notification:combatToPlayer(
				u,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[L].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. K,
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. L,
				}
			)
			PlayerData:getplayerData(u):addArtifactAbilities(self:GetAbility():entindex(), L, M == #x - 1)
		end)
	else
		Notification:combatToPlayer(
			u,
			{ message = "notify_enemy_ability_none", string_itemname_artifact = "DOTA_Tooltip_ability_" .. K }
		)
	end
end
r = e(
	{ p(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	r
)
j.modifier_trait_146 = r
return j