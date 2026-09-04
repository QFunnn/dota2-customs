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
--- 【狮心】套装工具：统计身上穿戴的狮心装备数量。
-- 成员 = 狮心战铠 item_0329 / 狮心王锤 item_0460 / 狮心王冠 item_0396 / 狮心王之证 item_0527 / 觉醒 item_0530（核心，自身亦计入，
--  使其「狮心王」被动在只穿戴本件时即可按 1 件结算触发）。
-- 增删 SHICI_ITEMS 即可调整哪些算狮心装，无需改各装备代码。
____exports.SHICI_ITEMS = {
	"item_0329",
	"item_0460",
	"item_0396",
	"item_0527",
	"item_0385",
	"item_0536",
	"item_0714",
	"item_0726",
	"item_0808",
	"item_0766",
	"item_0858",
	"item_0787",
}
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
--- 统计 hero 主装槽内穿戴的【狮心】装备件数。
function ____exports.CountLionheartItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.SHICI_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports