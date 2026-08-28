--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 0b85d8d 
  ~ auto-generated — do not edit
]]


local a = "abilities/greevil_effect/greevil_effect_ability_upgrade"
local b = require("lualib_bundle")
local c = b.__TS__Class
local d = b.__TS__ClassExtends
local e = b.__TS__SourceMapTraceBack
e(
	debug.getinfo(1).short_src,
	{
		["7"] = 1,
		["8"] = 1,
		["9"] = 3,
		["10"] = 3,
		["11"] = 3,
		["12"] = 3,
		["13"] = 5,
		["14"] = 6,
		["15"] = 7,
		["16"] = 8,
		["17"] = 9,
		["18"] = 10,
		["19"] = 11,
		["20"] = 12,
		["21"] = 13,
		["22"] = 14,
		["24"] = 16,
		["25"] = 16,
		["26"] = 16,
		["27"] = 16,
		["28"] = 16,
		["29"] = 16,
		["30"] = 16,
		["32"] = 5,
		["33"] = 25,
		["34"] = 26,
		["35"] = 27,
		["36"] = 27,
		["37"] = 27,
		["38"] = 27,
		["40"] = 25,
	}
)
local f = {}
local g = require("abilities.greevil_effect.greevil_effect_base")
local h = g.GreevilEffectBase
f.greevil_effect_ability_upgrade = c()
local i = f.greevil_effect_ability_upgrade
i.name = "greevil_effect_ability_upgrade"
d(i, h)
function i.prototype.spawn(self)
	local j = self:getPlayerID()
	local k = self:getSpecialValueFor("damage_pct")
	local l = self:getSpecialValueFor("chance")
	local m = self.kv.AbilityValues
	self.link_ability = self.kv.link_ability
	if m ~= nil and self.link_ability ~= nil then
		local n = {}
		for o, p in pairs(m) do
			n["g_" .. tostring(o)] = p
		end
		AbilityUpgrades:AddAbilityMechanicsUpgrade(
			j,
			{
				ability_name = self.link_ability,
				type = ABILITY_UPGRADES_TYPE.ABILITY_UPGRADES_TYPE_ABILITY_MECHANICS,
				id = self.link_ability,
				values = n,
				description = self.link_ability,
			}
		)
	end
end
function i.prototype.dispose(self)
	if self.link_ability then
		AbilityUpgrades:RemoveAbilityMechanicsUpgradeByID(self:getPlayerID(), self.kv.link_ability)
	end
end
return f