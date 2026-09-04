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
--- 【四象】套套装工具：统计身上穿戴的四象归一套装备数量。
-- 成员 = item_0578 万象之引（施加 DOT 概率追加一种目标未有的 DOT）/ item_0579 四疫之印（四系俱全时 DOT 结算追加等额物理）。
-- 二件套联动（判定在万象之引内）：追加概率提升。
-- 增删 SIXIANG_ITEMS 即可调整成员（同 fenshi_set.ts / zushi_set.ts 范式）。
____exports.SIXIANG_ITEMS = { "item_0578", "item_0579" }
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【四象】套装件数。
function ____exports.CountSixiangItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.SIXIANG_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports