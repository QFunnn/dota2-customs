--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local ____exports = {}
--- 【渡厄】套装共享工具。
-- 成员 = item_0580 渡厄宝铃（自身负面状态属性效果镜像给周围敌人）/ item_0581 审厄之瞳（目标每个负面状态增伤）。
-- 二件套联动（判定在渡厄宝铃内）：镜像比例提升。
-- 增删 DUE_ITEMS 即可调整成员（同 zushi_set.ts / sixiang_set.ts 范式）。
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
____exports.DUE_ITEMS = { "item_0580", "item_0581" }
--- 统计英雄主装备槽(0-5)上穿戴的【渡厄】套装件数。
function ____exports.CountDueItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.DUE_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports