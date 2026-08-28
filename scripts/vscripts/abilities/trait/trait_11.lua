--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/trait/trait_11"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__ArrayFilter
local g = b.__TS__ArraySplice
local h = b.__TS__ArrayIncludes
local i = b.__TS__ObjectKeys
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
		["18"] = 5,
		["19"] = 6,
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["23"] = 8,
		["24"] = 7,
		["25"] = 6,
		["26"] = 5,
		["27"] = 6,
		["29"] = 6,
		["30"] = 12,
		["31"] = 19,
		["32"] = 12,
		["33"] = 19,
		["34"] = 21,
		["35"] = 22,
		["36"] = 21,
		["37"] = 24,
		["38"] = 25,
		["39"] = 26,
		["40"] = 27,
		["42"] = 24,
		["43"] = 30,
		["44"] = 31,
		["45"] = 30,
		["46"] = 35,
		["47"] = 36,
		["48"] = 37,
		["49"] = 35,
		["50"] = 39,
		["51"] = 40,
		["52"] = 41,
		["53"] = 42,
		["54"] = 42,
		["55"] = 42,
		["56"] = 42,
		["57"] = 43,
		["60"] = 44,
		["61"] = 45,
		["62"] = 47,
		["63"] = 47,
		["64"] = 47,
		["65"] = 48,
		["66"] = 49,
		["67"] = 50,
		["68"] = 51,
		["71"] = 54,
		["72"] = 55,
		["73"] = 56,
		["75"] = 57,
		["76"] = 57,
		["78"] = 58,
		["81"] = 59,
		["82"] = 60,
		["83"] = 61,
		["84"] = 63,
		["85"] = 63,
		["86"] = 63,
		["87"] = 63,
		["88"] = 63,
		["89"] = 64,
		["90"] = 64,
		["92"] = 65,
		["93"] = 66,
		["96"] = 57,
		["99"] = 68,
		["100"] = 69,
		["101"] = 70,
		["102"] = 71,
		["103"] = 71,
		["104"] = 71,
		["105"] = 71,
		["106"] = 71,
		["107"] = 71,
		["108"] = 71,
		["109"] = 71,
		["110"] = 76,
		["111"] = 76,
		["112"] = 76,
		["113"] = 76,
		["114"] = 76,
		["117"] = 39,
		["118"] = 19,
		["119"] = 12,
		["120"] = 12,
		["121"] = 12,
		["122"] = 12,
		["123"] = 12,
		["124"] = 12,
		["125"] = 12,
		["126"] = 19,
		["128"] = 19,
	}
)
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseAbility
local n = l.registerAbility
local o = require("modifiers.eom_modifier")
local p = o.EOMModifier
local q = o.registerEOMModifier
k.trait_11 = c()
local r = k.trait_11
r.name = "trait_11"
d(r, m)
function r.prototype.GetIntrinsicModifierName(self)
	return "modifier_trait_11"
end
r = e({ n(nil) }, r)
k.trait_11 = r
k.modifier_trait_11 = c()
local s = k.modifier_trait_11
s.name = "modifier_trait_11"
d(s, p)
function s.prototype.GetAbilitySpecialValue(self)
	self.round = self:GetAbilitySpecialValueFor("round")
end
function s.prototype.OnCreated(self, t)
	if IsServer() then
		self:SetStackCount(self.round)
		self:Effect()
	end
end
function s.prototype.EDeclareEvents(self)
	return { [EOMModifierEvents.MODIFIER_EVENT_ON_ROUND_START] = { -1, -1 } }
end
function s.prototype.OnRoundStart(self)
	self:IncrementStackCount()
	self:Effect()
end
function s.prototype.Effect(self)
	if self:GetStackCount() >= self.round then
		local u = self:GetParent():GetPlayerOwnerID()
		local v = f(PlayerData:getAlivePlayerIDList(), function(w, x)
			return x ~= u
		end)
		if #v == 0 then
			return
		end
		local y = PlayerData:getHero(u):getAbilityUpgradeData()
		local z = {}
		for A, B in pairs(y) do
			local C
			C = B.level
			local D = KeyValues.AbilityUpgradesKvs[A]
			local E = SECT_ABILITY_LEVEL[D.rarity]
			if C >= E then
				z[#z + 1] = tostring(A)
			end
		end
		local F
		local G
		local H = #v
		do
			local I = 0
			while I < H do
				do
					if G ~= nil then
						break
					end
					local J = RandomInt(0, #v - 1)
					local K = v[J + 1]
					g(v, J, 1)
					local L = PlayerData:getHero(K)
					local M = f(i(L and L:getAbilityUpgradeData() or {}), function(w, N)
						return not h(z, N)
					end)
					if #M <= 0 then
						goto O
					end
					F = K
					G = GetRandomElement(M)
				end
				::O::
				I = I + 1
			end
		end
		if G ~= nil then
			self:SetStackCount(0)
			PlayerData:getHero(u):learnAbility(G, true)
			Notification:combatToPlayer(
				u,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[G].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_trait_11",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. G,
				}
			)
			PlayerData:getplayerData(u):addArtifactAbilities(self:GetAbility():entindex(), G, true)
		end
	end
end
s = e(
	{ q(
		a,
		{ IsHidden = true, IsDebuff = false, IsPurgable = false, IsPurgeException = false, AllowIllusionDuplicate = false }
	) },
	s
)
k.modifier_trait_11 = s
return k