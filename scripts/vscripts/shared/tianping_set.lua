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
--- 【天平】套套装工具：成员统计 + 左右两件的跨件通信约定。
-- 成员 = item_0573 均衡之左（魔法承伤）/ item_0574 均衡之右（耗蓝蓄能爆发）。
-- 二件套联动：左件承伤消耗的魔法，通过单位自定义值 TIANPING_ABSORBED_MANA_KEY 报账，
--  右件的蓄能 modifier 周期收割入账（读取→清零），实现"承伤也充能"。
____exports.TIANPING_ITEMS = { "item_0573", "item_0574" }
--- 跨件报账 key：左件写入承伤消耗的魔法量（累加），右件收割后清零。
____exports.TIANPING_ABSORBED_MANA_KEY = "tianping_absorbed_mana_acc"
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【天平】套装件数。
function ____exports.CountTianpingItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.TIANPING_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports