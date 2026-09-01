--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/treasures/treasure_1"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__ArrayFilter
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
		["17"] = 4,
		["18"] = 5,
		["19"] = 3,
		["20"] = 7,
		["21"] = 8,
		["24"] = 10,
		["25"] = 11,
		["26"] = 7,
		["27"] = 13,
		["28"] = 14,
		["31"] = 17,
		["34"] = 20,
		["35"] = 21,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["39"] = 25,
		["42"] = 28,
		["43"] = 28,
		["44"] = 28,
		["45"] = 28,
		["46"] = 29,
		["49"] = 32,
		["50"] = 33,
		["51"] = 34,
		["52"] = 34,
		["53"] = 34,
		["54"] = 34,
		["55"] = 34,
		["56"] = 34,
		["57"] = 37,
		["58"] = 38,
		["61"] = 40,
		["62"] = 41,
		["63"] = 42,
		["64"] = 43,
		["65"] = 44,
		["66"] = 45,
		["67"] = 45,
		["68"] = 45,
		["69"] = 45,
		["70"] = 45,
		["71"] = 45,
		["72"] = 45,
		["73"] = 45,
		["75"] = 51,
		["76"] = 34,
		["77"] = 34,
		["78"] = 13,
		["79"] = 4,
		["80"] = 3,
		["81"] = 4,
		["83"] = 4,
	}
)
local h = {}
local i = require("lib.dota_ts_adapter")
local j = i.BaseAbility
local k = i.registerAbility
h.treasure_1 = c()
local l = h.treasure_1
l.name = "treasure_1"
d(l, j)
function l.prototype.____constructor(self, ...)
	j.prototype.____constructor(self, ...)
	self.selecting = false
end
function l.prototype.Spawn(self)
	if not IsServer() then
		return
	end
	self.count = self:GetSpecialValueFor("count")
	self:Effect()
end
function l.prototype.Effect(self)
	if self.selecting then
		return
	end
	if self.count <= 0 then
		return
	end
	local m = self:GetCaster():GetPlayerOwnerID()
	local n = PlayerData:getHero(m)
	local o = {}
	for p, q in pairs(KeyValues.AbilityUpgradesKvs) do
		if q.type == "inhibit" and n:getAbilityUpgradeLevel(p) < q.MaxLevel then
			o[q.sect] = p
		end
	end
	local r = e(AbilityShop.pickList, function(s, t)
		return o[t] ~= nil
	end)
	if #r <= 0 then
		return
	end
	self.selecting = true
	self.count = self.count - 1
	PlayerData:requestSectSelection(m, { sects = r, ability_name = self:GetAbilityName() }, function(s, u, t)
		if not IsValid(self) then
			return
		end
		self.selecting = false
		local v = PlayerData:getplayerData(u)
		local w = o[t]
		if w and v.hero:getAbilityUpgradeLevel(w) < KeyValues.AbilityUpgradesKvs[w].MaxLevel then
			v.hero:learnAbility(w, true)
			Notification:combatToPlayer(
				m,
				{
					message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[w].rarity),
					string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
					string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. w,
				}
			)
		end
		self:Effect()
	end)
end
l = f({ k(nil) }, l)
h.treasure_1 = l
return h