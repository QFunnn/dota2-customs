--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_51"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayForEach
local f = b.__TS__StringSplit
local g = b.__TS__ArrayIncludes
local h = b.__TS__ArraySome
local i = b.__TS__New
local j = b.__TS__DecorateLegacy
local k = b.__TS__SourceMapTraceBack
k(
	debug.getinfo(1).short_src,
	{
		["13"] = 1,
		["14"] = 1,
		["15"] = 2,
		["16"] = 2,
		["17"] = 2,
		["18"] = 4,
		["19"] = 5,
		["20"] = 4,
		["21"] = 5,
		["22"] = 7,
		["23"] = 8,
		["24"] = 9,
		["26"] = 7,
		["27"] = 13,
		["28"] = 14,
		["29"] = 15,
		["30"] = 16,
		["31"] = 16,
		["32"] = 16,
		["33"] = 16,
		["34"] = 17,
		["35"] = 18,
		["36"] = 19,
		["37"] = 20,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 21,
		["43"] = 22,
		["44"] = 22,
		["45"] = 23,
		["46"] = 24,
		["47"] = 25,
		["48"] = 27,
		["49"] = 27,
		["50"] = 27,
		["51"] = 27,
		["52"] = 22,
		["57"] = 13,
		["58"] = 37,
		["59"] = 38,
		["60"] = 39,
		["61"] = 40,
		["62"] = 41,
		["63"] = 42,
		["64"] = 42,
		["65"] = 42,
		["66"] = 43,
		["67"] = 42,
		["68"] = 42,
		["69"] = 45,
		["70"] = 46,
		["72"] = 48,
		["73"] = 49,
		["74"] = 50,
		["75"] = 51,
		["76"] = 52,
		["77"] = 52,
		["78"] = 52,
		["79"] = 52,
		["80"] = 53,
		["85"] = 58,
		["86"] = 37,
		["87"] = 61,
		["88"] = 62,
		["89"] = 62,
		["90"] = 62,
		["91"] = 62,
		["92"] = 63,
		["93"] = 64,
		["94"] = 65,
		["96"] = 67,
		["97"] = 68,
		["98"] = 69,
		["100"] = 71,
		["101"] = 61,
		["102"] = 73,
		["103"] = 74,
		["104"] = 73,
		["105"] = 5,
		["106"] = 4,
		["107"] = 5,
		["109"] = 5,
	}
)
local l = {}
local m = require("class.weight_pool")
local n = m.CWeightPool
local o = require("lib.dota_ts_adapter")
local p = o.BaseItem
local q = o.registerAbility
l.item_artifact_51 = c()
local r = l.item_artifact_51
r.name = "item_artifact_51"
d(r, p)
function r.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("initial_charge"))
	end
end
function r.prototype.OnSpellStart(self)
	local s = self:GetCaster()
	if IsValid(s) then
		local t = CustomNetTables:GetTableValue("player_data", tostring(s:GetPlayerOwnerID())).gold
		local u = self:GetSpecialValueFor("cost_gold")
		local v = self:GetSpecialValueFor("count")
		if t >= u then
			self:SpendCharge()
			PlayerData:modifyGold(s:GetPlayerOwnerID(), -u)
			do
				local w = 0
				while w < v do
					local x = self:getLegendPool(s:GetPlayerOwnerID())
					local y = x:random()
					PlayerData:getHero(s:GetPlayerOwnerID()):learnAbility(y, true)
					Notification:combatToPlayer(
						s:GetPlayerOwnerID(),
						{
							message = "notify_artifact_ability_sr",
							string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_51",
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. y,
						}
					)
					w = w + 1
				end
			end
		end
	end
end
function r.prototype.getLegendPool(self, z)
	local A = PlayerData:getHero(z)
	local B = PlayerData:getplayerData(z)
	local C = {}
	local D = {}
	e(AbilityShop.banList, function(E, F)
		D[#D + 1] = F
	end)
	if B.bannedSect then
		D[#D + 1] = B.bannedSect
	end
	for G, H in pairs(KeyValues.AbilityUpgradesKvs) do
		if H.rarity ~= nil and H.rarity == "sr" then
			if A:getAbilityUpgradeLevel(G) < SECT_ABILITY_LEVEL.sr then
				local I = f(H.sect, "|")
				if not h(I, function(E, J)
					return g(D, J)
				end) then
					C[G] = 1
				end
			end
		end
	end
	return i(n, C)
end
function r.prototype.CastFilterResult(self)
	local t = CustomNetTables:GetTableValue("player_data", tostring(self:GetCaster():GetPlayerOwnerID())).gold
	if t < self:GetSpecialValueFor("cost_gold") then
		self.error = "金币不足"
		return UF_FAIL_CUSTOM
	end
	if self:GetCurrentCharges() == 0 then
		self.error = "没有使用次数"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function r.prototype.GetCustomCastError(self)
	return self.error
end
r = j({ q(nil) }, r)
l.item_artifact_51 = r
return l