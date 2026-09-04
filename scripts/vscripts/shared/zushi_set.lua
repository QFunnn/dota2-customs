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
--- 【诅蚀】套套装工具：统计身上穿戴的诅蚀套装备数量。
-- 成员 = item_0576 诅火之冠（debuff 数→DOT 增伤）/ item_0577 蚀魂之典（DOT 结算概率自叠蚀魂诅咒）。
-- 二件套联动（判定在蚀魂 modifier 内）：每层蚀魂额外提供技能伤害。
-- 增删 ZUSHI_ITEMS 即可调整成员（同 fenshi_set.ts / jiying_set.ts 范式）。
____exports.ZUSHI_ITEMS = { "item_0576", "item_0577" }
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【诅蚀】套装件数。
function ____exports.CountZushiItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.ZUSHI_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports