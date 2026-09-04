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
--- 【魔神】套（流血流派·面向玩家显示名"魔神套"）套装工具：统计身上穿戴的魔神套装备数量。
-- 成员 = item_0467 / item_0502 / item_0516（流血流派套装）。
--  (2026-06-28 移除 item_0465 魔神战铠；加入 item_0502 战神铠甲。)
-- 增删 BLEED_ITEMS 即可调整哪些算流血套，无需改各装备代码。
-- 注：血渊噬王 item_0504 是宝物、不属流血套，故不计入自身。
____exports.BLEED_ITEMS = {
	"item_0467",
	"item_0502",
	"item_0516",
	"item_0841",
	"item_0847",
	"item_0761",
}
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【流血】套装件数。
function ____exports.CountBleedItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.BLEED_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports