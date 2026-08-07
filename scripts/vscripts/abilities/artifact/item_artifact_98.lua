--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_98"
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
		["12"] = 3,
		["13"] = 4,
		["14"] = 3,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["20"] = 5,
		["21"] = 10,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["26"] = 15,
		["27"] = 15,
		["28"] = 15,
		["29"] = 17,
		["30"] = 18,
		["31"] = 19,
		["32"] = 20,
		["33"] = 21,
		["34"] = 22,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["39"] = 27,
		["40"] = 27,
		["41"] = 27,
		["42"] = 28,
		["43"] = 29,
		["44"] = 29,
		["45"] = 29,
		["46"] = 29,
		["47"] = 29,
		["48"] = 29,
		["49"] = 29,
		["50"] = 29,
		["51"] = 34,
		["52"] = 34,
		["53"] = 34,
		["54"] = 34,
		["55"] = 34,
		["56"] = 27,
		["57"] = 27,
		["60"] = 15,
		["61"] = 15,
		["62"] = 10,
		["63"] = 40,
		["64"] = 41,
		["65"] = 42,
		["66"] = 43,
		["68"] = 45,
		["69"] = 40,
		["70"] = 47,
		["71"] = 48,
		["72"] = 47,
		["73"] = 4,
		["74"] = 3,
		["75"] = 4,
		["77"] = 4,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
h.item_artifact_98 = c()
local l = h.item_artifact_98
l.name = "item_artifact_98"
d(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function l.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	local n = m:GetPlayerOwnerID()
	local o = self:GetSpecialValueFor("count")
	self:SpendCharge()
	PlayerData:requestSectSelection(n, { sects = AbilityShop.pickList }, function(p, n, q)
		if IsValid(self) and IsValid(self:GetCaster()) then
			local r = PlayerData:getplayerData(n)
			local s = r.hero
			if s then
				local t = AbilityShop:getRandomAbility(
					n,
					o,
					{ specifySect = { q }, isAbilityShop = false, specifyRarityIgnoreRule = true }
				)
				e(t, function(p, u, v)
					local w
					local x
					x = u.aid
					w = u.rarity
					s:learnAbility(x, true)
					Notification:combatToPlayer(
						n,
						{
							message = "notify_artifact_ability_" .. w,
							string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
							string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. x,
						}
					)
					r:addArtifactAbilities(self:entindex(), x, true)
				end)
			end
		end
	end)
end
function l.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function l.prototype.GetCustomCastError(self)
	return self.error
end
l = f({ k(nil) }, l)
h.item_artifact_98 = l
return h