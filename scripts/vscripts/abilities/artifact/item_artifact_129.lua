--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_129"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
local f = b.__TS__ArraySplice
local g = b.__TS__ArrayIncludes
local h = b.__TS__ObjectKeys
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
		["20"] = 5,
		["21"] = 6,
		["22"] = 7,
		["24"] = 5,
		["25"] = 10,
		["26"] = 11,
		["27"] = 12,
		["28"] = 13,
		["29"] = 13,
		["30"] = 13,
		["31"] = 13,
		["32"] = 14,
		["33"] = 14,
		["34"] = 14,
		["35"] = 15,
		["36"] = 16,
		["37"] = 18,
		["38"] = 18,
		["39"] = 18,
		["40"] = 19,
		["41"] = 20,
		["42"] = 21,
		["43"] = 22,
		["46"] = 25,
		["47"] = 26,
		["48"] = 27,
		["50"] = 28,
		["51"] = 28,
		["53"] = 29,
		["56"] = 30,
		["57"] = 31,
		["58"] = 32,
		["59"] = 34,
		["60"] = 34,
		["61"] = 34,
		["62"] = 34,
		["63"] = 34,
		["64"] = 35,
		["65"] = 35,
		["67"] = 36,
		["68"] = 37,
		["71"] = 28,
		["74"] = 39,
		["75"] = 40,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 41,
		["80"] = 41,
		["81"] = 41,
		["82"] = 41,
		["83"] = 41,
		["84"] = 46,
		["85"] = 46,
		["86"] = 46,
		["87"] = 46,
		["88"] = 46,
		["90"] = 14,
		["91"] = 14,
		["92"] = 10,
		["93"] = 50,
		["94"] = 51,
		["95"] = 52,
		["96"] = 53,
		["98"] = 55,
		["99"] = 50,
		["100"] = 57,
		["101"] = 58,
		["102"] = 57,
		["103"] = 4,
		["104"] = 3,
		["105"] = 4,
		["107"] = 4,
	}
)
local l = {}
local m = require("lib.dota_ts_adapter")
local n = m.BaseItem
local o = m.registerAbility
l.item_artifact_129 = c()
local p = l.item_artifact_129
p.name = "item_artifact_129"
d(p, n)
function p.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function p.prototype.OnSpellStart(self)
	local q = self:GetCaster():GetPlayerOwnerID()
	self:SpendCharge()
	local r = e(PlayerData:getAlivePlayerIDList(), function(s, t)
		return t ~= q
	end)
	i(r, function(s, u)
		local v = PlayerData:getHero(q):getAbilityUpgradeData()
		local w = {}
		for x, y in pairs(v) do
			local z
			z = y.level
			local A = KeyValues.AbilityUpgradesKvs[x]
			local B = SECT_ABILITY_LEVEL[A.rarity]
			if z >= B then
				w[#w + 1] = tostring(x)
			end
		end
		local C = q
		local D
		local E = #r
		do
			local F = 0
			while F < E do
				do
					if D ~= nil then
						break
					end
					local G = RandomInt(0, #r - 1)
					local H = r[G + 1]
					f(r, G, 1)
					local I = PlayerData:getHero(H)
					local J = e(h(I and I:getAbilityUpgradeData() or {}), function(s, K)
						return not g(w, K)
					end)
					if #J <= 0 then
						goto L
					end
					C = H
					D = GetRandomElement(J)
				end
				::L::
				F = F + 1
			end
		end
		if D ~= nil then
			PlayerData:getHero(q):learnAbility(D, true)
			Notification:combatToPlayer(
				q,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[D].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_129",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. D,
				}
			)
			PlayerData:getplayerData(q):addArtifactAbilities(self:entindex(), D, true)
		end
	end)
end
function p.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function p.prototype.GetCustomCastError(self)
	return self.error
end
p = j({ o(nil) }, p)
l.item_artifact_129 = p
return l