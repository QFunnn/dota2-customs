--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-07 04:51:43 UTC
  ~ auto-generated — do not edit
]]


local a = "abilities/unit_state"
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
		["18"] = 8,
		["19"] = 9,
		["20"] = 11,
		["21"] = 12,
		["22"] = 13,
		["23"] = 15,
		["25"] = 16,
		["26"] = 17,
		["28"] = 18,
		["30"] = 19,
		["32"] = 20,
		["34"] = 21,
		["36"] = 22,
		["39"] = 24,
		["43"] = 27,
		["46"] = 30,
		["47"] = 31,
		["48"] = 32,
		["49"] = 34,
		["50"] = 35,
		["51"] = 37,
		["52"] = 38,
		["53"] = 39,
		["55"] = 41,
		["58"] = 44,
		["59"] = 5,
		["60"] = 46,
		["61"] = 47,
		["62"] = 49,
		["63"] = 49,
		["64"] = 49,
		["65"] = 49,
		["66"] = 46,
		["67"] = 4,
		["68"] = 3,
		["69"] = 4,
		["71"] = 4,
	}
)
local g = {}
local h = require("lib.dota_ts_adapter")
local i = h.BaseAbility
local j = h.registerAbility
g.unit_state = c()
local k = g.unit_state
k.name = "unit_state"
d(k, i)
function k.prototype.GetAbilityTextureName(self)
	if _G.GetAbilitySpecialValue_AbilityEntIndex ~= nil then
		local l = EntIndexToHScript(_G.GetAbilitySpecialValue_AbilityEntIndex)
		local m = _G.GetAbilitySpecialValue_Level
		local n = _G.GetAbilitySpecialValue_KeyName
		_G.GetAbilitySpecialValue_AbilityEntIndex = nil
		_G.GetAbilitySpecialValue_Level = nil
		_G.GetAbilitySpecialValue_KeyName = nil
		if IsValid(l) and type(l.GetLevelSpecialValueFor) == "function" then
			repeat
				local o = n
				local p = o == "cooldown"
				if p then
					return tostring(l:GetCooldown(m))
				end
				p = p or o == "mana_cost"
				if p then
					return tostring(l:GetManaCost(m))
				end
				p = p or o == "gold_cost"
				if p then
					return tostring(l:GetGoldCost(m))
				end
				do
					return tostring(l:GetLevelSpecialValueFor(n, m))
				end
			until true
		else
			return ""
		end
	end
	if _G.GetUnitData_UnitEntIndex ~= nil then
		local q = EntIndexToHScript(_G.GetUnitData_UnitEntIndex)
		local r = _G.GetUnitData_FunctionName
		_G.GetUnitData_UnitEntIndex = nil
		_G.GetUnitData_FunctionName = nil
		local s = _G[r]
		if IsValid(q) and type(s) == "function" then
			return tostring(s(q))
		else
			return ""
		end
	end
	return ""
end
function k.prototype.OnInventoryContentsChanged(self)
	local t = self:GetCaster()
	FireGameEventLocal("custom_inventory_contents_changed", { EntityIndex = t:entindex() })
end
k = e({ j(nil) }, k)
g.unit_state = k
return g