--[[
  ~ dumper · customs · dota2
  ~ credits: rou (a.k.a internetenemy), qfun(a.k.a qfun_g9s)
  ~ special for t.me/wildguild

  ~ build b9dc48c · 2026-08-02 17:42:46 UTC
  ~ auto-generated — do not edit
]]


--[[ Generated with https://github.com/TypeScriptToLua/TypeScriptToLua ]]
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