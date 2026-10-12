--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build 1a5b3bb 
  ~ auto-generated — do not edit
]]


-- utils/sunlight/ts_utils/SunLightItem.lua
local ____debugRuntime = require("utils.debug_runtime")
local debug = ____debugRuntime.safe_debug
--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
____debugRuntime.register(
	"utils/sunlight/ts_utils/SunLightItem.lua",
	{
		["6"] = "4:11",
		["11"] = "9:5",
		["13"] = "10:18",
		["14"] = "10:25",
		["15"] = "11:19",
		["16"] = "12:17",
		["17"] = "12:41",
		["19"] = "10:57",
		["22"] = "14:9",
		["23"] = "9:5",
		["29"] = "23:5",
		["31"] = "24:18",
		["32"] = "24:25",
		["33"] = "25:19",
		["34"] = "26:17",
		["35"] = "27:17",
		["37"] = "24:57",
		["40"] = "30:9",
		["41"] = "23:5",
		["45"] = "37:5",
		["46"] = "38:15",
		["48"] = "39:18",
		["49"] = "39:25",
		["50"] = "40:19",
		["51"] = "41:17",
		["52"] = "42:17",
		["54"] = "39:34",
		["57"] = "45:9",
		["58"] = "37:5",
		["65"] = "55:5",
		["66"] = "55:70",
		["67"] = "55:70",
		["69"] = "55:90",
		["70"] = "55:90",
		["72"] = "56:15",
		["73"] = "57:14",
		["74"] = "58:13",
		["77"] = "61:9",
		["78"] = "62:15",
		["79"] = "63:13",
		["80"] = "64:15",
		["82"] = "65:18",
		["83"] = "65:29",
		["84"] = "66:18",
		["85"] = "67:17",
		["89"] = "65:50",
		["92"] = "72:9",
		["93"] = "73:9",
		["94"] = "73:28",
		["95"] = "73:35",
		["96"] = "73:40",
		["97"] = "73:45",
		["98"] = "73:57",
		["99"] = "73:9",
		["100"] = "74:9",
		["101"] = "55:5",
	}
)
SLItem = SLItem or {}
do
	--- 查询单位背包内是否有目标物品
	--
	-- @server
	function SLItem.IsItemInUnitInventory(self, unit, item)
		do
			local i = 0
			while i < DOTA_ITEM_INVENTORY_SIZE do
				local _item = unit:GetItemInSlot(i)
				if _item and _item == item then
					return true
				end
				i = i + 1
			end
		end
		return false
	end
	--- 从单位背包中获取指定名字的item
	--
	-- @param item_name 物品名
	-- @returns 物品实例或undefined
	-- @server
	function SLItem.GetItemInUnitInventory(self, unit, item_name)
		do
			local i = 0
			while i < DOTA_ITEM_INVENTORY_SIZE do
				local _item = unit:GetItemInSlot(i)
				if _item and _item:GetAbilityName() == item_name then
					return _item
				end
				i = i + 1
			end
		end
		return nil
	end
	--- 获取单位的背包中的所有物品
	--
	-- @server
	function SLItem.GetAllItemsInUnitInventory(self, unit, item_name)
		local items = {}
		do
			local i = 0
			while i < 9 do
				local _item = unit:GetItemInSlot(i)
				if _item and _item:GetAbilityName() == item_name then
					items[#items + 1] = _item
				end
				i = i + 1
			end
		end
		return items
	end
	--- 将一个物品创建到地上
	--
	-- @param itemName
	-- @param position
	-- @param radius 随机范围
	-- @param radius_max 随机最大范围
	function SLItem.DropLootItem(self, itemName, position, radius, radius_max)
		if radius == nil then
			radius = 0
		end
		if radius_max == nil then
			radius_max = radius
		end
		local newItem = CreateItem(itemName, nil, nil)
		if not IsValid(newItem) then
			DebugPrint(_G, "not valid new item")
			return
		end
		newItem:SetPurchaseTime(0)
		local drop = CreateItemOnPositionSync(position, newItem)
		local random_pos = position:__add(RandomVector(RandomFloat(radius, radius_max)))
		local maxTryTimes = 10
		do
			local index = 0
			while index < maxTryTimes do
				if not GridNav:CanFindPath(position, random_pos) then
					random_pos = position:__add(RandomVector(RandomFloat(radius, radius_max)))
				else
					break
				end
				index = index + 1
			end
		end
		random_pos = GetGroundPosition(random_pos, nil)
		newItem:LaunchLoot(false, 200, 0.5, random_pos, nil)
		return newItem
	end
end