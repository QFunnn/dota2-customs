--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_12"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__DecorateLegacy
local f = b.__TS__SourceMapTraceBack
f(
	debug.getinfo(1).short_src,
	{
		["8"] = 1,
		["9"] = 1,
		["10"] = 1,
		["11"] = 3,
		["12"] = 4,
		["13"] = 3,
		["14"] = 4,
		["15"] = 5,
		["16"] = 6,
		["17"] = 7,
		["19"] = 5,
		["20"] = 10,
		["21"] = 11,
		["22"] = 12,
		["23"] = 13,
		["24"] = 14,
		["25"] = 14,
		["26"] = 14,
		["27"] = 17,
		["28"] = 19,
		["29"] = 20,
		["30"] = 21,
		["31"] = 21,
		["32"] = 21,
		["33"] = 21,
		["34"] = 22,
		["35"] = 14,
		["36"] = 14,
		["37"] = 10,
		["38"] = 26,
		["39"] = 27,
		["40"] = 28,
		["41"] = 29,
		["43"] = 31,
		["44"] = 26,
		["45"] = 33,
		["46"] = 34,
		["47"] = 33,
		["48"] = 4,
		["49"] = 3,
		["50"] = 4,
		["52"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.item_artifact_12 = c()
local k = g.item_artifact_12
k.name = "item_artifact_12"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = l:GetPlayerOwnerID()
	self:SpendCharge()
	PlayerData:requestSectSelection(
		l:GetPlayerOwnerID(),
		{ title = "禁用一个流派", sects = AbilityShop.pickList },
		function(n, m, o)
			PlayerData.playerData[m].bannedSect = o
			PlayerData:getHero(m):removeSectModifiers(self:GetName())
			PlayerData:getHero(m):addSectModifier(o, self:GetName())
			AbilityShop:refreshShop(m, "artifact")
		end
	)
end
function k.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function k.prototype.GetCustomCastError(self)
	return self.error
end
k = e({ j(nil) }, k)
g.item_artifact_12 = k
return g