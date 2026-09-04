--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
local ____exports = {}
local MIN_ATTRIBUTE_MULTIPLIER = 0.000001
--- 获取平添属性进入总属性时实际承受的百分比乘区。
function ____exports.GetItem0608AttributeMultiplier(self, attributePct)
	return 1 + attributePct / 100
end
--- 从当前总属性中精确移除本装备上轮平添值的实际贡献。
function ____exports.GetItem0608TotalWithoutGrant(self, totalAttribute, previousGrant, attributePct)
	local multiplier = ____exports.GetItem0608AttributeMultiplier(nil, attributePct)
	return math.max(0, totalAttribute - previousGrant * multiplier)
end
--- 将目标总属性百分比变化换算为属性系统所需的平添值。
function ____exports.GetItem0608FlatGrant(self, totalWithoutGrant, attributePct, effectPct)
	local multiplier = ____exports.GetItem0608AttributeMultiplier(nil, attributePct)
	if multiplier <= MIN_ATTRIBUTE_MULTIPLIER then
		return 0
	end
	return math.floor(math.max(0, totalWithoutGrant) * math.max(0, effectPct) / 100 / multiplier)
end
return ____exports