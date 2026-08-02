--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_118"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__StringIncludes
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
		["26"] = 14,
		["27"] = 14,
		["28"] = 17,
		["29"] = 18,
		["30"] = 20,
		["31"] = 21,
		["32"] = 22,
		["33"] = 23,
		["34"] = 24,
		["35"] = 25,
		["36"] = 26,
		["37"] = 27,
		["38"] = 28,
		["39"] = 29,
		["42"] = 32,
		["43"] = 33,
		["44"] = 34,
		["45"] = 34,
		["46"] = 34,
		["47"] = 34,
		["48"] = 34,
		["49"] = 35,
		["50"] = 35,
		["51"] = 35,
		["52"] = 35,
		["53"] = 36,
		["54"] = 36,
		["55"] = 36,
		["56"] = 36,
		["57"] = 36,
		["58"] = 36,
		["59"] = 36,
		["60"] = 36,
		["62"] = 42,
		["65"] = 14,
		["66"] = 14,
		["67"] = 10,
		["68"] = 47,
		["69"] = 48,
		["70"] = 49,
		["71"] = 50,
		["73"] = 52,
		["74"] = 47,
		["75"] = 54,
		["76"] = 55,
		["77"] = 54,
		["78"] = 4,
		["79"] = 3,
		["80"] = 4,
		["82"] = 4,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseItem
local k = i.registerAbility
h.item_artifact_118 = c()
local l = h.item_artifact_118
l.name = "item_artifact_118"
d(l, j)
function l.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function l.prototype.OnSpellStart(self)
	local m = self:GetCaster()
	self:SpendCharge()
	local n = m:GetPlayerOwnerID()
	PlayerData:requestSectSelection(
		n,
		{ sects = AbilityShop.pickList, ability_name = "item_artifact_118" },
		function(o, n, p)
			if IsValid(self) and IsValid(self:GetCaster()) then
				local q = PlayerData:getplayerData(n)
				local r = q.hero
				if r then
					local s = r:getAbilityUpgradeData()
					local t = 0
					local u = {}
					for v, w in pairs(s) do
						if e(KeyValues.AbilityUpgradesKvs[v].sect, p) then
							u[v] = -w.level
							t = t + KeyValues.AbilityUpgradesKvs[v].cost * w.level
						end
					end
					if t > 0 then
						PlayerData:modifyGold(n, t)
						q:modifyArtifactExtraData(self:entindex(), "bonus_gold", t)
						EmitAnnouncerSoundForPlayer("General.Coins", m:GetPlayerOwnerID())
						Notification:combatToPlayer(
							n,
							{
								message = "notify_bonus_gold",
								string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
								int_gold = t,
							}
						)
					end
					r:modifyAbilityUpgrade(u)
				end
			end
		end
	)
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
h.item_artifact_118 = l
return h