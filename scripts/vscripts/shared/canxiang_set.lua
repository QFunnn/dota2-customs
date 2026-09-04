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
--- 【残响】套套装工具：成员统计（双端共享）。
-- 成员 = item_0571 残响之刃（普攻回声）/ item_0572 残响法印（技能回声）。
-- 二件套：回声比例从 ability_echo_pct 提升为 ability_echo_pct_full。
--
-- 注意：本文件位于 `shared/`，会被 junction 链接到 Panorama 前端，
-- 禁止使用任何服务端 API（SysTimers / Damage / EmitSoundOn / IsValidAlive 等）。
-- 延迟伤害结算等纯服务端逻辑已搬到 `abilities/items/canxiang_echo.ts`。
____exports.CANXIANG_ITEMS = { "item_0571", "item_0572" }
--- 残响伤害的归因标签：两件的监听都排除它 → 回声绝不再回声。
____exports.CANXIANG_ECHO_TAG = "canxiang_echo"
local MAIN_EQUIPMENT_SLOTS = {
	0,
	1,
	2,
	3,
	4,
	5,
}
--- 统计 hero 主装槽内穿戴的【残响】套装件数。
function ____exports.CountCanxiangItems(self, hero)
	if not hero or not IsValid(nil, hero) then
		return 0
	end
	local count = 0
	for ____, slot in ipairs(MAIN_EQUIPMENT_SLOTS) do
		local item = hero:GetItemInSlot(slot)
		if item and IsValid(nil, item) and __TS__ArrayIncludes(____exports.CANXIANG_ITEMS, item:GetAbilityName()) then
			count = count + 1
		end
	end
	return count
end
return ____exports