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
--- 【疾影】套套装工具：统计身上穿戴的疾影套装备数量。
-- 成员 = item_0562 疾影手套 / item_0404 疾影护服（闪避流派套装）。
-- 增删 JIYING_ITEMS 即可调整哪些算疾影套，无需改各装备代码（同 bleed_set.ts 范式）。
____exports.JIYING_ITEMS = { "item_0562", "item_0404" }
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【疾影】套装件数。
function ____exports.CountJiyingItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.JIYING_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports