--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build ec5ff63 
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__ArrayIncludes = ____lualib.__TS__ArrayIncludes
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
--- 【贤者】套装共享工具（现役消费者仅 item_0526 贤者共鸣；0442 的「大贤者之威」已于 2026-07-01 移除，0336 不消费名单）。
--  - SAGE_ITEMS：贤者套装成员清单，增删此数组即可调整“哪些算贤者装”。
--  - GetSageItems：枚举英雄主装备槽(0-5)上穿戴的贤者装。
--  - HasSageItem：英雄是否穿戴了某件指定贤者装。
--
-- 与 [[lionheart_set]] 同构，集中维护套装判定，避免在各装备里重复实现轮询逻辑。
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
	15,
	16,
	17,
}
____exports.SAGE_ITEMS = {
	"item_0456",
	"item_0336",
	"item_0442",
	"item_0526",
	"item_0384",
	"item_0724",
	"item_0716",
	"item_0839",
	"item_0765",
	"item_0807",
}
--- 枚举英雄主装备槽(0-5)上穿戴的【贤者】类型装备。
function ____exports.GetSageItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return {}
	end
	local result = {}
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.SAGE_ITEMS, item:GetAbilityName()) then
			result[#result + 1] = item
		end
	end
	return result
end
--- 英雄是否穿戴了某件指定【贤者】装备（按物品名匹配）。
function ____exports.HasSageItem(self, hero, itemName)
	return __TS__ArraySome(____exports.GetSageItems(nil, hero), function(____, item)
		return item:GetAbilityName() == itemName
	end)
end
return ____exports