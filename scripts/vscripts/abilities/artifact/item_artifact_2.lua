--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_2"
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
		["24"] = 13,
		["25"] = 13,
		["26"] = 13,
		["27"] = 14,
		["28"] = 14,
		["29"] = 14,
		["30"] = 14,
		["31"] = 14,
		["32"] = 15,
		["33"] = 15,
		["34"] = 15,
		["35"] = 15,
		["36"] = 15,
		["37"] = 15,
		["38"] = 15,
		["39"] = 16,
		["40"] = 17,
		["41"] = 17,
		["42"] = 17,
		["43"] = 17,
		["44"] = 10,
		["45"] = 19,
		["46"] = 20,
		["47"] = 21,
		["48"] = 22,
		["50"] = 24,
		["51"] = 24,
		["52"] = 24,
		["53"] = 24,
		["54"] = 25,
		["55"] = 26,
		["56"] = 27,
		["58"] = 29,
		["59"] = 30,
		["60"] = 31,
		["62"] = 33,
		["63"] = 19,
		["64"] = 35,
		["65"] = 36,
		["66"] = 35,
		["67"] = 4,
		["68"] = 3,
		["69"] = 4,
		["71"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.item_artifact_2 = c()
local k = g.item_artifact_2
k.name = "item_artifact_2"
d(k, i)
function k.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("charges"))
	end
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = self:GetSpecialValueFor("hp_regen")
	PlayerData:modifyHealth(l:GetPlayerOwnerID(), m)
	PlayerData:getplayerData(l:GetPlayerOwnerID()):modifyArtifactExtraData(self:entindex(), "bonus_health", m)
	SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, l, m, l:GetPlayerOwner())
	self:SpendCharge()
	PlayerData:modifyGold(l:GetPlayerOwnerID(), -self:GetSpecialValueFor("gold_cost"))
end
function k.prototype.CastFilterResult(self)
	if self:GetCaster():GetHealthPercent() >= 100 then
		self.error = "error_health"
		return UF_FAIL_CUSTOM
	end
	local n = CustomNetTables:GetTableValue("player_data", tostring(self:GetCaster():GetPlayerOwnerID())).gold
	if n < self:GetSpecialValueFor("gold_cost") then
		self.error = "error_no_enough_gold"
		return UF_FAIL_CUSTOM
	end
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
g.item_artifact_2 = k
return g