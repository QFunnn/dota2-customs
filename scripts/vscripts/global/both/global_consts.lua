--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 9d26fbd · 2026-08-03 06:18:41 UTC
  ~ auto-generated — do not edit
]]


local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
--- 属性=>计算类型
Attr2CalcType = {
	sm = 0,
	smI = 0,
	mf = 0,
	mfI = 0,
	gjb = 0,
	gjl = 0,
	gjbI = 0,
	gjI = 0,
	jnzq = 0,
	hj = 0,
	mk = 4,
	xx = 0,
	jnxx = 0,
	qnxx = 0,
	yxxx = 0,
	yxjnxx = 0,
	yxqnxx = 0,
	gsI = 0,
	gs = 0,
	lq = 4,
	ys = 0,
	ysI = 0,
	gjjl = 0,
	sb = 4,
	sfjl = 0,
	jnfw = 0,
	jnfwI = 0,
	ll = 0,
	mj = 0,
	zl = 0,
	zsx = 0,
	qss = 0,
	fm = 0,
	ztkx = 4,
	gjjg = 5,
	smhf = 0,
	smhfI = 0,
	smhfzqI = 0,
	mfhf = 0,
	mfhfzqI = 2,
	csshI = 0,
	shI = 0,
	cffyshI = 0,
	cfdjshI = 0,
	fhsj = 0,
	fhsjI = 0,
	mxI = 0,
	hxgjbl = 0,
	hxgjgl = 0,
	phcs = 0,
	phzs = 0,
	gangpct = 0,
	smhftzI = 0,
}
--- 装备槽
InventorySlot_Equip = {
	DOTA_ITEM_SLOT_1,
	DOTA_ITEM_SLOT_2,
	DOTA_ITEM_SLOT_3,
	DOTA_ITEM_SLOT_4,
	DOTA_ITEM_SLOT_5,
	DOTA_ITEM_SLOT_6,
}
--- 背包槽
InventorySlot_BackPack = { DOTA_ITEM_SLOT_7, DOTA_ITEM_SLOT_8, DOTA_ITEM_SLOT_9 }
--- 仓库槽
InventorySlot_Stash = {
	DOTA_STASH_SLOT_1,
	DOTA_STASH_SLOT_2,
	DOTA_STASH_SLOT_3,
	DOTA_STASH_SLOT_4,
	DOTA_STASH_SLOT_5,
	DOTA_STASH_SLOT_6,
}
local ____array_0 = __TS__SparseArrayNew(unpack(InventorySlot_Equip))
__TS__SparseArrayPush(____array_0, unpack(InventorySlot_BackPack))
__TS__SparseArrayPush(____array_0, unpack(InventorySlot_Stash))
__TS__SparseArrayPush(
	____array_0,
	DOTA_ITEM_TP_SCROLL,
	DOTA_ITEM_NEUTRAL_ACTIVE_SLOT,
	DOTA_ITEM_NEUTRAL_PASSIVE_SLOT,
	DOTA_ITEM_TRANSIENT_ITEM,
	DOTA_ITEM_TRANSIENT_RECIPE,
	DOTA_ITEM_TRANSIENT_CAST_ITEM
)
--- 所有槽位
InventorySlot_All = { __TS__SparseArraySpread(____array_0) }
--- 被认为是跳刀的道具
ItemBlinks = { item_blink = true, item_swift_blink = true, item_arcane_blink = true, item_overwhelming_blink = true }
--- 被认为是隐刀的道具 以及对应的隐身修饰器名
ItemInvisSwordMap = {
	item_invis_sword = "modifier_item_invisibility_edge_windwalk",
	item_silver_edge = "modifier_item_silver_edge_windwalk",
}
--- 隐刀的隐身修饰器名 => 道具名
ItemInvisSwordMap_Reverse = {}
for key in pairs(ItemInvisSwordMap) do
	local item_name = key
	ItemInvisSwordMap_Reverse[ItemInvisSwordMap[item_name]] = item_name
end
--- 静态帧时间 单位秒
StaticFrameTime = 0.0333333334
--- 基地名称 - 队伍
FortNameMap = { npc_dota_goodguys_fort = DOTA_TEAM_GOODGUYS, npc_dota_badguys_fort = DOTA_TEAM_BADGUYS }
--- 被认为是控制的 buff state
ControlStates = {
	[MODIFIER_STATE_STUNNED] = true,
	[MODIFIER_STATE_TAUNTED] = true,
	[MODIFIER_STATE_ROOTED] = true,
	[MODIFIER_STATE_HEXED] = true,
	[MODIFIER_STATE_FEARED] = true,
	[MODIFIER_STATE_FROZEN] = true,
	[MODIFIER_STATE_COMMAND_RESTRICTED] = true,
}
STR_TEXT_COLOR = { r = 255, g = 0, b = 0 }
AGI_TEXT_COLOR = { r = 0, g = 255, b = 0 }
INT_TEXT_COLOR = { r = 15, g = 202, b = 235 }
--- 玩家位置 - 颜色
PLAYER_COLOR_HEX_MAP = {
	[DOTA_TEAM_GOODGUYS] = {
		[1] = "#3375ffff",
		[2] = "#66ffbfff",
		[3] = "#bf00bfff",
		[4] = "#f3f00bff",
		[5] = "#ff6b00ff",
	},
	[DOTA_TEAM_BADGUYS] = {
		[1] = "#fe86c2ff",
		[2] = "#a1b447ff",
		[3] = "#65d9f7ff",
		[4] = "#008321ff",
		[5] = "#a46900ff",
	},
}
TEAM_COLOR_HEX_MAP = { [DOTA_TEAM_GOODGUYS] = "#00FF00", [DOTA_TEAM_BADGUYS] = "#ff0000" }
--- 被认为是鞋子的道具
BOOTS_ITEMS_MAP = {
	item_boots = true,
	item_phase_boots = true,
	item_power_treads = true,
	item_arcane_boots = true,
	item_guardian_greaves = true,
	item_tranquil_boots = true,
	item_boots_of_bearing = true,
	item_travel_boots = true,
	item_travel_boots_2 = true,
}
SHADOW_SHAMAN_WARD_NAMES =
	{ "npc_dota_shadow_shaman_ward_1", "npc_dota_shadow_shaman_ward_2", "npc_dota_shadow_shaman_ward_3" }