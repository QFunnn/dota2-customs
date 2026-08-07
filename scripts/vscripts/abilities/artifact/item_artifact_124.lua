--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_124"
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
		["25"] = 15,
		["26"] = 16,
		["27"] = 17,
		["28"] = 18,
		["29"] = 19,
		["30"] = 19,
		["31"] = 20,
		["34"] = 23,
		["35"] = 24,
		["36"] = 24,
		["37"] = 24,
		["38"] = 24,
		["39"] = 24,
		["40"] = 24,
		["41"] = 19,
		["42"] = 26,
		["44"] = 10,
		["45"] = 29,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["50"] = 34,
		["51"] = 29,
		["52"] = 36,
		["53"] = 37,
		["54"] = 36,
		["55"] = 4,
		["56"] = 3,
		["57"] = 4,
		["59"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.item_artifact_124 = c()
local k = g.item_artifact_124
k.name = "item_artifact_124"
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
	local n = PlayerData:getplayerData(m)
	if n and not n:IsBotData() then
		local o = GameState:getArtifactRounds()
		local p = math.min(#n.artifacts, #o)
		PlayerData:clearArtifact(m)
		local q
		q = function(r, s)
			if s >= p then
				return
			end
			local t = o[s + 1]
			PlayerData:selectArtifactByRound(m, t, "item_artifact_124", function()
				return q(nil, s + 1)
			end)
		end
		q(nil, 0)
	end
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
g.item_artifact_124 = k
return g