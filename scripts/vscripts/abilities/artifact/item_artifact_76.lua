--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_76"
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
		["13"] = 4,
		["14"] = 5,
		["15"] = 4,
		["16"] = 5,
		["17"] = 6,
		["18"] = 7,
		["19"] = 8,
		["21"] = 6,
		["22"] = 11,
		["23"] = 12,
		["24"] = 13,
		["25"] = 14,
		["26"] = 15,
		["27"] = 16,
		["28"] = 17,
		["29"] = 18,
		["30"] = 18,
		["31"] = 18,
		["32"] = 18,
		["33"] = 18,
		["34"] = 21,
		["35"] = 21,
		["36"] = 21,
		["37"] = 21,
		["38"] = 21,
		["39"] = 21,
		["40"] = 21,
		["41"] = 22,
		["42"] = 23,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 28,
		["47"] = 28,
		["48"] = 21,
		["49"] = 21,
		["50"] = 30,
		["52"] = 11,
		["53"] = 5,
		["54"] = 4,
		["55"] = 5,
		["57"] = 5,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
h.item_artifact_76 = c()
local l = h.item_artifact_76
l.name = "item_artifact_76"
d(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function l.prototype.OnSpellStart(self)
	if self:GetCurrentCharges() >= 1 then
		local m = self:GetCaster()
		local n = m:GetPlayerOwnerID()
		local o = self:GetSpecialValueFor("count")
		local p = self:GetSpecialValueFor("max")
		local q = PlayerData:getHero(n)
		local r = AbilityShop:getRandomAbility(n, RandomInt(o, p), { isAbilityShop = false })
		e(r, function(s, t, u)
			local v
			local w
			w = t.aid
			v = t.rarity
			q:learnAbility(w, true)
			Notification:combatToPlayer(
				n,
				{
					message = "notify_artifact_ability_" .. v,
					string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_76",
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
				}
			)
			PlayerData:getplayerData(m:GetPlayerOwnerID()):addArtifactAbilities(self:entindex(), w, u == #r - 1)
		end)
		self:SpendCharge()
	end
end
l = f({ k(nil) }, l)
h.item_artifact_76 = l
return h