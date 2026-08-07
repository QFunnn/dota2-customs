--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 16fdfbc · 2026-08-07 21:47:55 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/artifact/item_artifact_122"
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
		["19"] = 6,
		["20"] = 7,
		["21"] = 8,
		["23"] = 6,
		["24"] = 11,
		["25"] = 12,
		["26"] = 13,
		["27"] = 14,
		["28"] = 15,
		["29"] = 16,
		["30"] = 16,
		["31"] = 16,
		["32"] = 18,
		["33"] = 19,
		["34"] = 20,
		["35"] = 21,
		["36"] = 22,
		["37"] = 23,
		["38"] = 24,
		["39"] = 25,
		["40"] = 26,
		["41"] = 27,
		["44"] = 30,
		["45"] = 31,
		["46"] = 32,
		["47"] = 33,
		["48"] = 33,
		["49"] = 33,
		["50"] = 33,
		["51"] = 34,
		["52"] = 34,
		["53"] = 34,
		["54"] = 34,
		["55"] = 34,
		["56"] = 34,
		["57"] = 34,
		["58"] = 34,
		["60"] = 40,
		["64"] = 16,
		["65"] = 16,
		["67"] = 11,
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
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseItem
local j = h.registerAbility
g.item_artifact_122 = c()
local k = g.item_artifact_122
k.name = "item_artifact_122"
d(k, i)
function k.prototype.____constructor(self, ...)
	i.prototype.____constructor(self, ...)
	self.isCreat = false
end
function k.prototype.Spawn(self)
	if IsServer() then
		self:SetCurrentCharges(self:GetSpecialValueFor("count"))
	end
end
function k.prototype.OnSpellStart(self)
	local l = self:GetCaster()
	local m = l:GetPlayerOwnerID()
	if not self.isCreat then
		self.isCreat = true
		PlayerData:requestSectSelection(m, { sects = AbilityShop.pickList }, function(n, m, o)
			if IsValid(self) and IsValid(self:GetCaster()) then
				local p = PlayerData:getplayerData(m)
				local q = p.hero
				self.isCreat = false
				if q then
					local r
					for s, t in pairs(KeyValues.AbilityUpgradesKvs) do
						if t.type == "inhibit" and t.sect == o then
							r = s
						end
					end
					if r then
						if p.hero:getAbilityUpgradeLevel(r) < 5 then
							self:SpendCharge()
							p:addArtifactAbilities(self:entindex(), r)
							Notification:combatToPlayer(
								m,
								{
									message = "notify_artifact_ability_"
										.. tostring(KeyValues.AbilityUpgradesKvs[r].rarity),
									string_itemname_artifact = "DOTA_Tooltip_ability_" .. self:GetAbilityName(),
									string_ability_name = "DOTA_Tooltip_ability_mechanics_" .. r,
								}
							)
						end
						q:learnAbility(r, true)
					end
				end
			end
		end)
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
g.item_artifact_122 = k
return g