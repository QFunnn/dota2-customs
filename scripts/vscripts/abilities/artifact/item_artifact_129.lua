--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
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
local i = b.__TS__DecorateLegacy
local j = b.__TS__SourceMapTraceBack
j(
	debug.getinfo(1).short_src,
	{
		["12"] = 1,
		["13"] = 1,
		["14"] = 1,
		["15"] = 3,
		["16"] = 4,
		["17"] = 3,
		["18"] = 4,
		["19"] = 5,
		["20"] = 6,
		["21"] = 7,
		["23"] = 5,
		["24"] = 10,
		["25"] = 11,
		["26"] = 12,
		["27"] = 13,
		["28"] = 13,
		["29"] = 13,
		["30"] = 13,
		["32"] = 14,
		["33"] = 14,
		["34"] = 15,
		["35"] = 16,
		["36"] = 18,
		["37"] = 18,
		["38"] = 18,
		["39"] = 19,
		["40"] = 20,
		["41"] = 21,
		["42"] = 22,
		["45"] = 25,
		["46"] = 26,
		["47"] = 27,
		["49"] = 28,
		["50"] = 28,
		["52"] = 29,
		["55"] = 30,
		["56"] = 31,
		["57"] = 32,
		["58"] = 34,
		["59"] = 34,
		["60"] = 34,
		["61"] = 34,
		["62"] = 34,
		["63"] = 35,
		["64"] = 35,
		["66"] = 36,
		["67"] = 37,
		["70"] = 28,
		["73"] = 39,
		["74"] = 40,
		["75"] = 41,
		["76"] = 41,
		["77"] = 41,
		["78"] = 41,
		["79"] = 41,
		["80"] = 41,
		["81"] = 41,
		["82"] = 41,
		["83"] = 46,
		["84"] = 46,
		["85"] = 46,
		["86"] = 46,
		["87"] = 46,
		["89"] = 14,
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
local k = {}
local l = require("lib.dota_ts_adapter")
local m = l.BaseItem
local n = l.registerAbility
k.item_artifact_129 = c()
local o = k.item_artifact_129
o.name = "item_artifact_129"
d(o, m)
function o.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(1)
	end
end
function o.prototype.OnSpellStart(self)
	local p = self:GetCaster():GetPlayerOwnerID()
	self:SpendCharge()
	local q = e(PlayerData:getAlivePlayerIDList(), function(r, s)
		return s ~= p
	end)
	do
		local t = #q - 1
		while t >= 0 do
			local u = PlayerData:getHero(p):getAbilityUpgradeData()
			local v = {}
			for w, x in pairs(u) do
				local y
				y = x.level
				local z = KeyValues.AbilityUpgradesKvs[w]
				local A = SECT_ABILITY_LEVEL[z.rarity]
				if y >= A then
					v[#v + 1] = tostring(w)
				end
			end
			local B = p
			local C
			local D = #q
			do
				local t = 0
				while t < D do
					do
						if C ~= nil then
							break
						end
						local E = RandomInt(0, #q - 1)
						local F = q[E + 1]
						f(q, E, 1)
						local G = PlayerData:getHero(F)
						local H = e(h(G and G:getAbilityUpgradeData() or {}), function(r, I)
							return not g(v, I)
						end)
						if #H <= 0 then
							goto J
						end
						B = F
						C = GetRandomElement(H)
					end
					::J::
					t = t + 1
				end
			end
			if C ~= nil then
				PlayerData:getHero(p):learnAbility(C, true)
				Notification:combatToPlayer(
					p,
					{
						message = "notify_artifact_ability_" .. tostring(KeyValues.AbilityUpgradesKvs[C].rarity),
						string_itemname_artifact = "DOTA_Tooltip_ability_item_artifact_129",
						string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. C,
					}
				)
				PlayerData:getplayerData(p):addArtifactAbilities(self:entindex(), C, true)
			end
			t = t - 1
		end
	end
end
function o.prototype.CastFilterResult(self)
	if self:GetCurrentCharges() == 0 then
		self.error = "error_no_charge"
		return UF_FAIL_CUSTOM
	end
	return UF_SUCCESS
end
function o.prototype.GetCustomCastError(self)
	return self.error
end
o = i({ n(nil) }, o)
k.item_artifact_129 = o
return k