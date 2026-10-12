--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- modifiers/bless_modifiers/sl_modifier_bless_10188.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
local ____lualib = require("lualib_bundle")
local __TS__Class = ____lualib.__TS__Class
local __TS__ClassExtends = ____lualib.__TS__ClassExtends
local __TS__Decorate = ____lualib.__TS__Decorate
____debugRuntime.register(
	"modifiers/bless_modifiers/sl_modifier_bless_10188.lua",
	{
		["10"] = "1:1",
		["11"] = "1:10",
		["12"] = "2:1",
		["13"] = "2:10",
		["15"] = "11:7",
		["17"] = "14:1",
		["18"] = "15:10",
		["21"] = "16:5",
		["22"] = "17:13",
		["23"] = "18:13",
		["26"] = "14:1",
		["29"] = "27:1",
		["30"] = "28:14",
		["31"] = "27:1",
		["32"] = "28:38",
		["33"] = "29:5",
		["34"] = "30:9",
		["35"] = "29:5",
		["36"] = "35:5",
		["37"] = "36:14",
		["40"] = "37:9",
		["41"] = "37:9",
		["42"] = "37:33",
		["43"] = "37:51",
		["44"] = "37:9",
		["45"] = "38:9",
		["46"] = "35:5",
		["47"] = "41:5",
		["48"] = "42:14",
		["51"] = "43:9",
		["52"] = "43:9",
		["53"] = "43:33",
		["54"] = "43:51",
		["55"] = "43:9",
		["56"] = "41:5",
		["57"] = "46:5",
		["58"] = "47:14",
		["61"] = "48:9",
		["62"] = "48:9",
		["63"] = "48:33",
		["64"] = "48:51",
		["65"] = "48:9",
		["66"] = "46:5",
		["67"] = "51:5",
		["68"] = "52:14",
		["71"] = "53:9",
		["72"] = "54:15",
		["73"] = "56:9",
		["74"] = "56:28",
		["75"] = "56:31",
		["76"] = "57:18",
		["79"] = "58:17",
		["82"] = "59:13",
		["83"] = "56:31",
		["84"] = "56:9",
		["85"] = "51:5",
		["86"] = "28:14",
		["87"] = "27:2",
		["88"] = "27:2",
		["89"] = "27:19",
		["90"] = "27:2",
		["92"] = "27:2",
		["93"] = "28:14",
		["95"] = "28:14",
	}
)
local ____exports = {}
local ____dota_ts_adapter = require("utils.dota_ts_adapter")
local registerModifier = ____dota_ts_adapter.registerModifier
local ____sl_modifier_base = require("modifiers.sl_modifier_base")
local SLModifierBase = ____sl_modifier_base.SLModifierBase
--- 九格神装持有者很少，1 秒扫一次自己的 3 个背包格
local BACKPACK_READY_INTERVAL = 1
--- 只改背包 3 格，且仅在状态不同时写入，避免反复重置物品冷却
local function set_backpack_item_state(self, parent, state)
	if not IsValid(parent) then
		return
	end
	for ____, item in ipairs(parent:FindAllItemsBySlotType(4)) do
		if item:GetItemState() ~= state then
			item:SetItemState(state)
		end
	end
end
--- 备用背包中的物品生效，并且可以主动使用。
-- CAN_USE_BACKPACK_ITEMS 不会清掉背包交换冷却，冷却期间物品是 unequipped，属性不生效。
____exports.sl_modifier_bless_10188 = __TS__Class()
local sl_modifier_bless_10188 = ____exports.sl_modifier_bless_10188
sl_modifier_bless_10188.name = "sl_modifier_bless_10188"
__TS__ClassExtends(sl_modifier_bless_10188, SLModifierBase)
function sl_modifier_bless_10188.prototype.CheckState(self)
	return { [MODIFIER_STATE_CAN_USE_BACKPACK_ITEMS] = true }
end
function sl_modifier_bless_10188.prototype.OnCreated(self)
	if not IsServer() then
		return
	end
	set_backpack_item_state(nil, self:GetParent(), 1)
	self:StartIntervalThink(BACKPACK_READY_INTERVAL)
end
function sl_modifier_bless_10188.prototype.OnRefresh(self)
	if not IsServer() then
		return
	end
	set_backpack_item_state(nil, self:GetParent(), 1)
end
function sl_modifier_bless_10188.prototype.OnIntervalThink(self)
	if not IsServer() then
		return
	end
	set_backpack_item_state(nil, self:GetParent(), 1)
end
function sl_modifier_bless_10188.prototype.OnDestroy(self)
	if not IsServer() then
		return
	end
	self:StartIntervalThink(-1)
	local parent = self:GetParent()
	Timers:CreateTimer(0, function()
		if not IsValid(parent) then
			return
		end
		if parent:HasSLModifier(____exports.sl_modifier_bless_10188) then
			return
		end
		set_backpack_item_state(nil, parent, 0)
	end)
end
sl_modifier_bless_10188 = __TS__Decorate(
	{ registerModifier(nil, "modifiers/bless_modifiers/sl_modifier_bless_10188", nil, getfenv()) },
	sl_modifier_bless_10188
)
____exports.sl_modifier_bless_10188 = sl_modifier_bless_10188
return ____exports