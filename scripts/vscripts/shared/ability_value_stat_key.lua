--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
--- 将 AbilityValues 的 key 名映射为标签数值类型（后缀匹配策略）。
--
-- 规则：只有 key **以特定后缀结尾**（或精确等于）才命中对应 CountTagStat。
-- 新增 AbilityValues key 时，后缀决定是否进标签加成；不需要加成的 key 应避开这些后缀。
--
-- 约定：
-- - 同一套映射供运行时（GetSpecialValue）与前后端解析器复用
-- - 未命中时返回 undefined，由上层决定是否走标签结算
-- - 匹配顺序有优先级，排在前面的规则先命中先返回
function ____exports.ResolveStatByAbilityValueKey(self, key, override)
	if override and override[key] ~= nil then
		return override[key]
	end
	local k = string.lower(tostring(key))
	if __TS__StringEndsWith(k, "projectile_speed") then
		return 12
	end
	if __TS__StringEndsWith(k, "projectile_count") then
		return 13
	end
	if __TS__StringEndsWith(k, "cast_point") then
		return 9
	end
	if __TS__StringEndsWith(k, "cast_range") then
		return 8
	end
	if __TS__StringEndsWith(k, "cooldown") then
		return 7
	end
	if __TS__StringEndsWith(k, "mana_cost") then
		return 6
	end
	if __TS__StringEndsWith(k, "chance_pct") or __TS__StringEndsWith(k, "probability") then
		return 5
	end
	if __TS__StringEndsWith(k, "heal") or __TS__StringStartsWith(k, "heal_") or __TS__StringIncludes(k, "regen") then
		return 14
	end
	if __TS__StringEndsWith(k, "duration") then
		return 3
	end
	if __TS__StringEndsWith(k, "radius") or __TS__StringEndsWith(k, "range") or k == "aoe" then
		return 1
	end
	if __TS__StringEndsWith(k, "distance") then
		return 4
	end
	if
		__TS__StringEndsWith(k, "_damage")
		or __TS__StringEndsWith(k, "_dmg")
		or __TS__StringEndsWith(k, "damage_pct")
		or __TS__StringEndsWith(k, "damage_multiplier")
		or __TS__StringEndsWith(k, "damage_multiplier_pct")
	then
		return 2
	end
	if __TS__StringStartsWith(k, "buff_") then
		return 15
	end
	return nil
end
return ____exports