--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_1"
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
		["16"] = 4,
		["17"] = 5,
		["18"] = 3,
		["19"] = 7,
		["20"] = 8,
		["23"] = 10,
		["24"] = 11,
		["25"] = 7,
		["26"] = 13,
		["27"] = 14,
		["30"] = 17,
		["33"] = 20,
		["34"] = 21,
		["35"] = 22,
		["36"] = 23,
		["37"] = 23,
		["38"] = 23,
		["39"] = 23,
		["40"] = 23,
		["41"] = 23,
		["42"] = 26,
		["43"] = 27,
		["46"] = 29,
		["47"] = 30,
		["48"] = 31,
		["49"] = 32,
		["50"] = 33,
		["51"] = 34,
		["54"] = 37,
		["55"] = 38,
		["56"] = 39,
		["57"] = 39,
		["58"] = 39,
		["59"] = 39,
		["60"] = 39,
		["61"] = 39,
		["62"] = 39,
		["63"] = 39,
		["65"] = 45,
		["66"] = 23,
		["67"] = 23,
		["68"] = 13,
		["69"] = 4,
		["70"] = 3,
		["71"] = 4,
		["73"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.treasure_1 = c()
local k = g.treasure_1
k.name = "treasure_1"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.selecting = false
end
function k.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	self.count = self:GetSpecialValueFor("count")
	self:Effect()
end
function k.prototype.Effect(self)
	if self.selecting then
		return
	end
	if self.count <= 0 then
		return
	end
	self.selecting = true
	self.count = self.count - 1
	local l = self:GetCaster():GetPlayerOwnerID()
	PlayerData:requestSectSelection(
		l,
		{ sects = AbilityShop.pickList, ability_name = self:GetAbilityName() },
		function(m, n, o)
			if not IsValid(self) then
				return
			end
			self.selecting = false
			local p = PlayerData:getplayerData(n)
			local q
			for r, s in pairs(KeyValues.AbilityUpgradesKvs) do
				if s.type == "inhibit" and s.sect == o then
					q = r
				end
			end
			if q and p.hero:getAbilityUpgradeLevel(q) < 5 then
				p.hero:learnAbility(q, true)
				Notification:combatToPlayer(
					l,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[q].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. q,
					}
				)
			end
			self:Effect()
		end
	)
end
k = e({ j(nil) }, k)
g.treasure_1 = k
return g