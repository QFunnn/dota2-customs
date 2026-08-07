--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_142"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArraySlice
local f = b.__TS__ArrayIncludes
local g = b.__TS__ArrayFilter
local h = b.__TS__StringSplit
local i = b.__TS__ArrayForEach
local j = b.__TS__DecorateLegacy
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 1,
		["16"] = 3,
		["17"] = 4,
		["18"] = 3,
		["19"] = 4,
		["21"] = 4,
		["22"] = 5,
		["23"] = 3,
		["24"] = 6,
		["25"] = 6,
		["26"] = 6,
		["28"] = 6,
		["29"] = 7,
		["30"] = 8,
		["31"] = 9,
		["32"] = 10,
		["33"] = 10,
		["34"] = 11,
		["35"] = 11,
		["37"] = 12,
		["38"] = 12,
		["39"] = 12,
		["40"] = 12,
		["41"] = 13,
		["42"] = 14,
		["43"] = 14,
		["44"] = 14,
		["45"] = 14,
		["46"] = 14,
		["47"] = 14,
		["48"] = 14,
		["49"] = 15,
		["52"] = 16,
		["53"] = 16,
		["54"] = 16,
		["55"] = 16,
		["56"] = 16,
		["57"] = 16,
		["58"] = 16,
		["59"] = 16,
		["60"] = 16,
		["61"] = 16,
		["62"] = 17,
		["65"] = 18,
		["66"] = 19,
		["67"] = 16,
		["68"] = 16,
		["69"] = 14,
		["70"] = 14,
		["71"] = 7,
		["72"] = 23,
		["73"] = 24,
		["74"] = 25,
		["77"] = 26,
		["78"] = 27,
		["79"] = 28,
		["80"] = 29,
		["81"] = 30,
		["82"] = 31,
		["83"] = 31,
		["84"] = 31,
		["85"] = 31,
		["86"] = 32,
		["87"] = 33,
		["90"] = 36,
		["91"] = 37,
		["92"] = 38,
		["94"] = 39,
		["95"] = 39,
		["96"] = 40,
		["97"] = 41,
		["98"] = 42,
		["99"] = 43,
		["101"] = 39,
		["105"] = 47,
		["106"] = 47,
		["107"] = 47,
		["108"] = 48,
		["109"] = 48,
		["110"] = 48,
		["111"] = 48,
		["112"] = 48,
		["113"] = 48,
		["114"] = 48,
		["115"] = 48,
		["116"] = 53,
		["117"] = 53,
		["118"] = 53,
		["119"] = 53,
		["120"] = 53,
		["121"] = 47,
		["122"] = 47,
		["123"] = 55,
		["124"] = 23,
		["125"] = 57,
		["126"] = 58,
		["127"] = 59,
		["128"] = 60,
		["130"] = 62,
		["131"] = 63,
		["132"] = 64,
		["134"] = 66,
		["135"] = 57,
		["136"] = 68,
		["137"] = 68,
		["138"] = 68,
		["139"] = 4,
		["140"] = 3,
		["141"] = 4,
		["143"] = 4,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseItem
local o = m.registerAbility
l.item_artifact_142 = c()
local p = l.item_artifact_142
p.name = "item_artifact_142"
d(p, n)
function p.prototype.____constructor(self, ...)
	n.prototype.____constructor(self, ...)
	self.selecting = false
end
function p.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster():GetPlayerOwnerID()
	local r = e(AbilityShop.banList)
	local s = PlayerData:getplayerData(q)
	local t = s and s.bannedSect
	if t then
		r[#r + 1] = t
	end
	local u = g(AbilityShop.pickList, function(v, w)
		return not f(r, w)
	end)
	self.selecting = true
	PlayerData:requestSectSelection(q, { sects = u, ability_name = self:GetAbilityName() }, function(v, x, y)
		if not IsValid(self) then
			return
		end
		PlayerData:requestSectSelection(
			q,
			{ sects = g(u, function(v, w)
				return w ~= y
			end), ability_name = self:GetAbilityName() },
			function(v, z, A)
				if not IsValid(self) then
					return
				end
				self.selecting = false
				self:ReplaceSect(q, y, A)
			end
		)
	end)
end
function p.prototype.ReplaceSect(self, q, y, A)
	local B = PlayerData:getHero(q)
	if not B then
		return
	end
	local C = B:getAbilityUpgradeData()
	local D = {}
	local E = {}
	for F, G in pairs(C) do
		local H = KeyValues.AbilityUpgradesKvs[F]
		if H and f(h(H.sect, "|"), y) then
			D[F] = -G.level
			E[H.rarity] = (E[H.rarity] or 0) + G.level
		end
	end
	B:modifyAbilityUpgrade(D)
	local I = {}
	for J, K in pairs(E) do
		do
			local L = 0
			while L < K do
				local M = AbilityShop:getRandomAbility(
					q,
					1,
					{ specifySect = { A }, specifyRarity = J, specifyRarityIgnoreRule = true, isAbilityShop = false }
				)
				if #M > 0 then
					B:learnAbility(M[1].aid, true)
					I[#I + 1] = M[1].aid
				end
				L = L + 1
			end
		end
	end
	i(I, function(v, N, O)
		Notification:combatToPlayer(
			q,
			{
				message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[N].rarity),
				string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
				string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. N,
			}
		)
		PlayerData:getplayerData(q):addArtifactAbilities(self:entindex(), N, O == #I - 1)
	end)
	self:SpendCharge()
end
function p.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() <= 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	if self.selecting then
		self.error = "error_selection_in_progress"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function p.prototype.GetCustomCastError(self)
	return self.error
end
p = j({ o(nil) }, p)
l.item_artifact_142 = p
return l