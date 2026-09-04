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
--- 【疾影】套（敏捷/移速流派）套装工具：统计身上穿戴的疾影套装备数量。
-- 被动本体 = 疾影挂坠 item_0651「疾影共鸣」（2026-08-05 作者把被动从 0523 挪到新建的 0651）。
--
-- 成员（2026-08-06 定案·4 本体 + 各自先祖）：
--   疾影之靴 0360 / 疾影护服 0404 / 疾影手套 0523 / 疾影挂坠 0651
--   先祖版      0718 /        0837 /        0764 /        0879
--
-- ⚠ 为什么是 id 白名单而不是真去匹配"名字含疾影"：装备中文名只存在于
-- addon_schinese.txt（CSV 列2 是 #Loc 前缀，只进 loc 不进 KV/JSON），运行期 Lua
-- 拿不到中文名。故"名字带疾影"的设计意图落地为显式 id 清单——**新增疾影件时必须来这里登记**，
-- 否则套装不计数。（照 [[bleed_set]] 魔神套先例。）
--
-- 名单外的同名/近名件（勿加）：
--  - item_0453 / 0840：作者 2026-08-05 改回「幽冥鬼刺」，名字已不含疾影 → 用户拍板移出本套。
--  - item_0445 疾影背包 / 0860：背包走独立槽位不占主装槽，按用户 2026-08-05 名单排除。
--  - item_0236 疾影战靴、item_0552 疾影护符：从未列入用户给的套装名单。
--  - item_0562 / 0626 / 0793：曾叫「疾影手套」，2026-08-06 已改名「掠影手套」避撞，与本套无关。
____exports.SHADOW_ITEMS = {
	"item_0360",
	"item_0404",
	"item_0523",
	"item_0651",
	"item_0445",
	"item_0718",
	"item_0837",
	"item_0764",
	"item_0879",
	"item_0860",
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
--- 统计 hero 主装槽内穿戴的【疾影】套装件数（含本件）。
function ____exports.CountShadowItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.SHADOW_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports